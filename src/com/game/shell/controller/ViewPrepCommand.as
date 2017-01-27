package com.game.shell.controller
{
	import com.game.shell.view.ApplicationMediator;
	import com.game.shell.view.ShellJunctionMediator;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class ViewPrepCommand extends SimpleCommand
	{
		public function ViewPrepCommand()
		{
			super();
		}
		override public function execute(notification : INotification) : void
		{
			var main:Main = notification.getBody() as Main;
			facade.registerMediator(new ApplicationMediator(main));
			facade.registerMediator(new ShellJunctionMediator(main));
		}
	}
}