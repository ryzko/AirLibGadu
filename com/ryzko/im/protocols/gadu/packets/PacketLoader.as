package com.ryzko.im.protocols.gadu.packets
{
	import com.ryzko.im.protocols.gadu.events.PacketLoaderEvent;
	import com.ryzko.im.protocols.gadu.socket.GaduSocket;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class PacketLoader extends EventDispatcher
	{
		
		private var packet:Packet;
		private var headerParsed:Boolean = false;
		
		public function PacketLoader(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public function load(socket:GaduSocket):void
		{
			if(!headerParsed)
			{
				packet = new Packet();
				packet.header.read(socket);
				socket.readBytes(packet.body, 0, 0);
				headerParsed = false;
				checkSize();
				return;
			}
			else
			{
				trace('coś dłuższego')
				socket.readBytes(packet.body, packet.body.length, socket.bytesAvailable);
				checkSize();
				return;
			}
			
		}
		
		private function checkSize():void
		{
			if(packet.header.length == packet.body.bytesAvailable)
			{

				var event:PacketLoaderEvent = new PacketLoaderEvent(PacketLoaderEvent.PACKET_COMPLETE);
				event.packet = packet;
				headerParsed = false;
				dispatchEvent(event);
			}
		}
	}
}