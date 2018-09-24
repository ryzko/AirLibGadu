package com.ryzko.im.protocols.gadu.packets.incoming
{
	import com.ryzko.im.protocols.gadu.packets.Packet;
	import com.ryzko.im.protocols.gadu.user.RemoteUser;
	
	public class StatusChangePacket extends IncomingPacket
	{
		private var uid:String;				/* numer Gadu-Gadu kontaktu */
		private var status:int;				/* status */
		private var flags:int;				/* flagi (nieznane przeznaczenie) */
		private var remote_ip:int;			/* adres IP bezpośrednich połączeń (nieużywane) */
		private var remote_port:int;		/* port bezpośrednich połączeń (nieużywane) */
		private var image_size:uint;		/* maksymalny rozmiar obrazków w KB */
		private var unknown2:uint;			/* 0x00 */
		private var unknown3:uint;			/* 0x00000000 */
		private var description_size:int;	/* rozmiar opisu */
		private var description:String;		/* opis (nie musi wystąpić, bez \0) */
		
		public var user:RemoteUser;
		
		public function StatusChangePacket(packet:Packet)
		{
			super(packet);
		}
		
		public override function read() : void
		{
			if(body.bytesAvailable == 0 ) return;
			uid = body.readInt().toString();
			status = body.readInt();
			flags = body.readInt();
			remote_ip = body.readInt();
			remote_port = body.readShort();
			image_size = body.readByte();
			unknown2 = body.readByte();
			unknown3 = body.readInt();
			description_size = body.readInt();
			if(description_size > 0)
				description = body.readUTFBytes(body.bytesAvailable);
			
			user = new RemoteUser(uid, status, description);
		}
	}
}