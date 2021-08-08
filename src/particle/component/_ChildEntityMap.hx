package particle.component;

import haxe.ds.StringMap;
import legion.entity.IEntity;
import legion.component.IComponent;

/**
 * ...
 * @author 
 */
class ChildEntityMap implements IComponent {

	var _mQueue :StringMap<IEntity>;
	var _mEntity :StringMap<IEntity>;
	
	public function new( m :StringMap<IEntity>  ) {
		_mQueue = m.copy();
		_mEntity = new StringMap();
	}
	
	public function popQueue() {
		var o = _mQueue.keyValueIterator();
		if ( !o.hasNext() ) return null;
		var item = o.next();
		_mEntity.set( item.key, item.value );
		_mQueue.remove( item.key );
		return item.value;
	}
	public function getEntityMap() { return _mEntity; }
	
	public function addEntity( sKey :String , o :IEntity ) {
		_mQueue.set( sKey, o );
	}
}