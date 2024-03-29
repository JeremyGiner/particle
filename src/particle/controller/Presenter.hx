package particle.controller;
import particle.model.Model;
import particle.model.Model.ParticleUpdateEvent;
import particle.entity.Particle;

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
		
		// Model to particle view
		_oModel.onCreate.add(function( oParticle :Particle ) {
			_oView.addParticle( oParticle );
		});
		
		_oModel.onDelete.add(function( oParticle :Particle ){
			_oView.removeParticle( oParticle );
			_updateSelectionView();
		});
		_oModel.onUpdate.add(function( oEvent :ParticleUpdateEvent  ){
			_oView.updateParticle( oEvent.particle );
			_updateSelectionView();
		});
		
		// Model to menu
		/*
		_oModel.onSpeedChange.add(function( oModel :Model ) {
			_oView.getMenu().update();
		});*/
		
		// Model to selection view
		_oModel.onSelectionChange.add( function( oParticle :Particle ) {
			_updateSelectionView();
		});
		
		// Menu input
		/*
		_oView.getMenu().getContainer()
			.addEventListener('click', function( oEvent :MouseEvent ) {
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
				
		});*/
		
		
	}
	
	function _updateSelectionView() {
		/*
		var oPos = _oModel.getSelection() == null ? 
			null : 
			_oModel.getSelection().getPosition();
		_oView.getSelectionView().setPosition( oPos );*/
	}
	
}