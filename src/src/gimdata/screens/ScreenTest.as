package gimdata.screens 
{
	import al.ALManager;
	import al.core.Ast;
	import al.display.ScreenAL;
	import flash.utils.setTimeout;
	import starling.events.SEvent;
	import treefortress.sound.SoundAS;
	import treefortress.sound.SoundManager;
	
	/**
	 * ...
	 * @author ...
	 */
	public class ScreenTest extends ScreenAL 
	{
		
		public function ScreenTest(_alManager:ALManager) {super(_alManager);}
		
		override public function start(e:SEvent) 
		{
			var music:SoundManager = SoundAS.group("musix");
			
				music.addSound("music", Ast.snd("Music"));
				music.addSound("battle", Ast.snd("BattleBG"));
				music.playLoop("music");
				music.playLoop("battle")
				
			setTimeout(function(){
				music.fadeAllTo(0, 3000);
			}, 10000 );
						
		}
	}

}