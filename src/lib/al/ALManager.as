package al 
{
	import adobe.utils.CustomActions;
	import al.core.AL;
	import al.core.Ast;
	import al.display.ScreenAL;
	import al.display.SpriteAL;
	import al.list.Port;
	import al.model.GameLooper;
	import al.objects.ProgressBar;
	import com.greensock.plugins.TweenPlugin;
	import com.greensock.plugins.ShakeEffect;
	import com.greensock.TweenMax;
	import flash.filesystem.File;
	import flash.geom.Rectangle;
	import gimdata.core.config.Music;
	import gimdata.objects.achievements.MyAchievements;
	import plugins.ShakeEffect;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.SEvent;
	import starling.events.KeyboardEvent;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.formatString;
	import starling.utils.RectangleUtil;
	import starling.utils.ScaleMode;
	
	/**
	 * ...
	 * @author Aldy Ahsandin
	 */
	public class ALManager extends Sprite 
	{
		private var m_progressBar	: ProgressBar = null;
		private	var m_activeWorld	: Sprite;
		public 	var m_firstScreen	: Class;
		private var m_pleaseTxt		: TextField;
		
		private var m_container		: SpriteAL;
		private var m_achievements	: MyAchievements
		
		private var m_logoPC		: Image;
		
		[Embed(source = "../../bin/assets/textures/menuScreen/title2.png")]
		private static const title:Class;
		
		
		public function ALManager() 
		{
			
		}
		
		public function start(_firstScreen:Class)
		{
			removeEventListener(SEvent.ADDED_TO_STAGE, start);
			
			// --------------------------------------------------------
			// set framerate to 30 in software mode
            if (AL.starling.context.driverInfo.toLowerCase().indexOf("software") != -1)
                AL.starling.nativeStage.frameRate = 30;
			
			AL.globalStage				= this.stage;
			
			m_container					= new SpriteAL();
			m_achievements				= new MyAchievements();
			m_firstScreen				= _firstScreen;	
			addChild(m_container);
			
			m_progressBar				= new ProgressBar(150, 10);
			m_progressBar.pivotX		= m_progressBar.width / 2;
			m_progressBar.pivotY		= m_progressBar.height / 2;
			m_progressBar.y				= AL.halfStageHeight;
			m_progressBar.x				= AL.halfStageWidth;
			m_progressBar.visible		= false;
			addChild(m_progressBar);
			
			m_pleaseTxt		= new TextField(AL.stageWidth, AL.stageHeight / 5, "Building Assets ...", "Verdana", 20, 0xFFFFFF, true);
			m_pleaseTxt.y	=  AL.stageHeight - m_pleaseTxt.height;
			m_pleaseTxt.visible = false;
			addChild(m_pleaseTxt);
			
			var _texture:Texture = Texture.fromEmbeddedAsset(title);
			m_logoPC		= new Image(_texture);
			m_logoPC.scaleX	= 0.8;
			m_logoPC.scaleY	= 0.8;
			//m_logoPC.pivotX	= m_logoPC.width / 2;
			//m_logoPC.pivotY	= m_logoPC.height / 2;
			m_logoPC.x		= 240 - m_logoPC.width/2;
			m_logoPC.y		= 70;
			
			//addChild(m_logoPC);
			
			addChild(m_achievements);
			// --------------------------------------------------------
			
			if (AL.port == Port.WEB) {
				load_withFP	(EmbeddedAssets, onLoad);
			}
			else						{
				var _scaleFactor: int 		= AL.viewPort.width <= 480 ? 1 : 2; // midway between 320 and 640
				var _urlSystem	: String	= "system/";
				var _urlData	: String	= "data/";
				var _urlAudio	: String	= "assets/audio";
				//var _urlFont	: String	= formatString("assets/fonts/{0}x", _scaleFactor);
				//var _urlImg		: String	= formatString("assets/textures/{0}x", _scaleFactor);
				var _urlFont	: String	= "assets/fonts/";
				var _urlImg		: String	= "assets/textures/";
				
			
				load_withAir(new Array( _urlSystem, _urlData, _urlAudio, _urlFont, _urlImg), onLoad );
									
			}
		}
		
		public function showScreen(_worldALClass:Class):void
        {
            if (m_activeWorld) 
				m_activeWorld.removeFromParent(true);
			m_activeWorld = new _worldALClass(this);
            m_container.addChild(m_activeWorld);
        }
		
		// ---------------------------------------------------------------------
		// Basic Function
		// ---------------------------------------------------------------------
		
		private function load_withAir( folderData:Array, _function:Function) 
		{
			/**
			 * PERHATIAN!!:
				 * Untuk menggunakan air (mobile version), uncomment fungsi di bawah ini
				 * set Port.ke mobile
				 * set documen class ke main
				 * set stagefull weight dan full height
				 * comment all embedded asset
			 */
			//var appDir:File	= File.applicationDirectory;
			//for (var i:int 	= 0; i < folderData.length; i++) 
			//AL.assets.enqueue(appDir.resolvePath(folderData[i]));
			//AL.assets.loadQueue(_function);
		}
		
		private function load_withFP(_embedClass: Class, _function:Function )
		{
			/**
			 * PERHATIAN!!:
				 *	Untuk menggunakan flash player comment fungsi load_withAir 
				 * 	Jangan lupa tambahkan compiler argument. 
					Project	-> Properties -> Compiler Options -> Additional Compiler Options
					"-frame StartupFrame Main"
			 */
			AL.assets.enqueue(_embedClass);
			AL.assets.loadQueue(_function);
		}
		
		private function onLoad(ratio:Number)
		{
			trace("> LOADING: "+(int(ratio * 100))+"%");
			m_pleaseTxt.text = "Building Assets ..." + (int(ratio * 100)) + "%";
			
			if (AL.port != Port.WEB) {
				if (!m_progressBar.visible) {
					m_progressBar.visible 	= true;
					m_progressBar.ratio 	= ratio;					
				}
			} else {
				if (!m_pleaseTxt.visible)
				m_pleaseTxt.visible = true;
			}
			
			if (ratio == 1.0) {
				if (m_firstScreen) {
					
					//m_logoPC.visible = false;
					m_progressBar.visible = false;
					m_pleaseTxt.text = "Connecting Online Data"
					
					TweenMax.to(m_progressBar, 0.5, { scaleX:0.1, alpha:0 } );
					TweenMax.delayedCall(1, function() {
						m_pleaseTxt.visible = false;					
						m_progressBar.visible = false;
						Music.init();
						showScreen(m_firstScreen);
					})
				}
			}
		}
		
		// ---------------------------------------------------------------------
		
	}

}