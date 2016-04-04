package
{
	import starling.core.Starling;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.utils.Color;
		
	public class Main extends Sprite
	{
		// 로딩 후 Image를 가지고 있을 것
		
		private var _windows:Vector.<Window>;
		
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