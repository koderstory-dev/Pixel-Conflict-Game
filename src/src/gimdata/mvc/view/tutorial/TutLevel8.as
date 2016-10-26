package gimdata.mvc.view.tutorial 
{
	import al.core.Ast;
	import gimdata.mvc.view.IViewTutorial;
	import starling.display.Image;
	
	/**
	 * ...
	 * @author ...
	 */
	public class TutLevel8 extends IViewTutorial 
	{
		
		public function TutLevel8() 
		{
			super();
			
			m_dataText = [
				"Enemy's town is strategically located at the center of the road network of their city. The primary goals of the offensive is to capture the town to drive a wedge between our armies.",
				"Mission: Destroy all enemies."/*,
				"Building in position (x,y) is the enemy basecamp. Capturing the basecamp will force the enemy to withdraw from the town and let you win.",
				"Capturing enemy supply house will heal damaged unit on every turn. Same rule applies for the enemy.",*/
			];
			
			var _img1:Image = new Image(Ast.img("tut8_1"));
			var _img2:Image = new Image(Ast.img("tut8_2"));
			//var _img3:Image = new Image(Ast.img("tut5_2"));
			
			_img1.scaleX = 0.85;
			_img1.scaleY = 0.85;
			
			_img2.scaleX = 0.5;
			_img2.scaleY = 0.5;
			
			//_img3.scaleX = 0.5;
			//_img3.scaleY = 0.5;
			
			m_dataImage = [_img1, _img2];
			
			// ---------------------------------
			m_dataImage[0].x= 30; m_dataImage[0].y	= 170;
			m_dataImage[1].x= 30; m_dataImage[1].y	= 155;
			//m_dataImage[2].x= 30; m_dataImage[2].y	= 155;
			
			addChild(m_dataImage[0]);
			addChild(m_dataImage[1]);
			//addChild(m_dataImage[2]);
			
		}
		
	}

}