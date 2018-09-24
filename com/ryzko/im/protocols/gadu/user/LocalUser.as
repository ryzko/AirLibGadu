package com.ryzko.im.protocols.gadu.user
{
	public class LocalUser
	{
		public var password:String;
		public var uid:Number;
		public var username:String;
		
		
		
		
		private static var instance:LocalUser = new LocalUser();
		public function LocalUser()
		{
			if( instance ) throw new Error( "Singleton and can only be accessed through Singleton.getInstance()" );
		}
		
		public static function getInstance():LocalUser
		{
			return instance;
		}

	}
}