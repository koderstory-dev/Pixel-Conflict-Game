package gimdata.core.config 
{
	import al.core.Ast;
	import treefortress.sound.SoundAS;
	import treefortress.sound.SoundManager;
	/**
	 * ...
	 * @author ...
	 */
	public class Music 
	{
		
		public static function init() 
		{
			// tambahkan grup music
			GRUP_LEVEL =  SoundAS.group("level");
			GRUP_LEVEL.addSound(bg_lvl, 	Ast.snd("MenuBG"));
			GRUP_LEVEL.addSound(sfx_pick, 	Ast.snd("MENU_Pick"));
			GRUP_LEVEL.addSound(sfx_select, Ast.snd("MENU_Select"));
			GRUP_LEVEL.addSound(sfx_accept, Ast.snd("MENU_Accept"));
			
			GRUP_GAME =  SoundAS.group("game");
			
			GRUP_GAME.addSound(bg_forest,	Ast.snd("ForestBG"));
			GRUP_GAME.addSound(bg_player,	Ast.snd("PlayerBG"));
			GRUP_GAME.addSound(bg_enemy,	Ast.snd("EnemyBG"));
						
			GRUP_GAME.addSound(sfx_paper,	Ast.snd("GAME_Paper"));
			GRUP_GAME.addSound(sfx_click,	Ast.snd("GAME_Click"));
			GRUP_GAME.addSound(sfx_cteck,	Ast.snd("GAME_Cteck"));
			GRUP_GAME.addSound(sfx_cteck2,	Ast.snd("GAME_Select"));
			GRUP_GAME.addSound(sfx_deselect,Ast.snd("GAME_Deselect"));
			GRUP_GAME.addSound(sfx_cring,	Ast.snd("GAME_Cring"));
			GRUP_GAME.addSound(sfx_creng,	Ast.snd("GAME_Creng"));
			
			GRUP_GAME.addSound(sfx_clock,	Ast.snd("GAME_Clock"));
			GRUP_GAME.addSound(sfx_clock2,	Ast.snd("GAME_Clock2"));
			
			GRUP_GAME.addSound(sfx_yes1,	Ast.snd("GAME_Select_yes1"));
			GRUP_GAME.addSound(sfx_yes2,	Ast.snd("GAME_Select_yes2"));
			GRUP_GAME.addSound(sfx_yes3,	Ast.snd("GAME_Select_yes3"));
			
			GRUP_GAME.addSound(sfx_engine1,	Ast.snd("GAME_Select_engine1"));
			GRUP_GAME.addSound(sfx_engine2,	Ast.snd("GAME_Select_engine2"));
			GRUP_GAME.addSound(sfx_engine3,	Ast.snd("GAME_Select_engine3"));
			
			GRUP_GAME.addSound(sfx_infWalk,	Ast.snd("GAME_sfx_footstep"));
			GRUP_GAME.addSound(sfx_mesWalk,	Ast.snd("GAME_sfx_tankwalk"));
			GRUP_GAME.addSound(sfx_artWalk,	Ast.snd("GAME_sfx_wagon"));
			
			GRUP_GAME.addSound(sfx_battle,	Ast.snd("GAME_sfx_battle"));
			GRUP_GAME.addSound(sfx_radio,	Ast.snd("GAME_sfx_radio"));
			GRUP_GAME.addSound(sfx_radio2,	Ast.snd("GAME_sfx_radio2"));
			
			GRUP_GAME.addSound(sfx_ending,		Ast.snd("GAME_sfx_ending"));
			GRUP_GAME.addSound(sfx_ending2,		Ast.snd("GAME_sfx_ending2"));
			
			
		}
		
		// -------------------------------------------------
		// Single Music
		// -------------------------------------------------
		public static const bg_lvl		:String = "music_level";
		public static const bg_forest	:String = "music_forest";
		public static const bg_player	:String = "music_player";
		public static const bg_enemy	:String = "music_enemy";
		
		// -------------------------------------------------
		// SFX
		// -------------------------------------------------
		public static const sfx_pick	:String	= "sfx_pick";
		public static const sfx_select	:String	= "sfx_select";
		public static const sfx_accept	:String	= "sfx_accept";
		
		public static const sfx_paper	:String	= "sfx_paper";
		public static const sfx_click	:String	= "sfx_click";
		public static const sfx_cteck	:String	= "sfx_cteck";
		public static const sfx_cteck2	:String	= "sfx_cteck2";
		public static const sfx_deselect:String	= "sfx_deselect";
		
		public static const sfx_radio	:String	= "sfx_radio";
		public static const sfx_radio2	:String	= "sfx_radio2";
		
		public static const sfx_cring	:String	= "sfx_cring";
		public static const sfx_creng	:String	= "sfx_creng";
		
		public static const sfx_clock	:String	= "sfx_clock";
		public static const sfx_clock2	:String	= "sfx_clock2";
		
		public static const sfx_yes1	:String	= "sfx_yes1";
		public static const sfx_yes2	:String	= "sfx_yes2";
		public static const sfx_yes3	:String	= "sfx_yes3";
		
		public static const sfx_engine1	:String	= "sfx_engine1";
		public static const sfx_engine2	:String	= "sfx_engine2";
		public static const sfx_engine3	:String	= "sfx_engine3";
		
		public static const sfx_infWalk	:String = "sfx_inf_walk";
		public static const sfx_mesWalk	:String	= "sfx_mes_walk"
		public static const sfx_artWalk	:String	= "sfx_art_walk"
		
		public static const sfx_battle	:String	= "sfx_battle";
		public static const sfx_explsion:String	= "sfx_explosion";
		public static const sfx_die		:String	= "sfx_die";
		
		public static const sfx_ending	:String	= "sfx_ending";
		public static const sfx_ending2	:String	= "sfx_ending2";
		
		
		// -------------------------------------------------
		// GROUP
		// -------------------------------------------------
		public static var GRUP_LEVEL:SoundManager;
		public static var GRUP_GAME	:SoundManager;
		
		public static function mute(_isMute:Boolean)
		{
			if (GRUP_GAME)
			GRUP_GAME.mute 	= _isMute;
			
			if(GRUP_LEVEL)
			GRUP_LEVEL.mute	= _isMute;
		}
		
	}

}