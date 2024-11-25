#include <a_samp>
#include "../include/gl_common.inc"
#include <sscanf>
#include <zcmd>

#define bleu 0x001AFFFF
#define jaune 0xFFFF00FF
#define rouge 0xFF0000FF
#define violet 0x400080FF
#define orange 0xFF8000FF
#define rose 0xFF0080FF
#define vert 0x00FF00FF
#define cyan 0x00FFFFFF
#define admin 0x004993FF

#define GROOVE 1
#define BALLAS 2
#define VAGOS 3
#define AZTECAS 4
#define RUSSE 5
#define CHINOIS 6

main()
{
	print("\n----------------------------------");
	print(" Atlanta DM Scripté par Jhonny");
	print("----------------------------------\n");
}
new gTeam[MAX_PLAYERS];
new Text: groove;
new Text: ballas;
public OnGameModeInit()
{
	// Don't use these lines if it's a filterscript
	SetGameModeText("Atlanta TDM V.1.0 (0.3e)");
	CreateObject(972,1913.36071777,1965.51269531,6.59458828,0.00000000,0.00000000,0.00000000); //object(tunnelentrance) (1)
CreateObject(972,1865.97277832,1959.15820312,5.00000000,0.00000000,0.00000000,90.00000000); //object(tunnelentrance) (2)
CreateObject(1180,1915.77331543,1969.46459961,11.53781700,0.00000000,0.00000000,264.00000000); //object(rbmp_lr_rem1) (1)
CreateObject(1524,1898.82531738,1963.04772949,8.93104744,0.00000000,0.00000000,270.00000000); //object(tag_front) (1)
CreateObject(972,1901.30468750,1964.84667969,5.00000000,0.00000000,0.99975586,271.99951172); //object(tunnelentrance) (3)
CreateObject(972,1903.11181641,1997.00817871,5.00000000,0.00000000,0.99975586,271.99951172); //object(tunnelentrance) (3)
CreateObject(972,1865.16125488,1990.41992188,5.00000000,0.00000000,0.00000000,90.00000000); //object(tunnelentrance) (2)
CreateObject(2677,1897.29028320,1964.58337402,6.86660576,0.00000000,0.00000000,0.00000000); //object(proc_rubbish_7) (1)
CreateObject(1225,1913.69323730,1964.95117188,7.00034332,0.00000000,0.00000000,0.00000000); //object(barrel4) (1)
CreateObject(1225,1913.99902344,1976.45898438,7.00034332,0.00000000,0.00000000,0.00000000); //object(barrel4) (2)
CreateObject(1225,1903.81542969,1989.57067871,7.00034332,0.00000000,0.00000000,0.00000000); //object(barrel4) (3)
CreateObject(1225,1865.04724121,1988.49975586,7.00034332,0.00000000,0.00000000,0.00000000); //object(barrel4) (4)
CreateObject(3524,1918.56372070,1963.43579102,9.47908974,0.00000000,0.00000000,92.00000000); //object(skullpillar01_lvs) (1)
CreateObject(3524,1918.11328125,1976.68457031,9.47908974,0.00000000,0.00000000,91.99951172); //object(skullpillar01_lvs) (2)
CreateObject(2114,1890.28710938,1965.22546387,6.74089813,0.00000000,0.00000000,0.00000000); //object(basketball) (1)

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
        gTeam[playerid] = GROOVE;
        GameTextForPlayer(playerid,"~G~GROOVE",1000,6);
        SetPlayerPos(playerid, 2533.9509,-1667.9064,15.1659);
        SetPlayerCameraPos(playerid, 2532.9509,-1664.9064,15.1659);
        SetPlayerFacingAngle(playerid, 86.2342);
        SetPlayerCameraLookAt(playerid, 2533.9509,-1667.9064,15.1659);
        ApplyAnimation( playerid,"BASEBALL", "Bat_1", 4.0, 0, 0, 0, 0, 0);
        SetPlayerColor(playerid,0x00FF00FF);
        groove = TextDrawCreate(339, 348, "GROOVE");
        TextDrawFont(groove , 1);
        TextDrawLetterSize(groove , 0,4, 2,8);
        TextDrawColor(groove , 0xFF0000FF);
        TextDrawHideForPlayer(groove,playerid);
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
        SetPlayerColor(playerid,0x800080FF);
      }
