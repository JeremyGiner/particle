package legion.entity;
import legion.component.IComponent;

/**
 * @author 
 */
interface IEntity {
	public function getId() :Null<Int>;
	public function setId( i :Int ) :Void;
	public function getComponent<C>( oClass :Class<C>) :Dynamic;// TOTO:return C
	
	public function removeComponent<C>( oClass :Class<C>) :Dynamic;
	
	public function hasComponent<C>( oClass :Class<C>) :Bool;
	
	public function getComponentAr() :Array<IComponent>;
	
	/**
	 * 
	 * @param	o
	 * @return Componenet previoulsy attached
	 */
	public function setComponent( o :IComponent ) :IComponent;
}