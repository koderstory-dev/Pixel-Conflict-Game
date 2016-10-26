package gimdata.objects.building 
{
	import al.core.Ast;
	import al.display.SpriteAL;
	import com.greensock.easing.Elastic;
	import com.greensock.TweenMax;
	import flash.events.Event;
	import flash.geom.Point;
	import gimdata.core.config.Config;
	import gimdata.objects.unit.Unit;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.text.TextField;
	/**
	 * ...
	 * @author AldyAhsandin
	 */
	public class Owner extends SpriteAL 
	{
		
		//-------------------------------------------------
		// info
		//-------------------------------------------------
		public	var dTypeBuilding	: int = 1;
		public 	var dPos			: Point = new Point;
		public	var dCategory		: String;
		
		//-------------------------------------------------
		// 
		//-------------------------------------------------
		private var m_sign		: Image;
		private var m_text		: TextField;
		private var m_allyFlag	: Image;
		private var m_enemyFlag	: Image;
		private var	dLife		: int	= 10;
		
		// -- jarak naik - turun
		private var y1		: int;
		private var y2		: int;
		
		/**
		 * constructor
		 * @param	_type		tipe building: apakah village? town? atau basecamp?
		 * @param	_x			posisi x
		 * @param	_y			posisi y
		 */
		public function Owner(_type:int, _x:int = 0, _y:int=0) 
		{
			dPos.x			= _x;
			dPos.y			= _y;
			
			y1				= -35;
			y2				= -25;
			m_speed			= 0.5;
			
			
			m_sign			= new Image(Ast.img("uiSigns", "signs_village"));
			m_sign.scaleX	= 0.8;
			m_sign.scaleY	= 0.8;
			m_sign.x		= Config.STANDART / 2 - m_sign.width / 2;
			m_sign.y		= y2
			m_sign.alpha	= 0;
			
			m_allyFlag		= new Image(Ast.img("uiPosition", "allyFlag"));
			m_enemyFlag		= new Image(Ast.img("uiPosition", "enemyFlag"));
			
			m_allyFlag.x	= Config.STANDART / 2 - m_allyFlag.width / 2
			m_allyFlag.y	= y1;
			
			m_enemyFlag.x	= Config.STANDART / 2 - m_enemyFlag.width / 2
			m_enemyFlag.y	= y1;
			
			m_text			= new TextField(Config.STANDART*2, 40, "CAPTURED!", "badabom", 30, 0xFFFF00, true); 
			m_text.scaleX	= 0.5;
			m_text.scaleY	= 0.5;
			//m_text.border	= true;
			m_text.alpha	= 0;
			
			this.x 			= _x * Config.STANDART;
			this.y			= _y * Config.STANDART;
			
			addChild(m_allyFlag);
			addChild(m_enemyFlag);
			addChild(m_sign);
			addChild(m_text);
			
			dTypeBuilding	= _type % 10;
			var _cat:int	= ( _type / 10);
			dCategory 		= ( _cat == 0)? "ally" : "enemy";
			reset_fast(dCategory, 10);
			
			activate();	
		}
		
		private var m_speed:Number;
		override public function update(_dt:Number = -1):void 
		{
			down();
			up();
			
			m_allyFlag.y += m_speed;
			m_enemyFlag.y += m_speed;
		}
		
		
		// ------------------------------------------------------------------------------------------------------
		
		private function down(){ if ((m_allyFlag.y <= y1) || (m_enemyFlag.y <= y1)) m_speed = 0.5;}
		
		private function up(){ if ((m_allyFlag.y >= y2) || (m_enemyFlag.y >= y2)) m_speed = -0.5;}
		
		
		
		// ------------------------------------------------------------------------------------------------------
		
		/**
		 * 
		 * @param	_owner
		 * @param	_attacker
		 * @return	apakah basecamp sudah dikuasai?
		 */
		public function setOwner(_owner:String, _attacker:Unit):Boolean
		{
			if (dTypeBuilding <= 2 && _attacker.dType <= 3) {
				m_text.text = "CAPTURED!"
				dCategory = _owner;
				(dCategory == "ally")? showAllyFlag() : showEnemyFlag();
				return true;
			}
			return false;
		}
		
		/**
		 * 
		 * @param	_owner
		 * @param	_attacker
		 * @return	apakah basecamp sudah dikuasai?
		 */
		public function setOwner_fast(_owner:String, _attacker:Unit):Boolean
		{
			//--------------------------------------------------------------------------------------
			// jika building adalah basecamp maka perlu dihitung defense berdasarkan health unit
			//--------------------------------------------------------------------------------------
			if (dTypeBuilding == 1 && _attacker.dType<=3) {
				dCategory = _owner;
				m_allyFlag.visible 	= (dCategory== "ally")? true:false; 
				m_enemyFlag.visible = (dCategory == "ally")? false:true; 
				return true;
			}
			
			//--------------------------------------------------------------------------------------
			// jika building adalah village maka langsung ganti pemilik
			//--------------------------------------------------------------------------------------
			//else 
			
			// jika sudah dikuasai, ganti view
			if (dTypeBuilding == 2) {
				dCategory 	=  _owner;
				m_allyFlag.visible 	= (dCategory== "ally")? true:false; 
				m_enemyFlag.visible = (dCategory == "ally")? false:true; 
				return true;
			}
			
			return false;
		}
		
		public function reset_fast(_owner:String, _dlife:int):void 
		{
			dCategory 			=  _owner;
			dLife 				= _dlife; 
			
			m_allyFlag.visible 	= (_owner == "ally")? true:false; 
			m_enemyFlag.visible = (_owner == "ally")? false:true; 
			
		}
		
		public function show_reached()
		{
			m_text.text = "REACHED!";
			TweenMax.to(m_text, 0.5, { delay: 1.5, y:y1, alpha:1,scaleX:1, scaleY:1,x:-m_text.width/2,ease:Elastic.easeOut } );
			TweenMax.to(m_text, 0.5, { delay: 2.0, y:y2, alpha:0, scaleX:0.5, scaleY:0.5, x:0,ease:Elastic.easeIn } );
		}
		
		// ------------------------------------------------------------
		private function showAllyFlag() 
		{ 
			dLife 				= 10; 
			dCategory 			= "ally";
			
			m_allyFlag.visible 	= true; 
			m_enemyFlag.visible = false; 
			
			m_allyFlag.alpha	= 0;
			
			TweenMax.to(m_sign, 0.5, { y:y1, alpha:1, ease:Elastic.easeOut } );
			TweenMax.to(m_sign, 0.5, { delay: 1, y:y2, alpha:0, ease:Elastic.easeIn } );
			TweenMax.to(m_text, 0.5, { delay: 1.5, y:y1, alpha:1,scaleX:1, scaleY:1,x:-m_text.width/2,ease:Elastic.easeOut } );
			TweenMax.to(m_text, 0.5, { delay: 2.0, y:y2, alpha:0, scaleX:0.5, scaleY:0.5, x:0,ease:Elastic.easeIn } );
			TweenMax.to(m_allyFlag, 0.5, { delay: 2.5, alpha:1} );
			
		}
		
		private function showEnemyFlag() 
		{ 
			
			// matikan update
			//active				= false;
			
			dLife 				= 10; 
			dCategory 			= "enemy";
			
			m_enemyFlag.visible = true; 
			m_allyFlag.visible 	= false; 
			
			m_enemyFlag.alpha	= 0;
			
			TweenMax.to(m_sign, 0.5, { y:y1, alpha:1, ease:Elastic.easeOut } );
			TweenMax.to(m_sign, 0.5, { delay: 1, y:y2, alpha:0, ease:Elastic.easeIn } );
			TweenMax.to(m_text, 0.5, { delay: 1.5, y:y1, alpha:1, scaleX:1, scaleY:1, x:-m_text.width/2, ease:Elastic.easeOut } );
			TweenMax.to(m_text, 0.5, { delay: 2.0, y:y2, alpha:0, scaleX:0.5, scaleY:0.5, x:0, ease:Elastic.easeIn } );
			TweenMax.to(m_enemyFlag, 0.5, { delay: 2.5, alpha:1} );
			
		}
		
		public function cloneData():OwnerClone
		{
			
			var _ownerClone	: OwnerClone;	
				_ownerClone				= new OwnerClone();
				_ownerClone.dLife		= this.dLife;
				_ownerClone.dCategory	= this.dCategory;
				
			return _ownerClone;
			
		}
	}

}