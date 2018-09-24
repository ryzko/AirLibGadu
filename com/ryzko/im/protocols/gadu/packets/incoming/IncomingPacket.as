package com.ryzko.im.protocols.gadu.packets.incoming
{
	import com.ryzko.im.protocols.gadu.packets.Packet;
	
	public class IncomingPacket extends Packet
	{
		
		
		public function IncomingPacket(packet:Packet)
		{
			super();
			this.body = packet.body;
			this.header = packet.header;
		}
		
		public function read():void
		{
			
		}

	}
}