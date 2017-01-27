/*
  Modularity - A PureMVC AS3 MultiCore Flex Demo
  Copyright(c) 2008 Cliff Hall <clifford.hall@puremvc.org>
  Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package com.game.shell
{

	import com.game.shell.controller.PreLoadCommand;
	import com.game.shell.controller.StartupCommand;
	
	import org.puremvc.as3.multicore.interfaces.IFacade;
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	
	public class ApplicationFacade extends Facade implements IFacade
	{
		
		// Notification constants 
		public static const STARTUP:String = 'startup';
		public static const ADD_COMP:String = 'addComp';
		public static const REMOVE_COMP:String = 'removeComp';
		
		public static const PRE_LOAD:String = 'pre_load';
		/**
		 * 添加模块预加载界面 
		 */
		public static const ADD_PRE_LOADER:String = 'add_pre_loader';
		public static const REMOVE_PRE_LOADER:String = 'remove_pre_loader';
		/**
		 * 添加模块加载界面 
		 */
		public static const ADD_MODULE_LOADER:String = 'add_module_loader';
		public static const REMOVE_MODULE_LOADER:String = 'remove_module_loader';
		/**
		 * 模块管理信息 模块添加 
		 */
		public static const MODULE_ADDED:String = 'module_added';
		public static const MODULE_REMOVED:String = 'module_removed';
		
		/**
		 *添加场景模块 
		 */
		public static const ADD_SCENE:String = 'add_scene'; 
		
		public function ApplicationFacade( key:String )
		{
			super(key);	
		}
		
        /**
         * Singleton ApplicationFacade Factory Method
         */
        public static function getInstance( key:String ) : ApplicationFacade 
        {
            if ( instanceMap[ key ] == null ) instanceMap[ key ] = new ApplicationFacade( key );
            return instanceMap[ key ] as ApplicationFacade;
        }
        
	    /**
         * Register Commands with the Controller 
         */
        override protected function initializeController( ) : void 
        {
            super.initializeController();            
            registerCommand( STARTUP, StartupCommand );
            registerCommand( PRE_LOAD, PreLoadCommand );
        }
        
        /**
         * Application startup
         * 
         * @param app a reference to the application component 
         */  
        public function startup( app:Main ):void
        {
        	sendNotification( STARTUP, app );
        }

			
	}
}