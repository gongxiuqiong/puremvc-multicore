package com.MCore.managers
{
	import com.MCore.utils.ToolsUtil;
	
	import laya.display.Sprite;
	import laya.display.Stage;
	import laya.utils.Dictionary;

	/**
	 * LayerManager
	 */
	public class LayerManager
	{
		private static var _layerMap:Dictionary = new Dictionary()
		
		/**
		 * 窗口列表
		 */		
		
		
		/**
		 * 初始化, 传入stage对象和类型数据
		 * 会根据数据排序生成列表
		 * 类型数据都为字符串,如:
		 * [LayerType.LOGIN,		// 放在最下
		 *  LayerType.GAME,
		 * 	LayerType.ROOM]			// 放在最上
		 * @param	stage
		 */
		public static function init(stage:Stage , typeArr:Array):void
		{
			var container:Sprite = new Sprite();
			for (var i:int = 0; i < typeArr.length; i++)
			{
				var type:String = typeArr[i];
				if (_layerMap[type])
					throw new Error("This type has layer!");
				var sp:Sprite = new Sprite;
				sp.name = type;
				_layerMap[type] = sp;
				container.addChild(_layerMap[type]);
			}
			stage.addChild(container);
		}
		
		/**
		 * 获取层
		 * @param	type
		 * @return
		 */
		public static function getLayer(type:String):Sprite
		{
			if (_layerMap[type] == null)
				throw new Error("This type hasn't layer!");
			return _layerMap[type];
		}
		
		/**
		 * 添加到层
		 * @param	type
		 * @param	displayObj
		 */
		public static function addToLayer(type:String , displayObj:Sprite):void
		{
			getLayer(type).addChild(displayObj);
		}
		
		/**
		 * 移除其中一项 
		 * @param type
		 * @param displayObj
		 * 
		 */
		public static function removeFromLayer(type:String, displayObj:Sprite):void {
			var tdc:Sprite = getLayer(type);
			if(displayObj.parent==tdc){
				tdc.removeChild(displayObj);
			}else
			{
				throw new Error("displayObj.parent != layer[type]");
			}
		}
		/**
		 * 清空某图层内的所有内容 
		 * @param type
		 * 
		 */
		public static function clearFromLayer(type:String):void {
			var tdc:Sprite = getLayer(type);
			if (_layerMap[type] == null)
			{
				throw new Error("This type hasn't layer!");
			}else
			{
				ToolsUtil.delDisplayContainer(tdc);
			}
		}
		
	}
}