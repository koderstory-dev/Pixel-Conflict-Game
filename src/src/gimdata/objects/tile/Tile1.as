package gimdata.objects.tile 
{
	import al.core.Ast;
	import flash.geom.Point;
	import gimdata.core.config.Config;
	import gimdata.core.config.Factory;
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author AldyAhsandin
	 */
	public class Tile1 extends Sprite 
	{
		private var vDisplay:MovieClip;
		public function Tile1(_nomor:int, _pos:Point) 
		{
			
			vDisplay 		= Factory.createTile1(_nomor)
			vDisplay.width	= Config.STANDART;
			vDisplay.height	= Config.STANDART;
			this.x			= Config.STANDART * _pos.x;
			this.y			= Config.STANDART * _pos.y;
			
			addChild(vDisplay);
			
			Starling.juggler.add(vDisplay);
		}
		
	}

}