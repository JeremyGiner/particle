package particle.entity.atom;
import legion.entity.AEntity;
import particle.component.Energized;
import particle.component.Extract;
import particle.component.Stack;
import particle.entity.Atom;
import space.Vector2i;

/**
 * ...
 * @author 
 */
class Extractor extends Atom {

	public function new( 
		oPosition :Vector2i
	) {
		super( oPosition );
		//setComponent( new Energized() );
		setComponent( new Extract() );
	}
	
}