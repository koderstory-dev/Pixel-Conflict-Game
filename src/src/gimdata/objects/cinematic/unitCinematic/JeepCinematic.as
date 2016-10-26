package gimdata.objects.cinematic.unitCinematic 
{
	/**
	 * ...
	 * @author ...
	 */
	public class JeepCinematic extends IUnitCinematic 
	{
		
		public function JeepCinematic(_name:String, _y:int) 
		{
			this.y = _y;
			add_idle	(_name, (Math.floor(Math.random() * (6 - 4 + 1)) + 4)	,"CarIdle");
			add_walk	(_name, (Math.floor(Math.random() * (6 - 4 + 1)) + 4)	,"CarWalk");
			add_attack	(_name, (Math.floor(Math.random() * (6 - 4 + 1)) + 4)	,"CarAttack");
			add_die		(_name, (Math.floor(Math.random() * 5 + 7))				,"CarDie");
			
		}
		
	}

}