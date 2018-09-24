package com.ryzko.im.protocols.gadu.packets.incoming
{
	import com.ryzko.im.protocols.gadu.packets.Packet;
	
	import flash.utils.ByteArray;
	
	public class LoginOKPacket extends IncomingPacket
	{
		public function LoginOKPacket(packet:Packet)
		{
			super(packet);
		}
		
		public override function read():void
		{
			var b:ByteArray = new ByteArray();
			body.readBytes(b, 0, body.bytesAvailable);
			trace('#### ZALOGOWANY :D ###')
			trace('LoginOKPacket: '+b.bytesAvailable);
		}
		
	}
}