package gimdata.mvc.view 
{
	import al.core.AL;
	import al.core.Ast;
	import al.display.SpriteAL;
	import al.objects.Box;
	import com.greensock.easing.Elastic;
	import com.greensock.easing.Strong;
	import com.greensock.TweenMax;
	import flash.events.Event;
	import gimdata.core.config.Config;
	import gimdata.core.config.Music;
	import gimdata.objects.tutorial.DataHelp;
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.filters.ColorMatrixFilter;
	import starling.text.TextField;
	
	/**
	 * ...
	 * @author ...
	 */
	public class ViewHelp extends SpriteAL 
	{
		private var m_shade	:Box;
		private var m_window:Image;
		private var m_text:TextField;
		
		private var m_btn1	:Button;
		private var m_btn2	:Button;
		private var m_btn3	:Button;
		private var m_btn4	:Button;
		private var m_btn5	:Button;
		private var m_btn6	:Button;
		private var m_btn7	:Button;
		private var m_btn8	:Button;
		private var m_bClose:Button;
		
		private var m_data	:DataHelp;
		private var m_filter:ColorMatrixFilter = new ColorMatrixFilter();
				
		
		public function ViewHelp() 
		{
			m_filter.tint(0xFFFFFF, 0.9);
			
			m_shade 		= new Box(AL.stageWidth, AL.stageHeight, 0x0, 0.5, 0);
			m_shade.alpha 	= 0.5;
			addChild(m_shade)
			
			m_window		= new Image(Ast.img("window_form"));
			m_window.pivotX	= m_window.width / 2;
			m_window.pivotY = m_window.height / 2;
			m_window.scaleX	= 0.8;
			m_window.scaleY	= 0.8;
			m_window.x		= AL.halfStageWidth;
			m_window.y		= AL.halfStageHeight;
			addChild(m_window);
			
			m_text		= new TextField(150, 70, "Unitpedia", "badabom", 40, 0xFFFFFF);
			m_text.pivotX	= m_text.width / 2;
			m_text.pivotY	= m_text.height / 2;
			m_text.x	= AL.halfStageWidth;
			m_text.y	= 30;
			addChild(m_text);
			
			m_data		= new DataHelp();
			m_data.pivotX = m_data.width / 2;
			m_data.pivotY = m_data.height / 2;
			m_data.x	= AL.halfStageWidth;
			m_data.y	= 130;
			addChild(m_data);
			
			m_btn1			= new Button(Ast.img("btnPlayGame"), "1");
			m_btn1.addEventListener(TouchEvent.TOUCH, onTouch);
			m_btn1.fontColor = 0xFFFFFF;
			m_btn1.fontSize	= 30;
			m_btn1.fontBold	= true;
			m_btn1.pivotX	= m_btn1.width / 2;
			m_btn1.pivotY	= m_btn1.height / 2;
			m_btn1.scaleX 	= 0.3;
			m_btn1.scaleY 	= 0.4;
			m_btn1.x		= 70 + (0 * m_btn1.width);
			m_btn1.y		= 65;
			m_btn1.alpha	= 1;
			addChild(m_btn1);
			
			m_btn2			= new Button(Ast.img("btnPlayGame"), "2");
			m_btn2.addEventListener(TouchEvent.TOUCH, onTouch);
			m_btn2.fontColor = 0xFFFFFF;
			m_btn2.fontSize	= 30;
			m_btn2.fontBold	= true;
			m_btn2.pivotX	= m_btn2.width / 2;
			m_btn2.pivotY	= m_btn2.height / 2;
			m_btn2.scaleX 	= 0.3;
			m_btn2.scaleY 	= 0.4;
			m_btn2.x		= 70 + (1 * (m_btn2.width+10));
			m_btn2.y		= 65;
			addChild(m_btn2);
			
			m_btn3			= new Button(Ast.img("btnPlayGame"), "3");
			m_btn3.addEventListener(TouchEvent.TOUCH, onTouch);
			m_btn3.fontColor = 0xFFFFFF;
			m_btn3.fontSize	= 30;
			m_btn3.fontBold	= true;
			m_btn3.pivotX	= m_btn3.width / 2;
			m_btn3.pivotY	= m_btn3.height / 2;
			m_btn3.scaleX 	= 0.3;
			m_btn3.scaleY 	= 0.4;
			m_btn3.x		= 70 + (2 * (m_btn3.width+10));
			m_btn3.y		= 65;
			addChild(m_btn3);
			
			m_btn4			= new Button(Ast.img("btnPlayGame"), "4");
			m_btn4.addEventListener(TouchEvent.TOUCH, onTouch);
			m_btn4.fontColor = 0xFFFFFF;
			m_btn4.fontSize	= 30;
			m_btn4.fontBold	= true;
			m_btn4.pivotX	= m_btn4.width / 2;
			m_btn4.pivotY	= m_btn4.height / 2;
			m_btn4.scaleX 	= 0.3;
			m_btn4.scaleY 	= 0.4;
			m_btn4.x		= 70 + (3 * (m_btn4.width+10));
			m_btn4.y		= 65;
			addChild(m_btn4);
			
			m_btn5			= new Button(Ast.img("btnPlayGame"), "5");
			m_btn5.addEventListener(TouchEvent.TOUCH, onTouch);
			m_btn5.fontColor = 0xFFFFFF;
			m_btn5.fontSize	= 30;
			m_btn5.fontBold	= true;
			m_btn5.pivotX	= m_btn5.width / 2;
			m_btn5.pivotY	= m_btn5.height / 2;
			m_btn5.scaleX 	= 0.3;
			m_btn5.scaleY 	= 0.4;
			m_btn5.x		= 70 + (4 * (m_btn5.width+10));
			m_btn5.y		= 65;
			addChild(m_btn5);
			
			m_btn6			= new Button(Ast.img("btnPlayGame"), "6");
			m_btn6.addEventListener(TouchEvent.TOUCH, onTouch);
			m_btn6.fontColor = 0xFFFFFF;
			m_btn6.fontSize	= 30;
			m_btn6.fontBold	= true;
			m_btn6.pivotX	= m_btn6.width / 2;
			m_btn6.pivotY	= m_btn6.height / 2;
			m_btn6.scaleX 	= 0.3;
			m_btn6.scaleY 	= 0.4;
			m_btn6.x		= 70 + (5 * (m_btn6.width+10));
			m_btn6.y		= 65;
			addChild(m_btn6);
			
			m_btn7			= new Button(Ast.img("btnPlayGame"), "7");
			m_btn7.addEventListener(TouchEvent.TOUCH, onTouch);
			m_btn7.fontColor = 0xFFFFFF;
			m_btn7.fontSize	= 30;
			m_btn7.fontBold	= true;
			m_btn7.pivotX	= m_btn7.width / 2;
			m_btn7.pivotY	= m_btn7.height / 2;
			m_btn7.scaleX 	= 0.3;
			m_btn7.scaleY 	= 0.4;
			m_btn7.x		= 70 + (6 * (m_btn7.width+10));
			m_btn7.y		= 65;
			addChild(m_btn7);
			
			m_btn8			= new Button(Ast.img("btnPlayGame"), "8");
			m_btn8.addEventListener(TouchEvent.TOUCH, onTouch);
			m_btn8.fontColor = 0xFFFFFF;
			m_btn8.fontSize	= 30;
			m_btn8.fontBold	= true;
			m_btn8.pivotX	= m_btn8.width / 2;
			m_btn8.pivotY	= m_btn8.height / 2;
			m_btn8.scaleX 	= 0.3;
			m_btn8.scaleY 	= 0.4;
			m_btn8.x		= 70 + (7 * (m_btn8.width+10));
			m_btn8.y		= 65;
			addChild(m_btn8);
			
			m_bClose				= new Button(Ast.img("btnPlayGame"), "close");
			m_bClose.fontSize 		= 25;
			m_bClose.fontBold		= true;
			m_bClose.fontColor		= 0xFFFFFF;
			m_bClose.scaleWhenDown 	= 0.5;
			m_bClose.scaleX 		= 0.7;
			m_bClose.scaleY 		= 0.7;
			m_bClose.x				= AL.setCenterX(m_bClose);
			m_bClose.y				= (m_window.y) + (2*m_bClose.height);
			m_bClose.addEventListener(TouchEvent.TOUCH, onTouch);
			addChild(m_bClose);
			
			// ---  set All visible false
			m_btn1.visible		= false;
			m_btn2.visible		= false;
			m_btn3.visible		= false;
			m_btn4.visible		= false;
			m_btn5.visible		= false;
			m_btn6.visible		= false;
			m_btn7.visible		= false;
			m_btn8.visible		= false;
			m_bClose.visible	= false;
			m_shade.visible		= false;
			m_window.visible	= false;
			m_bClose.visible	= false;
			m_data.visible		= false;
			m_text.visible		= false;
			
			m_btn1.filter = m_filter;
			m_btn2.filter = m_filter;
			m_btn3.filter = m_filter;
			m_btn4.filter = m_filter;
			m_btn5.filter = m_filter;
			m_btn6.filter = m_filter;
			m_btn7.filter = m_filter;
			m_btn8.filter = m_filter;
		
		}
		
		private function onTouch(e:TouchEvent):void 
		{
			var _touch:Touch = e.getTouch(m_bClose, TouchPhase.ENDED);
			
			var _touchBtn1:Touch = e.getTouch(m_btn1, TouchPhase.ENDED);
			var _touchBtn2:Touch = e.getTouch(m_btn2, TouchPhase.ENDED);
			var _touchBtn3:Touch = e.getTouch(m_btn3, TouchPhase.ENDED);
			var _touchBtn4:Touch = e.getTouch(m_btn4, TouchPhase.ENDED);
			var _touchBtn5:Touch = e.getTouch(m_btn5, TouchPhase.ENDED);
			var _touchBtn6:Touch = e.getTouch(m_btn6, TouchPhase.ENDED);
			var _touchBtn7:Touch = e.getTouch(m_btn7, TouchPhase.ENDED);
			var _touchBtn8:Touch = e.getTouch(m_btn8, TouchPhase.ENDED);
			
			
			if (_touch) closeHelp();
			else if (_touchBtn1 && m_btn1.alpha == 1) {
				Music.GRUP_GAME.playFx(Music.sfx_cteck, 0.35);
				resetButton();
				m_btn1.filter 	= null;
				m_btn1.alpha	= 0;
				m_btn1.scaleX	= 0.35;
				m_btn1.scaleY	= 0.45;
				TweenMax.to(m_btn1, 0.5, { alpha:1 } );
				
				m_data.alpha = 0;
				TweenMax.to(m_data, 1, { alpha:1 } );
				m_data.show(1);
			}
			
			else if (_touchBtn2 && m_btn2.alpha==1) {
				Music.GRUP_GAME.playFx(Music.sfx_cteck, 0.35);
				resetButton();
				m_btn2.filter 	= null;
				m_btn2.alpha	= 0;
				m_btn2.scaleX	= 0.35;
				m_btn2.scaleY	= 0.45;
				TweenMax.to(m_btn2, 0.5, { alpha:1 } );
				
				m_data.alpha = 0;
				TweenMax.to(m_data, 1, { alpha:1 } );
				m_data.show(2);
			}
			
			else if (_touchBtn3 && m_btn3.alpha==1) {
				Music.GRUP_GAME.playFx(Music.sfx_cteck, 0.35);
				resetButton();
				m_btn3.filter 	= null;
				m_btn3.alpha	= 0;
				m_btn3.scaleX	= 0.35;
				m_btn3.scaleY	= 0.45;
				TweenMax.to(m_btn3, 0.5, { alpha:1 } );
				
				m_data.alpha = 0;
				TweenMax.to(m_data, 1, { alpha:1 } );
				m_data.show(3);
			}
			
			else if (_touchBtn4 && m_btn4.alpha==1) {
				Music.GRUP_GAME.playFx(Music.sfx_cteck, 0.35);
				resetButton();
				m_btn4.filter = null;
				m_btn4.alpha	= 0;
				m_btn4.scaleX	= 0.35;
				m_btn4.scaleY	= 0.45;
				TweenMax.to(m_btn4, 0.5, { alpha:1 } );
				
				m_data.alpha = 0;
				TweenMax.to(m_data, 1, { alpha:1 } );
				m_data.show(4);
			}
			
			else if (_touchBtn5 && m_btn5.alpha==1) {
				Music.GRUP_GAME.playFx(Music.sfx_cteck, 0.35);
				resetButton();
				m_btn5.filter = null;
				m_btn5.alpha	= 0;
				m_btn5.scaleX	= 0.35;
				m_btn5.scaleY	= 0.45;
				TweenMax.to(m_btn5, 0.5, { alpha:1 } );
				
				m_data.alpha = 0;
				TweenMax.to(m_data, 1, { alpha:1 } );
				m_data.show(5);
			}
			
			else if (_touchBtn6 && m_btn6.alpha==1) {
				Music.GRUP_GAME.playFx(Music.sfx_cteck, 0.35);
				resetButton();
				m_btn6.filter = null;
				m_btn6.alpha	= 0;
				m_btn6.scaleX	= 0.35;
				m_btn6.scaleY	= 0.45;
				TweenMax.to(m_btn6, 0.5, { alpha:1 } );
				
				m_data.alpha = 0;
				TweenMax.to(m_data, 1, { alpha:1 } );
				m_data.show(6);
			}
			
			else if (_touchBtn7 && m_btn7.alpha==1) {
				Music.GRUP_GAME.playFx(Music.sfx_cteck, 0.35);
				resetButton();
				m_btn7.filter = null;
				m_btn7.alpha	= 0;
				m_btn7.scaleX	= 0.35;
				m_btn7.scaleY	= 0.45;
				TweenMax.to(m_btn7, 0.5, { alpha:1 } );
				
				m_data.alpha = 0;
				TweenMax.to(m_data, 1, { alpha:1 } );
				m_data.show(7);
			}
			
			else if (_touchBtn8 && m_btn8.alpha==1) {
				Music.GRUP_GAME.playFx(Music.sfx_cteck, 0.35);
				resetButton();
				m_btn8.filter = null;
				m_btn8.alpha	= 0;
				m_btn8.scaleX	= 0.35;
				m_btn8.scaleY	= 0.45;
				TweenMax.to(m_btn8, 0.5, { alpha:1 } );
				
				m_data.alpha = 0;
				TweenMax.to(m_data, 1, { alpha:1 } );
				m_data.show(8);
			}
			
		}
		
		private function resetButton()
		{
			m_btn1.filter = m_filter;
			m_btn2.filter = m_filter;
			m_btn3.filter = m_filter;
			m_btn4.filter = m_filter;
			m_btn5.filter = m_filter;
			m_btn6.filter = m_filter;
			m_btn7.filter = m_filter;
			m_btn8.filter = m_filter;		
			
			m_btn1.scaleX = 0.3;
			m_btn2.scaleX = 0.3;
			m_btn3.scaleX = 0.3;
			m_btn4.scaleX = 0.3;
			m_btn5.scaleX = 0.3;
			m_btn6.scaleX = 0.3;
			m_btn7.scaleX = 0.3;
			m_btn8.scaleX = 0.3;		
			
			m_btn1.scaleY = 0.4;
			m_btn2.scaleY = 0.4;
			m_btn3.scaleY = 0.4;
			m_btn4.scaleY = 0.4;
			m_btn5.scaleY = 0.4;
			m_btn6.scaleY = 0.4;
			m_btn7.scaleY = 0.4;
			m_btn8.scaleY = 0.4;		
			
		}
		
		
		
		// ---------------------------
		public function showHelp()
		{
			resetButton();
			
			m_shade.visible		= true;
			m_window.visible	= true;
			m_bClose.visible	= true;
			m_data.visible		= true;
			m_text.visible		= true;
			
			m_btn1.visible		= true;
			m_btn2.visible		= true;
			m_btn3.visible		= true;
			m_btn4.visible		= true;
			m_btn5.visible		= true;
			m_btn6.visible		= true;
			m_btn7.visible		= true;
			m_btn8.visible		= true;
			
			m_window.alpha = 0;
			TweenMax.to(m_window, 0.7, { alpha:1, scaleX:1, scaleY:1, ease:Elastic.easeOut } );
			
			m_data.alpha = 0;
			TweenMax.to(m_data, 0.7, { delay:0.2, alpha:1, ease:Elastic.easeOut } );
			
			m_text.alpha 	= 0;
			m_text.scaleX 	= 0.8;
			m_text.scaleY 	= 0.8;
			TweenMax.to(m_text, 1, { scaleX:1, scaleY:1, alpha:1, ease:Elastic.easeOut } );
			
			switch(Config.currLevel) {
				case 1	:	m_btn3.alpha		= 0.5;
							m_btn4.alpha		= 0.5;
							m_btn5.alpha		= 0.5;
							m_btn6.alpha		= 0.5;
							m_btn7.alpha		= 0.5;
							m_btn8.alpha		= 0.5;
							m_data.show(1);
							m_btn1.filter = null;
							break;
				case 2	:	m_btn3.alpha		= 0.5;
							m_btn4.alpha		= 0.5;
							m_btn5.alpha		= 0.5;
							m_btn6.alpha		= 0.5;
							m_btn7.alpha		= 0.5;
							m_btn8.alpha		= 0.5;
							m_data.show(2);
							
							m_btn2.filter 	= null;
							m_btn2.scaleX 	= 0.35;
							m_btn2.scaleY	= 0.45;
							break;
				case 3	:	m_btn3.alpha		= 0.5;
							m_btn4.alpha		= 0.5;
							m_btn6.alpha		= 0.5;
							m_btn7.alpha		= 0.5;
							m_btn8.alpha		= 0.5;
							m_data.show(5);
							
							m_btn5.filter 	= null;
							m_btn5.scaleX 	= 0.35;
							m_btn5.scaleY	= 0.45;
							break;
				case 4	:	m_btn4.alpha		= 0.5;
							m_btn6.alpha		= 0.5;
							m_btn7.alpha		= 0.5;
							m_data.show(7);
							
							m_btn3.filter 	= null;
							m_btn3.scaleX 	= 0.35;
							m_btn3.scaleY	= 0.45;
							break;
				case 5	:	m_data.show(6);
							
							m_btn7.filter 	= null;
							m_btn7.scaleX 	= 0.35;
							m_btn7.scaleY	= 0.45;
							break;
				default	:	m_data.show(1);
							
							m_btn1.filter 	= null;
							m_btn1.scaleX 	= 0.35;
							m_btn1.scaleY	= 0.45;
							break;			
			}
			
			Music.GRUP_LEVEL.playFx(Music.sfx_paper, 0.3);
		}
		
		public function closeHelp()
		{
			m_btn1.visible		= false;
			m_btn2.visible		= false;
			m_btn3.visible		= false;
			m_btn4.visible		= false;
			m_btn5.visible		= false;
			m_btn6.visible		= false;
			m_btn7.visible		= false;
			m_btn8.visible		= false;
			m_bClose.visible	= false;
			
			TweenMax.delayedCall(0.5, function() {
				m_shade.visible		= false;
				m_window.visible	= false;
				m_bClose.visible	= false;
				m_data.visible		= false;
				m_text.visible		= false;
			});
			
			TweenMax.to(m_window, 0.4, { alpha:0, scaleX:0.8, scaleY:0.8, ease:Strong.easeOut } );
			TweenMax.to(m_data, 0.4, { alpha:0, ease:Strong.easeOut});
			TweenMax.to(m_text, 0.2, { alpha:0, ease:Strong.easeOut});
			
			Music.GRUP_LEVEL.playFx(Music.sfx_paper, 0.3);
			
		}
		
	}

}