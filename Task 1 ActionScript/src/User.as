package
{
	public class User
	{
		private var _id:int = -1;
		private var _name:String = null;
		private var _score:int = 0;
		private var _numWin:int = 0;
		private var _numDefeat:int = 0;
		private var _diff:int = 0;
		
		public function User(id:int, name:String, score:int, numWin:int, numDefeat:int)
		{
			_id = id;
			_name = name;
			_score = score;
			_numWin = numWin;
			_numDefeat = numDefeat;
		}
		
		public function Print(num:int):void
		{
			trace("  - User ", num,
				" (ID : ", _id,
				", Name : ", _name,
				", Score : ", _score,
				", Win : ", _numWin,
				", Defeat : ", _numDefeat, ")");
		}
		
		// Getter & Setter //////////
		
		public function get Score():int 
		{ 
			return _score; 
		} 
		
		public function get Diff():int 
		{ 
			return _diff; 
		} 
		
		public function set Diff(value:int):void 
		{ 
			_diff = value; 
		} 
	}
}