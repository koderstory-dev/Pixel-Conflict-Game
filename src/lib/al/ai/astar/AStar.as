package al.ai.astar
{
	import flash.geom.Point;
	/**
	* ...
	* @author Achmad Aulia Noorhakim
	*/
	public class AStar
	{
		private static const ORTHOGONAL_COST:int = 2;
		private static const DIAGONAL_COST  :int = 3;
		
		private var map   :Vector.<int>  = null;
		private var width :int           = 0;
		private var height:int           = 0;
		private var nodes :Vector.<Node> = null;
		
		public function AStar(Map:Vector.<int>, Width:int, Height:int = 0)
		{
			initialize(Map, Width, Height);
		}
		
		public function initialize(Map:Vector.<int>, Width:int, Height:int = 0):void
		{
			this.map    = Map;
			this.width  = Width;
			this.height = (Height == 0 ? Map.length / Width : Height);
			this.nodes  = new Vector.<Node>();
			
			for (var y:int = 0; y < height; ++y)
			for (var x:int = 0; x < width; ++x)
			nodes[ x + y * width ] = new Node(x, y);
		}
		
		public function searchPath(
		from    :Point,
		to      :Point,
		diagonal:Boolean = true,
		nearest :Boolean = true)
		:
		Vector.<Point>
		{
			if (from.x < 0 || from.y < 0 || from.x >= width || from.y >= height)
				return null;
			if (to  .x < 0 || to  .y < 0 || to  .x >= width || to  .y >= height)
				return null;
			
			var opened:Vector.<Node> = new Vector.<Node>();
			var closed:Vector.<Node> = new Vector.<Node>();
			var oIndex:int           = 0;
			var cIndex:int           = 0;
			var active:Node          = null;
			var start :Node          = nodes[ from.x + from.y * width ];
			var end   :Node          = nodes[ to  .x + to  .y * width ];
			
			end  .reset();
			start.reset();
			
			var sx:int = from.x - to.x;
			var sy:int = from.y - to.y;
			start.H    = (sx < 0 ? -sx : sx) + (sy < 0 ? -sy : sy);
			
			opened[ oIndex++ ] = start;
			while (oIndex)
			{
				opened.sort(sortF);
				active = closed[ cIndex++ ] = opened[ --oIndex ];
				if (active == end || cIndex > 64)
					break;
				
				for (var y:int = active.y - 1; y <= active.y + 1; ++y)
				{
					if (y < 0 || y >= height)
						continue;
					
					for (var x:int = active.x - 1; x <= active.x + 1; ++x)
					{
						if (x < 0 || x >= width)
							continue;
						
						if (x != active.x && y != active.y && !diagonal)
							continue;
						
						var index:int  = x + y * width;
						var node :Node = nodes[ index ];
						if (map[ index ] < 0 || closed.indexOf(node) >= 0)
							continue;
							
						var nodeG:int = active.G + (x != active.x && y != active.y ? DIAGONAL_COST : ORTHOGONAL_COST);
						if (opened.indexOf(node) < 0 && map[index] != int.MAX_VALUE)
						{
							var dx:int = x - to.x;
							var dy:int = y - to.y;
							
							dx = (dx < 0 ? -dx : dx);
							dy = (dy < 0 ? -dy : dy);
							
							node.H    = dx + dy + map[ index ];
							node.G    = nodeG;
							node.F    = node.G + node.H;
							node.root = active;
							
							opened[ oIndex++ ] = node;
						}
						else
						{
							if (nodeG < node.G)
							{
								node.G    = nodeG;
								node.F    = node.G + node.H;
								node.root = active;
							}							
						}
					}
				}
			}
			
			var rIndex:int            = 0;
			var result:Vector.<Point> = null;
			if (active == end)
			{
				result = new Vector.<Point>();
				while (active)
				{
					result[ rIndex++ ] = new Point(active.x, active.y);
					active = active.root;
				}
				
				result.reverse();
			}
			else if (nearest)
			{
				closed.sort(sortH);
				
				active = closed[ 0 ];
				result = new Vector.<Point>();
				while (active)
				{
					result[ rIndex++ ] = new Point(active.x, active.y);
					active             = active.root;
				}
				
				result.reverse();
			}
			
			return result;
		}
		
		
		private function sortH(a:Node, b:Node):int
		{
			return a.H - b.H;
		}
		
		
		private function sortF(a:Node, b:Node):int
		{
			return b.F - a.F;
		}

	}
}

class Node
{
	public var root:Node = null;
	public var G   :int  = 0;
	public var H   :int  = 0;
	public var F   :int  = 0;


	public var x   :int  = 0;
	public var y   :int  = 0;


	public function Node(x:int, y:int)
	{
		initialize(x, y);
	}


	public function initialize(x:int, y:int):void
	{
		this.x = x;
		this.y = y;
		//trace(x +" | " + y);
		reset();
	}


	public function reset():void
	{
		root = null;
		G    = 0;
		H    = 0;
		F    = 0;
	}

}