package gimdata.objects.cinematic.unitCinematic 
{
	/**
	 * ...
	 * @author ...
	 */
	public class APCCinematic extends IUnitCinematic 
	{
		
		public function APCCinematic(_name:String, _y:int) 
		{
			this.y = _y;
			add_idle	(_name, (Math.floor(Math.random() * (6 - 4 + 1)) + 4)	,"ApcIdle");
			add_walk	(_name, (Math.floor(Math.random() * (6 - 4 + 1)) + 4)	,"ApcWalk");
			add_attack	(_name, (Math.floor(Math.random() * (6 - 4 + 1)) + 4)	,"ApcAttack");
			add_die		(_name, (Math.floor(Math.random() * 5 + 7))				,"ApcDie");
			
		}
		
	}

}