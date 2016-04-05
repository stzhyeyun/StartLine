package
{
	import starling.core.Starling;
	import starling.display.Quad;
	import starling.display.Sprite;
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
			loadImage();			
			
			// 배경 세팅
			var background:Quad = new Quad(
				Starling.current.nativeStage.stageWidth,
				Starling.current.nativeStage.stageHeight,
				Color.TEAL);
			addChild(background);
			
			// 그리기
		}
		
		public function createWindow():void
		{
			
		}
		
		private function loadImage():void
		{
			var loader:Loader = new Loader();
			
			// 윈도우 이미지 에셋을 각각 로드 후 텍스처 -> 이미지 형태로 저장
		}
	}
}