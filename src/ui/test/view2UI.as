/**Created by the LayaEditor,do not modify.*/
package ui.test {
	import laya.ui.*;

	public class view2UI extends View {
		public var btn:Button;
		public var txt:Label;
		public var closeBtn:Button;

		public static var uiView:Object ={"type":"View","child":[{"props":{"x":1,"y":0,"skin":"comp/bg.png","sizeGrid":"30,4,4,4","width":300,"height":200},"type":"Image"},{"props":{"x":78,"y":149,"skin":"comp/button.png","label":"点我赋值2","width":150,"height":37,"sizeGrid":"4,4,4,4","var":"btn"},"type":"Button"},{"props":{"x":8,"y":29,"text":"label","width":282,"height":110,"var":"txt"},"type":"Label"},{"props":{"x":129,"y":7,"text":"view2"},"type":"Label"},{"props":{"x":266,"y":3,"skin":"comp/btn_close.png","name":"close","visible":true,"var":"closeBtn"},"type":"Button"}],"props":{"width":300,"height":200},"animations":[{"id":1,"name":"ani1","frameRate":24,"nodes":[],"action":0}]};
		public function view2UI(){}
		override protected function createChildren():void {

			super.createChildren();
			createView(uiView);
		}
	}
}