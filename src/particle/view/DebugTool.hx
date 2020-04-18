package particle.view;
import pixi.core.graphics.Graphics;

/**
 * ...
 * @author 
 */
class DebugTool {

	static public function createAnchor() {
		return (new Graphics())
			.lineStyle(0.1, 0xFF0000, 1)
			.moveTo(0, 0)
			.lineTo(1, 0)
			.lineStyle(0.1, 0x00FF00, 1)
			.moveTo(0, 0)
			.lineTo(0, 1)
		;
	}
	
}