package particle.controller.process;
import particle.model.Model;
import particle.entity.Particle;
import particle.view.View;
import space.Vector2i;
import sweet.functor.IProcedure;
import haxe.IntTool;
import particle.tool.Direction;
import particle.entity.ParticleType;

/**
 * ...
 * @author 
 */
class MapBound implements IProcedure {

	var _oModel :Model;
	var _oView :View;
	
	public function new( oModel :Model, oView :View ) {
		_oModel = oModel;
		_oView = oView;
	}
	
	
	public function process() {
		var x_min = 0, xmax;
		for ( oParticle in _oModel.getParticleAll() ) {
			if ( 
				!isBetween( oParticle.getPosition().x, 0, _oModel.getGrid().getWidth() )
				|| !isBetween( oParticle.getPosition().y, 0, _oModel.getGrid().getHeight() )
			) {
				_oModel.removeParticle( oParticle );
			}
		}
	}
	
	public function isBetween( x :Int, min :Int, max :Int ) {
		return x >= min && x <= max;
	}
}