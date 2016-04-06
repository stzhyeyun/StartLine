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
		private var _width:Number;
		private var _assets:Vector.<Image>;
		private var _children:Vector.<Window>;
		
		public function Window(position:Point)
		{
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
		
		private function move(currMouseX:Number, currMouseY:Number, prevMouseX:Number, prevMouseY:Number):void
		{
			this.x += currMouseX - prevMouseX;
			this.y += currMouseY - prevMouseY;
		}
		
		private function minimize():void
		{
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
			
			if (_children)
			{
				for (i = 0; i < _children.length; i++)
				{
					_children[i].visible = false;
				}
			}
		}
		
		private function revert():void
		{
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
			
			if (_children)
			{
				for (i = 0; i < _children.length; i++)
				{
					_children[i].visible = true;
				}
			}
		}
		
		private function close():void
		{
			if (_assets)
			{
				for (var i:int = 0; i < _assets.length; i++)
				{
					removeChild(_assets[i]);
				}
			}
			
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
		
		}
	}
}