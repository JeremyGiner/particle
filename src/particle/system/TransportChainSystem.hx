package particle.system;
import legion.GameState;
import legion.entity.IEntity;
import particle.component.Extract;
import particle.component.Position;
import particle.component.TransportChain;
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
class TransportChainSystem implements IProcedure {

	var _oGameState :ParticleGameState;
	
	public function new( oGameState :ParticleGameState ) {
		_oGameState = oGameState;
	}
	
	public function process() {
		
		var mCompo = new Map<TransportChain,TransportChain>();
		
		// TODO : improve using event
		// get all compo transport
		for ( oEntity in _oGameState.getEntityAll() ) {
			var oCompo :TransportChain = oEntity.getComponent(TransportChain);
			if ( oCompo == null ) continue;
			mCompo.set( oCompo, oCompo );
		}
		
		// Belt merge
		var tmp = mCompo.copy();
		for ( oCompo in mCompo ) {
			
			// Case : already deleted
			if ( !tmp.exists( oCompo ) ) continue;
			
			var oOutputPos = oCompo.getOutputPos();
			var oTarget = _oGameState.getPositionIndexer().getEntityByPositison( oOutputPos );
			if ( oTarget == null ) continue;
			
			var oMerged = oTarget.getComponent(TransportChain);
			if ( oMerged == null ) continue;
			
			if ( !oOutputPos.equal( oMerged.getInputPos() ) ) continue;
			
			
			// Case : current transportchain output into the input of another transportchain
			oCompo.merge( oMerged );
			tmp.remove( oMerged );
		}
		
		// Output if space available
		for ( oCompo in mCompo ) {
			var oOutputPos = oCompo.getOutputPos();
			var oTarget = _oGameState.getPositionIndexer().getEntityByPosition( oOutputPos );
			
			// Case : dump on the ground
			if ( oTarget == null ) {
				oTarget = new RawSolid( oOutputPos, [ oCompo.pop() ] );
				continue;
			}
			
			// Case : matter holder
			var oHolder :MatterHolder = Target.getComponent(MatterHolder);
			if ( oHolder != null ) {
				oHolder.stack( oCompo.pop() );
				continue;
			}
			
			// TODO : Case : other transport belt
		}
		
		// Move belt forward
		for ( oCompo in mCompo )
			oCompo.forward();
		
		
		
		
		// TODO : belt split 
		// TODO : belt 
		
		
		
		
	}
	
}