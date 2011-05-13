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
	import org.as3coreaddendum.system.StringCase;

	import flash.errors.IllegalOperationError;

	/**
	 * A utility class to work with <code>String</code> objects.
	 * <p>StringUtil handles <code>null</code> input Strings quietly. That is to say that a <code>null</code> input will return <code>null</code>.
	 * Where a <code>Boolean</code> or <code>int</code> is being returned details vary by method.</p>
	 * <p>Some terms used by this class related to <code>String</code> handling:</p>
	 * <p><ul>
	 * <li>empty: a zero-length <code>String</code> ("")</li>
	 * <li>space: the space character (" ", char 32)</li>
	 * <li>blank: a <code>String</code> object only with control chars (space, \t, \n, \s)</li>
	 * </ul></p>
	 * 
	 * @author Flávio Silva
	 */
	public final class StringUtil
	{
		private static const REGEXP_LTRIM:RegExp = /^(\s|\n|\t|\r)*/g;
		private static const REGEXP_RTRIM:RegExp = /(\s|\n|\t|\r)*$/g;
		
		/**
		 * StringUtil is a static class and shouldn't be instantiated.
		 * 
		 * @throws 	IllegalOperationError 	StringUtil is a static class and shouldn't be instantiated.
		 */
		public function StringUtil()
		{
			throw new IllegalOperationError("StringUtil is a static class and shouldn't be instantiated.");
		}

		/**
		 * Abbreviates a <code>String</code> object using ellipses.
		 * 
		 * @example
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.StringUtil;
		 * 
		 * StringUtil.abbreviate(null          , 4)    // null
		 * StringUtil.abbreviate(""            , 4)    // 
		 * StringUtil.abbreviate(" "           , 4)    //  
		 * StringUtil.abbreviate("a"           , 4)    // a
		 * StringUtil.abbreviate("ab"          , 4)    // ab
		 * StringUtil.abbreviate("abcdefghij"  , 4)    // a...
		 * StringUtil.abbreviate("abcdefghij"  , 5)    // ab...
		 * StringUtil.abbreviate(" abcdefghij" , 5)    //  a...
		 * StringUtil.abbreviate("a bcdefghij" , 5)    // a...
		 * StringUtil.abbreviate(" a bcdefghij", 5)    //  a...
		 * StringUtil.abbreviate("abcdefghij"  , 6)    // abc...
		 * StringUtil.abbreviate(" abcdefghij" , 6)    //  ab...
		 * StringUtil.abbreviate("a bcdefghij" , 6)    // a b...
		 * StringUtil.abbreviate(" a bcdefghij", 6)    //  a...
		 * StringUtil.abbreviate("abcdefghij"  , 7)    // abcd...
		 * StringUtil.abbreviate("abcdefghij"  , 8)    // abcde...
		 * StringUtil.abbreviate("abcdefghij"  , 9)    // abcdef...
		 * StringUtil.abbreviate("abcdefghij"  , 10)   // abcdefghij
		 * StringUtil.abbreviate("abcdefghij"  , 11)   // abcdefghij
		 * StringUtil.abbreviate("abcdefghij"  , 12)   // abcdefghij
		 * </listing>
		 * 
		 * @param 	str 		the <code>String</code> object to check. May be <code>null</code>.
		 * @param 	maxWidth	maximum length of the result <code>String</code> object, must be at least 4.
		 * @throws 	ArgumentError 	If the <code>maxWidth</code> argument is less than 4.
		 * @return	the abbreviated <code>String</code> object. If the <code>str</code> argument is <code>null</code> then the return is <code>null</code>. 
		 */
		public static function abbreviate(str:String, maxWidth:int): String
		{
			if (trimToNull(str) == null) return str;
			if (maxWidth < 4) throw new ArgumentError("The 'maxWidth' argument must be at least 4.");
			if (str.length <= maxWidth) return str;
			
			return rtrim(str.substring(0, maxWidth - 3)) + "...";
		}

		/**
		 * Capitalizes a <code>String</code> object, changing only the first letter to uppercase.
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.StringUtil;
		 * 
		 * StringUtil.capitalize(null)      // null
		 * StringUtil.capitalize(" ")       // 
		 * StringUtil.capitalize("a")       // A
		 * StringUtil.capitalize("A")       // A
		 * StringUtil.capitalize("ab")      // Ab
		 * StringUtil.capitalize("Ab")      // Ab
		 * StringUtil.capitalize("aB")      // AB
		 * StringUtil.capitalize("AB")      // AB
		 * StringUtil.capitalize("abc")     // Abc
		 * StringUtil.capitalize(" abc")    //  abc
		 * StringUtil.capitalize(" Abc")    //  Abc
		 * </listing>
		 * 
		 * @param 	str 	the <code>String</code> object to capitalize. May be <code>null</code>. 
		 * @return	the capitalized <code>String</code>. If the <code>str</code> argument is <code>null</code> then the return is <code>null</code>.
		 */
		public static function capitalize(str:String): String
		{
			if (trimToNull(str) == null) return str;
			return str.charAt(0).toUpperCase() + str.substring(1);
		}

		/**
		 * Checks if the <code>String</code> object contains the specified search <code>String</code> object.
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.StringUtil;
		 * 
		 * StringUtil.contains(null , null)          // false
		 * StringUtil.contains(null , "")            // false
		 * StringUtil.contains(""   , null)          // false
		 * StringUtil.contains(" "  , " ")           // true
		 * StringUtil.contains(" "  , "")            // true
		 * StringUtil.contains(""   , " ")           // false
		 * StringUtil.contains("abc", "")            // true
		 * StringUtil.contains(""   , "abc")         // false
		 * StringUtil.contains("abc", "a")           // true
		 * StringUtil.contains("abc", "A")           // false
		 * StringUtil.contains("abc", "A", false)    // true
		 * StringUtil.contains("Abc", "a")           // false
		 * StringUtil.contains("Abc", "a", false)    // true
		 * StringUtil.contains("abc", "á")           // false
		 * StringUtil.contains("ábc", "a")           // false
		 * StringUtil.contains("ábc", "á")           // true
		 * StringUtil.contains("a"  , "abc")         // false
		 * </listing>
		 * 
		 * @param  	str 			the <code>String</code> object to check. May be <code>null</code>.
		 * @param  	search 			the <code>String</code> object to find. May be <code>null</code>.
		 * @param  	stringCase 		indicates whether case sensitivity is considered or not in the comparison.
		 * @return 	<code>true</code> if the <code>String</code> object contains the search <code>String</code> object, <code>false</code> if not. If the <code>str</code> or <code>search</code> argument is <code>null</code> then the return is <code>null</code>.
		 */
		public static function contains(str:String, search:String, stringCase:StringCase): Boolean
		{
			if (str == null || search == null) return false;
			if (str == search) return true;
			if (stringCase == StringCase.INSENSITIVE && str.toLowerCase() == search.toLowerCase()) return true;
			
			var flags:String = "g";
			if (stringCase == StringCase.INSENSITIVE) flags += "i";
			
			var regexp:RegExp = new RegExp(search, flags);
			return str.search(regexp) != -1;
		}

		/**
		 * Checks if the <code>String</code> object contains any character in the given set of characters.
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.StringUtil;
		 * 
		 * StringUtil.containsAny(null , null)            // false
		 * StringUtil.containsAny("abc", "")              // false
		 * StringUtil.containsAny("abc", "a")             // true
		 * StringUtil.containsAny("b"  , "abc")           // true
		 * StringUtil.containsAny("A"  , "abc")           // false
		 * StringUtil.containsAny("A"  , "abc", false)    // true
		 * StringUtil.containsAny("a"  , "ABC")           // false
		 * StringUtil.containsAny("a"  , "ABC", false)    // true
		 * </listing>
		 * 
		 * @param  	str 			the <code>String</code> object to check. May be <code>null</code>.
		 * @param  	search 			the chars to find. May be <code>null</code>.
		 * @param  	stringCase 		indicates whether case sensitivity is considered or not in the comparison.
		 * @return 	<code>true</code> if the <code>String</code> object contains any of the chars of the search <code>String</code> object, <code>false</code> if not. If the <code>str</code> or <code>search</code> argument is <code>null</code> then the return is <code>false</code>.
		 */
		public static function containsAny(str:String, search:String, stringCase:StringCase): Boolean
		{
			if (str == null || search == null) return false;
			if (str == search) return true;
			if (stringCase == StringCase.INSENSITIVE && str.toLowerCase() == search.toLowerCase()) return true;
			
			var flags:String = "g";
			if (stringCase == StringCase.INSENSITIVE) flags += "i";
			
			var regexp:RegExp = new RegExp("[" + search + "]", flags);
			return str.search(regexp) != -1;
		}

		/**
		 * Checks if the <code>String</code> object does not contain any of the characters of the given set of characters.
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.StringUtil;
		 * 
		 * StringUtil.containsNone(null  , null)           // true
		 * StringUtil.containsNone("abc" , "")             // true
		 * StringUtil.containsNone("abc", "a")             // false
		 * StringUtil.containsNone("b"  , "abc")           // false
		 * StringUtil.containsNone("A"  , "abc")           // true
		 * StringUtil.containsNone("A"  , "abc", false)    // false
		 * StringUtil.containsNone("a"  , "ABC")           // true
		 * StringUtil.containsNone("a"  , "ABC", false)    // false
		 * </listing>
		 * 
		 * @param  	str 			the <code>String</code> object to check. May be <code>null</code>.
		 * @param  	invalidChars	the invalid chars. May be <code>null</code>.
		 * @param  	stringCase 		indicates whether case sensitivity is considered or not in the comparison.
		 * @return 	<code>true</code> if the <code>String</code> object does not contains any of the chars of the invalidChars <code>String</code> object, <code>false</code> if does. If the <code>str</code> or <code>invalidChars</code> argument is <code>null</code> then the return is <code>true</code>.
		 */
		public static function containsNone(str:String, invalidChars:String, stringCase:StringCase): Boolean
		{
			return !containsAny(str, invalidChars, stringCase);
		}

		/**
		 * Checks if the <code>String</code> object contains only characters in the given set of characters.
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.StringUtil;
		 * 
		 * StringUtil.containsOnly(null , null)            // false
		 * StringUtil.containsOnly("abc", "")              // false
		 * StringUtil.containsOnly("abc", "a")             // false
		 * StringUtil.containsOnly("abc", "b")             // false
		 * StringUtil.containsOnly("b"  , "abc")           // true
		 * StringUtil.containsOnly("ba" , "abc")           // true
		 * StringUtil.containsOnly("A"  , "abc")           // false
		 * StringUtil.containsOnly("A"  , "abc", false)    // true
		 * StringUtil.containsOnly("a"  , "ABC")           // false
		 * StringUtil.containsOnly("a"  , "ABC", false)    // true
		 * </listing>
		 * 
		 * @param  	str 			the <code>String</code> object to check. May be <code>null</code>.
		 * @param  	validChars		the valid chars. May be <code>null</code>.
		 * @param  	stringCase 		indicates whether case sensitivity is considered or not in the comparison.
		 * @return 	<code>true</code> if the <code>String</code> object contains only characters that exist in the <code>validChars</code> argument, <code>false</code> if contains any other characters. If the <code>str</code> or <code>validChars</code> argument is <code>null</code> then the return is <code>false</code>.
		 */
		public static function containsOnly(str:String, validChars:String, stringCase:StringCase): Boolean
		{
			if (str == null) return false;
			if (validChars == null) return false;
			if (str == validChars) return true;
			if (stringCase == StringCase.INSENSITIVE && str.toLowerCase() == validChars.toLowerCase()) return true;
			
			var flags:String = "g";
			if (stringCase == StringCase.INSENSITIVE) flags += "i";
			
			var regexp:RegExp = new RegExp("^[" + validChars + "]*$", flags);
			return str.search(regexp) != -1;
		}

		/**
		 * Counts how many times the substring appears in the <code>String</code> object.
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.StringUtil;
		 * 
		 * StringUtil.countMatches(null   , null)          // 0
		 * StringUtil.countMatches("abc"  , "")            // 0
		 * StringUtil.countMatches("abc"  , "a")           // 1
		 * StringUtil.countMatches("abc"  , "á")           // 0
		 * StringUtil.countMatches("ábca" , "á")           // 1
		 * StringUtil.countMatches("abc"  , "b")           // 1
		 * StringUtil.countMatches("a"    , "abc")         // 0
		 * StringUtil.countMatches("abc"  , "aa")          // 0
		 * StringUtil.countMatches("abca" , "a")           // 2
		 * StringUtil.countMatches("abca" , "aa")          // 0
		 * StringUtil.countMatches("aabca", "aa")          // 1
		 * StringUtil.countMatches("abc"  , "ba")          // 0
		 * StringUtil.countMatches("abc"  , "A")           // 0
		 * StringUtil.countMatches("abc"  , "A", false)    // 1
		 * StringUtil.countMatches("abca" , "A", false)    // 2
		 * </listing>
		 * 
		 * @param 	str 			the <code>String</code> object to check. May be <code>null</code>.
		 * @param 	sub 			the substring to count. May be <code>null</code>. 
		 * @param  	stringCase 		indicates whether case sensitivity is considered or not in the comparison.
		 * @return 	the number of occurrences or 0 if either argument is <code>null</code>.
		 */
		public static function countMatches(str:String, sub:String, stringCase:StringCase): int
		{
			if (str == null || sub == null) return 0;
			
			var flags:String = "g";
			if (stringCase == StringCase.INSENSITIVE) flags += "i";
			
			var regexp:RegExp = new RegExp(sub, flags);
			var arr:Array = str.match(regexp);
			return  (arr) ? arr.length : 0;
		}

		/**
		 * Returns either the passed in <code>String</code> object, or if the <code>String</code> object is empty ("") or <code>null</code>, the value of defaultStr.
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.StringUtil;
		 * 
		 * StringUtil.defaultIfEmpty(null      , null)     // null
		 * StringUtil.defaultIfEmpty(""        , null)     // null
		 * StringUtil.defaultIfEmpty(null      , "abc")    // abc
		 * StringUtil.defaultIfEmpty("abc"     , "")       // abc
		 * StringUtil.defaultIfEmpty("abc"     , null)     // abc
		 * StringUtil.defaultIfEmpty("   "     , "abc")    // abc
		 * StringUtil.defaultIfEmpty("  \n\t  ", "abc")    // abc
		 * </listing>
		 * 
		 * @param 	str 		the <code>String</code> object to check. May be <code>null</code>.
		 * @param 	default 	the default <code>String</code> object to return if the <code>str</code> argument is empty ("") or <code>null</code>. May be <code>null</code>. 
		 * @return 	the <code>defaultStr</code> argument if the <code>str</code> argument is empty ("") or <code>null</code>, or the <code>str</code> argument otherwise.
		 */
		public static function defaultIfEmpty(str:String, defaultStr:String): String
		{
			return isEmpty(str) ? defaultStr : str;
		}

		/**
		 * Check if the <code>String</code> object ends with a specified suffix.
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.StringUtil;
		 * 
		 * StringUtil.endsWith(null    , null)           // true
		 * StringUtil.endsWith(""      , null)           // false
		 * StringUtil.endsWith(null    , "abc")          // false
		 * StringUtil.endsWith("abcdef", "f")            // true
		 * StringUtil.endsWith("abcdef", "F")            // false
		 * StringUtil.endsWith("abcdef", "F", false)     // true
		 * StringUtil.endsWith("abcdEF", "eF")           // false
		 * StringUtil.endsWith("abcdEF", "eF", false)    // true
		 * StringUtil.endsWith("abcdef", "ef")           // true
		 * StringUtil.endsWith("abcdef", "abcdef")       // true
		 * StringUtil.endsWith("abcdef", "abcdefg")      // false
		 * </listing>
		 * 
		 * @param  	str				the <code>String</code> object to check. May be <code>null</code>.
		 * @param  	suffix 			the suffix to find. May be <code>null</code>. 
		 * @param  	stringCase 		indicates whether case sensitivity is considered or not in the comparison.
		 * @return 	<code>true</code> if the <code>String</code> object ends with the suffix or if both arguments are <code>null</code>.
		 */
		public static function endsWith(str:String, suffix:String, stringCase:StringCase): Boolean
		{
			if (str == null && suffix == null) return true;
			if (str == null || suffix == null) return false;
			
			var flags:String = "g";
			if (stringCase == StringCase.INSENSITIVE) flags += "i";
			
			var regexp:RegExp = new RegExp(suffix + "$", flags);
			return str.search(regexp) != -1;
		}

		/**
		 * Compares two <code>String</code> objects, returning <code>true</code> if they are equal.
		 * <p>Two <code>null</code> references are considered to be equal.</p>
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.StringUtil;
		 * 
		 * var obj:Object = {label:"jlm"};
		 * var n1:int = 1;
		 * var n2:Number = 2;
		 * var n3:Number = 3.1;
		 * var arr:Array = ["abc", "def", 123, {label:"ghi"}, obj, n1, n2, n3];
		 * 
		 * StringUtil.equals(null , null)            // true
		 * StringUtil.equals(""   , null)            // false
		 * StringUtil.equals(null , "abc")           // false
		 * StringUtil.equals("abc", "a")             // false
		 * StringUtil.equals("abc", "abc")           // true
		 * StringUtil.equals("abc", "AbC")           // false
		 * StringUtil.equals("abc", "AbC", false)    // true
		 * </listing>
		 * 
		 * @param  	str1 			the first <code>String</code> object. May be <code>null</code>.
		 * @param  	str2 			the second <code>String</code> object. May be <code>null</code>.
		 * @param  	stringCase 		indicates whether case sensitivity is considered or not in the comparison.
		 * @return 	<code>true</code> if the <code>String</code> objects are equal or both are <code>null</code>.
		 */
		public static function equals(str1:String, str2:String, stringCase:StringCase): Boolean
		{
			if (str1 == null && str2 == null) return true;
			if (str1 == null || str2 == null) return false;
			
			if (stringCase == StringCase.INSENSITIVE)
			{
				str1 = str1.toLowerCase();
				str2 = str2.toLowerCase();
			}
			
			return str1 == str2;
		}

		/**
		 * Returns the first char of the <code>String</code> object.
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.StringUtil;
		 * 
		 * StringUtil.firstChar(null)       // null
		 * StringUtil.firstChar("")         // 
		 * StringUtil.firstChar(" ")        //  
		 * StringUtil.firstChar("a")        // a
		 * StringUtil.firstChar("ab")       // a
		 * StringUtil.firstChar("abc")      // a
		 * StringUtil.firstChar(" abc")     //  
		 * StringUtil.firstChar(" abc ")    //  
		 * </listing>
		 * 
		 * @param 	str 	the <code>String</code> object to return the first char. May be <code>null</code>. 
		 * @return	the first char of the <code>String</code> object. If the <code>str</code> argument is <code>null</code> then the return is <code>null</code>.
		 */
		public static function firstChar(str:String): String
		{
			if (isEmpty(str)) return str;
			return str.charAt(0);
		}

		/**
		 * Checks if the <code>String</code> object contains only lowercase characters.
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.StringUtil;
		 * 
		 * StringUtil.isAllLowerCase(null)        // false
		 * StringUtil.isAllLowerCase("")          // false
		 * StringUtil.isAllLowerCase("    ")      // false
		 * StringUtil.isAllLowerCase("  \t  ")    // false
		 * StringUtil.isAllLowerCase("abc")       // true
		 * StringUtil.isAllLowerCase("Abc")       // false
		 * StringUtil.isAllLowerCase("ABC")       // false
		 * StringUtil.isAllLowerCase("óbc")       // true
		 * StringUtil.isAllLowerCase("Óbc")       // false
		 * StringUtil.isAllLowerCase("ÓBC")       // false
		 * </listing>
		 * 
		 * @param  	str 	the <code>String</code> object to check. May be <code>null</code>.
		 * @return 	<code>true</code> if only contains lowercase characters, and is not <code>null</code>.
		 */
		public static function isAllLowerCase(str:String): Boolean
		{
			if (trimToEmpty(str) == "") return false;
			return str == str.toLowerCase();
		}

		/**
		 * Checks if the <code>String</code> object contains only uppercase characters.
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.StringUtil;
		 * 
		 * StringUtil.isAllUpperCase(null)          // false
		 * StringUtil.isAllUpperCase("")            // false
		 * StringUtil.isAllUpperCase("    ")        // false
		 * StringUtil.isAllUpperCase("  	  ")    // false
		 * StringUtil.isAllUpperCase("abc")         // false
		 * StringUtil.isAllUpperCase("Abc")         // false
		 * StringUtil.isAllUpperCase("ABC")         // true
		 * StringUtil.isAllUpperCase("óbc")         // false
		 * StringUtil.isAllUpperCase("Óbc")         // false
		 * StringUtil.isAllUpperCase("ÓBC")         // true
		 * </listing>
		 * 
		 * @param  	str 	the <code>String</code> object to check. May be <code>null</code>.
		 * @return 	<code>true</code> if only contains uppercase characters, and is not <code>null</code>.
		 */
		public static function isAllUpperCase(str:String): Boolean
		{
			if (trimToEmpty(str) == "") return false;
			return str == str.toUpperCase();
		}

		/**
		 * Checks if the <code>String</code> object contains only unicode letters or digits.
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.StringUtil;
		 * 
		 * StringUtil.isAlphanumeric(null)              // false
		 * StringUtil.isAlphanumeric("")                // false
		 * StringUtil.isAlphanumeric("    ")            // false
		 * StringUtil.isAlphanumeric("  \t  ")          // false
		 * StringUtil.isAlphanumeric("abc")             // true
		 * StringUtil.isAlphanumeric("123456")          // true
		 * StringUtil.isAlphanumeric("abc123")          // true
		 * StringUtil.isAlphanumeric("123abc456def")    // true
		 * StringUtil.isAlphanumeric("abc123 ")         // false
		 * StringUtil.isAlphanumeric("ABC123 ")         // false
		 * StringUtil.isAlphanumeric("áóbc123")         // true
		 * StringUtil.isAlphanumeric("ÁÓbc123")         // true
		 * StringUtil.isAlphanumeric("ÁÓbc123-")        // false
		 * </listing>
		 * 
		 * @param  	str 	the <code>String</code> object to check. May be <code>null</code>. 	
		 * @return 	<code>true</code> if only contains unicode letters or digits, and is not <code>null</code>.
		 */
		public static function isAlphanumeric(str:String): Boolean
		{
			if (trimToNull(str) == null) return false;
			
			return str.search(/^[\u0041-\u005A\u0061-\u007A\u00C0-\u00FF0-9]+$/g) != -1;
		}

		/**
		 * Checks if the <code>String</code> object contains only unicode letters, digits or spaces.
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.StringUtil;
		 * 
		 * StringUtil.isAlphanumericSpace(null)              // false
		 * StringUtil.isAlphanumericSpace("")                // false
		 * StringUtil.isAlphanumericSpace("    ")            // true
		 * StringUtil.isAlphanumericSpace("  \t  ")          // false
		 * StringUtil.isAlphanumericSpace("abc")             // true
		 * StringUtil.isAlphanumericSpace("123456")          // true
		 * StringUtil.isAlphanumericSpace("abc123")          // true
		 * StringUtil.isAlphanumericSpace("123abc456def")    // true
		 * StringUtil.isAlphanumericSpace("abc123 ")         // true
		 * StringUtil.isAlphanumericSpace("ABC123 ")         // true
		 * StringUtil.isAlphanumericSpace("áóbc123")         // true
		 * StringUtil.isAlphanumericSpace("ÁÓbc123")         // true
		 * StringUtil.isAlphanumericSpace("ÁÓbc123-")        // false
		 * </listing>
		 * 
		 * @param  	str 	the <code>String</code> object to check. May be <code>null</code>. 	
		 * @return 	<code>true</code> if only contains unicode letters, digits and spaces and is not <code>null</code>.
		 */
		public static function isAlphanumericSpace(str:String): Boolean
		{
			if (str == null) return false;
			if (str == "") return false;
			
			return str.search(/^[\u0041-\u005A\u0061-\u007A\u00C0-\u00FF0-9 ]+$/g) != -1;
		}

		/**
		 * Checks if a <code>String</code> object is empty (""), <code>null</code> or if it contains only control characters(char &lt;= 32).
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.StringUtil;
		 * 
		 * StringUtil.isBlank(null)         // true
		 * StringUtil.isBlank("")           // true
		 * StringUtil.isBlank("    ")       // true
		 * StringUtil.isBlank("  \t  ")     // true
		 * StringUtil.isBlank("abc")        // false
		 * StringUtil.isBlank(" abc ")      // false
		 * </listing>
		 * 
		 * @param 	str 	the <code>String</code> object to check. May be <code>null</code>.
		 * @return 	<code>true</code> if the <code>String</code> object is <code>null</code>, empty or contains only control characters(char &lt;= 32).
		 */
		public static function isBlank(str:String): Boolean
		{
			return isEmpty(trimToEmpty(str));
		}

		/**
		 * Checks if a <code>String</code> object is empty ("") or <code>null</code>.
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.StringUtil;
		 * 
		 * StringUtil.isEmpty(null)         // true
		 * StringUtil.isEmpty("")           // true
		 * StringUtil.isEmpty("    ")       // false
		 * StringUtil.isEmpty("  \t  ")     // false
		 * StringUtil.isEmpty("abc")        // false
		 * StringUtil.isEmpty(" abc ")      // false
		 * </listing>
		 * 
		 * @param 	str 	the <code>String</code> object to check. May be <code>null</code>. 
		 * @return 	<code>true</code> if the <code>String</code> object is empty or <code>null</code>.
		 */
		public static function isEmpty(str:String): Boolean
		{
			if (str == null || str == "") return true;
			return false;
		}

		/**
		 * Checks if a <code>String</code> object is not empty (""), not <code>null</code> and not contains only control characters(char &lt;= 32).
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.StringUtil;
		 * 
		 * StringUtil.isNotBlank(null)         // false
		 * StringUtil.isNotBlank("")           // false
		 * StringUtil.isNotBlank("    ")       // false
		 * StringUtil.isNotBlank("  \t  ")     // false
		 * StringUtil.isNotBlank("abc")        // true
		 * StringUtil.isNotBlank(" abc ")      // true
		 * </listing>
		 * 
		 * @param 	str 	the <code>String</code> object to check. May be <code>null</code>.
		 * @return	<code>true</code> if the <code>String</code> object is not empty, not <code>null</code> and not contains only control characters(char &lt;= 32).
		 */
		public static function isNotBlank(str:String): Boolean
		{
			return !isBlank(str);
		}

		/**
		 * Checks if a <code>String</code> object is not empty ("") and not <code>null</code>.
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.StringUtil;
		 * 
		 * StringUtil.isNotEmpty(null)         // false
		 * StringUtil.isNotEmpty("")           // false
		 * StringUtil.isNotEmpty("    ")       // true
		 * StringUtil.isNotEmpty("  \t  ")     // true
		 * StringUtil.isNotEmpty("abc")        // true
		 * StringUtil.isNotEmpty(" abc ")      // true
		 * </listing>
		 * 
		 * @param 	str 	the <code>String</code> object to check. May be <code>null</code>. 
		 * @return	<code>true</code> if the <code>String</code> object is not empty and is not <code>null</code>.
		 */
		public static function isNotEmpty(str:String): Boolean
		{
			return !isEmpty(str);
		}

		/**
		 * Checks if the <code>String</code> object contains only unicode digits. A decimal point is not a unicode digit and returns <code>false</code>.
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.StringUtil;
		 * 
		 * StringUtil.isNumeric(null)       // false
		 * StringUtil.isNumeric("")         // true
		 * StringUtil.isNumeric("    ")     // false
		 * StringUtil.isNumeric("  \t ")    // false
		 * StringUtil.isNumeric("123")      // true
		 * StringUtil.isNumeric("12.3")     // false
		 * StringUtil.isNumeric("a123")     // false
		 * StringUtil.isNumeric(" 123")     // false
		 * StringUtil.isNumeric("  123")    // false
		 * </listing>
		 * 
		 * @param  	str 	the <code>String</code> object to check. May be <code>null</code>.
		 * @return 	<code>true</code> if the <code>String</code> object only contains unicode digits and is not <code>null</code>.
		 */
		public static function isNumeric(str:String): Boolean
		{
			if (str == null) return false;
			if (str == "") return true;
			
			return str.search(/^[0-9]*$/g) != -1;
		}

		/**
		 * Checks if the <code>String</code> object contains only unicode digits or spaces. A decimal point is not a unicode digit and returns <code>false</code>.
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.StringUtil;
		 * 
		 * StringUtil.isNumericSpace(null)       // false
		 * StringUtil.isNumericSpace("")         // true
		 * StringUtil.isNumericSpace("    ")     // true
		 * StringUtil.isNumericSpace("  \t ")    // false
		 * StringUtil.isNumericSpace("123")      // true
		 * StringUtil.isNumericSpace("12.3")     // false
		 * StringUtil.isNumericSpace("a123")     // false
		 * StringUtil.isNumericSpace(" 123")     // true
		 * StringUtil.isNumericSpace("  123")    // true
		 * </listing>
		 * 
		 * @param  	str 	the <code>String</code> object to check. May be <code>null</code>.
		 * @return 	<code>true</code> if the <code>String</code> object only contains unicode digits or spaces and is not <code>null</code>.
		 */
		public static function isNumericSpace(str:String): Boolean
		{
			if (str == null) return false;
			if (str == "") return true;
			
			return str.search(/^[0-9 ]*$/g) != -1;
		}

		/**
		 * Validates an input e-mail address.
		 * <p>This implementation does not conform with any specification and is very restrictive.</p>
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.StringUtil;
		 * 
		 * StringUtil.isValidEmail(null)                   // false
		 * StringUtil.isValidEmail("")                     // false
		 * StringUtil.isValidEmail("a")                    // false
		 * StringUtil.isValidEmail("a&#64;a.a")                // false
		 * StringUtil.isValidEmail("aa&#64;aa.aa")             // true
		 * StringUtil.isValidEmail("a/a&#64;aa.aa")            // false
		 * StringUtil.isValidEmail("a=a&#64;aa.aa")            // false
		 * StringUtil.isValidEmail("1a&#64;1a.1a")             // false
		 * StringUtil.isValidEmail("a1&#64;a1.a1")             // false
		 * StringUtil.isValidEmail("a1&#64;a1.aa")             // true
		 * StringUtil.isValidEmail("11&#64;11.11")             // false
		 * StringUtil.isValidEmail("aa-aa&#64;a-a.a-a")        // false
		 * StringUtil.isValidEmail("aa-aa&#64;aa-aa.aa-aa")    // false
		 * StringUtil.isValidEmail("aa-aa&#64;aa-aa-aa.aa")    // true
		 * StringUtil.isValidEmail("aa-aa&#64;aa.aa.aa")       // true
		 * StringUtil.isValidEmail("áa-aa&#64;aa.aa.aa")       // false
		 * StringUtil.isValidEmail("Aa-aa&#64;aa.aa.aA")       // true
		 * StringUtil.isValidEmail("aa-aa&#64;aa.aa.aa")       // true
		 * </listing>
		 * 
		 * @param  	str 	the <code>String</code> object to be validates as an e-mail address.
		 * @return 	<code>true</code> if the <code>String</code> object is a valid e-mail address according to this implementation.
		 */
		public static function isValidEmail(str:String): Boolean
		{
			if (trimToNull(str) == null)  return false;
			return str.search(/^([0-9a-z]([-.\w]*[0-9a-z])*@([0-9a-z][-\w]*[0-9a-z]\.)+[a-z]{2,9})$/ig) != -1;
		}
		
		/**
		 * Returns the last char of the <code>String</code> object.
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.StringUtil;
		 * 
		 * StringUtil.lastChar(null)       // null
		 * StringUtil.lastChar("")         // 
		 * StringUtil.lastChar(" ")        //  
		 * StringUtil.lastChar("a")        // a
		 * StringUtil.lastChar("ab")       // b
		 * StringUtil.lastChar("abc")      // c
		 * StringUtil.lastChar(" abc")     // c
		 * StringUtil.lastChar(" abc ")    //  
		 * </listing>
		 * 
		 * @param 	str 	the <code>String</code> object to return the last char. May be <code>null</code>. 
		 * @return	the last char of the <code>String</code> object. If the <code>str</code> argument is <code>null</code> then the return is <code>null</code>.
		 */
		public static function lastChar(str:String): String
		{
			if (isEmpty(str)) return str;
			return str.charAt(str.length - 1);
		}

		/**
		 * Removes control characters(char &lt;= 32) from the start of the <code>String</code> object.
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.StringUtil;
		 * 
		 * StringUtil.ltrim(null)                    // null
		 * StringUtil.ltrim("")                      // 
		 * StringUtil.ltrim(" ")                     // 
		 * StringUtil.ltrim("  ")                    // 
		 * StringUtil.ltrim("     ")                 // 
		 * StringUtil.ltrim("abc"):                  // abc
		 * StringUtil.ltrim(" abc")                  // abc
		 * StringUtil.ltrim("   abc")                // abc
		 * StringUtil.ltrim("   abc ")               // abc 
		 * StringUtil.ltrim(" \t\n  abc  ")          // abc  
		 * StringUtil.ltrim(" \t\n  abc \t\n ")      // abc \t\n 
		 * </listing>
		 * 
		 * @param 	str	the <code>String</code> object to be trimmed. May be <code>null</code>. 
		 * @return 	the trimmed <code>String</code> object. If the <code>str</code> argument is <code>null</code> then the return is <code>null</code>.
		 */
		public static function ltrim(str:String): String
		{
			if (str == null) return null;
			if (str == "") return str;
			
			return str.replace(REGEXP_LTRIM, "");
		}

		/**
		 * Removes all occurrences of a substring from within the source <code>String</code> object.
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.StringUtil;
		 * 
		 * StringUtil.remove(null    , null)           // null
		 * StringUtil.remove(""      , null)           // 
		 * StringUtil.remove(null    , "abc")          // null
		 * StringUtil.remove(""      , "")             // 
		 * StringUtil.remove("abc"   , "")             // abc
		 * StringUtil.remove(""      , "abc")          // 
		 * StringUtil.remove("abcdef", "c")            // abdef
		 * StringUtil.remove("abcdef", "C")            // abcdef
		 * StringUtil.remove("abcdef", "C", false)     // abdef
		 * StringUtil.remove("ABcdef", "aB")           // ABcdef
		 * StringUtil.remove("ABcdef", "aB", false)    // cdef
		 * StringUtil.remove("ABcdeF", "Ef")           // ABcdeF
		 * StringUtil.remove("ABcdeF", "Ef", false)    // ABcd
		 * StringUtil.remove("abcdef", "ab")           // cdef
		 * StringUtil.remove("abcdef", "abcdef")       // 
		 * StringUtil.remove("abcdef", "abcdefg")      // abcdef
		 * </listing>
		 * 
		 * @param  	str 			the <code>String</code> object to search. May be <code>null</code>.
		 * @param  	remove 			the <code>String</code> object to search for and remove. May be <code>null</code>. 
		 * @param  	stringCase 		indicates whether case sensitivity is considered or not in the comparison.
		 * @return 	the <code>String</code> object with the substring removed if found. If the <code>str</code> argument is <code>null</code> then the return is <code>null</code>.
		 */
		public static function remove(str:String, remove:String, stringCase:StringCase): String
		{
			if (str == null || str == "") return str;
			if (remove == null || remove == "") return str;
			
			var flags:String = "g";
			if (stringCase == StringCase.INSENSITIVE) flags += "i";
			
			var regexp:RegExp = new RegExp(remove, flags);
			return str.replace(regexp, "");
		}

		/**
		 * Removes a substring only if it is at the end of the source <code>String</code> object, otherwise returns the source <code>String</code> object.
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.StringUtil;
		 * 
		 * StringUtil.removeEnd(null    , null)           // null
		 * StringUtil.removeEnd(""      , null)           // 
		 * StringUtil.removeEnd(null    , "abc")          // null
		 * StringUtil.removeEnd(""      , "")             // 
		 * StringUtil.removeEnd("abc"   , "")             // abc
		 * StringUtil.removeEnd(""      , "abc")          // 
		 * StringUtil.removeEnd("abcdef", "c")            // abcdef
		 * StringUtil.removeEnd("abcdef", "C")            // abcdef
		 * StringUtil.removeEnd("abcdef", "C", false)     // abcdef
		 * StringUtil.removeEnd("ABcdef", "aB")           // ABcdef
		 * StringUtil.removeEnd("ABcdef", "aB", false)    // ABcdef
		 * StringUtil.removeEnd("ABcdeF", "Ef")           // ABcdeF
		 * StringUtil.removeEnd("ABcdeF", "Ef", false)    // ABcd
		 * StringUtil.removeEnd("abcdef", "ab")           // abcdef
		 * StringUtil.removeEnd("abcdef", "abcdef")       // 
		 * StringUtil.removeEnd("abcdef", "abcdefg")      // abcdef
		 * </listing>
		 * 
		 * @param  	str 			the <code>String</code> object to search. May be <code>null</code>.
		 * @param  	remove 			the <code>String</code> object to search for and remove. May be <code>null</code>. 
		 * @param  	stringCase 		indicates whether case sensitivity is considered or not in the comparison.
		 * @return 	the <code>String</code> object with the substring removed if found. If the <code>str</code> argument is <code>null</code> then the return is <code>null</code>.
		 */
		public static function removeEnd(str:String, remove:String, stringCase:StringCase): String
		{
			if (str == null || str == "") return str;
			if (remove == null || remove == "") return str;
			
			var flags:String = "g";
			if (stringCase == StringCase.INSENSITIVE) flags += "i";
			
			var regexp:RegExp = new RegExp(remove + "$", flags);
			return str.replace(regexp, "");
		}

		/**
		 * Removes the first character of the <code>String</code> object.
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.StringUtil;
		 * 
		 * StringUtil.removeFirstCharacter(null)            // null
		 * StringUtil.removeFirstCharacter(""):             // 
		 * StringUtil.removeFirstCharacter("a"):            // 
		 * StringUtil.removeFirstCharacter("ab")            // b
		 * StringUtil.removeFirstCharacter("abc")           // bc
		 * StringUtil.removeFirstCharacter("abc\t\ndef")    // bc\t\ndef
		 * </listing>
		 * 
		 * @param 	str 	the <code>String</code> object to remove the first character from. May be <code>null</code>. 
		 * @return	the <code>String</code> object without first character. If the <code>str</code> argument is <code>null</code> then the return is <code>null</code>.
		 */
		public static function removeFirstCharacter(str:String): String
		{
			if (str == null || str == "") return str;
			return str.substring(1);
		}

		/**
		 * Removes the last character of the <code>String</code> object.
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.StringUtil;
		 * 
		 * StringUtil.removeLastCharacter(null)            // null
		 * StringUtil.removeLastCharacter(""):             // 
		 * StringUtil.removeLastCharacter("a"):            // 
		 * StringUtil.removeLastCharacter("ab")            // a
		 * StringUtil.removeLastCharacter("abc")           // ab
		 * StringUtil.removeLastCharacter("abc\t\ndef")    // abc\t\nde
		 * </listing>
		 * 
		 * @param 	str 	the <code>String</code> object to remove last character from. May be <code>null</code>. 
		 * @return	the <code>String</code> object without last character. If the <code>str</code> argument is <code>null</code> then the return is <code>null</code>.
		 */
		public static function removeLastCharacter(str:String): String
		{
			if (str == null || str == "") return str;
			return str.substring(0, str.length - 1);
		}

		/**
		 * Removes a substring only if it is at the start of the source <code>String</code> object, otherwise returns the source <code>String</code> object.
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.StringUtil;
		 * 
		 * StringUtil.removeStart(null    , null)           // null
		 * StringUtil.removeStart(""      , null)           // 
		 * StringUtil.removeStart(null    , "abc")          // null
		 * StringUtil.removeStart(""      , "")             // 
		 * StringUtil.removeStart("abc"   , "")             // abc
		 * StringUtil.removeStart(""      , "abc")          // 
		 * StringUtil.removeStart("abcdef", "c")            // abcdef
		 * StringUtil.removeStart("abcdef", "C")            // abcdef
		 * StringUtil.removeStart("abcdef", "C", false)     // abcdef
		 * StringUtil.removeStart("ABcdef", "aB")           // ABcdef
		 * StringUtil.removeStart("ABcdef", "aB", false)    // cdef
		 * StringUtil.removeStart("ABcdeF", "Ef")           // ABcdeF
		 * StringUtil.removeStart("ABcdeF", "Ef", false)    // ABcdeF
		 * StringUtil.removeStart("abcdef", "ab")           // cdef
		 * StringUtil.removeStart("abcdef", "abcdef")       // 
		 * StringUtil.removeStart("abcdef", "abcdefg")      // abcdef
		 * </listing>
		 * 
		 * @param  	str 			the <code>String</code> object to search. May be <code>null</code>.
		 * @param  	remove 			the <code>String</code> object to search for and remove. May be <code>null</code>. 
		 * @param  	stringCase 		indicates whether case sensitivity is considered or not in the comparison.
		 * @return 	the <code>String</code> object with the substring removed if found. If the <code>str</code> argument is <code>null</code> then the return is <code>null</code>.
		 */
		public static function removeStart(str:String, remove:String, stringCase:StringCase): String
		{
			if (str == null || str == "") return str;
			if (remove == null || remove == "") return str;
			
			var flags:String = "g";
			if (stringCase == StringCase.INSENSITIVE) flags += "i";
			
			var regexp:RegExp = new RegExp("^" + remove, flags);
			return str.replace(regexp, "");
		}

		/**
		 * Remove accented characters from the <code>String</code> object.
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.StringUtil;
		 * 
		 * StringUtil.removeAccentuation(null)                  // null
		 * StringUtil.removeAccentuation("")                    // 
		 * StringUtil.removeAccentuation("    ")                //     
		 * StringUtil.removeAccentuation("aáeéiíoóuúçÇÁbÜõ")    // aaeeiioouucCAbUo
		 * </listing>
		 * 
		 * @param  	str 	the <code>String</code> object to remove accented characters. May be <code>null</code>.
		 * @return 	the <code>String</code> object without accented characters.
		 */
		public static function removeAccentuation(str:String): String
		{
			if (trimToNull(str) == null) return str;
			
			str = str.replace(/[áàâãä]/g, "a");
			str = str.replace(/[ÁÀÂÃÄ]/g, "A");
			str = str.replace(/[éèêë]/g, "e");
			str = str.replace(/[ÉÈÊË]/g, "E");
			str = str.replace(/[íìîï]/g, "i");
			str = str.replace(/[ÍÌÎÏ]/g, "I");
			str = str.replace(/[óòôõö]/g, "o");
			str = str.replace(/[ÓÒÔÕÖ]/g, "O");
			str = str.replace(/[úùûü]/g, "u");
			str = str.replace(/[ÚÙÛÜ]/g, "U");
			str = str.replace(/[ç]/g, "c");
			str = str.replace(/[Ç]/g, "C");
			str = str.replace(/[ñ]/g, "n");
			str = str.replace(/[Ñ]/g, "N");
			str = str.replace(/[´]/g, "");
			str = str.replace(/[`]/g, "");
			str = str.replace(/[~]/g, "");
			str = str.replace(/[^]/g, "");
			str = str.replace(/[¨]/g, "");
			
			return str;
			//return str.replace(/[\u0300-\u036F]*/g, "");
		}

		/**
		 * Search for all occurrences of the <code>String</code> <code>find</code> within the <code>String</code> <code>str</code> and replaces by the <code>String</code> <code>replaceBy</code>.
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.StringUtil;
		 * 
		 * StringUtil.replaceExtended(null        , null , "x")           // null
		 * StringUtil.replaceExtended(""          , null , "x")           // 
		 * StringUtil.replaceExtended(null        , "abc", "x")           // null
		 * StringUtil.replaceExtended(""          , ""   , "x")           // 
		 * StringUtil.replaceExtended("abc"       , ""   , "x")           // abc
		 * StringUtil.replaceExtended(""          , "abc", "x")           // 
		 * StringUtil.replaceExtended("abcdefabca", "a"  , "x")           // xbcdefxbcx
		 * StringUtil.replaceExtended("AbcdefabcA", "a"  , "x")           // AbcdefxbcA
		 * StringUtil.replaceExtended("AbcdefabcA", "a"  , "x", false)    // xbcdefxbcx
		 * StringUtil.replaceExtended("abcdef"    , "y"  , "x")           // abcdef
		 * </listing>
		 * 
		 * @param  	str 			the <code>String</code> object to search. May be <code>null</code>.
		 * @param  	find 			the <code>String</code> object to search for and replace. May be <code>null</code>. 
		 * @param  	replaceBy 		the <code>String</code> object that will replace the <code>String</code> <code>find</code>.
		 * @param  	stringCase 		indicates whether case sensitivity is considered or not in the comparison.
		 * @return 	the <code>String</code> <code>str</code> with the <code>String</code> <code>find</code> replaced by the <code>String</code> <code>replaceBy</code>. If the <code>str</code> argument is <code>null</code> then the return is <code>null</code>.
		 */
		public static function replaceExtended(str:String, find:String, replaceBy:String, stringCase:StringCase): String
		{
			if (str == null || str == "") return str;
			if (find == null || find == "") return str;
			
			var flags:String = "g";
			if (stringCase == StringCase.INSENSITIVE) flags += "i";
			
			var regExp:RegExp = new RegExp(find, flags);
			return str.replace(regExp, replaceBy);
		}

		/**
		 * Reverses the chars of the <code>String</code> object.
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.StringUtil;
		 * 
		 * StringUtil.reverse(null)       // null
		 * StringUtil.reverse("")         // 
		 * StringUtil.reverse(" ")        //  
		 * StringUtil.reverse("a")        // a
		 * StringUtil.reverse("ab")       // ba
		 * StringUtil.reverse("abc")      // cba
		 * StringUtil.reverse(" abc")     // cba 
		 * StringUtil.reverse(" abc ")    //  cba 
		 * StringUtil.reverse("abc\td")   // d\tcba
		 * </listing>
		 * 
		 * @param 	str 	the <code>String</code> object to reverse. May be <code>null</code>. 
		 * @return	the <code>String</code> object with the chars reversed. If the <code>str</code> argument is <code>null</code> then the return is <code>null</code>.
		 */
		public static function reverse(str:String): String
		{
			if (isEmpty(str)) return str;
			
			var arr:Array = str.split("");
			arr.reverse();
			return arr.join("");
		}

		/**
		 * Removes control characters(char &lt;= 32) from the start of the <code>String</code> object.
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.StringUtil;
		 * 
		 * StringUtil.rtrim(null)                   // null
		 * StringUtil.rtrim("")                     // 
		 * StringUtil.rtrim(" ")                    // 
		 * StringUtil.rtrim("abc")                  // abc
		 * StringUtil.rtrim(" abc")                 //  abc
		 * StringUtil.rtrim("   abc ")              //    abc
		 * StringUtil.rtrim("   abc  ")             //    abc
		 * StringUtil.rtrim(" \n\t  abc  ")         // \n\t  abc
		 * StringUtil.rtrim(" \n\t  abc  \n\t ")    // \n\t  abc
		 * </listing>
		 * 
		 * @param 	str	the <code>String</code> object to be trimmed. May be <code>null</code>. 
		 * @return 	the trimmed <code>String</code> object. If the <code>str</code> argument is <code>null</code> then the return is <code>null</code>.
		 */
		public static function rtrim(str:String): String
		{
			if (str == null) return null;
			if (str == "") return str;
			
			return str.replace(REGEXP_RTRIM, "");
		}

		/**
		 * Check if the <code>String</code> object starts with a specified prefix.
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.StringUtil;
		 * 
		 * StringUtil.startsWith(null    , null)           // true
		 * StringUtil.startsWith(""      , null)           // false
		 * StringUtil.startsWith(null    , "abc")          // false
		 * StringUtil.startsWith("abcdef", "a")            // true
		 * StringUtil.startsWith("abcdef", "A")            // false
		 * StringUtil.startsWith("abcdef", "A", false)     // true
		 * StringUtil.startsWith("ABcdef", "aB")           // false
		 * StringUtil.startsWith("ABcdef", "aB", false)    // true
		 * StringUtil.startsWith("abcdef", "ab")           // true
		 * StringUtil.startsWith("abcdef", "abcdef")       // true
		 * StringUtil.startsWith("abcdef", "abcdefg")      // false
		 * </listing>
		 * 
		 * @param  	str				the <code>String</code> object to check. May be <code>null</code>.
		 * @param  	prefix 			the prefix to find. May be <code>null</code>. 
		 * @param  	stringCase 		indicates whether case sensitivity is considered or not in the comparison.
		 * @return 	<code>true</code> if the <code>String</code> object starts with the prefix or if both arguments are <code>null</code>.
		 */
		public static function startsWith(str:String, prefix:String, stringCase:StringCase): Boolean
		{
			if (str == null && prefix == null) return true;
			if (str == null || prefix == null) return false;
			
			var flags:String = "g";
			if (stringCase == StringCase.INSENSITIVE) flags += "i";
			
			var regexp:RegExp = new RegExp("^" + prefix, flags);
			return str.search(regexp) != -1;
		}

		/**
		 * Removes control characters(char &lt;= 32) from the start and end of the <code>String</code> object.
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.StringUtil;
		 * 
		 * StringUtil.trim(null)                   // null
		 * StringUtil.trim("")                     // 
		 * StringUtil.trim(" ")                    // 
		 * StringUtil.trimToEmpty("  \t  ")        // 
		 * StringUtil.trim("abc")                  // abc
		 * StringUtil.trim(" abc")                 // abc
		 * StringUtil.trim("   abc ")              // abc
		 * StringUtil.trim("   abc  ")             // abc
		 * StringUtil.trim(" \n\t  abc  ")         // abc
		 * StringUtil.trim(" \n\t  abc  \n\t ")    // abc
		 * </listing>
		 * 
		 * @param 	str	the <code>String</code> object to be trimmed. May be <code>null</code>. 
		 * @return 	the trimmed <code>String</code> object. If the <code>str</code> argument is <code>null</code> then the return is <code>null</code>.
		 */
		public static function trim(str:String): String
		{
			if (str == null) return null;
			if (str == "") return "";
			
			return ltrim(rtrim(str));
		}

		/**
		 * Removes control characters(char &lt;= 32) from the start and end of the <code>String</code> object.
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.StringUtil;
		 * 
		 * StringUtil.trimToEmpty(null)                   // 
		 * StringUtil.trimToEmpty("")                     // 
		 * StringUtil.trimToEmpty(" ")                    // 
		 * StringUtil.trimToEmpty("  ")                   // 
		 * StringUtil.trimToEmpty("  \t  ")               // 
		 * StringUtil.trimToEmpty("abc")                  // abc
		 * StringUtil.trimToEmpty(" abc")                 // abc
		 * StringUtil.trimToEmpty("   abc ")              // abc
		 * StringUtil.trimToEmpty("   abc  ")             // abc
		 * StringUtil.trimToEmpty(" \n\t  abc  ")         // abc
		 * StringUtil.trimToEmpty(" \n\t  abc  \n\t ")    // abc
		 * </listing>
		 * 
		 * @param 	str	the <code>String</code> object to be trimmed. May be <code>null</code>. 
		 * @return 	the trimmed <code>String</code> object. If the <code>str</code> argument is <code>null</code> then the return is an empty <code>String</code> ("").
		 */
		public static function trimToEmpty(str:String): String
		{
			if (trimToNull(str) == null) return "";
			return trim(str);
		}

		/**
		 * Removes control characters(char &lt;= 32) from the start and end of the <code>String</code> object.
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.StringUtil;
		 * 
		 * StringUtil.trimToNull(null)                   // null
		 * StringUtil.trimToNull("")                     // null
		 * StringUtil.trimToNull(" ")                    // null
		 * StringUtil.trimToNull("  ")                   // null
		 * StringUtil.trimToNull("  \t  ")               // null
		 * StringUtil.trimToNull("abc")                  // abc
		 * StringUtil.trimToNull(" abc")                 // abc
		 * StringUtil.trimToNull("   abc ")              // abc
		 * StringUtil.trimToNull("   abc  ")             // abc
		 * StringUtil.trimToNull(" \n\t  abc  ")         // abc
		 * StringUtil.trimToNull(" \n\t  abc  \n\t ")    // abc
		 * </listing>
		 * 
		 * @param 	str	the <code>String</code> object to be trimmed. May be <code>null</code>. 
		 * @return 	the trimmed <code>String</code> object if it contains any characters that isn't control characters(char &lt;= 32), or <code>null</code> if it contains only those characters. If the <code>str</code> argument is <code>null</code> then the return is <code>null</code>.
		 */
		public static function trimToNull(str:String): String
		{
			if (str == null) return null;
			if (str == "") return null;
			
			str = trim(str);
			
			if (str == "") return null;
			return str;
		}

		/**
		 * Uncapitalizes a <code>String</code> object, changing only the first letter to lowercase.
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3coreaddendum.utils.StringUtil;
		 * 
		 * StringUtil.uncapitalize(null)      // null
		 * StringUtil.uncapitalize(" ")       // 
		 * StringUtil.uncapitalize("a")       // a
		 * StringUtil.uncapitalize("A")       // a
		 * StringUtil.uncapitalize("ab")      // ab
		 * StringUtil.uncapitalize("Ab")      // ab
		 * StringUtil.uncapitalize("aB")      // aB
		 * StringUtil.uncapitalize("AB")      // aB
		 * StringUtil.uncapitalize("abc")     // abc
		 * StringUtil.uncapitalize(" abc")    //  abc
		 * StringUtil.uncapitalize(" Abc")    //  Abc
		 * </listing>
		 * 
		 * @param 	str 	the <code>String</code> object to uncapitalize. May be <code>null</code>. 
		 * @return	the uncapitalized <code>String</code>. If the <code>str</code> argument is <code>null</code> then the return is <code>null</code>.
		 */
		public static function uncapitalize(str:String): String
		{
			if (trimToNull(str) == null) return str;
			return str.charAt(0).toLowerCase() + str.substring(1);
		}

	}

}