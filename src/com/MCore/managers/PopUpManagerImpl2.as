package com.MCore.managers
{
	
	import laya.display.Sprite;
	import laya.display.Stage;
	import laya.ui.View;
	import laya.utils.Handler;
	import laya.utils.Tween;

	/**
	 * ...
	 * @author ongsh ( Tool -> 弹出框管理实现)
	 */
	public class PopUpManagerImpl2 implements IPopUp
	{
		private static var popupInfo : Array;
		
		/**
		 * 添加弹出框
		 * 
		 * @param	window		待弹出窗体
		 * @param	parent		容器
		 * @param	modal		模式(true表示有遮罩,false表示无遮罩)
		 * @param	maskColor	遮罩颜色
		 * @param	maskAlpha	遮罩颜色透明度
		 */
		public  function addPopUp(window : View, parent : Sprite, modal : Boolean = false, maskColor : uint = 0x000000, maskAlpha : Number = 0.5,tweener:Boolean = true) : void
		{	 
			if (!popupInfo)
			{
				popupInfo = [];
			}
			var finishX:uint;
			var finishY:uint;
			if (parent is Stage) 
			{
				finishX = Laya.stage.width / 2 - window.width / 2;
				finishY = Laya.stage.height / 2 - window.height / 2;
			}
			else 
			{
				finishX = parent.width / 2 - window.width / 2;
				finishY = parent.height / 2 - window.height / 2;
			}
			
		
			
			const o : PopUpData = new PopUpData();
			o.owner = window;
			o.parent = parent;
			o.modal = modal;
			o.maskColor = maskColor;
			o.maskAlpha = maskAlpha;
			popupInfo.push(o);

			if (modal)
			{
				createModalWindow(parent, o);
			} 
			window.y = 22;
			parent.addChild(window);
 
			if (tweener) 
			{	
				window.alpha = 0.3;
				window.scaleX = window.scaleY = 0.2;
				if (parent is Stage) 
				{
					window.x = Laya.stage.width / 2 - window.width / 2;
					window.y = Laya.stage.height / 2 - window.height / 2;
				}
				else 
				{
					window.x = parent.width / 2 - window.width / 2;
					window.y = parent.height / 2 - window.height / 2;
				}
				Tween.to(window,{alpha:1,scaleX:1,scaleY:1,x:finishX,y:finishY},300);
			}
			
			if(o.modalMask)
			{
				var mask:Sprite = o.modalMask;
				mask.alpha = 0.3;
				Tween.to(mask,{alpha:1},300);
			}
			
		}

		/**
		 * 居中弹出窗体
		 * 
		 * @param	window	窗体
		 */
		public  function centerPopUp(window : View) : void
		{
			var o : PopUpData = findPopupInfoByOwner(window);
			if (o != null)
			{
				if (o.parent is Stage)
				{
					window.x = Laya.stage.width / 2- window.width / 2;;
					window.y = Laya.stage.height / 2- window.height / 2;;
				}
				else
				{
					window.x = o.parent.width / 2- window.width / 2;
					window.y = o.parent.height / 2- window.height / 2;;
				}
			}
			
		}

		/**
		 * 移除弹出窗体
		 * 
		 * @param	window 窗体
		 */
		public  function removePopUp(window : View) : void
		{
			var o : PopUpData = findPopupInfoByOwner(window);
				
	        if (o!=null) 
			{
				var finishX:uint;
				var finishY:uint;
				if (window.parent is Stage) 
				{
					finishX = Laya.stage.width / 2 - window.width * 0.1;
					finishY = Laya.stage.height / 2 - window.height * 0.1;
				}
				else 
				{
					finishX = window.parent["width"] / 2 - window.width * 0.1;
					finishY = window.parent["height"] / 2 - window.height * 0.1;
				}
				
				Tween.to(window,{alpha:0,scaleX:0.2,scaleY:0.2,x:finishX,y:finishY}
					,300,null,
					new Handler(this,function():void{
						o.parent.removeChild(o.owner);
					}));
				if(o.modal)
				{
					/*Tween.to(o.modalMask,{alpha:0},300,null,
						new Handler(this,function():void{
							o.parent.removeChild(o.modalMask);
						})
					);*/
				}
				
				var index : int = popupInfo.indexOf(o);
				popupInfo.splice(index, 1);
			}
		}

		/**
		 * 创建模式窗体
		 * 
		 * @param	parent	容器
		 * @param	o		弹出数据
		 */
		private  function createModalWindow(parent : Sprite, o : PopUpData) : void
		{
			/*var rect : Rectangle;
			if (parent is Stage)
			{
				rect = new Rectangle(0, 0, Laya.stage.width, Laya.stage.height);
			}
			else
			{
				rect = parent.getRect(parent.stage);
			}
			var modalMask : Sprite = new Sprite();
			modalMask.graphics.beginFill(o.maskColor, o.maskAlpha);
			modalMask.graphics.drawRect(0, 0, rect.width, rect.height);
			modalMask.graphics.endFill();
			o.modalMask = modalMask;
			parent.addChild(modalMask);*/
		}

		/**
		 * 根据本身查找弹出数据
		 * 
		 * @param	owner
		 * @return
		 */
		public function findPopupInfoByOwner(owner : Object) : PopUpData
		{
			const n : int = popupInfo.length;
			for (var i : int = 0; i < n; i++)
			{
				var o : PopUpData = popupInfo[i];
				if (o.owner == owner)
					return o;
			}
			return null;
		}
		/**
		 * 根据窗体父级对像查找窗体
		 * 
		 * @param	owner
		 * @return
		 */
		public function findPopUpByOwner(owner : Object):View
		{
			const n : int = popupInfo.length;
			for (var i : int = 0; i < n; i++)
			{
				var o : PopUpData = popupInfo[i];
				if (o.parent == owner)
					return o.owner;
			}
			return null;
		}
	}
}