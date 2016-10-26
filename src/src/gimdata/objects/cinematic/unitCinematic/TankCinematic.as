package gimdata.objects.cinematic.unitCinematic 
{
	/**
	 * ...
	 * @author ...
	 */
	public class TankCinematic extends IUnitCinematic 
	{
		
		public function TankCinematic(_name:String, _y:int)  
		{
			this.y = _y;
			add_idle	(_name, (Math.floor(Math.random() * (6 - 4 + 1)) + 4)	,"TankIdle");
			add_walk	(_name, (Math.floor(Math.random() * (6 - 4 + 1)) + 4)	,"TankWalk");
			add_attack	(_name, (Math.floor(Math.random() * (6 - 4 + 1)) + 4)	,"TankAttack");
			add_die		(_name, (Math.floor(Math.random() * 5 + 7))				,"TankDie");
			
		}
		
	}

}