#include <a_samp>
#include <core>
#include <float>
#include <dini>
#include <dudb>
#pragma tabsize 0
native PlayAudioStreamForPlayer(playerid, url[], Float:posX = 0.0, Float:posY = 0.0, Float:posZ = 0.0, Float:distance = 50.0, usepos = 0);
native StopAudioStreamForPlayer(playerid);

enum pInfos
{
     Faction,
}

#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_BRIGHTRED 0xFF0000AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_PINK 0xFF66FFAA
#define COLOR_BLUE 0x3A47DEFF
#define COLOR_TAN 0xBDB76BAA
#define COLOR_PURPLE 0x800080AA
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_LIGHTBLUE 0x33CCFFAA
#define COLOR_ORANGE 0xFF9900AA
#define COLOR_INDIGO 0x4B00B0AA
#define COLOR_BLACK 0x00000000
#define COLOR_DARKGREY 0x696969FF
#define COLOR_RED 0xFF0000FF
#define DIALOG_RULES 2
#define cyan 0x00FFFFFF
#define admin 0x0C337CFF
#define RED 0xFF0000FF  
#define YELLOW 0xFFFF00AA 
#define bleu 0x0066DDAA
#define rouge 0xFF0000FF

#define Text_Minimap " ~b~www.~w~team-kod.xooit~b~.com"
#define Dialogonclick 700
#define PMDIA 4600
#define NUMVALUES 4
#define BALLAS 0
#define GROOVES 1
#define FLICS 2
#define DANANGBOY 3
#define CIVILS 4
#define BUISINNESMAN 5
#define TRAVAILLEURS 6
#define MECANICIEN 7
#define MAFIARUSSE 8
#define TRIAD 9
#define GIRLS 10
#define BRAQUEUR 11
#define CHICKEN 12
#define CLODOS 13
#define HotPoint1 2009.0814,-1728.1830,13.4533
#define HotPoint2 2009.0692,-1640.7626,13.4465
#define HotPoint3 2075.3311,-1643.5902,13.4073
#define HotPoint4 2138.3816,-1616.8345,13.4692
#define HotPoint5 2172.3430,-1675.6588,14.9697
#define HotPoint6 2308.7888,-1665.8096,14.3982
#define HotPoint7 2503.9426,-1658.8201,13.3568
#define HotPoint8 2376.7712,-1907.2572,13.2880
#define HotPoint9 2238.4990,-1902.2578,13.4472
#define HotPoint10 1131.9427,-2037.3005,68.9129
#define HotPoint11 1623.0204,-1858.5880,13.4557
#define Refillpoint 1618.9200,-1892.1852,13.4540
#define binco 208.4070,-98.3959,1005.2578,165.4182
#define bar 495.4053,-80.9264,998.7578,83.1791
#define coiffeur 414.0039,-10.1411,1001.8120,178.2883
#define tatouage -201.1165,-22.7645,1002.2734,354.9867
#define resto 370.7368,-117.1211,1001.4922,193.5184
#define magasin -27.8137,-91.6268,1003.5469,355.9267
#define alambra 475.3438,-10.9796,1003.6953,184.8451
#define zip 179.5855,-92.0268,1002.0234,280.7025
#define ammu 295.6249,-40.2243,1001.5156,12.1201
#define burger 382.0842,-56.8519,1001.5151,194.7390
#define victim 200.5004,-10.5233,1001.2109,314.0121
#define shoes 213.8894,-159.9189,1000.5234,38.8303
#define jq1 2075.6831,-1795.5128,13.5469
#define jq2 1831.6819,-1841.8762,13.5781
#define jq3 1766.1318,-1944.9807,13.3278
#define jq4 1536.2109,-1676.7463,13.1494
#define jq5 1458.0214,-1142.5959,24.0503
#define jq6 2497.3289,-1667.4125,13.1120

new hotdog = 0;
new InfosJoueur[MAX_PLAYERS][pInfos];
new hotinfo;
new gTeam[MAX_PLAYERS];
new Compte;
new countdown;
forward CountDown();
forward payday();
forward MoneyGrubScoreUpdate();
forward GameModeExitFunc();
forward SendPlayerFormattedText(playerid, const str[], define);
forward public SendAllFormattedText(playerid, const str[], define);
forward Drugoff (playerid);
forward UnfreezePlayerAfterConnect(playerid);
forward ctimer();
new pseudoinitial[50][MAX_PLAYERS];
new pseudofinal[50];
new bool:IsInDM[MAX_PLAYERS];
new Duelid;
new EDuelid;
new weapid;
new weap[128];
new map[MAX_PLAYER_NAME];
new Dnormal;
new nmap[128][MAX_PLAYER_NAME];
new Duel[MAX_PLAYERS];
new Text:COMPTEUR[MAX_PLAYERS];
new Float:health,
    Text:PPing[MAX_PLAYERS],
    Text:PHealth[MAX_PLAYERS];

forward VerificationCompteur();
forward Messages();

new Message[][] =
{
    "Nouveau ? tapez /aide pour savoir plus d'infos sur le serveur!",
    "Pour les renames allez poster sur notre site et veuillez attendre la reponse d'un admin",
    "Envie d'être KoD ou faire partie du staff ? Allez poster sur notre forum et attendez une réponse",
    "Vous aussi vous voulez créer une team? Postez dans la rubrique Création d'une Team et attendez la réponse d'un administrateur"
};

#define ARGENT 0


#define VERT 0x009D07FF
#define ROUGE 0xD70000FF

	//swan off
    new Float:Team1Spawns[4][3] = {
    {1807.0031,-1804.0886,52.4688},
    {1750.2545,-1802.9989,52.4688},
    {1752.2957,-1748.4551,52.4688},
    {1804.9061,-1747.6243,52.4688}
    };
    //Deagle
    new Float:Team2Spawns[4][3] = {
    {1775.5597,-1934.6725,13.3854},
    {1805.2924,-1934.0822,13.3857},
    {1805.0275,-1886.7394,13.4077},
    {1777.4622,-1888.4426,13.3875}
    };
    //Minigun
    new Float:Team3Spawns[4][3] = {
    {-378.3859,2242.0300,42.6185},
    {-362.6399,2222.3945,43.0078},
    {-431.3329,2239.9219,42.9834},
    {-439.1094,2228.2107,43.1094}
    };
    //Combat Shotgun
    new Float:Team4Spawns[4][3] = {
    {2548.6445,2847.1313,10.8203},
    {2546.1104,2810.4377,10.8203},
    {2615.4187,2846.8633,10.8203},
    {2613.2544,2807.1721,10.8203}
    };
    //Fusil
    new Float:Team5Spawns[4][3] = {
    {1764.1620,-161.4169,76.5881},
    {1809.8928,-188.0536,71.3237},
    {1800.2218,-254.5208,62.2274},
    {1741.8600,-269.1770,84.3663}
    };
//------------------------------------------------------------------------------------------------------
stock Minus(tmp[])
{
	for(new i = strlen(tmp); i >=0; i--)
	{
		if(tmp[i] >= 'a' && tmp[i] <= 'Z')
		{
			tmp[i] |= 0x20;
		}
	}
}
new CashScoreOld;
new pname[MAX_PLAYER_NAME];
new dm[MAX_PLAYERS]; 
new buisson;
PlayAllSound(soundid)
{
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
	    PlayerPlaySound(i,soundid,0.0,0.0,0.0);
    }
}

public MoneyGrubScoreUpdate()
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
}

public OnPlayerConnect(playerid)
{
    GetPlayerName(playerid, pseudoinitial[playerid], 50);
    new message[127];
    SendClientMessage(playerid,COLOR_YELLOW,"============[FR] LS-TDM LIBRE V1.0 [KoD]===========");
    SendClientMessage(playerid,0x0080FFFF,"Bienvenue sur notre serveur [FR] LS-TDM LIBRE V1.0 [KoD].");
    SendClientMessage(playerid,0x0080FFFF,"En cas de problème contacter-nous sur le site en bas de la carte.");
    SendClientMessage(playerid,0x0080FFFF,"Tapez => /aide pour en savoir plus sur les commandes du server.");
    SendClientMessage(playerid,0x0080FFFF,"News: la dernière version est est la v1.0");
    SendClientMessage(playerid,COLOR_YELLOW,"===================================================");
    GetPlayerName(playerid, message, sizeof(message));
    format(message,sizeof(message), "{FFFFFF}**** {0080FF}%s {FFFFFF}a rejoint le server !****", message, playerid);
    SendClientMessageToAll(COLOR_ORANGE, message);
    new Text:text = TextDrawCreate(5.0, 430.0,Text_Minimap);
   	TextDrawUseBox(text, 0);
	TextDrawFont(text, 3);
	TextDrawSetShadow(text,0);
	TextDrawSetOutline(text,1);
	TextDrawBackgroundColor(text,0x000000FF);
	TextDrawColor(text,0xFFFFFFFF);
	TextDrawShowForPlayer(playerid, text);
	COMPTEUR[playerid] = TextDrawCreate(505.000000,102.000000,"");
	TextDrawBackgroundColor(COMPTEUR[playerid],0x000000FF);
	TextDrawFont(COMPTEUR[playerid],3);
	TextDrawLetterSize(COMPTEUR[playerid],0.230000,1.000000);
	TextDrawColor(COMPTEUR[playerid],-1);
	TextDrawSetOutline(COMPTEUR[playerid],1);
	TextDrawSetProportional(COMPTEUR[playerid],1);
	TextDrawUseBox(COMPTEUR[playerid],0);
	TextDrawBoxColor(COMPTEUR[playerid],0x000000FF);
	TextDrawTextSize(COMPTEUR[playerid],601.000000,0.000000);
    PPing[playerid] = TextDrawCreate(580.0, 410.0,":Ping");
	PHealth[playerid] = TextDrawCreate(541.0, 425.0,":Health");
	TextDrawAlignment(PHealth[playerid],0);
	TextDrawAlignment(PPing[playerid],0);
	TextDrawFont(PHealth[playerid],3);
	TextDrawLetterSize(PHealth[playerid],0.388888,1.800000);
	TextDrawFont(PPing[playerid],3);
	TextDrawLetterSize(PPing[playerid],0.388888,1.800000);
	TextDrawColor(PHealth[playerid],0xFFFFFFFF);
	TextDrawColor(PPing[playerid],0xFFFFFFFF);
	TextDrawSetOutline(PHealth[playerid],1);
	TextDrawSetOutline(PPing[playerid],1);
	TextDrawSetShadow(PHealth[playerid],0);
	TextDrawSetShadow(PPing[playerid],0);
	InfosJoueur[playerid][Faction]=0;
 return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
if(reason == 0)
	{
	new string[128];
		format(string, sizeof(string), "{FFFFFF}**** {0080FF}%s {FFFFFF}viens de quitter le server. (Crash/Bug) ****", noms(playerid));
		SendClientMessageToAll(COLOR_GREEN, string);
	}
	else if(reason == 1)
	{
	new string[128];
		format(string, sizeof(string), "{FFFFFF}**** {0080FF}%s {FFFFFF}viens de quitter le server. (Quitter...) ****", noms(playerid));
		SendClientMessageToAll(COLOR_GREEN, string);
	}
	else if(reason == 2)
	{
	new string[128];
		format(string, sizeof(string), "{FFFFFF}**** {0080FF}%s {FFFFFF}viens de quitter le server. (Kick/Bannie) ****", noms(playerid));
		SendClientMessageToAll(COLOR_GREEN, string);
		return 1;
	}
    new string[64],
    name[MAX_PLAYER_NAME];
    GetPlayerName(playerid,name,MAX_PLAYER_NAME);
    SendClientMessageToAll(0xFFFFFFAA,string);
    if (Duel[playerid] == 2)
{
Duel[Duelid] = 0;
Duel[EDuelid] = 0;
SpawnPlayer(Duelid);
SpawnPlayer(EDuelid);
if (map[Duelid] ==3) Dnormal = 0;
}
	TextDrawHideForPlayer(playerid, PHealth[playerid]);
	TextDrawHideForPlayer(playerid, PPing[playerid]);
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	new string[256];
	new cmd[256];
	new idx;
	cmd = strtok (cmdtext, idx);
	new AdminName[MAX_PLAYER_NAME];
	new pidName[MAX_PLAYER_NAME];
 	new Float:X, Float:Y, Float:Z,Float:Angle;
 	new specplayerid;


	cmd = strtok(cmdtext, idx);

	if(strcmp(cmd, "/aide", true) == 0) {

    ShowPlayerDialog(playerid,1,DIALOG_STYLE_MSGBOX,"Aide","1. /regle pour voir les rï¿½gles\r\n2. /telep Pour voir les commandes de tï¿½lï¿½portations\r\n3. /cmdwar Pour voir les commandes de war\r\n4. /animlist Pour voir la liste des animations\r\n5. /cmds Pour voir les commandes\r\n6. /racehelp Pour voir les commandes de course","Okay", "");

	return 1;
	}
	if(strcmp(cmd, "/regle", true) == 0) {

    ShowPlayerDialog(playerid,1,DIALOG_STYLE_MSGBOX,"Crédits","         =========[Les règles]=========\r\n\r\nLes interdictions: \r\n-Carkill\r\n-Batikill\r\n-Helikill\r\n-Drive-By\r\n-Cheat\r\n-Fuir un combat\r\n-Insultes,propos etc..\r\n-Pub\r\n-Flood\r\n\r\nLes autorisations: \r\n-C-bug\r\n-Switch","Okay","");
	return 1;
	}
	if(strcmp(cmd, "/credits", true) == 0) {

    ShowPlayerDialog(playerid,1,DIALOG_STYLE_MSGBOX,"Crédits","                                          =========[Les Credits]=========\r\n\r\nTous d'abord un merci ï¿½ toutes l'ï¿½quipes KoD qui ont tous mis du sien dans ce serveur\r\nEnsuite un grand merci ï¿½ [KoD]Jhonny et [KoD]Zepek qui s'occupent du scripting,\r\navec quelque aides de [KoD]TonTon_93 et ShaDowxx\r\nEt pour terminer un grand merci ï¿½ [KoD]James et [KoD]Smoking qui soutient le serveur","Okay","");
	return 1;
	}
	
	if(strcmp(cmd, "/cmds", true) == 0) {
	
    ShowPlayerDialog(playerid,567,DIALOG_STYLE_MSGBOX,"Commandes","      =========[Les Commandes]=========\r\n\r\nTab puis click pseudo pour une demande de duel\r\n/givecash pour transferï¿½ de l'arent un joueur\r\n/radio1 ou /radio2 pour ï¿½couter de la musique\r\n/stop pour arreter la radio\r\n/kill pour se tuer\r\n/dm pour aller en DeathMatch\r\n/team pour changer de team\r\n/me [action] pour faire une action\r\n/clear pour effacï¿½ son chat","Okay","");
	return 1;
	}
	
	if(strcmp(cmd, "/racehelp", true) == 0) {

    ShowPlayerDialog(playerid,567,DIALOG_STYLE_MSGBOX,"Commandes","=========[Les Commandes De Courses]=========\r\n\r\n/join pour rejoindre la course\r\n/leave pour quitter la course\r\n/bestrace pour voir les meilleurs temps","Okay","");
	return 1;
	}
 	if(strcmp(cmd, "/donnerargent", true) == 0) {
	    new tmp[256];
	    new playermoney;
    	new sendername[MAX_PLAYER_NAME];
    	new giveplayer[MAX_PLAYER_NAME];
    	new giveplayerid, moneys;
		tmp = strtok(cmdtext, idx);

		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_WHITE, "USAGE: /donnerargent [playerid] [amount]");
			return 1;
		}
		giveplayerid = strval(tmp);

		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_WHITE, "USAGE: /donnerargent [playerid] [montant]");
			return 1;
		}
 		moneys = strval(tmp);

		if (IsPlayerConnected(giveplayerid)) {
			GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			playermoney = GetPlayerMoney(playerid);
			if (moneys > 0 && playermoney >= moneys) {
				GivePlayerMoney(playerid, (0 - moneys));
				GivePlayerMoney(giveplayerid, moneys);
				format(string, sizeof(string), "Vous venez d'envoyer $%d à %s.", moneys, giveplayer);
				SendClientMessage(playerid, COLOR_YELLOW, string);
				format(string, sizeof(string), "%s(%d) vous a donné $%d. Remerciez le!", sendername, playerid, moneys);
				SendClientMessage(giveplayerid, COLOR_YELLOW, string);
			    format(string, sizeof(string),"%s(%d) a transferé $%d a %s(%d)",sendername, playerid, moneys, giveplayer, giveplayerid);
                SendClientMessageToAll(COLOR_YELLOW, string);
				printf("%s(%d) a transferé $%d a %s(%d)",sendername, playerid, moneys, giveplayer, giveplayerid);
			}
			else {
				SendClientMessage(playerid, COLOR_YELLOW, "Montant invalide.");
			}
		}
		else {
				format(string, sizeof(string), "Ce joueur n'est pas connecté", giveplayerid);
				SendClientMessage(playerid, COLOR_YELLOW, string);
			}
		return 1;
	}
	
    if(strcmp(cmdtext, "/decap", true) == 0) {
if(dm[playerid] == 1)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 2)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 3)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 4)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utilser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 5)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
	GetPlayerName(playerid, pname, sizeof (pname));
    format(string, sizeof(string),"{FFFF00}%s {FFFFFF}ï¿½ rejoint les décapotables => {00FFFF} /decap", pname);
    SendClientMessageToAll(COLOR_GREEN, string);
	SetPlayerPos(playerid, 525.8484,-1829.5167,5.6257);
    GameTextForPlayer(playerid, "~b~ Bienvenue aux décapotables", 5000, 5);
    return 1;
}
	if(strcmp(cmdtext, "/warentrep", true) == 0) {
	    if(dm[playerid] == 1)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 2)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 3)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 4)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utilser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 5)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
	SetPlayerInterior(playerid,2);
	ResetPlayerWeapons(playerid);
	GivePlayerWeapon(playerid,18 , 500);
	GivePlayerWeapon(playerid,9,500);
	SetPlayerHealth(playerid,25);
	SetPlayerArmour(playerid,100);
	GetPlayerName(playerid, pname, sizeof (pname));
    format(string, sizeof(string),"{FFFF00}%s {FFFFFF}à rejoint la war à l'entrepot=> {00FFFF} /warentrep", pname);
    SendClientMessageToAll(COLOR_GREEN, string);
	SetPlayerPos(playerid,2548.7476,-1295.2281,1031.4219);
    GameTextForPlayer(playerid, "~r~Bute les tous!", 5000, 5); 
	SendClientMessage(playerid,COLOR_GREEN,"Bienvenue a l'entrepot");
	SetPlayerSkin(playerid,127);
    return 1;
}
	if(strcmp(cmdtext, "/warboite", true) == 0) {
	    if(dm[playerid] == 1)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 2)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 3)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 4)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utilser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 5)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
	SetPlayerInterior(playerid,3);
	ResetPlayerWeapons(playerid);
	GivePlayerWeapon(playerid,4,500);
	GivePlayerWeapon(playerid,22,500);
	SetPlayerHealth(playerid,50);
	GetPlayerName(playerid, pname, sizeof (pname));
    format(string, sizeof(string),"{FFFF00}%s {FFFFFF}à rejoint la war à la boite de nuit=> {00FFFF} /warboite", pname);
    SendClientMessageToAll(COLOR_GREEN, string);
	SetPlayerPos(playerid,-2640.762939,1406.682006,906.460937);
    GameTextForPlayer(playerid, "~r~Bute les tous!", 5000, 5); 
	SendClientMessage(playerid,COLOR_GREEN,"Bienvenue a la boite");
	SetPlayerSkin(playerid,257);
    return 1;
}
	if(strcmp(cmdtext, "/wararmy", true) == 0) {
	    if(dm[playerid] == 1)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 2)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 3)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 4)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utilser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 5)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
	SetPlayerInterior(playerid,10);
	ResetPlayerWeapons(playerid);
	GivePlayerWeapon(playerid,16,500);
	GivePlayerWeapon(playerid,27,500);
	GivePlayerWeapon(playerid,31,500);
	GivePlayerWeapon(playerid,34,500);
	SetPlayerHealth(playerid,100);
	SetPlayerArmour(playerid,150);
	GetPlayerName(playerid, pname, sizeof (pname));
    format(string, sizeof(string),"{FFFF00}%s {FFFFFF}a rejoint la guerre=> {00FFFF} /wararmy", pname);
    SendClientMessageToAll(COLOR_GREEN, string);
	SetPlayerPos(playerid,-975.975708,1060.983032,1345.671875);
    GameTextForPlayer(playerid, "~r~Bute les tous!", 5000, 5);
	SendClientMessage(playerid,COLOR_GREEN,"Bienvenue a la guerre");
	SendClientMessage(playerid,COLOR_GREEN,"PS: Si le gilet ne s'enlève pas c'est normal c'est pour faire réaliste");
	SetPlayerSkin(playerid,287);
    return 1;
}
	if(strcmp(cmdtext, "/warlc", true) == 0) {
	    if(dm[playerid] == 1)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 2)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 3)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 4)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utilser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 5)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
	SetPlayerInterior(playerid,1);
	ResetPlayerWeapons(playerid);
	GivePlayerWeapon(playerid,24,500);
	GivePlayerWeapon(playerid,29,500);
	SetPlayerHealth(playerid,100);
	GetPlayerName(playerid, pname, sizeof (pname));
    format(string, sizeof(string),"{FFFF00}%s {FFFFFF}a rejoint l'émeute à Liberty City=> {00FFFF} /warlc", pname);
    SendClientMessageToAll(COLOR_GREEN, string);
	SetPlayerPos(playerid,-729.276000,503.086944,1371.971801);
    GameTextForPlayer(playerid, "~r~Bute les tous!", 5000, 5);
	SendClientMessage(playerid,COLOR_GREEN,"Bienvenue a l'émeute");
	SetPlayerSkin(playerid,230);
    return 1;
}
	if(strcmp(cmdtext, "/warmafia", true) == 0) {
	    if(dm[playerid] == 1)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 2)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 3)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 4)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utilser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 5)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
	SetPlayerInterior(playerid,1);
	ResetPlayerWeapons(playerid);
	GivePlayerWeapon(playerid,28,500);
	GivePlayerWeapon(playerid,24,500);
	GivePlayerWeapon(playerid,25,500);
	GivePlayerWeapon(playerid,4,500);
	GivePlayerWeapon(playerid,30,500);
	SetPlayerHealth(playerid,100);
	SetPlayerArmour(playerid,50);
	GetPlayerName(playerid, pname, sizeof (pname));
    format(string, sizeof(string),"{FFFF00}%s {FFFFFF}a rejoint la casa des mafieux=> {00FFFF} /warmafia", pname);
    SendClientMessageToAll(COLOR_GREEN, string);
	SetPlayerPos(playerid,-794.806396,497.738037,1376.195312);
    GameTextForPlayer(playerid, "~r~Bute les tous!", 5000, 5);
	SendClientMessage(playerid,COLOR_GREEN,"Bienvenue a la casa des mafieux");
	SetPlayerSkin(playerid,120);
    return 1;
}
	if(strcmp(cmd, "/cmdwar", true) == 0) {
    ShowPlayerDialog(playerid,1,DIALOG_STYLE_MSGBOX,"Commande Wars","                  ========[Les Wars]========\r\n\r\n1. /warentrep pour se tï¿½lï¿½porter ï¿½ l'entrepot\r\n2. /warboite Pour se tï¿½lï¿½porter ï¿½ la boit de nuit\r\n3. /wararmy Pour se tï¿½lï¿½porter ï¿½ la guerre\r\n4. /warlc Pour se tï¿½lï¿½porter ï¿½ l'ï¿½meute de LC\r\n5. /warmafia Pour se tï¿½lï¿½porter ï¿½ la casa de la mafia\r\n","Okay", "");
	return 1;
	}
		if(strcmp(cmd, "/telep", true) == 0) {
		ShowPlayerDialog(playerid,1,DIALOG_STYLE_MSGBOX,"Commande Téléportations","       ========[Les Tï¿½lï¿½portations]========\r\n\r\n1. /drift1 /drift2 /drift3 /drift4 Pour aller drifter\r\n2. /stunt1 /stunt2 /stunt3 /stunt4 pour aller stunter\r\n3. /decap Pour allez aux dï¿½capotables\r\n4. /desert: Pour aller au stunt dans le dï¿½sert\r\n","Okay", "");
	return 1;
	}
		if(strcmp(cmdtext, "/drift1", true) == 0) {
		    if(dm[playerid] == 1)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 2)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 3)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 4)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utilser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 5)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
	GetPlayerName(playerid, pname, sizeof (pname));
    format(string, sizeof(string),"{FFFF00}%s {FFFFFF}a rejoint drift 1 => {00FFFF} /drift1", pname);
    SendClientMessageToAll(COLOR_GREEN, string);
	SetPlayerPos(playerid,1239.9244,-2037.0375,59.9356);
    GameTextForPlayer(playerid, "~g~ Bon drift", 5000, 5); 
	SendClientMessage(playerid,cyan,"Bienvenue à Drift 1");

	return 1;
}
	if(strcmp(cmdtext, "/drift2", true) == 0) {
	    if(dm[playerid] == 1)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 2)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 3)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 4)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utilser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 5)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
	GetPlayerName(playerid, pname, sizeof (pname));
    format(string, sizeof(string),"{FFFF00}%s {FFFFFF}a rejoint drift 2 => {00FFFF} /drift2", pname);
    SendClientMessageToAll(COLOR_GREEN, string);
	SetPlayerPos(playerid,2325.8809,1406.8158,42.8203);
    GameTextForPlayer(playerid, "~g~ Bon drift", 5000, 5); 
	SendClientMessage(playerid,cyan,"Bienvenue à Drift 2");
	return 1;
}
if(strcmp(cmdtext, "/drift3", true) == 0) {
    if(dm[playerid] == 1)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 2)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 3)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 4)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utilser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 5)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
	GetPlayerName(playerid, pname, sizeof (pname));
    format(string, sizeof(string),"{FFFF00}%s {FFFFFF}a rejoint drift 3 => {00FFFF} /drift3", pname);
    SendClientMessageToAll(COLOR_GREEN, string);
	SetPlayerPos(playerid,-2405.3889,-598.8038,132.6484);
    GameTextForPlayer(playerid, "~g~ Bon drift", 5000, 5);
	SendClientMessage(playerid,cyan,"Bienvenue à Drift 3");
	return 1;
}
if(strcmp(cmdtext, "/drift4", true) == 0) {
    if(dm[playerid] == 1)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 2)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 3)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 4)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utilser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 5)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
	GetPlayerName(playerid, pname, sizeof (pname));
    format(string, sizeof(string),"{FFFF00}%s {FFFFFF}a rejoint drift 4 => {00FFFF} /drift4", pname);
    SendClientMessageToAll(COLOR_GREEN, string);
	SetPlayerPos(playerid,-329.6852,1536.7886,76.6117);
    GameTextForPlayer(playerid, "~g~ Bon drift", 5000, 5);
	SendClientMessage(playerid,cyan,"Bienvenue à Drift 4");
	return 1;
}
if(strcmp(cmdtext, "/stunt1", true) == 0) {
    if(dm[playerid] == 1)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 2)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 3)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 4)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utilser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 5)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
	GetPlayerName(playerid, pname, sizeof (pname));
    format(string, sizeof(string),"{FFFF00}%s {FFFFFF}a rejoint stunt 1 => {00FFFF} /stunt1", pname);
    SendClientMessageToAll(COLOR_GREEN, string);
	SetPlayerPos(playerid,2138.1179,1790.3162,10.8203);
    GameTextForPlayer(playerid, "~g~ Bon stunt", 5000, 5); 
	SendClientMessage(playerid,cyan,"Bienvenue à Stunt 1");
	return 1;
}
if(strcmp(cmdtext, "/stunt2", true) == 0) {
    if(dm[playerid] == 1)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 2)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 3)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 4)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utilser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 5)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
	GetPlayerName(playerid, pname, sizeof (pname));
    format(string, sizeof(string),"{FFFF00}%s {FFFFFF}a rejoint stunt 2 => {00FFFF} /stunt2", pname);
    SendClientMessageToAll(COLOR_GREEN, string);
	SetPlayerPos(playerid,1838.2540,1464.6748,10.8203);
    GameTextForPlayer(playerid, "~g~ Bon stunt", 5000, 5); 
	SendClientMessage(playerid,cyan,"Bienvenue à Stunt 2");
	return 1;
}
if(strcmp(cmdtext, "/stunt3", true) == 0) {
    if(dm[playerid] == 1)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 2)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 3)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 4)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utilser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 5)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
	GetPlayerName(playerid, pname, sizeof (pname));
    format(string, sizeof(string),"{FFFF00}%s {FFFFFF}a rejoint stunt 3 => {00FFFF} /stunt3", pname);
    SendClientMessageToAll(COLOR_GREEN, string);
	SetPlayerPos(playerid,1919.8005,-1406.4122,13.5703);
    GameTextForPlayer(playerid, "~g~ Bon stunt", 5000, 5); 
	SendClientMessage(playerid,cyan,"Bienvenue à Stunt 3");
	return 1;
}
if(strcmp(cmdtext, "/stunt4", true) == 0) {
    if(dm[playerid] == 1)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 2)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 3)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 4)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utilser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 5)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
	GetPlayerName(playerid, pname, sizeof (pname));
    format(string, sizeof(string),"{FFFF00}%s {FFFFFF}à rejoint stunt 4 => {00FFFF} /stunt4", pname);
    SendClientMessageToAll(COLOR_GREEN, string);
	SetPlayerPos(playerid,-1965.4253,293.8297,35.4688);
    GameTextForPlayer(playerid, "~g~ Bon stunt", 5000, 5); 
	SendClientMessage(playerid,cyan,"Bienvenue à Stunt 4");
	return 1;
}

