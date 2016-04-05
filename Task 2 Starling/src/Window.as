package
{
	public class Window
	{
		//private var _id:int;
		private var _parent:Window;
		private var _assets:Vector.<WindowAsset> = new Vector.<WindowAsset>(5);
		private var _children:Vector.<Window>;
		
		public function Window(parent:Window)
		{
			_parent = parent;			
		public function dispose():void
		{
			// Image 삭제
			for (var i:int = 0; i < _assets.length; i++)
			{
				var temp:Image = _assets.shift();
				_container.removeChild(temp);
				temp.dispose();
			}
			
			_assets[WindowAssetId.TITLE_BAR] = new WindowAsset(WindowAssetId.TITLE_BAR);
			_assets[WindowAssetId.MINIMIZE] = new WindowAsset(WindowAssetId.MINIMIZE);
			_assets[WindowAssetId.REVERT] = new WindowAsset(WindowAssetId.REVERT);
			_assets[WindowAssetId.CLOSE] = new WindowAsset(WindowAssetId.CLOSE);
			_assets[WindowAssetId.CONTENTS] = new WindowAsset(WindowAssetId.CONTENTS);			
			// Window 삭제
			for (i = 0; i < _children.length; i++)
			{
				_children.shift().dispose();
			}			
		}
		
		public function move():void
		{
			
		}
		
		public function minimize():void
		{
			
		}
		
		public function close():void
		{
			// removeChild();
			// 벡터에서 제거
		}
		
		public function removeChild(child:Window):void
		{
			for (var i:int = 0; i< _children.length; i++)
			{
				if (_children[i] == child)
				{
					_children.removeAt(i);
				}
			}			
		}
		
		private function onMouseAction(event:TouchEvent):void
		{			
			var touch:Touch = event.getTouch(_container);
			
			if (touch != null)
			{
				if (touch.phase == TouchPhase.BEGAN)
				{
				
				}
				else if (touch.phase == TouchPhase.ENDED)
				{
					if (touch.target.name == WindowAssetName.CONTENTS)
					{
						// 마우스 다운 타깃 확인
						
						if (_children == null)
						{
							_children = new Vector.<Window>();
						}
						_children.push(new Window(_container, this, touch.getLocation(_container)));
					}
				}
				else if (touch.phase == TouchPhase.MOVED)
				{
					
				}
			}
		}
	}
}