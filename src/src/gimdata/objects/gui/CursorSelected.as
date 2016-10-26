package gimdata.objects.gui {
	import al.core.AL;
	import al.core.Ast;
	import com.greensock.easing.Elastic;
	import com.greensock.easing.Strong;
	import com.greensock.TweenMax;
	import flash.geom.Point;
	import gimdata.core.config.Config;
	import starling.animation.Tween
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	
	/**
	 * ...
	 * @author Aldy Ahsandin
	 */
	public class CursorSelected extends Sprite 
	{
		public	var dPos	: Point;
		private var m_cursor: Image;
		public function CursorSelected(_image:Image) 
		{
			m_cursor	 	= _image;
			m_cursor.width	= 60;
			m_cursor.height	= 60;
			m_cursor.y		= 0;
			
			this.alpha 		= 0;
		
			addChild(m_cursor);
		}
		
		public	function show(_dPos:Point, _offsetY:int=0)
		{
			this.alpha		= 1;
			this.x			= _dPos.x * 60;
			this.y			= _dPos.y * 60 - 10;
			m_cursor.y		= _offsetY;
			
		}
		
		public function hide()
		{
			this.alpha		= 0;	
			m_cursor.y		= 0;
			
			//up();
		}
		
	}

}