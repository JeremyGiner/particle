package particle.component;
import legion.component.IComponent;
import particle.tool.Matter;

/**
 * ...
 * @author 
 */
class MatterHolder implements IComponent {
	
	var _aContent :Array<Matter>;
	var _iSize :Int;
	
	var _bRaw :Bool;

	public function new( iSize :Int, aContent :Array<Matter> = null, bRaw = false ) {
		_aContent = aContent == null ? [] : aContent;
		_iSize = iSize;
		_bRaw = bRaw;
	}
	
	public function stack( o :Matter ) {
		_aContent.push(o);
	}
	
	public function unstack() {
		return _aContent.pop();
	}
	public function getCount() {
		return _aContent.length;
	}
	
	public function isRaw() {
		return _bRaw;
	}
	
}