//=======================================[ CLEAR PLAYER ]=============================================
	if(strcmp(cmdtext, "/clear", true) == 0)
	{
    GetPlayerName(playerid, pname, sizeof (pname));
	SendClientMessage(playerid,COLOR_GREEN," ");
	SendClientMessage(playerid,COLOR_GREEN," ");
	SendClientMessage(playerid,COLOR_GREEN," ");
	SendClientMessage(playerid,COLOR_GREEN," ");
	SendClientMessage(playerid,COLOR_GREEN," ");
	SendClientMessage(playerid,COLOR_GREEN," ");
	SendClientMessage(playerid,COLOR_GREEN," ");
	SendClientMessage(playerid,COLOR_GREEN," ");
	SendClientMessage(playerid,COLOR_GREEN," ");
	SendClientMessage(playerid,COLOR_GREEN," ");
	SendClientMessage(playerid,COLOR_GREEN," ");
	SendClientMessage(playerid,COLOR_GREEN," ");
	SendClientMessage(playerid,COLOR_GREEN," ");
	SendClientMessage(playerid,COLOR_GREEN,"Vous avez effacez vos messages");

    return 1;
}

//===========================================[ CACHE CACHE ]===============================
if(!strcmp("/cachemoi", cmdtext, true, 10))
	{
	buisson = CreateObject(647, 0, 0, 0, 0, 0, 0);
	AttachObjectToPlayer(buisson, playerid, 0.0, 0.0, 0.0, 0, 0, 0);
	return 1;
	}
if(!strcmp("/stopcache", cmdtext, true, 10))
	{
	DestroyObject(buisson);
	return 1;
	}

//================================================[ STUNT DESERT ]
if (strcmp(cmdtext,"/desert",true) == 0)
{

new pid[256];
new tmpp[256];
new pidName[MAX_PLAYER_NAME];
    if(dm[playerid] == 1)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 2)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 3)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 4)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utilser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 5)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
SetPlayerPos(playerid,-79.2914,2499.1384,16.4844);
GameTextForPlayer(playerid, "~y~Bienvenue au ~b~stunts~p~desert !", 3500, 3);
SendClientMessage(playerid, COLOR_GREEN, "Bienvenue a la map stunt desert ");
GetPlayerName (playerid, pidName, 255);
format(tmpp, sizeof(tmpp), "*** %s (ID:%d) est allï¿½(e) ï¿½ la map stunt desert  [/desert]***",pidName,pid);
SendClientMessageToAll (0xAA3333AA, tmpp);
SetPlayerFacingAngle (playerid, 270.5811);
SetCameraBehindPlayer (playerid);
return 1;
}
//================================================[ RENAME ]===================================================
 if(strcmp(cmd,"/rename", true)==0)
{
    new pid, tmpp[256], tmp[256];
    new texte[256];
    new name[MAX_PLAYER_NAME];
    new name2[MAX_PLAYER_NAME];
    tmpp = strtok(cmdtext, idx);
    if(!strlen(tmpp))
    {
    SendClientMessage(playerid, COLOR_RED, "USAGE: /rename [playerid] [nom]");
    return 1;
    }
    pid = strval(tmpp);
    if(!IsPlayerConnected(pid))
    {
    SendClientMessage(playerid, COLOR_RED, "Ce player n'est pas connectï¿½");
    return 1;
    }
    if(IsPlayerAdmin(playerid)==0)
    {
    SendClientMessage(playerid, COLOR_RED, "Tu n'es pas admin !!!");
    return 1;
    }
    tmp = strtok(cmdtext, idx);
    GetPlayerName(playerid, name, sizeof(name));
    GetPlayerName(pid, name2, sizeof(name2));
    format(texte, sizeof(texte), "L'admin a renomer %s en %s", name2, tmp);
    SendClientMessageToAll(COLOR_BLUE, texte);
    SetPlayerName(pid,tmp);
    return 1;
 }
//=========================================================[ ANIM CUFF ]=========================================
    if(strcmp(cmd, "/cuff", true) == 0) {
		  // note: the cuffs have not been scaled for all player models
    	 AttachObjectToPlayer(playerid,8,19418,6,-0.031999,0.024000,-0.024000,-7.900000,-32.000011,-72.299987,1.115998,1.322000,1.406000);
    	 SetPlayerSpecialAction(playerid, 24);
         return 1;
	}
	//=======================================================[ UNCUFF ]==================================================
		 if(strcmp(cmd, "/uncuff", true) == 0) {
		 if(IsValidPlayerObject(playerid, 8)){
			DestroyPlayerObject(playerid, 8);
		 }
		 {
         SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
         return 1;
	}
//=================================================[ LISTE TEAM ]===========================================
if(strcmp(cmdtext, "/listeam", true) == 0)
{
SendClientMessage(playerid,COLOR_YELLOW,"-----------------Liste des teams du serveur------------------------");
SendClientMessage(playerid,COLOR_YELLOW,"Team KOD: King Of Deathmatch  (Team n°1)");
return 1;
}
//=================================================[ JQ]===========================================
if(IsPlayerInAnyVehicle(playerid))
if(strcmp(cmdtext, "/jq", true) == 0)
{

SendClientMessage(playerid,COLOR_YELLOW,"Tu as commencé ta journée quotidienne");
GameTextForPlayer(playerid,"~b~ ALLER D'ABORD VA TE COUPER LES CHEVEUX",5000,5);
SetPlayerCheckpoint(playerid,jq1,6.0);
return 1;
}
//===========================================[ LOGIN KOD ]=================================================
if(strcmp(cmdtext, "/logkod onlaykod", true) == 0)
{
SendClientMessage(playerid,COLOR_GREEN,"Vous vous êtes logué avec succès");
InfosJoueur[playerid][Faction]=1;
return 1;
}
//=========================================[ DELOGIN KOD ]================================================
if(strcmp(cmdtext, "/delog", true) == 0)
{
SendClientMessage(playerid,COLOR_RED,"Vous vous êtes délogué");
InfosJoueur[playerid][Faction]=0;
return 1;
}
//==============================================[ EQUIP KOD ]===================================================
if(strcmp(cmdtext, "/equipkod", true) == 0)
if(InfosJoueur[playerid][Faction]==1)
{
SetPlayerHealth(playerid,100);
SetPlayerArmour(playerid,100);
GivePlayerWeapon(playerid,26,10000);
GivePlayerWeapon(playerid,24,10000);
GivePlayerWeapon(playerid,18,10000);
SendClientMessage(playerid,COLOR_GREEN,"Vous vous êtes équipé en KOD");
GameTextForPlayer(playerid,"~r~ A L'ATTAQUE!!!!!!",5000,1);
return 1;
}
//==============================================[ QGKOD ]==============================================================
if(strcmp(cmdtext, "/qgkod", true) == 0)
{
if(InfosJoueur[playerid][Faction]==1)
{
SetPlayerHealth(playerid,9999);
SetPlayerArmour(playerid,9999);
SetPlayerPos(playerid,-2460.1072,132.8438,35.1719);
SendClientMessage(playerid,COLOR_GREEN,"Vous vous êtes téléporté avec succès");
GameTextForPlayer(playerid,"~p~ BIENVENU AU QG DE LA TEAM KOD",5000,1);
}
else
{
SendClientMessage(playerid,COLOR_RED,"Tu n'es pas un KOD pour utiliser cette commande");
}
return 1;
}
//=========================================[ LOG MODO ]=================================================
if(strcmp(cmdtext, "/logmodo alloamodo", true) == 0)
{
InfosJoueur[playerid][Faction]=2;
SendClientMessage(playerid,COLOR_GREEN,"Vous vous êtes logué en tant que Modérateur");
return 1;
}
//===============================================[ Admin Help ]=================================================
		if(strcmp(cmdtext, "/adminhelp", true) == 0)
		{
		if(IsPlayerAdmin(playerid))
		{
		SendClientMessage(playerid,cyan,"/kick: Pour Kicker un joueur");
		SendClientMessage(playerid,cyan,"/ban: Pour Bannir un joueur");
		SendClientMessage(playerid,cyan,"/racehelp et buildhelp: Pour savoir l'ensemble des commandes pour les courses");
		SendClientMessage(playerid,cyan,"/aclear: Pour effacer le chat");
		SendClientMessage(playerid,cyan,"/rename: Pour renommer quelqu'un");
		SendClientMessage(playerid,cyan,"/invisible: Pour se mettre invisible sur la map");
		}
		else
		{
		SendClientMessage(playerid,admin,"Tu n'es pas assez haut gradé pour utiliser cette commande");
		}

    return 1;
}

if	(!strcmp(cmd, "/team", true))
	{
	if(dm[playerid] == 1)
	{
	return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
	}
	if(dm[playerid] == 2)
	{
	return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
	}
	if(dm[playerid] == 3)
	{
	return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
	}
	if(dm[playerid] == 4)
	{
	return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
	}
	if(dm[playerid] == 5)
	{
	return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
	}
	new AdminName[MAX_PLAYER_NAME];
	SetPlayerHealth(playerid,-9999);
	ForceClassSelection(playerid);
	GetPlayerName(playerid, AdminName, sizeof(AdminName));
	return 1;
	}
//===============================================[ CLEAR ADMIN ]=================================================
		if(strcmp(cmdtext, "/aclear", true) == 0)
		{
		if(IsPlayerAdmin(playerid))
		{
 	GetPlayerName(playerid, pname, sizeof (pname));
    format(string, sizeof(string)," ", pname);
    SendClientMessageToAll(cyan,string);
   	GetPlayerName(playerid, pname, sizeof (pname));
    format(string, sizeof(string)," ", pname);
    SendClientMessageToAll(cyan,string);
   	GetPlayerName(playerid, pname, sizeof (pname));
    format(string, sizeof(string)," ", pname);
    SendClientMessageToAll(cyan,string);
   	GetPlayerName(playerid, pname, sizeof (pname));
    format(string, sizeof(string)," ", pname);
    SendClientMessageToAll(cyan,string);
   	GetPlayerName(playerid, pname, sizeof (pname));
    format(string, sizeof(string)," ", pname);
    SendClientMessageToAll(cyan,string);
 	GetPlayerName(playerid, pname, sizeof (pname));
    format(string, sizeof(string)," ", pname);
    SendClientMessageToAll(cyan,string);
   	GetPlayerName(playerid, pname, sizeof (pname));
    format(string, sizeof(string)," ", pname);
    SendClientMessageToAll(cyan,string);
   	GetPlayerName(playerid, pname, sizeof (pname));
    format(string, sizeof(string)," ", pname);
    SendClientMessageToAll(cyan,string);
   	GetPlayerName(playerid, pname, sizeof (pname));
    format(string, sizeof(string)," ", pname);
    SendClientMessageToAll(cyan,string);
   	GetPlayerName(playerid, pname, sizeof (pname));
    format(string, sizeof(string)," ", pname);
    SendClientMessageToAll(cyan,string);
   	GetPlayerName(playerid, pname, sizeof (pname));
    format(string, sizeof(string)," ", pname);
    SendClientMessageToAll(cyan,string);
   	GetPlayerName(playerid, pname, sizeof (pname));
    format(string, sizeof(string)," ", pname);
    SendClientMessageToAll(cyan,string);
   	GetPlayerName(playerid, pname, sizeof (pname));
    format(string, sizeof(string)," ", pname);
    SendClientMessageToAll(cyan,string);
   	GetPlayerName(playerid, pname, sizeof (pname));
    format(string, sizeof(string)," ", pname);
    SendClientMessageToAll(cyan,string);
    GetPlayerName(playerid, pname, sizeof (pname));
    format(string, sizeof(string),"L'Admin a effacï¿½ le chat ", pname);
    SendClientMessageToAll(cyan,string);
    }
    else
    {
    SendClientMessage(playerid,admin,"Tu n'es pas assez haut gradé pour utiliser cette commande");
    }
    return 1;
}
	if (strcmp("/dm", cmdtext, true, 3) == 0)
	{
        ShowPlayerDialog(playerid,1,DIALOG_STYLE_LIST,"DeathMatch","DM1: Swan off\r\nDM2: Deagle\r\nDM3: Minigun\r\nDM4: Combat Shotgun\r\nDM5: Fusil","Okay", "Annuler");
		return 1;
	}
		if (strcmp("/ldm", cmdtext, true, 3) == 0)
	{
            SetPlayerName(playerid, pseudoinitial[playerid]);
   	        new name[MAX_PLAYER_NAME];
            GetPlayerName(playerid, name, sizeof(name));
         	GameTextForPlayer(playerid, "~B~DM finis",1000,6);
     	    dm[playerid] = 0;
            SetPlayerVirtualWorld(playerid, 0);
            SpawnPlayer(playerid);
            format(string, sizeof(string), "%s {FFFFFF}viens de quitter de quitter un dm (/ldm).", name);
            SendClientMessageToAll(COLOR_YELLOW, string);
            return 1;
 }
//==============================================================================================================
    {
    if (strcmp("/kill", cmdtext, true) == 0)
{
          SendClientMessage(playerid,COLOR_RED,"Vous vous ï¿½tes suicidï¿½");
          SetPlayerHealth(playerid,0);
          return 1;
    }


if(strcmp("/radio1", cmdtext, true) == 0)
if(IsPlayerInAnyVehicle(playerid))
{
PlayAudioStreamForPlayer(playerid, "http://yp.shoutcast.com/sbin/tunein-station.pls?id=9054");
}
else
{
SendClientMessage(playerid,COLOR_RED,"Vous n'êtes pas dans un véhicule pour mettre de la radio");
}
return 1;
}

if(strcmp("/radio2", cmdtext, true) == 0)
if(IsPlayerInAnyVehicle(playerid))
{
 PlayAudioStreamForPlayer(playerid, "http://yp.shoutcast.com/sbin/tunein-station.pls?id=1193516");
 }
else
{
SendClientMessage(playerid,COLOR_RED,"Vous n'êtes pas dans un véhicule pour mettre de la radio");
}
return 1;
}

