package particle.view;
import h2d.Graphics;
import h2d.Object;
import h3d.mat.Texture;
import particle.component.Position;
import particle.tool.Direction;
import particle.entity.Atom;
import particle.entity.AtomType;
import particle.view.pixi.Animation;
import particle.view.AnimationInfo;

/**
 * ...
 * @author 
 */
class AtomView extends Object {

	var _oContainer :Object;
	var _oAtom :Atom;
	var _oVelocity :Graphics;
	var _oBody :Graphics;
	
	var _aAnimation :Array<AnimationInfo>;
	
	static var BORDER_WIDTH = 0.2;
	
	static var TYPE_COLOR = [
		AtomType.generator => 0xFFFFFF,
		AtomType.energy_echo => 0x00ffff,
		AtomType.pusher => 0xFFFF00,
		AtomType.redirect => 0x00FFFF,
		AtomType.multiplexer => 0x00FFFF,
		AtomType.wall_generator => 0x000000,
		AtomType.fabricator => 0xeeeeee,
	];
	
	
//_____________________________________________________________________________
//	Constructor
	
	
	public function new( oAtom :Atom ) {
		super();
		
		_oAtom = oAtom;
		
		_aAnimation = [];
		
		//_oContainer.addChild( DebugTool.createAnchor() );
		
		// draw body
		_oBody = new Graphics();
		updateBody();
		
		addChild( _oBody );
		
		// draw velocity
		/*
		_oVelocity = new Graphics();
		_oVelocity.lineStyle(2, 0xFFFFFF,1);
		_oVelocity.beginFill(0x35CC5A, 1);
		_oVelocity.moveTo(0, 0);
		_oVelocity.lineTo( 
			_oAtom.getVelocity().x, 
			_oAtom.getVelocity().y  
		);
		_oVelocity.endFill();
		_oContainer.addChild(_oVelocity);
		*/
		
	}
	
//_____________________________________________________________________________
//	Accessor

	
	public function getAtom() {
		return _oAtom;
	}
	
	public function getAnimationAr() {
		return _aAnimation;
	}
	
	public function getTypeColor( oType :Atom ) {
		return 0x666666;
	}
	
	
//_____________________________________________________________________________
//	Updater
	
	public function updateBody() {
		// Reset
		_aAnimation = [];
		_oBody.clear();
		_oBody.removeChildren();
		//_oBody.buttonMode = true;
		//_oBody.interactive = true;
		
		
		// Default box
		_oBody.beginFill(getTypeColor( _oAtom ), 1);
		/*
		if ( _oparticle.getType() == AtomType.energy_echo ) {
			_oBody.drawCircle(0, 0, 0.25);
		} else {*/
			//_oBody.lineStyle(BORDER_WIDTH,_oparticle.getEnergy() == 1 ? 0xFFFFFF : 0x555555,1);
			_oBody.drawRect( 0,0,1,1);
		/*}*/
		_oBody.endFill();
		
		// Mutiplexer "dead arrow"
		/*
		if ( _oparticle.getType() == AtomType.multiplexer ) {
			_oBody.lineStyle( 0.1, 0x666666, 1 );
			_oBody.moveTo( 0, 0.25 );// Move to
			_oBody.lineTo( -0.5, 0 );
			_oBody.lineTo( 0, -0.25 );
		}
		
		// Mutiplexer V "dead arrow"
		if ( _oparticle.getType() == AtomType.multiplexer_V ) {
			_oBody.lineStyle( 0.1, 0x666666, 1 );
			_oBody.moveTo( 0.25, 0 );
			_oBody.lineTo( 0, -0.5 );
			_oBody.lineTo( -0.25, 0 );
		}
		
		
		// Wheel 
		if ( _oparticle.getType() == AtomType.wheel ) {
			
			
			var o = new Graphics();
			o.beginFill(0xFF0000, 1);
			o.drawCircle( 0, 0, 0.5, 8);
			
			var oWheelContainer = new Object();
			oWheelContainer.addChild(o);
			//oWheelContainer.setTransform(1, 1);
			
			_oBody.addChild(oWheelContainer);
			//oWheelContainer.updateTransform();
			
			var oMatrix = oWheelContainer.getAbsPos().clone();
			
			//oWheelContainer.rotation = Math.PI / 2;
			//oWheelContainer.updateTransform();
			
			
			if ( 
				_oparticle.getDirection() == Direction.DOWN 
				|| _oparticle.getDirection() == Direction.UP 
			)
				//oMatrix.rotate(Math.PI / 2);
				oMatrix.rotate(Math.PI / 2);
			else
				//oMatrix.rotate( -Math.PI / 2);
				oMatrix.rotate( -Math.PI / 2);
			
			
			_aAnimation.push( {
				animation: new Animation(oWheelContainer, oMatrix, oWheelContainer.getAbsPos() ), 
				cadence: 'loop',
			} );
			
		}
		
		// Directional arrow
		if ( [
			AtomType.pusher, 
			AtomType.fabricator,
			AtomType.wall_generator,
			AtomType.redirect,
			AtomType.multiplexer,
			AtomType.multiplexer_V,
		].indexOf( _oparticle.getType() ) != -1  ) {
			_oContainer.rotation = getDirectionRadian( _oparticle.getDirection() );
			_oBody.lineStyle( 0.1, 0xFF0000, 1 );
			_oBody.moveTo( 0, 0.25 );
			_oBody.lineTo( 0.5, 0 );
			_oBody.lineTo( 0, -0.25 );
		}*/
	}

	public function update() {
		_oVelocity.clear();
		//_oVelocity.lineStyle(2, 0xFF00FF);
		//_oVelocity.beginFill(0x35CC5A, 1);
		//_oVelocity.moveTo(0, 0);
		//_oVelocity.lineTo( 
			//_oparticle.getVelocity().x * SCALE, 
			//_oparticle.getVelocity().y * SCALE 
		//);
		//_oVelocity.endFill();
		
		updateBody();
		
		var oPos = _oAtom.getComponent(Position);
		
		_oContainer.setPosition( 
			oPos.x + 0.5,
			oPos.y + 0.5
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