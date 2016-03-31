package
{
	import flash.display.Sprite;
		
	public class Program extends Sprite
	{
		public function Program()
		{
			trace("\n <Player Matching System by Score>");
						
			var system:MatchingSystem = new MatchingSystem();

			if (!system.Initialize())
			{
				return;
			}
			
			system.MatchByScore();
		}		
	}
}