package com.ryzko.im.protocols.gadu.packets.incoming
{
	import com.ryzko.im.protocols.gadu.packets.Packet;
	
	public class WelcomePacket extends IncomingPacket
	{
		
		public var seed:int;
		
		public function WelcomePacket(packet:Packet)
		{
			super(packet);
		}
		
		public override function read():void
		{
			seed = body.readInt();
		}
		
	}
}