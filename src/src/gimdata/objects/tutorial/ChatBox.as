package gimdata.objects.tutorial 
{
	import adobe.utils.CustomActions;
	import al.core.AL;
	import al.core.Ast;
	import al.display.SpriteAL;
	import al.objects.Box;
	import com.greensock.easing.Strong;
	import com.greensock.TweenMax;
	import flash.events.Event;
	import gimdata.core.config.Config;
	import gimdata.core.config.Music;
	import org.osflash.signals.Signal;
	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.utils.VAlign;
	
	/**
	 * ...
	 * @author ...
	 */
	public class ChatBox extends SpriteAL 
	{
		private var m_chatShade		:Box;
		private var m_chatSensor	:Box;
		private var m_chatClose		:TextField;
		private var m_chat_guidance1	:Image;
		private var m_chat_guidance2	:Image;
		
		private var m_chatIndex		:int;
		private var m_chatText		:TextField;
		private var m_chatContainer	:Array;
		
		public var signal_skip	:Signal = new Signal();
		
		public function ChatBox() 
		{
			m_chatShade			= new Box(AL.stageWidth, 100, 0x0, 0, 0);
			m_chatShade.alpha	= 0.85;
			
			m_chatText			= new TextField(400, 80, "Did you see that?");
			m_chatText.color	= 0xFFFFFF;
			m_chatText.x		= 40;
			m_chatText.y		= 10;
			m_chatText.alpha	= 0;
			
			m_chatSensor		= new Box(AL.stageWidth, AL.stageHeight, 0x0, 0, 0);
			m_chatSensor.addEventListener(TouchEvent.TOUCH, onTouch)
			m_chatSensor.alpha	= 0.01;
			
			m_chatClose			= new TextField(70, 30, "SKIP", "verdana", 13, 0xFFFFFF);
			m_chatClose.border	= true;
			m_chatClose.vAlign	= VAlign.CENTER;
			m_chatClose.x		= AL.stageWidth-m_chatClose.width;
			m_chatClose.addEventListener(TouchEvent.TOUCH, onTouch);
			//m_close.visible	= false;
			
			m_chatContainer		= new Array();
			
			m_chat_guidance1		= new Image(Ast.img("cursor_guide"));
			m_chat_guidance1.pivotX	= m_chat_guidance1.width / 2;
			m_chat_guidance1.pivotY	= m_chat_guidance1.height / 2;
			m_chat_guidance1.visible = false;
			m_chat_guidance1.scaleX 	= 0.7;
			m_chat_guidance1.scaleY	= 0.7;
			
			m_chat_guidance2		= new Image(Ast.img("cursor_guide"));
			m_chat_guidance2.pivotX	= m_chat_guidance2.width / 2;
			m_chat_guidance2.pivotY	= m_chat_guidance2.height / 2;
			m_chat_guidance2.visible = false;
			m_chat_guidance2.scaleX 	= 0.7;
			m_chat_guidance2.scaleY	= 0.7;
			
			addChild(m_chatShade);
			addChild(m_chatText);	
			addChild(m_chatSensor);
			addChild(m_chatClose);
			addChild(m_chat_guidance1);
			addChild(m_chat_guidance2);
			
			visible = false;
			Config.counterChat = 0;
		}
		
		private function onTouch(e:TouchEvent):void 
		{
			var _touch:Touch 		= e.getTouch(m_chatSensor, TouchPhase.ENDED);
			var _touchClose:Touch 	= e.getTouch(m_chatClose, TouchPhase.ENDED);
			
			if (_touchClose) {
				hideChat();
				signal_skip.dispatch();
			}
			else
			if (_touch && m_chatText.alpha == 1) {
				Music.GRUP_GAME.playFx(Music.sfx_radio2, 0.1);
				m_chatIndex++;
				if (m_chatIndex <= (m_chatContainer.length - 1)) 
					updateText();
				else
					hideChat();
			}
		}
		
		private function showChat(_pos:String="TOP")
		{
			if (_pos == "TOP") {
								
				Music.GRUP_GAME.playFx(Music.sfx_radio, 0.2);
				m_chatShade.y		= -m_chatShade.height;
				m_chatShade.alpha	= 0;
				m_chatText.y		= 10;
				
				m_chatClose.x		= AL.halfStageWidth - m_chatClose.width / 2;
				m_chatClose.y		= (m_chatShade.height)-(m_chatClose.height+10);
				m_chatClose.visible	= true;
				m_chatClose.alpha	= 0;
				TweenMax.to(m_chatClose, 0.5, { delay:1.2, alpha:1 } );
				
				TweenMax.to(m_chatShade, 0.5, { delay:1, y:0, alpha:1, ease:Strong.easeOut, onComplete:function() {
					updateText();
				}});
			} 
			else 
			if (_pos == "BOTTOM") {
				
				Music.GRUP_GAME.playFx(Music.sfx_radio, 0.2);
				m_chatShade.y		= AL.stageHeight;
				m_chatShade.alpha	= 0;
				m_chatText.y		= AL.stageHeight - m_chatText.height - 40;
				
				m_chatClose.y		= AL.stageHeight -(m_chatClose.height+10)
				m_chatClose.x		= AL.halfStageWidth - m_chatClose.width / 2;
				m_chatClose.visible	= true;
				m_chatClose.alpha	= 0;
				TweenMax.to(m_chatClose, 0.5, { delay:1.2, alpha:1 } );
				
				TweenMax.to(m_chatShade, 0.5, { delay:1, y:AL.stageHeight - m_chatShade.height, 
												alpha:1, ease:Strong.easeOut, onComplete:function() {
												updateText();
											}});
			}
		}
		
		private function hideChat()
		{
			TweenMax.to(m_chatClose, 0.3, { alpha:0, onComplete:function() { m_chatClose.visible = false;}} );
			
			//m_close.visible		= false;
			TweenMax.to(m_chatText, 0.5, {alpha:0});
			if (m_chatShade.y == 0) 
				TweenMax.to(m_chatShade, 0.7, { delay:0.5, y: -m_chatShade.height, alpha:0, ease:Strong.easeOut } );
			else
			if (m_chatShade.y <= (AL.stageHeight - m_chatShade.height)) 
				TweenMax.to(m_chatShade, 0.7, { delay:0.5, y: AL.stageHeight, alpha:0, ease:Strong.easeOut } );
			TweenMax.delayedCall(1, function() { visible = false } );
			
			m_chat_guidance1.visible = false;
			m_chat_guidance1.scaleX	= 0.7;
			m_chat_guidance1.scaleY	= 0.7;
			
			m_chat_guidance2.visible = false;
			m_chat_guidance2.scaleX	= 0.7;
			m_chat_guidance2.scaleY	= 0.7;
			
			
		}
		
		private function clearChats()
		{
			while (m_chatContainer.length>0)
				m_chatContainer.pop();
			m_chatIndex = 0;
		}
		
		private function updateText()
		{
				
			m_chatText.text 	= m_chatContainer[m_chatIndex];
			m_chatText.alpha	= 0;
			TweenMax.to(m_chatText, 0.5, { alpha:1 } );

		}
		
		// =====================================================================
		
		public function show_level1_1()
		{
			clearChats();
			visible = true;
			
			m_chatContainer[0] = "Listen up!";
			m_chatContainer[1] = "Now you have to follow my order";
			m_chatContainer[2] = "Click rifleman in position(3,2)";
			
			showChat("BOTTOM");
			
			m_chat_guidance1.visible = true;
			m_chat_guidance1.alpha	= 0;
			m_chat_guidance1.x		= 163;
			m_chat_guidance1.y		= 110;
			TweenMax.to(m_chat_guidance1, 1.5, { alpha:1 } );
			
		}
		
		public function show_level1_2()
		{
			clearChats();
			visible = true;
			
			m_chatContainer[0] = "When you select an unit, you will see basic info and move area";
			m_chatContainer[1] = "Move the unit to right"
			m_chatContainer[2] = "Click position (5,2)"
			
			showChat("BOTTOM");
			
			m_chat_guidance1.visible = true;
			m_chat_guidance1.alpha	= 0;
			m_chat_guidance1.x		= 267;
			m_chat_guidance1.y		= 110;
			//m_chat_guidance.scaleX	= 1.5;
			//m_chat_guidance.scaleY	= 1.5;
			TweenMax.to(m_chat_guidance1, 1.5, { delay:3.3, alpha:1 } );
			
			
		}
		
		public function show_level1_3()
		{
			clearChats();
			visible = true;
			
			m_chatContainer[0] = "Do you see that defense info?";
			m_chatContainer[1] = "It is terrain defense";
			m_chatContainer[2] = "All terrains give defense for a unit";
			m_chatContainer[3] = "To find out details about defense for each unit";
			m_chatContainer[4] = "press unitpedia button on top screen";
			m_chatContainer[5] = "But do that later...";
			m_chatContainer[6] = "...for now confirm this move";

			showChat("BOTTOM");	
			
			// --------------------------------------------------------
			m_chat_guidance1.visible = true;
			m_chat_guidance1.alpha	= 0;
			m_chat_guidance1.x		= 274;
			m_chat_guidance1.y		= 167;
			TweenMax.to(m_chat_guidance1, 1.5, { delay:1.5, alpha:1 } );
			// --------------------------------------------------------
			
		}
		
		public function show_level1_4()
		{
			clearChats();
			visible = true;
			
			m_chatContainer[0] = "Good!";
			m_chatContainer[1] = "For remaining unit...";
			m_chatContainer[2] = "Move rifleman(3,4) to position (5,4)";
			
			showChat();
			
			// --------------------------------------------------------
			m_chat_guidance1.visible = true;
			m_chat_guidance1.alpha	= 0;
			m_chat_guidance1.x		= 163;
			m_chat_guidance1.y		= 217;
			TweenMax.to(m_chat_guidance1, 1.5, {delay:2.5, alpha:1});
			
		}
		
		public function show_level1_5()
		{
			clearChats();
			visible = true;
			
			m_chatContainer[0] = "All units have moved";
			m_chatContainer[1] = "Press the button on top-right corner to change turn";
			
			showChat("BOTTOM");	
			
			m_chat_guidance1.visible = true;
			m_chat_guidance1.alpha	= 0;
			m_chat_guidance1.x		= 442;
			m_chat_guidance1.y		= 21.5;
			m_chat_guidance1.scaleX	= 0.5;
			m_chat_guidance1.scaleY	= 0.5;
			TweenMax.to(m_chat_guidance1, 1.5, { delay:3, alpha:1 } );
		    			
		}
		
		public function show_level1_6()
		{
			clearChats();
			visible = true;
			
			m_chatContainer[0] = "It seems they don't know us approaching";
			m_chatContainer[1] = "...";
			m_chatContainer[2] = "Okay everyone...Move closer!";
			m_chatContainer[3] = "Rifleman(5,2) move to position(7,2)";
			m_chatContainer[4] = "..and";
			m_chatContainer[5] = "Rifleman(5,4) move to position(7,4)";
			
			showChat("BOTTOM");
			
			m_chat_guidance1.visible = true;
			m_chat_guidance1.alpha	= 0;
			m_chat_guidance1.x		= 266;
			m_chat_guidance1.y		= 113;
			//m_chat_guidance1.scaleX	= 1.5;
			//m_chat_guidance1.scaleY	= 1.5;
			TweenMax.to(m_chat_guidance1, 1.5, { delay:5, alpha:1 } );
			
			m_chat_guidance2.visible = true;
			m_chat_guidance2.alpha	= 0;
			m_chat_guidance2.x		= 266;
			m_chat_guidance2.y		= 220;
			//m_chat_guidance2.scaleX	= 1.5;
			//m_chat_guidance2.scaleY	= 1.5;
			TweenMax.to(m_chat_guidance2, 1.5, { delay:6.5, alpha:1 } );
		}
		
		public function show_level1_7()
		{
			clearChats();
			visible = true;
			
			m_chatContainer[0] = "If they spot us, they will attack";
			m_chatContainer[1] = "But calm down...they outnumber";
			m_chatContainer[2] = "...";
			m_chatContainer[3] = "Now, change turn";
			
			showChat("BOTTOM");			
		}
		
		public function show_level1_8()
		{
			clearChats();
			visible = true;
			
			m_chatContainer[0] = "You can hide cinematic battle by pressing cinema button";
			m_chatContainer[1] = "Just press pause button at top-left screen to show it";
			m_chatContainer[2] = "Well...";
			m_chatContainer[3] = "...it's our turn";
			m_chatContainer[4] = "Select rifleman(7,2)";
			m_chatContainer[5] = "Target sign will appear";
			m_chatContainer[6] = "Whenever an enemy enters the move area";
			
			showChat("BOTTOM");
			
			m_chat_guidance1.visible = true;
			m_chat_guidance1.alpha	= 0;
			m_chat_guidance1.x		= 365;
			m_chat_guidance1.y		= 113;
			//m_chat_guidance1.scaleX	= 0.5;
			//m_chat_guidance1.scaleY	= 0.5;
			TweenMax.to(m_chat_guidance1, 1.5, { delay:6, alpha:1 } );
		}
		
		public function show_level1_9()
		{
			clearChats();
			visible = true;
			
			m_chatContainer[0] = "In every turn, each unit only have one action";
			m_chatContainer[1] = "Either move or attack. So, think wisely";
			m_chatContainer[2] = "For now you should attack enemy";
			m_chatContainer[3] = "Click target sign(7,3) to attack";
			
			showChat("BOTTOM");
			
			m_chat_guidance1.visible = true;
			m_chat_guidance1.alpha	= 0;
			m_chat_guidance1.x		= 367;
			m_chat_guidance1.y		= 167;
			m_chat_guidance1.scaleX	= 0.5;
			m_chat_guidance1.scaleY	= 0.5;
			TweenMax.to(m_chat_guidance1, 1.5, { delay:5, alpha:1 } );
		}
		
		public function show_level1_10()
		{
			clearChats();
			visible = true;
			
			m_chatContainer[0] = "There are some attack information";
			m_chatContainer[1] = "ENEMY refers to current enemy HP";
			m_chatContainer[2] = "ATK refers to damage you make";
			m_chatContainer[3] = "DEF refers to defense in terrain where you attack enemy";
			m_chatContainer[5] = "Confirm your attack now";
			
			
			showChat("BOTTOM");
		}
		
		
		// =================================================================
		
		public function show_level2_1()
		{
			clearChats();
			visible = true;
			
			m_chatContainer[0] = "Press yellow button on top screen";
			m_chatContainer[1] = "That's morale area button";
			
			showChat("BOTTOM");	
			
			m_chat_guidance1.visible = true;
			m_chat_guidance1.alpha	= 0;
			m_chat_guidance1.x		= 167;
			m_chat_guidance1.y		= 20;
			m_chat_guidance1.scaleX	= 0.5;
			m_chat_guidance1.scaleY	= 0.5;
			TweenMax.to(m_chat_guidance1, 1.5, { delay:3, alpha:1 } );
		}
		
		public function show_level2_2()
		{
			clearChats();
			visible = true;
			
			m_chatContainer[0] = "You see that?";
			m_chatContainer[1] = "Every unit gives morale influence to other units nearby";
			
			showChat("BOTTOM");
		}
		
		public function show_level2_3()
		{
			clearChats();
			visible = true;
			
			m_chatContainer[0] = "Now select an APC unit in position (3,3) ...";
			m_chatContainer[1] = "... you'll see morale and attack info";
			
			showChat("BOTTOM");	
			
			m_chat_guidance1.visible = true;
			m_chat_guidance1.alpha	= 0;
			m_chat_guidance1.x		= 166;
			m_chat_guidance1.y		= 167;
			//m_chat_guidance1.scaleX	= 0.5;
			//m_chat_guidance1.scaleY	= 0.5;
			TweenMax.to(m_chat_guidance1, 1.5, { delay:1.5, alpha:1 } );
		}
		
		public function show_level2_4()
		{
			clearChats();
			visible = true;
			
			m_chatContainer[0] = "Look morale and ATK info on top-right corner";
			m_chatContainer[1] = "Remember unit attack...";
			m_chatContainer[2] = " ...its value is 7";
			m_chatContainer[3] = "Now click target sign(5,2)";
			
			showChat("BOTTOM");	
			
			m_chat_guidance1.visible = true;
			m_chat_guidance1.alpha	= 0;
			m_chat_guidance1.x		= 385;
			m_chat_guidance1.y		= 45;
			m_chat_guidance1.scaleX	= 0.5;
			m_chat_guidance1.scaleY	= 0.1;
			TweenMax.to(m_chat_guidance1, 1.5, { delay:1.5, alpha:1 } );
			
			m_chat_guidance2.visible = true;
			m_chat_guidance2.alpha	= 0;
			m_chat_guidance2.x		= 267;
			m_chat_guidance2.y		= 108;
			//m_chat_guidance2.scaleX	= 0.5;
			//m_chat_guidance2.scaleY	= 0.5;
			TweenMax.to(m_chat_guidance2, 1.5, { delay:8.5, alpha:1 } );
		}
		
		public function show_level2_5()
		{
			clearChats();
			visible = true;
			
			m_chatContainer[0] = "See? your attack prediction is -3?";
			m_chatContainer[1] = "Why attack value is not -7?";
			m_chatContainer[2] = "It is not error";
			m_chatContainer[3] = "It is because enemy morale influence decreases your attack";
			m_chatContainer[4] = "Get it?";
			m_chatContainer[5] = "...for now cancel your attack";
			
			showChat("BOTTOM");	
			
			m_chat_guidance1.visible = true;
			m_chat_guidance1.alpha	= 0;
			m_chat_guidance1.x		= 273;
			m_chat_guidance1.y		= 145;
			m_chat_guidance1.scaleX	= 0.7;
			m_chat_guidance1.scaleY	= 0.3;
			TweenMax.to(m_chat_guidance1, 1.5, { delay:1.5, alpha:1 } );
		}
		
		public function show_level2_6()
		{
			clearChats();
			visible = true;
			
			m_chatContainer[0] = "Deselect APC by clicking APC";
			m_chatContainer[1] = "...or any tile outside move area";
			showChat();	
		}
		
		public function show_level2_7()
		{
			clearChats();
			visible = true;
			
			m_chatContainer[0] = "Select rifleman(2,2)";
			m_chatContainer[1] = "Move to position(4,2)";
			
			showChat("BOTTOM");	
			
			m_chat_guidance1.visible = true;
			m_chat_guidance1.alpha	= 0;
			m_chat_guidance1.x		= 110;
			m_chat_guidance1.y		= 108;
			//m_chat_guidance1.scaleX	= 0.5;
			//m_chat_guidance1.scaleY	= 0.5;
			TweenMax.to(m_chat_guidance1, 1.5, { delay:1.5, alpha:1 } );
		}
		
		public function show_level2_8()
		{
			clearChats();
			visible = true;
			
			m_chatContainer[0] = "Look your morale area";
			m_chatContainer[1] = "Press morale button to check new influence";
			
			showChat("BOTTOM");
			
			m_chat_guidance1.visible = true;
			m_chat_guidance1.alpha	= 0;
			m_chat_guidance1.x		= 167;
			m_chat_guidance1.y		= 20;
			m_chat_guidance1.scaleX	= 0.5;
			m_chat_guidance1.scaleY	= 0.5;
			TweenMax.to(m_chat_guidance1, 1.5, { delay:1.5, alpha:1 } );
		}
		
		public function show_level2_9()
		{
			clearChats();
			visible = true;
			
			m_chatContainer[0] = "See?";
			m_chatContainer[1] = "Your morale area has changed";
			
			showChat("BOTTOM");
		}
		
		public function show_level2_10()
		{
			clearChats();
			visible = true;
			
			m_chatContainer[0] = "Attack enemy(5,2) with APC(3,3)";
			m_chatContainer[1] = "Your attack prediction has changed now";
			m_chatContainer[2] = "Because your influence area is stronger...";
			
			showChat("BOTTOM");
			
			m_chat_guidance1.visible = true;
			m_chat_guidance1.alpha	= 0;
			m_chat_guidance1.x		= 267;
			m_chat_guidance1.y		= 108;
			//m_chat_guidance1.scaleX	= 0.5;
			//m_chat_guidance1.scaleY	= 0.5;
			TweenMax.to(m_chat_guidance1, 1.5, { delay:1.5, alpha:1 } );
		}
		
		public function show_level2_11()
		{
			clearChats();
			visible = true;
			
			m_chatContainer[0] = "Remember";
			m_chatContainer[1] = "Your attack depends on three things";
			m_chatContainer[2] = "Your current HP, morale and enemy defense";
			m_chatContainer[3] = "Form your best position to make best attack";
			m_chatContainer[4] = "I leave this mission to you";
			m_chatContainer[5] = "Good luck!";
			
			showChat("BOTTOM");
		}
		
		// =================================================================
		
		public function show_level3_1()
		{
			clearChats();
			visible = true;
			
			m_chatContainer[0] = "See the red tile(6,1)?";
			m_chatContainer[1] = "Do not let the truck to reach the position";
			m_chatContainer[2] = "An RPG unit is provided to succeed this ambush mission";
			m_chatContainer[3] = "It is weak against attack,...";
			m_chatContainer[4] = "...but is powerful to attack";
			m_chatContainer[5] = "I leave this mission to you";
			m_chatContainer[6] = "Good luck!";
			
			showChat("BOTTOM");
			
			m_chat_guidance1.visible = true;
			m_chat_guidance1.alpha	= 0;
			m_chat_guidance1.x		= 318;
			m_chat_guidance1.y		= 67;
			//m_chat_guidance1.scaleX	= 0.5;
			//m_chat_guidance1.scaleY	= 0.5;
			TweenMax.to(m_chat_guidance1, 1.5, { delay:1.5, alpha:1 } );
		}
		
		// =================================================================
		
		public function show_level4_1()
		{
			clearChats();
			visible = true;
			
			m_chatContainer[0] = "Use artillery unit to attack from a distance... ";
			m_chatContainer[1] = "...to avoid direct counter attack";
			m_chatContainer[2] = "Remember";
			m_chatContainer[3] = "Artillery is a vurnerable unit";
			m_chatContainer[4] = "Good luck!";
			
			showChat("BOTTOM");
		}
		
		// =================================================================
		
		public function show_level5_1()
		{
			clearChats();
			visible = true;
			
			m_chatContainer[0] = "Do you notice building(8,1)?";
			m_chatContainer[1] = "That's supply house";
			m_chatContainer[2] = "Capturing enemy supply house...";
			m_chatContainer[3] = "..will heal damaged unit on every turn";
			m_chatContainer[4] = "Same rule applies for the enemy";
			m_chatContainer[5] = "But remember";
			m_chatContainer[6] = "Only infantry unit (rifleman, m.gunner, rpg)...";
			m_chatContainer[7] = "...is able to capture building";
			m_chatContainer[8] = "Good luck!";
			
			showChat("BOTTOM");
			
			m_chat_guidance1.visible = true;
			m_chat_guidance1.alpha	= 0;
			m_chat_guidance1.x		= 418;
			m_chat_guidance1.y		= 62.5;
			//m_chat_guidance1.scaleX	= 0.5;
			//m_chat_guidance1.scaleY	= 0.5;
			TweenMax.to(m_chat_guidance1, 1.5, { delay:2.5, alpha:1 } );
		}
		
		
		// =================================================================
		//  CAUTION
		// =================================================================
		
		public function show_caution()
		{
			clearChats();
			visible = true;
			
			m_chatContainer[0] = "It seems you don't follow my instructions";
			m_chatContainer[1] = "Well it's okay";
			m_chatContainer[2] = "In case you need help ...";
			m_chatContainer[3] = "...restart this mission to follow my instructions";
			m_chatContainer[4] = "I leave this mission to you";
			m_chatContainer[5] = "Good luck!";
			
			showChat("BOTTOM");
			
		}
		
		
		
	}
	
	

}