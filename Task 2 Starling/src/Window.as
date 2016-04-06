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
		
			
			{
				{
				}
				{
					if (touch.target.name == WindowAssetName.CONTENTS)
					{
						// 마우스 다운 타깃 확인
						
						if (_children == null)
						{
							_children = new Vector.<Window>();
						}
						_children.push(new Window(_main, this, touch.getLocation(_main)));
					}
				}
				else if (touch.phase == TouchPhase.MOVED)
				{
					
				}
			}
		}
	}
}