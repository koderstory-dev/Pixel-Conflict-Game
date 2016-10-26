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
	 * A comparator for alphabetic order of <code>String</code> objects.
	 * 
	 * @example
	 * 
	 * <listing version="3.0">
	 * import org.as3coreaddendum.system.comparators.AlphabeticComparator;
	 * 
	 * var c1:AlphabeticComparator = new AlphabeticComparator(AlphabeticComparison.LOWER_CASE_FIRST);
	 * 
	 * c1.compare("a", "a")                      // 0
	 * c1.compare("a", "b")                      // -1
	 * c1.compare("b", "a")                      // 1
	 * c1.compare("a", "A")                      // -1
	 * c1.compare("A", "a")                      // 1
	 * c1.compare("comparison", "comparison")    // 0
	 * c1.compare("comparison", "comParison")    // -1
	 * c1.compare("comParison", "comparison")    // 1
	 * c1.compare("comparison", "Comparison")    // -1
	 * c1.compare("Comparison", "comparison")    // 1
	 * c1.compare("between", "strings")          // -1
	 * c1.compare("between", "Strings")          // -1
	 * c1.compare("Between", "strings")          // -1
	 * c1.compare("Between", "Strings")          // -1
	 * c1.compare("between", "between")          // 0
	 * c1.compare("between", "betweena")         // -1
	 * c1.compare("betweena", "betweenA")        // -1
	 * c1.compare("betweenA", "betweena")        // 1
	 * c1.compare("TestA", "TestB")              // -1
	 * c1.compare("TestB", "TestA")              // 1
	 * </listing>
	 * 
	 * <listing version="3.0">
	 * import org.as3coreaddendum.system.comparators.AlphabeticComparator;
	 * 
	 * var c2:AlphabeticComparator = new AlphabeticComparator(AlphabeticComparison.UPPER_CASE_FIRST);
	 * 
	 * c2.compare("a", "a")                      // 0
	 * c2.compare("a", "b")                      // -1
	 * c2.compare("b", "a")                      // 1
	 * c2.compare("a", "A")                      // 1
	 * c2.compare("A", "a")                      // -1
	 * c2.compare("comparison", "comparison")    // 0
	 * c2.compare("comparison", "comParison")    // 1
	 * c2.compare("comParison", "comparison")    // -1
	 * c2.compare("comparison", "Comparison")    // 1
	 * c2.compare("Comparison", "comparison")    // -1
	 * c2.compare("between", "strings")          // -1
	 * c2.compare("between", "Strings")          // -1
	 * c2.compare("Between", "strings")          // -1
	 * c2.compare("Between", "Strings")          // -1
	 * c2.compare("between", "between")          // 0
	 * c2.compare("between", "betweena")         // -1
	 * c2.compare("betweena", "betweenA")        // 1
	 * c2.compare("betweenA", "betweena")        // -1
	 * c2.compare("TestA", "TestB")              // -1
	 * c2.compare("TestB", "TestA")              // 1
	 * </listing>
	 * 
	 * <listing version="3.0">
	 * import org.as3coreaddendum.system.comparators.AlphabeticComparator;
	 * 
	 * var c3:AlphabeticComparator = new AlphabeticComparator(AlphabeticalComparison.CASE_INSENSITIVE);
	 * 
	 * c3.compare("a", "a")                      // 0
	 * c3.compare("a", "b")                      // -1
	 * c3.compare("b", "a")                      // 1
	 * c3.compare("a", "A")                      // 0
	 * c3.compare("A", "a")                      // 0
	 * c3.compare("comparison", "comparison")    // 0
	 * c3.compare("comparison", "comParison")    // 0
	 * c3.compare("comParison", "comparison")    // 0
	 * c3.compare("comparison", "Comparison")    // 0
	 * c3.compare("Comparison", "comparison")    // 0
	 * c3.compare("between", "strings")          // -1
	 * c3.compare("between", "Strings")          // -1
	 * c3.compare("Between", "strings")          // -1
	 * c3.compare("Between", "Strings")          // -1
	 * c3.compare("between", "between")          // 0
	 * c3.compare("between", "betweena")         // -1
	 * c3.compare("betweena", "betweenA")        // 0
	 * c3.compare("betweenA", "betweena")        // 0
	 * c3.compare("TestA", "TestB")              // -1
	 * c3.compare("TestB", "TestA")              // 1
	 * </listing>
	 * 
	 * @see 	org.as3coreaddendum.system.comparators.AlphabeticalComparison AlphabeticalComparison
	 * @author 	Flávio Silva
	 */
	public class AlphabeticalComparator implements IComparator
	{
		private var _comparison: AlphabeticalComparison;

		/**
		 * Defines the type of comparison to be used.
		 * @throws 	ArgumentError If is assigned a <code>null</code> value.
		 * @see 	org.as3coreaddendum.system.comparators.AlphabeticalComparison AlphabeticalComparison
		 */
		public function get comparison(): AlphabeticalComparison { return _comparison; }

		public function set comparison(value:AlphabeticalComparison): void
		{
			if (value == null) throw new ArgumentError("The property 'comparison' must not be 'null'.");
			_comparison = value;
		}

		/**
		 * Constructor, creates a new <code>AlphabeticComparator</code> object.
		 * 
		 * @param 	comparison		Indicates which type of comparison will be used.
		 * @throws 	ArgumentError 	If the 'comparison' argument is <code>null</code>.
		 * @see 	org.as3coreaddendum.system.comparators.AlphabeticalComparison AlphabeticalComparison
		 */
		public function AlphabeticalComparator(comparison:AlphabeticalComparison)
		{
			if (comparison == null) throw new ArgumentError("The property 'comparison' must not be 'null'.");
			this.comparison = comparison;
		}

		/**
		 * Performs the comparison between the two arguments.
		 * 
		 * @param 	o1	The first <code>String</code> object to be compared.
		 * @param 	o2	The second <code>String</code> object to be compared.
		 * @throws 	ArgumentError 	if any of the arguments is <code>null</code>.
		 * @return	A negative integer, zero, or a positive integer as the first argument is less than, equal to, or greater than the second.
		 */
		public function compare(o1:*, o2:*): int
		{
			if (o1 == null || o2 == null) throw new ArgumentError("Both arguments must not be 'null'.");
			
			o1 = String(o1);
			o2 = String(o2);
			
			if (_comparison == AlphabeticalComparison.CASE_INSENSITIVE)
			{
				o1 = (o1 as String).toLowerCase();
				o2 = (o2 as String).toLowerCase();
			}
			
			if (o1 == o2) return 0;
			
			var c1a:String;
			var c2a:String;
			var c1b:String;
			var c2b:String;
			var lc:int;
			var i:int = 0;
			var j:int = Math.min((o1 as String).length, (o2 as String).length);
			
			while (i < j)
			{
				c1a = (o1 as String).charAt(i);
				c2a = (o2 as String).charAt(i);
				
				c1b = c1a.toLowerCase();
				c2b = c2a.toLowerCase();
				
				lc = c1b.localeCompare(c2b);
				
				if (lc < 0)
				{
					return -1;
				}
				else if (lc > 0)
				{
					return 1;
				}
				else if (c1a != c2a)
				{
					if (_comparison == AlphabeticalComparison.LOWER_CASE_FIRST)
					{
						return (c1a == c1a.toUpperCase()) ? 1 : -1;
					}
					else
					{
						return (c1a == c1a.toUpperCase()) ? -1 : 1;
					}
				}
				
				i++;
			}
			
			if ((o1 as String).length < (o2 as String).length)
			{
				return -1;
			}
			else
			{
				return 1;
			}
		}
		
		/**
		 * Returns the string representation of this object.
		 * 
		 * @return 	the string representation of the this object.
		 */
		public function toString():String
		{
			return "[AlphabeticComparator: comparison = " + comparison + "]";
		}

	}

}