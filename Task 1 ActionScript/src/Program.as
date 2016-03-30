package
{
	import flash.display.Sprite;
		
	public class Program extends Sprite
	{
		private var parser:Parser = new Parser();
		
		public function Program()
		{
			trace("\n <Player Matching System by Score>");
			
			var system:MatchingSystem = new MatchingSystem();
			
			if (!system.Initialize())
			{
				return;
			}
			else
			{
				system.MatchByScore();
			}
		}
	}
}