package
{
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.geom.Point;
	
	import starling.core.Starling;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.Color;
	
	public class Main extends Sprite
	{
		private var _background:Quad
		
		public function Main()
		{
			// 이미지 리소스 로드
			SingletonAssetManager.getInstance().initialize("Resources");
			
			// 배경 세팅
			_background = new Quad(
				Starling.current.nativeStage.stageWidth,
				Starling.current.nativeStage.stageHeight,
				Color.TEAL);
			addChild(_background);
			
			// 이벤트 리스너 등록
			_background.addEventListener(TouchEvent.TOUCH, onClickBackground);
			NativeApplication.nativeApplication.addEventListener(Event.EXITING, onExit);
		}
		
		private function onClickBackground(event:TouchEvent):void
		{			
			var action:Touch = event.getTouch(this, TouchPhase.ENDED); // 클릭
			
			if (action)
			{
				var window:Window = new Window(action.getLocation(this));
				addChild(window);
			}
		}
		
		private function onExit(event:Event):void
		{
			// 배경 및 윈도우 삭제
			removeChildren();
			
			// 텍스처 삭제
			SingletonAssetManager.getInstance().dispose();
			
			// 이벤트 리스너 제거
			NativeApplication.nativeApplication.removeEventListener(Event.EXITING, onExit);
			dispose();
		}		
	}
}