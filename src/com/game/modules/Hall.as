package com.game.modules
{
	import com.MCore.LOG;
	import com.game.interfaces.IPipeAwareModule;
	import com.game.modules.hall.ApplicationFacade;
	
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeFitting;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.JunctionMediator;
	
	import ui.test.HallUI;

	public class Hall extends HallUI implements IPipeAwareModule
	{
		private var facade:ApplicationFacade;
		public function Hall()
		{
			this.name = "Hall";
		}
		public function startUp():void
		{
			LOG.trace(this.name + " startup");
			facade = ApplicationFacade.getInstance(this.name);
			facade.startUp(this);
		}
		public function dispose():void
		{
			facade.sendNotification(ApplicationFacade.DISPOSE);
		}
		public function sendData(notificationName:String, body:Object=null, type:String=null):void
		{
			facade.sendNotification(notificationName,body,type);
		}
		public function acceptInputPipe(name:String, pipe:IPipeFitting):void
		{
			facade.sendNotification(JunctionMediator.ACCEPT_INPUT_PIPE, pipe, name);
		}
		
		public function acceptOutputPipe(name:String, pipe:IPipeFitting):void
		{
			facade.sendNotification(JunctionMediator.ACCEPT_OUTPUT_PIPE, pipe, name);
		}
	}
}