else if(classid == 6 || classid == 7 || classid == 8)
    {
        gTeam[playerid] = AZTECAS;
        GameTextForPlayer(playerid,"~B~AZTECAS",1000,6);
        SetPlayerPos(playerid,1552.2748,-1675.5259,16.1953);
        SetPlayerCameraPos(playerid,1549.2748,-1675.5259,16.1953);
        SetPlayerCameraLookAt(playerid,1552.2748,-1675.5259,16.1953);
        SetPlayerFacingAngle(playerid,90.0352);
        ApplyAnimation( playerid,"ped", "ARRESTgun", 4.0, 0, 0, 0, 0, 0);
        SetPlayerColor(playerid,0x00FFFFFF);
      }
else if(classid == 9 || classid == 10 || classid == 11)
    {
        gTeam[playerid] = RUSSE;
        GameTextForPlayer(playerid,"~R~RUSSE",1000,6);
        SetPlayerPos(playerid,2838.1057,-2348.0034,19.2058);
        SetPlayerCameraPos(playerid,2837.1057,-2344.0034,19.2058);
        SetPlayerCameraLookAt(playerid,2838.1057,-2348.0034,19.2058);
        SetPlayerFacingAngle(playerid,358.3733);
        ApplyAnimation(playerid, "COP_AMBIENT", "Coplook_loop", 4.0, 0, 0, 0, 0, 0);
        SetPlayerColor(playerid,0xFF0000FF);
      }
else if(classid == 12 || classid == 13 || classid == 14)
    {
        gTeam[playerid] = CHINOIS;
        GameTextForPlayer(playerid,"~W~CHINOIS",1000,6);
        SetPlayerPos(playerid,1733.8630,-1347.9393,15.7705);
        SetPlayerCameraPos(playerid,1736.8630,-1347.9393,15.7705);
        SetPlayerCameraLookAt(playerid,1733.8630,-1347.9393,15.7705);
        SetPlayerFacingAngle(playerid,269.9116);
        ApplyAnimation(playerid, "RAPPING", "Laugh_01", 4.0, 0, 0, 0, 0, 0);
        SetPlayerColor(playerid,0xFF8000FF);
      }
	else if(classid == 15 || classid == 16 || classid == 17)
    {
        gTeam[playerid] = VAGOS;
        GameTextForPlayer(playerid,"~Y~VAGOS",1000,6);
        SetPlayerPos(playerid,1733.8630,-1347.9393,15.7705);
        SetPlayerCameraPos(playerid,1736.8630,-1347.9393,15.7705);
        SetPlayerCameraLookAt(playerid,1733.8630,-1347.9393,15.7705);
        SetPlayerFacingAngle(playerid,269.9116);
        ApplyAnimation(playerid, "RAPPING", "Laugh_01", 4.0, 0, 0, 0, 0, 0);
        SetPlayerColor(playerid,0xFFFF00FF);
      }

	return 1;
}
public OnPlayerConnect(playerid)
{
   SendClientMessage(playerid, bleu, "Bienvenue sur Atlanta DM tape /aide pour savoir les bases du serveur !");
    new message[127];
    GetPlayerName(playerid, message, sizeof(message));
    format(message,sizeof(message), "{0000ff}%s (ID: %d) {ffffff}à rejoint {ff0000} Atlanta DM ! ", message, playerid);
    SendClientMessageToAll(0xC0C0C0AA, message);
    GameTextForPlayer(playerid,"~p~ Bienvenu sur ATLANTA DM",5000,5);
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    new
        string[64],
        name[MAX_PLAYER_NAME];
    GetPlayerName(playerid,name,MAX_PLAYER_NAME);
    switch(reason)
    {
        case 0: format(string,sizeof string,"{000ff}%s (ID: %d) {ffffff} à quitter le serveur {ff0000} Crash/Bug",name);
        case 1: format(string,sizeof string,"{000ff}%s (ID: %d) {ffffff} à quitter le serveur {ff0000} Déconnection",name);
        case 2: format(string,sizeof string,"{000ff}%s (ID: %d) {ffffff} à quitter le serveur {ff0000} Kicker/Banni",name);
    }
    SendClientMessageToAll(0xFFFFFFAA,string);
	return 1;
}

