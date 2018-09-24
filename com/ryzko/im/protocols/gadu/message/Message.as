package com.ryzko.im.protocols.gadu.message
{

	public class Message
	{
		public var uid:String;
		public var text:String;
		
		public function Message(uid:String, text:String)
		{
			this.uid = uid;
			this.text = text;
		}
	}
}