package gimdata.objects.gui 
{
	import al.core.Ast;
	import al.display.SpriteAL;
	import al.objects.Box;
	import flash.events.Event;
	import gimdata.core.config.Config;
	import starling.display.Image;
	import starling.events.SEvent;
	import starling.text.TextField;
	import starling.utils.HAlign;
	
	/**
	 * ...
	 * @author Aldy Ahsadin
	 */
	public class InfoUnit extends SpriteAL 
	{
		private var m_vBoxUnit		: Box;
		
		private var m_unitType		: TextField;
		private var m_tHP			: TextField;
		private var m_tPow			: TextField;
		private var m_tMov			: TextField;
		private var m_tMorale		: TextField;
		
		
		public function InfoUnit() {
			addEventListener(SEvent.ADDED_TO_STAGE, start)
		}
		
		private function start(e:SEvent):void 
		{
			
			
			m_vBoxUnit			= new Box(120,80, 0x0, 0, 0, 0x0, 20);
			m_vBoxUnit.alpha	= 0.8;
			
			m_unitType			= new TextField( m_vBoxUnit.width-20, 15, "COMBATANT", "vcr", 11, 0xFFFFFF);
			m_unitType.x		= 10
			m_unitType.y		= 5
			m_unitType.border	= true;
			
			m_tHP				= new TextField( m_vBoxUnit.width-10, 15, "HP:10/10", "vcr", 11, 0xFFFFFF);
			m_tHP.x				= 10
			m_tHP.y				= m_unitType.y + m_unitType.height;
			
			
			m_tPow				= new TextField( m_vBoxUnit.width-10, 15, "ATK:10/10", "vcr", 11, 0xFFFFFF);
			m_tPow.x			= 10
			m_tPow.y			= m_tHP.y + m_tHP.height * 3/4;
			
			m_tMov				= new TextField( m_vBoxUnit.width-10, 15, "MOV:10/10", "vcr", 11, 0xFFFFFF);
			m_tMov.x			= 10
			m_tMov.y			= m_tPow.y + m_tPow.height * 3/4;
			
			m_tMorale			= new TextField( m_vBoxUnit.width-10, 15, "READY TO FIGHT", "vcr", 11, 0xFFFFFF);
			m_tMorale.x			= 10
			m_tMorale.y			= m_tMov.y + m_tMov.height;
			
			m_unitType.hAlign	= HAlign.CENTER;;
			m_tHP.hAlign		= HAlign.LEFT;
			m_tPow.hAlign		= HAlign.LEFT;
			m_tMov.hAlign		= HAlign.LEFT;
			m_tMorale.hAlign	= HAlign.LEFT;
			
			addChild(m_vBoxUnit);
			addChild(m_unitType);
			addChild(m_tHP);
			addChild(m_tPow);
			addChild(m_tMov);
			addChild(m_tMorale);
			
		}
		
		public function showInfo()
		{
			if (Config.focused) {
				
				switch(Config.focused.dType) {
					case 1	: m_unitType.text = "RIFLEMAN"; 		break;
					case 2	: m_unitType.text = "M.GUNNER"; 		break;
					case 3	: m_unitType.text = "RPG"; 				break;
					case 4	: m_unitType.text = "JEEP"; 			break;
					case 5	: m_unitType.text = "APC"; 				break;
					case 6	: m_unitType.text = "TANK"; 			break;
					case 7	: m_unitType.text = "ARTILLERY"; 		break;
					case 8	: m_unitType.text = "ARTILLERY TRUCK"; 	break;
					case 9	: m_unitType.text = "SUPPLY";	 		break;
				}
				m_tHP.text 		= "HP  = "+ Config.focused.dHP + "/" + Config.focused.db.hpFull;
				m_tPow.text		= "ATK = " + Config.focused.db.act;
				m_tMov.text		= "MOV = " +( Config.focused.db.move - 1) + " TILES";
				
				// -- morale
				if (Config.focused.db.category != Config.turn)
					Config.focused.imap *= -1;
				
				if (Config.focused.imap > 0.1 && Config.focused.imap <= 1) {
					m_tMorale.text 	= "MORALE - FRESH";
					m_tMorale.color	= 0x48FF48;
				}
				
				else
				if (Config.focused.imap >= 0 && Config.focused.imap < 0.1) {
					m_tMorale.text = "MORALE - STABLE";
					m_tMorale.color	= 0xFEF101;
				}
					
				else
				if (Config.focused.imap >= -0.2 && Config.focused.imap < 0) {
					m_tMorale.text = "MORALE - WORRY";
					m_tMorale.color	= 0xFF661C;
				}
				
				else
				if (Config.focused.imap >= -1 && Config.focused.imap < 0.2) {
					m_tMorale.text = "MORALE - AFRAID";
					m_tMorale.color	= 0xFF2424;
				}
			}
		}
	}

}