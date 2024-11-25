#define FILE_CONNECT
//--------------- INCLUDES
#include <a_samp>
#include <jh_utils>
#include <a_mysql>
#include <regex>
//---------------- MACROS

// Dialogs
#define DIALOG_LOGIN 0
#define DIALOG_MDP 1
#define DIALOG_MAIL 2
#define DIALOG_SKIN 3

// Base de donnée
#define MYSQL_HOST "e78998-mysql.services.easyname.eu"
#define MYSQL_USER "u122282db1"
#define MYSQL_DB "u122282db1"
#define MYSQL_PASSWORD "sanandreasbr"
//---------------- CONSTANTES
#define SPAWN_DEFAULT 1958.3783, 1343.1572, 15.3746
#define SPAWN_JAIL 219.5876, 110.2150, 999.0156
//---------------- VARIABLES

// Données du joueur
enum Infos
{
	Mdp_hash[65],
	Salt[11],
	Mail[32],
	Id,
	Pseudo[MAX_PLAYER_NAME + 1],
	bool:Logged,
	bool:English,
	Admin,
	Skin,
	Jail
};
new PlayerInfo[MAX_PLAYERS][Infos];
new bool:TDConnection_Show[MAX_PLAYERS char];
new Text:TD_Connection[17] = {Text:INVALID_TEXT_DRAW,...};
new PlayerText:PTD_Connection[MAX_PLAYERS][4];
// Base de donnée
new mysql;

