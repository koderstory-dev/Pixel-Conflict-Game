package gimdata.core.config 
{
	import al.core.Ast;
	import aldyahsn.air.core.Ast;
	import gimdata.objects.unit.UnitDB;
	import raj.soundlite.MSound;
	import raj.soundlite.MSoundGroup;
	import starling.display.Image;
	import starling.display.MovieClip;
	/**
	 * Static Factory  Class
	 * @author Aldy Ahsandin
	 */
	public class Factory 
	{
		// -----------------------------------------------------
		// Membuat Data Tile
		// -----------------------------------------------------
		public static const NUMTILE1:int = 76;
		public static function createTile1(_nomor:int):MovieClip
		{
			var _tile1:MovieClip;
			if (_nomor <= 52) 	_tile1 = new MovieClip(Ast.imgs("tile1", "tile1_"+((_nomor<10)?"0"+_nomor:_nomor)), 2)
			
			// sea
			if (_nomor == 53)  _tile1 = new MovieClip(Ast.imgs("tile1", "sea0"), 1);
			if (_nomor == 56)  _tile1 = new MovieClip(Ast.imgs("tile1", "sea1"), 1);
			if (_nomor == 59)  _tile1 = new MovieClip(Ast.imgs("tile1", "sea2"), 1);
			if (_nomor == 62)  _tile1 = new MovieClip(Ast.imgs("tile1", "sea3"), 1);
			if (_nomor == 65)  _tile1 = new MovieClip(Ast.imgs("tile1", "sea4"), 1);
			if (_nomor == 68)  _tile1 = new MovieClip(Ast.imgs("tile1", "sea5"), 1);
			if (_nomor == 71)  _tile1 = new MovieClip(Ast.imgs("tile1", "sea6"), 1);
			if (_nomor == 74)  _tile1 = new MovieClip(Ast.imgs("tile1", "sea7"), 1);
			
			return _tile1;
		}
		
		// ----------------------------- //
		// Data Terrain sesuai urutan 
		// ----------------------------- //
		/*	1:baseCamp1,
		 *  2:baseCamp2,
		 *  3:village1,
		 *  4:village2,
		 *  5:forest1,
		 *  6:forest2,
		 *  7:mountain1, 
		 *  8:mountain2,
		 *  9:bridge1,
		 * 10:bridge2,
		 * 11:grass,
		 * 12:ground,
		 * 13:field,
		 * 14:swamp,
		 * 15:sand,
		 * 16:street
		 * 17:river
		 * 18:sea
		*/
		public static function createTile2(_nomor:int):Image
		{
			_nomor = _nomor - NUMTILE1;
			switch(_nomor) {
				case 1	: return new Image(Ast.img("tile2", "1_baseCamp")); break;
				case 2	: return new Image(Ast.img("tile2", "2_baseCamp")); break;
				case 3	: return new Image(Ast.img("tile2", "3_village"	)); break;
				case 4	: return new Image(Ast.img("tile2", "4_village"	)); break;
				case 5	: return new Image(Ast.img("tile2", "5_forest"	)); break;
				case 6	: return new Image(Ast.img("tile2", "6_forest"	)); break;
				case 7	: return new Image(Ast.img("tile2", "7_mountain")); break;
				case 8	: return new Image(Ast.img("tile2", "8_mountain")); break;
				case 9	: return new Image(Ast.img("tile2", "9_bridge"	)); break;
				case 10	: return new Image(Ast.img("tile2", "10_bridge"	)); break;
				default	: return null;
			}
		}
		
		public static function createTileStatus(_type:int):MovieClip
		{
			var _tileObject: MovieClip;
			switch(_type) {
				case 1	: _tileObject	= new MovieClip(Ast.imgs("uiTileStatus","movable_"), 2);	break;
				case 2	: _tileObject	= new MovieClip(Ast.imgs("uiTileStatus", "target_"), 1); 	break;
				case 3	: _tileObject	= new MovieClip(Ast.imgs("uiTileStatus","movable_"), 2);	break;
			}
			return _tileObject;
		}
		
		// -----------------------------------------------------
		// Membuat Data Unit
		// -----------------------------------------------------
		
		public static function createUnitDB(_type:int):UnitDB
		{
			var _db			: UnitDB;
			var _country	: String = "ally";
			if (_type > 10) {
				_country = "enemy";
				_type %= 10;
			}
			
			switch(_type)
			{
				/*
					set default unit data
				 	1. 	Data Default: health, action, move, isMedic, isDirectAttack, kategori "ally" atau "enemys"
				 	2. 	Data Terrain Status (baseCamp-village-forest-mountain-bridge)
											 (grass, ground, field, swamp, sand) (river, sea)
					3.	Data Terrain Cover
				*/
				//-------------------------------------------------------------------------
				// infantry
				// infantry, mGun, rocketLauncher bisa bergerak dimana saja. 
				// Tempat padang akan mengurangi perlindungan
				//-------------------------------------------------------------------------
				case 1	: 	_db	= new UnitDB	(9, 3, 3, false, true, _country); 
				//{
							// TERRAIN-TERRAIN YANG BISA DILEWATI//
							_db.terrainsStatus	.push(
							/*basecamp*/ 	1,1,
							/*village*/ 	1,1,
							/*forest*/		1,1,
							/*mountain*/	1,1,
							/*bridge*/ 		1,1, 
							/*grass*/		1,	
							/*ground*/		1,
							/*field*/		1,
							/*swamp*/		1,
							/*sand*/		1,
							/*street*/		1,
							/*river*/		1,
							/*sea*/			0);			// --- X ---- //
							
							// BESARNYA NILAI COVER SETIAP TERRAIN//
							_db.terrainsCover	.push(	
							/*basecamp*/ 	0.9,0.9,
							/*village*/ 	0.9,0.9,
							/*forest*/		0.5,0.5,
							/*mountain*/	0.7,0.7,
							/*bridge*/ 		0.1,0.1, 
							/*grass*/		0.2,	
							/*ground*/		0,
							/*field*/		0.5,
							/*swamp*/		-0.1,
							/*sand*/		0,  
							/*street*/		-0.1,
							/*river*/		-0.3,
							/*sea*/			0);			// --- X ---- //
							
							break;
				//}			
				
				//-------------------------------------------------------------------------
				// mGun
				//-------------------------------------------------------------------------
				case 2	: 	_db	= new UnitDB	(7, 6, 3, false, true, _country); 
				//{
							// TERRAIN-TERRAIN YANG BISA DILEWATI//
							_db.terrainsStatus	.push(
							/*basecamp*/ 	1,1,
							/*village*/ 	1,1,
							/*forest*/		1,1,
							/*mountain*/	1,1,
							/*bridge*/ 		1,1, 
							/*grass*/		1,	
							/*ground*/		1,
							/*field*/		1,
							/*swamp*/		1,
							/*sand*/		1,
							/*street*/		1,
							/*river*/		1,
							/*sea*/			0);			// --- X ---- //
							
							// BESARNYA NILAI COVER SETIAP TERRAIN//
							_db.terrainsCover	.push(	
							/*basecamp*/ 	0.9,0.9,
							/*village*/ 	0.9,0.9,
							/*forest*/		0.7,0.7,
							/*mountain*/	0.3,0.3,
							/*bridge*/ 		0.1,0.1, 
							/*grass*/		0,	
							/*ground*/		0,
							/*field*/		0.5,
							/*swamp*/		-0.1,
							/*sand*/		0,  
							/*street*/		-0.2,
							/*river*/		-0.3,
							/*sea*/			0);			// --- X ---- //
							
							break;
				//}			
				
				//-------------------------------------------------------------------------
				// rocket launcher
				//-------------------------------------------------------------------------
				case 3	: 	_db	= new UnitDB	(3, 8, 3, false, true, _country); 
				//{
							// TERRAIN-TERRAIN YANG BISA DILEWATI//
							_db.terrainsStatus	.push(
							/*basecamp*/ 	1,1,
							/*village*/ 	1,1,
							/*forest*/		1,1,
							/*mountain*/	1,1,
							/*bridge*/ 		1,1, 
							/*grass*/		1,	
							/*ground*/		1,
							/*field*/		1,
							/*swamp*/		1,
							/*sand*/		1,
							/*street*/		1,
							/*river*/		1,
							/*sea*/			0);			// --- X ---- //
							
							// BESARNYA NILAI COVER SETIAP TERRAIN//
							_db.terrainsCover	.push(	
							/*basecamp*/ 	0.8,0.8,
							/*village*/ 	0.8,0.8,
							/*forest*/		0.6,0.6,
							/*mountain*/	0.5,0.5,
							/*bridge*/ 		0.1,0.1, 
							/*grass*/		0,	
							/*ground*/		0,
							/*field*/		0.3,
							/*swamp*/		-0.1,
							/*sand*/		0,  
							/*street*/		0,
							/*river*/		-0.3,
							/*sea*/			0);			// --- X ---- //
							
							break;
				//}
							
				//-------------------------------------------------------------------------
				// car
				// mobil di tempat yang luas malah bergerak luas, dapat menghindari serangan
				// mobil hanya bisa bergerak di tempat yang tanahnya baik
				//-------------------------------------------------------------------------
				case 4	: 	_db	= new UnitDB	(7, 6, 4, false, true, _country); 
				//{
							
							// TERRAIN-TERRAIN YANG BISA DILEWATI//
							_db.terrainsStatus	.push(
							/*basecamp*/ 	1,1,
							/*village*/ 	1,1,
							/*forest*/		1,1,
							/*mountain*/	0,0,	// --- X ---- //
							/*bridge*/ 		1,1, 
							/*grass*/		1,	
							/*ground*/		1,
							/*field*/		0,		// --- X ---- //
							/*swamp*/		0,		// --- X ---- //
							/*sand*/		1,
							/*street*/		1,
							/*river*/		0,		// --- X ---- //
							/*sea*/			0);		// --- X ---- //
							
							// BESARNYA NILAI COVER SETIAP TERRAIN//
							_db.terrainsCover	.push(	
							/*basecamp*/ 	0.8,0.8,
							/*village*/ 	0.6,0.6,
							/*forest*/		0.2,0.2,
							/*mountain*/	0.0,0.0,		// --- X ---- //
							/*bridge*/ 		0.1,0.1, 
							/*grass*/		0.4,	
							/*ground*/		0.4,
							/*field*/		0.3,
							/*swamp*/		0.0,			// --- X ---- //
							/*sand*/		0.3,  
							/*street*/		0.4,
							/*river*/	   -0.2,			// --- X ---- //
							/*sea*/			0.0);			// --- X ---- //
							
							break;
				//}
							
				//-------------------------------------------------------------------------
				// apc
				// apc adalah kendaraan yang menggunakan roda bergerigi yang bisa berjalan di kondisi apapun
				// terrain-terrain yang bisa menutup mesin cukup menambah perlindungan
				//-------------------------------------------------------------------------
				case 5	: 	_db	= new UnitDB	(10, 7, 4, false, true, _country); 
				//{
							// TERRAIN-TERRAIN YANG BISA DILEWATI//
							_db.terrainsStatus	.push(
							/*basecamp*/ 	1,1,
							/*village*/ 	1,1,
							/*forest*/		1,1,
							/*mountain*/	0,0,	// --- X ---- //
							/*bridge*/ 		1,1, 
							/*grass*/		1,	
							/*ground*/		1,
							/*field*/		0,
							/*swamp*/		0,
							/*sand*/		1,
							/*street*/		1,
							/*river*/		0,		// --- X ---- //
							/*sea*/			0);		// --- X ---- //
							
							// BESARNYA NILAI COVER SETIAP TERRAIN//
							_db.terrainsCover	.push(	
							/*basecamp*/ 	0.7,0.7,
							/*village*/ 	0.7,0.7,
							/*forest*/		0.3,0.3,
							/*mountain*/	0.0,0.0,		// --- X ---- //
							/*bridge*/ 		0.1,0.1, 
							/*grass*/		0.4,	
							/*ground*/		0.4,
							/*field*/		0,
							/*swamp*/		0.0,
							/*sand*/		0.0,  
							/*street*/		0.4,
							/*river*/	    0.0,			// --- X ---- //
							/*sea*/			0.0);			// --- X ---- //
							
							break;
				//}
							
				//-------------------------------------------------------------------------
				// tank
				// adalah kendaraan yang menggunakan roda khusus utk berjalan di medan apapun
				//-------------------------------------------------------------------------
				case 6	: 	_db	= new UnitDB	(15, 12, 4, false, true, _country); 
				//{
							// TERRAIN-TERRAIN YANG BISA DILEWATI//
							_db.terrainsStatus	.push(
							/*basecamp*/ 	1,1,
							/*village*/ 	1,1,
							/*forest*/		1,1,
							/*mountain*/	0,0,	// --- X ---- //
							/*bridge*/ 		1,1, 
							/*grass*/		1,	
							/*ground*/		1,
							/*field*/		1,
							/*swamp*/		1,
							/*sand*/		1,
							/*street*/		1,
							/*river*/		0,		// --- X ---- //
							/*sea*/			0);		// --- X ---- //
							
							// BESARNYA NILAI COVER SETIAP TERRAIN//
							_db.terrainsCover	.push(	
							/*basecamp*/ 	0.8,0.8,
							/*village*/ 	0.6,0.6,
							/*forest*/		0.5,0.5,
							/*mountain*/	0.0,0.0,		// --- X ---- //
							/*bridge*/ 		0.0,0.0, 
							/*grass*/		0.2,	
							/*ground*/		0.0,
							/*field*/		0.3,
							/*swamp*/		0.0,
							/*sand*/		0.0,  
							/*street*/		0.0,
							/*river*/	   -0.2,			// --- X ---- //
							/*sea*/			0.0);			// --- X ---- //
							
							break;
				//}			
				
				//-------------------------------------------------------------------------
				// artillery
				//-------------------------------------------------------------------------
				case 7	: 	_db	= new UnitDB	(5, 8, 4, false, false, _country); 
				//{
							_db.terrainsStatus	.push(
							/*basecamp*/ 	1,1,
							/*village*/ 	1,1,
							/*forest*/		0,0,
							/*mountain*/	0,0,
							/*bridge*/ 		1,1, 
							/*grass*/		1,	
							/*ground*/		1,
							/*field*/		1,
							/*swamp*/		0,		// --- X ---- //
							/*sand*/		0,
							/*street*/		1,
							/*river*/		0,		// --- X ---- //
							/*sea*/			0);		// --- X ---- //
							
							// BESARNYA NILAI COVER SETIAP TERRAIN//
							_db.terrainsCover	.push(	
							/*basecamp*/ 	0.8,0.8,
							/*village*/ 	0.6,0.6,
							/*forest*/		0.5,0.5,
							/*mountain*/	0.6,0.6,
							/*bridge*/ 		0.0,0.0, 
							/*grass*/		0.2,	
							/*ground*/		0.0,
							/*field*/		0.3,
							/*swamp*/		0.0,		// --- X ---- //
							/*sand*/		0.0,  
							/*street*/		0.0,
							/*river*/	    0.0,		// --- X ---- //
							/*sea*/			0.0);		// --- X ---- //
							
							break;
				//}
							
				//-------------------------------------------------------------------------
				// artilleryTruck
				//-------------------------------------------------------------------------
				case 8	: 	_db	= new UnitDB	(7, 15, 4, false, false, _country); 
				//{
							// TERRAIN-TERRAIN YANG BISA DILEWATI//
							_db.terrainsStatus	.push(
							/*basecamp*/ 	1,1,
							/*village*/ 	1,1,
							/*forest*/		1,1,
							/*mountain*/	1,1,
							/*bridge*/ 		1,1, 
							/*grass*/		1,	
							/*ground*/		1,
							/*field*/		1,
							/*swamp*/		0,		// --- X ---- //
							/*sand*/		1,
							/*street*/		1,
							/*river*/		0,		// --- X ---- //
							/*sea*/			0);		// --- X ---- //
							
							// BESARNYA NILAI COVER SETIAP TERRAIN//
							_db.terrainsCover	.push(	
							/*basecamp*/ 	0.8,0.8,
							/*village*/ 	0.6,0.6,
							/*forest*/		0.5,0.5,
							/*mountain*/	0.6,0.6,
							/*bridge*/ 		0.0,0.0, 
							/*grass*/		0.2,	
							/*ground*/		0.0,
							/*field*/		0.3,
							/*swamp*/		0.0,		// --- X ---- //
							/*sand*/		0.0,  
							/*street*/		0.0,
							/*river*/	    0.0,		// --- X ---- //
							/*sea*/			0.0);		// --- X ---- //
							
							break;
				//}
				//-------------------------------------------------------------------------
				// medic
				// di tempat2 yang bisa menutup dirinya
				// roda tidak bisa berjalan di semua medan
				//-------------------------------------------------------------------------
				
				
				case 9	: 	_db	= new UnitDB	(12, 7, 4, true, true, _country); 
				//{
							// TERRAIN-TERRAIN YANG BISA DILEWATI//
							_db.terrainsStatus	.push(
							/*basecamp*/ 	1,1,
							/*village*/ 	1,1,
							/*forest*/		0,0,
							/*mountain*/	0,0,	// --- X ---- //
							/*bridge*/ 		1,1, 
							/*grass*/		1,	
							/*ground*/		1,
							/*field*/		0,
							/*swamp*/		0,		// --- X ---- //
							/*sand*/		0,		// --- X ---- //
							/*street*/		1,
							/*river*/		0,
							/*sea*/			0);
							
							// BESARNYA NILAI COVER SETIAP TERRAIN//
							_db.terrainsCover	.push(	
							/*basecamp*/ 	0.8,0.8,
							/*village*/ 	0.6,0.6,
							/*forest*/		0.6,0.6,
							/*mountain*/	0.0,0.0,// --- X ---- //
							/*bridge*/ 		0.0,0.0, 
							/*grass*/		0.2,	
							/*ground*/		0,
							/*field*/		0.3,
							/*swamp*/		0,		// --- X ---- //
							/*sand*/		0,		// --- X ---- //  
							/*street*/		0,
							/*river*/		0.0,
							/*sea*/			0);
							
							break;
				//}
				
						
			}
			return _db;
		}
		
		public static function createUnit(_type:int, _isAlly:Boolean, _dir:String, _status:String):MovieClip
		{
			
			//Data Unit sesuai urutan
			//[infantry, mGun, RocketLauncher, car, apc, tank, artillery, artilleryTruck, medic]
			
			if (_type > 10) {
				_type %= 10;
			}
			
			var _atlas				:String;
			switch(_type)
			{
				case 1	: _atlas = "infantry_"; break;
				case 2	: _atlas = "mGunner_"; break;
				case 3	: _atlas = "rocket_"; break;
				case 4	: _atlas = "car_"; break;
				case 5	: _atlas = "apc_"; break;
				case 6	: _atlas = "tank_"; break;
				case 7	: _atlas = "artillery_"; break;
				case 8	: _atlas = "artilleryTruck_"; break;
				case 9	: _atlas = "supply_"; break;
			}
			
			_atlas = (_status == "I")? _atlas + "idle":_atlas + "walk";
			
			var _fileTextureAtlas	:String 	= (_isAlly)? "unitsAlly":"unitsEnemy";
			var _unit				:MovieClip 	= new MovieClip(Ast.imgs(_fileTextureAtlas, _atlas), 2);
			
			if (_dir == "L") {
				_unit.scaleX = -1;
				_unit.x += _unit.width;
				
			}
			return _unit;
		}
		
		// -----------------------------------------------------
		// Membuat Data Cinematic
		// -----------------------------------------------------
		// ----------------------------- //
		// Data Terrain sesuai urutan 
		// ----------------------------- //
		/*	1:baseCamp1,
		 *  2:baseCamp2,
		 *  3:village1,
		 *  4:village2,
		 *  5:forest1,
		 *  6:forest2,
		 *  7:mountain1, 
		 *  8:mountain2,
		 *  9:bridge1,
		 * 10:bridge2,
		 * 11:grass,
		 * 12:ground,
		 * 13:field,
		 * 14:swamp,
		 * 15:sand,
		 * 16:street
		 * 17:river
		 * 18:sea
		*/
		public static function createCinematicBG(_type:int):Image
		{
			var _bg:Image;
			switch(_type)
			{
				case 1	: _bg = new Image(Ast.img("cinBG_village")); break;
				case 2	: _bg = new Image(Ast.img("cinBG_village")); break;
				case 3	: _bg = new Image(Ast.img("cinBG_village")); break;
				case 4	: _bg = new Image(Ast.img("cinBG_village")); break;
				case 5	: _bg = new Image(Ast.img("cinBG_forest")); break;
				case 6	: _bg = new Image(Ast.img("cinBG_forest")); break;
				case 7	: _bg = new Image(Ast.img("cinBG_hill")); break;
				case 8	: _bg = new Image(Ast.img("cinBG_hill")); break;
				case 9	: _bg = new Image(Ast.img("cinBG_grass")); break;
				case 10	: _bg = new Image(Ast.img("cinBG_grass")); break;
				case 11	: _bg = new Image(Ast.img("cinBG_grass")); break;
				case 12	: _bg = new Image(Ast.img("cinBG_ground")); break;
				case 13	: _bg = new Image(Ast.img("cinBG_field")); break;
				case 14	: _bg = new Image(Ast.img("cinBG_swamp")); break;
				case 15	: _bg = new Image(Ast.img("cinBG_street")); break;
				case 16	: _bg = new Image(Ast.img("cinBG_street")); break;
				case 17	: _bg = new Image(Ast.img("cinBG_river")); break;
				case 18	: _bg = new Image(Ast.img("cinBG_river")); break;
				
			}
			return _bg;
		}
		
		public static function createCinematicUnit(_type:int, _behaviour:int, _isAlly:Boolean):MovieClip {
			var _mc:MovieClip = null;
			if(_isAlly){
			if(_type ==1)
			switch(_behaviour) {
				case 1	: _mc = new MovieClip(Ast.imgs("cinematicInfantry", "InfantryWalk"), 
											 (Math.floor(Math.random() * (6 - 4 + 1)) + 4)); break;
				case 2	: _mc = new MovieClip(Ast.imgs("cinematicInfantry", "InfantryDuck"),
											 (Math.floor(Math.random() * (4 - 2 + 1)) + 2)); break;
				case 3	: _mc = new MovieClip(Ast.imgs("cinematicInfantry", "InfantryWait"), 
											 (Math.floor(Math.random() * (4 - 1 + 1)) + 1)); break;
				case 4	: _mc = new MovieClip(Ast.imgs("cinematicInfantry", "InfantryWaitAttack"), 
											 (Math.floor(Math.random() * (4 - 1 + 1)) + 1)); break;
				case 5	: _mc = new MovieClip(Ast.imgs("cinematicInfantry", "InfantryDie"), 6); break;
			}
			
			else
			if(_type ==2)
			switch(_behaviour) {
				case 1	: _mc = new MovieClip(Ast.imgs("cinematicMGunner", "MGunnerWalk"), 
											 (Math.floor(Math.random() * (6 - 4 + 1)) + 4)); break;
				case 2	: _mc = new MovieClip(Ast.imgs("cinematicMGunner", "MGunnerDuck"),
											 (Math.floor(Math.random() * (4 - 2 + 1)) + 2)); break;
				case 3	: _mc = new MovieClip(Ast.imgs("cinematicMGunner", "MGunnerWait"), 
											 (Math.floor(Math.random() * (7 - 4 + 1)) + 4)); break;
				case 4	: _mc = new MovieClip(Ast.imgs("cinematicMGunner", "MGunnerWaitNAttack"), 
											 (Math.floor(Math.random() * (4 - 4 + 1)) + 4)); break;
				case 5	: _mc = new MovieClip(Ast.imgs("cinematicMGunner", "MGunnerDie"), 6); break;
			}
			
			else
			if(_type ==3)
			switch(_behaviour) {
				case 1	: _mc = new MovieClip(Ast.imgs("cinematicRocket", "RocketWalk"), 
											 (Math.floor(Math.random() * (6 - 4 + 1)) + 4)); break;
				case 2	: _mc = new MovieClip(Ast.imgs("cinematicRocket", "RocketDuck"),
											 (Math.floor(Math.random() * (4 - 2 + 1)) + 2)); break;
				case 3	: _mc = new MovieClip(Ast.imgs("cinematicRocket", "RocketWait"),7); break;
				case 4	: _mc = new MovieClip(Ast.imgs("cinematicRocket", "RocketWaitNAttack"), 
											 (Math.floor(Math.random() * (5 - 4 + 1)) + 4)); break;
				case 5	: _mc = new MovieClip(Ast.imgs("cinematicRocket", "RocketDie"), 6); break;
			}
			
			else
			if(_type ==4)
			switch(_behaviour) {
				case 1	: _mc = new MovieClip(Ast.imgs("cinematicCar", "CarWalk"), 
											 (Math.floor(Math.random() * (6 - 4 + 1)) + 4)); break;
				case 2	: _mc = new MovieClip(Ast.imgs("cinematicCar", "CarWait"),2); break;
				case 3	: _mc = new MovieClip(Ast.imgs("cinematicCar", "CarWaitNAttack"),6); break;
				case 4	: _mc = new MovieClip(Ast.imgs("cinematicCar", "CarDie"), 1); break;
			}
			
			if(_type ==5)
			switch(_behaviour) {
				case 1	: _mc = new MovieClip(Ast.imgs("cinematicArmour", "ApcWalk"), 
											 (Math.floor(Math.random() * (6 - 4 + 1)) + 4)); break;
				case 2	: _mc = new MovieClip(Ast.imgs("cinematicArmour", "ApcWait"),2); break;
				case 3	: _mc = new MovieClip(Ast.imgs("cinematicArmour", "ApcWaitNAttack"),8); break;
				case 4	: _mc = new MovieClip(Ast.imgs("cinematicArmour", "ApcDie"), 1); break;
			}
			
			if(_type ==6)
			switch(_behaviour) {
				case 1	: _mc = new MovieClip(Ast.imgs("cinematicArmour", "TankWalk"), 
											 (Math.floor(Math.random() * (6 - 4 + 1)) + 4)); break;
				case 2	: _mc = new MovieClip(Ast.imgs("cinematicArmour", "TankWait"),2); break;
				case 3	: _mc = new MovieClip(Ast.imgs("cinematicArmour", "TankWaitNAttack"),4); break;
				case 4	: _mc = new MovieClip(Ast.imgs("cinematicArmour", "TankDie"), 1); break;
			}
			
			
			else
			if(_type ==7)
			switch(_behaviour) {
				case 1	: _mc = new MovieClip(Ast.imgs("cinematicArtillery", "ArtilleryWait0000"), 
											 (Math.floor(Math.random() * (3 - 2 + 1)) + 2)); break;
				case 2	: _mc = new MovieClip(Ast.imgs("cinematicArtillery", "ArtilleryAttack"),
											 (Math.floor(Math.random() * (7 - 5 + 1)) + 5)); break;
				case 3	: _mc = new MovieClip(Ast.imgs("cinematicArtillery", "ArtilleryDie"), 6); break;
			}
			
			else
			if(_type ==8)
			switch(_behaviour) {
				case 1	: _mc = new MovieClip(Ast.imgs("cinematicArmour", "ArtilleryTruckAttack0000"), 
											 (Math.floor(Math.random() * (3 - 2 + 1)) + 2)); break;
				case 2	: _mc = new MovieClip(Ast.imgs("cinematicArmour", "ArtilleryTruckAttack"),
											 (Math.floor(Math.random() * (7 - 5 + 1)) + 5)); break;
				case 3	: _mc = new MovieClip(Ast.imgs("cinematicArmour", "ArtilleryTruckDie"), 6); break;
			}
			
			else
			if(_type ==9)
			switch(_behaviour) {
				case 1	: _mc = new MovieClip(Ast.imgs("cinematicArmour", "MedicWait"), 2); break;
				case 2	: _mc = new MovieClip(Ast.imgs("cinematicArmour", "MedicDie"), 6); break;
			}
			}
			
			// ---------------------------------------------------------------------------------------------
			//  asset enemy
			// ---------------------------------------------------------------------------------------------
			else{
			if(_type ==1)
			switch(_behaviour) {
				case 1	: _mc = new MovieClip(Ast.imgs("cinematicInfantryE", "InfantryWalk"), 
											 (Math.floor(Math.random() * (6 - 4 + 1)) + 4)); break;
				case 2	: _mc = new MovieClip(Ast.imgs("cinematicInfantryE", "InfantryDuck"),
											 (Math.floor(Math.random() * (4 - 2 + 1)) + 2)); break;
				case 3	: _mc = new MovieClip(Ast.imgs("cinematicInfantryE", "InfantryWait"), 
											 (Math.floor(Math.random() * (4 - 1 + 1)) + 1)); break;
				case 4	: _mc = new MovieClip(Ast.imgs("cinematicInfantryE", "InfantryWaitAttack"), 
											 (Math.floor(Math.random() * (4 - 1 + 1)) + 1)); break;
				case 5	: _mc = new MovieClip(Ast.imgs("cinematicInfantryE", "InfantryDie"), 6); break;
			}
			
			else
			if(_type ==2)
			switch(_behaviour) {
				case 1	: _mc = new MovieClip(Ast.imgs("cinematicMGunnerE", "MGunnerWalk"), 
											 (Math.floor(Math.random() * (6 - 4 + 1)) + 4)); break;
				case 2	: _mc = new MovieClip(Ast.imgs("cinematicMGunnerE", "MGunnerDuck"),
											 (Math.floor(Math.random() * (4 - 2 + 1)) + 2)); break;
				case 3	: _mc = new MovieClip(Ast.imgs("cinematicMGunnerE", "MGunnerWait"), 
											 (Math.floor(Math.random() * (7 - 4 + 1)) + 4)); break;
				case 4	: _mc = new MovieClip(Ast.imgs("cinematicMGunnerE", "MGunnerWaitNAttack"), 
											 (Math.floor(Math.random() * (4 - 4 + 1)) + 4)); break;
				case 5	: _mc = new MovieClip(Ast.imgs("cinematicMGunnerE", "MGunnerDie"), 6); break;
			}
			
			else
			if(_type ==3)
			switch(_behaviour) {
				case 1	: _mc = new MovieClip(Ast.imgs("cinematicRocketE", "RocketWalk"), 
											 (Math.floor(Math.random() * (6 - 4 + 1)) + 4)); break;
				case 2	: _mc = new MovieClip(Ast.imgs("cinematicRocketE", "RocketDuck"),
											 (Math.floor(Math.random() * (4 - 2 + 1)) + 2)); break;
				case 3	: _mc = new MovieClip(Ast.imgs("cinematicRocketE", "RocketWait"),7); break;
				case 4	: _mc = new MovieClip(Ast.imgs("cinematicRocketE", "RocketWaitNAttack"), 
											 (Math.floor(Math.random() * (5 - 4 + 1)) + 4)); break;
				case 5	: _mc = new MovieClip(Ast.imgs("cinematicRocketE", "RocketDie"), 6); break;
			}
			
			else
			if(_type ==4)
			switch(_behaviour) {
				case 1	: _mc = new MovieClip(Ast.imgs("cinematicCarE", "CarWalk"), 
											 (Math.floor(Math.random() * (6 - 4 + 1)) + 4)); break;
				case 2	: _mc = new MovieClip(Ast.imgs("cinematicCarE", "CarWait"),2); break;
				case 3	: _mc = new MovieClip(Ast.imgs("cinematicCarE", "CarWaitNAttack"),6); break;
				case 4	: _mc = new MovieClip(Ast.imgs("cinematicCarE", "CarDie"), 1); break;
			}
			
			if(_type ==5)
			switch(_behaviour) {
				case 1	: _mc = new MovieClip(Ast.imgs("cinematicArmourE", "ApcWalk"), 
											 (Math.floor(Math.random() * (6 - 4 + 1)) + 4)); break;
				case 2	: _mc = new MovieClip(Ast.imgs("cinematicArmourE", "ApcWait"),2); break;
				case 3	: _mc = new MovieClip(Ast.imgs("cinematicArmourE", "ApcWaitNAttack"),8); break;
				case 4	: _mc = new MovieClip(Ast.imgs("cinematicArmourE", "ApcDie"), 1); break;
			}
			
			if(_type ==6)
			switch(_behaviour) {
				case 1	: _mc = new MovieClip(Ast.imgs("cinematicArmourE", "TankWalk"), 
											 (Math.floor(Math.random() * (6 - 4 + 1)) + 4)); break;
				case 2	: _mc = new MovieClip(Ast.imgs("cinematicArmourE", "TankWait"),2); break;
				case 3	: _mc = new MovieClip(Ast.imgs("cinematicArmourE", "TankWaitNAttack"),4); break;
				case 4	: _mc = new MovieClip(Ast.imgs("cinematicArmourE", "TankDie"), 1); break;
			}
			
			
			else
			if(_type ==7)
			switch(_behaviour) {
				case 1	: _mc = new MovieClip(Ast.imgs("cinematicArtilleryE", "ArtilleryWait0000"), 
											 (Math.floor(Math.random() * (3 - 2 + 1)) + 2)); break;
				case 2	: _mc = new MovieClip(Ast.imgs("cinematicArtilleryE", "ArtilleryAttack"),
											 (Math.floor(Math.random() * (7 - 5 + 1)) + 5)); break;
				case 3	: _mc = new MovieClip(Ast.imgs("cinematicArtilleryE", "ArtilleryDie"), 6); break;
			}
			
			else
			if(_type ==8)
			switch(_behaviour) {
				case 1	: _mc = new MovieClip(Ast.imgs("cinematicArmourE", "ArtilleryTruckAttack0000"), 
											 (Math.floor(Math.random() * (3 - 2 + 1)) + 2)); break;
				case 2	: _mc = new MovieClip(Ast.imgs("cinematicArmourE", "ArtilleryTruckAttack"),
											 (Math.floor(Math.random() * (7 - 5 + 1)) + 5)); break;
				case 3	: _mc = new MovieClip(Ast.imgs("cinematicArmourE", "ArtilleryTruckDie"), 6); break;
			}
			
			else
			if(_type ==9)
			switch(_behaviour) {
				case 1	: _mc = new MovieClip(Ast.imgs("cinematicArmourE", "MedicWait"), 2); break;
				case 2	: _mc = new MovieClip(Ast.imgs("cinematicArmourE", "MedicDie"), 6); break;
			}
			
			}
			return _mc;
		}
		
		
	}

}