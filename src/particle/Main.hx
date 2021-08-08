package particle;

import h3d.mat.Texture;
import legion.GameState;
import legion.system.Render;
import particle.controller.DragDrop;
import particle.controller.Zoom;
import particle.entity.atom.Extractor;
import particle.entity.atom.MasterCrane;
import particle.entity.atom.RawSolid;
import particle.tool.Matter;
import particle.view.HeapsApp;
import space.Vector2i;

import haxe.ds.IntMap;
import sweet.functor.IProcedure;
import legion.entity.IEntity;
import particle.entity.Worldmap;


/**
 * ...
 * @author 
 */
class Main extends HeapsApp {
	
	static var _oInstance :Main;
	
	var _aProcess :Array<IProcedure>;
	
	var _oGame :ParticleGameState;
	var _oWorldmap :Worldmap;
	
//_____________________________________________________________________________
// Boot

	static public function main() {
		_oInstance = new Main();
	}
	
//_____________________________________________________________________________
// Constructor

	override function init() {
		super.init();
		
		_oGame = new ParticleGameState();
		
		_aProcess = [
			new Render( _oGame, this ),
			//new ChildEntityRegistrer( this ),
			//new Mobility( this ),
		];
		
		// User interaction
		new Zoom( this );
		new DragDrop( _oGame, this );
		
		_oGame.addEntity( new Worldmap() );
		_oGame.addEntity( new MasterCrane( new Vector2i() ) );
		_oGame.addEntity( new Extractor( new Vector2i(2,0) ) );
		_oGame.addEntity( new RawSolid( new Vector2i( 1, 0 ), [
			Matter.rock,
			Matter.sand,
			Matter.water,
		] ) );
		_oGame.addEntity( new RawSolid( new Vector2i( 0, 1 ), [
			Matter.rock,
			Matter.sand,
			Matter.water,
		]) );
		
		
		
		
	}
	
//_____________________________________________________________________________
// Singleton
	
	static public function get() {
		return _oInstance;
	}
	
//_____________________________________________________________________________
// Process
	
	override function update(dt:Float) {
		_oGame.update( dt );
		for ( oProcess in _aProcess )
			oProcess.process();
	}

}