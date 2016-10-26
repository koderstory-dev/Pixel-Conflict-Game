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
	import org.as3coreaddendum.system.StringCase;

	/**
	 * A comparator for <code>String</code> objects.
	 * 
	 * @example
	 * 
	 * <listing version="3.0">
	 * import org.as3coreaddendum.system.comparators.StringComparator;
	 * 
	 * var c1:StringComparator = new StringComparator();
	 * 
	 * c1.compare("comparison", "between");    // 1
	 * c1.compare("between", "comparison");    // -1
	 * c1.compare("between", "strings");       // 1
	 * c1.compare("strings", "between");       // -1
	 * c1.compare("STRINGS", "strings");       // 1
	 * c1.compare("strings", "Strings");       // -1
	 * c1.compare("strings", "strings");       // 0
	 * 
	 * var c2:StringComparator = new StringComparator(false);
	 * 
	 * c2.compare("STRINGS", "strings");    // 0
	 * c2.compare("strings", "Strings");    // 0
	 * c2.compare("between", "strings");    // 1
	 * </listing>
	 * 
	 * @author Flávio Silva
	 */
	public class StringComparator implements IComparator
	{
		private var _stringCase: StringCase;

		/**
		 * Defines whether case is considered in the comparison.
		 */
		public function get stringCase(): StringCase { return _stringCase; }

		public function set stringCase(value:StringCase): void
		{
			if (value == null) throw new ArgumentError("The property 'stringCase' must not be 'null'.");
			_stringCase = value;
		}

		/**
		 * Constructor, creates a new <code>StringComparator</code> object.
		 * 
		 * @param 	stringCase 	Indicates whether case sensitivity is considered or not in the comparison.
		 */
		public function StringComparator(stringCase:StringCase)
		{
			this.stringCase = stringCase;
		}

		/**
		 * Performs the comparison between the two arguments.
		 * 
		 * @param 	o1 	The first <code>String</code> object to be compared.
		 * @param 	o2 	The second <code>String</code> object to be compared.
		 * @throws 	ArgumentError 	if any of the arguments is <code>null</code>.
		 * @return 	A negative integer, zero, or a positive integer as the first argument is less than, equal to, or greater than the second.
		 */
		public function compare(o1:*, o2:*): int
		{
			if (o1 == null || o2 == null) throw new ArgumentError("Both arguments must not be 'null'.");
			
			o1 = String(o1);
			o2 = String(o2);
			
			if (_stringCase == StringCase.INSENSITIVE)
			{
				o1 = (o1 as String).toLowerCase();
				o2 = (o2 as String).toLowerCase();
			}
			
			if (o1 == o2)
			{
				return 0;
			}
			else if ((o1 as String).length > (o2 as String).length)
			{
				return 1;
			}
			else if ((o1 as String).length < (o2 as String).length)
			{
				return -1;
			}
			else
			{
				var lc:int = (o1 as String).localeCompare(o2);
				
				if (lc < 0)
				{
					return 1;
				}
				else
				{
					return -1;
				}
			}
		}
		
		/**
		 * Returns the string representation of this object.
		 * 
		 * @return 	the string representation of the this object.
		 */
		public function toString():String
		{
			return "[StringComparator: stringCase = " + stringCase + "]";
		}

	}

}