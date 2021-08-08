package particle.view;
import h2d.Object;
import haxe.ds.IntMap;
import haxe.ds.StringMap;
import particle.entity.Particle;
import particle.view.pixi.Animation;
import particle.view.pixi.Cadence;

import particle.model.Model;

import space.Vector2i;
import trigger.Subject;
import hxd.App;

/**
 * ...
 * @author 
 */
class View {
	
	var _oModel :Model;
	
	var _oStage :Object;
	
	var _oMenu :Menu;
	var _oHeaps :App;
	var _oSelectionView :SelectionView;
	
	var _mParticleView :IntMap<ParticleView>;
	
	var _oDragged :ParticleView = null;
	
	public var onParticleDragTo :Subject<DragTo>;
	
	var _mAnimation :IntMap<Array<AnimationInfo>>;
	var _mCadence :StringMap<Cadence>;
	
//_____________________________________________________________________________
//	Constuctor
	
	public function new( 
		oModel :Model
	) {
		
		_oHeaps = new HeapsApp();
		
		_oModel = oModel;
		
		_oMenu = new Menu( _oModel, 0, 'qsd', new Vector2i(), _oHeaps.s2d );
		
		_oSelectionView = new SelectionView();
		_oHeaps.s2d.add( _oSelectionView.getContainer(), 0 );
		_oStage = new Object();
		_oHeaps.s2d.add( _oStage, 0 );
		
		var oGridView = new GridView(200,100);
		_oHeaps.s2d.addChild(oGridView.getContainer());
		
		_mParticleView = new IntMap<ParticleView>();
		_mAnimation = new IntMap();
		_mCadence = [
			'loop' => new Cadence( 1000, Date.now().getTime(), true ),
			'move' => new Cadence( 1000, Date.now().getTime()  ),
		];
		
		onParticleDragTo = new Subject<DragTo>();
		
		//_oMenu.update();
		
		//_oPixi.start();
	}
	
//_____________________________________________________________________________
//	Accessor
	/*
	public function getZoom() : Float {
		return _oStage.scale.x;
	}
	*/
	public function getScene() {
		return _oHeaps.s2d;
	}
	/*
	public function toGridPosition( x :Int, y :Int ) {
		
		var rx = Browser.window.innerWidth / _oPixi.screen.width;
		var ry = Browser.window.innerHeight / _oPixi.screen.height;
		
		return new Vector2i(
			Math.floor( ( rx *x - _oStage.x) / _oStage.scale.x ),
			Math.floor((ry*y - _oStage.y) / _oStage.scale.y)
		);
	}
	*/
	
	public function getMenu() {
		return _oMenu;
	}
	
	public function getSelectionView() {
		return _oSelectionView;
	}
	
//_____________________________________________________________________________
//	Modifier
	
	/*
	public function setZoom( x, y, f :Float ) {
		_oStage.setTransform( x, y, f, f);
	}
	*/
	public function addParticle( oParticle :Particle ) {
		if ( _mParticleView.exists( oParticle.getId() ) )
			throw '!!!';
		
		var oParticleView = _createParticleView(oParticle);
		_mParticleView.set( oParticle.getId(), oParticleView );
		_updateParticleView( oParticleView );
	}
	
	public function updateParticle( oParticle :Particle ) {
		
		if ( !_mParticleView.exists( oParticle.getId() ) )
			throw '!!';
		
		var oParticleView = _mParticleView.get( oParticle.getId() );
		_updateParticleView( oParticleView );
		
	}
	
	public function removeParticle( oParticle :Particle ) {
		
		// Debug
		if ( _oModel.getCount()+1 != Lambda.count(_mParticleView) )
			throw '!!';
		
		if ( !_mParticleView.exists( oParticle.getId() ) ) {
			trace('WARING trying to remove #' + oParticle.getId());
			return;
		}
		trace('removing #' + oParticle.getId());
		_oStage.removeChild(
			_mParticleView.get( oParticle.getId() ).getContainer()
		);
		_mParticleView.remove( oParticle.getId() );
		_mAnimation.remove( oParticle.getId() );
		
		// Debug
		if ( _oModel.getCount() != Lambda.count(_mParticleView) )
			throw '!!';
	}
	
	public function updateSelection() {
		//_oMenu.update();
	}
		
//_____________________________________________________________________________
//	Process


	public function update() {

	}
	
//_____________________________________________________________________________
//	Sub-routine

	function _updateParticleView( oParticleView :ParticleView ) {
		oParticleView.update();
		_mAnimation.set( 
			oParticleView.getParticle().getId(), 
			oParticleView.getAnimationAr() 
		);
	}

	
	function _createParticleView( oParticle :Particle ) {
		var oView = new ParticleView( oParticle );
		_oStage.addChild( oView.getContainer() );
		
		return oView;
	}
}

typedef DragTo = {
	
	var particle :Particle;
	var position :Vector2i;
}

