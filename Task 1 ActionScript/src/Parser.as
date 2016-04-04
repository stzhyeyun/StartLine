package
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	public class Parser
	{
		/**
		 * 유저 데이터를 텍스트 파일로부터 읽어와 파싱하고 결과를 반환합니다.
		 * @param outUserData 파싱된 유저 데이터를 저장할 Vector입니다.
		 * @return 파싱된 점수를 반환합니다.
		 * 
		 */
		public function ParseData():Vector.<User>
		{
			var file:File = File.applicationDirectory.resolvePath("Data.txt");
						
			if (file.exists)
			{
				var result:Vector.<User> = new Vector.<User>();
				
				try
				{
					var fileStream:FileStream = new FileStream();
					fileStream.open(file, FileMode.READ);
					
					// 파일 리딩
					var data:String = fileStream.readUTFBytes(fileStream.bytesAvailable);
										
					// 줄 단위로 나눔
					var dataLines:Array = data.split("\r\n");
					
					// 유저 데이터 파싱
					for each(var line:String in dataLines)
					{
						var tempUserData:Array = line.split(',');						
						
						var user:User = new User(
							tempUserData[0],
							tempUserData[1],
							tempUserData[2],
							tempUserData[3],
							tempUserData[4]);
						
						result.push(user);
					}
					
					fileStream.close();
				}
				catch (error:*)
				{
					trace("\n Error : Data is invalid.");
					
					fileStream.close();
					return null;
				}
			
				return result;
			}
			else
			{
				trace("\n Error : Data does not exist. (Valid path : ", file.toString(), ")");
				
				return null;
			}			
		}
		
		/**
		 * 점수 데이터를 파싱하여 결과를 반환합니다. 
		 * @param input 파싱할 점수 데이터입니다.
		 * @return 파싱 결과를 int형으로 반환합니다. 점수 데이터가 유효하지 않을 경우 0을 반환합니다.
		 * 
		 */
		public function ParseScore(input:String):int
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
			
			// 문자 필터
			if (score == 0)
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