package particle.view;
import particle.model.Particle;
import pixi.core.display.Container;
import pixi.core.graphics.Graphics;

/**
 * ...
 * @author 
 */
class ParticleView {

	var _oParticle :Particle;
	var _oContainer :Graphics;
	var _oVelocity :Graphics;
	
	static var SCALE = 10;
	
	
	public function new( oParticle :Particle ) {
		_oParticle = oParticle;
		
		// draw body
		_oContainer = new Graphics();
		_oContainer.beginFill(0xFF0000, 0.4);
		_oContainer.drawRect(SCALE/2, SCALE/2, SCALE, SCALE);
		_oContainer.endFill();
			
		
		// draw velocity
		_oVelocity = new Graphics();
		_oVelocity.lineStyle(2, 0xFFFFFF);
		_oVelocity.beginFill(0x35CC5A, 1);
		_oVelocity.moveTo(0, 0);
		_oVelocity.lineTo( 
			_oParticle.getVelocity().x * SCALE, 
			_oParticle.getVelocity().y * SCALE 
		);
		_oVelocity.endFill();
		_oContainer.addChild(_oVelocity);
			
	}
	
	public function getContainer() {
		return _oContainer;
	}
	
	public function update() {
		_oVelocity.clear();
		_oVelocity.lineStyle(2, 0xFF00FF);
		_oVelocity.beginFill(0x35CC5A, 1);
		_oVelocity.moveTo(0, 0);
		_oVelocity.lineTo( 
			_oParticle.getVelocity().x * SCALE, 
			_oParticle.getVelocity().y * SCALE 
		);
		_oVelocity.endFill();
		
		_oContainer.position.set( 
			_oParticle.getPosition().x * SCALE,
			_oParticle.getPosition().y * SCALE
		);
	}
	
}