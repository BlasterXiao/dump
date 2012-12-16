package com.larrio.dump.doabc
{
	import com.larrio.dump.interfaces.ICodec;
	import com.larrio.utils.FileDecoder;
	import com.larrio.utils.FileEncoder;
	
	/**
	 * DoABC常量集合
	 * @author larryhou
	 * @createTime Dec 16, 2012 3:11:50 PM
	 */
	public class ConstantPool implements ICodec
	{
		private var _ints:Vector.<int>;
		private var _uints:Vector.<uint>;
		private var _doubles:Vector.<Number>;
		private var _strings:Vector.<String>;
		
		private var _nssets:Vector.<NamespaceSetInfo>;
		private var _namespaces:Vector.<NamespaceInfo>;
		
		private var _multinames:Vector.<MultinameInfo>;
		
		/**
		 * 构造函数
		 * create a [ConstantPool] object
		 */
		public function ConstantPool()
		{
			
		}
		
		/**
		 * 二进制解码 
		 * @param decoder	解码器
		 */		
		public function decode(decoder:FileDecoder):void
		{
			var length:int, i:int;
			
			length = decoder.readEU30() + 1;
			_ints = new Vector.<int>(length, true);
			for (i = 1; i < length; i++)
			{
				_ints[i] = decoder.readES32();
			}
			
			length = decoder.readEU30() + 1;
			_uints = new Vector.<uint>(length, true);
			for (i = 1; i < length; i++)
			{
				_uints[i] = decoder.readEU32();
			}
			
			length = decoder.readEU30() + 1;
			_doubles = new Vector.<Number>(length, true);
			for (i = 1; i < length; i++)
			{
				_doubles[i] = decoder.readDouble();
			}
			
			length = decoder.readEU30() + 1;
			_strings = new Vector.<String>(length, true);
			for (i = 1; i < length; i++)
			{
				_strings[i] = decoder.readSTR();
				trace(_strings[i]);
			}

		}
		
		/**
		 * 二进制编码 
		 * @param encoder	编码器
		 */		
		public function encode(encoder:FileEncoder):void
		{
			
		}

		/**
		 * 有符号整形数组
		 */		
		public function get ints():Vector.<int> { return _ints; }

		/**
		 * 无符号整形数组
		 */		
		public function get uints():Vector.<uint> { return _uints; }

		/**
		 * 双精度浮点型常量数组
		 */		
		public function get doubles():Vector.<Number> { return _doubles; }

		/**
		 * 字符串常量数组
		 */		
		public function get strings():Vector.<String> { return _strings; }

		/**
		 * 命名空间集合数组
		 */		
		public function get nssets():Vector.<NamespaceSetInfo> { return _nssets; }

		/**
		 * 命名空间数组
		 */		
		public function get namespaces():Vector.<NamespaceInfo> { return _namespaces; }
		
		/**
		 * multinames数组
		 */		
		public function get multinames():Vector.<MultinameInfo> { return _multinames; }
		
	}
}