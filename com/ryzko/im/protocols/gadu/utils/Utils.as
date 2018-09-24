package com.ryzko.im.protocols.gadu.utils
{
	import com.adobe.crypto.SHA1;
	
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	public class Utils
	{
		public function Utils()
		{
		
		}
		
		public static function hash(seed:uint, password:String):String
		{
			var ba:ByteArray = new ByteArray();
			ba.endian = Endian.LITTLE_ENDIAN;
			ba.writeUTFBytes(password);
			ba.writeUnsignedInt(seed);
			var hash:String = SHA1.hashBytes(ba);//password + seed;
			trace("sha1+seed: "+ hash)
			return hash;
			
		}
		
		public function bitWise(value:int, map:Array):int
		{
			return 0;
		}

	}
}