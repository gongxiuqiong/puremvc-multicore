package com.game.shell.controller
{
	import com.game.shell.model.PreLoadProxy;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class ModelPrepCommand extends SimpleCommand
	{
		public function ModelPrepCommand()
		{
			super();
		}
		override public function execute(notification:INotification):void 
		{
			facade.registerProxy(new PreLoadProxy()); 
		}
	}
}