package particle.view.pixi;
import h2d.Object;
import h2d.col.Matrix;

/**
 * ...
 * @author 
 */
class Animation {

	var _oBegin :Matrix;
	var _oEnd :Matrix;
	var _oContainer :Object;
	
	public function new( o :Object, oBegin :Matrix, oEnd :Matrix ) {
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
		
		// TODO : improve
		_oContainer.setPosition( o.getPosition().x, o.getPosition().y );
		_oContainer.scaleX = o.getScale().x; 
		_oContainer.scaleY = o.getScale().y; 
		//_oContainer.setRotation( o.get() );
		//transform.setFromMatrix(o);
		
		/*setTransform(
			o.tx, o.ty,
			o.a, o.d,
			0, 
			o.c, o.b
			
		);*/
		//_oContainer.updateTransform();
	}
	
}