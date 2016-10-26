package gimdata.objects.achievements 
{
	import al.core.Ast;
	import al.display.SpriteAL;
	import al.objects.Box;
	import com.greensock.easing.Elastic;
	import com.greensock.easing.Strong;
	import com.greensock.TweenMax;
	import org.osflash.signals.Signal;
	import starling.display.Image;
	import starling.filters.ColorMatrixFilter;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	/**
	 * ...
	 * @author Aldy Ahsandin
	 */
	public class AchievementBox extends SpriteAL 
	{
		private var m_box:Box;
		private var m_pic:Box;
		
		private var m_pic_firstBlood:Image;
		private var m_pic_restart:Image;
		private var m_pic_cinema:Image;
		private var m_pic_newbie:Image;
		private var m_pic_murder:Image;
		private var m_pic_mafia:Image;
		private var m_pic_iamtheman:Image;
		private var m_pic_rambo:Image;
		
		private var m_textAchievement:TextField;
		private var m_textDetail:TextField;
		public var signalEnd:Signal = new Signal();
		
		public function AchievementBox() 
		{
			
			m_box = new Box(250, 74, 0x0, 0, 0, 0);
			m_box.alpha = 0.85;
			addChild(m_box);
			
			m_pic = new Box(64, 64, 0xFFFFFF);
			m_pic.x = 10;
			m_pic.y = 5;
			addChild(m_pic);
			
			m_textAchievement 	= new TextField(150, 30, "Title", "badabom", 20, 0xFFFFFF);
			m_textAchievement.x = m_pic.width + m_pic.x + 10;
			m_textAchievement.hAlign = HAlign.LEFT;
			addChild(m_textAchievement);
			
			m_textDetail = new TextField(150, 20, "detail dari achievement", "verdana", 12, 0xFFFFFF);
			m_textDetail.x = m_pic.width + m_pic.x + 10;
			m_textDetail.hAlign = HAlign.LEFT;
			m_textDetail.vAlign = VAlign.TOP;
			m_textDetail.y	= m_textAchievement.y + m_textAchievement.height;
			
			addChild(m_textDetail);
			
			// ---------------
			
			
		}
		
		public function showAchievements()
		{
			y 		= 5;
			alpha	= 0;
			
			TweenMax.to(this, 0.5, { alpha:1, y:50, ease: Elastic.easeOut } );
			TweenMax.to(this, 0.3, { alpha:0, y: -20, ease:Strong.easeIn, delay:2, onComplete:function() { 
				hideAllPics();
				TweenMax.delayedCall(1, signalEnd.dispatch); 
			}});
		}
		
		public function hideAllPics()
		{
			if (m_pic_firstBlood) m_pic_firstBlood.visible = false;
			if (m_pic_restart) m_pic_restart.visible = false;
			if (m_pic_cinema) m_pic_cinema.visible = false;
			if (m_pic_newbie) m_pic_newbie.visible = false;
			if (m_pic_murder) m_pic_murder.visible = false;
			if (m_pic_mafia) m_pic_mafia.visible = false;
			if (m_pic_iamtheman) m_pic_iamtheman.visible = false;
			if (m_pic_rambo) m_pic_rambo.visible = false;
			
			
		}
		
		// ----------------------------------------
		// achievement
		// ----------------------------------------
		
		public function achievementFirstBlood() // fix
		{
			m_pic_firstBlood = new Image(Ast.img("myBadge", "FirstBlood"));
			m_pic_firstBlood.width = m_pic.width;
			m_pic_firstBlood.height = m_pic.height;
			m_pic_firstBlood.x = m_pic.x;
			m_pic_firstBlood.y = m_pic.y;
			m_pic_firstBlood.visible = false;
			addChild(m_pic_firstBlood);
			
			m_pic_firstBlood.visible = true;
			m_textAchievement.text 	= "FIRST BLOOD";
			m_textDetail.text 		= "The first attack"
		}
		
		public function achievementRestart() // fix
		{
			m_pic_restart = new Image(Ast.img("myBadge", "Restart"));
			m_pic_restart.width = m_pic.width;
			m_pic_restart.height = m_pic.height;
			m_pic_restart.x = m_pic.x;
			m_pic_restart.y = m_pic.y;
			m_pic_restart.visible = false;
			addChild(m_pic_restart);
			
			m_pic_restart.visible = true;
			m_textAchievement.text 	= "RESTART";
			m_textDetail.text 		= "Restart the game"
			
		}
		
		public function achievementCinema() // fix
		{
			m_pic_cinema = new Image(Ast.img("myBadge", "Cinematic"));
			m_pic_cinema.width = m_pic.width;
			m_pic_cinema.height = m_pic.height;
			m_pic_cinema.x = m_pic.x;
			m_pic_cinema.y = m_pic.y;
			m_pic_cinema.visible = false;
			addChild(m_pic_cinema);
			
			m_pic_cinema.visible = true;
			m_textAchievement.text 	= "CINEMA";
			m_textDetail.text 		= "Turn Off Cinema"
			
		}
		
		public function achievementNewbie() // fix
		{
			m_pic_newbie = new Image(Ast.img("myBadge", "Newbie"));
			m_pic_newbie.width = m_pic.width;
			m_pic_newbie.height = m_pic.height;
			m_pic_newbie.x = m_pic.x;
			m_pic_newbie.y = m_pic.y;
			m_pic_newbie.visible = false;
			addChild(m_pic_newbie);
			
			m_pic_newbie.visible = true;
			m_textAchievement.text 	= "NEWBIE";
			m_textDetail.text 		= "Yay!"
			
		}
		
		public function achievementMurder() // fix
		{
			m_pic_murder = new Image(Ast.img("myBadge", "Murder"));
			m_pic_murder.width = m_pic.width;
			m_pic_murder.height = m_pic.height;
			m_pic_murder.x = m_pic.x;
			m_pic_murder.y = m_pic.y;
			m_pic_murder.visible = false;
			addChild(m_pic_murder);
			
			m_pic_murder.visible = true;
			m_textAchievement.text 	= "MURDER";
			m_textDetail.text 		= "Destroy 10 units"
			
		}
		
		public function achievementMafia() // fix
		{
			m_pic_mafia = new Image(Ast.img("myBadge", "Mafia"));
			m_pic_mafia.width = m_pic.width;
			m_pic_mafia.height = m_pic.height;
			m_pic_mafia.x = m_pic.x;
			m_pic_mafia.y = m_pic.y;
			m_pic_mafia.visible = false;
			addChild(m_pic_mafia);
			
			m_pic_mafia.visible = true;
			m_textAchievement.text 	= "MAFIA";
			m_textDetail.text 		= "Destroy 20 units"
			
		}
		
		public function achievementIAmTheMan()  // fix
		{
			m_pic_iamtheman = new Image(Ast.img("myBadge", "IAmTheMan"));
			m_pic_iamtheman.width = m_pic.width;
			m_pic_iamtheman.height = m_pic.height;
			m_pic_iamtheman.x = m_pic.x;
			m_pic_iamtheman.y = m_pic.y;
			m_pic_iamtheman.visible = false;
			addChild(m_pic_iamtheman);
			
			m_pic_iamtheman.visible = true;
			m_textAchievement.text 	= "I AM THE MAN";
			m_textDetail.text 		= "Destroy 5 APCs"
			
		}
		
		public function achievementRambo() // fix
		{
			m_pic_rambo = new Image(Ast.img("myBadge", "Rambo"));
			m_pic_rambo.width = m_pic.width;
			m_pic_rambo.height = m_pic.height;
			m_pic_rambo.x = m_pic.x;
			m_pic_rambo.y = m_pic.y;
			m_pic_rambo.visible = false;
			addChild(m_pic_rambo);
			
			m_pic_rambo.visible = true;
			m_textAchievement.text 	= "RAMBO";
			m_textDetail.text 		= "Perfect!"
			
		}
		
	}

}