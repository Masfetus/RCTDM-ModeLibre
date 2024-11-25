#include <a_samp>
#include <core>
#include <utils>
#include <float>
#define ADMINFS_MESSAGE_COLOR 0xFF444499
#define PM_INCOMING_COLOR     0xFFFF22AA
#define PM_OUTGOING_COLOR     0xFFCC2299
#pragma tabsize 0
#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_RED 0xAA3333AA
#define COLOR_ULTRARED 0xAA3333AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_BLUE 0x0000FFAA
#define COLOR_BROWN 0x993300AA
#define COLOR_ORANGE 0xFF9933AA
#define COLOR_CYAN 0x99FFFFAA
#define COLOR_PINK 0xFF66FFAA
#define COLOR_BLACK 0x2C2727AA
#define COLOR_LIGHTCYAN 0xAAFFCC33
#define COLOR_LEMON 0xDDDD2357
#define COLOR_AQUA 0x7CFC00AA
#define COLOR_WHITEYELLOW 0xFFE87DFF
#define COLOR_BLUEAQUA 0x7E60FFFF
#define COLOR_DARKBLUE 0x15005EFF
#define COLOR_ALIEN 0x90FF87FF

#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_LIGHTBLUE 0x00D0F6AA
#define COLOR_PURPLE 0xA600F6AA
#define COLOR_TUT 0xF6C861AA
#define COLOR_ROYAL 0x00C1F6AA
#define COLOR_CWHITE 0xE0FFFFAA

#define COLOR_GOLD 0xB8860BAA
#define COLOR_IRAN 0x15005EFF
#define COLOR_America 0x90FF87FF
#define COLOR_JAPAN 0xB8860BAA
#define KICK_COLOR 0xFF0000FF
#define COLOR_GANGGREEN 0x00FF0096
#define COLOR_BLACK 0x2C2727AA
#define COLOR_SBLUE 0x00BFFFAA
#define INACTIVE_PLAYER_ID 255
#define GIVECASH_DELAY 5000
#define NUMVALUES 4
#define TEAM_IRAN 1
#define TEAM_America 2
#define TEAM_JAPAN 3
#define WELCOME                   2011
new KillerID[MAX_PLAYERS];
new bool: PlayerDied[MAX_PLAYERS];
forward MoneyGrubScoreUpdate();
forward Givecashdelaytimer(playerid);
forward GameModeExitFunc();
forward SendPlayerFormattedText(playerid, const str[], define);
forward public SendAllFormattedText(playerid, const str[], define);
enum SavePosENUM { Float:sX, Float:sY, Float:sZ, Float:sA, SavedPos };
new SavePos[MAX_PLAYERS][SavePosENUM];
new SeTSpaWns[MAX_PLAYERS];
new gTeam[MAX_PLAYERS];
new gActivePlayers[MAX_PLAYERS];
new gLastGaveCash[MAX_PLAYERS];
forward Nupdate ();
new Ntimer;
new Text:NEWS_TEXTDRAW;
new news[][] =
{
{
#define RANK_NEWBIE 0
#define RANK_BABY_KILLA 1
#define RANK_SOLDIER 2
#define RANK_GANGSTA 3
#define RANK_UNDERBOSS 4
#define RANK_BOSS 5
}
};

