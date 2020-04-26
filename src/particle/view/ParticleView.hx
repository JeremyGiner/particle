package particle.view;
import particle.model.Direction;
import particle.model.Particle;
import pixi.core.display.Container;
import pixi.core.graphics.Graphics;
import particle.model.ParticleType;

/**
 * ...
 * @author 
 */
class ParticleView {

	var _oParticle :Particle;
	var _oContainer :Container;
	var _oVelocity :Graphics;
	var _oBody :Graphics;
	
	static var TYPE_COLOR = [
		ParticleType.generator => 0xFFFFFF,
		ParticleType.energy_echo => 0x00ffff,
		ParticleType.pusher => 0xFFFF00,
		ParticleType.redirect => 0x00FFFF,
		ParticleType.multiplexer => 0x00FFFF,
		ParticleType.wall_generator => 0x000000,
		ParticleType.fabricator => 0xeeeeee,
	];
	
	
	public function new( oParticle :Particle ) {
		_oParticle = oParticle;
		
		_oContainer = new Container();
		_oContainer.interactive = true;
		_oContainer.interactiveChildren = true;
		
		//_oContainer.addChild( DebugTool.createAnchor() );
		
		// draw body
		_oBody = new Graphics();
		updateBody();
		_oContainer.addChild( _oBody );
		
		// draw velocity
		_oVelocity = new Graphics();
		_oVelocity.lineStyle(2, 0xFFFFFF,1);
		_oVelocity.beginFill(0x35CC5A, 1);
		_oVelocity.moveTo(0, 0);
		_oVelocity.lineTo( 
			_oParticle.getVelocity().x, 
			_oParticle.getVelocity().y  
		);
		_oVelocity.endFill();
		_oContainer.addChild(_oVelocity);
		
	}
	
	public function getContainer() {
		return _oContainer;
	}
	
	public function getParticle() {
		return _oParticle;
	}
	

	
	public function getTypeColor( oType :ParticleType ) {
		
		return TYPE_COLOR.exists(oType) ? TYPE_COLOR.get(oType) : 0x666666;
	}
	
//_____________________________________________________________________________
//	Updater
	
	public function updateBody() {
		_oBody.clear();
		_oBody.buttonMode = true;
		_oBody.interactive = true;
		
		_oBody.beginFill(getTypeColor( _oParticle.getType()), 1);
		if ( _oParticle.getType() == ParticleType.energy_echo ) {
			_oBody.drawCircle(0, 0, 0.25);
		} else {
			_oBody.lineStyle(0.2,_oParticle.getEnergy() == 1 ? 0xFFFFFF : 0x555555,1);
			_oBody.drawRect( -(1 - 0.2) / 2, -(1 - 0.2) / 2, 1 - 0.2, 1 - 0.2);
		}
		_oBody.endFill();
		
		
		if ( _oParticle.getType() == ParticleType.multiplexer ) {
			_oBody
				.lineStyle( 0.1, 0x666666, 1 )
				.moveTo( 0, 0.25 )
				.lineTo( -0.5, 0 )
				.lineTo( 0, -0.25 )
			;
			
		}
		
		if ( [
			ParticleType.pusher, 
			ParticleType.fabricator,
			ParticleType.wall_generator,
			ParticleType.redirect,
			ParticleType.multiplexer,
		].indexOf( _oParticle.getType() ) != -1  ) {
			_oContainer.rotation = getDirectionRadian( _oParticle.getDirection() );
			_oBody
				.lineStyle( 0.1, 0xFF0000, 1 )
				.moveTo( 0, 0.25 )
				.lineTo( 0.5, 0 )
				.lineTo( 0, -0.25 )
			;
		}
		

			
	}

	public function update() {
		_oVelocity.clear();
		//_oVelocity.lineStyle(2, 0xFF00FF);
		//_oVelocity.beginFill(0x35CC5A, 1);
		//_oVelocity.moveTo(0, 0);
		//_oVelocity.lineTo( 
			//_oParticle.getVelocity().x * SCALE, 
			//_oParticle.getVelocity().y * SCALE 
		//);
		//_oVelocity.endFill();
		
		updateBody();
		
		_oContainer.position.set( 
			_oParticle.getPosition().x + 0.5,
			_oParticle.getPosition().y + 0.5
		);
	}
	
	public function getDirectionRadian( oDirection :Direction ) {
		
		switch( oDirection ) {
			case UP: return Math.PI/2;
			case DOWN: return -Math.PI/2;
			case RIGHT: return 0;
			case LEFT: return Math.PI;
			
		}
	}
	
}