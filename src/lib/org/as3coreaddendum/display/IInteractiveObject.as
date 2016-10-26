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

package org.as3coreaddendum.display {
	import flash.accessibility.AccessibilityImplementation;

	/**
	 * When working on an architecture of interfaces for user-interface components, this interface may be desirable.
	 * <p>This interface simulates a native <code>InteractiveObject</code> interface, specifying all properties of the <code>InteractiveObject</code> class for pure Flash Player 10.</p>
	 * <p>For more information see the ActionScript 3.0 Language Reference.</p>
	 * 
	 * @author Flávio Silva
	 */
	public interface IInteractiveObject extends IDisplayObject
	{
		
		function get accessibilityImplementation(): AccessibilityImplementation;
		function set accessibilityImplementation(value:AccessibilityImplementation): void;
		
		function get doubleClickEnabled(): Boolean;
		function set doubleClickEnabled(value:Boolean): void;
		
		function get focusRect(): Object;
		function set focusRect(value:Object): void;
		
		function get mouseEnabled(): Boolean;
		function set mouseEnabled(value:Boolean): void;
		
		function get tabEnabled(): Boolean;
		function set tabEnabled(value:Boolean): void;
		
		function get tabIndex(): int;
		function set tabIndex(value:int): void;
		
	}

}