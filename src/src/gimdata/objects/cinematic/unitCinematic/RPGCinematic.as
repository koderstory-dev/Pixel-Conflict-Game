package gimdata.objects.cinematic.unitCinematic 
{
	/**
	 * ...
	 * @author ...
	 */
	public class RPGCinematic extends IUnitCinematic 
	{
		
		public function RPGCinematic(_name:String, _y:int)  
		{
			this.y = _y;
			add_idle	(_name, (Math.floor(Math.random() * (6 - 4 + 1)) + 4)	,"RocketIdle");
			add_walk	(_name, (Math.floor(Math.random() * (6 - 4 + 1)) + 4)	,"RocketWalk");
			add_attack	(_name, (Math.floor(Math.random() * (6 - 4 + 1)) + 4)	,"RocketAttack");
			add_duck	(_name, (Math.floor(Math.random() * (6 - 4 + 1)) + 4)	,"RocketDuck");
			add_die		(_name, (Math.floor(Math.random() * 5 + 7))				,"RocketDie");
			
		}
		
	}

}