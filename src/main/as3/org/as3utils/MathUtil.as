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
	 * A utility class for working with mathematical operations.
	 * 
	 * @author Flávio Silva
	 */
	public class MathUtil
	{
		private static const SECOND:int = 1000;

		/**
		 * MathUtil is a static class and shouldn't be instantiated.
		 * 
		 * @throws 	IllegalOperationError 	MathUtil is a static class and shouldn't be instantiated.
		 */
		public function MathUtil()
		{
			throw new IllegalOperationError("MathUtil is a static class and shouldn't be instantiated.");
		}
		
		/**
		 * Converts degrees to radians.
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.MathUtil;
		 * 
		 * MathUtil.degreesToRadians(null)    // 0
		 * MathUtil.degreesToRadians(0)       // 0
		 * MathUtil.degreesToRadians(1)       // 0.017453292519943295
		 * MathUtil.degreesToRadians(1, 0)    // 0
		 * MathUtil.degreesToRadians(1, 1)    // 0
		 * MathUtil.degreesToRadians(1, 2)    // 0.02
		 * MathUtil.degreesToRadians(1, 3)    // 0.017
		 * MathUtil.degreesToRadians(1.5)     // 0.02617993877991494
		 * MathUtil.degreesToRadians(30)      // 0.5235987755982988
		 * MathUtil.degreesToRadians(-8)      // -0.13962634015954636
		 * </listing>
		 * 
		 * @param  	degrees 		the number of degrees to be converted.
		 * @param 	decimalPlaces 	the number of decimal places.
		 * @return 	the number of degrees converted to radians.
		 */
		public static function degreesToRadians(degrees:Number, decimalPlaces:int = 18): Number
		{
			return Number((degrees * Math.PI / 180).toFixed(decimalPlaces));
		}

		/**
		 * Converts milliseconds to seconds.
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.MathUtil;
		 * 
		 * MathUtil.millisecondsToSeconds(null)        // 0
		 * MathUtil.millisecondsToSeconds(0)           // 0
		 * MathUtil.millisecondsToSeconds(1)           // 0
		 * MathUtil.millisecondsToSeconds(300)         // 0
		 * MathUtil.millisecondsToSeconds(300, 1)      // 0.3
		 * MathUtil.millisecondsToSeconds(500)         // 1
		 * MathUtil.millisecondsToSeconds(500, 1)      // 0.5
		 * MathUtil.millisecondsToSeconds(1000)        // 1
		 * MathUtil.millisecondsToSeconds(1000, 1)     // 1
		 * MathUtil.millisecondsToSeconds(1500)        // 2
		 * MathUtil.millisecondsToSeconds(1500, 1)     // 1.5
		 * MathUtil.millisecondsToSeconds(1500, 2)     // 1.5
		 * MathUtil.millisecondsToSeconds(2123)        // 2
		 * MathUtil.millisecondsToSeconds(2123, 1)     // 2.1
		 * MathUtil.millisecondsToSeconds(2123, 2)     // 2.12
		 * MathUtil.millisecondsToSeconds(-2123)       // -2
		 * MathUtil.millisecondsToSeconds(-2123, 1)    // -2.1
		 * </listing>
		 * 
		 * @param  	milliseconds 	the number of milliseconds to be converted.
		 * @param  	decimalPlaces 	the number of decimal places.
		 * @return 	the number of milliseconds converted to seconds.
		 */
		public static function millisecondsToSeconds(milliseconds:Number, decimalPlaces:int = 0): Number
		{
			return Number((milliseconds / SECOND).toFixed(decimalPlaces));
		}

		/**
		 * Returns the number that corresponds to the percentage in a given range.
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.MathUtil;
		 * 
		 * MathUtil.percentToRange(50, 0, 100)                           // 50
		 * MathUtil.percentToRange(50, 100, 200)                         // 150
		 * MathUtil.percentToRange(1, 26, 77)                            // 26.51
		 * MathUtil.percentToRange(33, 26, 77)                           // 42.83
		 * MathUtil.percentToRange(33, 26, 77, NumericRounding.FLOOR)    // 42
		 * </listing>
		 * 
		 * @param  	percent 	the percent to be used in the range.
		 * @param  	min 		the begin of the range.
		 * @param  	max 		the end of the range.
		 * @param  	rounding 	determines whether the number should be rounded.
		 * @return 	the number that corresponds to the percentage in the range.
		 */
		public static function percentToRange(percent:Number, min:Number, max:Number, rounding:NumericRounding = null): Number
		{
			var n:Number = ((percent / 100) * (max - min)) + min;
			if (rounding) n = NumberUtil.round(n, rounding);
			return n;
		}

		/**
		 * Converts radians to degrees.
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.MathUtil;
		 * 
		 * MathUtil.radiansToDegrees(null)    // 0
		 * MathUtil.radiansToDegrees(0)       // 0
		 * MathUtil.radiansToDegrees(1)       // 57.29577951308232
		 * MathUtil.radiansToDegrees(1, 0)    // 57
		 * MathUtil.radiansToDegrees(1, 1)    // 57.3
		 * MathUtil.radiansToDegrees(1, 2)    // 57.3
		 * MathUtil.radiansToDegrees(1, 3)    // 57.296
		 * MathUtil.radiansToDegrees(1.5)     // 85.94366926962348
		 * MathUtil.radiansToDegrees(30)      // 1718.8733853924698
		 * MathUtil.radiansToDegrees(-8)      // -458.3662361046586
		 * </listing>
		 * 
		 * @param  	degrees 		the number of degrees to be converted.
		 * @param 	decimalPlaces 	the number of decimal places.
		 * @return 	the number of radians converted to degrees.
		 */
		public static function radiansToDegrees(radians:Number, decimalPlaces:int = 18): Number
		{
			return Number((radians * 180 / Math.PI).toFixed(decimalPlaces));
		}

		/**
		 * Returns the percentage corresponding to the number in a given range.
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.MathUtil;
		 * 
		 * MathUtil.rangeToPercent(50, 0, 100)                           // 50
		 * MathUtil.rangeToPercent(50, 100, 200)                         // -50
		 * MathUtil.rangeToPercent(150, 100, 200)                        // 50
		 * MathUtil.rangeToPercent(27, 26, 77)                           // 1.9607843137254901
		 * MathUtil.rangeToPercent(33, 26, 77)                           // 13.725490196078432
		 * MathUtil.rangeToPercent(33, 26, 77, NumericRounding.FLOOR)    // 13
		 * MathUtil.rangeToPercent(51.5, 26, 77)                         // 50
		 * </listing>
		 * 
		 * @param  	num 		the number to be used in the range.
		 * @param  	min 		the begin of the range.
		 * @param  	max 		the end of the range.
		 * @param  	rounding 	determines whether the number should be rounded.
		 * @return 	the percentage that corresponds to the number in the range.
		 */
		public static function rangeToPercent(num:Number, min:Number, max:Number, rounding:NumericRounding = null): Number
		{
			var n:Number = (num - min) / (max - min) * 100;
			if (rounding) n = NumberUtil.round(n, rounding);
			return n;
		}

	}

}