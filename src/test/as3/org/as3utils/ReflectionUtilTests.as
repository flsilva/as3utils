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
	import org.flexunit.Assert;

	import flash.display.Sprite;
	import flash.net.FileReference;
	import flash.text.TextField;

	/**
	 * @author Flávio Silva
	 */
	public class ReflectionUtilTests
	{
		
		public function ReflectionUtilTests()
		{
			
		}
		
		///////////////////////
		// CONSTRUCTOR TESTS //
		///////////////////////
		
		[Test(expects="flash.errors.IllegalOperationError")]
		public function constructor_invalidInstanciation_ThrowsError(): void
		{
			var reflection:ReflectionUtil = new ReflectionUtil();
			reflection = null;
		}
		
		/////////////////////////////////////
		// Reflection.getClassName() TESTS //
		/////////////////////////////////////
		
		[Test]
		public function getClassName_validStringObject_ReturnsStringWithClassName(): void
		{
			var result:String = ReflectionUtil.getClassName("teste");
			Assert.assertEquals("String", result);
		}
		
		[Test]
		public function getClassName_validStringClass_ReturnsStringWithClassName(): void
		{
			var result:String = ReflectionUtil.getClassName(String);
			Assert.assertEquals("String", result);
		}
		
		[Test]
		public function getClassName_validNumericRoundingObject_ReturnsStringWithClassName(): void
		{
			var result:String = ReflectionUtil.getClassName(NumericRounding.FLOOR);
			Assert.assertEquals("NumericRounding", result);
		}
		
		////////////////////////////////////////
		// Reflection.getClassPackage() TESTS //
		////////////////////////////////////////
		
		[Test]
		public function getClassPackage_validSpriteObject_ReturnsStringWithClassPackage(): void
		{
			var result:String = ReflectionUtil.getClassPackage(new Sprite());
			Assert.assertEquals("flash.display", result);
		}
		
		[Test]
		public function getClassPackage_validStringUtilClass_ReturnsStringWithClassPackage(): void
		{
			var result:String = ReflectionUtil.getClassPackage(StringUtil);
			Assert.assertEquals("org.as3utils", result);
		}
		
		[Test]
		public function getClassPackage_validNumberClass_ReturnsNull(): void
		{
			var result:String = ReflectionUtil.getClassPackage(Number);
			Assert.assertNull(result);
		}
		
		/////////////////////////////////////
		// Reflection.getClassPath() TESTS //
		/////////////////////////////////////
		
		[Test]
		public function getClassPath_validNumberObject_ReturnsStringWithClassPath(): void
		{
			var result:String = ReflectionUtil.getClassPath(123.4);
			Assert.assertEquals("Number", result);
		}
		
		[Test]
		public function getClassPath_validNumberUtilClass_ReturnsStringWithClassPath(): void
		{
			var result:String = ReflectionUtil.getClassPath(NumberUtil);
			Assert.assertEquals("org.as3utils.NumberUtil", result);
		}
		
		//////////////////////////////////////////
		// Reflection.getSuperClassName() TESTS //
		//////////////////////////////////////////
		
		[Test]
		public function getSuperClassName_validNumberObject_ReturnsStringWithSuperClassName(): void
		{
			var result:String = ReflectionUtil.getSuperClassName(123.4);
			Assert.assertEquals("Object", result);
		}
		
		[Test]
		public function getSuperClassName_validSpriteObject_ReturnsStringWithSuperClassName(): void
		{
			var result:String = ReflectionUtil.getSuperClassName(new Sprite());
			Assert.assertEquals("DisplayObjectContainer", result);
		}
		
		/////////////////////////////////////////////
		// Reflection.getSuperClassPackage() TESTS //
		/////////////////////////////////////////////
		
		[Test]
		public function getSuperClassName_validArrayObject_ReturnsStringWithSuperClassPackage(): void
		{
			var result:String = ReflectionUtil.getSuperClassPackage([]);
			Assert.assertNull(result);
		}
		
		[Test]
		public function getSuperClassName_validFileReferenceObject_ReturnsStringWithSuperClassPackage(): void
		{
			var result:String = ReflectionUtil.getSuperClassPackage(new FileReference());
			Assert.assertEquals("flash.events", result);
		}
		
		[Test]
		public function getSuperClassName_validTextFieldClass_ReturnsStringWithSuperClassPackage(): void
		{
			var result:String = ReflectionUtil.getSuperClassPackage(TextField);
			Assert.assertEquals("flash.display", result);
		}
		
		/////////////////////////////////////////////
		// Reflection.getSuperClassPackage() TESTS //
		/////////////////////////////////////////////
		
		[Test]
		public function getSuperClassPath_validBooleanObject_ReturnsStringWithSuperClassPath(): void
		{
			var result:String = ReflectionUtil.getSuperClassPath(true);
			Assert.assertEquals("Object", result);
		}
		
		[Test]
		public function getSuperClassPath_validTextFieldObject_ReturnsStringWithSuperClassPath(): void
		{
			var result:String = ReflectionUtil.getSuperClassPath(new TextField());
			Assert.assertEquals("flash.display.InteractiveObject", result);
		}
		
	}

}