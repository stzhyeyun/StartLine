package
{
	import flash.geom.Point;
	
	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class Window extends Sprite
	{
		private var _container:Main;		
		private var _assets:Vector.<Image> = new Vector.<Image>(5);
		private var _parent:Window;
		private var _children:Vector.<Window>;
		private var _position:Point;
		
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