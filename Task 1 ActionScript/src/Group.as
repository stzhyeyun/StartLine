package
{
	import flash.display.Stage;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	public class Group
	{
		private var _id:int = -1;
		private var _member:Vector.<User> = new Vector.<User>();
		
		public function Group(id:int)
		{
			_id = id;
		}
		
		/**
		 * 기준 점수와 가까운 점수를 가진 유저를 탐색하여 결과를 반환합니다.
		 * @param score 기준 점수입니다.
		 * @param numRequired 탐색 결과로서 얻고자 하는 유저의 수입니다.
		 * @return 해당하는 유저를 반환합니다.
		 * 
		 */
		public function GetNear(score:int, numRequired:int):Vector.<User>
		{
			// 점수차 계산
			for (var i:int = 0; i < _member.length; i++)
			{
				_member[i].Diff = Math.abs(score - _member[i].Score);
			}
			
			// 점수차 기준 정렬
			_member.sort(CompareDiffForAscendingSort);
			
			// 결과 선택
			var result:Vector.<User> = new Vector.<User>();
			for (i = 0; i < _member.length; i++)
			{
				if (i == numRequired)
					break;
				
				result.push(_member[i]);
			}
			
			// 점수 기준 정렬 (초기화)
			_member.sort(CompareScoreForAscendingSort);

			return result;
		}
		
		/**
		 * 일정 수의 유저를 점수가 높은 순으로 반환합니다.  
		 * @param numRequired 결과로서 얻고자 하는 유저의 수입니다.
		 * @return 해당하는 유저를 반환합니다.
		 * 
		 */
		public function GetTop(numRequired:int):Vector.<User>
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
			
			return result;
		}
		
		/**
		 * 일정 수의 유저를 점수가 낮은 순으로 반환합니다. 
		 * @param numRequired 결과로서 얻고자 하는 유저의 수입니다.
		 * @return 해당하는 유저를 반환합니다.
		 * 
		 */
		public function GetBottom(numRequired:int):Vector.<User>
		{
			var result:Vector.<User> = new Vector.<User>();
			
			for (var i:int = 0; i < _member.length; i++)
			{
				if (i == numRequired)
					break;
				
				result.push(_member[i]);
			}
			
			return result;
		}
			
		/**
		 * 한 명의 유저를 그룹에 추가합니다. 
		 * @param newOne 그룹에 추가할 유저입니다.
		 * 
		 */
		public function PushOneUser(newOne:User):void
		{
			if (newOne)
			{
				_member.push(newOne);
			}
		}
		
		/**
		 * 복수의 유저를 그룹에 추가합니다. 
		 * @param newOne 그룹에 추가할 유저입니다.
		 * 
		 */
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
		
		/**
		 * 그룹 내 유저를 점수 기준 오름차순으로 정렬합니다. 
		 * 
		 */
		public function Sort():void
		{
			_member.sort(CompareScoreForAscendingSort);
		}
		
		public function Print(stage:Stage, heightOfUpperField:Number):Number
		{
			var textField:TextField = new TextField(); 
			textField.autoSize = TextFieldAutoSize.LEFT;
			textField.y = heightOfUpperField;
			textField.text = "\n	> Matched group : " + _id + " (" + _member.length + " players)";
			stage.addChild(textField);
			
			var height:Number = heightOfUpperField + textField.height;
			
			for (var i:int = 0; i < _member.length; i++)
			{
				height = _member[i].Print(stage, height, i + 1);
			}
			
			return height;
		}
		
		// Getter //////////
		
		public function get Id():int 
		{ 
			return _id; 
		} 
		
		// Comparer //////////
		
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