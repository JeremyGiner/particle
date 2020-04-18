package particle.controller;
import js.Browser;
import particle.view.View;
import pixi.core.math.Point;

/**
 * ...
 * @author 
 */
class Zoom {

	var _oView :View;
	
	public function new( oView :View ) {
		
		_oView = oView;
		Browser.window.addEventListener('wheel', function( event ) {
			
			var fFactor = _oView.getZoom()
				* (event.deltaY > 0 ? 0.75 : 1.25)
			;
			
			fFactor = Math.min(fFactor, 100);
			fFactor = Math.max(fFactor, 0.01);
			
			var x = event.pageX;
			var y = event.pageY;
			//var o = _oView.getScene().toLocal(new Point(x, y));
			//trace(o);
			var oScene = _oView.getScene();
			
			
			var worldPos = {x: (x - oScene.x) / oScene.scale.x, y: (y - oScene.y)/oScene.scale.y};
			var newScale = fFactor;//{x: oScene.scale.x * s, y: oScene.scale.y * s};

			var newScreenPos = {x: (worldPos.x ) * fFactor + oScene.x, y: (worldPos.y) * fFactor + oScene.y};

			oScene.x -= (newScreenPos.x-x) ;
			oScene.y -= (newScreenPos.y-y) ;
			oScene.scale.x = fFactor;
			oScene.scale.y = fFactor;
			//_oView.setZoom( o.x , o.y, fFactor );
		});
	}
	
}