package com.ryzko.im.protocols.gadu.packets.outbound
{
	import com.ryzko.im.protocols.gadu.socket.GaduSocket;
	
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	import mx.utils.StringUtil;
	
	public class SendMessage80 extends OutboundPacket
	{
		
		public var recipient:String;		/* numer odbiorcy */
		public var seq:int;		/* numer sekwencyjny */
		public var msgClass:int;		/* klasa wiadomości */
		public var offsetPlain:int;	/* położenie treści czystym tekstem */
		public var offsetAttributes:int;	/* położenie atrybutów */
		public var htmlMessage:String;	/* treść w formacie HTML (zakończona \0) */
		public var plainMessage:String;	/* treść czystym tekstem (zakończona \0) */
		public var attributes:ByteArray;	/* atrybuty wiadomości */

		
		
		public function SendMessage80()
		{
			super();
		}
		
		public function setOptions(recipient:String, text:String):void
		{
			this.recipient = recipient;
			seq = new Date().time / 1000;
			msgClass = 0x08; /* TODO: dorobic klasy wiadomosci, obecna:GG_CLASS_CHAT  */
			offsetPlain = 0;
			offsetAttributes = 0;
			htmlMessage = text;
			plainMessage = text;
			attributes = new ByteArray();
			attributes.endian = Endian.LITTLE_ENDIAN;
			/*if(recipient.length>1)
			{
				attributes.writeByte(0x01);
				attributes.writeByte(recipient.length);
				for each(var i:int in recipient)
				{
					attributes.writeByte(i);
				}
			}
			
			attributes.position = 0;
			*/
		}
		
		public override function write(socket:GaduSocket):void
		{
			var htmlEXP:String = '<span style=\"color:#000000; font-family:\'MS Shell Dlg 2\'; font-size:9pt; \">{0}</span>';
			var msg:String = StringUtil.substitute(htmlEXP, htmlMessage);
			var msgBy:ByteArray = new ByteArray();
			msgBy.endian = Endian.LITTLE_ENDIAN;
			msgBy.writeUTF(msg);
			body.writeInt(int(recipient));
			body.writeInt(seq);
			body.writeInt(msgClass);
			body.writeInt(msg.length + 20);
			body.writeInt(msg.length+htmlMessage.length + 20);
			body.writeUTFBytes(msg);
			body.writeUTFBytes(htmlMessage);
			body.position = 0;
			
			header.type = OutboundPacketType.GG_SEND_MSG80;
			header.length = body.bytesAvailable;
			
			sendPacket(socket);
		}
		
	}
}