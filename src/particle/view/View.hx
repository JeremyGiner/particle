package particle.view;
import haxe.ds.IntMap;
import js.html.Event;
import particle.model.Model;
import pixi.core.graphics.Graphics;
import pixi.core.math.Point;
import pixi.core.textures.Texture;
import particle.model.Particle;
import pixi.core.display.Container;
import pixi.core.sprites.Sprite;
import pixi.interaction.InteractionEvent;
import pixi.interaction.InteractionManager;
import space.Vector2i;
import trigger.EventListener;

/**
 * ...
 * @author 
 */
class View {
	
	var _oStage :Container;
	var _mParticleView :IntMap<ParticleView>;
	var _lUpdateStack :List<Particle>;
	
	var _oDragged :ParticleView = null;
	
	public var onParticleDragTo :EventListener<DragTo>;
	
	public function new( oModel :Model, oStage :Container, oInteractionManager :InteractionManager  ) {
		
		oModel.onCreate.add( this.updateParticle  );
		oModel.onUpdate.add( function( oEvent :ParticleUpdateEvent ) {
			
			this.updateParticle(oEvent.particle);
		});
		oModel.onDelete.add( this.updateParticle );
		_oStage = oStage;
		_oStage.scale.x = 10;
		_oStage.scale.y = 10;
		
		
		var oGridView = new GridView(200,100);
		_oStage.addChild(oGridView.getContainer());
		
		_mParticleView = new IntMap<ParticleView>();
		_lUpdateStack = new List<Particle>();
		
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
	}
	
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
	
	
	public function setZoom( x, y, f :Float ) {
		_oStage.setTransform( x, y, f, f);
	}
	
	public function updateParticle( oParticle :Particle ) {
		_lUpdateStack.push( oParticle );
		
	}
	
	public function removeParticle( oParticle :Particle ) {
		
		if ( !_mParticleView.exists( oParticle.getId() ) )
			return;
		_oStage.removeChild(
			_mParticleView.get( oParticle.getId() ).getContainer()
		);
		_mParticleView.remove( oParticle.getId() );
	}
	
	public function update() {
		var oParticle :Particle = null;
		while ( ( oParticle = _lUpdateStack.pop()) != null ) {
			
			var oView :ParticleView;
			if ( !_mParticleView.exists( oParticle.getId() ) ) {
				_mParticleView.set( oParticle.getId(), createParticleView(oParticle) );
			}
			
			oView = _mParticleView.get( oParticle.getId() );
			oView.update();
		}
	}
	
	public function createParticleView( oParticle :Particle ) {
		var oView = new ParticleView( oParticle );
		_oStage.addChild( oView.getContainer() );
		oView.getContainer().on('pointerdown', function() {
			_oDragged = oView;
			trace(_oDragged);
		});
		//oView.getContainer().on('pointermove', function() {
			////todo
		//});
		
		return oView;
	}
}

typedef DragTo = {
	
	var particle :Particle;
	var position :Vector2i;
}