package particle.entity.atom;
import particle.component.TransportChain;
import particle.entity.Atom;
import particle.tool.Direction;
import space.Vector2i;

/**
 * ...
 * @author 
 */
class Belt extends Atom {

	public function new( 
		oPosition :Vector2i,
		oDirection :Direction
	) {
		super( oPosition, oDirection );
		setComponent( new TransportChain( this ) );
	}
	
	
}