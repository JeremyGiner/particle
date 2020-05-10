package particle.controller.process;
import particle.model.Particle;
import space.Vector2i;
import particle.model.ParticleType;

/**
 * ...
 * @author 
 */
class FabricatorBehavior extends ATargeterBehavior {

	
	override public function targetProcess( oTarget :Particle, oDirectionVector :Vector2i ) {
		if ( oTarget == null )
			return false;
		_oModel.setParticleType( 
			oTarget, 
			getNextType( oTarget.getType() )
		);
		return true;
	}
	
	override public function getType() :ParticleType {
		return ParticleType.fabricator;
	}
	
	public function getNextType( oType :ParticleType ) {
		
		switch( oType ) {
			case ParticleType.wall: return ParticleType.redirect;
			case ParticleType.redirect: return ParticleType.multiplexer;
			case ParticleType.multiplexer: return ParticleType.pusher;
			case ParticleType.pusher: return ParticleType.wall_generator;
			case ParticleType.wall_generator: return ParticleType.fabricator;
			case ParticleType.fabricator: return ParticleType.wheel;
			default:
				return oType;
			
		}
		
		return oType;
	}
}