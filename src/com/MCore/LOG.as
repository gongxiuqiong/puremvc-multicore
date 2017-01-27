package com.MCore
{
	

	public class LOG
	{
		public function LOG()
		{
		}
		
		/**
		 * 用于输出普通信息
		 */
		public static function trace(...arg):void {
			if (arg.length == 1) 
			{
				__JS__("console.log(arg[0]);");
			}else if (arg.length == 2 && arg[0] is String) 
			{
				__JS__("console.log('↓↓↓↓↓↓↓↓ ' + arg[0] + ' ↓↓↓↓↓↓↓↓');");
				__JS__("console.log(arg[1]);");
			}else
			{
				__JS__("console.log(arg);");
			}
		}
		/**
		 * 用于输出错误信息
		 */
		public static function error(v:*):void {
			__JS__("console.error(v);");
		}
		/**
		 * 用于输出警示信息
		 */
		public static function warn(v:*):void {
			__JS__("console.warn(v);");
		}
		/**
		 * 用来显示网页的某个节点（node）所包含的html/xml代码
		 */
		public static function dirxml(v:*):void {
			__JS__("console.dirxml(v);");
		}
		/**
		 * 弹出字符串信息,并停止进程
		 */
		public static function alert(v:String):void {
			__JS__("alert(v);");
		}
		
	}
}