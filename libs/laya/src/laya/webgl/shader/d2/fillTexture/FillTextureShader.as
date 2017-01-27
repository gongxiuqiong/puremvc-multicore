package laya.webgl.shader.d2.fillTexture 
{
	import laya.webgl.shader.Shader;
	/**
	 * ...
	 * @author ...
	 */
	public class FillTextureShader extends Shader
	{
		
		public static var _instance:FillTextureShader;
		
		public function FillTextureShader() 
		{
			var vs:String = __INCLUDESTR__("fillTextureShader.vs");
			var ps:String = __INCLUDESTR__("fillTextureShader.ps");
			super(vs, ps, "fillTextureShader");
		}
		
		public static function getInstance():FillTextureShader
		{
			return _instance ||= new FillTextureShader();
		}
		
	}

}