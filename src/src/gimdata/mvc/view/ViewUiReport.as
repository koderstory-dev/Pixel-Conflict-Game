package gimdata.mvc.view 
{
	import al.core.AL;
	import al.core.Ast;
	import al.display.ActiveButtonAL;
	import al.display.SpriteAL;
	import al.objects.Box;
	import com.greensock.easing.Bounce;
	import com.greensock.easing.Elastic;
	import com.greensock.easing.Strong;
	import com.greensock.TweenMax;
	import flash.events.Event;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import gimdata.core.config.Config;
	import gimdata.core.config.Music;
	import gimdata.core.config.Record;
	import gimdata.core.config.Report;
	import gimdata.objects.achievements.MyAchievements;
	import gimdata.objects.save.WarningSave;
	import gimdata.objects.viewReport.GameOver;
	import gimdata.objects.viewReport.ViewReport;
	import org.osflash.signals.Signal;
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.filters.ColorMatrixFilter;
	import starling.text.TextField;
	import starling.utils.Color;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	import treefortress.sound.SoundAS;
	
	/**
	 * ...
	 * @author Aldy Ahsadin
	 */
	public class ViewUiReport extends SpriteAL 
	{
		public function ViewUiReport() {
			// - background
			m_bg				= new Box(AL.stageWidth, AL.stageHeight, 0x0, 0, 0);
			m_bg.alpha			= 0.8;
			
			// - pause option
			m_btnExit			= new Button(Ast.img("uiBattle", "btnMenu_0"), "", Ast.img("uiBattle", "btnMenu_1"));
			m_btnRestart		= new Button(Ast.img("uiBattle", "btnReset_0"), "", Ast.img("uiBattle", "btnReset_1"));
			m_btnResume			= new Button(Ast.img("uiBattle", "btnPlay_0"), "", Ast.img("uiBattle", "btnPlay_1"));
			m_btnVolume			= new Button(Ast.img("uiBattle", "btnVolume_on"));
			m_btnCinematic		= new Button(Ast.img("uiBattle", "btnCinema_on"));
			m_pauseText			= new TextField(AL.stageWidth, 40, "- PAUSE -", "vcr", 30, 0xFFFFFF);
			
			m_btnExit.scaleX		= 0.8;
			m_btnExit.scaleY		= 0.8;
			m_btnResume.scaleX		= 0.8;
			m_btnResume.scaleY		= 0.8;
			m_btnRestart.scaleX		= 0.8;
			m_btnRestart.scaleY		= 0.8;
			m_btnVolume.scaleX		= 0.8;
			m_btnVolume.scaleY		= 0.8;
			m_btnCinematic.scaleX 	= 0.8;
			m_btnCinematic.scaleY 	= 0.8;
			
			m_btnExit.x			= AL.setCenterX(m_btnExit) - m_btnExit.width - 20;
			m_btnResume.x		= AL.setCenterX(m_btnResume) + m_btnResume.width + 20;
			m_btnRestart.x		= AL.setCenterX(m_btnRestart);
			m_btnVolume.x		= AL.setCenterX(m_btnVolume) - m_btnVolume.width * 0.6;
			m_btnCinematic.x 	= AL.setCenterX(m_btnCinematic) + m_btnCinematic.width * 0.6;
			
			m_btnExit.y			= AL.setCenterY(m_btnExit) - 50;
			m_btnResume.y		= AL.setCenterY(m_btnResume) -50;
			m_btnRestart.y		= AL.setCenterY(m_btnRestart) - 50;
			m_btnVolume.y		= AL.setCenterY(m_btnVolume) + 20;
			m_btnCinematic.y 	= AL.setCenterY(m_btnCinematic) + 20;
			m_pauseText.y		= m_btnExit.y - m_pauseText.height;
			
			m_btnExit.visible		= false;
			m_btnRestart.visible	= false;	
			m_btnResume.visible		= false;
			m_btnVolume.visible		= false;
			m_btnCinematic.visible 	= false;
			m_pauseText.visible		= false;
			
			// -- report
			m_report			= new ViewReport();
			m_report.y			= 100;
			m_report.visible	= false;
			m_report.alpha		= 0;
			
			m_allyFlag			= new Image(Ast.img("flags", "allyFlag"));
			m_enemyFlag			= new Image(Ast.img("flags", "enemyFlag"));
			m_allyFlag.x		= -m_allyFlag.width;
			m_enemyFlag.x		= AL.stageWidth;
			
			m_allyFlag.y		= 50;
			m_enemyFlag.y		= 50;
			
			
			// ---------------
			m_btnContinue		= new Button(Ast.img("uiBattle", "btnPlay_0"), "", Ast.img("uiBattle", "btnPlay_1"));
			m_btnMenu			= new Button(Ast.img("uiBattle", "btnMenu_0"), "", Ast.img("uiBattle", "btnMenu_1"));
			m_btnRestartLvl		= new Button(Ast.img("uiBattle", "btnReset_0"), "", Ast.img("uiBattle", "btnReset_1"));
			
			m_btnMenu	.addEventListener(TouchEvent.TOUCH, onTouchBtn);
			m_btnRestartLvl	.addEventListener(TouchEvent.TOUCH, onTouchBtn);
			m_btnContinue	.addEventListener(TouchEvent.TOUCH, onTouchBtn);
			m_btnVolume		.addEventListener(TouchEvent.TOUCH, onTouchBtn);
			m_btnCinematic	.addEventListener(TouchEvent.TOUCH, onTouchBtn);
			
			m_btnContinue.scaleX		= 0.7;
			m_btnContinue.scaleY		= 0.7;
			m_btnMenu.scaleX	= 0.7;
			m_btnMenu.scaleY	= 0.7;
			m_btnRestartLvl.scaleX	= 0.7;
			m_btnRestartLvl.scaleY	= 0.7;
			
			m_btnContinue.pivotX		= m_btnContinue.width / 2;
			m_btnContinue.pivotY		= m_btnContinue.height / 2;
			m_btnMenu.pivotX	= m_btnMenu.width / 2;
			m_btnMenu.pivotY	= m_btnMenu.height / 2;
			m_btnRestartLvl.pivotX	= m_btnRestartLvl.width / 2;
			m_btnRestartLvl.pivotY	= m_btnRestartLvl.height / 2;
			
			m_btnContinue.x			= AL.halfStageWidth + m_btnContinue.width + 35;
			m_btnContinue.y			= AL.stageHeight - m_btnContinue.height - 80//AL.stageHeight;
			m_btnMenu.x		= AL.halfStageWidth - m_btnMenu.width - 45;
			m_btnMenu.y		= AL.stageHeight - m_btnMenu.height - 80//AL.stageHeight;
			m_btnRestartLvl.x		= AL.halfStageWidth - 5;
			m_btnRestartLvl.y		= AL.stageHeight - m_btnRestartLvl.height - 80//AL.stageHeight;
			
			// --------------
			
			m_menuTxt		= new TextField(75, 30, "MENU", "vcr", 15, 0xFFFFFF);
			m_restartTxt	= new TextField(75, 30, "RESTART", "vcr", 15, 0xFFFFFF);
			m_continueTxt	= new TextField(75, 30, "CONTINUE", "vcr", 15, 0xFFFFFF);
			
			//m_menuTxt.border = true;
			//m_restartTxt.border = true;
			//m_continueTxt.border = true;
			
			m_menuTxt.pivotX = m_menuTxt.width / 2;
			m_menuTxt.pivotY = m_menuTxt.height / 2;
			m_restartTxt.pivotX = m_restartTxt.width / 2;
			m_restartTxt.pivotY = m_restartTxt.height / 2;
			m_continueTxt.pivotX = m_continueTxt.width / 2;
			m_continueTxt.pivotY = m_continueTxt.height / 2;
			
			m_continueTxt.x	= AL.halfStageWidth + m_continueTxt.width + 10;
			m_continueTxt.y	= m_btnMenu.y + m_btnMenu.height + 10;
			m_menuTxt.x		= AL.halfStageWidth - m_menuTxt.width - 10;
			m_menuTxt.y		= m_btnMenu.y + m_btnMenu.height + 10;
			m_restartTxt.x	= AL.halfStageWidth;
			m_restartTxt.y	= m_btnMenu.y + m_btnMenu.height + 10;
			
			//
			m_gotMenuTxt.pivotX			= m_gotMenuTxt.width / 2;
			//m_gotMenuTxt.pivotY			= m_gotMenuTxt.height / 2;
			m_gotRestartTxt.pivotX		= m_gotRestartTxt.width / 2;
			//m_gotRestartTxt.pivotY		= m_gotRestartTxt.height / 2;
			m_gotResumeTxt.pivotX		= m_gotResumeTxt.width / 2;
			//m_gotResumeTxt.pivotY		= m_gotResumeTxt.height / 2;
			m_gotSoundTxt.pivotX		= m_gotSoundTxt.width / 2;
			//m_gotSoundTxt.pivotY		= m_gotSoundTxt.height / 2;
			m_gotCinematicTxt.pivotX	= m_gotCinematicTxt.width / 2;
			//m_gotCinematicTxt.pivotY	= m_gotCinematicTxt.height / 2;
			
			m_gotMenuTxt.x		= AL.halfStageWidth - m_gotMenuTxt.width;
			m_gotRestartTxt.x	= AL.halfStageWidth;
			m_gotResumeTxt.x	= AL.halfStageWidth + m_gotResumeTxt.width;
			m_gotSoundTxt.x		= AL.halfStageWidth - m_gotSoundTxt.width*0.85;
			m_gotCinematicTxt.x	= AL.halfStageWidth + m_gotCinematicTxt.width/2;
			
			m_gotMenuTxt.y		= m_btnExit.y + m_btnExit.height*0.87;
			m_gotRestartTxt.y	= m_btnRestart.y + m_btnRestart.height*0.87;
			m_gotResumeTxt.y	= m_btnResume.y + m_btnResume.height*0.87;
			m_gotSoundTxt.y		= m_btnVolume.y + m_btnVolume.height*0.85;
			m_gotCinematicTxt.y	= m_btnCinematic.y + m_btnCinematic.height*0.85;
			
			//m_gotMenuTxt.border			= true;
			//m_gotRestartTxt.border		= true;
			//m_gotResumeTxt.border		= true;
			//m_gotSoundTxt.border		= true;
			//m_gotCinematicTxt.border 	= true;
			
			m_gotMenuTxt.visible		= false;
			m_gotRestartTxt.visible		= false;
			m_gotResumeTxt.visible		= false;
			m_gotSoundTxt.visible		= false;
			m_gotCinematicTxt.visible 	= false;
			
			//-------------------------
			m_transition			= new Box(AL.stageWidth, AL.stageHeight, 0x0, 0, 0, 0);
			m_transition.alpha		= 1;
			m_transition.visible 	= false;
			m_textPlzWait			= new TextField(AL.stageWidth, AL.stageHeight / 5, "", "vcr", 20, 0xFFFFFF, true);
			m_textPlzWait.visible 	= false;
			m_textPlzWait.y			= AL.stageHeight - m_textPlzWait.height;
			
			
			// ------
			m_gameOver = new GameOver();
			
			m_y8Logo = new Image(Ast.img("sponsorLogo"));
			m_y8Logo.pivotX = m_y8Logo.width / 2;
			m_y8Logo.pivotY = m_y8Logo.height / 2;
			m_y8Logo.scaleX = 0.15;
			m_y8Logo.scaleY = 0.15;
			m_y8Logo.visible = false;
			m_y8Logo.addEventListener(TouchEvent.TOUCH, onTouchBtn_sponsor);
			
			// -achievements + highscore
			
			var _filter:ColorMatrixFilter = new ColorMatrixFilter();
				_filter.adjustHue(0.3);
			var _filter2:ColorMatrixFilter = new ColorMatrixFilter();
				_filter2.adjustHue(0.7);
			
			m_achievements = new Button(Ast.img("uiMenu", "button_long2"), "achievements");
			m_achievements.pivotX = m_achievements.width / 2;
			m_achievements.pivotY = m_achievements.height / 2;
			m_achievements.scaleX = 0.5;
			m_achievements.scaleY = 0.5;
			m_achievements.x = AL.halfStageWidth - m_achievements.width;
			m_achievements.y = AL.stageHeight - m_achievements.height + 20;
			m_achievements.visible = false;
			m_achievements.fontSize = 22;
			m_achievements.filter	= _filter;
			m_achievements.addEventListener(TouchEvent.TOUCH, onTouchBtn_highScoreNAchievements);
			
			m_highscore = new Button(Ast.img("uiMenu", "button_long2"), "highscore");
			m_highscore.pivotX = m_highscore.width/2;
			m_highscore.pivotY = m_highscore.height/2;
			m_highscore.scaleX = 0.5;
			m_highscore.scaleY = 0.5;
			m_highscore.x = AL.halfStageWidth;
			m_highscore.y = AL.stageHeight - m_highscore.height + 20;
			m_highscore.visible = false;
			m_highscore.fontSize = 22;
			m_highscore.filter = _filter2;
			m_highscore.addEventListener(TouchEvent.TOUCH, onTouchBtn_highScoreNAchievements);
			
			m_submitHighscore = new Button(Ast.img("uiMenu", "button_long2"), "Submit Score");
			m_submitHighscore.pivotX = m_submitHighscore.width / 2;
			m_submitHighscore.pivotY = m_submitHighscore.height / 2;
			m_submitHighscore.scaleX = 0.5;
			m_submitHighscore.scaleY = 0.5;
			m_submitHighscore.x	     = AL.halfStageWidth + m_submitHighscore.width;
			m_submitHighscore.y		 = m_highscore.y
			m_submitHighscore.filter = _filter2;
			m_submitHighscore.fontSize = 22;
			m_submitHighscore.addEventListener(TouchEvent.TOUCH, onTouchBtn_highScoreNAchievements);
		
			m_warningSave = new WarningSave();
			
			m_txtPlayMore									= new TextField(150, 30, "Play More Games", "Verdana", 10, 0xFFFFFF);
			//m_txtPlayMore.scaleX							= 0.7;
			//m_txtPlayMore.scaleY							= 0.7;
			m_txtPlayMore.pivotX							= m_txtPlayMore.width / 2;
			m_txtPlayMore.y									= m_y8Logo - m_txtPlayMore.height - 2;
			m_txtPlayMore.visible = false;
			m_txtPlayMore.addEventListener(TouchEvent.TOUCH, onTouchBtn_highScoreNAchievements);
			
			m_block.visible = false;
			
			// --CHILD
			
			addChild(m_bg);
			addChild(m_report);
			
			addChild(m_btnContinue);
			addChild(m_btnMenu);
			addChild(m_btnRestartLvl);
			
			addChild(m_restartTxt);
			addChild(m_menuTxt);
			addChild(m_continueTxt);
			
			addChild(m_btnExit);
			addChild(m_btnRestart);
			addChild(m_btnResume);
			addChild(m_btnVolume);
			addChild(m_btnCinematic);
			
			addChild(m_gotMenuTxt);
			addChild(m_gotRestartTxt);
			addChild(m_gotResumeTxt);
			addChild(m_gotSoundTxt);
			addChild(m_gotCinematicTxt);
			
			addChild(m_pauseText);
			addChild(m_allyFlag);
			addChild(m_enemyFlag);
			
			addChild(m_transition);
			addChild(m_textPlzWait);
			
			addChild(m_gameOver);
			addChild(m_y8Logo);
			addChild(m_achievements);
			addChild(m_highscore);
			addChild(m_submitHighscore);
			addChild(m_warningSave);
			addChild(m_txtPlayMore);
			addChild(m_block);
			
			// -- event
			m_btnExit.addEventListener(TouchEvent.TOUCH, onTouchBtn);
			m_btnRestart.addEventListener(TouchEvent.TOUCH, onTouchBtn);
			m_btnResume.addEventListener(TouchEvent.TOUCH, onTouchBtn);
			m_btnVolume.addEventListener(TouchEvent.TOUCH, onTouchBtn);
			m_btnCinematic.addEventListener(TouchEvent.TOUCH, onTouchBtn);
			m_gameOver.addEventListener(TouchEvent.TOUCH, onTouchBtn);
			
			this.visible = false;
		}
		
		private function onTouchBtn_sponsor(e:TouchEvent):void 
		{
			var _touchY8:Touch = e.getTouch(m_y8Logo, TouchPhase.ENDED);
			if (_touchY8) {
				if (Config.validateDomain_y8()) {
					
				} else {
					var myURL:URLRequest = new URLRequest("http://www.y8.com/");
					navigateToURL(myURL, "_blank");
					
				}
			}
		}
		
		// blok screen biar ga bisa disentuh
		private var m_bg			: Box;
		
		// option exit
		private var m_btnExit		: Button;
		private var m_btnRestart	: Button;
		private var m_btnResume		: Button;
		private var m_btnVolume		: Button;
		private var m_btnCinematic	: Button;
		private var m_pauseText		: TextField;
		
		// report
		private var m_report		: ViewReport;
		private var m_allyFlag		: Image;
		private var m_enemyFlag		: Image;
		
		private var m_btnContinue	: Button;
		private var m_btnRestartLvl	: Button;
		private var m_btnMenu	: Button;
		
		private var m_continueTxt	: TextField;
		private var m_restartTxt	: TextField;
		private var m_menuTxt		: TextField;
		
		// signal
		public	var signal_restart	: Signal = new Signal();
		public	var signal_exit		: Signal = new Signal();
		public	var signal_nextLevel: Signal = new Signal();
		
		// text
		private var m_gotMenuTxt		: TextField = new TextField(070, 30, "MENU", "vcr", 15, 0xFFFFFF);
		private var m_gotRestartTxt		: TextField = new TextField(100, 30, "RESTART", "vcr", 15, 0xFFFFFF);;
		private var m_gotResumeTxt		: TextField = new TextField(70, 30, "RESUME", "vcr", 15, 0xFFFFFF);;
		private var m_gotSoundTxt		: TextField = new TextField(070, 30, "SOUND", "vcr", 15, 0xFFFFFF);;
		private var m_gotCinematicTxt	: TextField = new TextField(120, 30, "CINEMATIC", "vcr", 15, 0xFFFFFF);;
		
		// transisi turn
		private	var m_transition	: Box;
		private var m_textPlzWait	: TextField;
		
		//gameover
		private var m_gameOver:GameOver;
		
		//logo 
		private var m_y8Logo:Image;
		
		// achievement + highscore
		private var m_achievements:Button;
		private var m_highscore:Button;
		private var m_submitHighscore:Button;
		private var m_warningSave:WarningSave;
		private var m_txtPlayMore:TextField;
		
		private var m_block		: Box = new Box(AL.stageWidth, AL.stageHeight, 0x0, 0, 0, 0x0);
		
		
		private function hideReportMenu()
		{
			m_btnContinue.visible	= false;
			m_btnRestartLvl.visible	= false;
			m_btnMenu.visible	= false;
			
			m_continueTxt.visible	= false;
			m_menuTxt.visible		= false;
			m_restartTxt.visible	= false;
			
			
		}
		
		public function showReport(_result:String)
		{
			
			showPlayMore(false);
			// ------------------------------
			m_achievements.visible 	= true;
			m_highscore.visible		= true;
			m_submitHighscore.visible = true;
			m_y8Logo.visible = true;
			
			m_achievements.alpha = 0;
			m_highscore.alpha = 0;
			m_submitHighscore.alpha = 0;
			m_y8Logo.alpha = 0;
			
			//var _alphaSubmit:Number = 0.5;
			//if (Config.usingOnlineData) _alphaSubmit = 1;
			
			TweenMax.to(m_y8Logo, 0.5, { delay:0.5, alpha:1 } );
			TweenMax.to(m_achievements, 0.5, { delay:3.0, alpha:1 } );
			TweenMax.to(m_highscore, 0.5, { delay:3.2, alpha:1 } );
			TweenMax.to(m_submitHighscore, 0.5, { delay:3.6, alpha:1/*_alphaSubmit*/ } );
			
			// =================================
			m_submitHighscore.text	= "Submit Score\n+" + String(Config.scoreAllLevels[Config.currLevel-1]);
			//m_submitHighscore.alpha =  (Config.usingOnlineData)? 1:0.5;
			
			m_y8Logo.x	= AL.halfStageWidth;
			m_y8Logo.y	= 20;
			
			
			this.visible			= true;	
			this.alpha = 1;
			
			m_bg.visible			= true;
			m_btnContinue.visible	= true;
			m_btnRestartLvl.visible	= true;
			m_btnMenu.visible	= true;
			
			m_continueTxt.visible	= true;
			m_menuTxt.visible		= true;
			m_restartTxt.visible	= true;
			m_y8Logo.visible		= true;
			
			m_bg.alpha				= 0;
			TweenMax.to(m_bg, 0.2, { alpha:0.8, 	delay:0.0 } );
			
			m_report.getReport(_result);
			m_report.visible	= true;
			m_report.alpha		= 0;
			m_report.y			= 100;
			TweenMax.to(m_report, 0.5, { alpha:1, delay:1.0, y:50, ease:Strong.easeOut});
			
			m_allyFlag.x		= 100;
			m_enemyFlag.x		= AL.stageWidth-100;
			m_allyFlag.alpha	= 0;
			m_enemyFlag.alpha	= 0;
			
			TweenMax.to(m_allyFlag,  0.8, { alpha:1, delay:1.0, x:10, ease:Strong.easeOut});
			TweenMax.to(m_enemyFlag, 0.8, { alpha:1, delay:1.0, x:AL.stageWidth - m_enemyFlag.width - 15, ease:Strong.easeOut});
			
			m_btnMenu.y			= AL.stageHeight+100;
			m_btnContinue.y		= AL.stageHeight+100;
			m_btnRestartLvl.y	= AL.stageHeight+100;
			m_btnMenu.alpha			= 0
			m_btnContinue.alpha		= 0;
			m_btnRestartLvl.alpha	= 0;
			
			
			TweenMax.to(m_btnMenu,  0.6, { alpha:1, delay:2.0, 
												y:AL.stageHeight - m_btnMenu.height - 65, 
												ease:Elastic.easeOut} );
			TweenMax.to(m_btnRestartLvl,  0.6, { alpha:1, delay:2.5, 
												y:AL.stageHeight - m_btnRestartLvl.height - 65, 
												ease:Elastic.easeOut} );
			TweenMax.to(m_btnContinue, 0.6, { 	delay:3.0, 
												y:AL.stageHeight - m_btnContinue.height - 65, 
												ease:Elastic.easeOut } );
			m_menuTxt.alpha 	= 0;
			m_restartTxt.alpha	= 0;
			m_continueTxt.alpha	= 0;  
			
			TweenMax.to(m_menuTxt, 0.5, { delay:2.5, alpha:1 } );
			TweenMax.to(m_restartTxt, 0.5, { delay:3.0, alpha:1 } );
			TweenMax.to(m_continueTxt, 0.5, { delay:3.5, alpha:1 } );
			
			// --save2an
			var _hasil:String = _result.substr(0, 9);
			var _levelData:Array;
			
			var _levelData:Array = Config.loadLevels();
			if (_hasil == "MISSION A" && Config.currLevel < Config.MAXLEVEL) {
				_levelData[Config.currLevel] = 1
				Config.updateLevels();
			}
			if (Config.currLevel < Config.MAXLEVEL) {
				if (Config.currLevel<Config.MAXLEVEL && _levelData[Config.currLevel] == 1) {
					m_btnContinue.alpha	= 1;
				} else {
					m_btnContinue.alpha	= 0.3;
				}
			}
			
		}
		
		public function showMenu()
		{
			
			showPlayMore(true);
			
			// --------------------------
			
			hideReportMenu();
			visible			= true;
			alpha			= 1;
			
			m_y8Logo.visible = true;
			m_achievements.visible = false;
			m_highscore.visible		= false;
			m_submitHighscore.visible = false;
			
			m_bg.visible			= true;
			m_btnExit.visible		= true;
			m_btnRestart.visible	= true;
			m_btnResume.visible		= true;
			m_btnVolume.visible		= true;
			m_btnCinematic.visible	= true;
			m_pauseText.visible		= true;
			m_y8Logo.visible		= true;
			
			m_bg.alpha 				= 0;
			m_btnExit.alpha			= 0;
			m_btnRestart.alpha		= 0;
			m_btnResume.alpha		= 0;
			m_btnVolume.alpha		= 0;
			m_btnCinematic.alpha	= 0;
			m_pauseText.alpha		= 0;
			
			m_gotMenuTxt.visible		= true;
			m_gotRestartTxt.visible		= true;
			m_gotResumeTxt.visible		= true;
			m_gotSoundTxt.visible		= true;
			m_gotCinematicTxt.visible 	= true;
			
			m_gotMenuTxt.alpha		= 0;
			m_gotRestartTxt.alpha	= 0;
			m_gotResumeTxt.alpha	= 0;
			m_gotSoundTxt.alpha		= 0;
			m_gotCinematicTxt.alpha = 0;
			
			
			TweenMax.to(m_bg, 			0.5, { alpha:0.85 } );
			TweenMax.to(m_pauseText, 	0.5, { alpha:1, delay:0.1 } );
			
			TweenMax.to(m_btnExit, 		0.5, { alpha:1, delay:0.2 } );
			TweenMax.to(m_btnRestart, 	0.5, { alpha:1, delay:0.3 } );
			TweenMax.to(m_btnResume, 	0.5, { alpha:1, delay:0.4 } );
			TweenMax.to(m_btnVolume, 	0.5, { alpha:1, delay:0.5 } );
			TweenMax.to(m_btnCinematic,	0.5, { alpha:1, delay:0.6 } );
			
			TweenMax.to(m_gotMenuTxt,	0.5, { alpha:1, delay:0.1 } );
			TweenMax.to(m_gotRestartTxt,0.5, { alpha:1, delay:0.2 } );
			TweenMax.to(m_gotResumeTxt,	0.5, { alpha:1, delay:0.3 } );
			TweenMax.to(m_gotSoundTxt, 	0.5, { alpha:1, delay:0.4 } );
			TweenMax.to(m_gotCinematicTxt,0.5, { alpha:1, delay:0.5 } );
			
			trace("UI REPORT VISIBLE:", this.visible);
			
			m_y8Logo.alpha = 0;
			m_y8Logo.x	= AL.halfStageWidth;
			m_y8Logo.y	= AL.stageHeight - m_y8Logo.height;
			TweenMax.to(m_y8Logo, 0.5, { alpha:1, delay:0.6 } );
			
		}
		
		public function hideMenu()
		{
			
			TweenMax.to(this, 0.5,{alpha:0, onComplete:function() {
				m_bg.visible			= false;
				
				m_y8Logo.visible = false;
				m_achievements.visible = false;
				m_highscore.visible = false;
				m_txtPlayMore.visible = false;
				
				m_gotMenuTxt.visible		= false;
				m_gotRestartTxt.visible		= false;
				m_gotResumeTxt.visible		= false;
				m_gotSoundTxt.visible		= false;
				m_gotCinematicTxt.visible 	= false;
				
				m_btnExit.visible		= false;
				m_btnRestart.visible	= false;
				m_btnResume.visible		= false;
				m_btnVolume.visible		= false;
				m_btnCinematic.visible	= false;
				m_pauseText.visible		= false;
				visible					= false;
			}});
		}
		
		// -- show
		public function showTransition(_text:String) {
			m_textPlzWait.visible	= true;
			m_transition.visible 	= true;
			m_textPlzWait.text		= _text;
		}
		
		// -- handler
		
		public function onTouchBtn_highScoreNAchievements(e:TouchEvent)
		{
			var _touchHighScore		: Touch	= e.getTouch(m_highscore, TouchPhase.ENDED);
			var _touchSubmit		: Touch	= e.getTouch(m_submitHighscore, TouchPhase.ENDED);
			var _touchAchievements	: Touch	= e.getTouch(m_achievements, TouchPhase.ENDED);
			var _touchPlayMore		: Touch	= e.getTouch(m_txtPlayMore, TouchPhase.ENDED);
			
			if (_touchPlayMore) {
				
				if (Config.validateDomain_y8()) {
					
				} else {
					var myURL:URLRequest = new URLRequest("http://www.y8.com/?utm_source="+Config.URL+"&utm_medium=g_moregames&utm_campaign=pixelconflict");
					navigateToURL(myURL, "_blank");
				}
			}
			
			else if (_touchSubmit) {
				Music.GRUP_GAME.playFx(Music.sfx_cteck, 0.35);
				// nanti perlu dibatsi, tidak bisa akumulasi nilai ketika menggulang levl yang sama 
				var _totalScore:int = 0;
				for (var i:int = 0; i < Config.scoreAllLevels.length; i++)
					_totalScore+= Config.scoreAllLevels[i];
				
				if (Config.usingOnlineData)
					IDI.idnet.advancedScoreSubmitList(_totalScore, 'HighScore');
				else {
					m_warningSave.visible = true;
				}
			}
			
			else if (_touchHighScore) {
				Music.GRUP_GAME.playFx(Music.sfx_cteck, 0.35);
				trace("show highscore")
				if (Config.usingOnlineData) {
					m_block.visible = true;
					IDI.idnet.advancedScoreList('HighScore');
				} else {
					m_warningSave.visible = true;
				}
				
			}
			
			else if (_touchAchievements) {
				Music.GRUP_GAME.playFx(Music.sfx_cteck, 0.35);
				trace("show achievements");
				if (Config.usingOnlineData) {
					m_block.visible = true;
					IDI.idnet.toggleInterface('achievements');
				} else {
					m_warningSave.visible = true;
				}
			}
		}
		
		
		public function onTouchBtn(_e:TouchEvent)
		{
			var _touchNext		: Touch	= _e.getTouch(m_btnContinue, 	TouchPhase.ENDED);
			var _touchResume	: Touch = _e.getTouch(m_btnResume, 		TouchPhase.ENDED);
			var _touchRestart2	: Touch = _e.getTouch(m_btnRestartLvl, 	TouchPhase.ENDED);
			var _touchRestart	: Touch = _e.getTouch(m_btnRestart, 	TouchPhase.ENDED);
			var _touchExit		: Touch = _e.getTouch(m_btnExit, 		TouchPhase.ENDED);
			var _touchExit2		: Touch = _e.getTouch(m_btnMenu, 	TouchPhase.ENDED);
			
			var _touchVolume	: Touch = _e.getTouch(m_btnVolume, 		TouchPhase.ENDED); 
			var _touchCinematic	: Touch = _e.getTouch(m_btnCinematic, 	TouchPhase.ENDED); 
			
			var _touchGameOver:Touch = _e.getTouch(m_gameOver, 	TouchPhase.ENDED); 
			
			if (_touchNext && m_btnContinue.alpha == 1) {
				
				if (Config.currLevel < Config.MAXLEVEL) {
					Music.GRUP_GAME.playFx(Music.sfx_cteck, 0.35);
					pauseSfx(true);
					Config.currLevel++;
					Config.load();
					Config.restart();
					showTransition("Please Wait ...");
					TweenMax.delayedCall(1, signal_nextLevel.dispatch);
				}
				else {
					m_gameOver.showGameOver();
				}
				
				m_achievements.visible = false;
				m_highscore.visible = false;
				m_submitHighscore.visible = false;
				m_y8Logo.visible = false;
				//TweenMax.delayedCall(1.1, function() { Config.counterChat++;});
			}
			if (_touchResume) { 
				Music.GRUP_GAME.playFx(Music.sfx_cteck, 0.35);
				hideMenu(); 
			}
			if (_touchRestart || _touchRestart2 ) { 
				m_y8Logo.visible = false;
				m_achievements.visible = false;
				m_highscore.visible = false;
				m_submitHighscore.visible =  false;
				
				if(Config.usingOnlineData) MyAchievements.show_restart();
				
				Music.GRUP_GAME.playFx(Music.sfx_cteck, 0.35);
				pauseSfx(true);
				showTransition("Please Wait ...");
				TweenMax.delayedCall(1, signal_restart.dispatch); 
			}
			if (_touchExit || _touchExit2 || _touchGameOver) { 
				m_gameOver.visible = false;
				m_submitHighscore.visible = false;
				m_achievements.visible = false;
				m_highscore.visible = false;
				m_y8Logo.visible = false;
				m_txtPlayMore.visible = false;
				
				Music.GRUP_GAME.playFx(Music.sfx_cteck, 0.35);
				pauseSfx(true);
				showTransition("Please Wait ...");
				TweenMax.delayedCall(1, signal_exit.dispatch); 
			}
			if (_touchCinematic) {
				if(Config.usingOnlineData) MyAchievements.show_cinematic();
				
				Music.GRUP_GAME.playFx(Music.sfx_cteck, 0.35);
				Config.isCinematic = (Config.isCinematic)?false:true;
				m_btnCinematic.upState = (Config.isCinematic)? 
				Ast.img("uiBattle","btnCinema_on"):Ast.img("uiBattle", "btnCinema_off")
			}
			if (_touchVolume) {
				
				TweenMax.delayedCall(0.5, function() {
					Config.isSounded = (Config.isSounded)?false:true;
					m_btnVolume.upState = (Config.isSounded)?
					Ast.img("uiBattle", "btnVolume_on"):Ast.img("uiBattle", "btnVolume_off")
					Music.mute(!(Config.isSounded));
				});
				
				Music.GRUP_GAME.playFx(Music.sfx_cteck, 0.35);;
			}
		}
		
		private function pauseSfx(_pauseEnding:Boolean=false)
		{
			Music.GRUP_GAME.getSound(Music.bg_player).pause();
			Music.GRUP_GAME.getSound(Music.bg_enemy).pause();
			Music.GRUP_GAME.getSound(Music.bg_forest).pause();
			
			if (_pauseEnding) {
				Music.GRUP_GAME.getSound(Music.sfx_ending).pause();
				Music.GRUP_GAME.getSound(Music.sfx_ending2).pause();
			}
		}
		
		private function showPlayMore(_isMenu:Boolean):void 
		{
			if (Config.validateDomain_y8()) {
				m_txtPlayMore.visible = false;
				m_txtPlayMore.useHandCursor = false;
				m_y8Logo.useHandCursor = false;
			} else {
				m_txtPlayMore.visible = true;
				m_txtPlayMore.useHandCursor = true;
				m_y8Logo.useHandCursor = true;
				
				if (_isMenu) {
					m_txtPlayMore.x = AL.halfStageWidth;
					m_txtPlayMore.y = AL.stageHeight - 25;
					m_txtPlayMore.alpha = 0;
					TweenMax.to(m_txtPlayMore, 0.5, { alpha:1, delay:1 } );
				} else {
					m_txtPlayMore.x = AL.halfStageWidth;
					m_txtPlayMore.y = 35;
					m_txtPlayMore.alpha = 0;
					TweenMax.to(m_txtPlayMore, 0.5, { alpha:1, delay:1 } );
				}
			}
		}
		
	}

}