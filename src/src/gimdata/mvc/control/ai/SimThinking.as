package gimdata.mvc.control.ai 
{
	import al.misc.Show;
	import flash.geom.Point;
	import gimdata.core.config.Config;
	import gimdata.core.constant.Goal;
	import gimdata.mvc.control.action.Action;
	import gimdata.mvc.control.action.Path;
	import gimdata.mvc.control.ControlBattle;
	import gimdata.mvc.model.ModelBattle;
	import gimdata.objects.unit.Unit;
	import org.as3collections.ISortedMap;
	import org.as3collections.maps.SortedArrayListMap;
	/**
	 * ...
	 * @author AldyAhsandin
	 */
	public class SimThinking 
	{
		// ------------------------------------------------------------------
		// output dari simulasi berpikir
		// ------------------------------------------------------------------
		public 	var type		: int;
		public 	var targetPos	: Point;
		// ------------------------------------------------------------------
		
		private	var m_modelBattle	: ModelBattle;
		private var m_controlBattle	: ControlBattle;
		
		
		public function SimThinking(_mBattle: ModelBattle,_cBattle:ControlBattle)
		{
			// basic data
			m_modelBattle 	= _mBattle;
			m_controlBattle	= _cBattle;
			
			// posisi base camp
			m_ourBasePos	= m_modelBattle.getPos_baseCamp(Config.turn);
			m_bX			= Config.WIDTH;
			m_bY			= Config.HEIGHT;
			
		}
		
		public function play()
		{
			switch(Config.focused.dModeAI) {
				case "attack_in_range"	: attack_inRange(); break;
				case "attack_in_sight"	: attack_inSight(); break;
				case "attack_closest"	: attack_closest(); break;
				case "attack_weakest"	: attack_weakest(); break;
				case "move_responsive"	: moveResponsive(); break;
				case "supply_move"		: moveResponsive(true); break;
			}
		}
		
		//
		//
		//
		//
		//
		//
		
		/**
		 * Menyerang yang paling lemah
		 */
		private function attack_weakest()
		{
			var _targetPos:Point; var _weakest:int = 999;
			for (var i:int = 0; i < m_modelBattle.cUnits.length; i++) {
				var _currUnit:Unit = m_modelBattle.cUnits[i];
				if (_currUnit.db.category !=Config.focused.db.category && _currUnit.dHP<_weakest) {
					_weakest 	= _currUnit.dHP;
					_targetPos	= _currUnit.dPos;
				}
			}
			
			if (_targetPos) actTo(_targetPos);
			else moveTo(Config.focused.dPos);
		}
		
		/**
		 * Menyerang musuh2 yang terdekat
		 * @param	_data
		 */
		private function attack_closest(_data:Vector.<Point>=null)
		{
			var _tPos:Vector.<Point> = (_data)?_data:m_modelBattle.getPos_enemiesByTurn();
			
			Path.enableAllyPos 		= true;
			Path.enableAreaActive 	= false;
			Path.enableEnemyPos		= false;
			Path.enablePassableTiles = true;
			
			var _target:Point = Path.find_OptEndPos(false, m_modelBattle, Config.focused, _tPos);
			if (_target) actTo(_target);
			else moveTo(Config.focused.dPos);
		}
		
		/**
		 * Menyerang musuh yang berada dalam jarak pandang
		 */
		private function attack_inSight()
		{
			var _area:Vector.<int> 		= m_modelBattle.getMap_WalkAndTargetArea();
			var _enemyInArea:Vector.<Point>	= new Vector.<Point>();
			for (var r:int = 0; r < Config.HEIGHT; r++ ) {
			for (var c:int = 0; c < Config.WIDTH; c++ ) {
				if (_area[c + r * Config.WIDTH] == 0) {
					var _currPos:Point = new Point(c, r);
					for (var j:int=0; j < m_modelBattle.cUnits.length; j++) {
						var _currUnit:Unit = m_modelBattle.cUnits[j];
						if (_currUnit.db.category!=Config.focused.db.category && _currUnit.dPos.equals(_currPos)) {
							_enemyInArea.push(_currPos);
							break;
						}
					}	
				}				
			}}
			
			// cari terdekat
			if (_enemyInArea.length > 0) {
				var _closest:int = 999; var _targetPos:Point;
				for (var i:int = 0; i < _enemyInArea.length; i++) {
					Path.enableAllyPos 		= (Config.focused.db.isDirectAct)?false:true;
					Path.enableAreaActive 	= false;
					Path.enableEnemyPos		= false;
					Path.enablePassableTiles = (Config.focused.db.isDirectAct)?false:true;
					
					var _path:Vector.<Point> = Path.findPath(m_modelBattle, Config.focused, _enemyInArea[i]);
					var _range:int = (_path!=null)?_path.length:null;
					
					if (_range!=null && _range < _closest) {
						_closest 	= _range
						_targetPos	= _enemyInArea[i];	
					}
				}
				
				if (_targetPos) actTo(_targetPos);
				else moveTo(Config.focused.dPos);
			}
			else moveTo(Config.focused.dPos);
		}
		
		/**
		 * Menyerang musuh yang berada dalam range tertentu
		 */
		private function attack_inRange()
		{
			while (m_enemyInRange.length > 0) m_enemyInRange.pop();
			
			recursTiles(Config.focused.dPos.x, Config.focused.dPos.y, Config.focused.dAI_param+1);
			
			if (m_enemyInRange.length > 0) {
				
				Path.enableAllyPos 		= true;
				Path.enableAreaActive 	= false;
				Path.enableEnemyPos		= false;
				Path.enablePassableTiles = true;
				
				var _pos:Point = Path.find_OptEndPos(false, m_modelBattle, Config.focused, m_enemyInRange);
				if (_pos) actTo(_pos);
				else moveTo(Config.focused.dPos);
			}
			else moveTo(Config.focused.dPos);
		}
		
		private function attack_protective()
		{
			// cari unit kawan yang akan dilindungi. Cek mana yang dalam kondisi gawat
			var _needProtection:Vector.<Point> = new Vector.<Point>();
			for (var i:int = 0; i < m_modelBattle.cUnits.length; i++ ) {
				var _u:Unit = m_modelBattle.cUnits[i];
				if (_u != Config.focused && _u.db.category == Config.focused.db.category) {
					if (_u.dAI_param && Config.focused.dPos.equals(_u.dAI_param)) {
						var _alert:Boolean = (Action.getAlert(_u.dPos, 2, m_modelBattle) < 0)?true:false;
						if (_alert) _needProtection.push(_u.dPos);
					}
				}
			}
			
			// jka ada yang butuh bantuan, cari yang paling dekat
			
		}
		
		/**
		 * Bergerak ke suatu titik. Jika ada yang menghalangi maka sikat
		 */
		private function moveResponsive(_avoidEnemy:Boolean=false)
		{
			var _targetMove:Point = Config.focused.dAI_param;
			
			Path.enableAllyPos 		= true;
			Path.enableAreaActive	= false;
			Path.enableEnemyPos		= _avoidEnemy;
			Path.enablePassableTiles = true;
			var _path:Vector.<Point> = Path.findPath(m_modelBattle, Config.focused, _targetMove, true);
			
			if (_path && _path.length > 0) {
				for (var i:int = 0; i < _path.length; i++) {
					var _u:Unit = m_modelBattle.getUnit(_path[i].x, _path[i].y);
					if (_u && _u.db.category != Config.focused.db.category) {
						actTo(_path[i]);
						return 1;
						break;
					}
				}
				moveTo(_path[_path.length - 1]);
			} else moveTo(Config.focused.dPos);
		}
		
		
		//
		//
		//
		//
		//
		//
		// -------------------------------------
		private var m_enemyInRange:Vector.<Point> = new Vector.<Point>();
		private function recursTiles(_x:int, _y:int, _max:int){
			if  ( !((_x >= 0) && 
				(_x < Config.WIDTH)	&&	(_y >= 0) && (_y < Config.HEIGHT)) ||  
				( _max == 0 )) 
				return 1;			
			else {
				
				for (var i:int = 0; i < m_modelBattle.cUnits.length; i++) {
					if (m_modelBattle.cUnits[i].dPos.equals(new Point(_x, _y)) && 
						m_modelBattle.cUnits[i].db.category!=Config.focused.db.category) {
						m_enemyInRange.push(new Point(_x, _y));
						break;
					}
				}
				
				recursTiles(_x + 1, _y, _max - 1);
				recursTiles(_x - 1, _y, _max - 1);
				recursTiles(_x, _y + 1, _max - 1);
				recursTiles(_x, _y - 1, _max - 1);
			}
		}
		// -------------------------------------
		private function actTo(_endPos:Point)
		{
			// jika berada di dalam jangkauan -> serang di titik end pos;
			// kalau tidak -> mendekati titik end pos;
			
			var _lockPos:Vector.<Point> = m_modelBattle.getPos_target();
			// -- cek path
			Path.enableAllyPos 			= true;
			Path.enableAreaActive		= false;
			Path.enableEnemyPos			= false;
			Path.enablePassableTiles 	= true;
			var _path: Vector.<Point>	= Path.findPath(m_modelBattle, Config.focused,  _endPos, true);
			
			for (var i:int = 0; i < _lockPos.length; i++ ){
				if (_lockPos[i].equals(_endPos)) {
					
					var _attackType	: int 		= m_controlBattle.classifyAction();
			
					// pilih unit
					Config.clicked.setData(	m_modelBattle.getUnit(_endPos.x, _endPos.y), 
											m_modelBattle.getTile(_endPos.x, _endPos.y));
					
					// jika  direct attack unit, maka pindahkan posisi
					if(_attackType == 2)
					Config.focused.dPos 	= _path[_path.length - 2];
					
					// lakukan aksi
					switch(_attackType) {
						
						case 1: Action.heal(Config.focused, Config.clicked.unit); break;
						case 2: Action.attack(Config.focused, Config.clicked.unit, m_modelBattle);
								if (!Config.clicked.unit.db.isSupply) 
								Action.attack(Config.clicked.unit, Config.focused, m_modelBattle);
								break;
						case 3: Action.attack(Config.focused, Config.clicked.unit, m_modelBattle);
								break;
					}
					
					
					// ---------------------------------------------------
					// Simpan Data
					// ---------------------------------------------------
					type				= _attackType;
					targetPos			= _endPos;
					
					return 1;
					break;
				}
			}
			
			
			Path.enableAllyPos 		= true;
			Path.enableAreaActive	= false;
			Path.enableEnemyPos		= false;
			Path.enablePassableTiles = true;
			var _area:Vector.<int>	= m_modelBattle.getMap_WalkArea();
			var _pos:Point			= Path.find_OptStartPos(false, m_modelBattle, Config.focused, _endPos, _area);
			
			if (_pos) 	moveTo(_endPos);
			else 		moveTo(Config.focused.dPos);
		}
		
		private function moveTo(_endPos:Point)
		{
			// ngecek apakah berada dalam area jangkauan
			var _area:Vector.<int> 	= m_modelBattle.getMap_WalkArea();
			var _inArea:Boolean		= false;
			for (var r:int = 0; r < Config.HEIGHT; r++ ) {
			for (var c:int = 0; c < Config.WIDTH; c++ ) {
				if (_endPos.equals(new Point(c,r))) {
					var _index:int = c + r * Config.WIDTH;
					if (_area[_index] == 0) 
						_inArea = true;
					break;
				}		
			}}
			
			// jika di dalam area jangkauan
			var _movePos: Point = Config.focused.dPos;
			if (_inArea) {
				_movePos = _endPos;
			} 
			
			// jika di luar area jangkauan
			else {
				Path.enableAllyPos			= true;
				Path.enableAreaActive		= false;
				Path.enableEnemyPos			= true;
				Path.enablePassableTiles	= true;	
				
				_movePos = Path.find_OptStartPos(false,m_modelBattle,Config.focused,_endPos,_area);
			}
			
			// ---------------------------------------------------
			// set tile tujuan
			// pindah posisi
			// ---------------------------------------------------
			if (!_movePos)
				_movePos = Config.focused.dPos;
			Config.clicked.setData(null, m_modelBattle.getTile(_movePos.x, _movePos.y));
			Config.focused.dPos = _movePos;
			
			// ---------------------------------------------------
			// Simpan Data
			// ---------------------------------------------------
			type				= 0;
			targetPos			= _movePos;
			
		}
		
	}

}