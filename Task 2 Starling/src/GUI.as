package
{
	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import starling.core.Starling;
	
	[SWF(width="1280", height="720", frameRate="60", backgroundColor="#000000")]
	
	public class GUI extends Sprite
	{
		private var _main:Starling;
		
		public function GUI()
		{
			// 스탈링 생성 및 시작
			_main = new Starling(Main, stage);
			_main.start();
			
			NativeApplication.nativeApplication.addEventListener(Event.EXITING, onExit);
		}
		
		private function onExit(event:Event):void
		{
			this.removeEventListener(Event.EXITING, onExit);
			_main.dispose();
		}	
	}
}