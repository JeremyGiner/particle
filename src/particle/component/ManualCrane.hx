package particle.component;
import legion.component.IComponent;
import particle.entity.Atom;

/**
 * ...
 * @author 
 */
class ManualCrane implements IComponent {
	
	var _iDistance :Int;
	var _oContent :Atom;
	
	public function new() {
		_iDistance = 50;
		_oContent = null;
	}
	
	public function getContent() {
		return _oContent;
	}
	
	public function grab( o :Atom ) {
		if ( _oContent != null ) throw '!!!';
		_oContent = o;
	}
	
	public function realease() {
		_oContent = null;
	}
	
}