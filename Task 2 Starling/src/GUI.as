package
{
	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.events.Event;
	import starling.core.Starling;
	import starling.events.TouchPhase;
	
	[SWF(width="400", height="300", frameRate="60", backgroundColor="#000000")]
	public class GUI extends Sprite
	{
		private var _main:Starling;
		
		public function GUI()
		{
			// 스탈링 생성
			_main = new Starling(Main, stage);
			
			// 이벤트 등록			
			_main.addEventListener(TouchPhase.BEGAN, onMouseDown);
			_main.addEventListener(TouchPhase.ENDED, onMouseUp);
			_main.addEventListener(TouchPhase.MOVED, onMouseMove);
			NativeApplication.nativeApplication.addEventListener(Event.EXITING, onExit);
			
			// 스탈링 시작
			_main.start();			
		}
		
		private function onMouseDown(event:TouchPhase):void
		{
			
		}
		
		private function onMouseUp(event:TouchPhase):void
		{
			
		}
		
		private function onMouseMove(event:TouchPhase):void
		{
			// 윈도우 이동
		}
		
		private function onExit(event:Event):void
		{
			_main.removeEventListener(TouchPhase.BEGAN, onMouseDown);
			_main.removeEventListener(TouchPhase.ENDED, onMouseUp);
			_main.removeEventListener(TouchPhase.MOVED, onMouseMove);
			NativeApplication.nativeApplication.removeEventListener(Event.EXITING, onExit);
		}
	}
}