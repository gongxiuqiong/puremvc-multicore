package com.MCore.managers 
{
	import laya.display.Sprite;
	import laya.ui.View;

	/**
	 * ...
	 * @author cong
	 */
	public class PopUpData
	{
		public function PopUpData()
		{
		}

		// 窗体本身
		public var owner : View;
		// 容器
		public var parent : Sprite;
		// 模式窗体遮罩
		public var modalMask : View;
		// 是否是模式窗体
		public var modal : Boolean;
		public var maskColor : uint;
		public var maskAlpha : Number;
	}

}