package al.core 
{
	import al.list.Port;
	import al.update.Updater;
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	import starling.display.Stage;
	
	import flash.geom.Rectangle;
	import starling.core.Starling;
	import starling.utils.AssetManager;
	/**
	 * ...
	 * @author Aldy Ahsandin
	 */
	public class AL 
	{
		
		// basic
		public	static var starling			: Starling;
		public	static var viewPort			: Rectangle;
		public	static var stageFullWidth	: int;
		public	static var stageFullHeight	: int;
		public	static var stageWidth		: int;
		public	static var stageHeight		: int;
		public	static var halfStageWidth	: Number;
		public	static var halfStageHeight	: Number;
		public	static var globalStage		: Stage;
		
		public	static var assets			: AssetManager;
		public	static var port				: String;
		
		public	static var firstPlaying		: Boolean;
		public 	static var updater			: Updater			= null;
		
		
		public static function init(_width:int, _height:int, _Port:String)
		{
			stageWidth		= _width
			stageHeight		= _height
			halfStageWidth	= stageWidth / 2;
			halfStageHeight	= stageHeight / 2;
			
			assets	 		= new AssetManager();
			assets.verbose 	= true;
			
			port			= _Port;
			
			firstPlaying	= true;
			updater			= new Updater();
			
		}
		
		public static function setCenterX(_obj:DisplayObjectContainer):int {
			return halfStageWidth - _obj.width / 2;
		}
		
		public static function setCenterY(_obj:DisplayObjectContainer):int {
			return halfStageHeight - _obj.height / 2;
		}
		
	}

}