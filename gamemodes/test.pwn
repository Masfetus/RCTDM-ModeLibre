// This is a comment
// uncomment the line below if you want to write a filterscript
//#define FILTERSCRIPT

#include <a_samp>
new const
	Mission_Dialogs[2][9][] =
	{
	    { // Mission 1
	        "Matthew: Putain c'est toi ? Mais c'est génial ! Depuis quand t'es arrivé ? ~n~Ça fait un bail ! Enfin laisse, c'est cool de te voir ici.",
	        "Matthew: J'suis un peu dans la merde en c'moment tu vois, ~n~j'dois de l'argent par-ci par-là, mais c'est d'la bricole.",
	        "Matthew: J'aimerais juste que tu bosses pour un d'ces gars-là,~n~ Ça règlera mon problème et ça t'occupera, tu pourrais même te faire des amis !",
	        "Matthew: Y s'appelle Fabrizio Luccetti, il est jamais bien loin de King's,~n~repasse me voir quand tu lui auras parlé ! Ah, et merci hein !",
	        "Moi: J'adore quand on me laisse le temps d'en placer une... J'irais l'voir... Salut.",
	        "",
	        "",
	        "",
	        ""
	    },
	    { // Mission 2
	        "Fabrizio: À qui ai-je l'honneur ?",
	        "Moi: Je suis un ami de Matthew, il vous doit du fric.",
	        "Fabrizio: Exact et alors quoi, tu viens payer?",
	        "Moi: En quelque sorte.",
	        "Fabrizio: Bon eh ben vas-y, donne !",
	        "Moi: Non, j'ai des bras, des jambes et un cerveau, c'est plus utile.",
	        "Fabrizio: Ah, tu viens donner de ta personne, je vois. Très bien, tu vas te charger d'un truc pour moi.",
	        "Fabrizio: Tu vas commencer par aller chercher une \"cargaison spéciale\" sur les docks,~n~ y'a un camion qui t'attends dehors.",
	        "Fabrizio: J'te laisse faire c'que t'as à faire."
		}
	};
main()
{
	for(new i; i < 2; i ++)
	{
	    for(new j; j <9; j++)
	    {
	        printf("Mission_Dialogs[%d][%d] = %s",i,j,Mission_Dialogs[i][j]);
		}
	}
	print("\n----------------------------------");
	print(" Blank Gamemode by your name here");
	print("----------------------------------\n");
}

public OnGameModeInit()
{
	// Don't use these lines if it's a filterscript
	SetGameModeText("Blank Script");
	AddPlayerClass(0, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	return 1;
}

public OnGameModeExit()
{
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
