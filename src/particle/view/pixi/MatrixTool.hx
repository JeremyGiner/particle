package particle.view.pixi;
import h2d.col.Matrix;

/**
 * ...
 * @author 
 */
class MatrixTool {

	static public function interpolate( a :Matrix, b :Matrix, f :Float ) :Matrix {
		var o = a.clone();
		
		o.a = FloatTool.interpolate( a.a, b.a, f );
		o.b = FloatTool.interpolate( a.b, b.b, f );
		o.c = FloatTool.interpolate( a.c, b.c, f );
		o.d = FloatTool.interpolate( a.d, b.d, f );
		o.x = FloatTool.interpolate( a.x, b.x, f );
		o.y = FloatTool.interpolate( a.y, b.y, f );

		/*o.setrotation = FloatTool.interpolateAngle(
			oTransformA.rotation, oTransformB.rotation, f 
		);*/
		
		return o;
	}
}