new Text:Newbie;
new Text:BabyKilla;
new Text:Soldier;
new Text:Gangsta;
new Text:Underboss;
new Text:Boss;
new gPlayerLogged[MAX_PLAYERS];
new pRank[MAX_PLAYERS];
main()
{
		print("\n----------------------------------");
		print("      Call Of Duty Black Ops       ");
		print("		 Par   Diablo               \n");
		print("----------------------------------\n");
}
public OnPlayerConnect(playerid)
{
	new player[MAX_PLAYER_NAME];
	GetPlayerName(playerid, player, sizeof(player));
	new string[50];
	format(string, sizeof(string), "Bienvenue '%s', Amuser vous bien ici!", player);
    SendClientMessage(playerid, COLOR_GREEN, string);
	SendPlayerFormattedText(playerid, "Tappez /aide pour bien commencer", 0);
	SendPlayerFormattedText(playerid, "Ne pas oublier de s'enregistrer et de loggué", 0);
	SendPlayerFormattedText(playerid, "Ce serveur a ete fondée par Diablo",0);
	SendPlayerFormattedText(playerid, "Amuser vous bien sur le serveur!", 0);
	pRank[playerid] = 0;
	gPlayerLogged[playerid] = 1;
	TextDrawShowForPlayer(playerid, NEWS_TEXTDRAW);
	gActivePlayers[playerid]++;
	gLastGaveCash[playerid] = GetTickCount();
    SetPlayerMapIcon( playerid, 0, 214.194396,1863.726440,13.140625, 58, 0 );
	SetPlayerMapIcon( playerid, 1, -228.306442,2729.432861,62.687500, 59, 0 );
	SetPlayerMapIcon( playerid, 2, -1309.324707,2494.259033,89.867187, 60, 0 );
	SetPlayerMapIcon( playerid, 3, 384.733917,2458.126708,16.500000, 6, 0 );
	return 1;
}
public Nupdate (){static Number = 0;TextDrawSetString(NEWS_TEXTDRAW, news[Number++]);TextDrawShowForAll(NEWS_TEXTDRAW);if(Number == sizeof(news)) Number = 0;return 1;}
public OnPlayerDisconnect(playerid)
{
	gActivePlayers[playerid]--;
}
public OnPlayerDeath(playerid, killerid, reason)
{
	if(PlayerDied[playerid] == true)
	{
	PlayerDied[playerid] = false;
 	if(KillerID[playerid] != INVALID_PLAYER_ID)
 	SendDeathMessage(INVALID_PLAYER_ID,playerid,reason);
    ResetPlayerWeapons(playerid);
	TogglePlayerSpectating(playerid,1);
	SendDeathMessage(killerid,playerid,reason);
	SetPlayerScore(killerid,GetPlayerScore(killerid)+1);
    SetPlayerScore(playerid, GetPlayerScore(playerid)-1);
    GivePlayerMoney(killerid, 1000);
    GivePlayerMoney(playerid, -1000);
	PlayerSpectatePlayer(playerid,killerid);
	SetTimerEx("spawn",10000,1, "i", playerid);
 	}
	else
	{
	TogglePlayerSpectating(playerid, 0);
	}
	    new string[256];

	if(GetPlayerScore(killerid) == 5) // Amount of required kills to get rank 1 *Baby Killa'*
    {
        GetPlayerName(killerid, string, sizeof(string) );
        format(string, sizeof(string), ">> %s advanced to rank *Baby Killa'* by killing %d players", string, GetPlayerScore(killerid) );
        SendClientMessageToAll(COLOR_LIGHTBLUE, string);
        pRank[playerid] = 1;
    }
    else if(GetPlayerScore(killerid) == 25) // Amount of required kills to get rank 2 *Soldier*
	{
	    GetPlayerName(killerid, string, sizeof(string) );
        format(string, sizeof(string), ">> %s advanced to rank *Soldier* by killing %d players", string, GetPlayerScore(killerid));
        SendClientMessageToAll(COLOR_LIGHTBLUE, string);
        pRank[playerid] = 2;
	}
	else if(GetPlayerScore(killerid) == 50) // Amount of required kills to get rank 3 *Gangsta'*
	{
        GetPlayerName(killerid, string, sizeof(string) );
	    format(string, sizeof(string), ">> %s advanced to rank *Gangsta'* by killing %d players", string, GetPlayerScore(killerid));
	    SendClientMessageToAll(COLOR_LIGHTBLUE, string);
	    pRank[playerid] = 3;
	}
	else if(GetPlayerScore(killerid) == 150) // Amount of required kills to get rank 4 *Underboss*
	{
	    GetPlayerName(killerid, string, sizeof(string) );
        format(string, sizeof(string), ">> %s advanced to rank *UnderBoss* by killing %d players", string, GetPlayerScore(killerid));
        SendClientMessageToAll(COLOR_LIGHTBLUE, string);
	    pRank[playerid] = 4;
	}
	else if(GetPlayerScore(killerid) == 300) // Amount of required kills to get rank 5 *Tha' Boss*
	{
	    GetPlayerName(killerid, string, sizeof(string) );
	    format(string, sizeof(string), ">> %s advanced to rank *The Boss* by killing %d players", string, GetPlayerScore(killerid));
	    SendClientMessageToAll(COLOR_LIGHTBLUE, string);
	    pRank[playerid] = 5;
	}
	return 1;
}
forward spawn(playerid);
public spawn(playerid)
{
TogglePlayerSpectating(playerid, 0);
}
public OnPlayerCommandText(playerid, cmdtext[])
{
	new string[256];
	new playermoney;
	new sendername[MAX_PLAYER_NAME];
	new giveplayer[MAX_PLAYER_NAME];
	new cmd[256];
	new giveplayerid, moneys, idx;
	new	tmp[256];
	new Message[256];
	new gMessage[256];
	new pName[MAX_PLAYER_NAME+1];
	new iName[MAX_PLAYER_NAME+1];


	cmd = strtok(cmdtext, idx);


	if(strcmp(cmdtext, "/ranginfo", true)==0)
	{
		SendClientMessage(playerid,COLOR_TUT, ".........:::: Infos Sur les Rangs ::::........");
        SendClientMessage(playerid,COLOR_WHITE, "Rang 0 -  *Nouveau*  (0 kills requis)");
        SendClientMessage(playerid,COLOR_WHITE, "Rang 1 -  *BeBe Killeur*  (5 kills requis)");
        SendClientMessage(playerid,COLOR_WHITE, "Rang 2 -  *Soldat*  (25 kills requis)");
		SendClientMessage(playerid,COLOR_WHITE, "Rang 3 -  *Gangster*  (50 kills requis)");
		SendClientMessage(playerid,COLOR_WHITE, "Rang 4 -  *Petit Boss*  (150 kills requis)");
		SendClientMessage(playerid,COLOR_WHITE, "Rang 5 -  *Big Boss*  (300 kills requis)");
		return 1;
}

	if (strcmp("/monrang", cmdtext, true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			new rankid = pRank[playerid];
			GetPlayerName(playerid, pName, sizeof(pName));
	    	new rank[20];
	    	if(pRank[playerid] == 0) { rank = "Nouveau"; }
		    else if(pRank[playerid] == 1) { rank = "BeBe Killeur"; }
		    else if(pRank[playerid] == 2) { rank = "Soldat"; }
		    else if(pRank[playerid] == 3) { rank = "Gangster"; }
		    else if(pRank[playerid] == 4) { rank = "Petit Boss"; }
		    else if(pRank[playerid] == 5) { rank = "Big Boss"; }

			format(string, sizeof(string), "*** %s's Rank Info ***",pName);
		    SendClientMessage(playerid, COLOR_ROYAL,string);
   			format(string, sizeof(string), "Your curent rank is %d (%s) with %d score",rankid,rank,GetPlayerScore(playerid));
		    SendClientMessage(playerid, COLOR_CWHITE,string);
		}
		return 1;
}
	if(strcmp(cmdtext, "/credits", true) == 0)
 	{
        PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0);
		ShowPlayerDialog(playerid,WELCOME,DIALOG_STYLE_MSGBOX,"Credits","Gamemode Par[Exo]DiablonLuX AdminScript System v1.3 Par LuxurioN","OK","Cancel");
        return 1;
	}
	if (strcmp("/aide", cmdtext, true, 10) == 0)
	{
		ShowPlayerDialog(playerid,WELCOME,DIALOG_STYLE_MSGBOX,"Menu aide","/Commands\n/Rules\n/Objective\n/Credits","OK","Cancel");
		return 1;
	}
	if (strcmp("/objectif", cmdtext, true, 10) == 0)
	{
		ShowPlayerDialog(playerid,WELCOME,DIALOG_STYLE_MSGBOX,"Objectiv's","Objective:\nThis Server is DM!\nHere 3 Teams\nWho Will Fight\nPlayers have to fight the opponent to get score and money.","OK","Cancel");
		return 1;
	}

	if(strcmp(cmd, "/Regles", true) == 0)
	{
			ShowPlayerDialog(playerid,WELCOME,DIALOG_STYLE_MSGBOX,"Regles du serveur","Ne pas cheater\nRespecter les joueur et les membre du staff\nNe pas Team-Kill\nEt surtout pas insulter","OK","Cancel");
    	return 1;
	}
	if(strcmp(cmd, "/Commands", true) == 0)
	{
		ShowPlayerDialog(playerid,WELCOME,DIALOG_STYLE_MSGBOX,"Commandes","/Report\n/Kill\n/pm\n/class\n/getid\n/nrg\n/sp\n/lp\n/(un)lock\n/parachute\n/bombme\n/me\n/ranginfo\n/monrang\n/anims","OK","Cancel");
    	return 1;
	}
 	if(strcmp(cmdtext, "/class",true)==0)
		{
		ForceClassSelection(playerid);
		SendClientMessage(playerid, COLOR_ULTRARED,"[CLASS]> Vous avez été forcé à la sélection de la classe");
		SetPlayerHealth(playerid, 0.00);
		return 1;
		}
 		if(strcmp(cmdtext, "/kill",true)==0)
		{
		SetPlayerHealth(playerid, 0.00);
		return 1;
		}
  if(!strcmp(cmd, "/me",true) || !strcmp(cmd, "/im",true))
		{
        new dir[256];
        dir = strtok(cmdtext, idx);
        strmid(tmp, cmdtext, 4, strlen(cmdtext));
        if(!strlen(dir))
		{
        SendClientMessage(playerid,COLOR_PINK,"[USAGE]> /me [Message/Action]");
        return 1;
        }
        dir = strtok(cmdtext, idx);
        GetPlayerName(playerid, sendername, sizeof(sendername));
        format(string, sizeof(string), "==> %s %s", sendername, tmp);
        SendClientMessageToAll(COLOR_RED,string);
        print(string);
        return 1;
        }
		//------------------------------------------------------------------------------
	if(strcmp(cmd,"/getid",true) == 0 || strcmp(cmd, "/id", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid,COLOR_RED,"Correct Usage: /getid [partie du nom]");
			return 1;
		}
		format(string,sizeof(string),"Searched for: \"%s\": ",tmp);
		SendClientMessage(playerid,COLOR_RED,string);
		new found=0;
		for(new i=0; i <= MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i))
			{
		  		new foundname[MAX_PLAYER_NAME];
		  		GetPlayerName(i, foundname, MAX_PLAYER_NAME);
				new namelen = strlen(foundname);
				new bool:searched=false;
		    	for(new pos=0; pos <= namelen; pos++)
				{
					if(searched != true)
					{
						if(strfind(foundname,tmp,true) == pos)
						{
			                found++;
							format(string,sizeof(string),"%d. %s (ID %d)",found,foundname,i);
							SendClientMessage(playerid, COLOR_GREEN ,string);
							searched = true;
						}
					}
				}
			}
		}
		return 1;
	}
 	if (strcmp(cmdtext, "/bombme", true)==0)
		{
	    new Float:X, Float:Y, Float:Z;
	    GetPlayerPos(playerid, X, Y, Z);
	    CreateExplosion(X,Y,Z-3,7,100);
	    CreateExplosion(X,Y,Z-3,7,100);
        CreateExplosion(X,Y,Z-3,7,100);
        CreateExplosion(X,Y,Z-3,7,100);
        SendClientMessage(playerid, COLOR_ULTRARED, "[LOL]> Vous avez vous-même explosé.");
        SetPlayerHealth(playerid, 50.0);
        GameTextForPlayer(playerid, "~r~Zbom",1200,5);
        return 1;
		}
	 if(strcmp(cmd, "/slap", true)==0||strcmp(cmd, "/slapper", true) ==0)
	{
	new reason[256];
new Float:x,Float:y,Float:z;
	    if(IsPlayerConnected(playerid))
	    {
	    if(!IsPlayerAdmin(playerid))
	    {
	    SendClientMessage(playerid,COLOR_SBLUE,"Vous n'êtes pas admin pour pouvoir utiliser cette commande");
	    return 1;
	    }
			    tmp = strtok(cmdtext, idx);
			    reason = strtok(cmdtext, idx);
				if(!strlen(tmp)) {
					SendClientMessage(playerid, COLOR_BLUE, "Utilisation: /(slap)per [id/pseudo] [Raison]");
					return 1;
				}
				giveplayerid = ReturnUser(tmp);
			    if(IsPlayerConnected(giveplayerid))
				{
				    if(giveplayerid != INVALID_PLAYER_ID)
				    {
						        GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
								GetPlayerName(playerid, sendername, sizeof(sendername));
								format(string,sizeof(string),"Vous avez été slappé Raison: %s",reason);
								SendClientMessage(giveplayerid, KICK_COLOR,string);
								format(string, sizeof(string), "Vous avez slappé %s", giveplayer);
								SendClientMessage(playerid, KICK_COLOR, string);
								format(string, sizeof(string), "[SLAP]Admin a slappé %s Raison: %s",giveplayer,reason);
								SendClientMessageToAll(KICK_COLOR,string);
    	                        printf("Admin %s a slappé %s Raison: %s",sendername,giveplayer,reason);
    	                        GetPlayerPos(giveplayerid,x,y,z);
    	                        SetPlayerPos(giveplayerid,x,y,z+10);
						    }
						}
				else
				{
				    SendClientMessage(playerid, COLOR_SBLUE, "Ce joueur n'est pas connecté!");
				    return 1;
				}
			}
		return 1;
	}
		 if(strcmp(cmd, "/exploser", true)==0||strcmp(cmd, "/explose", true) ==0)
	{
	new reason[256];
new Float:x,Float:y,Float:z;
	    if(IsPlayerConnected(playerid))
	    {
	    if(!IsPlayerAdmin(playerid))
	    {
	    SendClientMessage(playerid,COLOR_SBLUE,"Vous n'êtes pas admin pour pouvoir utiliser cette commande");
	    return 1;
	    }
			    tmp = strtok(cmdtext, idx);
			    reason = strtok(cmdtext, idx);
				if(!strlen(tmp)) {
					SendClientMessage(playerid, COLOR_BLUE, "Utilisation: /(explose)r [id/pseudo] [Raison]");
					return 1;
				}
				giveplayerid = ReturnUser(tmp);
			    if(IsPlayerConnected(giveplayerid))
				{
				    if(giveplayerid != INVALID_PLAYER_ID)
				    {
						        GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
								GetPlayerName(playerid, sendername, sizeof(sendername));
								format(string,sizeof(string),"Vous avez été explosé Raison: %s",reason);
								SendClientMessage(giveplayerid, KICK_COLOR,string);
								format(string, sizeof(string), "Vous avez explosé %s", giveplayer);
								SendClientMessage(playerid, KICK_COLOR, string);
								format(string, sizeof(string), "[SLAP]Admin a explosé %s Raison: %s",giveplayer,reason);
								SendClientMessageToAll(KICK_COLOR,string);
    	                        printf("Admin %s a explosé %s Raison: %s",sendername,giveplayer,reason);
    	                        GetPlayerPos(giveplayerid,x,y,z);
    	                        CreateExplosion(x,y,z,6,2);
    	                        CreateExplosion(x,y,z,6,2);
						    }
						}
				else
				{
				    SendClientMessage(playerid, COLOR_SBLUE, "Ce joueur n'est pas connecté!");
				    return 1;
				}
			}
		return 1;
	}

 if (!strcmp(cmdtext, "/chute", true) || !strcmp(cmdtext, "/parachute", true) || !strcmp(cmdtext, "/pc", true))
        {
        GivePlayerWeapon(playerid, 46, 1);
        return 1;
        }
 	if(strcmp(cmd, "/givecash", true) == 0) {
	    
		tmp = strtok(cmdtext, idx);

		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_WHITE, "AmericaGE: /givecash [ID] [Montant]");
			return 1;
		}
		giveplayerid = strval(tmp);
		
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_WHITE, "AmericaGE: /givecash [ID] [Montant]");
			return 1;
		}
 		moneys = strval(tmp);
		
		//printf("givecash_command: %d %d",giveplayerid,moneys);

		
		if (IsPlayerConnected(giveplayerid)) {
			GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			playermoney = GetPlayerMoney(playerid);
			if (moneys > 0 && playermoney >= moneys) {
				GivePlayerMoney(playerid, (0 - moneys));
				GivePlayerMoney(giveplayerid, moneys);
				format(string, sizeof(string), "Tu a donner  %s(player: %d), $%d.", giveplayer,giveplayerid, moneys);
				SendClientMessage(playerid, COLOR_YELLOW, string);
				format(string, sizeof(string), "Tu a reçu $%d de %s(player: %d).", moneys, sendername, playerid);
				SendClientMessage(giveplayerid, COLOR_YELLOW, string);
				printf("%s(playerid:%d) a transférer %d to %s(playerid:%d)",sendername, playerid, moneys, giveplayer, giveplayerid);
			}
			else {
				SendClientMessage(playerid, COLOR_YELLOW, "Montant de la Transaction invalide");
			}
		}
		else {
				format(string, sizeof(string), "%d et pas connecter", giveplayerid);
				SendClientMessage(playerid, COLOR_YELLOW, string);
			}
		return 1;
	}
	
	// PROCESS OTHER COMMANDS
	if(strcmp("/pm", cmd, true) == 0)
	{
		tmp = strtok(cmdtext,idx);

		if(!strlen(tmp) || strlen(tmp) > 5) {
			SendClientMessage(playerid,ADMINFS_MESSAGE_COLOR,"Usage: /pm [id] (message)");
			return 1;
		}

		new id = strval(tmp);
        

		if(!strlen(gMessage)) {
			SendClientMessage(playerid,ADMINFS_MESSAGE_COLOR,"Usage: /pm [id] (message)");
			return 1;
		}

		if(!IsPlayerConnected(id)) {
			SendClientMessage(playerid,ADMINFS_MESSAGE_COLOR,"/pm :Ce joueur et pas conncté!");
			return 1;
		}

		if(playerid != id) {
			GetPlayerName(id,iName,sizeof(iName));
			GetPlayerName(playerid,pName,sizeof(pName));
			format(Message,sizeof(Message),">> %s(%d): %s",iName,id,gMessage);
			SendClientMessage(playerid,PM_OUTGOING_COLOR,Message);
			format(Message,sizeof(Message),"** %s(%d): %s",pName,playerid,gMessage);
			SendClientMessage(id,PM_INCOMING_COLOR,Message);
			PlayerPlaySound(id,1085,0.0,0.0,0.0);

			printf("PM: %s",Message);

		}
		else {
			SendClientMessage(playerid,ADMINFS_MESSAGE_COLOR,"Tu peut pas envoier un m a toi-meme");
		}
		return 1;
	}
		if(strcmp(cmdtext, "/nrg", true) == 0)
		{
			new Float:X, Float:Y, Float:Z;
			GetPlayerPos(playerid, X, Y, Z);
			if(GetPlayerMoney(playerid) >= 30000)
			{
				new mnrg[MAX_PLAYERS];
				GivePlayerMoney(playerid, -60000);
				mnrg[playerid] = CreateVehicle(522, X, Y, Z + 1, 90.0, -1, -1, 100000000);
				PutPlayerInVehicle(playerid, mnrg[playerid], 0);
				AddVehicleComponent(mnrg[playerid], 1079);
				SendClientMessage(playerid, 0xFFFF00AA, "NRG-500 acheté pour 30000$");
			}
			else if(GetPlayerMoney(playerid) < 60000)
			{
				SendClientMessage(playerid, 0xEB000FFF, "ERREUR: pas assez d'argent, 30000 $ nécessaires!");
			}
			return 1;
  }
