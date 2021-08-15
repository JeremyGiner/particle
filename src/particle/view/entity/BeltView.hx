package particle.view.entity;
import h2d.Graphics;
import h2d.Object;
import h2d.Text;
import h3d.mat.Texture;
import legion.component.IComponent;
import legion.entity.IEntity;
import particle.component.Position;
import particle.tool.StringStream;
import particle.view.pixi.Animation;
import particle.view.AnimationInfo;
import space.Vector2f;
import sys.io.File;
import trigger.IObserver;

/**
 * ...
 * @author 
 */
class BeltView extends AEntityView {
	
	
	
//_____________________________________________________________________________
//	Constructor
	
	
	public function new( o :IEntity ) {
		super( o );
		
		// draw body
		
		addChild( createBody() );
		
	}
	
//_____________________________________________________________________________
//	Accessor

	
	
//_____________________________________________________________________________
//	Updater
	
	public function createBody() {
		
		
		var _oBody = new Graphics();
		
		
		//__________________
		// Default box
		
		_oBody.beginFill(0x666666, 1);
		_oBody.drawRect( -0.5, -0.5, 1, 1);
		_oBody.endFill();
		_oBody.beginFill(0xFF0000, 1);
		_oBody.drawCircle( 0,0, 0.5, 3);
		_oBody.endFill();
		
		var tf = new Text(hxd.res.DefaultFont.get());
		tf.text = '#' + _oOwner.getId();
		tf.scale(0.1);
		tf.scaleY = -0.1;
		_oBody.addChild( tf );
		
		return _oBody;
	}
	
	
	override public function onComponentAttach(o:IComponent) {
		if ( Std.is(o, Position) )
			addChild( createBody() );
		super.onComponentAttach(o);
	}
	
	override public function onComponentRemove( o:IComponent ) {
		if ( Std.is(o, Position) )
			this.removeChildren();
	}
	
	
	
	
	/*
	public function drawSquare( o :Graphics, fSize :Float ) {
		
		o.drawRect( 
			-fSize / 2, 
			-fSize / 2, 
			fSize, 
			fSize
		);
	}*/
	
}