package gimdata.mvc.view.tutorial 
{
	import al.core.Ast;
	import gimdata.mvc.view.IViewTutorial;
	import starling.display.Image;
	
	/**
	 * ...
	 * @author ...
	 */
	public class TutLevel1 extends IViewTutorial 
	{
		
		public function TutLevel1() 
		{
			super();
			
			m_dataText = [
				"Our supply truck will pass the road within few hours. But, some enemy activities are detected on site. Our mission is to clear the road before the truck comes.",
				"Eliminate the enemies blocking the road and finish the mission within 4 turns."/*,
				"An active unit will have a visible move area. Click on blank white tile in move area to move the unit.", 
				"A target sign will appear whenever an enemy enters the move area. In every turn, a unit will only have one action, either move or attack. So, think wisely.",
				"Press the button on top-right corner to change turn."*/
			];
			
			var _img1:Image = new Image(Ast.img("tut1_1"));
			var _img2:Image = new Image(Ast.img("tut1_2"));
			//var _img3:Image = new Image(Ast.img("tut1_2"));
			//var _img4:Image = new Image(Ast.img("tut1_3"));
			//var _img5:Image = new Image(Ast.img("tut1_4"));
			
			_img1.scaleX = 0.85;
			_img1.scaleY = 0.85;
			
			_img2.scaleX = 0.5;
			_img2.scaleY = 0.5;
			
			//_img3.scaleX = 0.5;
			//_img3.scaleY = 0.5;
			//
			//_img4.scaleX = 0.5;
			//_img4.scaleY = 0.5;
			//
			//_img5.scaleX = 0.5;
			//_img5.scaleY = 0.5;
			
			m_dataImage = [_img1, _img2/*, _img3, _img4, _img5*/];
			
			// ---------------------------------
			m_dataImage[0].x= 30; m_dataImage[0].y	= 170;
			m_dataImage[1].x= 30; m_dataImage[1].y	= 155;
			//m_dataImage[2].x= 30; m_dataImage[2].y	= 155;
			//m_dataImage[3].x= 30; m_dataImage[3].y	= 155;
			//m_dataImage[4].x= 30; m_dataImage[4].y	= 155;
			
			addChild(m_dataImage[0]);
			addChild(m_dataImage[1]);
			//addChild(m_dataImage[2]);
			//addChild(m_dataImage[3]);
			//addChild(m_dataImage[4]);
		
		}
		
	}

}