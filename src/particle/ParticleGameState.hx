package particle;
import haxe.ds.BalancedTreeFunctor;
import legion.GameState;
import legion.entity.IEntity;
import particle.entity.atom.RawSolid;
import particle.indexer.PositionIndexer;
import particle.system.ExtractSystem;
import particle.system.MatterHolderSystem;
import particle.tool.Matter;
import space.Vector2i;

/**
 * ...
 * @author 
 */
class ParticleGameState extends GameState {
	
	var _oPositionIndex :PositionIndexer;
	
	
	public function new() {
		super();
		_oPositionIndex = new PositionIndexer( this );
		
		_aProcess = [
			new MatterHolderSystem( this ),
			new ExtractSystem( this ),
		];
	}
	
	
	public function getPositionIndexer() {
		return _oPositionIndex;
	}
	
}