if(strcmp("/stop", cmdtext, true) == 0)
{
StopAudioStreamForPlayer(playerid);
return 1;
}

if (strcmp("/hotdog", cmdtext, true, 10) == 0)
{
if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 588)
{
hotdog = 1;
SetPlayerCheckpoint(playerid, HotPoint1, 3.0);
SendClientMessage(playerid, COLOR_YELLOW, "Tu viens de dï¿½marrer le job hotdog");
SendClientMessage(playerid, COLOR_YELLOW, "Pour le quitter tape /dogq");
new name[MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, sizeof(name));
format(string, sizeof(string), "%s est maintenant un livreur de hotdog.", pname );
SendClientMessageToAll(COLOR_RED, string);
}
else
{
SendClientMessage(playerid, COLOR_RED,"Tu dois ï¿½tre dans une camionnette de hotdog pour demarrer ce job");
}
return 1;
}
if (strcmp("/doginfo", cmdtext, true, 10) == 0)
{
ShowPlayerDialog(playerid,13,DIALOG_STYLE_MSGBOX,"AIDE JOB HOTDOG","Pour demarrer ce job hotdog va ï¿½ l'arriere du burger shot\r\nPrend un camion puis tape /hotdog\r\nTu devras livrer les hotdog au maison indiquï¿½ sur la carte\r\nUn fois tout livrer tu gagnera 50 000$\r\nAttention si tu meurs tu devra tous recommencer","Okay","");
return 1;
}

if (strcmp("/dogq", cmdtext, true, 10) == 0)
{
SendClientMessage(playerid, COLOR_YELLOW, "Tu viens de quitter le job hotdog");
 DisablePlayerCheckpoint(playerid);
 hotdog = 0;
return 1;
}

    if (strcmp("/specduel", cmdtext, true, 10) == 0)
{
if (Duel[playerid] == 2)
{
return SendClientMessage(playerid,rouge,"Tu est en duel tu ne peut pas utiliser de commandes");
}
	if(dm[playerid] == 1)
	{
	return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
	}
	if(dm[playerid] == 2)
	{
	return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
	}
	if(dm[playerid] == 3)
	{
	return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
	}
	if(dm[playerid] == 4)
	{
	return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
	}
	if(dm[playerid] == 5)
	{
	return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
	}
SetPlayerPos(playerid,-603.5388,2611.5425,66.8359);
TogglePlayerControllable(playerid,false);
SetPlayerCameraPos(playerid,-599.5388,2612.5425,66.8359);
SetPlayerCameraLookAt(playerid,-598.5388,2611.5425,66.8359);
SendClientMessage(playerid,0x00B303AA,"Tu est entrain de les observer!");
return 1;
}
if (strcmp("/offduel", cmdtext, true, 10) == 0)
{
if (Duel[playerid] == 2)
{
return SendClientMessage(playerid,rouge,"Tu est en duel tu ne peut pas utiliser de commandes");
}
	if(dm[playerid] == 1)
	{
	return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
	}
	if(dm[playerid] == 2)
	{
	return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
	}
	if(dm[playerid] == 3)
	{
	return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
	}
	if(dm[playerid] == 4)
	{
	return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
	}
	if(dm[playerid] == 5)
	{
	return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
	}
SpawnPlayer(playerid);
TogglePlayerControllable(playerid,true);
SendClientMessage(playerid,0x00B303AA,"Tu as arretï¿½ de les observer!");
return 1;
}

if (strcmp("/dexit", cmdtext, true, 10) == 0)
{
    if(dm[playerid] == 1)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 2)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 3)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 4)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utilser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 5)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
if (Duel[playerid] == 2)
{
SpawnPlayer(EDuelid);
SpawnPlayer(Duelid);
Duel[Duelid] = 0;
Duel[EDuelid] = 0;
SetPlayerHealth(EDuelid, 100);
SetPlayerHealth(Duelid, 100);
}
return 1;
}

if (Duel[playerid] == 2)
{
return SendClientMessage(playerid,rouge,"Tu est en duel tu ne peut pas utiliser de commandes");
}
if (strcmp("/accept", cmdtext, true, 10) == 0)
{
    if(dm[playerid] == 1)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 2)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 3)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 4)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utilser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 5)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
if (Duel[playerid] == 1)
{
new name[MAX_PLAYER_NAME];
new name2[MAX_PLAYER_NAME];
new tmp[128];
GetPlayerName(Duelid, name, sizeof(name));
GetPlayerName(EDuelid, name2, sizeof(name2));
SendClientMessage(playerid,bleu,"Vous avez accepter le duel pour quitter tapez /dexit!");
format(tmp, sizeof(tmp), "%s a acceptï¿½ la demande de duel de %s ! Souhaiter leur bonne chance !",name, name2);
SendClientMessageToAll(bleu,tmp);
printf("%s a acceptï¿½ la demande de duel de %s ",name, name2);
ResetPlayerWeapons(EDuelid);
ResetPlayerWeapons(Duelid);
if (map[Duelid] ==1)
SetPlayerPos(EDuelid, -595.5231,2594.4312,65.8368);
SetPlayerCameraPos(EDuelid, 2532.9509,-1664.9064,15.1659);
SetPlayerFacingAngle(EDuelid, -85);

SetPlayerPos(Duelid, -554.3133,2593.7834,65.8368);
SetPlayerCameraPos(Duelid, -595.5231,2594.4312,65.8368);
SetPlayerFacingAngle(Duelid, 85);

GivePlayerWeapon(EDuelid, weapid, 500);
GivePlayerWeapon(Duelid, weapid, 500);
TogglePlayerControllable(Duelid,false);
TogglePlayerControllable(EDuelid,false);
SetCameraBehindPlayer (EDuelid);
SetCameraBehindPlayer (Duelid);
Duel[Duelid] = 2;
Duel[EDuelid] = 2;
SetPlayerHealth(EDuelid, 100);
SetPlayerHealth(Duelid, 100);
Compte=SetTimer("CountDown",1000,1);
countdown = 5;
}
else
{
SendClientMessage(playerid,rouge,"Tu es dï¿½jï¿½ en duel");
}
return 1;
}
if (strcmp("/refus", cmdtext, true, 10) == 0)
{
    if(dm[playerid] == 1)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 2)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 3)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 4)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utilser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 5)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
if (Duel[playerid] == 1)
{
new tmp[128];
new name[MAX_PLAYER_NAME];
new name2[MAX_PLAYER_NAME];
GetPlayerName(Duelid, name, sizeof(name));
GetPlayerName(EDuelid, name2, sizeof(name2));
format(tmp, sizeof(tmp), "%s a refuser la demande de duel de %s ! Vraiment looser !",name, name2);
SendClientMessageToAll(bleu,tmp);
printf("%s a refusï¿½ la demande de duel de %s ",name, name2);
Duel[Duelid] = 0;
Duel[EDuelid] = 0;
if (map[Duelid] ==3) Dnormal = 0;
}
else
{
SendClientMessage(playerid,rouge,"Tu es dï¿½jï¿½ en duel");
}
return 1;
}
if (strcmp("/annulduel", cmdtext, true, 10) == 0)
{
    if(dm[playerid] == 1)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 2)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 3)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 4)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utilser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 5)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
if (Duel[playerid] == 1)
{
new tmp[128];
new name[MAX_PLAYER_NAME];
new name2[MAX_PLAYER_NAME];
GetPlayerName(Duelid, name, sizeof(name));
GetPlayerName(EDuelid, name2, sizeof(name2));
format(tmp, sizeof(tmp), "%s a annulï¿½ la demande de duel de %s ! Vraiment looser !",name, name2);
SendClientMessageToAll(bleu,tmp);
printf("%s a annulï¿½ sa demande de duel contre %s ",name, name2);
Duel[Duelid] = 0;
Duel[EDuelid] = 0;
if (map[Duelid] ==3) Dnormal = 0;
}
else
{
SendClientMessage(playerid,rouge,"Tu es dï¿½jï¿½ en duel");
}
return 1;
}
    
     if(!strcmp(cmdtext, "/me", true, 3)) // 3 is the length of /me
	{
        if(!cmdtext[3])return SendClientMessage(playerid, 0xFF0000FF, "USAGE: /me [action]");
        new str[128];
        GetPlayerName(playerid, str, sizeof(str));
        format(str, sizeof(str), " %s %s", str, cmdtext[4]);
        SendClientMessageToAll(COLOR_YELLOW, str);
        printf("%s", str, cmdtext[4]);
        return 1;
    }
	return 0;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
