package particle.controller;
import legion.entity.IEntity;
import particle.ParticleGameState;
import particle.component.ManualCrane;
import particle.entity.atom.MasterCrane;
import particle.view.HeapsApp;
import space.Vector2i;
import hxd.Event.EventKind;
import particle.component.Position;

/**
 * ...
 * @author 
 */
class DragDrop {

	var _oGameState :ParticleGameState;
	var _oView :HeapsApp;
	
	var _oMasterCrane :MasterCrane; // TODO : make dynamic
	
	
	public function new( oModel :ParticleGameState, oView :HeapsApp ) {
		_oGameState = oModel;
		_oView = oView;
		
		
		hxd.Window.getInstance().addEventTarget(function( event :hxd.Event ) {
			
			// On push right click
			if ( event.kind == EventKind.EPush && event.button == 0 )
				return dragStart();
			
				
			// On realease right click
			if ( event.kind == EventKind.ERelease && event.button == 0 )
				return drop();
		});
	}
	
	public function getMasterCrane() {
		if ( _oMasterCrane == null )
			for ( o in _oGameState.getEntityAll() )
				if ( Std.is( o, MasterCrane ) ) {
					_oMasterCrane = cast o;
					break;
				}
		return _oMasterCrane;
	}
	
	public function dragStart() {
		var x = Math.floor( _oView.s2d.mouseX );
		var y = Math.floor( _oView.s2d.mouseY );
		var o = _oGameState.getPositionIndexer()
			.getEntityByPosition( new Vector2i(x, y) );
		
		if ( o == null ) return;
		
		var oManualCrane = getMasterCrane().getComponent(ManualCrane);
		if ( oManualCrane == null ) throw '!!!';
		if ( oManualCrane.getContent() != null ) return;
		oManualCrane.grab( o );
		
		_oGameState.removeComponent( o, Position );
		_oGameState.onComponentUpdate.notify({
			entity: getMasterCrane(),
			component: cast oManualCrane,
		});
	}
	
	public function drop() {
		var x = Math.floor( _oView.s2d.mouseX );
		var y = Math.floor( _oView.s2d.mouseY );
		
		// Get crane content
		var oManualCrane = getMasterCrane().getComponent(ManualCrane);
		if ( oManualCrane == null ) throw '!!!';
		if ( oManualCrane.getContent() == null ) return;
		var o = oManualCrane.getContent();
		
		// Check drop location
		var oBlocker = _oGameState.getPositionIndexer()
			.getEntityByPosition( new Vector2i(x, y) );
		if ( oBlocker != null ) return;
		
		// Release
		oManualCrane.realease();
		_oGameState.onComponentUpdate.notify({
			entity: getMasterCrane(),
			component: cast oManualCrane,
		});
		_oGameState.setComponent( o,new Position(x,y));
	}
}