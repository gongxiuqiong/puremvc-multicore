package com.game.modules.hall.controller
{
	import com.game.modules.Hall;
	import com.game.modules.hall.view.ApplicationMediator;
	import com.game.modules.hall.view.HallJunctionMediator;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	/**
	 * ...
	 * @author cong
	 */
	public class ViewPrepCommand extends SimpleCommand
	{
		public function ViewPrepCommand()
		{
			super();
		}

		override public function execute(notification : INotification) : void
		{
			var hall : Hall = notification.getBody() as Hall;
			facade.registerMediator(new ApplicationMediator(hall));
			facade.registerMediator(new HallJunctionMediator());
		}
	}
}