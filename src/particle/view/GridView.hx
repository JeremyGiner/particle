package particle.view;
import h2d.Graphics;
import h2d.Object;
import haxe.Resource;
/**
 * ...
 * @author 
 */
class GridView {
	
	var _oContainer :Object;
	
	public function new( iWidth :Int, iHeight :Int ) {
		// draw body
		_oContainer = new Object();
		
		var o = new Graphics();
		o.lineStyle(0.1, 0x333333/*Utils.rgb2hex([200,200,200,200])*/, 1);
		for (  j in 0...iWidth ) {
			o.moveTo(j, 0);
			o.lineTo(j,iHeight);
		}
		for (i in 0...iHeight ) {
			o.moveTo(0, i);
			o.lineTo(iWidth,i);
		}
		_oContainer.addChild(o);
		//var width = Browser.window.innerWidth;
		//var height = Browser.window.innerHeight;
		//
		//// grid shader
		//var uniforms :Dynamic = {};
		//uniforms.vpw = width;
		//uniforms.vph = height;
		//uniforms.offset = { type: 'v2', value: { x: 0, y: 0}}
		//uniforms.pitch = { type: 'v2', value: { x: 5000, y: 5000}}
		//uniforms.resolution = { type: 'v2', value: { x: width, y: height}};
//
		//var shaderCode = Resource.getString('grid_shader');
		//var gridShader = new AbstractFilter('',shaderCode, uniforms);
		//var rect = new Graphics().drawRect(0, 0, width*2, height*2);
		//rect.filters = [cast gridShader];
		//
		//_oContainer = rect;
	}
	
	public function getContainer() {
		return _oContainer;
	}
	
}