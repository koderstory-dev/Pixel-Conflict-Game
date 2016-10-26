/**
 * An object that continuously loops ("ticks") on every rendering frame, dispatching SimpleSignal calls every time
 * it does so.
 *
 * More information: http://zehfernando.com/2013/a-gamelooper-class-for-actionscript-3-projects/
 *
 * Using GameLooper is similar to creating an ENTER_FRAME event and watching for it, but with these differences:
 *  . Actual "tick" call rate is flexible: it can execute more than one call per frame, or skip frames as needed
 *  . It keeps track of relative time, so it gets passed time and frame data (for correct position calculation)
 *  . Time is flexible, so it can be multiplied/scaled, paused, and resumed
 *
 *
 * How to use:
 *
 * 1. Create a new instance of GameLooper. This will make the looper's onTicked() signal be fired once per frame
 * (same as ENTER_FRAME):
 *
 *     var looper:GameLooper = new GameLooper(); // Create and start
 *
 *     var looper:GameLooper = new GameLooper(true); // Creates and pauses
 *
 * 2. Create function callbacks to receive the signal (signals are like events, but simpler):
 *
 *     looper.onTicked.add(onTick);
 *
 *     private function onTick(currentTimeSeconds:Number, tickDeltaTimeSeconds:Number, currentTick:int):void {
 *         var speed:Number = 10; // Speed of the box, in pixels per seconds
 *         box.x += speed * tickDeltaTimeSeconds;
 *     }
 *
 *
 * You can also:
 *
 * 1. Pause/resume the looper to pause/resume the game loop:
 *
 *     looper.pause();
 *     looper.resume();
 *
 *
 * 2. Change the time scale to make time go "faster" (currentTimeSeconds, and tickDeltaTimeSeconds):
 *
 *     looper.timeScale = 2; // 2x original speed (faster motion)
 *     looper.timeScale = 0.5; // 0.5x original speed (slower motion)
 *
 * 3. Specify a minimum FPS as a parameter. When the minFPS parameter is used, the looper is always dispatched at
 * least that amount of times per second, regardless of the number of frames:
 *
 *     var looper:GameLooper = new GameLooper(false, 8);
 *
 * In the above example, on a SWF with 4 frames per second, onTicked would be fired twice per frame. On a SWF with
 * 6 frames per second, it would be fired once, and then twice every other frame.
 *
 * 4. Specify a maximum FPS as a parameter. When the maxFPS parameter is used, the looper is not dispatched more
 * that number of times per second:
 *
 *     var looper:GameLooper = new GameLooper(false, NaN, 10);
 *
 * In the above example, on a SWF with 30 frames per second, onTicked would be fired once every 3 frames.
 *
 */

