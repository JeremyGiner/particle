package trigger;

/**
 * ...
 * @author 
 */
class EventListener<CEvent> {
	
	var _aFn :List<CEvent->Void>;

	public function new() {
		_aFn = new List();
	}
	
	public function add( fn :CEvent->Void) {
		_aFn.push( fn );
	}
	
	public function remove( fn :CEvent->Void) {
		_aFn.remove( fn );
	}
	
	public function trigger( oEvent :CEvent ) {
		for ( fn in _aFn )
			fn( oEvent );
	}
}