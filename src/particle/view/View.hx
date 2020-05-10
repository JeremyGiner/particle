package particle.view;
import haxe.ds.IntMap;
import haxe.ds.StringMap;
import js.Browser;
import js.html.CanvasElement;
import particle.model.Model;
import pixi.core.Application;
import pixi.core.math.Point;
import pixi.core.textures.Texture;
import particle.model.Particle;
import pixi.core.display.Container;
import pixi.interaction.InteractionEvent;
import pixi.interaction.InteractionManager;
import space.Vector2i;
import trigger.EventListener;
import particle.view.pixi.Animation;
import particle.view.pixi.Cadence;

/**
 * ...
 * @author 
 */
class View {
	
	var _oModel :Model;
	
	var _oPixi :Application;
	var _oMenu :Menu;
	var _oSelectionView :SelectionView;
	
	var _oStage :Container;
	var _mParticleView :IntMap<ParticleView>;
	
	var _mAnimation :IntMap<Array<AnimationInfo>>;
	var _mCadence :StringMap<Cadence>;
	
	var _oDragged :ParticleView = null;
	
	public var onParticleDragTo :EventListener<DragTo>;
	
//_____________________________________________________________________________
//	Constuctor
	
	public function new( 
		oModel :Model
	) {
		
		var oCanvas :CanvasElement = cast Browser.document.getElementById('canva-game');
		_oPixi = new Application({
			width: oCanvas.clientWidth,
			height: oCanvas.clientHeight,
			view: oCanvas,
		});
		Browser.window.addEventListener('resize', function() {
			_oPixi.renderer.resize(oCanvas.clientWidth,oCanvas.clientHeight);
		});
		_oPixi.ticker.add(this.animate);
		
		//_oPixi = oPixi;
		_oModel = oModel;
		_oStage = _oPixi.stage;
		_oStage.scale.x = 10;
		_oStage.scale.y = 10;
		_oMenu = new Menu( _oModel, Browser.document.getElementById('menu') );
		_oSelectionView = new SelectionView();
		_oStage.addChild( _oSelectionView.getContainer() );
		
		var oGridView = new GridView(200,100);
		_oStage.addChild(oGridView.getContainer());
		
		_mParticleView = new IntMap<ParticleView>();
		_mAnimation = new IntMap();
		_mCadence = [
			'loop' => new Cadence( 1000, Date.now().getTime(), true ),
			'move' => new Cadence( 1000, Date.now().getTime()  ),
		];
		
		onParticleDragTo = new EventListener<DragTo>();
		
		_oMenu.update();
		
		_oPixi.start();
	}
//_____________________________________________________________________________
//	Accessor
	
	public function getZoom() {
		return _oStage.scale.x;
	}
	
	public function getScene() {
		return _oStage;
	}
	
	public function toGridPosition( x :Int, y :Int ) {
		
		var rx = Browser.window.innerWidth / _oPixi.screen.width;
		var ry = Browser.window.innerHeight / _oPixi.screen.height;
		
		return new Vector2i(
			Math.floor( ( rx *x - _oStage.x) / _oStage.scale.x ),
			Math.floor((ry*y - _oStage.y) / _oStage.scale.y)
		);
	}
	
	public function getCanvas() {
		return _oPixi.view;
	}
	
	public function getMenu() {
		return _oMenu;
	}
	
	public function getSelectionView() {
		return _oSelectionView;
	}
	
//_____________________________________________________________________________
//	Modifier
	
	
	public function setZoom( x, y, f :Float ) {
		_oStage.setTransform( x, y, f, f);
	}
	
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
		_oMenu.update();
	}
		
//_____________________________________________________________________________
//	Process

	public function animate() {
		for ( aAnimation in _mAnimation ) 
		for ( oAnimationInfo in aAnimation ) {
			var oCadence = _mCadence.get(oAnimationInfo.cadence);// TODO : check for null
			oAnimationInfo.animation.animate( oCadence.getFrame() );
		}
	}

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


typedef AnimationInfo = {
	var animation :Animation;
	var cadence :String;
};