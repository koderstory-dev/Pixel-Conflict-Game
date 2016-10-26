package al.ai.ann 
{
	import com.aldyahsn.starling.data.DataJSON;
	/**
	 * ...
	 * @author AldyAhsandin
	 */
	
	/* ====================== */
	/*   CLASS DATA READER    */
	/* ====================== */
	public class DataReader 
	{
		
		public function DataReader() {
			
		}
		
		/* ====================== */
		/*       Properties       */
		/* ====================== */
		
		private var m_Data:Object;
		private var m_tSet:TrainingDataSet; 
		private var m_newData:Array;
		
		private var m_nInput:int;
		private var m_nTarget:int;
		
		private var m_trainingDataIndex:int;
		private var m_numTrainingSets:int = 1;
		private var m_creationApproach:String;
		
		public var growingStepSize:Number;		// percentage of total size
		public var growingLastDataIndex:int;	// last index added to current index
		public var windowingSetSize:int;		// init set size
		public var windowingStepSize:int;		// how many entries to move window
		public var windowingStartIndex:int		// windows start index
		
		public static const	STATIC:String 		= "STATIC"
		public static const	GROWING:String 		= "GROWING"
		public static const	WINDOWING:String 	= "WINDOWING"
		
		/* ==================== */
		/*   Private Method     */
		/* ==================== */
		
		/**
		 * Create static data set
		 */
		private function createStaticDataSet():void {
			
			for (var i:int = 0; i < m_trainingDataIndex; i++ ) {
				
				var _dataEntry:DataEntry = new DataEntry();
				_dataEntry.pattern 	= m_newData[i].slice(0, m_nInput);
				_dataEntry.target	= m_newData[i].slice(m_nInput, m_nInput+m_nTarget);
				
				m_tSet.trainingSet.push(_dataEntry);
			}
			
		}
		
		private function createGrowingDataSet() {
			
			growingLastDataIndex += int( Math.ceil( growingStepSize * m_trainingDataIndex ) );
			if (growingLastDataIndex > int( m_trainingDataIndex ))
				growingLastDataIndex = m_trainingDataIndex;
			
			//m_tSet.trainingSet = null;
			
			for (var i:int = 0; i < growingLastDataIndex; i++ ) {
				
				var _dataEntry:DataEntry = new DataEntry();
				_dataEntry.pattern 	= (m_Data[i] as Array).slice(0, m_nInput);
				_dataEntry.target	= (m_Data[i] as Array).slice(m_nInput, m_nInput+m_nTarget);
				
				m_tSet.trainingSet.push( _dataEntry );
			}
			
		}
		
		private function createWindowingDataSet() {
			
		}
		
		private function randomData(_oldData:Array):Array {
			var _newData:Array = new Array();
			
			while (_oldData.length > 0) {
				var _random:int = Math.random() * _oldData.length;
				_newData.push(_oldData[_random]);
				_oldData.splice( _random, 1);
			}
			
			return _newData;
			
		}
		/* ====================== */
		/*   Public  Method       */
		/* ====================== */
		
		/**
		 * Load data from embedded data
		 * @param	_class embedded class
		 * @param	_nI number of index input neuron
		 * @param	_nT number of index target neuron
		 */
		public function loadDataFile(_data:Object, _nI:int, _nT:int) {
			
			m_Data							= _data;
			m_nInput						= _nI;
			m_nTarget						= _nT;
			
			m_newData						= randomData((m_Data as Array));
			var _dataSize			:int	= (m_newData.length); 
			
			m_trainingDataIndex 			= 0.8 * _dataSize;
			var generalizationSize	:int	= Math.ceil(0.1 * _dataSize);
			var validationSize		:int	= _dataSize - (m_trainingDataIndex + generalizationSize);
			
			//generalisation set
			m_tSet							= new TrainingDataSet();
			
			
			for (var i:int = m_trainingDataIndex; i < m_trainingDataIndex + generalizationSize; i++ ) {
				var _dataEntry		:DataEntry 	= new DataEntry();
				_dataEntry.pattern 				= m_newData[i].slice(0, m_nInput);
				_dataEntry.target				= m_newData[i].slice(m_nInput, m_nInput+m_nTarget);
				
				m_tSet.generalizationSet.push(_dataEntry);
			}
				
			//validation set
			for (var i:int = m_trainingDataIndex + generalizationSize; i < _dataSize; i++ ) {
				
				var _dataEntry		:DataEntry 	= new DataEntry();
				_dataEntry.pattern 				= m_newData[i].slice(0, m_nInput);
				_dataEntry.target				= m_newData[i].slice(m_nInput, m_nInput+m_nTarget);
				
				m_tSet.validationSet.push(_dataEntry);
			}
			
		}
		
		
		/**
		 * Approch of data creation
		 * @param	_approach
		 * @param	_param1
		 * @param	_param2
		 */
		public function setCreationApproch(_approach:String, _param1:Number = 0, _param2:Number = 0) {
			
			switch(_approach) {
				
				case STATIC: 	m_numTrainingSets	= 1;
								m_creationApproach	= STATIC;
								break;
								
								
				case GROWING:	if (_param1<=100 && _param1>0)
								{
									m_creationApproach 		= GROWING;
									growingStepSize 		= _param1 / 100;
									growingLastDataIndex 	= 0;
									
									m_numTrainingSets		=  int( Math.ceil(1 / growingStepSize));
								}
								break;
				case WINDOWING: if (_param1 < (m_Data as Array).length && _param2 <=  _param1) 
								{
									m_creationApproach 	= WINDOWING;
									
									windowingSetSize	= int(_param1);
									windowingStepSize	= int(_param2);
									windowingStartIndex	= 0;
									
									numTrainingSets 	= int(Math.ceil(Number((m_trainingDataIndex - windowingSetSize) / windowingStepSize))) + 1;
								}
								break;
			}
		}
		
		/**
		 * Get number of training size
		 */
		public function get numTrainingSets():Number {
			return m_numTrainingSets;
		}

		/**
		 * Get training dataSet
		 */
		public function get trainingDataSet():TrainingDataSet {
			
			switch(m_creationApproach) {
				case STATIC: 	createStaticDataSet(); break;
				case GROWING:	createGrowingDataSet(); break;
				case WINDOWING:	createWindowingDataSet(); break;
			}
			
			return m_tSet;
		}
		
		
	}
}




	


	
	
	




