package particle.model;
import haxe.CallStack;
import haxe.ds.BalancedTree;
import haxe.ds.BalancedTreeFunctor;
import haxe.ds.IntMap;
import haxe.ds.Map;
import haxe.ds.BalancedTreeFunctor;
import particle.model.Particle;
import space.Vector2i;
import particle.tool.UniqueIdGenerator;
import sweet.functor.comparator.IComparator;
import particle.model.Direction.DirectionTool;
import haxe.Constraints.IMap;
import trigger.EventListener;


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
	var _mParticleByType :IMap<ParticleType,IMap<Int,Particle>>;
	
	var _oSelected :Particle;
	
	var _iSpeed :Int;
	
	//var oOutBoundIndexer :IIndexer;
	
	public var onCreate :EventListener<Particle>;
	public var onDelete :EventListener<Particle>;
	public var onUpdate :EventListener<ParticleUpdateEvent>;
	public var onSpeedChange :EventListener<Model>;
	public var onSelectionChange :EventListener<Particle>;

//_____________________________________________________________________________
//    Constructor
	
	public function new() {
		
		_oSelected = null;
		_iSpeed = 0;
		
		onCreate = new EventListener();
		onDelete = new EventListener();
		onUpdate = new EventListener();
		onSpeedChange = new EventListener();
		onSelectionChange = new EventListener();
		
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
		_mParticleByType = new BalancedTree();
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
	
	public function getParticleByType( oType :ParticleType ) {
		
		if ( !_mParticleByType.exists( oType ) )
			_mParticleByType.set(oType,new BalancedTree<Int,Particle>()  );
		return _mParticleByType.get( oType );
		
	}
	
	public function getCount() {
		return Lambda.count(_mParticle);
	}
	
	public function getSelection() {
		return _oSelected;
	}
		
	public function getSpeed() {
		return _iSpeed;
	}
	
//_____________________________________________________________________________
//    Modifier

	public function setSelection( oParticle :Particle ) {
		_oSelected = oParticle;
		onSelectionChange.trigger( _oSelected );
	}


	public function setSpeed( i :Int ) {
		_iSpeed = i;
		onSpeedChange.trigger( this );
	}

	public function addParticle( oParticle :Particle ) {
		oParticle.setId( _oIdGen.generate() );
		
		
		// Update indexer
		_mParticle.set( oParticle.getId(), oParticle );
		for(  oDirection in DirectionTool.getByVelocity( oParticle.getVelocity() ) ) {
			_mParticleListByVelDir
				.get( oDirection )
				.set( oParticle.getId(), oParticle )
			;
		}
		_mParticleByPosition.set( oParticle.getPosition(), oParticle );
		
		if ( !_mParticleByType.exists( oParticle.getType() ) )
			_mParticleByType.set( 
				oParticle.getType(),
				new BalancedTree<Int,Particle>() 
			);
		_mParticleByType
			.get( oParticle.getType() )
			.set(oParticle.getId(), oParticle )
		;
		
		
		// Dispatch event
		onCreate.trigger( oParticle );
	}
	
	public function removeParticle( oParticle :Particle ) {
		
		if ( oParticle.getId() == null ) {
			trace('Warning: trying to remove particle with no identity');
			return;
		}
		//if ( !_mParticle.exists( oParticle.getId() ) ) {
			//trace('Warning: trying to remove particle twice');
			//return;
			//
		//}
		trace('removing #'+oParticle.getId());
		trace(CallStack.callStack());
		
		
		
		
		// Remove from indexer
		_mParticle.remove( oParticle.getId() );
		for(  oDirection in DirectionTool.getAll() ) {
			_mParticleListByVelDir
				.get( oDirection )
				.remove( oParticle.getId() )
			;
		}
		_mParticleByPosition.remove( oParticle.getPosition() );
		_mParticleByType.get(oParticle.getType()).remove( oParticle.getId() );
		
		if ( _oSelected == oParticle ) {
			_oSelected = null;
			onSelectionChange.trigger(_oSelected);
		}
		onDelete.trigger( oParticle );
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

		_mParticleByPosition.remove( oParticle.getPosition() );
		oParticle.setPosition(oVector);
		_mParticleByPosition.set( oParticle.getPosition(), oParticle );
		
		onUpdate.trigger({particle: oParticle, field: 'position', });
	}
	
	public function setParticleType( oParticle :Particle, oType :ParticleType ) {
		if ( oParticle.getType() == oType )
			return;
		
		_mParticleByType.get(oParticle.getType()).remove(oParticle.getId());
		oParticle.setType( oType );
		if ( !_mParticleByType.exists( oParticle.getType() ) )
			_mParticleByType.set( 
				oParticle.getType(),
				new BalancedTree<Int,Particle>() 
			);
		_mParticleByType.get(oParticle.getType()).set( oParticle.getId(), oParticle );
		
		onUpdate.trigger({particle: oParticle, field: 'type', });
	}
	
	public function addParticleEnergy( oParticle :Particle, i :Int = 1 ) {
		
		if ( !_mParticle.exists(oParticle.getId()) )
			return;
		oParticle.addEnergy( i );
		
		onUpdate.trigger({particle: oParticle, field: 'energy', });
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

typedef ParticleUpdateEvent = {
	var particle :Particle;
	var field :String;
}