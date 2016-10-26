package gimdata.objects.gui {
	import al.core.AL;
	import al.core.Ast;
	import al.display.SpriteAL;
	import com.greensock.easing.Strong;
	import com.greensock.TweenMax;
	import flash.geom.Point;
	import gimdata.core.config.Config;
	import starling.display.Image;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author AldyAhsandin
	 */
	public class Sign extends SpriteAL
	{
		private var m_sign	: Image;
		
		private var y1		: int;
		private var y2		: int;
		
		public function Sign(_image:Image) 
		{
			m_sign			= _image;
			m_sign.scaleX	= 0.6;
			m_sign.scaleY	= 0.6;
			
			y1				= Config.STANDART - m_sign.height / 1.5;
			y2				= y1 + m_sign.height / 6;
			
			m_sign.x		= Config.STANDART / 2 -m_sign.width / 2;
			m_sign.y		= y1
			addChild(m_sign);
			
			this.alpha		= 0;
			activate();
		}
		
		override public function update(_dt:Number = -1):void 
		{
			
			if (!TweenMax.isTweening(m_sign)) {
				down();
				up();
			}
			
		}
		
		private function down()
		{
			if (m_sign.y == y1)
				TweenMax.to(m_sign, 0.3, { y:y2, alpha:1, onComplete:function() { up(); } } );
		}
		
		private function up()
		{
			if (m_sign.y == y2)
				TweenMax.to(m_sign, 0.3, { y:y1, alpha:1,onComplete:function() { down(); } } );
		}
		
		public	function show(_dPos:Point)
		{
			this.active	= true;
			this.alpha	= 1;
			this.x		= _dPos.x * 60;
			this.y		= _dPos.y * 60;
		}
		
		public function hide()
		{
			this.alpha		= 0;	
			this.active		= false;
		}
	}

}