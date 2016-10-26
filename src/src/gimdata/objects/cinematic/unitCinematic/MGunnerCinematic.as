package gimdata.objects.cinematic.unitCinematic 
{
	/**
	 * ...
	 * @author ...
	 */
	public class MGunnerCinematic extends IUnitCinematic 
	{
		
		public function MGunnerCinematic(_name:String, _y:int) 
		{
			this.y = _y;
			add_idle	(_name, (Math.floor(Math.random() * (6 - 4 + 1)) + 4)	,"MGunnerIdle");
			add_walk	(_name, (Math.floor(Math.random() * (6 - 4 + 1)) + 4)	,"MGunnerWalk");
			add_attack	(_name, (Math.floor(Math.random() * (6 - 4 + 1)) + 4)	,"MGunnerAttack");
			add_duck	(_name, (Math.floor(Math.random() * (6 - 4 + 1)) + 4)	,"MGunnerDuck");
			add_die		(_name, (Math.floor(Math.random() * 5 + 7))				,"MGunnerDie");
			
		}
		
	}

}