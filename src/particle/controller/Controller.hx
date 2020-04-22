package particle.controller;
import haxe.Timer;
import haxe.ds.StringMap;
import particle.controller.process.FabricatorBehavior;
import particle.controller.process.GeneratorSpawnBehavior;
import particle.controller.process.MapBound;
import particle.controller.process.Move;
import particle.controller.process.MultiplexerBehavior;
import particle.controller.process.PusherBehavior;
import particle.controller.process.RouterBehavior;
import particle.controller.process.Spawn;
import particle.controller.process.WallGeneratorBehavior;
import sweet.functor.IProcedure;

/**
 * ...
 * @author 
 */
class Controller extends AController {

	var _aProcess :StringMap<IProcedure>;
	var _oTimer :Timer;
	var _bProcessing :Bool;
	
//_____________________________________________________________________________
//	Constructor
	
	override public function init() {
		
		_oTimer = null;
		
		new Presenter( this );
		_aProcess = [
			'MapBound' => new MapBound( _oModel, _oView ), 
			'Move' => new Move( _oModel, _oView ), 
			'Spawn' => new Spawn( _oModel, _oView ), 
			//new SpaceRelativity( _oModel, _oView ),
			'GeneratorSpawnBehavior' => new GeneratorSpawnBehavior( _oModel, _oView ),
			'PusherBehavior' => new PusherBehavior( _oModel, _oView ),
			'RouterBehavior' => new RouterBehavior( _oModel, _oView ),
			'WallGeneratorBehavior' => new WallGeneratorBehavior( _oModel, _oView ),
			'FabricatorBehavior' => new FabricatorBehavior( _oModel, _oView ),
			'MultiplexerBehavior' => new MultiplexerBehavior( _oModel, _oView ),
		];
		
		// SubController
		new Zoom( _oView );
		new Rotate(_oModel, _oView );
		new DragDrop( _oModel, _oView, cast _aProcess.get('Move') );
		
		_bProcessing = false;
	}
	
//_____________________________________________________________________________
//	Accessor
	
	public function getModel() {
		return _oModel;
	}
	
	public function getView() {
		return _oView;
	}

	
	
//_____________________________________________________________________________
//	Modifier


	
//_____________________________________________________________________________
//	Process
	
	public function processGameStep() {
		if ( _bProcessing == true )
			throw 'overlapping step';
		_bProcessing = true;
		
		
		if ( _oTimer != null ) {
			_oTimer.stop();
			_oTimer = null;
		}
		
		for ( oProcess in _aProcess ) 
			oProcess.process();
		
		if ( _oModel.getSpeed() > 0 ) {
			
			_oTimer = Timer.delay(
				processGameStep, 
				Math.ceil( 50 / _oModel.getSpeed() )
			);
		}
		
		_bProcessing = false;
	}
	
}