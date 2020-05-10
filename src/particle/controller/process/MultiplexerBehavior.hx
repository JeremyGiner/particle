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
		
		for ( oParticle in _oModel.getParticleByType( ParticleType.multiplexer ) ) 
			_process( oParticle );
		
		for ( oParticle in _oModel.getParticleByType( ParticleType.multiplexer_V ) ) 
			_process( oParticle );
	}
	
	public function _process( oParticle :Particle ) {
		
		if ( oParticle.getEnergy() == 0 )// TODO: use indexer
			return;
		
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
		var oNextDirection = oParticle.getType() == ParticleType.multiplexer ?
			DirectionTool.getReverse( oParticle.getDirection() ) :
			DirectionTool.getRotateClockwise( oParticle.getDirection() )
		;
		oParticle.setDirection( oNextDirection );
	}
	
}