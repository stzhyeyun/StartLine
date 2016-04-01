package
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	public class Parser
	{
		public function ParseData(userList:Vector.<User>):int // return score
		{
			var file:File = File.applicationDirectory.resolvePath("Data.txt");
						
			if (file.exists)
			{
				try
				{
					var fileStream:FileStream = new FileStream();
					fileStream.open(file, FileMode.READ);
					
					// 파일 리딩
					var data:String = fileStream.readUTFBytes(fileStream.bytesAvailable);
										
					// 줄 단위로 나눔
					var dataLines:Array = data.split("\r\n");
					
					// 점수 파싱
					var score:int = ParseScore(dataLines.shift());
					
					// 유저 데이터 파싱
					for each(var line:String in dataLines)
					{
						var userData:Array = line.split(',');						
						
						var user:User = new User(
							userData[0],
							userData[1],
							userData[2],
							userData[3],
							userData[4]);
						
						userList.push(user);
					}
					
					fileStream.close();
				}
				catch (error:*)
				{
					trace("\n Error : Data is invalid.");
					
					fileStream.close();
					return 0;
				}
			
				return score;
			}
			else
			{
				trace("\n Error : Data does not exist. (Valid path : ", file.toString(), ")");
				
				return score;
			}			
		}
		
		public function ParseScore(input:String):int // return 0: 유효하지 않은 점수 데이터
		{
			var score:int = 0;
			
			// 공란 제거
			input = input.replace(/\s/g, '');
			
			// 음수, 0 필터
			if (input.search('-') != -1 || input == "0")
			{
				trace("\n Error : The value (" + input + ") is invalid.");
				
				return 0;
			}
			
			// 구두점이 있을 경우 유효한 자리수인지 검사
			var figure:String = new String();
			if (input.search(/,/) != -1 || input.search(/\./) != -1)
			{
				var temp:Array = input.split(/,|\./);
				
				for each (var element:String in temp)
				{
					if (element.length != 3)
					{
						trace("\n Error : The value (" + input + ") is invalid.");
						
						return 0;
					}
				}
						
				for each (element in temp)
				{
					figure += element;
				}
			}
			else
			{
				figure = input;
			}
			
			score = int(figure);
			
			if (score == 0) // 문자 필터
			{
				trace("\n Error : The value (" + input + ") is invalid.");
				
				return 0;
			}           
			else
			{
				return score;
			}
		}
	}
}