package gimdata.objects.cinematic.unitCinematic 
{
	/**
	 * ...
	 * @author ...
	 */
	public class ArtilleryCinematic extends IUnitCinematic 
	{
		
		public function ArtilleryCinematic(_name:String, _y:int) 
		{
			this.y = _y;
			add_idle	(_name, (Math.floor(Math.random() * (6 - 4 + 1)) + 4)	,"ArtilleryIdle");
			add_attack	(_name, (Math.floor(Math.random() * (6 - 4 + 1)) + 4)	,"ArtilleryAttack");
			add_die		(_name, (Math.floor(Math.random() * 5 + 7))				,"ArtilleryDie");
		}
		
	}

}