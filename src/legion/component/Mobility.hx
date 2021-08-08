package legion.component;
import legion.entity.IEntity;
import space.Vector2f;

/**
 * ...
 * @author 
 */
class Mobility implements IComponent {

	var _bPlayerControl :Bool;
	
	var _oGoal :Vector2f;
	var _oFollow :IEntity;
	
	public function new() {
		_oGoal = null;
		_oFollow = null;
	}
	
	public function getGoal() {
		if ( _oFollow != null ) 
			return _oFollow.getComponent(Position);
		return _oGoal; 
		
	}
	
	public function setGoal( o :Vector2f ) { 
		_oGoal = o;
		_oFollow = null;
	}
	public function setFollow( o :IEntity ) { 
		_oGoal = null;
		_oFollow = o;
	}
	
	
	public function isPlayerControl() {
		return _bPlayerControl;
	}
	public function setPlayerControl( b :Bool ) {
		_bPlayerControl = b;
	}
}