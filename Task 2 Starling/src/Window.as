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
			
			_assets[WindowAssetId.TITLE_BAR] = new WindowAsset(WindowAssetId.TITLE_BAR);
			_assets[WindowAssetId.MINIMIZE] = new WindowAsset(WindowAssetId.MINIMIZE);
			_assets[WindowAssetId.REVERT] = new WindowAsset(WindowAssetId.REVERT);
			_assets[WindowAssetId.CLOSE] = new WindowAsset(WindowAssetId.CLOSE);
			_assets[WindowAssetId.CONTENTS] = new WindowAsset(WindowAssetId.CONTENTS);			
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
		
		public function createWindow():void
		{
			
		}		
	}
}