if(dialogid == 555)
{
if(response == 1)
{
switch(listitem)
{
case 0:
{
weapid = 0;
weap = "Sans Armes";
}
case 1:
{
weapid = 4;
weap = "Couteau";
}
case 2:
{
weapid = 8;
weap = "Katana";
}
case 3:
{
weapid = 24;
weap = "Desert Eagle";
}
case 4:
{
weapid = 22;
weap = "9mm";
}
case 5:
{
weapid = 16;
weap = "Grenade";
}
case 6:
{
weapid = 32;
weap = "Tec9";
}
case 7:
{
weapid = 26;
weap = "Sawn-off";
}
case 8:
{
weapid = 30;
weap = "AK47";
}
case 9:
{
weapid = 38;
weap = "Minigun";
}
}
new tmp[128];
new name[MAX_PLAYER_NAME];
new name2[MAX_PLAYER_NAME];
Duel[EDuelid] = 1;
Duel[Duelid] = 1;
GetPlayerName(Duelid, name, sizeof(name));
GetPlayerName(EDuelid, name2, sizeof(name2));
format(tmp, sizeof(tmp), "%s a envoyï¿½ une demande de duel ï¿½ %s !",name2, name);
SendClientMessageToAll(bleu,tmp);
printf("%s a envoyï¿½ une demande de duel contre %s ",name2, name);
SendClientMessage(Duelid,bleu,"Faite /accept pour accepter ou /refus pour refuser le duel");
}
}
if(dialogid == 556)
{
if(response == 1)
{
if (Duel[Duelid] >=2)
{
new tmp[128];
new name[MAX_PLAYER_NAME];
GetPlayerName(Duelid, name, sizeof(name));
format(tmp, sizeof(tmp), "%s est dï¿½jï¿½ en duel ",name,Duelid);
return SendClientMessage(playerid,rouge,tmp);
}
switch(listitem)
{
case 0 :
{
map[Duelid] = 1;
nmap[Duelid] = "Duel Normal";
if (Dnormal == 1)
ShowPlayerDialog(playerid,555,DIALOG_STYLE_LIST,"Choisissez votre type de duel","Sans armes\nCouteau\nKatana","Envoyer","Annuler");
ShowPlayerDialog(playerid,555,DIALOG_STYLE_LIST,"Choisissez votre type de duel","Sans armes\nCouteau\nKatana\nDesert Eagle\nPisolet\nGrenade\nTec49\nSawn-off\nAK47\nMinigun","Envoyer","Annuler");
Dnormal = 1;
}
}
}
return 1;
}
    if(dialogid==1 && response==1)
    {
		switch(listitem)
		{
			case 0:
			{
            new rando = random(sizeof(Team1Spawns));
            new name[MAX_PLAYER_NAME], string[124+MAX_PLAYER_NAME];
            GetPlayerName(playerid, name, sizeof(name));
            format(string, sizeof(string), "{FFFF00}%s {FFFFFF}vient de rejoindre le dm 1 swan off tapez /dm pour l'affronter.", name);
            SendClientMessageToAll(-1, string);
            SendClientMessage(playerid, COLOR_GREEN,"Pour quitter le dm tapez /ldm");
			SetPlayerArmour(playerid, 0);
 		    format(pseudofinal, 70, "[DM1]_%s", pseudoinitial[playerid]);
		    SetPlayerName(playerid, pseudofinal);
			ResetPlayerWeapons(playerid);
            SetPlayerPos(playerid,Team1Spawns[rando][0], Team1Spawns[rando][1], Team1Spawns[rando][2]);
            SetPlayerHealth(playerid, 100.0);
            GivePlayerWeapon(playerid, 26,500);
            GameTextForPlayer(playerid, "~g~Bute tes adversaires",5000,5);
            SetPlayerVirtualWorld(playerid, 1);
            dm[playerid] = 1;
            }
			case 1:
			{
			new rando = random(sizeof(Team2Spawns));
            new name[MAX_PLAYER_NAME], string[124+MAX_PLAYER_NAME];
            GetPlayerName(playerid, name, sizeof(name));
            format(string, sizeof(string), "{FFFF00}%s {FFFFFF}vient de rejoindre le dm 2 desert eagle tapez /dm pour l'affronter.", name);
            SendClientMessageToAll(-1, string);
            SendClientMessage(playerid, COLOR_GREEN,"Pour quitter le dm tapez /ldm");
            SetPlayerArmour(playerid, 0);
            format(pseudofinal, 70, "[DM2]_%s", pseudoinitial[playerid]);
		    SetPlayerName(playerid, pseudofinal);
			ResetPlayerWeapons(playerid);
            SetPlayerPos(playerid,Team2Spawns[rando][0], Team2Spawns[rando][1], Team2Spawns[rando][2]);
            SetPlayerHealth(playerid, 100.0);
            GivePlayerWeapon(playerid, 24,500);
            GameTextForPlayer(playerid, "~g~Bute tes adversaires",5000,5);
            SetPlayerVirtualWorld(playerid, 2);
            dm[playerid] = 2;
            }
            case 2:
            {
            new rando = random(sizeof(Team3Spawns));
            new name[MAX_PLAYER_NAME], string[124+MAX_PLAYER_NAME];
            GetPlayerName(playerid, name, sizeof(name));
            format(string, sizeof(string), "{FFFF00}%s {FFFFFF}vient de rejoindre le dm 3 minigun tapez /dm pour l'affronter.", name);
            SendClientMessageToAll(-1, string);
            SendClientMessage(playerid, COLOR_GREEN,"Pour quitter le dm tapez /ldm");
            SetPlayerArmour(playerid, 0);
 		    format(pseudofinal, 70, "[DM3]_%s", pseudoinitial[playerid]);
		    SetPlayerName(playerid, pseudofinal);
			ResetPlayerWeapons(playerid);
            SetPlayerPos(playerid,Team3Spawns[rando][0], Team3Spawns[rando][1], Team3Spawns[rando][2]);
            SetPlayerHealth(playerid, 100.0);
            GivePlayerWeapon(playerid, 38,9999);
            GameTextForPlayer(playerid, "~g~Bute tes adversaires",5000,5);
            SetPlayerVirtualWorld(playerid, 3);
            dm[playerid] = 3;
            }
            case 3:
            {
            new rando = random(sizeof(Team4Spawns));
            new name[MAX_PLAYER_NAME], string[124+MAX_PLAYER_NAME];
            GetPlayerName(playerid, name, sizeof(name));
            format(string, sizeof(string), "{FFFF00}%s {FFFFFF}vient de rejoindre le dm 4 combat shotgun tapez /dm pour l'affronter.", name);
            SendClientMessageToAll(-1, string);
            SendClientMessage(playerid, COLOR_GREEN,"Pour quitter le dm tapez /ldm");
            SetPlayerArmour(playerid, 0);
 		    format(pseudofinal, 70, "[DM4]_%s", pseudoinitial[playerid]);
		    SetPlayerName(playerid, pseudofinal);
			ResetPlayerWeapons(playerid);
            SetPlayerPos(playerid,Team4Spawns[rando][0], Team4Spawns[rando][1], Team4Spawns[rando][2]);
            SetPlayerHealth(playerid, 100.0);
            GivePlayerWeapon(playerid, 27,500);
            GameTextForPlayer(playerid, "~g~Bute tes adversaires",5000,5);
            SetPlayerVirtualWorld(playerid, 4);
            dm[playerid] = 4;
                        }
            case 4:
            {
            new rando = random(sizeof(Team5Spawns));
            new name[MAX_PLAYER_NAME], string[124+MAX_PLAYER_NAME];
            GetPlayerName(playerid, name, sizeof(name));
            format(string, sizeof(string), "{FFFF00}%s {FFFFFF}vient de rejoindre le dm 5 fusil tapez /dm pour l'affronter.", name);
            SendClientMessageToAll(-1, string);
            SendClientMessage(playerid, COLOR_GREEN,"Pour quitter le dm tapez /ldm");
            SetPlayerArmour(playerid, 0);
 		    format(pseudofinal, 70, "[DM5]_%s", pseudoinitial[playerid]);
		    SetPlayerName(playerid, pseudofinal);
			ResetPlayerWeapons(playerid);
            SetPlayerPos(playerid,Team5Spawns[rando][0], Team5Spawns[rando][1], Team5Spawns[rando][2]);
            SetPlayerHealth(playerid, 100.0);
            GivePlayerWeapon(playerid, 25,500);
            GameTextForPlayer(playerid, "~g~Bute tes adversaires",5000,5);
            SetPlayerVirtualWorld(playerid, 5);
            dm[playerid] = 5;
           }
        }
     }
  return 1;
}
//------------------------------------------------------------------------------------------------------
public OnPlayerDeath(playerid, killerid, reason)
{
	new name[MAX_PLAYER_NAME];
	new string[256];
	new deathreason[20];
	new tmpp[256];
    DisablePlayerCheckpoint(playerid);
    hotdog = 0;
    SendDeathMessage(killerid, playerid, reason);
	GetPlayerName(playerid, name, sizeof(name));
	GetWeaponName(reason, deathreason, 20);
	if (killerid == INVALID_PLAYER_ID) {
	    switch (reason) {
			case WEAPON_DROWN:
			{
                format(string, sizeof(string), "*** %s s'est noyï¿½.***", name);
			}
			default:
			{
			    if (strlen(deathreason) > 0) {
					format(string, sizeof(string), "*** %s est mort.*** (%s)", name, deathreason);
				} else {
				    format(string, sizeof(string), "*** %s est mort.***", name);
				}
			}
		}
	}
	else {
	new killer[MAX_PLAYER_NAME];
	GivePlayerMoney(killerid, 5000);
	GivePlayerMoney(playerid, -2500);
	GetPlayerName(playerid, name, sizeof(name));
    format(tmpp, sizeof(tmpp), "~G~+5000$",name);
	GameTextForPlayer(killerid, tmpp, 1000,1);
	GetPlayerName(playerid, name, sizeof(name));
    format(tmpp, sizeof(tmpp), "~R~-2500$",name);
	GameTextForPlayer(playerid, tmpp, 1000,1);
	GetPlayerName(killerid, killer, sizeof(killer));
	if (strlen(deathreason) > 0) {
		format(string, sizeof(string), "*** %s ï¿½ tuï¿½ %s.*** (%s)", killer, name, deathreason);
		} else {
			}
		}
	SendClientMessageToAll(0xFF0000FF, string);
	if (Duel[playerid] == 2)
{
new tmp[128];
new name2[MAX_PLAYER_NAME];
GetWeaponName(reason, deathreason, 20);
GetPlayerName(playerid, name, sizeof(name));
GetPlayerName(killerid, name2, sizeof(name2));
format(tmp, sizeof(tmp), "%s s'est fait powned en face ï¿½ face contre %s (%s)!",name,name2,deathreason);
SendClientMessageToAll(bleu,tmp);
Duel[Duelid] = 0;
Duel[EDuelid] = 0;
SpawnPlayer(EDuelid);
SpawnPlayer(Duelid);
SetPlayerHealth(EDuelid, 100);
SetPlayerHealth(Duelid, 100);
if (map[Duelid] ==3) Dnormal = 0;
}

 	return 1;
}
public UnfreezePlayerAfterConnect(playerid)
{
   TogglePlayerControllable(playerid,true);
}
public OnPlayerSpawn(playerid)
{
  TogglePlayerControllable(playerid,false);
SetTimerEx("UnfreezePlayerAfterConnect",4000,false,"d",playerid);
SendClientMessage(playerid,COLOR_PINK,"Le système d'anti spawn-kill va s'arrêter dans un délai de 4 secondes");
Create3DTextLabel("Tapez ici /robinco pour braquer le Binco",COLOR_GREEN,binco,5.0);
Create3DTextLabel("Tapez ici /robar pour braquer le Bar",COLOR_GREEN,bar,5.0);
Create3DTextLabel("Tapez ici /robcoiff pour braquer le Coiffeur",COLOR_GREEN,coiffeur,5.0);
Create3DTextLabel("Tapez ici /robtatoo pour braquer le Tatoueur",COLOR_GREEN,tatouage,5.0);
Create3DTextLabel("Tapez ici /robresto pour braquer le Restaurant",COLOR_GREEN,resto,5.0);
Create3DTextLabel("Tapez ici /robmaga pour braquer le Magasin",COLOR_GREEN,magasin,5.0);
Create3DTextLabel("Tapez ici /robalam pour braquer l'Alhambra",COLOR_GREEN,alambra,5.0);
Create3DTextLabel("Tapez ici /robzip pour braquer le ZIP",COLOR_GREEN,zip,5.0);
Create3DTextLabel("Tapez ici /robammu pour braquer l'Ammunation",COLOR_GREEN,ammu,5.0);
Create3DTextLabel("Tapez ici /roburger pour braquer le Burger Shot",COLOR_GREEN,burger,5.0);
Create3DTextLabel("Tapez ici /robvictim pour braquer le Victim",COLOR_GREEN,victim,5.0);
Create3DTextLabel("Tapez ici /robshoes pour braquer le Magasin de Chaussure",COLOR_GREEN,shoes,5.0);


     if(dm[playerid] == 1)
	{
	   new rando = random(sizeof(Team1Spawns));
    SetPlayerPos(playerid,Team1Spawns[rando][0], Team1Spawns[rando][1], Team1Spawns[rando][2]);
	ResetPlayerWeapons(playerid);
	SetPlayerInterior(playerid,0);
	GivePlayerWeapon(playerid, 26, 50000);
	}
		if(dm[playerid] == 2)
	{
	   new rando = random(sizeof(Team2Spawns));
    SetPlayerPos(playerid,Team2Spawns[rando][0], Team2Spawns[rando][1], Team2Spawns[rando][2]);
	ResetPlayerWeapons(playerid);
	SetPlayerInterior(playerid,0);
	GivePlayerWeapon(playerid, 24, 50000);
	}
		if(dm[playerid] == 3)
	{
	   new rando = random(sizeof(Team3Spawns));
    SetPlayerPos(playerid,Team3Spawns[rando][0], Team3Spawns[rando][1], Team3Spawns[rando][2]);
	ResetPlayerWeapons(playerid);
	SetPlayerInterior(playerid,0);
	GivePlayerWeapon(playerid, 38, 50000);
	}
		if(dm[playerid] == 4)
	{
	   new rando = random(sizeof(Team4Spawns));
    SetPlayerPos(playerid,Team4Spawns[rando][0], Team4Spawns[rando][1], Team4Spawns[rando][2]);
	ResetPlayerWeapons(playerid);
	SetPlayerInterior(playerid,0);
	GivePlayerWeapon(playerid, 27, 50000);
	}
		if(dm[playerid] == 5)
	{
	   new rando = random(sizeof(Team5Spawns));
    SetPlayerPos(playerid,Team5Spawns[rando][0], Team5Spawns[rando][1], Team5Spawns[rando][2]);
	ResetPlayerWeapons(playerid);
	SetPlayerInterior(playerid,0);
    GivePlayerWeapon(playerid, 16,500);
    GivePlayerWeapon(playerid, 25,500);
	}
    SetTimer("Save",300000,false);
   	TextDrawShowForPlayer(playerid, PHealth[playerid]);
	TextDrawShowForPlayer(playerid, PPing[playerid]);
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
if(classid == 0 || classid == 1 || classid == 2)
    {
        gTeam[playerid] = GROOVES;
        GameTextForPlayer(playerid,"~G~GROOVES",1000,6);
        SetPlayerPos(playerid, 2533.9509,-1667.9064,15.1659);
        SetPlayerCameraPos(playerid, 2532.9509,-1664.9064,15.1659);
        SetPlayerFacingAngle(playerid, 86.2342);
        SetPlayerCameraLookAt(playerid, 2533.9509,-1667.9064,15.1659);
        ApplyAnimation( playerid,"SMOKING", "M_smklean_loop", 4.0, 0, 0, 0, 0, 0);
        SetPlayerColor(playerid,0x33AA33AA);
    }
else if(classid == 3 || classid == 4 || classid == 5)
    {
        gTeam[playerid] = BALLAS;
        GameTextForPlayer(playerid,"~P~BALLAS",1000,6);
        SetPlayerPos(playerid,1977.9478,-1197.4344,25.8362);
        SetPlayerCameraPos(playerid,1974.9476,-1197.4344,25.8362);
        SetPlayerCameraLookAt(playerid,1977.9476,-1197.4344,25.8362);
        SetPlayerFacingAngle(playerid,91.1924);
        ApplyAnimation( playerid,"ped", "fucku", 4.1, 0, 1, 1, 1, 1 );
        SetPlayerColor(playerid,0xCC00FFFF);
      }
else if(classid == 6 || classid == 7 || classid == 8)
    {
        gTeam[playerid] = FLICS;
        GameTextForPlayer(playerid,"~B~FLICS",1000,6);
        SetPlayerPos(playerid,1552.2748,-1675.5259,16.1953);
        SetPlayerCameraPos(playerid,1549.2748,-1675.5259,16.1953);
        SetPlayerCameraLookAt(playerid,1552.2748,-1675.5259,16.1953);
        SetPlayerFacingAngle(playerid,90.0352);
        ApplyAnimation( playerid,"ped", "ARRESTgun", 4.0, 0, 0, 0, 0, 0);
        SetPlayerColor(playerid,0x006EFFFF);
      }
else if(classid == 9 || classid == 10 || classid == 11)
    {
        gTeam[playerid] = DANANGBOY;
        GameTextForPlayer(playerid,"~Y~DA NANG BOY",1000,6);
        SetPlayerPos(playerid,2838.1057,-2348.0034,19.2058);
        SetPlayerCameraPos(playerid,2837.1057,-2344.0034,19.2058);
        SetPlayerCameraLookAt(playerid,2838.1057,-2348.0034,19.2058);
        SetPlayerFacingAngle(playerid,358.3733);
        ApplyAnimation(playerid, "COP_AMBIENT", "Coplook_loop", 4.0, 0, 0, 0, 0, 0);
        SetPlayerColor(playerid,0xFFFB00FF);
      }
else if(classid == 12 || classid == 13 || classid == 14)
    {
        gTeam[playerid] = CIVILS;
        GameTextForPlayer(playerid,"~p~CIVILS",1000,6);
        SetPlayerPos(playerid,1733.8630,-1347.9393,15.7705);
        SetPlayerCameraPos(playerid,1736.8630,-1347.9393,15.7705);
        SetPlayerCameraLookAt(playerid,1733.8630,-1347.9393,15.7705);
        SetPlayerFacingAngle(playerid,269.9116);
        ApplyAnimation(playerid, "RAPPING", "Laugh_01", 4.0, 0, 0, 0, 0, 0);
        SetPlayerColor(playerid,0x2600FFFF);
      }
else if(classid == 15 || classid == 16 || classid == 17)
    {
        gTeam[playerid] = BUISINNESMAN;
        GameTextForPlayer(playerid,"~r~BUISINESS-MAN",1000,6);
        SetPlayerPos(playerid,1422.1661,-1179.9872,25.9922);
        SetPlayerCameraPos(playerid,1422.1661,-1176.9872,25.9922);
        SetPlayerCameraLookAt(playerid,1422.1661,-1179.9872,25.9922);
        SetPlayerFacingAngle(playerid,359.3095);
        ApplyAnimation(playerid,"PED","IDLE_CHAT",4.0,0,0,0,0,0);
        SetPlayerColor(playerid,0xFF0A16FF);
      }
else if(classid == 18 || classid == 19 || classid == 20)
    {
        gTeam[playerid] = TRAVAILLEURS;
        GameTextForPlayer(playerid,"~W~TRAVAILLEURS",1000,6);
        SetPlayerPos(playerid,2352.2861,-1359.4155,24.3984);
        SetPlayerCameraPos(playerid,2355.2861,-1359.4155,24.3984);
        SetPlayerCameraLookAt(playerid,2352.2861,-1359.4155,24.3984);
        SetPlayerFacingAngle(playerid,268.5968);
        SetPlayerColor(playerid,0xFFFFFFFF);
      }
else if(classid == 21 || classid == 22 || classid == 23)
    {
        gTeam[playerid] = MECANICIEN;
        GameTextForPlayer(playerid,"~W~MECANICIENS",1000,6);
        SetPlayerPos(playerid,2644.6736,-2038.7173,13.5500);
        SetPlayerCameraPos(playerid,2641.6736,-2035.7173,13.5500);
        SetPlayerCameraLookAt(playerid,2644.6736,-2038.7173,13.5500);
        SetPlayerFacingAngle(playerid,1.5065);
        SetPlayerColor(playerid,0x878787FF);
      }
else if(classid == 24 || classid == 25 || classid == 26)
    {
        gTeam[playerid] = MAFIARUSSE;
        GameTextForPlayer(playerid,"~p~MAFIA RUSSE",1000,6);
        SetPlayerPos(playerid,669.9679,-1275.7726,13.4609);
        SetPlayerCameraPos(playerid,666.9679,-1275.7726,13.4609);
        SetPlayerCameraLookAt(playerid,669.9679,-1275.7726,13.4609);
        SetPlayerFacingAngle(playerid,87.1914);
        ApplyAnimation(playerid, "SHOP", "ROB_Loop_Threat", 4.0, 0, 0, 0, 0, 0);
        SetPlayerColor(playerid,0xD900D2FF);
      }
else if(classid == 27 || classid == 28 || classid == 29)
    {
        gTeam[playerid] = TRIAD;
        GameTextForPlayer(playerid,"~p~TRIAD",1000,6);
        SetPlayerPos(playerid,1129.0514,-1469.3722,15.7464);
        SetPlayerCameraPos(playerid,1131.0514,-1465.3722,15.7464);
        SetPlayerCameraLookAt(playerid,1129.0514,-1469.3722,15.7464);
        SetPlayerFacingAngle(playerid,358.7380);
        ApplyAnimation(playerid, "SHOP", "ROB_Loop_Threat", 4.0, 0, 0, 0, 0, 0);
        SetPlayerColor(playerid,0xD900D2FF);
      }
else if(classid == 30 || classid == 31 || classid == 32)
    {
        gTeam[playerid] = GIRLS;
        GameTextForPlayer(playerid,"~p~GIRLS",1000,6);
        SetPlayerPos(playerid,2421.5200,-1221.7500,25.3998);
        SetPlayerCameraPos(playerid,2421.5200,-1225.7500,25.3998);
        SetPlayerCameraLookAt(playerid,2421.5200,-1221.7500,25.3998);
        SetPlayerFacingAngle(playerid,180.0000);
        ApplyAnimation(playerid, "SMOKING", "F_smklean_loop", 4.0, 0, 0, 0, 0, 0);
        SetPlayerColor(playerid,0xFF30B7FF);
      }
else if(classid == 33 || classid == 34 || classid == 35)
    {
        gTeam[playerid] = BRAQUEUR;
        GameTextForPlayer(playerid,"~G~BRAQUEUR",1000,6);
        SetPlayerPos(playerid,1712.8864,-1129.6523,24.0859);
        SetPlayerCameraPos(playerid,1712.8864,-1133.6523,24.0859);
        SetPlayerCameraLookAt(playerid,1712.8864,-1129.6523,24.0859);
        SetPlayerFacingAngle(playerid,183.6575);
        ApplyAnimation(playerid, "DEALER", "DEALER_DEAL", 4.0, 0, 0, 0, 0, 0);
        SetPlayerColor(playerid,0x00AB17FF);
      }
else if(classid == 36 || classid == 37 || classid == 38)
    {
        gTeam[playerid] = CHICKEN;
        GameTextForPlayer(playerid,"~Y~CHICKEN",1000,6);
        SetPlayerPos(playerid,816.1298,-1624.1692,13.5469);
        SetPlayerCameraPos(playerid,820.1298,-1624.1692,13.5469);
        SetPlayerCameraLookAt(playerid,816.1298,-1624.1692,13.5469);
        SetPlayerFacingAngle(playerid,273.4866);
        ApplyAnimation(playerid, "FOOD", "EAT_Burger", 3.00, 0, 0, 0, 0, 0);
        SetPlayerColor(playerid,0xFFEE38FF);
      }
      else if(classid == 39 || classid == 40 || classid == 41)
    {
        gTeam[playerid] = CLODOS;
        GameTextForPlayer(playerid,"~w~Sans Abris",1000,6);
        SetPlayerPos(playerid,2439.8875,-1774.9139,13.5469,95.2077);
        SetPlayerCameraPos(playerid,2441.3975,-1773.6748,13.5469,90.4842);
        SetPlayerCameraLookAt(playerid,2439.8875,-1774.9139,13.5469,95.2077);
        SetPlayerFacingAngle(playerid,273.4866);
        ApplyAnimation( playerid,"BASEBALL", "Bat_1", 4.1, 0, 1, 1, 1, 1 );
        SetPlayerColor(playerid,0x808000FF);
      }
return 1;
}
public OnGameModeInit()
{
    SetTimer("Messages", 150000, true);
	SetGameModeText("[FR] LS-TDM Libre");
    for(new i = 0; i < MAX_PLAYERS; i++)
    IsInDM[i] = false;
	ShowPlayerMarkers(1);
	ShowNameTags(1);
	EnableStuntBonusForAll(0);
	SetTimer("NomDuTimer",1000,true);
	SetTimer("VerificationCompteur",50,true);
	SetTimer("payday",3600,true);

UsePlayerPedAnims();

AddPlayerClass(105, 2531.9509, -1667.9064, 15.1659, 86.2342, 26, 999, 24, 999, 4, 1);
AddPlayerClass(106, 2531.9509, -1667.9064, 15.1659, 86.2342, 26, 999, 24, 999, 4, 1);
AddPlayerClass(107, 2531.9509, -1667.9064, 15.1659, 86.2342, 26, 999, 24, 999, 4, 1);

AddPlayerClass(102, 1977.9478, -1197.4344, 25.8362, 91.1924, 28, 999, 24, 999, 5, 1);
AddPlayerClass(103, 1977.9478, -1197.4344, 25.8362, 91.1924, 28, 999, 24, 999, 5, 1);
AddPlayerClass(104, 1977.9478, -1197.4344, 25.8362, 91.1924, 28, 999, 24, 999, 5, 1);

AddPlayerClass(280, 1552.2748, -1675.5259, 16.1953, 91.1924, 27, 999, 30, 999, 3, 1);
AddPlayerClass(282, 1552.2748, -1675.5259, 16.1953, 91.1924, 27, 999, 30, 999, 3, 1);
AddPlayerClass(283, 1552.2748, -1675.5259, 16.1953, 91.1924, 27, 999, 30, 999, 3, 1);

AddPlayerClass(121, 2838.1057, -2346.0034, 19.2058, 358.3733, 32, 999, 23, 999, 8, 1);
AddPlayerClass(122, 2838.1057, -2346.0034, 19.2058, 358.3733, 32, 999, 23, 999, 8, 1);
AddPlayerClass(123, 2838.1057, -2346.0034, 19.2058, 358.3733, 32, 999, 23, 999, 8, 1);

AddPlayerClass(28, 1735.8630, -1347.9393, 15.7705, 269.9116, 32, 999, 22, 999, 1, 1);
AddPlayerClass(29, 1735.8630, -1347.9393, 15.7705, 269.9116, 32, 999, 22, 999, 1, 1);
AddPlayerClass(188, 1735.8630, -1347.9393, 15.7705, 269.9116, 32, 999, 22, 999, 1, 1);

AddPlayerClass(163, 1422.1661, -1177.9872, 25.9922, 359.3095, 22, 999, 29, 999, 7, 1);
AddPlayerClass(186, 1422.1661, -1177.9872, 25.9922, 359.3095, 22, 999, 29, 999, 7, 1);
AddPlayerClass(187, 1422.1661, -1177.9872, 25.9922, 359.3095, 22, 999, 29, 999, 7, 1);

AddPlayerClass(27, 2354.2861, -1359.4155, 24.3984, 268.5968, 25, 999, 31, 999, 6, 1);
AddPlayerClass(153, 2354.2861, -1359.4155, 24.3984, 268.5968, 25, 999, 31, 999, 6, 1);
AddPlayerClass(260, 2354.2861, -1359.4155, 24.3984, 268.5968, 25, 999, 31, 999, 6, 1);

AddPlayerClass(50, 2644.6736, -2036.7173, 13.5500, 1.5065, 27, 999, 30, 999, 41, 99999);
AddPlayerClass(258, 2644.6736, -2036.7173, 13.5500, 1.5065, 27, 999, 30, 999, 41, 99999);
AddPlayerClass(261, 2644.6736, -2036.7173, 13.5500, 1.5065, 27, 999, 30, 999, 41, 99999);

AddPlayerClass(112, 668.9679, -1275.7726, 13.4609, 87.1914, 29, 999, 27, 999, 1, 1);
AddPlayerClass(111, 668.9679, -1275.7726, 13.4609, 87.1914, 29, 999, 27, 999, 1, 1);
AddPlayerClass(113, 668.9679, -1275.7726, 13.4609, 87.1914, 29, 999, 27, 999, 1, 1);

AddPlayerClass(117, 1129.0514, -1468.3722, 15.7464, 358.7380, 29, 999, 26, 999, 8, 1);
AddPlayerClass(204, 1129.0514, -1468.3722, 15.7464, 358.7380, 29, 999, 26, 999, 8, 1);
AddPlayerClass(208, 1129.0514, -1468.3722, 15.7464, 358.7380, 29, 999, 26, 999, 8, 1);

AddPlayerClass(192, 2421.5200, -1223.7500, 25.3998, 180.0000, 24, 999, 26, 999, 10, 1);
AddPlayerClass(246, 2421.5200, -1223.7500, 25.3998, 180.0000, 24, 999, 26, 999, 10, 1);
AddPlayerClass(87, 2421.5200, -1223.7500, 25.3998, 180.0000, 24, 999, 26, 999, 10, 1);

AddPlayerClass(299, 1712.8864, -1131.6523, 24.0859, 183.6575, 26, 999, 24, 999, 4, 1);
AddPlayerClass(292, 1712.8864, -1131.6523, 24.0859, 183.6575, 26, 999, 24, 999, 4, 1);
AddPlayerClass(293, 1712.8864, -1131.6523, 24.0859, 183.6575, 26, 999, 24, 999, 4, 1);

AddPlayerClass(167, 816.1298, -1624.1692, 13.5469, 273.4866, 32, 999, 39, 999, 8, 1);
AddPlayerClass(205, 816.1298, -1624.1692, 13.5469, 273.4866, 32, 999, 39, 999, 8, 1);
AddPlayerClass(155, 816.1298, -1624.1692, 13.5469, 273.4866, 32, 999, 39, 999, 8, 1);

AddPlayerClass(135, 2439.8875,-1774.9139,13.5469,95.2077,4,1,23,999,29,999);
AddPlayerClass(137, 2439.8875,-1774.9139,13.5469,95.2077,4,1,23,999,29,999);
AddPlayerClass(212, 2439.8875,-1774.9139,13.5469,95.2077,4,1,23,999,29,999);

AddStaticVehicle(588,783.0263,-1637.3671,13.3103,90.1556,1,1); // van 1
AddStaticVehicle(588,783.1420,-1633.9399,13.2905,90.3979,0,0); // van 2
AddStaticVehicle(588,783.1110,-1630.4070,13.2914,89.8296,0,0); // van 3
AddStaticVehicle(448,783.0247,-1626.7286,12.9826,89.1438,0,0); // pizza 1
AddStaticVehicle(448,782.9750,-1623.0658,12.9811,89.7237,0,0); // pizza 2
AddStaticVehicle(448,782.6379,-1619.5103,12.9820,88.3149,0,0); // pizza 3

hotinfo = CreatePickup(1239,1,800.7488,-1629.2859,13.3828,-1);

AddStaticVehicle(567,2497.8320,-1681.3807,13.2215,284.5126,86,86); // groove 1
AddStaticVehicle(567,2489.8396,-1682.3148,13.2042,270.2081,86,86); // groove 2
AddStaticVehicle(468,2490.0396,-1654.8390,13.0221,270.1897,86,86); // groove 3
AddStaticVehicle(468,2495.2131,-1655.1078,13.0507,258.6732,86,86); // groove 4
AddStaticVehicle(518,2507.7258,-1671.8767,13.0487,350.2875,86,86); // groove 5
AddStaticVehicle(535,2505.4011,-1662.2262,13.1653,38.0089,86,86); // groove 6
AddStaticVehicle(522,2419.6365,-1684.6371,13.3249,358.7100,86,86); // groove 7

AddStaticVehicle(481,1967.6425,-1289.0939,23.5006,358.3140,150,150); // ballas 1
AddStaticVehicle(517,1966.5317,-1220.9113,25.0175,3.5852,150,150); // ballas 2
AddStaticVehicle(517,1965.9900,-1211.9219,25.2598,3.6131,150,150); // ballas 3
AddStaticVehicle(526,1965.2758,-1203.0453,25.4104,4.3475,150,150); // ballas 4
AddStaticVehicle(526,1964.4331,-1191.5568,25.6005,4.4478,150,150); // ballas 5
AddStaticVehicle(545,1951.1827,-1143.3114,25.5784,90.8479,150,150); // ballas 6
AddStaticVehicle(558,1934.1295,-1123.5576,25.5974,0.0764,150,150); // ballas 7

	AddStaticVehicle(451,2040.0520,1319.2799,10.3779,183.2439,16,16);
	AddStaticVehicle(429,2040.5247,1359.2783,10.3516,177.1306,13,13);
	AddStaticVehicle(421,2110.4102,1398.3672,10.7552,359.5964,13,13);
	AddStaticVehicle(411,2074.9624,1479.2120,10.3990,359.6861,64,64);
	AddStaticVehicle(477,2075.6038,1666.9750,10.4252,359.7507,94,94);
	AddStaticVehicle(541,2119.5845,1938.5969,10.2967,181.9064,22,22);
	AddStaticVehicle(541,1843.7881,1216.0122,10.4556,270.8793,60,1);
	AddStaticVehicle(402,1944.1003,1344.7717,8.9411,0.8168,30,30);
	AddStaticVehicle(402,1679.2278,1316.6287,10.6520,180.4150,90,90);
	AddStaticVehicle(415,1685.4872,1751.9667,10.5990,268.1183,25,1);
	AddStaticVehicle(411,2034.5016,1912.5874,11.9048,0.2909,123,1);
	AddStaticVehicle(411,2172.1682,1988.8643,10.5474,89.9151,116,1);
	AddStaticVehicle(429,2245.5759,2042.4166,10.5000,270.7350,14,14);
	AddStaticVehicle(477,2361.1538,1993.9761,10.4260,178.3929,101,1);
	AddStaticVehicle(550,2221.9946,1998.7787,9.6815,92.6188,53,53);
	AddStaticVehicle(558,2243.3833,1952.4221,14.9761,359.4796,116,1);
	AddStaticVehicle(587,2276.7085,1938.7263,31.5046,359.2321,40,1);
	AddStaticVehicle(587,2602.7769,1853.0667,10.5468,91.4813,43,1);
	AddStaticVehicle(603,2610.7600,1694.2588,10.6585,89.3303,69,1);
	AddStaticVehicle(587,2635.2419,1075.7726,10.5472,89.9571,53,1);
	AddStaticVehicle(437,2577.2354,1038.8063,10.4777,181.7069,35,1);
	AddStaticVehicle(535,2039.1257,1545.0879,10.3481,359.6690,123,1);
	AddStaticVehicle(535,2009.8782,2411.7524,10.5828,178.9618,66,1);
	AddStaticVehicle(429,2010.0841,2489.5510,10.5003,268.7720,1,2);
	AddStaticVehicle(415,2076.4033,2468.7947,10.5923,359.9186,36,1);
	AddStaticVehicle(487,2093.2754,2414.9421,74.7556,89.0247,26,57);
	AddStaticVehicle(506,2352.9026,2577.9768,10.5201,0.4091,7,7);
	AddStaticVehicle(506,2166.6963,2741.0413,10.5245,89.7816,52,52);
	AddStaticVehicle(411,1960.9989,2754.9072,10.5473,200.4316,112,1);
	AddStaticVehicle(429,1919.5863,2760.7595,10.5079,100.0753,2,1);
	AddStaticVehicle(415,1673.8038,2693.8044,10.5912,359.7903,40,1);
	AddStaticVehicle(402,1591.0482,2746.3982,10.6519,172.5125,30,30);
	AddStaticVehicle(603,1580.4537,2838.2886,10.6614,181.4573,75,77);
	AddStaticVehicle(550,1555.2734,2750.5261,10.6388,91.7773,62,62);
	AddStaticVehicle(535,1455.9305,2878.5288,10.5837,181.0987,118,1);
	AddStaticVehicle(477,1537.8425,2578.0525,10.5662,0.0650,121,1);
	AddStaticVehicle(451,1433.1594,2607.3762,10.3781,88.0013,16,16);
	AddStaticVehicle(603,2223.5898,1288.1464,10.5104,182.0297,18,1);
	AddStaticVehicle(558,2451.6707,1207.1179,10.4510,179.8960,24,1);
	AddStaticVehicle(550,2461.7253,1357.9705,10.6389,180.2927,62,62);
	AddStaticVehicle(558,2461.8162,1629.2268,10.4496,181.4625,117,1);
	AddStaticVehicle(477,2395.7554,1658.9591,10.5740,359.7374,0,1);
	AddStaticVehicle(404,1553.3696,1020.2884,10.5532,270.6825,119,50);
	AddStaticVehicle(400,1380.8304,1159.1782,10.9128,355.7117,123,1);
	AddStaticVehicle(418,1383.4630,1035.0420,10.9131,91.2515,117,227);
	AddStaticVehicle(404,1445.4526,974.2831,10.5534,1.6213,109,100);
	AddStaticVehicle(400,1704.2365,940.1490,10.9127,91.9048,113,1);
	AddStaticVehicle(404,1658.5463,1028.5432,10.5533,359.8419,101,101);
	AddStaticVehicle(581,1677.6628,1040.1930,10.4136,178.7038,58,1);
	AddStaticVehicle(581,1383.6959,1042.2114,10.4121,85.7269,66,1);
	AddStaticVehicle(581,1064.2332,1215.4158,10.4157,177.2942,72,1);
	AddStaticVehicle(581,1111.4536,1788.3893,10.4158,92.4627,72,1);
	AddStaticVehicle(522,953.2818,1806.1392,8.2188,235.0706,3,8);
	AddStaticVehicle(522,995.5328,1886.6055,10.5359,90.1048,3,8);
	AddStaticVehicle(521,993.7083,2267.4133,11.0315,1.5610,75,13);
	AddStaticVehicle(535,1439.5662,1999.9822,10.5843,0.4194,66,1);
	AddStaticVehicle(522,1430.2354,1999.0144,10.3896,352.0951,6,25);
	AddStaticVehicle(522,2156.3540,2188.6572,10.2414,22.6504,6,25);
	AddStaticVehicle(598,2277.6846,2477.1096,10.5652,180.1090,0,1);
	AddStaticVehicle(598,2268.9888,2443.1697,10.5662,181.8062,0,1);
	AddStaticVehicle(598,2256.2891,2458.5110,10.5680,358.7335,0,1);
	AddStaticVehicle(598,2251.6921,2477.0205,10.5671,179.5244,0,1);
	AddStaticVehicle(523,2294.7305,2441.2651,10.3860,9.3764,0,0);
	AddStaticVehicle(523,2290.7268,2441.3323,10.3944,16.4594,0,0);
	AddStaticVehicle(523,2295.5503,2455.9656,2.8444,272.6913,0,0);
	AddStaticVehicle(522,2476.7900,2532.2222,21.4416,0.5081,8,82);
	AddStaticVehicle(522,2580.5320,2267.9595,10.3917,271.2372,8,82);
	AddStaticVehicle(522,2814.4331,2364.6641,10.3907,89.6752,36,105);
	AddStaticVehicle(535,2827.4143,2345.6953,10.5768,270.0668,97,1);
	AddStaticVehicle(521,1670.1089,1297.8322,10.3864,359.4936,87,118);
	AddStaticVehicle(487,1614.7153,1548.7513,11.2749,347.1516,58,8);
	AddStaticVehicle(487,1647.7902,1538.9934,11.2433,51.8071,0,8);
	AddStaticVehicle(487,1608.3851,1630.7268,11.2840,174.5517,58,8);
	AddStaticVehicle(476,1283.0006,1324.8849,9.5332,275.0468,7,6); 
	AddStaticVehicle(476,1283.5107,1361.3171,9.5382,271.1684,1,6); 
	AddStaticVehicle(476,1283.6847,1386.5137,11.5300,272.1003,89,91);
	AddStaticVehicle(476,1288.0499,1403.6605,11.5295,243.5028,119,117);
	AddStaticVehicle(415,1319.1038,1279.1791,10.5931,0.9661,62,1);
	AddStaticVehicle(521,1710.5763,1805.9275,10.3911,176.5028,92,3);
	AddStaticVehicle(521,2805.1650,2027.0028,10.3920,357.5978,92,3);
	AddStaticVehicle(535,2822.3628,2240.3594,10.5812,89.7540,123,1);
	AddStaticVehicle(521,2876.8013,2326.8418,10.3914,267.8946,115,118);
	AddStaticVehicle(429,2842.0554,2637.0105,10.5000,182.2949,1,3);
	AddStaticVehicle(549,2494.4214,2813.9348,10.5172,316.9462,72,39);
	AddStaticVehicle(549,2327.6484,2787.7327,10.5174,179.5639,75,39);
	AddStaticVehicle(549,2142.6970,2806.6758,10.5176,89.8970,79,39);
	AddStaticVehicle(521,2139.7012,2799.2114,10.3917,229.6327,25,118);
	AddStaticVehicle(521,2104.9446,2658.1331,10.3834,82.2700,36,0);
	AddStaticVehicle(521,1914.2322,2148.2590,10.3906,267.7297,36,0);
	AddStaticVehicle(549,1904.7527,2157.4312,10.5175,183.7728,83,36);
	AddStaticVehicle(549,1532.6139,2258.0173,10.5176,359.1516,84,36);
	AddStaticVehicle(521,1534.3204,2202.8970,10.3644,4.9108,118,118);
	AddStaticVehicle(549,1613.1553,2200.2664,10.5176,89.6204,89,35);
	AddStaticVehicle(400,1552.1292,2341.7854,10.9126,274.0815,101,1);
	AddStaticVehicle(404,1637.6285,2329.8774,10.5538,89.6408,101,101);
	AddStaticVehicle(400,1357.4165,2259.7158,10.9126,269.5567,62,1);
	AddStaticVehicle(411,1281.7458,2571.6719,10.5472,270.6128,106,1);
	AddStaticVehicle(522,1305.5295,2528.3076,10.3955,88.7249,3,8);
	AddStaticVehicle(521,993.9020,2159.4194,10.3905,88.8805,74,74);
	AddStaticVehicle(415,1512.7134,787.6931,10.5921,359.5796,75,1);
	AddStaticVehicle(522,2299.5872,1469.7910,10.3815,258.4984,3,8);
	AddStaticVehicle(522,2133.6428,1012.8537,10.3789,87.1290,3,8);

	//Monday 13th Additions ~ Jax
	AddStaticVehicle(415,2266.7336,648.4756,11.0053,177.8517,0,1); //
	AddStaticVehicle(461,2404.6636,647.9255,10.7919,183.7688,53,1); //
	AddStaticVehicle(506,2628.1047,746.8704,10.5246,352.7574,3,3); //
	AddStaticVehicle(549,2817.6445,928.3469,10.4470,359.5235,72,39); //
	AddStaticVehicle(562,1919.8829,947.1886,10.4715,359.4453,11,1); //
	AddStaticVehicle(562,1881.6346,1006.7653,10.4783,86.9967,11,1); //
	AddStaticVehicle(562,2038.1044,1006.4022,10.4040,179.2641,11,1); //
	AddStaticVehicle(562,2038.1614,1014.8566,10.4057,179.8665,11,1); //
	AddStaticVehicle(562,2038.0966,1026.7987,10.4040,180.6107,11,1); //
	
	//Uber haxed
	AddStaticVehicle(422,9.1065,1165.5066,19.5855,2.1281,101,25); //
	AddStaticVehicle(463,19.8059,1163.7103,19.1504,346.3326,11,11); //
	AddStaticVehicle(463,12.5740,1232.2848,18.8822,121.8670,22,22); //
	AddStaticVehicle(586,69.4633,1217.0189,18.3304,158.9345,10,1); //
	AddStaticVehicle(586,-199.4185,1223.0405,19.2624,176.7001,25,1); //
	AddStaticVehicle(476,325.4121,2538.5999,17.5184,181.2964,71,77); //
	AddStaticVehicle(476,291.0975,2540.0410,17.5276,182.7206,7,6); //
	AddStaticVehicle(576,384.2365,2602.1763,16.0926,192.4858,72,1); //
	AddStaticVehicle(586,423.8012,2541.6870,15.9708,338.2426,10,1); //
	AddStaticVehicle(586,-244.0047,2724.5439,62.2077,51.5825,10,1); //
	AddStaticVehicle(586,-311.1414,2659.4329,62.4513,310.9601,27,1); //

	//uber haxed x 50
	AddStaticVehicle(543,596.8064,866.2578,-43.2617,186.8359,67,8); //
	AddStaticVehicle(543,835.0838,836.8370,11.8739,14.8920,8,90); //
	AddStaticVehicle(549,843.1893,838.8093,12.5177,18.2348,79,39); //
	AddStaticVehicle(400,-235.9767,1045.8623,19.8158,180.0806,75,1); //
	AddStaticVehicle(599,-211.5940,998.9857,19.8437,265.4935,0,1); //
	AddStaticVehicle(422,-304.0620,1024.1111,19.5714,94.1812,96,25); //
	AddStaticVehicle(588,-290.2229,1317.0276,54.1871,81.7529,1,1); //
	AddStaticVehicle(451,-290.3145,1567.1534,75.0654,133.1694,61,61); //
	AddStaticVehicle(470,280.4914,1945.6143,17.6317,310.3278,43,0); //
	AddStaticVehicle(470,272.2862,1949.4713,17.6367,285.9714,43,0); //
	AddStaticVehicle(470,271.6122,1961.2386,17.6373,251.9081,43,0); //
	AddStaticVehicle(470,279.8705,1966.2362,17.6436,228.4709,43,0); //
	AddStaticVehicle(433,277.6437,1985.7559,18.0772,270.4079,43,0); //
	AddStaticVehicle(433,277.4477,1994.8329,18.0773,267.7378,43,0); //
	AddStaticVehicle(568,-441.3438,2215.7026,42.2489,191.7953,41,29); //
	AddStaticVehicle(568,-422.2956,2225.2612,42.2465,0.0616,41,29); //
	AddStaticVehicle(568,-371.7973,2234.5527,42.3497,285.9481,41,29); //
	AddStaticVehicle(568,-360.1159,2203.4272,42.3039,113.6446,41,29); //
	AddStaticVehicle(468,-660.7385,2315.2642,138.3866,358.7643,6,6); //
	AddStaticVehicle(460,-1029.2648,2237.2217,42.2679,260.5732,1,3); //
	AddStaticVehicle(419,95.0568,1056.5530,13.4068,192.1461,13,76); //
	AddStaticVehicle(429,114.7416,1048.3517,13.2890,174.9752,1,2); //
	AddStaticVehicle(411,-290.0065,1759.4958,42.4154,89.7571,116,1); //
	AddStaticVehicle(522,-302.5649,1777.7349,42.2514,238.5039,6,25); //
	AddStaticVehicle(522,-302.9650,1776.1152,42.2588,239.9874,8,82); //
	AddStaticVehicle(533,-301.0404,1750.8517,42.3966,268.7585,75,1); //
	AddStaticVehicle(535,-866.1774,1557.2700,23.8319,269.3263,31,1); //
	AddStaticVehicle(550,-799.3062,1518.1556,26.7488,88.5295,53,53); //
	AddStaticVehicle(521,-749.9730,1589.8435,26.5311,125.6508,92,3); //
	AddStaticVehicle(522,-867.8612,1544.5282,22.5419,296.0923,3,3); //
	AddStaticVehicle(554,-904.2978,1553.8269,25.9229,266.6985,34,30); //
	AddStaticVehicle(521,-944.2642,1424.1603,29.6783,148.5582,92,3); //
	AddStaticVehicle(429,-237.7157,2594.8804,62.3828,178.6802,1,2); //
	AddStaticVehicle(463,-196.3012,2774.4395,61.4775,303.8402,22,22); //
	AddStaticVehicle(519,-1341.1079,-254.3787,15.0701,321.6338,1,1); //
	AddStaticVehicle(519,-1371.1775,-232.3967,15.0676,315.6091,1,1); //
	AddStaticVehicle(519,1642.9850,-2425.2063,14.4744,159.8745,1,1); //
	AddStaticVehicle(519,1734.1311,-2426.7563,14.4734,172.2036,1,1); //
    AddStaticVehicle(415,-680.9882,955.4495,11.9032,84.2754,36,1); //
	AddStaticVehicle(460,-816.3951,2222.7375,43.0045,268.1861,1,3); //
	AddStaticVehicle(460,-94.6885,455.4018,1.5719,250.5473,1,3); //
	AddStaticVehicle(460,1624.5901,565.8568,1.7817,200.5292,1,3); //
	AddStaticVehicle(460,1639.3567,572.2720,1.5311,206.6160,1,3); //
	AddStaticVehicle(460,2293.4219,517.5514,1.7537,270.7889,1,3); //
	AddStaticVehicle(460,2354.4690,518.5284,1.7450,270.2214,1,3); //
	AddStaticVehicle(460,772.4293,2912.5579,1.0753,69.6706,1,3); //

	// 22/4 UPDATE
	AddStaticVehicle(560,2133.0769,1019.2366,10.5259,90.5265,9,39); //
	AddStaticVehicle(560,2142.4023,1408.5675,10.5258,0.3660,17,1); //
	AddStaticVehicle(560,2196.3340,1856.8469,10.5257,179.8070,21,1); //
	AddStaticVehicle(560,2103.4146,2069.1514,10.5249,270.1451,33,0); //
	AddStaticVehicle(560,2361.8042,2210.9951,10.3848,178.7366,37,0); //
	AddStaticVehicle(560,-1993.2465,241.5329,34.8774,310.0117,41,29); //
	AddStaticVehicle(559,-1989.3235,270.1447,34.8321,88.6822,58,8); //
	AddStaticVehicle(559,-1946.2416,273.2482,35.1302,126.4200,60,1); //
	AddStaticVehicle(558,-1956.8257,271.4941,35.0984,71.7499,24,1); //
	AddStaticVehicle(562,-1952.8894,258.8604,40.7082,51.7172,17,1); //
	AddStaticVehicle(411,-1949.8689,266.5759,40.7776,216.4882,112,1); //
	AddStaticVehicle(429,-1988.0347,305.4242,34.8553,87.0725,2,1); //
	AddStaticVehicle(559,-1657.6660,1213.6195,6.9062,282.6953,13,8); //
	AddStaticVehicle(560,-1658.3722,1213.2236,13.3806,37.9052,52,39); //
	AddStaticVehicle(558,-1660.8994,1210.7589,20.7875,317.6098,36,1); //
	AddStaticVehicle(550,-1645.2401,1303.9883,6.8482,133.6013,7,7); //
	AddStaticVehicle(460,-1333.1960,903.7660,1.5568,0.5095,46,32); //

	// 25/4 UPDATE
	AddStaticVehicle(411,113.8611,1068.6182,13.3395,177.1330,116,1); //
	AddStaticVehicle(429,159.5199,1185.1160,14.7324,85.5769,1,2); //
	AddStaticVehicle(411,612.4678,1694.4126,6.7192,302.5539,75,1); //
	AddStaticVehicle(522,661.7609,1720.9894,6.5641,19.1231,6,25); //
	AddStaticVehicle(522,660.0554,1719.1187,6.5642,12.7699,8,82); //
	AddStaticVehicle(567,711.4207,1947.5208,5.4056,179.3810,90,96); //
	AddStaticVehicle(567,1031.8435,1920.3726,11.3369,89.4978,97,96); //
	AddStaticVehicle(567,1112.3754,1747.8737,10.6923,270.9278,102,114); //
	AddStaticVehicle(567,1641.6802,1299.2113,10.6869,271.4891,97,96); //
	AddStaticVehicle(567,2135.8757,1408.4512,10.6867,180.4562,90,96); //
	AddStaticVehicle(567,2262.2639,1469.2202,14.9177,91.1919,99,81); //
	AddStaticVehicle(567,2461.7380,1345.5385,10.6975,0.9317,114,1); //
	AddStaticVehicle(567,2804.4365,1332.5348,10.6283,271.7682,88,64); //
	AddStaticVehicle(560,2805.1685,1361.4004,10.4548,270.2340,17,1); //
	AddStaticVehicle(506,2853.5378,1361.4677,10.5149,269.6648,7,7); //
	AddStaticVehicle(567,2633.9832,2205.7061,10.6868,180.0076,93,64); //
	AddStaticVehicle(567,2119.9751,2049.3127,10.5423,180.1963,93,64); //
	AddStaticVehicle(567,2785.0261,-1835.0374,9.6874,226.9852,93,64); //
	AddStaticVehicle(567,2787.8975,-1876.2583,9.6966,0.5804,99,81); //
	AddStaticVehicle(411,2771.2993,-1841.5620,9.4870,20.7678,116,1); //
	AddStaticVehicle(420,1713.9319,1467.8354,10.5219,342.8006,6,1); // taxi

//======================================[ JAIL PRISON ]=================================
CreateObject(5191,838.01464844,-2040.07519531,6.34001207,0.00000000,0.00000000,359.99963379); //object(nwdkbridd_las2) (8)
CreateObject(4866,892.01757812,-2665.75488281,0.11075592,0.00000000,0.00000000,0.00000000); //object(lasrnway1_las) (4)
CreateObject(4866,892.01757812,-2714.37792969,1.44023633,0.00000000,0.00000000,0.00000000); //object(lasrnway1_las) (5)
CreateObject(7033,891.45996094,-2682.87695312,5.62452698,0.00000000,0.00000000,0.00000000); //object(vgnhsegate02) (1)
CreateObject(3550,826.57165527,-2729.73730469,2.80890369,0.00000000,0.00000000,0.00000000); //object(vgsn_fncelec_msh) (1)
CreateObject(3550,826.49450684,-2723.73120117,2.80890369,0.00000000,0.00000000,350.07507324); //object(vgsn_fncelec_msh) (2)
CreateObject(3550,827.04071045,-2723.84692383,2.80890369,0.00000000,0.00000000,350.07507324); //object(vgsn_fncelec_msh) (3)
CreateObject(3550,849.82983398,-2729.21386719,2.80890369,0.00000000,0.00000000,0.00000000); //object(vgsn_fncelec_msh) (5)
CreateObject(3550,848.76422119,-2724.21459961,2.80890369,0.00000000,0.00000000,23.81982422); //object(vgsn_fncelec_msh) (6)
CreateObject(996,891.50781250,-2668.25390625,1.85951114,0.00000000,0.00000000,282.57934570); //object(lhouse_barrier1) (1)
CreateObject(996,890.95214844,-2668.28710938,1.85951114,0.00000000,0.00000000,260.74401855); //object(lhouse_barrier1) (2)
CreateObject(5333,871.95214844,-2611.06054688,9.15587711,0.00000000,0.00000000,267.64343262); //object(sanpedbigslt_las2) (1)
CreateObject(16610,873.42675781,-2445.57421875,15.66332245,0.00000000,0.00000000,272.11486816); //object(des_nbridgebit_02) (1)
CreateObject(16610,859.95214844,-2283.50097656,15.68332195,0.00000000,0.00000000,276.32067871); //object(des_nbridgebit_02) (2)
CreateObject(16610,858.82250977,-2249.32299805,22200012800.00000000,0.00000000,0.00000000,276.08874512); //object(des_nbridgebit_02) (3)
CreateObject(16610,845.56347656,-2165.86914062,15.69332218,0.00000000,0.00000000,277.19250488); //object(des_nbridgebit_02) (4)
CreateObject(16610,871.24414062,-2396.51953125,15.67332172,0.00000000,0.00000000,274.10339355); //object(des_nbridgebit_02) (5)
CreateObject(4866,892.01757812,-2835.98925781,1.31075597,0.00000000,0.00000000,0.00000000); //object(lasrnway1_las) (5)
CreateObject(8249,837.59082031,-2726.73632812,5.13854313,0.00000000,0.00000000,0.00000000); //object(pltschlhnger70_lvs) (1)
CreateObject(8253,837.59082031,-2701.32324219,5.13854313,0.00000000,0.00000000,0.00000000); //object(pltschlhnger01_lvs) (1)
CreateObject(8253,837.59082031,-2752.01757812,5.13854313,0.00000000,0.00000000,0.00000000); //object(pltschlhnger01_lvs) (2)
CreateObject(4866,892.01757812,-2665.75488281,0.11075592,0.00000000,0.00000000,0.00000000); //object(lasrnway1_las) (4)
CreateObject(4866,892.01757812,-2665.75488281,0.11075592,0.00000000,0.00000000,0.00000000); //object(lasrnway1_las) (4)
CreateObject(4866,892.01757812,-2665.75488281,0.11075592,0.00000000,0.00000000,0.00000000); //object(lasrnway1_las) (4)
CreateObject(4866,892.01757812,-2665.75488281,1.31075597,0.00000000,0.00000000,0.00000000); //object(lasrnway1_las) (4)
CreateObject(9241,838.33398438,-2634.48828125,3.16965485,0.00000000,0.00000000,0.00000000); //object(copbits_sfn) (1)
CreateObject(996,891.00488281,-2659.71484375,1.85951114,0.00000000,0.00000000,270.67016602); //object(lhouse_barrier1) (1)
CreateObject(996,890.88867188,-2651.19433594,1.85951114,0.00000000,0.00000000,270.67016602); //object(lhouse_barrier1) (1)
CreateObject(987,886.32812500,-2605.52856445,0.11075497,0.00000000,0.00000000,0.00000000); //object(elecfence_bar) (1)
CreateObject(987,898.33203125,-2605.42529297,0.11075592,0.00000000,0.00000000,0.00000000); //object(elecfence_bar) (2)
CreateObject(987,910.29620361,-2605.50122070,0.11075497,0.00000000,0.00000000,0.00000000); //object(elecfence_bar) (3)
CreateObject(987,922.34259033,-2605.42333984,0.11075592,0.00000000,0.00000000,0.00000000); //object(elecfence_bar) (4)
CreateObject(987,934.28076172,-2605.48535156,0.11075592,0.00000000,0.00000000,0.00000000); //object(elecfence_bar) (5)
CreateObject(987,874.66235352,-2605.70874023,0.11075592,0.00000000,0.00000000,0.00000000); //object(elecfence_bar) (6)
CreateObject(987,862.72833252,-2605.76318359,0.11075592,0.00000000,0.00000000,0.00000000); //object(elecfence_bar) (7)
CreateObject(987,851.25244141,-2605.79638672,0.11075592,0.00000000,0.00000000,0.00000000); //object(elecfence_bar) (8)
CreateObject(987,839.42480469,-2605.83398438,0.11075592,0.00000000,0.00000000,0.00000000); //object(elecfence_bar) (9)
CreateObject(987,827.78137207,-2605.83544922,0.11075592,0.00000000,0.00000000,0.00000000); //object(elecfence_bar) (10)
CreateObject(987,815.87133789,-2605.73999023,0.11075687,0.00000000,0.00000000,0.00000000); //object(elecfence_bar) (11)
CreateObject(987,804.04870605,-2605.68408203,0.11075592,0.00000000,0.00000000,0.00000000); //object(elecfence_bar) (12)
CreateObject(987,792.28955078,-2605.78881836,0.11075783,0.00000000,0.00000000,0.00000000); //object(elecfence_bar) (13)
CreateObject(987,780.21258545,-2605.77294922,0.11075592,0.00000000,0.00000000,0.00000000); //object(elecfence_bar) (14)
CreateObject(987,768.26855469,-2605.61035156,0.11075592,0.00000000,0.00000000,0.00000000); //object(elecfence_bar) (15)
CreateObject(987,756.48052979,-2605.84106445,0.11075592,0.00000000,0.00000000,0.00000000); //object(elecfence_bar) (16)
CreateObject(987,745.94287109,-2609.60473633,0.11075592,0.00000000,0.00000000,19.84985352); //object(elecfence_bar) (17)
CreateObject(987,742.44433594,-2620.22631836,0.11075592,0.00000000,0.00000000,65.50463867); //object(elecfence_bar) (18)
CreateObject(987,946.27996826,-2605.45312500,0.11075592,0.00000000,0.00000000,0.00000000); //object(elecfence_bar) (19)
CreateObject(987,957.67126465,-2605.61791992,0.11075592,0.00000000,0.00000000,0.00000000); //object(elecfence_bar) (20)
CreateObject(987,969.11602783,-2605.30175781,0.11075592,0.00000000,0.00000000,0.00000000); //object(elecfence_bar) (21)
CreateObject(987,980.97631836,-2605.42919922,0.11075544,0.00000000,0.00000000,0.00000000); //object(elecfence_bar) (22)
CreateObject(987,992.88671875,-2605.28906250,0.11075497,0.00000000,0.00000000,0.00000000); //object(elecfence_bar) (23)
CreateObject(987,1004.78845215,-2605.33300781,0.11075497,0.00000000,0.00000000,0.00000000); //object(elecfence_bar) (24)
CreateObject(987,1016.41516113,-2605.19018555,0.11075592,0.00000000,0.00000000,0.00000000); //object(elecfence_bar) (25)
CreateObject(987,1028.21789551,-2605.10400391,0.11075640,0.00000000,0.00000000,0.00000000); //object(elecfence_bar) (26)
CreateObject(987,1036.83935547,-2605.07373047,0.11075592,0.00000000,0.00000000,0.00000000); //object(elecfence_bar) (27)
CreateObject(3749,868.67382812,-2688.22265625,7.29865074,0.00000000,0.00000000,0.00000000); //object(clubgate01_lax) (1)
CreateObject(987,860.01910400,-2685.66796875,1.68850136,0.00000000,0.00000000,87.33950806); //object(elecfence_bar) (29)
CreateObject(987,860.67761230,-2673.87939453,2.00872803,0.00000000,0.00000000,87.33581543); //object(elecfence_bar) (30)
CreateObject(987,861.13641357,-2662.13989258,2.85212755,0.00000000,0.00000000,87.33581543); //object(elecfence_bar) (31)
CreateObject(987,861.63269043,-2650.21118164,4.90172195,0.00000000,0.00000000,87.33581543); //object(elecfence_bar) (32)
CreateObject(987,862.16101074,-2638.47558594,7.40159559,0.00000000,0.00000000,87.33581543); //object(elecfence_bar) (33)
CreateObject(987,862.46026611,-2626.59838867,9.28363514,0.00000000,0.00000000,87.33581543); //object(elecfence_bar) (34)
CreateObject(987,877.48754883,-2685.37939453,1.70020485,0.00000000,0.00000000,87.33581543); //object(elecfence_bar) (38)
CreateObject(987,878.17480469,-2673.16381836,2.06937504,0.00000000,0.00000000,87.33581543); //object(elecfence_bar) (39)
CreateObject(987,878.54541016,-2661.36474609,3.04399681,0.00000000,0.00000000,87.33581543); //object(elecfence_bar) (40)
CreateObject(987,879.11138916,-2650.25244141,5.04957628,0.00000000,0.00000000,87.33581543); //object(elecfence_bar) (41)
CreateObject(987,879.77075195,-2638.64794922,7.51264238,0.00000000,0.00000000,87.33581543); //object(elecfence_bar) (42)
CreateObject(987,880.19976807,-2626.88208008,9.33116341,0.00000000,0.00000000,87.33581543); //object(elecfence_bar) (43)
CreateObject(5005,965.56250000,-2897.90356445,3.86227250,0.00000000,0.00000000,0.00000000); //object(lasrunwall1_las) (1)
CreateObject(5005,845.41186523,-2897.82080078,3.86227250,0.00000000,0.00000000,0.00000000); //object(lasrunwall1_las) (2)
CreateObject(5005,817.14343262,-2897.95800781,3.86227250,0.00000000,0.00000000,358.54205322); //object(lasrunwall1_las) (3)
CreateObject(5005,740.54003906,-2815.62597656,3.86227250,0.00000000,0.00000000,269.64782715); //object(lasrunwall1_las) (4)
CreateObject(5005,741.54003906,-2699.94091797,3.99175286,0.00000000,0.00000000,269.64782715); //object(lasrunwall1_las) (5)
CreateObject(5005,1046.11486816,-2684.74487305,3.99175286,0.00000000,0.00000000,269.64294434); //object(lasrunwall1_las) (6)
CreateObject(5005,1045.46777344,-2815.96484375,3.86227250,0.00000000,0.00000000,269.64294434); //object(lasrunwall1_las) (7)
CreateObject(8042,877.79296875,-2701.49218750,7.30762959,0.00000000,0.00000000,196.50695801); //object(apbarriergate07_lvs) (1)
CreateObject(8151,990.47540283,-2833.66748047,4.67740822,0.00000000,0.00000000,0.00000000); //object(vgsselecfence05) (1)
CreateObject(8151,990.51635742,-2833.63012695,4.67740822,0.00000000,0.00000000,0.00000000); //object(vgsselecfence05) (2)
CreateObject(8151,982.67529297,-2841.26635742,4.67740822,0.00000000,0.00000000,178.64941406); //object(vgsselecfence05) (3)
CreateObject(987,951.62890625,-2794.04492188,1.31075644,0.00000000,0.00000000,0.00000000); //object(elecfence_bar) (44)
CreateObject(987,1009.90527344,-2881.40820312,1.31075597,0.00000000,0.00000000,33.73901367); //object(elecfence_bar) (46)
CreateObject(987,1013.11523438,-2878.84667969,1.31075680,0.00000000,0.00000000,43.65966797); //object(elecfence_bar) (47)
CreateObject(978,886.34765625,-2695.96972656,2.28045654,0.00000000,0.00000000,51.60827637); //object(sub_roadright) (1)
CreateObject(979,885.34179688,-2708.79199219,2.28045654,0.00000000,0.00000000,27.78442383); //object(sub_roadleft) (1)
CreateObject(979,893.69238281,-2702.62792969,2.28045654,0.00000000,0.00000000,47.63122559); //object(sub_roadleft) (2)
CreateObject(979,900.55273438,-2694.00488281,2.28045654,0.00000000,0.00000000,57.55187988); //object(sub_roadleft) (3)
CreateObject(9241,796.09179688,-2634.48828125,3.16965485,0.00000000,0.00000000,0.00000000); //object(copbits_sfn) (2)
CreateObject(979,904.09863281,-2682.71191406,2.28045654,0.00000000,0.00000000,89.30786133); //object(sub_roadleft) (4)
CreateObject(979,880.91113281,-2644.58789062,2.15097594,0.00000000,0.00000000,267.95654297); //object(sub_roadleft) (5)
CreateObject(979,880.91113281,-2655.98632812,2.15097594,0.00000000,0.00000000,267.95104980); //object(sub_roadleft) (6)
CreateObject(979,884.88085938,-2634.29980469,2.15097594,0.00000000,0.00000000,226.26892090); //object(sub_roadleft) (7)
CreateObject(968,877.90246582,-2710.30981445,2.64127755,0.00000000,0.00000000,268.68872070); //object(barrierturn) (1)
CreateObject(972,915.53631592,-2690.00097656,0.44023633,0.00000000,0.00000000,258.76574707); //object(tunnelentrance) (1)
CreateObject(972,939.33325195,-2692.79003906,0.44023633,0.00000000,0.00000000,268.68713379); //object(tunnelentrance) (2)
CreateObject(972,949.55407715,-2686.31176758,0.44023728,0.00000000,0.00000000,0.00000000); //object(tunnelentrance) (4)
CreateObject(972,949.29089355,-2661.55981445,0.44023633,0.00000000,0.00000000,0.00000000); //object(tunnelentrance) (5)
CreateObject(972,948.95812988,-2636.91894531,0.31075591,0.00000000,0.00000000,0.00000000); //object(tunnelentrance) (6)
CreateObject(972,948.83776855,-2620.23193359,0.31075591,0.00000000,0.00000000,0.00000000); //object(tunnelentrance) (7)
CreateObject(10675,966.55273438,-2622.69921875,4.64073277,0.00000000,0.00000000,0.00000000); //object(elecstionv_sfs) (1)
CreateObject(10774,1025.45996094,-2643.98535156,4.21488333,0.00000000,0.00000000,0.00000000); //object(dk_cargoshp1_sfs01e) (1)
CreateObject(10774,1014.19238281,-2643.83398438,4.21488333,0.00000000,0.00000000,0.00000000); //object(dk_cargoshp1_sfs01e) (2)
CreateObject(2669,1001.77539062,-2864.53515625,2.65102887,0.00000000,0.00000000,0.00000000); //object(cj_chris_crate) (1)
CreateObject(2669,998.38085938,-2864.53515625,2.65102887,0.00000000,0.00000000,0.00000000); //object(cj_chris_crate) (2)
CreateObject(2669,995.08593750,-2864.63574219,2.65102887,0.00000000,0.00000000,0.00000000); //object(cj_chris_crate) (3)
CreateObject(2669,991.83300781,-2864.70117188,2.65102887,0.00000000,0.00000000,0.00000000); //object(cj_chris_crate) (4)
CreateObject(2669,991.81250000,-2863.36328125,5.34082651,0.00000000,0.00000000,0.00000000); //object(cj_chris_crate) (5)
CreateObject(2669,995.11914062,-2863.37402344,5.34082651,0.00000000,0.00000000,0.00000000); //object(cj_chris_crate) (6)
CreateObject(2669,998.37011719,-2863.38378906,5.34082651,0.00000000,0.00000000,0.00000000); //object(cj_chris_crate) (7)
CreateObject(2669,1001.71484375,-2863.38183594,5.34082651,0.00000000,0.00000000,0.00000000); //object(cj_chris_crate) (8)
CreateObject(1689,966.63769531,-2635.62304688,2.52163482,0.00000000,0.00000000,0.00000000); //object(gen_roofbit3) (1)
CreateObject(1635,1003.63671875,-2863.61523438,4.82744551,0.00000000,0.00000000,179.36279297); //object(nt_aircon1dbl) (1)
CreateObject(4853,946.84765625,-2650.26074219,4.33666945,0.00000000,0.00000000,91.30737305); //object(traincano_las) (1)
CreateObject(7191,801.58886719,-2688.72851562,3.41491461,0.00000000,0.00000000,89.32434082); //object(vegasnnewfence2b) (1)
CreateObject(7191,764.14160156,-2688.31542969,3.41491461,0.00000000,0.00000000,89.32434082); //object(vegasnnewfence2b) (2)
CreateObject(3475,857.70312500,-2688.16699219,3.81641173,0.00000000,0.00000000,91.30737305); //object(vgsn_fncelec_pst) (2)
CreateObject(3475,853.99511719,-2688.24121094,3.81641173,0.00000000,0.00000000,91.29638672); //object(vgsn_fncelec_pst) (3)
CreateObject(3939,977.31726074,-2869.84521484,2.07543230,0.00000000,0.00000000,0.00000000); //object(hanger01) (1)
CreateObject(3939,977.20184326,-2863.94360352,2.07543230,0.00000000,0.00000000,0.00000000); //object(hanger01) (2)
CreateObject(3763,839.86230469,-2681.17578125,34.62902451,0.00000000,0.00000000,0.00000000); //object(ce_radarmast3) (1)
CreateObject(967,862.16992188,-2684.61816406,1.44023633,0.00000000,0.00000000,356.02844238); //object(bar_gatebox01) (1)
CreateObject(967,875.30957031,-2684.80078125,1.44023633,0.00000000,0.00000000,359.99450684); //object(bar_gatebox01) (2)
CreateObject(5708,741.04003906,-2835.88964844,11.94710255,0.00000000,0.00000000,0.00000000); //object(hospital_law) (1)
CreateObject(5837,945.08300781,-2790.88964844,3.02825093,0.00000000,0.00000000,0.00000000); //object(ci_guardhouse1) (1)
CreateObject(10401,908.34472656,-2616.54980469,3.60212874,0.00000000,0.00000000,312.35778809); //object(hc_shed02_sfs) (1)
CreateObject(16774,1015.85058594,-2724.28613281,3.03402448,0.00000000,0.00000000,0.00000000); //object(des_gunbldg) (1)
CreateObject(7347,901.20898438,-2910.88378906,-41.92681885,0.00000000,0.00000000,177.37976074); //object(vgsn_pipeworks01) (1)
CreateObject(11292,1016.25878906,-2864.69921875,2.77478790,0.00000000,0.00000000,0.00000000); //object(gasstatiohut) (1)
CreateObject(11292,1007.66601562,-2864.80468750,2.77478790,0.00000000,0.00000000,0.00000000); //object(gasstatiohut) (2)
CreateObject(10828,997.59979248,-2882.66113281,9.10612011,0.00000000,0.00000000,0.00000000); //object(drydock1_sfse) (2)
CreateObject(10828,965.15466309,-2882.66113281,9.10612011,0.00000000,0.00000000,0.00000000); //object(drydock1_sfse) (3)
CreateObject(10828,948.63629150,-2866.33154297,9.10612011,0.00000000,0.00000000,89.32449341); //object(drydock1_sfse) (4)
CreateObject(10828,949.06347656,-2831.80371094,9.10612011,0.00000000,0.00000000,89.31884766); //object(drydock1_sfse) (5)
CreateObject(6976,931.77459717,-2811.95605469,3.01075411,0.00000000,0.00000000,0.00000000); //object(shamheliprt04) (1)
CreateObject(10828,1023.70965576,-2847.52148438,9.10612011,0.00000000,0.00000000,89.31884766); //object(drydock1_sfse) (8)
CreateObject(6976,1006.74139404,-2792.99902344,3.11075592,0.00000000,0.00000000,0.00000000); //object(shamheliprt04) (3)
CreateObject(10828,1024.09667969,-2812.37915039,9.10612011,0.00000000,0.00000000,89.32434082); //object(drydock1_sfse) (9)
CreateObject(1332,863.06445312,-2672.02832031,2.67575598,0.00000000,0.00000000,85.35278320); //object(binnt02_la) (1)
CreateObject(1332,862.82714844,-2674.51464844,2.57028913,0.00000000,0.00000000,9.92065430); //object(binnt02_la) (2)
CreateObject(1329,1008.29980469,-2867.04980469,1.76339269,0.00000000,0.00000000,0.00000000); //object(binnt13_la) (1)
CreateObject(2677,1001.55126953,-2876.08276367,0.58277327,0.00000000,0.00000000,0.00000000); //object(proc_rubbish_7) (1)
CreateObject(2677,1014.24578857,-2870.74438477,0.58277327,0.00000000,0.00000000,0.00000000); //object(proc_rubbish_7) (2)
CreateObject(2677,1007.68280029,-2867.98095703,0.58277327,0.00000000,0.00000000,0.00000000); //object(proc_rubbish_7) (3)
CreateObject(3065,992.35449219,-2825.08203125,1.50556934,0.00000000,0.00000000,0.00000000); //object(bball_col) (1)
CreateObject(1985,1001.48046875,-2831.63476562,4.79928827,0.00000000,0.00000000,0.00000000); //object(punchbagnu) (1)
CreateObject(2921,999.56530762,-2867.28076172,2.07168221,0.00000000,0.00000000,97.26449585); //object(kmb_cam) (1)
CreateObject(2921,1017.84295654,-2866.31640625,1.40401292,0.00000000,0.00000000,69.47454834); //object(kmb_cam) (2)
CreateObject(2921,957.65167236,-2794.18896484,3.06258631,0.00000000,0.00000000,71.45959473); //object(kmb_cam) (3)
CreateObject(2921,861.90325928,-2690.32250977,4.32744884,0.00000000,0.00000000,145.62152100); //object(kmb_cam) (4)
CreateObject(2921,874.50659180,-2689.96777344,4.12854910,0.00000000,0.00000000,0.00000000); //object(kmb_cam) (5)
CreateObject(10394,985.02734375,-2833.92187500,4.05023861,0.00000000,0.00000000,0.00000000); //object(plot1_sfs) (1)
CreateObject(1985,1003.23046875,-2829.62890625,4.79928827,0.00000000,0.00000000,0.00000000); //object(punchbagnu) (3)
CreateObject(18275,1002.34667969,-2830.67871094,3.61871982,0.00000000,0.00000000,47.63671875); //object(cw2_mtbfinish) (1)
CreateObject(980,850.63378906,-2694.98535156,4.21362734,0.00000000,0.00000000,89.31884766); //object(airportgate) (1)
CreateObject(3078,763.71777344,-2754.10351562,2.48894978,0.00000000,0.00000000,0.00000000); //object(ad_finish) (1)
CreateObject(3628,814.49987793,-2700.72143555,3.99424076,0.00000000,0.00000000,180.00000000); //object(smallprosjmt_las) (1)
CreateObject(8253,793.43359375,-2703.57714844,5.36802387,0.00000000,0.00000000,270.00000000); //object(pltschlhnger01_lvs) (2)
CreateObject(987,793.47760010,-2716.58984375,1.44023609,0.00000000,0.00000000,0.00000000); //object(elecfence_bar) (28)
CreateObject(966,789.46862793,-2716.58984375,1.44023633,0.00000000,0.00000000,0.00000000); //object(bar_gatebar01) (1)
CreateObject(987,789.82934570,-2716.58984375,1.44023633,0.00000000,0.00000000,0.00000000); //object(elecfence_bar) (35)
CreateObject(968,789.32275391,-2716.58593750,2.19402361,0.00000000,270.00000000,0.00000000); //object(barrierturn) (3)
CreateObject(1358,2443.57348633,-1765.68249512,13.78190994,0.00000000,0.00000000,0.00000000); //object(cj_skip_rubbish) (1)
CreateObject(1299,2442.27880859,-1768.51110840,13.01008606,0.00000000,0.00000000,0.00000000); //object(smashboxpile) (1)
CreateObject(12957,2450.94335938,-1764.05065918,13.45878696,0.00000000,0.00000000,0.00000000); //object(sw_pickupwreck01) (1)
CreateObject(2672,2443.41430664,-1760.48742676,12.86786366,0.00000000,0.00000000,0.00000000); //object(proc_rubbish_4) (1)
CreateObject(2674,2445.05590820,-1761.24853516,12.60846901,0.00000000,0.00000000,0.00000000); //object(proc_rubbish_2) (1)
CreateObject(2675,2457.20874023,-1760.15185547,12.65340042,0.00000000,0.00000000,0.00000000); //object(proc_rubbish_6) (1)
CreateObject(2676,2454.81127930,-1760.24145508,12.69226646,0.00000000,0.00000000,0.00000000); //object(proc_rubbish_8) (1)
CreateObject(2677,2446.90063477,-1762.87866211,12.85757351,0.00000000,0.00000000,0.00000000); //object(proc_rubbish_7) (1)
CreateObject(3594,2455.52124023,-1765.69201660,13.20813942,0.00000000,0.00000000,0.00000000); //object(la_fuckcar1) (1)
CreateObject(1225,2444.40039062,-1767.84875488,12.97525978,0.00000000,0.00000000,0.00000000); //object(barrel4) (1)
//==========================[ MAP STUNT DESERT ]===========================
CreateObject(987, 12.775471, 2475.398682, 15.484375, 0.0000, 0.0000, 0.0000);
CreateObject(987, 24.858721, 2475.417725, 15.484375, 0.0000, 0.0000, 0.0000);
CreateObject(987, 36.865723, 2475.372070, 15.484375, 0.0000, 0.0000, 0.0000);
CreateObject(987, 48.836678, 2475.311768, 15.484375, 0.0000, 0.0000, 0.0000);
CreateObject(987, 60.616432, 2475.368896, 15.484375, 0.0000, 0.0000, 0.0000);
CreateObject(987, 72.648102, 2475.273438, 15.484375, 0.0000, 0.0000, 0.0000);
CreateObject(987, 84.673584, 2475.312012, 15.476620, 0.0000, 0.0000, 0.0000);
CreateObject(987, 96.557053, 2475.392090, 15.476620, 0.0000, 0.0000, 0.0000);
CreateObject(987, 108.381264, 2475.528076, 15.476620, 0.0000, 0.0000, 0.0000);
CreateObject(987, 119.994705, 2475.709961, 15.480478, 0.0000, 0.0000, 0.0000);
CreateObject(987, 131.889374, 2475.673340, 15.480463, 0.0000, 0.0000, 0.0000);
CreateObject(987, 143.822876, 2475.795410, 15.480524, 0.0000, 0.0000, 0.0000);
CreateObject(987, 155.829559, 2475.715576, 15.484375, 0.0000, 0.0000, 0.0000);
CreateObject(987, 168.095200, 2475.986084, 15.484375, 0.0000, 0.0000, 0.0000);
CreateObject(987, 180.098633, 2476.129883, 15.484375, 0.0000, 0.0000, 0.0000);
CreateObject(987, 191.901871, 2476.344482, 15.484375, 0.0000, 0.0000, 0.0000);
CreateObject(987, 203.862183, 2476.402100, 15.484375, 0.0000, 0.0000, 0.0000);
CreateObject(987, 215.807098, 2476.251465, 15.484375, 0.0000, 0.0000, 0.0000);
CreateObject(987, 227.867920, 2476.370605, 15.484375, 0.0000, 0.0000, 0.0000);
CreateObject(987, 239.860138, 2476.341064, 15.484375, 0.0000, 0.0000, 0.0000);
CreateObject(987, 251.763123, 2476.332275, 15.484375, 0.0000, 0.0000, 0.0000);
CreateObject(987, 263.641327, 2476.436768, 15.484375, 0.0000, 0.0000, 0.0000);
CreateObject(987, 275.361298, 2476.558350, 15.484375, 0.0000, 0.0000, 0.0000);
CreateObject(987, 287.306671, 2476.586426, 15.484375, 0.0000, 0.0000, 0.0000);
CreateObject(987, 299.230896, 2476.654785, 15.484375, 0.0000, 0.0000, 0.0000);
CreateObject(987, 311.188171, 2476.799072, 15.492169, 0.0000, 0.0000, 0.0000);
CreateObject(987, 323.302277, 2476.631348, 15.492168, 0.0000, 0.0000, 0.0000);
CreateObject(987, 335.245667, 2476.633301, 15.492168, 0.0000, 0.0000, 0.0000);
CreateObject(987, 347.290527, 2476.311279, 15.484375, 0.0000, 0.0000, 0.0000);
CreateObject(987, 359.195251, 2476.264160, 15.484375, 0.0000, 0.0000, 0.0000);
CreateObject(987, 368.979919, 2476.337402, 15.484375, 0.0000, 0.0000, 0.0000);
CreateObject(987, 431.177124, 2476.637695, 15.484375, 0.0000, 0.0000, 67.5000);
CreateObject(987, 435.629211, 2487.756836, 15.492168, 0.0000, 0.0000, 90.0000);
CreateObject(987, 435.394562, 2499.650635, 15.492168, 0.0000, 0.0000, 90.0000);
CreateObject(987, 435.617706, 2511.596924, 15.539049, 0.0000, 0.0000, 90.0000);
CreateObject(987, 435.960846, 2523.523438, 15.757484, 0.0000, 0.0000, 56.2500);
CreateObject(987, 442.758270, 2533.282715, 15.921204, 0.0000, 0.0000, 56.2500);
CreateObject(987, 449.293610, 2543.525635, 15.920647, 0.0000, 0.0000, 112.5000);
CreateObject(987, 444.882568, 2553.919434, 15.340252, 0.0000, 0.0000, 157.5000);
CreateObject(987, 434.003754, 2558.774902, 15.508301, 0.0000, 0.0000, 180.0000);
CreateObject(13648, 408.354156, 2520.397217, 15.480347, 0.0000, 0.0000, 270.0000);
CreateObject(13648, 365.472290, 2520.286865, 15.596104, 0.0000, 0.0000, 90.0000);
CreateObject(13641, 386.582794, 2500.677734, 17.203619, 0.0000, 0.0000, 180.0000);
CreateObject(13641, 353.815369, 2500.920410, 17.203619, 0.0000, 0.0000, 0.0000);
CreateObject(13636, 414.434082, 2496.971191, 17.764767, 0.0000, 0.0000, 0.0000);
CreateObject(13640, 384.890076, 2485.989746, 16.504644, 0.0000, 0.0000, 0.0000);
CreateObject(13643, 353.263947, 2487.713135, 16.780392, 0.0000, 0.0000, 0.0000);
CreateObject(1634, 425.888123, 2504.319092, 16.781693, 0.0000, 0.0000, 0.0000);
CreateObject(2714, -83.542557, 2508.389648, 17.495777, 0.0000, 0.0000, 270.0000);
CreateObject(2714, -83.981155, 2505.923828, 15.747351, 0.0000, 0.0000, 315.0000);
CreateObject(8132, -88.765175, 2507.810059, 18.091831, 0.0000, 0.0000, 101.2500);
CreateObject(3819, 397.764282, 2532.751465, 16.542009, 0.0000, 0.0000, 90.0000);
CreateObject(14791, 347.439362, 2537.644531, 17.797346, 0.0000, 0.0000, 0.0000);
CreateObject(13666, 330.277924, 2489.423096, 21.264687, 0.0000, 0.0000, 123.7499);
CreateObject(13642, 173.810272, 2512.225098, 17.995104, 0.0000, 0.0000, 270.0000);
CreateObject(13592, 243.423996, 2513.780029, 27.154579, 0.0000, 331.6386, 0.0000);
CreateObject(1675, 325.675995, 2510.393555, 18.702814, 0.0000, 0.0000, 0.0000);
CreateObject(1697, 306.634888, 2510.196045, 17.140163, 0.0000, 0.0000, 90.0000);
CreateObject(3627, 262.635986, 2491.915283, 19.323862, 0.0000, 0.0000, 90.0000);
CreateObject(16401, 227.339722, 2491.530762, 15.478264, 0.0000, 0.0000, 0.0001);
CreateObject(7980, -46.929817, 2506.535645, 17.471340, 0.0000, 0.0000, 0.0000);
CreateObject(7980, 75.897789, 2507.872559, 17.471340, 0.0000, 0.0000, 0.0000);
CreateObject(987, 422.248718, 2558.553711, 15.373043, 0.0000, 0.0000, 180.0000);
CreateObject(987, 410.309052, 2558.712891, 15.488323, 0.0000, 0.0000, 180.0000);
CreateObject(987, 398.423187, 2558.828369, 15.574753, 0.0000, 0.0000, 180.0000);
CreateObject(987, 386.439911, 2558.854736, 15.614704, 0.0000, 0.0000, 180.0000);
CreateObject(987, 374.561371, 2558.932861, 15.641068, 0.0000, 0.0000, 180.0000);
CreateObject(987, 362.549927, 2558.861816, 15.367188, 0.0000, 0.0000, 180.0000);
CreateObject(987, 350.636993, 2558.893799, 15.367188, 0.0000, 0.0000, 180.0000);
CreateObject(987, 338.711548, 2558.883301, 15.367188, 0.0000, 0.0000, 180.0000);
CreateObject(987, 326.683685, 2558.924072, 15.367188, 0.0000, 0.0000, 180.0000);
CreateObject(987, 314.729919, 2558.971191, 15.367188, 0.0000, 0.0000, 180.0000);
CreateObject(987, 302.858337, 2559.026367, 15.367188, 0.0000, 0.0000, 180.0000);
CreateObject(987, 290.942139, 2559.099365, 15.367188, 0.0000, 0.0000, 180.0000);
CreateObject(987, 278.999573, 2559.105225, 15.367188, 0.0000, 0.0000, 180.0000);
CreateObject(987, 266.973633, 2559.264648, 15.367188, 0.0000, 0.0000, 180.0000);
CreateObject(987, 255.039169, 2559.224365, 15.367188, 0.0000, 0.0000, 180.0000);
CreateObject(987, 243.092194, 2559.261719, 15.367188, 0.0000, 0.0000, 180.0000);
CreateObject(987, 231.252335, 2559.367676, 15.367188, 0.0000, 0.0000, 180.0000);
CreateObject(987, 219.300537, 2559.438721, 15.367188, 0.0000, 0.0000, 180.0000);
CreateObject(987, 207.312897, 2559.434082, 15.367188, 0.0000, 0.0000, 180.0000);
CreateObject(987, 195.483688, 2559.465576, 15.367188, 0.0000, 0.0000, 180.0000);
CreateObject(987, 183.576538, 2559.513672, 15.367188, 0.0000, 0.0000, 180.0000);
CreateObject(987, 171.656952, 2559.569336, 15.367188, 0.0000, 0.0000, 180.0000);
CreateObject(987, 159.703110, 2559.684570, 15.367188, 0.0000, 0.0000, 213.7500);
CreateObject(987, 149.825882, 2553.244385, 15.554487, 0.0000, 0.0000, 213.7500);
CreateObject(987, 139.983994, 2546.569580, 15.519419, 0.0000, 0.0000, 213.7500);
CreateObject(987, 129.954147, 2540.143066, 15.630342, 0.0000, 0.0000, 213.7499);
CreateObject(987, 119.986015, 2533.680664, 15.741314, 0.0000, 0.0000, 213.7499);
CreateObject(987, 110.333588, 2527.972900, 15.811367, 0.0000, 0.0000, 180.0000);
CreateObject(987, 98.405869, 2527.832520, 15.676216, 0.0000, 0.0000, 180.0000);
CreateObject(987, 86.533249, 2527.648682, 15.541368, 0.0000, 0.0000, 180.0000);
CreateObject(987, 74.510269, 2527.577637, 15.484375, 0.0000, 0.0000, 180.0000);
CreateObject(987, 62.566978, 2527.596680, 15.484375, 0.0000, 0.0000, 180.0000);
CreateObject(987, 50.657326, 2527.647949, 15.484375, 0.0000, 0.0000, 180.0000);
CreateObject(987, 38.751770, 2527.632324, 15.484374, 0.0000, 0.0000, 180.0000);
CreateObject(987, 26.837936, 2527.566895, 15.484375, 0.0000, 0.0000, 180.0000);
CreateObject(987, 14.954397, 2527.618652, 15.484374, 0.0000, 0.0000, 180.0000);
CreateObject(987, 2.996510, 2527.660400, 15.492184, 0.0000, 0.0000, 180.0000);
CreateObject(987, -8.967529, 2527.717773, 15.484375, 0.0000, 0.0000, 180.0000);
CreateObject(987, -21.018055, 2527.717041, 15.484375, 0.0000, 0.0000, 180.0000);
CreateObject(987, -32.822639, 2527.809570, 15.484375, 0.0000, 0.0000, 180.0000);
CreateObject(987, -44.659660, 2527.819824, 15.492184, 0.0000, 0.0000, 180.0000);
CreateObject(987, -62.947563, 2529.994629, 15.484375, 0.0000, 0.0000, 348.7500);
CreateObject(13592, 138.415878, 2496.755615, 27.054981, 0.0000, 13.7510, 11.2500);
CreateObject(13592, 130.716843, 2488.323975, 30.812149, 0.0000, 22.3454, 11.2500);
CreateObject(13592, 123.445953, 2480.285156, 34.489731, 0.0000, 21.4859, 11.2500);
CreateObject(13592, 116.336121, 2472.161865, 38.147316, 0.0000, 20.6265, 11.2500);
  
	AddStaticPickup(371, 15, 1710.3359,1614.3585,10.1191); 
	AddStaticPickup(371, 15, 1964.4523,1917.0341,130.9375); 
	AddStaticPickup(371, 15, 2055.7258,2395.8589,150.4766); 
	AddStaticPickup(371, 15, 2265.0120,1672.3837,94.9219); 
	AddStaticPickup(371, 15, 2265.9739,1623.4060,94.9219); 
	AddStaticPickup(1274, 2,2244.4800,-1664.0601,15.4766);
	AddStaticPickup(1274, 2,2308.1172,-1643.6335,14.8270);
	AddStaticPickup(1274, 2,2074.0000,-1793.9399,13.5469);
	AddStaticPickup(1274, 2,2071.5088,-1779.9432,13.5578);
	AddStaticPickup(1274, 2,2103.4600,-1806.5900,13.5547);
	AddStaticPickup(1274, 2,1831.5400,-1843.3800,13.5781);
	AddStaticPickup(1274, 2,1834.4000,-1681.7500,13.4331);
	AddStaticPickup(1274, 2,1458.7700,-1140.0200,24.0692);
	AddStaticPickup(1274, 2,1365.3500,-1279.0601,13.5469);
	AddStaticPickup(1274, 2,1199.0829,-920.6430,43.0297);
	AddStaticPickup(1274, 2,458.6580,-1500.4800,31.0444);
	AddStaticPickup(1274, 2,452.0120,-1479.5699,30.8378);

	SetTimer("MoneyGrubScoreUpdate", 1000, 1);
	return 1;
	}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
     if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 588)
     {
     SendClientMessage(playerid, COLOR_RED, "Pour commencer le job hotdog tape /hotdog");
     }
     return 1;
}
public OnPlayerExitVehicle(playerid, vehicleid)
{
	if((hotdog) == 1)
	{
	    hotdog = 0;
	    SendClientMessage(playerid, COLOR_RED, "Tu as quitter ton hotdog van reprend le pour continuer ton job.");

	}else if((hotdog) == 0){
 }
}

