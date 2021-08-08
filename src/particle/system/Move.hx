package particle.system;
import legion.GameState;
import sweet.functor.IProcedure;
import trigger.Subject;

/**
 * ...
 * @author 
 */
class Move implements IProcedure {

	var _oGameState :GameState;
	
	public function new( oGameState :GameState ) {
		_oGameState = oGameState;
	}
	
	public function process() {
		
		// TODO : get only related entity
		for ( oEntity in _oGameState.getEntityAll() ) {
			
			// Get component
			
			var oPosition :Position = cast oEntity.getComponent(Position);
			if ( oPosition == null ) continue;
			
			
			// Case : player controlled
			if (  oMobility.isPlayerControl() )
				return handlePlayerMove( oMobility, oPosition, oStats );
			
		
			// Process mobility
			if ( oMobility.getGoal() == null ) continue;
			
			var o = new Vector2f();
			o.copy( oMobility.getGoal() ).vector_sub( oPosition );
			
			o.length_set( oStats.getSpeed() );
			oPosition.vector_add( o );
			
			_oGameState.onComponentUpdate.notify({ entity: o, component: oPosition });
		}
		
	}
	
	public function handlePlayerMove(  
		oMobility :CompMobility, 
		oPosition :Position,
		oStats :Stats
	) {
		var o = new Vector2f();
		if (Key.isDown( Key.Z )) {
			o.y = 1;
		}
		if (Key.isDown( Key.S )) {
			o.y = -1;
		}
		if (Key.isDown( Key.Q )) {
			o.x = 1;
		}
		if (Key.isDown( Key.D )) {
			o.x = -1;
		}
		trace( o.x );
		trace( o.y );
		if ( o.x == 0 && o.y == 0 )
			return;
		o.length_set( oStats.getSpeed() );
		oPosition.vector_add( o );
	}
	
	
}