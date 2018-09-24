package com.ryzko.im.protocols.gadu.events
{
	public class RosterEvent extends ProtocolEvent
	{
		public static const ROSTER_RECEIVED:String = 'rosterReceived';
		
		public var roster:XML;
		
		public function RosterEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(ROSTER_RECEIVED, bubbles, cancelable);
		}
	}
}