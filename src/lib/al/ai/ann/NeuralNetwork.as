package al.ai.ann 
{
	import al.misc.SaveToFile;
	import starling.display.Sprite;
	/**
	 * ...
	 * @author AldyAhsandin
	 */
	public class NeuralNetwork  {
		
		public var inputsNeurons:Array 	= new Array();
		public var hiddenNeurons:Array 	= new Array();
		public var outputNeurons:Array 	= new Array();
		
		public var wInputHidden:Array	= new Array();
		public var wHiddenOutput:Array	= new Array();
		
		public var nInput:int;
		public var nHidden:int;
		public var nOutput:int;
		
		/*===============*/
		/* Constructor   */
		/*===============*/
		
		/**
		 * Add Neural Network
		 * @param	_nInput input neuron total
		 * @param	_nHidden hidden neuron total
		 * @param	_nOutput output neuron total
		 */
		public function NeuralNetwork(_nInput:int, _nHidden:int, _nOutput:int ) {
			
			nInput	= _nInput;
			nHidden	= _nHidden;
			nOutput	= _nOutput;
			
			/*===============*/
			/* Create Neuron */
			/*===============*/
			
			//input layer + input bias
			for (var i:int = 0; i < _nInput; i++ ) inputsNeurons[i] = 0;
			inputsNeurons[_nInput] = -1;
				
			
			//hidden layer + hidden bias
			for (var h:int = 0; h < _nHidden; h++ )hiddenNeurons[h] = 0;
			hiddenNeurons[_nHidden] = -1;
			
			
			//Output layer
			for (var o:int = 0; o < _nOutput; o++ )outputNeurons[o] = 0;
			
			
			
			
			/*===============*/
			/* Create Weight */
			/*===============*/
			//var _jumlah:int =0;
			for (var i:int = 0; i <= _nInput; i++ ){
				wInputHidden[i] = new Array();
				for (var h:int = 0; h < _nHidden ; h++ ) {
				 	wInputHidden[i][h] = 0;
					//_jumlah++;
				}
			}
			
			for (var h:int = 0; h <= _nHidden ; h++ ){ 
				wHiddenOutput[h] = new Array();
				for (var o:int = 0; o < _nOutput ; o++ ) {
					wHiddenOutput[h][o] = 0;
					//_jumlah++;
				}
			}
			//trace(_jumlah);
			initializeWeight();
		}
		public function initializeWeight(_data:Object = null ):void {
			
			var _upperbound	:Number = 2;
			var _lowerbound	:Number = -2;
			
			var _rH			:Number	= 1 / Math.sqrt(nInput);
			var _rO			:Number	= 1 / Math.sqrt(nHidden);
			var _index		:int	= 0;
			
			for (var i:int = 0; i <= nInput; i++ ){
				wInputHidden[i] = new Array();
				for (var h:int = 0; h < nHidden ; h++ ) {
					if (_data) 	{ wInputHidden[i][h] = int(_data[_index] * 100)/100; /*trace(wInputHidden[i][h]);*/ }
					else	 	wInputHidden[i][h] = (Math.random() * 1) - 0.5;
					_index++
					
				}
			}
			for (var h:int = 0; h <= nHidden ; h++ ){ 
				wHiddenOutput[h] = new Array();
				for (var o:int = 0; o < nOutput ; o++ ) {
				if (_data)	{ wHiddenOutput[h][o] =int( _data[_index] * 100)/100; /*trace(wHiddenOutput[h][o]);*/ }
					else 		wHiddenOutput[h][o] = (Math.random() * 1) - 0.5;
					_index++;
					
				}
			}
		}
		
		/*===============*/
		/* Private Method*/
		/*===============*/
		
		/**
		 * Random data
		 * @param	_upperbound
		 * @param	_lowerbound
		 * @return Number
		 */
		private function randomWeight(_upperbound:Number, _lowerbound:Number):Number {
			var _weight:Number	= Math.random() * (_upperbound - _lowerbound + 1) + _lowerbound;
			//trace(_weight);
			return _weight;
		}
		
		/**
		 * Activation Function -Sigmoid-
		 * @param	x
		 * @return Number
		 */
		private function activationFunction(_x: Number):Number {
			return 1 / (1 + Math.exp( - _x ) );
		}
		
		
		
		/**
		 * FeedForward
		 * @param	_inputs input data (array)
		 */
		private function feedForward(_inputs:Array) {
			//input
			//trace("Input")
			for (var i:int = 0; i < nInput; i++ ) {
				inputsNeurons[i] = _inputs[i];
				//trace("InputNeurons: "+inputsNeurons[i]);
			}
			
			//hidden
			//trace("HIDDEN")
			for (var h:int = 0; h < nHidden; h++ ) {
				
				hiddenNeurons[h] = 0;
				for (var i:int = 0; i <= nInput; i++) {
					hiddenNeurons[h] += inputsNeurons[i] * wInputHidden[i][h];
				}
				hiddenNeurons[h] = activationFunction(hiddenNeurons[h]);
				
			}
			
			//Output
			//trace("OUTPUT")
			for (var o:int = 0; o < nOutput; o++ ) {
				
				outputNeurons[o] = 0;
				for (var h:int = 0; h <= nHidden; h++) {
					outputNeurons[o] += hiddenNeurons[h] * wHiddenOutput[h][o];
				}
				//LogError.doSave("[BEFORE] OutputNeurons["+o+"]", outputNeurons[o] );
				outputNeurons[o] = activationFunction(outputNeurons[o]);
				
			}
			
		}
		
		
		/*===============*/
		/* Public Method */
		/*===============*/
		
		
		/**
		 * Feedforward with filtering data
		 * @param	_inputs
		 * @return
		 */
		public function feedForwardPattern(_inputs:Array):Array {
			
			var _result:Array = new Array();
			feedForward(_inputs);
			
			//copy result from output neurons
			for (var o:int = 0; o < nOutput; o++ ) {
				_result[o] = clampOutput( outputNeurons[o] );
			}
			return _result
		}
	
	
		/**
		 * Return the NN accuracy on the set
		 * @param	_dataset
		 * @return
		 */
		public function getSetAccuracy(_dataset:Vector.<DataEntry>):Number {
			
			
			var _incorrectResult:Number = 0.0;
			
			//every training input
			for (var tp:int = 0;  tp < _dataset.length; tp++ ) {
				
				var _data:DataEntry 		= _dataset[tp];
				var _correctResult:Boolean 	= true;
				
				
				feedForward( _data.pattern);
				//check desired output
				for (var o:int = 0; o < nOutput; o++ ) 
					if (Math.abs(clampOutput(outputNeurons[o]) - _data.target[o])>0.2) 
						_correctResult = false;
				
				if (!_correctResult) _incorrectResult++;
			}
			
			
			//calculate and return as percentage
			return 100 - ( ( _incorrectResult / _dataset.length ) * 100);
		}
		
		
		/**
		 * Return the NN mean squared error on the set
		 * @param	_dataset
		 * @return
		 */
		public function getSetMSE(_dataset:Vector.<DataEntry>):Number {
			
			var MSE:Number = 0.0;
			
			//every training input
			for (var tp:int = 0;  tp < _dataset.length; tp++ ) {
				
				var _data:DataEntry = _dataset[tp];
				feedForward(_data.pattern);
				for (var o:int = 0; o < nOutput; o++ ) 
					MSE += Math.pow( outputNeurons[o] - _data.target[o], 2);
			}
			
			return MSE / ( nOutput * _dataset.length );
		}
		
		/**
		 * Clamp function/ Filter function
		 * @param	_x
		 * @return
		 */
		public function clampOutput(_x: Number):Number {
			//trace("> Output: ", _x);
			if (_x < 0.05) return 0;
			else if (_x > 0.95) return 1;
			else return int(_x * 100)/100;
		}
		
		public function saveDataWeight()
		{
			SaveToFile.openStream("weight");
			var _index:int = 0;
			for (var i:int = 0; i <= nInput; i++ ){
				for (var h:int = 0; h < nHidden ; h++ ) {
					SaveToFile.saveByColumn("new wInputHidden[" + i + "][" + h + "]", wInputHidden[i][h], _index );
					_index++;
				}
			}
			
			for (var h:int = 0; h <= nHidden ; h++ ){ 
				for (var o:int = 0; o < nOutput ; o++ ) {
					SaveToFile.saveByColumn("new wHiddenOutputHidden[" + h + "][" + o + "]", wHiddenOutput[h][o], _index );
					_index++
				}
			}
			trace("Index Total: "+_index);
			SaveToFile.closeStream();
		}	
	}

}