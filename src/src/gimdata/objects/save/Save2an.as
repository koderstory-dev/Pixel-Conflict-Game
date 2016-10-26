package gimdata.objects.save 
{
	import al.core.AL;
	import al.core.Ast;
	import al.display.SpriteAL;
	import com.greensock.TweenMax;
	import flash.events.Event;
	import flash.net.navigateToURL;
	import flash.net.SharedObject;
	import flash.net.URLRequest;
	import gimdata.core.config.Config;
	import gimdata.core.config.Music;
	import org.osflash.signals.Signal;
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	/**
	 * ...
	 * @author Aldy Ahsandin
	 */
	public class Save2an extends SpriteAL 
	{
		private var m_slotOL1:TombolSave2an;
		private var m_slotOL2:TombolSave2an;
		private var m_slotOL3:TombolSave2an;
		
		private var m_slotLocal1:TombolSave2an;
		private var m_slotLocal2:TombolSave2an;
		private var m_slotLocal3:TombolSave2an;
			
		private var m_textOL:TextField;
		private var m_textLocal:TextField;
		private var idnet_logo:Image = new Image(Ast.img("idnet_logo"));
		private var m_notif:TextField;
		private var m_warning:WarningLocalSave;
		private var m_txtWelcome:TextField;
		private var m_txtWarning:TextField;
		
		public var signal_enterSlot:Signal = new Signal();
		public var signal_deleteSlot:Signal = new Signal();
		
		
		public function Save2an() 
		{
			
			idnet_logo.scaleX 	= 0.4;
			idnet_logo.scaleY 	= 0.4;
			idnet_logo.y 		= 25;
			idnet_logo.addEventListener(TouchEvent.TOUCH, onTouchIdnet);
			addChild(idnet_logo);
			//m_notif = new TextField(AL.stageWidth+150, 70, "", "verdana", 25, 0xFFFFFF);
			//m_notif.text = "Getting achievements and submitting highscore\nare only available in online save mode";
			//m_notif.x	=  -75;
			//m_notif.y = 10;
			////m_notif.border = true;
			//addChild(m_notif);
			
			// -------------------------
			// TEXT
			// -------------------------
			m_textOL 	= new TextField(250, 110, "Online Save", "badabom", 50, 0xFFFFFF);
			m_textOL.x  = -15;
			m_textOL.y 	= idnet_logo.height + 10;// m_notif.height + m_notif.y;
			m_textOL.border = true;
			m_textOL.vAlign = VAlign.BOTTOM;
			addChild(m_textOL);
			
			m_textLocal 	= new TextField(192, 110, "Local Save", "badabom", 50, 0xFFFFFF);
			m_textLocal.x	= m_textOL.width + 10;
			m_textLocal.y	= idnet_logo.height + 10;// m_notif.y + m_notif.height -25;
			//m_textLocal.border = true;
			m_textLocal.vAlign = VAlign.BOTTOM;
			addChild(m_textLocal);
			
			// ---------------------------------
			
			m_slotOL1 = new TombolSave2an();
			m_slotOL1.y	= m_textOL.height +100;
			m_slotOL1.addEventListener(TouchEvent.TOUCH, onTouch_online);
			addChild(m_slotOL1);
			
			m_slotOL2 	= new TombolSave2an();
			m_slotOL2.y	= (m_slotOL1.height+m_slotOL1.y);
			m_slotOL2.addEventListener(TouchEvent.TOUCH, onTouch_online);
			addChild(m_slotOL2);
			
			m_slotOL3 = new TombolSave2an();
			m_slotOL3.y	= (m_slotOL2.height+m_slotOL2.y);
			addChild(m_slotOL3);
			
			// --------------------------------
			 
			m_slotLocal1 	= new TombolSave2an();
			m_slotLocal1.x	= m_slotOL1.width + 30;
			m_slotLocal1.y	= m_textLocal.height + 100;
			m_slotLocal1.tombolSave.addEventListener(TouchEvent.TOUCH, onTouch_local);
			m_slotLocal1.tombolDelete.addEventListener(TouchEvent.TOUCH, onTouch_local);
			addChild(m_slotLocal1)
			
			m_slotLocal2 	= new TombolSave2an();
			m_slotLocal2.x	= m_slotOL1.width+ 30;
			m_slotLocal2.y	= (m_slotOL1.height+m_slotOL1.y);
			m_slotLocal2.tombolSave.addEventListener(TouchEvent.TOUCH, onTouch_local);
			m_slotLocal2.tombolDelete.addEventListener(TouchEvent.TOUCH, onTouch_local);
			addChild(m_slotLocal2)
			
			m_slotLocal3 	= new TombolSave2an();
			m_slotLocal3.x	= m_slotOL1.width + 30;
			m_slotLocal3.y	= (m_slotOL2.height+m_slotOL2.y);
			m_slotLocal3.tombolSave.addEventListener(TouchEvent.TOUCH, onTouch_local);
			m_slotLocal3.tombolDelete.addEventListener(TouchEvent.TOUCH, onTouch_local);
			addChild(m_slotLocal3)
			
			m_txtWelcome = new TextField(300, 110, "Welcome bro ...", "Verdana", 20, 0xFFFFFF, true);
			m_txtWelcome.x = -35;
			m_txtWelcome.y = m_textOL.y - 20;
			m_txtWelcome.border = true;
			addChild(m_txtWelcome);
			
			m_warning = new WarningLocalSave();
			m_warning.x = m_slotLocal3.x - 20;
			m_warning.y = m_slotLocal3.y + m_slotLocal3.height + 20;;
			addChild(m_warning);
			
			m_txtWarning = new TextField(300, 110, "Getting achievements and\nsubmitting score\nare only available \non online save mode", "Verdana", 20, 0xFFFFFF, true);
			m_txtWarning.x = m_slotOL3.x - 90;
			m_txtWarning.y = m_slotOL3.y + m_slotOL3.height + 15;
			m_txtWarning.hAlign = HAlign.RIGHT;
			m_txtWarning.border = true;
			addChild(m_txtWarning);
			
		}
		
		private function onTouchIdnet(e:TouchEvent):void 
		{
			var _touch:Touch = e.getTouch(idnet_logo, TouchPhase.ENDED);
			if (_touch) {
				var myURL:URLRequest = new URLRequest("http://www.id.net/");
					navigateToURL(myURL, "_blank");
			}
		}
		
		// =====================================================
		
		private function onTouch_local(e:TouchEvent)
		{
			var _touchLocal1:Touch = e.getTouch(m_slotLocal1.tombolSave, TouchPhase.ENDED);
			var _touchLocal2:Touch = e.getTouch(m_slotLocal2.tombolSave, TouchPhase.ENDED);
			var _touchLocal3:Touch = e.getTouch(m_slotLocal3.tombolSave, TouchPhase.ENDED);
			
			var _delLocal1:Touch = e.getTouch(m_slotLocal1.tombolDelete, TouchPhase.ENDED);
			var _delLocal2:Touch = e.getTouch(m_slotLocal2.tombolDelete, TouchPhase.ENDED);
			var _delLocal3:Touch = e.getTouch(m_slotLocal3.tombolDelete, TouchPhase.ENDED);
			
			if (_touchLocal1) {
				Music.GRUP_LEVEL.playFx(Music.sfx_pick, 0.3);
				Config.levels_local = SharedObject.getLocal("slotLocal_1");
				if (!Config.levels_local.data.levels) {
					Config.levels_local.data.levels = [1, 0, 0, 0, 0, 0, 0, 0, 0, 0];
					Config.levels_local.flush();
				}
				Config.currLevel = countLevelData_local(Config.levels_local);
				signal_enterSlot.dispatch();
			}
			if (_touchLocal2) {
				Music.GRUP_LEVEL.playFx(Music.sfx_pick, 0.3);
				Config.levels_local = SharedObject.getLocal("slotLocal_2");
				if (!Config.levels_local.data.levels) {
					Config.levels_local.data.levels = [1, 0, 0, 0, 0, 0, 0, 0, 0, 0];
					Config.levels_local.flush();
				}
				Config.currLevel = countLevelData_local(Config.levels_local);
				signal_enterSlot.dispatch();
			}
			if (_touchLocal3) {
				Music.GRUP_LEVEL.playFx(Music.sfx_pick, 0.3);
				Config.levels_local = SharedObject.getLocal("slotLocal_3");
				if (!Config.levels_local.data.levels) {
					Config.levels_local.data.levels = [1, 0, 0, 0, 0, 0, 0, 0, 0, 0];
					Config.levels_local.flush();
				}
				Config.currLevel = countLevelData_local(Config.levels_local);
				signal_enterSlot.dispatch();
			}
			if (_touchLocal1 || _touchLocal2 || _touchLocal3) {
				Config.onlineSlot		= 0;
				Config.usingOnlineData 	= false;
			}
			
			// ==================================================================
			
			if (_delLocal1) {
				Music.GRUP_LEVEL.playFx(Music.sfx_pick, 0.3);
				var _so:SharedObject = SharedObject.getLocal("slotLocal_1");
					_so.clear();
					m_slotLocal1.setSave(false);
					trace("delete 1");
			}
			if (_delLocal2) {
				Music.GRUP_LEVEL.playFx(Music.sfx_pick, 0.3);
				var _so:SharedObject = SharedObject.getLocal("slotLocal_2");
					_so.clear();
					m_slotLocal2.setSave(false);
			}
			if (_delLocal3) {
				Music.GRUP_LEVEL.playFx(Music.sfx_pick, 0.3);
				var _so:SharedObject = SharedObject.getLocal("slotLocal_3");
					_so.clear();
					m_slotLocal3.setSave(false);
			}
			
			
		}
		
		private function onTouch_online(e:TouchEvent)
		{
			var _touchOnline1:Touch = e.getTouch(m_slotOL1.tombolSave, TouchPhase.ENDED);
			var _touchOnline2:Touch = e.getTouch(m_slotOL2.tombolSave, TouchPhase.ENDED);
			var _touchOnline3:Touch = e.getTouch(m_slotOL3.tombolSave, TouchPhase.ENDED);
			
			var _delOnline1:Touch = e.getTouch(m_slotOL1.tombolDelete, TouchPhase.ENDED);
			var _delOnline2:Touch = e.getTouch(m_slotOL2.tombolDelete, TouchPhase.ENDED);
			var _delOnline3:Touch = e.getTouch(m_slotOL3.tombolDelete, TouchPhase.ENDED);
			
			if (_touchOnline1 || _touchOnline2 || _touchOnline3 || _delOnline1 || _delOnline2 || _delOnline3) {
				
				// kalo sudah login
				if (IDI.idnet && IDI.idnet.isLoggedIn) {
					
					// -----------------
					// SLOT 1
					// -----------------
					if (_delOnline1)
					{
						Music.GRUP_LEVEL.playFx(Music.sfx_pick, 0.3);
						
						IDI.idnet.removeUserData('slotOnline_1');
						IDI.m_saveOL_1 = "";
						m_slotOL1.setSave(false);
					}
					else if (_touchOnline1) {
						Music.GRUP_LEVEL.playFx(Music.sfx_pick, 0.3);
						
						// set level sekarang sesuai dengan data
						if (IDI.m_saveOL_1 == "") {
							IDI.m_saveOL_1 = "LEVEL #1"
							IDI.idnet.submitUserData('slotOnline_1', IDI.m_saveOL_1);
							
						}
						countLevelData_online(IDI.m_saveOL_1); 
						signal_enterSlot.dispatch();
						Config.onlineSlot = 1;
					}
					
					// -----------------
					// SLOT 2
					// -----------------
					else if (_delOnline2)
					{
						Music.GRUP_LEVEL.playFx(Music.sfx_pick, 0.3);
						
						IDI.idnet.removeUserData('slotOnline_2');
						IDI.m_saveOL_2 = "";
						m_slotOL2.setSave(false);
					}
					else if (_touchOnline2) {
						Music.GRUP_LEVEL.playFx(Music.sfx_pick, 0.3);
						
						// set level sekarang sesuai dengan data
						if (IDI.m_saveOL_2 == "") {
							IDI.m_saveOL_2 = "LEVEL #1"
							IDI.idnet.submitUserData('slotOnline_2', IDI.m_saveOL_2);
							
						}
						countLevelData_online(IDI.m_saveOL_2); 
						signal_enterSlot.dispatch();
						Config.onlineSlot = 2;
					}
					
					// -----------------
					// SLOT 3
					// -----------------
					else if (_delOnline3)
					{
						Music.GRUP_LEVEL.playFx(Music.sfx_pick, 0.3);
						
						IDI.idnet.removeUserData('slotOnline_3');
						IDI.m_saveOL_3 = "";
						m_slotOL3.setSave(false);
					}
					else if (_touchOnline3) {
						Music.GRUP_LEVEL.playFx(Music.sfx_pick, 0.3);
						
						// set level sekarang sesuai dengan data
						if (IDI.m_saveOL_3 == "") {
							IDI.m_saveOL_3 = "LEVEL #1"
							IDI.idnet.submitUserData('slotOnline_3', IDI.m_saveOL_3);
							
						}
						countLevelData_online(IDI.m_saveOL_3); 
						signal_enterSlot.dispatch();
						Config.onlineSlot = 3;
					}
					
				// kalo belum login	
				} else {
					
					IDI.idnet.toggleInterface("login");
					
					if (IDI.belum_login)
						IDI.belum_login = null;
					IDI.belum_login = new Signal();
					IDI.belum_login.addOnce(function()
					{
						checkSave2an_Online();
						IDI.belum_login = null
					});
				
				}
				
			} 
			
			
		}
		
		// ------------------------------------------------------
		
		public function checkSave2an_Local():void 
		{
			var _dataSave1: SharedObject = SharedObject.getLocal("slotLocal_1");
				//_dataSave1.data.levels 	= [1, 1, 1, 1, 1, 0, 0, 0, 0, 0];
				//_dataSave1.flush();
			
			var _dataSave2: SharedObject = SharedObject.getLocal("slotLocal_2");
				//_dataSave2.data.levels 	= [1, 1, 1, 1, 1, 1, 1, 1, 0, 0];
				//_dataSave2.flush();
				
			var _dataSave3: SharedObject = SharedObject.getLocal("slotLocal_3");
				//_dataSave3.data.levels 	= [1, 1, 1, 1, 0, 0, 0, 0, 0, 0];
				//_dataSave3.flush();
				
			// level 1
			if (_dataSave1 && _dataSave1.data.levels) 
			m_slotLocal1.setSave(true, "LEVEL #"+countLevelData_local(_dataSave1));	
			else m_slotLocal1.setSave(false);
			
			// level 2
			if (_dataSave2 && _dataSave2.data.levels) 
			m_slotLocal2.setSave(true, "LEVEL #"+countLevelData_local(_dataSave2));	
			else m_slotLocal2.setSave(false);
			
			// level 3
			if (_dataSave3 && _dataSave3.data.levels) 
			m_slotLocal3.setSave(true, "LEVEL #"+countLevelData_local(_dataSave3));	
			else m_slotLocal3.setSave(false);
			
		}
		
		public function checkSave2an_Online()
		{
			
			if (IDI.idnet && IDI.idnet.isLoggedIn) m_txtWelcome.text = "Welcome\n" + IDI.idnet.userData.nickname
			
			// -------------------------
			// slot save 1
			// -------------------------
			if (IDI.m_saveOL_1 != "") 	m_slotOL1.setSave(true, IDI.m_saveOL_1);
			else 						m_slotOL1.setSave(false);
			
			if (IDI.m_saveOL_2 != "") 	m_slotOL2.setSave(true, IDI.m_saveOL_2);
			else 						m_slotOL2.setSave(false);
			
			if (IDI.m_saveOL_3 != "") 	m_slotOL3.setSave(true, IDI.m_saveOL_3);
			else 						m_slotOL3.setSave(false);
			
			
			
			
			//(IDI.m_saveOL_1 != "")? m_slotOL1.setSave(true, "LEVEL #1"):m_slotOL1.setSave(false);
	
		}
		
		// =====================================================
		
		private function countLevelData_local(_so:SharedObject):int
		{
			var _currLevel:int = 0;
			for (var i:int = 0; i < 10; i++ ) {
				if (_so.data.levels[i] == 1)
					_currLevel++;
			}
			return _currLevel;
		}
		
		private function countLevelData_online(_data:String)
		{
			switch(_data)
			{
				case "LEVEL #1": Config.currLevel = 1; Config.levels_online 	= [1, 0, 0, 0, 0, 0, 0, 0, 0, 0]; break;
				case "LEVEL #2": Config.currLevel = 2; Config.levels_online 	= [1, 1, 0, 0, 0, 0, 0, 0, 0, 0]; break;
				case "LEVEL #3": Config.currLevel = 3; Config.levels_online 	= [1, 1, 1, 0, 0, 0, 0, 0, 0, 0]; break;
				case "LEVEL #4": Config.currLevel = 4; Config.levels_online 	= [1, 1, 1, 1, 0, 0, 0, 0, 0, 0]; break;
				case "LEVEL #5": Config.currLevel = 5; Config.levels_online 	= [1, 1, 1, 1, 1, 0, 0, 0, 0, 0]; break;
				case "LEVEL #6": Config.currLevel = 6; Config.levels_online 	= [1, 1, 1, 1, 1, 1, 0, 0, 0, 0]; break;
				case "LEVEL #7": Config.currLevel = 7; Config.levels_online 	= [1, 1, 1, 1, 1, 1, 1, 0, 0, 0]; break;
				case "LEVEL #8": Config.currLevel = 8; Config.levels_online 	= [1, 1, 1, 1, 1, 1, 1, 1, 0, 0]; break;
				case "LEVEL #9": Config.currLevel = 9; Config.levels_online 	= [1, 1, 1, 1, 1, 1, 1, 1, 1, 0]; break;
				case "LEVEL #10": Config.currLevel = 10; Config.levels_online 	= [1, 1, 1, 1, 1, 1, 1, 1, 1, 1]; break;
			}
			Config.usingOnlineData = true;
		}
		
		private function loadDataAchievements()
		{
			
		}
	}

}