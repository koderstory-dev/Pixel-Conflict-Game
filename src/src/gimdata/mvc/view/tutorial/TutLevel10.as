package gimdata.mvc.view.tutorial 
{
	import al.core.Ast;
	import gimdata.mvc.view.IViewTutorial;
	import starling.display.Image;
	
	/**
	 * ...
	 * @author ...
	 */
	public class TutLevel10 extends IViewTutorial 
	{
		
		public function TutLevel10() 
		{
			super();
			
			m_dataText = [
				"Supply truck is important for our units in this battle. We will attack the town with only infantry units. So we are rely heavily on supply unit to heal wounded units.",
				"Mission: Capture the base or destroy all enemy units"/*,
				"Building in position (x,y) is the enemy basecamp. Capturing the basecamp will force the enemy to withdraw from the town and let you win.",
				"Capturing enemy supply house will heal damaged unit on every turn. Same rule applies for the enemy.",*/
			];
			
			var _img1:Image = new Image(Ast.img("tut10_1"));
			var _img2:Image = new Image(Ast.img("tut10_2"));
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