package al.display 
{
	import al.display.SpriteAL;
	import starling.display.Image;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author ...
	 */
	public class ActiveButtonAL extends SpriteAL 
	{
		protected var m_image0	:Image;
		protected var m_image1	:Image
		protected var m_isActive:int = 0;
		public function ActiveButtonAL(_img0:Texture, _img1:Texture) 
		{
			m_image0 	= new Image(_img0);
			m_image1	= new Image(_img1);
			
			addChild(m_image0);
			addChild(m_image1);
			setImage();
		}
		
		private function setImage()
		{
			if (m_isActive == 0) {
				m_image0.visible = true;
				m_image1.visible = false;
			} else {
				m_image0.visible = false;
				m_image1.visible = true;
			}
		}
		
		public function turnCondition() {
			m_isActive = (m_isActive == 0)? 1:0;
			setImage();
		}
		
	}

}