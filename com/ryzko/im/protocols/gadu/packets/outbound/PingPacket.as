package com.ryzko.im.protocols.gadu.packets.outbound
{
	import com.ryzko.im.protocols.gadu.socket.GaduSocket;
	
	public class PingPacket extends OutboundPacket
	{
		public function PingPacket()
		{
			super();
		}
		
		public override function write(socket:GaduSocket):void
		{
			socket.writeInt(OutboundPacketType.GG_PING);
			socket.flush();
		}
	}
}