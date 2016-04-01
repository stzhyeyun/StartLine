package
{
	public class MatchingSystem
	{
		private const _numRequired:int = 5; // 탐색할 결과의 수
		
		private var _score:int = new int(0); // 탐색 기준 점수
		private var _userData:Vector.<Group> = new Vector.<Group>(11);
		
		/**
		 * 매칭 시스템을 초기화 (데이터 파싱, 유저 그룹핑) 합니다.
		 * @return 초기화  성공 여부를 반환합니다.
		 * 
		 */
		public function Initialize():Boolean
		{
			try
			{
				var parser:Parser = new Parser();
				var rawData:Vector.<User>;
				
				_score = parser.ParseData(rawData);
				GroupUsersByScore(rawData);
			}
			catch (error:*)
			{
				return false;
			}
			
			return true;
		}
		
		/**
		 * 데이터에서 파싱한 점수를 기준으로 가까운 점수를 가진 유저를 매칭합니다.
		 * 
		 */
		public function MatchByScore():void
		{
			var groupId:int = DetermineWhichGroup(_score);
			
			// 유효한 타겟 검색
			var targetId:int = groupId;
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
			
			// 매칭 시작...
			var matchedGroup:Vector.<Group> = new Vector.<Group>();
			var numRequired:int = _numRequired;
			var upperIndex:int = -1;
			var lowerIndex:int = -1;
			
			// 내 그룹 탐색
			if (targetId == groupId)
			{
				var tempUserList:Vector.<User> = _userData[targetId - 1].GetNear(_score, numRequired);
				numRequired -= tempUserList.length;
				
				var tempGroup:Group = new Group(targetId);
				tempGroup.PushUsers(tempUserList);
				matchedGroup.push(tempGroup);
				
				upperIndex = targetId;
				lowerIndex = targetId - 2;
			}
			else if (targetId > groupId)
			{
				upperIndex = targetId - 1;
				lowerIndex = groupId - 2;
			}
			else if (targetId < groupId)
			{
				lowerIndex = targetId - 1;
			}
			
			// 상위 & 하위 그룸 탑색
			var intermediateGroup:Group = new Group(0);
			if (numRequired != 0)
			{
				var requiredOfUpper:int = numRequired;
				var requiredOfLower:int = numRequired;
				
				while (requiredOfUpper != 0)
				{
					if (upperIndex == -1 || upperIndex >= _userData.length - 1 || !_userData[upperIndex])
						break;
					
					tempUserList = _userData[upperIndex].GetBottom(requiredOfUpper);
					numRequired -= tempUserList.length;
					
					intermediateGroup.PushUsers(tempUserList);
					
					upperIndex++;
				}
				
				while (requiredOfLower != 0)
				{
					if (lowerIndex < 0 || !_userData[lowerIndex])
						break;
					
					tempUserList = _userData[upperIndex].GetTop(requiredOfLower);
					numRequired -= tempUserList.length;
					
					intermediateGroup.PushUsers(tempUserList);
					
					lowerIndex--;
				}
			}
			
			// 결과 정리
			var temp:Vector.<Group> = GroupResultsByScore(
				intermediateGroup.GetNear(_score, numRequired));
			
			for (var i:int = 0; i < temp.length; i++)
			{
				matchedGroup.push(temp[i]);
			}
			
			// 결과 출력
			PrintResult(groupId, matchedGroup);
		}
		
		/**
		 * 점수 기준으로 유저를 그룹핑합니다.
		 * @param rawData 그룹핑되지 않은 유저 데이터입니다.
		 * 
		 */
		private function GroupUsersByScore(rawData:Vector.<User>):void // 유저 데이터 최초 그룹핑
		{
			for (var i:int = 0; i < rawData.length; i++)
			{
				PushUser(DetermineWhichGroup(rawData[i].Score), rawData[i]);
			}
			
			// 각 그룹 내 유저를 점수 기준 오름차순으로 정렬
			for each (var group:Group in _userData)
			{
				if (group != null)
				{
					group.Sort();
				}
			}
		}
		
		/**
		 * 점수 기준으로 유저를 그룹핑하고 결과를 반환합니다.
		 * @param rawData 그룹핑되지 않은 유저 데이터입니다.
		 * @return 그룹핑 결과를 반환합니다.
		 * 
		 */
		private function GroupResultsByScore(rawData:Vector.<User>):Vector.<Group> // 매칭된 유저 그룹핑
		{
			var groupId:int = 0;
			var doesExist:Boolean = false;
			var result:Vector.<Group> = new Vector.<Group>();
			
			for (var i:int = 0; i < rawData.length; i++)
			{
				groupId = DetermineWhichGroup(rawData[i].Score);
				
				for (var j:int = 0; j < result.length; j++)
				{
					if (result[j].Id == groupId)
					{
						result[j].PushOneUser(rawData[i]);
						doesExist = true;
						break;
					}
				}
				
				if (!doesExist)
				{
					var group:Group = new Group(groupId);
					group.PushOneUser(rawData[i]);
					result.push(group);
				}
				doesExist = false;                
			}
			
			result.sort(CompareIdForDescendingSort); // 상위 그룹부터 출력하기 위해 그룹 ID 기준 내림차순 정렬
			return result;
		}
		
		/**
		 * 입력한 점수가 어떤 그룹에 속하는지 확인하고 결과를 반환합니다. 
		 * @param score 기준 접수입니다.
		 * @return 그룹 ID를 반환합니다.
		 * 
		 */
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
					var a:int = 0;
				}
				else
				{
					_userData[groupId - 1].PushOneUser(newOne);
				}                
			}
		}
		
		/**
		 * 매칭 결과를 콘솔에 출력합니다.
		 * @param groupId 기준 점수가 속하는 그룹의 ID입니다.
		 * @param result 매칭된 유저 데이터입니다.
		 * 
		 */
		private function PrintResult(groupId:int, result:Vector.<Group>):void
		{
			trace("\n======================================================================");
			trace("\n [Result]");
			trace("\n Your score : ", _score);
			trace("\n Your group : ", groupId);
			
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