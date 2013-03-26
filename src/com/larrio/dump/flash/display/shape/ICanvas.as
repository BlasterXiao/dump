package com.larrio.dump.flash.display.shape
{
	import flash.display.BitmapData;
	import flash.display.InterpolationMethod;
	import flash.display.LineScaleMode;
	import flash.display.SpreadMethod;
	import flash.geom.Matrix;
	
	/**
	 * 可接受绘制数据画板
	 * @author larryhou
	 * @createTime Mar 26, 2013 12:18:49 PM
	 */
	public interface ICanvas
	{
		function lineStyle(thickness:Number = NaN, color:uint = 0, alpha:Number = 1.0, pixelHinting:Boolean = false, scaleMode:String = LineScaleMode.NORMAL, caps:String = null, joints:String = null, miterLimit:Number = 3):void;
		
		function moveTo(x:Number, y:Number):void;
		function lineTo(x:Number, y:Number):void;
		function curveTo(controlX:Number, controlY:Number, anchorX:Number, anchorY:Number):void;
		
		function beginFill(color:uint, alpha:Number = 1.0):void;
		function beginBitmapFill(bitmap:BitmapData, matrix:Matrix = null, repeat:Boolean = true, smooth:Boolean = false):void;
		function beginGradientFill(type:String, colors:Array, alphas:Array, ratios:Array, matrix:Matrix = null, spreadMethod:String = SpreadMethod.PAD, interpolationMethod:String = InterpolationMethod.RGB, focalPointRatio:Number = 0):void;
		
		function endFill():void;
	}
}