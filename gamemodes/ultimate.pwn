
//==========================ULTIMATE STUNT DM v5 by Gta-MP Team=================
//¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
//	  __¦¦¦¦¦___¦¦¦___¦¦¦¦¦_ _¦¦¦¦¦¦_ _¦¦¦¦¦¦¦_   _¦¦_			  ¦
//	    ¯¦¦¦¦¦    	 ¦¦¦¦¦¯ ¯¦¦¦¦¦¦¦¯ ¯¦¦¦¦¦¦¦¯__¦¦_¯¦¦__        ¦¦¦
//		 ¦¦¦  ¦¦¦ ¦¦¦  ¦¦¦   ¦¦¦ 		 ¦¦¦   ¦¦¦   ¯¦¦¦      _¦¦¯¦¦_
//		 ¦¦¦    ¦¦¦    ¦¦¦	 ¦¦¦¦¦¦		 ¦¦¦   ¦¦¦  _¦¦¯¯	  ¦¦¦   ¦¦¦
//		 ¦¦¦      	   ¦¦¦	 ¦¦¦¯   	 ¦¦¦   ¦¦¦¯¦¦_		 ¦¦¦ ___ ¦¦¦
//		 ¦¦¦       	   ¦¦¦	 ¦¦¦		 ¦¦¦   ¦¦¦  ¯¦¦_    ¦¦¦¯     ¯¦¦¦
//		_¦¦¦_	  	  _¦¦¦_	_¦¦¦¦¦¦¦_   _¦¦¦_ _¦¦¦_  _¦¦¦_ _¦¦¦_     _¦¦¦_
//______________________________________________________________________________
//===============================www.Metra-Concept.fr===========================
//=======================Ancien site web : http://gta-mp.fr ====================

//===============================Includes=======================================
#include <a_samp>
#include <dudb>
#include <SInclude>
#include <textdraw>
//===============================Class Defines==================================
#define TEAM_ULTIMAN 0
#define TEAM_ULTIGIRL 1
#define TEAM_GOLFEUR 2
#define TEAM_TRIAD 3
#define TEAM_ARMEE 4
#define TEAM_VALET 5
#define TEAM_INFIRMIER 6
#define TEAM_FBI 7
#define TEAM_RICHE 9
#define TEAM_PILOTE 10
#define TEAM_DANANG 11
#define TEAM_STUNTMAN 8
#define TEAM_FORDEFEND 12
#define TEAM_FORATTACK 13
#define TEAM_RIDER 14
#define TEAM_PIMP 15

#define SLOTS 100

forward Float:GetXYInFrontOfPlayer(playerid, &Float:x, &Float:y, Float:distance);
forward IsPlayerNameOnline(compname[]);
forward SetupPlayerForClassSelection(playerid);
forward PlaySoundForPlayer(playerid, soundid);
forward dteamchatcmd(playerid,params[]);
forward dgravityplayercmd(playerid,params[]);
forward isPlayerInArea(playerID, Float:data[4]);
forward ctimer();
forward resetcount();
forward announcer();
forward scoreupdate(playerid);
forward SystemMsg(playerid,msg[]);
forward Settings();
forward SaveData();
forward SoundForAll(sound);
forward resetmessage();
forward GameModeExitFunc();
forward GetPlayers();
forward SetupPlayerForClassSelection(playerid);
forward PingCheck(playerid);
forward TimerFlash1(playerid);
forward TimerFlash2(playerid);
forward explosion1(playerid);
forward explosion2(playerid);
forward explosion3(playerid);
forward explosion4(playerid);
forward explosion5(playerid);
forward infini(playerid);
forward CreerPickup ();
forward bombmanoir(playerid);
forward helpserv(playerid);

enum SavePlayerPosEnum {
Float:LastX,
Float:LastY,
Float:LastZ
}
#define FILE_SETTINGS "settings.ini"
//===========================Sons===============================================
#define SOUND_MUSIC1							1062
#define SOUND_MUSIC2							1068
#define SOUND_MUSIC3							1076
#define SOUND_MUSIC4     						1097
#define SOUND_MUSIC5							1183
#define SOUND_MUSIC6    						1185
#define SOUND_MUSIC7							1187
#define SOUND_OFF                    			1184

//===========================Declaration des couleurs===========================
#define COLOR_GREEN 0x33AA33AA
#define COLOR_PINK 0xFF66FFAA
#define COLOR_BLUE 0x0000BBAA
#define COLOR_LIGHTBLUE 0x33CCFFAA
#define COLOR_ORANGE 0xFF9900AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_PURPLE 0x330066AA
#define COLOR_SKIN 0xFFCC99AA
#define COLOR_DARKGREY 0x333333AA
#define RED 0xFF0000AA
#define COLOR_INDIGO 0x4B00B0AA
#define COLOR_BRIGHTRED 0xDC143CAA
#define COLOR_AQUA 0x7CFC00AA
#define COLOR_SYSTEM 0xEFEFF7AA
#define COLOR_BLA 0x7CFC11AA
#define ADMIN_RED 0xFB0000FF
#define LIGHTGREEN 0x38FF06FF
#define YELLOW 0xFFFF00FF
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_RED 0xFF0606FF
#define COLOR_DARKRED 0x660000AA
#define COLOR_GREY 0xAFAFAFAA

#define CHECKPOINT_NONE 0

#define CHECKPOINT_PLANE 1

#define CHECKPOINT_AREA 2
#define cmd(%1) if((strcmp(cmdtext,%1,true,strlen(%1))==0)&&(((cmdtext[strlen(%1)]==0)&&(d%1(playerid,"")))||((cmdtext[strlen(%1)]==32)&&(d%1(playerid,cmdtext[strlen(%1)+1]))))) return 1
enum pInfo
{
    pAdmin,
    pJailedby,
}

new PlayerRegistered[MAX_PLAYERS];
new vehName[][] = { "Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel", "Dumper", "Firetruck", "Trashmaster", "Stretch", "Manana", "Infernus", "Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam", "Esperanto", "Taxi", "Washington", "Bobcat", "Whoopee", "BF Injection", "Hunter", "Premier",
"Enforcer", "Securicar", "Banshee", "Predator", "Bus", "Rhino", "Barracks", "Hotknife", "Trailer", "Previon", "Coach", "Cabbie", "Stallion", "Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral", "Squalo", "Seasparrow", "Pizzaboy", "Tram", "Trailer", "Turismo", "Speeder", "Reefer", "Tropic", "Flatbed", "Yankee", "Caddy",
"Solair", "Berkley's RC Van", "Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron", "RC Raider", "Glendale", "Oceanic", "Sanchez", "Sparrow", "Patriot", "Quad", "Coastguard", "Dinghy", "Hermes", "Sabre", "Rustler", "ZR-350", "Walton", "Regina", "Comet", "BMX", "Burrito", "Camper", "Marquis", "Baggage", "Dozer", "Maverick",
"News Chopper", "Rancher", "FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking", "Blista Compact", "Police Maverick", "Boxvillde", "Benson", "Mesa", "RC Goblin", "Hotring Racer A", "Hotring Racer B", "Bloodring Banger", "Rancher", "Super GT", "Elegant", "Journey", "Bike", "Mountain Bike", "Beagle", "Cropduster",
"Stunt", "Tanker", "Roadtrain", "Nebula", "Majestic", "Buccaneer", "Shamal", "Hydra", "FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Tow Truck", "Fortune", "Cadrona", "FBI Truck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer", "Remington", "Slamvan", "Blade", "Freight", "Streak", "Vortex", "Vincent", "Bullet", "Clover",
"Sadler", "Firetruck", "Hustler", "Intruder", "Primo", "Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada", "Yosemite", "Windsor", "Monster", "Monster", "Uranus", "Jester", "Sultan", "Stratum", "Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma", "Savanna", "Bandito", "Freight Flat", "Streak Carriage", "Kart", "Mower", "Dune",
"Sweeper", "Broadway", "Tornado", "AT-400", "DFT-30", "Huntley", "Stafford", "BF-400", "News Van", "Tug", "Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club", "Freight Box", "Trailer", "Andromada", "Dodo", "RC Cam", "Launch", "Police Car", "Police Car", "Police Car", "Police Ranger", "Picador", "S.W.A.T", "Alpha", "Phoenix",
"Glendale", "Sadler", "Luggage", "Luggage", "Stairs", "Boxville", "Tiller", "Utility Trailer" };
new gravityplayercmd[]  = "/grav";
new teamchatcmd[]  = "/t";
new gVC;
new playercount[MAX_PLAYERS];
new Calling[MAX_PLAYERS];
new Answered[MAX_PLAYERS];
new skinvar[MAX_PLAYERS];
new Callerid[MAX_PLAYERS];
new allowprofit[MAX_PLAYERS];
new buyable[MAX_PLAYERS];
new moneydef[MAX_PLAYERS];
new moneygag[MAX_PLAYERS];
new moneyresult[MAX_PLAYERS];
new motosou[MAX_PLAYERS];
new Count[MAX_PLAYERS];
new cseconds,cstring[40];
new PlayerInfo[MAX_PLAYERS][pInfo];
new moneyed[MAX_PLAYERS];
new carowned[MAX_PLAYERS];
new server[256];
new passenger[MAX_PLAYERS];
new gTeam[MAX_PLAYERS];
new Spawned[MAX_PLAYERS];
new welcome[MAX_PLAYERS];
new messaged[MAX_PLAYERS];
new used[MAX_PLAYERS];
new CashScoreOld;
new aMessage[MAX_PLAYERS];
new setd[MAX_PLAYERS];
new boxe[MAX_PLAYERS];
new dmanoir[MAX_PLAYERS];
new dm1[MAX_PLAYERS];
new dm2[MAX_PLAYERS];
new dm2s[MAX_PLAYERS];
new ford[MAX_PLAYERS];
new fora[MAX_PLAYERS];
new stadium[MAX_PLAYERS];
new dmvitre[MAX_PLAYERS];
new derby[MAX_PLAYERS];
new katana;
new chaise;
new fleche2;
new gPlayerCheckpointStatus[MAX_PLAYERS];
new gPlayerClass[MAX_PLAYERS];
new PlayerRequestNew[MAX_PLAYERS];
new Float:X,Float:Y,Float:Z;
new CounterID, String[32];
new textdra[MAX_PLAYERS];
new Text:textdrr0;
new Text:textdrr1;
new Text:textdrr2;
new flash1;
new flash2;
new flash3;
new flash4;
new flash5;
new flash6;
new flash7;
new flash8;
new flash9;
new dancestyle;
new NewCar[MAX_PLAYERS]=0;
new Float:x1, Float:y1, Float:z1;
new SaveP[MAX_PLAYERS] = 0;
new RewP[MAX_PLAYERS] = 0;
new cokt;
new flam;
new rifle1;
new Float:Pos[MAX_PLAYERS][4];
new tele1;
new tele2;
new tele3;
new deto;
new exmanoir[MAX_PLAYERS];
new menu1;
new Menu:teleport;
new Menu:teleport1;
new Menu:teleport2;
new Menu:teleport3;
new Menu:teleport4;
new hepPos;
new namePos;
new vehspec;
new timerbobgrav;
new miliveh;
new bob[][] =
{
	"[FR] *** Ultimate Stunt DM oO| Www.nomdedomaine.fr |Oo",
	"*** Ultimate ==> Fun | Stunt | DM |Race",
	"<== The Ultimate Server ! ==>[FR]",
	"oOo Ultimate Stunt DM :: 100% Original"
};


new hepp[][] =
{
	"*** Hey, viens casser des vitres en tapant /dmvitre ***",
	"*** Du juuuuuuuuuuuuump? Tape : /jump *** ",
	"*** Pour t'envoler, pour voir les petits zoizo tape : /funup *** ",
	"*** Enregistre l'ip dans tes favoris ;) : votre-ip:7777 *** ",
	"*** Que du stunt avec un magnifique 'Half-Pipe à /stunt1 *** ",
	"*** oOo, le roi de la moto, pour du cross c'est par ici : /cross *** ",
	"*** Participe à une course dans les airs ici : /race *** ",
	"*** Motos invisibles (oui oui invisible)...... ici : /motoin *** ",
	"*** Venez visiter notre communauté : www.nomdedomaine.fr *** ",
	"*** Du derby, de la pur démolition ? Ecrit /derby *** ",
	"*** Si tu n'as pas le vertige tape : /ligne *** ",
	"*** Participe à une course dans les airs ici : /race *** ",
	"*** Enregistre l'ip dans tes favoris ;) : votre-ip:7777 *** ",
	"*** Si tu veux détruire le 'Forfarmers'... /forfarmers *** ",
	"*** Pour rouler avec un véhicule plus que fun viens ici : /fveh *** ",
	"*** Youhou, Jacky, le roi du volant tape : /race5 *** ",
	"*** Viens faire péter le manoir ici : /manoir *** ",
	"*** Pour tuner ta caisse, écrit : /tuning *** ",
	"*** Enregistre l'ip dans tes favoris ;) : votre-ip:7777 *** ",
	"*** Ouhlala, ça tourne dans tout les sens ici : /vertigo *** ",
	"*** Pour voir toutes les commandes tape : /commandes *** "
};

new b1;
new b2;
new b3;
new b4;
new b5;
new b6;
new b7;
new b8;
new b9;
new b10;
new b11;
new b12;
new b13;
new b14;
new b15;
new b16;
new b17;
new b18;
new b19;
new b20;
new b21;
new b22;
new b23;
new b24;
new b25;
new b26;
new b27;
new b28;
new b29;
new b30;
new b31;
new b32;
new b33;
new b34;
new b35;
new b36;
new b37;
new b38;
new b39;
new b40;
new b41;
new b42;
new b43;
new b44;
new b45;
new b46;
new b47;
new b48;
new b49;
new b50;
new b51;
new b52;
new b53;
new b54;
new b55;
new b56;
new b57;
new b58;
new b59;
new b60;
new b61;
new b62;
new b63;
new b64;
new b65;
new b66;
new b67;
new b68;
new b69;
new b70;
new b71;
new b72;
new b73;
new b74;
new b75;
new b76;
new b77;
new b78;
new b79;
new b80;
new b81;
new b82;
new b83;
new b84;
new b85;
new b86;
new b87;
new b88;
new b89;
new b90;
new b91;
new b92;
new b93;
new b94;
new b95;
new b96;
new b97;
new b98;
new b99;
new b100;
new b101;
new b102;
new b103;
new b104;
new b105;
new b106;
new b107;
new b108;
new b109;
new b110;
new b111;
new b112;
new b113;
new b114;
new b115;
new b116;
new b117;
new b118;
new b119;
new b120;
new b121;
new b122;
new b123;
new b124;
new b125;
new b126;
new b127;
new b128;
new b129;
new b130;
new b131;
new b132;
new b133;
new b134;
new b135;
new b136;
new b137;
new b138;
new b139;
new b140;
new b141;
new b142;
new b143;
new b144;
new b145;
new b146;
new b147;
new b148;
new b149;
new b150;
new b151;
new b152;
new b153;
new b154;
new b155;
new b156;
new b157;
new b158;
new b159;
new b160;
new b161;
new b162;
new b163;
new b164;
new b165;
new b166;
new b167;
new b168;
new b169;
new b170;
new b171;
new b172;
new b173;
new b174;
new b175;
new b176;
new b177;
new b178;
new b179;
new b180;
new b181;
new b182;
new b183;
new perso1;
new perso2;
new perso3;
new perso4;
new perso5;
new perso6;
new perso7;
new perso8;
new perso9;
new perso10;
new perso11;
new perso12;
new perso13;
new perso14;
new perso15;
new perso16;
new perso17;
new perso19;
new perso20;
new perso21;
new perso22;
new perso23;
new perso24;
new perso25;
new perso26;
new perso28;
new perso29;
new perso30;
new perso31;
new perso32;
new perso33;
new perso34;
enum Float:Pos2{ Float:sX,Float:sY,Float:sZ };
new Text:lbt;
new Text:lbb;
new string2[256];
new Text:loading;
new concons1[][] =
{
"viens d'arriver sur le serveur.",
"nous rejoins sur Ultimate Stunt DM.",
", nous te souhaitons la bienvenue."
};
new poinco;
//================================More Defines==================================
new logged[MAX_PLAYERS];
new PlayerInterior[MAX_PLAYERS];

//================================Global Defines================================


stock IsPlayerInArea(playerid,Float:max_x,Float:min_x,Float:max_y,Float:min_y)
{
GetPlayerPos(playerid, X, Y, Z); // On récupére la position du joueur
if(X <= max_x && X >= min_x && Y <= max_y && Y >= min_y) { // Si le joueur est dans les cordonnées à définir
return 1;
}
return 0;
}


//================================Main Info=====================================
				main()
				{
				print(" ");
				print("\n------------------------");
				print(" ULTIMATE STUNT DM by Metra (Metra-concept.fr)");
				print("--------------------------\n");}


public OnPlayerText(playerid, text[])
{
	if (Calling[playerid] > -1 && Answered[playerid] == 1)
	{
    	new string[256];
		new sendername[MAX_PLAYER_NAME];
		GetPlayerName(playerid, sendername, sizeof(sendername));
		format(string, sizeof(string), "%s: %s", sendername, text);
		SendClientMessage(Calling[playerid], COLOR_YELLOW, string);
		format(string, sizeof(string), "%s: %s", sendername, text);
		SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
		format(string, sizeof(string), "%s: %s", sendername, text);
		print(string);
		format(string, sizeof(string), "%s: %s", sendername, text);
		print(string);

		return 0;
	}

    if(dm1[playerid] == 1)
    {
    	new string[256];
		new sendername[MAX_PLAYER_NAME];
		GetPlayerName(playerid, sendername, sizeof(sendername));
		format(string, sizeof(string), "[DM]%s: %s", sendername, text);
		SendClientMessageToAll(COLOR_WHITE, string);
		return 0;
    }

    if(dm2[playerid] == 1)
    {
    	new string[256];
		new sendername[MAX_PLAYER_NAME];
		GetPlayerName(playerid, sendername, sizeof(sendername));
		format(string, sizeof(string), "[DM]%s: %s", sendername, text);
		SendClientMessageToAll(COLOR_WHITE, string);
		return 0;
    }

    if(stadium[playerid] == 1)
    {
    	new string[256];
		new sendername[MAX_PLAYER_NAME];
		GetPlayerName(playerid, sendername, sizeof(sendername));
		format(string, sizeof(string), "[DM]%s: %s", sendername, text);
		SendClientMessageToAll(COLOR_WHITE, string);
		return 0;
    }

    if(dmvitre[playerid] == 1)
    {
    	new string[256];
		new sendername[MAX_PLAYER_NAME];
		GetPlayerName(playerid, sendername, sizeof(sendername));
		format(string, sizeof(string), "[DM]%s: %s", sendername, text);
		SendClientMessageToAll(COLOR_WHITE, string);
		return 0;
    }

    if(derby[playerid] == 1)
    {
    	new string[256];
		new sendername[MAX_PLAYER_NAME];
		GetPlayerName(playerid, sendername, sizeof(sendername));
		format(string, sizeof(string), "[DM]%s: %s", sendername, text);
		SendClientMessageToAll(COLOR_WHITE, string);
		return 0;
    }

    if(boxe[playerid] == 1)
    {
    	new string[256];
		new sendername[MAX_PLAYER_NAME];
		GetPlayerName(playerid, sendername, sizeof(sendername));
		format(string, sizeof(string), "[DM]%s: %s", sendername, text);
		SendClientMessageToAll(COLOR_WHITE, string);
		return 0;
    }
    
    if(dmanoir[playerid] == 1)
    {
    	new string[256];
		new sendername[MAX_PLAYER_NAME];
		GetPlayerName(playerid, sendername, sizeof(sendername));
		format(string, sizeof(string), "[DM]%s: %s", sendername, text);
		SendClientMessageToAll(COLOR_WHITE, string);
		return 0;
    }
    
	if ((strcmp("Salut", text, true, strlen(text)) == 0) && (strlen(text) == strlen("Salut")))
{
ApplyAnimation(playerid,"PED","endchat_03",4.1,0,1,0,1,1);

}
	if ((strcmp("slt", text, true, strlen(text)) == 0) && (strlen(text) == strlen("slt")))
{
ApplyAnimation(playerid,"PED","endchat_03",4.1,0,1,0,1,1);

}

	if ((strcmp("bjr", text, true, strlen(text)) == 0) && (strlen(text) == strlen("bjr")))
{
ApplyAnimation(playerid,"PED","endchat_03",4.1,0,1,0,1,1);

}

	if ((strcmp("bonjour", text, true, strlen(text)) == 0) && (strlen(text) == strlen("bonjour")))
{
ApplyAnimation(playerid,"PED","endchat_03",4.1,0,1,0,1,1);

}
	if ((strcmp("lu", text, true, strlen(text)) == 0) && (strlen(text) == strlen("lu")))
{
ApplyAnimation(playerid,"PED","endchat_03",4.1,0,1,0,1,1);

}
	if ((strcmp("lut", text, true, strlen(text)) == 0) && (strlen(text) == strlen("lut")))
{
ApplyAnimation(playerid,"PED","endchat_03",4.1,0,1,0,1,1);

}
	if ((strcmp("hey", text, true, strlen(text)) == 0) && (strlen(text) == strlen("hey")))
{
ApplyAnimation(playerid,"PED","endchat_03",4.1,0,1,0,1,1);

}
	if ((strcmp("hello", text, true, strlen(text)) == 0) && (strlen(text) == strlen("hello")))
{
ApplyAnimation(playerid,"PED","endchat_03",4.1,0,1,0,1,1);

}
	if ((strcmp("hi", text, true, strlen(text)) == 0) && (strlen(text) == strlen("hi")))
{
ApplyAnimation(playerid,"PED","endchat_03",4.1,0,1,0,1,1);

}
	if ((strcmp("bjr all", text, true, strlen(text)) == 0) && (strlen(text) == strlen("bjr all")))
{
ApplyAnimation(playerid,"PED","endchat_03",4.1,0,1,0,1,1);

}
	if ((strcmp("lu all", text, true, strlen(text)) == 0) && (strlen(text) == strlen("lu all")))
{
ApplyAnimation(playerid,"PED","endchat_03",4.1,0,1,0,1,1);

}
	if ((strcmp("cc", text, true, strlen(text)) == 0) && (strlen(text) == strlen("lu all")))
{
ApplyAnimation(playerid,"PED","endchat_03",4.1,0,1,0,1,1);

}
	if ((strcmp("cc all", text, true, strlen(text)) == 0) && (strlen(text) == strlen("lu all")))
{
ApplyAnimation(playerid,"PED","endchat_03",4.1,0,1,0,1,1);

}
	if ((strcmp("bitch", text, true, strlen(text)) == 0) && (strlen(text) == strlen("bitch")))
{
SendClientMessageToAll(COLOR_PINK,"Admin: Les insultes sont interdites ! !");
}
	if ((strcmp("fuck", text, true, strlen(text)) == 0) && (strlen(text) == strlen("fuck")))
{
SendClientMessageToAll(COLOR_PINK,"Admin: Les insultes sont interdites ! !");
}
	if ((strcmp("merde", text, true, strlen(text)) == 0) && (strlen(text) == strlen("*****")))
{
SendClientMessageToAll(COLOR_PINK,"Admin: Parle correctement ! !");
}
	return 1;
}
//================================GameMode Exit=================================
public OnGameModeExit()
{

    UsePlayerPedAnims();
	dini_IntSet(FILE_SETTINGS,"vehicleresetcount",gVC);
	return 1;
}
//===============================Gamemode Start=================================
public OnGameModeInit()
{
	print("\n \nGameModeInit(Ultimate R5)");
	SetGameModeText("Stunt/DM/Race");
    AllowInteriorWeapons(1);
    AllowAdminTeleport (1);
    UsePlayerPedAnims();
	ShowNameTags(1);
	ShowPlayerMarkers(1);
	SetWorldTime(12);
	SetTimer("SaveData",1000,1);
    SetTimer("Settings",1000,1);
    SetTimer("scoreupdate",1000,1);
    SetTimer("ctimer",1000,1);
    SetTimer("TimerFlash1", 800, 1);
    SetTimer("TimerFlash2", 1200, 1);
	SetTimer("helpserv", 120000, 1);
//==============================ALL GAME TEAMS==================================
    AddPlayerClass(165,1614.9872,-2546.6929,13.6118,90.1026,23,170,25,60,30,360); //Ultiman
    AddPlayerClass(193,2336.0127,-1063.9725,1049.0234,276.6525,28,300,24,100,4,1); //Ultigirl
	AddPlayerClass(259,-2642.2583,-274.9985,8.3506,135.0036,25,80,32,300,2,1); //Golfer
	AddPlayerClass(294,-2188.8037,609.8431,36.2624,82.8703,32,300,30,390,4,1); //Triad
	AddPlayerClass(287,-1377.4271,466.0897,8.9393,1.0348,26,80,31,300,23,170); // Army
	AddPlayerClass(253,-1754.9976,958.5851,25.8386,163.2550,28,300,24,100,4,1); //Valet
	AddPlayerClass(274,-2665.4282,635.6348,16.0054,179.8403,26,100,23,170,9,1); //Medic
	AddPlayerClass(286,-1635.0077,665.8105,8.4054,264.2244,29,360,27,100,3,1); //FBI
	AddPlayerClass(34,-2052.3101,-142.4197,35.3203,357.5560,22,100,5,100,31,200); //Stuntman
	AddPlayerClass(295,-2664.8037,938.6110,80.7618,180.7716,27,100,24,100,28,400); //Rich
	AddPlayerClass(61,-1358.6774,-243.8737,15.6769,315.6869,22,170,25,60,14,1); // Pilot
	AddPlayerClass(122,-1430.1825,1492.3381,8.0482,91.3221,24,70,27,77,28,300); //Da Nang
	AddPlayerClass(158,-282.4652,-1332.4438,7.7677,-268.4413,5,1,31,400,34,50); //Fordefend
    AddPlayerClass(206,-378.6329,-1418.9111,25.7266,351.1076,26,80,31,400,23,170); //Forattack
	AddPlayerClass(217,312.4999,-1798.2933,4.5453,89.4093,22,100,5,100,31,200); //Rider
	AddPlayerClass(296,-2640.3687,1366.7942,7.1447,150.9731,26,100,29,360,15,1); //Pimp

//========================ALL GAME VEHICLES PICKUPS AND OBJECTS=========================

    flash1 = AddStaticVehicle(522,2206.1633,-1160.7301,25.3022,272.4089,0,3);

    flash2 = AddStaticVehicle(522,2206.8352,-1152.9868,25.3075,269.5026,6,10);
    
    flash3 = AddStaticVehicle(522,2206.7314,-1169.1262,25.2953,270.2662,4,11);
    
    flash4 = AddStaticVehicle(522,2206.6699,-1176.9222,25.3004,269.5915,23,2);
    
    flash5 = AddStaticVehicle(429,2217.0862,-1166.7008,25.4063,269.1339,184,185);
    
    flash6 = AddStaticVehicle(429,2217.0334,-1161.5881,25.4063,271.1920,9,3);
    
    flash7 = AddStaticVehicle(541,2227.8525,-1173.6556,25.3523,89.0990,7,12);
    
    flash8 = AddStaticVehicle(416,2226.3032,-1162.9703,25.9022,89.7317,1,1);
    
    flash9 = AddStaticVehicle(411,2227.8125,-1156.0602,25.5365,89.1830,252,252);

    vehspec = AddStaticVehicle(411,2216.8157,-1157.1687,25.4536,270.0455,-1,-1);

    
    AddStaticVehicle(457,-2652.9031,-297.2605,8.0617,315.6009,-1,-1);

	AddStaticVehicle(457,-2659.7441,-289.6562,8.0920,313.6239,-1,-1);

	AddStaticVehicle(457,-2642.9949,-301.7552,8.0090,47.6567,-1,-1);

	AddStaticVehicle(421,-2681.7434,-276.2391,8.0605,44.2241,-1,-1);

	AddStaticVehicle(411,-2645.5964,1376.7522,7.8935,267.8349,-1,-1);

	AddStaticVehicle(409,-2628.6924,1377.4845,7.9350,180.7913,-1,-1);

	AddStaticVehicle(409,-2633.1638,1332.7010,7.9953,269.6430,-1,-1);

	AddStaticVehicle(522,-2151.1257,629.7889,52.8293,180.7068,-1,-1);

	AddStaticVehicle(446,-1571.3143,1263.2914,1.2879,269.1020,-1,-1);

	AddStaticVehicle(446,-1720.0265,1436.3821,1.4272,3.3108,-1,-1);

	AddStaticVehicle(522,-1654.1005,1211.9901,14.2380,315.9562,-1,-1);

	AddStaticVehicle(415,-1660.4161,1213.3704,8.0209,295.4768,-1,-1);

	AddStaticVehicle(415,-1553.3494,1089.8568,7.9584,89.1789,-1,-1);

	AddStaticVehicle(420,-1497.4607,845.8477,7.9671,88.5197,-1,-1);

	AddStaticVehicle(421,-1699.4597,1035.9624,46.0932,91.6588,-1,-1);

	AddStaticVehicle(539,-1835.1257,1425.9342,1.5476,184.1130,-1,-1);

	AddStaticVehicle(539,-2441.2109,1414.1995,1.4429,86.1079,-1,-1);

	AddStaticVehicle(547,-2438.0117,1340.9783,8.7316,86.7979,-1,-1);

	AddStaticVehicle(411,-2166.5498,1251.0760,28.2782,1.6030,-1,-1);

	AddStaticVehicle(411,-2636.3838,932.3286,72.5378,187.1212,-1,-1);

	AddStaticVehicle(461,-2566.5906,989.6594,78.8568,358.1472,-1,-1);

	AddStaticVehicle(461,-2464.8860,896.7036,63.6223,0.6326,-1,-1);

	AddStaticVehicle(400,-2459.9055,786.4501,36.2643,89.8722,-1,-1);

	AddStaticVehicle(400,-2673.5830,802.1517,51.0693,0.3607,-1,-1);

	AddStaticVehicle(446,-2970.6746,497.2838,1.3557,4.0073,-1,1);

	AddStaticVehicle(444,-2902.7820,342.5712,6.3723,138.7612,-1,-1);

	AddStaticVehicle(444,-2876.3977,26.3173,7.2123,118.5961,-1,-1);

	AddStaticVehicle(470,-1382.4279,455.8060,7.1838,359.9849,-1,-1);

	AddStaticVehicle(470,-1439.3396,455.1034,7.1739,0.1531,-1,-1);

	AddStaticVehicle(476,-1433.3817,-504.8247,15.8794,158.2625,-1,-1);

	AddStaticVehicle(476,-1464.6495,-522.4009,15.8899,234.2019,-1,-1);

	AddStaticVehicle(593,-1354.2429,-467.9689,15.6386,162.9646,-1,-1);

	AddStaticVehicle(593,-1387.8518,-484.0513,15.6341,247.9289,-1,-1);

	AddStaticVehicle(487,-1162.1279,-460.9374,15.3257,53.8622,-1,-1);

	AddStaticVehicle(553,-1317.8910,-260.4665,16.4827,288.2876,-1,-1);

	AddStaticVehicle(553,-1362.9397,-183.5522,16.4848,308.6994,-1,-1);

	AddStaticVehicle(447,-1187.9520,26.1456,15.1604,45.3312,-1,-1);

	AddStaticVehicle(447,-1222.7996,-10.4235,15.1594,45.5780,-1,-1);

	AddStaticVehicle(475,-1872.5575,-820.7949,32.8273,90.7921,-1,-1);

	AddStaticVehicle(444,-1898.3019,-915.5814,33.3947,91.2857,-1,-1);

	AddStaticVehicle(496,-2124.4800,-929.0856,32.7397,269.1853,-1,-1);

	AddStaticVehicle(496,-2133.3015,-847.1439,32.7396,88.8312,-1,-1);

	AddStaticVehicle(429,-2664.9673,268.9968,5.0156,357.6026,-1,-1);

	AddStaticVehicle(420,-2626.5276,-53.6779,5.1144,357.7703,-1,-1);

	AddStaticVehicle(434,-2718.5354,-124.4790,5.3071,269.1429,-1,-1);

	AddStaticVehicle(434,-2487.5295,-125.3075,26.5715,90.9363,-1,-1);

	AddStaticVehicle(400,-2486.0298,51.5018,27.7954,177.2178,-1,-1);

	AddStaticVehicle(400,-2574.9736,146.5981,5.4279,1.8790,-1,-1);

	AddStaticVehicle(549,-1741.0009,811.0599,25.5879,270.6703,-1,-1);

	AddStaticVehicle(549,-1920.7559,875.2713,36.1113,270.0973,-1,-1);

	AddStaticVehicle(500,-2040.4465,1107.7076,54.4032,89.8491,-1,-1);

	AddStaticVehicle(500,-1968.8488,465.6065,36.2766,89.3124,-1,-1);

	AddStaticVehicle(429,-1687.9076,1003.5587,18.2656,91.3972,-1,-1);

	AddStaticVehicle(439,-1704.8613,1058.0004,18.4810,182.3475,-1,-1);

	AddStaticVehicle(480,-1735.9534,1016.0621,18.3580,268.5771,-1,-1);

	AddStaticVehicle(400,-2782.3508,442.1533,5.5383,57.1401,-1,-1);

	AddStaticVehicle(400,-2836.3665,865.6495,44.1470,268.7662,-1,-1);

	AddStaticVehicle(415,-2899.3823,1112.4786,27.3954,268.9744,-1,-1);

	AddStaticVehicle(516,-2654.5662,615.2198,15.2873,0.1598,-1,-1);

	AddStaticVehicle(416,-2618.7363,627.2617,15.6024,179.6464,-1,-1);

	AddStaticVehicle(516,-1904.3373,-599.6174,24.4277,344.2378,-1,-1);

	AddStaticVehicle(475,-1639.3912,-567.4948,13.9482,80.1914,-1,-1);

	AddStaticVehicle(475,-1405.5500,-309.2615,13.9504,174.9827,-1,-1);

	AddStaticVehicle(475,-2132.1143,160.2086,35.1341,270.0023,-1,-1);

	AddStaticVehicle(500,-2151.4924,428.9210,35.1902,176.6156,-1,-1);

	AddStaticVehicle(500,-2304.8279,360.0154,35.2835,201.6184,-1,-1);

	AddStaticVehicle(522,-1696.7413,977.0867,17.1574,7.0263,-1,-1);

	AddStaticVehicle(429,-2641.7395,1333.0645,6.8700,356.7557,-1,-1);

	AddStaticVehicle(457,-2650.6292,-280.5106,7.0874,132.0127,-1,-1);

	AddStaticVehicle(421,-1409.6693,456.0711,7.0672,3.2988,-1,-1);

	AddStaticVehicle(487,-1681.5756,706.4234,30.7777,266.5047,-1,-1);

    AddStaticVehicle(603,-2617.2964,1349.0765,7.0217,358.1852,-1,-1);

	AddStaticVehicle(475,-2129.8242,288.0418,34.9864,269.9582,-1,-1);

	AddStaticVehicle(475,-2664.0950,-259.9579,6.5482,74.4868,-1,-1);

	AddStaticVehicle(597,-1628.6875,652.5107,6.9568,0.9097,-1,-1);

	AddStaticVehicle(597,-1616.7957,652.5980,6.9551,0.6199,-1,-1);

	AddStaticVehicle(597,-1594.2644,672.5858,6.9564,176.7420,-1,-1);

    AddStaticVehicle(597,-1593.5823,652.3891,6.9567,1.3142,0,1);

	AddStaticVehicle(597,-1611.9730,673.5499,6.9567,181.6088,0,1);

    //divers

    AddStaticVehicle(522,-2245.6775,650.2472,49.0214,5.3371,51,118);

	AddStaticVehicle(489,-2275.7500,648.7062,49.5895,179.1701,14,123);

    AddStaticVehicle(522,-2719.0620,980.9500,54.0246,0.5909,39,106);

    AddStaticVehicle(541,-2315.1248,-126.6856,34.9375,1.0982,60,1);

    AddStaticVehicle(405,-2326.4458,-126.8906,35.1875,0.0172,75,1);

	AddStaticVehicle(522,-2337.5034,-127.0731,34.8748,178.4558,51,118);

    AddStaticVehicle(411,-1749.7599,911.1860,24.5409,272.1891,75,1);

    //vehicules rajoutes oOo

    //vehicule a cross

	AddStaticVehicle(522, -1420.006592, -966.554321, 200.443192, 271, -1, -1);

	AddStaticVehicle(522, -1439.559814, -942.044067, 200.940979, 169, -1, -1);

	AddStaticVehicle(522, -1436.513062, -942.672668, 200.940979, 169, -1, -1);

	AddStaticVehicle(424, -1427.335571, -944.246216, 200.940979, 170, -1, -1);

	AddStaticVehicle(424, -1433.402710, -943.219727, 200.940979, 170, -1, -1);

	AddStaticVehicle(521, -1435.671875, -959.242737, 200.869949, 340, -1, -1);

	AddStaticVehicle(521, -1427.331787, -958.952759, 200.717346, 340, -1, -1);

	AddStaticVehicle(521, -1423.705688, -959.068298, 200.650879, 340, -1, -1);

	AddStaticVehicle(471, -1429.182739, -964.629639, 200.748474, 271, -1, -1);

	AddStaticVehicle(471, -1442.125488, -953.456238, 200.940979, 271, -1, -1);

	AddStaticVehicle(468, -1441.926514, -950.434448, 200.940979, 271, -1, -1);

	AddStaticVehicle(468, -1423.753540, -944.744019, 200.940979, 170, -1, -1);

	AddStaticVehicle(468, -1420.339233, -945.249817, 200.940979, 170, -1, -1);

	AddStaticVehicle(522, -1441.481812, -947.182434, 200.940979, 273, -1, -1);

    //vehicule a desert

	AddStaticVehicle(513, 422.602478, 2515.322754, 17.269133, 89, -1, -1);

	AddStaticVehicle(513, 421.786499, 2496.330078, 17.269133, 89, -1, -1);

	AddStaticVehicle(513, 407.831177, 2507.418945, 17.269133, 89, -1, -1);

	AddStaticVehicle(487, 350.149628, 2536.558594, 17.269133, 180, -1, -1);

 	AddStaticVehicle(522, 349.825775, 2477.856445, 17.269133, 0, -1, -1);

	AddStaticVehicle(522, 361.017517, 2478.155029, 17.269133, 0, -1, -1);

	AddStaticVehicle(522, 370.609924, 2478.127197, 17.269133, 0, -1, -1);

	AddStaticVehicle(522, 355.344879, 2478.441895, 17.269133, 0, -1, -1);

	AddStaticVehicle(522, 365.836761, 2478.121338, 17.269133, 0, -1, -1);

	AddStaticVehicle(444, 386.890198, 2483.457520, 15.876120, 0, -1, -1);

	AddStaticVehicle(444, 391.438843, 2482.893799, 15.876120, 0, -1, -1);

	AddStaticVehicle(444, 395.943909, 2483.107422, 15.876120, 0, -1, -1);

	AddStaticVehicle(444, 401.203613, 2483.125488, 15.876120, 0, -1, -1);

    //vehicule a stunt

	AddStaticVehicle(468, -2072.623291, -108.402962, 35.071072, 180, -1, -1);

	AddStaticVehicle(468, -2074.933105, -108.155403, 35.077393, 180, -1, -1);

	AddStaticVehicle(471, -2077.837646, -107.632278, 35.077393, 180, -1, -1);

	AddStaticVehicle(471, -2080.634766, -108.026932, 35.070313, 180, -1, -1);

	AddStaticVehicle(521, -2083.396973, -107.781792, 35.077393, 180, -1, -1);

	AddStaticVehicle(521, -2085.806885, -107.766632, 35.070313, 180, -1, -1);

	AddStaticVehicle(429, -2013.740112, -116.844887, 35.013042, 180, -1, -1);

	AddStaticVehicle(429, -2017.744507, -109.313278, 34.820797, 180, -1, -1);

	AddStaticVehicle(429, -2013.812622, -108.985321, 34.965363, 180, -1, -1);

	AddStaticVehicle(522, -2088.726807, -108.083244, 34.820797, 180, -1, -1);

	AddStaticVehicle(522, -2091.457520, -107.850830, 34.820797, 180, -1, -1);

	AddStaticVehicle(522, -2093.985840, -108.254608, 34.820797, 180, -1, -1);

    //vehicules a aiport

	AddStaticVehicle(513, -1259.961914, -125.598289, 15.148514, 134, -1, -1);

	AddStaticVehicle(513, -1250.012695, -133.847580, 15.148514, 134, -1, -1);

 	AddStaticVehicle(513, -1240.473877, -141.157761, 15.148514, 134, -1, -1);

	AddStaticVehicle(513, -1231.777100, -145.939209, 15.148514, 134, -1, -1);

 	AddStaticVehicle(513, -1224.880737, -153.185959, 15.148514, 134, -1, -1);

 	AddStaticVehicle(506, -1250.699341, -33.301178, 15.148514, 134, -1, -1);

  	AddStaticVehicle(506, -1278.722168, -0.169319, 15.148514, 134, -1, -1);

  	AddStaticVehicle(592, -1661.657227, -169.425110, 15.148510, 316, -1, -1);

  	AddStaticVehicle(425, -1561.645386, -245.713440, 15.148510, 44, -1, -1);

  	AddStaticVehicle(425, -1584.869141, -268.620605, 15.148510, 44, -1, -1);

    //vehicules a stadium

    AddStaticVehicle(522, 995.952148, -1275.194458, 651.667175, 0, -1,-1);

    AddStaticVehicle(411, 1008.673401, -1249.984985, 651.579041, 0, -1,-1);

    AddStaticVehicle(451, 1008.421143, -1256.198730, 651.579041, 0, -1,-1);

    AddStaticVehicle(428, 1008.004150, -1264.528931, 651.579041, 0, -1,-1);

    AddStaticVehicle(422, 1007.969299, -1273.262329, 651.579041, 0, -1,-1);

    AddStaticVehicle(427, 989.929138, -1275.767334, 651.579041, 0, -1,-1);

    AddStaticVehicle(525, 984.837097, -1275.439697, 651.579041, 0, -1,-1);

    AddStaticVehicle(415, 977.772461, -1274.272705, 651.579041, 0, -1,-1);

    AddStaticVehicle(541, 978.709900, -1265.982544, 651.579041, 0, -1,-1);

    AddStaticVehicle(411, 978.258179, -1257.341919, 651.579041, 0, -1,-1);

    AddStaticVehicle(451, 978.662354, -1248.953857, 651.579041, 0, -1,-1);

    //vehicule a parking diver

	AddStaticVehicle(402, -2081.009766, -84.911957, 35.104061, 0, -1, -1);

	AddStaticVehicle(405, -2072.546387, -84.712990, 35.104061, 0, -1, -1);

	AddStaticVehicle(477, -2068.574219, -84.755112, 35.104061, 180, -1, -1);

	AddStaticVehicle(475, -2089.424316, -85.070526, 35.104061, 180, -1, -1);

 	AddStaticVehicle(521, -2058.935059, -85.875534, 35.260311, 168, -1, -1);

	AddStaticVehicle(463, -2038.786987, -88.697350, 35.260311, 214, -1, -1);

	AddStaticVehicle(521, -1575.276245, 682.704895, 7.127500, 11, -1, -1);

	AddStaticVehicle(463, -1578.427246, 683.325867, 7.127500, 338, -1, -1);

    //vehicule a race

    AddStaticVehicle(522, 2420.553223, -1870.983765, 466.666779, 0, -1,-1);

    AddStaticVehicle(521, 2420.549805, -1874.168091, 466.666779, 0, -1,-1);

    AddStaticVehicle(521, 2420.803223, -1876.974121, 466.666779, 0, -1,-1);

    AddStaticVehicle(522, 2421.175537, -1880.270142, 466.666779, 0, -1,-1);

    AddStaticVehicle(522, 2421.179688, -1883.103638, 466.666779, 0, -1,-1);

    AddStaticVehicle(521, 2420.603760, -1886.734131, 466.666779, 0, -1,-1);

    AddStaticVehicle(521, 2441.453613, -1875.375732, 466.666779, 0, -1,-1);

    AddStaticVehicle(522, 2433.683838, -1877.951782, 466.666779, 0, -1,-1);

    AddStaticVehicle(522, 2929.822510, -1757.356934, 467.397827, 0, -1,-1);

    AddStaticVehicle(451, 2929.441895, -1748.663086, 467.397827, 0, -1,-1);

    AddStaticVehicle(411, 2929.499023, -1737.696167, 467.397827, 0, -1,-1);

    AddStaticVehicle(415, 2935.998291, -1735.629028, 467.397827, 0, -1,-1);

    AddStaticVehicle(541, 2941.365723, -1735.020508, 467.397827, 0, -1,-1);

    AddStaticVehicle(451, 2946.041016, -1734.271606, 467.397827, 0, -1,-1);

    AddStaticVehicle(411, 2950.908447, -1733.950073, 467.397827, 0, -1,-1);

    AddStaticVehicle(415, 2955.323242, -1733.857910, 467.397827, 0, -1,-1);

    AddStaticVehicle(541, 2960.840576, -1737.029541, 467.397827, 0, -1,-1);

    AddStaticVehicle(451, 2961.478271, -1746.886108, 467.397827, 0, -1,-1);

    AddStaticVehicle(411, 2961.544678, -1757.029175, 467.397827, 0, -1,-1);

    AddStaticVehicle(415, 2960.869629, -1768.226563, 467.397827, 0, -1,-1);

    AddStaticVehicle(541, 2939.967041, -1750.521973, 467.397827, 0, -1,-1);

    AddStaticVehicle(451, 2943.360352, -1750.439819, 467.397827, 0, -1,-1);

    AddStaticVehicle(522, 2946.164307, -1750.250366, 467.397827, 0, -1,-1);

    //vehicule skatepark

    AddStaticVehicle(522,1909.7806,-1415.5347,13.1464,0.0815,0,3); //

    AddStaticVehicle(522,1910.9434,-1415.5455,13.1415,355.2513,-1,-1); //

    AddStaticVehicle(522,1912.0858,-1415.5300,13.1302,354.9190,7,3); //

    AddStaticVehicle(522,1914.6873,-1415.5310,13.1429,353.9939,-1,-1);//

    AddStaticVehicle(522,1913.3052,-1415.5922,13.1287,4.0974,-1,-1); //

    AddStaticVehicle(522,1915.9277,-1415.4800,13.1348,2.6831,-1,-1); //

    AddStaticVehicle(522,1917.4435,-1415.2448,13.1418,0.4740,5,8); //

    AddStaticVehicle(462,1918.8790,-1415.0360,13.1591,1.9341,-1,-1); //

    AddStaticVehicle(462,1920.1221,-1414.8804,13.1684,358.6682,-1,-1); //

    //vehicule waterace

    AddStaticVehicle(468,-745.7382,1991.5110,-34.7996,197.6500,-1,-1); //

    AddStaticVehicle(468,-743.6007,1991.8746,-34.7997,194.0701,-1,-1); //

    AddStaticVehicle(468,-740.7604,1992.7845,-34.8124,197.8607,-1,-1); //

    AddStaticVehicle(468,-736.6630,1993.0947,-34.7996,194.4061,-1,-1); //

    AddStaticVehicle(468,-733.7203,1993.9941,-34.7997,188.1198,-1,-1); //

    AddStaticVehicle(522,-720.1223,1995.0616,-34.9449,187.1708,-1,-1);//

    AddStaticVehicle(522,-717.0360,1995.2021,-35.0211,184.2834,-1,-1);//

    AddStaticVehicle(522,-713.9346,1995.4775,-35.1080,183.0845,-1,-1); //

    AddStaticVehicle(522,-709.8032,1995.4640,-35.2393,182.7102,-1,-1); //

    //vehicule laconca

    AddStaticVehicle(521,2491.5632,1635.6759,10.3903,90.8506,-1,-1); //

    AddStaticVehicle(522,2491.4653,1636.9285,10.3914,93.5857,-1,-1); //

    AddStaticVehicle(521,2491.2214,1638.3958,10.3863,93.2700,-1,-1); //

    AddStaticVehicle(522,2490.9788,1640.3896,10.3931,93.9141,-1,-1); //

    AddStaticVehicle(522,2490.9734,1641.4838,10.3857,92.3588,-1,-1); //

    AddStaticVehicle(522,2490.4954,1643.1067,10.3800,91.7510,-1,-1); //

    AddStaticVehicle(463,2490.7830,1644.3204,10.3607,93.6772,-1,-1); //

    AddStaticVehicle(477,2363.3855,1662.2053,10.5721,270.6446,-1,-1); //

    AddStaticVehicle(562,2363.1846,1655.7175,10.4782,272.1195,-1,-1); //

    AddStaticVehicle(475,2400.6006,1677.2255,10.6304,179.1752,-1,-1); //

    AddStaticVehicle(419,2445.7405,1629.0875,10.6202,0.0258,-1,-1); //

    AddStaticVehicle(402,2452.1650,1629.3500,10.6301,359.1411,-1,-1); //

    AddStaticVehicle(415,2458.5864,1629.3011,10.5795,359.7593,-1,-1); //

    AddStaticVehicle(429,2461.6948,1629.3915,10.4803,1.1390,-1,-1); //

    AddStaticVehicle(475,2468.4211,1629.1573,10.6382,359.7437,-1,-1); //

    AddStaticVehicle(562,2502.0969,1648.5062,10.4804,0.9654,-1,-1); //

    AddStaticVehicle(587,2479.4358,1658.4441,10.5535,180.3693,-1,-1); //

    //véhicules divers

    AddStaticVehicle(522,2573.0396,-1327.0040,777.6523,354.7666,-1,-1); //

    AddStaticVehicle(522,2565.1938,-1327.7688,777.6431,2.5471,-1,-1); //

    AddStaticVehicle(522,2556.8965,-1327.5404,777.6466,3.3648,-1,-1); //

    AddStaticVehicle(411,2581.9331,-1296.3937,777.8042,87.4269,-1,-1); //

    AddStaticVehicle(444,2582.0532,-1316.1516,778.4467,91.1420,-1,-1); //

    AddStaticVehicle(444,2551.3381,-1316.3899,778.4467,270.6635,-1,-1); //

    AddStaticVehicle(411,2550.8433,-1296.5215,777.8026,270.8202,-1,-1); //

    AddStaticVehicle(522,-2356.3562,-1626.0702,483.2442,251.3307,-1,-1); //

    AddStaticVehicle(522,-2355.5828,-1623.7618,483.2389,256.8541,-1,-1); //

    AddStaticVehicle(522,-2354.5339,-1621.9648,483.2218,263.9631,-1,-1); //

    AddStaticVehicle(522,-2354.3408,-1620.4460,483.2281,262.8673,-1,-1); //

    AddStaticVehicle(539,-2350.6301,-1606.2170,482.9801,240.8912,-1,-1); //

    AddStaticVehicle(539,-2348.5034,-1603.0725,482.9924,245.6721,-1,-1); //

    AddStaticVehicle(444,-2345.6052,-1595.3301,483.9702,249.4586,-1,-1); //

    AddStaticVehicle(444,-2343.9832,-1589.0885,483.9705,249.9912,-1,-1); //

    AddStaticVehicle(443,-2306.5391,-1604.4171,484.5671,219.6294,-1,-1); //

    AddStaticVehicle(448,-2351.2927,-1645.9421,483.2733,300.7621,-1,-1); //

    AddStaticVehicle(448,-2352.4553,-1643.3478,483.2749,300.8134,-1,-1); //

    AddStaticVehicle(448,-2354.5735,-1640.3903,483.2747,306.9222,-1,-1); //

    AddStaticVehicle(463,-2342.6072,-1660.9636,483.2433,324.1938,0,3); //

    AddStaticVehicle(416,-2317.4709,-1682.6382,482.3500,322.2592,5,26); //

    AddStaticVehicle(416,-2321.5879,-1674.6129,482.8724,319.4357,0,3); //

    AddStaticVehicle(409,-1575.9229,1144.2391,6.9875,178.3995,5,5); //

    AddStaticVehicle(409,-1575.8467,1114.6987,6.9874,181.1688,5,5); //

    AddStaticVehicle(522,1865.8284,-2245.6785,155.2286,235.6358,-1,-1); //

    AddStaticVehicle(522,1854.7028,-1524.7567,3.2731,319.9822,-1,-1); //

    AddStaticVehicle(522,1852.1385,-1524.7723,3.3675,326.5388,-1,-1); //

    AddStaticVehicle(522,1849.3252,-1524.8442,3.4656,334.3188,-1,-1); //

    AddStaticVehicle(522,1878.1527,-1527.3567,3.4498,19.4783,-1,-1); //

    //voiture a /race3

    AddStaticVehicle(521,2551.7842,-1836.7849,3.5759,172.8173,-1,-1); //

    AddStaticVehicle(521,2549.9741,-1836.6617,3.7264,173.9248,-1,-1); //

    AddStaticVehicle(521,2548.4343,-1836.6248,3.8537,174.1079,-1,-1); //

    AddStaticVehicle(522,2546.7561,-1840.1541,3.2588,126.0607,-1,-1); //

    AddStaticVehicle(522,2548.9822,-1840.2551,3.3335,125.4902,-1,-1); //

    AddStaticVehicle(522,2545.0024,-1839.7405,3.2211,118.4248,-1,-1); //

    AddStaticVehicle(522,2550.8525,-1840.5586,3.3957,128.5956,-1,-1); //

    AddStaticVehicle(522,2542.6094,-1839.8488,3.1200,135.0095,-1,-1); //

    //funstunt

    AddStaticVehicle(468,1278.3036,-2020.6566,58.5970,91.1628,-1,-1); //

    AddStaticVehicle(468,1278.4705,-2026.1409,58.6152,93.3655,-1,-1); //

    AddStaticVehicle(468,1278.2988,-2033.6008,58.6481,92.2329,-1,-1); //

    AddStaticVehicle(521,1272.8021,-2008.9913,58.6247,177.1477,-1,-1); //

    AddStaticVehicle(521,1269.8988,-2009.0940,58.7077,178.9303,-1,-1); //

    AddStaticVehicle(521,1266.5404,-2009.1591,58.8035,182.4522,-1,-1); //

    AddStaticVehicle(522,1255.7493,-2008.6721,59.1121,176.7280,-1,-1); //

    AddStaticVehicle(522,1253.1243,-2008.6351,59.1897,178.1238,-1,-1); //

    AddStaticVehicle(522,1250.5093,-2008.9794,59.2570,181.9281,-1,-1); //

    //vehicule rally

    AddStaticVehicle(522,-542.1516,-181.8479,78.0280,237.8330,-1,-1);//

    AddStaticVehicle(522,-542.6467,-183.1337,78.0283,230.5114,-1,-1);//

    AddStaticVehicle(475,-488.1297,-177.1125,78.0161,181.7753,-1,-1);//

    AddStaticVehicle(475,-549.8436,-176.9734,78.2103,266.5045,-1,-1);//

    AddStaticVehicle(402,-541.0948,-192.5525,78.2380,91.3013,-1,-1);//

    AddStaticVehicle(402,-513.5712,-191.8280,78.1314,91.9226,-1,-1);//

    AddStaticVehicle(402,-567.3026,-176.6019,78.2402,88.7527,-1,-1);//

    //vehicule a dm1

    AddStaticVehicle(457,1415.7533,2789.3003,10.4471,90.3604,-1,-1);//

    AddStaticVehicle(457,1415.5820,2784.6438,10.4471,92.1192,-1,-1);//

    AddStaticVehicle(457,1415.6040,2781.4053,10.4471,91.6084,-1,-1);//

    AddStaticVehicle(457,1413.8899,2763.3684,10.4471,94.0571,-1,-1);//

    AddStaticVehicle(457,1415.2225,2748.9492,10.4471,88.4874,-1,-1);//

    AddStaticVehicle(457,1416.5573,2744.2092,10.4471,93.1684,-1,-1);//

    AddStaticVehicle(457,1528.4912,2822.9766,10.4471,86.2940,-1,-1);//

    AddStaticVehicle(457,1529.5964,2845.3118,10.4471,93.5689,-1,-1);//

    AddStaticVehicle(457,1528.7207,2867.2087,10.4471,91.0781,-1,-1);//

    AddStaticVehicle(457,1509.4088,2878.2827,10.4471,182.0614,-1,-1);//

    AddStaticVehicle(457,1491.4478,2878.4753,10.4471,181.5820,-1,-1);//

    AddStaticVehicle(457,1451.6853,2877.8000,10.4471,180.3133,-1,-1);//

    AddStaticVehicle(457,1423.6969,2855.9150,10.4469,267.6443,-1,-1);//

    AddStaticVehicle(522,1423.8115,2872.7466,10.3932,269.4409,-1,-1);//

    AddStaticVehicle(522,1429.0405,2878.0061,10.3894,180.7570,-1,-1);//

    AddStaticVehicle(522,1423.4413,2826.6882,10.3823,270.3177,-1,-1);//

    AddStaticVehicle(522,1528.2246,2795.6741,10.3816,91.9542,-1,-1);//

    //farmers

    AddStaticVehicle(451,-376.1211,-1446.2067,25.2995,358.1461,-1,-1);//

    AddStaticVehicle(451,-372.8575,-1413.4755,25.2986,359.6730,-1,-1);//

    AddStaticVehicle(451,-386.1147,-1384.8899,22.6182,202.8231,-1,-1);//

    AddStaticVehicle(451,-401.3530,-1393.4153,23.1605,194.0300,-1,-1);//

    AddStaticVehicle(522,-380.1609,-1377.5376,22.4881,224.9725,-1,-1);//

    AddStaticVehicle(522,-371.2483,-1368.2665,21.7452,248.0999,-1,-1);//

    AddStaticVehicle(451,-237.7645,-1375.8267,9.9681,89.1062,-1,-1);//

    AddStaticVehicle(451,-242.9928,-1387.1451,10.0650,60.0966,-1,-1);//

    AddStaticVehicle(451,-247.6327,-1396.5648,9.8797,45.5514,-1,-1);//

    AddStaticVehicle(451,-251.1246,-1407.7751,9.5400,47.1554,-1,-1);//

    AddStaticVehicle(522,-212.6089,-1347.5613,9.5263,100.0331,-1,-1);//

    AddStaticVehicle(522,-212.2048,-1345.1550,10.0222,89.8442,-1,-1);//

    AddStaticVehicle(522,-211.6242,-1342.6630,10.5396,98.2771,-1,-1);//

    AddStaticVehicle(522,-375.4564,-1371.9729,22.3510,225.2137,-1,-1);//

    //vehicules a new

    AddStaticVehicle(522,2790.1311,-1438.5328,39.6303,270.5857,-1,-1);//

    AddStaticVehicle(522,2790.2129,-1436.8353,39.6347,276.8909,-1,-1);//

    AddStaticVehicle(522,2790.2473,-1435.1677,39.6362,280.5844,-1,-1);//

    AddStaticVehicle(522,2790.2854,-1433.6348,39.6267,276.7539,-1,-1);//

    AddStaticVehicle(522,2790.3572,-1431.9556,39.6363,279.5331,-1,-1);//

    AddStaticVehicle(468,2801.5952,-1426.4960,39.6363,185.3315,-1,-1);//

    AddStaticVehicle(468,2803.2109,-1426.4745,39.6327,183.0410,-1,-1);//

    AddStaticVehicle(468,2804.7466,-1426.7069,39.6332,189.7165,-1,-1);///

    AddStaticVehicle(468,2806.2344,-1427.0266,39.6200,187.8188,-1,-1);//

    AddStaticVehicle(468,2807.7810,-1426.6718,39.6260,188.1341,-1,-1);//

    AddStaticVehicle(411,2817.5813,-1432.9502,39.7896,90.2322,-1,-1);//

    AddStaticVehicle(411,2817.7700,-1438.4133,39.7896,89.5534,-1,-1);//

    AddStaticVehicle(411,2817.7173,-1443.7175,39.7885,93.2420,-1,-1);//

    AddStaticVehicle(411,2817.9241,-1450.2717,39.7898,91.3687,-1,-1);//

    AddStaticVehicle(539,2813.0283,-1465.8444,39.4001,358.2469,-1,-1);//

    AddStaticVehicle(539,2817.8474,-1465.5045,39.4226,9.2070,-1,-1);//

    AddStaticVehicle(539,2791.9978,-1465.8301,39.4226,3.8602,-1,-1);//

    AddStaticVehicle(539,2797.6409,-1465.8680,39.4226,0.7039,-1,-1);//

    //stunt1 et race4

    AddStaticVehicle(522,315.2791,-1788.4449,4.2016,180.3438,-1,-1);//

    AddStaticVehicle(522,318.6714,-1787.7755,4.2607,180.5710,-1,-1);//

    AddStaticVehicle(522,321.2328,-1789.2810,4.2985,183.7290,-1,-1);//

    AddStaticVehicle(522,324.6057,-1789.0779,4.3449,184.6480,-1,-1);//

    AddStaticVehicle(522,327.9358,-1789.3414,4.3993,177.1734,-1,-1);//

    AddStaticVehicle(522,331.1042,-1789.3284,4.4583,179.4846,-1,-1);//

    AddStaticVehicle(522,334.0287,-1788.7672,4.4684,179.4742,-1,-1);//

    AddStaticVehicle(522,337.6209,-1789.2878,4.4869,184.0533,-1,-1);//

    AddStaticVehicle(468,334.2039,-1809.0042,4.1603,0.9647,-1,-1);//

    AddStaticVehicle(468,331.0742,-1808.7029,4.1652,359.3607,-1,-1);//

    AddStaticVehicle(468,327.6299,-1808.6820,4.1637,356.7908,-1,-1);//

    AddStaticVehicle(468,337.4396,-1808.7970,4.1918,1.7543,-1,-1);//

    AddStaticVehicle(462,353.5264,-1809.2776,4.1301,0.7512,-1,-1);///

    AddStaticVehicle(462,350.3906,-1809.2227,4.1287,3.7931,-1,-1);//

    AddStaticVehicle(462,347.2806,-1808.9851,4.1303,2.8716,-1,-1);//

    AddStaticVehicle(522,537.2292,-2525.0112,0.6376,347.0553,-1,-1);//

    AddStaticVehicle(522,526.5297,-2521.7910,0.6294,349.5288,-1,-1);//

    AddStaticVehicle(522,517.7522,-2520.2485,0.6233,351.0680,-1,-1);//

    AddStaticVehicle(522,507.1049,-2518.2236,0.6314,350.3121,-1,-1);//

    AddStaticVehicle(451,510.8623,-2506.2244,0.7488,260.7853,-1,-1);//

    AddStaticVehicle(541,511.3221,-2497.9556,0.6945,260.1915,-1,-1);//

    AddStaticVehicle(451,513.5753,-2489.1936,0.7692,260.4716,-1,-1);//

    AddStaticVehicle(411,540.4954,-2516.7434,0.7895,79.7781,-1,-1);//

    AddStaticVehicle(415,542.1645,-2508.1270,0.8291,79.4436,-1,-1);//

    AddStaticVehicle(411,544.3168,-2496.8872,0.7924,78.5399,-1,-1);//

    //stunt2 et /drift

    AddStaticVehicle(522,1629.3311,-2618.6450,13.1175,2.0579,-1,-1);//

    AddStaticVehicle(522,1631.0996,-2618.8762,13.1082,2.0108,-1,-1);//

    AddStaticVehicle(522,1632.7598,-2618.8220,13.1158,358.6804,-1,-1);//

    AddStaticVehicle(522,1634.1284,-2618.9622,13.1119,359.1720,-1,-1);//

    AddStaticVehicle(522,1635.7715,-2618.8713,13.1124,1.4820,-1,-1);//

    AddStaticVehicle(522,1637.4130,-2618.7813,13.1143,359.7230,-1,-1);//

    AddStaticVehicle(429,1653.1477,-2616.6626,13.2266,1.1575,-1,-1);//

    AddStaticVehicle(411,1657.3209,-2617.1401,13.2740,1.6891,-1,-1);//

    AddStaticVehicle(429,1661.9363,-2616.9788,13.2740,3.3065,-1,-1);//

    AddStaticVehicle(411,1666.8892,-2617.1621,13.2740,3.3190,-1,-1);//

    AddStaticVehicle(429,1671.4814,-2617.3208,13.2739,358.7570,-1,-1);//

    AddStaticVehicle(411,1675.9843,-2617.4382,13.2740,1.5894,-1,-1);//

    AddStaticVehicle(522,1687.3910,-2616.5120,13.1123,0.4823,-1,-1);//

    AddStaticVehicle(522,1689.5010,-2616.6064,13.1107,359.2065,-1,-1);//

    AddStaticVehicle(522,1691.3633,-2616.6174,13.1117,1.2458,-1,-1);//

    AddStaticVehicle(522,1692.9395,-2616.6875,13.1095,358.4519,-1,-1);//

    AddStaticVehicle(522,1694.6219,-2616.7639,13.1072,356.3287,-1,-1);//

    AddStaticVehicle(522,1696.4250,-2616.9856,13.1089,3.0721,-1,-1);//

    AddStaticVehicle(411,2352.1599,1408.7831,42.5474,89.9962,-1,-1);//

    AddStaticVehicle(560,2352.0686,1404.7329,42.5251,90.6199,-1,-1);//

    AddStaticVehicle(560,2312.3008,1389.2650,42.5260,359.9328,-1,-1);//

    AddStaticVehicle(560,2302.9282,1415.6853,42.5255,268.6805,-1,-1);//

    AddStaticVehicle(429,2351.8984,1419.2421,42.4996,89.2782,-1,-1);//

    AddStaticVehicle(429,2302.8901,1437.3678,42.5000,268.5776,-1,-1);//

    AddStaticVehicle(429,2279.0684,1389.7168,42.5000,359.5787,-1,-1);//

    AddStaticVehicle(475,2289.3711,1389.6125,42.6227,0.7284,-1,-1);//

    AddStaticVehicle(475,2351.0640,1451.6617,42.6175,90.5909,-1,-1);

    AddStaticVehicle(588,1002.2632,-1274.4604,652.2534,358.6934,-1,-1); //

    AddStaticVehicle(502,2582.9163,-1307.0552,777.8026,90.7088,-1,-1); //

    AddStaticVehicle(539,2581.0166,-1325.5488,777.8025,47.4020,-1,-1); //

    AddStaticVehicle(539,2550.2629,-1325.9766,777.8025,300.8332,-1,-1); //

    AddStaticVehicle(503,2550.3750,-1307.5042,777.8025,269.5508,-1,-1); //

    AddStaticVehicle(415,2303.4141,1408.3184,42.5474,270.0987,-1,-1); //

    AddStaticVehicle(451,2302.5679,1389.9684,42.5474,1.1033,-1,-1); //

    AddStaticVehicle(402,2295.6426,1388.9175,42.5474,0.4426,-1,-1); //

    AddStaticVehicle(502,2352.9167,1426.3674,42.5451,88.4420,-1,-1);//

    AddStaticVehicle(451,2303.6013,1422.8934,42.5474,269.2731,-1,-1); //

    AddStaticVehicle(415,2304.0129,1426.5321,42.5474,268.7874,-1,-1); //

    AddStaticVehicle(503,2304.1382,1429.8875,42.5474,269.8281,-1,-1); //

    AddStaticVehicle(522,1550.1293,-1245.3553,277.4610,269.7861,-1,-1); //

    AddStaticVehicle(522,1550.4395,-1241.5332,277.4575,274.8932,-1,-1); //

    AddStaticVehicle(522,1550.6885,-1238.8013,277.4471,274.5003,-1,-1); //

    AddStaticVehicle(522,1550.7181,-1236.2772,277.4519,274.1809,-1,-1); //

    //3 motos à race

    AddStaticVehicle(522,2420.2651,-1865.3484,466.9192,1.7486,184,18); //

    AddStaticVehicle(522,2420.2371,-1860.0315,466.9189,358.7036,18,18); //

    AddStaticVehicle(522,2420.6001,-1854.8252,466.9134,356.2432,18,18); //


    //tuning
	AddStaticVehicle(562,-2689.9199,223.8162,3.9875,89.2262,186,182); //

	AddStaticVehicle(560,-2699.6802,236.5022,4.0335,181.5154,180,-184); //

	AddStaticVehicle(560,-2689.9724,210.1997,4.0325,90.5760,185,181); //

	AddStaticVehicle(559,-2711.9849,248.9352,3.9844,176.9036,252,182); //

	AddStaticVehicle(559,-2679.8477,210.3661,3.9845,90.8800,186,180); //

	//drift
	AddStaticVehicle(562,2264.1758,1497.9528,42.1347,269.2532,252,252); //

	AddStaticVehicle(559,2264.2798,1494.2245,41.8940,268.1311,181,182); //

	AddStaticVehicle(562,2263.8145,1487.1036,41.6698,266.1617,185,185); //

	AddStaticVehicle(559,2263.5959,1483.3816,41.4318,267.6840,183,1); //

	AddStaticVehicle(562,2263.5547,1479.8235,41.2117,263.6994,184,183); //

	AddStaticVehicle(559,2262.7429,1476.1521,40.9688,268.4909,-1,-1); //

	AddStaticVehicle(562,2263.7366,1465.3450,40.2615,270.3073,-1,-1); //

	AddStaticVehicle(559,2262.9761,1462.4453,40.0869,91.9440,-1,-1); //

	AddStaticVehicle(493, 2110.048340, -107.326340, 0.700262, 123,-1,-1); //véhicule à /ponton

	AddStaticVehicle(446, 2103.195801, -97.325172, 0.693713, 123, -1,-1); //

	AddStaticVehicle(493, 2094.542969, -109.395950, 0.699220, 123, -1,-1); //

	AddStaticVehicle(446, 2120.181396, -135.222107, 0.702063, 123,-1,-1); //

	AddStaticVehicle(452, 2041.040039, -38.980141, 0.685543, 180, -1,-1); //

	AddStaticVehicle(452, 2028.492310, -48.068489, 0.673883, 180, -1,-1); //

	AddStaticVehicle(460, 1962.626099, -232.752197, 0.719716, 0.0000, -1,-1); //

	AddStaticVehicle(522, 2369.935791, 601.016663, 10.433316,  180.0000, -1,-1); // véhicules à /port

	AddStaticVehicle(522, 2368.227783, 600.987793, 10.433316, 180.0000, -1,-1); //

	AddStaticVehicle(522, 2366.394043, 601.018433, 10.433316, 180.0000, -1,-1); //

	AddStaticVehicle(521, 2364.375488, 600.994263, 10.433316, 180.0000, -1,-1); //

	AddStaticVehicle(522, 2362.253174, 600.902039, 10.433316, 180.0000, -1,-1); //

	AddStaticVehicle(521, 2359.931885, 601.013733, 10.433316, 180.0000, -1,-1); //

	AddStaticVehicle(521, 2357.533447, 600.977234, 10.433316, 180.0000, -1,-1); //

	AddStaticVehicle(493, 2362.129395, 518.113647, 0.623195, 90.0000, -1,-1); //

	AddStaticVehicle(446, 2294.938721, 518.759766, 0.603738, 90.0000, -1,-1); //

	AddStaticVehicle(473, -221.166794, -1798.633911, 0.635705, 270.0000,-1,-1); // véhicules au fort de gouzy

	AddStaticVehicle(473, -227.008759, -1797.321533, 0.568019, 270.0000,-1,-1); //

	AddStaticVehicle(473, -232.288895, -1796.220581, 0.495929, 270.0000,-1,-1); //

	AddStaticVehicle(538,-1944.0951,135.2402,27.0006,358.5617,-1,-1); // TRAIN
	
	AddStaticVehicle(411,-1435.8602,-1538.3247,101.4849,89.7150,-1,-1); // Ultigirl
	
	AddStaticVehicle(522,-1435.3485,-1542.2336,101.3242,90.8770,-1,-1); // Ultigirl
	
	AddStaticVehicle(522,-1447.7087,-1532.0321,101.3195,225.1128,-1,-1); // Ultigirl
	
	AddStaticVehicle(522,-1447.8080,-1528.3300,101.3313,228.3865,-1,-1); // Ultigirl
	
	
	AddStaticVehicle(427,-2834.0374,2605.5369,412.6538,258.7472,-1,-1); // Funup
	
	AddStaticVehicle(427,-2832.1396,2617.6777,412.6540,259.8403,-1,-1); // Funup
	
	AddStaticVehicle(444,-2820.5244,2616.1643,412.8933,168.1295,-1,-1); // Funup
	
	AddStaticVehicle(444,-2818.6470,2599.9246,412.8933,352.9057,-1,-1); // Funup
	
	
	
	AddStaticVehicle(411,920.6826,428.2307,1299.5986,181.4398,80,1); // Vertigo
	
	AddStaticVehicle(411,920.5137,436.9923,1299.5986,1.3464,80,1); //Vertigo
	
	AddStaticVehicle(411,940.6920,438.4795,1299.5986,90.0367,80,1); //Vertigo
	
	AddStaticVehicle(411,941.9026,429.4320,1299.5986,89.9015,80,1); //Vertigo
	
	AddStaticVehicle(522,1729.2324,-1190.0282,1849.7444,102.7783,1,1); // stunt4
	
	AddStaticVehicle(522,1729.0713,-1200.5791,1849.7407,79.8844,1,1); //stunt4
	
	AddStaticVehicle(522,1728.6819,-1208.7430,1849.7335,86.7459,1,1); //stunt4
	
	AddStaticVehicle(522,1729.0660,-1217.0222,1849.7349,90.5033,1,1); //stunt4
	
	AddStaticVehicle(522,1702.7025,-1213.3541,1849.7339,270.7484,1,1); //stunt4
	
	AddStaticVehicle(522,1702.6343,-1206.4677,1849.7405,257.9861,1,1); //stunt4
	
	AddStaticVehicle(522,1702.7959,-1197.1355,1849.7394,266.1378,1,1); //stunt4
	
	AddStaticVehicle(522,1702.5869,-1189.0066,1849.7411,265.8905,1,1); //stunt4
	
    
    LinkVehicleToInterior (AddStaticVehicle(468,-1455.3557,-669.8512,1055.4175,343.5540,-1,-1), 4);
    
	LinkVehicleToInterior (AddStaticVehicle(468,-1453.6672,-670.7628,1054.9801,337.5945,-1,-1), 4);
	
	LinkVehicleToInterior (AddStaticVehicle(468,-1451.8669,-672.0612,1054.4468,337.1357,-1,-1), 4);
	
	LinkVehicleToInterior (AddStaticVehicle(468,-1449.8909,-673.3065,1053.8899,338.8267,-1,-1), 4);
	
	LinkVehicleToInterior (AddStaticVehicle(468,-1457.0698,-669.0438,1055.8594,332.7866,-1,-1), 4);

    LinkVehicleToInterior (AddStaticVehicle(522,-1407.8445,1571.9448,1052.0966,48.3221,0,2), 14);

    LinkVehicleToInterior (AddStaticVehicle(522,-1410.1337,1571.7795,1052.1033,42.4896,5,6), 14);

    LinkVehicleToInterior (AddStaticVehicle(522,-1412.0088,1571.5796,1052.1082,40.7273,9,14), 14);

    LinkVehicleToInterior (AddStaticVehicle(522,-1413.8013,1571.6234,1052.1016,42.4292,7,1), 14);

    LinkVehicleToInterior (AddStaticVehicle(522,-1415.5349,1571.6484,1052.1006,41.9718,3,6), 14);

    LinkVehicleToInterior (AddStaticVehicle(468,-1422.1145,1571.4401,1052.1050,33.0898,26,11), 14);

    LinkVehicleToInterior (AddStaticVehicle(468,-1423.8226,1571.4589,1052.0988,30.4881,4,12), 14);

    LinkVehicleToInterior (AddStaticVehicle(468,-1425.3950,1571.3395,1052.0953,24.6295,22,8), 14);

    LinkVehicleToInterior (AddStaticVehicle(468,-1426.9937,1571.3345,1052.0934,21.6535,13,25), 14);

    LinkVehicleToInterior (AddStaticVehicle(468,-1428.2850,1571.1786,1052.0946,19.4101,12,26), 14);

    LinkVehicleToInterior (AddStaticVehicle(468,-987.1283,1084.2203,1342.5872,80.4031,-1,-1), 10);

    LinkVehicleToInterior (AddStaticVehicle(468,-987.7032,1081.7634,1342.5624,86.4113,-1,-1), 10);

    LinkVehicleToInterior (AddStaticVehicle(468,-988.0709,1079.6753,1342.5479,84.7038,-1,-1), 10);

    LinkVehicleToInterior (AddStaticVehicle(468,-988.3085,1077.6378,1342.5444,88.1082,-1,-1), 10);

    LinkVehicleToInterior (AddStaticVehicle(468,-988.3547,1075.5190,1342.5553,91.0376,-1,-1), 10);

    LinkVehicleToInterior (AddStaticVehicle(468,-988.3617,1073.3778,1342.5933,94.6025,-1,-1), 10);

    LinkVehicleToInterior (AddStaticVehicle(502,-1360.6257,932.8281,1036.0586,9.7560,-1,-1), 15);

    LinkVehicleToInterior (AddStaticVehicle(502,-1355.1343,933.4384,1036.0651,5.3995,-1,-1), 15);

    LinkVehicleToInterior (AddStaticVehicle(444,-1335.7448,938.2325,1036.1172,17.0370,-1,-1), 15);

    LinkVehicleToInterior (AddStaticVehicle(503,-1320.8409,941.9439,1036.1552,21.1502,-1,-1), 15);

    LinkVehicleToInterior (AddStaticVehicle(502,-1315.8979,944.6830,1036.1913,25.1746,-1,-1), 15);

    LinkVehicleToInterior (AddStaticVehicle(503,-1311.6814,946.6147,1036.2147,22.4335,-1,-1), 15);

    LinkVehicleToInterior (AddStaticVehicle(502,-1306.8374,948.7673,1036.2408,27.4989,-1,-1), 15);

    LinkVehicleToInterior (AddStaticVehicle(444,-1294.6085,960.5136,1037.0582,39.8173,-1,-1), 15);

    LinkVehicleToInterior (AddStaticVehicle(444,-1488.8099,949.6340,1037.2166,340.9308,-1,-1), 15);

    LinkVehicleToInterior (AddStaticVehicle(411,-1508.8130,964.9341,1036.8683,312.8495,-1,-1), 15);

    LinkVehicleToInterior (AddStaticVehicle(502,-1512.1453,969.4385,1036.9506,304.7769,-1,-1), 15);

    LinkVehicleToInterior (AddStaticVehicle(503,-1515.8666,973.4241,1037.0212,302.8992,-1,-1), 15);

    LinkVehicleToInterior (AddStaticVehicle(502,-1518.5757,978.3775,1037.1062,300.5847,-1,-1), 15);

    LinkVehicleToInterior (AddStaticVehicle(503,-1520.3591,983.8273,1037.2001,295.5498,-1,-1), 15);

    LinkVehicleToInterior (AddStaticVehicle(522,938.1089,-1755.8212,13.1105,175.9619,-1,-1), 1);

    LinkVehicleToInterior (AddStaticVehicle(522,940.1005,-1756.3116,13.1085,171.3534,-1,-1), 1);

    LinkVehicleToInterior (AddStaticVehicle(522,942.2270,-1756.8322,13.1177,169.2711,-1,-1), 1);

    LinkVehicleToInterior (AddStaticVehicle(522,944.3069,-1757.4840,13.1088,177.8073,-1,-1), 1);

    LinkVehicleToInterior (AddStaticVehicle(522,946.1332,-1757.6061,13.1111,169.2101,-1,-1), 1);

	LinkVehicleToInterior (AddStaticVehicle(560,-1406.3180,-195.9577,1043.0853,4.8191,-1,-1), 7);
	
	LinkVehicleToInterior (AddStaticVehicle(560,-1405.3311,-201.3690,1043.0597,5.8324,-1,-1), 7);
	
	LinkVehicleToInterior (AddStaticVehicle(560,-1406.5779,-189.8270,1043.1478,4.4453,-1,-1), 7);
	
	LinkVehicleToInterior (AddStaticVehicle(560,-1407.2266,-183.9044,1043.2256,9.4994,-1,-1), 7);
	
	LinkVehicleToInterior (AddStaticVehicle(560,-1408.1146,-178.6651,1043.2992,10.6460,-1,-1), 7);
	
	LinkVehicleToInterior (AddStaticVehicle(560,-1409.3816,-171.8695,1043.4294,12.7810,-1,-1), 7);

	CreateObject(13641, -2083.727051, -223.349548, 36.039558, 0.0, 0.0, 270.0);
    CreateObject(1686, -2083.163330, -236.075485, 39.871323, 0.0, 0.0, 90.0);
    CreateObject(1686, -2082.959961, -235.921661, 42.584507, 0.0, 0.0, 270.0);
    CreateObject(1686, -2082.950684, -235.916306, 45.249622, 0.0, 0.0, 270.0);
    CreateObject(1686, -2082.626709, -235.500092, 47.903580, 0.0, 0.0, 270.0);
    CreateObject(3524, -2075.688721, -219.674225, 37.205654, 0.0, 0.0, 180.0);
    CreateObject(3524, -2091.556152, -220.103882, 37.205654, 0.0, 0.0, 180.0);
    CreateObject(13592, -2062.388184, -228.909454, 44.090809, 0.0, 0.0, 101.2503);
    CreateObject(13666, -2065.601074, -226.971756, 39.273613, 0.0, 0.0, 11.25);
    CreateObject(13645, -2059.794189, -236.517136, 35.038170, 0.0, 0.0, 180.0);
    CreateObject(13645, -2057.021729, -236.472382, 35.063171, 0.0, 0.0, 180.0);
    CreateObject(13645, -2057.014648, -240.270905, 36.538261, 0.0, 0.0, 180.0);
    CreateObject(13645, -2059.637451, -240.358063, 36.538261, 0.0, 0.0, 180.0);
    CreateObject(13645, -2056.914795, -244.096619, 38.020432, 0.0, 0.0, 180.0);
    CreateObject(13645, -2059.637451, -244.171005, 38.013351, 0.0, 0.0, 180.0);
    CreateObject(13641, -2042.721436, -228.040070, 36.046631, 0.0, 0.0, 270.0);
    CreateObject(13641, -2042.576538, -236.911285, 39.364761, 0.0, 0.0, 270.0);
    CreateObject(1697, -2028.774902, -223.299530, 35.922192, 0.0, 0.0, 360.0);
    CreateObject(1697, -2028.788574, -227.839767, 35.922192, 0.0, 0.0, 180.0);
    CreateObject(1894, -2013.397217, -168.444153, 34.320313, 0.0, 0.0, 270.0);
    CreateObject(1319, -1408.580078, -957.791626, 199.649979, 0.0, 0.0, 270.0001);
    CreateObject(1319, -1408.628174, -948.132874, 199.964310, 0.0, 0.0, 270.0001);
    CreateObject(1319, -1361.601807, -958.290405, 196.807861, 0.0, 0.0, 270.0001);
    CreateObject(1319, -1361.829956, -949.568115, 197.156723, 0.0, 0.0, 270.0001);
    CreateObject(1319, -1320.587036, -950.580994, 192.716507, 0.0, 0.0, 270.0001);
    CreateObject(1319, -1320.412964, -960.078308, 192.874557, 0.0, 0.0, 270.0001);
    CreateObject(16084, -1219.867065, -958.520752, 150.685822, 0.0, 0.0, 11.25);
    CreateObject(1634, -1206.022461, -959.415039, 158.562393, 0.0, 0.0, 270.0);
    CreateObject(2780, -1207.213379, -959.198730, 157.847778, 0.0, 0.0, 0.0);
    CreateObject(2780, -1059.295166, -951.856384, 127.393761, 0.0, 0.0, 0.0);
    CreateObject(2780, -1061.669556, -976.166382, 127.443764, 0.0, 0.0, 0.0);
    CreateObject(2780, -1050.966064, -973.614319, 127.443764, 0.0, 0.0, 0.0);
    CreateObject(2780, -1050.323853, -952.067017, 127.393761, 0.0, 0.0, 0.0);
    CreateObject(1454, -1038.621460, -956.099670, 129.016953, 0.0, 0.0, 0.0);
    CreateObject(1454, -1031.363770, -957.689392, 129.016953, 0.0, 0.0, 0.0);
    CreateObject(17036, -1027.756958, -1022.758728, 128.218750, 0.0, 0.0, 0.0);
    CreateObject(1425, -1030.054565, -1038.592285, 128.671249, 0.0, 0.0, 191.25);
    CreateObject(1425, -1028.498413, -963.569397, 128.671249, 0.0, 0.0, 270.0);
    CreateObject(1412, -1039.331055, -973.430664, 129.492706, 0.0, 0.0, 292.5);
    CreateObject(996, -1030.961670, -1018.260132, 128.967499, 0.0, 0.0, 135.0);
    CreateObject(996, -1037.082397, -996.476501, 128.967499, 0.0, 0.0, 270.0);
    CreateObject(996, -1037.141113, -980.545227, 128.967499, 0.0, 0.0, 270.0);
    CreateObject(996, -1025.216431, -1017.096375, 128.967499, 0.0, 0.0, 78.75);
    CreateObject(996, -1024.068359, -973.703125, 128.967499, 0.0, 0.0, 258.75);
    CreateObject(994, -1025.512085, -998.932373, 128.312958, 0.0, 0.0, 101.25);
    CreateObject(996, -1025.632324, -1038.466553, 128.967499, 0.0, 0.0, 78.75);
    CreateObject(996, -1038.933105, -1033.344116, 128.960678, 0.0, 0.0, 33.75);
    CreateObject(16401, -1083.508789, -1041.099854, 128.212646, 0.0, 0.0, 180.0);
    CreateObject(996, -1049.743042, -1035.560181, 128.967499, 0.0, 0.0, 0.0);
    CreateObject(996, -1048.402222, -1044.382568, 128.967499, 0.0, 0.0, 180.0);
    CreateObject(2780, -1083.346924, -1041.070801, 128.436462, 0.0, 0.0, 0.0);
    CreateObject(996, -1062.783936, -1035.348389, 128.967499, 0.0, 0.0, 0.0);
    CreateObject(996, -1068.414795, -1036.308472, 128.967499, 0.0, 0.0, 191.25);
    CreateObject(996, -1065.393066, -1044.433716, 128.967499, 0.0, 0.0, 180.0);
    CreateObject(12917, -1087.844482, -1041.702026, 127.986443, 0.0, 0.0, 270.0);
    CreateObject(1225, -1063.697632, -968.697998, 128.624512, 0.0, 0.0, 0.0);
    CreateObject(1225, -1062.884644, -956.988220, 128.624512, 0.0, 0.0, 0.0);
    CreateObject(1225, -1049.257935, -967.626221, 128.624512, 0.0, 0.0, 0.0);
    CreateObject(1225, -1049.311646, -956.797302, 128.624512, 0.0, 0.0, 0.0);
    CreateObject(1225, -1029.117310, -1024.871460, 128.624512, 0.0, 0.0, 0.0);
    CreateObject(1225, -1026.622925, -1020.366699, 128.624512, 0.0, 0.0, 0.0);
    CreateObject(996, -1027.206787, -1042.114258, 128.967499, 0.0, 0.0, 191.2499);
    CreateObject(17039, -1123.589111, -1041.692627, 128.220276, 0.0, 0.0, 90.0);
    CreateObject(1225, -1123.221802, -1039.993042, 128.624512, 0.0, 0.0, 0.0);
    CreateObject(1458, -1029.886841, -1005.635681, 128.466187, 0.0, 0.0, 0.0);
    CreateObject(996, -1024.219482, -961.937073, 128.967499, 0.0, 0.0, 270.0);
    CreateObject(18367, -1449.097778, -881.875244, 179.739700, 0.0, 0.0, 180.0);
    CreateObject(1245, -1448.016724, -823.491028, 187.834122, 0.0, 0.0, 270.0);
    CreateObject(18367, -1449.159058, -852.764343, 182.986664, 0.0, 0.0, 180.0);
    CreateObject(1318, -1448.436523, -912.622498, 201.861191, 0.0, 0.0, 270.0);
    CreateObject(1425, -1456.933350, -912.095093, 201.806747, 0.0, 0.0, 45.0);
    CreateObject(3524, -1443.051758, -911.250427, 203.883621, 0.0, 0.0, 348.75);
    CreateObject(1454, -1447.660767, -686.770813, 13.946640, 0.0, 0.0, 0.0);
    CreateObject(1454, -1446.097656, -686.851013, 13.946640, 0.0, 0.0, 0.0);
    CreateObject(1454, -1449.244751, -686.884033, 13.946640, 0.0, 0.0, 0.0);
    CreateObject(1228, -1441.739502, -690.885559, 13.569566, 0.0, 0.0, 180.0);
    CreateObject(1228, -1452.296631, -690.930664, 13.569566, 0.0, 0.0, 180.0);
    CreateObject(1634, 94.032158, 2492.760742, 16.406698, 0.0, 0.0, 90.0);
    CreateObject(1634, 94.002831, 2496.824951, 16.431698, 0.0, 0.0, 90.0);
    CreateObject(1634, 94.041092, 2500.967041, 16.456697, 0.0, 0.0, 90.0);
    CreateObject(1634, 93.970657, 2505.067627, 16.456697, 0.0, 0.0, 90.0);
    CreateObject(1225, 65.575623, 2496.938721, 15.890130, 0.0, 0.0, 0.0);
    CreateObject(1225, 61.835739, 2498.699463, 15.890130, 0.0, 0.0, 0.0);
    CreateObject(1225, 61.835739, 2498.699463, 15.890130, 0.0, 0.0, 0.0);
    CreateObject(1225, 71.056549, 2501.231201, 15.890130, 0.0, 0.0, 0.0);
    CreateObject(1225, 69.255630, 2500.816162, 15.890130, 0.0, 0.0, 0.0);
    CreateObject(1225, 69.583450, 2499.475830, 15.890130, 0.0, 0.0, 0.0);
    CreateObject(1225, 63.607483, 2502.049561, 15.890130, 0.0, 0.0, 0.0);
    CreateObject(1225, 71.256500, 2504.796143, 15.890130, 0.0, 0.0, 0.0);
    CreateObject(1225, 53.378674, 2506.909668, 15.890130, 0.0, 0.0, 0.0);
    CreateObject(1225, 62.997017, 2506.185791, 15.890130, 0.0, 0.0, 0.0);
    CreateObject(1225, 51.033730, 2499.482910, 15.890130, 0.0, 0.0, 0.0);
    CreateObject(1225, 57.197273, 2501.077148, 15.890130, 0.0, 0.0, 0.0);
    CreateObject(1225, 68.998367, 2508.892090, 15.890130, 0.0, 0.0, 0.0);
    CreateObject(1225, 76.487045, 2506.063721, 15.890130, 0.0, 0.0, 0.0);
    CreateObject(1225, 71.598541, 2509.395996, 15.890130, 0.0, 0.0, 0.0);
    CreateObject(1225, 77.349243, 2499.195313, 15.890130, 0.0, 0.0, 0.0);
    CreateObject(1225, 75.008118, 2502.298828, 15.890130, 0.0, 0.0, 0.0);
    CreateObject(1225, 70.450867, 2496.495117, 15.890130, 0.0, 0.0, 0.0);
    CreateObject(1225, 63.496330, 2492.992920, 15.890130, 0.0, 0.0, 0.0);
    CreateObject(1225, 58.822079, 2494.286377, 15.890130, 0.0, 0.0, 0.0);
    CreateObject(1225, 51.606682, 2496.748291, 15.890130, 0.0, 0.0, 0.0);
    CreateObject(1225, 56.735260, 2504.004395, 15.890130, 0.0, 0.0, 0.0);
    CreateObject(1225, 54.812202, 2508.550781, 15.890130, 0.0, 0.0, 0.0);
    CreateObject(1225, 62.684612, 2510.545898, 15.890130, 0.0, 0.0, 0.0);
    CreateObject(1225, 51.271278, 2503.591797, 15.890130, 0.0, 0.0, 0.0);
    CreateObject(1225, 45.502342, 2502.582520, 15.890130, 0.0, 0.0, 0.0);
    CreateObject(1225, 51.314560, 2503.272705, 15.890132, 0.0, 0.0, 0.0);
    CreateObject(1225, 45.445198, 2497.725342, 15.890130, 0.0, 0.0, 0.0);
    CreateObject(1225, 45.559380, 2492.299072, 15.890130, 0.0, 0.0, 0.0);
    CreateObject(1225, 53.067810, 2492.717529, 15.890130, 0.0, 0.0, 0.0);
    CreateObject(1225, 45.636257, 2507.639648, 15.890130, 0.0, 0.0, 0.0);
    CreateObject(1225, 55.462524, 2512.712891, 15.890130, 0.0, 0.0, 0.0);
    CreateObject(1225, 62.932091, 2515.079346, 15.890130, 0.0, 0.0, 0.0);
    CreateObject(1225, 67.603058, 2513.865967, 15.890130, 0.0, 0.0, 0.0);
    CreateObject(1225, 67.603058, 2513.865967, 15.890130, 0.0, 0.0, 0.0);
    CreateObject(1225, 67.603058, 2513.865967, 15.890130, 0.0, 0.0, 0.0);
    CreateObject(1225, 50.277485, 2512.737793, 15.890132, 0.0, 0.0, 0.0);
    CreateObject(1341, 1865.571777, -1524.305908, 3.503366, 0.0, 0.0, 90.0);
    CreateObject(979, 1887.727539, -1524.933472, 3.255997, 0.0, 0.0, 0.0);
    CreateObject(979, 1901.824707, -1525.789307, 3.024878, 0.0, 0.0, 0.0);
    CreateObject(998, 1874.400391, -1512.212646, 2.311045, 0.0, 0.0, 270.0);
    CreateObject(1228, 1911.140869, -1519.580078, 2.691483, 0.0, 0.0, 0.0);
    CreateObject(1228, 1939.996338, -1510.814087, 2.735535, 0.0, 0.0, 0.0);
    CreateObject(1228, 1954.301514, -1516.517090, 2.767804, 0.0, 0.0, 0.0);
    CreateObject(1228, 2018.725220, -1515.266846, 2.822866, 0.0, 0.0, 0.0);
    CreateObject(1228, 2018.410156, -1518.688965, 2.833653, 0.0, 0.0, 0.0);
    CreateObject(979, 2015.031128, -1532.438965, 3.317648, 0.0, 0.0, 22.5);
    CreateObject(979, 2024.476929, -1528.083130, 3.402152, 0.0, 0.0, 22.5);
    CreateObject(1228, 1979.737061, -1513.521851, 2.789172, 0.0, 0.0, 0.0);
    CreateObject(1228, 2086.056396, -1528.045288, 2.103745, 0.0, 0.0, 348.75);
    CreateObject(1228, 2087.339111, -1519.338989, 2.111919, 0.0, 0.0, 348.75);
    CreateObject(1228, 2168.501465, -1557.235107, 1.633218, 0.0, 0.0, 337.5);
    CreateObject(1228, 2170.607910, -1552.540039, 1.628349, 0.0, 0.0, 337.5);
    CreateObject(1228, 2076.736084, -1507.239502, 2.380144, 0.0, 0.0, 348.75);
    CreateObject(1228, 2086.958496, -1502.840576, 2.197604, 0.0, 0.0, 348.75);
    CreateObject(1228, 2086.259277, -1510.914063, 2.177048, 0.0, 0.0, 348.75);
    CreateObject(1228, 2165.394531, -1535.812622, 1.708918, 0.0, 0.0, 337.5);
    CreateObject(1228, 2216.197510, -1561.670044, 1.598735, 0.0, 0.0, 337.5);
    CreateObject(1228, 2219.477539, -1552.852539, 1.619917, 0.0, 0.0, 337.5);
    CreateObject(1228, 2242.343750, -1570.745117, 1.911383, 0.0, 0.0, 337.5);
    CreateObject(1228, 2240.948730, -1584.917725, 1.955411, 0.0, 0.0, 337.5);
    CreateObject(1237, 1874.195190, -1524.031128, 2.475908, 0.0, 0.0, 0.0);
    CreateObject(1237, 1873.785645, -1509.263550, 2.431741, 0.0, 0.0, 0.0);
    CreateObject(1237, 1939.916626, -1514.561890, 2.324967, 0.0, 0.0, 0.0);
    CreateObject(1237, 1978.665039, -1519.410034, 2.379375, 0.0, 0.0, 0.0);
    CreateObject(1237, 1982.214966, -1500.324219, 2.387765, 0.0, 0.0, 0.0);
    CreateObject(1237, 2011.817871, -1499.053833, 2.402223, 0.0, 0.0, 0.0);
    CreateObject(1237, 2035.714844, -1513.597778, 2.344911, 0.0, 0.0, 0.0);
    CreateObject(1237, 2043.790283, -1501.100708, 2.317052, 0.0, 0.0, 0.0);
    CreateObject(1237, 2004.827393, -1510.312378, 2.398808, 0.0, 0.0, 0.0);
    CreateObject(1237, 2060.642090, -1516.739136, 2.247806, 0.0, 0.0, 0.0);
    CreateObject(1237, 2069.314941, -1522.937500, 2.057328, 0.0, 0.0, 0.0);
    CreateObject(1237, 2113.705322, -1534.770508, 1.463820, 0.0, 0.0, 0.0);
    CreateObject(1237, 2111.906494, -1544.182983, 1.635694, 0.0, 0.0, 0.0);
    CreateObject(1237, 2179.795898, -1539.207275, 1.188782, 0.0, 0.0, 0.0);
    CreateObject(1237, 2140.125488, -1526.356567, 1.463820, 0.0, 0.0, 0.0);
    CreateObject(1237, 2117.943604, -1511.700195, 1.468502, 0.0, 0.0, 0.0);
    CreateObject(1237, 2153.622559, -1546.440430, 1.345081, 0.0, 0.0, 0.0);
    CreateObject(1237, 2196.011963, -1565.143311, 1.174756, 0.0, 0.0, 0.0);
    CreateObject(1237, 2190.960693, -1548.295654, 1.180487, 0.0, 0.0, 0.0);
    CreateObject(1237, 2177.675781, -1561.201660, 1.174756, 0.0, 0.0, 0.0);
    CreateObject(1237, 2268.759521, -1583.630737, 2.089242, 0.0, 0.0, 0.0);
    CreateObject(1237, 2253.251953, -1592.422485, 1.789469, 0.0, 0.0, 0.0);
    CreateObject(1237, 2230.770996, -1579.024780, 1.407466, 0.0, 0.0, 0.0);
    CreateObject(1237, 2320.663330, -1594.669189, 4.111808, 0.0, 0.0, 0.0);
    CreateObject(1237, 2311.222412, -1609.702759, 3.830731, 0.0, 0.0, 0.0);
    CreateObject(1237, 2298.410156, -1605.620239, 3.228780, 0.0, 0.0, 0.0);
    CreateObject(1237, 2295.404053, -1593.571289, 2.953237, 0.0, 0.0, 0.0);
    CreateObject(1237, 2277.975830, -1597.210815, 2.429748, 0.0, 0.0, 0.0);
    CreateObject(1237, 2344.638672, -1617.590088, 5.702641, 0.0, 0.0, 0.0);
    CreateObject(1237, 2341.405273, -1597.161377, 5.337373, 0.0, 0.0, 0.0);
    CreateObject(1237, 2364.819580, -1619.592407, 6.996360, 0.0, 0.0, 0.0);
    CreateObject(1237, 2355.310547, -1603.798950, 6.319505, 0.0, 0.0, 0.0);
    CreateObject(1237, 2375.910889, -1604.299927, 7.768785, 0.0, 0.0, 0.0);
    CreateObject(1237, 2378.512695, -1614.457275, 7.971685, 0.0, 0.0, 0.0);
    CreateObject(1237, 2394.978516, -1614.156616, 9.328262, 0.0, 0.0, 0.0);
    CreateObject(1237, 2402.216797, -1600.785767, 9.970866, 0.0, 0.0, 0.0);
    CreateObject(1237, 2414.077881, -1622.570679, 11.082597, 0.0, 0.0, 0.0);
    CreateObject(1237, 2434.931396, -1601.453125, 12.687295, 0.0, 0.0, 0.0);
    CreateObject(1237, 2443.253906, -1615.403809, 13.144996, 0.0, 0.0, 0.0);
    CreateObject(1237, 2491.460693, -1622.977051, 15.692056, 0.0, 0.0, 0.0);
    CreateObject(1228, 2115.631104, -1531.324829, 1.882066, 0.0, 0.0, 348.75);
    CreateObject(1228, 2131.339600, -1520.702393, 1.887675, 0.0, 0.0, 348.75);
    CreateObject(1228, 2139.796631, -1541.133301, 1.862654, 0.0, 0.0, 348.75);
    CreateObject(1228, 2212.955322, -1575.463623, 1.622870, 0.0, 0.0, 337.5);
    CreateObject(1228, 2197.162109, -1547.850342, 1.594216, 0.0, 0.0, 337.5);
    CreateObject(1228, 2188.764648, -1563.785522, 1.593003, 0.0, 0.0, 337.5);
    CreateObject(1228, 2279.289551, -1586.033203, 2.803106, 0.0, 0.0, 337.5);
    CreateObject(1228, 2293.156738, -1607.828369, 3.448721, 0.0, 0.0, 337.5);
    CreateObject(1228, 2337.313721, -1601.085083, 5.503597, 0.0, 0.0, 348.75);
    CreateObject(1228, 2415.913086, -1603.606934, 11.677751, 0.0, 0.0, 0.0);
    CreateObject(1228, 2402.185547, -1616.907593, 10.386116, 0.0, 0.0, 0.0);
    CreateObject(1228, 2377.708740, -1616.636108, 8.325337, 0.0, 0.0, 0.0);
    CreateObject(1228, 2368.019043, -1600.049072, 7.602747, 0.0, 0.0, 0.0);
    CreateObject(1228, 2487.709473, -1602.389526, 15.944104, 0.0, 0.0, 0.0);
    CreateObject(978, 2433.750244, -1596.521484, 13.496858, 0.0, 0.0, 168.75);
    CreateObject(978, 2449.933594, -1597.379883, 14.489655, 0.0, 0.0, 168.75);
    CreateObject(978, 2238.791748, -1559.560547, 2.246418, 0.0, 0.0, 146.25);
    CreateObject(978, 2229.497559, -1553.231689, 2.111788, 0.0, 0.0, 146.25);
    CreateObject(1634, 2694.531982, -1611.654907, 14.552339, 0.0, 0.0, 270.0);
    CreateObject(1634, 2692.878174, -1627.354736, 14.702639, 0.0, 0.0, 270.0);
    CreateObject(1634, 2693.101563, -1621.897949, 14.668596, 0.0, 0.0, 270.0);
    CreateObject(1634, 2694.102539, -1603.819946, 14.952532, 0.0, 0.0, 270.0);
    CreateObject(1225, 2489.314941, -1616.094116, 16.001781, 0.0, 0.0, 0.0);
    CreateObject(1225, 2479.110840, -1619.266479, 15.521131, 0.0, 0.0, 0.0);
    CreateObject(1225, 2475.872803, -1600.745239, 15.387631, 0.0, 0.0, 0.0);
    CreateObject(1225, 2477.011475, -1606.361084, 15.437772, 0.0, 0.0, 0.0);
    CreateObject(1225, 2444.858154, -1619.146118, 13.678760, 0.0, 0.0, 0.0);
    CreateObject(1225, 2428.692383, -1621.179321, 12.778264, 0.0, 0.0, 0.0);
    CreateObject(1225, 2414.437988, -1601.360840, 11.516706, 0.0, 0.0, 0.0);
    CreateObject(1225, 2411.370117, -1606.298706, 11.210293, 0.0, 0.0, 0.0);
    CreateObject(1225, 2410.659180, -1615.748779, 11.142890, 0.0, 0.0, 0.0);
    CreateObject(1225, 2388.124512, -1620.317017, 9.146895, 0.0, 0.0, 0.0);
    CreateObject(1225, 2325.118164, -1601.614014, 4.791337, 0.0, 0.0, 0.0);
    CreateObject(1225, 2330.679443, -1595.170776, 5.004227, 0.0, 0.0, 0.0);
    CreateObject(1225, 2331.059326, -1613.554565, 5.206565, 0.0, 0.0, 0.0);
    CreateObject(1225, 2335.050537, -1617.698608, 5.497353, 0.0, 0.0, 0.0);
    CreateObject(1225, 2355.059082, -1614.985107, 6.744962, 0.0, 0.0, 0.0);
    CreateObject(1225, 2312.503662, -1597.299316, 4.172690, 0.0, 0.0, 0.0);
    CreateObject(1225, 2295.958984, -1587.965332, 3.290877, 0.0, 0.0, 0.0);
    CreateObject(1225, 2319.740234, -1588.565674, 4.587973, 0.0, 0.0, 0.0);
    CreateObject(1225, 2273.863281, -1575.013306, 2.638491, 0.0, 0.0, 0.0);
    CreateObject(1225, 2251.624756, -1572.867798, 2.003450, 0.0, 0.0, 0.0);
    CreateObject(1225, 2260.753174, -1600.651123, 2.439373, 0.0, 0.0, 0.0);
    CreateObject(1225, 2278.321289, -1600.743896, 2.875747, 0.0, 0.0, 0.0);
    CreateObject(1225, 2300.629883, -1610.980957, 3.786475, 0.0, 0.0, 0.0);
    CreateObject(1225, 2281.834717, -1611.821899, 3.225987, 0.0, 0.0, 0.0);
    CreateObject(1225, 2223.751953, -1561.918091, 1.659830, 0.0, 0.0, 0.0);
    CreateObject(1225, 2216.208008, -1580.421387, 1.663066, 0.0, 0.0, 0.0);
    CreateObject(1225, 2157.291504, -1535.012695, 1.754140, 0.0, 0.0, 0.0);
    CreateObject(1225, 2164.535156, -1551.914307, 1.658618, 0.0, 0.0, 0.0);
    CreateObject(1225, 2125.440674, -1540.599365, 1.866693, 0.0, 0.0, 0.0);
    CreateObject(1225, 2136.539795, -1518.429321, 1.867223, 0.0, 0.0, 0.0);
    CreateObject(1225, 2080.581055, -1504.855835, 2.309609, 0.0, 0.0, 0.0);
    CreateObject(1225, 2078.691650, -1518.001465, 2.280560, 0.0, 0.0, 0.0);
    CreateObject(1225, 2072.455566, -1526.675293, 2.382819, 0.0, 0.0, 0.0);
    CreateObject(1225, 2074.816162, -1528.680298, 2.487292, 0.0, 0.0, 0.0);
    CreateObject(1225, 2098.624268, -1536.620972, 2.038568, 0.0, 0.0, 0.0);
    CreateObject(1225, 1997.583252, -1499.653198, 2.798142, 0.0, 0.0, 0.0);
    CreateObject(1225, 1994.133789, -1517.415527, 2.800157, 0.0, 0.0, 0.0);
    CreateObject(1225, 1953.565674, -1498.580566, 2.746757, 0.0, 0.0, 0.0);
    CreateObject(1225, 1964.574219, -1514.558838, 2.771924, 0.0, 0.0, 0.0);
    CreateObject(2780, 1937.693115, -1523.933594, 1.678940, 0.0, 0.0, 0.0);
    CreateObject(2780, 1978.802856, -1507.919922, 1.764502, 0.0, 0.0, 0.0);
    CreateObject(2780, 2327.322754, -1614.140991, 3.745645, 0.0, 0.0, 0.0);
    CreateObject(978, 2248.059570, -1565.741455, 2.365408, 0.0, 0.0, 146.25);
    CreateObject(2780, 2317.478516, -1596.836304, 3.167923, 0.0, 0.0, 0.0);
    CreateObject(2780, 2693.019775, -1617.529663, 12.628779, 0.0, 0.0, 0.0);
    CreateObject(2780, 2309.809570, -1611.270752, 2.993307, 0.0, 0.0, 0.0);
    CreateObject(2780, 2302.236816, -1594.685547, 2.469069, 0.0, 0.0, 0.0);
    CreateObject(2780, 2330.313232, -1600.323242, 3.797613, 0.0, 0.0, 0.0);
    CreateObject(2780, 2325.856445, -1608.441040, 3.732932, 0.0, 0.0, 0.0);
    CreateObject(1503, 2354.452881, 1626.431885, 18.740953, 0.0, 0.0, 202.5000);
    CreateObject(1503, 2392.603027, 1487.467896, 18.088343, 0.0, 0.0, 191.2500);
    CreateObject(1245, 2409.532715, 1396.488159, 16.141073, 0.0, 0.0, 101.2500);
    CreateObject(1245, 2395.100830, 1632.629395, 11.307885, 0.0, 0.0, 0.0);
    CreateObject(1503, 2405.128174, 1687.789551, 18.740946, 0.0, 0.0, 270.0);
    CreateObject(1503, 2459.485107, 1696.629517, 18.740950, 0.0, 0.0, 90.0002);
    CreateObject(1245, 2379.812500, 1547.866577, 28.431919, 0.0, 0.0, 101.2500);
    CreateObject(1503, 2416.335205, 1214.062500, 20.747486, 0.0, 0.0, 168.7500);
    CreateObject(1503, 2409.383545, 1097.816650, 33.651932, 0.0, 0.0, 180.0);
    CreateObject(1245, 2413.655273, 975.788086, 18.807556, 0.0, 0.0, 180.0);
    CreateObject(1245, 2469.021729, 978.245667, 18.807537, 0.0, 0.0, 180.0);
    CreateObject(1503, 2527.386963, 1000.019226, 17.714081, 0.0, 0.0, 326.2500);
    CreateObject(1503, 2543.403076, 1058.642212, 17.902878, 0.0, 0.0, 0.0);
    CreateObject(1503, 2540.357666, 1092.888306, 19.363258, 0.0, 0.0, 90.0);
    CreateObject(1503, 2488.308350, 1115.973999, 20.539911, 0.0, 0.0, 0.0);
    CreateObject(1245, 2489.695557, 1153.475586, 22.510769, 0.0, 0.0, 270.0);
    CreateObject(1245, 2481.831055, 1181.410645, 22.498863, 0.0, 0.0, 292.5001);
    CreateObject(1503, 2466.207275, 1239.604248, 17.566378, 0.0, 0.0, 0.0);
    CreateObject(1503, 2472.071777, 1299.020508, 17.566444, 0.0, 0.0, 337.5000);
    CreateObject(1503, 2499.370605, 1358.775635, 16.025623, 0.0, 0.0, 337.5000);
    CreateObject(1503, 2510.786865, 1436.405396, 21.139441, 0.0, 0.0, 78.7500);
    CreateObject(1634, 2470.848389, 1459.170776, 22.042641, 0.0, 0.0, 348.7500);
    CreateObject(1634, 2467.196289, 1551.151001, 19.242630, 0.0, 0.0, 348.7500);
    CreateObject(1634, 2474.047852, 1499.011475, 15.710901, 0.0, 0.0, 0.0);
    CreateObject(1245, 2475.030029, 1510.900391, 19.235834, 0.0, 0.0, 315.0);
    CreateObject(1322, 2110.421143, -1845.353394, 4.468750, 0.0, 0.0, 0.0);
    CreateObject(8406, 2535.887207, -1853.406616, 7.797685, 0.0, 0.0, 90.0);
    CreateObject(3593, 2440.411377, -1844.692871, 1.124231, 0.0, 0.0, 337.5000);
    CreateObject(1225, 2370.264648, -1859.756470, 1.164142, 0.0, 0.0, 0.0);
    CreateObject(851, 2238.736328, -1845.258667, -0.821612, 0.0, 0.0, 0.0);
    CreateObject(853, 2237.899170, -1846.734497, -0.733809, 0.0, 0.0, 168.7500);
    CreateObject(849, 2236.204102, -1845.885010, -0.804385, 0.0, 0.0, 0.0);
    CreateObject(854, 2234.898193, -1845.279785, -0.819455, 0.0, 0.0, 0.0);
    CreateObject(852, 2235.729492, -1846.767334, -1.111983, 0.0, 0.0, 0.0);
    CreateObject(1228, 2241.541260, -1846.903564, -0.713356, 0.0, 0.0, 157.5000);
    CreateObject(1225, 2238.392578, -1845.247314, -0.728729, 0.0, 0.0, 0.0);
    CreateObject(1425, 1974.759888, -1842.023315, 3.491826, 0.0, 0.0, 123.7499);
    CreateObject(1634, 1995.559082, -1853.185181, 4.281693, 0.0, 0.0, 78.7500);
    CreateObject(1425, 1795.950806, -1809.523682, 3.436872, 0.0, 0.0, 101.2500);
    CreateObject(1225, 1756.364136, -1801.363281, 3.390130, 0.0, 0.0, 0.0);
    CreateObject(1225, 1752.030518, -1797.744751, 3.390130, 0.0, 0.0, 0.0);
    CreateObject(1225, 1749.671265, -1798.560913, 3.397010, 0.0, 0.0, 0.0);
    CreateObject(1225, 1751.080933, -1799.613403, 3.397010, 0.0, 0.0, 0.0);
    CreateObject(3057, 1754.199097, -1801.609131, 3.377259, 0.0, 0.0, 0.0);
    CreateObject(3057, 1755.168579, -1798.597412, 3.370379, 0.0, 0.0, 0.0);
    CreateObject(1218, 1752.415405, -1799.204834, 3.476068, 0.0, 0.0, 0.0);
    CreateObject(2780, 1754.170166, -1799.765869, 2.159372, 0.0, 0.0, 0.0);
    CreateObject(1228, 1767.916748, -1802.275879, 3.405503, 0.0, 0.0, 168.7500);
    CreateObject(979, 1624.039307, -1753.088867, 3.793345, 0.0, 0.0, 202.5000);
    CreateObject(979, 2145.294434, -1841.881592, 3.824595, 0.0, 0.0, 202.5000);
    CreateObject(1634, 1996.267334, -1849.436646, 4.281693, 0.0, 0.0, 78.7500);
    CreateObject(18451, 1554.704590, -1744.846924, 4.502957, 0.0, 0.0, 78.7500);
    CreateObject(1425, 1365.878052, -1714.125732, 8.240774, 0.0, 0.0, 112.5000);
    CreateObject(1634, 1361.870239, -1603.929565, 8.913727, 0.0, 0.0, 348.7500);
    CreateObject(1634, 1357.782593, -1603.153320, 8.906693, 0.0, 0.0, 348.7500);
    CreateObject(1228, 1410.902710, -1357.602905, 7.975815, 0.0, 0.0, 90.0);
    CreateObject(1228, 1408.112793, -1357.561890, 7.975815, 0.0, 0.0, 90.0);
    CreateObject(1440, 1439.571411, -1715.268433, 6.378491, 0.0, 0.0, 11.2500);
    CreateObject(1440, 1377.643066, -1709.088623, 8.378491, 0.0, 0.0, 78.7500);
    CreateObject(1440, 2075.050781, -1855.814453, 3.510138, 0.0, 0.0, 90.0);
    CreateObject(1358, 2206.368652, -1846.173462, 1.868008, 0.0, 0.0, 0.0);
    CreateObject(1438, 2229.562744, -1856.614502, -0.680171, 0.0, 0.0, 281.2500);
    CreateObject(1441, 2229.125244, -1854.811768, -0.028767, 0.0, 0.0, 90.0);
    CreateObject(1438, 2225.734375, -1849.531372, -0.452606, 0.0, 0.0, 11.2500);
    CreateObject(1438, 2096.760742, -1848.766968, 3.049919, 0.0, 0.0, 11.2500);
    CreateObject(1426, 1362.715942, -1676.534790, 7.801153, 0.0, 0.0, 270.0);
    CreateObject(979, 1368.066040, -1699.723999, 8.806726, 0.0, 0.0, 123.7499);
    CreateObject(1221, 1372.475830, -1547.538330, 8.133664, 0.0, 0.0, 0.0);
    CreateObject(1221, 1380.560913, -1533.669067, 8.133664, 0.0, 0.0, 326.2500);
    CreateObject(1221, 1381.481689, -1515.552979, 8.140883, 0.0, 0.0, 337.5000);
    CreateObject(1221, 1372.974609, -1557.419556, 8.133664, 0.0, 0.0, 258.7500);
    CreateObject(1299, 1380.166138, -1538.554688, 8.127735, 0.0, 0.0, 135.0);
    CreateObject(1299, 1378.617798, -1526.631104, 8.127735, 0.0, 0.0, 78.7500);
    CreateObject(1438, 1410.828857, -1331.554688, 7.580940, 0.0, 0.0, 0.0);
    CreateObject(1438, 1410.460571, -1330.283691, 7.908810, 0.0, 0.0, 157.5000);
    CreateObject(1438, 1409.229614, -1329.211914, 7.580940, 0.0, 0.0, 56.2500);
    CreateObject(1438, 1410.367554, -1330.213745, 8.146703, 0.0, 0.0, 56.2500);
    CreateObject(1438, 1409.300049, -1330.563843, 7.580940, 0.0, 0.0, 56.2500);
    CreateObject(1438, 1409.260376, -1331.795776, 7.580940, 0.0, 0.0, 168.7500);
    CreateObject(1438, 1407.190063, -1331.509521, 7.580940, 0.0, 0.0, 236.2500);
    CreateObject(1438, 1407.859863, -1330.847168, 8.696217, 0.0, 0.0, 0.0);
    CreateObject(1438, 1407.638794, -1330.391724, 8.752425, 0.0, 0.0, 0.0);
    CreateObject(1438, 1406.896973, -1329.955811, 8.161607, 0.0, 0.0, 0.0);
    CreateObject(1438, 1407.103271, -1329.181885, 7.580940, 0.0, 0.0, 67.5000);
    CreateObject(1438, 1411.029419, -1328.327026, 7.580940, 0.0, 0.0, 112.5000);
    CreateObject(1438, 1408.622437, -1327.894043, 7.589519, 0.0, 0.0, 101.2500);
    CreateObject(1438, 1411.047119, -1333.053101, 7.580940, 0.0, 0.0, 270.0);
    CreateObject(1438, 1410.108887, -1331.244507, 7.929530, 0.0, 0.0, 202.5000);
    CreateObject(1438, 1401.881348, -1459.820679, 7.698127, 0.0, 0.0, 202.5000);
    CreateObject(1438, 1396.617676, -1478.968872, 7.698127, 0.0, 0.0, 101.2500);
    CreateObject(1438, 1388.985962, -1490.721069, 7.698127, 0.0, 0.0, 303.7500);
    CreateObject(1221, 1387.968384, -1497.291138, 8.133664, 0.0, 0.0, 33.7500);
    CreateObject(1221, 1384.443481, -1505.487549, 8.133664, 0.0, 0.0, 326.2500);
    CreateObject(1221, 1388.994751, -1502.273193, 8.133664, 0.0, 0.0, 45.0);
    CreateObject(1221, 1392.702026, -1479.245850, 8.133664, 0.0, 0.0, 326.2500);
    CreateObject(1221, 1397.656372, -1466.701294, 8.133664, 0.0, 0.0, 247.5000);
    CreateObject(1221, 1383.405884, -1521.513184, 8.133664, 0.0, 0.0, 157.5000);
    CreateObject(1438, 2067.866943, -1847.732422, 3.017274, 0.0, 0.0, 303.7500);
    CreateObject(1438, 2499.943359, -1851.784546, 1.069241, 0.0, 0.0, 303.7500);
    CreateObject(1438, 2493.582764, -1840.561401, 0.891427, 0.0, 0.0, 225.0);
    CreateObject(1438, 2500.927002, -1857.090210, 1.128417, 0.0, 0.0, 135.0);
    CreateObject(1438, 2510.682861, -1842.642822, 1.454964, 0.0, 0.0, 56.2500);
    CreateObject(1438, 2456.520020, -1854.964355, 0.575885, 0.0, 0.0, 135.0);
    CreateObject(1438, 2402.948975, -1844.614136, 0.497470, 0.0, 0.0, 90.0);
    CreateObject(1438, 2407.068604, -1857.693848, 0.454446, 0.0, 0.0, 348.7500);
    CreateObject(1225, 2400.542480, -1842.784302, 0.897542, 0.0, 0.0, 0.0);
    CreateObject(1225, 2442.338135, -1852.390381, 0.837640, 0.0, 0.0, 0.0);
    CreateObject(1225, 2498.901123, -1842.508545, 1.440111, 0.0, 0.0, 0.0);
    CreateObject(1230, 2449.218262, -1859.285889, 0.905776, 0.0, 0.0, 0.0);
    CreateObject(1230, 2450.268066, -1858.945435, 0.914493, 0.0, 0.0, 67.5000);
    CreateObject(1230, 2240.495117, -1852.839111, -0.717718, 0.0, 0.0, 67.5000);
    CreateObject(1230, 2201.963379, -1852.662964, 1.343074, 0.0, 0.0, 112.5000);
    CreateObject(1225, 2236.819336, -1846.295288, -0.728729, 0.0, 0.0, 112.5000);
    CreateObject(1225, 2227.522461, -1855.719360, -0.179387, 0.0, 0.0, 112.5000);
    CreateObject(1225, 2073.725098, -1850.959351, 3.396777, 0.0, 0.0, 112.5000);
    CreateObject(1358, 1690.114502, -1776.562988, 4.178465, 0.0, 0.0, 348.7500);
    CreateObject(1225, 1689.412231, -1774.002075, 3.389606, 0.0, 0.0, 0.0);
    CreateObject(1225, 1691.312134, -1773.995361, 3.390069, 0.0, 0.0, 0.0);
    CreateObject(1225, 1690.347290, -1776.196289, 4.994313, 0.0, 0.0, 0.0);
    CreateObject(1440, 1683.305908, -1783.961670, 3.498523, 0.0, 0.0, 112.5000);
    CreateObject(1450, 1524.723999, -1746.295410, 5.386534, 0.0, 0.0, 168.7500);
    CreateObject(12957, 1511.565186, -1741.464111, 6.118906, 0.0, 0.0, 78.7500);
    CreateObject(3594, 1483.129761, -1727.408936, 6.370997, 0.0, 0.0, 236.2501);
    CreateObject(3593, 1443.661133, -1722.936523, 6.569543, 0.0, 0.0, 270.0);
    CreateObject(2780, 1755.404175, -1792.307983, 2.134372, 0.0, 0.0, 0.0);
    CreateObject(1438, 2465.643799, -1848.222534, 0.651640, 0.0, 0.0, 236.2500);
    CreateObject(1438, 2465.441162, -1859.291382, 0.649957, 0.0, 0.0, 101.2501);
    CreateObject(1438, 2466.279297, -1841.175781, 0.664732, 0.0, 0.0, 33.7501);
    CreateObject(1438, 2413.710938, -1851.040894, 0.440315, 0.0, 0.0, 135.0);
    CreateObject(1634, 1594.2537, -1235.9625, 278.1727, 0.0000, 0.0000, 270.0000);
    CreateObject(1634, 1594.2715, -1239.8384, 278.1737, 0.0000, 0.0000, 270.0000);
    CreateObject(16080, 1572.9413, -1103.8241, 240.9369, 0.0000, 0.0000, 78.7500);
    CreateObject(1696, 1572.4771, -1102.8084, 242.9896, 0.0000, 0.0000, 0.0000);
    CreateObject(16318, 1574.8813, -1033.4459, 222.6587, 0.0000, 0.0000, 90.0000);
    CreateObject(16301, 1574.7073, -1004.2513, 230.2957, 0.0000, 0.0000, 90.0000);
    CreateObject(3461, 1563.6667, -1219.6361, 278.4545, 0.0000, 0.0000, 0.0000);
    CreateObject(3461, 1575.5963, -1219.7428, 278.4516, 0.0000, 0.0000, 0.0000);
    CreateObject(16135, 1569.1493, -936.5814, 235.8146, 0.0000, 0.0000, 90.0000);
    CreateObject(5441, 2745.3179, -1779.8740, 467.0770, 0.0000, 0.0000, 0.0000);
    CreateObject(5441, 2634.2964, -1779.8444, 467.0637, 0.0000, 0.0000, 0.0000);
    CreateObject(5441, 2847.5715, -1779.9779, 467.0735, 0.0000, 0.0000, 0.0000);
    CreateObject(5441, 2947.5125, -1779.9960, 467.0360, 0.0000, 0.0000, 0.0000);
    CreateObject(4651, 2513.6030, -1817.6064, 466.8461, 0.0000, 0.0000, 90.0000);
    CreateObject(4651, 2498.3450, -1926.4006, 466.5806, 0.0000, 0.0000, 180.0000);
    CreateObject(5441, 2598.7307, -1978.8816, 466.5603, 0.0000, 0.0000, 0.0000);
    CreateObject(5441, 2657.4377, -1978.8300, 466.5128, 0.0000, 0.0000, 0.0000);
    CreateObject(5441, 2770.1089, -1978.7921, 466.4279, 0.0000, 0.0000, 0.0000);
    CreateObject(5441, 2869.3235, -1978.7885, 466.3802, 0.0000, 0.0000, 0.0000);
    CreateObject(5441, 2976.9155, -1978.7866, 466.3315, 0.0000, 0.0000, 0.0000);
    CreateObject(5441, 3032.8618, -1978.8831, 466.3090, 0.0000, 0.0000, 0.0000);
    CreateObject(4651, 3149.4810, -1940.6259, 0.3421, 0.0000, 0.0000, 270.0000);
    CreateObject(4651, 3149.7632, -1941.3744, 466.0034, 0.0000, 0.0000, 270.0000);
    CreateObject(4651, 3164.8589, -1838.0000, 465.7987, 0.0000, 0.0000, 0.0000);
    CreateObject(5441, 3066.1675, -1785.3661, 465.8275, 0.0000, 0.0000, 0.0000);
    CreateObject(1634, 3010.3865, -1786.4979, 467.0311, 0.0000, 0.0000, 90.0000);
    CreateObject(1634, 3010.4512, -1782.5612, 467.0561, 0.0000, 0.0000, 90.0000);
    CreateObject(1634, 3010.4971, -1778.5859, 467.0452, 0.0000, 0.0000, 90.0000);
    CreateObject(1312, 2907.5393, -1774.8501, 471.3027, 0.0000, 0.0000, 270.0000);
    CreateObject(4651, 3165.2112, -1838.5310, 465.7884, 0.0000, 0.0000, 0.0000);
    CreateObject(4651, 3148.9944, -1941.5669, 466.0514, 0.0000, 0.0000, 270.0000);
    CreateObject(4651, 2497.7249, -1925.4670, 466.6154, 0.0000, 0.0000, 180.0000);
    CreateObject(4651, 2514.1692, -1817.3818, 466.7770, 0.0000, 0.0000, 90.0001);
    CreateObject(1633, 2447.0630, -1867.0035, 466.6741, 0.0000, 0.0000, 270.0000);
    CreateObject(1633, 2447.0613, -1870.7201, 466.6491, 0.0000, 0.0000, 270.0000);
    CreateObject(5441, 2566.4641, -1233.5839, 777.0843, 0.0000, 0.0000, 90.0000);
    CreateObject(5441, 2566.5000, -1120.8000, 747.9800, 0.0000, 28.6479, 90.0000);
    CreateObject(5441, 2566.4016, -1027.4866, 697.0321, 0.0000, 28.6479, 90.0000);
    CreateObject(5441, 2566.4646, -940.3200, 649.4200, 0.0000, 28.6479, 90.0000);
    CreateObject(5441, 2566.4646, -849.0171, 599.5765, 0.0000, 28.6479, 90.0000);
    CreateObject(1634, 2566.5010, -702.1860, 520.5139, 331.3521, 0.0000, 0.0000);
    CreateObject(1634, 2570.4956, -702.2621, 520.5554, 331.3521, 0.0000, 0.0000);
    CreateObject(1634, 2562.4717, -702.0867, 520.4596, 331.3521, 0.0000, 0.0000);
    CreateObject(1676, 2566.7026, -644.6838, 137.3505, 0.0000, 0.0000, 0.0000);
    CreateObject(5441, 2566.4607, -747.5754, 544.2241, 0.0000, 28.6479, 90.0000);
    CreateObject(5441, 2566.3933, -954.6849, 657.2982, 0.0000, 28.6479, 90.0000);
    CreateObject(1318, 2566.8606, -1289.8987, 777.4890, 0.0000, 0.0000, 90.0000);
    CreateObject(16152, -2817.405273, -1516.518311, 139.839569, 0.0, 0.0, 270.0001);
    CreateObject(2064, -2800.956055, -1509.953979, 138.918289, 0.0, 0.0, 202.5000);
    CreateObject(2061, -2801.359863, -1510.684204, 138.580994, 0.0, 0.0, 101.2500);
    CreateObject(1485, -2801.322754, -1508.975220, 139.218216, 0.0, 0.0, 135.0);
    CreateObject(1665, -2817.981445, -1529.164063, 140.876373, 0.0, 0.0, 112.5000);
    CreateObject(1485, -2818.154785, -1528.958252, 140.855179, 0.0, 0.0, 315.0);
    CreateObject(1486, -2819.174561, -1529.425903, 140.985870, 0.0, 0.0, 0.0);
    CreateObject(1486, -2814.820557, -1516.795532, 140.910339, 0.0, 0.0, 0.0);
    CreateObject(1455, -2812.789307, -1529.953125, 140.932602, 0.0, 0.0, 0.0);
    CreateObject(1492, -2811.437500, -1523.164673, 139.884201, 0.0, 0.0, 270.0);
    CreateObject(1492, -2821.262451, -1517.901001, 139.835602, 0.0, 0.0, 270.0);
    CreateObject(1670, -2817.413574, -1516.653931, 140.800842, 0.0, 0.0, 0.0);
    CreateObject(2838, -2819.721924, -1516.631714, 140.763474, 0.0, 0.0, 0.0);
    CreateObject(2035, -2812.771729, -1516.571289, 140.789841, 0.0, 0.0, 123.7499);
    CreateObject(2670, -2817.488770, -1527.460449, 139.935806, 0.0, 0.0, 0.0);
    CreateObject(2672, -2817.652100, -1523.514771, 140.123215, 0.0, 0.0, 0.0);
    CreateObject(2673, -2818.461426, -1526.052368, 139.931580, 0.0, 0.0, 0.0);
    CreateObject(2673, -2816.142334, -1525.148804, 139.931580, 0.0, 0.0, 0.0);
    CreateObject(2850, -2815.189453, -1516.416382, 140.765762, 0.0, 0.0, 292.5000);
    CreateObject(2415, -2830.363037, -1522.237183, 136.820572, 0.0, 0.0, 89.9999);
    CreateObject(16151, -2816.144043, -1530.072754, 140.235504, 0.0, 0.0, 270.0);
    CreateObject(3461, -2830.483887, -1522.229126, 136.397919, 0.0, 0.0, 0.0);
    CreateObject(924, -2830.498779, -1522.149780, 138.209808, 0.0, 0.0, 0.0);
    CreateObject(924, -2830.441162, -1522.130127, 138.184296, 0.0, 0.0, 157.5000);
    CreateObject(1503, -2883.606689, -1509.283813, 136.043655, 0.0, 0.0, 90.0);
    CreateObject(1318, -2861.964111, -1510.467651, 137.027725, 0.0, 0.0, 0.0);
    CreateObject(3797, -2819.467773, -1523.788452, 141.259415, 0.0, 0.0, 90.0);
    CreateObject(3795, -2819.822998, -1523.606567, 140.184753, 0.0, 0.0, 270.0);
    CreateObject(3794, -2812.471191, -1520.504639, 140.443146, 0.0, 0.0, 90.0);
    CreateObject(3791, -2822.502686, -1525.467041, 138.753738, 0.0, 0.0, 270.0);
    CreateObject(3795, -2819.821777, -1526.923096, 140.184753, 0.0, 0.0, 270.0);
    CreateObject(2036, -2813.926025, -1529.143433, 140.874847, 0.0, 0.0, 180.0);
    CreateObject(2044, -2816.576660, -1529.160278, 140.868454, 0.0, 0.0, 90.0);
    CreateObject(2035, -2815.473389, -1529.137939, 140.865372, 0.0, 0.0, 337.5000);
    CreateObject(1655, 227.4096, -1794.9285, 4.4094, 0.0000, 0.0000, 90.0001);
    CreateObject(1655, 227.4177, -1786.2185, 4.3871, 0.0000, 0.0000, 90.0001);
    CreateObject(1655, 220.3448, -1794.9819, 9.8070, 28.6479, 0.0000, 90.0000);
    CreateObject(1655, 220.3576, -1786.2581, 9.8186, 28.6479, 0.0000, 90.0000);
    CreateObject(1655, 216.8395, -1794.9889, 17.9537, 57.2958, 0.0000, 90.0000);
    CreateObject(1655, 216.8571, -1786.2484, 17.9712, 57.2958, 0.0000, 90.0000);
    CreateObject(1655, 227.2778, -1803.6538, 4.4649, 0.0000, 0.0000, 90.0001);
    CreateObject(1655, 220.2665, -1803.6576, 9.9288, 28.6479, 0.0000, 90.0000);
    CreateObject(1655, 216.8783, -1803.6945, 17.9343, 57.2958, 0.0000, 90.0000);
    CreateObject(1655, 237.0942, -1786.1625, 3.1180, 342.8113, 0.0000, 270.0000);
    CreateObject(1655, 236.8943, -1794.8488, 3.1379, 342.8113, 0.0000, 270.0000);
    CreateObject(1655, 245.5414, -1786.1783, 5.2847, 0.0000, 0.0000, 270.0002);
    CreateObject(1655, 245.5374, -1794.8330, 5.3313, 0.0000, 0.0000, 270.0002);
    CreateObject(1655, 252.4065, -1786.1471, 10.5891, 28.6479, 0.0000, 270.0000);
    CreateObject(1655, 252.4136, -1794.7638, 10.6103, 28.6479, 0.0000, 270.0000);
    CreateObject(1655, 255.9612, -1794.7957, 18.7148, 57.2958, 0.0000, 270.0000);
    CreateObject(1655, 255.9585, -1786.1171, 18.7471, 57.2958, 0.0000, 270.0000);
    CreateObject(3631, 259.6665, -1782.7719, 22.0906, 0.0000, 0.0000, 0.0000);
    CreateObject(3631, 259.6714, -1784.7485, 22.0772, 0.0000, 0.0000, 0.0000);
    CreateObject(3631, 259.7035, -1786.7498, 22.0398, 0.0000, 0.0000, 0.0000);
    CreateObject(3631, 259.7008, -1788.7404, 22.0187, 0.0000, 0.0000, 0.0000);
    CreateObject(3631, 259.7067, -1790.7360, 22.0091, 0.0000, 0.0000, 0.0000);
    CreateObject(3631, 259.7155, -1792.7280, 22.0179, 0.0000, 0.0000, 0.0000);
    CreateObject(3631, 259.6990, -1794.7268, 21.9995, 0.0000, 0.0000, 0.0000);
    CreateObject(3631, 259.7094, -1796.7261, 21.9972, 0.0000, 0.0000, 0.0000);
    CreateObject(3631, 259.7202, -1798.7075, 21.9926, 0.0000, 0.0000, 0.0000);
    CreateObject(3631, 213.0216, -1807.6846, 21.2604, 0.0000, 0.0000, 0.0000);
    CreateObject(3631, 213.0183, -1805.6874, 21.2777, 0.0000, 0.0000, 0.0000);
    CreateObject(3631, 213.0109, -1803.7325, 21.2683, 0.0000, 0.0000, 0.0000);
    CreateObject(3631, 213.0073, -1801.7267, 21.2768, 0.0000, 0.0000, 0.0000);
    CreateObject(3631, 213.0126, -1799.7365, 21.2986, 0.0000, 0.0000, 0.0000);
    CreateObject(3631, 213.0250, -1797.7139, 21.3060, 0.0000, 0.0000, 0.0000);
    CreateObject(3631, 213.0119, -1795.7216, 21.3344, 0.0000, 0.0000, 0.0000);
    CreateObject(3631, 213.0118, -1793.7250, 21.3413, 0.0000, 0.0000, 0.0000);
    CreateObject(3631, 212.9920, -1791.7218, 21.3346, 0.0000, 0.0000, 0.0000);
    CreateObject(3631, 213.0075, -1789.7157, 21.3229, 0.0000, 0.0000, 0.0000);
    CreateObject(3631, 212.9833, -1787.7540, 21.3054, 0.0000, 0.0000, 0.0000);
    CreateObject(3631, 212.9488, -1785.7767, 21.3028, 0.0000, 0.0000, 0.0000);
    CreateObject(3631, 212.9659, -1783.7598, 21.2622, 0.0000, 0.0000, 0.0000);
    CreateObject(1655, 236.8767, -1803.6045, 3.1363, 342.8113, 0.0000, 270.0000);
    CreateObject(1655, 245.5163, -1803.5369, 5.3234, 0.0000, 0.0000, 270.0002);
    CreateObject(1655, 252.5204, -1803.5160, 10.7472, 28.6479, 0.0000, 270.0000);
    CreateObject(1655, 255.9845, -1803.3682, 18.7471, 57.2958, 0.0000, 270.0000);
    CreateObject(1655, 227.0155, -1812.3842, 4.6213, 0.0000, 0.0000, 90.0001);
    CreateObject(1655, 220.1434, -1812.3116, 10.0543, 28.6479, 0.0000, 90.0000);
    CreateObject(1655, 216.8634, -1812.3386, 17.9530, 57.2958, 0.0000, 90.0000);
    CreateObject(3631, 213.0134, -1809.6371, 21.2452, 0.0000, 0.0000, 0.0000);
    CreateObject(3631, 213.0232, -1811.6213, 21.2516, 0.0000, 0.0000, 0.0000);
    CreateObject(3631, 213.0318, -1813.6254, 21.2616, 0.0000, 0.0000, 0.0000);
    CreateObject(3631, 213.0374, -1815.6150, 21.2220, 0.0000, 0.0000, 0.0000);
    CreateObject(3631, 212.9456, -1782.7795, 21.2451, 0.0000, 0.0000, 0.0000);
    CreateObject(3631, 259.7292, -1800.7252, 22.0009, 0.0000, 0.0000, 0.0000);
    CreateObject(3631, 259.7327, -1802.7084, 21.9981, 0.0000, 0.0000, 0.0000);
    CreateObject(3631, 259.7682, -1804.7153, 22.0136, 0.0000, 0.0000, 0.0000);
    CreateObject(3631, 259.7597, -1806.7115, 22.0330, 0.0000, 0.0000, 0.0000);
    CreateObject(994, 256.7117, -1781.9980, 22.7704, 0.0000, 0.0000, 0.0000);
    CreateObject(994, 263.2076, -1782.1624, 22.7454, 0.0000, 0.0000, 270.0000);
    CreateObject(994, 263.2556, -1788.4945, 22.6985, 0.0000, 0.0000, 270.0000);
    CreateObject(994, 263.2602, -1794.9146, 22.6724, 0.0000, 0.0000, 270.0000);
    CreateObject(994, 263.2563, -1801.2227, 22.6779, 0.0000, 0.0000, 270.0000);
    CreateObject(994, 262.6281, -1807.5033, 22.7128, 0.0000, 0.0000, 180.0000);
    CreateObject(994, 216.1822, -1816.3915, 21.9018, 0.0000, 0.0000, 180.0000);
    CreateObject(994, 209.4336, -1816.2672, 21.9018, 0.0000, 0.0000, 90.0001);
    CreateObject(994, 209.4332, -1809.4897, 21.9250, 0.0000, 0.0000, 90.0001);
    CreateObject(994, 209.4697, -1802.6816, 21.9340, 0.0000, 0.0000, 90.0001);
    CreateObject(994, 209.4382, -1795.9014, 21.9359, 0.0000, 0.0000, 90.0001);
    CreateObject(994, 209.4360, -1789.0074, 21.9027, 0.0000, 0.0000, 90.0001);
    CreateObject(994, 209.8688, -1782.0555, 21.9249, 0.0000, 0.0000, 0.0000);
    CreateObject(8343, 691.7592, -2522.3472, 0.0285, 0.0000, 0.0000, 258.7500);
    CreateObject(8344, 658.2827, -2605.6924, 0.1146, 0.0000, 0.0000, 78.7500);
    CreateObject(8357, 551.2974, -2469.8394, 0.0480, 0.0000, 0.0000, 78.7500);
    CreateObject(8357, 492.2094, -2597.2627, 0.1728, 0.0000, 0.0000, 78.7500);
    CreateObject(8344, 380.1099, -2460.4124, 0.0274, 0.0000, 0.0000, 258.7500);
    CreateObject(8343, 346.5196, -2543.7227, 0.1564, 0.0000, 0.0000, 78.7500);
    CreateObject(1655, 182.0686, -1853.9978, 3.6683, 345.6761, 45.8366, 27.6845);
    CreateObject(1655, 181.9854, -1846.5782, 3.8651, 345.6761, 45.8366, 5.1845);
    CreateObject(1655, 184.4266, -1840.4524, 3.9801, 345.6761, 45.8366, 342.6844);
    CreateObject(1655, 189.4077, -1835.4287, 4.1542, 345.6761, 45.8366, 320.1844);
    CreateObject(1655, 195.8115, -1833.0439, 4.1963, 345.6761, 45.8366, 297.6844);
    CreateObject(1655, 203.0863, -1833.2800, 4.1637, 345.6761, 45.8366, 275.1844);
    CreateObject(1655, 209.0251, -1835.8326, 4.0526, 345.6761, 45.8366, 252.6844);
    CreateObject(1655, 213.7625, -1840.9427, 3.8809, 345.6761, 45.8366, 230.1845);
    CreateObject(1655, 216.1578, -1847.5356, 3.6941, 345.6761, 45.8366, 207.6845);
    CreateObject(1655, 216.2014, -1853.0095, 3.5508, 345.6761, 45.8366, 185.1845);
    CreateObject(1655, 213.0539, -1859.1748, 3.4114, 345.6761, 45.8366, 151.4346);
    CreateObject(1655, 207.6500, -1862.4983, 3.3483, 345.6761, 45.8366, 128.9347);
    CreateObject(1655, 200.7829, -1864.5193, 3.3291, 345.6761, 45.8366, 117.6847);
    CreateObject(1655, 184.2320, -1859.1012, 3.5314, 345.6761, 45.8366, 50.1848);
    CreateObject(1655, 195.3749, -1864.9611, 3.3374, 345.6761, 45.8366, 106.4347);
    CreateObject(1655, 188.9046, -1863.4236, 3.4013, 345.6761, 45.8366, 72.6848);
    CreateObject(1697, 232.9465, -1851.9309, 3.8036, 0.0000, 0.0000, 270.0000);
    CreateObject(13592, 333.8403, -1846.1776, 11.6355, 74.4845, 0.0000, 348.7501);
    CreateObject(13592, 335.1796, -1844.5404, 18.2244, 74.4845, 0.0000, 348.7502);
    CreateObject(13592, 336.3994, -1843.0258, 24.4285, 74.4845, 0.0000, 348.7505);
    CreateObject(13592, 338.0439, -1841.2725, 31.4275, 74.4845, 0.0000, 348.7505);
    CreateObject(1632, 331.7280, -1839.0985, 2.8488, 0.0000, 28.6479, 281.2500);
    CreateObject(13592, 339.5121, -1839.5529, 38.2554, 74.4845, 0.0000, 348.7505);
    CreateObject(13642, 296.2216, -1873.7246, 3.5792, 0.0000, 0.0000, 0.0001);
	b1=CreateObject(3374, -277.795959, -1328.474365, 8.293514, 0.0000, 0.0000, 180.0002);
	b2=CreateObject(3374, -277.622650, -1336.372437, 8.122874, 0.0000, 0.0000, 180.0002);
	b3=CreateObject(3374, -277.431732, -1340.441406, 8.063190, 0.0000, 0.0000, 180.0000);
	b4=CreateObject(3374, -273.915497, -1340.683228, 16.973503, 0.0000, 0.0000, 270.0004);
	b5=CreateObject(3374, -269.968719, -1340.585327, 16.992702, 0.0000, 0.0000, 270.0004);
	b6=CreateObject(3374, -265.975616, -1340.652832, 16.933535, 0.0000, 0.0000, 270.0004);
	b7=CreateObject(3374, -262.010498, -1340.692627, 16.964914, 0.0000, 0.0000, 270.0004);
	b8=CreateObject(3374, -258.036041, -1340.704834, 17.010767, 0.0000, 0.0000, 270.0005);
	b9=CreateObject(3374, -257.962036, -1336.668579, 17.076801, 0.0000, 0.0000, 0.0006);
	b10=CreateObject(3374, -257.980469, -1332.655518, 17.083822, 0.0000, 0.0000, 0.0006);
	b11=CreateObject(3374, -258.095306, -1328.563232, 17.168003, 0.0000, 0.0000, 0.0006);
	b12=CreateObject(3374, -257.965912, -1324.579834, 17.178797, 0.0000, 0.0000, 90.0006);
	b13=CreateObject(3374, -261.943634, -1324.513428, 17.088385, 0.0000, 0.0000, 90.0006);
	b14=CreateObject(3374, -266.010651, -1324.486206, 17.108250, 0.0000, 0.0000, 90.0006);
	b15=CreateObject(3374, -270.025421, -1324.524292, 17.029274, 0.0000, 0.0000, 90.0006);
	b16=CreateObject(3374, -274.042969, -1324.489624, 17.002766, 0.0000, 0.0000, 90.0003);
	b17=CreateObject(3374, -262.229034, -1328.580322, 17.212660, 0.0000, 0.0000, 90.0006);
	b18=CreateObject(3374, -259.990784, -1332.705688, 17.033823, 0.0000, 0.0000, 90.0006);
	b19=CreateObject(3374, -262.158600, -1336.760620, 17.102060, 0.0000, 0.0000, 90.0006);
	b20=CreateObject(3374, -266.317352, -1328.639648, 17.090569, 0.0000, 0.0000, 90.0006);
	b21=CreateObject(3374, -266.215820, -1332.617920, 17.088394, 0.0000, 0.0000, 90.0006);
	b22=CreateObject(3374, -266.222473, -1336.588379, 17.059843, 0.0000, 0.0000, 90.0006);
	b23=CreateObject(3374, -270.337219, -1328.524170, 17.025202, 0.0000, 0.0000, 90.0006);
	b24=CreateObject(3374, -270.248322, -1332.563477, 17.006952, 0.0000, 0.0000, 90.0006);
	b25=CreateObject(3374, -270.153748, -1336.435913, 17.118042, 0.0000, 0.0000, 90.0006);
	b26=CreateObject(3374, -274.287262, -1328.413818, 16.909967, 0.0000, 0.0000, 90.0006);
	b27=CreateObject(3374, -274.255859, -1332.271118, 16.929693, 0.0000, 0.0000, 90.0006);
	b28=CreateObject(3374, -277.571167, -1344.479004, 7.916314, 0.0000, 0.0000, 270.0007);
	b29=CreateObject(3374, -273.899994, -1344.436646, 7.769637, 0.0000, 0.0000, 270.0006);
	b30=CreateObject(3374, -269.884766, -1344.382324, 7.731488, 0.0000, 0.0000, 270.0006);
	b31=CreateObject(3374, -265.846680, -1344.389526, 7.731573, 0.0000, 0.0000, 270.0006);
	b32=CreateObject(3374, -261.870087, -1344.374268, 7.723220, 0.0000, 0.0000, 270.0006);
	b33=CreateObject(3374, -257.884277, -1344.394287, 7.693246, 0.0000, 0.0000, 270.0006);
	b34=CreateObject(3374, -254.236359, -1344.494751, 7.660328, 0.0000, 0.0000, 270.0006);
	b35=CreateObject(3374, -254.222839, -1340.554810, 7.838885, 0.0000, 0.0000, 0.0006);
	b36=CreateObject(3374, -254.106827, -1336.586792, 7.900655, 0.0000, 0.0000, 0.0006);
	b37=CreateObject(3374, -253.925049, -1328.511963, 8.053417, 0.0000, 0.0000, 0.0006);
	b38=CreateObject(3374, -253.873138, -1324.582397, 8.140799, 0.0000, 0.0000, 0.0006);
	b39=CreateObject(3374, -254.080261, -1320.689453, 8.061488, 0.0000, 0.0000, 90.0007);
	b40=CreateObject(3374, -258.040466, -1320.693726, 8.021676, 0.0000, 0.0000, 90.0007);
	b41=CreateObject(3374, -262.050201, -1320.771484, 8.181780, 0.0000, 0.0000, 90.0007);
	b42=CreateObject(3374, -266.088715, -1320.708984, 8.201214, 0.0000, 0.0000, 90.0007);
	b43=CreateObject(3374, -269.875885, -1320.550293, 8.392005, 0.0000, 0.0000, 90.0007);
	b44=CreateObject(3374, -273.947174, -1320.481689, 8.391057, 0.0000, 0.0000, 90.0007);
	b45=CreateObject(3374, -277.930420, -1320.474365, 8.361448, 0.0000, 0.0000, 90.0007);
	b46=CreateObject(3374, -277.548523, -1344.491089, 10.798084, 0.0000, 0.0000, 270.0000);
	b47=CreateObject(3374, -277.628235, -1344.604248, 13.798084, 0.0000, 0.0000, 270.0000);
	b48=CreateObject(3374, -273.504456, -1344.439697, 10.769636, 0.0000, 0.0000, 270.0000);
	b49=CreateObject(3374, -273.585327, -1344.551514, 13.769636, 0.0000, 0.0000, 270.0000);
	b50=CreateObject(3374, -269.979675, -1344.352173, 10.731488, 0.0000, 0.0000, 270.0000);
	b51=CreateObject(3374, -269.989014, -1344.455444, 13.731488, 0.0000, 0.0000, 270.0000);
	b52=CreateObject(3374, -265.951721, -1344.440796, 10.731573, 0.0000, 0.0000, 270.0000);
	b53=CreateObject(3374, -266.052216, -1344.526123, 13.731573, 0.0000, 0.0000, 270.0000);
	b54=CreateObject(3374, -261.887634, -1344.546875, 10.723221, 0.0000, 0.0000, 270.0000);
	b55=CreateObject(3374, -262.028656, -1344.613403, 13.723221, 0.0000, 0.0000, 270.0000);
	b56=CreateObject(3374, -257.896515, -1344.483154, 10.693247, 0.0000, 0.0000, 270.0000);
	b57=CreateObject(3374, -258.005280, -1344.558716, 13.693247, 0.0000, 0.0000, 270.0000);
	b58=CreateObject(3374, -254.399490, -1344.516113, 10.660328, 0.0000, 0.0000, 270.0000);
	b59=CreateObject(3374, -254.505493, -1344.540161, 13.660328, 0.0000, 0.0000, 270.0000);
	b60=CreateObject(3374, -254.105255, -1340.564575, 10.838885, 0.0000, 0.0000, 0.0000);
	b61=CreateObject(3374, -253.964218, -1340.517456, 13.838885, 0.0000, 0.0000, 0.0000);
	b62=CreateObject(3374, -254.104736, -1336.578613, 10.900655, 0.0000, 0.0000, 0.0000);
	b63=CreateObject(3374, -253.961823, -1336.545410, 13.900655, 0.0000, 0.0000, 0.0000);
	b64=CreateObject(3374, -254.016144, -1332.556396, 10.966618, 0.0000, 0.0000, 0.0000);
	b65=CreateObject(3374, -253.733963, -1332.748535, 13.966618, 0.0000, 0.0000, 0.0000);
	b66=CreateObject(3374, -253.901657, -1328.489258, 11.053417, 0.0000, 0.0000, 0.0006);
	b67=CreateObject(3374, -253.649292, -1328.628174, 14.053417, 0.0000, 0.0000, 0.0006);
	b68=CreateObject(3374, -253.851944, -1324.550171, 11.190798, 0.0000, 0.0000, 0.0006);
	b69=CreateObject(3374, -253.828629, -1324.610474, 13.990801, 0.0000, 0.0000, 0.0006);
	b70=CreateObject(3374, -253.983261, -1320.699341, 11.061488, 0.0000, 0.0000, 90.0006);
	b71=CreateObject(3374, -253.853516, -1320.731201, 14.061488, 0.0000, 0.0000, 90.0006);
	b72=CreateObject(3374, -257.960785, -1320.766357, 11.021676, 0.0000, 0.0000, 90.0007);
	b73=CreateObject(3374, -257.950134, -1320.730957, 14.021676, 0.0000, 0.0000, 90.0007);
	b74=CreateObject(3374, -262.076019, -1320.699341, 11.181780, 0.0000, 0.0000, 90.0007);
	b75=CreateObject(3374, -261.937805, -1320.434570, 14.181780, 0.0000, 0.0000, 90.0007);
	b76=CreateObject(3374, -266.097504, -1320.537842, 11.201214, 0.0000, 0.0000, 90.0007);
	b77=CreateObject(3374, -265.983917, -1320.375732, 14.201214, 0.0000, 0.0000, 90.0007);
	b78=CreateObject(3374, -270.115204, -1320.556519, 11.392005, 0.0000, 0.0000, 90.0007);
	b79=CreateObject(3374, -270.016602, -1320.190063, 14.392005, 0.0000, 0.0000, 90.0007);
	b80=CreateObject(3374, -274.051697, -1320.429810, 11.391057, 0.0000, 0.0000, 90.0007);
	b81=CreateObject(3374, -273.910309, -1320.303711, 14.391057, 0.0000, 0.0000, 90.0007);
	b82=CreateObject(3374, -277.697937, -1320.444824, 11.361448, 0.0000, 0.0000, 90.0007);
	b83=CreateObject(3374, -277.673340, -1320.363281, 14.361448, 0.0000, 0.0000, 90.0007);
	b84=CreateObject(3374, -253.887772, -1320.365112, 17.111488, 0.0000, 0.0000, 90.0008);
	b85=CreateObject(3374, -257.930817, -1320.554565, 17.096674, 0.0000, 0.0000, 90.0009);
	b86=CreateObject(3374, -261.913300, -1320.289551, 16.981783, 0.0000, 0.0000, 90.0009);
	b87=CreateObject(3374, -265.948944, -1320.214478, 16.901218, 0.0000, 0.0000, 90.0009);
	b88=CreateObject(3374, -270.020599, -1320.296021, 16.942013, 0.0000, 0.0000, 90.0009);
	b89=CreateObject(3374, -274.138824, -1320.541748, 17.116060, 0.0000, 0.0000, 90.0007);
	b90=CreateObject(3374, -277.596558, -1320.281982, 17.086452, 0.0000, 0.0000, 90.0007);
	b91=CreateObject(3374, -277.561462, -1344.501587, 16.798084, 0.0000, 0.0000, 270.0000);
	b92=CreateObject(3374, -273.556091, -1344.497681, 16.769636, 0.0000, 0.0000, 270.0000);
	b93=CreateObject(3374, -270.005981, -1344.456177, 16.731487, 0.0000, 0.0000, 270.0008);
	b94=CreateObject(3374, -266.096344, -1344.583862, 16.731573, 0.0000, 0.0000, 270.0008);
	b95=CreateObject(3374, -262.114899, -1344.577271, 16.723221, 0.0000, 0.0000, 270.0008);
	b96=CreateObject(3374, -258.093079, -1344.532837, 16.693247, 0.0000, 0.0000, 270.0008);
	b97=CreateObject(3374, -254.530106, -1344.451538, 16.660328, 0.0000, 0.0000, 270.0008);
	b98=CreateObject(3374, -254.031967, -1340.584717, 16.838886, 0.0000, 0.0000, 0.0009);
	b99=CreateObject(3374, -253.855865, -1336.650391, 16.900654, 0.0000, 0.0000, 0.0009);
	b100=CreateObject(3374, -253.691299, -1332.604248, 16.966618, 0.0000, 0.0000, 0.0009);
	b101=CreateObject(3374, -253.527618, -1328.555420, 17.053417, 0.0000, 0.0000, 0.0009);
	b102=CreateObject(3374, -253.646637, -1324.512207, 16.990801, 0.0000, 0.0000, 0.0009);
	b103=CreateObject(3374, -274.079407, -1336.416260, 16.895048, 0.0000, 0.0000, 0.0006);
	b104=CreateObject(3374, -273.797028, -1338.688110, 16.997570, 0.0000, 0.0000, 0.0006);
	b105=CreateObject(3374, -259.957092, -1336.735107, 17.073521, 0.0000, 0.0000, 270.0006);
	b106=CreateObject(3374, -253.839874, -1320.359009, 20.111488, 0.0000, 0.0000, 90.0007);
	b107=CreateObject(3374, -254.508026, -1344.581543, 19.660328, 0.0000, 0.0000, 270.0008);
	b108=CreateObject(3374, -266.126099, -1316.526367, 9.855675, 0.0000, 0.0000, 90.0007);
	b109=CreateObject(3374, -266.280060, -1312.304443, 10.209438, 0.0000, 0.0000, 90.0007);
	b110=CreateObject(3374, -266.311951, -1308.532349, 10.129108, 0.0000, 0.0000, 90.0007);
	b111=CreateObject(3374, -266.193268, -1316.263794, 12.805676, 0.0000, 0.0000, 90.0007);
	b112=CreateObject(3374, -266.362183, -1312.177246, 13.109440, 0.0000, 0.0000, 90.0007);
	b113=CreateObject(1318, -364.866333, -1395.623169, 20.929628, 0.0000, 0.0000, 0.0000);
	b114=CreateObject(3374, -277.807678, -1324.502075, 8.364038, 0.0000, 0.0000, 180.0000);
	b115=CreateObject(3374, -277.837616, -1324.477783, 11.364038, 0.0000, 0.0000, 180.0000);
	b116=CreateObject(3374, -277.798828, -1328.427368, 11.293514, 0.0000, 0.0000, 180.0000);
	b117=CreateObject(3374, -277.752777, -1332.404541, 11.248959, 0.0000, 0.0000, 180.0000);
	b118=CreateObject(3374, -277.636261, -1336.444946, 11.122874, 0.0000, 0.0000, 180.0000);
	b119=CreateObject(3374, -277.406219, -1340.322144, 11.063190, 0.0000, 0.0000, 180.0000);
	b120=CreateObject(3374, -277.876678, -1324.560059, 14.364038, 0.0000, 0.0000, 180.0000);
	b121=CreateObject(3374, -277.850616, -1328.369263, 14.293514, 0.0000, 0.0000, 180.0000);
	b122=CreateObject(3374, -277.750214, -1332.356323, 14.248959, 0.0000, 0.0000, 180.0000);
	b123=CreateObject(3374, -277.681000, -1336.450317, 14.122874, 0.0000, 0.0000, 180.0000);
	b124=CreateObject(3374, -277.544006, -1340.454590, 14.063190, 0.0000, 0.0000, 180.0000);
	b125=CreateObject(3374, -278.084717, -1324.631714, 17.089043, 0.0000, 0.0000, 180.0006);
	b126=CreateObject(3374, -278.074554, -1328.483887, 17.118517, 0.0000, 0.0000, 180.0006);
	b127=CreateObject(3374, -278.063660, -1332.452026, 17.023962, 0.0000, 0.0000, 180.0006);
	b128=CreateObject(3374, -277.883667, -1336.391968, 17.122875, 0.0000, 0.0000, 180.0006);
	b129=CreateObject(3374, -277.663147, -1340.556519, 17.063190, 0.0000, 0.0000, 180.0006);
	b130=CreateObject(3374, -261.994171, -1320.423340, 19.981783, 0.0000, 0.0000, 90.0006);
	b131=CreateObject(3374, -269.940216, -1320.421753, 19.942013, 0.0000, 0.0000, 90.0007);
	b132=CreateObject(3374, -277.600525, -1320.405396, 20.086452, 0.0000, 0.0000, 90.0009);
	b133=CreateObject(3374, -253.674194, -1328.533447, 20.053417, 0.0000, 0.0000, 0.0007);
	b134=CreateObject(3374, -254.006134, -1336.603516, 19.900654, 0.0000, 0.0000, 0.0007);
	b135=CreateObject(3374, -262.106873, -1344.575684, 19.723221, 0.0000, 0.0000, 270.0007);
	b136=CreateObject(3374, -269.714600, -1344.600342, 19.731487, 0.0000, 0.0000, 270.0007);
	b137=CreateObject(3374, -277.563232, -1344.633789, 19.798084, 0.0000, 0.0000, 270.0007);
	b138=CreateObject(3374, -278.129486, -1328.491455, 20.118517, 0.0000, 0.0000, 180.0009);
	b139=CreateObject(3374, -278.143280, -1336.280151, 20.122875, 0.0000, 0.0000, 180.0009);
	b140=CreateObject(3374, -253.868347, -1332.515015, 8.147121, 0.0000, 0.0000, 0.0000);
	b141=CreateObject(3374, -266.289276, -1316.327515, 15.805676, 0.0000, 0.0000, 90.0007);

	b142=CreateObject(3374, -269.476196, -1362.841309, 9.914375, 0.0000, 0.0000, 89.9998);
	b143=CreateObject(3374, -277.405975, -1366.923340, 10.320328, 0.0000, 0.0000, 179.9998);
	b144=CreateObject(3374, -277.500854, -1370.857910, 10.515165, 0.0000, 0.0000, 269.9998);
	b145=CreateObject(3374, -273.555969, -1370.901367, 10.513641, 0.0000, 0.0000, 269.9998);
	b146=CreateObject(3374, -273.460815, -1362.894775, 9.969217, 0.0000, 0.0000, 89.9998);
	b147=CreateObject(3374, -277.408386, -1362.933838, 10.049191, 0.0000, 0.0000, 89.9998);
	b148=CreateObject(3374, -277.490692, -1366.890747, 13.020332, 0.0000, 0.0000, 179.9998);
	b149=CreateObject(3374, -269.457306, -1366.923706, 10.286041, 0.0000, 0.0000, 359.9998);
	b150=CreateObject(3374, -277.526245, -1363.068604, 13.049191, 0.0000, 0.0000, 89.9998);
	b151=CreateObject(3374, -269.539246, -1370.845825, 10.514158, 0.0000, 0.0000, 269.9998);
	b152=CreateObject(3374, -277.422760, -1370.790527, 13.140171, 0.0000, 0.0000, 269.9998);
	b153=CreateObject(3374, -273.684723, -1362.900024, 12.969217, 0.0000, 0.0000, 89.9998);
	b154=CreateObject(3374, -269.565582, -1362.806274, 12.914375, 0.0000, 0.0000, 89.9998);
	b155=CreateObject(3374, -269.525299, -1366.837402, 12.986046, 0.0000, 0.0000, 359.9998);
	b156=CreateObject(3374, -269.538452, -1370.828247, 13.189163, 0.0000, 0.0000, 269.9998);
	b157=CreateObject(3374, -273.595764, -1370.936035, 12.963650, 0.0000, 0.0000, 269.9998);
	b158=CreateObject(3374, -277.490448, -1362.919312, 16.049191, 0.0000, 0.0000, 89.9999);
	b159=CreateObject(3374, -273.591217, -1362.960083, 15.969217, 0.0000, 0.0000, 89.9999);
	b160=CreateObject(3374, -269.644440, -1362.928955, 15.914375, 0.0000, 0.0000, 89.9998);
	b161=CreateObject(3374, -269.588501, -1366.915649, 15.986046, 0.0000, 0.0000, 359.9998);
	b162=CreateObject(3374, -269.587128, -1370.815674, 16.189163, 0.0000, 0.0000, 269.9999);
	b163=CreateObject(3374, -273.587067, -1370.975464, 15.963650, 0.0000, 0.0000, 269.9999);
	b164=CreateObject(3374, -277.470886, -1370.986450, 16.140171, 0.0000, 0.0000, 269.9999);
	b165=CreateObject(3374, -277.375519, -1366.960571, 16.020332, 0.0000, 0.0000, 179.9999);
	b166=CreateObject(3374, -277.333771, -1367.006226, 19.020332, 0.0000, 0.0000, 179.9999);
	b167=CreateObject(3374, -277.456696, -1370.983032, 19.140171, 0.0000, 0.0000, 269.9999);
	b168=CreateObject(3374, -273.495758, -1370.973755, 18.963650, 0.0000, 0.0000, 269.9999);
	b169=CreateObject(3374, -269.476379, -1370.966553, 19.114164, 0.0000, 0.0000, 269.9999);
	b170=CreateObject(3374, -269.592926, -1367.050659, 18.986046, 0.0000, 0.0000, 359.9999);
	b171=CreateObject(3374, -269.657623, -1363.085205, 18.914375, 0.0000, 0.0000, 89.9998);
	b172=CreateObject(3374, -273.693298, -1363.013062, 18.969217, 0.0000, 0.0000, 89.9998);
	b173=CreateObject(3374, -277.605804, -1362.917725, 19.049191, 0.0000, 0.0000, 89.9998);
	b174=CreateObject(3374, -273.697388, -1348.433228, 16.689644, 0.0000, 0.0000, 89.9998);
	b175=CreateObject(3374, -273.723938, -1352.382202, 16.863255, 0.0000, 0.0000, 89.9998);
	b176=CreateObject(3374, -273.707458, -1356.327026, 16.923119, 0.0000, 0.0000, 89.9998);
	b177=CreateObject(3374, -273.656952, -1360.037109, 18.698137, 0.0000, 0.0000, 89.9998);
	b178=CreateObject(3374, -269.726837, -1363.061279, 21.914375, 0.0000, 0.0000, 89.9999);
	b179=CreateObject(3374, -269.658112, -1370.946167, 22.114164, 0.0000, 0.0000, 89.9999);
	b180=CreateObject(3374, -277.369690, -1370.938232, 22.140171, 0.0000, 0.0000, 89.9999);
	b181=CreateObject(3374, -277.623993, -1362.916870, 22.049191, 0.0000, 0.0000, 89.9999);
	b182=CreateObject(3374, -273.419800, -1367.084717, 18.939613, 0.0000, 0.0000, 89.9999);
	b183=CreateObject(3374, -277.757599, -1332.360229, 8.102072, 0.0000, 0.0000, 179.9998);

	CreateObject(1632, -2048.6631, -112.6469, 35.5109, 0.0000, 0.0000, 0.0000);
	CreateObject(1632, -2048.6821, -106.5468, 41.4386, 40.1070, 0.0000, 0.0000);
	CreateObject(1632, -2048.7068, -107.0327, 49.6027, 97.4028, 0.0000, 0.0000);
	CreateObject(2931, -2095.0549, -117.6610, 34.5037, 0.0000, 0.0000, 0.0000);
	CreateObject(2931, -2095.0574, -114.6552, 36.2538, 0.0000, 0.0000, 0.0000);
	CreateObject(2931, -2095.0781, -112.2090, 37.6447, 0.0000, 0.0000, 0.0000);
	CreateObject(18565, 1192.5323, -2059.0847, 69.3267, 0.0000, 0.0000, 0.0000);
    CreateObject(18565, 1198.2030, -2051.2954, 69.0517, 0.0000, 0.0000, 180.0000);
    CreateObject(13636, 1195.9390, -2017.2433, 70.1132, 0.0000, 0.0000, 0.0000);
    CreateObject(3364, 1151.1378, -2072.1357, 67.8388, 0.0000, 0.0000, 0.0000);
    CreateObject(1632, 1146.2699, -2036.7610, 69.3079, 0.0000, 0.0000, 90.0000);
    CreateObject(1632, 1132.5779, -2036.8091, 74.4332, 0.0000, 0.0000, 90.0000);
    CreateObject(6052, 1159.5718, -2002.5013, 70.4804, 0.0000, 0.0000, 191.2500);
    CreateObject(6052, 1139.0063, -1988.1342, 70.3480, 0.0000, 0.0000, 11.2500);
    CreateObject(1696, 1130.5419, -1980.3861, 69.3629, 0.0000, 0.0000, 0.0000);
    CreateObject(2931, 1143.4543, -2019.3625, 68.0412, 0.0000, 0.0000, 90.0000);
    CreateObject(2931, 1140.2501, -2019.4556, 69.8913, 0.0000, 0.0000, 90.0000);
    CreateObject(2931, 1140.6310, -2016.6969, 71.1664, 0.0000, 0.0000, 0.0000);
    CreateObject(2931, 1140.0026, -2013.6199, 72.8915, 0.0000, 0.0000, 0.0000);
    CreateObject(2931, 1136.7042, -2013.6636, 74.4323, 0.0000, 0.0000, 90.0000);
    CreateObject(18367, 1137.1257, -2013.0532, 75.8164, 0.0000, 0.0000, 270.0000);
    CreateObject(13641, 1118.0488, -2012.9946, 79.5083, 0.0000, 0.0000, 180.0000);
    CreateObject(1634, 1179.5444, -1997.6514, 69.0301, 0.0000, 0.0000, 0.0000);
    CreateObject(3374, 1175.2383, -1967.8094, 70.2769, 0.0000, 0.0000, 0.0000);
    CreateObject(3374, 1181.5416, -1969.5029, 70.3549, 0.0000, 0.0000, 0.0000);
    CreateObject(3374, 1176.5332, -1970.4502, 70.8646, 0.0000, 0.0000, 0.0000);
    CreateObject(3374, 1173.1750, -1970.7499, 69.8284, 0.0000, 0.0000, 0.0000);
    CreateObject(3374, 1178.4596, -1968.0034, 73.8646, 0.0000, 0.0000, 0.0000);
    CreateObject(3374, 1174.2366, -1968.8096, 72.8284, 0.0000, 0.0000, 0.0000);
    CreateObject(3374, 1174.5381, -1970.3514, 73.1572, 0.0000, 0.0000, 0.0000);
    CreateObject(3374, 1182.0706, -1969.3525, 73.3549, 0.0000, 0.0000, 0.0000);
    CreateObject(3374, 1172.2415, -1969.0858, 75.1492, 0.0000, 0.0000, 0.0000);
    CreateObject(3374, 1174.0562, -1968.2716, 78.1492, 0.0000, 0.0000, 0.0000);
    CreateObject(3374, 1177.8448, -1969.9935, 75.8474, 0.0000, 0.0000, 0.0000);
    CreateObject(3374, 1181.1425, -1969.7080, 76.3549, 0.0000, 0.0000, 0.0000);
    CreateObject(3374, 1177.3219, -1969.8081, 78.8474, 0.0000, 0.0000, 0.0000);
    CreateObject(3374, 1180.4795, -1970.0084, 79.3549, 0.0000, 0.0000, 0.0000);
    CreateObject(3374, 1174.0593, -1968.7617, 81.0740, 0.0000, 0.0000, 0.0000);
    CreateObject(3374, 1177.6565, -1968.2002, 82.1224, 0.0000, 0.0000, 0.0000);
    CreateObject(3374, 1180.2570, -1970.4985, 82.1091, 0.0000, 0.0000, 0.0000);
    CreateObject(1225, 1173.5956, -1969.1362, 80.7606, 0.0000, 0.0000, 0.0000);
    CreateObject(1225, 1176.7373, -1966.9557, 81.8090, 0.0000, 0.0000, 0.0000);
    CreateObject(1225, 1176.5123, -1969.7860, 80.7591, 0.0000, 0.0000, 0.0000);
    CreateObject(1225, 1177.5718, -1970.2982, 79.7733, 0.0000, 0.0000, 0.0000);
    CreateObject(1225, 1181.5474, -1969.8611, 72.2667, 0.0000, 0.0000, 0.0000);
    CreateObject(1225, 1174.8511, -1969.9512, 73.6689, 0.0000, 0.0000, 0.0000);
    CreateObject(3374, 1177.3016, -1969.8601, 81.8474, 0.0000, 0.0000, 0.0000);
    CreateObject(3524, 1174.1450, -2002.1777, 70.8932, 0.0000, 0.0000, 0.0000);
    CreateObject(3524, 1183.4926, -2002.0485, 70.8932, 0.0000, 0.0000, 0.0000);
    CreateObject(1318, 1234.3623, -2036.8888, 60.5297, 0.0000, 0.0000, 0.0000);
    CreateObject(1632, 1089.9730, -2037.0787, 81.9826, 0.0000, 0.0000, 90.0000);
    CreateObject(5001, 1824.5319, -2483.6890, 34.0725, 85.9437, 0.0000, 0.0000);
    CreateObject(1245, 1882.6494, -2484.5310, 57.3738, 0.0000, 85.9437, 180.0000);
    CreateObject(1634, 1898.3027, -2614.8655, 13.8442, 0.0000, 0.0000, 180.0000);
    CreateObject(1634, 1872.6991, -2663.5115, 24.5855, 0.0000, 0.0000, 90.0000);
    CreateObject(1634, 1807.6787, -2663.4131, 25.0492, 0.0000, 0.0000, 90.0000);
    CreateObject(1634, 1736.2583, -2664.7817, 24.2740, 0.0000, 0.0000, 90.0000);
    CreateObject(1634, 1665.1279, -2663.4214, 24.3766, 0.0000, 0.0000, 90.0000);
    CreateObject(3534, 1616.0773, -2670.7649, 26.7540, 0.0000, 0.0000, 0.0000);
    CreateObject(3534, 1616.3781, -2655.4539, 26.7650, 0.0000, 0.0000, 0.0000);
    CreateObject(1633, 1764.6343, -2584.1277, 13.8472, 0.0000, 28.6479, 281.2500);
    CreateObject(1633, 1764.6506, -2587.5737, 13.8472, 0.0000, 331.3521, 258.7500);
    CreateObject(1633, 1772.2770, -2584.3105, 15.5221, 0.0000, 28.6479, 281.2500);
    CreateObject(1633, 1772.3395, -2587.4746, 15.3721, 0.0000, 331.3521, 258.7500);
    CreateObject(1634, 2104.2036, -2420.1213, 13.8442, 0.0000, 0.0000, 0.0000);
    CreateObject(1634, 2104.1208, -2413.2104, 19.6865, 28.6479, 0.0000, 0.0000);
    CreateObject(1660, 2016.9575, -2502.3086, 12.0918, 0.0000, 0.0000, 270.0000);
    CreateObject(1660, 1963.1188, -2500.9983, 12.0340, 0.0000, 0.0000, 270.0000);
    CreateObject(1660, 1898.9875, -2501.8181, 12.1590, 0.0000, 0.0000, 270.0000);
    CreateObject(1660, 1838.8617, -2502.4829, 12.0246, 0.0000, 0.0000, 270.0000);
    CreateObject(1894, 1592.6948, -2608.1233, 12.5469, 0.0000, 0.0000, 180.0000);
    CreateObject(3665, 1913.4071, -2541.2622, 14.5285, 0.0000, 0.0000, 90.0000);
    CreateObject(16305, 2071.9763, -2544.5129, 17.6292, 0.0000, 0.0000, 33.7500);
    CreateObject(16367, 2060.9285, -2429.5498, 14.3058, 0.0000, 0.0000, 292.5000);
    CreateObject(18367, 1917.2322, -2396.2837, 23.9026, 28.6479, 0.0000, 0.0000);
    CreateObject(18367, 1917.2177, -2367.6431, 35.6644, 28.6479, 0.0000, 0.0000);
    CreateObject(18367, 1917.1550, -2338.9690, 47.4045, 28.6479, 0.0000, 0.0000);
    CreateObject(3270, 1493.6324, -2630.6074, 11.8318, 0.0000, 0.0000, 0.0000);
    CreateObject(1697, 1917.1815, -2339.1643, 48.0239, 0.0000, 0.0000, 180.0000);
    CreateObject(18367, 1917.1396, -2282.9583, 65.0452, 28.6479, 0.0000, 0.0000);
    CreateObject(1633, 1921.7422, -2178.3093, 27.7560, 17.1887, 0.0000, 0.0000);
    CreateObject(1503, 1929.5302, -2110.1055, 17.6334, 0.0000, 0.0000, 0.0000);
    CreateObject(3363, 1927.0320, -2084.9822, 18.9963, 0.0000, 0.0000, 180.0000);
    CreateObject(13590, 1614.2778, -2466.0747, 13.6056, 0.0000, 0.0000, 270.0000);
    CreateObject(3375, 1825.4196, -2584.8472, 17.1309, 0.0000, 0.0000, 0.0000);
    CreateObject(17672, 1432.5032, -2486.4050, 32.4013, 0.0000, 0.0000, 348.7500);
    CreateObject(1634, 1365.7859, -2483.4624, 50.9795, 0.0000, 0.0000, 78.7500);
    CreateObject(1634, 1366.6108, -2479.4705, 50.9562, 0.0000, 0.0000, 78.7500);
    CreateObject(1634, 1358.6019, -2482.0107, 56.5229, 22.9183, 0.0000, 78.7500);
    CreateObject(1634, 1359.4503, -2478.0950, 56.4638, 22.9183, 0.0000, 78.7500);
    CreateObject(1634, 1354.2623, -2481.1838, 64.1345, 45.8366, 0.0000, 78.7500);
    CreateObject(1634, 1355.1342, -2477.2405, 64.1767, 45.8366, 0.0000, 78.7500);
    CreateObject(1634, 1355.0050, -2477.2485, 73.3051, 80.2141, 0.0000, 78.7500);
    CreateObject(1634, 1354.2113, -2481.1638, 73.3173, 80.2141, 0.0000, 78.7500);
    CreateObject(1634, 1358.8503, -2482.0830, 80.6084, 114.5916, 0.0000, 78.7500);
    CreateObject(1634, 1359.7938, -2478.1147, 80.7500, 114.5916, 0.0000, 78.7500);
    CreateObject(5013, 1419.0880, -2491.4880, 69.6046, 0.0000, 0.0000, 78.7500);
    CreateObject(1631, 1451.6206, -2497.6372, 69.9538, 0.0000, 0.0000, 258.7500);
    CreateObject(13592, 1375.7577, -2491.9492, 26.6255, 0.0000, 0.0000, 191.2501);
    CreateObject(1633, 1364.2552, -2496.9995, 19.0800, 17.1887, 0.0000, 90.0000);
    CreateObject(1697, 1352.1743, -2620.9033, 14.1488, 0.0000, 0.0000, 123.7499);
    CreateObject(2931, 1754.4362, -2605.0525, 12.5803, 0.0000, 0.0000, 90.0000);
    CreateObject(2931, 1754.6942, -2602.5332, 12.5803, 0.0000, 0.0000, 90.0000);
    CreateObject(1638, 2018.2825, -2588.2427, 11.9280, 0.0000, 0.0000, 180.0000);
    CreateObject(1638, 2018.3331, -2591.7615, 11.9280, 0.0000, 0.0000, 180.0000);
    CreateObject(1638, 2018.3392, -2595.1426, 11.9530, 0.0000, 0.0000, 180.0000);
    CreateObject(1638, 2018.3757, -2598.6042, 11.9280, 0.0000, 0.0000, 180.0000);
    CreateObject(1638, 2018.3909, -2601.8491, 11.9280, 0.0000, 0.0000, 180.0000);
    CreateObject(8620, 1594.5160, -2584.2798, 15.0554, 0.0000, 0.0000, 270.0000);
    CreateObject(1633, 1553.4678, -2583.1497, 14.8972, 17.1887, 0.0000, 270.0000);
    CreateObject(3277, 1617.5699, -2546.4851, 12.1195, 0.0000, 0.0000, 78.7500);
    CreateObject(2780, 1615.7224, -2535.8081, 12.5469, 0.0000, 0.0000, 0.0000);
    CreateObject(2780, 1616.3752, -2557.0779, 12.5469, 0.0000, 0.0000, 213.7500);
    CreateObject(11480, -50.6457, -1144.7069, 2.2718, 0.0000, 0.0000, 337.5000);
    CreateObject(17036, -50.9070, -1145.8813, 0.0546, 0.0000, 0.0000, 247.5000);
    CreateObject(3797, -51.7015, -1144.7217, 0.6190, 0.0000, 0.0000, 326.2500);
    CreateObject(3797, -48.8195, -1146.5466, 0.6190, 0.0000, 0.0000, 236.2501);
    CreateObject(13607, -940.2047, -422.0641, 724.7858, 22.9183, 0.0000, 0.0000);
    CreateObject(13607, -940.2096, -274.4745, 724.6170, 22.9183, 0.0000, 0.0000);
    CreateObject(13607, -933.2991, -195.9200, 724.5236, 337.0817, 0.0000, 0.0000);
    CreateObject(3524, -944.4831, -340.3645, 722.6931, 0.0000, 0.0000, 157.5000);
    CreateObject(3524, -935.6334, -341.2267, 723.0576, 0.0000, 0.0000, 180.0000);
    CreateObject(1775, -961.1578, -396.4810, 732.8569, 22.9183, 0.0000, 11.2501);
    CreateObject(12912, -944.4845, -294.0069, 724.7618, 22.9183, 0.0000, 0.0001);
    CreateObject(1211, -918.9908, -291.7326, 714.0388, 22.9183, 0.0000, 0.0000);
    CreateObject(910, -933.6367, -316.7548, 711.1449, 337.0817, 0.0000, 0.0000);
    CreateObject(933, -917.2283, -259.5661, 727.0747, 22.9183, 0.0000, 0.0000);
    CreateObject(942, -934.6158, -250.4018, 733.3956, 22.9183, 0.0000, 0.0000);
    CreateObject(3594, -926.8256, -357.1220, 727.5314, 337.0817, 0.0000, 0.0000);
    CreateObject(3593, -937.2694, -411.9384, 725.9347, 22.9183, 0.0000, 0.0000);
    CreateObject(3393, -926.4287, -201.3584, 722.9784, 337.0817, 0.0000, 0.0000);
    CreateObject(3791, -929.4014, -164.6632, 707.9307, 337.0817, 0.0000, 0.0000);
    CreateObject(12950, -958.7000, -208.3496, 728.1177, 337.0817, 0.0000, 0.0000);
    CreateObject(12950, -958.8109, -198.5120, 723.9659, 22.9183, 0.0000, 180.0000);
    CreateObject(967, -899.8901, -189.0856, 717.7993, 22.9183, 0.0000, 180.0000);
    CreateObject(3243, -942.8899, -201.3814, 723.0254, 337.0817, 0.0000, 0.0000);
    CreateObject(3615, -965.7078, -340.0958, 721.8817, 337.0817, 0.0000, 0.0000);
    CreateObject(3615, -911.2427, -350.2522, 726.1758, 22.9183, 0.0000, 168.7500);
    CreateObject(14449, -945.3195, -445.2874, 712.3975, 22.9183, 0.0000, 0.0000);
    CreateObject(14780, -928.7122, -433.4899, 716.9871, 22.9183, 0.0000, 0.0000);
    CreateObject(17699, -968.7026, -418.6602, 727.0215, 22.9183, 0.0000, 0.0000);
    CreateObject(1454, -914.6640, -281.5523, 718.5804, 337.0817, 0.0000, 191.2500);
    CreateObject(1457, -961.1641, -260.0746, 728.5298, 22.9183, 0.0000, 0.0000);
    CreateObject(12918, -922.1334, -219.0002, 730.4321, 337.0817, 0.0000, 0.0000);
    CreateObject(13367, -949.1772, -364.0083, 741.8056, 337.0817, 0.0000, 0.0000);
    CreateObject(1451, -920.0223, -180.7728, 715.1047, 337.0817, 0.0000, 0.0000);
    CreateObject(3374, -944.8583, -397.0057, 733.0320, 22.9183, 0.0000, 0.0000);
    CreateObject(3374, -917.0029, -413.6610, 726.0067, 22.9183, 0.0000, 0.0000);
    CreateObject(3374, -940.3746, -423.6765, 721.6470, 22.9183, 0.0000, 0.0000);
    CreateObject(3374, -960.9265, -432.3737, 718.1026, 22.9183, 0.0000, 0.0000);
    CreateObject(1225, -914.9922, -269.7014, 723.1984, 22.9183, 0.0000, 0.0000);
    CreateObject(1225, -939.6805, -266.4178, 724.6031, 22.9183, 0.0000, 0.0000);
    CreateObject(1225, -963.7328, -275.6183, 720.7383, 22.9183, 0.0000, 0.0000);
    CreateObject(1225, -953.9455, -285.1409, 716.6621, 22.9183, 0.0000, 0.0000);
    CreateObject(16304, -684.9307, 1887.6309, -37.3946, 0.0000, 0.0000, 0.0000);
    CreateObject(16305, -694.9732, 1843.3174, -38.8816, 0.0000, 0.0000, 0.0000);
    CreateObject(16303, -727.2396, 1796.4677, -46.7998, 0.0000, 0.0000, 292.5000);
    CreateObject(13647, -698.9519, 1763.6294, -44.3382, 0.0000, 0.0000, 281.2500);
    CreateObject(13641, -625.7578, 1646.1183, -29.7583, 0.0000, 0.0000, 315.0000);
    CreateObject(13636, -755.0145, 1885.6871, -35.4414, 0.0000, 0.0000, 180.0000);
    CreateObject(12956, -558.2822, 1461.7893, -29.5748, 0.0000, 0.0000, 270.0000);
    CreateObject(3852, -579.2058, 1548.5452, -25.7307, 0.0000, 0.0000, 22.5000);
    CreateObject(3364, -567.1984, 1556.0790, -29.8540, 0.0000, 0.0000, 112.5000);
    CreateObject(3269, -545.6802, 1364.9578, -33.7178, 0.0000, 0.0000, 225.0000);
    CreateObject(1632, -581.0882, 1366.3785, -29.3831, 0.0000, 0.0000, 202.5000);
    CreateObject(3364, 205.2216, 2527.8484, 15.9540, 0.0000, 0.0000, 0.0000);
    CreateObject(3364, 205.1358, 2517.0991, 15.8130, 0.0000, 0.0000, 180.0000);
    CreateObject(931, 96.5655, 1920.4856, 18.2055, 0.0000, 0.0000, 270.0000);
    CreateObject(925, 96.9866, 1920.4283, 20.2132, 0.0000, 0.0000, 270.0000);
    CreateObject(1225, 1243.4500, 2788.6692, 10.2261, 0.0000, 0.0000, 0.0000);
    CreateObject(1225, 1317.7542, 2840.5298, 10.2261, 0.0000, 0.0000, 0.0000);
    CreateObject(1225, 1272.1631, 2831.3286, 10.2261, 0.0000, 0.0000, 0.0000);
    CreateObject(1225, 1310.2877, 2798.1128, 10.2288, 0.0000, 0.0000, 0.0000);
    CreateObject(1225, 1300.1671, 2768.1755, 10.2183, 0.0000, 0.0000, 0.0000);
    CreateObject(1225, 1201.0560, 2744.0576, 10.2339, 0.0000, 0.0000, 0.0000);
    CreateObject(1225, 1155.5342, 2789.7229, 10.2261, 0.0000, 0.0000, 0.0000);
    CreateObject(1225, 1223.2668, 2809.0457, 10.2261, 0.0000, 0.0000, 0.0000);
    CreateObject(1225, 1182.3728, 2841.2180, 10.2261, 0.0000, 0.0000, 0.0000);
    CreateObject(1225, 1150.8577, 2742.7039, 10.2339, 0.0000, 0.0000, 0.0000);
    CreateObject(1225, 1161.6089, 2748.9204, 10.2339, 0.0000, 0.0000, 0.0000);
    CreateObject(1225, 1165.3912, 2746.4497, 10.2339, 0.0000, 0.0000, 0.0000);
    CreateObject(1225, 1179.2977, 2768.4429, 10.2261, 0.0000, 0.0000, 0.0000);
    CreateObject(1225, 1142.2639, 2766.1326, 10.2183, 0.0000, 0.0000, 0.0000);
    CreateObject(1225, 1131.7615, 2756.7104, 10.2261, 0.0000, 0.0000, 0.0000);
    CreateObject(1225, 1197.5381, 2791.3311, 10.2261, 0.0000, 0.0000, 0.0000);
    CreateObject(1225, 1277.8650, 2767.8259, 10.2261, 0.0000, 0.0000, 0.0000);
    CreateObject(1225, 1310.9562, 2738.3013, 10.2183, 0.0000, 0.0000, 0.0000);
    CreateObject(1225, 1258.0155, 2755.8630, 10.2261, 0.0000, 0.0000, 0.0000);
    CreateObject(1225, 1274.5687, 2778.7876, 10.2261, 0.0000, 0.0000, 0.0000);
    CreateObject(1225, 1292.8329, 2812.3613, 10.2261, 0.0000, 0.0000, 0.0000);
    CreateObject(1225, 1341.4879, 2766.1946, 9.1856, 0.0000, 0.0000, 0.0000);
    CreateObject(1225, 1340.0941, 2782.4875, 9.6260, 0.0000, 0.0000, 0.0000);
    CreateObject(1225, 1356.3003, 2734.4453, 10.2261, 0.0000, 0.0000, 0.0000);
    CreateObject(1225, 1325.6445, 2760.0542, 10.2261, 0.0000, 0.0000, 0.0000);
    CreateObject(1225, 1367.6058, 2794.1667, 10.2261, 0.0000, 0.0000, 0.0000);
    CreateObject(1225, 1385.5469, 2827.7966, 10.2261, 0.0000, 0.0000, 0.0000);
    CreateObject(1225, 1339.5591, 2816.1680, 10.2184, 0.0000, 0.0000, 0.0000);
    CreateObject(1225, 1407.0593, 2753.1819, 10.2261, 0.0000, 0.0000, 0.0000);
    CreateObject(1225, 1398.0321, 2808.0671, 10.2261, 0.0000, 0.0000, 0.0000);
    CreateObject(1225, 1407.1223, 2810.7446, 10.2261, 0.0000, 0.0000, 0.0000);
    CreateObject(1225, 1397.1434, 2788.9900, 10.2261, 0.0000, 0.0000, 0.0000);
    CreateObject(1225, 1388.7670, 2801.5234, 10.2261, 0.0000, 0.0000, 0.0000);
    CreateObject(1225, 1384.2407, 2787.2771, 10.3745, 0.0000, 0.0000, 0.0000);
    CreateObject(1225, 1318.7367, 2830.1245, 10.2261, 0.0000, 0.0000, 0.0000);
    CreateObject(1423, -963.5195, -416.9332, 724.0292, 0.0000, 0.0000, 281.2500);
    CreateObject(1423, -963.5672, -417.0100, 725.2864, 0.0000, 0.0000, 281.2500);
    CreateObject(10841, 1228.9423, -154.6038, 5.7471, 0.0000, 0.0000, 33.7500);
    CreateObject(1655, 1258.8286, -183.7672, 0.8933, 0.0000, 0.0000, 45.0000);
    CreateObject(10841, 962.3497, -120.7481, 6.2132, 0.0000, 0.0000, 90.0000);
    CreateObject(1655, 1001.8668, -114.3346, 0.9266, 0.0000, 0.0000, 101.2500);
    CreateObject(1655, 526.9843, -247.1261, 0.8492, 0.0000, 0.0000, 101.2500);
    CreateObject(10841, 802.4089, -164.9476, 4.5716, 0.0000, 0.0000, 135.0000);
    CreateObject(10828, 2126.8577, 121.1817, 9.5375, 0.0000, 0.0000, 157.5000);
    CreateObject(1655, 2113.3098, 84.5319, 0.9706, 0.0000, 0.0000, 337.5000);
    CreateObject(1225, 2125.8955, 120.8346, 12.5899, 0.0000, 0.0000, 0.0000);
    CreateObject(1225, 2133.2295, 118.3962, 12.5899, 0.0000, 0.0000, 0.0000);
    CreateObject(1225, 2119.5840, 124.0157, 12.5899, 0.0000, 0.0000, 0.0000);
    CreateObject(1225, 2113.6011, 125.8557, 12.5899, 0.0000, 0.0000, 0.0000);
    CreateObject(1225, 2128.9661, 120.1263, 12.5899, 0.0000, 0.0000, 0.0000);
    CreateObject(1225, 2119.6321, 124.2595, 13.7126, 0.0000, 0.0000, 0.0000);
    CreateObject(1225, 2128.8826, 120.2330, 13.7705, 0.0000, 0.0000, 0.0000);
    CreateObject(1225, 2133.0266, 118.4001, 13.7387, 0.0000, 0.0000, 0.0000);
    CreateObject(1225, 2125.8584, 121.0775, 13.7138, 0.0000, 0.0000, 0.0000);
    CreateObject(1225, 2113.6423, 125.9086, 13.7886, 0.0000, 0.0000, 0.0000);
    CreateObject(1655, 58.0349, -1486.9332, 0.8902, 0.0000, 0.0000, 168.7500);
    CreateObject(1225, 53.9666, -1294.7538, 0.0887, 0.0000, 0.0000, 0.0000);
    CreateObject(1225, 18.7095, -1307.0371, 0.0394, 0.0000, 0.0000, 0.0000);
    CreateObject(1225, 33.4488, -1330.9200, -0.0528, 0.0000, 0.0000, 0.0000);
    CreateObject(1225, 45.6159, -1544.1487, 12.2995, 0.0000, 0.0000, 0.0000);
    CreateObject(1225, 54.5495, -1545.1683, 12.2995, 0.0000, 0.0000, 0.0000);
    CreateObject(1655, 2144.6599, 157.3223, 0.8898, 0.0000, 0.0000, 157.5000);
    CreateObject(1225, 43.6923, -510.3034, -0.0180, 0.0000, 0.0000, 0.0000);
    CreateObject(3524, 2119.8730, 84.8579, 2.4826, 0.0000, 0.0000, 326.2500);
    CreateObject(3524, 2137.8774, 156.6034, 2.3184, 0.0000, 0.0000, 146.2500);
    CreateObject(3524, 51.9710, -1488.4781, 2.3363, 0.0000, 0.0000, 157.5000);
    CreateObject(979, -68.2297, -586.8911, 0.8241, 0.0000, 0.0000, 247.5000);
    CreateObject(979, -76.1215, -605.0740, 0.8828, 0.0000, 0.0000, 247.5000);
    CreateObject(979, -83.0174, -622.9438, 0.8386, 0.0000, 0.0000, 247.5000);
    CreateObject(979, -91.5573, -643.0552, 0.8059, 0.0000, 0.0000, 247.5000);
    CreateObject(979, -100.0475, -663.0715, 0.8419, 0.0000, 0.0000, 247.5000);
    CreateObject(979, -108.6309, -682.9288, 0.8512, 0.0000, 0.0000, 247.5000);
    CreateObject(979, -117.4759, -704.4117, 0.8430, 0.0000, 0.0000, 247.5000);
    CreateObject(979, -126.0764, -724.8768, 0.8319, 0.0000, 0.0000, 247.5000);
    CreateObject(1225, -125.9803, -845.1270, 0.0494, 0.0000, 0.0000, 0.0000);
    CreateObject(1225, 9.1100, -920.4623, 0.0742, 0.0000, 0.0000, 0.0000);
    CreateObject(1225, 73.1702, -1005.3965, 0.0082, 0.0000, 0.0000, 0.0000);
    CreateObject(1225, 81.8420, -1176.4707, 0.0453, 0.0000, 0.0000, 0.0000);
    CreateObject(1225, 48.7761, -535.6159, 0.0007, 0.0000, 0.0000, 0.0000);
    CreateObject(1225, 71.6492, -1300.0566, 0.0979, 0.0000, 0.0000, 0.0000);
    CreateObject(1225, 94.8125, -1203.5060, 0.1640, 0.0000, 0.0000, 0.0000);
    CreateObject(1225, 1873.7880, -72.9707, 0.1125, 0.0000, 0.0000, 0.0000);
    CreateObject(1225, 1880.8337, -47.8104, 0.0497, 0.0000, 0.0000, 0.0000);
    CreateObject(1225, 1644.1348, -17.9913, 0.0594, 0.0000, 0.0000, 0.0000);
    CreateObject(1696, 2386.3179, 549.6896, 7.7885, 0.0000, 0.0000, 180.0000);
    CreateObject(1696, 2386.3162, 545.9304, 9.1066, 0.0000, 0.0000, 180.0000);
    CreateObject(1696, 2386.5378, 543.5523, 9.9610, 0.0000, 0.0000, 180.0000);
    CreateObject(1696, 2386.5051, 541.1611, 10.7686, 0.0000, 0.0000, 180.0000);
    CreateObject(1696, 2386.3801, 538.7698, 11.6525, 0.0000, 0.0000, 180.0000);
    CreateObject(1696, 2386.4089, 536.3786, 12.5318, 0.0000, 0.0000, 180.0000);
    CreateObject(8040, 2389.4241, 451.2310, 0.7997, 0.0000, 0.0000, 180.0000);
    CreateObject(1696, 2386.2954, 533.9874, 13.4040, 0.0000, 0.0000, 180.0000);
    CreateObject(1243, 31.9019, -1567.0199, -3.0770, 0.0000, 0.0000, 0.0000);
    CreateObject(1243, 60.9512, -1569.9590, -3.0578, 0.0000, 0.0000, 0.0000);
    CreateObject(1696, 2386.5740, 550.1867, 7.7885, 0.0000, 0.0000, 180.0000);
    CreateObject(11495, 2339.8950, 448.2769, -0.1666, 0.0000, 0.0000, 269.9999);
    CreateObject(11495, 2281.2739, 444.3907, -0.0950, 0.0000, 0.0000, 269.9999);
    CreateObject(9767, 2356.4380, 506.0392, 10.5172, 0.0000, 0.0000, 0.0000);
    CreateObject(9767, 2350.8137, 579.0703, 10.5250, 0.0000, 0.0000, 180.0000);
    CreateObject(11495, 2271.1689, 454.4996, -0.1269, 0.0000, 0.0000, 180.0000);
    CreateObject(11495, 2271.1782, 475.0466, -0.1428, 0.0000, 0.0000, 180.0000);
    CreateObject(2931, 2271.3069, 485.5133, 0.0938, 0.0000, 0.0000, 0.0000);
    CreateObject(2931, 2271.3035, 488.7585, 2.0295, 0.0000, 0.0000, 0.0000);
    CreateObject(9766, 2272.1890, 525.8649, 6.8899, 0.0000, 0.0000, 0.0000);
    CreateObject(13666, 2326.5210, 446.5072, 4.9401, 0.0000, 0.0000, 281.2500);
    CreateObject(1632, 2318.7578, 443.9410, 1.0821, 0.0000, 0.0000, 90.0000);
    CreateObject(13666, 2352.5593, 449.7997, 4.9970, 0.0000, 0.0000, 90.0000);
    CreateObject(14791, 1325.4558, 1181.5697, 1227.9867, 0.0000, 0.0000, 0.0000);
    CreateObject(3260, 2007.0015, -129.5134, 0.9986, 17.1887, 0.0000, 89.9544);
    CreateObject(3260, 2007.0343, -127.8962, 0.9506, 17.1887, 0.0000, 89.9544);
    CreateObject(3260, 2006.9760, -131.5262, 0.9764, 17.1887, 0.0000, 89.9544);
    CreateObject(3260, 2006.9183, -133.5034, 1.0048, 17.1887, 0.0000, 89.9544);
    CreateObject(3260, 2006.9680, -135.4596, 1.0023, 17.1887, 0.0000, 89.9544);
    CreateObject(3260, 2006.9224, -137.4072, 1.0242, 17.1887, 0.0000, 89.9544);
    CreateObject(3260, 2006.9066, -139.4021, 0.9951, 17.1887, 0.0000, 89.9544);
    CreateObject(3260, 2006.9595, -141.3244, 0.9839, 17.1887, 0.0000, 89.9544);
    CreateObject(3260, 2006.9630, -143.3026, 1.0143, 17.1887, 0.0000, 89.9544);
    CreateObject(3260, 2006.9214, -145.2437, 0.9887, 17.1887, 0.0000, 89.9544);
    CreateObject(3260, 2006.8827, -147.1976, 0.9900, 17.1887, 0.0000, 89.9544);
    CreateObject(3260, 2006.8799, -149.1141, 1.0039, 17.1887, 0.0000, 89.9544);
    CreateObject(3260, 2006.8553, -151.0917, 0.9633, 17.1887, 0.0000, 89.9544);
    CreateObject(3260, 2006.9077, -153.0163, 0.9982, 17.1887, 0.0000, 89.9544);
    CreateObject(3260, 2006.9301, -155.0382, 1.0123, 17.1887, 0.0000, 89.9544);
    CreateObject(3260, 2006.7075, -156.3937, 1.0129, 17.1887, 0.0000, 78.7044);
    CreateObject(3260, 2006.1072, -158.3993, 0.9637, 17.1887, 0.0000, 67.4544);
    CreateObject(3260, 2005.1415, -160.1438, 0.9825, 17.1887, 0.0000, 56.2044);
    CreateObject(3260, 2004.1293, -161.6592, 1.0010, 17.1887, 0.0000, 56.2044);
    CreateObject(3260, 2003.1019, -163.3194, 1.0072, 17.1887, 0.0000, 56.2044);
    CreateObject(3260, 2002.0643, -164.8065, 0.9946, 17.1887, 0.0000, 56.2044);
    CreateObject(3260, 2001.0386, -166.3241, 1.0081, 17.1887, 0.0000, 56.2044);
    CreateObject(3260, 2006.5195, -157.3106, 0.9561, 17.1887, 0.0000, 67.4544);
    CreateObject(3260, 2005.5136, -149.6980, 1.0075, 0.0000, 0.0000, 0.0000);
    CreateObject(3260, 2003.5199, -149.6537, 0.9637, 0.0000, 0.0000, 0.0000);
    CreateObject(3260, 2001.4940, -149.6539, 0.9971, 0.0000, 0.0000, 0.0000);
    CreateObject(3260, 1999.4709, -149.6833, 0.9438, 0.0000, 0.0000, 0.0000);
    CreateObject(3260, 1997.4921, -149.6197, 1.0135, 0.0000, 0.0000, 0.0000);
    CreateObject(3260, 1995.4561, -149.6224, 1.0326, 0.0000, 0.0000, 0.0000);
    CreateObject(3260, 1993.4731, -149.5130, 1.0030, 0.0000, 0.0000, 0.0000);
    CreateObject(3260, 1991.5033, -149.5128, 0.9887, 0.0000, 0.0000, 0.0000);
    CreateObject(3260, 1990.1329, -150.0979, 0.9766, 17.1887, 0.0000, 269.9544);
    CreateObject(3260, 1990.1536, -152.0917, 0.9963, 17.1887, 0.0000, 269.9544);
    CreateObject(3260, 1990.1547, -156.0630, 1.0302, 17.1887, 0.0000, 269.9544);
    CreateObject(3260, 1990.2247, -154.1619, 0.9787, 17.1887, 0.0000, 269.9544);
    CreateObject(3260, 1990.2826, -157.7469, 0.9734, 17.1887, 0.0000, 281.2044);
    CreateObject(3260, 1990.8315, -159.4241, 0.9511, 17.1887, 0.0000, 292.4544);
    CreateObject(3260, 1991.6465, -161.1016, 1.0043, 17.1887, 0.0000, 303.7044);
    CreateObject(3260, 1992.6404, -162.5487, 1.0040, 17.1887, 0.0000, 303.7044);
    CreateObject(3260, 1993.6354, -163.9919, 1.0078, 17.1887, 0.0000, 303.7044);
    CreateObject(3260, 1994.7428, -165.4824, 0.9664, 17.1887, 0.0000, 303.7044);
    CreateObject(3260, 1995.7231, -166.9869, 0.9867, 17.1887, 0.0000, 303.7044);
    CreateObject(3260, 2000.0662, -167.8223, 0.9966, 17.1887, 0.0000, 56.2044);
    CreateObject(3260, 1999.1094, -169.1989, 1.0195, 17.1887, 0.0000, 56.2044);
    CreateObject(3260, 1996.5568, -168.3805, 1.0008, 17.1887, 0.0000, 303.7044);
    CreateObject(3260, 1997.0190, -169.1592, 0.9682, 17.1887, 0.0000, 303.7044);
    CreateObject(3260, 1998.7528, -169.6194, 0.9991, 17.1887, 0.0000, 56.2044);
    CreateObject(3260, 1997.2153, -169.5410, 1.0017, 17.1887, 0.0000, 303.7044);
    CreateObject(3260, 1997.4124, -169.6307, 0.9633, 17.1887, 22.9183, 303.8501);
    CreateObject(3260, 1998.5546, -169.6486, 0.9880, 17.1887, 337.0817, 56.2500);
    CreateObject(3260, 1990.1801, -148.1031, 0.9871, 17.1887, 0.0000, 269.9544);
    CreateObject(3260, 1990.1641, -146.1688, 1.0028, 17.1887, 0.0000, 269.9544);
    CreateObject(3260, 1990.1653, -144.1794, 0.9847, 17.1887, 0.0000, 269.9544);
    CreateObject(3260, 1990.1805, -142.2054, 0.9584, 17.1887, 0.0000, 269.9544);
    CreateObject(3260, 1990.0963, -140.2839, 1.0031, 17.1887, 0.0000, 269.9544);
    CreateObject(3260, 1990.1277, -138.3737, 1.0033, 17.1887, 0.0000, 269.9544);
    CreateObject(3260, 1990.1189, -136.3454, 1.0191, 17.1887, 0.0000, 269.9544);
    CreateObject(3260, 1990.1646, -134.4561, 1.0229, 17.1887, 0.0000, 269.9544);
    CreateObject(3260, 1990.2703, -132.5559, 0.9599, 17.1887, 0.0000, 269.9544);
    CreateObject(3260, 1990.2252, -130.6322, 0.9864, 17.1887, 0.0000, 269.9544);
    CreateObject(3260, 1990.1866, -128.7236, 1.0171, 17.1887, 0.0000, 269.9544);
    CreateObject(3260, 1990.1799, -127.7652, 1.0123, 17.1887, 0.0000, 269.9544);
    CreateObject(3260, 1991.4781, -126.5107, 0.9531, 17.1887, 0.0000, 179.9544);
    CreateObject(3260, 1993.3739, -126.5505, 0.9641, 17.1887, 0.0000, 179.9544);
    CreateObject(3260, 1995.3108, -126.6289, 0.9479, 17.1887, 0.0000, 179.9544);
    CreateObject(3260, 1997.1201, -126.5960, 0.9947, 17.1887, 0.0000, 179.9544);
    CreateObject(3260, 2000.8046, -126.6310, 0.9606, 17.1887, 0.0000, 179.9544);
    CreateObject(3260, 2002.8224, -126.5844, 1.0112, 17.1887, 0.0000, 179.9544);
    CreateObject(3260, 2004.8160, -126.5596, 0.9970, 17.1887, 0.0000, 179.9544);
    CreateObject(3260, 2005.7754, -126.5472, 1.0084, 17.1887, 0.0000, 179.9544);
    CreateObject(3260, 2006.8208, -127.5345, 1.1017, 17.1887, 22.9183, 78.8501);
    CreateObject(3260, 2006.0138, -126.7942, 1.1277, 17.1887, 337.0817, 191.2500);
    CreateObject(3260, 1990.3278, -127.3996, 1.3776, 17.1887, 337.0817, 281.2500);
    CreateObject(3260, 1991.2157, -126.6382, 1.3824, 17.1887, 22.9183, 168.8501);
    CreateObject(3260, 1998.9465, -128.7206, 0.2578, 269.2902, 0.0000, 0.0000);
	CreateObject(3260, 1997.9750, -127.6802, 1.2816, 0.0000, 17.1887, 90.0000);
    CreateObject(3260, 1999.8636, -127.5184, 1.2796, 0.0000, 342.8113, 270.0000);
    CreateObject(3260, 1999.8671, -128.7617, 1.2950, 0.0000, 0.0000, 270.0000);
    CreateObject(3260, 1998.0006, -128.7979, 1.2954, 0.0000, 0.0000, 90.0001);
    CreateObject(3260, 1998.9199, -131.6797, 0.7151, 257.8310, 0.0000, 0.0000);
	CreateObject(3260, 1999.0221, -134.6237, 0.9444, 269.2902, 0.0000, 0.0000);
    CreateObject(3260, 1999.8369, -130.6246, 1.2193, 0.0000, 0.0000, 270.0000);
    CreateObject(3260, 1998.0088, -130.7923, 1.2600, 0.0000, 0.0000, 90.0001);
    CreateObject(3260, 1998.0476, -132.7258, 1.2847, 0.0000, 0.0000, 90.0001);
    CreateObject(3260, 1999.8105, -132.6221, 1.3585, 0.0000, 0.0000, 270.0001);
    CreateObject(3260, 1999.4093, -125.7323, 0.2138, 269.2902, 0.0000, 90.0000);
    CreateObject(3260, 2000.9828, -135.9474, 0.9824, 269.2902, 0.0000, 0.0000);
    CreateObject(3260, 2000.9249, -131.6929, 0.9656, 269.2902, 0.0000, 0.0000);
    CreateObject(3260, 2000.9393, -128.6540, 0.9456, 269.2902, 0.0000, 0.0000);
    CreateObject(3260, 2002.9299, -135.9350, 0.9949, 269.2902, 0.0000, 0.0000);
    CreateObject(3260, 2002.8718, -131.6821, 0.9690, 269.2902, 0.0000, 0.0000);
    CreateObject(3260, 2002.9135, -128.6811, 0.9669, 269.2902, 0.0000, 0.0000);
    CreateObject(3260, 2004.8684, -128.7165, 0.9866, 269.2902, 0.0000, 0.0000);
    CreateObject(3260, 2005.8740, -128.7362, 0.9698, 269.2902, 0.0000, 0.0000);
    CreateObject(3260, 2004.8552, -131.6896, 0.9882, 269.2902, 0.0000, 0.0000);
    CreateObject(3260, 2005.8854, -131.6875, 0.9880, 269.2902, 0.0000, 0.0000);
    CreateObject(3260, 2004.7496, -135.9542, 1.0025, 269.2902, 0.0000, 0.0000);
    CreateObject(3260, 2005.9197, -135.9600, 1.0088, 269.2902, 0.0000, 0.0000);
    CreateObject(3260, 1999.6929, -148.7844, 2.9575, 269.2902, 0.0000, 0.0000);
    CreateObject(3260, 1997.6659, -148.8091, 2.9762, 269.2902, 0.0000, 0.0000);
    CreateObject(3260, 2006.4174, -148.7015, 0.9841, 0.0000, 0.0000, 90.0000);
    CreateObject(3260, 2006.5021, -146.8109, 0.9590, 0.0000, 0.0000, 90.0000);
    CreateObject(3260, 2006.4919, -144.8859, 0.9778, 0.0000, 0.0000, 90.0000);
	CreateObject(3260, 2006.5410, -142.9681, 1.0077, 0.0000, 0.0000, 90.0000);
	CreateObject(3260, 2006.4323, -140.9690, 0.9489, 0.0000, 0.0000, 90.0000);
	CreateObject(3260, 2001.6456, -148.7484, 2.9721, 269.2902, 0.0000, 0.0000);
	CreateObject(3260, 2003.5721, -148.7524, 2.9835, 269.2902, 0.0000, 0.0000);
	CreateObject(3260, 2005.3972, -139.9715, 0.9664, 0.0000, 0.0000, 180.0000);
	CreateObject(3260, 2003.5378, -140.0373, 0.9654, 0.0000, 0.0000, 180.0000);
	CreateObject(3260, 2001.6145, -139.9917, 0.9756, 0.0000, 0.0000, 180.0000);
	CreateObject(3260, 1999.6858, -139.9397, 1.0219, 0.0000, 0.0000, 180.0000);
	CreateObject(3260, 1997.6975, -139.9651, 1.0058, 0.0000, 0.0000, 180.0000);
	CreateObject(3260, 1995.8446, -139.9459, 1.0122, 0.0000, 0.0000, 180.0000);
	CreateObject(3260, 1993.9303, -139.9339, 0.9771, 0.0000, 0.0000, 180.0000);
	CreateObject(3260, 1991.9999, -139.9893, 0.9800, 0.0000, 0.0000, 180.0000);
	CreateObject(3260, 1990.4680, -140.9636, 0.9606, 0.0000, 0.0000, 270.0000);
	CreateObject(3260, 1990.5054, -142.9534, 1.0398, 0.0000, 0.0000, 270.0000);
	CreateObject(3260, 1990.4998, -144.8666, 1.0600, 0.0000, 0.0000, 270.0000);
	CreateObject(3260, 1990.4935, -146.6112, 1.0951, 0.0000, 0.0000, 270.0000);
	CreateObject(3260, 1990.5563, -148.5223, 1.0154, 0.0000, 0.0000, 270.0000);
	CreateObject(3260, 1991.4081, -140.0048, 0.9592, 0.0000, 0.0000, 180.0000);
	CreateObject(3260, 1995.6907, -148.7732, 2.9983, 269.2902, 0.0000, 0.0000);
	CreateObject(3260, 2005.5297, -148.7922, 3.0242, 269.2902, 0.0000, 0.0000);
	CreateObject(3260, 2005.9078, -138.9457, 1.0586, 269.2902, 0.0000, 0.0000);
	CreateObject(3260, 2003.8787, -138.9061, 1.0500, 269.2902, 0.0000, 0.0000);
	CreateObject(3260, 2001.8525, -138.8998, 1.0243, 269.2902, 0.0000, 0.0000);
	CreateObject(3260, 1999.9014, -138.8890, 0.9922, 269.2902, 0.0000, 0.0000);
	CreateObject(3260, 1997.8918, -138.9140, 0.9764, 269.2902, 0.0000, 0.0000);
	CreateObject(3260, 1997.0646, -135.9479, 0.9564, 269.2902, 0.0000, 0.0000);
	CreateObject(3260, 1995.9252, -138.9018, 1.0247, 269.2902, 0.0000, 0.0000);
	CreateObject(3260, 1995.0680, -135.9682, 0.9895, 269.2902, 0.0000, 0.0000);
	CreateObject(3260, 1993.9496, -138.9139, 0.9812, 269.2902, 0.0000, 0.0000);
	CreateObject(3260, 1993.0995, -135.9929, 0.9861, 269.2902, 0.0000, 0.0000);
	CreateObject(3260, 1991.9716, -138.8890, 0.9874, 269.2902, 0.0000, 0.0000);
	CreateObject(3260, 1997.0494, -132.9642, 0.9300, 269.2902, 0.0000, 0.0000);
	CreateObject(3260, 1995.0265, -133.0058, 0.9802, 269.2902, 0.0000, 0.0000);
	CreateObject(3260, 1993.1018, -133.0554, 0.9547, 269.2902, 0.0000, 0.0000);
	CreateObject(3260, 1991.2616, -135.9766, 0.9486, 269.2902, 0.0000, 0.0000);
	CreateObject(3260, 1991.2418, -138.8935, 1.0108, 269.2902, 0.0000, 0.0000);
	CreateObject(3260, 1999.0404, -135.9732, 0.9539, 269.2902, 0.0000, 0.0000);
	CreateObject(3260, 2005.9052, -133.2776, 0.9882, 269.2902, 0.0000, 0.0000);
	CreateObject(3260, 2004.0951, -133.2930, 1.0153, 269.2902, 0.0000, 0.0000);
	CreateObject(3260, 2002.1866, -133.2447, 0.9639, 269.2902, 0.0000, 0.0000);
	CreateObject(3260, 2000.7115, -133.2395, 0.9835, 269.2902, 0.0000, 0.0000);
	CreateObject(3260, 1991.2455, -133.0824, 0.9819, 269.2902, 0.0000, 0.0000);
	CreateObject(3260, 1997.0179, -130.0711, 1.0207, 269.2902, 0.0000, 0.0000);
	CreateObject(3260, 1995.2085, -130.1042, 0.9587, 269.2902, 0.0000, 0.0000);
	CreateObject(3260, 1993.3894, -130.0995, 0.9957, 269.2902, 0.0000, 0.0000);
	CreateObject(3260, 1991.3413, -130.0834, 0.9997, 269.2902, 0.0000, 0.0000);
	CreateObject(3260, 1997.0046, -128.6426, 1.0163, 269.2902, 0.0000, 0.0000);
	CreateObject(3260, 1995.1484, -128.6559, 1.0131, 269.2902, 0.0000, 0.0000);
	CreateObject(3260, 1993.3709, -128.6262, 0.9989, 269.2902, 0.0000, 359.1406);
	CreateObject(3260, 1991.4044, -128.6092, 1.0062, 269.2902, 0.0000, 359.1406);
	CreateObject(3851, 2691.6477, -2406.7185, 985.6797, 0.0000, 91.6724, 0.0000);
	CreateObject(3851, 2695.6213, -2406.7249, 985.5651, 0.0000, 91.6724, 0.0000);
	CreateObject(3851, 2699.5054, -2406.7104, 985.4659, 0.0000, 91.6724, 0.0000);
	CreateObject(3851, 2691.6511, -2417.9324, 985.7002, 0.0000, 91.6724, 359.9992);
	CreateObject(3851, 2695.5945, -2417.9272, 985.5878, 0.0000, 91.6724, 359.9992);
	CreateObject(3851, 2699.5054, -2417.9229, 985.4591, 0.0000, 91.6724, 359.9992);
	CreateObject(3851, 2687.7034, -2417.9272, 985.8086, 0.0000, 91.6724, 359.9992);
	CreateObject(3851, 2687.7053, -2406.7241, 985.7909, 0.0000, 91.6724, 0.0000);
	CreateObject(3851, 2683.8022, -2406.7417, 985.9199, 0.0000, 91.6724, 0.0000);
	CreateObject(3851, 2683.8169, -2417.9900, 985.8997, 0.0000, 91.6724, 359.9992);
	CreateObject(3851, 2691.6477, -2406.7185, 975.6797, 0.0000, 91.6724, 0.0000);
	CreateObject(3851, 2695.6213, -2406.7249, 975.5651, 0.0000, 91.6724, 0.0000);
	CreateObject(3851, 2699.5054, -2406.7104, 975.4659, 0.0000, 91.6724, 0.0000);
	CreateObject(3851, 2691.6511, -2417.9324, 975.7002, 0.0000, 91.6724, 359.9992);
	CreateObject(3851, 2695.5945, -2417.9272, 975.5878, 0.0000, 91.6724, 359.9992);
	CreateObject(3851, 2699.5054, -2417.9229, 975.4591, 0.0000, 91.6724, 359.9992);
	CreateObject(3851, 2687.7034, -2417.9272, 975.8086, 0.0000, 91.6724, 359.9992);
	CreateObject(3851, 2687.7053, -2406.7241, 975.7909, 0.0000, 91.6724, 0.0000);
	CreateObject(3851, 2683.8022, -2406.7417, 975.9199, 0.0000, 91.6724, 0.0000);
	CreateObject(3851, 2683.8169, -2417.9900, 975.8997, 0.0000, 91.6724, 359.9992);
	CreateObject(3851, 2691.6477, -2406.7185, 965.6797, 0.0000, 91.6724, 0.0000);
	CreateObject(3851, 2695.6213, -2406.7249, 965.5651, 0.0000, 91.6724, 0.0000);
	CreateObject(3851, 2699.5054, -2406.7104, 965.4659, 0.0000, 91.6724, 0.0000);
	CreateObject(3851, 2691.6511, -2417.9324, 965.7002, 0.0000, 91.6724, 359.9992);
	CreateObject(3851, 2695.5945, -2417.9272, 965.5878, 0.0000, 91.6724, 359.9992);
	CreateObject(3851, 2699.5054, -2417.9229, 965.4591, 0.0000, 91.6724, 359.9992);
	CreateObject(3851, 2687.7034, -2417.9272, 965.8086, 0.0000, 91.6724, 359.9992);
	CreateObject(3851, 2687.7053, -2406.7241, 965.7909, 0.0000, 91.6724, 0.0000);
	CreateObject(3851, 2683.8022, -2406.7417, 965.9199, 0.0000, 91.6724, 0.0000);
	CreateObject(3851, 2683.8169, -2417.9900, 965.8997, 0.0000, 91.6724, 359.9992);
	CreateObject(3851, 2690.8962, -2403.7024, 967.5515, 0.0000, 0.0000, 270.0000);
	CreateObject(3851, 2685.2451, -2409.3770, 967.5695, 0.0000, 0.0000, 0.0000);
	CreateObject(3851, 2698.7053, -2409.7766, 967.4885, 0.0000, 0.0000, 337.5000);
	CreateObject(3851, 2691.8564, -2418.1340, 967.5005, 0.0000, 0.0000, 123.7503);
	CreateObject(3851, 2692.5295, -2410.9839, 967.4552, 0.0000, 0.0000, 45.0000);
	CreateObject(3851, 2691.6477, -2406.7185, 955.6797, 0.0000, 91.6724, 0.0000);
	CreateObject(3851, 2695.6213, -2406.7249, 955.5651, 0.0000, 91.6724, 0.0000);
	CreateObject(3851, 2699.5054, -2406.7104, 955.4659, 0.0000, 91.6724, 0.0000);
	CreateObject(3851, 2691.6511, -2417.9324, 955.7002, 0.0000, 91.6724, 359.9992);
	CreateObject(3851, 2695.5945, -2417.9272, 955.5878, 0.0000, 91.6724, 359.9992);
	CreateObject(3851, 2699.5054, -2417.9229, 955.4591, 0.0000, 91.6724, 359.9992);
	CreateObject(3851, 2687.7034, -2417.9272, 955.8086, 0.0000, 91.6724, 359.9992);
	CreateObject(3851, 2687.7053, -2406.7241, 955.7909, 0.0000, 91.6724, 0.0000);
	CreateObject(3851, 2683.8022, -2406.7417, 955.9199, 0.0000, 91.6724, 0.0000);
	CreateObject(3851, 2683.8169, -2417.9900, 955.8997, 0.0000, 91.6724, 359.9992);
	CreateObject(16095, 2690.6597, -2426.8164, 987.6741, 0.0000, 0.0000, 0.0000);
	
	CreateObject(3399, 255.549774, 1833.806152, 19.234673, 0.0000, 0.0000, 180.0000);
    CreateObject(1225, 268.651855, 1883.908325, -30.687996, 0.0000, 0.0000, 0.0000);
    CreateObject(2780, 234.076172, 1876.735718, 6.494133, 0.0000, 0.0000, 355.7028);
    CreateObject(2780, 234.443466, 1869.221191, 6.985971, 0.0000, 0.0000, 175.7029);
    CreateObject(2780, 251.690598, 1869.377197, 8.169000, 0.0000, 0.0000, 175.7029);
    CreateObject(9833, 212.302444, 1905.239014, 13.243269, 0.0000, 0.0000, 0.0000);
    CreateObject(6865, 207.109467, 1925.665039, 23.496431, 0.0000, 0.0000, 45.0000);
    CreateObject(3524, 250.530411, 1842.183228, 8.043877, 0.0000, 0.0000, 180.0000);
    CreateObject(3524, 247.232895, 1842.112061, 8.041834, 0.0000, 0.0000, 180.0000);
    CreateObject(3374, 257.848877, 1835.734009, 4.828389, 0.0000, 0.0000, 90.0000);
    CreateObject(3374, 262.297546, 1835.773438, 5.950994, 0.0000, 0.0000, 90.0000);
    CreateObject(3374, 268.087463, 1839.280396, 6.906465, 0.0000, 0.0000, 45.0000);
    CreateObject(1225, 267.535706, 1843.918701, 6.601359, 0.0000, 0.0000, 0.0000);
    CreateObject(3374, 266.723907, 1844.421631, 7.891618, 0.0000, 0.0000, 337.5000);
    CreateObject(3374, 262.663696, 1845.783936, 8.530811, 0.0000, 0.0000, 0.0000);
    CreateObject(3374, 257.975861, 1845.978638, 9.158716, 0.0000, 0.0000, 0.0000);
    CreateObject(16637, 249.071793, 1841.905151, 11.865650, 0.0000, 0.0000, 270.0000);

    CreateObject(1264, 263.973663, 1824.272827, 1.683082, 0.0000, 0.0000, 0.0000);
    CreateObject(1264, 263.938507, 1822.905640, 1.683082, 0.0000, 0.0000, 0.0000);
    CreateObject(1264, 263.689911, 1815.922852, 0.479957, 0.0000, 0.0000, 0.0000);
    CreateObject(1264, 263.572968, 1821.332397, 1.683082, 0.0000, 0.0000, 0.0000);
    CreateObject(1349, 277.072235, 1815.184448, 0.578197, 0.0000, 0.0000, 225.0000);
    CreateObject(1371, 235.215424, 1802.110107, 7.197325, 0.0000, 0.0000, 90.0000);
    CreateObject(2780, 239.790115, 1836.528564, 7.768745, 0.0000, 0.0000, 0.0000);
    CreateObject(3786, 275.050598, 1859.485474, 9.294486, 0.0000, 0.0000, 0.0000);
    CreateObject(16637, 233.649124, 1822.508545, 10.521902, 0.0000, 0.0000, 180.0000);

    CreateObject(3851, 269.743652, 1881.492065, 16.548054, 0.0000, 91.6732, 91.0458);
    CreateObject(3851, 269.725433, 1885.423096, 16.407133, 0.0000, 91.6732, 91.0458);
    CreateObject(3851, 268.270355, 1887.822021, 16.330107, 0.0000, 91.6732, 91.0458);
    CreateObject(16637, 248.183105, 1806.078003, 10.637526, 0.0000, 0.0000, 270.0000);

    CreateObject(16637, 238.554169, 1803.806152, 10.396904, 0.0000, 0.0000, 180.0000);

    CreateObject(918, 156.834198, 1831.896484, 17.019587, 0.0000, 0.0000, 0.0000);
    CreateObject(1225, 152.937958, 1846.556519, 21.046379, 0.0000, 0.0000, 0.0000);
    
    CreateObject(1683, 492.527802, 1848.627197, 141.997711, 0.0000, 0.0000, 180.0000); //avion arret


    CreateObject(13645, 563.812866, 822.977722, -22.384285, 0.0000, 0.0000, 281.2500);
    
    CreateObject(5706, -2792.214111, 2603.143311, 267.030701, 0.0000, 0.0000, 348.7500);
    CreateObject(18450, -2801.602783, 2606.428711, 285.117493, 0.0000, 88.8085, 348.7500);
    CreateObject(18450, -2793.434326, 2611.099854, 285.470551, 0.0000, 88.8085, 258.7500);
    CreateObject(18450, -2796.961670, 2599.263672, 285.444702, 0.0000, 88.8085, 78.7500);
    CreateObject(18450, -2787.656738, 2603.360596, 285.169373, 0.0000, 88.8085, 168.7501);
    CreateObject(18450, -2803.272949, 2606.678955, 365.037659, 0.0000, 88.8085, 348.7500);
    CreateObject(18450, -2796.317139, 2597.474121, 365.053223, 0.0000, 88.8085, 78.7500);
    CreateObject(18450, -2786.126709, 2603.434814, 365.199280, 0.0000, 88.8085, 168.7501);
    CreateObject(18450, -2793.120605, 2612.749268, 365.217773, 0.0000, 88.8085, 258.7500);
    CreateObject(5706, -2823.804688, 2608.377441, 407.701538, 0.0000, 0.0000, 348.7500);
    CreateObject(2918, -2795.187988, 2605.386475, 272.740326, 0.0000, 0.0000, 0.0000);
    CreateObject(2918, -2792.522705, 2603.164307, 272.740326, 0.0000, 0.0000, 0.0000);
    CreateObject(2918, -2795.040039, 2602.740723, 272.740326, 0.0000, 0.0000, 0.0000);
    CreateObject(2918, -2798.065674, 2604.287842, 272.740326, 0.0000, 0.0000, 0.0000);
    CreateObject(2918, -2789.230225, 2609.757813, 272.740326, 0.0000, 0.0000, 0.0000);
    CreateObject(2918, -2791.879883, 2608.612793, 272.740326, 0.0000, 0.0000, 0.0000);
    CreateObject(2918, -2791.000000, 2606.709473, 272.740326, 0.0000, 0.0000, 0.0000);
    CreateObject(2918, -2795.129883, 2608.716553, 272.740326, 0.0000, 0.0000, 0.0000);
    CreateObject(2918, -2797.438232, 2607.387207, 272.740326, 0.0000, 0.0000, 0.0000);
    CreateObject(2918, -2790.490723, 2604.553955, 272.740326, 0.0000, 0.0000, 0.0000);
    CreateObject(2918, -2798.266357, 2610.119141, 272.740326, 0.0000, 0.0000, 0.0000);
    CreateObject(2918, -2799.755859, 2602.588379, 272.740326, 0.0000, 0.0000, 0.0000);
    CreateObject(2918, -2790.832275, 2601.457764, 272.740326, 0.0000, 0.0000, 0.0000);
    CreateObject(2918, -2793.121826, 2606.228760, 272.740326, 0.0000, 0.0000, 0.0000);
    CreateObject(2918, -2799.104248, 2608.372803, 272.740326, 0.0000, 0.0000, 0.0000);
    CreateObject(2918, -2797.151855, 2607.970215, 274.868744, 0.0000, 0.0000, 0.0000);
    CreateObject(2918, -2795.566650, 2608.513916, 272.740326, 0.0000, 0.0000, 0.0000);
    CreateObject(2918, -2791.791992, 2606.216309, 272.740326, 0.0000, 0.0000, 0.0000);
    CreateObject(2918, -2789.787109, 2604.375977, 272.740326, 0.0000, 0.0000, 0.0000);
    CreateObject(2918, -2788.376953, 2608.833984, 272.740326, 0.0000, 0.0000, 0.0000);
    CreateObject(2918, -2788.672607, 2607.630371, 272.740326, 0.0000, 0.0000, 0.0000);
    CreateObject(2918, -2800.076172, 2605.739502, 272.740326, 0.0000, 0.0000, 0.0000);
    CreateObject(2918, -2796.901367, 2602.210205, 272.740326, 0.0000, 0.0000, 0.0000);
    CreateObject(2918, -2793.035645, 2601.083008, 272.740326, 0.0000, 0.0000, 0.0000);
    CreateObject(2918, -2796.351318, 2605.560059, 272.740326, 0.0000, 0.0000, 0.0000);
    CreateObject(10767, 1715.866211, -1138.703857, 1834.553345, 0.0000, 0.0000, 225.0004); // Halfpipe2
	CreateObject(8355, 1676.147583, -1122.658936, 1832.354980, 0.0000, 57.2958, 180.0000);
	CreateObject(8355, 1654.695190, -1122.651367, 1798.977905, 0.0000, 57.2958, 180.0000);
	CreateObject(8355, 1631.831909, -1122.667725, 1766.999023, 0.0000, 51.5662, 180.0000);
	CreateObject(8355, 1605.596558, -1122.656494, 1737.162720, 0.0000, 45.8366, 180.0000);
	CreateObject(8355, 1574.123657, -1122.653076, 1713.243042, 0.0000, 28.6479, 180.0000);
	CreateObject(8355, 1536.707031, -1122.700195, 1701.646729, 0.0000, 5.7296, 180.0000);
	CreateObject(8355, 1499.287476, -1122.690674, 1709.278687, 0.0000, 28.6479, 0.0001);
	CreateObject(8355, 1467.819336, -1122.710693, 1733.156738, 0.0000, 45.8366, 0.0000);
	CreateObject(8355, 1441.678589, -1122.699341, 1763.047119, 0.0000, 51.5662, 0.0000);
	CreateObject(10767, 1400.367188, -1138.942261, 1764.103760, 0.0000, 0.0000, 225.0004);
    
	CreateObject(18450, 0.000000, 497.000000, 300.000000, 0.0000, 0.0000, 0.0000);
	CreateObject(18450, 6.540313, 496.983948, 300.214111, 0.0116, 356.2500, 359.8227);
	CreateObject(18450, 13.052619, 496.935760, 300.855499, 0.0464, 352.5000, 359.6476);
	CreateObject(18450, 19.509031, 496.855530, 301.921478, 0.1040, 348.7500, 359.4771);
	CreateObject(18450, 25.881905, 496.743347, 303.407410, 0.1840, 345.0000, 359.3133);
	CreateObject(18450, 32.143948, 496.599304, 305.306976, 0.2856, 341.2500, 359.1586);
	CreateObject(18450, 38.268345, 496.423553, 307.612061, 0.4081, 337.5000, 359.0148);
	CreateObject(18450, 44.228870, 496.216309, 310.312714, 0.5502, 333.7500, 358.8842);
	CreateObject(18450, 50.000000, 495.977783, 313.397461, 0.7109, 330.0000, 358.7687);
	CreateObject(18450, 55.557022, 495.708221, 316.853027, 0.8887, 326.2500, 358.6701);
	CreateObject(18450, 60.876144, 495.407898, 320.664673, 1.0819, 322.5000, 358.5900);
	CreateObject(18450, 65.934586, 495.077179, 324.816010, 1.2890, 318.7500, 358.5302);
	CreateObject(18450, 70.710678, 494.716400, 329.289337, 1.5080, 315.0000, 358.4920);
	CreateObject(18450, 75.183983, 494.325928, 334.065430, 1.7370, 311.2500, 358.4766);
	CreateObject(18450, 79.335335, 493.906189, 339.123871, 1.9740, 307.5000, 358.4853);
	CreateObject(18450, 83.146957, 493.457642, 344.442963, 2.2166, 303.7500, 358.5189);
	CreateObject(18450, 86.602539, 492.980774, 350.000000, 2.4626, 300.0000, 358.5782);
	CreateObject(18450, 89.687271, 492.476074, 355.771118, 2.7097, 296.2500, 358.6637);
	CreateObject(18450, 92.387955, 491.944092, 361.731659, 2.9555, 292.5000, 358.7758);
	CreateObject(18450, 94.693016, 491.385406, 367.856049, 3.1976, 288.7500, 358.9146);
	CreateObject(18450, 96.592583, 490.800598, 374.118103, 3.4334, 285.0000, 359.0801);
	CreateObject(18450, 98.078529, 490.190308, 380.490967, 3.6605, 281.2500, 359.2719);
	CreateObject(18450, 99.144485, 489.555206, 386.947388, 3.8765, 277.5000, 359.4897);
	CreateObject(18450, 99.785889, 488.895935, 393.459686, 4.0789, 273.7500, 359.7327);
	CreateObject(18450, 100.000000, 488.213196, 400.000000, 4.2654, 270.0000, 0.0000);
	CreateObject(18450, 99.785889, 487.507782, 406.540314, 4.4336, 266.2500, 0.2906);
	CreateObject(18450, 99.144485, 486.780365, 413.052612, 4.5813, 262.5000, 0.6032);
	CreateObject(18450, 98.078529, 486.031799, 419.509033, 4.7063, 258.7500, 0.9362);
	CreateObject(18450, 96.592583, 485.262848, 425.881897, 4.8067, 255.0000, 1.2880);
	CreateObject(18450, 94.693016, 484.474335, 432.143951, 4.8805, 251.2500, 1.6567);
	CreateObject(18450, 92.387955, 483.667114, 438.268341, 4.9259, 247.5000, 2.0404);
	CreateObject(18450, 89.687271, 482.842041, 444.228882, 4.9413, 243.7500, 2.4368);
	CreateObject(18450, 86.602539, 482.000000, 450.000000, 4.9253, 240.0000, 2.8436);
	CreateObject(18450, 83.146957, 481.141907, 455.557037, 4.8765, 236.2500, 3.2584);
	CreateObject(18450, 79.335335, 480.268646, 460.876129, 4.7939, 232.5000, 3.6785);
	CreateObject(18450, 75.183983, 479.381226, 465.934570, 4.6767, 228.7500, 4.1013);
	CreateObject(18450, 70.710678, 478.480499, 470.710663, 4.5241, 225.0000, 4.5241);
	CreateObject(18450, 65.934586, 477.567505, 475.183990, 4.3357, 221.2500, 4.9439);
	CreateObject(18450, 60.876144, 476.643188, 479.335327, 4.1113, 217.5000, 5.3580);
	CreateObject(18450, 44.228870, 473.812286, 489.687286, 3.2228, 206.2500, 6.5353);
	CreateObject(18450, 38.268345, 472.852722, 492.387939, 2.8565, 202.5000, 6.8962);
	CreateObject(18450, 32.143948, 471.886871, 494.693024, 2.4565, 198.7500, 7.2366);
	CreateObject(18450, 25.881905, 470.915771, 496.592590, 2.0239, 195.0000, 7.5534);
	CreateObject(18450, 19.509031, 469.940521, 498.078522, 1.5603, 191.2500, 7.8439);
	CreateObject(18450, 13.052619, 468.962097, 499.144501, 1.0671, 187.5000, 8.1054);
	CreateObject(18450, 6.540313, 467.981567, 499.785889, 0.5463, 183.7500, 8.3352);
	CreateObject(18450, 0.000000, 467.000000, 500.000000, 0.0000, 180.0000, 8.5308);
	CreateObject(18450, -6.540313, 466.018433, 499.785889, 359.4537, 176.2500, 8.3352);
	CreateObject(18450, -25.881905, 463.084229, 496.592590, 357.9761, 165.0000, 7.5534);
	CreateObject(18450, -32.143948, 462.113129, 494.693024, 357.5435, 161.2500, 7.2366);
	CreateObject(18450, -38.268345, 461.147278, 492.387939, 357.1435, 157.5000, 6.8962);
	CreateObject(18450, -44.228870, 460.187714, 489.687286, 356.7772, 153.7500, 6.5353);
	CreateObject(18450, -50.000000, 459.235443, 486.602539, 356.4455, 150.0000, 6.1565);
	CreateObject(18450, -55.557022, 458.291473, 483.146973, 356.1492, 146.2500, 5.7631);
	CreateObject(18450, -60.876144, 457.356812, 479.335327, 355.8887, 142.5000, 5.3580);
	CreateObject(18450, -65.934586, 456.432495, 475.183990, 355.6643, 138.7500, 4.9439);
	CreateObject(18450, -70.710678, 455.519501, 470.710663, 355.4759, 135.0000, 4.5241);
	CreateObject(18450, -75.183983, 454.618774, 465.934570, 355.3233, 131.2500, 4.1013);
	CreateObject(18450, -79.335335, 453.731354, 460.876129, 355.2061, 127.5000, 3.6785);
	CreateObject(18450, -83.146957, 452.858093, 455.557037, 355.1235, 123.7500, 3.2584);
	CreateObject(18450, -86.602539, 452.000000, 450.000000, 355.0747, 120.0000, 2.8436);
	CreateObject(18450, -89.687271, 451.157959, 444.228882, 355.0587, 116.2500, 2.4368);
	CreateObject(18450, -92.387955, 450.332886, 438.268341, 355.0741, 112.5000, 2.0404);
	CreateObject(18450, -94.693016, 449.525665, 432.143951, 355.1195, 108.7500, 1.6567);
	CreateObject(18450, -96.592583, 448.737152, 425.881897, 355.1933, 105.0000, 1.2880);
	CreateObject(18450, -98.078529, 447.968201, 419.509033, 355.2937, 101.2500, 0.9362);
	CreateObject(18450, -99.144485, 447.219635, 413.052612, 355.4187, 97.5000, 0.6032);
	CreateObject(18450, -99.785889, 446.492218, 406.540314, 355.5664, 93.7500, 0.2906);
	CreateObject(18450, -100.000000, 445.786804, 400.000000, 355.7346, 90.0000, 0.0000);
	CreateObject(18450, -99.785889, 445.104065, 393.459686, 355.9211, 86.2500, 359.7327);
	CreateObject(18450, -99.144485, 444.444794, 386.947388, 356.1235, 82.5000, 359.4897);
	CreateObject(18450, -98.078529, 443.809692, 380.490967, 356.3395, 78.7500, 359.2719);
	CreateObject(18450, -96.592583, 443.199402, 374.118103, 356.5666, 75.0000, 359.0801);
	CreateObject(18450, -94.693016, 442.614594, 367.856049, 356.8024, 71.2500, 358.9146);
	CreateObject(18450, -92.387955, 442.055908, 361.731659, 357.0445, 67.5000, 358.7758);
	CreateObject(18450, -89.687271, 441.523926, 355.771118, 357.2903, 63.7500, 358.6637);
	CreateObject(18450, -86.602539, 441.019226, 350.000000, 357.5374, 60.0000, 358.5782);
	CreateObject(18450, -83.146957, 440.542358, 344.442963, 357.7834, 56.2500, 358.5189);
	CreateObject(18450, -79.335335, 440.093811, 339.123871, 358.0260, 52.5000, 358.4853);
	CreateObject(18450, -75.183983, 439.674072, 334.065430, 358.2630, 48.7500, 358.4766);
	CreateObject(18450, -70.710678, 439.283600, 329.289337, 358.4920, 45.0000, 358.4920);
	CreateObject(18450, -65.934586, 438.922821, 324.816010, 358.7110, 41.2500, 358.5302);
	CreateObject(18450, -60.876144, 438.592102, 320.664673, 358.9181, 37.5000, 358.5900);
	CreateObject(18450, -55.557022, 438.291779, 316.853027, 359.1113, 33.7500, 358.6701);
	CreateObject(18450, -50.000000, 438.022217, 313.397461, 359.2891, 30.0000, 358.7687);
	CreateObject(18450, -44.228870, 437.783691, 310.312714, 359.4498, 26.2500, 358.8842);
	CreateObject(18450, -38.268345, 437.576447, 307.612061, 359.5919, 22.5000, 359.0148);
	CreateObject(18450, -32.143948, 437.400696, 305.306976, 359.7144, 18.7500, 359.1586);
	CreateObject(18450, -25.881905, 437.256653, 303.407410, 359.8160, 15.0000, 359.3133);
	CreateObject(18450, -19.509031, 437.144470, 301.921478, 359.8960, 11.2500, 359.4771);
	CreateObject(18450, -13.052619, 437.064240, 300.855499, 359.9536, 7.5000, 359.6476);
	CreateObject(18450, -6.540313, 437.016052, 300.214111, 359.9884, 3.7500, 359.8227);
	CreateObject(18450, 0.000000, 437.000000, 300.000000, 0.0000, 0.0000, 0.0000);
	CreateObject(18450, 50.034317, 437.050934, 316.411926, 0.0000, 334.2171, 0.0000);
	CreateObject(18450, 13.389036, 436.988739, 301.661926, 0.0000, 347.9680, 0.0000);
	CreateObject(18450, 10.259542, 436.961334, 301.015076, 0.0000, 353.1246, 0.0000);
	CreateObject(18450, 26.015713, 437.035400, 305.223541, 0.0000, 341.9520, 0.0000);
	CreateObject(18450, 28.400043, 437.043335, 306.287811, 0.0000, 337.6548, 0.0000);
	CreateObject(18450, 83.768143, 437.048553, 334.087067, 0.0000, 324.7634, 0.0000);
	CreateObject(18450, 79.857574, 437.056274, 331.824097, 0.0000, 329.9200, 0.0000);
	CreateObject(18450, 146.371048, 437.077820, 378.314667, 0.0000, 324.7634, 0.0000);
	CreateObject(18450, 177.531723, 437.076508, 402.078796, 0.0000, 316.1691, 0.0000);
	CreateObject(18450, 170.189621, 437.121002, 395.450836, 0.0000, 320.4663, 0.0000);
	CreateObject(18450, 233.837006, 437.062439, 456.142700, 0.0000, 316.1691, 0.0000);
	CreateObject(18450, 287.702606, 437.038116, 507.870331, 0.0000, 316.1691, 0.0000);
	CreateObject(18450, 341.141083, 437.044220, 559.171753, 0.0000, 316.1691, 0.0000);
	CreateObject(18450, -18.295586, 464.268433, 498.344208, 357.9761, 169.2972, 7.5534);
	CreateObject(18450, 54.562870, 475.326355, 484.016937, 4.1113, 212.3433, 5.3580);
	CreateObject(18450, 397.784454, 437.036255, 613.587952, 0.0000, 316.1691, 0.0000);
	CreateObject(18450, 449.901184, 437.025787, 667.448120, 0.0000, 311.8720, 0.0000);
	CreateObject(18450, 488.196533, 437.033752, 714.167847, 0.0000, 307.5748, 0.0000);
	CreateObject(18450, 531.805786, 437.037689, 770.812622, 0.0000, 307.5748, 0.0000);
	CreateObject(18450, 464.675385, 437.010681, 684.108215, 0.0000, 310.1531, 0.0000);
	CreateObject(18450, 422.068970, 437.070068, 637.056885, 0.0000, 314.4503, 0.0000);
	CreateObject(18450, 578.019287, 437.047241, 830.898071, 0.0000, 307.5748, 0.0000);
	CreateObject(18450, 623.021729, 437.072968, 889.409851, 0.0000, 307.5748, 0.0000);
	CreateObject(18450, 667.351685, 437.075226, 947.041138, 0.0000, 307.5748, 0.0000);
	CreateObject(18450, 712.262756, 437.092255, 1005.425781, 0.0000, 307.5748, 0.0000);
	CreateObject(18450, 754.253418, 437.084656, 1059.934204, 0.0000, 307.5748, 0.0000);
	CreateObject(1655, 778.968384, 437.054352, 1092.098999, 278.3535, 0.0000, 90.0000);
	CreateObject(18450, 791.695374, 436.407623, 1121.986328, 0.8594, 292.9645, 359.1406);
	CreateObject(18450, 821.813599, 434.936127, 1193.068726, 0.8594, 292.9645, 359.1406);
	CreateObject(18450, 851.026367, 433.476349, 1262.026489, 0.8594, 292.9645, 359.1406);
	CreateObject(8040, 906.371704, 432.223175, 1299.637207, 0.0000, 0.0000, 180.8595);
	CreateObject(3264, 869.377502, 441.770569, 1298.771484, 0.0000, 0.0000, 67.5000);
	CreateObject(3263, 867.591431, 424.202881, 1298.779053, 0.0000, 0.0000, 137.6556);
	CreateObject(3262, 868.862915, 423.706085, 1298.754028, 0.0000, 0.0000, 112.5000);
	CreateObject(3265, 867.781372, 440.334930, 1298.846558, 0.0000, 0.0000, 78.7500);
	CreateObject(1228, 870.096741, 426.153015, 1299.300293, 0.0000, 0.0000, 11.2500);
	CreateObject(1228, 870.423950, 431.473175, 1299.300293, 0.0000, 0.0000, 0.0000);
	CreateObject(1228, 871.033569, 438.399078, 1299.292725, 0.0000, 0.0000, 337.5000);
	CreateObject(1228, 869.772461, 434.766388, 1299.292725, 0.0000, 0.0000, 0.0000);
	CreateObject(1228, 870.013550, 428.986145, 1299.300293, 0.0000, 0.0000, 348.7500);
	CreateObject(981, 931.129150, 414.669617, 1299.353516, 0.0000, 0.0000, 0.8594);
	CreateObject(981, 899.316101, 414.145874, 1299.467896, 0.0000, 0.0000, 0.8594);
	CreateObject(981, 882.993347, 413.911987, 1299.473511, 0.0000, 0.0000, 0.8594);
	CreateObject(981, 925.140869, 450.076630, 1299.555420, 0.0000, 0.0000, 0.8594);
	CreateObject(18368, 887.658508, 450.741333, 1296.003052, 0.0000, 0.0000, 90.0000);
	CreateObject(3361, 890.583435, 447.078125, 1298.345459, 0.0000, 0.0000, 270.0000);
	CreateObject(18450, -75.398521, 497.001007, 300.011963, 0.0000, 0.0000, 0.0000);
	CreateObject(17310, -126.561768, 497.100189, 304.002411, 0.0000, 210.4580, 0.0000);
    
	miliveh = 	CreateObject(3267, 2212.0388,-1137.8070,25.7969,195.5867,0,0);
	// objets
	CreateObject(13607, 995.232605, -1207.484375, 654.863159, 0, 0, 0);
    
   	CreateObject(8417, 994.160645, -1259.448242, 651.299927, 0, 0, 0);

	//race
	CreateObject(8417, 2944.756836, -1752.680664, 467.118713, 0, 0, 0);
    
   	CreateObject(8417, 2434.418213, -1871.609985, 466.387665, 0, 0, 0);

	//jump
    CreateObject(8417, 2565.557373, -1310.492310, 777.114502, 0, 0, 0);

	//stunt1
    CreateObject(8417, 526.415222, -2505.865479, 0.077583, 0.0000, 0.0000, 258.7500);

	//dm2
    CreateObject(13607, -940.440308, -343.029907, 724.777039, 337.0817, 0.0000, 0.0000);
    
	katana = CreateObject(3028, -2662.7451,1933.2261,225.7578, 0, 0, 0);
	
	chaise = CreateObject(1369, -2662.7451,1933.2261,225.7578, 0, 0, 0);
	
	fleche2 = CreatePickup(2058,23, 2700.196045, -2402.200195, 955.574829);
	
	cokt = CreatePickup (344,2, -2818.0251,-1530.3417,140.8438);
	
	flam = CreatePickup (361,2, -2815.6746,-1519.4891,140.8438);
	
	rifle1 = CreatePickup (357,2, -2813.3518,-1526.7675,140.8438);
	
	tele1 = CreatePickup(1581,23,2420.7197,-1881.9529,13.1150); // Teleport /race

	tele2 = CreatePickup(1313,23,-967.2900,-357.9936,36.1287); // Teleport /dm2

	tele3 = CreatePickup(1314,23,990.2617,-1304.8654,12.9547); // Teleport /stadium
	
	menu1 = CreatePickup (1239,23, 207.9456,1869.0684,13.1406);

	perso1 = CreatePickup (1239,23, -2062.5891,223.2881,35.4647);
	perso2 = CreatePickup (1239,23, -377.1883,-1434.7134,25.7266);
	perso3 = CreatePickup (1239,23, -293.8589,-1313.7675,9.3057);
	perso4 = CreatePickup (1239,23, -1411.1277,1489.8246,7.1016);
	perso5 = CreatePickup (1239,23, -1352.1639,-260.8943,14.1484);
	perso6 = CreatePickup (1239,23, -2040.0912,-106.3493,35.1972);
	perso7 = CreatePickup (1239,23, -1615.5699,683.0885,7.1875);

	perso8 = CreatePickup (1239,23, -2663.6250,609.9744,14.4545);
	perso9 = CreatePickup (1239,23, -1754.8865,945.6935,24.8828);
	perso10 = CreatePickup (1239,23, -1377.5657,478.8469,7.1875);
	perso11 = CreatePickup (1239,23, -2184.9626,613.7365,35.1641);
	perso12 = CreatePickup (1239,23, -2652.1794,-287.4060,7.5435);
	perso13 = CreatePickup (1239,23, -2634.6584,1349.5692,7.1210);
	perso14 = CreatePickup (1239,23, -2663.1907,941.6266,79.7101);
	perso15 = CreatePickup (1239,23, 343.5305,-1799.6865,4.7511);
	perso16 = CreatePickup (1239,23, -1414.7161,1577.6971,1052.5313);



	//pickups divers

	perso19= CreatePickup (1239,23, 1599.2113,-2551.8960,13.5469);
	perso20 = CreatePickup (1239,23,-1421.9528,1579.0958,1052.5313);

	perso21 = CreatePickup (1239,23, 1260.9979,-2009.1068,59.3914);

	perso22 = CreatePickup (1239,23, -1449.5389,-960.3679,201.9560);

	perso23 = CreatePickup (1239,23, 2429.1865,-1873.5581,467.3486);

	perso24 = CreatePickup (1239,23, 1884.5629,-1527.6824,3.4908);

	perso25 = CreatePickup (1239,23, 2543.3330,-1836.7162,4.7102);

	perso26 = CreatePickup (1239,23, 541.5168,-2502.8657,1.0385);


	//pickups /jump /jump2
	perso28 = CreatePickup (1239,23, 2574.0420,-1312.5798,778.0754);
	perso29 = CreatePickup (1239,23, -663.4441,2305.7710,136.1166);


	// drift
	perso30 = CreatePickup (1239,23, 2326.9214,1387.3151,42.8203);

	//laconca
	perso31 = CreatePickup (1239,23, 2495.6147,1640.2311,14.2689);

	// desert
	perso32 = CreatePickup (1239,23, 365.3698,2536.9998,16.6647);

	//ligne
	perso33 = CreatePickup (1239,23, -2351.6460,-1613.9171,483.6375);

	// chilliad
	perso34 = CreatePickup (1239,23, 365.3698,2536.9998,16.6647);

	teleport = CreateMenu("~b~Teleportations ~w~selection",1,125,150,300);
	teleport1 = CreateMenu("~b~Stunts ~w~selection",1,125,150,300);
	teleport2 = CreateMenu("~b~Cross ~w~selection",1,125,150,300);
	teleport3 = CreateMenu("~b~DM ~w~selection",1,125,150,300);
	teleport4 = CreateMenu("~b~Races ~w~selection",1,125,150,300);

    deto=CreatePickup (1254,2,1226.8099,-808.4751,1084.0078); //manoir

	CreatePickup (1252,23, 1286.5693,-828.5428,1085.6328);  //manoir
	CreatePickup (1252,23, 1274.0499,-825.8211,1085.6328);
	CreatePickup (1252,23, 1279.1196,-814.1102,1085.6328);
	CreatePickup (1252,23, 1282.7286,-832.3138,1089.9375);
	CreatePickup (1252,23, 1275.9065,-816.1691,1089.9375);
	CreatePickup (1252,23, 1288.6785,-807.6561,1089.9375);
	CreatePickup (1252,23, 1290.4569,-792.5706,1089.9375);
	CreatePickup (1252,23, 1279.5675,-772.6429,1091.9063);
	CreatePickup (1252,23, 1252.0012,-821.7390,1084.0078);
	CreatePickup (1252,23, 1235.2119,-808.3564,1084.0078);
	CreatePickup (1252,23, 1228.6798,-828.0161,1084.0078);
	CreatePickup (1252,23, 1255.3750,-804.2156,1084.0151);
	CreatePickup (1252,23, 1280.8680,-798.0719,1084.0078);
	CreatePickup (1252,23, 1271.1538,-795.0403,1084.1719);
	CreatePickup (1252,23, 1258.6477,-795.0280,1084.2344);
	CreatePickup (1252,23, 1237.5100,-756.2418,1084.0150);
	CreatePickup (1252,23, 1227.6356,-761.4369,1084.0007);
	CreatePickup (1252,23, 1231.9501,-771.9229,1084.0116);
	CreatePickup (1252,23, 1251.0398,-782.1349,1084.0078);
	CreatePickup (1252,23, 1264.6299,-767.5043,1084.0078);
	CreatePickup (1252,23, 1277.3457,-783.7160,1084.0149);
	CreatePickup (1252,23, 1299.4833,-779.8370,1084.0078);  //manoir


	if(IsValidMenu(teleport)) {
SetMenuColumnHeader(teleport , 0, "Choisissez une teleportation:");
AddMenuItem(teleport ,0,"Stunt");
AddMenuItem(teleport ,0,"Cross");
AddMenuItem(teleport ,0,"DM");
AddMenuItem(teleport ,0,"Races");
}


	if(IsValidMenu(teleport1)) {
SetMenuColumnHeader(teleport1 , 0, "Choisissez un stunt:");
AddMenuItem(teleport1 ,0,"Stunt");
AddMenuItem(teleport1,0,"Stunt1");
AddMenuItem(teleport1 ,0,"Stunt2");
AddMenuItem(teleport1 ,0,"Stunt3");
}


	if(IsValidMenu(teleport2)) {
SetMenuColumnHeader(teleport2 , 0, "Choisissez une zone de cross:");
AddMenuItem(teleport2 ,0,"Cross");
AddMenuItem(teleport2 ,0,"Cross2");
AddMenuItem(teleport2,0,"RC");
}


	if(IsValidMenu(teleport3)) {
SetMenuColumnHeader(teleport3 , 0, "Choisissez un DM:");
AddMenuItem(teleport3 ,0,"DM2");
AddMenuItem(teleport3 ,0,"Stadium");
AddMenuItem(teleport3 ,0,"Derby");
AddMenuItem(teleport3 ,0,"Forfarmers");
}


	if(IsValidMenu(teleport4)) {
SetMenuColumnHeader(teleport4 , 0, "Choisissez une course:");
AddMenuItem(teleport4 ,0,"Race");
AddMenuItem(teleport4 ,0,"Race2");
AddMenuItem(teleport4 ,0,"Race3");
AddMenuItem(teleport4 ,0,"Race4");
}



	return 1;

}

//============================On Player Exit Vehicle============================
public OnPlayerExitVehicle(playerid)
{

    used[playerid] = 0;
	passenger[playerid] = 0;
	motosou[playerid]=0;
	for(new i=0;i<MAX_PLAYERS;i++)
   {
      if(i != playerid)
      {
         SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid),i, 0, 0);


}

}
	return 1;
}

//============================Is Player Name Online=============================
public IsPlayerNameOnline(compname[])
{
	new playername[MAX_PLAYER_NAME];
    for(new i=0;i<=MAX_PLAYERS;i++)
	{
        if(IsPlayerConnected(i))
		{
            GetPlayerName(i, playername, sizeof(playername));
            if(strcmp(playername,compname,false) == 0)
			{
                return i;
			}
		}
	}
	return 100;
}
//============================Anti-Team kill Script=============================
public OnPlayerDeath(playerid, killerid, reason)
{
	new name[MAX_PLAYER_NAME];
	new string[256];
	new deathreason[20];
	new player[MAX_PLAYER_NAME];
	GameTextForPlayer(playerid,"~r~OMG Tu es mort !",10000,2);
	GetPlayerName(playerid, name, sizeof(name));
	GetWeaponName(reason, deathreason, 20);
	StopPlayerObject(playerid,katana);
	StopPlayerObject(playerid,chaise);
 	exmanoir[playerid] = 0;
 	KillTimer(timerbobgrav);
 	motosou[playerid]=0;
 	moneydef[playerid]=0;
 	moneygag[playerid]=0;
	if (killerid == INVALID_PLAYER_ID)
	{
		SendDeathMessage(INVALID_PLAYER_ID,playerid,reason);

		if (reason == WEAPON_DROWN)
		{
			format(string, sizeof(string), "*** %s s'est noyé(e).", name);
		}
		else {
  			if (strlen(deathreason) > 0)
			  {
				format(string, sizeof(string), "*** %s s'est fait tué(e).", name);
			}
			else {
		 		format(string, sizeof(string), "*** %s s'est fait tué(e).", name);
			}
		}
    }
	else
	{
		new killer[MAX_PLAYER_NAME];
		GetPlayerName(killerid, killer, sizeof(killer));
		format(string, sizeof(string), "*** %s à tué(e) %s.", killer, name);
		SendDeathMessage(killerid,playerid,reason);
		SendClientMessageToAll(COLOR_RED, string);
		Spawned[playerid] = 0;
		moneyed[playerid] = 0;
	}
	
	GetPlayerName(playerid, player, sizeof(player));
	if(reason == 35)
{
Kick (killerid);
format(string, sizeof(string), "Le serveur a kické %s pour cheat.(raison: Rocket Launcher)", player);
SendClientMessageToAll(YELLOW, string);
}
	else
{
if(reason == 36)
{
Kick(killerid);
format(string, sizeof(string), "Le serveur a kické %s pour cheat.(raison: Rocket Launcher)", player);
SendClientMessageToAll(YELLOW, string);
}
	else
{
if(reason == 38)
{
Kick(killerid);
format(string, sizeof(string), "Le serveur a kické %s pour cheat.(raison: Minigun)", player);
SendClientMessageToAll(YELLOW, string);
}
	else
{
if(IsPlayerAdmin(playerid))
return 1;
}
}
}
	moneydef[playerid]=GetPlayerMoney(playerid);
 	return 1;
}


public OnPlayerRequestClass(playerid, classid)
//--------------------------Selection Screen Colors-----------------------------

{
	TextDrawHideForPlayer(playerid,loading);
    SetPlayerWeather(playerid,190);
    
	if(classid == 0)
	{
		GameTextForPlayer(playerid, "~r~ULTIMAN", 2000, 5);
        SetPlayerColor(playerid,COLOR_GREEN);
		gTeam[playerid] = TEAM_ULTIMAN;
	}
    	else if(classid == 1)
	{
		GameTextForPlayer(playerid, "~r~ULTIGIRL", 2000, 5);
		SetPlayerColor(playerid,COLOR_PINK);
		gTeam[playerid] = TEAM_ULTIGIRL;
	}
		else if(classid == 2)
	{
		GameTextForPlayer(playerid, "~r~GOLFEUR", 2000, 5);
		SetPlayerColor(playerid,COLOR_YELLOW);
		gTeam[playerid] = TEAM_GOLFEUR;
	}
		else if(classid == 3)
	{
		GameTextForPlayer(playerid, "~r~TRIAD", 2000, 5);
		SetPlayerColor(playerid,COLOR_PINK);
		gTeam[playerid] = TEAM_TRIAD;
	}
 		else if(classid == 4)
 	{
		GameTextForPlayer(playerid, "~r~ARMEE", 2000, 5);
		SetPlayerColor(playerid,COLOR_GREEN);
		gTeam[playerid] = TEAM_ARMEE;
	}
		else if(classid == 5)
	{
		GameTextForPlayer(playerid, "~r~VALET", 2000, 5);
		SetPlayerColor(playerid,COLOR_LIGHTBLUE);
		gTeam[playerid] = TEAM_VALET;
	}
 		else if(classid == 6)
	{
		GameTextForPlayer(playerid, "~r~INFIRMIER", 2000, 5);
		SetPlayerColor(playerid,COLOR_PURPLE);
		gTeam[playerid] = TEAM_INFIRMIER;
	}
		else if(classid == 7)
	{
		GameTextForPlayer(playerid, "~r~FBI", 2000, 5);
		SetPlayerColor(playerid,COLOR_ORANGE);
		gTeam[playerid] = TEAM_FBI;
	}
		else if(classid == 8)
	{
		GameTextForPlayer(playerid, "~r~STUNTMAN", 2000, 5);
		SetPlayerColor(playerid,COLOR_RED);
		gTeam[playerid] = TEAM_STUNTMAN;
	}
		else if(classid == 9)
	{
		GameTextForPlayer(playerid, "~r~RICHE", 2000, 5);
	 	SetPlayerColor(playerid,COLOR_SKIN);
	 	gTeam[playerid] = TEAM_RICHE;
	}
		else if(classid == 10)
	{
		GameTextForPlayer(playerid, "~r~PILOTE", 2000, 5);
		SetPlayerColor(playerid,COLOR_DARKGREY);
		gTeam[playerid] = TEAM_PILOTE;
	}
  		else if(classid == 11)
	{
		GameTextForPlayer(playerid, "~r~DA NANG", 2000, 5);
		SetPlayerColor(playerid,COLOR_DARKRED);
		gTeam[playerid] = TEAM_DANANG;
	}
  		else if(classid == 12)
	{
		GameTextForPlayer(playerid, "~r~FORDEFEND", 2000, 5);
		SetPlayerColor(playerid,COLOR_ORANGE);
		gTeam[playerid] = TEAM_FORDEFEND;
	}
	  	else if(classid == 13)
	{
		GameTextForPlayer(playerid, "~r~FORATTACK", 2000, 5);
		SetPlayerColor(playerid,COLOR_AQUA);
		gTeam[playerid] = TEAM_FORATTACK;
	}
	  	else if(classid == 14)
	{
		GameTextForPlayer(playerid, "~r~RIDER", 2000, 5);
		SetPlayerColor(playerid,COLOR_INDIGO);
		gTeam[playerid] = TEAM_RIDER;
	}
	   	else if(classid == 15)
	{
		GameTextForPlayer(playerid, "~r~PIMP", 2000, 5);
		SetPlayerColor(playerid,COLOR_RED);
		gTeam[playerid] = TEAM_PIMP;
	}
//---------------------Player Selection Screen Locations------------------------
	//-------------------------------Worker
	if(classid == 0)
	{
		SetPlayerInterior(playerid,0);
		SetPlayerPos(playerid, 1614.9872,-2546.6929,13.6118);
		SetPlayerFacingAngle(playerid,90.1026);
		SetPlayerCameraPos(playerid,1602.6073,-2547.3750,13.5469);
		SetPlayerCameraLookAt(playerid, 1614.9872,-2546.6929,13.6118);
		PlayerPlaySound(playerid,SOUND_MUSIC5,1614.9872,-2546.6929,13.6118);
		ApplyAnimation(playerid,"STRIP","PUN_CASH",4.1,0,1,1,1,1);

	}
		//-------------------------------UltiGirl
	else if(classid == 1)
	{
		SetPlayerInterior(playerid,6);
		SetPlayerPos(playerid, 2336.0127,-1063.9725,1049.0234);
		SetPlayerFacingAngle(playerid,276.6525);
		SetPlayerCameraPos(playerid, 2340.7080,-1063.7745,1049.0234);
		SetPlayerCameraLookAt(playerid, 2336.0127,-1063.9725,1049.0234);
		PlayerPlaySound(playerid,SOUND_MUSIC5, 2336.0127,-1063.9725,1049.0234);
        ApplyAnimation(playerid,"STRIP","PUN_CASH",4.1,0,1,1,1,1);
	}
	//-------------------------------Golfer
	else if(classid == 2)
	{
		SetPlayerInterior(playerid,0);
		SetPlayerPos(playerid, -2457.8726,-259.3923,39.6499);
		SetPlayerFacingAngle(playerid,91.5298);
		SetPlayerCameraPos(playerid, -2463.7385,-260.9094,39.5841);
		SetPlayerCameraLookAt(playerid, -2457.8726,-259.3923,39.6499);
		PlayerPlaySound(playerid,SOUND_MUSIC5,-2457.8726,-259.3923,39.6499);
        ApplyAnimation(playerid,"STRIP","PUN_CASH",4.1,0,1,1,1,1);
	}
	//-------------------------------Triad
	else if(classid == 3)
	{
		SetPlayerInterior(playerid,0);
		SetPlayerPos(playerid, -2193.5981,641.5383,49.4429);
		SetPlayerFacingAngle(playerid,354.6778);
		SetPlayerCameraPos(playerid, -2194.3101,645.1630,49.4375);
		SetPlayerCameraLookAt(playerid, -2193.5981,641.5383,49.4429);
		PlayerPlaySound(playerid,SOUND_MUSIC5,-2193.5981,641.5383,49.4429);
        ApplyAnimation(playerid,"STRIP","PUN_CASH",4.1,0,1,1,1,1);
	}
	//-------------------------------Army
	else if(classid == 4)
	{
		SetPlayerInterior(playerid,0);
		SetPlayerPos(playerid, -1314.7040,445.2622,7.1875);
		SetPlayerFacingAngle(playerid,217.3818);
		SetPlayerCameraPos(playerid, -1314.56,435.76,8.94);
		SetPlayerCameraLookAt(playerid, -1314.7040,445.2622,7.1875);
		PlayerPlaySound(playerid,SOUND_MUSIC5,-1314.7040,445.2622,7.1875);
        ApplyAnimation(playerid,"STRIP","PUN_CASH",4.1,0,1,1,1,1);
	}
	//-------------------------------Valet
	else if(classid == 5)
	{
		SetPlayerInterior(playerid,0);
		SetPlayerPos(playerid, -1731.0652,956.3801,24.8828);
		SetPlayerFacingAngle(playerid,358.6085);
		SetPlayerCameraPos(playerid, -1731.92,960.97,26.35);
		SetPlayerCameraLookAt(playerid, -1731.0652,956.3801,24.8828);
		PlayerPlaySound(playerid,SOUND_MUSIC5, -1731.0652,956.3801,24.8828);
        ApplyAnimation(playerid,"STRIP","PUN_CASH",4.1,0,1,1,1,1);
	}
	//-------------------------------Medic
	else if(classid == 6)
	{
		SetPlayerInterior(playerid,0);
		SetPlayerPos(playerid, -2593.1321,608.7902,14.4531);
		SetPlayerFacingAngle(playerid,270.5395);
		SetPlayerCameraPos(playerid, -2590.15,608.88,14.89);
		SetPlayerCameraLookAt(playerid, -2593.1321,608.7902,14.4531);
		PlayerPlaySound(playerid,SOUND_MUSIC5, -2593.1321,608.7902,14.4531);
        ApplyAnimation(playerid,"STRIP","PUN_CASH",4.1,0,1,1,1,1);
	}
	//-------------------------------FBI
	else if(classid == 7)
	{
		SetPlayerInterior(playerid,0);
		SetPlayerPos(playerid, -1622.7039,673.5800,-4.9063);
		SetPlayerFacingAngle(playerid,150.9650);
		SetPlayerCameraPos(playerid, -1623.80,670.28,-3.78);
		SetPlayerCameraLookAt(playerid, -1622.7039,673.5800,-4.9063);
		PlayerPlaySound(playerid,SOUND_MUSIC5,-1622.7039,673.5800,-4.9063);
        ApplyAnimation(playerid,"STRIP","PUN_CASH",4.1,0,1,1,1,1);
	}
	//------------------------------Stuntman
	else if(classid == 8)
	{
		SetPlayerInterior(playerid,0);
		SetPlayerPos(playerid, -2052.3101,-142.4197,35.3203);
		SetPlayerFacingAngle(playerid,173.3385);
		SetPlayerCameraPos(playerid, -2053.3252,-160.6607,35.3203);
		SetPlayerCameraLookAt(playerid, -2052.3101,-142.4197,35.3203);
		PlayerPlaySound(playerid,SOUND_MUSIC5,-2052.3101,-142.4197,35.3203);
        ApplyAnimation(playerid,"STRIP","PUN_CASH",4.1,0,1,1,1,1);
	}
	//-------------------------------Rich
	else if(classid == 9)
	{
		SetPlayerInterior(playerid,0);
		SetPlayerPos(playerid, -2680.6270,936.2209,79.7031);
		SetPlayerFacingAngle(playerid,2.7078);
		SetPlayerCameraPos(playerid, -2680.65,938.96,80.53);
		SetPlayerCameraLookAt(playerid, -2680.6270,936.2209,79.7031);
		PlayerPlaySound(playerid,SOUND_MUSIC5,-2680.6270,936.2209,79.7031);
        ApplyAnimation(playerid,"STRIP","PUN_CASH",4.1,0,1,1,1,1);
	}
	//-------------------------------Pilot
	else if(classid == 10)
	{
		SetPlayerInterior(playerid,0);
		SetPlayerPos(playerid, -1339.0934,-299.9974,14.1484);
		SetPlayerFacingAngle(playerid,173.2872);
		SetPlayerCameraPos(playerid, -1337.09,-306.75,15.64);
		SetPlayerCameraLookAt(playerid, -1339.0934,-299.9974,14.1484);
		PlayerPlaySound(playerid,SOUND_MUSIC5, -1339.0934,-299.9974,14.1484);
        ApplyAnimation(playerid,"STRIP","PUN_CASH",4.1,0,1,1,1,1);
	}
	//-------------------------------Da Nang
	else if(classid == 11)
	{
		SetPlayerInterior(playerid,0);
		SetPlayerPos(playerid, -1421.1034,1488.5735,11.8084);
		SetPlayerFacingAngle(playerid,267.8500);
		SetPlayerCameraPos(playerid, -1417.55,1488.98,11.74);
		SetPlayerCameraLookAt(playerid, -1421.1034,1488.5735,11.8084);
		PlayerPlaySound(playerid,SOUND_MUSIC5,-1421.1034,1488.5735,11.8084);
        ApplyAnimation(playerid,"STRIP","PUN_CASH",4.1,0,1,1,1,1);
	}
	//-----------------------------FORDEFEND
	else if(classid == 12)
	{
		SetPlayerInterior(playerid,0);
		SetPlayerPos(playerid, -276.7504,-1332.3538,7.6125);
		SetPlayerFacingAngle(playerid,-268.4413);
		SetPlayerCameraPos(playerid, -282.4652,-1332.4438,7.7677);
		SetPlayerCameraLookAt(playerid, -276.7504,-1332.3538,7.6125);
		PlayerPlaySound(playerid,SOUND_MUSIC5,-276.7504,-1332.3538,7.6125);
        ApplyAnimation(playerid,"STRIP","PUN_CASH",4.1,0,1,1,1,1);
	}
	//---------------------------FORATTACK
		else if(classid == 13)
	{
		SetPlayerInterior(playerid,0);
		SetPlayerPos(playerid, -378.6329,-1418.9111,25.7266);
		SetPlayerFacingAngle(playerid,351.1076);
		SetPlayerCameraPos(playerid, -379.5747,-1407.2579,25.4592);
		SetPlayerCameraLookAt(playerid, -378.6329,-1418.9111,25.7266);
		PlayerPlaySound(playerid,SOUND_MUSIC5,-378.6329,-1418.9111,25.7266);
        ApplyAnimation(playerid,"STRIP","PUN_CASH",4.1,0,1,1,1,1);
	}
	//---------------------------RIDER
		else if(classid == 14)
	{
		SetPlayerInterior(playerid,0);
		SetPlayerPos(playerid, 293.3661,-1798.6559,4.4512);
		SetPlayerFacingAngle(playerid,266.5514);
		SetPlayerCameraPos(playerid, 306.6218,-1798.7434,4.4732);
		SetPlayerCameraLookAt(playerid, 293.3661,-1798.6559,4.4512);
		PlayerPlaySound(playerid,SOUND_MUSIC5,293.3661,-1798.6559,4.4512);
        ApplyAnimation(playerid,"STRIP","PUN_CASH",4.1,0,1,1,1,1);
	}
		//-------------------------------Pimp
		else if(classid ==15)
	{
		SetPlayerInterior(playerid,0);
		SetPlayerPos(playerid, -2718.6787,1369.0715,7.1875);
		SetPlayerFacingAngle(playerid,150.9731);
		SetPlayerCameraPos(playerid, -2722.37,1362.35,9.08);
		SetPlayerCameraLookAt(playerid, -2718.6787,1369.0715,7.1875);
		PlayerPlaySound(playerid,SOUND_MUSIC5,-2718.6787,1369.0715,7.1875);
        ApplyAnimation(playerid,"STRIP","PUN_CASH",4.1,0,1,1,1,1);
	}
	moneydef[playerid]=GetPlayerMoney(playerid);
	return 1;
}
//================================Random Functions==============================
public SystemMsg(playerid,msg[])
{
	if ((IsPlayerConnected(playerid))&&(strlen(msg)>0))
	{
		SendClientMessage(playerid,COLOR_SYSTEM,msg);
	}
	return 1;
}

stock PlayerName(playerid)
{
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, MAX_PLAYER_NAME);
	return name;
}
//==============================On Player Connect===============================
public OnPlayerConnect(playerid)
{
   	SetPlayerWeather(playerid,190);
    SetPlayerMapIcon(playerid,1,2429.7119,-1872.4382,467.3486,53,0xF5F5F5F5);
	SetPlayerMapIcon(playerid,2,1873.8799,-1517.0804,3.5199,53,0xF5F5F5F5);
	SetPlayerMapIcon(playerid,3,2539.4878,-1849.3433,3.3929,53,0xF5F5F5F5);
	SetPlayerMapIcon(playerid,4,527.0893,-2504.8962,1.0385,53,0xF5F5F5F5);
	SetPlayerMapIcon(playerid,5,1413.1477,2773.1746,10.8203,23,0xF5F5F5F5);
	SetPlayerMapIcon(playerid,6,-940.5526,-342.5797,721.7444,23,0xF5F5F5F5);
	SetPlayerMapIcon(playerid,7,996.9399,-1257.9702,652.2609,23,0xF5F5F5F5);
	SetPlayerMapIcon(playerid,8,1299.3696,-801.3244,84.1406,23,0xF5F5F5F5);
	SetPlayerMapIcon(playerid,9,215.2220,1867.5486,13.1406,23,0xF5F5F5F5);
	SetPlayerMapIcon(playerid,10,-2797.2209,-1527.6780,139.2153,23,0xF5F5F5F5);
	printf("OnPlayerConnect(%d)",playerid);
	allowprofit[playerid] = 0;
    buyable[playerid] = 0;
	Calling[playerid] = -1;
	Answered[playerid] = 0;
	Callerid[playerid] = 0;
 	Spawned[playerid] = 0;
 	welcome[playerid] = 1;
 	moneyed[playerid] = 1;
 	setd[playerid] = 0;
 	motosou[playerid]=0;
 	skinvar[playerid] = 0;
 	PlayerRegistered[playerid] = 0;
    TextDrawHideForPlayer(playerid,textdrr0);
	TextDrawHideForPlayer(playerid,textdrr1);
	TextDrawHideForPlayer(playerid,textdrr2);
    textdra[playerid] = 0;
	dm1[playerid] = 0;
	dm2[playerid] = 0;
	dm2s[playerid] = 0;
	ford[playerid] = 0;
	fora[playerid] = 0;
	stadium[playerid] = 0;
	dmvitre[playerid] = 0;
	derby[playerid] = 0;
    boxe[playerid] = 0;
    dmanoir[playerid] = 0;
    exmanoir[playerid] = 0;
    lbt = TextDrawCreate(-1.000000,2.000000,"---");
	lbb = TextDrawCreate(0.000000,337.000000,"---");
	TextDrawUseBox(lbt,1);
	TextDrawBoxColor(lbt,0x000000ff);
	TextDrawTextSize(lbt,640.000000,-69.000000);
	TextDrawUseBox(lbb,1);
	TextDrawBoxColor(lbb,0x000000ff);
	TextDrawTextSize(lbb,638.000000,-60.000000);
	TextDrawAlignment(lbt,0);
	TextDrawAlignment(lbb,0);
	TextDrawBackgroundColor(lbt,0x000000ff);
	TextDrawBackgroundColor(lbb,0x000000ff);
	TextDrawFont(lbt,3);
	TextDrawLetterSize(lbt,1.000000,12.199999);
	TextDrawFont(lbb,3);
	TextDrawLetterSize(lbb,0.899999,15.000000);
	TextDrawColor(lbt,0x000000ff);
	TextDrawColor(lbb,0x000000ff);
	TextDrawSetOutline(lbt,1);
	TextDrawSetOutline(lbb,1);
	TextDrawSetProportional(lbt,1);
	TextDrawSetProportional(lbb,1);
	TextDrawSetShadow(lbt,1);
	TextDrawSetShadow(lbb,1);
	TextDrawShowForPlayer(playerid,lbt);
	TextDrawShowForPlayer(playerid,lbb);
    loading=TextDrawCreate(350.0, 400.0,"Chargement en cours");
   	TextDrawUseBox(loading, 0);
	TextDrawFont(loading, 2);
	TextDrawSetShadow(loading,0);
	TextDrawSetOutline(loading,1);
	TextDrawColor(loading,0xFFFFFFFF);
	TextDrawShowForPlayer(playerid, loading);
	
    PlayerInterior[playerid] = GetPlayerInterior(playerid);
    server = dini_Get(FILE_SETTINGS, "servername");
   	new string[256], pname[250];
	GetPlayerName(playerid, pname, sizeof(pname));
	format(string, sizeof(string), "*** %s %s", pname,concons1[poinco]);
	SendClientMessageToAll(COLOR_GREY, string);
	poinco++;
	if(poinco == sizeof(concons1))poinco = 0;
	new playername2[MAX_PLAYER_NAME];
	GetPlayerName (playerid,playername2,sizeof(playername2));
	if (strfind (playername2,"[AFK]",true) != -1)
	{
		SendClientMessage(playerid, COLOR_ORANGE,"L'usage de [AFK] dans un pseudo n'est pas autorisé ici");
		Kick (playerid);
	}
	moneydef[playerid]=GetPlayerMoney(playerid);
	SendClientMessage(playerid,COLOR_SYSTEM, " ");
	SendClientMessage(playerid,COLOR_SYSTEM, " ");
	SendClientMessage(playerid,COLOR_SYSTEM, " ");
	SendClientMessage(playerid,COLOR_SYSTEM, " ");
	SendClientMessage(playerid,COLOR_SYSTEM, " ");
	SendClientMessage(playerid,COLOR_SYSTEM, " ");
	SendClientMessage(playerid,COLOR_SYSTEM, " ");
	SendClientMessage(playerid,COLOR_SYSTEM, " ");
	SendClientMessage(playerid,COLOR_SYSTEM, " ");
	SendClientMessage(playerid,COLOR_SYSTEM, " ");
	SendClientMessage(playerid,COLOR_SYSTEM, " ");
	SendClientMessage(playerid,COLOR_SYSTEM, " ");
	SendClientMessage(playerid,COLOR_SYSTEM, " ");
	SendClientMessage(playerid,COLOR_SYSTEM, " ");
	SendClientMessage(playerid,COLOR_SYSTEM, " ");
	SendClientMessage(playerid,COLOR_SYSTEM, " ");
	format(string2, sizeof(string2), "*** Ultimate Stunt DM ***");
	SendClientMessage(playerid,COLOR_SYSTEM, string2);
	DisplayTextForPlayer(playerid,"Bienvenue sur ~r~Ultimate", 10, 1, 3);
	format(string2, sizeof(string2), "Tape /help pour voir les commandes.");
	SendClientMessage(playerid,COLOR_AQUA, string2);
	SendClientMessageToAll(COLOR_SYSTEM, " ");
	SendClientMessageToAll(COLOR_SYSTEM, " ");
	return 1;
}

//=============================On Player Spawn==================================
public OnPlayerSpawn(playerid)
{
	SetPlayerWeather(playerid,10);
	GameTextForPlayer(playerid,"~y~BON JEU!",3000,5);
    PlayerPlaySound(playerid,SOUND_OFF,-1421.1034,1488.5735,11.8084);
	Spawned[playerid] = 1;

	switch (gPlayerClass[playerid]) {
    case 0:
    {
	gPlayerCheckpointStatus[playerid] = CHECKPOINT_PLANE;
	}
    case 1, 2:
    {
	gPlayerCheckpointStatus[playerid] = CHECKPOINT_NONE;
	}
	}
	DisablePlayerCheckpoint(playerid);

	MoveObject(katana,-2662.7451,1933.2261,225.7578,10);
	MoveObject(chaise,-2662.7451,1933.2261,225.7578,10);

    if(dm1[playerid] == 1)
    {
    SetPlayerPos(playerid, 1416.8678,2773.6418,10.8203);
    }

    if(dm2[playerid] == 1)
    {
    SetPlayerPos(playerid, -939.935242, -340.764435, 720.294983);
    }

    if(gTeam[playerid] == TEAM_ULTIGIRL)
    if(dm2s[playerid] == 0)
    {
    SetPlayerInterior(playerid,6);
    SetPlayerPos(playerid, 2336.0127,-1063.9725,1049.0234);
    SetPlayerFacingAngle(playerid,276.6525);
	SendClientMessage(playerid,COLOR_LIGHTBLUE,"N'oublie pas la commande /tele pour voir les teleportations. ;)");
	}


    if(ford[playerid] == 1)
    {
    SetPlayerPos(playerid, -250.0356, -1308.6962, 10.2857);
    }

    if(fora[playerid] == 1)
    {
    SetPlayerPos(playerid, -378.6329,-1418.9111,25.7266);
    }

    if(stadium[playerid] == 1)
    {
    SetPlayerPos(playerid,994.454224,-1251.696167,651.640198);
    }

    if(dmvitre[playerid] == 1)
    {
    SetPlayerPos(playerid,2690.9480, -2426.6470, 1000.1874);
    SetPlayerArmour(playerid,100);
    }

    if(derby[playerid] == 1)
    {
    SetPlayerInterior(playerid, 15);
    SetPlayerPos(playerid,-1394.20, 987.62, 1023.96);
    }

    if(boxe[playerid] == 1)
    {
    SetPlayerInterior(playerid, 15);
    SetPlayerPos(playerid,1325.5791, 1181.2716, 1235.1788);
    }

    if(dmanoir[playerid] == 1)
    {
    SetPlayerInterior(playerid, 5);
    SetPlayerPos(playerid,1299.14 ,-794.77,1084.00);
    }
	if(PlayerRegistered[playerid] == 0)
 	{
	TextDrawHideForPlayer(playerid,lbt);
	TextDrawHideForPlayer(playerid,lbb);
  	}
  	else if(PlayerRegistered[playerid] == 1)
  	{
	TextDrawHideForPlayer(playerid,lbt);
	TextDrawHideForPlayer(playerid,lbb);
	if(logged[playerid] == 1)
	{
	SendClientMessage(playerid,COLOR_YELLOW,"Vous touchez 1500 $ d'indemnité.");
    GivePlayerMoney(playerid,1500);
	}
	if(welcome[playerid] == 1)
	{
	    SendClientMessage(playerid,COLOR_YELLOW,"Vous pouvez vous enregistrer avec un pseudo : /reg [password]'");
		SendClientMessage(playerid,COLOR_YELLOW, "Ou loggez-vous: /log [password]");
		SendClientMessage(playerid,COLOR_BRIGHTRED,"Vous pourrez seulement récupérer votre argent après vous être loggé!");
		SendClientMessage(playerid,COLOR_AQUA,"Nouveau **stunts** : /funup /vertigo /stunt4");
		welcome[playerid] = 0;
 }
    }
    motosou[playerid]=0;
    moneydef[playerid]=GetPlayerMoney(playerid);
    return 1;
}


public OnPlayerEnterCheckpoint(playerid)
{
	switch (gPlayerCheckpointStatus[playerid])
	{
    case CHECKPOINT_PLANE:
    {
    SetPlayerInterior(playerid,0);
    SetPlayerPos(playerid, 239.5148, 1813.7039, 500.6836);
    gPlayerCheckpointStatus[playerid] = CHECKPOINT_AREA;
	}
	case CHECKPOINT_AREA:
    {
    DisablePlayerCheckpoint(playerid);
    gPlayerCheckpointStatus[playerid] = CHECKPOINT_NONE;
    }
	default:
    {
    DisablePlayerCheckpoint(playerid);
    }
	}
	DisablePlayerCheckpoint(playerid);
	moneydef[playerid]=GetPlayerMoney(playerid);
	return 1;
}

new count2;
//===============================Random Functions===============================
public OnVehicleSpawn(vehicleid)
{
	
    count2 = vehicleid;
	printf("OnVehicleSpawn(%d)", vehicleid);
	return 1;
}

//=========================OnPlayerEnterVehicle=================================
public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{

motosou[playerid]=1;

return 1;
}
//==============================================================================

forward DisplayVehicles();

public DisplayVehicles()

{

        format(String, sizeof(String), "%d Vehicules comptés", count2);

        SendClientMessage(CounterID, 0xFFFFFF, String);

}

public OnVehicleDeath(vehicleid, killerid)
{
    new filename[256];
	format(filename, sizeof(filename), "%d", vehicleid);
}
//=============================Player save system!==============================
public OnPlayerDisconnect(playerid)
{
    new playername[MAX_PLAYER_NAME];
	new string[256];
    textdra[playerid] = 0;
	dm1[playerid] = 0;
	dm2[playerid] = 0;
	dm2s[playerid] = 0;
	ford[playerid] = 0;
	fora[playerid] = 0;
	motosou[playerid]=0;
	stadium[playerid] = 0;
	dmvitre[playerid] = 0;
	derby[playerid] = 0;
    boxe[playerid] = 0;
    dmanoir[playerid] = 0;
    exmanoir[playerid] = 0;
   	PlayerRegistered[playerid] = 0;
	GetPlayerName(playerid, playername, sizeof(playername));

	if (dini_Exists(udb_encode(playername)) && logged[playerid] == 1)
	{
		dini_IntSet(udb_encode(playername), "money", GetPlayerMoney(playerid));
       	dini_IntSet(udb_encode(playername), "vehicleresetcount", gVC);
       	PlayerInterior[playerid] = GetPlayerInterior(playerid);
		if(PlayerInterior[playerid] == 0)
		{
			new Float:x, Float:y, Float:z;
      		new Float:a;
			GetPlayerFacingAngle(playerid,a);
			dini_IntSet(udb_encode(playername), "a", floatround(a));
 			GetPlayerPos(playerid,x,y,z);
			dini_IntSet(udb_encode(playername), "x", floatround(x));
			dini_IntSet(udb_encode(playername), "y", floatround(y));
			dini_IntSet(udb_encode(playername), "z", floatround(z));
		}
	}
	format(string, sizeof(string), "--- %s est parti(e).", playername);
	printf(string);
	logged[playerid] = 0;

	return 1;
}

//==================================Count Timer=================================
public ctimer()
{
    if (cseconds)
    {
        format(cstring,6,"~w~%d", cseconds-1);
        GameTextForAll(cstring,1100,4);
        SoundForAll(1056);

        cseconds --;

        if (!cseconds)
        {
            GameTextForAll("~r~GO GO GO!",2000,4);
            SoundForAll(1057);
            for (new i = 0; i < MAX_PLAYERS; i ++)
    		{
        		if (IsPlayerConnected(i)) SetTimer("resetcount",2000,0);
   			}
        }
    }
}
//=================================Reset Count==================================
public resetcount()
{
	for (new i = 0; i < MAX_PLAYERS; i ++)
	{
		if (IsPlayerConnected(i)) Count[i] = 0;
	}
}
//==================================Announcer===================================
public announcer()
{
	for(new i=0;i<MAX_PLAYERS;i++)
	{
		if(IsPlayerConnected(i) && aMessage[i] == 1)
		{
		    aMessage[i] = 0;
		    return 1;
		}
	}
	return 1;
}
//==================================Team Chat===================================
dteamchatcmd(playerid,params[])
{
    new team;
    team = GetPlayerTeam(playerid);
	new players = GetPlayers();
	new playername[256];
	GetPlayerName(playerid,playername,256);
	new temptext[256];
	new count;
 	for(count = 0;count <= players;count++)
 	{
	    if(IsPlayerConnected(count))
 	    {
	    	if(GetPlayerTeam(count) == team)
 	    	{
				format(temptext,256,"[TEAM]%s: %s",playername,params);
	   	        SendClientMessage(count,COLOR_BLUE,temptext);
			}
		}
	}
	return true;
}

dgravityplayercmd(playerid,params[])
{
if(!strlen(params)||!(strval(params)<=50&&strval(params)>=-50)) return SendClientMessage(playerid,COLOR_RED,"Erreur de syntaxe, tapez: /GRAV <-50.0 - 50.0>\".");
new string[256], bobly[24]; GetPlayerName(playerid,bobly,24); new Float:Gravity = floatstr(params);
format(string, sizeof(string), "Vous avez changé votre gravité à: \'%f\'.",Gravity);
SendClientMessage(playerid,YELLOW, string);
return 1;
}
//=================================Count Sound==================================
SoundForAll(sound)
{
    for (new i = 0, j = MAX_PLAYERS; i < j; i ++)
    {
        if (IsPlayerConnected(i)) PlayerPlaySound(i,sound,0.0,0.0,0.0);
    }
}
//=================================Score Update=================================
public scoreupdate(playerid)
{
	new CashScore;
	new name[MAX_PLAYER_NAME];
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if (IsPlayerConnected(i))
		{
			GetPlayerName(i, name, sizeof(name));
   			CashScore = GetPlayerMoney(i);
			SetPlayerScore(i, CashScore);
			if (CashScore > CashScoreOld)
			{
				CashScoreOld = CashScore;
			}
		}
	}
	if(motosou[playerid]==1)
	{
	moneygag[playerid]=GetPlayerMoney(playerid);
	moneyresult[playerid]=moneygag[playerid]-moneydef[playerid];

	if(moneyresult[playerid] >= 60)
	{

	moneyresult[playerid]=0;
	moneygag[playerid]=0;
	moneydef[playerid]=GetPlayerMoney(playerid);
	}
	else
	{
	}
}
}

//=================================Reset Message================================
public resetmessage()
{
    for(new i=0;i<MAX_PLAYERS;i++)
	{
		if(IsPlayerConnected(i) && messaged[i] == 1)
		{
		    messaged[i] = 0;
		    return 1;
		}
	}
	return 1;
}

public TimerFlash1(playerid)
{

   new Carrr = GetPlayerVehicleID(playerid), yooo = GetVehicleModel(Carrr);
   if(yooo == vehspec)
   {
   AttachObjectToPlayer(miliveh, playerid, 0, -0.5, 0.4, 0, 0, 0);
   }
   ChangeVehicleColor(flash1,0,1);
   ChangeVehicleColor(flash2,6,2);
   ChangeVehicleColor(flash3,4,4);
   ChangeVehicleColor(flash4,2,36);
   ChangeVehicleColor(flash5,184,185);
   ChangeVehicleColor(flash6,8,3);
   ChangeVehicleColor(flash7,3,0);
   ChangeVehicleColor(flash8,3,1);
   ChangeVehicleColor(flash9,186,186);
   return 1;
}
public helpserv(playerid)
{
SendClientMessageToAll(COLOR_LIGHTBLUE, hepp[hepPos]);
hepPos++;
if(hepPos == sizeof(hepp))hepPos = 0;
return 1;
}
public TimerFlash2(playerid)
{
	new tmp[64];
	format(tmp,sizeof(tmp),"hostname %s",bob[namePos]);
	SendRconCommand(tmp);
 	namePos++;
    if(namePos == sizeof(bob))namePos = 0;

    if(IsPlayerInArea(playerid,-233.5575, -338.6584, -1296.244, -1377.989))
	{
	MoveObject(b183,-277.714172, -1332.484863, 11.921299,5);
	}
    if(!IsPlayerInArea(playerid,-233.5575, -338.6584, -1296.244, -1377.989))
	{
	MoveObject(b183,-277.757599, -1332.360229, 8.102072,5);
	}
    ChangeVehicleColor(flash1,0,3);
    ChangeVehicleColor(flash2,6,10);
    ChangeVehicleColor(flash3,4,11);
    ChangeVehicleColor(flash4,4,2);
    ChangeVehicleColor(flash5,183,185);
    ChangeVehicleColor(flash6,9,3);
    ChangeVehicleColor(flash7,1,0);
    ChangeVehicleColor(flash8,1,1);
    ChangeVehicleColor(flash9,252,252);
    return 1;
}

//===================================Commands===================================
public OnPlayerCommandText(playerid, cmdtext[])

{
	new cmd[256],tmp[256];
	new idx;
	new string[256];
	new playername[MAX_PLAYER_NAME];
	new tmp2[256];
	new moneys[MAX_PLAYERS];

	cmd = strtok(cmdtext, idx);
	
//------------------new---------------------------------------------------------


    if (strcmp("/new", cmdtext, true) == 0){

   GetPlayerPos(playerid,x1,y1,z1);

   NewCar[playerid]=1;

   SetPlayerPos(playerid,2802.6626,-1446.7981,40.0426);

   return GameTextForPlayer(playerid,"Choisis un véhicule.",1000,1);

}

//-----------------------------Parachute----------------------------------------

	if(strcmp(cmdtext, "/para", true) == 0)
	{
	GivePlayerWeapon(playerid, 46, 1);
	SendClientMessage(playerid,YELLOW,"Tu viens d'obtenir un parachute");
	return 1;
	}
//-----------------------------Ateleport----------------------------------------

	if(strcmp(cmd, "/ateleport", true) == 0)
	{
		if(IsPlayerAdmin(playerid))
  {
		    SendClientMessageToAll(COLOR_PINK, "Stunt: /stunt /stunt1 /stunt2 /stunt3 /stunt4 /funup / vertigo/funstunt");
		    SendClientMessageToAll(COLOR_PINK, "Jump: /jump /jump2 /and, Races: /race /race2 /race3 /race4 /race5 ");
            SendClientMessageToAll(COLOR_PINK, "DM: /dm1 /dm2 /dm51 /manoir /stadium /derby /forfarmers /dmvitre");
            SendClientMessageToAll(COLOR_PINK, "Cross: /cross /cross2, Divers: /port /ponton /chilliad");
			SendClientMessageToAll(COLOR_PINK,"La suite ici: /tele");

			return 1;
		}
}
//---------------------------------Login System---------------------------------
	if(strcmp(cmd, "/log", true) == 0)

	{
		if(Spawned[playerid] == 0)
		{
			SendClientMessage(playerid,COLOR_BRIGHTRED,"Loggez-vous après le spawn svp: /log ou /reg");
		    return 1;
		}
		if(logged[playerid] == 1)
		{
		    SendClientMessage(playerid,COLOR_BRIGHTRED,"Vous êtes déjà loggé");
		    return 1;
		}
	    tmp = strtok(cmdtext, idx);

 		GetPlayerName(playerid, playername, sizeof(playername));
	    if(!strlen(tmp))
    	SendClientMessage(playerid,COLOR_LIGHTBLUE,"Utilisez: /log [password]");

		else
		{
			if (dini_Exists(udb_encode(playername)))
			{
					tmp2 = dini_Get(udb_encode(playername), "password");
			  		if (udb_hash(tmp) != strval(tmp2))
					  {
					    SendClientMessage(playerid,COLOR_BRIGHTRED,"Mauvais password.");
					}
					else {
						logged[playerid] = 1;
						dini_Set(udb_encode(playername),"pass",tmp);
      					new Float:x, Float:y, Float:z;
						new Float:a;
						playercount[playerid] = dini_Int(udb_encode(playername), "vehicleresetcount");
						if(playercount[playerid] != gVC)
						{
						    dini_IntSet(udb_encode(playername), "carowned", 0);
						    dini_IntSet(udb_encode(playername), "car", 0);
						    dini_IntSet(udb_encode(playername), "notified", 1);
						}
						x = dini_Int(udb_encode(playername), "x");
						y = dini_Int(udb_encode(playername), "y");
						z = dini_Int(udb_encode(playername), "z");
						a = dini_Int(udb_encode(playername), "a");
						carowned[playerid] = dini_Int(udb_encode(playername), "carowned");
						moneys[playerid] = dini_Int(udb_encode(playername), "money");
		                PlayerInfo[playerid][pAdmin] = dini_Int(udb_encode(playername), "level");
	                	SetPlayerPos(playerid,x,y,z);
						SetPlayerFacingAngle(playerid,a);
                        SendClientMessage(playerid,COLOR_GREEN,"Vous êtes maintenant loggé et avez été replacé à votre dernière position connue.");
                        SendClientMessage(playerid,COLOR_GREEN,"L'argent et la position seront sauvegardés automatiquement quand vous quitterez le jeu!");
				}
			}
			else {
			    format(string, sizeof(string), "Le compte %s, n'existe pas sur ce serveur. Veuillez taper /reg [password] pour créer un compte.", playername);
				SendClientMessage(playerid, COLOR_BRIGHTRED, string);
			}
		}

		return 1;
	}
//------------------------------Registration System-----------------------------
	if(strcmp(cmd, "/reg", true) == 0)
	{
		if(Spawned[playerid] == 0)
		{
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous devez vous enregistrer avant de continuer /log ou /reg");
		    return 1;
		}
	    tmp = strtok(cmdtext, idx);
 		GetPlayerName(playerid, playername, sizeof(playername));
        if(20 < strlen(tmp) || strlen(tmp) < 5)
		{
			SendClientMessage(playerid, COLOR_YELLOW, "Le mot de passe doit contenir 5-10 caractères.");
			return 1;
		}
	    if(!strlen(tmp))
			SendClientMessage(playerid, COLOR_YELLOW, "Utiliser: /reg [password]");

		else {
			if (!dini_Exists(udb_encode(playername)))
			{
				dini_Create(udb_encode(playername));
				dini_IntSet(udb_encode(playername), "password", udb_hash(tmp));
				dini_Set(udb_encode(playername),"pass",tmp);
				new Float:x, Float:y, Float:z;
      			new Float:a;
				GetPlayerFacingAngle(playerid,a);
				dini_IntSet(udb_encode(playername), "a", floatround(a));
 				GetPlayerPos(playerid,x,y,z);
				dini_IntSet(udb_encode(playername), "x", floatround(x));
				dini_IntSet(udb_encode(playername), "y", floatround(y));
				dini_IntSet(udb_encode(playername), "z", floatround(z));
    			dini_IntSet(udb_encode(playername), "carowned", 0);
    			dini_IntSet(udb_encode(playername), "car", 0);
    			dini_IntSet(udb_encode(playername), "level", 0);
				format(string, sizeof(string), "--- %s (id: %d) à crée un compte. Password: %s.", playername, playerid, tmp);
				printf(string);
				format(string, sizeof(string), "Compte %s créé ! Vous pouvez maintenant vous logger avec le mot de passe : %s.", playername, tmp);
				SendClientMessage(playerid, COLOR_YELLOW, string);
			}
			else {
				format(string, sizeof(string), "%s est déjà enregistré.", playername,tmp);
				SendClientMessage(playerid, COLOR_BRIGHTRED, string);
			}
		}

		return 1;
	}
//--------------------------------Change Password-------------------------------
	if(strcmp(cmd, "/setpass", true) == 0)
	{
        tmp = dini_Get(FILE_SETTINGS, "register");
		if (strval(tmp) == 0)
		{
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "On ne permet pas le registre sur ce serveur!");
		    return 1;
		}
	    tmp = strtok(cmdtext, idx);

 		GetPlayerName(playerid, playername, sizeof(playername));

		if(20 < strlen(tmp) || strlen(tmp) < 5)
		{
			SendClientMessage(playerid, COLOR_YELLOW, "Le mot de passe doit contenir 5-10 caractères.");
			return 1;
		}

		if(!strlen(tmp))
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Utilisez: /setpass [password]");

		else {
			if (dini_Exists(udb_encode(playername)))
			{
			    if (logged[playerid] == 1)
				{
			        dini_Set(udb_encode(playername),"pass",tmp);
					dini_IntSet(udb_encode(playername), "password", udb_hash(tmp));
					format(string, sizeof(string), "--- %s (id: %d) a changé le pass en %s.", playername, playerid, tmp);
					printf(string);
					format(string, sizeof(string), "Password changé pour %s, rappelez-vous en.", tmp);
					SendClientMessage(playerid, COLOR_YELLOW, string);
				}
				else SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous devez être loggé pour changer votre mot de passe.");
			}
			else {
			    format(string, sizeof(string), "%s aucun tel compte.", playername);
				SendClientMessage(playerid, COLOR_BRIGHTRED, string);
			}
		}
		return 1;
	}

//-----------------------------------Count Down---------------------------------
	if(strcmp(cmd, "/count", true) == 0)
	{
	    new seconds;
		tmp = strtok(cmdtext, idx);
		seconds = strval(tmp);
		if (!seconds)
        	SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous devez entrer le nombre de secondes.");
  		if (seconds > 20)
		  {
  			SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous devez écrire une durée entre 1 et 20 secondes");
  			return 1;
  		}

    	else if (cseconds)
        	SendClientMessage(playerid, COLOR_BRIGHTRED, "Le chrono est déjà enclenché.");

    	else
    	{
        	format(cstring,40,"Vous avez démarré le chrono à %d secondes.",seconds);
        	SendClientMessage(playerid,COLOR_LIGHTBLUE, cstring);
        	cseconds = seconds+1;
        	Count[playerid] = 1;
    	}
		return 1;
	}


//------------------------------Teleport to Ultigirl----------------------------
	if(strcmp(cmdtext, "/ultigirl", true) == 0)
	{
	    if (gTeam[playerid] == TEAM_ULTIGIRL)
		{
			SetPlayerInterior(playerid,6);
			{
				SetPlayerPos(playerid,2336.0127,-1063.9725,1049.0234);
			}
			GameTextForPlayer(playerid,"UltiGirl Spawn!",2500,3);
		}
		return 1;
	}
	
//------------------------------AFK System--------------------------------------

	if(strcmp(cmd, "/afk", true) == 0)
{
	GetPlayerName(playerid,playername,sizeof(playername));
	if(strfind(playername,"[AFK]",true) != -1)
	{
 		strdel(playername,strlen(playername)-5,strlen(playername));
		SetPlayerName(playerid,playername);
		format(string,sizeof(string),"%s n'est plus en pause (AFK).",playername);
		SendClientMessageToAll(0xFFFFFFFF,string); 
		TogglePlayerControllable(playerid,1);
	}
	else
	{
		format(string,sizeof(string),"%s c'est mis en pause (AFK).",playername);
		SendClientMessageToAll(0xFFFFFFFF,string);
		strcat(playername,"[AFK]",sizeof(playername)); 
		SetPlayerName(playerid,playername); 
		TogglePlayerControllable(playerid,0); 
	}
	return 1;
}

//------------------------------Teleport to Pimp--------------------------------
	if(strcmp(cmdtext, "/pimp", true) == 0)
	{
	    if (gTeam[playerid] == TEAM_PIMP)
		{
			SetPlayerInterior(playerid,0);
			{
				SetPlayerPos(playerid,-2653.6443,1388.2767,8.0739);
			}
			GameTextForPlayer(playerid,"Pimp Spawn!",2500,3);
		}
		return 1;
	}
//-----------------------------Teleport to Worker-------------------------------
	if(strcmp(cmdtext, "/ultiman", true) == 0)
	{
	    if (gTeam[playerid] == TEAM_ULTIMAN)
		{
			SetPlayerInterior(playerid,0);
			{
				SetPlayerPos(playerid,-2062.5583,237.4662,36.2890);
			}
			GameTextForPlayer(playerid,"ULTIMAN Spawn!",2500,3);
		}
		return 1;
	}
//----------------------------Teleport to Golfer--------------------------------
	if(strcmp(cmdtext, "/golfeur", true) == 0)
	{
	    if (gTeam[playerid] == TEAM_GOLFEUR)
		{
			SetPlayerInterior(playerid,0);
			{
				SetPlayerPos(playerid,-2642.2583,-274.9985,8.3506);
			}
			GameTextForPlayer(playerid,"Golfeur Spawn!",2500,3);
		}
		return 1;
	}
//-----------------------------Teleport to Triad--------------------------------
	if(strcmp(cmdtext, "/triad", true) == 0)
	{
	    if (gTeam[playerid] == TEAM_TRIAD)
		{
			SetPlayerInterior(playerid,0);
			{
				SetPlayerPos(playerid,-2188.8037,609.8431,36.2624);
			}
			GameTextForPlayer(playerid,"Triad Spawn!",2500,3);
		}
		return 1;
	}
//------------------------------Teleport to Army--------------------------------
	if(strcmp(cmdtext, "/armée", true) == 0)
	{
	    if (gTeam[playerid] == TEAM_ARMEE)
		{
			SetPlayerInterior(playerid,0);
			{
				SetPlayerPos(playerid,-1377.4271,466.0897,8.9393);
			}
			GameTextForPlayer(playerid,"Armee Spawn!",2500,3);
		}
		return 1;
	}
//-----------------------------Teleport to Valet--------------------------------
	if(strcmp(cmdtext, "/valet", true) == 0)
	{
	    if (gTeam[playerid] == TEAM_VALET)
		{
			SetPlayerInterior(playerid,0);
			{
				SetPlayerPos(playerid,-1754.9976,958.5851,25.8386);
			}
			GameTextForPlayer(playerid,"Valet Spawn!",2500,3);
		}
		return 1;
	}
//------------------------------Teleport to Medic-------------------------------
	if(strcmp(cmdtext, "/infirmier", true) == 0)
	{
	    if (gTeam[playerid] == TEAM_INFIRMIER)
		{
			SetPlayerInterior(playerid,0);
			{
				SetPlayerPos(playerid,-2665.4282,635.6348,16.0054);
			}
			GameTextForPlayer(playerid,"Infirmier Spawn!",2500,3);
		}
		return 1;
	}
//------------------------------Teleport to FBI---------------------------------
	if(strcmp(cmdtext, "/fbi", true) == 0)
	{
	    if (gTeam[playerid] == TEAM_FBI)
		{
			SetPlayerInterior(playerid,0);
			{
				SetPlayerPos(playerid,-1635.0077,665.8105,8.4054);
			}
			GameTextForPlayer(playerid,"FBI Spawn!",2500,3);
		}
		return 1;
	}

//------------------------------Teleport to stuntman----------------------------
	if(strcmp(cmdtext, "/stuntman", true) == 0)
	{
	    if (gTeam[playerid] == TEAM_STUNTMAN)
		{
			SetPlayerInterior(playerid,0);
			{
				SetPlayerPos(playerid,-2061.2349,-122.4176,35.3249);
			}
			GameTextForPlayer(playerid,"Stuntman Spawn!",2500,3);
		}
		return 1;
	}
//------------------------------Teleport to Rich--------------------------------
	if(strcmp(cmdtext, "/riche", true) == 0)
	{
	    if (gTeam[playerid] == TEAM_RICHE)
		{
			SetPlayerInterior(playerid,0);
			{
				SetPlayerPos(playerid,-2664.8037,938.6110,80.7618);
			}
			GameTextForPlayer(playerid,"Riche Spawn!",2500,3);
		}
		return 1;
	}
//------------------------------Teleport to Pilot-------------------------------
	if(strcmp(cmdtext, "/pilote", true) == 0)
	{
	    if (gTeam[playerid] == TEAM_PILOTE)
		{
			SetPlayerInterior(playerid,0);
			{
				SetPlayerPos(playerid,-1358.6774,-243.8737,15.6769);
			}
			GameTextForPlayer(playerid,"Pilote Spawn!",2500,3);
		}
		return 1;
	}
//------------------------------Teleport to Da Nang-----------------------------
	if(strcmp(cmdtext, "/danang", true) == 0)
	{
	    if (gTeam[playerid] == TEAM_DANANG)
		{
			SetPlayerInterior(playerid,0);
			{
				SetPlayerPos(playerid,-1430.1825,1492.3381,8.0482);
			}
			GameTextForPlayer(playerid,"Da Nang Spawn!",2500,3);
		}
		return 1;
	}
//------------------------------Teleport to Rider-------------------------------
	if(strcmp(cmdtext, "/rider", true) == 0)
	{
	    if (gTeam[playerid] == TEAM_RIDER)
		{
			SetPlayerInterior(playerid,0);
			{
				SetPlayerPos(playerid,312.4999,-1798.2933,4.5453);
			}
			GameTextForPlayer(playerid,"RIDER Spawn!",2500,3);
		}
		return 1;
	}

//------------------------------------Credits-----------------------------------
	if(strcmp(cmd, "/credits", true) == 0) {
		SendClientMessage(playerid, COLOR_LIGHTBLUE, "oOo ULTIMATE STUNT DM oOo");
		SendClientMessage(playerid, COLOR_LIGHTBLUE, "Auteur : Jonjon alias Metra(Metrakit)");
		SendClientMessage(playerid, COLOR_LIGHTBLUE, "Developpeurs Metra et Fire17");
		SendClientMessage(playerid, COLOR_LIGHTBLUE, "Mapeurs : Gouzy, Serin22 et Jonjon");
		SendClientMessage(playerid, COLOR_YELLOW, "Website de Metra : www.metra-concept.fr");
		return 1;
	}

	if (strcmp(cmdtext, "/clearall", true)==0) {
		if(IsPlayerAdmin(playerid))
  {
			SendClientMessageToAll(COLOR_SYSTEM, " ");
			SendClientMessageToAll(COLOR_SYSTEM, " ");
			SendClientMessageToAll(COLOR_SYSTEM, " ");
			SendClientMessageToAll(COLOR_SYSTEM, " ");
			SendClientMessageToAll(COLOR_SYSTEM, " ");
			SendClientMessageToAll(COLOR_SYSTEM, " ");
			SendClientMessageToAll(COLOR_SYSTEM, " ");
			SendClientMessageToAll(COLOR_SYSTEM, " ");
			SendClientMessageToAll(COLOR_SYSTEM, " ");
			SendClientMessageToAll(COLOR_SYSTEM, " ");
			SendClientMessageToAll(COLOR_SYSTEM, " ");
			SendClientMessageToAll(COLOR_SYSTEM, " ");
			SendClientMessageToAll(COLOR_SYSTEM, " ");
			SendClientMessageToAll(COLOR_SYSTEM, " ** Un administrateur a éffacé le chat ** ");
			SendClientMessageToAll(COLOR_SYSTEM, " ");
			SendClientMessageToAll(COLOR_SYSTEM, " ");

			return 1;
		}
	}
	
	if( !strcmp(cmdtext,"/tele", true) ) 
	{

		SendClientMessage(playerid,LIGHTGREEN,"====)oOo TELEPORTATIONS oOo(====");
		SendClientMessage(playerid,COLOR_LIGHTBLUE,"Stunts : /stunt /stunt1 /stunt2 /stunt3 /stunt4 /funstunt /ligne /skatepark /waterstunt");
		SendClientMessage(playerid,COLOR_LIGHTBLUE,"Cross : /cross /cross2 /rc");
		SendClientMessage(playerid,COLOR_LIGHTBLUE,"DM : /dm1 /dm2 /stadium /manoir /derby /dm51 /forfarmers /hobby /dmvitre");
		SendClientMessage(playerid,COLOR_LIGHTBLUE,"Races : /race /race2 race3 /race4 /race5 /ponton /port");
        SendClientMessage(playerid,COLOR_LIGHTBLUE,"Jumps : /jump /funup /jump2 /and /funup");
		SendClientMessage(playerid,COLOR_LIGHTBLUE,"Drift : /laconca /drift");
        SendClientMessage(playerid,COLOR_LIGHTBLUE,"Transfender et tuning : /tuning /trans /trans2");
        SendClientMessage(playerid,COLOR_LIGHTBLUE,"Divers : /desert /airport /chilliad /bistro /parking /rally /boxe /vertigo");
		return 1;
	}

	if( !strcmp(cmdtext,"/teleportation", true) ) 
	{

		SendClientMessage(playerid,LIGHTGREEN,"====)oOo TELEPORTATIONS oOo(====");
		SendClientMessage(playerid,COLOR_LIGHTBLUE,"Stunts : /stunt /stunt1 /stunt2 /stunt3 /funstunt /ligne /skatepark /waterstunt");
		SendClientMessage(playerid,COLOR_LIGHTBLUE,"Cross : /cross /cross2 /rc");
		SendClientMessage(playerid,COLOR_LIGHTBLUE,"DM : /dm1 /dm2 /stadium /manoir /derby /dm51 /forfarmers /hobby /dmvitre");
		SendClientMessage(playerid,COLOR_LIGHTBLUE,"Races : /race /race2 race3 /race4 /race5 /ponton /port");
        SendClientMessage(playerid,COLOR_LIGHTBLUE,"Jumps : /jump /funup /jump2 /and ");
		SendClientMessage(playerid,COLOR_LIGHTBLUE,"Drift : /laconca /drift");
        SendClientMessage(playerid,COLOR_LIGHTBLUE,"Transfender et tuning : /tuning /trans /trans2");
        SendClientMessage(playerid,COLOR_LIGHTBLUE,"Divers : /desert /airport /chilliad /bistro /parking /rally /boxe");
		return 1;
	}

	if( !strcmp(cmdtext,"/help", true) ) 
	{

		SendClientMessage(playerid,LIGHTGREEN,"====)oOo HELP oOo(====");
		SendClientMessage(playerid,COLOR_YELLOW,"NO CHEAT AND NO HACK!");
		SendClientMessage(playerid,COLOR_YELLOW,"ZONE STUNT = NO KILL!");
		SendClientMessage(playerid,COLOR_LIGHTBLUE,"Teleportations : /tele");
		SendClientMessage(playerid,COLOR_LIGHTBLUE,"Commandes : /commandes");
		SendClientMessage(playerid,COLOR_LIGHTBLUE,"Véhicules commandes : /car");
		return 1;
	}

	if( !strcmp(cmdtext,"/aide", true) )
	{

		SendClientMessage(playerid,LIGHTGREEN,"====)oOo HELP oOo(====");
		SendClientMessage(playerid,COLOR_YELLOW,"NO CHEAT AND NO HACK!");
		SendClientMessage(playerid,COLOR_YELLOW,"ZONE STUNT = NO KILL!");
		SendClientMessage(playerid,COLOR_LIGHTBLUE,"Teleportations : /tele");
		SendClientMessage(playerid,COLOR_LIGHTBLUE,"Commandes : /commandes");
		SendClientMessage(playerid,COLOR_LIGHTBLUE,"Véhicules commandes : /car");
		return 1;
	}

	if( !strcmp(cmdtext,"/commandes", true) ) 
	{

		SendClientMessage(playerid,LIGHTGREEN,"====)oOo COMMANDES oOo(====");
		SendClientMessage(playerid,COLOR_LIGHTBLUE,"Fermer son véhicule : /lock, ouvrir son véhicule : /unlock");
        SendClientMessage(playerid,COLOR_LIGHTBLUE,"Ramp : presser CTRL GAUCHE, pour changer de rampe : /setramp 0-5");
		SendClientMessage(playerid,COLOR_LIGHTBLUE,"Donner de l'argent : /givemoney");
		SendClientMessage(playerid,COLOR_LIGHTBLUE,"Sauvegarder votre position : /S-on ");
		SendClientMessage(playerid,COLOR_LIGHTBLUE,"Commandes fun : /grav /katana /handicap ");
		SendClientMessage(playerid,COLOR_LIGHTBLUE,"Divers : /afk /para /eat /death /danse /smoke ");
		SendClientMessage(playerid,COLOR_LIGHTBLUE,"Voir les crédits : /credits ");
		return 1;
	}

	if( !strcmp(cmdtext,"/cmd", true) ) 
	{

		SendClientMessage(playerid,LIGHTGREEN,"====)oOo COMMANDES oOo(====");
		SendClientMessage(playerid,COLOR_LIGHTBLUE,"Fermer son véhicule : /lock, ouvrir son véhicule : /unlock");
        SendClientMessage(playerid,COLOR_LIGHTBLUE,"Ramp : presser CTRL GAUCHE, pour changer de rampe : /setramp 0-5");
		SendClientMessage(playerid,COLOR_LIGHTBLUE,"Donner de l'argent : /givemoney");
		SendClientMessage(playerid,COLOR_LIGHTBLUE,"Sauvegarder votre position : /S-on ");
		SendClientMessage(playerid,COLOR_LIGHTBLUE,"Commandes fun : /grav /katana /handicap ");
		SendClientMessage(playerid,COLOR_LIGHTBLUE,"Divers : /afk /para /eat /death /danse /smoke ");
		SendClientMessage(playerid,COLOR_LIGHTBLUE,"Voir les crédits : /credits ");
		return 1;
	}

	if( !strcmp(cmdtext,"/commands", true) ) 
	{

		SendClientMessage(playerid,LIGHTGREEN,"====)oOo COMMANDES oOo(====");
		SendClientMessage(playerid,COLOR_LIGHTBLUE,"Fermer son véhicule : /lock, ouvrir son véhicule : /unlock");
        SendClientMessage(playerid,COLOR_LIGHTBLUE,"Ramp : presser CTRL GAUCHE, pour changer de rampe : /setramp 0-5");
		SendClientMessage(playerid,COLOR_LIGHTBLUE,"Donner de l'argent : /givemoney");
		SendClientMessage(playerid,COLOR_LIGHTBLUE,"Sauvegarder votre position : /S-on ");
		SendClientMessage(playerid,COLOR_LIGHTBLUE,"Commandes fun : /grav /katana /handicap ");
		SendClientMessage(playerid,COLOR_LIGHTBLUE,"Divers : /afk /para /eat /death /danse /smoke ");
		SendClientMessage(playerid,COLOR_LIGHTBLUE,"Voir les crédits : /credits ");
		return 1;
	}
	if( !strcmp(cmdtext,"/car", true) ) 
	{

        SendClientMessage(playerid,LIGHTGREEN,"====)oOo VEHICULE COMMANDES oOo(====");
        SendClientMessage(playerid,COLOR_LIGHTBLUE,"Prendre un nouveau véhicule : /new");
        SendClientMessage(playerid,COLOR_LIGHTBLUE,"Prendre un véhicule flashant : /fveh");
        SendClientMessage(playerid,COLOR_LIGHTBLUE,"Prendre une NRG invisible : /motoin");
        SendClientMessage(playerid,COLOR_LIGHTBLUE,"Réparer son véhicule : /vr");
        SendClientMessage(playerid,COLOR_LIGHTBLUE,"Réparer entierement son véhicule : /fullvr");
        SendClientMessage(playerid,COLOR_LIGHTBLUE,"Retourner son véhicule : /flip");
        SendClientMessage(playerid,COLOR_LIGHTBLUE,"Ajouter de la nitro : /nos");
		return 1;
	}
	
	if( !strcmp(cmdtext,"/pub", true) )
	{
	if(IsPlayerAdmin(playerid))
	{
 	SendClientMessageToAll(LIGHTGREEN, "_______________________________");

	SendClientMessageToAll(YELLOW, "     Visitez notre site svp: ");

	SendClientMessageToAll(YELLOW, "       www.NomDedomaine.fr ");

	SendClientMessageToAll(YELLOW, "    Enregistrez-vous sur le forum. ");

	SendClientMessageToAll(LIGHTGREEN, "_______________________________");
    }
	return 1;
	}
//------------------------------------NOS---------------------------------------


	if( !strcmp(cmdtext,"/nos", true) )
	{
    if(IsPlayerInAnyVehicle(playerid))//si le joueur est dans un vehicule
	{
	new Car = GetPlayerVehicleID(playerid), Model = GetVehicleModel(Car);
	switch(Model) { case     430,446,448,449,452,453,454,461,462,463,468,472,473,481,484,
    493,509,510,520,521,522,523,537,538,569,570,581,586,590,595: return//si le joueur est dans un de ces id
    SendClientMessage(playerid,COLOR_GREEN,"C'est impossible sur ce véhicule.");//il obtient ce méssage
	}
	AddVehicleComponent(GetPlayerVehicleID(playerid),1010);//sinon, il a la nitro
	SendClientMessage(playerid,COLOR_YELLOW,"Votre véhicule est désormais équipé de nos.");
	}else{//sinon (si le joueur n'est pas dans un véhicule)
	SendClientMessage(playerid,COLOR_RED,"Vous devez être dans un véhicule.");//il obtient ce message
	return 1;
	}
	return 1;
	}

//-------------------------------Player Clear Chat------------------------------
	if (strcmp(cmdtext, "/clear", true)==0)
	{
		SendClientMessage(playerid, COLOR_SYSTEM, " ");
		SendClientMessage(playerid, COLOR_SYSTEM, " ");
		SendClientMessage(playerid, COLOR_SYSTEM, " ");
		SendClientMessage(playerid, COLOR_SYSTEM, " ");
		SendClientMessage(playerid, COLOR_SYSTEM, " ");
		SendClientMessage(playerid, COLOR_SYSTEM, " ");
		SendClientMessage(playerid, COLOR_SYSTEM, " ");
		SendClientMessage(playerid, COLOR_SYSTEM, " ");
		SendClientMessage(playerid, COLOR_SYSTEM, " ");
		SendClientMessage(playerid, COLOR_SYSTEM, " ");
		SendClientMessage(playerid, COLOR_SYSTEM, " ");
		SendClientMessage(playerid, COLOR_SYSTEM, " ");
		SendClientMessage(playerid, COLOR_SYSTEM, " ");
		SendClientMessage(playerid, COLOR_SYSTEM, " ");
		SendClientMessage(playerid, COLOR_SYSTEM, " ");
		SendClientMessage(playerid, COLOR_SYSTEM, " ");
		return 1;
	}


	if(strcmp(cmdtext, "/exit", true) == 0)
{
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid,-2040.251587, -97.368607, 34.482243);
GameTextForPlayer(playerid,"Bonne continuation! ",2000,5);
ResetPlayerWeapons(playerid);
if(IsPlayerInAnyVehicle(playerid))
{
new VehicleID;
VehicleID = GetPlayerVehicleID(playerid);
SetVehiclePos(VehicleID,-2047.597168, -97.544945, 34.489979);
}
return 1;
}

	if(strcmp(cmdtext, "/race5") == 0)
{
if(dm2s[playerid] == 1)
return SendClientMessage(playerid, YELLOW, "Vous ne pouvez pas utiliser cette commande, tapez /dmq pour sortir du dm.");
GetPlayerName(playerid, playername, sizeof(playername));
format(string, sizeof(string), "%s viens d'entrer dans la zone: /race5", playername);
SendClientMessageToAll(LIGHTGREEN, string);
SetPlayerPos(playerid,-1403.7610,-227.0062,1043.2185);
GameTextForPlayer(playerid,"Bienvenue a race5",2000,5);
SetPlayerInterior(playerid,7);
SendClientMessage(playerid, COLOR_ORANGE, "Pour démarrer le chrono tape: /count !");
SendClientMessage(playerid, COLOR_LIGHTBLUE, "Pour quitter race tape: /exit");
return 1;
}
	if(strcmp(cmdtext, "/scorew") == 0)
{
format(string, sizeof(string), "Ton score est de %d .", moneyresult);
SendClientMessage(playerid,LIGHTGREEN, string);
return 1;
}
	if(!strcmp(cmdtext, "/countcars", true, 10))
	{
	    if(IsPlayerAdmin(playerid))
	    {
	    CounterID = playerid;
        for(new i = 0; i < MAX_VEHICLES; i ++)
        SetVehicleToRespawn(i);
	    SetTimer("DisplayVehicles", 5000, 0);
	    }
	    return 1;
	}



	if(strcmp(cmdtext, "/port") == 0)
{
if(dm2s[playerid] == 1)
return SendClientMessage(playerid, YELLOW, "Vous ne pouvez pas utiliser cette commande, tapez /dmq pour sortir du dm.");
GetPlayerName(playerid, playername, sizeof(playername));
format(string, sizeof(string), "%s viens d'entrer dans la zone: /port", playername);
SendClientMessageToAll(LIGHTGREEN, string);
SetPlayerPos(playerid,2395.579102, 585.829834, 10.140400);
GameTextForPlayer(playerid,"Bienvenue au Port",2000,5);
SetPlayerInterior(playerid,0);
if(IsPlayerInAnyVehicle(playerid))
{
new VehicleID;
VehicleID = GetPlayerVehicleID(playerid);
SetVehiclePos(VehicleID,2395.587891, 580.243347, 10.140400);
}
return 1;
}

	if(strcmp(cmd, "/danse", true) == 0) {
		    

			// Get the dance style param
      		tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
				SendClientMessage(playerid,0xFF0000FF,"Utilisez: /danse [style 1-4]");
				return 1;
			}

			dancestyle = strval(tmp);
			if(dancestyle < 1 || dancestyle > 4) {
			    SendClientMessage(playerid,0xFF0000FF,"Utilisez: /danse [style 1-4]");
			    return 1;
			}

			if(dancestyle == 1) {
			    SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE1);
			} else if(dancestyle == 2) {
			    SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE2);
			} else if(dancestyle == 3) {
			    SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE3);
			} else if(dancestyle == 4) {
			    SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE4);
			}
 	  		return 1;
	}

	if(strcmp(cmdtext, "/chilliad", true) == 0)
{
if(dm2s[playerid] == 1)
return SendClientMessage(playerid, YELLOW, "Vous ne pouvez pas utiliser cette commande, tapez /dmq pour sortir du dm.");
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid,-2326.098145, -1616.646240, 483.033264);
GameTextForPlayer(playerid,"Bienvenue au CHILLIAD",2000,5);
GetPlayerName(playerid, playername, sizeof(playername));
format(string, sizeof(string), " %s viens d'entrer dans la zone: /chilliad",playername);
SendClientMessageToAll(LIGHTGREEN, string);
if(IsPlayerInAnyVehicle(playerid))
{
new VehicleID;
VehicleID = GetPlayerVehicleID(playerid);
SetVehiclePos(VehicleID,-2324.378906, -1625.670654, 483.024445);
}
return 1;
}
	if(strcmp(cmdtext, "/funup", true) == 0)
{
if(dm2s[playerid] == 1)
return SendClientMessage(playerid, YELLOW, "Vous ne pouvez pas utiliser cette commande, tapez /dmq pour sortir du dm.");
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid,-2826.8608,2610.3401,412.5220);
GameTextForPlayer(playerid,"Bienvenue a FUNUP",2000,5);
GetPlayerName(playerid, playername, sizeof(playername));
format(string, sizeof(string), " %s viens d'entrer dans la zone: /funup",playername);
SendClientMessageToAll(LIGHTGREEN, string);
if(IsPlayerInAnyVehicle(playerid))
{
new VehicleID;
VehicleID = GetPlayerVehicleID(playerid);
SetVehiclePos(VehicleID,-2816.4136,2610.7258,412.5220);
}
return 1;
}

	if(strcmp(cmdtext, "/kill", true) == 0) {
SetPlayerHealth(playerid,0.0);
return 1;
}
	if(strcmp(cmdtext, "/handicap", true) == 0) {
if (GetPlayerState(playerid)== 1)
{

ApplyAnimation(playerid,"ped", "SEAT_idle", 2.000001, 1, 0, 0, 1, -1);
AttachObjectToPlayer(chaise, playerid, 0, -0.5, -0.5, 0, 0, 180);
}
return 1;
}

	if (strcmp(cmdtext, "/lc", true) == 0)
{
	 if(dm2s[playerid] == 1)
     return SendClientMessage(playerid, YELLOW, "Vous ne pouvez pas utiliser cette commande, tapez /dmq pour sortir du dm.");
     SetPlayerInterior(playerid, 1);
     SetPlayerFacingAngle(playerid, 270);
     SetPlayerPos(playerid, -900.698913,458.643615,1346.875000);
     SendClientMessage(playerid, 0xFFFFFFAA, "Liberty City");
     SendClientMessage(playerid, 0xFFFFFFAA, "Attention: c'est un bug de gta, les textures ne sont pas solides.");
     return 1;
}

	if (strcmp(cmdtext, "/ponton", true) == 0)
{
	 if(dm2s[playerid] == 1)
     return SendClientMessage(playerid, YELLOW, "Vous ne pouvez pas utiliser cette commande, tapez /dmq pour sortir du dm.");
     SetPlayerInterior(playerid, 0);
     SetPlayerFacingAngle(playerid, 128.3099);
     SetPlayerPos(playerid, 2123.1384,-90.5492,2.1892);
     GameTextForPlayer(playerid,"Bienvenue au Ponton !",2000,5);
     GetPlayerName(playerid, playername, sizeof(playername));
	 format(string, sizeof(string), " %s viens d'entrer dans la zone: /ponton",playername);
	 SendClientMessageToAll(LIGHTGREEN, string);
     return 1;
}

	if (strcmp(cmdtext, "/bistro", true) == 0)
{
	 if(dm2s[playerid] == 1)
	 return SendClientMessage(playerid, YELLOW, "Vous ne pouvez pas utiliser cette commande, tapez /dmq pour sortir du dm.");
     SetPlayerInterior(playerid, 1);
     SetPlayerFacingAngle(playerid, 0);
     SetPlayerPos(playerid, -794.9109,493.3645,1376.1953);
     SendClientMessage(playerid, 0xFFFF00AA, "Viens boire un coup au ch'tit bistro!");
     GetPlayerName(playerid, playername, sizeof(playername));
	 format(string, sizeof(string), " %s viens d'entrer dans la zone: /bistro",playername);
	 SendClientMessageToAll(LIGHTGREEN, string);
     return 1;
}

	if (strcmp(cmdtext, "/fveh", true) == 0)
{
	 if(dm2s[playerid] == 1)
	 return SendClientMessage(playerid, YELLOW, "Vous ne pouvez pas utiliser cette commande, tapez /dmq pour sortir du dm.");
     SetPlayerInterior(playerid, 0);
     SetPlayerFacingAngle(playerid, 216.0272);
     SetPlayerPos(playerid, 2209.6724,-1152.0153,29.7969);
     SendClientMessage(playerid, 0xFFFF00AA, "C'est le grand luxe!");
     GetPlayerName(playerid, playername, sizeof(playername));
	 format(string, sizeof(string), " %s va prendre un super véhicule à: /fveh",playername);
	 SendClientMessageToAll(LIGHTGREEN, string);
     return 1;
}

	if(strcmp(cmdtext,"/s-on",true)== 0) {
	if (SaveP[playerid] == 1)
{
SendClientMessage(playerid,0xFF0000AA,"> Save Position est déja activé.");
}
	else{
SaveP[playerid] = 1;
SendClientMessage(playerid,0x33FF33AA,"> Save Position activé.");
SendClientMessage(playerid,0x33FF33AA," ");
SendClientMessage(playerid,0xFFFFFFFF," Pressez \"6\" pour sauver votre position.");
SendClientMessage(playerid,0xFFFFFFFF," Pressez \"4\" pour charger votre position.");
}
	return 1;
}

	if(strcmp(cmdtext,"/s-off",true)== 0) {
	if (SaveP[playerid] == 0 && RewP[playerid] == 0)
{
SendClientMessage(playerid,0xFF0000AA,"> Save Position est déja activé.");
}
	else{
SaveP[playerid] = 0;
RewP[playerid] = 0;
SendClientMessage(playerid,0x33FF33AA,"> Save Position désactivé..");
}
	return 1;
}

	if (strcmp(cmdtext, "/des", true) == 0)
			if(IsPlayerAdmin(playerid))
                {

            new VehicleId = GetPlayerVehicleID (playerid);
            SetVehicleToRespawn (VehicleId);
            PlayerRequestNew[playerid] = 1;
            return 1;
}

	new targetid;
	new Float:x7, Float:y7, Float:z7;
	if(strcmp(cmd, "/nuke", true) == 0)
	{
	    if(IsPlayerAdmin(playerid))
	    {
	        tmp = strtok(cmdtext, idx);
	        if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_ORANGE, "Utilise: /nuke <id>");
	        targetid = strval(tmp);
	        if(IsPlayerConnected(targetid))
	        {
	            SendClientMessage(playerid, COLOR_GREEN, "Vous avez bombardez ce joueur!");
	            SendClientMessage(targetid, COLOR_RED, "Aie... Bobo! Un admin vous a bombardé!");
	            GetPlayerPos(targetid, x7, y7, z7);
	            for(new i = 0; i<10; i++)
	            {
	                CreateExplosion(x7, y7, z7, 7, 10);
				}
	            return 1;
			}
			else return SendClientMessage(playerid, COLOR_RED, "ID invalide");
		}
		else return SendClientMessage(playerid, COLOR_RED, "Vous ne pouvez pas employer cette commande!");
	}

	if(strcmp(cmdtext, "/fordefend", true) == 0)
{
if(dm2s[playerid] == 1)
return SendClientMessage(playerid, YELLOW, "Vous ne pouvez pas utiliser cette commande, tapez /dmq pour sortir du dm.");
gTeam[playerid] = TEAM_FORDEFEND;
ford[playerid] = 1;
dm2s[playerid] = 1;
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid,-250.0356, -1308.6962, 10.2857);
GameTextForPlayer(playerid,"Bienvenue au FORT FARMERS !",2000,5);
if(IsPlayerInAnyVehicle(playerid))
SendClientMessage(playerid,COLOR_GREEN, "Pour quitter le dm tape: /dmq , good game!");
GetPlayerName(playerid, playername, sizeof(playername));
format(string, sizeof(string), " %s viens d'entrer dans la zone /forfarmers comme defenseur",playername);
SendClientMessageToAll(LIGHTGREEN, string);
SetPlayerSkin(playerid,158);
SetPlayerColor(playerid,COLOR_ORANGE);
return 1;
}

	if(strcmp(cmdtext, "/forattack", true) == 0)
{
if(dm2s[playerid] == 1)
return SendClientMessage(playerid, YELLOW, "Vous ne pouvez pas utiliser cette commande, tapez /dmq pour sortir du dm.");
gTeam[playerid] = TEAM_FORATTACK;
fora[playerid] = 1;
dm2s[playerid] = 1;
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid,-378.6329,-1418.9111,25.7266);
GameTextForPlayer(playerid,"Bienvenue au FORT FARMERS !",2000,5);
if(IsPlayerInAnyVehicle(playerid))
SendClientMessage(playerid,COLOR_GREEN, "Pour quitter le dm tape: /dmq , good game!");
GetPlayerName(playerid, playername, sizeof(playername));
format(string, sizeof(string), " %s viens d'entrer dans la zone /forfarmers comme attaquant",playername);
SendClientMessageToAll(LIGHTGREEN, string);
SetPlayerSkin(playerid,206);
SetPlayerColor(playerid,COLOR_AQUA);
return 1;
}


	if(strcmp(cmdtext, "/reconst", true) == 0)
{
    DestroyObject( b1);
    DestroyObject( b2);
    DestroyObject( b3);
    DestroyObject( b4);
    DestroyObject( b5);
    DestroyObject( b6);
    DestroyObject( b7);
    DestroyObject( b8);
    DestroyObject( b9);
    DestroyObject( b10);
    DestroyObject( b11);
    DestroyObject( b12);
    DestroyObject( b13);
    DestroyObject( b14);
    DestroyObject( b15);
    DestroyObject( b16);
    DestroyObject( b17);
    DestroyObject( b18);
    DestroyObject( b19);
    DestroyObject( b20);
    DestroyObject( b21);
    DestroyObject( b22);
    DestroyObject( b23);
    DestroyObject( b24);
    DestroyObject( b25);
    DestroyObject( b26);
    DestroyObject( b27);
    DestroyObject( b28);
    DestroyObject( b29);
    DestroyObject( b30);
    DestroyObject( b31);
    DestroyObject( b32);
    DestroyObject( b33);
    DestroyObject( b34);
    DestroyObject( b35);
    DestroyObject( b36);
    DestroyObject( b37);
    DestroyObject( b38);
    DestroyObject( b39);
    DestroyObject( b40);
    DestroyObject( b41);
    DestroyObject( b42);
    DestroyObject( b43);
    DestroyObject( b44);
    DestroyObject( b45);
    DestroyObject( b46);
    DestroyObject( b47);
    DestroyObject( b48);
    DestroyObject( b49);
    DestroyObject( b50);
    DestroyObject( b51);
    DestroyObject( b52);
    DestroyObject( b53);
    DestroyObject( b54);
    DestroyObject( b55);
    DestroyObject( b56);
    DestroyObject( b57);
    DestroyObject( b58);
    DestroyObject( b59);
    DestroyObject( b60);
    DestroyObject( b61);
    DestroyObject( b62);
    DestroyObject( b63);
    DestroyObject( b64);
    DestroyObject( b65);
    DestroyObject( b66);
    DestroyObject( b67);
    DestroyObject( b68);
    DestroyObject( b69);
    DestroyObject( b70);
    DestroyObject( b71);
    DestroyObject( b72);
    DestroyObject( b73);
    DestroyObject( b74);
    DestroyObject( b75);
    DestroyObject( b76);
    DestroyObject( b77);
    DestroyObject( b78);
    DestroyObject( b79);
    DestroyObject( b80);
    DestroyObject( b81);
    DestroyObject( b82);
    DestroyObject( b83);
    DestroyObject( b84);
    DestroyObject( b85);
    DestroyObject( b86);
    DestroyObject( b87);
    DestroyObject( b88);
    DestroyObject( b89);
    DestroyObject( b90);
    DestroyObject( b91);
    DestroyObject( b92);
    DestroyObject( b93);
    DestroyObject( b94);
    DestroyObject( b95);
    DestroyObject( b96);
    DestroyObject( b97);
    DestroyObject( b98);
    DestroyObject( b99);
    DestroyObject( b100);
    DestroyObject( b101);
    DestroyObject( b102);
    DestroyObject( b103);
    DestroyObject( b104);
    DestroyObject( b105);
    DestroyObject( b106);
    DestroyObject( b107);
    DestroyObject( b108);
    DestroyObject( b109);
    DestroyObject( b110);
    DestroyObject( b111);
    DestroyObject( b112);
    DestroyObject( b113);
    DestroyObject( b114);
    DestroyObject( b115);
    DestroyObject( b116);
    DestroyObject( b117);
    DestroyObject( b118);
    DestroyObject( b119);
    DestroyObject( b120);
    DestroyObject( b121);
    DestroyObject( b122);
    DestroyObject( b123);
    DestroyObject( b124);
    DestroyObject( b125);
    DestroyObject( b126);
    DestroyObject( b127);
    DestroyObject( b128);
    DestroyObject( b129);
    DestroyObject( b130);
    DestroyObject( b131);
    DestroyObject( b132);
    DestroyObject( b133);
    DestroyObject( b134);
    DestroyObject( b135);
    DestroyObject( b136);
    DestroyObject( b137);
    DestroyObject( b138);
    DestroyObject( b139);
    DestroyObject( b140);
    DestroyObject( b141);
    DestroyObject( b142);
    DestroyObject( b143);
    DestroyObject( b144);
    DestroyObject( b145);
    DestroyObject( b146);
    DestroyObject( b147);
    DestroyObject( b148);
    DestroyObject( b149);
    DestroyObject( b150);
    DestroyObject( b151);
    DestroyObject( b152);
    DestroyObject( b153);
    DestroyObject( b154);
    DestroyObject( b155);
    DestroyObject( b156);
    DestroyObject( b157);
    DestroyObject( b158);
    DestroyObject( b159);
    DestroyObject( b160);
    DestroyObject( b161);
    DestroyObject( b162);
    DestroyObject( b163);
    DestroyObject( b164);
    DestroyObject( b165);
    DestroyObject( b166);
    DestroyObject( b167);
    DestroyObject( b168);
    DestroyObject( b169);
    DestroyObject( b170);
    DestroyObject( b171);
    DestroyObject( b172);
    DestroyObject( b173);
    DestroyObject( b174);
    DestroyObject( b175);
    DestroyObject( b176);
    DestroyObject( b177);
    DestroyObject( b178);
    DestroyObject( b179);
    DestroyObject( b180);
    DestroyObject( b181);
    DestroyObject( b182);
    DestroyObject( b183);
    
	b1=CreateObject(3374, -277.795959, -1328.474365, 8.293514, 0.0000, 0.0000, 180.0002);
	b2=CreateObject(3374, -277.622650, -1336.372437, 8.122874, 0.0000, 0.0000, 180.0002);
	b3=CreateObject(3374, -277.431732, -1340.441406, 8.063190, 0.0000, 0.0000, 180.0000);
	b4=CreateObject(3374, -273.915497, -1340.683228, 16.973503, 0.0000, 0.0000, 270.0004);
	b5=CreateObject(3374, -269.968719, -1340.585327, 16.992702, 0.0000, 0.0000, 270.0004);
	b6=CreateObject(3374, -265.975616, -1340.652832, 16.933535, 0.0000, 0.0000, 270.0004);
	b7=CreateObject(3374, -262.010498, -1340.692627, 16.964914, 0.0000, 0.0000, 270.0004);
	b8=CreateObject(3374, -258.036041, -1340.704834, 17.010767, 0.0000, 0.0000, 270.0005);
	b9=CreateObject(3374, -257.962036, -1336.668579, 17.076801, 0.0000, 0.0000, 0.0006);
	b10=CreateObject(3374, -257.980469, -1332.655518, 17.083822, 0.0000, 0.0000, 0.0006);
	b11=CreateObject(3374, -258.095306, -1328.563232, 17.168003, 0.0000, 0.0000, 0.0006);
	b12=CreateObject(3374, -257.965912, -1324.579834, 17.178797, 0.0000, 0.0000, 90.0006);
	b13=CreateObject(3374, -261.943634, -1324.513428, 17.088385, 0.0000, 0.0000, 90.0006);
	b14=CreateObject(3374, -266.010651, -1324.486206, 17.108250, 0.0000, 0.0000, 90.0006);
	b15=CreateObject(3374, -270.025421, -1324.524292, 17.029274, 0.0000, 0.0000, 90.0006);
	b16=CreateObject(3374, -274.042969, -1324.489624, 17.002766, 0.0000, 0.0000, 90.0003);
	b17=CreateObject(3374, -262.229034, -1328.580322, 17.212660, 0.0000, 0.0000, 90.0006);
	b18=CreateObject(3374, -259.990784, -1332.705688, 17.033823, 0.0000, 0.0000, 90.0006);
	b19=CreateObject(3374, -262.158600, -1336.760620, 17.102060, 0.0000, 0.0000, 90.0006);
	b20=CreateObject(3374, -266.317352, -1328.639648, 17.090569, 0.0000, 0.0000, 90.0006);
	b21=CreateObject(3374, -266.215820, -1332.617920, 17.088394, 0.0000, 0.0000, 90.0006);
	b22=CreateObject(3374, -266.222473, -1336.588379, 17.059843, 0.0000, 0.0000, 90.0006);
	b23=CreateObject(3374, -270.337219, -1328.524170, 17.025202, 0.0000, 0.0000, 90.0006);
	b24=CreateObject(3374, -270.248322, -1332.563477, 17.006952, 0.0000, 0.0000, 90.0006);
	b25=CreateObject(3374, -270.153748, -1336.435913, 17.118042, 0.0000, 0.0000, 90.0006);
	b26=CreateObject(3374, -274.287262, -1328.413818, 16.909967, 0.0000, 0.0000, 90.0006);
	b27=CreateObject(3374, -274.255859, -1332.271118, 16.929693, 0.0000, 0.0000, 90.0006);
	b28=CreateObject(3374, -277.571167, -1344.479004, 7.916314, 0.0000, 0.0000, 270.0007);
	b29=CreateObject(3374, -273.899994, -1344.436646, 7.769637, 0.0000, 0.0000, 270.0006);
	b30=CreateObject(3374, -269.884766, -1344.382324, 7.731488, 0.0000, 0.0000, 270.0006);
	b31=CreateObject(3374, -265.846680, -1344.389526, 7.731573, 0.0000, 0.0000, 270.0006);
	b32=CreateObject(3374, -261.870087, -1344.374268, 7.723220, 0.0000, 0.0000, 270.0006);
	b33=CreateObject(3374, -257.884277, -1344.394287, 7.693246, 0.0000, 0.0000, 270.0006);
	b34=CreateObject(3374, -254.236359, -1344.494751, 7.660328, 0.0000, 0.0000, 270.0006);
	b35=CreateObject(3374, -254.222839, -1340.554810, 7.838885, 0.0000, 0.0000, 0.0006);
	b36=CreateObject(3374, -254.106827, -1336.586792, 7.900655, 0.0000, 0.0000, 0.0006);
	b37=CreateObject(3374, -253.925049, -1328.511963, 8.053417, 0.0000, 0.0000, 0.0006);
	b38=CreateObject(3374, -253.873138, -1324.582397, 8.140799, 0.0000, 0.0000, 0.0006);
	b39=CreateObject(3374, -254.080261, -1320.689453, 8.061488, 0.0000, 0.0000, 90.0007);
	b40=CreateObject(3374, -258.040466, -1320.693726, 8.021676, 0.0000, 0.0000, 90.0007);
	b41=CreateObject(3374, -262.050201, -1320.771484, 8.181780, 0.0000, 0.0000, 90.0007);
	b42=CreateObject(3374, -266.088715, -1320.708984, 8.201214, 0.0000, 0.0000, 90.0007);
	b43=CreateObject(3374, -269.875885, -1320.550293, 8.392005, 0.0000, 0.0000, 90.0007);
	b44=CreateObject(3374, -273.947174, -1320.481689, 8.391057, 0.0000, 0.0000, 90.0007);
	b45=CreateObject(3374, -277.930420, -1320.474365, 8.361448, 0.0000, 0.0000, 90.0007);
	b46=CreateObject(3374, -277.548523, -1344.491089, 10.798084, 0.0000, 0.0000, 270.0000);
	b47=CreateObject(3374, -277.628235, -1344.604248, 13.798084, 0.0000, 0.0000, 270.0000);
	b48=CreateObject(3374, -273.504456, -1344.439697, 10.769636, 0.0000, 0.0000, 270.0000);
	b49=CreateObject(3374, -273.585327, -1344.551514, 13.769636, 0.0000, 0.0000, 270.0000);
	b50=CreateObject(3374, -269.979675, -1344.352173, 10.731488, 0.0000, 0.0000, 270.0000);
	b51=CreateObject(3374, -269.989014, -1344.455444, 13.731488, 0.0000, 0.0000, 270.0000);
	b52=CreateObject(3374, -265.951721, -1344.440796, 10.731573, 0.0000, 0.0000, 270.0000);
	b53=CreateObject(3374, -266.052216, -1344.526123, 13.731573, 0.0000, 0.0000, 270.0000);
	b54=CreateObject(3374, -261.887634, -1344.546875, 10.723221, 0.0000, 0.0000, 270.0000);
	b55=CreateObject(3374, -262.028656, -1344.613403, 13.723221, 0.0000, 0.0000, 270.0000);
	b56=CreateObject(3374, -257.896515, -1344.483154, 10.693247, 0.0000, 0.0000, 270.0000);
	b57=CreateObject(3374, -258.005280, -1344.558716, 13.693247, 0.0000, 0.0000, 270.0000);
	b58=CreateObject(3374, -254.399490, -1344.516113, 10.660328, 0.0000, 0.0000, 270.0000);
	b59=CreateObject(3374, -254.505493, -1344.540161, 13.660328, 0.0000, 0.0000, 270.0000);
	b60=CreateObject(3374, -254.105255, -1340.564575, 10.838885, 0.0000, 0.0000, 0.0000);
	b61=CreateObject(3374, -253.964218, -1340.517456, 13.838885, 0.0000, 0.0000, 0.0000);
	b62=CreateObject(3374, -254.104736, -1336.578613, 10.900655, 0.0000, 0.0000, 0.0000);
	b63=CreateObject(3374, -253.961823, -1336.545410, 13.900655, 0.0000, 0.0000, 0.0000);
	b64=CreateObject(3374, -254.016144, -1332.556396, 10.966618, 0.0000, 0.0000, 0.0000);
	b65=CreateObject(3374, -253.733963, -1332.748535, 13.966618, 0.0000, 0.0000, 0.0000);
	b66=CreateObject(3374, -253.901657, -1328.489258, 11.053417, 0.0000, 0.0000, 0.0006);
	b67=CreateObject(3374, -253.649292, -1328.628174, 14.053417, 0.0000, 0.0000, 0.0006);
	b68=CreateObject(3374, -253.851944, -1324.550171, 11.190798, 0.0000, 0.0000, 0.0006);
	b69=CreateObject(3374, -253.828629, -1324.610474, 13.990801, 0.0000, 0.0000, 0.0006);
	b70=CreateObject(3374, -253.983261, -1320.699341, 11.061488, 0.0000, 0.0000, 90.0006);
	b71=CreateObject(3374, -253.853516, -1320.731201, 14.061488, 0.0000, 0.0000, 90.0006);
	b72=CreateObject(3374, -257.960785, -1320.766357, 11.021676, 0.0000, 0.0000, 90.0007);
	b73=CreateObject(3374, -257.950134, -1320.730957, 14.021676, 0.0000, 0.0000, 90.0007);
	b74=CreateObject(3374, -262.076019, -1320.699341, 11.181780, 0.0000, 0.0000, 90.0007);
	b75=CreateObject(3374, -261.937805, -1320.434570, 14.181780, 0.0000, 0.0000, 90.0007);
	b76=CreateObject(3374, -266.097504, -1320.537842, 11.201214, 0.0000, 0.0000, 90.0007);
	b77=CreateObject(3374, -265.983917, -1320.375732, 14.201214, 0.0000, 0.0000, 90.0007);
	b78=CreateObject(3374, -270.115204, -1320.556519, 11.392005, 0.0000, 0.0000, 90.0007);
	b79=CreateObject(3374, -270.016602, -1320.190063, 14.392005, 0.0000, 0.0000, 90.0007);
	b80=CreateObject(3374, -274.051697, -1320.429810, 11.391057, 0.0000, 0.0000, 90.0007);
	b81=CreateObject(3374, -273.910309, -1320.303711, 14.391057, 0.0000, 0.0000, 90.0007);
	b82=CreateObject(3374, -277.697937, -1320.444824, 11.361448, 0.0000, 0.0000, 90.0007);
	b83=CreateObject(3374, -277.673340, -1320.363281, 14.361448, 0.0000, 0.0000, 90.0007);
	b84=CreateObject(3374, -253.887772, -1320.365112, 17.111488, 0.0000, 0.0000, 90.0008);
	b85=CreateObject(3374, -257.930817, -1320.554565, 17.096674, 0.0000, 0.0000, 90.0009);
	b86=CreateObject(3374, -261.913300, -1320.289551, 16.981783, 0.0000, 0.0000, 90.0009);
	b87=CreateObject(3374, -265.948944, -1320.214478, 16.901218, 0.0000, 0.0000, 90.0009);
	b88=CreateObject(3374, -270.020599, -1320.296021, 16.942013, 0.0000, 0.0000, 90.0009);
	b89=CreateObject(3374, -274.138824, -1320.541748, 17.116060, 0.0000, 0.0000, 90.0007);
	b90=CreateObject(3374, -277.596558, -1320.281982, 17.086452, 0.0000, 0.0000, 90.0007);
	b91=CreateObject(3374, -277.561462, -1344.501587, 16.798084, 0.0000, 0.0000, 270.0000);
	b92=CreateObject(3374, -273.556091, -1344.497681, 16.769636, 0.0000, 0.0000, 270.0000);
	b93=CreateObject(3374, -270.005981, -1344.456177, 16.731487, 0.0000, 0.0000, 270.0008);
	b94=CreateObject(3374, -266.096344, -1344.583862, 16.731573, 0.0000, 0.0000, 270.0008);
	b95=CreateObject(3374, -262.114899, -1344.577271, 16.723221, 0.0000, 0.0000, 270.0008);
	b96=CreateObject(3374, -258.093079, -1344.532837, 16.693247, 0.0000, 0.0000, 270.0008);
	b97=CreateObject(3374, -254.530106, -1344.451538, 16.660328, 0.0000, 0.0000, 270.0008);
	b98=CreateObject(3374, -254.031967, -1340.584717, 16.838886, 0.0000, 0.0000, 0.0009);
	b99=CreateObject(3374, -253.855865, -1336.650391, 16.900654, 0.0000, 0.0000, 0.0009);
	b100=CreateObject(3374, -253.691299, -1332.604248, 16.966618, 0.0000, 0.0000, 0.0009);
	b101=CreateObject(3374, -253.527618, -1328.555420, 17.053417, 0.0000, 0.0000, 0.0009);
	b102=CreateObject(3374, -253.646637, -1324.512207, 16.990801, 0.0000, 0.0000, 0.0009);
	b103=CreateObject(3374, -274.079407, -1336.416260, 16.895048, 0.0000, 0.0000, 0.0006);
	b104=CreateObject(3374, -273.797028, -1338.688110, 16.997570, 0.0000, 0.0000, 0.0006);
	b105=CreateObject(3374, -259.957092, -1336.735107, 17.073521, 0.0000, 0.0000, 270.0006);
	b106=CreateObject(3374, -253.839874, -1320.359009, 20.111488, 0.0000, 0.0000, 90.0007);
	b107=CreateObject(3374, -254.508026, -1344.581543, 19.660328, 0.0000, 0.0000, 270.0008);
	b108=CreateObject(3374, -266.126099, -1316.526367, 9.855675, 0.0000, 0.0000, 90.0007);
	b109=CreateObject(3374, -266.280060, -1312.304443, 10.209438, 0.0000, 0.0000, 90.0007);
	b110=CreateObject(3374, -266.311951, -1308.532349, 10.129108, 0.0000, 0.0000, 90.0007);
	b111=CreateObject(3374, -266.193268, -1316.263794, 12.805676, 0.0000, 0.0000, 90.0007);
	b112=CreateObject(3374, -266.362183, -1312.177246, 13.109440, 0.0000, 0.0000, 90.0007);
	b113=CreateObject(1318, -364.866333, -1395.623169, 20.929628, 0.0000, 0.0000, 0.0000);
	b114=CreateObject(3374, -277.807678, -1324.502075, 8.364038, 0.0000, 0.0000, 180.0000);
	b115=CreateObject(3374, -277.837616, -1324.477783, 11.364038, 0.0000, 0.0000, 180.0000);
	b116=CreateObject(3374, -277.798828, -1328.427368, 11.293514, 0.0000, 0.0000, 180.0000);
	b117=CreateObject(3374, -277.752777, -1332.404541, 11.248959, 0.0000, 0.0000, 180.0000);
	b118=CreateObject(3374, -277.636261, -1336.444946, 11.122874, 0.0000, 0.0000, 180.0000);
	b119=CreateObject(3374, -277.406219, -1340.322144, 11.063190, 0.0000, 0.0000, 180.0000);
	b120=CreateObject(3374, -277.876678, -1324.560059, 14.364038, 0.0000, 0.0000, 180.0000);
	b121=CreateObject(3374, -277.850616, -1328.369263, 14.293514, 0.0000, 0.0000, 180.0000);
	b122=CreateObject(3374, -277.750214, -1332.356323, 14.248959, 0.0000, 0.0000, 180.0000);
	b123=CreateObject(3374, -277.681000, -1336.450317, 14.122874, 0.0000, 0.0000, 180.0000);
	b124=CreateObject(3374, -277.544006, -1340.454590, 14.063190, 0.0000, 0.0000, 180.0000);
	b125=CreateObject(3374, -278.084717, -1324.631714, 17.089043, 0.0000, 0.0000, 180.0006);
	b126=CreateObject(3374, -278.074554, -1328.483887, 17.118517, 0.0000, 0.0000, 180.0006);
	b127=CreateObject(3374, -278.063660, -1332.452026, 17.023962, 0.0000, 0.0000, 180.0006);
	b128=CreateObject(3374, -277.883667, -1336.391968, 17.122875, 0.0000, 0.0000, 180.0006);
	b129=CreateObject(3374, -277.663147, -1340.556519, 17.063190, 0.0000, 0.0000, 180.0006);
	b130=CreateObject(3374, -261.994171, -1320.423340, 19.981783, 0.0000, 0.0000, 90.0006);
	b131=CreateObject(3374, -269.940216, -1320.421753, 19.942013, 0.0000, 0.0000, 90.0007);
	b132=CreateObject(3374, -277.600525, -1320.405396, 20.086452, 0.0000, 0.0000, 90.0009);
	b133=CreateObject(3374, -253.674194, -1328.533447, 20.053417, 0.0000, 0.0000, 0.0007);
	b134=CreateObject(3374, -254.006134, -1336.603516, 19.900654, 0.0000, 0.0000, 0.0007);
	b135=CreateObject(3374, -262.106873, -1344.575684, 19.723221, 0.0000, 0.0000, 270.0007);
	b136=CreateObject(3374, -269.714600, -1344.600342, 19.731487, 0.0000, 0.0000, 270.0007);
	b137=CreateObject(3374, -277.563232, -1344.633789, 19.798084, 0.0000, 0.0000, 270.0007);
	b138=CreateObject(3374, -278.129486, -1328.491455, 20.118517, 0.0000, 0.0000, 180.0009);
	b139=CreateObject(3374, -278.143280, -1336.280151, 20.122875, 0.0000, 0.0000, 180.0009);
	b140=CreateObject(3374, -253.868347, -1332.515015, 8.147121, 0.0000, 0.0000, 0.0000);
	b141=CreateObject(3374, -266.289276, -1316.327515, 15.805676, 0.0000, 0.0000, 90.0007);
	b142=CreateObject(3374, -269.476196, -1362.841309, 9.914375, 0.0000, 0.0000, 89.9998);
	b143=CreateObject(3374, -277.405975, -1366.923340, 10.320328, 0.0000, 0.0000, 179.9998);
	b144=CreateObject(3374, -277.500854, -1370.857910, 10.515165, 0.0000, 0.0000, 269.9998);
	b145=CreateObject(3374, -273.555969, -1370.901367, 10.513641, 0.0000, 0.0000, 269.9998);
	b146=CreateObject(3374, -273.460815, -1362.894775, 9.969217, 0.0000, 0.0000, 89.9998);
	b147=CreateObject(3374, -277.408386, -1362.933838, 10.049191, 0.0000, 0.0000, 89.9998);
	b148=CreateObject(3374, -277.490692, -1366.890747, 13.020332, 0.0000, 0.0000, 179.9998);
	b149=CreateObject(3374, -269.457306, -1366.923706, 10.286041, 0.0000, 0.0000, 359.9998);
	b150=CreateObject(3374, -277.526245, -1363.068604, 13.049191, 0.0000, 0.0000, 89.9998);
	b151=CreateObject(3374, -269.539246, -1370.845825, 10.514158, 0.0000, 0.0000, 269.9998);
	b152=CreateObject(3374, -277.422760, -1370.790527, 13.140171, 0.0000, 0.0000, 269.9998);
	b153=CreateObject(3374, -273.684723, -1362.900024, 12.969217, 0.0000, 0.0000, 89.9998);
	b154=CreateObject(3374, -269.565582, -1362.806274, 12.914375, 0.0000, 0.0000, 89.9998);
	b155=CreateObject(3374, -269.525299, -1366.837402, 12.986046, 0.0000, 0.0000, 359.9998);
	b156=CreateObject(3374, -269.538452, -1370.828247, 13.189163, 0.0000, 0.0000, 269.9998);
	b157=CreateObject(3374, -273.595764, -1370.936035, 12.963650, 0.0000, 0.0000, 269.9998);
	b158=CreateObject(3374, -277.490448, -1362.919312, 16.049191, 0.0000, 0.0000, 89.9999);
	b159=CreateObject(3374, -273.591217, -1362.960083, 15.969217, 0.0000, 0.0000, 89.9999);
	b160=CreateObject(3374, -269.644440, -1362.928955, 15.914375, 0.0000, 0.0000, 89.9998);
	b161=CreateObject(3374, -269.588501, -1366.915649, 15.986046, 0.0000, 0.0000, 359.9998);
	b162=CreateObject(3374, -269.587128, -1370.815674, 16.189163, 0.0000, 0.0000, 269.9999);
	b163=CreateObject(3374, -273.587067, -1370.975464, 15.963650, 0.0000, 0.0000, 269.9999);
	b164=CreateObject(3374, -277.470886, -1370.986450, 16.140171, 0.0000, 0.0000, 269.9999);
	b165=CreateObject(3374, -277.375519, -1366.960571, 16.020332, 0.0000, 0.0000, 179.9999);
	b166=CreateObject(3374, -277.333771, -1367.006226, 19.020332, 0.0000, 0.0000, 179.9999);
	b167=CreateObject(3374, -277.456696, -1370.983032, 19.140171, 0.0000, 0.0000, 269.9999);
	b168=CreateObject(3374, -273.495758, -1370.973755, 18.963650, 0.0000, 0.0000, 269.9999);
	b169=CreateObject(3374, -269.476379, -1370.966553, 19.114164, 0.0000, 0.0000, 269.9999);
	b170=CreateObject(3374, -269.592926, -1367.050659, 18.986046, 0.0000, 0.0000, 359.9999);
	b171=CreateObject(3374, -269.657623, -1363.085205, 18.914375, 0.0000, 0.0000, 89.9998);
	b172=CreateObject(3374, -273.693298, -1363.013062, 18.969217, 0.0000, 0.0000, 89.9998);
	b173=CreateObject(3374, -277.605804, -1362.917725, 19.049191, 0.0000, 0.0000, 89.9998);
	b174=CreateObject(3374, -273.697388, -1348.433228, 16.689644, 0.0000, 0.0000, 89.9998);
	b175=CreateObject(3374, -273.723938, -1352.382202, 16.863255, 0.0000, 0.0000, 89.9998);
	b176=CreateObject(3374, -273.707458, -1356.327026, 16.923119, 0.0000, 0.0000, 89.9998);
	b177=CreateObject(3374, -273.656952, -1360.037109, 18.698137, 0.0000, 0.0000, 89.9998);
	b178=CreateObject(3374, -269.726837, -1363.061279, 21.914375, 0.0000, 0.0000, 89.9999);
	b179=CreateObject(3374, -269.658112, -1370.946167, 22.114164, 0.0000, 0.0000, 89.9999);
	b180=CreateObject(3374, -277.369690, -1370.938232, 22.140171, 0.0000, 0.0000, 89.9999);
	b181=CreateObject(3374, -277.623993, -1362.916870, 22.049191, 0.0000, 0.0000, 89.9999);
	b182=CreateObject(3374, -273.419800, -1367.084717, 18.939613, 0.0000, 0.0000, 89.9999);
	b183=CreateObject(3374, -277.757599, -1332.360229, 8.102072, 0.0000, 0.0000, 179.9998);
	return 1;
}

	if(strcmp(cmdtext, "/forfarmers", true) == 0)

{
SendClientMessage(playerid,COLOR_GREEN, "Pour acceder au fort farmers, choisissez un camp:");
SendClientMessage(playerid,COLOR_ORANGE, "Tapez /fordefend pour defendre le fort.");
SendClientMessage(playerid,COLOR_ORANGE, "Ou tapez /forattack pour attaquer le fort.");
SendClientMessage(playerid,COLOR_ORANGE, "Pour parler que à votre équipe, faites : /t [VotreMessage]");
SendClientMessage(playerid,COLOR_ORANGE, "Si le fort est détruit, tapez /reconst pour le reconstruire.");
SendClientMessage(playerid,COLOR_GREEN, "Pour quitter le dm tapez : /dmq, good game !");


return 1;
}



	if(strcmp(cmdtext, "/katana", true) == 0)

{
AttachObjectToPlayer(katana, playerid, -0.05, 0.25, 0.4, -60, 20, 0);
return 1;
}


	if (strcmp("/peren", cmdtext, true, 10) == 0)
        {
		if(dm2s[playerid] == 1)
		return SendClientMessage(playerid, YELLOW, "Vous ne pouvez pas utiliser cette commande, tapez /dmq pour sortir du dm.");
        if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, 0x33AA33AA, "Vous êtes déja dans un véhicule.");
        new Float:x,Float:y,Float:z,Float:a,carid;
        GetPlayerPos(playerid,x,y,z);
        GetPlayerFacingAngle(playerid,a);
        carid = CreateVehicle(404,x,y,z,a,-1,-1,50000);
		PutPlayerInVehicle(playerid,carid,0);
		TogglePlayerControllable(playerid,1);
		if(GetPlayerInterior(playerid)) LinkVehicleToInterior(carid,GetPlayerInterior(playerid));
		SetVehicleVirtualWorld(carid,GetPlayerVirtualWorld(playerid));
		return 1;
}

	if (strcmp("/smoke", cmdtext, true, 4) == 0) {
          ApplyAnimation(playerid,"SMOKING", "M_smklean_loop", 4.0, 0, 0, 0, 0, 0); // Smoke
          SendClientMessage(playerid, 0xFF0000FF, "Fumer n'est pas bon pour la santé!");
		  return 1;
}

	if (strcmp("/death", cmdtext, true) == 0) {
          ApplyAnimation(playerid, "WUZI", "CS_Dead_Guy", 4.0, 0, 0, 0, 0, 0); // Dead Crawling
          SendClientMessage(playerid, 0xFF0000FF, "Vous faites le mort.");
		  return 1;
}

	if (strcmp("/vomit", cmdtext, true) == 0) {
	      ApplyAnimation(playerid, "FOOD", "EAT_Vomit_P", 3.0, 0, 0, 0, 0, 0); // Vomit BAH!
          SendClientMessage(playerid, 0xFF0000FF, "Vous vomissez. Berk...");
		  return 1;
}
	// Eat Burger
	if (strcmp("/eat", cmdtext, true) == 0) {
	      ApplyAnimation(playerid, "FOOD", "EAT_Burger", 3.00, 0, 0, 0, 0, 0); // Eat Burger
          SendClientMessage(playerid, 0xFF0000FF, "Vous mangez un hamburger.");
		  return 1;
}

	if (strcmp("/regina", cmdtext, true, 10) == 0)
        {
        if(dm2s[playerid] == 1)
		return SendClientMessage(playerid, YELLOW, "Vous ne pouvez pas utiliser cette commande, tapez /dmq pour sortir du dm.");
        if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, 0x33AA33AA, "Vous êtes déja dans un véhicule.");
        new Float:x,Float:y,Float:z,Float:a,carid;
        GetPlayerPos(playerid,x,y,z);
        GetPlayerFacingAngle(playerid,a);
        carid = CreateVehicle(479,x,y,z,a,-1,-1,50000);
		PutPlayerInVehicle(playerid,carid,0);
		TogglePlayerControllable(playerid,1);
		if(GetPlayerInterior(playerid)) LinkVehicleToInterior(carid,GetPlayerInterior(playerid));
		SetVehicleVirtualWorld(carid,GetPlayerVirtualWorld(playerid));
		return 1;
}

	if (strcmp(cmdtext, "/cross2", true) == 0)
{
	 if(dm2s[playerid] == 1)
     return SendClientMessage(playerid, YELLOW, "Vous ne pouvez pas utiliser cette commande, tapez /dmq pour sortir du dm.");
     SetPlayerInterior(playerid, 4);
     SetPlayerFacingAngle(playerid, 84.6050 );
     SetPlayerPos(playerid,-1424.6003,-664.2609,1059.8308);
     GetPlayerName(playerid, playername, sizeof(playername));
	 format(string, sizeof(string), " %s viens d'entrer dans la zone: /cross2",playername);
	 SendClientMessageToAll(LIGHTGREEN, string);
     return 1;
}

	if (strcmp(cmdtext, "/chambre", true) == 0)
{
	 if(dm2s[playerid] == 1)
	 return SendClientMessage(playerid, YELLOW, "Vous ne pouvez pas utiliser cette commande, tapez /dmq pour sortir du dm.");
     SetPlayerInterior(playerid, 12);
     SetPlayerFacingAngle(playerid, 106);
     SetPlayerPos(playerid,2324.33, -1144.79,1050.71);
     SendClientMessage(playerid, 0xFFFF00AA, "Bienvenue à la chambre !");
     return 1;
}

	if(strcmp(cmdtext, "/motoin", true) == 0)
{
if(dm2s[playerid] == 1)
return SendClientMessage(playerid, YELLOW, "Vous ne pouvez pas utiliser cette commande, tapez /dmq pour sortir du dm.");
SetPlayerFacingAngle(playerid, 351.4688);
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid,942.8413,-1766.9431,13.9320);
GameTextForPlayer(playerid,"Take a nrg invisible",2000,5);
SendClientMessage(playerid, COLOR_ORANGE, "Prends une moto invsible, il y en a quelques une devant toi ;)");
if(IsPlayerInAnyVehicle(playerid))
{
new VehicleID;
VehicleID = GetPlayerVehicleID(playerid);
SetVehiclePos(VehicleID,947.1976,-1768.1875,14.0393);
}
return 1;
}


	if (strcmp(cmdtext, "/rc", true) == 0)
{
     if(dm2s[playerid] == 1)
	 return SendClientMessage(playerid, YELLOW, "Vous ne pouvez pas utiliser cette commande, tapez /dmq pour sortir du dm.");
     SetPlayerInterior(playerid, 10);
     SetPlayerFacingAngle(playerid, 55);
     SetPlayerPos(playerid,  -975.5766, 1061.1312, 1345.6719);
     GameTextForPlayer(playerid,"Bienvenue a RC !",2000,5);
     GetPlayerName(playerid, playername, sizeof(playername));
	 format(string, sizeof(string), " %s viens d'entrer dans la zone: /rc",playername);
	 SendClientMessageToAll(LIGHTGREEN, string);
     return 1;
}

	if (strcmp(cmdtext, "/derby", true) == 0)
{
	 if(dm2s[playerid] == 1)
	 return SendClientMessage(playerid, YELLOW, "Vous ne pouvez pas utiliser cette commande, tapez /dmq pour sortir du dm.");
	 derby[playerid] = 1;
	 dm2s[playerid] = 1;
	 if(dm2s[playerid] == 1)
     SetPlayerInterior(playerid, 15);
     SetPlayerFacingAngle(playerid, 55);
     SetPlayerPos(playerid,  -1394.20, 987.62, 1023.96);
     GameTextForPlayer(playerid,"Bienvenue au DERBY ! !",2000,5);
     GetPlayerName(playerid, playername, sizeof(playername));
	 format(string, sizeof(string), " %s viens d'entrer dans la zone: /derby",playername);
  	 SendClientMessageToAll(LIGHTGREEN, string);
     return 1;
}

	if (strcmp(cmdtext, "/dmvitre", true) == 0)
{
	 if(dm2s[playerid] == 1)
	 return SendClientMessage(playerid, YELLOW, "Vous ne pouvez pas utiliser cette commande, tapez /dmq pour sortir du dm.");
	 dmvitre[playerid] = 1;
	 dm2s[playerid] = 1;
     SetPlayerInterior(playerid, 0);
     SetPlayerFacingAngle(playerid, 55);
     SetPlayerArmour(playerid,100);
     SetPlayerPos(playerid,  2690.9480, -2426.6470, 1000.1874);

     GetPlayerName(playerid, playername, sizeof(playername));
	 format(string, sizeof(string), " %s viens d'entrer dans la zone: /dmvitre",playername);
  	 SendClientMessageToAll(LIGHTGREEN, string);



     return 1;
}

	if (strcmp(cmdtext, "/stunt3", true) == 0)
{
	 if(dm2s[playerid] == 1)
	 return SendClientMessage(playerid, YELLOW, "Vous ne pouvez pas utiliser cette commande, tapez /dmq pour sortir du dm.");
     SetPlayerInterior(playerid, 14);
     SetPlayerFacingAngle(playerid, 55);
     SetPlayerPos(playerid,   -1410.72, 1591.16, 1052.53 );
     GameTextForPlayer(playerid,"Bienvenue a STUNT3 !",2000,5);
     GetPlayerName(playerid, playername, sizeof(playername));
     format(string, sizeof(string), " %s viens d'entrer dans la zone: /stunt3",playername);
     SendClientMessageToAll(LIGHTGREEN, string);
     return 1;
}

	if(strcmp(cmdtext, "/white", true) == 0)
	{
	if(IsPlayerAdmin(playerid))
	SetPlayerColor(playerid, 0xFFFFFFAA);
	return 1;
	}

	if(strcmp(cmdtext, "/stunt4", true) == 0)
{
if(dm2s[playerid] == 1)
return SendClientMessage(playerid, YELLOW, "Vous ne pouvez pas utiliser cette commande, tapez /dmq pour sortir du dm.");
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid,1708.091675, -1176.772827, 1849.488770);
GameTextForPlayer(playerid,"Bienvenue a Stunt4 !",2000,5);
GetPlayerName(playerid, playername, sizeof(playername));
format(string, sizeof(string), " %s viens d'entrer dans la zone: /stunt4",playername);
SendClientMessageToAll(LIGHTGREEN, string);
if(IsPlayerInAnyVehicle(playerid))
{
new VehicleID;
VehicleID = GetPlayerVehicleID(playerid);
SetVehiclePos(VehicleID,1723.312744, -1176.233398, 1849.488770);
}
return 1;
}


	if(strcmp(cmdtext, "/island", true) == 0)
{
if(dm2s[playerid] == 1)
return SendClientMessage(playerid, YELLOW, "Vous ne pouvez pas utiliser cette commande, tapez /dmq pour sortir du dm.");
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid,-3009.220703, -2581.659424, 1.070389);
GameTextForPlayer(playerid,"Bienvenue au Dm Island !",2000,5);
GetPlayerName(playerid, playername, sizeof(playername));
format(string, sizeof(string), " %s viens d'entrer dans la zone: /island",playername);
SendClientMessageToAll(LIGHTGREEN, string);
if(IsPlayerInAnyVehicle(playerid))
{
new VehicleID;
VehicleID = GetPlayerVehicleID(playerid);
SetVehiclePos(VehicleID,-3009.220703, -2781.659424, 0.913389);
}
return 1;
}


	new command[256];
	new space;
	space = strfind(cmdtext, " ", true, 0);
	if(space == -1)
	{
    space = strlen(cmdtext);
	}
	strmid(command, cmdtext, 0, space, sizeof(command));

	if(strcmp(command, "/invisible", true) == 0)
		{
			if(IsPlayerAdmin(playerid))
		    SetPlayerColor(playerid, 0xFFFFFF00);
		    SendClientMessage(playerid, COLOR_WHITE, "Vous êtes invisible!");
		    return 1;
		}

	if(strcmp(cmdtext, "/airport", true) == 0)
{
if(dm2s[playerid] == 1)
return SendClientMessage(playerid, YELLOW, "Vous ne pouvez pas utiliser cette commande, tapez /dmq pour sortir du dm.");
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid,-1272.883667, 22.905991, 13.466618);
GameTextForPlayer(playerid,"Bienvenue a Airport",2000,5);
GetPlayerName(playerid, playername, sizeof(playername));
format(string, sizeof(string), " %s viens d'entrer dans la zone: /airport",playername);
SendClientMessageToAll(LIGHTGREEN, string);
if(IsPlayerInAnyVehicle(playerid))
{
new VehicleID;
VehicleID = GetPlayerVehicleID(playerid);
SetVehiclePos(VehicleID,-1268.895142, 19.057495, 13.466618);
}
return 1;
}


	if(strcmp(cmdtext, "/hobby", true) == 0)
{
if(dm2s[playerid] == 1)
return SendClientMessage(playerid, YELLOW, "Vous ne pouvez pas utiliser cette commande, tapez /dmq pour sortir du dm.");
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid,-2797.220947,-1527.677979,138.733398);
GameTextForPlayer(playerid,"Bienvenue a HOBBY",2000,5);
GetPlayerName(playerid, playername, sizeof(playername));
format(string, sizeof(string), " %s viens d'entrer dans la zone: /hobby",playername);
SendClientMessageToAll(LIGHTGREEN, string);
if(IsPlayerInAnyVehicle(playerid))
{
new VehicleID;
VehicleID = GetPlayerVehicleID(playerid);
SetVehiclePos(VehicleID,-2797.513672,-1521.045288,138.668549);
}
return 1;
}



	if(strcmp(cmdtext, "/desert", true) == 0)
{
if(dm2s[playerid] == 1)
return SendClientMessage(playerid, YELLOW, "Vous ne pouvez pas utiliser cette commande, tapez /dmq pour sortir du dm.");
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid,348.407715, 2533.216797, 16.065739);
GameTextForPlayer(playerid,"BIENVENUE DANS LE DESERT",2000,5);
GetPlayerName(playerid, playername, sizeof(playername));
format(string, sizeof(string), " %s viens d'entrer dans la zone: /desert",playername);
SendClientMessageToAll(LIGHTGREEN, string);
if(IsPlayerInAnyVehicle(playerid))
{
new VehicleID;
VehicleID = GetPlayerVehicleID(playerid);
SetVehiclePos(VehicleID,354.840240, 2532.480713, 16.034321);
}
return 1;
}

	if(strcmp(cmdtext, "/amorce", true) == 0)
        {
                GetPlayerPos (playerid, X, Y, Z);
                if (X<1226.3099 || X>1227.3099 || Y<-808.9751 || Y>-807.9751)
                {
                SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous ne pouvez pas utiliser cette commande.");
                }
					else {
exmanoir[playerid] ++;
if(exmanoir[playerid] > 3)
{
SendClientMessage(playerid, COLOR_RED, "Vous ne pouvez pas utiliser cette commande plus de 3 fois par DM.");
}
if(exmanoir[playerid] <= 3)
{
GetPlayerName(playerid, playername, sizeof(playername));
format(string, sizeof(string), "WARNING: %s viens d'activer le détonateur au /manoir, Tout va péter dans 5 secondes !!!", playername);
SendClientMessageToAll(COLOR_BRIGHTRED, string);
SetTimer("bombmanoir",7000,0);
}
                    }

                return 1;
        }

	if (strcmp(cmdtext, "/manoir", true) == 0)
{
	 if(dm2s[playerid] == 1)
	 return SendClientMessage(playerid, YELLOW, "Vous ne pouvez pas utiliser cette commande, tapez /dmq pour sortir du dm.");
   	 dmanoir[playerid] = 1;
	 dm2s[playerid] = 1;
     SetPlayerInterior(playerid, 5);
     SetPlayerFacingAngle(playerid, 55);
     SetPlayerPos(playerid, 1299.14 ,-794.77,1084.00);
     GameTextForPlayer(playerid,"Bienvenue au MANOIR !",2000,5);
     GetPlayerName(playerid, playername, sizeof(playername));
	 format(string, sizeof(string), " %s viens d'entrer dans la zone: /manoir",playername);
	 SendClientMessageToAll(LIGHTGREEN, string);
     return 1;
}


	if(strcmp(cmdtext, "/stadium", true) == 0)
{
if(dm2s[playerid] == 1)
return SendClientMessage(playerid, YELLOW, "Vous ne pouvez pas utiliser cette commande, tapez /dmq pour sortir du dm.");
stadium[playerid] = 1;
dm2s[playerid] = 1;
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid,994.454224, -1251.696167, 651.640198);
GameTextForPlayer(playerid,"Bienvenue au STADIUM",2000,5);
GetPlayerName(playerid, playername, sizeof(playername));
format(string, sizeof(string), " %s viens d'entrer dans la zone: /stadium",playername);
SendClientMessageToAll(LIGHTGREEN, string);
return 1;
}


	if(strcmp(cmdtext, "/stunt", true) == 0)
{
if(dm2s[playerid] == 1)
return SendClientMessage(playerid, YELLOW, "Vous ne pouvez pas utiliser cette commande, tapez /dmq pour sortir du dm.");
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid,-2061.2349,-122.4176,35.3249);
GameTextForPlayer(playerid,"Bienvenue a STUNT",2000,5);
GetPlayerName(playerid, playername, sizeof(playername));
format(string, sizeof(string), " %s viens d'entrer dans la zone: /stunt",playername);
SendClientMessageToAll(LIGHTGREEN, string);
if(IsPlayerInAnyVehicle(playerid))
{
new VehicleID;
VehicleID = GetPlayerVehicleID(playerid);
SetVehiclePos(VehicleID,-2043.115234, -112.268021, 34.529186);
}
return 1;
}

	if(strcmp(cmdtext, "/mistunt", true) == 0)
{
if(dm2s[playerid] == 1)
return SendClientMessage(playerid, YELLOW, "Vous ne pouvez pas utiliser cette commande, tapez /dmq pour sortir du dm.");
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid,
489.254791, 810.100891, 1.013578);
GameTextForPlayer(playerid,"Bienvenue a MISTUNT",2000,5);
GetPlayerName(playerid, playername, sizeof(playername));
format(string, sizeof(string), " %s viens d'entrer dans la zone: /mistunt",playername);
SendClientMessageToAll(LIGHTGREEN, string);
if(IsPlayerInAnyVehicle(playerid))
{
new VehicleID;
VehicleID = GetPlayerVehicleID(playerid);
SetVehiclePos(VehicleID,489.254791, 810.100891, 1.013578);
}
return 1;
}


	if(strcmp(cmdtext, "/race", true) == 0)
{
if(dm2s[playerid] == 1)
return SendClientMessage(playerid, YELLOW, "Vous ne pouvez pas utiliser cette commande, tapez /dmq pour sortir du dm.");
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid,2447.803711, -1859.895630, 466.666779);
GameTextForPlayer(playerid,"Bienvenue a RACE",2000,5);
GetPlayerName(playerid, playername, sizeof(playername));
format(string, sizeof(string), " %s viens d'entrer dans la zone: /race",playername);
SendClientMessageToAll(LIGHTGREEN, string);
if(IsPlayerInAnyVehicle(playerid))
{
new VehicleID;
VehicleID = GetPlayerVehicleID(playerid);
SetVehiclePos(VehicleID,2436.639893, -1861.192383, 466.666779);
}
return 1;
}

	if(strcmp(cmdtext, "/skatepark", true) == 0)
{
if(dm2s[playerid] == 1)
return SendClientMessage(playerid, YELLOW, "Vous ne pouvez pas utiliser cette commande, tapez /dmq pour sortir du dm.");
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid,1919.9288,-1407.8441,13.1372);
GameTextForPlayer(playerid,"Bienvenue au SKATEPARK",2000,5);
if(IsPlayerInAnyVehicle(playerid))
GetPlayerName(playerid, playername, sizeof(playername));
format(string, sizeof(string), " %s viens d'entrer dans la zone: /skatepark",playername);
SendClientMessageToAll(LIGHTGREEN, string);
{
new VehicleID;
VehicleID = GetPlayerVehicleID(playerid);
SetVehiclePos(VehicleID,1922.1769,-1403.2471,13.1538);
}
return 1;
}

	if(strcmp(cmdtext, "/waterstunt", true) == 0)
{
if(dm2s[playerid] == 1)
return SendClientMessage(playerid, YELLOW, "Vous ne pouvez pas utiliser cette commande, tapez /dmq pour sortir du dm.");
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid,-740.5289,1964.9835,-35.7435);
GameTextForPlayer(playerid,"Bienvenue a WATERSTUNT",2000,5);
GetPlayerName(playerid, playername, sizeof(playername));
format(string, sizeof(string), " %s viens d'entrer dans la zone: /waterstunt",playername);
SendClientMessageToAll(LIGHTGREEN, string);
if(IsPlayerInAnyVehicle(playerid))
{
new VehicleID;
VehicleID = GetPlayerVehicleID(playerid);
SetVehiclePos(VehicleID,-756.3792,1974.7317,-34.8270);
}
return 1;
}

	if(strcmp(cmdtext, "/race2", true) == 0)
{
if(dm2s[playerid] == 1)
return SendClientMessage(playerid, YELLOW, "Vous ne pouvez pas utiliser cette commande, tapez /dmq pour sortir du dm.");
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid,1895.845825, -1537.071167, 2.716762);
GameTextForPlayer(playerid,"Bienvenue a RACE 2 !",2000,5);
GetPlayerName(playerid, playername, sizeof(playername));
format(string, sizeof(string), " %s viens d'entrer dans la zone: /race2",playername);
SendClientMessageToAll(LIGHTGREEN, string);
if(IsPlayerInAnyVehicle(playerid))
{
new VehicleID;
VehicleID = GetPlayerVehicleID(playerid);
SetVehiclePos(VehicleID,1891.839478, -1538.872803, 2.707959);
}
return 1;
}


	if(strcmp(cmdtext, "/jump", true) == 0)
{
if(dm2s[playerid] == 1)
return SendClientMessage(playerid, YELLOW, "Vous ne pouvez pas utiliser cette commande, tapez /dmq pour sortir du dm.");
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid,2566.292725, -1309.883545, 777.393616);
GameTextForPlayer(playerid,"Bienvenue a Jump !",2000,5);
GetPlayerName(playerid, playername, sizeof(playername));
format(string, sizeof(string), " %s viens d'entrer dans la zone: /jump",playername);
SendClientMessageToAll(LIGHTGREEN, string);
if(IsPlayerInAnyVehicle(playerid))
{
new VehicleID;
VehicleID = GetPlayerVehicleID(playerid);
SetVehiclePos(VehicleID,2560.656250, -1309.888184, 777.393616);
}
return 1;
}

	if(strcmp(cmdtext, "/laconca", true) == 0)
{
if(dm2s[playerid] == 1)
return SendClientMessage(playerid, YELLOW, "Vous ne pouvez pas utiliser cette commande, tapez /dmq pour sortir du dm.");
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid,2489.430664, 1627.447998, 10.138493);
GameTextForPlayer(playerid,"Bienvenue a laconca!",2000,5);
if(IsPlayerInAnyVehicle(playerid))
GetPlayerName(playerid, playername, sizeof(playername));
format(string, sizeof(string), " %s viens d'entrer dans la zone: /laconca",playername);
SendClientMessageToAll(LIGHTGREEN, string);
{
new VehicleID;
VehicleID = GetPlayerVehicleID(playerid);
SetVehiclePos(VehicleID,2483.718262, 1627.236572, 10.138493);
}
return 1;
}


	if(strcmp(cmdtext, "/dm1", true) == 0)
{
if(dm2s[playerid] == 1)
return SendClientMessage(playerid, YELLOW, "Vous ne pouvez pas utiliser cette commande, tapez /dmq pour sortir du dm.");
dm1[playerid] = 1;
dm2s[playerid] = 1;
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid,1416.8678,2773.6418,10.8203);
GameTextForPlayer(playerid,"Bienvenue au DM1 !",2000,5);
if(IsPlayerInAnyVehicle(playerid))
GetPlayerName(playerid, playername, sizeof(playername));
format(string, sizeof(string), " %s viens d'entrer dans la zone: /dm1",playername);
SendClientMessageToAll(LIGHTGREEN, string);
SendClientMessage(playerid, COLOR_DARKRED, "Pour quitter le dm tape /dmq");
return 1;
}

	if(strcmp(cmdtext, "/boxe", true) == 0)
{
if(dm2s[playerid] == 1)
return SendClientMessage(playerid, YELLOW, "Vous ne pouvez pas utiliser cette commande, tapez /dmq pour sortir du dm.");
SetPlayerInterior(playerid, 0);
boxe[playerid] = 1;
SetPlayerPos(playerid,1325.5791, 1181.2716, 1235.1788);
GameTextForPlayer(playerid,"Bienvenue au club de Boxe !",2000,5);
if(IsPlayerInAnyVehicle(playerid))
GetPlayerName(playerid, playername, sizeof(playername));
format(string, sizeof(string), " %s viens d'entrer dans la zone: /boxe",playername);
SendClientMessageToAll(LIGHTGREEN, string);
return 1;
}

	if(strcmp(cmdtext, "/parking", true) == 0)
{
if(dm2s[playerid] == 1)
return SendClientMessage(playerid, YELLOW, "Vous ne pouvez pas utiliser cette commande, tapez /dmq pour sortir du dm.");
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid,-2040.251587, -97.368607, 34.482243);
GameTextForPlayer(playerid,"PRENDS UN VEHICULE!! ",2000,5);
if(IsPlayerInAnyVehicle(playerid))
{
new VehicleID;
VehicleID = GetPlayerVehicleID(playerid);
SetVehiclePos(VehicleID,-2047.597168, -97.544945, 34.489979);
}
return 1;
}


	if(strcmp(cmdtext, "/race3", true) == 0)
{
if(dm2s[playerid] == 1)
return SendClientMessage(playerid, YELLOW, "Vous ne pouvez pas utiliser cette commande, tapez /dmq pour sortir du dm.");
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid,2560.211426, -1836.466064, 3.001304);
GameTextForPlayer(playerid,"Bienvenue a RACE3 !",2000,5);
GetPlayerName(playerid, playername, sizeof(playername));
format(string, sizeof(string), " %s viens d'entrer dans la zone: /race3",playername);
SendClientMessageToAll(LIGHTGREEN, string);
if(IsPlayerInAnyVehicle(playerid))
{
new VehicleID;
VehicleID = GetPlayerVehicleID(playerid);
SetVehiclePos(VehicleID,2560.439453, -1830.400391, 2.796362);
}
return 1;
}


	if(strcmp(cmdtext, "/ligne", true) == 0)
{
if(dm2s[playerid] == 1)
return SendClientMessage(playerid, YELLOW, "Vous ne pouvez pas utiliser cette commande, tapez /dmq pour sortir du dm.");
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid,1567.9233, -1246.4817, 277.1961);
GameTextForPlayer(playerid,"Bienvenue a LIGNE !",2000,5);
GetPlayerName(playerid, playername, sizeof(playername));
format(string, sizeof(string), " %s viens d'entrer dans la zone: /ligne",playername);
SendClientMessageToAll(LIGHTGREEN, string);
if(IsPlayerInAnyVehicle(playerid))
{
new VehicleID;
VehicleID = GetPlayerVehicleID(playerid);
SetVehiclePos(VehicleID,1580.5262, -1246.6938, 277.1965);
}
return 1;
}

	if(strcmp(cmdtext, "/funstunt", true) == 0)
{
if(dm2s[playerid] == 1)
return SendClientMessage(playerid, YELLOW, "Vous ne pouvez pas utiliser cette commande, tapez /dmq pour sortir du dm.");
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid,1258.135864, -2021.087036, 58.791382);
GameTextForPlayer(playerid,"Bienvenue a FUNSTUNT",2000,5);
GetPlayerName(playerid, playername, sizeof(playername));
format(string, sizeof(string), " %s viens d'entrer dans la zone: /funstunt",playername);
SendClientMessageToAll(LIGHTGREEN, string);
if(IsPlayerInAnyVehicle(playerid))
{
new VehicleID;
VehicleID = GetPlayerVehicleID(playerid);
SetVehiclePos(VehicleID,1264.263794, -2021.366089, 58.616253);
}
return 1;
}

	if( strcmp( cmdtext, "/vertigo", true)==0)
{
if(dm2s[playerid] == 1)
return SendClientMessage(playerid, YELLOW, "Vous ne pouvez pas utiliser cette commande, tapez /dmq pour sortir du dm.");
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid,906.371704, 432.223175, 1303.637207);
GameTextForPlayer(playerid,"Bienvenue a Vertigo",2000,5);
GetPlayerName(playerid, playername, sizeof(playername));
format(string, sizeof(string), " %s viens d'entrer dans la zone: /vertigo",playername);
SendClientMessageToAll(LIGHTGREEN, string);
return 1;
}

	if(strcmp(cmdtext, "/cross", true) == 0)
{
if(dm2s[playerid] == 1)
return SendClientMessage(playerid, YELLOW, "Vous ne pouvez pas utiliser cette commande, tapez /dmq pour sortir du dm.");
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid,-1442.598877, -966.526367, 200.411926);
GameTextForPlayer(playerid,"Bienvenue au CROSS",2000,5);
GetPlayerName(playerid, playername, sizeof(playername));
format(string, sizeof(string), " %s viens d'entrer dans la zone: /cross",playername);
SendClientMessageToAll(LIGHTGREEN, string);
if(IsPlayerInAnyVehicle(playerid))
{
new VehicleID;
VehicleID = GetPlayerVehicleID(playerid);
SetVehiclePos(VehicleID,-1442.900391, -959.951477, 200.434341);
}
return 1;
}



	if(strcmp(cmdtext, "/rally", true) == 0)
{
if(dm2s[playerid] == 1)
return SendClientMessage(playerid, YELLOW, "Vous ne pouvez pas utiliser cette commande, tapez /dmq pour sortir du dm.");
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid,-537.784607, -177.422211, 77.722847);
GameTextForPlayer(playerid,"Bienvenue au RALLY!",2000,5);
GetPlayerName(playerid, playername, sizeof(playername));
format(string, sizeof(string), " %s viens d'entrer dans la zone: /rally",playername);
SendClientMessageToAll(LIGHTGREEN, string);
if(IsPlayerInAnyVehicle(playerid))
{
new VehicleID;
VehicleID = GetPlayerVehicleID(playerid);
SetVehiclePos(VehicleID,-532.703247, -177.900940, 77.722839);
}
return 1;
}

	if(strcmp(cmdtext, "/stunt1", true) == 0)
{
if(dm2s[playerid] == 1)
return SendClientMessage(playerid, YELLOW, "Vous ne pouvez pas utiliser cette commande, tapez /dmq pour sortir du dm.");
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid,314.1865, -1803.2380, 3.8689);
GameTextForPlayer(playerid,"Bienvenue a STUNT1!",2000,5);
GetPlayerName(playerid, playername, sizeof(playername));
format(string, sizeof(string), " %s viens d'entrer dans la zone: /stunt1",playername);
SendClientMessageToAll(LIGHTGREEN, string);
if(IsPlayerInAnyVehicle(playerid))
{
new VehicleID;
VehicleID = GetPlayerVehicleID(playerid);
SetVehiclePos(VehicleID,316.8828, -1797.6747, 3.9303);
}
return 1;
}

	if(strcmp(cmdtext, "/race4", true) == 0)
{
if(dm2s[playerid] == 1)
return SendClientMessage(playerid, YELLOW, "Vous ne pouvez pas utiliser cette commande, tapez /dmq pour sortir du dm.");
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid,528.0999, -2504.0320, 0.3567);
GameTextForPlayer(playerid,"Bienvenue a RACE4!",2000,5);
GetPlayerName(playerid, playername, sizeof(playername));
format(string, sizeof(string), " %s viens d'entrer dans la zone: /race4",playername);
SendClientMessageToAll(LIGHTGREEN, string);
if(IsPlayerInAnyVehicle(playerid))
{
new VehicleID;
VehicleID = GetPlayerVehicleID(playerid);
SetVehiclePos(VehicleID,521.8636, -2505.9272, 0.3567);
}
return 1;
}

	if(strcmp(cmdtext, "/stunt2", true) == 0)
{
if(dm2s[playerid] == 1)
return SendClientMessage(playerid, YELLOW, "Vous ne pouvez pas utiliser cette commande, tapez /dmq pour sortir du dm.");
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid, 1617.509644, -2546.425293, 12.929976);
GameTextForPlayer(playerid,"BIENVENUE A STUNT2 !",2000,5);
GetPlayerName(playerid, playername, sizeof(playername));
format(string, sizeof(string), " %s viens d'entrer dans la zone: /stunt2",playername);
SendClientMessageToAll(LIGHTGREEN, string);
if(IsPlayerInAnyVehicle(playerid))
{
new VehicleID;
VehicleID = GetPlayerVehicleID(playerid);
SetVehiclePos(VehicleID,1600.143311, -2543.844482, 12.865055);
}
return 1;
}

	if(strcmp(cmdtext, "/dm2", true) == 0)
{
if(dm2s[playerid] == 1)
return SendClientMessage(playerid, YELLOW, "Vous ne pouvez pas utiliser cette commande, tapez /dmq pour sortir du dm.");
dm2[playerid] = 1;
dm2s[playerid] = 1;
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid, -939.935242, -340.764435, 720.294983);
GameTextForPlayer(playerid,"BIENVENUE A DM2 !",2000,5);
GetPlayerName(playerid, playername, sizeof(playername));
format(string, sizeof(string), " %s viens d'entrer dans la zone: /dm2",playername);
SendClientMessageToAll(LIGHTGREEN, string);
SendClientMessage(playerid, COLOR_DARKRED, "Pour quitter le dm tape /dmq");
return 1;
}

	if(strcmp(cmdtext, "/dmq", true) == 0)
{
SendClientMessage(playerid, COLOR_BRIGHTRED, "Bonne continuation !");
if(dm2[playerid] == 1)
{
dm2[playerid] = 0;
dm2s[playerid] = 0;
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid,-2040.251587, -97.368607, 34.482243);
}
if(dm1[playerid] == 1)
{
dm1[playerid] = 0;
dm2s[playerid] = 0;
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid,-2040.251587, -97.368607, 34.482243);
}
if(ford[playerid] == 1)
{
ford[playerid] = 0;
dm2s[playerid] = 0;
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid,-2040.251587, -97.368607, 34.482243);
}
if(fora[playerid] == 1)
{
fora[playerid] = 0;
dm2s[playerid] = 0;
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid,-2040.251587, -97.368607, 34.482243);
}
if(stadium[playerid] == 1)
{
stadium[playerid] = 0;
dm2s[playerid] = 0;
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid,-2040.251587, -97.368607, 34.482243);
}
GameTextForPlayer(playerid,"bonne continuation! ",2000,5);
if(IsPlayerInAnyVehicle(playerid))
{
new VehicleID;
VehicleID = GetPlayerVehicleID(playerid);
SetVehiclePos(VehicleID,-2047.597168, -97.544945, 34.489979);
}
if(dmvitre[playerid] == 1)
{
dmvitre[playerid] = 0;
dm2s[playerid] = 0;
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid,-2040.251587, -97.368607, 34.482243);
}
if(derby[playerid] == 1)
{
derby[playerid] = 0;
dm2s[playerid] = 0;
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid,-2040.251587, -97.368607, 34.482243);
}
if(boxe[playerid] == 1)
{
boxe[playerid] = 0;
dm2s[playerid] = 0;
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid,-2040.251587, -97.368607, 34.482243);
}
if(dmanoir[playerid] == 1)
{
exmanoir[playerid] = 0;
dmanoir[playerid] = 0;
dm2s[playerid] = 0;
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid,-2040.251587, -97.368607, 34.482243);
}
return 1;
}

	if(strcmp(cmdtext, "/drift", true) == 0)
{
if(dm2s[playerid] == 1)
return SendClientMessage(playerid, YELLOW, "Vous ne pouvez pas utiliser cette commande, tapez /dmq pour sortir du dm.");
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid, 2315.206787, 1402.235718, 42.138493);
GameTextForPlayer(playerid,"BIENVENUE AU DRIFT !",2000,5);
GetPlayerName(playerid, playername, sizeof(playername));
format(string, sizeof(string), " %s viens d'entrer dans la zone: /drift",playername);
SendClientMessageToAll(LIGHTGREEN, string);
if(IsPlayerInAnyVehicle(playerid))
{
new VehicleID;
VehicleID = GetPlayerVehicleID(playerid);
SetVehiclePos(VehicleID,2325.429443, 1411.019531, 42.138493);
}
return 1;
}

	if(strcmp(cmdtext, "/dm51", true) == 0)
{
if(dm2s[playerid] == 1)
return SendClientMessage(playerid, YELLOW, "Vous ne pouvez pas utiliser cette commande, tapez /dmq pour sortir du dm.");
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid, 215.187515, 1867.106079, 12.458805);
GameTextForPlayer(playerid,"Bienvenue au dm51 !",2000,5);
GetPlayerName(playerid, playername, sizeof(playername));
format(string, sizeof(string), " %s viens d'entrer dans la zone: /dm51",playername);
SendClientMessageToAll(LIGHTGREEN, string);
return 1;
}

	new vehicleid = GetPlayerVehicleID(playerid);
	if(strcmp(cmdtext, "/fullvr", true) == 0)

if (IsPlayerInAnyVehicle(playerid))
{
GivePlayerMoney(playerid,100);
ResprayCar(vehicleid);
return 1;
}

	if(strcmp(cmdtext, "/jump2", true) == 0)
{
if(dm2s[playerid] == 1)
return SendClientMessage(playerid, YELLOW, "Vous ne pouvez pas utiliser cette commande, tapez /dmq pour sortir du dm.");
new cartype = GetPlayerVehicleID(playerid);
new State=GetPlayerState(playerid);
SetPlayerInterior(playerid,0);
{
if(State!=PLAYER_STATE_DRIVER)
{
GetPlayerName(playerid, playername, sizeof(playername));
format(string, sizeof(string), " %s viens d'entrer dans la zone: /jump2",playername);
SendClientMessageToAll(LIGHTGREEN, string);
SetPlayerPos(playerid,-669.7441,2306.3635,135.4752);}
else if(IsPlayerInVehicle(playerid, cartype) == 1)
{
SetVehiclePos(cartype,-669.7441,2306.3635,135.4752);
SetVehicleZAngle(cartype,88.4296);}
else
{
SetPlayerPos(playerid,-669.7441,2306.3635,135.4752);}
GameTextForPlayer(playerid,"bienvenue a Jump2!",2500,3);}
return 1;
}


	if(strcmp(cmdtext, "/tuning", true) == 0)
{
if(dm2s[playerid] == 1)
return SendClientMessage(playerid, YELLOW, "Vous ne pouvez pas utiliser cette commande, tapez /dmq pour sortir du dm.");
new cartype = GetPlayerVehicleID(playerid);
new State=GetPlayerState(playerid);
SetPlayerInterior(playerid,0);
{
if(State!=PLAYER_STATE_DRIVER)
{
SetPlayerPos(playerid,-2693.1226,217.7086,3.7430);}
else if(IsPlayerInVehicle(playerid, cartype) == 1)
{
SetVehiclePos(cartype,-2693.1226,217.7086,3.7430);
SetVehicleZAngle(cartype,92.2370);}
else
{
SetPlayerPos(playerid,-2693.1226,217.7086,3.7430);}
GameTextForPlayer(playerid,"Good Tuning !",2500,3);}
return 1;
}




		//--------------------------------------------TELEPORT transfender
		//1040.7844,-1051.6259,31.4096,359.5718
	if(strcmp(cmdtext, "/trans", true) == 0)
{
if(dm2s[playerid] == 1)
return SendClientMessage(playerid, YELLOW, "Vous ne pouvez pas utiliser cette commande, tapez /dmq pour sortir du dm.");
new cartype = GetPlayerVehicleID(playerid);
new State=GetPlayerState(playerid);
SetPlayerInterior(playerid,0);
{
if(State!=PLAYER_STATE_DRIVER)
{
SetPlayerPos(playerid,1040.7844,-1051.6259,31.4096);}
else if(IsPlayerInVehicle(playerid, cartype) == 1)
{
SetVehiclePos(cartype,1040.7844,-1051.6259,31.4096);
SetVehicleZAngle(cartype,360);}
else
{
SetPlayerPos(playerid,1040.7844,-1051.6259,31.4096);}
GameTextForPlayer(playerid,"Bienvenue au transfender",2500,3);}
return 1;
}


	if(strcmp(cmdtext, "/trans2", true) == 0)
{
if(dm2s[playerid] == 1)
return SendClientMessage(playerid, YELLOW, "Vous ne pouvez pas utiliser cette commande, tapez /dmq pour sortir du dm.");
new cartype = GetPlayerVehicleID(playerid);
new State=GetPlayerState(playerid);
SetPlayerInterior(playerid,0);
{
if(State!=PLAYER_STATE_DRIVER)
{
SetPlayerPos(playerid,2385.7163,1012.6401,10.5273);}
else if(IsPlayerInVehicle(playerid, cartype) == 1)
{
SetVehiclePos(cartype,2385.7163,1012.6401,10.5273);
SetVehicleZAngle(cartype,357.4084);}
else
{
SetPlayerPos(playerid,2385.7163,1012.6401,10.5273);}
GameTextForPlayer(playerid,"Bienvenue au tranfender 2",2500,3);}
return 1;
}


	if(strcmp(cmdtext, "/and", true) == 0)
    {
    if(dm2s[playerid] == 1)
	return SendClientMessage(playerid, YELLOW, "Vous ne pouvez pas utiliser cette commande, tapez /dmq pour sortir du dm.");
    SetPlayerCheckpoint(playerid,315.7353,1035.6589,1945.1191,5.0);
    AddStaticPickup(371,2,315.48,984.13,1959.11);
    SetPlayerInterior(playerid,9);
	SetPlayerPos(playerid,315.48,984.13,1959.11);
	GameTextForPlayer(playerid,"Andromada",1000,1);
	GetPlayerName(playerid, playername, sizeof(playername));
    format(string, sizeof(string), " %s viens d'entrer dans la zone: /and",playername);
    SendClientMessageToAll(LIGHTGREEN, string);
	return 1;
}

	if (strcmp(cmdtext, "/lock", true)==0)
      {
         if(IsPlayerInAnyVehicle(playerid))
         {
         if(GetPlayerVehicleID(playerid) != 1){
            new State=GetPlayerState(playerid);
            if(State!=PLAYER_STATE_DRIVER)
            {
               SendClientMessage(playerid,COLOR_ORANGE,"Seulement le conducteur peut fermer les portes");
               return 1;
            }
            new i;
            for(i=0;i<MAX_PLAYERS;i++)
            {
               if(i != playerid)
               {
                  SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid),i, 0, 1);
               }
            }
            SendClientMessage(playerid, COLOR_GREEN, "Vehicle fermé!");
            new Float:pX, Float:pY, Float:pZ;
            GetPlayerPos(playerid,pX,pY,pZ);
            PlayerPlaySound(playerid,1056,pX,pY,pZ);
         }
         }
         else
         {
            SendClientMessage(playerid, COLOR_ORANGE, "Vous n'êtes pas dans un véhicule!");
		 }
         return 1;
      }
	if (strcmp(cmdtext, "/unlock", true)==0)
   {
      if(IsPlayerInAnyVehicle(playerid))
      {
         new State=GetPlayerState(playerid);
         if(State!=PLAYER_STATE_DRIVER)
         {
            SendClientMessage(playerid,COLOR_ORANGE,"Seulement le conducteur peut ouvrir les portes.");
            return 1;
         }
         new i;
         for(i=0;i<MAX_PLAYERS;i++)
         {
            SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid),i, 0, 0);
         }
         SendClientMessage(playerid, COLOR_GREEN, "Vehicle ouvert!");
         new Float:pX, Float:pY, Float:pZ;
         GetPlayerPos(playerid,pX,pY,pZ);
         PlayerPlaySound(playerid,1057,pX,pY,pZ);
      }
      else
      {
         SendClientMessage(playerid, COLOR_ORANGE, "Vous n'êtes pas dans un véhicule!");
      }
      return 1;
    }



	if( !strcmp(cmdtext,"/vr", true) )
	{

    	if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,COLOR_RED,"ERREUR: Vous n'êtes pas dans un véhicule.");
		SetVehicleHealth(GetPlayerVehicleID(playerid),1000.0);
		return SendClientMessage(playerid,COLOR_YELLOW,"Votre véhicule a été réparé avec succès!");

	}

	if( !strcmp(cmdtext,"/flip", true) )
	{
	    if(IsPlayerInAnyVehicle(playerid)) {

			new Float:Angle,name[24]; GetPlayerName(playerid,name,24); GetVehiclePos(GetPlayerVehicleID(playerid),X,Y,Z); GetVehicleZAngle(GetPlayerVehicleID(playerid),Angle);
			SetVehiclePos(GetPlayerVehicleID(playerid),X,Y,Z+2); SetVehicleZAngle(GetPlayerVehicleID(playerid),Angle);

		} else return SendClientMessage(playerid,COLOR_RED,"ERREUR: Vous n'êtes pas dans un véhicule.");
		return 1;




	}
//----------------------------------Team Chat-----------------------------------
	cmd(gravityplayercmd);
	cmd(teamchatcmd);

    else
	{
		format(string, sizeof(string), "La commande '%s' n'existe pas, pour connaitre les commandes tape : /help.", cmdtext);
		SendClientMessage(playerid, COLOR_SYSTEM, string);
	}
    return 1;
}

//==================================Settings====================================
public Settings()
{
	if (!dini_Exists(FILE_SETTINGS)) {
		dini_Create(FILE_SETTINGS);
		dini_Set(FILE_SETTINGS, "servername", "server");
		dini_IntSet(FILE_SETTINGS, "moneyscan", 1);
		dini_IntSet(FILE_SETTINGS, "maxmoney", 9000000);
		dini_IntSet(FILE_SETTINGS, "register", 1);
		dini_IntSet(FILE_SETTINGS, "maxusers", 2000);
		dini_IntSet(FILE_SETTINGS, "manualsaving", 1);
	}
}
//==================================KeyStateChange==============================
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
if (newkeys & KEY_ANALOG_RIGHT)
{
if (SaveP[playerid] == 1)
{
GetPlayerPos(playerid,Pos[playerid][0],Pos[playerid][1],Pos[playerid][2]);
GetPlayerFacingAngle(playerid,Pos[playerid][3]);
GameTextForPlayer(playerid,"~r~Position Saved",1,1);
GetPlayerPos(playerid,X,Y,Z);
PlayerPlaySound(playerid,1056,X,Y,Z);
RewP[playerid] = 1;
}
}

if (newkeys & KEY_ANALOG_LEFT)
{
if (RewP[playerid] == 1)
{
if(IsPlayerInAnyVehicle(playerid))
{
new Interior = GetPlayerInterior(playerid);SetPlayerInterior(playerid,Interior);
new VehicleID;
GetPlayerPos(playerid, X, Y, Z);
VehicleID = GetPlayerVehicleID(playerid);
SetVehiclePos(VehicleID,Pos[playerid][0],Pos[playerid][1],Pos[playerid][2]);
SetPlayerFacingAngle(playerid,Pos[playerid][3]);
SetCameraBehindPlayer(playerid);
GameTextForPlayer(playerid,"~y~Position Loaded",1,1);
PlayerPlaySound(playerid,1057,X,Y,Z);
}
else{
SetPlayerPos(playerid,Pos[playerid][0],Pos[playerid][1],Pos[playerid][2]);
SetPlayerFacingAngle(playerid,Pos[playerid][3]);
SetCameraBehindPlayer(playerid);
GameTextForPlayer(playerid,"~y~Position Loaded",1,1);
GetPlayerPos(playerid,X,Y,Z);
PlayerPlaySound(playerid,1057,X,Y,Z);}
}
}
return 1;
}
//================================Save System===================================
public SaveData()
{
    new playername[MAX_PLAYER_NAME];

    for (new i=0;i<MAX_PLAYERS;i++) {
	    GetPlayerName(i, playername, MAX_PLAYER_NAME);
	    if (dini_Exists(udb_encode(playername)) && logged[i] == 1) {
			dini_IntSet(udb_encode(playername), "money", GetPlayerMoney(i));
       		PlayerInterior[i] = GetPlayerInterior(i);
       		if(PlayerInterior[i] == 0) {
				new Float:x, Float:y, Float:z;
				GetPlayerPos(i,x,y,z);
      			new Float:a;
 				GetPlayerFacingAngle(i,a);
 				dini_IntSet(udb_encode(playername), "a", floatround(a));
				dini_IntSet(udb_encode(playername), "x", floatround(x));
				dini_IntSet(udb_encode(playername), "y", floatround(y));
				dini_IntSet(udb_encode(playername), "z", floatround(z));
			}
		}
	}

    return 1;
}


//==============================Is Player in Area===============================
public isPlayerInArea(playerID, Float:data[4])
{

	GetPlayerPos(playerID, X, Y, Z);
	if(X >= data[0] && X <= data[2] && Y >= data[1] && Y <= data[3]) {
		return 1;
	}
	return 0;
}
//=============================Gamemode Exit Stuff==============================
public GameModeExitFunc()
{
	GameModeExit();
	return 1;
}
//=================================Team Chat====================================
public GetPlayers() //By rapidZ
{
	new i;
	new player;
	player = 0;
	for (i=0;i<MAX_PLAYERS;i++)
	{
		if(IsPlayerConnected(i))
		{
			player++;
		}
	}
	return player;
}
//=================================OnPlayerPickUpPickup=========================
public OnPlayerPickUpPickup (playerid, pickupid)
{
   new string[256];
   new playername[MAX_PLAYER_NAME];
   if  (pickupid == fleche2)
   {
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid,2690.9480, -2426.6470, 1000.1874);
}
   if  (pickupid == tele1)
   {
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid,2447.803711, -1859.895630, 466.666779);
GameTextForPlayer(playerid,"Bienvenue a RACE",2000,5);
GetPlayerName(playerid, playername, sizeof(playername));
format(string, sizeof(string), " %s viens d'entrer dans la zone: /race",playername);
SendClientMessageToAll(LIGHTGREEN, string);
if(IsPlayerInAnyVehicle(playerid))
{
new VehicleID;
VehicleID = GetPlayerVehicleID(playerid);
SetVehiclePos(VehicleID,2436.639893, -1861.192383, 466.666779);
}
return 1;
   }

   if  (pickupid == tele2)
   {
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid, -939.935242, -340.764435, 720.294983);
GameTextForPlayer(playerid,"BIENVENUE AU DM2 !",2000,5);
GetPlayerName(playerid, playername, sizeof(playername));
format(string, sizeof(string), " %s viens d'entrer dans la zone: /dm2",playername);
SendClientMessageToAll(LIGHTGREEN, string);
return 1;
   }

   if  (pickupid == tele3)
   {
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid,994.454224, -1251.696167, 651.640198);
GameTextForPlayer(playerid,"BIENVENUE AU STADIUM",2000,5);
GetPlayerName(playerid, playername, sizeof(playername));
format(string, sizeof(string), " %s viens d'entrer dans la zone: /stadium",playername);
SendClientMessageToAll(LIGHTGREEN, string);
return 1;
   }

   if  (pickupid == cokt)
   {
   GivePlayerWeapon(playerid,18,10);
   }


   if  (pickupid == flam)
   {
   GivePlayerWeapon(playerid,37,500);
   }


   if  (pickupid == rifle1)
   {
   GivePlayerWeapon(playerid,33,30);
   }
   
   if  (pickupid == menu1)
   {
 ShowMenuForPlayer(teleport,playerid);
 TogglePlayerControllable(playerid,0);
   }

   if  (pickupid == perso1)
   {
 ShowMenuForPlayer(teleport,playerid);
 TogglePlayerControllable(playerid,0);
   }

   if  (pickupid == perso2)
   {
  ShowMenuForPlayer(teleport,playerid);
  TogglePlayerControllable(playerid,0);
   }

   if  (pickupid == perso3)
      {
  ShowMenuForPlayer(teleport,playerid);
  TogglePlayerControllable(playerid,0);
   }

   if  (pickupid == perso4)
   {
 ShowMenuForPlayer(teleport,playerid);
 TogglePlayerControllable(playerid,0);
   }

   if  (pickupid == perso5)
   {
 ShowMenuForPlayer(teleport,playerid);
 TogglePlayerControllable(playerid,0);
   }

   if  (pickupid == perso6)
   {
 ShowMenuForPlayer(teleport,playerid);
 TogglePlayerControllable(playerid,0);
   }

   if  (pickupid == perso7)
   {
 ShowMenuForPlayer(teleport,playerid);
 TogglePlayerControllable(playerid,0);
   }

   if  (pickupid == perso8)
   {
 ShowMenuForPlayer(teleport,playerid);
 TogglePlayerControllable(playerid,0);
   }

   if  (pickupid == perso9)
   {
 ShowMenuForPlayer(teleport,playerid);
 TogglePlayerControllable(playerid,0);
   }

   if  (pickupid == perso10)
   {
 ShowMenuForPlayer(teleport,playerid);
 TogglePlayerControllable(playerid,0);
   }

   if  (pickupid == perso11)
   {
 ShowMenuForPlayer(teleport,playerid);
 TogglePlayerControllable(playerid,0);
   }

   if  (pickupid == perso12)
   {
 ShowMenuForPlayer(teleport,playerid);
 TogglePlayerControllable(playerid,0);
   }

   if  (pickupid == perso13)
   {
 ShowMenuForPlayer(teleport,playerid);
 TogglePlayerControllable(playerid,0);
   }

   if  (pickupid == perso14)
   {
 ShowMenuForPlayer(teleport,playerid);
 TogglePlayerControllable(playerid,0);
   }

   if  (pickupid == perso15)
   {
 ShowMenuForPlayer(teleport,playerid);
 TogglePlayerControllable(playerid,0);
   }

   if  (pickupid == perso16)
   {
 ShowMenuForPlayer(teleport,playerid);
 TogglePlayerControllable(playerid,0);
   }

   if  (pickupid == perso17)
   {
 ShowMenuForPlayer(teleport,playerid);
 TogglePlayerControllable(playerid,0);
   }

   if  (pickupid == perso19)
   {
 ShowMenuForPlayer(teleport,playerid);
 TogglePlayerControllable(playerid,0);
   }

   if  (pickupid == perso20)
   {
 ShowMenuForPlayer(teleport,playerid);
 TogglePlayerControllable(playerid,0);
   }

   if  (pickupid == perso21)
   {
 ShowMenuForPlayer(teleport,playerid);
 TogglePlayerControllable(playerid,0);
   }

   if  (pickupid == perso22)
   {
 ShowMenuForPlayer(teleport,playerid);
 TogglePlayerControllable(playerid,0);
   }

   if  (pickupid == perso23)
   {
 ShowMenuForPlayer(teleport,playerid);
 TogglePlayerControllable(playerid,0);
   }

   if  (pickupid == perso24)
   {
 ShowMenuForPlayer(teleport,playerid);
 TogglePlayerControllable(playerid,0);
   }

   if  (pickupid == perso25)
   {
 ShowMenuForPlayer(teleport,playerid);
 TogglePlayerControllable(playerid,0);
   }

   if  (pickupid == perso26)
   {
 ShowMenuForPlayer(teleport,playerid);
 TogglePlayerControllable(playerid,0);
   }

   if  (pickupid == perso28)
   {
 ShowMenuForPlayer(teleport,playerid);
 TogglePlayerControllable(playerid,0);
   }

   if  (pickupid == perso29)
   {
 ShowMenuForPlayer(teleport,playerid);
 TogglePlayerControllable(playerid,0);
   }

   if  (pickupid == perso30)
   {
 ShowMenuForPlayer(teleport,playerid);
 TogglePlayerControllable(playerid,0);
   }

   if  (pickupid == perso31)
   {
 ShowMenuForPlayer(teleport,playerid);
 TogglePlayerControllable(playerid,0);
   }

   if  (pickupid == perso32)
   {
 ShowMenuForPlayer(teleport,playerid);
 TogglePlayerControllable(playerid,0);
   }

   if  (pickupid == perso33)
   {
 ShowMenuForPlayer(teleport,playerid);
 TogglePlayerControllable(playerid,0);
   }

   if  (pickupid == perso34)
   {
 ShowMenuForPlayer(teleport,playerid);
 TogglePlayerControllable(playerid,0);
   }
   if (pickupid == deto)
{
SendClientMessage(playerid, COLOR_AQUA, "TAPE /AMORCE POUR ACTIVER LE DETONATEUR ET TOUT FAIRE PETER !");
}
   return 1;
}
//=====================================CreerPickup==============================
public CreerPickup ()
{  /* On creer un nouveau pickup */

cokt = CreatePickup (344,2, -2818.0251,-1530.3417,140.8438);
flam = CreatePickup (361,2, -2815.6746,-1519.4891,140.8438);
rifle1 = CreatePickup (357,2, -2813.3518,-1526.7675,140.8438);
}
//=====================================MenusDesIcones==============================
public OnPlayerSelectedMenuRow(playerid, row) {
new string[256];
new playername[MAX_PLAYER_NAME];
new Menu:Current = GetPlayerMenu(playerid); // Si le joueur séléctionne quel que chose du menu.
if (Current == teleport){
if (row == 0){
ShowMenuForPlayer(teleport1,playerid);
} else if (row == 1){
ShowMenuForPlayer(teleport2,playerid);
} else if (row == 2){
ShowMenuForPlayer(teleport3,playerid);
} else if (row == 3){
ShowMenuForPlayer(teleport4,playerid);
}
TogglePlayerControllable(playerid,0); // On défreeze le joueur
}


if (Current == teleport1){
if (row == 0){
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid,-2061.2349,-122.4176,35.3249);
GameTextForPlayer(playerid,"Bienvenue a STUNT",2000,5);
GetPlayerName(playerid, playername, sizeof(playername));
format(string, sizeof(string), " %s viens d'entrer dans la zone: /stunt",playername);
SendClientMessageToAll(LIGHTGREEN, string);
if(IsPlayerInAnyVehicle(playerid))
{
new VehicleID;
VehicleID = GetPlayerVehicleID(playerid);
SetVehiclePos(VehicleID,-2043.115234, -112.268021, 34.529186);
}


} else if (row == 1){
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid,314.1865, -1803.2380, 3.8689);
GameTextForPlayer(playerid,"Bienvenue a STUNT1!",2000,5);
GetPlayerName(playerid, playername, sizeof(playername));
format(string, sizeof(string), " %s viens d'entrer dans la zone: /stunt1",playername);
SendClientMessageToAll(LIGHTGREEN, string);
if(IsPlayerInAnyVehicle(playerid))
{
new VehicleID;
VehicleID = GetPlayerVehicleID(playerid);
SetVehiclePos(VehicleID,316.8828, -1797.6747, 3.9303);
}

} else if (row == 2){
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid, 1617.509644, -2546.425293, 12.929976);
GameTextForPlayer(playerid,"BIENVENUE A STUNT2 !",2000,5);
GetPlayerName(playerid, playername, sizeof(playername));
format(string, sizeof(string), " %s viens d'entrer dans la zone: /stunt2",playername);
SendClientMessageToAll(LIGHTGREEN, string);
if(IsPlayerInAnyVehicle(playerid))
{
new VehicleID;
VehicleID = GetPlayerVehicleID(playerid);
SetVehiclePos(VehicleID,1600.143311, -2543.844482, 12.865055);
}

} else if (row == 3){

     SetPlayerInterior(playerid, 14);
     SetPlayerFacingAngle(playerid, 55);
     SetPlayerPos(playerid,   -1410.72, 1591.16, 1052.53 );
     GameTextForPlayer(playerid,"Bienvenue a STUNT3 !",2000,5);
     GetPlayerName(playerid, playername, sizeof(playername));
     format(string, sizeof(string), " %s viens d'entrer dans la zone: /stunt3",playername);
     SendClientMessageToAll(LIGHTGREEN, string);
}

SendClientMessage(playerid,COLOR_LIGHTBLUE, "Pour voir la suite des téléportations tape: /tele");
TogglePlayerControllable(playerid,1); 
}



if (Current == teleport2){
if (row == 0){
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid,-1442.598877, -966.526367, 200.411926);
GameTextForPlayer(playerid,"Bienvenue a CROSS",2000,5);
GetPlayerName(playerid, playername, sizeof(playername));
format(string, sizeof(string), " %s viens d'entrer dans la zone: /cross",playername);
SendClientMessageToAll(LIGHTGREEN, string);
if(IsPlayerInAnyVehicle(playerid))
{
new VehicleID;
VehicleID = GetPlayerVehicleID(playerid);
SetVehiclePos(VehicleID,-1442.900391, -959.951477, 200.434341);
}

} else if (row == 1){
     SetPlayerInterior(playerid, 4);
     SetPlayerFacingAngle(playerid, 84.6050 );
     SetPlayerPos(playerid,-1424.6003,-664.2609,1059.8308);
     GameTextForPlayer(playerid,"Bienvenue a Cross2 !",2000,5);
     GetPlayerName(playerid, playername, sizeof(playername));
	 format(string, sizeof(string), " %s viens d'entrer dans la zone: /cross2",playername);
	 SendClientMessageToAll(LIGHTGREEN, string);




} else if (row == 2){
     SetPlayerInterior(playerid, 10);
     SetPlayerFacingAngle(playerid, 55);
     SetPlayerPos(playerid,  -975.5766, 1061.1312, 1345.6719);
     GameTextForPlayer(playerid,"Bienvenue a RC !",2000,5);
     GetPlayerName(playerid, playername, sizeof(playername));
	 format(string, sizeof(string), " %s viens d'entrer dans la zone: /rc",playername);
	 SendClientMessageToAll(LIGHTGREEN, string);
}
SendClientMessage(playerid,COLOR_LIGHTBLUE, "Pour voir la suite des téléportations tape: /tele");
TogglePlayerControllable(playerid,1);
}



if (Current == teleport3){
if (row == 0){
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid, -939.935242, -340.764435, 720.294983);
GameTextForPlayer(playerid,"BIENVENUE AU DM2 !",2000,5);
GetPlayerName(playerid, playername, sizeof(playername));
format(string, sizeof(string), " %s viens d'entrer dans la zone: /dm2",playername);
SendClientMessageToAll(LIGHTGREEN, string);

} else if (row == 1){
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid,994.454224, -1251.696167, 651.640198);
GameTextForPlayer(playerid,"Bienvenue au STADIUM",2000,5);
GetPlayerName(playerid, playername, sizeof(playername));
format(string, sizeof(string), " %s viens d'entrer dans la zone: /stadium",playername);
SendClientMessageToAll(LIGHTGREEN, string);

}if (row == 2){
     SetPlayerInterior(playerid, 15);
     SetPlayerFacingAngle(playerid, 55);
     SetPlayerPos(playerid,  -1394.20, 987.62, 1023.96);
     GameTextForPlayer(playerid,"Bienvenue au DERBY ! !",2000,5);
     GetPlayerName(playerid, playername, sizeof(playername));
	 format(string, sizeof(string), " %s viens d'entrer dans la zone: /derby",playername);
  	 SendClientMessageToAll(LIGHTGREEN, string);


} else if (row == 3){
SendClientMessage(playerid,COLOR_GREEN, "Pour acceder au fort farmers, choisissez un camp:");
SendClientMessage(playerid,COLOR_ORANGE, "Tapez /fordefend pour defendre le fort");
SendClientMessage(playerid,COLOR_ORANGE, "Ou tapez /forattack pour attaquer le fort");
SendClientMessage(playerid,COLOR_GREEN, "Pour quitter le dm tape : /dmq, good game !");


}
SendClientMessage(playerid,COLOR_LIGHTBLUE, "Pour voir la suite des téléportations tape: /tele");
TogglePlayerControllable(playerid,1);
}


if (Current == teleport4){
if (row == 0){
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid,2447.803711, -1859.895630, 466.666779);
GameTextForPlayer(playerid,"Bienvenue a RACE",2000,5);
GetPlayerName(playerid, playername, sizeof(playername));
format(string, sizeof(string), " %s viens d'entrer dans la zone: /race",playername);
SendClientMessageToAll(LIGHTGREEN, string);
if(IsPlayerInAnyVehicle(playerid))
{
new VehicleID;
VehicleID = GetPlayerVehicleID(playerid);
SetVehiclePos(VehicleID,2436.639893, -1861.192383, 466.666779);
}

} else if (row == 1){
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid,1895.845825, -1537.071167, 2.716762);
GameTextForPlayer(playerid,"Bienvenue a RACE 2 !",2000,5);
GetPlayerName(playerid, playername, sizeof(playername));
format(string, sizeof(string), " %s viens d'entrer dans la zone: /race2",playername);
SendClientMessageToAll(LIGHTGREEN, string);
if(IsPlayerInAnyVehicle(playerid))
{
new VehicleID;
VehicleID = GetPlayerVehicleID(playerid);
SetVehiclePos(VehicleID,1891.839478, -1538.872803, 2.707959);
}

} else if (row == 2){
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid,2560.211426, -1836.466064, 3.001304);
GameTextForPlayer(playerid,"Bienvenue a RACE3 !",2000,5);
GetPlayerName(playerid, playername, sizeof(playername));
format(string, sizeof(string), " %s viens d'entrer dans la zone: /race3",playername);
SendClientMessageToAll(LIGHTGREEN, string);
if(IsPlayerInAnyVehicle(playerid))
{
new VehicleID;
VehicleID = GetPlayerVehicleID(playerid);
SetVehiclePos(VehicleID,2560.439453, -1830.400391, 2.796362);
}

} else if (row == 3){
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid,528.0999, -2504.0320, 0.3567);
GameTextForPlayer(playerid,"Bienvenue a RACE4!",2000,5);
GetPlayerName(playerid, playername, sizeof(playername));
format(string, sizeof(string), " %s viens d'entrer dans la zone: /race4",playername);
SendClientMessageToAll(LIGHTGREEN, string);
if(IsPlayerInAnyVehicle(playerid))
{
new VehicleID;
VehicleID = GetPlayerVehicleID(playerid);
SetVehiclePos(VehicleID,521.8636, -2505.9272, 0.3567);
}
}
SendClientMessage(playerid,COLOR_LIGHTBLUE, "Pour voir la suite des téléportations tape: /tele");
TogglePlayerControllable(playerid,1);
}

return 1;
}
//=================================OnPlayerStateChange==========================
public OnPlayerStateChange(playerid, newstate, oldstate)

{

	
    if (newstate == PLAYER_STATE_DRIVER && NewCar[playerid]==1){

    new cartype = GetPlayerVehicleID(playerid);

    SetPlayerInterior(playerid,0);

    SetVehiclePos(cartype,x1,y1,z1);

    NewCar[playerid]=0;

    return 1;
	}


	new str[80]; if (newstate == 2 || newstate == 3)
	{
 	format(str, sizeof(str), "~g~%s",vehName[GetVehicleModel(GetPlayerVehicleID(playerid))-400]);
 	GameTextForPlayer(playerid, str, 5000, 1);
	}
	
	new State=GetPlayerState(playerid);
	if(State==PLAYER_STATE_DRIVER)
	{
	PlayerPlaySound(playerid,1133,0,0,0);
	}
	return 1;


	
}

public OnPlayerExitedMenu(playerid)
{
	TogglePlayerControllable(playerid, 1);
	return 1;
}

public bombmanoir(playerid)
{
                GameTextForAll("~y~BOOM!!",2000,4);

                CreateExplosion(1286.5693,-828.5428,1085.6328, 10, 10.0);
                CreateExplosion(1274.0499,-825.8211,1085.6328, 10, 10.0);
                CreateExplosion(1279.1196,-814.1102,1085.6328, 10, 10.0);
                CreateExplosion(1282.7286,-832.3138,1089.9375, 10, 10.0);

                CreateExplosion(1275.9065,-816.1691,1089.9375, 10, 10.0);
                CreateExplosion(1290.4569,-792.5706,1089.9375, 10, 10.0);
                CreateExplosion(1279.5675,-772.6429,1091.9063, 10, 10.0);
                CreateExplosion(1252.0012,-821.7390,1084.0078, 10, 10.0);

                CreateExplosion(1235.2119,-808.3564,1084.0078, 10, 10.0);
                CreateExplosion(1228.6798,-828.0161,1084.0078, 10, 10.0);
                CreateExplosion(1255.3750,-804.2156,1084.0151, 10, 10.0);
                CreateExplosion(1280.8680,-798.0719,1084.0078, 10, 10.0);

                CreateExplosion(1271.1538,-795.0403,1084.1719, 10, 10.0);
                CreateExplosion(1258.6477,-795.0280,1084.2344, 10, 10.0);
                CreateExplosion(1237.5100,-756.2418,1084.0150, 10, 10.0);
                CreateExplosion(1227.6356,-761.4369,1084.0007, 10, 10.0);
                CreateExplosion(1231.9501,-771.9229,1084.0116, 10, 10.0);
                CreateExplosion(1251.0398,-782.1349,1084.0078, 10, 10.0);
                CreateExplosion(1264.6299,-767.5043,1084.0078, 10, 10.0);
                CreateExplosion(1277.3457,-783.7160,1084.0149, 10, 10.0);
                CreateExplosion(1238.4683,-821.0138,1083.1563, 10, 10.0);

                CreateExplosion(1249.5198,-782.0673,1084.0078, 10, 10.0);
                CreateExplosion(1231.8630,-770.6633,1084.0000, 10, 10.0);
                CreateExplosion(1264.5953,-767.9968,1084.0149, 10, 10.0);
                CreateExplosion(1277.0612,-780.7959,1084.0078, 10, 10.0);
                CreateExplosion(1299.4833,-779.8370,1084.0078, 10, 10.0);
				SoundForAll(1057);
				return 1;

 }

public PingCheck(playerid)
{
new player[MAX_PLAYER_NAME];
if (GetPlayerPing(playerid) >=800)
{
	    GetPlayerName(playerid, player, sizeof(player));
	    new string[128];
	    format(string, sizeof(string), "Le serveur a kicke [%i] %s. [Raison: Haut ping( %d )]", playerid, player, GetPlayerPing(playerid));
		SendClientMessageToAll(ADMIN_RED, string);
	    Kick(playerid);
}
return 1;
}

