package
{
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	
	import starling.core.Starling;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.Color;

	
	public class Main extends Sprite
	{
		private var _background:Quad;
		
		public function Main()
		{
			// 텍스처 로드
            try {
                TextureManager.getInstance().enqueue("Resources/titleBar.png");
                TextureManager.getInstance().enqueue("Resources/minimize.png");
                TextureManager.getInstance().enqueue("Resources/revert.png");
                TextureManager.getInstance().enqueue("Resources/close.png");
                TextureManager.getInstance().enqueue("Resources/contents.png", true);    
            } catch (e:Error) {
                trace(e.message);
            }
					
			
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
		
		/**
		 * 터치 이벤트 발생 시 새로운 윈도우를 생성합니다. 
		 * @param event 터치 이벤트입니다. 
		 * 
		 */
		private function onClickBackground(event:TouchEvent):void
		{			
			var action:Touch = event.getTouch(this, TouchPhase.ENDED); // 클릭
			
			if (action)
			{
				var window:Window = new Window(true, action.getLocation(this));
				addChild(window);
			}
		}
		
		/**
		 * SWF 종료 시 사용한 리소스를 해제합니다.
		 * @param event 종료 이벤트입니다.
		 * 
		 */
		private function onExit(event:Event):void
		{
			// 배경 및 윈도우 삭제
			removeChildren();
			
            try {
                // 텍스처 삭제
                TextureManager.getInstance().dispose();    
            } catch (e:Error) {
                trace(e.message);
            }
			
			// 이벤트 리스너 제거
			NativeApplication.nativeApplication.removeEventListener(Event.EXITING, onExit);
			
			dispose();
		}
	}
}