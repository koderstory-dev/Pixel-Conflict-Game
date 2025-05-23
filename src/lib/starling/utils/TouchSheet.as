package starling.utils 
{
	import flash.geom.Point;
	import starling.events.EnterFrameEvent;
    
    import starling.display.DisplayObject;
    import starling.display.Sprite;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;

    public class TouchSheet extends Sprite
    {
		
		
        public function TouchSheet(contents:DisplayObject=null)
        {
            addEventListener(TouchEvent.TOUCH, onMoveAndZoom);
			
            useHandCursor = true;
            
            if (contents)
            {
                contents.x = int(contents.width / -2);
                contents.y = int(contents.height / -2);
                addChild(contents);
            }
        }
		
		private var m_touched:Boolean 	= false;
		private var m_offsetX:Number	= 0;
		private var m_offsetY:Number	= 0;
		
		public var maxX:int;
		public var maxY:int;
		public var widthNow:int;
		public var heightNow:int;
		
		//zoom
		public var lockedMap:Boolean	= false; // select one of tile. When it's true you can't drag
		
		
		public function update():void 
		{
			
			if (!m_touched) {
				
				m_offsetX *= 0.8;
				m_offsetY *= 0.8;
				
				x += m_offsetX;
				y += m_offsetY;
			}
			
			
		}
        
        public function onMoveAndZoom(event:TouchEvent):void
        {
            var touches:Vector.<Touch> = event.getTouches(this, TouchPhase.MOVED);
			var startTouch:Touch = event.getTouch(this, TouchPhase.BEGAN);
            var touch:Touch = event.getTouch(this, TouchPhase.ENDED);
            
			// check end touch
			if (startTouch) m_touched = true;
			if (touch)m_touched = false;
				
			
				
			
            if (touches.length == 1 && !lockedMap)
            {
                // one finger touching -> move
                var delta:Point = touches[0].getMovement(parent);
                m_offsetX		= delta.x;
				m_offsetY		= delta.y;
				
				m_offsetX *= 2;
				m_offsetY *= 2;
				
				//trace(m_offsetX, m_offsetY);
				
				x += delta.x;
                y += delta.y;
				
            }
            
            else if (touches.length == 2 && !lockedMap)
            {
                // two fingers touching -> rotate and scale
                var touchA:Touch = touches[0];
                var touchB:Touch = touches[1];
                
                var currentPosA:Point  		= touchA.getLocation(parent);
                var previousPosA:Point 		= touchA.getPreviousLocation(parent);
                var currentPosB:Point  		= touchB.getLocation(parent);
                var previousPosB:Point 		= touchB.getPreviousLocation(parent);
                
                var currentVector:Point  	= currentPosA.subtract(currentPosB);
                var previousVector:Point 	= previousPosA.subtract(previousPosB);
                
                var currentAngle:Number  	= Math.atan2(currentVector.y, currentVector.x);
                var previousAngle:Number 	= Math.atan2(previousVector.y, previousVector.x);
                var deltaAngle:Number 		= currentAngle - previousAngle;
                
				// update pivot point based on previous center
				var previousLocalA:Point  	= touchA.getPreviousLocation(this);
				var previousLocalB:Point  	= touchB.getPreviousLocation(this);
				
				pivotX = (previousLocalA.x + previousLocalB.x) * 0.5;
				pivotY = (previousLocalA.y + previousLocalB.y) * 0.5;

				// update location based on the current center
				x = (currentPosA.x + currentPosB.x) * 0.5;
				y = (currentPosA.y + currentPosB.y) * 0.5;

				// rotate
                //rotation += deltaAngle;

                // scale
                var sizeDiff:Number = currentVector.length / previousVector.length;
                scaleX *= sizeDiff;
                scaleY *= sizeDiff;
				
				widthNow 	= this.width;
				heightNow	= this.height;
            }
            
            
            
			
			if (touch && touch.tapCount == 2)
                parent.addChild(this); // bring self to front
            
            // enable this code to see when you're hovering over the object
             //touch = event.getTouch(this, TouchPhase.HOVER);            
             //alpha = touch ? 1.0 : .9;
        }
        
        public override function dispose():void
        {
            removeEventListener(TouchEvent.TOUCH, onMoveAndZoom);
            super.dispose();
        }
		
		protected function setCenter(_x:int, _y:int) {
			x = stage.stageWidth / 2;
			y = stage.stageHeight / 2;
			
			 
			//x = stage.width;
			//y = stage.height;
		}
		
	}
}