package particle.component;
import legion.component.IComponent;
import particle.tool.Direction;
import space.Vector2i;

/**
 * ...
 * @author 
 */
class Position extends Vector2i implements IComponent {
	var _oDirection :Direction;
	public function new( x :Int = 0, y :Int = 0, oDirection :Direction = Direction.UP ) {
		super(x, y);
	}
	public function getDirection() {
		return _oDirection;
	}
}