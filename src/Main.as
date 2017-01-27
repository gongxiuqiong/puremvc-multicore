package {
	import com.game.publicDatas.GameData;
	import com.game.shell.ApplicationFacade;
	
	public class Main {
		
		private static var _i:Main;
		
		/**游戏公共数据*/
		public var gameData:GameData;
		
		public static function get i():Main
		{
			return _i;
		}
		
		public function Main() {
			_i = this;
			//初始化引擎
			Laya.init(600, 400);
			Laya.stage.bgColor = "#FFFFFF"
			initialize();
			onLoaded()
		}
		
		private function initialize():void
		{
			this.gameData = new GameData();
		}
		
		public static const NAME:String = 'Main';
		protected var facade:ApplicationFacade = ApplicationFacade.getInstance( NAME );		
		
		private function onLoaded():void {
			//实例UI界面
			/*var testView:TestView = new TestView();
			Laya.stage.addChild(testView);*/
			facade.startup(this);
			/*var testView:ModuleLoader = new ModuleLoader();
			Laya.stage.addChild(testView)*/
		}
	}
}