//sp lp
//------------------------------------------------------------------------------
        if(!strcmp(cmdtext, "/spos",true) || !strcmp(cmdtext,"/sp",true))
		{
		if (IsPlayerInAnyVehicle(playerid))
		{
        GetVehiclePos(GetPlayerVehicleID(playerid), SavePos[playerid][sX], SavePos[playerid][sY], SavePos[playerid][sZ]);
        GetVehicleZAngle(GetPlayerVehicleID(playerid), SavePos[playerid][sA]);
		}else {
        GetPlayerPos(playerid, SavePos[playerid][sX], SavePos[playerid][sY], SavePos[playerid][sZ]);
        GetPlayerFacingAngle(playerid, SavePos[playerid][sA]);
		}SavePos[playerid][SavedPos] = 1;
        return SendClientMessage(playerid, COLOR_WHITE,"Position sauvegarder, utilise /lp pour revenir.");
		}

//------------------------------------------------------------------------------
        if(!strcmp(cmdtext, "/lp",true) || !strcmp(cmdtext,"/lpos",true))
        {
        SetCameraBehindPlayer(playerid);
        if (SavePos[playerid][SavedPos] == 0) return SendClientMessage(playerid, COLOR_WHITE, "[SERVER]> Utiliser /sp en 1er.");
        if (IsPlayerInAnyVehicle(playerid))
		{
        SetVehiclePos(GetPlayerVehicleID(playerid), SavePos[playerid][sX], SavePos[playerid][sY], SavePos[playerid][sZ]);
        SetVehicleZAngle(GetPlayerVehicleID(playerid), SavePos[playerid][sA]);
		} else {
        SetPlayerPos(playerid, SavePos[playerid][sX], SavePos[playerid][sY], SavePos[playerid][sZ]);
        SetPlayerFacingAngle(playerid, SavePos[playerid][sA]);
		}
        return SendClientMessage(playerid, COLOR_WHITE, "Position restored");
		}
