package particle.controller.process;
import particle.controller.AController;
import particle.model.Particle;
import sweet.functor.IProcedure;
import particle.model.ParticleType;
import particle.model.Direction.DirectionTool;

/**
 * ...
 * @author 
 */
class MultiplexerBehavior extends AController implements IProcedure {

	public function process() {
		
		var a = _oModel.getParticleByType( ParticleType.multiplexer );
		for ( oParticle in a ) {
			
			if ( oParticle.getEnergy() == 0 )// TODO: use indexer
				continue;
			
			var oDirectionVector = DirectionTool.getVector( oParticle.getDirection() );
			var oTargetPosition = oParticle.getPosition()
				.clone().vector_add( 
					oDirectionVector
				)
			;
			
			var oTarget = _oModel.getParticleByPosition( oTargetPosition );
			if ( oTarget != null ) {
				_oModel.addParticleEnergy( oTarget );
			} else {
				// Create particle
				_oModel.addParticle( new Particle( 
					oTargetPosition, 
					oDirectionVector, 
					ParticleType.energy_echo
				) );
			}
			
			// Discharge
			_oModel.addParticleEnergy( oParticle, -1 );
			
			// Change orientation
			oParticle.setDirection( DirectionTool.getReverse( oParticle.getDirection() ) );
		}
	}
	
}