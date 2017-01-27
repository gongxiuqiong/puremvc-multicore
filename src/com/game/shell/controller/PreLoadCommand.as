package com.game.shell.controller
{
	import com.MCore.LOG;
	import com.game.shell.model.PreLoadProxy;
	
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class PreLoadCommand extends SimpleCommand implements ICommand
	{
		public function PreLoadCommand()
		{
			super();
		}
		override public function execute(notification:INotification):void 
		{
			var preloadProxy:PreLoadProxy = facade.retrieveProxy(PreLoadProxy.NAME) as PreLoadProxy;
			var modulName:String = (notification.getBody() as Object).name;
			var modulData:* = (notification.getBody() as Object).data;
			LOG.trace("<PreLoadCommand> execute() modulName==", modulName);
			preloadProxy.setPreLoadData(modulName,modulData);
		}
	}
}