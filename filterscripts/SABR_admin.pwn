#define FILE_ADMIN

//--------------- INCLUDES
#include <a_samp>
#include <jh_utils>
//#include <regex>

//---------------- MACROS
// Dialogs


// Couleurs
#define ROUGE 0xFF0000FF

// Messages
#define NotRankedEnough(%0) SendClientMessage(%0, ROUGE, "Tu n'es pas assez haut gradé !")
#define NotConnected(%0) SendClientMessage(%0, ROUGE, "Ce joueur n'est pas connecté !")

//---------------- CONSTANTES
static const GradeNames[][] = {
	"Banni",
	"Joueur",
	"Modérateur",
	"Administrateur",
	"Responsable"
};
//---------------- VARIABLES
enum speInfo
{
	Interior,
	Float:PosX,
	Float:PosY,
	Float:PosZ
};
new SpecInfoPlayer[MAX_PLAYERS][speInfo];
new bool:Spectating[MAX_PLAYERS char];
new PlayerSpectate[MAX_PLAYERS];

//---------------- FONCTIONS
// PRIVATES
stock ResetSpecData(playerid)
{
	Spectating{playerid} = false;
	PlayerSpectate[playerid] = INVALID_PLAYER_ID;
	SpecInfoPlayer[playerid][Interior] = 0;
	SpecInfoPlayer[playerid][PosX] = -1.0;
    SpecInfoPlayer[playerid][PosY] = -1.0;
    SpecInfoPlayer[playerid][PosZ] = -1.0;
}
stock ResetData(playerid)
{
	ResetSpecData(playerid);
}
// COMMANDES
//-------------------- COMMANDES MODO ----------------------------------------------//
YCMD:kick(playerid, params[], help)
{
	#pragma unused help
	new reason[64], id, string[128];
	if(!IsPlayerModerator(playerid)) return NotRankedEnough(playerid);
	if(sscanf(params, "uS(Aucune)[63]", id, reason)) return SendClientMessage(playerid, ROUGE, ".:: /kick [ID / Pseudo] [Raison] ::.");
	if(!IsPlayerConnected(id)) return NotConnected(playerid);
	
	format(string, sizeof(string), "{FFFFFF}%s{FF0000} a été kick par {FFFFFF}%s{FF0000}. Raison : {FFFFFF}%s", GetName(id), GetName(playerid), reason);
	SendClientMessageToAll(ROUGE, string);
	format(string, sizeof(string), "Vous avez été kick pour %s", reason);
	SendClientMessage(id, ROUGE, string);
	printf("[KICK] %s a kick %s - Raison: %s", GetName(playerid), GetName(id), reason);
	SetTimerEx("TimerKick", 100, false, "i", id);

	return 1;
}
YCMD:spec(playerid, params[], help)
{
	#pragma unused help
	new id = INVALID_PLAYER_ID, string[128];
	if(!IsPlayerModerator(playerid)) return NotRankedEnough(playerid);
	if(sscanf(params,"u", id)) return SendClientMessage(playerid, ROUGE, ".:: /spec [ID / Pseudo] ::.");
	if(!IsPlayerConnected(id)) return NotConnected(playerid);
	
	format(string, sizeof(string), "{FFFF00}Vous surveillez {FFFFFF}%s", GetName(id));
	SendClientMessage(playerid, -1, string);
	TogglePlayerSpectating(playerid, true);
	PlayerSpectatePlayer(playerid, id);
	Spectating{playerid} = true;
	PlayerSpectate[playerid] = id;
	GetPlayerPos(playerid, SpecInfoPlayer[playerid][PosX], SpecInfoPlayer[playerid][PosY], SpecInfoPlayer[playerid][PosZ]);
	SpecInfoPlayer[playerid][Interior] = GetPlayerInterior(playerid);
	SendClientMessage(playerid, -1, "Appuyez sur les flèches directionnelles pour changer de personne et sur N pour arrêter de spec");
	return 1;
}
YCMD:jail(playerid, params[], help)
{
	#pragma unused help
	new id = INVALID_PLAYER_ID, string[256], reason[64], time = 0;
	if(!IsPlayerModerator(playerid)) return NotRankedEnough(playerid);
	if(sscanf(params, "uS(Aucune)[64]I(5)", id, reason, time)) return SendClientMessage(playerid, ROUGE, ".:: /jail[ID / Pseudo][Raison][Temps (5min par défaut)] ::.");
	if(time <= 0) return SendClientMessage(playerid, ROUGE, "Temps invalide !");
	if(!IsPlayerConnected(id)) return NotConnected(playerid);
	
	format(string, sizeof(string), "{FFFFFF}%s {FF0000}a été jail par {FFFFFF}%s {FF0000} ({FFFFFF}%d minutes{FF0000}). Raison : {FFFFFF}%s", GetName(id), GetName(playerid), time, reason);
	SendClientMessageToAll(ROUGE, string);
	SetPlayerJail(id, time);
	
	return 1;
}
YCMD:unjail(playerid, params[], help)
{
	#pragma unused help
	new id = INVALID_PLAYER_ID;
	
	if(!IsPlayerModerator(playerid)) return NotRankedEnough(playerid);
	if(sscanf(params, "u", id)) return SendClientMessage(playerid, ROUGE, ".:: /unjail [ID / Pseudo] ::.");
	if(!IsPlayerConnected(id)) return NotConnected(playerid);
	
	SetPlayerJail(id, 0);
	
	return 1;
}
YCMD:reboot(playerid, params[], help)
{
	#pragma unused help
	new time = 0;
	
	if(!IsPlayerOwner(playerid)) return NotRankedEnough(playerid);
	if(sscanf(params, "I(0)", time)) return SendClientMessage(playerid, ROUGE, ".:: /reboot [Temps (en min.)] ::.");
	if(time < 0) return SendClientMessage(playerid, ROUGE, "Temps incorrect !");
	if(TimeReboot >= 0) return SendClientMessage(playerid, ROUGE, "Un reboot est déjà programmé ! (/stopgmx pour annuler)");
	
	SetSVarInt("g_Reboot", time * 60);
	if(time != 0)
	{
	    new hour = time / 60, string[256];
		if(hour != 0)
		{
			time %= 60;
			format(string, sizeof(string), "{FF0000}[Reboot] Le serveur redémarrera dans {FFFFFF}%d {FF0000}heures et {FFFFFF}%d {FF0000}minutes", hour, time);
		}
		else format(string, sizeof(string), "{FF0000}[Reboot] Le serveur redémarrera dans {FFFFFF}%d {FF0000}minutes", time);
		SendClientMessageToAll(ROUGE, string);
	}
	return 1;
}
YCMD:stopgmx(playerid, params[], help)
{
	#pragma unused params, help
	if(!IsPlayerOwner(playerid)) return NotRankedEnough(playerid);
	if(TimeReboot < 0) return SendClientMessage(playerid, ROUGE, "Aucun reboot n'est programmé !");
	
	SetSVarInt("g_Reboot", -1);
	SendClientMessage(playerid, ROUGE, "[Reboot] Le redémarrage du serveur a été annulé !");
	
	return 1;
}
// PUBLICS

