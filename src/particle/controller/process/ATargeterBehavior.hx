package particle.controller.process;
import particle.controller.Controller;
import particle.model.Particle;
import space.Vector2i;
import sweet.functor.IProcedure;
import particle.model.ParticleType;
import particle.model.Direction.DirectionTool;

/**
 * ...
 * @author 
 */
class ATargeterBehavior extends Controller implements IProcedure {

	public function process() {
		
		var a = _oModel.getParticleByType( getType() );
		for ( oParticle in a ) {
			
			if ( oParticle.getEnergy() == 0 )// TODO: use indexer
				continue;
			
			var oDirectionVector = DirectionTool.getVector( oParticle.getDirection() );
			var oPushPosition = oParticle.getPosition()
				.clone().vector_add( 
					oDirectionVector
				)
			;
			var oTarget = _oModel.getParticleByPosition( oPushPosition );
			targetProcess( oTarget, oDirectionVector );
			
			_oModel.addParticleEnergy( oParticle, -1 );
		}
		//TODO: energize adjacent block 
	}
	
	public function getType() :ParticleType {
		throw 'override me';
		return null;
		
	}
	
	public function targetProcess( oTarget :Particle, oDirectionVector :Vector2i  ) {
		throw 'override me';
	}
	
}