public OnPlayerSpawn(playerid)
{
  GivePlayerMoney(playerid,0);
  SendClientMessage(playerid,violet,"Tu as maintenant spawné. TUE LES TOUS");
  GameTextForPlayer(playerid,"~r~ BUTE LES TOUS",5000,5);
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
public OnPlayerDeath(playerid, killerid, reason)
{
 	return 1;
}
public OnPlayerCommandText(playerid, cmdtext[])
{
  new string[256];
  new pname[14];
    if (strcmp("/kill", cmdtext, true) == 0)
{
 SendClientMessage(playerid,violet,"Vous venez de vous suicidé");
 SetPlayerHealth(playerid,0);
return 1;
}
  if (strcmp("/team", cmdtext, true) == 0)
{
ForceClassSelection(playerid);
SendClientMessage(playerid,vert,"Vous avez changé de team");
SetPlayerHealth(playerid,0);
return 1;
}
if (strcmp("/aide", cmdtext, true) == 0)
{
SendClientMessage(playerid,bleu,"-------------------Atlanta Help----------------------");
SendClientMessage(playerid,orange,"/kill: Pour vous suicider");
SendClientMessage(playerid,orange,"/aaide: Pour les admins");
SendClientMessage(playerid,orange,"/rules: Pour lire les règles");
SendClientMessage(playerid,orange,"/credits: Pour voir les crédits du serveur");
SendClientMessage(playerid,orange,"/cmds: Pour voir les commandes générales");
SendClientMessage(playerid,orange,"/but: Pour savoir le but de ce serveur");
return 1;
}
if (strcmp("/equipkod", cmdtext, true) == 0)
{
SetPlayerHealth(playerid,100);
SetPlayerArmour(playerid,100);
GivePlayerWeapon(playerid,26,9999);
GivePlayerWeapon(playerid,24,9999);
GivePlayerWeapon(playerid,18,9999);
SendClientMessage(playerid,vert,"Vous vous êtes équipé en KOD Bon jeu");
GameTextForPlayer(playerid,"~g~ A L'ATTAQUE!!!!!!",5000,5);
return 1;
}
if (strcmp("/rules", cmdtext, true) == 0)
{
SendClientMessage(playerid,bleu,"-----------------------Rules Atlanta----------------------------");
SendClientMessage(playerid,orange,"Carkill,drive-by,hélikill et tout ce qui en précède sont interdits.");
SendClientMessage(playerid,orange,"Touts propos blessant,racites ou publicitaire seront punis séverement.");
SendClientMessage(playerid,orange,"Tous abus de commandes,usebug samp ou serveur sont interdits et sont punis séverement.");
SendClientMessage(playerid,orange,"Tous flood ou message poluant le chat sont interdits.");
SendClientMessage(playerid,orange,"Tous logiciel de cheat ou logiciel ressemblant à de cheat sont interdit et seront bannis");
SendClientMessage(playerid,orange,"Pour les admins; tous abus de commandes envers un joueur où un supérieur seront punis séverement");
SendClientMessage(playerid,orange,"Et pour finir tout harcèlement envers les admins ou les joueurs sont interdits");
return 1;
}
if (strcmp("/credits", cmdtext, true) == 0)
{
SendClientMessage(playerid,bleu,"--------------------------Atlanta Crédits------------------------");
SendClientMessage(playerid,orange,"Le serveur a été entièrement hébergé,scripté par [KoD]Jhonny");
return 1;
}
if (strcmp("/cmds", cmdtext, true) == 0)
{
SendClientMessage(playerid,bleu,"-----------------------------Atlanta Commandes-----------------------");
SendClientMessage(playerid,orange,"/clear: Pour effacer le chat");
SendClientMessage(playerid,orange,"/kill: Pour se suicider");
SendClientMessage(playerid,orange,"/sawn: Pour avoir un sawn-off contre 15000$");
SendClientMessage(playerid,orange,"/molotov: Pour avoir un cocktail molotov contre 20000$");
SendClientMessage(playerid,orange,"/spawn: Pour aller à son spawn");
SendClientMessage(playerid,orange,"/gilet: Pour avoir un gilet contre 10000$");
SendClientMessage(playerid,orange,"/vie: Pour avoir de la vie contre 10000$");
SendClientMessage(playerid,orange,"/team: Pour changer de team");
return 1;
}
if (strcmp("/clear", cmdtext, true) == 0)
{
SendClientMessage(playerid,bleu," ");
SendClientMessage(playerid,bleu," ");
SendClientMessage(playerid,bleu," ");
SendClientMessage(playerid,bleu," ");
SendClientMessage(playerid,bleu," ");
SendClientMessage(playerid,bleu," ");
SendClientMessage(playerid,bleu," ");
SendClientMessage(playerid,bleu," ");
SendClientMessage(playerid,bleu," ");
SendClientMessage(playerid,bleu," ");
SendClientMessage(playerid,bleu," ");
SendClientMessage(playerid,bleu," ");
SendClientMessage(playerid,bleu," ");
SendClientMessage(playerid,bleu," ");
SendClientMessage(playerid,bleu," ");
SendClientMessage(playerid,bleu," ");
SendClientMessage(playerid,bleu," ");
SendClientMessage(playerid,bleu," ");
SendClientMessage(playerid,bleu," ");
SendClientMessage(playerid,bleu," ");
SendClientMessage(playerid,bleu," ");
SendClientMessage(playerid,bleu," ");
SendClientMessage(playerid,bleu," ");
SendClientMessage(playerid,bleu," ");
SendClientMessage(playerid,bleu," ");
SendClientMessage(playerid,bleu," ");
SendClientMessage(playerid,bleu," ");
SendClientMessage(playerid,bleu," ");
SendClientMessage(playerid,bleu," ");
SendClientMessage(playerid,jaune,"Vous avez effacé votre chat ");
return 1;
}
if (strcmp("/sawn", cmdtext, true) == 0)
{
GivePlayerWeapon(playerid,26,500);
GivePlayerMoney(playerid,-15000);
SendClientMessage(playerid,bleu,"Vous avez acheté un sawn-off pour 15000$");
return 1;
}
if (strcmp("/molotov", cmdtext, true) == 0)
{
GivePlayerWeapon(playerid,18,500);
GivePlayerMoney(playerid,-20000);
SendClientMessage(playerid,bleu,"Vous avez acheté un cocktail molotov pour 20000$");
return 1;
}
if (strcmp("/gilet", cmdtext, true) == 0)
{
SetPlayerArmour(playerid,100);
GivePlayerMoney(playerid,-10000);
SendClientMessage(playerid,bleu,"Vous avez acheté un gilet pour 10000$");
return 1;
}
if (strcmp("/vie", cmdtext, true) == 0)
{
SetPlayerHealth(playerid,100);
GivePlayerMoney(playerid,-10000);
SendClientMessage(playerid,bleu,"Vous vous êtes soigner pour 10000$");
return 1;
}
if (strcmp("/spawn", cmdtext, true) == 0)
{
SpawnPlayer(playerid);
SendClientMessage(playerid,bleu,"Vous avez respawn avec succès");
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
