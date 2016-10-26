package gimdata.core.levels 
{
	import flash.geom.Point;
	import org.as3collections.iterators.ArrayIterator;
	/**
	 * ...
	 * @author Aldy Ahsadin
	 */
	public class Level2 
	{
		
		// -- INFO BASIC
		public static const BATTLENAME		: String 	= "#2 Attack Village";
		public static const COMMANDER_ALLY	: String 	= "Captain Falcon";
		public static const COMMANDER_ENMY	: String 	= "Unknown Captain";
		public static const limitDay		: int		= 5;
		
		// -- TILE DATA
		public static const TILE1			: Array =
		[
			3,7,3,3,5,7,7,1,
			3,2,5,10,3,3,7,2,
			40,40,40,44,40,40,44,40,
			3,4,9,10,4,9,3,3,
			1,6,4,9,4,3,3,5
		];
		
		public static const TILE2			: Array =
		[
			87,88,87,81,88,81,88,87,
			81,87,79,89,79,79,81,80,
			92,92,92,92,92,92,92,92,
			87,87,89,89,87,89,80,79,
			81,88,87,89,87,81,87,88

		];
		
		/*	
			1:baseCamp, 
			2:village, 	
		*/ 
		public static const OWNERS			: Array =
		[
			00, 00, 00, 00, 00, 00, 00, 00,
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
			00, 01, 00, 00, 11, 00, 00, 00,
			00, 00, 05, 00, 00, 00, 00, 00,
			00, 01, 00, 00, 00, 00, 00, 11,
			00, 00, 00, 00, 00, 12, 00, 00
		];
		
		public static const UNITS_AI: Array =
		[
			[new Point(4, 1), "attack_in_range", 1],	// unit yg akan dimasukkan AI, AI, posisi tujuan
			[new Point(5, 4), "attack_in_range", 4],	// unit yg akan dimasukkan AI, AI, posisi tujuan
			[new Point(7, 3), "attack_in_range", 4]	// unit yg akan dimasukkan AI, AI, posisi tujuan
		];
		
		
		// --------------------------------------
		public static const WIN_TARGET: Array =
		[
			
		];
		
		public static const WIN_POS	:Array = 
		[
			
		];
		
	}

}