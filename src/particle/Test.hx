package particle;
import haxe.Resource;
import js.Browser;
import pixi.AbstractFilter;
import pixi.core.Application;
import pixi.core.Pixi;
import pixi.core.RenderOptions;
import pixi.core.display.Container;
import pixi.core.graphics.Graphics;
import pixi.core.renderers.Detector;
import pixi.core.renderers.webgl.filters.Filter;
import pixi.core.utils.Utils;

class Test {

	static function main() {
		//Adapted from: https://codepen.io/davidhartley/pen/seEki?editors=0010

		var width :Int = Browser.window.innerWidth;
		var height :Int = Browser.window.innerHeight;
		var renderer = Detector.autoDetectRenderer(width, height);//Chooses either WebGL if supported or falls back to Canvas rendering
		Browser.document.body.appendChild(renderer.view);//Add the render view object into the page

		var stage = new Container();//The stage is the root container that will hold everything in our scene

		// grid shader
		var uniforms :Dynamic = {};
		uniforms.vpw = { type: 'i',value: width};
		uniforms.vph = { type: 'i',value: height};
		uniforms.offset = { type: 'v2', value: { x: -0.0235, y: 0.9794}}
		uniforms.pitch = { type: 'v2', value: { x: 50, y: 50}}
		uniforms.resolution = { type: 'v2', value: { x: width, y: height}};

		var shaderCode = Resource.getString('grid_shader');
		var gridShader = new Filter('',shaderCode, uniforms);
		var rect = new Graphics().drawRect(0, 0, width, height);
		rect.filters = [gridShader];
		stage.addChild(rect);

		// this is the main render call that makes pixi draw your container and its children.
		renderer.render(stage);


	}
	
	
}