package gimdata.core.levels 
{
	import flash.geom.Point;
	import org.as3collections.iterators.ArrayIterator;
	/**
	 * ...
	 * @author Aldy Ahsadin
	 */
	public class Level8 
	{
		
		// -- INFO BASIC
		public static const BATTLENAME		: String 	= "#8 Charge!";
		public static const COMMANDER_ALLY	: String 	= "Captain Falcon";
		public static const COMMANDER_ENMY	: String 	= "Unknown Captain";
		public static const limitDay		: int		= 5;
		
		// -- TILE DATA
		public static const TILE1			: Array =
		[
			1,3,6,3,2,5,1,9,
			1,6,6,6,7,3,9,10,
			1,1,3,4,3,1,9,1,
			1,6,5,1,6,6,1,1,
			1,1,6,6,4,7,12,10
		];
		
		public static const TILE2			: Array =
		[
			82,87,88,87,79,88,80,89,
			82,82,88,88,88,87,89,89,
			82,82,87,87,87,80,89,80,
			82,82,88,81,88,88,79,77,
			82,87,88,88,87,88,89,89
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
			00, 00, 00, 00, 00, 00, 00, 11,
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
			00, 01, 00, 00, 00, 00, 11, 00,
			01, 02, 00, 00, 00, 00, 12, 00,
			01, 01, 00, 00, 00, 00, 17, 00,
			02, 02, 00, 00, 00, 15, 00, 00,
			00, 01, 00, 00, 00, 00, 11, 00
		];
		
		
		public static const UNITS_AI: Array =
		[
			[new Point(6, 0), "attack_in_range", 2],
			[new Point(6, 1), "attack_in_range", 3],
			[new Point(6, 2), "attack_in_sight"],
			[new Point(5, 3), "attack_in_range", 3],
			[new Point(6, 4), "attack_in_range", 2]
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