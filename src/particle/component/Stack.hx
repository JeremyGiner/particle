package particle.component;
import legion.component.IComponent;

/**
 * ...
 * @author 
 */
class Stack implements IComponent {
	
	var _i :Int;

	public function new( i :Int ) {
		_i = i;
	}
	
	public function count() {
		return _i;
	}
	
}