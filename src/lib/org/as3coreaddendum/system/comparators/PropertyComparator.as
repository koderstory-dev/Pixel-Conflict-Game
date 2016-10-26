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
	 * This comparator uses the received <code>comparator</code> object to compare the values recovered from the <code>property</code> of each of the two objects.
	 * 
	 * @example
	 * 
	 * <listing version="3.0">
	 * import org.as3coreaddendum.system.comparators.AlphabeticComparator;
	 * import org.as3coreaddendum.system.comparators.NumberComparator;
	 * import org.as3coreaddendum.system.comparators.PropertyComparator;
	 *
	 * var a:Object = { id: 1, name: "TestA" };
	 * var b:Object = { id: 0, name: "TestB" };
	 * var c:Object = { id: 2, name: "TestC" };
	 *  
	 * var p1:PropertyComparator = new PropertyComparator("id", new NumberComparator());
	 * 
	 * p1.compare(a, a)    // 0
	 * p1.compare(a, b)    // 1
	 * p1.compare(b, a)    // -1
	 * p1.compare(b, c)    // -1
	 * p1.compare(c, a)    // 1
	 *
	 * var p2:PropertyComparator = new PropertyComparator("name", new AlphabeticComparator());
	 *  
	 * p2.compare(a, a)    // 0
	 * p2.compare(a, b)    // -1
	 * p2.compare(b, a)    // 1
	 * p2.compare(b, c)    // -1
	 * p2.compare(c, a)    // 1
	 * </listing>
	 * 
	 * @author Flávio Silva
	 */
	public class PropertyComparator implements IComparator
	{
		private var _comparator: IComparator;
		private var _property: String;

		/**
		 * Defines the comparator object used in the comparison.
		 * 
		 * @throws 	ArgumentError if is assigned a <code>null</code> value.
		 */
		public function get comparator(): IComparator { return _comparator; }

		public function set comparator(value:IComparator): void
		{
			if (value == null) throw new ArgumentError("The property 'comparator' must not be 'null'.");
			_comparator = value;
		}

		/**
		 * Defines the name of the property to be recovered and compared between the objects.
		 * 
		 * @throws 	ArgumentError if is assigned a <code>null</code> value or an empty <code>String</code>.
		 */
		public function get property(): String { return _property; }

		public function set property(value:String): void
		{
			if (value == null || value == "") throw new ArgumentError("The property 'property' must not be 'null' nor an empty 'String'.");
			_property = value;
		}

		/**
		 * Constructor, creates a new <code>PropertyComparator</code> object.
		 * 
		 * @param 	property 	The name of the property to be recovered and compared between the objects.
		 * @param 	comparator 	The comparator object used in the comparison.
		 * @throws 	ArgumentError if the <code>property</code> argument is <code>null</code> or an empty <code>String</code>.
		 * @throws 	ArgumentError if the <code>comparator</code> argument is <code>null</code>.
		 */
		public function PropertyComparator(property:String, comparator:IComparator)
		{
			if (property == null || property == "") throw new ArgumentError("The 'property' argument must not be 'null' nor an empty 'String'.");
			if (comparator == null) throw new ArgumentError("The 'comparator' argument must not be 'null'.");
			
			_property = property;
			_comparator = comparator;
		}

		/**
		 * Performs the comparison between the values recovered from the properties of each of the two objects.
		 * 
		 * @param 	o1 	The first object which has the property recovered to be compared. Can be an instance of any custom class.
		 * @param 	o2 	The second object which has the property recovered to be compared. Can be an instance of any custom class.
		 * @throws 	ArgumentError if any argument is <code>null</code>.
		 * @return 	A negative integer, zero, or a positive integer as the first property is less than, equal to, or greater than the second.
		 */
		public function compare(o1:*, o2:*): int
		{
			if (o1 == null || o2 == null) throw new ArgumentError("Both arguments must not be 'null'.");
			
			return _comparator.compare(o1[_property], o2[_property]);
		}
		
		/**
		 * Returns the string representation of this object.
		 * 
		 * @return 	the string representation of the this object.
		 */
		public function toString():String
		{
			return "[PropertyComparator: property = " + property + "]";
		}

	}

}