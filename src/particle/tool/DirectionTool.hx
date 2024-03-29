package particle.tool;
import space.Vector2i;

/**
 * ...
 * @author 
 */

class DirectionTool {
	
	static var all = [Direction.RIGHT, Direction.UP, Direction.LEFT, Direction.DOWN];
	static var vector = [
		Direction.RIGHT => new Vector2i(1,0), 
		Direction.UP => new Vector2i(0,1),  
		Direction.LEFT => new Vector2i(-1,0), 
		Direction.DOWN => new Vector2i(0,-1), 
	];
	
	static public function getAll() {
		return all;
	}
	static public function getByVelocity( oVector :Vector2i ) {
		var a = new Array<Direction>();
		if ( oVector.x > 0 )
			a.push( Direction.RIGHT );
		if ( oVector.x < 0 )
			a.push( Direction.LEFT );
		if ( oVector.y > 0 )
			a.push( Direction.UP );
		if ( oVector.y < 0 )
			a.push( Direction.DOWN );
		return a;
	}
	static public function getReverse( oDirection :Direction ) {
		
		switch( oDirection ) {
			case UP: return Direction.DOWN;
			case DOWN: return Direction.UP;
			case RIGHT: return Direction.LEFT;
			case LEFT: return Direction.RIGHT;
			
		}
	}
	
	static public function toRadian( oDirection :Direction ) :Float {
		
		switch( oDirection ) {
			//case UP: return 1.5708;
			case UP: return 0.0;
			case DOWN: return -1.5708;
			case RIGHT: return 0;
			case LEFT: return 3.14159;
			
		}
	}
	/*
	public function getDirectionRadian( oDirection :Direction ) {
		
		switch( oDirection ) {
			case UP: return Math.PI/2;
			case DOWN: return -Math.PI/2;
			case RIGHT: return 0;
			case LEFT: return Math.PI;
		}
	}
	*/
	
	static public function getVector( oDirection :Direction ) {
		return vector.get(oDirection);
		
	}
	
	static public function getRotateCounterClockwise( oDirection :Direction ) {
		switch( oDirection ) {
			case UP: return Direction.LEFT;
			case RIGHT: return Direction.UP;
			case DOWN: return Direction.RIGHT;
			case LEFT: return Direction.DOWN;
		}
	}
	
	static public function getRotateClockwise( oDirection :Direction ) {
		switch( oDirection ) {
			case UP: return Direction.RIGHT;
			case RIGHT: return Direction.DOWN;
			case DOWN: return Direction.LEFT;
			case LEFT: return Direction.UP;
		}
	}
}
