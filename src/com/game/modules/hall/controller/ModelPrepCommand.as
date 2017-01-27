package com.game.modules.hall.controller
{ 
	import com.game.modules.hall.model.HallProxy;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	/**
	 * ...
	 * @author cong
	 */
	public class ModelPrepCommand extends SimpleCommand
	{
		
		public function ModelPrepCommand() 
		{
			super();
		}
		override public function execute(notification:INotification):void 
		{
			facade.registerProxy(new HallProxy());
		}
	}

}