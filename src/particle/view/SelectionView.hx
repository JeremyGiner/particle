package particle.view;
import h2d.Graphics;
import h2d.Object;
import particle.tool.Direction;
import particle.entity.Particle;
import particle.entity.ParticleType;
import particle.view.pixi.Animation;
import particle.view.View.AnimationInfo;
import space.Vector2i;

/**
 * ...
 * @author 
 */
class SelectionView extends Object {

	var _oPosition :Vector2i;
	
//_____________________________________________________________________________
//	Constructor
	
	
	public function new() {
		
		_oPosition = null;
		super();
	}
	
//_____________________________________________________________________________
//	Accessor
	
	public function getContainer() :Object {
		return this;
	}
	
//_____________________________________________________________________________
//	Modifier
	/*
	public function setPosition( oVector :Vector2i ) {
		_oPosition = oVector;
		update();
	}
	*/
	
//_____________________________________________________________________________
//	Updater
	

	public function update() {
		/*
		_oContainer.clear();
		
		if ( _oPosition == null ) 
			return;
		
		_oContainer.lineStyle( 0.1, 0xFF0000, 1 );
		drawSquare( _oContainer, 1.5 );
		_oContainer.position.set( 
			_oPosition.x + 0.5,
			_oPosition.y + 0.5
		);*/
	}
	
	public function drawSquare( o :Graphics, fSize :Float ) {
		/*
		o.drawRect( 
			-fSize / 2, 
			-fSize / 2, 
			fSize, 
			fSize
		);*/
	}
	
}