//car lock unlock
//------------------------------------------------------------------------------
		if (strcmp(cmdtext, "/lock", true)==0)
		{
			if(IsPlayerInAnyVehicle(playerid))
			{
				new State=GetPlayerState(playerid);
				if(State!=PLAYER_STATE_DRIVER)
				{
					SendClientMessage(playerid,0xFFFF00AA,"Vous ne pouvez verrouiller les portes comme le pilote.");
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
				SendClientMessage(playerid, 0xFFFF00AA, "Vehicule lock");
		    	new Float:pX, Float:pY, Float:pZ;
				GetPlayerPos(playerid,pX,pY,pZ);
				PlayerPlaySound(playerid,1056,pX,pY,pZ);
			}
			else
			{
				SendClientMessage(playerid, 0xFFFF00AA, "Tu n'est pas un vehicule!");
			}
			return 1;
			}

//------------------------------------------------------------------------------
		if (strcmp(cmdtext, "/unlock", true)==0)
		{
		if(IsPlayerInAnyVehicle(playerid))
		{
			new State=GetPlayerState(playerid);
			if(State!=PLAYER_STATE_DRIVER)
			{
				SendClientMessage(playerid,0xFFFF00AA,"Vous ne pouvez Déverrouiller les portes comme le pilote.");
				return 1;
			}
			new i;
			for(i=0;i<MAX_PLAYERS;i++)
			{
				SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid),i, 0, 0);
			}
			SendClientMessage(playerid, 0xFFFF00AA, "Vehicule unlock!");
			new Float:pX, Float:pY, Float:pZ;
			GetPlayerPos(playerid,pX,pY,pZ);
			PlayerPlaySound(playerid,1057,pX,pY,pZ);
		}
		else
		{
			SendClientMessage(playerid, 0xFFFF00AA, "Tun'est pas dans un vehicle!");
		}
		return 1;
		}
