package gimdata.objects.gui 
{
	import al.display.SpriteAL;
	import al.objects.Box;
	import gimdata.core.config.Config;
	import starling.text.TextField;
	import starling.utils.HAlign;
	
	/**
	 * ...
	 * @author AldyAhsandin
	 */
	public class InfoTile extends SpriteAL 
	{
		private var m_vBoxUnit		: Box;
		private var m_staticTile	: TextField;
		private var m_tileType		: TextField;
		public function InfoTile() 
		{
			m_vBoxUnit			= new Box(120,50, 0x0, 0, 0, 0x0, 20);
			m_vBoxUnit.alpha	= 0.8;
			
			m_staticTile		= new TextField( m_vBoxUnit.width-20, 15, "TERRAIN TYPE", "vcr", 11, 0xFFFFFF);
			m_staticTile.x		= 10
			m_staticTile.y		= 5
			m_staticTile.border	= true;
			
			m_tileType			= new TextField( m_vBoxUnit.width-20, 15, "TILE", "vcr", 10, 0xFFFFFF);
			m_tileType.x		= 10
			m_tileType.y		= 20
			
			m_tileType.hAlign	= HAlign.LEFT
			
			addChild(m_vBoxUnit);
			addChild(m_staticTile);
			addChild(m_tileType);
		}
		
		public function showInfo()
		{
			switch(Config.clicked.tile.dType) {
					case 0	: m_tileType.text = "NAME: BASECAMP"; 	break;
					case 1	: m_tileType.text = "NAME: BUILDING";	break;
					case 2	: m_tileType.text = "NAME: BUILDING"; 	break;
					case 3	: m_tileType.text = "NAME: BUILDING"; 	break;
					case 4	: m_tileType.text = "NAME: FOREST"; 	break;
					case 5	: m_tileType.text = "NAME: FOREST"; 	break;
					case 6	: m_tileType.text = "NAME: HILL"; 		break;
					case 7	: m_tileType.text = "NAME: HILL"; 		break;
					case 8	: m_tileType.text = "NAME: BRIDGE"; 	break;
					case 9	: m_tileType.text = "NAME: BRIDGE"; 	break;
					case 10	: m_tileType.text = "NAME: GRASS"; 		break;
					case 11	: m_tileType.text = "NAME: GROUND"; 	break;
					case 12	: m_tileType.text = "NAME: FIELD"; 		break;
					case 13	: m_tileType.text = "NAME: SWAMP"; 		break;
					case 14	: m_tileType.text = "NAME: SAND"; 		break;
					case 15	: m_tileType.text = "NAME: STREET"; 	break;
					case 16	: m_tileType.text = "NAME: RIVER"; 		break;
					case 17	: m_tileType.text = "NAME: SEA"; 		break;
			}
		}
	}

}