package gimdata.core.levels 
{
	import flash.geom.Point;
	import org.as3collections.iterators.ArrayIterator;
	/**
	 * ...
	 * @author Aldy Ahsadin
	 */
	public class Level1 
	{
		
		// -- INFO BASIC
		public static const BATTLENAME		: String 	= "#1 Clear The Road";
		public static const limitDay		: int		= 4;
		
		// -- score
		public static var STAR:int = 0;
		
		// -- TILE DATA
		public static const TILE1			: Array =
		[
			1,1,1,3,9,12,42,9,
			1,1,1,2,11,9,42,1,
			1,1,1,2,12,9,42,12,
			1,1,1,3,9,9,42,1,
			1,1,1,4,12,11,42,11
		];
		
		public static const TILE2			: Array =
		[
			82,82,82,87,89,89,92,89,
			82,82,82,87,89,89,92,79,
			82,82,82,87,89,89,92,89,
			82,82,82,87,89,89,92,79,
			82,82,82,87,89,89,92,89

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
		public static const UNITS: Array =
		[
			00, 00, 00, 00, 00, 00, 00, 00,
			00, 00, 01, 00, 00, 00, 00, 00,
			00, 00, 00, 00, 00, 00, 12, 00,
			00, 00, 01, 00, 00, 00, 00, 00,
			00, 00, 00, 00, 00, 00, 00, 00
		];
		
		public static const UNITS_AI: Array =
		[
			[new Point(6, 2), "attack_in_range", 2]
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