package gimdata.mvc.control.action 
{
	import al.misc.Show;
	import com.greensock.TweenMax;
	import flash.geom.Point;
	import gimdata.core.config.Config;
	import gimdata.mvc.model.ModelBattle;
	import gimdata.objects.unit.Unit;
	/**
	 * ...
	 * @author AldyAhsandin
	 */
	public class Action 
	{
		
		public function Action() 
		{
			
		}
		
		 /**
		  * Menyerang ke unit tertentu
		  * @param	_attacker	Unit yang menyerang
		  * @param	_defender	Unit yang bertahan
		  * @param	_modelBattle		ModelBattle
		  */
		public static function attack(_attacker:Unit, _defender:Unit, _modelBattle:ModelBattle):void {
			
			var _damage:int = getDmgAttack(_attacker, _defender, _modelBattle);
			//--------------------------------------						
			// Kurangi health unit target
			//--------------------------------------
			trace("DMAGAE:", _damage);
			_defender.setFast_dHP( _defender.dHP - _damage);
			trace("defender[AFTER]:", _defender.dHP);
		}
		
		/**
		 * Melakukan aksi ke suatu titik. Jika titik tidak dalam jangkauan maka cari titik terdekat dalam jangkaun. Jika diblok
		 * maka serang musuh yang mengeblok
		 * @param	_pos	target posisi
		 * @param	_model
		 * @param	_isActionToEnemy	true jika aksi di titik tersebut akan dilakukan untuk AI enemy, false sebaliknya
		 */
		public static function toDo(_pos:Point, _model:ModelBattle, _isActionToEnemy:Boolean=true):Array
		{
			var _attackResult:Array = new Array;
			
			if (_pos) {
				
				// Cek apakah posisi base ada dalam jarak serang, 
				Path.enableAllyPos 			= true;
				Path.enableAreaActive		= false;
				Path.enableEnemyPos			= false;
				Path.enablePassableTiles 	= true;
				var _path: Vector.<Point>	= Path.findPath(_model, Config.focused,  _pos, true);
				
				// -- cek jika ada musuh yang memblok
				var _enemyBlock:Point		= null;
				for (var i:int = 0; i < _path.length; i++ ){
					var _currPos: Point 	= _path[i];
					var _currUnit:Unit		= _model.getUnit(_currPos.x, _currPos.y) ;
					
					if (( _currUnit	!= null) && (_currUnit.db.category 	!= Config.turn)) {
						_enemyBlock = _currPos;
						break;	
					}
				}
				
				// -----------------------------
				// jika berada di range serang
				// -----------------------------
				if (_path.length<=Config.focused.db.move && _enemyBlock) {
					trace("> TARGET PATH-BLOCKED");
					_attackResult.push( { todo:"action", pos:_enemyBlock} );
				} 
				
				// -----------------------------
				// jika berada di luar range serang
				// -----------------------------
				else {
					var _movePos:Point = (Config.focused.db.move <= _path.length)?
										_path[Config.focused.db.move-1]:_path[_path.length - 1];
					trace("> TARGET PATH-NOBLOCKED");
					_attackResult.push({todo:"moving",pos:_movePos});
				}
				
				// Jika ada musuh, maka serang musuh. tidak ada maka gerak ke posisi
				// jika Tidak. cari posisi gerak terdekat
				
			}
			
			return _attackResult;
		}
		
		/**
		 * Menambah nyawa unit
		 * @param	_healer unit supply
		 * @param	_target target yang diberi tambahan supply
		 */
		public static function heal(_healer:Unit, _target:Unit) {
			
			// heal target
			_target.setFast_dHP(_target.dHP + _healer.db.act);
			
			
		}
		
		public static function getDefensive(_attacker:Unit,  _modelBattle:ModelBattle):int
		{
			_modelBattle.updateCoverByUnit(_attacker.db);
			var _index:int 	= Config.clicked.tile.dPos.x + Config.clicked.tile.dPos.y * Config.WIDTH;
			var cover:int	= 100 * _modelBattle.coverMap[_index];
			return cover;
		}
		
		public static function getDefensiveAtk(_attacker:Unit,  _modelBattle:ModelBattle):int
		{
			_modelBattle.updateCoverByUnit(_attacker.db);
			var _pos:Point;
			if (_attacker.db.isDirectAct) {
				Path.enableAllyPos = true;
				Path.enableAreaActive = false;
				Path.enableEnemyPos = false;
				Path.enablePassableTiles = true;
				var _path:Vector.<Point> = Path.findPath(_modelBattle, _attacker, Config.clicked.tile.dPos);
					_pos = _path[_path.length - 2];
			} else _pos = _attacker.dPos;
			
			var _index:int 	=_pos.x + _pos.y * Config.WIDTH;
			var cover:int	= 100 * _modelBattle.coverMap[_index];
			return cover;
		}
		
		/**
		 * Mencari nilai  besarnya serangan
		 * @param	_attacker
		 * @param	_defender
		 * @param	_modelBattle
		 * @return
		 */
		public static function getDmgAttack(_attacker:Unit, _defender:Unit, _modelBattle:ModelBattle):int
		{
			var _pos:Point;
			if (_attacker.db.isDirectAct) {
				Path.enableAllyPos = true;
				Path.enableAreaActive = false;
				Path.enableEnemyPos = false;
				Path.enablePassableTiles = true;
				var _path:Vector.<Point> = Path.findPath(_modelBattle, _attacker, _defender.dPos);
					_pos = _path[_path.length - 2];
					trace("Attacker Pos: ", _pos)
			} else _pos = _attacker.dPos;
			
			//Show.squareNum_zero("IMAP", _modelBattle.iMap, 8, 5);
			//--------------------------------------
			// Inisialisasi Damage Calculation
			//--------------------------------------
			var curHP	: int 	= _attacker.dHP;
			var baseAtk	: int 	= _attacker.db.act;
			var hpFull	: int 	= _attacker.db.hpFull;
			var IM		: int 	= 	100 * _modelBattle.iMap[ _pos.x + _pos.y *  Config.WIDTH];
			var cover	: int 	= 	100 * _modelBattle.coverMap[_defender.dPos.x +_defender.dPos.y * Config.WIDTH];
			
			// pengaturan IM untuk serangan balik, jika nilai negatif maka ubah jadi positif, sebaliknya negtf jadi pstif
			if (Config.turn != _attacker.db.category) {
				IM = (IM < 0)?-IM: IM;
			}
			//--------------------------------------						
			// Hhtung Damage
			//--------------------------------------
			var damage 	: int	= 	(baseAtk) 				* 
									(curHP / hpFull) 		* 
									((	100 + IM) 	/ 100)	* 
									(	100 / (100 	+ cover));
									
			trace("--------------------------------------------------")	
			trace("Penyerang adalah ", _attacker.db.category);
			trace("HP:"+curHP, "HPfull:"+hpFull,"Atk:"+baseAtk,"IM:"+IM,"Cover:"+cover,"DMG:"+damage);
			trace("--------------------------------------------------\n")	
			
			return (damage <= 0)? 0:damage;
		}
		
		
		/**
		 * Mencari besarnya nilai bahaya di suatu area
		 * @param	_centerPos		titik pusat pengecekan
		 * @param	_range			jangkauan pengecekan
		 * @param	_modelBattle	data model battle
		 */
		public static function getAlert(_centerPos:Point, _range:int, _modelBattle:ModelBattle) 
		{
			var	_dAlert	: int	= 0;
			
			// --------------------------------------------------
			// cek sekeliling basecamp
			// --------------------------------------------------
			for (var _y:int = -_range; _y <= _range; _y++ )
			for (var _x:int = -_range; _x <= _range; _x++ )
			{
				
				// posisi yang akan dicek
				var _pos:Point = new Point(_centerPos.x + _x, _centerPos.y + _y);
				
				// cek apakah posisi _x, _y masih dalam map
				if ((_pos.x >= 0 && _pos.y >= 0) && (_pos.x < Config.WIDTH && _pos.y < Config.HEIGHT))
				{
					// jika suatu titik terdapat unit 
					
					if (_modelBattle.getUnit(_pos.x, _pos.y) != null) {
						
						if (_centerPos.equals(_pos)) {
								
							//-------------------------------------------------------------------------------------
							// jika musuh
							if (_modelBattle.getUnit(_pos.x, _pos.y).db.category != Config.turn)
							_dAlert = (_modelBattle.getUnit(_pos.x, _pos.y).dType % 10 <= 3)? _dAlert -999 :_dAlert-(4*_range);
							
							// jika kawan
							else if(_modelBattle.getUnit(_pos.x, _pos.y).db.category == Config.turn)
							_dAlert = (_modelBattle.getUnit(_pos.x, _pos.y).dType % 10 <= 3)? _dAlert + (2*_range):_dAlert+(4*_range);
							//-------------------------------------------------------------------------------------
							
						} else {
								
							//-------------------------------------------------------------------------------------
							// jika musuh
							if (_modelBattle.getUnit(_pos.x, _pos.y).db.category != Config.turn)
							_dAlert = (_modelBattle.getUnit(_pos.x, _pos.y).dType % 10 <= 3)? _dAlert-(3*_range):_dAlert-(_range);
							
							// jika kawan
							else if(_modelBattle.getUnit(_pos.x, _pos.y).db.category == Config.turn)
							_dAlert = (_modelBattle.getUnit(_pos.x, _pos.y).dType % 10 <= 3)? _dAlert +(3*_range):_dAlert+(_range);
							//-------------------------------------------------------------------------------------	
						}
							
					} else _dAlert += 0; // jika kosong
					
				}
			}

			// --------------------------------------------------
			// apakah dalam bahaya
			// --------------------------------------------------
			
			return _dAlert;
		}
		
		
	}

}