package particle.entity.atom;
import particle.component.ManualCrane;
import particle.entity.Atom;
import space.Vector2i;

/**
 * ...
 * @author 
 */
class MasterCrane extends Atom {

	public function new( 
		oPosition :Vector2i
	) {
		super( oPosition );
		setComponent( new ManualCrane() );
	}
	
	
}