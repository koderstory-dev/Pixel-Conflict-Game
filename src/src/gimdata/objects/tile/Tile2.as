package gimdata.objects.tile 
{
	import al.display.SpriteAL;
	import al.objects.Box;
	import flash.geom.Point;
	import gimdata.core.config.Config;
	import gimdata.core.config.Factory;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.filters.ColorMatrixFilter;
	
	/**
	 * ...
	 * @author Aldy Ahsadin
	 */
	public class Tile2 extends SpriteAL 
	{
		public var vDisplay :Image;
		public var vMove	: MovieClip;
		public var vTarget	: MovieClip;
		public var vOwner	: Box;
		
		
		public var dType	: int;
		public var dPos		: Point;
		
		public var isMove	: Boolean;
		public var isTarget	: Boolean;
		
		private var m_filter_black: ColorMatrixFilter;
		private var m_filter_white: ColorMatrixFilter;
		private var m_owner	: SpriteAL;
		public function Tile2(_nomor:int, _pos:Point) 
		{
			m_filter_black = new ColorMatrixFilter();
			m_filter_black.tint(0x0, 0.8);
			
			m_filter_white = new ColorMatrixFilter();
			m_filter_white.tint(0xFF0000, 1);
				
			dType		= _nomor - (Factory.NUMTILE1+1);// tambah 1 karena nanti pengaruh di UnitDB karena indeks 1 adalah 0
			dPos		= _pos;
			
			// display
			vDisplay 	= Factory.createTile2(_nomor)
			vMove		= Factory.createTileStatus(1);
			vTarget		= Factory.createTileStatus(2);
			m_owner		= new SpriteAL();
			
			addChild(m_owner);
			if (vDisplay) 
			addChild(vDisplay);
			addChild(vMove);
			addChild(vTarget);
			
			Starling.juggler.add(vMove);
			Starling.juggler.add(vTarget);
			
			vMove.alpha		= 0.3;
			this.x			= _pos.x * Config.STANDART;
			this.y			= _pos.y * Config.STANDART-10;
			
			showTile();
		}
		
		public function hideAll()
		{
			if (vDisplay) 
			vDisplay.visible = false;
			
			vMove.visible	= false;
			vTarget.visible	= false;
			
			isMove			= false;
			isTarget		= false;
			
			vMove.pause();
			vTarget.pause();
		}
		
		public function showTile()
		{
			hideAll();
			
			if(vDisplay)
			vDisplay.visible	= true;
		}
		
		public function showMove()
		{
			hideAll();
			vMove.filter = null;
			
			vMove.visible	= true;
			vMove.alpha 	= 0.7;
			isMove			= true;
			vMove.play();
			
			if(vDisplay)
			vDisplay.visible	= true;
		}
		
		public function showTargetArea()
		{
			if (!vMove.visible)
			{
				//vMove.filter 	= m_filter_black;
				vMove.visible	= true;
				vMove.alpha 	= 0.3;
				//isMove			= true;
				vMove.play();
				
				//vTarget.filter = m_filter_white;
				//vTarget.visible	= true;
				//vTarget.play();
				
				if(vDisplay)
				vDisplay.visible	= true;
			}
		}
		
		public function showTarget()
		{
			hideAll();
			
			isTarget		= true;
			
			vMove.visible	= true;
			vMove.alpha 	= 0.7;
			
			vTarget.visible	= true;
			vTarget.play();
			
			
			
			if(vDisplay)
			vDisplay.visible	= true;
		}
		
		public function showOwner(_type:int)
		{
			var _tes:Box 	= new Box(60, 60, (_type>10)?0xFF0000:0x008000, 0, 0);
				_tes.alpha	= 0.5;
				_tes.y		= 10;
			m_owner.addChild(_tes);
		}
		
		
	}

}