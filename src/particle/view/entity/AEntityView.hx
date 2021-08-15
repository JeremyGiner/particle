package particle.view.entity;
import h2d.Object;
import legion.component.IComponent;
import legion.entity.IEntity;
import particle.component.DirectionCompo;
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
			_updatePosition( oPos );
		var oDir = _oOwner.getComponent(DirectionCompo);
		if ( oDir != null )
			rotation = oDir.getRadian();
	}
	
	private function _updatePosition( oPos :Position ) {
		setPosition( oPos.x +0.5, oPos.y +0.5 );
	}
	
	public function update( f :Float ) {
		
	}
	
	public function onComponentAttach( o :IComponent ) {
		if ( ! Std.is(o, Position) ) return;
		var oPos :Position = cast o; 
		_updatePosition( oPos );
	}
	
	public function onComponentUpdate( o :IComponent ) {
		if ( Std.is(o, Position) ) {
			var oPos :Position = cast o; 
			_updatePosition( oPos );
			return;
		}
		
		if ( Std.is(o, DirectionCompo) ) {
			var oCompo :DirectionCompo = cast o;
			rotation = oCompo.getRadian();
			return;
		}
	}
	
	public function onComponentRemove(o :IComponent ) {
		if ( Std.is(o, Position) )
			return _updatePosition( cast o );
	}
	/*
	public function onEntityRemove() {
		remove();
	}
	*/
	
}