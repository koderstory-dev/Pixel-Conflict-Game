package al.misc 
{
	/**
	 * ...
	 * @author Aldy Ahsandin
	 */
	public class Show 
	{
		
		//----------------------------
		// Private Method
		//----------------------------
		
		private static function convertMinus_int(_value:int):String
		{
			
			if (_value < 0)
				return "___";
			else
				return String(int(_value).toFixed(1));
		}
		
		private static function convertMinus_num(_value:Number):String
		{
			
			if (_value <= 0)
				return "___";
			else
				return String(Number(_value).toFixed(1));
		}
		
		private static function convertZero_int(_value:int):String
		{
			
			if (_value == 0)
				return "____";
			else if (_value > 0)
				return String(" "+Number(_value).toFixed(1));
			else
				return String(Number(_value).toFixed(1));
		}
		
		private static function convertZero_num(_value:Number):String
		{
			
			if (_value == 0)
				return "____";
			else if (_value > 0)
				return String(" "+Number(_value).toFixed(1));
			else
				return String(Number(_value).toFixed(1));
		}
		
		
		//----------------------------
		// Public Method
		//----------------------------
		
		/**
		 * Menampilkan data vector<int> dalam bentuk kotak
		 * Nilai negatif akan diubah menjadi ---
		 * @param	_data
		 * @param	_width
		 * @param	_height
		 */
		public static function square_negatif(_detail:String, _data:Vector.<int>, _width:int, _height:int)
		{
			
			trace("==============================================")	
			trace("  " + _detail);	
			trace("==============================================")	
			
			for (var _y:int = 0; _y < (_height * _width); _y += _width ) {
				var _text:String="";
				for (var _x:int = 0; _x < _width; _x++ ) {
					_text += convertMinus_int(_data[_y + _x]) + " ";
				}
				trace(_text);
				
			}
			trace("\n\n")	
		}
		
		/**
		 * Menampilkan data vector<Number> dalam bentuk kotak
		 * Nilai negatif akan diubah menjadi --- 
		 * @param	_data
		 * @param	_width
		 * @param	_height
		 * @param	_startPoint
		 * @param	_queue
		 */
		public static function squareNum_negatif(_detail:String, _data:Vector.<Number>, _width:int, _height:int, _startPoint:int=0, _queue:int=1)
		{
			trace("==============================================")	
			trace("  " + _detail);
			trace("==============================================")	
			
			for (var _y:int = 0; _y < (_height * _width); _y += _width ) {
				var _text:String="";
				for (var _x:int = 0; _x < _width; _x++ ) {
					_text += convertMinus_num(_data[_y + _x]) + " ";
				}
				trace(_text);
				
			}
			trace("\n\n")	
		}
		
		/**
		 * Menampilkan data vector<int> dalam bentuk kotak
		 * Nilai 0 akan diubah menjadi --- 
		 * @param	_data
		 * @param	_width
		 * @param	_height
		 * @param	_startPoint
		 * @param	_queue
		 */
		public static function square_zero(_detail:String, _data:Vector.<int>, _width:int, _height:int, _startPoint:int=0, _queue:int=1)
		{
			trace("==============================================")	
			trace("  " + _detail);
			trace("==============================================")	
			
			for (var _y:int = 0; _y < (_height * _width); _y += _width ) {
				var _text:String="";
				for (var _x:int = 0; _x < _width; _x++ ) {
					_text += convertZero_int(_data[_y + _x]) + " ";
				}
				trace(_text);
				
			}
			trace("\n\n")	
		}
		
		/**
		 * Menampilkan data vector<Number> dalam bentuk kotak
		 * Nilai 0 akan diubah menjadi ---
		 * @param	_data
		 * @param	_width
		 * @param	_height
		 * @param	_startPoint
		 * @param	_queue
		 */
		public static function squareNum_zero(_detail:String, _data:Vector.<Number>, _width:int, _height:int)
		{
			trace("==============================================")	
			trace("  " + _detail);
			trace("==============================================")	
			
			for (var _y:int = 0; _y < (_height * _width); _y += _width ) {
				var _text:String="";
				for (var _x:int = 0; _x < _width; _x++ ) {
					_text += convertZero_num(_data[_y + _x]) + " ";
				}
				trace(_text);
			}
			trace("\n\n")	
		}
		
		
		
	}

}