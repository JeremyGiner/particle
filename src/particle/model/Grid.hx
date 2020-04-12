package particle.model;

/**
 * ...
 * @author 
 */
class Grid {

	var _iHeight :Int;
	var _iWidth :Int;
	
	public function new( iWidth :Int, iHeight: Int ) {
		_iHeight = iHeight;
		_iWidth = iWidth;
	}
	
	public function getWidth() {
		return _iWidth;
	}
	
	public function getHeight() {
		return _iHeight;
	}
}