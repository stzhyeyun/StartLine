package
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	public class Parser
	{
		public function ParseData(myScore:Int):Vector.<User>
		{
			var file:File = File.applicationDirectory;
			file = file.resolvePath("Data.txt");
						
			if (file.exists)
			{
				var userList:Vector.<User> = new Vector.<User>();
				
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
						return null;
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
						userList.push(user);
					}
					
					fileStream.close();
				}
				catch (error:*)
				{
					trace("\n Error : Data is invalid.");
					
					return null;
				}
			
				return userList;
			}
			else
			{
				trace("\n Error : Data does not exist. (Valid path : {0})", file.toString());
				
				return null;
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
			if (input.search(/,/) != -1 || input.search(/\./) != -1)
			{
				var temp:Array = input.split(/,|\./);
				
				for each (var element:String in temp)
				{
					if (element.length != 3)
					{
						trace("\n Error : The value (" + input + ") is invalid.");
						
						score.Value = 0;
						return false;
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