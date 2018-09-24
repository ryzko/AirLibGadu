package com.ryzko.im.protocols.gadu.packets.incoming
{
	import com.ryzko.im.protocols.gadu.packets.Packet;
	
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	public class ReccMessage80 extends IncomingPacket
	{
		
		public var sender:int;				/* numer nadawcy */
		public var seq:int;					/* numer sekwencyjny */
		public var time:int;				/* czas nadania */
		public var msgClass:int;			/* klasa wiadomości */
		public var offsetPlain:int;			/* położenie treści czystym tekstem */
		public var offsetAttributes:int;	/* położenie atrybutów */
		public var html_message:String;		/* treść w formacie HTML (zakończona \0) */
		public var plain_message:String;	/* treść czystym tekstem (zakończona \0) */
		public var attributes:ByteArray;	/* atrybuty wiadomości */

		
		public function ReccMessage80(packet:Packet)
		{
			super(packet);
			attributes = new ByteArray();
		}
		
		public override function read():void
		{
			sender = body.readInt();
			seq = body.readInt();
			time = body.readInt();
			msgClass = body.readInt();
			offsetPlain = body.readInt();
			offsetAttributes = body.readInt();
			var b:ByteArray = new ByteArray()
			b.endian = Endian.LITTLE_ENDIAN;
			body.readBytes(b, 0, body.bytesAvailable);
			body.position = 0;
			
			this.html_message = b.readUTFBytes(b.bytesAvailable);
			trace(html_message)
	

		}
		
	}
}