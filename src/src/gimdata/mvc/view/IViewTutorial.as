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
	import org.osflash.signals.Signal;
	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	/**
	 * ...
	 * @author ...
	 */
	public class IViewTutorial extends SpriteAL 
	{
		protected var m_shade		:Box;
		
		protected var m_briefingTxt	:TextField;
		protected var m_overview	:TextField;
		protected var m_border		:TextField;
		protected var m_mission		:TextField;
		protected var m_image		:Image;
		
		protected var m_btnNext	:TextField;
		protected var m_btnSkip	:TextField;
		
		protected var m_curIndex:int = 0;
		protected var m_maxIndex:int = 3;
		
		protected var m_dataText:Array = new Array();
		protected var m_dataImage:Array = new Array();
		
		public var signal_close:Signal = new Signal();
		
		public function IViewTutorial() 
		{
			
			m_shade 		= new Box(AL.stageWidth, AL.stageHeight, 0x0, 0.5, 0);
			addChild(m_shade)
			
			m_briefingTxt	= new TextField(350, 50, "BRIEFING", "badabom", 40, 0xFFFFFF);
			m_briefingTxt.x	= 20;
			m_briefingTxt.y	= 60;
			addChild(m_briefingTxt);
			
			m_border		= new TextField(420, 80, "", "vcr", 15, 0xFFFFFF);
			m_border.x		= 30;
			m_border.y		= 70;
			m_border.border	= true;
			addChild(m_border);

			m_overview		= new TextField(400, 60, "", "verdana", 12, 0xFFFFFF);
			m_overview.x	= 40;
			m_overview.y	= 90;
			m_overview.vAlign = VAlign.TOP;
			m_overview.hAlign = HAlign.LEFT;
			addChild(m_overview);
			
			m_btnNext			= new TextField(100, 40, "Next", "vcr", 20, 0xFFFFFF);
			m_btnNext.pivotX 	= m_btnNext.width / 2;
			m_btnNext.pivotY 	= m_btnNext.height / 2;
			m_btnNext.x			= 400;
			m_btnNext.y			= 230;
			m_btnNext.border 	= true;
			m_btnNext.addEventListener(TouchEvent.TOUCH, onTouch);
			addChild(m_btnNext)
			
			m_btnSkip		 = new TextField(100, 40, "Skip", "vcr", 20, 0xFFFFFF);
			m_btnSkip.pivotX = m_btnSkip.width / 2;
			m_btnSkip.pivotY = m_btnSkip.height / 2;
			m_btnSkip.x		 = 400;
			m_btnSkip.y		 = 180;
			m_btnSkip.border = true;
			m_btnSkip.addEventListener(TouchEvent.TOUCH, onTouch);
			addChild(m_btnSkip);
			
			showAll(false);
		}
		
		protected function onTouch(e:TouchEvent):void 
		{
			var _touch:Touch 	= e.getTouch(m_btnNext, TouchPhase.BEGAN);
			var _untouch:Touch 	= e.getTouch(m_btnNext, TouchPhase.ENDED);
			var _skip:Touch		= e.getTouch(m_btnSkip, TouchPhase.BEGAN);
			if (_touch && m_btnNext.scaleX==1 && m_btnNext.alpha==1) {
				
				Music.GRUP_GAME.playFx(Music.sfx_cteck, 0.35);
				
				m_btnNext.scaleX = 0.9;
				m_btnNext.scaleY = 0.9;
				
				if (m_curIndex < m_maxIndex-1) {
					m_curIndex++;
					updateText();
				} else {
					closeTutorial();
				}
			} 
			
			else if (_skip && m_btnSkip.alpha==1) {
				closeTutorial();
			}
			
			if (_untouch && m_btnNext.alpha==1) {
				m_btnNext.scaleX = 1;
				m_btnNext.scaleY = 1;
				
			}
		}
		
		protected function updateText()
		{
			if (m_curIndex < m_dataText.length) {
				
				
				// --------------------------------------------------
				for (var i:int = 0; i < m_dataImage.length; i++ ) {
					if (m_dataImage[i] != null) {
						m_dataImage[i].visible 	= false;
						m_dataImage[i].alpha 	= 0;
					}
				}
				if(m_dataImage[m_curIndex]!=null)
				m_dataImage[m_curIndex].visible = true;
				
				// --------------------------------------------------
				m_overview.text = m_dataText[m_curIndex];
				if (m_curIndex > 0) {
					m_overview.alpha = 0;
					
					TweenMax.to(m_overview, 0.5, { alpha:1 } );
					TweenMax.to(m_dataImage[m_curIndex], 0.5, { delay:0.4, alpha:1 } );
				}
			}
		}
		
		public function playTutorial(_isDelay:Boolean=true)
		{
			showAll();
			m_briefingTxt.text	= Config.BATTLENAME;
			m_curIndex			= 0;
			m_maxIndex			= m_dataText.length;
			m_shade.alpha 		= 0;
			m_briefingTxt.alpha	= 0;
			m_overview.alpha	= 0;
			m_border.alpha		= 0;
			m_dataImage[0].alpha= 0;
			//m_image.alpha		= 0;
			m_btnNext.alpha		= 0;
			m_btnSkip.alpha		= 0;
			
			TweenMax.to(m_shade, 0.5, { delay:(_isDelay)?1.8:0, alpha:0.85 } );
			TweenMax.to(m_briefingTxt, 0.5, { delay:(_isDelay)?2:0.2, alpha:1, y:20, ease:Strong.easeOut});
			TweenMax.to(m_border, 0.5, { delay:(_isDelay)?2.2:0.4, alpha:1, y:70, ease:Strong.easeOut } );
			TweenMax.to(m_overview, 0.5, { delay:(_isDelay)?2.2:0.4, alpha:1, y:80, ease:Strong.easeOut } );
			TweenMax.to(m_dataImage[0], 0.5, { delay:(_isDelay)?2.4:0.6, alpha:1, y:155, ease:Strong.easeOut } );
			TweenMax.to(m_btnNext, 0.25, { alpha:1, delay:(_isDelay)?2.6:0.8, y:250, ease:Strong.easeOut } );
			TweenMax.to(m_btnSkip, 0.25, { alpha:1, delay:(_isDelay)?2.8:1, y:190, ease:Strong.easeOut } );
			updateText();
			
			Music.GRUP_LEVEL.playFx(Music.sfx_paper, 0.3);
		}
		
		public function closeTutorial()
		{
			Music.GRUP_LEVEL.playFx(Music.sfx_paper, 0.3);
				
			TweenMax.to(m_shade, 0.25, { alpha:0 } );
			TweenMax.to(m_briefingTxt, 0.25, { delay:0.1, alpha:0, y:60, ease:Strong.easeOut});
			TweenMax.to(m_border, 0.25, { delay:0.2, alpha:0, ease:Strong.easeOut } );
			TweenMax.to(m_overview, 0.25, { delay:0.2, alpha:0, y:90, ease:Strong.easeOut } );
			//TweenMax.to(m_dataImage[m_curIndex], 0.01, { delay:0, alpha:0, y:170} );
			//TweenMax.to(m_image, 0.25, { delay:0.3, alpha:0, y:170, ease:Strong.easeOut } );
			TweenMax.to(m_btnNext, 0.25, { alpha:0, delay:0.4, y:230, ease:Strong.easeOut } );
			TweenMax.to(m_btnSkip, 0.25, { alpha:0, delay:0.5, y:180, ease:Strong.easeOut } );
			TweenMax.delayedCall(0.6, showAll, [false]);
			
			for (var i:int = 0; i < m_dataImage.length; i++ ) {
				if (m_dataImage[i] != null) {
					m_dataImage[i].visible 	= false;
					m_dataImage[i].alpha 	= 0;
				}
			}
			
			signal_close.dispatch();
		}
		
		protected function showAll(_isVisible:Boolean=true)
		{
			m_shade.visible			= _isVisible;
			m_briefingTxt.visible	= _isVisible;
			m_overview.visible		= _isVisible;
			m_border.visible		= _isVisible;
			//m_image.visible			= _isVisible;
			m_btnNext.visible		= _isVisible;
			m_btnSkip.visible		= _isVisible;
			this.visible			= _isVisible;
		}
		
	}

}