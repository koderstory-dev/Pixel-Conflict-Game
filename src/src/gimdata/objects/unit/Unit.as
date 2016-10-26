package gimdata.objects.unit 
{
	import al.core.AL;
	import al.core.Ast;
	import al.display.SpriteAL;
	import al.misc.StackFSM;
	import al.objects.Box;
	import al.objects.HealthBar;
	import aldyahsn.air.objects.HealthBar;
	import com.greensock.easing.Elastic;
	import com.greensock.TweenMax;
	import ctf.config.Factory;
	import flash.geom.Point;
	import gimdata.core.config.Config;
	import gimdata.core.config.Factory;
	import gimdata.core.constant.Goal;
	import org.osflash.signals.Signal;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.filters.ColorMatrixFilter;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	import starling.events.SEvent;
	/**
	 * ...
	 * @author AldyAhsn
	 */
	public class Unit extends SpriteAL
	{
		
		//-------------------------------------------------
		// display
		//-------------------------------------------------
		private	var m_IdleR		: MovieClip;
		private	var m_IdleL		: MovieClip;
		private	var m_WalkR		: MovieClip;
		private	var m_WalkL		: MovieClip;
		private	var m_Health	: TextField;
		private var m_Flag		: Image;
		
		//-------------------------------------------------
		// fix info
		//-------------------------------------------------
		public var db			: UnitDB
		public var dType		: int;
		public var isFaceRight	: Boolean;
		
		//-------------------------------------------------
		// dynamic info
		//-------------------------------------------------
		public 	var dPos		: Point;
		public  var dModeAI		: String;
		public  var dAI_param	: *;
		public 	var isThisTarget:Boolean = false;
		public	var winPos		: Point = new Point( -1, -1);
		public 	var imap		: Number;
		
		//-------------------------------------------------
		// data privat
		//-------------------------------------------------
		private var _dHP		: int;
		private var m_posY		: int;	// posisi teks health
		private	var m_isActive	: Boolean = true;
		
		private var _dIM		: Vector.<Number>
		private var _inf		: Array;
		
		//-------------------------------------------------
		// signal
		//-------------------------------------------------
		public	var sign_remove	: Signal = new Signal(Unit);
		
		public function Unit(_type:int, _pos:Point) 
		{
			//-------------------------------------------
			//init fix info
			//-------------------------------------------
			dType				= _type%10;
			db					= Factory.createUnitDB(_type);
			
			//-------------------------------------------
			//init dynamic info
			//-------------------------------------------
			dPos				= _pos;
			_dHP				= db.hpFull;
			
			
			//-------------------------------------------
			//influence map 
			//-------------------------------------------
			_dIM				= new Vector.<Number>();
			_inf				= new Array();
			
			for (var i:int = 0; i < (Config.WIDTH * Config.HEIGHT); i++ )
			_dIM.push( -1);
			
			for (var i:int = 0; i < db.move; i++ )
			_inf.push(1 - (i * (1.0 / db.move)));
			
			//-------------------------------------------
			//init display
			//-------------------------------------------
			m_IdleR				= Factory.createUnit(_type, ((_type<10)?true:false), "R", "I");
			m_IdleL				= Factory.createUnit(_type, ((_type<10)?true:false), "L", "I");
			m_WalkR				= Factory.createUnit(_type, ((_type<10)?true:false), "R", "W");
			m_WalkL				= Factory.createUnit(_type, ((_type<10)?true:false), "L", "W");
			
			m_IdleR.scaleX		= 0.9;
			m_IdleR.scaleY		= 0.9;
			m_IdleL.scaleX		= 0.9;
			m_IdleL.scaleY		= 0.9;
			
			m_WalkR.scaleX		= 0.9;
			m_WalkR.scaleY		= 0.9;
			m_WalkL.scaleX		= 0.9;
			m_WalkL.scaleY		= 0.9;
			
			
			var _center:int 	= Config.STANDART / 2;
			m_IdleR.x 			= _center - m_IdleR.width / 2;
			m_IdleL.x 			= _center - m_IdleL.width / 2;
			m_WalkR.x 			= _center - m_WalkR.width / 2;
			m_WalkL.x 			= _center - m_WalkL.width / 2;
			
			m_IdleR.y 			= _center - m_IdleR.height / 2 - 10;
			m_IdleL.y 			= _center - m_IdleL.height / 2 - 10;
			m_WalkR.y 			= _center - m_WalkR.height / 2 - 10;
			m_WalkL.y 			= _center - m_WalkL.height / 2 - 10;
			
			m_IdleL.scaleX		= -0.9;
			m_IdleL.x			+= m_IdleL.width;
			m_WalkL.scaleX		= -0.9;
			m_WalkL.x			+= m_WalkL.width;
			
			
			// display health. Muncul ketika habis battle
			m_Health		= new TextField(Config.STANDART * Config.scale,
											Config.STANDART * Config.scale,
											String(db.hpFull),
											"vcr",
											20, 0xFFFFFF);
			
			
			m_Health.hAlign = HAlign.LEFT;
			m_Health.vAlign = VAlign.TOP;
			m_Health.alpha 	= 0;
			m_posY			= m_Health.y;
			
			//m_Flag = (db.category == "ally")? new Image(Ast.img("flags", "ally")): new Image(Ast.img("flags", "enemy"));
			//m_Flag.y			= - m_Flag.height/10;
			
			//-------------------------------------------
			//
			//-------------------------------------------
			
			Starling.juggler.add(m_IdleR);
			Starling.juggler.add(m_IdleL);
			Starling.juggler.add(m_WalkR);
			Starling.juggler.add(m_WalkL);
			
			
			//addChild(m_Flag);
			addChild(m_IdleR);	
			addChild(m_IdleL);	
			addChild(m_WalkR);	
			addChild(m_WalkL);	
			addChild(m_Health);
			
			(db.category == "ally")?showIdle_Right(): showIdle_Left();
			
			active = true;
			AL.updater.add(this);
		}
		
		
		public function cloneData():UnitClone
		{
			
			var _dataUnitClone	: UnitClone;	
				_dataUnitClone				= new UnitClone();
				_dataUnitClone.dHP			= this.dHP;
				_dataUnitClone.dPos			= this.dPos;
				_dataUnitClone.isFaceRight	= isFaceRight;
			
			return _dataUnitClone;
			
		}
		
		//-------------------------------------------------
		// HP
		//-------------------------------------------------
		
		public function setFast_dHP(_value:int){
			_dHP = (_value >= db.hpFull)? db.hpFull: _value;
		}
		
		public function get dHP():int {
			return _dHP;
		}
		
		public function set dHP(_value:int):void {
			
			// initial nilai baru
			_value			= (_value >= db.hpFull)? db.hpFull: _value;
			var _diffHP:int	= _value - _dHP; // cari selisih
			
			// display selisih text
			if (_diffHP != 0)
				m_Health.text = (_diffHP >= 0)?"+" + _diffHP:_diffHP;
			else
				m_Health.text = "";
			
			TweenMax.to(m_Health, 0.5, 	{ alpha:1, 	delay: 1, y:m_Health.y-10, ease:Elastic.easeOut } );
			TweenMax.to(m_Health, 0.5, 	{ alpha: 0, delay: 2.5, onComplete:function() { m_Health.y = m_posY } } );
			
			// update hp menjadi nilai baru
			_dHP	 		= _value;
			if (_dHP <= 0) {
				if (dType == 5 && Config.turn == "ally")
					Config.APCKilled++;
				sign_remove.dispatch(this);
			}
			
			
			
		}
		
		//-------------------------------------------------
		// Fungsi Arah
		//-------------------------------------------------
		public 	function  hideAll() {
			m_IdleR.visible = false;
			m_IdleL.visible = false;
			m_WalkR.visible = false;
			m_WalkL.visible = false;
		}
		
		public	function showIdle_Right()
		{
			hideAll();
			m_IdleR.visible = true;
			isFaceRight		= true;
		}
		public	function showIdle_Left()
		{
			hideAll();
			m_IdleL.visible = true;
			isFaceRight		= false;
		}
		public	function showWalk_Right()
		{
			hideAll();
			m_WalkR.visible = true;
			m_WalkR.fps		= 10;
			isFaceRight		= true;
		}
		public	function showWalk_Left()
		{
			hideAll();
			m_WalkL.visible = true;
			m_WalkL.fps		= 10;
			isFaceRight		= false;
		}
		
		//-------------------------------------------------
		// Fungsi Influence Map
		//-------------------------------------------------
		
		private function recursIM(_x:int, _y:int, _range:int){
			if ( !((_x >= 0) && (_x < Config.WIDTH)	&&	
				 (_y >= 0) && (_y < Config.HEIGHT)) ||  
				 ( _range <= 0 )) 
				return 1;			
			else {
				
				if ( _dIM[_x + _y * Config.WIDTH] < _range )
				_dIM[_x + _y * Config.WIDTH] = _range;
				
				recursIM(_x + 1, _y, _range-1);
				recursIM(_x - 1, _y, _range-1);
				recursIM(_x, _y + 1, _range-1);
				recursIM(_x, _y - 1, _range-1);		
			}
		}
		public 	function get dIM():Vector.<Number> {
			return _dIM;
		}
		
		public 	function  makeIM() {
			recursIM(dPos.x, dPos.y, db.move);
			for (var i:int = 0; i < _dIM.length; i++ ) 
			_dIM[i] = (_dIM[i] != -1)? (_dIM[i] *= (1 / db.move)):0;
			
		}
		
		//-------------------------------------------------
		// Fungsi Utama
		//-------------------------------------------------
		override public function update(_dt:Number = -1):void 
		{
			this.x 	= this.dPos.x * 60;
			this.y	= this.dPos.y * 60;
			
		}
		
		//-------------------------------------------------
		// Fungsi Delete
		//-------------------------------------------------
		public function explode(_onHandler:Function)
		{
			hideAll();
			_onHandler()
			
		}
		
		//-------------------------------------------------
		// Fungsi Set Active
		//-------------------------------------------------
		public function getActive():Boolean {return m_isActive;}
		public function setActive(value:Boolean):void { 
			m_isActive = value; 
			var _filter:ColorMatrixFilter = new ColorMatrixFilter();
			
			if (value) 	_filter = null;
			else		_filter.tint(0x0, 0.4);
				
			m_IdleR.filter	= _filter;
			m_IdleR.filter	= _filter;
			m_IdleL.filter	= _filter;
			m_IdleL.filter	= _filter;
			
		}
	}

}