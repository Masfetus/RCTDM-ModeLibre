#include <a_samp>
#define orange 0xFF8000FF
#define rouge 0xFF0000FF
#define vert 0x00FF00FF
new pickinfo;
new mission[MAX_PLAYERS];
forward TimerCondition(playerid);
forward GameOver(playerid);
forward AchievedMission(playerid);
forward StartMission(playerid);
#pragma tabsize 0

public OnGameModeInit()
{
pickinfo=CreatePickup(1274,2,-2650.2517,1358.4600,7.1857,0);
return 1;
}


public GameOver(playerid)
{
new pname[256];
new string[256];
GetPlayerName(playerid,pname,sizeof(pname));
DisablePlayerCheckpoint(playerid);
SendClientMessage(playerid,rouge,"[MISSION]Tu as râté ta mission, dommage pour toi!");
format(string,sizeof(string),"[MISSION]%s a râté sa mission, dommage pour lui!",pname);
SendClientMessageToAll(orange,string);
mission[playerid]=0;
SetPlayerPos(playerid,-2650.2517,1358.4600,7.1857);
}
public AchievedMission(playerid)
{
new pname[256];
new string[256];
GetPlayerName(playerid,pname,sizeof(string));
DisablePlayerCheckpoint(playerid);
GivePlayerMoney(playerid,500);
SendClientMessage(playerid,vert,"Bravo!!!Tu as réussi ta mission tu gagnes 50 points et 500$");
format(string,sizeof(string),"[MISSION]%s est parvenu(e) à sa mission il gagne 50 points et 500$",pname);
SendClientMessageToAll(orange,string);
mission[playerid]=0;
SetPlayerPos(playerid,-2650.2517,1358.4600,7.1857);
}
public StartMission(playerid)
{
new string[256];
new pname[256];
GetPlayerName(playerid,pname,sizeof(pname));
SetPlayerCheckpoint(playerid,-2658.8413,1538.9945,54.2146,5.0);
mission[playerid]=1;
SendClientMessage(playerid,vert,"[MISSION]Votre mission a commencé, atteignez le checkpoint!!");
format(string,sizeof(string),"[MISSION]%s a tenté le Saut en Hauteur va t-il réussir?",pname);
SendClientMessageToAll(orange,string);
SetPlayerPos(playerid,-2659.3442,1459.1012,49.6572);
SendClientMessage(playerid,rouge,"[RAPPEL]Attention si tu reviens en arrière ta mission sera considérée comme échouée!");
}


public TimerCondition(playerid)
{
new Float:x;
new Float:y;
new Float:z;
GetPlayerPos(playerid,x,y,z);
if(z<45 && mission[playerid]==1)
{
GameOver(playerid);
}
return 1;
}

public OnPlayerConnect(playerid)
{
SetPlayerMapIcon(playerid,1,-2650.2517,1358.4600,7.1857,56,0,0);
mission[playerid]=0;
	return 1;
}


public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/mission", cmdtext, true) == 0)
	{
	if(!IsPlayerInRangeOfPoint(playerid,5.0,-2650.2517,1358.4600,7.1857)) return SendClientMessage(playerid,rouge,"Vous n'êtes pas sur le pickup spécial pour pouvoir commencer une mission!");
	{
	if(mission[playerid]==1) return SendClientMessage(playerid,rouge,"Vous faites déjà cette mission!");
	{
	ShowPlayerDialog(playerid,1,DIALOG_STYLE_MSGBOX,"MISSION","Bienvenu(e) dans l'interface Mission.\nVous allez commencer une mission qui demande beaucoup d'agilité\nElle se nomme: Le Saut en Hauteur\nVous devrez sauter le plus loin possible afin de passer le Checkpoint et gagner la récompense\nUne fois le CheckPoint passé vous serez directement téléporté à la terre ferme\nSi vous réussisez à passer le CheckPoint vous gagnerez 50 Points et 500$\nBonne Chance!!!","COMMENCER","REFUSER");
	}
	}
		return 1;
	}
	return 0;
}

public OnPlayerEnterCheckpoint(playerid)
{
if(IsPlayerInRangeOfPoint(playerid,5.0,-2658.8413,1538.9945,54.2146))
{
AchievedMission(playerid);
}
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
if(pickupid==pickinfo)
{
GameTextForPlayer(playerid,"~g~ TAPEZ /MISSION POUR COMMENCER LA MISSION",5000,5);
}
return 1;
}


public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
if(dialogid==1)
{
if(response)
{
StartMission(playerid);
}
}
	return 1;
}
