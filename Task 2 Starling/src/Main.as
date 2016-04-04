package
{
	import starling.core.Starling;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.utils.Color;
		
	public class Main extends Sprite
	{
		public function Main()
		{
			// NOTE @hyeyun 배경
			var background:Quad = new Quad(
				Starling.current.nativeStage.stageWidth,
				Starling.current.nativeStage.stageHeight,
				Color.TEAL);
			addChild(background);
			
			
			
		}
	}
}