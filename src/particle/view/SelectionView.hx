package particle.view;
import particle.model.Direction;
import particle.model.Particle;
import pixi.core.display.Container;
import pixi.core.graphics.Graphics;
import particle.model.ParticleType;
import particle.view.pixi.Animation;
import particle.view.View.AnimationInfo;
import space.Vector2i;

/**
 * ...
 * @author 
 */
class SelectionView {

	var _oPosition :Vector2i;
	var _oContainer :Graphics;
	
//_____________________________________________________________________________
//	Constructor
	
	
	public function new() {
		
		_oContainer = new Graphics();
		_oPosition = null;
		
	}
	
//_____________________________________________________________________________
//	Accessor
	
	public function getContainer() :Container {
		return _oContainer;
	}
	
//_____________________________________________________________________________
//	Modifier
	
	public function setPosition( oVector :Vector2i ) {
		_oPosition = oVector;
		update();
	}
	
	
//_____________________________________________________________________________
//	Updater
	

	public function update() {
		_oContainer.clear();
		
		if ( _oPosition == null ) 
			return;
		
		_oContainer.lineStyle( 0.1, 0xFF0000, 1 );
		drawSquare( _oContainer, 1.5 );
		_oContainer.position.set( 
			_oPosition.x + 0.5,
			_oPosition.y + 0.5
		);
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
