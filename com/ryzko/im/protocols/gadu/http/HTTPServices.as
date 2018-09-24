package com.ryzko.im.protocols.gadu.http
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	
	import mx.utils.StringUtil;
	
	import com.ryzko.im.protocols.gadu.events.HTTPServicesEvent;
	
	public class HTTPServices extends EventDispatcher
	{
		
		public static var HOST:String = 'http://appmsg.gadu-gadu.pl';
		public var COMMAND:String = '/appsvc/appmsg_ver8.asp?fmnumber={0}&lastmsg={1}&version={2}';
		private var urlLoader:URLLoader;
		public function HTTPServices()
		{
		}
		
		public function getServerInfo():void
		{
			var url:String = HOST + StringUtil.substitute(COMMAND,'0','0','10.0.0.10450'); 
			var urlRequest:URLRequest = new URLRequest(url);
			urlRequest.method = URLRequestMethod.GET;
			urlLoader = new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE, onServerInfoResponse);
			urlLoader.load(urlRequest);
		}
		
		private function onServerInfoResponse(event:Event):void
		{
			var e:HTTPServicesEvent = new HTTPServicesEvent(HTTPServicesEvent.SERVER_INFO_RESPONSE);
			var response:Array = String(urlLoader.data).split(' ');
			e.host = String(String(response[2]).split(':')[0]);
			e.port = Number(String(response[2]).split(':')[1]);
			
			dispatchEvent(e);

		}

	}
}