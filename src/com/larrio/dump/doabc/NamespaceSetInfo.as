package com.larrio.dump.doabc
{
	import com.larrio.dump.codec.FileDecoder;
	import com.larrio.dump.codec.FileEncoder;
	import com.larrio.dump.interfaces.ICodec;
	import com.larrio.dump.utils.assertTrue;
	
	/**
	 * 命名空间集合
	 * @author larryhou
	 * @createTime Dec 16, 2012 3:58:38 PM
	 */
	public class NamespaceSetInfo implements ICodec
	{
		private var _namespaces:Vector.<uint>;
		
		private var _constants:ConstantPool;
		
		/**
		 * 构造函数
		 * create a [NamespaceSetInfo] object
		 */
		public function NamespaceSetInfo(constants:ConstantPool)
		{
			_constants = constants;
		}
		
		/**
		 * 二进制解码 
		 * @param decoder	解码器
		 */		
		public function decode(decoder:FileDecoder):void
		{
			_namespaces = new Vector.<uint>;
			
			var length:uint = decoder.readEU30();
			while(length-- > 0) _namespaces.push(decoder.readEU30());
			
			// TODO: hard code unit test
			for each(var index:uint in _namespaces)
			{
				assertTrue(index >= 0 && index < _constants.namespaces.length);
			}
			
		}
		
		/**
		 * 二进制编码 
		 * @param encoder	编码器
		 */		
		public function encode(encoder:FileEncoder):void
		{
			var length:uint = _namespaces.length;
			
			encoder.writeEU30(length);
			for (var i:int = 0; i < length; i++)
			{
				encoder.writeEU30(_namespaces[i]);
			}
			
		}
		
		/**
		 * 字符串输出
		 */		
		public function toString():String
		{
			var result:Array = [];
			
			var length:int = _namespaces.length;
			for (var i:int = 0; i < length; i++)
			{
				result[i] = _constants.namespaces[_namespaces[i]];
			}
			
			return result.join(",");
		}

		/**
		 * 命名空间索引数组
		 */		
		public function get namespaces():Vector.<uint> { return _namespaces; }

	}
}