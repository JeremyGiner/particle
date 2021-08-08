package particle.controller.process;
import particle.controller.AController;
import particle.entity.Particle;
import particle.tool.Direction;
import space.Vector2i;
import sweet.functor.IProcedure;
import particle.entity.ParticleType;
import particle.tool.Direction.DirectionTool;

/**
 * ...
 * @author 
 */
class WallGeneratorBehavior extends AController implements IProcedure {

	public function process() {
		
		var a = _oModel.getParticleByType( ParticleType.wall_generator );
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
			if ( oTarget != null ) continue;
		
			_oModel.addParticle( new Particle( 
				oTargetPosition, 
				new Vector2i(), 
				ParticleType.wall
			) );
			_oModel.addParticleEnergy( oParticle, -1 );
			
		}
	}
}