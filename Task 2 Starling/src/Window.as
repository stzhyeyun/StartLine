package
{
	import flash.geom.Point;
	
	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class Window extends Sprite
	{
		private var _main:Main;		
		private var _assets:Vector.<Image>;
		private var _parent:Window;
		private var _children:Vector.<Window>;
		
		public function Window(container:Main, parent:Window, position:Point)
		{
			if (container != null)
			{
				_container = container;
				_container.addEventListener(TouchEvent.TOUCH, onMouseAction);
			}
			
			if (parent != null)
			{
				_parent = parent;
			}
			
			_position = position;
			
			// 에셋 생성
			
			
			
		}
		
		public function dispose():void
		{
			// Image 삭제
			for (var i:int = 0; i < _assets.length; i++)
			{
				var temp:Image = _assets.shift();
				_container.removeChild(temp);
				temp.dispose();
			}
			
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
		
		private function setWindowAsset(name:String):void
		{
			// 에셋 생성
			var asset:Image = new Image(SingletonAssetManager.getInstance().getTexture(name));
			asset.name = name;
			
			// 위치 및 크기 지정
			switch (name)
			{
				case WindowAssetName.TITLE_BAR:
				{

				}
					break;

				case WindowAssetName.MINIMIZE:
				{
					asset.x = SingletonAssetManager.getInstance().getTexture(WindowAssetName.TITLE_BAR).width * 0.82;
				}
					break;
				
				case WindowAssetName.REVERT:
				{
					asset.x = SingletonAssetManager.getInstance().getTexture(WindowAssetName.TITLE_BAR).width * 0.88;
				}
					break;
				
				case WindowAssetName.CLOSE:
				{
					asset.x = SingletonAssetManager.getInstance().getTexture(WindowAssetName.TITLE_BAR).width * 0.94;
				}
					break;
				
				case WindowAssetName.CONTENTS:
				{
					asset.y = SingletonAssetManager.getInstance().getTexture(WindowAssetName.TITLE_BAR).height;					
				}
					break;
			}	
			
			// addChild
			addChild(asset);		
			
			// 벡터에 저장
			if (!_assets)
			{
				_assets = new Vector.<Image>();	
			}	
			_assets.push(asset);
		}
		
		private function onMouseAction(event:TouchEvent):void
		{			
			var touch:Touch = event.getTouch(this);
			
			if (touch)
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