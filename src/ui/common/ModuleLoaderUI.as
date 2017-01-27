/**Created by the LayaEditor,do not modify.*/
package ui.common {
	import laya.ui.*;

	public class ModuleLoaderUI extends View {
		public var progress_mc:ProgressBar;
		public var tip_txt:Label;

		public static var uiView:Object ={"type":"View","child":[{"props":{"x":116,"y":149,"skin":"comp/blank.png","width":353,"height":79,"sizeGrid":"3,3,3,3"},"type":"Image"},{"props":{"x":193,"y":169,"skin":"comp/progress.png","width":198,"height":14,"value":0,"sizeGrid":"1,1,1,1","var":"progress_mc"},"type":"ProgressBar"},{"props":{"x":130,"y":192,"text":"加载中...","width":326,"height":22,"fontSize":20,"align":"center","font":"宋体","bold":true,"color":"#ffffff","var":"tip_txt"},"type":"Label"}],"props":{"width":600,"height":400},"animations":[{"id":1,"name":"ani1","frameRate":24,"nodes":[],"action":0}]};
		public function ModuleLoaderUI(){}
		override protected function createChildren():void {

			super.createChildren();
			createView(uiView);
		}
	}
}