package
{
	public class Group
	{
		private var _id:int = -1;
		private var _member:Vector.<User> = new Vector.<User>();
		
		public function Group(id:int)
		{
			_id = id;
		}
		
		public function GetNear(score:int, numRequired:int, numRemaining:Int):Vector.<User>
		{
			// Set Diff
			for (var i:int = 0; i < _member.length; i++)
			{
				_member[i].Diff = Math.abs(score - _member[i].Score);
			}
			
			// Sort by Diff
			_member.sort(CompareDiffForAscendingSort);
			
			// Pick results out
			var result:Vector.<User> = new Vector.<User>();
			for (i = 0; i < _member.length; i++)
			{
				if (i == numRequired)
					break;
				
				result.push(_member[i]);
			}
			
			// Sort by Score (Reset)
			_member.sort(CompareScoreForAscendingSort);
			
			numRemaining.Value = numRequired - result.length;
			return result;
		}
		
		public function GetTop(numRequired:int, numRemaining:Int):Vector.<User>
		{
			var result:Vector.<User> = new Vector.<User>();
			
			for (var i:int = 0; i < _member.length; i++)
			{
				if (i == numRequired)
					break;
				
				result.push(_member[i]);
			}
			
			numRemaining.Value = numRequired - result.length;
			return result;
		}
		
		public function GetBottom(numRequired:int, numRemaining:Int):Vector.<User>
		{
			var result:Vector.<User> = new Vector.<User>();
			
			var j:int = 0;
			for (var i:int = _member.length - 1; i >= 0; i--)
			{
				if (j == numRequired)
					break;
				
				result.push(_member[i]);
				j++;
			}
			
			numRemaining.Value = numRequired - result.length;
			return result;
		}
		
		public function PushOneUser(newOne:User):void
		{
			if (newOne)
			{
				_member.push(newOne);
			}
		}
		
		public function PushUsers(newOne:Vector.<User>):void
		{
			if (newOne)
			{
				for (var i:int = 0; i < newOne.length; i++)
				{
					_member.push(newOne[i]);
				}				
			}
		}
		
		public function Count():int
		{
			return _member.length;
		}
		
		public function Sort():void
		{
			_member.sort(CompareScoreForAscendingSort);
		}
		
		public function Print():void
		{
			trace(
				"\n > Matched group : ", _id, " (", _member.length, " players)");
			
			for (var i:int = 0; i < _member.length; i++)
			{
				_member[i].Print(i + 1);
			}
		}
		
		// Getter //////////
		
		public function get Id():int 
		{ 
			return _id; 
		} 
		
		// Comparer //////////
		
//		private function CompareIdForDescendingSort(x:Group, y:Group):int 
//		{ 
//			if (x.Id < y.Id) 
//			{ 
//				return 1; 
//			} 
//			else if (x.Id > y.Id) 
//			{ 
//				return -1; 
//			} 
//			else 
//			{ 
//				return 0; 
//			} 
//		} 
		
		private function CompareScoreForAscendingSort(x:User, y:User):int 
		{ 
			if (x.Score < y.Score) 
			{ 
				return -1; 
			} 
			else if (x.Score > y.Score) 
			{ 
				return 1; 
			} 
			else 
			{ 
				return 0; 
			} 
		} 
		
		private function CompareDiffForAscendingSort(x:User, y:User):int 
		{ 
			if (x.Diff < y.Diff) 
			{ 
				return -1; 
			} 
			else if (x.Diff > y.Diff) 
			{ 
				return 1; 
			} 
			else 
			{ 
				return 0; 
			} 
		} 
	}
}