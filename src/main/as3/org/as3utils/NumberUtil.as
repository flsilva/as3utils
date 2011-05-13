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
	import org.as3coreaddendum.system.NumericRounding;

	import flash.errors.IllegalOperationError;

	/**
	 * A utility class to work with <code>Number</code> objects.
	 * 
	 * @author Flávio Silva
	 */
	public final class NumberUtil
	{
		/**
		 * NumberUtil is a static class and shouldn't be instantiated.
		 * 
		 * @throws 	IllegalOperationError 	NumberUtil is a static class and shouldn't be instantiated.
		 */
		public function NumberUtil()
		{
			throw new IllegalOperationError("NumberUtil is a static class and shouldn't be instantiated.");
		}

		/**
		 * Checks if the value of the <code>Number</code> object is NaN(not a number).
		 * <p>This method uses the native AS3 <code>isNaN()</code> global function</p>
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.NumberUtil;
		 * 
		 * var num:Number;
		 * 
		 * trace("num: " + num)            // NaN
		 * 
		 * NumberUtil.isNotNumber(null)    // false
		 * NumberUtil.isNotNumber(num)     // true
		 * NumberUtil.isNotNumber(1)       // false
		 * NumberUtil.isNotNumber(-1)      // false
		 * NumberUtil.isNotNumber(NaN)     // true
		 * </listing>
		 * 
		 * @param  	num 	 a <code>Number</code> object to evaluate.
		 * @return 	<code>true</code> if the value is NaN (not a number) and <code>false</code> otherwise.
		 */
		public static function isNotNumber(num:Number): Boolean
		{
			return isNaN(num);
		}

		/**
		 * Checks if the value of the <code>Number</code> object is a number.
		 * <p>This method uses the native AS3 <code>isNaN()</code> global function</p>
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.NumberUtil;
		 * 
		 * var num:Number;
		 * 
		 * trace("num: " + num)         // NaN
		 * 
		 * NumberUtil.isNumber(null)    // true
		 * NumberUtil.isNumber(num)     // false
		 * NumberUtil.isNumber(1)       // true
		 * NumberUtil.isNumber(-1)      // true
		 * NumberUtil.isNumber(NaN)     // false
		 * </listing>
		 * 
		 * @param  	num 	 a <code>Number</code> object to evaluate.
		 * @return 	<code>true</code> if the value is a number and <code>false</code> if it is NaN (not a number).
		 */
		public static function isNumber(num:Number): Boolean
		{
			return !isNaN(num);
		}
		
		
		public static function isEven(value:Number):Boolean
		{
			return Boolean(value % 2);
		}
		
		public static function isOdd(value:Number):Boolean
		{
			return !Boolean(value % 2);
		}

		public static function round(num:Number, rounding:NumericRounding):Number
		{
			if (!rounding) throw new ArgumentError("The 'rounding' argument must not be 'null'.");
			
			switch(rounding)
			{
				case NumericRounding.FLOOR:
				{
					return Math.floor(num);
				}
				
				case NumericRounding.ROUND:
				{
					return Math.round(num);
				}
				
				case NumericRounding.CEIL:
				{
					return Math.ceil(num);
				}
				
				default:
				{
					return num;
				}
			}
		}

		//TODO: opção de quantos zeros. por ex: 01, 001, 009, 010
		//TODO: ASDOC
		public static function zeroPrecedent(num:Number, lessThan:Number = 10): String
		{
			var n:String = String(num);
			if (num < lessThan) n = "0" + num;
			return n;
		}

	}

}