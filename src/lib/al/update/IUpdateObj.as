package al.update 
{
	
	/**
	 * Interface of update objects
	 * @author AldyAhsandin
	 */
	public interface IUpdateObj {
		function get active():Boolean;
		function update(_dt:Number = -1):void;
	}
	
}