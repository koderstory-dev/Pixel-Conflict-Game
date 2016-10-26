package 
{
	import com.bnFontRenderer.BMFont;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	import gimdata.core.config.Config;
	import mx.core.SpriteAsset;
	
	import starling.utils.Color;
	
    // To show a Preloader while the SWF is being transferred from the server, 
    // set this class as your 'default application' and add the following 
    // compiler argument: '-frame StartupFrame Main'
    
    [SWF(width = "640", height = "480", frameRate = "30", backgroundColor = "#0")]
	public class WebPreloader extends MovieClip
	{
		public function WebPreloader(){
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			stop();
		}
		
        private const STARTUP_CLASS:String = "Main";
        
        private var _firstEnterFrame:Boolean;
        private var _preloaderBackground:Shape 
        private var _preloaderPercent:Shape;
		
		
		private var _bgPaper:Bitmap;
		private var _logo:Bitmap;
		private var _logoY8:Bitmap;
		
		// ----------
		// Init
		// ----------
		
		[Embed(source = "../bin/assets/textures/menuScreen/title2.png")]
		public static const logoFront:Class;
		
		[Embed(source="../bin/system/sponsorLogo.png")]
		public static const logoY8:Class;

		[Embed(source="../bin/system/bgPaper.jpg")]
		public static const bgPreloader:Class;
		
		private function onAddedToStage(event:Event):void {
			Config.URL			= stage.loaderInfo.url; trace("URL:"+Config.URL);
			stage.scaleMode 	= StageScaleMode.SHOW_ALL;
            stage.align 		= StageAlign.TOP_LEFT;
            
			_firstEnterFrame 	= true;
			
			_bgPaper			= new bgPreloader();
			_bgPaper.width		= 640;
			_bgPaper.height		= 480;
			addChild(_bgPaper);
			
			
			_logo				= new logoFront();
			//_logo.scaleX		= ;
			//_logo.scaleY		= 0.8;
			_logo.x				= 320 - _logo.width / 2;
			_logo.y				= 120;
			addChild(_logo);
			
			_logoY8				= new logoY8();
			_logoY8.scaleX		= 0.3;
			_logoY8.scaleY		= 0.3;
			_logoY8.x			= 320 - _logoY8.width / 2;
			_logoY8.y			= _logo.y + _logo.height + 40;
			addChild(_logoY8);
			
			
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onPressLogo)
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
            removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onPressLogo(e:MouseEvent):void 
		{
			if (Config.validateDomain_y8()) {
				
			} else {
				var myURL:URLRequest = new URLRequest("http://www.y8.com/?utm_source="+Config.URL+"&utm_medium=g_prelogo&utm_campaign=pixelconflict");
				navigateToURL(myURL, "_blank");
			}
				
		}
        
		private function onEnterFrame(event:Event):void {
            if (_firstEnterFrame) {
                _firstEnterFrame=false;
                if (root.loaderInfo.bytesLoaded >= root.loaderInfo.bytesTotal) {
                    dispose()
                    run()
                } else {
                    beginLoading();
                }
                return;
            }
            //trace(root.loaderInfo.bytesLoaded + "/" + root.loaderInfo.bytesTotal)
            if (root.loaderInfo.bytesLoaded >= root.loaderInfo.bytesTotal) {
                dispose()
                run()
            } else {
                var percent:Number=root.loaderInfo.bytesLoaded / root.loaderInfo.bytesTotal;
                updateLoading(percent);
            }
        }
        
        // this function may never be called if the load is instant
        private function updateLoading(a_percent:Number):void {
            _preloaderPercent.scaleX = a_percent
        }
        
        // this function may never be called if the load is instant
        private function beginLoading():void {
            trace("begin Loading")
            _preloaderBackground = new Shape()
            _preloaderBackground.graphics.beginFill(0x333333)
            //_preloaderBackground.graphics.lineStyle(0,0x000000)
            _preloaderBackground.graphics.drawRect(0,0,200,10)
            _preloaderBackground.graphics.endFill()
            
            //
            _preloaderPercent = new Shape()
            _preloaderPercent.graphics.beginFill(0xFF8B17)
            _preloaderPercent.graphics.drawRect(0,0,200,10)
            _preloaderPercent.graphics.endFill()
            //
            addChild(_preloaderBackground)
            addChild(_preloaderPercent)
            _preloaderBackground.x 	= 220;
            _preloaderBackground.y 	= 235;
			_preloaderPercent.x 	= 220;
			_preloaderPercent.y 	= 235;
            _preloaderPercent.scaleX = 0
        }
        
        private function dispose():void {
            trace("dispose preloader")
            removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.removeEventListener(MouseEvent.MOUSE_DOWN, onPressLogo)
            if (_preloaderBackground){
                removeChild(_preloaderBackground)
            }
            if (_preloaderPercent){
                removeChild(_preloaderPercent)
            }
			if (_logo) {
				removeChild(_logo);
				removeChild(_logoY8);
				removeChild(_bgPaper);
			}
			
			_logo					= null;
            _preloaderBackground 	= null
            _preloaderPercent 		= null
        }
		
		private function run():void 
        {
			nextFrame();
            
			var startupClass:Class = getDefinitionByName(STARTUP_CLASS) as Class;
            if (startupClass == null)
				throw new Error("Invalid Startup class in Preloader: " + STARTUP_CLASS);
			
			var startupObject:DisplayObject = new startupClass() as DisplayObject;
			if (startupObject == null)
				throw new Error("Startup class needs to inherit from Sprite or MovieClip.");
			
			addChildAt(startupObject, 0);
		}
	}
}