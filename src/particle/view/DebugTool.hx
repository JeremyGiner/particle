package particle.view;
import h2d.Graphics;

/**
 * ...
 * @author 
 */
class DebugTool {

	static public function createAnchor() {
		var o = new Graphics();
		
		o.lineStyle(0.1, 0xFF0000, 1);
		o.moveTo(0, 0);
		o.lineTo(1, 0);
		o.lineStyle(0.1, 0x00FF00, 1);
		o.moveTo(0, 0);
		o.lineTo(0, 1);
		return o;
	}
	
}