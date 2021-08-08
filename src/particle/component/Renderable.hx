package particle.component;
import h2d.Object;
import legion.component.AComponent;
import legion.component.IComponent;
import particle.entity.Atom;
import particle.view.entity.AEntityView;
import particle.view.entity.MasterCraneView;
import particle.entity.atom.MasterCrane;
import particle.view.entity.RawSolidView;

/**
 * ...
 * @author 
 */
class Renderable extends AComponent {

	var _o :Dynamic;
	var _oView :Object;
	
	public function new( owner :Dynamic ) {
		_o = owner;
		_oView = null;
	}
	
	public function createView() :AEntityView {
		
		if ( Std.is( _o, MasterCrane ) ) {
			return new MasterCraneView(cast _o);
		} else if ( Std.is( _o, Atom ) ) {
			return new RawSolidView(cast _o);
		}
		throw '!!!!';
	}
}