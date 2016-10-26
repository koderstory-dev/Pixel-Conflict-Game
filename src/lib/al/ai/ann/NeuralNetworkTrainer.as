package al.ai.ann 
{
	import al.ai.ga.GeneticAlgorithm;
	/**
	 * ...
	 * @author AldyAhsandin
	 */
	public class NeuralNetworkTrainer 
	{
		
		/* ====================== */
		/*   Properties           */
		/* ====================== */
		
		private var m_nn:NeuralNetwork;
		
		//change to weights
		private var m_deltaInputHidden:Array;
		private var m_deltaHiddenOuput:Array;
		
		//error gradient
		private var m_hiddenErrorGradient:Array;
		private var m_outputErrorGradient:Array;
		
		// learning parameter
		private var m_learningRate:Number	= 0.001;
		private var m_momentum:Number		= 0.9;		
		
		//batch learning flag
		private var m_useBatch:Boolean		= false;
		
		//epoch counter
		private var m_maxEpoch:int			= 1500;
		private var m_epoch:int				= 0;
		
		//accuracy/ MSE required
		private var m_desiredAccuracy:Number= 90.0;
		
		//accuracy stats per epoch2
		private var m_trainingSetAccuracy:Number		= 0;
		private var m_validationSetAccuracy:Number		= 0;
		private var m_generalizationSetAccuracy:Number	= 0;
		private var m_trainingSetMSE:Number				= 0;
		private var m_generalizationSetMSE:Number		= 0;
		private var m_validationSetMSE:Number			= 0;
		
		
		/* ====================== */
		/*   Constructor          */
		/* ====================== */
		
		/**
		 * Init data neural network, make delta list and error gradient storage
		 * @param	_nn
		 */
		public function NeuralNetworkTrainer(_nn:NeuralNetwork) {
			
			m_nn = _nn;
			
			// ------------------
			//  Create Delta List
			// ------------------
			
			var _nInput:int;
			
			m_deltaInputHidden 	= new Array();
			for (var i:int = 0; i <= _nn.nInput; i++ ) {
				m_deltaInputHidden[i] = new Array();
				for (var h:int = 0; h < _nn.nHidden; h++ )
					m_deltaInputHidden[i][h] = 0;
			}
				
			
			m_deltaHiddenOuput 	= new Array();
			for (var h:int = 0; h <= _nn.nHidden; h++ ) {
				m_deltaHiddenOuput[h] = new Array();
				for (var o:int = 0; o < _nn.nOutput; o++ )
					m_deltaHiddenOuput[h][o] = 0;
			}
			
			// --------------------------------
			//  Create Error Gradient Storage
			// --------------------------------
			
			m_hiddenErrorGradient	= new Array();
			for (var i:int = 0; i < _nn.nHidden; i++ ) m_hiddenErrorGradient[i] = 0;
			
			m_outputErrorGradient	= new Array();
			for (var i:int = 0; i < _nn.nOutput; i++ ) m_outputErrorGradient[i] = 0;
			
			
		}
		
		/* ====================== */
		/*   Private  Method      */
		/* ====================== */
		
		private function getOutputErrorGradient( _desiredValue:Number, _outputValue:Number):Number {
			return _outputValue * ( 1  - _outputValue ) * ( _desiredValue - _outputValue );
		}
		
		private function getHiddenErrorGradient(_h:int):Number {
			
			//sum of hidden->output weight  *  error output gradient
			var _weightedSum:Number	= 0.0;
			for (var o:int = 0; o < m_nn.nOutput; o++ ) 
				_weightedSum +=  m_nn.wHiddenOutput[_h][o] * m_outputErrorGradient[o]
			
			return m_nn.hiddenNeurons[_h] * ( 1 - m_nn.hiddenNeurons[_h]) * _weightedSum;
			
		}
		
		private function runTrainingEpoch(_tSet:Vector.<DataEntry>):void {
			
			var _incorrectPatterns:Number 	= 0;
			var _mse:Number					= 0
			
			//check for every pattern
			for (var tp:int = 0; tp < _tSet.length; tp++ ) {
				var _dataEntry:DataEntry = _tSet[tp] as DataEntry;
				
				// feed inputs and backpropagate errors
				m_nn.feedForwardPattern( _dataEntry.pattern);
				backpropagate( _dataEntry.target );
				
				var _patternCorrect:Boolean = true;
				
				for ( var o:int = 0; o < m_nn.nOutput; o++ ) {
					if ( Math.abs( (m_nn.clampOutput( m_nn.outputNeurons[o])) - _dataEntry.target[o] ) > 0.2) 
					_patternCorrect = false;
					_mse += Math.pow( m_nn.outputNeurons[o] - _dataEntry.target[o], 2 );
					
				}
				if (!_patternCorrect) _incorrectPatterns++;
				
			}
			
			if (m_useBatch) updateWeights();
			m_trainingSetAccuracy	= 100 - ( ( _incorrectPatterns / _tSet.length) * 100 );
			m_trainingSetMSE		= _mse / ( m_nn.nOutput * _tSet.length );
			
		}
		
		private function updateWeights():void {
			
			//-------------------------------------------
			// update weight input - hidden
			//-------------------------------------------
			for (var i:int = 0; i <= m_nn.nInput; i++ ) {
			for (var h:int = 0; h < m_nn.nHidden; h++ ) {
				m_nn.wInputHidden[i][h]	+= m_deltaInputHidden[i][h];
				
				if (m_useBatch) 
					m_deltaInputHidden[i][h] = 0;	
			}}
			
			// weight hidden - output
			for (var h:int = 0; h <= m_nn.nHidden; h++ ) {
			for (var o:int = 0; o < m_nn.nOutput; o++ ) {
				m_nn.wHiddenOutput[h][o] += m_deltaHiddenOuput[h][o];
				
				if (m_useBatch) 
					m_deltaHiddenOuput[h][o] = 0;		
			}}
			
		}
		
		private function backpropagate(_target:Array):void {
			
			//modify delta between hidden and output
			for (var o:int = 0; o < m_nn.nOutput; o++ ) {
				
				m_outputErrorGradient[o] = getOutputErrorGradient( _target[o], m_nn.outputNeurons[o]);
				for (var h:int = 0; h <= m_nn.nHidden; h++ ) {
					
					if (!m_useBatch)
						m_deltaHiddenOuput[h][o] = 	m_learningRate * m_nn.hiddenNeurons[h] * m_outputErrorGradient[o] 
													+ m_momentum * m_deltaHiddenOuput[h][o];
					else
						m_deltaHiddenOuput[h][o] += m_learningRate * m_nn.hiddenNeurons[h] * m_outputErrorGradient[o]; 	
				}
				//trace(_target[o], m_nn.outputNeurons[o]);
			}
			
			
			
			// modify deltas between input and hidden
			for (var h:int = 0; h < m_nn.nHidden; h++ ) {
				
				m_hiddenErrorGradient[h] = getHiddenErrorGradient(h);
				for (var i:int = 0; i <= m_nn.nInput; i++ ) {
					
					if (!m_useBatch)
						m_deltaInputHidden[i][h] = 	m_learningRate * m_nn.inputsNeurons[i] * m_hiddenErrorGradient[h] 
													+ m_momentum * m_hiddenErrorGradient[h];
					else
						m_deltaInputHidden[i][h] += m_learningRate * m_nn.inputsNeurons[i] * m_hiddenErrorGradient[h];
					
				}
				
			}
			
			
			//if use stocastic learning, update weight immediately
			if (!m_useBatch) updateWeights();
		}
		
		
		/* ====================== */
		/*   Public  Method       */
		/* ====================== */
		
		/**
		 * Set parameter
		 * @param	_lr		learning rate
		 * @param	_m		momentum
		 * @param	_batch	menggunakan batch atau tidak
		 */
		public function setTrainingParameters(_lr:Number, _m:Number, _batch:Boolean) {
			
			m_learningRate	= _lr;
			m_momentum		= _m;
			m_useBatch		= _batch;
			
		}
		
		/**
		 * Set parameter for stopping
		 * @param	_epoch		epoch number
		 * @param	_dAccuracy	number accuracy
		 */
		public function setStoppingConditions( _epoch:int, _dAccuracy:Number) {
			
			m_maxEpoch			= _epoch;
			m_desiredAccuracy	= _dAccuracy;
			
		}
		
		/**
		 * Train the network
		 * @param	_tSet  DataSet
		 */
		public function trainNetwork(_tSet:TrainingDataSet) {
			
			m_epoch	= 0;
			
			//train network 
			while 	(((m_trainingSetAccuracy < m_desiredAccuracy) || (m_generalizationSetAccuracy < m_desiredAccuracy)) && 
					(m_epoch < m_maxEpoch)) {
				
					//store previous accuracy
					var _previousTAccuracy:Number	= m_trainingSetAccuracy;
					var _previousGAccuracy:Number	= m_generalizationSetAccuracy;
					
					//use training set to train network
					runTrainingEpoch(_tSet.trainingSet);
					
					//get generalization and MSE
					m_generalizationSetAccuracy	= m_nn.getSetAccuracy( _tSet.generalizationSet );
					m_generalizationSetMSE		= m_nn.getSetMSE(_tSet.generalizationSet);
				
					//print data
					trace(m_epoch);
					if ((Math.ceil(_previousTAccuracy) != Math.ceil(m_trainingSetAccuracy)) ||
						(Math.ceil(_previousGAccuracy) != Math.ceil(m_generalizationSetAccuracy))) {
							
							trace("Epoch: " + m_epoch);
							trace("TSet Acc: " + m_trainingSetAccuracy + "%, MSE: " + m_trainingSetMSE);
							trace("GSet Acc: " + m_generalizationSetAccuracy + "%, MSE: " + m_generalizationSetMSE+"\n");
						}
					
					m_epoch++;
					
			}
			
			
			//get validation accuracy
			m_validationSetAccuracy	= m_nn.getSetAccuracy( _tSet.validationSet);
			m_validationSetMSE		= m_nn.getSetMSE( _tSet.validationSet);
			
			
			//training complete
			trace("=========================");
			trace("    TRAINING COMPLETE    ");
			trace("=========================");
			trace("Elapsed Epoch: " + m_epoch);
			trace("ValidationSetAcc:" + m_validationSetAccuracy + ", ValidationMSE: " + m_validationSetMSE);
			
			
		}
		
		
		
		
		
	}

}