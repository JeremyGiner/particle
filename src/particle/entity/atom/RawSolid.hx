package particle.entity.atom;
import legion.entity.AEntity;
import particle.component.MatterHolder;
import particle.component.Stack;
import particle.entity.Atom;
import particle.tool.Matter;
import space.Vector2i;

/**
 * ...
 * @author 
 */
class RawSolid extends Atom {

	public function new( 
		oPosition :Vector2i,
		aStack :Array<Matter>
	) {
		super( oPosition );
		setComponent( new MatterHolder( -1, aStack, true ) );
	}
	
}