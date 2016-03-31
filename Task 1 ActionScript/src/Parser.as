package
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	public class Parser
	{
		public function ParseData(myScore:Int, userList:Vector.<User>):Boolean
		{
			var file:File = File.applicationDirectory;
			file = file.resolvePath("Data.txt");
						
			if (file.exists)
			{
				var tempList:Vector.<User> = new Vector.<User>();
				
				try
				{
					var fileStream:FileStream = new FileStream();
					fileStream.open(file, FileMode.READ);
					
					// Read file
					var data:String = fileStream.readUTFBytes(fileStream.bytesAvailable);
										
					// Split Data into Lines
					var dataLines:Array = data.split("\r\n");
					
					// Parse Criterion score
					if (!ParseScore(dataLines.shift(), myScore))
					{						
						return false;
					}
					
					// Parse User Data 
					for each(var line:String in dataLines)
					{
						var userData:Array = line.split(',');						
						
						var user:User = new User(
							userData[0],
							userData[1],
							userData[2],
							userData[3],
							userData[4]);
						tempList.push(user);
					}
					
					fileStream.close();
				}
				catch (error:Error)
				{
					trace("\n Error : Data is invalid.");
					
					userList = null;
					return false;
				}
			
				userList = tempList;
				return true;
			}
			else
			{
				trace("\n Error : Data does not exist. (Valid path : {0})", file.toString());
				
				userList = null;
				return false;
			}			
		}
		
		public function ParseScore(input:String, score:Int):Boolean
		{
			if (input.search('-') != -1 || input == "0")
			{
				trace("\n Error : The value (" + input + ") is invalid.");
				
				score.Value = 0;
				return false;
			}
			
			var figure:String = new String();
			if (input.search(',') != -1 || input.search('.') != -1)
			{
				var temp:Array = input.split(/,|\./);
				
				for (var i:int = 1; i < temp.Length; i++)
				{
					if (temp[i].Length != 3)
					{
						trace("\n Error : The value (" + input + ") is invalid.");
						
						score.Value = 0;
						return false;
					}
				}
						
				for each (var element:String in temp)
				{
					figure += element;
				}
			}
			else
			{
				figure = input;
			}
			
			score.Value = int(figure);
			
			if (score.Value == 0)
			{
				trace("\n Error : The value (" + input + ") is invalid.");
				return false;
			}           
			else
			{
				return true;
			}
		}
	}
}