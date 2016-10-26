package gimdata.mvc.control.action {
	import al.ai.astar.AStar;
	import al.misc.Show;
	import aldyahsn.air.ai.astar.AStar;
	import flash.geom.Point;
	import gimdata.core.config.Config;
	import gimdata.mvc.model.ModelBattle;
	import gimdata.objects.unit.Unit;
	/**
	 * Kelas yang berhubungan dengan pencarian posisi atau jarak optimal
	 * @author Aldy Ahsandin
	 */
	public class Path 
	{
		/**
		 * Mengaktifkan "ground yang bisa dilewati dan tidak" saat perhitungan algoritma pencarian posisi
		 */
		public static var enablePassableTiles	:Boolean = false;
		/**
		 * Mengaktifkan "kehadiran posisi musuh" saat perhitungan algoritma pencarian posisi
		 */
		public static var enableEnemyPos		:Boolean = false;
		/**
		 * Mengaktifkan "area aktif" saat perhitungan algoritma pencarian posisi
		 */
		public static var enableAreaActive		:Boolean = false;
		/**
		 * Mengaktifkan "kehadiran posisi ally" saat perhitungan algoritma pencarian posisi
		 */
		public static var enableAllyPos			:Boolean = false;
		
		/**
		 * Dapatkan input peta berdasarkan parameter-parameter tertentu
		 * @param	_bData
		 * @param	_fromUnit
		 * @return
		 */
		private static function getMap(_bData:ModelBattle, _fromUnit:Unit):Vector.<int>
		{
			var _map		: Vector.<int> 	= new Vector.<int>();
			var _mapLength	: int			= Config.WIDTH * Config.HEIGHT;
			for (var i:int = 0; i < _mapLength; i++ )
				_map.push(0);
			
			// jika  mengaktifkan input peta yang bisa dilewati
			if(enablePassableTiles)
			{
				var _mapTiles: Vector.<int> 	= _bData.getMap_PassableTiles(_fromUnit.db);
				_map							= _bData.getMap_Combined(_map, _mapTiles);
			}
			
			// jika  mengaktifkan input posisi musuh
			if (enableEnemyPos)
			{
				var _mapEnemies	: Vector.<int> 	= _bData.getMap_EnemiesByUnit(_fromUnit.db);
				_map							= _bData.getMap_Combined(_map, _mapEnemies);
			}
			
			// jika  mengaktifkan input area aktif
			if (enableAreaActive)
			{
				var _mapArea	: Vector.<int>	= _bData.getMap_WalkArea();
				_map							= _bData.getMap_Combined(_map, _mapArea);
			}
			
			// jika  mengaktifkan input posisi ally
			if (enableAllyPos)
			{
				var _mapAlly	: Vector.<int>	= _bData.getMap_AlliesByUnit(_fromUnit.db);
				_map							= _bData.getMap_Combined(_map, _mapAlly);
			}
			
			return _map;
		}
		
		/**
		 * Menemukan PATH dari unit tertentu ke titik tertentu
		 * berdasarkan faktor passable tile, posisi area aktif dan musuh
		 * @param	_fromUnit
		 * @param	_toPos
		 * @return
		 */
		public static function findPath(_bData:ModelBattle, _fromUnit:Unit, _toPos:Point, _isNearest:Boolean=false):Vector.<Point> 
		{
			
			// inisialisasi data yang diperlukan
			var _fromPos	: Point				= _fromUnit.dPos;
			var _map		: Vector.<int>		= getMap(_bData, _fromUnit);
			
			// Mengosongkan nilai di posisi target
			_map[_fromUnit.dPos.x + _fromUnit.dPos.y * Config.WIDTH] 	= 0;
			_map[_toPos.x + _toPos.y * Config.WIDTH] 					= 0;
			
			Show.square_negatif("FINDING PATH", _map, Config.WIDTH, Config.HEIGHT);
			
			// mencari pathfinding
			var _aStar		: AStar				= new AStar(_map, Config.WIDTH, Config.HEIGHT);
			var _result		: Vector.<Point>	= _aStar.searchPath(_fromPos, _toPos, false, _isNearest)
			
			return _result;
			
		}
		
		
		
		/**
		 * Mencari posisi START paling optimum dari jarak end Pos 
		 * terdapat beberapa pilihan START posisi yang dibatasi oleh BOUNDARY
		 * @param	_isMax		apakah mencari posisi terjauh (_isMax=true) atau terdekat(_isMax:false) ?
		 * @param	_bData		ModelBattle
		 * @param	_fromUnit	unit yang akan bergerak
		 * @param	_endPos		posisi end pos
		 * @param	_boundary	batas start posisi yang akan diseleksi
		 * @return				posisi start paling optimum
		 */
		public static function find_OptStartPos(
		_isMax		: Boolean,
		_bData		: ModelBattle, 
		_fromUnit	: Unit, 
		_endPos		: Point,
		_boundary	: Vector.<int>):Point{
			/* Goal	*/
			var _pos		: Point 		= null;
			var _bestRange	: int			= (_isMax)? -999:999;
			
			
			/* resource yg dibutuhkan: area aktif, map, dan algoritma A* */
			var _map		: Vector.<int>	= getMap(_bData, _fromUnit);
			var _aStar		: AStar			= new AStar(_map, Config.WIDTH, Config.HEIGHT);
			
			
			_map[_fromUnit.dPos.x + _fromUnit.dPos.y * Config.WIDTH] 	= 0;
			_map[_endPos.x + _endPos.y * Config.WIDTH] 					= 0;
			
			Show.square_negatif("PATH IN AREA", _map, Config.WIDTH, Config.HEIGHT);
			//trace("> END POINT", _endPos + "\n");
			
			//hitung jarak dari setiap posisi di area aktif 
			//cari yang paling dekat _toPos
			
			for (var r:int = 0; r < Config.HEIGHT; r++ ) {
			for (var c:int = 0; c < Config.WIDTH; c++ ) {
				
				if (_boundary[c + r * Config.WIDTH] == 0) {
					
					var _tilePos: Point				= new Point(c, r)
					var _path	: Vector.<Point>	= _aStar.searchPath( _tilePos, _endPos, false);
					var _result : int 				= _path.length;
					//trace(" -------------------------")
					//trace(_path);
					//trace("> ", _result, _tilePos);
					
					if ((_isMax)?(_result > _bestRange):(_result < _bestRange)) {
						
						_bestRange 	= _result;
						_pos		= new Point(c, r);
						
					}	
				}
			}}
			
			return _pos;
		}
		
		/**
		 * Mencari posisi END Pos paling optimum dari jarak start Pos 
		 * terdapat beberapa pilihan END posisi
		 * @param	_isMax
		 * @param	_bData
		 * @param	_fromUnit
		 * @param	_someEndPos
		 * @return
		 */
		public static function find_OptEndPos(
		_isMax			: Boolean,
		_bData			: ModelBattle, 
		_fromUnit		: Unit, 
		_someEndPos		: Vector.<Point>):Point {
			
			//trace("SEARCH PATH");
			/* Goal	*/
			var _pos		: Point 		= null;
			var _bestRange	: int			= (_isMax)? -999:999;
			var _map		: Vector.<int>	= getMap(_bData, _fromUnit);
			
			//Show.square_negatif("PATH IN AREA", _map, Config.WIDTH, Config.HEIGHT);
			var _aStar		: AStar			= new AStar(_map, Config.WIDTH, Config.HEIGHT);
			
			for (var i:int = 0; i < _someEndPos.length; i++ ) {
				
				var _path	:Vector.<Point>	= _aStar.searchPath(_fromUnit.dPos, _someEndPos[i], false);
				var _range	:int 			= _path.length;
				
				//trace("> range all: " + _range, _fromUnit.dPos, _someEndPos[i]);
				
				if ((_isMax)?(_range > _bestRange):(_range < _bestRange)) {
					
					// catat path terakhir yang dijangkau
					_bestRange 	= _range;
					_pos		= _path[_path.length-1];
					//trace("> path: ", _path);
				}
			}
			//trace("  from, to: ", _fromUnit.dPos, _pos)
			//trace("\n");
			return _pos;
			
		}
		
		
	}

}