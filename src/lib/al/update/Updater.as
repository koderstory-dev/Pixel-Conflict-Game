package al.update 
{
	import al.model.GameLooper;
	import flash.utils.getTimer;
	import starling.display.Stage;
	/**
	 * Update (Subscribe Pattern)
	 * @author AldyAhsandin
	 */
	public class Updater {
		
		private var m_prevTime	:int					= 0;
		private var m_looper	:GameLooper				= null;
		private var m_container	:Vector.<IUpdateObj>	= null;
		
		private var m_isPause	: Boolean				= false;
		
		public function Updater() {
			m_looper 	= new GameLooper();
			m_prevTime	= getTimer();
			m_container	= new Vector.<IUpdateObj>();
			
			m_looper.onTicked.add(onEnterFrame);
		}
		
		//==============//
		// Private Method
		//==============//
		
		private function onEnterFrame(_currentTimeSeconds:Number, _deltaTimeSeconds:Number, _currentTick:int ):void {
			if (!m_isPause) {
				for each( var obj:IUpdateObj in m_container) {
					if ( obj.active)
						obj.update(_deltaTimeSeconds);
				}	
			}
			
		}
		
		//==============//
		// Public Method
		//==============//
		
		/**
		 * Add object to be updated
		 * @param	_obj
		 */
		public function add(_obj:IUpdateObj) {
			m_container.push(_obj);
		}
		
		/**
		 * Remove object from list
		 * @param	_obj
		 */
		public function remove(_obj:IUpdateObj) {
			var indexObj:int = this.m_container.indexOf(_obj);
			if (indexObj != -1)
				this.m_container.splice(indexObj, 1);
		}
		
		
		/**
		 * Pause - Resume loop
		 */
		public function turnOnOffUpdate() {
			m_isPause = (m_isPause)?false:true;
		}
		
		/**
		 * check apakah ada object x yang sudah masuk
		 * @param	_obj
		 * @return
		 */
		public function isThereObj(_obj:IUpdateObj):Boolean {
			for (var i:int = 0; i < m_container.length; i++ ) {
				if (m_container[i] == _obj) {
					return true;
					break;
				}
				
			}
			return false;
		}
		
		
	}

}