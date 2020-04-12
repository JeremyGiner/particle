package particle.view;
import haxe.ds.IntMap;
import pixi.core.graphics.Graphics;
import pixi.core.textures.Texture;
import particle.model.Particle;
import pixi.core.display.Container;
import pixi.core.sprites.Sprite;

/**
 * ...
 * @author 
 */
class View {
	
	var _oStage :Container;
	
	var _mParticleView :IntMap<ParticleView>;
	
	var _lUpdateStack :List<Particle>;
	
	public function new( oStage :Container ) {
		_oStage = oStage;
		_mParticleView = new IntMap<ParticleView>();
		_lUpdateStack = new List<Particle>();
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
				
				var o = new Graphics();
				o.beginFill(0xFF0000, 0.4);
				o.drawRect(-5, -5, 10, 10);
				o.endFill();
				//oContainer.anchor.set(0.5);
				
				
				oView = new ParticleView( oParticle );
				_oStage.addChild( oView.getContainer() );
				_mParticleView.set( oParticle.getId(), oView );
			} else 
				oView = _mParticleView.get( oParticle.getId() );
				
			oView.update();
		}
	}
}