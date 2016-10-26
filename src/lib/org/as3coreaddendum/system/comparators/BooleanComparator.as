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

	/**
	 * A comparator for <code>Boolean</code> objects.
	 * 
	 * @example
	 * 
	 * <listing version="3.0">
	 * import org.as3coreaddendum.system.comparators.BooleanComparator;
	 * 
	 * var b1:BooleanComparator = new BooleanComparator(BooleanComparison.TRUE_FIRST);
	 * 
	 * b1.compare(true, false);    // -1
	 * b1.compare(false, true);    // 1
	 * 
	 * var b2:BooleanComparator = new BooleanComparator(BooleanComparison.FALSE_FIRST);
	 * 
	 * b2.compare(true, false);    // 1
	 * b2.compare(false, true);    // -1
	 * </listing>
	 * 
	 * @author Flávio Silva
	 */
	public class BooleanComparator implements IComparator
	{
		private var _comparison: BooleanComparison;

		/**
		 * Defines the type of comparison to be used.
		 * @throws 	ArgumentError If is assigned a <code>null</code> value.
		 * @see 	org.as3coreaddendum.system.comparators.BooleanComparison BooleanComparison
		 */
		public function get comparison(): BooleanComparison { return _comparison; }

		public function set comparison(value:BooleanComparison): void
		{
			if (value == null) throw new ArgumentError("The property 'comparison' must not be 'null'.");
			_comparison = value;
		}

		/**
		 * Constructor, creates a new <code>BooleanComparator</code> object.
		 * 
		 * @param 	comparison		Indicates which type of comparison will be used.
		 * @throws 	ArgumentError 	If the 'comparison' argument is <code>null</code>.
		 * @see 	org.as3coreaddendum.system.comparators.BooleanComparison BooleanComparison
		 */
		public function BooleanComparator(comparison:BooleanComparison)
		{
			this.comparison = comparison;
		}

		/**
		 * Performs the comparison between the two arguments.
		 * 
		 * @param 	o1 	The first <code>Boolean</code> object to be compared.
		 * @param 	o2 	The second <code>Boolean</code> object to be compared.
		 * @throws 	ArgumentError 	if any of the arguments are not of type <code>Boolean</code>.
		 * @return 	A negative integer, zero, or a positive integer as the first argument is less than, equal to, or greater than the second.
		 */
		public function compare(o1:*, o2:*): int
		{
			if (!(o1 is Boolean) || !(o2 is Boolean)) throw new ArgumentError("Both arguments must be of type 'Boolean'.");
			
			if (o1 == o2)
			{
				return 0;
			}
			else if (o1 == true && o2 == false)
			{
				return (_comparison == BooleanComparison.TRUE_FIRST) ? -1 : 1;
			}
			else
			{
				return (_comparison == BooleanComparison.TRUE_FIRST) ? 1 : -1;
			}
		}

		/**
		 * Returns the string representation of this object.
		 * 
		 * @return 	the string representation of the this object.
		 */
		public function toString():String
		{
			return "[BooleanComparator: comparison = " + comparison + "]";
		}

	}

}