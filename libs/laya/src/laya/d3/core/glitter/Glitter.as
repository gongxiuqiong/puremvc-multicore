package laya.d3.core.glitter {
	import laya.d3.core.GlitterRender;
	import laya.d3.core.Sprite3D;
	import laya.d3.core.material.Material;
	import laya.d3.core.render.IRenderable;
	import laya.d3.core.render.RenderElement;
	import laya.d3.core.render.RenderQueue;
	import laya.d3.core.render.RenderState;
	import laya.d3.math.Vector3;
	import laya.d3.resource.tempelet.GlitterTemplet;
	import laya.display.Node;
	import laya.events.Event;
	import laya.utils.Stat;
	
	/**
	 * <code>Glitter</code> 类用于创建闪光。
	 */
	public class Glitter extends Sprite3D {
		/** @private */
		private var _templet:GlitterTemplet;
		/** @private */
		private var _glitterRender:GlitterRender;
		
		/**
		 * 获取闪光模板。
		 * @return  闪光模板。
		 */
		public function get templet():GlitterTemplet {
			return _templet;
		}
		
		/**
		 * 获取刀光渲染器。
		 * @return  刀光渲染器。
		 */
		public function get glitterRender():GlitterRender {
			return _glitterRender;
		}
		
		/**
		 * 创建一个 <code>Glitter</code> 实例。
		 *  @param	settings 配置信息。
		 */
		public function Glitter(settings:GlitterSettings) {//暂不支持更换模板和初始化后修改混合状态。
			_glitterRender = new GlitterRender(this);
			_glitterRender.on(Event.MATERIAL_CHANGED, this, _onMaterialChanged);
			
			var material:Material = new Material();
			_glitterRender.shadredMaterial = material;
			_templet = new GlitterTemplet(this, settings);
			
			material.renderMode = Material.RENDERMODE_ADDTIVEDOUBLEFACE;
			
			_changeRenderObject(0);
		
		}
		
		/** @private */
		private function _changeRenderObject(index:int):RenderElement {
			var renderObjects:Vector.<RenderElement> = _glitterRender.renderCullingObject._renderElements;
			
			var renderElement:RenderElement = renderObjects[index];
			(renderElement) || (renderElement = renderObjects[index] = new RenderElement());
			
			var material:Material = _glitterRender.shadredMaterials[index];
			(material) || (material = Material.defaultMaterial);//确保有材质,由默认材质代替。
			
			var element:IRenderable = _templet;
			renderElement.mainSortID = 0;
			renderElement.triangleCount = element.triangleCount;
			renderElement.sprite3D = this;
			
			renderElement.element = element;
			renderElement.material = material;
			return renderElement;
		}
		
		/** @private */
		private function _onMaterialChanged(_glitterRender:GlitterRender, oldMaterials:Array, materials:Array):void {
			var renderElementCount:int = _glitterRender.renderCullingObject._renderElements.length;
			for (var i:int = 0, n:int = materials.length; i < n; i++)
				(i < renderElementCount) && _changeRenderObject(i);
		}
		
		/** @private */
		override protected function _clearSelfRenderObjects():void {
			scene.removeFrustumCullingObject(_glitterRender.renderCullingObject);
		}
		
		/** @private */
		override protected function _addSelfRenderObjects():void {
			(scene) && (scene.addFrustumCullingObject(_glitterRender.renderCullingObject));
		}
		
		/**
		 * @private
		 * 更新闪光。
		 * @param	state 渲染状态参数。
		 */
		public override function _update(state:RenderState):void {
			state.owner = this;
			
			Stat.spriteCount++;
			_childs.length && _updateChilds(state);
		}
		
		/**
		 * 通过位置添加刀光。
		 * @param position0 位置0。
		 * @param position1 位置1。
		 */
		public function addGlitterByPositions(position0:Vector3, position1:Vector3):void {
			_templet.addVertexPosition(position0, position1);
		}
		
		/**
		 * 通过位置和速度添加刀光。
		 * @param position0 位置0。
		 * @param velocity0 速度0。
		 * @param position1 位置1。
		 * @param velocity1 速度1。
		 */
		public function addGlitterByPositionsVelocitys(position0:Vector3, velocity0:Vector3, position1:Vector3, velocity1:Vector3):void {
			_templet.addVertexPositionVelocity(position0, velocity0, position1, velocity1);
		}
		
		override public function dispose():void {
			super.dispose();
			_glitterRender.off(Event.MATERIAL_CHANGED, this, _onMaterialChanged);
			_templet.dispose();
		
		}
	
	}
}