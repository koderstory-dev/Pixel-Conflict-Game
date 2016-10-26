package gimdata.objects.selected 
{
	import gimdata.objects.tile.Tile;
	import gimdata.objects.tile.Tile2;
	import gimdata.objects.unit.Unit;
	/**
	 * ...
	 * @author Aldy Ahsandin
	 */
	public class Clicked 
	{
		private var _unit	: Unit;
		private var _tile	: Tile2;
		
		public function Clicked() 
		{
			
		}
		
		public function setData(_u:Unit, _t:Tile2)
		{
			_unit 	= _u;
			_tile	= _t;
		}
		
		public function get unit():Unit {return _unit;}
		public function get tile():Tile2{return _tile;}
		
		
	}

}