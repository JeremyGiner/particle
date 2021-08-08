package particle.entity;
import h2d.Object;
import particle.component.Position;
import legion.entity.AEntity;
import particle.component.Renderable;
import particle.tool.Direction;
import space.Vector2i;

/**
 * ...
 * @author 
 */
class Atom extends AEntity {
	
	
	
//_____________________________________________________________________________
//    Constructor
	
	public function new( 
		oPosition :Vector2i,
		oDirection :Direction = Direction.UP
	) {
		super();
		
		setComponent( new Position(oPosition.x,oPosition.y,oDirection) );
		
		//setComponent( new Stats() );
		setComponent( new Renderable( this ) );
	}
	
//_____________________________________________________________________________
//    Accessor
	public function getPosition() :Position {
		return getComponent(Position);
	}
	
	
	/*
	public function isAbsorbable( oParticle :Atom ) {
		if ( oParticle.getType() == ParticleType.energy_echo )
			return true;
		return false;
	}
	
	*/
//_____________________________________________________________________________
//    Modifier
	/*
	public function addEnergy( i :Int ) {
		_iEnergy += i;
		_iEnergy = IntTool.max(_iEnergy, 0);
		_iEnergy = IntTool.min(_iEnergy, 
			getType() == ParticleType.storage ? 9 : 1
		);
	}*/

}