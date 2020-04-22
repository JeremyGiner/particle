package particle.view;
import haxe.Resource;
import haxe.Template;
import js.html.Element;
import particle.controller.Controller;
import particle.model.Model;

/**
 * ...
 * @author 
 */
class Menu {

	var _oModel :Model;
	var _oContainer :Element;
	var _oTemplate :Template;
	
	public function new(  oModel :Model, oContainer :Element ) {
		_oModel = oModel;
		_oContainer = oContainer;
		if (  oContainer == null )
			throw '!!';
		
		_oTemplate = new Template( 
			Resource.getString('menu')
		);
	}
	
	public function getContainer() {
		return _oContainer;
	}
	
	public function getData() :Dynamic {
		return {
			speed: _oModel.getSpeed(),
		};
	}
	
	public function update() {
		
		_oContainer.innerHTML = _oTemplate.execute( getData() );
	}
}