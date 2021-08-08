package particle.system;
import legion.GameState;
import legion.entity.IEntity;
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
class MatterHolderSystem implements IProcedure {

	var _oGameState :ParticleGameState;
	
	public function new( oGameState :ParticleGameState ) {
		_oGameState = oGameState;
	}
	
	public function process() {
		
		// TODO : get only related entity
		for ( oEntity in _oGameState.getEntityAll() ) {
			
			// Get component
			var oCompo :MatterHolder = oEntity.getComponent(MatterHolder);
			if ( oCompo == null ) continue;
			
			// Kill empty RawSolid
			if ( oCompo.isRaw() && oCompo.getCount() == 0 ) {
				_oGameState.removeEntity( oEntity );
				trace('Killing');
				trace(oEntity);
				
				return;
			}
			// TODO : water spill
			
		}
		
	}
	
	
	
}