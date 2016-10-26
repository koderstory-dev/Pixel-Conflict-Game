package al.display {
	import al.ALManager;
	import al.core.AL;
	import al.core.Ast;
	import al.model.GameLooper;
	import al.objects.Box;
	import al.update.IUpdateObj;
	import com.greensock.easing.Strong;
	import com.greensock.TweenMax;
	import flash.events.Event;
	import flash.utils.getTimer;
	import starling.core.RenderSupport;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.display.Stage;
	import starling.events.SEvent;
	import starling.filters.ScanlineFilter;
	import starling.filters.SpotlightFilter;
	/**
	 * Kelas world yang menjadi kontainer kelas-kelas spriteAL
	 * Update (Subscribe Pattern)
	 * @author AldyAhsandin
	 */
	public class ScreenAL extends SpriteAL {
		
		private var m_prevTime		: int				= 0;
		private var m_container		: Sprite			= null;	// menampung object
		private var m_transition	: Box; 
		
		private var m_scanlineFilter: ScanlineFilter	= null
		
		protected var alManager	: ALManager;
		
		
		//------------------------------
		// border
		private var m_borderH1		: Image;
		private var m_borderH2		: Image;
		private var m_borderV1		: Image;
		private var m_borderV2		: Image;
		
		public function ScreenAL(_alManager:ALManager) {
			
			alManager	= _alManager;
			
			// -- container --
			m_container	= new Sprite();
			addChild(m_container);
			// ---------------
			
			
			// -- transition --
			m_transition = new Box(AL.stageWidth, AL.stageHeight, 0x0, 0, 0); addChild(m_transition)
			TweenMax.to(m_transition, 1, { alpha:0, onComplete:function() { m_transition.visible = false; }} );
			// ----------------
			
			
			// -- border --
			m_borderV1			= new Image(Ast.img("borderV"));
			m_borderV2			= new Image(Ast.img("borderV"));
			//m_borderV1.pivotX	= m_borderV1.width / 2;
			//m_borderV2.pivotX	= m_borderV2.width / 2;
			
			//m_borderV1.x		= 10;
			m_borderV2.scaleX	= -1;
			m_borderV2.x		= AL.stageWidth;
			addChild(m_borderV1);
			addChild(m_borderV2);
			// ------------
			
			addEventListener(SEvent.ADDED_TO_STAGE, start);
		}
		
		
		
		//==============//
		// Public Method
		//==============//
		
		public function start(e:SEvent) 
		{
			//removeEventListener(SEvent.ADDED_TO_STAGE, start);
		}
		
		public function add(_obj:DisplayObject)
		{
			m_container.addChild(_obj);
		}
		
		public function remove(_obj:DisplayObject)
		{
			if(_obj) m_container.removeChild(_obj);
		}
		
		//==============//
		// Effect
		//==============//
		
		public function activateScanline()
		{
			var _stage:Stage		= Starling.current.stage;
			var rs:RenderSupport 	= new RenderSupport();
			
			rs.clear(0xFFFFFF, 1.0);
			rs.scaleMatrix(1,1);
			rs.setOrthographicProjection(0, 0, AL.stageWidth, AL.stageHeight);
			rs.finishQuadBatch();
			render(rs, 0.5);
			
			m_scanlineFilter		= new ScanlineFilter(AL.stageFullWidth/240);
			filter					= m_scanlineFilter;
			//m_scanlineFilter 		= new SpotlightFilter();
			//m_scanlineFilter.x 		= AL.halfStageWidth;
			//m_scanlineFilter.y		= AL.halfStageHeight;
			//m_scanlineFilter.radius	= 0.65;
			//filter = m_scanlineFilter;
		}
		
		public function scanlineEffect()
		{
			m_scanlineFilter.resolution = (m_scanlineFilter.resolution > 0.5)?
			m_scanlineFilter.resolution -= 0.001:m_scanlineFilter.resolution = 0.9;
		}
	}

}