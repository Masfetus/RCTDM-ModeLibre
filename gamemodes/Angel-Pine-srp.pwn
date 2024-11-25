 //=========================================Angel Pine Semi-RP Mappé de Bender_Jhonny et scripté de Dim_Jhonny=======================================//
// Note:  Régler les conditions admins
//========================[ VARIABLES ET DEFINES ]=======================
#include <YSI\y_ini>
#include <a_samp>
#include <a_players>
#include <SuperStream>
#include <utils>
#define CYCLISTE 0
#define CIVIL 1
#define POLICE 2
#define AMBULANCIER 3
#define bleu 0x001AFFFF
#define jaune 0xFFFF00FF
#include <radar>
#define rouge 0xFF0000FF
#define violet 0x400080FF
#define orange 0xFF8000FF
#define newbie 0x00AE00FF
#define ADMIN_COLOR 0x04849FFF
#define rose 0xFF0080FF
#define info 0xFCEBB6FF
#define info2 0x9BD9E6FF
#define info3 0x86B9A8FF
#define vert 0x00FF00FF
#define gris 0xBBC1C6FF
#define cyan 0x00FFFFFF
#define camion -2193.9236,-2253.9270,33.3203
#define secours 345.1000,157.0000,1014.3792
#define deal -2084.3906,-2420.3313,30.6250
#define pilot -1263.3015,41.0482,14.1392
#define police -2162.1306,-2385.6995,30.6250
#define COLOR_RED 0xAA3333AA
#define PosAttaq 2543.2075,-1304.0317,1025.0703
#define PosDef 2580.9861,-1285.1428,1044.1250
#define ColorDef 0x000FFFF
#define ColorAttaq 0xFF0000FF
#pragma tabsize 0
new rapportsujet[MAX_PLAYERS][256];
new vehallume[MAX_VEHICLES];
new vehsabot[MAX_VEHICLES];
new clickedplayer;
new rapportexte[MAX_PLAYERS][256];
new mcagoule[MAX_PLAYERS];
new ammu1;
new playerdemande;
new autoecole1;
new bar1;
new bar2;
new bar3;
new timerlol;
new autoecole2;
new vspawn[MAX_PLAYERS];
new conversapm[MAX_PLAYERS];
new autoecoleinfo;
new mjoin[MAX_PLAYERS];
new Text:Textdraw4[MAX_PLAYERS];
new successlogin[MAX_PLAYERS];
new mjload;
new mjjoin;
new checkcp[MAX_PLAYERS];
new radiopick;
enum pPermisInfos
{
pVoiture,
pPoidsLourd,
pArme,
pMoto,
pVol,
pBateau
};
new permis[MAX_PLAYERS][pPermisInfos];

new permiscours[MAX_PLAYERS];
new Text:Mjscore;
new rapport[MAX_PLAYERS];
new confirm[MAX_PLAYERS];
new Text:Mjdef;
new ammu2;
new def[MAX_PLAYERS];
new banque1;
new banque2;
new banque3;
new attaq[MAX_PLAYERS];
new Text:serv;
new pickuprepair;
new pickup2repair;
new v1;
new attaquants;
new defenseurs;
new v2;
new pduty;
new casque[MAX_PLAYERS];
new Menu:ammu;
new market;
new duty[MAX_PLAYERS];
#define Modo 1
#define Admin 2
#define Administrateur 3
new ooc;
new fumer[MAX_PLAYERS];
new r1;
new mspawn[MAX_PLAYERS];
new noob;
new commi1;
new commi2;
new vestinfo;
new r2;
new amende[MAX_PLAYERS];
new Float:a1;
new Float:a2;
new Float:a3;
new r3;
new mill;
new p1;
new p2;
new p3;
new p4;
new market2;
new John;
new ybande[MAX_PLAYERS];
new briquet[MAX_PLAYERS];
new pomme[MAX_PLAYERS];
new poire[MAX_PLAYERS];
new peche [MAX_PLAYERS];
new prioritaire[MAX_PLAYERS];
new cigarette[MAX_PLAYERS];
new gps[MAX_PLAYERS];
new logged[MAX_PLAYERS];
new cuff[MAX_PLAYERS];
new barrage[MAX_PLAYERS];
new saveplayerid;
new cagoule[MAX_PLAYERS];
new canne[MAX_PLAYERS];
new decodeur[MAX_PLAYERS];
new vol[MAX_PLAYERS];
new giro[MAX_VEHICLES];
new carcasse;
new veh1;
new veh2;
#define BLANC 0xFFFFFFFF
new veh3;
new veh4;
new veh5;
new veh6;
#define bus -3228.0159,454.9955,4.6437
#define admin 0x004993FF
#define RECORDING "sentinel" // Nom de l'enregistrement test.rec
#define RECORDING_TYPE 1 //1 pour un enregistrement dans un Véhicule et 2 pour un Ped
#include <a_npc>
#define CreateObject CreateStreamObject
#define DestroyObject DestroyStreamObject
#define DIALOG_REGISTER 1000
#define DIALOG_LOGIN 1001
#define DIALOG_SUCCESS_1 1002
#define DIALOG_SUCCESS_2 1003
#define PATH "/Comptes/%s.ini"
#define COL_WHITE "{FFFFFF}"
#define COL_RED "{F81414}"
#define COL_GREEN "{00FF22}"
#define COL_LIGHTBLUE "{00CED1}"
enum pInfo
{
	pAlevel,
    pPass,
    pCash,
    pAdmin,
    pKills,
    pDeaths,
    pLevel,
    pNiveau,
    pSkin,
    pVie,
    pArmure,
    pMetier,
    pCasque,
    pPcasque,
    pGps,
    pBriquet,
    pBanque,
    pPbanque,
	pPermisv,
	pPermisp,
	pPermisa,
	pPermisvol,
	pPermisb,
	pPermism
}
new PlayerInfo[MAX_PLAYERS][pInfo];
new mission[MAX_PLAYERS];
new accident;
new afk[MAX_PLAYERS];
new Float:x1;
new Float:x2;
new Float:x3;
new metier[MAX_PLAYERS];
new pseudoinitial[50][MAX_PLAYERS];
new pseudofinal[50]; 
new Message[][] =
{
"[ANNOUNCE]Vous êtes nouveau? Et bien tapez /aide.",
"[ANNOUNCE]Les Missions sont représentées sur votre carte par un drapeau rouge",
"[ANNOUNCE]Un problème? Postez sur notre forum dans la rubrique Plainte ou contactez un admin",
"[ANNOUNCE]Nous avons un forum: www.minecraft-le-fun.xooit.fr",
"[ANNOUNCE]Vous voulez savoir le but de notre serveur et ses crédits? Alors faites /but et /credits",
"[ANNOUNCE]Vous voulez savoir les différentes missions disponibles? Tapez /mhelp",
"[ANNOUNCE]Nous possédons un gta3.img particulier téléchargeable sur le forum",
"[ANNOUNCE]Pour voir les news de la dernière mise à jour tapez /news",
"[ANNOUNCE]Notre staff recrute allez voir sur le forum pour plus d'informations"
};
new CSkinAlea[][]=
{
16,
27,
153,
160
};
new SSkinAlea[][]=
{
70,
274,
275,
276
};
new DSkinAlea[][]=
{
102,
103,
104,
105,
106,
107,
108,
109,
110,
111,
112,
113,
114,
115,
116,
117,
118,
119,
120,
121,
122,
123,
124,
125,
126,
127,
173,
174,
175
};
new PoSkinAlea[][]=
{
71,
280,
281,
282,
283,
284,
285,
288
};
new MSkinAlea[][]=
{
287,
73,
191
};
new PeSkinAlea[][]=
{
30,
47,
48
};

	new Float: taxi[6][5]= {
	{-1604.9218,720.953,11.6951},
	{-1646.5613,1215.0417,7.0028},
	{-2624.2891,1410.0417,6.9210},
	{-1975.1097,289.8986,34.9952},
	{-2080.2354,-94.7077,34.9874},
	{-1427.6084,-291.7390,13.8935}
	};
	new Float:passager[5][4]= {
	{-2525.6379,-609.9336,132.3093},
	{-2724.9463,-310.9633,6.7832},
	{-1821.8961,17.0387,14.8400},
	{-2398.8813,1116.6245,55.4519},
	{-2412.0803,330.7469,34.6874}
	};
    new Float:essence[5][4] = {
	{-1675.5332,414.5001,6.9068},
    {-2416.5349,974.9665,45.0240},
    {-1474.0569,1863.6008,32.3599},
    {-91.0539,-1169.4426,2.1304},
    {1937.5670,-1778.3977,13.1118}

    };
    new Float: secour[5][4]= {
        {-2802.7136,-1532.6322,139.4382},
    {-2432.5562,-1325.8119,310.6184},
    {-2551.2959,-1471.9063,359.9337},
    {-2379.2834,-1614.9718,496.9742},
	{-2429.8967,-1698.2836,446.2047}
	};
     new Float:habit[6][5] = {
    {-1885.1783,864.5337,34.8973},
    {-1704.7999,950.4305,24.6176},
    {-2377.1309,910.8334,45.1724},
    {2247.4409,-1663.7406,15.1996},
    {1455.3796,-1153.3982,23.6252},
    {502.2471,-1358.5989,15.8611}
    };
     new Float:pilote[3][3] = {
    {1983.7072,-2494.1772,13.8788},
    {1431.3889,1468.2025,11.1635},
    {-1495.9304,-113.5655,13.8744}
    };
    new Float:CpAleaPermis[5][4]= {
    {-104.7341,1354.5192,9.5089},
    {176.6050,1169.2396,14.3360},
    {-308.6200,829.9609,12.9293},
    {-683.9039,965.9741,11.7179},
    {-323.1439,1531.2491,74.9434}
    };
	main()
{
	print("\n----------------------------------");
	print(" ****Angel Pine RP****");
	print("Scripteur: Dim_Jhonny Mappeur: Bender_Jhonny");
	print("----------------------------------\n");
}
new BigEar[MAX_PLAYERS];
//==================================================================================================================================//
//========================[ TIMERS ]====================================//
forward Messages();
forward Peage();
forward Peage2();
forward ProxDetector(Float:radi, playerid, string[],col1,col2,col3,col4,col5);
forward Payday(playerid);
forward Chargement(playerid);
forward Event();
forward ACheatArmes(playerid);
forward Reboot();
forward OnPlayerFlashed(playerid,radarid,vitesse);
forward Volmaison();
forward ProxDetectorS(Float:radi, playerid, targetid);
forward Fume(playerid);
forward LoadUser_data(playerid,name[],value[]);
forward SendRadioPolice(playerid, const str[], define);
forward SendAdminMessage(playerid, const str[], define);
forward GiveCInfos(playerid);
forward GiveSInfos(playerid);
forward GiveDInfos(playerid);
forward GivePInfos(playerid);
forward GivePoInfos(playerid);
forward GiveChInfos(playerid);
forward GiveMInfos(playerid);
forward GivePeInfos(playerid);
forward TimerPermis(playerid);
forward TimeRepair(playerid,vehicleid);
forward SendSMS(playerid,const str[]);
forward Carcasse(playerid);
public LoadUser_data(playerid,name[],value[])
{
    INI_Int("Password",PlayerInfo[playerid][pPass]);
    INI_Int("Cash",PlayerInfo[playerid][pCash]);
    INI_Int("Kills",PlayerInfo[playerid][pKills]);
    INI_Int("Deaths",PlayerInfo[playerid][pDeaths]);
    INI_Int("Niveau",PlayerInfo[playerid][pNiveau]);
    INI_Int("Santé",PlayerInfo[playerid][pVie]);
    INI_Int("Armure",PlayerInfo[playerid][pArmure]);
	INI_Int("Casque",PlayerInfo[playerid][pCasque]);
	INI_Int("GPS",PlayerInfo[playerid][pGps]);
	INI_Int("Briquet",PlayerInfo[playerid][pBriquet]);
	INI_Int("Admin Level",PlayerInfo[playerid][pAlevel]);
	INI_Int("Banque",PlayerInfo[playerid][pPbanque]);
	INI_Int("Métier",PlayerInfo[playerid][pMetier]);
	INI_Int("Permis Voiture",PlayerInfo[playerid][pPermisv]);
	INI_Int("Permis Moto",PlayerInfo[playerid][pPermism]);
	INI_Int("Permis Poids Lourd",PlayerInfo[playerid][pPermisp]);
	INI_Int("Permis Arme",PlayerInfo[playerid][pPermisa]);
	INI_Int("Permis Vol",PlayerInfo[playerid][pPermisv]);
	INI_Int("Permis Bâteau",PlayerInfo[playerid][pPermisb]);
    return 1;
}
public Carcasse(playerid)
{
CreateObject(3594,a1,a2,a3,0,0,0);
ProxDetector(30.0,playerid,"Une carcasse vient de se former",orange,orange,orange,orange,orange);
}
public Fume(playerid)
{
SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
SendClientMessage(playerid,vert,"Vous avez fini votre cigarette");
fumer[playerid]=0;
}
public ACheatArmes(playerid)
{
new pname[256];
new msgscreen[256];
new msgannounce[256];
new msglog[256];
if(GetPlayerWeapon(playerid)== 38 || GetPlayerWeapon(playerid)== 35 || GetPlayerWeapon(playerid)== 36 || GetPlayerWeapon(playerid)== 37) 
{
if(!IsPlayerAdmin(playerid))
{
GetPlayerName(playerid,pname,sizeof(pname));
SendClientMessage(playerid,rouge,"[ANTI-CHEAT]Vous avez été banni par notre anti-cheat pour toutes demandes de deban screenez le message qui va apparaître ci-dessous");
format(msgscreen,sizeof(msgscreen),"Nom: %s    ID: %d",pname,playerid);
SendClientMessage(playerid,info,"Sanction: Ban     Raison: Cheat Armes");
SendClientMessage(playerid,info,msgscreen);
format(msgannounce,sizeof(msgannounce),"[ANNOUNCE]%s a été banni par notre anti-cheat Raison: Cheat Armes",pname);
SendClientMessageToAll(ADMIN_COLOR,msgannounce);
format(msglog,sizeof(msglog),"[ANTI-CHEAT]%s a été banni par l'anti-cheat armes",pname);
BanEx(playerid,msglog);
}
}
}
public TimerPermis(playerid)
{
new Float:vhealth;
GetVehicleHealth(vspawn[playerid],vhealth);
if(vhealth<1000 && permiscours[playerid]!=0)
{
EchouedPermis(playerid);
KillTimer(timerlol);
}
}
public TimeRepair(playerid,vehicleid)
{
vehicleid=GetPlayerVehicleID(playerid);
TogglePlayerControllable(playerid,1);
SendClientMessage(playerid,jaune,"Votre véhicule a été réparé roulez prudemment la prochaine fois!");
RepairVehicle(vehicleid);
GameTextForPlayer(playerid,"~y~REPARATION FINIE",2000,4);
}
public ProxDetector(Float:radi, playerid, string[],col1,col2,col3,col4,col5)
{
	if(IsPlayerConnected(playerid))
	{
		new Float:posx, Float:posy, Float:posz;
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		//radi = 2.0; //Trigger Radius
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i) && (GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(i)))
			{
				if(!BigEar[i])
				{
					GetPlayerPos(i, posx, posy, posz);
					tempposx = (oldposx -posx);
					tempposy = (oldposy -posy);
					tempposz = (oldposz -posz);
					//printf("DEBUG: X:%f Y:%f Z:%f",posx,posy,posz);
					if (((tempposx < radi/16) && (tempposx > -radi/16)) && ((tempposy < radi/16) && (tempposy > -radi/16)) && ((tempposz < radi/16) && (tempposz > -radi/16)))
					{
						SendClientMessage(i, col1, string);
					}
					else if (((tempposx < radi/8) && (tempposx > -radi/8)) && ((tempposy < radi/8) && (tempposy > -radi/8)) && ((tempposz < radi/8) && (tempposz > -radi/8)))
					{
						SendClientMessage(i, col2, string);
					}
					else if (((tempposx < radi/4) && (tempposx > -radi/4)) && ((tempposy < radi/4) && (tempposy > -radi/4)) && ((tempposz < radi/4) && (tempposz > -radi/4)))
					{
						SendClientMessage(i, col3, string);
					}
					else if (((tempposx < radi/2) && (tempposx > -radi/2)) && ((tempposy < radi/2) && (tempposy > -radi/2)) && ((tempposz < radi/2) && (tempposz > -radi/2)))
					{
						SendClientMessage(i, col4, string);
					}
					else if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
					{
						SendClientMessage(i, col5, string);
					}
				}
				else
				{
					SendClientMessage(i, col1, string);
				}
			}
		}
	}//not connected
	return 1;
}
public ProxDetectorS(Float:radi, playerid, targetid)
{
    if(IsPlayerConnected(playerid)&&IsPlayerConnected(targetid))
	{
		new Float:posx, Float:posy, Float:posz;
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		//radi = 2.0; //Trigger Radius
		GetPlayerPos(targetid, posx, posy, posz);
		tempposx = (oldposx -posx);
		tempposy = (oldposy -posy);
		tempposz = (oldposz -posz);
		//printf("DEBUG: X:%f Y:%f Z:%f",posx,posy,posz);
		if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
		{
			return 1;
		}
	}
	return 0;
}
public Messages()
{
    new randMSG = random(sizeof(Message));
    SendClientMessageToAll(cyan, Message[randMSG]);
}
public Reboot()
{
SendClientMessageToAll(jaune,"Le Serveur reboot pour une nouvelle mise à jour veuillez nous excuser pour le dérangement éventuelement causé");
SendRconCommand("gmx");
}
public OnPlayerFlashed(playerid,radarid,vitesse)
{
new pname[256];
if(radarid==r1)
{
GetPlayerName(playerid,pname,sizeof(pname));
new msg1[256];
new msg2[256];
SendClientMessage(playerid,jaune,"Vous avez reçu une amende s'élevant à 250$ pour excès de vitesse");
SendClientMessage(playerid,bleu,"---------------Contravention-------------                        ");
SendClientMessage(playerid,orange,"Radar: Fixe          Limite: 50      ");
format(msg1,sizeof(msg1),"Vitesse retenue: %d     Modèle: %d   ",vitesse,GetVehicleModel(playerid));
SendClientMessage(playerid,orange,msg1);
format(msg2,sizeof(msg2),"%s vient de se faire flasher à %d km/h",pname,vitesse);
ProxDetector(30.0,playerid,msg2,jaune,jaune,jaune,jaune,jaune);
GivePlayerMoney(playerid,-250);

new msgspeca[256];
format(msgspeca,sizeof(msgspeca),"[SPEC]%s vient de se faire flashé à %d km/h",pname,vitesse);
SendAdminMessage(playerid,msgspeca,0);
printf("%s vient de se faire flasher à %d km/h",pname,vitesse);
}
if(radarid==r2)
{
GetPlayerName(playerid,pname,sizeof(pname));
new msg1[256];
new msg2[256];
SendClientMessage(playerid,jaune,"Vous avez reçu une amende s'élevant à 500$ pour excès de vitesse");
SendClientMessage(playerid,bleu,"---------------Contravention-------------                        ");
SendClientMessage(playerid,orange,"Radar: Fixe          Limite: 90      ");
format(msg1,sizeof(msg1),"Vitesse retenue: %d     Modèle: %d   ",vitesse,GetVehicleModel(playerid));
SendClientMessage(playerid,orange,msg1);
format(msg2,sizeof(msg2),"%s vient de se faire flasher à %d km/h",pname,vitesse);
ProxDetector(30.0,playerid,msg2,jaune,jaune,jaune,jaune,jaune);
GivePlayerMoney(playerid,-500);

new msgspeca[256];
format(msgspeca,sizeof(msgspeca),"[SPEC]%s vient de se faire flashé à %d km/h",pname,vitesse);
SendAdminMessage(playerid,msgspeca,0);
printf("%s vient de se faire flasher à %d km/h",pname,vitesse);
}
if(radarid==r3)
{
GetPlayerName(playerid,pname,sizeof(pname));
new msg1[256];
new msg2[256];
SendClientMessage(playerid,jaune,"Vous avez reçu une amende s'élevant à 1000$ pour excès de vitesse");
SendClientMessage(playerid,bleu,"---------------Contravention-------------                        ");
SendClientMessage(playerid,orange,"Radar: Fixe          Limite: 130      ");
format(msg1,sizeof(msg1),"Vitesse retenue: %d     Modèle: %d   ",vitesse,GetVehicleModel(playerid));
SendClientMessage(playerid,orange,msg1);
format(msg2,sizeof(msg2),"%s vient de se faire flasher à %d km/h",pname,vitesse);
ProxDetector(30.0,playerid,msg2,jaune,jaune,jaune,jaune,jaune);
GivePlayerMoney(playerid,-1000);

new msgspeca[256];
format(msgspeca,sizeof(msgspeca),"[SPEC]%s vient de se faire flashé à %d km/h",pname,vitesse);
SendAdminMessage(playerid,msgspeca,0);
printf("%s vient de se faire flasher à %d km/h",pname,vitesse);
}
return 1;
}
forward Compteur(playerid);
public Compteur(playerid)
{
    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
        {
        new string[128];
    new vid;
    vid = GetPlayerVehicleID(playerid);
    new Float:Vitesse_x,Float:Vitesse_y,Float:Vitesse_z,Float:Temp_Vitesse,Dernier_Vitesse;
    GetVehicleVelocity(vid,Vitesse_x,Vitesse_y,Vitesse_z);
    Temp_Vitesse = floatsqroot(((Vitesse_x*Vitesse_x)+(Vitesse_y*Vitesse_y))+(Vitesse_z*Vitesse_z))*136.666667;
    Dernier_Vitesse = floatround(Temp_Vitesse,floatround_round);
    format(string,sizeof string,"~B~Vitesse: ~g~%i",Dernier_Vitesse);
    TextDrawSetString(Textdraw4[playerid], string);
        SetTimer("Compteur", 1000, 0);
    }
    else
    {
    TextDrawDestroy(Textdraw4[playerid]);
    }
        return 1;
}
//======================================================================================================================================//
public OnGameModeInit()
{
	// Don't use these lines if it's a filterscript
	SetGameModeText("Angel Pine RP");
 SetTimer("Messages", 60000, true);
 SetTimer("ACheatArmes",1,true);
 //==============================================[ COURSE PLAYER ]=======================================================================
 UsePlayerPedAnims();
 //=============================================[ VARIABLES ]=======================================================================
 ooc=1;
 noob=1;
 accident=0;
 mjload=0;
 mjjoin=1;
 attaquants=0;
 defenseurs=0;
 //===========================[ BOT JOHN ]========================================================
 ConnectNPC("John","John.amx"); // Connection de votre bot, bot_1 correspond au nom et test au nom de votre bot dans le dossier npcmodes!
 ConnectNPC("vend","vendeur");

 	John =	AddStaticVehicle(405,-2153.6404,-2424.3950,30.3423,321.4653,0,1); // Pour créer le véhicule de la position de départ de l'enregistrement prenez la position dans le savedpositions quand vous avez fait /save !
 	//===============================================[PICKUPS INTERIOR]===========================================================
 	    DisableInteriorEnterExits();
 	//==========================================================================================
 	AddPlayerClass(299,-134.7689,917.9264,19.4042,0,0,0,0,0,0,0);
AddStaticVehicle(584,-2087.69995117,-2238.60009766,32.40000153,141.99987793,-1,-1); //Trailer 3
AddStaticVehicle(584,-2090.80004883,-2235.50000000,32.20000076,139.99829102,-1,-1); //Trailer 3
AddStaticVehicle(435,-2098.60009766,-2232.80004883,31.29999924,140.00000000,-1,-1); //Trailer 1
AddStaticVehicle(435,-2096.00000000,-2235.09960938,31.29999924,139.99877930,-1,-1); //Trailer 1
AddStaticVehicle(591,-2104.50000000,-2229.30004883,31.29999924,144.00000000,-1,-1); //Trailer 3
AddStaticVehicle(591,-2101.29980469,-2230.79980469,31.29999924,143.99780273,-1,-1); //Trailer 3
AddStaticVehicle(515,-2105.00000000,-2245.00000000,31.79999924,140.00000000,-1,-1); //Roadtrain
AddStaticVehicle(515,-2101.79980469,-2247.50000000,31.79999924,139.99877930,-1,-1); //Roadtrain
AddStaticVehicle(403,-2109.19995117,-2242.89990234,31.29999924,144.00000000,-1,-1); //Linerunner
AddStaticVehicle(553,-1387.19995117,-217.69999695,16.39999962,322.00000000,-1,-1); //Nevada
AddStaticVehicle(553,-1356.59997559,-259.89999390,16.39999962,321.99829102,-1,-1); //Nevada
AddStaticVehicle(553,-1288.69995117,-253.69999695,16.39999962,321.99829102,-1,-1); //Nevada
AddStaticVehicle(519,-1625.50000000,-303.79998779,15.10000038,0.00000000,-1,-1); //Shamal
AddStaticVehicle(519,-1611.09960938,-289.89941406,15.10000038,0.00000000,-1,-1); //Shamal
AddStaticVehicle(519,-1639.50000000,-316.29998779,15.10000038,0.00000000,-1,-1); //Shamal
AddStaticVehicle(563,-2245.00000000,-2272.60009766,34.09999847,230.00000000,-1,-1); //Raindance
AddStaticVehicle(403,-2097.5183,-2250.6052,31.2307,140.7120,30,1); //
AddStaticVehicle(599,-2144.5085,-2379.9224,30.6107,230.2219,0,1); //
AddStaticVehicle(599,-2153.3220,-2372.9778,30.6469,53.1308,0,1); //
AddStaticVehicle(437,-3226.4148,517.2717,4.8923,179.8567,3,3); //
AddStaticVehicle(437,-3236.5525,515.6914,4.9022,177.3497,3,3); //
AddStaticVehicle(437,-3246.6282,518.7544,4.8927,177.1580,3,3); //
AddStaticVehicle(437,-3257.3040,518.3444,4.8980,178.3407,3,3); //
AddStaticVehicle(437,-3267.8586,518.7302,4.8898,178.9281,3,3); //
AddStaticVehicle(437,-3278.3955,517.1195,4.8921,180.8185,3,3); //
AddStaticVehicle(437,-3288.7415,517.5958,4.8912,179.8578,3,3); //
AddStaticVehicle(437,-3298.8113,518.5793,4.8938,178.9284,3,3); //
AddStaticVehicle(437,-3309.4827,517.6297,4.8951,180.2230,3,3); //
AddStaticVehicle(437,-3319.8774,518.1424,4.8925,177.9814,3,3); //
AddStaticVehicle(437,-3329.3682,518.0278,4.8974,182.6740,3,3); //
AddStaticVehicle(437,-3340.4167,517.5416,4.8924,179.6468,3,3); //
AddStaticVehicle(437,-3350.7002,516.7054,4.8945,183.0172,3,3); //
AddStaticVehicle(437,-3360.6816,517.4002,4.8919,181.3375,3,3); //
AddStaticVehicle(437,-3371.3875,518.4897,4.8869,180.8573,3,3); //
AddStaticVehicle(437,-3381.4856,518.1161,4.8940,180.6749,3,3); //
AddStaticVehicle(420,-3377.9519,452.8582,4.5757,0.3908,3,3); //
AddStaticVehicle(420,-3367.8806,454.3029,4.5718,1.7845,3,3); //
AddStaticVehicle(420,-3357.3782,453.7481,4.5716,358.8253,3,3); //
AddStaticVehicle(420,-3347.1306,454.9754,4.5769,0.2903,3,3); //
AddStaticVehicle(420,-3336.5215,454.9515,4.5725,1.8309,3,3); //
AddStaticVehicle(420,-3326.4084,454.2704,4.5703,359.1892,3,3); //
AddStaticVehicle(420,-3316.1843,454.6851,4.5718,357.3226,3,3); //
AddStaticVehicle(405,-2188.3960,-2269.2014,30.4999,142.6057,7,5); //
AddStaticVehicle(580,-2191.1367,-2267.4392,30.4211,145.0171,0,0); //
AddStaticVehicle(426,-2193.6506,-2265.3870,30.3680,141.7528,8,3); //
AddStaticVehicle(445,-2196.2427,-2263.8560,30.5059,141.0500,45,78); //
AddStaticVehicle(545,-2198.6104,-2261.2261,30.4539,141.9126,89,45); //
AddStaticVehicle(416,-2206.7129,-2299.7336,30.7738,319.9361,86,1); //
AddStaticVehicle(416,-2198.7529,-2310.7490,30.7744,319.1246,86,1); //
AddStaticVehicle(596,-2152.4763,-2399.0554,30.1246,52.9307,86,1); //
AddStaticVehicle(596,-2158.5542,-2394.3157,30.1252,51.5992,86,1); //
AddStaticVehicle(596,-2164.0500,-2390.0542,30.1217,50.0195,86,1); //
AddStaticVehicle(523,-2171.2080,-2384.4937,30.0394,52.3097,86,1); //
AddStaticVehicle(523,-2174.8481,-2381.7712,30.0352,48.6938,86,1); //
AddStaticVehicle(482,-2063.3647,-2433.0950,30.7473,52.3406,74,12); //
AddStaticVehicle(482,-2065.4785,-2435.4688,30.7462,53.9111,36,52); //
AddStaticVehicle(482,-2067.0229,-2437.8831,30.7445,55.2072,36,52); //
AddStaticVehicle(482,-2068.5579,-2440.5552,30.7481,54.7963,12,45); //
AddStaticVehicle(482,-2070.1167,-2443.2070,30.7411,54.3379,101,45); //
AddStaticVehicle(588,-2164.3572,-2463.8933,30.5293,52.3951,74,56); //
AddStaticVehicle(588,-2161.9075,-2460.9331,30.5313,54.1658,74,56); //
AddStaticVehicle(448,-2153.5366,-2438.8577,30.2254,144.3055,74,56); //
AddStaticVehicle(448,-2151.5647,-2440.8052,30.2236,146.1156,74,56); //
AddStaticVehicle(448,-2149.6016,-2442.6707,30.2248,144.5472,74,56); //
AddStaticVehicle(448,-2147.4971,-2444.3164,30.2250,143.0962,74,56); //
AddStaticVehicle(448,-2145.6719,-2446.2117,30.2234,143.9814,74,56); //
AddStaticVehicle(448,-2143.6262,-2447.9644,30.2245,142.3422,74,56); //
AddStaticVehicle(448,-2141.4429,-2449.8569,30.2288,146.1606,74,56); //
AddStaticVehicle(603,-1246.5090,45.4434,13.8904,224.1875,106,106); //
AddStaticVehicle(603,-1244.1570,47.3234,13.8888,224.7330,106,106); //
AddStaticVehicle(603,-1241.9590,49.3991,13.8904,223.9278,106,106); //
AddStaticVehicle(603,-1239.5067,51.6097,13.8879,222.0108,106,106); //
AddStaticVehicle(603,-1237.2782,53.8144,13.8856,223.1171,106,106); //
//=======================[ TRAIN ]=================================================================
AddStaticVehicle(538,-1943.00000000,162.80000305,27.20000076,0.00000000,-1,-1); //Streak
//==========================================[VEHICULES PORT ANGEL PINE ]===========================
AddStaticVehicle(453,-2792.3081,-2172.0002,-0.5448,314.3132,1,1); //
AddStaticVehicle(453,-2785.2676,-2165.7766,-0.0506,312.2227,1,1); //
AddStaticVehicle(453,-2785.9082,-2180.5574,-0.3291,308.4388,1,1); //
AddStaticVehicle(453,-2778.4080,-2174.8782,-0.1640,303.2772,1,1); //
AddStaticVehicle(453,-2781.6943,-2189.3008,-0.6649,303.7586,1,1); //
AddStaticVehicle(453,-2772.3591,-2182.5847,-0.6301,305.0202,1,1); //
AddStaticVehicle(453,-2774.7971,-2197.8083,-0.3980,301.7560,1,1); //
AddStaticVehicle(453,-2765.2136,-2191.4434,-0.0407,304.5709,1,1); //
AddStaticVehicle(453,-2768.1353,-2207.9646,-0.6170,306.9113,1,1); //
AddStaticVehicle(453,-2757.9851,-2200.3394,-0.5927,299.7583,1,1); //
AddStaticVehicle(453,-2761.4446,-2216.3225,-0.5497,304.9755,1,1); //
AddStaticVehicle(453,-2751.9900,-2209.4407,-0.2416,309.1882,1,1); //
AddStaticVehicle(453,-2756.2573,-2224.4011,-0.5484,305.0664,1,1); //
AddStaticVehicle(453,-2746.2153,-2216.7166,-0.4641,301.8473,1,1); //
AddStaticVehicle(453,-2749.1511,-2232.4199,-0.2860,307.3682,1,1); //
AddStaticVehicle(453,-2739.0156,-2225.1333,-0.3443,309.8379,1,1); //
AddStaticVehicle(453,-2826.5544,-2198.8096,-0.4835,125.0458,1,1); //
AddStaticVehicle(453,-2836.9148,-2206.1414,-0.6801,127.5981,1,1); //
AddStaticVehicle(453,-2820.7688,-2207.3237,-0.0463,133.4961,1,1); //
AddStaticVehicle(453,-2830.0742,-2214.6804,-0.7641,123.8277,1,1); //
AddStaticVehicle(453,-2814.7231,-2215.5500,-0.7169,119.9874,1,1); //
AddStaticVehicle(453,-2826.5413,-2223.2036,-0.1958,125.5406,1,1); //
AddStaticVehicle(453,-2808.7871,-2224.4734,-0.0883,127.8324,1,1); //
AddStaticVehicle(453,-2817.7097,-2231.0884,0.0022,122.5967,1,1); //
AddStaticVehicle(453,-2801.9277,-2232.5454,-0.2147,125.9635,1,1); //
AddStaticVehicle(453,-2812.3391,-2239.7178,-0.6364,124.2886,1,1); //
AddStaticVehicle(453,-2796.3064,-2241.3245,-0.3802,127.3949,1,1); //
AddStaticVehicle(453,-2805.1924,-2248.3196,-0.0661,122.4472,1,1); //
AddStaticVehicle(453,-2789.8589,-2249.5405,-0.1933,123.0926,1,1); //
AddStaticVehicle(453,-2799.5144,-2256.3916,-0.6642,131.7867,1,1); //
AddStaticVehicle(453,-2784.0154,-2257.9263,-0.5335,125.0800,1,1); //
AddStaticVehicle(453,-2793.3899,-2265.5759,-0.4290,123.9193,1,1); //
AddStaticVehicle(454,-2677.4463,-2183.2178,0.3469,127.0115,1,1); //
AddStaticVehicle(454,-2711.2197,-2205.9539,0.3270,127.4361,1,1); //
AddStaticVehicle(484,-2846.0339,-2395.4089,0.5888,9.4665,1,1); //
AddStaticVehicle(484,-2857.9939,-2390.5347,0.5531,236.6086,1,1); //
AddStaticVehicle(484,-2847.1177,-2376.8284,0.5747,87.2808,1,1); //
AddStaticVehicle(484,-2840.9780,-2366.2747,0.0981,354.8848,1,1); //
AddStaticVehicle(484,-2840.7102,-2341.0105,0.6176,51.3111,1,1); //
AddStaticVehicle(484,-2847.7034,-2366.2568,-0.0669,32.0563,1,1); //
AddStaticVehicle(484,-2842.2124,-2346.2095,0.2441,70.2457,1,1); //
AddStaticVehicle(484,-2863.4285,-2338.1345,-0.1251,318.7016,1,1); //
AddStaticVehicle(484,-2869.5952,-2354.1680,0.6242,294.8508,1,1); //
AddStaticVehicle(484,-2867.5728,-2385.8833,0.0400,352.1804,1,1); //
AddStaticVehicle(484,-2884.3569,-2385.9590,0.6207,247.0346,1,1); //
AddStaticVehicle(530,-2741.8625,-2247.1311,4.8828,305.7279,1,1); //
AddStaticVehicle(530,-2742.8440,-2245.8501,4.8804,305.8846,1,1); //
AddStaticVehicle(484,-2861.9250,-2366.0383,0.2903,91.6101,1,1); //
AddStaticVehicle(484,-2879.0828,-2372.2197,0.0028,200.8363,1,1); //
AddStaticVehicle(484,-2876.6731,-2344.7275,0.2097,70.4362,1,1); //
AddStaticVehicle(484,-2882.2900,-2355.5867,0.4358,152.1347,1,1); //
AddStaticVehicle(484,-2885.8743,-2377.4956,0.1344,58.3679,1,1); //
AddStaticVehicle(484,-2869.5059,-2331.0349,0.3145,105.8045,1,1); //
AddStaticVehicle(484,-2885.1294,-2349.9917,0.2368,114.0201,1,1); //
AddStaticVehicle(484,-2900.2715,-2373.2803,0.3906,345.9804,1,1); //
AddStaticVehicle(484,-2890.7849,-2331.3530,0.4350,158.9716,1,1); //
//==========================================[ VEHICULE CIRCUIT LV ]===============================================
AddStaticVehicle(571,2020.3008,1934.7622,11.6079,181.8448,36,2); //
AddStaticVehicle(571,2021.8083,1934.8065,11.5918,180.2926,11,22); //
AddStaticVehicle(571,2023.2990,1934.7579,11.5763,181.2778,40,35); //
AddStaticVehicle(571,2027.4083,1934.8264,11.5329,179.2963,51,53); //
AddStaticVehicle(571,2028.9272,1934.7952,11.5169,181.0743,91,2); //
AddStaticVehicle(522,2019.4680,1920.2979,11.9094,184.6194,7,79); //
AddStaticVehicle(522,2020.9269,1920.1416,11.9120,182.1618,6,25); //
AddStaticVehicle(522,2022.4264,1919.8979,11.9045,181.2515,3,8); //
AddStaticVehicle(522,2023.8734,1919.7614,11.9011,180.0597,8,82); //
AddStaticVehicle(522,2026.9226,1919.8243,11.9060,182.3250,36,105); //
AddStaticVehicle(522,2028.2745,1919.5509,11.9074,181.0483,39,106); //
AddStaticVehicle(522,2029.6088,1919.5157,11.8901,184.8081,51,118); //
//===========================================[ VEH COMMI FC ]=====================================================
AddStaticVehicle(598,-227.2313,990.8314,19.2662,269.5407,106,106); //
AddStaticVehicle(598,-227.2466,993.5106,19.2869,269.7743,106,106); //
AddStaticVehicle(598,-227.3660,996.2531,19.3111,270.4473,106,106); //
AddStaticVehicle(598,-227.4409,998.9980,19.3338,271.3473,106,106); //
AddStaticVehicle(599,-210.1122,1000.6337,19.8669,92.0185,106,106); //
AddStaticVehicle(599,-209.9955,997.6669,19.8108,89.9699,106,106); //
AddStaticVehicle(599,-209.7032,994.7564,19.7360,92.7982,106,106); //
AddStaticVehicle(599,-209.4901,991.7511,19.7170,91.3111,106,106); //
AddStaticVehicle(523,-216.2950,984.4363,18.9476,271.5005,106,106); //
AddStaticVehicle(523,-216.3830,985.6899,18.9739,269.6536,106,106); //
AddStaticVehicle(523,-216.5215,986.9286,19.0001,268.2737,106,106); //
AddStaticVehicle(523,-216.5399,988.1901,19.0251,273.5422,106,106); //
//======================================[ VEH HOSTO FC ]=====================================================
AddStaticVehicle(563,-333.8062,1050.0751,26.7374,179.7605,1,6); //
AddStaticVehicle(416,-304.2465,1036.1733,19.7424,271.5238,1,3); //
AddStaticVehicle(416,-304.0095,1032.1853,19.7431,270.3385,1,3); //
AddStaticVehicle(416,-303.9332,1027.9954,19.7429,269.0859,1,3); //
AddStaticVehicle(416,-303.9430,1024.0089,19.7431,269.4514,1,3); //
AddStaticVehicle(597,-304.7307,1019.8320,19.3443,271.4347,3,3); //
AddStaticVehicle(597,-304.7649,1015.8474,19.3377,270.2323,3,3); //
AddStaticVehicle(597,-304.7473,1011.8291,19.3402,270.4580,3,3); //
AddStaticVehicle(597,-304.8717,1007.5831,19.3410,270.7640,3,3); //
//=============================================[ VEH BANQUE FC ]===============================================
AddStaticVehicle(428,-167.4533,1027.9438,19.8608,178.2329,0,0); //
AddStaticVehicle(428,-163.1937,1027.9580,19.8661,179.8598,0,0); //
//===========================================[ VEH INSTRUCTEUR ]=============================================
AddStaticVehicle(458,-136.1949,1075.6162,19.6264,359.9565,1,1); //
AddStaticVehicle(458,-139.7027,1075.8140,19.6247,358.8177,1,1); //
AddStaticVehicle(550,-162.0333,1075.6938,19.5629,6.8674,1,1); //
AddStaticVehicle(550,-154.9925,1079.9938,19.5677,271.0428,1,1); //
//===========================================[ VEH BUS/TAXI FC ]================================================
AddStaticVehicle(420,-215.2591,1220.9984,19.5173,180.0489,6,1); //
AddStaticVehicle(420,-218.3547,1221.0190,19.5134,179.2327,6,1); //
AddStaticVehicle(438,-221.4743,1221.3671,19.7380,182.0658,6,6); //
AddStaticVehicle(438,-224.8916,1221.3597,19.7400,183.2883,6,76); //
AddStaticVehicle(431,-234.0081,1221.7766,19.8413,91.7077,92,72); //
AddStaticVehicle(431,-250.3984,1221.4843,19.8413,91.7105,55,83); //
//=================================================[ CORBIHARS ]==============================================================
AddStaticVehicle(442,-135.9936,1122.7705,19.6510,0.3489,1,1); //
AddStaticVehicle(442,-140.6334,1116.6571,19.5789,0.5154,1,1); //
AddStaticVehicle(442,-144.1038,1116.4309,19.5780,1.3739,1,1); //
AddStaticVehicle(442,-147.5547,1116.4016,19.5765,0.7158,1,1); //
AddStaticVehicle(442,939.6618,-1086.9468,24.1220,89.1102,1,1); //
//==========================================[ DEPOT BUS/TAXI ]===============================================
CreateObject(11083, -3291.599609375, 487.3994140625, 6.8000001907349, 0, 0, 270);
CreateObject(10815, -3072.7998046875, 470.8994140625, 4, 0, 0, 44.97802734375);
CreateObject(10976, -3202, 490.2998046875, 4, 0, 0, 269.98901367188);
CreateObject(3627, -3236.5, 519.5, 7.5999999046326, 0, 0, 90);
CreateObject(3627, -3278, 519.5, 7.5999999046326, 0, 0, 90);
CreateObject(3627, -3319.5, 519.2998046875, 7.5999999046326, 0, 0, 90);
CreateObject(3627, -3361, 519.29998779297, 7.5999999046326, 0, 0, 90);
CreateObject(9623, -3214.1999511719, 471.60000610352, 6.5, 0, 0, 270);
CreateObject(3578, -3228.1000976563, 472.20001220703, 3.2000000476837, 0, 0, 0);
CreateObject(3578, -3238.1000976563, 473.20001220703, 3.2000000476837, 0, 0, 348);
CreateObject(3578, -3238.1000976563, 471.20001220703, 3.2000000476837, 0, 0, 11.997436523438);
CreateObject(3578, -3228, 480.8994140625, 3.2000000476837, 0, 0, 0);
CreateObject(3578, -3228.1000976563, 462.60000610352, 3.2000000476837, 0, 0, 0);
CreateObject(3578, -3238, 481.8994140625, 3.2000000476837, 0, 0, 347.99743652344);
CreateObject(3578, -3237.69921875, 461.69921875, 3.2000000476837, 0, 0, 11.991577148438);
CreateObject(3665, -3229.5, 471.8994140625, 1.7699999809265, 0, 0, 0);
CreateObject(3665, -3204.19921875, 472.099609375, 1.7699999809265, 0, 0, 0);
CreateObject(3578, -3217.8000488281, 472.10000610352, 2.9000000953674, 0, 0, 90);
CreateObject(3578, -3219, 472.10000610352, 2.9000000953674, 0, 0, 90);
CreateObject(3578, -3200.2998046875, 462.5, 3.2000000476837, 0, 0, 0);
CreateObject(3578, -3200.3000488281, 481, 3.2000000476837, 0, 0, 0);
CreateObject(3578, -3193.3999023438, 485.60000610352, 3.2000000476837, 0, 0, 68);
CreateObject(3578, -3193.5, 457.79998779297, 3.2000000476837, 0, 0, 291.99987792969);
CreateObject(3578, -3242.8999023438, 487.89999389648, 3.2000000476837, 0, 0, 269.99743652344);
CreateObject(3578, -3238.1999511719, 490.39999389648, 3.2000000476837, 0, 0, 151.99450683594);
CreateObject(3578, -3228.6000976563, 488, 3.2000000476837, 0, 0, 179.99450683594);
CreateObject(3578, -3218.8000488281, 490.20001220703, 3.2000000476837, 0, 0, 205.99365234375);
CreateObject(3578, -3242.5, 455.5, 3.2000000476837, 0, 0, 89.991577148438);
CreateObject(3578, -3242.6000976563, 450.70001220703, 3.2000000476837, 0, 0, 89.989013671875);
CreateObject(3578, -3247.6999511719, 474.29998779297, 3.2000000476837, 0, 0, 0);
CreateObject(3578, -3247.8999023438, 470.29998779297, 3.2000000476837, 0, 0, 0);
CreateObject(3578, -3252.3999023438, 472.29998779297, 3.2000000476837, 0, 0, 270);
CreateObject(3578, -3252.8999023438, 472.29998779297, 3.2000000476837, 0, 0, 270);
CreateObject(3578, -3249.1000976563, 472.29998779297, 3.2000000476837, 0, 0, 180);
CreateObject(11547, -3283, 472.20001220703, 6.6999998092651, 0, 0, 0);
CreateObject(3578, -3290.6999511719, 480.60000610352, 3.2000000476837, 0, 0, 179.99450683594);
CreateObject(3578, -3290.5, 475.10000610352, 3.2000000476837, 0, 0, 179.99450683594);
CreateObject(3578, -3290.3000488281, 469.60000610352, 3.2000000476837, 0, 0, 179.99450683594);
CreateObject(3578, -3290.1000976563, 464.10000610352, 3.2000000476837, 0, 0, 179.99450683594);
CreateObject(1278, -3217.1999511719, 446.10000610352, 18, 0, 0, 179.99499511719);
CreateObject(1278, -3247.5, 446.39999389648, 18, 0, 0, 179.99450683594);
CreateObject(1278, -3277, 446.20001220703, 18, 0, 0, 179.99450683594);
CreateObject(1278, -3306.8000488281, 446, 18, 0, 0, 179.99450683594);
CreateObject(1278, -3336.8000488281, 446.10000610352, 18, 0, 0, 179.99450683594);
CreateObject(1278, -3367.1000976563, 446, 18, 0, 0, 179.99450683594);
CreateObject(971, -3213.6000976563, 486.39999389648, 4.0999999046326, 0, 0, 90);
CreateObject(971, -3213.69921875, 457.099609375, 4.0999999046326, 0, 0, 90);
CreateObject(3526, -3202.6000976563, 472.20001220703, 3.7000000476837, 0, 0, 0);
CreateObject(3526, -3201.3999023438, 478.5, 3.7000000476837, 0, 0, 0);
CreateObject(3526, -3201.3000488281, 466.20001220703, 3.7000000476837, 0, 0, 0);
CreateObject(1676, -3283, 464, 5.5, 0, 0, 0);
CreateObject(1676, -3282.6999511719, 469.39999389648, 5.5, 0, 0, 0);
CreateObject(1676, -3282.3000488281, 474.70001220703, 5.5, 0, 0, 0);
CreateObject(1676, -3282.6000976563, 480.20001220703, 5.5, 0, 0, 0);
CreateObject(3627, -3367.6999511719, 456.60000610352, 7.5999999046326, 0, 0, 90);
CreateObject(3627, -3326.3999023438, 456.70001220703, 7.5999999046326, 0, 0, 90);
CreateObject(638, -3191, 455.5, 4.0999999046326, 0, 0, 0);
CreateObject(638, -3191, 458.20001220703, 4.0999999046326, 0, 0, 0);
CreateObject(638, -3191, 453, 4.0999999046326, 0, 0, 0);
CreateObject(638, -3192, 451.29998779297, 4.0999999046326, 0, 0, 270);
CreateObject(638, -3191, 483.39999389648, 4.0999999046326, 0, 0, 0);
CreateObject(638, -3191, 486.10000610352, 4.0999999046326, 0, 0, 0);
CreateObject(638, -3191, 488.29998779297, 4.0999999046326, 0, 0, 0);
CreateObject(638, -3191, 490.5, 4.0999999046326, 0, 0, 0);
CreateObject(638, -3191, 493, 4.0999999046326, 0, 0, 0);
CreateObject(638, -3191, 495.29998779297, 4.0999999046326, 0, 0, 0);
CreateObject(638, -3191, 497.79998779297, 4.0999999046326, 0, 0, 0);
CreateObject(638, -3191, 500.29998779297, 4.0999999046326, 0, 0, 0);
CreateObject(638, -3191, 502.79998779297, 4.0999999046326, 0, 0, 0);
CreateObject(638, -3191, 505.5, 4.0999999046326, 0, 0, 0);
CreateObject(638, -3191, 508, 4.0999999046326, 0, 0, 0);
CreateObject(638, -3191, 510.29998779297, 4.0999999046326, 0, 0, 0);
CreateObject(638, -3191, 513, 4.0999999046326, 0, 0, 0);
CreateObject(638, -3191, 515.5, 4.0999999046326, 0, 0, 0);
CreateObject(638, -3191, 518, 4.0999999046326, 0, 0, 0);
CreateObject(638, -3191, 520.5, 4.0999999046326, 0, 0, 0);
CreateObject(638, -3191, 523, 4.0999999046326, 0, 0, 0);
CreateObject(638, -3191, 525.79998779297, 4.0999999046326, 0, 0, 0);
CreateObject(638, -3191, 528, 4.0999999046326, 0, 0, 0);
CreateObject(638, -3194.8000488281, 451.29998779297, 4.0999999046326, 0, 0, 270);
CreateObject(638, -3197.5, 451.29998779297, 4.0999999046326, 0, 0, 270);
CreateObject(638, -3199.8000488281, 451.29998779297, 4.0999999046326, 0, 0, 270);
CreateObject(638, -3202.5, 451.29998779297, 4.0999999046326, 0, 0, 270);
CreateObject(638, -3205, 451.29998779297, 4.0999999046326, 0, 0, 270);
CreateObject(638, -3207.8000488281, 451.29998779297, 4.0999999046326, 0, 0, 270);
CreateObject(638, -3210.5, 451.29998779297, 4.0999999046326, 0, 0, 270);
CreateObject(638, -3212, 451.29998779297, 4.0999999046326, 0, 0, 270);
CreateObject(4571, -3206.6999511719, 503.70001220703, -60.5, 0, 0, 270);
CreateObject(4571, -3206.6999511719, 465.39999389648, -60.5, 0, 0, 270);
CreateObject(4571, -3245.6000976563, 465.39999389648, -60.5, 0, 0, 270);
CreateObject(4571, -3284.1999511719, 465.39999389648, -60.5, 0, 0, 270);
CreateObject(4571, -3322.8999023438, 465.39999389648, -60.5, 0, 0, 270);
CreateObject(4571, -3361.1000976563, 465.29998779297, -60.5, 0, 0, 270);
CreateObject(4571, -3380.3999023438, 465.29998779297, -60.5, 0, 0, 270);
CreateObject(11504, -3231.1000976563, 450.5, 3.5999999046326, 0, 0, 180.03698730469);
CreateObject(768, -3210.3000488281, 512.40002441406, 3.7000000476837, 0, 0, 347.52667236328);
CreateObject(769, -3209.1999511719, 524.20001220703, 3.7999999523163, 0, 0, 345.96752929688);
CreateObject(821, -3210, 514.29998779297, 4.6999998092651, 0, 0, 347.52667236328);
CreateObject(4571, -3245.1000976563, 503.70001220703, -60.5, 0, 0, 270);
CreateObject(4571, -3283.6999511719, 503.79998779297, -60.5, 0, 0, 270);
CreateObject(4571, -3322.1999511719, 503.79998779297, -60.5, 0, 0, 270);
CreateObject(4571, -3360.8000488281, 503.79998779297, -60.5, 0, 0, 270);
CreateObject(4571, -3380.3999023438, 503.79998779297, -60.5, 0, 0, 270);
CreateObject(3749, -2953.8000488281, 470.89999389648, 9.8000001907349, 0, 0, 270.48205566406);
CreateObject(3475, -2953.8000488281, 458, 6.1999998092651, 0, 0, 179.505859375);
CreateObject(3475, -2953.6999511719, 483.70001220703, 6.1999998092651, 0, 0, 1.1017456054688);
CreateObject(1422, -2953.5, 470.89999389648, 4.3000001907349, 0, 0, 0);
CreateObject(3578, -2946.8000488281, 470.89999389648, 3.2000000476837, 0, 0, 0);
CreateObject(8865, -2941.3000488281, 463, 4.1999998092651, 0, 0, 269.74301147461);
CreateObject(8865, -2941.3000488281, 478.60000610352, 4.1999998092651, 0, 0, 269.74182128906);
CreateObject(629, -2931, 462.70001220703, 4.4000000953674, 0, 0, 0);
CreateObject(629, -2937.6999511719, 463.10000610352, 4.4000000953674, 0, 0, 0);
CreateObject(629, -2946.1999511719, 463.10000610352, 4.4000000953674, 0, 0, 0);
CreateObject(629, -2946.5, 478.60000610352, 4.4000000953674, 0, 0, 0);
CreateObject(629, -2938.3000488281, 478.60000610352, 4.4000000953674, 0, 0, 0);
CreateObject(629, -2930.5, 478.60000610352, 4.4000000953674, 0, 0, 0);
CreateObject(3578, -2937.3999023438, 470.89999389648, 3.2000000476837, 0, 0, 0);
//====================================[ KART TRACK SAN FIERRO ]============================================
CreateObject(1238, -2046.0841064453, -95.50464630127, 34.469177246094, 0, 0, 0);
CreateObject(3819, -2251.1066894531, 342.64294433594, 33.79093170166, 0, 0, 0);
CreateObject(3819, -2092.6437988281, -152.38595581055, 35.318069458008, 0, 0, 179.99450683594);
CreateObject(16090, -2037.4765625, -215.9404296875, 34.327396392822, 0, 0, 270);
CreateObject(978, -2080.1496582031, -173.70678710938, 35.160533905029, 0, 0, 103.42498779297);
CreateObject(979, -2087.9501953125, -179.794921875, 35.160533905029, 0, 0, 286.48498535156);
CreateObject(973, -2089.1953125, -151.87911987305, 35.150135040283, 0, 0, 269.70983886719);
CreateObject(3819, -2092.6437988281, -160.9814453125, 35.318069458008, 0, 0, 179.99450683594);
CreateObject(3819, -2092.6435546875, -169.5859375, 35.318069458008, 0, 0, 179.99450683594);
CreateObject(3819, -2092.5583496094, -178.22421264648, 35.318069458008, 0, 0, 180.9794921875);
CreateObject(3819, -2090.1137695313, -187.10304260254, 35.318069458008, 0, 0, 209.90454101563);
CreateObject(3819, -2083.865234375, -193.82460021973, 35.318069458008, 0, 0, 235.75439453125);
CreateObject(973, -2089.2368164063, -161.240234375, 35.160533905029, 0, 0, 269.70617675781);
CreateObject(973, -2089.2646484375, -170.609375, 35.160533905029, 0, 0, 269.93957519531);
CreateObject(979, -2083.2106933594, -187.53877258301, 35.160533905029, 0, 0, 316.34985351563);
CreateObject(979, -2075.306640625, -192.0380859375, 35.160533905029, 0, 0, 344.3115234375);
CreateObject(3819, -2075.029296875, -196.58203125, 35.318069458008, 0, 0, 270);
CreateObject(3819, -2066.42578125, -196.5751953125, 35.318069458008, 0, 0, 270);
CreateObject(973, -2066.12109375, -193.298828125, 35.160533905029, 0, 0, 0);
CreateObject(978, -2075.439453125, -181.0537109375, 35.160533905029, 0, 0, 140.97106933594);
CreateObject(973, -2081.2329101563, -164.50598144531, 35.160533905029, 0, 0, 90);
CreateObject(973, -2067.1970214844, -184.00379943848, 35.160533905029, 0, 0, 180);
CreateObject(973, -2081.2351074219, -155.13694763184, 35.160533905029, 0, 0, 90);
CreateObject(973, -2081.2353515625, -145.763671875, 35.160533905029, 0, 0, 90);
CreateObject(973, -2057.8134765625, -184.0009765625, 35.160533905029, 0, 0, 179.99450683594);
CreateObject(978, -2049.0568847656, -186.43081665039, 35.160533905029, 0, 0, 148.91101074219);
CreateObject(978, -2045.0048828125 , -193.572265625, 35.160533905029, 0, 0, 90);
CreateObject(979, -2057.8334960938, -196.26661682129, 35.160533905029, 0, 0, 320.49169921875);
CreateObject(973, -2054.2683105469, -203.86598205566, 35.167613983154, 0, 0, 270);
CreateObject(973, -2045.0040283203, -202.92356872559, 35.160533905029, 0, 0, 90);
CreateObject(3819, -2057.6142578125, -204.044921875, 35.318069458008, 0, 0, 179.99450683594);
CreateObject(973, -2045.0017089844, -212.2984161377, 35.160533905029, 0, 0, 90);
CreateObject(973, -2045.005859375, -221.6882019043, 35.167613983154, 0, 0, 90);
CreateObject(973, -2045.0084228516, -231.04266357422, 35.160533905029, 0, 0, 90);
CreateObject(973, -2054.26171875, -213.2082824707, 35.160533905029, 0, 0, 270);
CreateObject(973, -2054.2690429688, -222.59310913086, 35.160533905029, 0, 0, 270);
CreateObject(973, -2054.2626953125, -231.8109588623, 35.160533905029, 0, 0, 270);
CreateObject(973, -2045.0145263672, -240.33540344238, 35.160533905029, 0, 0, 90);
CreateObject(973, -2054.2392578125, -241.052734375, 35.160533905029, 0, 0, 270);
CreateObject(979, -2057.2094726563, -249.31034851074, 35.160533905029, 0, 0, 230.75793457031);
CreateObject(979, -2064.67578125, -252.85546875, 35.160533905029, 0, 0, 179.99450683594);
CreateObject(979, -2070.5583496094, -248.43835449219, 35.160533905029, 0, 0, 106.22052001953);
CreateObject(973, -2045.0107421875, -249.67578125, 35.160533905029, 0, 0, 90);
CreateObject(978, -2047.9937744141, -259.51184082031, 35.160533905029, 0, 0, 50.634948730469);
CreateObject(978, -2055.6669921875, -263.1083984375, 35.160533905029, 0, 0, 0);
CreateObject(978, -2064.9990234375, -263.10760498047, 35.160533905029, 0, 0, 0);
CreateObject(978, -2072.1857910156, -263.10244750977, 35.160533905029, 0, 0, 0);
CreateObject(978, -2079.0539550781, -258.97055053711, 35.160533905029, 0, 0, 298.28356933594);
CreateObject(978, -2082.0769042969, -250.28393554688, 35.160533905029, 0, 0, 279.92028808594);
CreateObject(978, -2080.8083496094, -241.39576721191, 35.160533905029, 0, 0, 244.09973144531);
CreateObject(979, -2069.255859375, -240.20622253418, 35.160533905029, 0, 0, 56.365447998047);
CreateObject(973, -2076.37890625, -233.07743835449, 35.160533905029, 0, 0, 239.62976074219);
CreateObject(973, -2064.552734375, -232.15646362305, 35.167613983154, 0, 0, 62.365417480469);
CreateObject(973, -2060.5925292969, -223.87356567383, 35.167613983154, 0, 0, 66.33544921875);
CreateObject(979, -2063.6196289063, -206.74015808105, 35.160533905029, 0, 0, 130.03967285156);
CreateObject(973, -2059.6496582031, -214.95881652832, 35.160533905029, 0, 0, 101.59323120117);
CreateObject(979, -2071.3200683594, -202.91285705566, 35.160533905029, 0, 0, 177.90466308594);
CreateObject(979, -2080.7080078125, -202.72787475586, 35.160533905029, 0, 0, 179.88659667969);
CreateObject(979, -2088.708984375, -206.14054870605, 35.160533905029, 0, 0, 226.54467773438);
CreateObject(973, -2071.7263183594, -225.0242767334, 35.160533905029, 0, 0, 240.34973144531);
CreateObject(978, -2070.6120605469, -216.57460021973, 35.160533905029, 0, 0, 284.99060058594);
CreateObject(978, -2076.3046875, -212.17384338379, 35.160533905029, 0, 0, 0.733642578125);
CreateObject(978, -2081.7863769531, -216.67001342773, 35.160533905029, 0, 0, 78.460510253906);
CreateObject(973, -2045.0104980469, -251.23417663574, 35.155506134033, 0, 0, 90);
CreateObject(979, -2092.2153320313, -214.09358215332, 35.160533905029, 0, 0, 266.28881835938);
CreateObject(973, -2092.6823730469, -223.44589233398, 35.160533905029, 0, 0, 267.90270996094);
CreateObject(973, -2093.0317382813, -232.80432128906, 35.160533905029, 0, 0, 267.90161132813);
CreateObject(973, -2093.3681640625, -242.16293334961, 35.160533905029, 0, 0, 267.90161132813);
CreateObject(973, -2093.5375976563, -251.53363037109, 35.160533905029, 0, 0, 269.88659667969);
CreateObject(973, -2083.3562011719, -225.84330749512, 35.160533905029, 0, 0, 82.213928222656);
CreateObject(973, -2084.4587402344, -235.13888549805, 35.160533905029, 0, 0, 84.195678710938);
CreateObject(973, -2085.2536621094, -244.41368103027, 35.160533905029, 0, 0, 86.1787109375);
CreateObject(973, -2085.556640625, -253.72491455078, 35.160533905029, 0, 0, 90.146759033203);
CreateObject(973, -2093.5590820313, -260.87576293945, 35.160533905029, 0, 0, 269.88464355469);
CreateObject(979, -2091.3671875, -269.73071289063, 35.160533905029, 0, 0, 298.04638671875);
CreateObject(979, -2085.13671875, -276.1875, 35.160533905029, 0, 0, 329.89196777344);
CreateObject(978, -2083.5822753906, -262.59515380859, 35.160533905029, 0, 0, 114.39541625977);
CreateObject(978, -2077.2817382813, -268.19348144531, 35.160533905029, 0, 0, 162.17004394531);
CreateObject(973, -2076.5207519531, -279.04452514648, 35.160533905029, 0, 0, 353.65954589844);
CreateObject(973, -2067.1765136719, -279.59265136719, 35.160533905029, 0, 0, 359.6103515625);
CreateObject(973, -2068.1613769531, -269.64324951172, 35.160533905029, 0, 0, 180);
CreateObject(973, -2058.869140625, -269.6337890625, 35.167613983154, 0, 0, 179.99450683594);
CreateObject(973, -2057.869140625, -279.6484375, 35.167613983154, 0, 0, 0);
CreateObject(3819, -2057.7451171875, -230.533203125, 35.318069458008, 0, 0, 179.99450683594);
CreateObject(3819, -2057.7451171875, -239.1346282959, 35.318069458008, 0, 0, 179.99450683594);
CreateObject(3819, -2064.1735839844, -248.15141296387, 35.318069458008, 0, 0, 89.544616699219);
CreateObject(986, -2053.0600585938, -102.24409484863, 35.944217681885, 0, 0, 0);
CreateObject(986, -2041.2807617188, -102.24409484863, 35.944217681885, 0, 0, 0);
CreateObject(996, -2035.8623046875, -102.4990234375, 38.799369812012, 0, 0, 0);
CreateObject(996, -2027.265625, -102.4990234375, 38.851364135742, 0, 0, 0);
CreateObject(10244, -2051.654296875, -104.3662109375, 34.585273742676, 0, 0, 0);
CreateObject(10244, -2042.7109375, -100.17578125, 34.585273742676, 0, 0, 180.53833007813);
CreateObject(1686, -2018.5810546875, -248.8017578125, 34.226722717285, 0, 0, 270);
CreateObject(1340, -2061.7348632813, -238.5054473877, 35.447898864746, 0, 0, 272.33032226563);
CreateObject(1341, -2064.1616210938, -239.35604858398, 35.322898864746, 0, 0, 310.3603515625);
CreateObject(1342, -2067.1342773438, -243.9041595459, 35.333209991455, 0, 0, 359);
CreateObject(1775, -2065.76171875, -240.5439453125, 35.417350769043, 0, 0, 47.334594726563);
CreateObject(1776, -2066.5473632813, -241.58100891113, 35.419704437256, 0, 0, 59.820007324219);
CreateObject(1549, -2060.365234375, -243.2052154541, 34.278717041016, 0, 0, 17.539672851563);
CreateObject(1549, -2062.6723632813, -245.20199584961, 34.278717041016, 0, 0, 85.254638671875);
CreateObject(1549, -2090.6950683594, -147.88726806641, 34.278717041016, 0, 0, 271.08972167969);
CreateObject(974, -2015.15625, -252.97398376465, 35.172554016113, 0, 0, 0);
CreateObject(973, -2048.5283203125, -279.63949584961, 35.167613983154, 0, 0, 0);
CreateObject(973, -2039.2081298828, -279.64111328125, 35.160533905029, 0, 0, 0);
CreateObject(973, -2029.8748779297, -279.63073730469, 35.167613983154, 0, 0, 0);
CreateObject(979, -2022.1809082031, -275.99362182617, 35.160533905029, 0, 0, 50.446899414063);
CreateObject(973, -2019.1885986328, -267.68786621094, 35.167613983154, 0, 0, 90);
CreateObject(973, -2019.1977539063, -258.31625366211, 35.160533905029, 0, 0, 90);
CreateObject(974, -2015.1190185547, -244.92338562012, 35.172554016113, 0, 0, 0);
CreateObject(974, -2015.1181640625, -236.203125, 35.172554016113, 0, 0, 0);
CreateObject(1686, -2018.5810546875, -240.583984375, 34.3203125, 0, 0, 270);
CreateObject(978, -2050.4189453125, -267.01907348633, 35.160533905029, 0, 0, 214.51049804688);
CreateObject(978, -2045.0133056641, -260.03500366211, 35.160533905029, 0, 0, 250.32806396484);
CreateObject(973, -2043.4411621094, -251.04919433594, 35.160533905029, 0, 0, 270);
CreateObject(979, -2042.5545654297, -272.04541015625, 35.160533905029, 0, 0, 37.696960449219);
CreateObject(979, -2036.5341796875, -265.0068359375, 35.160533905029, 0, 0, 61.600341796875);
CreateObject(973, -2034.3427734375, -256.18359375, 35.160533905029, 0, 0, 90);
CreateObject(973, -2041.6729736328, -274.43292236328, 35.160533905029, 0, 0, 183.21997070313);
CreateObject(973, -2035.0979003906, -274.18319702148, 35.160533905029, 0, 0, 179.99450683594);
CreateObject(978, -2027.7360839844, -270.50805664063, 35.167613983154, 0, 0, 232.4609375);
CreateObject(973, -2024.9451904297, -262.13171386719, 35.160533905029, 0, 0, 270);
CreateObject(973, -2026.060546875, -252.990234375, 35.160533905029, 0, 0, 283.89221191406);
CreateObject(973, -2027.1878662109, -243.7590637207, 35.160533905029, 0, 0, 270);
CreateObject(973, -2034.3399658203, -246.86889648438, 35.160533905029, 0, 0, 90);
CreateObject(973, -2034.337890625, -237.5751953125, 35.167613983154, 0, 0, 90);
CreateObject(973, -2034.3392333984, -228.2802734375, 35.160533905029, 0, 0, 90);
CreateObject(973, -2034.3453369141, -218.98886108398, 35.160533905029, 0, 0, 90);
CreateObject(973, -2034.3482666016, -209.64881896973, 35.160533905029, 0, 0, 90);
CreateObject(973, -2043.4451904297, -241.8180847168, 35.160533905029, 0, 0, 270);
CreateObject(973, -2043.4464111328, -232.48715209961, 35.160533905029, 0, 0, 270);
CreateObject(973, -2043.4508056641, -223.1508026123, 35.167613983154, 0, 0, 270);
CreateObject(973, -2043.4427490234, -213.83877563477, 35.160533905029, 0, 0, 270);
CreateObject(973, -2043.4296875, -204.4970703125, 35.160533905029, 0, 0, 270);
CreateObject(1775, -2030.6938476563, -214.40029907227, 35.402046203613, 0, 0, 179.99450683594);
CreateObject(973, -2027.1796875, -234.4677734375, 35.167613983154, 0, 0, 270);
CreateObject(973, -2027.1879882813, -225.16253662109, 35.160533905029, 0, 0, 270);
CreateObject(973, -2027.1884765625, -215.8271484375, 35.160533905029, 0, 0, 270);
CreateObject(973, -2027.2042236328, -206.56443786621, 35.160533905029, 0, 0, 270);
CreateObject(973, -2034.3486328125, -200.33984375, 35.160533905029, 0, 0, 90);
CreateObject(973, -2043.4373779297, -195.14625549316, 35.160533905029, 0, 0, 270);
CreateObject(973, -2043.4400634766, -193.17379760742, 35.160846710205, 0, 0, 270);
CreateObject(978, -2047.3315429688, -186.18251037598, 35.160533905029, 0, 0, 327.875);
CreateObject(978, -2049.2790527344, -184.96621704102, 35.160533905029, 0, 0, 327.87048339844);
CreateObject(973, -2057.8264160156, -182.49040222168, 35.160533905029, 0, 0, 0);
CreateObject(973, -2065.46875, -182.50096130371, 35.160533905029, 0, 0, 0);
CreateObject(978, -2073.7724609375, -179.69998168945, 35.160533905029, 0, 0, 321.91552734375);
CreateObject(978, -2078.6159667969, -172.26071166992, 35.160533905029, 0, 0, 284.06042480469);
CreateObject(979, -2034.3381347656, -190.99078369141, 35.160533905029, 0, 0, 90);
CreateObject(979, -2034.3394775391, -186.07501220703, 35.160533905029, 0, 0, 90);
CreateObject(979, -2038.2067871094, -178.82388305664, 35.160533905029, 0, 0, 147.56478881836);
CreateObject(979, -2046.515625, -174.68977355957, 35.160533905029, 0, 0, 159.51782226563);
CreateObject(973, -2055.5927734375, -173.05572509766, 35.160533905029, 0, 0, 180);
CreateObject(973, -2061.6828613281, -173.05796813965, 35.160533905029, 0, 0, 179.99450683594);
CreateObject(979, -2068.1125488281, -168.85353088379, 35.160533905029, 0, 0, 113.72607421875);
CreateObject(973, -2069.9765625, -160.02435302734, 35.160533905029, 0, 0, 90);
CreateObject(973, -2079.744140625, -163.02374267578, 35.160533905029, 0, 0, 270);
CreateObject(973, -2079.7407226563, -153.70611572266, 35.160533905029, 0, 0, 270);
CreateObject(978, -2075.4243164063, -147.19174194336, 35.160533905029, 0, 0, 202.31213378906);
CreateObject(979, -2065.55078125, -154.35746765137, 35.160533905029, 0, 0, 14.024963378906);
CreateObject(978, -2066.5415039063, -144.40151977539, 35.160533905029, 0, 0, 192.24755859375);
CreateObject(973, -2056.3920898438, -153.24848937988, 35.160533905029, 0, 0, 0);
CreateObject(973, -2057.2724609375, -143.41342163086, 35.167613983154, 0, 0, 180);
CreateObject(973, -2047.9879150391, -143.3995513916, 35.160533905029, 0, 0, 179.99450683594);
CreateObject(973, -2047.2352294922, -153.21180725098, 35.167613983154, 0, 0, 0);
CreateObject(979, -2038.2019042969, -151.35618591309, 35.160533905029, 0, 0, 23.948974609375);
CreateObject(979, -2036.2117919922, -150.45748901367, 35.145107269287, 0, 0, 23.948974609375);
CreateObject(979, -2031.8342285156, -143.80635070801, 35.160533905029, 0, 0, 88.759674072266);
CreateObject(973, -2047.9697265625, -142.84631347656, 35.160533905029, 0, 0, 0);
CreateObject(973, -2057.3322753906, -142.83615112305, 35.167613983154, 0, 0, 0);
CreateObject(979, -2031.7618408203, -141.42503356934, 35.155506134033, 0, 0, 88.758544921875);
CreateObject(979, -2035.9965820313, -135.0206451416, 35.139549255371, 0, 0, 158.54858398438);
CreateObject(973, -2045.0631103516, -133.29022216797, 35.126430511475, 0, 0, 179.99450683594);
CreateObject(973, -2066.6162109375, -142.02243041992, 35.167613983154, 0, 0, 350.0299987793);
CreateObject(978, -2075.8771972656, -141.26637268066, 35.170932769775, 0, 0, 0.7039794921875);
CreateObject(978, -2076.7390136719, -141.26995849609, 35.167770385742, 0, 0, 0.703125);
CreateObject(979, -2090.0412597656, -142.6841583252, 35.160533905029, 0, 0, 280.53002929688);
CreateObject(979, -2087.8664550781, -134.53678894043, 35.160533905029, 0, 0, 228.69165039063);
CreateObject(979, -2080.2912597656, -129.47225952148, 35.167613983154, 0, 0, 198.78149414063);
CreateObject(979, -2071.1162109375, -127.98352813721, 35.167263031006, 0, 0, 180);
CreateObject(973, -2061.7998046875, -127.98163604736, 35.167263031006, 0, 0, 179.99450683594);
CreateObject(973, -2052.4138183594, -127.96935272217, 35.140048980713, 0, 0, 179.99450683594);
CreateObject(973, -2043.1209716797, -127.97492980957, 35.098579406738, 0, 0, 179.99450683594);
CreateObject(979, -2033.8493652344, -128.94284057617, 35.079524993896, 0, 0, 168.08459472656);
CreateObject(979, -2026.0494384766, -133.27352905273, 35.115016937256, 0, 0, 134.19995117188);
CreateObject(979, -2022.9450683594, -141.32682800293, 35.129100799561, 0, 0, 88.408111572266);
CreateObject(973, -2031.3134765625, -153.12322998047, 35.160533905029, 0, 0, 279.92492675781);
CreateObject(973, -2029.7274169922, -162.23233032227, 35.167613983154, 0, 0, 279.92065429688);
CreateObject(973, -2028.6116943359, -171.44410705566, 35.160533905029, 0, 0, 273.96569824219);
CreateObject(973, -2027.9801025391, -180.75221252441, 35.160533905029, 0, 0, 273.96057128906);
CreateObject(973, -2027.5042724609, -190.10546875, 35.160533905029, 0, 0, 271.9755859375);
CreateObject(973, -2027.2877197266, -198.06646728516, 35.160533905029, 0, 0, 270.98706054688);
CreateObject(974, -2015.1181640625, -228.38108825684, 35.172554016113, 0, 0, 0);
CreateObject(1686, -2018.5810546875, -232.35255432129, 34.3203125, 0, 0, 270);
CreateObject(974, -2015.1181640625, -220.16091918945, 35.172554016113, 0, 0, 0);
CreateObject(974, -2015.1181640625, -212.29931640625, 35.172554016113, 0, 0, 0);
CreateObject(974, -2015.1181640625, -204.19747924805, 35.172554016113, 0, 0, 0);
CreateObject(974, -2015.1181640625, -196.19813537598, 35.172554016113, 0, 0, 0);
CreateObject(974, -2015.1181640625, -188.18048095703, 35.172554016113, 0, 0, 0);
CreateObject(974, -2015.1181640625, -180.30386352539, 35.172554016113, 0, 0, 0);
CreateObject(974, -2015.1181640625, -172.29684448242, 35.172554016113, 0, 0, 0);
CreateObject(1686, -2018.5836181641, -224.33686828613, 34.3203125, 0, 0, 270);
CreateObject(1686, -2018.5805664063, -216.26612854004, 34.3203125, 0, 0, 270);
CreateObject(1686, -2018.5810546875, -208.2788848877, 34.3203125, 0, 0, 270);
CreateObject(1686, -2018.5810546875, -200.12890625, 34.3203125, 0, 0, 270);
CreateObject(1686, -2018.5810546875, -192.18502807617, 34.3203125, 0, 0, 270);
CreateObject(1686, -2018.5810546875, -184.22436523438, 34.3203125, 0, 0, 270);
CreateObject(1686, -2018.5808105469, -176.3837890625, 34.3203125, 0, 0, 270);
CreateObject(973, -2022.5554199219, -150.64413452148, 35.129337310791, 0, 0, 96.485778808594);
CreateObject(973, -2021.5070800781, -159.96617126465, 35.160533905029, 0, 0, 96.48193359375);
CreateObject(973, -2021.0074462891, -164.37422180176, 35.158256530762, 0, 0, 96.48193359375);
CreateObject(3819, -2030.4501953125, -207.671875, 35.318069458008, 0, 0, 0);
CreateObject(3819, -2030.4503173828, -199.08949279785, 35.318069458008, 0, 0, 0);
CreateObject(3819, -2030.4503173828, -190.45697021484, 35.318069458008, 0, 0, 0);
CreateObject(3819, -2030.4501953125, -222.59866333008, 35.318069458008, 0, 0, 0);
CreateObject(3819, -2030.4501953125, -231.20738220215, 35.325149536133, 0, 0, 0);
CreateObject(3819, -2030.4501953125, -239.81748962402, 35.318069458008, 0, 0, 0);
CreateObject(3819, -2030.4501953125, -248.45138549805, 35.318069458008, 0, 0, 0);
CreateObject(3819, -2030.4501953125, -257.08245849609, 35.318069458008, 0, 0, 0);
CreateObject(3819, -2032.6331787109, -266.00765991211, 35.318069458008, 0, 0, 332.57507324219);
CreateObject(985, -2061.1552734375, -112.2021484375, 36.022815704346, 0, 0, 0);
CreateObject(985, -2071.5241699219, -112.24295043945, 36.028095245361, 0, 0, 0);
CreateObject(985, -2079.3564453125, -112.2470703125, 36.028289794922, 0, 0, 0);
CreateObject(985, -2090.6818847656, -112.1661529541, 36.017890930176, 0, 0, 0);
CreateObject(985, -2092.7219238281, -112.1658706665, 36.031105041504, 0, 0, 0);
CreateObject(985, -2053.2822265625, -112.197265625, 35.974239349365, 0, 0, 0);
CreateObject(985, -2045.4052734375, -112.1923828125, 35.938991546631, 0, 0, 0);
CreateObject(985, -2040.9208984375, -112.193359375, 35.87092590332, 0, 0, 0);
CreateObject(985, -2036.9467773438, -108.24278259277, 35.970989227295, 0, 0, 89.730041503906);
CreateObject(985, -2036.9426269531, -106.28773498535, 35.986003875732, 0, 0, 89.725341796875);
CreateObject(11095, -2043.6020507813, -135.65841674805, 39.469619750977, 0, 0, 328.73474121094);
CreateObject(3819, -2037.6589355469, -155.6851348877, 35.318069458008, 0, 0, 293.63439941406);
CreateObject(3819, -2046.5477294922, -157.6043548584, 35.318069458008, 0, 0, 270);
CreateObject(3819, -2043.8483886719, -171.12899780273, 35.219879150391, 0, 0, 68.254699707031);
CreateObject(3819, -2035.9471435547, -175.27577209473, 35.318069458008, 0, 0, 56.342651367188);
CreateObject(985, -2064.6665039063, -112.23699951172, 36.015068054199, 0, 0, 0);
CreateObject(985, -2081.5910644531, -116.17472839355, 36.039543151855, 0, 0, 90);
CreateObject(985, -2081.5930175781, -124.02085113525, 36.039543151855, 0, 0, 90);
CreateObject(985, -2081.5932617188, -126.08197784424, 36.02046585083, 0, 0, 90);
CreateObject(10244, -2017.0480957031, -120.3440322876, 34.559730529785, 0, 0, 90);
CreateObject(996, -2036.8450927734, -119.43030548096, 38.799369812012, 0, 0, 90);
CreateObject(996, -2029.1896972656, -120.02572631836, 38.799369812012, 0, 0, 180);
CreateObject(996, -2020.4650878906, -120.02572631836, 38.815185546875, 0, 0, 180);
CreateObject(996, -2019.2923583984, -105.48175811768, 38.851364135742, 0, 0, 270);
CreateObject(3819, -2071.7451171875, -123.89890289307, 35.327709197998, 0, 0, 90);
CreateObject(3819, -2063.1433105469, -123.89890289307, 35.324100494385, 0, 0, 90);
CreateObject(3819, -2054.5493164063, -123.89890289307, 35.298915863037, 0, 0, 90);
CreateObject(3819, -2045.8742675781, -123.89890289307, 35.249332427979, 0, 0, 90);
CreateObject(1262, -2041.0197753906, -216.86293029785, 41.797954559326, 0, 0, 180.69299316406);
CreateObject(1262, -2039.822265625, -216.8444519043, 41.809562683105, 0, 0, 180.69213867188);
CreateObject(1262, -2038.6472167969, -216.85852050781, 41.797954559326, 0, 0, 180.69213867188);
CreateObject(1262, -2037.5119628906, -216.8602142334, 41.798305511475, 0, 0, 180.69213867188);
CreateObject(1262, -2036.3959960938, -216.84425354004, 41.789115905762, 0, 0, 180.69213867188);
CreateObject(2930, -2088.1059570313, -112.23552703857, 37.353179931641, 0, 0, 89.730041503906);
CreateObject(985, -2081.0886230469, -112.24256896973, 36.028717041016, 0, 0, 0);
CreateObject(983, -2067.1098632813, -80.322204589844, 34.847618103027, 0, 0, 90);
CreateObject(984, -2030.4879150391, -80.543190002441, 35.456993103027, 0, 0, 90);
CreateObject(982, -2083.0935058594, -80.318542480469, 34.847618103027, 0, 0, 90);
CreateObject(983, -2062.2683105469, -83.533866882324, 34.847618103027, 0, 0, 180);
CreateObject(983, -2065.4951171875, -80.318542480469, 34.847618103027, 0, 0, 90);
CreateObject(983, -2020.859375, -80.543190002441, 35.503868103027, 0, 0, 90);
CreateObject(983, -2017.48046875, -83.750518798828, 35.503868103027, 0, 0, 0);
CreateObject(983, -2036.9140625, -83.76180267334, 35.503868103027, 0, 0, 0);
CreateObject(983, -2020.6688232422, -80.543190002441, 35.503868103027, 0, 0, 90);
CreateObject(618, -2020.7136230469, -84.316535949707, 34.016479492188, 0, 0, 0);
CreateObject(615, -2033.2482910156, -83.806022644043, 34.151664733887, 0, 0, 0);
CreateObject(1238, -2047.8096923828, -96.49479675293, 34.469181060791, 0, 0, 0);
CreateObject(1238, -2041.6557617188, -90.897315979004, 34.469181060791, 0, 0, 0);
CreateObject(1238, -2042.9002685547, -92.747909545898, 34.479579925537, 0, 0, 0);
CreateObject(1238, -2044.4523925781, -94.251518249512, 34.458782196045, 0, 0, 0);
CreateObject(1238, -2049.5458984375, -97.195625305176, 34.469177246094, 0, 0, 0);
//========================================[HELIPORT]====================================================//
CreateObject(9241,-2245.60009766,-2272.30004883,31.39999962,0.00000000,0.00000000,142.00000000); //object(copbits_sfn)(2)
//===========================================[ PORT ANGEL PINE]========================================//
CreateObject(6189,-2780.10009766,-2227.00000000,-11.39999962,0.00000000,0.00000000,36.00000000); //object(gaz_pier1) (1)
CreateObject(6300,-2839.79980469,-2141.50000000,-4.90000010,0.00000000,0.00000000,35.99670410); //object(pier04_law2) (1)
CreateObject(12990,-2788.00000000,-2254.39990234,1.79999995,0.00000000,0.00000000,306.00000000); //object(sw_jetty) (1)
CreateObject(12990,-2800.30004883,-2237.50000000,1.79999995,0.00000000,0.00000000,305.99670410); //object(sw_jetty) (2)
CreateObject(5184,-2684.00000000,-2221.79980469,23.00000000,0.00000000,0.00000000,215.99670410); //object(mdock1a_las2) (1)
CreateObject(3620,-2663.00000000,-2193.00000000,17.10000038,0.00000000,0.00000000,216.00000000); //object(redockrane_las) (1)
CreateObject(3620,-2679.00000000,-2204.69921875,17.10000038,0.00000000,0.00000000,215.99670410); //object(redockrane_las) (2)
CreateObject(3620,-2695.39990234,-2217.39990234,17.10000038,0.00000000,0.00000000,215.99670410); //object(redockrane_las) (3)
CreateObject(3578,-2744.19995117,-2247.10009766,4.80000019,0.00000000,0.00000000,306.00000000); //object(dockbarr1_la) (2)
CreateObject(3578,-2738.00000000,-2255.59960938,4.80000019,0.00000000,0.00000000,305.99121094); //object(dockbarr1_la) (3)
CreateObject(8073,-2675.50000000,-2246.80004883,9.00000000,0.00000000,0.00000000,36.00000000); //object(vgsfrates02) (1)
CreateObject(8886,-2666.89990234,-2204.50000000,7.40000010,0.00000000,0.00000000,306.00000000); //object(vgsefrght04) (1)
CreateObject(2934,-2663.80004883,-2192.89990234,5.50000000,0.00000000,0.00000000,0.00000000); //object(kmb_container_red) (1)
CreateObject(2935,-2677.00000000,-2204.19995117,5.50000000,0.00000000,0.00000000,30.00000000); //object(kmb_container_yel) (1)
CreateObject(3043,-2682.60009766,-2215.00000000,5.50000000,0.00000000,0.00000000,216.00000000); //object(kmb_container_open) (1)
CreateObject(3268,-2716.69995117,-2238.60009766,4.00000000,0.00000000,0.00000000,306.00000000); //object(mil_hangar1_) (1)
CreateObject(3383,-2710.89990234,-2226.10009766,4.00000000,0.00000000,0.00000000,126.00000000); //object(a51_labtable1_) (1)
CreateObject(3383,-2706.69921875,-2231.39941406,4.00000000,0.00000000,0.00000000,125.99121094); //object(a51_labtable1_) (2)
CreateObject(1599,-2711.60009766,-2224.69995117,5.19999981,0.00000000,100.00000000,358.00000000); //object(fish1single) (1)
CreateObject(953,-2710.89990234,-2226.10009766,5.30000019,0.00000000,0.00000000,0.00000000); //object(cj_oyster) (1)
CreateObject(2782,-2710.50000000,-2227.10009766,5.30000019,0.00000000,0.00000000,290.00000000); //object(cj_oyster_2) (1)
CreateObject(6283,-2830.19921875,-2157.09960938,8.19999981,0.00000000,0.00000000,35.99670410); //object(pier04b_law2) (1)
CreateObject(11495,-2877.29980469,-2108.39941406,2.00000000,4.99877930,0.00000000,215.99670410); //object(des_ranchjetty) (2)
CreateObject(11495,-2875.89990234,-2107.39990234,2.00000000,355.00000000,0.00000000,35.99670410); //object(des_ranchjetty) (3)
CreateObject(4133,-2901.59960938,-2161.69921875,2.00000000,358.99475098,0.00000000,291.99462891); //object(gsfreeway8_lan) (1)
CreateObject(5184,-2921.39941406,-2172.00000000,21.29999924,0.00000000,0.00000000,305.99121094); //object(mdock1a_las2) (2)
CreateObject(12990,-2812.50000000,-2220.10009766,1.79999995,0.00000000,0.00000000,305.99670410); //object(sw_jetty) (5)
CreateObject(12990,-2824.39990234,-2203.39990234,1.79999995,0.00000000,0.00000000,305.99670410); //object(sw_jetty) (6)
CreateObject(12990,-2751.60009766,-2228.00000000,1.79999995,0.00000000,0.00000000,125.99670410); //object(sw_jetty) (7)
CreateObject(12990,-2763.60009766,-2211.60009766,1.79999995,0.00000000,0.00000000,125.99121094); //object(sw_jetty) (8)
CreateObject(12990,-2777.10009766,-2193.30004883,1.79999995,0.00000000,0.00000000,125.99121094); //object(sw_jetty) (9)
CreateObject(12990,-2789.10009766,-2176.39990234,1.79999995,0.00000000,0.00000000,125.99121094); //object(sw_jetty) (10)
CreateObject(6417,-2858.00000000,-2320.50000000,-13.10000038,0.00000000,0.00000000,254.00000000); //object(lawborder2c_law2) (1)
CreateObject(6417,-2880.80004883,-2405.69995117,-13.10000038,0.00000000,0.00000000,253.99841309); //object(lawborder2c_law2) (2)
CreateObject(6417,-2790.39990234,-2297.10009766,-14.39999962,0.00000000,0.00000000,319.99841309); //object(lawborder2c_law2) (3)
CreateObject(6417,-2828.39990234,-2383.80004883,-14.39999962,0.00000000,0.00000000,349.99328613); //object(lawborder2c_law2) (5)
CreateObject(3749,-2450.69995117,-2245.19995117,23.39999962,0.00000000,0.00000000,38.00000000); //object(clubgate01_lax) (1)
p1=CreateObject(968,-2455.10009766,-2248.69995117,18.70000076,1.00000000,90.00000000,37.00000000); //object(barrierturn) (3)
CreateObject(2973,-2719.10009766,-2243.00000000,4.09999990,0.00000000,0.00000000,36.00000000); //object(k_cargo2) (1)
CreateObject(2973,-2716.80004883,-2241.10009766,4.09999990,0.00000000,0.00000000,35.99670410); //object(k_cargo2) (2)
CreateObject(1600,-2717.10009766,-2239.69995117,6.00000000,0.00000000,0.00000000,0.00000000); //object(fish2single) (1)
CreateObject(1601,-2717.60009766,-2240.10009766,5.80000019,0.00000000,0.00000000,0.00000000); //object(fish3s) (1)
CreateObject(1600,-2717.50000000,-2240.10009766,6.00000000,0.00000000,0.00000000,0.00000000); //object(fish2single) (2)
CreateObject(1604,-2717.89990234,-2240.30004883,5.00000000,0.00000000,0.00000000,0.00000000); //object(fish3single) (1)
CreateObject(1604,-2719.89990234,-2242.00000000,5.80000019,0.00000000,0.00000000,0.00000000); //object(fish3single) (2)
CreateObject(1600,-2719.39990234,-2241.60009766,5.00000000,0.00000000,0.00000000,0.00000000); //object(fish2single) (3)
CreateObject(1599,-2719.39990234,-2241.60009766,5.30000019,0.00000000,0.00000000,0.00000000); //object(fish1single) (2)
CreateObject(953,-2719.30004883,-2240.00000000,4.40000010,0.00000000,0.00000000,0.00000000); //object(cj_oyster) (2)
CreateObject(953,-2717.10009766,-2240.80004883,6.90000010,0.00000000,0.00000000,0.00000000); //object(cj_oyster) (3)
CreateObject(1604,-2720.39990234,-2242.30004883,5.40000010,0.00000000,0.00000000,0.00000000); //object(fish3single) (3)
CreateObject(1602,-2719.30004883,-2241.60009766,6.80000019,0.00000000,0.00000000,0.00000000); //object(jellyfish) (1)
CreateObject(1600,-2720.30004883,-2242.30004883,6.40000010,0.00000000,0.00000000,0.00000000); //object(fish2single) (4)
CreateObject(953,-2707.30004883,-2229.89990234,5.30000019,0.00000000,0.00000000,0.00000000); //object(cj_oyster) (4)
CreateObject(2782,-2706.00000000,-2232.50000000,5.30000019,0.00000000,0.00000000,0.00000000); //object(cj_oyster_2) (2)
CreateObject(1600,-2706.60009766,-2231.80004883,5.09999990,0.00000000,0.00000000,0.00000000); //object(fish2single) (5)
CreateObject(1599,-2707.10009766,-2230.80004883,5.19999981,0.00000000,0.00000000,0.00000000); //object(fish1single) (3)
CreateObject(6295,-2706.10009766,-2275.19995117,40.40000153,0.00000000,0.00000000,148.00000000); //object(sanpedlithus_law2) (1)
CreateObject(3749,-2536.30004883,-2363.19995117,19.79999924,0.00000000,0.00000000,3.99621582); //object(clubgate01_lax) (2)
p3=CreateObject(968,-2530.69995117,-2362.89990234,15.19999981,0.00000000,270.00000000,2.00000000);
CreateObject(5837,-2448.39990234,-2242.39990234,19.20000076,0.00000000,350.00000000,128.00000000); //object(ci_guardhouse1) (1)
CreateObject(5837,-2539.89990234,-2363.89990234,15.50000000,0.00000000,0.00000000,274.00000000); //object(ci_guardhouse1) (2)
CreateObject(8042,-2614.69995117,-2313.50000000,16.10000038,0.00000000,0.00000000,344.00000000); //object(apbarriergate07_lvs) (2)
CreateObject(8040,-2673.50000000,-2373.10009766,3.20000005,0.00000000,0.00000000,82.00000000); //object(airprtcrprk02_lvs) (1)
CreateObject(3276,-2613.80004883,-2303.89990234,9.30000019,0.00000000,0.00000000,334.00000000); //object(cxreffencesld) (1)
CreateObject(996,-2693.80004883,-2330.80004883,4.40000010,0.00000000,5.00000000,0.00000000); //object(lhouse_barrier1) (1)
CreateObject(996,-2702.00000000,-2330.69995117,5.19999981,0.00000000,4.99877930,0.00000000); //object(lhouse_barrier1) (2)
CreateObject(3276,-2624.00000000,-2300.30004883,9.30000019,0.00000000,355.00000000,347.99536133); //object(cxreffencesld) (2)
CreateObject(3276,-2635.39990234,-2299.60009766,8.10000038,0.00000000,354.99572754,3.99194336); //object(cxreffencesld) (3)
CreateObject(3276,-2656.89990234,-2305.19995117,4.40000010,0.00000000,354.99023438,29.98803711); //object(cxreffencesld) (4)
CreateObject(3276,-2665.60009766,-2312.30004883,3.90000010,0.00000000,0.00000000,47.98718262); //object(cxreffencesld) (5)
CreateObject(996,-2710.30004883,-2330.80004883,5.90000010,0.00000000,4.99877930,0.00000000); //object(lhouse_barrier1) (3)
CreateObject(996,-2718.50000000,-2329.19995117,6.59999990,0.00000000,4.99877930,348.00000000); //object(lhouse_barrier1) (4)
CreateObject(997,-2721.89990234,-2327.39990234,6.80000019,0.00000000,6.00000000,330.00000000); //object(lhouse_barrier3) (1)
CreateObject(996,-2727.89990234,-2322.69995117,6.90000010,0.00000000,355.00000000,321.99743652); //object(lhouse_barrier1) (5)
CreateObject(996,-2733.60009766,-2316.89990234,6.69999981,0.00000000,0.00000000,313.99279785); //object(lhouse_barrier1) (6)
CreateObject(996,-2738.69995117,-2310.50000000,6.69999981,0.00000000,0.00000000,307.98925781); //object(lhouse_barrier1) (7)
CreateObject(996,-2743.89990234,-2303.80004883,6.69999981,0.00000000,0.00000000,307.98522949); //object(lhouse_barrier1) (8)
CreateObject(996,-2748.89990234,-2297.19995117,6.50000000,0.00000000,0.00000000,307.98522949); //object(lhouse_barrier1) (9)
CreateObject(996,-2753.89990234,-2290.80004883,5.80000019,0.00000000,0.00000000,307.98522949); //object(lhouse_barrier1) (10)
CreateObject(996,-2758.89990234,-2284.19995117,5.00000000,0.00000000,355.00000000,307.98522949); //object(lhouse_barrier1) (11)
CreateObject(996,-2764.00000000,-2277.80004883,4.30000019,0.00000000,354.99572754,307.97973633); //object(lhouse_barrier1) (12)
CreateObject(996,-2678.30004883,-2321.80004883,3.20000005,0.00000000,4.99877930,0.00000000); //object(lhouse_barrier1) (13)
CreateObject(996,-2686.50000000,-2322.19995117,3.90000010,0.00000000,4.99877930,4.00000000); //object(lhouse_barrier1) (14)
CreateObject(996,-2694.80004883,-2322.39990234,4.40000010,0.00000000,4.99328613,1.99902344); //object(lhouse_barrier1) (15)
CreateObject(996,-2703.10009766,-2322.69995117,5.19999981,0.00000000,4.98779297,1.99401855); //object(lhouse_barrier1) (16)
CreateObject(996,-2711.19995117,-2322.89990234,5.90000010,0.00000000,4.98779297,1.99401855); //object(lhouse_barrier1) (17)
CreateObject(996,-2719.39990234,-2323.19995117,6.69999981,0.00000000,4.98779297,1.99401855); //object(lhouse_barrier1) (18)
CreateObject(996,-2718.19995117,-2316.10009766,8.80000019,0.00000000,15.00000000,253.99401855); //object(lhouse_barrier1) (19)
CreateObject(996,-2716.00000000,-2308.50000000,11.00000000,0.00000000,14.99633789,253.99291992); //object(lhouse_barrier1) (20)
CreateObject(996,-2713.69995117,-2300.80004883,13.00000000,0.00000000,14.99633789,253.99291992); //object(lhouse_barrier1) (21)
CreateObject(996,-2711.39990234,-2293.30004883,15.30000019,0.00000000,14.99633789,253.99291992); //object(lhouse_barrier1) (22)
CreateObject(996,-2709.30004883,-2285.80004883,17.50000000,0.00000000,14.99633789,253.99291992); //object(lhouse_barrier1) (23)
CreateObject(996,-2714.60009766,-2287.80004883,16.00000000,0.00000000,14.99633789,253.99291992); //object(lhouse_barrier1) (24)
CreateObject(996,-2716.80004883,-2295.50000000,14.00000000,0.00000000,14.99633789,253.99291992); //object(lhouse_barrier1) (25)
CreateObject(996,-2719.00000000,-2303.00000000,11.80000019,0.00000000,14.99633789,253.99291992); //object(lhouse_barrier1) (26)
CreateObject(996,-2721.19995117,-2310.50000000,9.60000038,0.00000000,14.99633789,253.99291992); //object(lhouse_barrier1) (27)
CreateObject(996,-2728.89990234,-2311.60009766,7.69999981,0.00000000,0.00000000,313.98925781); //object(lhouse_barrier1) (28)
CreateObject(996,-2734.60009766,-2305.69995117,7.69999981,0.00000000,0.00000000,313.98925781); //object(lhouse_barrier1) (29)
CreateObject(996,-2737.80004883,-2298.39990234,8.50000000,0.00000000,5.00000000,291.98925781); //object(lhouse_barrier1) (30)
CreateObject(996,-2740.19995117,-2289.00000000,9.30000019,0.00000000,0.00000000,281.98913574); //object(lhouse_barrier1) (31)
CreateObject(996,-2740.60009766,-2280.80004883,9.60000038,0.00000000,3.00000000,271.98608398); //object(lhouse_barrier1) (32)
CreateObject(996,-2739.30004883,-2257.89990234,3.09999990,0.00000000,340.00000000,265.98303223); //object(lhouse_barrier1) (33)
CreateObject(996,-2739.80004883,-2265.60009766,5.90000010,0.00000000,339.99938965,265.97900391); //object(lhouse_barrier1) (34)
CreateObject(996,-2739.89990234,-2272.80004883,8.10000038,0.00000000,350.00000000,265.97900391); //object(lhouse_barrier1) (35)
CreateObject(997,-2738.39990234,-2296.00000000,8.10000038,0.00000000,0.00000000,290.00000000); //object(lhouse_barrier3) (2)
CreateObject(997,-2712.69995117,-2282.80004883,16.79999924,0.00000000,0.00000000,68.00000000); //object(lhouse_barrier3) (3)
CreateObject(997,-2713.89990234,-2285.80004883,16.50000000,0.00000000,0.00000000,65.99987793); //object(lhouse_barrier3) (4)
CreateObject(997,-2714.60009766,-2287.60009766,15.80000019,0.00000000,350.00000000,65.99487305); //object(lhouse_barrier3) (5)
CreateObject(997,-2708.89990234,-2284.89990234,16.79999924,0.00000000,349.99694824,65.98937988); //object(lhouse_barrier3) (6)
CreateObject(3578,-2730.80004883,-2254.60009766,4.80000019,0.00000000,0.00000000,33.99121094); //object(dockbarr1_la) (3)
CreateObject(3578,-2694.19995117,-2238.39990234,4.80000019,0.00000000,0.00000000,353.98620605); //object(dockbarr1_la) (3)
CreateObject(3578,-2685.50000000,-2242.69995117,4.80000019,0.00000000,0.00000000,311.98498535); //object(dockbarr1_la) (3)
CreateObject(3578,-2685.60009766,-2250.30004883,6.59999990,0.00000000,350.00000000,231.98425293); //object(dockbarr1_la) (3)
CreateObject(3578,-2685.10009766,-2257.69995117,8.60000038,0.00000000,0.00000000,303.98181152); //object(dockbarr1_la) (3)
CreateObject(3578,-2679.39990234,-2266.19995117,8.60000038,0.00000000,0.00000000,303.98071289); //object(dockbarr1_la) (3)
CreateObject(3578,-2673.60009766,-2274.80004883,8.10000038,0.00000000,10.00000000,303.98071289); //object(dockbarr1_la) (3)
CreateObject(3578,-2667.89990234,-2283.30004883,6.40000010,0.00000000,9.99755859,303.97521973); //object(dockbarr1_la) (3)
CreateObject(3578,-2661.50000000,-2291.19995117,4.69999981,0.00000000,9.99755859,311.97521973); //object(dockbarr1_la) (3)
CreateObject(3578,-2654.89990234,-2298.39990234,4.40000010,0.00000000,350.00000000,311.97326660); //object(dockbarr1_la) (3)
CreateObject(3578,-2645.50000000,-2203.60009766,4.80000019,0.00000000,0.00000000,41.98498535); //object(dockbarr1_la) (3)
CreateObject(3578,-2653.39990234,-2210.80004883,4.80000019,0.00000000,0.00000000,41.98425293); //object(dockbarr1_la) (3)
CreateObject(3578,-2657.89990234,-2219.60009766,5.30000019,0.00000000,5.00000000,83.98425293); //object(dockbarr1_la) (3)
CreateObject(3578,-2657.50000000,-2230.10009766,5.80000019,0.00000000,0.00000000,97.97949219); //object(dockbarr1_la) (3)
CreateObject(3578,-2655.60009766,-2240.50000000,5.80000019,0.00000000,0.00000000,101.97607422); //object(dockbarr1_la) (3)
CreateObject(3578,-2653.39990234,-2250.69995117,5.80000019,0.00000000,0.00000000,101.97509766); //object(dockbarr1_la) (3)
CreateObject(3578,-2650.89990234,-2260.80004883,5.80000019,0.00000000,0.00000000,103.97512817); //object(dockbarr1_la) (3)
CreateObject(3578,-2648.30004883,-2270.89990234,5.80000019,0.00000000,0.00000000,103.97460938); //object(dockbarr1_la) (3)
CreateObject(3578,-2645.89990234,-2280.89990234,5.80000019,0.00000000,0.00000000,103.97460938); //object(dockbarr1_la) (3)
CreateObject(3578,-2643.50000000,-2290.89990234,5.80000019,0.00000000,0.00000000,103.97460938); //object(dockbarr1_la) (3)
CreateObject(3578,-2642.39990234,-2295.50000000,5.80000019,0.00000000,0.00000000,103.97460938); //object(dockbarr1_la) (3)
CreateObject(1271,-2725.80004883,-2248.30004883,4.50000000,0.00000000,0.00000000,0.00000000); //object(gunbox) (1)
CreateObject(1271,-2725.80004883,-2247.10009766,4.50000000,0.00000000,0.00000000,0.00000000); //object(gunbox) (2)
CreateObject(1271,-2724.60009766,-2247.10009766,4.50000000,0.00000000,0.00000000,0.00000000); //object(gunbox) (3)
CreateObject(1271,-2724.60009766,-2247.80004883,4.50000000,0.00000000,0.00000000,0.00000000); //object(gunbox) (4)
CreateObject(1271,-2725.80004883,-2247.80004883,4.50000000,0.00000000,0.00000000,0.00000000); //object(gunbox) (5)
CreateObject(1271,-2726.80004883,-2247.30004883,4.50000000,0.00000000,0.00000000,0.00000000); //object(gunbox) (6)
CreateObject(1271,-2726.80004883,-2246.30004883,4.50000000,0.00000000,0.00000000,0.00000000); //object(gunbox) (7)
CreateObject(1271,-2725.89990234,-2247.60009766,5.09999990,0.00000000,0.00000000,0.00000000); //object(gunbox) (8)
CreateObject(1271,-2725.10009766,-2246.30004883,4.50000000,0.00000000,0.00000000,0.00000000); //object(gunbox) (9)
CreateObject(1271,-2725.80004883,-2246.00000000,4.50000000,0.00000000,0.00000000,0.00000000); //object(gunbox) (10)
CreateObject(2567,-2729.19995117,-2244.50000000,6.00000000,0.00000000,0.00000000,306.00000000); //object(ab_warehouseshelf) (1)
CreateObject(2669,-2691.00000000,-2214.69995117,5.50000000,0.00000000,0.00000000,244.00000000); //object(cj_chris_crate) (1)
CreateObject(5269,-2723.00000000,-2242.10009766,6.40000010,0.00000000,0.00000000,38.00000000); //object(las2dkwar05) (1)
CreateObject(1338,-2709.00000000,-2229.19995117,4.80000019,0.00000000,0.00000000,34.00000000); //object(binnt08_la) (1)
CreateObject(1338,-2709.69995117,-2228.30004883,5.09999990,0.00000000,0.00000000,33.99719238); //object(binnt08_la) (2)
CreateObject(1338,-2711.50000000,-2229.80004883,5.09999990,0.00000000,0.00000000,101.99719238); //object(binnt08_la) (3)
CreateObject(1558,-2721.89990234,-2246.50000000,4.69999981,0.00000000,0.00000000,306.00000000); //object(cj_cardbrd_pickup) (1)
CreateObject(1558,-2722.80004883,-2247.30004883,4.69999981,0.00000000,0.00000000,305.99670410); //object(cj_cardbrd_pickup) (2)
CreateObject(1558,-2722.80004883,-2247.30004883,5.69999981,0.00000000,0.00000000,305.99670410); //object(cj_cardbrd_pickup) (3)
CreateObject(1558,-2721.89941406,-2246.50000000,5.69999981,0.00000000,0.00000000,305.99670410); //object(cj_cardbrd_pickup) (4)
CreateObject(1558,-2722.89990234,-2245.39990234,4.69999981,0.00000000,0.00000000,305.99670410); //object(cj_cardbrd_pickup) (6)
CreateObject(1558,-2723.80004883,-2246.19995117,4.69999981,0.00000000,0.00000000,305.99670410); //object(cj_cardbrd_pickup) (7)
CreateObject(1558,-2723.30004883,-2245.60009766,5.69999981,0.00000000,0.00000000,305.99670410); //object(cj_cardbrd_pickup) (8)
CreateObject(953,-2711.30004883,-2230.10009766,5.80000019,0.00000000,0.00000000,0.00000000); //object(cj_oyster) (5)
CreateObject(2782,-2709.89990234,-2228.60009766,5.80000019,0.00000000,0.00000000,0.00000000); //object(cj_oyster_2) (3)
CreateObject(922,-2690.89990234,-2214.00000000,5.19999981,0.00000000,0.00000000,334.00000000); //object(packing_carates1) (1)
CreateObject(923,-2691.50000000,-2215.00000000,5.19999981,0.00000000,0.00000000,334.00000000); //object(packing_carates2) (1)
CreateObject(1558,-2693.00000000,-2214.39990234,4.90000010,0.00000000,0.00000000,334.00000000); //object(cj_cardbrd_pickup) (9)
CreateObject(16092,-2862.69995117,-2145.89990234,3.00000000,0.00000000,0.00000000,34.00000000); //object(des_pipestrut05) (1)
CreateObject(16092,-2873.39990234,-2130.19995117,3.00000000,0.00000000,0.00000000,33.99719238); //object(des_pipestrut05) (2)
CreateObject(1263,-2861.80004883,-2145.10009766,10.60000038,0.00000000,0.00000000,214.00000000); //object(mtraffic3) (1)
CreateObject(1263,-2872.69995117,-2129.19995117,10.60000038,0.00000000,0.00000000,213.99719238); //object(mtraffic3) (2)
CreateObject(968,-2859.50000000,-2150.60009766,4.80000019,1.00000000,0.00000000,305.99951172); //object(barrierturn) (6)
CreateObject(968,-2870.19995117,-2134.69995117,4.80000019,0.99975586,0.00000000,305.99670410); //object(barrierturn) (7)
CreateObject(968,-2859.50000000,-2150.50000000,4.80000019,0.99975586,270.00000000,305.99670410); //object(barrierturn) (8)
CreateObject(968,-2870.19995117,-2134.69995117,4.80000019,0.99975586,270.00000000,305.99670410); //object(barrierturn) (9)
CreateObject(968,-2872.60009766,-2119.50000000,4.09999990,0.99975586,0.00000000,35.99670410); //object(barrierturn) (10)
CreateObject(968,-2872.60009766,-2119.50000000,4.09999990,0.99426270,90.00000000,35.99670410); //object(barrierturn) (11)
CreateObject(5837,-2865.39990234,-2143.00000000,4.80000019,0.00000000,0.00000000,215.99902344); //object(ci_guardhouse1) (3)
CreateObject(5837,-2876.60009766,-2128.00000000,4.80000019,0.00000000,0.00000000,215.99670410); //object(ci_guardhouse1) (4)
CreateObject(5837,-2862.69995117,-2113.80004883,4.80000019,0.00000000,0.00000000,215.99670410); //object(ci_guardhouse1) (5)
//======================================[ HOPITAL ]========================================================================
CreateObject(18030, -3431.134521, 485.900696, 58.980362, 0.0000, 0.0000, 0.0000);
CreateObject(3851, -3414.403076, 481.469910, 58.052380, 0.0000, 0.0000, 0.0000);
CreateObject(16500, -3438.102051, 479.148163, 58.115932, 0.0000, 0.0000, 180.0000);
CreateObject(16500, -3438.109863, 474.212006, 62.046516, 0.0000, 0.0000, 180.0000);
CreateObject(16500, -3438.104980, 479.143646, 62.044415, 0.0000, 0.0000, 180.0000);
CreateObject(16500, -3440.937256, 481.486877, 56.990864, 0.0000, 0.0000, 270.0000);
CreateObject(16500, -3448.051270, 481.455658, 58.615963, 0.0000, 0.0000, 270.0000);
CreateObject(16500, -3453.049316, 481.449829, 58.615963, 0.0000, 0.0000, 270.0000);
CreateObject(16500, -3445.840332, 478.679169, 58.615963, 0.0000, 0.0000, 180.0000);
CreateObject(16500, -3445.845459, 478.682648, 62.585945, 0.0000, 0.0000, 180.0000);
CreateObject(18084, -3415.399170, 481.453278, 58.747929, 0.0000, 0.0000, 90.0000);
CreateObject(16500, -3438.107178, 474.202484, 58.065929, 0.0000, 0.0000, 180.0000);
CreateObject(1537, -3436.934814, 472.305359, 56.440868, 0.0000, 0.0000, 142.1845);
CreateObject(2164, -3416.020508, 476.476715, 56.808903, 0.0000, 0.0000, 180.0000);
CreateObject(2167, -3415.101318, 476.468048, 56.810150, 0.0000, 0.0000, 180.0000);
CreateObject(2604, -3433.258057, 475.004883, 57.350861, 0.0000, 0.0000, 90.0000);
CreateObject(2608, -3431.760010, 472.435791, 58.362087, 0.0000, 0.0000, 180.0000);
CreateObject(2610, -3430.616211, 473.715393, 56.879414, 0.0000, 0.0000, 180.0000);
CreateObject(1797, -3449.090332, 475.390503, 56.565342, 0.0000, 0.0000, 90.0000);
CreateObject(1797, -3448.117920, 477.217743, 56.565342, 0.0000, 0.0000, 0.0000);
CreateObject(1797, -3441.888916, 477.761749, 56.565342, 0.0000, 0.0000, 0.0000);
CreateObject(1797, -3442.086426, 475.485046, 56.565342, 0.0000, 0.0000, 270.0000);
CreateObject(1742, -3438.055908, 477.629730, 56.615780, 0.0000, 0.0000, 270.0000);
CreateObject(1744, -3439.522461, 472.156342, 58.005661, 0.0000, 0.0000, 180.0000);
CreateObject(1738, -3445.596680, 477.881256, 57.226379, 0.0000, 0.0000, 90.0000);
CreateObject(1791, -3440.372070, 472.281311, 58.329323, 0.0000, 0.0000, 180.0000);
CreateObject(2333, -3439.720215, 479.689484, 56.515408, 0.0000, 0.0000, 270.0000);
CreateObject(2812, -3438.664795, 478.772705, 57.484566, 0.0000, 0.0000, 281.2500);
CreateObject(2813, -3439.505371, 472.514404, 58.346287, 0.0000, 0.0000, 202.5000);
CreateObject(1721, -3439.248047, 481.095367, 56.609905, 0.0000, 0.0000, 191.2500);
CreateObject(1721, -3439.868164, 478.843262, 56.609905, 0.0000, 0.0000, 270.0000);
CreateObject(1742, -3453.084473, 478.078491, 56.524128, 0.0000, 0.0000, 88.6589);
CreateObject(1744, -3451.005371, 481.521484, 58.635593, 0.0000, 0.0000, 359.9227);
CreateObject(1791, -3449.949463, 481.421967, 58.953369, 0.0000, 0.0000, 1.2373);
CreateObject(2333, -3451.439941, 479.903198, 56.552795, 0.0000, 0.0000, 0.1371);
CreateObject(1721, -3452.697754, 479.883484, 56.597763, 0.0000, 0.0000, 307.7117);
CreateObject(1721, -3450.933350, 479.483337, 56.610622, 0.0000, 0.0000, 2.7156);
CreateObject(14705, -3452.778564, 478.655365, 58.787151, 0.0000, 0.0000, 0.0000);
CreateObject(2816, -3450.540039, 480.995361, 57.521580, 0.0000, 0.0000, 0.0000);
CreateObject(1500, -3443.361572, 481.483551, 56.574081, 0.0000, 0.0000, 213.7500);
CreateObject(16500, -3445.825928, 471.733978, 58.615963, 0.0000, 0.0000, 180.0000);
CreateObject(16500, -3445.828857, 471.725494, 62.012665, 0.0000, 0.0000, 180.0000);
CreateObject(1500, -3445.729248, 474.182739, 56.574825, 0.0000, 0.0000, 146.2500);
CreateObject(16500, -3445.833496, 473.747070, 61.216061, 0.0000, 0.0000, 180.0000);
CreateObject(16500, -3440.929443, 481.483551, 60.377632, 0.0000, 0.0000, 270.0000);
CreateObject(16500, -3445.893555, 481.436096, 61.216030, 0.0000, 0.0000, 270.8595);
CreateObject(1649, -3421.715088, 472.331299, 58.606609, 0.0000, 0.0000, 180.0000);
CreateObject(1649, -3426.130127, 472.315765, 58.744919, 0.0000, 0.0000, 180.0000);
CreateObject(1649, -3430.572998, 472.335815, 58.613014, 0.0000, 0.0000, 180.0000);
CreateObject(2690, -3433.158203, 472.335815, 58.121151, 0.0000, 0.0000, 180.0000);
CreateObject(2684, -3433.363770, 476.903015, 57.544289, 0.0000, 0.0000, 180.0000);
CreateObject(2687, -3426.413086, 472.790649, 59.531715, 0.0000, 0.0000, 179.9997);
CreateObject(2688, -3430.565918, 472.385803, 58.194000, 0.0000, 0.0000, 180.0000);
CreateObject(16500, -3436.266357, 472.183624, 60.966015, 0.0000, 0.0000, 90.0000);
CreateObject(2162, -3418.316162, 476.917206, 56.761330, 0.0000, 0.0000, 90.0000);
CreateObject(1500, -3415.351074, 479.521912, 56.816780, 0.0000, 0.0000, 224.9999);
CreateObject(1729, -3417.998291, 478.823853, 56.813511, 0.0000, 0.0000, 78.7500);
CreateObject(16500, -3448.625977, 490.762451, 58.615963, 0.0000, 0.0000, 90.0000);
CreateObject(16500, -3455.157471, 490.765350, 58.615963, 0.0000, 0.0000, 90.0000);
CreateObject(16500, -3451.397949, 490.776398, 61.216000, 0.0000, 0.0000, 90.0000);
CreateObject(1500, -3452.708740, 490.693665, 56.581261, 0.0000, 0.0000, 65.6266);
CreateObject(16500, -3445.807861, 493.480042, 58.015926, 0.0000, 0.0000, 180.0000);
CreateObject(16500, -3445.808105, 497.330750, 58.015926, 0.0000, 0.0000, 180.0000);
CreateObject(16500, -3445.810791, 493.474518, 61.420723, 0.0000, 0.0000, 180.0000);
CreateObject(16500, -3445.811035, 498.395142, 61.408611, 0.0000, 0.0000, 180.0000);
CreateObject(1797, -3449.565430, 492.596039, 56.555542, 0.0000, 0.0000, 270.0000);
CreateObject(1797, -3449.555176, 496.229187, 56.557510, 0.0000, 0.0000, 270.0000);
CreateObject(1797, -3452.452148, 496.169617, 56.565342, 0.0000, 0.0000, 359.3814);
CreateObject(1742, -3449.852539, 499.945496, 56.592693, 0.0000, 0.0000, 3.6786);
CreateObject(2333, -3451.374023, 493.654297, 56.522900, 0.0000, 0.0000, 91.1340);
CreateObject(1744, -3448.056152, 500.009369, 58.725933, 0.0000, 0.0000, 0.0000);
CreateObject(1791, -3447.075195, 499.972015, 59.053726, 0.0000, 0.0000, 359.5185);
CreateObject(1721, -3452.690186, 495.670135, 56.588215, 0.0000, 0.0000, 270.3182);
CreateObject(1721, -3451.707520, 493.630859, 56.601074, 0.0000, 0.0000, 352.7206);
CreateObject(1817, -3448.081787, 498.776672, 56.566715, 0.0000, 0.0000, 0.0000);
CreateObject(1819, -3447.332275, 493.354950, 56.571541, 0.0000, 0.0000, 0.0000);
CreateObject(1721, -3446.226807, 498.407898, 56.601074, 0.0000, 0.0000, 94.2377);
CreateObject(1738, -3449.987061, 490.982697, 57.201378, 0.0000, 0.0000, 0.0000);
CreateObject(1738, -3452.862549, 473.974640, 57.176376, 0.0000, 0.0000, 270.0000);
CreateObject(1782, -3448.021240, 499.291351, 57.155022, 0.0000, 0.0000, 0.0000);
CreateObject(2202, -3428.985596, 473.662872, 56.564693, 0.0000, 0.0000, 180.0000);
CreateObject(2855, -3452.366211, 493.585510, 57.491684, 0.0000, 0.0000, 123.7499);
CreateObject(2848, -3446.942139, 493.871826, 57.062328, 0.0000, 0.0000, 22.5000);
CreateObject(16500, -3440.934326, 490.790497, 58.615963, 0.0000, 0.0000, 90.0000);
CreateObject(1500, -3445.592529, 490.674225, 56.515873, 0.0000, 0.0000, 47.5783);
CreateObject(16500, -3444.256348, 490.800537, 61.216015, 0.0000, 0.0000, 90.0000);
CreateObject(16500, -3438.110107, 493.135803, 58.590961, 0.0000, 0.0000, 180.0000);
CreateObject(16500, -3438.112061, 498.095184, 58.590961, 0.0000, 0.0000, 180.0000);
CreateObject(16500, -3438.113037, 493.124756, 62.585213, 0.0000, 0.0000, 180.0000);
CreateObject(16500, -3438.114990, 498.105011, 62.577660, 0.0000, 0.0000, 180.0000);
CreateObject(1797, -3444.691162, 496.334839, 56.580544, 0.0000, 0.0000, 359.3814);
CreateObject(1797, -3441.860107, 492.629791, 56.642399, 0.0000, 0.0000, 270.9634);
CreateObject(1742, -3441.492188, 499.923370, 56.603683, 0.0000, 0.0000, 3.6786);
CreateObject(1819, -3439.431641, 493.252075, 56.586964, 0.0000, 0.0000, 0.0000);
CreateObject(1744, -3440.229492, 500.028778, 58.939453, 0.0000, 0.0000, 0.0000);
CreateObject(1791, -3439.527588, 499.928497, 59.269745, 0.0000, 0.0000, 359.5185);
CreateObject(1817, -3439.362793, 498.105133, 56.566463, 0.0000, 0.0000, 270.6186);
CreateObject(1721, -3438.956543, 495.714783, 56.601074, 0.0000, 0.0000, 358.7364);
CreateObject(1721, -3439.734375, 499.398438, 56.604694, 0.0000, 0.0000, 202.3193);
CreateObject(14705, -3441.540527, 499.608337, 58.866707, 0.0000, 0.0000, 0.0000);
CreateObject(2854, -3438.844727, 497.996643, 56.671379, 0.0000, 0.0000, 270.0000);
CreateObject(2850, -3438.910400, 493.788483, 57.103001, 0.0000, 0.0000, 0.0000);
CreateObject(1738, -3445.584473, 494.370667, 57.245953, 0.0000, 0.0000, 270.6186);
CreateObject(16500, -3434.194092, 497.901703, 58.032349, 0.0000, 0.0000, 0.0000);
CreateObject(16500, -3434.191650, 492.959229, 58.032349, 0.0000, 0.0000, 0.0000);
CreateObject(16500, -3434.187012, 497.220947, 61.932343, 0.0000, 0.0000, 0.0000);
CreateObject(16500, -3434.188721, 492.969238, 61.923931, 0.0000, 0.0000, 0.0000);
CreateObject(16500, -3431.852783, 490.828308, 55.407295, 0.0000, 0.0000, 90.0000);
CreateObject(1649, -3432.182617, 490.781647, 58.305847, 0.0000, 0.0000, 0.0000);
CreateObject(16500, -3427.350098, 490.847107, 55.382248, 0.0000, 0.0000, 90.0000);
CreateObject(16500, -3427.491211, 490.850433, 59.380772, 0.0000, 0.0000, 90.0000);
CreateObject(16500, -3431.449219, 490.856628, 61.920868, 0.0000, 0.0000, 90.0000);
CreateObject(1649, -3432.149170, 490.856873, 58.303780, 0.0000, 0.0000, 180.0000);
CreateObject(16500, -3424.925049, 493.249908, 58.007347, 0.0000, 0.0000, 180.0000);
CreateObject(16500, -3424.927979, 493.267059, 61.925598, 0.0000, 0.0000, 180.0000);
CreateObject(16500, -3424.926270, 499.983459, 58.032349, 0.0000, 0.0000, 180.0000);
CreateObject(16500, -3424.930908, 499.994934, 62.032349, 0.0000, 0.0000, 180.0000);
CreateObject(16500, -3424.950439, 496.570526, 61.182480, 0.0000, 0.0000, 180.0000);
CreateObject(1500, -3424.853271, 495.712738, 56.561943, 0.0000, 0.0000, 135.0000);
CreateObject(1671, -3432.127930, 473.812897, 57.055622, 0.0000, 0.0000, 191.2501);
CreateObject(1671, -3431.948975, 476.075195, 57.030621, 0.0000, 0.0000, 270.0000);
CreateObject(3396, -3425.713379, 493.406006, 56.535950, 0.0000, 0.0000, 0.0000);
CreateObject(3395, -3428.222900, 491.714142, 56.535950, 0.0000, 0.0000, 270.0000);
CreateObject(3388, -3425.559570, 499.124847, 56.363159, 0.0000, 0.0000, 270.0000);
CreateObject(2343, -3430.551025, 491.680328, 57.188637, 0.0000, 0.0000, 87.8172);
CreateObject(1715, -3427.075195, 493.356323, 56.579773, 0.0000, 0.0000, 78.7500);
CreateObject(1738, -3427.542725, 499.670471, 57.192799, 0.0000, 0.0000, 0.0000);
CreateObject(1808, -3428.709473, 499.677643, 56.608017, 0.0000, 0.0000, 0.0000);
CreateObject(2146, -3430.795654, 496.940308, 57.048721, 0.0000, 0.0000, 22.5000);
CreateObject(2133, -3429.549805, 499.348755, 56.587135, 0.0000, 0.0000, 0.0000);
CreateObject(2134, -3433.613281, 492.092712, 56.562134, 0.0000, 0.0000, 90.0000);
CreateObject(2141, -3433.589111, 493.151947, 56.601280, 0.0000, 0.0000, 90.0000);
CreateObject(2197, -3432.609863, 494.996460, 56.580360, 0.0000, 0.0000, 90.0000);
CreateObject(2197, -3432.623535, 494.300476, 56.580360, 0.0000, 0.0000, 90.0000);
CreateObject(1723, -3419.855713, 478.272919, 56.561218, 0.0000, 0.0000, 270.0000);
CreateObject(1723, -3422.946533, 473.705200, 56.536217, 0.0000, 0.0000, 180.0000);
CreateObject(1724, -3420.319092, 474.677429, 56.511177, 0.0000, 0.0000, 226.4098);
CreateObject(2008, -3417.912109, 486.256378, 56.781921, 0.0000, 0.0000, 0.0000);
CreateObject(2311, -3422.593018, 476.790375, 56.580482, 0.0000, 0.0000, 217.8151);
CreateObject(1724, -3423.011475, 479.122925, 56.529652, 0.0000, 0.0000, 2.0967);
CreateObject(1724, -3425.823975, 477.620270, 56.518051, 0.0000, 0.0000, 49.3658);
CreateObject(2854, -3423.770996, 476.014008, 57.086102, 0.0000, 0.0000, 236.2501);
CreateObject(14705, -3422.609619, 476.818726, 57.309940, 0.0000, 0.0000, 0.0000);
CreateObject(16500, -3426.793213, 475.077362, 55.132370, 0.0000, 0.0000, 0.0000);
CreateObject(16500, -3426.793213, 479.284363, 55.132339, 0.0000, 0.0000, 0.0000);
CreateObject(16500, -3429.281982, 481.681793, 55.132324, 0.0000, 0.0000, 90.0000);
CreateObject(2133, -3427.793945, 473.978851, 56.562134, 0.0000, 0.0000, 213.7500);
CreateObject(2604, -3428.789551, 481.079590, 57.285042, 0.0000, 0.0000, 0.0000);
CreateObject(1671, -3429.205811, 480.227325, 57.048386, 0.0000, 0.0000, 270.0000);
CreateObject(2184, -3431.083496, 481.461639, 56.608799, 0.0000, 0.0000, 202.5000);
CreateObject(2180, -3427.508545, 477.707947, 56.535961, 0.0000, 0.0000, 90.0000);
CreateObject(14604, -3427.526855, 476.669037, 57.568817, 0.0000, 0.0000, 90.0000);
CreateObject(2813, -3427.467041, 477.808136, 57.337742, 0.0000, 0.0000, 258.7500);
CreateObject(2131, -3433.772217, 496.696533, 56.437126, 0.0000, 0.0000, 90.0000);
CreateObject(1808, -3427.486572, 475.839020, 56.558014, 0.0000, 0.0000, 270.0000);
CreateObject(1506, -3416.948486, 483.419342, 56.690411, 0.0000, 0.0000, 0.0000);
CreateObject(1671, -3428.119873, 479.636230, 57.048386, 0.0000, 0.0000, 315.0000);
CreateObject(1723, -3449.718994, 482.042450, 56.586220, 0.0000, 0.0000, 180.0000);
CreateObject(1723, -3452.530762, 482.837006, 56.586220, 0.0000, 0.0000, 90.0000);
CreateObject(1724, -3447.379639, 482.028687, 56.586182, 0.0000, 0.0000, 180.0000);
CreateObject(1724, -3452.561035, 486.193298, 56.561180, 0.0000, 0.0000, 90.0000);
CreateObject(1723, -3449.333984, 490.178223, 56.561218, 0.0000, 0.0000, 0.0000);
CreateObject(1723, -3419.809570, 489.638977, 56.561218, 0.0000, 0.0000, 270.0000);
CreateObject(1724, -3419.804443, 486.514709, 56.561180, 0.0000, 0.0000, 269.9999);
CreateObject(2311, -3449.535645, 483.908875, 56.580482, 0.0000, 0.0000, 135.0000);
//=======================================[ CIRCUIT LV ]===========================================================
CreateObject(1238,2095.85107400,1859.89355500,9.99613400,0.00000000,0.00000000,0.00000000); //start of track
CreateObject(1238,2096.28881800,1863.60327100,10.00178100,0.00000000,0.00000000,0.00000000); //
CreateObject(1238,2095.03735400,1867.43542500,10.13676300,0.00000000,0.00000000,0.00000000); //
CreateObject(1238,2092.37109400,1871.40356400,10.43221700,0.00000000,0.00000000,0.00000000); //
CreateObject(1411,2107.21215800,1867.13439900,11.29136000,0.00000000,0.00000000,254.07570000); //
CreateObject(1411,2105.95947300,1862.11767600,11.28960500,0.00000000,0.00000000,258.37280000); //
CreateObject(1411,2104.87109400,1857.05932600,11.25457000,0.00000000,0.00000000,257.51340000); //
CreateObject(1411,1867.46533200,1789.07629400,13.35144200,0.00000000,0.00000000,353.98390000); //
CreateObject(1411,1862.49987800,1790.31884800,13.35144200,0.00000000,0.00000000,337.50000000); //
CreateObject(1411,1858.38183600,1793.06079100,13.35144200,0.00000000,0.00000000,315.93670000); //
CreateObject(1411,1855.18481400,1797.14917000,13.34440600,0.00000000,0.00000000,300.31220000); //
CreateObject(1411,1853.42541500,1801.78552200,13.35144200,0.00000000,0.00000000,281.25000000); //
CreateObject(1411,1852.99707000,1806.89880400,13.28306200,0.00000000,0.00000000,270.00000000); //
CreateObject(1411,1853.00744600,1812.07055700,13.06946800,0.00000000,0.00000000,270.00000000); //
CreateObject(1411,1853.03723100,1817.27563500,12.85449700,0.00000000,0.00000000,270.00000000); //
CreateObject(1411,1853.07568400,1822.45361300,12.64306600,0.00000000,0.00000000,270.00000000); //
CreateObject(1411,1852.92004400,1827.74035600,12.54173500,0.00000000,0.00000000,270.00000000); //
CreateObject(1411,1852.92004400,1832.91320800,12.24897000,0.00000000,0.00000000,270.00000000); //
CreateObject(1411,1852.92004400,1838.15942400,12.33633100,0.00000000,0.00000000,270.00000000); //
CreateObject(1411,1852.91406300,1843.37304700,12.39462100,0.00000000,0.00000000,270.00000000); //
CreateObject(1411,1852.91406300,1848.58703600,12.19285200,0.00000000,0.00000000,270.00000000); //
CreateObject(1411,1852.91406300,1853.74182100,12.07042300,0.00000000,0.00000000,270.00000000); //
CreateObject(1411,1852.93908700,1858.99108900,12.07420400,0.00000000,0.00000000,270.00000000); //
CreateObject(1411,1852.98913600,1864.21984900,12.12194900,0.00000000,0.00000000,270.00000000); //
CreateObject(1411,1852.91406300,1869.31530800,12.35769500,0.00000000,0.00000000,270.00000000); //
CreateObject(1411,1852.91406300,1874.47668500,12.40973700,0.00000000,0.00000000,270.00000000); //
CreateObject(1411,1852.91406300,1879.73986800,12.33027600,0.00000000,0.00000000,270.00000000); //
CreateObject(1411,1852.83129900,1884.99414100,12.37549400,0.00000000,0.00000000,270.00000000); //
CreateObject(1411,1852.80139200,1890.15734900,12.34649300,0.00000000,0.00000000,270.00000000); //
CreateObject(1411,1852.79699700,1895.31787100,12.31187200,0.00000000,0.00000000,270.00000000); //
CreateObject(1411,1852.71215800,1900.53686500,12.28383400,0.00000000,0.00000000,270.00000000); //
CreateObject(1411,1852.81750500,1905.55285600,12.25688600,0.00000000,0.00000000,270.00000000); //
CreateObject(1411,1852.77111800,1910.76037600,12.23077400,0.00000000,0.00000000,270.00000000); //
CreateObject(1411,1852.77050800,1915.93408200,12.20171500,0.00000000,0.00000000,270.00000000); //
CreateObject(1411,1852.72998000,1921.21618700,12.17204700,0.00000000,0.00000000,270.00000000); //
CreateObject(1411,1852.47863800,1926.79724100,12.14070000,0.00000000,0.00000000,270.00000000); //
CreateObject(978,2101.38330100,1970.56042500,10.57412100,0.00000000,0.00000000,60.54720000); //
CreateObject(2792,2109.48779300,1976.62890600,16.28000500,0.00000000,0.00000000,180.00000000); //
CreateObject(970,2109.42358400,1974.58056600,10.37633200,0.00000000,0.00000000,311.87160000); //
CreateObject(970,2104.89111300,1968.56457500,10.31982900,0.00000000,0.00000000,1.01410000); //
CreateObject(978,2086.63549800,2006.77636700,10.66053300,0.00000000,0.00000000,157.50000000); //
CreateObject(978,2094.55664100,2002.00659200,10.66053300,0.00000000,0.00000000,140.23390000); //
CreateObject(978,2099.85302700,1995.94189500,10.66053300,0.00000000,0.00000000,120.23490000); //
CreateObject(978,2106.57861300,1867.47607400,10.52244900,0.00000000,0.00000000,258.75000000); //
CreateObject(978,2105.03369100,1859.79138200,10.52120500,0.00000000,0.00000000,259.53210000); //
CreateObject(970,2100.96752900,1967.55590800,10.34114200,0.00000000,0.00000000,27.26120000); //
CreateObject(970,2110.90991200,1970.84741200,10.25468100,0.00000000,0.00000000,273.06010000); //
CreateObject(978,1981.30957000,2008.77941900,10.44193600,0.00000000,2.57830000,180.00000000); //
CreateObject(978,1990.67175300,2008.77600100,10.67434400,0.00000000,0.00000000,180.00000000); //
CreateObject(978,2000.03442400,2008.78430200,10.66053300,0.00000000,0.00000000,180.00000000); //
CreateObject(978,2009.20837400,2008.77526900,10.66053300,0.00000000,0.00000000,180.00000000); //
CreateObject(978,2018.42102100,2008.79638700,10.66053300,0.00000000,0.00000000,180.00000000); //
CreateObject(978,2027.60900900,2008.82019000,10.66053300,0.00000000,0.00000000,180.00000000); //
CreateObject(978,2036.89782700,2008.84179700,10.66053300,0.00000000,0.00000000,180.00000000); //
CreateObject(978,2046.19836400,2008.86157200,10.66053300,0.00000000,0.00000000,180.00000000); //
CreateObject(978,2055.47876000,2008.85327100,10.66053300,0.00000000,0.00000000,180.00000000); //
CreateObject(978,2064.77319300,2008.90148900,10.66053300,0.00000000,0.00000000,180.00000000); //
CreateObject(978,2073.74853500,2008.90393100,10.66053300,0.00000000,0.00000000,180.00000000); //
CreateObject(978,2081.21118200,2008.32690400,10.66053300,0.00000000,0.00000000,171.32830000); //
CreateObject(1425,2106.73657200,1863.20031700,10.13059200,0.00000000,0.00000000,78.75000000); //
CreateObject(979,1921.19030800,1964.60681200,7.43397000,0.00000000,0.00000000,24.21890000); //
CreateObject(979,1929.29150400,1969.13977100,7.43397000,0.00000000,0.00000000,33.75000000); //
CreateObject(979,1936.83874500,1974.18225100,7.43397000,0.00000000,0.00000000,33.75000000); //
CreateObject(979,1944.31201200,1979.17712400,7.43397000,0.00000000,0.00000000,33.75000000); //
CreateObject(979,1951.96899400,1984.30676300,7.43397000,0.00000000,0.00000000,33.75000000); //
CreateObject(979,1959.90466300,1988.77172900,8.15895900,0.00000000,350.54620000,25.93770000); //
CreateObject(979,1968.08361800,1992.11621100,9.95959200,0.00000000,346.24900000,19.06220000); //
CreateObject(978,1920.88061500,1979.22229000,7.43397000,0.00000000,0.00000000,217.18780000); //
CreateObject(978,1928.26745600,1984.85461400,7.43397000,0.00000000,0.00000000,217.18780000); //
CreateObject(978,1935.60229500,1990.48620600,7.43397000,0.00000000,0.00000000,218.04720000); //
CreateObject(978,1942.87744100,1995.74926800,7.43397000,0.00000000,0.00000000,213.75000000); //
CreateObject(978,1950.05261200,2000.40148900,7.60897100,0.00000000,2.57830000,212.03110000); //
CreateObject(978,1957.42456100,2004.27356000,8.13281200,0.00000000,4.29720000,204.29610000); //
CreateObject(978,1965.92163100,2007.15637200,9.06113100,0.00000000,6.87550000,193.90560000); //
CreateObject(978,1974.06762700,2008.53344700,9.94465500,358.28110000,5.15660000,184.37450000); //
CreateObject(978,1921.96752900,1792.27673300,12.65891200,0.00000000,0.00000000,270.38670000); //
CreateObject(978,2102.85766600,1987.26013200,10.66053300,0.00000000,0.00000000,97.81230000); //
CreateObject(978,2103.48242200,1978.92578100,10.66053300,0.00000000,0.00000000,90.00000000); //
CreateObject(1319,2098.90234400,1966.89746100,10.36360800,0.00000000,0.00000000,11.25000000); //
CreateObject(1319,2092.13818400,1974.58691400,10.36718800,0.00000000,0.00000000,0.00000000); //
CreateObject(970,2108.96923800,1968.65881300,10.30295900,0.00000000,0.00000000,1.71890000); //
CreateObject(978,1921.92334000,1801.64050300,12.65094100,0.00000000,0.00000000,270.00000000); //
CreateObject(978,1877.44482400,1790.20568800,12.58391300,0.00000000,0.00000000,0.00000000); //
CreateObject(978,1886.79418900,1790.20385700,12.58865300,0.00000000,0.00000000,0.00000000); //
CreateObject(978,1862.94677700,1941.37731900,7.43480800,0.00000000,0.00000000,213.75000000); //
CreateObject(978,1856.11010700,1935.13159200,7.43480800,0.00000000,0.00000000,231.09340000); //
CreateObject(978,1913.06250000,1974.76086400,7.43480800,0.00000000,0.00000000,213.75000000); //
CreateObject(978,1906.54821800,1968.29089400,7.43480800,0.00000000,0.00000000,236.25010000); //
CreateObject(978,1903.16564900,1959.76477100,7.43480800,0.00000000,0.00000000,260.54620000); //
CreateObject(978,1902.36071800,1950.70153800,7.43480800,0.00000000,0.00000000,269.06320000); //
CreateObject(979,1963.82885700,1768.67236300,12.58391300,0.00000000,0.00000000,209.37560000); //
CreateObject(979,1957.60266100,1762.20910600,12.53391400,0.00000000,0.85940000,242.26610000); //
CreateObject(979,1954.82910200,1750.42138700,12.59196000,0.00000000,0.00000000,270.00000000); //
CreateObject(979,1959.43957500,1740.10327100,12.58391300,0.00000000,0.00000000,0.00000000); //
CreateObject(979,1968.81201200,1740.11682100,12.59467900,0.00000000,0.00000000,0.00000000); //
CreateObject(979,1954.81897000,1743.29150400,12.59370300,0.00000000,0.00000000,270.00000000); //
CreateObject(978,1908.40637200,1776.95715300,12.58391300,0.00000000,0.00000000,230.07940000); //
CreateObject(978,1914.70837400,1783.83386200,12.58391300,0.00000000,0.00000000,225.00000000); //end of track
CreateObject(1238,2059.01293900,1950.12072800,10.95341400,0.00000000,0.00000000,0.00000000); //start of pits
CreateObject(1238,2057.60986300,1948.63732900,10.99553200,0.00000000,0.00000000,0.00000000); //
CreateObject(1238,2056.05883800,1947.02221700,11.04146900,0.00000000,0.00000000,0.00000000); //
CreateObject(1238,2054.35766600,1945.21362300,11.09278800,0.00000000,0.00000000,0.00000000); //
CreateObject(1238,2057.10229500,1950.32470700,10.96787500,0.00000000,0.00000000,0.00000000); //
CreateObject(1238,2054.46972700,1950.50610400,10.98929600,0.00000000,0.00000000,0.00000000); //
CreateObject(1238,2051.46850600,1950.79541000,11.09629200,0.00000000,0.00000000,0.00000000); //
CreateObject(1238,2048.79541000,1950.40319800,11.20001300,0.00000000,0.00000000,0.00000000); //
CreateObject(1238,2045.74182100,1948.73730500,11.24454700,0.00000000,0.00000000,0.00000000); //
CreateObject(1238,2042.71276900,1945.25671400,11.24258200,0.00000000,0.00000000,0.00000000); //
CreateObject(1238,2041.74743700,1941.49206500,11.28800800,0.00000000,0.00000000,0.00000000); //
CreateObject(978,2045.82214400,1938.87707500,12.07231400,0.00000000,0.00000000,348.75000000); //
CreateObject(978,2040.91052200,1934.94628900,11.91018400,0.00000000,0.00000000,87.42170000); //
CreateObject(978,2040.47473100,1923.93457000,12.00704100,0.00000000,0.00000000,88.28110000); //
CreateObject(978,2040.37878400,1912.47863800,12.00751400,0.00000000,0.00000000,90.85940000); //
CreateObject(978,2040.83850100,1901.58276400,11.98101100,0.00000000,0.00000000,94.29720000); //
CreateObject(978,2045.11950700,1894.57666000,11.83576300,0.00000000,0.00000000,147.89160000); //
CreateObject(1238,2041.32373000,1894.16601600,11.33176500,0.00000000,0.00000000,0.00000000); //
CreateObject(1238,2041.84899900,1890.68078600,11.28303100,0.00000000,0.00000000,0.00000000); //
CreateObject(1238,2042.35998500,1887.57031300,11.24285100,0.00000000,0.00000000,0.00000000); //
CreateObject(1238,2043.80078100,1885.14697300,11.24181900,0.00000000,0.00000000,0.00000000); //
CreateObject(1238,2046.00915500,1882.98913600,11.24101800,0.00000000,0.00000000,0.00000000); //
CreateObject(1238,2049.95019500,1882.07202100,11.15880100,0.00000000,0.00000000,0.00000000); //
CreateObject(1238,2053.54785200,1882.21484400,11.02964600,0.00000000,0.00000000,0.00000000); //
CreateObject(1238,2056.41845700,1882.51611300,10.96817400,0.00000000,0.00000000,0.00000000); //
CreateObject(1238,2059.29760700,1882.40502900,10.94071000,0.00000000,0.00000000,0.00000000); //
CreateObject(1238,2057.14062500,1884.50781300,11.00104500,0.00000000,0.00000000,0.00000000); //
CreateObject(1238,2055.11303700,1886.26647900,11.09727200,0.00000000,0.00000000,0.00000000); //
CreateObject(1238,2053.71069300,1887.97412100,11.16660500,0.00000000,0.00000000,0.00000000); //
CreateObject(8947,2018.42297400,1929.18481400,14.39399700,0.00000000,0.00000000,90.00000000); //
CreateObject(8947,2018.41992200,1903.44226100,14.38596900,0.00000000,0.00000000,90.00000000); //
CreateObject(10282,2022.37219200,1929.85376000,12.34669300,0.00000000,0.00000000,90.00000000); //
CreateObject(10282,2022.24926800,1903.46765100,12.29317200,0.00000000,0.00000000,90.00000000); //
CreateObject(3659,2045.71130400,1924.70300300,12.30383800,0.00000000,0.00000000,0.00000000); //
CreateObject(3659,2045.71997100,1914.00512700,12.27057100,0.00000000,0.00000000,0.00000000); //
CreateObject(3860,2045.73901400,1923.54748500,12.30288100,0.00000000,0.00000000,88.28110000); //
CreateObject(3860,2045.68493700,1912.85522500,12.26615000,0.00000000,0.00000000,88.28110000); //
CreateObject(3860,2045.53674300,1904.28759800,12.18684600,0.00000000,0.00000000,88.28110000); //
CreateObject(3659,2045.54223600,1905.44946300,12.16358200,0.00000000,0.00000000,358.28110000); //
CreateObject(8947,2018.42614700,1916.85449200,14.37620500,0.00000000,0.00000000,90.00000000); //
CreateObject(10282,2021.61340300,1916.75537100,12.35228700,0.00000000,0.00000000,90.00000000); //
CreateObject(1215,2030.23376500,1932.68737800,11.80434000,0.00000000,0.00000000,0.00000000); //
CreateObject(1215,2030.21081500,1925.54980500,11.84680900,0.00000000,0.00000000,0.00000000); //
CreateObject(1215,2030.25061000,1913.28100600,11.87210800,0.00000000,0.00000000,0.00000000); //
CreateObject(1215,2030.21496600,1920.34777800,11.87823500,0.00000000,0.00000000,0.00000000); //
CreateObject(1215,2030.20605500,1899.94238300,11.78092800,0.00000000,0.00000000,0.00000000); //
CreateObject(1215,2030.36254900,1906.87316900,11.82824000,0.00000000,0.00000000,0.00000000); //
CreateObject(1215,2046.69995100,1904.21521000,13.89695200,0.00000000,0.00000000,0.00000000); //
CreateObject(1215,2046.74133300,1912.82556200,13.97652400,0.00000000,0.00000000,0.00000000); //
CreateObject(1215,2046.93310500,1923.57556200,14.04436500,0.00000000,0.00000000,0.00000000); //
CreateObject(1319,2041.17382800,1939.74536100,11.53881200,0.00000000,0.00000000,0.00000000); //
CreateObject(1250,2063.75781300,1898.97448700,12.11791600,0.00000000,0.00000000,287.26600000); //
CreateObject(1250,2050.96777300,1895.09948700,12.04060600,0.00000000,0.00000000,108.12540000); //end of pits
CreateObject(1238,2095.85107400,1859.89355500,9.99613400,0.00000000,0.00000000,0.00000000); //extra barriers
CreateObject(1238,2096.28881800,1863.60327100,10.00178100,0.00000000,0.00000000,0.00000000); //
CreateObject(1238,2095.03735400,1867.43542500,10.13676300,0.00000000,0.00000000,0.00000000); //
CreateObject(1238,2092.37109400,1871.40356400,10.43221700,0.00000000,0.00000000,0.00000000); //
CreateObject(1411,2107.21215800,1867.13439900,11.29136000,0.00000000,0.00000000,254.07570000); //
CreateObject(1411,2105.95947300,1862.11767600,11.28960500,0.00000000,0.00000000,258.37280000); //
CreateObject(1411,2104.87109400,1857.05932600,11.25457000,0.00000000,0.00000000,257.51340000); //
CreateObject(1411,1867.46533200,1789.07629400,13.35144200,0.00000000,0.00000000,353.98390000); //
CreateObject(1411,1862.49987800,1790.31884800,13.35144200,0.00000000,0.00000000,337.50000000); //
CreateObject(1411,1858.38183600,1793.06079100,13.35144200,0.00000000,0.00000000,315.93670000); //
CreateObject(1411,1855.18481400,1797.14917000,13.34440600,0.00000000,0.00000000,300.31220000); //
CreateObject(1411,1853.42541500,1801.78552200,13.35144200,0.00000000,0.00000000,281.25000000); //
CreateObject(1411,1852.99707000,1806.89880400,13.28306200,0.00000000,0.00000000,270.00000000); //
CreateObject(1411,1853.00744600,1812.07055700,13.06946800,0.00000000,0.00000000,270.00000000); //
CreateObject(1411,1853.03723100,1817.27563500,12.85449700,0.00000000,0.00000000,270.00000000); //
CreateObject(1411,1853.07568400,1822.45361300,12.64306600,0.00000000,0.00000000,270.00000000); //
CreateObject(1411,1852.92004400,1827.74035600,12.54173500,0.00000000,0.00000000,270.00000000); //
CreateObject(1411,1852.92004400,1832.91320800,12.24897000,0.00000000,0.00000000,270.00000000); //
CreateObject(1411,1852.92004400,1838.15942400,12.33633100,0.00000000,0.00000000,270.00000000); //
CreateObject(1411,1852.91406300,1843.37304700,12.39462100,0.00000000,0.00000000,270.00000000); //
CreateObject(1411,1852.91406300,1848.58703600,12.19285200,0.00000000,0.00000000,270.00000000); //
CreateObject(1411,1852.91406300,1853.74182100,12.07042300,0.00000000,0.00000000,270.00000000); //
CreateObject(1411,1852.93908700,1858.99108900,12.07420400,0.00000000,0.00000000,270.00000000); //
CreateObject(1411,1852.98913600,1864.21984900,12.12194900,0.00000000,0.00000000,270.00000000); //
CreateObject(1411,1852.91406300,1869.31530800,12.35769500,0.00000000,0.00000000,270.00000000); //
CreateObject(1411,1852.91406300,1874.47668500,12.40973700,0.00000000,0.00000000,270.00000000); //
CreateObject(1411,1852.91406300,1879.73986800,12.33027600,0.00000000,0.00000000,270.00000000); //
CreateObject(1411,1852.83129900,1884.99414100,12.37549400,0.00000000,0.00000000,270.00000000); //
CreateObject(1411,1852.80139200,1890.15734900,12.34649300,0.00000000,0.00000000,270.00000000); //
CreateObject(1411,1852.79699700,1895.31787100,12.31187200,0.00000000,0.00000000,270.00000000); //
CreateObject(1411,1852.71215800,1900.53686500,12.28383400,0.00000000,0.00000000,270.00000000); //
CreateObject(1411,1852.81750500,1905.55285600,12.25688600,0.00000000,0.00000000,270.00000000); //
CreateObject(1411,1852.77111800,1910.76037600,12.23077400,0.00000000,0.00000000,270.00000000); //
CreateObject(1411,1852.77050800,1915.93408200,12.20171500,0.00000000,0.00000000,270.00000000); //
CreateObject(1411,1852.72998000,1921.21618700,12.17204700,0.00000000,0.00000000,270.00000000); //
CreateObject(1411,1852.47863800,1926.79724100,12.14070000,0.00000000,0.00000000,270.00000000); //
CreateObject(978,2101.38330100,1970.56042500,10.57412100,0.00000000,0.00000000,60.54720000); //
CreateObject(2792,2109.48779300,1976.62890600,16.28000500,0.00000000,0.00000000,180.00000000); //
CreateObject(970,2109.42358400,1974.58056600,10.37633200,0.00000000,0.00000000,311.87160000); //
CreateObject(970,2104.89111300,1968.56457500,10.31982900,0.00000000,0.00000000,1.01410000); //
CreateObject(978,2086.63549800,2006.77636700,10.66053300,0.00000000,0.00000000,157.50000000); //
CreateObject(978,2094.55664100,2002.00659200,10.66053300,0.00000000,0.00000000,140.23390000); //
CreateObject(978,2099.85302700,1995.94189500,10.66053300,0.00000000,0.00000000,120.23490000); //
CreateObject(978,2106.57861300,1867.47607400,10.52244900,0.00000000,0.00000000,258.75000000); //
CreateObject(978,2105.03369100,1859.79138200,10.52120500,0.00000000,0.00000000,259.53210000); //
CreateObject(970,2100.96752900,1967.55590800,10.34114200,0.00000000,0.00000000,27.26120000); //
CreateObject(970,2110.90991200,1970.84741200,10.25468100,0.00000000,0.00000000,273.06010000); //
CreateObject(978,1981.30957000,2008.77941900,10.44193600,0.00000000,2.57830000,180.00000000); //
CreateObject(978,1990.67175300,2008.77600100,10.67434400,0.00000000,0.00000000,180.00000000); //
CreateObject(978,2000.03442400,2008.78430200,10.66053300,0.00000000,0.00000000,180.00000000); //
CreateObject(978,2009.20837400,2008.77526900,10.66053300,0.00000000,0.00000000,180.00000000); //
CreateObject(978,2018.42102100,2008.79638700,10.66053300,0.00000000,0.00000000,180.00000000); //
CreateObject(978,2027.60900900,2008.82019000,10.66053300,0.00000000,0.00000000,180.00000000); //
CreateObject(978,2036.89782700,2008.84179700,10.66053300,0.00000000,0.00000000,180.00000000); //
CreateObject(978,2046.19836400,2008.86157200,10.66053300,0.00000000,0.00000000,180.00000000); //
CreateObject(978,2055.47876000,2008.85327100,10.66053300,0.00000000,0.00000000,180.00000000); //
CreateObject(978,2064.77319300,2008.90148900,10.66053300,0.00000000,0.00000000,180.00000000); //
CreateObject(978,2073.74853500,2008.90393100,10.66053300,0.00000000,0.00000000,180.00000000); //
CreateObject(978,2081.21118200,2008.32690400,10.66053300,0.00000000,0.00000000,171.32830000); //
CreateObject(1425,2106.73657200,1863.20031700,10.13059200,0.00000000,0.00000000,78.75000000); //
CreateObject(979,1921.19030800,1964.60681200,7.43397000,0.00000000,0.00000000,24.21890000); //
CreateObject(979,1929.29150400,1969.13977100,7.43397000,0.00000000,0.00000000,33.75000000); //
CreateObject(979,1936.83874500,1974.18225100,7.43397000,0.00000000,0.00000000,33.75000000); //
CreateObject(979,1944.31201200,1979.17712400,7.43397000,0.00000000,0.00000000,33.75000000); //
CreateObject(979,1951.96899400,1984.30676300,7.43397000,0.00000000,0.00000000,33.75000000); //
CreateObject(979,1959.90466300,1988.77172900,8.15895900,0.00000000,350.54620000,25.93770000); //
CreateObject(979,1968.08361800,1992.11621100,9.95959200,0.00000000,346.24900000,19.06220000); //
CreateObject(978,1920.88061500,1979.22229000,7.43397000,0.00000000,0.00000000,217.18780000); //
CreateObject(978,1928.26745600,1984.85461400,7.43397000,0.00000000,0.00000000,217.18780000); //
CreateObject(978,1935.60229500,1990.48620600,7.43397000,0.00000000,0.00000000,218.04720000); //
CreateObject(978,1942.87744100,1995.74926800,7.43397000,0.00000000,0.00000000,213.75000000); //
CreateObject(978,1950.05261200,2000.40148900,7.60897100,0.00000000,2.57830000,212.03110000); //
CreateObject(978,1957.42456100,2004.27356000,8.13281200,0.00000000,4.29720000,204.29610000); //
CreateObject(978,1965.92163100,2007.15637200,9.06113100,0.00000000,6.87550000,193.90560000); //
CreateObject(978,1974.06762700,2008.53344700,9.94465500,358.28110000,5.15660000,184.37450000); //
CreateObject(978,1921.96752900,1792.27673300,12.65891200,0.00000000,0.00000000,270.38670000); //
CreateObject(978,2102.85766600,1987.26013200,10.66053300,0.00000000,0.00000000,97.81230000); //
CreateObject(978,2103.48242200,1978.92578100,10.66053300,0.00000000,0.00000000,90.00000000); //
CreateObject(1319,2098.90234400,1966.89746100,10.36360800,0.00000000,0.00000000,11.25000000); //
CreateObject(1319,2092.13818400,1974.58691400,10.36718800,0.00000000,0.00000000,0.00000000); //
CreateObject(970,2108.96923800,1968.65881300,10.30295900,0.00000000,0.00000000,1.71890000); //
CreateObject(978,1921.92334000,1801.64050300,12.65094100,0.00000000,0.00000000,270.00000000); //
CreateObject(978,1877.44482400,1790.20568800,12.58391300,0.00000000,0.00000000,0.00000000); //
CreateObject(978,1886.79418900,1790.20385700,12.58865300,0.00000000,0.00000000,0.00000000); //
CreateObject(978,1862.94677700,1941.37731900,7.43480800,0.00000000,0.00000000,213.75000000); //
CreateObject(978,1856.11010700,1935.13159200,7.43480800,0.00000000,0.00000000,231.09340000); //
CreateObject(978,1913.06250000,1974.76086400,7.43480800,0.00000000,0.00000000,213.75000000); //
CreateObject(978,1906.54821800,1968.29089400,7.43480800,0.00000000,0.00000000,236.25010000); //
CreateObject(978,1903.16564900,1959.76477100,7.43480800,0.00000000,0.00000000,260.54620000); //
CreateObject(978,1902.36071800,1950.70153800,7.43480800,0.00000000,0.00000000,269.06320000); //
CreateObject(979,1963.82885700,1768.67236300,12.58391300,0.00000000,0.00000000,209.37560000); //
CreateObject(979,1957.60266100,1762.20910600,12.53391400,0.00000000,0.85940000,242.26610000); //
CreateObject(979,1954.82910200,1750.42138700,12.59196000,0.00000000,0.00000000,270.00000000); //
CreateObject(979,1959.43957500,1740.10327100,12.58391300,0.00000000,0.00000000,0.00000000); //
CreateObject(979,1968.81201200,1740.11682100,12.59467900,0.00000000,0.00000000,0.00000000); //
CreateObject(979,1954.81897000,1743.29150400,12.59370300,0.00000000,0.00000000,270.00000000); //
CreateObject(978,1908.40637200,1776.95715300,12.58391300,0.00000000,0.00000000,230.07940000); //
CreateObject(978,1914.70837400,1783.83386200,12.58391300,0.00000000,0.00000000,225.00000000); //
//=====================================================[ Vélodrome circuit bmx etc... Par Bender_Jhonny ]============================================
CreateObject(13662,743.29998779,505.00000000,7.19999981,0.00000000,0.00000000,192.00000000); //object(dirtcock) (2)
CreateObject(13665,742.89941406,504.59960938,7.30000019,0.00000000,0.00000000,191.99707031); //object(dirtfences2) (1)
CreateObject(13664,743.29998779,504.89999390,7.30000019,0.00000000,0.00000000,192.00000000); //object(dirtroad) (1)
CreateObject(13663,743.19921875,504.69921875,7.30000019,0.00000000,0.00000000,191.99707031); //object(dirtfences) (1)
CreateObject(13614,-1945.79980469,2172.29980469,13.69999981,0.00000000,0.00000000,221.98974609); //object(thebowl12) (1)
CreateObject(13618,-1920.89941406,2106.89941406,10.89999962,0.00000000,0.00000000,221.99523926); //object(thebowl16) (3)
CreateObject(13621,-1937.90002441,2053.10009766,10.80000019,0.00000000,0.00000000,222.00000000); //object(thebolla03) (2)
CreateObject(13617,-2011.59960938,2166.00000000,14.00000000,0.00000000,0.00000000,221.99523926); //object(thebowl14) (2)
CreateObject(8661,-1893.79980469,2142.89941406,0.00000000,0.00000000,90.00000000,13.99658203); //object(gnhtelgrnd_lvs) (1)
CreateObject(13652,-2059.39941406,2123.79980469,11.00000000,0.00000000,0.00000000,221.98974609); //object(oroadbit) (1)
CreateObject(13613,-2111.10009766,2070.89990234,11.00000000,0.00000000,0.00000000,222.00000000); //object(thebowl11) (1)
CreateObject(13615,-2124.10009766,2026.59997559,11.10000038,0.00000000,0.00000000,222.00000000); //object(thebowl10) (1)
CreateObject(13611,-2078.80004883,1977.40002441,11.39999962,0.00000000,0.00000000,220.00000000); //object(thebowl13) (1)
CreateObject(13616,-2032.59997559,1979.30004883,11.10000038,0.00000000,0.00000000,220.00000000); //object(thebolla04) (1)
CreateObject(13619,-1979.09960938,2012.50000000,10.60000038,0.00000000,0.00000000,221.98974609); //object(thebowl17) (2)
CreateObject(13653,-2020.50000000,2076.10009766,35.50000000,0.00000000,0.00000000,42.00000000); //object(innerfence) (2)
CreateObject(8661,-1901.09997559,2160.60009766,0.00000000,0.00000000,90.00000000,29.99658203); //object(gnhtelgrnd_lvs) (1)
CreateObject(8661,-1913.09997559,2175.80004883,0.00000000,0.00000000,90.00000000,43.99267578); //object(gnhtelgrnd_lvs) (1)
CreateObject(8661,-1928.50000000,2188.10009766,0.00000000,0.00000000,90.00000000,57.98925781); //object(gnhtelgrnd_lvs) (1)
CreateObject(8661,-1945.40002441,2194.39990234,0.00000000,0.00000000,90.00000000,79.98583984); //object(gnhtelgrnd_lvs) (1)
CreateObject(8661,-1964.59997559,2195.89990234,0.00000000,0.00000000,90.00000000,89.98046875); //object(gnhtelgrnd_lvs) (1)
CreateObject(8661,-1984.09997559,2194.60009766,0.00000000,0.00000000,90.00000000,97.97607422); //object(gnhtelgrnd_lvs) (1)
CreateObject(8661,-2003.09997559,2190.69995117,0.00000000,0.00000000,90.00000000,105.97607422); //object(gnhtelgrnd_lvs) (1)
CreateObject(8661,-2021.19995117,2183.80004883,0.00000000,0.00000000,90.00000000,113.97412109); //object(gnhtelgrnd_lvs) (1)
CreateObject(8661,-2038.30004883,2174.60009766,0.00000000,0.00000000,90.00000000,121.97216797); //object(gnhtelgrnd_lvs) (1)
CreateObject(8661,-2054.30004883,2163.69995117,0.00000000,0.00000000,90.00000000,125.97021484); //object(gnhtelgrnd_lvs) (1)
CreateObject(8661,-2069.19995117,2151.39990234,0.00000000,0.00000000,90.00000000,131.96923828); //object(gnhtelgrnd_lvs) (1)
CreateObject(8661,-2069.19921875,2151.39941406,0.00000000,0.00000000,90.00000000,131.96777344); //object(gnhtelgrnd_lvs) (1)
CreateObject(8661,-2083.60009766,2138.30004883,0.00000000,0.00000000,90.00000000,131.96777344); //object(gnhtelgrnd_lvs) (1)
CreateObject(8661,-2098.00000000,2125.19995117,0.00000000,0.00000000,90.00000000,131.96777344); //object(gnhtelgrnd_lvs) (1)
CreateObject(8661,-2111.89990234,2111.60009766,0.00000000,0.00000000,90.00000000,135.96777344); //object(gnhtelgrnd_lvs) (1)
CreateObject(8661,-2124.30004883,2096.69995117,0.00000000,0.00000000,90.00000000,143.96679688); //object(gnhtelgrnd_lvs) (1)
CreateObject(8661,-2134.50000000,2080.39990234,0.00000000,0.00000000,90.00000000,151.96484375); //object(gnhtelgrnd_lvs) (1)
CreateObject(8661,-2142.60009766,2062.80004883,0.00000000,0.00000000,90.00000000,157.96289062); //object(gnhtelgrnd_lvs) (1)
CreateObject(8661,-2148.60009766,2044.19995117,0.00000000,0.00000000,90.00000000,165.96142578); //object(gnhtelgrnd_lvs) (1)
CreateObject(8661,-2152.30004883,2025.30004883,0.00000000,0.00000000,90.00000000,171.95947266); //object(gnhtelgrnd_lvs) (1)
CreateObject(8661,-2151.80004883,2006.00000000,0.00000000,0.00000000,90.00000000,189.95800781); //object(gnhtelgrnd_lvs) (1)
CreateObject(8661,-2145.69995117,1987.40002441,0.00000000,0.00000000,90.00000000,205.95361328); //object(gnhtelgrnd_lvs) (1)
CreateObject(8661,-2135.00000000,1971.09997559,0.00000000,0.00000000,90.00000000,219.94970703); //object(gnhtelgrnd_lvs) (1)
CreateObject(8661,-2120.10009766,1958.59997559,0.00000000,0.00000000,90.00000000,239.94628906); //object(gnhtelgrnd_lvs) (1)
CreateObject(8661,-2102.10009766,1950.90002441,0.00000000,0.00000000,90.00000000,253.94140625); //object(gnhtelgrnd_lvs) (1)
CreateObject(8661,-2083.60009766,1947.59997559,0.00000000,0.00000000,90.00000000,265.93798828); //object(gnhtelgrnd_lvs) (1)
CreateObject(8661,-2064.10009766,1948.40002441,0.00000000,0.00000000,90.00000000,277.93505859); //object(gnhtelgrnd_lvs) (1)
CreateObject(8661,-2044.90002441,1951.90002441,0.00000000,0.00000000,90.00000000,281.93212891); //object(gnhtelgrnd_lvs) (1)
CreateObject(8661,-2025.59997559,1956.00000000,0.00000000,0.00000000,90.00000000,281.93115234); //object(gnhtelgrnd_lvs) (1)
CreateObject(8661,-2006.40002441,1960.50000000,0.00000000,0.00000000,90.00000000,283.93115234); //object(gnhtelgrnd_lvs) (1)
CreateObject(8661,-1987.90002441,1966.19995117,0.00000000,0.00000000,90.00000000,289.93066406); //object(gnhtelgrnd_lvs) (1)
CreateObject(8661,-1970.09997559,1973.80004883,0.00000000,0.00000000,90.00000000,295.92919922); //object(gnhtelgrnd_lvs) (1)
CreateObject(8661,-1953.80004883,1984.09997559,0.00000000,0.00000000,90.00000000,307.92773438); //object(gnhtelgrnd_lvs) (1)
CreateObject(8661,-1939.90002441,1997.59997559,0.00000000,0.00000000,90.00000000,319.92480469); //object(gnhtelgrnd_lvs) (1)
CreateObject(8661,-1928.80004883,2013.40002441,0.00000000,0.00000000,90.00000000,329.92187500); //object(gnhtelgrnd_lvs) (1)
CreateObject(8661,-1920.19995117,2030.90002441,0.00000000,0.00000000,90.00000000,337.91943359); //object(gnhtelgrnd_lvs) (1)
CreateObject(8661,-1913.09997559,2049.10009766,0.00000000,0.00000000,90.00000000,337.91748047); //object(gnhtelgrnd_lvs) (1)
CreateObject(8661,-1906.09997559,2066.80004883,0.00000000,0.00000000,90.00000000,337.91748047); //object(gnhtelgrnd_lvs) (1)
CreateObject(8661,-1898.90002441,2084.80004883,0.00000000,0.00000000,90.00000000,337.91748047); //object(gnhtelgrnd_lvs) (1)
CreateObject(8661,-1892.90002441,2103.80004883,0.00000000,0.00000000,90.00000000,345.91748047); //object(gnhtelgrnd_lvs) (1)
CreateObject(8661,-1891.09997559,2123.30004883,0.00000000,0.00000000,90.00000000,1.91552734); //object(gnhtelgrnd_lvs) (1)
CreateObject(8373,-1887.69995117,2170.19995117,-10.19999981,0.00000000,0.00000000,126.00000000); //object(vegass_jetty01) (2)
CreateObject(14877,-1908.19995117,2145.50000000,19.79999924,0.00000000,0.00000000,126.00000000); //object(michelle-stairs) (2)
CreateObject(3819,775.09997559,401.00000000,20.50000000,0.00000000,0.00000000,284.00000000); //object(bleacher_sfsx) (1)
CreateObject(3819,766.79998779,399.10000610,20.50000000,0.00000000,0.00000000,283.99658203); //object(bleacher_sfsx) (2)
CreateObject(3819,758.59997559,396.89999390,20.50000000,0.00000000,0.00000000,283.99658203); //object(bleacher_sfsx) (3)
CreateObject(3819,759.50000000,393.00000000,22.29999924,0.00000000,0.00000000,283.99658203); //object(bleacher_sfsx) (4)
CreateObject(3819,767.79998779,394.89999390,22.29999924,0.00000000,0.00000000,283.99658203); //object(bleacher_sfsx) (5)
CreateObject(3819,776.09997559,397.00000000,22.29999924,0.00000000,0.00000000,283.99658203); //object(bleacher_sfsx) (6)
CreateObject(13630,706.79998779,541.59997559,19.00000000,0.00000000,0.00000000,286.00000000); //object(8screen) (1)
CreateObject(3819,743.09997559,395.10000610,21.29999924,0.00000000,0.00000000,279.99658203); //object(bleacher_sfsx) (7)
CreateObject(3819,734.90002441,393.60000610,21.29999924,0.00000000,0.00000000,279.99206543); //object(bleacher_sfsx) (8)
CreateObject(3819,726.50000000,392.10000610,21.29999924,0.00000000,0.00000000,279.99206543); //object(bleacher_sfsx) (9)
CreateObject(3819,743.79998779,390.89999390,23.00000000,0.00000000,0.00000000,279.99206543); //object(bleacher_sfsx) (10)
CreateObject(3819,735.70001221,389.39999390,23.00000000,0.00000000,0.00000000,279.99206543); //object(bleacher_sfsx) (11)
CreateObject(3819,727.29998779,388.10000610,23.00000000,0.00000000,0.00000000,279.99206543); //object(bleacher_sfsx) (12)
CreateObject(14877,-1904.69995117,2140.89990234,15.50000000,0.00000000,0.00000000,125.99670410); //object(michelle-stairs) (2)
CreateObject(14877,-1924.90002441,2169.10009766,19.79999924,0.00000000,0.00000000,305.99670410); //object(michelle-stairs) (2)
CreateObject(14877,-1928.30004883,2173.69995117,15.80000019,0.00000000,0.00000000,305.99121094);//object(michelle-stairs) (2)
CreateObject(3452,-1948.30004883,2187.89990234,17.00000000,0.00000000,0.00000000,166.00000000); //object(bballintvgn1) (1)
CreateObject(3452,-1974.00000000,2190.10009766,17.00000000,0.00000000,0.00000000,183.99792480); //object(bballintvgn1) (2)
CreateObject(3452,-2000.09997559,2185.30004883,17.00000000,0.00000000,0.00000000,195.99353027); //object(bballintvgn1) (3)
CreateObject(3452,-2025.19995117,2175.39990234,17.00000000,0.00000000,0.00000000,205.99060059); //object(bballintvgn1) (4)
CreateObject(3452,-2048.39990234,2161.60009766,17.00000000,0.00000000,0.00000000,215.98815918); //object(bballintvgn1) (5)
CreateObject(3452,-2069.30004883,2144.39990234,17.00000000,0.00000000,0.00000000,221.98571777); //object(bballintvgn1) (6)
CreateObject(3452,-2090.50000000,2125.30004883,17.00000000,0.00000000,0.00000000,221.98425293); //object(bballintvgn1) (7)
CreateObject(3452,-2110.00000000,2105.89990234,17.00000000,0.00000000,0.00000000,227.98425293); //object(bballintvgn1) (8)
CreateObject(3452,-2125.39990234,2085.39990234,17.00000000,0.00000000,0.00000000,237.98278809); //object(bballintvgn1) (9)
CreateObject(3452,-2137.39990234,2061.39990234,17.00000000,0.00000000,0.00000000,249.98034668); //object(bballintvgn1) (10)
CreateObject(3452,-2144.39990234,2035.19995117,17.00000000,0.00000000,0.00000000,259.97741699); //object(bballintvgn1) (11)
CreateObject(3452,-2145.00000000,2009.40002441,17.00000000,0.00000000,0.00000000,277.97497559); //object(bballintvgn1) (12)
CreateObject(3452,-2137.30004883,1986.09997559,17.00000000,0.00000000,0.00000000,299.97058105); //object(bballintvgn1) (13)
CreateObject(3452,-2120.89990234,1968.19995117,17.00000000,0.00000000,0.00000000,325.96520996); //object(bballintvgn1) (14)
CreateObject(3452,-2097.80004883,1957.80004883,17.00000000,0.00000000,0.00000000,345.96435547); //object(bballintvgn1) (15)
CreateObject(3452,-2072.10009766,1955.80004883,17.00000000,0.00000000,0.00000000,5.95947266); //object(bballintvgn1) (16)
CreateObject(10932,-1975.40002441,1996.09997559,21.50000000,0.00000000,0.00000000,131.99670410); //object(station03_sfs) (1)
CreateObject(13608,-2019.19995117,2077.60009766,15.69999981,0.00000000,0.00000000,42.00000000); //object(sumoring) (1)
CreateObject(3281,-1987.69995117,2131.19995117,1.29999995,0.00000000,0.00000000,180.00000000); //object(mtb_banner1) (1)
CreateObject(3281,-2080.80004883,2059.30004883,1.29999995,0.00000000,0.00000000,243.99450684); //object(mtb_banner1) (2)
CreateObject(3281,-1991.19921875,2131.00000000,1.29999995,0.00000000,0.00000000,185.99304199); //object(mtb_banner1) (3)
CreateObject(3281,-1994.69921875,2130.59960938,1.29999995,0.00000000,0.00000000,185.99304199); //object(mtb_banner1) (4)
CreateObject(3281,-1998.19921875,2130.09960938,1.29999995,0.00000000,0.00000000,191.99157715); //object(mtb_banner1) (5)
CreateObject(3281,-2001.69921875,2129.39941406,1.29999995,0.00000000,0.00000000,191.99157715); //object(mtb_banner1) (6)
CreateObject(3281,-2005.09960938,2128.39941406,1.29999995,0.00000000,0.00000000,199.98962402); //object(mtb_banner1) (7)
CreateObject(3281,-2008.50000000,2127.19921875,1.29999995,0.00000000,0.00000000,199.98962402); //object(mtb_banner1) (8)
CreateObject(3281,-2011.79980469,2126.00000000,1.29999995,0.00000000,0.00000000,199.98962402); //object(mtb_banner1) (9)
CreateObject(3281,-2015.29980469,2124.79980469,1.50000000,0.00000000,0.00000000,199.98962402); //object(mtb_banner1) (10)
CreateObject(3281,-2018.79980469,2123.69921875,1.89999998,0.00000000,0.00000000,195.99060059); //object(mtb_banner1) (11)
CreateObject(3281,-2022.19921875,2122.50000000,2.20000005,0.00000000,0.00000000,203.99414062); //object(mtb_banner1) (12)
CreateObject(3281,-2025.50000000,2121.00000000,2.50000000,0.00000000,0.00000000,203.99414062); //object(mtb_banner1) (13)
CreateObject(3281,-2028.89941406,2119.59960938,2.70000005,0.00000000,0.00000000,203.99414062); //object(mtb_banner1) (14)
CreateObject(3281,-2032.19921875,2118.19921875,2.90000010,0.00000000,0.00000000,203.99414062); //object(mtb_banner1) (15)
CreateObject(3281,-2035.39941406,2116.69921875,2.90000010,0.00000000,0.00000000,207.99316406); //object(mtb_banner1) (16)
CreateObject(3281,-2038.39941406,2114.89941406,3.09999990,0.00000000,0.00000000,213.99169922); //object(mtb_banner1) (17)
CreateObject(3281,-2041.29980469,2112.69921875,3.20000005,0.00000000,0.00000000,221.98974609); //object(mtb_banner1) (18)
CreateObject(3281,-2051.19921875,2103.89941406,3.20000005,0.00000000,0.00000000,221.98974609); //object(mtb_banner1) (19)
CreateObject(3281,-2053.59960938,2101.29980469,3.09999990,0.00000000,0.00000000,227.99377441); //object(mtb_banner1) (20)
CreateObject(3281,-2056.00000000,2098.59960938,3.00000000,0.00000000,0.00000000,227.99377441); //object(mtb_banner1) (21)
CreateObject(3281,-2058.29980469,2095.79980469,2.79999995,0.00000000,0.00000000,233.99230957); //object(mtb_banner1) (22)
CreateObject(3281,-2060.39941406,2092.89941406,2.59999990,0.00000000,0.00000000,233.99230957); //object(mtb_banner1) (23)
CreateObject(3281,-2062.39941406,2090.00000000,2.40000010,0.00000000,0.00000000,237.99133301); //object(mtb_banner1) (24)
CreateObject(3281,-2064.29980469,2087.00000000,2.09999990,0.00000000,0.00000000,237.99133301); //object(mtb_banner1) (25)
CreateObject(3281,-2066.19921875,2084.00000000,1.70000005,0.00000000,0.00000000,237.99133301); //object(mtb_banner1) (26)
CreateObject(3281,-2068.00000000,2080.89941406,1.29999995,0.00000000,0.00000000,241.99035645); //object(mtb_banner1) (27)
CreateObject(3281,-2069.89941406,2077.89941406,1.29999995,0.00000000,0.00000000,235.99182129); //object(mtb_banner1) (28)
CreateObject(3281,-2071.89941406,2074.89941406,1.29999995,0.00000000,0.00000000,235.99182129); //object(mtb_banner1) (29)
CreateObject(3281,-2073.89941406,2072.00000000,1.29999995,0.00000000,0.00000000,233.99230957); //object(mtb_banner1) (30)
CreateObject(3281,-2075.89941406,2069.00000000,1.29999995,0.00000000,0.00000000,239.99084473); //object(mtb_banner1) (31)
CreateObject(3281,-2077.59960938,2065.79980469,1.29999995,0.00000000,0.00000000,243.98986816); //object(mtb_banner1) (32)
CreateObject(3281,-2079.19921875,2062.59960938,1.29999995,0.00000000,0.00000000,243.98986816); //object(mtb_banner1) (33)
CreateObject(3281,-2085.80004883,2042.00000000,1.60000002,0.00000000,0.00000000,263.98986816); //object(mtb_banner1) (34)
CreateObject(3281,-2082.19921875,2056.00000000,1.29999995,0.00000000,0.00000000,251.98791504); //object(mtb_banner1) (35)
CreateObject(3281,-2083.19921875,2052.59960938,1.29999995,0.00000000,0.00000000,255.98693848); //object(mtb_banner1) (36)
CreateObject(3281,-2084.09960938,2049.09960938,1.29999995,0.00000000,0.00000000,255.98693848); //object(mtb_banner1) (37)
CreateObject(3281,-2085.09960938,2045.50000000,1.50000000,0.00000000,0.00000000,255.98693848); //object(mtb_banner1) (38)
CreateObject(3281,-2079.39990234,2022.69995117,1.89999998,0.00000000,0.00000000,325.98498535); //object(mtb_banner1) (39)
CreateObject(3281,-2086.00000000,2038.50000000,1.70000005,0.00000000,0.00000000,271.98303223); //object(mtb_banner1) (40)
CreateObject(3281,-2085.69921875,2034.89941406,1.79999995,0.00000000,0.00000000,277.98156738); //object(mtb_banner1) (41)
CreateObject(3281,-2084.89941406,2031.39941406,1.79999995,0.00000000,0.00000000,287.98461914); //object(mtb_banner1) (42)
CreateObject(3281,-2083.89941406,2028.09960938,1.89999998,0.00000000,0.00000000,291.98364258); //object(mtb_banner1) (43)
CreateObject(3281,-2082.09960938,2025.09960938,1.89999998,0.00000000,0.00000000,309.98474121); //object(mtb_banner1) (44)
CreateObject(3281,-2076.39990234,2020.69995117,1.79999995,0.00000000,0.00000000,325.98083496); //object(mtb_banner1) (45)
CreateObject(3281,-2073.30004883,2018.90002441,1.79999995,0.00000000,0.00000000,335.98083496); //object(mtb_banner1) (46)
CreateObject(3281,-2070.00000000,2017.59997559,1.70000005,0.00000000,0.00000000,343.97839355); //object(mtb_banner1) (47)
CreateObject(3281,-2066.50000000,2016.59997559,1.70000005,0.00000000,0.00000000,343.97644043); //object(mtb_banner1) (48)
CreateObject(3281,-2063.00000000,2015.90002441,1.60000002,0.00000000,0.00000000,351.97644043); //object(mtb_banner1) (49)
CreateObject(3281,-2059.39990234,2015.59997559,1.50000000,0.00000000,0.00000000,357.97448730); //object(mtb_banner1) (50)
CreateObject(3281,-2055.80004883,2015.59997559,1.39999998,0.00000000,0.00000000,357.97302246); //object(mtb_banner1) (51)
CreateObject(3281,-2052.19995117,2015.80004883,1.29999995,0.00000000,0.00000000,7.97302246); //object(mtb_banner1) (52)
CreateObject(3281,-2048.69995117,2016.59997559,1.29999995,0.00000000,0.00000000,15.97058105); //object(mtb_banner1) (53)
CreateObject(3281,-2045.19995117,2017.59997559,1.29999995,0.00000000,0.00000000,15.96862793); //object(mtb_banner1) (54)
CreateObject(3281,-2041.80004883,2018.59997559,1.29999995,0.00000000,0.00000000,15.96862793); //object(mtb_banner1) (55)
CreateObject(3281,-2038.30004883,2019.59997559,1.29999995,0.00000000,0.00000000,15.96862793); //object(mtb_banner1) (56)
CreateObject(3281,-2034.90002441,2020.80004883,1.29999995,0.00000000,0.00000000,21.96862793); //object(mtb_banner1) (57)
CreateObject(3281,-2031.59997559,2022.09997559,1.29999995,0.00000000,0.00000000,21.96716309); //object(mtb_banner1) (58)
CreateObject(3281,-2028.30004883,2023.59997559,1.29999995,0.00000000,0.00000000,27.96716309); //object(mtb_banner1) (59)
CreateObject(3281,-2025.09997559,2025.30004883,1.29999995,0.00000000,0.00000000,29.96569824); //object(mtb_banner1) (60)
CreateObject(3281,-2022.09997559,2027.19995117,1.29999995,0.00000000,0.00000000,35.96520996); //object(mtb_banner1) (62)
CreateObject(3281,-2019.09997559,2029.09997559,1.89999998,0.00000000,0.00000000,35.96374512); //object(mtb_banner1) (61)
CreateObject(3281,-2016.19995117,2031.19995117,2.00000000,0.00000000,0.00000000,35.96374512); //object(mtb_banner1) (63)
CreateObject(3281,-2013.09997559,2033.09997559,2.20000005,0.00000000,0.00000000,29.96374512); //object(mtb_banner1) (64)
CreateObject(3281,-2010.00000000,2034.80004883,2.50000000,0.00000000,0.00000000,29.95971680); //object(mtb_banner1) (65)
CreateObject(3281,-2006.90002441,2036.50000000,2.70000005,0.00000000,0.00000000,29.95971680); //object(mtb_banner1) (66)
CreateObject(3281,-2003.90002441,2038.50000000,2.90000010,0.00000000,0.00000000,35.95971680); //object(mtb_banner1) (67)
CreateObject(3281,-2000.90002441,2040.59997559,3.20000005,0.00000000,0.00000000,35.95825195); //object(mtb_banner1) (68)
CreateObject(3281,-1995.30004883,2045.19995117,3.20000005,0.00000000,0.00000000,43.95825195); //object(mtb_banner1) (69)
CreateObject(3281,-1998.00000000,2042.79980469,3.20000005,0.00000000,0.00000000,37.95776367); //object(mtb_banner1) (70)
CreateObject(3281,-1984.19995117,2130.80004883,1.29999995,0.00000000,0.00000000,167.95629883); //object(mtb_banner1) (71)
CreateObject(3281,-1980.69995117,2130.00000000,1.29999995,0.00000000,0.00000000,167.95349121); //object(mtb_banner1) (72)
CreateObject(3281,-1968.40002441,2123.50000000,1.29999995,0.00000000,0.00000000,133.95349121); //object(mtb_banner1) (73)
CreateObject(3281,-1977.29980469,2129.09960938,1.29999995,0.00000000,0.00000000,161.94946289); //object(mtb_banner1) (74)
CreateObject(3281,-1974.00000000,2127.79980469,1.29999995,0.00000000,0.00000000,153.95141602); //object(mtb_banner1) (75)
CreateObject(3281,-1971.00000000,2125.89941406,1.29999995,0.00000000,0.00000000,139.94934082); //object(mtb_banner1) (76)
CreateObject(3281,-1966.09997559,2120.80004883,1.29999995,0.00000000,0.00000000,125.95080566); //object(mtb_banner1) (77)
CreateObject(3281,-1964.19995117,2117.80004883,1.29999995,0.00000000,0.00000000,117.94726562); //object(mtb_banner1) (78)
CreateObject(3281,-1962.90002441,2114.50000000,1.29999995,0.00000000,0.00000000,105.94372559); //object(mtb_banner1) (79)
CreateObject(3281,-1962.09997559,2111.00000000,1.29999995,0.00000000,0.00000000,97.94116211); //object(mtb_banner1) (80)
CreateObject(3281,-1961.69995117,2107.50000000,1.29999995,0.00000000,0.00000000,93.93762207); //object(mtb_banner1) (81)
CreateObject(3281,-1961.59997559,2103.89990234,1.29999995,0.00000000,0.00000000,89.93310547); //object(mtb_banner1) (82)
CreateObject(3281,-1961.90002441,2100.30004883,1.29999995,0.00000000,0.00000000,81.92858887); //object(mtb_banner1) (83)
CreateObject(3281,-1964.40002441,2089.80004883,1.29999995,0.00000000,0.00000000,69.92504883); //object(mtb_banner1) (84)
CreateObject(3281,-1962.50000000,2096.69921875,1.29999995,0.00000000,0.00000000,77.92053223); //object(mtb_banner1) (85)
CreateObject(3281,-1963.29980469,2093.19921875,1.29999995,0.00000000,0.00000000,75.92102051); //object(mtb_banner1) (86)
CreateObject(3281,-1965.80004883,2086.50000000,1.29999995,0.00000000,0.00000000,65.92248535); //object(mtb_banner1) (87)
CreateObject(3281,-1967.30004883,2083.30004883,1.29999995,0.00000000,0.00000000,63.91796875); //object(mtb_banner1) (88)
CreateObject(3281,-1969.09997559,2080.19995117,1.29999995,0.00000000,0.00000000,55.91296387); //object(mtb_banner1) (89)
CreateObject(3281,-1971.09997559,2077.19995117,1.29999995,0.00000000,0.00000000,57.90942383); //object(mtb_banner1) (90)
CreateObject(3281,-1973.00000000,2074.10009766,1.70000005,0.00000000,0.00000000,57.90893555); //object(mtb_banner1) (91)
CreateObject(3281,-1974.80004883,2071.00000000,2.09999990,0.00000000,0.00000000,59.90893555); //object(mtb_banner1) (92)
CreateObject(3281,-1978.30004883,2064.69995117,2.59999990,0.00000000,0.00000000,59.90844727); //object(mtb_banner1) (93)
CreateObject(3281,-1976.50000000,2067.79980469,2.40000010,0.00000000,0.00000000,59.90844727); //object(mtb_banner1) (94)
CreateObject(3281,-1980.09997559,2061.50000000,2.79999995,0.00000000,0.00000000,59.90844727); //object(mtb_banner1) (95)
CreateObject(3281,-1984.30004883,2055.69995117,3.09999990,0.00000000,0.00000000,49.90844727); //object(mtb_banner1) (96)
CreateObject(3281,-1982.00000000,2058.50000000,2.90000010,0.00000000,0.00000000,51.90490723); //object(mtb_banner1) (97)
CreateObject(3281,-1986.69995117,2053.00000000,3.20000005,0.00000000,0.00000000,45.90539551); //object(mtb_banner1) (98)
CreateObject(18236,-2073.50000000,2062.80004883,0.20000000,0.00000000,0.00000000,149.99877930); //object(cuntw_shed3_) (1)
CreateObject(18236,-2042.40002441,2023.40002441,0.20000000,0.00000000,0.00000000,285.99633789); //object(cuntw_shed3_) (2)
CreateObject(11326,-2080.50000000,2037.09997559,2.79999995,0.00000000,0.00000000,310.00000000); //object(sfse_hublockup) (1)
CreateObject(11008,-1982.19995117,2111.00000000,7.30000019,0.00000000,0.00000000,48.00000000); //object(firehouse_sfs) (1)
CreateObject(2630,-2027.69995117,2068.69995117,2.09999990,0.00000000,0.00000000,40.00000000); //object(gym_bike) (1)
CreateObject(3281,-2026.19995117,2077.10009766,3.20000005,0.00000000,0.00000000,131.98977661); //object(mtb_banner1) (99)
CreateObject(16770,-2027.00000000,2070.10009766,3.70000005,0.00000000,0.00000000,42.00000000); //object(des_gunbldg01) (1)
CreateObject(2630,-2029.40002441,2067.30004883,2.09999990,0.00000000,0.00000000,39.99572754); //object(gym_bike) (2)
CreateObject(2630,-2031.30004883,2069.60009766,2.09999990,0.00000000,0.00000000,39.99572754); //object(gym_bike) (3)
CreateObject(2630,-2029.59997559,2071.00000000,2.09999990,0.00000000,0.00000000,39.99572754); //object(gym_bike) (4)
CreateObject(3281,-2021.40002441,2071.69995117,3.20000005,0.00000000,0.00000000,131.98977661); //object(mtb_banner1) (100)
CreateObject(3281,-2019.00000000,2069.10009766,3.20000005,0.00000000,0.00000000,131.98977661); //object(mtb_banner1) (101)
CreateObject(3281,-2023.79980469,2074.39941406,3.20000005,0.00000000,0.00000000,131.98977661); //object(mtb_banner1) (102)
CreateObject(3281,-2028.59997559,2079.80004883,3.20000005,0.00000000,0.00000000,131.98977661); //object(mtb_banner1) (103)
CreateObject(3281,-2014.59997559,2082.89990234,3.20000005,0.00000000,0.00000000,311.98974609); //object(mtb_banner1) (104)
CreateObject(16770,-2011.50000000,2087.30004883,3.70000005,0.00000000,0.00000000,221.99523926); //object(des_gunbldg01) (2)
CreateObject(3281,-2012.19995117,2080.19995117,3.20000005,0.00000000,0.00000000,311.98425293); //object(mtb_banner1) (105)
CreateObject(3281,-2009.69995117,2077.50000000,3.20000005,0.00000000,0.00000000,311.98425293); //object(mtb_banner1) (106)
CreateObject(3281,-2017.00000000,2085.60009766,3.20000005,0.00000000,0.00000000,311.98425293); //object(mtb_banner1) (107)
CreateObject(3281,-2019.40002441,2088.30004883,3.20000005,0.00000000,0.00000000,311.98425293); //object(mtb_banner1) (108)
CreateObject(2630,-2009.09997559,2085.80004883,2.09999990,0.00000000,0.00000000,41.99572754); //object(gym_bike) (5)
CreateObject(2630,-2011.40002441,2088.50000000,2.09999990,0.00000000,0.00000000,41.99523926); //object(gym_bike) (6)
CreateObject(2630,-2008.90002441,2090.60009766,2.09999990,0.00000000,0.00000000,41.99523926); //object(gym_bike) (7)
CreateObject(2630,-2006.59997559,2087.89990234,2.09999990,0.00000000,0.00000000,41.99523926); //object(gym_bike) (8)
CreateObject(3452,-2045.19995117,1960.40002441,17.00000000,0.00000000,0.00000000,13.95458984); //object(bballintvgn1) (17)
CreateObject(3452,-2019.80004883,1968.90002441,17.00000000,0.00000000,0.00000000,23.95263672); //object(bballintvgn1) (18)
CreateObject(3452,-1996.80004883,1982.40002441,17.00000000,0.00000000,0.00000000,37.95019531); //object(bballintvgn1) (19)
CreateObject(3452,-1974.59997559,2000.40002441,17.00000000,0.00000000,0.00000000,39.94677734); //object(bballintvgn1) (20)
CreateObject(3452,-1952.19995117,2019.00000000,17.00000000,0.00000000,0.00000000,39.94628906); //object(bballintvgn1) (21)
CreateObject(3452,-1931.59997559,2038.09997559,17.00000000,0.00000000,0.00000000,45.94628906); //object(bballintvgn1) (22)
CreateObject(3452,-1917.69995117,2058.80004883,17.00000000,0.00000000,0.00000000,65.94482422); //object(bballintvgn1) (23)
CreateObject(3452,-1906.19995117,2085.00000000,17.00000000,0.00000000,0.00000000,65.93994141); //object(bballintvgn1) (24)
CreateObject(3452,-1899.00000000,2109.89990234,17.00000000,0.00000000,0.00000000,79.93994141); //object(bballintvgn1) (25)
CreateObject(10932,-2014.30004883,1969.00000000,21.50000000,0.00000000,0.00000000,113.99523926); //object(station03_sfs) (1)
CreateObject(10932,-2061.19995117,1955.69995117,21.50000000,0.00000000,0.00000000,95.99414062); //object(station03_sfs) (1)
CreateObject(10932,-2104.89990234,1962.80004883,21.50000000,0.00000000,0.00000000,65.99304199); //object(station03_sfs) (1)
CreateObject(10932,-2139.19995117,1991.90002441,21.50000000,0.00000000,0.00000000,23.98937988); //object(station03_sfs) (1)
CreateObject(10932,-2145.19995117,2042.19995117,21.50000000,0.00000000,0.00000000,351.98864746); //object(station03_sfs) (1)
CreateObject(10932,-2126.89990234,2089.69995117,21.50000000,0.00000000,0.00000000,327.98547363); //object(station03_sfs) (1)
CreateObject(10932,-2092.89990234,2130.39990234,21.50000000,0.00000000,0.00000000,311.98034668); //object(station03_sfs) (1)
CreateObject(10932,-2051.80004883,2164.60009766,21.50000000,0.00000000,0.00000000,303.97875977); //object(station03_sfs) (1)
CreateObject(10932,-2004.19995117,2189.50000000,21.50000000,0.00000000,0.00000000,287.97521973); //object(station03_sfs) (1)
CreateObject(10932,-1963.90002441,2195.39990234,21.50000000,0.00000000,0.00000000,263.97363281); //object(station03_sfs) (1)
CreateObject(10932,-1937.19995117,2033.50000000,21.50000000,0.00000000,0.00000000,135.99523926); //object(station03_sfs) (1)
CreateObject(10932,-1908.30004883,2074.30004883,21.50000000,0.00000000,0.00000000,153.99426270); //object(station03_sfs) (1)
CreateObject(10932,-1898.09997559,2101.39990234,21.50000000,0.00000000,0.00000000,167.98986816); //object(station03_sfs) (1)
CreateObject(18275,-2049.10009766,2111.19995117,4.69999981,0.00000000,0.00000000,312.00000000); //object(cw2_mtbfinish) (1)
CreateObject(18275,-1988.69995117,2045.69995117,4.69999981,0.00000000,0.00000000,311.99523926); //object(cw2_mtbfinish) (2)
CreateObject(3095,-1861.00000000,2197.39990234,11.00000000,0.00000000,0.00000000,306.00000000); //object(a51_jetdoor) (1)
CreateObject(3095,-1853.90002441,2202.60009766,11.00000000,0.00000000,0.00000000,305.99670410); //object(a51_jetdoor) (2)
CreateObject(3095,-1847.00000000,2207.69995117,11.00000000,0.00000000,0.00000000,305.99670410); //object(a51_jetdoor) (3)
//==========================================================[ CIRCUIT SF ]===========================================================
CreateObject(7933,-1717.75781250,1285.02441406,6.75461817,0.00000000,0.00000000,175.13659668); //object
CreateObject(978,-1709.38378906,1301.05468750,5.71292305,0.00000000,0.00000000,154.74658203); //object(9)
CreateObject(978,-1701.74121094,1295.94042969,5.70427799,0.00000000,0.00000000,136.35107422); //object(12)
CreateObject(978,-1718.36035156,1302.84667969,5.70427799,0.00000000,0.00000000,183.13659668); //object(13)
CreateObject(978,-1764.84863281,1275.67089844,8.34767532,0.00000000,353.00000000,181.18603516); //object(15)
CreateObject(978,-1768.66601562,1275.51367188,8.75868702,0.00000000,353.00000000,181.18603516); //object(16)
CreateObject(978,-1777.71777344,1276.50097656,9.73647785,0.00000000,353.00000000,166.89489746); //object(17)
CreateObject(978,-1785.79296875,1278.08593750,10.60839176,0.00000000,353.00000000,172.99926758); //object(18)
CreateObject(978,-1794.70410156,1279.00683594,11.52537060,0.00000000,353.00000000,175.06518555); //object(19)
CreateObject(978,-1800.29882812,1279.44824219,12.08471298,0.00000000,353.00000000,175.06518555); //object(21)
CreateObject(978,-1807.69433594,1279.06152344,12.95160198,0.00000000,353.00000000,187.25744629); //object(22)
CreateObject(978,-1815.30004883,1278.09997559,13.89999962,0.00000000,351.99645996,185.25598145); //object(23)
CreateObject(978,-1824.36230469,1277.03906250,14.95457458,0.00000000,353.00000000,187.25744629); //object(24)
CreateObject(978,-1829.79980469,1275.40039062,15.79390335,0.00000000,350.00000000,197.46618652); //object(25)
CreateObject(978,-1838.37402344,1272.54101562,17.29908562,0.00000000,350.00000000,197.45520020); //object(26)
CreateObject(973,-1708.97949219,1301.74609375,6.87928200,0.00000000,0.00000000,154.74658203); //object(29)
CreateObject(973,-1701.39160156,1296.68359375,6.87928200,0.00000000,0.00000000,138.35107422); //object(30)
CreateObject(973,-1718.00097656,1303.55566406,6.87928200,0.00000000,0.00000000,183.13659668); //object(31)
CreateObject(973,-1727.03808594,1280.28710938,6.72987604,0.00000000,359.96704102,42.78002930); //object(32)
CreateObject(979,-1724.84277344,1282.88964844,5.51904583,0.00000000,359.00000000,44.78002930); //object(33)
CreateObject(1422,-1820.58642600,1285.90441900,15.33805900,0.00000000,0.10500000,0.34769900); //object(35)
CreateObject(1422,-1817.66711400,1286.73877000,14.96464100,0.00000000,0.12000000,0.09135000); //object(38)
CreateObject(1422,-1814.72448700,1287.00122100,14.60200400,0.00000000,0.12000000,0.09135000); //object(39)
CreateObject(1422,-1811.86096200,1287.25549300,14.24560500,0.00000000,0.12000000,0.09135000); //object(40)
CreateObject(1422,-1809.04821800,1287.49987800,13.90084000,0.00000000,0.12000000,0.09135000); //object(41)
CreateObject(1422,-1806.11303700,1287.54211400,13.57348900,0.00000000,0.12000000,-0.04365000); //object(43)
CreateObject(973,-1821.58593750,1282.39550781,15.71343708,0.00000000,353.00000000,189.25744629); //object(45)
CreateObject(973,-1812.86230469,1283.40722656,14.72817993,0.00000000,353.00000000,187.25744629); //object(46)
CreateObject(973,-1803.65332031,1284.17089844,13.61939240,0.00000000,353.00000000,183.18054199); //object(47)
CreateObject(973,-1794.51074219,1283.92968750,12.58780766,0.00000000,353.00000000,175.04870605); //object(48)
CreateObject(973,-1785.84863281,1283.13281250,11.68270588,0.00000000,353.00000000,177.04870605); //object(49)
CreateObject(973,-1777.77832031,1281.82421875,10.81341553,0.00000000,355.00000000,162.91137695); //object(50)
CreateObject(973,-1768.94628906,1279.61132812,9.84822273,0.00000000,355.00000000,168.86193848); //object(51)
CreateObject(973,-1829.95898438,1280.60156250,16.78172112,0.00000000,350.00000000,199.18750000); //object(55)
CreateObject(973,-1838.53808594,1277.61132812,18.16376114,0.00000000,350.00000000,199.18750000); //object(56)
CreateObject(3452,-1727.28613281,1310.18847656,8.61347771,0.00000000,0.00000000,201.52709961); //object(57)
CreateObject(3452,-1704.66894531,1312.55371094,8.58853531,0.00000000,0.00000000,162.94006348); //object(58)
CreateObject(973,-1847.13574219,1274.73632812,19.51727295,0.00000000,350.00000000,201.18750000); //object(61)
CreateObject(978,-1843.22656250,1270.97363281,18.13124847,0.00000000,350.00000000,199.45520020); //object(62)
CreateObject(978,-1851.40527344,1267.43554688,19.69993973,0.00000000,350.00000000,207.63098145); //object(63)
CreateObject(978,-1859.49902344,1263.07128906,21.36902046,0.00000000,350.00000000,207.63098145); //object(64)
CreateObject(978,-1868.00195312,1257.55371094,23.52479935,0.00000000,347.00000000,217.82873535); //object(65)
CreateObject(978,-1874.16503906,1252.49414062,25.34350395,0.00000000,348.00000000,217.82873535); //object(66)
CreateObject(978,-1880.01074219,1246.25683594,27.47968864,0.00000000,345.00000000,232.09240723); //object(67)
CreateObject(978,-1884.32128906,1240.26660156,29.43869972,0.00000000,344.99816895,236.09069824); //object(68)
CreateObject(978,-1888.43554688,1232.60839844,31.85031891,0.00000000,344.99816895,248.32397461); //object(69)
CreateObject(978,-1890.43652344,1227.55664062,33.48100662,0.00000000,345.00000000,246.32861328); //object(70)
CreateObject(978,-1891.58203125,1222.29101562,35.06154251,0.00000000,345.00000000,260.60327148); //object(71)
CreateObject(978,-1892.35351562,1215.17187500,37.17879486,0.00000000,345.00000000,262.60327148); //object(72)
CreateObject(973,-1878.26562500,1255.16699219,26.84915924,0.00000000,346.00000000,227.56103516); //object(73)
CreateObject(973,-1884.34375000,1248.33789062,28.97352600,0.00000000,345.00000000,229.81921387); //object(74)
CreateObject(973,-1888.86718750,1241.88867188,30.89425850,0.00000000,345.00000000,241.81921387); //object(75)
CreateObject(973,-1893.07617188,1233.98144531,33.22263718,0.00000000,345.00000000,242.06091309); //object(76)
CreateObject(973,-1663.46386719,1264.81250000,6.87928200,0.00000000,0.00000000,315.21447754); //object(79)
CreateObject(973,-1656.84667969,1258.19238281,6.87928200,0.00000000,0.00000000,315.21447754); //object(80)
CreateObject(973,-1650.40332031,1251.71972656,6.87928295,0.00000000,0.00000000,315.21447754); //object(81)
CreateObject(979,-1671.01855469,1269.85839844,6.87928200,0.00000000,0.00000000,337.60449219); //object(83)
CreateObject(979,-1679.87304688,1272.53515625,6.87928200,0.00000000,0.00000000,347.80224609); //object(84)
CreateObject(979,-1688.96289062,1274.35351562,6.87928200,0.00000000,0.00000000,349.80224609); //object(85)
CreateObject(979,-1698.09863281,1276.15917969,6.87928200,0.00000000,0.00000000,349.80224609); //object(86)
CreateObject(979,-1706.53320312,1279.65136719,6.88706303,0.00000000,0.00000000,325.40673828); //object(87)
CreateObject(973,-1643.83105469,1245.14062500,6.87928200,0.00000000,0.00000000,315.21447754); //object(88)
CreateObject(973,-1637.23828125,1238.55273438,6.87928200,0.00000000,0.00000000,315.21447754); //object(89)
CreateObject(973,-1630.65820312,1231.97656250,6.87928200,0.00000000,0.00000000,315.21447754); //object(90)
CreateObject(973,-1624.57421875,1225.87402344,6.87928295,0.00000000,0.00000000,315.21447754); //object(91)
CreateObject(973,-1620.56445312,1221.85644531,6.87928200,0.00000000,0.00000000,315.21447754); //object(92)
CreateObject(973,-1614.49023438,1214.99414062,6.87928200,0.00000000,0.00000000,309.08813477); //object(93)
CreateObject(973,-1610.70312500,1210.22070312,6.87928200,0.00000000,0.00000000,307.08813477); //object(94)
CreateObject(973,-1605.50488281,1202.56152344,6.87928200,0.00000000,0.00000000,300.95629883); //huj1
CreateObject(973,-1603.47753906,1199.15820312,6.87928200,0.00000000,0.00000000,300.95629883); //huj1
CreateObject(973,-1597.95410156,1187.71289062,6.87928200,0.00000000,0.00000000,292.83544922); //huj1
CreateObject(973,-1594.95312500,1179.05957031,6.87928200,0.00000000,0.00000000,284.68164062); //huj1
CreateObject(973,-1594.25390625,1176.43652344,6.87928200,0.00000000,0.00000000,284.68164062); //huj1
CreateObject(973,-1599.32324219,1190.95019531,6.87928200,0.00000000,0.00000000,292.83544922); //huj1
CreateObject(3452,-1690.65722656,1266.50683594,8.61348248,0.00000000,0.00000000,347.80224609); //object(96)
CreateObject(8673,-1692.28906250,1275.06152344,8.68097019,0.00000000,0.00000000,349.80224609); //object(97)
CreateObject(8674,-1680.39843750,1272.69238281,8.73096943,0.00000000,0.00000000,347.80224609); //object(99)
CreateObject(8674,-1706.07128906,1279.54785156,8.66375065,0.00000000,0.00000000,325.40673828); //object(101)
CreateObject(3452,-1666.88671875,1251.18554688,8.63847733,0.00000000,0.00000000,315.21447754); //object(102)
CreateObject(3452,-1645.92871094,1230.28222656,8.63850021,0.00000000,0.00000000,315.21447754); //object(103)
CreateObject(3452,-1626.54882812,1208.76562500,8.63850403,0.00000000,0.00000000,309.10461426); //object(104)
CreateObject(7610,-1693.94628906,1273.67578125,13.98228264,0.00000000,0.00000000,357.77526855); //object(105)
CreateObject(978,-1598.04199219,1219.46191406,6.87928200,0.00000000,0.00000000,128.24670410); //object(88)
CreateObject(978,-1592.93359375,1211.66308594,6.88462210,0.00000000,0.00000000,118.04895020); //object(89)
CreateObject(978,-1588.74218750,1203.34765625,6.88647985,0.00000000,0.00000000,116.02148438); //object(90)
CreateObject(978,-1584.85937500,1194.94628906,6.88553190,0.00000000,0.00000000,113.97753906); //object(91)
CreateObject(978,-1581.65820312,1186.28027344,6.88045979,0.00000000,0.00000000,105.87316895); //object(92)
CreateObject(978,-1579.36523438,1177.58398438,6.88706303,0.00000000,0.00000000,103.77978516); //object(93)
CreateObject(978,-1578.04980469,1168.43847656,6.88331223,0.00000000,0.00000000,93.64245605); //object(94)
CreateObject(1237,-1893.02783200,1214.47229000,37.84085500,0.00000000,0.00000000,0.00000000); //object(96)
CreateObject(1237,-1864.98156700,1240.28991700,26.66523000,0.00000000,0.00000000,0.00000000); //object(97)
CreateObject(1237,-1842.57373000,1271.97363300,18.30929900,0.00000000,0.00000000,0.00000000); //object(98)
CreateObject(1237,-1800.21630900,1263.37731900,12.54273600,0.00000000,0.00000000,0.00000000); //object(99)
CreateObject(1237,-1760.32226600,1276.69555700,8.15498000,0.00000000,0.00000000,0.00000000); //object(100)
CreateObject(1237,-1732.11816400,1274.40014600,5.37419700,0.00000000,0.00000000,0.00000000); //object(101)
CreateObject(973,-1591.97656250,1149.93359375,6.87928200,0.00000000,0.00000000,270.42895508); //huj2
CreateObject(973,-1592.77734375,1167.35742188,6.87928200,0.00000000,0.00000000,274.48388672); //huj2
CreateObject(973,-1592.27734375,1159.25781250,6.87928200,0.00000000,0.00000000,272.48937988); //huj2
CreateObject(10889,-1891.85253906,1139.63964844,44.94636154,2.50000000,0.00000000,180.85791016); //object(136)
CreateObject(10889,-1876.51464844,1107.34570312,44.97127151,2.50000000,0.00000000,359.71582031); //object(137)
CreateObject(1422,-1892.28808594,1081.45507812,44.70740509,0.00000000,0.00000000,270.42895508); //object(130)
CreateObject(1422,-1892.27539062,1078.61132812,44.70740509,0.00000000,0.00000000,270.42895508); //object(131)
CreateObject(1422,-1892.27539062,1075.78417969,44.70740509,0.00000000,0.00000000,270.42895508); //object(132)
CreateObject(1422,-1892.28320312,1072.87695312,44.70740509,0.00000000,0.00000000,270.42895508); //object(133)
CreateObject(1422,-1892.23339844,1069.94824219,44.70740509,0.00000000,0.00000000,270.42895508); //object(134)
CreateObject(1422,-1892.27636719,1084.41699219,44.70740509,0.00000000,0.00000000,270.42895508); //object(135)
CreateObject(1422,-1892.36035156,1061.86035156,44.70740509,0.00000000,0.00000000,270.42895508); //object(136)
CreateObject(1422,-1892.36328125,1058.96875000,44.70740509,0.00000000,0.00000000,268.42895508); //object(138)
CreateObject(1422,-1892.36035156,1056.06738281,44.70740509,0.00000000,0.00000000,268.42895508); //object(139)
CreateObject(1422,-1892.33984375,1053.29199219,44.70740509,0.00000000,0.00000000,270.42895508); //object(140)
CreateObject(1422,-1892.31542969,1050.39257812,44.70740509,0.00000000,0.00000000,270.42895508); //object(141)
CreateObject(1422,-1892.33984375,1047.54199219,44.70740509,0.00000000,0.00000000,270.42895508); //object(142)
CreateObject(1422,-1871.45507812,1183.98437500,44.70740509,0.00000000,0.00000000,270.42895508); //object(143)
CreateObject(1422,-1871.48144531,1181.13378906,44.70740509,0.00000000,0.00000000,270.42895508); //object(144)
CreateObject(1422,-1871.45605469,1178.28515625,44.70740509,0.00000000,0.00000000,270.42895508); //object(145)
CreateObject(1422,-1871.43847656,1175.48730469,44.65479660,0.00000000,0.00000000,272.42895508); //object(146)
CreateObject(1422,-1871.43847656,1172.63574219,44.65479660,0.00000000,0.00000000,270.42895508); //object(147)
CreateObject(1422,-1871.46484375,1169.79101562,44.70740509,0.00000000,0.00000000,268.42895508); //object(148)
CreateObject(1422,-1871.44042969,1188.15820312,44.82218552,0.00000000,0.00000000,266.42895508); //object(149)
CreateObject(1422,-1871.62792969,1165.66699219,44.84638596,0.00000000,0.00000000,270.42895508); //object(150)
CreateObject(1422,-1886.47265625,912.84179688,34.41957855,0.00000000,0.00000000,90.42895508); //object(151)
CreateObject(1422,-1886.47167969,915.89257812,34.41957855,0.00000000,0.00000000,90.42895508); //object(152)
CreateObject(1422,-1886.47070312,918.79199219,34.41957855,0.00000000,0.00000000,88.42895508); //object(153)
CreateObject(1422,-1886.45800781,921.77636719,34.42615509,0.00000000,0.00000000,88.42895508); //object(154)
CreateObject(1422,-1886.47558594,924.79101562,34.42615509,0.00000000,0.00000000,90.42895508); //object(155)
CreateObject(1422,-1886.49707031,933.83203125,34.43395233,0.00000000,0.00000000,90.42895508); //object(156)
CreateObject(1422,-1886.44824219,936.78125000,34.43395233,0.00000000,0.00000000,88.42895508); //object(157)
CreateObject(1422,-1886.49511719,930.80957031,34.42615509,0.00000000,0.00000000,90.42895508); //object(158)
CreateObject(1422,-1886.51855469,927.83886719,34.42615509,0.00000000,0.00000000,90.42895508); //object(159)
CreateObject(1422,-1886.29589844,908.32226562,34.58240509,0.00000000,0.00000000,90.42895508); //object(160)
CreateObject(1422,-1907.50781250,911.88476562,34.42615509,0.00000000,0.00000000,270.42895508); //object(161)
CreateObject(1422,-1907.45019531,914.96386719,34.42615509,0.00000000,0.00000000,268.42895508); //object(162)
CreateObject(1422,-1907.47558594,917.96484375,34.42615509,0.00000000,0.00000000,268.42895508); //object(163)
CreateObject(1422,-1907.40039062,920.86523438,34.42615509,0.00000000,0.00000000,268.42895508); //object(164)
CreateObject(1422,-1907.35546875,923.80957031,34.42615509,0.00000000,0.00000000,270.42895508); //object(165)
CreateObject(1422,-1907.40625000,926.71093750,34.42615509,0.00000000,0.00000000,270.42895508); //object(166)
CreateObject(1422,-1907.33984375,929.66308594,34.43395233,0.00000000,0.00000000,270.42895508); //object(167)
CreateObject(1422,-1907.38867188,932.58886719,34.43395233,0.00000000,0.00000000,270.42895508); //object(168)
CreateObject(1422,-1907.31542969,935.53906250,34.43395233,0.00000000,0.00000000,270.42895508); //object(169)
CreateObject(1422,-1907.29589844,938.39160156,34.43395233,0.00000000,0.00000000,268.42895508); //object(170)
CreateObject(7418,-1931.25390625,875.81347656,34.00453186,0.00000000,0.00000000,91.56555176); //object(172)
CreateObject(7418,-2042.98242188,362.45996094,34.02567291,0.00000000,0.00000000,89.56054688); //object(175)
CreateObject(7418,-2215.61425781,278.34570312,34.16528320,0.00000000,0.00000000,270.42895508); //object(176)
CreateObject(7933,-1909.90527344,860.78906250,34.54689789,0.00000000,0.00000000,46.78002930); //object(180)
CreateObject(7933,-1993.46582031,829.98632812,44.85591888,0.00000000,0.00000000,225.64343262); //object(181)
CreateObject(7933,-2243.67871094,311.98632812,34.68091583,0.00000000,0.00000000,221.64343262); //object(182)
CreateObject(7933,-2243.56347656,-181.99902344,34.69533539,0.00000000,0.00000000,315.21447754); //object(183)
CreateObject(7933,-2217.50488281,-198.14941406,34.81647491,0.00000000,0.00000000,128.07238770); //object(184)
CreateObject(973,-2227.72363281,-196.73730469,35.16053391,0.00000000,0.00000000,14.19226074); //object(185)
CreateObject(7933,-2200.09960938,-301.49804688,34.88092804,0.00000000,0.00000000,138.07238770); //object(189)
CreateObject(978,-2197.51464844,-314.50585938,35.03553391,0.00000000,0.00000000,276.42895508); //object(190)
CreateObject(10889,-2221.99804688,-259.25292969,35.03234100,2.50000000,0.00000000,178.85791016); //object(191)
CreateObject(978,-2217.84277344,-206.98730469,35.16053391,0.00000000,0.00000000,237.83569336); //object(192)
CreateObject(973,-2232.39355469,-184.42968750,35.03754425,0.00000000,0.00000000,178.85791016); //object(193)
CreateObject(973,-2223.09765625,-184.42675781,35.02545547,0.00000000,0.00000000,180.85791016); //object(194)
CreateObject(979,-2212.00195312,-185.40429688,35.05897141,0.00000000,0.00000000,170.94433594); //object(195)
CreateObject(979,-2202.65527344,-195.05859375,35.05582047,0.00000000,0.00000000,97.76330566); //object(196)
CreateObject(979,-2205.86718750,-188.75097656,35.05840683,0.00000000,0.00000000,136.35110474); //object(197)
CreateObject(978,-2264.87500000,-184.02832031,35.01209641,0.00000000,0.00000000,274.42895508); //object(198)
CreateObject(978,-2251.03710938,-200.40820312,35.01209641,0.00000000,0.00000000,0.00000000); //object(199)
CreateObject(978,-2258.33007812,-198.31445312,35.01209641,0.00000000,0.00000000,325.40673828); //object(200)
CreateObject(978,-2263.33007812,-192.04003906,35.01209641,0.00000000,0.00000000,290.81896973); //object(201)
CreateObject(973,-2236.87695312,-198.57714844,35.15988159,0.00000000,0.00000000,8.19226074); //object(202)
CreateObject(5005,-2222.47363281,-288.73242188,36.14803314,0.00000000,0.00000000,268.42895508); //object(203)
CreateObject(3819,-2228.43847656,-286.20214844,35.36494446,0.00000000,0.00000000,180.85791016); //object(206)
CreateObject(3819,-2228.43554688,-277.60546875,35.36494446,0.00000000,0.00000000,180.85791016); //object(207)
CreateObject(3819,-2228.41992188,-269.02929688,35.36494446,0.00000000,0.00000000,178.85791016); //object(208)
CreateObject(3819,-2228.41796875,-260.43261719,35.36494446,0.00000000,0.00000000,180.85791016); //object(209)
CreateObject(3819,-2228.41699219,-251.84277344,35.36494446,0.00000000,0.00000000,178.85791016); //object(210)
CreateObject(3819,-2228.41699219,-243.22656250,35.36494446,0.00000000,0.00000000,178.85791016); //object(211)
CreateObject(3819,-2228.41796875,-234.57128906,35.37085724,0.00000000,0.00000000,180.85791016); //object(212)
CreateObject(3452,-2256.19482400,-208.54892000,36.72345700,0.00000000,0.00000000,0.00000000); //object(214)
CreateObject(3819,-2228.43164062,-225.92773438,35.37085342,0.00000000,0.00000000,180.85791016); //object(215)
CreateObject(3819,-2228.43750000,-217.34082031,35.37085724,0.00000000,0.00000000,180.85791016); //object(216)
CreateObject(3819,-2228.43359375,-294.78320312,35.36502075,0.00000000,0.00000000,180.85791016); //object(217)
CreateObject(972,-2238.08203125,-208.31835938,28.29972839,0.46142578,359.98352051,90.85791016); //object(219)
CreateObject(972,-2255.81738281,-218.44433594,33.33481598,0.00000000,359.51660156,268.42895508); //object(220)
CreateObject(972,-2259.56542969,-218.47265625,33.09433746,0.00000000,359.51660156,268.42895508); //object(221)
CreateObject(3452,-2267.66113281,-200.93359375,36.73002625,0.00000000,0.00000000,313.21447754); //object(222)
CreateObject(3452,-2274.87597656,-190.64941406,36.71162415,0.00000000,0.00000000,280.62121582); //object(223)
CreateObject(8674,-2264.83300781,-184.50683594,36.78886032,0.00000000,0.00000000,94.42895508); //object(224)
CreateObject(8674,-2263.32128906,-191.95800781,36.78886032,0.00000000,0.00000000,290.81896973); //object(225)
CreateObject(8674,-2258.44921875,-198.13281250,36.78436661,0.00000000,0.00000000,325.40673828); //object(226)
CreateObject(8674,-2251.53222656,-200.38378906,36.79816818,0.00000000,0.00000000,0.00000000); //object(227)
CreateObject(3452,-2194.39062500,-185.53222656,36.67124176,0.00000000,0.00000000,87.28686523); //object(228)
CreateObject(8674,-2202.44042969,-196.26464844,36.81486893,0.00000000,0.00000000,278.62121582); //object(229)
CreateObject(8674,-2205.90234375,-188.78515625,36.82574463,0.00000000,0.00000000,317.21447754); //object(230)
CreateObject(8674,-2211.86816406,-185.50000000,36.81428146,0.00000000,0.00000000,351.80224609); //object(231)
CreateObject(10889,-2265.17382812,-129.87695312,34.82126999,2.50000000,0.00000000,178.85791016); //object(232)
CreateObject(10889,-2247.05078125,-125.35253906,34.82126999,2.50000000,0.00000000,359.71582031); //object(233)
CreateObject(10889,-2246.95019531,-9.21093750,34.79766083,2.50000000,0.00000000,359.71582031); //object(218)
CreateObject(1422,-2136.86914062,-329.29101562,34.44531631,0.00000000,0.00000000,338.46240234); //object(222)
CreateObject(1422,-2134.28417969,-330.44824219,34.42538452,0.00000000,0.00000000,338.46240234); //object(223)
CreateObject(1422,-2131.65917969,-331.55078125,34.45132065,0.00000000,0.00000000,338.46240234); //object(224)
CreateObject(1422,-2129.08007812,-332.65429688,34.40597916,0.00000000,0.00000000,336.46240234); //object(225)
CreateObject(1422,-2126.51562500,-333.76367188,34.40668106,0.00000000,0.00000000,344.46240234); //object(226)
CreateObject(1422,-2123.96777344,-334.86425781,34.40667725,0.00000000,0.00000000,338.46240234); //object(227)
CreateObject(1422,-2121.35546875,-335.91992188,34.48176193,0.00000000,0.00000000,340.46240234); //object(228)
CreateObject(1422,-2118.79785156,-336.92480469,34.54790878,0.00000000,0.00000000,340.46240234); //object(229)
CreateObject(1422,-2116.22460938,-338.00000000,34.54790878,0.00000000,0.00000000,338.46240234); //object(230)
CreateObject(1422,-2113.62207031,-339.10058594,34.59791183,0.00000000,0.01098633,332.46240234); //object(231)
CreateObject(1422,-2111.02832031,-340.19042969,34.66021347,0.00000000,0.00000000,340.46240234); //object(232)
CreateObject(1422,-2108.30175781,-340.98828125,34.70711136,0.00000000,0.00000000,350.66015625); //object(233)
CreateObject(1422,-2105.53222656,-341.54687500,34.73132706,0.00000000,0.00000000,346.66015625); //object(234)
CreateObject(1422,-2102.83984375,-342.12695312,34.72203064,0.00000000,359.98352051,356.66015625); //object(235)
CreateObject(973,-2133.74707031,-330.91308594,34.41217422,0.00000000,0.00000000,337.60449219); //object(236)
CreateObject(973,-2125.35253906,-334.41894531,34.39445877,0.00000000,0.00000000,337.60449219); //object(237)
CreateObject(973,-2116.81054688,-337.96875000,34.37423706,0.00000000,0.00000000,337.60449219); //object(238)
CreateObject(973,-2109.23535156,-341.03320312,34.55659485,0.00000000,0.00000000,335.60449219); //object(239)
CreateObject(3452,-2140.08203125,-338.74218750,36.56864166,0.00000000,0.00000000,341.60449219); //object(241)
CreateObject(972,-2122.97753906,-344.45605469,28.12963104,0.46142578,359.98352051,64.46240234); //object(242)
CreateObject(8673,-2148.38964800,-326.95617700,36.19047500,0.00000000,0.00000000,-0.16635000); //object(243)
CreateObject(8673,-2128.37109375,-332.96484375,36.19622421,0.00000000,0.00000000,335.60449219); //object(244)
CreateObject(8674,-2114.39257812,-338.75976562,36.17560959,0.00000000,0.00000000,337.60449219); //object(245)
CreateObject(8674,-2106.40820312,-341.31542969,36.18201447,0.00000000,0.00000000,345.80224609); //object(246)
CreateObject(3819,-2065.81445312,-300.92773438,35.41963196,0.00000000,0.00000000,89.28686523); //object(247)
CreateObject(3819,-2075.53515625,-300.93554688,35.41963196,0.00000000,0.00000000,89.28686523); //object(248)
CreateObject(3819,-2085.46484375,-300.90429688,35.41963196,0.00000000,0.00000000,89.28686523); //object(249)
CreateObject(3819,-2095.28808594,-301.05468750,35.41963196,0.00000000,0.00000000,89.28540039); //object(250)
CreateObject(8673,-2090.39648400,-303.35714700,36.15960300,0.00000000,0.00000000,0.00000000); //object(251)
CreateObject(8673,-2071.84375000,-303.36126700,36.15617400,0.00000000,0.00000000,0.00000000); //object(252)
CreateObject(8673,-2016.68164062,423.73828125,35.63879013,0.00000000,0.00000000,90.42895508); //object(256)
CreateObject(8673,-2016.67089844,403.27539062,35.63879013,0.00000000,0.00000000,88.42895508); //object(257)
CreateObject(8673,-2027.07385300,393.29147300,35.63879000,0.00000000,0.00000000,-3.14159300); //object(258)
CreateObject(3819,-2020.04296875,428.56054688,35.16963196,0.00000000,0.00000000,178.85791016); //object(259)
CreateObject(3819,-2020.04101562,419.64550781,35.16963196,0.00000000,0.00000000,180.85791016); //object(260)
CreateObject(3819,-2020.08300781,399.84375000,35.16963196,0.00000000,0.00000000,178.85791016); //object(261)
CreateObject(3819,-2020.01757812,408.75781250,35.16963196,0.00000000,0.00000000,178.85791016); //object(262)
CreateObject(3406,-2026.85449219,398.07226562,35.26746368,1.57104492,0.00000000,268.00000000); //object(263)
CreateObject(3406,-2026.83984375,406.80273438,35.24259949,1.57104492,0.00000000,268.00000000); //object(264)
CreateObject(3406,-2026.65136719,417.50292969,35.19259644,1.57104492,0.00000000,92.00000000); //object(265)
CreateObject(3406,-2026.26269531,426.37402344,35.20168686,1.57104492,0.00000000,88.00000000); //object(266)
CreateObject(3819,-2025.52050781,399.86816406,37.26730728,0.00000000,0.00000000,178.85791016); //object(267)
CreateObject(3819,-2025.63671875,408.72265625,37.09314346,0.00000000,0.00000000,178.85791016); //object(268)
CreateObject(3819,-2025.66894531,419.65039062,37.08036041,0.00000000,0.00000000,180.85791016); //object(269)
CreateObject(3819,-2025.64843750,428.58105469,37.08906937,0.00000000,0.00000000,178.85791016); //object(270)
CreateObject(3406,-2031.86035156,417.53906250,37.15758514,1.57104492,0.00000000,90.00000000); //object(271)
CreateObject(3406,-2031.88183594,426.56542969,37.19029236,1.57104492,0.00000000,92.00000000); //object(272)
CreateObject(3819,-2031.19042969,419.65234375,39.15897369,0.00000000,0.00000000,180.85791016); //object(273)
CreateObject(3819,-2031.19140625,428.49902344,39.16287613,0.00000000,0.00000000,178.85791016); //object(274)
CreateObject(3406,-2031.86621094,406.86425781,37.17007446,1.57104492,0.00000000,270.00000000); //object(275)
CreateObject(3406,-2031.92187500,398.09082031,37.13773727,1.57104492,0.00000000,270.00000000); //object(276)
CreateObject(3819,-2030.94238281,408.56152344,39.16656113,0.00000000,0.00000000,178.85791016); //object(277)
CreateObject(3819,-2030.94824219,399.76855469,39.16492081,0.00000000,0.00000000,180.85791016); //object(278)
CreateObject(3406,-2036.67285156,409.14746094,40.24301910,0.00000000,0.00000000,90.42895508); //object(279)
CreateObject(3406,-2036.69335938,400.35156250,40.24259949,0.00000000,0.00000000,88.42895508); //object(280)
CreateObject(3406,-2036.71484375,391.57910156,40.24259949,0.00000000,0.00000000,90.42895508); //object(281)
CreateObject(3406,-2036.71582031,382.80371094,40.24259949,0.00000000,0.00000000,270.42895508); //object(282)
CreateObject(8673,-2016.64648438,463.34667969,35.63879013,0.00000000,0.00000000,90.42895508); //object(283)
CreateObject(8673,-2016.63769531,483.76562500,35.63879013,0.00000000,0.00000000,90.42895508); //object(284)
CreateObject(3819,-2020.02929688,478.47070312,35.16963196,0.00000000,0.00000000,180.85791016); //object(285)
CreateObject(3819,-2020.04687500,488.67773438,35.16963196,0.00000000,0.00000000,178.85791016); //object(286)
CreateObject(3406,-2027.01171875,476.53222656,35.21761322,1.57104492,0.00000000,270.00000000); //object(287)
CreateObject(3406,-2026.85351562,486.76171875,35.19255066,1.57104492,0.00000000,88.00000000); //object(288)
CreateObject(3819,-2025.33105469,478.39355469,37.21920395,0.00000000,0.00000000,180.85791016); //object(289)
CreateObject(3819,-2025.34960938,488.63867188,37.18989944,0.00000000,0.00000000,178.85791016); //object(290)
CreateObject(3406,-2031.39062500,476.53906250,37.24016571,1.57104492,0.00000000,268.00000000); //object(291)
CreateObject(3406,-2031.32421875,486.80664062,37.12681198,1.57104492,0.00000000,90.00000000); //object(292)
CreateObject(3819,-2030.62890625,478.31542969,39.24328613,0.00000000,0.00000000,180.85791016); //object(293)
CreateObject(3819,-2030.47070312,488.57421875,39.11844635,0.00000000,0.00000000,178.85791016); //object(294)
CreateObject(3569,-1798.22558594,-26.46875000,11.59957123,0.00000000,359.93408203,90.42346191); //object(301)
CreateObject(3569,-1902.56640625,-572.27734375,21.02034950,0.00000000,359.93957520,89.28686523); //object(302)
CreateObject(10889,-1577.00195312,1095.19628906,6.62133503,2.50000000,0.00000000,359.71582031); //object(303)
CreateObject(978,-1577.35351562,1159.16601562,6.88706303,0.00000000,0.00000000,95.64245605); //object(304)
CreateObject(10889,-1591.96386719,1090.79687500,6.76359892,2.50000000,0.00000000,180.57373047); //object(305)
CreateObject(973,-1576.99316406,1149.88769531,6.88701916,0.00000000,0.00000000,91.56555176); //object(306)
CreateObject(979,-1914.90429688,-326.78320312,26.76392937,0.00000000,359.96704102,175.07617188); //object(307)
CreateObject(979,-1905.71191406,-327.61035156,26.54544449,0.00000000,359.98352051,173.02124023); //object(308)
CreateObject(979,-1898.34765625,-332.00878906,26.62190628,0.00000000,0.02746582,126.18627930); //object(309)
CreateObject(979,-1895.07812500,-340.47851562,26.82936478,0.00000000,0.01098633,101.69189453); //object(310)
CreateObject(10889,-1638.41210938,1261.83496094,6.75290585,2.50000000,0.00000000,44.50134277); //object(311)
CreateObject(978,-1603.74902344,1226.54785156,6.87928200,0.00000000,0.00000000,130.24670410); //object(312)
CreateObject(973,-1726.59997559,1301.59997559,6.90000010,0.00000000,0.00000000,203.53210449); //object(313)
CreateObject(978,-1727.29492188,1301.08203125,5.70427799,0.00000000,0.00000000,199.53210449); //object(314)
CreateObject(973,-1693.60644531,1292.50488281,6.87928200,0.00000000,0.00000000,164.94433594); //object(315)
CreateObject(973,-1684.40625000,1290.68847656,6.87928200,0.00000000,0.00000000,172.94433594); //object(316)
CreateObject(973,-1675.23144531,1288.86523438,6.87928200,0.00000000,0.00000000,164.94433594); //object(317)
CreateObject(978,-1693.87207031,1291.71484375,5.70427799,0.00000000,0.00000000,166.94433594); //object(318)
CreateObject(978,-1684.74023438,1289.90136719,5.70427799,0.00000000,0.00000000,170.94433594); //object(319)
CreateObject(978,-1675.62207031,1288.06640625,5.70427799,0.00000000,0.00000000,166.94433594); //object(320)
CreateObject(10889,-2086.00781250,325.27148438,34.61566162,2.50000000,0.00000000,89.28686523); //object(285)
CreateObject(10889,-2246.51562500,251.60058594,34.53865433,2.50000000,0.00000000,359.71582031); //object(286)
CreateObject(5005,-1914.84960938,-446.15625000,26.86248970,0.00000000,0.00000000,270.42895508); //object(289)
CreateObject(5005,-1893.25976562,-446.21484375,26.84840584,0.00000000,0.00000000,90.42895508); //object(291)
CreateObject(5005,-1687.18750000,349.02636719,8.88277721,0.00000000,0.00000000,44.78002930); //object(292)
CreateObject(978,-1746.27929688,293.30957031,6.87802887,0.00000000,0.00000000,24.39001465); //object(293)
CreateObject(10889,-1566.62500000,576.91601562,6.63859892,2.50000000,0.00000000,180.85791016); //object(296)
CreateObject(979,-1815.50878906,186.99414062,14.80115795,0.00000000,0.00000000,270.74060059); //object(295)
CreateObject(979,-1815.23925781,177.63183594,14.80115795,0.00000000,0.00000000,272.74060059); //object(296)
CreateObject(979,-1815.09472656,168.26562500,14.79471874,0.00000000,0.00000000,270.70764160); //object(298)
CreateObject(978,-1817.21875000,159.45312500,14.80115795,0.00000000,0.00000000,243.08764648); //object(299)
CreateObject(979,-1816.47363281,-7.20507812,14.80115795,0.00000000,0.00000000,315.49316406); //object(300)
CreateObject(979,-1811.41503906,-14.79492188,14.80115795,0.00000000,0.00000000,291.10314941); //object(301)
CreateObject(979,-1822.32226562,0.00195312,14.80115795,0.00000000,0.00000000,301.30090332); //object(302)
CreateObject(979,-1826.75000000,8.20214844,14.80115795,0.00000000,0.00000000,297.10314941); //object(303)
CreateObject(979,-1813.99707031,10.15625000,14.80115795,0.00000000,0.00000000,305.49316406); //object(304)
CreateObject(979,-1808.95605469,2.59960938,14.80115795,0.00000000,0.00000000,301.10314941); //object(305)
CreateObject(1238,-1809.93481400,72.78886400,14.42755500,0.00000000,0.00000000,-4.31969000); //object(307)
CreateObject(1238,-1803.31604000,132.74856600,14.42755500,0.00000000,0.00000000,-7.46128400); //object(308)
CreateObject(978,-1755.28613281,287.84179688,7.27803087,0.00000000,0.07141113,44.70861816); //object(309)
CreateObject(978,-1764.68066406,279.66796875,8.92427826,0.00000000,10.00000000,40.70861816); //object(310)
CreateObject(978,-1775.63378906,269.94628906,11.36973476,0.00000000,8.00000000,40.72509766); //object(311)
CreateObject(978,-1785.39843750,260.33496094,13.14683247,0.00000000,6.00000000,46.81298828); //object(312)
CreateObject(978,-1792.52832031,250.70214844,14.32566929,0.00000000,4.00000000,61.02722168); //object(313)
CreateObject(978,-1797.60058594,240.12500000,14.74959946,0.00000000,0.00000000,71.23596191); //object(314)
CreateObject(1237,-1759.15393100,284.08511400,7.11165600,-0.01500000,0.10500000,0.58904900); //object(315)
CreateObject(1237,-1760.45666500,282.93768300,7.26690000,-0.01500000,0.15000000,0.58904900); //object(317)
CreateObject(1237,-1768.84338400,275.53671300,9.31798100,-0.01500000,0.15000000,0.58904900); //object(318)
CreateObject(1237,-1771.51831100,273.13940400,9.80144300,-0.01500000,0.15000000,0.58904900); //object(319)
CreateObject(1237,-1770.24194300,274.28952000,9.65143500,-0.01500000,0.15000000,0.58904900); //object(320)
CreateObject(1237,-1779.61206100,265.96643100,11.47737300,-0.01500000,0.09000000,0.58904900); //object(321)
CreateObject(1237,-1781.62585400,264.00912500,11.83182600,-0.01500000,0.12000000,0.58904900); //object(322)
CreateObject(1237,-1780.69372600,265.00891100,11.61598100,-0.01500000,0.12000000,0.58904900); //object(323)
CreateObject(1237,-1789.27954100,255.71453900,13.08056100,-0.01500000,0.12000000,0.58904900); //object(324)
CreateObject(1237,-1795.35913100,245.43475300,14.11225600,0.00000000,0.00000000,0.00000000); //object(325)
CreateObject(5005,-1551.50097656,823.31347656,8.88904953,0.00000000,0.00000000,89.56555176); //dodge
CreateObject(5005,-1545.34277344,613.68261719,8.88900661,0.00000000,0.00000000,89.56555176); //object(328)
CreateObject(3452,-1536.95214844,608.24121094,8.78697205,0.00000000,0.00000000,89.56555176); //object(334)
CreateObject(3452,-1537.00000000,644.55859375,8.75314522,0.00000000,0.00000000,89.56555176); //object(335)
CreateObject(3452,-1537.01367188,680.67480469,8.78694916,0.00000000,0.00000000,89.56555176); //object(338)
CreateObject(972,-1537.89843750,698.75097656,-0.41249901,0.46142578,359.98352051,358.42895508); //object(339)
CreateObject(972,-1537.64746100,662.57641600,-0.31562000,0.46500000,-0.01500000,-1.57079700); //object(340)
CreateObject(972,-1537.64685100,626.30889900,-0.35052200,0.46500000,-0.01500000,-1.57079700); //object(341)
CreateObject(972,-1537.66015600,669.13940400,-0.34963400,0.46500000,-0.01500000,-1.57079700); //object(342)
CreateObject(972,-1537.71154800,632.98693800,-0.32171100,0.46500000,-0.01500000,-1.57079700); //object(343)
CreateObject(972,-1537.67334000,596.72345000,-0.39733600,0.46500000,-0.01500000,-1.57079700); //object(344)
CreateObject(7933,-1884.61938500,-567.57171600,23.83093100,0.00000000,0.00000000,0.00000000); //object(345)
CreateObject(7933,-1826.62304688,-567.60546875,15.79499435,0.00000000,0.00000000,46.78002930); //object(347)
CreateObject(3452,-1923.92871094,-579.65039062,26.04476166,0.00000000,0.00000000,270.42895508); //object(348)
CreateObject(978,-1897.90234375,-589.04882812,24.27929688,0.00000000,0.00000000,350.00000000); //object(349)
CreateObject(978,-1912.84765625,-568.98730469,24.27929688,0.00000000,0.00000000,290.81896973); //object(350)
CreateObject(978,-1910.16210938,-577.84277344,24.27929688,0.00000000,0.00000000,282.62121582); //object(351)
CreateObject(978,-1905.91992188,-585.74218750,24.28553200,0.00000000,0.00000000,319.21447754); //object(352)
CreateObject(978,-1624.10546875,409.11328125,6.87146997,0.00000000,0.00000000,18.19226074); //object(354)
CreateObject(978,-1615.10644531,410.90136719,6.87146997,0.00000000,0.00000000,4.19226074); //object(355)
CreateObject(978,-1606.25195312,413.59375000,6.87146997,0.00000000,0.00000000,26.39001465); //object(356)
CreateObject(978,-1597.61718750,417.18554688,6.87146997,0.00000000,0.00000000,20.39001465); //object(357)
CreateObject(978,-1589.43554688,421.55078125,6.87146997,0.00000000,0.00000000,36.58776855); //object(358)
CreateObject(978,-1582.26855469,427.46093750,6.87146997,0.00000000,0.00000000,40.78002930); //object(359)
CreateObject(973,-1567.43359375,520.67089844,6.87146997,0.00000000,0.00000000,262.30261230); //object(360)
CreateObject(973,-1568.54296875,511.90332031,6.87146997,0.00000000,0.00000000,262.30261230); //object(361)
CreateObject(973,-1570.97363281,503.14453125,6.87146997,0.00000000,0.00000000,246.03344727); //object(362)
CreateObject(973,-1574.55664062,494.51757812,6.87146997,0.00000000,0.00000000,248.03344727); //object(363)
CreateObject(973,-1579.27636719,486.47558594,6.87146997,0.00000000,0.00000000,231.75878906); //object(364)
CreateObject(973,-1584.72265625,479.64746094,6.87146997,0.00000000,0.00000000,231.75878906); //object(365)
CreateObject(973,-1590.65332031,473.02441406,6.87146997,0.00000000,0.00000000,225.64343262); //object(366)
CreateObject(973,-1597.20410156,466.46093750,6.87146997,0.00000000,0.00000000,225.64343262); //object(367)
CreateObject(973,-1603.74414062,459.89746094,6.87146997,0.00000000,0.00000000,223.64343262); //object(368)
CreateObject(973,-1610.35351562,453.29003906,6.87146997,0.00000000,0.00000000,225.64343262); //object(369)
CreateObject(973,-1616.95507812,446.71386719,6.87146997,0.00000000,0.00000000,223.64343262); //object(370)
CreateObject(973,-1623.53417969,440.12792969,6.87146997,0.00000000,0.00000000,225.64343262); //object(371)
CreateObject(979,-1631.33789062,435.77343750,6.87146997,0.00000000,0.00000000,193.36730957); //object(372)
CreateObject(978,-1545.94531250,529.33691406,6.87146997,0.00000000,0.00000000,91.56555176); //object(373)
CreateObject(978,-1548.00292969,499.04882812,6.87146997,0.00000000,0.00000000,71.56555176); //object(374)
CreateObject(978,-1548.89257812,489.74804688,6.87146997,0.00000000,0.00000000,95.37329102); //object(375)
CreateObject(978,-1550.73144531,480.56152344,6.87146997,0.00000000,0.00000000,61.37329102); //object(376)
CreateObject(978,-1553.43554688,471.68164062,6.87146997,0.00000000,0.00000000,83.17553711); //object(377)
CreateObject(3452,-2038.18164062,-350.04199219,36.87071228,0.00000000,0.00000000,0.00000000); //object(378)
CreateObject(972,-2020.04199219,-349.35351562,28.08605766,0.46142578,359.98352051,88.85791016); //object(379)
CreateObject(973,-2052.92285156,-342.75878906,34.74488449,0.00000000,0.00000000,2.04394531); //object(380)
CreateObject(973,-2043.62109375,-342.33300781,34.74488449,0.00000000,0.00000000,2.04394531); //object(381)
CreateObject(973,-2034.32617188,-341.91894531,34.74488449,0.00000000,0.00000000,2.04394531); //object(382)
CreateObject(973,-2025.06152344,-341.51269531,34.80958176,0.00000000,359.98352051,4.04394531); //object(383)
CreateObject(8673,-2041.97363281,-342.22558594,36.62159348,0.00000000,0.00000000,2.04394531); //object(384)
CreateObject(8674,-2026.82324219,-341.54492188,36.62345886,0.00000000,0.00000000,4.04394531); //object(385)
CreateObject(8674,-2014.99316400,-340.73773200,36.67245500,0.00000000,0.00000000,0.04499900); //object(386)
CreateObject(972,-2049.76464844,-349.21289062,27.67656898,0.46142578,359.98352051,86.85791016); //object(387)
CreateObject(972,-2150.48730469,-333.79589844,27.80974007,0.46142578,359.98352051,78.46240234); //object(388)
CreateObject(10889,-1996.53222656,464.05761719,34.69020462,2.50000000,0.00000000,359.71582031); //object(389)
CreateObject(10889,-2011.77441406,442.80273438,34.74007034,2.50000000,0.00000000,180.85791016); //object(390)
CreateObject(978,-2016.47656250,392.34765625,34.85584641,0.00000000,0.00000000,170.94433594); //object(391)
CreateObject(978,-2025.73828125,393.25097656,34.85584641,0.00000000,0.00000000,179.13659668); //object(392)
CreateObject(1238,-2011.88281300,358.36715700,34.49005500,0.00000000,0.00000000,-8.24668100); //object(395)
CreateObject(10889,-2124.85058594,314.80859375,34.80690384,2.50000000,0.00000000,270.14477539); //object(396)
CreateObject(979,-2181.64746094,312.69140625,35.01209641,0.00000000,0.00000000,22.39001465); //object(397)
CreateObject(978,-1539.02441406,707.98535156,6.87928200,0.00000000,0.00000000,56.97778320); //object(381)
CreateObject(978,-1545.92382812,702.33300781,6.87928200,0.00000000,0.00000000,20.39001465); //object(382)
CreateObject(978,-1536.36816406,716.36035156,6.87928200,0.00000000,0.00000000,87.56555176); //object(383)
CreateObject(973,-1536.37207031,725.70605469,6.87928200,0.00000000,0.00000000,91.56555176); //object(384)
CreateObject(973,-1536.36621094,735.08203125,6.87928200,0.00000000,0.00000000,89.56555176); //object(385)
CreateObject(973,-1536.23046875,744.44726562,6.87928200,0.00000000,0.00000000,89.53808594); //object(386)
CreateObject(979,-1589.58300781,1025.32617188,6.87928200,0.00000000,0.00000000,290.69812012); //object(387)
CreateObject(979,-1586.16210938,1016.73339844,6.87928200,0.00000000,0.00000000,292.91235352); //object(388)
CreateObject(979,-1591.44921875,1034.46777344,6.87928200,0.00000000,0.00000000,272.56079102); //object(389)
CreateObject(979,-1581.63574219,1008.66113281,6.87928200,0.00000000,0.00000000,304.97277832); //object(390)
CreateObject(973,-1576.40820312,1001.19531250,6.87928200,0.00000000,0.00000000,307.38879395); //object(391)
CreateObject(973,-1570.29589844,994.09179688,6.87928200,0.00000000,0.00000000,313.44921875); //object(392)
CreateObject(973,-1563.91406250,987.27832031,6.87928200,0.00000000,0.00000000,313.47668457); //object(394)
CreateObject(973,-1557.61035156,980.44531250,6.87928200,0.00000000,0.00000000,311.43273926); //object(395)
CreateObject(978,-1666.68457031,1285.36816406,5.70427799,0.00000000,0.00000000,158.74658203); //object(396)
CreateObject(973,-1551.93066406,973.11328125,6.87928200,0.00000000,0.00000000,303.01672363); //object(397)
CreateObject(973,-1546.93164062,965.27539062,6.87928200,0.00000000,0.00000000,300.97277832); //object(398)
CreateObject(973,-1542.54882812,957.04785156,6.87928200,0.00000000,0.00000000,296.86291504); //object(399)
CreateObject(979,-1538.37890625,948.66699219,6.88701916,0.00000000,0.00000000,294.91235352); //object(400)
CreateObject(1237,-1536.04223600,943.98986800,6.04194400,0.00000000,0.00000000,0.00000000); //object(401)
CreateObject(1237,-1550.64172400,700.55468800,6.19038100,0.00000000,0.00000000,0.00000000); //object(402)
CreateObject(973,-1666.38476562,1286.18847656,6.88706303,0.00000000,0.00000000,160.74658203); //object(405)
CreateObject(978,-1658.47753906,1280.97949219,5.71206093,0.00000000,0.00000000,144.54882812); //object(406)
CreateObject(8673,-1996.45996094,422.12988281,36.66385269,0.00000000,0.00000000,90.42895508); //object(409)
CreateObject(8673,-1996.44628906,442.51757812,36.65902710,0.00000000,0.00000000,270.42895508); //object(410)
CreateObject(8673,-1996.38769531,462.91894531,36.60756302,0.00000000,0.00000000,270.42895508); //object(411)
CreateObject(8673,-1996.43945312,483.36328125,36.64601898,0.00000000,0.00000000,90.42895508); //object(412)
CreateObject(8673,-1996.44628906,503.84472656,36.65761185,0.00000000,0.00000000,270.42895508); //object(413)
CreateObject(10889,-1795.26660156,74.07617188,14.68592644,2.50000000,0.00000000,4.05493164); //object(414)
CreateObject(1238,-1795.58679200,12.76682900,14.42755500,0.00000000,0.00000000,-7.46128400); //object(415)
CreateObject(10230,-1701.09387200,182.43362400,6.69579900,0.00000000,0.00000000,1.57079600); //object(410)
CreateObject(10229,-1699.62536600,182.15043600,5.50167500,0.00000000,0.00000000,1.57079600); //statek
CreateObject(10140,-1700.01538100,197.10482800,6.79981200,0.00000000,0.00000000,1.57079600); //object(412)
CreateObject(10231,-1699.58105500,181.50242600,7.98898400,0.00000000,0.00000000,1.57079600); //object(413)
CreateObject(1683,-1674.09204100,-178.44908100,19.05106400,0.00000000,0.00000000,0.78539800); //object(414)
CreateObject(1683,-1662.14257800,-378.34332300,19.05106400,0.00000000,0.00000000,-0.78539800); //object(415)
CreateObject(1683,-1646.02050781,-342.26953125,19.05106354,0.00000000,0.00000000,359.21447754); //object(416)
CreateObject(1683,-1625.81762700,-306.20697000,19.05106400,0.00000000,0.00000000,-0.78539800); //object(417)
CreateObject(1683,-1616.08398400,-236.79379300,19.05106400,0.00000000,0.00000000,-2.35619400); //object(419)
CreateObject(1681,-1726.27441400,-500.38513200,15.32647500,0.00000000,0.00000000,-1.57079600); //object(422)
CreateObject(1681,-1726.26757800,-537.13562000,15.30147600,0.00000000,0.00000000,-1.57079600); //object(423)
CreateObject(1681,-1684.04040500,-456.40768400,15.32198500,0.00000000,0.00000000,1.17809700); //object(424)
CreateObject(1681,-1694.46752900,-482.02496300,15.29699300,0.00000000,0.00000000,1.17809700); //object(425)
CreateObject(1681,-1713.79846200,-317.29547100,15.32647500,0.00000000,0.00000000,-1.57079600); //object(426)
CreateObject(1681,-1714.18652300,-293.68917800,15.32647500,0.00000000,0.00000000,-1.57079600); //object(427)
CreateObject(1681,-1714.44433594,-270.98730469,15.30147552,0.00000000,0.00000000,358.42895508); //object(428)
CreateObject(10794,-1397.35791000,940.87878400,5.70697900,0.00000000,0.00000000,-1.57079600); //object(432)
CreateObject(10795,-1397.34790000,943.16033900,15.78571100,0.00000000,0.00000000,-1.57079600); //object(433)
CreateObject(10793,-1397.31945800,1016.07397500,34.33271000,0.00000000,0.00000000,-1.57079600); //object(434)
CreateObject(10230,-1749.64917000,-460.54235800,7.12698000,0.00000000,0.00000000,4.71238800); //object(436)
CreateObject(10140,-1750.71228000,-474.87976100,7.05979600,0.00000000,0.00000000,4.71238900); //object(438)
CreateObject(10229,-1751.05529800,-460.29925500,5.98359200,0.00000000,0.00000000,-1.57079600); //statek2
CreateObject(10231,-1751.15429700,-459.61441000,8.39164400,0.00000000,0.00000000,-1.57079600); //object(441)
CreateObject(8674,-1910.09179688,-577.93457031,25.88097572,0.00000000,0.00000000,282.62121582); //object(443)
CreateObject(8674,-1906.05957031,-585.49511719,25.89115906,0.00000000,0.00000000,319.21447754); //object(444)
CreateObject(8674,-1898.38085938,-588.97460938,25.93222237,0.00000000,0.00000000,350.00000000); //object(445)
CreateObject(8674,-1912.89355469,-568.64550781,25.88836098,0.00000000,0.00000000,290.81896973); //object(446)
CreateObject(979,-1539.94335938,908.95898438,6.87928200,0.00000000,0.00000000,321.40673828); //object(437)
CreateObject(978,-1548.04882812,908.97851562,6.87928200,0.00000000,0.00000000,36.58776855); //object(438)
CreateObject(5005,-1544.32031250,823.07617188,8.88359356,0.00000000,0.00000000,85.47766113); //object(439)
CreateObject(1237,-1543.96032700,911.56066900,6.04194400,0.00000000,0.00000000,0.00000000); //object(440)
CreateObject(973,-1575.44824219,1029.90234375,6.87928200,0.00000000,0.00000000,103.58898926); //object(442)
CreateObject(973,-1571.09082031,1021.89257812,6.87928200,0.00000000,0.00000000,129.97900391); //object(443)
CreateObject(973,-1565.07714844,1014.69238281,6.87928200,0.00000000,0.00000000,129.97900391); //object(444)
CreateObject(973,-1559.08203125,1007.51855469,6.87928200,0.00000000,0.00000000,129.97900391); //object(445)
CreateObject(973,-1552.87207031,1000.52832031,6.87928200,0.00000000,0.00000000,134.03942871); //object(446)
CreateObject(973,-1546.81933594,993.46875000,6.88701916,0.00000000,0.00000000,127.95153809); //object(447)
CreateObject(973,-1541.29296875,985.99414062,6.87928200,0.00000000,0.00000000,123.89111328); //object(448)
CreateObject(973,-1536.13183594,978.16503906,6.87928200,0.00000000,0.00000000,121.84716797); //object(449)
CreateObject(978,-1531.29882812,970.18457031,6.87928200,0.00000000,0.00000000,120.09838867); //object(450)
CreateObject(978,-1527.18652344,961.87011719,6.87928200,0.00000000,0.00000000,111.96105957); //object(451)
CreateObject(978,-1523.60644531,953.20605469,6.87928200,0.00000000,0.00000000,111.96105957); //object(452)
CreateObject(978,-1521.22070312,945.31445312,6.87928200,0.00000000,0.00000000,101.76330566); //object(453)
CreateObject(973,-1520.61718750,937.82617188,6.87928200,0.00000000,0.00000000,89.56555176); //object(454)
CreateObject(973,-1520.61425781,928.42968750,6.87928200,0.00000000,0.00000000,89.56555176); //object(455)
CreateObject(973,-1520.61718750,919.06152344,6.88701916,0.00000000,0.00000000,89.56555176); //object(456)
CreateObject(973,-1520.87011719,909.73730469,6.87928200,0.00000000,0.00000000,87.51062012); //object(457)
CreateObject(973,-1576.80175781,1038.82519531,6.87928200,0.00000000,0.00000000,93.56555176); //object(458)
CreateObject(979,-1569.13476562,632.65917969,6.87928200,0.00000000,0.00000000,291.01672363); //object(459)
CreateObject(979,-1571.72656250,641.22265625,6.87928200,0.00000000,0.00000000,282.42895508); //object(460)
CreateObject(10889,-1996.59179688,768.94531250,44.89489365,2.50000000,0.00000000,359.71582031); //object(464)
CreateObject(10889,-2011.92773438,748.81542969,44.94525909,2.50000000,0.00000000,180.85791016); //object(465)
CreateObject(10889,-2011.92773438,626.13085938,35.77173615,352.00000000,359.98352051,178.85791016); //object(466)
CreateObject(10889,-2011.88085938,567.22167969,34.66509628,2.50000000,0.00000000,180.85791016); //object(468)
CreateObject(7933,-2014.75390625,496.44433594,34.62580109,0.00000000,0.00000000,136.07238770); //object(469)
CreateObject(7933,-2014.94238281,512.45410156,34.73249054,0.00000000,0.00000000,42.50134277); //object(470)
CreateObject(973,-1996.37890625,520.46582031,34.84804535,0.00000000,0.00000000,89.28686523); //object(471)
CreateObject(979,-1996.39257812,529.84960938,34.85584641,0.00000000,0.00000000,89.56555176); //object(472)
CreateObject(978,-1996.38964844,558.89648438,34.85584641,0.00000000,0.00000000,89.56555176); //object(473)
CreateObject(1422,-1571.86132812,722.41210938,6.60975981,0.00000000,0.00000000,270.42895508); //object(464)
CreateObject(1422,-1571.91015625,725.63671875,6.44259882,0.00000000,0.00000000,268.42895508); //object(465)
CreateObject(1422,-1571.91699219,728.56640625,6.44259882,0.00000000,0.00000000,268.42895508); //object(466)
CreateObject(1422,-1571.92871094,731.49511719,6.44959402,0.00000000,0.00000000,270.42895508); //object(467)
CreateObject(1422,-1571.92871094,734.27246094,6.44959402,0.00000000,0.00000000,268.42895508); //object(468)
CreateObject(1422,-1571.87011719,737.17675781,6.44959402,0.00000000,0.00000000,270.42895508); //object(469)
CreateObject(1422,-1571.52050781,741.02636719,6.60903406,0.00000000,0.00000000,268.23120117); //object(470)
CreateObject(8673,-1572.28808594,730.70410156,7.50597906,0.00000000,0.00000000,88.42895508); //object(471)
CreateObject(8673,-1651.57226562,419.28808594,8.15441608,0.00000000,0.00000000,45.64343262); //object(472)
CreateObject(8673,-1668.14257812,402.83886719,8.15441608,0.00000000,0.00000000,45.64343262); //object(473)
CreateObject(8673,-1684.68750000,386.31054688,8.15441608,0.00000000,0.00000000,45.64343262); //object(474)
CreateObject(981,-1798.82983400,358.85650600,16.97512600,0.00000000,0.00000000,-2.14484400); //object(476)
CreateObject(1237,-1789.39428700,-126.47023000,4.65131900,0.00000000,0.00000000,0.00000000); //object(477)
CreateObject(1237,-1789.37390100,-275.77542100,20.96716700,0.00000000,0.00000000,0.00000000); //object(478)
CreateObject(1237,-1789.28698700,-286.17846700,22.77964400,0.00000000,0.00000000,0.00000000); //object(479)
CreateObject(1237,-1795.75647000,-358.31259200,19.04517700,0.00000000,0.00000000,0.00000000); //object(480)
CreateObject(1237,-1798.89331100,-376.84362800,17.16256000,0.00000000,0.00000000,0.00000000); //object(481)
CreateObject(1237,-1813.24414100,-467.07138100,14.12006900,0.00000000,0.00000000,0.00000000); //object(482)
CreateObject(1237,-1814.84423800,-486.36514300,14.12006900,0.00000000,0.00000000,0.00000000); //object(483)
CreateObject(1237,-1810.62133800,-542.98339800,14.63963300,0.00000000,0.00000000,0.00000000); //object(484)
CreateObject(7418,-1854.05078125,-545.92285156,15.33593845,0.00000000,0.00000000,93.56555176); //object(484)
CreateObject(7418,-1854.04785156,-545.95410156,17.95093536,0.00000000,0.00000000,93.56555176); //object(485)
CreateObject(7418,-1854.02148438,-545.93945312,12.79455280,0.00000000,0.00000000,93.56555176); //object(486)
CreateObject(7418,-1854.02246094,-545.91503906,20.56175613,0.00000000,0.00000000,93.56555176); //object(487)
CreateObject(7418,-1853.99121094,-545.89160156,23.12934685,0.00000000,0.00000000,93.56555176); //object(488)
CreateObject(3336,-1551.47656250,743.41308594,6.29696989,0.00000000,0.00000000,270.42895508); //object(489)
CreateObject(3554,-1617.45788600,406.41156000,14.58406300,0.00000000,0.00000000,0.19635000); //object(490)
CreateObject(5811,-1525.06140100,699.21759000,10.06345600,0.00000000,0.00000000,0.98174800); //object(491)
CreateObject(6958,-2004.06250000,421.80371094,42.08246231,0.00000000,0.00000000,270.42895508); //object(492)
CreateObject(7304,-1677.55175781,358.12011719,10.16950989,0.00000000,0.00000000,315.21447754); //object(493)
CreateObject(7305,-1579.56152344,421.70312500,9.07537270,0.00000000,0.00000000,278.56079102); //object(494)
CreateObject(7306,-1555.30078125,460.16210938,9.07537270,0.00000000,0.00000000,284.73107910); //object(496)
CreateObject(7307,-1527.80004883,626.79998779,15.30000019,0.00000000,0.00000000,225.64343262); //object(497)
CreateObject(7606,-1579.79687500,421.55273438,6.42598486,0.00000000,0.00000000,143.34631348); //object(498)
CreateObject(7610,-1608.19372600,433.30523700,14.42291500,0.00000000,0.00000000,-0.19635000); //object(499)
CreateObject(7900,-1855.49682600,110.49987000,22.57110600,0.00000000,0.00000000,3.14159300); //object(500)
CreateObject(7901,-1856.83960000,164.03508000,22.63570600,0.00000000,0.00000000,1.35944600); //object(501)
CreateObject(7906,-1855.54577600,110.37486300,35.17430900,0.00000000,0.00000000,3.14159300); //object(502)
CreateObject(7907,-1861.78051800,143.42259200,22.11254900,0.00000000,0.00000000,1.38944600); //object(503)
CreateObject(7909,-1857.43750000,163.93576000,31.34522600,0.00000000,0.00000000,1.35944700); //object(505)
CreateObject(7912,-1671.32543900,454.99679600,10.11405600,0.00000000,0.00000000,0.63404800); //object(507)
CreateObject(7913,-1571.96118200,704.53668200,11.29927600,0.00000000,0.00000000,-4.71238900); //object(508)
CreateObject(7914,-1527.75878906,680.90625000,15.52046776,0.00000000,0.00000000,268.42895508); //object(509)
CreateObject(7915,-1809.70800781,-48.65820312,17.43833351,0.00000000,0.00000000,91.56555176); //object(510)
CreateObject(7918,-1496.67968750,688.77734375,1.67901003,0.00000000,0.00000000,87.56555176); //object(511)
CreateObject(8406,-1587.36572300,1039.77954100,11.56440300,0.00000000,0.00000000,0.00000000); //object(514)
CreateObject(8406,-1586.15905800,1083.25708000,11.56440300,0.00000000,0.00000000,0.00000000); //object(515)
CreateObject(8406,-1586.42456100,1125.75048800,11.56440300,0.00000000,0.00000000,0.00000000); //object(516)
CreateObject(8406,-1588.39941406,1177.44335938,11.57218266,0.00000000,0.00000000,12.19226074); //object(517)
CreateObject(9314,-1557.04101562,457.48730469,7.24768114,0.00000000,0.00000000,333.50012207); //object(521)
CreateObject(9314,-1554.06640625,463.00781250,7.26816797,0.00000000,0.00000000,329.50012207); //object(522)
CreateObject(9314,-1557.08691406,457.39550781,10.12265110,0.00000000,0.00000000,333.50012207); //object(523)
CreateObject(9314,-1554.13574219,462.87988281,10.12267017,0.00000000,0.00000000,329.50012207); //object(524)
CreateObject(10281,-1539.66162100,568.23223900,14.32917300,0.00000000,0.00000000,-2.55119500); //object(525)
CreateObject(10281,-1581.59118700,528.58953900,15.97089400,-0.04500000,-0.73500000,-4.09199200); //object(526)
CreateObject(10838,-1553.87597656,720.43554688,23.59147263,0.00000000,0.00000000,88.42895508); //object(527)
CreateObject(11435,-1545.38574219,538.04882812,8.36593437,356.86340332,0.00000000,270.70764160); //object(528)
CreateObject(6958,-1546.70153800,514.22454800,14.32157300,0.00000000,0.00000000,3.00659200); //object(534)
CreateObject(7305,-1518.31054688,517.02636719,9.21755791,0.00000000,0.00000000,315.21447754); //object(535)
CreateObject(973,-1518.33789062,517.39648438,7.16834497,0.00000000,0.00000000,89.56555176); //object(536)
CreateObject(973,-1518.48144531,544.46289062,7.16834497,0.00000000,0.00000000,89.56555176); //object(537)
CreateObject(9191,-1518.28649900,558.07727100,9.65212400,0.00000000,0.00000000,-1.57079600); //object(538)
CreateObject(3715,-1524.27734375,576.25097656,7.74321985,0.00000000,0.00000000,300.12585449); //object(539)
CreateObject(7304,-1482.85742188,751.09179688,9.28481293,0.00000000,0.00000000,0.00000000); //object(546)
CreateObject(7306,-1830.90002441,86.09999847,17.00000000,0.00000000,0.00000000,134.35107422); //object(528)
CreateObject(7906,-1829.37695312,23.94140625,17.44614601,0.00000000,0.00000000,89.56555176); //object(529)
CreateObject(7906,-1809.76367188,-65.54199219,17.43833351,0.00000000,0.00000000,89.56555176); //object(530)
CreateObject(1422,-1809.55078125,-124.25488281,5.05896902,0.00000000,0.00000000,270.42895508); //object(531)
CreateObject(1422,-1809.41015625,-119.41503906,4.90806389,0.00000000,0.00000000,270.42895508); //object(532)
CreateObject(1422,-1809.38671875,-116.29003906,4.90806389,0.00000000,0.00000000,270.42895508); //object(533)
CreateObject(1422,-1809.36816406,-108.69921875,5.05896902,0.00000000,0.00000000,268.42895508); //object(534)
CreateObject(1422,-1809.44042969,-113.01269531,4.90806389,0.00000000,0.00000000,270.42895508); //object(535)
CreateObject(8673,-1809.52343750,-116.73925781,5.96444988,0.00000000,0.00000000,270.42895508); //object(536)
CreateObject(8673,-1809.70507812,-236.77539062,18.69347763,0.00000000,0.00000000,270.42895508); //object(537)
CreateObject(1422,-1809.73144531,-228.71875000,17.78553009,0.00000000,0.00000000,270.42895508); //object(538)
CreateObject(1422,-1809.42675781,-236.35937500,17.63709259,0.00000000,0.00000000,270.42895508); //object(539)
CreateObject(1422,-1809.38671875,-232.91406250,17.63709259,0.00000000,0.00000000,270.42895508); //object(540)
CreateObject(1422,-1809.43359375,-239.74023438,17.63709259,0.00000000,0.00000000,270.42895508); //object(541)
CreateObject(1422,-1809.51367188,-244.03613281,17.78553009,0.00000000,0.00000000,268.42895508); //object(542)
CreateObject(1238,-1794.00402800,-126.41667200,4.96661700,0.00000000,0.00000000,-7.46128400); //object(543)
CreateObject(1238,-1793.96777300,-146.35751300,6.02238000,0.00000000,0.00000000,-7.46128400); //object(544)
CreateObject(1238,-1804.33361800,-106.26411400,4.96661800,0.00000000,0.00000000,-3.14159300); //object(545)
CreateObject(1238,-1804.44128400,-65.91650400,11.31374400,0.00000000,0.00000000,-4.31969100); //object(546)
CreateObject(1238,-1794.01281700,-246.29489100,17.69318000,0.00000000,0.00000000,-7.46128400); //object(547)
CreateObject(1238,-1794.00451700,-286.35394300,23.12640400,0.00000000,0.00000000,-7.46128400); //object(548)
CreateObject(1238,-1809.00866700,-406.75885000,15.30136300,0.00000000,0.00000000,-7.46128400); //object(549)
CreateObject(1238,-1820.33874500,-506.70822100,14.42755500,0.00000000,0.00000000,-7.46128400); //object(550)
CreateObject(1238,-1804.45019500,-206.31283600,15.65417100,0.00000000,0.00000000,-3.14159300); //object(551)
CreateObject(1238,-1804.32519500,-226.36557000,17.68717200,0.00000000,0.00000000,-3.14159300); //object(552)
CreateObject(1238,-1809.27050800,-346.71987900,20.82378200,0.00000000,0.00000000,-3.14159300); //object(553)
CreateObject(1238,-1828.50195300,-466.71304300,14.42755500,0.00000000,0.00000000,-3.14159300); //object(554)
CreateObject(1238,-1825.93823200,-542.53283700,14.92523800,0.00000000,0.00000000,-3.14159300); //object(555)
CreateObject(973,-1836.36132812,-570.03710938,17.26778221,0.00000000,347.00000000,178.85791016); //object(557)
CreateObject(973,-1845.29199219,-570.04296875,19.31074715,0.00000000,347.00000000,180.85791016); //object(558)
CreateObject(973,-1853.98437500,-570.01562500,21.06036186,0.00000000,347.00000000,180.85791016); //object(559)
CreateObject(973,-1824.27734375,-557.88964844,15.83061790,0.00000000,359.98352051,268.43994141); //object(560)
CreateObject(973,-1824.97753906,-548.64062500,15.54611874,0.00000000,359.95056152,276.56079102); //object(561)
CreateObject(979,-1829.32421875,-538.96679688,15.11319733,0.00000000,0.00000000,317.49316406); //object(562)
CreateObject(978,-1888.97949219,-591.25292969,24.28553200,0.00000000,0.00000000,341.51660156); //object(564)
CreateObject(5811,-1805.22766100,-494.97433500,13.61816000,0.00000000,0.00000000,0.58904900); //object(565)
CreateObject(972,-1796.66931200,-485.12728900,13.95781900,0.00000000,0.00000000,-0.98174800); //object(566)
CreateObject(1237,-1829.95947300,-589.36090100,15.63728900,0.00000000,0.00000000,0.00000000); //object(567)
CreateObject(1238,-1847.98217800,-589.29895000,19.87706800,0.00000000,0.00000000,-1.57079600); //object(568)
CreateObject(1237,-1874.01220700,-570.46484400,23.50727500,0.00000000,0.00000000,0.00000000); //object(569)
CreateObject(8673,-1918.24707031,-552.76757812,26.05912399,0.00000000,0.00000000,90.42895508); //object(570)
CreateObject(978,-1916.14355469,-533.66210938,24.10897446,0.00000000,0.00000000,250.03344727); //object(571)
CreateObject(978,-1916.15625000,-533.65917969,24.58396721,0.00000000,0.00000000,250.03344727); //object(572)
CreateObject(8674,-1916.28320312,-534.02539062,26.23566246,0.00000000,0.00000000,250.03344727); //object(573)
CreateObject(8673,-1930.02050781,-326.80664062,29.48559189,0.00000000,3.00000000,0.85791016); //object(574)
CreateObject(8674,-1914.41113281,-326.86132812,28.70579910,0.04394531,359.96704102,354.79748535); //object(575)
CreateObject(8674,-1905.75390625,-327.62304688,28.44499969,0.04394531,359.96704102,352.74804688); //object(576)
CreateObject(8674,-1898.30566406,-332.16113281,28.40060425,0.04394531,0.01098633,305.90759277); //object(577)
CreateObject(8674,-1895.25000000,-339.90917969,28.55697060,0.04394531,0.01098633,101.39120483); //object(578)
CreateObject(7305,-1893.09472656,-491.93457031,28.17222023,0.00000000,0.00000000,315.21447754); //object(579)
CreateObject(7305,-1893.05664062,-440.64550781,28.13473129,0.00000000,0.00000000,315.21447754); //object(580)
CreateObject(7305,-1892.93457031,-390.84277344,28.11736298,0.00000000,0.00000000,315.21447754); //object(581)
CreateObject(7306,-1915.20507812,-491.47558594,28.17187500,0.00000000,0.00000000,136.35107422); //object(583)
CreateObject(7306,-1915.20214844,-441.04394531,28.21738052,0.00000000,0.00000000,134.35107422); //object(584)
CreateObject(7306,-1915.07519531,-390.93554688,28.14628220,0.00000000,0.00000000,134.35107422); //object(585)
CreateObject(7915,-1918.78125000,-553.24316406,26.97775841,0.00000000,0.00000000,89.56555176); //object(586)
CreateObject(7305,-2095.23144531,-355.79199219,37.01754761,0.00000000,0.00000000,221.44567871); //object(587)
CreateObject(7304,-2232.90820312,-260.82226562,37.35697937,0.00000000,0.00000000,179.13659668); //object(588)
CreateObject(7304,-2139.30004883,-281.29998779,37.50000000,0.00000000,0.00000000,89.56555176); //object(589)
CreateObject(8406,-2253.49218750,-171.79003906,39.69721603,0.00000000,0.00000000,181.13659668); //object(590)
CreateObject(8406,-2253.41503906,-140.14843750,39.69721603,0.00000000,0.00000000,179.13659668); //object(591)
CreateObject(8406,-2253.36621094,-114.40039062,39.69721603,0.00000000,0.00000000,181.13659668); //object(592)
CreateObject(8406,-2253.65527344,-82.09570312,39.69721603,0.00000000,0.00000000,181.13659668); //object(593)
CreateObject(8406,-2258.31445312,-35.00195312,39.69721603,0.00000000,0.00000000,0.00000000); //object(594)
CreateObject(979,-2263.92285156,63.49609375,35.01209641,0.00000000,0.00000000,306.18627930); //object(595)
CreateObject(978,-2268.48925781,48.97167969,35.01209641,0.00000000,0.00000000,301.20751953); //object(596)
CreateObject(978,-2273.65429688,56.55175781,35.00428391,0.00000000,0.00000000,307.40527344); //object(597)
CreateObject(978,-2278.89550781,64.22070312,35.00428391,0.00000000,0.00000000,301.20751953); //object(598)
CreateObject(973,-2265.23242188,70.44238281,35.01209641,0.00000000,0.00000000,264.33557129); //object(601)
CreateObject(973,-2264.39062500,79.74121094,35.01209641,0.00000000,0.00000000,264.33557129); //object(602)
CreateObject(973,-2263.68066406,89.00976562,35.01209641,0.00000000,0.00000000,266.36853027); //object(603)
CreateObject(973,-2263.11914062,98.33203125,35.01209641,0.00000000,0.00000000,266.36853027); //object(604)
CreateObject(973,-2262.61621094,107.64746094,35.01209641,0.00000000,0.00000000,268.37951660); //object(605)
CreateObject(978,-2266.46875000,39.92480469,35.01209641,0.00000000,0.00000000,264.61975098); //object(606)
CreateObject(978,-2282.49707031,72.74609375,35.00428391,0.00000000,0.00000000,285.00976562); //object(607)
CreateObject(973,-2283.28515625,80.66503906,35.01209641,0.00000000,0.00000000,266.36303711); //object(609)
CreateObject(973,-2282.70605469,90.00292969,35.01209641,0.00000000,0.00000000,266.36303711); //object(610)
CreateObject(979,-2268.52343750,71.46484375,35.01209641,0.00000000,0.00000000,291.98852539); //object(611)
CreateObject(4199,-2286.60009800,118.75686600,36.17496100,0.00000000,0.00000000,0.00000000); //object(612)
CreateObject(973,-2282.17871094,98.98242188,35.00428391,0.00000000,0.00000000,266.36303711); //object(613)
CreateObject(4199,-2286.28076200,187.53237900,36.17653300,0.00000000,0.00000000,0.00000000); //object(614)
CreateObject(973,-2281.12792969,139.27050781,35.00428391,0.00000000,0.00000000,270.42895508); //object(615)
CreateObject(973,-2281.14843750,148.54589844,34.99737930,0.00000000,0.00000000,270.42895508); //object(616)
CreateObject(973,-2281.14355469,157.88769531,35.00428391,0.00000000,0.00000000,270.42895508); //object(617)
CreateObject(973,-2281.13769531,167.23046875,35.00428391,0.00000000,0.00000000,270.42895508); //object(618)
CreateObject(8673,-2281.09277344,143.85156250,36.78104782,0.00000000,0.00000000,90.42895508); //object(619)
CreateObject(8673,-2281.07128906,164.25683594,36.78104782,0.00000000,0.00000000,270.42895508); //object(620)
CreateObject(3819,-2284.64941406,141.77343750,35.15491486,0.00000000,0.00000000,180.85791016); //object(621)
CreateObject(3819,-2284.19824219,153.54492188,35.16181946,0.00000000,0.00000000,180.85791016); //object(622)
CreateObject(3819,-2286.95117188,166.04492188,35.16181946,0.00000000,0.00000000,178.85791016); //object(623)
CreateObject(3819,-2286.80004900,95.81185200,35.16181900,0.00000000,0.00000000,-3.14159300); //object(624)
CreateObject(3819,-2287.30761719,83.18652344,35.16181946,0.00000000,0.00000000,176.85791016); //object(625)
CreateObject(8673,-2282.92089844,86.21386719,36.73104477,0.00000000,0.00000000,266.36853027); //object(626)
CreateObject(8674,-2282.22460938,72.00878906,36.73909760,0.00000000,0.00000000,104.71463013); //object(627)
CreateObject(978,-2266.00585938,176.00781250,35.00428391,0.00000000,0.00000000,209.63647461); //object(628)
CreateObject(978,-2273.49804688,170.92089844,34.99737549,0.00000000,0.00000000,219.83422852); //object(629)
CreateObject(978,-2279.07617188,163.93457031,35.00428391,0.00000000,0.00000000,242.22424316); //object(630)
CreateObject(5005,-2267.91113281,158.25390625,30.68905067,0.00000000,0.00000000,0.39599609); //object(632)
CreateObject(1238,-2264.24682600,7.69615900,34.63849300,0.00000000,0.00000000,-4.51604000); //object(633)
CreateObject(1238,-2257.39038100,138.29798900,34.63849300,0.00000000,0.00000000,-4.51604000); //object(634)
CreateObject(1238,-2257.14184600,218.24646000,34.63849300,0.00000000,0.00000000,-4.51604000); //object(635)
CreateObject(1238,-2257.31469700,237.01594500,34.63849300,0.00000000,0.00000000,-4.51604000); //object(636)
CreateObject(1238,-2246.79199200,178.27706900,34.63849300,0.00000000,0.00000000,-7.46128400); //object(637)
CreateObject(1238,-2246.80712900,78.28400400,34.63849300,0.00000000,0.00000000,-7.46128400); //object(638)
CreateObject(7304,-2296.84936500,141.53222700,37.20072900,0.00000000,0.00000000,3.14159200); //object(639)
CreateObject(1422,-2154.09033200,330.34207200,34.73084300,0.00000000,0.00000000,-3.14159300); //object(640)
CreateObject(1422,-2146.66870100,330.61413600,34.58240500,0.00000000,0.00000000,-3.14159300); //object(641)
CreateObject(1422,-2149.84399400,330.66473400,34.58240500,0.00000000,0.00000000,-3.14159300); //object(642)
CreateObject(1422,-2143.49731400,330.60397300,34.58240500,0.00000000,0.00000000,-3.14159300); //object(643)
CreateObject(1422,-2139.31494100,330.47207600,34.73084300,0.00000000,0.00000000,-3.14159300); //object(644)
CreateObject(8673,-2146.38989300,330.71310400,35.63879000,0.00000000,0.00000000,0.00000000); //object(645)
CreateObject(8673,-2241.93261719,263.04394531,46.92004013,0.00000000,0.00000000,88.42895508); //object(646)
CreateObject(8673,-2241.93457031,242.60644531,46.92004013,0.00000000,0.00000000,270.42895508); //object(647)
CreateObject(8674,-2248.45605469,252.13769531,41.35754013,0.00000000,0.00000000,270.42895508); //object(650)
CreateObject(8674,-2244.86621094,240.34472656,41.35754013,0.00000000,0.00000000,307.01672363); //object(651)
CreateObject(8674,-2244.84667969,263.64648438,41.35754013,0.00000000,0.00000000,51.83569336); //object(652)
CreateObject(8673,-2241.82128906,239.13769531,35.78722763,0.00000000,0.00000000,90.42895508); //object(654)
CreateObject(8673,-2241.82617188,259.55664062,35.78722763,0.00000000,0.00000000,270.42895508); //object(655)
CreateObject(3819,-2242.87500000,242.82910156,40.89563370,0.00000000,0.00000000,36.58776855); //object(656)
CreateObject(3819,-2242.75781250,261.17773438,40.88838196,0.00000000,0.00000000,321.40673828); //object(657)
CreateObject(3819,-2245.98706100,252.02171300,40.88838200,0.00000000,0.00000000,-0.00000100); //object(658)
CreateObject(5005,-2275.69921875,78.88574219,30.66548157,0.00000000,0.00000000,358.39599609); //object(661)
CreateObject(979,-2272.33105469,79.91308594,35.00428391,0.00000000,0.00000000,295.98852539); //object(662)
CreateObject(979,-2266.98046875,158.04980469,34.99737930,0.00000000,0.00000000,3.16955566); //object(663)
CreateObject(8406,-2006.52697800,452.25720200,39.54096600,0.00000000,0.00000000,0.00000000); //object(664)
CreateObject(8406,-2006.62597700,467.05706800,39.54096600,0.00000000,0.00000000,0.00000000); //object(665)
CreateObject(8406,-2006.60656700,494.68811000,39.54096600,0.00000000,0.00000000,0.00000000); //object(666)
CreateObject(8406,-2006.15332031,513.89453125,39.24707794,0.00000000,0.00000000,0.00000000); //object(667)
CreateObject(8406,-2006.30273400,553.90502900,39.54876300,0.00000000,0.00000000,0.00000000); //object(668)
CreateObject(8406,-2006.08569300,576.35022000,39.54876300,0.00000000,0.00000000,0.00000000); //object(669)
CreateObject(973,-1996.38183594,568.22851562,34.85584641,0.00000000,0.00000000,89.28686523); //object(670)
CreateObject(973,-1996.37207031,577.54394531,34.85584641,0.00000000,0.00000000,89.28686523); //object(671)
CreateObject(973,-1996.37792969,586.91308594,34.86238861,0.00000000,0.00000000,91.28686523); //object(672)
CreateObject(973,-1993.81152344,595.32226562,34.85584641,0.00000000,0.00000000,54.69360352); //object(673)
CreateObject(1422,-1991.37988281,615.87695312,34.58240509,0.00000000,0.00000000,268.42895508); //object(674)
CreateObject(1422,-1991.39160156,611.87792969,34.43395233,0.00000000,0.00000000,270.42895508); //object(675)
CreateObject(1422,-1991.43359375,608.87304688,34.43395233,0.00000000,0.00000000,270.42895508); //object(676)
CreateObject(1422,-1991.46191406,605.87695312,34.42615509,0.00000000,0.00000000,270.42895508); //object(677)
CreateObject(1422,-1991.46093750,603.02148438,34.42615509,0.00000000,0.00000000,270.42895508); //object(678)
CreateObject(1422,-1991.56152344,600.03125000,34.42615509,0.00000000,0.00000000,270.42895508); //object(679)
CreateObject(8673,-1991.35351562,608.07324219,35.48448563,0.00000000,0.00000000,268.42895508); //object(680)
CreateObject(8673,-1996.44140625,524.07812500,36.60760880,0.00000000,0.00000000,270.42895508); //object(681)
CreateObject(8673,-1996.40429688,564.25000000,36.60753250,0.00000000,0.00000000,270.42895508); //object(682)
CreateObject(8673,-1996.41113281,581.13964844,36.61415482,0.00000000,0.00000000,92.42895508); //object(683)
CreateObject(979,-1992.49902344,551.85937500,34.85584641,0.00000000,0.00000000,146.54882812); //object(684)
CreateObject(978,-1992.13281250,536.16406250,34.86363983,0.00000000,0.00000000,24.39001465); //object(685)
CreateObject(8406,-2006.59692400,744.84588600,49.81563900,0.00000000,0.00000000,0.00000000); //object(686)
CreateObject(8406,-2006.79602100,716.08410600,49.82221600,0.00000000,0.00000000,0.00000000); //object(687)
CreateObject(8406,-2001.49707031,795.91503906,49.82221603,0.00000000,0.00000000,178.85791016); //object(688)
CreateObject(3452,-1987.51171875,485.10156250,36.77183533,0.00000000,0.00000000,89.56555176); //object(689)
CreateObject(3452,-1987.48535156,441.71777344,36.77114105,0.00000000,0.00000000,89.56555176); //object(690)
CreateObject(3452,-1985.30664062,386.76562500,36.75529480,0.00000000,0.00000000,89.56555176); //object(691)
CreateObject(972,-1986.05432100,375.10220300,27.71009800,0.46500000,-0.01500000,-1.57079700); //object(692)
CreateObject(972,-1988.37890625,430.19628906,27.66877365,0.46142578,359.98352051,0.42895508); //object(693)
CreateObject(972,-1988.25659200,473.48498500,27.49378400,0.46500000,-0.01500000,-1.57079700); //object(694)
CreateObject(972,-1985.72412100,404.80310100,28.19374700,0.46500000,-0.01500000,-1.57079700); //object(695)
CreateObject(972,-1988.19140600,459.75378400,27.71303200,0.46500000,-0.01500000,-1.57079700); //object(696)
CreateObject(972,-1988.38317900,503.14468400,27.86874000,0.46500000,-0.01500000,-1.57079700); //object(697)
CreateObject(972,-1970.81726100,496.50738500,26.84377900,0.00000000,0.00000000,-4.71238900); //object(698)
CreateObject(978,-1992.51367188,857.63867188,45.14363861,0.00000000,0.00000000,185.05017090); //object(700)
CreateObject(978,-2001.01269531,854.10058594,45.13709641,0.00000000,0.00000000,221.44567871); //object(701)
CreateObject(978,-2007.52343750,847.60156250,45.13709641,0.00000000,0.00000000,227.83569336); //object(702)
CreateObject(978,-2011.04296875,839.12695312,45.13709641,0.00000000,0.00000000,268.23120117); //object(703)
CreateObject(978,-2011.92578125,830.11035156,45.13709641,0.00000000,0.00000000,260.42895508); //object(704)
CreateObject(1238,-1952.61035200,858.05047600,41.59726700,0.00000000,0.00000000,-4.71239000); //object(708)
CreateObject(1238,-1919.22106900,832.69427500,35.55297100,0.00000000,0.00000000,-7.85398300); //object(709)
CreateObject(6958,-2004.09472656,529.79003906,42.07466507,0.00000000,0.00000000,88.42895508); //object(710)
CreateObject(6958,-2004.13085938,590.64746094,42.13246536,0.00000000,0.00000000,88.42895508); //object(711)
CreateObject(7906,-1976.12792969,387.71972656,43.87808228,0.00000000,0.00000000,270.42895508); //object(712)
CreateObject(7915,-1978.18164062,441.69628906,44.05319214,0.00000000,0.00000000,270.42895508); //object(713)
CreateObject(7907,-1978.40002441,485.70001221,43.50000000,0.00000000,0.00000000,270.42895508); //object(714)
CreateObject(7305,-1967.59997559,438.70001221,46.90000153,0.00000000,0.00000000,315.21447754); //object(715)
CreateObject(7306,-1967.40002441,536.29998779,46.59999847,0.00000000,0.00000000,315.21447754); //object(716)
CreateObject(7307,-1943.00842300,413.37429800,45.76187900,0.00000000,0.00000000,-0.78539800); //object(717)
CreateObject(7909,-1991.68457031,631.36328125,43.42324066,0.00000000,0.00000000,270.42895508); //object(719)
CreateObject(6958,-2004.07714844,741.99414062,52.41371918,0.00000000,0.00000000,89.28686523); //object(720)
CreateObject(6958,-2004.14062500,828.24316406,52.38882065,0.00000000,0.00000000,90.14477539); //object(721)
CreateObject(9314,-1884.85644531,928.56835938,34.87575531,0.00000000,0.00000000,0.00000000); //object(722)
CreateObject(9314,-1884.89050300,934.77734400,34.87575500,0.00000000,0.00000000,0.00000000); //object(723)
CreateObject(8673,-1907.44531250,934.83691406,35.48254013,0.00000000,0.00000000,270.42895508); //object(724)
CreateObject(8673,-1907.44531250,916.28710938,35.48254013,0.00000000,0.00000000,270.42895508); //object(725)
CreateObject(8673,-1978.66015625,862.77246094,46.26481247,0.00000000,0.00000000,0.85791016); //object(726)
CreateObject(8673,-1958.86718750,862.80859375,44.50181198,1.00000000,10.00000000,0.85791016); //object(727)
CreateObject(8673,-1938.91503906,862.86425781,40.89812088,0.00000000,10.00000000,358.85791016); //object(729)
CreateObject(8674,-1992.96484375,857.48242188,46.96386337,0.00000000,0.00000000,4.19226074); //object(730)
CreateObject(8674,-2001.06054688,853.98828125,46.97040558,0.00000000,0.00000000,40.58776855); //object(731)
CreateObject(8674,-2007.38671875,847.79394531,46.96386337,0.00000000,0.00000000,46.97778320); //object(732)
CreateObject(8674,-2011.02050781,839.01953125,46.96386337,0.00000000,0.00000000,87.37329102); //object(733)
CreateObject(7909,-2004.03320312,860.63671875,47.62583160,0.00000000,0.00000000,20.19226074); //object(734)
CreateObject(1238,-1907.86816400,893.55957000,34.49005500,0.00000000,0.00000000,-6.87223500); //object(735)
CreateObject(1238,-1889.36340300,954.82080100,34.49005500,0.00000000,0.00000000,-6.47953600); //object(736)
CreateObject(1238,-1903.19018600,970.93566900,34.48224300,0.00000000,0.00000000,-7.06858500); //object(737)
CreateObject(1238,-1884.01647900,986.47644000,34.51054000,0.00000000,0.00000000,-10.21017500); //object(738)
CreateObject(1238,-1879.04272500,1015.33776900,39.53294800,0.00000000,0.00000000,-10.21017500); //object(739)
CreateObject(1238,-1875.88354500,1050.56176800,44.75693900,0.00000000,0.00000000,-10.21017500); //object(740)
CreateObject(1238,-1897.87646500,1002.55450400,37.03255100,0.00000000,0.00000000,-7.06858500); //object(741)
CreateObject(1238,-1892.86840800,1031.40844700,42.86135100,0.00000000,0.00000000,-7.06858500); //object(742)
CreateObject(978,-1890.76074219,851.82519531,33.69060516,0.00000000,0.00000000,89.56555176); //object(743)
CreateObject(978,-1906.87194800,833.26196300,33.68088200,0.00000000,0.00000000,-0.00000200); //object(744)
CreateObject(978,-1892.57714844,842.79394531,33.70586777,0.00000000,0.00000000,67.17553711); //object(745)
CreateObject(978,-1898.27832031,835.88964844,33.70577621,0.00000000,0.00000000,32.58776855); //object(746)
CreateObject(978,-1992.41699219,857.17578125,43.96202469,0.00000000,0.00000000,183.33435059); //object(747)
CreateObject(978,-2000.90917969,853.66503906,43.96865845,0.00000000,0.00000000,221.72985840); //object(748)
CreateObject(978,-2007.37402344,847.24218750,43.96202469,0.00000000,0.00000000,228.11987305); //object(749)
CreateObject(978,-2010.86230469,838.79394531,43.96202469,0.00000000,0.00000000,264.51538086); //object(750)
CreateObject(978,-2011.83068800,315.23620600,33.66560400,0.00000000,0.00000000,0.00000000); //object(751)
CreateObject(978,-2003.22363281,317.80761719,33.65577316,0.00000000,0.00000000,32.58776855); //object(752)
CreateObject(978,-1998.38183594,325.04296875,33.65577316,0.00000000,0.00000000,79.37329102); //object(753)
CreateObject(978,-2247.99414062,325.62304688,33.84685516,0.00000000,0.00000000,189.13659668); //object(754)
CreateObject(978,-2256.02343750,322.30957031,33.86202621,0.00000000,0.00000000,215.92211914); //object(755)
CreateObject(978,-2261.07519531,314.77441406,33.83702469,0.00000000,0.00000000,254.31762695); //object(756)
CreateObject(978,-2249.76611300,-200.38728300,33.82185400,0.00000000,0.00000000,0.00000100); //object(757)
CreateObject(978,-2258.29296875,-197.85253906,33.81202316,0.00000000,0.00000000,325.40673828); //object(758)
CreateObject(978,-2263.19921875,-191.93261719,33.81202316,0.00000000,0.00000000,290.81896973); //object(759)
CreateObject(978,-2264.88183594,-183.10449219,33.81208420,0.00000000,0.00000000,272.42895508); //object(760)
CreateObject(978,-2206.12500000,-188.94628906,33.86961746,0.00000000,0.00000000,138.07232666); //object(761)
CreateObject(978,-2212.64453125,-185.30761719,33.88213730,0.00000000,0.00000000,170.66015625); //object(762)
CreateObject(978,-2202.67773438,-195.77050781,33.87973022,0.00000000,0.00000000,97.47912598); //object(763)
CreateObject(978,-2196.79785156,-308.61914062,33.93546677,0.00000000,0.00000000,270.14477539); //object(764)
CreateObject(978,-2194.52539062,-316.67675781,33.93546677,0.00000000,0.00000000,298.73254395); //object(765)
CreateObject(978,-2187.56347656,-322.36132812,33.94953537,0.00000000,0.00000000,341.32031250); //object(766)
CreateObject(978,-1905.66894531,-585.36816406,23.13554955,0.00000000,0.00000000,318.93029785); //object(767)
CreateObject(978,-1909.88867188,-577.45898438,23.15431404,0.00000000,0.00000000,278.33703613); //object(768)
CreateObject(978,-1897.68994100,-588.66485600,23.13555000,0.00000000,0.00000000,-6.28318300); //object(769)
CreateObject(978,-1888.96191406,-590.95019531,23.11054993,0.00000000,0.00000000,337.19946289); //object(770)
CreateObject(978,-1808.05859375,-575.00488281,15.02617455,0.00000000,0.00000000,89.00268555); //object(771)
CreateObject(978,-1827.02148438,-589.12500000,15.02617455,0.00000000,0.00000000,355.43164062); //object(772)
CreateObject(978,-1810.63281250,-583.45410156,15.03359032,0.00000000,0.00000000,52.41491699); //object(773)
CreateObject(978,-1817.79003906,-588.22070312,15.05117416,0.00000000,0.00000000,16.19226074); //object(774)
CreateObject(978,-1546.10351562,703.94238281,5.67927790,0.00000000,0.00000000,20.39001465); //object(775)
CreateObject(978,-1539.80859375,707.75292969,5.67927790,0.00000000,0.00000000,42.78002930); //object(776)
CreateObject(978,-1538.35253906,709.86621094,5.67928505,0.00000000,0.00000000,55.07116699); //object(777)
CreateObject(978,-1537.16210938,715.28417969,5.67927694,0.00000000,0.00000000,81.45568848); //object(778)
CreateObject(8673,-1659.20507812,1260.69238281,8.65597057,0.00000000,0.00000000,315.21447754); //object(779)
CreateObject(8673,-1644.73828125,1246.20410156,8.65597057,0.00000000,0.00000000,315.21447754); //object(780)
CreateObject(8673,-1630.27832031,1231.71582031,8.65597057,0.00000000,0.00000000,315.21447754); //object(781)
CreateObject(8674,-1620.45703125,1221.83593750,8.63097095,0.00000000,0.00000000,315.21447754); //object(782)
CreateObject(8674,-1613.86230469,1214.27343750,8.60597134,0.00000000,0.00000000,309.07714844); //object(783)
CreateObject(7915,-1904.30273438,1025.16308594,47.99059677,0.00000000,0.00000000,89.28686523); //object(784)
CreateObject(3715,-1884.34960938,957.39941406,35.47089767,0.00000000,0.00000000,271.40075684); //object(785)
CreateObject(8406,-1881.98730469,1090.23242188,49.82221603,0.00000000,0.00000000,178.85791016); //object(786)
CreateObject(8406,-1881.45312500,1157.64550781,49.82221603,0.00000000,0.00000000,180.85791016); //object(787)
CreateObject(6958,-1884.04101562,1115.10156250,52.31370926,0.00000000,0.00000000,90.14477539); //object(788)
CreateObject(7306,-1866.85839844,1064.29882812,47.97380829,0.00000000,0.00000000,315.21447754); //object(789)
CreateObject(7915,-1787.17321800,1286.32385300,16.93979300,0.00000000,0.00000000,-0.06134900); //object(790)
CreateObject(7305,-1636.08886719,1267.08496094,9.06266212,0.00000000,0.00000000,0.00000000); //object(791)
CreateObject(7304,-1561.79394500,1101.81750500,9.07573100,0.00000000,0.00000000,0.00000000); //object(792)
CreateObject(7306,-1576.85717800,1208.18823200,9.07836300,0.00000000,0.00000000,-0.27135000); //object(794)
CreateObject(3452,-1605.39257812,1053.93945312,8.73906136,0.00000000,0.00000000,270.42895508); //object(795)
CreateObject(3452,-1605.41308594,1083.50097656,8.72122192,0.00000000,0.00000000,270.42895508); //object(796)
CreateObject(3452,-1605.36816406,1113.06738281,8.76353264,0.00000000,0.00000000,270.42895508); //object(797)
CreateObject(3452,-1605.40332031,1142.58300781,8.78850937,0.00000000,0.00000000,270.42895508); //object(798)
CreateObject(7304,-1614.98913600,1097.89392100,15.11099400,0.00000000,0.00000000,-3.14159200); //object(799)
CreateObject(972,-1604.73925781,1035.92285156,0.03906300,0.46142578,359.98352051,253.28686523); //object(800)
CreateObject(972,-1614.86816406,1195.03906250,0.58594102,0.45593262,359.97802734,273.98999023); //object(801)
CreateObject(972,-1604.58593750,1154.17187500,-0.33905801,0.46142578,359.98352051,95.28686523); //object(802)
CreateObject(972,-1701.21508800,1272.53381300,-1.91667600,0.46500000,-0.01500000,-3.33794300); //object(803)
CreateObject(972,-1693.50720200,1309.26525900,-1.13127900,0.46500000,-0.01500000,-6.47953700); //object(804)
CreateObject(8674,-1708.90234375,1301.64746094,8.63097095,0.00000000,0.00000000,333.60449219); //object(805)
CreateObject(8674,-1717.56054688,1303.52343750,8.61868668,0.00000000,0.00000000,4.00000000); //object(806)
CreateObject(8674,-1726.61132812,1301.82421875,8.60597134,0.00000000,0.00000000,202.39001465); //object(807)
CreateObject(8673,-1592.21777344,1132.01757812,8.77940559,0.00000000,0.00000000,270.42895508); //kurwa1
CreateObject(8673,-1592.21777344,1050.19238281,8.77940559,0.00000000,0.00000000,270.42895508); //kurwa1
CreateObject(8673,-1592.21777344,1070.59277344,8.77940559,0.00000000,0.00000000,270.42895508); //kurwa1
CreateObject(8673,-1592.21777344,1091.14160156,8.77940559,0.00000000,0.00000000,270.42895508); //kurwa1
CreateObject(8673,-1592.21777344,1111.61816406,8.77940559,0.00000000,0.00000000,270.42895508); //kurwa1
CreateObject(1262,-1559.32336400,743.75732400,12.82014200,0.00000000,0.00000000,0.00000000); //object(794)
CreateObject(1262,-1558.87536600,743.75683600,12.80575400,0.00000000,0.00000000,0.00000000); //object(795)
CreateObject(1262,-1558.38806200,743.78210400,12.80981300,0.00000000,0.00000000,0.00000000); //object(796)
CreateObject(1262,-1557.90954600,743.75585900,12.82891100,0.00000000,0.00000000,0.00000000); //object(797)
CreateObject(11391,-1674.80224600,442.85092200,7.46943400,0.00000000,0.00000000,-0.78539800); //object(800)
CreateObject(11391,-1521.24096700,562.39959700,7.46943400,0.00000000,0.00000000,-3.14159200); //object(801)
CreateObject(11391,-1835.68042000,111.77574200,15.40693500,0.00000000,0.00000000,-4.71238800); //object(802)
CreateObject(4199,-1855.39782700,151.32238800,16.12966500,0.00000000,0.00000000,-0.19635000); //object(803)
CreateObject(11392,-1841.10351600,134.03263900,14.11220600,0.00000000,0.00000000,0.39269900); //object(804)
CreateObject(11393,-1843.22888200,166.19033800,15.64222700,0.00000000,0.00000000,-4.71238900); //object(805)
CreateObject(11392,-1655.24755900,434.57840000,6.22470200,0.00000000,0.00000000,-1.17809700); //object(806)
CreateObject(11393,-1704.72338900,406.09484900,7.70472800,0.00000000,0.00000000,2.35619400); //object(807)
CreateObject(14826,-1712.90478500,393.67767300,6.94406600,0.00000000,0.00000000,-1.96349500); //object(808)
CreateObject(14826,-1674.43310500,438.35434000,6.94406600,0.00000000,0.00000000,-1.96349500); //object(809)
CreateObject(14826,-1850.00647000,133.36245700,14.11718400,0.00000000,0.00000000,-1.96349500); //object(810)
CreateObject(11393,-1850.28491200,146.26950100,15.64222900,0.00000000,0.00000000,-1.76714600); //object(811)
CreateObject(11393,-1707.12890600,403.35745200,7.70472800,0.00000000,0.00000000,-2.35619400); //object(812)
CreateObject(8673,-1672.13867188,409.22949219,7.86535406,0.00000000,0.00000000,45.64343262); //object(813)
CreateObject(8673,-1673.04882812,410.52441406,7.86535406,0.00000000,0.00000000,45.64343262); //object(814)
CreateObject(8673,-1679.49707031,417.20019531,7.86535406,0.00000000,0.00000000,41.64343262); //object(815)
CreateObject(8673,-1678.34863281,416.14257812,7.86535406,0.00000000,0.00000000,45.64343262); //object(816)
CreateObject(1237,-1664.06799300,417.76620500,6.18256900,0.00000000,0.00000000,0.00000000); //object(817)
CreateObject(1237,-1664.64355500,418.36602800,6.18256900,0.00000000,0.00000000,0.00000000); //object(818)
CreateObject(1237,-1670.69030800,424.23016400,6.18256900,0.00000000,0.00000000,0.00000000); //object(819)
CreateObject(1237,-1671.21557600,424.85485800,6.18256900,0.00000000,0.00000000,0.00000000); //object(820)
CreateObject(1237,-1687.45422400,408.80554200,6.18256900,0.00000000,0.00000000,0.00000000); //object(821)
CreateObject(1237,-1686.92858900,408.20578000,6.18256900,0.00000000,0.00000000,0.00000000); //object(822)
CreateObject(1237,-1680.95397900,402.08413700,6.18256900,0.00000000,0.00000000,0.00000000); //object(823)
CreateObject(1237,-1680.38793900,401.50927700,6.18256900,0.00000000,0.00000000,0.00000000); //object(824)
CreateObject(1422,-1789.40136719,-123.85058594,5.05896902,0.00000000,0.00000000,84.42895508); //object(825)
CreateObject(1422,-1789.07714844,-119.68652344,4.91053104,0.00000000,0.00000000,90.42895508); //object(826)
CreateObject(1422,-1789.13867188,-116.30468750,4.91053104,0.00000000,0.00000000,90.42895508); //object(827)
CreateObject(1422,-1789.10546875,-113.01562500,4.91053104,0.00000000,0.00000000,90.42895508); //object(828)
CreateObject(1422,-1789.08593750,-108.82910156,5.05896902,0.00000000,0.00000000,88.42895508); //object(829)
CreateObject(11393,-2280.57592800,111.01433600,35.68910200,0.00000000,0.00000000,-1.57079600); //object(830)
CreateObject(11392,-2274.54931600,132.23553500,34.20908000,0.00000000,0.00000000,0.19635000); //object(831)
CreateObject(11391,-2279.25585900,191.46118200,35.45380800,0.00000000,0.00000000,0.00000000); //object(832)
CreateObject(14826,-2275.03686500,184.16032400,34.92844000,0.00000000,0.00000000,-2.94524300); //object(833)
CreateObject(14826,-2276.79345700,174.49252300,34.92844000,0.00000000,0.00000000,-2.15984400); //object(834)
CreateObject(11393,-2031.17004400,383.01724200,35.69691500,0.00000000,0.00000000,3.14159300); //object(836)
CreateObject(11391,-1990.57800300,569.10668900,35.46162000,0.00000000,0.00000000,0.00000000); //object(837)
CreateObject(11391,-1935.87292500,593.98687700,35.46162000,0.00000000,0.00000000,-1.57079600); //object(838)
CreateObject(11393,-1972.16137700,590.06427000,35.73191800,0.00000000,0.00000000,1.57079600); //object(839)
CreateObject(14826,-1954.87268100,591.86669900,34.94536200,0.00000000,0.00000000,2.74889300); //object(840)
CreateObject(1422,-2016.97558594,504.21679688,34.42615509,0.00000000,0.00000000,270.42895508); //object(841)
CreateObject(1422,-2016.97558594,501.09179688,34.42615509,0.00000000,0.00000000,270.42895508); //object(842)
CreateObject(1422,-2016.97460938,507.51660156,34.42615509,0.00000000,0.00000000,268.42895508); //object(843)
CreateObject(1422,-2016.79101562,808.32324219,44.70740509,0.00000000,0.00000000,88.42895508); //object(844)
CreateObject(1422,-2016.77539062,805.05859375,44.70740509,0.00000000,0.00000000,88.42895508); //object(845)
CreateObject(1422,-2016.87304688,811.66992188,44.70740509,0.00000000,0.00000000,90.42895508); //object(846)
CreateObject(1422,-2016.55566406,816.19238281,44.90257263,0.00000000,0.00000000,90.42895508); //object(847)
CreateObject(978,-2014.54882812,821.61816406,45.13709641,0.00000000,0.00000000,245.83569336); //object(848)
CreateObject(3566,-1641.44873000,1293.89697300,8.44929300,0.00000000,0.00000000,-0.78539800); //object(849)
CreateObject(3568,-1652.09094200,1304.19799800,8.42768500,0.00000000,0.00000000,-0.78539800); //object(850)
CreateObject(3569,-1658.87793000,1311.20117200,8.40268500,0.00000000,0.00000000,-0.78539800); //object(851)
CreateObject(3168,-1668.75915500,1325.32910200,6.54215900,0.00000000,0.00000000,0.58904900); //object(852)
CreateObject(3172,-1681.21557600,1322.64318800,6.43520700,0.00000000,0.00000000,1.96349500); //object(853)
CreateObject(3175,-1669.80493200,1309.76074200,6.06893300,0.00000000,0.00000000,0.00000000); //object(854)
CreateObject(14826,-1679.03137200,1306.78039600,6.94117100,0.00000000,0.00000000,2.15984400); //object(855)
CreateObject(11393,-1684.58435100,1311.92443800,7.70359100,0.00000000,0.00000000,1.96349500); //object(856)
CreateObject(8674,-1701.85839844,1297.03710938,8.63097095,0.00000000,0.00000000,317.21447754); //object(857)
CreateObject(3554,-1595.00000000,1010.55175781,16.31835556,0.00000000,0.00000000,292.80249023); //object(858)
CreateObject(7617,-1608.21289062,1182.26367188,15.60171890,0.00000000,0.00000000,292.39001465); //object(859)
CreateObject(7617,-1544.62072800,892.14007600,18.20326400,0.00000000,0.00000000,0.00000000); //object(860)
CreateObject(7617,-1579.23437500,744.39746094,17.10796165,0.00000000,0.00000000,89.21447754); //object(861)
CreateObject(7610,-1540.88671875,945.76562500,14.23383713,0.00000000,0.00000000,110.69360352); //object(862)
CreateObject(7617,-1908.83227500,1153.76574700,55.24399600,0.00000000,0.00000000,0.58904900); //object(863)
CreateObject(7617,-1922.93164100,342.45568800,35.27468900,0.00000000,0.00000000,-1.57079600); //object(864)
CreateObject(3566,-1536.43127400,493.89260900,8.56831000,0.00000000,0.00000000,-3.14159300); //object(866)
CreateObject(3568,-1545.22363281,493.77441406,8.54331017,0.00000000,0.00000000,1.13659668); //object(867)
CreateObject(3569,-1540.78356900,494.07849100,8.56831000,0.00000000,0.00000000,3.14159200); //object(868)
CreateObject(3569,-2179.51562500,306.40820312,36.45578766,0.00000000,0.00000000,90.42749023); //object(869)
CreateObject(3568,-2179.53125000,300.93554688,36.45578766,0.00000000,0.00000000,90.42895508); //object(870)
CreateObject(3566,-2179.45605469,293.68457031,36.43119049,0.00000000,0.00000000,90.42895508); //object(871)
CreateObject(1383,-2124.11987300,299.38787800,66.19736500,0.00000000,0.00000000,0.00000000); //object(872)
CreateObject(1384,-2124.35180700,299.22683700,98.73642700,0.00000000,0.00000000,0.00000000); //object(873)
CreateObject(1391,-2085.04687500,287.93551600,67.08599100,0.00000000,0.00000000,0.00000000); //object(874)
CreateObject(1388,-2084.81494100,287.93804900,79.62505300,0.00000000,0.00000000,-1.17809700); //object(875)
CreateObject(1395,-2029.14221200,279.50430300,66.04370900,0.00000000,0.00000000,0.00000000); //object(878)
CreateObject(1394,-2029.27600100,279.52447500,118.58277100,0.00000000,0.00000000,0.78539800); //object(879)
CreateObject(5126,-1727.01342800,-455.32031300,27.89611800,0.00000000,0.00000000,-3.14159200); //object(880)
CreateObject(1378,-1749.97241200,-534.07385300,22.27988800,0.00000000,0.00000000,0.00000000); //object(881)
CreateObject(10889,-1530.69140625,800.39257812,6.73750210,2.50000000,0.00000000,353.60595703); //object(877)
CreateObject(973,-1521.50292969,900.45898438,6.87928200,0.00000000,0.00000000,85.49414062); //object(878)
CreateObject(973,-1522.20410156,891.16406250,6.87928200,0.00000000,0.00000000,85.49414062); //object(879)
CreateObject(973,-1523.03808594,881.86132812,6.87928295,0.00000000,0.00000000,83.46118164); //object(880)
CreateObject(973,-1524.02246094,872.56933594,6.87928200,0.00000000,0.00000000,83.46118164); //object(881)
CreateObject(973,-1524.87402344,863.23828125,6.87928200,0.00000000,0.00000000,85.49414062); //object(882)
CreateObject(1237,-1525.27172900,858.33032200,6.19038100,0.00000000,0.00000000,0.00000000); //object(883)
CreateObject(1237,-1525.19580100,851.78100600,6.19038100,0.00000000,0.00000000,0.00000000); //object(884)
CreateObject(1237,-1525.27160600,856.60369900,6.19038100,0.00000000,0.00000000,0.00000000); //object(885)
CreateObject(1237,-1525.29663100,855.05658000,6.19038100,0.00000000,0.00000000,0.00000000); //object(886)
CreateObject(1237,-1525.24462900,853.48101800,6.19038100,0.00000000,0.00000000,0.00000000); //object(887)
CreateObject(7304,-1505.42260700,893.89917000,9.07573100,0.00000000,0.00000000,0.00000000); //object(888)
CreateObject(3452,-1504.67089844,809.85351562,8.75976753,0.00000000,0.00000000,89.56555176); //object(889)
CreateObject(3452,-1504.63964844,780.31738281,8.72169495,0.00000000,0.00000000,89.56555176); //object(890)
CreateObject(3452,-1504.62207031,750.77343750,8.71192074,0.00000000,0.00000000,89.56555176); //object(891)
CreateObject(972,-1505.55896000,828.00305200,-0.26561700,0.46500000,-0.01500000,-1.57079700); //object(892)
CreateObject(972,-1505.55529800,739.14154100,0.08437800,0.46500000,-0.01500000,-1.57079700); //object(893)
CreateObject(7307,-1495.50000000,762.79998779,15.00000000,0.00000000,0.00000000,225.64343262); //object(894)
CreateObject(7914,-1495.39099100,807.72155800,15.75149700,0.00000000,0.00000000,-1.57079600); //object(895)
CreateObject(4199,-1577.11120600,759.80786100,7.93279000,0.00000000,0.00000000,0.00000000); //object(896)
CreateObject(4199,-1577.31762700,845.40930200,7.93279000,0.00000000,0.00000000,0.00000000); //object(897)
CreateObject(4199,-1577.04260300,800.91040000,7.93279000,0.00000000,0.00000000,0.00000000); //object(898)
CreateObject(10281,-1581.95520000,528.59362800,24.62894100,-0.04500000,-0.73500000,-4.09199200); //object(898)
CreateObject(10281,-1539.34667969,567.69238281,23.67288399,0.00000000,0.00000000,357.44567871); //object(899)
//====================================================[ CIRCUIT LS ]=========================================================
CreateObject(979,1673.36621094,-1862.77246094,12.07305145,0.41748047,0.00000000,213.44567871); //zakr1-wewnetrzna1
CreateObject(979,1664.61425781,-1866.42382812,12.07305145,0.41748047,0.00000000,191.05017090); //zakr1-wewnetrzna2
CreateObject(979,1683.73632812,-1847.09863281,12.07305145,0.41748047,0.00000000,258.23120117); //zakr1-wewnetrzna3
CreateObject(979,1680.03808594,-1856.09765625,12.07305145,0.41748047,0.00000000,235.83569336); //zakr1-wewnetrzna4
CreateObject(979,1664.08886719,-1876.20214844,12.07305145,0.41748047,0.00000000,9.90808105); //zakr1-zewn1
CreateObject(979,1668.73535156,-1875.30371094,12.07305145,0.41748047,0.00000000,11.90808105); //zakr1-zewn2
CreateObject(979,1693.44335938,-1846.90039062,12.07305145,0.41748047,0.00000000,79.08911133); //zakr1-zewn3
CreateObject(979,1692.61621094,-1851.07617188,12.07305145,0.41748047,0.00000000,79.08911133); //zakr1-zewn4
CreateObject(979,1689.26562500,-1859.40136719,12.07305145,0.41748047,0.00000000,56.69360352); //zakr1-zewn5
CreateObject(979,1686.76269531,-1863.07812500,12.07305145,0.41748047,0.00000000,56.69360352); //zakr1-zewn6
CreateObject(979,1676.61816406,-1871.97851562,12.07305145,0.41748047,0.00000000,34.30358887); //zakr1-zewn7
CreateObject(979,1680.84277344,-1869.15234375,12.07305145,0.41748047,0.00000000,34.30358887); //zakr1-zewn8
CreateObject(1238,1634.03393600,-1877.70520000,12.86505500,0.00000000,0.00000000,-2.15984400); //object(24)
CreateObject(1238,1659.79394500,-1866.58764600,12.85162000,0.00000000,0.00000000,-2.15984400); //object(25)
CreateObject(1238,1682.07495100,-1851.73864700,12.84731900,0.00000000,0.00000000,-1.37444600); //object(26)
CreateObject(1238,1694.79846200,-1826.32019000,12.86009100,0.00000000,0.00000000,-2.15984400); //object(27)
CreateObject(7418,1214.03027344,-1820.39355469,12.58704853,0.00000000,0.00000000,0.00000000); //object(29)
CreateObject(7418,1212.87988281,-1754.06542969,12.59237671,0.00000000,0.00000000,270.42895508); //object(30)
CreateObject(3452,1154.22265625,-1746.16503906,15.17290688,0.00000000,0.00000000,270.42895508); //object(31)
CreateObject(3452,1154.18261719,-1716.63964844,15.16414261,0.00000000,0.00000000,270.42895508); //object(32)
CreateObject(979,1326.68066406,-1857.66796875,12.10781670,0.41748047,0.00000000,351.57849121); //chikane1-s
CreateObject(979,1373.90332031,-1876.36816406,12.10781670,0.41748047,0.00000000,353.57849121); //chikane1-s
CreateObject(979,1344.33203125,-1853.22070312,12.10781670,0.41748047,0.00000000,158.16723633); //chikane1-s
CreateObject(979,1325.32959000,-1847.71508800,12.10781700,0.42000000,0.00000000,-9.56112700); //chikane1-s
CreateObject(979,1356.35449219,-1870.99511719,12.10781670,0.41748047,0.00000000,331.27636719); //chikane1-s
CreateObject(979,1357.05566406,-1860.31835938,12.10781670,0.41748047,0.00000000,150.04089355); //chikane1-s
CreateObject(979,1365.50585938,-1874.71777344,12.10781670,0.41748047,0.00000000,339.32031250); //chikane1-s
CreateObject(979,1374.50781250,-1866.76660156,12.10781670,0.41748047,0.00000000,172.43640137); //chikane1-s
CreateObject(979,1365.30859375,-1864.36718750,12.10781670,0.41748047,0.00000000,158.47888184); //chikane1-s
CreateObject(979,1355.85644531,-1859.74121094,12.10781670,0.41748047,0.00000000,150.05737305); //chikane1-s
CreateObject(979,1347.83203125,-1855.19238281,12.10781670,0.41748047,0.00000000,152.05737305); //chikane1-s
CreateObject(979,1338.43359375,-1850.82031250,12.10781670,0.41748047,0.00000000,158.17822266); //chikane1-s
CreateObject(979,1329.48339844,-1848.29199219,12.10781670,0.41748047,0.00000000,172.43640137); //chikane1-s
CreateObject(979,1371.75598100,-1876.04284700,12.10781700,0.42000000,0.00000000,-6.41953600); //chikane1-s
CreateObject(979,1361.15625000,-1872.94335938,12.10781670,0.41748047,0.00000000,337.33679199); //chikane1-s
CreateObject(979,1351.78027344,-1868.49511719,12.10781670,0.41748047,0.00000000,329.20495605); //chikane1-s
CreateObject(979,1343.68261719,-1863.94531250,12.10781670,0.41748047,0.00000000,331.19946289); //chikane1-s
CreateObject(979,1335.28027344,-1859.91992188,12.10781670,0.41748047,0.00000000,339.33679199); //chikane1-s
CreateObject(1238,1348.20666500,-1854.87585400,12.86505500,0.00000000,0.00000000,-2.15984400); //object(38)
CreateObject(1238,1370.12243700,-1865.53649900,12.86505500,0.00000000,0.00000000,-2.15984400); //object(39)
CreateObject(979,1176.02636719,-1837.64648438,12.10673618,0.41748047,0.00000000,91.28686523); //tunnel1flat
CreateObject(979,1176.02636719,-1726.57128906,12.28173447,0.41748047,359.98352051,91.29785156); //tunnel1flat
CreateObject(979,1176.02636719,-1734.89843750,12.18173504,0.41748047,359.98352051,89.28686523); //tunnel1flat
CreateObject(979,1176.02636719,-1744.22558594,12.10673618,0.41748047,0.00000000,89.28686523); //tunnel1flat
CreateObject(979,1176.02636719,-1753.57421875,12.10673618,0.41748047,0.00000000,91.28686523); //tunnel1flat
CreateObject(979,1176.02636719,-1762.94726562,12.10673618,0.41748047,0.00000000,89.28686523); //tunnel1flat
CreateObject(979,1176.02636719,-1772.29785156,12.10673618,0.41748047,0.00000000,89.28686523); //tunnel1flat
CreateObject(979,1176.02636719,-1781.67187500,12.10673618,0.41748047,0.00000000,91.28686523); //tunnel1flat
CreateObject(979,1176.02636719,-1791.02050781,12.10673618,0.41748047,0.00000000,89.28686523); //tunnel1flat
CreateObject(979,1176.02636719,-1800.39648438,12.10673618,0.41748047,0.00000000,89.28686523); //tunnel1flat
CreateObject(979,1176.02636719,-1809.69726562,12.10673618,0.41748047,0.00000000,89.28686523); //tunnel1flat
CreateObject(979,1176.02636719,-1819.04687500,12.10673618,0.41748047,0.00000000,91.28686523); //tunnel1flat
CreateObject(979,1176.02636719,-1828.29687500,12.10673618,0.41748047,0.00000000,89.28686523); //tunnel1flat
CreateObject(979,1178.88281250,-1837.69433594,12.09917641,0.41748047,0.00000000,270.14477539); //tunnel1-flat2
CreateObject(979,1178.88281250,-1726.66796875,12.24917412,0.41748047,0.01098633,270.14477539); //tunnel1-flat2
CreateObject(979,1178.90722656,-1735.07031250,12.14917564,0.41748047,0.01098633,270.14477539); //tunnel1-flat2
CreateObject(979,1178.88281250,-1744.29589844,12.09917641,0.41748047,0.00000000,270.14477539); //tunnel1-flat2
CreateObject(979,1178.88281250,-1753.69433594,12.09917641,0.41748047,0.00000000,270.14477539); //tunnel1-flat2
CreateObject(979,1178.88281250,-1762.82128906,12.09917641,0.41748047,0.00000000,270.14477539); //tunnel1-flat2
CreateObject(979,1178.88281250,-1772.21972656,12.09917641,0.41748047,0.00000000,270.14477539); //tunnel1-flat2
CreateObject(979,1178.88281250,-1781.49609375,12.09917641,0.41748047,0.00000000,270.14477539); //tunnel1-flat2
CreateObject(979,1178.88281250,-1790.81933594,12.09917641,0.41748047,0.00000000,270.14477539); //tunnel1-flat2
CreateObject(979,1178.88281250,-1800.19531250,12.09917641,0.41748047,0.00000000,270.14477539); //tunnel1-flat2
CreateObject(979,1178.88281250,-1809.56835938,12.09917641,0.41748047,0.00000000,270.14477539); //tunnel1-flat2
CreateObject(979,1178.88281250,-1818.94335938,12.09917641,0.41748047,0.00000000,270.14477539); //tunnel1-flat2
CreateObject(979,1178.88281250,-1828.31933594,12.09917641,0.41748047,0.00000000,270.14477539); //tunnel1-flat2
CreateObject(973,1177.34765625,-1755.79589844,13.41053295,0.00000000,0.00000000,90.42895508); //tunnel1-fence
CreateObject(973,1177.34765625,-1776.16992188,13.41053295,0.00000000,0.00000000,90.42895508); //tunnel1-fence
CreateObject(973,1177.34765625,-1837.64550781,13.41053295,0.00000000,0.00000000,91.28686523); //tunnel1-fence
CreateObject(973,1177.34765625,-1725.87109375,13.41053295,0.00000000,0.00000000,89.28686523); //tunnel1-fence
CreateObject(973,1177.34765625,-1740.84667969,13.41053295,0.00000000,0.00000000,91.28686523); //tunnel1-fence
CreateObject(973,1177.34765625,-1755.77050781,13.41053295,0.00000000,0.00000000,269.28686523); //tunnel1-fence
CreateObject(973,1177.34765625,-1837.62207031,13.41053295,0.00000000,0.00000000,270.42895508); //tunnel1-fence
CreateObject(973,1177.34765625,-1818.54492188,13.41053295,0.00000000,0.00000000,268.42895508); //tunnel1-fence
CreateObject(973,1177.34765625,-1725.89648438,13.41053295,0.00000000,0.00000000,268.42895508); //tunnel1-fence
CreateObject(973,1177.34765625,-1740.84472656,13.41053295,0.00000000,0.00000000,270.42895508); //tunnel1-fence
CreateObject(973,1177.34765625,-1776.17187500,13.41053295,0.00000000,0.00000000,269.28686523); //tunnel1-fence
CreateObject(973,1177.34765625,-1818.59375000,13.41053295,0.00000000,0.00000000,89.28686523); //tunnel1-fence
CreateObject(979,1181.25292969,-1857.12109375,12.11367512,0.41748047,0.00000000,359.71582031); //zakr-1
CreateObject(979,1170.22363281,-1846.81054688,12.11367512,0.41748047,0.00000000,272.14477539); //zakr-3
CreateObject(979,1173.70703125,-1854.36523438,12.13867474,0.41748047,0.00000000,317.00170898); //zakr-2
CreateObject(979,1181.49609400,-1707.39990200,12.17027600,0.42000000,-0.01500000,-9.42477700); //zakr-3
CreateObject(979,1170.19628906,-1717.31933594,12.40308285,0.41748047,0.00000000,266.14477539); //zakr-1
CreateObject(979,1173.60644531,-1710.11132812,12.32043076,0.41748047,359.98352051,221.24938965); //zakr-2
CreateObject(7418,1275.45214844,-1670.36328125,12.54028130,0.00000000,0.00000000,89.56555176); //object(84)
CreateObject(7418,1319.90527344,-1435.01855469,12.35008240,0.00000000,0.00000000,179.13659668); //object(85)
CreateObject(3452,1154.50097656,-1847.99121094,14.97338295,0.00000000,0.00000000,270.42895508); //object(87)
CreateObject(7418,1466.82116700,-1696.00427200,12.37621900,0.00000000,0.00000000,0.00000100); //object(88)
CreateObject(7418,1484.28222656,-1648.83496094,12.33272362,0.00000000,0.00000000,270.42895508); //object(90)
CreateObject(7418,1652.91796875,-1768.54199219,12.37621880,0.00000000,0.00000000,181.13659668); //object(92)
CreateObject(3452,1674.08203125,-1711.06738281,14.98279953,0.00000000,0.00000000,180.85791016); //object(93)
CreateObject(3453,1704.29394531,-1716.53710938,14.96287727,0.00000000,0.00000000,89.56555176); //object(94)
CreateObject(3452,1710.78320312,-1745.86035156,14.93226433,0.00000000,0.00000000,89.28686523); //object(95)
CreateObject(18450,1101.56884800,-1651.93615700,28.17910400,-0.21000000,0.06000000,0.00000000); //object(136)
CreateObject(8406,1175.48767100,-1754.23107900,17.92377900,0.00000000,0.00000000,0.00000000); //object(94)
CreateObject(8406,1175.55065900,-1821.69934100,18.09305200,0.00000000,0.00000000,0.00000000); //object(95)
CreateObject(3336,1271.16552700,-1706.14453100,12.35479000,0.00000000,0.00000000,0.00000000); //object(100)
CreateObject(3715,1304.98645000,-1631.17565900,21.42205200,0.00000000,0.00000000,0.00000000); //object(101)
CreateObject(6958,1226.53039600,-1852.55090300,20.82469200,0.00000000,0.00000000,0.00000000); //object(104)
CreateObject(6958,1377.87512200,-1872.33789100,20.83248100,0.00000000,0.00000000,0.00000000); //object(105)
CreateObject(7610,1186.78991700,-1727.43750000,20.87626600,0.00000000,0.00000000,0.00000000); //object(107)
CreateObject(8644,1177.49377400,-1782.36572300,24.11375600,0.00000000,0.00000000,-1.10309700); //object(108)
CreateObject(10889,1317.58691406,-1634.60253906,13.19644356,2.50000000,0.00000000,0.00000000); //object(109)
CreateObject(10889,1291.95312500,-1634.62109375,13.10735703,2.50000000,0.00000000,180.85791016); //object(110)
CreateObject(10889,1456.89257812,-1867.27539062,12.98234653,2.50000000,0.00000000,89.56555176); //object(111)
CreateObject(10889,1464.93359375,-1877.59375000,12.84014511,2.50000000,0.00000000,270.42895508); //object(112)
CreateObject(7933,1681.29492188,-1740.72167969,13.11548519,0.00000000,0.00000000,130.35107422); //object(114)
CreateObject(1238,1683.45166000,-1776.49340800,12.86505500,0.00000000,0.00000000,-2.15984400); //object(117)
CreateObject(1238,1694.81945800,-1793.68579100,12.86505500,0.00000000,0.00000000,-2.15984400); //object(118)
CreateObject(1238,1694.82177700,-1749.83386200,12.86505500,0.00000000,0.00000000,-2.15984400); //object(119)
CreateObject(1238,1656.98254400,-1726.52282700,12.86505500,0.00000000,0.00000000,-2.15984400); //object(120)
CreateObject(1238,1628.48596200,-1726.52917500,12.86505500,0.00000000,0.00000000,-2.15984400); //object(121)
CreateObject(1238,1571.41931200,-1726.53186000,12.86505500,0.00000000,0.00000000,-2.15984400); //object(122)
CreateObject(1238,1518.18371600,-1724.09204100,12.86505500,0.00000000,0.00000000,-2.15984400); //slopek1
CreateObject(1238,1440.18493700,-1723.16931200,12.86505500,0.00000000,0.00000000,-2.15984400); //slopek1
CreateObject(1238,1445.78479000,-1726.41931200,12.86505500,0.00000000,0.00000000,-2.15984400); //slopek1
CreateObject(1238,1451.68542500,-1726.41931200,12.86505500,0.00000000,0.00000000,-2.15984400); //slopek1
CreateObject(1238,1456.68493700,-1726.41931200,12.86505500,0.00000000,0.00000000,-2.15984400); //slopek1
CreateObject(1238,1461.43493700,-1726.41931200,12.86505500,0.00000000,0.00000000,-2.15984400); //slopek1
CreateObject(1238,1467.33508300,-1726.41931200,12.86505500,0.00000000,0.00000000,-2.15984400); //slopek1
CreateObject(1238,1473.43493700,-1726.41931200,12.86505500,0.00000000,0.00000000,-2.15984400); //slopek1
CreateObject(1238,1479.43493700,-1726.41931200,12.86505500,0.00000000,0.00000000,-2.15984400); //slopek1
CreateObject(1238,1485.26001000,-1726.41931200,12.86505500,0.00000000,0.00000000,-2.15984400); //slopek1
CreateObject(1238,1492.53454600,-1726.41931200,12.86505500,0.00000000,0.00000000,-2.15984400); //slopek1
CreateObject(1238,1498.83361800,-1726.41931200,12.86505500,0.00000000,0.00000000,-2.15984400); //slopek1
CreateObject(1238,1505.28527800,-1726.41931200,12.86505500,0.00000000,0.00000000,-2.15984400); //slopek1
CreateObject(1238,1512.75952100,-1726.41931200,12.86505500,0.00000000,0.00000000,-2.15984400); //slopek1
CreateObject(7418,658.16778600,-1379.80139200,12.39760800,0.00000000,0.00000000,0.00000000); //object(128)
CreateObject(7418,656.98632812,-1357.32714844,12.54411888,0.00000000,0.00000000,270.42895508); //object(129)
CreateObject(7933,1070.95214844,-1289.41601562,13.10749054,0.00000000,0.00000000,223.92211914); //object(133)
CreateObject(1238,1077.90832500,-1287.87597700,12.86505500,0.00000000,0.00000000,-2.15984400); //object(134)
CreateObject(1238,1080.53515600,-1289.17480500,12.86505500,0.00000000,0.00000000,-2.15984400); //object(135)
CreateObject(1238,1069.35754400,-1296.28491200,12.86505500,0.00000000,0.00000000,-2.15984400); //object(136)
CreateObject(1238,1070.26086400,-1299.07177700,12.86505500,0.00000000,0.00000000,-2.15984400); //object(137)
CreateObject(7933,1045.35253906,-1311.93164062,13.10749054,0.00000000,0.00000000,46.78002930); //object(138)
CreateObject(1238,1047.22717300,-1304.96618700,12.86505500,0.00000000,0.00000000,-2.15984400); //object(139)
CreateObject(1238,1047.34045400,-1302.11547900,12.86505500,0.00000000,0.00000000,-2.15984400); //object(140)
CreateObject(1422,1065.91845700,-1270.77978500,12.90946500,0.00000000,0.00000000,0.00000000); //object(142)
CreateObject(1422,1062.87768600,-1270.76757800,13.00207000,0.01500000,0.04500000,0.00000000); //object(143)
CreateObject(1422,1059.94531250,-1270.83593750,13.08469486,0.01098633,0.00000000,0.00000000); //object(146)
CreateObject(1422,1057.07714844,-1271.54882812,13.04910183,0.01098633,359.96704102,24.50537109); //object(147)
CreateObject(1422,1054.61230469,-1272.91406250,12.99646187,0.01098633,359.96704102,32.50537109); //object(148)
CreateObject(1422,1052.54101562,-1274.78906250,12.90747070,0.00000000,359.96704102,54.97778320); //object(149)
CreateObject(1422,1050.84472656,-1277.25976562,12.80430698,0.00000000,359.96704102,58.97778320); //object(150)
CreateObject(1238,1047.42309600,-1296.24243200,12.86505500,0.00000000,0.00000000,-2.15984400); //object(151)
CreateObject(1238,1047.43054200,-1293.16796900,12.86505500,0.00000000,0.00000000,-2.15984400); //object(152)
CreateObject(1238,1047.48901400,-1290.34008800,12.86505500,0.00000000,0.00000000,-2.15984400); //object(153)
CreateObject(1238,1047.54736300,-1287.32934600,12.86505500,0.00000000,0.00000000,-2.15984400); //object(154)
CreateObject(1238,1047.59741200,-1284.45153800,12.86505500,0.00000000,0.00000000,-2.15984400); //object(155)
CreateObject(1238,1070.21814000,-1270.78149400,12.86505500,0.00000000,0.00000000,-2.15984400); //object(156)
CreateObject(981,1058.05761719,-1265.60253906,13.66207218,0.00000000,0.00000000,358.85791016); //object(159)
CreateObject(1238,1049.57153300,-1279.36193800,12.75292000,0.00000000,0.00000000,-2.15984400); //object(160)
CreateObject(1422,1050.37500000,-1336.82556200,12.74334400,0.00000000,0.00000000,0.00000000); //object(162)
CreateObject(1422,1053.22424300,-1336.84387200,12.74334500,0.00000000,0.00000000,0.00000000); //object(163)
CreateObject(1422,1056.08325200,-1336.80725100,12.74334400,0.00000000,0.00000000,0.00000000); //object(164)
CreateObject(1422,1058.87109375,-1336.23632812,12.74334431,0.00000000,0.00000000,18.39001465); //object(165)
CreateObject(1422,1061.46972656,-1335.15332031,12.74334431,0.00000000,0.00000000,22.39001465); //object(166)
CreateObject(1422,1063.83496094,-1333.57714844,12.74334431,0.00000000,0.00000000,42.78002930); //object(167)
CreateObject(1422,1065.82421875,-1331.53027344,12.74334431,0.00000000,0.00000000,46.78002930); //object(168)
CreateObject(1238,1046.21777300,-1336.75427200,12.87289800,0.00000000,0.00000000,-2.15984400); //object(169)
CreateObject(1238,1068.53405800,-1327.34692400,12.86505500,0.00000000,0.00000000,-2.15984400); //object(175)
CreateObject(1238,1070.98181200,-1324.38903800,12.86505500,0.00000000,0.00000000,-2.15984400); //object(177)
CreateObject(1238,1021.43774400,-1337.03613300,12.85926900,0.00000000,0.00000000,-2.15984400); //object(182)
CreateObject(1238,1019.05444300,-1335.66870100,12.86683500,0.00000000,0.00000000,-2.15984400); //object(183)
CreateObject(1238,1019.37927200,-1333.11792000,12.86683500,0.00000000,0.00000000,-2.15984400); //object(184)
CreateObject(1422,1041.87023900,-1336.97937000,13.13709400,0.00000000,0.00000000,0.00000000); //object(185)
CreateObject(1422,1038.99682600,-1336.96972700,13.13709400,0.00000000,0.00000000,0.00000000); //object(186)
CreateObject(1422,1036.02038600,-1336.96740700,13.13709400,0.00000000,0.00000000,0.00000000); //object(187)
CreateObject(1422,1033.18322800,-1336.94506800,13.13709400,0.00000000,0.00000000,0.00000000); //object(188)
CreateObject(1422,1030.30737300,-1336.97180200,13.13709400,0.00000000,0.00000000,0.00000000); //object(189)
CreateObject(1422,1027.41796900,-1337.01123000,13.13709400,0.00000000,0.00000000,0.00000000); //object(190)
CreateObject(1422,1024.58105500,-1337.01025400,13.13709400,0.00000000,0.00000000,0.00000000); //object(192)
CreateObject(7418,1417.45507812,-1274.37500000,12.37621689,0.00000000,0.00000000,181.13659668); //object(174)
CreateObject(7418,1492.28222700,-1404.52209500,12.38401800,0.00000000,0.00000000,0.00000300); //object(175)
CreateObject(1237,1348.00610400,-1447.95776400,12.54975600,0.00000000,0.00000000,0.00000000); //object(176)
CreateObject(1237,1341.34057600,-1476.59692400,12.54975600,0.00000000,0.00000000,0.00000000); //object(177)
CreateObject(1237,1329.70776400,-1498.64379900,12.54975600,0.00000000,0.00000000,0.00000000); //object(178)
CreateObject(1237,1316.66418500,-1519.28198200,12.54975600,0.00000000,0.00000000,0.00000000); //object(179)
CreateObject(1237,1308.33349600,-1539.34899900,12.54975600,0.00000000,0.00000000,0.00000000); //object(180)
CreateObject(1237,1306.09375000,-1553.99523900,12.54975600,0.00000000,0.00000000,0.00000000); //object(181)
CreateObject(1237,1305.00915500,-1685.59582500,12.54975600,0.00000000,0.00000000,0.00000000); //object(182)
CreateObject(1237,1304.99829100,-1702.32226600,12.54975600,0.00000000,0.00000000,0.00000000); //object(183)
CreateObject(1237,1177.30004900,-1721.30725100,12.76957900,0.00000000,0.00000000,0.00000000); //object(184)
CreateObject(1237,1177.38305700,-1842.41015600,12.56412500,0.00000000,0.00000000,0.00000000); //object(185)
CreateObject(7418,1621.64550781,-1554.82519531,12.39369678,0.00000000,0.00000000,87.56555176); //object(186)
CreateObject(7418,1620.42871094,-1470.19238281,12.37478828,0.00000000,0.00000000,181.13659668); //object(187)
CreateObject(7933,1334.33105469,-1414.10742188,13.11664295,0.00000000,0.00000000,136.35107422); //object(188)
CreateObject(7933,1289.12890625,-1703.86328125,13.10749054,0.00000000,0.00000000,42.78002930); //object(189)
CreateObject(7933,1188.29785156,-1720.49121094,13.10749054,0.00000000,0.00000000,223.92211914); //object(190)
CreateObject(7933,1649.63769531,-1449.15429688,13.10749054,0.00000000,0.00000000,134.35107422); //object(191)
CreateObject(7933,1463.11718750,-1432.55859375,13.10749054,0.00000000,0.00000000,315.49316406); //object(192)
CreateObject(7933,1446.49804688,-1249.07519531,13.10749054,0.00000000,0.00000000,136.35107422); //object(193)
CreateObject(1237,1193.10693400,-1846.63110400,12.56572700,0.00000000,0.00000000,0.00000000); //object(194)
CreateObject(1237,1424.07836900,-1605.81079100,12.54975600,0.00000000,0.00000000,0.00000000); //object(198)
CreateObject(1237,1350.98791500,-1251.24340800,12.39980400,0.00000000,0.00000000,0.00000000); //object(199)
CreateObject(1237,1349.28967300,-1251.25231900,12.39316800,0.00000000,0.00000000,0.00000000); //object(200)
CreateObject(1237,1349.28698700,-1270.40246600,12.38569400,0.00000000,0.00000000,0.00000000); //object(201)
CreateObject(1237,1350.97192400,-1270.41833500,12.38569400,0.00000000,0.00000000,0.00000000); //object(202)
CreateObject(1237,1351.11071800,-1291.22070300,12.38569400,0.00000000,0.00000000,0.00000000); //object(203)
CreateObject(1237,1349.18481400,-1291.23791500,12.38569400,0.00000000,0.00000000,0.00000000); //object(204)
CreateObject(981,1352.37109375,-1293.78417969,13.12075329,0.00000000,0.00000000,359.71582031); //object(205)
CreateObject(981,1352.78320312,-1229.64941406,13.09530735,0.00000000,0.00000000,0.57373047); //object(206)
CreateObject(3452,1378.94921875,-1400.92968750,14.93224335,0.00000000,0.00000000,89.28686523); //object(207)
CreateObject(3452,1678.36718750,-1438.49511719,14.90723038,0.00000000,0.00000000,91.28686523); //object(212)
CreateObject(979,1062.95507812,-1271.28906250,12.31052971,0.41748047,359.95056152,178.57373047); //object(209)
CreateObject(979,1056.13964844,-1272.51171875,12.39882660,0.41748047,0.02746582,205.07360840); //object(210)
CreateObject(979,1051.95898438,-1276.44433594,12.24602318,0.41748047,0.02746582,235.52404785); //object(211)
CreateObject(10889,859.55761719,-1315.06054688,13.04644585,2.50000000,0.00000000,89.28686523); //object(213)
CreateObject(10889,857.62792969,-1332.40820312,13.11814308,2.50000000,0.00000000,270.14477539); //object(214)
CreateObject(1422,780.13769500,-1330.35681200,12.95740600,0.00000000,0.00000000,0.00000000); //object(215)
CreateObject(1422,777.08142100,-1330.30529800,12.95740600,0.00000000,0.00000000,0.00000000); //object(216)
CreateObject(1422,774.00659200,-1330.28027300,12.95740600,0.00000000,0.00000000,0.00000000); //object(217)
CreateObject(979,1362.17871094,-1420.58105469,12.09805012,0.41748047,0.00000000,86.94226074); //object(218)
CreateObject(979,1361.61230469,-1429.91894531,12.09805012,0.41748047,0.00000000,84.94226074); //object(219)
CreateObject(979,1292.64550781,-1697.56640625,12.07304955,0.41748047,0.00000000,270.14477539); //object(220)
CreateObject(979,1327.93945312,-1410.64453125,12.06814003,0.41748047,0.00000000,359.14746094); //object(230)
CreateObject(979,1337.50292969,-1420.58886719,12.07304955,0.41748047,0.00000000,265.49951172); //object(231)
CreateObject(979,1684.72851562,-1747.13574219,12.08952427,0.41748047,0.00000000,269.57641602); //object(232)
CreateObject(979,1674.86621094,-1737.13574219,12.07304955,0.41748047,0.00000000,359.14746094); //object(233)
CreateObject(979,1653.12207031,-1455.54785156,12.07364273,0.41748047,0.00000000,270.44519043); //object(244)
CreateObject(979,1643.25683594,-1445.64941406,12.09805012,0.41748047,0.00000000,0.01623535); //object(245)
CreateObject(979,1469.42773438,-1436.00390625,12.07304955,0.41748047,0.00000000,180.58996582); //object(248)
CreateObject(979,1459.58398438,-1426.16210938,12.07304955,0.41748047,0.00000000,91.01892090); //object(250)
CreateObject(979,1362.48730469,-1255.44042969,12.10557079,0.41748047,0.00000000,91.01892090); //plotek1
CreateObject(979,1337.79785156,-1266.16601562,12.09805012,0.41748047,0.00000000,270.16101074); //plotek2
CreateObject(979,1362.48730469,-1274.06542969,12.10557079,0.41748047,0.00000000,91.01892090); //plotek1
CreateObject(979,1362.48730469,-1264.74023438,12.10557079,0.41748047,0.00000000,89.01892090); //plotek1
CreateObject(979,1337.79785156,-1247.41699219,12.09805012,0.41748047,0.00000000,270.16101074); //plotek2
CreateObject(979,1337.79785156,-1256.79199219,12.09805012,0.41748047,0.00000000,270.16101074); //plotek2
CreateObject(979,1038.89746094,-1332.19433594,12.10369778,0.41748047,0.00000000,359.44787598); //plotek3
CreateObject(979,651.93261719,-1314.71875000,12.10622978,0.41748047,0.01098633,178.58996582); //object(262)
CreateObject(979,1029.59765625,-1332.19433594,12.10369778,0.41748047,0.00000000,359.44787598); //plotek3
CreateObject(979,622.86718750,-1334.00585938,12.11284256,0.41748047,0.00000000,269.87683105); //plotek4
CreateObject(979,622.84277344,-1343.33203125,12.11284256,0.41748047,0.00000000,269.87683105); //plotek4
CreateObject(979,652.29589844,-1410.52050781,12.07808113,0.41748047,0.00000000,1.14746094); //plotek5
CreateObject(979,783.29882812,-1410.52050781,12.07808113,0.41748047,0.00000000,359.14746094); //plotek5
CreateObject(979,658.24877900,-1410.52063000,11.92808300,0.42000000,0.00000000,-18.84955200); //plotek5
CreateObject(979,773.92089844,-1410.52050781,12.07808113,0.41748047,0.00000000,1.14746094); //plotek5
CreateObject(979,764.57128906,-1410.52050781,12.07808113,0.41748047,0.00000000,359.14746094); //plotek5
CreateObject(979,745.87500000,-1410.52050781,12.07808113,0.41748047,0.00000000,1.14746094); //plotek5
CreateObject(979,755.24609375,-1410.52050781,12.07808113,0.41748047,0.00000000,359.14746094); //plotek5
CreateObject(979,736.50000000,-1410.52050781,12.07808113,0.41748047,0.00000000,359.14746094); //plotek5
CreateObject(979,717.79882812,-1410.52050781,12.07808113,0.41748047,0.00000000,1.14746094); //plotek5
CreateObject(979,727.17285156,-1410.52050781,12.07808113,0.41748047,0.00000000,359.14746094); //plotek5
CreateObject(979,708.42285156,-1410.52050781,12.07808113,0.41748047,0.00000000,359.14746094); //plotek5
CreateObject(979,699.07519531,-1410.52050781,12.07808113,0.41748047,0.00000000,359.14746094); //plotek5
CreateObject(979,689.69921875,-1410.52050781,12.07808113,0.41748047,0.00000000,1.14746094); //plotek5
CreateObject(979,680.32421875,-1410.52050781,12.07808113,0.41748047,0.00000000,359.14746094); //plotek5
CreateObject(979,670.95214844,-1410.52050781,12.07808113,0.41748047,0.00000000,1.14746094); //plotek5
CreateObject(979,661.62402344,-1410.52050781,12.07808113,0.41748047,0.00000000,359.14746094); //plotek5
CreateObject(979,1282.78515625,-1707.39355469,12.09805012,0.41748047,0.00000000,180.57373047); //object(285)
CreateObject(10889,977.97753906,-1405.76855469,12.60929203,2.50000000,0.00000000,270.14477539); //object(286)
CreateObject(973,1038.93359375,-1412.94628906,13.21796417,0.00000000,0.00000000,0.39001465); //object(288)
CreateObject(973,927.04821800,-1415.17053200,13.22652400,0.00000000,0.00000000,0.00000000); //object(289)
CreateObject(1237,922.07940700,-1415.32507300,12.22105800,0.00000000,0.00000000,0.00000000); //object(290)
CreateObject(1237,1043.83544900,-1411.35144000,12.45367800,0.00000000,0.00000000,0.00000000); //object(293)
CreateObject(10889,978.47851562,-1390.55957031,12.57143211,2.50000000,0.00000000,89.00268555); //object(294)
CreateObject(981,1255.12792969,-1383.05761719,12.97477055,0.00000000,0.00000000,358.57373047); //object(295)
CreateObject(981,1200.77539062,-1384.04687500,13.02721214,0.00000000,0.00000000,0.57373047); //object(296)
CreateObject(1411,931.84143100,-1405.62048300,13.63859400,0.00000000,0.00000000,0.00000000); //fence-drut
CreateObject(1411,937.14074700,-1405.62048300,13.63859400,0.00000000,0.00000000,0.00000000); //fence-drut
CreateObject(1411,942.41626000,-1405.62048300,13.63859400,0.00000000,0.00000000,0.00000000); //fence-drut
CreateObject(1411,947.71606400,-1405.62048300,13.63859400,0.00000000,0.00000000,0.00000000); //fence-drut
CreateObject(1411,952.96582000,-1405.62048300,13.63859400,0.00000000,0.00000000,0.00000000); //fence-drut
CreateObject(1411,958.24182100,-1405.62048300,13.63859400,0.00000000,0.00000000,0.00000000); //fence-drut
CreateObject(1411,963.51586900,-1405.62048300,13.63859400,0.00000000,0.00000000,0.00000000); //fence-drut
CreateObject(1411,968.79003906,-1405.62011719,13.63859367,0.00000000,0.00000000,0.00000000); //fence-drut
CreateObject(1411,974.11621100,-1405.62048300,13.63859400,0.00000000,0.00000000,0.00000000); //fence-drut
CreateObject(1411,979.39245600,-1405.62048300,13.63859400,0.00000000,0.00000000,0.00000000); //fence-drut
CreateObject(1411,984.64245600,-1405.62048300,13.63859400,0.00000000,0.00000000,0.00000000); //fence-drut
CreateObject(1411,989.94177200,-1405.62048300,13.63859400,0.00000000,0.00000000,0.00000000); //fence-drut
CreateObject(1411,995.19104000,-1405.62048300,13.63859400,0.00000000,0.00000000,0.00000000); //fence-drut
CreateObject(1411,1000.49133300,-1405.62048300,13.63859400,0.00000000,0.00000000,0.00000000); //fence-drut
CreateObject(1411,1005.86572300,-1405.62048300,13.63859400,0.00000000,0.00000000,0.00000000); //fence-drut
CreateObject(1411,1011.14025900,-1405.62048300,13.63859400,0.00000000,0.00000000,0.00000000); //fence-drut
CreateObject(1411,1016.41674800,-1405.62048300,13.63859400,0.00000000,0.00000000,0.00000000); //fence-drut
CreateObject(1411,1021.69055200,-1405.62048300,13.63859400,0.00000000,0.00000000,0.00000000); //fence-drut
CreateObject(4199,1012.49121094,-1421.21484375,14.29093170,0.00000000,0.00000000,89.56555176); //object(279)
CreateObject(4199,980.93164062,-1421.21484375,14.33799839,0.00000000,0.00000000,91.56555176); //object(280)
CreateObject(8947,960.95770300,-1428.47326700,14.54967100,0.00000000,0.00000000,-3.14159300); //object(282)
CreateObject(10282,960.69390900,-1435.07067900,13.55899000,0.00000000,0.00000000,-3.14159300); //object(283)
CreateObject(11391,963.74987800,-1421.97644000,13.83662200,0.00000000,0.00000000,-3.14159300); //object(284)
CreateObject(11392,959.98687700,-1423.80139200,12.56688900,0.00000000,0.00000000,1.96349500); //object(285)
CreateObject(11393,1030.82470700,-1415.51098600,13.76853200,0.00000000,0.00000000,0.00000000); //object(288)
CreateObject(14826,956.22393800,-1421.58496100,13.31125400,0.00000000,0.00000000,-1.37444700); //object(289)
CreateObject(14826,1020.06909200,-1415.88720700,12.96102200,0.00000000,0.00000000,-0.19500000); //object(290)
CreateObject(14826,1005.79266400,-1416.06726100,12.95083600,0.00000000,0.00000000,-0.22500000); //object(291)
CreateObject(14826,988.23938000,-1415.98120100,12.98810000,0.00000000,0.00000000,-0.22500000); //object(292)
CreateObject(14826,973.02197300,-1416.03002900,13.01729600,0.00000000,0.00000000,-0.22500000); //object(293)
CreateObject(11393,996.62188700,-1415.03100600,13.71801600,0.00000000,0.00000000,0.00000000); //object(295)
CreateObject(13011,952.91394000,-1423.92688000,14.25515700,0.00000000,0.00000000,0.00000000); //object(299)
CreateObject(4882,1246.27990700,-1712.17883300,17.62474400,0.00000000,0.00000000,0.00000000); //object(300)
CreateObject(3515,1231.60437000,-1374.22680700,12.44526200,0.00000000,0.00000000,0.00000000); //object(302)
CreateObject(3515,1231.62963900,-1306.32971200,12.37729700,0.00000000,0.00000000,0.00000000); //object(303)
CreateObject(3515,1199.32043500,-1731.14502000,13.29667500,0.00000000,0.00000000,0.00000000); //object(304)
CreateObject(7073,608.50872800,-1379.48840300,40.85268800,0.00000000,0.00000000,0.19635000); //object(308)
CreateObject(7388,784.75305200,-1333.35009800,12.30121200,0.00000000,0.00000000,0.00000000); //object(309)
CreateObject(7392,1153.35144000,-1773.50415000,27.06409100,0.00000000,0.00000000,1.57079900); //object(310)
CreateObject(9833,1478.38464400,-1640.94238300,16.64424700,0.00000000,0.00000000,0.00000000); //object(312)
CreateObject(11417,951.85907000,-1416.52319300,17.57697700,0.00000000,0.00000000,-5.49778800); //object(313)
CreateObject(13562,1302.50122100,-1416.94567900,15.18248600,0.00000000,0.00000000,3.14159300); //object(314)
CreateObject(13667,1220.23315400,-1413.90136700,36.47386600,0.00000000,0.00000000,1.75214600); //object(315)
CreateObject(16776,980.40411400,-1377.32043500,20.33212500,0.00000000,0.00000000,-6.28318600); //object(318)
CreateObject(16778,1260.41027800,-1418.09216300,14.02149200,0.00000000,0.00000000,0.00000000); //object(319)
CreateObject(1238,919.39691200,-1414.23535200,12.53316500,0.00000000,0.00000000,0.00000000); //object(320)
CreateObject(1238,916.21368400,-1412.46667500,12.54073300,0.00000000,0.00000000,0.00000000); //object(321)
CreateObject(1238,911.13690200,-1410.77661100,12.54488000,0.00000000,0.00000000,0.00000000); //object(322)
CreateObject(1262,1043.73254400,-1399.12719700,17.76427700,0.00000000,0.00000000,1.57079600); //swiatla
CreateObject(1262,1043.73254400,-1398.65173300,17.76427700,0.00000000,0.00000000,1.57079600); //swiatla
CreateObject(1262,1043.73254400,-1400.07812500,17.76427700,0.00000000,0.00000000,1.57079600); //swiatla
CreateObject(1262,1043.73254400,-1399.60266100,17.76427700,0.00000000,0.00000000,1.57079600); //swiatla
CreateObject(8406,905.98602300,-1403.22509800,17.70719500,0.00000000,0.00000000,1.57079600); //object(321)
CreateObject(9188,1388.25219700,-1401.06457500,21.50796900,0.00000000,0.00000000,-1.57079600); //object(324)
CreateObject(9190,1145.38745100,-1848.16503900,22.21755200,0.00000000,0.00000000,-4.71238900); //object(325)
CreateObject(10281,1177.54406700,-1810.56311000,22.43339200,0.00000000,0.00000000,0.00000000); //object(327)
CreateObject(7306,1145.19995117,-1731.40002441,22.29999924,0.00000000,0.00000000,134.07238770); //object(330)
CreateObject(7901,1688.02111800,-1701.63818400,22.25301600,0.00000000,0.00000000,0.00000000); //object(332)
CreateObject(7906,1720.10754400,-1732.25744600,22.26971600,0.00000000,0.00000000,-1.57079600); //object(333)
CreateObject(7907,1711.44641100,-1709.97412100,22.55454100,0.00000000,0.00000000,-0.78539800); //object(334)
CreateObject(8406,1687.11938500,-1765.14184600,17.91184200,0.00000000,0.00000000,-0.07634900); //object(336)
CreateObject(8406,1562.58398438,-1735.07226562,17.90815353,0.00000000,0.00000000,89.56555176); //object(337)
CreateObject(8406,1434.16980000,-1549.53015100,17.89181100,0.00000000,0.00000000,2.94524300); //object(338)
CreateObject(8406,1274.08886719,-1283.36523438,17.81839371,0.00000000,0.00000000,89.56555176); //object(340)
CreateObject(8406,1018.07324219,-1324.76171875,17.81701279,0.00000000,0.00000000,89.56555176); //object(341)
CreateObject(16093,970.06475800,-1421.27038600,22.03823700,0.00000000,0.00000000,-3.14159300); //object(342)
CreateObject(13011,963.88977100,-1424.35595700,18.63650700,0.00000000,0.00000000,0.00000000); //object(343)
CreateObject(8673,1092.58740200,-1385.33789100,14.25471000,0.00000000,0.00000000,0.00000000); //object(344)
CreateObject(8673,1112.95922900,-1385.35791000,14.25471000,0.00000000,0.00000000,0.00000000); //object(345)
CreateObject(8673,1135.74206500,-1415.81481900,14.10283100,0.00000000,0.00000000,0.00000000); //object(346)
CreateObject(8673,1115.24194300,-1415.99865700,14.02574800,0.00000000,0.00000000,0.00000000); //object(347)
CreateObject(8673,1226.80810500,-1384.77648900,14.06821300,0.00000000,0.00000000,0.00000000); //object(348)
CreateObject(8673,1568.26660156,-1883.16699219,14.02417946,0.00000000,0.00000000,0.00000000); //object(350)
CreateObject(3566,1663.19335938,-1898.70996094,14.93549728,0.00000000,0.00000000,268.14477539); //object(352)
CreateObject(3568,1639.82421875,-1900.04492188,14.93549728,0.00000000,0.00000000,270.42895508); //object(353)
CreateObject(3569,1639.78320312,-1904.78906250,14.94072533,0.00000000,0.00000000,270.42895508); //object(354)
CreateObject(8673,1673.75000000,-1892.38476562,22.42106628,0.00000000,0.00000000,269.56555176); //object(355)
CreateObject(8673,1684.31347656,-1892.40429688,22.42106628,0.00000000,0.00000000,269.56555176); //object(356)
CreateObject(8673,1684.30273438,-1912.87207031,22.42106628,0.00000000,0.00000000,89.56555176); //object(357)
CreateObject(8673,1677.24902344,-1930.33203125,22.42106628,0.00000000,0.00000000,44.78002930); //object(358)
CreateObject(8674,1679.10839800,-1882.41882300,22.42106600,0.00000000,0.00000000,0.00000000); //object(359)
CreateObject(3819,1679.25097656,-1885.71484375,21.95191002,0.00000000,0.00000000,270.42895508); //object(360)
CreateObject(3819,1679.26953125,-1890.55175781,23.17690277,0.00000000,0.00000000,270.42895508); //object(361)
CreateObject(3406,1678.92675781,-1893.92382812,21.24989510,358.42346191,0.00000000,181.13659668); //object(362)
CreateObject(8674,1701.38391100,-1828.55883800,14.00599800,0.00000000,0.00000000,1.57079600); //object(363)
CreateObject(1238,1681.77356000,-1748.83728000,12.86386500,0.00000000,0.00000000,-2.15984400); //object(364)
CreateObject(1238,1680.59387200,-1753.68176300,12.86216900,0.00000000,0.00000000,-2.15984400); //object(365)
CreateObject(1238,1672.11193800,-1739.79870600,12.86517400,0.00000000,0.00000000,-2.15984400); //object(367)
CreateObject(1238,1667.62890600,-1740.77063000,12.86366900,0.00000000,0.00000000,-2.15984400); //object(368)
CreateObject(8673,1660.24707031,-1742.42675781,14.01168537,0.00000000,0.00000000,0.00000000); //object(369)
CreateObject(8673,1639.82373000,-1742.42956500,14.01379000,0.00000000,0.00000000,0.00000000); //object(370)
CreateObject(8673,1679.59765625,-1754.82519531,14.01297283,0.00000000,0.00000000,270.42895508); //object(371)
CreateObject(1238,1680.22741700,-1759.17517100,12.86099300,0.00000000,0.00000000,-2.15984400); //object(372)
CreateObject(8674,1674.42285156,-1744.38183594,14.01830864,0.00000000,0.00000000,0.00000000); //object(373)
CreateObject(3819,1675.06738281,-1758.21093750,13.53790665,0.00000000,0.00000000,180.85791016); //object(374)
CreateObject(3819,1675.05273438,-1749.61523438,13.54279900,0.00000000,0.00000000,180.85791016); //object(375)
CreateObject(1571,1666.01477100,-1757.83801300,13.87096400,0.00000000,0.00000000,0.00000000); //object(376)
CreateObject(1341,1632.79101600,-1747.18017600,13.54273500,0.00000000,0.00000000,0.00000000); //object(377)
CreateObject(8673,1691.27929688,-1877.45117188,14.00049305,0.00000000,0.00000000,30.57128906); //object(379)
CreateObject(8674,1703.91467300,-1869.13427700,14.03683700,0.00000000,0.00000000,-1.57079600); //object(380)
CreateObject(8673,1714.36511200,-1863.96350100,14.03416300,0.00000000,0.00000000,0.00000000); //object(382)
CreateObject(1238,1700.33313000,-1860.75195300,12.88815000,0.00000000,0.00000000,-2.15984400); //object(383)
CreateObject(1238,1700.23083500,-1864.37829600,12.87895600,0.00000000,0.00000000,-2.15984400); //object(384)
CreateObject(1238,1699.95666500,-1868.27404800,12.87932600,0.00000000,0.00000000,-2.15984400); //object(385)
CreateObject(1238,1696.45019500,-1871.51953100,12.86776500,0.00000000,0.00000000,-2.15984400); //object(386)
CreateObject(1238,1692.38037100,-1874.20800800,12.85799000,0.00000000,0.00000000,-2.15984400); //object(387)
CreateObject(1238,1688.53820800,-1876.47143600,12.85218500,0.00000000,0.00000000,-2.15984400); //object(388)
CreateObject(1238,1683.91174300,-1879.08435100,12.86580300,0.00000000,0.00000000,-2.15984400); //object(389)
CreateObject(1238,1678.70593300,-1881.10681200,12.86888000,0.00000000,0.00000000,-2.15984400); //object(390)
CreateObject(1422,1652.61535600,-1899.47180200,12.96263500,0.00000000,0.00000000,0.00000000); //object(391)
CreateObject(1422,1649.23425300,-1899.56933600,12.96263500,0.00000000,0.00000000,0.00000000); //object(392)
CreateObject(1422,1701.03674300,-1836.62060500,12.95635900,0.00000000,0.00000000,-1.57079600); //object(393)
CreateObject(1422,1701.02600100,-1840.01733400,12.95387600,0.00000000,0.00000000,-1.57079600); //object(394)
CreateObject(1238,1435.04931600,-1702.58569300,12.86505400,0.00000000,0.00000000,-2.15984400); //object(397)
CreateObject(1238,1434.89685100,-1708.00817900,12.86505400,0.00000000,0.00000000,-2.15984400); //object(398)
CreateObject(1238,1434.88037100,-1713.70813000,12.86505400,0.00000000,0.00000000,-2.15984400); //object(399)
CreateObject(1422,1437.47583000,-1581.88012700,12.95740600,0.00000000,0.00000000,0.00000000); //object(400)
CreateObject(1422,1433.10095200,-1582.15271000,12.77845700,0.00000000,0.00000000,0.00000000); //object(401)
CreateObject(1422,1429.52539100,-1581.97876000,12.78533700,0.00000000,0.00000000,0.00000000); //object(402)
CreateObject(1422,1426.00036600,-1581.97949200,12.77824500,0.00000000,0.00000000,0.00000000); //object(403)
CreateObject(1422,1422.22558594,-1581.97851562,12.95740604,0.00000000,0.00000000,0.00000000); //object(404)
CreateObject(1422,1419.16308594,-1584.69824219,12.95443916,0.00000000,0.00000000,69.56555176); //object(405)
CreateObject(1422,1419.02148438,-1588.76269531,12.77771854,0.00000000,0.00000000,89.56555176); //object(406)
CreateObject(1422,1419.04101562,-1592.34570312,12.77820206,0.00000000,0.00000000,89.56555176); //object(407)
CreateObject(1422,1419.01660156,-1595.79687500,12.77820206,0.00000000,0.00000000,91.56555176); //object(408)
CreateObject(1422,1418.97851562,-1600.03320312,12.95740604,0.00000000,0.00000000,87.56555176); //object(409)
CreateObject(1238,1524.09912100,-1721.09704600,12.86505500,0.00000000,0.00000000,-2.15984400); //object(410)
CreateObject(1238,1529.57727100,-1719.25512700,12.70099300,0.00000000,0.00000000,-2.15984400); //object(411)
CreateObject(1238,1535.61315900,-1717.26977500,12.86505500,0.00000000,0.00000000,-2.15984400); //object(412)
CreateObject(7520,1254.24414062,-1821.95312500,12.66119766,0.00000000,0.00000000,0.00000000); //object(391)
CreateObject(1238,1283.30407700,-1294.17370600,12.67778600,0.00000000,0.00000000,-2.15984400); //object(393)
CreateObject(1238,1276.87817400,-1294.22424300,12.67778700,0.00000000,0.00000000,-2.15984400); //object(394)
CreateObject(1238,1280.15918000,-1294.18151900,12.67562300,0.00000000,0.00000000,-2.15984400); //object(395)
CreateObject(10889,1129.90136719,-1389.94238281,13.09189701,2.50000000,0.00000000,91.00268555); //object(394)
CreateObject(1237,1184.75781300,-1411.74694800,12.40340900,0.00000000,0.00000000,0.00000000); //object(395)
CreateObject(1237,1244.02160600,-1411.36901900,12.22841600,0.00000000,0.00000000,0.00000000); //object(396)
CreateObject(1237,1216.54748500,-1389.83776900,12.48912000,0.00000000,0.00000000,0.00000000); //object(397)
CreateObject(1237,1245.52026400,-1389.76635700,12.38703700,0.00000000,0.00000000,0.00000000); //object(398)
CreateObject(1237,807.98352100,-1411.39025900,12.56502900,0.00000000,0.00000000,0.00000000); //object(399)
CreateObject(973,1291.68554688,-1692.28222656,13.28709698,0.00000000,0.00000000,266.14477539); //object(400)
CreateObject(973,1277.84375000,-1706.29199219,13.38709545,0.00000000,0.00000000,180.57373047); //object(401)
CreateObject(8673,1217.89880400,-1722.24768100,14.01379100,0.00000000,0.00000000,0.00000000); //object(402)
CreateObject(1238,1195.26550300,-1719.68322800,12.86505500,0.00000000,0.00000000,-2.15984400); //object(403)
CreateObject(1238,1197.74572800,-1721.67858900,12.86505500,0.00000000,0.00000000,-2.15984400); //object(404)
CreateObject(1238,1187.52136200,-1727.28454600,12.87599700,0.00000000,0.00000000,-2.15984400); //object(405)
CreateObject(1238,1189.61413600,-1729.57727100,12.87885700,0.00000000,0.00000000,-2.15984400); //object(406)
CreateObject(8674,1195.14062500,-1842.26171875,14.03722858,0.00000000,0.00000000,356.85791016); //object(407)
CreateObject(8673,1190.01367188,-1832.30761719,14.03722858,0.00000000,0.00000000,270.42895508); //object(408)
CreateObject(8673,1234.70251500,-1842.27099600,14.01184700,0.00000000,0.00000000,0.00000000); //object(409)
CreateObject(8673,1249.53564500,-1842.25817900,14.01332200,0.00000000,0.00000000,0.00000000); //object(410)
CreateObject(981,1304.93066406,-1841.17871094,13.30930042,0.00000000,0.00000000,0.57373047); //object(411)
CreateObject(1422,1537.63696300,-1882.40808100,12.81774600,0.00000000,0.00000000,-3.14159300); //object(414)
CreateObject(1422,1533.18896500,-1882.48474100,12.79334400,0.00000000,0.00000000,-3.14159300); //object(415)
CreateObject(1422,1529.95031700,-1882.46057100,12.79334400,0.00000000,0.00000000,-3.14159300); //object(416)
CreateObject(1422,1526.50122100,-1882.45874000,12.79334400,0.00000000,0.00000000,-3.14159300); //object(417)
CreateObject(1422,1522.45141600,-1882.26367200,12.95740600,0.00000000,0.00000000,-3.14159300); //object(418)
CreateObject(10889,1564.53723100,-1800.76623500,13.08238000,0.04500000,0.00000000,-3.14159300); //object(419)
CreateObject(3819,1557.35229500,-1803.42602500,13.54463300,0.00000000,0.00000000,-3.14159300); //object(420)
CreateObject(3819,1557.40014600,-1790.72680700,13.54463300,0.00000000,0.00000000,-3.14159300); //object(421)
CreateObject(3819,1557.41528300,-1777.31286600,13.54463300,0.00000000,0.00000000,-3.14159300); //object(422)
CreateObject(1422,1389.28503400,-1861.98791500,12.79334400,0.00000000,0.00000000,-3.14159300); //object(423)
CreateObject(1422,1385.64343300,-1861.99548300,12.79334400,0.00000000,0.00000000,-3.14159300); //object(424)
CreateObject(1422,1392.56884800,-1861.99475100,12.79334400,0.00000000,0.00000000,-3.14159300); //object(425)
CreateObject(1422,1381.45837400,-1862.16528300,12.95740600,0.00000000,0.00000000,-3.14159300); //object(427)
CreateObject(1422,1396.83923300,-1862.05481000,12.95740600,0.00000000,0.00000000,-3.14159300); //object(428)
CreateObject(1422,1055.28356900,-1422.42089800,12.95409600,0.00000000,0.00000000,0.00000000); //object(429)
CreateObject(1422,1058.75451700,-1422.57177700,12.78131000,0.00000000,0.00000000,0.00000000); //object(430)
CreateObject(1422,1062.48352100,-1422.59887700,12.78030600,0.00000000,0.00000000,0.00000000); //object(431)
CreateObject(1422,1065.98327600,-1422.60205100,12.78030600,0.00000000,0.00000000,0.00000000); //object(432)
CreateObject(1422,1070.01110800,-1422.65405300,13.09232700,0.00000000,0.00000000,0.00000000); //object(433)
CreateObject(1422,1052.00170900,-1422.45764200,12.95518400,0.00000000,0.00000000,0.00000000); //object(434)
CreateObject(1422,1188.36608900,-1416.20471200,12.78214900,0.00000000,0.00000000,0.00000000); //object(435)
CreateObject(1422,1192.45678700,-1416.15087900,12.62152400,0.00000000,0.00000000,0.00000000); //object(436)
CreateObject(1422,1196.07226600,-1416.20654300,12.62903400,0.00000000,0.00000000,0.00000000); //object(437)
CreateObject(1422,1199.53735400,-1416.20507800,12.64210400,0.00000000,0.00000000,0.00000000); //object(438)
CreateObject(1422,1203.58728000,-1416.22802700,12.81382800,0.00000000,0.00000000,0.00000000); //object(439)
CreateObject(8673,1196.33300781,-1429.45507812,13.74785328,0.00000000,0.00000000,0.00000000); //object(440)
CreateObject(8673,1061.36157200,-1437.37243700,13.82445600,0.00000000,0.00000000,0.00000000); //object(441)
CreateObject(1422,1069.71582000,-1385.00512700,13.26110400,0.00000000,0.00000000,0.00000000); //object(442)
CreateObject(1422,1065.70275900,-1384.79748500,12.99585100,0.00000000,0.00000000,0.00000000); //object(443)
CreateObject(1422,1062.07605000,-1384.83703600,12.97815600,0.00000000,0.00000000,0.00000000); //object(444)
CreateObject(1422,1058.20324700,-1384.76257300,12.92616100,0.00000000,0.00000000,0.00000000); //object(445)
CreateObject(1422,1054.22338900,-1384.77136200,12.90243200,0.00000000,0.00000000,0.00000000); //object(446)
CreateObject(1422,1050.09314000,-1384.76599100,12.94421800,0.00000000,0.00000000,0.00000000); //object(447)
CreateObject(1422,1045.94360400,-1384.15490700,13.12536000,0.00000000,0.00000000,0.00000000); //object(448)
CreateObject(8673,1058.06457500,-1384.36914100,13.96293200,0.00000000,0.00000000,0.00000000); //object(449)
CreateObject(8673,1216.57385300,-1267.89013700,14.05387300,0.00000000,0.00000000,0.00000000); //object(450)
CreateObject(1422,1223.97131300,-1270.45385700,12.95740600,0.00000000,0.00000000,0.00000000); //object(451)
CreateObject(1422,1219.87597700,-1270.64172400,12.81162500,0.00000000,0.00000000,0.00000000); //object(452)
CreateObject(1422,1216.05798300,-1270.67956500,12.80906900,0.00000000,0.00000000,0.00000000); //object(453)
CreateObject(1422,1212.59301800,-1270.65515100,12.81071800,0.00000000,0.00000000,0.00000000); //object(454)
CreateObject(1422,1208.52148400,-1270.56933600,12.97764800,0.00000000,0.00000000,0.00000000); //object(455)
CreateObject(1238,1193.36267100,-1293.91198700,12.69989800,0.00000000,0.00000000,-2.15984400); //object(456)
CreateObject(1238,1198.16040000,-1296.97412100,12.70219600,0.00000000,0.00000000,-2.15984400); //object(457)
CreateObject(1238,1204.12182600,-1298.71142600,12.70771600,0.00000000,0.00000000,-2.15984400); //object(458)
CreateObject(1238,1210.18640100,-1299.09692400,12.70375200,0.00000000,0.00000000,-2.15984400); //object(459)
CreateObject(1238,1278.94091800,-1270.15905800,12.86253100,0.00000000,0.00000000,-2.15984400); //object(460)
CreateObject(1238,1276.05395500,-1270.12658700,12.85392300,0.00000000,0.00000000,-2.15984400); //object(461)
CreateObject(1238,1272.89575200,-1270.25500500,12.85801800,0.00000000,0.00000000,-2.15984400); //object(462)
CreateObject(1422,1143.54321300,-1270.46386700,12.93053300,0.00000000,0.00000000,0.00000000); //object(463)
CreateObject(1422,1147.44335900,-1270.74108900,12.90302800,0.00000000,0.00000000,0.00000000); //object(464)
CreateObject(1422,1150.89904800,-1270.76538100,12.92773000,0.00000000,0.00000000,0.00000000); //object(465)
CreateObject(1422,1154.60485800,-1270.71887200,12.90579500,0.00000000,0.00000000,0.00000000); //object(466)
CreateObject(1422,1158.80261200,-1270.64477500,12.93613200,0.00000000,0.00000000,0.00000000); //object(467)
CreateObject(8673,1151.16308594,-1265.90234375,14.15338230,0.00000000,0.00000000,0.00000000); //object(468)
CreateObject(1238,1146.47338900,-1291.19628900,12.95527000,0.00000000,0.00000000,-2.15984400); //object(469)
CreateObject(1238,1143.24926800,-1291.16503900,12.91738200,0.00000000,0.00000000,-2.15984400); //object(470)
CreateObject(1238,1140.04882800,-1291.16455100,12.91738200,0.00000000,0.00000000,-2.15984400); //object(471)
CreateObject(1238,1136.93029800,-1291.16418500,12.88153400,0.00000000,0.00000000,-2.15984400); //object(472)
CreateObject(1238,1011.19726600,-1332.84240700,12.70210100,0.00000000,0.00000000,-2.15984400); //object(473)
CreateObject(1238,1006.71783400,-1332.88098100,12.70448000,0.00000000,0.00000000,-2.15984400); //object(474)
CreateObject(1238,1001.13470500,-1332.83264200,12.70099300,0.00000000,0.00000000,-2.15984400); //object(475)
CreateObject(1238,995.68426500,-1332.80810500,12.70099300,0.00000000,0.00000000,-2.15984400); //object(476)
CreateObject(1238,990.66870100,-1334.36425800,12.70099300,0.00000000,0.00000000,-2.15984400); //object(477)
CreateObject(1422,949.99578900,-1310.15600600,12.96752300,0.00000000,0.00000000,0.00000000); //object(478)
CreateObject(1422,945.96075400,-1309.89392100,12.81581500,0.00000000,0.00000000,0.00000000); //object(479)
CreateObject(1422,942.28582800,-1309.94397000,12.81335500,0.00000000,0.00000000,0.00000000); //object(480)
CreateObject(1422,938.81158400,-1309.94299300,12.81340400,0.00000000,0.00000000,0.00000000); //object(481)
CreateObject(1422,934.23651100,-1309.46875000,12.95740600,0.00000000,0.00000000,0.00000000); //object(482)
CreateObject(8673,941.90179400,-1307.36792000,14.13142400,0.00000000,0.00000000,0.00000000); //object(483)
CreateObject(1422,805.19397000,-1309.81445300,12.95740600,0.00000000,0.00000000,0.00000000); //object(484)
CreateObject(1422,801.00042700,-1309.96508800,12.79334400,0.00000000,0.00000000,0.00000000); //object(485)
CreateObject(1422,797.42413300,-1309.96582000,12.79334400,0.00000000,0.00000000,0.00000000); //object(486)
CreateObject(1422,794.26965300,-1309.99194300,12.79334400,0.00000000,0.00000000,0.00000000); //object(487)
CreateObject(1422,789.78784200,-1310.04162600,12.95740600,0.00000000,0.00000000,0.00000000); //object(488)
CreateObject(8673,797.64495800,-1306.71313500,13.84972900,0.00000000,0.00000000,0.00000000); //object(489)
CreateObject(1422,799.49975600,-1332.00256300,12.79334400,0.00000000,0.00000000,-0.19635000); //object(490)
CreateObject(1422,796.70520000,-1331.40966800,12.79334400,0.00000000,0.00000000,-0.19635000); //object(491)
CreateObject(1422,789.48095700,-1330.75903300,12.95740600,0.00000000,0.00000000,0.00000000); //object(492)
CreateObject(1422,793.83148200,-1331.18542500,12.79334400,0.00000000,0.00000000,0.00000000); //object(493)
CreateObject(1422,802.51232900,-1332.41076700,12.79334400,0.00000000,0.00000000,0.00000000); //object(494)
CreateObject(8673,817.63494900,-1337.36096200,14.00594200,0.00000000,0.00000000,0.00000000); //object(495)
CreateObject(8673,807.36816406,-1347.80761719,14.01379108,0.00000000,0.00000000,270.42895508); //object(496)
CreateObject(1422,805.39642300,-1416.02771000,12.96461700,0.00000000,0.00000000,0.00000000); //object(497)
CreateObject(1422,800.99017300,-1416.04834000,12.80637800,0.00000000,0.00000000,0.00000000); //object(498)
CreateObject(1422,797.06549100,-1416.12341300,12.79825500,0.00000000,0.00000000,0.00000000); //object(499)
CreateObject(1422,793.41998300,-1416.07849100,12.79663900,0.00000000,0.00000000,0.00000000); //object(500)
CreateObject(1422,788.90283200,-1416.20654300,12.95217400,0.00000000,0.00000000,0.00000000); //object(501)
CreateObject(8673,796.81066900,-1421.15612800,13.84972900,0.00000000,0.00000000,-3.14159300); //object(502)
CreateObject(1422,773.99981700,-1384.67932100,13.10698700,0.00000000,0.00000000,0.00000000); //object(503)
CreateObject(1422,777.17840600,-1384.67504900,13.12264800,0.00000000,0.00000000,0.00000000); //object(504)
CreateObject(1422,780.27307100,-1384.70190400,13.13069300,0.00000000,0.00000000,0.00000000); //object(505)
CreateObject(1422,789.67376700,-1384.80102500,13.13293100,0.00000000,0.00000000,0.00000000); //object(506)
CreateObject(1422,793.43780500,-1384.85717800,12.91534000,0.00000000,0.00000000,0.00000000); //object(507)
CreateObject(1422,796.91064500,-1384.81982400,12.88079400,0.00000000,0.00000000,0.00000000); //object(508)
CreateObject(1422,800.96044900,-1384.82226600,12.88079400,0.00000000,0.00000000,0.00000000); //object(509)
CreateObject(1422,805.27038600,-1384.72436500,12.99840500,0.00000000,0.00000000,0.00000000); //object(510)
CreateObject(8673,797.50292969,-1380.76464844,13.86507416,0.00000000,0.00000000,0.85791016); //object(511)
CreateObject(8673,917.83203125,-1422.31250000,13.69630146,0.00000000,0.00000000,356.85791016); //object(512)
CreateObject(3819,993.35351562,-1386.33789062,13.30201626,0.00000000,0.00000000,91.28686523); //object(514)
CreateObject(3819,964.46582031,-1386.85449219,13.43389225,0.00000000,0.00000000,89.28686523); //object(515)
CreateObject(3819,951.41113281,-1386.79394531,13.37257290,0.00000000,0.00000000,89.28686523); //object(516)
CreateObject(3819,797.14941406,-1377.91796875,13.43999195,0.00000000,0.00000000,91.28686523); //object(517)
CreateObject(3819,797.99316406,-1303.41992188,13.38057041,0.00000000,0.00000000,89.28686523); //object(518)
CreateObject(3819,813.21289062,-1340.94726562,13.53127575,0.00000000,0.00000000,270.14477539); //object(519)
CreateObject(3819,873.19531250,-1338.64355469,13.54463291,0.00000000,0.00000000,270.14477539); //object(520)
CreateObject(3819,942.47851562,-1304.74804688,13.65585804,0.00000000,0.00000000,89.00268555); //object(521)
CreateObject(3819,1151.19726562,-1263.37402344,13.97337055,0.00000000,0.00000000,89.00268555); //object(522)
CreateObject(3819,1216.10253906,-1264.33203125,13.82505703,0.00000000,0.00000000,89.00268555); //object(523)
CreateObject(973,1651.70312500,-1458.99902344,13.18709946,0.00000000,0.00000000,270.14477539); //object(524)
CreateObject(973,1639.82226562,-1447.20214844,13.11209965,0.00000000,0.00000000,1.43164062); //object(525)
CreateObject(973,1473.37988281,-1435.14355469,13.38709545,0.00000000,0.00000000,180.28955078); //object(526)
CreateObject(973,1459.91113281,-1422.32617188,13.26209736,0.00000000,0.00000000,90.71850586); //object(527)
CreateObject(3452,1057.23437500,-1376.56445312,15.07739258,0.00000000,0.00000000,178.85791016); //object(528)
CreateObject(3452,1058.12207031,-1349.03222656,14.96501160,0.00000000,0.00000000,359.71582031); //object(529)
CreateObject(8673,1058.31372100,-1340.27282700,13.84972900,0.00000000,0.00000000,0.00000000); //object(530)
CreateObject(3819,1087.56054688,-1382.63378906,13.77900887,0.00000000,0.00000000,89.28686523); //object(531)
CreateObject(3819,1097.14355469,-1382.69628906,13.78555202,0.00000000,0.00000000,89.28686523); //object(532)
CreateObject(1422,1289.69335938,-1580.84570312,12.95740604,0.00000000,0.00000000,311.21447754); //object(533)
CreateObject(1238,1285.37426800,-1576.30004900,12.70099300,0.00000000,0.00000000,-2.15984400); //object(537)
CreateObject(1238,1281.96752900,-1572.48950200,12.70099300,0.00000000,0.00000000,-2.15984400); //object(538)
CreateObject(1238,1278.15612800,-1568.20239300,12.70099300,0.00000000,0.00000000,-2.15984400); //object(539)
CreateObject(1238,1272.77722200,-1564.46997100,12.90699500,0.00000000,0.00000000,-2.15984400); //object(540)
CreateObject(1422,1561.90295400,-1861.98168900,12.95740600,0.00000000,0.00000000,-3.14159300); //object(541)
CreateObject(1422,1565.94250500,-1861.98461900,12.79334400,0.00000000,0.00000000,-3.14159300); //object(542)
CreateObject(1422,1569.49841300,-1861.97473100,12.79334400,0.00000000,0.00000000,-3.14159300); //object(543)
CreateObject(1422,1573.19165000,-1862.02136200,12.79334400,0.00000000,0.00000000,-3.14159300); //object(544)
CreateObject(1422,1577.44824200,-1862.10107400,12.94964700,0.00000000,0.00000000,-3.14159300); //object(545)
CreateObject(1422,1561.00463900,-1745.19299300,12.95740600,0.00000000,0.00000000,-3.14159300); //object(546)
CreateObject(1422,1566.02563500,-1745.26184100,12.79334400,0.00000000,0.00000000,-3.14159300); //object(547)
CreateObject(1422,1569.48608400,-1745.24475100,12.79334400,0.00000000,0.00000000,-3.14159300); //object(548)
CreateObject(1422,1573.18945300,-1745.24682600,12.79334400,0.00000000,0.00000000,-3.14159300); //object(549)
CreateObject(1422,1577.18310500,-1745.34875500,12.95740600,0.00000000,0.00000000,-3.14159300); //object(550)
CreateObject(1238,1264.84655800,-1292.43872100,12.61914100,0.00000000,0.00000000,-2.15984400); //object(551)
CreateObject(1238,1260.46582000,-1295.80835000,12.82341000,0.00000000,0.00000000,-2.15984400); //object(552)
CreateObject(1238,1254.58813500,-1297.35766600,12.58917200,0.00000000,0.00000000,-2.15984400); //object(553)
CreateObject(1238,1248.41345200,-1297.85815400,12.73753800,0.00000000,0.00000000,-2.15984400); //object(554)
CreateObject(1422,925.10455300,-1337.68640100,12.92962600,0.00000000,0.00000000,0.00000000); //object(555)
CreateObject(1422,921.04730200,-1337.57568400,12.79196000,0.00000000,0.00000000,0.00000000); //object(556)
CreateObject(1422,917.49676500,-1337.62475600,12.79196000,0.00000000,0.00000000,0.00000000); //object(557)
CreateObject(1422,913.87213100,-1337.62500000,12.79196000,0.00000000,0.00000000,0.00000000); //object(558)
CreateObject(1422,910.43310500,-1337.42211900,12.95740600,0.00000000,0.00000000,0.00000000); //object(559)
CreateObject(1422,909.67218000,-1384.56835900,12.95475400,0.00000000,0.00000000,0.00000000); //object(560)
CreateObject(1422,913.28320300,-1384.85376000,12.73310900,0.00000000,0.00000000,0.00000000); //object(561)
CreateObject(1422,916.93969700,-1384.70471200,12.63267600,0.00000000,0.00000000,0.00000000); //object(562)
CreateObject(1422,921.25109900,-1384.76379400,12.66597900,0.00000000,0.00000000,0.00000000); //object(563)
CreateObject(1422,925.05590800,-1384.76513700,12.81900500,0.00000000,0.00000000,0.00000000); //object(564)
CreateObject(1422,1322.40332031,-1579.91992188,12.95740604,0.00000000,0.00000000,268.42895508); //object(556)
CreateObject(1422,1322.73535156,-1575.87500000,12.77581882,0.00000000,0.00000000,270.42895508); //object(557)
CreateObject(1422,1322.81054688,-1572.25000000,12.79805756,0.00000000,0.00000000,270.42895508); //object(558)
CreateObject(1422,1322.62890625,-1568.67285156,12.77638054,0.00000000,0.00000000,270.42895508); //object(559)
CreateObject(973,1325.73437500,-1559.85546875,13.37987614,0.00000000,0.00000000,74.01940918); //object(561)
//================================================[ MAP FC ]======================================
CreateObject(669,-192.5478516,1040.6025391,18.7812996,0.0000000,0.0000000,0.0000000); //object(sm_veg_tree4) (5)
CreateObject(3605,48.2791557,1356.3199463,15.5726013,0.0000000,0.0000000,262.0000000); //object(bevman3_law2) (1)
CreateObject(970,-190.5395813,1037.1845703,19.1452312,0.0000000,0.0000000,269.9995117); //object(fencesmallb) (2)
CreateObject(970,-190.5395660,1041.3598633,19.1452312,0.0000000,0.0000000,269.9945068); //object(fencesmallb) (3)
CreateObject(970,-190.5406799,1045.4462891,19.1452312,0.0000000,0.0000000,269.9945068); //object(fencesmallb) (4)
CreateObject(970,-190.5387115,1049.4580078,19.1452312,0.0000000,0.0000000,269.9945068); //object(fencesmallb) (5)
CreateObject(970,-190.5366974,1053.5600586,19.1452312,0.0000000,0.0000000,269.9945068); //object(fencesmallb) (6)
CreateObject(970,-190.5346680,1057.6806641,19.1452312,0.0000000,0.0000000,269.9945068); //object(fencesmallb) (7)
CreateObject(970,-190.5394897,1061.8200684,19.1452312,0.0000000,0.0000000,269.9945068); //object(fencesmallb) (8)
CreateObject(970,-190.5316772,1066.0260010,19.1452312,0.0000000,0.0000000,269.9945068); //object(fencesmallb) (9)
CreateObject(970,-190.5316467,1070.2021484,19.1452312,0.0000000,0.0000000,269.9945068); //object(fencesmallb) (10)
CreateObject(970,-190.5394592,1074.2775879,19.1453838,0.0000000,0.0000000,269.9945068); //object(fencesmallb) (11)
CreateObject(970,-190.5394440,1078.3377686,19.1435108,0.0000000,0.0000000,269.9945068); //object(fencesmallb) (12)
CreateObject(970,-190.5394287,1082.4099121,19.1416321,0.0000000,0.0000000,269.9945068); //object(fencesmallb) (13)
CreateObject(970,-185.4892578,1083.4199219,19.2936687,0.0000000,0.0000000,269.9945068); //object(fencesmallb) (15)
CreateObject(970,-185.4921875,1079.3505859,19.2936687,0.0000000,0.0000000,269.9945068); //object(fencesmallb) (16)
CreateObject(970,-185.4648438,1075.2949219,19.2936687,0.0000000,0.0000000,269.9945068); //object(fencesmallb) (17)
CreateObject(970,-185.4404297,1071.1455078,19.2936687,0.0000000,0.0000000,269.9945068); //object(fencesmallb) (18)
CreateObject(970,-185.4628906,1067.0556641,19.2936687,0.0000000,0.0000000,269.9945068); //object(fencesmallb) (19)
CreateObject(970,-185.4257812,1062.9873047,19.2936687,0.0000000,0.0000000,269.9945068); //object(fencesmallb) (20)
CreateObject(970,-185.4052734,1058.8798828,19.2936687,0.0000000,0.0000000,269.9945068); //object(fencesmallb) (21)
CreateObject(970,-185.4186859,1054.8891602,19.2936687,0.0000000,0.0000000,269.9945068); //object(fencesmallb) (22)
CreateObject(970,-185.4695282,1050.8066406,19.2936687,0.0000000,0.0000000,269.9945068); //object(fencesmallb) (23)
CreateObject(970,-185.2490234,1047.2451172,19.1474037,0.0000000,0.0000000,269.9945068); //object(fencesmallb) (25)
CreateObject(970,-185.5380859,1043.2285156,19.2936687,0.0000000,0.0000000,269.9945068); //object(fencesmallb) (26)
CreateObject(970,-185.4218750,1039.0644531,19.2936687,0.0000000,0.0000000,269.9945068); //object(fencesmallb) (27)
CreateObject(970,-185.4365234,1034.9736328,19.2936687,0.0000000,0.0000000,269.9945068); //object(fencesmallb) (28)
CreateObject(970,-190.4052734,1033.0517578,19.1452312,0.0000000,0.0000000,271.9995117); //object(fencesmallb) (29)
CreateObject(970,-195.6578979,1040.3404541,19.1410370,0.0000000,0.0000000,273.9995117); //object(fencesmallb) (30)
CreateObject(970,-195.6881409,1044.3406982,19.1452312,0.0000000,0.0000000,269.9945068); //object(fencesmallb) (33)
CreateObject(970,-195.6171875,1048.6816406,19.1452312,0.0000000,0.0000000,269.9945068); //object(fencesmallb) (34)
CreateObject(970,-195.5400391,1052.8496094,19.1452312,0.0000000,0.0000000,269.9945068); //object(fencesmallb) (35)
CreateObject(970,-195.5400391,1056.9609375,19.1664505,0.0000000,0.0000000,269.9945068); //object(fencesmallb) (36)
CreateObject(970,-195.5400391,1036.2500000,19.1452312,0.0000000,0.0000000,269.9945068); //object(fencesmallb) (37)
CreateObject(970,-195.5693359,1061.0517578,19.1452312,0.0000000,0.0000000,269.9945068); //object(fencesmallb) (38)
CreateObject(970,-195.7929688,1065.2197266,19.1452312,0.0000000,0.0000000,269.9945068); //object(fencesmallb) (39)
CreateObject(970,-195.7333984,1069.3535156,19.1452312,0.0000000,0.0000000,269.9945068); //object(fencesmallb) (40)
CreateObject(970,-195.5400391,1073.4951172,19.1529961,0.0000000,0.0000000,269.9945068); //object(fencesmallb) (41)
CreateObject(970,-195.5400391,1077.6611328,19.1529961,0.0000000,0.0000000,269.9945068); //object(fencesmallb) (42)
CreateObject(970,-195.5400391,1081.7714844,19.1529961,0.0000000,0.0000000,269.9945068); //object(fencesmallb) (43)
CreateObject(970,-200.5375519,1084.6595459,19.1449795,0.0000000,0.0000000,269.9945068); //object(fencesmallb) (44)
CreateObject(970,-200.5387573,1080.5739746,19.1470833,0.0000000,0.0000000,269.9945068); //object(fencesmallb) (45)
CreateObject(970,-200.5399933,1076.4818115,19.1491909,0.0000000,0.0000000,269.9945068); //object(fencesmallb) (46)
CreateObject(970,-200.5462036,1072.3555908,19.2936687,0.0000000,0.0000000,269.9945068); //object(fencesmallb) (47)
CreateObject(970,-200.6740417,1068.1612549,19.2936687,0.0000000,0.0000000,269.9945068); //object(fencesmallb) (48)
CreateObject(970,-200.7549896,1064.0166016,19.2936687,0.0000000,0.0000000,269.9945068); //object(fencesmallb) (49)
CreateObject(970,-200.7545166,1059.9645996,19.2936687,0.0000000,0.0000000,269.9945068); //object(fencesmallb) (50)
CreateObject(970,-200.7317505,1055.9072266,19.2936687,0.0000000,0.0000000,269.9945068); //object(fencesmallb) (51)
CreateObject(970,-200.6792603,1051.8065186,19.2936687,0.0000000,0.0000000,269.9945068); //object(fencesmallb) (52)
CreateObject(970,-200.6819916,1047.7984619,19.2936687,0.0000000,0.0000000,269.9945068); //object(fencesmallb) (53)
CreateObject(970,-200.6467743,1043.6207275,19.2936687,0.0000000,0.0000000,269.9945068); //object(fencesmallb) (54)
CreateObject(970,-200.5510254,1039.4399414,19.2936687,0.0000000,0.0000000,269.9945068); //object(fencesmallb) (55)
CreateObject(970,-200.5552368,1035.3192139,19.2936687,0.0000000,0.0000000,269.9945068); //object(fencesmallb) (56)
CreateObject(978,-188.5814514,1107.6297607,19.4341621,0.0000000,0.0000000,176.0000000); //object(sub_roadright) (1)
CreateObject(979,-196.8218536,1107.8078613,19.4339695,0.0000000,0.0000000,182.0000000); //object(sub_roadleft) (1)
CreateObject(978,-197.0994263,1187.7558594,19.4324932,0.0000000,0.0000000,0.0000000); //object(sub_roadright) (2)
CreateObject(979,-189.6654510,1187.6727295,19.4275646,0.0000000,0.0000000,0.0000000); //object(sub_roadleft) (2)
CreateObject(979,-181.0506744,1148.5349121,19.4406986,0.0000000,0.0000000,272.0000000); //object(sub_roadleft) (3)
CreateObject(1282,-193.0638275,1188.9838867,19.2729988,0.0000000,0.0000000,90.0000000); //object(barrierm) (1)
CreateObject(1282,-193.1113281,1106.0751953,19.2846909,0.0000000,0.0000000,90.0000000); //object(barrierm) (2)
CreateObject(1282,-193.0634766,1188.9833984,19.2729988,0.0000000,0.0000000,90.0000000); //object(barrierm) (3)
CreateObject(1282,-179.0298462,1148.2670898,19.2825661,0.0000000,0.0000000,4.0000000); //object(barrierm) (4)
CreateObject(1422,-197.6040955,1114.3533936,19.0025539,0.0000000,0.0000000,0.0000000); //object(dyn_roadbarrier_5) (1)
CreateObject(1422,-188.0322266,1114.3730469,19.0033684,0.0000000,0.0000000,0.0000000); //object(dyn_roadbarrier_5) (2)
CreateObject(1422,-187.9385529,1185.3740234,18.9989815,0.0000000,0.0000000,0.0000000); //object(dyn_roadbarrier_5) (3)
CreateObject(1422,-197.6707001,1186.7779541,19.0024757,0.0000000,0.0000000,0.0000000); //object(dyn_roadbarrier_5) (4)
CreateObject(1422,-182.4896851,1145.8386230,19.0042801,0.0000000,0.0000000,272.0000000); //object(dyn_roadbarrier_5) (5)
CreateObject(1422,-182.9302521,1150.8574219,19.0074387,0.0000000,0.0000000,269.9990234); //object(dyn_roadbarrier_5) (6)
CreateObject(1425,-189.2443695,1106.0737305,19.0471249,0.0000000,0.0000000,0.0000000); //object(dyn_roadbarrier_3) (1)
CreateObject(1425,-197.5644226,1105.7646484,19.0462475,0.0000000,0.0000000,0.0000000); //object(dyn_roadbarrier_3) (2)
CreateObject(1425,-178.9608612,1150.3842773,19.0502110,0.0000000,0.0000000,90.0000000); //object(dyn_roadbarrier_3) (3)
CreateObject(1425,-179.3591003,1145.5812988,19.0432072,0.0000000,0.0000000,90.0000000); //object(dyn_roadbarrier_3) (4)
CreateObject(1425,-178.9599609,1150.3837891,19.0502110,0.0000000,0.0000000,90.0000000); //object(dyn_roadbarrier_3) (5)
CreateObject(1425,-197.7537689,1189.1329346,19.0448589,0.0000000,0.0000000,182.0000000); //object(dyn_roadbarrier_3) (6)
CreateObject(1425,-187.7314453,1188.7041016,19.0242176,0.0000000,0.0000000,181.9995117); //object(dyn_roadbarrier_3) (7)
//=================================================[ GARE FC ]=====================================================================
CreateObject(3115,107.3000031,1252.5000000,20.5000000,358.0000000,355.0000000,74.0000000); //object(carrier_lift1_sfse) (1)
CreateObject(3115,102.8000031,1241.4000244,19.7999001,358.0000000,358.0000000,59.9984131); //object(carrier_lift1_sfse) (2)
CreateObject(16480,74.5000000,1288.5999756,33.5998993,0.0000000,0.0000000,235.9964600); //object(ftcarson_sign) (1)
CreateObject(16480,159.0000000,1267.8000488,36.7999001,0.0000000,0.0000000,55.9963379); //object(ftcarson_sign) (2)
CreateObject(10932,95.9000015,1284.5000000,29.3999004,2.0000000,0.0000000,254.0000000); //object(station03_sfs) (1)
CreateObject(5169,114.8000031,1291.9000244,23.5000000,0.0000000,2.0000000,163.9984131); //object(imnrmpy1_las2) (1)
CreateObject(5169,107.5000000,1267.0000000,23.5000000,0.0000000,358.0000000,344.0000000); //object(imnrmpy1_las2) (2)
CreateObject(8575,107.5999985,1253.1999512,25.7999992,358.0000000,0.0000000,74.0000000); //object(vgstrainstation) (1)
CreateObject(8575,123.5000000,1302.0999756,26.2000008,2.0000000,0.0000000,253.9984131); //object(vgstrainstation) (3)
CreateObject(10932,137.7593842,1272.6204834,30.6499996,1.9995117,0.0000000,253.9984131); //object(station03_sfs) (2)
//==================================================[ 3D TEXT LABEL ]=======================================================
//==================================================[ PORT FC ]===============================================================
CreateObject(10769,-517.3994141,884.7998047,5.4000001,0.0000000,0.0000000,197.9956055); //object(airport_14_sfse) (3)
CreateObject(5184,-583.5996094,992.6992188,26.0000000,0.0000000,0.0000000,61.9958496); //object(mdock1a_las2) (1)
CreateObject(5184,-504.7000122,1025.5000000,25.5000000,0.0000000,0.0000000,153.9958496); //object(mdock1a_las2) (2)
CreateObject(5166,-504.7000122,1044.3000488,17.2999992,0.0000000,0.0000000,242.0000000); //object(dkcargohull2bd) (1)
CreateObject(10841,-526.7999878,798.2000122,8.3999996,0.0000000,0.0000000,334.0000000); //object(drydock1_sfse01) (1)
CreateObject(10841,-508.7999878,789.4000244,8.3999996,0.0000000,0.0000000,333.9953613); //object(drydock1_sfse01) (2)
CreateObject(14436,-535.9000244,1030.5000000,9.1000004,225.0000000,0.0000000,246.0000000); //object(carter_girders1) (1)
CreateObject(14436,-541.7000122,995.0999756,9.1000004,225.0000000,0.0000000,263.9948730); //object(carter_girders1) (2)
CreateObject(14436,-490.7999878,994.7000122,9.3999996,225.0000000,0.0000000,41.9904785); //object(carter_girders1) (3)
CreateObject(14436,-470.7999878,1023.5000000,9.3999996,225.0000000,0.0000000,57.9897461); //object(carter_girders1) (4)
CreateObject(3620,-498.6000061,989.7999878,27.7999992,0.0000000,0.0000000,224.0000000); //object(redockrane_las) (1)
CreateObject(5154,-496.2000122,983.2999878,11.3999996,0.0000000,0.0000000,221.9953613); //object(dk_cargoshp03d) (2)
CreateObject(9618,-502.2999878,1005.0000000,18.2000008,0.0000000,0.0000000,314.0000000); //object(scaff1_sfw) (1)
CreateObject(3867,-494.0000000,1006.4000244,-0.9000000,0.0000000,0.0000000,44.0000000); //object(ws_scaffolding_sfx) (1)
CreateObject(3867,-494.0000000,1006.4000244,30.2999992,0.0000000,0.0000000,43.9947510); //object(ws_scaffolding_sfx) (3)
CreateObject(3867,-483.2999878,1019.7000122,-0.9000000,0.0000000,0.0000000,57.9947510); //object(ws_scaffolding_sfx) (4)
CreateObject(3867,-483.2999878,1019.7000122,30.3999996,0.0000000,0.0000000,57.9913330); //object(ws_scaffolding_sfx) (5)
CreateObject(9618,-533.5999756,1015.2000122,18.2000008,0.0000000,0.0000000,351.9947510); //object(scaff1_sfw) (2)
CreateObject(3867,-528.4000244,1021.5000000,-0.8000000,0.0000000,0.0000000,262.0000000); //object(ws_scaffolding_sfx) (6)
CreateObject(3867,-528.4000244,1021.5000000,30.2000008,0.0000000,0.0000000,261.9964600); //object(ws_scaffolding_sfx) (7)
CreateObject(3867,-524.0999756,1037.6999512,-0.8000000,0.0000000,0.0000000,247.9964600); //object(ws_scaffolding_sfx) (8)
CreateObject(3867,-524.0999756,1037.6999512,30.2000008,0.0000000,0.0000000,247.9943848); //object(ws_scaffolding_sfx) (9)
CreateObject(3620,-502.6000061,986.0000000,27.7999992,0.0000000,0.0000000,223.9947510); //object(redockrane_las) (2)
CreateObject(5154,-545.0000000,1007.7000122,11.3999996,0.0000000,0.0000000,263.9952393); //object(dk_cargoshp03d) (3)
CreateObject(3620,-538.7999878,1004.4000244,27.7999992,0.0000000,0.0000000,85.9947510); //object(redockrane_las) (3)
CreateObject(3620,-538.2000122,1009.9000244,27.7999992,0.0000000,0.0000000,85.9899902); //object(redockrane_las) (4)
CreateObject(2917,-523.2999878,1002.9000244,39.7999992,0.0000000,0.0000000,264.0000000); //object(a51_crane) (1)
CreateObject(12930,-517.2000122,1005.0999756,36.7999992,0.0000000,0.0000000,84.0000000); //object(sw_pipepile02) (1)
CreateObject(2917,-522.7999878,1008.0999756,39.7999992,0.0000000,0.0000000,263.9959717); //object(a51_crane) (2)
CreateObject(2917,-508.8999939,1001.2000122,39.7999992,0.0000000,0.0000000,41.9959717); //object(a51_crane) (3)
CreateObject(2917,-513.0000000,997.5000000,39.7999992,0.0000000,0.0000000,41.9947510); //object(a51_crane) (4)
CreateObject(12930,-514.9000244,1003.5000000,36.7999992,0.0000000,0.0000000,221.9959717); //object(sw_pipepile02) (2)
CreateObject(10230,-487.2999878,860.5999756,12.1999998,0.0000000,0.0000000,64.0000000); //object(freighter_sfe) (1)
CreateObject(10229,-486.1000061,860.0000000,10.8999996,0.0000000,0.0000000,64.0000000); //object(freighter2b_sfe) (1)
CreateObject(10231,-486.3999939,859.2000122,13.1000004,0.0000000,0.0000000,64.0000000); //object(freightboxes) (2)
CreateObject(3867,-481.3999939,840.5000000,1.8000000,0.0000000,0.0000000,64.0000000); //object(ws_scaffolding_sfx) (10)
CreateObject(1466,-485.1992188,831.8994141,5.5000000,0.0000000,0.0000000,333.9953613); //object(dyn_scaffold_5) (1)
CreateObject(1466,-483.2000122,831.0000000,5.5000000,0.0000000,0.0000000,333.9953613); //object(dyn_scaffold_5) (2)
CreateObject(3867,-489.7000122,823.7000122,1.8000000,0.0000000,0.0000000,63.9953613); //object(ws_scaffolding_sfx) (11)
CreateObject(3867,-474.0000000,855.5000000,1.8000000,0.0000000,0.0000000,63.9953613); //object(ws_scaffolding_sfx) (12)
CreateObject(3867,-466.5000000,870.7999878,1.8000000,0.0000000,0.0000000,63.9953613); //object(ws_scaffolding_sfx) (13)
CreateObject(3867,-459.1000061,885.7999878,1.8000000,0.0000000,0.0000000,63.9953613); //object(ws_scaffolding_sfx) (14)
CreateObject(1466,-455.0000000,894.2000122,13.0000000,0.0000000,0.0000000,333.9953613); //object(dyn_scaffold_5) (1)
CreateObject(1466,-452.8999939,893.2000122,13.0000000,0.0000000,0.0000000,333.9953613); //object(dyn_scaffold_5) (1)
CreateObject(1466,-450.8999939,892.2000122,13.0000000,0.0000000,0.0000000,333.9953613); //object(dyn_scaffold_5) (1)
CreateObject(3867,-517.5000000,825.7999878,-1.0000000,0.0000000,0.0000000,244.0000000); //object(ws_scaffolding_sfx) (2)
CreateObject(3867,-509.2999878,843.2999878,-1.0000000,0.0000000,0.0000000,243.9953613); //object(ws_scaffolding_sfx) (15)
CreateObject(3867,-502.0000000,858.4000244,-1.0000000,0.0000000,0.0000000,243.9953613); //object(ws_scaffolding_sfx) (16)
CreateObject(3867,-494.6000061,873.5999756,-1.0000000,0.0000000,0.0000000,243.9953613); //object(ws_scaffolding_sfx) (17)
CreateObject(3867,-487.1000061,888.5999756,-1.0000000,0.0000000,0.0000000,243.9953613); //object(ws_scaffolding_sfx) (18)
CreateObject(1466,-513.7999878,834.7999878,10.3000002,0.0000000,0.0000000,333.9953613); //object(dyn_scaffold_5) (1)
CreateObject(3361,-515.7000122,835.5000000,13.8000002,0.0000000,0.0000000,334.0000000); //object(cxref_woodstair) (1)
CreateObject(3620,-491.5000000,818.0000000,29.2000008,0.0000000,0.0000000,244.0000000); //object(redockrane_las) (5)
CreateObject(3620,-482.2999878,835.7999878,29.2000008,0.0000000,0.0000000,243.9953613); //object(redockrane_las) (6)
CreateObject(3620,-474.5000000,851.2000122,29.2000008,0.0000000,0.0000000,243.9953613); //object(redockrane_las) (7)
CreateObject(3620,-464.7999878,870.0999756,29.2000008,0.0000000,0.0000000,243.9953613); //object(redockrane_las) (8)
CreateObject(3620,-497.2000122,886.4000244,29.2000008,0.0000000,0.0000000,63.9953613); //object(redockrane_las) (9)
CreateObject(3620,-506.1000061,867.9000244,29.2000008,0.0000000,0.0000000,63.9953613); //object(redockrane_las) (10)
CreateObject(3620,-514.7000122,852.5000000,29.2000008,0.0000000,0.0000000,63.9953613); //object(redockrane_las) (11)
CreateObject(3620,-523.9000244,835.0000000,29.2000008,0.0000000,0.0000000,63.9953613); //object(redockrane_las) (12)
CreateObject(10831,-571.5999756,798.0000000,21.0000000,0.0000000,0.0000000,152.0000000); //object(drydock3_sfse) (1)
CreateObject(9245,-580.4000244,778.0000000,27.8999996,0.0000000,0.0000000,242.0000000); //object(cstguard_sfn01) (1)
CreateObject(5184,-610.2000122,942.5000000,26.0000000,0.0000000,0.0000000,61.9958496); //object(mdock1a_las2) (1)
CreateObject(5184,-694.5000000,803.2000122,26.0000000,0.0000000,0.0000000,55.9958496); //object(mdock1a_las2) (1)
CreateObject(8373,-656.2000122,854.9000244,-21.7000008,0.0000000,0.0000000,56.0000000); //object(vegass_jetty01) (1)
CreateObject(8373,-644.5999756,871.7999878,-21.7000008,0.0000000,0.0000000,55.9973145); //object(vegass_jetty01) (2)
CreateObject(3361,-640.9000244,853.5999756,4.5999999,0.0000000,0.0000000,325.9953613); //object(cxref_woodstair) (2)
CreateObject(3361,-635.9000244,850.2999878,0.6000000,0.0000000,0.0000000,325.9918213); //object(cxref_woodstair) (3)
CreateObject(3361,-629.5996094,870.3994141,4.5999999,0.0000000,0.0000000,325.9918213); //object(cxref_woodstair) (4)
CreateObject(3361,-624.7999878,867.0999756,0.6000000,0.0000000,0.0000000,325.9918213); //object(cxref_woodstair) (5)
CreateObject(3867,-626.4000244,862.0000000,-4.5000000,0.0000000,0.0000000,146.0000000); //object(ws_scaffolding_sfx) (20)
CreateObject(3867,-632.5999756,853.2999878,-4.5000000,0.0000000,0.0000000,325.9973145); //object(ws_scaffolding_sfx) (21)
CreateObject(3620,-639.5000000,865.0000000,19.1000004,0.0000000,0.0000000,56.0000000); //object(redockrane_las) (13)
CreateObject(3620,-639.5000000,865.0000000,19.1000004,0.0000000,0.0000000,56.0000000); //object(redockrane_las) (14)
CreateObject(10830,-589.2000122,991.9000244,14.8999996,0.0000000,0.0000000,16.0000000); //object(drydock2_sfse) (1)
CreateObject(3620,-584.5999756,932.0999756,21.1000004,0.0000000,0.0000000,62.0000000); //object(redockrane_las) (15)
CreateObject(3620,-598.0000000,906.7999878,21.1000004,0.0000000,0.0000000,61.9958496); //object(redockrane_las) (16)
CreateObject(8883,-604.0999756,945.2999878,10.5000000,0.0000000,0.0000000,332.0000000); //object(vgsefrght01) (1)
CreateObject(1262,-553.4000244,602.7000122,15.1999998,0.0000000,0.0000000,154.0000000); //object(mtraffic4) (1)
CreateObject(1262,-553.0000000,602.5000000,15.1999998,0.0000000,0.0000000,153.9953613); //object(mtraffic4) (2)
CreateObject(1262,-552.5999756,602.2999878,15.1999998,0.0000000,0.0000000,153.9953613); //object(mtraffic4) (3)
CreateObject(1262,-552.2000122,602.0999756,15.1999998,0.0000000,0.0000000,153.9953613); //object(mtraffic4) (4)
CreateObject(1262,-551.7999878,601.9000244,15.1999998,0.0000000,0.0000000,153.9953613); //object(mtraffic4) (5)
CreateObject(1262,-551.4000244,601.7000122,15.1999998,0.0000000,0.0000000,153.9953613); //object(mtraffic4) (6)
CreateObject(1262,-551.0000000,601.5000000,15.1999998,0.0000000,0.0000000,153.9953613); //object(mtraffic4) (7)
CreateObject(1262,-550.5999756,601.2999878,15.1999998,0.0000000,0.0000000,153.9953613); //object(mtraffic4) (8)
CreateObject(1262,-550.2000122,601.0999756,15.1999998,0.0000000,0.0000000,153.9953613); //object(mtraffic4) (12)
CreateObject(1262,-549.7999878,600.9000244,15.1999998,0.0000000,0.0000000,153.9953613); //object(mtraffic4) (13)
CreateObject(1262,-620.9000244,633.7000122,15.1000004,0.0000000,0.0000000,156.0000000); //object(mtraffic4) (14)
CreateObject(1262,-620.4000244,633.5000000,15.1000004,0.0000000,0.0000000,155.9948730); //object(mtraffic4) (15)
CreateObject(1262,-619.9000244,633.2999878,15.1000004,0.0000000,0.0000000,155.9948730); //object(mtraffic4) (16)
CreateObject(1262,-619.4000244,633.0999756,15.1000004,0.0000000,0.0000000,155.9948730); //object(mtraffic4) (17)
CreateObject(1262,-618.9000244,632.9000244,15.1000004,0.0000000,0.0000000,155.9948730); //object(mtraffic4) (18)
CreateObject(1262,-618.5000000,632.7000122,15.1000004,0.0000000,0.0000000,155.9948730); //object(mtraffic4) (19)
CreateObject(1262,-618.0999756,632.5000000,15.1000004,0.0000000,0.0000000,155.9948730); //object(mtraffic4) (20)
CreateObject(1262,-617.7000122,632.2999878,15.1000004,0.0000000,0.0000000,155.9948730); //object(mtraffic4) (21)
CreateObject(1262,-617.2999878,632.0999756,15.1000004,0.0000000,0.0000000,155.9948730); //object(mtraffic4) (22)
CreateObject(1262,-654.7999878,677.9000244,15.1000004,0.0000000,0.0000000,335.9948730); //object(mtraffic4) (23)
CreateObject(1262,-655.2000122,678.0999756,15.1000004,0.0000000,0.0000000,335.9948730); //object(mtraffic4) (24)
CreateObject(1262,-655.5999756,678.2999878,15.1000004,0.0000000,0.0000000,335.9948730); //object(mtraffic4) (25)
CreateObject(1262,-656.0000000,678.5000000,15.1000004,0.0000000,0.0000000,335.9948730); //object(mtraffic4) (26)
CreateObject(1262,-656.4000244,678.7000122,15.1000004,0.0000000,0.0000000,335.9948730); //object(mtraffic4) (27)
CreateObject(1262,-656.7999878,678.9000244,15.1000004,0.0000000,0.0000000,335.9948730); //object(mtraffic4) (28)
CreateObject(1262,-657.2000122,679.0999756,15.1000004,0.0000000,0.0000000,335.9948730); //object(mtraffic4) (29)
CreateObject(1262,-657.7000122,679.2999878,15.1000004,0.0000000,0.0000000,335.9948730); //object(mtraffic4) (30)
CreateObject(1262,-658.2000122,679.5000000,15.1000004,0.0000000,0.0000000,335.9948730); //object(mtraffic4) (31)
CreateObject(1262,-658.7000122,679.7000122,15.1000004,0.0000000,0.0000000,335.9948730); //object(mtraffic4) (32)
CreateObject(8886,-609.4000244,984.7000122,11.8999996,0.0000000,0.0000000,334.0000000); //object(vgsefrght04) (1)
CreateObject(8886,-582.7000122,972.2000122,11.8999996,0.0000000,0.0000000,333.9953613); //object(vgsefrght04) (2)
CreateObject(8883,-582.7999878,1004.0000000,10.5000000,0.0000000,0.0000000,241.9958496); //object(vgsefrght01) (2)
CreateObject(5184,-430.8999939,961.9000244,-30.6000004,90.0000000,0.0000000,152.0000000); //object(mdock1a_las2) (3)
CreateObject(5184,-428.2999878,865.7999878,-30.6000004,90.0000000,0.0000000,61.9958496); //object(mdock1a_las2) (4)
CreateObject(5184,-402.2999878,975.7000122,25.3999996,0.0000000,0.0000000,153.9903564); //object(mdock1a_las2) (5)
CreateObject(10831,-450.2999878,986.7999878,9.1000004,0.0000000,0.0000000,244.0000000); //object(drydock3_sfse) (2)
CreateObject(12930,-457.5000000,995.0000000,7.5000000,0.0000000,0.0000000,334.0000000); //object(sw_pipepile02) (3)
CreateObject(12930,-455.5000000,994.0000000,7.5000000,0.0000000,0.0000000,333.9953613); //object(sw_pipepile02) (4)
CreateObject(12930,-448.5000000,990.5999756,7.5000000,0.0000000,0.0000000,333.9953613); //object(sw_pipepile02) (5)
CreateObject(12930,-446.2000122,989.5000000,7.5000000,0.0000000,0.0000000,333.9953613); //object(sw_pipepile02) (6)
CreateObject(12930,-465.6000061,977.4000244,7.5000000,0.0000000,0.0000000,333.9953613); //object(sw_pipepile02) (7)
CreateObject(12930,-463.2999878,976.4000244,7.5000000,0.0000000,0.0000000,333.9953613); //object(sw_pipepile02) (8)
CreateObject(12930,-456.2999878,973.2000122,7.5000000,0.0000000,0.0000000,333.9953613); //object(sw_pipepile02) (9)
CreateObject(12930,-454.0000000,972.2000122,7.5000000,0.0000000,0.0000000,333.9953613); //object(sw_pipepile02) (10)
CreateObject(12930,-564.9000244,825.4000244,16.8999996,0.0000000,0.0000000,332.0000000); //object(sw_pipepile02) (11)
CreateObject(3865,-540.2999878,857.4000244,18.0000000,0.0000000,0.0000000,0.0000000); //object(concpipe_sfxrf) (1)
CreateObject(3865,-545.5999756,860.0000000,20.2999992,90.0000000,0.0000000,0.0000000); //object(concpipe_sfxrf) (2)
CreateObject(3865,-522.7999878,888.0000000,18.0000000,0.0000000,0.0000000,44.0000000); //object(concpipe_sfxrf) (3)
CreateObject(3865,-525.5000000,885.5999756,18.0000000,0.0000000,0.0000000,43.9947510); //object(concpipe_sfxrf) (4)
CreateObject(3865,-524.0999756,886.7999878,21.0000000,0.0000000,0.0000000,43.9947510); //object(concpipe_sfxrf) (5)
CreateObject(3636,-680.4000244,810.9000244,15.3999996,0.0000000,0.0000000,0.0000000); //object(indust1las_las) (1)
CreateObject(3636,-666.5000000,831.4000244,15.3999996,0.0000000,0.0000000,0.0000000); //object(indust1las_las) (2)
CreateObject(6930,-505.8999939,924.5999756,25.2999992,0.0000000,0.0000000,152.0000000); //object(vegasplant05) (1)
CreateObject(3637,-626.5000000,893.7999878,15.1999998,0.0000000,0.0000000,332.0000000); //object(indust1las2_las) (1)
CreateObject(2960,-538.7999878,885.2000122,16.5000000,0.0000000,0.0000000,62.0000000); //object(kmb_beam) (1)
CreateObject(2960,-539.2000122,885.5000000,16.5000000,0.0000000,0.0000000,61.9958496); //object(kmb_beam) (2)
CreateObject(2960,-539.9000244,885.4000244,16.5000000,0.0000000,0.0000000,61.9958496); //object(kmb_beam) (3)
CreateObject(2960,-538.5999756,884.5999756,16.5000000,0.0000000,0.0000000,61.9958496); //object(kmb_beam) (4)
CreateObject(2960,-539.4000244,885.0999756,17.0000000,0.0000000,0.0000000,87.9958496); //object(kmb_beam) (5)
CreateObject(2960,-538.7999878,885.7000122,17.0000000,0.0000000,0.0000000,87.9949951); //object(kmb_beam) (6)
CreateObject(2960,-537.9000244,884.5999756,16.5000000,0.0000000,0.0000000,55.9949951); //object(kmb_beam) (7)
CreateObject(3673,-518.4000244,903.2999878,30.7999992,0.0000000,0.0000000,152.0000000); //object(laxrf_refinerybase) (1)
CreateObject(5126,-548.0999756,844.9000244,31.2000008,0.0000000,0.0000000,152.0000000); //object(dockcranescale0) (1)
CreateObject(5126,-533.5999756,873.2000122,31.2000008,0.0000000,0.0000000,151.9958496); //object(dockcranescale0) (2)
CreateObject(3255,-428.3999939,928.2999878,16.1000004,0.0000000,0.0000000,242.0000000); //object(ref_oiltank01) (1)
CreateObject(3255,-447.8999939,938.5000000,16.1000004,0.0000000,0.0000000,241.9958496); //object(ref_oiltank01) (2)
CreateObject(3255,-469.2000122,949.5999756,16.1000004,0.0000000,0.0000000,241.9958496); //object(ref_oiltank01) (3)
CreateObject(3255,-490.0000000,960.5000000,16.1000004,0.0000000,0.0000000,241.9958496); //object(ref_oiltank01) (4)
CreateObject(3361,-476.1000061,967.5999756,13.8999996,0.0000000,0.0000000,61.9918213); //object(cxref_woodstair) (4)
CreateObject(3361,-474.7000122,973.0000000,9.6000004,0.0000000,0.0000000,89.9903564); //object(cxref_woodstair) (4)
CreateObject(3361,-474.7999878,979.2000122,5.5999999,0.0000000,0.0000000,89.9890137); //object(cxref_woodstair) (4)
Create3DTextLabel("Cette maison est cambriolable\ntapez /volmaison pour la voler",orange,2340.3164,-1062.3643,1049.0310,20.0,0,0);
//=====================================[ PICKUPS ]================================================================
market=CreatePickup(1318,2,-19.1569,1175.4562,19.5634,0);
market2=CreatePickup(1318,2,-27.0844,-187.3501,1003.5469,0);
commi2=CreatePickup(1318,2,322.2388,302.9153,999.1484,0);
vestinfo=CreatePickup(1239,2,326.4402,307.1887,999.1484,0);
commi1=CreatePickup(1318,2,-217.8448,979.0904,19.5040,0);
mill=CreatePickup(1254,2,-2189.9485,639.7510,49.4429,0);
ammu2=CreatePickup(1318,2,316.3439,-168.1963,999.5938,0);
ammu1=CreatePickup(1318,2,-315.3720,829.7943,14.2422,0);
pickuprepair=CreatePickup(1239,2,-2274.3418,107.1998,34.7365,0);
pickup2repair=CreatePickup(1239,2,-2274.3418,107.1998,34.7365,0);
autoecole1=CreatePickup(1318,2,-145.2853,1079.0308,20.4922,0);
autoecole2=CreatePickup(1318,2,1494.5181,1303.5819,1093.2891,0);
autoecoleinfo=CreatePickup(1239,2,1492.1539,1305.5914,1093.2964,0);
//===================================[ PICKUPS BANQUE ]=================================================
banque1=CreatePickup(1318,2,-181.6341,1034.9274,19.7422,0);
banque2=CreatePickup(1318,2,2306.1594,-16.3970,26.7496,0);
banque3=CreatePickup(1239,2,2316.6091,-10.2255,26.7422,0);
//=====================================[ PICKUP BAR ]============================================================
bar1=CreatePickup(1318,2,-89.1510,1378.2269,10.4698,0);
bar2=CreatePickup(1318,2,-228.3345,1401.4363,27.7656,0);
bar3=CreatePickup(1239,2,-225.2079,1404.4272,27.7734,0);
//============================[ RADARS ]============================================================
r1=CreateRadar(-2135.3298,-2431.5601,33.5074,328.3731,70,10.0); // Radar Angel-Pine
r2=CreateRadar(-2190.9160,-2178.4009,45.2111,26.3931,130,10.0); // Radar route chiliad
r3=CreateRadar(-2740.9417,-1994.4626,45.5745,325.3922,180,10.0); // Radar Autoroute
//============================[ RADIO ]======================================================================
radiopick=CreatePickup(1239,2,-98.9612,1084.1152,19.7422,0);
//==============================[ MENU ]===============================================================
ammu=CreateMenu("~g~Ammunation",1,125,150,300);
if(IsValidMenu(ammu))
{
SetMenuColumnHeader(ammu , 0, "Choisissez une arme:");
        AddMenuItem(ammu ,0,"Desert Eagle (5.000$)");
	AddMenuItem(ammu ,0,"Mp5 (7.500$)");
	AddMenuItem(ammu ,0,"Ak-47 (15.000$)");
	AddMenuItem(ammu ,0,"Fusil (5.000$)");
	AddMenuItem(ammu,0,"Pistolets (2.500$)");
	AddMenuItem(ammu,0,"Fermer");
	}
	return 1;
}
public Peage2()
{
DestroyObject(p4);
p3=CreateObject(968,-2530.69995117,-2362.89990234,15.19999981,0.00000000,270.00000000,2.00000000);
}
public Peage()
{
DestroyObject(p2);
p1=CreateObject(968,-2455.10009766,-2248.69995117,18.70000076,1.00000000,90.00000000,37.00000000);
}

new Text:charge;
new Text:team;
public OnPlayerConnect(playerid)
{
         Textdraw4[playerid] = TextDrawCreate(149, 381, "_");
        TextDrawFont(Textdraw4[playerid], 1);
        TextDrawLetterSize(Textdraw4[playerid], 0.40000, 1.45000);
        TextDrawColor(Textdraw4[playerid], -1);
        TextDrawSetOutline(Textdraw4[playerid], 0);
        TextDrawSetProportional(Textdraw4[playerid], 1);
        TextDrawSetShadow(Textdraw4[playerid], 1);
        TextDrawUseBox(Textdraw4[playerid], 0);
        TextDrawTextSize(Textdraw4[playerid], 606.000000, 0.000000);
    new message[127];
   GetPlayerName(playerid, message, sizeof(message));
   format(message,sizeof(message), "¤¤¤| {00ffff}%s (ID: %d) a rejoint le serveur ! |¤¤¤",message, playerid);
   SendClientMessageToAll(0x33CC71FF, message);
    SetPlayerWantedLevel(playerid,0);
	SendClientMessage(playerid,jaune , "|||----------Bienvenu sur {ff0000}Angel Pine RP{ffff00}---------||");
	SendClientMessage(playerid,bleu,"Bienvenu sur notre serveur semi-rp Angel Pine RP");
	SendClientMessage(playerid,bleu,"Si tu as besoin l'équipe du staff se fera un plaisir de t'aider ou sinon tu as le /aide à ta disponibilité");
	SendClientMessage(playerid,bleu,"Tu veux savoir le but de ce serveur? Alors tape /but et lis tous");
	SendClientMessage(playerid,bleu,"Tu veux savoir l'équipe du staff de ce serveur? Alors tape /staff et lis tous");
	SendClientMessage(playerid,bleu,"Pour conclure le /credits est à ta disposition au cas où");
	  GetPlayerName(playerid, pseudoinitial[playerid], 50);
	  afk[playerid]=0;
	  briquet[playerid]=0;
	  cigarette[playerid]=0;
	  decodeur[playerid]=0;
	  canne[playerid]=0;
	  poire[playerid]=0;
	  gps[playerid]=0;
	  pomme[playerid]=0;
	  peche[playerid]=0;
	  barrage[playerid]=1;
	  cuff[playerid]=0;
	  prioritaire[playerid]=0;
	  mcagoule[playerid]=0;
	  cagoule[playerid]=0;
	  amende[playerid]=0;
	  casque[playerid]=0;
	  mspawn[playerid]=0;
	  checkcp[playerid]=0;
   GetPlayerName(playerid, pseudoinitial[playerid], 50);
	  SendClientMessage(playerid,jaune,"Dernière Mise à Jour: {ffff00}19/05/2013 //// Pour connaître les news tapez /news");
        SetTimer("PayDay",60000000,true);
        if(fexist(UserPath(playerid)))
    {
        INI_ParseFile(UserPath(playerid), "LoadUser_%s", .bExtra = true, .extra = playerid);
        ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_INPUT,""COL_WHITE"Connection","Bienvenu sur {00cc33}Angel-Pine Semi-RP\n{ffffff}Veuillez vous connecter pour accèder à votre compte","Connexion","Quitter");
    }
    else
    {
        ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_INPUT,""COL_WHITE"Enregistrement","Bienvenu sur {00cc33}Angel-Pine Semi-RP\n{ffffff}Veuillez choisir un mot de passe pour pouvoir accéder au serveur.","Inscription","Quitter");
    }
    team=TextDrawCreate(536,422,"Civils");
    TextDrawColor(team,vert);
    TextDrawFont(team,1);
    TextDrawSetOutline(team , 1);
TextDrawSetProportional(team , 1);
TextDrawSetShadow(team , 1);
TextDrawUseBox(team,1);
TextDrawBoxColor(team,0x000000);
    charge=TextDrawCreate(302,212,"Chargement...");
    TextDrawColor(charge,0x33CC71FF);
    TextDrawFont(charge,3);

		return 1;
		}
public OnPlayerRequestClass(playerid, classid)
{
        SetPlayerPos(playerid,-268.0418,2592.2168,63.5703);
        SetPlayerCameraPos(playerid,-270.7320,2578.0361,86.6255);
        SetPlayerCameraLookAt(playerid,-268.0418,2592.2168,63.5703);
        SetPlayerFacingAngle(playerid,85.8636);
	return 1;
}
public OnPlayerDisconnect(playerid, reason)
{
new Float:health;
new Float:armure;
       new string[256];
       new name[MAX_PLAYER_NAME];
    GetPlayerName(playerid,name,MAX_PLAYER_NAME);
    switch(reason)
    {
        case 0: format(string,sizeof string,"¤¤¤| %s (ID:%d) a quitté le serveur(Déconnection)",name,playerid);
        case 1: format(string,sizeof string,"¤¤¤| %s (ID:%d) a quitté le serveur(Kick/Ban)",name,playerid);
        case 2: format(string,sizeof string,"¤¤¤| %s (ID:%d) a quitté le serveur(Crash/Bug)",name,playerid);
    }
    SendClientMessageToAll(0x33CC71FF,string);
    if(afk[playerid]==1)
    {
    SetPlayerName(playerid, pseudoinitial[playerid]);
    }
       new INI:File = INI_Open(UserPath(playerid));
    INI_SetTag(File,"data");
    INI_WriteInt(File,"Cash",GetPlayerMoney(playerid));
    INI_WriteInt(File,"Kills",PlayerInfo[playerid][pKills]);
    INI_WriteInt(File,"Deaths",PlayerInfo[playerid][pDeaths]);
    INI_WriteInt(File,"Niveau",PlayerInfo[playerid][pNiveau]);
    INI_WriteInt(File,"Santé",GetPlayerHealth(playerid,health));
    INI_WriteInt(File,"Armure",GetPlayerArmour(playerid,armure));
    INI_WriteInt(File,"Casque",PlayerInfo[playerid][pPcasque]);
    INI_WriteInt(File,"GPS",gps[playerid]);
	INI_WriteInt(File,"Briquet",briquet[playerid]);
	INI_WriteInt(File,"Admin Level",PlayerInfo[playerid][pAdmin]);
	INI_WriteInt(File,"Banque",PlayerInfo[playerid][pBanque]);
	INI_WriteInt(File,"Métier",metier[playerid]);
	INI_WriteInt(File,"Permis Voiture",permis[playerid][pVoiture]);
	INI_WriteInt(File,"Permis Moto",permis[playerid][pMoto]);
	INI_WriteInt(File,"Permis Poids Lourd",permis[playerid][pPoidsLourd]);
	INI_WriteInt(File,"Permis Arme",permis[playerid][pArme]);
	INI_WriteInt(File,"Permis Vol",permis[playerid][pVol]);
	INI_WriteInt(File,"Permis Bâteau",permis[playerid][pBateau]);
    INI_Close(File);
    if(duty[playerid]==1)
    {
    pduty--;
	format(string,sizeof(string),"[ANNOUNCE]Il y a maintenant %d policier(s) en service",pduty);
	SendClientMessageToAll(bleu,string);
	}
	return 1;
}
public OnPlayerSpawn(playerid)
{
	if(metier[playerid]==1)
                {
                GiveCInfos(playerid);
                }
                if(metier[playerid]==2)
                {
                GiveSInfos(playerid);
                }
                if(metier[playerid]==3)
				{
				GiveDInfos(playerid);
				}
				if(metier[playerid]==4)
				{
				GivePInfos(playerid);
				}
				if(metier[playerid]==5)
				{
				GivePoInfos(playerid);
				}
				if(metier[playerid]==6)
				{
				GiveChInfos(playerid);
				}
				if(metier[playerid]==7)
				{
				GiveMInfos(playerid);
				}
				if(metier[playerid]==8)
				{
				GivePeInfos(playerid);
				}
				if(metier[playerid]==9)
				{
				GiveIInfos(playerid);
				}
    SetPlayerMapIcon(playerid,3,-319.6008,1048.2404,20.3403,22,rouge);
    SetPlayerMapIcon(playerid,4,-217.8448,979.0904,19.5040,30,bleu);
SetPlayerMapIcon(playerid,7,-315.3720,829.7943,14.2422,6,gris);
SetPlayerMapIcon(playerid,1,-181.6341,1034.9274,19.7422,52,vert);
SetPlayerMapIcon(playerid,2,-19.1569,1175.4562,19.5634,36,rouge);
SetPlayerMapIcon(playerid,5,-145.2853,1079.0308,20.4922,55,bleu);
SetPlayerMapIcon(playerid,6,-89.1510,1378.2269,10.4698,49,gris);
mspawn[playerid]=1;
serv = TextDrawCreate(251, 452, "Angel-Pine Semi-RP");
TextDrawFont(serv , 2);
TextDrawShowForPlayer(playerid,serv);
if(mjoin[playerid]==1)
{
SetPlayerInterior(playerid,2);
if(attaq[playerid]==1)
{
SendClientMessage(playerid,vert,"Tue tous les défenseurs!");
SetPlayerPos(playerid,PosAttaq);
GiveInfosAttaq(playerid);
}
if(def[playerid]==1)
{
SendClientMessage(playerid,vert,"Tue tous les attaquants!");
SetPlayerPos(playerid,PosDef);
GiveInfosDef(playerid);
}
}
// ShowPlayerDialog(playerid,10,DIALOG_STYLE_LIST,"METIER","CAMIONNEUR\nAMBULANCIER\nDELIQUANT\nPILOTE DE LIGNE\nPOLICIER\nCHAUFFEUR DE BUS/TAXI\nMILITAIRE\nPÊCHEUR","PRENDRE","FERMER");
//============================[ BOT]============================================================================
if(!IsPlayerNPC(playerid)) return 0; // Nous Nous occupons seulement des NPC dans se script ne rajouter rien d'autres !!!

	new playername[64];
	GetPlayerName(playerid,playername,64);

 	if(!strcmp(playername,"John",true)) { //Nom de votre enregistrement
        PutPlayerInVehicle(John, John, 0); // Idem
        SetSpawnInfo( John, 1, 255, 1958.33, 1343.12, 15.36, 269.15, 0, 0, 0, 0, 0, 0 ); // Laisser par defaut cela ne changera rien a moins que vous vouliez ^^
        ShowPlayerMarkers(0);
	}
	    if(IsPlayerNPC(playerid))// si le joueur est un BOT
    {
		GetPlayerName(playerid,playername,MAX_PLAYER_NAME);//on récupère sont pseudo
		if(!strcmp(playername,"vend",true))//si sont pseudo est Bruno
		{
			SetPlayerSkin(playerid,0);//je désir lui mettre le skin 0
		}
	}
	if(metier[playerid]==1)
                {
                GiveCInfos(playerid);
                }
                if(metier[playerid]==2)
                {
                GiveSInfos(playerid);
                }
                if(metier[playerid]==3)
				{
				GiveDInfos(playerid);
				}
				if(metier[playerid]==4)
				{
				GivePInfos(playerid);
				}
				if(metier[playerid]==5)
				{
				GivePoInfos(playerid);
				}
				if(metier[playerid]==6)
				{
				GiveChInfos(playerid);
				}
				if(metier[playerid]==7)
				{
				GiveMInfos(playerid);
				}
				if(metier[playerid]==8)
				{
				GivePeInfos(playerid);
				}
		return 1;
  }
public OnPlayerDeath(playerid, killerid, reason)
{
if(mjoin[killerid]==1 && mjoin[playerid]==1)
{
if(attaq[killerid]==1 && def[playerid]==1)
{
AddPointAttaq();
RemovePointDef();
SendClientMessage(killerid,rouge,"Ennemi tué avec succès +1 point");
SendClientMessage(playerid,jaune,"Tu t'es fait tué -1 point");
}
if(def[killerid]==1 && attaq[playerid]==1)
{
AddPointDef();
RemovePointAttaq();
SendClientMessage(killerid,rouge,"Ennemi tué avec succès +1 point");
SendClientMessage(playerid,jaune,"Tu t'es fait tué -1 point");
}
}
new name[MAX_PLAYER_NAME];
	new string[256];
	new deathreason[20];
	GetPlayerName(playerid, name, sizeof(name));
	GetWeaponName(reason, deathreason, 20);
if(duty[playerid]==1)
{
pduty--;
format(string,sizeof(string),"[ANNOUNCE]Il y a maintenant %d policiers en service",pduty);
SendClientMessageToAll(bleu,string);
duty[playerid]=0;
}

	if (killerid == INVALID_PLAYER_ID) {
	    switch (reason) {
			case WEAPON_DROWN:
			{
                format(string, sizeof(string), "%s vient de se noyer dans l'eau", name);
                ProxDetector(30.0,playerid,string,orange,orange,orange,orange,orange);
                printf("%s s'est noyé",name);
                format(string, sizeof(string), "[SPEC]%s s'est noyé", name);
                SendAdminMessage(playerid,string,0);
			}
			default:
			{
			    if (strlen(deathreason) > 0) {
					format(string, sizeof(string), "%s vient de mourrir (%s)", name, deathreason);
					ProxDetector(30.0,playerid,string,orange,orange,orange,orange,orange);
                    printf("%s vient de mourrir Raison: %s",name,deathreason);
                    format(string, sizeof(string), "[SPEC]%s vient de mourrir Raison: %s", name,deathreason);
                    SendAdminMessage(playerid,string,0);
				}
			}
		}
	}
	else {
	new killer[MAX_PLAYER_NAME];
	GetPlayerName(killerid, killer, sizeof(killer));
	if (strlen(deathreason) > 0) {
		format(string, sizeof(string), "%s a abattu %s au %s", killer, name, deathreason);
		ProxDetector(30.0,playerid,string,orange,orange,orange,orange,orange);
        printf("%s a tué %s (%s) ",killer,name,deathreason);
        format(string, sizeof(string), "[SPEC]%s a tué %s (%s)",killer, name,deathreason);
        SendAdminMessage(playerid,string,0);
		} else {
				format(string, sizeof(string), "%s a abattu %s", killer, name);
				ProxDetector(30.0,playerid,string,orange,orange,orange,orange,orange);
    printf("%s a tué %s",killer,name);
        format(string, sizeof(string), "[SPEC]%s a tué %s",killer, name);
        SendAdminMessage(playerid,string,0);
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
carcasse=vehicleid;
GetVehiclePos(vehicleid,a1,a2,a3);
SetTimer("Carcasse",7000,false);
	return 1;
}

public OnPlayerText(playerid, text[])
{
if(mspawn[playerid]==0) return SendClientMessage(playerid,orange,"Pour parler vous devez spawner");
{
new pname[256];
GetPlayerName(playerid,pname,sizeof(pname));
new astring[256];
	    format(astring, sizeof(astring), "%s dit: %s",pname,text);
	    ProxDetector(30.0, playerid, astring, BLANC, BLANC, BLANC, BLANC, BLANC);
	    format(astring,sizeof(astring),"[SPEC]Canal RP %s: %s ",pname,text);
	    SendAdminMessage(playerid,astring,0);
	    }
			return 0;
}
public Chargement(playerid)
{
TextDrawHideForPlayer(playerid,charge);
TogglePlayerControllable(playerid,1);
GameTextForPlayer(playerid,"~g~ CHARGEMENT TERMINE",2500,5);
}
public OnPlayerCommandText(playerid, cmdtext[])
{
new girophare;
new string[1000];
  new pname[256];
  new vehicleid=GetPlayerVehicleID(playerid);
  new playermoney;
	new sendername[MAX_PLAYER_NAME];
	new giveplayer[MAX_PLAYER_NAME];
	new cmd[256];
	new giveplayerid, moneys, idx;
	cmd = strtok(cmdtext, idx);
	for(new i = 0; i < MAX_PLAYERS; i++)
    {
  	if(strcmp("/news",cmdtext,true) ==0)
  	{
  	SendClientMessage(playerid,rose,"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~NEWS ANGEL PINE RP du 19/05/2013~~~~~~~~~~~~~~~~~~~~~~");
	SendClientMessage(playerid,bleu,"-Debug du système permis");
	SendClientMessage(playerid,bleu,"-Ajout d'un système d'annonce RP.");
	SendClientMessage(playerid,bleu,"");
	SendClientMessage(playerid,bleu,"");
  	SendClientMessage(playerid,rose,"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
  	return 1;
	}
	if(strcmp("/anews",cmdtext,true) ==0)
  	{
  	if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid,rouge,"Vous n'êtes pas admin pour pouvoir utiliser cette commande");
  	{
  	SendClientMessage(playerid,rose,"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~NEWS ADMIN ANGEL PINE RP du 17/05/2013~~~~~~~~~~~~~~~~~~~~~~");
	SendClientMessage(playerid,bleu,"-Ajout d'une commande /rendrealcoolique pour régler le taux d'alcoolémie d'un joueur.");
	SendClientMessage(playerid,bleu,"-Ajout d'un système de conversation entre un admin et un joueur (/aideapm)");
	SendClientMessage(playerid,bleu,"-Debug de quelques commandes admins (Text raison)                           ");
  	SendClientMessage(playerid,rose,"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
  	}
  	return 1;
	}
	if(strcmp("/aideapm",cmdtext,true)==0)
	{
	if(!IsPlayerAdmin(playerid))
	{
	SendClientMessage(playerid,gris,"Bienvenue dans l'interface APM (Admin Private Message) vous trouverez ci-dessous surement les réponses à vos questions.");
	SendClientMessage(playerid,gris,"Une conversation est engagée dès lorsqu'un administrateur l'engage.");
	SendClientMessage(playerid,gris,"Vous pouvez répondre à ce message à l'aide de /repond , actif que pendant que la conversation n'est pas arêtée par l'administrateur");
	}
	else
	{
	SendClientMessage(playerid,gris,"Bienvenue dans l'interface APM (Admin Private Message) vous trouverez ci-dessous surement les réponses à vos questions.");
	SendClientMessage(playerid,gris,"Une conversation est engagée dès lorsque vous utilisez la commande /apm.");
	SendClientMessage(playerid,gris,"Vous pouvez alors arrêter la conversation à l'aide de /stopconvers.");
	}
	return 1;
	}
	if(strcmp("/buylevel",cmdtext,true)==0)
	{
	if(GetPlayerMoney(playerid)<200000) return SendClientMessage(playerid,rouge,"Vous n'avez pas assez d'argent pour vous payer un level (200.000$ requis)");
	{
	SendClientMessage(playerid,vert,"Vous avez acheté un level! Tapez /level pour voir le niveau que vous avez");
	PlayerInfo[playerid][pLevel]++;
	SetPlayerScore(playerid,GetPlayerScore(playerid)+1);
	GivePlayerMoney(playerid,-200000);
	GetPlayerName(playerid,pname,sizeof(pname));
	printf("%s a acheté un level",pname);
	}
	return 1;
	}
	if(strcmp("/level",cmdtext,true)==0)
	{
	format(string,sizeof(string),"Vous êtes Niveau: %d ",PlayerInfo[playerid][pLevel]);
	SendClientMessage(playerid,vert,string);
	return 1;
	}
	if(strcmp("/rdvrules",cmdtext,true)==0)
	{
	ShowPlayerDialog(playerid,-55,DIALOG_STYLE_MSGBOX,"Interface Règles de rendez-vous","Bienvenue dans l'interface des règles de rendez-vous\nLes rendez-vous doivent être utilisés à bon escient et non inutillement.\nIl est conseillé d'avoir eu des échanges SMS entre le client et vous-même.\nEn acceptant lançant un rendez-vous , vous acceptez le dévoilement de votre position ainsi que les divers actes qui peuvent être commis par votre client.","OK","FERMER");
	return 1;
	}
		if(strcmp(cmd, "/sabot", true) == 0) // By LordMan
	{
	    if(IsPlayerConnected(playerid))
	    {
	        if(metier[playerid]==5)
	        {
			    new counter = 0;
			    new plyName[MAX_PLAYER_NAME];
			    GetPlayerName(playerid, plyName, MAX_PLAYER_NAME);
			        new dist = CheckPlayerDistanceToVehicle(3.5, playerid, i);
			        if(dist)
			        {
			        new result;
			            result=i;
			            counter++;
			        }
			    switch(counter)
			    {
			        case 0:
			        {
			            SendClientMessage(playerid, rouge, "Aucun véhicule n'est prêt de vous.");
			        }

			        case 1:
			        {
			            if(IsPlayerInAnyVehicle(playerid))
      					{
			                SendClientMessage(playerid, rouge, "Commande impossible en véhicule");
			            	return 1;
               			}
						vehsabot[vehicleid] = 1;
               			GetPlayerName(playerid, sendername, sizeof(sendername));
                        format(string, sizeof(string), " %s met un sabot dans les roues du véhicules.", sendername);
                  		ProxDetector(30.0, playerid, string, jaune,jaune,jaune,jaune,jaune);
						return 1;
			        }

			        default:
			        {
			            SendClientMessage(playerid, rouge, "Véhicule trop près des autres.");
			            return 1;
			        }
			    }
			    return 1;
			}
			}
	    return 1;
	}

 if(strcmp(cmd, "/barrage", true) == 0)
	{
	new msgradio[256];
  	new msgspeca[256];
	if(metier[playerid]<5 || metier[playerid]>5) return SendClientMessage(playerid,rouge,"Vous n'êtes pas policier pour pouvoir déployé un barrage");
	{
	if(barrage[playerid]>5) return SendClientMessage(playerid,rouge,"Vous avez dépassé la limite de barrage (5) ");
	{
		new Float:X, Float:Y, Float:Z, Float:A;
		GetPlayerName(playerid,pname,sizeof(pname));
		GetPlayerPos(playerid, X, Y, Z);
		GetPlayerFacingAngle(playerid, A);
		CreateObject(981, X, Y, Z, 0.0, 0.0, A+180);
		SetPlayerPos(playerid, X, Y, Z+4);
		SendClientMessage(playerid, vert, "Barage placé avec succès");
		printf("Officier %s a déployé un barrage",pname);
		format(msgspeca,sizeof(msgspeca),"[SPEC]Officier %s a déployé un barrage",pname);
		SendAdminMessage(playerid,msgspeca,0);
		format(msgradio,sizeof(msgradio),"[RADIO]Officier %s a déployé un barrage",pname);
		SendRadioPolice(playerid,msgradio,0);
		barrage[playerid]++;
		}
		}
		return 1;
	}
if(strcmp(cmdtext, "/sauver", true) == 0)
{
if(accident==1)
if(metier[playerid]==2)
if(IsPlayerInRangeOfPoint(playerid,8.0,-1877.0603,-1706.9952,21.7500))
{
DisablePlayerCheckpoint(playerid);
SendClientMessage(playerid,vert,"Vous avez secouru la personne avec succès vous avez gagner 1500$");
GivePlayerMoney(playerid,1500);
mission[playerid]=0;
accident=0;
	DestroyVehicle(veh1);
	DestroyVehicle(veh2);
	DestroyVehicle(veh3);
	DestroyVehicle(veh4);
	DestroyVehicle(veh5);
	DestroyVehicle(veh6);
	}
	else if(accident==0)
	{
	SendClientMessage(playerid,rouge,"Aucun accident s'est produit récemment");
	}
 else if(!IsPlayerInRangeOfPoint(playerid,8.0,-1877.0603,-1706.9952,21.7500))
 {
SendClientMessage(playerid,rouge,"Vous n'êtes pas à l'accident pour secourir la personne");
}
else if(metier[playerid]<2 || metier[playerid]>2)
{
SendClientMessage(playerid,rouge,"Vous n'êtes pas secouriste pour pouvoir intervenir");
 }
return 1;
}
    if (strcmp("/kill", cmdtext, true) == 0)
{
 SendClientMessage(playerid,orange,"La commande que vous recherchez est /mort");
return 1;
}
if(strcmp("/reboot",cmdtext,true)==0)
{
if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid,rouge,"Vous n'êtes pas admin pour pouvoir utiliser cette commande");
{
ShowPlayerDialog(playerid,18,DIALOG_STYLE_LIST,"TEMPS DU REBOOT"," MAINTENANT \n 30 SECONDES \n 1 MINUTE \n 2 MINUTES \n 5 MINUTES \n 10 MINUTES","REBOOT","ANNULER");
SendClientMessage(playerid,vert,"Veuillez choisir le temps quand le reboot débutera");
GetPlayerName(playerid,pname,sizeof(pname));
}
return 1;
}
if(strcmp("/passerpermis",cmdtext,true)==0)
{
if(!IsPlayerInRangeOfPoint(playerid,5.0,1492.1539,1305.5914,1093.2964)) return SendClientMessage(playerid,rouge,"Vous n'êtes pas à l'auto-école!");
{
ShowPlayerDialog(playerid,964,DIALOG_STYLE_LIST,"PERMIS","Voiture\nMoto\nPoids Lourd\nArme(EN CONSTRUCTION)\nVol(EN CONSTRUCTION)\nBÂTEAU(EN CONSTRUCTION)","CHOISIR","FERMER");
SendClientMessage(playerid,vert,"Choisissez le type de permis que vous voulez passer");
}
return 1;
}
if(strcmp(cmdtext,"/banque",true)==0)
{
if(!IsPlayerInRangeOfPoint(playerid,10.0,2316.6091,-10.2255,26.7422)) return SendClientMessage(playerid,rouge,"Vous n'êtes pas devant les guichets de la banque");
{
format(string,sizeof(string),"Vous avez %d$ à votre banque",PlayerInfo[playerid][pBanque]);
SendClientMessage(playerid,gris,string);
}
return 1;
}
if(strcmp(cmdtext,"/manger",true)==0)
{
SendClientMessage(playerid,vert,"Choisissez l'aliment que vous souhaitez manger");
format(string,sizeof(string),"Pomme (%d)\nPoire (%d)\nPêche (%d)",pomme[playerid],poire[playerid],peche[playerid]);
ShowPlayerDialog(playerid,900,DIALOG_STYLE_LIST,"Inventaire Nourriture",string,"MANGER","FERMER");
return 1;
}
	if(strcmp(cmd, "/deposer", true) == 0)
	{
	new tmp[256];
	new cashdeposit=strval(tmp);
	    if(IsPlayerConnected(playerid))
	    {
	    	if(!IsPlayerInRangeOfPoint(playerid,10.0,2316.6091,-10.2255,26.7422)) return SendClientMessage(playerid,rouge,"Vous n'êtes pas devant les guichets de la banque");
	    	{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
			format(string,sizeof(string),"Vous avez %d$ sur vous",GetPlayerMoney(playerid));
			SendClientMessage(playerid,gris,string);
			}
			if (cashdeposit > GetPlayerMoney(playerid)) return SendClientMessage(playerid, rouge, "Vous n'avez pas cette somme sur vous.");
			{
			GivePlayerMoney(playerid,-cashdeposit);
			new curfunds = PlayerInfo[playerid][pBanque];
			PlayerInfo[playerid][pBanque]=cashdeposit+PlayerInfo[playerid][pBanque];
			SendClientMessage(playerid, orange, "|___________ Dépot Compte banquaire ___________|");
			format(string, sizeof(string), "Argent sur le compte avant le dépot: %d$", curfunds);
			SendClientMessage(playerid, jaune, string);
			format(string, sizeof(string), "Argent déposé: %d$",cashdeposit);
			SendClientMessage(playerid, jaune, string);
			format(string, sizeof(string), "Argent sur le compte après le dépot: %d$", PlayerInfo[playerid][pBanque]);
			SendClientMessage(playerid, jaune, string);
			return 1;
		}
		}
		}
		return 1;
	}
	   if(strcmp(cmd, "/retirer", true) == 0)
	{
	new tmp[256];
	    if(IsPlayerConnected(playerid))
	    {
	    	if(!IsPlayerInRangeOfPoint(playerid,10.0,2316.6091,-10.2255,26.7422)) return SendClientMessage(playerid,rouge,"Vous n'êtes pas devant les guichets de la banque");
	    	{
				tmp = strtok(cmdtext, idx);
				new cashdeposit = strval(tmp);
				if(!strlen(tmp))
				{
					format(string, sizeof(string), "  Vous avez $%d sur votre compte banquaire.", PlayerInfo[playerid][pBanque]);
					SendClientMessage(playerid, gris, string);
					return 1;
				}
				if (cashdeposit > PlayerInfo[playerid][pBanque] || cashdeposit < 1)
				{
					SendClientMessage(playerid, rouge, "   Vous n'avez pas cette somme sur vous.");
					return 1;
				}
		    	//ConsumingMoney[playerid] = 1;
		    	new account=PlayerInfo[playerid][pBanque];
				GivePlayerMoney(playerid,cashdeposit);
				PlayerInfo[playerid][pBanque]=PlayerInfo[playerid][pBanque]-cashdeposit;
				SendClientMessage(playerid,orange,"|______________Retrait du compte banquaire______________|");
				format(string,sizeof(string),"Argent sur le compte avant le retrait: %d$",account);
				SendClientMessage(playerid,jaune,string);
				format(string,sizeof(string),"Argent retiré: %d$",cashdeposit);
				SendClientMessage(playerid,jaune,string);
				format(string,sizeof(string),"Argent sur le compte après le retrait: %d$",PlayerInfo[playerid][pBanque]);
				SendClientMessage(playerid,jaune,string);
				return 1;
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/makemetier", true) == 0 || strcmp(cmd,"/donnermetier",true)==0 || strcmp(cmd,"/metier",true)==0)
	{
	new tmp[256];
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, orange, "Utilisation: /donner(metier) [Id/Pseudo] [Id Metier]");
				SendClientMessage(playerid,gris,"1: Camionneur, 2: Secouriste, 3: Délinquant, 4: Pilote de Ligne\n5: Policier, 6: Chauffeur de bus/taxi, 7: Militaire, 8: Pêcheur, 9: Instructeur");
				return 1;
			}
			new para1;
			new nmetier;
			new anivt[256];
			para1 = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			nmetier = strval(tmp);
			if(IsPlayerAdmin(playerid))
			{
				    if(IsPlayerConnected(para1))
				    {
				        if(para1 != INVALID_PLAYER_ID)
				        {
				        if(nmetier==0)
				        {
						anivt="Chomeur";
						}
						else if(nmetier==1)
						{
						anivt="Camionneur";
						GiveCInfos(para1);
						}
						else if(nmetier==2)
						{
						anivt="Secouriste";
						GiveSInfos(para1);
						}
						else if(nmetier==3)
						{
						anivt="Délinquant";
						GiveDInfos(para1);
						}
						else if(nmetier==4)
						{
						anivt="Pilote de Ligne";
						GivePInfos(para1);
						}
						else if(nmetier==5)
						{
						anivt="Policier";
						GivePoInfos(para1);
						}
						else if(nmetier==6)
						{
						anivt="Chauffeur de bus/taxi";
						GiveChInfos(para1);
						}
						else if(nmetier==7)
						{
						anivt="Militaire";
						GiveMInfos(para1);
						}
						else if(nmetier==8)
						{
						anivt="Pêcheur";
						GivePeInfos(para1);
						}
						else if(nmetier==9)
						{
						anivt="Instructeur";
						GiveIInfos(para1);
						}

							GetPlayerName(para1, giveplayer, sizeof(giveplayer));
							GetPlayerName(playerid, sendername, sizeof(sendername));
							metier[para1]= nmetier;
							printf("Admin %s a mis %s %s.", sendername, giveplayer, anivt);
							format(string, sizeof(string), "{ffff00}[INFO]{cccccc}L'Admin vous a mis {00ffff}%s", anivt);
							SendClientMessage(para1, orange, string);
							format(string, sizeof(string), "Vous avez bien mis %s %s", giveplayer,anivt);
							SendClientMessage(playerid, jaune, string);
						}
					}
			}
			else
			{
				SendClientMessage(playerid, rouge, "Vous n'êtes pas autorisé à utiliser cette commande!");
			}
		}
		return 1;
	}
	
	
	
if(strcmp(cmd, "/donnerargent", true) == 0 || strcmp(cmd,"/payer",true)==0 || strcmp(cmd,"/givecash",true)==0)
{
	    new tmp[256];
	    new msgspeca[256];
		tmp = strtok(cmdtext, idx);

		if(!strlen(tmp)) {
			SendClientMessage(playerid, jaune, "Utilisation: /payer [playerid] [argent]");
			return 1;
		}
		giveplayerid = strval(tmp);

		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) {
			SendClientMessage(playerid, jaune, "Utilisation: /payer [playerid] [argent]");
			return 1;
		}
 		moneys = strval(tmp);

		//printf("givecash_command: %d %d",giveplayerid,moneys);


		if (IsPlayerConnected(giveplayerid))
		{
			GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			playermoney = GetPlayerMoney(playerid);
			if (moneys > 0 && playermoney >= moneys)
			{
			if(!ProxDetectorS(5.0,playerid,giveplayerid)) return SendClientMessage(playerid,orange,"Vous devez vous rapprochez de cette personne pour pouvoir lui donner de l'argent");
			{
				GivePlayerMoney(playerid, (0 - moneys));
				GivePlayerMoney(giveplayerid, moneys);
				format(string, sizeof(string), "Vous avez donné à %s (ID:%d) %d $", giveplayer,giveplayerid, moneys);
				SendClientMessage(playerid, jaune, string);
				format(string, sizeof(string), "Vous recevez %d $ de la part de %s (ID:%d)", moneys, sendername, playerid);
				SendClientMessage(giveplayerid, vert, string);
				printf("%s(ID:%d) a transféré %d $ à %s (ID:%d)",sendername, playerid, moneys, giveplayer, giveplayerid);
				format(string, sizeof(string), "%s sort une liasse de billets et la donne à %s",giveplayer,sendername);
                ProxDetector(30.0, playerid, string, jaune, jaune,jaune,jaune,jaune);
				format(msgspeca,sizeof(msgspeca),"[SPEC]%s a donné %d$ à %s",sendername,moneys,giveplayer);
				SendAdminMessage(playerid,msgspeca,0);
			}
			}
			else {
				SendClientMessage(playerid, rouge, "Vous n'avez pas assez d'argent pour lui donner la somme voulue");
			}
		}
		else {
				format(string, sizeof(string), "ID:%d est invalide", giveplayerid);
				SendClientMessage(playerid, rouge, string);
			}
		return 1;
	}
		if(strcmp(cmdtext, "/but", true)== 0)
	{
		ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "BUT DU SERVEUR", "Ce serveur est un Semi-RP.\nEssayez de devenir le plus riche et en profiter à maximum \n ", "OK", "OK");
		return 1;
	}
		if(strcmp(cmdtext, "/credits", true)== 0)
	{
		ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "LES CREDITS", "GM entièrement scripté par Dim_Jhonny avec au niveau mapping de Bender_Jhonny.", "OK", "OK");
		return 1;
	}
		if(strcmp(cmdtext, "/staff", true)== 0)
	{
		ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX,"LISTE DU STAFF ","{ff0000}Scripteur: {00ffff}Dim_Jhonny \n {ff0000}Mappeur: {00ffff}Bender_Jhonny \n {ff0000}Admins: {00ffff}Sylar,Alex_Jhonny","OK","OK");
		return 1;
	}
if (strcmp(cmdtext,"/mort", true)== 0)
{
new msgspeca[256];
new msgannounce[256];
SetPlayerHealth(playerid,0);
SendClientMessage(playerid,rouge,"Vous vous êtes tué");
GameTextForPlayer(playerid,"~r~ TU AS FAIT UN ARRET CARDIAQUE LOL!!!",5000,5);
GetPlayerName(playerid, pname, sizeof (pname));
format(msgannounce,sizeof(msgannounce),"%s vient de faire un arrêt cardiaque",pname);
ProxDetector(30.0,playerid,msgannounce,orange,orange,orange,orange,orange);
printf("%s s'est suicidé à l'aide de la commande /mort",pname);
format(msgspeca,sizeof(msgspeca),"[SPEC]%s s'est suicidé à l'aide de la commande /mort",pname);
SendAdminMessage(playerid,msgspeca,0);
if(attaq[playerid]==1)
{
SendClientMessage(playerid,jaune,"En te suicidant tu as fait perdre 1 point à ton équipe");
RemovePointAttaq();
}
if(def[playerid]==1)
{
SendClientMessage(playerid,jaune,"En te suicidant tu as fait perdre 1 point à ton équipe");
RemovePointDef();
}
return 1;
}
if(strcmp(cmdtext,"/acheter",true)== 0)
{
if(!IsPlayerInRangeOfPoint(playerid,2.0,-10.3536,-177.9040,1003.5469)) return SendClientMessage(playerid,rouge,"Vous n'êtes pas dans le checkpoint du 24/7 pour acheter des articles");
{
SendClientMessage(playerid,vert,"Veuillez choisir vos articles voulus");
ShowPlayerDialog(playerid,21,DIALOG_STYLE_LIST,"24/7 CAISSE","BRIQUET (5$)\nCIGARETTE (10$)\nDECODEUR (500$)\nCANNE A PECHE (25$)\nTOM TOM (200$)\nPOIRE(2$)\nPOMME (2$)\nPÊCHE (1$)\nCAGOULE (100$)\nCASQUE (150$)","Acheter","Fermer");
}
return 1;
}
if(strcmp(cmdtext,"/mjload",true)==0)
{
if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid,rouge,"Vous n'êtes pas admin pour pouvoir utiliser cette commande");
{
if(mjload==1) return SendClientMessage(playerid,rouge,"Un mini-jeu est déjà lancé");
{
mjload=1;
mjjoin=1;
SendClientMessageToAll(jaune,"Le Mini-Jeu TDM a été lancé par l'admin, pour le rejoindre tapez /join");
format(string,sizeof(string),"[SPEC]Admin %s a lancé le mini-jeu");
SendAdminMessage(playerid,string,0);
SendClientMessage(playerid,vert,"Mini jeu lancé avec succès. Pour pouvoir le débuter tapez /startmj");
}
}
return 1;
}
if(strcmp(cmdtext,"/startmj",true)==0)
{
if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid,rouge,"Vous n'êtes pas admin pour pouvoir utiliser cette commande");
{
if(mjload==0) return SendClientMessage(playerid,rouge,"Vous n'avez load aucun mini-jeu");
{
if(mjjoin==0) return SendClientMessage(playerid,rouge,"Le mini-jeu est déjà lancé");
{
if(mjoin[i]==1)
{
mjjoin=0;
TogglePlayerControllable(i,1);
SendClientMessage(i,vert,"Le mini-jeu a débuté tuez le maximum de personne");
}
}
}
}
return 1;
}
if(strcmp(cmdtext,"/join",true)==0)
{
if(mjload==0) return SendClientMessage(playerid,rouge,"Aucun mini-jeu n'est lancé");
{
if(mjjoin==0) return SendClientMessage(playerid,rouge,"Le mini-jeu a déjà commencé");
{
if(mjoin[playerid]==1) return SendClientMessage(playerid,rouge,"Vous êtes déjà en mini-jeu");
{
ShowPlayerDialog(playerid,98,DIALOG_STYLE_LIST,"TEAMS DU MINI JEU","{ff0000}ATTAQUANTS\n{0000ff}DEFENSEURS","PRENDRE","QUITTER");
SendClientMessage(playerid,bleu,"Prenez la team du mini-jeu que vous voulez choisir");
mjoin[playerid]=1;
}
}
}
return 1;
}
if(strcmp(cmdtext,"/endmj",true)==0)
{
if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid,rouge,"Vous n'êtes pas admin pour pouvoir utiliser cette commande");
{
if(mjload==0) return SendClientMessage(playerid,rouge,"Aucun mini-jeu n'est load");
{
if(mjoin[i]==1)
{
SendClientMessage(i,jaune,"Le mini-jeu a été arrêté par l'Admin excusez-nous pour l'éventuel dérangement causé");
TogglePlayerControllable(i,1);
mjoin[i]=0;
mjload=0;
mjjoin=0;
SpawnPlayer(i);
}
}
}
return 1;
}
                new rando = random(sizeof(essence));
                new rando1 = random(sizeof(habit));
				new rando2 = random(sizeof(pilote));
				new rando3 = random(sizeof(secour));
				new rando5 = random(sizeof(passager));

if (strcmp("/essence", cmdtext, true)==0)
{
if(IsPlayerInRangeOfPoint(playerid,100.0,-2104.9915,-2245.0149,31.6315))
{
if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 403 || GetVehicleModel(GetPlayerVehicleID(playerid)) == 515)
{
if(!IsTrailerAttachedToVehicle(vehicleid)) return SendClientMessage(playerid,rouge,"Aucune remorque n'est attachée à votre camion");
{
mission[playerid]= 1;
ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "MISSION ESSENCE", " {0066cc}Tu as commencé une mission camionneur va au checkpoint indiquer sur ta map puis une fois dessus revient à la base et retape /essence", "OK", "OK");
SetPlayerCheckpoint(playerid,essence[rando][0],essence[rando][1],essence[rando][2],3.0);
}
}
}
else if(!GetVehicleModel(GetPlayerVehicleID(playerid) == 403) || GetVehicleModel(GetPlayerVehicleID(playerid) == 515))
{
SendClientMessage(playerid,rouge,"Vous n'êtes pas dans un camion et équipé d'une remorque pour utiliser cette commande");
}
else if(!IsPlayerInRangeOfPoint(playerid,100.0,-2104.9915,-2245.0149,31.6315))
{
SendClientMessage(playerid,rouge,"Vous n'êtes pas à la base pour commencer une mission prenez une remorque et retappez la commande");
}
return 1;
}
if(strcmp(cmdtext,"/duty",true)==0 || strcmp(cmdtext,"/service",true)==0)
{
if(metier[playerid]<5 || metier[playerid]>5) return SendClientMessage(playerid,rouge,"Vous n'êtes pas policier pour pouvoir utiliser cette commande");
{
if(duty[playerid]==1) return SendClientMessage(playerid,rouge,"Vous êtes déjà en service");
{
if(!IsPlayerInRangeOfPoint(playerid,4.0,326.4402,307.1887,999.1484)) return SendClientMessage(playerid,rouge,"Vous n'êtes pas aux vestiaires");
{
duty[playerid]=1;
pduty++;
format(string,sizeof(string),"[ANNOUNCE]Il y a maintenant %d policiers en service",pduty);
SendClientMessageToAll(bleu,string);
SetPlayerArmour(playerid,100);
GivePlayerWeapon(playerid,24,100);
GivePlayerWeapon(playerid,25,50);
SetPlayerAttachedObject( playerid, 5, 19142, 1, 0.1, 0.039999, 0.000000, 2.459999, 0.0, -3.100000, 1, 1, 1);
}
}
}
return 1;
}
if(strcmp("/bus", cmdtext,true)==0)
{
if(GetVehicleModel(GetPlayerVehicleID(playerid))== 437)
if(metier[playerid]== 6)
{
SendClientMessage(playerid,vert,"Vous avez commencé votre mission bus");
SetPlayerCheckpoint(playerid,passager[rando5][0],passager[rando5][1],passager[rando5][2],3.0);
mission[playerid]=1;
}
else if(!GetVehicleModel(GetPlayerVehicleID(playerid)== 420))
{
SendClientMessage(playerid,rouge,"Vous n'êtes pas dans un bus pour commencer la mission");
}
else if(metier[playerid] <6 || metier[playerid]>6)
{
SendClientMessage(playerid,rouge,"Vous n'êtes pas Chauffeur de bus/taxi pour commencer cette mission");
}
return 1;
}
if(strcmp("/test",cmdtext,true)==0)
{
SetPlayerHealth(playerid,85);
return 1;
}
/*
if(strcmp("/taxi", cmdtext,true)==0)
{
if(GetVehicleModel(GetPlayerVehicleID(playerid))== 420)
if(metier[playerid]== 6)
{
SendClientMessage(playerid,vert,"Vous avez commencé votre mission taxi");
SetPlayerCheckpoint(playerid,passager[rando5][0],passager[rando5][1],passager[rando5][2],3.0);
mission[playerid]=1;
}
else if(!GetVehicleModel(GetPlayerVehicleID(playerid)== 420))
{
SendClientMessage(playerid,rouge,"Vous n'êtes pas dans un bus pour commencer la mission");
}
else if(metier[playerid] <6 || metier[playerid]>6)
{
SendClientMessage(playerid,rouge,"Vous n'êtes pas Chauffeur de bus/taxi pour commencer cette mission");
}
return 1;
}
*/
if(strcmp("/armes",cmdtext,true)==0)
{
if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid,rouge,"Vous n'êtes pas admin pour pouvoir utiliser cette commande");
{
SendClientMessage(playerid,vert,"Veuillez choisir votre classe d'armes voulue");
ShowPlayerDialog(playerid,2,DIALOG_STYLE_LIST,"CLASSE ARMES"," ARMES DE POING \n ARMES BLANCHES \n USTENSILES \n EXPLOSIFS \n PISTOLETS \n FUSILS \n ARMES AUTOMATIQUES \n ARMES DE GUERRE \n FUSILS D'ASSAUT \n ARMES MILITAIRES \n OBJETS \n OBJETS MILITAIRES","ALLER","ANNULER");
}
return 1;
}
/*if(strcmp("/peage",cmdtext,true)==0)
{
new msgspeca[256];
if(GetPlayerMoney(playerid)<500) return SendClientMessage(playerid,rouge,"Vous n'avez pas 500$ pour payer le péage");
{
if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,rouge,"Vous n'êtes pas dans un véhicule pour payer le péage");
{
if(!IsPlayerInRangeOfPoint(playerid,10.0,-2450.0513,-2248.9097,18.1239) || !IsPlayerInRangeOfPoint(playerid,10.0,-2534.2456,-2359.8513,14.9891)) return SendClientMessage(playerid,rouge,"Vous n'êtes pas au péage pour pouvoir le payer"); 
{
if(GetPlayerVehicleSeat(playerid)>0) return SendClientMessage(playerid,rouge,"Vous n'êtes pas conducteur pour pouvoir payer le péage");
{
SendClientMessage(playerid,vert,"Vous avez payé l'autoroute à 500$ Bonne Route et soyez prudents");
GivePlayerMoney(playerid,-500);
DestroyObject(p1);
p2=CreateObject(968,-2455.00000000,-2248.69995117,18.70000076,0.00000000,0.00000000,37.00000000);
SetTimer("Peage",5000,false);
printf("%s a payé le péage N°1",pname);
format(msgspeca,sizeof(msgspeca),"[SPEC]%s a payé le péage N°1",pname);
SendAdminMessage(playerid,msgspeca,0);
}
}
}
}
if(GetPlayerMoney(playerid)<500) return SendClientMessage(playerid,rouge,"Vous n'avez pas 500$ pour payer le péage");
{
if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,rouge,"Vous n'êtes pas dans un véhicule pour payer le péage");
{
if(GetPlayerVehicleSeat(playerid)>0) return SendClientMessage(playerid,rouge,"Vous n'êtes pas conducteur pour pouvoir payer le péage");
{
SendClientMessage(playerid,vert,"Vous avez payé l'autoroute à 500$ Bonne Route et soyez prudents");
GivePlayerMoney(playerid,-500);
DestroyObject(p3);
SetTimer("Peage2",5000,false);
printf("%s a payé le péage N°1",pname);
format(msgspeca,sizeof(msgspeca),"[SPEC]%s a payé le péage N°1",pname);
SendAdminMessage(playerid,msgspeca,0);
}
}
}
return 1;
}
*/

 if(strcmp(cmd, "/menotter", true)==0||strcmp(cmd, "/men", true) ==0 || strcmp(cmd, "/cuff", true) == 0)
	{
	new msgspeca[256];
	new tmp[256];
	    if(IsPlayerConnected(playerid))
	    {
			if(metier[playerid]==5)
			{
			    tmp = strtok(cmdtext, idx);
				if(!strlen(tmp)) {
					SendClientMessage(playerid, rouge, "USAGE: /(men)otter [id/pseudo]");
					return 1;
				}
				giveplayerid = ReturnUser(tmp);
			    if(IsPlayerConnected(giveplayerid))
				{
				    if(giveplayerid != INVALID_PLAYER_ID)
				    {
				    if(cuff[giveplayerid]==1) return SendClientMessage(playerid,rouge,"Ce joueur est déjà menotté");
				    {
				    if(playerid==giveplayerid) return SendClientMessage(playerid,rouge,"Vous ne pouvez pas vous menotter");
				    {
						if (ProxDetectorS(8.0, playerid, giveplayerid))
						{
						    if(GetPlayerState(giveplayerid) != GetPlayerState(playerid)) { SendClientMessage(playerid, rouge, "Ce joueur doit etre en dehors du véhicule (ou vous devez etre en dehors)"); return 1; }
						    if(GetPlayerState(playerid) == 1)
						    {
						        GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
								GetPlayerName(playerid, sendername, sizeof(sendername));
						        format(string, sizeof(string), "Vous avez été menotté par %s, jusqu'à ce qu'un policier vous démenotte.", sendername);
								SendClientMessage(giveplayerid, jaune, string);
								format(string, sizeof(string), "Vous avez menotté %s faites /unmen ou /uncuff pour lui enlever ses menottes", giveplayer);
								SendClientMessage(playerid, orange, string);
								format(string, sizeof(string), "Officier %s a menotté %s il ne peut plus bouger.", sendername ,giveplayer);
								ProxDetector(30.0, playerid, string, orange,orange,orange,orange,orange);
								GameTextForPlayer(giveplayerid, "~r~Menotter", 2500, 3);
								TogglePlayerControllable(giveplayerid, 0);
		    	                SetPlayerAttachedObject(giveplayerid,8,19418,6,-0.031999,0.024000,-0.024000,-7.900000,-32.000011,-72.299987,1.115998,1.322000,1.406000);
    	                        SetPlayerSpecialAction(giveplayerid, SPECIAL_ACTION_CUFFED);
    	                        cuff[giveplayerid]=1;
    	                        printf("Officier %s a menotté %s",sendername,giveplayer);
    	                        format(msgspeca,sizeof(msgspeca),"[SPEC]Officier %s a menotté %s",sendername,giveplayer);
    	                        SendAdminMessage(playerid,msgspeca,0);
						    }
						    else
						    {
						        SendClientMessage(playerid, rouge, "Ce joueur n'est pas dans votre voiture, ou vous n'êtes pas le conducteur!");
						        return 1;
						    }
						}
						else
						{
						    SendClientMessage(playerid, rouge, "Ce joueur n'est pas près de vous!");
						    return 1;
						}
					}
				}
				}
				else
				{
				    SendClientMessage(playerid, rouge, "Ce joueur n'est pas connecté!");
				    return 1;
				}
			}
			else
			{
				SendClientMessage(playerid, rouge, "Vous n'êtes pas policier!");
			}
			}
			}
		return 1;
	}
	 if(strcmp(cmd, "/slap", true,8)==0)
	{
	new msgspeca[256];
	new tmp[256];
	new reason[256];
new Float:x,Float:y,Float:z;
	    if(IsPlayerConnected(playerid))
	    {
	    if(!IsPlayerAdmin(playerid))
	    {
	    SendClientMessage(playerid,rouge,"Vous n'êtes pas admin pour pouvoir utiliser cette commande");
	    return 1;
	    }
			    tmp = strtok(cmdtext, idx);
			    reason = strtok(cmdtext, idx);
				if(!strlen(tmp)) {
					SendClientMessage(playerid, orange, "Utilisation: /(slap)per [id/pseudo] [Raison]");
					return 1;
				}
				giveplayerid = ReturnUser(tmp);
			    if(IsPlayerConnected(giveplayerid))
				{
				    if(giveplayerid != INVALID_PLAYER_ID)
				    {
						        GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
								GetPlayerName(playerid, sendername, sizeof(sendername));
								format(string,sizeof(string),"Vous avez été slappé Raison: %s",cmdtext[8]);
								SendClientMessage(giveplayerid, ADMIN_COLOR,string);
								format(string, sizeof(string), "Vous avez slappé %s", giveplayer);
								SendClientMessage(playerid, ADMIN_COLOR, string);
								format(string, sizeof(string), "[ANNOUNCE]Admin a slappé %s Raison: %s",giveplayer,cmdtext[8]);
								SendClientMessageToAll(ADMIN_COLOR,string);
    	                        printf("Admin %s a slappé %s Raison: %s",sendername,giveplayer,cmdtext[8]);
    	                        format(msgspeca,sizeof(msgspeca),"[SPEC]Admin %s a slappé %s Raison: %s",sendername,giveplayer,cmdtext[8]);
    	                        SendAdminMessage(playerid,msgspeca,0);
    	                        GetPlayerPos(giveplayerid,x,y,z);
    	                        SetPlayerPos(giveplayerid,x,y,z+10);
						    }
						}
				else
				{
				    SendClientMessage(playerid, rouge, "Ce joueur n'est pas connecté!");
				    return 1;
				}
			}
		return 1;
	}
		 if(strcmp(cmd, "/goto", true)==0)
	{
	new msgspeca[256];
	new tmp[256];
new Float:x,Float:y,Float:z;
	    if(IsPlayerConnected(playerid))
	    {
	    if(!IsPlayerAdmin(playerid))
	    {
	    SendClientMessage(playerid,rouge,"Vous n'êtes pas admin pour pouvoir utiliser cette commande");
	    return 1;
	    }
			    tmp = strtok(cmdtext, idx);
				if(!strlen(tmp)) {
					SendClientMessage(playerid, orange, "Utilisation: /goto [id/pseudo]");
					return 1;
				}
				giveplayerid = ReturnUser(tmp);
			    if(IsPlayerConnected(giveplayerid))
				{
				    if(giveplayerid != INVALID_PLAYER_ID)
				    {
						        GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
								GetPlayerName(playerid, sendername, sizeof(sendername));
								format(string, sizeof(string), "Vous vous êtes téléporté à %s", giveplayer);
								SendClientMessage(playerid, ADMIN_COLOR, string);
    	                        printf("Admin %s s'est téléporté %s",sendername,giveplayer);
    	                        format(msgspeca,sizeof(msgspeca),"[SPEC]Admin %s s'est téléporté à %s",sendername,giveplayer);
    	                        SendAdminMessage(playerid,msgspeca,0);
    	                        GetPlayerPos(giveplayerid,x,y,z);
    	                        SetPlayerPos(playerid,x,y,z);
						    }
						}
				else
				{
				    SendClientMessage(playerid, rouge, "Ce joueur n'est pas connecté!");
				    return 1;
				}
			}
		return 1;
	}
			 if(strcmp(cmd, "/gethere", true)==0)
	{
	new msgspeca[256];
	new tmp[256];
new Float:x,Float:y,Float:z;
	    if(IsPlayerConnected(playerid))
	    {
	    if(!IsPlayerAdmin(playerid))
	    {
	    SendClientMessage(playerid,rouge,"Vous n'êtes pas admin pour pouvoir utiliser cette commande");
	    return 1;
	    }
			    tmp = strtok(cmdtext, idx);
				if(!strlen(tmp)) {
					SendClientMessage(playerid, orange, "Utilisation: /gethere [id/pseudo]");
					return 1;
				}
				giveplayerid = ReturnUser(tmp);
			    if(IsPlayerConnected(giveplayerid))
				{
				    if(giveplayerid != INVALID_PLAYER_ID)
				    {
						        GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
								GetPlayerName(playerid, sendername, sizeof(sendername));
								format(string, sizeof(string), "Vous avez téléporté %s à vous", giveplayer);
								SendClientMessage(playerid, ADMIN_COLOR, string);
								SendClientMessage(giveplayerid, ADMIN_COLOR,"L'Admin vous a téléporté à lui");
    	                        printf("Admin %s a téléporté %s à lui",sendername,giveplayer);
    	                        format(msgspeca,sizeof(msgspeca),"[SPEC]Admin %s a téléporté %s à lui",sendername,giveplayer);
    	                        SendAdminMessage(playerid,msgspeca,0);
    	                        GetPlayerPos(playerid,x,y,z);
    	                        SetPlayerPos(giveplayerid,x,y,z);
						    }
						}
				else
				{
				    SendClientMessage(playerid, rouge, "Ce joueur n'est pas connecté!");
				    return 1;
				}
			}
		return 1;
	}
				 if(strcmp(cmd, "/stopconvers", true)==0)
	{
	new msgspeca[256];
	new tmp[256];
	    if(IsPlayerConnected(playerid))
	    {
	    if(conversapm[giveplayerid]==0) return SendClientMessage(playerid,rouge,"Aucune conversation n'a été engagée vous ne pouvez donc en arrêter");
	    {
	    if(!IsPlayerAdmin(playerid))
	    {
	    SendClientMessage(playerid,rouge,"Vous n'êtes pas admin pour pouvoir utiliser cette commande");
	    return 1;
	    }
			    tmp = strtok(cmdtext, idx);
				if(!strlen(tmp)) {
					SendClientMessage(playerid, orange, "Utilisation: /stopconvers [id/pseudo]");
					return 1;
				}
				giveplayerid = ReturnUser(tmp);
			    if(IsPlayerConnected(giveplayerid))
				{
				    if(giveplayerid != INVALID_PLAYER_ID)
				    {
						        GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
								GetPlayerName(playerid, sendername, sizeof(sendername));
								format(string, sizeof(string), "Vous avez arrêté la conversation avec %s", giveplayer);
								SendClientMessage(playerid, ADMIN_COLOR, string);
								SendClientMessage(giveplayerid, ADMIN_COLOR,"L'admin a arrêté la conversation");
    	                        printf("Admin %s a arrêté la conversation.",sendername,giveplayer);
    	                        format(msgspeca,sizeof(msgspeca),"[SPEC]Admin %s a arrêté la conversation avec %s",sendername,giveplayer);
    	                        SendAdminMessage(playerid,msgspeca,0);
								conversapm[giveplayerid]=0;
						    }
						}
				else
				{
				    SendClientMessage(playerid, rouge, "Ce joueur n'est pas connecté!");
				    return 1;
				}
			}
			}
		return 1;
	}
	if(strcmp(cmd, "/rendrealcoolique", true) == 0 || strcmp(cmd,"/alcoolique",true)==0)
	{
	new tmp[256];
	    if(IsPlayerConnected(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, orange, "Utilisation: /(rendre)alcoolique [Id/Pseudo] [Taux d'alcoolémie (5000-50000)]");
				return 1;
			}
			new para1;
			new nmetier;
			para1 = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			nmetier = strval(tmp);
			if(IsPlayerAdmin(playerid))
			{
				    if(IsPlayerConnected(para1))
				    {
				        if(para1 != INVALID_PLAYER_ID)
				        {
				        if(nmetier<5000 || nmetier>50000)
				        {
				        SendClientMessage(playerid,rouge,"Le taux d'alcoolémie doit être compris entre 5000 et 50000");
				        }
							GetPlayerName(para1, giveplayer, sizeof(giveplayer));
							GetPlayerName(playerid, sendername, sizeof(sendername));
							SetPlayerDrunkLevel(para1,nmetier);
							printf("Admin %s a mis %s alcoolique à %d.", sendername, giveplayer, nmetier);
							format(string, sizeof(string), "L'admin vous a mis alcoolique à %d", nmetier);
							SendClientMessage(para1, ADMIN_COLOR, string);
							format(string, sizeof(string), "%s est maintenant ivre à %d", giveplayer,nmetier);
							SendClientMessage(playerid, jaune, string);
						}
					}
			}
			else
			{
				SendClientMessage(playerid, rouge, "Vous n'êtes pas autorisé à utiliser cette commande!");
			}
		}
		return 1;
	}
		 if(strcmp(cmd, "/rename", true)==0||strcmp(cmd, "/changename", true) ==0)
	{
	new msgspeca[256];
	new tmp[256];
	new reason[256];
	    if(IsPlayerConnected(playerid))
	    {
	    if(!IsPlayerAdmin(playerid))
	    {
	    SendClientMessage(playerid,rouge,"Vous n'êtes pas admin pour pouvoir utiliser cette commande");
	    return 1;
	    }
			    tmp = strtok(cmdtext, idx);
			    reason = strtok(cmdtext, idx);
				if(!strlen(tmp)) {
					SendClientMessage(playerid, orange, "Utilisation: /rename [id/pseudo] [Nouveau Pseudo]");
					return 1;
				}
				giveplayerid = ReturnUser(tmp);
			    if(IsPlayerConnected(giveplayerid))
				{
				    if(giveplayerid != INVALID_PLAYER_ID)
				    {
						        GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
								GetPlayerName(playerid, sendername, sizeof(sendername));
								format(string,sizeof(string),"Votre Pseudo vient d'être changé en {00ffff} %s vous devrez maintenant vous connecter sous ce pseudo",reason);
								SendClientMessage(giveplayerid, ADMIN_COLOR,string);
								format(string, sizeof(string), "%s a bien été rename", giveplayer);
								SendClientMessage(playerid, ADMIN_COLOR, string);
    	                        printf("Admin %s a rename %s en %s",sendername,giveplayer,reason);
    	                        format(msgspeca,sizeof(msgspeca),"[SPEC]Admin %s a rename %s en %s",sendername,giveplayer,reason);
    	                        SendAdminMessage(playerid,msgspeca,0);
    	                        SetPlayerName(giveplayerid,reason);
						    }
						}
				else
				{
				    SendClientMessage(playerid, rouge, "Ce joueur n'est pas connecté!");
				    return 1;
				}
			}
		return 1;
	}
		 if(strcmp(cmd, "/explose", true,11) ==0)
	{
	new msgspeca[256];
	new tmp[256];
	new reason[256];
new Float:x,Float:y,Float:z;
	    if(IsPlayerConnected(playerid))
	    {
	    if(!IsPlayerAdmin(playerid))
	    {
	    SendClientMessage(playerid,rouge,"Vous n'êtes pas admin pour pouvoir utiliser cette commande");
	    return 1;
	    }
			    tmp = strtok(cmdtext, idx);
			    reason = strtok(cmdtext, idx);
				if(!strlen(tmp)) {
					SendClientMessage(playerid, orange, "Utilisation: /(explose)r [id/pseudo] [Raison]");
					return 1;
				}
				giveplayerid = ReturnUser(tmp);
			    if(IsPlayerConnected(giveplayerid))
				{
				    if(giveplayerid != INVALID_PLAYER_ID)
				    {
						        GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
								GetPlayerName(playerid, sendername, sizeof(sendername));
								format(string,sizeof(string),"Vous avez été explosé Raison: %s",cmdtext[11]);
								SendClientMessage(giveplayerid, ADMIN_COLOR,string);
								format(string, sizeof(string), "Vous avez explosé %s", giveplayer);
								SendClientMessage(playerid, ADMIN_COLOR, string);
								format(string, sizeof(string), "[ANNOUNCE]Admin a explosé %s Raison: %s",giveplayer,cmdtext[11]);
								SendClientMessageToAll(ADMIN_COLOR,string);
    	                        printf("Admin %s a explosé %s Raison: %s",sendername,giveplayer,cmdtext[11]);
    	                        format(msgspeca,sizeof(msgspeca),"[SPEC]Admin %s a explosé %s Raison: %s",sendername,giveplayer,cmdtext[11]);
    	                        SendAdminMessage(playerid,msgspeca,0);
    	                        GetPlayerPos(giveplayerid,x,y,z);
    	                        CreateExplosion(x,y,z,6,2);
    	                        CreateExplosion(x,y,z,6,2);
						    }
						}
				else
				{
				    SendClientMessage(playerid, rouge, "Ce joueur n'est pas connecté!");
				    return 1;
				}
			}
		return 1;
	}
			 if(strcmp(cmd, "/apm", true,7)==0||strcmp(cmd, "/pma", true,7) ==0)
	{
	new msgspeca[256];
	new tmp[256];
	new reason[256];
	    if(IsPlayerConnected(playerid))
	    {
	    if(!IsPlayerAdmin(playerid))
	    {
	    SendClientMessage(playerid,rouge,"Vous n'êtes pas admin pour pouvoir utiliser cette commande");
	    return 1;
	    }
			    tmp = strtok(cmdtext, idx);
			    reason = strtok(cmdtext, idx);
				if(!strlen(tmp)) {
					SendClientMessage(playerid, orange, "Utilisation: /apm [id/pseudo] [Texte]");
					return 1;
				}
				giveplayerid = ReturnUser(tmp);
			    if(IsPlayerConnected(giveplayerid))
				{
				    if(giveplayerid != INVALID_PLAYER_ID)
				    {
					 if(conversapm[giveplayerid]==1)
    	                        {
    	                        GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
								GetPlayerName(playerid, sendername, sizeof(sendername));
								format(string,sizeof(string),"[ADMIN]Administrateur: %s",cmdtext[7]);
								SendClientMessage(giveplayerid, ADMIN_COLOR,string);
								format(string, sizeof(string), "[ADMIN]%s: %s", giveplayer,cmdtext[7]);
								SendClientMessage(playerid, ADMIN_COLOR, string);
    	                        printf("Admin %s a pm %s: %s",sendername,giveplayer,reason);
    	                        format(msgspeca,sizeof(msgspeca),"[SPEC]Admin %s a pm %s: %s",sendername,giveplayer,cmdtext[7]);
    	                        SendAdminMessage(playerid,msgspeca,0);
    	                        }
				    if(conversapm[giveplayerid]==0)
				    {
					            SendClientMessage(giveplayerid,vert,"Conversation engagée avec un administrateur");
								SendClientMessage(playerid,vert,"Conversation engagée");
						        GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
								GetPlayerName(playerid, sendername, sizeof(sendername));
								format(string,sizeof(string),"[ADMIN]Administrateur: %s",cmdtext[7]);
								SendClientMessage(giveplayerid, ADMIN_COLOR,string);
								format(string, sizeof(string), "[ADMIN]%s: %s", giveplayer,cmdtext[7]);
								SendClientMessage(playerid, ADMIN_COLOR, string);
    	                        printf("Admin %s a pm %s: %s",sendername,giveplayer,cmdtext[7]);
    	                        format(msgspeca,sizeof(msgspeca),"[SPEC]Admin %s a pm %s: %s",sendername,giveplayer,cmdtext[7]);
    	                        SendAdminMessage(playerid,msgspeca,0);
								conversapm[giveplayerid]=1;
    	                        }

    	                        
						    }
						}
				else
				{
				    SendClientMessage(playerid, rouge, "Ce joueur n'est pas connecté!");
				    return 1;
				}
			}
		return 1;
	}
		if(strcmp(cmdtext, "/repond", true, 7) == 0)
		{
		new str[256];
		new tmp[256];
		tmp = strtok(cmdtext, idx);
		if(conversapm[playerid]==0) return SendClientMessage(playerid,rouge,"Aucune conversation n'est engagée avec un administrateur");
		{
		if(!strlen(tmp))
		{
		SendClientMessage(playerid, orange,"Utilisation: /repond [Texte]");
		return 1;
		}
		GetPlayerName(playerid, pname, 14);
		format(str, sizeof(str), "[APM]%s: %s",pname, cmdtext[7]);
		SendAdminMessage(playerid,str,0);
		SendClientMessage(playerid, vert, "Réponse envoyée");
		}
		return 1;
		}
		 if(strcmp(cmd, "/kick", true,8)==0)
	{
	new msgspeca[256];
	new tmp[256];
	new reason[256];
	    if(IsPlayerConnected(playerid))
	    {
	    if(!IsPlayerAdmin(playerid))
	    {
	    SendClientMessage(playerid,rouge,"Vous n'êtes pas admin pour pouvoir utiliser cette commande");
	    return 1;
	    }
			    tmp = strtok(cmdtext, idx);
			    reason = strtok(cmdtext, idx);
				if(!strlen(tmp)) {
					SendClientMessage(playerid, orange, "Utilisation: /(kick)er [id/pseudo] [Raison]");
					return 1;
				}
				giveplayerid = ReturnUser(tmp);
			    if(IsPlayerConnected(giveplayerid))
				{
				    if(giveplayerid != INVALID_PLAYER_ID)
				    {
						        GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
								GetPlayerName(playerid, sendername, sizeof(sendername));
								format(string,sizeof(string),"Vous avez été kické Raison: %s",cmdtext[8]);
								SendClientMessage(giveplayerid, ADMIN_COLOR,string);
								SendClientMessage(giveplayerid,jaune,"Si vous êtes contre ce kick veuillez porter plainte sur notre forum www.minecraft-le-fun.xooit.fr");
								format(string, sizeof(string), "Vous avez kické %s", giveplayer);
								SendClientMessage(playerid, ADMIN_COLOR, string);
								format(string, sizeof(string), "[ANNOUNCE]Admin a kické %s Raison: %s",giveplayer,cmdtext[8]);
								SendClientMessageToAll(ADMIN_COLOR,string);
    	                        printf("Admin %s a kické %s Raison: %s",sendername,giveplayer,cmdtext[8]);
    	                        format(msgspeca,sizeof(msgspeca),"[SPEC]Admin %s a kické %s Raison: %s",sendername,giveplayer,cmdtext[8]);
    	                        SendAdminMessage(playerid,msgspeca,0);
    	                        Kick(giveplayerid);
						    }
						}
				else
				{
				    SendClientMessage(playerid, rouge, "Ce joueur n'est pas connecté!");
				    return 1;
				}
			}
		return 1;
	}
			 if(strcmp(cmd, "/ban", true,7)==0)
	{
	new msgspeca[256];
	new tmp[256];
	new reason[256];
	    if(IsPlayerConnected(playerid))
	    {
	    if(!IsPlayerAdmin(playerid))
	    {
	    SendClientMessage(playerid,rouge,"Vous n'êtes pas admin pour pouvoir utiliser cette commande");
	    return 1;
	    }
			    tmp = strtok(cmdtext, idx);
			    reason = strtok(cmdtext, idx);
				if(!strlen(tmp)) {
					SendClientMessage(playerid, orange, "Utilisation: /ban [id/pseudo] [Raison]");
					return 1;
				}
				giveplayerid = ReturnUser(tmp);
			    if(IsPlayerConnected(giveplayerid))
				{
				    if(giveplayerid != INVALID_PLAYER_ID)
				    {
						        GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
								GetPlayerName(playerid, sendername, sizeof(sendername));
								format(string, sizeof(string), "[ANNOUNCE]Admin a banni %s Raison: %s",giveplayer,cmdtext[7]);
								SendClientMessageToAll(ADMIN_COLOR,string);
								format(string,sizeof(string),"Vous avez été banni Raison: %s",cmdtext[7]);
								SendClientMessage(giveplayerid, ADMIN_COLOR,string);
								SendClientMessage(giveplayerid, gris,"Vous avez posibilité de vous faire unban en postant sur notre forum: www.minecraft-le-fun.xooit.fr");
								format(string, sizeof(string), "Vous avez banni %s", giveplayer);
								SendClientMessage(playerid, ADMIN_COLOR, string);
    	                        printf("Admin %s a banni %s Raison: %s",sendername,giveplayer,cmdtext[7]);
    	                        format(msgspeca,sizeof(msgspeca),"[SPEC]Admin %s a banni %s Raison: %s",sendername,giveplayer,cmdtext[7]);
    	                        SendAdminMessage(playerid,msgspeca,0);
    	                        format(string,sizeof(string),"%s",reason);
    	                        BanEx(giveplayerid,string);
						    }
						}
				else
				{
				    SendClientMessage(playerid, rouge, "Ce joueur n'est pas connecté!");
				    return 1;
				}
			}
		return 1;
	}
	
		if(strcmp(cmd, "/newbie", true) == 0 || strcmp(cmd, "/n", true) == 0 || strcmp(cmd, "/new", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			GetPlayerName(playerid, sendername, sizeof(sendername));
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[256];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!strlen(result))
			{
				SendClientMessage(playerid, orange, "Utilisation: (/n) [Message]");
				return 1;
			}
			if(IsPlayerAdmin(playerid))
			{
			format(string,sizeof(string),"[Newbie]Admin %s: %s",sendername,result);
			SendClientMessageToAll(newbie,string);
			printf("Canal Newbie Admin  %s: %s",sendername,result);
			}
			else if(!IsPlayerAdmin(playerid))
			{
			format(string,sizeof(string),"[Newbie]Nouveau %s: %s",sendername,result);
			SendClientMessageToAll(newbie,string);
			printf("Canal Newbie Nouveau %s: %s",sendername,result);
			}
			}
		return 1;
	}
	if(strcmp(cmd,"/annonce",true)==0)
	{
	if(IsPlayerInRangeOfPoint(playerid,2.0,-98.9612,1084.1152,19.7422))
	{
	if(GetPlayerMoney(playerid)<100) return SendClientMessage(playerid,rouge,"Vous n'avez pas assez d'argent pour passer une annonce (100$) ");
	{
	SendClientMessage(playerid,vert,"Entrez l'annonce que vous voulez passer");
	ShowPlayerDialog(playerid,755,DIALOG_STYLE_INPUT,"ANNONCE","Entrez ci-dessous l'annonce que vous voulez faire passer","ENTRER","ANNULER");
	}
	}
	return 1;
	}
	 if(strcmp(cmd, "/unmenotter", true)==0||strcmp(cmd, "/unmen", true) ==0 || strcmp(cmd, "/uncuff", true) == 0)
	{
	new tmp[256];
	new msgspeca[256];
	    if(IsPlayerConnected(playerid))
	    {
			if(metier[playerid]==5)
			{
			    tmp = strtok(cmdtext, idx);
				if(!strlen(tmp)) {
					SendClientMessage(playerid, rouge, "USAGE: /(unmen)otter [id/pseudo]");
					return 1;
				}
				giveplayerid = ReturnUser(tmp);
			    if(IsPlayerConnected(giveplayerid))
				{
				    if(giveplayerid != INVALID_PLAYER_ID)
				    {
				    if(cuff[giveplayerid]==0) return SendClientMessage(playerid,rouge,"Ce joueur n'est pas menotté");
				    {
						if (ProxDetectorS(8.0, playerid, giveplayerid))
						{
						    if(GetPlayerState(giveplayerid) != GetPlayerState(playerid)) { SendClientMessage(playerid, rouge, "Ce joueur doit etre en dehors du véhicule (ou vous devez etre en dehors)"); return 1; }
						    if(GetPlayerState(playerid) == 1)
						    {
						        GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
								GetPlayerName(playerid, sendername, sizeof(sendername));
						        format(string, sizeof(string), "Vous avez été démenotté par %s", sendername);
								SendClientMessage(giveplayerid, jaune, string);
								format(string, sizeof(string), "Vous avez démenotté %s", giveplayer);
								SendClientMessage(playerid, orange, string);
								format(string, sizeof(string), "Officier %s a démenotté %s il peut maintenant bouger.", sendername ,giveplayer);
								ProxDetector(30.0, playerid, string, orange,orange,orange,orange,orange);
								GameTextForPlayer(giveplayerid, "~g~Demenotter", 2500, 3);
								TogglePlayerControllable(giveplayerid, 1);
								RemovePlayerAttachedObject(giveplayerid,8);
                                SetPlayerSpecialAction(giveplayerid, 0);
                                cuff[giveplayerid]=0;
       	                        printf("Officier %s a démenotté %s",sendername,giveplayer);
    	                        format(msgspeca,sizeof(msgspeca),"[SPEC]Officier %s a démenotté %s",sendername,giveplayer);
    	                        SendAdminMessage(playerid,msgspeca,0);
						    }
						    else
						    {
						        SendClientMessage(playerid, rouge, "Ce joueur n'est pas dans votre voiture, ou vous n'êtes pas le conducteur!");
						        return 1;
						    }
						}
						else
						{
						    SendClientMessage(playerid, rouge, "Ce joueur n'est pas près de vous!");
						    return 1;
						}
					}
				}
				}
				else
				{
				    SendClientMessage(playerid, rouge, "Ce joueur n'est pas connecté!");
				    return 1;
				}
			}
			else
			{
				SendClientMessage(playerid, rouge, "Vous n'êtes pas policier!");
			}
			}
		return 1;
	}
if(strcmp("/constat",cmdtext,true)==0)
{
if(mission[playerid]==1)
if(metier[playerid]==5)
if(IsPlayerInRangeOfPoint(playerid,8.0,-1877.0603,-1706.9952,21.7500))
{
SendClientMessage(playerid,vert,"Vous avez le bilan de l'accident");
SendClientMessage(playerid,jaune,"Vous remportez 500$");
GivePlayerMoney(playerid,500);
mission[playerid]=0;
}
else if(mission[playerid]==0)
{
SendClientMessage(playerid,rouge,"Vous n'êtes pas appelé à intervenir à l'accident");
}
else if(metier[playerid]<5 || metier[playerid]>5)
{
SendClientMessage(playerid,rouge,"Vous n'êtes pas policier pour faire le constat");
}
else if(!IsPlayerInRangeOfPoint(playerid,8.0,-1877.0603,-1706.9952,21.7500))
{
SendClientMessage(playerid,rouge,"Vous n'êtes pas à l'accident pour pouvoir faire le constat");
}
return 1;
}
if(strcmp("/intervenir",cmdtext, true) ==0)
{
if(accident==1)
if(GetVehicleModel(GetPlayerVehicleID(playerid))== 599 || GetVehicleModel(GetPlayerVehicleID(playerid))== 596 || GetVehicleModel(GetPlayerVehicleID(playerid))== 523)
if(metier[playerid]== 5)
if(mission[playerid]== 0)
{
SetPlayerCheckpoint(playerid,-1877.0603,-1706.9952,21.7500,8.0);
SendClientMessage(playerid,vert,"Vous êtes appelé à faire le constat de l'accident");
veh1=CreateVehicle(416,-1940.8195,-1790.9509,32.4435,124.3544,0,0,0); //
veh2=CreateVehicle(416,-1879.3409,-1697.4465,22.4030,347.9438,0,0,0); //
veh3=CreateVehicle(416,-1869.8400,-1710.3840,22.4040,327.6788,0,0,0); //
veh4=CreateVehicle(597,-1884.4144,-1686.4833,21.5396,246.2280,0,0,0); //
veh5=CreateVehicle(597,-1882.7817,-1683.2170,21.5437,253.2603,0,0,0); //
veh6=CreateVehicle(599,-1890.7196,-1700.7587,22.0502,144.7191,0,0,0); //
mission[playerid]=1;
}
else if(!GetVehicleModel(GetPlayerVehicleID(playerid)== 599 || GetVehicleModel(GetPlayerVehicleID(playerid)== 596 || GetVehicleModel(GetPlayerVehicleID(playerid)== 523))))
{
SendClientMessage(playerid,rouge,"Vous n'êtes pas dans un véhicule de police pour intervenir");
}
else if(metier[playerid]<5 || metier[playerid]>5)
{
SendClientMessage(playerid,rouge,"Vous n'êtes pas policier pour pouvoir intervenir");
}
else if(mission[playerid]== 1)
{
SendClientMessage(playerid,rouge,"Vous êtes déjà en train de faire une mission vous ne pouvez donc intervenir");
}
else if(accident==0)
{
SendClientMessage(playerid,rouge,"Aucun accident s'est déroulé recemment");
}
return 1;
}
if(strcmp("/fumer",cmdtext,true)==0)
{
if(briquet[playerid]==0 || cigarette[playerid]==0) return SendClientMessage(playerid,rouge,"Vous devez munir d'une cigarette et d'un briquet pour pouvoir fumer");
{
if(fumer[playerid]==1) return SendClientMessage(playerid,rouge,"Vous êtes déjà en train de fumer");
{
GetPlayerName(playerid,pname,sizeof(pname));
SetPlayerSpecialAction(playerid,SPECIAL_ACTION_SMOKE_CIGGY);
format(string, sizeof(string), "%s allume sa cigarette",pname);
ProxDetector(30.0, playerid, string, jaune, jaune,jaune,jaune,jaune);
fumer[playerid]=1;
SendClientMessage(playerid,orange,"Vous pouvez arrêté de fumer en tapant /stopfumer ou attendre 1 minute.");
SetTimer("Fume",600000,false);
cigarette[playerid]--;
}
}
return 1;
}
if(strcmp("/stopfumer",cmdtext,true)==0)
{
if(fumer[playerid]==0) return SendClientMessage(playerid,rouge,"Vous n'êtes pas en train de fumer pour vous arrêtez");
{
KillTimer(5);
SendClientMessage(playerid,orange,"Vous avez fini votre cigarette");
fumer[playerid]=0;
SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
}
return 1;
}
if(strcmp("/accident", cmdtext, true) ==0)
{
new msgspeca[256];
if(accident==0)
if(metier[playerid]== 2)
if(GetVehicleModel(GetPlayerVehicleID(playerid))== 416)
{
SetPlayerCheckpoint(playerid,-1877.0603,-1706.9952,21.7500,8.0);
veh1=CreateVehicle(416,-1940.8195,-1790.9509,32.4435,124.3544,0,0,0); //
veh2=CreateVehicle(416,-1879.3409,-1697.4465,22.4030,347.9438,0,0,0); //
veh3=CreateVehicle(416,-1869.8400,-1710.3840,22.4040,327.6788,0,0,0); //
veh4=CreateVehicle(597,-1884.4144,-1686.4833,21.5396,246.2280,0,0,0); //
veh5=CreateVehicle(597,-1882.7817,-1683.2170,21.5437,253.2603,0,0,0); //
veh6=CreateVehicle(599,-1890.7196,-1700.7587,22.0502,144.7191,0,0,0); //
mission[playerid]= 1;
SendClientMessageToAll(orange,"[RADIO]Un Accident de chantier a eu lieu au pied du Mont Chiliad les secours sont sur place");
accident= 1;
GetPlayerName(playerid,pname,sizeof(pname));
SetPlayerCheckpoint(playerid,-1877.0603,-1706.9952,21.7500,8.0);
printf("Ambulancier %s a simulé un accident",pname);
format(msgspeca,sizeof(msgspeca),"[SPEC]Ambulancier %s a simulé un accident",pname);
SendAdminMessage(playerid,msgspeca,0);
}
else if(accident==1)
{
SendClientMessage(playerid,rouge,"Un accident a déjà eu lieu vous ne pouvez pas en simuler un autre");
}
else if(metier[playerid]< 2 || metier[playerid]>2)
{
SendClientMessage(playerid,rouge,"Vous n'êtes pas secouriste pour utiliser cette commande");
}
else if(!GetVehicleModel(GetPlayerVehicleID(playerid)== 416))
{
SendClientMessage(playerid,rouge,"Vous n'êtes pas dans une ambulance pour utiliser cette commande");
}
return 1;
}
if(strcmp("/cagoule",cmdtext,true)==0)
{
if(mcagoule[playerid]==1) return SendClientMessage(playerid,rouge,"Vous avez déjà votre cagoule sur la tête");
{
if(cagoule[playerid]==0) return SendClientMessage(playerid,rouge,"Vous n'avez pas de cagoule pour vous la mettre sur la tête");
{
GetPlayerName(playerid,pname,sizeof(pname));
SendClientMessage(playerid,vert,"Cagoule mise avec succès");
printf("%s vient de mettre sa cagoule",pname);
ShowPlayerNameTagForPlayer(i, playerid, 0);
format(string,sizeof(string),"[SPEC]%s a mis sa cagoule",pname);
SendAdminMessage(playerid,string,0);
format(string,sizeof(string),"%s vient de mettre sa cagoule",pname);
ProxDetector(20.0,playerid,string,orange,orange,orange,orange,orange);
mcagoule[playerid]=1;
}
}
return 1;
}
if(strcmp("/enlevercagoule",cmdtext,true)==0)
{
if(mcagoule[playerid]==0) return SendClientMessage(playerid,rouge,"Vous n'avez pas de cagoule sur la tête");
{
GetPlayerName(playerid,pname,sizeof(pname));
SendClientMessage(playerid,vert,"Cagoule enlevée avec succès");
printf("%s vient de mettre sa cagoule",pname);
format(string,sizeof(string),"[SPEC]%s a enlevé sa cagoule",pname);
SendAdminMessage(playerid,string,0);
format(string,sizeof(string),"%s vient d'enlever sa cagoule",pname);
ProxDetector(20.0,playerid,string,orange,orange,orange,orange,orange);
ShowPlayerNameTagForPlayer(i, playerid, 0);
mcagoule[playerid]=0;
}
return 1;
}
if (strcmp("/pause", cmdtext, true) == 0 || strcmp("/afk",cmdtext,true)==0)
{
new msgspeca[256];
if(afk[playerid]==0)
{
GetPlayerName(playerid,pname,sizeof(pname));
ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "AFK", " {0066cc}Vous vous êtes mis AFK avec succès.Pour revenir en jeu retapez la commande.", "OK", "OK");
TogglePlayerControllable(playerid,0);
SetPlayerPos(playerid,-2706.1846,376.2457,4.9685);
SetPlayerCameraPos(playerid,-2713.7087,376.5720,4.3744);
SetPlayerCameraLookAt(playerid,-2706.1846,376.2457,4.9685);
format(pseudofinal, 70, "AFK_%s", pseudoinitial[playerid]);
SetPlayerName(playerid, pseudofinal);
PlayerPlaySound(playerid,1076,-2706.1846,376.2457,4.9685);
afk[playerid]=1;
printf("%s s'est mis en pause",pname);
format(msgspeca,sizeof(msgspeca),"[SPEC]%s s'est mis en pause",pname);
SendAdminMessage(playerid,msgspeca,0);
}
else
{
GetPlayerName(playerid,pname,sizeof(pname));
SpawnPlayer(playerid);
TogglePlayerControllable(playerid,1);
SetPlayerName(playerid,pseudoinitial[playerid]);
afk[playerid]=0;
printf("%s s'est enlevé de sa pause",pname);
format(msgspeca,sizeof(msgspeca),"[SPEC]%s s'est enlevé de sa pause",pname);
SendAdminMessage(playerid,msgspeca,0);
}
return 1;
}
	if(strcmp(cmd, "/ooc", true) == 0 || strcmp(cmd, "/o", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        if(logged[playerid] == 0)
	        {
	            SendClientMessage(playerid, rouge, "Vous devez d'abord entrer votre mot de passe!");
	            return 1;
	        }
			GetPlayerName(playerid, sendername, sizeof(sendername));
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[775];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!strlen(result))
			{
				SendClientMessage(playerid, orange, "Utilisation: (/o)oc [Message]");
				return 1;
			}
			if(ooc==0 && !IsPlayerAdmin(playerid))
			{
			SendClientMessage(playerid,orange,"Le canal OOC est fermé pour le moment veuillez attendre qu'un admin l'ouvre");
			return 1;
			}
			format(string, sizeof(string), "((OOC %s: %s))" , sendername, result);
			SendClientMessageToAll(cyan,string);
			printf("Canal OOC %s: %s", string);
		}
		return 1;
	}
	if(strcmp(cmdtext,"/stats",true)==0)
	{
	new Float: health;
	new Float: armour;
	new tm[256];
	new te[256];
	new ta[256];
	if(metier[playerid]==1) { tm="Camionneur"; }
	else if(metier[playerid]==2) { tm="Ambulancier"; }
	else if(metier[playerid]==3) { tm="Délinquant"; }
	else if(metier[playerid]==4) { tm="Pilote de Ligne"; }
	else if(metier[playerid]==5) { tm="Policier"; }
	else if(metier[playerid]==6) { tm="Chauffeur de bus/taxi"; }
	else if(metier[playerid]==7) { tm="Militaire"; }
	else if(metier[playerid]==8) { tm="Pêcheur"; }
	if(metier[playerid]==1) { te="E.C.A.P"; }
	else if(metier[playerid]==2) { te="S.I.M.A.P"; }
	else if(metier[playerid]==3) { te="Syndicat du crime"; }
	else if(metier[playerid]==4) { te="Air A.P"; }
	else if(metier[playerid]==5) { te="A.P.P.D"; }
	else if(metier[playerid]==6) { te="Evra A.P"; }
	else if(metier[playerid]==7) { te="Armée de l'air"; }
	else if(metier[playerid]==8) { te="A.P Maritime"; }
	if(PlayerInfo[playerid][pAdmin]==0) { ta="Joueur"; }
	else if(PlayerInfo[playerid][pAdmin]==1) { ta="Modérateur"; }
	else if(PlayerInfo[playerid][pAdmin]==2) { ta="Admin"; }
	else if(PlayerInfo[playerid][pAdmin]==3) { ta="Administrateur"; }
	GetPlayerName(playerid,pname,sizeof(pname));
	GetPlayerHealth(playerid,health);
	GetPlayerArmour(playerid,armour);
	format(string,sizeof(string),"{0099ff}Pseudo: %s\nArgent: %d$\n Niveau: %d\nSanté: %f\nGilet pare-balles: %f\nMétier: %s\nEntreprise: %s\nAdmin: %d",pname,GetPlayerMoney(playerid),PlayerInfo[playerid][pLevel],health,armour,tm,te,ta);
	ShowPlayerDialog(playerid,0,DIALOG_STYLE_MSGBOX,"{9966cc}STATS",string,"OK","FERMER");
	format(string,sizeof(string),"%s regarde ses papiers",pname);
	ProxDetector(20.0,playerid,string,jaune,jaune,jaune,jaune,jaune);
	printf("%s a regardé ses stats",pname);
	format(string,sizeof(string),"[SPEC]%s regarde ses stats",pname);
	SendAdminMessage(playerid,string,0);
	return 1;
	}
		if(strcmp(cmdtext,"/astats",true)==0)
	{
	new tmp[256];
 tmp = strtok(cmdtext, idx);
giveplayerid = ReturnUser(tmp);
if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid,rouge,"Vous n'êtes pas admin pour pouvoir utiliser cette commande");
{
if(!strlen(tmp)) return SendClientMessage(playerid,orange,"Utilisation: /astats [Id/Pseudo]");
{
if(!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid,rouge,"Ce joueur n'est pas connecté");
{
	new Float: health;
	new Float: armour;
	new tm[256];
	new te[256];
	new ta[256];
	if(metier[giveplayerid]==1) { tm="Camionneur"; }
	else if(metier[giveplayerid]==2) { tm="Ambulancier"; }
	else if(metier[giveplayerid]==3) { tm="Délinquant"; }
	else if(metier[giveplayerid]==4) { tm="Pilote de Ligne"; }
	else if(metier[giveplayerid]==5) { tm="Policier"; }
	else if(metier[giveplayerid]==6) { tm="Chauffeur de bus/taxi"; }
	else if(metier[giveplayerid]==7) { tm="Militaire"; }
	else if(metier[giveplayerid]==8) { tm="Pêcheur"; }
	if(metier[giveplayerid]==1) { te="E.C.A.P"; }
	else if(metier[giveplayerid]==2) { te="S.I.M.A.P"; }
	else if(metier[giveplayerid]==3) { te="Syndicat du crime"; }
	else if(metier[giveplayerid]==4) { te="Air A.P"; }
	else if(metier[giveplayerid]==5) { te="A.P.P.D"; }
	else if(metier[giveplayerid]==6) { te="Evra A.P"; }
	else if(metier[giveplayerid]==7) { te="Armée de l'air"; }
	else if(metier[giveplayerid]==8) { te="A.P Maritime"; }
	if(PlayerInfo[giveplayerid][pAdmin]==0) { ta="Joueur"; }
	else if(PlayerInfo[giveplayerid][pAdmin]==1) { ta="Modérateur"; }
	else if(PlayerInfo[giveplayerid][pAdmin]==2) { ta="Admin"; }
	else if(PlayerInfo[giveplayerid][pAdmin]==3) { ta="Administrateur"; }
	GetPlayerName(giveplayerid,pname,sizeof(pname));
	GetPlayerHealth(giveplayerid,health);
	GetPlayerArmour(giveplayerid,armour);
	GetPlayerName(playerid,sendername,sizeof(sendername));
	format(string,sizeof(string),"{0099ff}Pseudo: %s\nArgent: %d$\n Niveau: %d\nSanté: %f\nGilet pare-balles: %f\nMétier: %s\nEntreprise: %s\nAdmin: %d",pname,GetPlayerMoney(playerid),PlayerInfo[playerid][pLevel],health,armour,tm,te,ta);
	ShowPlayerDialog(playerid,0,DIALOG_STYLE_MSGBOX,"{9966cc}STATS",string,"OK","FERMER");
	printf("Admin %s a regardé les stats de %s",sendername,pname);
	format(string,sizeof(string),"[SPEC]Admin %s regarde les stats de %s",sendername,pname);
	SendAdminMessage(playerid,string,0);
	}
	}
	}
	return 1;
	}
		if(strcmp(cmd, "/a", true) == 0 || strcmp(cmd, "/admin", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        if(logged[playerid] == 0)
	        {
	            SendClientMessage(playerid, rouge, "Vous devez d'abord entrer votre mot de passe!");
	            return 1;
	        }
			GetPlayerName(playerid, sendername, sizeof(sendername));
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[775];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!IsPlayerAdmin(playerid))
			{
			SendClientMessage(playerid,rouge,"Vous n'êtes pas admin pour pouvoir utiliser cette commande");
			return 1;
			}
			if(!strlen(result))
			{
				SendClientMessage(playerid, orange, "Utilisation: (/a)dmin [Message]");
				return 1;
			}
			format(string, sizeof(string), "[ADMIN]%s: %s" , sendername, result);
			SendAdminMessage(jaune,string,0);
			printf("Canal Admin %s: %s",sendername,result);
		}
		return 1;
	}
	if(strcmp(cmd,"/fnoob",true)==0 || strcmp(cmd,"/fermernewbie",true)==0)
	{
	new msgspec[256];
	new msgspeca[256];
	if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid,rouge,"Vous n'êtes pas admin pour pouvoir utiliser cette commande");
	{
	if(noob==0) return SendClientMessage(playerid,rouge,"Le canal Newbie est déjà fermé");
	{
	SendClientMessageToAll(cyan,"**Le Canal Newbie vient d'être fermé par l'Admin**");
	GetPlayerName(playerid,pname,sizeof(pname));
	format(msgspec,sizeof(msgspec),"Admin %s a fermé le canal Newbie",pname);
	print(msgspec);
	SendClientMessage(playerid,vert,"Canal Newbie fermé avec succès");
	format(msgspeca,sizeof(msgspeca),"[SPEC]Admin %s a fermé le canal Newbie",pname);
	SendAdminMessage(playerid,msgspeca,0);
	noob=0;
	}
	}
	return 1;
	}
		if(strcmp(cmd,"/onoob",true)==0 || strcmp(cmd,"/ouvrirnewbie",true)==0)
	{
	new msgspec[256];
	new msgspeca[256];
	if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid,rouge,"Vous n'êtes pas admin pour pouvoir utiliser cette commande");
	{
	if(noob==1) return SendClientMessage(playerid,rouge,"Le canal Newbie est déjà ouvert");
	{
	SendClientMessageToAll(cyan,"**Le Canal Newbie vient d'être ouvert par l'Admin**");
	GetPlayerName(playerid,pname,sizeof(pname));
	format(msgspec,sizeof(msgspec),"Admin %s a ouvert le canal Newbie",pname);
	print(msgspec);
	SendClientMessage(playerid,vert,"Canal Newbie ouvert avec succès");
	format(msgspeca,sizeof(msgspeca),"[SPEC]Admin %s a ouvert le canal Newbie",pname);
	SendAdminMessage(playerid,msgspeca,0);
	noob=1;
	}
	}
	return 1;
	}
			if(strcmp(cmd, "/ao", true) == 0 || strcmp(cmd, "/adminooc", true) == 0)
	{
	new msgspeca[256];
	    if(IsPlayerConnected(playerid))
	    {
	        if(logged[playerid] == 0)
	        {
	            SendClientMessage(playerid, rouge, "Vous devez d'abord entrer votre mot de passe!");
	            return 1;
	        }
			GetPlayerName(playerid, sendername, sizeof(sendername));
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[775];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!IsPlayerAdmin(playerid))
			{
			SendClientMessage(playerid,rouge,"Vous n'êtes pas admin pour pouvoir utiliser cette commande");
			return 1;
			}
			if(!strlen(result))
			{
				SendClientMessage(playerid, orange, "Utilisation: (/ao)adminooc [Message]");
				return 1;
			}
			format(string, sizeof(string), "Admin: %s", result);
			SendClientMessageToAll(ADMIN_COLOR,string);
			printf("Admin OOC %s: %s",sendername,result);
			format(msgspeca,sizeof(msgspeca),"[SPEC]Canal Admin OOC %s: %s",sendername,result);
			SendAdminMessage(playerid,msgspeca,0);
		}
		return 1;
	}
	if(strcmp(cmdtext,"/bar",true)==0)
	{
	if(IsPlayerInRangeOfPoint(playerid,3.0,-225.2079,1404.4272,27.7734))
	{
	ShowPlayerDialog(playerid,899,DIALOG_STYLE_LIST,"MENU BAR","Boissons gazeuses et Sodas\nAlcool\nJus\nCafé(25$)\nThé(25$)\nTisane(20$)","CHOISIR","FERMER");
	SendClientMessage(playerid,vert,"Choisissez la catégorie la mieux adaptée à votre souhait");
	}
	return 1;
	}
	if(strcmp(cmdtext,"/fooc",true)==0 || strcmp(cmdtext,"/fermerooc",true)==0)
	{
	new msgspec[256];
	new msgspeca[256];
	if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid,rouge,"Vous n'êtes pas admin pour pouvoir utiliser cette commande");
	{
	if(ooc==0) return SendClientMessage(playerid,rouge,"Le Canal OOC est déjà fermé");
	{
	SendClientMessageToAll(cyan,"**Le Canal OOC vient d'être fermé par l'Admin**");
	GetPlayerName(playerid,pname,sizeof(pname));
	format(msgspec,sizeof(msgspec),"Admin %s a fermé le canal OOC",pname);
	print(msgspec);
	SendClientMessage(playerid,vert,"Canal OOC fermé avec succès");
	format(msgspeca,sizeof(msgspeca),"[SPEC]Admin %s a fermé le canal OOC",pname);
	SendAdminMessage(playerid,msgspeca,0);
	ooc=0;
	}
	}
	return 1;
	}
		if(strcmp(cmdtext,"/oooc",true)==0 || strcmp(cmdtext,"/ouvrirooc",true)==0)
	{
	new msgspec[256];
	new msgspeca[256];
	if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid,rouge,"Vous n'êtes pas admin pour pouvoir utiliser cette commande");
	{
	if(ooc==1) return SendClientMessage(playerid,rouge,"Le Canal OOC est déjà ouvert");
	{
	SendClientMessageToAll(cyan,"**Le Canal OOC vient d'être ouvert par l'Admin**");
	GetPlayerName(playerid,pname,sizeof(pname));
	format(msgspec,sizeof(msgspec),"Admin %s a ouvert le canal OOC",pname);
	print(msgspec);
	SendClientMessage(playerid,vert,"Canal OOC ouvert avec succès");
	format(msgspeca,sizeof(msgspeca),"[SPEC]Admin %s a ouvert le canal OOC",pname);
	SendAdminMessage(playerid,msgspeca,0);
	ooc=1;
	}
	}
	return 1;
	}

if(strcmp("/aide",cmdtext,true)==0)
{
ShowPlayerDialog(playerid,19,DIALOG_STYLE_LIST,"AIDE"," COMMANDES GENERALES \n COMMANDES JOB  \n COMMANDES ADMINS ","ALLER","ANNULER");
SendClientMessage(playerid,vert,"Veuillez choisir votre catégorie");
return 1;
}
if (strcmp("/mq", cmdtext, true) == 0)
{
SendClientMessage(playerid,orange,"**Vous avez arrété vos missions**");
DisablePlayerCheckpoint(playerid);
SpawnPlayer(playerid);
mission[playerid]= 0;
return 1;
}
if(strcmp(cmdtext,"/volmaison", true)==0)
{
new msgspeca[256];
if(metier[playerid]<3 || metier[playerid]>3) return SendClientMessage(playerid,rouge,"Vous n'êtes pas délinquant pour pouvoir voler cette maison");
{
if(!IsPlayerInRangeOfPoint(playerid,5,2340.3164,-1062.3643,1049.0310)) return SendClientMessage(playerid,rouge,"Vous êtes pas au bonne endroit pour pourvoir voler");
{
if(vol[playerid]==1) return SendClientMessage(playerid,rouge,"Vous êtes déjà en train de voler!");
{
SetPlayerCheckpoint(playerid,-2192.5742,642.7424,49.0084,3.0);
GetPlayerName(playerid,pname,sizeof(pname));
SendClientMessage(playerid,jaune,"Vous êtes en train de cambrioler la maison foncez vite à votre planque!");
vol[playerid]=1;
SetPlayerWantedLevel(playerid,GetPlayerWantedLevel(playerid)+2);
SendRadioPolice(playerid,"[RADIO]A toutes les unités un cambriolage vient d'avoir lieu à la maison N°1",0);
format(msgspeca,sizeof(msgspeca),"[SPEC]%s a commencé un cambriolage à la maison N°1",pname);
SendAdminMessage(playerid,msgspeca,0);
printf("%s a commencé à cambrioler la maison N°1",pname);
}
}
}
return 1;
}
//======================================[ DROGUER  ]==================
if(strcmp(cmdtext, "/drogue", true) == 0)
{
if(metier[playerid]==3)
if(IsPlayerInRangeOfPoint(playerid,100.0,-2084.2737,-2421.2327,30.6250))
if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 482)
{
SetPlayerCheckpoint(playerid,-2726.8450,-309.4221,7.0391,8.0);
SendClientMessage(playerid,0x1CE3CFFF,"[PATRON]Ouais,allo prend une camionette et livre moi la drogue à la planque");
mission[playerid]=1;
SetPlayerWantedLevel(playerid,GetPlayerWantedLevel(playerid)+3);
}
else if(metier[playerid]<3 || metier[playerid]>3)
{
SendClientMessage(playerid,rouge,"Vous n'êtes pas délinquant pour pouvoir livrer de la drogue");
}
else if(!IsPlayerInRangeOfPoint(playerid,100.0,-2084.2737,-2421.2327,30.6250))
{
SendClientMessage(playerid,rouge,"Vous n'êtes pas au dépot de drogue pour livrer de la drogue");
}
else if(!GetVehicleModel(GetPlayerVehicleID(playerid) == 482))
{
SendClientMessage(playerid,rouge,"Vous n'êtes pas dans une camionette pour pouvoir livrer de la drogue");
}
return 1;
}
if(strcmp("/gps",cmdtext,true)==0)
{
if(gps[playerid]==0) return SendClientMessage(playerid,rouge,"Vous devez munir d'un GPS pour l'allumer");
{
if(IsPlayerInAnyVehicle(playerid))
{
SendClientMessage(playerid,jaune,"Programmez votre GPS à l'endroit voulu");
ShowPlayerDialog(playerid,963,DIALOG_STYLE_LIST,"Menu GPS","CENTRE MEDICAL\nCOMMISSARIAT\nPORT\nBANQUE\nAMMUNATION\nAUTO-ECOLE\n24/7\nGare\nBar","PROGRAMMER","ANNULER");
}
else if(!IsPlayerInAnyVehicle(playerid))
{
SendClientMessage(playerid,rouge,"Vous n'êtes pas dans un véhicule pour allumer le GPS");
}
}
return 1;
}
if(strcmp(cmdtext,"/sirene",true)==0)
{
if(metier[playerid]!=5) return SendClientMessage(playerid,rouge,"Vous n'êtes pas policier vous ne possédez donc pas de girophare");
{
if(!v1 || !v2) return SendClientMessage(playerid,rouge,"Vous n'êtes pas dans un véhicule de la B.C pour pouvoir mettre un girophare");
{
if(giro[vehicleid]==1) return SendClientMessage(playerid,rouge,"Ce véhicule a déjà un girophare sur le toit.Pour l'enlever taper /unsirene");
{
giro[vehicleid]=1;
SendClientMessage(playerid,vert,"Girophare mis avec succès");
girophare = CreateObject(18646,0,0,0,0,0,0);
AttachObjectToVehicle(girophare, vehicleid, 0.299999,0.000000,0.674999,0.000000,0.000000,0.000000);
}
}
}
return 1;
}
if(strcmp(cmdtext,"/unsirene",true)==0)
{
if(metier[playerid]!=5) return SendClientMessage(playerid,rouge,"Vous n'êtes pas policier vous ne possédez donc pas de girophare");
{
if(!v1 || !v2) return SendClientMessage(playerid,rouge,"Vous n'êtes pas dans un véhicule de la B.C pour pouvoir mettre un girophare");
{
if(giro[vehicleid]==0) return SendClientMessage(playerid,rouge,"Ce véhicule ne comporte aucun girophare");
{
giro[vehicleid]=0;
SendClientMessage(playerid,vert,"Girophare enlevé avec succès");
DestroyObject(girophare);
}
}
}
return 1;
}
if(strcmp(cmdtext, "/decharger", true) == 0)
{
if(mission[playerid]==1)
if(IsPlayerInRangeOfPoint(playerid,8.0,-2726.8450,-309.4221,7.0391))
if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 482)
{
SendClientMessage(playerid,0x1CE3CFFF,"[PATRON]Merci mec tiens prends en un peu");
SendClientMessage(playerid,jaune,"Tu as livré ces drogues tu as donc gagné 500$");
DisablePlayerCheckpoint(playerid);
SetPlayerWantedLevel(playerid,GetPlayerWantedLevel(playerid)+2);
GivePlayerMoney(playerid,500);
mission[playerid]=0;
SetTimerEx("Drugoff",60000,0,"i",playerid);
}
else if(mission[playerid]<1 || metier[playerid]>1)
{
SendClientMessage(playerid,rouge,"Vous n'avez pas pris de drogue retournez à la base en rechercher");
}
else if(!IsPlayerInRangeOfPoint(playerid,8.0,-2726.8450,-309.4221,7.0391))
{
SendClientMessage(playerid,rouge,"Vous n'êtes pas à la planque pour pouvoir décharger la drogue");
}
else if(!GetVehicleModel(GetPlayerVehicleID(playerid) == 482))
{
SendClientMessage(playerid,rouge,"Vous n'avez pas de camionette pour pouvoir décharger la drogue");
}
return 1;
}
if (strcmp("/habit", cmdtext, true) == 0)
{
if(IsPlayerInRangeOfPoint(playerid,100.0,-2104.9915,-2245.0149,31.6315))
if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 403 || GetVehicleModel(GetPlayerVehicleID(playerid)) == 515)
{
mission[playerid]= 1;
ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "MISSION HABIT", " {0066cc}Tu as commencé une mission camionneur va au checkpoint indiquer sur ta map puis une fois dessus revient à la base et retape /habit", "OK", "OK");
SetPlayerCheckpoint(playerid,habit[rando1][0],habit[rando1][1],habit[rando1][2],3.0);
}
else if(!IsPlayerInRangeOfPoint(playerid,100.0,-2104.9915,-2245.0149,31.6315))
{
SendClientMessage(playerid,rouge,"Vous n'êtes pas à la base pour commencer une mission");
}
else if(!GetVehicleModel(GetPlayerVehicleID(playerid) == 403 || GetVehicleModel(GetPlayerVehicleID(playerid) == 515)))
{
SendClientMessage(playerid,rouge,"Vous n'êtes pas équipé d'un camion et d'une remorque pour pouvoir commencer la mission");
}
return 1;
}
if (strcmp("/secours", cmdtext, true) == 0)
{
if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 563)
{
ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "MISSION SECOURISTE", " {0066cc}Tu as commencé une mission secouriste va au checkpoint indiqué une fois dessus tape /secourir pour secourir la personne.", "OK", "OK");
SetPlayerCheckpoint(playerid,secour[rando3][0],secour[rando3][1],secour[rando3][2],3.0);
}
else if(!GetVehicleModel(GetPlayerVehicleID(playerid) == 563))
{
SendClientMessage(playerid,rouge,"Vous n'êtes pas dans le Raindance pour pouvoir commencer la mission");
}
return 1;
}
if(strcmp("/rep",cmdtext,true)==0)
{
new msgspeca[256];
if(IsPlayerAdmin(playerid))
if(IsPlayerInAnyVehicle(playerid))
{
GetPlayerName(playerid,pname,sizeof(pname));
SendClientMessage(playerid,vert,"Véhicule réparé avec succès");
RepairVehicle(vehicleid);
format(msgspeca,sizeof(msgspeca),"[SPEC]Admin %s a réparé son véhicule",pname);
SendAdminMessage(playerid,msgspeca,0);
printf("Admin %s a réparé son véhicule",pname);
}
else if(!IsPlayerAdmin(playerid))
{
SendClientMessage(playerid,rouge,"Vous n'êtes pas admin pour pouvoir utiliser cette commande");
}
else if(!IsPlayerInAnyVehicle(playerid))
{
SendClientMessage(playerid,rouge,"Vous n'êtes pas dans un véhicule pour pouvoir le réparé");
}
return 1;
}
	if(strcmp(cmdtext, "/rapport", true) == 0)
	{
	if(confirm[playerid]==1) return SendClientMessage(playerid,rouge,"Vous avez déjà crée un rapport que vous n'avez pas confirmé");
	{
	ShowPlayerDialog(playerid,69,DIALOG_STYLE_INPUT,"SUJET DU RAPPORT","{ffffff}Veuillez entrer le sujet de votre rapport (Cheat,insultes,bugs,nof etc...)","ENTRER","ANNULER");
	}
		return 1;
		}
		if(strcmp(cmdtext,"/confirm",true)==0)
		{
		if(rapport[playerid]==0) return SendClientMessage(playerid,rouge,"Vous n'avez crée aucun rapport");
		{
		GetPlayerName(playerid,pname,sizeof(pname));
		format(string,sizeof(string),"Rapport de %s: [%s]%s",pname,rapportsujet[playerid],rapportexte[playerid]);
		Rapport(string);
		SendClientMessage(playerid,vert,"Votre rapport a bien été envoyé aux admins présents et {ff0000}enregistré dans un fichier");
		printf(string);
		SendAdminMessage(playerid,string,0);
		rapport[playerid]=0;
		confirm[playerid]=0;
  }
  return 1;
  }
if(strcmp("/secourir", cmdtext, true) == 0)
{
if(!IsPlayerInAnyVehicle(playerid))
if(IsPlayerInRangeOfPoint(playerid,10.0,-2802.7136,-1532.6322,139.4382) || IsPlayerInRangeOfPoint(playerid,10.0,-2432.5562,-1325.8119,310.6184) || IsPlayerInRangeOfPoint(playerid,10.0,-2551.2959,-1471.9063,359.9337) || IsPlayerInRangeOfPoint(playerid,10.0,-2379.2834,-1614.9718,496.9742) || IsPlayerInRangeOfPoint(playerid,10.0,-2429.8967,-1698.2836,446.2047))
{
SendClientMessage(playerid,vert,"Vous avez secouru cette personne vous avez gagné 800$");
GivePlayerMoney(playerid,800);
GameTextForPlayer(playerid,"~g~ VOUS AVEZ SECOURU CETTE PERSONNE AVEC SUCCES",5000,5);
DisablePlayerCheckpoint(playerid);
SendClientMessage(playerid,jaune,"Pour recommencer une mission secouriste montez dans un Leviathan ou une Ambulance puis tapez /secoure");
ApplyAnimation( playerid,"BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0);
}
else if(IsPlayerInAnyVehicle(playerid))
{
SendClientMessage(playerid,rouge,"Tu es dans un véhicule et ne peux donc secourir la personne");
}
else if(!IsPlayerInRangeOfPoint(playerid,10.0,-2802.7136,-1532.6322,139.4382) || IsPlayerInRangeOfPoint(playerid,10.0,-2432.5562,-1325.8119,310.6184) || IsPlayerInRangeOfPoint(playerid,10.0,-2551.2959,-1471.9063,359.9337) || IsPlayerInRangeOfPoint(playerid,10.0,-2379.2834,-1614.9718,496.9742) || IsPlayerInRangeOfPoint(playerid,10.0,-2429.8967,-1698.2836,446.2047))
{
SendClientMessage(playerid,rouge,"Tu n'es pas au checkpoint indiquer pour secourir la personne");
}
return 1;
}
if (strcmp("/pilote", cmdtext, true) == 0)
{
if(metier[playerid]== 4)
if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 519 || GetVehicleModel(GetPlayerVehicleID(playerid))== 553)
{
mission[playerid]= 1;
ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "AIDE", " {0066cc}Tu as commencé un transport aérien va à l'aéroport indiquer pour transporter les passagers puis retape /pilote", "OK", "OK");
SetPlayerCheckpoint(playerid,pilote[rando2][0],pilote[rando2][1],pilote[rando2][2],3.0);
}
else if(!GetVehicleModel(GetPlayerVehicleID(playerid) == 519 || !GetVehicleModel(GetPlayerVehicleID(playerid)== 553)))
{
SendClientMessage(playerid,rouge,"Tu n'es pas dans un avion pour utiliser cette commande");
}
else if(metier[playerid]<4 || metier[playerid]>4)
{
SendClientMessage(playerid,rouge,"Tu n'es pas Pilote de Ligne pour utiliser cette commande");
}
return 1;
}
if(strcmp(cmd, "/bander", true) == 0 || strcmp(cmd, "/banderyeux", true) == 0)
 {
 new tmp[256];
	    if(IsPlayerConnected(playerid))
	    {
	        tmp = strtok(cmdtext, idx);
	        if(!strlen(tmp))
	        {
	        	SendClientMessage(playerid, orange, "Utilisation: /banderyeux [Id/Pseudo]");
				return 1;
			}
			giveplayerid = ReturnUser(tmp);
			if(IsPlayerConnected(giveplayerid))
			{
			    if(giveplayerid != INVALID_PLAYER_ID)
			    {
			            	if(GetPlayerVehicleID(playerid) != GetPlayerVehicleID(giveplayerid))
	        				{
               					SendClientMessage(playerid, rouge, "Vous devez être dans un véhicule pour bander les yeux d'une personne");
        						return 1;
	        				}
	        				GetPlayerName(playerid, sendername, sizeof(sendername));
	        				GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
	        				SetPlayerCameraPos(giveplayerid, 2000,-2000,2000);
							SetPlayerCameraLookAt(giveplayerid, 2000,-2000,2000);
			            	format(string, sizeof(string), "%s a bandé les yeux de %s il ne voit plus rien ", sendername, giveplayer);
			            	ProxDetector(30.0, playerid, string, jaune,jaune,jaune,jaune,jaune);
							ybande[giveplayerid]=1;
							format(string,sizeof(string),"[SPEC]%s a bandé les yeux de %s",sendername,giveplayer);
							SendAdminMessage(playerid,string,0);
							printf("%s a bandé les yeux de %s",sendername,giveplayer);
			        	}
			        	}
	    }
	    return 1;
	}
new clear;
new aclear;
//=======================================[ CLEAR PLAYER ]=============================================
	if(strcmp(cmdtext, "/clear", true) == 0)
	{
	new msgspeca[256];
	while(clear<100)
	{
	SendClientMessage(playerid,rouge," ");
	clear++;

	}
GetPlayerName(playerid,pname,sizeof(pname));
format(msgspeca,sizeof(msgspeca),"[SPEC]%s a nettoyé sa Chat Box",pname);
SendAdminMessage(playerid,msgspeca,0);
printf("%s a nettoyé sa ChatBox",pname);
    return 1;
}
//=======================[ ADMIN CLEAR ]======================================================
if(strcmp(cmdtext, "/aclear", true) ==0)
{
new msgspeca[256];
if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid,rouge,"Vous n'êtes pas admin pour pouvoir utiliser cette commande");
{
while(aclear<100)
{
SendClientMessageToAll(rouge," ");
aclear++;
}
GetPlayerName(playerid,pname,sizeof(pname));
format(msgspeca,sizeof(msgspeca),"[SPEC]Admin %s a nettoyé la Chat Box",pname);
SendAdminMessage(playerid,msgspeca,0);
printf("Admin %s a nettoyé la Chat Box",pname);
}
return 1;
}
if(strcmp("/vrespawn",cmdtext,true)==0)
{
if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid,rouge,"Vous n'êtes pas admin pour pouvoir utiliser cette commande");
if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,rouge,"Vous n'êtes pas dans un véhicule pour pouvoir utiliser cette commande");
{
SendClientMessage(playerid,vert,"Véhicule respawn avec succès");
SetVehicleToRespawn(vehicleid);
}
return 1;
}
if(strcmp("/vmodifcolor",cmdtext,true)==0)
{
if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid,rouge,"Vous n'êtes pas admin pour pouvoir utiliser cette commande");
if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,rouge,"Vous n'êtes pas dans un véhicule pour pouvoir utiliser cette commande");
{
SendClientMessage(playerid,vert,"Veuillez choisir la couleur qui vous convient");
ShowPlayerDialog(playerid, 1, DIALOG_STYLE_LIST, "COULEUR VEHICULE"," {000000}NOIR \n {ffffff}BLANC \n {0066ff}BLEU \n {ff0000}ROUGE \n {666666}GRIS \n {ff00ff}ROSE \n {ffff00}JAUNE \n {009900}VERT \n {990066}VIOLET", "PRENDRE", "ANNULER");
}
return 1;
}
}
    return SendClientMessage(playerid,rouge,"Vous avez entré une commande inconnue à notre serveur tapez /aide pour plus d'informations");
	}
public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
new engine, lights, alarm, doors, bonnet, boot, objective;
new string[256];
new Text:compteur;
new Float:x,Float:y,Float:z;
GetPlayerPos(playerid,x,y,z);
format(string,sizeof(string),"Vitesse: %d km/h",GetVehicleSpeed(vehicleid));
compteur=TextDrawCreate(508,413,string);
TextDrawTextSize(compteur,508,413);
TextDrawColor(compteur,cyan);
TextDrawBackgroundColor(compteur,0x000000);
TextDrawFont(compteur,0);
TextDrawShowForPlayer(playerid,compteur);
TextDrawSetOutline(serv , 1);
TextDrawSetProportional(serv , 1);
TextDrawSetShadow(serv , 1);
TextDrawUseBox(serv,true);
TextDrawBoxColor(serv,0x000000);
SetTimer("Compteur",1000,0);
TextDrawSetShadow(Textdraw4[playerid],1);
if(GetVehicleModel(vehicleid) == 403 || GetVehicleModel(vehicleid)== 515)
{
 if(metier[playerid]== 1)
 {
    SendClientMessage(playerid, vert, "Bienvenu camionneur dans votre véhicule de service.Tapez /essence ou /habit pour commencer une nouvelle mission");
 }
 else
 {
   SetPlayerPos(playerid,x,y,z);
   SendClientMessage(playerid, rouge, "Vous n'avez pas les clés de ce véhicule");
   GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
SetVehicleParamsEx(vehicleid, 0, 0, 1, 0, 0, 0, 0);
 }
}
if(GetVehicleModel(vehicleid) == 563 || GetVehicleModel(vehicleid)== 416 || GetVehicleModel(vehicleid)== 597)
{
 if(metier[playerid]== 2)
 {
    SendClientMessage(playerid, vert, "Bienvenu ambulancier dans votre véhicule de service.Tapez /secours pour commencer une mission");

 }
 else
 {
   SetPlayerPos(playerid,x,y,z);
   SendClientMessage(playerid, rouge, "Vous n'avez pas les clés de ce véhicule");
   GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
SetVehicleParamsEx(vehicleid, 0, 0, 1, 0, 0, 0, 0);
 }
}
if(GetVehicleModel(vehicleid) == 482)
{
 if(metier[playerid]== 3)
 {
    SendClientMessage(playerid, vert, "Bienvenu Dealer dans votre véhicule de deal.Tapez /drogue pour commencer un deal de drogue");

 }
 else
 {
   SetPlayerPos(playerid,x,y,z);
   SendClientMessage(playerid, rouge, "Vous n'avez pas les clés de ce véhicule");
   GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
SetVehicleParamsEx(vehicleid, 0, 0, 1, 0, 0, 0, 0);
 }
}
if(GetVehicleModel(vehicleid) == 519 || GetVehicleModel(vehicleid) == 553 || GetVehicleModel(vehicleid) == 603)
{
 if(metier[playerid]== 4)
 {
    SendClientMessage(playerid, vert, "Bienvenu Pilote de Ligne dans votre véhicule de service.Tapez /pilote pour commencer une mission");

 }
 else
 {
   SetPlayerPos(playerid,x,y,z);
   SendClientMessage(playerid, rouge, "Vous n'avez pas les clés de ce véhicule");
   GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
SetVehicleParamsEx(vehicleid, 0, 0, 1, 0, 0, 0, 0);
 }
}
if(GetVehicleModel(vehicleid) == 598 || GetVehicleModel(vehicleid) == 599 || GetVehicleModel(vehicleid)== 523)
{
 if(metier[playerid]== 5)
 {
    SendClientMessage(playerid, vert, "Bienvenu Policier dans votre véhicule de service.Tapez /aide pour connaître les différentes commandes disponibles pour vous");

 }
 else
 {
   SetPlayerPos(playerid,x,y,z);
   SendClientMessage(playerid, rouge, "Vous n'avez pas les clés de ce véhicule");
   GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
SetVehicleParamsEx(vehicleid, 0, 0, 1, 0, 0, 0, 0);
 }
 }
 if(GetVehicleModel(vehicleid) == 431 || GetVehicleModel(vehicleid) == 420 || GetVehicleModel(vehicleid)==438)
{
 if(metier[playerid]== 6)
 {
    SendClientMessage(playerid, vert, "Bienvenu Chauffeur dans votre véhicule de service.Tapez /aide pour connaître les différentes commandes disponibles pour vous");

 }
 else
 {
   SetPlayerPos(playerid,x,y,z);
   SendClientMessage(playerid, rouge, "Vous n'avez pas les clés de ce véhicule");
   GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
SetVehicleParamsEx(vehicleid, 0, 0, 1, 0, 0, 0, 0);
 }
}
if(GetVehicleModel(vehicleid)== 470 || GetVehicleModel(vehicleid)== 433 || GetVehicleModel(vehicleid)== 432 || GetVehicleModel(vehicleid)== 520 || GetVehicleModel(vehicleid)== 476)
{
 if(metier[playerid]== 7)
 {
    SendClientMessage(playerid, vert, "Bienvenu Militaire dans votre véhicule de service.Tapez /aide pour voir les commandes misent à votre disposition");

 }
 else
 {
   SetPlayerPos(playerid,x,y,z);
   SendClientMessage(playerid, rouge, "Vous n'avez pas les clés de ce véhicule");
   GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
SetVehicleParamsEx(vehicleid, 0, 0, 1, 0, 0, 0, 0);
 }
}
if(GetVehicleModel(vehicleid)== 453 || GetVehicleModel(vehicleid)== 454 || GetVehicleModel(vehicleid)== 484 || GetVehicleModel(vehicleid)== 530)
{
 if(metier[playerid]== 8)
 {
    SendClientMessage(playerid, vert, "Bienvenu Pêcheur dans votre bâteau de plaisance. Tapez /aide pour voir les commandes misent à votre disposition.");

 }
 else
 {
   SetPlayerPos(playerid,x,y,z);
   SendClientMessage(playerid, rouge, "Vous n'avez pas les clés de ce véhicule");
   GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
SetVehicleParamsEx(vehicleid, 0, 0, 1, 0, 0, 0, 0);
 }
}
if(GetVehicleModel(vehicleid)== 550 || GetVehicleModel(vehicleid)== 458)
{
 if(metier[playerid]== 9)
 {
    SendClientMessage(playerid, vert, "Bienvenu Instructeur dans votre véhicule de service. Tapez /aide pour voir les commandes misent à votre disposition.");

 }
 else
 {
   SetPlayerPos(playerid,x,y,z);
   SendClientMessage(playerid, rouge, "Vous n'avez pas les clés de ce véhicule");
   GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
SetVehicleParamsEx(vehicleid, 0, 0, 1, 0, 0, 0, 0);
 }
}
if(GetVehicleModel(vehicleid)== 462 || GetVehicleModel(vehicleid)== 522 || GetVehicleModel(vehicleid)== 521 || GetVehicleModel(vehicleid)== 468 || GetVehicleModel(vehicleid)== 463 || GetVehicleModel(vehicleid)== 471 || GetVehicleModel(vehicleid)== 461 || GetVehicleModel(vehicleid)== 481 || GetVehicleModel(vehicleid)== 509 || GetVehicleModel(vehicleid)== 510 || GetVehicleModel(vehicleid)== 581 || GetVehicleModel(vehicleid)== 586 || GetVehicleModel(vehicleid)== 448 || GetVehicleModel(vehicleid)== 523 )
{
if(PlayerInfo[playerid][pPcasque]==0) return SendClientMessage(playerid,rouge,"Vous n'avez pour l'instant aucun casque allez en acheter-un");
{
new pname[256];
GetPlayerName(playerid,pname,sizeof(pname));
SetPlayerAttachedObject(playerid,6,18977,2,0.061999,0.015000,-0.011000,95.300086,76.599983,3.300000,1.000000,1.000000,1.000000);
SendClientMessage(playerid,vert,"Casque mis avec succès");
format(string,sizeof(string),"%s a mis son casque",pname);
casque[playerid]=1;
ProxDetector(20.0,playerid,string,jaune,jaune,jaune,jaune,jaune);
}
}
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
new Float:x,Float:y,Float:z;
GetPlayerPos(playerid,x,y,z);
TextDrawSetShadow(Textdraw4[playerid],1);
if(mission[playerid]== 1)
{
DisablePlayerCheckpoint(playerid);
SendClientMessage(playerid,rouge,"Tu es sorti de ton véhicule donc tu as annulé ta mission");
}
if(casque[playerid]==1)
{
SendClientMessage(playerid,jaune,"Vous êtes sorti de votre moto votre casque s'est enlevé automatiquement");
RemovePlayerAttachedObject(playerid,6);
casque[playerid]=0;
}
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
if(oldstate==PLAYER_STATE_DRIVER || oldstate==PLAYER_STATE_PASSENGER && newstate==PLAYER_STATE_ONFOOT)
{
if(casque[playerid]==1)
{
SendClientMessage(playerid,jaune,"Vous êtes sorti de votre moto votre casque s'est enlevé automatiquement");
RemovePlayerAttachedObject(playerid,6);
casque[playerid]=0;
}
}
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
if(IsPlayerInRangeOfPoint(playerid,7.0,-1675.5332,414.5001,6.9068))
{
GameTextForPlayer(playerid,"~g~ LIVRAISON EFFECTUEE",5000,5);
GivePlayerMoney(playerid,2000);
SendClientMessage(playerid,vert,"Vous avez gagné 2000$ pour votre livraison bravo!");
DisablePlayerCheckpoint(playerid);
SendClientMessage(playerid,jaune,"Pour commencer une nouvelle mission retourner à la base puis faites /essence");
mission[playerid]= 0;
}
if(IsPlayerInRangeOfPoint(playerid,7.0,-2416.5349,974.9665,45.0240))
{
GameTextForPlayer(playerid,"~g~ LIVRAISON EFFECTUEE",5000,5);
GivePlayerMoney(playerid,2000);
SendClientMessage(playerid,vert,"Vous avez gagné 2000$ pour votre livraison bravo!");
DisablePlayerCheckpoint(playerid);
SendClientMessage(playerid,jaune,"Pour commencer une nouvelle mission retourner à la base puis faites /essence");
mission[playerid]= 0;
}
if(IsPlayerInRangeOfPoint(playerid,7.0,-1474.0569,1863.6008,32.3599))
{
GameTextForPlayer(playerid,"~g~ LIVRAISON EFFECTUEE",5000,5);
GivePlayerMoney(playerid,2000);
SendClientMessage(playerid,vert,"Vous avez gagné 2000$ pour votre livraison bravo!");
DisablePlayerCheckpoint(playerid);
SendClientMessage(playerid,jaune,"Pour commencer une nouvelle mission retourner à la base puis faites /essence");
mission[playerid]= 0;
}
if(IsPlayerInRangeOfPoint(playerid,7.0,-91.0539,-1169.4426,2.1304))
{
GameTextForPlayer(playerid,"~g~ LIVRAISON EFFECTUEE",5000,5);
GivePlayerMoney(playerid,2000);
SendClientMessage(playerid,vert,"Vous avez gagné 2000$ pour votre livraison bravo!");
DisablePlayerCheckpoint(playerid);
SendClientMessage(playerid,jaune,"Pour commencer une nouvelle mission retourner à la base puis faites /essence");
mission[playerid]= 0;
}
if(IsPlayerInRangeOfPoint(playerid,7.0,1937.5670,-1778.3977,13.1118))
{
GameTextForPlayer(playerid,"~g~ LIVRAISON EFFECTUEE",5000,5);
GivePlayerMoney(playerid,2000);
SendClientMessage(playerid,vert,"Vous avez gagné 2000$ pour votre livraison bravo!");
DisablePlayerCheckpoint(playerid);
SendClientMessage(playerid,jaune,"Pour commencer une nouvelle mission retourner à la base puis faites /essence");
mission[playerid]= 0;
}
if(IsPlayerInRangeOfPoint(playerid,7.0,-1885.1783,864.5337,34.8973))
{
GameTextForPlayer(playerid,"~g~ LIVRAISON EFFECTUEE",5000,5);
GivePlayerMoney(playerid,1000);
SendClientMessage(playerid,vert,"Vous avez gagné 1000$ pour votre livraison bravo!");
DisablePlayerCheckpoint(playerid);
SendClientMessage(playerid,jaune,"Pour commencer une nouvelle mission retourner à la base puis faites /habit");
mission[playerid]= 0;
}
if(IsPlayerInRangeOfPoint(playerid,7.0,-1704.7999,950.4305,24.6176))
{
GameTextForPlayer(playerid,"~g~ LIVRAISON EFFECTUEE",5000,5);
GivePlayerMoney(playerid,1000);
SendClientMessage(playerid,vert,"Vous avez gagné 1000$ pour votre livraison bravo!");
DisablePlayerCheckpoint(playerid);
SendClientMessage(playerid,jaune,"Pour commencer une nouvelle mission retourner à la base puis faites /habit");
mission[playerid]= 0;
}
if(IsPlayerInRangeOfPoint(playerid,7.0,-2377.1309,910.8334,45.1724))
{
GameTextForPlayer(playerid,"~g~ LIVRAISON EFFECTUEE",5000,5);
GivePlayerMoney(playerid,1000);
SendClientMessage(playerid,vert,"Vous avez gagné 1000$ pour votre livraison bravo!");
DisablePlayerCheckpoint(playerid);
SendClientMessage(playerid,jaune,"Pour commencer une nouvelle mission retourner à la base puis faites /habit");
mission[playerid]= 0;
}
if(IsPlayerInRangeOfPoint(playerid,7.0,2247.4409,-1663.7406,15.1996))
{
GameTextForPlayer(playerid,"~g~ LIVRAISON EFFECTUEE",5000,5);
GivePlayerMoney(playerid,1000);
SendClientMessage(playerid,vert,"Vous avez gagné 1000$ pour votre livraison bravo!");
DisablePlayerCheckpoint(playerid);
SendClientMessage(playerid,jaune,"Pour commencer une nouvelle mission retourner à la base puis faites /habit");
mission[playerid]= 0;
}
if(IsPlayerInRangeOfPoint(playerid,7.0,1455.3796,-1153.3982,23.6252))
{
GameTextForPlayer(playerid,"~g~ LIVRAISON EFFECTUEE",5000,5);
GivePlayerMoney(playerid,1000);
SendClientMessage(playerid,vert,"Vous avez gagné 1000$ pour votre livraison bravo!");
DisablePlayerCheckpoint(playerid);
SendClientMessage(playerid,jaune,"Pour commencer une nouvelle mission retourner à la base puis faites /habit");
mission[playerid]= 0;
}
if(IsPlayerInRangeOfPoint(playerid,7.0,502.2471,-1358.5989,15.8611))
{
GameTextForPlayer(playerid,"~g~ LIVRAISON EFFECTUEE",5000,5);
GivePlayerMoney(playerid,1000);
SendClientMessage(playerid,vert,"Vous avez gagné 1000$ pour votre livraison bravo!");
DisablePlayerCheckpoint(playerid);
SendClientMessage(playerid,jaune,"Pour commencer une nouvelle mission retourner à la base puis faites /habit");
mission[playerid]= 0;
}
if(IsPlayerInRangeOfPoint(playerid,7.0,1983.7072,-2494.1772,13.8788))
{
GameTextForPlayer(playerid,"~g~ TRANSPORT EFFECTUE",5000,5);
GivePlayerMoney(playerid,3000);
SendClientMessage(playerid,vert,"Vous avez gagné 3000$ pour votre transport, la compagnie A.P Air vous remercie!");
mission[playerid]= 0;
DisablePlayerCheckpoint(playerid);
SendClientMessage(playerid,jaune,"Pour commencer une nouvelle mission faites /pilote");
}
if(IsPlayerInRangeOfPoint(playerid,7.0,1431.3889,1468.2025,11.1635))
{
GameTextForPlayer(playerid,"~g~ TRANSPORT EFFECTUE",5000,5);
GivePlayerMoney(playerid,3000);
SendClientMessage(playerid,vert,"Vous avez gagné 3000$ pour votre transport la compagnie A.P Air vous remercie!");
mission[playerid]= 0;
DisablePlayerCheckpoint(playerid);
SendClientMessage(playerid,jaune,"Pour commencer une nouvelle mission faites /pilote");
}
if(IsPlayerInRangeOfPoint(playerid,7.0,-1495.9304,-113.5655,13.8744))
{
GameTextForPlayer(playerid,"~g~ TRANSPORT EFFECTUE",5000,5);
GivePlayerMoney(playerid,3000);
SendClientMessage(playerid,vert,"Vous avez gagné 3000$ pour votre transport la compagnie A.P Air vous remercie!");
mission[playerid]= 0;
DisablePlayerCheckpoint(playerid);
SendClientMessage(playerid,jaune,"Pour commencer une nouvelle mission faites /pilote");
}
if(IsPlayerInRangeOfPoint(playerid,8.0,-2189.0200,-2373.2700,30.4625))
{
DisablePlayerCheckpoint(playerid);
SetPlayerCheckpoint(playerid,-2177.2495,-2348.5464,30.1959,8.0);
}
if(IsPlayerInRangeOfPoint(playerid,8.0,-2177.2495,-2348.5464,30.1959))
{
DisablePlayerCheckpoint(playerid);
SetPlayerCheckpoint(playerid,-2168.2249,-2300.6582,30.1958,8.0);
}
if(IsPlayerInRangeOfPoint(playerid,8.0,-2168.2249,-2300.6582,30.1958))
{
DisablePlayerCheckpoint(playerid);
SetPlayerCheckpoint(playerid,-2158.4878,-2254.1921,30.1959,8.0);
}
if(IsPlayerInRangeOfPoint(playerid,8.0,-2158.4878,-2254.1921,30.1959))
{
DisablePlayerCheckpoint(playerid);
SetPlayerCheckpoint(playerid,-2095.5757,-2275.5579,30.1959,8.0);
}
if(IsPlayerInRangeOfPoint(playerid,7.0,-2095.5757,-2275.5579,30.1959))
{
DisablePlayerCheckpoint(playerid);
SetPlayerCheckpoint(playerid,-2105.3757,-2323.6016,30.1962,8.0);
}
if(IsPlayerInRangeOfPoint(playerid,7.0,-2105.3757,-2323.6016,30.1962))
{
DisablePlayerCheckpoint(playerid);
SetPlayerCheckpoint(playerid,-2118.5796,-2373.6448,30.1958,8.0);
}
if(IsPlayerInRangeOfPoint(playerid,7.0,-2118.5796,-2373.6448,30.1958))
{
DisablePlayerCheckpoint(playerid);
SetPlayerCheckpoint(playerid,-2162.4714,-2429.1497,30.1958,8.0);
}
if(IsPlayerInRangeOfPoint(playerid,7.0,-2162.4714,-2429.1497,30.1958))
{
DisablePlayerCheckpoint(playerid);
SetPlayerCheckpoint(playerid,-2187.1475,-2496.0679,30.1958,8.0);
}
if(IsPlayerInRangeOfPoint(playerid,7.0,-2187.1475,-2496.0679,30.1958))
{
DisablePlayerCheckpoint(playerid);
SetPlayerCheckpoint(playerid,-2101.1313,-2505.3044,30.1959,8.0);
}
if(IsPlayerInRangeOfPoint(playerid,7.0,-2101.1313,-2505.3044,30.1959))
{
DisablePlayerCheckpoint(playerid);
SetPlayerCheckpoint(playerid,-2124.1682,-2454.2444,30.1962,8.0);
}
if(IsPlayerInRangeOfPoint(playerid,7.0,-2124.1682,-2454.2444,30.1962))
{
DisablePlayerCheckpoint(playerid);
SetPlayerCheckpoint(playerid,-2191.4128,-2486.5999,30.1958,8.0);
}
if(IsPlayerInRangeOfPoint(playerid,7.0,-2191.4128,-2486.5999,30.1958))
{
DisablePlayerCheckpoint(playerid);
SetPlayerCheckpoint(playerid,-2165.7927,-2439.4839,30.1959,8.0);
}
if(IsPlayerInRangeOfPoint(playerid,7.0,-2165.7927,-2439.4839,30.1959))
{
DisablePlayerCheckpoint(playerid);
SetPlayerCheckpoint(playerid,-2160.7903,-2392.5759,30.2714,8.0);
}
if(IsPlayerInRangeOfPoint(playerid,7.0,-2160.7903,-2392.5759,30.2714))
{
DisablePlayerCheckpoint(playerid);
GivePlayerMoney(playerid,500);
SendClientMessage(playerid,vert,"Vous avez gagné 500$ pour votre patrouille la police d'Angel Pine vous remercie");
GameTextForPlayer(playerid,"~g~ PATROUILLE EFFECTUE",5000,5);
}
if(IsPlayerInRangeOfPoint(playerid,7.0,-2726.8450,-309.4221,7.0391))
{
SendClientMessage(playerid,jaune,"Tapez /decharger pour décharger la drogue de votre camionette");
}
				new rando4 = random(sizeof(taxi));
if(IsPlayerInRangeOfPoint(playerid,5.0,-2525.6379,-609.9336,132.3093) ||IsPlayerInRangeOfPoint(playerid,5.0,-2724.9463,-310.9633,6.7832) || IsPlayerInRangeOfPoint(playerid,5.0,-1821.8961,17.0387,14.8400) || IsPlayerInRangeOfPoint(playerid,5.0,-2398.8813,1116.6245,55.4519) || IsPlayerInRangeOfPoint(playerid,5.0,-2412.0803,330.7469,34.6874))
{
SendClientMessage(playerid,vert,"Conduis ce client à sa destination demandée");
DisablePlayerCheckpoint(playerid);
SetPlayerCheckpoint(playerid,taxi[rando4][0],taxi[rando4][1],taxi[rando4][2],3.0);
}
if(IsPlayerInRangeOfPoint(playerid,5.0,-1604.9218,720.9513,11.6951) || IsPlayerInRangeOfPoint(playerid,5.0,-1646.5613,1215.0417,7.0028) ||IsPlayerInRangeOfPoint(playerid,5.0,-2624.2891,1410.0417,6.9210) ||IsPlayerInRangeOfPoint(playerid,5.0,-1975.1097,289.8986,34.9952) ||IsPlayerInRangeOfPoint(playerid,5.0,-2080.2354,-94.7077,34.9874) ||IsPlayerInRangeOfPoint(playerid,5.0,-1427.6084,-291.7390,13.8935))
{
SendClientMessage(playerid,vert,"La Compagnie EVRA SF vous remercie de votre hospitalité");
DisablePlayerCheckpoint(playerid);
GivePlayerMoney(playerid,1000);
SendClientMessage(playerid,jaune,"Vous avez fini votre mission tapez /bus ou /taxi pour en recommencer une autre");
}
if(IsPlayerInRangeOfPoint(playerid,3.0,-2196.7065,-2271.3132,30.4360) || IsPlayerInRangeOfPoint(playerid,3.0,-2193.1270,-2293.5981,30.4357) || IsPlayerInRangeOfPoint(playerid,3.0,-2159.5649,-2389.3291,30.4357) || IsPlayerInRangeOfPoint(playerid,3.0,-2673.1653,-2374.0095,3.3257) || IsPlayerInRangeOfPoint(playerid,3.0,-2163.3433,-2419.6394,30.4362) || IsPlayerInRangeOfPoint(playerid,3.0,-2160.3938,-2419.3069,30.6250))
{
DisablePlayerCheckpoint(playerid);
SendClientMessage(playerid,vert,"Vous êtes arrivé à destination");
}
if(IsPlayerInRangeOfPoint(playerid,3.0,-2192.5742,642.7424,49.0084))
{
DisablePlayerCheckpoint(playerid);
SendClientMessage(playerid,jaune,"Vous vous êtes réfugié dans votre planque vous gagnez 500$");
GivePlayerMoney(playerid,500);
vol[playerid]=0;
}
if(IsPlayerInRangeOfPoint(playerid,3.0,-10.3536,-177.9040,1003.5469))
{
SendClientMessage(playerid,jaune,"[INFO]Tapez /acheter pour faire vos achats");
}
if(IsPlayerInRangeOfPoint(playerid,2.0,312.1375,-165.4500,999.6010))
{
ShowMenuForPlayer(ammu,playerid);
TogglePlayerControllable(playerid,0);
}
if(checkcp[playerid]==5)
{
AchievedPermis(playerid);
}
if(IsPlayerInRangeOfPoint(playerid,5.0,-104.7341,1354.5192,9.5089) || IsPlayerInRangeOfPoint(playerid,5.0,176.6050,1169.2396,14.3360) || IsPlayerInRangeOfPoint(playerid,5.0,-308.6200,829.9609,12.9293) || IsPlayerInRangeOfPoint(playerid,5.0,-683.9039,965.9741,11.7179) || IsPlayerInRangeOfPoint(playerid,5.0,-323.1439,1531.2491,74.9434) && checkcp[playerid]!= 5)
{
new string[256];
new rand1=random(sizeof(CpAleaPermis));
DisablePlayerCheckpoint(playerid);
SetPlayerCheckpoint(playerid,CpAleaPermis[rand1][0],CpAleaPermis[rand1][1],CpAleaPermis[rand1][2],5.0);
checkcp[playerid]++;
format(string,sizeof(string),"Il vous reste %d CheckPoints à passer",5-checkcp[playerid]);
SendClientMessage(playerid,orange,string);
}
if(IsPlayerInRangeOfPoint(playerid,3.0,x1,x2,x3))
{
GameTextForPlayer(playerid,"~y~ARRIVE A DESTINATION",5000,3);
DisablePlayerCheckpoint(playerid);
}
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
if(pickupid== market)
{
SetPlayerPos(playerid,-25.884498,-185.868988,1003.546875);
SetPlayerInterior(playerid,17);
SetPlayerCheckpoint(playerid,-10.3536,-177.9040,1003.5469,2.0);
SendClientMessage(playerid,vert,"Bienvenu au 24/7 d'Angel Pine");
}

if(pickupid== market2)
{
SetPlayerPos(playerid,-19.2287,1181.5573,19.3650);
SetPlayerInterior(playerid,0);
DisablePlayerCheckpoint(playerid);
SendClientMessage(playerid,vert,"Vous voici de retour dans la ville.Bonne Journée!");
}
if(pickupid== mill)
{
if(metier[playerid]<3 || metier[playerid]>3) return GameTextForPlayer(playerid,"~r~ VOUS DEVEZ ETRE DELINQUANT",5000,5);
{
GameTextForPlayer(playerid,"~b~ BIENVENU AU MARCHE NOIR\nTAPEZ ~g~ /MNOIR",5000,5);
}
}
if(pickupid== commi2)
{
SetPlayerInterior(playerid,0);
SetPlayerPos(playerid,-213.7934,979.6099,19.3346);
SendClientMessage(playerid,vert,"Vous voici de retour en ville.Bonne Journée");
}
if(pickupid== vestinfo)
{
if(metier[playerid]<5 || metier[playerid]>5) return GameTextForPlayer(playerid,"~r~ VOUS N'ETES PAS POLICIER",5000,5);
{
GameTextForPlayer(playerid,"~b~ TAPEZ ~g~ /DUTY ~b~ POUR VOUS METTRE EN SERVICE",5000,5);
}
}
if(pickupid== commi1)
{
SetPlayerInterior(playerid,5);
SetPlayerPos(playerid,322.7245,305.8021,999.1484);
SendClientMessage(playerid,vert,"Bienvenu au commisariat d'Angel-Pine");
}
if(pickupid == ammu2)
{
SetPlayerInterior(playerid,0);
SetPlayerPos(playerid,-312.0728,830.0394,14.2422);
SendClientMessage(playerid,vert,"Vous voici de retour en ville.Bonne Journée");
DisablePlayerCheckpoint(playerid);
}
if(pickupid == ammu1)
{
SetPlayerInterior(playerid,6);
SetPlayerPos(playerid,316.6829,-165.3712,999.6010);
SendClientMessage(playerid,vert,"Bienvenu à l'ammunation");
SetPlayerCheckpoint(playerid,312.1375,-165.4500,999.6010,2.0);
}
if(pickupid== pickuprepair || pickupid== pickup2repair)
{
GameTextForPlayer(playerid,"~b~TAPEZ LA COMMANDE ~g~ /REPAIR ~b~ POUR POUVOIR REPARER VOTRE VEHICULE",5000,5);
}
if(pickupid== banque1)
{
SetPlayerPos(playerid,2309.1252,-16.0755,26.7496);
SendClientMessage(playerid,vert,"Bienvenu à la banque, allez sur le pickup i pour pouvoir faire des transactions");
}
if(pickupid== banque2)
{
SetPlayerPos(playerid,-184.3524,1034.7491,19.7422);
SendClientMessage(playerid,vert,"Vous voici de retour en ville.Bonne journée");
}
if(pickupid== banque3)
{
GameTextForPlayer(playerid,"~g~/RETIRER\n~b~POUR RETIRER UN MONTANT DE VOTRE BANQUE",5000,5);
}
if(pickupid==autoecole1)
{
SetPlayerPos(playerid,1495.6390,1307.5577,1093.2920);
SetPlayerInterior(playerid,3);
SendClientMessage(playerid,vert,"Bienvenu à l'auto-école, pour passer votre permis allez sur le pickup i");
}
if(pickupid==autoecole2)
{
SetPlayerPos(playerid,-149.8545,1079.5879,19.7422);
SetPlayerInterior(playerid,0);
SendClientMessage(playerid,vert,"Vous voici de retour en ville. Bonne journée");
}
if(pickupid==autoecoleinfo)
{
GameTextForPlayer(playerid,"~g~TAPEZ /PASSERPERMIS POUR PASSER VOTRE PERMIS",5000,5);
}
if(pickupid==bar1)
{
SendClientMessage(playerid,vert,"Bienvenue au bar d'Angel-Pine");
SetPlayerPos(playerid,-225.9351,1400.8958,27.7656);
SetPlayerInterior(playerid,18);
}
if(pickupid==bar2)
{
SendClientMessage(playerid,vert,"Vous voilà de retour en ville bonne journée!");
SetPlayerPos(playerid,-85.2414,1378.1438,10.2734);
SetPlayerInterior(playerid,0);
}
if(pickupid==bar3)
{
GameTextForPlayer(playerid,"~g~TAPEZ /BAR POUR COMMANDER UNE BOISSON",5000,5);
}
if(pickupid==radiopick)
{
GameTextForPlayer(playerid,"~g~TAPEZ /ANNONCE POUR FAIRE PASSER UNE ANNONCE",5000,5);
}
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
new Menu: Current=GetPlayerMenu(playerid);
if(Current==ammu)
{
if(row==0)
{
if(GetPlayerMoney(playerid)<5000) return SendClientMessage(playerid,rouge,"Vous n'avez pas assez d'argent (5.000$ requis)");
{
GivePlayerWeapon(playerid,24,100);
GivePlayerMoney(playerid,-5000);
SendClientMessage(playerid,gris,"Ammunation: Vous venez d'acheter ce Desert Eagle de 100 munitions");
TogglePlayerControllable(playerid,1);
}
}
if(row==1)
{
if(GetPlayerMoney(playerid)<7500) return SendClientMessage(playerid,rouge,"Vous n'avez pas assez d'argent (7.500$ requis)");
{
GivePlayerWeapon(playerid,29,250);
GivePlayerMoney(playerid,-7500);
SendClientMessage(playerid,gris,"Ammunation: Vous venez d'acheter ce Mp5 de 250 munitions");
TogglePlayerControllable(playerid,1);
}
}
if(row==2)
{
if(GetPlayerMoney(playerid)<15000) return SendClientMessage(playerid,rouge,"Vous n'avez pas assez d'argent (15.000$ requis)");
{
GivePlayerWeapon(playerid,30,300);
GivePlayerMoney(playerid,-15000);
SendClientMessage(playerid,gris,"Ammunation: Vous venez d'acheter ce Ak-47 de 300 munitions");
TogglePlayerControllable(playerid,1);
}
}
if(row==3)
{
if(GetPlayerMoney(playerid)<5000) return SendClientMessage(playerid,rouge,"Vous n'avez pas assez d'argent (5.000$ requis)");
{
GivePlayerWeapon(playerid,25,100);
GivePlayerMoney(playerid,-5000);
SendClientMessage(playerid,gris,"Ammunation: Vous venez d'acheter ce Fusil de 100 munitions");
TogglePlayerControllable(playerid,1);
}
}
if(row==4)
{
if(GetPlayerMoney(playerid)<2500) return SendClientMessage(playerid,rouge,"Vous n'avez pas assez d'argent (2.500$ requis)");
{
GivePlayerWeapon(playerid,22,150);
GivePlayerMoney(playerid,-2500);
SendClientMessage(playerid,gris,"Ammunation: Vous venez d'acheter ces Pistolets de 150 munitions");
TogglePlayerControllable(playerid,1);
}
}
if(row==5)
{
TogglePlayerControllable(playerid,1);
HideMenuForPlayer(ammu,playerid);
}
}
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
TogglePlayerControllable(playerid,1);
HideMenuForPlayer(ammu,playerid);
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
for(new i = 0; i < MAX_PLAYERS; i++)
{
if(success)
{
SendClientMessage(i,rose,"Vous vous êtes authentifié en admin");
SendClientMessage(i,jaune,"Vous pouvez voir les news admin à l'aide de la commande /anews");
return 1;
}
if(!success)
{
new pname[256];
GetPlayerName(i,pname,sizeof(pname));
new string[256];
successlogin[i]++;
format(string,sizeof(string),"Le mot de passe n'a pas abouti ce n'est donc ça.Vous avez %d/3 avertissements",successlogin[i]);
SendClientMessage(i,rouge,string);
format(string,sizeof(string),"[SPEC]%s a tenté une connexion à la console. Mot de passe entré: %s Ip: %s",pname,password,ip);
SendAdminMessage(i,string,0);
printf(string);
}
if(successlogin[i]==3)
{
new string[256];
new pname[256];
GetPlayerName(i,pname,sizeof(pname));
SendClientMessage(i,rouge,"Votre tentative de connexion à la console a échoué vous êtes maintenant banni");
BanEx(i,"Tentative de connexion à la console");
format(string,sizeof(string),"[ANNOUNCE]%s s'est fait bannir. Raison: Tentative de connexion à la console",pname);
SendClientMessageToAll(ADMIN_COLOR,string);
format(string,sizeof(string),"[SPEC]%s a tenté une connexion à la console. Mot de passe entré: %s Ip: %s",pname,password,ip);
SendAdminMessage(i,string,0);
printf(string);
}
return 1;
}
	return 1;
}

public OnPlayerUpdate(playerid)
{
 if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
        {
    TextDrawShowForPlayer(playerid, Textdraw4[playerid]);
        SetTimer("Compteur", 1000, 0);
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

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
new string[256];
new vehicleid=GetPlayerVehicleID(playerid);
	if(dialogid == 10)
{
if(response)
		{

			if(listitem == 0)
			{
				SetPlayerHealth(playerid,100);
				GivePlayerWeapon(playerid,25,200);
				GivePlayerWeapon(playerid,5,1);
				SendClientMessage(playerid,vert,"Vous avez choisi Camionneur comme job Bon Jeu");
				metier[playerid]= 1;
				SetPlayerPos(playerid,-2090.9336,-2260.7412,30.6250);
				SetPlayerSkin(playerid,260);

 			}
			if(listitem == 1)
			{
			    SetPlayerHealth(playerid, 100.0);
			    SetPlayerArmour(playerid, 25.0);
			    GivePlayerWeapon(playerid,4,1);
			    GivePlayerWeapon(playerid,22,200);
				SendClientMessage(playerid,vert,"Vous avez choisi Secouriste comme job Bon Jeu");
				metier[playerid]= 2;
				SetPlayerPos(playerid,-2204.0447,-2309.8958,31.3750);
				SetPlayerSkin(playerid,274);
				prioritaire[playerid]=1;
				}
				if(listitem == 2)
				{
				SetPlayerHealth(playerid,100.0);
				SetPlayerArmour(playerid,50.0);
				GivePlayerWeapon(playerid,4,1);
				GivePlayerWeapon(playerid,24,200);
				GivePlayerWeapon(playerid,29,200);
				SendClientMessage(playerid,vert,"Vous avez choisi Délinquant comme job Bon Jeu");
				metier[playerid]= 3;
				SetPlayerPos(playerid,deal);
				SetPlayerSkin(playerid,120);
				}
				if(listitem == 3)
				{
				SetPlayerHealth(playerid,100.0);
				GivePlayerWeapon(playerid,22,200);
				SendClientMessage(playerid,vert,"Vous avez choisi Pilote de Ligne comme job Bon Jeu");
				metier[playerid]= 4;
				SetPlayerPos(playerid,pilot);
				SetPlayerSkin(playerid,61);
				}
				if(listitem == 4)
				{
				SetPlayerHealth(playerid,100.0);
				GivePlayerWeapon(playerid,3,1);
				SendClientMessage(playerid,vert,"Vous avez choisi Policier comme job Bon Jeu");
				metier[playerid]= 5;
				SetPlayerPos(playerid,police);
				SetPlayerSkin(playerid,283);
				prioritaire[playerid]=1;
				}
				if(listitem == 5)
				{
				SetPlayerHealth(playerid,100.0);
				GivePlayerWeapon(playerid,22,200);
				SendClientMessage(playerid,vert,"Vous avez choisi Chauffeur de Bus/Taxi comme job Bon Jeu");
				metier[playerid]= 6;
				SetPlayerPos(playerid,bus);
				SetPlayerSkin(playerid,253);
				TextDrawShowForPlayer(playerid,charge);
                SetTimer("Chargement",5000,false);
                TogglePlayerControllable(playerid,0);
				}
				if(listitem == 6)
				{
				SetPlayerHealth(playerid,100.0);
				SetPlayerArmour(playerid,100.0);
				GivePlayerWeapon(playerid,16,200);
				GivePlayerWeapon(playerid,24,200);
				GivePlayerWeapon(playerid,31,200);
				GivePlayerWeapon(playerid,27,200);
				GivePlayerWeapon(playerid,34,200);
				SendClientMessage(playerid,vert,"Vous avez choisi Militaire comme job Bon Jeu");
				metier[playerid]= 7;
				SetPlayerSkin(playerid,287);
				SetPlayerPos(playerid,-1443.8810,453.8577,7.1875);
				prioritaire[playerid]=1;
				}
				if(listitem == 7)
				{
				SetPlayerHealth(playerid,100.0);
				GivePlayerWeapon(playerid,5,1);
				GivePlayerWeapon(playerid,22,200);
				SetPlayerSkin(playerid,48);
				SendClientMessage(playerid,vert,"Vous avez choisi Pêcheur comme job Bon Jeu");
				metier[playerid]= 8;
				SetPlayerPos(playerid,-2715.4150,-2234.7825,5.1172);
				TextDrawShowForPlayer(playerid,charge);
                SetTimer("Chargement",5000,false);
                TogglePlayerControllable(playerid,0);
				}
   			}
		}
	if(dialogid == 1)
		{
		if(response)
		{

			if(listitem == 0)
			{
	   ChangeVehicleColor(vehicleid,0,0);
	   }
	   if(listitem == 1)
	   {
	   ChangeVehicleColor(vehicleid,1,1);
	   }
	   if(listitem==2)
	{
	   ChangeVehicleColor(vehicleid,106,106);
	   }
	   if(listitem == 3)
	   {
	   ChangeVehicleColor(vehicleid,3,3);
	   }
	   if(listitem == 4)
	   {
	   ChangeVehicleColor(vehicleid,4,4);
	   }
	   if(listitem == 5)
	   {
	   ChangeVehicleColor(vehicleid,126,126);
	   }
	   if(listitem == 6)
	   {
	   ChangeVehicleColor(vehicleid,6,6);
	   }
	   if(listitem == 7)
	   {
	   ChangeVehicleColor(vehicleid,86,86);
	   }
	   if(listitem == 8)
	   {
	   ChangeVehicleColor(vehicleid,22,22);
	   }
	   }
	   }
	   if(dialogid==963)
	   {
	   if(response)
	   {
	   if(listitem==0)
	   {
	   SetPlayerCheckpoint(playerid,-320.8312,1058.4899,19.4451,3.0);
	   }
	   if(listitem==1)
	   {
	   SetPlayerCheckpoint(playerid,-211.4530,976.2515,18.9038,3.0);
	}
	if(listitem==2)
	{
	}
	if(listitem==3)
	{
	SetPlayerCheckpoint(playerid,-2673.1653,-2374.0095,3.3257,3.0);
	}
	if(listitem==4)
	{
	SetPlayerCheckpoint(playerid,-2163.3433,-2419.6394,30.4362,3.0);
	}
	if(listitem==5)
	{
	SetPlayerCheckpoint(playerid,-2160.3938,-2419.3069,30.6250,3.0);
	}
	}
	}
	if(dialogid==2)
	{
	if(response)
	{
	if(listitem==0)
	{
	ShowPlayerDialog(playerid,3,DIALOG_STYLE_LIST,"ARMES DE POING"," Poing \n Coup de poing Américain","PRENDRE","ANNULER");
	}
	if(listitem==1)
	{
    ShowPlayerDialog(playerid,4,DIALOG_STYLE_LIST,"ARMES BLANCHES"," Club de Golf \n Matraque \n Couteau \n Bat de Baseball \n Pelle \n Queue de Billard \n Tronçonneuse \n Katana","PRENDRE","ANNULER");
    }
    if(listitem==2)
    {
    ShowPlayerDialog(playerid,5,DIALOG_STYLE_LIST,"USTENSILES"," Dildo 1 \n Dildo 2 \n Vibrateur 1 \n Vibrateur 2 \n Fleurs \n Canne","PRENDRE","ANNULER");
    }
    if(listitem==3)
    {
    ShowPlayerDialog(playerid,6,DIALOG_STYLE_LIST,"EXPLOSIFS"," Grenades \n Bombes Lacrymogènes \n Cocktails Molotovs \n Charges Explosifs ","PRENDRE","ANNULER");
    }
    if(listitem==4)
    {
    ShowPlayerDialog(playerid,7,DIALOG_STYLE_LIST,"PISTOLETS"," Pistolet \n Pistolet Silencieux \n Desert Eagle","PRENDRE","ANNULER");
    }
    if(listitem==5)
    {
    ShowPlayerDialog(playerid,8,DIALOG_STYLE_LIST,"FUSILS"," Fusil \n Fusil Canon Scié \n Fusil de Combat","PRENDRE","ANNULER");
    }
    if(listitem==6)
    {
    ShowPlayerDialog(playerid,9,DIALOG_STYLE_LIST,"ARMES AUTOMATIQUES"," Uzi \n Mp5 \n Tec-9","PRENDRE","ANNULER");
    }
    if(listitem==7)
    {
    ShowPlayerDialog(playerid,11,DIALOG_STYLE_LIST,"ARMES DE GUERRE"," Ak-47 \n M4","PRENDRE","ANNULER");
    }
    if(listitem==8)
    {
    ShowPlayerDialog(playerid,12,DIALOG_STYLE_LIST,"FUSILS D'ASSAUT"," Fusil de Chasse \n Sniper","PRENDRE","ANNULER");
    }
    if(listitem==9)
    {
    ShowPlayerDialog(playerid,13,DIALOG_STYLE_LIST,"ARMES MILITAIRES"," Lance-Roquettes \n HS Roquettes \n Lance-Flammes \n Minigun","PRENDRE","ANNULER");
    }
    if(listitem==10)
    {
    ShowPlayerDialog(playerid,14,DIALOG_STYLE_LIST,"OBJETS"," Détonateur \n Tagueur \n Extincteur \n Appareil Photo","PRENDRE","ANNULER");
    }
    if(listitem==11)
	{
 ShowPlayerDialog(playerid,15,DIALOG_STYLE_LIST,"OBJETS MILITAIRES"," Lunettes à vision Nocturne \n Lunettes Infrarouge \n Parachute","PRENDRE","ANNULER");
 }
 }
 }
 if(dialogid==3)
 {
 if(response)
 {
 if(listitem==0)
 {
 GivePlayerWeapon(playerid,0,9999);
 SendClientMessage(playerid,vert,"Voici une main :D");
 }
 if(listitem==1)
 {
 GivePlayerWeapon(playerid,1,0);
 SendClientMessage(playerid,vert,"Voici un coup de poing américain");
 }
 }
 }
 if(dialogid==4)
 {
 if(response)
 {
 if(listitem==0)
 {
 GivePlayerWeapon(playerid,2,9999);
 SendClientMessage(playerid,vert,"Voici un club de golf");
 }
 if(listitem==1)
 {
 GivePlayerWeapon(playerid,3,9999);
 SendClientMessage(playerid,vert,"Voici une matraque");
 }
 if(listitem==2)
 {
 GivePlayerWeapon(playerid,4,9999);
 SendClientMessage(playerid,vert,"Voici un couteau");
 }
 if(listitem==3)
 {
 GivePlayerWeapon(playerid,5,9999);
 SendClientMessage(playerid,vert,"Voici une bat de baseball");
 }
 if(listitem==4)
 {
 GivePlayerWeapon(playerid,6,9999);
 SendClientMessage(playerid,vert,"Voici une pelle");
 }
 if(listitem==5)
 {
 GivePlayerWeapon(playerid,7,9999);
 SendClientMessage(playerid,vert,"Voici une queue de billard");
 }
 if(listitem==6)
 {
 GivePlayerWeapon(playerid,9,9999);
 SendClientMessage(playerid,vert,"Voici une tronçonneuse");
 }
 if(listitem==7)
 {
 GivePlayerWeapon(playerid,8,9999);
 SendClientMessage(playerid,vert,"Voici un Katana");
  }
 }
 }
 if(dialogid==5)
 {
 if(response)
 {
 if(listitem==0)
 {
 GivePlayerWeapon(playerid,10,9999);
 SendClientMessage(playerid,vert,"Voici un dildo 1");
 }
 if(listitem==1)
 {
 GivePlayerWeapon(playerid,11,9999);
 SendClientMessage(playerid,vert,"Voici un dildo 2");
 }
 if(listitem==2)
 {
 GivePlayerWeapon(playerid,12,9999);
 SendClientMessage(playerid,vert,"Voici un vibrateur 1");
 }
 if(listitem==3)
 {
 GivePlayerWeapon(playerid,13,9999);
 SendClientMessage(playerid,vert,"Voici un vibrateur 2");
 }
 if(listitem==4)
 {
 GivePlayerWeapon(playerid,14,9999);
 SendClientMessage(playerid,vert,"Voici des fleurs");
 }
 if(listitem==5)
 {
 GivePlayerWeapon(playerid,15,9999);
 SendClientMessage(playerid,vert,"Voici une canne");
 }
 }
 }
 if(dialogid==6)
 {
 if(response)
 {
 if(listitem==0)
 {
 GivePlayerWeapon(playerid,16,9999);
 SendClientMessage(playerid,vert,"Voici des grenades");
 }
 if(listitem==1)
 {
 GivePlayerWeapon(playerid,17,9999);
 SendClientMessage(playerid,vert,"Voici des bombes lacrymogènes");
 }
 if(listitem==2)
 {
 GivePlayerWeapon(playerid,18,9999);
 SendClientMessage(playerid,vert,"Voici des cocktails molotovs");
 }
 if(listitem==3)
 {
 GivePlayerWeapon(playerid,39,9999);
 SendClientMessage(playerid,vert,"Voici des charges explosifs");
 }
 }
 }
 if(dialogid==7)
 {
 if(response)
 {
 if(listitem==0)
 {
 GivePlayerWeapon(playerid,22,9999);
 SendClientMessage(playerid,vert,"Voici des pistolets");
 }
 if(listitem==1)
 {
 GivePlayerWeapon(playerid,23,9999);
 SendClientMessage(playerid,vert,"Voici un pistolet silencieux");
 }
 if(listitem==2)
 {
 GivePlayerWeapon(playerid,24,9999);
 SendClientMessage(playerid,vert,"Voici un Desert Eagle");
 }
 }
 }
 if(dialogid==8)
 {
 if(response)
 {
 if(listitem==0)
 {
 GivePlayerWeapon(playerid,25,9999);
 SendClientMessage(playerid,vert,"Voici un fusil");
 }
 if(listitem==1)
 {
 GivePlayerWeapon(playerid,26,9999);
 SendClientMessage(playerid,vert,"Voici un fusil canon scié");
 }
 if(listitem==2)
 {
 GivePlayerWeapon(playerid,27,9999);
 SendClientMessage(playerid,vert,"Voici un fusil de combat");
 }
 }
 }
 if(dialogid==9)
 {
 if(response)
 {
 if(listitem==0)
 {
 GivePlayerWeapon(playerid,28,9999);
 SendClientMessage(playerid,vert,"Voici un Uzi");
 }
 if(listitem==1)
 {
 GivePlayerWeapon(playerid,29,9999);
 SendClientMessage(playerid,vert,"Voici un Mp5");
 }
 if(listitem==2)
 {
 GivePlayerWeapon(playerid,32,9999);
 SendClientMessage(playerid,vert,"Voici un Tec-9");
 }
 }
 }
 if(dialogid==11)
 {
 if(response)
 {
 if(listitem==0)
 {
 GivePlayerWeapon(playerid,30,9999);
 SendClientMessage(playerid,vert,"Voici un Ak-47");
 }
 if(listitem==1)
 {
 GivePlayerWeapon(playerid,31,9999);
 SendClientMessage(playerid,vert,"Voici un M4");
 }
 }
 }
 if(dialogid==12)
 {
 if(response)
 {
 if(listitem==0)
 {
 GivePlayerWeapon(playerid,33,9999);
 SendClientMessage(playerid,vert,"Voici un Fusil de Chasse");
 }
 if(listitem==1)
 {
 GivePlayerWeapon(playerid,34,9999);
 SendClientMessage(playerid,vert,"Voici un Sniper");
 }
 }
 }
 if(dialogid==13)
 {
 if(response)
 {
 if(listitem==0)
 {
 GivePlayerWeapon(playerid,35,9999);
 SendClientMessage(playerid,vert,"Voici un Lance-Roquettes");
 }
 if(listitem==1)
 {
 GivePlayerWeapon(playerid,36,9999);
 SendClientMessage(playerid,vert,"Voici un H.S Roquettes");
 }
 if(listitem==2)
 {
 GivePlayerWeapon(playerid,37,9999);
 SendClientMessage(playerid,vert,"Voici un Lance-Flammes");
 }
 if(listitem==3)
 {
 GivePlayerWeapon(playerid,38,9999);
 SendClientMessage(playerid,vert,"Voici un Minigun");
 }
 }
 }
 if(dialogid==14)
 {
 if(response)
 {
 if(listitem==0)
 {
 GivePlayerWeapon(playerid,39,9999);
 SendClientMessage(playerid,vert,"Voici un Détonateur");
 }
 if(listitem==1)
 {
 GivePlayerWeapon(playerid,40,9999);
 SendClientMessage(playerid,vert,"Voici un Tagueur");
 }
 if(listitem==2)
 {
 GivePlayerWeapon(playerid,41,9999);
 SendClientMessage(playerid,vert,"Voici un Extincteur");
 }
 if(listitem==3)
 {
 GivePlayerWeapon(playerid,42,9999);
 SendClientMessage(playerid,vert,"Voici un Appareil Photo");
 }
 }
 }
 if(dialogid==15)
 {
 if(response)
 {
 if(listitem==0)
 {
 GivePlayerWeapon(playerid,43,9999);
 SendClientMessage(playerid,vert,"Voici des Lunettes à Vision Nocturne");
 }
 if(listitem==1)
 {
 GivePlayerWeapon(playerid,44,9999);
 SendClientMessage(playerid,vert,"Voici des Lunettes Infrarouge");
 }
 if(listitem==2)
 {
 GivePlayerWeapon(playerid,45,9999);
 SendClientMessage(playerid,vert,"Voici un Parachute");
 }
 }
 }
 if(dialogid==18)
 {
 if(response)
 {
 new pname[256];
 GetPlayerName(playerid,pname,sizeof(pname));
 printf("%s a utilisé la commande /reboot",pname);
format(string,sizeof(string),"[SPEC]Admin %s a déclenché un reboot à l'aide de la commande /reboot",pname);
SendAdminMessage(playerid,string,0);
 if(listitem==0)
 {
 SetTimerEx("Reboot",0,false,"i",playerid);
 SendClientMessageToAll(rouge,"[REBOOT]Le Serveur reboot");
 }
 if(listitem==1)
 {
 SetTimerEx("Reboot",30000,false,"i",playerid);
 SendClientMessageToAll(rouge,"[REBOOT]Le Serveur va reboot dans 30 secondes");
 }
 if(listitem==2)
 {
 SetTimerEx("Reboot",60000,false,"i",playerid);
 SendClientMessageToAll(rouge,"[REBOOT]Le Serveur va reboot dans 1 minute");
 }
 if(listitem==3)
 {
 SetTimerEx("Reboot",120000,false,"i",playerid);
 SendClientMessageToAll(rouge,"[REBOOT]Le Serveur va reboot dans 2 minutes");
 }
 if(listitem==4)
 {
 SetTimerEx("Reboot",300000,false,"i",playerid);
 SendClientMessageToAll(rouge,"[REBOOT]Le Serveur va reboot dans 5 minutes");
 }
 if(listitem==5)
 {
 SetTimerEx("Reboot",600000,false,"i",playerid);
 SendClientMessageToAll(rouge,"[REBOOT]Le Serveur va reboot dans 10 minutes");
 }
 }
 }
 if(dialogid==19)
 {
 if(response)
 {
 if(listitem==0)
 {
SendClientMessage(playerid,info3,".::AIDE::. /news: Pour connaître les récentes nouvelles  /buylevel: Pour acheter un niveau (200.000$)");
SendClientMessage(playerid,info3,".::AIDE::. /level: Pour savoir votre niveau   /mc: Pour vous téléporter au Mont Chiliad (5.000$)     ");
SendClientMessage(playerid,info3,".::AIDE::. /louer: Pour louer un véhicule louable  /payer: Pour donner une somme d'argent à une personne ");
SendClientMessage(playerid,info3,".::AIDE::. /but: Pour savoir le but de ce serveur  /credits: Pour connaître les credits du serveur   ");
SendClientMessage(playerid,info3,".::AIDE::. /staff: Pour avoir la liste du staff  /mort: Pour se suicider  /acheter: Pour acheter différents articles");
SendClientMessage(playerid,info3,".::AIDE::. /peage: Pour payer le péage (500$)  /fumer: Pour fumer une cigarette (Briquet & Cigarette)");
SendClientMessage(playerid,info3,".::AIDE::. /stopfumer: Pour arrêter de fumer  /pause: Pour se mettre AFK  /mq: Pour quitter sa mission");
SendClientMessage(playerid,info3,".::AIDE::. /gps: Pour allumer votre gps (GPS)  /clear: Pour nettoyer votre Chat Box                   ");
SendClientMessage(playerid,info3,".::AIDE::. /ooc: Pour parler dans le canal OOC                                                        ");
 }
 if(listitem==1)
 {
 if(metier[playerid]==1)
 {
 SendClientMessage(playerid,info,".::CAMIONNEUR::. /essence: Pour commencer une livraison d'essence  /habit: Pour commencer une cargaison d'habits");
 }
 if(metier[playerid]==2)
 {
 SendClientMessage(playerid,info,".::SECOURISTE::. /sauver: Pour sauver la personne accidentée  /accident: Pour simuler un accident         ");
 SendClientMessage(playerid,info,".::SECOURISTE::. /secours: Pour commencer une mission secours /secourir: Pour secourir la personne        ");
 }
 if(metier[playerid]==3)
 {
 SendClientMessage(playerid,info,".::DELINQUANT::. /drogue: Pour commencer un trafic de drogue   /decharger: Pour décharger la drogue    ");
 SendClientMessage(playerid,info,".::DELINQUANT::. /volmaison: Pour voler une maison volable                                             ");
 }
 if(metier[playerid]==4)
 {
 SendClientMessage(playerid,info,".::PILOTE DE LIGNE::. /pilote: Pour commmencer un transport aérien");
 }
 if(metier[playerid]==5)
 {
 SendClientMessage(playerid,info,".::POLICIER::. /barrage: Pour placer un barrage  /men: Pour menotter une personne");
 SendClientMessage(playerid,info,".::POLICIER::. /unmen: Pour démenotter une personne  /constat: Pour faire le constat de l'accident      ");
 SendClientMessage(playerid,info,".::POLICIER::. /intervenir: Pour intervenir sur l'accident                                              ");
 }
 if(metier[playerid]==6)
 {
 SendClientMessage(playerid,info,".::CHAUFFEUR DE BUS/TAXI::. /bus: Pour commencer votre mission bus   /taxi: Pour commencer votre mission taxi ");
 }
 if(metier[playerid]==7)
 {
 SendClientMessage(playerid,info,".::MILITAIRE::. Bientôt quelques commandes à disposition ");
 }
 if(metier[playerid]==8)
 {
 SendClientMessage(playerid,info,".::PÊCHEUR::. Bientôt quelques commandes à disposition ");
 }
 }
 if(listitem==2)
 {
 if(PlayerInfo[playerid][pAdmin]<=0) return SendClientMessage(playerid,rouge,"Vous n'êtes pas admin pour voir leurs commandes");
 {
 if(PlayerInfo[playerid][pAdmin]>=1)
 {
 }
 }
 }
 }
 }
  switch( dialogid )
    {
        case DIALOG_REGISTER:
        {
        new pname[256];
            if (!response) return Kick(playerid);
            if(response)
            {
                if(!strlen(inputtext)) return ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_INPUT, ""COL_WHITE"Enregistrement",""COL_RED"Le Mot de passe entré est invalide\n"COL_WHITE"Entrer un mot de passe valide pour pouvoir vous enregistrer.","S'enregistrer","Quitter");
                new INI:File = INI_Open(UserPath(playerid));
                INI_SetTag(File,"data");
                INI_WriteInt(File,"Password",udb_hash(inputtext));
                INI_WriteInt(File,"Cash",0);
                INI_WriteInt(File,"Admin",0);
                INI_WriteInt(File,"Kills",0);
                INI_WriteInt(File,"Deaths",0);
                INI_WriteInt(File,"Niveau",0);
				INI_WriteInt(File,"Casque",0);
				INI_WriteInt(File,"GPS",0);
				INI_WriteInt(File,"Briquet",0);
				INI_WriteInt(File,"Admin Level",0);
				INI_WriteInt(File,"Banque",0);
				INI_WriteInt(File,"Métier",0);
				INI_WriteInt(File,"Permis Voiture",0);
				INI_WriteInt(File,"Permis Moto",0);
				INI_WriteInt(File,"Permis Poids Lourd",0);
				INI_WriteInt(File,"Permis Arme",0);
				INI_WriteInt(File,"Permis Vol",0);
				INI_WriteInt(File,"Permis Bâteau",0);
                INI_Close(File);
                logged[playerid]=1;
                GetPlayerName(playerid,pname,sizeof(pname));
                format(string,sizeof(string),"{00ff00}Votre compte a été crée avec succès:\n{0099ff}Nom de Compte: {ffff00}%s\n{0099ff}Mot de Passe: {ffff00}%s",pname,inputtext);
                ShowPlayerDialog(playerid, DIALOG_SUCCESS_1, DIALOG_STYLE_MSGBOX,"Inscription Infos",string,"Confirmer","Fermer");
                format(string,sizeof(string),"[SPEC]%s s'est inscrit avec le mot de passe: %s",pname,inputtext);
                SendAdminMessage(playerid,string,0);
				printf("%s s'est connecté avec le mot de passe: %s",pname,inputtext);
				SpawnPlayer(playerid);
			}
        }

        case DIALOG_LOGIN:
        {
        new pname[256];
            if ( !response ) return Kick ( playerid );
            if( response )
            {
                if(udb_hash(inputtext) != PlayerInfo[playerid][pPass]) return ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_INPUT,""COL_WHITE"Connection",""COL_RED"Vous avez entré un mot de passe invalide.\n"COL_WHITE"Veuillez entrer votre mot de passe pour vous connecter.","Connexion","Quitter");
                {
                    INI_ParseFile(UserPath(playerid), "LoadUser_%s", .bExtra = true, .extra = playerid);
                    GivePlayerMoney(playerid, PlayerInfo[playerid][pCash]);
                    PlayerInfo[playerid][pLevel]=PlayerInfo[playerid][pNiveau];
                    SetPlayerScore(playerid,PlayerInfo[playerid][pLevel]);
                    PlayerInfo[playerid][pPcasque]=PlayerInfo[playerid][pCasque];
                    logged[playerid]=1;
                    PlayerInfo[playerid][pBanque]=PlayerInfo[playerid][pPbanque];
                    metier[playerid]=PlayerInfo[playerid][pMetier];
                    gps[playerid]=PlayerInfo[playerid][pGps];
					briquet[playerid]=PlayerInfo[playerid][pBriquet];
					PlayerInfo[playerid][pAdmin]=PlayerInfo[playerid][pAlevel];
					permis[playerid][pVoiture]=PlayerInfo[playerid][pPermisv];
					permis[playerid][pMoto]=PlayerInfo[playerid][pPermism];
					permis[playerid][pPoidsLourd]=PlayerInfo[playerid][pPermisp];
					permis[playerid][pArme]=PlayerInfo[playerid][pPermisa];
					permis[playerid][pVol]=PlayerInfo[playerid][pPermisvol];
					permis[playerid][pBateau]=PlayerInfo[playerid][pPermisb];
					SendClientMessage(playerid,vert,"Connection établie avec succès");
					GetPlayerName(playerid,pname,sizeof(pname));
					format(string,sizeof(string),"[SPEC]%s s'est connecté avec le mot de passe: %s",pname,inputtext);
					SendAdminMessage(playerid,string,0);
					printf("%s s'est connecté avec le mot de passe: %s",pname,inputtext);
                }
                if(metier[playerid]==0)
{
SetPlayerPos(playerid,-134.7689,917.9264,19.4042);
SetPlayerSkin(playerid,3);
}
 if(metier[playerid]==1)
                {
                GiveCInfos(playerid);
                }
                if(metier[playerid]==2)
                {
                GiveSInfos(playerid);
                }
                if(metier[playerid]==3)
				{
				GiveDInfos(playerid);
				}
				if(metier[playerid]==4)
				{
				GivePInfos(playerid);
				}
				if(metier[playerid]==5)
				{
				GivePoInfos(playerid);
				}
				if(metier[playerid]==6)
				{
				GiveChInfos(playerid);
				}
				if(metier[playerid]==7)
				{
				GiveMInfos(playerid);
				}
				if(metier[playerid]==8)
				{
				GivePeInfos(playerid);
				}
				if(metier[playerid]==9)
				{
				GiveIInfos(playerid);
				}

				}
                return 1;
            }
            }

    

if(dialogid==21)
{
if(response)
{
if(listitem==0)
{
if(GetPlayerMoney(playerid)<5) return SendClientMessage(playerid,rouge,"Vous n'avez pas assez d'argent pour vous payer ce briquet");
{
if(briquet[playerid]==1) return SendClientMessage(playerid,gris,"Vous possédez déjà un briquet vous ne pouvez donc en acheter un autre");
{
SendClientMessage(playerid,jaune,"[CAISSE]Vous avez acheté ce briquet à 5$");
GivePlayerMoney(playerid,-5);
briquet[playerid]=1;
SendClientMessage(playerid,gris,"Note: Si vous avez des cigarettes vous pouvez fumer à l'aide de /fumer");
}
}
}
if(listitem==1)
{
if(GetPlayerMoney(playerid)<10) return SendClientMessage(playerid,rouge,"Vous n'avez pas assez d'argent pour vous payer ce paquet de cigarette");
{
SendClientMessage(playerid,jaune,"[CAISSE]Vous avez acheté ce paquet de cigarette à 10$");
GivePlayerMoney(playerid,-10);
cigarette[playerid]++;
SendClientMessage(playerid,gris,"Note: Si vous avez un briquet vous pouvez fumer à l'aide de /fumer");
}
}
if(listitem==2)
{
if(GetPlayerMoney(playerid)<500) return SendClientMessage(playerid,rouge,"Vous n'avez pas assez d'argent pour vous payer ce décodeur");
{
if(decodeur[playerid]==1) return SendClientMessage(playerid,gris,"Vous possédez déjà un décodeur vous ne pouvez donc en acheter un autre");
{
SendClientMessage(playerid,jaune,"[CAISSE]Vous avez acheté ce décodeur à 500$");
GivePlayerMoney(playerid,-500);
decodeur[playerid]=1;
}
}
}
if(listitem==3)
{
if(GetPlayerMoney(playerid)<25) return SendClientMessage(playerid,rouge,"Vous n'avez pas assez d'argent pour vous payer cette canne à pêche");
{
SendClientMessage(playerid,jaune,"[CAISSE]Vous avez acheté cette canne à pêche à 25$");
GivePlayerMoney(playerid,-25);
canne[playerid]=1;
}
}
if(listitem==4)
{
if(GetPlayerMoney(playerid)<200) return SendClientMessage(playerid,rouge,"Vous n'avez pas assez d'argent pour vous payer ce TomTom");
{
if(gps[playerid]==1) return SendClientMessage(playerid,gris,"Vous possédez déjà un GPS vous ne pouvez donc en acheter un autre");
{
SendClientMessage(playerid,jaune,"[CAISSE]Vous avez acheté ce TomTom à 200$");
GivePlayerMoney(playerid,-200);
gps[playerid]=1;
SendClientMessage(playerid,gris,"Note: Vous pouvez maintenant utiliser le GPS à l'aide de /gps");
}
}
}
if(listitem==5)
{
if(GetPlayerMoney(playerid)<2) return SendClientMessage(playerid,rouge,"Vous n'avez pas assez d'argent pour vous payer cette poire");
{
SendClientMessage(playerid,jaune,"[CAISSE]Vous avez acheté cette poire à 2$");
GivePlayerMoney(playerid,-2);
format(string,sizeof(string),"Vous avez maintenant %d poires",poire[playerid]);
SendClientMessage(playerid,gris,string);
poire[playerid]++;
}
}
if(listitem==6)
{
if(GetPlayerMoney(playerid)<2) return SendClientMessage(playerid,rouge,"Vous n'avez pas assez d'argent pour vous payer cette pomme");
{
SendClientMessage(playerid,jaune,"[CAISSE]Vous avez acheté cette pomme à 2$");
GivePlayerMoney(playerid,-2);
format(string,sizeof(string),"Vous avez maintenant %d pommes",pomme[playerid]);
SendClientMessage(playerid,gris,string);
pomme[playerid]++;
}
}
if(listitem==7)
{
if(GetPlayerMoney(playerid)<1) return SendClientMessage(playerid,rouge,"Vous n'avez pas assez d'argent pour vous payer cette pêche");
{
SendClientMessage(playerid,jaune,"[CAISSE]Vous avez acheté cette pêche à 1$");
GivePlayerMoney(playerid,-1);
format(string,sizeof(string),"Vous avez maintenant %d pêches",peche[playerid]);
SendClientMessage(playerid,gris,string);
peche[playerid]=1;
}
}
if(listitem==8)
{
if(GetPlayerMoney(playerid)<100) return SendClientMessage(playerid,rouge,"Vous n'avez pas assez d'argent pour vous payer cette cagoule");
{
SendClientMessage(playerid,jaune,"[CAISSE]Vous avez acheté cette cagoule à 100$");
GivePlayerMoney(playerid,-100);
cagoule[playerid]=1;
}
}
if(listitem==9)
{
if(GetPlayerMoney(playerid)<150) return SendClientMessage(playerid,rouge,"Vous n'avez pas assez d'argent pour vous payer ce casque");
{
if(PlayerInfo[playerid][pCasque]==1) return SendClientMessage(playerid,gris,"Vous possédez déjà un casque vous ne pouvez donc en acheter un autre");
{
SendClientMessage(playerid,jaune,"[CAISSE]Vous avez acheté ce casque à 150$");
GivePlayerMoney(playerid,-150);
PlayerInfo[playerid][pPcasque]=1;
SendClientMessage(playerid,gris,"Note: Quand vous monterez maintenant dans une moto votre casque se mettra automatiquement");
}
}
}
}
}
if(dialogid==98)
{
if(response)
{
if(listitem==0)
{
GiveInfosAttaq(playerid);
SendClientMessage(playerid,jaune,"Vous avez rejoint le mini-jeu sous la team Attaquants ");
TogglePlayerControllable(playerid,0);
SendClientMessage(playerid,orange,"Vous êtes freezé jusqu'à le début du mini-jeu");
mjoin[playerid]=1;
attaq[playerid]=1;
GiveTextDraw();
}
if(listitem==1)
{
GiveInfosDef(playerid);
SendClientMessage(playerid,jaune,"Vous avez rejoint le mini-jeu sous la team Défenseurs");
TogglePlayerControllable(playerid,0);
SendClientMessage(playerid,orange,"Vous êtes freezé jusqu'à le début du mini-jeu");
mjoin[playerid]=1;
def[playerid]=1;
GiveTextDraw();
}
}
}
if(dialogid==69)
{
if(response)
{
format(string,sizeof(string),"%s",inputtext);
rapportsujet[playerid]=string;
format(string,sizeof(string),"Sujet de votre rapport: {00ffff}%s",inputtext);
SendClientMessage(playerid,orange,string);
ShowPlayerDialog(playerid,71,DIALOG_STYLE_INPUT,"MESSAGE DU RAPPORT","Veuillez entrer le pseudo du joueur que vous rapportez ainsi que la faute qu'a commise ce joueur","RAPPORTE","ANNULER");
}
}
if(dialogid==71)
{
if(response)
{
format(string,sizeof(string),"%s",inputtext);
new pname[256];
GetPlayerName(saveplayerid,pname,sizeof(pname));
rapportexte[playerid]=string;
format(string,sizeof(string),"Message du rapport: {00ffff}%s",inputtext);
SendClientMessage(playerid,orange,string);
format(string,sizeof(string),"{ffffff}Sujet: {00ffff}%s\n{ffffff}Message du rapport: {00ffff}%s",rapportsujet[playerid],rapportexte[playerid]);
ShowPlayerDialog(playerid,72,DIALOG_STYLE_MSGBOX,"RAPPORT",string,"OK","ANNULER");
SendClientMessage(playerid,jaune,"Votre rapport a été crée avec succès pour le confirmer tapez {00ffff}/confirm");
rapport[playerid]=1;
confirm[playerid]=1;
}
}
if(dialogid==964)
{
if(response)
{
if(listitem==0)
{
if(permis[playerid][pVoiture]==1) return SendClientMessage(playerid,rouge,"Vous avez déjà ce permis!");
{
if(GetPlayerMoney(playerid)<5000) return SendClientMessage(playerid,rouge,"Vous n'avez pas assez d'argent pour vous payer ce permis!");
{
PermisVoiture(playerid);
GivePlayerMoney(playerid,-5000);
timerlol=SetTimerEx("TimerPermis",1000,true,"i",playerid);
new rand1=random(sizeof(CpAleaPermis));
SetPlayerCheckpoint(playerid,CpAleaPermis[rand1][0],CpAleaPermis[rand1][1],CpAleaPermis[rand1][2],5.0);
permiscours[playerid]=1;
PutPlayerInVehicle(playerid,vspawn[playerid],0);
SetPlayerInterior(playerid,0);
ShowPlayerDialog(playerid,963,DIALOG_STYLE_MSGBOX,"PERMIS","Bienvenu dans l'interface Permis\nVous allez commencer le permis à bord de votre véhicule respectif à votre permis sélectionné\nVous devrez passer dans 5 CheckPoints placés aléatoirement dans les environs de Fort-Carson\nVous devrez passer ces CheckPoints sans abimer votre véhicule\nSi vous abimer votre véhicule votre permis sera échoué","OK","FERMER");
}
}
}
if(listitem==1)
{
if(permis[playerid][pMoto]==1) return SendClientMessage(playerid,rouge,"Vous avez déjà ce permis!");
{
if(GetPlayerMoney(playerid)<5000) return SendClientMessage(playerid,rouge,"Vous n'avez pas assez d'argent pour vous payer ce permis!");
{
GivePlayerMoney(playerid,-5000);
timerlol=SetTimerEx("TimerPermis",1000,true,"i",playerid);
new rand1=random(sizeof(CpAleaPermis));
SetPlayerCheckpoint(playerid,CpAleaPermis[rand1][0],CpAleaPermis[rand1][1],CpAleaPermis[rand1][2],5.0);
permiscours[playerid]=2;
PutPlayerInVehicle(playerid,vspawn[playerid],0);
SetPlayerInterior(playerid,0);
ShowPlayerDialog(playerid,963,DIALOG_STYLE_MSGBOX,"PERMIS","Bienvenu dans l'interface Permis\nVous allez commencer le permis à bord de votre véhicule respectif à votre permis sélectionné\nVous devrez passer dans 5 CheckPoints placés aléatoirement dans les environs de Fort-Carson\nVous devrez passer ces CheckPoints sans abimer votre véhicule\nSi vous abimer votre véhicule votre permis sera échoué","OK","FERMER");
PermisMoto(playerid);
}
}
}
if(listitem==2)
{
if(permis[playerid][pPoidsLourd]==1) return SendClientMessage(playerid,rouge,"Vous avez déjà ce permis!");
{
if(GetPlayerMoney(playerid)<5000) return SendClientMessage(playerid,rouge,"Vous n'avez pas assez d'argent pour vous payer ce permis!");
{
GivePlayerMoney(playerid,-5000);
timerlol=SetTimerEx("TimerPermis",1000,true,"i",playerid);
new rand1=random(sizeof(CpAleaPermis));
SetPlayerCheckpoint(playerid,CpAleaPermis[rand1][0],CpAleaPermis[rand1][1],CpAleaPermis[rand1][2],5.0);
permiscours[playerid]=3;
PutPlayerInVehicle(playerid,vspawn[playerid],0);
SetPlayerInterior(playerid,0);
ShowPlayerDialog(playerid,963,DIALOG_STYLE_MSGBOX,"PERMIS","Bienvenu dans l'interface Permis\nVous allez commencer le permis à bord de votre véhicule respectif à votre permis sélectionné\nVous devrez passer dans 5 CheckPoints placés aléatoirement dans les environs de Fort-Carson\nVous devrez passer ces CheckPoints sans abimer votre véhicule\nSi vous abimer votre véhicule votre permis sera échoué","OK","FERMER");
PermisPoidsLourd(playerid);
}
}
}
}
}
if(dialogid==39)
{
if(response)
{
if(listitem==0)
{
if(GetPlayerMoney(playerid)<=10) return SendClientMessage(playerid,rouge,"Vous n'avez pas assez d'argent pour envoyer un SMS (10$) ");
{
ShowPlayerDialog(playerid,40,DIALOG_STYLE_INPUT,"ENVOYER UN SMS","Veuillez entrer ci-dessous le SMS que vous voulez entrer. Coût du SMS: 10$","ENVOYER","FERMER");
}
}
if(listitem==3)
{
new pname[256];
GetPlayerName(playerid,pname,sizeof(pname));
format(string,sizeof(string),"%s souhaite vous demander un rendez-vous\nEn acceptant ce rendez-vous vous aurez accepté les règles du (/rdvrules)\nVous saurez sa position à laquelle il était lors de son envoi\nPour accepter le rendez-vous cliquez le bouton ACCEPTER en bas de ce dialog",pname);
ShowPlayerDialog(clickedplayer,41,DIALOG_STYLE_MSGBOX,"RENDEZ-VOUS",string,"ACCEPTER","REFUSER");
playerid=playerdemande;
}
}
}
if(dialogid==40)
{
if(response)
{
new pname[256];
GetPlayerName(playerid,pname,sizeof(pname));
format(string,sizeof(string),"[SMS]%s: %s",pname,inputtext);
SendSMS(clickedplayer,string);
SendClientMessage(playerid,vert,"SMS envoyé avec succès -10$");
GivePlayerMoney(playerid,-10);
}
}
if(dialogid==41)
{
if(response)
{
new Float:x;
new Float:y;
new Float:z;
x=x1;
x=x2;
x=x3;
GetPlayerPos(playerdemande,x,y,z);
SetPlayerCheckpoint(playerid,x,y,z,3.0);
SendClientMessage(playerid,vert,"Vous avez accepté son rendez-vous vous connaissez désormais sa position");
SendClientMessage(playerid,jaune,"Votre client connait désormais votre position il arrive d'une minute à l'autre");
}
}
if(dialogid==900)
{
if(response)
{
if(listitem==0)
{
if(pomme[playerid]<1) return SendClientMessage(playerid,rouge,"Vous n'avez aucunes pommes dans votre inventaire");
{
new Float:phealth;
GetPlayerHealth(playerid,phealth);
pomme[playerid]--;
SendClientMessage(playerid,vert,"Vous avez mangé une pomme vous récupérez 20 hp");
format(string,sizeof(string),"Il ne vous reste plus que %d pommes",pomme[playerid]);
SendClientMessage(playerid,gris,string);
SetPlayerHealth(playerid,phealth+20);
}
}
if(listitem==1)
{
if(poire[playerid]<1) return SendClientMessage(playerid,rouge,"Vous n'avez aucunes poires dans votre inventaire");
{
new Float:phealth;
GetPlayerHealth(playerid,phealth);
poire[playerid]--;
SendClientMessage(playerid,vert,"Vous avez mangé une poire vous récupérez 20 hp");
format(string,sizeof(string),"Il ne vous reste plus que %d poires",poire[playerid]);
SendClientMessage(playerid,gris,string);
SetPlayerHealth(playerid,phealth+20);
}
}
if(listitem==2)
{
if(peche[playerid]<1) return SendClientMessage(playerid,rouge,"Vous n'avez aucunes pêches dans votre inventaire");
{
new Float:phealth;
GetPlayerHealth(playerid,phealth);
peche[playerid]--;
SendClientMessage(playerid,vert,"Vous avez mangé une pêche vous récupérez 25 hp");
format(string,sizeof(string),"Il ne vous reste plus que %d pêches",peche[playerid]);
SendClientMessage(playerid,gris,string);
SetPlayerHealth(playerid,phealth+25);
}
}
}
}
if(dialogid==899)
{
new pname[256];
if(response)
{
if(listitem==0)
{
SendClientMessage(playerid,vert,"Catégorie: Boissons Gazeuses et Sodas");
ShowPlayerDialog(playerid,898,DIALOG_STYLE_LIST,"Boissons Gazeuses et Sodas","Coca Cola(20$)\nOrangina(20$)\nFanta(15$)\nPepsi(15$)\nChampomy(15$)\nSprite(10$)","ACHETER","FERMER");
}
if(listitem==1)
{
SendClientMessage(playerid,vert,"Catégorie: Alcools");
ShowPlayerDialog(playerid,897,DIALOG_STYLE_LIST,"Alcools","Cocktail alcoolisé(35$)\nChampagne(45$)\nPorto(75$)\nRhum(40$)\nTequila(65$)\nVin(50$)\nVodka(70$)\nWhisky(80$)","ACHETER","FERMER");
}
if(listitem==2)
{
SendClientMessage(playerid,vert,"Catégorie: Jus");
ShowPlayerDialog(playerid,896,DIALOG_STYLE_LIST,"Jus","Jus de pomme(5$)\nJus d'ananas(5$)\nJus d'orange(5$)\nJus de clémentine(5$)\nJus d'abricot(5$)\nJus de fraise(5$)\nJus de framboise(5$)\nJus de multifruits(10$)","ACHETER","FERMER");
}
if(listitem==3)
{
if(GetPlayerMoney(playerid)<=25) return SendClientMessage(playerid,rouge,"Vous n'avez pas assez d'argent pour vous payer ce café (25$)");
{
new Float:phealth;
GetPlayerHealth(playerid,phealth);
SetPlayerHealth(playerid,phealth+15);
GivePlayerMoney(playerid,-25);
SendClientMessage(playerid,gris,"**Ouille! Ce café est trop chaud**");
GetPlayerName(playerid,pname,sizeof(pname));
format(string,sizeof(string),"%s boit son café ",pname);
ProxDetector(30.0,playerid,string,jaune,jaune,jaune,jaune,jaune);
}
}
if(listitem==4)
{
new Float:phealth;
if(GetPlayerMoney(playerid)<=25) return SendClientMessage(playerid,rouge,"Vous n'avez pas assez d'argent pour vous payer ce thé (25$)");
{
GetPlayerHealth(playerid,phealth);
SetPlayerHealth(playerid,phealth+15);
GivePlayerMoney(playerid,-25);
SendClientMessage(playerid,gris,"**Ce thé me réchauffe**");
GetPlayerName(playerid,pname,sizeof(pname));
format(string,sizeof(string),"%s boit son thé ",pname);
ProxDetector(30.0,playerid,string,jaune,jaune,jaune,jaune,jaune);
SetPlayerHealth(playerid,phealth+15);
}
}
if(listitem==5)
{
if(GetPlayerMoney(playerid)<=20) return SendClientMessage(playerid,rouge,"Vous n'avez pas assez d'argent pour vous payer cette tisane (20$)");
{
new Float:phealth;
GetPlayerHealth(playerid,phealth);
GivePlayerMoney(playerid,-20);
SetPlayerHealth(playerid,phealth+15);
SendClientMessage(playerid,gris,"**Cette tisane est très réconfortante**");
GetPlayerName(playerid,pname,sizeof(pname));
format(string,sizeof(string),"%s boit sa tisane ",pname);
ProxDetector(30.0,playerid,string,jaune,jaune,jaune,jaune,jaune);
}
}
}
}
if(dialogid==898)
{
new Float:phealth;
new pname[256];
GetPlayerHealth(playerid,phealth);
if(response)
{
if(listitem==0)
{
if(GetPlayerMoney(playerid)<=20) return SendClientMessage(playerid,rouge,"Vous n'avez pas assez d'argent pour vous payer ce Coca (20$) ");
{
GivePlayerMoney(playerid,-20);
SetPlayerHealth(playerid,phealth+10);
SendClientMessage(playerid,gris,"**Aie ma langue ! ça pique**");
GetPlayerName(playerid,pname,sizeof(pname));
format(string,sizeof(string),"%s boit son Coca ",pname);
ProxDetector(30.0,playerid,string,jaune,jaune,jaune,jaune,jaune);
}
}
if(listitem==1)
{
if(GetPlayerMoney(playerid)<=20) return SendClientMessage(playerid,rouge,"Vous n'avez pas assez d'argent pour vous payer cet Orangina (20$) ");
{
GivePlayerMoney(playerid,-20);
SetPlayerHealth(playerid,phealth+10);
SendClientMessage(playerid,gris,"**Ouille ma langue ! ça pique**");
GetPlayerName(playerid,pname,sizeof(pname));
format(string,sizeof(string),"%s boit son Orangina ",pname);
ProxDetector(30.0,playerid,string,jaune,jaune,jaune,jaune,jaune);
}
}
if(listitem==2)
{
if(GetPlayerMoney(playerid)<=15) return SendClientMessage(playerid,rouge,"Vous n'avez pas assez d'argent pour vous payer ce Fanta (15$) ");
{
GivePlayerMoney(playerid,-15);
SetPlayerHealth(playerid,phealth+5);
SendClientMessage(playerid,gris,"**Mmmm un bon fanta bien frais**");
GetPlayerName(playerid,pname,sizeof(pname));
format(string,sizeof(string),"%s boit son Fanta ",pname);
ProxDetector(30.0,playerid,string,jaune,jaune,jaune,jaune,jaune);
}
}
if(listitem==3)
{
if(GetPlayerMoney(playerid)<=15) return SendClientMessage(playerid,rouge,"Vous n'avez pas assez d'argent pour vous payer ce Pepsi (15$) ");
{
GivePlayerMoney(playerid,-15);
SetPlayerHealth(playerid,phealth+5);
SendClientMessage(playerid,gris,"**Oh c'est trop bon :)**");
GetPlayerName(playerid,pname,sizeof(pname));
format(string,sizeof(string),"%s boit son Pepsi ",pname);
ProxDetector(30.0,playerid,string,jaune,jaune,jaune,jaune,jaune);
}
}
if(listitem==4)
{
if(GetPlayerMoney(playerid)<=15) return SendClientMessage(playerid,rouge,"Vous n'avez pas assez d'argent pour vous payer ce Champomy (15$) ");
{
GivePlayerMoney(playerid,-15);
SetPlayerHealth(playerid,phealth+8);
SendClientMessage(playerid,gris,"**Rien de tel qu'un bon champomy pour les grands évènements!**");
GetPlayerName(playerid,pname,sizeof(pname));
format(string,sizeof(string),"%s boit son Champomy ",pname);
ProxDetector(30.0,playerid,string,jaune,jaune,jaune,jaune,jaune);
}
}
if(listitem==5)
{
if(GetPlayerMoney(playerid)<=10) return SendClientMessage(playerid,rouge,"Vous n'avez pas assez d'argent pour vous payer ce Sprite (10$) ");
{
GivePlayerMoney(playerid,-10);
SetPlayerHealth(playerid,phealth+2);
SendClientMessage(playerid,gris,"**J'aime bien ce sprite**");
GetPlayerName(playerid,pname,sizeof(pname));
format(string,sizeof(string),"%s boit son Sprite ",pname);
ProxDetector(30.0,playerid,string,jaune,jaune,jaune,jaune,jaune);
}
}
}
}
if(dialogid==897)
{
new Float:phealth;
new pname[256];
GetPlayerHealth(playerid,phealth);
if(response)
{
if(listitem==0)
{
if(GetPlayerMoney(playerid)<=35) return SendClientMessage(playerid,rouge,"Vous n'avez pas assez d'argent pour vous payer ce Cocktail Alcoolisé (35$) ");
{
GivePlayerMoney(playerid,-35);
SetPlayerHealth(playerid,phealth-2);
SendClientMessage(playerid,gris,"**Mmmm on sent bien l'arôme**");
GetPlayerName(playerid,pname,sizeof(pname));
format(string,sizeof(string),"%s boit un Cocktail Alcoolisé ",pname);
ProxDetector(30.0,playerid,string,jaune,jaune,jaune,jaune,jaune);
SetPlayerDrunkLevel(playerid,5000);
}
}
if(listitem==1)
{
if(GetPlayerMoney(playerid)<=45) return SendClientMessage(playerid,rouge,"Vous n'avez pas assez d'argent pour vous payer ce Champagne (45$) ");
{
GivePlayerMoney(playerid,-45);
SetPlayerHealth(playerid,phealth-2);
SendClientMessage(playerid,gris,"**On va être bourré che choir**");
GetPlayerName(playerid,pname,sizeof(pname));
format(string,sizeof(string),"%s boit un Champagne",pname);
ProxDetector(30.0,playerid,string,jaune,jaune,jaune,jaune,jaune);
SetPlayerDrunkLevel(playerid,25000);
}
}
if(listitem==2)
{
if(GetPlayerMoney(playerid)<=75) return SendClientMessage(playerid,rouge,"Vous n'avez pas assez d'argent pour vous payer ce Porto (75$) ");
{
GivePlayerMoney(playerid,-75);
SetPlayerHealth(playerid,phealth-2);
SendClientMessage(playerid,gris,"**Ouah! Ca vient tout droit d'Espagne**");
GetPlayerName(playerid,pname,sizeof(pname));
format(string,sizeof(string),"%s boit un Porto",pname);
ProxDetector(30.0,playerid,string,jaune,jaune,jaune,jaune,jaune);
SetPlayerDrunkLevel(playerid,40000);
}
}
if(listitem==3)
{
if(GetPlayerMoney(playerid)<=40) return SendClientMessage(playerid,rouge,"Vous n'avez pas assez d'argent pour vous payer ce Rhum (40$) ");
{
GivePlayerMoney(playerid,-40);
SetPlayerHealth(playerid,phealth-2);
SendClientMessage(playerid,gris,"**Ce rhum est explosif!**");
GetPlayerName(playerid,pname,sizeof(pname));
format(string,sizeof(string),"%s boit un Rhum",pname);
ProxDetector(30.0,playerid,string,jaune,jaune,jaune,jaune,jaune);
SetPlayerDrunkLevel(playerid,30000);
}
}
if(listitem==4)
{
if(GetPlayerMoney(playerid)<=65) return SendClientMessage(playerid,rouge,"Vous n'avez pas assez d'argent pour vous payer cette Tequila (65$) ");
{
GivePlayerMoney(playerid,-65);
SetPlayerHealth(playerid,phealth-2);
SendClientMessage(playerid,gris,"**Aaaa ça rafraichit**");
GetPlayerName(playerid,pname,sizeof(pname));
format(string,sizeof(string),"%s boit une Tequila",pname);
ProxDetector(30.0,playerid,string,jaune,jaune,jaune,jaune,jaune);
SetPlayerDrunkLevel(playerid,35000);
}
}
if(listitem==5)
{
if(GetPlayerMoney(playerid)<=50) return SendClientMessage(playerid,rouge,"Vous n'avez pas assez d'argent pour vous payer ce Vin (50$) ");
{
GivePlayerMoney(playerid,-50);
SetPlayerHealth(playerid,phealth-2);
SendClientMessage(playerid,gris,"**Mmm j'aime mais c'est pas assez puissant!**");
GetPlayerName(playerid,pname,sizeof(pname));
format(string,sizeof(string),"%s boit un Vin",pname);
ProxDetector(30.0,playerid,string,jaune,jaune,jaune,jaune,jaune);
SetPlayerDrunkLevel(playerid,10000);
}
}
if(listitem==6)
{
if(GetPlayerMoney(playerid)<=70) return SendClientMessage(playerid,rouge,"Vous n'avez pas assez d'argent pour vous payer ce Vodka (70$) ");
{
GivePlayerMoney(playerid,-70);
SetPlayerHealth(playerid,phealth-2);
SendClientMessage(playerid,gris,"**Mmm avec de la menthe ce serait meilleur**");
GetPlayerName(playerid,pname,sizeof(pname));
format(string,sizeof(string),"%s boit un Vodka",pname);
ProxDetector(30.0,playerid,string,jaune,jaune,jaune,jaune,jaune);
SetPlayerDrunkLevel(playerid,40000);
}
}
if(listitem==7)
{
if(GetPlayerMoney(playerid)<=80) return SendClientMessage(playerid,rouge,"Vous n'avez pas assez d'argent pour vous payer ce Whisky (80$) ");
{
GivePlayerMoney(playerid,-80);
SetPlayerHealth(playerid,phealth-2);
SendClientMessage(playerid,gris,"**Aaaa ça arrache la langue**");
GetPlayerName(playerid,pname,sizeof(pname));
format(string,sizeof(string),"%s boit un Whisky",pname);
ProxDetector(30.0,playerid,string,jaune,jaune,jaune,jaune,jaune);
SetPlayerDrunkLevel(playerid,50000);
}
}
}
}
if(dialogid==896)
{
new Float:phealth;
new pname[256];
GetPlayerHealth(playerid,phealth);
if(response)
{
if(listitem==0)
{
if(GetPlayerMoney(playerid)<=5) return SendClientMessage(playerid,rouge,"Vous n'avez pas assez d'argent pour vous payer ce Jus de Pomme (5$) ");
{
GivePlayerMoney(playerid,-5);
SetPlayerHealth(playerid,phealth+17);
SendClientMessage(playerid,gris,"**Mmm on sent bien le goût de la pomme**");
GetPlayerName(playerid,pname,sizeof(pname));
format(string,sizeof(string),"%s boit son Jus de Pomme en brique",pname);
ProxDetector(30.0,playerid,string,jaune,jaune,jaune,jaune,jaune);
}
}
if(listitem==1)
{
if(GetPlayerMoney(playerid)<=5) return SendClientMessage(playerid,rouge,"Vous n'avez pas assez d'argent pour vous payer ce Jus d'Ananas (5$) ");
{
GivePlayerMoney(playerid,-5);
SetPlayerHealth(playerid,phealth+17);
SendClientMessage(playerid,gris,"**Mmm on sent bien le goût de l'Ananas**");
GetPlayerName(playerid,pname,sizeof(pname));
format(string,sizeof(string),"%s boit son Jus d'Ananas en brique",pname);
ProxDetector(30.0,playerid,string,jaune,jaune,jaune,jaune,jaune);
}
}
if(listitem==2)
{
if(GetPlayerMoney(playerid)<=5) return SendClientMessage(playerid,rouge,"Vous n'avez pas assez d'argent pour vous payer ce Jus d'Orange (5$) ");
{
GivePlayerMoney(playerid,-5);
SetPlayerHealth(playerid,phealth+17);
SendClientMessage(playerid,gris,"**Mmm on sent bien le goût de l'Orange**");
GetPlayerName(playerid,pname,sizeof(pname));
format(string,sizeof(string),"%s boit son Jus d'Orange en brique",pname);
ProxDetector(30.0,playerid,string,jaune,jaune,jaune,jaune,jaune);
}
}
if(listitem==3)
{
if(GetPlayerMoney(playerid)<=5) return SendClientMessage(playerid,rouge,"Vous n'avez pas assez d'argent pour vous payer ce Jus de Clémentine (5$) ");
{
GivePlayerMoney(playerid,-5);
SetPlayerHealth(playerid,phealth+17);
SendClientMessage(playerid,gris,"**Mmm on sent bien le goût de la Clémentine**");
GetPlayerName(playerid,pname,sizeof(pname));
format(string,sizeof(string),"%s boit son Jus de Clémentine en brique",pname);
ProxDetector(30.0,playerid,string,jaune,jaune,jaune,jaune,jaune);
}
}
if(listitem==4)
{
if(GetPlayerMoney(playerid)<=5) return SendClientMessage(playerid,rouge,"Vous n'avez pas assez d'argent pour vous payer ce Jus d'Abricot (5$) ");
{
GivePlayerMoney(playerid,-5);
SetPlayerHealth(playerid,phealth+17);
SendClientMessage(playerid,gris,"**Mmm on sent bien le goût de l'Abricot**");
GetPlayerName(playerid,pname,sizeof(pname));
format(string,sizeof(string),"%s boit son Jus d'Abricot en brique",pname);
ProxDetector(30.0,playerid,string,jaune,jaune,jaune,jaune,jaune);
}
}
if(listitem==5)
{
if(GetPlayerMoney(playerid)<=5) return SendClientMessage(playerid,rouge,"Vous n'avez pas assez d'argent pour vous payer ce Jus de Fraise (5$) ");
{
GivePlayerMoney(playerid,-5);
SetPlayerHealth(playerid,phealth+17);
SendClientMessage(playerid,gris,"**Mmm on sent bien le goût de la fraise**");
GetPlayerName(playerid,pname,sizeof(pname));
format(string,sizeof(string),"%s boit son Jus de Fraise en brique",pname);
ProxDetector(30.0,playerid,string,jaune,jaune,jaune,jaune,jaune);
}
}
if(listitem==6)
{
if(GetPlayerMoney(playerid)<=5) return SendClientMessage(playerid,rouge,"Vous n'avez pas assez d'argent pour vous payer ce Jus de Framboise (5$) ");
{
GivePlayerMoney(playerid,-5);
SetPlayerHealth(playerid,phealth+17);
SendClientMessage(playerid,gris,"**Mmm on sent bien le goût de la Framboise**");
GetPlayerName(playerid,pname,sizeof(pname));
format(string,sizeof(string),"%s boit son Jus de Framboise en brique",pname);
ProxDetector(30.0,playerid,string,jaune,jaune,jaune,jaune,jaune);
}
}
if(listitem==7)
{
if(GetPlayerMoney(playerid)<=10) return SendClientMessage(playerid,rouge,"Vous n'avez pas assez d'argent pour vous payer ce Jus de Multifruits (10$) ");
{
GivePlayerMoney(playerid,-10);
SetPlayerHealth(playerid,phealth+20);
SendClientMessage(playerid,gris,"**Mmm on sent bien le goût des fruits**");
GetPlayerName(playerid,pname,sizeof(pname));
format(string,sizeof(string),"%s boit son Jus de Multifruits en brique",pname);
ProxDetector(30.0,playerid,string,jaune,jaune,jaune,jaune,jaune);
}
}
}
}
if(dialogid==755)
{
if(response)
{
new pname[256];
SendClientMessage(playerid,vert,"Annonce envoyée avec succès");
GetPlayerName(playerid,pname,sizeof(pname));
format(string,sizeof(string),"[ANNONCE]%s ,pour plus d'informations contactez %s",inputtext,pname);
SendClientMessageToAll(cyan,string);
GivePlayerMoney(playerid,-100);
}
}
         return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
ShowPlayerDialog(playerid,39,DIALOG_STYLE_LIST,"OPTIONS","{0000ff}Envoyer un SMS\n{0000ff}Envoyer un Appel\n{0000ff}Faire un virement\n{0000ff}Demander Rendez-vous (/rdvrules)","CHOISIR","FERMER");
clickedplayerid=clickedplayer;
return 1;
}
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
new string[256];
new sendername[256];
    if(newkeys == KEY_JUMP)
    {
        if(IsPlayerInAnyVehicle(playerid))
        {
			if(IsPlayerConnected(playerid))
			{
				if(vehallume[GetPlayerVehicleID(playerid)]==1) return SendClientMessage(playerid,rouge,"Moteur déjà allumé!");
				{
					if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER)
					{
					SendClientMessage(playerid,rouge,"Vous n'êtes pas conducteur pour démarrer le véhicule");
						return 1;
					}
					if(vehsabot[GetPlayerVehicleID(playerid)] == 1)
					{
					SendClientMessage(playerid,rouge,"Votre voiture a un sabot!");
						return 1;
					}
					PutPlayerInVehicle(playerid, GetPlayerVehicleID(playerid), 0);
					GetPlayerName(playerid, sendername, sizeof(sendername));
     format(string, sizeof(string), "%s essaye de démarrer son véhicule", sendername);
					ProxDetector(30.0, playerid, string,jaune,jaune,jaune,jaune,jaune);
					SetTimerEx("StartingTheVehicle",2500,0,"i",playerid);
					GameTextForPlayer(playerid, "~w~Moteur en cours de demarrage",2500,3);
					return 1;
				}
			}
		}
    }
return 1;
}
stock UserPath(playerid)
{
    new string[128],playername[MAX_PLAYER_NAME];
    GetPlayerName(playerid,playername,sizeof(playername));
    format(string,sizeof(string),PATH,playername);
    return string;
}
stock udb_hash(buf[]) {
    new length=strlen(buf);
    new s1 = 1;
    new s2 = 0;
    new n;
    for (n=0; n<length; n++)
    {
       s1 = (s1 + buf[n]) % 65521;
       s2 = (s2 + s1)     % 65521;
    }
    return (s2 << 16) + s1;
}

strtok(const string[], &index)
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
Rapport(string[])
{
	new tmp[256];
	format(tmp, sizeof(tmp), "%s \r\n",string);
	new File:hFile;
	hFile = fopen("rapport.txt", io_append);
	fwrite(hFile, tmp);
	fclose(hFile);
}
public SendRadioPolice(playerid, const str[], define)
{
for(new i = 0; i < MAX_PLAYERS; i++)
    {
if(metier[i]==5)
{
	new tmpbuf[256];
	format(tmpbuf, sizeof(tmpbuf), str, define);
	SendClientMessage(i, bleu, tmpbuf);
}
}
}
public SendAdminMessage(playerid, const str[], define)
{
for(new i = 0; i < MAX_PLAYERS; i++)
    {
if(IsPlayerAdmin(i))
{
	new tmpbuf[256];
	format(tmpbuf, sizeof(tmpbuf), str, define);
	SendClientMessage(i, jaune, tmpbuf);
}
}
}
public GiveCInfos(playerid)
{
new rando1 = random(sizeof(CSkinAlea));
SetSpawnInfo(playerid,0,CSkinAlea[rando1][0],246.2563,1410.5654,23.3703,286.1922,5,0,0,0,0,0);
metier[playerid]=1;
}
public GiveSInfos(playerid)
{
new rando1 = random(sizeof(SSkinAlea));
SetPlayerPos(playerid,-319.6008,1048.2404,20.3403);
SetPlayerSkin(playerid,SSkinAlea[rando1][0]);
metier[playerid]=2;
}
public GiveDInfos(playerid)
{
new rando1 = random(sizeof(DSkinAlea));
SetPlayerSkin(playerid,DSkinAlea[rando1][0]);
metier[playerid]=3;
GivePlayerWeapon(playerid,29,100);
GivePlayerWeapon(playerid,30,100);
GivePlayerWeapon(playerid,4,0);
}
public GivePInfos(playerid)
{
SetSpawnInfo(playerid,0,61,pilot,0,4,0,42,900,0,0);
metier[playerid]=4;
}
public GivePoInfos(playerid)
{
SetPlayerInterior(playerid,5);
SetPlayerPos(playerid,326.7917,304.4862,999.1484);
new rando1 = random(sizeof(PoSkinAlea));
SetPlayerSkin(playerid,PoSkinAlea[rando1][0]);
metier[playerid]=5;
GivePlayerWeapon(playerid,3,0);
SendClientMessage(playerid,jaune,"Pour avoir le reste de vos armes: allez au commissariat et prenez les armes dans les vestiaires");
}
public GiveChInfos(playerid)
{
SetSpawnInfo(playerid,0,255,-206.7114,1212.1204,19.8906,272.4016,0,0,0,0,0,0);
SetPlayerSkin(playerid,255);
metier[playerid]=6;
}
public GiveMInfos(playerid)
{
new rando1 = random(sizeof(MSkinAlea));
SetSpawnInfo(playerid,0,MSkinAlea[rando1][0],217.8039,1822.6954,6.4141,272.0115,16,2,23,200,27,200);
metier[playerid]=7;
GivePlayerWeapon(playerid,29,200);
GivePlayerWeapon(playerid,31,200);
GivePlayerWeapon(playerid,34,50);
}
public GivePeInfos(playerid)
{
new rando1 = random(sizeof(PeSkinAlea));
SetSpawnInfo(playerid,0,PeSkinAlea[rando1][0],-2715.4150,-2234.7825,5.1172,0,0,0,0,0,0,0);
metier[playerid]=8;
SendClientMessage(playerid,jaune,"Si vous n'avez déjà pas de canne à pêche allez en chercher-une au 24/7");
}
GiveIInfos(playerid)
{
SetPlayerSkin(playerid,171);
SetPlayerInterior(playerid,3);
SetPlayerPos(playerid,1489.0314,1305.7617,1093.2964);
metier[playerid]=9;

}
GiveInfosDef(playerid)
{
SetPlayerHealth(playerid,100);
SetPlayerArmour(playerid,100);
GivePlayerWeapon(playerid,31,500);
GivePlayerWeapon(playerid,34,500);
GivePlayerWeapon(playerid,24,500);
SetPlayerColor(playerid,ColorDef);
SetPlayerPos(playerid,PosDef);
SetPlayerInterior(playerid,2);
def[playerid]=1;
}
GiveInfosAttaq(playerid)
{
SetPlayerHealth(playerid,100);
SetPlayerArmour(playerid,100);
GivePlayerWeapon(playerid,33,500);
GivePlayerWeapon(playerid,30,500);
GivePlayerWeapon(playerid,25,500);
SetPlayerColor(playerid,ColorAttaq);
SetPlayerPos(playerid,PosAttaq);
SetPlayerInterior(playerid,2);
attaq[playerid]=1;
}
GiveTextDraw()
{
for(new i = 0; i < MAX_PLAYERS; i++)
{
if(mjoin[i]==1)
{
new string[256];
format(string,sizeof(string),"Attaquants: %d",attaquants);
Mjscore = TextDrawCreate(48, 287,string);
TextDrawFont(Mjscore , 3);
TextDrawLetterSize(Mjscore , 0.7, 4.0);
TextDrawColor(Mjscore , 0xFF0000FF);
TextDrawSetOutline(Mjscore , 1);
TextDrawSetProportional(Mjscore , 1);
TextDrawShowForPlayer(i,Mjscore);
TextDrawUseBox(Mjscore,1);
TextDrawBoxColor(Mjscore, 0xFF8000FF);
TextDrawTextSize(Mjscore, 0, 0);
format(string,sizeof(string),"Defenseurs: %d",defenseurs);
Mjdef = TextDrawCreate(439, 296,string);
TextDrawFont(Mjdef , 3);
TextDrawLetterSize(Mjdef , 0.7, 4.0);
TextDrawColor(Mjdef , 0x0000FFFF);
TextDrawSetOutline(Mjdef , 1);
TextDrawSetProportional(Mjdef , 1);
TextDrawShowForPlayer(i,Mjdef);
TextDrawUseBox(Mjdef,1);
TextDrawBoxColor(Mjdef, 0x000000FF);
}
}
return 1;
}
AddPointAttaq()
{
new string[256];
attaquants++;
format(string,sizeof(string),"Attaquants: %d",attaquants);
TextDrawSetString(Mjscore,string);
}
RemovePointAttaq()
{
new string[256];
attaquants--;
format(string,sizeof(string),"Attaquants: %d",attaquants);
TextDrawSetString(Mjscore,string);
}
AddPointDef()
{
new string[256];
defenseurs++;
format(string,sizeof(string),"Defenseurs: %d",defenseurs);
TextDrawSetString(Mjdef,string);
}
RemovePointDef()
{
new string[256];
defenseurs--;
format(string,sizeof(string),"Defenseurs: %d",defenseurs);
TextDrawSetString(Mjdef,string);
}
stock CheckPlayerDistanceToVehicle(Float:radi, playerid, vehicleid)
{
	if(IsPlayerConnected(playerid))
	{
	    new Float:PX,Float:PY,Float:PZ,Float:X,Float:Y,Float:Z;
	    GetPlayerPos(playerid,PX,PY,PZ);
	    GetVehiclePos(vehicleid, X,Y,Z);
	    new Float:DistanceS = (X-PX)*(X-PX)+(Y-PY)*(Y-PY)+(Z-PZ)*(Z-PZ);
	    if(DistanceS <= radi*radi)
	    {
	        return 1;
	    }
	}
	return 0;
}
EchouedPermis(playerid)
{
DisablePlayerCheckpoint(playerid);
DestroyVehicle(vspawn[playerid]);
KillTimer(timerlol);
SetPlayerPos(playerid,-143.6687,1088.1812,19.7422);
SendClientMessage(playerid,rouge,"Permis échoué");
SendClientMessage(playerid,jaune,"Vous avez échoué votre permis en abimant le véhicule. Vous êtes directement redirigé devant l'auto-école");
permiscours[playerid]=0;
checkcp[playerid]=0;
}

PermisVoiture(playerid)
{
if(GetPlayerMoney(playerid)<5000) return SendClientMessage(playerid,rouge,"Vous n'avez pas assez d'argent pour vous payer ce permis!");
{
GivePlayerMoney(playerid,-5000);
timerlol=SetTimerEx("TimerPermis",1000,true,"i",playerid);
new rand1=random(sizeof(CpAleaPermis));
SetPlayerCheckpoint(playerid,CpAleaPermis[rand1][0],CpAleaPermis[rand1][1],CpAleaPermis[rand1][2],5.0);
permiscours[playerid]=1;
vspawn[playerid]=CreateVehicle(405,-148.6971,1100.6835,19.4679,88.8702,0,0,0);
PutPlayerInVehicle(playerid,vspawn[playerid],0);
SetPlayerInterior(playerid,0);
SetVehicleHealth(vspawn[playerid],1020);
ShowPlayerDialog(playerid,963,DIALOG_STYLE_MSGBOX,"PERMIS","Bienvenu dans l'interface Permis\nVous allez commencer le permis à bord de votre véhicule respectif à votre permis sélectionné\nVous devrez passer dans 5 CheckPoints placés aléatoirement dans les environs de Fort-Carson\nVous devrez passer ces CheckPoints sans abimer votre véhicule\nSi vous abimer votre véhicule votre permis sera échoué","OK","FERMER");
}
return 1;
}
PermisMoto(playerid)
{
if(GetPlayerMoney(playerid)<5000) return SendClientMessage(playerid,rouge,"Vous n'avez pas assez d'argent pour vous payer ce permis!");
{
GivePlayerMoney(playerid,-5000);
timerlol=SetTimerEx("TimerPermis",1000,true,"i",playerid);
new rand1=random(sizeof(CpAleaPermis));
SetPlayerCheckpoint(playerid,CpAleaPermis[rand1][0],CpAleaPermis[rand1][1],CpAleaPermis[rand1][2],5.0);
permiscours[playerid]=1;
vspawn[playerid]=CreateVehicle(521,-148.6971,1100.6835,19.4679,88.8702,0,0,0);
PutPlayerInVehicle(playerid,vspawn[playerid],0);
SetPlayerInterior(playerid,0);
SetVehicleHealth(vspawn[playerid],1020);
ShowPlayerDialog(playerid,963,DIALOG_STYLE_MSGBOX,"PERMIS","Bienvenu dans l'interface Permis\nVous allez commencer le permis à bord de votre véhicule respectif à votre permis sélectionné\nVous devrez passer dans 5 CheckPoints placés aléatoirement dans les environs de Fort-Carson\nVous devrez passer ces CheckPoints sans abimer votre véhicule\nSi vous abimer votre véhicule votre permis sera échoué","OK","FERMER");
}
return 1;
}
PermisPoidsLourd(playerid)
{
if(GetPlayerMoney(playerid)<5000) return SendClientMessage(playerid,rouge,"Vous n'avez pas assez d'argent pour vous payer ce permis!");
{
GivePlayerMoney(playerid,-5000);
timerlol=SetTimerEx("TimerPermis",1000,true,"i",playerid);
new rand1=random(sizeof(CpAleaPermis));
SetPlayerCheckpoint(playerid,CpAleaPermis[rand1][0],CpAleaPermis[rand1][1],CpAleaPermis[rand1][2],5.0);
permiscours[playerid]=3;
vspawn[playerid]=CreateVehicle(403,-148.6971,1100.6835,19.4679,88.8702,0,0,0);
PutPlayerInVehicle(playerid,vspawn[playerid],0);
SetPlayerInterior(playerid,0);
SetVehicleHealth(vspawn[playerid],1020);
ShowPlayerDialog(playerid,963,DIALOG_STYLE_MSGBOX,"PERMIS","Bienvenu dans l'interface Permis\nVous allez commencer le permis à bord de votre véhicule respectif à votre permis sélectionné\nVous devrez passer dans 5 CheckPoints placés aléatoirement dans les environs de Fort-Carson\nVous devrez passer ces CheckPoints sans abimer votre véhicule\nSi vous abimer votre véhicule votre permis sera échoué","OK","FERMER");
}
return 1;
}
AchievedPermis(playerid)
{
new string[256];
if(permiscours[playerid]==1)
{
new text[256];
text="Voiture";
format(string,sizeof(string),"Félicitation! Vous avez achevé votre permis %s",text);
SendClientMessage(playerid,jaune,string);
permis[playerid][pVoiture]=1;
checkcp[playerid]=0;
SetPlayerPos(playerid,-149.8545,1079.5879,19.7422);
DestroyVehicle(vspawn[playerid]);
checkcp[playerid]=0;
}
if(permiscours[playerid]==2)
{
new text[256];
text="Moto";
format(string,sizeof(string),"Félicitation! Vous avez achevé votre permis %s",text);
SendClientMessage(playerid,jaune,string);
permis[playerid][pMoto]=1;
SetPlayerPos(playerid,-149.8545,1079.5879,19.7422);
DestroyVehicle(vspawn[playerid]);
checkcp[playerid]=0;
}
if(permiscours[playerid]==3)
{
new text[256];
text="Poids Lourd";
format(string,sizeof(string),"Félicitation! Vous avez achevé votre permis %s",text);
SendClientMessage(playerid,jaune,string);
permis[playerid][pPoidsLourd]=1;
SetPlayerPos(playerid,-149.8545,1079.5879,19.7422);
DestroyVehicle(vspawn[playerid]);
checkcp[playerid]=0;
}
if(permiscours[playerid]==4)
{
new text[256];
text="Arme";
format(string,sizeof(string),"Félicitation! Vous avez achevé votre permis %s",text);
SendClientMessage(playerid,jaune,string);
permis[playerid][pArme]=1;
SetPlayerPos(playerid,-149.8545,1079.5879,19.7422);
DestroyVehicle(vspawn[playerid]);
checkcp[playerid]=0;
}
if(permiscours[playerid]==5)
{
new text[256];
text="Vol";
format(string,sizeof(string),"Félicitation! Vous avez achevé votre permis %s",text);
SendClientMessage(playerid,jaune,string);
permis[playerid][pVol]=1;
SetPlayerPos(playerid,-149.8545,1079.5879,19.7422);
DestroyVehicle(vspawn[playerid]);
checkcp[playerid]=0;
}
if(permiscours[playerid]==6)
{
new text[256];
text="Bâteau";
format(string,sizeof(string),"Félicitation! Vous avez achevé votre permis %s",text);
SendClientMessage(playerid,jaune,string);
permis[playerid][pBateau]=1;
SetPlayerPos(playerid,-149.8545,1079.5879,19.7422);
DestroyVehicle(vspawn[playerid]);
checkcp[playerid]=0;
}
}
public SendSMS(playerid, const str[])
{
	new tmpbuf[256];
	format(tmpbuf, sizeof(tmpbuf),str);
	SendClientMessage(playerid, jaune, tmpbuf);
}