stock noms(playerid)
{
	new namep[MAX_PLAYER_NAME];
	GetPlayerName(playerid,namep,sizeof(namep));

	return namep;
}

public SendPlayerFormattedText(playerid, const str[], define)
{
	new tmpbuf[256];
	format(tmpbuf, sizeof(tmpbuf), str, define);
	SendClientMessage(playerid, 0xFF004040, tmpbuf);
}

public SendAllFormattedText(playerid, const str[], define)
{
	new tmpbuf[256];
	format(tmpbuf, sizeof(tmpbuf), str, define);
	SendClientMessageToAll(0xFFFF00AA, tmpbuf);
}

public CountDown()
{
new tmpp[256];
if(countdown == 0)
{
KillTimer(Compte);
TogglePlayerControllable(Duelid,true);
TogglePlayerControllable(EDuelid,true);
format(tmpp, sizeof(tmpp), "~g~QUE LE~r~ MEILLEUR GAGNE !");
GameTextForPlayer(EDuelid, tmpp,1000,3);
format(tmpp, sizeof(tmpp), "~g~QUE LE~r~ MEILLEUR GAGNE !");
GameTextForPlayer(Duelid, tmpp,1000,3);
PlayAllSound(1057);
}else{
format(tmpp, sizeof(tmpp), "~r~%d",countdown);
GameTextForPlayer(EDuelid, tmpp,1000,3);
format(tmpp, sizeof(tmpp), "~r~%d",countdown);
GameTextForPlayer(Duelid, tmpp,1000,3);
PlayAllSound(1056);
countdown--;
}
return 1;
}

