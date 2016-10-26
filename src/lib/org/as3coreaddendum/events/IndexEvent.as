/*
 * Licensed under the MIT License
 * 
 * Copyright 2011 (c) Flávio Silva, flsilva.com
 *
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following
 * conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 * 
 * http://www.opensource.org/licenses/mit-license.php
 */
package org.as3coreaddendum.events
{
	import flash.events.Event;

	/**
	 * This event should be dispatched by objects that implement <code>org.as3coreaddendum.system.IIndex</code> interface and had its "index" setter invoked.
	 * This way the object will inform that its index was changed.
	 * <p>But if the object does not implement <code>flash.events.IEventDispatcher</code> interface, that's ok to not dispatch this event.</p>
	 * 
	 * @author Flávio Silva
	 */
	public class IndexEvent extends Event
	{
		public static const CHANGED:String = "org.as3coreaddendum.events.IndexEvent.CHANGED";
		
		/**
		 * description
		 */
		private var _index:int;
		
		/**
		 * description
		 */
		public function get index(): int { return _index; }
		
		/**
		 * Constructor, creates a new <code>IndexEvent</code> object.
		 * 
		 * @param type 			The type of the event, accessible as <code>Event.type</code>.
		 * @param index 		The new index value.
		 * @param bubbles 		Determines whether the Event object participates in the bubbling stage of the event flow. The default value is <code>false</code>.
		 * @param cancelable 	Determines whether the Event object can be canceled. The default value is <code>false</code>.
		 */
		public function IndexEvent(type:String, index:int, bubbles: Boolean = false, cancelable: Boolean = false)
		{
			super(type, bubbles, cancelable);
			
			_index = index;
		}
		
		/**
		 * Duplicates the instance of IndexEvent object.
		 * <p>Returns a new IndexEvent object that is a copy of the original instance of the IndexEvent object. You do not normally call <code>clone()</code>; the <code>EventDispatcher</code> class calls it automatically when you redispatch an event—that is, when you call <code>dispatchEvent(event)</code> from a handler that is handling event.</p>
		 * <p>The new IndexEvent object includes all the properties of the original.</p>
		 * 
		 * @return	A new IndexEvent object that is identical to the original.
		 */
		override public function clone():Event
		{
			return new IndexEvent(type, _index, bubbles, cancelable);
		}
		
	}

}