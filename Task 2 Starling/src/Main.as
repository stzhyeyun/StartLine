package
{
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.geom.Point;
	import starling.core.Starling;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.TouchEvent;
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
		
		private function loadImage():void
		{
			var loader:Loader = new Loader();
			
			// 윈도우 이미지 에셋을 각각 로드 후 텍스처 -> 이미지 형태로 저장
		}
	}
}