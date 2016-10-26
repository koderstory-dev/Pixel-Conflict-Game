package gimdata.objects.save 
{
	import al.display.SpriteAL;
	import al.objects.Box;
	import starling.text.TextField;
	
	/**
	 * ...
	 * @author Aldy Ahsandin
	 */
	public class WarningLocalSave extends SpriteAL 
	{
		
		private var m_border:Box;
		private var m_text:TextField;
		
		public function WarningLocalSave() 
		{
			m_border = new Box(270, 120, 0xFFFFFF, 0, 0);
			m_border.alpha = 0.8;
			
			m_text = new TextField(270, 120, "WARNING\nProgress is saved offline on this computer only", "Verdana", 18, 0x0, true);
			m_text.y = 5;
			
			addChild(m_border);
			addChild(m_text);
		}
		
	}

}