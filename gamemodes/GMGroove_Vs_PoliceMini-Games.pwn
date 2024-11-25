// Les Include
#include <a_samp>

// Les Defines
#define COULEUR_POLICE 0x33CCFFAA // Couleur Bleu
#define COULEUR_VERT 0x33AA33AA // Couleur Verte
#define COULEUR_JAUNE 0xDABB3EAA // Couleur Jaune
#define COULEUR_ROUGE 0xFF6347AA // Couleur Rouge

// Les Equipes
#define Groove 0 // Equipe 0
#define Police 1 // Equipe 1

// Les Menu
#define AIDE 0  // Menu ID 0

// Variable qui permet de retenir les informations global d'un Joueur
static gTeam[MAX_PLAYERS];

// Enumerateur
enum Info
{
	Membre
};
new InfoJoueur[MAX_PLAYERS][Info];  // On retient les information du joueur

// Véhicule NSA
forward NSA(vehicleid); // CallBack pour le camion de la NSA

// Radios
forward SendGMessage(color, string[]); // Radio pour les Grooves
forward SendPMessage(color, string[]); // Radio pour la Police

// Timers
new Restartimer;
forward Restart();
new Temptimer;
forward Temps();
new fintimer;
forward Fin();

main()
{
	print("\n----------------------------------");
	print(" Groove VS Police By D0os-Nox (( V.1.2+ )) "); // Credits
	print("----------------------------------\n");
}

public OnGameModeInit()
{
	SetGameModeText("GrooveVSPolice"); // Nom du Mode ( Colonne Mode Sur SA-MP )
	
	// Skins
	AddPlayerClass(107, 2526.5298,-1667.5500,15.1688,91.2498, 26, 200, 24, 250, 4, 1); // ID 1 Groove
	
	AddPlayerClass(280,1552.2850,-1675.5742,16.1953,180.4600, 26, 200, 24, 250, 4, 1); // ID 2 Police
	
	// Véhicules Grooves
	AddStaticVehicleEx(567,2498.7996,-1683.8821,13.2685,101.7797,252,252, 900000); //
	AddStaticVehicleEx(560,2443.4092,-1648.9498,13.1595,179.7604,252,252, 900000); //
	AddStaticVehicleEx(566,2515.9763,-1672.0355,13.6154,58.5126,252,252, 900000); //
	AddStaticVehicleEx(461,2498.8286,-1653.1884,13.0255,80.2516,252,252, 900000); //
	AddStaticVehicleEx(411,2505.5750,-1690.0313,13.2835,0.7536,252,252, 900000); //
	AddStaticVehicleEx(542,2473.5295,-1691.6973,13.2579,358.2473,252,252, 900000); //
	AddStaticVehicleEx(487,2430.2478,-1671.3154,13.7695,359.5641,252,252, 900000); //
	
	// Véhicules Police
	AddStaticVehicleEx(497,1564.7528,-1612.2146,13.5596,180.3663,0,1, 900000); //
	AddStaticVehicleEx(596,1600.8594,-1615.1167,13.1962,87.0131,0,1, 900000); //
	AddStaticVehicleEx(597,1600.6012,-1622.2900,13.2404,88.7567,0,1, 900000); //
	AddStaticVehicleEx(598,1588.4031,-1607.3491,13.1274,176.4542,0,1, 900000); //
	AddStaticVehicleEx(490,1564.6385,-1633.3348,13.5918,90.7638,0,0, 900000); //
	AddStaticVehicleEx(411,1545.5731,-1609.2330,13.1099,268.9421,0,1, 900000); //
	AddStaticVehicleEx(528,1567.1185,-1694.8977,5.9344,178.4258,0,0, 90000000); // Véhicule de la NSA
	
	Temptimer = SetTimer("Temps", 350000, 0); // 5 Minutes et 90 seconde avant la fin du temps additionnel
	
	return 1;
}

