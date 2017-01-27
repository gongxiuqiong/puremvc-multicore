package com.game.modules.hall.view
{
	import com.game.enum.PipeAwareModuleEnum;
	import com.game.modules.Hall;
	import com.smartfoxserver.v2.util.SFSErrorCodes;
	
	import laya.events.Event;
	
	import net.lxqClient;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	public class ApplicationMediator extends Mediator
	{
		public static const NAME : String = 'ApplicationMediator'; 
		
		public function ApplicationMediator(viewComponent : Object)
		{
			super(NAME, viewComponent);
		}
		override public function onRegister() : void
		{
			this.addListen();
		}
		override public function listNotificationInterests():Array
		{
			return [
				
			];
		}
		
		override public function handleNotification(notification : INotification) : void
		{
			switch(notification.getName())
			{ 
				
				default:
			}
		}
		
		
		private function addListen() : void
		{ 
			app.btn.on("click",this,onClick);
		}
		
		private function onClick(e:Event):void
		{
			trace("-----******------");
			sendNotification(PipeAwareModuleEnum.MTS_ADD_WIN)
			
			lxqClient.instance.connect();
			lxqClient.instance.addEvenHandler(lxqClient.CONNECTION,this,onConnection);
			lxqClient.instance.addEvenHandler(lxqClient.CONNECTION_LOST,this,onConnectionLost);
			lxqClient.instance.addEvenHandler(lxqClient.LOGIN,this,onLogin);
			lxqClient.instance.addEvenHandler(lxqClient.LOGIN_ERROR,this,onLoginError);
			lxqClient.instance.addEvenHandler("b123",this,onGetDate);

		}
		private function onGetDate(e:*):void
		{
			trace("终于他妈获得数据了");
		}
		
		private function onLoginError(e:*):void
		{
			trace("onLoginError:"+e.errorMessage);
			trace("errorCode:"+e.errorCode);
			
			trace(lxqClient.SFSError.getErrorMessage(e.errorCode));
		}
		
		private function onLogin(e:*):void
		{
			trace("onLogin:"+e);
			var param:Object = new Object();
			param["aaa"] = 123
			lxqClient.instance.send("a123",param);
		}
		
		private function onConnectionLost(e:*):void
		{
			trace("onConnectionLost:"+e);
		}
		
		private function onConnection(e:*):void
		{
			trace("onConnection:"+e);
			
			lxqClient.instance.login("111222","111222");
		}
		private function doLogin($username:String,$password:String):void
		{
			if(!lxqClient.instance.isConnect())
			{
				lxqClient.instance.connect();
			}
			else
			{
				lxqClient.instance.login($username,$password);
			}
		}
		
		public function get app() : Hall
		{
			return this.viewComponent as Hall;
		}
	}
}