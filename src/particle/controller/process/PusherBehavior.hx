package particle.controller.process;
import particle.controller.Controller;
import particle.model.Direction;
import particle.model.Particle;
import space.Vector2i;
import sweet.functor.IProcedure;
import particle.model.ParticleType;
import particle.model.Direction.DirectionTool;
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