package al.display 
{
	import al.core.AL;
	import al.update.IUpdateObj;
	import aldyahsn.air.update.IUpdateObj;
	import starling.core.RenderSupport;
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.display.Stage;
	import starling.filters.SpotlightFilter;
	
	/**
	 * ...
	 * @author AldyAhsn
	 */
	public class SpriteAL extends Sprite implements IUpdateObj
	{
		private	var _active		: Boolean			= false;
		public function SpriteAL() 
		{
			
		}
		
		public function set active(_act:Boolean){_active = _act;}
		public function get active():Boolean {return _active;}
		
		
		public function update(_dt:Number = -1):void 
		{
			
		}
		
		public function activate()
		{
			_active = true;
			AL.updater.add(this);
		}
		
		public function deactivate()
		{
			_active = false;
			AL.updater.remove(this);
		}
		
		public function pause() {
			_active = false;
		}
	}

}