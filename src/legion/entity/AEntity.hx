package legion.entity;
import haxe.ds.StringMap;
import legion.component.IComponent;

/**
 * ...
 * @author 
 */
class AEntity implements IEntity {

	var _iId :Null<Int>;
	var _mComponent :StringMap<IComponent>;
	
	public function new() {
		_mComponent = new StringMap<IComponent>();
		
	}
	
	public function getId() :Null<Int> { return _iId; }
	public function setId( i :Int ) { _iId = i; }
	
	
	public function hasComponent<C>( oClass :Class<C>) :Bool {
		var s = Type.getClassName( oClass );
		return _mComponent.exists( s );
	}
	public function getComponent<C>( oClass :Class<C>) :Dynamic {
		var s = Type.getClassName( oClass );
		
		if ( !_mComponent.exists( s ) ) return null;
		var o = _mComponent.get( s );
		return untyped o;
	}
	public function setComponent( o :IComponent ) {
		var s = Type.getClassName( Type.getClass(o) );
		
		var oPrev = _mComponent.get( s );
		_mComponent.set( s, o );
		return oPrev;
	}
	
	public function getComponentAr() :Array<IComponent> {
		return Lambda.array( _mComponent );
	}
	
	public function removeComponent<C>( oClass :Class<C>) :Dynamic {
		var s = Type.getClassName( oClass );
		
		if ( !_mComponent.exists( s ) ) return null;
		return _mComponent.remove( s );
	}
	
}