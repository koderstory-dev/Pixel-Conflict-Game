package gimdata.core.config 
{
	
	import flash.net.SharedObject;
	import gimdata.core.levels.Level1;
	import gimdata.core.levels.Level10;
	import gimdata.core.levels.Level2;
	import gimdata.core.levels.Level3;
	import gimdata.core.levels.Level4;
	import gimdata.core.levels.Level5;
	import gimdata.core.levels.Level6;
	import gimdata.core.levels.Level7;
	import gimdata.core.levels.Level8;
	import gimdata.core.levels.Level9;
	import gimdata.objects.selected.Clicked;
	import gimdata.objects.unit.Unit;
	/**
	 * Static Setting Class
	 * @author AldyAhsn
	 */
	public class Config 
	{
		
		public static function loadLevels():Array
		{
			var _levelData:Array;
			if(usingOnlineData) _levelData = levels_online;
			else _levelData = levels_local.data.levels;
			return _levelData;
		}
		
		public static function updateLevels()
		{
			if (usingOnlineData) {
				if (Config.currLevel < Config.MAXLEVEL) {
					
					// ngesave level selanjutnya
					switch(Config.currLevel) {
						case 1: switch(onlineSlot) {
									case 1:	IDI.idnet.submitUserData('slotOnline_1', "LEVEL #2"); IDI.m_saveOL_1 = "LEVEL #2"; break;
									case 2:	IDI.idnet.submitUserData('slotOnline_2', "LEVEL #2"); IDI.m_saveOL_2 = "LEVEL #2";break;
									case 3:	IDI.idnet.submitUserData('slotOnline_3', "LEVEL #2"); IDI.m_saveOL_3 = "LEVEL #2";break;
								}
								break
						case 2: switch(onlineSlot) {
									case 1:	IDI.idnet.submitUserData('slotOnline_1', "LEVEL #3"); IDI.m_saveOL_1 = "LEVEL #3";break;
									case 2:	IDI.idnet.submitUserData('slotOnline_2', "LEVEL #3"); IDI.m_saveOL_2 = "LEVEL #3";break;
									case 3:	IDI.idnet.submitUserData('slotOnline_3', "LEVEL #3"); IDI.m_saveOL_3 = "LEVEL #3";break;
								}
								break
						case 3: switch(onlineSlot) {
									case 1:	IDI.idnet.submitUserData('slotOnline_1', "LEVEL #4"); IDI.m_saveOL_1 = "LEVEL #4"; break;
									case 2:	IDI.idnet.submitUserData('slotOnline_2', "LEVEL #4"); IDI.m_saveOL_2 = "LEVEL #4";break;
									case 3:	IDI.idnet.submitUserData('slotOnline_3', "LEVEL #4"); IDI.m_saveOL_3 = "LEVEL #4";break;
								}
								break
						case 4: switch(onlineSlot) {
									case 1:	IDI.idnet.submitUserData('slotOnline_1', "LEVEL #5"); IDI.m_saveOL_1 = "LEVEL #5"; break;
									case 2:	IDI.idnet.submitUserData('slotOnline_2', "LEVEL #5"); IDI.m_saveOL_2 = "LEVEL #5";break;
									case 3:	IDI.idnet.submitUserData('slotOnline_3', "LEVEL #5"); IDI.m_saveOL_3 = "LEVEL #5";break;
								}
								break
						case 5: switch(onlineSlot) {
									case 1:	IDI.idnet.submitUserData('slotOnline_1', "LEVEL #6"); IDI.m_saveOL_1 = "LEVEL #6"; break;
									case 2:	IDI.idnet.submitUserData('slotOnline_2', "LEVEL #6"); IDI.m_saveOL_2 = "LEVEL #6";break;
									case 3:	IDI.idnet.submitUserData('slotOnline_3', "LEVEL #6"); IDI.m_saveOL_3 = "LEVEL #6";break;
								}
								break
						case 6: switch(onlineSlot) {
									case 1:	IDI.idnet.submitUserData('slotOnline_1', "LEVEL #7"); IDI.m_saveOL_1 = "LEVEL #7"; break;
									case 2:	IDI.idnet.submitUserData('slotOnline_2', "LEVEL #7"); IDI.m_saveOL_2 = "LEVEL #7";break;
									case 3:	IDI.idnet.submitUserData('slotOnline_3', "LEVEL #7"); IDI.m_saveOL_3 = "LEVEL #7";break;
								}
								break
						case 7: switch(onlineSlot) {
									case 1:	IDI.idnet.submitUserData('slotOnline_1', "LEVEL #8"); IDI.m_saveOL_1 = "LEVEL #8"; break;
									case 2:	IDI.idnet.submitUserData('slotOnline_2', "LEVEL #8"); IDI.m_saveOL_2 = "LEVEL #8";break;
									case 3:	IDI.idnet.submitUserData('slotOnline_3', "LEVEL #8"); IDI.m_saveOL_3 = "LEVEL #8";break;
								}
								break
						case 8: switch(onlineSlot) {
									case 1:	IDI.idnet.submitUserData('slotOnline_1', "LEVEL #9"); IDI.m_saveOL_1 = "LEVEL #9"; break;
									case 2:	IDI.idnet.submitUserData('slotOnline_2', "LEVEL #9"); IDI.m_saveOL_2 = "LEVEL #9";break;
									case 3:	IDI.idnet.submitUserData('slotOnline_3', "LEVEL #9"); IDI.m_saveOL_3 = "LEVEL #9";break;
								}
								break
						case 9: switch(onlineSlot) {
									case 1:	IDI.idnet.submitUserData('slotOnline_1', "LEVEL #10"); IDI.m_saveOL_1 = "LEVEL #10"; break;
									case 2:	IDI.idnet.submitUserData('slotOnline_2', "LEVEL #10"); IDI.m_saveOL_2 = "LEVEL #10";break;
									case 3:	IDI.idnet.submitUserData('slotOnline_3', "LEVEL #10"); IDI.m_saveOL_3 = "LEVEL #10";break;
								}
								break
						case 10: switch(onlineSlot) {
									case 1:	IDI.idnet.submitUserData('slotOnline_1', "LEVEL #10"); IDI.m_saveOL_1 = "LEVEL #11"; break;
									case 2:	IDI.idnet.submitUserData('slotOnline_2', "LEVEL #10"); IDI.m_saveOL_2 = "LEVEL #11";break;
									case 3:	IDI.idnet.submitUserData('slotOnline_3', "LEVEL #10"); IDI.m_saveOL_3 = "LEVEL #11";break;
								}
								break
						
					}
				}
				
			} else {
				Config.levels_local.data.levels[Config.currLevel] = 1;
				Config.levels_local.flush();
			}
		}
		
		//-------------------------------------------------
		// Data statis
		//-------------------------------------------------
		
		public static const WIDTH			: int 	= 8;
		public static const HEIGHT			: int 	= 5;
		
		public static const STANDART		: int 	= 60;
		public static const MAXLEVEL		: int 	= 10;
		
		//-------------------------------------------------
		// Host domain
		//-------------------------------------------------
		
		public static var URL				:String 	= "";
		public static function validateDomain_y8()
		{
			var _regex:RegExp = /(\w+)s?:\/\/(.*)?((y8.com)|(pog.com)|(dollmania.com)|(id.net)|(gamepost.com))\/?(.*)?/igm
			//var _regex:RegExp = new RegExp("app:/PixelConflict.swf");
				//_regex.ignoreCase
			
			return _regex.test(URL)
		}
		
		//-------------------------------------------------
		// Data game
		//-------------------------------------------------
		
		public static var turn				: String	= "ally";
		public static var clicked			: Clicked	= new Clicked();
		public static var focused			: Unit		= null;
		//public static var mode				: String	= "AttackAll";
		public static var scale				: int		= 1;
		public static var confirmation		: int		= 2; 		// 0:false, 1:true, 2:unsigned
		
		public static var totalAlly			:int 		= 0;
		public static var totalMusuh		:int 		= 0;
		
		public static var day				: int		= 1;
		public static var limitDay			: int		= 10;
		public static var isStarted			: Boolean 	= false;	// apakah game sudah dimulai? klo iya maka ubah true di Screen Menu
		
		public static var currLevel			: int 		= 1; 	// level sekarang yang ditampilkan di antarmuka memilih level
		public static var levels_local		: SharedObject;
		public static var levels_online		: Array;
		public static var usingOnlineData	: Boolean	= false;
		public static var onlineSlot		: int      	= 0;
		public static const default_levels	: Array 	= [1, 1, 0, 0, 0, 0, 0, 0, 0, 0];
		
		public static var enemyKilled		: int		= 0;
		public static var APCKilled			: int		= 0;
		
		
		public static var isSounded			: Boolean	= true;
		public static var isCinematic		: Boolean	= true;
		public static var counterChat		: int		= 0;
		// --------------------------------
		// highscore
		// --------------------------------
		
		public static var scoreAllLevels:Array = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
		public static function hitungScore(_sisaAlly:int, _sisaMusuh:int)
		{
			currScore = 0;
			
			if (_sisaMusuh == 0)_sisaMusuh = 1;
			if (_sisaAlly == 0)_sisaAlly = 1;
			
			var _nilaiAlly:int = (_sisaAlly / totalAlly) * 10;
			var _nilaiEnemy:int = (totalMusuh / _sisaMusuh ) * (1 / totalMusuh) * 10;
			var _nilaiWaktu:int = (limitDay / day) * (1 / limitDay) * 10;
			
			scoreAllLevels[currLevel-1] = _nilaiAlly + _nilaiEnemy + _nilaiWaktu;
		}
		
		//-------------------------------------------------
		// Data Per Level
		//-------------------------------------------------
		
		public static var BATTLENAME		: String;
		public static var TIME				: String;
		public static var COMMANDER_ALLY	: String;
		public static var COMMANDER_ENMY	: String;
		
		public static var TILE1				: Array;
		public static var TILE2				: Array;
		public static var OWNERS			: Array;
		public static var UNITS				: Array;
		public static var UNITS_AI			: Array;
		
		public static var WIN_TARGET		: Array;
		public static var WIN_POS			: Array;
		
		
		public static var RECORD			: String;
		public static var WEIGHT			: String;
		
		
		private static function loadLevel(_lvl:Class)
		{
			
			BATTLENAME		= _lvl.BATTLENAME;
			TIME			= _lvl.TIME;
			COMMANDER_ALLY	= _lvl.COMMANDER_ALLY;
			COMMANDER_ENMY	= _lvl.COMMANDER_ENMY;
			
			TILE1			= _lvl.TILE1;
			TILE2 			= _lvl.TILE2;
			OWNERS			= _lvl.OWNERS;
			UNITS			= _lvl.UNITS;
			UNITS_AI		= _lvl.UNITS_AI;
			
			WIN_TARGET		= _lvl.WIN_TARGET;
			WIN_POS			= _lvl.WIN_POS;
			
			RECORD			= _lvl.RECORD;
			WEIGHT			= _lvl.WEIGHT;
			
			limitDay		= _lvl.limitDay;
		}
		
		//-------------------------------------------------
		// fungsi load data level baru
		//-------------------------------------------------
		
		public static function restart()
		{
			counterChat	= 0;
			day			= 1;
			turn		= "ally";
			isCinematic	= true;
		}
		
		public static function load()
		{
			switch(currLevel) {
				case 1: loadLevel(Level1); break;
				case 2: loadLevel(Level2); break;
				case 3: loadLevel(Level3); break;
				case 4: loadLevel(Level4); break;
				case 5: loadLevel(Level5); break;
				case 6: loadLevel(Level6); break;
				case 7: loadLevel(Level7); break;
				case 8: loadLevel(Level8); break;
				case 9: loadLevel(Level9); break;
				case 10: loadLevel(Level10); break;
			}
		}
		
		
		
	}

}