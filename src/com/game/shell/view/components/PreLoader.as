package com.game.shell.view.components
{
	import com.MCore.LOG;
	
	import ui.common.PreLoaderUI;
	
	
	public class PreLoader extends PreLoaderUI
	{
		private var _percent:int;
		private var _tip:String;
		public function PreLoader()
		{
			super();
		}
		public function getPercent():int
		{
			return _percent;
		}
		public function setPercent(value:Number):void
		{
			LOG.trace("<PreLoader>]设置加载进度 "+value);
			this.progress_mc.value = value;
		}
		public function get tip():String { return _tip; }
		
		public function set tip(value:String):void 
		{
			LOG.trace("<PreLoader>设置加载说明 "+value);
			_tip = value;
			if(this.tip_txt)this.tip_txt.text = _tip;
		}
		
	}
}