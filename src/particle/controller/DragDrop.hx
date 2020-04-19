package particle.controller;
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
class DragDrop extends Controller  {

	var _oMove :Move;
	var _oDragged :ParticleView;
	
	
	public function new( oModel :Model, oView :View, oMove :Move ) {
		_oMove = oMove;
		
		super(oModel, oView);
		
		//_oView.onParticleMove.attach( this );
		oView.onParticleDragTo.add(function( o :DragTo ) {
			_oMove.addUserMove(o.particle, o.position);
		});
		oModel.onDelete.add(function( oParticle :Particle ) {
			if ( _oDragged!= null && _oDragged.getParticle() ==  oParticle )
				_oDragged = null;
		});
	}
}