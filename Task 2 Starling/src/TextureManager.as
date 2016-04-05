package
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.Dictionary;
	import starling.textures.Texture;
		
	public class TextureManager
	{
		private static var _instance:TextureManager;
		private static var _textures:Dictionary;
		
		public function TextureManager()
		{
			if (_instance)
			{
				throw new Error("TextureManager is a Singleton. Use getInstance().");
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
		
		public function initialize():Boolean
		{
			// 텍스처 파일 리딩 -> ByteArray
			var file:File = File.applicationDirectory.resolvePath("Data.txt");
			var fileStream:FileStream = new FileStream();
			fileStream.open(file, FileMode.READ);
			
			
			// 텍스처 로딩 -> Bitmap
			
			
			
			
			// 디스플레이 오브젝트 이름 설정
			
			
			
			
			return true;
		}
		
		public function dispose():void
		{
//			for each (var element:Texture in _textures)
//			{
//				element.dispose();
//			}
			
			for (var key:Object in _textures)
			{
				_textures[key].dispose();
				delete _textures[key];
			}
		}
		
		public function getTexture(name:String):Texture
		{
			if (_textures[name] != null)
			{
				return _textures[name];		
			}
			else
			{
				return null;
			}			
		}
	}
}