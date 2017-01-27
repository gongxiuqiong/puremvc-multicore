package com.game.modules.hall.view
{
	import com.game.enum.PipeAwareModuleEnum;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeMessage;
	import org.puremvc.as3.multicore.utilities.pipes.messages.Message;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.Junction;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.JunctionMediator;
	
	public class HallJunctionMediator extends JunctionMediator
	{
		public static const NAME:String = 'HallJunctionMediator';
		public function HallJunctionMediator()
		{
			super( NAME, new Junction() );
		}
		
		/**
		 * Called when the Mediator is registered.
		 */
		override public function onRegister():void
		{
			
		}
		/**
		 * Remove event listeners
		 */
		override public function onRemove():void
		{
			//
			// remove both pipes (shell -> module && module -> shell )			
			junction.removePipe( PipeAwareModuleEnum.MODULE_TO_SHELL_PIPE );
			junction.removePipe( PipeAwareModuleEnum.SHELL_TO_MODULE_PIPE );		
		}		
		/**
		 * ShellJunction related Notification list.
		 * <P>
		 * Adds subclass interests to JunctionMediator interests.</P>
		 */
		override public function listNotificationInterests():Array
		{  
			var interests:Array = super.listNotificationInterests();
			interests.push(PipeAwareModuleEnum.MTS_ADD_WIN); 
			return interests; 
		}
		
		/**
		 * Handle SimpleModule related Notifications.
		 */
		override public function handleNotification( note:INotification ):void
		{ 
			switch( note.getName() )
			{							
				case PipeAwareModuleEnum.MTS_ADD_WIN: 
					junction.sendMessage(PipeAwareModuleEnum.MODULE_TO_SHELL_PIPE,
						new Message( PipeAwareModuleEnum.MTS_ADD_WIN, null, note.getBody() ));
					break; 
				// Let super handle the rest (ACCEPT_OUTPUT_PIPE, ACCEPT_INPUT_PIPE, SEND_TO_LOG)							
				default:
					super.handleNotification(note);
			}	
		}
		
		/**
		 * Handle incoming pipe messages from the Shell.
		 */
		override public function handlePipeMessage( message:IPipeMessage ):void
		{
			switch ( Message(message).getType() )
			{
				//case PipeAwareModuleEnum.SHELL_TO_MODULE_MESSAGE:
				//sendNotification( ApplicationFacade.MESSAGE_FROM_SHELL_RECEIVED, 
				//Message(message).getBody() );
				//break;
			}
		}
	}
}