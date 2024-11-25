/*
Include avec des trucs utiles dedans
*/

#if defined _jh_utils_included
	#endinput
#endif
#define _jh_utils_included
#pragma library jh_utils

#include <YSI\y_commands>
#include <YSI\y_master>
#include <sscanf2>

#undef MAX_PLAYERS
#define MAX_PLAYERS 100

#define ROUGE 0xFF0000FF

#if !defined FILE_CONNECT
	#define IsPlayerLogIn(%0) CallRemoteFunction("IsPlayerLogged", "i", %0)
	#define GetAdminLevel(%0) CallRemoteFunction("GetPlayerAdminLevel", "i", %0)
	#define GetPlayerJailTime(%0) CallRemoteFunction("GetPlayerJailTime", "i", %0)
	#define SetPlayerJail(%0,%1) CallRemoteFunction("SetPlayerJail","ii",%0,%1)
	#define IsPlayerJailed(%0) (GetPlayerJailTime(%0) > 0)

	#define IsPlayerModerator(%0) (GetAdminLevel(%0) >= 2)
	#define IsPlayerAdmin(%0) (GetAdminLevel(%0) >= 3)
	#define IsPlayerOwner(%0) (GetAdminLevel(%0) >= 4)
#endif

#define TimeReboot GetSVarInt("g_Reboot")

// Natives

//native TimePassedSince(time);
//native GetName(playerid);
//native HidePassword(str[]);
//native KickEx(playerid, reason[], source = -1);
//native Hash256(mdp[], salt[]);
//native UpdatePTD(playerid, PlayerText: PTD);
//native convert_encoding(string[]);

forward TimerKick(playerid);

public TimerKick(playerid)
{
	Kick(playerid);
	return 1;
}
stock SendAdminMessage(color, const msg[], rank = 2) for(new i = 0; i <= GetPlayerPoolSize(); i++) if(IsPlayerConnected(i) && GetAdminLevel(i) >= rank) SendClientMessage(i, color, msg);

stock UpdatePTD(playerid, PlayerText: PTD)
{
	PlayerTextDrawHide(playerid, PTD);
	PlayerTextDrawShow(playerid, PTD);
}
stock convert_encoding(string[])
{
	static const
		scRealChars[256] =
		{
			  0,   1,   2,   3,   4,   5,   6,   7,   8,   9,  10,  11,  12,  13,  14,  15,
			 16,  17,  18,  19,  20,  21,  22,  23,  24,  25,  26,  27,  28,  29,  30,  31,
			 32,  33,  34,  35,  36,  37,  38,  39,  40,  41,  42,  43,  44,  45,  46,  47,
			 48,  49,  50,  51,  52,  53,  54,  55,  56,  57,  58,  59,  60,  61,  62,  63,
			 64,  65,  66,  67,  68,  69,  70,  71,  72,  73,  74,  75,  76,  77,  78,  79,
			 80,  81,  82,  83,  84,  85,  86,  87,  88,  89,  90,  91,  92,  93,  94,  95,
			 96,  97,  98,  99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111,
			112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127,
			128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143,
			144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159,
			160,  94, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175,
			124, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 175,
			128, 129, 130, 195, 131, 197, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141,
			208, 173, 142, 143, 144, 213, 145, 215, 216, 146, 147, 148, 149, 221, 222, 150,
			151, 152, 153, 227, 154, 229, 155, 156, 157, 158, 159, 160, 161, 162, 163, 164,
			240, 174, 165, 166, 167, 245, 168, 247, 248, 169, 170, 171, 172, 253, 254, 255
		};
	if (ispacked(string))
	{
		for (new i = 0, len = strlen(string); i != len; ++i)
		{
			string{i} = scRealChars[string{i}];
		}
	}
	else
	{
		for (new i = 0, len = strlen(string), ch; i != len; ++i)
		{
			if (0 <= (ch = string[i]) < 256)
			{
				string[i] = scRealChars[ch];
			}
		}
	}
}
stock HashSHA256(const mdp[], const salt[], storein[])
{
    for(new i = 0; i < 10; i++) salt[i] = random(79) + 10;
	salt[10] = 0;
	SHA256_PassHash(mdp, salt, storein, 65);
}
stock KickEx(playerid, const reason[], source = -1)
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
stock HidePassword(const str[])
{
	new result[64];
	for(new i = 0; i < strlen(str); i++) strcat(result, "*");
	return result;
}
