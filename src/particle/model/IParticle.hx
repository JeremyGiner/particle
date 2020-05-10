package particle.model;
import space.Vector2i;

/**
 * ...
 * @author 
 */
interface IParticle {
	
	public function getId() :Int;

	public function getVelocity() :Vector2i;
	
	public function getPosition() :Vector2i;
	
	public function getType() :ParticleType;
	
	public function getEnergy() :Int;
	
	public function getDirection() :Direction;
	
//_____________________________________________________________________________
//    Modifier
	
	public function setId( iId :Int ) :Void;
	
	public function setPosition( oPosition :Vector2i ) :Void;
	
	public function setVelocity( oVector :Vector2i ) :Void;
	
	public function setType( iType :ParticleType ) :Void;
	
	public function addEnergy( i :Int ) :Void;
	
	public function setDirection( oDirection :Direction ) :Void;
}