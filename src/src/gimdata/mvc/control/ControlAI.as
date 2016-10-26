package gimdata.mvc.control 
{
	import adobe.utils.CustomActions;
	import al.core.Ast;
	import al.misc.Show;
	import com.greensock.TweenMax;
	import flash.geom.Point;
	import gimdata.core.config.Config;
	import gimdata.core.config.Music;
	import gimdata.mvc.control.ai.Layering;
	import gimdata.mvc.control.ai.SimThinking;
	import gimdata.mvc.model.ModelBattle;
	import gimdata.objects.building.Owner;
	import gimdata.objects.building.OwnerClone;
	import gimdata.objects.gui.CursorSelected;
	import gimdata.objects.gui.Sign;
	import gimdata.objects.tile.Tile2;
	import gimdata.objects.unit.Unit;
	import gimdata.objects.unit.UnitClone;
	import org.as3collections.ISortedMap;
	import org.osflash.signals.Signal;
	import raj.soundlite.MSFX;
	/**
	 * ...
	 * @author AldyAhsandin
	 */
	public class ControlAI 
	{
		private	var m_controlBattle	: ControlBattle;
		private	var m_modelBattle	: ModelBattle;
		
		// karena AI menggerakkan enemy maka ally disini adalah enemy
		private var m_allies		: Vector.<Point>		= new Vector.<Point>();
		private var m_queue			: Vector.<Point>		= new Vector.<Point>();
		
		private var m_clones		: Vector.<UnitClone>	= new Vector.<UnitClone>();
		private var m_ownerClones	: Vector.<OwnerClone>	= new Vector.<OwnerClone>();
		private var m_nextActions	: Vector.<Array>		= new Vector.<Array>() ;
		
		// signal
		public  var signal_onPlayAI	: Signal				= new Signal();
		public 	var signal_block	: Signal				= new Signal(Boolean);
		public 	var signal_turn		: Signal				= new Signal();
		public	var signal_report	: Signal				= new Signal(String);
		
		public function ControlAI(_mBattle:ModelBattle, _cBattle:ControlBattle) 
		{
			m_modelBattle	= _mBattle;
			m_controlBattle	= _cBattle;
			
		}
		
		
		
		
		
		// ============================================================================== //
		//                              Public Function
		// cara kerja AI Controller
		// Proses Thinking: startThinking -> focusUnit -> AiThink -> unFocus
		// Proses Playing : startPlaying  -> focusUnit -> AiPlay  -> unFocus
		// ============================================================================== //
		
		var m_condition:int = 0; // variabel untuk mengecek nilai kembalian m_control.check_onBuilding();
		
		/**
		 * fungsi untuk memulai menghitung posisi gerak AI
		 */
		public function startThinking(){
			
			// -----------------
			// restart data
			// -----------------
			Music.GRUP_GAME.getSound(Music.bg_player).stop();
			Music.GRUP_GAME.mute = true;

			// random
			m_queue.length = 0;
			var _queue:Vector.<Point> =  m_modelBattle.getPos_alliesByTurn();
			while (_queue.length > 0) {
				var _randIndex:int = Math.random() * _queue.length;
				m_queue.push(_queue[_randIndex]);
				_queue.splice(_randIndex, 1);
			}
			
			m_clones.length 		= 0;
			m_nextActions.length 	= 0;
			m_allies.length 		= 0;
			
			for (var i:int = 0; i < m_queue.length;i++)
				m_allies.push(m_queue[i]);
			
			// -----------------
			// simpan semua unit
			// -----------------
			
			// Membuat clone units [back up]
			for (var i:int = 0; i < m_modelBattle.cUnits.length; i++ ) {
				
				var _oriUnit	:Unit 		= m_modelBattle.cUnits[i];
				var _cloneU		:UnitClone 	= _oriUnit.cloneData();
				
				m_clones.push( _cloneU );
			}
			
			// ---------------------------------------------------------------------------
			// Membuat clone owner
			m_ownerClones.length = 0;
			for (var i:int = 0; i < m_modelBattle.cOwners.length; i++ ) {
				
				var _ownerUnit	:Owner		= m_modelBattle.cOwners[i];
				var _cloneO		:OwnerClone	= _ownerUnit.cloneData();
				
				m_ownerClones.push(_cloneO);
			}
			
			// -----------------
			// focus to unit
			// -----------------
			m_controlBattle.fastChange_owner();
			focusToUnit(true)
		}
		
		/**
		 * Fungsi untuk memulai menjalankan AI
		 */
		public function startPlaying(){
			
			// ------------------------------------------------------
			// reset data unit sesuai dengan clone
			// ------------------------------------------------------
			if (Config.isSounded) {
				Music.GRUP_GAME.mute = false;
				if (!Music.GRUP_GAME.getSound(Music.bg_enemy).isPlaying)
					Music.GRUP_GAME.playLoop(Music.bg_enemy, 0.3);
					
			}
			
			// reset unit
			var _units:Vector.<Unit> = m_modelBattle.cUnits;
			
			for (var i:int = 0; i < _units.length; i++ ) {
				var _unit: Unit	= _units[i];
					_unit.dPos	= m_clones[i].dPos;
					_unit.setFast_dHP(m_clones[i].dHP);
				
				(m_clones[i].isFaceRight)? _unit.showIdle_Right(): _unit.showIdle_Left();
			}
			
			// reset owner
			for (var i:int = 0; i < m_modelBattle.cOwners.length; i++ ) {
				var _ownerUnit	:Owner		= m_modelBattle.cOwners[i];
					_ownerUnit.reset_fast(	m_ownerClones[i].dCategory, 
											m_ownerClones[i].dLife);
			}
			
			
			if (ending>0) {
				show_ending();
				return 1;
			}
			
			// ------------------------------------------------------
			// focus ally x untuk dianimasikan sesuai aksi yang dipilih
			// ------------------------------------------------------
			for (var i:int = 0; i < m_queue.length;i++)
				m_allies.push(m_queue[i]);
			
			// --- heal or conquer
			var _tileCondition:int 	= m_controlBattle.check_onTile;
			var _delay:int			= 1;
			
			if (_tileCondition >= 1 && _tileCondition <= 4) {
				m_controlBattle.change_owner();
				_delay = 20;
			}
			
			// -- action
			TweenMax.delayedCall(0.1*_delay, focusToUnit,[false]);
			
		}
		
		
		
		// ============================================================================== //
		//                                  logic 
		// ============================================================================== //
		
		private function aiThink() 
		{
			
			m_modelBattle.updateIMap();
			m_modelBattle.updateCoverByUnit(Config.focused.db);
			
			var _simulation	: SimThinking 	= new SimThinking(	m_modelBattle, m_controlBattle);
				_simulation.play();
				
			var _action		: Array			= [_simulation.type, _simulation.targetPos]
			m_nextActions.push(_action);
			
			// ---------------------------------------						
			// close
			// ---------------------------------------	
			TweenMax.delayedCall(0.1,	m_controlBattle.hideArea);
			TweenMax.delayedCall(0.1, 	m_modelBattle.fsm.changeState);
			TweenMax.delayedCall(0.1, 	unFocusToUnit, [true]);
		}
		
		private function aiPlay()
		{
			
			var _typeAction	: int 	= m_nextActions[0][0];
			var _pos		: Point	= m_nextActions[0][1];
			
			// ------------------------------------------------------
			// mainkan animasi
			// ------------------------------------------------------
			
			switch(_typeAction) {
				
				// -- animasi gerak
				case 0	: 	
							// 1. set tile tujuan
							// 2. animasikan gerak
							
							// jika posisi berikutnya berbeda dengan sebelumnya
							if (!_pos.equals(Config.focused.dPos)) {
								
								// -- ui
								(m_modelBattle.cSigns[0] as Sign).show(_pos);
								(m_modelBattle.cSelected[1] as CursorSelected).show(_pos);
								
								Config.clicked.setData(null, m_modelBattle.getTile(_pos.x, _pos.y));
								m_controlBattle.move(unFocusToUnit, [false]); 
								
							} 
							
							// jika posisi sama dengan sebelumnya
							else {
								TweenMax.delayedCall(0.5, Config.focused.setActive, [false]);
								TweenMax.delayedCall(0.5, m_controlBattle.hideArea);
								TweenMax.delayedCall(0.5, m_modelBattle.fsm.changeState, [true]);
								TweenMax.delayedCall(0.5, unFocusToUnit, [false]);	
							}
							
							break;
				case 1	:	
				
				// -- animasi serang mode direct attack			
				case 2	: 	
				case 3	:	// -- ui
							(m_modelBattle.cSigns[0] as Sign).hide();
				
							var _unit	: Unit 	= m_modelBattle.getUnit(_pos.x, _pos.y);
							var _tile	: Tile2	= m_modelBattle.getTile(_pos.x, _pos.y);
						
							// -- set clicked
							Config.clicked.setData(_unit, _tile);
							
							if(_unit)
								m_controlBattle.act();
							else {
								TweenMax.delayedCall(0.5, Config.focused.setActive, [false]);
								TweenMax.delayedCall(0.5, m_controlBattle.hideArea);
								TweenMax.delayedCall(0.5, m_modelBattle.fsm.changeState, [true]);
								TweenMax.delayedCall(0.5, unFocusToUnit, [false]);	
							}
							break;	
			}
			
		}
		
		
		
		
		// ============================================================================== //
		//                                  Seleksi Objek 
		// ============================================================================== //
		
		private function focusToUnit(_isThinking:Boolean) {
			
			// block screen
			signal_block.dispatch(true);
			
			// -------------------------------------------------------
			// ambil posisi urutan saat ini
			// set unit dan tile
			// set state
			// -------------------------------------------------------
			var _pos	: Point	= m_allies[0];
			var _unit	: Unit	= m_modelBattle.getUnit(_pos.x, _pos.y);
			var _tile	: Tile2	= m_modelBattle.getTile(_pos.x, _pos.y);
			
			Config.clicked.setData(_unit, _tile);
			m_modelBattle.fsm.changeState();
			
			//--------------------------------------------------------
			// Show Area kemudian berpikir
			//--------------------------------------------------------
			TweenMax.delayedCall(0.1, m_controlBattle.showArea, [	Config.clicked.unit.dPos.x,
																	Config.clicked.unit.dPos.y,
																	Config.clicked.unit.db.move]);
			
			(_isThinking)?TweenMax.delayedCall(0.2, aiThink):TweenMax.delayedCall(0.5, aiPlay);
		}
		
		public function unFocusToUnit(_isThinking:Boolean){
			
			m_allies.shift(); // ganti giliran
			if (_isThinking) {
				(m_allies.length > 0)? TweenMax.delayedCall(0.1, focusToUnit, [true]): signal_onPlayAI.dispatch();
			} 
			else {
				
				var _resultEnding:int 	= ending;
				var _checkTile:int 		= m_controlBattle.check_onTile; 
				if (m_allies.length > 0) {
					
					// cek ending
					if ( _resultEnding == 2 || _resultEnding == 3 ) {
						show_ending();
						return 1;
					}
					
					m_nextActions.shift();
					signal_block.dispatch(true);
					TweenMax.delayedCall(0.15 * _delay, focusToUnit, [false])
				}
				else {
					
					// cek ending
					if (_resultEnding > 0) {
						show_ending();
						return 1;
					}
					
					// -- heal or conquer
					var _tileCondition:int 	= m_controlBattle.check_onTile;
					var _delay:int			= 1;
					
					if (_tileCondition >= 1 && _tileCondition <= 4) {
						m_controlBattle.change_owner();
						_delay = 20;
					}
					
					// --action
					TweenMax.delayedCall(0.1 * _delay, m_modelBattle.setAllUnits_active);
					TweenMax.delayedCall(0.1 * _delay, function() {
						Config.turn = (Config.turn == "ally")? "enemy":"ally";
						show_newTurn();						
					});
					
				}
			}
		}
		
		
		// ============================================================================== //
		//                                  Ending 
		// ============================================================================== //
		
		/**
		 * 1:win Pos, 2: target dead, 3: eliminate all, 4: basecamp
		 * @param	_inEndTurn	
		 * @return
		 */
		private function get ending():int
		{
			// 1. Win Pos
			if (m_controlBattle.check_onWinPos > 0) 
				return 1;
			
			// 2. target dead
			if (m_controlBattle.check_VIP_dead > 0)
				return 2;
			
			// 3. target all
			if (m_controlBattle.check_deadPlayer > 0)
				return 3;
			
			// 4. jika basecamp sudah dikuasai
			if (m_controlBattle.check_onTile >= 5)
				return 4;
				
			return 0;
		}
		
		private function show_ending():void 
		{
			switch(ending) {
				case 1:	m_controlBattle.ending_winPos(); 			break;
				case 2: m_controlBattle.ending_vipDead(); 			break;
				case 3: m_controlBattle.ending_deadPlayer(); 		break;
				case 4: m_controlBattle.ending_capturedBasecamp();	break;
			}
			
		}
		
		private function show_newTurn()
		{
			var _numAlly:int 	= m_modelBattle.getUnits("ally").length;
			var _numEnemy:int	= m_modelBattle.getUnits("enemy").length;
			
			if (_numAlly>0 && _numEnemy>0) {
				TweenMax.delayedCall(1, signal_turn.dispatch);
				TweenMax.delayedCall(3.0, signal_block.dispatch, [false]);
				
				// -- music fade away
				Music.GRUP_GAME.fadeTo(Music.bg_enemy,0);
			}			
		}
		
		
	}

}