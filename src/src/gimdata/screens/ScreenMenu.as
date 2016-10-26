package gimdata.screens 
{
	import al.ALManager;
	import al.core.AL;
	import al.core.Ast;
	import al.display.ScreenAL;
	import al.objects.Box;
	import com.greensock.easing.Strong;
	import com.greensock.TweenMax;
	import de.flintfabrik.starling.display.FFParticleSystem;
	import de.flintfabrik.starling.display.FFParticleSystem.SystemOptions;
	import de.flintfabrik.starling.utils.ColorArgb;
	import flash.display3D.Context3DBlendFactor;
	import flash.events.Event;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.ui.Mouse;
	import flash.utils.getTimer;
	import gimdata.core.config.Config;
	import gimdata.core.config.Music;
	import gimdata.objects.achievements.AchievementBox;
	import gimdata.objects.level.LevelPhoto;
	import gimdata.objects.save.Save2an;
	import gimdata.objects.save.SaveF2an;
	import gimdata.objects.save.WarningLocalSave;
	import gimdata.objects.save.WarningSave;
	import gimdata.objects.viewReport.GameOver;
	import org.as3collections.maps.HashMap;
	import starling.core.RenderSupport;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Stage;
	import starling.events.SEvent;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.filters.ColorMatrixFilter;
	import starling.filters.ScanlineFilter;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	import treefortress.sound.SoundAS;
	
	/**
	 * ...
	 * @author AldyAhsandin
	 */
	public class ScreenMenu extends ScreenAL 
	{
		public function ScreenMenu(_alManager:ALManager) { super(_alManager); }
		
		override public function start(e:SEvent) {
			
			/* -----------------------------------
			 *  Initial data
			 * ----------------------------------- */ 
			createBG();
			createLevelBox();
			if (!Config.isStarted) {
				createIntro();
				setState(INTRO_BG);
			}
			else startLevel();
			activate();
			
			// -----------------------------
			m_block.visible = false;
			addChild(m_block);
			
			m_text.visible 	= false;
			m_text.y		= AL.stageHeight - m_text.height;
			addChild(m_text);
			
			//activateScanline();
		}
				
		private const INTRO_BG		: String = "IntroBG";
		private const MENU_SCREEN	: String = "MenuScreen";
		private const LEVEL_SCREEN	: String = "LevelScreen";
		
		private var m_stateScreen	: String;
		
		// Menu Screen
		private var m_bgEffect		: Image;
		private var m_bgColor		: Box;
		private var m_bgShadow		: Image;
		private var m_bgWires		: Image;
		private var m_title			: Image;
		private var m_pressStrt		: Button;
		private var m_sensorBG		: Box;
		private var m_txtPlayMore	: TextField;
		
		
		// level
		private	var m_boxInfo		: LevelPhoto;
		private var m_boxCenterX	: int;
		private var m_boxCenterY	: int;
		private var m_borderUp		: Box;
		private var m_borderDown	: Box;
		
		private var m_buttonLeft	: Button;
		private var m_buttonRight	: Button;
		
		// Intro
		private var m_ads			: Box;
		private var m_starterBG		: Image;
		private var m_devIcon		: TextField;
		private var m_sponsorIcon	: TextField;
		private var m_starterBtn	: Button;
		
		private var m_blackBG		: Box;
		private var m_sponsorBG		: Image;
		private var m_devBG			: Image;
		private var m_idnetBG		: Image;
		
		private var m_block		: Box = new Box(AL.stageWidth, AL.stageHeight, 0x0, 0, 0, 0x0);
		private var m_text		:TextField = new TextField(AL.stageWidth, AL.stageHeight / 5, "Please Wait...", "Verdana", 20, 0xFFFFFF, true);
		
		// save2an
		private var m_saveBox : Save2an;
		private var m_backToSave:TextField;
		private var m_progressComplete:TextField;
		private var m_achievements:Button;
		private var m_highscore:Button;
		
		
		// =================================================
		//              Creation Function
		// =================================================
		
		private function createBG():void 
		{
			FFParticleSystem.init(4096, false, 4096, 16);
			
			m_bgEffect										= new Image(Ast.img("bgEffect"));
			m_bgEffect.alpha								= 0.75;
			
			m_sensorBG										= new Box(AL.stageWidth, AL.stageHeight);
			m_sensorBG.alpha								= 0;
			m_sensorBG.addEventListener(TouchEvent.TOUCH, onStartLevel);
			
			// -- objects --
			
			m_bgColor										= new Box(AL.stageWidth, AL.stageHeight, 0xFFAE5E, 0, 0);
			m_bgShadow										= new Image(Ast.img("bgMenu", "bg_shadow"));
			m_bgShadow.y									= AL.stageHeight - m_bgShadow.height;
			m_bgWires										= new Image(Ast.img("bgMenu", "bg_wires"));
			m_bgWires.y										= AL.stageHeight - m_bgWires.height;
			m_title											= new Image(Ast.img("title"));
			m_title.x										= AL.halfStageWidth - m_title.width / 2;
			m_title.y										= AL.halfStageHeight / 12;
			
			
			
			var _colorFilter:ColorMatrixFilter = new ColorMatrixFilter();
				_colorFilter.adjustHue(0.2);
			
			m_pressStrt 									= new Button(Ast.img("uiMenu", "button_long3"), "Start Game");
			m_pressStrt.scaleX								= 0.4;
			m_pressStrt.scaleY								= 0.4;
			m_pressStrt.fontSize							= 30;
			m_pressStrt.x									= AL.halfStageWidth - m_pressStrt.width / 2
			m_pressStrt.y									= AL.stageHeight - (m_pressStrt.height) * 1.7
			m_pressStrt.filter								= _colorFilter;
			m_pressStrt.addEventListener(TouchEvent.TOUCH, onStartLevel);
			
			m_txtPlayMore									= new TextField(120, 20, "Play More Games", "Verdana", 12, 0xFFFFFF);
			m_txtPlayMore.y									= m_pressStrt.y - m_txtPlayMore.height - 5;
			m_txtPlayMore.addEventListener(TouchEvent.TOUCH, onTouchSponsor);
			m_txtPlayMore.visible = false;
			//m_txtPlayMore.border							= true;
			
			
			// -- effects --
			
			var _ashXML		:XML 							= Ast.xml("ash")
			var _ashTexture	:Texture 						= Ast.img("taA", "smokeA_3")
			var _ashEffect	:FFParticleSystem 				= new FFParticleSystem(SystemOptions.fromXML(_ashXML, _ashTexture));
			_ashEffect.emitterX 							= 0;
			_ashEffect.emitterY 							= 0;
			_ashEffect.gravityY								= -1;
			_ashEffect.gravityX 							= 0;
			_ashEffect.alpha								= 1;
			_ashEffect.startSize							= 3;
			
			var _smoke1XML		:XML 						= Ast.xml("smokeScreen")
			var _smoke1Texture	:Texture 					= Ast.img("taA", "smokeB_3")
			var _smoke1Effect	:FFParticleSystem 			= new FFParticleSystem(SystemOptions.fromXML(_smoke1XML, _smoke1Texture));
			_smoke1Effect.emitterX 							= AL.stageWidth;
			_smoke1Effect.emitterY 							= AL.stageHeight;
			_smoke1Effect.gravityY							= -3;
			_smoke1Effect.gravityX 							= 0;
			_smoke1Effect.alpha								= 0.5;
			_smoke1Effect.startSize							= 100;
			_smoke1Effect.speed								= 10;
			
			var _fireInTheCityXML		:XML 				= Ast.xml("fire")
			var _fireInTheCityTexture	:Texture 			= Ast.img("taA", "smokeB_10")
			var _fireInTheCityEffect	:FFParticleSystem 	= new FFParticleSystem(SystemOptions.fromXML(_fireInTheCityXML, _fireInTheCityTexture));
			_fireInTheCityEffect.emitterX 					= AL.halfStageWidth;
			_fireInTheCityEffect.emitterY 					= AL.stageHeight*3/4;
			_fireInTheCityEffect.gravityY					= 0;
			_fireInTheCityEffect.gravityX 					= 0;
			_fireInTheCityEffect.alpha						= 0.9;
			_fireInTheCityEffect.speed						= 0;
			_fireInTheCityEffect.startSize					= 1;
			
			var _fireXML		:XML 						= Ast.xml("burningHouseRight")
			var _fireTexture	:Texture 					= Ast.img("taA", "smokeA_12")
			var _fireEffect		:FFParticleSystem 			= new FFParticleSystem(SystemOptions.fromXML(_fireXML, _fireTexture));
			_fireEffect.emitterX 							= AL.halfStageWidth/5;
			_fireEffect.emitterY 							= AL.stageHeight;
			_fireEffect.gravityY							= -5;
			_fireEffect.gravityX 							= 0;
			_fireEffect.alpha								= 0.5;
			_fireEffect.lifespan							= 20;
			_fireEffect.speed								= 10;
			
			var _dustXML		:XML 						= Ast.xml("dust")
			var _dustTexture	:Texture 					= Ast.img("taA", "smokeA_12")
			var _dustEffect		:FFParticleSystem 			= new FFParticleSystem(SystemOptions.fromXML(_dustXML, _dustTexture));
			
			m_sponsorBG			= new Image(Ast.img("sponsorLogo"));
			m_sponsorBG.scaleX	= 0.15;
			m_sponsorBG.scaleY	= 0.15;
			m_sponsorBG.x		= 20;
			m_sponsorBG.y		= AL.stageHeight - m_sponsorBG.height - 20;
			m_sponsorBG.addEventListener(TouchEvent.TOUCH, onTouchSponsor);
			
			m_idnetBG			= new Image(Ast.img("idnet_logo"));
			m_idnetBG.scaleX	= 0.2;
			m_idnetBG.scaleY	= 0.2;
			m_idnetBG.x			= AL.stageWidth - 20 - m_idnetBG.width;
			m_idnetBG.y			= AL.stageHeight - m_idnetBG.height - 27;
			m_idnetBG.addEventListener(TouchEvent.TOUCH, onTouchSponsor);
			
			
			_smoke1Effect.start();
			_fireInTheCityEffect.start();
			_fireEffect.start();
			_ashEffect.start();
			
			add(m_bgColor);
			add(m_bgEffect);
			add(_fireInTheCityEffect);
			add(m_bgShadow);
			add(_smoke1Effect);
			add(_ashEffect);
			add(_fireEffect);
			add(m_bgWires);
			add(m_title);
			add(m_pressStrt);
			add(m_txtPlayMore);
			
			//add(m_sensorBG);
			
			
		}
		
		
		private function createLevelBox():void 
		{
			
			m_borderUp				= new Box(AL.stageWidth, 50, 0x0, 0, 0);
			m_borderUp.y			= - m_borderUp.height;
			m_borderUp.alpha		= 0;
			m_borderDown			= new Box(AL.stageWidth, 50, 0x0,0,0);
			m_borderDown.y			= AL.stageHeight;
			m_borderDown.alpha		= 0;
			
			m_boxInfo 				= new LevelPhoto();
			m_boxInfo.alpha			= 0;
			m_boxCenterX			= AL.setCenterX(m_boxInfo);
			m_boxCenterY			= AL.setCenterY(m_boxInfo);
			m_boxInfo.x				= m_boxCenterX;
			m_boxInfo.y				= m_boxCenterY+10;
			m_boxInfo.playBattle.add(onTouchPlayBattle);
			
			m_buttonLeft			= new Button(Ast.img("direction", "arrow"), "", Ast.img("direction", "arrowClicked")); 
			m_buttonRight			= new Button(Ast.img("direction", "arrow"), "", Ast.img("direction", "arrowClicked"));
			
			m_buttonLeft.scaleX		= -1;
			m_buttonLeft.x			= m_buttonLeft.width+10;
			m_buttonLeft.y			= AL.halfStageHeight - m_buttonLeft.height / 2 - 20;
			m_buttonRight.x			= AL.stageWidth - m_buttonRight.width-10;
			m_buttonRight.y			= AL.halfStageHeight - m_buttonRight.height / 2 - 20;
				
			m_backToSave = new TextField(80, 35, "< back", "badabom", 30, 0xFFFFFF);
			m_backToSave.addEventListener(TouchEvent.TOUCH, onTouchBack);
			m_backToSave.visible = false;
			
			
			// --------------------------------
			
			add(m_boxInfo);
			add(m_buttonLeft)
			add(m_buttonRight)
			add(m_borderUp);
			add(m_borderDown);
			add(m_backToSave);
			
			m_boxInfo.visible		= false;
			m_borderUp.visible		= false;
			m_borderDown.visible	= false;
			m_buttonLeft.visible	= false;
			m_buttonRight.visible	= false;
			
			m_buttonLeft.addEventListener(TouchEvent.TOUCH, onTouchBtnLevel);
			m_buttonRight.addEventListener(TouchEvent.TOUCH, onTouchBtnLevel);
			
			add(m_sponsorBG);
			add(m_idnetBG);
			
		}
		
		private function createIntro():void 
		{
			m_starterBG			= new Image(Ast.img("bgPaper"));	
			m_starterBG.alpha	= 0;
			m_starterBG.width	= AL.stageWidth;
			m_starterBG.height	= AL.stageHeight;
			m_ads				= new Box(200, 200, 0xB35900, 5, 1, 0x0);
			m_ads.x				= AL.setCenterX(m_ads);
			m_ads.y				= AL.setCenterY(m_ads) - 10;
			m_ads.alpha			= 0;
			m_devIcon			= new TextField(100, 100, "Developer\nLogo", "badabom", 28, 0xFFFFFF)
			//m_devIcon.border	= true;
			m_devIcon.x			= AL.stageWidth - m_devIcon.width - 15;
			m_devIcon.y			= AL.setCenterY(m_devIcon);
			m_devIcon.alpha		= 0;
			m_sponsorIcon		= new TextField(100, 100, "Sponsor\nLogo", "badabom", 28, 0xFFFFFF);
			//m_sponsorIcon.border= true;
			m_sponsorIcon.x		= 15;
			m_sponsorIcon.y		= AL.setCenterY(m_sponsorIcon);
			m_sponsorIcon.alpha	= 0;
			m_starterBtn		= new Button(Ast.img("btnPlayGame"), "Start");
			m_starterBtn.fontName		= "badabom"
			m_starterBtn.fontColor 		= 0xFFFFFF;
			m_starterBtn.fontSize		= 27;
			m_starterBtn.scaleWhenDown 	= 0.6;
			m_starterBtn.scaleX			= 0.7;
			m_starterBtn.scaleY			= 0.7;
			m_starterBtn.x				= AL.setCenterX(m_starterBtn);
			m_starterBtn.y				= m_ads.y + m_ads.height + 5;
			m_starterBtn.alpha			= 0;
			m_starterBtn.addEventListener(TouchEvent.TOUCH, onStartMenu);
			
			m_blackBG			= new Box(AL.stageFullWidth, AL.stageFullHeight, 0x0, 0, 0);
			
			m_devBG				= new Image(Ast.img("developerLogo"));
			m_devBG.alpha		= 0;
			m_devBG.scaleX		= 0.7;
			m_devBG.scaleY		= 0.7;
			m_devBG.x			= AL.halfStageWidth - m_devBG.width/2;
			m_devBG.y			= AL.halfStageHeight - m_devBG.height/2;
			m_devBG.addEventListener(TouchEvent.TOUCH, onTouchDeveloper);
			
			//m_txtConnectingData.
			
			// intro movie
			add(m_blackBG);
			//add(m_devBG);
			//add(m_sponsorBG);
			
			//starter bg ga pake strater
			//add(m_starterBG);
			//add(m_ads);
			//add(m_devIcon);
			//add(m_sponsorIcon);
			//add(m_starterBtn);
			
			
			//TweenMax.to(m_starterBG, 	0.5, { alpha:1, delay:0.0 } );
			//TweenMax.to(m_sponsorIcon, 	0.5, { alpha:1, delay:0.8 } );
			//TweenMax.to(m_ads,		 	0.5, { alpha:1, delay:1.0 } );
			//TweenMax.to(m_devIcon, 		0.5, { alpha:1, delay:0.8 } );
			//TweenMax.to(m_starterBtn, 	0.5, { alpha:1, delay:1.5 } );
			m_txtConnectingData.text = "Please Wait ..."
			m_txtConnectingData.x = 0;
			m_txtConnectingData.y	=  AL.stageHeight - m_txtConnectingData.height;
			add(m_txtConnectingData);
			
			
			startMenu();
		}
		
		// =================================================
		//         				Update
		// =================================================
		
		private var m_prevTime : int = 0;
		override public function update(_dt:Number = -1):void 
		{
			//---------------------------------------
			// Update Background
			//---------------------------------------
			
			// title naik turun
			if (m_stateScreen == MENU_SCREEN) {
				if (!TweenMax.isTweening(m_title)) {
					if(m_title.y == AL.halfStageHeight / 12) 		TweenMax.to(m_title, 1.5, { y:  AL.halfStageHeight / 6 });
					else if(m_title.y == AL.halfStageHeight / 6)	TweenMax.to(m_title, 1.5, { y:  AL.halfStageHeight / 12 });
				}
				
				// text mulai berdetak!
				//var _curTime:int	= getTimer();
				//if (_curTime-m_prevTime > 500) {
					//m_pressStrt.visible = (m_pressStrt.visible)? false:true;
					//m_prevTime 			= _curTime;
				//}
			}
			
			
			//---------------------------------------
			// Update Level
			//---------------------------------------	
			if (m_stateScreen == LEVEL_SCREEN) {
				
				if (m_isProcessing) {
					m_buttonRight.visible	= false;
					m_buttonLeft.visible 	= false;
				}
				else
				if (Config.currLevel <= 1) {
					m_buttonRight.visible	= true;
					m_buttonLeft.visible 	= false;
					
					m_buttonLeft.alpha	 	= 0.5;
					m_buttonRight.alpha 	= 1;
				}
				else 
				if (Config.currLevel >= Config.MAXLEVEL) {
					m_buttonLeft.visible	= true;
					m_buttonRight.visible 	= false;
					
					m_buttonLeft.alpha	 	= 1;
					m_buttonRight.alpha 	= 0.5;
				}
				else {
					m_buttonLeft.visible	= true;
					m_buttonRight.visible 	= true;
					
					m_buttonLeft.alpha	 	= 1;
					m_buttonRight.alpha 	= 1;
				}
			}				
		
		}
		
		// =================================================
		//         		  Handler  Function
		// =================================================
		
		private function onStartMenu(e:TouchEvent)
		{
			var _touch	: Touch = e.getTouch(m_starterBtn, TouchPhase.ENDED);
			if (_touch) {
				startMenu();
			}
		}
		
		private function onStartLevel(e:TouchEvent) 
		{
			var _touch	: Touch = e.getTouch(m_pressStrt, TouchPhase.ENDED);
			//var _tochBtn: Touch = e.getTouch(m_sensorBG, TouchPhase.BEGAN);
			if (_touch) {
				Music.GRUP_LEVEL.playFx(Music.sfx_pick, 0.3);
				m_pressStrt.alpha = 0;
				TweenMax.to(m_title,	 1.0, { alpha:0} );
				
				startSave();
				
				TweenMax.to(m_sponsorBG, 0.5, { alpha:0, onComplete:function() { m_sponsorBG.visible = false; }} )
				TweenMax.to(m_idnetBG, 0.5, { alpha:0, onComplete:function() { m_idnetBG.visible = false; }} )
				TweenMax.to(m_txtPlayMore, 0.5, { alpha:0, onComplete:function() { m_txtPlayMore.visible = false; }} )
				
				// show level photo
				//TweenMax.delayedCall(1.1, startLevel);
				
				//Config.load();
				//m_boxInfo.updateData();
				
			}
		}
		
		private function onTouchPlayBattle()
		{
			
			m_block.visible = true;
			m_block.alpha	= 0;
			TweenMax.to(m_block, 0.5, { alpha:1 } );
			
			m_text.visible 	= true;
			m_text.alpha	= 0;
			TweenMax.to(m_text, 0.5, { alpha:1 } );
			
			//---------------------------
			deactivate();
			TweenMax.delayedCall(1, alManager.showScreen, [ScreenBattle]);
		}
		
		private function onTouchSponsor(e:TouchEvent) 
		{
			var _touchY8: Touch = e.getTouch(m_sponsorBG, TouchPhase.ENDED);
			var _touchIDINET: Touch = e.getTouch(m_idnetBG, TouchPhase.ENDED);
			var _touchPlayMore: Touch = e.getTouch(m_txtPlayMore, TouchPhase.ENDED);
			
			if (_touchPlayMore) {
				
				if (Config.validateDomain_y8()) {
					
				} else {
					var myURL:URLRequest = new URLRequest("http://www.y8.com/?utm_source="+Config.URL+"&utm_medium=g_moregames&utm_campaign=pixelconflict");
					navigateToURL(myURL, "_blank");
				}
				
			}
			
			if (_touchY8) {
				if (Config.validateDomain_y8()) {
					
				} else {
					var myURL:URLRequest = new URLRequest("http://www.y8.com/?utm_source="+Config.URL+"&utm_medium=g_menulogo&utm_campaign=pixelconflict");
					navigateToURL(myURL, "_blank");
				}
				
			}
			
			if (_touchIDINET) {
				var myURL:URLRequest = new URLRequest("http://www.id.net/");
				navigateToURL(myURL, "_blank");
			}
		}
		
		private function onTouchDeveloper(e:TouchEvent) 
		{
			var _touch	: Touch = e.getTouch(m_devBG, TouchPhase.ENDED);
			if (_touch) {
				var myURL:URLRequest = new URLRequest("http://www.aldylab.com/");
				navigateToURL(myURL, "_blank");
				trace("helloworld")
			}
		}
		
		private function onTouchBack(e:TouchEvent)
		{
			var _touch:Touch = e.getTouch(m_backToSave, TouchPhase.ENDED);
			if (_touch) {
				stopLevel();	
			}
			
		}
		
		private var m_isProcessing:Boolean = false; 
		private function onTouchBtnLevel(e:TouchEvent):void 
		{
			var _touchLeft	: Touch = e.getTouch(m_buttonLeft, TouchPhase.ENDED);
			var _touchRight	: Touch = e.getTouch(m_buttonRight, TouchPhase.ENDED);
			
			var _sfxLeft	: Touch = e.getTouch(m_buttonLeft, TouchPhase.ENDED);
			var _sfxRight	: Touch = e.getTouch(m_buttonRight, TouchPhase.ENDED);

			if (_sfxLeft) Music.GRUP_LEVEL.playFx(Music.sfx_select, 0.3);
			if (_sfxRight) Music.GRUP_LEVEL.playFx(Music.sfx_select, 0.3);
			
			if (_touchLeft  && 
				m_buttonLeft.alpha == 1 && 
				!m_isProcessing && Config.currLevel>1) {
				
				m_isProcessing = true;
				Config.currLevel--;
				TweenMax.to(m_boxInfo, 0.3, { 
							x: m_boxCenterX + m_boxCenterX / 2, 
							alpha:0, 
							ease:Strong.easeIn, 
							onComplete:function() {
								m_boxInfo.x = m_boxCenterX - m_boxCenterX / 2;
								setLevel(false);
							}
					} );
				TweenMax.to(m_boxInfo, 0.3, { delay: 0.7, x: m_boxCenterX, alpha:1, ease:Strong.easeOut, 
							onComplete:function() { m_isProcessing = false;} } )
			}
			
			else
			if (_touchRight && m_buttonRight.alpha==1 && !m_isProcessing && Config.currLevel<=Config.MAXLEVEL) {
				
				m_isProcessing = true;
				Config.currLevel++;
				TweenMax.to(m_boxInfo, 0.3, { 
							x: m_boxCenterX - m_boxCenterX / 2, 
							alpha:0, 
							ease:Strong.easeIn, 
							onComplete:function() {
								m_boxInfo.x = m_boxCenterX + m_boxCenterX / 2;
								setLevel(true);
							}
					} );
				TweenMax.to(m_boxInfo, 0.3, { delay: 0.7, x: m_boxCenterX, alpha:1, ease:Strong.easeOut, 
							onComplete:function() { m_isProcessing = false} } )
				
			}
		}
		
		
		// =================================================
		//         		 logic  Function
		// =================================================
		private var m_txtConnectingData:TextField = new TextField(AL.stageWidth, AL.stageHeight / 5,"Connecting Data ...","Verdana", 20, 0xFFFFFF, true);
		private function startMenu()
		{
			// -----------------
			showPlayMore();
			
			Music.GRUP_LEVEL.playFx(Music.sfx_pick, 0.3);
			TweenMax.to(m_ads, 			0.5, { delay:0.2, alpha:0 } );
			TweenMax.to(m_devIcon, 		0.5, { delay:0.4, alpha:0 } );
			TweenMax.to(m_sponsorIcon, 	0.5, { delay:0.0, alpha:0 } );
			TweenMax.to(m_starterBtn, 	0.5, { delay:0.8, alpha:0 } );
			TweenMax.to(m_starterBG, 	0.5, { delay:1.0,alpha:0 } );
			
			TweenMax.delayedCall(1.5, function() {
			m_ads.visible			= false;
			m_devIcon.visible		= false;
			m_sponsorIcon.visible	= false;
			m_starterBG.visible		= false;
			m_starterBtn.visible	= false;
			
			//TweenMax.to(m_sponsorBG, 	0.5,	{ alpha:1, delay:0.0 } );
			//TweenMax.to(m_sponsorBG, 	0.5,	{ alpha:0, delay:1.5, visible: false } ); // delay: 0.5 + 0.0 ... + 1 = 1.5
			//TweenMax.to(m_devBG,		0.5, 	{ alpha:1, delay:3.0 } ); // delay: 0.5 + 1.5 ... + 1 = 3.0
			//TweenMax.to(m_devBG, 		0.5,	{ alpha:0, delay:4.5, visible: false } ); // delay: 0.5 + 3.0 ... + 1 = 4.5
			
			m_prevTime	= getTimer();
			
			TweenMax.to(m_blackBG, 	0.25,	{ alpha:0, visible: false, delay:0.5, onComplete:function()
			{
				m_txtConnectingData.visible = false;
			}});
			TweenMax.delayedCall(0, setState, [MENU_SCREEN]);
			
			Music.GRUP_LEVEL.playLoop(Music.bg_lvl,0.2,300);
			
			});
		}
		
		private function startSave()
		{
			if (!m_saveBox) {
				m_saveBox = new Save2an();
				m_saveBox.pivotX 	= m_saveBox.width / 2;
				m_saveBox.pivotY 	= m_saveBox.height / 2;
				m_saveBox.scaleX 	= 0.48;
				m_saveBox.scaleY 	= 0.48;
				
				
				m_saveBox.signal_enterSlot.add(function() {
					startLevel(); 
					TweenMax.to(m_saveBox, 0.5, { alpha:0, onComplete:function() { 
						m_saveBox.visible = false; }
					})
				});
				add(m_saveBox);
			}
			m_saveBox.visible	= true;
			m_saveBox.x 		= AL.halfStageWidth + 40;
			m_saveBox.y 		= AL.halfStageHeight - 10;
			m_saveBox.alpha 	= 0;
			m_saveBox.checkSave2an_Local();
			m_saveBox.checkSave2an_Online();
			TweenMax.to(m_saveBox, 1,{ alpha:1});
		
		}
		
		private function setState(_state:String) {m_stateScreen = _state;}
		
		private function setLevel(_isRight:Boolean)
		{
			Config.currLevel = (_isRight)? Config.currLevel++:Config.currLevel--;
			Config.load();
			m_boxInfo.updateData();
			
		}
		
		private function startLevel():void 
		{
			
			if (!Music.GRUP_LEVEL.getSound(Music.bg_lvl).isPlaying) {
				Music.GRUP_LEVEL.playLoop(Music.bg_lvl, 0.2);
				Music.GRUP_GAME.stopAll();
			}
			
			// -----------------------------------
			setState(LEVEL_SCREEN);
			AL.updater.turnOnOffUpdate();
			
			m_boxInfo.visible		= true;
			m_borderUp.visible		= true;
			m_borderDown.visible	= true;
			m_title.visible			= false;
			m_pressStrt.visible		= false;
			
			m_buttonLeft.visible	= false;
			m_buttonRight.visible	= false;
			m_sensorBG.removeEventListener(TouchEvent.TOUCH, onStartLevel);
			
			// -- set display button --
			if (Config.currLevel <= 1)					
				m_buttonRight.visible	= true;
			else if (Config.currLevel >= Config.MAXLEVEL) 
				m_buttonLeft.visible	= true;
			else {
				m_buttonLeft.visible	= true;
				m_buttonRight.visible	= true;	
			}
			
			m_buttonLeft.alpha		= 0;
			m_buttonRight.alpha		= 0;
			
			m_backToSave.visible	= true;
			m_backToSave.alpha		= 0;
			
			Config.load();
			m_boxInfo.updateData();
			
			Config.isStarted 	= true;
			
			// ------------------------
			
			TweenMax.to(m_borderUp, 	0.5, { delay: 0.5, alpha:1, y:0, ease:Strong.easeOut } );
			TweenMax.to(m_borderDown, 	0.5, { delay: 0.5, alpha:1, y:AL.stageHeight - m_borderDown.height, ease:Strong.easeOut} );
			TweenMax.to(m_boxInfo, 		0.5, { delay: 1,   alpha:1 } );
			TweenMax.to(m_buttonLeft, 	0.5, { delay: 1.2, alpha:1 } );
			TweenMax.to(m_buttonRight, 	0.5, { delay: 1.2, alpha:1 } );
			TweenMax.to(m_backToSave, 0.5, { delay: 1.3, alpha:1 } );
			
			TweenMax.delayedCall(1.5, AL.updater.turnOnOffUpdate);
			
			// -------------------------
			
			
			if (!m_achievements) {
				var _filter_1:ColorMatrixFilter = new ColorMatrixFilter();
					_filter_1.adjustHue(0.3);
					
				m_achievements = new Button(Ast.img("uiMenu", "button_long2"), "Achievements");
				m_achievements.scaleX = 0.5;
				m_achievements.scaleY = 0.5;
				m_achievements.pivotX = m_achievements.width / 2;
				m_achievements.visible = false;
				m_achievements.fontSize = 20;
				m_achievements.filter = _filter_1;
				m_achievements.addEventListener(TouchEvent.TOUCH, onTouch_AchievementsHighScore);
				add(m_achievements);
			}
			m_achievements.visible = true;
			m_achievements.x = AL.halfStageWidth - m_achievements.width / 2 - 40;
			m_achievements.y = AL.stageHeight - m_achievements.height - 20;
			
			if (!m_highscore) {
				
				var _filter_2:ColorMatrixFilter = new ColorMatrixFilter();
					_filter_2.adjustHue(0.7);
				
				m_highscore = new Button(Ast.img("uiMenu", "button_long2"), "Highscore");
				m_highscore.scaleX = 0.5;
				m_highscore.scaleY = 0.5;
				m_highscore.pivotX = m_highscore.width / 2;
				m_highscore.visible = false;
				m_highscore.fontSize = 20;
				m_highscore.filter = _filter_2;
				m_highscore.addEventListener(TouchEvent.TOUCH, onTouch_AchievementsHighScore);
				add(m_highscore);
			}
			
			m_highscore.visible = true;
			m_highscore.x = AL.halfStageWidth + m_highscore.width / 3 ;
			m_highscore.y = AL.stageHeight - m_highscore.height - 20;
			
			m_idnetBG.visible = true;
			m_sponsorBG.visible = true;
			
			m_achievements.visible = true;
			m_highscore.visible = true;
			m_achievements.alpha = 0;
			m_highscore.alpha = 0;
			TweenMax.to(m_achievements, 0.5, { alpha:1 } );
			TweenMax.to(m_highscore, 0.5, { alpha:1 } );
			
			showPlayMore();
			
			TweenMax.to(m_idnetBG, 0.5, { alpha:1 } );
			TweenMax.to(m_sponsorBG, 0.5, { alpha:1 } );
			
			
			if (!m_warningLocal) {
				m_warningLocal = new WarningSave();
				m_warningLocal.visible = false;
				add(m_warningLocal);
			}
		}
		
		private var m_warningLocal:WarningSave;
		private function onTouch_AchievementsHighScore(e:TouchEvent):void 
		{
			var _touchAchievements:Touch = e.getTouch(m_achievements, TouchPhase.ENDED);
			var _touchHighscore:Touch = e.getTouch(m_highscore, TouchPhase.ENDED);
			if (_touchAchievements) {
				if (Config.usingOnlineData) {
					m_block.visible = true;
					IDI.idnet.toggleInterface('achievements');
				} else {
					m_warningLocal.visible = true;
				}
			}
			
			if (_touchHighscore) {
				if (Config.usingOnlineData) {
					m_block.visible = true;
					IDI.idnet.advancedScoreList('HighScore');
				} else {
					m_warningLocal.visible = true;
				}
				
			}
		}
		
		private function stopLevel()
		{
			m_stateScreen			= "save2an"
			
			TweenMax.to(m_achievements, 0.2, { alpha:0 } );
			TweenMax.to(m_highscore, 0.2, { alpha:0 } );
			TweenMax.to(m_txtPlayMore, 0.2, { alpha:0 } );
			TweenMax.to(m_sponsorBG, 0.2, { alpha:0 } );
			TweenMax.to(m_idnetBG, 0.2, { alpha:0 } );
			
			TweenMax.to(m_borderUp, 	0.2, { delay: 0.5,alpha:0, y:-m_borderUp.height, ease:Strong.easeOut } );
			TweenMax.to(m_borderDown, 	0.2, { delay: 0.5,alpha:0, y:AL.stageHeight, ease:Strong.easeOut} );
			TweenMax.to(m_boxInfo, 		0.2, { delay: 0,   alpha:0 } );
			TweenMax.to(m_buttonLeft, 	0.2, { delay: 0.2, alpha:0 } );
			TweenMax.to(m_buttonRight, 	0.2, { delay: 0.2, alpha:0 } );
			TweenMax.to(m_backToSave, 0.2, { delay: 0.3, alpha:0 } );
			
			//TweenMax.delayedCall(0.5, AL.updater.turnOnOffUpdate);
			TweenMax.delayedCall(1, function() {
				
				m_achievements.visible = false;
				m_highscore.visible = false;
				m_txtPlayMore.visible = false;
				m_sponsorBG.visible = false;
				m_idnetBG.visible = false;
				
				m_boxInfo.visible		= false;
				m_borderUp.visible		= false;
				m_borderDown.visible	= false;
				m_buttonLeft.visible	= false;
				m_buttonRight.visible	= false;
				
				startSave();
				
				Config.isStarted = false;
			})
			
			
		}
		
		private function showPlayMore():void 
		{
			var _statusDomain:Boolean = Config.validateDomain_y8();
			
			if (_statusDomain) {
				//IDI.myText.text = ">> it is true";
				m_txtPlayMore.visible = false;
				m_txtPlayMore.useHandCursor = false;
				m_sponsorBG.useHandCursor = false;
			} else {
				//IDI.myText.text = "> false";
				m_txtPlayMore.visible = true;
				m_txtPlayMore.useHandCursor = true;
				m_sponsorBG.useHandCursor = true;
				TweenMax.to(m_txtPlayMore, 1.5, { alpha:1 } );
			}
		}
		
		
	}

}