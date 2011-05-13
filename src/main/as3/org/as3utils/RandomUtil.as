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
	import flash.errors.IllegalOperationError;
	
	/**
	 * A utility class for working with random numbers.
	 * 
	 * @author Flávio Silva
	 */
	public class RandomUtil
	{
		/**
		 * RandomUtil is a static class and shouldn't be instantiated.
		 * 
		 * @throws 	IllegalOperationError 	RandomUtil is a static class and shouldn't be instantiated.
		 */
		public function RandomUtil()
		{
			throw new IllegalOperationError("RandomUtil is a static class and shouldn't be instantiated.");
		}

		/**
		 * Returns a random number between a range.
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.RandomUtil;
		 * 
		 * RandomUtil.random(0, 10)              // 3
		 * RandomUtil.random(0, 10)              // 0
		 * RandomUtil.random(0, 10)              // 10
		 * RandomUtil.random(0, 10, 1)           // 0.9
		 * RandomUtil.random(0, 10, 1)           // 9.6
		 * RandomUtil.random(0, 10, 1)           // 5.4
		 * RandomUtil.random(0, 10, 2)           // 2.87
		 * RandomUtil.random(0, 10, 3)           // 4.602
		 * RandomUtil.random(-13, 11, 1)         // -9.8
		 * RandomUtil.random(-13, 11, 1)         // -12.9
		 * RandomUtil.random(-13, 11, 1)         // 10.6
		 * RandomUtil.random(-1000, 1000, 1)     // 273.6
		 * RandomUtil.random(-1000, 1000, 1)     // -847.2
		 * RandomUtil.random(-20, -10)           // -15
		 * </listing>
		 * 
		 * @param  	min 			the begin of the range.
		 * @param  	max 			the end of the range.
		 * @param 	decimalPlaces 	the number of decimal places.
		 * @throws 	ArgumentError 	if the <code>max</code> argument is less than the <code>min</code> argument.
		 * @return 	a random number between the range (min, max).
		 */
		public static function random(min:Number, max:Number, decimalPlaces:int = 0): Number
		{
			if (min >= max) throw new ArgumentError("The 'max' argument must be greater than the 'min' argument. Received: min(" + min + ") max(" + max + ")");
			
			return Number((min + (Math.random() * (max - min))).toFixed(decimalPlaces));
		}

		/**
		 * Returns an array of random numbers that can be repeated.
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.RandomUtil;
		 * 
		 * RandomUtil.randomArray(0, 10, 5)             // [7,5,3,3,9]
		 * RandomUtil.randomArray(0, 10, 5, 1)          // [5.6,4.6,8.7,3.5,0.9]
		 * RandomUtil.randomArray(10, 20, 5)            // [16,10,15,16,16]
		 * RandomUtil.randomArray(-10, 10, 5)           // [-7,-4,-10,7,-3]
		 * RandomUtil.randomArray(-7, 4, 5)             // [-2,-7,2,2,3]
		 * RandomUtil.randomArray(-7, 4, 5, 2)          // [-4.88,-4.98,3.38,-0.3,2.41]
		 * RandomUtil.randomArray(-20, -10, 5)          // [-15,-14,-18,-13,-15]
		 * RandomUtil.randomArray(-1000, 1000, 5, 2)    // [146.31,-839.97,-85.05,-525.63,-739.22]
		 * </listing>
		 * 
		 * @param  	min 			the begin of the range.
		 * @param  	max 			the end of the range.
		 * @param  	length 			the length of the array, must be greater than zero.
		 * @param  	decimalPlaces 	the number of decimal places.
		 * @throws 	ArgumentError 	if the <code>length</code> argument is less than zero.
		 * @return 	an array of random numbers that can be repeated.
		 */
		public static function randomArray(min:Number, max:Number, length:int, decimalPlaces:int = 0): Array
		{
			if (length < 1) throw new ArgumentError("The 'length' argument must be greater than zero.");
			
			var arr:Array = [];
			var i:int;
			
			for (i = 0; i < length; i++)
			{
				arr.push(Number((min + (Math.random() * (max - min))).toFixed(decimalPlaces)));
			}
			
			return arr;
		}

	}

}