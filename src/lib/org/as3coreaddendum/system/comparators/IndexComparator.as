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

package org.as3coreaddendum.system.comparators 
{
	import org.as3coreaddendum.system.IComparator;
	import org.as3coreaddendum.system.IIndexable;

	/**
	 * A comparator for objects that implements the <code>org.as3coreaddendum.system.IIndexable</code> interface, comparing the <code>index</code> property.
	 * 
	 * @see org.as3coreaddendum.system.IComparator IComparator
	 * @see org.as3coreaddendum.system.IIndexable IIndexable
	 * @author Flávio Silva
	 */
	public class IndexComparator implements IComparator
	{
		private var _numberComparator: NumberComparator;
		
		/**
		 * Constructor, creates a new <code>IndexComparator</code> object.
		 */
		public function IndexComparator()
		{
			_numberComparator = new NumberComparator();
		}

		/**
		 * Performs the comparison between the two arguments.
		 * 
		 * @param 	o1	The first <code>Number</code> object to be compared.
		 * @param 	o2	The second <code>Number</code> object to be compared.
		 * @throws 	ArgumentError 	if any of the arguments does not implements the <code>IIndexable</code> interface.
		 * @return 	A negative integer, zero, or a positive integer as the first argument is less than, equal to, or greater than the second.
		 */
		public function compare(o1:*, o2:*): int
		{
			if (!(o1 is IIndexable) || !(o2 is IIndexable)) throw new ArgumentError("Both arguments must implements the 'IIndexable' interface.");
			
			var i1:int = (o1 as IIndexable).index;
			var i2:int = (o2 as IIndexable).index;
			
			return _numberComparator.compare(i1, i2);
		}

	}

}