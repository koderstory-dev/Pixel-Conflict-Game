package gimdata.core.levels 
{
	import flash.geom.Point;
	import org.as3collections.iterators.ArrayIterator;
	/**
	 * ...
	 * @author Aldy Ahsadin
	 */
	public class Level9
	{
		
		// -- INFO BASIC
		public static const BATTLENAME		: String 	= "#9 Protection";
		public static const COMMANDER_ALLY	: String 	= "Captain Falcon";
		public static const COMMANDER_ENMY	: String 	= "Unknown Captain";
		public static const limitDay		: int		= 8;
		
		// -- TILE DATA
		public static const TILE1			: Array =
		[
			37,40,40,40,44,40,40,30,
			42,1,1,1,21,24,28,27,
			39,40,40,40,22,40,40,41,
			24,28,24,28,33,1,1,38,
			40,40,40,40,22,40,40,51
		];
		
		public static const TILE2			: Array =
		[
			92,92,92,92,92,92,92,85,
			92,81,81,83,93,93,93,93,
			92,92,92,92,85,92,92,92,
			93,93,93,93,93,84,82,92,
			92,92,92,92,85,92,92,92
		];
		
		/*	
			1:baseCamp, 
			2:village, 	
		*/ 
		public static const OWNERS			: Array =
		[
			00, 00, 00, 00, 00, 00, 00, 03,
			00, 00, 00, 00, 00, 00, 00, 00,
			00, 00, 00, 00, 00, 00, 00, 00,
			00, 00, 00, 00, 00, 00, 00, 00,
			00, 00, 00, 00, 00, 00, 00, 00
		];
		
		//Data Unit sesuai urutan
		//[ 1. infantry, 
		//	2. mGun, 
		// 	3. RocketLauncher, 
		//  4. car, 
		//	5. apc, 
		// 	6. tank, 
		//	7. artillery, 
		//	8. artilleryTruck, 
		//	9. medic]
		public static const UNITS	: Array =
		[
			11, 00, 00, 00, 13, 00, 00, 00,
			00, 11, 12, 00, 00, 00, 00, 00,
			00, 00, 00, 00, 00, 00, 00, 11,
			00, 00, 00, 00, 00, 12, 12, 00,
			02, 09, 02, 06, 00, 00, 00, 00
		];
		
		
		public static const UNITS_AI: Array =
		[
			[new Point(0, 0), "attack_in_range", 3],
			[new Point(1, 1), "attack_in_range", 2],
			[new Point(2, 1), "attack_in_range", 1],
			[new Point(4, 0), "attack_in_range", 1],
			[new Point(5, 3), "attack_in_range", 1],
			[new Point(6, 3), "attack_in_range", 2],
			[new Point(7, 2), "attack_in_range", 3]
		];
		
		
		// --------------------------------------
		public static const WIN_TARGET: Array =
		[
			new Point(1, 4)
		];
		
		public static const WIN_POS	:Array = 
		[
			[new Point(1, 4), new Point(7, 0)]
		];
		
	}

}