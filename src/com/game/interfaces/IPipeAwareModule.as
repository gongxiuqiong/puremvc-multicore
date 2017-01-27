package com.game.interfaces
{
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeAware;
	
	/**
	 * ...
	 * @author m
	 */
	public interface IPipeAwareModule extends IPipeAware 
	{
		function dispose():void;
		function startUp():void;		
		function sendData(notificationName:String, body:Object=null, type:String=null):void;		
	}
	
}
