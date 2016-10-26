package gimdata.objects.cinematic.unitCinematic 
{
	/**
	 * ...
	 * @author ...
	 */
	public class SupplyCinematic extends IUnitCinematic 
	{
		
		public function SupplyCinematic(_name:String, _y:int)  
		{
			this.y = _y;
			add_idle	(_name, (Math.floor(Math.random() * (6 - 4 + 1)) + 4)	,"MedicIdle");
			add_die		(_name, (Math.floor(Math.random() * 5 + 7))				,"MedicDie");
			
		}
		
	}

}