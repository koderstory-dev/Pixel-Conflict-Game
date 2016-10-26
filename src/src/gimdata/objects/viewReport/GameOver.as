package gimdata.objects.viewReport 
{
	import al.core.AL;
	import al.core.Ast;
	import al.display.SpriteAL;
	import al.objects.Box;
	import com.greensock.TweenMax;
	import flash.events.Event;
	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.utils.VAlign;
	
	/**
	 * ...
	 * @author Al
	 */
	public class GameOver extends SpriteAL 
	{
		private var m_bg:Image;
		private var m_borderUp:Box; 
		private var m_borderDown:Box;
		
		private var m_textEnd:TextField;
		private var m_credit:TextField;
		
		public function GameOver() 
		{
			m_bg = new Image(Ast.img("bgGameOver"));
			addChild(m_bg);
			
			// ------
			m_borderUp = new Box(AL.stageWidth, 27, 0x0, 0, 0);
			m_borderDown = new Box(AL.stageWidth, 50, 0x0, 0, 0);
			
			m_borderUp.y	= 0;
			m_borderDown.y 	= AL.stageHeight - 25;
			
			
			// ---
			m_textEnd = new TextField(AL.stageWidth, 50, "The End", "badabom", 40, 0xFFFFFF);
			m_textEnd.vAlign = VAlign.TOP;
			m_textEnd.y = AL.stageHeight;
			addChild(m_textEnd);
			
			var _creditText:String =
			" Production 2015 AldyLab\nSponsored By y8.com\nDeveloper - Aldy Ahsandin\nTranslator - Fia Mahanani\nTester - Fateh Ali Sulthoni"
			m_credit = new TextField(AL.stageWidth, AL.stageHeight, _creditText,"verdana", 20, 0xFFFFFF);
			m_credit.vAlign = VAlign.TOP;
			m_credit.y = m_textEnd.y + m_textEnd.height;
			
			addChild(m_credit);
			addChild(m_borderUp);
			addChild(m_borderDown);
			
			this.visible = false;
			
		}
		
		public function showGameOver()
		{
			this.visible = true;
			this.alpha = 0;
			 
			TweenMax.to(this, 2, { alpha: 1 } );
			
			TweenMax.to(m_textEnd, 55, { delay:2, y: -m_credit.height-m_textEnd.height } );
			TweenMax.to(m_credit, 55, { delay:2, y: -m_credit.height } );
			
		}
		
	}

}