//---------------- FONCTIONS
// PRIVATES
stock ResetData(playerid)
{
	format(PlayerInfo[playerid][Mdp_hash], 128, "");
	format(PlayerInfo[playerid][Mail], 32, "");
	PlayerInfo[playerid][Id] = -1;
	format(PlayerInfo[playerid][Pseudo], MAX_PLAYER_NAME + 1, "");
	PlayerInfo[playerid][Logged] = false;
	format(PlayerInfo[playerid][Salt], 11, "");
	PlayerInfo[playerid][English] = false;
	TDConnection_Show{playerid} = false;
	for(new i = 0; i < 4; i++) PTD_Connection[playerid][i] = PlayerText:INVALID_TEXT_DRAW;
	PlayerInfo[playerid][Admin] = 1;
	PlayerInfo[playerid][Skin] = 0;
	PlayerInfo[playerid][Jail] = 0;
}
stock ShowTDConnection(playerid)
{
	for(new i = 0; i < sizeof(TD_Connection); i++) TextDrawShowForPlayer(playerid, TD_Connection[i]);
	for(new i = 0; i < 4; i++) PlayerTextDrawShow(playerid, PTD_Connection[playerid][i]);
	SelectTextDraw(playerid, ROUGE);
	TDConnection_Show{playerid} = true;
	TogglePlayerSpectating(playerid, true);
	return 1;
}
stock HideTDConnection(playerid)
{
	for(new i = 0; i < sizeof(TD_Connection); i++) TextDrawHideForPlayer(playerid, TD_Connection[i]);
	for(new i = 0; i < 4; i++) PlayerTextDrawHide(playerid, PTD_Connection[playerid][i]);
	CancelSelectTextDraw(playerid);
	TDConnection_Show{playerid} = false;
}
stock CreatePTDConnection(playerid)
{
	PTD_Connection[playerid][0] = CreatePlayerTextDraw(playerid, 230.029251, 158.583374, "MDP:");
	PlayerTextDrawLetterSize(playerid, PTD_Connection[playerid][0], 0.400000, 1.600000);
	PlayerTextDrawAlignment(playerid, PTD_Connection[playerid][0], 1);
	PlayerTextDrawColor(playerid, PTD_Connection[playerid][0], -1);
	PlayerTextDrawSetShadow(playerid, PTD_Connection[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, PTD_Connection[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, PTD_Connection[playerid][0], 255);
	PlayerTextDrawFont(playerid, PTD_Connection[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, PTD_Connection[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, PTD_Connection[playerid][0], 0);
	PlayerTextDrawSetSelectable(playerid, PTD_Connection[playerid][0], true);
	PlayerTextDrawTextSize(playerid, PTD_Connection[playerid][0], 400.0, 30.0);

	PTD_Connection[playerid][1] = CreatePlayerTextDraw(playerid, 230.029251, 206.886322, "MAIL:");
	PlayerTextDrawLetterSize(playerid, PTD_Connection[playerid][1], 0.400000, 1.600000);
	PlayerTextDrawAlignment(playerid, PTD_Connection[playerid][1], 1);
	PlayerTextDrawColor(playerid, PTD_Connection[playerid][1], -1);
	PlayerTextDrawSetShadow(playerid, PTD_Connection[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, PTD_Connection[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, PTD_Connection[playerid][1], 255);
	PlayerTextDrawFont(playerid, PTD_Connection[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, PTD_Connection[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, PTD_Connection[playerid][1], 0);
	PlayerTextDrawSetSelectable(playerid, PTD_Connection[playerid][1], true);
	PlayerTextDrawTextSize(playerid, PTD_Connection[playerid][1], 450.0, 30.0);

	PTD_Connection[playerid][2] = CreatePlayerTextDraw(playerid, 254.099472, 237.216033, "");
	PlayerTextDrawLetterSize(playerid, PTD_Connection[playerid][2], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, PTD_Connection[playerid][2], 137.000000, 144.000000);
	PlayerTextDrawAlignment(playerid, PTD_Connection[playerid][2], 1);
	PlayerTextDrawColor(playerid, PTD_Connection[playerid][2], -1);
	PlayerTextDrawSetShadow(playerid, PTD_Connection[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, PTD_Connection[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, PTD_Connection[playerid][2], 0);
	PlayerTextDrawFont(playerid, PTD_Connection[playerid][2], 5);
	PlayerTextDrawSetProportional(playerid, PTD_Connection[playerid][2], 0);
	PlayerTextDrawSetShadow(playerid, PTD_Connection[playerid][2], 0);
	PlayerTextDrawSetPreviewModel(playerid, PTD_Connection[playerid][2], 0);
	PlayerTextDrawSetPreviewRot(playerid, PTD_Connection[playerid][2], 0.000000, 0.000000, 0.000000, 1.000000);
	PlayerTextDrawSetSelectable(playerid, PTD_Connection[playerid][2], true);

	PTD_Connection[playerid][3] = CreatePlayerTextDraw(playerid, 526.496215, 63.432914, "LANGUE : FR");
	PlayerTextDrawLetterSize(playerid, PTD_Connection[playerid][3], 0.449663, 2.095834);
	PlayerTextDrawAlignment(playerid, PTD_Connection[playerid][3], 1);
	PlayerTextDrawColor(playerid, PTD_Connection[playerid][3], -1);
	PlayerTextDrawSetShadow(playerid, PTD_Connection[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, PTD_Connection[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, PTD_Connection[playerid][3], 255);
	PlayerTextDrawFont(playerid, PTD_Connection[playerid][3], 1);
	PlayerTextDrawSetProportional(playerid, PTD_Connection[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, PTD_Connection[playerid][3], 0);

}
stock CreateTDConnection()
{
	TD_Connection[0] = TextDrawCreate(-12.664695, -1.916664, "box");
	TextDrawLetterSize(TD_Connection[0], 0.000000, 49.824283);
	TextDrawTextSize(TD_Connection[0], 655.000000, 0.000000);
	TextDrawAlignment(TD_Connection[0], 1);
	TextDrawColor(TD_Connection[0], -1);
	TextDrawUseBox(TD_Connection[0], 1);
	TextDrawBoxColor(TD_Connection[0], 83);
	TextDrawSetShadow(TD_Connection[0], 0);
	TextDrawSetOutline(TD_Connection[0], 0);
	TextDrawBackgroundColor(TD_Connection[0], 255);
	TextDrawFont(TD_Connection[0], 1);
	TextDrawSetProportional(TD_Connection[0], 0);
	TextDrawSetShadow(TD_Connection[0], 0);

	TD_Connection[1] = TextDrawCreate(504.113464, 12.083359, "box");
	TextDrawLetterSize(TD_Connection[1], 0.000000, 3.440704);
	TextDrawTextSize(TD_Connection[1], 630.000000, 0.000000);
	TextDrawAlignment(TD_Connection[1], 1);
	TextDrawColor(TD_Connection[1], -1);
	TextDrawUseBox(TD_Connection[1], 1);
	TextDrawBoxColor(TD_Connection[1], 255);
	TextDrawSetShadow(TD_Connection[1], 0);
	TextDrawSetOutline(TD_Connection[1], 0);
	TextDrawBackgroundColor(TD_Connection[1], 255);
	TextDrawFont(TD_Connection[1], 1);
	TextDrawSetProportional(TD_Connection[1], 1);
	TextDrawSetShadow(TD_Connection[1], 0);

	TD_Connection[2] = TextDrawCreate(508.799560, 17.333337, "ALPHA_VERSION");
	TextDrawLetterSize(TD_Connection[2], 0.449663, 2.095834);
	TextDrawAlignment(TD_Connection[2], 1);
	TextDrawColor(TD_Connection[2], -1);
	TextDrawSetShadow(TD_Connection[2], 0);
	TextDrawSetOutline(TD_Connection[2], 0);
	TextDrawBackgroundColor(TD_Connection[2], 255);
	TextDrawFont(TD_Connection[2], 1);
	TextDrawSetProportional(TD_Connection[2], 1);
	TextDrawSetShadow(TD_Connection[2], 0);

	TD_Connection[3] = TextDrawCreate(245.021820, 59.333324, "S");
	TextDrawLetterSize(TD_Connection[3], 1.400758, 7.036664);
	TextDrawAlignment(TD_Connection[3], 1);
	TextDrawColor(TD_Connection[3], 255);
	TextDrawSetShadow(TD_Connection[3], 0);
	TextDrawSetOutline(TD_Connection[3], 0);
	TextDrawBackgroundColor(TD_Connection[3], 255);
	TextDrawFont(TD_Connection[3], 1);
	TextDrawSetProportional(TD_Connection[3], 1);
	TextDrawSetShadow(TD_Connection[3], 0);

	TD_Connection[4] = TextDrawCreate(272.812652, 67.500000, "AN");
	TextDrawLetterSize(TD_Connection[4], 0.682048, 2.912498);
	TextDrawAlignment(TD_Connection[4], 1);
	TextDrawColor(TD_Connection[4], 255);
	TextDrawSetShadow(TD_Connection[4], 0);
	TextDrawSetOutline(TD_Connection[4], 0);
	TextDrawBackgroundColor(TD_Connection[4], 255);
	TextDrawFont(TD_Connection[4], 1);
	TextDrawSetProportional(TD_Connection[4], 1);
	TextDrawSetShadow(TD_Connection[4], 0);

	TD_Connection[5] = TextDrawCreate(271.875549, 86.749961, "ANDREAS");
	TextDrawLetterSize(TD_Connection[5], 0.720466, 3.390834);
	TextDrawAlignment(TD_Connection[5], 1);
	TextDrawColor(TD_Connection[5], 255);
	TextDrawSetShadow(TD_Connection[5], 0);
	TextDrawSetOutline(TD_Connection[5], 0);
	TextDrawBackgroundColor(TD_Connection[5], 255);
	TextDrawFont(TD_Connection[5], 1);
	TextDrawSetProportional(TD_Connection[5], 1);
	TextDrawSetShadow(TD_Connection[5], 0);

	TD_Connection[6] = TextDrawCreate(298.433319, 114.166687, "BATTLE_ROYALE");
	TextDrawLetterSize(TD_Connection[6], 0.403279, 1.699167);
	TextDrawAlignment(TD_Connection[6], 1);
	TextDrawColor(TD_Connection[6], 255);
	TextDrawSetShadow(TD_Connection[6], 0);
	TextDrawSetOutline(TD_Connection[6], 0);
	TextDrawBackgroundColor(TD_Connection[6], 255);
	TextDrawFont(TD_Connection[6], 1);
	TextDrawSetProportional(TD_Connection[6], 1);
	TextDrawSetShadow(TD_Connection[6], 0);

	TD_Connection[7] = TextDrawCreate(226.281097, 151.800048, "box");
	TextDrawLetterSize(TD_Connection[7], 0.000000, 3.112736);
	TextDrawTextSize(TD_Connection[7], 420.000000, 0.000000);
	TextDrawAlignment(TD_Connection[7], 1);
	TextDrawColor(TD_Connection[7], -1);
	TextDrawUseBox(TD_Connection[7], 1);
	TextDrawBoxColor(TD_Connection[7], 255);
	TextDrawSetShadow(TD_Connection[7], 0);
	TextDrawSetOutline(TD_Connection[7], 0);
	TextDrawBackgroundColor(TD_Connection[7], 255);
	TextDrawFont(TD_Connection[7], 1);
	TextDrawSetProportional(TD_Connection[7], 1);
	TextDrawSetShadow(TD_Connection[7], 0);
	TextDrawSetSelectable(TD_Connection[7], true);

	TD_Connection[8] = TextDrawCreate(223.469970, 148.583389, "box");
	TextDrawLetterSize(TD_Connection[8], 0.000000, 3.815519);
	TextDrawTextSize(TD_Connection[8], 423.459472, 0.000000);
	TextDrawAlignment(TD_Connection[8], 1);
	TextDrawColor(TD_Connection[8], -1);
	TextDrawUseBox(TD_Connection[8], 1);
	TextDrawBoxColor(TD_Connection[8], 86);
	TextDrawSetShadow(TD_Connection[8], 0);
	TextDrawSetOutline(TD_Connection[8], 0);
	TextDrawBackgroundColor(TD_Connection[8], 255);
	TextDrawFont(TD_Connection[8], 1);
	TextDrawSetProportional(TD_Connection[8], 1);
	TextDrawSetShadow(TD_Connection[8], 0);
	TextDrawSetSelectable(TD_Connection[8], true);

	TD_Connection[9] = TextDrawCreate(226.281097, 200.403015, "box");
	TextDrawLetterSize(TD_Connection[9], 0.000000, 3.112736);
	TextDrawTextSize(TD_Connection[9], 420.000000, 0.000000);
	TextDrawAlignment(TD_Connection[9], 1);
	TextDrawColor(TD_Connection[9], -1);
	TextDrawUseBox(TD_Connection[9], 1);
	TextDrawBoxColor(TD_Connection[9], 255);
	TextDrawSetShadow(TD_Connection[9], 0);
	TextDrawSetOutline(TD_Connection[9], 0);
	TextDrawBackgroundColor(TD_Connection[9], 255);
	TextDrawFont(TD_Connection[9], 1);
	TextDrawSetProportional(TD_Connection[9], 1);
	TextDrawSetShadow(TD_Connection[9], 0);

	TD_Connection[10] = TextDrawCreate(223.469970, 197.086349, "box");
	TextDrawLetterSize(TD_Connection[10], 0.000000, 3.815519);
	TextDrawTextSize(TD_Connection[10], 423.459472, 0.000000);
	TextDrawAlignment(TD_Connection[10], 1);
	TextDrawColor(TD_Connection[10], -1);
	TextDrawUseBox(TD_Connection[10], 1);
	TextDrawBoxColor(TD_Connection[10], 86);
	TextDrawSetShadow(TD_Connection[10], 0);
	TextDrawSetOutline(TD_Connection[10], 0);
	TextDrawBackgroundColor(TD_Connection[10], 255);
	TextDrawFont(TD_Connection[10], 1);
	TextDrawSetProportional(TD_Connection[10], 1);
	TextDrawSetShadow(TD_Connection[10], 0);
	TextDrawSetSelectable(TD_Connection[10], true);

	TD_Connection[11] = TextDrawCreate(226.281097, 245.405761, "box");
	TextDrawLetterSize(TD_Connection[11], 0.000000, 15.414422);
	TextDrawTextSize(TD_Connection[11], 420.000000, 0.000000);
	TextDrawAlignment(TD_Connection[11], 1);
	TextDrawColor(TD_Connection[11], -1);
	TextDrawUseBox(TD_Connection[11], 1);
	TextDrawBoxColor(TD_Connection[11], 255);
	TextDrawSetShadow(TD_Connection[11], 0);
	TextDrawSetOutline(TD_Connection[11], 0);
	TextDrawBackgroundColor(TD_Connection[11], 255);
	TextDrawFont(TD_Connection[11], 1);
	TextDrawSetProportional(TD_Connection[11], 1);
	TextDrawSetShadow(TD_Connection[11], 0);

	TD_Connection[12] = TextDrawCreate(223.180908, 241.222213, "box");
	TextDrawLetterSize(TD_Connection[12], 0.000000, 16.257761);
	TextDrawTextSize(TD_Connection[12], 423.389404, 0.000000);
	TextDrawAlignment(TD_Connection[12], 1);
	TextDrawColor(TD_Connection[12], -1);
	TextDrawUseBox(TD_Connection[12], 1);
	TextDrawBoxColor(TD_Connection[12], 128);
	TextDrawSetShadow(TD_Connection[12], 0);
	TextDrawSetOutline(TD_Connection[12], 0);
	TextDrawBackgroundColor(TD_Connection[12], 255);
	TextDrawFont(TD_Connection[12], 1);
	TextDrawSetProportional(TD_Connection[12], 1);
	TextDrawSetShadow(TD_Connection[12], 0);
	TextDrawSetSelectable(TD_Connection[12], true);

	TD_Connection[13] = TextDrawCreate(343.880065, 394.166900, "TERMINER");
	TextDrawLetterSize(TD_Connection[13], 0.400000, 1.600000);
	TextDrawAlignment(TD_Connection[13], 1);
	TextDrawColor(TD_Connection[13], -1);
	TextDrawSetShadow(TD_Connection[13], 0);
	TextDrawSetOutline(TD_Connection[13], 0);
	TextDrawBackgroundColor(TD_Connection[13], 255);
	TextDrawFont(TD_Connection[13], 1);
	TextDrawSetProportional(TD_Connection[13], 1);
	TextDrawSetShadow(TD_Connection[13], 0);
	TextDrawSetSelectable(TD_Connection[13], true);
	TextDrawTextSize(TD_Connection[13], 450.0, 20.0);

	TD_Connection[14] = TextDrawCreate(368.000000, 292.718444, "");
	TextDrawLetterSize(TD_Connection[14], 0.000000, 0.000000);
	TextDrawTextSize(TD_Connection[14], 40.000000, 38.000000);
	TextDrawAlignment(TD_Connection[14], 1);
	TextDrawColor(TD_Connection[14], -1);
	TextDrawSetShadow(TD_Connection[14], 0);
	TextDrawSetOutline(TD_Connection[14], 0);
	TextDrawBackgroundColor(TD_Connection[14], 255);
	TextDrawFont(TD_Connection[14], 5);
	TextDrawSetProportional(TD_Connection[14], 0);
	TextDrawSetShadow(TD_Connection[14], 0);
	TextDrawSetPreviewModel(TD_Connection[14], 1318);
	TextDrawSetPreviewRot(TD_Connection[14], 90.000000, 78.000000, 0.000000, 1.000000);
	TextDrawSetSelectable(TD_Connection[14], true);

	TD_Connection[15] = TextDrawCreate(241.000045, 291.888824, "");
	TextDrawLetterSize(TD_Connection[15], 0.000000, 0.000000);
	TextDrawTextSize(TD_Connection[15], 40.000000, 38.000000);
	TextDrawAlignment(TD_Connection[15], 1);
	TextDrawColor(TD_Connection[15], -1);
	TextDrawSetShadow(TD_Connection[15], 0);
	TextDrawSetOutline(TD_Connection[15], 0);
	TextDrawBackgroundColor(TD_Connection[15], 255);
	TextDrawFont(TD_Connection[15], 5);
	TextDrawSetProportional(TD_Connection[15], 0);
	TextDrawSetShadow(TD_Connection[15], 0);
	TextDrawSetPreviewModel(TD_Connection[15], 1318);
	TextDrawSetPreviewRot(TD_Connection[15], 90.000000, 265.000000, 0.000000, 0.969760);
	TextDrawSetSelectable(TD_Connection[15], true);

	TD_Connection[16] = TextDrawCreate(503.113464, 58.927490, "box");
	TextDrawLetterSize(TD_Connection[16], 0.000000, 3.440704);
	TextDrawTextSize(TD_Connection[16], 629.000000, 0.000000);
	TextDrawAlignment(TD_Connection[16], 1);
	TextDrawColor(TD_Connection[16], -1);
	TextDrawUseBox(TD_Connection[16], 1);
	TextDrawBoxColor(TD_Connection[16], 255);
	TextDrawSetShadow(TD_Connection[16], 0);
	TextDrawSetOutline(TD_Connection[16], 0);
	TextDrawBackgroundColor(TD_Connection[16], 255);
	TextDrawFont(TD_Connection[16], 1);
	TextDrawSetProportional(TD_Connection[16], 1);
	TextDrawSetShadow(TD_Connection[16], 0);
}
// COMMANDES
/*YCMD:show(playerid, params[], help)
{
	#pragma unused params, help
	if(TDConnection_Show{playerid}) HideTDConnection(playerid);
	else ShowTDConnection(playerid);
	return 1;
}
YCMD:textsize(playerid, params[], help)
{
	new TD = -1, Float:X = 0.0, Float:Y = 0.0;
	if(sscanf(params, "iff", TD, X, Y)) return SendClientMessage(playerid, ROUGE, "/textsize [ID] [X] [Y]");

	if(TD < 0) return SendClientMessage(playerid, ROUGE, "Non !");
	if(TD == 4) TextDrawTextSize(TD_Connection[13], X, Y);
	PlayerTextDrawTextSize(playerid, PTD_Connection[playerid][TD], X, Y);
	SendClientMessage(playerid, ROUGE, "Changé avec succès !");
	return 1;
}*/
// PUBLICS
forward SetPlayerJail(playerid, timejail);
forward GetPlayerJailTime(playerid);
forward bool:IsPlayerJailed(playerid);
forward GetPlayerAdminLevel(playerid);
forward bool:IsPlayerLogged(playerid);
forward CheckName(playerid);
forward CheckMdp(playerid, mdp[]);
forward SaveUser(playerid);
forward LoadData(playerid);

public GetPlayerJailTime(playerid) return PlayerInfo[playerid][Jail];

public SetPlayerJail(playerid, timejail)
{
	if(timejail > 0)
	{
	    if(GetPlayerJailTime(playerid) <= 0)
	    {
		    SetPlayerPos(playerid, SPAWN_JAIL);
			SetPlayerInterior(playerid, 10);
			ResetPlayerWeapons(playerid);
		}
	}
	else SpawnPlayer(playerid);
	PlayerInfo[playerid][Jail] = timejail;
	return 1;
}

public bool:IsPlayerJailed(playerid) return (PlayerInfo[playerid][Jail] > 0);
public GetPlayerAdminLevel(playerid) return PlayerInfo[playerid][Admin];
public bool:IsPlayerLogged(playerid) return PlayerInfo[playerid][Logged];

public LoadData(playerid)
{
	PlayerInfo[playerid][Id] = cache_get_field_content_int(0, "ID");
	cache_get_field_content(0, "Pseudo", PlayerInfo[playerid][Pseudo]);
	cache_get_field_content(0, "MotDePasse", PlayerInfo[playerid][Mdp_hash]);
	cache_get_field_content(0, "Salt", PlayerInfo[playerid][Salt]);
	cache_get_field_content(0, "Mail", PlayerInfo[playerid][Mail]);
	PlayerInfo[playerid][English] = !!cache_get_field_content_int(0, "Langue");
	SendClientMessage(playerid, 0, "{00FF00}Connecté avec succès !");
	PlayerInfo[playerid][Logged] = true;
	PlayerInfo[playerid][Admin] = cache_get_field_content_int(0, "Admin");
	PlayerInfo[playerid][Skin] = cache_get_field_content_int(0, "Skin");
	SetSpawnInfo(playerid, 0, PlayerInfo[playerid][Skin], SPAWN_DEFAULT, 270.0, 0, 0, 0, 0, 0, 0);
	PlayerInfo[playerid][Jail] = cache_get_field_content_int(0, "Jail");
	SpawnPlayer(playerid);
	return 1;
}
public SaveUser(playerid)
{
	if(PlayerInfo[playerid][Logged])
	{
	    new request[256];
	    mysql_format(mysql, request, sizeof(request), "\
		UPDATE `joueurs` SET \
			Pseudo = '%s', \
			MotDePasse = '%s', \
			Salt = '%s', \
			Mail = '%s', \
			Langue = '%b', \
			Admin = '%i', \
			Skin = '%i', \
			Jail = '%b'",
		PlayerInfo[playerid][Pseudo],
		PlayerInfo[playerid][Mdp_hash],
		PlayerInfo[playerid][Salt],
		PlayerInfo[playerid][Mail],
		PlayerInfo[playerid][English],
		PlayerInfo[playerid][Admin],
		PlayerInfo[playerid][Skin],
		PlayerInfo[playerid][Jail]);
		mysql_tquery(mysql, request);
	}
	return 1;
}
public CheckMdp(playerid, mdp[])
{
	new result[2][65], salt[11], request[256];
	
	cache_get_field_content(0, "MotDePasse", result[0]);
	cache_get_field_content(0, "Salt", salt);
	SHA256_PassHash(mdp, salt, result[1], 65);
	if(!strcmp(result[1], result[0]))
	{
 		mysql_format(mysql, request, sizeof(request), "SELECT * FROM `joueurs` WHERE `Pseudo` = '%s'", GetName(playerid));
   		mysql_tquery(mysql, request, "LoadData", "i", playerid);
	}
	else return ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD,"Connexion", "{FF0000}Mot de passe incorrect !\n{FFFFFF}Entrez ci-dessous votre mot de passe :", "Entrer", "Quitter");
	return 1;
}
public CheckName(playerid)
{
	if(cache_get_row_count()) return ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD,"Connexion", "{00FF00}Votre compte a été détecté !\n{FFFFFF}Entrez ci-dessous votre mot de passe :", "Entrer", "Quitter");
	else return ShowTDConnection(playerid);
}
//----------------- CALLBACKS
public OnFilterScriptInit()
{
	new request[512];
	new count = GetTickCount();
	mysql_log(LOG_ALL);
	mysql = mysql_connect(MYSQL_HOST, MYSQL_USER, MYSQL_DB, MYSQL_PASSWORD);
	if(mysql_errno() != 0) return printf("[DATABASE] La connexion à la BDD a échoué !");
	mysql_format(mysql, request, sizeof(request), "CREATE TABLE IF NOT EXISTS `joueurs` (\
	  	`ID` int(11) NOT NULL AUTO_INCREMENT, \
	 	`Pseudo` varchar(24) NOT NULL, \
	  	`MotDePasse` varchar(65) NOT NULL, \
	  	`Mail` varchar(32) NOT NULL, \
	  	`Salt` varchar(11) NOT NULL, \
	  	`Langue` tinyint(1) NOT NULL, \
	  	`Admin` int(3) NOT NULL, \
	  	`Skin` int(11) NOT NULL, \
	  	`Jail` tinyint(1) NOT NULL, \
	  	PRIMARY KEY (`ID`))");
	  	
	mysql_tquery(mysql, request);
	

	for(new i = 0; i < MAX_PLAYERS; i++) if(!IsPlayerConnected(i)) ResetData(i);

	//---------------------------[ TD Connexion ]-----------------------------------------//
	CreateTDConnection();

	print("\n--------------------------------------");
	printf(" Système de connexion - SABR (chargé en %d ms)", TimePassedSince(count));
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	mysql_close(mysql);
	return 1;
}


public OnPlayerConnect(playerid)
{
	if(!IsPlayerNPC(playerid) && !PlayerInfo[playerid][Logged])
	{
		new string[128];
		mysql_format(mysql, string, sizeof(string), "SELECT * FROM `joueurs` WHERE `Pseudo` = '%s' LIMIT 1", GetName(playerid));
		mysql_tquery(mysql, string, "CheckName", "i", playerid);
		CreatePTDConnection(playerid);
	}
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	SaveUser(playerid);
	ResetData(playerid);
	return 1;
}

public OnPlayerSpawn(playerid)
{
	if(IsPlayerJailed(playerid)) SetPlayerJail(playerid, true);
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
public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
    if(_:clickedid == INVALID_TEXT_DRAW && TDConnection_Show{playerid}) return SelectTextDraw(playerid, ROUGE);
	if(clickedid == TD_Connection[13])
	{
	    if(!strlen(PlayerInfo[playerid][Mdp_hash]) || !strlen(PlayerInfo[playerid][Mail])) return SendClientMessage(playerid, ROUGE, "Un des champs n'est pas rempli !");
	    new request[512], str_date[32], time[2][3];
		gettime(time[0][0], time[0][1], time[0][2]);
		getdate(time[1][0], time[1][1], time[1][2]);
		format(str_date, sizeof(str_date), "%04d-%02d-%02d %02d:%02d:%02d", time[1][0], time[1][1], time[1][2], time[0][0], time[0][1], time[0][2]);
	    format(PlayerInfo[playerid][Pseudo], MAX_PLAYER_NAME + 1, "%s", GetName(playerid));
		mysql_format(mysql, request, sizeof(request),"INSERT INTO `joueurs` (Pseudo, MotDePasse, Salt, Mail, Langue, Admin, Skin, Jail, Date_Register) VALUES('%s', '%s', '%s', '%s', '%b', '%i', '%i', '%b', '%s')",
			PlayerInfo[playerid][Pseudo],
			PlayerInfo[playerid][Mdp_hash],
			PlayerInfo[playerid][Salt],
			PlayerInfo[playerid][Mail],
		 	PlayerInfo[playerid][English],
			PlayerInfo[playerid][Admin],
			PlayerInfo[playerid][Skin],
			PlayerInfo[playerid][Jail],
			str_date);
		mysql_tquery(mysql, request);
		SendClientMessage(playerid, 0, "{00FF00}Inscription réussie avec succès !");
		PlayerInfo[playerid][Logged] = true;
		SetSpawnInfo(playerid, 0, PlayerInfo[playerid][Skin], SPAWN_DEFAULT, 270.0, 0, 0, 0, 0, 0, 0);
		SpawnPlayer(playerid);
		HideTDConnection(playerid);
		TogglePlayerSpectating(playerid, false);
	    return 1;
	}
	if(clickedid == TD_Connection[15]) // Gauche
	{
	    PlayerInfo[playerid][Skin] --;
	    if(PlayerInfo[playerid][Skin] < 0) PlayerInfo[playerid][Skin] = 311;
		PlayerTextDrawSetPreviewModel(playerid, PTD_Connection[playerid][2], PlayerInfo[playerid][Skin]);
		UpdatePTD(playerid, PTD_Connection[playerid][2]);
		return 1;
	}
	if(clickedid == TD_Connection[14]) // Droite
	{
	    PlayerInfo[playerid][Skin] ++;
	    if(PlayerInfo[playerid][Skin] > 311) PlayerInfo[playerid][Skin] = 0;
		PlayerTextDrawSetPreviewModel(playerid, PTD_Connection[playerid][2], PlayerInfo[playerid][Skin]);
		UpdatePTD(playerid, PTD_Connection[playerid][2]);
		return 1;
	}
    return 0;
}
public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
    if(playertextid == PTD_Connection[playerid][0]) return ShowPlayerDialog(playerid, DIALOG_MDP, DIALOG_STYLE_PASSWORD,"Mot de passe", "{FFFFFF}Mot de passe :", "Entrer", "Quitter");
	if(playertextid == PTD_Connection[playerid][1]) return ShowPlayerDialog(playerid, DIALOG_MAIL, DIALOG_STYLE_INPUT,"E-mail", "{FFFFFF}Adresse mail :", "Entrer", "Quitter");
	if(playertextid == PTD_Connection[playerid][2]) return ShowPlayerDialog(playerid, DIALOG_SKIN, DIALOG_STYLE_INPUT,"Skin", "{FFFFFF}ID Skin :", "Entrer","Quitter");
	return 0;
}
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	new request[256];
	switch(dialogid)
	{
		case DIALOG_MAIL:
		{
		    if(response)
		    {
			    if(!strlen(inputtext) || strlen(inputtext) > 64 || !regex_match(inputtext, "[a-zA-Z0-9_\\.]+@([a-zA-Z0-9\\-]+\\.)+[a-zA-Z]{2,4}")) return SendClientMessage(playerid, ROUGE, "Adresse mail invalide");
			    
				format(PlayerInfo[playerid][Mail], 64, "%s", inputtext);
				format(request, sizeof(request), "MAIL: %s", inputtext);
				request[strfind(request, "@")] = '&';
				convert_encoding(request);
				PlayerTextDrawSetString(playerid, PTD_Connection[playerid][1], request);
				UpdatePTD(playerid, PTD_Connection[playerid][1]);
			}
		}
		case DIALOG_MDP:
		{
		    if(response)
		    {
			    if(!strlen(inputtext)) return  SendClientMessage(playerid, ROUGE, "Veuillez entrer un mot de passe !");
				
    			for(new i = 0; i < 10; i++) PlayerInfo[playerid][Salt][i] = random(79) + 47;
				PlayerInfo[playerid][Salt][10] = 0;
				SHA256_PassHash(inputtext, PlayerInfo[playerid][Salt], PlayerInfo[playerid][Mdp_hash], 65);
				format(request, sizeof(request), "MDP: %s", HidePassword(inputtext));
				convert_encoding(request);
				PlayerTextDrawSetString(playerid, PTD_Connection[playerid][0], request);
				UpdatePTD(playerid, PTD_Connection[playerid][0]);
			}
	    }
	    case DIALOG_LOGIN:
		{
		    if(!response) Kick(playerid);
		    
		    mysql_format(mysql, request, sizeof(request), "SELECT `MotDePasse`, `Salt` FROM `joueurs` WHERE `Pseudo` = '%s'", GetName(playerid));
		    mysql_tquery(mysql, request, "CheckMdp", "is", playerid, inputtext);
		}
		case DIALOG_SKIN:
		{
		    if(response)
		    {
		        new skin = strval(inputtext);
		        if(!( 0 <= skin <= 311)) return SendClientMessage(playerid, ROUGE, "Skin invalide !");
		        
		        PlayerInfo[playerid][Skin] = skin;
		        PlayerTextDrawSetPreviewModel(playerid, PTD_Connection[playerid][2], skin);
		        UpdatePTD(playerid, PTD_Connection[playerid][2]);
		    }
		}
	}
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}
