package com.ryzko.im.protocols.gadu.packets.outbound
{
	import com.ryzko.im.protocols.gadu.socket.GaduSocket;

	public class UserlistRequestPacket extends OutboundPacket
	{
		
		
		
		public function UserlistRequestPacket()
		{
			super();
		}
		
		public override function write(socket:GaduSocket) : void
		{
			body.writeByte(0x02);
			
			header.type = OutboundPacketType.GG_USERLIST_REQUEST80;
			header.length = body.length;
			
			sendPacket(socket);
			
		}
	}
}