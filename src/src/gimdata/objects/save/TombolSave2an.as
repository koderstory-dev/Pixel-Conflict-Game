package gimdata.objects.save 
{
	import al.core.Ast;
	import al.display.SpriteAL;
	import flash.events.Event;
	import org.osflash.signals.Signal;
	import starling.display.Button;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.filters.ColorMatrixFilter;
	import starling.text.TextField;
	
	/**
	 * ...
	 * @author Aldy Ahsandin
	 */
	public class TombolSave2an extends SpriteAL 
	{
		public var tombolSave:Button;
		public var tombolDelete:TextField;
		
		public var signal_save:Signal = new Signal();
		public var signal_delete:Signal = new Signal();
		
		public function TombolSave2an() 
		{
			tombolSave 			= new Button(Ast.img("uiMenu", "button_long2"));
			tombolSave.text		= "New Slot";
			tombolSave.fontSize	= 28;
			tombolSave.addEventListener(TouchEvent.TOUCH, onTouchButton);
			addChild(tombolSave);
			
			tombolDelete 			= new TextField(50, 50, "X", "badabom", 46, 0xFFFFFF);
			tombolDelete.x		= tombolSave.width - tombolDelete.width/2;
			tombolDelete.addEventListener(TouchEvent.TOUCH, onTouchButton);
			tombolDelete.y		= -15;
			tombolDelete.visible	= false;
			addChild(tombolDelete);
			
		}
		
		public function setSave(_isSaved:Boolean, _date:String = ""):void 
		{
			if (!_isSaved) {
				tombolSave.fontColor	= 0x0;
				tombolSave.filter = null;
				tombolSave.text = "New Slot"
				
				tombolDelete.visible	= false;
				
			}
			else 
			{
				tombolSave.fontColor	= 0xFF0000;		
				tombolSave.text		= _date;
				
				tombolDelete.visible 	= true;
				
				var _filter:ColorMatrixFilter = new ColorMatrixFilter();
					_filter.adjustHue(0.4);
				tombolSave.filter = _filter;
			}
		}
		
		// -------------------------------------------------------
		
		private function onTouchButton(e:TouchEvent):void 
		{
			var _touchSave:Touch 	= e.getTouch(tombolSave, TouchPhase.ENDED);
			var _touchDelete:Touch 	= e.getTouch(tombolDelete, TouchPhase.ENDED);
			
			if (_touchSave)
				signal_save.dispatch();
			if (_touchDelete)
				signal_delete.dispatch();
			
		}
	}

}