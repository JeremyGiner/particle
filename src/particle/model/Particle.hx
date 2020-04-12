package particle.model;
import pixi.core.display.Container;
import space.Vector2i;

/**
 * ...
 * @author 
 */
class Particle {

	var _iId :Int;
	
	var _oVelocity :Vector2i;
	var _oPosition :Vector2i;
	var _oView :Container;
//_____________________________________________________________________________
//    Constructor
	
	public function new( oPosition :Vector2i, oVelocity :Vector2i, iCharge :Int = 0 ) {
		_iId = null;
		_oVelocity = oVelocity;
		_oPosition = oPosition;
	}
	
//_____________________________________________________________________________
//    Accessor
	
	public function getId() {
		return _iId;
	}

	public function getVelocity() {
		
		return _oVelocity;
	}
	
	public function getPosition() {
		
		return _oPosition;
	}
	
//_____________________________________________________________________________
//    Modifier
	
	public function setId( iId :Int ) {
		_iId = iId;
	}
	
	public function setPosition( oPosition :Vector2i ) {
		_oPosition = oPosition;
		return this;
	}
	
	public function setVelocity( oVector :Vector2i ) {
		_oVelocity = oVector;
		return this;
	}
}