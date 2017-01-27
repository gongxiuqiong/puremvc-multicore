package com.game.publicDatas
{
	import com.MCore.managers.LanguageManager;

	/**
	 * 公共信息
	 */
	public class PublicInfos
	{
		
		/**
		 * 资源包 地址
		 */		
		public static var RES:String = "res/";
		/**
		 * 语言版本ID
		 */		
		public static var languageId:uint = 1;
		
		/**
		 * 语言版本所对应的文件夹
		 */		
		public static function getLanguage():String
		{
			switch (languageId) 
			{
				case 1: // 简体中文
					return 'zh-CN';
				default :
					return 'zh-CN';
					
			}
		}
		/**
		 * 加载语言文本
		 * @param	content  参数
		 */
		public static function loadLanguage(content : String) : void
		{
			LanguageManager.load(getLanguage(), content);
		}
		
		/**
		 * 根据键值获取语言包相应信息
		 * 
		 * @param	key  键值
		 * @param	args  参数数组，用于替换{0}{1}...占位符
		 * @return
		 */
		public static function parseLanguage(key : String, args : Array = null) : String
		{
			return LanguageManager.parse(getLanguage(), key, args);
		}
		
		
		public static function getClassNameByClz(clz:Class):String
		{
			return clz["name"];
		}
		public static function getClassByName(className:String):Class
		{
			var rst:Class;
			rst=__JS__("eval(className)");
			return rst;
		}
		public static function createObjByName(className:String):*
		{
			var clz:Class;
			clz=getClassByName(className);
			return new clz();
		}
	}
}