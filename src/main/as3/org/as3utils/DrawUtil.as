/*
 * Licensed under the MIT License
 * 
 * Copyright 2009 (c) Flávio Silva, flsilva.com.
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
 */

package org.as3utils
{
	
	import flash.geom.Rectangle;
	import flash.display.Shape;
	import flash.errors.IllegalOperationError;
	
	/**
	 * A utility class for working with drawings.
	 * 
	 * @author Flávio Silva
	 */
	public class DrawUtil
	{
		
		/**
		 * DrawUtil is a static class and shouldn't be instantiated.
		 * 
		 * @throws 	IllegalOperationError 	DrawUtil is a static class and shouldn't be instantiated.
		 */
		public function DrawUtil()
		{
			throw new IllegalOperationError("DrawUtil is a static class and shouldn't be instantiated.");
		}
		
		public static function border(bounds:Rectangle, thickness:Number = 1, color:uint = 0xFFFFFF, alpha:Number = 1):Shape
		{
			var s:Shape = new Shape();
			
			s.graphics.lineStyle(thickness, color, alpha);
			s.graphics.lineTo(bounds.width, 0);
			s.graphics.lineTo(bounds.width, bounds.height);
			s.graphics.lineTo(0, bounds.height);
			s.graphics.lineTo(0, 0);
			
			return s;
		}
		
		/**
		 * Returns a <code>Shape</code> object using the <code>Shape.Graphics.drawCircle</code> method.
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import flash.display.Shape;
		 * import org.as3coreaddendum.utils.DrawUtil;
		 * 
		 * var s:Shape = DrawUtil.circ(0, 0, 50, 0xFF0000);
		 * addChild(s);
		 * </listing>
		 * 
		 * @param  	x 			the <em>x</em> location of the center of the circle relative to the registration point of the <code>Shape</code> object (in pixels).
		 * @param  	y 			the <em>y</em> location of the center of the circle relative to the registration point of the <code>Shape</code> object (in pixels).
		 * @param  	radius		the radius of the circle (in pixels).
		 * @param 	color 		the color of the <code>Shape</code>.
		 * @param 	alpha 		the alpha of the <code>Shape</code>.
		 * @return 	a <code>Shape</code> object using the <code>Shape.Graphics.drawCircle</code> method.
		 */
		public static function circ(x:Number, y:Number, radius:Number, color:uint = 0xFFFFFF, alpha:Number = 1):Shape
		{
			var s:Shape = new Shape();
			
			s.graphics.beginFill(color, 1);
			s.graphics.drawCircle(x, y, radius);
			s.graphics.endFill();
			s.alpha = alpha;
			
			return s;
		}
		
		/**
		 * Returns a <code>Shape</code> object using the <code>Shape.Graphics.drawRect</code> method.
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import flash.display.Shape;
		 * import org.as3coreaddendum.utils.DrawUtil;
		 * 
		 * var s:Shape = DrawUtil.rect(0, 0, 250, 250, 0xFF0000);
		 * addChild(s);
		 * </listing>
		 * 
		 * @param  	x 			a number indicating the horizontal position relative to the registration point of the <code>Shape</code> object (in pixels).
		 * @param  	y 			a number indicating the vertical position relative to the registration point of the <code>Shape</code> object (in pixels).
		 * @param  	w 			the width of the <code>Shape</code> (in pixels).
		 * @param  	h 			the height of the <code>Shape</code> (in pixels).
		 * @param 	color 		the color of the <code>Shape</code>.
		 * @param 	alpha 		the alpha of the <code>Shape</code>.
		 * @return 	a <code>Shape</code> object using the <code>Shape.Graphics.drawRect</code> method.
		 */
		public static function rect(x:Number, y:Number, w:Number, h:Number, color:uint = 0xFFFFFF, alpha:Number = 1):Shape
		{
			var s:Shape = new Shape();
			
			s.graphics.beginFill(color, alpha);
			s.graphics.drawRect(x, y, w, h);
			s.graphics.endFill();
			
			return s;
		}
		
	}
	
}