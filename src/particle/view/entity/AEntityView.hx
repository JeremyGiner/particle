package particle.view.entity;
import h2d.Object;
import legion.component.IComponent;
import legion.entity.IEntity;
import particle.component.Position;

/**
 * ...
 * @author 
 */
class AEntityView extends Object {
	
	var _oOwner :IEntity;

	public function new( o :IEntity ) {
		super();
		_oOwner = o;
		
		var oPos = _oOwner.getComponent(Position);
		if ( oPos != null )
			setPosition( oPos.x, oPos.y );
	}
	
	public function update( f :Float ) {
		
	}
	
	public function onComponentAttach( o :IComponent ) {
		if ( ! Std.is(o, Position) ) return;
		var oPos :Position = cast o; 
		setPosition( oPos.x, oPos.y );
	}
	
	public function onComponentUpdate( o :IComponent ) {
		if ( ! Std.is(o, Position) ) return;
		var oPos :Position = cast o; 
		setPosition( oPos.x, oPos.y );
	}
	
	public function onComponentRemove(o :IComponent ) {
		if ( Std.is(o, Position) )
			return setPosition( 0, 0 );
	}
	/*
	public function onEntityRemove() {
		remove();
	}
	*/
	
}