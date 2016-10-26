package gimdata.mvc.control 
{
	import adobe.utils.CustomActions;
	import al.display.SpriteAL;
	import al.misc.Show;
	import al.objects.CameraAL;
	import com.greensock.TweenMax;
	import flash.geom.Point;
	import gimdata.core.config.Config;
	import gimdata.core.config.Music;
	import gimdata.core.config.Record;
	import gimdata.core.constant.State;
	import gimdata.mvc.control.action.Action;
	import gimdata.mvc.control.action.Moving;
	import gimdata.mvc.control.action.Path;
	import gimdata.mvc.model.ModelBattle;
	import gimdata.mvc.view.ViewBattle;
	import gimdata.objects.achievements.MyAchievements;
	import gimdata.objects.building.Owner;
	import gimdata.objects.gui.CursorSelected;
	import gimdata.objects.gui.Sign;
	import gimdata.objects.tutorial.ChatBox;
	import gimdata.objects.unit.Unit;
	import org.osflash.signals.Signal;
	import raj.soundlite.MSFX;
	/**
	 * ...
	 * @author Aldy Ahsadin
	 */
	public class ControlBattle extends SpriteAL
	{
		
		// -- model view --
		public	var modelBattle			: ModelBattle;
		public	var viewBattle			: ViewBattle;
		
		
		// -- event --
		public	var signal_infoUnit		: Signal;
		public	var signal_infoTile		: Signal;
		public	var signal_cinema		: Signal;
		public	var signal_block		: Signal;
		public 	var signal_unFocusUnit	: Signal;
		public	var signal_confirmation	: Signal;
		public	var signal_report		: Signal;
		public	var signal_endBattle	: Signal;
		public	var signal_chat			: Signal;
		
		
		public 	var EVENT_CERTAIN_POS	: Signal;
		
		
		public function ControlBattle(_model:ModelBattle, _view:ViewBattle) 
		{
			
			// -- model view --
			modelBattle			= _model;
			viewBattle			= _view;
			
			// -- event --
			signal_infoUnit		= new Signal(Boolean);
			signal_infoTile		= new Signal(Boolean);
			signal_confirmation	= new Signal();
			
			signal_cinema		= new Signal(Array, Array);
			signal_block		= new Signal(Boolean);
			signal_unFocusUnit	= new Signal();
			signal_report		= new Signal(String);
			signal_endBattle	= new Signal();
			signal_chat			= new Signal(int);
			
			TweenMax.delayedCall(0.5, activate);
		}
		
		/**
		 * Update FSM
		 * @param	_dt
		 */
		override public function update(_dt:Number = -1):void {
			//if (Config.turn == "ally") {
				update_waiting();
				update_showAlly();
				update_showEnemy();
				update_showInfo();
				update_move();
				update_action();
				update_confirmation();
				
			//}
		}
		
		
		//--------------------------------------------------------------------------------
		//  fungsi untuk menjalankan update
		//--------------------------------------------------------------------------------
		
		/**
		 * update FSM saat FSM == waiting
		 */
		private function update_waiting()	:void {
			if (modelBattle.fsm.state == State.WAITING && Config.focused == null && !modelBattle.fsm.isProcessing) {
				
				modelBattle.fsm.isProcessing = true;
				hideArea();
				
				// -- ui
				signal_infoUnit.dispatch(false);
				signal_infoTile.dispatch(false);
				
				
				(modelBattle.cSigns[0] as Sign).hide();
				(modelBattle.cSelected[0] as CursorSelected).hide();
				(modelBattle.cSelected[1] as CursorSelected).hide();
				
				signal_chat.dispatch(1);
			}
		}
		
		/**
		 * update FSM saat FSM == menampilkan area unit ally
		 */
		private function update_showAlly()	:void {
			if (modelBattle.fsm.state == State.SHOW_ALLY  && Config.focused && !modelBattle.fsm.isProcessing) {
				
				modelBattle.fsm.isProcessing = true;
				//m_ModelBattle.cursor.show(Config.focused.dPos);
				showArea(	Config.clicked.unit.dPos.x,
							Config.clicked.unit.dPos.y,
							Config.clicked.unit.db.move);
				// ui
				signal_infoUnit.dispatch(true);
				
				(modelBattle.cSigns[0] as Sign).show(Config.focused.dPos);
				(modelBattle.cSelected[0] as CursorSelected).show(Config.focused.dPos);
					
				signal_chat.dispatch(2);
			}
		}
		
		/**
		 * * update FSM saat FSM == menampilkan area enemy 
		 */
		private function update_showEnemy()	:void {
			if (modelBattle.fsm.state == State.SHOW_ENEMY && !modelBattle.fsm.isProcessing) {
				modelBattle.fsm.isProcessing = true;
				showArea( 	Config.clicked.unit.dPos.x,
							Config.clicked.unit.dPos.y,
							Config.clicked.unit.db.move);
				signal_infoUnit.dispatch(true);
				(modelBattle.cSigns[0] as Sign).show(Config.clicked.unit.dPos);
			}
		}
		
		/**
		 * 
		 */
		private function update_showInfo():void 
		{
			if (modelBattle.fsm.state == State.SHOW_INFO && Config.focused == null && !modelBattle.fsm.isProcessing) {
				
				modelBattle.fsm.isProcessing = true;
				signal_infoTile.dispatch(true);
				
				Config.clicked.tile.showMove();
				(modelBattle.cSigns[0] as Sign).show(Config.clicked.tile.dPos);
			}
		}
		
		/**
		 * * update FSM saat FSM == move 
		 */
		private function update_move()		:void {
			if (modelBattle.fsm.state == State.MOVE && !modelBattle.fsm.isProcessing) {
				
				modelBattle.fsm.isProcessing = true;
				signal_block.dispatch(true);
				
				//record data
				if(Config.turn == "enemy") record(true);
				
				// bergerak
				move();
				
				// ui
				(modelBattle.cSigns[0] as Sign).show(Config.clicked.tile.dPos);
				(modelBattle.cSelected[1] as CursorSelected).show(Config.clicked.tile.dPos, 5);
			}	
		}
		
		/**
		 * update FSM saat FSM == action 
		 */
		private function update_action()	:void {
			if (modelBattle.fsm.state == State.ACTION && !modelBattle.fsm.isProcessing) {
				
				modelBattle.fsm.isProcessing = true;
				signal_block.dispatch(true);
				
				// update influence dan cover
				modelBattle.updateIMap();
				modelBattle.updateCoverByUnit(Config.clicked.unit.db);
				
				// record data
				//if(Config.turn == "enemy") record(false);
				act();
				
				// --ui
				(modelBattle.cSigns[0] as Sign).show(Config.clicked.tile.dPos);
				(modelBattle.cSigns[0] as Sign).hide();
				
			}
		}
		
		
		private function update_confirmation() {
			if (modelBattle.fsm.state == State.CONFIRMATION && !modelBattle.fsm.isProcessing) {
				
				modelBattle.fsm.isProcessing = true;
				if(Config.focused.db.isDirectAct) showTracks();
				else if (!Config.focused.db.isDirectAct && !Config.clicked.tile.isTarget) showTracks();
				
				// ui
				signal_confirmation.dispatch();
				(modelBattle.cSigns[0] as Sign).show(Config.clicked.tile.dPos);
				(modelBattle.cSelected[1] as CursorSelected).show(Config.clicked.tile.dPos, 5);
				
				signal_chat.dispatch(3);
			}
		}
		
		
		//-------------------------------------------------
		// ACTION
		//-------------------------------------------------
		
		/**
		 * Fungsi ini untuk melakukan klasifikasi aksi
		 * @return	1: (Supply) heal | 2: (Direct Attack) attack+counterAttack | 3: (indirect attack) attack
		 */
		public function classifyAction():int {
			
			
			// lakukan aksi
			if (Config.focused.db.isDirectAct)
				return (Config.focused.db.isSupply)? 1:2
			else 
				return 3
			
		}
		
		/**
		 * Beraksi
		 * @param	_handler	jalankan handler stelah fungsi ini dijalankan
		 */
		public function act():void 
		{
			//klasifikasi
			var _attackType	: int 		= classifyAction();
			var _delay		: Number	= 0;
			var _pos		: Point 	= new Point(Config.clicked.tile.dPos.x * 60, Config.clicked.tile.dPos.y * 60);
			
			switch(_attackType)
			{
				case 	1: 	// -- ui
							(modelBattle.cSigns[2] as Sign).show(Config.clicked.unit.dPos);
							
							// -- action
							_delay = Moving.move(modelBattle, 1);
							TweenMax.delayedCall(_delay, simulateAction,[1]);
							break;
							
							
				case 	2: 	// -- ui
							(modelBattle.cSigns[1] as Sign).show(Config.clicked.unit.dPos);
							
							// -- action
							_delay = Moving.move(modelBattle, 1);	
							TweenMax.delayedCall(_delay, simulateAction,[2])
							break;
							
				case 	3:	// -- ui
							(modelBattle.cSigns[1] as Sign).show(Config.clicked.unit.dPos);
							
							// -- action
							_delay = 1;
							TweenMax.delayedCall(_delay, simulateAction,[3])
							break;
			}
			
			// --ui
			TweenMax.delayedCall(_delay, (modelBattle.cSigns[1] as Sign).hide);
			TweenMax.delayedCall(_delay, (modelBattle.cSigns[2] as Sign).hide);
			
			
		}
		
		public function endAction()
		{
			// achievements 1: jika ada yang menyerang
			if(Config.usingOnlineData) MyAchievements.show_firstBlood();
			
			// update info hp
			switch(m_action) {
				case 1	: 	Config.clicked.unit.dHP	= m_HPDef[2];
							break
				case 2	: 	Config.focused.dHP		= m_HPAtk[2];
							Config.clicked.unit.dHP	= m_HPDef[2];
							break;
				case 3	: 	Config.clicked.unit.dHP	= m_HPDef[2];
							break;
			}
			
			// cek jika ada kondisi mati
			if (Config.turn == "ally") {
				
				if (check_VIP_dead > 0) {
					
					// jika sudah selesai aksi, maka ganti state
					Config.focused.setActive(false);
					hideArea();
					hideTracks();
					modelBattle.fsm.changeState(true);
					signal_block.dispatch(false);
					
					ending_vipDead();
					return 1;
				}
				
				else 
				if (check_deadPlayer > 0) {
					
					Config.focused.setActive(false);
					hideArea();
					hideTracks();
					modelBattle.fsm.changeState(true);
					signal_block.dispatch(false);
					
					ending_deadPlayer();
					return 1;
				}
			}
			
			// jika sudah selesai aksi, maka ganti state
			TweenMax.delayedCall(2.0, Config.focused.setActive, [false]);
			TweenMax.delayedCall(2.0, hideArea);
			TweenMax.delayedCall(2.0, hideTracks);
			TweenMax.delayedCall(2.0, modelBattle.fsm.changeState, [true]);
			TweenMax.delayedCall(2.0, signal_block.dispatch, [false]);
			
			// jika sekarang yang bergerak adalah AI
			if(Config.turn == "enemy")	TweenMax.delayedCall(2.0,	signal_unFocusUnit.dispatch); // KomenBuatIsiData
			
			signal_chat.dispatch(9);
			
			// =================
			// MUSIC
			// =================
			
			if (Music.GRUP_GAME.getSound(Music.sfx_battle).isPlaying) Music.GRUP_GAME.getSound(Music.sfx_battle).fadeTo(0);
			if (Config.turn == "enemy") Music.GRUP_GAME.playLoop(Music.bg_enemy, 0.3);
			//Music.GRUP_GAME.playLoop(((Config.turn == "ally")?Music.bg_player:Music.bg_enemy), 0.3);
		}
		
		private	var m_HPAtk:Array = new Array();
		private	var m_HPDef:Array = new Array();
		private var m_action:int;
		/**
		 *  (0)current HP  (1)currentPercentage HP (2)nextHP  (3)next Percentage HP for simulation)
		 * @param	_typeAction
		 * @param	_delay
		 */
		private function simulateAction(_typeAction:int):void 
		{
			
			m_HPAtk.length	= 0;
			m_HPDef.length	= 0;
			
			//--------------------------------------------------------------------------------
			// Proses Mengisi Data HP
			//--------------------------------------------------------------------------------
			
			// -- (1) mencatat data hp lama
			m_HPAtk.push(Config.focused.dHP);
			m_HPDef.push(Config.clicked.unit.dHP);
			
			// -- (2) cari persentage hp lama
			m_HPAtk.push(int((Config.focused.dHP / Config.focused.db.hpFull) * 100));
			m_HPDef.push(int((Config.clicked.unit.dHP / Config.clicked.unit.db.hpFull) * 100));
			
			// -- (2.1 cinematic)
			switch(_typeAction) {
				case 1	: 	Action.heal(Config.focused, Config.clicked.unit);
							TweenMax.delayedCall(0, endAction);
							break;
				case 2	: 	Action.attack(Config.focused, Config.clicked.unit, modelBattle);
							if (!Config.clicked.unit.db.isSupply) 
							Action.attack(Config.clicked.unit, Config.focused, modelBattle);
							// simulate
							if (Config.isCinematic) {
								TweenMax.delayedCall(0, showCinema, [true]);
							} else {
								TweenMax.delayedCall(1, endAction);
							}
							break;
				case 3	: 	Action.attack(Config.focused, Config.clicked.unit, modelBattle);
							// simulate
							if (Config.isCinematic) {
								TweenMax.delayedCall(0, showCinema, [false]);
							} else {
								TweenMax.delayedCall(1, endAction);
							}
							
							break;
			}
			m_action = _typeAction;
			
			// -- (3) catat hp terbaru
			m_HPAtk.push(Config.focused.dHP);
			m_HPDef.push(Config.clicked.unit.dHP);
			
			// -- (4) cari persentase hp terbaru
			var _percentage1:int = int((Config.focused.dHP / Config.focused.db.hpFull) * 100);
			var _percentage2:int = int((Config.clicked.unit.dHP / Config.clicked.unit.db.hpFull) * 100);
			
			m_HPAtk.push((_percentage1<=0)?0:_percentage1);
			m_HPDef.push((_percentage2<=0)?0:_percentage2);
			
			// ------------------
			// kembalikan HP ke data lama
			//trace(m_dataHP1, m_dataHP2);
			Config.focused.setFast_dHP((m_HPAtk[1] <= 0)?0:m_HPAtk[0]);
			Config.clicked.unit.setFast_dHP((m_HPDef[1] <= 0)?0:m_HPDef[0]);
			
			
			
		}
		
		
		/**
		 * Bergerak
		 * @param	_handler	jalankan handler stelah fungsi ini dijalankan
		 */
		public function move(_handler:Function = null, _params:Array=null):void 
		{
			// zoooom in
			//var _pos:Point = new Point(Config.clicked.tile.dPos.x * 60, Config.clicked.tile.dPos.y * 60);
			
			TweenMax.delayedCall(0.5, function() {
				/* move */
				var _delay:Number 	= Moving.move(modelBattle);
				
				/* tutup area dan set state */
				//TweenMax.delayedCall(_delay, 		(modelBattle.cObjects[0] as Sign).hide);
				TweenMax.delayedCall(_delay + 0.5, Config.focused.setActive, [false]);
				TweenMax.delayedCall(_delay + 0.5, hideArea);
				TweenMax.delayedCall(_delay + 0.5, hideTracks);
				TweenMax.delayedCall(_delay + 0.5, modelBattle.fsm.changeState);
				TweenMax.delayedCall(_delay + 0.5, signal_block.dispatch, [false]);
				if(_handler)
				TweenMax.delayedCall(_delay + 0.5, _handler, _params);
				TweenMax.delayedCall(_delay + 0.5, signal_chat.dispatch, [8]);
			})
			
			
		}
		
		
		
		// ----------------------------------------------------------------
		//				CHANGE OWNER
		// -----------------------------------------------------------------
		
		/**
		 * Change owner jika hasil check tile 1 dan 2
		 */ 
		public function change_owner(){
			
			for (var i:int = 0; i<modelBattle.cUnits.length; i++ ) {
			for (var j:int = 0; j<modelBattle.cOwners.length; j++ ) {
				
				var _curUnit:Unit	= modelBattle.cUnits[i];
				var _curTown:Owner	= modelBattle.cOwners[j];
				
				if (_curUnit.dPos.equals(_curTown.dPos) && 
					_curUnit.db.category == _curTown.dCategory &&
					_curTown.dTypeBuilding<=2) {
					switch(_curTown.dTypeBuilding) {
						case 1: _curUnit.dHP += 6; break;
						case 2: _curUnit.dHP += 3; break;
					}
				}
				
				else 
				if (_curUnit.dPos.equals(_curTown.dPos) && 
					_curUnit.db.category != _curTown.dCategory &&
					_curTown.dTypeBuilding<=2) 
					_curTown.setOwner(_curUnit.db.category, _curUnit )
				
				
				else 
				if(_curUnit.dPos.equals(_curTown.dPos) && 
					_curUnit.db.category == _curTown.dCategory &&
					_curTown.dTypeBuilding == 3)
					_curTown.show_reached();
			}}
		}
		
		public function fastChange_owner()
		{
			for (var i:int = 0; i<modelBattle.cUnits.length; i++ ) {
			for (var j:int = 0; j<modelBattle.cOwners.length; j++ ) {
				
				var _curUnit:Unit	= modelBattle.cUnits[i];
				var _curTown:Owner	= modelBattle.cOwners[j];
				
				if (_curUnit.dPos.equals(_curTown.dPos) && 
					_curUnit.db.category == _curTown.dCategory && 
					_curTown.dTypeBuilding <= 2) {
					switch(_curTown.dTypeBuilding) {
						case 1: _curUnit.dHP += 6; break;
						case 2: _curUnit.dHP += 3; break;
					}
				}
				
				// conquer
				else 
				if (_curUnit.dPos.equals(_curTown.dPos) && 
					_curUnit.db.category != _curTown.dCategory &&
					_curTown.dTypeBuilding<=2) 
					_curTown.setOwner_fast( _curUnit.db.category, _curUnit )	
			}}
		}
		
		
		// ----------------------------------------------------------------
		//				CHECK ENDING
		// -----------------------------------------------------------------
		
		/**
		  * cek semua hal mengenai kota saat berganti giliran.
		  * (0)-(1)ally heals(2)enemy heals unit,(3)ally conquered,(4)enemy conquered(5) ally Basecamp(6) enemy basecamp
		  * @return
		  */
		public function get check_onTile():int
		{
			var _condition:int = 0;
			
			for (var i:int = 0; i<modelBattle.cUnits.length; i++ ) {
			for (var j:int = 0; j<modelBattle.cOwners.length; j++ ) {
				
				var _curUnit:Unit	= modelBattle.cUnits[i];
				var _curTown:Owner	= modelBattle.cOwners[j];
				
				// heal basecamp/building
				if (_curUnit.dPos.equals(_curTown.dPos) && _curUnit.db.category == _curTown.dCategory) {
						if (_curTown.dCategory == "ally")
							_condition = 1;
						else
							_condition = 2;
					}
					
				// conquer
				else 
				if (_curUnit.dPos.equals(_curTown.dPos) && _curUnit.db.category != _curTown.dCategory && _curUnit.dType <= 3) {
											
						if (_curTown.dTypeBuilding == 1) {
							if (_curTown.dCategory == "ally") {
								_condition = 5;
								return _condition;
							}
							else {
								_condition = 6;
								return _condition;
							}
						}
						else {
							if (_curTown.dCategory == "ally")
								_condition = 3;
							else 
								_condition = 4;
						}
						
					}
			
			}}
			
			return _condition;
		}
		
		/**
		 * 0: No problem, 1: ally VIP dead, 2:Enemy VIP dead
		 */
		public function get check_VIP_dead():int
		{
			for (var i:int = 0; i < modelBattle.cUnitJunk.length; i++)
				if (modelBattle.cUnitJunk[i].isThisTarget)
					return (modelBattle.cUnitJunk[i].db.category=="ally")?1:2;
			return 0;
		}
		
		/**
		 * 0: no problem, 1:ally reached win pos, 2:enemy reached win pos
		 */
		public function get check_onWinPos():int
		{
			for (var i:int = 0; i < modelBattle.cUnits.length; i++) {
				var _u:Unit = modelBattle.cUnits[i];
				if (_u.dPos.equals(_u.winPos)) 
					return (_u.db.category == "ally")?2:1
			}
			return 0;
		}
		
		/**
		 * 0: no problem, 1: ally dead, 2: enemy dead
		 */
		public function get check_deadPlayer():int
		{
			var _numAlly	: int = 0;
			var _numEnemy	: int = 0;
			for (var i:int = 0; i < modelBattle.cUnits.length; i++ ) {
				(modelBattle.cUnits[i].db.category == "ally")? _numAlly++ : _numEnemy++;
			}
			
			if (_numAlly == 0)
				return 1;
			
			if(_numEnemy== 0)
				return 2;
			
			return 0;
		}
		
		/**
		 * apakah sudah hari terakhir?
		 */
		public function get isMaxDay():Boolean
		{
			return (Config.day == Config.limitDay)? true:false;
		}
		
		//--------------------------------------------------------------------------------
		// SHOW ENDING
		//--------------------------------------------------------------------------------
		
		
		public function ending_winPos()
		{
			switch(check_onWinPos) {
				case 1	: change_owner();
						  signal_report.dispatch("MISSION FAILED\nEnemy Reached The Point");
						  break;
				case 2	: change_owner();
						  signal_report.dispatch("MISSION ACCOMPLISHED\nYou Reached The Point");
						  break;
			}
		}
		
		public function ending_vipDead()
		{
			switch(check_VIP_dead)
			{
				case 1	: signal_report.dispatch("MISSION FAILED\nYour VIP is Dead");
						  break;
				case 2	: signal_report.dispatch("MISSION ACCOMPLISHED\nEnemy's VIP is Dead");
						  break;
			}
		}
		
		public function ending_deadPlayer()
		{
			switch(check_deadPlayer) {
				case 1	: signal_report.dispatch("MISSION FAILED\nYou are Destroyed");
						  break;
				case 2	: if(Config.usingOnlineData) MyAchievements.show_newbie();
						  signal_report.dispatch("MISSION ACCOMPLISHED\nEnemy Destroyed");
						  break;
			}
		}
		
		public function ending_capturedBasecamp()
		{
			switch(check_onTile) {
				case 5	: change_owner();
						  signal_report.dispatch("MISSION FAILED\nYour Base Captured");
						  break;
				case 6	: change_owner();
						  signal_report.dispatch("MISSION ACCOMPLISHED\nEnemy Base Captured");
						  break;
			}
		}
		
		//--------------------------------------------------------------------------------
		// AREA
		//--------------------------------------------------------------------------------
		
		/**
		 * Tutup area aktif
		 */
		public function hideArea(){
			
			for (var i:int = 0; i < modelBattle.cTile2.length; i++ ) 
			modelBattle.cTile2[i].showTile();	
			
			//if (viewBattle.scaleX != 1)
				//TweenMax.to(viewBattle, 0.5, { x:0, y:0, scaleX:1, scaleY:1, ease:Strong.easeOut } )
		}
		
		public function hideTracks() {
			
			// show path
			for (var i:int = 0; i < modelBattle.cTracks.length; i++ ) {
				modelBattle.cTracks[i].visible = false;
			}
			
			// ui
			(modelBattle.cSigns[0] as Sign).hide();
			(modelBattle.cSelected[1] as CursorSelected).hide();
			
		}
		
		/**
		 * Menampilan area aktif warna putih
		 * @param	_x	Posisi pusat X
		 * @param	_y	Posisi pusat Y
		 * @param	_max	Jarak sebaran
		 */
		public function showArea(_x:int, _y:int, _max:int){
			
			if (Config.focused.db.isDirectAct)		// showArea unit yang memiliki serangan pendek
				recursTiles(_x, _y, _max, true);
				
			else {									// showArea unit yang memiliki serangan jarak jauh
				recursTiles(_x, _y, _max, true);
				recursTiles(_x, _y, _max, false);
			}
		}
		
		/**
		 * Menampilkan influence Map
		 */
		public function showIMap()
		{
			// hidupkan, ambil sampel index pertama
			if (modelBattle.cIMapsAlly[i].visible == false) 
			{
				modelBattle.updateIMap();
				for (var i:int = 0; i < modelBattle.cIMapsAlly.length; i++ )
				{
					modelBattle.cIMapsAlly[i].visible 	= true;
					modelBattle.cIMapsEnemy[i].visible	= true;
					
					// set warna imap box
					// 1. imap>0, imap box = biru
					// 2. imap<0, imap box = merah
					// 3. imap=0, imap box = tansparant
					if (modelBattle.iMap[i] > 0) {
						modelBattle.cIMapsAlly[i].alpha	= modelBattle.iMap[i];
						modelBattle.cIMapsEnemy[i].alpha	= 0
						
					} else
					if (modelBattle.iMap[i] < 0) {
						modelBattle.cIMapsAlly[i].alpha	= 0
						modelBattle.cIMapsEnemy[i].alpha	= -(modelBattle.iMap[i]);
					} else {
						modelBattle.cIMapsAlly[i].alpha	= 0
						modelBattle.cIMapsEnemy[i].alpha	= 0;
					}
					
				}
			} else{
			// matikan
				for (var i:int = 0; i < modelBattle.cIMapsAlly.length; i++ )
				{
					modelBattle.cIMapsAlly[i].visible	= false;
					modelBattle.cIMapsEnemy[i].visible 	= false;
				}
			}
			
		}
	
		/**
		 * data1data1: (1)tipe unit, (2) tipe environment, (3) currenthealth, (4) nextHealth
		 * @param	_isDirAttack
		 * @param	_dataHP1
		 * @param	_dataHP2
		 */
		public function showCinema(_isDirAttack:Boolean)
		{
			
			var _attacker:Array = new Array();
			var _defender:Array = new Array();
			var _bgAtk:int		= modelBattle.getTile(Config.focused.dPos.x, Config.focused.dPos.y).dType; 
			var _bgDef:int		= modelBattle.getTile(Config.clicked.tile.dPos.x, Config.clicked.tile.dPos.y).dType; 
			
			_attacker.push(Config.focused.db.category)
			_attacker.push(Config.focused.dType);
			_attacker.push(_bgAtk);
			_attacker.push(m_HPAtk[1]);
			_attacker.push(m_HPAtk[3]);
			
			_defender.push(Config.clicked.unit.db.category);
			_defender.push(Config.clicked.unit.dType);
			_defender.push(_bgDef);
			_defender.push(m_HPDef[1]);
			_defender.push(m_HPDef[3]);
			
			if (Config.focused.dPos.x == Config.clicked.unit.dPos.x) {
				if (_attacker[0] == "ally") {
					_attacker.push("left");
					_defender.push("right");
				} else {
					_attacker.push("right");
					_defender.push("left");
				}
 			}
			else
			if (Config.focused.dPos.x < Config.clicked.unit.dPos.x) {
				_attacker.push("left")
				_defender.push("right");
			} 
			else {
				_attacker.push("right")
				_defender.push("left");
			}
			trace("Attacker: ", _attacker);
			trace("Defender: ", _defender);
			signal_cinema.dispatch(_attacker, _defender);
			
			// ==================================
			// MUSIC
			// ==================================
			
			Music.GRUP_GAME.pause(Music.bg_player);
			Music.GRUP_GAME.pause(Music.bg_enemy);
			
			TweenMax.delayedCall(1.5,Music.GRUP_GAME.playLoop,[Music.sfx_battle, 0.15]);
		}
		
		public function showTracks() {
			
				// show path
				Path.enableAllyPos			= true;
				Path.enableEnemyPos			= true;
				Path.enableAreaActive		= true;
				Path.enablePassableTiles	= true;
				
				var _path:Vector.<Point> = Path.findPath(modelBattle, Config.focused, Config.clicked.tile.dPos);
				for (var i:int = 0; i < _path.length; i++ ) {
					
					var _currPos:Point = _path[i];
					modelBattle.cTracks[_currPos.x + _currPos.y * Config.WIDTH].visible = true;
					
				}
		}
		
				
		/**
		 * Fungsi untuk melakukan penyebaran area baik area aktif maupun pasif
		 * @param	_x			posisi pusat x sebaran
		 * @param	_y			posisi pusat y sebaran
		 * @param	_max		jangkauan sebaran
		 * @param	_setNormal	<b>mode filter:</b> true untuk filter normal, false filter target
		 */
		private function recursTiles(_x:int, _y:int, _max:int, _setNormal:Boolean){
			if  ( !((_x >= 0) && 
				(_x < Config.WIDTH)	&&	(_y >= 0) && (_y < Config.HEIGHT)) ||  
				( _max == 0 )) 
				return 1;			
			else {
				
				// filter untuk land unit
				if (_setNormal) {
					if (!filter_landUnit_NormalMode(_x, _y)) return 1;
				}else {
					modelBattle.cTile2[_x + _y * Config.WIDTH].showTargetArea();
					if (!filter_landUnit_TargetMode(_x, _y)) return 1;						
				}
				
				recursTiles(_x + 1, _y, _max - 1, _setNormal);
				recursTiles(_x - 1, _y, _max - 1, _setNormal);
				recursTiles(_x, _y + 1, _max - 1, _setNormal);
				recursTiles(_x, _y - 1, _max - 1, _setNormal);
			}
		}
		

		/**
		 * <b>Filter penyebaran area aktif(warna kuning)</b> 
		 * <b> mode normal</b>: area aktif yang ada musuh/ target supply maka area berubah jadi target,
		 * area yang ada unit kawan tidak akan berubah dan penyebaran tetap dilakukan
		 * @param	_x 	Posisi x area
		 * @param	_y	Posisi y area
		 * @return
		 */
		private function filter_landUnit_NormalMode(_x:int, _y:int):Boolean{
			
			//------------------------------------------------------------------------------------------
			// jika tile adalah tile yang bisa dilewati
			//------------------------------------------------------------------------------------------
			
			if (modelBattle.isTilePassable(Config.focused.db, _x, _y)) {
				
				//------------------------------------------------------------------------------------------
				// jika ada unit di dalam tile
				//------------------------------------------------------------------------------------------
				if (modelBattle.isUnit(_x, _y) && modelBattle.getUnit(_x, _y) != Config.focused) {
					
					// 1). jika terdapat unit musuh dan unitFocus adalah unit serangan pendek
					if (Config.focused.db.isDirectAct && 
						Config.focused.db.category != modelBattle.getUnit(_x, _y).db.category) {
						
						// jika unit focus memiliki kemampuan menyerang
						if (!Config.focused.db.isSupply) {
							
							// cek apakah, jalur antara unit target dengan unit focus ada penghalang(unit)
							
							Path.enablePassableTiles 		= true;
							Path.enableEnemyPos				= true;
							Path.enableAreaActive 			= true;
							Path.enableAllyPos				= true;
							var _path		: Vector.<Point>= Path.findPath(modelBattle, Config.focused, new Point(_x, _y))
							var _closePos	: Point;
							
							if (_path.length >= 2) {
								
								// posisi sebelah target langsung
								_closePos = _path[_path.length - 2];			
								//trace(_path);
								// jika di posisi itu
								// 1. ada unit? Apakah unit itu sama dengan fokus unit?
								// 2. tidak ada unit?	  
								if (modelBattle.isUnit(_closePos.x, _closePos.y)) {
									if (modelBattle.getUnit(_closePos.x, _closePos.y) == Config.focused)
									modelBattle.cTile2[_x + _y * Config.WIDTH].showTarget();
									return false;
								} else{
									modelBattle.cTile2[_x + _y * Config.WIDTH].showTarget();
									return false;
								}
								
							}
							return false;	
							
						} else return false; // jika unit focus adalah supplyTruck
							
					} 
					
					// 2).jika terdapat unit musuh dan unitFocus adalah unit serangan jarak jauh
					else
					if (!Config.focused.db.isDirectAct && 
						Config.focused.db.category != modelBattle.getUnit(_x, _y).db.category) {
						return false;	
					}
					
					// 3).jika unit(x,y) adalah kawan
					else {
						
						// jika unit focus adalah supplyTruck
						if (Config.focused.db.isSupply) {
							modelBattle.cTile2[_x + _y * Config.WIDTH].showTarget();
							return false;	
						} else {
							//modelBattle.cTile2[_x + _y * Config.WIDTH].showMove();
							return false; // jika unit focus memiliki kemampuan menyerang
						}
					}
				}
				
				// tile bisa dilewati
				else {
					modelBattle.cTile2[_x + _y * Config.WIDTH].showMove();
					return true; 
				}
				
			}
			
			//------------------------------------------------------------------------------------------
			// jika tile adalah tile yang tidak bisa dilewati
			//------------------------------------------------------------------------------------------
			else {
				//trace("Tipe Tile: "+modelBattle.getTile(_x, _y).dType)
				return false;
			}
			
		}
		
		/**
		 * <b>Filter penyebaran area pasif(jarak sebar) dimana posisi musuh berada</b>
		 * Dalam jarak sebaran yang dimiliki masing-masing unit 
		 * area yang ada musuh maka area berubah jadi target. Fungsi ini dipanggi utk unit indirect attack
		 * @param	_x
		 * @param	_y
		 * @return
		 */
		private function filter_landUnit_TargetMode(_x:int, _y:int):Boolean{
			// jika di dalam tile(x,y) terdapat unit musuh 
			if (modelBattle.isUnit(_x, _y) && Config.focused.db.category != modelBattle.getUnit(_x, _y).db.category) {
				modelBattle.cTile2[_x + _y * Config.WIDTH].showTarget();
				return true;
			}
			else return true;
		}
		
		
		// -------------------------------------------------
		// fungsi-fungsi yang berhubungan dengan recording
		// -------------------------------------------------
		/**
		 * Rekam input 
		 * @param	_isMove	apakah yang direkam FSM bergerak atau menyerang?
		 */
		public function record(_isMove:Boolean, _customPos:Point = null) {
			
			var _outputPos	: Point = 	(_customPos != null)?_customPos: 
										((_isMove)?	Config.clicked.tile.dPos:Config.clicked.unit.dPos);
			
			modelBattle.updateIMap();
			modelBattle.updateCoverByUnit(Config.focused.db);
			
		
			// record input 
			Record.addInput(
				modelBattle.coverMap,
				modelBattle.iMap,
				modelBattle.getMap_unitsValue(),
				modelBattle.negative_toZero(modelBattle.getMap_WalkArea()),
				modelBattle.getMap_Building());
			
			// record output
			Record.addOutput(_isMove, _outputPos.x, _outputPos.y);
			
		}
		
		// -------------------------------------------------
		// fungsi-fungsi voice
		// -------------------------------------------------
		
	}

}