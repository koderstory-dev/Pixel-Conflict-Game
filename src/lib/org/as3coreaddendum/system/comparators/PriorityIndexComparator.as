/*
 * Licensed under the MIT License
 * 
 * Copyright 2010 (c) Flávio Silva, http://flsilva.com
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

package org.as3coreaddendum.system.comparators {
	import org.as3coreaddendum.system.IComparator;
	import org.as3coreaddendum.system.IIndexable;
	import org.as3coreaddendum.system.IPriority;

	/**
	 * A comparator for objects that implements the <code>org.as3coreaddendum.system.IPriority</code> and <code>org.as3coreaddendum.system.IIndexable</code> interfaces, comparing the <code>priority</code> and <code>index</code> properties.
	 * <p>This comparator is util when you want to sort the objects by priority, but if the priority of the two objects are equal, the <code>index</code> property of the objects are compared to decide wich object comes before.</p>
	 * 
	 * @see org.as3coreaddendum.system.IComparator IComparator
	 * @see org.as3coreaddendum.system.IIndexable IIndexable
	 * @see org.as3coreaddendum.system.IPriority IPriority
	 * @author Flávio Silva
	 */
	public class PriorityIndexComparator implements IComparator
	{
		private var _numberComparator: NumberComparator;

		/**
		 * Constructor, creates a new <code>PriorityIndexComparator</code> object.
		 */
		public function PriorityIndexComparator()
		{
			_numberComparator = new NumberComparator();
		}

		/**
		 * Performs the comparison between the two arguments.
		 * 
		 * @param 	o1	The first <code>Number</code> object to be compared.
		 * @param 	o2	The second <code>Number</code> object to be compared.
		 * @throws 	ArgumentError 	if any of the arguments does not implements the <code>IPriority</code> or <code>IIndexable</code> interfaces.
		 * @return 	A negative integer or a positive integer as the priority of the first argument is greater than or less than the second. If the priority of the arguments are equal, returns a negative integer, zero, or a positive integer as the index of the first argument is less than, equal to, or greater than the second.
		 */
		public function compare(o1:*, o2:*): int
		{
			if (!(o1 is IPriority) || !(o2 is IPriority)) throw new ArgumentError("Both arguments must implement the 'IPriority' interface.");
			if (!(o1 is IIndexable) || !(o2 is IIndexable)) throw new ArgumentError("Both arguments must implement the 'IIndexable' interface.");
			
			var p1:int = (o1 as IPriority).priority;
			var p2:int = (o2 as IPriority).priority;
			
			if (p1 > p2)
			{
				return -1;
			}
			else if (p1 < p2)
			{
				return 1;
			}
			else
			{
				var i1:int = (o1 as IIndexable).index;
				var i2:int = (o2 as IIndexable).index;
				
				return _numberComparator.compare(i1, i2);
			}
		}

	}

}