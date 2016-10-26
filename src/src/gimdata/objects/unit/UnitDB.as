package gimdata.objects.unit 
{
	import flash.utils.Dictionary;
	/**
	 * Kelas yang menyimpan record data unit
	 * @author Aldy Ahsandin
	 */
	public class UnitDB 
	{
		
		public 	var hpFull			: int;
		public 	var act				: int;
		public 	var move			: int;
		public	var category		: String;
		public	var isSupply		: Boolean;
		public	var isDirectAct		: Boolean;
		
		
		/**
		 * Status Terrain yang bisa dilewati atau tidak
		 * contoh terrainStatus[2] = true / false
		 */
		public	var terrainsStatus	: Array;
		
		/**
		 * Nilai cover terrain yang diberikan kepada unit
		 */
		public	var terrainsCover	: Array;
		
		/**
		 * Data basic dari suatu unit
		 * @param	_hp			berapa healthpoint unit?
		 * @param	_atk		berapa kekuatan serang?
		 * @param	_move		berapa jarak jangkau gerak unit
		 * @param	_isSupply 	apakah jenis supply?
		 * @param	_dAct 		apakah unit menyerang secara langsung atau tidak?
		 * @param	_category 	apa jenis unit ally? atau Enemy?
		 */
		public function UnitDB(
		_hp			: int, 
		_atk		: int, 
		_move		: int,
		_isSupply	: Boolean,
		_dAct		: Boolean, 
		_category	: String) {
			
			hpFull			= _hp;
			act				= _atk;
			move			= _move;
			isSupply		= _isSupply;
			isDirectAct		= _dAct;
			category		= _category;
			
			terrainsStatus	= new Array();
			terrainsCover	= new Array();
		}
		
		
		
		
		
		
	}

}