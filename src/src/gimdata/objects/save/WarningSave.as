package gimdata.objects.save 
{
	import al.core.AL;
	import al.display.SpriteAL;
	import al.objects.Box;
	import flash.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	
	/**
	 * ...
	 * @author Aldy Ahsandin
	 */
	public class WarningSave extends SpriteAL 
	{
		private var m_bg:Box;
		private var m_box:Box;
		private var m_textWarning:TextField;
		
		public function WarningSave() 
		{
			m_bg = new Box(AL.stageWidth, AL.stageHeight, 0x0, 0, 0);
			m_bg.alpha = 0.5;
			addChild(m_bg);
			
			m_box = new Box(350, 150, 0xFFFFFF, 0, 0, 0x0, 20);
			m_box.pivotX = m_box.width / 2;
			m_box.pivotY = m_box.height / 2;
			m_box.x = AL.halfStageWidth;
			m_box.y = AL.halfStageHeight;
			m_box.alpha = 0.95;
			addChild(m_box);
			
			m_textWarning = new TextField(300, 150, "Getting achievements and submitting highsocre\nare only available on online save.\nBack to save screen and change to save online to enable.", "Verdana", 12);
			m_textWarning.pivotX = m_textWarning.width / 2;
			m_textWarning.pivotY = m_textWarning.height / 2;
			m_textWarning.x = AL.halfStageWidth;
			m_textWarning.y = AL.halfStageHeight;
			addChild(m_textWarning);
			
			visible = false;
			addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		private function onTouch(e:TouchEvent):void 
		{
			var _touch:Touch = e.getTouch(this, TouchPhase.ENDED);
			if (_touch) {
				visible = false;
			}
		}
		
		
		
	}

}