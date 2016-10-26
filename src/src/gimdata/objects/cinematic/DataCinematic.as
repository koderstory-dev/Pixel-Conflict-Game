package gimdata.objects.cinematic 
{
	/**
	 * ...
	 * @author ...
	 */
	public class DataCinematic 
	{
		private var mCategory	:String;
		private var mType		:int;
		private var mBg			:int;
		private var mCurrHP		:int;
		private var mNextHP		:int;
		private var mPos		:String;
		private var mUnits		:Array;
		
		
		public function setCategory(_value:String) { mCategory = _value; }
		public function setType(_value:int) { mType = _value; }
		public function setBg(_value:int) { mBg = _value; }
		public function setCurrHP(_value:int) { mCurrHP = _value; }
		public function setNextHP(_value:int) { mNextHP = _value; }
		public function setPos(_value:String) { mPos = _value; }
		public function set units(_value:Array) { mUnits = _value;
			for (var i:int = 0; i < mUnits.length; i++) {
				mUnits[i].restart();
			}
		}
		
		
		public function get category():String { return mCategory; }
		public function get type():int { return mType; }
		public function get bg():int { return mBg; }
		public function get currHP():int { return mCurrHP; }
		public function get nextHP():int { return mNextHP; }
		public function get pos():String { return mPos; }
		public function get units():Array { return mUnits; }
		
	}

}