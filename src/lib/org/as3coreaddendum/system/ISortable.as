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

package org.as3coreaddendum.system
{
	import org.as3coreaddendum.system.IComparator;

	/**
	 * A class that implements this interface indicates that it can be sorted by the <code>sort()</code> method.
	 * <p>Usually the classes that implement this interface are collections of some sort.</p>
	 * 
	 * @author Flávio Silva
	 */
	public interface ISortable
	{
		/**
		 * Defines the <code>IComparator</code> object to be used in the comparison.
		 */
		function get comparator(): IComparator;

		function set comparator(value:IComparator): void;

		/**
		 * Defines the options to be used automatically to sort.
		 */
		function get options(): uint;

		function set options(value:uint): void;

		/**
		 * Sorts the objects within this class.
		 * <p>By default, <code>Array.sort()</code> works in the following way:</p>
		 * <p>
		 * <ul>
		 * <li>Sorting is case-sensitive (Z precedes a).</li>
		 * <li>Sorting is ascending (a precedes b).</li>
		 * <li>The array is modified to reflect the sort order; multiple elements that have identical sort fields are placed consecutively in the sorted array in no particular order.</li>
		 * <li>All elements, regardless of data type, are sorted as if they were strings, so 100 precedes 99, because "1" is a lower string value than "9".</li>
		 * </ul>
		 * </p>
		 * 
		 * @param  		compare 	A comparison function used to determine the sorting order of elements in an array. For more info see <code>IComparator.compare</code>.
		 * @param  		options 	One or more numbers or defined constants, separated by the | (bitwise OR) operator, that change the behavior of the sort from the default.
		 * The following values are acceptable for <code>options</code>:
		 * <ul>
		 * <li>1 or Array.CASEINSENSITIVE</li>
		 * <li>2 or Array.DESCENDING</li>
		 * <li>4 or Array.UNIQUESORT</li>
		 * <li>8 or Array.RETURNINDEXEDARRAY</li>
		 * <li>16 or Array.NUMERIC</li>
		 * </ul>
		 * @return 		The return value depends on whether you pass any arguments, as described in the following list:
		 * <ul>
		 * <li>If you specify a value of 4 or Array.UNIQUESORT for the <code>options</code> argument and two or more elements being sorted have identical sort fields, returns a value of 0 and does not modify the array.</li>
		 * <li>If you specify a value of 8 or Array.RETURNINDEXEDARRAY for the options parameter, an array is returned that reflects the results of the sort and the array is not modified.</li>
		 * <li>Otherwise, nothing is returned and the array is modified to reflect the sort order.</li>
		 * </ul>
		 * @see 		IComparator#compare() IComparator.compare()
		 */
		function sort(compare:Function = null, options:uint = 0): Array;
	}

}