package gimdata.core.levels 
{
	import flash.geom.Point;
	import org.as3collections.iterators.ArrayIterator;
	/**
	 * ...
	 * @author Aldy Ahsadin
	 */
	public class Level4 
	{
		
		// -- INFO BASIC
		public static const BATTLENAME		: String 	= "#4 The Bridge";
		public static const COMMANDER_ALLY	: String 	= "Captain Falcon";
		public static const COMMANDER_ENMY	: String 	= "Unknown Captain";
		public static const limitDay		: int		= 5;
		
		// -- TILE DATA
		public static const TILE1			: Array =
		[
			2,5,2,22,2,3,4,42,
			37,40,40,26,40,44,40,49,
			42,10,9,22,5,4,7,42,
			42,12,9,30,6,5,5,39,
			42,3,12,31,29,36,24,28
		];
		
		public static const TILE2			: Array =
		[
			82,82,82,93,82,79,82,92,
			92,92,92,85,92,92,92,92,
			92,89,89,93,78,82,82,92,
			92,89,89,93,83,82,83,92,
			92,79,89,93,93,93,93,93

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
			00, 00, 00, 00, 12, 00, 11, 00,
			00, 00, 00, 00, 00, 11, 00, 00,
			00, 00, 00, 00, 00, 00, 00, 00,
			04, 00, 00, 00, 00, 11, 00, 16,
			00, 07, 00, 00, 00, 00, 00, 00
		];
		
		
		public static const UNITS_AI: Array =
		[
			[new Point(4, 0), "attack_closest"],
			[new Point(5, 1), "attack_weakest"],
			[new Point(6, 0), "attack_in_range",4],
			[new Point(5, 3), "attack_closest"],
			[new Point(7, 3), "attack_closest"]
		];
		
		
		// --------------------------------------
		public static const WIN_TARGET: Array =
		[
			new Point(0, 3)
		];
		
		// jika posisi unit X, titik Y dimana jika X di Y ia menang
		public static const WIN_POS	:Array = 
		[
			[new Point(0, 3), new Point(7, 0)]
		];
		
	}

}