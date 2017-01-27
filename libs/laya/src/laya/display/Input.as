package laya.display
{
	import laya.events.Event;
	import laya.maths.Matrix;
	import laya.maths.Rectangle;
	import laya.renders.Render;
	import laya.renders.RenderContext;
	import laya.utils.Browser;
	import laya.utils.Utils;
	
	/**
	 * 用户输入一个或多个文本字符时后调度。
	 * @eventType Event.INPUT
	 * */
	[Event(name = "input", type = "laya.events.Event")]
	/**
	 * 用户在输入框内敲回车键后，将会调度 <code>enter</code> 事件。
	 * @eventType Event.ENTER
	 * */
	[Event(name = "enter", type = "laya.events.Event")]
	/**
	 * 显示对象获得焦点后调度。
	 * @eventType Event.FOCUS
	 * */
	[Event(name = "focus", type = "laya.events.Event")]
	/**
	 * 显示对象失去焦点后调度。
	 * @eventType Event.BLUR
	 * */
	[Event(name = "blur", type = "laya.events.Event")]
	
	/**
	 * <p><code>Input</code> 类用于创建显示对象以显示和输入文本。</p>
	 *
	 * @example 以下示例代码，创建了一个 <code>Text</code> 实例。
	 * <listing version="3.0">
	 * package
	 * {
	 * 	import laya.display.Input;
	 * 	import laya.events.Event;
	 * 	public class Input_Example
	 * 	{
	 * 		private var input:Input;
	 * 		public function Input_Example()
	 * 		{
	 * 			Laya.init(640, 800);//设置游戏画布宽高、渲染模式。
	 * 			Laya.stage.bgColor = "#efefef";//设置画布的背景颜色。
	 * 			onInit();
	 * 		}
	 * 		private function onInit():void
	 * 		{
	 * 			input = new Input();//创建一个 Input 类的实例对象 input 。
	 * 			input.text = "这个是一个 Input 文本示例。";
	 * 			input.color = "#008fff";//设置 input 的文本颜色。
	 * 			input.font = "Arial";//设置 input 的文本字体。
	 * 			input.bold = true;//设置 input 的文本显示为粗体。
	 * 			input.fontSize = 30;//设置 input 的字体大小。
	 * 			input.wordWrap = true;//设置 input 的文本自动换行。
	 * 			input.x = 100;//设置 input 对象的属性 x 的值，用于控制 input 对象的显示位置。
	 * 			input.y = 100;//设置 input 对象的属性 y 的值，用于控制 input 对象的显示位置。
	 * 			input.width = 300;//设置 input 的宽度。
	 * 			input.height = 200;//设置 input 的高度。
	 * 			input.italic = true;//设置 input 的文本显示为斜体。
	 * 			input.borderColor = "#fff000";//设置 input 的文本边框颜色。
	 * 			Laya.stage.addChild(input);//将 input 添加到显示列表。
	 * 			input.on(Event.FOCUS, this, onFocus);//给 input 对象添加获得焦点事件侦听。
	 * 			input.on(Event.BLUR, this, onBlur);//给 input 对象添加失去焦点事件侦听。
	 * 			input.on(Event.INPUT, this, onInput);//给 input 对象添加输入字符事件侦听。
	 * 			input.on(Event.ENTER, this, onEnter);//给 input 对象添加敲回车键事件侦听。
	 * 		}
	 * 		private function onFocus():void
	 * 		{
	 * 			trace("输入框 input 获得焦点。");
	 * 		}
	 * 		private function onBlur():void
	 * 		{
	 * 			trace("输入框 input 失去焦点。");
	 * 		}
	 * 		private function onInput():void
	 * 		{
	 * 			trace("用户在输入框 input 输入字符。文本内容：", input.text);
	 * 		}
	 * 		private function onEnter():void
	 * 		{
	 * 			trace("用户在输入框 input 内敲回车键。");
	 * 		}
	 * 	}
	 * }
	 * </listing>
	 * <listing version="3.0">
	 * var input;
	 * Input_Example();
	 * function Input_Example()
	 * {
	 *     Laya.init(640, 800);//设置游戏画布宽高、渲染模式。
	 *     Laya.stage.bgColor = "#efefef";//设置画布的背景颜色。
	 *     onInit();
	 * }
	 * function onInit()
	 * {
	 *     input = new laya.display.Input();//创建一个 Input 类的实例对象 input 。
	 *     input.text = "这个是一个 Input 文本示例。";
	 *     input.color = "#008fff";//设置 input 的文本颜色。
	 *     input.font = "Arial";//设置 input 的文本字体。
	 *     input.bold = true;//设置 input 的文本显示为粗体。
	 *     input.fontSize = 30;//设置 input 的字体大小。
	 *     input.wordWrap = true;//设置 input 的文本自动换行。
	 *     input.x = 100;//设置 input 对象的属性 x 的值，用于控制 input 对象的显示位置。
	 *     input.y = 100;//设置 input 对象的属性 y 的值，用于控制 input 对象的显示位置。
	 *     input.width = 300;//设置 input 的宽度。
	 *     input.height = 200;//设置 input 的高度。
	 *     input.italic = true;//设置 input 的文本显示为斜体。
	 *     input.borderColor = "#fff000";//设置 input 的文本边框颜色。
	 *     Laya.stage.addChild(input);//将 input 添加到显示列表。
	 *     input.on(laya.events.Event.FOCUS, this, onFocus);//给 input 对象添加获得焦点事件侦听。
	 *     input.on(laya.events.Event.BLUR, this, onBlur);//给 input 对象添加失去焦点事件侦听。
	 *     input.on(laya.events.Event.INPUT, this, onInput);//给 input 对象添加输入字符事件侦听。
	 *     input.on(laya.events.Event.ENTER, this, onEnter);//给 input 对象添加敲回车键事件侦听。
	 * }
	 * function onFocus()
	 * {
	 *     console.log("输入框 input 获得焦点。");
	 * }
	 * function onBlur()
	 * {
	 *     console.log("输入框 input 失去焦点。");
	 * }
	 * function onInput()
	 * {
	 *     console.log("用户在输入框 input 输入字符。文本内容：", input.text);
	 * }
	 * function onEnter()
	 * {
	 *     console.log("用户在输入框 input 内敲回车键。");
	 * }
	 * </listing>
	 * <listing version="3.0">
	 * import Input = laya.display.Input;
	 * class Input_Example {
	 *     private input: Input;
	 *     constructor() {
	 *         Laya.init(640, 800);//设置游戏画布宽高、渲染模式。
	 *         Laya.stage.bgColor = "#efefef";//设置画布的背景颜色。
	 *         this.onInit();
	 *     }
	 *     private onInit(): void {
	 *         this.input = new Input();//创建一个 Input 类的实例对象 input 。
	 *         this.input.text = "这个是一个 Input 文本示例。";
	 *         this.input.color = "#008fff";//设置 input 的文本颜色。
	 *         this.input.font = "Arial";//设置 input 的文本字体。
	 *         this.input.bold = true;//设置 input 的文本显示为粗体。
	 *         this.input.fontSize = 30;//设置 input 的字体大小。
	 *         this.input.wordWrap = true;//设置 input 的文本自动换行。
	 *         this.input.x = 100;//设置 input 对象的属性 x 的值，用于控制 input 对象的显示位置。
	 *         this.input.y = 100;//设置 input 对象的属性 y 的值，用于控制 input 对象的显示位置。
	 *         this.input.width = 300;//设置 input 的宽度。
	 *         this.input.height = 200;//设置 input 的高度。
	 *         this.input.italic = true;//设置 input 的文本显示为斜体。
	 *         this.input.borderColor = "#fff000";//设置 input 的文本边框颜色。
	 *         Laya.stage.addChild(this.input);//将 input 添加到显示列表。
	 *         this.input.on(laya.events.Event.FOCUS, this, this.onFocus);//给 input 对象添加获得焦点事件侦听。
	 *         this.input.on(laya.events.Event.BLUR, this, this.onBlur);//给 input 对象添加失去焦点事件侦听。
	 *         this.input.on(laya.events.Event.INPUT, this, this.onInput);//给 input 对象添加输入字符事件侦听。
	 *         this.input.on(laya.events.Event.ENTER, this, this.onEnter);//给 input 对象添加敲回车键事件侦听。
	 *     }
	 *     private onFocus(): void {
	 *         console.log("输入框 input 获得焦点。");
	 *     }
	 *     private onBlur(): void {
	 *         console.log("输入框 input 失去焦点。");
	 *     }
	 *     private onInput(): void {
	 *         console.log("用户在输入框 input 输入字符。文本内容：", this.input.text);
	 *     }
	 *     private onEnter(): void {
	 *         console.log("用户在输入框 input 内敲回车键。");
	 *     }
	 * }
	 * </listing>
	 */
	public class Input extends Text
	{
		/**@private */
		protected static var input:*;
		/**@private */
		protected static var area:*;
		/**@private */
		protected static var inputElement:*;
		/**@private */
		protected static var inputContainer:*;
		/**@private */
		protected static var confirmButton:*;
		/**@private */
		protected static var promptStyleDOM:*;
		
		/**@private */
		protected var _focus:Boolean;
		/**@private */
		protected var _multiline:Boolean = false;
		/**@private */
		protected var _editable:Boolean = true;
		/**@private */
		protected var _restrictPattern:Object;
		/**@private */
		protected var _maxChars:int = 1E5;
		
		private var _type:String = "text";
		
		/**原生输入框 X 轴调整值，用来调整输入框坐标。*/
		public var inputElementXAdjuster:int = 0;
		/**原生输入框 Y 轴调整值，用来调整输入框坐标。*/
		public var inputElementYAdjuster:int = 0;
		/**输入提示符。*/
		private var _prompt:String = '';
		/**输入提示符颜色。*/
		private var _promptColor:String = "#A9A9A9";
		private var _originColor:String = "#000000";
		private var _content:String = '';
		
		/**@private */
		public static const IOS_IFRAME:Boolean = (Browser.onIOS && Browser.window.top != Browser.window.self);
		private static const inputHeight:int = 45;
		
		/**表示是否处于输入状态。*/
		public static var isInputting:Boolean = false;
		
		/**创建一个新的 <code>Input</code> 类实例。*/
		public function Input()
		{
			_width = 100;
			_height = 20;
			
			multiline = false;
			overflow = Text.SCROLL;
			
			on(Event.MOUSE_DOWN, this, _onMouseDown);
			on(Event.UNDISPLAY, this, _onUnDisplay);
		}
		
		/**@private */
		public static function __init__():void
		{
			_createInputElement();
			
			// 移动端通过画布的touchend调用focus
			if (Browser.onMobile)
				Render.canvas.addEventListener(IOS_IFRAME ? "click" : "touchend", _popupInputMethod);
		}
		
		// 移动平台在单击事件触发后弹出输入法
		private static function _popupInputMethod(e:*):void
		{
			//e.preventDefault();
			if (!Input.isInputting) return;
			
			var input:* = Input.inputElement;
			
			// 设置光标位置至末尾。
			input.selectionStart = input.selectionEnd = input.value.length;
			// 弹出输入法。
			input.focus();
		}
		
		/**@private */
		private static function _createInputElement():void
		{
			_initInput(area = Browser.createElement("textarea"));
			_initInput(input = Browser.createElement("input"));
			
			inputContainer = Browser.createElement("div");
			inputContainer.style.position = "absolute";
			inputContainer.style.zIndex = 101;
			inputContainer.appendChild(input);
			inputContainer.appendChild(area);
			//[IF-SCRIPT] inputContainer.setPos = function(x:int, y:int):void { inputContainer.style.left = x + 'px'; inputContainer.style.top = y + 'px'; };
		}
		
		/**
		 * @private
		 * @param	input 输入框的引用实例。
		 */
		private static function _initInput(input:*):void
		{
			var style:* = input.style;
			style.cssText = "position:absolute;overflow:hidden;resize:none;transform-origin:0 0;-webkit-transform-origin:0 0;-moz-transform-origin:0 0;-o-transform-origin:0 0;";
			style.resize = 'none';
			style.backgroundColor = 'transparent';
			style.border = 'none';
			style.outline = 'none';
			
			input.addEventListener('input', _processInputting);
			
			input.addEventListener('mousemove', _stopEvent);
			input.addEventListener('mousedown', _stopEvent);
			input.addEventListener('touchmove', _stopEvent);
		
		/*[IF-SCRIPT-BEGIN]
		   if(!Render.isConchApp)
		   {
		   input.setColor = function(color:String):void { input.style.color = color; };
		   input.setFontSize = function(fontSize:int):void { input.style.fontSize = fontSize + 'px'; };
		   input.setSize = function(w:int, h:int):void { input.style.width = w + 'px'; input.style.height = h + 'px'; };
		   }
		   input.setFontFace = function(fontFace:String):void { input.style.fontFamily = fontFace; };
		   [IF-SCRIPT-END]*/
		}
		
		private static function _processInputting(e:*):void
		{
			var input:* = Input.inputElement.target;
			var value:String = Input.inputElement.value;
			
			// 对输入字符进行限制
			if (input._restrictPattern)
			{
				value = value.replace(input._restrictPattern, "");
				
				Input.inputElement.value = value;
			}
			
			input._text = value;
			input.event(Event.INPUT);
		}
		
		/**@private */
		private static function _stopEvent(e:*):void
		{
			if (e.type == 'touchmove')
				e.preventDefault();
			e.stopPropagation && e.stopPropagation();
		}
		
		/**
		 * 设置光标位置和选取字符。
		 * @param	startIndex	光标起始位置。
		 * @param	endIndex	光标结束位置。
		 */
		public function setSelection(startIndex:int, endIndex:int):void
		{
			Input.inputElement.selectionStart = startIndex;
			Input.inputElement.selectionEnd = endIndex;
		}
		
		/**表示是否是多行输入框。*/
		public function get multiline():Boolean
		{
			return _multiline;
		}
		
		public function set multiline(value:Boolean):void
		{
			_multiline = value;
			valign = value ? "top" : "middle";
		}
		
		/**
		 * 获取对输入框的引用实例。
		 */
		public function get nativeInput():*
		{
			return _multiline ? area : input;
		}
		
		/**@private */
		private function _onUnDisplay(e:Event = null):void
		{
			focus = false;
		}
		
		/**@private */
		private function _onMouseDown(e:Event):void
		{
			focus = true;
			Laya.stage.on(Event.MOUSE_DOWN, this, _checkBlur);
		}
		
		/**@private */
		private function _checkBlur(e:*):void
		{
			// 点击输入框之外的地方会终止输入。
			if (e.nativeEvent.target != Input.input && e.nativeEvent.target != Input.area && e.target != this)
				Input.inputElement.target.focus = false;
		}
		
		/**@inheritDoc*/
		override public function render(context:RenderContext, x:Number, y:Number):void
		{
			super.render(context, x, y);
		}
		
		/**
		 * 在输入期间，如果 Input 实例的位置改变，调用该方法同步输入框的位置。
		 */
		private function _syncInputTransform():void
		{
			var style:* = nativeInput.style;
			var stage:Stage = Laya.stage;
			var rec:Rectangle;
			rec = Utils.getGlobalPosAndScale(this);
			
			var m:Matrix = stage._canvasTransform.clone();
			
			var tm:Matrix = m.clone();
			tm.scale(Laya.stage.clientScaleX, Laya.stage.clientScaleY);
			tm.rotate(Math.PI / 180 * Laya.stage.canvasDegree);
			var sx:Number = tm.a;
			var sy:Number = tm.d;
			tm.destroy();
			
			var tx:Number = (Laya.stage.canvasDegree == 0 ? rec.x : rec.y);
			var ty:Number = (Laya.stage.canvasDegree == 0 ? rec.y : -rec.x);
			tx += padding[3];
			ty += padding[0];
			tx *= sx;
			ty *= sy;
			tx += m.tx;
			ty += m.ty;
			
			m.scale(sx * Browser.pixelRatio, sy * Browser.pixelRatio);
			m.tx = tx;
			m.ty = ty;
			
			/*[IF-FLASH]*/
			inputContainer.setPos(tx, ty);
			//[IF-SCRIPT]inputContainer.style.transform = "matrix(" + m.toString() + ")";
			m.destroy();
			
			var inputWid:int = _width - padding[1] - padding[3];
			var inputHei:int = _height - padding[0] - padding[2];
			nativeInput.setSize(inputWid, inputHei);
			
			//不可见
			if (!_getVisible()) focus = false;
			
			if (Render.isConchApp)
			{
				nativeInput.setPos(tx, ty);
				nativeInput.setScale(sx, sy);
			}
		}
		
		/**@private */
		private function _getVisible():Boolean
		{
			var target:* = this;
			while (target)
			{
				if (target.visible === false) return false;
				target = target.parent;
			}
			return true;
		}
		
		/**选中所有文本。*/
		public function select():void
		{
			nativeInput.select();
		}
		
		/**
		 * 表示焦点是否在显示对象上。
		 */
		public function get focus():Boolean
		{
			return _focus;
		}
		
		// 移动平台最后单击画布才会调用focus
		// 因此 调用focus接口是无法都在移动平台立刻弹出键盘的
		public function set focus(value:Boolean):void
		{
			var input:* = nativeInput;
			
			if (_focus !== value)
			{
				Input.isInputting = value;
				
				if (value)
				{
					input.target && (input.target.focus = false);
					input.target = this;
					
					_setInputMethod();
					Browser.container.appendChild(inputContainer);
					
					_focusIn();
				}
				else
				{
					input.target = null;
					
					_focusOut();
					Browser.container.removeChild(inputContainer);
					if (Render.isConchApp)
					{
						input.setPos(-10000, -10000);
					}
				}
			}
		}
		
		/**@private 设置输入法（textarea或input）*/
		private function _setInputMethod():void
		{
			input.parentElement && (inputContainer.removeChild(input));
			area.parentElement && (inputContainer.removeChild(area));
			
			inputElement = (_multiline ? area : input);
			inputContainer.appendChild(inputElement);
		}
		
		/**@private */
		private function _focusIn():void
		{
			var input:* = nativeInput;
			/*[IF-FLASH]*/
			input.setRestrict(_restrictPattern);
			
			this._focus = true;
			
			var cssStyle:* = input.style;
			cssStyle.whiteSpace = (wordWrap ? "pre-wrap" : "nowrap");
			_setPromptColor();
			
			input.readOnly = !this._editable;
			input.maxLength = this._maxChars;
			
			var padding:Array = this.padding;
			
			input.value = _content;
			input.type = _getCSSStyle().password ? "password" : (type == "number" ? "number" : "text");
			input.placeholder = _prompt;
			
			Laya.stage.off(Event.KEY_DOWN, this, _onKeyDown);
			Laya.stage.on(Event.KEY_DOWN, this, _onKeyDown);
			Laya.stage.focus = this;
			event(Event.FOCUS);
			
			// PC端直接调用focus进入焦点。
			if (Browser.onPC) input.focus();
			
			// PC浏览器隐藏文字
			var temp:String = _text;
			this._text = null;
			typeset();
			
			// PC同步输入框外观。
			input.setColor(_originColor);
			input.setFontSize(fontSize);
			input.setFontFace(font);
			if (Render.isConchApp)
			{
				input.setMultiAble && input.setMultiAble(_multiline);
			}
			cssStyle.lineHeight = (leading + fontSize) + "px";
			cssStyle.fontStyle = (italic ? "italic" : "normal");
			cssStyle.fontWeight = (bold ? "bold" : "normal");
			cssStyle.textAlign = align;
			cssStyle.padding = "0 0";
			
			// 输入框重定位。
			_syncInputTransform();
			if (!Render.isConchApp && Browser.onPC)
				Laya.timer.frameLoop(1, this, _syncInputTransform);
		}
		
		// 设置DOM输入框提示符颜色。
		private function _setPromptColor():void
		{
			// 创建style标签
			promptStyleDOM = Browser.getElementById("promptStyle");
			if (!promptStyleDOM)
			{
				promptStyleDOM = Browser.createElement("style");
				Browser.document.head.appendChild(promptStyleDOM);
			}
			
			// 设置style标签
			promptStyleDOM.innerText = "input::-webkit-input-placeholder, textarea::-webkit-input-placeholder {" + "color:" + _promptColor + "}" + "input:-moz-placeholder, textarea:-moz-placeholder {" + "color:" + _promptColor + "}" + "input::-moz-placeholder, textarea::-moz-placeholder {" + "color:" + _promptColor + "}" + "input:-ms-input-placeholder, textarea:-ms-input-placeholder {" + "color:" + _promptColor + "}";
		}
		
		/**@private */
		private function _focusOut():void
		{
			this._focus = false;
			
			this._text = null;
			_content = inputElement.value;
			if (!_content)
			{
				super.text = _prompt;
				super.color = _promptColor;
			}
			else
			{
				super.text = _content;
				super.color = _originColor;
			}
			
			Laya.stage.off(Event.KEY_DOWN, this, _onKeyDown);
			Laya.stage.focus = null;
			event(Event.BLUR);
			if (Render.isConchApp) this.nativeInput.blur();
			// 只有PC会注册此事件。
			Browser.onPC && Laya.timer.clear(this, _syncInputTransform);
			Laya.stage.off(Event.MOUSE_DOWN, this, _checkBlur);
		}
		
		/**@private */
		private function _onKeyDown(e:*):void
		{
			if (e.keyCode === 13)
			{
				// 移动平台单行输入状态下点击回车收回输入法。 
				if (Browser.onMobile && !this._multiline)
					this.focus = false;
				
				event(Event.ENTER);
			}
		}
		
		/**@inheritDoc */
		override public function set text(value:String):void
		{
			super.color = _originColor;
			
			value += '';
			
			if (this._focus)
			{
				nativeInput.value = value || '';
				event(Event.CHANGE);
			}
			else
			{
				// 单行时不允许换行
				if (!this._multiline)
					value = value.replace(/\r?\n/g, '');
				
				_content = value;
				
				if (value)
					super.text = value;
				else
				{
					super.text = _prompt;
					super.color = promptColor;
				}
			}
		}
		
		override public function get text():String
		{
			if (this._focus)
				return nativeInput.value;
			else
				return _content || "";
		}
		
		/**@inheritDoc */
		override public function set color(value:String):void
		{
			if (this._focus)
				nativeInput.setColor(value);
			
			super.color = _content ? value : _promptColor;
			_originColor = value;
		}
		
		/**限制输入的字符。在部分输入法下，使用中文IME会产生错误的行为。最好在输入完成后手动检测限制字符，而非使用restrict。*/
		public function get restrict():String
		{
			if (_restrictPattern)
			{
				/*[IF-FLASH]*/
				return _restrictPattern as String;
				return _restrictPattern.source;
			}
			return "";
		}
		
		public function set restrict(pattern:String):void
		{
			// AS保存字符串
			/*[IF-FLASH-BEGIN]*/
			_restrictPattern = pattern;
			return;
			/*[IF-FLASH-END]*/
			
			// H5保存RegExp
			if (pattern)
			{
				pattern = "[^" + pattern + "]";
				
				// 如果pattern为^\00-\FF，则我们需要的正则表达式是\00-\FF
				if (pattern.indexOf("^^") > -1)
					pattern = pattern.replace("^^", "");
				
				_restrictPattern = new RegExp(pattern, "g");
			}
			else
				_restrictPattern = null;
		}
				
		/**
		 * <p>本API已弃用。使用type="password"替代设置asPassword, asPassword将在下次重大更新时删去。</p>
		 * <p>指定文本字段是否是密码文本字段。</p>
		 * <p>如果此属性的值为 true，则文本字段被视为密码文本字段，并使用星号而不是实际字符来隐藏输入的字符。如果为 false，则不会将文本字段视为密码文本字段。</p>
		 * <p>默认值为false。</p>
		 */
		//[Deprecated(replacement="Input.type")]
		public function get asPassword():Boolean {
			return _getCSSStyle().password;
		}
		
		public function set asPassword(value:Boolean):void {
			_getCSSStyle().password = value;
			console.warn("deprecated: 使用type=\"password\"替代设置asPassword, asPassword将在下次重大更新时删去");
			isChanged = true;
		}
		
		/**
		 * 是否可编辑。
		 */
		public function set editable(value:Boolean):void
		{
			_editable = value;
		}
		
		public function get editable():Boolean
		{
			return _editable;
		}
		
		/**
		 * 字符数量限制，默认为10000。
		 * 设置字符数量限制时，小于等于0的值将会限制字符数量为10000。
		 */
		public function get maxChars():int
		{
			return _maxChars;
		}
		
		public function set maxChars(value:int):void
		{
			if (value <= 0)
				value = 1E5;
			_maxChars = value;
		}
		
		/**
		 * 设置输入提示符。
		 */
		public function get prompt():String
		{
			return _prompt;
		}
		
		public function set prompt(value:String):void
		{
			if (!_text && value)
				super.color = _promptColor;
			
			this.promptColor = _promptColor;
			
			if (_text)
				super.text = (_text == _prompt) ? value : _text;
			else
				super.text = value;
			
			_prompt = value;
		}
		
		/**
		 * 设置输入提示符颜色。
		 */
		public function get promptColor():String
		{
			return _promptColor;
		}
		
		public function set promptColor(value:String):void
		{
			_promptColor = value;
			if (!_content) super.color = value;
		}
		
		/**
		 * 输入框类型：
		 * <ol>
		 * <li>text:普通文本输入框。</li>
		 * <li>number:默认为数字键盘的输入框。</li>
		 * <li>password:密码输入框。</li>
		 * </ol>*/
		public function get type():String 
		{
			return _type;
		}
		
		public function set type(value:String):void 
		{
			if (value == "password")
				_getCSSStyle().password = true;
			else
				_getCSSStyle().password = false;
			_type = value;
		}
	}
}