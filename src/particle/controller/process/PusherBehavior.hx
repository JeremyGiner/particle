package particle.controller.process;
import particle.controller.AController;
import particle.tool.Direction;
import particle.entity.Particle;
import space.Vector2i;
import sweet.functor.IProcedure;
import particle.entity.ParticleType;
import particle.tool.Direction.DirectionTool;
import haxe.Timer;

/**
 * ...
 * @author 
 */
class PusherBehavior extends ATargeterBehavior {

	
	override public function targetProcess( oTarget :Particle, oDirectionVector :Vector2i ) {
		if ( oTarget == null )
			return false;
		
		_oModel.setParticleVelocity( 
			oTarget, 
			oTarget.getVelocity().vector_add( oDirectionVector )
		);
		return true;
	}
	
	override public function getType() :ParticleType {
		return ParticleType.pusher;
	}
}