public OnGameModeExit()
{
    KillTimer(Restartimer);
    KillTimer(Temptimer);
    KillTimer(fintimer);
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	if(classid == 0) // ID 1 Groove
	{
    	GameTextForPlayer(playerid, "~g~EQUIPE GROOVE", 3000, 4);
		SetPlayerPos(playerid, 2526.5298,-1667.5500,15.1688); // Positon du Spawn Equipe 0
		SetPlayerCameraPos(playerid, 2523.2490,-1667.0548,15.0423);
		SetPlayerCameraLookAt(playerid, 2532.8364,-1667.5310,15.1646);
		SetPlayerColor(playerid, COULEUR_VERT); // Change la couleur du Joueur
		gTeam[playerid] = Groove; // Equipe 0 (( Groove ))
	}
	else if(classid == 1) // ID 2 Police
	{
    	GameTextForPlayer(playerid, "~b~EQUIPE POLICE", 3000, 4);
	    SetPlayerPos(playerid, 1552.2850,-1675.5742,16.1953); // Positon du Spawn Equipe 1
		SetPlayerCameraPos(playerid, 1540.6938,-1675.4351,13.5511);
		SetPlayerCameraLookAt(playerid, 1553.7799,-1675.4731,16.1953);
		SetPlayerColor(playerid, COULEUR_POLICE); // Change la couleur du Joueur
		gTeam[playerid] = Police; // Equipe 1 (( Police ))
	}
	return 1;
}

