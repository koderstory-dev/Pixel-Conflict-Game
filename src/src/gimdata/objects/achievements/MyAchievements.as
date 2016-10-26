package gimdata.objects.achievements 
{
	import al.core.AL;
	import al.display.SpriteAL;
	import al.objects.Box;
	import gimdata.core.config.Config;
	import gimdata.core.config.Music;
	
	/**
	 * ...
	 * @author Aldy Ahsandin
	 */
	public class MyAchievements extends SpriteAL 
	{
		
		private static var m_block:Box;
		private static var m_achBox:AchievementBox;
		
		public static var queue:Array = new Array();
		
		public function MyAchievements() 
		{
			m_achBox = new AchievementBox();
			m_achBox.pivotX = m_achBox.width / 2;
			m_achBox.pivotY = m_achBox.height / 2;
			m_achBox.x = AL.halfStageWidth;
			m_achBox.y = AL.stageHeight - m_achBox.height;
			m_achBox.signalEnd.add(function() { 
				queue.shift();
				m_isProcess = false;
				if (queue.length > 0) {
					show(queue[0]);
				} else {
					hide();
				}
			});
			addChild(m_achBox);
			
			m_block = new Box(AL.stageWidth, AL.stageHeight, 0xFFFFFF, 0, 0);
			m_block.alpha = 0;
			addChild(m_block);
			
			hide();
		}
		
		// ----------------------------------------------
		// 1. Achievement First Blood - berhasil melakukan serang pertama
		// ----------------------------------------------
		
		public static var isFirstBlood:Boolean = false; 
		public static const ACH_FIRSTBLOOD:String = "firstblood_achievement";
		public static function show_firstBlood()
		{
			if (!isFirstBlood && Config.turn == "ally") {
				
				
				IDI.idnet.achievementsSave('First Blood', '03c3387482a4a135b007');
				isFirstBlood = true;
				queue.push(ACH_FIRSTBLOOD);
				show(ACH_FIRSTBLOOD);
			}
		}
		
		// ----------------------------------------------
		// 2. Achievement newbie - berhasil menyelesaikan level 2
		// -------------f---------------------------------
		
		public static var isNewbie:Boolean = false; 
		public static const ACH_NEWBIE:String = "newbie_achievement";
		public static function show_newbie()
		{
			if (!isNewbie && Config.currLevel == 2)
			{
				IDI.idnet.achievementsSave('Newbie', '5c82ba3c77b33d682031');
				isNewbie = true;
				queue.push(ACH_NEWBIE);
				show(ACH_NEWBIE);
			}
		}
		
		// ----------------------------------------------
		// 3. Restart game
		// ----------------------------------------------
		
		public static var isRestart:Boolean = false;
		public static const ACH_RESTART:String = "restart_achievement";
		public static function show_restart()
		{
			if (!isRestart) {
				IDI.idnet.achievementsSave('Restart', '1c4136403c7b2a11baf4');
				isRestart = true;
				queue.push(ACH_RESTART);
				show(ACH_RESTART);
			}
		}
		
		// ----------------------------------------------
		// 4. Turn off cinematic menu
		// ----------------------------------------------
		
		public static var isCinematic:Boolean = false;
		public static const ACH_CINEMATIC: String = "cinematic_achievement";
		public static function show_cinematic()
		{
			if (!isCinematic)
			{
				IDI.idnet.achievementsSave('Cinema', '0ca6662c9f8493e43119');
				isCinematic =  true;
				queue.push(ACH_CINEMATIC);
				show(ACH_CINEMATIC);
			}
		}
		
		// ----------------------------------------------
		// 5. Membunuh total 10 unit
		// ----------------------------------------------
		public static var isMurder:Boolean = false;
		public static const ACH_MURDER:String = "murder_achievement";
		
		public static function show_murder()
		{
			if (!isMurder)
			{
				IDI.idnet.achievementsSave('Murder', '9e8fd0b85a28fb5262ee');
				isMurder = true;
				queue.push(ACH_MURDER);
				show(ACH_MURDER);
			}
		}
		
		// ----------------------------------------------
		// 6. Membunuh total 20 unit
		// ----------------------------------------------
		public static var isMafia:Boolean = false;
		public static const ACH_MAFIA:String = "mafia_achievement";
		
		public static function show_mafia()
		{
			if (!isMafia)
			{
				IDI.idnet.achievementsSave('Mafia', '81918e0e4699a5598ccc');
				isMafia = true;
				queue.push(ACH_MAFIA);
				show(ACH_MAFIA);
			}
		}
		
		
		// ----------------------------------------------
		// 7. Menghancurkan 5 APC dengan rifleman
		// ----------------------------------------------
		public static var isIAMTHEMAN:Boolean = false;
		public static const ACH_IAMTHEMAN:String = "iamtheman_achievement";
		
		public static function show_iamtheman()
		{
			if (!isIAMTHEMAN)
			{
				IDI.idnet.achievementsSave('I am the Man', 'a7ed19f6ef263bc74ed7');
				isIAMTHEMAN = true;
				queue.push(ACH_IAMTHEMAN);
				show(ACH_IAMTHEMAN);
			}
		}
		
		// ----------------------------------------------
		// 8. Menang dengan hp full
		// ----------------------------------------------
		
		public static var isRambo:Boolean = false;
		public static const ACH_RAMBO:String = "rambo_achievements";
		
		public static function show_rambo()
		{
			if (!isRambo) {
				IDI.idnet.achievementsSave('Rambo', '4742dd715665f22fe0d6');
				isRambo = true;
				queue.push(ACH_RAMBO);
				show(ACH_RAMBO);
			}
		}
		
		private static var m_isProcess:Boolean = false;
		private static function show(_type:String)
		{
			if (queue.length > 0 && !m_isProcess) {
				
				switch(_type)
				{
					case ACH_FIRSTBLOOD	: m_achBox.achievementFirstBlood(); break
					case ACH_RESTART	: m_achBox.achievementRestart(); break;
					case ACH_CINEMATIC	: m_achBox.achievementCinema(); break;
					case ACH_NEWBIE		: m_achBox.achievementNewbie(); break;
					case ACH_MURDER		: m_achBox.achievementMurder(); break;
					case ACH_MAFIA		: m_achBox.achievementMafia(); break;
					case ACH_RAMBO		: m_achBox.achievementRambo(); break;
					case ACH_IAMTHEMAN	: m_achBox.achievementIAmTheMan(); break;
				}
				
				
				m_block.visible = true;
				m_achBox.visible = true;
				m_isProcess = true;
				m_achBox.showAchievements(); // nanti dimasukkan parameter ke achievement					
				Music.GRUP_GAME.playFx(Music.sfx_cring, 0.35);
			}
		}		
		
		private static function hide()
		{
			m_block.visible = false;
			m_achBox.visible = false;
		}
		
		
	}

}