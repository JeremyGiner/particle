package particle.view.pixi;
import pixi.core.display.Transform;
import pixi.core.math.Matrix;

/**
 * ...
 * @author 
 */
class MatrixTool {

	static public function interpolate( a :Matrix, b :Matrix, f :Float ) {
		var o = a.clone();
		var oTransformA = new Transform();oTransformA.setFromMatrix( a );
		var oTransformB = new Transform();oTransformB.setFromMatrix( b );
		oTransformA.rotation = FloatTool.interpolateAngle(
			oTransformA.rotation, oTransformB.rotation, f 
		);
		oTransformA.position.set(
			FloatTool.interpolate( 
				oTransformA.position.x, 
				oTransformB.position.x, 
				f 
			),
			FloatTool.interpolate( 
				oTransformA.position.y, 
				oTransformB.position.y, 
				f 
			)
		);
		oTransformA.updateLocalTransform();
		return oTransformA.localTransform;
	}
}