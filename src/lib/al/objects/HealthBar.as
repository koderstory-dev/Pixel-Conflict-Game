package al.objects 
{
	
	import aldyahsn.air.shape.Box;
	import starling.display.Sprite;
	import starling.text.TextField;
	
	/**
	 * Kelas Bar
	 * @author AldyAhsn
	 */
	public class HealthBar extends Sprite
	{
		public 	var vHealth		: Box;
		public 	var vBar		: Box;
		public	var healthFull	: int;
		public function HealthBar(_x:int, _y:int, _width:int, _height:int, _lineBar:int=4, _lineIn:int=0) 
		{
				
			if (_width 	<= 6)_width		= 7;
			if (_height <= 6)_height 	= 7;
			
			
			vBar		= new Box(_width,	_height, 0x000000, _lineBar,1, 0xFFFFFF); 
			vHealth		= new Box(_width - 6, _height - 6,	0xFED801, _lineIn , 1, 0x000000, 5);
			healthFull	= vHealth.width;
			
			vBar.x		= _x;
			vBar.y		= _y;
			vHealth.x	= _x+3;
			vHealth.y	= _y+3;
			
			addChild(vBar);
			addChild(vHealth);		
			
		}
		
		public function setHealth(_health:Number, _fullHealth:Number)
		{
			
			vHealth.width = (_health / _fullHealth) * healthFull;
		}
	}

}