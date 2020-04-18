package particle.controller.process;
import particle.model.Model;
import particle.model.Particle;
import particle.view.View;
import space.Vector2i;
import sweet.functor.IProcedure;
import haxe.IntTool;
import particle.model.Direction;
import particle.model.ParticleType;

/**
 * ...
 * @author 
 */
class Spawn implements IProcedure {

	var _oModel :Model;
	var _oView :View;
	var _iMax :Int;
	var _iStep :Int;
	
	public function new( oModel :Model, oView :View ) {
		_oModel = oModel;
		_oView = oView;
		_iMax = 200;
		_iStep = 1;
		
		
		_oModel.addParticle(new Particle(
			new Vector2i(25,25),
			new Vector2i(),
			ParticleType.generator
		));
		_oModel.addParticle(new Particle(
			new Vector2i(31,30),
			new Vector2i(),
			ParticleType.wall_generator
		));
		_oModel.addParticle(new Particle(
			new Vector2i(30,30),
			new Vector2i(),
			ParticleType.fabricator
		));
	}
	
	
	public function process() {
		return;
		var iDelta = _iMax - _oModel.getParticleCount();
		if ( iDelta <= 0 )
			return;
		for ( i in 0...IntTool.min( iDelta, _iStep) ) {
			var oParticle = createParticle();
			
			// Case : no enought space
			var oPrevious = _oModel.getParticleByPosition( oParticle.getPosition() );
			if ( oPrevious != null )
				continue;
				
				
			_oModel.addParticle( oParticle );
		}
	}
	
	public function createParticle() {
		
		var oGrid = _oModel.getGrid();
		var iDeadZone = Math.floor(oGrid.getWidth() * 0.25); // prevent spawn at corners
		
		// Get random direction
		var oDirection = [Direction.RIGHT, Direction.UP, Direction.LEFT, Direction.DOWN][
			Math.floor(Math.random() * 4)
		];
		
		var oPos :Vector2i = null;
		var oVel :Vector2i = null;
		switch( oDirection ) {
			case UP: 
				oPos = new Vector2i(
					randomBetween( iDeadZone, oGrid.getWidth() - iDeadZone  ),
					oGrid.getHeight()
				);
				oVel = new Vector2i(
					randomBetween( -1, 1 ),
					-1
				);
			case DOWN: 
				oPos = new Vector2i(
					randomBetween( iDeadZone, oGrid.getWidth() - iDeadZone  ),
					0
				);
				oVel = new Vector2i(
					randomBetween( -1, 1 ),
					1
				);
			case RIGHT: 
				oPos = new Vector2i(
					oGrid.getWidth(),
					randomBetween( iDeadZone, oGrid.getHeight() - iDeadZone  )
				);
				oVel = new Vector2i(
					-1,
					randomBetween( -1, 1 )
				);
			case LEFT: 
				oPos = new Vector2i(
					0,
					randomBetween( iDeadZone, oGrid.getHeight() - iDeadZone  )
				);
				oVel = new Vector2i(
					1,
					randomBetween( -1, 1 )
				);
				
		}
		return new Particle( oPos, oVel );
		
	}
	
	public function randomBetween( min :Int, max :Int ) {
		
		return Math.floor( Math.random() * (max+1) ) + min;
	}
}