package com.ryzko.im.protocols.gadu.packets.outbound
{
	import com.ryzko.im.protocols.gadu.socket.GaduSocket;
	

	public class AddNotifyPacket extends OutboundPacket
	{
		
		private var _buddyList:Array;
		
		public function set buddyList(a:Array):void
		{
			_buddyList = a;
		}
		
		public function AddNotifyPacket()
		{
			super();
		}
		
		public override function write(socket:GaduSocket):void
		{
			if(!_buddyList || _buddyList.length == 0)
			{
				socket.writeInt(OutboundPacketType.GG_LIST_EMPTY);
				socket.writeInt(0);
				socket.flush();
				return;
			}
			if(_buddyList.length>0 && _buddyList.length<400)
			{
				for each(var uid:String in _buddyList)
				{
					body.writeInt(int(uid));
					body.writeByte(0x03);
				}
				body.position = 0;
				socket.writeInt(OutboundPacketType.GG_NOTIFY_LAST);
				socket.writeInt(body.length);
				socket.writeBytes(body, 0, body.length);
				socket.flush();
				return;
			}
		}
		
	}
}