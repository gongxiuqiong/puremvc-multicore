package com.game.shell.view
{
	import com.MCore.LOG;
	import com.game.enum.PipeAwareModuleEnum;
	import com.game.shell.ApplicationFacade;
	import com.game.shell.model.PreLoadProxy;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeAware;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeMessage;
	import org.puremvc.as3.multicore.utilities.pipes.messages.Message;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.Junction;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.JunctionMediator;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.Pipe;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.TeeMerge;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.TeeSplit;
	
	public class ShellJunctionMediator extends JunctionMediator
	{
		public static const NAME:String = "ShellJunctionMediator";
		private var preLoadProxy:PreLoadProxy; 
		private var main:Main;
		public function ShellJunctionMediator(m:Main)
		{
			main = m;
			super( NAME, new Junction() );		
		}
		override public function onRegister():void 
		{
			preLoadProxy = facade.retrieveProxy(PreLoadProxy.NAME) as PreLoadProxy; 
		}
		/**
		 * ShellJunction related Notification list.
		 */
		override public function listNotificationInterests():Array
		{
			return [ApplicationFacade.MODULE_ADDED,
				ApplicationFacade.MODULE_REMOVED, 
			]; 			
		}
		/**
		 * Handle ShellJunction related Notifications
		 * 处理相关通知
		 * @param 	note	Notification sended by an actor
		 */
		override public function handleNotification( note:INotification ):void
		{
			switch( note.getName() )
			{							
				case ApplicationFacade.MODULE_ADDED: 
					connectModule( note.getBody() as IPipeAware );
					break;
				case ApplicationFacade.MODULE_REMOVED:
					disconnectModule(note.getBody());
					break;
				default:
					super.handleNotification(note);
			}
		}
		/**
		 * Handle incoming pipe messages for the ShellJunction.
		 * 处理传入的通道消息
		 * @param message 	Message typed as IPipeMessage
		 */
		override public function handlePipeMessage( message:IPipeMessage ):void
		{
			LOG.trace("<ShellJunctionMediator>  --> handlePipeMessage() 收到并处理传入的通道消息");
			var body:Object = Message(message).getBody();
			var moduleName:String;
			switch ( Message(message).getType())
			{
				case PipeAwareModuleEnum.MTS_ADD_WIN:
					trace("壳收到 模块通知----");
					break;
				/*case PipeAwareModuleConstants.MTS_USER_LOGIN_COMPLETE:
					sendNotification(ApplicationFacade.PRE_LOAD, {name:'MainInterface',data:body});
					sendNotification(ApplicationFacade.REMOVE_TOPIC);//移除TOPIC内的模块（登陆框）
					break;
				case PipeAwareModuleConstants.MTS_JOIN_ROOM:
					moduleName = "PlayPoker";
					var roomData:Object = body ;
					if (!preLoadProxy.moduleHasLoaded(moduleName))
					{
						sendNotification(ApplicationFacade.PRE_LOAD, {name:moduleName,data:roomData});
					}else
					{
						sendNotification(ApplicationFacade.ADD_ROOM_PANLE, {moduleName:moduleName,data:roomData});
					}
					break;*/
			}
		}
		
		
		private var outMap:Object = {};//这个就是保存管道信息的类
		
		/**
		 * Connect the module using pipes and its TeeMerge and TeeSplit
		 * 用TeeMerge和TeeSplit以及管道连接
		 * @param module	Module typed as IPipeAware
		 */
		public function connectModule( module:IPipeAware ):void
		{
			// Register SHELL_TO_MODULE_PIPE from the shell to all modules 
			junction.registerPipe( PipeAwareModuleEnum.SHELL_TO_MODULE_PIPE,  
				Junction.OUTPUT, 
				new TeeSplit() );
			//
			// Register MODULE_TO_SHELL_PIPE to the shell from all modules 
			junction.registerPipe( PipeAwareModuleEnum.MODULE_TO_SHELL_PIPE,  
				Junction.INPUT, 
				new TeeMerge() );
			//
			// add a pipe listener for messages sended by module						
			junction.addPipeListener( PipeAwareModuleEnum.MODULE_TO_SHELL_PIPE, 
				this, 
				handlePipeMessage );
			// module -> shell
			var moduleToShell: Pipe = new Pipe();
			module.acceptOutputPipe( PipeAwareModuleEnum.MODULE_TO_SHELL_PIPE, moduleToShell );
			
			var shellInFitting: TeeMerge = junction.retrievePipe( PipeAwareModuleEnum.MODULE_TO_SHELL_PIPE ) as TeeMerge;
			shellInFitting.connectInput( moduleToShell );
			
			// shell -> module
			var shellToModule: Pipe = new Pipe();
			module.acceptInputPipe( PipeAwareModuleEnum.SHELL_TO_MODULE_PIPE, shellToModule );
			
			var shellOutFitting: TeeSplit = junction.retrievePipe( PipeAwareModuleEnum.SHELL_TO_MODULE_PIPE ) as TeeSplit;
			shellOutFitting.connect( shellToModule );
			
			var moduleID:String = String(module)
			outMap[moduleID] = shellToModule;
		}				
		/**
		 * Disconnect the pipes from shell to module 
		 */
		public function disconnectModule(module:*):void
		{
			
			var moduleID:String = String(module); 
			var junctionOut:TeeSplit = junction.retrievePipe(PipeAwareModuleEnum.SHELL_TO_MODULE_PIPE) as TeeSplit;
			junctionOut.disconnectFitting(outMap[moduleID])//删除时你只需要删除主应用到module的就可以了
			delete outMap[moduleID];
		}
	}
}