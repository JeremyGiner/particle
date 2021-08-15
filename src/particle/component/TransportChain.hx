package particle.component;
import legion.component.IComponent;
import legion.entity.IEntity;
import particle.tool.Matter;
import space.Vector2i;

/**
 * ...
 * @author 
 */
class TransportChain implements IComponent {
	
	var _aBelt :Array<IEntity>;
	var _aMatter :Array<Null<Matter>>;
	
//_____________________________________________________________________________
// Constructor

	public function new( oOwner :IEntity ) {
		_aBelt = [ oOwner ];
		_aMatter = [];
	}
	
//_____________________________________________________________________________
// Accessor

	public function getOutput() :IEntity {
		return _aBelt[ 0 ];
	}
	
	public function getOutputPos() :Vector2i {
		var oEnt = _aBelt[ 0 ];
		var oDirection :DirectionCompo = oEnt.getComponent(DirectionCompo);
		var oPos :Position = oEnt.getComponent(Position);
		return oPos.clone().vector_add( oDirection.getVector() );
	}
	
	public function getInputPos() :Vector2i {
		var oEnt = _aBelt[ _aBelt.length - 1 ];
		var oPos :Position = oEnt.getComponent(Position);
		return oPos.clone();
	}

	public function getNextMatter() {
		return _aMatter[0];
	}
	
//_____________________________________________________________________________
// Modifier
	
 	public function forward() {
		for ( i in 1..._aMatter.length ) {
			
			if ( _aMatter[i-1] != null ) continue;
			
			_aMatter[i-1] = _aMatter[i];
			_aMatter[i] = null;
		}
	}
	
	public function pop() {
		var o = _aMatter[0];
		_aMatter[0] = null;
		return o;
	}
	
	public function merge( o :TransportChain ) {
		_aBelt = _aBelt.concat( o._aBelt );
		_aMatter = _aMatter.concat( o._aMatter );
		
		for ( oEnt in o._aBelt ) oEnt.setComponent( this );
	}
	
}