public Messages()
{
    new randMSG = random(sizeof(Message));
    SendClientMessageToAll(COLOR_LIGHTBLUE, Message[randMSG]);
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
if(Duel[playerid] == 0)
{
Duelid = clickedplayerid;
EDuelid = playerid;
if (Duelid == EDuelid) return SendClientMessage(playerid,rouge,"Tu ne peut pas faire un duel a toi mï¿½me !");
ShowPlayerDialog(playerid,556,DIALOG_STYLE_LIST,"Choisissez","Duel","Continuer","Annuler");
    if(dm[playerid] == 1)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 2)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 3)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 4)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utilser cette commande tu es en DeathMatch");
}
if(dm[playerid] == 5)
{
return SendClientMessage(playerid,COLOR_RED,"Tu ne peux pas utiliser cette commande tu es en DeathMatch");
}
}
else
{
SendClientMessage(playerid,rouge,"Vous ï¿½tes ou vous avez dï¿½jï¿½ lancer un duel");
}
return 1;
}

public VerificationCompteur()
{
    new vehicleid,Float:speed_x,Float:speed_y,Float:speed_z,Float:final_speed,speed_string[256],final_speed_int;
    for(new i=0;i<MAX_PLAYERS;i++)
    {
		vehicleid=GetPlayerVehicleID(i);
		if(vehicleid==0)
		{
            TextDrawSetString(COMPTEUR[i],"");
            TextDrawHideForPlayer(i,COMPTEUR[i]);
		}
		else
		{
		    TextDrawShowForPlayer(i,COMPTEUR[i]);
            GetVehicleVelocity(vehicleid,speed_x,speed_y,speed_z);
			final_speed=floatsqroot(((speed_x*speed_x)+(speed_y*speed_y))+(speed_z*speed_z))*115.0;
			final_speed_int=floatround(final_speed,floatround_round);
			if(final_speed_int<60)
			{
			    format(speed_string,256,"Vitesse : ~g~%d~w~ km/h",final_speed_int);
			}
			else if(final_speed_int<90)
			{
			    format(speed_string,256,"Vitesse : ~y~%d~w~ km/h",final_speed_int);
			}
			else
			{
				format(speed_string,256,"Vitesse : ~r~%d~w~ km/h",final_speed_int);
			}
			TextDrawSetString(COMPTEUR[i],speed_string);
		}
	}
	return 1;
}

