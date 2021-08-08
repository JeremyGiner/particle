package particle.view;
import h2d.domkit.Style;
import hxd.App;
import particle.controller.DragDrop;
import particle.controller.Zoom;
import trigger.Subject;

/**
 * ...
 * @author 
 */
class HeapsApp extends App {

	//var _oMenu :Menu;
	
	public var onUpdate :Subject<HeapsApp>;
	
//_____________________________________________________________________________
// Constructor
	
    override function init() {
		
		onUpdate = new Subject<HeapsApp>();
		
		s2d.camera.setAnchor( 0.5, 0.5 );
		s2d.camera.setScale( 10, -10 );
		
		//_oMenu = new Menu(s2d);
		
		
		//backgroundColor = 0x000000;
		//transparent = true;
		//antialias = false;
		//onUpdate = _animate;
		
		
		var style = new Style();
		// resource referencing res/style.css (see Heaps Resources documentation)
		//style.load(hxd.Res.style); 
		//style.addObject(_oMenu);
		
		
		
		
    }
	
//_____________________________________________________________________________
// Process

	
}