public OnPlayerConnect(playerid)
{
	new connection[127];
	GetPlayerName(playerid, connection, sizeof(connection));
	format(connection,sizeof(connection), "[ ! ] %s (ID: %d) à rejoint le serveur !", connection, playerid);
	SendClientMessageToAll(COULEUR_JAUNE, connection);
	
	GivePlayerMoney(playerid, 100000); // On donne 100000$ à la connection d'un joueur
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    new deconnection[127];
	GetPlayerName(playerid, deconnection, sizeof(deconnection));
	format(deconnection,sizeof(deconnection), "[ ! ] %s (ID: %d) à quitté le serveur !", deconnection, playerid);
	SendClientMessageToAll(COULEUR_JAUNE, deconnection);
}
public OnPlayerSpawn(playerid)
{
    new join[127], join1[127];
    new string[256];
	
    if(gTeam[playerid] == Groove)
    {
        InfoJoueur[playerid][Membre] = 1;
		GetPlayerName(playerid, join, sizeof(join));
		format(string, sizeof(string), "[INFO] Le Joueur %s vient de nous rejoindre ", join);
  		SendGMessage(COULEUR_VERT, string);
		ShowPlayerDialog(playerid, AIDE, DIALOG_STYLE_MSGBOX,"Explication de Votre Rôle (Groove) ",
		"Nous allons vous expliquez les régles du jeux !\nVous devez voler le camion de la NSA \nPour cela vous devez vous infiltrez dans le QG de la Police\nDonc prenez le et apportez le au checkpoint avant la fin du temps\nSans Mourir et Sans Faire Exploser le Camion\nSinon, vous recommencez du début !\n\nBONNE CHANCE !!!!",
		"Compris","");

    }
    else if(gTeam[playerid] == Police)
    {
        SetPlayerPos(playerid, 1526.5593,-1678.1320,5.8906);
        InfoJoueur[playerid][Membre] = 2;
		GetPlayerName(playerid, join1, sizeof(join1));
		format(string, sizeof(string), "[INFO] Le joueur %s vient de nous rejoindre ", join1);
  		SendPMessage(COULEUR_POLICE, string);
		ShowPlayerDialog(playerid, AIDE, DIALOG_STYLE_MSGBOX,"Explication de votre Rôle (Police)",
		"Nous allons vous expliquez les régles du jeux !\nVous devez protéger le camion de la NSA \nPour cela vous devez empêcher les Grooves de le Volez\nDonc protegez le et attendez les renforts\nSans Mourir et Sans Faire Exploser le Camion\nSinon, vous recommencez du début !\n\nBONNE CHANCE !!!!",
		"Compris","");
    }
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	new string[256];
	
	SendDeathMessage(killerid, playerid, reason);
	
	if(gTeam[killerid] == gTeam[playerid]) // [killerid] est le joueur qui à tuer la personne de son équipe qui est [playerid]
	{
		if(gTeam[playerid] == Groove)
    	{
          	SendGMessage(COULEUR_VERT, string); // On Envoie un message d'information à l'equipe pour le teamkill
          	format(string, sizeof(string), "[TEAM-KILL] Le Groove %s vient de tuer %s son coéquipier ", killerid, playerid);
          	SetPlayerHealth(killerid, 0.0);
          	return 1;
    	}
    	else if(gTeam[playerid] == Police)
    	{
          	SendPMessage(COULEUR_POLICE, string);
          	format(string, sizeof(string), "[TEAM-KILL] Le policier %s vient de tuer %s son coéquipier ", killerid, playerid);
          	SetPlayerHealth(killerid, 0.0);
          	return 1;
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
	new nom[MAX_PLAYER_NAME];
  	new cmd[256];
  	new string[256];
 	new idx;
	cmd = strtok(cmdtext, idx);
    
	if(strcmp(cmd, "/radio", true) == 0)
	{
	    GetPlayerName(playerid, nom, sizeof(nom));
	    new length = strlen(cmdtext);
     	while ((idx < length) && (cmdtext[idx] <= ' '))
     	{
            idx++;
     	}
     	new offset = idx;
     	new result[64];
     	while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
     	{
            result[idx - offset] = cmdtext[idx];
            idx++;
     	}
     	result[idx - offset] = EOS;
      	if(!strlen(result))
     	{
            SendClientMessage(playerid, COULEUR_ROUGE, "COMMANDE: /radio [Votre Texte]");
            return 1;
     	}
	    if (InfoJoueur[playerid][Membre] == 1)
		{
		    format(string, sizeof(string), "[RADIO] Le Groove %s dit: %s ", nom, result);
		    SendGMessage(COULEUR_VERT, string);
			return 1;
		}
		else if (InfoJoueur[playerid][Membre] == 2)
		{
		    format(string, sizeof(string), "[RADIO] Le Policier %s dit: %s ", nom, result);
		    SendPMessage(COULEUR_POLICE, string);
			return 1;
		}
	}
	if (strcmp("/aide", cmdtext, true, 10) == 0)
	{
	    SendClientMessage(playerid, COULEUR_ROUGE, ">>>>>>>>>>>>>>> LISTE CoMManDE <<<<<<<<<<<<<<<");
	    SendClientMessage(playerid, COULEUR_JAUNE, " /radio pour chaque équipe de jeu !");
	    SendClientMessage(playerid, COULEUR_JAUNE, " /q pour quitter le serveur !");
	    return 1;
	}
	return 0;
}

public SendGMessage(color, string[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
 		new membreg;
   		membreg = InfoJoueur[i][Membre];
	    if(membreg == 1)
	    {
			SendClientMessage(i, color, string);
		}
	}
}

public SendPMessage(color, string[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
 		new membrep;
   		membrep = InfoJoueur[i][Membre];
	    if(membrep == 2)
	    {
			SendClientMessage(i, color, string);
		}
	}
}

public NSA(vehicleid)
{
	new model = GetVehicleModel(vehicleid); // On déclare Model comme étant la fonction de GetVehicleModel
	if(model == 528) // Le Model du véhicule de la NSA
	{
		return 1;
	}
	return 0;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	if(NSA(vehicleid)) // On appelle la callbacks avec le parametre vehicleid
	{
	    SetPlayerCheckpoint(playerid, 2808.7444,-1419.5342,16.2500, 50.0); // On envoie un checkpoint sur la carte du joueur quand t-il rentre dans le véhicule
	    SendClientMessageToAll(COULEUR_JAUNE,"[ALERTE] Le camion de la NSA vient d'être voler !!!");
	}
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
    if(NSA(vehicleid))
	{
		DisablePlayerCheckpoint(playerid); // On retire le checkpoint du joueur quand t-il sort du véhicule
	}
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	SendClientMessageToAll(COULEUR_JAUNE,"[FELICITATION] L'équipe Groove vient de remporter la partie !!! (Le serveur va redemarrer)");
	RemovePlayerFromVehicle(playerid); // Arriver au checkpoint on lui retire le véhicule
	Restartimer = SetTimer("Restart", 4000, 0);
	return 1;
}

public Restart()
{
	SendClientMessageToAll(COULEUR_ROUGE, " Le Restart a commencé.");
    GameModeExit();
}

public Temps()
{
    SendClientMessageToAll(COULEUR_ROUGE, "[ALERTE] Il ne reste plus que 10 seconde avant la fin de la partit .");
    fintimer = SetTimer("Fin", 4000, 0);
}

public Fin()
{
    SendClientMessageToAll(COULEUR_JAUNE,"[FELICITATION] L'équipe de la Police vient de remporter la partie !!! (Le serveur va redemarrer)");
	Restartimer = SetTimer("Restart", 3000, 0);
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
    SendClientMessage(playerid, COULEUR_JAUNE,"Véhicule repeint");
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

stock strtok(const string[], &index)
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
