package gimdata.objects.cinematic 
{
	import al.core.AL;
	import al.core.Ast;
	import al.display.SpriteAL;
	import al.objects.Box;
	import com.greensock.easing.Elastic;
	import com.greensock.easing.Strong;
	import com.greensock.TweenMax;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import gimdata.core.config.Music;
	import gimdata.objects.cinematic.unitCinematic.APCCinematic;
	import gimdata.objects.cinematic.unitCinematic.ArtilleryCinematic;
	import gimdata.objects.cinematic.unitCinematic.CinExplosions;
	import gimdata.objects.cinematic.unitCinematic.InfantryCinematic;
	import gimdata.objects.cinematic.unitCinematic.IUnitCinematic;
	import gimdata.objects.cinematic.unitCinematic.JeepCinematic;
	import gimdata.objects.cinematic.unitCinematic.MGunnerCinematic;
	import gimdata.objects.cinematic.unitCinematic.RPGCinematic;
	import gimdata.objects.cinematic.unitCinematic.SupplyCinematic;
	import gimdata.objects.cinematic.unitCinematic.TankCinematic;
	import org.osflash.signals.Signal;
	import starling.display.Image;
	import starling.text.TextField;
	import starling.utils.HAlign;
	
	
	/**
	 * ...
	 * @author ...
	 */
	public class BattleCinema extends SpriteAL 
	{
		
		public function BattleCinema() 
		{
			// --------------
			// Background
			// --------------
			
			m_bgWhite.alpha		= 0;
			m_borderUp.alpha 	= 0;
			m_borderDown.alpha	= 0;
			m_borderDown.y		= AL.stageHeight - m_borderDown.height;
			addChild(m_bgWhite);
			
			// ----------
			// Add BG
			// ----------
			for (var i:int = 0; i < 18; i++) {
				var _bg:Image 	= getBG(i + 1);
					_bg.pivotX	= _bg.width / 2;
					_bg.pivotY	= _bg.height / 2;
					_bg.scaleX	= -1;
					_bg.x		= 120;
					_bg.y		= 155;
					_bg.alpha	= 0;
					
				m_bgLeft.push(_bg);
				addChild(_bg);
			}
			
			for (var i:int = 0; i < 18; i++) {
				var _bg:Image 	= getBG(i + 1);
					_bg.pivotX	= _bg.width / 2;
					_bg.pivotY	= _bg.height / 2;
					_bg.x		= 360;
					_bg.y		= 155;
					_bg.alpha	= 0;
					
				m_bgRight.push(_bg);
				addChild(_bg);
			}
			
			// ----------
			// Add Units
			// ----------
			
			// infantry
			for (var i:int = 0; i < 10; i++) {
				var _infantry1:InfantryCinematic;
				var _infantry2:InfantryCinematic; 
					_infantry1			= new InfantryCinematic("cinematicInfantry", 175 + (i * 5));
					_infantry2			= new InfantryCinematic("cinematicInfantryE",175 + (i * 5));
					_infantry1.pivotX	= _infantry1.width / 2;
					_infantry1.pivotY	= _infantry1.height / 2;
					_infantry2.pivotX	= _infantry2.width / 2;
					_infantry2.pivotY	= _infantry2.height / 2;
					_infantry1.alpha 	= 0;
					_infantry2.alpha	= 0;
					
				addChild(_infantry1);
				addChild(_infantry2);
				
				m_allyInfantry.push(_infantry1);
				m_enmyInfantry.push(_infantry2)
			}
			
			// mGunner
			for (var i:int = 0; i < 6; i++) {
				var _mGunner1:MGunnerCinematic;	
				var _mGunner2:MGunnerCinematic; 	
					_mGunner1			= new MGunnerCinematic("cinematicMGunner", 175 + (i * 8));
					_mGunner2			= new MGunnerCinematic("cinematicMGunnerE",175 + (i * 8));
					_mGunner1.pivotX	= _mGunner1.width / 2;
					_mGunner1.pivotY	= _mGunner1.height / 2;
					_mGunner2.pivotX	= _mGunner2.width / 2;
					_mGunner2.pivotY	= _mGunner2.height / 2;
					_mGunner1.alpha 	= 0;
					_mGunner2.alpha	= 0;
					
				addChild(_mGunner1);
				addChild(_mGunner2);
				
				m_allyMGunner.push(_mGunner1);
				m_enmyMGunner.push(_mGunner2)
			}
			
			// rocket
			for (var i:int = 0; i < 3; i++) {
				var _rpg1:RPGCinematic;	
				var _rpg2:RPGCinematic; 	
					_rpg1			= new RPGCinematic("cinematicRocket", 160 + (i * 15));
					_rpg2			= new RPGCinematic("cinematicRocketE",160 + (i * 15));
					_rpg1.pivotX	= _rpg1.width / 2;
					_rpg1.pivotY	= _rpg1.height / 2;
					_rpg2.pivotX	= _rpg2.width / 2;
					_rpg2.pivotY	= _rpg2.height / 2;
					_rpg1.alpha 	= 0;
					_rpg2.alpha	= 0;
					
				addChild(_rpg1);
				addChild(_rpg2);
				
				m_allyRPG.push(_rpg1);
				m_enmyRPG.push(_rpg2)
			}
			
			// Jeep
			for (var i:int = 0; i < 3; i++) {
				var _jeep1:JeepCinematic;	
				var _jeep2:JeepCinematic; 	
					_jeep1			= new JeepCinematic("cinematicCar", 170 + (i * 15));
					_jeep2			= new JeepCinematic("cinematicCarE",170 + (i * 15));
					_jeep1.pivotX	= _jeep1.width / 2;
					_jeep1.pivotY	= _jeep1.height / 2;
					_jeep2.pivotX	= _jeep2.width / 2;
					_jeep2.pivotY	= _jeep2.height / 2;
					_jeep1.alpha 	= 0;
					_jeep2.alpha	= 0;
					
				addChild(_jeep1);
				addChild(_jeep2);
				
				m_allyJeep.push(_jeep1);
				m_enmyJeep.push(_jeep2)
			}
			
			// apc
			for (var i:int = 0; i < 2; i++) {
				var _apc1:APCCinematic;	
				var _apc2:APCCinematic; 	
					_apc1			= new APCCinematic("cinematicArmour", 170 + (i * 25));
					_apc2			= new APCCinematic("cinematicArmourE",170 + (i * 25));
					_apc1.pivotX	= _apc1.width / 2;
					_apc1.pivotY	= _apc1.height / 2;
					_apc2.pivotX	= _apc2.width / 2;
					_apc2.pivotY	= _apc2.height / 2;
					_apc1.alpha 	= 0;
					_apc2.alpha	= 0;
					
				addChild(_apc1);
				addChild(_apc2);
				
				m_allyAPC.push(_apc1);
				m_enmyAPC.push(_apc2)
			}
			
			// tank
			for (var i:int = 0; i < 2; i++) {
				var _tank1:TankCinematic;	
				var _tank2:TankCinematic; 	
					_tank1			= new TankCinematic("cinematicArmour", 170 + (i * 25));
					_tank2			= new TankCinematic("cinematicArmourE",170 + (i * 25));
					_tank1.pivotX	= _tank1.width / 2;
					_tank1.pivotY	= _tank1.height / 2;
					_tank2.pivotX	= _tank2.width / 2;
					_tank2.pivotY	= _tank2.height / 2;
					_tank1.alpha 	= 0;
					_tank2.alpha	= 0;
					
				addChild(_tank1);
				addChild(_tank2);
				
				m_allyTank.push(_tank1);
				m_enmyTank.push(_tank2)
			}
			
			// artillery
			for (var i:int = 0; i < 3; i++) {
				var _artillery1:ArtilleryCinematic;	
				var _artillery2:ArtilleryCinematic; 	
					_artillery1			= new ArtilleryCinematic("cinematicArtillery", 170 + (i * 15));
					_artillery2			= new ArtilleryCinematic("cinematicArtilleryE",170 + (i * 15));
					_artillery1.pivotX	= _artillery1.width / 2;
					_artillery1.pivotY	= _artillery1.height / 2;
					_artillery2.pivotX	= _artillery2.width / 2;
					_artillery2.pivotY	= _artillery2.height / 2;
					_artillery1.alpha 	= 0;
					_artillery2.alpha	= 0;
					
				addChild(_artillery1);
				addChild(_artillery2);
				
				m_allyArtillery.push(_artillery1);
				m_enmyArtillery.push(_artillery2)
			}
			
			// suply
			for (var i:int = 0; i < 2; i++) {
				var _supply1:SupplyCinematic;	
				var _supply2:SupplyCinematic; 	
					_supply1			= new SupplyCinematic("cinematicArmour", 160 + (i * 10));
					_supply2			= new SupplyCinematic("cinematicArmourE",160 + (i * 35));
					_supply1.pivotX	= _supply1.width / 2;
					_supply1.pivotY	= _supply1.height / 2;
					_supply2.pivotX	= _supply2.width / 2;
					_supply2.pivotY	= _supply2.height / 2;
					_supply1.alpha 	= 0;
					_supply2.alpha	= 0;
					
				addChild(_supply1);
				addChild(_supply2);
				
				m_allySupply.push(_supply1);
				m_enmySupply.push(_supply2)
			}
			
			// explosion
			addChild(m_explosion);
			
			// --------------
			// Setting
			// --------------
			
			addChild(m_borderUp);
			addChild(m_borderDown);
			
			m_bgLeft.pivotX		= m_bgLeft.width / 2;
			m_bgLeft.pivotY		= m_bgLeft.height / 2;
			m_bgLeft.x			= 120 
			m_bgLeft.y			= 100;
			
			m_bgRight.pivotX	= m_bgRight.width / 2;
			m_bgRight.pivotY	= m_bgRight.height / 2;
			m_bgRight.x			= 360 
			m_bgRight.y			= 100;
			
			m_flagGreen.pivotX 	= m_flagGreen.width / 2;
			m_flagGreen.pivotY	= m_flagGreen.height / 2;
			m_flagGreen.x		= 40;
			m_flagGreen.y		= 60;
			m_flagGreen.alpha	= 0;
			addChild(m_flagGreen)
			
			m_flagRed.pivotX 	= m_flagRed.width / 2;
			m_flagRed.pivotY	= m_flagRed.height / 2;
			m_flagRed.x			= AL.stageWidth-40;
			m_flagRed.y			= 60;
			m_flagRed.alpha		= 0;
			addChild(m_flagRed)
			
			m_nameGreen.pivotX	= m_nameGreen.width / 2;
			m_nameGreen.pivotY	= m_nameGreen.height / 2;
			//m_nameGreen.border	= true;
			m_nameGreen.x		= 110;
			m_nameGreen.y		= 60;
			m_nameGreen.alpha	= 0;
			addChild(m_nameGreen);
			
			m_nameRed.pivotX	= m_nameRed.width / 2;
			m_nameRed.pivotY	= m_nameRed.height / 2;
			//m_nameRed.border	= true;
			m_nameRed.x			= AL.stageWidth-110;
			m_nameRed.y			= 60;
			m_nameRed.alpha		= 0;
			addChild(m_nameRed);
			
			m_txtLife_left.alpha  	= 0;
			m_txtLife_left.pivotX	= m_txtLife_left.width / 2;
			m_txtLife_left.pivotY	= m_txtLife_left.height / 2;
			m_txtLife_left.x		= 120;
			m_txtLife_left.y		= 250;
			//m_txtLife_left.border	= true;
			
			m_txtLife_right.alpha  	= 0;
			m_txtLife_right.pivotX	= m_txtLife_right.width / 2;
			m_txtLife_right.pivotY	= m_txtLife_right.height / 2;
			m_txtLife_right.x		= 360;
			m_txtLife_right.y		= 250;
			//m_txtLife_right.border= true;
			
			m_direction.pivotX	= m_direction.width / 2;
			m_direction.pivotY	= m_direction.height / 2;
			m_direction.x		= AL.halfStageWidth;
			m_direction.y		= AL.halfStageHeight + 50;
			m_direction.alpha	= 0;
			
			addChild(m_txtLife_left);
			addChild(m_txtLife_right);
			addChild(m_direction);
			
			this.visible = false;
		}
		
		private var m_bgWhite		:Box		= new Box(AL.stageWidth, AL.stageHeight, 0xFFFFFF, 0, 0);;
		private var m_borderUp		:Box		= new Box(AL.stageWidth, 40, 0x0, 0, 0);;
		private var m_borderDown	:Box		= new Box(AL.stageWidth, 40, 0x0, 0, 0);;
		
		private var m_direction		:Image		= new Image(Ast.img("direction", "arrowClicked"));		
		
		private var m_flagGreen		:Image		= new Image(Ast.img("flags", "allyFlag"));
		private var m_flagRed		:Image		= new Image(Ast.img("flags", "enemyFlag"));
		
		private var m_nameGreen		:TextField	= new TextField(110, 50, "Green", "badabom",40, 0x65B319);
		private var m_nameRed		:TextField	= new TextField(110, 50, "Red", "badabom",40, 0xFF3333);
		private var m_txtLife_left	:TextField	= new TextField(110, 50, "100%", "vcr", 40, 0xFFFFFF);
		private var m_txtLife_right	:TextField	= new TextField(110, 50, "100%", "vcr", 40, 0xFFFFFF);
		
		private var m_bgLeft		:Array	= new Array();
		private var m_bgRight		:Array	= new Array();
		
		private var m_allyInfantry	:Array 	= new Array();
		private var m_enmyInfantry	:Array 	= new Array();

		private var m_allyMGunner	:Array 	= new Array();
		private var m_enmyMGunner	:Array 	= new Array();

		private var m_allyRPG		:Array 	= new Array();
		private var m_enmyRPG		:Array 	= new Array();

		private var m_allyJeep		:Array 	= new Array();
		private var m_enmyJeep		:Array 	= new Array();

		private var m_allyAPC		:Array 	= new Array();
		private var m_enmyAPC		:Array 	= new Array();

		private var m_allyTank		:Array 	= new Array();
		private var m_enmyTank		:Array 	= new Array();

		private var m_allyArtillery	:Array 	= new Array();
		private var m_enmyArtillery	:Array 	= new Array();

		private var m_allySupply	:Array 	= new Array();
		private var m_enmySupply	:Array 	= new Array();
	
		private var m_explosion		:CinExplosions = new CinExplosions();
		
		public	var signal_battleEnd:Signal = new Signal();
		
		
		// -------------------------------------
		// Private function
		// -------------------------------------
		
		private function getBG(_type:int):Image
		{
			var _bg:Image;
			switch(_type)
			{
				case 1	: _bg = new Image(Ast.img("cinBG","cinBG_village")); break;
				case 2	: _bg = new Image(Ast.img("cinBG","cinBG_village")); break;
				case 3	: _bg = new Image(Ast.img("cinBG","cinBG_village")); break;
				case 4	: _bg = new Image(Ast.img("cinBG","cinBG_village")); break;
				case 5	: _bg = new Image(Ast.img("cinBG","cinBG_forest")); break;
				case 6	: _bg = new Image(Ast.img("cinBG","cinBG_forest")); break;
				case 7	: _bg = new Image(Ast.img("cinBG","cinBG_hill")); break;
				case 8	: _bg = new Image(Ast.img("cinBG","cinBG_hill")); break;
				case 9	: _bg = new Image(Ast.img("cinBG","cinBG_bridge")); break;
				case 10	: _bg = new Image(Ast.img("cinBG","cinBG_bridge")); break;
				case 11	: _bg = new Image(Ast.img("cinBG","cinBG_grass")); break;
				case 12	: _bg = new Image(Ast.img("cinBG","cinBG_ground")); break;
				case 13	: _bg = new Image(Ast.img("cinBG","cinBG_field")); break;
				case 14	: _bg = new Image(Ast.img("cinBG","cinBG_swamp")); break;
				case 15	: _bg = new Image(Ast.img("cinBG","cinBG_street")); break;
				case 16	: _bg = new Image(Ast.img("cinBG","cinBG_street")); break;
				case 17	: _bg = new Image(Ast.img("cinBG","cinBG_river")); break;
				case 18	: _bg = new Image(Ast.img("cinBG","cinBG_river")); break;
				
			}
			return _bg;
		}
		private function getUnit(_category:String, _type:int):Array
		{
			var _units:Array;
			switch(_type) {
				case 1	: _units = (_category == "ally")? m_allyInfantry:m_enmyInfantry; break;
				case 2	: _units = (_category == "ally")? m_allyMGunner:m_enmyMGunner; break;
				case 3	: _units = (_category == "ally")? m_allyRPG:m_enmyRPG; break;
				case 4	: _units = (_category == "ally")? m_allyJeep:m_enmyJeep; break;
				case 5	: _units = (_category == "ally")? m_allyAPC:m_enmyAPC; break;
				case 6	: _units = (_category == "ally")? m_allyTank:m_enmyTank; break;
				case 7	: _units = (_category == "ally")? m_allyArtillery:m_enmyArtillery; break;
				case 9	: _units = (_category == "ally")? m_allySupply:m_enmySupply; break;
			}
			return _units;
		}
		private function getTotalShowedUnit(_units:Array):int
		{
			var _num:int = 0;
			for (var i:int = 0; i < _units.length; i++ ) {
				if (_units[i].alpha == 1)_num++;
			}
			return _num;
		}
		private function setPos(_pos:String, _unit:Array)
		{
			for (var i:int = 0; i < _unit.length; i++) {
				(_unit[i] as IUnitCinematic).scaleX = ((_pos == "left")?1: -1);
				(_unit[i] as IUnitCinematic).x  	= ((_pos == "left")?((Math.random() * 170) + 10):((Math.random() * 160) + 300));
			}
		}
		private function show(_atk:Array, _def:Array)
		{
			// -- show bg
			this.visible 	= true;
			
			m_bgWhite.alpha		= 0;
			m_borderUp.alpha 	= 0;
			m_borderDown.alpha	= 0;
			m_flagGreen.alpha	= 0;
			m_flagRed.alpha		= 0;
			m_nameGreen.alpha	= 0;
			m_nameRed.alpha		= 0;
			
			m_borderUp.y		= -m_borderUp.height;
			m_borderDown.y		= AL.stageHeight;
			
			TweenMax.to(m_bgWhite, 	0.5,{ alpha:0.9 } );
			TweenMax.to(m_borderUp, 0.3,{ alpha:1.0, delay:0.1, y:0, ease:Strong.easeOut} );
			TweenMax.to(m_borderDown,0.3,{ alpha:1.0, delay:0.1, y:AL.stageHeight-m_borderDown.height, ease:Strong.easeOut});
			
			// --set bg
			var _indexLeft:int	= (m_atk.pos == "left")?m_atk.bg:m_def.bg;
			var _indexRight:int	= (m_atk.pos == "right")?m_atk.bg:m_def.bg;
			
			TweenMax.to(m_bgLeft[_indexLeft - 1], 0.4, { alpha:1, y:145, delay:0.3, ease:Strong.easeOut } );
			TweenMax.to(m_bgRight[_indexRight - 1], 0.4, { alpha:1, y:145, delay:0.3, ease:Strong.easeOut } );
			
			
			// -- units
			var _maxAtk:int = Math.ceil(m_atk.currHP / (100/_atk.length));
			var _maxDef:int = Math.ceil(m_def.currHP / (100/_def.length));
			//
			for (var i:int = 0; i<_maxAtk;i++) {
				(_atk[i] as IUnitCinematic).alpha = 0;
				(_atk[i] as IUnitCinematic).show_idle();
				TweenMax.to(_atk[i], 0.3, { delay:0.3, alpha:1, y:_atk[i].y-30, ease:Strong.easeOut});
			}
			
			for (var i:int=0;i<_maxDef;i++){
				(_def[i] as IUnitCinematic).alpha = 0;
				(_def[i] as IUnitCinematic).show_idle();
				TweenMax.to(_def[i], 0.3, { delay:0.3, alpha:1, y:_def[i].y-30, ease:Strong.easeOut});
			}	
			
			TweenMax.to(m_txtLife_left, 0.5,{alpha:1,delay:0.3});
			TweenMax.to(m_txtLife_right, 0.5, { alpha:1, delay:0.3 } );
			
			// -- sign
			TweenMax.to(m_flagGreen,0.5, { alpha:1, delay:0.4 } );
			TweenMax.to(m_flagRed, 	0.5, { alpha:1, delay:0.4 } );
			TweenMax.to(m_nameGreen,0.5, { alpha:1, delay:0.5 } );
			TweenMax.to(m_nameRed,	0.5, { alpha:1, delay:0.5 } );
		}
		private function units_forward(_left:Array, _right:Array, _gotoLeft:Boolean=true)
		{
			for (var i:int = 0; i < _left.length; i++) {
				(_left[i] as IUnitCinematic).activateAnim 	= true;
				(_left[i] as IUnitCinematic).gotoLeft		= _gotoLeft; 
			}
			
			for (var i:int = 0; i < _right.length; i++) {
				(_right[i] as IUnitCinematic).activateAnim 	= true;
				(_right[i] as IUnitCinematic).gotoLeft		= _gotoLeft; 
			}
			
		}
		private function play_battle(_num:int=1)
		{
			var _totalUnits:int	= (_num == 1)?getTotalShowedUnit(m_def.units):getTotalShowedUnit(m_atk.units);
			var _currHP:int		= (_num == 1)?m_def.currHP:m_atk.currHP;
			var _nextHP:int		= (_num == 1)?m_def.nextHP:m_atk.nextHP;
			var _currPos:String	= (_num == 1)?m_def.pos:m_atk.pos;
			var _lwrBoundHP:int = _currHP-(_currHP/_totalUnits);
					
			
			
			var _t:Timer 		= new Timer(40)
				_t.addEventListener(TimerEvent.TIMER, function() {
					
					// -- show text 
					(_currPos=="left")?m_txtLife_left.text = _currHP+ "%":m_txtLife_right.text = _currHP+ "%";
					
					// -------------------------------------------
					// shake
					// -------------------------------------------
					for (var i:int = 0; i < 5; i++) {
						TweenMax.delayedCall(i * 0.05, function() {
							x = (Math.random() * 0.5)-0.5;
							y = (Math.random() * 2)-1;
						})
					}
					TweenMax.delayedCall(0.3, function() {
						x 	= 0;
						y	= 0;
					});
					
					
					// -- die
					if (_totalUnits > 0 && _currHP <= _lwrBoundHP) {
						
						// -------------------------------------------
						// shake
						// -------------------------------------------
						for (var i:int = 0; i < 5; i++) {
							TweenMax.delayedCall(i * 0.05, function() {
								x = (Math.random() * 2)-2;
								y = (Math.random() * 20)-10;
							})
						}
						TweenMax.delayedCall(0.3, function() {
							x 	= 0;
							y	= 0;
						});
						
					
						//---------------------------------------------
						var _uPos:Point = new Point();
						if (_num == 1 ) {
							
							_uPos.x = m_def.units[_totalUnits - 1].x;
							_uPos.y = m_def.units[_totalUnits - 1].y;
							m_explosion.show_Explosion(_uPos);
							
							m_def.units[_totalUnits - 1].show_die();
						}
						else {
							
							_uPos.x = m_atk.units[_totalUnits - 1].x;
							_uPos.y = m_atk.units[_totalUnits - 1].y;
							m_explosion.show_Explosion(_uPos);
							
							m_atk.units[_totalUnits - 1].show_die();
						}
						_totalUnits--;
						_lwrBoundHP	= _currHP - (_currHP / _totalUnits);
						
						
					}
					_currHP--;
					
					// -- ends
					if (_currHP<_nextHP) {
						_t.stop();
						
						if (_num==1 && m_atk.type < 7 && m_def.nextHP > 0) {
							m_direction.scaleX 	= (m_def.pos == "left")?1: -1;
							play_battle(2);
						} else {
							
							// stop battle
							for (var i:int = 0; i < m_atk.units.length; i++)
							(m_atk.units[i] as IUnitCinematic).activateAnim = false;
							
							for (var i:int = 0; i < m_def.units.length; i++)
							(m_def.units[i] as IUnitCinematic).activateAnim = false;
							
							Music.GRUP_GAME.getSound(Music.sfx_battle).pause();
							
							// text scale
							TweenMax.to(m_txtLife_left, 0.7, { scaleX:1.5, scaleY:1.5, delay:1, ease:Elastic.easeOut});
							TweenMax.to(m_txtLife_right, 0.7, { scaleX:1.5, scaleY:1.5, delay:1, ease:Elastic.easeOut } );
							TweenMax.delayedCall(2, hide);
							TweenMax.delayedCall(2, signal_battleEnd.dispatch);
						}
					}
					
				});
				
				_t.start();
		}
		private function hide()
		{
			// -- hide units
			var _maxAtk:int = Math.ceil(m_atk.currHP / (100/m_atk.units.length));
			var _maxDef:int = Math.ceil(m_def.currHP / (100 / m_def.units.length));
			
			// --set bg
			var _indexLeft:int	= (m_atk.pos == "left")?m_atk.bg:m_def.bg;
			var _indexRight:int	= (m_atk.pos == "right")?m_atk.bg:m_def.bg;
			
			TweenMax.to(m_bgLeft[_indexLeft - 1], 0.3, { alpha:0, y:155} );
			TweenMax.to(m_bgRight[_indexRight - 1], 0.3, { alpha:0, y:155} );
			
			// -- units
			for (var i:int = 0; i < _maxAtk; i++) 
				TweenMax.to(m_atk.units[i], 0.5, { alpha:0, y:m_atk.units[i].y + 30, ease:Strong.easeOut } );	
			for (var i:int = 0; i < _maxDef; i++) 
				TweenMax.to(m_def.units[i], 0.5, { alpha:0, y:m_def.units[i].y + 30, ease:Strong.easeOut } );
			
			// -- hide border
			TweenMax.to(m_bgWhite, 	0.5,{ delay: 0.2, alpha:0 } );
			TweenMax.to(m_borderUp, 0.3,{ alpha:0, delay:0.3, y:-m_borderUp.height, ease:Strong.easeOut} );
			TweenMax.to(m_borderDown,0.3,{ alpha:0, delay:0.3, y:AL.stageHeight, ease:Strong.easeOut});
			
			// -- hide score
			TweenMax.to(m_txtLife_left, 0.1,{alpha:0, scaleX:1, scaleY:1, delay:0.3});
			TweenMax.to(m_txtLife_right, 0.1, { alpha:0, scaleX:1, scaleY:1, delay:0.3 } );
			TweenMax.to(m_direction, 0.3, { alpha:0, delay:0.4 } );
			
			// -- flag name
			TweenMax.to(m_flagGreen,0.3, { alpha:0, delay:0.5 } );
			TweenMax.to(m_flagRed, 	0.3, { alpha:0, delay:0.5 } );
			TweenMax.to(m_nameGreen,0.3, { alpha:0, delay:0.5 } );
			TweenMax.to(m_nameRed,	0.3, { alpha:0, delay:0.5 } );
			
			TweenMax.delayedCall(1, function() {
				visible = false;
			})
			
		}
		
		// -------------------------------------
		// Public function
		// -------------------------------------
		private var m_atk:DataCinematic = new DataCinematic();
		private var m_def:DataCinematic = new DataCinematic();
		public function playCinema(_attacker:Array, _defender:Array)
		{
			
			// ------------------------------------------------------
			// init
			// ------------------------------------------------------
			
			m_atk.setCategory(_attacker[0]);
			m_def.setCategory(_defender[0]);
			
			m_atk.setType(_attacker[1]);
			m_def.setType(_defender[1]);
			
			m_atk.setBg(_attacker[2]+1);
			m_def.setBg(_defender[2]+1);
			
			m_atk.setCurrHP(_attacker[3]);
			m_def.setCurrHP(_defender[3]);
			
			m_atk.setNextHP(_attacker[4]);
			m_def.setNextHP(_defender[4]);
			
			m_atk.setPos(_attacker[5]);
			m_def.setPos(_defender[5]);
			
			m_atk.units	= getUnit(m_atk.category, m_atk.type);
			m_def.units	= getUnit(m_def.category, m_def.type);
			
			// ------------------------------------------------------
			// set posisi
			// ------------------------------------------------------
			setPos(m_atk.pos, m_atk.units);
			setPos(m_def.pos, m_def.units);
			
			if (m_atk.category == "ally") {
				m_flagGreen.x		= (m_atk.pos == "left")?40:AL.stageWidth - 40;
				m_flagRed.x			= (m_atk.pos == "left")?AL.stageWidth - 40:40;
				m_nameGreen.x		= (m_atk.pos == "left")?110:AL.stageWidth - 110;
				m_nameRed.x			= (m_atk.pos == "left")?AL.stageWidth - 110:110;
				m_nameGreen.hAlign	= (m_atk.pos == "left")?HAlign.LEFT:HAlign.RIGHT;
				m_nameRed.hAlign	= (m_atk.pos == "left")?HAlign.RIGHT:HAlign.LEFT;	
			}
			else {
				m_flagRed.x			= (m_atk.pos == "left")?40:AL.stageWidth - 40;
				m_flagGreen.x		= (m_atk.pos == "left")?AL.stageWidth - 40:40;
				m_nameRed.x			= (m_atk.pos == "left")?110:AL.stageWidth - 110;
				m_nameGreen.x		= (m_atk.pos == "left")?AL.stageWidth - 110:110;
				m_nameRed.hAlign	= (m_atk.pos == "left")?HAlign.LEFT:HAlign.RIGHT;
				m_nameGreen.hAlign	= (m_atk.pos == "left")?HAlign.RIGHT:HAlign.LEFT;
			}
			
			m_txtLife_left.text		= ((m_atk.pos == "left")?m_atk.currHP:m_def.currHP)+"%";
			m_txtLife_right.text	= ((m_atk.pos == "left")?m_def.currHP:m_atk.currHP)+"%";
			m_direction.scaleX 		= (m_atk.pos == "left")?1: -1;
			m_direction.alpha		= 0;
			
			// -- show
			show(m_atk.units, m_def.units);
			TweenMax.to(m_direction, 0.3, { alpha:1, delay:0.5 } );
			
			// -- play
			TweenMax.delayedCall(1, units_forward, [
					((m_atk.pos == "left")?m_atk.units:m_def.units),
					((m_atk.pos == "right")?m_atk.units:m_def.units),
					(m_atk.pos == "right")?true:false]);
			
			TweenMax.delayedCall(1.2, play_battle);
			
		}
	
	}

}