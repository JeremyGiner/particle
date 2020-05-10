package particle.view.pixi;

/**
 * ...
 * @author 
 */
class FloatTool {

	static public function interpolate( a :Float, b :Float, f :Float) {
		return a + f * (b - a);
	}
	static public function interpolateAngle( a :Float, b :Float, f :Float) {
		return a + FloatTool.shortAngleDist(a,b)*f;
	}
	
	static public function shortAngleDist(a0 :Float, a1 :Float) {
		var max = Math.PI*2;
		var da = (a1 - a0) % max;
		return 2*da % max - da;
	}
	
}