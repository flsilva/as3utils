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

package org.as3utils {
	import org.as3coreaddendum.system.IComparator;
	import org.as3coreaddendum.system.comparators.AlphabeticalComparator;
	import org.as3coreaddendum.system.comparators.AlphabeticalComparison;
	import org.as3coreaddendum.system.comparators.PropertyComparator;

	import flash.errors.IllegalOperationError;

	/**
	 * A utility class to work with <code>Array</code> objects.
	 * <p>ArrayUtil handles <code>null</code> input arrays quietly in almost all methods.
	 * When not, it's documented in the method.
	 * That is to say that a <code>null</code> input will not thrown an error in almost all methods.</p>
	 * 
	 * @author Flávio Silva
	 */
	public class ArrayUtil
	{
		private static var _checkType: *;
		private static var _strictCheckType: Boolean;

		/**
		 * ArrayUtil is a static class and shouldn't be instantiated.
		 * 
		 * @throws 	IllegalOperationError 	ArrayUtil is a static class and shouldn't be instantiated.
		 */
		public function ArrayUtil()
		{
			throw new IllegalOperationError("ArrayUtil is a static class and shouldn't be instantiated.");
		}

		/**
		 * Adds the element at the specified position in the specified array.
		 * <p>This method modifies the original array.</p>
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.ArrayUtil;
		 * 
		 * var arr:Array = ["abc", "def", 123, 1, 2, 3, "abc", 7];
		 * 
		 * ArrayUtil.addAt(arr, 0, 0)       // [0,abc,def,123,1,2,3,abc,7]
		 * ArrayUtil.addAt(arr, 7, 4)       // [0,abc,def,123,1,2,3,4,abc,7]
		 * ArrayUtil.addAt(arr, 10, "z")    // [0,abc,def,123,1,2,3,4,abc,7,z]
		 * 
		 * </listing>
		 * 
		 * @param  	array 		the array to remove the element from.
		 * @param  	index 		the position of the element to be removed.
		 * @param  	element 	the element to add.
		 * @throws 	ArgumentError 	if the <code>array</code> argument is <code>null</code>.
		 * @throws 	RangeError 		if the <code>index</code> argument is a negative integer or greater than the <code>array.length - 1</code>.
		 * @return 	the array with the element added.
		 */
		public static function addAt(array:Array, index:int, element:*): Array
		{
			if (array == null) throw new ArgumentError("The 'array' argument must not be 'null'");
			if (index < 0 || index > array.length) throw new RangeError("The 'index' argument is out of bounds: " + index + " (min: 0, max: " + (array.length) + ")");
			
			array.splice(index, 0, element);
			return array;
		}

		/**
		 * Checks if the element is in the given array.
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.ArrayUtil;
		 * 
		 * var obj:Object = {label:"ghi"};
		 * var arr:Array = ["abc", 123, {label:"def"}, obj];
		 * 
		 * ArrayUtil.contains([], null)              // false
		 * ArrayUtil.contains([null], null)          // true
		 * ArrayUtil.contains(arr, "abc")            // true
		 * ArrayUtil.contains(arr, "ab")             // false
		 * ArrayUtil.contains(arr, "abcd")           // false
		 * ArrayUtil.contains(arr, 123)              // true
		 * ArrayUtil.contains(arr, "123")            // false
		 * ArrayUtil.contains(arr, 1234)             // false
		 * ArrayUtil.contains(arr, {label:"def"})    // false
		 * ArrayUtil.contains(arr, {label:"ghi"})    // false
		 * ArrayUtil.contains(arr, obj)              // true
		 * </listing>
		 * 
		 * @param  	array 		the array to search through. May be <code>null</code>.
		 * @param  	element 	the element to find.
		 * @return 	<code>true</code> if the array contains the element.
		 */
		public static function contains(array:Array, element:*): Boolean
		{
			if (isEmpty(array)) return false;
			return array.indexOf(element) != -1;
		}
		//TODO:asdoc e ordenar
		public static function containsDuplication(array:Array): Boolean
		{
			return getDuplicate(array).length > 0;
		}
		
		public static function getDuplicate(array:Array): Array
		{
			if (isEmpty(array)) return [];
			
			var duplicate:Array = [];
			var temp:Array = [];
			var element:*;
			var i:int;
			var length:int = array.length;
			
			for (i = 0; i < length; i++)
			{
				element = array[i];
				
				if (contains(temp, element)) duplicate.push(element);
				
				temp.push(element); 
			}
			
			return duplicate;
		}

		/**
		 * Returns <code>true</code> if the array contains only elements of the <code>type</code> argument.
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.ArrayUtil;
		 * 
		 * ArrayUtil.containsOnlyType(["a", "b", "c"], String)                  // true
		 * ArrayUtil.containsOnlyType(["a", "b", "c"], String, true)            // true
		 * ArrayUtil.containsOnlyType(["a", "b", "c", 5], String)               // false
		 * ArrayUtil.containsOnlyType([[], [], [], [], []], Array)              // true
		 * ArrayUtil.containsOnlyType([[], [], [], 3, [], []], Array)           // false
		 * ArrayUtil.containsOnlyType([[], [], [], 3, [], []], Object)          // true
		 * ArrayUtil.containsOnlyType([[], [], [], 3, [], []], Object, true)    // false
		 * </listing>
		 * 
		 * @param  	array 		the array to check. May be <code>null</code>.
		 * @param  	element 	the type of the elements.
		 * @param  	strict 		defines if the type of the elements should be strictly equal.
		 * @return 	<code>true</code> if the array contains only elements of the <code>type</code> argument. If the array is <code>null</code> or empty returns <code>false</code>.
		 */
		public static function containsOnlyType(array:Array, type:*, strict:Boolean = false): Boolean
		{
			if (isEmpty(array)) return false;
			_checkType = type;
			_strictCheckType = strict;
			return array.every(_containsOnlyType);
		}

		/**
		 * Returns <code>true</code> if the array contains some element of the <code>type</code> argument.
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.ArrayUtil;
		 * 
		 * ArrayUtil.containsType(["a", "b", "c"], String)                  // true
		 * ArrayUtil.containsType(["a", "b", "c"], String, true)            // true
		 * ArrayUtil.containsType(["a", "b", "c", 5], String)               // true
		 * ArrayUtil.containsType(["a", "b", "c"], Number):                 // false
		 * ArrayUtil.containsType(["a", "b", "c", 5], Number)               // true
		 * ArrayUtil.containsType([[], [], [], [], []], Array)              // true
		 * ArrayUtil.containsType([[], [], [], 3, [], []], Array)           // true
		 * ArrayUtil.containsType([[], [], [], 3, [], []], Number)          // true
		 * ArrayUtil.containsType([[], [], [], 3, [], []], Object)          // true
		 * ArrayUtil.containsType([[], [], [], 3, [], []], Object, true)    // false
		 * ArrayUtil.containsType([[], [], [], 3, [], []], Boolean)         // false
		 * </listing>
		 * 
		 * @param  	array 		the array to check. May be <code>null</code>.
		 * @param  	element 	the type of the elements.
		 * @param  	strict 		defines if the type of the elements should be strictly equal.
		 * @return 	<code>true</code> if the array contains some element of the <code>type</code> argument. If the array is <code>null</code> or empty returns <code>false</code>.
		 */
		public static function containsType(array:Array, type:*, strict:Boolean = false): Boolean
		{
			if (isEmpty(array)) return false;
			_checkType = type;
			_strictCheckType = strict;
			return array.some(_containsType);
		}

		/**
		 * Returns the array containing only objects of the type of the <code>type</code> argument.
		 * <p>This method modifies the original array.</p>
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.ArrayUtil;
		 * 
		 * var obj:Object = {label:"jlm"};
		 * var n1:int = 1;
		 * var n2:Number = 2;
		 * var n3:Number = 3.1;
		 * var arr:Array = ["abc", "def", 123, {label:"ghi"}, obj, n1, n2, n3];
		 * 
		 * ArrayUtil.filterByType(null, null)             // null
		 * ArrayUtil.filterByType([], null)               // 
		 * ArrayUtil.filterByType(null, Array)            // null
		 * ArrayUtil.filterByType(arr, String)            // abc,def
		 * ArrayUtil.filterByType(arr, String, true)      // abc,def
		 * ArrayUtil.filterByType(arr, Object)            // abc,def,123,[object Object],[object Object],1,2,3.1
		 * ArrayUtil.filterByType(arr, Object, true)      // [object Object],[object Object]
		 * ArrayUtil.filterByType(arr, Number)            // 123,1,2,3.1
		 * ArrayUtil.filterByType(arr, Number, true)      // 3.1
		 * ArrayUtil.filterByType(arr, int)               // 123,1,2
		 * ArrayUtil.filterByType(arr, int, true)         // 123,1,2
		 * 
		 * // for this to work the array must be re-declared with values for each call, because filterByType changes the original array.
		 * </listing>
		 * 
		 * @param  	array 	the array for filtering. May be <code>null</code>.
		 * @param  	type 	the type of the objects that should remain in the array.
		 * @param  	strict 	defines if the type of the elements should be strictly equal.
		 * @return 	the array containing only objects of the type of the <code>type</code> argument.
		 */
		public static function filterByType(array:Array, type:Class, strict:Boolean = false): Array
		{
			if (isEmpty(array)) return array;
			
			var arr:Array = [];
			var i:int;
			var n:int = array.length;
			
			if (strict)
			{
				for (i = 0; i < n; i++)
				{
					if (ReflectionUtil.classPathEquals(type, array[i])) arr.push(array[i]);
				}
			}
			else
			{
				for (i = 0; i < n; i++)
				{
					if (array[i] == null && type == null)
					{
						arr.push(array[i]);
					}
					else if (array[i] is type)
					{
						arr.push(array[i]);
					}
				}
			}
			
			array.splice(0);
			array.push.apply(array, arr);
			
			return array;
		}

		/**
		 * Checks if an array is empty (zero-length) or <code>null</code>.
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.ArrayUtil;
		 * 
		 * ArrayUtil.isEmpty(null)      // true
		 * ArrayUtil.isEmpty([])        // true
		 * ArrayUtil.isEmpty([null])    // false
		 * ArrayUtil.isEmpty([123])     // false
		 * </listing>
		 * 
		 * @param  	array 	the array to check.
		 * @return 	<code>true</code> if the array is empty or <code>null</code>.
		 */
		public static function isEmpty(array:Array): Boolean
		{
			return (array == null || array.length == 0) ? true : false;
		}

		/**
		 * Compares two arrays, returning <code>true</code> if they are equal (same length, objects and order).
		 * <p>Two <code>null</code> references are considered to be equal.</p>
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.ArrayUtil;
		 * 
		 * var obj:Object = {label:"jlm"};
		 * var n1:int = 1;
		 * var n2:Number = 2;
		 * var n3:Number = 3.1;
		 * var arr:Array = ["abc", "def", 123, {label:"ghi"}, obj, n1, n2, n3];
		 * var arr2:Array = ["abc", "def", 123, {label:"ghi"}, obj, n1, n2, n3];
		 * var arr3:Array = ["abc", "def", 123, obj, n1, n2, n3];
		 * var arr4:Array = ["abc", "def", 123, obj, n1, n2, n3];
		 * var arr5:Array = ["abc", "def", 123, obj, n2, n1, n3];
		 * 
		 * ArrayUtil.equals(null, null)           // true
		 * ArrayUtil.equals(null, [])             // false
		 * ArrayUtil.equals([], [])               // true
		 * ArrayUtil.equals([1], [1])             // true
		 * ArrayUtil.equals(["abc"], ["abc"])     // true
		 * ArrayUtil.equals(["abc"], ["abcd"])    // false
		 * ArrayUtil.equals(arr, [])              // false
		 * ArrayUtil.equals(arr, arr)             // true
		 * ArrayUtil.equals(arr, arr2)            // false
		 * ArrayUtil.equals(arr3, arr4)           // true
		 * ArrayUtil.equals(arr4, arr5)           // false
		 * </listing>
		 * 
		 * @param  	array1 	the first array. May be <code>null</code>.
		 * @param  	array2 	the second array. May be <code>null</code>.
		 * @return 	<code>true</code> if the arrays are equal or both are <code>null</code>.
		 */
		public static function equals(array1:Array, array2:Array): Boolean
		{
			if (array1 == null && array2 == null) return true;
			if (array1 == null || array2 == null) return false;
			if (array1 == array2) return true;
			
			if (array1.length != array2.length) return false;
			
			var i:int;
			var n:int = array1.length;
			
			for (i = 0; i < n; i++)
			{
				if (array1[i] !== array2[i]) return false;
			}
			
			return true;
		}

		/**
		 * Checks if the array is not empty (zero-length) nor not <code>null</code>.
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.ArrayUtil;
		 * 
		 * ArrayUtil.isNotEmpty(null)      // false
		 * ArrayUtil.isNotEmpty([])        // false
		 * ArrayUtil.isNotEmpty([null])    // true
		 * ArrayUtil.isNotEmpty([123])     // true
		 * </listing>
		 * 
		 * @param  	array 	the array to check.
		 * @return 	<code>true</code> if the array is not empty nor not <code>null</code>.
		 */
		public static function isNotEmpty(array:Array): Boolean
		{
			return !isEmpty(array);
		}

		/**
		 * Checks whether two arrays are the same length, treating <code>null</code> arrays as length 0.
		 * <p>Two <code>null</code> references are considered to be equal.</p>
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.ArrayUtil;
		 * 
		 * ArrayUtil.isSameLength(null, null)            // true
		 * ArrayUtil.isSameLength(null, [])              // true
		 * ArrayUtil.isSameLength([], [])                // true
		 * ArrayUtil.isSameLength([1], [2])              // true
		 * ArrayUtil.isSameLength([1, "a"], [2])         // false
		 * ArrayUtil.isSameLength([1, "a"], [2, "b"])    // true
		 * </listing>
		 * 
		 * @param  	array1 	the first array. May be <code>null</code>.
		 * @param  	array2 	the second array. May be <code>null</code>.
		 * @return 	<code>true</code> if length of arrays matches, treating <code>null</code> as an empty array.
		 */
		public static function isSameLength(array1:Array, array2:Array): Boolean
		{
			if (array1 == null && array2 == null) return true;
			var l1:int = (array1 != null) ? array1.length : 0;
			var l2:int = (array2 != null) ? array2.length : 0;
			return l1 == l2;
		}

		/**
		 * Returns the largest number in the array.
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.ArrayUtil;
		 * 
		 * var arr:Array = [5, 3, 9.1, 9.12, -10];
		 * var arr2:Array = [-15, -8, -25, -90, -66];
		 * 
		 * ArrayUtil.maxValue(null)    // NaN
		 * ArrayUtil.maxValue([])      // NaN
		 * ArrayUtil.maxValue(arr)     // 9.12
		 * ArrayUtil.maxValue(arr2)    // -8
		 * </listing>
		 * 
		 * @param  	array 	the array to check. May be <code>null</code>.
		 * @return 	the largest number in the array. If the <code>array</code> argument is <code>null</code> or empty then the return is <code>NaN</code>.
		 */
		public static function maxValue(array:Array): Number
		{
			if (isEmpty(array)) return NaN;
			return array[maxValueIndex(array)];
		}

		/**
		 * Returns the index position of the largest number in the array.
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.ArrayUtil;
		 * 
		 * var arr:Array = [5, 3, 9.1, 9.12, -10];
		 * var arr2:Array = [-15, -8, -25, -90, -66];
		 * 
		 * ArrayUtil.maxValue(null)    // -1
		 * ArrayUtil.maxValue([])      // -1
		 * ArrayUtil.maxValue(arr)     // 3
		 * ArrayUtil.maxValue(arr2)    // 1
		 * </listing>
		 * 
		 * @param  	array 	the array to check. May be <code>null</code>.
		 * @return 	the index position of the largest number in the array. If the <code>array</code> argument is <code>null</code> or empty then the return is -1.
		 */
		public static function maxValueIndex(array:Array): int
		{
			if (isEmpty(array)) return -1;
			
			var i:int = 0;
			var n:int = array.length;
			var currentMaxIndex:int = 0;
			var currentMaxValue:Number = array[0];
			
			for (i = 0; i < n; i++)
			{
				if (array[i] > currentMaxValue) currentMaxIndex = i;
			}
			
			return currentMaxIndex;
		}

		/**
		 * Returns an empty array for a <code>null</code> input array.
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.ArrayUtil;
		 * 
		 * ArrayUtil.nullToEmpty(null)            // []
		 * ArrayUtil.nullToEmpty([])              // []
		 * ArrayUtil.nullToEmpty([1])             // [1]
		 * ArrayUtil.nullToEmpty(["abc", 123])    // [abc,123]
		 * </listing>
		 * 
		 * @param  	array 	the array to check for <code>null</code> or empty.
		 * @return 	the same array or an empty array if <code>null</code> input.
		 */
		public static function nullToEmpty(array:Array): Array
		{
			if (array == null) return [];
			return array;
		}

		/**
		 * Removes all occurances of a the given <code>element</code> argument from the given <code>array</code> argument.
		 * <p>This method modifies the original array.</p>
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.ArrayUtil;
		 * 
		 * var arr:Array = ["abc", "def", 123, 1, 2, 3, "abc", 7];
		 * 
		 * ArrayUtil.removeAllOccurances(arr, "abc")    // [def,123,1,2,3,7]
		 * </listing>
		 * 
		 * @param  	array 		the array to remove the element. May be <code>null</code>.
		 * @param  	element 	the element to be removed from the array.
		 * @return 	the updated array or <code>null</code> if the <code>array</code> argument is <code>null</code>.
		 */
		public static function removeAllOccurances(array:Array, element:*): Array
		{
			if (isEmpty(array)) return array;
			
			while (array.indexOf(element) != -1) array.splice(array.indexOf(element), 1);
			
			return array;
		}

		/**
		 * Removes the element at the specified position from the specified array.
		 * <p>This method modifies the original array.</p>
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.ArrayUtil;
		 * 
		 * var arr:Array = ["abc", "def", 123, 1, 2, 3, "abc", 7];
		 * 
		 * ArrayUtil.removeAt(arr, 0)    // [def,123,1,2,3,abc,7]
		 * ArrayUtil.removeAt(arr, 5)    // [abc,def,123,1,2,abc,7]
		 * ArrayUtil.removeAt(arr, 6)    // [abc,def,123,1,2,3,7]
		 * 
		 * //for this to work exactly that way is necessary to redefine the array for every call because the original array is modified at each call.
		 * </listing>
		 * 
		 * @param  	array 	the array to remove the element from.
		 * @param  	index 	the position of the element to be removed.
		 * @throws 	ArgumentError 	if the <code>array</code> argument is <code>null</code> or empty.
		 * @throws 	RangeError 		if the <code>index</code> argument is a negative integer or greater than the <code>array.length - 1</code>.
		 * @return 	the array with the element removed.
		 */
		public static function removeAt(array:Array, index:int): Array
		{
			if (isEmpty(array)) throw new ArgumentError("The 'array' argument must not be 'null' nor empty.");
			if (index < 0 || index >= array.length) throw new RangeError("The 'index' argument is out of bounds: " + index + " (min: 0, max: " + (array.length - 1) + ")");
			
			array.splice(index, 1);
			return array;
		}

		/**
		 * Removes the first occurrence of the specified element from the specified array.
		 * <p>This method modifies the original array.</p>
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.ArrayUtil;
		 * 
		 * var arr:Array = ["abc", "def", 123, 1, 2, 3, "abc", 7];
		 * 
		 * ArrayUtil.removeFirstOccurance(arr, "abc")    // [def,123,1,2,3,abc,7]
		 * </listing>
		 * 
		 * @param  	array 		the array to remove the element from.
		 * @param  	element 	the element to be removed.
		 * @throws 	ArgumentError 	if the <code>array</code> argument is <code>null</code> or empty.
		 * @return 	the array with the element removed.
		 */
		public static function removeFirstOccurance(array:Array, element:*): Array
		{
			if (isEmpty(array)) throw new ArgumentError("The 'array' argument must not be 'null' nor empty.");
			
			if (array.indexOf(element) != -1) array.splice(array.indexOf(element), 1);
			return array;
		}

		/**
		 * Removes the last occurrence of the specified element from the specified array.
		 * <p>This method modifies the original array.</p>
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.ArrayUtil;
		 * 
		 * var arr:Array = ["abc", "def", 123, 1, 2, 3, "abc", 7];
		 * 
		 * ArrayUtil.removeLastOccurance(arr, "abc")    // [abc,def,123,1,2,3,7]
		 * </listing>
		 * 
		 * @param  	array 		the array to remove the element from.
		 * @param  	element 	the element to be removed.
		 * @throws 	ArgumentError 	if the <code>array</code> argument is <code>null</code> or empty.
		 * @return 	the array with the element removed.
		 */
		public static function removeLastOccurance(array:Array, element:*): Array
		{
			if (isEmpty(array)) throw new ArgumentError("The 'array' argument must not be 'null' nor empty.");
			
			if (array.indexOf(element) == -1) return array;
			
			var i:int;
			var j:int = array.length - 1;
			
			for (i = j; i >= 0; i--)
			{
				if (array[i] == element)
				{
					array.splice(i, 1);
					return array;
				}
			}
			
			return array;
		}

		/**
		 * Shuffles the position of the elements of the given <code>array</code>.
		 * <p>This method modifies the original array.</p>
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.ArrayUtil;
		 * 
		 * var arr:Array = ["abc", "def", 123, 1, 2, 3, "abc", 7];
		 * 
		 * ArrayUtil.shuffle(arr)    // [123,abc,2,def,abc,7,3,1]
		 * </listing>
		 * 
		 * @param  	array 	the array to shuffle. May be <code>null</code>.
		 * @return 	the modified array.
		 */
		public static function shuffle(array:Array): Array
		{
			if (isEmpty(array)) return array;
			
			var i:int;
			var n:int = array.length;
			var r:int;
			var e:*;
			
			for (i = 0; i < n; i++)
			{
				r = Math.floor(Math.random() * n);
				e = array[i];
				array[i] = array[r];
				array[r] = e;
			}
			
			return array;
		}

		/**
		 * Sorts the array of <code>String</code> objects alphabetically.
		 * <p>This method uses the <code>org.as3coreaddendum.system.comparators.AlphabeticalComparator</code> object.</p>
		 * <p>This method modifies the original array.</p>
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.ArrayUtil;
		 * 
		 * var arr:Array = ["a", "ab", "abc", "aba", "A", "Ab", "Abc", "Aba", "AB", "ABC", "ABA"];
		 * 
		 * ArrayUtil.shuffle(arr)                                                          // [aba,Ab,ABC,AB,abc,Aba,ab,ABA,a,Abc,A]
		 * 
		 * ArrayUtil.sortAlphabetically(arr, AlphabeticalComparison.LOWER_CASE_FIRST)      // [a,ab,aba,abc,A,Ab,Aba,Abc,AB,ABA,ABC]
		 * ArrayUtil.sortAlphabetically(arr, AlphabeticalComparison.UPPER_CASE_FIRST)      // [A,AB,ABA,ABC,Ab,Aba,Abc,a,ab,aba,abc]
		 * ArrayUtil.sortAlphabetically(arr, AlphabeticalComparison.CASE_INSENSITIVE)      // [a,A,AB,ab,Ab,ABA,Aba,aba,ABC,Abc,abc]
		 * </listing>
		 * 
		 * @param  	array 			the array to sort.
		 * @param 	comparison		indicates which type of comparison will be used.
		 * @return 	the sorted array.
		 * @see		org.as3coreaddendum.system.comparators.AlphabeticalComparator	AlphabeticalComparator
		 */
		public static function sortAlphabetically(array:Array, comparison:AlphabeticalComparison): Array
		{
			var ac:IComparator = new AlphabeticalComparator(comparison);
			
			array.sort(ac.compare);
			return array;
		}

		/**
		 * Sorts the array of objects alphabetically through the object's <code>property</code>.
		 * <p>This method uses the <code>org.as3coreaddendum.system.comparators.AlphabeticalComparator</code> and <code>org.as3coreaddendum.system.comparators.PropertyComparator</code> objects together.</p>
		 * <p>This method modifies the original array.</p>
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.ArrayUtil;
		 * 
		 * var arr:Array = [{label:"a"}, {label:"ab"}, {label:"abc"}, {label:"aba"}, {label:"A"}, {label:"Ab"}, {label:"Abc"}, {label:"Aba"}, {label:"AB"}, {label:"ABC"}, {label:"ABA"}];
		 * 
		 * ArrayUtil.shuffle(arr)
		 * ArrayUtil.sortAlphabeticallyByObjectProperty(arr, "label", AlphabeticalComparison.CASE_INSENSITIVE)
		 * 
		 * arr[0].label    // A
		 * arr[1].label    // a
		 * arr[2].label    // Ab
		 * arr[3].label    // ab
		 * arr[4].label    // AB
		 * arr[5].label    // Aba
		 * arr[6].label    // ABA
		 * arr[7].label    // aba
		 * arr[8].label    // ABC
		 * arr[9].label    // abc
		 * </listing>
		 * 
		 * @param  	array 			the array to sort.
		 * @param 	property 		the name of the property to be recovered and compared between the objects.
		 * @param 	comparison		indicates which type of comparison will be used.
		 * @return 	the sorted array.
		 * @see		org.as3coreaddendum.system.comparators.AlphabeticalComparator	AlphabeticalComparator
		 * @see		org.as3coreaddendum.system.comparators.PropertyComparator	PropertyComparator
		 */
		public static function sortAlphabeticallyByObjectProperty(array:Array, property:String, comparison:AlphabeticalComparison): Array
		{
			var ac:IComparator = new AlphabeticalComparator(comparison);
			var pc:IComparator = new PropertyComparator(property, ac);
			
			array.sort(pc.compare);
			return array;
		}

		/**
		 * Sorts the array of <code>Number</code> objects ascending.
		 * <p>This method modifies the original array.</p>
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.ArrayUtil;
		 * 
		 * var arr:Array = [-3, -2.55, -2.54, -1, 0, 1, 2, 3, 4, 4.1, 5, 5.01, 5.02, 6, 7, 8];
		 * 
		 * ArrayUtil.shuffle(arr)          // [-1,4.1,6,3,-3,4,5.02,8,2,1,5,-2.54,5.01,7,-2.55,0]
		 * 
		 * ArrayUtil.sortAscending(arr)    // [-3,-2.55,-2.54,-1,0,1,2,3,4,4.1,5,5.01,5.02,6,7,8]
		 * </listing>
		 * 
		 * @param  	array 	the array to sort.
		 * @return 	the sorted array.
		 */
		public static function sortAscending(array:Array): Array
		{
			array.sort(Array.NUMERIC);
			return array;
		}

		/**
		 * Sorts the array of objects ascending through the object's property (must be a numeric value).
		 * <p>This method modifies the original array.</p>
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.ArrayUtil;
		 * 
		 * var arr:Array = [{num:-3}, {num:-2.55}, {num:-2.54}, {num:-1}, {num:0}, {num:1}, {num:2}, {num:3}, {num:4}, {num:4.1}, {num:5}, {num:5.01}, {num:5.02}, {num:6}, {num:7}, {num:8}];
		 * 
		 * ArrayUtil.shuffle(arr)             // [-1,4.1,6,3,-3,4,5.02,8,2,1,5,-2.54,5.01,7,-2.55,0]
		 * 
		 * ArrayUtil.sortAscendingByObjectProperty(arr, "num")
		 * 
		 * arr[0].num     // -3
		 * arr[1].num     // -2.55
		 * arr[2].num     // -2.54
		 * arr[3].num     // -1
		 * arr[4].num     // 0
		 * arr[5].num     // 1
		 * arr[6].num     // 2
		 * arr[7].num     // 3
		 * arr[8].num     // 4
		 * arr[9].num     // 4.1
		 * arr[10].num    // 5
		 * arr[11].num    // 5.01
		 * arr[12].num    // 5.02
		 * arr[13].num    // 6
		 * arr[14].num    // 7
		 * arr[15].num    // 8
		 * </listing>
		 * 
		 * @param  	array 		the array to sort.
		 * @param 	property 	the name of the property to be recovered and compared between the objects.
		 * @return 	the sorted array.
		 */
		public static function sortAscendingByObjectProperty(array:Array, property:String): Array
		{
			array.sortOn(property, Array.NUMERIC);
			return array;
		}

		/**
		 * Sorts the array of <code>Number</code> objects descending.
		 * <p>This method modifies the original array.</p>
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.ArrayUtil;
		 * 
		 * var arr:Array = [-3, -2.55, -2.54, -1, 0, 1, 2, 3, 4, 4.1, 5, 5.01, 5.02, 6, 7, 8];
		 * 
		 * ArrayUtil.shuffle(arr)           // [-1,4.1,6,3,-3,4,5.02,8,2,1,5,-2.54,5.01,7,-2.55,0]
		 * 
		 * ArrayUtil.sortDescending(arr)    // [8,7,6,5.02,5.01,5,4.1,4,3,2,1,0,-1,-2.54,-2.55,-3]
		 * </listing>
		 * 
		 * @param  	array 	the array to sort.
		 * @return 	the sorted array.
		 */
		public static function sortDescending(array:Array): Array
		{
			array.sort(Array.NUMERIC | Array.DESCENDING);
			return array;
		}

		/**
		 * Sorts the array of objects descending through the object's property (must be a numeric value).
		 * <p>This method modifies the original array.</p>
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.ArrayUtil;
		 * 
		 * var arr:Array = [{num:-3}, {num:-2.55}, {num:-2.54}, {num:-1}, {num:0}, {num:1}, {num:2}, {num:3}, {num:4}, {num:4.1}, {num:5}, {num:5.01}, {num:5.02}, {num:6}, {num:7}, {num:8}];
		 * 
		 * ArrayUtil.shuffle(arr)             // [-1,4.1,6,3,-3,4,5.02,8,2,1,5,-2.54,5.01,7,-2.55,0]
		 * 
		 * ArrayUtil.sortDescendingByObjectProperty(arr, "num")
		 * 
		 * arr[0].num     // 8
		 * arr[1].num     // 7
		 * arr[2].num     // 6
		 * arr[3].num     // 5.02
		 * arr[4].num     // 5.01
		 * arr[5].num     // 5
		 * arr[6].num     // 4.1
		 * arr[7].num     // 4
		 * arr[8].num     // 3
		 * arr[9].num     // 2
		 * arr[10].num    // 1
		 * arr[11].num    // 0
		 * arr[12].num    // -1
		 * arr[13].num    // -2.54
		 * arr[14].num    // -2.55
		 * arr[15].num    // -3
		 * </listing>
		 * 
		 * @param  	array 		the array to sort.
		 * @param 	property 	the name of the property to be recovered and compared between the objects.
		 * @return 	the sorted array.
		 */
		public static function sortDescendingByObjectProperty(array:Array, property:String): Array
		{
			array.sortOn(property, Array.NUMERIC | Array.DESCENDING);
			return array;
		}

		/**
		 * Swaps the position of the elements.
		 * <p>This method modifies the original array.</p>
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.ArrayUtil;
		 * 
		 * var arr:Array = [1, 9, 3, 7, 5];
		 * 
		 * ArrayUtil.swap(arr, 9, 5)      // [1,5,3,7,9]
		 * 
		 * ArrayUtil.swap(arr, 3, 5)      // [1,3,5,7,9]
		 * </listing>
		 * 
		 * @param  	array 		the array to swap the position of the elements.
		 * @param 	element1 	the first element.
		 * @param 	element2 	the second element.
		 */
		public static function swap(array:Array, element1:*, element2:*): void
		{
			if (isEmpty(array)) return;
			
			var index1:int =  array.indexOf(element1);
			var index2:int =  array.indexOf(element2);
			
			if (index1 == -1 || index2 == -1) return;
			
			array[index1] = element2;
			array[index2] = element1;
		}

		/**
		 * Swaps the position of the elements in the specified indexes.
		 * <p>This method modifies the original array.</p>
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.ArrayUtil;
		 * 
		 * var arr:Array = [1, 9, 3, 7, 5];
		 * 
		 * ArrayUtil.swapAt(arr, 1, 4)      // [1,5,3,7,9]
		 * 
		 * ArrayUtil.swapAt(arr, 2, 1)      // [1,3,5,7,9]
		 * </listing>
		 * 
		 * @param  	array 	the array to swap the position of the elements.
		 * @param 	index1 	the index of the first element.
		 * @param 	index2 	the index of the second element.
		 */
		public static function swapAt(array:Array, index1:*, index2:*): void
		{
			if (isEmpty(array)) return;
			
			if (index1 < 0 || index1 >= array.length) return; 
			if (index2 < 0 || index2 >= array.length) return;
			
			var element1:* =  array[index1];
			var element2:* =  array[index2];
			
			array[index1] = element2;
			array[index2] = element1;
		}

		/**
		 * Swaps the position of all elements in the array according to <code>newPositions</code>.
		 * <p>
		 * <ul><li><code>array[0]</code> will be equal <code>array[ newPositions[0] ]</code></li>
		 * <li><code>array[1]</code> will be equal <code>array[ newPositions[1] ]</code></li>
		 * <li>and so on...</li></ul></p>
		 * <p>The length of both arrays must be equal.</p>
		 * <p>This method modifies the original array.</p>
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.ArrayUtil;
		 * 
		 * var arr:Array = ["c", "a", "b", "e", "d"];
		 * 
		 * var positions:Array = [1, 2, 0, 4, 3];
		 * 
		 * ArrayUtil.swapPositions(arr, positions)     // [a,b,c,d,e]
		 * </listing>
		 * 
		 * @param  	array 			the array to swap the position of all elements.
		 * @param 	newPositions 	the array with the new positions.
		 */
		public static function swapPositions(array:Array, newPositions:Array): void
		{
			if (isEmpty(array) || isEmpty(newPositions)) return;
			if (array.length != newPositions.length) return;
			
			var i:int;
			var n:int = array.length;
			var c:Array = array.concat();
			
			array.splice(0);
			
			for (i = 0; i < n; i++)
			{
				array.push(c[newPositions[i]]);
			}
		}

		/**
		 * Creates a new array containing only unique instances of the objects in the given array. In other words, removes duplicated objects.
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.ArrayUtil;
		 * 
		 * var arr:Array = ["a", "b", "c", "a", "b", "a"];
		 * 
		 * ArrayUtil.uniqueCopy(arr)    // [a,b,c]
		 * </listing>
		 * 
		 * @param  	array 	the array to copy.
		 * @return 	a new array without duplicated objects.
		 */
		public static function uniqueCopy(array:Array): Array
		{
			var e:*;
			var i:int;
			var n:int = array.length;
			var newArray:Array = [];
			
			for (i = 0; i < n; i++)
			{
				e = array[i];
				if (newArray.indexOf(e) == -1) newArray.push(e);
			}
			
			return newArray;
		}
		//TODO:_containsOnlyType() and _containsType() are equal. refactor.
		//TODO: pensar em otimizar performance matando esse if daqui dos metodos e colocando no momento de passar o metodo. ou seja, criar um método que usa strict e outro q nao usa.
		/**
		 * @private
		 */
		private static function _containsOnlyType(element:*, index:int, arr:Array): Boolean
		{
			if (_strictCheckType)
			{
				return ReflectionUtil.classPathEquals(element, _checkType);
			}
			else
			{
				return (element is _checkType);
			}
		}

		/**
		 * @private
		 */
		private static function _containsType(element:*, index:int, arr:Array): Boolean
		{
			if (_strictCheckType)
			{
				return ReflectionUtil.classPathEquals(element, _checkType);
			}
			else
			{
				return (element is _checkType);
			}
		}

	}

}