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
		
		
		var _oBody = new Graphics();
		
		//__________________
		/*
		var s = File.getContent('res/test.svg');
		var xml = Xml.parse( s );
		
		
		function getFirst<C>( o :Iterator<C> ) :C {
			if ( ! o.hasNext() ) throw '!!!';
			return o.next();
		}
		var oSvg = getFirst( xml.elementsNamed('svg') );
		var oDefs = getFirst( oSvg.elementsNamed('defs') );
		var oGroup = getFirst( oSvg.elementsNamed('g') );
		for ( oChild in oGroup.elements() ) {
			if ( oChild.nodeName == 'rect' ) {
				_oBody.beginFill( 0xFF0000, 1 );// TODO
				_oBody.drawRect(
					Std.parseInt( oChild.get('x') ),
					Std.parseInt( oChild.get('y') ),
					Std.parseInt( oChild.get('height') ),
					Std.parseInt( oChild.get('width') )
				);
				_oBody.endFill();
			}
			if ( oChild.nodeName == 'path' ) {
				
				var oFirstPoint = null;
				_oBody.beginFill( 0xFF0000, 1 );// TODO
				var s = new StringStream( oChild.get('d') );
				s.ignoreWhitespace();
				trace( s.getRemaining() );
				switch( s.read(1) ) {
					case 'M':
						while( StringStream.isNum( s.charAt(0) )  ) {
							s.ignoreWhitespace();
							var x = Std.parseFloat( s.getNextFloat() );
							s.ignoreWhitespace();
							s.eat(',');
							s.ignoreWhitespace();
							var y = Std.parseFloat( s.getNextFloat() );
							
							if ( oFirstPoint == null )
								oFirstPoint = new Vector2f(x,y);
							_oBody.moveTo( x, y );
						}
					case 'Z':
						_oBody.moveTo( oFirstPoint.x, oFirstPoint.y );
					default:
						throw 'Invalid '+s.getRemaining();
				}
				_oBody.endFill();
			}
		}*/
		
		//__________________
		// Default box
		
		_oBody.beginFill(getTypeColor(), 1);
		_oBody.drawRect( -0.5,-0.5,1,1);
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