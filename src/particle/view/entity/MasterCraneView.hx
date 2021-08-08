package particle.view.entity;
import hxd.Event;
import h2d.Graphics;
import h2d.Object;
import particle.component.ManualCrane;
import particle.component.Position;
import particle.entity.atom.MasterCrane;
import particle.view.AtomView;
import space.Vector2f;
import hxd.Event.EventKind;

/**
 * ...
 * @author 
 */
class MasterCraneView extends AEntityView {
	
	public function new( o :MasterCrane ) {
		super( o );
		// TODO : redraw head on mouse move
		/*
		hxd.Window.getInstance().addEventTarget(function( event :Event ) {
			if ( event.kind != EventKind.EMove )
				return;
			update();
		});
		*/
	}
	
	
	override public function update( f :Float ) {
		
		var oEntity = _oOwner;
		
		this.removeChildren();
		// TODO : draw base
		// Draw base
		var oBody = new Graphics();
		oBody.beginFill(0x00FF00);
		oBody.drawRect(0.4, 0, 0.2, 1);
		oBody.endFill();
		this.addChild(oBody);
		
		// Get mouse pos rel to crane pivot
		var oPos = oEntity.getComponent(Position);
		var oMouse = new Vector2f(
			oPos.x + 0.5 - Main.get().s2d.mouseX,
			oPos.y + 0.5 - Main.get().s2d.mouseY
		);
		
		var oPivot = new Object();
		oPivot.setPosition( 0.5, 1 );
		this.addChild( oPivot );
		
		var fLength = oMouse.length_get();// TODO : apply max reach
		var oHead = new Graphics();
		oHead.beginFill(0x00FF00);
		oHead.drawRect(-0.1, 0, 0.2, fLength);
		oHead.endFill();
		oHead.rotate( oMouse.angleAxisXY() + 1.570796 );
		oPivot.addChild( oHead );
		
		var oGrapple = new Graphics();
		oGrapple.setPosition(-oMouse.x, -oMouse.y);
		oGrapple.beginFill(0x006600);
		oGrapple.drawRect(-0.5, -0.5, 1, 0.5);
		oGrapple.endFill();
		oPivot.addChild( oGrapple );
		
		// Draw Grapple content
		var oCrane = oEntity.getComponent(ManualCrane);
		if( oCrane.getContent() != null )
			oGrapple.addChild( new AtomView( oCrane.getContent() ) );
	}
	
}