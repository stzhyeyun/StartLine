package
{
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;

	public class Program extends Sprite
	{
		private var system:MatchingSystem = new MatchingSystem();
		
		private var titleField:TextField = new TextField(); 
		private var scoreField:TextField = new TextField();
		private var resultField:TextField = new TextField();
		
		public function Program()
		{
			// 매칭시스템 초기화	
			if (!system.Initialize(this))
			{
				return;
			}
			
			// 텍스트필드 초기화
			CreateTextField();
		}
		
		private function CreateTextField():void 
		{ 
			// titleField
			titleField.autoSize = TextFieldAutoSize.LEFT;
			titleField.text = "\n	<Player Matching System by Score>";
			addChild(titleField);
			
			// scoreField
			scoreField.type = TextFieldType.INPUT; 
			scoreField.y = titleField.height;
			scoreField.text = "\n	Input score here.";
			scoreField.addEventListener(KeyboardEvent.KEY_DOWN, TextInputCapture);
			addChild(scoreField);
		} 
		
		private function TextInputCapture(event:KeyboardEvent):void 
		{ 
			if(event.charCode == 13) // Enter
			{
				var parser:Parser = new Parser();
				system.MatchByScore(parser.ParseScore(scoreField.text));
				system.PrintResult(this.stage, titleField.height + scoreField.height);
			}
		} 
	}
}