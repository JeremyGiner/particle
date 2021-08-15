package particle.component;
import legion.component.IComponent;
import particle.tool.Direction;
import particle.tool.DirectionTool;

/**
 * ...
 * @author 
 */
class DirectionCompo implements IComponent {
	var _oDirection :Direction;
	public function new( oDirection :Direction = Direction.UP ) {
		_oDirection = oDirection;
	}
	public function getDirection() {
		return _oDirection;
	}
	
	public function getVector() {
		return DirectionTool.getVector( _oDirection );
	}
	public function getReverseVector() {
		return DirectionTool.getVector( 
			DirectionTool.getReverse( _oDirection ) 
		);
	}
	
	public function rotateClockwise() {
		_oDirection = DirectionTool.getRotateClockwise( _oDirection );
		return this;
	}
	
	public function getRadian() {
		return DirectionTool.toRadian( _oDirection );
	}
	
}