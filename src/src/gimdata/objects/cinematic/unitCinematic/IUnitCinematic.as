package gimdata.objects.cinematic.unitCinematic {
	import al.core.AL;
	import al.core.Ast;
	import al.display.SpriteAL;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import starling.core.Starling;
	import starling.display.MovieClip;
	/**
	 * ...
	 * @author ...
	 */
	public class IUnitCinematic extends SpriteAL
	{
		public function IUnitCinematic() 
		{
			
		}
		
		protected var m_idle		:MovieClip;
		protected var m_duck		:MovieClip;
		protected var m_walk		:MovieClip;
		protected var m_attack		:MovieClip;
		protected var m_die			:MovieClip;
		
		// ==============================================================================
		
		protected function add_idle(_name:String, _fps:int=12, _atlas:String="")
		{
			m_idle = new MovieClip(Ast.imgs(_name, _atlas), Math.random()*4+1);
			Starling.juggler.add(m_idle);
			addChild(m_idle);
		}
		
		protected function add_duck(_name:String, _fps:int=12, _atlas:String="")
		{
			m_duck = new MovieClip(Ast.imgs(_name, _atlas), 5);
			Starling.juggler.add(m_duck);
			addChild(m_duck);
		}
		
		protected function add_walk(_name:String, _fps:int=12, _atlas:String="")
		{
			m_walk = new MovieClip(Ast.imgs(_name, _atlas), 5);
			Starling.juggler.add(m_walk);
			addChild(m_walk);
		}
		
		protected function add_attack(_name:String, _fps:int=12, _atlas:String="")
		{
			m_attack = new MovieClip(Ast.imgs(_name, _atlas), 5);
			Starling.juggler.add(m_attack);
			addChild(m_attack);
		}
		
		protected function add_die(_name:String, _fps:int=12, _atlas:String="")
		{
			m_die 			= new MovieClip(Ast.imgs(_name, _atlas), 5);
			m_die.visible 	= false;
			m_die.loop		= false;
			m_die.stop();
			
			Starling.juggler.add(m_die);
			addChild(m_die);
			
		}
		
		public var gotoLeft:Boolean = false;
		protected var counter:Timer;
		protected function loopAction()
		{
			var _randomTime:Number 	= Math.random() * 20 + 20;
			var _found:Boolean		= false;
			while (!_found) {
				var _rand:Number = Math.random() * 10;
				if (_rand >0 && _rand<=2 && m_idle) {
					show_idle();
					_found = true;
				} 
				else 
				if (_rand >8 && _rand<=10 && m_walk) {
					show_walk();
					_found = true;
				} 
				else 
				if (_rand >2 && _rand<=4 && m_duck) {
					show_duck();
					_found = true;
				} 
				else 
				if (_rand >4 && _rand<=8 && m_attack) {
					show_attack();
					_found = true;
				} 
				
			}
			
			// --------------------------------------
			counter	= new Timer(60, _randomTime);
			counter.addEventListener(TimerEvent.TIMER, function() {
				if (m_walk && m_walk.visible) {
					
					if ((x > 40 && x < 200) || (x > 280 && x < 440))
					x	= (!gotoLeft)? (x + Math.random() * 1+0.2):(x - Math.random() * 1+0.2); 
				}
			});
			counter.addEventListener(TimerEvent.TIMER_COMPLETE, function() {
				
				counter.stop();
				counter.removeEventListener(TimerEvent.TIMER_COMPLETE, loopAction);
				counter	= null;
				loopAction();
			});
			counter.start();
		}
			
		// ==============================================================================
		
		public function show_idle()
		{
			if (m_die && !m_die.visible) {
				hide_all();
				if (m_idle) {
					m_idle.visible = true;
					m_idle.play();
				}
			}
		}
		
		public function show_walk()
		{
			if (m_die && !m_die.visible) {
				hide_all();
				if (m_walk) {
					m_walk.visible = true;
					m_walk.play();
				}
			}
		}
		
		public function show_attack()
		{
			if (m_die && !m_die.visible) {
				hide_all();
				if (m_attack) {
					m_attack.visible = true;
					m_attack.play();
				}
			}
		}
		
		public function show_duck()
		{
			if (m_die && !m_die.visible) {
				hide_all();
				if (m_duck) {
					m_duck.visible = true;
					m_duck.play();
				}
			}
		}
		
		public function show_die()
		{
			if (m_die && !m_die.visible) {
				hide_all();
				m_die.visible 		= true;
				m_die.currentFrame	= 0;
				m_die.play();
			}
		}
		
		public function hide_all()
		{
			if (m_attack) {
				m_attack.stop();
				m_attack.visible 	= false;
			}
			if (m_idle) {
				m_idle.stop();
				m_idle.visible		= false;
			}
			if (m_walk) {
				m_walk.stop();
				m_walk.visible		= false;
			}
			if (m_duck) {
				m_duck.stop();
				m_duck.visible		= false;
			}
			//if (m_die) {
				//m_die.stop();
				//m_die.visible		= false;
			//}
		}
		public function restart()
		{
			m_die.visible 		= false;
			m_die.currentFrame	= 0;
			show_idle();
		}
		// ==============================================================================
		public function set activateAnim(_isActive:Boolean) 
		{
			if (_isActive && !m_die.visible) {
				loopAction();
			}else {
				if (counter) {
					counter.stop();
					counter = null;
				}
				if (m_attack && m_attack.visible) m_attack.pause()
				else if (m_idle && m_idle.visible) m_idle.pause();
				else if (m_walk && m_walk.visible) m_walk.pause();
				else if (m_duck && m_duck.visible) m_duck.pause();
				
			}
		}
		
		
	}

}