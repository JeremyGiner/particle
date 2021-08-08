package particle.controller;
import h2d.col.Point;
import particle.view.HeapsApp;

/**
 * ...
 * @author 
 */
class Zoom {

	var _oView :HeapsApp;
	
	public function new( oView :HeapsApp ) {
		_oView = oView;
		hxd.Window.getInstance().addEventTarget(function( event :hxd.Event ) {
			
			if( event.wheelDelta == 0 )
				return;
			
			// Get new zoom factor
			var fFactor = ( event.wheelDelta > 0 ) ? 0.75 : 1.25;
			
			var oNewScale = {
				x: _clamp( fFactor * _oView.s2d.camera.scaleX, 1, 100 ),
				y: _clamp( fFactor * _oView.s2d.camera.scaleY, -100, -1 ),
			};
			_oView.s2d.camera.setScale( 
				oNewScale.x, 
				oNewScale.y
			);
			
			// Get cursor position
			
			//var o = _oView.getScene().toLocal(new Point(x, y));
			//trace(o);
			
			// Get focus point (mouse rel to scene)
			var oFocusPoint = {
				x: _oView.s2d.mouseX,
				y: _oView.s2d.mouseY,
			};
			
			// get focus point rel to camera
			var oFocusPointToCamera = {
				x: (oFocusPoint.x - _oView.s2d.camera.x) ,
				y: (oFocusPoint.y - _oView.s2d.camera.y),
			}
			
			
			//TODO : simplify
			var offset = {
				x: oFocusPointToCamera.x / fFactor, 
				y: oFocusPointToCamera.y / fFactor
			};
			
			
			_oView.s2d.camera.x = oFocusPoint.x - offset.x;
			_oView.s2d.camera.y = oFocusPoint.y - offset.y;
			
		});
	}

	function _clamp( f :Float, min :Float, max :Float ) {
		return Math.max(Math.min(f, max),min);
	}
}