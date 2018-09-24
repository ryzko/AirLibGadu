package com.ryzko.im.protocols.gadu.settings
{
	public class ProtocolSettings
	{
		public var HOST:String;
		public var PORT:int;
		
		public var UID:int;
		public var CID:String;
		public var PASSWORD:String;
		public var SEED:int;
		public var STATUS:int;
		public var DESC:String;
		
		
		
		private static var instance:ProtocolSettings = new ProtocolSettings();
		public function ProtocolSettings()
		{
			if( instance ) throw new Error( "Singleton and can only be accessed through Singleton.getInstance()" );
		}
		
		public static function getInstance():ProtocolSettings
		{
			return instance;
		}
		
	}
}