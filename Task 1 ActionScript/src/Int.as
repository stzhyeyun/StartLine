package
{
	public class Int
	{
		private var _value:int = 0;
		
		public function Int(value:int)
		{
			_value = value;
		}
		
		// Getter & Setter //////////
		
		public function get Value():int 
		{ 
			return _value; 
		}
		
		public function set Value(value:int):void 
		{ 
			_value = value; 
		} 
	}
}