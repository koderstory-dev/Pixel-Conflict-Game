package gimdata.mvc.view.tutorial 
{
	import al.core.Ast;
	import gimdata.mvc.view.IViewTutorial;
	import starling.display.Image;
	
	/**
	 * ...
	 * @author ...
	 */
	public class TutLevel4 extends IViewTutorial 
	{
		
		public function TutLevel4() 
		{
			super();
			
			m_dataText = [
				"Caution! We got a VIP in the jeep. We should take the jeep out of battle field to point(8,1). We should protect the VIP in any expense",
				"Mission: Guard the jeep along the way to position(8,1). Do not let it down. This mission has to end within 5 turns or you will lose."/*,
				"Use artillery unit to attack from a distance to avoid direct counter attack. Remember, artillery is a vurnerable unit.",*/
			];
			
			var _img1:Image = new Image(Ast.img("tut4_1"));
			var _img2:Image = new Image(Ast.img("tut4_2"));
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