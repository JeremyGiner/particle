package legion.system;
import space.Vector2f;
import sweet.functor.IProcedure;
import legion.component.Stats;
import particle.component.Position;
import legion.component.Mobility as CompMobility;
import hxd.Key;

/**
 * ...
 * @author 
 */
class Mobility implements IProcedure {

	var _oMain :Main;
	
	public function new( oMain :Main ) {
		_oMain = oMain;
	}
	
	public function process() {
		
		// TODO : get only related entity
		for ( oEntity in _oMain.getEntityAll() ) {
			
			// Get component
			var oStats :Stats = cast oEntity.getComponent(Stats);
			if ( oStats == null ) continue;
			
			var oPosition :Position = cast oEntity.getComponent(Position);
			if ( oPosition == null ) continue;
			
			var oMobility :CompMobility = cast oEntity.getComponent(CompMobility);
			if ( oMobility == null ) continue;
			
			
			//DEBUG
			if ( oEntity.getId() == 10
			)
				oMobility.setPlayerControl( true );
			
			// Case : player controlled
			if (  oMobility.isPlayerControl() )
				return handlePlayerMove( oMobility, oPosition, oStats );
			
		
			// Process mobility
			if ( oMobility.getGoal() == null ) continue;
			
			var o = new Vector2f();
			o.copy( oMobility.getGoal() ).vector_sub( oPosition );
			
			o.length_set( oStats.getSpeed() );
			oPosition.vector_add( o );
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