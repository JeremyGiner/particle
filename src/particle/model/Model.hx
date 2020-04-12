package particle.model;
import haxe.ds.BalancedTreeFunctor;
import haxe.ds.IntMap;
import haxe.ds.Map;
import haxe.ds.BalancedTreeFunctor;
import js.Lib;
import particle.model.Particle;
import space.Vector2i;
import particle.tool.UniqueIdGenerator;
import sweet.functor.comparator.IComparator;
import particle.model.Direction.DirectionTool;
import haxe.Constraints.IMap;


/**
 * ...
 * @author 
 */
class Model {
	
	var _oGrid :Grid;
	
	// index by velocity direction
	var _oIdGen :UniqueIdGenerator;
	var test :BalancedTreeFunctor<Int,Particle>;
	var _mParticle :BalancedTreeFunctor<Int,Particle>;
	var _mParticleListByVelDir :Map<Direction,IMap<Int,Particle>>;
	var _mParticleByPosition :IMap<Vector2i,Particle>;

	public function new() {
		
		_oGrid = new Grid(100,50);
		_oIdGen = new UniqueIdGenerator();
		
		test = new BalancedTreeFunctor<Int,Particle>();
		_mParticle = new BalancedTreeFunctor<Int,Particle>();
		_mParticleListByVelDir = new Map<Direction,IMap<Int,Particle>>();
		_mParticleListByVelDir.set( Direction.UP, new Map<Int,Particle>() );// TODO use sorted list by valocity
		_mParticleListByVelDir.set( Direction.DOWN, new Map<Int,Particle>() );// TODO use sorted list by valocity
		_mParticleListByVelDir.set( Direction.LEFT, new Map<Int,Particle>() );// TODO use sorted list by valocity
		_mParticleListByVelDir.set( Direction.RIGHT, new Map<Int,Particle>() );// TODO use sorted list by valocity
		_mParticleByPosition = new BalancedTreeFunctor( new Vector2iComp() );
		//_mParticleByPosition = new Map();
	}
	
//_____________________________________________________________________________
//    Accessor
	
	public function getGrid() {
		return _oGrid;
	}
	
	public function getParticle( iId :Int ) {
		return _mParticle.get(iId);
	}
	public function getParticleAll() {
		return _mParticle;
	}
	
	public function getParticleCount() {
		return Lambda.array(_mParticle).length;
	}
	
	public function getParticleByPosition( oVector :Vector2i ) {
		return _mParticleByPosition.get( oVector );
	}
	
	public function getParticleListByVelDir( oDir :Direction ) {
		return _mParticleListByVelDir.get( oDir );
	}
	
//_____________________________________________________________________________
//    Modifier

	public function addParticle( oParticle :Particle ) {
		oParticle.setId( _oIdGen.generate() );
		
		
		// Index
		_mParticle.set( oParticle.getId(), oParticle );
		for(  oDirection in DirectionTool.getByVelocity( oParticle.getVelocity() ) ) {
			_mParticleListByVelDir
				.get( oDirection )
				.set( oParticle.getId(), oParticle )
			;
		}
		var i = Lambda.count(_mParticleByPosition);
		_mParticleByPosition.set( oParticle.getPosition(), oParticle );
		if ( Lambda.count(_mParticleByPosition) != i + 1 )
			throw '!!';
		if ( _mParticleByPosition.get( oParticle.getPosition().clone() ) != oParticle )
			throw '!!';
	}
	
	public function removeParticle( oParticle :Particle ) {
		
		if ( oParticle.getId() == null ) {
			trace('Warning: trying to remove particle with no identity');
			return;
		}
		// Remove from indexer
		_mParticle.remove( oParticle.getId() );
		for(  oDirection in DirectionTool.getAll() ) {
			_mParticleListByVelDir
				.get( oDirection )
				.remove( oParticle.getId() )
			;
		}
		_mParticleByPosition.remove( oParticle.getPosition() );
	}
	
	public function setParticleVelocity( oParticle :Particle, oVector :Vector2i ) {
		for(  oDirection in DirectionTool.getAll() ) {
			_mParticleListByVelDir
				.get( oDirection )
				.remove( oParticle.getId() )
			;
		}
		oParticle.setVelocity( oVector );// TODO: add to stack and process later
		for(  oDirection in DirectionTool.getByVelocity( oParticle.getVelocity() ) ) {
			_mParticleListByVelDir
				.get( oDirection )
				.set( oParticle.getId(), oParticle )
			;
		}
	}
	public function setParticlePosition( oParticle :Particle, oVector :Vector2i ) {
		if ( _mParticleByPosition.exists( oVector ) )
			throw '!!!';
		if ( Lambda.count(_mParticleByPosition ) !=Lambda.count( _mParticle ) ) {
			trace(_mParticleByPosition.toString());
			trace(_mParticle.toString());
			throw '!!!';
		}
		_mParticleByPosition.remove( oParticle.getPosition() );
		
		if ( Lambda.count(_mParticleByPosition ) !=Lambda.count( _mParticle ) -1  ) {
			trace(_mParticleByPosition.toString());
			trace(_mParticle.toString());
			throw '!!!';
		}
		
		oParticle.setPosition(oVector);
		_mParticleByPosition.set( oParticle.getPosition(), oParticle );
		
		
	}
}


class Vector2iComp implements IComparator<Vector2i> {
	
	public function new() {
		
	}
	
	public function apply( a :Vector2i, b :Vector2i ) {
		
		if ( a.equal(b) ) return 0;
		return a.toString() > b.toString() ? 1 : -1;
		//return a.x > b.x && a.y > b.y ? 1 : -1;
	}
}