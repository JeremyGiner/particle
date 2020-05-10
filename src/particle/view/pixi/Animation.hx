package particle.view.pixi;
import pixi.core.display.Container;
import pixi.core.math.Matrix;

/**
 * ...
 * @author 
 */
class Animation {

	var _oBegin :Matrix;
	var _oEnd :Matrix;
	var _oContainer :Container;
	
	public function new( o :Container, oBegin :Matrix, oEnd :Matrix ) {
		_oContainer = o;
		_oBegin = oBegin;
		_oEnd = oEnd.clone();
	}
	
	public function animate( f :Float ) {
		var o = MatrixTool.interpolate(
			_oBegin,
			_oEnd,
			f
		);
		untyped _oContainer.transform.setFromMatrix(o);
		
		/*setTransform(
			o.tx, o.ty,
			o.a, o.d,
			0, 
			o.c, o.b
			
		);*/
		_oContainer.updateTransform();
	}
	
}