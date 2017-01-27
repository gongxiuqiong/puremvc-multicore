package com.MCore.utils
{
	import laya.display.Node;

	public class ToolsUtil
	{
		public function ToolsUtil()
		{
		} 
		/**
		 * 移除display 节点
		 */
		public static function delDisplayContainer(container:Node):void
		{
			var child:*;
			var i:int;
			for (i = container.numChildren - 1; i >= 0; i--)
			{
				child = container.getChildAt(0);
				if (container.getChildAt(0) is Node)
				{
					delDisplayContainer((child));
				}
				container.removeChildAt(0);
			}
		}
	}
}