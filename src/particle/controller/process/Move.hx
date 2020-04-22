package particle.controller.process;
import haxe.ds.List;
import particle.controller.tool.CollisionHandler;
import particle.model.Model;
import particle.model.Particle;
import particle.model.ParticleType;
import particle.view.View;
import space.Vector2i;
import particle.model.Direction;
import sweet.functor.IProcedure;
import haxe.ds.ArraySort;


typedef PairParticleVector = {
	var particle :Particle;
	var vector :Vector2i;
}

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
	
	var _lUserMove :List<PairParticleVector>;

	public function new( oModel :Model, oView :View ) {
		_lUserMove = new List();
		
		_oModel = oModel;
		_oView = oView;
		
		_iMaxSpeed = 1;
		_iCurrentSpeed = 1;
		
		_oCollisionHandler = new CollisionHandler( _oModel );
	}
	
	public function addUserMove( oParticle :Particle, oPos :Vector2i ) {
		_lUserMove.add({particle: oParticle, vector: oPos });
	}

	
	public function process() {
		
		var oPair :PairParticleVector;
		while ( (oPair = _lUserMove.pop()) != null ) {
			
			var oParticle = oPair.particle;
			
			// Check if partcile wasn't removed by previous calls
			if( _oModel.getParticle( oParticle.getId() ) == null )
				return;
			
			if ( collisionCheck( oParticle, oPair.vector ) )
				return;
			
			_oModel.setParticlePosition( oParticle, oPair.vector );
		}
		
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
	}
	
	public function collisionCheck( oParticle :Particle, oPosition :Vector2i ) {
		var o = _oModel.getParticleByPosition( oPosition );
		if ( o == null )
			return false;
			
		// 
		_oCollisionHandler.handle( oParticle, o );
		
		// bump
		if ( 
			_oModel.getParticleByPosition( oPosition ) != null 
			&&  _oModel.getParticle( oParticle.getId() ) != null
		) {
			if ( oParticle.getType() == ParticleType.energy_echo )
				throw '!!!!';
			_oModel.setParticleVelocity( oParticle, new Vector2i() );// todo: bump animation
		}
		
		// Roll back move if particle was removed or path hasn't been cleared
		if ( 
			_oModel.getParticleByPosition( oPosition ) != null 
			||  _oModel.getParticle( oParticle.getId() ) == null
		) {
			
			return true;
		}
		
		return false;
	}
	
	public function sortingFunc( oDirection :Direction ) {
		
		switch( oDirection ) {
			
			case RIGHT: return function( a :Particle, b :Particle ) {
				return b.getPosition().x - a.getPosition().x;
			}
			case LEFT: return function( a :Particle, b :Particle ) {
				return a.getPosition().x - b.getPosition().x;
			}
			case UP: return function( a :Particle, b :Particle ) {
				return b.getPosition().y - a.getPosition().y;
			}
			case DOWN: return function( a :Particle, b :Particle ) {
				return a.getPosition().y - b.getPosition().y;
			}
		}
	}
}
