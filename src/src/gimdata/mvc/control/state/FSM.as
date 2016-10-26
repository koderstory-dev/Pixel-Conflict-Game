package gimdata.mvc.control.state {
	import gimdata.core.config.Config;
	import flash.geom.Point;
	import gimdata.core.config.Music;
	import gimdata.core.constant.State;
	import gimdata.objects.tile.Tile;
	import gimdata.objects.unit.Unit;
	import raj.soundlite.MSFX;
	/**
	 * ...
	 * @author Aldy Ahsandin
	 */
	public class FSM 
	{
		private var m_state		: String	= "Waiting";
		public var isProcessing	: Boolean	= false;
		
		/**
		 * restart data setiap pergantian m_state
		 * @param	_state
		 * @param	_focusedUnit
		 * @param	_isProcessing
		 */
		private function restartData(_state	:String, _focusedUnit	:Unit) 
		{
			if (_state == State.WAITING && !Music.GRUP_GAME.getSound(Music.sfx_deselect).isPlaying)
				Music.GRUP_GAME.playFx(Music.sfx_deselect, 0.3);
			
			m_state 		= _state;
			Config.focused 	= _focusedUnit;
			isProcessing	= false;
		}
		
		private function wait_to() {
			if (Config.clicked.unit != null) {
				if (Config.turn == Config.clicked.unit.db.category && Config.clicked.unit.getActive()) {
					restartData(State.SHOW_ALLY, Config.clicked.unit);								// lock ally
					
					// voice
					Music.GRUP_GAME.playFx(Music.sfx_cteck2, 0.3);
					if(Config.turn == "ally"){
					switch(Config.focused.dType) {
						case 1:
						case 2:
						case 3: var _random:int = Math.random() * 10;
								if (_random >= 0 && _random < 3) {
									Music.GRUP_GAME.playFx(Music.sfx_yes1, 0.1);
								} 
								else
								if (_random >= 3 && _random < 7) {
									Music.GRUP_GAME.playFx(Music.sfx_yes2, 0.1);
								} 
								else
								if (_random >= 7 && _random <= 10) {
									Music.GRUP_GAME.playFx(Music.sfx_yes3, 0.1);
								} 
								break;
						case 4:
						case 5:
						case 6:
						case 8:var _random:int = Math.random() * 10;
								if (_random >= 0 && _random < 3) {
									Music.GRUP_GAME.playFx(Music.sfx_engine1, 0.3);
								} 
								else
								if (_random >= 3 && _random < 7) {
									Music.GRUP_GAME.playFx(Music.sfx_engine2, 0.3);
								} 
								else
								if (_random >= 7 && _random <= 10) {
									Music.GRUP_GAME.playFx(Music.sfx_engine3, 0.3);
								} 
								
								break;
						
					}}
					
				}
				else {
					Music.GRUP_GAME.playFx(Music.sfx_cteck2, 0.3);
					restartData(State.SHOW_ENEMY, Config.clicked.unit);								// klik enemy
				}
			}else {
				if (m_state == State.WAITING) {
					Music.GRUP_GAME.playFx(Music.sfx_cteck2, 0.3);
					restartData(State.SHOW_INFO, null);
				}
				else
					restartData(State.WAITING, null);
			}
		}
		
		private function showAlly_to() {
			if (Config.clicked.unit) {																// jika ada unit
				if (Config.clicked.unit == Config.focused) 											// unlocked
					restartData(State.WAITING, null);
				else 
				if (Config.clicked.tile.isMove && Config.clicked.unit.db.category == Config.turn)	// jangan serang ally
					restartData(State.WAITING, null);
				else
				if (Config.clicked.tile.isTarget) {
					Music.GRUP_GAME.playFx(Music.sfx_cteck2, 0.3);
					// heal ally || serang
					restartData(State.CONFIRMATION, Config.focused);
				}
				else
					restartData(State.WAITING, null);												// unlocked
			} else {
				
				if (Config.turn == "ally" && Config.clicked.tile.isMove) {							// konfirmasi sebelum bergerak
					Music.GRUP_GAME.playFx(Music.sfx_cteck2, 0.3);
					restartData(State.CONFIRMATION, Config.focused);
				}
				else
				if (Config.clicked.tile.isMove)														// pindah posisi
					restartData(State.MOVE, Config.focused);
				else
				restartData(State.WAITING, null);
			}
		}
		
		private function confirmation_to() {
			
			if (Config.confirmation == 1) {
				Music.GRUP_LEVEL.playFx(Music.sfx_accept, 0.3);
				// ---
				if (Config.clicked.unit) 
				// jika yang diklik adalah posisi unit
					restartData(State.ACTION, Config.focused);								
				else
					restartData(State.MOVE, Config.focused);								// jalan
					
				// --
				Config.confirmation = 2;	// kembalikan confirmasi ke mode awal
			}
			
			else 
			if (Config.confirmation == 0) {
				Music.GRUP_GAME.playFx(Music.sfx_cteck, 0.35);
				
				// --
				Config.clicked.setData(Config.focused, null);  // <- dunno this code works!. Altough I only add null
				restartData(State.SHOW_ALLY, Config.focused);
				
				// --
				Config.confirmation = 2;	// kembalikan confirmasi ke mode awal
			}
						
		}
		
		/**
		 * ganti m_state
		 * @param	_isForceToWait	parameter ini digunakan saat berganti giliran. m_state dipaksa ke dalam mode tunggu
		 */
		public function changeState(_isForceToWait:Boolean=false){
			
			//{ FSM
			// m_state:  (waiting)
				//klik ally -> (showAllyRange)
				//klik enemy  -> (showEnemyRange)
				//klik terrain-> (showInfo)
			
			// m_state: (showEnemyRange)
				//klik anyting -> waiting 
				
			// m_state: (showAllyRange)
				//klik focused ally 	-> (waiting)
				//klik enemy in range 	-> (attack)
				//klik enemy out range	-> (waiting)
				//klik terrain in range	-> (move)
				//klik terrain out range-> (waiting)
			
			// m_state: move
				//set waiting
				
			// m_state: attack
				//set waiting
				
			//m_state: (showInfo)
				//klik close button		-> (waiting)
			//}
			
			if (_isForceToWait)
				restartData(State.WAITING, null);
			else {
				switch(m_state) {
					case State.WAITING		: wait_to(); 						break;
					case State.SHOW_ALLY	: showAlly_to(); 					break;
					case State.SHOW_ENEMY	: restartData(State.WAITING, null);	break;
					case State.MOVE			: restartData(State.WAITING, null);	break;
					case State.ACTION		: restartData(State.WAITING, null);	break;
					case State.SHOW_INFO	: restartData(State.WAITING, null);	break;
					case State.CONFIRMATION	: confirmation_to();				break;
				}	
			}
			
		}
		
		public function get state():String {
			return m_state;
		}
		
		
	}

}