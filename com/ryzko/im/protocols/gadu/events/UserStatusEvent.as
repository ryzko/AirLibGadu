package com.ryzko.im.protocols.gadu.events
{
	import com.ryzko.im.protocols.gadu.user.RemoteUser;
	

	public class UserStatusEvent extends ProtocolEvent
	{
		public static const USER_STATUS_CHANGED:String = 'userStatusChanged';
		//public static const USER_BANNED:String = 'user_banned';
		
		public var user:RemoteUser;
		
		public function UserStatusEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=true)
		{
			super(type, bubbles, cancelable);
		}
	}
}