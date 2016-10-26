package gimdata.mvc.model 
{
	import al.misc.Show;
	import al.objects.Box;
	import flash.geom.Point;
	import gimdata.core.config.Config;
	import gimdata.core.config.Factory;
	import gimdata.mvc.control.state.FSM;
	import gimdata.objects.building.Owner;
	import gimdata.objects.gui.CursorSelected;
	import gimdata.objects.gui.Sign;
	import gimdata.objects.gui.SignVillage;
	import gimdata.objects.tile.Tile1;
	import gimdata.objects.tile.Tile2;
	import gimdata.objects.unit.Unit;
	import gimdata.objects.unit.UnitDB;
	import starling.display.Image;
	/**
	 * ...
	 * @author Aldy Ahsadin
	 */
	public class ModelBattle 
	{
		
		//----------------------------------------------
		// yang berhubungan dengan state
		//----------------------------------------------
		public 	var fsm			: FSM;
		
		//----------------------------------------------
		// container objek
		//----------------------------------------------
		public 	var cTile1		: Vector.<Tile1>
		public 	var cTile2		: Vector.<Tile2>
		
		public	var cIMapsAlly	: Vector.<Box>;
		public	var cIMapsEnemy	: Vector.<Box>;
		public	var cTracks		: Vector.<Image>;
		
		
		public	var cOwners		: Vector.<Owner>;
		public 	var cUnits		: Vector.<Unit>
		public 	var cUnitJunk	: Vector.<Unit>;
		public	var cSigns		: Vector.<Sign>
		public	var cSelected	: Vector.<CursorSelected>
		
		
		//----------------------------------------------
		// yang berhubungan dengan data iMap
		//----------------------------------------------
		
		private	var _iMap		: Vector.<Number>;
		private	var _iMapAlly	: Vector.<Number>;
		private	var _iMapEnemy	: Vector.<Number>;
		private var _coverMap	: Vector.<Number>;
		
		
		
		public function ModelBattle() 
		{
			fsm			= new FSM();
			
			// -- basic --
			cTile1		= new Vector.<Tile1>();
			cTile2		= new Vector.<Tile2>();
			
			cIMapsAlly	= new Vector.<Box>();
			cIMapsEnemy	= new Vector.<Box>();
			cTracks		= new Vector.<Image>();
			
			cOwners		= new Vector.<Owner>();
			cUnits		= new Vector.<Unit>();
			cUnitJunk	= new Vector.<Unit>();
			cSigns		= new Vector.<Sign>();
			cSelected	= new Vector.<CursorSelected>();
			
			
			// -- imap --
			_iMap		= new Vector.<Number>();
			_iMapAlly	= new Vector.<Number>();
			_iMapEnemy	= new Vector.<Number>();
			_coverMap	= new Vector.<Number>();
			
			for (var i:int = 0; i < (Config.WIDTH * Config.HEIGHT); i++ ) {
				_iMap		.push(0);
				_iMapAlly	.push(0);
				_iMapEnemy	.push(0);
				_coverMap	.push(0);
			}
			
		}
		
		
		public function setAllUnits_active()
		{
			for (var i:int = 0; i < cUnits.length; i++ ) 
			cUnits[i].setActive(true);
		}
		
		/**
		 * Influence Map 
		 */
		public function get iMap():Vector.<Number> 
		{
			return _iMap;
		}
		
		/**
		 * Perlindungan
		 */
		public function get coverMap():Vector.<Number> 
		{
			return _coverMap;
		}
		
		//-------------------------------------------------
		// Independent Method
		//-------------------------------------------------
		
		/**
		 * fungsi untuk mencegah user menekan tombol apapun
		 */
		public function openHideBlock()
		{
			if (block.visible)
				block.visible = false;
			else
				block.visible = true;
		}
		
		
		/**
		 * Membuat influence map
		 */
		public	function updateIMap()
		{
			
			// reset imInfluence
			for (var r:int = 0; r < Config.HEIGHT; r++ ) {
			for (var c:int = 0; c < Config.WIDTH; c++ ) {
				var _curIndex: int = c + r * Config.WIDTH;
				
				_iMap		[_curIndex]		= 0;
				_iMapAlly	[_curIndex] 	= 0;
				_iMapEnemy	[_curIndex] 	= 0;
				
				
			}}
			
			// -------------------------------------------------
			// Mengeset nilai _influenceA dan _influenceE
			//  1. Menggabungkan IM setiap unit ally ke _influenceA
			//	2. Mencari nilai pembagi terbesar
			// -------------------------------------------------
			var _total	: int		= cUnits.length;
			var _biggest: Number	= -1;
			for (var i:int	= 0; i < _total; i++ ) {
				
				if (cUnits[i].db.category == Config.turn ) {
					
					// -----------------------
					// Mengeset _influenceA
					// -----------------------
					
					cUnits[i].makeIM();
					for (var r:int = 0; r < Config.HEIGHT; r++ ) {
					for (var c:int = 0; c < Config.WIDTH; c++ ) {
						var _curIndex: int 			= c + r * Config.WIDTH;
							_iMapAlly[_curIndex] 	+= cUnits[i].dIM[_curIndex]; 
						if (_iMapAlly[_curIndex] > _biggest) _biggest = _iMapAlly[_curIndex];
					}}
				
				} else {
					
					// -----------------------
					// Mengeset _influenceE
					// -----------------------
					
					cUnits[i].makeIM();
					
					for (var r:int = 0; r < Config.HEIGHT; r++ ) {
					for (var c:int = 0; c < Config.WIDTH; c++ ) {
						var _curIndex: int 			= c + r * Config.WIDTH;
							_iMapEnemy[_curIndex] 	+= cUnits[i].dIM[_curIndex]; 
						if (_iMapEnemy[_curIndex] > _biggest) _biggest = _iMapEnemy[_curIndex];
					}}
				}
			}
			
			//------------------------------------------------
			// dibagi dengan nilai terbesar
			//------------------------------------------------
			for (var r:int = 0; r < Config.HEIGHT; r++ ) {
			for (var c:int = 0; c < Config.WIDTH; c++ ) {
				var _curIndex:int 			= c + r * Config.WIDTH;
					_iMapAlly[_curIndex] 	/= _biggest;
					_iMapEnemy[_curIndex] 	/= _biggest;
			}}
			
			//------------------------------------------------
			// mengeset dIMap 
			//  - cari nilai selisih _influenceA - _influenceE
			//------------------------------------------------
			for (var r:int = 0; r < Config.HEIGHT; r++ ) {
			for (var c:int = 0; c < Config.WIDTH; c++ ) {
				var _curIndex:int 		= c + r * Config.WIDTH;
					_iMap[_curIndex]  	= _iMapAlly[_curIndex] - _iMapEnemy[_curIndex];
			}}
			
			// set imap itu unit selek
			if (Config.focused) {
				//Show.squareNum_zero("IMAP", _iMap, 8, 5);
				Config.focused.imap = _iMap[Config.focused.dPos.x + Config.focused.dPos.y * Config.WIDTH];
			}
				
		}
		
		/**
		 * Menghitung nilai cover yang diberikan tile
		 * terhadap clicked unit (target) 
		 * @param	_db
		 */ 
		public function updateCoverByUnit(_db:UnitDB)
		{
			for (var r:int = 0; r < Config.HEIGHT; r++ ) {
			for (var c:int = 0; c < Config.WIDTH; c++ ) {
				
				var _curIndex	: int = c + r * Config.WIDTH;
				var _indexType	: int = getTile(c, r).dType;
				_coverMap[_curIndex] = _db.terrainsCover[_indexType]
			}}
		}
		
		//-------------------------------------------------
		// Check method
		//-------------------------------------------------
		
		/**
		 * Apakah tile ini bisa dilewati?
		 * @param	_db db dari unit yang jadi patokan
		 * @param	_x tile x yang sedang di cek
		 * @param	_y tile y yang sedang di cek
		 * @return
		 */
		public function isTilePassable(_db:UnitDB, _x:int, _y:int):Boolean
		{
			var _tile:Tile2 = getTile(_x, _y);
			
			// cek apakah tipe tile bernilai true di db unit
			if (_tile != null && _db.terrainsStatus[ _tile.dType] ) 
				return true;
			else return false;
			
		}
		
		/**
		 * Apakah unit di tile(x,y) adalah musuh?
		 * @param	_db	db dari unit yang jadi patokan
		 * @param	_x tile x yang sedang di cek
		 * @param	_y tile y yang sedang di cek
		 * @return
		 */
		public function isUnitEnemy(_db:UnitDB, _x:int, _y:int):Boolean
		{
			var _unit: Unit = getUnit(_x, _y);
			return (_unit != null && _db.category != _unit.db.category)? true : false;
		}
		
		/**
		 * Apakah unit di tile(x,y) adalah ally?
		 * @param	_db
		 * @param	_x
		 * @param	_y
		 * @return
		 */
		public function isUnitAlly(_db:UnitDB, _x:int, _y:int):Boolean
		{
			var _unit: Unit = getUnit(_x, _y);
			return (_unit != null && _db.category == _unit.db.category)? true : false;
				 
		}
		
		/**
		 * Apakah di posi(x,y) terdapat suatu unit?
		 * @param	_x
		 * @param	_y
		 * @return
		 */
		public function isUnit(_x:int, _y:int):Boolean
		{
			var _touchPoint	: Point	= new Point(_x, _y);
			
			for (var i:int = 0; i < cUnits.length; i++ )
			if (cUnits[i].dPos.equals(_touchPoint)) {
				return true;
				break;
			}
			
			return false;
		}
		
		/**
		 * cek apakah ai selesai melakukan aksi 
		 */
		public function get afterAiAction():Boolean
		{
			if (Config.turn == "enemy") {
				for (var i:int = 0; i < cTile2.length; i++ ) 
				if (cTile2[i].isMove || cTile2[i].isTarget) {
					return true;
					break;
				}
				return false;
			} else
			return false;
		}
		
		//-------------------------------------------------
		// Get Object Method
		//-------------------------------------------------
		
		/**
		 * ambil tile berdasarkan posisi x, y
		 * @param	_x
		 * @param	_y
		 * @return
		 */
		public function getTile(_x:int, _y:int): Tile2
		{
			var _touchPoint	: Point	= new Point(_x, _y);
			var _tile		: Tile2	= null;
			for (var i:int = 0; i < cTile2.length; i++ )
			if (cTile2[i].dPos.equals(_touchPoint)) {
				_tile	= cTile2[i];
				break;
			}
			return _tile;
		}
		
		/**
		 * ambil unit berdasarkan posisi x, y
		 * @param	_x posisi x unit
		 * @param	_y posisi y unit
		 * @return
		 */
		public function getUnit(_x:int, _y:int):Unit 
		{
			var _unit		: Unit	= null;
			var _touchPoint	: Point	= new Point(_x, _y);
			
			for (var i:int = 0; i < cUnits.length; i++ )
			if (cUnits[i].dPos.equals(_touchPoint)) {
				_unit	= cUnits[i];
				break;
			}
			
			return _unit;
		}
		
		public function getUnits(_category:String):Vector.<Unit>
		{
			var _allies:Vector.<Unit> = new Vector.<Unit>();
			
			for (var i:int = 0; i < cUnits.length; i++ )
				if (cUnits[i].db.category == _category)
					_allies.push(cUnits[i]);
			
			return _allies;
		}
		
		public function getUnit_supply(_x:int, _y:int):Unit 
		{
			var _unit		: Unit	= null;
			var _touchPoint	: Point	= new Point(_x, _y);
			
			for (var i:int = 0; i < cUnits.length; i++ )
			if (cUnits[i].dPos.equals(_touchPoint) && cUnits[i].dType==9) {
				_unit	= cUnits[i];
				break;
			}
			
			return _unit;
		}
		
		public function getUnits_supply(_category:String):Vector.<Unit>
		{
			var _allies:Vector.<Unit> = new Vector.<Unit>();
			
			for (var i:int = 0; i < cUnits.length; i++ )
				if (cUnits[i].db.category == _category && cUnits[i].dType==9)
					_allies.push(cUnits[i]);
			
			return _allies;
		}
		
		public function getOwner(_x:int, _y:int):Owner {
			var _owner:Owner = null;
			for (var i:int = 0; i < cOwners.length; i++ ) {
				
				if (cOwners[i].dPos.equals(new Point(_x, _y))) {
					_owner = cOwners[i];
					break;
				}
			}
			return _owner;
		}
		
		//-------------------------------------------------
		// Get Map Method
		// fungsi yang memetakan suatu posisi objek 
		// nilai -1 menunjukkan terdapat suatu objek
		//-------------------------------------------------
		
		/**
		 * Melihat peta dimana tile yang bisa dilewati
		 * Peta akan bernilai 0 dan -1. 0 bisa dilewati -1 tidak
		 * @param	_db db dari unit yang jadi patokan
		 * @return
		 */
		public function getMap_PassableTiles(_db:UnitDB):Vector.<int>
		{
			var _map:Vector.<int> = new Vector.<int>();
			
			for (var r:int = 0; r < Config.HEIGHT; r++ ) {
			for (var c:int = 0; c < Config.WIDTH; c++ ) {
				
				if (isTilePassable(_db, c, r)) _map.push(0);
				else _map.push( -1);
				
			}}
			return _map;
		}
		
		/**
		 * Melihat peta dimana posisi musuh berdasarkan unit tertentu
		 * Peta akan bernilai 0 dan -1. 0 bisa dilewati -1 tidak
		 * @param	_db db dari unit yang jadi patokan
		 * @return
		 */
		public function getMap_EnemiesByUnit(_db:UnitDB):Vector.<int>
		{
			var _map:Vector.<int> = new Vector.<int>();
			
			for (var r:int = 0; r < Config.HEIGHT; r++ ) {
			for (var c:int = 0; c < Config.WIDTH; c++ ) {
				
				if (!isUnitEnemy(_db, c, r)) _map.push(0);
				else _map.push( -1);
				
			}}
			return _map;
		}
		
		/**
		 * Melihat peta dimana posisi ally berdasarkan unit tertentu
		 * Peta akan bernilai 0 dan -1. 0 bisa dilewati -1 tidak
		 * @param	_db
		 * @return
		 */
		public function getMap_AlliesByUnit(_db:UnitDB):Vector.<int>
		{
			var _map:Vector.<int> = new Vector.<int>();
			
			for (var r:int = 0; r < Config.HEIGHT; r++ ) {
			for (var c:int = 0; c < Config.WIDTH; c++ ) {
				
				if (isUnitAlly(_db, c, r)) _map.push(-1);
				else _map.push(0);
				
			}}
			return _map;
		}
		/**
		 * Melihat peta dimana posisi musuh berdasarkan kesamaan giliran
		 * Peta akan bernilai 0 dan -1. 0 bisa dilewati -1 tidak
		 * @return
		 */
		public function getMap_EnemiesByTurn():Vector.<int>
		{
			var _map:Vector.<int> = new Vector.<int>();
			
			for (var r:int = 0; r < Config.HEIGHT; r++ ) {
			for (var c:int = 0; c < Config.WIDTH; c++ ) {
				
				// jika terdapat unit
				if (isUnit(c, r)) {
					var _unit:Unit = getUnit(c, r);
					(_unit.db.category != Config.turn)? _map.push( -1):_map.push(0);	
				} else _map.push(0);
				
			}}
			return _map;
		}
		
		public function getMap_unitsValue():Vector.<Number>
		{
			var _map:Vector.<Number> = new Vector.<Number>();
			
			for (var r:int = 0; r < Config.HEIGHT; r++ ) {
			for (var c:int = 0; c < Config.WIDTH; c++ ) {
				
				// jika terdapat unit
				if (isUnit(c, r)) {
					
					var _unit:Unit = getUnit(c, r);
					if (_unit.db.category != Config.turn) {
						
						// komponen yang mempengaruhi value unit
						// 1. health unit
						// 2. enemy imap
						// 3. enemy cover
						// formula
						
						var _hp		: Number = _unit.dHP / _unit.db.hpFull;
						var _iMp	: Number = _iMap[c + r * Config.WIDTH] * -1;
						var _cv		: Number = _coverMap[c + r * Config.WIDTH];
						var _uVal	: Number = (_hp + _iMp + _cv) / 3;
						
						_map.push( _uVal);
					}
					else
						_map.push(0);	
				} else
					_map.push(0);
			}}
			return _map;
			
		}
		
		/**
		 * Melihat peta posisi bangunan
		 * @return
		 */
		public function getMap_Building():Vector.<Number>
		{
			var _map:Vector.<Number> = new Vector.<Number>();
			
			for (var r:int = 0; r < Config.HEIGHT; r++ ) {
			for (var c:int = 0; c < Config.WIDTH; c++ ) {
				
				// mengecek jika tipe tile adalah building
				var _owner:Owner = getOwner(c, r);
				if (getOwner(c, r) != null) {
					
					if (_owner.dCategory == "enemy") {
						switch(_owner.dTypeBuilding) {
							case 1: _map.push(-1); break;
							case 2: _map.push(-0.5); break;
						}
					} 
					else 
					if (_owner.dCategory == "ally") {
						switch(_owner.dTypeBuilding) {
							case 1: _map.push( 1.0); break;
							case 2: _map.push( 0.5); break;
						}
					}
				} else _map.push(0);
			}}
			return _map;
		}
		
		/**
		 * Menggabungkan dua map menjadi satu agar diketahui posisi yang bisa dilewati
		 * @param	_map1
		 * @param	_map2
		 * @return
		 */
		public function getMap_Combined(_map1:Vector.<int>, _map2:Vector.<int>):Vector.<int>
		{
			
			var _newMap:Vector.<int> = new Vector.<int>();
			
			for (var r:int = 0; r < Config.HEIGHT; r++ ) {
			for (var c:int = 0; c < Config.WIDTH; c++ ) {
				if (_map1[c + r * Config.WIDTH] == 0 && _map2[c + r * Config.WIDTH] ==0)
					_newMap.push(0);
				else
					_newMap.push(-1);
			}}
			return _newMap;
		}
		
		
		/**
		 * Ambil data map area kuning aktif tidak termasuk tile yang ada unit kawan
		 * 0 menunjukkan area aktif dan -1 yang tidak
		 * @return
		 */
		public function getMap_WalkArea():Vector.<int>
		{
			var _newMap:Vector.<int> = new Vector.<int>();
			
			for (var r:int = 0; r < Config.HEIGHT; r++ ) {
			for (var c:int = 0; c < Config.WIDTH; c++ ) {
				if (cTile2[c + r * Config.WIDTH].isMove)
					_newMap.push(0);
				else
					_newMap.push(-1);
			}}
			return _newMap;
		}
		
		/**
		 * Ambil data map yang menunjukkan area gerak atau serang
		 * 0 menunjukkan area aktif dan -1 yang tidak
		 * @return
		 */
		public function getMap_WalkAndTargetArea():Vector.<int>
		{
			var _newMap:Vector.<int> = new Vector.<int>();
			
			for (var r:int = 0; r < Config.HEIGHT; r++ ) {
			for (var c:int = 0; c < Config.WIDTH; c++ ) {
				if (cTile2[c + r * Config.WIDTH].isMove || cTile2[c + r * Config.WIDTH].isTarget)
					_newMap.push(0);
				else
					_newMap.push(-1);
			}}
			return _newMap;
		}
		
		
		//-------------------------------------------------
		// Get Posisi
		//-------------------------------------------------
		
		/**
		 * Mencari posisi musuh yang berada dalam target
		 * @return
		 */
		public function getPos_target():Vector.<Point>
		{
			
			var _enemyPos:Vector.<Point> = new Vector.<Point>();
			
			for (var r:int = 0; r < Config.HEIGHT; r++ ) {
			for (var c:int = 0; c < Config.WIDTH; c++ ) {
				
				if (cTile2[c + r * Config.WIDTH].isTarget) {
					//if (getUnit(c, r).db.category != Config.turn) {
						_enemyPos.push(new Point(c, r));
					//}
				}
			}}
			return _enemyPos;
		}
		
		/**
		 * Mencari posisi musuh
		 * @return
		 */
		public function getPos_enemiesByTurn():Vector.<Point>
		{
			var _enemyPos:Vector.<Point> = new Vector.<Point>();
			for (var i:int = 0; i < cUnits.length; i++ ) {
				
				var _currUnit:Unit = cUnits[i];
				
				// set AI pada enemy
				if (_currUnit.db.category != Config.turn) {
					_enemyPos.push(_currUnit.dPos);
				}
			}
			return _enemyPos;
		}
		
		/**
		 * 
		 * @param	_center
		 * @param	_range harus positif
		 * @return
		 */
		public function getPos_enemyAround(_center:Point, _range:int):Vector.<Point> 
		{
			_range							= Math.abs(_range);
			var _enemies: Vector.<Point>	= new Vector.<Point>();
				
			// catat semua posisi musuh di sekitar basecamp
			for (var _y:int = -_range; _y <= _range; _y++ )
			for (var _x:int = -_range; _x <= _range; _x++ )
			{
				var _pos:Point = new Point(_center.x + _x, _center.y + _y);
				if ((_pos.x >= 0 && _pos.y >= 0) && (_pos.x < Config.WIDTH && _pos.y < Config.HEIGHT))
				if ((getUnit(_pos.x, _pos.y) != null) && (getUnit(_pos.x, _pos.y).db.category!=Config.turn)) 
				_enemies.push(_pos);
			}
			return _enemies;
		}
		
		/**
		 * Mendapatkan semua posisi ally
		 * @return
		 */
		public function getPos_alliesByTurn():Vector.<Point>
		{
			var _alliesPos:Vector.<Point> = new Vector.<Point>();
			for (var i:int = 0; i < cUnits.length; i++ ) {
				
				var _currUnit:Unit = cUnits[i];
				
				// set AI pada enemy
				if (_currUnit.db.category == Config.turn) {
					_alliesPos.push(_currUnit.dPos);
				}
			}
			return _alliesPos;
		}
		
		/**
		 * Dapatkan posisi building
		 * @param	_type
		 * @return
		 */
		public function getPos_baseCamp(_type:String):Point {
			var _pos:Point = null;
			for (var i:int = 0; i < cOwners.length; i++ ) {
				if (cOwners[i].dCategory == _type && cOwners[i].dTypeBuilding == 1) {
					_pos = cOwners[i].dPos;
					break;
				}
			}
			return _pos
		}
		
		public function getPos_villages(_type:String):Vector.<Point>
		{
			var _pos:Vector.<Point> = new Vector.<Point>()
			for (var i:int = 0; i < cOwners.length; i++ ) {
				if (cOwners[i].dCategory == _type) 
					_pos.push( cOwners[i].dPos);
				
			}
			return _pos
		}
		
		public function getPos_supply(_category:String):Vector.<Point>
		{
			var _supplies	:Vector.<Unit> 	= getUnits_supply(_category);
			var _pos		:Vector.<Point>	= new Vector.<Point>();
			
			for (var i:int = 0; i < _supplies.length; i++)
				_pos.push(_supplies[i].dPos);
			return _pos;
		}
		
		
		//-------------------------------------------------
		// Normalisation
		//-------------------------------------------------
		
		/**
		 * Mengonversi nilai map vector
		 * mengubah negatif menjadi 0
		 * mengubah 0 menjadi 1
		 * @param	_oldMap
		 * @return
		 */
		public function negative_toZero(_oldMap:Vector.<int>): Vector.<Number>
		{
			var _newMap:Vector.<Number> = new Vector.<Number>();
			for (var i:int = 0; i < _oldMap.length; i++ ) {
				if (_oldMap[i] == -1)
					_newMap.push(0.0);
				else
					_newMap.push(1.0);
			}
			return _newMap;
		}
		
		/**
		 * Mengonversi nilai map vector
		 * mengubah negatif menjadi 1
		 * mengubah 0 menjadi 0
		 * @param	_oldMap
		 * @return
		 */
		public function negative_toOne(_oldMap:Vector.<int>): Vector.<Number>
		{
			var _newMap:Vector.<Number> = new Vector.<Number>();
			for (var i:int = 0; i < _oldMap.length; i++ ) {
				if (_oldMap[i] == -1)
					_newMap.push(1.0);
				else
					_newMap.push(0.0);
			}
			return _newMap;
		}
		
		//-------------------------------------------------
		// Deletion
		//-------------------------------------------------
		
		/**
		 * Hapus Units
		 * @param	_unit
		 */
		public function removeUnit(_unit:Unit)
		{
			var _total:int = cUnits.length;
			for (var i:int = 0; i < _total; i++ ) {
				if (_unit == cUnits[i]) {
					cUnitJunk.push(_unit);
					cUnits.splice(i, 1);
					_unit.visible = false;
					break;
				}
			}
			
		}
		
		
	}

}