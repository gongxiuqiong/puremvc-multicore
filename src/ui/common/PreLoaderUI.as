/**Created by the LayaEditor,do not modify.*/
package ui.common {
	import laya.ui.*;

	public class PreLoaderUI extends View {
		public var progress_mc:ProgressBar;
		public var tip_txt:Label;

		public static var uiView:Object ={"type":"View","child":[{"props":{"x":0,"y":0,"skin":"comp/blank.png","width":600,"height":400,"sizeGrid":"3,3,3,3"},"type":"Image"},{"props":{"x":57,"y":363,"skin":"comp/progress.png","width":489,"height":14,"value":0,"sizeGrid":"1,3,1,3","var":"progress_mc"},"type":"ProgressBar"},{"props":{"x":141,"y":341,"text":"加载中...","width":326,"height":22,"fontSize":20,"align":"center","font":"宋体","bold":true,"var":"tip_txt","color":"#c6f3ff"},"type":"Label"}],"props":{"width":600,"height":400},"animations":[{"id":1,"name":"ani1","frameRate":24,"nodes":[],"action":0}]};
		public function PreLoaderUI(){}
		override protected function createChildren():void {

			super.createChildren();
			createView(uiView);
		}
	}
}