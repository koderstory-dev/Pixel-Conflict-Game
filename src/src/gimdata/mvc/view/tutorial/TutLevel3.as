package gimdata.mvc.view.tutorial 
{
	import al.core.Ast;
	import gimdata.mvc.view.IViewTutorial;
	import starling.display.Image;
	
	/**
	 * ...
	 * @author ...
	 */
	public class TutLevel3 extends IViewTutorial 
	{
		
		public function TutLevel3() 
		{
			super();
			
			m_dataText = [
				"Incoming report. A supply truck is under way to the enemy base. It is approaching to that position. We have to intercept the truck!",
				"Mission: Destroy enemy supply truck. Finish this mission within 7 turns."/*,
				"Do not let the truck to reach the position. An RPG unit is provided to succeed this ambush mission It is weak against attack, but is powerful to attack."*/
			];
			
			var _img1:Image = new Image(Ast.img("tut3_1"));
			var _img2:Image = new Image(Ast.img("tut3_2"));
			//var _img3:Image = new Image(Ast.img("tut4_2"));
			
			_img1.scaleX = 0.85;
			_img1.scaleY = 0.85;
			
			_img2.scaleX = 0.5;
			_img2.scaleY = 0.5;
			
			//_img3.scaleX = 0.5;
			//_img3.scaleY = 0.5;
			//
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