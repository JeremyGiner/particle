package particle.controller.process;
import particle.controller.AController;
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
class GeneratorSpawnBehavior extends AController implements IProcedure {

	public function process() {
		
		var a = _oModel.getParticleByType( ParticleType.generator );
		for ( oParticle in a )
		for ( oDirection in DirectionTool.getAll() ) {
			var oVectorDirection = DirectionTool.getVector( oDirection );
			var oSpawnPosition = oParticle.getPosition().clone().vector_add( oVectorDirection );
		
			// Case : spawn blocked
			if ( _oModel.getParticleByPosition( oSpawnPosition ) != null )
				continue;
			
			//Timer.measure(function() {
				 _oModel.addParticle( createParticle(
					oParticle,
					oSpawnPosition,
					oDirection
				 
				) );
			//});
		}
		//TODO: energize adjacent block 
	}
	
	public function createParticle( 
		oParent :Particle,
		oPosition :Vector2i, 
		oDirection :Direction 
	) {
		var oParticle = new Particle( 
			oPosition, 
			DirectionTool.getVector( oDirection ),
			ParticleType.energy_echo
		);
		return oParticle;
	}
	
}