package al.model {
	import al.signal.SimpleSignal;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getTimer;

	/**
	 * @author zeh fernando
	 */
	public class GameLooper {

		// Properties
		private var m_isRunning						: Boolean;
		private var m_timeScale						: Number;
		private var m_currentTick					: int;			// Current absolute frame
		private var m_currentTime					: int;			// Current absolute time, in ms
		private var m_tickDeltaTime					: int;			// Time since last tick, in ms
		private var m_minFPS						: Number;
		private var m_maxFPS						: Number;

		private var m_lastTimeUpdated				: int;
		private var m_minInterval					: Number;		// Min time to wait (in ms) between updates; causes skips (NaN = never enforces)
		private var m_maxInterval					: Number;		// Max time to wait (in ms) between updates; causes repetitions (NaN = never enforces)

		// Temp stuff to reduce garbage collection
		private var m_now							: int;
		private var m_frameDeltaTime				: int;
		private var m_interval						: int;

		// Instances
		private var m_sprite						: Sprite;

		private var m_onResumed						: SimpleSignal;
		private var m_onPaused						: SimpleSignal;
		private var m_onTicked						: SimpleSignal;	// Receives: currentTimeSeconds:Number, tickDeltaTimeSeconds:Number, currentTick:int
		private var m_onTickedOncePerVisualFrame	: SimpleSignal;	// Only fired once per frame. Receives: currentTimeSeconds:Number, tickDeltaTimeSeconds:Number, currentTick:int

		// ================================================================================================================
		// CONSTRUCTOR ----------------------------------------------------------------------------------------------------

		/**
		 * Creates a new GameLooper instance.
		 *
		 * @param paused Starts in paused state if true. Default is false, which means it starts looping right
		 *               away.
		 *
		 * @param minFPS Minimum amount of ticks to dispatch per second. This can cause frames to dispatch more
		 *               than one onTicked event. Default is NaN, which means there's no minimum (synchronizes
		 *               with ENTER_FRAME).
		 *
		 * @param maxFPS Maximum amount of ticks to dispatch per second. This can cause frames to skip dispatching
		 *               onTicked events. Default is NaN, which means there's no maximum (synchronizes to
		 *               ENTER_FRAME).
		 */
		public function GameLooper(_paused:Boolean = false, _minFPS:Number = NaN, _maxFPS:Number = NaN) {
			m_minFPS 						= _minFPS;
			m_maxFPS 						= _maxFPS;
			m_timeScale 					= 1;
			m_currentTick 					= 0;
			m_currentTime 					= 0;
			m_tickDeltaTime 				= 0;
			m_isRunning 					= false;

			m_maxInterval 					= isNaN(m_minFPS) ? NaN : (1000 / m_minFPS);
			m_minInterval 					= isNaN(m_maxFPS) ? NaN : (1000 / m_maxFPS);

			m_onResumed 					= new SimpleSignal();
			m_onPaused 						= new SimpleSignal();
			m_onTicked 						= new SimpleSignal();
			m_onTickedOncePerVisualFrame 	= new SimpleSignal();

			if (!_paused) resume();
		}


		// ================================================================================================================
		// EVENT INTERFACE ------------------------------------------------------------------------------------------------

		private function onSpriteEnterFrame(e:Event):void {
			m_now 				= getTimer();
			m_frameDeltaTime 	= m_now - m_lastTimeUpdated;

			if (isNaN(m_minInterval) || m_frameDeltaTime >= m_minInterval) {
				
				if (!isNaN(m_maxInterval)) {
					
					// Needs several updates
					m_interval = Math.min(m_frameDeltaTime, m_maxInterval);
					while (m_now >= m_lastTimeUpdated + m_interval) {
						update(m_interval * m_timeScale, m_now <= m_lastTimeUpdated + m_maxInterval * 2); // Only dispatches visual frame update on the last call
						m_lastTimeUpdated += m_interval;
					}
				} else {
					
					// Just a single simple update
					update(m_frameDeltaTime * m_timeScale, true);
					m_lastTimeUpdated = m_now; // TODO: not perfect? drifting for ~1 frame every 20 seconds or so when minInterval is used
				}
			}
		}

		private function update(_timePassedMS:int, _newVisualFrame:Boolean = true):void {
			m_currentTick++;
			m_currentTime 	+= _timePassedMS;
			m_tickDeltaTime = _timePassedMS;
			m_onTicked.dispatch(currentTimeSeconds, tickDeltaTimeSeconds, currentTick);

			if (_newVisualFrame) m_onTickedOncePerVisualFrame.dispatch(currentTimeSeconds, tickDeltaTimeSeconds, currentTick);
		}


		// ================================================================================================================
		// PUBLIC INTERFACE -----------------------------------------------------------------------------------------------

		public function updateOnce(_callback:Function):void {
			_callback(currentTimeSeconds, tickDeltaTimeSeconds, currentTick);
		}

		/**
		 * Resumes running this instance, if it's in a paused state.
		 *
		 * <p>Calling this method when this instance is already running has no effect.</p>
		 *
		 * @see #isRunning
		 */
		public function resume():void {
			if (!m_isRunning) {
				m_isRunning = true;

				m_lastTimeUpdated = getTimer();

				m_onResumed.dispatch();

				if (m_sprite == null) {
					m_sprite = new Sprite();
					m_sprite.addEventListener(Event.ENTER_FRAME, onSpriteEnterFrame);
				}
			}
		}

		/**
		 * Pauses this instance, if it's in a running state. All time- and tick-related property values are also
		 * paused.
		 *
		 * <p>Calling this method when this instance is already paused has no effect.</p>
		 *
		 * @see #isRunning
		 */
		public function pause():void {
			if (m_isRunning) {
				m_isRunning = false;

				m_onPaused.dispatch();

				if (m_sprite != null) {
					m_sprite.removeEventListener(Event.ENTER_FRAME, onSpriteEnterFrame);
					m_sprite = null;
				}
			}
		}

		/**
		 * Prepares this instance for disposal, by pausing it and removing all signal callbacks.
		 *
		 * <p>Calling this method is not strictly necessary, but a good practice unless you're pausing it and
		 * clearing all signals manually.</p>
		 */
		public function dispose():void {
			pause();
			m_onResumed.removeAll();
			m_onPaused.removeAll();
			m_onTicked.removeAll();
		}

		// ================================================================================================================
		// ACCESSOR INTERFACE ---------------------------------------------------------------------------------------------

		/**
		 * The index of the tick (an "internal frame") executed last.
		 */
		public function get currentTick():int {return m_currentTick;}

		/**
		 * The current internal time of the looper, in seconds. This is aligned to the last tick executed.
		 */
		public function get currentTimeSeconds():Number {return m_currentTime / 1000;}

		/**
		 * How much time has been spent between the last and the previous tick, in seconds.
		 */
		public function get tickDeltaTimeSeconds():Number {return m_tickDeltaTime / 1000;}

		/**
		 * The time scale for the internal loop time. Changing this has an impact on the time used by the looper,
		 * and can have the effect of make objects that depend on it slower or faster.
		 *
		 * <p>The actual number of signal callbacks dispatched per second do not change.</p>
		 */
		public function get timeScale():Number {return m_timeScale;}

		/**
		 * The time scale for the internal loop time. Changing this has an impact on the time used by the looper,
		 * and can have the effect of make objects that depend on it slower or faster.
		 *
		 * <p>The actual number of signal callbacks dispatched per second do not change.</p>
		 */
		public function set timeScale(__value:Number):void {
			if (m_timeScale != __value) {
				m_timeScale = __value;
			}
		}

		/**
		 * A signal that sends callbacks for when the looper resumes running. Sends no parameters.
		 *
		 * <p>Usage:</p>
		 *
		 * <pre>
		 * private function myOnResumed():void {
		 *     trace("Looper has resumed");
		 * }
		 *
		 * myGameLooper.onResumed.add(myOnResumed);
		 * </pre>
		 */
		public function get onResumed():SimpleSignal {return m_onResumed;}

		/**
		 * A signal that sends callbacks for when the looper pauses execution. Sends no parameters.
		 *
		 * <p>Usage:</p>
		 *
		 * <pre>
		 * private function myOnPaused():void {
		 *     trace("Looper has paused");
		 * }
		 *
		 * myGameLooper.onPaused.add(myOnPaused);
		 * </pre>
		 */
		public function get onPaused():SimpleSignal {return m_onPaused;}

		/**
		 * A signal that sends callbacks for when the looper instance loops (that is, it "ticks"). It sends the
		 * current time (absolute and delta, as seconds) and current tick (as an int) as parameters.
		 *
		 * <p>Usage:</p>
		 *
		 * <pre>
		 * private function myOnTicked(currentTimeSeconds:Number, tickDeltaTimeSeconds:Number, currentTick:int):void {
		 *     trace("A loop happened.");
		 *     trace("Time since it started executing:" + currentTimeSeconds + " seconds");
		 *     trace("           Time since last tick:" + tickDeltaTimeSeconds + " seconds");
		 *     trace("        Tick/frame count so far:" + currentTick);
		 * }
		 *
		 * myGameLooper.onTicked.add(myOnTicked);
		 * </pre>
		 */
		public function get onTicked():SimpleSignal {return m_onTicked;}

		/**
		 * A signal that sends callbacks for when the looper instance loops (that is, it "ticks") only once per
		 * frame (basically ignoring the <code>minFPS</code> parameter). It sends the current time (absolute and
		 * delta, as seconds) and current tick (as an int) as parameters.
		 *
		 * <p>This is useful when using <code>minFPS</code> because you can use the <code>onTicked</code> callback
		 * to do any state changes your game needs, but then only perform visual updates after a
		 * <code>onTickedOncePerVisualFrame()</code> call. If you need to enforce a minimum number of frames per
		 * second but did all visual updates on <code>onTicked()</code>, you could potentially be repeating useless
		 * visual updates.
		 *
		 * <p>Usage:</p>
		 *
		 * <pre>
		 * private function myOnTickedOncePerVisualFrame(currentTimeSeconds:Number, tickDeltaTimeSeconds:Number, currentTick:int):void {
		 *     trace("At least one loop happened in this frame.");
		 *     trace("Time since it started executing:" + currentTimeSeconds + " seconds");
		 *     trace("           Time since last tick:" + tickDeltaTimeSeconds + " seconds");
		 *     trace("        Tick/frame count so far:" + currentTick);
		 * }
		 *
		 * myGameLooper.onTickedOncePerVisualFrame.add(myOnTickedOncePerVisualFrame);
		 * </pre>
		 */
		public function get onTickedOncePerVisualFrame():SimpleSignal {return m_onTickedOncePerVisualFrame;}

		/**
		 * Returns <code>true</code> if the GameLooper instance is running, <code>false</code> if it is paused.
		 *
		 * @see #pause()
		 * @see #resume()
		 */
		public function get isRunning():Boolean {return m_isRunning;}
	}

}