package com.larrio.dump.flash.display.shape.collector
{
	import com.larrio.dump.flash.display.shape.canvas.ICanvas;
	import com.larrio.dump.model.shape.CurvedEdgeShapeRecord;
	import com.larrio.dump.model.shape.LineStyle;
	import com.larrio.dump.model.shape.Shape;
	import com.larrio.dump.model.shape.ShapeWithStyle;
	import com.larrio.dump.model.shape.StraightEdgeShapeRecord;
	import com.larrio.dump.model.shape.StyleChangeShapeRecord;
	
	/**
	 * 只收集线条样式
	 * @author larryhou
	 * @createTime Mar 29, 2013 2:04:10 PM
	 */
	public class OutlineCollector extends ShapeCollector
	{
		private var _styles:Vector.<LineStyle>;
		private var _includeInvisible:Boolean;
		
		private var _lineStyle:uint;
		private var _index:uint;
		
		/**
		 * 构造函数
		 * create a [OutlineCollector] object
		 */
		public function OutlineCollector(shape:Shape = null, includeInvisible:Boolean = false)
		{
			this.includeInvisible = includeInvisible;
			super(shape);
		}
		
		override public function load(shape:Shape):void
		{
			super.load(shape);
			
			if (_shape is ShapeWithStyle)
			{
				_styles = (_shape as ShapeWithStyle).lineStyles.styles;
			}
		}
		
		override public function drawVectorOn(canvas:ICanvas):void
		{
			super.drawVectorOn(canvas);
		}
		
		override protected function processShapeStyle(record:StyleChangeShapeRecord):void
		{
			if (record.stateMoveTo)
			{
				_position.x = record.moveToX / TWIPS_PER_PIXEL;
				_position.y = record.moveToY / TWIPS_PER_PIXEL;
				
				_canvas.moveTo(_position.x, _position.y);
			}
			
			if (record.stateNewStyles)
			{
				_styles = record.lineStyles.styles;
			}
			
			if (record.stateLineStyle)
			{
				if (record.lineStyle)
				{
					_index = record.lineStyle;
					changeLineStyle(_styles[_index - 1]);
				}
				else
				if (_includeInvisible)
				{
					_canvas.lineStyle(0.1, 0xFF0000, 1);
				}
				else
				{
					_index = 0;
					_canvas.lineStyle(NaN);
				}
			}
			else
			if (!_index && _includeInvisible)
			{
				_canvas.lineStyle(0.1, 0xFF0000, 1);
			}
		}
		
		override protected function processStraightEdge(recorder:StraightEdgeShapeRecord):void
		{
			_position.x += recorder.deltaX / TWIPS_PER_PIXEL;
			_position.y += recorder.deltaY / TWIPS_PER_PIXEL;
			
			_canvas.lineTo(_position.x, _position.y);
		}
		
		override protected function processCurvedEdge(record:CurvedEdgeShapeRecord):void
		{
			var ctrlX:Number = _position.x += record.deltaControlX / TWIPS_PER_PIXEL;
			var ctrlY:Number = _position.y += record.deltaControlY / TWIPS_PER_PIXEL;
			
			var anchorX:Number = _position.x += record.deltaAnchorX / TWIPS_PER_PIXEL;
			var anchorY:Number = _position.y += record.deltaAnchorY / TWIPS_PER_PIXEL;
			
			_canvas.curveTo(ctrlX, ctrlY, anchorX, anchorY);
		}

		/**
		 * 包含不可见线条
		 */		
		public function get includeInvisible():Boolean { return _includeInvisible; }
		public function set includeInvisible(value:Boolean):void
		{
			_includeInvisible = value;
		}
	}
}