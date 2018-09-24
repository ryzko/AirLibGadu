package com.ryzko.im.protocols.gadu.packets
{
	import flash.net.Socket;
	import flash.utils.ByteArray;
	
	public class PacketHeader
	{
		
		public var type:int;
		public var length:int;
		
		public function PacketHeader()
		{
		}
		
		public function read(socket:Socket):void
		{
			var ba:ByteArray = new ByteArray();
			type = socket.readInt();
			length = socket.readInt();
		}

	}
}