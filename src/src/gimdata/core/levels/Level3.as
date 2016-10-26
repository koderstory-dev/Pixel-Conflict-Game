package gimdata.core.levels 
{
	import flash.geom.Point;
	import org.as3collections.iterators.ArrayIterator;
	/**
	 * ...
	 * @author Aldy Ahsadin
	 */
	public class Level3
	{
		
		// -- INFO BASIC
		public static const BATTLENAME		: String 	= "#3 Ambush";
		public static const limitDay		: int		= 7;
		
		// -- TILE DATA
		public static const TILE1			: Array =
		[
			37,40,44,40,44,51,5,5,
			49,5,6,5,6,5,5,4,
			39,45,44,41,5,37,44,49,
			40,51,5,39,48,43,5,39,
			65,65,65,65,65,65,65,65
		];
		
		public static const TILE2			: Array =
		[
			92,92,92,92,92,92,80,84,
			92,82,84,82,82,83,84,82,
			92,92,92,92,84,92,92,92,
			82,82,82,92,92,92,83,92,
			94,94,94,94,94,94,94,94
		];
		
		/*	
			1:baseCamp, 
			2:village, 	
		*/ 
		public static const OWNERS			: Array =
		[
			00, 00, 00, 00, 00, 13, 00, 00,
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
			00, 00, 00, 00, 00, 00, 00, 00,
			00, 00, 11, 00, 00, 00, 00, 00,
			00, 00, 00, 00, 12, 00, 00, 00,
			03, 00, 00, 00, 00, 00, 00, 19,
			00, 00, 00, 00, 00, 00, 00, 00
		];
		
		public static const UNITS_AI: Array =
		[
			[new Point(2, 1), "attack_in_range",3],	// unit yg akan dimasukkan AI, AI, posisi tujuan
			[new Point(4, 2), "attack_in_range",3],	// unit yg akan dimasukkan AI, AI, posisi tujuan
			[new Point(7, 3), "supply_move", new Point(5, 0)]	// unit yg akan dimasukkan AI, AI, posisi tujuan
			
		];
		
		
		// --------------------------------------
		public static const WIN_TARGET: Array =
		[
			new Point(7, 3)
		];
		
		public static const WIN_POS	:Array = 
		[
			[new Point(7, 3), new Point(5, 0)]
		];
		
	}

}