package gimdata.core.config 
{
	import al.misc.SaveToFile;
	import al.misc.Show;
	/**
	 * Kelas menyimpan record data training
	 * Jika ingin merubah data input dan output, 
	 * tinggal ganti variabel input dan outputnya
	 * serta variabel passing parameter di setiap fungsi
	 * @author Aldy Ahsandin
	 */
	public class Record 
	{
		//--------------------------------------------
		// variabel penampung input
		//--------------------------------------------
		private static var m_terrainCover	: Vector.<Number>	= new Vector.<Number>();
		private static var m_passableTile	: Vector.<Number>	= new Vector.<Number>();
		private static var m_imap			: Vector.<Number>	= new Vector.<Number>();
		private	static var m_buildingPos	: Vector.<Number>	= new Vector.<Number>();
		private static var m_unitsVal		: Vector.<Number>	= new Vector.<Number>();
		
		//--------------------------------------------
		// variabel penampung output
		//--------------------------------------------
		private static var m_outputMove		: Vector.<Number>	= new Vector.<Number>();
		private static var m_outputAtk		: Vector.<Number>	= new Vector.<Number>();
		
		//--------------------------------------------
		// variabel yang menyimpan input-output dalam 1 line
		//--------------------------------------------
		private static var m_data:Vector.<Vector.<Number>> = new Vector.<Vector.<Number>>();
		
		//--------------------------------------------
		// Private Method
		//--------------------------------------------
		
		private static function resetData()
		{
			if (m_outputMove.length == 0) {
				var _total		: int 	= Config.WIDTH * Config.HEIGHT;
				for (var i:int = 0; i < _total; i++  ) {
					m_outputMove.push(0);
					m_outputAtk.push(0);
				}	
			} else {
				var _total		: int	= m_outputMove.length;
				for (var i:int = 0; i < _total; i++  ) {
				m_outputMove[i]=0;
				m_outputAtk[i]=0;
			}
			}
			
		}
		
		private static function makeALine():void 
		{
			//----------------------------------------------------
			// data input dan output di konversi menjadi satu data
			//----------------------------------------------------
			
			var _data:Vector.<Number> = new Vector.<Number>();
			
			for (var i:int = 0; i < m_terrainCover.length; i++ ) 
			_data.push(m_terrainCover[i]);
			
			for (var i:int = 0; i < m_passableTile.length; i++ ) 
			_data.push(m_passableTile[i]);
			
			for (var i:int = 0; i < m_imap.length; i++ ) 
			_data.push(m_imap[i]);
			
			for (var i:int = 0; i < m_buildingPos.length; i++ ) 
			_data.push(m_buildingPos[i]);
			
			for (var i:int = 0; i < m_unitsVal.length; i++ ) 
			_data.push(m_unitsVal[i]);
			
			for (var i:int = 0; i < m_outputMove.length; i++ ) 
			_data.push(m_outputMove[i]);	
			
			for (var i:int = 0; i < m_outputAtk.length; i++ ) 
			_data.push(m_outputAtk[i]);
			
			m_data.push(_data);
		
		}
		
		//--------------------------------------------
		// Public Method
		//--------------------------------------------
		
		
		 /**
		  * Tambahkan input yang akan disimpan
		  * @param	_t	terrain cover
		  * @param	_i	imap
		  * @param	_u	units value
		  * @param	_p	passable tile
		  * @param	_b	building position
		  */
		public static function addInput(
		_t	: Vector.<Number>,
		_i	: Vector.<Number>,
		_u	: Vector.<Number>,
		_p	: Vector.<Number>,
		_b	: Vector.<Number>) {
			
			m_terrainCover 	= _t;
			m_passableTile	= _p;
			m_imap			= _i;
			m_buildingPos	= _b;
			m_unitsVal		= _u;

			Show.squareNum_zero("IMAP",m_imap, Config.WIDTH, Config.HEIGHT);
			Show.squareNum_zero("TERRAIN COVER", m_terrainCover, Config.WIDTH, Config.HEIGHT);
			Show.squareNum_negatif("PASSABLE TILE",m_passableTile, Config.WIDTH, Config.HEIGHT);
			Show.squareNum_zero("BUILDING POS",m_buildingPos, Config.WIDTH, Config.HEIGHT);
			Show.squareNum_negatif("UNIT VALUE",m_unitsVal, Config.WIDTH, Config.HEIGHT);
			
		}
		
		/**
		 * tambahkan output kemudian simpan data di file record.json
		 * @param	_m
		 * @param	_a
		 */
		public static function addOutput(_isMove:Boolean, _x:int, _y:int) {
			
			//----------------------------------------------------
			// Mengeset nilai output
			//----------------------------------------------------
			var _targetIndex: int	= _x + _y * Config.WIDTH;
			
			resetData();
			
			// set index x, y sebagai posisi pilihan
			if (_isMove) m_outputMove[_targetIndex] = 1;
			else		 m_outputAtk[_targetIndex] 	= 1;
			
			Show.squareNum_zero("OUTPUT MOVE", m_outputMove, Config.WIDTH, Config.HEIGHT);
			Show.squareNum_zero("OUTPUT ATK", m_outputAtk, Config.WIDTH, Config.HEIGHT);
			
			makeALine();	
			
		}
		
		/**
		 * Simpan ke dalam folder data
		 */
		public static function save()
		{
			
			var _object:Object		= m_data;
			
			SaveToFile.openStream("record");
			SaveToFile.save(JSON.stringify(_object));
			SaveToFile.closeStream();
			
			
		}
		
		
	}

}