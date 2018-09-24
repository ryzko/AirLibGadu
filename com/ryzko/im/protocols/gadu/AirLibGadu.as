package com.ryzko.im.protocols.gadu
{
	import com.ryzko.im.protocols.gadu.events.ConnectionEvent;
	import com.ryzko.im.protocols.gadu.events.HTTPServicesEvent;
	import com.ryzko.im.protocols.gadu.events.MessageEvent;
	import com.ryzko.im.protocols.gadu.events.PacketLoaderEvent;
	import com.ryzko.im.protocols.gadu.events.RosterEvent;
	import com.ryzko.im.protocols.gadu.events.UserStatusEvent;
	import com.ryzko.im.protocols.gadu.http.HTTPServices;
	import com.ryzko.im.protocols.gadu.message.Message;
	import com.ryzko.im.protocols.gadu.packets.Packet;
	import com.ryzko.im.protocols.gadu.packets.PacketHeader;
	import com.ryzko.im.protocols.gadu.packets.PacketLoader;
	import com.ryzko.im.protocols.gadu.packets.incoming.IncomingPacketType;
	import com.ryzko.im.protocols.gadu.packets.incoming.LoginOKPacket;
	import com.ryzko.im.protocols.gadu.packets.incoming.NotifyReply80Packet;
	import com.ryzko.im.protocols.gadu.packets.incoming.ReccMessage80;
	import com.ryzko.im.protocols.gadu.packets.incoming.SendMessageAck;
	import com.ryzko.im.protocols.gadu.packets.incoming.StatusChangePacket;
	import com.ryzko.im.protocols.gadu.packets.incoming.UserlistReply10Packet;
	import com.ryzko.im.protocols.gadu.packets.incoming.WelcomePacket;
	import com.ryzko.im.protocols.gadu.packets.outbound.AddNotifyPacket;
	import com.ryzko.im.protocols.gadu.packets.outbound.Login80Packet;
	import com.ryzko.im.protocols.gadu.packets.outbound.NewStatus80;
	import com.ryzko.im.protocols.gadu.packets.outbound.PingPacket;
	import com.ryzko.im.protocols.gadu.packets.outbound.SendMessage80;
	import com.ryzko.im.protocols.gadu.packets.outbound.UserlistRequestPacket;
	import com.ryzko.im.protocols.gadu.settings.ProtocolSettings;
	import com.ryzko.im.protocols.gadu.socket.GaduSocket;
	import com.ryzko.im.protocols.gadu.utils.Utils;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	import flash.utils.Timer;
	
	[Event(name="connected", type="com.ryzko.im.protocols.gadu.events.ConnectionEvent")]
	[Event(name="disconnected", type="com.ryzko.im.protocols.gadu.events.ConnectionEvent")]
	[Event(name="rosterReceived", type="com.ryzko.im.protocols.gadu.events.RosterEvent")]
	[Event(name="messageReceived", type="com.ryzko.im.protocols.gadu.events.MessageEvent")]
	[Event(name="userStatusChanged", type="com.ryzko.im.protocols.gadu.events.UserStatusEvent")]
	
	public class AirLibGadu extends Sprite
	{
		
		private var socket:GaduSocket;
		private var http:HTTPServices;
		private var header:PacketHeader;
		private var settings:ProtocolSettings;
		
		private var packet:ByteArray;
		private var packetComplete:Boolean = true;
		private var xmlAction:Boolean = false;
		private var ulr:UserlistReply10Packet;
		
		private var packetLoader:PacketLoader;
		
		private var timer:Timer;
		private var pingPongTimer:Timer;
		
		public function AirLibGadu()
		{
			settings = ProtocolSettings.getInstance();
			packetLoader = new PacketLoader();
			packetLoader.addEventListener(PacketLoaderEvent.PACKET_COMPLETE, onPacketComplete);
		}
		
		public function connect(uid:String, password:String, initialStatus:int, initialDescription:String):void
		{
			http = new HTTPServices();
			http.addEventListener(HTTPServicesEvent.SERVER_INFO_RESPONSE, onServerInfoResponse);
			http.getServerInfo();
			settings.UID = Number(uid);
			settings.PASSWORD = password;
			settings.STATUS = initialStatus;
			settings.DESC = initialDescription;
			
		}
		
		private function onServerInfoResponse(e:HTTPServicesEvent):void
		{
			settings.HOST = e.host;
			settings.PORT = e.port;
			
			timer = new Timer(1000);
			timer.addEventListener(TimerEvent.TIMER, onComplete);
			//4 minuty na ping-ponga?
			pingPongTimer = new Timer(1000 * 60 * 4);
			pingPongTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onPingPongHandler);
			socket = new GaduSocket();
			socket.endian = Endian.LITTLE_ENDIAN;
			socket.addEventListener(ProgressEvent.SOCKET_DATA, onSocketData);
			socket.addEventListener(Event.CLOSE, onSocketClose);
			socket.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			socket.connect(settings.HOST, settings.PORT);
			
		}
		
		private function onPingPongHandler(e:TimerEvent):void
		{
			var ping:PingPacket = new PingPacket();
			ping.write(socket);
		}
		
		private function onComplete(e:TimerEvent):void
		{
			timer.stop();
			//readPacket();
			
		}
		
		private function onSocketData(e:ProgressEvent):void
		{
			//timer.start();
			//readPacket();
			packetLoader.load(socket);
		}
		
		private function onPacketComplete(event:PacketLoaderEvent):void
		{
			
			switch(event.packet.header.type)
			{
				case IncomingPacketType.GG_WELCOME:
					readWelcomePacket(event.packet);
					break;
				
				case IncomingPacketType.GG_LOGIN_OK80:
					readLoginData(event.packet);
					break;
				
				case IncomingPacketType.GG_SEND_MSG_ACK:
					readMessageAck(event.packet);
					break;
				
				case IncomingPacketType.GG_RECV_MSG80:
					readMessage(event.packet);
					break;
				
				case IncomingPacketType.GG_NOTIFY_REPLY80:
					readNotifyReply(event.packet)
					break;
				
				case IncomingPacketType.GG_STATUS80:
					readUserStatus(event.packet)
					break;
				
				case IncomingPacketType.GG_USER_DATA:
					readUserData(event.packet);
					break;
				
				case IncomingPacketType.GG_XML_ACTION:
					readXMLAction(event.packet);
					break;
				
				case IncomingPacketType.GG_USERLIST_REPLY80:
					readUserlist(event.packet);
					break;
				
				case IncomingPacketType.GG_DISCONNECTING:
					disconnected();
					break;
				
				default:
					readUnknownPacket(event.packet);
					
			}
			
			checkSocket();
		}
		
		
		
		private function onSocketClose(e:Event):void
		{
			trace('onSocketClose');
		}
		private function onIOError(e:IOErrorEvent):void
		{
			trace(e.errorID);
		}
		private function onSecurityError(e:SecurityErrorEvent):void
		{
			trace(e.errorID);
		}
		
		private function login():void
		{
			var loginPacket:Login80Packet = new Login80Packet();
			loginPacket.hash = Utils.hash(settings.SEED, settings.PASSWORD);
			loginPacket.write(socket);
		}
		/**
		 * 
		 * @param status
		 * @param description
		 * 
		 */		
		public function changeStatus(status:int, description:String) : void
		{
			var stat:NewStatus80 = new NewStatus80();
			stat.setOptions(status, description);
			stat.write(socket);
			
		}
		
		public function addNotify(contacts:Array):void
		{
			var notify:AddNotifyPacket = new AddNotifyPacket();
			notify.buddyList = contacts;
			notify.write(socket);
		}
		
		public function sendMessage(message:Message):void
		{
			var newMsg:SendMessage80 = new SendMessage80();
			newMsg.setOptions(message.uid, message.text);
			newMsg.write(socket);
		}
		
		public function importUserlist():void
		{
			var iu:UserlistRequestPacket = new UserlistRequestPacket();
			iu.write(socket);
		}
		
		private function readUserlist(packet:Packet):void
		{
			var rosterPacket:UserlistReply10Packet = new UserlistReply10Packet(packet);
			rosterPacket.read();
			var e:RosterEvent = new RosterEvent(RosterEvent.ROSTER_RECEIVED);
			e.roster = rosterPacket.userlist;
			dispatchEvent(e);
		}
		
		private function readNotifyReply(packet:Packet):void
		{
			trace('GG_NOTIFY_REPLY80:');
			var nr:NotifyReply80Packet = new NotifyReply80Packet(packet);
			nr.read();
		}
		
		private function readUserStatus(packet:Packet):void
		{
			trace('GG_NOTIFY_REPLY80:');
			var nr:StatusChangePacket = new StatusChangePacket(packet);
			nr.read();
			var e:UserStatusEvent = new UserStatusEvent(UserStatusEvent.USER_STATUS_CHANGED);
			e.user = nr.user;
			dispatchEvent(e);
		}
		
		private function readLoginData(packet:Packet):void
		{
			trace('GG_LOGIN_OK80:')
			var loginOK:LoginOKPacket = new LoginOKPacket(packet);
			loginOK.read();
			pingPongTimer.start();
			dispatchEvent(new ConnectionEvent(ConnectionEvent.CONNECTED));
		}
		
		private function readWelcomePacket(packet:Packet):void
		{
			trace('GG_WELCOME:')
			var welcome:WelcomePacket = new WelcomePacket(packet);
			welcome.read();
			settings.SEED = welcome.seed;
			
			login();
		}
		
		private function readMessageAck(packet:Packet):void
		{
			trace('GG_SEND_MSG_ACK:')
			var sma:SendMessageAck = new SendMessageAck(packet);
			sma.read();
		}
		
		private function readMessage(packet:Packet):void
		{
			trace("GG_RECV_MSG80:")
			var rmsg:ReccMessage80 = new ReccMessage80(packet);
			rmsg.read();
			var m:Message = new Message(rmsg.sender.toString(), rmsg.html_message);
			var e:MessageEvent = new MessageEvent();
			e.message = m;
			dispatchEvent(e);
		}
		
		private function readUserData(packet:Packet):void
		{
			trace('GG_USER_DATA:');
			clearSocket();
		}
		
		private function readXMLAction(packet:Packet):void
		{
			trace('GG_XML_ACTION:');
			xmlAction = true;
		}
		
		public function disconnect():void
		{
			trace('[..GG_DISCONNECTING..]')
			pingPongTimer.stop();
		}
		
		private function disconnected():void
		{
			dispatchEvent(new ConnectionEvent(ConnectionEvent.DISCONNECTED));
		}
		
		private function readUnknownPacket(packet:Packet):void
		{
			trace("UNKNOWN_PACKET??" + header.type +' [ '+socket.bytesAvailable+' ]');
		}
		
		private function checkSocket():void
		{
			trace('bytesAvailable:'+socket.bytesAvailable)
			if(socket.bytesAvailable>0) clearSocket();
		}
		
		private function clearSocket():void
		{
			var ba:ByteArray = new ByteArray();
			socket.readBytes(ba, 0, socket.bytesAvailable);
		}

	}
}