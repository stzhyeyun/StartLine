package
{
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.utils.Color;
		
	public class Main extends Sprite
	{
		public function Main()
		{
			// NOTE @hyeyun 배경
			var background:Quad = new Quad(200, 200, Color.TEAL);
			background.x = 100;
			background.y = 50;
			addChild(background);
			
			
			
		}
	}
}