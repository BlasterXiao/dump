package com.larrio.dump.doabc
{
	import com.larrio.dump.codec.FileDecoder;
	import com.larrio.dump.codec.FileEncoder;
	import com.larrio.dump.interfaces.ICodec;
	import com.larrio.dump.utils.assertTrue;
	
	/**
	 * DoABC之metadata
	 * @author larryhou
	 * @createTime Dec 16, 2012 3:42:46 PM
	 */
	public class MetadataInfo implements ICodec
	{
		private var _name:uint;
		private var _items:Vector.<MetadataItemInfo>;
		
		private var _constants:ConstantPool;
		
		private var _lenR:uint;
		
		/**
		 * 构造函数
		 * create a [MetadataInfo] object
		 */
		public function MetadataInfo(constants:ConstantPool)
		{
			_constants = constants;
		}
		
		/**
		 * 二进制解码 
		 * @param decoder	解码器
		 */		
		public function decode(decoder:FileDecoder):void
		{
			_lenR = decoder.position;
			var _length:uint;
			
			_name = decoder.readEU30();
			assertTrue(_name >= 0 && _name < _constants.strings.length);
			
			_length = decoder.readEU30();
			_items = new Vector.<MetadataItemInfo>(_length, true);
			for (var i:int = 0; i < _length; i++)
			{
				_items[i] = new MetadataItemInfo(_constants);
				_items[i].decode(decoder);
			}	
			
			_lenR = decoder.position - _lenR;
		}
		
		/**
		 * 二进制编码 
		 * @param encoder	编码器
		 */		
		public function encode(encoder:FileEncoder):void
		{
			var lenR:uint = encoder.position;
			encoder.writeEU30(_name);
			
			var length:uint = _items.length;
			encoder.writeEU30(length);
			
			for (var i:int = 0; i < length; i++)
			{
				_items[i].encode(encoder);
			}
			
			lenR = encoder.position - lenR;
			assertTrue(lenR == _lenR);
		}
		
		/**
		 * 字符串输出
		 */		
		public function toString():String
		{
			return _constants.strings[_name] + ": " + _items.join(" ");
		}
		
		/**
		 * 指向strings常量数组的索引
		 */		
		public function get name():uint { return _name; }
		
		/**
		 * 指向strings常量数组的索引
		 */		
		public function get items():Vector.<MetadataItemInfo> { return _items; }

	}
}