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

package org.as3coreaddendum.display
{
	import flash.accessibility.AccessibilityProperties;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.LoaderInfo;
	import flash.display.Shader;
	import flash.display.Stage;
	import flash.events.IEventDispatcher;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.geom.Transform;
	import flash.geom.Vector3D;
	
	/**
	 * When working on an architecture of interfaces for user-interface components, this interface may be desirable.
	 * <p>This interface simulates a native <code>DisplayObject</code> interface, specifying all methods and properties of the <code>DisplayObject</code> class for pure Flash Player 10.</p>
	 * <p>For more information see the ActionScript 3.0 Language Reference.</p>
	 * 
	 * @author Flávio Silva
	 */
	public interface IDisplayObject extends IEventDispatcher
	{
		
		function get accessibilityProperties(): AccessibilityProperties;
		function set accessibilityProperties(value:AccessibilityProperties): void;
		
		function get alpha(): Number;
		function set alpha(value:Number): void;
		
		function get blendMode(): String;
		function set blendMode(value:String): void;
		
		function set blendShader(value:Shader): void;
		
		function get filters(): Array;
		function set filters(value:Array): void;
		
		function get height(): Number;
		function set height(value:Number): void;
		
		function get loaderInfo(): LoaderInfo;
		
		function get mask(): DisplayObject;
		function set mask(value:DisplayObject): void;
		
		function get mouseX(): Number;
		
		function get mouseY(): Number;
		
		function get name(): String;
		function set name(value:String): void;
		
		function get opaqueBackground(): Object;
		function set opaqueBackground(value:Object): void;
		
		function get parent(): DisplayObjectContainer;
		
		function get root(): DisplayObject;
		
		function get rotation(): Number;
		function set rotation(value:Number): void;
		
		function get rotationX(): Number;
		function set rotationX(value:Number): void;
		
		function get rotationY(): Number;
		function set rotationY(value:Number): void;
		
		function get rotationZ(): Number;
		function set rotationZ(value:Number): void;
		
		function get scale9Grid(): Rectangle;
		function set scale9Grid(value:Rectangle): void;
		
		function get scaleX(): Number;
		function set scaleX(value:Number): void;
		
		function get scaleY(): Number;
		function set scaleY(value:Number): void;
		
		function get scaleZ(): Number;
		function set scaleZ(value:Number): void;
		
		function get scrollRect(): Rectangle;
		function set scrollRect(value:Rectangle): void;
		
		function get stage(): Stage;
		
		function get transform(): Transform;
		function set transform(value:Transform): void;
		
		function get visible(): Boolean;
		function set visible(value:Boolean): void;
		
		function get width(): Number;
		function set width(value:Number): void;
		
		function get x(): Number;
		function set x(value:Number): void;
		
		function get y(): Number;
		function set y(value:Number): void;
		
		function get z(): Number;
		function set z(value:Number): void;
		
		function getBounds(targetCoordinateSpace:DisplayObject): Rectangle;
		
		function getRect(targetCoordinateSpace:DisplayObject): Rectangle;
		
		function globalToLocal(point:Point): Point;
		
		function globalToLocal3D(point:Point): Vector3D;
		
		function hitTestObject(obj:DisplayObject): Boolean;
		
		function hitTestPoint(x:Number, y:Number, shapeFlag:Boolean = false): Boolean;
		
		function local3DToGlobal(point3d:Vector3D): Point;
		
		function localToGlobal(point:Point): Point;
	}

}