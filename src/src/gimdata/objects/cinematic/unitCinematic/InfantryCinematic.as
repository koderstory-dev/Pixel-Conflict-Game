package gimdata.objects.cinematic.unitCinematic 
{
	/**
	 * ...
	 * @author ...
	 */
	public class InfantryCinematic extends IUnitCinematic 
	{
		
		public function InfantryCinematic(_name:String, _y:int) 
		{
			this.y = _y;
			add_idle	(_name, (Math.floor(Math.random() * (6 - 4 + 1)) + 4)	,"InfantryIdle");
			add_walk	(_name, (Math.floor(Math.random() * (6 - 4 + 1)) + 4)	,"InfantryWalk");
			add_attack	(_name, (Math.floor(Math.random() * (6 - 4 + 1)) + 4)	,"InfantryAttack");
			add_duck	(_name, (Math.floor(Math.random() * (6 - 4 + 1)) + 4)	,"InfantryDuck");
			add_die		(_name, (Math.floor(Math.random() * 5 + 7))				,"InfantryDie");
		}
		
	}

}