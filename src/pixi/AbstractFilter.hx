package pixi;

/**
 * ...
 * @author 
 */

@:native("PIXI.AbstractFilter")
extern class AbstractFilter {
	/**
	 * @class
	 * @memberof PIXI
	 * @param [vertexSrc] {String} The source of the vertex shader.
	 * @param [fragmentSrc] {String} The source of the fragment shader.
	 * @param [uniforms] {Dynamic} Custom uniforms to use to augment the built-in ones.
	 */
	function new(?vertexSrc:String, ?fragmentSrc:String, ?uniforms:Dynamic);
	
}
