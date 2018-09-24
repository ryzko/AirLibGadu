package com.ryzko.im.protocols.gadu.packets.outbound
{
	import com.ryzko.im.protocols.gadu.socket.GaduSocket;
	import com.ryzko.im.protocols.gadu.packets.Packet;
	
	
	public class OutboundPacket extends Packet
	{
		
		public function OutboundPacket()
		{
			super();
		}
		
		public function write(socket:GaduSocket):void
		{

		}
		
		public function sendPacket(socket:GaduSocket):void
		{
			socket.writeHeader(header);
			socket.writeBody(body);
		}

	}
}