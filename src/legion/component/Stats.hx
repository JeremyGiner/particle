package legion.component;
import haxe.ds.StringMap;

/**
 * ...
 * @author 
 */
class Stats implements IComponent {
	
	var _mBaseStat :StringMap<Int>;

	public static var BALANCED = [
		'speed' => 2,
		'pass' => 100,
		'shot' => 100,
		'block' => 100,
		'catch' => 100,
		'att' => 100,
		'endurance' => 100,
	];
	
	public function new( mBaseStat :StringMap<Int> ) {
		_mBaseStat = mBaseStat;
	}
	
	public function getBaseStat() {
		return _mBaseStat;
	}
	
	public function getSpeed() {
		return _mBaseStat.get('speed');
	}
}