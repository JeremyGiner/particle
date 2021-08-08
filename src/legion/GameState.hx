package legion;
import haxe.ds.IntMap;
import legion.component.IComponent;
import sweet.functor.IProcedure;
import legion.entity.IEntity;
import trigger.Subject;
import trigger.IObserver;
import legion.ds.PairEntityComponent;


/**
 * ...
 * @author 
 */
class GameState {
	var _aProcess :Array<IProcedure>;
	var _mEntity :IntMap<IEntity>;
	
	var _iIdGen :Int = 0;
	
	public var onEntityAdd :Subject<IEntity>;
	public var onEntityRemove :Subject<IEntity>;
	public var onComponentAttach :Subject<PairEntityComponent>;
	public var onComponentUpdate :Subject<PairEntityComponent>;
	public var onComponentRemove :Subject<PairEntityComponent>;
	
	public function new() {
		_mEntity = new IntMap();
		_aProcess = [];
		onEntityAdd = new Subject<IEntity>();
		onEntityRemove = new Subject<IEntity>();
		onComponentAttach = new Subject<PairEntityComponent>();
		onComponentUpdate = new Subject<PairEntityComponent>();
		onComponentRemove = new Subject<PairEntityComponent>();
	}
	
	public function getEntityAll() {
		return _mEntity;
	}
	
//_____________________________________________________________________________
// Modifier

	public function createId() {
		return _iIdGen++;
	}
	
	public function addEntity( o :IEntity ) {
		o.setId( createId() );
		_mEntity.set( o.getId(), o );
		
		// Events
		onEntityAdd.notify( o );
		for ( oCompo in o.getComponentAr() )
			onComponentAttach.notify( {entity: o, component: oCompo });
			
	}
	
	public function removeEntity( o :IEntity ) {
		
		if ( ! _mEntity.remove( o.getId() ) ) return;
		
		// Events 
		for ( oCompo in o.getComponentAr() )
			onComponentRemove.notify({ entity: o, component: oCompo });
		onEntityRemove.notify( o );
	}
	
	public function setComponent( oEntity :IEntity, oComponent :IComponent ) {
		var oPrev = oEntity.setComponent( oComponent );
		if ( oPrev != null ) {
			onComponentRemove.notify( {entity: oEntity, component: oPrev });
		}
		onComponentAttach.notify( {entity: oEntity, component: oComponent });
	}
	
	public function removeComponent<C>( oEntity :IEntity, oClass :Class<C>) :Dynamic {
		if ( !oEntity.hasComponent( oClass ) ) return null;
		var o = oEntity.getComponent( oClass );
		oEntity.removeComponent( oClass );
		onComponentRemove.notify( {entity: oEntity, component: o });
		return o;
	}
	
//_____________________________________________________________________________
// Process

	public function update(dt:Float) {
		for ( oProcess in _aProcess )
			oProcess.process();
	}
	
//_____________________________________________________________________________
// Notification

}