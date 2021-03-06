package demos.redrawShape
{
	import com.larrio.dump.SWFile;
	import com.larrio.dump.flash.display.shape.canvas.ContainerCanvas;
	import com.larrio.dump.flash.display.shape.canvas.GraphicsCanvas;
	import com.larrio.dump.flash.display.shape.canvas.ICanvas;
	import com.larrio.dump.flash.display.shape.canvas.StepRecordCanvas;
	import com.larrio.dump.flash.display.shape.collector.OutlineCollector;
	import com.larrio.dump.tags.DefineShapeTag;
	import com.larrio.dump.tags.SWFTag;
	import com.larrio.dump.tags.TagType;
	
	import flash.display.Sprite;
	
	[SWF(width="1024", height="768")]
	
	/**
	 * 
	 * @author larryhou
	 * @createTime Apr 15, 2013 1:27:02 PM
	 */
	public class OutlineMain extends Sprite
	{
		[Embed(source="../../../libs/joker.swf", mimeType="application/octet-stream")]
		private var FileByteArray:Class;
		
		/**
		 * 构造函数
		 * create a [OutlineMain] object
		 */
		public function OutlineMain()
		{
			var swf:SWFile = new SWFile(new FileByteArray());
			
			var shapeTag:DefineShapeTag;
			for each(var tag:SWFTag in swf.tags)
			{
				switch(tag.type)
				{
					case TagType.DEFINE_SHAPE:
					case TagType.DEFINE_SHAPE2:
					case TagType.DEFINE_SHAPE3:
					case TagType.DEFINE_SHAPE4:
					{
						shapeTag = tag as DefineShapeTag;
						break;
					}
				}
				
				if (shapeTag) break;
			}
			
			this.scaleX = this.scaleY = 3.0
			
			var outline:StepRecordCanvas;
			var list:Vector.<ICanvas> = new Vector.<ICanvas>();
			list.push(new GraphicsCanvas(graphics));
			list.push(outline = new StepRecordCanvas());
			
			var collector:OutlineCollector = new OutlineCollector(shapeTag.shape, true);
			collector.drawVectorOn(new ContainerCanvas(list));
			
			var step:Object;
			for (var i:int = 0; i < outline.steps.length; i++)
			{
				step = outline.steps[i];
				trace(padding(step["method"]) + ":[" + step.params + "]");
			}

		}
		
		private function padding(value:String):String
		{
			while (value.length < 10) value += " ";
			return value;
		}
	}
}