/////////

	return 0;
}



public OnPlayerSpawn(playerid)
{
	SetPlayerInterior(playerid,0);
	TogglePlayerClock(playerid,0);
    SetPlayerToTeamColor(playerid);
    SetWeather(32);
    
    	TextDrawShowForPlayer(playerid, Newbie);
	TextDrawShowForPlayer(playerid, BabyKilla);
	TextDrawShowForPlayer(playerid, Soldier);
	TextDrawShowForPlayer(playerid, Gangsta);
	TextDrawShowForPlayer(playerid, Underboss);
	TextDrawShowForPlayer(playerid, Boss);

	if(gPlayerLogged[playerid] == 0) { // If not logged in
	TextDrawHideForPlayer(playerid, Newbie);
	TextDrawHideForPlayer(playerid, BabyKilla);
	TextDrawHideForPlayer(playerid, Soldier);
	TextDrawHideForPlayer(playerid, Gangsta);
	TextDrawHideForPlayer(playerid, Underboss);
	TextDrawHideForPlayer(playerid, Boss);
	}

	if(pRank[playerid] == 0) { // Newbie
	SetPlayerHealth(playerid, 50.0);
	GivePlayerWeapon(playerid, 22, 300);
	GivePlayerWeapon(playerid, 17, 500);
	TextDrawHideForPlayer(playerid, BabyKilla);
	TextDrawHideForPlayer(playerid, Soldier);
	TextDrawHideForPlayer(playerid, Gangsta);
	TextDrawHideForPlayer(playerid, Underboss);
	TextDrawHideForPlayer(playerid, Boss);
	}

	else if(pRank[playerid] == 1) { // Baby Killa
	SetPlayerHealth(playerid, 60.0);
	SetPlayerArmour(playerid, 15.0);
	GivePlayerWeapon(playerid, 23, 300);
	GivePlayerWeapon(playerid, 17, 500);
	GivePlayerWeapon(playerid, 5, 1);
	TextDrawHideForPlayer(playerid, Newbie);
	TextDrawHideForPlayer(playerid, Soldier);
	TextDrawHideForPlayer(playerid, Gangsta);
	TextDrawHideForPlayer(playerid, Underboss);
	TextDrawHideForPlayer(playerid, Boss);
	}

	else if(pRank[playerid] == 2) { // Soldier
	SetPlayerHealth(playerid, 70.0);
	SetPlayerArmour(playerid, 25.0);
	GivePlayerWeapon(playerid, 24, 150);
	GivePlayerWeapon(playerid, 5, 1);
	TextDrawHideForPlayer(playerid, BabyKilla);
	TextDrawHideForPlayer(playerid, Newbie);
	TextDrawHideForPlayer(playerid, Gangsta);
	TextDrawHideForPlayer(playerid, Underboss);
	TextDrawHideForPlayer(playerid, Boss);
	}

	else if(pRank[playerid] == 3) { // Gangsta
	SetPlayerHealth(playerid, 80.0);
	SetPlayerArmour(playerid, 50.0);
	GivePlayerWeapon(playerid, 29, 200);
	GivePlayerWeapon(playerid, 24, 150);
	TextDrawHideForPlayer(playerid, BabyKilla);
	TextDrawHideForPlayer(playerid, Soldier);
	TextDrawHideForPlayer(playerid, Newbie);
	TextDrawHideForPlayer(playerid, Underboss);
	TextDrawHideForPlayer(playerid, Boss);
	}

	else if(pRank[playerid] == 4) { // Underboss
	SetPlayerHealth(playerid, 90.0);
	SetPlayerArmour(playerid, 75.0);
	GivePlayerWeapon(playerid, 34, 100);
	GivePlayerWeapon(playerid, 24, 300);
	TextDrawHideForPlayer(playerid, BabyKilla);
	TextDrawHideForPlayer(playerid, Soldier);
	TextDrawHideForPlayer(playerid, Gangsta);
	TextDrawHideForPlayer(playerid, Newbie);
	TextDrawHideForPlayer(playerid, Boss);
	}

	else if(pRank[playerid] == 5) { // Tha' Boss
	SetPlayerHealth(playerid, 100);
	SetPlayerArmour(playerid, 100);
	GivePlayerWeapon(playerid, 27, 100);
	GivePlayerWeapon(playerid, 24, 500);
	GivePlayerWeapon(playerid, 31, 500);
	TextDrawHideForPlayer(playerid, BabyKilla);
	TextDrawHideForPlayer(playerid, Soldier);
	TextDrawHideForPlayer(playerid, Gangsta);
	TextDrawHideForPlayer(playerid, Underboss);
	TextDrawHideForPlayer(playerid, Newbie);
	}
	return 1;
}
forward SetPlayerToTeamColor(playerid);
public SetPlayerToTeamColor(playerid)
{
    if (gTeam[playerid] == TEAM_IRAN) 
    {
        SetPlayerColor(playerid, COLOR_IRAN);
        SetPlayerInterior(playerid,0);
		SetPlayerArmour(playerid,100);
    }
    else if (gTeam[playerid] == TEAM_America) 
    {
        SetPlayerColor(playerid, COLOR_America);
        SetPlayerInterior(playerid,0);
        SetPlayerArmour(playerid,100);
    }
    else if (gTeam[playerid] == TEAM_JAPAN) 
    {
        SetPlayerColor(playerid, COLOR_JAPAN);
        SetPlayerInterior(playerid,0);
        SetPlayerArmour(playerid,100);
    }
}


