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
	 * A utility class for working with conversion of bytes.
	 * 
	 * @author Flávio Silva
	 */
	public class ByteConversionUtil
	{
		/**
		 * Defines the value of 1 gigabyte in bytes.
		 */
		public static const GIGABYTE: Number = 1073741824;

		/**
		 * Defines the value of 1 kilobyte in bytes.
		 */
		public static const KILOBYTE: Number = 1024;

		/**
		 * Defines the value of 1 megabyte in bytes.
		 */
		public static const MEGABYTE: Number = 1048576;

		/**
		 * Defines the value of 1 terabyte in bytes.
		 */
		public static const TERABYTE: Number = 1099511627776;

		/**
		 * ByteConversionUtil is a static class and shouldn't be instantiated.
		 * 
		 * @throws 	IllegalOperationError 	ByteConversionUtil is a static class and shouldn't be instantiated.
		 */
		public function ByteConversionUtil()
		{
			throw new IllegalOperationError("ByteConversionUtil is a static class and shouldn't be instantiated.");
		}

		/**
		 * Converts the number of bytes to gigabytes.
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.ByteConversionUtil;
		 * 
		 * var num:Number;
		 * 
		 * trace("num: " + num)                               // NaN
		 * 
		 * ByteConversionUtil.bytesToGigabytes(null)          // 0
		 * ByteConversionUtil.bytesToGigabytes(num)           // NaN
		 * ByteConversionUtil.bytesToGigabytes(0)             // 0
		 * ByteConversionUtil.bytesToGigabytes(1)             // 0.1
		 * ByteConversionUtil.bytesToGigabytes(1, 0)          // 1
		 * ByteConversionUtil.bytesToGigabytes(1024)          // 0.1
		 * ByteConversionUtil.bytesToGigabytes(2048)          // 0
		 * ByteConversionUtil.bytesToGigabytes(2048, 2)       // 0
		 * ByteConversionUtil.bytesToGigabytes(35347)         // 0
		 * ByteConversionUtil.bytesToGigabytes(353470)        // 0
		 * ByteConversionUtil.bytesToGigabytes(3534701)       // 0
		 * ByteConversionUtil.bytesToGigabytes(35347012)      // 0
		 * ByteConversionUtil.bytesToGigabytes(353470123)     // 0.3
		 * ByteConversionUtil.bytesToGigabytes(3534701234)    // 3.3
		 * </listing>
		 * 
		 * @param 	bytes 			the number of bytes to be converted.
		 * @param 	decimalPlaces 	the number of decimal places.
		 * @return 	the number of bytes converted to gigabytes.
		 */
		public static function bytesToGigabytes(bytes:Number, decimalPlaces:int = 1): Number
		{
			return Number((bytes / GIGABYTE).toFixed(decimalPlaces));
		}

		/**
		 * Converts the number of bytes to kilobytes.
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.ByteConversionUtil;
		 * 
		 * var num:Number;
		 * 
		 * trace("num: " + num)                               // NaN
		 * 
		 * ByteConversionUtil.bytesToKilobytes(null)          // 0
		 * ByteConversionUtil.bytesToKilobytes(num)           // NaN
		 * ByteConversionUtil.bytesToKilobytes(0)             // 0
		 * ByteConversionUtil.bytesToKilobytes(1)             // 0.1
		 * ByteConversionUtil.bytesToKilobytes(1, 0)          // 1
		 * ByteConversionUtil.bytesToKilobytes(1000)          // 1
		 * ByteConversionUtil.bytesToKilobytes(1024)          // 1
		 * ByteConversionUtil.bytesToKilobytes(2048)          // 2
		 * ByteConversionUtil.bytesToKilobytes(2048, 2)       // 2
		 * ByteConversionUtil.bytesToKilobytes(2560)          // 2.5
		 * ByteConversionUtil.bytesToKilobytes(2560, 2)       // 2.5
		 * ByteConversionUtil.bytesToKilobytes(2560, 3)       // 2.5
		 * ByteConversionUtil.bytesToKilobytes(2363)          // 2.3
		 * ByteConversionUtil.bytesToKilobytes(2363, 0)       // 2
		 * ByteConversionUtil.bytesToKilobytes(2363, 2)       // 2.31
		 * ByteConversionUtil.bytesToKilobytes(2363, 3)       // 2.308
		 * ByteConversionUtil.bytesToKilobytes(2963)          // 2.9
		 * ByteConversionUtil.bytesToKilobytes(2963, 0)       // 3
		 * ByteConversionUtil.bytesToKilobytes(35347)         // 34.5
		 * ByteConversionUtil.bytesToKilobytes(353470)        // 345.2
		 * ByteConversionUtil.bytesToKilobytes(3534701)       // 3451.9
		 * ByteConversionUtil.bytesToKilobytes(35347012)      // 34518.6
		 * ByteConversionUtil.bytesToKilobytes(353470123)     // 345185.7
		 * ByteConversionUtil.bytesToKilobytes(3534701234)    // 3451856.7
		 * </listing>
		 * 
		 * @param 	bytes 			the number of bytes to be converted.
		 * @param 	decimalPlaces 	the number of decimal places.
		 * @return 	the number of bytes converted to kilobytes.
		 */
		public static function bytesToKilobytes(bytes:Number, decimalPlaces:int = 1): Number
		{
			return Number((bytes / KILOBYTE).toFixed(decimalPlaces));
		}

		/**
		 * Converts the number of bytes to megabytes.
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.ByteConversionUtil;
		 * 
		 * var num:Number;
		 * 
		 * trace("num: " + num)                               // NaN
		 * 
		 * ByteConversionUtil.bytesToMegabytes(null)          // 0
		 * ByteConversionUtil.bytesToMegabytes(num)           // NaN
		 * ByteConversionUtil.bytesToMegabytes(0)             // 0
		 * ByteConversionUtil.bytesToMegabytes(1)             // 0.1
		 * ByteConversionUtil.bytesToMegabytes(1, 0)          // 1
		 * ByteConversionUtil.bytesToMegabytes(1024)          // 0.1
		 * ByteConversionUtil.bytesToMegabytes(2048)          // 0
		 * ByteConversionUtil.bytesToMegabytes(2048, 1)       // 0
		 * ByteConversionUtil.bytesToMegabytes(2048, 2)       // 0
		 * ByteConversionUtil.bytesToMegabytes(2363)          // 0
		 * ByteConversionUtil.bytesToMegabytes(2363, 0)       // 0
		 * ByteConversionUtil.bytesToMegabytes(2363, 2)       // 0
		 * ByteConversionUtil.bytesToMegabytes(2363, 3)       // 0.002
		 * ByteConversionUtil.bytesToMegabytes(35347)         // 0
		 * ByteConversionUtil.bytesToMegabytes(353470)        // 0.3
		 * ByteConversionUtil.bytesToMegabytes(3534701)       // 3.4
		 * ByteConversionUtil.bytesToMegabytes(35347012)      // 33.7
		 * ByteConversionUtil.bytesToMegabytes(353470123)     // 337.1
		 * ByteConversionUtil.bytesToMegabytes(3534701234)    // 3371
		 * </listing>
		 * 
		 * @param 	bytes 			the number of bytes to be converted.
		 * @param 	decimalPlaces 	the number of decimal places.
		 * @return 	the number of bytes converted to megabytes.
		 */
		public static function bytesToMegabytes(bytes:Number, decimalPlaces:int = 1): Number
		{
			return Number((bytes / MEGABYTE).toFixed(decimalPlaces));
		}

		/**
		 * Converts the number of bytes to terabytes.
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.ByteConversionUtil;
		 * 
		 * var num:Number;
		 * 
		 * trace("num: " + num)                                  // NaN
		 * 
		 * ByteConversionUtil.bytesToTerabytes(null)             // 0
		 * ByteConversionUtil.bytesToTerabytes(num)              // NaN
		 * ByteConversionUtil.bytesToTerabytes(0)                // 0
		 * ByteConversionUtil.bytesToTerabytes(1)                // 0.1
		 * ByteConversionUtil.bytesToTerabytes(1, 0)             // 1
		 * ByteConversionUtil.bytesToTerabytes(1024)             // 0.1
		 * ByteConversionUtil.bytesToTerabytes(2048)             // 0
		 * ByteConversionUtil.bytesToTerabytes(2048, 1)          // 0
		 * ByteConversionUtil.bytesToTerabytes(2048, 2)          // 0
		 * ByteConversionUtil.bytesToTerabytes(35347)            // 0
		 * ByteConversionUtil.bytesToTerabytes(353470)           // 0
		 * ByteConversionUtil.bytesToTerabytes(3534701)          // 0
		 * ByteConversionUtil.bytesToTerabytes(35347012)         // 0
		 * ByteConversionUtil.bytesToTerabytes(353470123)        // 0
		 * ByteConversionUtil.bytesToTerabytes(3534701234)       // 0
		 * ByteConversionUtil.bytesToTerabytes(35347012345)      // 0
		 * ByteConversionUtil.bytesToTerabytes(353470123456)     // 0.3
		 * ByteConversionUtil.bytesToTerabytes(3534701234567)    // 3.2
		 * </listing>
		 * 
		 * @param 	bytes 			the number of bytes to be converted.
		 * @param 	decimalPlaces 	the number of decimal places.
		 * @return 	the number of bytes converted to terabytes.
		 */
		public static function bytesToTerabytes(bytes:Number, decimalPlaces:int = 1): Number
		{
			return Number((bytes / TERABYTE).toFixed(decimalPlaces));
		}

		/**
		 * Converts the number of gigabytes to bytes.
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.ByteConversionUtil;
		 * 
		 * ByteConversionUtil.gigabytesToBytes(null)      // 0
		 * ByteConversionUtil.gigabytesToBytes(0.1)       // 107374182
		 * ByteConversionUtil.gigabytesToBytes(0.1, 1)    // 107374182.4
		 * ByteConversionUtil.gigabytesToBytes(1)         // 1073741824
		 * ByteConversionUtil.gigabytesToBytes(1.1)       // 1181116006
		 * ByteConversionUtil.gigabytesToBytes(1.1, 1)    // 1181116006.4
		 * ByteConversionUtil.gigabytesToBytes(1.5)       // 1610612736
		 * ByteConversionUtil.gigabytesToBytes(1.5, 1)    // 1610612736
		 * ByteConversionUtil.gigabytesToBytes(2)         // 2147483648
		 * </listing>
		 * 
		 * @param 	gigabytes		the number of gigabytes to be converted.
		 * @param 	decimalPlaces 	the number of decimal places.
		 * @return 	the number of gigabytes converted to bytes.
		 */
		public static function gigabytesToBytes(gigabytes:Number, decimalPlaces:int = 0): Number
		{
			return Number((gigabytes * GIGABYTE).toFixed(decimalPlaces));
		}

		/**
		 * Converts the number of kilobytes to bytes.
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.ByteConversionUtil;
		 * 
		 * ByteConversionUtil.kilobytesToBytes(null)      // 0
		 * ByteConversionUtil.kilobytesToBytes(1)         // 1024
		 * ByteConversionUtil.kilobytesToBytes(1.1)       // 1126
		 * ByteConversionUtil.kilobytesToBytes(1.1, 1)    // 1126.4
		 * ByteConversionUtil.kilobytesToBytes(1.5)       // 1536
		 * ByteConversionUtil.kilobytesToBytes(1.5, 1)    // 1536
		 * ByteConversionUtil.kilobytesToBytes(2)         // 2048
		 * </listing>
		 * 
		 * @param 	kilobytes		the number of kilobytes to be converted.
		 * @param 	decimalPlaces 	the number of decimal places.
		 * @return 	the number of kilobytes converted to bytes.
		 */
		public static function kilobytesToBytes(kilobytes:Number, decimalPlaces:int = 0): Number
		{
			return Number((kilobytes * KILOBYTE).toFixed(decimalPlaces));
		}

		/**
		 * Converts the number of megabytes to bytes.
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.ByteConversionUtil;
		 * 
		 * ByteConversionUtil.megabytesToBytes(null)      // 0
		 * ByteConversionUtil.megabytesToBytes(0.1)       // 104858
		 * ByteConversionUtil.megabytesToBytes(0.1, 1)    // 104857.6
		 * ByteConversionUtil.megabytesToBytes(1)         // 1048576
		 * ByteConversionUtil.megabytesToBytes(1.1)       // 1153434
		 * ByteConversionUtil.megabytesToBytes(1.1, 1)    // 1153433.6
		 * ByteConversionUtil.megabytesToBytes(1.5)       // 1572864
		 * ByteConversionUtil.megabytesToBytes(1.5, 1)    // 1572864
		 * ByteConversionUtil.megabytesToBytes(2)         // 2097152
		 * </listing>
		 * 
		 * @param 	megabytes		the number of megabytes to be converted.
		 * @param 	decimalPlaces 	the number of decimal places.
		 * @return 	the number of megabytes converted to bytes.
		 */
		public static function megabytesToBytes(megabytes:Number, decimalPlaces:int = 0): Number
		{
			return Number((megabytes * MEGABYTE).toFixed(decimalPlaces));
		}

		/**
		 * Converts the number of terabytes to bytes.
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.ByteConversionUtil;
		 * 
		 * ByteConversionUtil.terabytesToBytes(null)      // 0
		 * ByteConversionUtil.terabytesToBytes(0.1)       // 109951162778
		 * ByteConversionUtil.terabytesToBytes(0.1, 1)    // 109951162777.6
		 * ByteConversionUtil.terabytesToBytes(1)         // 1099511627776
		 * ByteConversionUtil.terabytesToBytes(1.1)       // 1209462790554
		 * ByteConversionUtil.terabytesToBytes(1.1, 1)    // 1209462790553.6
		 * ByteConversionUtil.terabytesToBytes(1.5)       // 1649267441664
		 * ByteConversionUtil.terabytesToBytes(1.5, 1)    // 1649267441664
		 * ByteConversionUtil.terabytesToBytes(2)         // 2199023255552
		 * </listing>
		 * 
		 * @param 	terabytes		the number of terabytes to be converted.
		 * @param 	decimalPlaces 	the number of decimal places.
		 * @return 	the number of terabytes converted to bytes.
		 */
		public static function terabytesToBytes(terabytes:Number, decimalPlaces:int = 0): Number
		{
			return Number((terabytes * TERABYTE).toFixed(decimalPlaces));
		}

	}

}