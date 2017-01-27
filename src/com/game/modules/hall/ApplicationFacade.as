package com.game.modules.hall
{
	import com.game.modules.Hall;
	import com.game.modules.hall.controller.DisposeCommand;
	import com.game.modules.hall.controller.StartUpCommand;
	
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	
	public class ApplicationFacade extends Facade
	{
		public static const STARTUP : String = 'startup';
		public static const DISPOSE:String = "dispose"; 
		
		public function ApplicationFacade(key:String)
		{
			super(key);
		}
		public static function getInstance(key : String) : ApplicationFacade
		{
			if (!( instanceMap[ key ] is  ApplicationFacade)) 
			{
				delete instanceMap[ key ];
				instanceMap[ key ]  = new ApplicationFacade( key );
			}
			return instanceMap[ key ];
		}
		public function startUp(view : Hall) : void
		{
			sendNotification(STARTUP, view);
		}
		
		override protected function initializeController() : void
		{
			super.initializeController();
			registerCommand(STARTUP, StartUpCommand);
			registerCommand(DISPOSE, DisposeCommand);
		}
	}
}