//----------------- CALLBACKS
public OnFilterScriptInit()
{
	new count = GetTickCount();


	
	SetSVarInt("g_Reboot", -1); // Variable globale pour le timer du reboot (en secondes)
	
	for(new i = 0; i < MAX_PLAYERS; i++) if(!IsPlayerConnected(i)) ResetData(i);
	print("\n--------------------------------------");
	printf(" Système d'administration - SABR (chargé en %d ms)", TimePassedSince(count));
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	DeleteSVar("g_Reboot");
	return 1;
}


public OnPlayerConnect(playerid)
{
	if(!IsPlayerNPC(playerid))
	{
	}
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	ResetData(playerid);
	return 1;
}

public OnPlayerSpawn(playerid)
{
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	new string[144];
	if(text[0] == '*' && GetAdminLevel(playerid) > 1)
	{
	    strdel(text, 0, 1);
		for(new i = 0; i <= GetPlayerPoolSize(); i++) if(IsPlayerConnected(i) && GetAdminLevel(i) > 1)
		{
			format(string, sizeof(string), "{FFFF00}[ADMIN][%s] %s : {FFFFFF}%s", GradeNames[GetAdminLevel(playerid)], GetName(playerid), text);
			SendClientMessage(i, -1, string);
		}
	}
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	return 0;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	new IDSpec = INVALID_PLAYER_ID;
	for(new i = 0; i <= GetPlayerPoolSize(); i++) if(playerid == PlayerSpectate[i])
	{
		IDSpec = i;
		break;
	}
	if(IsPlayerConnected(IDSpec))
	{
		if( (newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER) && oldstate == PLAYER_STATE_ONFOOT) PlayerSpectateVehicle(IDSpec, GetPlayerVehicleID(playerid));
		else if(newstate == PLAYER_STATE_ONFOOT && (oldstate == PLAYER_STATE_PASSENGER || oldstate == PLAYER_STATE_DRIVER)) PlayerSpectatePlayer(IDSpec, playerid);
	}
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	new IDSpec = INVALID_PLAYER_ID;
	for(new i = 0; i <= GetPlayerPoolSize(); i++) if(PlayerSpectate[i] == playerid)
	{
 		IDSpec = i;
		break;
	}
	if(IsPlayerConnected(IDSpec)) SetPlayerInterior(IDSpec, newinteriorid);
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys & KEY_NO)
	{
	    if(Spectating{playerid})
	    {
			TogglePlayerSpectating(playerid, false);
			SetPlayerPos(playerid, SpecInfoPlayer[playerid][PosX], SpecInfoPlayer[playerid][PosY], SpecInfoPlayer[playerid][PosZ]);
			SetPlayerInterior(playerid, SpecInfoPlayer[playerid][Interior]);
			ResetSpecData(playerid);
		}
	}
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
    new Keys,ud,lr, string[128];
    GetPlayerKeys(playerid,Keys,ud,lr);
	if(Spectating{playerid})
	{
		if(lr == KEY_LEFT)
		{
		    loop_player:
			PlayerSpectate[playerid]--;
			if(PlayerSpectate[playerid] == INVALID_PLAYER_ID) PlayerSpectate[playerid] = GetPlayerPoolSize();
			if(!IsPlayerConnected(PlayerSpectate[playerid])) goto loop_player;

			format(string, sizeof(string), "~y~%s | ~w~ID : %d", GetName(PlayerSpectate[playerid]), PlayerSpectate[playerid]);
			GameTextForPlayer(playerid, string, 1500, 5);
			PlayerSpectatePlayer(playerid, PlayerSpectate[playerid]);

		}
	    else if(lr == KEY_RIGHT)
	    {
	    	loop_player:
			PlayerSpectate[playerid]++;
			if(PlayerSpectate[playerid] > GetPlayerPoolSize()) PlayerSpectate[playerid] = 0;
			if(!IsPlayerConnected(PlayerSpectate[playerid])) goto loop_player;

			format(string, sizeof(string), "~y~%s | ~w~ID : %d", GetName(PlayerSpectate[playerid]), PlayerSpectate[playerid]);
			GameTextForPlayer(playerid, string, 1500, 5);
			PlayerSpectatePlayer(playerid, PlayerSpectate[playerid]);
	    }
	}
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}
public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
    return 0;
}
public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
  	return 0;
}
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}
