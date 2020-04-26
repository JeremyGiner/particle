package particle.view;
import haxe.Resource;
import haxe.Template;
import js.html.Element;
import particle.controller.Controller;
import particle.model.Model;
import space.Vector2i;

/**
 * ...
 * @author 
 */
class Menu {

	var _oModel :Model;
	var _oContainer :Element;
	var _oTemplate :Template;
	
	var _oPosition :Vector2i;
	
	public function new(  oModel :Model, oContainer :Element ) {
		_oModel = oModel;
		_oContainer = oContainer;
		if (  oContainer == null )
			throw '!!';
		
		_oTemplate = new Template( 
			Resource.getString('menu')
		);
		_oPosition = new Vector2i();
	}
	
	public function setPosition( o :Vector2i ) {
		_oPosition = o;
	}
	
	public function getContainer() {
		return _oContainer;
	}
	
	public function getData() :Dynamic {
		return {
			speed: _oModel.getSpeed(),
			selected: _oModel.getSelection() == null ? null: _oModel.getSelection().getId(),
			position: _oPosition,
		};
	}
	
	public function update() {
		
		_oContainer.innerHTML = _oTemplate.execute( getData() );
	}
}