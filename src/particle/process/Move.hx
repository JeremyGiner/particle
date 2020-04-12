package particle.process;
import haxe.ds.BalancedTree;
import haxe.ds.IntMap;
import haxe.ds.RedBlackTree;
import particle.model.Model;
import particle.model.Particle;
import particle.view.View;
import space.Vector2i;
import particle.model.Direction;
import sweet.functor.IProcedure;
import haxe.ds.ArraySort;


/**
 * ...
 * @author 
 */
class Move implements IProcedure {
	
	// index by velocity direction
	var _oModel :Model;
	var _oView :View;
	
	var _iMaxSpeed :Int;
	var _iCurrentSpeed :Int;

	public function new( oModel :Model, oView :View ) {
		_oModel = oModel;
		_oView = oView;
		
		_iMaxSpeed = 10;
		_iCurrentSpeed = 1;
	}

	
	public function process() {
		
		
		// Get all 
		for ( oDirection in DirectionTool.getAll() ) { 
		
		
			var a = Lambda.array(_oModel.getParticleListByVelDir(oDirection));
			ArraySort.sort( a, sortingFunc(oDirection) );
			//for ( oParticle  in a ) {
				//_oModel.removeParticleoParticle move( oDirection, oParticle );
			//}
			for ( oParticle  in a ) {
				move( oDirection, oParticle );
			}
		}
		_iCurrentSpeed++;
		if ( _iCurrentSpeed > _iMaxSpeed ) _iCurrentSpeed = 1;
	}
	
	public function move( oDirection :Direction, oParticule :Particle) {
		var oPosition = oParticule.getPosition().clone();
		switch( oDirection ) {
			
			case RIGHT: //for ( i in 0...oParticule.getVelocity().x ) {
				if ( oParticule.getVelocity().x < _iCurrentSpeed ) return;
				oPosition.x++;
				//collisionCheck( oParticule, oPosition );
			//}
			case LEFT: //for ( i in 0...Math.floor(Math.abs(oParticule.getVelocity().x)) ) {
				if ( -oParticule.getVelocity().x < _iCurrentSpeed ) return;
				oPosition.x--;
				//collisionCheck( oParticule, oPosition );
			//}
			case UP:// for ( i in 0...oParticule.getVelocity().y ) {
				if ( oParticule.getVelocity().y < _iCurrentSpeed ) return;
				oPosition.y++;
				//collisionCheck( oParticule, oPosition );
			//}
			case DOWN:// for ( i in 0...Math.floor(Math.abs(oParticule.getVelocity().y) )) {
				if ( -oParticule.getVelocity().y < _iCurrentSpeed ) return;
				oPosition.y--;
				//collisionCheck( oParticule, oPosition );
			//}
		}
		if ( collisionCheck( oParticule, oPosition ) )
			return;
		_oModel.setParticlePosition( oParticule, oPosition );
		_oView.updateParticle( oParticule );
	}
	
	public function collisionCheck( oParticle :Particle, oPosition :Vector2i ) {
		var o = _oModel.getParticleByPosition( oPosition );
		if ( o == null )
			return false;
		return true;
		//trace('collision' );
		//
		//_oModel.removeParticle( o );
		//_oView.removeParticle( o );
		//
		//_oModel.setParticleVelocity( 
			//oParticle, 
			//oParticle.getVelocity().vector_add( o.getVelocity() ) 
		//);
	}
	
	public function sortingFunc( oDirection :Direction ) {
		
		switch( oDirection ) {
			
			case RIGHT: return function( a :Particle, b :Particle ) {
				return a.getVelocity().x - b.getVelocity().x;
			}
			case LEFT: return function( a :Particle, b :Particle ) {
				return b.getVelocity().x - a.getVelocity().x;
			}
			case UP: return function( a :Particle, b :Particle ) {
				return a.getVelocity().y - b.getVelocity().y;
			}
			case DOWN: return function( a :Particle, b :Particle ) {
				return b.getVelocity().y - a.getVelocity().y;
			}
		}
	}
}
