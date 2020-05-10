package particle.view;
import particle.model.Direction;
import particle.model.Particle;
import pixi.core.display.Container;
import pixi.core.graphics.Graphics;
import particle.model.ParticleType;
import particle.view.pixi.Animation;
import particle.view.View.AnimationInfo;

/**
 * ...
 * @author 
 */
class ParticleView {

	var _oParticle :Particle;
	var _oContainer :Container;
	var _oVelocity :Graphics;
	var _oBody :Graphics;
	
	var _aAnimation :Array<AnimationInfo>;
	
	static var BORDER_WIDTH = 0.2;
	
	static var TYPE_COLOR = [
		ParticleType.generator => 0xFFFFFF,
		ParticleType.energy_echo => 0x00ffff,
		ParticleType.pusher => 0xFFFF00,
		ParticleType.redirect => 0x00FFFF,
		ParticleType.multiplexer => 0x00FFFF,
		ParticleType.wall_generator => 0x000000,
		ParticleType.fabricator => 0xeeeeee,
	];
	
	
//_____________________________________________________________________________
//	Constructor
	
	
	public function new( oParticle :Particle ) {
		_oParticle = oParticle;
		
		_oContainer = new Container();
		_oContainer.interactive = true;
		_oContainer.interactiveChildren = true;
		
		_aAnimation = [];
		
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
	
//_____________________________________________________________________________
//	Accessor
	
	public function getContainer() {
		return _oContainer;
	}
	
	public function getParticle() {
		return _oParticle;
	}
	
	public function getAnimationAr() {
		return _aAnimation;
	}
	
	public function getTypeColor( oType :ParticleType ) {
		
		return TYPE_COLOR.exists(oType) ? TYPE_COLOR.get(oType) : 0x666666;
	}
	
	
//_____________________________________________________________________________
//	Updater
	
	public function updateBody() {
		
		// Reset
		_aAnimation = [];
		_oBody.clear();
		_oBody.removeChildren();
		_oBody.buttonMode = true;
		_oBody.interactive = true;
		
		// Default box
		_oBody.beginFill(getTypeColor( _oParticle.getType()), 1);
		if ( _oParticle.getType() == ParticleType.energy_echo ) {
			_oBody.drawCircle(0, 0, 0.25);
		} else {
			_oBody.lineStyle(BORDER_WIDTH,_oParticle.getEnergy() == 1 ? 0xFFFFFF : 0x555555,1);
			drawSquare( _oBody, 1 - BORDER_WIDTH);
		}
		_oBody.endFill();
		
		// Mutiplexer "dead arrow"
		if ( _oParticle.getType() == ParticleType.multiplexer ) {
			_oBody
				.lineStyle( 0.1, 0x666666, 1 )
				.moveTo( 0, 0.25 )
				.lineTo( -0.5, 0 )
				.lineTo( 0, -0.25 )
			;
		}
		
		// Mutiplexer V "dead arrow"
		if ( _oParticle.getType() == ParticleType.multiplexer_V ) {
			_oBody
				.lineStyle( 0.1, 0x666666, 1 )
				.moveTo( 0.25, 0 )
				.lineTo( 0, -0.5 )
				.lineTo( -0.25, 0 )
			;
		}
		
		
		// Wheel 
		if ( _oParticle.getType() == ParticleType.wheel ) {
			
			
			var o = new Graphics();
			o.beginFill(0xFF0000, 1);
			o.drawStar(0, 0, 8, 0.5, 0.4);
			
			var oWheelContainer = new Container();
			oWheelContainer.addChild(o);
			//oWheelContainer.setTransform(1, 1);
			
			
			
			
			
			
			_oBody.addChild(oWheelContainer);
			oWheelContainer.updateTransform();
			
			var oMatrix = oWheelContainer.localTransform.clone();
			
			//oWheelContainer.rotation = Math.PI / 2;
			oWheelContainer.updateTransform();
			var oMatrixB = oWheelContainer.localTransform.clone();
			
			
			if( _oParticle.getDirection() == Direction.DOWN || _oParticle.getDirection() == Direction.UP )
				//oMatrix.rotate(Math.PI / 2);
				oMatrix.rotate(Math.PI / 2);
			else
				//oMatrix.rotate( -Math.PI / 2);
				oMatrix.rotate( -Math.PI / 2);
			
			
			_aAnimation.push( {
				animation: new Animation(oWheelContainer, oMatrix, oMatrixB), 
				cadence: 'loop',
			} );
			
		}
		
		// Directional arrow
		if ( [
			ParticleType.pusher, 
			ParticleType.fabricator,
			ParticleType.wall_generator,
			ParticleType.redirect,
			ParticleType.multiplexer,
			ParticleType.multiplexer_V,
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
	
	public function drawSquare( o :Graphics, fSize :Float ) {
		
		o.drawRect( 
			-fSize / 2, 
			-fSize / 2, 
			fSize, 
			fSize
		);
	}
	
}
