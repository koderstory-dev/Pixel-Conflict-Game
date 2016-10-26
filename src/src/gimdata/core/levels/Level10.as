package gimdata.core.levels 
{
	import flash.geom.Point;
	import org.as3collections.iterators.ArrayIterator;
	/**
	 * ...
	 * @author Aldy Ahsadin
	 */
	public class Level10
	{
		
		// -- INFO BASIC
		public static const BATTLENAME		: String 	= "#10 Last Breath";
		public static const COMMANDER_ALLY	: String 	= "Captain Falcon";
		public static const COMMANDER_ENMY	: String 	= "Unknown Captain";
		public static const limitDay		: int		= 4;
		
		// -- TILE DATA
		public static const TILE1			: Array =
		[
			3,1,5,12,9,9,9,8,
			2,5,11,9,9,1,5,8,
			3,1,5,10,9,1,7,8,
			2,5,11,9,9,6,5,8,
			3,1,5,12,9,9,9,8
		];
		
		public static const TILE2			: Array =
		[
			87,87,88,89,89,89,89,82,
			87,88,89,89,89,79,80,83,
			87,87,88,89,89,87,79,77,
			87,88,89,89,89,79,80,84,
			87,87,88,89,89,89,89,82
		];
		
		/*	
			1:baseCamp, 
			2:village, 	
		*/ 
		public static const OWNERS			: Array =
		[
			00, 00, 00, 00, 00, 00, 00, 00,
			00, 00, 00, 00, 00, 00, 00, 00,
			00, 00, 00, 00, 00, 00, 00, 11,
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
			00, 00, 00, 00, 11, 00, 00, 12,
			00, 02, 00, 00, 00, 00, 17, 00,
			09, 03, 00, 00, 00, 00, 11, 00,
			00, 02, 00, 00, 00, 00, 17, 00,
			00, 00, 00, 00, 12, 00, 00, 12
		];
		
		/*
		
		[new Point (x,y), "ai", (parameter)]
	
		AI:
		1: "attack_in_range"
			example: [new Point(7, 3), "attack_in_range", 4],
			
		2: "attack_in_sight"
			example: [new Point(3, 3), "attack_in_sight"]
				
		3: "attack_closest"
			example: [new Point(7, 2), "attack_closest"]
			
		4: "attack_weakest"
			example: [new Point(5, 1), "attack_weakest"]
		
		5: "move_responsive"
			example: [new Point(7, 0), "move_responsive", new Point(1, 3)] 
				
		6: "supply_move"
			[new Point(7, 0), "supply_move", new Point(1, 3)],
			
		*/
		
		public static const UNITS_AI: Array =
		[
			[new Point(4, 0), "attack_closest"],
			[new Point(4, 4), "attack_closest"],
			[new Point(6, 1), "attack_in_sight"],
			[new Point(6, 2), "attack_closest"],
			[new Point(6, 3), "attack_in_range", 3],
			[new Point(7, 0), "attack_in_range", 3],
			[new Point(7, 4), "attack_in_range", 3]
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