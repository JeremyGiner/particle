package particle;

import js.Function;
import js.Lib;
import particle.controller.DragDrop;
import particle.controller.Presenter;
import particle.controller.Rotate;
import particle.controller.Zoom;
import particle.controller.process.FabricatorBehavior;
import particle.controller.process.GeneratorSpawnBehavior;
import particle.controller.process.MapBound;
import particle.controller.process.MultiplexerBehavior;
import particle.controller.process.PusherBehavior;
import particle.controller.process.RouterBehavior;
import particle.controller.process.SpaceRelativity;
import particle.controller.process.WallGeneratorBehavior;
import particle.view.View;
import particle.model.Model;
import particle.controller.process.Spawn;
import pixi.plugins.app.Application;
import pixi.core.graphics.Graphics;
import pixi.interaction.InteractionEvent;

import pixi.core.sprites.Sprite;
import js.Browser;
import particle.controller.process.Move;
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
		backgroundColor = 0x000000;
		//transparent = true;
		antialias = false;
		onUpdate = _animate;
		super.start();
		
		
		_oModel = new Model();
		_oView = new View( _oModel, stage, this.renderer.plugins.interaction);
		
		
		new Presenter( _oModel, _oView );
		_aProcess = [
			new MapBound( _oModel, _oView ), 
			new Move( _oModel, _oView ), 
			new Spawn( _oModel, _oView ), 
			//new SpaceRelativity( _oModel, _oView ),
			new GeneratorSpawnBehavior( _oModel, _oView ),
			new PusherBehavior( _oModel, _oView ),
			new RouterBehavior( _oModel, _oView ),
			new WallGeneratorBehavior( _oModel, _oView ),
			new FabricatorBehavior( _oModel, _oView ),
			new MultiplexerBehavior( _oModel, _oView ),
		];

		new DragDrop( _oModel, _oView, cast _aProcess[0] );
		new Zoom( _oView );
		new Rotate(_oModel, _oView );
		
		
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
		trace('setting up');
		var bProcessing = false;
		var t = null;
		t = Browser.window.setInterval(function() {
			if ( bProcessing == true )
				trace('[WARNING] skipping processing');
			bProcessing = true;
			//try {
				for ( oProcess in _aProcess ) 
					oProcess.process();
			//} catch ( e :Dynamic ) {
				//Browser.window.clearInterval(t);
				//throw e;
			//}
			bProcessing = false;
		},50);
		//var timer = new haxe.Timer(1000); // 1000ms delay
		//timer.run = 
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