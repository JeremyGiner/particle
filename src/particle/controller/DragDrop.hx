package particle.controller;
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

	var _oDragged :ParticleView;
	
	
	public function new( oModel :Model, oView :View ) {
		super(oModel, oView);
		
		//_oView.onParticleMove.attach( this );
		oView.onParticleDragTo.add(function( o :DragTo ) {
			move(o.particle, o.position );
		});

	}
	
	public function move( oParticle :Particle, oVector :Vector2i ) {
		if ( _oModel.getParticleByPosition(oVector) != null )
			return;
		_oModel.setParticlePosition( oParticle, oVector );
		_oView.updateParticle( oParticle );
	}
}