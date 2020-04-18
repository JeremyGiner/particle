package particle.controller;
import js.Browser;
import js.html.DirectionSetting;
import js.html.KeyboardEvent;
import js.html.MouseEvent;
import particle.model.Direction;
import particle.model.Model;
import particle.model.Particle;
import particle.view.ParticleView;
import particle.view.View;
import pixi.interaction.InteractionEvent;
import pixi.interaction.InteractionManager;
import space.Vector2i;

/**
 * ...
 * @author 
 */
class Rotate extends Controller {

	var mouse_x :Int;
	var mouse_y :Int;
	
	
	public function new( oModel :Model, oView :View ) {
		super(oModel, oView);
		
		Browser.window.addEventListener('mousemove', function( event :MouseEvent ) {
			mouse_x = event.clientX;
			mouse_y = event.clientY;
		});
		
		Browser.window.addEventListener('keydown', function( event :KeyboardEvent ) {
			if ( event.keyCode != 82 )
				return;
			
			var oPosition = _oView.toGridPosition(mouse_x, mouse_y);
			var oParticle = _oModel.getParticleByPosition( oPosition );
			trace( oPosition );
			if ( oParticle == null )
				return;
			
			oParticle.setDirection( getNextDirection( oParticle.getDirection() ) );
			_oView.updateParticle( oParticle );
		});

	}
	
	public function getNextDirection( oDirection :Direction ) {
		switch( oDirection ) {
			case UP: return Direction.RIGHT;
			case RIGHT: return Direction.DOWN;
			case DOWN: return Direction.LEFT;
			case LEFT: return Direction.UP;
		}
	}
}