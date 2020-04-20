package particle.controller;
import particle.model.Model.ParticleUpdateEvent;
import particle.model.Particle;

/**
 * ...
 * @author 
 */
class Presenter extends Controller {

	override public function init() {
		_oModel.onCreate.add(function( oParticle :Particle ) {
			_oView.addParticle( oParticle );
		});
		
		_oModel.onDelete.add(function( oParticle :Particle ){
			_oView.removeParticle( oParticle );
		});
		
		_oModel.onUpdate.add(function( oEvent :ParticleUpdateEvent  ){
			_oView.updateParticle( oEvent.particle );
		});
	}
	
}