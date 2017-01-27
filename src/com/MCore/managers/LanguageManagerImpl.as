package com.MCore.managers
{
	import com.MCore.LOG;
	
	import laya.utils.Dictionary;

	/**
	 * ...
	 * @author ongsh
	 */
	public class LanguageManagerImpl 
	{
		
		public var isDebug:Boolean = true;
		
		private var messages:Dictionary = new Dictionary();
		//原始数据
		private var rawDataMap:Dictionary = new Dictionary();
		private const PATTERN_PRINTF:RegExp = /\{[a-z0-9_]+\}/i;
		
		
		public function LanguageManagerImpl() 
		{
			
		}
		
		/**
		 * 加载消息文档
		 * 
		 * @param	contentName 文档名称
		 * @param	content 文档内容
		 */
		public function load(contentName:String,content:String):void
		{
			rawDataMap.set(contentName,content);
			
			var lines:Array = content.split("\n");
			
			for(var i:int=0; i< lines.length ; i ++)
			{
				var line:String = lines[i];
				line = trim(line);
				if(line == "")
				{
					//debugTrace(contentName,"的第"+(i+1)+"行是空行！");
					continue;
				}
				if(isAnnotation(line))
				{
					//debugTrace(contentName,"的第"+(i+1)+"行是注释行！");
					continue;
				}
				var key:String;
				var value:String;
				var sep:String = "=";
				var firstSepIndex:int = line.indexOf(sep);
				if(firstSepIndex!=-1)
				{
					key = line.substring(0,firstSepIndex);
					value = line.substring(firstSepIndex+1);
					if(messages.get(contentName)==null)
					{
						messages.set(contentName,new Dictionary());
					}
					messages.get(contentName).set(key,value);
				}else{
					debugTrace(contentName,"的第"+(i+1)+"行格式不正确！");
				}
			}
		}
		
		/**
		 * @param	contentName 文档名称
		 * @param	key 键值
		 * @param	argsArray 替换占位符({0},{1}...)的参数
		 * @return
		 */
		public function parse(contentName:String,key:String,argsArray:Array=null):String
		{
			if(messages.get(contentName))
			{
				var value:String = messages.get(contentName).get(key);
				if(value==null)
				{
					debugTrace(contentName,key,"不存在");
					return key + ":null";
				}else{
					var str:String = replacePlaceholder(value,argsArray);
					return str;
				}
				
			}else{
				debugTrace(contentName,"不存在");
				return key + ":null";
			}
			
		}
		
		/**
		 * 解析文档的数组，格式如下： 
		 * 		season:Array = ['冬', '春', '夏', '秋'];
		 * @param	contentName	文档名称
		 * @param	key			键值
		 * @return  数组
		 */
		public function parseArray(contentName:String, key:String):Array
		{
			//season:Array = ['冬', '春', '夏', '秋'];
			var result:Array = messages.get(contentName).get(key);
			if (!result)
			{
				var value:Array = [];
				var exp:RegExp = new RegExp("\\s*" + key + "\\s*:\\s*Array\\s*=\\s*\\[(.*)\\]");
				var obj:Object = exp.exec(rawDataMap.get(contentName));
				if (obj && obj[1])
				{
					var str:String = obj[1];
					var arr:Array = str.split(",");
					for each(var itemStr:String in arr)
					{
						exp = new RegExp("\\s*'(.*)'\\s*");
						var item:Object = exp.exec(itemStr);
						if (item && item[1])
						{
							value.push(item[1]);
						}
					}
				}
				messages.get(contentName).set(key,value);
				result = value;
			}
			
			return result;
		}
		
		
		/**
		 
		 *  使用传入的各个参数替换指定的字符串内的 <code>{n}</code> 标记。		 
		 *  @param str  - 用来进行替换的源字符串。
		 *  @param rest  - 可在 str 参数中的每个 <code>{n}</code> 位置被替换的值。
		 *  如果第一个参数是一个数组，则该数组将用作参数列表。若第一个参数为数据对象，则会进行全局替换，否则为顺序替换。
		 *  <p>源字符串可包含 <code>{n}</code> 形式的特殊标记，其中 n 为任意标识符（由字母、数字、下划线组成），
		 *  它将被替换成具体的值。</p>		 
		 *  <p>因为允许 rest 第一个参数为数组，因此允许在其它想要使用... rest 参数的方法中重复使用此例程。例如:		 
		 *         <table><tr><td style="padding:10px;color:#334455"><code>		 
		 *     public function myTracer(str:String, ... rest):void<br>		 
		 *     {<br>		 
		 *                     label.text += printf(str, rest) + "\n";<br>		 
		 *     }		 
		 *         </code></td></tr></table><p>		 
		 *		 
		 *  @return 使用指定的各个参数替换了所有 <code>{n}</code> 标记的新字符串。		 
		 *		 
		 *  <table><tr><td style="padding:10px;color:#334455"><code>		 
		 *  var str:String = "here is some info {number} and {boolean}";<br>		 
		 *  trace(printf(str, 15.4, true));<br>		 
		 *  <br>		 
		 *   this will output the following string:<br>		 
		 *   "here is some info 15.4 and true"<br>		 
		 *        </code></td></tr></table>		 
		 */		
		public function printf( str:String, ... rest ):String			
		{			
			if( str == null || str == "" )				
				return "";			
			var lng:int; // 最终需要计算替换的次数			
			var args:Array; // 最终需要替换的数据			
			var i:int;			
			switch( typeof( rest[ 0 ]))				
			{				
				case "number":					
				case "boolean":					
				case "string":					
				{					
					lng = rest.length;					
					args = rest;					
					
					for( i = 0; i < lng; i++ )						
					{						
						str = str.replace( PATTERN_PRINTF, args[ i ]);						
					}					
					break;					
				}
				case "object":					
				{					
					if( rest[ 0 ] is Array )						
					{						
						args = rest[ 0 ] as Array;						
						lng = args.length;						
						
						for( i = 0; i < lng; i++ )							
						{							
							str = str.replace( PATTERN_PRINTF, args[ i ]);							
						}						
					}						
					else						
					{						
						var reg:RegExp;	
						for( var prop:String in rest[ 0 ])							
						{							
							reg = new RegExp( "\{" + prop + "\}", "ig" );							
							str = str.replace( reg, rest[ 0 ][ prop ]);							
						}						
					}					
					break;					
				}					
			}	
			return str;
			
		}
		
		
		/**
		 * 卸载消息文档
		 * 
		 * @param	contentNam 文档名称
		 */
		public function unload(contentName:String):void
		{
			if( messages.indexOf(contentName)!=-1 )
			{
				messages.remove(contentName);
			}
		}
		
		private function debugTrace(...args):void
		{
			if(isDebug)
			{
				LOG.error("语言包错误输出:----------------------\\\\");
				LOG.error(args);
			}
		}
		
		/**
		 * 是否是注释
		 * 
		 * @param	str 字符串
		 * @return
		 */
		private function isAnnotation(str:String):Boolean
		{
			if(str.charAt(0) == "#")
			{
				return true;	
			}else{
				return false;
			}
		}
		
		
		/**
		 * 把字符串中的占位符 {0} {1} 用数组中的字符串替换
		 * @param	source	源字符串
		 * @param	args	待替换字符串数组
		 * @return	替换后的字符串
		 */
		private function replacePlaceholder(source:String, args:Array):String
		{
			var pattern:RegExp = /{(\d)}/g;
			
			source =  source.replace(pattern, function():String {
				return args[arguments[1]];
			});
			
			return source;
		}
		
		/**
		 * 剔除字符串前后空白
		 * @param	str	源字符串
		 * @return	结果字符串
		 */
		private function trim(str:String):String
		{
			return str.replace(/(^\s+)|(\s+$)/g,"");   
		}
	}
	
}