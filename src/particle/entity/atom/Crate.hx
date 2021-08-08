package particle.entity.atom;
import particle.component.MatterHolder;
import particle.entity.Atom;
import space.Vector2i;

/**
 * ...
 * @author 
 */
class Crate extends Atom {

	public function new( 
		oPosition :Vector2i
	) {
		super( oPosition );
		setComponent( new MatterHolder( 20 ) );
	}
	
	
}