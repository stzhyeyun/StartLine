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
		private var _windows:Vector.<Window>;
		
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
		
		private function createWindow(position:Point):void
		{
			if (!_windows)
			{
				_windows = new Vector.<Window>();
			}
			_windows.push(new Window(this, null, position));
		}
		
		private function removeChild(child:Window):void
		{
			for (var i:int = 0; i < _windows.length; i++)
			{
				if (_windows[i] == child)
				{
					_windows.removeAt(i);
				}
			}			
		}
		
		private function onMouseAction(event:TouchEvent):void
		{			
			var action:Touch = event.getTouch(this);
			
			if (action)
			{
				if (action.phase == TouchPhase.ENDED) // 클릭
				{
					createWindow(action.getLocation(this));
				}
			}
		}
		
		private function onExit(event:Event):void
		{
			// 윈도우 삭제
			if (_windows)
			{
				for (var i:int = 0; i < _windows.length; i++)
				{
					_windows.shift().dispose();
				}
			}
			
			// 텍스처 삭제
			SingletonAssetManager.getInstance().dispose();
			
 			removeEventListener(TouchEvent.TOUCH, onMouseAction);
			NativeApplication.nativeApplication.removeEventListener(Event.EXITING, onExit);
			dispose();
		}		
	}
}