public OnPlayerUpdate(playerid)
{
	new InfoString[300];
	if(IsPlayerConnected(playerid))
	{
		if(IsPlayerNPC(playerid)) return 0;
		GetPlayerHealth(playerid, health);
		new ping = GetPlayerPing(playerid);
		format(InfoString, sizeof(InfoString), "~w~%d :Ping", ping);
		TextDrawSetString(PPing[playerid], InfoString);
		format(InfoString, sizeof(InfoString), "~b~%.1f :Health", health);
		TextDrawSetString(PHealth[playerid], InfoString);
	}
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
    if(pickupid == hotinfo)
	{
    GameTextForPlayer(playerid, "~g~INFOS: Pour en savoir plus sur le job hotdog tape /doginfo", 3000, 3);
	}
}

public OnPlayerEnterCheckpoint(playerid)
{
if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 588)
   {
     if (IsPlayerInRangeOfPoint(playerid, 7.0,HotPoint1))
     {
          SetPlayerCheckpoint(playerid, HotPoint2, 7.0);
          GameTextForPlayer(playerid, "~g~1ere LIVRAISON!", 3000, 3);
  	 }
     if (IsPlayerInRangeOfPoint(playerid, 7.0,HotPoint2))
     {
          SetPlayerCheckpoint(playerid, HotPoint3, 7.0);
          GameTextForPlayer(playerid, "~g~2eme LIVRAISON!", 3000, 3);
  	 }
     if (IsPlayerInRangeOfPoint(playerid, 7.0,HotPoint3))
     {
          SetPlayerCheckpoint(playerid, HotPoint4, 7.0);
          GameTextForPlayer(playerid, "~g~3eme LIVRAISON!", 3000, 3);
  	 }
     if (IsPlayerInRangeOfPoint(playerid, 7.0,HotPoint4))
     {
          SetPlayerCheckpoint(playerid, HotPoint5, 7.0);
          GameTextForPlayer(playerid, "~g~4eme LIVRAISON!", 3000, 3);
  	 }
     if (IsPlayerInRangeOfPoint(playerid, 7.0,HotPoint5))
     {
          SetPlayerCheckpoint(playerid, Refillpoint, 7.0);
          GameTextForPlayer(playerid, "~g~VA REMPLIR TON VAN DE HOTDOG POUR CONTINUER A LIVRER!", 3000, 3);
          GameTextForPlayer(playerid, "~g~VA REMPLIR TON VAN DE HOTDOG POUR CONTINUER A LIVRER!", 3000, 3);
  	 }
     if (IsPlayerInRangeOfPoint(playerid, 7.0,Refillpoint))
     {
          SetPlayerCheckpoint(playerid, HotPoint6, 7.0);
          GameTextForPlayer(playerid, "~g~7eme LIVRAISON!", 3000, 3);
  	 }
     if (IsPlayerInRangeOfPoint(playerid, 7.0,HotPoint6))
     {
          SetPlayerCheckpoint(playerid, HotPoint7, 7.0);
          GameTextForPlayer(playerid, "~g~6eme LIVRAISON!", 3000, 3);
  	 }
     if (IsPlayerInRangeOfPoint(playerid, 7.0,HotPoint7))
     {
          SetPlayerCheckpoint(playerid, HotPoint8, 7.0);
          GameTextForPlayer(playerid, "~g~7eme LIVRAISON!", 3000, 3);
  	 }
     if (IsPlayerInRangeOfPoint(playerid, 7.0,HotPoint8))
     {
          SetPlayerCheckpoint(playerid, HotPoint9, 7.0);
          GameTextForPlayer(playerid, "~g~8eme LIVRAISON!", 3000, 3);
  	 }
     if (IsPlayerInRangeOfPoint(playerid, 7.0,HotPoint9))
     {
          SetPlayerCheckpoint(playerid, HotPoint10, 7.0);
          GameTextForPlayer(playerid, "~g~9eme LIVRAISON!", 3000, 3);
  	 }
     if (IsPlayerInRangeOfPoint(playerid, 7.0,HotPoint10))
     {
          SetPlayerCheckpoint(playerid, HotPoint11, 7.0);
          GameTextForPlayer(playerid, "~g~TU AS FINIS RETOURNE AU BURGER SHOT!", 3000, 3);
  	 }
     if (IsPlayerInRangeOfPoint(playerid, 7.0,HotPoint11))
     {
	     GivePlayerMoney(playerid, 50000);
	     GameTextForPlayer(playerid, "~g~10 LIVRAISON DE FAITE TU GAGNE DONC 50 000$", 3000, 3);
	     GameTextForPlayer(playerid, "~g~10 LIVRAISON DE FAITE TU GAGNE DONC 50 000$", 3000, 3);
	     new name[MAX_PLAYER_NAME], string[128];
         GetPlayerName(playerid, name, sizeof(name));
         format(string, sizeof(string), "%s a terminï¿½ sa livraison de hotdog il gagne donc 50 000$.", name );
         SendClientMessageToAll(COLOR_YELLOW, string);
     	 new veh;
     	 veh = GetPlayerVehicleID(playerid);
         SetVehicleToRespawn(veh);
         DisablePlayerCheckpoint(playerid);
         hotdog = 0;
     }
   }
}
main()
{
	print("\n---------------------------------------------------------------------------");
	print("|                      [FR] LS-TDM LIBRE V1.0 [KoD]                       |");
	print("|   [KoD]Zepek, [KoD]Jhonny, [KoD]Freddy, [KoD]Tonton_93, [KoD]Smoking    |");
	print("---------------------------------------------------------------------------\n");
}



#pragma unused ret_memcpy
