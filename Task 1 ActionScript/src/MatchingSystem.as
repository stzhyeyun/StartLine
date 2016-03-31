package
{
	public class MatchingSystem
	{
		private const _numRequired:int = 5;
		
		private var _score:Int = new Int(0);
		private var _userData:Vector.<Group> = new Vector.<Group>(11);
		
		public function Initialize():Boolean
		{
			var parser:Parser = new Parser();
			var rawData:Vector.<User> = null;
			
			return parser.ParseData(_score, rawData);
		}
		
		public function MatchByScore():void
		{
			var myGroupId:int = DetermineWhichGroup(_score.Value);
			
			// Find valid target
			var targetId:int = myGroupId;
			var isCheckedGroup11:Boolean = false;
			
			while (!_userData[targetId - 1])
			{
				if (targetId == 11)
				{
					isCheckedGroup11 = true;
				}
				else if (targetId == 1)
				{
					trace("\n Error : User data does not exist.");
					return;
				}
				
				if (isCheckedGroup11)
				{
					targetId--;
				}
				else
				{
					targetId++;
				}
			}
			
			// Start matching
			var matchedGroup:Vector.<Group> = new Vector.<Group>();
			var numRequired:Int = new Int(_numRequired);
			var upperIndex:int = -1;
			var lowerIndex:int = -1;
			
			// My group
			if (targetId == myGroupId)
			{
				var myGroup:Group = new Group(targetId);
				myGroup.PushUsers(_userData[targetId - 1].GetNear(_score, numRequired, numRequired));
				matchedGroup.push(myGroup);
				
				upperIndex = targetId;
				lowerIndex = targetId - 2;
			}
			else if (targetId > myGroupId)
			{
				upperIndex = targetId - 1;
				lowerIndex = myGroupId - 2;
			}
			else if (targetId < myGroupId)
			{
				lowerIndex = targetId - 1;
			}
			
			// Upper & Lower group
			var intermediateGroup:Group = new Group(0);
			if (numRequired.Value != 0)
			{
				var requiredOfUpper:Int = new Int(numRequired.Value);
				var requiredOfLower:Int = new Int(numRequired.Value);
				
				while (requiredOfUpper.Value != 0)
				{
					if (upperIndex == -1 || upperIndex >= _userData.length - 1)
						break;
					
					intermediateGroup.PushUsers(
						_userData[upperIndex].GetBottom(requiredOfUpper.Value, requiredOfUpper));
					
					upperIndex++;
				}
				
				while (requiredOfLower.Value != 0)
				{
					if (lowerIndex < 0)
						break;
					
					intermediateGroup.PushUsers(
						_userData[lowerIndex].GetTop(requiredOfLower.Value, requiredOfLower));
					
					lowerIndex--;
				}
			}
			
			// Set results
			var temp:Vector.<Group> = new Vector.<Group>();
			GroupResultsByScore(
				intermediateGroup.GetNear(_score.Value, numRequired.Value, numRequired),
				temp);
			
			for (var i:int = 0; i < temp.length; i++)
			{
				matchedGroup.push(temp[i]);
			}
			
			// Print results
			PrintResult(myGroupId, matchedGroup);
		}
		
		private function GroupUsersByScore(rawData:Vector.<User>):void
		{
			// Group Users by Score
			for (var i:int = 0; i < rawData.length; i++)
			{
				PushUser(
					DetermineWhichGroup(rawData[i].Score),
					rawData[i]);
			}
			
			// Users in Group -> Order by Score ascending
//			foreach (Group group in _userData.Values)
//			{
//				group.Sort();
//			}    
		}
		
		private function GroupResultsByScore(rawData:Vector.<User>, result:Vector.<Group>):void
		{
			var groupId:int = 0;
			var doesExist:Boolean = false;
			var temp:Vector.<Group> = new Vector.<Group>();
			
			for (var i:int = 0; i < rawData.length; i++)
			{
				groupId = DetermineWhichGroup(rawData[i].Score);
				
				for (var j:int = 0; j < temp.length; j++)
				{
					if (temp[j].Id == groupId)
					{
						temp[j].PushOneUser(rawData[i]);
						doesExist = true;
						break;
					}
				}
				
				if (!doesExist)
				{
					var group:Group = new Group(groupId);
					group.PushOneUser(rawData[i]);
					temp.push(group);
				}
				doesExist = false;                
			}
			
			temp.sort(CompareIdForDescendingSort);
			result = temp;
		}
		
		private function DetermineWhichGroup(score:int):int
		{
			return Math.min(Math.ceil(score / 100000), 11);
		}
		
		private function PushUser(groupId:int, newOne:User):void
		{
			if (newOne)
			{
				if (!_userData[groupId - 1])
				{
					var group:Group = new Group(groupId);
					group.PushOneUser(newOne);
					_userData[groupId - 1] = group;
				}
				else
				{
					_userData[groupId - 1].PushOneUser(newOne);
				}                
			}
		}
		
		private function PrintResult(myGroupId:int, result:Vector.<Group>):void
		{
			trace("\n======================================================================");
			trace("\n [Result]");
			trace("\n Your group : " + myGroupId);
			
			for (var i:int = 0; i < result.length; i++)
			{
				result[i].Print();
			}
			
			trace("\n======================================================================");
		}	
		
		// Comparer //////////
		
		private function CompareIdForDescendingSort(x:Group, y:Group):int 
		{ 
			if (x.Id < y.Id) 
			{ 
				return 1; 
			} 
			else if (x.Id > y.Id) 
			{ 
				return -1; 
			} 
			else 
			{ 
				return 0; 
			} 
		}
	}
}