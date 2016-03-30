package
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	public class Parser
	{
		public function ParseData(userList:Vector.<User>):Boolean
		{
			var data:File = File.applicationDirectory;
			data = data.resolvePath("Data.txt");
						
			if (data.exists())
			{
				var fileStream:FileStream = new FileStream();
				fileStream.open(data, FileMode.READ);
				
				var fileContents:String = fileStream.readUTFBytes(fileStream.bytesAvailable); // Read the contens of the 
				fileContents_txt.text = fileContents; // Display the contents. I've created a TextArea on the stage for display
				
				
				// Read Score
				// Read User Data
				
				
				
				
				fileStream.close(); // Clean up and close the file stream
			}
			else
			{
				
			}
			
			

			

			
			
			
			
			return true;	
		}
	}
}