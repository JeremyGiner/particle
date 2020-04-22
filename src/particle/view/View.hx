package particle.view;
import haxe.ds.IntMap;
import js.Browser;
import particle.model.Model;
import pixi.core.math.Point;
import pixi.core.textures.Texture;
import particle.model.Particle;
import pixi.core.display.Container;
import pixi.interaction.InteractionEvent;
import pixi.interaction.InteractionManager;
import space.Vector2i;
import trigger.EventListener;

/**
 * ...
 * @author 
 */
class View {
	
	var _oModel :Model;
	
	var _oMenu :Menu;
	
	var _oStage :Container;
	var _mParticleView :IntMap<ParticleView>;
	
	var _oDragged :ParticleView = null;
	
	public var onParticleDragTo :EventListener<DragTo>;
	
//_____________________________________________________________________________
//	Constuctor
	
	public function new( oModel :Model, oStage :Container, oInteractionManager :InteractionManager  ) {
		_oModel = oModel;
		_oStage = oStage;
		_oStage.scale.x = 10;
		_oStage.scale.y = 10;
		_oMenu = new Menu( _oModel, Browser.document.getElementById('menu') );
		
		var oGridView = new GridView(200,100);
		_oStage.addChild(oGridView.getContainer());
		
		_mParticleView = new IntMap<ParticleView>();
		
		oInteractionManager.on('pointerup', function( event ){
			if ( _oDragged == null )
				return;
			var oVector = event.data.getLocalPosition(_oStage);
			
			onParticleDragTo.trigger({
				particle: _oDragged.getParticle(),
				position: new Vector2i(
					Math.floor(oVector.x),
					Math.floor(oVector.y)
				),
			});
			_oDragged = null;
		});
		
		
		
		onParticleDragTo = new EventListener<DragTo>();
		
		_oMenu.update();
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
		var oVector = _oStage.toLocal(new Point(x,y));
		return new Vector2i(
			Math.floor(oVector.x),
			Math.floor(oVector.y)
		);
	}
	
	public function getMenu() {
		return _oMenu;
	}
	
//_____________________________________________________________________________
//	Modifier
	
	
	public function setZoom( x, y, f :Float ) {
		_oStage.setTransform( x, y, f, f);
	}
	
	public function addParticle( oParticle :Particle ) {
		if ( _mParticleView.exists( oParticle.getId() ) )
			throw '!!!';
		
		_mParticleView.set( oParticle.getId(), _createParticleView(oParticle) );
	}
	
	public function updateParticle( oParticle :Particle ) {
		
		if ( !_mParticleView.exists( oParticle.getId() ) )
			throw '!!';
		
		_mParticleView.get( oParticle.getId() ).update();
		
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
		
		// Debug
		if ( _oModel.getCount() != Lambda.count(_mParticleView) )
			throw '!!';
	}
	

		
//_____________________________________________________________________________
//	Process

	public function update() {

	}
	
//_____________________________________________________________________________
//	Sub-routine

	
	function _createParticleView( oParticle :Particle ) {
		var oView = new ParticleView( oParticle );
		_oStage.addChild( oView.getContainer() );
		oView.getContainer().on('pointerdown', function() {
			_oDragged = oView;
			trace(_oDragged);
		});
		//oView.getContainer().on('pointermove', function() {
			////todo
		//});
		oView.update();
		
		return oView;
	}
}

typedef DragTo = {
	
	var particle :Particle;
	var position :Vector2i;
}