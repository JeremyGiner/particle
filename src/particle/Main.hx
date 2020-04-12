package particle;

import haxe.ds.RedBlackTree;
import particle.process.SpaceRelativity;
import particle.view.View;
import particle.model.Model;
import particle.process.Spawn;
import pixi.plugins.app.Application;
import pixi.core.graphics.Graphics;

import pixi.core.sprites.Sprite;
import js.Browser;
import particle.process.Move;
import sweet.functor.IProcedure;

class Main extends Application {

	var _bunny:Sprite;
	var _graphic:Graphics;
	
	var _oView :View;
	var _oModel :Model;
	var _aProcess :Array<IProcedure>;
	

	public function new() {
		super();
		
		position = Application.POSITION_FIXED;
		width = Browser.window.innerWidth;
		height = Browser.window.innerHeight;
		backgroundColor = 0x006666;
		transparent = true;
		antialias = false;
		onUpdate = _animate;
		super.start();
		
		
		_oModel = new Model();
		_oView = new View( stage);
		_aProcess = [
			new Move( _oModel, _oView ), 
			new Spawn( _oModel, _oView ), 
			new SpaceRelativity( _oModel, _oView ), 
		];

		
		//var oTexture = Texture.from("asset/1.png");
		//_bunny = new Sprite(oTexture);
		//_bunny.anchor.set(0.5);
		//_bunny.position.set(400, 300);
//
		
		//stage.addChild(_bunny);
		
		
		//_aParticle = [];
		//
		//for ( i in 0...100 ) {
		//for ( j in 0...100 ) {
			//_graphic = new Graphics();
			//_graphic.beginFill(0xFF0000, 0.4);
			//_graphic.drawRect(-10, -10, 100, 100);
			//_graphic.endFill();
//
			//stage.addChild(_graphic);
		//}
		//}
		
		var timer = new haxe.Timer(50); // 1000ms delay
		timer.run = function() {
			try {
				for ( oProcess in _aProcess ) 
					oProcess.process();
			} catch ( e :Dynamic ) {
				timer.stop();
				throw e;
			}
		}
	}

	function _animate(e:Float) {
		
		
		//for ( i in 0..._aParticle.length ) {
			//_aParticle[i].rotation += 0.1;
		//}
		//_graphic.rotation += 0.1;
		
		_oView.update();
	}

	static function main() {
		new Main();
	}
}