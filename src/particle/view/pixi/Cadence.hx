package particle.view.pixi;

/**
 * ...
 * @author 
 */
class Cadence {

	var _fStart :Float;
	var _fDuration :Float;
	var _bRepeat :Bool;
	
	public function new( fDuration :Float, fStart :Float = null , bRepeat :Bool = true) {
		_fStart = fStart == null ? Date.now().getTime() : fStart;
		_fDuration = fDuration;
		_bRepeat = true;
	}
	
	public function getFrame() {
		var fFrame = 
			( Date.now().getTime() - _fStart) 
			/ _fDuration
		;
		
		if ( _bRepeat )
			fFrame = fFrame % 1;
		else
			fFrame = Math.min(fFrame, 1);
		return fFrame;
	}
	
	public function reset() {
		_fStart = Date.now().getTime();
	}
}