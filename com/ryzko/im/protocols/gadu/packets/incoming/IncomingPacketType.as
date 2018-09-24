package com.ryzko.im.protocols.gadu.packets.incoming
{
	public class IncomingPacketType
	{
		
		//Liczba do wyznaczenie hashu hasła
		public static var GG_WELCOME:int 					= 0x0001;
		//Zmiana stanu przed GG 6.0
		public static var GG_STATUS:int 					= 0x0002;
		//Logowanie powiodło się przed Nowym Gadu-Gadu
		public static var GG_LOGIN_OK:int 					= 0x0003;
		//Potwierdzenie wiadomości
		public static var GG_SEND_MSG_ACK:int 				= 0x0005;
		//Pong
		public static var GG_PONG:int 						= 0x0007;
		//Ping
		public static var GG_PING:int 						= 0x0008;
		//Logowanie nie powiodło się
		public static var GG_LOGIN_FAILED:int 				= 0x0009;
		//Przychodząca wiadomość przed GG 8.0
		public static var GG_RECV_MSG:int 					= 0x000a;
		//Zerwanie połączenia
		public static var GG_DISCONNECTING:int 				= 0x000b;
		//Stan listy kontaktów przed GG 6.0
		public static var GG_NOTIFY_REPLY:int 				= 0x000c;
		//Zerwanie połączenia po zmianie stanu 
		//na niedostępny
		public static var GG_DISCONNECT_ACK:int 			= 0x000d;
		//Odpowiedź katalogu publicznego
		public static var GG_PUBDIR50_REPLY:int 			= 0x000e;
		//Zmiana stanu przed GG 7.7
		public static var GG_STATUS60:int 					= 0x000f;
		//Odpowiedź listy kontaktów na serwerze 
		//przed nowym Gadu-Gadu
		public static var GG_USERLIST_REPLY:int 			= 0x0010;
		//Stan listy kontaktów przed GG 7.7
		public static var GG_NOTIFY_REPLY60:int 			= 0x0011;
		//Logowanie powiodło się, ale powinniśmy 
		//uzupełnić adres e-mail w katalogu publicznym
		public static var GG_NEED_EMAIL:int 				= 0x0014;
		//Dany rodzaj hashowania hasła 
		//jest nieobsługiwany przez serwer
		public static var GG_LOGIN_HASH_TYPE_INVALID:int 	= 0x0016;
		//Zmiana stanu przed GG 8.0
		public static var GG_STATUS77:int 					= 0x0017;
		//Stan listy kontaktów przed GG 8.0
		public static var GG_NOTIFY_REPLY77:int 			= 0x0018;
		//???
		public static var GG_DCC7_INFO:int 					= 0x001f;
		//Informacje o chęci nawiązania 
		//połączenia DCC
		public static var GG_DCC7_NEW:int 					= 0x0020;
		//Zaakceptowanie połączenia DCC
		public static var GG_DCC7_ACCEPT:int 				= 0x0021;
		//Odrzucenie połączenia DCC
		public static var GG_DCC7_REJECT:int 				= 0x0022;	
		//???
		public static var GG_DCC7_ID_REPLY:int 				= 0x0023;
		//???
		public static var GG_DCC7_ABORTED:int 				= 0x0025;	
		//Odebrano wiadomość systemową
		public static var GG_XML_EVENT:int 					= 0x0027;
		//Zmiana stanu przed Nowym Gadu-Gadu
		public static var GG_STATUS80BETA:int 				= 0x002a;			
		//Stan listy kontaktów przed Nowym Gadu-Gadu
		public static var GG_NOTIFY_REPLY80BETA:int 		= 0x002b;
		//???
		public static var GG_XML_ACTION:int 				= 0x002c;
		//Przychodząca wiadomość
		public static var GG_RECV_MSG80:int 				= 0x002e;
		//Odpowiedź listy kontaktów na serwerze 
		//przed Gadu-Gadu 10
		public static var GG_USERLIST_REPLY80:int 			= 0x0030;
		//Logowanie powiodło się
		public static var GG_LOGIN_OK80:int 				= 0x0035;
		//Zmiana stanu
		public static var GG_STATUS80:int 					= 0x0036;
		//Stan listy kontaktów
		public static var GG_NOTIFY_REPLY80:int 			= 0x0037;
		//Odpowiedź listy kontaktów na serwerze
		public static var GG_USERLIST_REPLY100:int 			= 0x0041;
		//Dodatkowe informacje o liście kontaktów
		public static var GG_USER_DATA:int 					= 0x0044;


		public function IncomingPacketType()
		{
		}

	}
}