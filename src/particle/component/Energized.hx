package particle.component;
import legion.component.IComponent;

/**
 * ...
 * @author 
 */
class Energized implements IComponent {

	var _i :Int;
	
	public function new( i :Int = 0) {
		_i = i;
	}
	
	public function get() {
		return _i;
	}
	
	public function set( i :Int ) {
		_i = i;
		return this;
	}
	
}