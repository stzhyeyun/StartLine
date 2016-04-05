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
		private var _background:Quad = new Quad(
			Starling.current.nativeStage.stageWidth,
			Starling.current.nativeStage.stageHeight,
			Color.TEAL);		
		private var _windows:Vector.<Window> = new Vector.<Window>();
		
		public function Main()
		{
			// 이미지 리소스 로드
			//TextureManager.getInstance().initialize();			
			
			// 이벤트 등록
			addEventListener(TouchEvent.TOUCH, onMouseAction);
			NativeApplication.nativeApplication.addEventListener(Event.EXITING, onExit);
			
			// 배경
			addChild(_background);
			
			// 그리기
			
			
			// 테스트
			
			
						
		}
		
		private function createWindow(position:Point):void
		{
			_windows.push(new Window(this, null, position));
		}
		
		private function removeChild(child:Window):void
		{
			for (var i:int = 0; i< _windows.length; i++)
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
			
			if (action != null)
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
			for (var i:int = 0; i < _windows.length; i++)
			{
				_windows.shift().dispose();
			}
			
			// 텍스처 매니저 삭제
			//TextureManager.getInstance().dispose();
			
 			removeEventListener(TouchEvent.TOUCH, onMouseAction);
			NativeApplication.nativeApplication.removeEventListener(Event.EXITING, onExit);
			dispose();
		}		
	}
}