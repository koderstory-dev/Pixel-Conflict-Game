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

	/**
	 * A comparator for <code>Date</code> objects.
	 * 
	 * @example
	 * 
	 * <listing version="3.0">
	 * import org.as3coreaddendum.system.comparators.DateComparator;
	 * 
	 * var c:DateComparator = new DateComparator();
	 * 
	 * var d1:Date = new Date(2010, 04, 09);
	 * var d2:Date = new Date(2010, 04, 10);
	 * var d3:Date = new Date(2009, 04, 10);
	 * var d4:Date = new Date(1980, 01, 15);
	 * 
	 * c.compare(d1, d1)    // 0
	 * c.compare(d1, d2)    // -1
	 * c.compare(d2, d1)    // 1
	 * c.compare(d2, d3)    // 1
	 * c.compare(d3, d2)    // -1
	 * c.compare(d1, d4)    // 1
	 * c.compare(d4, d1)    // -1
	 * 
	 * </listing>
	 * 
	 * @author Flávio Silva
	 */
	public class DateComparator implements IComparator
	{
		private var _numberComparator: NumberComparator;

		/**
		 * Constructor, creates a new <code>StringComparator</code> object.
		 */
		public function DateComparator()
		{
			_numberComparator = new NumberComparator();
		}

		/**
		 * Performs the comparison between the two arguments.
		 * 
		 * @param 	o1	The first <code>Date</code> object to be compared.
		 * @param 	o2	The second <code>Date</code> object to be compared.
		 * @throws 	ArgumentError 	if any of the arguments is not of type <code>Date</code>.
		 * @return	A negative integer, zero, or a positive integer as the first argument is less than, equal to, or greater than the second.
		 */
		public function compare(o1:*, o2:*): int
		{
			if (!(o1 is Date) || !(o2 is Date)) throw new ArgumentError("Both arguments must be of type 'Date'.");
			
			var d1:Date = o1;
			var d2:Date = o2;
			
			var n1:Number = d1.valueOf();
			var n2:Number = d2.valueOf();
			
			return _numberComparator.compare(n1, n2);
		}

	}

}