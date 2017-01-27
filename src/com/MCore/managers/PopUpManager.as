package com.MCore.managers 
{
	import laya.display.Sprite;
	import laya.ui.View;
	import laya.utils.Dictionary;

	/**
	 * @example
	 * 		
	 * 	
		<listing version="3.0"> 	 
			var win:AlertTip = new AlertTip(350, 200);
			win.msg = "對不起，您的元寶不足！請到兌換元寶頁面兌換元寶！";
			PopUpManager.addPopUp(win, this.stage, true, 0, 0);
			PopUpManager.centerPopUp(win);　	
		</listing>		
	 * ...
	 * @author ongsh (Tool -> 弹出层管理器)
	 */
	public class PopUpManager  
	{
		
		private static var _impl:IPopUp;// 弹出层管理器实现类
		private static var _impl1:IPopUp = new PopUpManagerImpl1();
		private static var _impl2:IPopUp = new PopUpManagerImpl2();
		private static var _popUpType:String='';
		public static const FADE_IN_OUT:String = 'fade_in_out';
		public static const ZOOM_IN_OUT:String = 'zoom_in_out';
		private static var popUpTypes:Dictionary = new Dictionary(); 
		
		/**
		 * 添加弹出框
		 * 
		 * @param	window		待弹出窗体
		 * @param	parent		容器
		 * @param	modal		模式(true表示有遮罩,false表示无遮罩)
		 * @param	maskColor	遮罩颜色
		 * @param	maskAlpha	遮罩颜色透明度
		 */
		public static function addPopUp(window:View , parent:Sprite,
										modal:Boolean=false,maskColor:uint=0x000000,maskAlpha:Number=0.5,tweener:Boolean=true):void
		{	
			popUpTypes.set(window.name, popUpType);
			impl.addPopUp(window, parent, modal, maskColor, maskAlpha, tweener);	
		}
		
		/**
		 * 居中弹出窗体
		 * 
		 * @param	window	窗体
		 */
		public static function centerPopUp(window:View):void 
		{
			impl.centerPopUp(window);
		}
		
		/**
		 * 移除弹出窗体
		 * 
		 * @param	window 窗体
		 */
		public static function removePopUp(popUp:View):void
		{
			if (popUp!=null) 
			{
				popUpType = popUpTypes.get(popUp.name);
				impl.removePopUp(popUp);
				popUpTypes.remove(popUp.name);
			}
		}
		/**
		 * 查找窗体
		 * 
		 * @param	owner 窗体父级对像
		 */
		public static function findPopUpByOwner(owner : Object):View
		{
			return impl.findPopUpByOwner(owner);
		}
		/**
		 * 是否有这个窗体
		 * @param	windowName 窗体名称
		 */
		public static function isHasPopUp(windowName : String):Boolean
		{
			return popUpTypes.get(windowName) != null;
		}
		
		static private function get impl():IPopUp 
		{
			return _impl;
		}
		
		static public function get popUpType():String 
		{
			return _popUpType;
		}
		
		static public function set popUpType(value:String):void 
		{
			_popUpType = value;
			if (value == FADE_IN_OUT)
			{
				_impl = _impl1;
			}
			else if(value==ZOOM_IN_OUT)
			{
				_impl = _impl2;
			}
		}

	}
}
