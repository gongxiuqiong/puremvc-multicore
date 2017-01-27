/**Created by the LayaEditor,do not modify.*/
package ui.test {
	import laya.ui.*;

	public class view1UI extends View {
		public var btn2:Button;
		public var txt:Label;
		public var closeBtn:Button;
		public var btn1:Button;

		public static var uiView:Object ={"type":"View","child":[{"props":{"x":-1,"y":-3,"skin":"comp/bg.png","sizeGrid":"30,4,4,4","width":300,"height":200},"type":"Image"},{"props":{"x":135,"y":146,"skin":"comp/button.png","label":"点我赋值1","width":150,"height":37,"sizeGrid":"4,4,4,4","var":"btn2"},"type":"Button"},{"props":{"x":6,"y":28,"text":"label","width":285,"height":87,"var":"txt"},"type":"Label"},{"props":{"x":128,"y":3,"text":"view1"},"type":"Label"},{"props":{"x":266,"y":0,"skin":"comp/btn_close.png","name":"close","visible":true,"var":"closeBtn"},"type":"Button"},{"props":{"x":15,"y":147,"skin":"comp/button.png","label":"通知shell","width":108,"height":36,"sizeGrid":"4,4,4,4","var":"btn1"},"type":"Button"}],"props":{"width":300,"height":200},"animations":[{"id":1,"name":"ani1","frameRate":24,"nodes":[],"action":0}]};
		public function view1UI(){}
		override protected function createChildren():void {

			super.createChildren();
			createView(uiView);
		}
	}
}