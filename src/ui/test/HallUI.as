/**Created by the LayaEditor,do not modify.*/
package ui.test {
	import laya.ui.*;

	public class HallUI extends View {
		public var btn:Button;
		public var label:Label;
		public var btn1:Button;

		public static var uiView:Object ={"type":"View","child":[{"props":{"x":0,"y":0,"skin":"comp/bg.png","sizeGrid":"30,4,4,4","width":600,"height":400},"type":"Image"},{"props":{"x":450,"y":352,"skin":"comp/button.png","label":"添加","width":66,"height":38,"sizeGrid":"4,4,4,4","labelSize":24,"labelBold":true,"var":"btn"},"type":"Button"},{"props":{"x":447,"y":29,"text":"label","width":147,"height":315,"color":"#ffffff","bgColor":"#6e6a6a","fontSize":20,"bold":false,"var":"label"},"type":"Label"},{"props":{"x":524,"y":352,"skin":"comp/button.png","label":"移除","width":66,"height":38,"sizeGrid":"4,4,4,4","labelSize":24,"labelBold":true,"var":"btn1"},"type":"Button"}],"props":{"width":600,"height":400},"animations":[{"id":1,"name":"ani1","frameRate":24,"nodes":[],"action":0}]};
		public function HallUI(){}
		override protected function createChildren():void {

			super.createChildren();
			createView(uiView);
		}
	}
}