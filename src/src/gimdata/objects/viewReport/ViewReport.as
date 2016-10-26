package gimdata.objects.viewReport 
{
	import al.core.AL;
	import al.core.Ast;
	import al.display.SpriteAL;
	import al.objects.Box;
	import com.greensock.TweenMax;
	import gimdata.core.config.Config;
	import gimdata.core.config.Report;
	import starling.display.Image;
	import starling.text.TextField;
	import starling.utils.VAlign;
	
	/**
	 * ...
	 * @author ...
	 */
	public class ViewReport extends SpriteAL 
	{
		private var m_winPic		: Image;
		private var m_losePic		: Image;
		
		private var m_battleName	: TextField;
		private var m_result		: TextField;
		
		public function ViewReport() 
		{
			// - report
			m_winPic			= new Image(Ast.img("pictureReport", "winning"));
			m_losePic			= new Image(Ast.img("pictureReport", "lose"));
			
			m_battleName		= new TextField(300, 80, "", "badabom",35, 0xFFFFFF, true);
			m_result			= new TextField(300, 50, "", "verdana", 15, 0xFFFFFF, true);
			
			m_winPic.x			= AL.halfStageWidth - m_winPic.width / 2;
			m_winPic.y			= 10;
			m_losePic.x			= AL.halfStageWidth - m_losePic.width / 2;
			m_losePic.y			= 10;
			
			//m_battleName.border	= true;
			m_battleName.x		= AL.halfStageWidth - m_battleName.width / 2;
			m_battleName.y		= m_winPic.y+30;
			
			m_result.x			= m_battleName.x;
			m_result.y			= m_battleName.y + 60;
			m_result.vAlign		= VAlign.TOP;
			m_result.border		= true;
			
			addChild(m_winPic);
			addChild(m_losePic);
			
			addChild(m_battleName);
			addChild(m_result);
			
		}
		
		
		public function getReport(_result:String)
		{
			m_winPic.visible	= false;
			m_losePic.visible	= false;
			
			var _hasil:String = _result.substr(0, 9);
			switch(_hasil) {
				case "MISSION A"	: m_winPic.visible	= true; break;
				case "MISSION F"	: m_losePic.visible	= true; break;
			}
			
			m_battleName.text 	= Config.BATTLENAME;
			m_result.text		= _result;
			
		}
	}

}