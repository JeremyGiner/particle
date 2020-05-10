package particle.model;
import haxe.IntTool;
import pixi.core.display.Container;
import space.Vector2i;

/**
 * ...
 * @author 
 */
class Particle implements IParticle {

	var _iId :Int;
	
	var _iType :ParticleType;
	var _iEnergy :Int;
	
	var _oVelocity :Vector2i;
	var _oPosition :Vector2i;
	var _oView :Container;
	var _oDirection :Direction;
	
//_____________________________________________________________________________
//    Constructor
	
	public function new( 
		oPosition :Vector2i, 
		oVelocity :Vector2i, 
		iType :ParticleType = ParticleType.wall,
		iCharge :Int = 0,
		oDirection :Direction = Direction.UP
	) {
		_iId = null;
		_iType = iType;
		_oVelocity = oVelocity;
		_oPosition = oPosition;
		_iEnergy = 0;
		_oDirection = oDirection;
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
	
	public function getType() {
		return _iType;
	}
	
	public function getEnergy() {
		return _iEnergy;
	}
	
	public function getDirection() {
		return _oDirection;
	}
	
	public function isAbsorbable( oParticle :Particle ) {
		if ( oParticle.getType() == ParticleType.energy_echo )
			return true;
		return false;
	}
	
	
//_____________________________________________________________________________
//    Modifier
	
	public function setId( iId :Int ) {
		_iId = iId;
	}
	
	public function setPosition( oPosition :Vector2i ) {
		_oPosition = oPosition;
	}
	
	public function setVelocity( oVector :Vector2i ) {
		_oVelocity = oVector;
	}
	
	public function setType( iType :ParticleType ) {
		_iType = iType;
	}
	
	public function addEnergy( i :Int ) {
		_iEnergy += i;
		_iEnergy = IntTool.max(_iEnergy, 0);
		_iEnergy = IntTool.min(_iEnergy, 
			getType() == ParticleType.storage ? 9 : 1
		);
	}
	
	public function setDirection( oDirection :Direction ) {
		_oDirection = oDirection;
	}
}