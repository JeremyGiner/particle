package particle.view;
import haxe.Resource;
import js.Browser;
import pixi.AbstractFilter;
import pixi.core.display.Container;
import pixi.core.graphics.Graphics;
import pixi.core.renderers.webgl.filters.Filter;
import pixi.core.utils.Utils;
/**
 * ...
 * @author 
 */
class GridView {
	
	var _oContainer :Container;
	
	public function new( iWidth :Int, iHeight :Int ) {
		// draw body
		_oContainer = new Container();
		
		var o = new Graphics().lineStyle(0.1, 0x333333/*Utils.rgb2hex([200,200,200,200])*/, 1);
		for (  j in 0...iWidth ) {
			o.moveTo(j,0).lineTo(j,iHeight);
		}
		for (i in 0...iHeight ) {
			o.moveTo(0,i).lineTo(iWidth,i);
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