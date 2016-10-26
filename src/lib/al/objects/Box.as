package al.objects 
{
	import flash.display.BitmapData;
	import flash.display.GradientType;
	import flash.display.SpreadMethod;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	//import starling.display.Shape;
	import flash.display.Shape;
	import flash.geom.ColorTransform;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author Aldy Ahsandin
	 */
	public class Box extends Sprite 
	{
		
		private var m_bgShape		: Shape 	= new Shape();
		private var m_bgBitmapData	: BitmapData;
		private var m_bgTexture		: Texture;	
		private var m_box			: Image;
		
		private var m_width			: int;
		private var m_height		: int;
		private var m_fillColor		: uint;
		private var m_line			: int;
		private var m_lineAlpha		: Number;
		private var m_lineColor		: uint;
		private var m_elipse		: int;
		
		
		public function Box(
		_width		:int, 
		_height		:int, 
		_fillcolor	:uint 	= 0x0,
		_line		:int	= 0, 
		_lineAlpha	:Number	= 1,
		_lineColor	:uint	= 0x00ff00,
		_elipse		:int 	= 0,
		_isGradient	:Boolean= false)
		
		{
			m_width 		= _width;
			m_height		= _height;
			m_fillColor		= _fillcolor;
			m_line			= _line;
			m_lineAlpha		= _lineAlpha;
			m_lineColor		= _lineColor;
			m_elipse		= _elipse;
			
			//create black rounded box for background
			m_bgShape.graphics.lineStyle(_line, _lineColor, _lineAlpha);
			(_isGradient)? setGradient(_width, _height):m_bgShape.graphics.beginFill(_fillcolor, 1);
			m_bgShape.graphics.drawRoundRect(0, 0, _width, _height, _elipse);
			m_bgShape.graphics.endFill();
		
			m_bgBitmapData	= new BitmapData(_width, _height, true, 0x0);
			m_bgBitmapData.draw(m_bgShape);
		
			m_bgTexture		= Texture.fromBitmapData(m_bgBitmapData, false, false);
			m_box			= new Image(m_bgTexture);
			addChild(m_box);
		}
		
		/**
		 * EXPERIEMENT GRADIENT
		 * @param	_width
		 * @param	_height
		 */
		public function setGradient(_width:int, _height:int)
		{
			var fType:String = GradientType.RADIAL;
			var colors:Array = [ 0xFFFFFF, 0x0 ];
			var alphas:Array = [ 0, 1 ];
			var ratios:Array = [ 0, 200 ];
			
			var gradientMatrixWidth:Number 		= _width	* 2 ;
			var gradientMatrixHeight:Number 	= _height 	* 4 ;
			var gradientMatrixRotation:Number 	= 0 ;
			trace(m_width)
			var gradientTx:Number 				= 0;
			var gradientTy:Number 				= 0;

			var gradientOffsetX:Number 			= -_width / 2; // use this to move the gradient horizontally
			var gradientOffsetY:Number 			= -_height * 1.5; // use this to move the gradient vertically

			var gradientMatrix:Matrix 			= new Matrix ( ) ;
			gradientMatrix.createGradientBox ( 	gradientMatrixWidth, 
												gradientMatrixHeight, 
												gradientMatrixRotation, 
												gradientTx + gradientOffsetX, 
												gradientTy + gradientOffsetY) ;
			m_bgShape.graphics.beginGradientFill(fType, colors, alphas, ratios, gradientMatrix);
		}
		
	
		
		
	}

}