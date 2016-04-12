package
{
	import flash.filesystem.File;
	
	import starling.utils.AssetManager;

    [Deprecated(replacement="TextureManager")]
	public class SingletonAssetManager extends AssetManager
	{
		private static var _instance:SingletonAssetManager;
		
		public function SingletonAssetManager()
		{
			if (_instance)
			{
				throw new Error("Use getInstance().");
			} 
			_instance = this;
		}
		
		public static function getInstance():SingletonAssetManager
		{
			if (!_instance)
			{
				_instance = new SingletonAssetManager();
			} 
			return _instance;
		}
		
		public function initialize(resourceFolder:String):void
		{
			enqueue(File.applicationDirectory.resolvePath(resourceFolder));
			loadQueue(function(ratio:Number):void
			{
				if (ratio == 1)
				{
					// to do
				}
			});	
		}
	}
}