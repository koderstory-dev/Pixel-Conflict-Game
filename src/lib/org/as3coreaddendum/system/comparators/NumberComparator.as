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
	 * A comparator for <code>Number</code> objects.
	 * 
	 * @example
	 * 
	 * <listing version="3.0">
	 * import org.as3coreaddendum.system.comparators.NumberComparator;
	 * 
	 * var c:NumberComparator = new NumberComparator();
	 * 
	 * c.compare(0, 0);              // 0
	 * c.compare(1, 1);              // 0
	 * c.compare(0, 1);              // -1
	 * c.compare(94, 56);            // 1
	 * c.compare(-38, -27);          // -1
	 * c.compare(2.5, 2.5);          // 0
	 * c.compare(2.54, 2.54);        // 0
	 * c.compare(2.54, 2.56);        // -1
	 * c.compare(2.567, 2.567);      // 0
	 * c.compare(2.5678, 2.5677);    // 1
	 * c.compare(2.5678, 2.5674);    // 1
	 * c.compare(2.5674, 2.5678);    // -1
	 * </listing>
	 * 
	 * <listing version="3.0">
	 * import org.as3coreaddendum.system.comparators.NumberComparator;
	 * 
	 * var c1:NumberComparator = new NumberComparator(true, 1);
	 * 
	 * c1.compare(2.5, 2.5);          // 0
	 * c1.compare(2.54, 2.54);        // 0
	 * c1.compare(2.54, 2.56);        // -1
	 * c1.compare(2.567, 2.567);      // 0
	 * c1.compare(2.5678, 2.5677);    // 0
	 * c1.compare(2.5678, 2.5674);    // 0
	 * c1.compare(2.5674, 2.5678);    // 0
	 * </listing>
	 * 
	 * <listing version="3.0">
	 * import org.as3coreaddendum.system.comparators.NumberComparator;
	 * 
	 * var c2:NumberComparator = new NumberComparator(true, 2);
	 * 
	 * c2.compare(2.5, 2.5);          // 0
	 * c2.compare(2.54, 2.54);        // 0
	 * c2.compare(2.54, 2.56);        // -1
	 * c2.compare(2.567, 2.567);      // 0
	 * c2.compare(2.5678, 2.5677);    // 0
	 * c2.compare(2.5678, 2.5674);    // 0
	 * c2.compare(2.5674, 2.5678);    // 0
	 * </listing>
	 * 
	 * <listing version="3.0">
	 * import org.as3coreaddendum.system.comparators.NumberComparator;
	 * 
	 * var c3:NumberComparator = new NumberComparator(true, 3);
	 * 
	 * c3.compare(2.5, 2.5);          // 0
	 * c3.compare(2.54, 2.54);        // 0
	 * c3.compare(2.54, 2.56);        // -1
	 * c3.compare(2.567, 2.567);      // 0
	 * c3.compare(2.5678, 2.5677);    // 0
	 * c3.compare(2.5678, 2.5674);    // 1
	 * c3.compare(2.5674, 2.5678);    // -1
	 * </listing>
	 * 
	 * <listing version="3.0">
	 * import org.as3coreaddendum.system.comparators.NumberComparator;
	 * 
	 * var c4:NumberComparator = new NumberComparator(true, 4);
	 * 
	 * c4.compare(2.5, 2.5);          // 0
	 * c4.compare(2.54, 2.54);        // 0
	 * c4.compare(2.54, 2.56);        // -1
	 * c4.compare(2.567, 2.567);      // 0
	 * c4.compare(2.5678, 2.5677);    // 1
	 * c4.compare(2.5678, 2.5674);    // 1
	 * c4.compare(2.5674, 2.5678);    // -1
	 * </listing>
	 * 
	 * @see org.as3coreaddendum.system.IComparator IComparator
	 * @author Flávio Silva
	 */
	public class NumberComparator implements IComparator
	{
		private var _decimalPlaces: int;
		private var _useDecimalPlaces: Boolean;

		/**
		 * Defines the number of decimal places to be considered in the comparison. Must be an integer between 0 and 20.
		 * 
		 * @throws 	RangeError if is assigned a value out of the 0-20 range.
		 */
		public function get decimalPlaces(): int { return _decimalPlaces; }

		public function set decimalPlaces(value:int): void
		{
			if (value < 0 || value > 20) throw new RangeError("The property 'decimalPlaces' must be an integer between 0 and 20.");
			_decimalPlaces = value;
		}

		/**
		 * Defines if both numbers should be rounded by the <code>decimalPlaces</code> property.
		 */
		public function get useDecimalPlaces(): Boolean { return _useDecimalPlaces; }

		public function set useDecimalPlaces(value:Boolean): void { _useDecimalPlaces = value; }

		/**
		 * Constructor, creates a new <code>NumberComparator</code> object.
		 * 
		 * @param useDecimalPlaces 	Indicates if both numbers should be rounded by the <code>decimalPlaces</code> property.
		 * @param decimalPlaces 	The number of decimal places to be considered in the comparison. Must be an integer between 0 and 20.
		 * @throws 	ArgumentError 	if <code>useDecimalPlaces</code> argument is sent <code>false</code> but some value is sent to <code>decimalPlaces</code> argument.
		 * @throws 	RangeError 		if the <code>decimalPlaces</code> argument is out of the 0-20 range.
		 */
		public function NumberComparator(useDecimalPlaces:Boolean = false, decimalPlaces:int = 0)
		{
			if (useDecimalPlaces == false && decimalPlaces != 0) throw new ArgumentError("To send the 'decimalPlaces' argument you must send <code>true</code> to the 'useDecimalPlaces' argument.");
			if (decimalPlaces < 0 || decimalPlaces > 20) throw new RangeError("The argument 'decimalPlaces' must be an integer between 0 and 20.");
			
			this.useDecimalPlaces = useDecimalPlaces;
			this.decimalPlaces = decimalPlaces;
		}

		/**
		 * Performs the comparison between the two arguments.
		 * 
		 * @param 	o1	The first <code>Number</code> object to be compared.
		 * @param 	o2	The second <code>Number</code> object to be compared.
		 * @throws 	ArgumentError if any of the arguments is not of type <code>Number</code>.
		 * @return 	A negative integer, zero, or a positive integer as the first argument is less than, equal to, or greater than the second.
		 */
		public function compare(o1:*, o2:*): int
		{
			if (!(o1 is Number) || !(o2 is Number)) throw new ArgumentError("Both arguments must be of type 'Number'.");
			
			if (_useDecimalPlaces)
			{
				o1 = Number((o1 as Number).toFixed(_decimalPlaces));
				o2 = Number((o2 as Number).toFixed(_decimalPlaces));
			}
			
			if (o1 == o2)
			{
				return 0;
			}
			else if (o1 < o2)
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
			return "[NumberComparator: useDecimalPlaces = " + useDecimalPlaces + " | decimalPlaces = " + decimalPlaces + "]";
		}

	}

}