package legion.system;
import haxe.ds.IntMap;
import hxd.App;
import particle.component.Renderable;
import particle.component.Position;
import legion.entity.IEntity;
import legion.GameState;
import sweet.functor.IProcedure;
import trigger.IObserver;
import legion.ds.PairEntityComponent;
import trigger.Subject;
import particle.view.entity.AEntityView;

/**
 * ...
 * @author 
 */
class Render implements IProcedure implements IObserver<Dynamic> {
	
	var _oHeaps :App;
	
	var _oGame :GameState;
	
	
	var _mEntityView :IntMap<AEntityView>;

	//TODO : queue
	
	public function new( oGame :GameState, oHeaps :App ) {
		_oGame = oGame;
		_oHeaps = oHeaps;
		_mEntityView = new IntMap<AEntityView>();
		
		_oGame.onEntityAdd.attach( cast this );
		_oGame.onComponentAttach.attach( cast this );
		_oGame.onComponentUpdate.attach( cast this );
		_oGame.onComponentRemove.attach( cast this );
		_oGame.onEntityRemove.attach( cast this );
	}
	
	public function process() {
		for ( oEntity in _oGame.getEntityAll() ) {
			var o = _mEntityView.get( oEntity.getId() ); 
			if ( o == null ) continue;
			o.update( 0 );
		}
	}
	
	public function signal( o :Subject<Dynamic> ) {
		
		// Event : Entity creation
		if ( o == _oGame.onEntityAdd ) {
			var oEntity = _oGame.onEntityAdd.getEvent();
			var oRenderable = oEntity.getComponent(Renderable);
			if ( oRenderable == null ) return;
			var oView = oRenderable.createView();
			_mEntityView.set( oEntity.getId(), oView );
			_oHeaps.s2d.addChild( oView );
			return;
		}
		
		// Event : Entity delete
		if ( o == _oGame.onEntityRemove ) {
			var oEntity = _oGame.onEntityRemove.getEvent();
			var oRenderable = oEntity.getComponent(Renderable);
			if ( oRenderable == null ) return;
			var oView = _mEntityView.get( oEntity.getId() );
			if ( oView == null ) return;
			_oHeaps.s2d.removeChild( oView );
			return;
		}
		
		if ( 
			o == _oGame.onComponentAttach 
			|| o == _oGame.onComponentUpdate
			|| o == _oGame.onComponentRemove 
		) {
			var oEvent :PairEntityComponent = cast o.getEvent();
			var oEntity =  oEvent.entity;
			var oView = _mEntityView.get( oEntity.getId() );
			if ( oView == null ) return;
			
			if( o == _oGame.onComponentAttach )
				return oView.onComponentAttach( oEvent.component );
			if( o == _oGame.onComponentUpdate )
				return oView.onComponentUpdate( oEvent.component );
			if( o == _oGame.onComponentRemove )
				return oView.onComponentRemove( oEvent.component );
		}
	}
	
}