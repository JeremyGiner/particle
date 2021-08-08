package particle.indexer;
import haxe.ds.BalancedTreeFunctor;
import legion.GameState;
import legion.entity.IEntity;
import legion.ds.PairEntityComponent;
import particle.component.Position;
import space.Vector2i;
import sweet.functor.comparator.IComparator;
import trigger.IObserver;
import trigger.Subject;

/**
 * ...
 * @author 
 */
class PositionIndexer implements IObserver<PairEntityComponent> {
	
	var _oGame :GameState;
	var _mParticleByPosition :BalancedTreeFunctor<Vector2i,IEntity>;
	var _mReverse :BalancedTreeFunctor<Int,Vector2i>;

	public function new( oGameState :GameState ) {
		_mParticleByPosition = new BalancedTreeFunctor( new Vector2iComp() );
		_mReverse = new BalancedTreeFunctor();
		_oGame = oGameState;
		oGameState.onComponentAttach.attach( this );
		oGameState.onComponentUpdate.attach( this );
		oGameState.onComponentRemove.attach( this );
	}
	
	public function getEntityByPosition( o :Vector2i ) {
		return _mParticleByPosition.get( o );
	}
	
	public function signal( oSubject :Subject<PairEntityComponent> ) {
		
		// Remove pos
		if ( 
			oSubject == _oGame.onComponentRemove 
			&& Std.is(_oGame.onComponentRemove.getEvent().component, Position)
		) {
			var oEntity = _oGame.onComponentRemove.getEvent().entity;
			var oPrevPos = _mReverse.get( oEntity.getId() );
			if ( oPrevPos == null ) throw '!!!';
			_mParticleByPosition.remove( oPrevPos );
			_mReverse.remove( oEntity.getId() );
			return;
		}
		
		// Attach
		if ( 
			oSubject == _oGame.onComponentAttach 
			&& Std.is(_oGame.onComponentAttach.getEvent().component, Position)
		) {
			var oEntity = _oGame.onComponentAttach.getEvent().entity;
			var oPos :Position = cast _oGame.onComponentAttach.getEvent().component;
			_mParticleByPosition.set( oPos, oEntity );
			_mReverse.set( oEntity.getId(), oPos );
			return;
		}
		
		// Update
		if ( 
			oSubject == _oGame.onComponentUpdate 
			&& Std.is(_oGame.onComponentUpdate.getEvent().component, Position)
		) {
			var oEntity = _oGame.onComponentUpdate.getEvent().entity;
			var oPos :Position = cast _oGame.onComponentUpdate.getEvent().component;
			
			// Remove prev
			var oPrevPos = _mReverse.get( oEntity.getId() );
			_mParticleByPosition.remove( oPrevPos );
			
			// Add new pos
			_mParticleByPosition.set( oPos, oEntity );
			_mReverse.set( oEntity.getId(), oPos );
		}
		
		
	}
	
}


class Vector2iComp implements IComparator<Vector2i> {
	
	public function new() {}
	
	public function apply( a :Vector2i, b :Vector2i ) {
		
		if ( a.equal(b) ) return 0;
		return a.toString() > b.toString() ? 1 : -1;
		//return a.x > b.x && a.y > b.y ? 1 : -1;
	}
}