package  
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.system.Security;
	import flash.system.SecurityDomain;
	import flash.text.TextField;
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author Aldy Ahsandin
	 */
	public class IDI extends MovieClip 
	{
		
		public static var idnet;
        public static var myText:TextField;
		
		public static var m_saveOL_1:String ="";
		public static var m_saveOL_2:String ="";
		public static var m_saveOL_3:String ="";
		
		public static var Firstblood:Boolean =  false
		public static var Newbie	:Boolean =  false
		public static var Restart	:Boolean =  false
		public static var Cinema	:Boolean =  false
		public static var Murder	:Boolean =  false
		public static var Mafia		:Boolean =  false
		public static var Iamtheman	:Boolean =  false
		public static var Rambo		:Boolean =  false
		
		public static var belum_login:Signal;
		
		public function IDI() 
		{
			
		}
		
		public static function afterLogin(_func:Function)
		{
			_func();
		}
		
	}

}