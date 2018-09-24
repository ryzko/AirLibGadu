package com.ryzko.im.protocols.gadu.packets
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	import flash.events.EventDispatcher;

	public class Packet extends EventDispatcher
	{
		public var header:PacketHeader;
		public var body:ByteArray;
		
		public function Packet()
		{
			header = new PacketHeader();
			
			body = new ByteArray();
			body.endian = Endian.LITTLE_ENDIAN;
		}

	}
}