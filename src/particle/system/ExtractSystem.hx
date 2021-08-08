package particle.system;
import legion.GameState;
import legion.entity.IEntity;
import particle.component.Extract;
import particle.component.Position;
import particle.entity.atom.RawSolid;
import space.Vector2i;
import sweet.functor.IProcedure;
import trigger.Subject;
import particle.tool.DirectionTool;
import particle.ParticleGameState;
import particle.component.MatterHolder;

/**
 * ...
 * @author 
 */
class ExtractSystem implements IProcedure {

	var _oGameState :ParticleGameState;
	
	public function new( oGameState :ParticleGameState ) {
		_oGameState = oGameState;
	}
	
	public function process() {
		
		// TODO : get only related entity
		for ( oEntity in _oGameState.getEntityAll() ) {
			
			// Get component
			var oCompo :Extract = cast oEntity.getComponent(Extract);
			if ( oCompo == null ) continue;
		
			var oPosition :Position = cast oEntity.getComponent(Position);
			if ( oPosition == null ) continue;
			
			// Get target entity
			var vector = DirectionTool.getVector( oPosition.getDirection() );
			var oTargetEntity = _oGameState.getPositionIndexer()
				.getEntityByPosition( oPosition.clone().addVector( vector ) );
			
			
			if ( oTargetEntity == null ) return;
			
			// Get target location
			var oTargetLocation = DirectionTool.getVector( DirectionTool.getReverse(oPosition.getDirection()) );
			
			extract( oTargetEntity, oTargetLocation);
		}
		
	}
	
	public function extract( o :IEntity, oLocation :Vector2i ) {
		var oHolder :MatterHolder = o.getComponent( MatterHolder );
		if ( oHolder != null ) {
			if ( oHolder.getCount() == 0 ) return;
			return extractMatter( oHolder, oLocation );
		}
	}
	
	public function extractMatter( oHolder :MatterHolder, oLocation :Vector2i ) {
		var oReceivingEntity = _oGameState.getPositionIndexer().getEntityByPosition( oLocation );
		
		// Case : no receiving entity -> dump on the ground
		if ( oReceivingEntity == null ) {
			_oGameState.addEntity( new RawSolid( oLocation, [ oHolder.unstack() ] ) );
			return;
		}
		
		// Tranfer matter holder to holder
		// TODO : check size
		var oReceivingHolder = oReceivingEntity.getComponent( MatterHolder );
		if ( oReceivingHolder == null ) return;
		oReceivingHolder.stack( oHolder.unstack() );
	}
	
	
}