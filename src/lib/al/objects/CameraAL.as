package al.objects 
{
	import com.greensock.easing.Strong;
	import com.greensock.TweenMax;
	import flash.geom.Point;
	import starling.display.DisplayObject;
	/**
	 * ...
	 * @author AldyAhsandin
	 */
	public class CameraAL 
	{
		
		public function CameraAL() 
		{
			
		}
		
		/**
		 * Zoom in
		 * @param	objToScale
		 * @param	regX
		 * @param	regY
		 * @param	scaleX
		 * @param	scaleY
		 */
		public static function zoom(objToScale:DisplayObject, regX:int, regY:int, scaleX:Number, scaleY:Number, _timer:Number = 0.5):void{
            if (!objToScale){
                return;
            }
            var transformedVector:Point = new Point( (regX-objToScale.x)*scaleX, (regY-objToScale.y)*scaleY );
			TweenMax.to(objToScale, _timer, {	x		: regX - ( transformedVector.x), 
												y		: regY - ( transformedVector.y), 
												scaleX	: objToScale.scaleX * (scaleX),
												scaleY	: objToScale.scaleY * (scaleY),
												ease	: Strong.easeOut})
		}
	}

}