package com.ryzko.im.protocols.gadu.user
{
	public class LocalUserStatus
	{
		
		/* Niedostępny */
		public static const GG_STATUS_NOT_AVAIL:int = 0x0001;
		/* Niedostępny (z opisem) */
		public static const GG_STATUS_NOT_AVAIL_DESCR:int = 0x0015;
		/* PoGGadaj ze mną */
		public static const GG_STATUS_FFC:int = 0x0017;
		/* PoGGadaj ze mną (z opisem) */
		public static const GG_STATUS_FFC_DESCR:int = 0x0018;
		/* Dostępny */
		public static const GG_STATUS_AVAIL:int = 0x0002;
		/* Dostępny (z opisem) */
		public static const GG_STATUS_AVAIL_DESCR:int = 0x0004;
		/* 	Zajęty */
		public static const GG_STATUS_BUSY:int = 0x0003;
		/* Zajęty (z opisem) */
		public static const GG_STATUS_BUSY_DESCR:int = 0x0005;
		/* 	Nie przeszkadzać */
		public static const GG_STATUS_DND:int = 0x0021;
		/* Nie przeszkadzać (z opisem) */
		public static const GG_STATUS_DND_DESCR:int = 0x0022;
		/* Niewidoczny */
		public static const GG_STATUS_INVISIBLE:int = 0x0014;
		/* 	Niewidoczny (z opisem) */
		public static const GG_STATUS_INVISIBLE_DESCR:int = 0x0016;
		/* 	Zablokowany */
		public static const GG_STATUS_BLOCKED:int = 0x0006;
		/* Maska bitowa oznaczająca ustawiony opis graficzny */
		public static const GG_STATUS_IMAGE_MASK:int = 0x0100;
		/* Maska bitowa oznaczająca ustawiony opis */
		public static const GG_STATUS_DESCR_MASK:int = 0x4000;
		/* Maska bitowa oznaczająca tryb tylko dla przyjaciół */
		public static const GG_STATUS_FRIENDS_MASK:int = 0x8000;
		
		
		public function LocalUserStatus()
		{
		}

	}
}