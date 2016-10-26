package gimdata.mvc.view.tutorial 
{
	import al.core.Ast;
	import gimdata.mvc.view.IViewTutorial;
	import starling.display.Image;
	
	/**
	 * ...
	 * @author ...
	 */
	public class TutLevel2 extends IViewTutorial 
	{
		
		public function TutLevel2() 
		{
			super();
			
			m_dataText = [
				"Listen up! Enemy activities are reported in Jogoja. We are going to attack the village with an APC support. No civilians are detected on site,  destroy all enemies.",
				"Crush all enemies and finish mission within 5 turns."
			];
			
			var _img1:Image = new Image(Ast.img("tut2_1"));
			var _img2:Image = new Image(Ast.img("tut2_2"));
			//var _img3:Image = new Image(Ast.img("tut2_2"));
			
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