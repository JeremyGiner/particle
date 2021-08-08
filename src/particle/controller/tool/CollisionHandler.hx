package particle.controller.tool;
import particle.model.Model;
import particle.entity.Particle;
import particle.entity.ParticleType;


/**
 * ...
 * @author 
 */
class CollisionHandler {
	
	
	var _oModel :Model;
	var _bReverse :Bool = false;
	
	public function new( oModel :Model ) {
		_oModel = oModel;
	}
	
	public function handle( oParticleA :Particle, oParticleB :Particle ) {
		
		// energy dissipate
		if ( oParticleA.getType() == ParticleType.energy_echo ) {
			_oModel.removeParticle( oParticleA );
			_oModel.addParticleEnergy( oParticleB );
		}
	
		
		// Case : reverse not attempted -> try reverse
		if ( _bReverse == false ) {
			_bReverse = true;
			handle( oParticleB, oParticleA );
			_bReverse = false;
		}
	}
}