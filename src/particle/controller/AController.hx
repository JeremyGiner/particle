package particle.controller;
import particle.model.Model;
import particle.view.View;

/**
 * ...
 * @author 
 */
class AController {

	var _oModel :Model;
	var _oView :View;
	
	public function new( oModel :Model, oView :View ) {
		_oModel = oModel;
		_oView = oView;
		init();
	}
	
	public function init() {
		
	}
	
	
}