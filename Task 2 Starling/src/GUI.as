package
{
	import flash.display.Sprite;
	import starling.core.Starling;
	
	[SWF(width="400", height="300", frameRate="60", backgroundColor="#000000")]
	
	public class GUI extends Sprite
	{
		private var _main:Starling;
		
		public function GUI()
		{
			// 스탈링 생성 및 시작
			_main = new Starling(Main, stage);
			_main.start();
						
			//_main.dispose();
		}
	}
}