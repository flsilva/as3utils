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
	 * A utility class to work with <code>Boolean</code> objects.
	 * 
	 * @author Flávio Silva
	 */
	public class BooleanUtil
	{

		/**
		 * BooleanUtil is a static class and shouldn't be instantiated.
		 * 
		 * @throws 	IllegalOperationError 	BooleanUtil is a static class and shouldn't be instantiated.
		 */
		public function BooleanUtil()
		{
			throw new IllegalOperationError("BooleanUtil is a static class and shouldn't be instantiated.");
		}
		
		public static function isBooleanString(value:String): Boolean
		{
			if (!value) return false;
			return value.toLowerCase() == "false" || value.toLowerCase() == "true";
		}
		
		public static function string2Boolean(value:String): Boolean
		{
			if (!value) return false;
			return value.toLowerCase() == "true";
		}

	}

}