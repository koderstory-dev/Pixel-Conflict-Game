package gimdata.objects.tutorial 
{
	import al.core.Ast;
	import al.display.SpriteAL;
	import starling.display.Image;
	import starling.text.TextField;
	
	/**
	 * ...
	 * @author ...
	 */
	public class TerrainProtection extends SpriteAL 
	{
		private var m_image:Image;
		private var m_data:TextField;
		private var m_terrain:String;
		public function TerrainProtection(_img:String, _txt:String) 
		{
			m_terrain = _txt;
			m_image = new Image(Ast.img("helpTerrain",_img));
			m_image.width 	= 30;
			m_image.height 	= 30;
			
			m_data	= new TextField(50, 35, m_terrain+"\n", "verdana", 10, 0x0, true);
			m_data.pivotX = m_data.width / 2;
			m_data.pivotY = m_data.height / 2;
			//m_data.border = true;
			m_data.y = m_image.y + 1.5*m_image.height;
			m_data.x = m_image.width / 2;
			
			addChild(m_image);
			addChild(m_data);
		}
		
		public function setData(_data:Number)
		{
			_data = _data * 100;
			m_data.text = m_terrain + "\n" + _data+"%";
		}
		
		
	}

}