package particle.controller.process;
import particle.tool.Direction;
import particle.entity.Particle;
import space.Vector2i;
import particle.entity.ParticleType;
import sweet.functor.IProcedure;
import particle.tool.Direction.DirectionTool;

/**
 * ...
 * @author 
 */
class WheelBehavior extends AController implements IProcedure {

	public function process() {
		
		var a = _oModel.getParticleByType( ParticleType.wheel );
		for ( oParticle in a ) 
		for ( oDirection in DirectionTool.getAll() ) {
			
			var oDirectionVector = DirectionTool.getVector(oDirection );
			var oTargetPosition = oParticle.getPosition()
				.clone().vector_add( 
					oDirectionVector
				)
			;
			var oTarget = _oModel.getParticleByPosition( oTargetPosition );
			
			if ( oTarget == null )
				continue;
			
			var oPushDirection = DirectionTool.getVector( getPushDirection(oParticle,oDirection) );
			
			_oModel.setParticleVelocity( 
				oTarget, 
				oPushDirection
			);
		}
	}
	
	public function getPushDirection( oWheel :Particle, oTargetDirection :Direction ) {
		if ( oWheel.getDirection() == Direction.DOWN || oWheel.getDirection() == Direction.UP )
			return DirectionTool.getRotateClockwise( oTargetDirection );
		return DirectionTool.getRotateCounterClockwise( oTargetDirection );
	}
}