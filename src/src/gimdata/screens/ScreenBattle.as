 package gimdata.screens 
{
	import al.ALManager;
	import al.core.AL;
	import al.core.Ast;
	import al.display.ScreenAL;
	import al.display.SpriteAL;
	import com.greensock.TweenMax;
	import flash.events.Event;
	import gimdata.core.config.Config;
	import gimdata.core.config.Music;
	import gimdata.mvc.control.ControlAI;
	import gimdata.mvc.control.ControlBattle;
	import gimdata.mvc.model.ModelBattle;
	import gimdata.mvc.view.ViewBattle;
	import gimdata.mvc.view.ViewUiBattle;
	import gimdata.mvc.view.ViewUiReport;
	import gimdata.objects.achievements.MyAchievements;
	import gimdata.objects.cinematic.BattleCinema;
	import gimdata.objects.unit.Unit;
	import starling.display.Image;
	import starling.events.SEvent;
	
	/**
	 * ...
	 * @author Aldy Ahsadin
	 */
	public class ScreenBattle extends ScreenAL 
	{
		
		// -- background --
		private var m_bg			: Image;
		
		// ---------------------------------------------
		// Data battle
		// ---------------------------------------------
		private var m_modelBattle	: ModelBattle;
		private var m_viewBattle	: ViewBattle;
		private var m_controlBattle	: ControlBattle;
		
		// ---------------------------------------------
		// Data ui 
		// ---------------------------------------------
		private var m_viewUiBattle	: ViewUiBattle;
		private var m_viewUiReport	: ViewUiReport;
		
		// ---------------------------------------------
		// Cinematic Battle
		// ---------------------------------------------
		private var m_battleCinema	:BattleCinema
		// ---------------------------------------------
		// Control AI
		// ---------------------------------------------
		private var m_controlAI		: ControlAI;
		
		// ---------------------------------------------
		// Achievements
		// ---------------------------------------------
		
		public function ScreenBattle(_alManager:ALManager) {
			super(_alManager);
		}
		
		override public function start(e:SEvent) {
			
			playBattle();
			//activateScanline();
		}
		
		private function playBattle():void 
		{
			
			// ---------------------------------------------
			// hapus ui
			// ---------------------------------------------
			Config.restart();
			
			if (m_bg) {
				remove(m_bg);
				m_bg	= null;
			}
			
			m_viewBattle	= removeView(m_viewBattle);
			m_viewUiBattle	= removeView(m_viewUiBattle);
			m_viewUiReport	= removeView(m_viewUiReport);
			
			// ---------------------------------------------
			// data battle
			// ---------------------------------------------
			
			// -- masukkan data baru
			m_bg			= new Image(Ast.img("bgBattle"));
			
			// -- main
			m_modelBattle	= new ModelBattle();
			m_viewBattle	= new ViewBattle(m_modelBattle);
			m_controlBattle	= new ControlBattle(m_modelBattle, m_viewBattle);
			
			// -- cinema
			m_battleCinema	= new BattleCinema();
			
			// -- ui
			m_viewUiBattle	= new ViewUiBattle(m_modelBattle, m_viewBattle, m_controlBattle);
			m_viewUiReport	= new ViewUiReport();
			
			// -- ai
			m_controlAI		= new ControlAI(m_modelBattle, m_controlBattle);
			
			//-- event listener
			m_controlBattle.signal_infoUnit		.add(onShow_infoUnit);
			m_controlBattle.signal_infoTile		.add(onShow_infoTile);
			m_controlBattle.signal_cinema		.add(onShow_cinematicBattle);
			m_controlBattle.signal_block		.add(onShow_block);
			m_controlBattle.signal_unFocusUnit	.add(onUnFocusUnit);
			m_controlBattle.signal_confirmation	.add(onShow_confirmation);
			m_controlBattle.signal_report		.add(onShow_report);
			m_controlBattle.signal_endBattle	.add(onShow_turn);
			m_controlBattle.signal_chat			.add(onShow_chat);
			
			//m_viewBattle.signal_report			.add(onShow_report);
			
			m_battleCinema.signal_battleEnd		.add(onShow_cinematicBattleEnd);
			
			m_viewUiBattle.signal_menu			.add(onShow_menu);
			m_viewUiBattle.signal_report		.add(onShow_report);
			m_viewUiBattle.signal_simulation	.add(onAiThink);
			m_viewUiBattle.signal_imap			.add(on_imap);
			
			m_viewUiReport.signal_restart		.add(onRestart);
			m_viewUiReport.signal_exit			.add(onExit);
			m_viewUiReport.signal_nextLevel		.add(onRestart);
			
			m_controlAI.signal_onPlayAI			.add(onAiPlay);
			m_controlAI.signal_block			.add(onShow_block);
			m_controlAI.signal_turn				.add(onShow_turn);
			//m_controlAI.signal_report			.add(onShow_report);
			
			
			var _borderH1:Image		= new Image(Ast.img("borderH"));
			var _borderH2:Image		= new Image(Ast.img("borderH"));
			
				_borderH2.scaleY 	= -1;
				_borderH2.y			= AL.stageHeight+1;
			
			// -- update display
			add(m_bg);
			add(m_viewBattle);
			add(_borderH1); add(_borderH2);
			add(m_viewUiBattle);
			add(m_battleCinema);
			add(m_viewUiReport);
			
			
			m_viewUiBattle.tutorial.playTutorial();
		}
		
		// -------------------------------------------------
		// Event Handler
		// -------------------------------------------------
		
		// -- display handler
		private function onShow_infoUnit(_isShow:Boolean) { 
			(_isShow)?m_viewUiBattle.showInfoUnit():m_viewUiBattle.hideInfoUnit(); 
		}
		private function onShow_infoTile(_isShow:Boolean) { 
			(_isShow)?m_viewUiBattle.showInfoTile():m_viewUiBattle.hideInfoTile();
		}
		private function onShow_cinematicBattle(_data1:Array, _data2:Array) { 
			m_battleCinema.playCinema(_data1, _data2);
		}
		private function onShow_cinematicBattleEnd() { 
			m_controlBattle.endAction();
		}
		private function onShow_report(_result:String) {
			// -------------
			// hitung sisa
			// -------------
			
			var _sisaAlly:int	= m_modelBattle.getUnits("ally").length;
			var _sisaMusuh:int	= m_modelBattle.getUnits("enemy").length;
			
			Config.hitungScore(_sisaAlly, _sisaMusuh);
			
			// -----rambo
			
			if (Config.usingOnlineData)
			{
				var _allyHP:Vector.<Unit> = m_modelBattle.getUnits("ally");
				var _isRambo:Boolean = true;
				
				for (var i:int = 0; i < _allyHP.length; i++) {
					if (_allyHP[i].dHP < _allyHP[i].db.hpFull) {
						_isRambo = false;
						break;
					}
				}
				if (_isRambo) MyAchievements.show_rambo();
				
			}
			
			// -----------------------------------------
			m_viewUiBattle.screenBlock.visible = true;
			
			// Matikan BG
			TweenMax.delayedCall(1.5, Music.GRUP_GAME.getSound(Music.bg_player).pause);
			TweenMax.delayedCall(1.5, Music.GRUP_GAME.getSound(Music.bg_enemy).pause);
			TweenMax.delayedCall(1.5, Music.GRUP_GAME.getSound(Music.bg_forest).pause);
			
			var _hasil:String = _result.substr(0, 9);
			switch(_hasil) {
				case "MISSION A"	:TweenMax.delayedCall(2.5, Music.GRUP_GAME.playFx, [Music.sfx_ending , 0.3]); break;
				case "MISSION F"	:TweenMax.delayedCall(2.5, Music.GRUP_GAME.playFx, [Music.sfx_ending2, 0.3]); break;
			}
			
			TweenMax.delayedCall(4, m_viewUiReport.showReport, [_result]);
		}
		private function onShow_menu() {
			m_viewUiReport.showMenu();
		}
		private function onShow_block(_isTurn:Boolean) {
			m_viewUiBattle.screenBlock.visible = _isTurn;
		}
		private function onShow_confirmation() {
			m_viewUiBattle.showConfirmation();
		}
		private function onShow_turn():void {
			if (!m_viewUiReport.visible || m_viewUiReport.visible == undefined)
				m_viewUiBattle.showDay();
		}
		private function onShow_chat(_value:int){
			m_viewUiBattle.showChat(_value);
		}
		private function on_imap(){
			m_modelBattle.updateIMap();
		}
		
		// -- playing handler
		private function onRestart() {
			m_viewUiReport.hideMenu();
			m_viewUiBattle.showAllButtons();
			playBattle();
		}
		private function onExit(){
			alManager.showScreen(ScreenMenu);
		}
		
		// -- ai handler
		private function onAiThink() {
			m_controlAI.startThinking();
		}
		
		private function onAiPlay() {
			m_viewUiBattle.screenBlock.visible = true;
			TweenMax.delayedCall(0.5, m_viewUiBattle.hideTransition);
			TweenMax.delayedCall(0.5, m_controlAI.startPlaying);
		}
		
		private function onUnFocusUnit() {
			m_controlAI.unFocusToUnit(false);
		}
		
		// -------------------------------------------------
		// Remove
		// -------------------------------------------------
		
		private function removeView(_view:SpriteAL) {
			if (_view) {
				
				while (_view.numChildren > 0) {
					_view.removeChild(_view.getChildAt(0))
				}
				
				remove(_view)
				return null;
			} else return null;
		}
	}

}