package particle.controller.process;
import sweet.functor.IProcedure;
import particle.model.Model;
import particle.model.Particle;
import particle.view.View;
import space.Vector2i;
import particle.model.Direction;
import sweet.functor.IProcedure;
import haxe.IntTool;

/**
 * ...
 * @author 
 */
class SpaceRelativity implements IProcedure {

	// index by velocity direction
	var _oModel :Model;
	var _oView :View;

	public function new( oModel :Model, oView :View ) {
		_oModel = oModel;
		_oView = oView;
	}
	
	public function process() {
		
		// Pair each particle
		var aPair = new Array<Array<Particle>>();
		for ( oParticleA in _oModel.getParticleAll() )
		for ( oParticleB in _oModel.getParticleAll() ) {
			
			if ( oParticleA.getId() >= oParticleB.getId() ) continue;
			
			aPair.push( [
				oParticleA,
				oParticleB,
			] );
		}
		
		// Process each pair
		for ( oPair in aPair ) {
			
			// Get distance / cab distance
			var oDelta = new Vector2i( 
				oPair[0].getPosition().x - oPair[1].getPosition().x, 
				oPair[0].getPosition().y - oPair[1].getPosition().y
			);
			var iDist = oDelta.getTaxicabLength();
		
			if ( iDist == 0 )
				throw '!!';
			
			// Process gravity
			oDelta.mult( 
				0.5
				//* ( aPair[0].getMass() * aPair[1].getMass() ) 
				/ (iDist/2)
			);
			
			_oModel.setParticleVelocity( 
				oPair[1], 
				maxSpeed(oDelta.clone().vector_add(oPair[1].getVelocity()))
			);
			_oModel.setParticleVelocity( 
				oPair[0], 
				maxSpeed(oDelta.clone().mult(-1).vector_add(oPair[0].getVelocity())) 
			);
		}
		
	}
	
	public function maxSpeed( oVector :Vector2i ) {
		oVector.x = clampBetween( oVector.x, -10, 10 );// TODO : use vector callback 
		oVector.y = clampBetween( oVector.y, -10, 10 );// TODO : use Move max speed
		return oVector;
	}
	
	public function clampBetween(i :Int, min :Int, max :Int ) {
		if (i < min) return min;
		if(i > max) return max;
		return i;
	}
}