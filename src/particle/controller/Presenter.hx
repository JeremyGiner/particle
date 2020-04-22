package particle.controller;
import particle.model.Model;
import particle.model.Model.ParticleUpdateEvent;
import particle.model.Particle;
import js.html.MouseEvent;
import js.html.Element;

/**
 * ...
 * @author 
 */
class Presenter extends AController {

	var _oController :Controller;
	
	public function new( oController :Controller ) {
		_oController = oController;
		super( 
			_oController.getModel(), 
			_oController.getView()
		);
	}
	
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
		
		_oModel.onSpeedChange.add(function( oModel :Model ) {
			_oView.getMenu().update();
		});
		
		_oView.getMenu().getContainer().addEventListener('click', function( oEvent :MouseEvent ) {
			if ( !Std.is( oEvent.originalTarget, Element ) )
				return;
			
			var oTarget :Element = cast oEvent.originalTarget;
			
			switch ( oTarget.dataset.action ) {
				case 'toggle_play':
					_oModel.setSpeed(
						_oModel.getSpeed() == 0 ? 1 : 0
					);
					if( _oModel.getSpeed() != 0 )
						_oController.processGameStep();
				case 'step':
					_oController.processGameStep();
			}
				
		});
	}
	
}