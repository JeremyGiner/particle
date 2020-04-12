package haxe.ds;
import sweet.functor.comparator.IComparator;
import sweet.functor.comparator.ReflectComparator;

/**
 * ...
 * @author 
 */
class BalancedTreeFunctor<CKey,CValue> extends BalancedTree<CKey,CValue> {

	var _oComparator :IComparator<CKey>;
	
	public function new( oComparator :IComparator<CKey> = null ) {
		super();
		_oComparator = ( oComparator == null ) ?
			new ReflectComparator<CKey>() :
			oComparator
		;
	}
	
	override function compare(k1:CKey, k2:CKey) {
		return _oComparator.apply( k1, k2 );
	}
	
}