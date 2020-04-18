package particle.controller.process;
import haxe.ds.BalancedTree;
import haxe.ds.IntMap;
import particle.controller.tool.CollisionHandler;
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
	
	var _oCollisionHandler :CollisionHandler;

	public function new( oModel :Model, oView :View ) {
		_oModel = oModel;
		_oView = oView;
		
		_iMaxSpeed = 10;
		_iCurrentSpeed = 1;
		
		_oCollisionHandler = new CollisionHandler( _oModel );
	}

	
	public function process() {
		
		
		// Get all 
		for ( oDirection in DirectionTool.getAll() ) { 
		
		
			var a = Lambda.array(_oModel.getParticleListByVelDir(oDirection));
			ArraySort.sort( a, sortingFunc(oDirection) );
			//for ( oParticle  in a ) {
				//_oModel.removeParticleoParticle move( oDirection, oParticle );
			//}
			for ( oParticle in a ) {
				move( oDirection, oParticle );
			}
		}
		_iCurrentSpeed++;
		if ( _iCurrentSpeed > _iMaxSpeed ) _iCurrentSpeed = 1;
	}
	
	public function move( oDirection :Direction, oParticle :Particle) {
		
		// Check if partcile wasn't removed by previous calls
		if( _oModel.getParticle( oParticle.getId() ) == null )
			return;
		
		var oPosition = oParticle.getPosition().clone();
		switch( oDirection ) {
			
			case RIGHT: //for ( i in 0...oParticle.getVelocity().x ) {
				if ( oParticle.getVelocity().x < _iCurrentSpeed ) return;
				oPosition.x++;
				//collisionCheck( oParticle, oPosition );
			//}
			case LEFT: //for ( i in 0...Math.floor(Math.abs(oParticle.getVelocity().x)) ) {
				if ( -oParticle.getVelocity().x < _iCurrentSpeed ) return;
				oPosition.x--;
				//collisionCheck( oParticle, oPosition );
			//}
			case UP:// for ( i in 0...oParticle.getVelocity().y ) {
				if ( oParticle.getVelocity().y < _iCurrentSpeed ) return;
				oPosition.y++;
				//collisionCheck( oParticle, oPosition );
			//}
			case DOWN:// for ( i in 0...Math.floor(Math.abs(oParticle.getVelocity().y) )) {
				if ( -oParticle.getVelocity().y < _iCurrentSpeed ) return;
				oPosition.y--;
				//collisionCheck( oParticle, oPosition );
			//}
		}
		if ( collisionCheck( oParticle, oPosition ) )
			return;
		
		_oModel.setParticlePosition( oParticle, oPosition );
		_oView.updateParticle( oParticle );
	}
	
	public function collisionCheck( oParticle :Particle, oPosition :Vector2i ) {
		var o = _oModel.getParticleByPosition( oPosition );
		if ( o == null )
			return false;
			
		// 
		_oCollisionHandler.handle( oParticle, o );
		
		// Roll back move if particle was removed or path hasn't been cleared
		if ( 
			_oModel.getParticleByPosition( oPosition ) != null 
			||  _oModel.getParticle( oParticle.getId() ) == null
		) {
			oParticle.setVelocity( new Vector2i() );// to do bump animation
			return true;
		}
		
		return false;
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