public OnPlayerRequestClass(playerid, classid)
{
	SeTSpaWns[playerid] = 0;
	SetPlayerTeamFromClass(playerid, classid);
	SetPlayerInterior(playerid,0);
	SetPlayerPos(playerid, -2476.72, 1544.59, 55.46);
	SetPlayerFacingAngle(playerid, 1.304757);
	SetPlayerCameraPos(playerid, -2480.61, 1552.29, 55.43);
	SetPlayerCameraLookAt(playerid, -2476.72, 1544.59, 55.46);
	return 1;
}

public OnGameModeExit(){KillTimer(Ntimer);TextDrawDestroy(NEWS_TEXTDRAW);return 1;}

public GameModeExitFunc(){GameModeExit();}

public OnGameModeInit()
{

    Newbie = TextDrawCreate(500, 100, "Rang: Nouveau");
    TextDrawAlignment(Newbie, 1);
    TextDrawFont(Newbie, 2);
    TextDrawLetterSize(Newbie, 0.400, 1.000);
    TextDrawColor(Newbie, COLOR_WHITE);
    TextDrawSetOutline(Newbie, 1);

    BabyKilla = TextDrawCreate(486, 100, "Rang: BeBe killeur'");
    TextDrawAlignment(BabyKilla, 1);
    TextDrawFont(BabyKilla, 2);
    TextDrawLetterSize(BabyKilla, 0.400, 1.000);
    TextDrawColor(BabyKilla, COLOR_YELLOW);
    TextDrawSetOutline(BabyKilla, 1);

    Soldier = TextDrawCreate(500, 100, "Rang: Soldats");
    TextDrawAlignment(Soldier, 1);
    TextDrawFont(Soldier, 2);
    TextDrawLetterSize(Soldier, 0.400, 1.000);
    TextDrawColor(Soldier, COLOR_GREEN);
    TextDrawSetOutline(Soldier, 1);

    Gangsta = TextDrawCreate(500, 100, "Rang: Gangster");
    TextDrawAlignment(Gangsta, 1);
    TextDrawFont(Gangsta, 2);
    TextDrawLetterSize(Gangsta, 0.400, 1.000);
    TextDrawColor(Gangsta, COLOR_ROYAL);
    TextDrawSetOutline(Gangsta, 1);

    Underboss = TextDrawCreate(483, 100, "Rang: Petit Boss");
    TextDrawAlignment(Underboss, 1);
    TextDrawFont(Underboss, 2);
    TextDrawLetterSize(Underboss, 0.400, 1.000);
    TextDrawColor(Underboss, COLOR_PURPLE);
    TextDrawSetOutline(Underboss, 1);

    Boss = TextDrawCreate(490, 100, "Rang: Big Boss");
    TextDrawAlignment(Boss, 1);
    TextDrawFont(Boss, 2);
    TextDrawLetterSize(Boss, 0.400, 1.000);
    TextDrawColor(Boss, COLOR_TUT);
    TextDrawSetOutline(Boss, 1);

	Ntimer = SetTimer("Nupdate", 5000, 1);
    NEWS_TEXTDRAW = TextDrawCreate(321.000000,420.000000,"~y~/Commands");
    TextDrawUseBox(NEWS_TEXTDRAW,0);
    TextDrawBoxColor(NEWS_TEXTDRAW,0x00000099);
    TextDrawTextSize(NEWS_TEXTDRAW,0.000000,631.000000);
    TextDrawAlignment(NEWS_TEXTDRAW,2);
    TextDrawBackgroundColor(NEWS_TEXTDRAW,0x000000ff);
    TextDrawFont(NEWS_TEXTDRAW,1);
    TextDrawLetterSize(NEWS_TEXTDRAW,0.399999,1.100000);
    TextDrawColor(NEWS_TEXTDRAW,0xffffffff);
    TextDrawSetOutline(NEWS_TEXTDRAW,1);
    TextDrawSetProportional(NEWS_TEXTDRAW,1);
    TextDrawSetShadow(NEWS_TEXTDRAW,1);
	SetGameModeText("COD BO");
	UsePlayerPedAnims();
    AllowInteriorWeapons(1);
    SetWeather(32);
	ShowPlayerMarkers(1);
	ShowNameTags(1);
	AddPlayerClass(287,214.194396,1863.726440,13.140625,270.1425,31,3121,24,300,16,100);
	AddPlayerClass(285,-228.306442,2729.432861,62.687500,270.1425,31,3120,24,300,16,100);
	AddPlayerClass(277,-1309.324707,2494.259033,89.867187,270.1425,30,3120,24,300,16,100);
	// Car Spawns
	AddStaticVehicle(451,2040.0520,1319.2799,10.3779,183.2439,16,16);
	AddStaticVehicle(451,2040.0520,1319.2799,10.3779,183.2439,16,16);
	AddStaticVehicle(451,2040.0520,1319.2799,10.3779,183.2439,16,16);
	AddStaticVehicle(432,278.9016,1950.7509,17.6532,88.9054,43,0); 
	AddStaticVehicle(432,282.3510,1987.1381,17.6535,87.2516,43,0); 
	AddStaticVehicle(432,278.2103,2020.6830,17.6535,98.7492,43,0); 
	AddStaticVehicle(425,342.1974,1874.3889,18.3136,104.1868,34,0); 
	AddStaticVehicle(425,339.5558,1855.1088,18.5525,108.6887,43,0); 
	AddStaticVehicle(520,338.5540,1930.7616,18.7074,272.5084,0,0); 
	AddStaticVehicle(520,358.0111,1916.5072,18.6420,266.0934,0,0); 
	AddStaticVehicle(520,358.7953,1892.7484,18.3639,109.5348,0,0); 
	AddStaticVehicle(520,366.4059,1960.9697,18.3639,280.4560,0,0); 
	AddStaticVehicle(520,331.8059,1968.1923,18.3639,97.8575,0,0); 
	AddStaticVehicle(425,343.2718,1946.3412,18.2241,274.0224,43,0);
	AddStaticVehicle(520,229.651931,1892.521972,17.211687,274.0224,43,0); 
	AddStaticVehicle(432,182.544204,1909.152343,17.469060,274.0224,43,0); 
	AddStaticVehicle(470,184.454849,1948.658813,17.396722,0.0,43,0); 
	AddStaticVehicle(470,184.454849,1953.658813,17.396722,0.0,43,0); 
	AddStaticVehicle(470,-224.073669,2751.190185,62.539062,274.0224,43,0);
	AddStaticVehicle(470,-224.073669,2755.190185,62.539062,274.0224,43,0);
	AddStaticVehicle(520,-197.495452,2725.493164,62.687500,280.4560,0,0);
	AddStaticVehicle(432,-257.033142,2701.294189,62.535140,88.2516,43,0); 
	AddStaticVehicle(425,-294.516601,2741.593261,61.895484,100.2516,43,0); 
	AddStaticVehicle(520,-306.612548,2676.907470,62.599357,60.2516,43,0); 
	AddStaticVehicle(470,-1294.959960,2447.247558,88.042465,0.0,43,0); 
	AddStaticVehicle(470,-1297.959960,2447.247558,88.042465,0.0,43,0); 
	AddStaticVehicle(470,-1291.959960,2447.247558,88.042465,0.0,43,0); 
	AddStaticVehicle(520,-1329.691162,2488.202148,87.046875,120.0,43,0); 
	AddStaticVehicle(425,-1302.751953,2479.679687,87.278709,0.0,43,0);
	AddStaticVehicle(432,-1298.280273,2504.918212,86.957275,88.2516,43,0); 
	AddStaticPickup(371, 15, -320.800262,2742.728759,62.952674); 
	AddStaticPickup(370, 15, 384.733917,2474.126708,16.500000); 
	AddStaticPickup(355, 15, 384.733917,2472.126708,16.500000); 
	AddStaticPickup(352, 15, 384.733917,2470.126708,16.500000); 
	AddStaticPickup(351, 15, 384.733917,2468.126708,16.500000); 
	AddStaticPickup(350, 15, 384.733917,2466.126708,16.500000); 
	AddStaticPickup(349, 15, 384.733917,2464.126708,16.500000); 
	AddStaticPickup(348, 15, 384.733917,2462.126708,16.500000); 
	AddStaticPickup(344, 15, 384.733917,2460.126708,16.500000); 
	AddStaticPickup(342, 15, 384.733917,2458.126708,16.500000); 
	AddStaticPickup(359, 15, 384.733917,2456.126708,16.500000); 
	AddStaticPickup(358, 15, 384.733917,2454.126708,16.500000); 
	AddStaticPickup(357, 15, 384.733917,2452.126708,16.500000); 
	AddStaticPickup(356, 15, 384.733917,2450.126708,16.500000); 
	AddStaticPickup(366, 15, 384.733917,2448.126708,16.500000); 
	AddStaticPickup(367, 15, 384.733917,2446.126708,16.500000); 
	AddStaticPickup(365, 15, 384.733917,2444.126708,16.500000); 
	AddStaticPickup(364, 15, 384.733917,2442.126708,16.500000); 
	AddStaticPickup(363, 15, 384.733917,2440.126708,16.500000); 
	SetTimer("MoneyGrubScoreUpdate", 1000, 1);
	
	CreateObject(5005, -254.9398, 2629.4697, 65.4919, 0.0000, 0.0000, 0.0000);
	CreateObject(5005, -171.8070, 2712.8440, 65.4890, 0.0000, 0.0000, 270.0000);
	CreateObject(5005, -176.8703, 2790.9417, 64.4789, 357.4217, 0.8594, 180.0000);
	CreateObject(5001, -307.1126, 2746.8711, 62.5342, 0.0000, 0.0000, 202.5000);
	CreateObject(5005, -360.5526, 2738.1599, 64.0616, 0.0000, 0.0000, 281.2500);
	CreateObject(9482, -349.0363, 2646.9709, 69.9636, 0.0000, 0.0000, 337.5000);
	CreateObject(3279, -339.5167, 2660.0864, 62.9289, 0.0000, 0.0000, 1.7962);
	CreateObject(3279, -351.9811, 2723.3726, 62.4001, 0.0000, 0.0000, 1.7962);
	CreateObject(3279, -179.5017, 2786.7734, 61.6452, 0.0000, 0.0000, 272.4147);
	CreateObject(3279, -177.2514, 2633.9680, 61.9540, 0.0000, 0.0000, 176.1577);
	CreateObject(12911, -176.4954, 2709.1003, 61.6658, 0.0000, 0.0000, 11.2500);
	CreateObject(16093, -320.0561, 2740.5032, 61.5683, 0.0000, 0.0000, 0.0000);
	CreateObject(3268, -221.8601, 2735.1553, 61.6124, 0.0000, 0.0000, 270.0000);
	CreateObject(3277, -294.6788, 2720.3306, 62.1320, 0.0000, 0.0000, 0.0000);
	CreateObject(3277, -246.4207, 2769.7610, 62.3890, 0.0000, 0.0000, 0.0000);
	CreateObject(3277, -220.2349, 2666.4761, 62.3742, 0.0000, 0.0000, 0.0000);
	CreateObject(3267, -220.0240, 2666.2141, 62.4346, 0.0000, 0.0000, 77.9679);
	CreateObject(3267, -246.2458, 2769.9004, 62.3417, 0.0000, 0.0000, 77.9679);
	CreateObject(3267, -294.7077, 2720.5930, 62.0847, 0.0000, 0.0000, 77.9679);
	CreateObject(16779, -221.7522, 2735.5933, 70.1197, 0.0000, 0.0000, 0.0000);
	CreateObject(3386, -207.4938, 2744.3926, 61.6875, 0.0000, 0.0000, 0.0000);
	CreateObject(3387, -207.4999, 2743.3928, 61.6875, 0.0000, 0.0000, 0.0000);
	CreateObject(3387, -207.3986, 2743.7925, 61.6875, 0.0000, 0.0000, 0.0000);
	CreateObject(3387, -207.4974, 2742.4133, 61.6875, 0.0000, 0.0000, 0.0000);
	CreateObject(3386, -207.4666, 2741.4272, 61.6875, 0.0000, 0.0000, 0.0000);
	CreateObject(3390, -212.4124, 2726.7991, 61.6853, 0.0000, 0.0000, 270.0000);
	CreateObject(3391, -215.9368, 2726.8037, 61.6853, 0.0000, 0.0000, 270.0000);
	CreateObject(3393, -235.5252, 2732.9263, 61.6853, 0.0000, 0.0000, 180.0000);
	CreateObject(3786, -223.0990, 2725.8984, 63.0437, 0.0000, 87.6625, 270.0000);
	CreateObject(3786, -223.9230, 2725.8738, 63.0437, 0.0000, 87.6625, 270.0000);
	CreateObject(3786, -224.7999, 2725.9360, 63.0937, 0.0000, 87.6625, 270.0000);
	CreateObject(3788, -209.4488, 2739.1323, 62.2069, 0.0000, 0.0000, 180.0000);
	CreateObject(3788, -209.4458, 2737.6816, 62.2069, 0.0000, 0.0000, 180.0000);
	CreateObject(3788, -209.3231, 2735.9937, 62.2069, 0.0000, 0.0000, 180.0000);
	CreateObject(3788, -209.2553, 2733.9226, 62.2069, 0.0000, 0.0000, 180.0000);
	CreateObject(3790, -209.2686, 2739.1145, 62.3186, 0.0000, 0.0000, 0.0000);
	CreateObject(3795, -209.2949, 2732.0935, 62.0285, 0.0000, 0.0000, 0.0000);
	CreateObject(16782, -228.2192, 2725.5979, 65.3473, 0.0000, 0.0000, 90.0000);
	CreateObject(3390, -218.4553, 2735.3118, 61.6853, 0.0000, 0.0000, 268.2811);
	CreateObject(3390, -225.8240, 2735.4895, 61.6853, 0.0000, 0.0000, 268.2811);
	CreateObject(8263, -1274.3019, 2543.9512, 91.4514, 0.0000, 353.9839, 315.0000);
	CreateObject(8263, -1260.6560, 2500.6094, 89.4559, 0.0000, 0.0000, 255.3896);
	CreateObject(8263, -1346.3373, 2491.7375, 89.1479, 357.4217, 356.5623, 266.5623);
	CreateObject(8262, -1257.6318, 2448.5452, 89.6399, 0.0000, 0.0000, 281.2500);
	CreateObject(9482, -1324.4058, 2434.7969, 94.7742, 0.0000, 0.0000, 281.2500);
	CreateObject(1411, -1337.2031, 2432.9114, 90.2721, 0.0000, 0.0000, 0.0000);
	CreateObject(1411, -1342.5999, 2432.8882, 90.3597, 0.0000, 0.0000, 0.0000);
	CreateObject(1411, -1347.7378, 2432.8120, 90.8788, 0.0000, 0.0000, 0.0000);
	CreateObject(3279, -1336.7545, 2546.3669, 84.3876, 0.0000, 0.0000, 348.7500);
	CreateObject(3279, -1276.2366, 2538.0657, 86.7594, 0.0000, 0.0000, 236.2501);
	CreateObject(3279, -1264.9675, 2529.1968, 88.1707, 0.0000, 0.0000, 236.2501);
	CreateObject(3279, -1279.8213, 2451.6201, 86.3936, 0.0000, 0.0000, 168.7500);
	CreateObject(3279, -1346.1771, 2455.6633, 85.9918, 0.0000, 0.0000, 348.7500);
	CreateObject(12911, -1340.7258, 2485.4453, 86.1911, 0.0000, 0.0000, 0.0000);
	CreateObject(16093, -1283.4213, 2476.8713, 86.2617, 0.0000, 0.0000, 270.0000);
	CreateObject(4853, -1290.9688, 2515.7266, 88.3231, 0.0000, 0.0000, 292.5000);
	CreateObject(1252, -1340.4661, 2472.5381, 88.9848, 0.0000, 0.0000, 225.0000);
	CreateObject(1550, -1309.3625, 2544.3850, 87.1355, 0.0000, 0.0000, 0.0000);
	CreateObject(1550, -1308.8961, 2544.4812, 87.1355, 0.0000, 0.0000, 0.0000);
	CreateObject(1550, -1307.9420, 2543.8079, 87.1355, 0.0000, 0.0000, 0.0000);
	CreateObject(1550, -1309.0991, 2543.3286, 87.1355, 0.0000, 0.0000, 0.0000);
	CreateObject(1550, -1307.9792, 2542.8489, 87.1355, 0.0000, 0.0000, 0.0000);
	CreateObject(1550, -1307.3198, 2542.6135, 87.1355, 0.0000, 0.0000, 0.0000);
	CreateObject(1550, -1307.2151, 2543.5928, 87.1355, 0.0000, 0.0000, 0.0000);
	return 1;
}

