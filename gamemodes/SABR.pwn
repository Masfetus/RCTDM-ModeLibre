//--------------- INCLUDES
#include <a_samp>
#include <jh_utils>
//---------------- MACROS
#define VERSION "v0.1"

enum E_TEST
{
	Float:e_X,
	Float:e_Y,
	Float:e_Z
};
new Test1[E_TEST];
new Test2[E_TEST];
static const FS_Parts[][32] = {
	"SABR_connect",
	"SABR_lobbys",
	"SABR_admin"
};
main()
{
	print("**********************||||----- Battle Royale GM "VERSION" ------|||||******************");
	print("Blablablabla");
	print("Le gamemode va charger dans quelques instants !");
	
	printf("Différence : %d", difftime(19, 0, 0, 20, 0, 0));
	Test1[e_X] = 1.0;
	Test2[e_X] = 2.0;
	printf("Test1 : %.f | Test2: %.f | e_X : %.f", Test1[e_X], Test2[e_X], _:e_X);
}
stock difftime(fromhours, fromminutes, fromseconds, tohours, tominutes, toseconds)
{
	if(tohours < fromhours) tohours += 24;
	new diff = (fromhours * 3600 + fromminutes * 60 + fromseconds) - (tohours * 3600 + tominutes * 60 + toseconds);
	return (diff < 0 ? -diff : diff);
}
// PUBLICS
forward OnMinutePasses();
forward OnSecondPasses();

public OnSecondPasses()
{
	static seconds = 0;
	if(seconds == 60) OnMinutePasses(), seconds = 0;
	if(TimeReboot != -1)
	{
		
		new minutes = TimeReboot / 60;
		new hours = minutes / 60, second = TimeReboot;
		second %= 60;
		minutes %= 60;

		new string[128];
		if(hours && minutes == 0 && second == 0) format(string, sizeof(string), "~w~Reboot dans ~y~%d~w~ heures", hours);
		else if(!hours && ( (!(minutes % 15) || minutes == 5 || minutes == 1) && minutes != 0) && second == 0) format(string, sizeof(string), "~w~Reboot dans ~y~%d~w~ minutes", minutes);
		else if(!hours && !minutes && (second == 30 || second < 4)) format(string, sizeof(string), "~w~Reboot dans ~y~%d~w~ secondes", second);
  		GameTextForAll(string, 2500, 5);
		print(string);

		if(TimeReboot == 0)
		{
		    SendClientMessageToAll(ROUGE, "[Reboot] Le serveur redémarre, veuillez nous excuser pour le dérangement ...");
		    SendRconCommand("gmx");
		}
		SetSVarInt("g_Reboot", TimeReboot - 1);
	}
	seconds ++;
    SetTimer("OnSecondPasses", 1000, false);
	return 1;
}
public OnMinutePasses()
{
	for(new i = 0; i <= GetPlayerPoolSize(); i++)
	{
	    if(IsPlayerConnected(i))
	    {
	        if(IsPlayerJailed(i)) SetPlayerJail(i, GetPlayerJailTime(i) - 1);
	    }
	}
	
	return 1;
}
public OnGameModeInit()
{
	new count = GetTickCount();
	SetGameModeText("SABR - "VERSION);
	for(new i = 0; i < sizeof(FS_Parts); i++)
	{
	    new str[64];
	    format(str, sizeof(str), "loadfs %s", FS_Parts[i]);
	    SendRconCommand(str);
	}
	SetTimer("OnSecondPasses", 1000, false);
	printf("[GM] GameMode chargé en %d ms", TimePassedSince(count));
	return 1;
}

public OnGameModeExit()
{
	for(new i = 0; i < sizeof(FS_Parts); i++)
	{
	    new str[64];
	    format(str, sizeof(str), "unloadfs %s", FS_Parts[i]);
	    SendRconCommand(str);
	}
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraLookAt(playerid, 1958.3783, 1343.1572, 15.3746);
	return 1;
}

public OnPlayerConnect(playerid)
{
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
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
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/mycommand", cmdtext, true, 10) == 0)
	{
		// Do something here
		return 1;
	}
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
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
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

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}
