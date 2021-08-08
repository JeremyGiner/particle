package particle.view;
import h2d.Flow;
import haxe.Resource;
import haxe.Template;
import particle.controller.Controller;
import particle.model.Model;
import space.Vector2i;

/**
 * ...
 * @author 
 */
class Menu extends Flow implements h2d.domkit.Object {

	var _oModel :Model;
	var _oTemplate :Template;
	
	var _oPosition :Vector2i;
	
	static var SRC = 
	<menu>
       <flow>
			<flow>
				<text text={"&curarr;"}/> 
			</flow>
			<flow>
				${
					if (speed == 0)
						<text text={"&rtrif;"}/> 
					else
						<text text={"&squarf;"}/> 
				}
			</flow>
			<flow>
				<text text={"&rtrif;&rtrif;"}/> 
			</flow>
		</flow>

		<flow>
			${
			if (selected != null )
				<text text={selected}/>
			}
		</flow>
		<flow>
			
		</flow>
	</menu>
	;
//<text text={position.x}/><text text={":"}/><text text={position.y}/>
		
	public function new( oModel :Model , speed :Float, selected :String, position :Vector2i, ?parent) {
		super(parent);
		initComponent();
		_oModel = oModel;
		_oPosition = new Vector2i();
	}
	/*
	public function setPosition( o :Vector2i ) {
		_oPosition = o;
	}
	*/
	public function get_speed() {
		return 0;
	}
	
	public function getData() :Dynamic {
		return {
			speed: _oModel.getSpeed(),
			selected: _oModel.getSelection() == null ? null: _oModel.getSelection().getId(),
			position: _oPosition,
		};
	}
}

@:uiComp("button")
class ButtonComp extends h2d.Flow implements h2d.domkit.Object {

	static var SRC = <button>
		<text public id="labelTxt" />
	</button>

	public var label(get, set): String;
	function get_label() return labelTxt.text;
	function set_label(s) {
		labelTxt.text = s;
		return s;
	}

	public function new( ?parent ) {
		super(parent);
		initComponent();
		enableInteractive = true;
		interactive.onClick = function(_) onClick();
		interactive.onOver = function(_) {
			dom.hover = true;
		};
		interactive.onPush = function(_) {
			dom.active = true;
		};
		interactive.onRelease = function(_) {
			dom.active = false;
		};
		interactive.onOut = function(_) {
			dom.hover = false;
		};
	}

	public dynamic function onClick() {
	}
}