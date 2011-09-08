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

package org.as3utils
{
	import org.as3coreaddendum.system.IEquatable;

	import flash.errors.IllegalOperationError;

	/**
	 * A utility class to work with objects that implement <code>org.as3coreaddendum.system.IEquatable</code>.
	 * 
	 * @author Flávio Silva
	 */
	public final class EquatableUtil
	{
		/**
		 * NumberUtil is a static class and shouldn't be instantiated.
		 * 
		 * @throws 	IllegalOperationError 	NumberUtil is a static class and shouldn't be instantiated.
		 */
		public function EquatableUtil()
		{
			throw new IllegalOperationError("NumberUtil is a static class and shouldn't be instantiated.");
		}

		/**
		 * Checks if objects are equal.
		 * <p>First thi method compare objects using <code>o1 == o2</code>.
		 * If it returns true then the method returns true.
		 * Otherwise it will be checked if both objects implement <code>org.as3coreaddendum.system.IEquatable</code> interface and then use <code>o1.equals(o2)</code>.</p>
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * package test
		 * {
		 *     import org.as3coreaddendum.system.IEquatable;
		 *     import org.as3utils.ReflectionUtil;
		 * 
		 *     public class EquatableObject implements IEquatable
		 *     {
		 *         private var _id:String;
		 * 
		 *         public function get id(): String { return _id; }
		 * 
		 *         public function EquatableObject(id:String)
		 *         {
		 *             _id = id;
		 *         }
		 * 
		 *         public function equals(other:*): Boolean
		 *         {
		 *             if (!other) return false;
		 *             if (!ReflectionUtil.classPathEquals(this, other)) return false;
		 *             return id == (other as EquatableObject).id;
		 *         }
		 *     }
		 * }
		 * </listing>
		 * 
		 * <listing version="3.0">
		 * import test.EquatableObject;
		 * import org.as3coreaddendum.system.IEquatable;
		 * 
		 * trace(EquatableUtil.areEqual(1, 1))            // false
		 * trace(EquatableUtil.areEqual("test1", 99))     // false
		 * 
		 * var equatableObject1A:EquatableObject = new EquatableObject("object-1");
		 * var equatableObject1B:EquatableObject = new EquatableObject("object-1");
		 * var equatableObject2:EquatableObject = new EquatableObject("object-2");
		 * 
		 * trace(EquatableUtil.areEqual(equatableObject1A, equatableObject1B))            // true
		 * trace(EquatableUtil.areEqual(equatableObject1A, equatableObject2))             // false
		 * 
		 * </listing>
		 * 
		 * @param  	num 	 a <code>Number</code> object to evaluate.
		 * @return 	<code>true</code> if the value is NaN (not a number) and <code>false</code> otherwise.
		 */
		public static function areEqual(o1:*, o2:*): Boolean
		{
			if (o1 == o2) return true;
			return o1 is IEquatable && o2 is IEquatable && (o1 as IEquatable).equals(o2);
		}

	}

}