forward SetPlayerTeamFromClass(playerid,classid);
public SetPlayerTeamFromClass(playerid, classid)
{
	switch(classid)
	{
	    case 0:
	    {
		    GameTextForPlayer(playerid, "~b~IRAN", 1500, 6);
		    SetPlayerInterior(playerid,0);
		    SetPlayerPos(playerid,222.472366,1822.878784,6.414062);
	        SetPlayerFacingAngle(playerid, 270.0);
	        SetPlayerCameraPos(playerid,224.472366,1822.878784,7.414062);
	        SetPlayerCameraLookAt(playerid,222.472366,1822.878784,6.414062);
		    gTeam[playerid] = TEAM_IRAN;
		    SetPlayerTeam(playerid,1);
	        ApplyAnimation(playerid,"PED","fucku",4.0,0,0,0,0,0);
		 }
		 case 1:
		 {
		    GameTextForPlayer(playerid, "~g~~h~America", 1500, 6);
		    SetPlayerInterior(playerid,0);
		    SetPlayerPos(playerid,-228.306442,2729.432861,62.687500);
	        SetPlayerFacingAngle(playerid, 270.0);
	        SetPlayerCameraPos(playerid,-226.306442,2729.432861,62.687500);
	        SetPlayerCameraLookAt(playerid,-228.306442,2729.432861,62.687500);
		    gTeam[playerid] = TEAM_America;
		    SetPlayerTeam(playerid,2);
		    ApplyAnimation(playerid,"PED","fucku",4.0,0,0,0,0,0);
		}
		case 2:
		{
  		    GameTextForPlayer(playerid, "~b~JAPAN", 1500, 6);
		    SetPlayerInterior(playerid,0);
		    SetPlayerPos(playerid,-1309.324707,2494.259033,89.867187);
		    SetPlayerFacingAngle(playerid, 357.1708);
		    SetPlayerCameraPos(playerid, -1306.324707,2494.259033,89.867187);
		    SetPlayerCameraLookAt(playerid, -1309.324707,2494.259033,89.867187);
		    gTeam[playerid] = TEAM_JAPAN;
		    SetPlayerTeam(playerid,3);
		    ApplyAnimation(playerid,"PED","fucku",4.0,0,0,0,0,0);
                     }

		}

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

strtok(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' '))
	{
		index++;
	}

	new offset = index;
	new result[20];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}
