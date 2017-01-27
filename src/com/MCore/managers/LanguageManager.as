package com.MCore.managers
{
	/**
	 * @author ongsh
	 * @example 
	 * 
	 <listing version="3.0"> 
	 package com.MCore.test
	 {
	 import com.MCore.managers.LanguageManager;
	 
	 import flash.display.Sprite;
	 import flash.events.Event;
	 import flash.net.URLLoader;
	 import flash.net.URLLoaderDataFormat;
	 import flash.net.URLRequest;
	 import flash.system.Capabilities;
	 
	 
	 public class TestLanguageManager extends Sprite
	 {
	 private var urlLoader:URLLoader;
	 
	 public function TestLanguageManager()
	 {
	 urlLoader = new URLLoader();   
	 urlLoader.dataFormat = URLLoaderDataFormat.TEXT;   
	 urlLoader.addEventListener(Event.COMPLETE, loadComplete);   
	 urlLoader.load(new URLRequest("source/"+sysLanguage+"/language.txt"));   
	 }
	 
	 private function loadComplete(event : Event) : void
	 {
	 LanguageManager.load(sysLanguage, urlLoader.data);
	 var str:String = LanguageManager.parse(sysLanguage, "金币tip") ;      
	 trace(str);
	 }
	 
	 private var _sysLanguage : String;
	 
	 public function get sysLanguage() : String
	 {
	 _sysLanguage = Capabilities.language;
	 return _sysLanguage;
	 }
	 }
	 }
	 </listing>
	 *	
	 */
	public class LanguageManager
	{
		private static var _impl : LanguageManagerImpl;
		
		/**
		 * 加载消息文档
		 * 
		 * @param	contentName 文档名称
		 * @param	content 文档内容
		 */
		public static function load(contentName : String, content : String) : void
		{
			impl.load(contentName, content);
		}
		
		/**
		 * 卸载消息文档
		 * 
		 * @param	contentNam 文档名称
		 */
		
		public static function unload(contentName : String) : void
		{
			impl.unload(contentName);
		}
		
		/**
		 * 解析文档的key，返还key对应的value
		 * 
		 * @param	contentName 文档名称
		 * @param	key 键值
		 * @param	argsArray 替换占位符({0},{1}...)的参数
		 * @return
		 */
		public static function parse(contentName : String, key : String, argsArray : Array = null) : String
		{
			return impl.parse(contentName, key, argsArray);
		}
		
		/**
		 * 解析文档的数组，格式如下： 
		 * 		season:Array = ['冬', '春', '夏', '秋'];
		 * @param	contentName	文档名称
		 * @param	key			键值
		 * @return  数组
		 */
		public static function parseArray(contentName:String, key:String):Array
		{
			return impl.parseArray(contentName,key);
		}
		
		/**
		 * 使用传入的各个参数替换指定的字符串内的 标记
		 * @param str 用来进行替换的源字符串。
		 * @param rest 可在 str 参数中的每个 <code>{n}</code> 位置被替换的值。
		 * @return 
		 * trace( printf( "您确定要花费{money}金币，来购买{amount}个红瓶吗？", 100, 5 ));
		 * trace( printf( "{name}公会全体成员完成公会任务，奖励{name}公会所有成员{money}金币和{exp}经验。", { name: "天地会", money: 100, exp: 2000 }));
		 */
		public static function printf(str:String, ... rest ):String
		{
			return impl.printf(str,rest );
		}
		
		static public function get isDebug() : Boolean
		{
			return impl.isDebug;
		}
		
		static public function set isDebug(value : Boolean) : void
		{
			impl.isDebug = value;
		}
		
		static private function get impl() : LanguageManagerImpl
		{
			if (_impl == null)
			{
				_impl = new LanguageManagerImpl();
			}
			return _impl;
		}
		
	}
}
