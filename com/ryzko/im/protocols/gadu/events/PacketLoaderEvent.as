package com.ryzko.im.protocols.gadu.events
{
	import com.ryzko.im.protocols.gadu.packets.Packet;
	
	import flash.events.Event;
	
	public class PacketLoaderEvent extends Event
	{
		
		public static var PACKET_COMPLETE:String = 'packet_complete';
		
		
		
		public var packet:Packet;
		
		public function PacketLoaderEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}