/*
Include avec des trucs utiles dedans
*/

#if defined _jh_utils_included
	#endinput
#endif
#define _jh_utils_included
#pragma library jh_utils


// Natives

//native TimePassedSince(time);
//native GetName(playerid);
//native HidePassword(str[]);
//native KickEx(playerid, reason[], source = -1);
//native Hash256(mdp[], salt[]);

forward TimerKick(playerid);

public TimerKick(playerid)
{
	Kick(playerid);
	return 1;
}

stock HashSHA256(mdp[], salt[], storein[])
{
    for(new i = 0; i < 10; i++) salt[i] = random(79) + 10;
	salt[10] = 0;
	SHA256_PassHash(mdp, salt, storein, 65);
}
stock KickEx(playerid, reason[], source = -1)
{
	new str[144];
	format(str, sizeof(str), "{FF0000}%s {FFFFFF}a été kick par {FF0000}%s{FFFFFF} | {FF0000}Raison : %s", GetName(playerid), (source == -1 ? "le serveur" : GetName(source)), reason);
	SendClientMessageToAll(0, str);
	SetTimerEx("TimerKick", 100, "i", playerid);
}
stock TimePassedSince(time) return GetTickCount() - time;
stock GetName(playerid)
{
	new pname[MAX_PLAYER_NAME + 1];
	GetPlayerName(playerid, pname, sizeof(pname));
	return pname;
}
stock HidePassword(str[])
{
	new result[64];
	for(new i = 0; i < strlen(str); i++) strcat(result, "*");
	return result;
}
