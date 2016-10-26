package gimdata.objects.tutorial 
{
	import al.core.Ast;
	import al.display.SpriteAL;
	import al.objects.Box;
	import gimdata.core.config.Factory;
	import gimdata.objects.unit.UnitDB;
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	/**
	 * ...
	 * @author ...
	 */
	public class DataHelp extends SpriteAL 
	{
		private var m_avatar_infantry		:MovieClip;
		private var m_avatar_mGunner		:MovieClip;
		private var m_avatar_rpg	 		:MovieClip;
		private var m_avatar_jeep			:MovieClip;
		private var m_avatar_apc			:MovieClip;
		private var m_avatar_tank			:MovieClip;
		private var m_avatar_artillery		:MovieClip;
		private var m_avatar_supply			:MovieClip;
		
		private var m_nameTxt		:TextField;
		private var m_descrip		:TextField;
		private var m_dataUnit		:TextField;
		private var m_protection	:TextField;
		private var m_box			:Box;
		private var m_border		:Box;
		private var m_borderLeft	:Box;
		
		private var m_village	:TerrainProtection;
		private var m_forest	:TerrainProtection;
		private var m_mountain	:TerrainProtection;
		private var m_bridge	:TerrainProtection;
		private var m_grass		:TerrainProtection;
		private var m_ground	:TerrainProtection;
		private var m_field		:TerrainProtection;
		private var m_swamp		:TerrainProtection;
		private var m_street	:TerrainProtection;
		private var m_river		:TerrainProtection;
		
		
		public function DataHelp() 
		{
			m_box	= new Box(120, 170, 0xCCCCCC, 0, 0, 0x0, 10);
			m_box.x	= -10;
			m_box.y	= 40;
			addChild(m_box);
			
			m_avatar_infantry 	= new MovieClip(Ast.imgs("unitsAlly", "infantry_idle"), 2);
			m_avatar_infantry.x	= -10;
			m_avatar_infantry.y	= 45;
		
			
			m_avatar_mGunner 	= new MovieClip(Ast.imgs("unitsAlly", "mGunner_idle"), 2);
			m_avatar_mGunner.x	= -10;
			m_avatar_mGunner.y	= 45;
			
			m_avatar_rpg 	= new MovieClip(Ast.imgs("unitsAlly", "rocket_idle"), 2);
			m_avatar_rpg.x	= -10;
			m_avatar_rpg.y	= 45;
			
			m_avatar_jeep 	= new MovieClip(Ast.imgs("unitsAlly", "car_idle"), 2);
			m_avatar_jeep.x	= 0;
			m_avatar_jeep.y	= 45;
			
			m_avatar_apc 	= new MovieClip(Ast.imgs("unitsAlly", "apc_idle"), 2);
			m_avatar_apc.x	= 0;
			m_avatar_apc.y	= 45;
			
			m_avatar_tank 	= new MovieClip(Ast.imgs("unitsAlly", "tank_idle"), 2);
			m_avatar_tank.x	= 0;
			m_avatar_tank.y	= 45;
			
			m_avatar_artillery 		= new MovieClip(Ast.imgs("unitsAlly", "artillery_idle"), 2);
			m_avatar_artillery.x	= 0;
			m_avatar_artillery.y	= 45;
			
			
			m_avatar_supply 	= new MovieClip(Ast.imgs("unitsAlly", "supply_idle"), 2);
			m_avatar_supply.x	= 0;
			m_avatar_supply.y	= 35;
			
			m_nameTxt 			= new TextField(100, 30, "INFANTRY", "verdana", 13, 0xCE0000, true);
			//m_nameTxt.underline	= true;
			m_nameTxt.hAlign	= HAlign.LEFT;
			//m_nameTxt.border 	= true;
			m_nameTxt.y			= 94;
			
			m_descrip 		= new TextField(100, 55, "sahdg adgas jhdgsad", "verdana", 11, 0x0, true);
			m_descrip.hAlign = HAlign.LEFT;
			m_descrip.vAlign = VAlign.TOP;
			//m_descrip.border= true;
			m_descrip.x		= 0;
			m_descrip.y		= 118;
			
			m_border		= new Box(110, 70, 0xE4E4E4, 0, 0, 0, 10);
			m_border.x		= -5;
			m_border.y		= 99;
			
			m_borderLeft	= new Box(7, 175, 0x0, 0,0);
			m_borderLeft.x	= -10;
			m_borderLeft.y	= 45;
			
			m_dataUnit 				= new TextField(100, 35, "", "verdana", 12, 0xCE0000);
			//m_dataUnit.hAlign		= HAlign.LEFT;
			m_dataUnit.vAlign		= VAlign.TOP;
			m_dataUnit.hAlign		= HAlign.LEFT;
			m_dataUnit.bold			= true;
			//m_dataUnit.border 	= true;
			m_dataUnit.x			= 0;
			m_dataUnit.y			= m_descrip.y + m_descrip.height;
			
			m_protection 			= new TextField(200, 30, "Bonus Protection", "verdana", 15, 0xCE0000);
			m_protection.bold		= true;
			//m_protection.border 	= true;
			m_protection.x			= 130;
			m_protection.y			= 40;
			
			// -----------------------------------------------------
			// TERRAIN
			// -----------------------------------------------------
			
			m_village 	= new TerrainProtection("terrain_village", "Building");
			m_village.x	= 130;
			m_village.y	= 75;
			
			m_forest 	= new TerrainProtection("terrain_forest", "Forest");
			m_forest.x	= 175;
			m_forest.y	= 75;
			
			m_mountain 	= new TerrainProtection("terrain_mountain", "Hill");
			m_mountain.x= 220;
			m_mountain.y= 75;
			
			m_bridge 	= new TerrainProtection("terrain_bridge", "Bridge");
			m_bridge.x	= 265;
			m_bridge.y	= 75;
			
			m_grass 	= new TerrainProtection("terrain_grass", "Grass");
			m_grass.x	= 310;
			m_grass.y	= 75;
			
			m_ground 	= new TerrainProtection("terrain_ground", "Ground");
			m_ground.x	= 130;
			m_ground.y	= 140;
			
			m_field 		= new TerrainProtection("terrain_field", "Field");
			m_field.x	= 175;
			m_field.y	= 140;
			
			m_swamp 		= new TerrainProtection("terrain_swamp", "Swamp");
			m_swamp.x	= 220;
			m_swamp.y	= 140;
			
			m_street 		= new TerrainProtection("terrain_street", "Street");
			m_street.x	= 265;
			m_street.y	= 140;
			
			m_river 		= new TerrainProtection("terrain_river", "River");
			m_river.x	= 310;
			m_river.y	= 140;
			
			Starling.juggler.add(m_avatar_infantry);
			Starling.juggler.add(m_avatar_mGunner);
			Starling.juggler.add(m_avatar_rpg);
			Starling.juggler.add(m_avatar_jeep);
			Starling.juggler.add(m_avatar_apc);
			Starling.juggler.add(m_avatar_tank);
			Starling.juggler.add(m_avatar_artillery);
			Starling.juggler.add(m_avatar_supply);
			
			addChild(m_avatar_infantry);
			addChild(m_avatar_mGunner);
			addChild(m_avatar_rpg);
			addChild(m_avatar_jeep);
			addChild(m_avatar_apc);
			addChild(m_avatar_tank);
			addChild(m_avatar_artillery);
			addChild(m_avatar_supply);
			
			addChild(m_border);
			addChild(m_nameTxt);
			addChild(m_descrip);
			addChild(m_dataUnit);
			addChild(m_protection);
			addChild(m_borderLeft);
			
			addChild(m_village);
			addChild(m_forest);
			addChild(m_mountain);
			addChild(m_bridge);
			addChild(m_grass);
			addChild(m_ground);
			addChild(m_field);
			addChild(m_swamp);
			addChild(m_street);
			addChild(m_river);
		}
		
		public function show(_typeUnit:int)
		{
			 m_avatar_infantry		.visible=false;;
			 m_avatar_mGunner		.visible=false;;
			 m_avatar_rpg	 		.visible=false;;
			 m_avatar_jeep			.visible=false;;
			 m_avatar_apc			.visible=false;;
			 m_avatar_tank			.visible=false;;
			 m_avatar_artillery		.visible=false;;
			 m_avatar_supply		.visible=false;;
			 
			 m_avatar_infantry		.pause();
			 m_avatar_mGunner		.pause();
			 m_avatar_rpg	 		.pause();
			 m_avatar_jeep			.pause();
			 m_avatar_apc			.pause();
			 m_avatar_tank			.pause();
			 m_avatar_artillery		.pause();
			 m_avatar_supply		.pause();
			 
			 
			var _db:UnitDB = Factory.createUnitDB(((_typeUnit==8)?9:_typeUnit));
			
			switch(_typeUnit)
			{
				case 1: m_nameTxt.text 	= "RIFLEMAN";
						m_descrip.text	= "Infantry unit with highest HP"
						m_avatar_infantry.visible = true;
						m_avatar_infantry.play();
						break;
				case 2: m_nameTxt.text 	= "M.GUNNER";
						m_descrip.text	= "Infantry unit mounted with machine gun" 
						m_avatar_mGunner.visible = true;
						m_avatar_mGunner.play();
						break;
				case 3: m_nameTxt.text 			= "RPG";
						m_avatar_rpg.visible 	= true;
						m_descrip.text			= "Best unit to destroy armoured unit"
						m_avatar_rpg.play();
						break;
				case 4: m_nameTxt.text 			= "JEEP";
						m_avatar_jeep.visible 	= true;
						m_descrip.text			= "Light armoured unit"
						m_avatar_jeep.play();
						break;
				case 5: m_nameTxt.text 			= "APC";
						m_avatar_apc.visible 	= true;
						m_descrip.text			= "Armoured unit mounted with M.Gun"
						m_avatar_apc.play();
						break;
				case 6: m_nameTxt.text 			= "TANK";
						m_descrip.text			= "Heaviest armoured unit" 
						m_avatar_tank.visible 	= true;
						m_avatar_tank.play();
						break;
				case 7: m_nameTxt.text 				= "ARTILLERY";
						m_descrip.text				= "Best unit to attack from distance"
						m_avatar_artillery.visible 	= true;
						m_avatar_artillery.play();
						break;
				case 8: m_nameTxt.text 			= "SUPPLY";
						m_avatar_supply.visible = true;
						m_descrip.text			= "Unit provides supply to other units"
						m_avatar_supply.play();
						break;		
			}
			
			m_dataUnit.text = ((_db.isDirectAct)?"Direct Attack":"Indirect Attack") + "\nAtk:" + _db.act + " | HP:" + _db.hpFull;
			m_village	.setData(_db.terrainsCover[0]);
			m_forest	.setData(_db.terrainsCover[4]);
			m_mountain	.setData(_db.terrainsCover[6]);
			m_bridge	.setData(_db.terrainsCover[8]);
			m_grass		.setData(_db.terrainsCover[10]);
			m_ground	.setData(_db.terrainsCover[11]);
			m_field		.setData(_db.terrainsCover[12]);
			m_swamp		.setData(_db.terrainsCover[13]);
			m_street	.setData(_db.terrainsCover[15]);
			m_river		.setData(_db.terrainsCover[16]);
			
		}
		
	}

}