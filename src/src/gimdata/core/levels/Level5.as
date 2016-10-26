package gimdata.core.levels 
{
	import flash.geom.Point;
	import org.as3collections.iterators.ArrayIterator;
	/**
	 * ...
	 * @author Aldy Ahsadin
	 */
	public class Level5 
	{
		
		// -- INFO BASIC
		public static const BATTLENAME		: String 	= "#5 No Turning Back";
		public static const COMMANDER_ALLY	: String 	= "Captain Falcon";
		public static const COMMANDER_ENMY	: String 	= "Unknown Captain";
		public static const limitDay		: int		= 10;
		
		// -- TILE DATA
		public static const TILE1			: Array =
		[
			2,1,09,3,10,12,1,1,
			40,40,40,40,40,40,45,40,
			25,1,1,1,1,1,42,1,
			22,13,1,09,1,1,42,1,
			26,37,40,40,40,44,43,1
		];
		
		public static const TILE2			: Array =
		[
			87,84,89,79,89,89,82,78,
			92,92,92,92,92,92,92,92,
			93,83,80,83,84,83,92,84,
			93,90,83,89,84,78,92,78,
			93,92,92,92,92,92,92,77

		];
		
		/*	
			1:baseCamp, 
			2:village, 	
		*/ 
		public static const OWNERS			: Array =
		[
			00, 00, 00, 00, 00, 00, 00, 12,
			00, 00, 00, 00, 00, 00, 00, 00,
			00, 00, 00, 00, 00, 00, 00, 00,
			00, 00, 00, 00, 00, 00, 00, 00,
			00, 00, 00, 00, 00, 00, 00, 11
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
			01, 02, 12, 00, 00, 00, 00, 00,
			06, 06, 00, 00, 00, 00, 00, 00,
			00, 01, 00, 12, 00, 00, 00, 00,
			00, 00, 00, 17, 00, 15, 00, 15,
			00, 00, 12, 00, 00, 00, 00, 00
		];
		
		
		public static const UNITS_AI: Array =
		[
			[new Point(2, 0), "attack_in_range", 1],// unit yg akan dimasukkan AI, AI, posisi tujuan
			[new Point(2, 4), "attack_weakest"],// unit yg akan dimasukkan AI, AI, posisi tujuan
			[new Point(3, 2), "attack_in_range", 1],// unit yg akan dimasukkan AI, AI, posisi tujuan
			[new Point(3, 3), "attack_in_sight"],// unit yg akan dimasukkan AI, AI, posisi tujuan
			[new Point(5, 3), "attack_closest"],// unit yg akan dimasukkan AI, AI, posisi tujuan
			[new Point(7, 3), "attack_in_range", 2]// unit yg akan dimasukkan AI, AI, posisi tujuan
			
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