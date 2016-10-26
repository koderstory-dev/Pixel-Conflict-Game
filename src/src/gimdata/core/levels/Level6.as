package gimdata.core.levels 
{
	import flash.geom.Point;
	import org.as3collections.iterators.ArrayIterator;
	/**
	 * ...
	 * @author Aldy Ahsadin
	 */
	public class Level6 
	{
		
		// -- INFO BASIC
		public static const BATTLENAME		: String 	= "#6 Protect Base";
		public static const COMMANDER_ALLY	: String 	= "Captain Falcon";
		public static const COMMANDER_ENMY	: String 	= "Unknown Captain";
		public static const limitDay		: int		= 6;
		
		// -- TILE DATA
		public static const TILE1			: Array =
		[
			56,1,1,1,1,1,38,1,
			56,1,1,1,1,1,42,1,
			56,1,1,1,1,1,39,40,
			56,1,1,1,1,1,1,1,
			59,65,65,65,65,65,65,65
		];
		
		public static const TILE2			: Array =
		[
			94,84,82,83,82,82,92,82,
			94,82,82,82,82,82,92,82,
			94,80,82,82,84,82,92,92,
			94,77,80,82,82,83,82,82,
			94,94,94,94,94,94,94,94

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
			00, 01, 00, 00, 00, 00, 00, 00,
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
			00, 00, 00, 00, 00, 00, 00, 11,
			00, 02, 00, 00, 00, 00, 00, 12,
			00, 01, 00, 02, 00, 00, 00, 15,
			00, 00, 00, 02, 00, 00, 00, 15,
			00, 00, 00, 00, 00, 00, 00, 00
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
			[new Point(7, 2), "attack_closest"], 
			[new Point(7, 3), "attack_in_range", 4], 
			[new Point(7, 0), "move_responsive", new Point(1, 3)],
			[new Point(7, 1), "move_responsive", new Point(1, 3)]
		];
		
		/*
			unit (X,Y) mati maka game selesai
		*/
		public static const WIN_TARGET: Array =
		[
			//new Point(7, 3) 
		];
	
		/*
			WIn pos adalah titik jika unit A menyentuh titik B, maka game selesai
			
			unit A titik B
			example: [new Point(7, 0), new Point(1, 3)],
		*/
		public static const WIN_POS	:Array = 
		[
			[new Point(7, 0), new Point(1, 3)],
			[new Point(7, 1), new Point(1, 3)]
		];
		
	}

}