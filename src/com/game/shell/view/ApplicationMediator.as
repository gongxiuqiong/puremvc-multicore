package com.game.shell.view
{
	import com.MCore.managers.LayerManager;
	import com.MCore.managers.PopUpManager;
	import com.game.enum.MainLayerTypeEnum;
	import com.game.modules.Hall;
	import com.game.publicDatas.PublicInfos;
	import com.game.shell.ApplicationFacade;
	import com.game.shell.view.components.PreLoader;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	public class ApplicationMediator extends Mediator
	{
		public static const NAME : String = 'ApplicationMediator';
		
		/**
		 *当前场景(交互主界面。。) 
		 */
		private var currScene:*;
		
		
		public function ApplicationMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
			
			
			var layerArr:Array = [
				MainLayerTypeEnum.SCENE_PANEL
				,MainLayerTypeEnum.SCENE_TIP_PANEL
				,MainLayerTypeEnum.GAME_PANEL
				,MainLayerTypeEnum.TOP_TIP_PANEL
				,MainLayerTypeEnum.LOADING_PANEL
			];
			LayerManager.init(Laya.stage,layerArr);
		}	
		override public function onRegister():void
		{
			facade.registerMediator(new PreLoaderMediator());
		}
		
		override public function listNotificationInterests() : Array
		{
			return [ApplicationFacade.ADD_PRE_LOADER
				,ApplicationFacade.REMOVE_PRE_LOADER
				,ApplicationFacade.ADD_MODULE_LOADER
				,ApplicationFacade.REMOVE_MODULE_LOADER
				,ApplicationFacade.ADD_SCENE
				]
		}
		
		override public function handleNotification(notification : INotification) : void
		{ 
			switch (notification.getName()) 
			{
				case ApplicationFacade.ADD_PRE_LOADER:
					addPreLoader();
					break;
				case ApplicationFacade.REMOVE_PRE_LOADER:
					removePreLoader();
					break;
				case ApplicationFacade.ADD_MODULE_LOADER:
					addModuleLoader();
					break;
				case ApplicationFacade.REMOVE_MODULE_LOADER:
					removeModuleLoader();
					break;
				case ApplicationFacade.ADD_SCENE:
					if (currScene!=null) 
					{
						removeScene();
//						removePopUpWindow();
					}
					addScene(notification.getBody() as Object);
					break;
			}
		}
		
		private function removeModuleLoader():void
		{
			// TODO Auto Generated method stub
			
		}
		
		private function addModuleLoader():void
		{
			// TODO Auto Generated method stub
			
		}
		
		/** 添加加载模块 */		
		private function addPreLoader():void
		{
			var preLoader:PreLoader = new PreLoader();
			var preLoaderMediator:PreLoaderMediator = facade.retrieveMediator(PreLoaderMediator.NAME) as PreLoaderMediator;
			preLoaderMediator.setViewComponent(preLoader);
			LayerManager.addToLayer(MainLayerTypeEnum.LOADING_PANEL,preLoader);
		}
		private function removePreLoader():void
		{
			LayerManager.clearFromLayer(MainLayerTypeEnum.LOADING_PANEL);
		}
		
		/**
		 *添加 Scene模块
		 * @param name 模块名称
		 * 
		 */
		private function addScene(obj:Object):void
		{
			trace("obj.moduleName",obj.moduleName);
			var name:String = obj.moduleName;
//			var data:* = obj.data;
			currScene = PublicInfos.createObjByName(name);
			PopUpManager.popUpType = PopUpManager.FADE_IN_OUT;
			PopUpManager.addPopUp(currScene, LayerManager.getLayer(MainLayerTypeEnum.SCENE_PANEL), false);
			currScene.startUp(); 
			sendNotification(ApplicationFacade.MODULE_ADDED, currScene); 
			Main.i.gameData.currScene = name;
//			if(data)
//			{
//				currScene.sendData(MainLayerTypeEnum.TM_USER_INFO,data);
//			}
		}
		private function removeScene():void
		{
			/*PopUpManager.removePopUp(currScene);
			currScene.dispose();
			sendNotification(ApplicationFacade.MODULE_REMOVED,currScene);
			PublicStatus.getInstance().currScene = '';*/
		}
		public function get main() : Main
		{
			return viewComponent as Main;
		}
	}
}