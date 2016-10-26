package al.objects 
{
	import starling.display.Shape;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author AldyAhsandin
	 */
	public class Circle extends Sprite 
	{
		private var m_bgShape	: Shape	= new Shape();
		public function Circle() 
		{
			m_bgShape.graphics.lineStyle(_line, _lineColor, _lineAlpha);
			m_bgShape.graphics.beginFill(_fillcolor, 1);
			m_bgShape.graphics.drawCircle(0, 0, radius);
			m_bgShape.graphics.endFill();
			
		}
		
	}

}