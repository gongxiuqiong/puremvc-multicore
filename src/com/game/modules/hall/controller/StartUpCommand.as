package com.game.modules.hall.controller
{
	import org.puremvc.as3.multicore.patterns.command.MacroCommand;
	/**
	 * ...
	 * @author cong
	 */
	public class StartUpCommand extends MacroCommand
	{
		override protected function initializeMacroCommand():void 
		{
			addSubCommand(ModelPrepCommand);	
			addSubCommand(ViewPrepCommand);		
		}
	}

}