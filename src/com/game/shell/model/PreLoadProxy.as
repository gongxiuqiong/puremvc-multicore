package com.game.shell.model
{
	import com.MCore.LOG;
	import com.MCore.Version;
	import com.game.publicDatas.PublicInfos;
	import com.game.shell.ApplicationFacade;
	
	import laya.events.Event;
	import laya.net.Loader;
	import laya.utils.Handler;
	
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;

	public class PreLoadProxy extends Proxy
	{
		public static const NAME:String = "preLoadProxy";
		/** 语言包 */
		public static const RES_LANGUAGE_CONFIG:String = PublicInfos.RES + "data/language.txt?v="+Version.ASSET_VER;
		/** 模块配置*/
		public static const RES_MODULE_CONFIG:String = PublicInfos.RES + "data/module.xml?v="+Version.ASSET_VER;
		/** 基础控件图集*/
		public static const RES_COMP:String = PublicInfos.RES + "atlas/comp.json?v="+Version.ASSET_VER;
		
		/** 模块配置数据*/
		private var _moduleConfigXML : XML;
		
		/** 模块名称*/
		public var moduleName : String;
		/** 模块参数*/
		public var moduleParameter:*;
		
		/** 当前加载索引*/
		private var numLoaded:int = 0;
		/** 资源总数*/
		private var resAmount:int = 0;
		/** 存储已经加载过了的模块*/
		public var moduleLoaded : Array = new Array();
		
		public function PreLoadProxy()
		{
			super(NAME);
			startQueueLoad();
		}

		public function startQueueLoad():void
		{
			numLoaded = 0;
			resAmount = 3;
			// 按序列加载 
			// 不开启缓存
			// 关闭并发加载
			Laya.loader.maxLoader = 1;
			Laya.loader.load(PreLoadProxy.RES_COMP, Handler.create(this, onAssetLoaded), null, Loader.ATLAS, 0, true);
			Laya.loader.load(PreLoadProxy.RES_LANGUAGE_CONFIG, Handler.create(this, onAssetLoaded), null, Loader.TEXT, 1, false);
			Laya.loader.load(PreLoadProxy.RES_MODULE_CONFIG, Handler.create(this, onAssetLoaded), null, Loader.XML, 2, false);
			
			// 侦听加载失败
			Laya.loader.on(Event.ERROR, this, onError);
			
		}
		private function onAssetLoaded(e:* = null):void
		{
			numLoaded++
			if (numLoaded == 1) 
			{
				//基础控件图集 加载完毕
				sendNotification(ApplicationFacade.ADD_PRE_LOADER);
			}else if (numLoaded == 2) 
			{
				var str:String = e;
				PublicInfos.loadLanguage(str);
			}else if (numLoaded == 3) 
			{
				_moduleConfigXML = e;
				// 恢复默认并发加载个数。
				Laya.loader.maxLoader = 5;
				onQueueComplete();
			}
		}

		/** 全部加载完成*/
		private function onQueueComplete(e:* = null):void
		{
			LOG.trace("<PreLoadProxy> onQueueComplete()--------- onQueueComplete" );
			sendNotification(ApplicationFacade.PRE_LOAD, {name:'PreLoad'});
		}

		private function onError(err:String):void
		{
			LOG.error("<PreLoadProxy> onError() 加载失败: " + err);
		}
		
		public function setPreLoadData(_moduleName:String, _moduleParameter:* = null):void
		{
			this.moduleName = _moduleName;
			this.moduleParameter = _moduleParameter;
			
			var childeXml:XmlDom = _moduleConfigXML.firstChild; 
			var arr:Array = childeXml.getElementsByTagName(_moduleName);
			if (arr.length > 0) 
			{
				var moduleChild:Array = arr[0].childNodes;
				
				setData(moduleChild);
			}else
			{
				LOG.error("<PreLoadProxy> setPreLoadData 配置里无此模块");
				setData(null);
			}
		}
		/** 添加已经加载了的模块*/
		public function addModuleLoaded(_moduleName : String) : void
		{
			moduleLoaded.push(_moduleName);
		}
		public function moduleHasLoaded(_moduleName : String) : Boolean
		{
			for (var i : int = 0; i < moduleLoaded.length; i++)
			{
				if (moduleLoaded[i] == _moduleName)
				{
					return true;
				}
			}
			return false;
		}
	}
}
