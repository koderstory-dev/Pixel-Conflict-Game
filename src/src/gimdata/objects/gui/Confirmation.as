package gimdata.objects.gui 
{
	import al.core.Ast;
	import al.display.SpriteAL;
	import al.objects.Box;
	import com.greensock.easing.Bounce;
	import com.greensock.easing.Elastic;
	import com.greensock.easing.Strong;
	import com.greensock.TweenMax;
	import flash.events.Event;
	import gimdata.core.config.Config;
	import gimdata.mvc.control.action.Action;
	import gimdata.mvc.model.ModelBattle;
	import org.osflash.signals.Signal;
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.SEvent;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.utils.VAlign;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Confirmation extends SpriteAL 
	{
		
		private var m_vOk				: Button;
		private var m_vCancel			: Button;
		private var m_text				: TextField;
		
		public 	var signal_confirmation	: Signal = new Signal(); 
		
		public function Confirmation() {
			addEventListener(SEvent.ADDED_TO_STAGE, start);
		}
		
		public function show(_info:String)
		{
			m_text.text = _info;
			TweenMax.to(m_text, 1.25, {  y:-70, ease:Elastic.easeOut } );
			TweenMax.to(m_vOk, 1.25, {  x:25, y:m_vOk.y - 40, ease:Elastic.easeOut } );
			TweenMax.to(m_vCancel, 1.25, { x:95, y:m_vCancel.y - 40, ease:Elastic.easeOut } );
			
			
		}
		
		public function hide()
		{
			TweenMax.to(m_text, 1, {  y:20, ease:Strong.easeOut } );
			TweenMax.to(m_vOk, 1, { x:45, y:m_vOk.y + 40, ease:Strong.easeOut } );
			TweenMax.to(m_vCancel, 1, { x:45, y:m_vCancel.y + 40, ease:Strong.easeOut } );
		}
		
		private function start(e:SEvent):void {
			
			m_text		= new TextField(140, 65, "SURE?", "vcr",20, 0xFFFF00);
			m_vOk		= new Button(	Ast.img("uiConfirmation", "confirmation_ok"), "", 
										Ast.img("uiConfirmation", "confirmation_ok_small"));
			m_vCancel	= new Button(	Ast.img("uiConfirmation", "confirmation_cancel"), "", 
										Ast.img("uiConfirmation", "confirmation_cancel_small"));
			
			//m_vOk.scaleX = 0.85;
			//m_vOk.scaleY = 0.85;
			//m_vCancel.scaleX = 0.85;
			//m_vCancel.scaleY = 0.85;
			//
			m_text.x	= 15;
			m_text.y	= 50;
			//m_text.border = true;
			m_text.vAlign = VAlign.BOTTOM;
			m_vOk.x		= 45;
			m_vCancel.x = 45;
			m_vOk.y		= 45;
			m_vCancel.y = 45;
			
			m_vOk.addEventListener(TouchEvent.TOUCH, onTouch);
			m_vCancel.addEventListener(TouchEvent.TOUCH, onTouch);
			
			addChild(m_text);
			addChild(m_vOk);
			addChild(m_vCancel);
		}
		
		private function onTouch(e:TouchEvent):void 
		{
			var _touchOk: Touch 	= e.getTouch(m_vOk, 	TouchPhase.ENDED);
			var _touchCancel: Touch = e.getTouch(m_vCancel, TouchPhase.ENDED);
			
			// jika tombol konfirmasi ok ditekan
			// maka menuju state bergerak
			if (_touchOk) {
				
				if (Config.confirmation == 2)
					Config.confirmation = 1; 
				signal_confirmation.dispatch();
			}
			
			// jika tombol konfirmasi cancel ditekan
			// maka menuju state show ally
			else
			if(_touchCancel) {
				
				if (Config.confirmation == 2)
					Config.confirmation = 0;
				signal_confirmation.dispatch();
			}
		}
		
	}

}