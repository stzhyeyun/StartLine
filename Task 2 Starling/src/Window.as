package
{
	import flash.geom.Point;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class Window extends Sprite
	{
		private var _id:int = -1;
		private var _isRoot:Boolean = false; // 루트 윈도우(Main에서 생성한 윈도우) 여부 플래그
		private var _width:Number;
		private var _assets:Vector.<Image>; // 윈도우 에셋
		private var _children:Vector.<Window>; // 자식 윈도우
		
		/**
		 * 윈도우의 위치를 지정하고 에셋을 생성합니다.
		 * @param position 클릭 시점의 마우스 위치입니다.
		 * 
		 */		
		public function Window(isRoot:Boolean, position:Point)
		{
			// 루트 윈도우 여부
			_isRoot = isRoot;
			
			// 윈도우 (타이틀 바) 너비 저장
			_width = SingletonAssetManager.getInstance().getTexture(WindowAssetName.TITLE_BAR).width;
			
			// 윈도우 위치 지정
			this.x = position.x - _width / 4;
			this.y = position.y;
			
			// 에셋 생성
			setWindowAsset(WindowAssetName.TITLE_BAR);
			setWindowAsset(WindowAssetName.MINIMIZE);
			setWindowAsset(WindowAssetName.REVERT);
			setWindowAsset(WindowAssetName.CLOSE);
			setWindowAsset(WindowAssetName.CONTENTS);		
		}
		
		/**
		 * 윈도우 에셋을 생성하고 위치, 크기, 이벤트 리스너를 세팅한 후 멤버로 저장합니다. 
		 * @param name 에셋 생성에 사용할 텍스처의 이름입니다.
		 * 
		 */
		private function setWindowAsset(name:String):void
		{
			// 에셋 (이미지) 생성 및 오브젝트 이름 지정
			var asset:Image = new Image(SingletonAssetManager.getInstance().getTexture(name));
			asset.name = name;
			
			// 위치 및 크기 지정, 이벤트 리스너 등록
			switch (asset.name)
			{
				case WindowAssetName.TITLE_BAR:
				{
					asset.addEventListener(TouchEvent.TOUCH, onDragTitleBar);					
				}
					break;
				
				case WindowAssetName.MINIMIZE:
				{
					asset.x = _width * 0.82;
					asset.addEventListener(TouchEvent.TOUCH, onClickMinimize);
				}
					break;
				
				case WindowAssetName.REVERT:
				{
					asset.x = _width * 0.88;
					asset.scaleY = 0.9;
					asset.addEventListener(TouchEvent.TOUCH, onClickRevert);
				}
					break;
				
				case WindowAssetName.CLOSE:
				{
					asset.x = _width * 0.94;
					asset.addEventListener(TouchEvent.TOUCH, onClickClose);
				}
					break;
				
				case WindowAssetName.CONTENTS:
				{
					asset.y = SingletonAssetManager.getInstance().getTexture(WindowAssetName.TITLE_BAR).height;	
					asset.addEventListener(TouchEvent.TOUCH, onClickContents);
				}
					break;
			}	
			
			// Window 하위에 추가
			addChild(asset);		
			
			// Vector에 저장
			if (!_assets)
			{
				_assets = new Vector.<Image>();	
			}	
			_assets.push(asset);
		}
		
		/**
		 * 입력 좌표에 따라 윈도우를 이동합니다. 
		 * @param currMouseX 마우스 포인터의 현재 위치(x)입니다.
		 * @param currMouseY 마우스 포인터의 현재 위치(y)입니다.
		 * @param prevMouseX 마우스 포인터의 이전 위치(x)입니다.
		 * @param prevMouseY 마우스 포인터의 이전 위치(y)입니다.
		 * 
		 */
		private function move(currMouseX:Number, currMouseY:Number, prevMouseX:Number, prevMouseY:Number):void
		{
			this.x += currMouseX - prevMouseX;
			this.y += currMouseY - prevMouseY;
		}
		
		/**
		 * 윈도우를 최소화합니다. 
		 * 
		 */
		private function minimize():void
		{
			// contents
			if (_assets)
			{
				for (var i:int = 0; i < _assets.length; i++)
				{
					if (_assets[i].name == WindowAssetName.CONTENTS)
					{
						_assets[i].visible = false;
						break;
					}
				}
			}
			
			// 자식 윈도우
			if (_children)
			{
				for (i = 0; i < _children.length; i++)
				{
					_children[i].visible = false;
				}
			}
		}
		
		/**
		 * 최소화된 윈도우의 크기를 되돌립니다. 
		 * 
		 */
		private function revert():void
		{
			// contents
			if (_assets)
			{
				for (var i:int = 0; i < _assets.length; i++)
				{
					if (_assets[i].name == WindowAssetName.CONTENTS)
					{
						_assets[i].visible = true;
						break;
					}
				}
			}
			
			// 자식 윈도우
			if (_children)
			{
				for (i = 0; i < _children.length; i++)
				{
					_children[i].visible = true;
				}
			}
		}
		
		/**
		 * 윈도우를 닫고 관련 리소스를 해제합니다. 
		 * 
		 */
		private function close():void
		{
			// 에셋
			if (_assets)
			{
				for (var i:int = 0; i < _assets.length; i++)
				{
					removeChild(_assets[i]);
				}
			}
			
			// 자식 윈도우
			if (_children)
			{
				for (i = 0; i < _children.length; i++)
				{
					_children[i].close();
					_children[i].dispose();
				}
			}
			
			dispose();
		}
		
		/**
		 * minimize부에 대한 클릭 발생 시 minimize()를 호출합니다. 
		 * @param event 터치 이벤트입니다.
		 * 
		 */
		private function onClickMinimize(event:TouchEvent):void
		{
			var action:Touch = event.getTouch(this, TouchPhase.ENDED);
			
			if (action)
			{
				minimize();
			}
		}
		
		/**
		 * revert부에 대한 클릭 발생 시 revert()를 호출합니다. 
		 * @param event 터치 이벤트입니다.
		 * 
		 */
		private function onClickRevert(event:TouchEvent):void
		{
			var action:Touch = event.getTouch(this, TouchPhase.ENDED);
			
			if (action)
			{
				revert();
			}
		}
		
		/**
		 * close부에 대한 클릭 발생 시 close()를 호출합니다. 
		 * @param event 터치 이벤트입니다.
		 * 
		 */
		private function onClickClose(event:TouchEvent):void
		{
			var action:Touch = event.getTouch(this, TouchPhase.ENDED);
			
			if (action)
			{
				close();
			}
		}
		
		/**
		 * contents부에 대한 클릭 발생 시 새로운 윈도우를 생성하고 멤버로 저장합니다. 
		 * @param event 터치 이벤트입니다.
		 * 
		 */
		private function onClickContents(event:TouchEvent):void
		{
			var action:Touch = event.getTouch(this, TouchPhase.ENDED);
			
			if (action)
			{
				var window:Window = new Window(action.getLocation(this));
				addChild(window);
				
				if (!_children)
				{
					_children = new Vector.<Window>();
				}
				_children.push(window);
			}
		}
		
		/**
		 * titleBar를 드래그하면 윈도우를 이동하는 move()를 호출합니다. 
		 * @param event 터치 이벤트입니다.
		 * 
		 */
		private function onDragTitleBar(event:TouchEvent):void
		{
			var action:Touch = event.getTouch(this, TouchPhase.MOVED);
			
			if (action)
			{
				move(action.globalX, action.globalY,
					action.previousGlobalX, action.previousGlobalY);
			}
		}
		
		/**
		 * 자식 윈도우를 멤버(_children)에서 제거합니다. 
		 * @param removeId 제거할 윈도우의 ID입니다.
		 * 
		 */
		public function removeChildWindow(removeId:int):void
		{
			if (_children)
			{
				for (var i:int = 0; i < _children.length; i++)
				{
					if (_children[i].id == removeId)
					{
						_children.removeAt(i);
						break;
					}
				}
			}
		}
		
		public function get id():int
		{
			return _id;
		}
		
		public function set id(id:int):void
		{
			_id = id;
		}
	}
}