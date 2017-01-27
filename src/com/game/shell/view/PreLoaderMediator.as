package com.game.shell.view
{
	import com.MCore.LOG;
	import com.MCore.Version;
	import com.game.modules.Hall;
	import com.game.publicDatas.PublicInfos;
	import com.game.shell.ApplicationFacade;
	import com.game.shell.model.PreLoadProxy;
	import com.game.shell.model.vo.MaterialVO;
	
	import laya.events.Event;
	import laya.utils.Handler;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	public class PreLoaderMediator extends Mediator
	{
		public static const NAME:String = 'PreLoaderMediator'; 
		private var preLoadProxy:PreLoadProxy;
		
		public function PreLoaderMediator()
		{
			super(NAME);
		}
		override public function onRegister():void
		{
			preLoadProxy = facade.retrieveProxy(PreLoadProxy.NAME) as PreLoadProxy;
		}
		public function get preLoader():*
		{
			return viewComponent;
		}
		
		override public function listNotificationInterests():Array 
		{
			return [ApplicationFacade.PRE_LOAD, 
			];
		}
		
		override public function handleNotification(notification:INotification):void 
		{
			switch (notification.getName()) 
			{
				case ApplicationFacade.PRE_LOAD:
					startQueueLoad();
					break;
			}
		}
		
		private function startQueueLoad():void
		{
			if (preLoadProxy.getData() == null) 
			{
				LOG.trace("<PreLoaderMediator> --> startQueueLoad() 错误return");
				return;
			}
			LOG.trace("<PreLoaderMediator> --> startQueueLoad() ",preLoader);
			var modleList:Array = preLoadProxy.getData() as Array;
			if (modleList.length == 0 ) 
			{
				onQueueComplete(null); 
				return;
			}
			Laya.loader.maxLoader = 1;
			addLoader(modleList);
			if (preLoadProxy.moduleName != 'PreLoad')
			{
				sendNotification(ApplicationFacade.ADD_MODULE_LOADER);
			}
		}
		
		private function addLoader(modleList:Array):void
		{
			for (var i:int = 0; i < modleList.length; i++) 
			{
				var node:Object = modleList[i];
				var materialVo:MaterialVO = new MaterialVO();
				materialVo.name = node.getAttribute("name");
				materialVo.url = node.getAttribute("url");
				materialVo.type = node.getAttribute("type");
				materialVo.tip = node.getAttribute("tip");
				Laya.loader.load(PublicInfos.RES + materialVo.url + "?v=" + Version.ASSET_VER, 
					Handler.create(this, onAssetLoaded,[materialVo,i,modleList.length]), 
					Handler.create(this, onProgress,[materialVo,i,modleList.length]), materialVo.type, 
					i<=5?i:5, 
					true);
				if (i==0) 
				{
					onLoadStart(materialVo,modleList.length);
				}
			}
			// 侦听加载失败
			Laya.loader.on(Event.ERROR, this, onError);
		}
		private function onError(err:String):void
		{
			LOG.error("<PreLoaderMediator> onError() 加载失败: " + err);
		}
		
		private function onProgress(materialVo:MaterialVO, i:int, len:int, percent:Number):void
		{
			preLoader.tip =  PublicInfos.parseLanguage('正在加载') + '[' + materialVo.tip + ']   ' + Math.floor(percent*100) + '% (' + (i+1) + '/' + len + ')';
			preLoader.setPercent(percent);
		}
		private function onAssetLoaded(materialVo:MaterialVO, i:int, len:int):void
		{
			if (i+1 == len)
			{
				onQueueComplete(null);
			}
		}
		private function onLoadStart(materialVo:MaterialVO,len:int):void 
		{
			preLoader.tip =  PublicInfos.parseLanguage('正在加载') + '[' + materialVo.tip + ']   0% (1/' + len + ')';
			preLoader.setPercent(0);
		}
		
		private function onQueueComplete(param0:Object):void
		{
			Laya.loader.maxLoader = 5;
			preLoadProxy.addModuleLoaded(preLoadProxy.moduleName);
			
			if (preLoadProxy.moduleName != 'PreLoad') 
			{
				sendNotification(ApplicationFacade.REMOVE_MODULE_LOADER);
			}
			switch (preLoadProxy.moduleName) 
			{
				case 'PreLoad':
					//预加载完毕.->连接服务端->加载登陆/大厅模块
					
					//test begin
					sendNotification(ApplicationFacade.REMOVE_PRE_LOADER);  
					sendNotification(ApplicationFacade.PRE_LOAD, {name:'Hall'});
					break;
				case 'Hall':
					Hall;
					sendNotification(ApplicationFacade.ADD_SCENE, {moduleName:preLoadProxy.moduleName});
					break;
			}
		}
		
	}
}