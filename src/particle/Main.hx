package particle;

import particle.controller.Controller;
import particle.view.View;
import particle.model.Model;

class Main {

	static function main() {
		
		var _oView :View;
		var _oModel :Model;
		
		
		//backgroundColor = 0x000000;
		//transparent = true;
		//antialias = false;
		//onUpdate = _animate;
		
		
		_oModel = new Model();
		_oView = new View( _oModel );
		
		new Controller( _oModel, _oView );
	}
	
	
}