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
	/**
	 * This interface exposes a way to tell to an object that it is no longer needed.
	 * <p>When the <code>dispose()</code> method is invoked on an object, it should stop all its processes and kill all its references to another objects, explicitly controlling the lifecycle of all its dependencies.
	 * If the dependency also implements this interface, its <code>dispose()</code> method should be called by this object.</p>
	 * <p>If the object has a parent class (base class) and the parent class also implements this interface, the <code>dispose()</code> method of the parent class should be called, propagating this action through the hierarchy of parents.</p>
	 * <p>If the <code>dispose()</code> method is called more than once, the object should ignore all calls after the first one, without throwing an error.</p>
	 * <p>Since the <code>dispose()</code> method was called, the object just wait to be released from memory by the garbage collection process.</p>
	 * <p>The object should throw the org.as3coreaddendum.errors.ObjectDisposedError if some method is called after the <code>dispose()</code> method was called, indicating an illegal operation.</p>
	 * 
	 * @see		org.as3coreaddendum.errors.ObjectDisposedError	ObjectDisposedError
	 * @author Flávio Silva
	 */
	public interface IDisposable
	{
		/**
		 * Dispose the object to be garbage collected.
		 */
		function dispose(): void;
	}

}