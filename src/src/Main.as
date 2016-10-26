package 
{
	import al.core.AL;
	import al.ALManager;
	import al.list.Port;
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemIdleMode;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.net.SharedObject;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.Capabilities;
	import flash.system.LoaderContext;
	import flash.system.Security;
	import flash.system.SecurityDomain;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import gimdata.core.config.Config;
	import gimdata.core.config.Music;
	import gimdata.screens.ScreenBattle;
	import gimdata.screens.ScreenMenu;
	import gimdata.screens.ScreenTest;
	import starling.core.Starling;
	import starling.events.SEvent;
	import starling.utils.RectangleUtil;
	import starling.utils.ScaleMode;
	import treefortress.sound.SoundAS;
	
	
	/**
	 * ...
	 * @author Aldy Ahsandin
	 */
	[Frame(factoryClass="WebPreloader")]
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			
			if (stage) init();
            else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Object = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			// set general properties
            var iOS			:Boolean 		= Capabilities.manufacturer.indexOf("iOS") != -1;
            Multitouch.inputMode 			= MultitouchInputMode.TOUCH_POINT;
			Starling.multitouchEnabled 		= true;  // useful on mobile devices
            Starling.handleLostContext 		= !iOS;  // not necessary on iOS. Saves a lot of memory!
            
			// init
			AL.init(480, 320, Port.WEB);
			AL.stageFullWidth				= 640;// this.stage.fullScreenWidth;
			AL.stageFullHeight				= 480;// this.stage.fullScreenHeight;
			AL.viewPort						= RectangleUtil.fit(
												new Rectangle(0, 0, AL.stageWidth, AL.stageHeight), 
												new Rectangle(0, 0, AL.stageFullWidth, AL.stageFullHeight), 
												ScaleMode.SHOW_ALL);
            
			// starling
			AL.starling						= new Starling( ALManager, this.stage, AL.viewPort);
			AL.starling.showStats 			= false;
			AL.starling.stage.stageWidth 	= AL.stageWidth;
			AL.starling.stage.stageHeight 	= AL.stageHeight;
			AL.starling.stage.color 		= 0x0;
			AL.starling.simulateMultitouch 	= true;
			AL.starling.addEventListener(SEvent.ROOT_CREATED, onRootCreated);
			
			// Khusus Mobile
			//NativeApplication.nativeApplication.addEventListener(Event.ACTIVATE, function (e:*):void { 
				//AL.starling.start(); 
				//Music.mute(false);
			//});
            //NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE, function (e:*):void { 
				//AL.starling.stop(true); 
				//Music.mute(true);
			//} );
			//NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.KEEP_AWAKE;
			
			// text
			var myFormat:TextFormat = new TextFormat();
			myFormat.size = 15;
			myFormat.bold = true;
			myFormat.color = 0xFFFFFF;
			
			IDI.myText = new TextField();
			IDI.myText.defaultTextFormat = myFormat;
			IDI.myText.width = 640;
			IDI.myText.height = 480;
			IDI.myText.x = 180;
			IDI.myText.y = 160;
			IDI.myText.text = "> init";
			IDI.myText.border = true;
			addChild(IDI.myText);
			
			loadAPI();
			
		}
		
		private function onRootCreated(_e:SEvent, _myManager:ALManager)
		{
			AL.starling.removeEventListener(SEvent.ROOT_CREATED, onRootCreated);
			AL.starling.start();
			_myManager.start(ScreenMenu);
			
		}
		
		// ----------------------------------------------------------------------------------------------
		// ID.NET
		
		// please read http://dev.id.net/docs/actionscript/ for details about this example
		private var appID = ''; // your application id
		private var verbose = true; // display idnet messages
		private var showPreloader = false; // Display Traffic Flux preloader ad
		
		private function loadAPI():void 
		{
			var loaderContext:LoaderContext = new LoaderContext();
				loaderContext.applicationDomain = ApplicationDomain.currentDomain;
			
			if (Security.sandboxType != "localTrusted") {
				loaderContext.securityDomain = SecurityDomain.currentDomain;// Sets the security 
			}
			
			var sdk_url:String = "https://www.id.net/swf/idnet-client.swc?="+new Date().getTime();
			var urlRequest:URLRequest = new URLRequest(sdk_url);
			var loader:Loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadComplete, false, 0, true);
				loader.load(urlRequest, loaderContext);
			//IDI.myText.text = "> load API";
		}
		
		private function loadComplete(e:Event)
		{
			//IDI.myText.text = "> load completed";
			
			IDI.idnet = e.currentTarget.content;
			IDI.idnet.addEventListener('IDNET', handlerAPI)
			IDI.idnet.init(stage, appID, '', verbose, showPreloader);
			addChild(IDI.idnet)
			
			
		}
		
		private function handlerAPI(e:Event)
		{
			
			
			// ==============================================
			//
			//
			
			if (IDI.idnet.type == 'login') {
				
				IDI.idnet.retrieveUserData('slotOnline_1');
				IDI.idnet.retrieveUserData('slotOnline_2');
				IDI.idnet.retrieveUserData('slotOnline_3');
				
				// achievements
				//IDI.idnet.retrieveUserData('firstblood');
				//IDI.idnet.retrieveUserData('newbie');
				//IDI.idnet.retrieveUserData('restart');
				//IDI.idnet.retrieveUserData('cinema');
				//IDI.idnet.retrieveUserData('murder');
				//IDI.idnet.retrieveUserData('mafia');
				//IDI.idnet.retrieveUserData('iamtheman');
				//IDI.idnet.retrieveUserData('rambo');
				
				
				if (IDI.belum_login)
					IDI.belum_login.dispatch();
					
			}
			
			//IDI.myText.text = "> API started";
			if (IDI.idnet.type == 'retrieve') {
				
				switch(IDI.idnet.data.key)
				{
					case 'slotOnline_1': 	IDI.m_saveOL_1	= IDI.idnet.data.jsondata;
											break;
					case 'slotOnline_2':	IDI.m_saveOL_2	= IDI.idnet.data.jsondata;
											break;
					case 'slotOnline_3':	IDI.m_saveOL_3	= IDI.idnet.data.jsondata;
											break;
					
					// achievements
					//case 'firstbood': IDI.Firstblood = IDI.idnet.data.jsondata; break;
					//case 'newbie'	: IDI.Newbie = IDI.idnet.data.jsondata;  	break;
					//case 'restart'	: IDI.Restart = IDI.idnet.data.jsondata; 	break;
					//case 'cinema'	: IDI.Cinema = IDI.idnet.data.jsondata; 	break;
					//case 'murder'	: IDI.Murder = IDI.idnet.data.jsondata; 	break;
					//case 'mafia'	: IDI.Mafia = IDI.idnet.data.jsondata; 		break;
					//case 'iamtheman': IDI.Iamtheman = IDI.idnet.data.jsondata; 	break;
					//case 'rambo'	: IDI.Rambo	= IDI.idnet.data.jsondata; 		break;
					
				}
				
			}
		
		}
		
	}
	
}