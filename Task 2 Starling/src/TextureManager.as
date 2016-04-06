package
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	import starling.textures.Texture;

	public class TextureManager
	{
		private static var _instance:TextureManager;
		
		private var _loader:Loader;
		private var _queue:Vector.<String>; // 로딩할 이미지 파일의 경로를 저장
		private var _textures:Dictionary; // key: String(파일 이름), value: Texture(로딩한 이미지 파일로 생성한 텍스처)
		private var _isLoading:Boolean = false;
		
		public function TextureManager()
		{
			if (_instance)
			{
				throw new Error("Use getInstance().");
			} 
			_instance = this;
		}
		
		public static function getInstance():TextureManager
		{
			if (!_instance)
			{
				_instance = new TextureManager();
			} 
			return _instance;
		}
		
		public function dispose():void
		{
			_loader = null;
			
			if (_queue)
			{
				if (_queue.length > 0)
				{
					for (var i:int = 0; i <_queue.length; i++)
					{
						_queue[i] = null;
					}
				}
			}
			_queue = null;
			
			if (_textures)
			{
				for each (var element:Texture in _textures)
				{
					element.dispose();
				}
			}
			_textures = null;
		}
		
		/**
		 * 로딩할 파일을 queue에 등록합니다. 현재 로딩 중이라면 Enqueue 할 수 없습니다. enqueue가 끝났다면 load()를 호출합니다. 
		 * @param filepath 이미지 파일의 이름과 확장자를 포함한 경로입니다.
		 * @param endEnqueue Enqueue 종료 여부입니다. true: Enqueue 종료, load() 호출 / false: Enqueue가 가능한 상태
		 * @return Enqueue 성공 여부를 반환합니다.
		 * 
		 */
		public function enqueue(filepath:String, endEnqueue:Boolean = false):Boolean
		{
			if (!_isLoading)
			{
				if (!_queue)
				{
					_queue = new Vector.<String>();
				}			
				_queue.push(filepath);
				
				trace("[TextureManager] Enqueued ", filepath);
				
				_isLoading = endEnqueue;
				
				if (_isLoading)
				{
					load();
				}
				
				return true;
			}
			else
			{
				return false; // 로딩중
			}
		}
		
		/**
		 * Queue에서 해당 파일 경로를 제거합니다. 
		 * @param filepath 제거할 파일의 이름과 확장자를 포함한 경로입니다.
		 * @return Dequeue 성공 여부를 반환합니다.
		 * 
		 */
		public function dequeue(filepath:String):Boolean
		{
			if (!_isLoading)
			{
				if (_queue)
				{
					if (_queue.length > 0)
					{
						for (var i:int = 0; i < _queue.length; i++)
						{
							if (_queue[i] == filepath)
							{
								_queue.removeAt(i);	
								
								trace("[TextureManager] Dequeued ", filepath);
								return true;
							}
						}
					}
					else
					{
						return false; // queue가 비었음
					}
				}
			}
			
			return false; // 이미 로딩 중임 / queue가 없음 / filepath를 queue에서 찾지 못함
		}

		/**
		 * Queue에 등록(파일 경로)된 파일의 로드를 시작하고 완료 이벤트 리스너를 등록합니다.  
		 * 
		 */
		private function load():void
		{
			if (_queue)
			{
				if (!_loader)
				{
					_loader = new Loader();
				}
				
				if (_queue.length > 0)
				{
					_loader.load(new URLRequest(_queue[0]));
					_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
				}
				else
				{
					_isLoading = false;
					
					// 디버깅 코드					
					var count:int = 0;
					for each (var element:Object in _textures)
					{
						count++;
					}			
					trace("[TextureManager] Loading complete. Number of total textures :", count);
				}
			}			
		}
		
		/**
		 * 로드 완료시 호출되는 함수입니다. 로딩한 파일로 텍스처를 만들어 멤버(_textures)에 이름과 함께 저장합니다. 
		 * @param event 프로세스 완료 이벤트입니다.
		 * 
		 */
		private function onComplete(event:Event):void
		{
			var loadedBitmap:Bitmap = event.currentTarget.loader.content as Bitmap;
			var texture:Texture = Texture.fromBitmap(loadedBitmap);
			
			var filepath:String = _queue.shift();
			var filename:String = filepath.substring(filepath.lastIndexOf("/") + 1, filepath.length);
			filename = filename.substring(0, filename.indexOf("."));
			
			trace("[TextureManager] Loaded ", filepath);
			
			if (!_textures)
			{
				_textures = new Dictionary();
			}
			_textures[filename] = texture;
			
			load();
		}
		
		/**
		 * 이미지 파일의 이름으로 텍스처를 검색하여 반환합니다. 
		 * @param name 반환받고자 하는 텍스처의 원 파일명입니다.
		 * @return 해당하는 텍스처를 반환합니다. 저장된 텍스처가 없거나 해당 텍스처를 찾지 못했을 경우에는 null을 반환합니다.
		 * 
		 */
		public function getTexture(name:String):Texture
		{
			if (_textures)
			{
				var texture:Texture = _textures[name];
				
				if (texture)
				{
					return texture;
				}
				else
				{
					return null;
				}
			}
			
			return null;
		}
	}
}





