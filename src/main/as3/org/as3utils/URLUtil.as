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
	import flash.net.URLRequest;
	import flash.net.navigateToURL;

	/**
	 * A utility class to work with <code>URL</code> strings.
	 * 
	 * @author Flávio Silva
	 */
	public final class URLUtil
	{
		private static const HTTP_PROTOCOL:String = "http://";
		private static const HTTPS_PROTOCOL:String = "https://";
		
		/**
		 * URLUtil is a static class and shouldn't be instantiated.
		 * 
		 * @throws 	IllegalOperationError 	URLUtil is a static class and shouldn't be instantiated.
		 */
		public function URLUtil()
		{
			throw new IllegalOperationError("URLUtil is a static class and shouldn't be instantiated.");
		}
		
		public static function appendVar(url:String, varName:String, varValue:String):String
		{
			if (url == null) throw new ArgumentError("Argument <url> must not be null.");
			
			var c:String = (url.indexOf("?") != -1) ? "&" : "?";
			return url += c + varName + "=" + varValue;
		}
		
		public static function getURLRequest(url:String):URLRequest
		{
			return new URLRequest(url);
		}
		
		public static function isHttp(url:String):Boolean
		{
			return url.indexOf(HTTP_PROTOCOL) != -1;
		}
		
		public static function isHttps(url:String):Boolean
		{
			return url.indexOf(HTTPS_PROTOCOL) != -1;
		}
		
		public static function navigateToURL(url:String, window:String = null):void
		{
			flash.net.navigateToURL(getURLRequest(url), window);
		}
		
	}

}