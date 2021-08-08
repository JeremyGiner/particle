package particle.view.entity;
import h2d.Graphics;
import h2d.Object;
import h2d.Text;
import h3d.mat.Texture;
import legion.component.IComponent;
import legion.entity.IEntity;
import particle.component.Position;
import particle.view.pixi.Animation;
import particle.view.AnimationInfo;
import trigger.IObserver;

/**
 * ...
 * @author 
 */
class RawSolidView extends AEntityView {
	
	var _aAnimation :Array<AnimationInfo>;
	
	static var BORDER_WIDTH = 0.2;
	
	
	
//_____________________________________________________________________________
//	Constructor
	
	
	public function new( o :IEntity ) {
		super( o );
		
		_aAnimation = [];
		
		//_oContainer.addChild( DebugTool.createAnchor() );
		
		// draw body
		
		addChild( createBody() );
		
		// draw velocity
		/*
		_oVelocity = new Graphics();
		_oVelocity.lineStyle(2, 0xFFFFFF,1);
		_oVelocity.beginFill(0x35CC5A, 1);
		_oVelocity.moveTo(0, 0);
		_oVelocity.lineTo( 
			_oAtom.getVelocity().x, 
			_oAtom.getVelocity().y  
		);
		_oVelocity.endFill();
		_oContainer.addChild(_oVelocity);
		*/
		
	}
	
//_____________________________________________________________________________
//	Accessor

	
	public function getAnimationAr() {
		return _aAnimation;
	}
	
	public function getTypeColor() {
		return 0x666666;
	}
	
	
//_____________________________________________________________________________
//	Updater
	
	public function createBody() {
		
		// Default box
		var _oBody = new Graphics();
		_oBody.beginFill(getTypeColor(), 1);
		_oBody.drawRect( 0,0,1,1);
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