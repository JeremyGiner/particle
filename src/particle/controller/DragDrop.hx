package particle.controller;
import js.html.MouseEvent;
import particle.controller.process.Move;
import particle.model.Model;
import particle.model.Particle;
import particle.view.ParticleView;
import particle.view.View;
import space.Vector2i;

/**
 * ...
 * @author 
 */
class DragDrop extends AController  {

	var _oMove :Move;
	var _oDragged :ParticleView;
	
	
	public function new( oModel :Model, oView :View, oMove :Move ) {
		_oMove = oMove;
		
		super(oModel, oView);
		
		oModel.onDelete.add(function( oParticle :Particle ) {
			if ( _oDragged!= null && _oDragged.getParticle() ==  oParticle )
				_oDragged = null;
		});
		var oCanvas = _oView.getCanvas();
		oCanvas.addEventListener('click', function( oEvent :MouseEvent ) {
			
			// Case: left click -> clear selection
			if ( oEvent.button == 2 ) {
				_oModel.setSelection( null );
				return;
			}
			
			var oPosition = _oView.toGridPosition( oEvent.pageX, oEvent.pageY);
			var oTargetParticle = _oModel.getParticleByPosition( oPosition );
			
			// Case: move particle
			if ( _oModel.getSelection() != null && oTargetParticle == null ) {
				_oModel.setParticlePosition( _oModel.getSelection(), oPosition );
				return;
			}
			
			_oModel.setSelection( oTargetParticle );
		});
		oCanvas.addEventListener('mousemove', function( oEvent :MouseEvent ) {
			
			var oPosition = _oView.toGridPosition( oEvent.clientX, oEvent.clientY);
			_oView.getMenu().setPosition( oPosition );
			_oView.getMenu().update();
		});
		
		_oModel.onSelectionChange.add(function( oParticle :Particle ) {
			_oView.updateSelection();
		});
	}
}