package gimdata.mvc.view 
{
	import al.core.AL;
	import al.core.Ast;
	import al.display.SpriteAL;
	import al.objects.Box;
	import al.objects.CameraAL;
	import com.greensock.easing.Elastic;
	import com.greensock.easing.Strong;
	import com.greensock.TweenMax;
	import de.flintfabrik.starling.display.FFParticleSystem;
	import de.flintfabrik.starling.display.FFParticleSystem.SystemOptions;
	import flash.geom.Point;
	import gimdata.core.config.Config;
	import gimdata.core.config.Music;
	import gimdata.core.config.Report;
	import gimdata.mvc.model.ModelBattle;
	import gimdata.objects.achievements.MyAchievements;
	import gimdata.objects.building.Owner;
	import gimdata.objects.gui.CursorSelected;
	import gimdata.objects.gui.Sign;
	import gimdata.objects.gui.SignVillage;
	import gimdata.objects.tile.Tile1;
	import gimdata.objects.tile.Tile2;
	import gimdata.objects.unit.Unit;
	import org.osflash.signals.events.GenericEvent;
	import org.osflash.signals.Signal;
	import raj.soundlite.MSFX;
	import starling.core.RenderSupport;
	import starling.display.Image;
	import starling.display.Stage;
	import starling.events.SEvent;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.filters.BlurFilter;
	import starling.filters.SpotlightFilter;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author Aldy Ahsadin
	 */
	public class ViewBattle extends SpriteAL 
	{
		private var m_ModelBattle	: ModelBattle;
		public	var signal_report	: Signal;
		
		public function ViewBattle(_modelBattle:ModelBattle) 
		{
			m_ModelBattle 	= _modelBattle;
			signal_report	= new Signal(String);
			
			addEventListener(SEvent.ADDED_TO_STAGE, start);	
			
			// music
			
			//Music.GRUP_GAME.playLoop(Music.bg_player, 0.35);
			switch(Config.currLevel)
			{
				case 1	:Music.GRUP_GAME.playLoop(Music.bg_forest, 0.3); break;
				case 2	:Music.GRUP_GAME.playLoop(Music.bg_forest, 0.3); break;
				case 3	:Music.GRUP_GAME.playLoop(Music.bg_forest, 0.3); break;
				case 4	:Music.GRUP_GAME.playLoop(Music.bg_forest, 0.3); break;
				case 5	:Music.GRUP_GAME.playLoop(Music.bg_forest, 0.3); break;
				case 6	:Music.GRUP_GAME.playLoop(Music.bg_forest, 0.3); break;
				case 7	:Music.GRUP_GAME.playLoop(Music.bg_forest, 0.3); break;
				case 8	:Music.GRUP_GAME.playLoop(Music.bg_forest, 0.3); break;
				case 9	:Music.GRUP_GAME.playLoop(Music.bg_forest, 0.3); break;
				case 10	:Music.GRUP_GAME.playLoop(Music.bg_forest, 0.3); break;
			}
			
			
		}
		
		private function start(e:SEvent):void 
		{
			removeEventListener(SEvent.ADDED_TO_STAGE, start);	
			
			//---------------------//
			// image map
			//---------------------//
			
			createTile0();
			createTile1();
			createTile1_5();
			createTile2();
			createTracks();
			createSelection();
			//effectShadow();
			createIMap();
			createUnits();
			createOwners();
			createUISigns();
			createSensors();
			
			//---------------------//
			// resize view
			//---------------------//
			this.scaleX		= 0.85;
			this.scaleY		= 0.85;
			this.x			= AL.setCenterX(this) + 5;
			this.y			= AL.stageHeight - 200;
			this.alpha		= 0;

			TweenMax.to(this, 0.5,{ alpha:1, delay: 1, ease:Strong.easeOut})
			this.y = (this.height < 280)? AL.setCenterY(this) + 20: AL.setCenterY(this) + 30; // konfigurasi posisi y map
			
			
		}
		
		private function createTracks():void 
		{
			for (var r:int = 0; r < Config.HEIGHT; r++ ) {
			for (var c:int = 0; c < Config.WIDTH; c++ ) {
					
				var _track:Image = new Image(Ast.img("uiSigns", "signs_focus"));
				_track.x		= (Config.STANDART * c);
				_track.y		= (Config.STANDART * r) - 10;
				_track.alpha	= 0.7;
				_track.visible  = false;
				
				addChild(_track);
				m_ModelBattle.cTracks.push(_track);
			}}
		}
		
		private function createUnits():void 
		{
			Config.totalAlly 	= 0;
			Config.totalMusuh 	= 0;
			
			// --------------
			for (var r:int = 0; r < Config.HEIGHT; r++ ) {
			for (var c:int = 0; c < Config.WIDTH; c++ ) {
				var _type	:int = Config.UNITS[ c + r * Config.WIDTH];
				if (_type != 0) {
					var _unit:Unit	= new Unit(_type, new Point(c, r) );
						_unit.sign_remove.add(onRemoveUnitFromStage);
						
						
						// Mengisi AI
						if (_type > 10) {	
							Config.totalMusuh++;
							for (var i:int = 0; i < Config.UNITS_AI.length; i++ ) {
								var _pos:Point 	= Config.UNITS_AI[i][0];
								var _ai	:String	= Config.UNITS_AI[i][1];
								var _parameter:*= Config.UNITS_AI[i][2];
								
								if (_pos.equals(new Point(c, r))) {
									_unit.dModeAI 	= _ai;
									_unit.dAI_param	= (_parameter==undefined)?null:_parameter;
									break;
								}
							}
						} else {
							Config.totalAlly++;
						}
						
						
						// mengisi target yang dibunuh
						for (var i:int = 0; i < Config.WIN_TARGET.length; i++ ) {
							var _pos:Point = Config.WIN_TARGET[i]
							if (_pos.equals(new Point(c, r))) {
								_unit.isThisTarget = true;
								break;
							}
						}
						
						// mengisi koordinat yang dapat membuat kemenangan
						for (var i:int = 0; i < Config.WIN_POS.length; i++ ) {
							var _target:Point 	= Config.WIN_POS[i][0];
							var _pos:Point 		= Config.WIN_POS[i][1];
							if (_target.equals(new Point(c, r))) {
								_unit.winPos = _pos;
								break;
							}
						}
					
					addChild(_unit);
					m_ModelBattle.cUnits.push(_unit);
				}
			}}
		}
		
		private function createTile0():void 
		{
			var _box:Box 	= new Box(AL.stageWidth + 10, AL.stageHeight-8, 0x0, 7, 0.5, 0xB95C00, 30);
				_box.x		= -5;
				_box.y		= -2;
				addChild(_box);
		}
		
		private function effectShadow()
		{
			var m_borderUp	: Image = new Image(Ast.img("borderH"))			
				m_borderUp.scaleY	= 2;
				m_borderUp.y		= -10;
				m_borderUp.alpha	= 0.6;
				addChild(m_borderUp);
		
		}
		
		private function createTile1_5()
		{
			for (var r:int = 0; r < Config.HEIGHT; r++ ) {
			for (var c:int = 0; c < Config.WIDTH; c++ ) {
					
				var _sensor:Box	= new Box(Config.STANDART, Config.STANDART, 0x004080,5, 1, 0xFFFFFF, 3);
				_sensor.x		= Config.STANDART * c;
				_sensor.y		= Config.STANDART * r;
				_sensor.alpha	= 0;
				_sensor.addEventListener(TouchEvent.TOUCH, onTouch);
				
				addChild(_sensor);
				
			}}
			
		}
		
		private function createTile1()
		{
			
			for (var r:int = 0; r < Config.HEIGHT; r++ ) {
			for (var c:int = 0; c < Config.WIDTH; c++ ) {
				var _nomor	:int	= Config.TILE1[ c + r * Config.WIDTH];
				var _tile1	:Tile1 	= new Tile1(_nomor, new Point(c, r));
				addChild(_tile1);
				m_ModelBattle.cTile1.push(_tile1);
			}}
		}
		
		private function createTile2():void 
		{
			for (var r:int = 0; r < Config.HEIGHT; r++ ) {
			for (var c:int = 0; c < Config.WIDTH; c++ ) {
				
				var _nomor	:int	= Config.TILE2[ c + r * Config.WIDTH];
				var _tile2	:Tile2 	= new Tile2(_nomor, new Point(c, r));
				addChild(_tile2);
				m_ModelBattle.cTile2.push(_tile2);	
							
			}}
		}
		
		private function createSelection():void 
		{
			// sign Hand
			var _sign1:CursorSelected = new CursorSelected(new Image(Ast.img("uiSigns", "signs_focus")));
			addChild(_sign1);
			m_ModelBattle.cSelected.push(_sign1);
			
			// sign Atk
			var _sign2:CursorSelected = new CursorSelected(new Image(Ast.img("uiSigns", "signs_clicked")));
			addChild(_sign2);
			m_ModelBattle.cSelected.push(_sign2);
			
		}
		
		private function createOwners():void 
		{
			for (var r:int = 0; r < Config.HEIGHT; r++ ) {
			for (var c:int = 0; c < Config.WIDTH; c++ ) {
				var _type	:int = Config.OWNERS[ c + r * Config.WIDTH];
				if (_type != 0) {
					var _owner:Owner	= new Owner(_type, c, r);
					addChild(_owner);
					m_ModelBattle.cOwners.push(_owner);	
					m_ModelBattle.cTile2[c + r * Config.WIDTH].showOwner(_type);
				}
			}}
		}
		
		private function createSensors()
		{
			for (var r:int = 0; r < Config.HEIGHT; r++ ) {
			for (var c:int = 0; c < Config.WIDTH; c++ ) {
					
				var _sensor:Box	= new Box(Config.STANDART, Config.STANDART, 0x004080,3, 1, 0xFFFFFF, 5);
				_sensor.x		= Config.STANDART * c;
				_sensor.y		= Config.STANDART * r;
				_sensor.alpha	= 0;
				_sensor.addEventListener(TouchEvent.TOUCH, onTouch);
				
				addChild(_sensor);
				
			}}
		}
		
		private function createIMap()
		{
			for (var r:int = 0; r < Config.HEIGHT; r++ ) {
			for (var c:int = 0; c < Config.WIDTH; c++ ) {
				
				var _imap:Box	= new Box(Config.STANDART, Config.STANDART, 0xE6E600, 0, 0);
				_imap.x			= Config.STANDART * c;
				_imap.y			= Config.STANDART * r;
				_imap.alpha		= 1;
				_imap.visible	= false;
				addChild(_imap);
				m_ModelBattle.cIMapsAlly.push(_imap);
				
				var _imap:Box	= new Box(Config.STANDART, Config.STANDART, 0xFF2020, 0, 0);
				_imap.x			= Config.STANDART * c;
				_imap.y			= Config.STANDART * r;
				_imap.alpha		= 1;
				_imap.visible	= false;
				addChild(_imap);
				m_ModelBattle.cIMapsEnemy.push(_imap);
				
			}}
		}
		
		private function createUISigns() {
			
			// sign Hand
			var _sign1:Sign = new Sign(new Image(Ast.img("uiSigns", "signs_hand")));
			addChild(_sign1);
			m_ModelBattle.cSigns.push(_sign1);
			
			// sign Atk
			var _sign2:Sign = new Sign(new Image(Ast.img("uiSigns", "signs_attack")));
			addChild(_sign2);
			m_ModelBattle.cSigns.push(_sign2);
			
			// sign Heal
			var _sign3:Sign = new Sign(new Image(Ast.img("uiSigns", "signs_heal")));
			addChild(_sign3);
			m_ModelBattle.cSigns.push(_sign3);
			
		}
		
		//----------------------------------------------------------------
		private function onTouch(e:TouchEvent):void 
		{
			var _touch: Touch = e.getTouch(this, TouchPhase.ENDED);
			
			var _x	: int 	= e.currentTarget.x / 60;
			var _y	: int 	= e.currentTarget.y / 60;
			
			if (_touch) {
				
				var _pos	: Point		= new Point(_x, _y);
				var _unit	: Unit		= m_ModelBattle.getUnit(_pos.x, _pos.y);
				var _tile	: Tile2		= m_ModelBattle.getTile(_pos.x, _pos.y);
				
				Config.clicked.setData( _unit, _tile );
				m_ModelBattle.fsm.changeState();
				
				
			} 
		}
		
		// -- handler --
		private function onRemoveUnitFromStage(_u:Unit) {
			if (Config.turn == "ally") {
				Config.enemyKilled++;
				
				if (Config.focused.dType == 1 && Config.APCKilled>=5)
					if(Config.usingOnlineData) MyAchievements.show_iamtheman();
				
				if (Config.enemyKilled == 10) {
					if(Config.usingOnlineData) MyAchievements.show_murder();
				} 
				else if (Config.enemyKilled == 20) {
					if(Config.usingOnlineData) MyAchievements.show_mafia();
				}
			}
			m_ModelBattle.removeUnit(_u);
		}
		
		
	}

}