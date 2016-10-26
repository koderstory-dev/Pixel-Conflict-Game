package gimdata.mvc.view.tutorial 
{
	import al.core.Ast;
	import gimdata.mvc.view.IViewTutorial;
	import starling.display.Image;
	
	/**
	 * ...
	 * @author ...
	 */
	public class TutLevel6 extends IViewTutorial 
	{
		
		public function TutLevel6() 
		{
			super();
			
			m_dataText = [
				"After the conquest of one of the enemy's base camp. Now the enemy is trying to counterattack to one of our base camp near the beach.",
				"Mission: Defense our base camp by destroying all incoming attack"/*,
				"Building in position (x,y) is the enemy basecamp. Capturing the basecamp will force the enemy to withdraw from the town and let you win.",
				"Capturing enemy supply house will heal damaged unit on every turn. Same rule applies for the enemy.",*/
			];
			
			var _img1:Image = new Image(Ast.img("tut6_1"));
			var _img2:Image = new Image(Ast.img("tut6_2"));
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