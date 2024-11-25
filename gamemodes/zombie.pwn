// This is a comment
// uncomment the line below if you want to write a filterscript
//#define FILTERSCRIPT

#include <a_samp>

new gTeam[MAX_PLAYERS];
main()
{
	print("\n----------------------------------");
	print(" ** Zombie Invasion BY Dim_Jhonny");
	print("----------------------------------\n");
}


public OnGameModeInit()
{
	// Don't use these lines if it's a filterscript
	SetGameModeText("Zombie Invasion");
	AddPlayerClass(47 ,358.8864,207.4143,1008.3828, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(296 ,358.8864,207.4143,1008.3828, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(299 ,358.8864,207.4143,1008.3828, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(160, 350.3217,164.1745,1019.9912, 0,0,0,0,0,0);
	AddPlayerClass(162,350.3217,164.1745,1019.9912,0,0,0,0,0,0);
	AddPlayerClass(230,350.3217,164.1745,1019.9912,0,0,0,0,0,0);
	return 1;
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
if(classid == 0 || classid == 1 || classid == 2)
    {
        gTeam[playerid] = 1;
        GameTextForPlayer(playerid,"~B~CIVIL",1000,6);
        SetPlayerPos(playerid,-2670.7632,1410.4504,907.570);
        SetPlayerCameraPos(playerid,-2664.1206,1410.3835,929.7339);
        SetPlayerCameraLookAt(playerid,-2670.7632,1410.4504,907.570);
        SetPlayerFacingAngle(playerid,269.9116);
        ApplyAnimation(playerid, "RAPPING", "Laugh_01", 4.0, 0, 0, 0, 0, 0);
        SetPlayerColor(playerid,0x2600FFFF);
	  }
	  if(classid == 3 || classid == 4 || classid == 5)
    {
        gTeam[playerid] = 1;
        GameTextForPlayer(playerid,"~R~ZOMBIE",1000,6);
        SetPlayerPos(playerid,-2670.7632,1410.4504,907.570);
        SetPlayerCameraPos(playerid,-2664.1206,1410.3835,929.7339);
        SetPlayerCameraLookAt(playerid,-2670.7632,1410.4504,907.570);
        SetPlayerFacingAngle(playerid,269.9116);
        ApplyAnimation(playerid, "RAPPING", "Laugh_01", 4.0, 0, 0, 0, 0, 0);
        SetPlayerColor(playerid,0x2600FFFF);
	  }
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
	new name[MAX_PLAYER_NAME];
	new string[256];
	new deathreason[20];
	new playercash;
	GetPlayerName(playerid, name, sizeof(name));
	GetWeaponName(reason, deathreason, 20);
	if (killerid == INVALID_PLAYER_ID) {
	    switch (reason) {
			case WEAPON_DROWN:
			{
                format(string, sizeof(string), "*** %s s'est noyé car il ne sait pas nagé.***", name);
			}
			default:
			{
			    if (strlen(deathreason) > 0) {
					format(string, sizeof(string), "*** %s est mort.*** (%s)", name, deathreason);
				}
			}
		}
	}
	else {
	new killer[MAX_PLAYER_NAME];
	GetPlayerName(killerid, killer, sizeof(killer));
	if (strlen(deathreason) > 0) {
		format(string, sizeof(string), "*** %s à powned %s.*** (%s)", killer, name, deathreason);
		} else {
				format(string, sizeof(string), "*** %s à powned %s.***", killer, name);
			}
		}
	SendClientMessageToAll(0xFF0000FF, string);
		{
		playercash = GetPlayerMoney(playerid);
		if (playercash > 0)
		{
		SetDeathDropAmount(200);
			GivePlayerMoney(killerid, playercash);
			ResetPlayerMoney(playerid);
		}
		else
		{
		}
	}
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
