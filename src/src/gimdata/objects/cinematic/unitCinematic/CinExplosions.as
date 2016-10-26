package gimdata.objects.cinematic.unitCinematic 
{
	import al.core.AL;
	import al.core.Ast;
	import al.display.SpriteAL;
	import de.flintfabrik.starling.display.FFParticleSystem;
	import de.flintfabrik.starling.display.FFParticleSystem.SystemOptions;
	import flash.geom.Point;
	import org.osflash.signals.Signal;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author AldyAhsandin
	 */
	public class CinExplosions extends SpriteAL 
	{
		// effect
		protected var m_fireEffect	: FFParticleSystem; 
		public function CinExplosions() 
		{
			FFParticleSystem.init(4096, false, 4096, 16);
			
			var _fireXML	:XML 		= Ast.xml("explosion")
			var _fireTexture:Texture 	= Ast.img("taA", "smokeB_0")
			m_fireEffect				= new FFParticleSystem(SystemOptions.fromXML(_fireXML, _fireTexture));
			m_fireEffect.visible		= false;
			addChild(m_fireEffect);
			
		}
		
		public function show_Explosion(_pos:Point) {
			m_fireEffect.visible = true;
			m_fireEffect.emitterX = _pos.x;
			m_fireEffect.emitterY = _pos.y;
			m_fireEffect.start(0.05);
		}
	}

}