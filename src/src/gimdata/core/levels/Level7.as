package gimdata.core.levels 
{
	import flash.geom.Point;
	import org.as3collections.iterators.ArrayIterator;
	/**
	 * ...
	 * @author Aldy Ahsadin
	 */
	public class Level7 
	{
		
		// -- INFO BASIC
		public static const BATTLENAME		: String 	= "#7 Sabotage";
		public static const COMMANDER_ALLY	: String 	= "Captain Falcon";
		public static const COMMANDER_ENMY	: String 	= "Unknown Captain";
		public static const limitDay		: int		= 7;
		
		// -- TILE DATA
		public static const TILE1			: Array =
		[
			1,1,1,1,1,22,9,1,
			1,1,20,1,1,22,10,1,
			1,1,42,1,21,27,5,1,
			1,6,42,1,22,1,1,1,
			6,1,20,1,22,1,1,1
		];
		
		public static const TILE2			: Array =
		[
			82,82,82,82,83,93,89,77,
			82,82,78,87,84,93,89,87,
			81,81,92,82,93,93,83,87,
			83,82,92,87,93,78,87,82,
			82,79,78,82,93,81,82,82
		];
		
		/*	
			1:baseCamp, 
			2:village, 	
		*/ 
		public static const OWNERS			: Array =
		[
			00, 00, 00, 00, 00, 00, 00, 11,
			00, 00, 12, 00, 00, 00, 00, 00,
			00, 00, 00, 00, 00, 00, 00, 00,
			00, 00, 00, 00, 00, 12, 00, 00,
			00, 00, 12, 00, 00, 00, 00, 00
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
			02, 00, 00, 00, 00, 00, 11, 11,
			01, 00, 11, 00, 00, 00, 00, 00,
			00, 00, 00, 00, 00, 00, 00, 00,
			00, 00, 00, 00, 00, 12, 00, 00,
			00, 00, 11, 00, 00, 00, 00, 00
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
			[new Point(2, 1), "attack_in_range", 2],
			[new Point(2, 4), "attack_in_range", 2],
			[new Point(5, 3), "attack_in_range", 2],
			[new Point(6, 0), "attack_in_range", 2],
			[new Point(7, 0), "attack_in_range", 2]
		];
		
		//new Point(7, 3), //new Point(7, 3)  
		public static const WIN_TARGET: Array =
		[
			
		];
		
		
		/*
			WIn pos adalah titik jika unit A menyentuh titik B, maka game selesai
			
			unit A titik B
			example: [new Point(7, 0), new Point(1, 3)],
		*/
		public static const WIN_POS	:Array = 
		[
			
		];
		
	}

}