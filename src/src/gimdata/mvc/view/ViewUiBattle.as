package gimdata.mvc.view 
{
	import al.core.AL;
	import al.core.Ast;
	import al.display.SpriteAL;
	import al.list.Port;
	import al.objects.Box;
	import com.greensock.easing.Bounce;
	import com.greensock.easing.Elastic;
	import com.greensock.easing.Strong;
	import com.greensock.TweenMax;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import gimdata.core.config.Config;
	import gimdata.core.config.Music;
	import gimdata.mvc.control.action.Action;
	import gimdata.mvc.control.ControlBattle;
	import gimdata.mvc.model.ModelBattle;
	import gimdata.mvc.view.tutorial.TutLevel1;
	import gimdata.mvc.view.tutorial.TutLevel10;
	import gimdata.mvc.view.tutorial.TutLevel2;
	import gimdata.mvc.view.tutorial.TutLevel3;
	import gimdata.mvc.view.tutorial.TutLevel4;
	import gimdata.mvc.view.tutorial.TutLevel5;
	import gimdata.mvc.view.tutorial.TutLevel6;
	import gimdata.mvc.view.tutorial.TutLevel7;
	import gimdata.mvc.view.tutorial.TutLevel8;
	import gimdata.mvc.view.tutorial.TutLevel9;
	import gimdata.objects.gui.Confirmation;
	import gimdata.objects.gui.InfoTile;
	import gimdata.objects.gui.InfoUnit;
	import gimdata.objects.tutorial.ChatBox;
	import org.as3coreaddendum.system.Enum;
	import org.osflash.signals.Signal;
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.filters.ColorMatrixFilter;
	import starling.text.TextField;
	import starling.utils.HAlign;
	/**
	 * ...
	 * @author Aldy Ahsadin
	 */
	public class ViewUiBattle extends SpriteAL
	{
		
		public function ViewUiBattle(_mBattle:ModelBattle, _vBattle:ViewBattle, _cBattle:ControlBattle) 
		{
			
			m_modelBattle 		= _mBattle;
			m_viewBattle		= _vBattle;
			m_controlBattle		= _cBattle;
			
			signal_menu			= new Signal();
			signal_report		= new Signal(String);
			signal_simulation	= new Signal();
			signal_imap			= new Signal();
			
			// ----------------------------------------------------
			//                         UI
			// ----------------------------------------------------
			
			// -- ui button --
			m_btnEndTurn 		= new Button(Ast.img("uiBattle", "btnTurn_0"), "", Ast.img("uiBattle", "btnTurn_1"));
			m_btnMenu 			= new Button(Ast.img("uiBattle", "btnPause_0"), "", Ast.img("uiBattle", "btnPause_1"));
			m_btnMission		= new Button(Ast.img("btnBook2"), "");
			m_btnIMap 			= new Button(Ast.img("uiBattle", "btnIMap_0"), "", Ast.img("uiBattle", "btnIMap_1"));
			m_btnGuide			= new Button(Ast.img("uiBattle", "btnBook_0"), "", Ast.img("uiBattle", "btnBook_1"));
						
			m_btnEndTurn.scaleX	= 0.45;
			m_btnEndTurn.scaleY	= 0.45;
			m_btnMenu.scaleX	= 0.45;
			m_btnMenu.scaleY	= 0.45;
			m_btnIMap.scaleX	= 0.45;
			m_btnIMap.scaleY	= 0.45;
			m_btnGuide.scaleX	= 0.45;
			m_btnGuide.scaleY	= 0.45;
			
			m_btnIMap.scaleX	= 0.45;
			m_btnIMap.scaleY	= 0.45;
			m_btnMission.scaleX	= 0.45;
			m_btnMission.scaleY	= 0.45;
			
			m_btnEndTurn.scaleWhenDown	= 0.7;
			m_btnMenu.scaleWhenDown		= 0.7;
			m_btnIMap.scaleWhenDown		= 0.7;
			m_btnGuide.scaleWhenDown	= 0.7;
			
			m_btnEndTurn.x		= AL.stageWidth	- m_btnEndTurn.width - 20;
			m_btnEndTurn.y		= -75;
			m_btnMenu.x			= 20;
			m_btnMenu.y			= -75;
			m_btnMission.x		= m_btnMenu.x + m_btnMenu.width + 15;
			m_btnMission.y		= -75;
			m_btnGuide.x		= m_btnMission.x + m_btnMission.width + 15;
			m_btnGuide.y		= -75;
			m_btnIMap.x			= m_btnGuide.x + m_btnGuide.width + 15;
			m_btnIMap.y			= -75;
			
			m_btnEndTurn.addEventListener(TouchEvent.TOUCH, onTouch);
			m_btnMenu	.addEventListener(TouchEvent.TOUCH, onTouch);
			m_btnIMap	.addEventListener(TouchEvent.TOUCH, onTouch);
			m_btnGuide	.addEventListener(TouchEvent.TOUCH, onTouch);
			m_btnMission.addEventListener(TouchEvent.TOUCH, onTouch);
						
			// -------------------
			m_vInfoUnit			= new InfoUnit();
			m_vInfoUnit.x		= -300;
			m_vInfoUnit.y		= -300;
			
			m_vInfoTile			= new InfoTile();
			m_vInfoTile.x		= -300;
			m_vInfoTile.y		= -300;
			
			m_vConfirmation		= new Confirmation();
			m_vConfirmation.x	= 10;
			m_vConfirmation.y	= 10;
			m_vConfirmation.visible = false;
			
			tutorial			= createTutorial();
			tutorial.signal_close.add(onShowNotif);
			m_help				= new ViewHelp();
			//--------------
			screenBlock			= new Box(AL.stageWidth, AL.stageHeight, 0x0, 0, 0);
			screenBlock.alpha	= 0;
			screenBlock.visible	= false;
			
			screenBlockImap			= new Box(AL.stageWidth, AL.stageHeight, 0x0, 0, 0);
			screenBlockImap.alpha	= 0;
			screenBlockImap.visible	= false;
			
			//---------------------
			m_transition		= new Box(AL.stageWidth, AL.stageHeight, 0x0, 0, 0, 0);
			m_transition.alpha	= 1;
			m_transition.visible = false;
			m_textPlzWait		= new TextField(AL.stageWidth, AL.stageHeight / 5, "Enemy's Turn ...", "Verdana", 20, 0xFFFFFF, true);
			m_textPlzWait.visible = false;
			m_textPlzWait.y		= AL.stageHeight - m_textPlzWait.height;
			
			m_sponsorLogo		= new Image(Ast.img("sponsorLogo"));
			m_sponsorLogo.pivotX = m_sponsorLogo.width / 2;
			m_sponsorLogo.pivotY = m_sponsorLogo.height / 2;
			m_sponsorLogo.scaleX = 0.5;
			m_sponsorLogo.scaleY = 0.5;
			m_sponsorLogo.x		= AL.halfStageWidth;
			m_sponsorLogo.y		= AL.halfStageHeight;
			m_sponsorLogo.visible = false;
			m_sponsorLogo.addEventListener(TouchEvent.TOUCH, onTouch_sponsor);
			
			// ---------------------
			// NOTIF
			// ---------------------
			
			m_notifMission 	= new Image(Ast.img("notif"));
			m_notifGuide	= new Image(Ast.img("notif"));
			m_notifIMap		= new Image(Ast.img("notif"));
			
			
			m_notifMission.pivotX 	= m_notifMission.width / 2;
			m_notifMission.pivotY 	= m_notifMission.height / 2;	
			m_notifMission.scaleX 	= 0.7;
			m_notifMission.scaleY 	= 0.7;
			
			m_notifGuide.pivotX 	= m_notifGuide.width / 2;
			m_notifGuide.pivotY 	= m_notifGuide.height / 2;	
			m_notifGuide.scaleX 	= 0.7;
			m_notifGuide.scaleY 	= 0.7;
			
			m_notifIMap.pivotX 		= m_notifIMap.width / 2;
			m_notifIMap.pivotY 		= m_notifIMap.height / 2;	
			m_notifIMap.scaleX 		= 0.7;
			m_notifIMap.scaleY 		= 0.7;
			
			m_notifMission.x	= m_btnMission.x+35;
			m_notifMission.y	= 35;
			m_notifGuide.x		= m_btnGuide.x +35;
			m_notifGuide.y		= 35;
			m_notifIMap.x		= m_btnIMap.x + 35;
			m_notifIMap.y		= 35;
			
			m_notifMission.visible 	= false;
			m_notifGuide.visible	= false;
			m_notifIMap.visible		= false;
			
			m_btnMission.visible 	= false;
			m_btnGuide.visible		= false;
			m_btnIMap.visible		= false;
			
			m_textTurn 			= new TextField(130, 34, "", "badabom", 25, 0xFFFFFF);
			m_textTurn.text		= "TIME: " + Config.day + "/" + Config.limitDay;
			m_textTurn.pivotX	= m_textTurn.width / 2;
			m_textTurn.x		= m_btnEndTurn.x - (m_textTurn.width / 2) - 20;
			m_textTurn.y		= ((AL.port!=Port.WEB)?5:0);
			//m_textTurn.border	= true;
			m_textTurn.hAlign	= HAlign.RIGHT;
			
			m_txtPlayMore	= new TextField(300, 50, "Play More Games", "Verdana", 20, 0xFFFFFF);
			m_txtPlayMore.pivotX = m_txtPlayMore.width / 2;
			m_txtPlayMore.y	=  m_sponsorLogo.y - m_sponsorLogo.height / 2 - m_txtPlayMore.height - 5;
			m_txtPlayMore.x = AL.halfStageWidth;
			m_txtPlayMore.visible = false;
			m_txtPlayMore.addEventListener(TouchEvent.TOUCH, onTouch_sponsor);
			
			
			// ---------------------
			// USER GUIDE
			// ---------------------
			m_chat	= new ChatBox();
			m_chat.signal_skip.add(onCloseChat);
						
			// ---------------------
			
			addChild(m_btnEndTurn);
			addChild(m_btnMenu);
			addChild(m_btnMission);
			addChild(m_btnGuide);
			addChild(m_textTurn)
			addChild(screenBlockImap);
			addChild(m_btnIMap);
			
			addChild(m_notifMission);
			addChild(m_notifGuide);
			addChild(m_notifIMap);
			
			addChild(screenBlock);
			
			addChild(m_vInfoUnit);
			addChild(m_vInfoTile);
			addChild(m_vConfirmation);
			
			addChild(m_transition);
			addChild(m_textPlzWait);
			addChild(m_sponsorLogo);
			addChild(m_txtPlayMore);
			addChild(tutorial);
			addChild(m_help);
			
			addChild(m_chat);
			
			// ------------------------
			showAllButtons();
			
		}
		
		private function onTouch_sponsor(e:TouchEvent):void 
		{
			var _touch:Touch = e.getTouch(m_sponsorLogo, TouchPhase.ENDED);
			var _touchPlayMore:Touch = e.getTouch(m_txtPlayMore, TouchPhase.ENDED);
			
			if (_touchPlayMore) {
				
				if (Config.validateDomain_y8()) {
					
				} else {
					var myURL:URLRequest = new URLRequest("http://www.y8.com/?utm_source="+Config.URL+"&utm_medium=g_moregames&utm_campaign=pixelconflict");
					navigateToURL(myURL, "_blank");
				}
			}
			
			if (_touch)
			{
				if (Config.validateDomain_y8()) {
					
				} else {
					var myURL:URLRequest = new URLRequest("http://www.y8.com/?utm_source="+Config.URL+"&utm_medium=g_iglogo&utm_campaign=pixelconflict");
					navigateToURL(myURL, "_blank");
					
				}
			}
		}
		
		
		private var m_modelBattle	: ModelBattle;
		private var m_viewBattle	: ViewBattle;
		private var m_controlBattle	: ControlBattle;
		
		// ui btn
		private var m_btnEndTurn	: Button
		private var m_btnIMap		: Button;
		private var m_btnMission	: Button;
		private var m_btnMenu		: Button;
		private var m_btnGuide		: Button;
		
		// info box dialog
		private var m_vInfoUnit		: InfoUnit;
		private var m_vInfoTile		: InfoTile;
		private var m_vConfirmation	: Confirmation;
		
		// border
		private var m_effectUp		: Image;
		
		// blok screen biar ga bisa disentuh
		public var screenBlock		: Box;
		public var screenBlockImap	: Box;
		
		// user guide
		private var m_chat			:ChatBox;
		
		// transisi turn
		private	var m_transition	: Box;
		private var m_btnTurn		: Button;
		private var m_textPlzWait	: TextField;
		private var m_sponsorLogo	: Image;
		
		// handler
		public var signal_menu		: Signal;
		public var signal_report	: Signal;
		public var signal_simulation: Signal;
		public var signal_imap		: Signal;
		
		
		// tutorial+help
		public var tutorial		:IViewTutorial;
		private var m_help		:ViewHelp;
		private var m_textTurn	:TextField; 
		
		// notifikasi
		private var m_notifMission	:Image;
		private var m_notifGuide	:Image;
		private var m_notifIMap		:Image;
		
		private var m_txtPlayMore:TextField;
		
		// ----------------
		//    event 
		// ----------------
		
		private function onTouch(e:TouchEvent):void 
		{
			var _touchIMap	:Touch	= e.getTouch(m_btnIMap, 	TouchPhase.ENDED);
			var _touchMenu	:Touch	= e.getTouch(m_btnMenu, 	TouchPhase.ENDED);
			var _touchTurn	:Touch	= e.getTouch(m_btnEndTurn, 	TouchPhase.ENDED);
			var _touchGuide	:Touch	= e.getTouch(m_btnGuide, 	TouchPhase.ENDED);
			var _touchMiss	:Touch	= e.getTouch(m_btnMission, 	TouchPhase.ENDED);
			
			if (_touchIMap) {
				
				Music.GRUP_GAME.playFx(Music.sfx_cteck, 0.35);
				
				// --------------------------------------------------
				// hide buttons and show imap
				if (m_btnEndTurn.y <= -80) {
					
					m_notifIMap.visible = false;
					m_controlBattle.showIMap();
					
					screenBlockImap.visible = false;
					
					showAllButtons();
					
					TweenMax.to(m_notifMission, 0.3, { alpha: 1} );
					TweenMax.to(m_notifGuide, 	0.3, { alpha: 1} );
					TweenMax.to(m_notifIMap, 	0.3, { alpha: 1} );
					
					showChat(7);
					
				} 
				// hide imap
				else if (m_btnEndTurn.y >= 5 || m_btnEndTurn.y >= 0 ) {
					
					m_controlBattle.showIMap();
					
					screenBlockImap.visible = true;
					TweenMax.to(m_btnEndTurn, 	0.3, { y: -80});
					TweenMax.to(m_btnMenu,		0.3, { y: -80});
					TweenMax.to(m_btnGuide, 	0.3, { y: -80});
					TweenMax.to(m_btnMission, 	0.3, { y: -80});
					
					TweenMax.to(m_notifMission, 0.3, { alpha: 0});
					TweenMax.to(m_notifGuide, 	0.3, { alpha: 0});
					TweenMax.to(m_notifIMap, 	0.3, { alpha: 0});
					
					showChat(6);
				}
			} 
			
			else if (_touchGuide) {
				Music.GRUP_GAME.playFx(Music.sfx_cteck, 0.35);
				// --------------------------------------------------
				
				m_help.showHelp();
				m_notifGuide.visible = false;
				
			}
			
			else if (_touchMenu) {
				Music.GRUP_GAME.playFx(Music.sfx_cteck, 0.35);
				// --------------------------------------------------
				signal_menu.dispatch();
			}
			
			else if (_touchTurn) {
				
				Music.GRUP_LEVEL.playFx(Music.sfx_accept, 0.2);
				// --------------------------------------------------
				
				// ---------------------------------------
				// -- ganti mode
				// ---------------------------------------
				Config.turn = (Config.turn == "ally")? "enemy":"ally";
				m_modelBattle.fsm.changeState(true);
				
				//if (Config.turn == "ally") // pengecekan building... buat apa?
				//m_controlBattle.check_onBuildings();
				showPlayMore();
				showTransition("Enemy's Turn");			// KomenBuatIsiData
				signal_simulation.dispatch();
				m_modelBattle.setAllUnits_active(); 
			}
			
			else if (_touchMiss) {
				
				Music.GRUP_GAME.playFx(Music.sfx_click, 0.5);
				tutorial.playTutorial(false);
				m_notifMission.visible = false;
			}
		}
		
		// ----------------
		//    handler 
		// ----------------
		
		// -- show
		
		public function showAllButtons(){
			TweenMax.to(m_btnEndTurn, 	0.3, { y: ((AL.port!=Port.WEB)?5:0)} );
			TweenMax.to(m_btnMenu,		0.3, { y: ((AL.port!=Port.WEB)?5:0)} );
			TweenMax.to(m_btnGuide, 	0.3, { y: ((AL.port!=Port.WEB)?5:0)} );
			TweenMax.to(m_btnMission, 	0.3, { y: ((AL.port!=Port.WEB)?5:0)} );
			TweenMax.to(m_btnIMap, 		0.3, { y: ((AL.port!=Port.WEB)?5:0)} );
		}
		
		public function showTransition(_text:String) {
			m_textPlzWait.visible	= true;
			m_transition.visible 	= true;
			screenBlock.visible		= true;
			m_sponsorLogo.visible	= true;
			m_textPlzWait.text		= _text;
			
			showPlayMore();
		}
		
		public function showInfoUnit(){
			
			TweenMax.to(m_btnEndTurn, 	0.3, { y: -80} );
			TweenMax.to(m_btnIMap, 		0.3, { y: -80} );
			TweenMax.to(m_btnMenu,		0.3, { y: -80} );
			TweenMax.to(m_btnGuide, 	0.3, { y: -80} );
			TweenMax.to(m_btnMission, 	0.3, { y: -80} );
			
			TweenMax.to(m_notifMission, 0.3, { alpha: 0} );
			TweenMax.to(m_notifGuide, 	0.3, { alpha: 0} );
			TweenMax.to(m_notifIMap, 	0.3, { alpha: 0} );
			
			// set posisi
			var _targetPos:Point	= new Point();	
				_targetPos.x 		= (Config.focused.dPos.x < Config.WIDTH / 2)? (AL.stageWidth - m_vInfoUnit.width -10):10;
				_targetPos.y 		= (Config.focused.dPos.y < Config.HEIGHT / 2-1)? (AL.stageHeight - m_vInfoUnit.height-5):5;
			
			m_vInfoUnit.x		= _targetPos.x;
			m_vInfoUnit.y 		= (Config.focused.dPos.y < Config.HEIGHT / 2)? AL.stageHeight + m_vInfoUnit.height:-150;
			
			TweenMax.to(m_vInfoUnit, 	0.1, { y: _targetPos.y, ease:Strong.easeOut } );
			
			// imap
			signal_imap.dispatch();
			m_vInfoUnit.showInfo();
			
		}
		
		public function showInfoTile() {
			
			TweenMax.to(m_btnEndTurn, 	0.3, { y: -80} );
			TweenMax.to(m_btnIMap, 		0.3, { y: -80} );
			TweenMax.to(m_btnMenu,		0.3, { y: -80} );
			TweenMax.to(m_btnGuide, 	0.3, { y: -80 } );
			TweenMax.to(m_btnMission, 	0.3, { y: -80 } );
			
			TweenMax.to(m_notifMission, 0.3, { alpha: 0} );
			TweenMax.to(m_notifGuide, 	0.3, { alpha: 0} );
			TweenMax.to(m_notifIMap, 	0.3, { alpha: 0} );
			
			// set posisi
			var _targetPos:Point	= new Point();	
				_targetPos.x 		= (Config.clicked.tile.dPos.x < Config.WIDTH / 2)? (AL.stageWidth - m_vInfoTile.width -10):10;
				_targetPos.y 		= (Config.clicked.tile.dPos.y < Config.HEIGHT / 2-1)? (AL.stageHeight - m_vInfoTile.height-5):5;
			
			m_vInfoTile.x		= _targetPos.x;
			m_vInfoTile.y 		= (Config.clicked.tile.dPos.y < Config.HEIGHT / 2)? AL.stageHeight + m_vInfoTile.height:-150;
			m_vInfoTile.showInfo();
			
			TweenMax.to(m_vInfoTile, 	0.1, { y: _targetPos.y, ease:Strong.easeOut} );
			
		}
		
		public function showConfirmation() {
			
			
			//---------------------//
			// resize view
			//---------------------//
			TweenMax.to(m_viewBattle, 0.5,{ x:m_viewBattle.x-35, y:m_viewBattle.y - 45, scaleX:1, scaleY:1, ease:Strong.easeOut})
			
			// set posisi konfirmasi
			screenBlock.alpha		= 0.2;
			screenBlock.visible		= true;
			m_vConfirmation.visible = true;
			
			// set posisi konfirmasi
			var _targetPos:Point	= new Point();	
			
			switch( Config.clicked.tile.dPos.x) {
				case 0	: _targetPos.x = (Config.clicked.tile.dPos.x * 60) + 10; break;
				case 7	: _targetPos.x = (Config.clicked.tile.dPos.x * 60) - 130; break;
				default	: _targetPos.x = (Config.clicked.tile.dPos.x * 60) - 50; break;
			}
			
			switch( Config.clicked.tile.dPos.y) {
				case 0	: _targetPos.y = (Config.clicked.tile.dPos.y * 60) + 100; 	break;
				case 1	: _targetPos.y = (Config.clicked.tile.dPos.y * 60) + 90; 	break;
				case 4	: _targetPos.y = (Config.clicked.tile.dPos.y * 60) - 95; 	break;
				default	: _targetPos.y = (Config.clicked.tile.dPos.y * 60) - 80; 	break;
			}
			
			// tampilkan konfirmasi
			m_vConfirmation.alpha		= 0;
			m_vConfirmation.x			= _targetPos.x;
			m_vConfirmation.y			= _targetPos.y + 30;
			
			// ---- lihat presentase
			var _persentageTxt:String = "";
			if (Config.clicked.unit) {
				m_modelBattle.updateCoverByUnit(Config.clicked.unit.db);
				m_modelBattle.updateIMap();
				var _dmg:int	= Action.getDmgAttack(Config.focused, Config.clicked.unit, m_modelBattle)
				var _p:Number	= Math.ceil(100 * (_dmg / Config.clicked.unit.db.hpFull));
				var _def:int	= Action.getDefensiveAtk(Config.focused, m_modelBattle);
				var _enemyHP:int = Config.clicked.unit.dHP;
				
				if(Config.focused.db.category != Config.clicked.unit.db.category)
					_persentageTxt +="ENEMY:"+_enemyHP+"\nATK:-"+_dmg+"\nDEF:"+_def+"%";	
				else	
					_persentageTxt +="FRIEND:"+_enemyHP+"\nHEAL:+"+_dmg+"\nDEF:"+_def+"%";	
			} 
			else 
			{
				_persentageTxt +="DEF:"+Action.getDefensive(Config.focused, m_modelBattle)+"%";
			}
			m_vConfirmation.show(_persentageTxt);
			
			// 
			m_vConfirmation.signal_confirmation.add(onConfirmation);
			TweenMax.to(m_vConfirmation, 0.1, { alpha:1} );
						
			// hide infoUnit
			if (m_vInfoUnit.y >= 0 && m_vInfoUnit.y <= AL.stageHeight && !TweenMax.isTweening(m_vInfoUnit)) {
				var _targetPos:Point	= new Point();
					_targetPos.x		= m_vInfoUnit.x;
					_targetPos.y 		= (m_vInfoUnit.y <= 10)? -150:AL.stageHeight + m_vInfoUnit.height;
				TweenMax.to(m_vInfoUnit, 	0.1, { y: _targetPos.y, ease:Strong.easeIn} );					
			}
			
		}
		
		public function showDay() {
			
			screenBlock.visible = true;
			screenBlock.alpha	= 0.01;
			
			var _dayText:TextField=new TextField(AL.stageWidth,AL.stageHeight/5,"","badabom",50,0xFFFFFF, true);
			if (m_controlBattle.isMaxDay) {
				
				// -----------------------------
				// Music
				// -----------------------------
				screenBlock.visible = true;
				Music.GRUP_GAME.playFx(Music.sfx_clock2, 0.3);
				_dayText.text = "TIME IS UP";
				
				TweenMax.delayedCall(3, m_controlBattle.signal_report.dispatch, ["MISSION FAILED\nTime is Up!"]);
			}
			else {
				
				// -----------------------------
				// Music
				// -----------------------------
				//TweenMax.delayedCall(1, Music.GRUP_GAME.playLoop, [Music.bg_player, 0.3]);
				Music.GRUP_GAME.playFx(Music.sfx_clock, 0.2);
				
				// -----------------------------
				
				Config.day++;
				TweenMax.to(m_textTurn, 0.7, { 
								delay	:0.8, 
								scaleX	:1.25, 
								scaleY:1.25, 
								ease:Elastic.easeOut, 
								onComplete:function() {
									m_textTurn.text	= "TIME: " + Config.day + "/" + Config.limitDay;
									TweenMax.to(m_textTurn, 0.7,{scaleX:1,scaleY:1,delay:1,ease:Elastic.easeOut} );
								}
							});
							
				_dayText.text 	= "YOUR TURN";
				TweenMax.delayedCall(3, function() { screenBlock.visible = false; } );
			}
			_dayText.y			= AL.setCenterY(_dayText);
			_dayText.alpha		= 0;
			addChild(_dayText);
			
			TweenMax.to(_dayText, 0.5, { alpha:1 } );
			TweenMax.to(_dayText, 0.5, { delay: 1, alpha:0, onComplete:function() { removeChild(_dayText); }} );
			
			TweenMax.delayedCall(1.5, showChat, [11]);
		}
		
		private var m_level1:Array = [1, 10, 
									  2, 3, 4, 8, 1,
									  2, 3, 4, 8, 1, 
									  11,
									  2, 3, 4, 8, 1,
									  2, 3, 4, 8, 1,
									  11,
									  2, 3];
									  
		private var m_level2:Array = [1, 10, 
									  6, 7, 
									  2, 3, 5, 2, 1, 
									  2, 3, 4, 8, 1, 
									  6, 7, 
									  2, 3, 4, 9, 1];
		
		private var m_level3:Array = [1, 10];
		private var m_level4:Array = [1, 10];
		private var m_level5:Array = [1, 10];
		
		
		/**
		 *  1. WAITING 
			2. SHOW ALLY 
			3. CLICK TARGET
			4. CONFIRM OK
			5. CONFIRM CANCEL
			6. IMAP OPEN
			7. IMAP CLOSE
			8. END MOVE
			9. END ACTION
			10. SHOW NOTIF
			11. SHOW DAY
		 * @param	_value
		 */
		public function showChat(_value:int) {
			if (Config.turn == "ally") {
				trace("> Counter: ", Config.counterChat);
				
				//----------------------------------------------------------
				// LEVEL 1
				if (Config.counterChat != -1 && Config.currLevel == 1) {
					trace("> value: ", m_level1[Config.counterChat]);
					if (_value == m_level1[Config.counterChat]) {
						switch(Config.counterChat)
						{
							case 1:	m_chat.show_level1_1(); break;
							case 2: m_chat.show_level1_2(); break;
							case 3: m_chat.show_level1_3(); break;
							case 6: m_chat.show_level1_4(); break;
							case 11: m_chat.show_level1_5(); break;
							case 12: m_chat.show_level1_6(); break;
							case 22: m_chat.show_level1_7(); break;
							case 23: m_chat.show_level1_8(); break;
							case 24: m_chat.show_level1_9(); break;
							case 25: m_chat.show_level1_10(); break;
							
						}
					} else {
						if(Config.counterChat<m_level1.length)
							m_chat.show_caution();						
						Config.counterChat = -2;
					}
					Config.counterChat++;
				}
				
				//----------------------------------------------------------
				// LEVEL 2
				else 
				if (Config.counterChat != -1 && Config.currLevel == 2) {
					if (_value == m_level2[Config.counterChat]) {
						switch(Config.counterChat)
						{
							case 1:	m_chat.show_level2_1(); break;
							case 2: m_chat.show_level2_2(); break;
							case 3: m_chat.show_level2_3(); break;
							case 4: m_chat.show_level2_4(); break;
							case 5: m_chat.show_level2_5(); break;
							case 7: m_chat.show_level2_6(); break;
							case 8: m_chat.show_level2_7(); break;
							case 13: m_chat.show_level2_8(); break;
							case 14: m_chat.show_level2_9(); break;
							case 15: m_chat.show_level2_10(); break;
							case 20: m_chat.show_level2_11(); break;
						}
					} else {
						if(Config.counterChat<m_level2.length)
							m_chat.show_caution();						
						Config.counterChat = -2;
					}
					Config.counterChat++;
				}
				
				//----------------------------------------------------------
				// LEVEL 3
				else 
				if (Config.counterChat != -1 && Config.currLevel == 3) {
					if (_value == m_level3[Config.counterChat]) {
						switch(Config.counterChat)
						{
							case 1:	m_chat.show_level3_1(); break;
						}
					} else {
						if(Config.counterChat<m_level3.length)
							m_chat.show_caution();						
						Config.counterChat = -2;
					}
					Config.counterChat++;
				}
				
				//----------------------------------------------------------
				// LEVEL 4
				else 
				if (Config.counterChat != -1 && Config.currLevel == 4)  {
					if (_value == m_level4[Config.counterChat]) {
						switch(Config.counterChat)
						{
							case 1:	m_chat.show_level4_1(); break;
						}
					} else {
						if(Config.counterChat<m_level4.length)
							m_chat.show_caution();						
						Config.counterChat = -2;
					}
					Config.counterChat++;
				}
				
				//----------------------------------------------------------
				// LEVEL 5
				else 
				if (Config.counterChat != -1 && Config.currLevel == 5) {
					if (_value == m_level5[Config.counterChat]) {
						switch(Config.counterChat)
						{
							case 1:	m_chat.show_level5_1(); break;
						}
					} else {
						if(Config.counterChat<m_level5.length)
							m_chat.show_caution();						
						Config.counterChat = -2;
					}
					Config.counterChat++;
				}
				//----------------------------------------------------------
				
				
			}
		}
		
		// -- hide
		public function hideInfoUnit() {
			
			showAllButtons();
			
			TweenMax.to(m_notifMission, 0.3, { alpha: 1} );
			TweenMax.to(m_notifGuide, 	0.3, { alpha: 1} );
			TweenMax.to(m_notifIMap, 	0.3, { alpha: 1} );
			
			
			if (m_vInfoUnit.y >= 0 && m_vInfoUnit.y <= AL.stageHeight && !TweenMax.isTweening(m_vInfoUnit)) {
				var _targetPos:Point	= new Point();
					_targetPos.x		= m_vInfoUnit.x;
					_targetPos.y 		= (m_vInfoUnit.y <= 10)? -150:AL.stageHeight + m_vInfoUnit.height;
				TweenMax.to(m_vInfoUnit, 	0.1, { y: _targetPos.y, ease:Strong.easeIn} );					
			}
			
		}
		
		public function hideInfoTile() {
			
			showAllButtons();
			TweenMax.to(m_notifMission, 0.3, { alpha: 1} );
			TweenMax.to(m_notifGuide, 	0.3, { alpha: 1} );
			TweenMax.to(m_notifIMap, 	0.3, { alpha: 1} );
			
			
			if (m_vInfoTile.y >= 0 && m_vInfoTile.y <= AL.stageHeight && !TweenMax.isTweening(m_vInfoTile)) {
				var _targetPos:Point	= new Point();
					_targetPos.x		= m_vInfoTile.x;
					_targetPos.y 		= (m_vInfoTile.y <= 10)? -150:AL.stageHeight + m_vInfoTile.height;
				TweenMax.to(m_vInfoTile, 	0.1, { y: _targetPos.y, ease:Strong.easeIn} );					
			}
			
		}
		
		public function hideTransition() {
			m_transition.visible 	= false;
			m_textPlzWait.visible	= false;
			m_sponsorLogo.visible	= false;
			m_txtPlayMore.visible = false;
		}
		
		// -- handler
		public function onConfirmation() {
			
			m_vConfirmation.hide();
			
			if (Config.confirmation == 0) {
				m_controlBattle.hideTracks();
				showChat(5);
			} else {
				showChat(4);
			}
			
			
			screenBlock.visible	= false;
			screenBlock.alpha	= 0;
			
			TweenMax.to(m_vConfirmation, 0.5, { alpha:0, onComplete:function(){m_vConfirmation.visible = false}});
			TweenMax.to(m_viewBattle, 0.5,{ x:m_viewBattle.x + 35, y:m_viewBattle.y + 45, scaleX:0.85, scaleY:0.85, ease:Strong.easeOut})
			
			showInfoUnit();
			m_modelBattle.fsm.changeState();
		}
		
		private var notifShown:Boolean = false;
		private function onShowNotif()
		{
			if (!notifShown) {
				showChat(10);
				notifShown = true;
				switch(Config.currLevel)
				{
					case 1: m_btnMission.visible	= true;
							m_btnGuide.visible		= true;
							
							m_notifMission.visible 	= true;
							m_notifGuide.visible 	= true;
							break;
							
					case 2: m_btnMission.visible	= true;
							m_btnGuide.visible		= true;
							m_notifGuide.visible 	= true;
							m_btnIMap.visible		= true;
							m_notifIMap.visible		= true;
							
							break;
							
					case 3: m_btnMission.visible	= true;
							m_btnGuide.visible		= true;
							m_btnIMap.visible		= true;
							m_notifGuide.visible	= true;
							break;
							
					case 4: m_btnMission.visible	= true;
							m_btnGuide.visible		= true;
							m_btnIMap.visible		= true;
							m_notifGuide.visible	= true;
							break;
							
					case 5: m_btnMission.visible	= true;
							m_btnGuide.visible		= true;
							m_btnIMap.visible		= true;
							m_notifGuide.visible	= true;
							break;
							
					default:m_btnMission.visible	= true;
							m_btnGuide.visible		= true;
							m_btnIMap.visible		= true;
							break;
				}
				
				m_notifMission.alpha 	= 0;
				m_notifGuide.alpha		= 0;
				m_notifIMap.alpha		= 0;
				
				switch(Config.currLevel)
				{
					case 1: TweenMax.to(m_notifMission, 0.7, {alpha:1, delay:1, scaleX:1.2, scaleY:1.2, ease:Bounce.easeOut } );
							TweenMax.to(m_notifGuide, 0.7, {alpha:1, delay:1 , scaleX:1.2, scaleY:1.2, ease:Bounce.easeOut } );
							break;
					case 2: TweenMax.to(m_notifGuide, 0.7, {alpha:1, delay:1 , scaleX:1.2, scaleY:1.2, ease:Bounce.easeOut } );
							TweenMax.to(m_notifIMap, 0.7, { alpha:1, delay:1 , scaleX:1.2, scaleY:1.2, ease:Bounce.easeOut } );
							break;	
					case 3: TweenMax.to(m_notifGuide, 0.7, {alpha:1, delay:1 , scaleX:1.2, scaleY:1.2, ease:Bounce.easeOut } );
							break;	
					case 4: TweenMax.to(m_notifGuide, 0.7, { alpha:1, delay:1 , scaleX:1.2, scaleY:1.2, ease:Bounce.easeOut } );
							break;	
					case 5: TweenMax.to(m_notifGuide, 0.7, { alpha:1, delay:1 , scaleX:1.2, scaleY:1.2, ease:Bounce.easeOut } );
							break;	
					
							
				}
				
			}
			
		}
		
		private function onCloseChat()
		{
			Config.counterChat = -1;
		}
		
		// -- factory method
		private function createTutorial():IViewTutorial
		{
			switch(Config.currLevel) {
				case 1: return new TutLevel1(); break;
				case 2: return new TutLevel2(); break;
				case 3: return new TutLevel3(); break;
				case 4: return new TutLevel4(); break;
				case 5: return new TutLevel5(); break;
				case 6: return new TutLevel6(); break;
				case 7: return new TutLevel7(); break;
				case 8: return new TutLevel8(); break;
				case 9: return new TutLevel9(); break;
				case 10: return new TutLevel10(); break;
			}
		}
		
		private function showPlayMore():void 
		{
			if (Config.validateDomain_y8()) {
				m_txtPlayMore.visible = false;
				m_txtPlayMore.useHandCursor = false;
				m_sponsorLogo.useHandCursor = false;
			} else {
				m_txtPlayMore.visible = true;
				m_txtPlayMore.useHandCursor = true;
				m_sponsorLogo.useHandCursor = true;
			}
		}
		
	}

}