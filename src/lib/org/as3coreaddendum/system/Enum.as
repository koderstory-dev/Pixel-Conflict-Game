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

package org.as3coreaddendum.system {
	import flash.errors.IllegalOperationError;
	import flash.utils.getQualifiedClassName;

	/**
	 * This is the base class for implementation of enumeration objects.
	 * <p>This class shouldn't be instantiated directly, rather than enumeration classes must extend this class.</p>
	 * <p><b>What is an Enumerated Type?</b></p>
	 * <p>An Enumerated Type is a data type that consists of a pre-defined set of values. Each enumerator (constant) is a value.
	 * An Enumerated Type groups a set of interrelated logical values.</p>
	 * <p>Actionscript 3.0 doesn't implements Enumerated types. Rather, its uses a class with only constants to define a set of interrelated logical values.</p>
	 * <p>One example is the <code>flash.display.StageAlign</code> class. It is the set of logical values acceptable for the <code>flash.display.Stage.align</code> property.</p>
	 * <p>But even without the support of Actionscript 3.0 for Enumerated types you can simulate this functionality extending this Enum class.</p>
	 * 
	 * <p><b>Why use an Enumerated Type rather than a class with constants?</b></p>
	 * <p>Following the example above, if you open the Actionscript 3.0 Language Reference and quickly look at the class <code>flash.display.Stage</code> and see the <code>align</code> property, you will note that its type is <code>String</code>.
	 * So you cannot immediatly know what values you can assign to it. Only after discovering that there is a class <code>flash.display.StageAlign</code> you note that these are the acceptable values.
	 * So this is the first problem with this approach.</p>
	 * <p>The second problem is that you really can assign any <code>String</code> to the <code>align</code> property.
	 * Nothing guarantees you will pass the values that are actually in the <code>flash.display.StageAlign</code> class.
	 * Nor will there be any error at compile time that say that something is wrong.</p>
	 * <p>But if instead of using this approach was used Enumeration types, these two problems would become two good points.</p>
	 * <p>First, looking at the Actionscript 3.0 Language Reference you would see that the property <code>align</code> is of the type <code>StageAlign</code>.
	 * Automatically you check this class and see how to use it to assign a value for the <code>align</code> property.</p>
	 * <p>Even better, if you make a mistake the compiler will warn you.
	 * You will no longer able to send an invalid value for the property.</p>
	 * <p>But even with this approach remains a problem to be solved. The client of your code can still create instances of your Enumerated Type and use them when needed.
	 * In most cases this is undesirable, because you have already defined the set of acceptable values through constants in its Enumerated Type.</p>
	 * <p>To resolve this problem exists a solution: the type-safe enum pattern. It is described with an example at the end of the page.</p>
	 * <p>You can also check the class NumericRounding listed in the section "See also" below.</p>
	 * <p>So to summarize the benefits of using Enumerated types: they make your code (or API) more readable and safe.</p>
	 * 
	 * @example
	 * 
	 * <b>Simple Enumerated Type</b>
	 * <p>Suppose that we have an API that make loading of files.
	 * The acceptable file types that the API can load can be defined by an Enumerated Type.
	 * In this example the name of the Enumerated Type will be FileType. Note that you don't need to use the suffix "Enum" in its name.</p>
	 * <p>Then we define the types that the API can load. In this example the API can load just image, swf and mp3 files.
	 * So we have just three constants, one to each file type.</p>
	 * <p>When we want to load a file, we use the appropriate constant to tell the API what type of file will be loaded.
	 * If you need a file type that doesn't exists in the Enumerated Type, this means that the API doesn't support that file type.</p>
	 * 
	 * <listing version="3.0">
	 * import org.as3coreaddendum.system.Enum;
	 * 
	 * public class FileType extends Enum
	 * {
	 * 
	 *      public static const IMAGE   :FileType = new FileType("Image", 0);
	 *      public static const SWF     :FileType = new FileType("SWF", 1);
	 *      public static const MP3     :FileType = new FileType("MP3", 2);
	 * 
	 *      public function FileType(name:String, ordinal:int)
	 *      {
	 *           super(name, ordinal);
	 *      }
	 * }
	 * </listing>
	 * 
	 * <b>Type-safe Enumerated Type</b>
	 * <p>In the above example, if the user of the API need to load a file type that doesn't exists in the Enumerated Type, it could instantiate a new object FileType with the desired type, as in the example below:</p>
	 * <listing version="3.0">
	 * import FileType;
	 * 
	 * var videoFileType:FileType = new FileType("Video", 3);
	 * </listing>
	 * 
	 * <p>This behavior would be wrong, but still allowed by the technical point of view.
	 * This would create the illusion that the user can create new types at runtime and send them to the API.</p>
	 * <p>To prevent this mistake, we can implement a pattern named type-safe enum.
	 * This pattern will prevents the user create new types, throwing a runtime error.</p>
	 * <p>There are some ways to do this, we will see just one below:</p>
	 * 
	 * <listing version="3.0">
	 * import org.as3coreaddendum.system.Enum;
	 * 
	 * public class FileType extends Enum
	 * {
	 * 
	 *      public static const IMAGE   :FileType = new FileType("Image", 0);
	 *      public static const SWF     :FileType = new FileType("SWF", 1);
	 *      public static const MP3     :FileType = new FileType("MP3", 2);
	 * 
	 *      private static var _created:Boolean = false;
	 * 
	 *      {
	 *           _created = true;
	 *      }
	 * 
	 *      public function FileType(name:String, ordinal:int)
	 *      {
	 *           super(name, ordinal);
	 *           if (_created) throw new IllegalOperationError("The set of acceptable values by this Enumerated Type has already been created internally.");
	 *      }
	 * }
	 * </listing>
	 * 
	 * <p>What happens above is that when the FileType is loaded in the Flash Player memory at runtime, first all the static members are initialized.
	 * After that the <em>static code block</em> is executed:</p>
	 * 
	 * <listing version="3.0">
	 * {
	 *      _created = true;
	 * }
	 * </listing>
	 * 
	 * <p>So first all the constants are initialized with the FileType instances because the <code>_created</code> static variable is <code>false</code> and then immediately after that the <code>_created</code> is set to <code>true</code>.
	 * Thus no more instances can be created.</p>
	 * <p>Your Enumerated Type is safe to be used only with the set of values pre-defined by you.</p>
	 * 
	 * @see 	org.as3coreaddendum.errors.InvalidEnumArgumentError InvalidEnumArgumentError
	 * @see 	org.as3coreaddendum.system.IComparable IComparable
	 * @see 	org.as3coreaddendum.system.IEquatable IEquatable
	 * @see 	org.as3coreaddendum.system.ISerializable ISerializable
	 * @author 	Flávio Silva
	 */
	public class Enum implements IComparable, IEquatable, ISerializable
	{
		private var _name: String;
		private var _ordinal: int;

		/**
		 * The name of this enum constant exactly as supplied by the constructor.
		 * <p><b>Most programmers should use the <code>toString()</code> method in preference to this one, as the <code>toString()</code> method may return a more user-friendly name.</b> This property is designed primarily for use in specialized situations where correctness depends on getting the exact name.</p>
		 */
		public function get name(): String { return _name; }

		/**
		 * The ordinal of this enumeration constant (its position in its enum declaration, where the initial constant is assigned an ordinal of zero).
		 */
		public function get ordinal(): int { return _ordinal; }

		/**
		 * Constructor, creates a new Enum object.
		 * 
		 * @param 	name 			The name of this enumeration constant.
		 * @param 	ordinal 		The ordinal of this enumeration constant, that is its position in the enum declaration (where the initial constant is assigned an ordinal of zero).
		 * @throws 	ArgumentError 	If the <code>name</code> argument is <code>null</code> or an empty <code>String</code>.
		 * @throws 	IllegalOperationError 	If this class is instantiated directly, in other words, if there is <b>not</b> another class extending this class.
		 */
		public function Enum(name:String, ordinal:int)
		{
			if (getClassName(this) == "Enum")  throw new IllegalOperationError("This class shouldn't be instantiated directly, rather than enumeration classes must extend this class.");
			if (name == null || name == "") throw new ArgumentError("The 'name' argument must not be 'null' nor an empty 'String'.");
			
			_name = name;
			_ordinal = ordinal;
		}

		/**
		 * Compares this enum with the specified object for order.
		 * <p>Enum constants are only comparable to other enum constants of the same enum type. The natural order implemented by this method is the order in which the constants are declared.</p>
		 * 
		 * @param 	o	The target object to be compared.
		 * @throws	ArgumentError If the type of the argument <code>o</code> is other than this exactly enum type instance.
		 * @return	a negative integer, zero, or a positive integer as this object is less than, equal to, or greater than the specified object.
		 * @see		org.as3coreaddendum.system.IComparable	IComparable
		 */
		public function compareTo(o:*): int
		{
			var path:String = getClassPath(this);
			var comparePath:String = getClassPath(o);
			
			if (path != comparePath) throw new ArgumentError("The 'o' argument must be of type: " + path + ". Received: " + comparePath);
			
			var compare:Enum = Enum(o);
			
			if (_name == compare.name && _ordinal == compare.ordinal)
			{
				return 0;
			}
			else if (_ordinal < compare.ordinal)
			{
				return -1;
			}
			
			return 1;
		}

		/**
		 * Compares the target object for equality with this object.
		 * 
		 * @param 	other	The object to be compared for equality with this object.
		 * @return 	<code>true</code> if the specified object is equal to this enum constant.
		 * @see		org.as3coreaddendum.system.IEquatable	IEquatable 
		 */
		public function equals(other:*): Boolean
		{
			var path:String = getClassPath(this);
			var comparePath:String = getClassPath(other);
			
			if (path != comparePath) return false;
			
			var compare:Enum = Enum(other);
			if (_name == compare.name && _ordinal == compare.ordinal) return true;
			
			return false;
		}

		/**
		 * @inheritDoc
		 * @see		org.as3coreaddendum.system.ISerializable	ISerializable
 		 */
		public function toSource(): String
		{
			return getClassName(this) + "." + toString();
		}

		/**
		 * Returns the name of this enum constant, as contained in the declaration.
		 * <p>This method may be overridden, though it typically isn't necessary or desirable. An enum type should override this method when a more "programmer-friendly" string form exists.</p>
		 * 
		 * @return The name of this enum constant.
 		 */
		public function toString(): String
		{
			return _name;
		}

		/**
		 * Returns the primitive value of the object.
		 * <p>This method is called automatically by the Flash Player every time an arithmetic operation occur. Thus, it's possible to perform these operations to check the position between two or more enum constants.</p>
		 * 
		 * @return	The primitive value of the object. In this case, the <code>ordinal</code> value.
 		 */
		public function valueOf(): int
		{
			return _ordinal;
		}
		
		/**
		 * @private
		 */
		private function getClassName(o:*): String
		{
			var path:String = getClassPath(o);
			var a:Array = path.split(".");
			return (a.length > 0) ? a.pop() : path;
		}
		
		/**
		 * @private
		 */
		private function getClassPath(o:*): String
		{
			var path:String = getQualifiedClassName(o);
			return path.split("::").join(".");
		}

	}

}