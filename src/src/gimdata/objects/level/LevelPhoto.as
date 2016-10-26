package gimdata.objects.level 
{
	import adobe.utils.CustomActions;
	import al.core.AL;
	import al.core.Ast;
	import al.display.SpriteAL;
	import al.objects.Box;
	import com.greensock.TweenMax;
	import flash.events.Event;
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
	
	/**
	 * ...
	 * @author Aldy Ahsadin
	 */
	public class LevelPhoto extends SpriteAL 
	{
		private var m_btnPlay	: Button
		private var m_title		: TextField
		
		private var m_photo1	: Image;
		private var m_photo2	: Image;
		private var m_photo3	: Image;
		private var m_photo4	: Image;
		private var m_photo5	: Image;
		private var m_photo6	: Image;
		private var m_photo7	: Image;
		private var m_photo8	: Image;
		private var m_photo9	: Image;
		private var m_photo10	: Image;
		
		public 	var playBattle	: Signal
		private var m_statusLevel:TextField;
		
		public function LevelPhoto() 
		{
			m_photo1			= new Image(Ast.img("levelPhoto","level01"));
			m_photo2			= new Image(Ast.img("levelPhoto","level02"));
			m_photo3			= new Image(Ast.img("levelPhoto","level03"));
			m_photo4			= new Image(Ast.img("levelPhoto","level04"));
			m_photo5			= new Image(Ast.img("levelPhoto","level05"));
			m_photo6			= new Image(Ast.img("level6"));
			m_photo7			= new Image(Ast.img("levelPhoto","level06"));
			m_photo8			= new Image(Ast.img("level8"));
			m_photo9			= new Image(Ast.img("level9"));
			m_photo10			= new Image(Ast.img("level10"));
			
			
			// -----------------------------------------------------------------------------------------------
			m_btnPlay			= new Button(Ast.img("btnPlayGame"), "Play");
			m_btnPlay.fontColor	= 0xFFFFFF;
			m_btnPlay.fontSize	= 25;
			m_btnPlay.scaleX	= 0.5;
			m_btnPlay.scaleY	= 0.5;
			m_btnPlay.pivotX	= m_btnPlay.width / 2;
			m_btnPlay.pivotY	= m_btnPlay.height / 2;
			m_btnPlay.x			= 215;
			m_btnPlay.y			= 110;
			m_btnPlay.addEventListener(TouchEvent.TOUCH, onTouch);
			
			m_title				= new TextField(200, 30, "AMBUSH", "badabom", 25, 0xFFFFFF, true);
			m_title.hAlign		= HAlign.LEFT;
			m_title.x			= 10;
			m_title.y			= 100;
			
			m_statusLevel = new TextField(150, 30, "", "verdana", 17, 0xFFFFFF);
			m_statusLevel.pivotX = m_statusLevel.width / 2;
			//m_statusLevel.pivotY = m_statusLevel.height / 2;
			m_statusLevel.x = m_photo1.width / 2;
			m_statusLevel.y = - m_statusLevel.height;
			//m_statusLevel.border = true;
			
			// -----------------------------------------------------------------------------------------------
			
			//m_photo1.x	= 20;
			//m_photo2.x	= 20;
			//m_photo3.x	= 20;
			//m_photo4.x	= 20;
			//m_photo5.x	= 20;
			//m_photo6.x	= 20;
			
			m_photo1.y	= 0;
			m_photo2.y	= 0;
			m_photo3.y	= 0;
			m_photo4.y	= 0;
			m_photo5.y	= 0;
			m_photo6.y	= 0;
			m_photo7.y	= 0;
			m_photo8.y	= 0;
			m_photo9.y	= 0;
			m_photo10.y	= 0;
			
			playBattle	= new Signal();

			addChild(m_photo1);
			addChild(m_photo2);
			addChild(m_photo3);
			addChild(m_photo4);
			addChild(m_photo5);
			addChild(m_photo6);
			addChild(m_photo7);
			addChild(m_photo8);
			addChild(m_photo9);
			addChild(m_photo10);
			
			addChild(m_title);
			addChild(m_btnPlay);
			addChild(m_statusLevel);
			
		}
		
		private function onTouch(e:TouchEvent):void 
		{
			var _touch:Touch = e.getTouch(m_btnPlay, TouchPhase.ENDED);
			if (_touch && m_btnPlay.alpha == 1) {
				TweenMax.delayedCall(0.5, playBattle.dispatch);
				Music.GRUP_LEVEL.playFx(Music.sfx_accept, 0.2);
				Music.GRUP_LEVEL.fadeTo(Music.bg_lvl, 0);
			}
		}

		public function updateData() 
		{
			
			hideAll();
			m_title.text = Config.BATTLENAME;
			
			var _levelData:Array = Config.loadLevels();
			m_btnPlay.alpha = (_levelData[Config.currLevel - 1] == 1)?1:0.2;
			
			// -----------------------------
			// check maksimum level yang nilainya 1
			
			if (Config.currLevel == 10) {
				//if(_levelData)
			} else {
				if ((_levelData[Config.currLevel - 1] == 1) && (_levelData[Config.currLevel] == 0)) {
					m_statusLevel.text = "";
				}
				else {
					m_statusLevel.text = "Level Completed";
				}
			}
				
			
			// ------------------------------
			
			switch(Config.currLevel) {
				case 1	: m_photo1.visible = true; break;
				case 2	: m_photo2.visible = true; break;
				case 3	: m_photo3.visible = true; break;
				case 4	: m_photo4.visible = true; break;
				case 5	: m_photo5.visible = true; break;
				case 6	: m_photo6.visible = true; break;
				case 7	: m_photo7.visible = true; break;
				case 8	: m_photo8.visible = true; break;
				case 9	: m_photo9.visible = true; break;
				case 10	: m_photo10.visible = true; break;
				default	: m_photoDemo.visible = true; break;
			}
		}
		
		private function hideAll() 
		{
			m_photo1.visible = false;
			m_photo2.visible = false;
			m_photo3.visible = false;
			m_photo4.visible = false;
			m_photo5.visible = false;
			m_photo6.visible = false;
			m_photo7.visible = false;
			m_photo8.visible = false;
			m_photo9.visible = false;
			m_photo10.visible = false;
			
		}
	}

}