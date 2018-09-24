package com.ryzko.im.protocols.gadu.packets.incoming
{
	import com.ryzko.im.protocols.gadu.packets.Packet;
	
	import flash.errors.IOError;
	import flash.utils.ByteArray;
	import flash.utils.Endian;

	public class UserlistReply10Packet extends IncomingPacket
	{
		
		public var userlist:XML;
		
		public function UserlistReply10Packet(packet:Packet)
		{
			super(packet);
		}
		
		public override function read() : void
		{
			var ba:ByteArray = new ByteArray();
			var type:uint = body.readByte();
			try
			{
				ba.endian = Endian.LITTLE_ENDIAN;
				body.readBytes(ba, 0, body.bytesAvailable);
				ba.uncompress();
				userlist = new XML(ba.toString());
			}
			catch (e:IOError)
			{
				trace(e.message)
			}

		}
	}
}