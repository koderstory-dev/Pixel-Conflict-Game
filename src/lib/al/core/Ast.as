package al.core 
{
	import al.list.Port;
	import flash.media.Sound;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	/**
	 * ...
	 * @author Aldy Ahsandin
	 */
	public class Ast 
	{
		public static function txA(_name:String):TextureAtlas
		{
			return AL.assets.getTextureAtlas(_name);
		}
		
		/**
		 * load image
		 * @param	_name	nama file image
		 * @param	_atlas	nama texture atlas
		 * @return
		 */
		public static function img(_name:String, _atlas:String = ""):Texture {
			
			if (_atlas)	return AL.assets.getTextureAtlas(_name).getTexture(_atlas);
			else		return AL.assets.getTexture(_name);				
			

		}
		
		public static function imgs(_name:String, _atlas:String):Vector.<Texture>{
			return AL.assets.getTextureAtlas(_name).getTextures(_atlas);
		}
		
		public static function xml(_name:String):XML{
			return AL.assets.getXml(_name);
		}
		
		public static function obj(_name:String):Object {
			return AL.assets.getObject(_name);
		}
		
		public static function snd(_name:String):Sound {
			return AL.assets.getSound(_name);
		}
	}

}