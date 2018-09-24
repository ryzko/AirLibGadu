package com.ryzko.im.protocols.gadu.packets.incoming
{
	import com.ryzko.im.protocols.gadu.packets.Packet;
	
	public class SendMessageAck extends IncomingPacket
	{
		
		public var status:int;
		public var recipient:int;
		public var seq:int;
		
		public function SendMessageAck(packet:Packet)
		{
			super(packet);
		}
		
		public override function read():void
		{
			status = body.readInt();
			recipient = body.readInt();
			seq = body.readInt();
		}
		
	}
}