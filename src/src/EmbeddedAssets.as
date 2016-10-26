package
{
    public class EmbeddedAssets
    {
        /** ATTENTION: Naming conventions!
         *  
         *  - Classes for embedded IMAGES should have the exact same name as the file,
         *    without extension. This is required so that references from XMLs (atlas, bitmap font)
         *    won't break.
         *    
         *  - Atlas and Font XML files can have an arbitrary name, since they are never
         *    referenced by file name.
         * 
         */
		
		// -----------------------------------------------------
		//  AUDIO
		// -----------------------------------------------------
        
		//  BG
		//{
		[Embed(source = "../bin/assets/audio/bg/EnemyBG.mp3")]
		public static const EnemyBG:Class;
		 
		[Embed(source = "../bin/assets/audio/bg/ForestBG.mp3")]
		public static const ForestBG:Class
		 
		[Embed(source = "../bin/assets/audio/bg/MenuBG.mp3")]
		public static const MenuBG:Class;
		
		[Embed(source = "../bin/assets/audio/bg/PlayerBG.mp3")]
		public static const PlayerBG:Class;
		//}
		 
		//  SFX
		//{
		 
		[Embed(source = "../bin/assets/audio/sfx/GAME_Click.mp3")]
		public static const GAME_Click:Class;
		
		[Embed(source = "../bin/assets/audio/sfx/GAME_Clock.mp3")]
		public static const GAME_Clock:Class;
		
		[Embed(source = "../bin/assets/audio/sfx/GAME_Clock2.mp3")]
		public static const GAME_Clock2:Class;
		
		[Embed(source = "../bin/assets/audio/sfx/GAME_Creng.mp3")]
		public static const GAME_Creng:Class;
		
		[Embed(source = "../bin/assets/audio/sfx/GAME_Cring.mp3")]
		public static const GAME_Cring:Class;
		
		[Embed(source = "../bin/assets/audio/sfx/GAME_Cteck.mp3")]
		public static const GAME_Cteck:Class;
		
		[Embed(source = "../bin/assets/audio/sfx/GAME_Deselect.mp3")]
		public static const GAME_Deselect:Class;
		
		[Embed(source = "../bin/assets/audio/sfx/GAME_Paper.mp3")]
		public static const GAME_Paper:Class;
		
		[Embed(source = "../bin/assets/audio/sfx/GAME_Select.mp3")]
		public static const GAME_Select:Class;
		
		[Embed(source = "../bin/assets/audio/sfx/GAME_Select_cannon1.mp3")]
		public static const GAME_Select_canon1:Class;
		
		[Embed(source = "../bin/assets/audio/sfx/GAME_Select_engine1.mp3")]
		public static const GAME_Select_engine1:Class
		
		[Embed(source = "../bin/assets/audio/sfx/GAME_Select_engine2.mp3")]
		public static const GAME_Select_engine2:Class
		
		[Embed(source = "../bin/assets/audio/sfx/GAME_Select_engine3.mp3")]
		public static const GAME_Select_engine3:Class
		
		[Embed(source = "../bin/assets/audio/sfx/GAME_Select_yes1.mp3")]
		public static const GAME_Select_yes1:Class
		
		[Embed(source = "../bin/assets/audio/sfx/GAME_Select_yes2.mp3")]
		public static const GAME_Select_yes2:Class
		
		[Embed(source = "../bin/assets/audio/sfx/GAME_Select_yes3.mp3")]
		public static const GAME_Select_yes3:Class
		
		[Embed(source = "../bin/assets/audio/sfx/GAME_sfx_battle.mp3")]
		public static const GAME_sfx_battle:Class
		
		[Embed(source = "../bin/assets/audio/sfx/GAME_sfx_ending.mp3")]
		public static const GAME_sfx_ending:Class
		
		[Embed(source = "../bin/assets/audio/sfx/GAME_sfx_ending2.mp3")]
		public static const GAME_sfx_ending2:Class
		
		[Embed(source = "../bin/assets/audio/sfx/GAME_sfx_explosion.mp3")]
		public static const GAME_sfx_explosion:Class
		
		[Embed(source = "../bin/assets/audio/sfx/GAME_sfx_footstep.mp3")]
		public static const GAME_sfx_footstep:Class
		
		[Embed(source = "../bin/assets/audio/sfx/GAME_sfx_tankwalk.mp3")]
		public static const GAME_sfx_tankwalk:Class
		
		[Embed(source = "../bin/assets/audio/sfx/GAME_sfx_wagon.mp3")]
		public static const GAME_sfx_wagon:Class
		
		[Embed(source = "../bin/assets/audio/sfx/GAME_sfx_radio.mp3")]
		public static const GAME_sfx_radio:Class
		
		[Embed(source = "../bin/assets/audio/sfx/GAME_sfx_radio2.mp3")]
		public static const GAME_sfx_radio2:Class
		
		[Embed(source = "../bin/assets/audio/sfx/MENU_Accept.mp3")]
		public static const MENU_Accept:Class;
		
		[Embed(source = "../bin/assets/audio/sfx/MENU_Pick.mp3")]
		public static const MENU_Pick:Class;
		
		[Embed(source = "../bin/assets/audio/sfx/MENU_Select.mp3")]
		public static const MENU_Select:Class;
		
		//}
		
		// -----------------------------------------------------
		//  FONT
		// -----------------------------------------------------
        //{
		[Embed(source = "../bin/assets/fonts/badabom.fnt", mimeType = "application/octet-stream")]
		public static const badabom_fnt:Class;
		
		[Embed(source = "../bin/assets/fonts/badabom.png")]
		public static const badabom:Class;
		
		[Embed(source = "../bin/assets/fonts/vcr.fnt", mimeType = "application/octet-stream")]
		public static const vcr_fnt:Class;
		
		[Embed(source = "../bin/assets/fonts/vcr.png")]
		public static const vcr:Class;
		
		//}
		
		
		
		// -----------------------------------------------------
		//  System
		// -----------------------------------------------------
		//{
        
		[Embed(source="../bin/assets/textures/menuScreen/myBadge.png")]
		public static const myBadge:Class;
		
		[Embed(source = "../bin/assets/textures/menuScreen/myBadge.xml", mimeType="application/octet-stream")]
		public static const myBadge_xml:Class;
		
		[Embed(source = "../bin/system/bgBattle.jpg")]
		public static const bgBattle:Class;
		
		[Embed(source = "../bin/system/bgEffect.jpg")]
		public static const bgEffect:Class;
		
		[Embed(source = "../bin/system/bgPaper.jpg")]
		public static const bgPaper:Class;
		
		[Embed(source = "../bin/system/borderH.png")]
		public static const borderH:Class;
		
		[Embed(source = "../bin/system/borderV.png")]
		public static const borderV:Class;
		
		[Embed(source = "../bin/system/sponsorLogo.png")]
		public static const sponsorLogo:Class;
		
		[Embed(source = "../bin/system/developerLogo.png")]
		public static const developerLogo:Class;
		
		//}
		
		// -----------------------------------------------------
		//  TEXTURES - BattleScreen
		// -----------------------------------------------------
        //{
		[Embed(source = "../bin/assets/textures/battleScreen/btnBook2.png")]
		public static const btnBook2:Class;
		
		[Embed(source = "../bin/assets/textures/battleScreen/notif.png")]
		public static const notif:Class;
		
		
		
		[Embed(source="../bin/assets/textures/battleScreen/tile1.png")]
		public static const tile1:Class;
		
		[Embed(source = "../bin/assets/textures/battleScreen/tile1.xml", mimeType="application/octet-stream")]
		public static const tile1_xml:Class;
		
		[Embed(source="../bin/assets/textures/battleScreen/tile2.png")]
		public static const tile2:Class;
		
		[Embed(source = "../bin/assets/textures/battleScreen/tile2.xml", mimeType="application/octet-stream")]
		public static const tile2_xml:Class;
		
		
		
		[Embed(source="../bin/assets/textures/battleScreen/uiBattle.png")]
		public static const uiBattle:Class;
		
		[Embed(source = "../bin/assets/textures/battleScreen/uiBattle.xml", mimeType="application/octet-stream")]
		public static const uiBattle_xml:Class;
		
		[Embed(source="../bin/assets/textures/battleScreen/uiConfirmation.png")]
		public static const uiConfirmation:Class;
		
		[Embed(source = "../bin/assets/textures/battleScreen/uiConfirmation.xml", mimeType="application/octet-stream")]
		public static const uiConfirmation_xml:Class;
		
		[Embed(source="../bin/assets/textures/battleScreen/uiPosition.png")]
		public static const uiPosition:Class;
		
		[Embed(source = "../bin/assets/textures/battleScreen/uiPosition.xml", mimeType="application/octet-stream")]
		public static const uiPosition_xml:Class;
		
		[Embed(source="../bin/assets/textures/battleScreen/uiSigns.png")]
		public static const uiSigns:Class;
		
		[Embed(source = "../bin/assets/textures/battleScreen/uiSigns.xml", mimeType="application/octet-stream")]
		public static const uiSigns_xml:Class;
		
		[Embed(source="../bin/assets/textures/battleScreen/uiTileStatus.png")]
		public static const uiTileStatus:Class;
		
		[Embed(source = "../bin/assets/textures/battleScreen/uiTileStatus.xml", mimeType="application/octet-stream")]
		public static const uiTileStatus_xml:Class;
		
		[Embed(source="../bin/assets/textures/battleScreen/unitsAlly.png")]
		public static const unitsAlly:Class;
		
		[Embed(source = "../bin/assets/textures/battleScreen/unitsAlly.xml", mimeType="application/octet-stream")]
		public static const unitsAlly_xml:Class;
		
		
		[Embed(source="../bin/assets/textures/battleScreen/unitsEnemy.png")]
		public static const unitsEnemy:Class;
		
		[Embed(source = "../bin/assets/textures/battleScreen/unitsEnemy.xml", mimeType="application/octet-stream")]
		public static const unitsEnemy_xml:Class;
		
		//}
		
		// -----------------------------------------------------
		//  TEXTURES - Cinematic BG
		// -----------------------------------------------------
        //{
		
		[Embed(source = "../bin/assets/textures/cinematic/bg/cinBG.png")]
		public static const cinBG:Class;
		
		[Embed(source = "../bin/assets/textures/cinematic/bg/cinBG.xml", mimeType = "application/octet-stream")]
		public static const cinBG_xml:Class;
		//}
		
		// -----------------------------------------------------
		//  TEXTURES - Cinematic UNIT
		// -----------------------------------------------------
        
		//{
		[Embed(source = "../bin/assets/textures/cinematic/units/ally/cinematicArmour.png")]
		public static const cinematicArmour:Class;
		
		[Embed(source = "../bin/assets/textures/cinematic/units/ally/cinematicArmour.xml", mimeType="application/octet-stream")]
		public static const cinematicArmour_xml:Class;
		
		[Embed(source = "../bin/assets/textures/cinematic/units/ally/cinematicArtillery.png")]
		public static const cinematicArtillery:Class;
		
		[Embed(source = "../bin/assets/textures/cinematic/units/ally/cinematicArtillery.xml", mimeType="application/octet-stream")]
		public static const cinematicArtillery_xml:Class;
		
		[Embed(source = "../bin/assets/textures/cinematic/units/ally/cinematicCar.png")]
		public static const cinematicCar:Class;
		
		[Embed(source = "../bin/assets/textures/cinematic/units/ally/cinematicCar.xml", mimeType="application/octet-stream")]
		public static const cinematicCar_xml:Class;
		
		[Embed(source = "../bin/assets/textures/cinematic/units/ally/cinematicInfantry.png")]
		public static const cinematicInfantry:Class;
		
		[Embed(source = "../bin/assets/textures/cinematic/units/ally/cinematicInfantry.xml", mimeType="application/octet-stream")]
		public static const cinematicInfantry_xml:Class;
		
		[Embed(source = "../bin/assets/textures/cinematic/units/ally/cinematicMGunner.png")]
		public static const cinematicMGunner:Class;
		
		[Embed(source = "../bin/assets/textures/cinematic/units/ally/cinematicMGunner.xml", mimeType="application/octet-stream")]
		public static const cinematicMGunner_xml:Class
		
		[Embed(source = "../bin/assets/textures/cinematic/units/ally/cinematicRocket.png")]
		public static const cinematicRocket:Class
		
		[Embed(source = "../bin/assets/textures/cinematic/units/ally/cinematicRocket.xml", mimeType="application/octet-stream")]
		public static const cinematicRocket_xml :Class
		
		
		[Embed(source = "../bin/assets/textures/cinematic/units/enemy/cinematicArmourE.png")]
		public static const cinematicArmourE:Class;
		
		[Embed(source = "../bin/assets/textures/cinematic/units/enemy/cinematicArmourE.xml", mimeType="application/octet-stream")]
		public static const cinematicArmourE_xml:Class;
		
		[Embed(source = "../bin/assets/textures/cinematic/units/enemy/cinematicArtilleryE.png")]
		public static const cinematicArtilleryE:Class;
		
		[Embed(source = "../bin/assets/textures/cinematic/units/enemy/cinematicArtilleryE.xml", mimeType="application/octet-stream")]
		public static const cinematicArtilleryE_xml:Class;
		
		[Embed(source = "../bin/assets/textures/cinematic/units/enemy/cinematicCarE.png")]
		public static const cinematicCarE:Class;
		
		[Embed(source = "../bin/assets/textures/cinematic/units/enemy/cinematicCarE.xml", mimeType="application/octet-stream")]
		public static const cinematicCarE_xml:Class;
		
		[Embed(source = "../bin/assets/textures/cinematic/units/enemy/cinematicInfantryE.png")]
		public static const cinematicInfantryE:Class;
		
		[Embed(source = "../bin/assets/textures/cinematic/units/enemy/cinematicInfantryE.xml", mimeType="application/octet-stream")]
		public static const cinematicInfantryE_xml:Class;
		
		[Embed(source = "../bin/assets/textures/cinematic/units/enemy/cinematicMGunnerE.png")]
		public static const cinematicMGunnerE:Class;
		
		[Embed(source = "../bin/assets/textures/cinematic/units/enemy/cinematicMGunnerE.xml", mimeType="application/octet-stream")]
		public static const cinematicMGunnerE_xml:Class
		
		[Embed(source = "../bin/assets/textures/cinematic/units/enemy/cinematicRocketE.png")]
		public static const cinematicRocketE:Class
		
		[Embed(source = "../bin/assets/textures/cinematic/units/enemy/cinematicRocketE.xml", mimeType="application/octet-stream")]
		public static const cinematicRocketE_xml :Class
		
		//}
		
		// -----------------------------------------------------
		//  FX
		// -----------------------------------------------------
        
		//{
		[Embed(source = "../bin/assets/textures/fx/ash.pex", mimeType = "application/octet-stream")]
		public static const ash:Class;
		
		[Embed(source = "../bin/assets/textures/fx/burningHouseRight.pex", mimeType = "application/octet-stream")]
		public static const burningHouseRight:Class;
		
		[Embed(source = "../bin/assets/textures/fx/dust.pex", mimeType = "application/octet-stream")]
		public static const dust:Class;
		
		[Embed(source = "../bin/assets/textures/fx/explosion.pex", mimeType = "application/octet-stream")]
		public static const explosion:Class;
		
		[Embed(source = "../bin/assets/textures/fx/fire.pex", mimeType = "application/octet-stream")]
		public static const fire:Class;
		
		[Embed(source = "../bin/assets/textures/fx/smokeScreen.pex", mimeType = "application/octet-stream")]
		public static const smokeScreen:Class;
		
		[Embed(source = "../bin/assets/textures/fx/taA.png")]
		public static const taA:Class;
		
		[Embed(source = "../bin/assets/textures/fx/taA.xml", mimeType="application/octet-stream")]
		public static const taA_xml:Class;
		
		//}
		
		// -----------------------------------------------------
		//  Help Tutorial
		// -----------------------------------------------------
        
		//{
		[Embed(source = "../bin/assets/textures/help_tutorial/helpTerrain.png")]
		public static const helpTerrain:Class;
		
		[Embed(source="../bin/assets/textures/help_tutorial/helpTerrain.xml", mimeType="application/octet-stream")]
		public static const helpTerrain_xml:Class;
		
		[Embed(source="../bin/assets/textures/help_tutorial/window_form.png")]
		public static const window_form :Class;
		
		// =========================
		// Level 1
		// =========================
		[Embed(source = "../bin/assets/textures/help_tutorial/level1/tut1_1.png")]
		public static const tut1_1:Class;
		
		[Embed(source = "../bin/assets/textures/help_tutorial/level1/tut1_2.png")]
		public static const tut1_2:Class;
		
		
		// =========================
		// Level 2
		// =========================
		[Embed(source = "../bin/assets/textures/help_tutorial/level2/tut2_1.png")]
		public static const tut2_1:Class;
		
		[Embed(source = "../bin/assets/textures/help_tutorial/level2/tut2_2.png")]
		public static const tut2_2:Class;
		
		// =========================
		// Level 3
		// =========================
		[Embed(source = "../bin/assets/textures/help_tutorial/level3/tut3_1.png")]
		public static const tut3_1:Class;
		
		[Embed(source = "../bin/assets/textures/help_tutorial/level3/tut3_2.png")]
		public static const tut3_2:Class;
		
		
		//[Embed(source = "../bin/assets/textures/help_tutorial/level3/tut3_3.png")]
		//public static const tut3_3:Class;
		//
		// =========================
		// Level 4
		// =========================
		[Embed(source = "../bin/assets/textures/help_tutorial/level4/tut4_1.png")]
		public static const tut4_1:Class;
		
		[Embed(source = "../bin/assets/textures/help_tutorial/level4/tut4_2.png")]
		public static const tut4_2:Class;
		
				
		// =========================
		// Level 5
		// =========================
		[Embed(source = "../bin/assets/textures/help_tutorial/level5/tut5_1.png")]
		public static const tut5_1:Class;
		
		[Embed(source = "../bin/assets/textures/help_tutorial/level5/tut5_2.png")]
		public static const tut5_2:Class;
		
		
		// =========================
		// Level 6
		// =========================
		[Embed(source = "../bin/assets/textures/help_tutorial/level6/tut6_1.png")]
		public static const tut6_1:Class;
		
		[Embed(source = "../bin/assets/textures/help_tutorial/level6/tut6_2.png")]
		public static const tut6_2:Class;
		
		
		// =========================
		// Level 7
		// =========================
		[Embed(source = "../bin/assets/textures/help_tutorial/level7/tut7_1.png")]
		public static const tut7_1:Class;
		
		[Embed(source = "../bin/assets/textures/help_tutorial/level7/tut7_2.png")]
		public static const tut7_2:Class;
		
		
		// =========================
		// Level 8
		// =========================
		[Embed(source = "../bin/assets/textures/help_tutorial/level8/tut8_1.png")]
		public static const tut8_1:Class;
		
		[Embed(source = "../bin/assets/textures/help_tutorial/level8/tut8_2.png")]
		public static const tut8_2:Class;
		
		
		// =========================
		// Level 9
		// =========================
		[Embed(source = "../bin/assets/textures/help_tutorial/level9/tut9_1.png")]
		public static const tut9_1:Class;
		
		[Embed(source = "../bin/assets/textures/help_tutorial/level9/tut9_2.png")]
		public static const tut9_2:Class;
		
		
		// =========================
		// Level 10
		// =========================
		[Embed(source = "../bin/assets/textures/help_tutorial/level10/tut10_1.png")]
		public static const tut10_1:Class;
		
		[Embed(source = "../bin/assets/textures/help_tutorial/level10/tut10_2.png")]
		public static const tut10_2:Class;
		
		
		
		
		//}
		
		// -----------------------------------------------------
		//  Menu Screen
		// -----------------------------------------------------
        //{
		
		[Embed(source = "../bin/assets/textures/menuScreen/bgMenu.png")]
		public static const bgMenu:Class;
		
		[Embed(source = "../bin/assets/textures/menuScreen/bgGameOver.png")]
		public static const bgGameOver:Class;
		
		[Embed(source = "../bin/assets/textures/menuScreen/bgMenu.xml", mimeType="application/octet-stream")]
		public static const bgMenu_xml:Class;
		
		[Embed(source = "../bin/assets/textures/menuScreen/btnPlayGame.png")]
		public static const btnPlayGame:Class;
		
		[Embed(source = "../bin/assets/textures/menuScreen/direction.png")]
		public static const direction:Class;
		
		[Embed(source = "../bin/assets/textures/menuScreen/direction.xml", mimeType="application/octet-stream")]
		public static const direction_xml:Class;
		
		[Embed(source = "../bin/assets/textures/menuScreen/levelPhoto.png")]
		public static const levelPhoto:Class;
		
		[Embed(source = "../bin/assets/textures/menuScreen/levelPhoto.xml", mimeType="application/octet-stream")]
		public static const levelPhoto_xml:Class;
		
		[Embed(source = "../bin/assets/textures/menuScreen/title.png")]
		public static const title:Class;
		
		[Embed(source = "../bin/assets/textures/menuScreen/uiMenu.png")]
		public static const uiMenu:Class;
		
		[Embed(source = "../bin/assets/textures/menuScreen/uiMenu.xml", mimeType="application/octet-stream")]
		public static const uiMenu_xml:Class;
		
		[Embed(source = "../bin/assets/textures/menuScreen/idnet_logo.png")]
		public static const idnet_logo:Class;
		
		[Embed(source="../bin/assets/textures/battleScreen/cursor_guide.png")]
		public static const cursor_guide:Class
		
		
		
		// level photo
		[Embed(source="../bin/assets/textures/menuScreen/level6.png")]
		public static const level6:Class;
		
		[Embed(source="../bin/assets/textures/menuScreen/level8.png")]
		public static const level8:Class;
		
		[Embed(source="../bin/assets/textures/menuScreen/level9.png")]
		public static const level9:Class;
		
		[Embed(source="../bin/assets/textures/menuScreen/level10.png")]
		public static const level10:Class;
		
		//}
		
		// -----------------------------------------------------
		//  Report Screen
		// -----------------------------------------------------
		
		//{
		[Embed(source = "../bin/assets/textures/reportScreen/flags.png")]
		public static const flags:Class;
		
		[Embed(source = "../bin/assets/textures/reportScreen/flags.xml", mimeType="application/octet-stream")]
		public static const flags_xml:Class;
		
		[Embed(source = "../bin/assets/textures/reportScreen/pictureReport.png")]
		public static const pictureReport:Class;
		
		[Embed(source = "../bin/assets/textures/reportScreen/pictureReport.xml", mimeType="application/octet-stream")]
		public static const puctureReport_xml:Class;
		
		//}
		
    }
}