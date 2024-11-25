#pragma unused ret_memcpy

#include <a_samp>
#include <dini>
#include <dudb>

#include <core>
#include <float>

#include <streamer>

/*=================================================================================================*/
/*==================================== TDM-FR - Serinity Wars - TDM ===============================*/
//- Scripté par Xolokos (Sanctus, Jeffrey Payne) Geoffrey Migliacci - //

new Text:BIA;

//*============================= CONFIG ==========================================*//

#define WEBSITE "VOTREWEBSITEICI"
#define BIENVENUE "MESSAGE DE BIENVENUE"

//*== COULEUR EQUIPE ==*//
#define POURPRE 0x6A0000AA
#define BLEUE 0x152CC4AA
#define BLANC 0xE1E1E1AA
#define ORANGE 0xF9C000AA
//== COULEUR ADMINISTRATEUR =//
#define ZAZOLIN 0xB000ACFF

/*== LES LOGINS ==*/
#define ENREGISTREMENT "Comptes/%s.ini"// A modifier si vous voulez enregistrez autre par...

#define VERT 0x009D07FF
#define ROUGE 0xD70000FF

//*============================= CONFIG ==========================================*//
//*===============================================================================*//
//*===============================================================================*//
//*===============================================================================*//
//*===============================================================================*//

/*== DEFINES ==*/
#define TEAM_ARMY 0
#define TEAM_RUSSE 1
#define TEAM_MERCENAIRE 2
#define TEAM_JAPON 3

#define NOIR 0x555555AA
#define BLANCHE 0xE1E1E1AA
#define GRIS 0x7D7D7DFF

/*== RANGS DEFINE ==*/
#define CADET  0
#define RECRUE	1
#define CORPORAL 2
#define SERGENT 3
#define SERGENTDEQUARTIER    4
#define CHEFSERGENT  5
#define SERGENTENCHEF  6
#define SOUSMAJOR 7
#define MAJOR   8
#define LIEUTENANTC 9
#define COLONEL 10
#define BRIGADIERG 11
#define GENERAL 12
#define MAJORG  13
#define GENERALAR   14
#define MARECHAL 15
#define PRESTIGEI  16
#define PRESTIGEII 17
#define PRESTIGEIII   18

/*== 3D TEXT==*/
new Text3D:Admins[MAX_PLAYERS];

new Text3D:Information[MAX_PLAYERS];

//*== JAIL ==*//
new Float:Jail[MAX_PLAYERS][3];
new Jailled[MAX_PLAYERS];

//*== ENUM ==*/
enum Info
{
	Argent,
	Score,
	Level,
    KillDeath,
    NMorts,
    NTues,
    JVIP,
    Bannis,
    MULTIKILL,
    ULTRAKILL,
    FANTASTIQUE,
    ARMAGEDDON,
    INCROYABLE,
    BIGBANG,
    IMPOSSIBLE,
    IIMPOSSIBLE,
    IIIMPOSSIBLE,
    INDESTRUCTIBLE,
    WPoint,
    Brouilleur,
	Vie,
	Banques,
	PSkin,
//________________//
	SLOTSI,
	SLOTSII,
	SLOTSIII,
	SLOTSIIII,
	SLOTSIIIII,
	SLOTSIIIIII
//________________//
}

new InfoJoueur[MAX_PLAYERS][Info];
new JoueurLogguer[MAX_PLAYERS];


//*== SLOT DES ARMES PRESTIGES ==*//
new SlotI[MAX_PLAYERS];
new SlotII[MAX_PLAYERS];
new SlotIII[MAX_PLAYERS];
new SlotIIII[MAX_PLAYERS];
new SlotIIIII[MAX_PLAYERS];
new SlotIIIIII[MAX_PLAYERS];

/*== ZONE NON CAPRURABLE ==*/
new ZArmy;
new ZMercenaire;
new ZRusse;
new ZJapon;

/*== RESPAWN SPAWNED CAR ==*/
new SpawnCar[MAX_VEHICLES] = 0;

/*== NEW FERME VOITURE ==*/
new Ferme[MAX_VEHICLES] = 0;

/*== DEVOIR ==*/
new Devoir[MAX_PLAYERS] = 0;
new Skin[MAX_PLAYERS];
new Couleur[MAX_PLAYERS];

/*==PERSOSKIN==*/
new Skins[MAX_PLAYERS];
new PSK[MAX_PLAYERS]=0;

/*== STATICS TEAM ==*/
static Team[MAX_PLAYERS];

/*== NEWS LIERS AUX CLASSES ==*/
new Rang[MAX_PLAYERS];
new Text:Boxrang;

new Rep[MAX_PLAYERS] = 0;
new Soin[MAX_PLAYERS] = 0;

new Classe[MAX_PLAYERS] = 0;

/*==LES WARS POINTS==*/
new Brouilleurs[MAX_PLAYERS] = 0;
new BCharges[MAX_PLAYERS] = 0;
new SVie[MAX_PLAYERS] = 0;

/*== FLOAT ==*/
new Float:Positions[MAX_PLAYERS][3];

/*== NEWS ==*/
new Levels[MAX_PLAYERS] = 0;

new Kill[MAX_PLAYERS] = 0;
new Death[MAX_PLAYERS] = 0;
new KD[MAX_PLAYERS] = 0;

new VIP[MAX_PLAYERS] = 0;

new Bans[MAX_PLAYERS] = 0;

new WarsPoints[MAX_PLAYERS] = 0;

new Banque[MAX_PLAYERS] = 0;

/*==NOMBRE DE JOUEUR==*/
new Connecter;

/*== MUTE ==*/
new Mute[MAX_PLAYERS];

/*== NEWS POUR LES COMBOS ==*/
new Combos[MAX_PLAYERS] = 0;

new COMULTIKILL[MAX_PLAYERS];
new COULTRAKILL[MAX_PLAYERS];
new COFANTASTIQUE[MAX_PLAYERS];
new COARMAGEDDON[MAX_PLAYERS];
new COINCROYABLE[MAX_PLAYERS];
new COBIGBANG[MAX_PLAYERS];
new COIMPOSSIBLE[MAX_PLAYERS];
new COIIMPOSSIBLE[MAX_PLAYERS];
new COIIIMPOSSIBLE[MAX_PLAYERS];
new COINDESTRUCTIBLE[MAX_PLAYERS];


/*== FORWARD COMBOS ==*/
forward Combinaison(playerid);
forward SCombos(playerid);

/*== NEWS TEXT ==*/
new Text:Noir;

new Text:Connection;
new Text:Titre;
new Text:Regles;

new Text:RANG[MAX_PLAYERS];

/*== FORWARDS ==*/
forward Rangs(playerid);

forward Classiation(playerid);
forward Spawn(playerid);

forward Stop(playerid);

forward Message();
forward Message0(); // A définir ligne 287.

forward SpawnVie(playerid);

forward CBan(playerid);

forward ClearC(playerid);

forward Gazeuze(playerid);
forward Nucleaire(playerid);

forward Toucher(playerid);
new Envoyeur;
//________________________

/*== FORWARD LIER AU CLASSES ==*/

forward Reparation(playerid);
forward Soigne(playerid);

forward BStop(playerid);
forward BCharge(playerid);
new BCouleur[MAX_PLAYERS];

/*==VOITURE==*/

new Menu:Vehicules;

/*==GANG ZONE==*/

new TerritoireHotel;
new TerritoireFuel;
new TerritoirePark;
new TerritoireEntrepot;
new TerritoireAparte;
new TerritoireMarcher;
new TerritoireGare;
new TerritoireWash;

//*== TIMER ZONE ==*/

new THotel[MAX_PLAYERS];
new TFuel[MAX_PLAYERS];
new TPark[MAX_PLAYERS];
new TEntrepot[MAX_PLAYERS];
new TAparte[MAX_PLAYERS];
new TMarcher[MAX_PLAYERS];
new TGare[MAX_PLAYERS];
new TWash[MAX_PLAYERS];

//_____________________________//
forward CaptureHotel(playerid);
forward CaptureFuel(playerid);
forward CapturePark(playerid);
forward CaptureEntrepot(playerid);
forward CaptureAparte(playerid);
forward CaptureMarcher(playerid);
forward CaptureGare(playerid);
forward CaptureWash(playerid);
//_____________________________//

new TerritoireHotelAppartenance = 50;
new TerritoireFuelAppartenance = 50;
new TerritoireParkAppartenance = 50;
new TerritoireEntrepotAppartenance = 50;
new TerritoireAparteAppartenance = 50;
new TerritoireMarcherAppartenance = 50;
new TerritoireGareAppartenance = 50;
new TerritoireWashAppartenance = 50;

new Captures[MAX_PLAYERS];

/*== ZONE  ==*/

new HotelP;
new FuelP;
new ParkP;
new EntrepotP;
new AparteP;
new MarcherP;
new GareP;
new WashP;

/*== ZONE CLASSE ==*/

forward Territoire(playerid);

/*== BONUS TERRITOIRE ==*/

forward Munitions(playerid);

/*== SPAWN ALEATOIRE ==*/

new Float:Army[8][3] = {
{2778.1670,-2502.6597,13.6521},
{2769.3733,-2425.7537,13.6484},
{2769.1426,-2392.6047,13.6328},
{2724.2888,-2393.5994,13.6328},
{2735.1565,-2414.2153,13.6328},
{2745.6541,-2440.4790,13.6432},
{2775.2896,-2496.6060,13.6655},
{2769.8250,-2483.7642,13.6484}
};

new Float:Russe[5][3] = {
{1811.4297,-1355.7758,15.0850},
{1803.5537,-1343.7361,15.3143},
{1770.4508,-1384.6808,15.7578},
{1779.9824,-1410.8385,15.7648},
{1772.8158,-1427.8972,15.7648}
};

new Float:Mercenaire[3][3] = {
{2711.9685,-1674.1161,9.5452},
{2697.0762,-1689.8308,10.0184},
{2669.1138,-1711.1666,9.3580}
};

new Float:Japon[7][3] = {
{2745.4385,-1185.8705,69.4008},
{2709.2717,-1207.7399,68.6500},
{2745.7454,-1249.4836,59.7188},
{2752.7573,-1308.9104,53.0938},
{2704.1694,-1276.7009,57.8839},
{2749.5178,-1227.1877,63.6406},
{2715.2048,-1165.0812,69.4770}
};


#if defined FILTERSCRIPT

public OnFilterScriptInit()
{
	print("Serinity Wars V3.5.02, Gamemode Initiation terminée.");
	print("Game Mode Chargé.");
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

#else

main()
{
	print("[SERENITY WARS] [WOS[V3.5.02] GAME MODE INITIATION...");
	print("");
	print("[GM LOADED]");
	print("[Geoffrey Migliacci || Sanctus || Xolokos || Jeffrey Payne]");
}

#endif

AntiDeAMX()
{
    new A[][] =
    {
        "Unarmed (Fist)",
        "Brass K"
    };
    #pragma unused A
}

public OnGameModeInit()
{
	SetGameModeText("WOS [V3.5.02]");
	SetMapName("[Los Santos]");

	/*==WEATHER et AUTRES ==*/

	SetNameTagDrawDistance(25.0);
	SetWeather(43);
	DisableInteriorEnterExits();
	ShowNameTags(1);
	LimitPlayerMarkerRadius(850);
	SetWorldTime(13);
	UsePlayerPedAnims();

	SetTimer("Message",900000,false);

	/*== PICKUP et 3DTEXTLABEL==*/
	AddStaticPickup(1318, 1, 2769.8250,-2483.7642,13.6484, 0);
	AddStaticPickup(1318, 1, 1803.5537,-1343.7361,15.3143, 0);
	AddStaticPickup(1318, 1, 2711.9685,-1674.1161,9.5452, 0);
	AddStaticPickup(1318, 1, 2175.2415,-1822.4995,16.1423, 0);
	AddStaticPickup(1318, 1, 2429.7581,-2111.9622,13.5469, 0);
	Create3DTextLabel("[/EQUIPEMENT]",BLANC, 2769.8250,-2483.7642,13.6484,25,0);
    Create3DTextLabel("[/EQUIPEMENT])",BLANC, 1803.5537,-1343.7361,15.3143,25,0);
    Create3DTextLabel("[/EQUIPEMENT]",BLANC, 2711.9685,-1674.1161,9.5452,25,0);
	Create3DTextLabel("[/EQUIPEMENT]",BLANC, 2175.2415,-1822.4995,16.1423,25,0);
    Create3DTextLabel("[/EQUIPEMENT])",BLANC, 2429.7581,-2111.9622,13.5469,25,0);

    AddStaticPickup(1318, 1, 2745.6541,-2440.4790,13.6432, 0);
	AddStaticPickup(1318, 1, 1770.4508,-1384.6808,15.7578, 0);
	AddStaticPickup(1318, 1, 2669.1138,-1711.1666,9.3580, 0);
	AddStaticPickup(1318, 1, 2752.7573,-1308.9104,53.0938, 0);
 	AddStaticPickup(1318, 1, 2142.1882,-1803.1599,16.1475, 0);
	Create3DTextLabel("[/BANQUE]",BLANC, 2745.6541,-2440.4790,13.6432,25,0);
    Create3DTextLabel("[/BANQUE])",BLANC, 1770.4508,-1384.6808,15.7578,25,0);
    Create3DTextLabel("[/BANQUE]",BLANC, 2669.1138,-1711.1666,9.3580,25,0);
    Create3DTextLabel("[/BANQUE]",BLANC, 2752.7573,-1308.9104,53.0938,25,0);

	Create3DTextLabel("[/ENTRER]",BLANC, 2142.1882,-1803.1599,16.1475,50,0);
	Create3DTextLabel("[/SORTIR]",BLANC, 833.29541015625,7.6442446708679,1004.5296630860,50,0);
    Create3DTextLabel("[/ENTRER])",BLANC, -1761.5845,13.5391,345.7529,50,0);
    Create3DTextLabel("[/ENTRER]",BLANC, 2420.6204,-1761.4904,13.5391,50,0);
    Create3DTextLabel("[/SORTIR])",BLANC, 2215.939453125,-1150.6352539063,1027.1468505859,50,0);

    Create3DTextLabel("[/NUKE])",BLANC, 2298.2078,-1917.8633,13.5906,25,0);
    AddStaticPickup(1318, 1, 2298.2078,-1917.8633,13.5906, 0);

    AddStaticPickup(1318, 1, 2171.2310,-1769.2451,18.5466, 0);
	Create3DTextLabel("[/TIRE [Playerid] - 10500 $]",BLANC, 2171.2310,-1769.2451,19,25,0);

	AddStaticPickup(1318, 1, 2126.9934,-2274.6104,20.6719, 0);
 	Create3DTextLabel("[/NUKE])",BLANC, 2133.7466,-2281.3774,20.6719,25,0);
 	
	AddStaticPickup(1318, 1, 2133.7466,-2281.3774,20.6719, 0);
	Create3DTextLabel("[/EQUIPEMENT]",BLANC, 2126.9934,-2274.6104,20.6719,25,0);

	//ARMY
	AddPlayerClass(287,2778.1670,-2502.6597,13.6521,89.0143,0,0,0,0,0,0); //

    //RUSSE
	AddPlayerClass(206,1811.4297,-1355.7758,15.0850,90.0,0,0,0,0,0,0); //

	//MERCENAIRE
	AddPlayerClass(250,3130,-1626.8202,10.8858,267.4567,0,0,0,0,0,0); //

	//JAPON
	AddPlayerClass(122,3130,-1626.8202,10.8858,267.4567,0,0,0,0,0,0); //

	/*== MENU VOITURE==*/
	Vehicules = CreateMenu("Vehicules",1,20,120,150,40);
	SetMenuColumnHeader(Vehicules,0,"Vehicle :");
	AddMenuItem(Vehicules,0,"Turismo");
	AddMenuItem(Vehicules,0,"Infernus");
	AddMenuItem(Vehicules,0,"Buffalo");
	AddMenuItem(Vehicules,0,"Stretch");
	AddMenuItem(Vehicules,0,"Leviathan");
	AddMenuItem(Vehicules,0,"Hunter");
	AddMenuItem(Vehicules,0,"PCJ600");
	AddMenuItem(Vehicules,0,"FreeWay");
	AddMenuItem(Vehicules,0,"Sanchez");
	AddMenuItem(Vehicules,0,"Rustler");
	AddMenuItem(Vehicules,0,"Camper");
	AddMenuItem(Vehicules,0,"Shamal");
	AddMenuItem(Vehicules,0,"NRJ500");

	/*== NEWS TEXT ==*/

	Noir=TextDrawCreate(680.000000,-9.000000, "                                                                                            ");
	TextDrawBackgroundColor(Noir,255);
	TextDrawFont(Noir,1);
	TextDrawLetterSize(Noir,0.500000,1.000000);
	TextDrawColor(Noir,-1);
	TextDrawSetOutline(Noir,0);
	TextDrawSetProportional(Noir,1);
	TextDrawSetShadow(Noir,1);
	TextDrawUseBox(Noir,1);
	TextDrawBoxColor(Noir,0x000000FF);
	TextDrawTextSize(Noir,-11.000000, 230.000000);

	Connection=TextDrawCreate(135, 388, "A rejoind la partie.");
    TextDrawAlignment(Connection, 1);
    TextDrawFont(Connection, 2);
    TextDrawLetterSize(Connection, 0.180, 0.600);
    TextDrawColor(Connection, BLANC);
    TextDrawSetOutline(Connection, 1);
    TextDrawTextSize (Connection,  3.0, 3.0) ;

	/*== TEXTE ==*/

	Titre=TextDrawCreate(25, 350, BIENVENUE);
    TextDrawAlignment(Titre, 1);
    TextDrawFont(Titre, 2);
    TextDrawLetterSize(Titre, 0.400, 1.000);
    TextDrawColor(Titre, BLANC);
    TextDrawSetOutline(Titre, 1);
    TextDrawTextSize (Titre,  3.0, 3.0) ;

    Regles=TextDrawCreate(25, 150, "Respecter les Joueurs Respecter le choix des Administrateur Eviter le Drive By");
    TextDrawAlignment(Regles, 200);
    TextDrawFont(Regles, 2);
    TextDrawLetterSize(Regles, 0.400, 1.000);
    TextDrawColor(Regles, BLANC);
    TextDrawSetOutline(Regles, 1);
    TextDrawTextSize (Regles,  10.0, 10.0) ;

   	BIA=TextDrawCreate(20, 425, WEBSITE);
    TextDrawAlignment(BIA, 200);
    TextDrawFont(BIA, 2);
    TextDrawLetterSize(BIA, 0.300, 0.900);
    TextDrawColor(BIA, BLANC);
    TextDrawSetOutline(BIA, 1);
    TextDrawTextSize (BIA,  10.0, 10.0) ;

    /*== ZONE ==*/

	TerritoireHotel = GangZoneCreate(2135.0232, -1830.4382, 2197.5315, -1754.2130);
    TerritoireFuel = GangZoneCreate(2330.038085, -2197.457519, 2474.038085, -2029.457519);
    TerritoirePark = GangZoneCreate(2086.422119, -1585.907836, 2342.422119, -1361.907836);
    TerritoireEntrepot = GangZoneCreate(2060.754150, -2377.371337, 2316.754150, -2113.371337);
    TerritoireAparte = GangZoneCreate(1919.758789, -1768.443603, 2095.758789, -1592.443603);
    TerritoireMarcher = GangZoneCreate(1927.021240, -2114.393554, 2135.021240, -1946.393432);
    TerritoireGare = GangZoneCreate(1664.946044, -2011.879150, 1856.946044, -1827.879150);
    TerritoireWash = GangZoneCreate(2402.557617, -1567.578857, 2634.557617, -1423.578857);

    /*== NON CAPTURABLE ==*/

	ZArmy = GangZoneCreate(2518.210449, -2574.962890, 2814.210449, -2318.962890);
    ZMercenaire = GangZoneCreate(2621.684570, -1885.480712, 2861.684570, -1661.480712);
    ZRusse = GangZoneCreate(1687.698364, -1480.407958, 1863.698364, -1264.407958);
    ZJapon = GangZoneCreate(2616.767333, -1330.253173, 2872.767333, -1034.253173);

    //*== PICKUP ==*/

    HotelP = CreatePickup(1314 , 2, 2147.4602,-1818.3251,16.1406, -1);
    FuelP = CreatePickup(1314 , 2, 2435.0288,-2124.7832,13.5469, -1);
    EntrepotP = CreatePickup(1314 , 2, 2128.5146,-2263.6455,14.7808, -1);
    ParkP = CreatePickup(1314 , 2, 2171.9695,-1498.7477,23.9748, -1);
    AparteP = CreatePickup(1314 , 2, 2030.7883,-1655.9767,13.5547, -1);
    MarcherP = CreatePickup(1314 , 2, 1994.4258,-2018.2747,13.5469, -1);
    GareP = CreatePickup(1314 , 2, 1763.8785,-1910.4652,13.5694, -1);
    WashP = CreatePickup(1314 , 2, 2511.1475,-1468.4246,24.0220, -1);

	/*==BASE MOH ==*/
	AddStaticVehicle(470,775.40002441,1743.80004883,5.40000010,88.75000000,-1,-1); //Patriot
	AddStaticVehicle(470,773.32647705,1736.67065430,5.40000010,88.74755859,-1,-1); //Patriot
	AddStaticVehicle(470,775.09997559,1729.30004883,5.00000000,88.74755859,-1,-1); //Patriot
	AddStaticVehicle(470,761.09997559,1729.40002441,5.00000000,269.99755859,-1,-1); //Patriot
	AddStaticVehicle(470,760.79998779,1736.30004883,5.00000000,272.99450684,-1,-1); //Patriot
	AddStaticVehicle(470,760.50000000,1743.59997559,5.00000000,272.99377441,-1,-1); //Patriot
	AddStaticVehicle(470,777.62628174,1601.56665039,5.87151670,30.00000000,-1,-1); //Patriot
	AddStaticVehicle(433,759.78961182,1599.63867188,5.83775377,350.00000000,-1,-1); //Barracks
	AddStaticVehicle(433,765.57592773,1599.91186523,5.83775377,9.99694824,-1,-1); //Barracks
	AddStaticVehicle(433,772.10034180,1599.68188477,5.83775377,349.99206543,-1,-1); //Barracks
	AddStaticVehicle(470,778.55950928,1612.68139648,5.87151670,49.99816895,-1,-1); //Patriot
	AddStaticVehicle(470,777.28637695,1608.75781250,5.87151670,69.99328613,-1,-1); //Patriot
	CreateDynamicObject(8150,754.90002441,1680.30004883,7.40000010,0.00000000,0.00000000,90.75000000); //object(vgsselecfence04) (1)
	CreateDynamicObject(8210,753.00000000,1770.50000000,6.69999981,0.00000000,0.00000000,91.24694824); //object(vgsselecfence12) (1)
	CreateDynamicObject(8313,755.50000000,1811.79980469,6.40000010,1.49963379,0.00000000,5.49865723); //object(vgsselecfence16) (2)
	CreateDynamicObject(8313,770.59960938,1820.00000000,6.19999981,0.24719238,2.49938965,264.48486328); //object(vgsselecfence16) (3)
	CreateDynamicObject(8313,793.59960938,1806.69921875,5.80000019,1.74133301,2.49938965,247.66479492); //object(vgsselecfence16) (4)
	CreateDynamicObject(8210,809.69921875,1771.50000000,5.69999981,0.00000000,0.00000000,102.24426270); //object(vgsselecfence12) (6)
	CreateDynamicObject(8210,837.33697510,1653.81738281,8.62500763,359.24743652,2.99926758,103.27697754); //object(vgsselecfence12) (7)
	CreateDynamicObject(3279,822.43408203,1708.46044922,4.50000000,0.00000000,0.00000000,284.74365234); //object(a51_spottower) (2)
	CreateDynamicObject(8313,828.09997559,1694.09997559,7.00000000,0.00000000,0.00000000,30.50000000); //object(vgsselecfence16) (5)
	CreateDynamicObject(7893,818.79998779,1734.00000000,4.40000010,0.00000000,0.00000000,103.00000000); //object(vegascrashbar04) (1)
	CreateDynamicObject(3885,816.29052734,1733.15673828,4.50000000,0.00000000,0.00000000,97.99804688); //object(sambase_sfxrf) (1)
	CreateDynamicObject(3884,816.46423340,1733.10229492,4.50000000,0.00000000,0.00000000,289.99511719); //object(samsite_sfxrf) (2)
	CreateDynamicObject(16337,822.25787354,1712.98266602,4.30000019,0.00000000,0.00000000,195.99609375); //object(des_cranecontrol) (1)
	CreateDynamicObject(3015,814.19921875,1681.89941406,4.40000010,0.00000000,0.00000000,0.00000000); //object(cr_cratestack) (1)
	CreateDynamicObject(925,782.63012695,1679.09875488,8.97500896,0.00000000,0.00000000,0.00000000); //object(rack2) (1)
	CreateDynamicObject(3577,791.59503174,1697.01806641,8.67499733,0.00000000,0.00000000,20.00000000); //object(dockcrates1_la) (1)
	CreateDynamicObject(3939,761.00000000,1729.40002441,5.50000000,0.00000000,0.00000000,2.00000000); //object(hanger01) (1)
	CreateDynamicObject(3939,760.79980469,1736.09960938,5.50000000,0.00000000,0.00000000,1.99951172); //object(hanger01) (2)
	CreateDynamicObject(3939,760.29998779,1743.40002441,5.50000000,0.00000000,0.00000000,1.99951172); //object(hanger01) (3)
	CreateDynamicObject(3939,775.59997559,1743.69995117,5.50000000,0.00000000,0.00000000,180.99951172); //object(hanger01) (4)
	CreateDynamicObject(3939,775.50000000,1736.40002441,5.50000000,0.00000000,0.00000000,179.49951172); //object(hanger01) (5)
	CreateDynamicObject(3939,775.29998779,1729.40002441,5.50000000,0.00000000,0.00000000,179.49462891); //object(hanger01) (6)
	CreateDynamicObject(967,817.84979248,1727.50170898,3.87499952,0.00000000,0.00000000,17.99560547); //object(bar_gatebox01) (1)
	CreateDynamicObject(3350,779.85607910,1700.25964355,4.09999990,0.00000000,0.00000000,180.00000000); //object(torino_mic) (1)
	CreateDynamicObject(1586,809.90002441,1643.69995117,4.30000019,0.00000000,0.00000000,0.00000000); //object(tar_civ1) (1)
	CreateDynamicObject(1585,800.00000000,1653.59997559,4.30000019,0.00000000,0.00000000,0.00000000); //object(tar_civ2) (1)
	CreateDynamicObject(1584,805.00000000,1657.00000000,4.30000019,0.00000000,0.00000000,0.00000000); //object(tar_gun1) (1)
	CreateDynamicObject(1583,799.09960938,1632.69921875,4.30000019,0.00000000,0.00000000,0.00000000); //object(tar_gun2) (1)
	CreateDynamicObject(1586,799.50000000,1653.09960938,4.30000019,0.00000000,0.00000000,0.00000000); //object(tar_civ1) (2)
	CreateDynamicObject(1586,802.79998779,1660.40002441,4.30000019,0.00000000,0.00000000,0.00000000); //object(tar_civ1) (3)
	CreateDynamicObject(1586,807.59997559,1654.50000000,4.30000019,0.00000000,0.00000000,0.00000000); //object(tar_civ1) (4)
	CreateDynamicObject(1586,803.20001221,1649.59997559,4.30000019,0.00000000,0.00000000,0.00000000); //object(tar_civ1) (5)
	CreateDynamicObject(1586,794.00000000,1656.30004883,4.30000019,0.00000000,0.00000000,0.00000000); //object(tar_civ1) (6)
	CreateDynamicObject(1586,794.39941406,1629.19921875,4.27500010,0.00000000,0.00000000,0.00000000); //object(tar_civ1) (7)
	CreateDynamicObject(1586,805.59997559,1628.30004883,4.30000019,0.00000000,0.00000000,0.00000000); //object(tar_civ1) (8)
	CreateDynamicObject(1586,800.50000000,1637.00000000,4.30000019,0.00000000,0.00000000,0.00000000); //object(tar_civ1) (9)
	CreateDynamicObject(1586,807.00000000,1636.50000000,4.30000019,0.00000000,0.00000000,0.00000000); //object(tar_civ1) (10)
	CreateDynamicObject(1586,795.20001221,1642.90002441,4.30000019,0.00000000,0.00000000,0.00000000); //object(tar_civ1) (11)
	CreateDynamicObject(1585,808.59997559,1646.30004883,4.30000019,0.00000000,0.00000000,0.00000000); //object(tar_civ2) (2)
	CreateDynamicObject(1585,802.90002441,1640.30004883,4.30000019,0.00000000,0.00000000,0.00000000); //object(tar_civ2) (3)
	CreateDynamicObject(1585,802.89941406,1640.29980469,4.30000019,0.00000000,0.00000000,0.00000000); //object(tar_civ2) (4)
	CreateDynamicObject(1584,798.59997559,1648.30004883,4.30000019,0.00000000,0.00000000,0.00000000); //object(tar_gun1) (2)
	CreateDynamicObject(1584,809.59997559,1630.90002441,4.30000019,0.00000000,0.00000000,0.00000000); //object(tar_gun1) (3)
	CreateDynamicObject(1583,797.40002441,1658.00000000,4.30000019,0.00000000,0.00000000,0.00000000); //object(tar_gun2) (2)
	CreateDynamicObject(1583,806.09997559,1651.90002441,4.30000019,0.00000000,0.00000000,0.00000000); //object(tar_gun2) (3)
	CreateDynamicObject(1583,793.09997559,1649.59997559,4.30000019,0.00000000,0.00000000,0.00000000); //object(tar_gun2) (4)
	CreateDynamicObject(1583,793.70001221,1640.30004883,4.30000019,0.00000000,0.00000000,0.00000000); //object(tar_gun2) (5)
	CreateDynamicObject(11245,795.29998779,1687.09997559,7.19999981,0.00000000,0.00000000,0.00000000); //object(sfsefirehseflag) (1)
	CreateDynamicObject(2985,797.20001221,1669.09997559,4.30000019,0.00000000,0.00000000,268.25000000); //object(minigun_base) (3)
	CreateDynamicObject(2985,806.20001221,1669.19995117,4.30000019,0.00000000,0.00000000,267.49853516); //object(minigun_base) (4)
	CreateDynamicObject(3795,791.11737061,1679.04699707,8.30000305,0.00000000,0.00000000,350.00000000); //object(missile_04_sfxr) (1)
	CreateDynamicObject(9241,768.38037109,1761.30468750,4.67499971,0.49987793,0.74707031,91.98852539); //object(copbits_sfn) (1)
	CreateDynamicObject(10831,768.26715088,1603.45947266,9.55044174,0.00000000,0.00000000,180.00000000); //object(drydock3_sfse) (1)
	CreateDynamicObject(3940,791.03320312,1690.98291016,7.42069435,0.00000000,0.00000000,0.00000000); //object(comms01) (1)
	CreateDynamicObject(3941,784.46734619,1690.30786133,7.45486450,0.00000000,0.00000000,179.25000000); //object(comms02) (1)
	CreateDynamicObject(3763,784.78363037,1690.56250000,12.15357018,0.00000000,0.00000000,0.00000000); //object(ce_radarmast3) (1)
	CreateDynamicObject(3030,792.69250488,1685.07446289,11.94379807,0.00000000,0.00000000,0.00000000); //object(wongs_erection) (1)
	CreateDynamicObject(3504,793.26495361,1704.19799805,5.54861355,0.00000000,0.00000000,0.00000000); //object(vgsn_portaloo) (1)
	CreateDynamicObject(3475,797.86077881,1694.10656738,5.20741987,0.00000000,0.00000000,269.25000000); //object(vgsn_fncelec_pst) (1)
	CreateDynamicObject(8315,808.18762207,1603.44726562,6.93259525,0.00000000,0.00000000,300.00000000); //object(vgsselecfence18) (1)
	CreateDynamicObject(17050,834.40710449,1615.90417480,-2.11848450,0.00000000,0.00000000,210.00000000); //object(cw_silo02) (1)
	CreateDynamicObject(17051,844.12414551,1624.72338867,-2.50868559,0.00000000,0.00000000,130.00000000); //object(cw_silo03) (1)
	CreateDynamicObject(17050,838.81256104,1618.78527832,2.63151550,0.00000000,0.00000000,159.99816895); //object(cw_silo02) (3)
	CreateDynamicObject(17050,842.77478027,1619.77038574,2.63151550,0.00000000,0.00000000,319.99389648); //object(cw_silo02) (4)
	CreateDynamicObject(3941,769.53173828,1787.21606445,6.72986174,0.00000000,0.00000000,271.49743652); //object(comms02) (2)
	CreateDynamicObject(17051,815.60339355,1741.99523926,3.14131308,0.00000000,0.00000000,39.99572754); //object(cw_silo03) (2)
	CreateDynamicObject(3279,786.53851318,1787.28161621,3.24999523,0.00000000,0.00000000,271.49365234); //object(a51_spottower) (2)
	CreateDynamicObject(3791,756.10894775,1615.26354980,4.57230568,0.00000000,0.00000000,20.00000000); //object(missile_10_sfxr) (2)

	/*==OBJECT ET VEH */
    AddStaticVehicle(470,2725.71655273,-2396.07836914,13.75424385,340.00000000,-1,-1); //Patriot
	AddStaticVehicle(470,2732.96728516,-2395.25927734,13.75424385,19.99938965,-1,-1); //Patriot
	AddStaticVehicle(470,2737.02587891,-2390.82617188,13.75424385,59.99511719,-1,-1); //Patriot
	AddStaticVehicle(470,2742.76391602,-2414.14868164,13.75424385,89.99084473,-1,-1); //Patriot
	AddStaticVehicle(470,2748.32641602,-2431.51196289,13.75424385,109.98901367,-1,-1); //Patriot
	AddStaticVehicle(470,2770.62133789,-2407.07226562,13.75424385,149.98413086,-1,-1); //Patriot
	AddStaticVehicle(470,2766.88867188,-2401.06127930,13.75424385,109.97985840,-1,-1); //Patriot
	AddStaticVehicle(470,2750.21386719,-2392.65844727,13.75424385,129.97863770,-1,-1); //Patriot
	AddStaticVehicle(433,2748.76586914,-2467.16992188,14.12202835,0.00000000,-1,-1); //Barracks
	AddStaticVehicle(433,2742.54101562,-2466.62597656,14.12202835,330.00000000,-1,-1); //Barracks
	AddStaticVehicle(433,2746.43383789,-2446.48559570,14.12202835,279.99633789,-1,-1); //Barracks
	AddStaticVehicle(432,2769.11572266,-2435.95922852,13.85523224,0.00000000,-1,-1); //Rhino
	AddStaticVehicle(411,2652.35058594,-2391.87524414,13.50781155,0.00000000,-1,-1); //Infernus
	AddStaticVehicle(558,2580.37036133,-2399.37011719,13.46941471,0.00000000,-1,-1); //Uranus
	AddStaticVehicle(565,2606.42749023,-2383.08007812,13.29992580,0.00000000,-1,-1); //Flash
	AddStaticVehicle(436,2272.11010742,-2103.23754883,13.52762794,0.00000000,-1,-1); //Previon
	AddStaticVehicle(533,2311.36059570,-2076.77783203,13.34687519,20.00000000,-1,-1); //Feltzer
	AddStaticVehicle(549,2314.40039062,-2074.89843750,13.40835190,0.00000000,-1,-1); //Tampa
	AddStaticVehicle(412,2334.53100586,-2063.02197266,13.49687481,0.00000000,-1,-1); //Voodoo
	AddStaticVehicle(405,2635.35815430,-1674.05761719,10.83875656,0.00000000,66,1); //Sentinel
	AddStaticVehicle(405,2635.23144531,-1682.10778809,10.83875656,40.00000000,-1,1); //Sentinel
	AddStaticVehicle(405,2635.17871094,-1689.45849609,10.83875656,359.99572754,1,1); //Sentinel
	AddStaticVehicle(421,2686.66992188,-1672.54431152,9.44425106,0.00000000,-1,-1); //Washington
	AddStaticVehicle(467,2691.62158203,-1672.09313965,9.33557701,20.00000000,-1,-1); //Oceanic
	AddStaticVehicle(447,2665.42749023,-1706.16748047,10.12974739,0.00000000,-1,-1); //Seasparrow
	AddStaticVehicle(548,2789.86669922,-2546.16113281,16.75255013,0.00000000,-1,-1); //Cargobob
	AddStaticVehicle(460,2777.80273438,-2306.21386719,2.25000000,289.99511719,-1,-1); //Skimmer
	AddStaticVehicle(452,2962.38964844,-1486.98437500,0.00000000,0.00000000,-1,-1); //Speeder
	AddStaticVehicle(507,1839.73767090,-1401.83081055,13.51249981,0.00000000,-1,-1); //Elegant
	AddStaticVehicle(534,1834.84936523,-1397.70458984,13.25256443,320.00000000,-1,-1); //Remington
	AddStaticVehicle(470,1825.30920410,-1361.06042480,14.54330635,0.00000000,-1,-1); //Patriot
	AddStaticVehicle(470,1822.05004883,-1361.13623047,14.54330635,0.00000000,-1,-1); //Patriot
	AddStaticVehicle(470,1821.84387207,-1374.39294434,14.54330635,0.00000000,-1,-1); //Patriot
	AddStaticVehicle(470,1824.83935547,-1374.55224609,14.54330635,0.00000000,-1,-1); //Patriot
	AddStaticVehicle(470,1764.00878906,-1345.96130371,15.87994289,240.00000000,-1,-1); //Patriot
	AddStaticVehicle(470,1763.99926758,-1354.48596191,15.87994289,269.99633789,-1,-1); //Patriot
	AddStaticVehicle(470,1756.96557617,-1355.23901367,15.87994289,281.99450684,-1,-1); //Patriot
	AddStaticVehicle(470,1798.42590332,-1438.80603027,13.54487610,0.00000000,-1,-1); //Patriot
	AddStaticVehicle(433,1805.57580566,-1433.18176270,13.89450073,90.00000000,-1,-1); //Barracks
	AddStaticVehicle(433,1805.34155273,-1428.19140625,13.89450073,100.00000000,-1,-1); //Barracks
	AddStaticVehicle(433,1798.42895508,-1424.95312500,13.89450073,119.99755859,-1,-1); //Barracks
	AddStaticVehicle(402,1797.10070801,-1465.35229492,13.48687458,280.00000000,-1,-1); //Buffalo
	AddStaticVehicle(432,1826.13684082,-1338.94262695,14.97866440,300.00000000,-1,-1); //Rhino
	AddStaticVehicle(432,1865.87255859,-1394.16223145,13.70115757,0.00000000,-1,-1); //Rhino
	AddStaticVehicle(433,1824.71179199,-1399.34814453,13.90036392,320.00000000,-1,-1); //Barracks
	AddStaticVehicle(470,1841.42163086,-1444.09875488,13.68236542,340.00000000,-1,-1); //Patriot
	AddStaticVehicle(470,1857.59899902,-1448.94506836,13.68236542,19.99938965,-1,-1); //Patriot
	AddStaticVehicle(420,2324.25122070,-1994.44995117,13.40109539,0.00000000,6,1); //Taxi
	AddStaticVehicle(420,2320.50219727,-1994.18090820,13.40109539,350.00000000,6,1); //Taxi
	AddStaticVehicle(426,2321.94775391,-1945.69836426,13.55313873,30.00000000,-1,-1); //Premier
	AddStaticVehicle(507,2315.67944336,-1879.07336426,14.19839478,10.00000000,-1,-1); //Elegant
	AddStaticVehicle(529,2272.19335938,-1899.84765625,13.28867626,340.00000000,-1,-1); //Willard
	AddStaticVehicle(546,2274.55371094,-1887.14160156,13.39529800,309.99572754,-1,-1); //Intruder
	AddStaticVehicle(550,2211.15234375,-1874.75292969,13.46965694,339.99938965,-1,-1); //Sunrise
	AddStaticVehicle(566,2644.37280273,-1623.99169922,19.02388191,340.00000000,-1,-1); //Tahoma
	AddStaticVehicle(406,2600.55712891,-2212.34130859,16.29820442,0.00000000,-1,-1); //Dumper
	AddStaticVehicle(420,2379.34570312,-1913.69323730,13.39687443,0.00000000,6,1); //Taxi
	AddStaticVehicle(507,2410.26269531,-1877.01562500,13.45654583,49.99877930,-1,-1); //Elegant
	AddStaticVehicle(551,2421.99487305,-1817.54235840,13.50187397,30.00000000,-1,-1); //Merit
	AddStaticVehicle(546,2400.38085938,-1787.84289551,13.66371918,0.00000000,-1,-1); //Intruder
	AddStaticVehicle(546,2364.47070312,-1764.46020508,13.83871651,20.00000000,-1,-1); //Intruder
	AddStaticVehicle(550,2374.42041016,-1759.91601562,13.59465504,0.00000000,-1,-1); //Sunrise
	AddStaticVehicle(550,2335.53027344,-1770.89562988,13.59465504,320.00000000,82,15); //Sunrise
	AddStaticVehicle(447,2475.37792969,-1764.16784668,19.32818985,30.00000000,-1,-1); //Seasparrow
	AddStaticVehicle(400,2477.58593750,-1748.81884766,14.10798264,0.00000000,-1,-1); //Landstalker
	AddStaticVehicle(470,2534.99340820,-1744.56530762,13.66830635,350.00000000,-1,-1); //Patriot
	AddStaticVehicle(470,2535.17553711,-1750.92663574,13.66830635,11.99694824,-1,-1); //Patriot
	AddStaticVehicle(424,2471.19677734,-1677.43505859,13.45503712,350.00000000,-1,-1); //BF Injection
	AddStaticVehicle(434,2406.49096680,-1985.07055664,13.69612026,10.00000000,-1,-1); //Hotknife
	AddStaticVehicle(579,2278.44506836,-1671.39746094,15.41620827,10.00000000,-1,-1); //Huntley
	AddStaticVehicle(579,2282.58935547,-1671.36303711,15.41620827,349.99755859,-1,-1); //Huntley
	AddStaticVehicle(500,1979.18444824,-1945.26953125,13.76687527,270.00000000,-1,-1); //Mesa
	AddStaticVehicle(579,1906.69860840,-1766.52282715,13.64551258,0.00000000,-1,-1); //Huntley
	AddStaticVehicle(579,1903.53820801,-1764.61511230,13.64551258,350.00000000,-1,-1); //Huntley
	AddStaticVehicle(540,2169.99169922,-1811.24841309,13.65137386,0.00000000,-1,-1); //Vincent
	AddStaticVehicle(529,2190.88574219,-1811.17675781,13.36314201,19.99511719,-1,-1); //Willard
	AddStaticVehicle(475,2349.97363281,-1850.20861816,1.67519736,0.00000000,-1,-1); //Sabre
	AddStaticVehicle(527,2257.93920898,-2215.62451172,13.33002377,0.00000000,-1,-1); //Cadrona
	AddStaticVehicle(514,2440.61376953,-2112.32714844,14.24654961,10.00000000,-1,-1); //Tanker
	AddStaticVehicle(514,2445.76538086,-2112.19189453,14.24654961,359.99755859,49,1); //Tanker
	AddStaticVehicle(514,2452.51123047,-2111.33496094,14.24654961,9.99450684,24,1); //Tanker
	AddStaticVehicle(470,2485.05224609,-2109.77172852,13.66830635,10.00000000,-1,-1); //Patriot
	AddStaticVehicle(470,2480.40258789,-2109.81420898,13.66830635,349.99755859,-1,-1); //Patriot
	AddStaticVehicle(470,2489.85424805,-2107.42871094,13.66830635,29.99694824,-1,-1); //Patriot
	AddStaticVehicle(470,2493.94311523,-2102.08642578,13.66830635,19.99267578,-1,-1); //Patriot
	AddStaticVehicle(432,2470.90820312,-2084.14453125,13.75366974,0.00000000,-1,-1); //Rhino
	AddStaticVehicle(432,2478.69970703,-2085.46337891,13.75366974,14.00000000,-1,-1); //Rhino
	AddStaticVehicle(432,2487.80737305,-2085.59301758,13.75366974,343.99658203,-1,-1); //Rhino
	AddStaticVehicle(433,2428.37377930,-2081.70507812,14.02046585,0.00000000,-1,-1); //Barracks
	AddStaticVehicle(433,2428.96728516,-2102.11743164,14.02046585,350.00000000,-1,-1); //Barracks
	AddStaticVehicle(433,2460.76782227,-1743.38867188,14.01825714,0.00000000,-1,-1); //Barracks
	AddStaticVehicle(409,2515.19042969,-1937.55603027,13.47187519,30.00000000,1,1); //Stretch
	AddStaticVehicle(470,2205.95849609,-2213.32690430,15.39330292,50.00000000,-1,-1); //Patriot
	AddStaticVehicle(470,2196.87084961,-2238.17382812,13.66830635,0.00000000,-1,-1); //Patriot
	AddStaticVehicle(470,2200.37890625,-2239.65332031,13.66830635,330.00000000,-1,-1); //Patriot
	AddStaticVehicle(470,2202.64648438,-2242.64013672,13.66830635,299.99633789,-1,-1); //Patriot
	AddStaticVehicle(470,2223.09570312,-2242.16699219,13.66830635,259.99267578,-1,-1); //Patriot
	AddStaticVehicle(470,2226.12158203,-2237.84765625,13.66830635,309.99145508,-1,-1); //Patriot
	AddStaticVehicle(470,2223.53271484,-2235.18066406,13.66830635,299.99023438,-1,-1); //Patriot
	AddStaticVehicle(489,2190.67968750,-2227.35595703,15.53121758,46.25000000,-1,-1); //Rancher
	AddStaticVehicle(433,2241.06518555,-2233.82299805,14.02046585,0.00000000,-1,-1); //Barracks
	AddStaticVehicle(433,2247.72656250,-2235.32031250,14.02046585,30.50000000,-1,-1); //Barracks
	AddStaticVehicle(433,2233.30590820,-2228.93334961,14.02046585,308.00000000,-1,-1); //Barracks
	AddStaticVehicle(433,2222.64160156,-2211.56274414,14.02046585,247.99621582,-1,-1); //Barracks
	AddStaticVehicle(433,2215.56152344,-2216.86035156,14.02046585,197.99438477,-1,-1); //Barracks
	AddStaticVehicle(470,2120.85668945,-2286.16479492,13.61635494,0.00000000,-1,-1); //Patriot
	AddStaticVehicle(470,2117.86352539,-2286.49194336,13.61635494,10.00000000,-1,-1); //Patriot
	AddStaticVehicle(470,2114.74145508,-2287.43237305,13.61635494,19.99755859,-1,-1); //Patriot
	AddStaticVehicle(470,2131.19604492,-2293.21997070,13.61635494,149.99743652,-1,-1); //Patriot
	AddStaticVehicle(470,2133.85595703,-2296.57080078,13.61635494,119.99633789,-1,-1); //Patriot
	AddStaticVehicle(433,2117.77563477,-2309.86303711,13.98414993,260.00000000,-1,-1); //Barracks
	AddStaticVehicle(433,2118.16894531,-2305.24658203,13.98414993,269.99694824,-1,-1); //Barracks
	AddStaticVehicle(433,2209.19409180,-2297.97412109,15.23826027,320.00000000,-1,-1); //Barracks
	AddStaticVehicle(433,2206.29687500,-2294.22387695,15.23826027,299.99877930,-1,-1); //Barracks
	AddStaticVehicle(563,2176.83154297,-2303.55761719,14.11019611,0.00000000,-1,-1); //Raindance
	AddStaticVehicle(447,2189.75415039,-2289.69165039,19.29395103,320.00000000,1,1); //Seasparrow
	AddStaticVehicle(469,2176.30566406,-2331.27465820,19.28287506,20.00000000,-1,-1); //Sparrow
	AddStaticVehicle(470,2770.68945312,-2503.42993164,13.75671196,0.00000000,-1,-1); //Patriot
	AddStaticVehicle(470,2766.46972656,-2506.35034180,13.75671196,40.00000000,-1,-1); //Patriot
	AddStaticVehicle(464,2504.20629883,-1919.43103027,24.95700264,0.00000000,-1,-1); //RC Baron
	AddStaticVehicle(464,2501.68896484,-1919.21228027,24.95700264,350.00000000,-1,-1); //RC Baron
	AddStaticVehicle(405,2038.55944824,-1625.19946289,13.54687500,0.00000000,-1,-1); //Sentinel
	AddStaticVehicle(426,2028.41333008,-1641.45019531,13.37468338,0.00000000,-1,-1); //Premier
	AddStaticVehicle(467,2004.56665039,-1597.99768066,13.43300056,0.00000000,-1,-1); //Oceanic
	AddStaticVehicle(492,2177.74243164,-1498.07763672,23.87771988,0.00000000,-1,-1); //Greenwood
	AddStaticVehicle(516,2143.96875000,-1497.97778320,23.86736870,50.00000000,-1,-1); //Nebula
	AddStaticVehicle(546,2172.25732422,-1391.82324219,23.82622337,70.00000000,-1,-1); //Intruder
	AddStaticVehicle(566,2220.01635742,-1510.13684082,23.89999962,0.00000000,-1,-1); //Tahoma
	AddStaticVehicle(433,2230.16430664,-1493.63256836,24.31753922,0.00000000,-1,-1); //Barracks
	AddStaticVehicle(433,2225.30395508,-1493.62060547,24.31753922,10.00000000,-1,-1); //Barracks
	AddStaticVehicle(432,2131.42846680,-1490.22338867,24.02209282,0.00000000,-1,-1); //Rhino
	AddStaticVehicle(576,1977.62866211,-1985.64221191,13.29687500,0.00000000,19,1); //Tornado
	AddStaticVehicle(545,1977.68029785,-1995.64648438,13.37888908,0.00000000,-1,-1); //Hustler
	AddStaticVehicle(533,1984.21838379,-1995.45446777,13.35390186,0.00000000,2,1); //Feltzer
	AddStaticVehicle(419,1973.05993652,-2016.11096191,13.47687531,0.00000000,16,1); //Esperanto
	AddStaticVehicle(452,2955.02685547,-1497.92370605,0.00000000,340.00000000,48,53); //Speeder
	AddStaticVehicle(405,2747.85302734,-1095.69555664,69.57812500,0.00000000,-1,-1); //Sentinel
	AddStaticVehicle(445,2715.29638672,-1108.79321289,69.56354523,0.00000000,2,1); //Admiral
	AddStaticVehicle(487,2683.32763672,-1009.96472168,86.98061371,40.00000000,-1,-1); //Maverick
	AddStaticVehicle(550,2699.73828125,-1109.32421875,69.50090790,0.00000000,33,1); //Sunrise
	AddStaticVehicle(447,2703.55883789,-1206.32885742,75.84165192,40.00000000,-1,-1); //Seasparrow
	AddStaticVehicle(470,2712.11718750,-1252.78173828,59.76097870,280.00000000,-1,-1); //Patriot
	AddStaticVehicle(470,2712.11450195,-1262.91076660,59.76097870,259.99755859,-1,-1); //Patriot
	AddStaticVehicle(470,2717.64550781,-1251.50451660,59.76097870,309.99755859,-1,-1); //Patriot
	AddStaticVehicle(470,2715.76440430,-1276.59790039,58.26099396,179.99694824,-1,-1); //Patriot
	AddStaticVehicle(470,2716.70751953,-1284.59106445,57.71096039,169.99444580,-1,-1); //Patriot
	AddStaticVehicle(489,2730.15332031,-1291.72595215,55.66780472,24.00000000,-1,-1); //Rancher
	AddStaticVehicle(442,2745.63085938,-1265.65637207,59.70095062,0.00000000,-1,-1); //Romero
	AddStaticVehicle(549,2650.20068359,-1264.54541016,49.87865448,0.00000000,-1,-1); //Tampa
	AddStaticVehicle(533,2649.06958008,-1249.61657715,49.81494522,320.00000000,-1,-1); //Feltzer
	AddStaticVehicle(517,2634.45117188,-1263.97937012,49.95118332,40.00000000,-1,-1); //Majestic
	AddStaticVehicle(496,2803.46459961,-1253.96923828,46.74085236,130.00000000,-1,-1); //Blista Compact
	AddStaticVehicle(526,2788.80590820,-1266.29077148,46.79202652,340.00000000,-1,-1); //Fortune
	AddStaticVehicle(603,2784.01538086,-1288.30187988,42.96177292,90.00000000,-1,-1); //Phoenix
	AddStaticVehicle(587,2714.44726562,-1336.41479492,47.53250122,0.00000000,-1,-1); //Euros
	AddStaticVehicle(602,2744.41479492,-1164.54174805,69.38298798,0.00000000,-1,-1); //Alpha
	AddStaticVehicle(436,2729.88916016,-1157.55480957,70.31958008,50.00000000,-1,-1); //Previon
	AddStaticVehicle(470,2745.53076172,-1127.23962402,69.69955444,0.00000000,-1,-1); //Patriot
	AddStaticVehicle(470,2748.06909180,-1122.95336914,69.69955444,30.00000000,-1,-1); //Patriot
	AddStaticVehicle(470,2730.50390625,-1121.58068848,69.84956360,119.99816895,-1,-1); //Patriot
	AddStaticVehicle(458,2700.03808594,-1191.04003906,69.39594269,70.00000000,-1,-1); //Solair
	AddStaticVehicle(470,2654.02539062,-1177.44873047,68.24546051,70.00000000,-1,-1); //Patriot
	AddStaticVehicle(470,2653.84472656,-1190.90307617,68.24546051,110.00000000,-1,-1); //Patriot
	AddStaticVehicle(470,2660.86035156,-1191.79296875,68.24546051,89.99511719,-1,-1); //Patriot
	AddStaticVehicle(487,2778.13525391,-1304.02893066,53.17906189,20.00000000,-1,-1); //Maverick
	AddStaticVehicle(469,2778.81835938,-1283.17419434,59.23897552,0.00000000,-1,-1); //Sparrow
	CreateObject(1327,2721.07177734,-2408.92675781,13.35391331,0.00000000,0.00000000,348.00000000); //object(junk_tyre) (1)
	CreateObject(1227,2664.45019531,-2409.87304688,13.27687359,0.00000000,0.00000000,280.00000000); //object(dump1) (1)
	CreateObject(16096,2696.96704102,-2392.21899414,14.49164486,0.00000000,0.00000000,0.00000000); //object(des_a51guardbox04) (1)
	CreateObject(18100,2300.11767578,-2096.90234375,12.37635231,0.00000000,0.00000000,0.00000000); //object(cj_rubbish01) (1)
	CreateObject(18100,2284.25000000,-2084.99023438,12.37635231,0.00000000,0.00000000,50.00000000); //object(cj_rubbish01) (2)
	CreateObject(18100,2297.12280273,-2088.76440430,12.37635231,0.00000000,0.00000000,89.99877930); //object(cj_rubbish01) (3)
	CreateObject(18100,2298.60888672,-2099.20947266,12.37635231,0.00000000,0.00000000,127.99450684); //object(cj_rubbish01) (4)
	CreateObject(3461,2281.28344727,-2073.64331055,10.55571270,0.00000000,0.00000000,0.00000000); //object(tikitorch01_lvs) (1)
	CreateObject(3461,2289.79541016,-2076.64038086,10.55571270,0.00000000,0.00000000,0.00000000); //object(tikitorch01_lvs) (2)
	CreateObject(3461,2302.97900391,-2104.11840820,10.41078186,0.00000000,0.00000000,0.00000000); //object(tikitorch01_lvs) (3)
	CreateObject(3461,2313.92993164,-2098.44946289,11.06077194,0.00000000,0.00000000,0.00000000); //object(tikitorch01_lvs) (4)
	CreateObject(3461,2276.32519531,-2080.68505859,10.73577690,0.00000000,0.00000000,0.00000000); //object(tikitorch01_lvs) (5)
	CreateObject(2415,2307.19189453,-2103.14428711,11.07718849,0.00000000,0.00000000,0.00000000); //object(cj_ff_fryer) (1)
	CreateObject(2415,2275.78515625,-2072.42089844,11.07718849,0.00000000,0.00000000,0.00000000); //object(cj_ff_fryer) (2)
	CreateObject(2415,2298.78784180,-2068.28979492,11.07718849,0.00000000,0.00000000,0.00000000); //object(cj_ff_fryer) (3)
	CreateObject(2415,2289.66870117,-2101.30004883,11.07718849,0.00000000,0.00000000,0.00000000); //object(cj_ff_fryer) (4)
	CreateObject(2415,2291.24780273,-2080.00268555,11.07718849,0.00000000,0.00000000,0.00000000); //object(cj_ff_fryer) (5)
	CreateObject(2927,2283.22729492,-2067.01269531,14.68434429,352.00000000,0.00000000,30.00000000); //object(a51_blastdoorr) (1)
	CreateObject(852,2301.57055664,-2104.49121094,12.30230236,0.00000000,0.00000000,0.00000000); //object(cj_urb_rub_4) (1)
	CreateObject(851,2283.56518555,-2072.60156250,12.74932957,0.00000000,0.00000000,0.00000000); //object(cj_urb_rub_2) (1)
	CreateObject(850,2284.61401367,-2082.22192383,12.47764778,0.00000000,0.00000000,10.00000000); //object(cj_urb_rub_1) (1)
	CreateObject(3887,2295.51171875,-1912.94726562,13.52533913,359.50012207,2.49389648,180.01098633); //object(demolish4_sfxrf) (1)
	CreateObject(1353,2314.22924805,-1903.44787598,13.06517220,0.00000000,0.00000000,10.00000000); //object(cj_aircon) (1)
	CreateObject(1688,2316.16357422,-1960.31665039,13.25228500,0.00000000,0.00000000,10.00000000); //object(gen_roofbit2) (1)
	CreateObject(3287,2333.72778320,-1956.40393066,25.28904533,0.00000000,0.00000000,330.00000000); //object(cxrf_oiltank) (1)
	CreateObject(3502,2322.21679688,-1933.81433105,18.01456261,37.39288330,5.03411865,266.18481445); //object(vgsn_con_tube) (1)
	CreateObject(3502,2314.70654297,-1933.36755371,14.26366234,15.94937134,4.68054199,266.70755005); //object(vgsn_con_tube) (2)
	CreateObject(3643,2330.41333008,-1928.03845215,25.11685753,0.00000000,0.00000000,0.00000000); //object(la_chem_piping) (1)
	CreateObject(6934,2349.96948242,-1903.62170410,64.54653168,0.00000000,0.00000000,0.00000000); //object(vegasplant09) (1)
	CreateObject(7950,2776.84936523,-2343.75317383,6.96732712,0.00000000,0.00000000,0.00000000); //object(vegaspumphouse02) (1)
	CreateObject(939,2361.62524414,-2043.61230469,15.02653122,0.00000000,0.00000000,300.00000000); //object(cj_df_unit) (1)
	CreateObject(923,2362.05908203,-2047.77783203,13.33436966,0.00000000,0.00000000,268.00000000); //object(packing_carates2) (1)
	CreateObject(922,2362.76171875,-2051.43041992,13.28473377,0.00000000,0.00000000,290.00000000); //object(packing_carates1) (1)
	CreateObject(3567,2425.59960938,-2049.42919922,22.00668526,0.49600220,352.74972534,0.06311035); //object(lasnfltrail) (1)
	CreateObject(3134,2424.35937500,-2052.31542969,23.20424080,0.00000000,0.00000000,0.00000000); //object(quarry_barrel) (1)
	CreateObject(3066,2425.42138672,-2046.49609375,23.63794708,0.00000000,0.00000000,0.00000000); //object(ammotrn_obj) (1)
	CreateObject(2973,2356.19360352,-2051.47875977,12.45005798,0.00000000,0.00000000,20.00000000); //object(k_cargo2) (1)
	CreateObject(2933,2356.49316406,-2056.43188477,13.13932705,0.00000000,0.00000000,270.00000000); //object(pol_comp_gate) (1)
	CreateObject(18260,2296.22924805,-2064.35815430,13.88872719,0.00000000,0.00000000,0.00000000); //object(crates01) (1)
	CreateObject(1362,2264.17553711,-2091.75463867,13.27979279,0.00000000,0.00000000,0.00000000); //object(cj_firebin) (1)
	CreateObject(1685,2272.44042969,-2097.26269531,13.35210037,0.00000000,0.00000000,310.00000000); //object(blockpallet) (1)
	CreateObject(2669,2305.86303711,-2071.83251953,13.88714790,0.00000000,0.00000000,90.00000000); //object(cj_chris_crate) (1)
	CreateObject(3565,2326.27197266,-2070.51708984,13.89481544,0.00000000,0.00000000,340.00000000); //object(lasdkrt1_la01) (1)
	CreateObject(3574,2326.29052734,-2082.22509766,15.23856640,0.00000000,0.00000000,10.00000000); //object(lasdkrtgrp2) (1)
	CreateObject(3576,2322.87597656,-2093.86499023,13.96454906,0.00000000,0.00000000,0.00000000); //object(dockcrates2_la) (1)
	CreateObject(3577,2316.77050781,-2094.69531250,13.25438309,0.00000000,0.00000000,29.99816895); //object(dockcrates1_la) (1)
	CreateObject(3630,2330.53637695,-2096.76367188,13.96449852,0.00000000,0.00000000,330.00000000); //object(crdboxes2_las) (1)
	CreateObject(3633,2327.55029297,-2095.73242188,15.93942928,0.00000000,0.00000000,0.00000000); //object(imoildrum4_las) (1)
	CreateObject(3630,2309.37304688,-1928.32299805,13.90668201,0.00000000,0.00000000,350.00000000); //object(crdboxes2_las) (2)
	CreateObject(3576,2305.42407227,-1956.59106445,14.06534195,0.00000000,0.00000000,320.00000000); //object(dockcrates2_la) (2)
	CreateObject(3577,2310.93212891,-1957.68115234,13.15298843,0.00000000,0.00000000,0.00000000); //object(dockcrates1_la) (2)
	CreateObject(3633,2311.00048828,-1957.68176270,14.41317368,0.00000000,0.00000000,10.00000000); //object(imoildrum4_las) (2)
	CreateObject(3573,2315.31420898,-1898.58764648,15.10071468,0.00000000,0.00000000,0.00000000); //object(lasdkrtgrp1) (1)
	CreateObject(3576,2312.07470703,-1900.19567871,16.59902191,0.00000000,0.00000000,270.00000000); //object(dockcrates2_la) (3)
	CreateObject(3633,2308.89916992,-1901.59729004,18.27847481,0.00000000,0.00000000,10.00000000); //object(imoildrum4_las) (3)
	CreateObject(3800,2316.12182617,-1901.66955566,17.80367279,0.00000000,0.00000000,340.00000000); //object(acbox4_sfs) (1)
	CreateObject(10984,1841.86242676,-1525.03515625,13.18657684,0.00000000,0.00000000,0.00000000); //object(rubbled01_sfs) (1)
	CreateObject(18260,1847.65832520,-1517.10961914,13.94758034,0.00000000,0.00000000,0.00000000); //object(crates01) (2)
	CreateObject(930,1844.48352051,-1518.58752441,16.85026360,0.00000000,0.00000000,0.00000000); //object(o2_bottles) (1)
	CreateObject(1271,1837.38769531,-1516.76647949,12.72422028,0.00000000,0.00000000,0.00000000); //object(gunbox) (2)
	CreateObject(925,1844.07861328,-1533.51477051,13.60877991,0.00000000,0.00000000,0.00000000); //object(rack2) (2)
	CreateObject(1362,1844.08154297,-1533.42126465,15.27805901,0.00000000,0.00000000,0.00000000); //object(cj_firebin) (2)
	CreateObject(2567,1829.26843262,-1538.34082031,14.31041336,0.00000000,0.00000000,0.00000000); //object(ab_warehouseshelf) (1)
	CreateObject(2415,1839.69409180,-1525.75585938,11.21528149,0.00000000,0.00000000,0.00000000); //object(cj_ff_fryer) (6)
	CreateObject(2415,1842.92175293,-1532.36218262,11.21528149,0.00000000,0.00000000,0.00000000); //object(cj_ff_fryer) (7)
	CreateObject(2415,1830.20532227,-1534.70532227,11.21528149,0.00000000,0.00000000,0.00000000); //object(cj_ff_fryer) (8)
	CreateObject(2415,1842.23742676,-1520.08288574,11.21528149,0.00000000,0.00000000,0.00000000); //object(cj_ff_fryer) (9)
	CreateObject(2415,1848.28894043,-1523.50158691,11.21528149,0.00000000,0.00000000,0.00000000); //object(cj_ff_fryer) (10)
	CreateObject(2415,1837.66943359,-1516.44726562,11.21528149,0.00000000,0.00000000,0.00000000); //object(cj_ff_fryer) (11)
	CreateObject(2415,1839.19519043,-1520.01574707,11.21528149,0.00000000,0.00000000,0.00000000); //object(cj_ff_fryer) (12)
	CreateObject(2415,1844.54821777,-1529.09338379,11.21528149,0.00000000,0.00000000,0.00000000); //object(cj_ff_fryer) (13)
	CreateObject(3461,1845.28503418,-1518.30834961,14.69941139,0.00000000,0.00000000,0.00000000); //object(tikitorch01_lvs) (6)
	CreateObject(3461,1835.44494629,-1542.51354980,10.77442169,0.00000000,0.00000000,0.00000000); //object(tikitorch01_lvs) (7)
	CreateObject(3461,1835.44494629,-1542.51354980,10.77442169,0.00000000,0.00000000,0.00000000); //object(tikitorch01_lvs) (8)
	CreateObject(1327,2547.07568359,-1740.59570312,13.50738049,0.00000000,0.00000000,0.00000000); //object(junk_tyre) (2)
	CreateObject(12957,2546.47436523,-1736.82629395,13.08603191,0.00000000,0.00000000,20.00000000); //object(sw_pickupwreck01) (2)
	CreateObject(3461,2547.42236328,-1738.70568848,11.66223049,0.00000000,0.00000000,0.00000000); //object(tikitorch01_lvs) (9)
	CreateObject(2985,2548.60400391,-1735.45690918,12.33281326,0.00000000,0.00000000,170.00000000); //object(minigun_base) (3)
	CreateObject(3630,2475.40625000,-1739.74218750,13.78950119,0.00000000,0.00000000,59.99633789); //object(crdboxes2_las) (3)
	CreateObject(3633,2477.44311523,-1736.79309082,15.76443195,0.00000000,0.00000000,0.00000000); //object(imoildrum4_las) (4)
	CreateObject(3798,2480.81445312,-1730.86328125,12.33281326,0.00000000,0.00000000,349.99694824); //object(acbox3_sfs) (1)
	CreateObject(8077,2479.19775391,-1784.35363770,16.32001495,0.00000000,0.00000000,290.00000000); //object(vgsfrates06) (1)
	CreateObject(13025,2493.96484375,-1749.42395020,15.66774940,0.00000000,0.00000000,0.00000000); //object(sw_fueldrum01) (1)
	CreateObject(939,2529.79785156,-1725.00903320,14.74010468,0.00000000,0.00000000,68.00000000); //object(cj_df_unit) (2)
	CreateObject(939,2514.23193359,-1731.41735840,14.64010620,0.00000000,0.00000000,57.99987793); //object(cj_df_unit) (3)
	CreateObject(923,2513.43237305,-1735.56262207,13.13750076,0.00000000,0.00000000,80.00000000); //object(packing_carates2) (2)
	CreateObject(3378,2506.55615234,-1719.91528320,18.65274048,0.00000000,0.00000000,90.00000000); //object(ce_beerpile01) (1)
	CreateObject(3066,2428.74731445,-1729.26574707,13.65083885,0.00000000,0.00000000,330.00000000); //object(ammotrn_obj) (2)
	CreateObject(3046,2433.58374023,-1724.82751465,12.99357986,0.00000000,0.00000000,0.00000000); //object(kb_barrel) (1)
	CreateObject(12957,2352.77539062,-2017.26550293,13.37468815,0.00000000,0.00000000,310.00000000); //object(sw_pickupwreck01) (3)
	CreateObject(1227,2360.24804688,-2018.17175293,13.34182358,0.00000000,0.00000000,340.00000000); //object(dump1) (2)
	CreateObject(13591,2225.30932617,-1926.67993164,12.73414230,0.00000000,0.00000000,350.00000000); //object(kickcar28) (1)
	CreateObject(18248,2205.33984375,-1938.79052734,18.18836784,1.29241943,329.49139404,9.01147461); //object(cuntwjunk01) (1)
	CreateObject(8613,2248.15747070,-1966.59143066,16.87033463,0.00000000,0.00000000,0.00000000); //object(vgssstairs03_lvs) (1)
	CreateObject(2669,2229.79711914,-1950.70043945,21.75230598,355.00000000,0.00000000,300.00000000); //object(cj_chris_crate) (2)
	CreateObject(3565,2293.50537109,-1959.08850098,21.56669044,0.00000000,0.00000000,20.00000000); //object(lasdkrt1_la01) (2)
	CreateObject(3569,2352.25634766,-1970.87731934,14.57709503,0.00000000,0.00000000,40.00000000); //object(lasntrk3) (1)
	CreateObject(3576,2359.10546875,-1980.07934570,14.03954792,0.00000000,0.00000000,20.00000000); //object(dockcrates2_la) (4)
	CreateObject(3577,2321.06518555,-2065.86474609,13.32938194,0.00000000,0.00000000,350.00000000); //object(dockcrates1_la) (3)
	CreateObject(3633,2327.56518555,-1993.58605957,15.50387383,0.00000000,0.00000000,0.00000000); //object(imoildrum4_las) (5)
	CreateObject(5262,2311.17944336,-1992.17114258,15.51450062,0.00000000,0.00000000,70.00000000); //object(las2dkwar04) (2)
	CreateObject(3798,2604.92260742,-1608.27246094,18.58667755,0.00000000,0.00000000,350.00000000); //object(acbox3_sfs) (2)
	CreateObject(1362,2606.42846680,-1607.23181152,19.20388603,0.00000000,0.00000000,0.00000000); //object(cj_firebin) (3)
	CreateObject(2732,2605.97558594,-1608.44738770,19.49264526,0.00000000,0.00000000,80.00000000); //object(cj_zip_post_2) (1)
	CreateObject(3335,2604.03002930,-1611.78393555,18.74322891,0.00000000,0.00000000,80.00000000); //object(ce_roadsign1) (1)
	CreateObject(3468,2607.34985352,-1597.25646973,19.30040550,0.00000000,0.00000000,70.00000000); //object(vegstreetsign2) (1)
	CreateObject(2973,2605.20288086,-1602.75915527,18.50640297,0.00000000,0.00000000,350.00000000); //object(k_cargo2) (2)
	CreateObject(2973,2605.25610352,-1599.80847168,18.50640297,0.00000000,0.00000000,9.99694824); //object(k_cargo2) (3)
	CreateObject(2973,2605.33496094,-1601.16333008,20.95638847,0.00000000,0.00000000,349.99206543); //object(k_cargo2) (4)
	CreateObject(2933,2608.79882812,-1604.33837891,20.13991547,289.55535889,94.22766113,95.98559570); //object(pol_comp_gate) (2)
	CreateObject(18260,2605.58593750,-1614.33093262,20.17827415,0.00000000,0.00000000,60.00000000); //object(crates01) (3)
	CreateObject(18257,2609.10327148,-1618.35754395,18.61091805,0.00000000,0.00000000,40.00000000); //object(crates) (1)
	CreateObject(2415,2606.55688477,-1614.15795898,16.73007202,0.00000000,0.00000000,0.00000000); //object(cj_ff_fryer) (14)
	CreateObject(2415,2603.97949219,-1620.62817383,16.65506554,0.00000000,0.00000000,0.00000000); //object(cj_ff_fryer) (15)
	CreateObject(2415,2604.75927734,-1608.54296875,16.63006973,0.00000000,0.00000000,0.00000000); //object(cj_ff_fryer) (16)
	CreateObject(3461,2606.37524414,-1607.15747070,18.05928612,0.00000000,0.00000000,0.00000000); //object(tikitorch01_lvs) (10)
	CreateObject(3461,2607.16625977,-1609.94482422,19.00927162,0.00000000,0.00000000,0.00000000); //object(tikitorch01_lvs) (11)
	CreateObject(3461,2609.95849609,-1616.31250000,17.03425598,0.00000000,0.00000000,0.00000000); //object(tikitorch01_lvs) (12)
	CreateObject(1358,2612.19799805,-1600.44274902,19.83501053,0.00000000,0.00000000,40.00000000); //object(cj_skip_rubbish) (1)
	CreateObject(1370,2605.89111328,-1602.12207031,23.96089935,0.00000000,0.00000000,0.00000000); //object(cj_flame_drum) (1)
	CreateObject(1365,2606.94433594,-1628.22424316,19.76130676,0.00000000,0.00000000,110.00000000); //object(cj_big_skip1) (1)
	CreateObject(1358,2675.28149414,-1645.94226074,11.20606709,0.00000000,0.00000000,340.00000000); //object(cj_skip_rubbish) (2)
	CreateObject(1344,2679.74365234,-1646.71423340,11.02582932,0.00000000,0.00000000,0.00000000); //object(cj_dumpster2) (1)
	CreateObject(1327,2672.89331055,-1644.77917480,10.91810226,0.00000000,0.00000000,30.00000000); //object(junk_tyre) (3)
	CreateObject(12957,2669.76855469,-1643.32397461,10.54116535,0.00000000,0.00000000,90.00000000); //object(sw_pickupwreck01) (4)
	CreateObject(1265,2669.24414062,-1643.40393066,10.88206100,0.00000000,0.00000000,0.00000000); //object(blackbag2) (1)
	CreateObject(1227,2657.08764648,-1645.94274902,10.71667671,0.00000000,0.00000000,20.00000000); //object(dump1) (3)
	CreateObject(1331,2659.45947266,-1645.88171387,10.43690777,0.00000000,0.00000000,0.00000000); //object(binnt01_la) (1)
	CreateObject(2674,2660.78466797,-1645.00927734,9.88487053,0.00000000,0.00000000,20.00000000); //object(proc_rubbish_2) (1)
	CreateObject(2674,2656.08349609,-1645.86889648,9.88487053,0.00000000,0.00000000,39.99511719); //object(proc_rubbish_2) (2)
	CreateObject(2674,2657.62011719,-1644.89538574,9.88487053,0.00000000,0.00000000,9.99023438); //object(proc_rubbish_2) (3)
	CreateObject(2677,2657.99536133,-1647.20703125,10.13944149,0.00000000,0.00000000,0.00000000); //object(proc_rubbish_7) (1)
	CreateObject(3594,2662.92041016,-1664.36779785,10.49727917,0.00000000,0.00000000,80.00000000); //object(la_fuckcar1) (1)
	CreateObject(11496,2664.72802734,-1633.82214355,15.18082237,0.00000000,0.00000000,268.00000000); //object(des_wjetty) (1)
	CreateObject(3630,2418.18383789,-1838.19604492,13.82543564,0.00000000,0.00000000,350.00000000); //object(crdboxes2_las) (4)
	CreateObject(3633,2412.34790039,-1838.38183594,12.80761528,0.00000000,0.00000000,10.00000000); //object(imoildrum4_las) (6)
	CreateObject(3633,2410.95312500,-1838.00244141,12.80761528,0.00000000,0.00000000,339.99755859); //object(imoildrum4_las) (7)
	CreateObject(3633,2410.95312500,-1838.00195312,13.75761604,0.00000000,0.00000000,339.99389648); //object(imoildrum4_las) (8)
	CreateObject(3633,2409.71801758,-1837.30053711,12.80761528,0.00000000,0.00000000,29.99755859); //object(imoildrum4_las) (9)
	CreateObject(2973,2421.99121094,-1843.32458496,12.54687500,0.00000000,0.00000000,22.00000000); //object(k_cargo2) (5)
	CreateObject(2595,2413.90625000,-1838.39062500,15.68318558,0.00000000,0.00000000,0.00000000); //object(cj_shop_tv_video) (1)
	CreateObject(2630,2410.11059570,-1838.73144531,12.38281250,0.00000000,0.00000000,20.00000000); //object(gym_bike) (1)
	CreateObject(2813,2409.53393555,-1837.48388672,13.28061581,0.00000000,0.00000000,0.00000000); //object(gb_novels01) (1)
	CreateObject(2851,2409.77050781,-1836.90051270,13.28061581,0.00000000,0.00000000,0.00000000); //object(gb_kitchdirt05) (1)
	CreateObject(3800,2420.86254883,-1870.88146973,12.54687500,0.00000000,0.00000000,20.00000000); //object(acbox4_sfs) (2)
	CreateObject(10814,2441.36425781,-1899.34277344,20.41301727,0.00000000,0.00000000,0.00000000); //object(apfuel2_sfse) (1)
	CreateObject(3866,2367.68847656,-1855.38989258,8.19020462,0.00000000,0.00000000,290.00000000); //object(demolish1_sfxrf) (1)
	CreateObject(10985,2366.40869141,-1844.37231445,0.91930056,0.00000000,0.00000000,29.99816895); //object(rubbled02_sfs) (19)
	CreateObject(10985,2372.39306641,-1844.18090820,0.91930056,0.00000000,0.00000000,309.99816895); //object(rubbled02_sfs) (20)
	CreateObject(10985,2367.89453125,-1851.09179688,0.91930056,0.00000000,0.00000000,309.99572754); //object(rubbled02_sfs) (21)
	CreateObject(3406,2400.18481445,-1833.48168945,6.11057949,0.00000000,0.00000000,0.00000000); //object(cxref_woodjetty) (1)
	CreateObject(1388,2447.86816406,-1872.28710938,8.54881382,0.00000000,0.00000000,52.49816895); //object(twrcrane_s_04) (1)
	CreateObject(1389,2443.78710938,-1862.82226562,0.63400602,0.00000000,0.00000000,0.00000000); //object(twrcrane_s_01) (1)
	CreateObject(1391,2460.18652344,-1888.53344727,44.57720947,0.00000000,0.00000000,0.00000000); //object(twrcrane_s_03) (1)
	CreateObject(8877,2454.64746094,-1883.83569336,18.34764099,0.00000000,0.00000000,290.00000000); //object(vgsecnstrct10) (1)
	CreateObject(16337,2402.28515625,-1880.69531250,12.54687500,0.00000000,0.00000000,0.00000000); //object(des_cranecontrol) (1)
	CreateObject(934,2406.10620117,-1874.54370117,13.87515450,0.00000000,0.00000000,310.00000000); //object(generator_big) (1)
	CreateObject(3502,2425.43212891,-1875.61035156,21.50052643,346.03479004,355.87799072,17.00360107); //object(vgsn_con_tube) (3)
	CreateObject(3502,2427.35595703,-1882.93737793,24.54800987,328.00000000,0.00000000,12.00000000); //object(vgsn_con_tube) (4)
	CreateObject(942,2434.02734375,-1886.52832031,25.91260910,0.00000000,0.00000000,19.99511719); //object(cj_df_unit_2) (1)
	CreateObject(939,2425.97167969,-1896.38659668,25.91260910,0.00000000,0.00000000,30.00000000); //object(cj_df_unit) (4)
	CreateObject(2973,2436.60986328,-1896.72583008,23.46938324,0.00000000,0.00000000,0.00000000); //object(k_cargo2) (6)
	CreateObject(2933,2415.08471680,-1842.74768066,14.04842091,290.26336670,267.96795654,347.83401489); //object(pol_comp_gate) (3)
	CreateObject(1685,2419.76367188,-1872.66784668,13.29687500,0.00000000,0.00000000,0.00000000); //object(blockpallet) (2)
	CreateObject(2567,2417.18652344,-1870.41210938,14.31041336,0.00000000,0.00000000,10.00000000); //object(ab_warehouseshelf) (2)
	CreateObject(3566,2401.00805664,-1826.94201660,12.66049385,336.00000000,0.00000000,140.00000000); //object(lasntrk1) (1)
	CreateObject(3577,2425.47778320,-1889.19921875,24.25189018,0.00000000,0.00000000,20.00000000); //object(dockcrates1_la) (4)
	CreateObject(3798,2355.96020508,-1847.54895020,8.41542053,0.00000000,0.00000000,0.00000000); //object(acbox3_sfs) (3)
	CreateObject(7096,2360.47900391,-1855.10815430,5.96956062,0.00000000,0.00000000,200.00000000); //object(vrockstairs) (1)
	CreateObject(969,2415.95288086,-1753.93225098,12.45282364,306.50000000,269.99996948,260.00000000); //object(electricgate) (1)
	CreateObject(970,2455.82763672,-1742.66125488,18.90766144,0.00000000,0.00000000,0.00000000); //object(fencesmallb) (1)
	CreateObject(1228,2415.61035156,-1760.28295898,12.80394077,0.00000000,0.00000000,79.99755859); //object(roadworkbarrier1) (2)
	CreateObject(1422,2413.08886719,-1760.20227051,12.80113888,0.00000000,0.00000000,10.00000000); //object(dyn_roadbarrier_5) (1)
	CreateObject(1422,2410.51416016,-1760.83764648,12.80113888,0.00000000,0.00000000,348.24755859); //object(dyn_roadbarrier_5) (2)
	CreateObject(4100,2458.18115234,-1750.72412109,20.05784988,0.00000000,0.00000000,50.00000000); //object(meshfence1_lan) (1)
	CreateObject(1766,2408.71264648,-1932.48486328,12.38281250,0.00000000,0.00000000,10.00000000); //object(med_couch_1) (1)
	CreateObject(12957,2633.25219727,-1629.68701172,10.42719936,0.00000000,0.00000000,296.00000000); //object(sw_pickupwreck01) (5)
	CreateObject(12954,2643.93774414,-1628.09069824,10.18712711,0.00000000,356.00000000,84.00000000); //object(sw_furnipile01) (1)
	CreateObject(1236,2641.80224609,-1629.37231445,10.39029598,0.00000000,0.00000000,10.00000000); //object(rcyclbank01) (1)
	CreateObject(1227,2649.76049805,-1629.71386719,10.65545177,0.00000000,0.00000000,10.00000000); //object(dump1) (4)
	CreateObject(1334,2630.39038086,-1633.32226562,10.98536777,0.00000000,6.00000000,0.00000000); //object(binnt04_la) (1)
	CreateObject(3461,2631.41186523,-1630.95019531,9.04596806,0.00000000,0.00000000,0.00000000); //object(tikitorch01_lvs) (13)
	CreateObject(3461,2651.38842773,-1628.40258789,9.89595509,0.00000000,0.00000000,0.00000000); //object(tikitorch01_lvs) (14)
	CreateObject(7073,2629.38110352,-1640.60571289,21.89486504,343.29147339,313.23513794,309.91082764); //object(vegascowboy1) (1)
	CreateObject(2985,2636.28906250,-1629.44958496,9.88389492,0.00000000,0.00000000,280.00000000); //object(minigun_base) (4)
	CreateObject(3787,2578.85156250,-1727.07519531,12.82404804,0.00000000,0.00000000,59.99633789); //object(missile_02_sfxr) (1)
	CreateObject(14603,2431.65039062,-1759.11560059,14.74024963,0.00000000,0.00000000,270.00000000); //object(bikeschl_main) (2)
	CreateObject(2415,2348.53857422,-1965.92163086,14.56396675,0.00000000,0.00000000,0.00000000); //object(cj_ff_fryer) (17)
	CreateObject(2415,2357.13012695,-1954.47729492,19.31396675,0.00000000,0.00000000,10.00000000); //object(cj_ff_fryer) (19)
	CreateObject(2415,2364.23828125,-1953.06408691,19.31396675,0.00000000,0.00000000,9.99755859); //object(cj_ff_fryer) (20)
	CreateObject(2415,2360.52612305,-1945.89941406,19.31396675,0.00000000,0.00000000,9.99755859); //object(cj_ff_fryer) (21)
	CreateObject(2415,2354.45703125,-1940.98779297,19.31396675,0.00000000,0.00000000,9.99755859); //object(cj_ff_fryer) (22)
	CreateObject(2415,2358.23535156,-1938.19738770,19.31396675,0.00000000,0.00000000,9.99755859); //object(cj_ff_fryer) (23)
	CreateObject(2514,2450.76196289,-1998.37475586,12.52187538,0.00000000,0.00000000,0.00000000); //object(cj_toilet1) (1)
	CreateObject(1348,2231.91406250,-1151.28991699,1029.49938965,0.00000000,0.00000000,94.00000000); //object(cj_o2tanks) (1)
	CreateObject(3576,2236.20312500,-1157.76635742,1030.28955078,0.00000000,0.00000000,0.00000000); //object(dockcrates2_la) (5)
	CreateObject(3632,2240.09936523,-1152.55725098,1029.27917480,0.00000000,0.00000000,0.00000000); //object(imoildrum_las) (1)
	CreateObject(3632,2240.76269531,-1152.33691406,1029.27917480,0.00000000,0.00000000,30.25000000); //object(imoildrum_las) (2)
	CreateObject(3632,2240.76269531,-1152.33691406,1030.22839355,0.00000000,0.00000000,20.24536133); //object(imoildrum_las) (3)
	CreateObject(3633,2242.41503906,-1180.21740723,1033.26440430,0.00000000,0.00000000,10.00000000); //object(imoildrum4_las) (10)
	CreateObject(3633,2242.41503906,-1180.21679688,1034.21533203,0.00000000,0.00000000,9.99755859); //object(imoildrum4_las) (11)
	CreateObject(3633,2242.47680664,-1181.54418945,1033.26440430,0.00000000,0.00000000,359.99755859); //object(imoildrum4_las) (12)
	CreateObject(3633,2242.47656250,-1181.54394531,1034.19030762,0.00000000,0.00000000,359.99450684); //object(imoildrum4_las) (13)
	CreateObject(3633,2242.47656250,-1181.54394531,1035.11621094,0.00000000,0.00000000,359.99450684); //object(imoildrum4_las) (14)
	CreateObject(3633,2241.94628906,-1182.95092773,1033.26440430,0.00000000,0.00000000,9.99450684); //object(imoildrum4_las) (15)
	CreateObject(3633,2241.94628906,-1182.95019531,1034.21533203,0.00000000,0.00000000,9.99206543); //object(imoildrum4_las) (16)
	CreateObject(3633,2241.94628906,-1182.95019531,1035.14123535,0.00000000,0.00000000,9.99206543); //object(imoildrum4_las) (17)
	CreateObject(3633,2242.41503906,-1180.21679688,1035.14123535,0.00000000,0.00000000,9.99755859); //object(imoildrum4_las) (18)
	CreateObject(3633,2241.21264648,-1185.16748047,1033.26440430,0.00000000,0.00000000,9.99206543); //object(imoildrum4_las) (19)
	CreateObject(3633,2241.21191406,-1185.16699219,1034.18957520,0.00000000,0.00000000,9.99206543); //object(imoildrum4_las) (20)
	CreateObject(3796,2186.44311523,-1187.06921387,1032.79687500,0.00000000,0.00000000,270.00000000); //object(acbox1_sfs) (1)
	CreateObject(3798,2199.48681641,-1189.42529297,1028.79687500,0.00000000,0.00000000,10.00000000); //object(acbox3_sfs) (4)
	CreateObject(3799,2191.45703125,-1181.39746094,1028.79687500,0.00000000,0.00000000,9.99755859); //object(acbox2_sfs) (1)
	CreateObject(3800,2193.77148438,-1147.36791992,1032.79687500,0.00000000,0.00000000,0.00000000); //object(acbox4_sfs) (3)
	CreateObject(942,1954.91296387,-1949.11962891,15.01369095,0.00000000,0.00000000,330.00000000); //object(cj_df_unit_2) (2)
	CreateObject(942,1949.25036621,-1947.96447754,15.01369095,0.00000000,0.00000000,189.99633789); //object(cj_df_unit_2) (3)
	CreateObject(939,1977.27734375,-1925.08398438,14.69950104,0.00000000,0.00000000,99.99755859); //object(cj_df_unit) (5)
	CreateObject(3567,1933.13439941,-1933.76623535,13.26155853,0.00000000,0.00000000,0.00000000); //object(lasnfltrail) (2)
	CreateObject(1337,2272.66650391,-1724.58935547,13.19610023,0.00000000,0.00000000,22.00000000); //object(binnt07_la) (2)
	CreateObject(12957,2179.71826172,-1785.87292480,12.98682880,0.00000000,0.00000000,70.00000000); //object(sw_pickupwreck01) (6)
	CreateObject(1227,2183.79736328,-1786.56042480,13.19145203,0.00000000,0.00000000,180.00000000); //object(dump1) (5)
	CreateObject(2672,2184.19702148,-1787.94592285,12.64431953,0.00000000,0.00000000,0.00000000); //object(proc_rubbish_4) (1)
	CreateObject(2890,2164.89990234,-1809.96179199,12.47443008,354.00000000,0.00000000,10.00000000); //object(kmb_skip) (1)
	CreateObject(1358,2164.53027344,-1788.49316406,13.72242546,0.00000000,0.00000000,79.99694824); //object(cj_skip_rubbish) (3)
	CreateObject(1271,2165.39648438,-1806.33984375,12.72189617,0.00000000,0.00000000,0.00000000); //object(gunbox) (3)
	CreateObject(1348,2165.17041016,-1791.84570312,13.06864357,0.00000000,0.00000000,280.00000000); //object(cj_o2tanks) (2)
	CreateObject(1685,2165.25585938,-1793.79626465,13.11170578,0.00000000,0.00000000,0.00000000); //object(blockpallet) (3)
	CreateObject(2567,2182.67285156,-1807.94213867,14.30109406,0.00000000,0.00000000,340.00000000); //object(ab_warehouseshelf) (3)
	CreateObject(2567,2177.05297852,-1807.01989746,14.30109406,0.00000000,0.00000000,359.99938965); //object(ab_warehouseshelf) (4)
	CreateObject(3569,2181.53125000,-1740.03125000,14.71050072,0.49987793,0.00000000,29.99816895); //object(lasntrk3) (2)
	CreateObject(3576,2190.65136719,-1789.44213867,13.86387157,0.00000000,0.00000000,0.00000000); //object(dockcrates2_la) (6)
	CreateObject(3577,2151.09863281,-1815.24609375,15.92313194,0.00000000,0.00000000,0.00000000); //object(dockcrates1_la) (5)
	CreateObject(3577,2151.10375977,-1812.09118652,15.92313194,0.00000000,0.00000000,270.00000000); //object(dockcrates1_la) (6)
	CreateObject(3633,2151.36645508,-1802.28063965,15.62576485,0.00000000,0.00000000,10.00000000); //object(imoildrum4_las) (21)
	CreateObject(3633,2151.44848633,-1803.59912109,15.62576485,0.00000000,0.00000000,359.99755859); //object(imoildrum4_las) (22)
	CreateObject(3633,2151.44824219,-1803.59863281,16.55075073,0.00000000,0.00000000,359.99450684); //object(imoildrum4_las) (23)
	CreateObject(3798,2155.11767578,-1814.72583008,15.14062500,0.00000000,0.00000000,0.00000000); //object(acbox3_sfs) (5)
	CreateObject(8886,2146.58691406,-1820.30395508,21.29496765,0.00000000,0.00000000,320.00000000); //object(vgsefrght04) (1)
	CreateObject(3630,2651.34472656,-2505.94335938,13.98480988,0.00000000,0.00000000,249.99938965); //object(crdboxes2_las) (5)
	CreateObject(3633,2651.78247070,-2498.11914062,13.13890266,0.00000000,0.00000000,10.00000000); //object(imoildrum4_las) (24)
	CreateObject(3633,2649.94458008,-2498.22973633,13.13890266,0.00000000,0.00000000,29.99755859); //object(imoildrum4_las) (25)
	CreateObject(3633,2649.94433594,-2498.22949219,14.06388855,0.00000000,0.00000000,29.99267578); //object(imoildrum4_las) (26)
	CreateObject(2415,2650.98999023,-2508.57836914,11.48493862,0.00000000,0.00000000,0.00000000); //object(cj_ff_fryer) (25)
	CreateObject(2415,2649.84057617,-2498.61083984,10.98493862,0.00000000,0.00000000,0.00000000); //object(cj_ff_fryer) (26)
	CreateObject(18257,2669.74414062,-2512.75854492,12.62393379,0.00000000,0.00000000,0.00000000); //object(crates) (2)
	CreateObject(1327,2579.31274414,-1746.51733398,7.88531542,0.00000000,0.00000000,250.00000000); //object(junk_tyre) (4)
	CreateObject(12957,2423.21020508,-2097.41674805,13.12509632,0.00000000,0.00000000,340.00000000); //object(sw_pickupwreck01) (7)
	CreateObject(1236,2448.06762695,-2099.06738281,13.20960140,0.00000000,0.00000000,250.00000000); //object(rcyclbank01) (2)
	CreateObject(952,2223.01855469,-1766.69970703,13.90400600,0.00000000,0.00000000,20.00000000); //object(generator_big_d) (1)
	CreateObject(3866,2463.96704102,-1848.80297852,8.16274643,0.00000000,0.00000000,40.00000000); //object(demolish1_sfxrf) (2)
	CreateObject(1388,2510.27392578,-1792.24951172,12.07382107,9.25000000,0.00000000,62.49816895); //object(twrcrane_s_04) (1)
	CreateObject(3363,2497.67236328,-1802.49707031,13.24304295,352.75000000,0.00000000,0.00000000); //object(des_ruin1_) (1)
	CreateObject(18101,2268.94482422,-1749.91931152,12.38281250,0.00000000,0.00000000,239.99511719); //object(cj_rubbish02) (9)
	CreateObject(1442,2267.85913086,-1738.70263672,13.14535809,0.00000000,0.00000000,0.00000000); //object(dyn_firebin0) (1)
	CreateObject(1439,2263.24365234,-1743.19787598,12.54687500,0.00000000,0.00000000,0.00000000); //object(dyn_dumpster_1) (1)
	CreateObject(1332,2277.05053711,-1720.22131348,17.66425514,0.00000000,0.00000000,340.00000000); //object(binnt02_la) (1)
	CreateObject(5822,2229.45361328,-1719.18725586,16.53236198,0.00000000,0.00000000,93.00000000); //object(lhroofst14) (1)
	CreateObject(1379,2264.46777344,-1718.55969238,16.60923576,6.00000000,0.00000000,20.00000000); //object(magnocrane_02) (1)
	CreateObject(8877,2231.85278320,-1719.88146973,27.94698524,0.00000000,0.00000000,0.00000000); //object(vgsecnstrct10) (2)
	CreateObject(1327,2250.67553711,-1721.31652832,22.82067871,0.00000000,0.00000000,0.00000000); //object(junk_tyre) (5)
	CreateObject(2837,2245.17993164,-1892.86108398,12.35870075,0.00000000,0.00000000,0.00000000); //object(gb_takeaway02) (1)
	CreateObject(850,2190.87280273,-1897.65930176,12.73859501,0.00000000,0.00000000,0.00000000); //object(cj_urb_rub_1) (2)
	CreateObject(850,2185.83178711,-1887.54638672,12.73859501,0.00000000,0.00000000,60.00000000); //object(cj_urb_rub_1) (3)
	CreateObject(1358,2183.39770508,-1902.05200195,13.74261856,0.00000000,0.00000000,60.00000000); //object(cj_skip_rubbish) (4)
	CreateObject(1345,2189.58032227,-1903.59643555,13.31701088,0.00000000,0.00000000,0.00000000); //object(cj_dumpster) (1)
	CreateObject(2912,2136.92651367,-2278.44653320,19.67187500,0.00000000,0.00000000,0.00000000); //object(temp_crate1) (1)
	CreateObject(930,2137.96655273,-2279.38720703,20.15705490,0.00000000,0.00000000,320.00000000); //object(o2_bottles) (2)
	CreateObject(1348,2139.01733398,-2280.69702148,20.37440109,0.00000000,0.00000000,0.00000000); //object(cj_o2tanks) (3)
	CreateObject(1685,2144.27954102,-2278.17724609,14.52829647,0.00000000,0.00000000,0.00000000); //object(blockpallet) (4)
	CreateObject(1685,2145.58203125,-2276.50488281,14.52829647,0.00000000,0.00000000,320.00000000); //object(blockpallet) (5)
	CreateObject(1685,2144.92089844,-2277.38232422,16.00330162,0.00000000,0.00000000,329.99877930); //object(blockpallet) (6)
	CreateObject(2567,2154.92993164,-2267.70849609,14.10542679,0.00000000,0.00000000,330.00000000); //object(ab_warehouseshelf) (5)
	CreateObject(3576,2131.61425781,-2261.41601562,15.27084351,0.00000000,0.00000000,20.00000000); //object(dockcrates2_la) (7)
	CreateObject(3577,2136.55883789,-2257.28735352,12.97994423,0.00000000,0.00000000,50.00000000); //object(dockcrates1_la) (7)
	CreateObject(3577,2136.55859375,-2257.28710938,14.40492630,0.00000000,0.00000000,49.99877930); //object(dockcrates1_la) (8)
	CreateObject(3577,2138.94946289,-2259.98510742,12.97994423,0.00000000,0.00000000,39.99877930); //object(dockcrates1_la) (9)
	CreateObject(3633,2143.56787109,-2247.04711914,20.13886452,0.00000000,0.00000000,40.00000000); //object(imoildrum4_las) (27)
	CreateObject(3633,2143.56738281,-2247.04687500,21.08886147,0.00000000,0.00000000,39.99572754); //object(imoildrum4_las) (28)
	CreateObject(3633,2144.65649414,-2247.91577148,20.13886452,0.00000000,0.00000000,49.99572754); //object(imoildrum4_las) (29)
	CreateObject(3633,2145.65356445,-2248.92773438,20.13886452,0.00000000,0.00000000,39.99328613); //object(imoildrum4_las) (30)
	CreateObject(3633,2145.65332031,-2248.92773438,21.06385040,0.00000000,0.00000000,39.99023438); //object(imoildrum4_las) (31)
	CreateObject(3796,2167.72656250,-2247.35644531,19.09688377,0.00000000,0.00000000,159.99938965); //object(acbox1_sfs) (2)
	CreateObject(3798,2161.50073242,-2265.23291016,19.67187500,0.00000000,0.00000000,0.00000000); //object(acbox3_sfs) (6)
	CreateObject(2677,2187.06811523,-2254.59130859,12.70613384,0.00000000,0.00000000,20.00000000); //object(proc_rubbish_7) (2)
	CreateObject(2677,2188.74267578,-2238.01196289,12.70404625,0.00000000,0.00000000,0.00000000); //object(proc_rubbish_7) (3)
	CreateObject(3564,2276.47998047,-2247.33129883,14.37988853,0.00000000,0.00000000,0.00000000); //object(lastran1_la01) (1)
	CreateObject(3567,2262.48364258,-2245.92602539,13.27562332,0.00000000,0.00000000,0.00000000); //object(lasnfltrail) (3)
	CreateObject(3564,2283.63916016,-2237.62084961,14.00210857,273.25000000,0.00000000,30.00000000); //object(lastran1_la01) (2)
	CreateObject(3585,2290.52319336,-2231.70068359,14.17676353,0.00000000,0.00000000,54.75000000); //object(lastran1_la02) (2)
	CreateObject(1225,2306.20214844,-2216.89331055,12.95263004,0.00000000,0.00000000,0.00000000); //object(barrel4) (1)
	CreateObject(1225,2304.82446289,-2214.51318359,12.95263004,0.00000000,0.00000000,340.00000000); //object(barrel4) (2)
	CreateObject(1225,2306.96459961,-2214.71752930,12.95263004,0.00000000,0.00000000,339.99938965); //object(barrel4) (3)
	CreateObject(1225,2305.66601562,-2215.46826172,12.95263004,0.00000000,0.00000000,359.99938965); //object(barrel4) (4)
	CreateObject(1225,2304.40356445,-2212.33056641,12.95263004,0.00000000,0.00000000,305.99328613); //object(barrel4) (7)
	CreateObject(1225,2302.61230469,-2212.12548828,12.95263004,0.00000000,0.00000000,275.99121094); //object(barrel4) (8)
	CreateObject(1225,2303.75781250,-2213.09326172,12.95263004,0.00000000,0.00000000,275.98754883); //object(barrel4) (9)
	CreateObject(1225,2305.51928711,-2212.94506836,12.95263004,0.00000000,0.00000000,245.98754883); //object(barrel4) (10)
	CreateObject(1225,2289.73193359,-2232.62573242,13.77764034,0.00000000,0.00000000,245.98388672); //object(barrel4) (17)
	CreateObject(1225,2290.01220703,-2231.52001953,13.77764034,0.00000000,0.00000000,245.98388672); //object(barrel4) (18)
	CreateObject(1225,2291.06835938,-2230.81103516,13.77764034,0.00000000,0.00000000,245.98388672); //object(barrel4) (19)
	CreateObject(1225,2290.99267578,-2231.94384766,13.77764034,0.00000000,0.00000000,245.98388672); //object(barrel4) (20)
	CreateObject(1225,2279.13598633,-2244.52661133,13.77764034,0.00000000,0.00000000,245.98388672); //object(barrel4) (21)
	CreateObject(1225,2282.37646484,-2240.68603516,13.77764034,0.00000000,0.00000000,255.98388672); //object(barrel4) (22)
	CreateObject(1225,2281.43896484,-2246.30908203,13.77764034,0.00000000,0.00000000,255.98144531); //object(barrel4) (23)
	CreateObject(1327,2032.82409668,-1601.80517578,13.42921162,0.00000000,0.00000000,0.00000000); //object(junk_tyre) (6)
	CreateObject(18099,2048.22412109,-1670.83117676,12.38281441,0.00000000,0.00000000,29.98229980); //object(cj_rubbish) (58)
	CreateObject(1442,2051.61938477,-1603.32263184,13.14535809,0.00000000,0.00000000,0.00000000); //object(dyn_firebin0) (2)
	CreateObject(1442,2050.96435547,-1602.87878418,13.14535809,0.00000000,0.00000000,20.00000000); //object(dyn_firebin0) (3)
	CreateObject(1442,2051.78125000,-1602.63085938,13.14535809,0.00000000,0.00000000,39.99511719); //object(dyn_firebin0) (4)
	CreateObject(1442,2051.45336914,-1604.17309570,13.14535809,0.00000000,0.00000000,39.99023438); //object(dyn_firebin0) (5)
	CreateObject(1442,2052.26733398,-1604.61853027,13.14535809,0.00000000,0.00000000,69.99023438); //object(dyn_firebin0) (6)
	CreateObject(1440,2045.99401855,-1601.18688965,12.87086391,0.00000000,0.00000000,10.00000000); //object(dyn_box_pile_3) (1)
	CreateObject(1440,2044.50000000,-1602.36718750,12.87086391,0.00000000,0.00000000,339.99755859); //object(dyn_box_pile_3) (2)
	CreateObject(1439,2043.27978516,-1600.27453613,12.32301140,0.00000000,0.00000000,0.00000000); //object(dyn_dumpster_1) (2)
	CreateObject(1438,2036.29296875,-1601.28564453,12.34686565,0.00000000,0.00000000,20.00000000); //object(dyn_box_pile_2) (1)
	CreateObject(1438,2037.60534668,-1602.42370605,12.34686565,0.00000000,0.00000000,309.99511719); //object(dyn_box_pile_2) (2)
	CreateObject(1415,2028.75366211,-1606.34399414,12.54687500,0.00000000,0.00000000,0.00000000); //object(dyn_dumpster) (1)
	CreateObject(1415,2026.05529785,-1605.81066895,12.54687500,0.00000000,0.00000000,350.00000000); //object(dyn_dumpster) (2)
	CreateObject(1370,2030.57226562,-1606.30358887,13.09048080,0.00000000,0.00000000,0.00000000); //object(cj_flame_drum) (2)
	CreateObject(1369,2053.74462891,-1609.06665039,12.99507427,0.00000000,0.00000000,340.00000000); //object(cj_wheelchair1) (1)
	CreateObject(1365,2054.73193359,-1618.11840820,13.68978691,0.00000000,0.00000000,0.00000000); //object(cj_big_skip1) (3)
	CreateObject(1365,2054.45068359,-1621.12597656,15.81481552,358.25375366,3.75173950,90.11450195); //object(cj_big_skip1) (4)
	CreateObject(1358,2052.06909180,-1620.86926270,13.75042152,0.00000000,0.00000000,0.00000000); //object(cj_skip_rubbish) (5)
	CreateObject(1358,2058.87963867,-1605.17077637,13.67542267,0.00000000,0.00000000,340.00000000); //object(cj_skip_rubbish) (6)
	CreateObject(12957,2037.60754395,-1664.03540039,13.25009441,0.00000000,0.00000000,320.00000000); //object(sw_pickupwreck01) (8)
	CreateObject(1264,2038.33923340,-1663.30261230,13.59409142,0.00000000,0.00000000,0.00000000); //object(blackbag1) (1)
	CreateObject(1264,2038.21313477,-1664.41259766,13.59409142,0.00000000,0.00000000,20.00000000); //object(blackbag1) (2)
	CreateObject(1236,2044.17565918,-1672.12207031,12.97054005,0.00000000,0.00000000,320.00000000); //object(rcyclbank01) (3)
	CreateObject(1219,2043.90771484,-1669.24902344,12.74573517,0.00000000,0.00000000,0.00000000); //object(palette) (1)
	CreateObject(1219,2046.77746582,-1669.46655273,12.74573517,0.00000000,0.00000000,20.00000000); //object(palette) (2)
	CreateObject(1558,2043.46423340,-1668.84008789,13.57767200,0.00000000,0.00000000,0.00000000); //object(cj_cardbrd_pickup) (1)
	CreateObject(2671,2041.18884277,-1671.10998535,12.38281250,0.00000000,0.00000000,0.00000000); //object(proc_rubbish_3) (1)
	CreateObject(2671,2041.18847656,-1671.10937500,12.38281250,0.00000000,0.00000000,40.00000000); //object(proc_rubbish_3) (2)
	CreateObject(3594,2105.94555664,-1715.99121094,13.02041149,0.00000000,0.00000000,20.00000000); //object(la_fuckcar1) (2)
	CreateObject(3594,2103.63891602,-1723.94470215,13.02041149,0.00000000,0.00000000,349.99511719); //object(la_fuckcar1) (3)
	CreateObject(3594,2108.11181641,-1758.09423828,13.02041149,0.00000000,0.00000000,359.99145508); //object(la_fuckcar1) (4)
	CreateObject(3594,2103.53125000,-1757.29602051,13.02041149,0.00000000,0.00000000,309.98901367); //object(la_fuckcar1) (5)
	CreateObject(18253,2095.38305664,-1702.30639648,14.99549866,0.00000000,0.00000000,0.00000000); //object(cuntwjunk09) (1)
	CreateObject(850,2081.17236328,-1706.26684570,12.39060783,0.00000000,0.00000000,0.00000000); //object(cj_urb_rub_1) (4)
	CreateObject(850,2081.17187500,-1706.26660156,12.39060783,0.00000000,0.00000000,62.00000000); //object(cj_urb_rub_1) (5)
	CreateObject(850,2082.24340820,-1712.89990234,12.39060783,0.00000000,0.00000000,61.99584961); //object(cj_urb_rub_1) (6)
	CreateObject(849,2088.52880859,-1707.95397949,12.83883572,0.00000000,0.00000000,30.00000000); //object(cj_urb_rub_3) (1)
	CreateObject(3302,2010.10717773,-1704.75146484,12.63843536,0.00000000,0.00000000,0.00000000); //object(cxrf_corpanel) (1)
	CreateObject(3302,2031.99890137,-1654.95666504,12.63843536,0.00000000,0.00000000,20.00000000); //object(cxrf_corpanel) (2)
	CreateObject(3119,2034.29663086,-1653.03771973,12.80854225,0.00000000,0.00000000,0.00000000); //object(cs_ry_props) (1)
	CreateObject(3035,2025.92932129,-1647.59387207,13.12482262,0.00000000,0.00000000,270.00000000); //object(tmp_bin) (1)
	CreateObject(3035,2026.42443848,-1650.00830078,13.12482262,0.00000000,0.00000000,290.00000000); //object(tmp_bin) (2)
	CreateObject(2971,2012.54394531,-1649.74401855,12.54687500,0.00000000,0.00000000,10.00000000); //object(k_smashboxes) (1)
	CreateObject(2971,2011.98425293,-1645.32653809,12.54687500,0.00000000,0.00000000,349.99755859); //object(k_smashboxes) (2)
	CreateObject(2968,2138.17675781,-1494.79345703,23.28090477,0.00000000,0.00000000,10.00000000); //object(cm_box) (1)
	CreateObject(850,2170.96215820,-1487.98291016,23.09586716,0.00000000,0.00000000,290.00000000); //object(cj_urb_rub_1) (7)
	CreateObject(850,2170.44970703,-1489.46679688,23.09586716,0.00000000,0.00000000,349.99511719); //object(cj_urb_rub_1) (8)
	CreateObject(1271,2173.38696289,-1494.53332520,23.33437538,0.00000000,0.00000000,0.00000000); //object(gunbox) (4)
	CreateObject(1685,2169.18066406,-1494.00988770,23.73437500,0.00000000,0.00000000,10.00000000); //object(blockpallet) (7)
	CreateObject(1685,2171.34448242,-1494.15930176,23.73437500,0.00000000,0.00000000,339.99755859); //object(blockpallet) (8)
	CreateObject(1685,2170.36840820,-1493.97290039,25.18437576,0.00000000,0.00000000,359.99389648); //object(blockpallet) (9)
	CreateObject(1685,2170.36816406,-1493.97265625,26.60936546,0.00000000,0.00000000,359.98901367); //object(blockpallet) (10)
	CreateObject(1685,2167.10839844,-1493.95458984,26.53436661,0.00000000,0.00000000,31.98901367); //object(blockpallet) (11)
	CreateObject(1685,2165.02124023,-1494.09899902,26.53436661,0.00000000,0.00000000,1.98669434); //object(blockpallet) (12)
	CreateObject(1685,2162.85498047,-1496.30029297,23.73437500,0.00000000,0.00000000,29.99755859); //object(blockpallet) (13)
	CreateObject(2567,2168.26831055,-1504.39038086,24.86540222,0.00000000,0.00000000,348.00000000); //object(ab_warehouseshelf) (6)
	CreateObject(2567,2181.71533203,-1502.11889648,24.86540222,0.00000000,0.00000000,97.99743652); //object(ab_warehouseshelf) (7)
	CreateObject(2567,2181.71484375,-1502.11816406,28.56540680,0.00000000,0.00000000,97.99255371); //object(ab_warehouseshelf) (8)
	CreateObject(2567,2160.62109375,-1501.11230469,24.86540222,0.00000000,0.00000000,277.99743652); //object(ab_warehouseshelf) (9)
	CreateObject(3576,2151.41210938,-1504.40063477,24.40723610,0.00000000,0.00000000,154.00000000); //object(dockcrates2_la) (8)
	CreateObject(3577,2220.09277344,-1494.35839844,23.78250694,0.00000000,0.00000000,90.00000000); //object(dockcrates1_la) (10)
	CreateObject(3577,2204.79858398,-1494.91979980,23.76688194,0.00000000,0.00000000,20.00000000); //object(dockcrates1_la) (11)
	CreateObject(3630,2220.00122070,-1485.19531250,24.32074738,0.00000000,0.00000000,70.00000000); //object(crdboxes2_las) (6)
	CreateObject(3630,2212.98583984,-1475.09045410,24.32074738,0.00000000,0.00000000,161.99938965); //object(crdboxes2_las) (7)
	CreateObject(3633,2216.44213867,-1476.96911621,26.29567909,0.00000000,0.00000000,0.00000000); //object(imoildrum4_las) (32)
	CreateObject(3761,2204.13916016,-1488.14978027,24.98335648,0.00000000,0.00000000,0.00000000); //object(industshelves) (1)
	CreateObject(3796,2198.03076172,-1504.14526367,22.96587181,0.00000000,0.00000000,20.00000000); //object(acbox1_sfs) (3)
	CreateObject(8884,2240.59008789,-1494.21606445,26.01544762,0.00000000,0.00000000,0.00000000); //object(vgsefrght02) (1)
	CreateObject(8885,2113.13867188,-1496.05322266,26.23665237,0.00000000,0.00000000,340.00000000); //object(vgsefrght03) (1)
	CreateObject(18100,2175.28833008,-1752.14685059,12.42218208,0.00000000,0.00000000,348.00000000); //object(cj_rubbish01) (5)
	CreateObject(18100,2175.28808594,-1752.14648438,12.42218208,0.00000000,0.00000000,39.99743652); //object(cj_rubbish01) (6)
	CreateObject(18100,2167.15673828,-1754.07238770,12.42218208,0.00000000,0.00000000,39.99572754); //object(cj_rubbish01) (7)
	CreateObject(18100,2162.31103516,-1752.02905273,12.42218208,0.00000000,0.00000000,39.99572754); //object(cj_rubbish01) (8)
	CreateObject(3630,1994.08471680,-2045.19299316,14.03564167,0.00000000,0.00000000,10.00000000); //object(crdboxes2_las) (8)
	CreateObject(3633,1999.76782227,-2046.21765137,13.02167702,0.00000000,0.00000000,349.00000000); //object(imoildrum4_las) (33)
	CreateObject(3633,1999.76757812,-2046.21679688,13.94666290,0.00000000,0.00000000,348.99719238); //object(imoildrum4_las) (34)
	CreateObject(3796,2004.88354492,-2015.47119141,12.49687576,0.00000000,0.00000000,30.00000000); //object(acbox1_sfs) (4)
	CreateObject(3798,2012.53979492,-2017.37622070,12.54687500,0.00000000,0.00000000,0.00000000); //object(acbox3_sfs) (7)
	CreateObject(3798,2012.53906250,-2017.37597656,14.52185249,0.00000000,0.00000000,0.00000000); //object(acbox3_sfs) (8)
	CreateObject(3798,2007.45507812,-2017.69775391,12.54687500,0.00000000,0.00000000,320.00000000); //object(acbox3_sfs) (9)
	CreateObject(3798,2012.05236816,-2019.98364258,12.54687500,0.00000000,0.00000000,340.00000000); //object(acbox3_sfs) (10)
	CreateObject(3798,2011.78369141,-2022.64233398,12.54687500,0.00000000,0.00000000,9.99938965); //object(acbox3_sfs) (11)
	CreateObject(3799,2006.13354492,-2020.93615723,12.54687500,0.00000000,0.00000000,0.00000000); //object(acbox2_sfs) (2)
	CreateObject(3799,2006.13281250,-2020.93554688,14.74686050,0.00000000,0.00000000,0.00000000); //object(acbox2_sfs) (3)
	CreateObject(5262,2008.84399414,-2044.54382324,15.50453568,0.00000000,0.00000000,270.00000000); //object(las2dkwar04) (3)
	CreateObject(7527,1859.68261719,-2412.75854492,18.54691124,0.00000000,0.00000000,0.00000000); //object(vegasnfrates03) (1)
	CreateObject(18260,1983.52355957,-2068.22290039,13.95509338,0.00000000,0.00000000,0.00000000); //object(crates01) (4)
	CreateObject(2567,1997.82470703,-2014.14843750,14.29947853,0.00000000,0.00000000,0.00000000); //object(ab_warehouseshelf) (10)
	CreateObject(2567,1997.82421875,-2014.14843750,17.89946556,0.00000000,0.00000000,0.00000000); //object(ab_warehouseshelf) (11)
	CreateObject(2567,2000.28503418,-2018.25439453,14.29947853,0.00000000,0.00000000,290.00000000); //object(ab_warehouseshelf) (12)
	CreateObject(2669,1997.44421387,-2060.93627930,13.88714790,0.00000000,0.00000000,0.00000000); //object(cj_chris_crate) (3)
	CreateObject(3569,1998.16027832,-2089.29516602,15.16049385,0.00000000,0.00000000,0.00000000); //object(lasntrk3) (3)
	CreateObject(3568,2012.42675781,-2089.50097656,15.03549576,0.00000000,0.00000000,20.00000000); //object(lasntrk2) (1)
	CreateObject(3569,1943.88427734,-2104.30322266,15.08247948,0.00000000,0.00000000,70.00000000); //object(lasntrk3) (4)
	CreateObject(3576,1996.58032227,-2041.25720215,14.03954792,0.00000000,0.00000000,0.00000000); //object(dockcrates2_la) (9)
	CreateObject(3577,1996.47607422,-2037.76147461,13.32671928,0.00000000,0.00000000,20.00000000); //object(dockcrates1_la) (12)
	CreateObject(3577,1990.88305664,-2030.10131836,13.32671928,0.00000000,0.00000000,359.99511719); //object(dockcrates1_la) (13)
	CreateObject(3576,1991.31347656,-2033.84912109,14.03954792,0.00000000,0.00000000,178.25000000); //object(dockcrates2_la) (11)
	CreateObject(3577,2031.23681641,-2062.78369141,13.32938194,0.00000000,0.00000000,0.00000000); //object(dockcrates1_la) (14)
	CreateObject(3577,2027.02050781,-2062.10620117,13.32938194,0.00000000,0.00000000,40.00000000); //object(dockcrates1_la) (16)
	CreateObject(3576,2016.34155273,-2053.31884766,14.03954792,0.00000000,0.00000000,0.00000000); //object(dockcrates2_la) (12)
	CreateObject(3576,2015.01513672,-2057.38940430,14.03954792,0.00000000,0.00000000,50.00000000); //object(dockcrates2_la) (13)
	CreateObject(3577,2031.65295410,-2053.41699219,13.32938194,0.00000000,0.00000000,350.00000000); //object(dockcrates1_la) (17)
	CreateObject(3585,1968.80651855,-1948.12316895,14.00176620,1.24694824,359.24743652,50.00915527); //object(lastran1_la02) (1)
	CreateObject(1327,2005.51403809,-2047.65087891,17.04308891,0.00000000,0.00000000,0.00000000); //object(junk_tyre) (7)
	CreateObject(12957,1954.45654297,-2054.90502930,13.11103153,0.00000000,0.00000000,50.00000000); //object(sw_pickupwreck01) (9)
	CreateObject(12954,2007.95227051,-2054.75488281,-57.36803818,0.00000000,0.00000000,0.00000000); //object(sw_furnipile01) (2)
	CreateObject(1332,2012.52832031,-1983.97851562,13.60956764,0.00000000,0.00000000,350.00000000); //object(binnt02_la) (2)
	CreateObject(3594,2630.85937500,-1482.98522949,16.01223755,0.00000000,0.00000000,0.00000000); //object(la_fuckcar1) (6)
	CreateObject(3594,2612.39648438,-1491.75927734,16.01223755,0.00000000,0.00000000,340.00000000); //object(la_fuckcar1) (7)
	CreateObject(1687,2173.95019531,-1777.39172363,18.35623932,0.00000000,0.00000000,0.00000000); //object(gen_roofbit1) (1)
	CreateObject(1687,2170.32910156,-1773.40673828,18.35623932,0.00000000,0.00000000,270.00000000); //object(gen_roofbit1) (2)
	CreateObject(1690,2137.55468750,-1803.31054688,18.42640305,0.00000000,0.00000000,0.00000000); //object(gen_roofbit4) (1)
	CreateObject(3502,2128.84252930,-1738.52929688,14.49063301,0.00000000,0.00000000,0.00000000); //object(vgsn_con_tube) (5)
	CreateObject(3643,2113.62988281,-1740.23242188,22.70009613,0.00000000,0.00000000,270.00000000); //object(la_chem_piping) (2)
	CreateObject(3805,2154.86376953,-1761.93859863,13.93322372,0.00000000,0.00000000,90.00000000); //object(sfxref_aircon12) (1)
	CreateObject(3865,2120.50659180,-1770.51184082,13.96908760,0.00000000,0.00000000,0.00000000); //object(concpipe_sfxrf) (1)
	CreateObject(3865,2116.62133789,-1769.65441895,13.96908760,0.00000000,0.00000000,180.00000000); //object(concpipe_sfxrf) (2)
	CreateObject(3865,2118.73852539,-1770.05651855,16.86908531,0.00000000,0.00000000,359.99450684); //object(concpipe_sfxrf) (3)
	CreateObject(919,2150.44018555,-1786.73376465,18.32986259,0.00000000,0.00000000,0.00000000); //object(aircon) (1)
	CreateObject(3406,2155.57812500,-1786.90258789,13.11141205,0.00000000,0.00000000,0.00000000); //object(cxref_woodjetty) (2)
	CreateObject(10230,2450.20507812,-2317.64550781,6.62499857,0.00000000,0.00000000,19.99511719); //object(freighter_sfe) (1)
	CreateObject(10229,2450.74902344,-2318.95288086,5.49687290,0.00000000,0.00000000,20.00000000); //object(freighter2b_sfe) (1)
	CreateObject(10140,2464.40527344,-2313.60546875,6.76225758,0.00000000,0.00000000,20.00000000); //object(freig2_intsfe) (1)
	CreateObject(11495,2422.77319336,-2305.88818359,0.18672952,0.00000000,0.00000000,20.00000000); //object(des_ranchjetty) (1)
	CreateObject(10227,2492.49487305,-2302.51464844,11.64811325,0.00000000,0.00000000,20.00000000); //object(shipbits1_sfe) (1)
	CreateObject(10231,2450.00488281,-2319.31689453,7.72214413,0.00000000,0.00000000,20.00000000); //object(freightboxes) (1)
	CreateObject(1660,2860.19873047,-2130.71264648,9.25285053,0.00000000,0.00000000,0.00000000); //object(ramp) (1)
	CreateObject(1660,2794.85302734,-2367.10913086,12.15708733,0.00000000,0.00000000,0.00000000); //object(ramp) (2)
	CreateObject(1660,2680.74218750,-2529.22509766,11.92679405,0.00000000,0.00000000,0.00000000); //object(ramp) (3)
	CreateObject(1324,2660.71166992,-2496.50244141,14.14847565,0.00000000,0.00000000,0.00000000); //object(ws_roadwarning_04) (1)
	CreateObject(617,2766.53417969,-1206.77966309,65.86750793,0.00000000,0.00000000,0.00000000); //object(veg_treeb1) (1)
	CreateObject(3577,2307.09985352,-2103.14062500,13.05438614,0.00000000,0.00000000,49.99816895); //object(dockcrates1_la) (1)
	CreateObject(1299,2662.53027344,-1093.09655762,68.94267273,0.00000000,0.00000000,0.00000000); //object(smashboxpile) (1)
	CreateObject(12957,2714.80834961,-1291.62866211,54.69502640,358.12066650,339.98876953,87.31570435); //object(sw_pickupwreck01) (1)
	CreateObject(1299,2730.02246094,-1267.59875488,59.24812317,0.00000000,0.00000000,0.00000000); //object(smashboxpile) (2)
	CreateObject(1264,2730.44458008,-1335.89685059,46.86331177,0.00000000,0.00000000,20.00000000); //object(blackbag1) (3)
	CreateObject(939,2712.13916016,-1093.66406250,70.90668488,0.00000000,0.00000000,70.00000000); //object(cj_df_unit) (6)
	CreateObject(3564,2716.94360352,-1089.03710938,69.89551544,0.00000000,0.00000000,10.00000000); //object(lastran1_la01) (3)
	CreateObject(2973,2721.19189453,-1065.67004395,68.43750000,0.00000000,0.00000000,10.00000000); //object(k_cargo2) (7)
	CreateObject(2973,2721.73803711,-1062.33691406,68.43750000,0.00000000,0.00000000,339.99755859); //object(k_cargo2) (8)
	CreateObject(18257,2720.71411133,-1086.15698242,68.26548004,0.00000000,0.00000000,10.00000000); //object(crates) (3)
	CreateObject(2567,2714.83178711,-1068.83178711,70.16509247,0.00000000,0.00000000,60.00000000); //object(ab_warehouseshelf) (13)
	CreateObject(2567,2713.63330078,-1074.42895508,70.16509247,0.00000000,0.00000000,95.99633789); //object(ab_warehouseshelf) (14)
	CreateObject(2933,2750.03613281,-1079.68969727,69.49369049,281.57702637,283.56063843,283.83142090); //object(pol_comp_gate) (4)
	CreateObject(18257,2691.57861328,-1192.82324219,68.35819244,0.00000000,0.00000000,0.00000000); //object(crates) (4)
	CreateObject(8613,2768.96850586,-1269.58117676,54.11438751,0.00000000,0.00000000,270.00000000); //object(vgssstairs03_lvs) (2)

    print("[GM LOADED]");
	return 1;
}

public Stop (playerid)
{
	TogglePlayerSpectating(playerid, 0);
	SpawnPlayer(playerid);
    return 1;
}

public Message()
{
    print("[15 Minutes écoulées auto-message(s) envoyé(s)]");
    SendClientMessageToAll(GRIS, "[Faite /aide pour voir les commandes, pour plus d'AIDE sur les commandes]");
    SendClientMessageToAll(GRIS, "[Lisez les règles grâce à /regles faite aussi /rangs pour voir les rangs !]");
    SendClientMessageToAll(GRIS, "[Faite /sc pour changé de classe au prochain respawn et /kill pour vous tuez !]");

	SetTimer("Message",900000,false);
}

public Message0()
{
	/*A modifier a votre guise*/
 	SendClientMessageToAll(GRIS, "[Un Hacker ou une personne qui casse les règles ? /rapport [TEXTE]]");
    SendClientMessageToAll(GRIS, "[Allé faire des dons sur notre site pour reçevoir des WarsPoints et vous achetez des bonus dans le /equipement !]");
    SendClientMessageToAll(GRIS, "[Vous aimez ce serveur allé votez pour lui sur notre site ((http://call-of-serinity.xooit.fr/index.php)) !]");
	SetTimer("Message0",1800000,false);
}


public OnGameModeExit()
{
    print("[GAME MODE]");
    print("");
    print("[UNLOADED]");
    print("[SUCCES]");
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
    TextDrawHideForPlayer(playerid,Noir);
	Classe[playerid] = 0;
	if(classid == 0)
		{
	GameTextForPlayer(playerid, "~w~ARMY", 3000, 4);
	SetPlayerPos(playerid, 250.7688,1906.3539,20.6406);
	SetPlayerFacingAngle(playerid,90);
	SetPlayerCameraPos(playerid, 247.2086,1906.9135,20.2510);
	SetPlayerCameraLookAt(playerid, 250.7688,1906.3539,20.6406);
	SetPlayerColor(playerid, BLEUE);
	Team[playerid] = TEAM_ARMY;
		}
	else if(classid == 1)
		{
	GameTextForPlayer(playerid, "~w~RUSSE", 3000, 4);
	SetPlayerPos(playerid, 250.7688,1906.3539,20.6406);
	SetPlayerFacingAngle(playerid,90);
	SetPlayerCameraPos(playerid, 247.2086,1906.9135,20.2510);
	SetPlayerCameraLookAt(playerid, 250.7688,1906.3539,20.6406);
	SetPlayerColor(playerid, POURPRE);
	Team[playerid] = TEAM_RUSSE;
		}
	else if(classid == 2)
		{
	GameTextForPlayer(playerid, "~w~MERCENAIRE", 3000, 4);
	SetPlayerPos(playerid, 250.7688,1906.3539,20.6406);
	SetPlayerFacingAngle(playerid,90);
	SetPlayerCameraPos(playerid, 247.2086,1906.9135,20.2510);
	SetPlayerCameraLookAt(playerid, 250.7688,1906.3539,20.6406);
	SetPlayerColor(playerid, BLANCHE);
	Team[playerid] = TEAM_MERCENAIRE;
		}
    else if(classid == 3)
		{
	GameTextForPlayer(playerid, "~w~JAPON", 3000, 4);
	SetPlayerPos(playerid, 250.7688,1906.3539,20.6406);
	SetPlayerFacingAngle(playerid,90);
	SetPlayerCameraPos(playerid, 247.2086,1906.9135,20.2510);
	SetPlayerCameraLookAt(playerid, 250.7688,1906.3539,20.6406);
	SetPlayerColor(playerid, ORANGE);
	Team[playerid] = TEAM_JAPON;
		}
	return 1;

}

//____________________________________________________________//
//____________________________________________________________//
//____________________________________________________________//


public Spawn(playerid)
{
	if (Team[playerid] == TEAM_ARMY)
	{
	new AArmy = random(sizeof(Army));
	SetPlayerPos(playerid, Army[AArmy][0], Army[AArmy][1], Army[AArmy][2]);
	SetCameraBehindPlayer(playerid);
	}
	else if (Team[playerid] == TEAM_RUSSE)
	{
	new ARusse = random(sizeof(Russe));
	SetPlayerPos(playerid, Russe[ARusse][0], Russe[ARusse][1], Russe[ARusse][2]);
	SetCameraBehindPlayer(playerid);
	}
	else if (Team[playerid] == TEAM_MERCENAIRE)
	{
	new AMercenaire = random(sizeof(Mercenaire));
	SetPlayerPos(playerid, Mercenaire[AMercenaire][0], Mercenaire[AMercenaire][1], Mercenaire[AMercenaire][2]);
	SetCameraBehindPlayer(playerid);
	}
	else if (Team[playerid] == TEAM_JAPON)
	{
	new AJapon = random(sizeof(Japon));
	SetPlayerPos(playerid, Japon[AJapon][0], Japon[AJapon][1], Japon[AJapon][2]);
	SetCameraBehindPlayer(playerid);
	}
	return 1;
}

//____________________________________________________________//
//____________________________________________________________//
//____________________________________________________________//


public Rangs(playerid)
{
    TextDrawShowForPlayer(playerid,RANG[playerid]);
    //________________________________________________//
	new Strings[200], Teams[55], Classement[55],Ranjation[55];

   	if(Team[playerid] == 0) {Teams = "USA"; }
	else if(Team[playerid] == 1) { Teams = "Russe"; }
	else if(Team[playerid] == 2) { Teams = "Mercenaire"; }
	else if(Team[playerid] == 3) { Teams = "Japonnais"; }
	
	if (Classe[playerid] == 1){Classement="Assault";}
	else if (Classe[playerid] == 2){Classement="Assault";}
	else if (Classe[playerid] == 3){Classement="Sniper";}
	else if (Classe[playerid] == 4){Classement="Démolisseur";}
	else if (Classe[playerid] == 5){Classement="Saboteur";}
	else if (Classe[playerid] == 6){Classement="Réparateur";}
	else if (Classe[playerid] == 7){Classement="Pilote";}
	else if (Classe[playerid] == 8){Classement="Pyroman";}
	else if (Classe[playerid] == 9){Classement="VIP";}
	else if (Classe[playerid] == 10){Classement="Médecin";}
	else if (Classe[playerid] == 100){Classement="Prestige Personnel";}

    //_______________________________________________//
	//_______________________________________________//
	if ( GetPlayerScore(playerid) <= 49)
	{
        Rang[playerid] = CADET;

		format(Strings,sizeof(Strings),"%s\nTuer: %d\nCADET\n%s", Teams, Kill[playerid],Classement);
		Update3DTextLabelText(Information[playerid], GetPlayerColor(playerid), Strings);

		Ranjation="Cadet";
		format(Strings,sizeof(Strings),"%s Kill:%d Mort:%d %s %s", Teams, Kill[playerid],Death[playerid],Ranjation, Classement);
		TextDrawSetString(RANG[playerid], Strings);
	}
	else if ( GetPlayerScore(playerid) >= 50 && GetPlayerScore(playerid) <= 99 )
	{
		Rang[playerid] = RECRUE;

        format(Strings,sizeof(Strings),"%s\nTuer: %d\nRECRUE\n%s", Teams, Kill[playerid],Classement);
		Update3DTextLabelText(Information[playerid], GetPlayerColor(playerid), Strings);

		Ranjation="Recrue";
		format(Strings,sizeof(Strings),"%s Kill:%d Mort:%d %s %s", Teams, Kill[playerid],Death[playerid],Ranjation, Classement);
		TextDrawSetString(RANG[playerid], Strings);
	}
	else if ( GetPlayerScore(playerid) >= 100 && GetPlayerScore(playerid) <= 149 )
	{
		Rang[playerid] = CORPORAL;

        format(Strings,sizeof(Strings),"%s\nTuer: %d\nCORPORAL\n%s", Teams, Kill[playerid],Classement);
		Update3DTextLabelText(Information[playerid], GetPlayerColor(playerid), Strings);

		Ranjation="Corporal";
		format(Strings,sizeof(Strings),"%s Kill:%d Mort:%d %s %s", Teams, Kill[playerid],Death[playerid],Ranjation, Classement);
		TextDrawSetString(RANG[playerid], Strings);
	}
	else if ( GetPlayerScore(playerid) >= 150 && GetPlayerScore(playerid) <= 199 )
	{
		Rang[playerid] = SERGENT;

        format(Strings,sizeof(Strings),"%s\nTuer: %d\nSERGENT\n%s", Teams, Kill[playerid],Classement);
		Update3DTextLabelText(Information[playerid], GetPlayerColor(playerid), Strings);

		Ranjation="Sergent";
		format(Strings,sizeof(Strings),"%s Kill:%d Mort:%d %s %s", Teams, Kill[playerid],Death[playerid],Ranjation, Classement);
		TextDrawSetString(RANG[playerid], Strings);
	}
	else if ( GetPlayerScore(playerid) >= 200 && GetPlayerScore(playerid) <= 299 )
	{
		Rang[playerid] = SERGENTDEQUARTIER;

        format(Strings,sizeof(Strings),"%s\nTuer: %d\nSERGENT DE QUARTIER\n%s", Teams, Kill[playerid],Classement);
		Update3DTextLabelText(Information[playerid], GetPlayerColor(playerid), Strings);

		Ranjation="Sergent de Quartier";
		format(Strings,sizeof(Strings),"%s Kill:%d Mort:%d %s %s", Teams, Kill[playerid],Death[playerid],Ranjation, Classement);
		TextDrawSetString(RANG[playerid], Strings);
	}
	else if ( GetPlayerScore(playerid) >= 300 && GetPlayerScore(playerid) <= 349 )
	{
		Rang[playerid] = CHEFSERGENT;

        format(Strings,sizeof(Strings),"%s\nTuer: %d\nCHEF SERGENT\n%s", Teams, Kill[playerid],Classement);
		Update3DTextLabelText(Information[playerid], GetPlayerColor(playerid), Strings);

		Ranjation="Chef Sergent";
		format(Strings,sizeof(Strings),"%s Kill:%d Mort:%d %s %s", Teams, Kill[playerid],Death[playerid],Ranjation, Classement);
		TextDrawSetString(RANG[playerid], Strings);
	}
	else if ( GetPlayerScore(playerid) >= 350 && GetPlayerScore(playerid) <= 399 )
	{
		Rang[playerid] = SERGENTENCHEF;

        format(Strings,sizeof(Strings),"%s\nTuer: %d\nSERGENT EN CHEF\n%s", Teams, Kill[playerid],Classement);
		Update3DTextLabelText(Information[playerid], GetPlayerColor(playerid), Strings);

		Ranjation="Sergent En Chef";
		format(Strings,sizeof(Strings),"%s Kill:%d Mort:%d %s %s", Teams, Kill[playerid],Death[playerid],Ranjation, Classement);
		TextDrawSetString(RANG[playerid], Strings);
	}
	else if ( GetPlayerScore(playerid) >= 400 && GetPlayerScore(playerid) <= 499 )
	{
		Rang[playerid] = SOUSMAJOR;

        format(Strings,sizeof(Strings),"%s\nTuer: %d\nSOUS-MAJOR\n%s", Teams, Kill[playerid],Classement);
		Update3DTextLabelText(Information[playerid], GetPlayerColor(playerid), Strings);

		Ranjation="Sous-Major";
		format(Strings,sizeof(Strings),"%s Kill:%d Mort:%d %s %s", Teams, Kill[playerid],Death[playerid],Ranjation, Classement);
		TextDrawSetString(RANG[playerid], Strings);
	}
	else if ( GetPlayerScore(playerid) >= 500 && GetPlayerScore(playerid) <= 699 )
	{
		Rang[playerid] = MAJOR;

        format(Strings,sizeof(Strings),"%s\nTuer: %d\nMAJOR\n%s", Teams, Kill[playerid],Classement);
		Update3DTextLabelText(Information[playerid], GetPlayerColor(playerid), Strings);

		Ranjation="Major";
		format(Strings,sizeof(Strings),"%s Kill:%d Mort:%d %s %s", Teams, Kill[playerid],Death[playerid],Ranjation, Classement);
		TextDrawSetString(RANG[playerid], Strings);
	}
    else if ( GetPlayerScore(playerid) >= 700 && GetPlayerScore(playerid) <= 799 )
	{
		Rang[playerid] = COLONEL;

        format(Strings,sizeof(Strings),"%s\nTuer: %d\nCOLONEL\n%s", Teams, Kill[playerid],Classement);
		Update3DTextLabelText(Information[playerid], GetPlayerColor(playerid), Strings);

		Ranjation="Colonel";
		format(Strings,sizeof(Strings),"%s Kill:%d Mort:%d %s %s", Teams, Kill[playerid],Death[playerid],Ranjation, Classement);
		TextDrawSetString(RANG[playerid], Strings);
	}
	else if ( GetPlayerScore(playerid) >= 800 && GetPlayerScore(playerid) <= 999 )
	{
		Rang[playerid] = BRIGADIERG;

        format(Strings,sizeof(Strings),"%s\nTuer: %d\nBRIGADIER-GENERAL\n%s", Teams, Kill[playerid],Classement);
		Update3DTextLabelText(Information[playerid], GetPlayerColor(playerid), Strings);

		Ranjation="Brigadier General";
		format(Strings,sizeof(Strings),"%s Kill:%d Mort:%d %s %s", Teams, Kill[playerid],Death[playerid],Ranjation, Classement);
		TextDrawSetString(RANG[playerid], Strings);
	}
	else if ( GetPlayerScore(playerid) >= 1000 && GetPlayerScore(playerid) <= 1499 )
	{
		Rang[playerid] = GENERAL;

        format(Strings,sizeof(Strings),"%s\nTuer: %d\nGENERAL\n%s", Teams, Kill[playerid],Classement);
		Update3DTextLabelText(Information[playerid], GetPlayerColor(playerid), Strings);

		Ranjation="General";
		format(Strings,sizeof(Strings),"%s Kill:%d Mort:%d %s %s", Teams, Kill[playerid],Death[playerid],Ranjation, Classement);
		TextDrawSetString(RANG[playerid], Strings);
	}
	else if ( GetPlayerScore(playerid) >= 1500 && GetPlayerScore(playerid) <= 1999 )
	{
		Rang[playerid] = MAJORG;

        format(Strings,sizeof(Strings),"%s\nTuer: %d\nMAJOR-GENERAL\n%s", Teams, Kill[playerid],Classement);
		Update3DTextLabelText(Information[playerid], GetPlayerColor(playerid), Strings);

		Ranjation="Major-General";
		format(Strings,sizeof(Strings),"%s Kill:%d Mort:%d %s %s", Teams, Kill[playerid],Death[playerid],Ranjation, Classement);
		TextDrawSetString(RANG[playerid], Strings);
	}
	else if ( GetPlayerScore(playerid) >= 2000 && GetPlayerScore(playerid) <= 2499 )
	{
		Rang[playerid] = GENERALAR;

        format(Strings,sizeof(Strings),"%s\nTuer: %d\nGENERAL ARMEE\n%s", Teams, Kill[playerid],Classement);
		Update3DTextLabelText(Information[playerid], GetPlayerColor(playerid), Strings);

		Ranjation="General Armee";
		format(Strings,sizeof(Strings),"%s Kill:%d Mort:%d %s %s", Teams, Kill[playerid],Death[playerid],Ranjation, Classement);
		TextDrawSetString(RANG[playerid], Strings);
	}
	else if ( GetPlayerScore(playerid) >= 2500 && GetPlayerScore(playerid) <= 2999 )
	{
		Rang[playerid] = MARECHAL;

        format(Strings,sizeof(Strings),"%s\nTuer: %d\nMARECHAL\n%s", Teams, Kill[playerid],Classement);
		Update3DTextLabelText(Information[playerid], GetPlayerColor(playerid), Strings);

		Ranjation="Marechal";
		format(Strings,sizeof(Strings),"%s Kill:%d Mort:%d %s %s", Teams, Kill[playerid],Death[playerid],Ranjation, Classement);
		TextDrawSetString(RANG[playerid], Strings);
	}
	else if ( GetPlayerScore(playerid) >= 3000 && GetPlayerScore(playerid) <= 3999 )
	{
		Rang[playerid] = PRESTIGEI;

        format(Strings,sizeof(Strings),"%s\nTuer: %d\nPRESTIGE-I\n%s", Teams, Kill[playerid],Classement);
		Update3DTextLabelText(Information[playerid], GetPlayerColor(playerid), Strings);

		Ranjation="PrestigeI";
		format(Strings,sizeof(Strings),"%s Kill:%d Mort:%d %s %s", Teams, Kill[playerid],Death[playerid],Ranjation, Classement);
		TextDrawSetString(RANG[playerid], Strings);
	}
	else if ( GetPlayerScore(playerid) >= 4000 && GetPlayerScore(playerid) <= 4999 )
	{
		Rang[playerid] = PRESTIGEII;

        format(Strings,sizeof(Strings),"%s\nTuer: %d\nPRESTIGE-II\n%s", Teams, Kill[playerid],Classement);
		Update3DTextLabelText(Information[playerid], GetPlayerColor(playerid), Strings);

		Ranjation="PrestigeII";
		format(Strings,sizeof(Strings),"%s Kill:%d Mort:%d %s %s", Teams, Kill[playerid],Death[playerid],Ranjation, Classement);
		TextDrawSetString(RANG[playerid], Strings);
	}
	else if ( GetPlayerScore(playerid) >= 5000)
	{
		Rang[playerid] = PRESTIGEIII;

        format(Strings,sizeof(Strings),"%s\nTuer: %d\nPRESTIGE-III\n%s", Teams, Kill[playerid],Classement);
		Update3DTextLabelText(Information[playerid], GetPlayerColor(playerid), Strings);

		Ranjation="PrestigeIII";
		format(Strings,sizeof(Strings),"%s Kill:%d Mort:%d %s %s", Teams, Kill[playerid],Death[playerid],Ranjation, Classement);
		TextDrawSetString(RANG[playerid], Strings);
	}
	return 1;
}

//____________________________________________________________//
//____________________________________________________________//
//____________________________________________________________//


public OnPlayerConnect(playerid)
{
	TextDrawShowForPlayer(playerid,Titre);
	TextDrawShowForPlayer(playerid,Regles);
    TextDrawShowForPlayer(playerid,BIA);
   	TextDrawShowForPlayer(playerid,Noir);
    //__________________________________________________________//
    print("[UN JOUEUR VIEN D'ENTRER]");
    //__________________________________________________________//
    GangZoneShowForPlayer(playerid, ZArmy, BLEUE);
    GangZoneShowForPlayer(playerid, ZMercenaire, BLANC);
    GangZoneShowForPlayer(playerid, ZRusse, POURPRE);
    GangZoneShowForPlayer(playerid, ZJapon, ORANGE);
	GangZoneShowForPlayer(playerid, TerritoireHotel, NOIR);
    GangZoneShowForPlayer(playerid, TerritoireFuel, NOIR);
    GangZoneShowForPlayer(playerid, TerritoirePark, NOIR);
    GangZoneShowForPlayer(playerid, TerritoireEntrepot, NOIR);
    GangZoneShowForPlayer(playerid, TerritoireAparte, NOIR);
    GangZoneShowForPlayer(playerid, TerritoireMarcher, NOIR);
    GangZoneShowForPlayer(playerid, TerritoireGare, NOIR);
    GangZoneShowForPlayer(playerid, TerritoireWash, NOIR);
    Territoire(playerid);
    //__________________________________________________________//
    SetTimerEx("Munitions", 60000*5, 0, "i", playerid);
    SetTimerEx("Connections", 550, 0, "i", playerid);
    //__________________________________________________________//
	/*==CONNECTION==*/
	Connecter++;
	//____________________________________________________________//
	SetPlayerMapIcon( playerid, 50, 2147.4602,-1818.3251,16.1406, 19, 0, MAPICON_GLOBAL );
    SetPlayerMapIcon( playerid, 51, 2435.0288,-2124.7832,13.5469, 19, 0, MAPICON_GLOBAL );
    SetPlayerMapIcon( playerid, 52, 2128.5146,-2263.6455,14.7808, 19, 0, MAPICON_GLOBAL );
    SetPlayerMapIcon( playerid, 53, 2171.9695,-1498.7477,23.9748, 19, 0, MAPICON_GLOBAL );
    SetPlayerMapIcon( playerid, 54, 2030.7883,-1655.9767,13.5547, 19, 0, MAPICON_GLOBAL );
    SetPlayerMapIcon( playerid, 55, 1994.4258,-2018.2747,13.5469, 19, 0, MAPICON_GLOBAL );
    SetPlayerMapIcon( playerid, 56, 1763.8785,-1910.4652,13.5694, 19, 0, MAPICON_GLOBAL );
    SetPlayerMapIcon( playerid, 57, 2511.1475,-1468.4246,24.0220, 19, 0, MAPICON_GLOBAL );
   	//____________________________________________________________//
	//____________________________________________________________//
	return 1;
}

forward Connections(playerid);
public Connections(playerid)
{
	SetPlayerCameraPos(playerid, 2772,-2519,45);
	SetPlayerCameraLookAt(playerid, 2748,-2473,13);
 	UsePlayerPedAnims();
    ClearC(playerid);
    //__________________________________________________________//
   	new Text[125], Jonom[MAX_PLAYER_NAME];
    GetPlayerName(playerid, Jonom, MAX_PLAYER_NAME);
    format(Text, sizeof(Text), "%s vient de rejoindre.(%d).", Jonom, Connecter);
	TextDrawSetString(Connection, Text);
	TextDrawShowForPlayer(playerid, Connection);
    //__________________________________________________________//
	new Nom[MAX_PLAYER_NAME], Fichier[256];
	GetPlayerName(playerid, Nom, sizeof(Nom));
	format(Fichier, sizeof(Fichier), ENREGISTREMENT, Nom);
	Bans[playerid] = dini_Int(Fichier,"Bannis");
	if (Bans[playerid] == 1)
	{
	    TogglePlayerControllable(playerid,false);
	    TextDrawShowForPlayer(playerid,Noir);
		SendClientMessage(playerid, POURPRE,"Votre Compte est bannis posté une demande de déban sur notre forum.");
	 	SendClientMessage(playerid, POURPRE,"[]");
	 	SetTimerEx("CBan", 1200, 0, "i", playerid);
		return 1;
	}
	//__________________________________________________________//
    //__________________________________________________________//
	//*== LOGGUE ==*/
	JoueurLogguer[playerid] = 0;
	if (!dini_Exists(Fichier) && Bans[playerid] == 0)
	{
	    ShowPlayerDialog(playerid, 1, DIALOG_STYLE_INPUT, "{FF0000}[Bienvenue]","Bienvenue, enregistrez-vous ci dessous.", "Enregistrer", "Quitter");
	}
	else if(fexist(Fichier) && Bans[playerid] == 0)
	{
	    ShowPlayerDialog(playerid, 2, DIALOG_STYLE_INPUT, "{FF0000}[Bienvenue]", "Bienvenue, connectez vous grâce a votre mot de passe.\nCi-dessous.", "Connecter", "Quitter");
	}
	RANG[playerid]=TextDrawCreate(610, 415, "-CHARGEMENT-");
 	TextDrawAlignment(RANG[playerid], 2);
 	TextDrawFont(RANG[playerid], 2);
  	TextDrawLetterSize(RANG[playerid], 0.200, 0.600);
  	TextDrawColor(RANG[playerid], BLANC);
  	TextDrawSetOutline(RANG[playerid], 1);
  	TextDrawTextSize (RANG[playerid],  3.0, 3.0) ;
	TextDrawShowForPlayer(playerid, RANG[playerid]);
	
	Boxrang = TextDrawCreate(585.000000,415.000000,"_ _ _");
	TextDrawUseBox(Boxrang,1);
	TextDrawBoxColor(Boxrang,0x00000033);
	TextDrawTextSize(Boxrang,800.000000,300.000000);
	TextDrawAlignment(Boxrang,0);
	TextDrawBackgroundColor(Boxrang,0x00000000);
	TextDrawFont(Boxrang,1);
	TextDrawLetterSize(Boxrang,1.000000,14.100000);
	TextDrawColor(Boxrang,0x00000000);
	TextDrawSetOutline(Boxrang,1);
	TextDrawSetProportional(Boxrang,1);
	TextDrawShowForPlayer(playerid, Text:Boxrang);
	
	Raffraichir(playerid);
 	//__________________________________________________________//
 	new Strings[128];
    format(Strings,sizeof(Strings),"-INFORMATION-\n-CHARGEMENT-");
    Information[playerid] = Create3DTextLabel(Strings, GetPlayerColor(playerid), 30.0, 40.0, 15.0, 15.0, 0);
    Attach3DTextLabelToPlayer(Information[playerid], playerid, 0.0, 0.0, 1.4);
	return 1;
}

//____________________________________________________________//
//____________________________________________________________//
//____________________________________________________________//
//____________________________________________________________//
//____________________________________________________________//
//____________________________________________________________//


public OnPlayerDisconnect(playerid, reason)
{
    //__________________________________________________________//
    print("[UN JOUEUR VIEN DE SORTIR]");
    //__________________________________________________________//
	KillTimer(THotel[playerid]);
	KillTimer(TFuel[playerid]);
	KillTimer(TEntrepot[playerid]);
	KillTimer(TPark[playerid]);
	KillTimer(TAparte[playerid]);
	KillTimer(TMarcher[playerid]);
	KillTimer(TGare[playerid]);
	KillTimer(TWash[playerid]);
    //__________________________________________________________//
    Territoire(playerid);
    //__________________________________________________________//
	/*== LOGIN ==*/
	new Nom[MAX_PLAYER_NAME], Fichier[256];
	GetPlayerName(playerid, Nom, sizeof(Nom));
	format(Fichier, sizeof(Fichier), ENREGISTREMENT, Nom);
	if(JoueurLogguer[playerid] == 1)
	{
	    dini_IntSet(Fichier, "Score", InfoJoueur[playerid][Score] = GetPlayerScore(playerid));
	    dini_IntSet(Fichier, "Money", InfoJoueur[playerid][Argent] = GetPlayerMoney(playerid));
        dini_IntSet(Fichier, "Level", InfoJoueur[playerid][Level] = Levels[playerid]);
        dini_IntSet(Fichier, "Kill/Death", InfoJoueur[playerid][KillDeath] = KD[playerid]);
        dini_IntSet(Fichier, "Morts", InfoJoueur[playerid][NMorts] = Death[playerid]);
        dini_IntSet(Fichier, "Tues", InfoJoueur[playerid][NTues] = Kill[playerid]);
        dini_IntSet(Fichier, "VIP", InfoJoueur[playerid][JVIP] = VIP[playerid]);
        dini_IntSet(Fichier, "Bannis", InfoJoueur[playerid][Bannis] = Bans[playerid]);

        dini_IntSet(Fichier, "MULTIKILL", InfoJoueur[playerid][MULTIKILL] = COMULTIKILL[playerid]);
        dini_IntSet(Fichier, "ULTRAKILL", InfoJoueur[playerid][ULTRAKILL] = COULTRAKILL[playerid]);
        dini_IntSet(Fichier, "FANTASTIQUE", InfoJoueur[playerid][FANTASTIQUE] = COFANTASTIQUE[playerid]);
        dini_IntSet(Fichier, "ARMAGEDDON", InfoJoueur[playerid][ARMAGEDDON] = COARMAGEDDON[playerid]);
        dini_IntSet(Fichier, "INCROYABLE", InfoJoueur[playerid][INCROYABLE] = COINCROYABLE[playerid]);
        dini_IntSet(Fichier, "BIGBANG", InfoJoueur[playerid][BIGBANG] = COBIGBANG[playerid]);
        dini_IntSet(Fichier, "IMPOSSIBLE", InfoJoueur[playerid][IMPOSSIBLE] = COIMPOSSIBLE[playerid]);
        dini_IntSet(Fichier, "IIMPOSSIBLE", InfoJoueur[playerid][IIMPOSSIBLE] = COIIMPOSSIBLE[playerid]);
        dini_IntSet(Fichier, "IIIMPOSSIBLE", InfoJoueur[playerid][IIIMPOSSIBLE] = COIIIMPOSSIBLE[playerid]);
        dini_IntSet(Fichier, "INDESTRUCTIBLE", InfoJoueur[playerid][INDESTRUCTIBLE] = COINDESTRUCTIBLE[playerid]);

		dini_IntSet(Fichier, "WarsPoints", InfoJoueur[playerid][WPoint] = WarsPoints[playerid]);

		dini_IntSet(Fichier, "Brouilleur", InfoJoueur[playerid][Brouilleur] = Brouilleurs[playerid]);

        dini_IntSet(Fichier, "Vie", InfoJoueur[playerid][Vie] = SVie[playerid]);

        dini_IntSet(Fichier, "Banque", InfoJoueur[playerid][Banques] = Banque[playerid]);

        dini_IntSet(Fichier, "Skin", InfoJoueur[playerid][PSkin] = Skins[playerid]);

        dini_IntSet(Fichier, "SLOTSI", InfoJoueur[playerid][SLOTSI] = SlotI[playerid]);
		dini_IntSet(Fichier, "SLOTSII", InfoJoueur[playerid][SLOTSII] = SlotII[playerid]);
		dini_IntSet(Fichier, "SLOTSIII", InfoJoueur[playerid][SLOTSIII] = SlotIII[playerid]);
		dini_IntSet(Fichier, "SLOTSIIII", InfoJoueur[playerid][SLOTSIIII] = SlotIIII[playerid]);
		dini_IntSet(Fichier, "SLOTSIIIII", InfoJoueur[playerid][SLOTSIIIII] = SlotIIIII[playerid]);
		dini_IntSet(Fichier, "SLOTSIIIIII", InfoJoueur[playerid][SLOTSIIIIII] = SlotIIIIII[playerid]);

        ClearC(playerid);
	}
	JoueurLogguer[playerid] = 0;
	//____________________________________________________________//
    Connecter--;
	new Text[125], Jonom[MAX_PLAYER_NAME];
    GetPlayerName(playerid, Jonom, MAX_PLAYER_NAME);
	if(reason == 0)
	{
	    format(Text, sizeof(Text), "%s A une connection en carton (Crash) (%d).", Jonom, Connecter);
		TextDrawSetString(Connection, Text);
		print("[UN JOUEUR VIENT DE SORTIR CRASH]");
	}
	else if(reason == 1)
	{
	    format(Text, sizeof(Text), "%s A quitter la partie (%d).", Jonom, Connecter);
	    TextDrawSetString(Connection, Text);
  		print("[UN JOUEUR VIENT DE SORTIR]");
	}
	else if(reason == 2)
	{
	    format(Text, sizeof(Text), "%s A fait une connerie (kick/bannis) (%d).", Jonom, Connecter);
	    TextDrawSetString(Connection, Text);
  		print("[UN JOUEUR VIENT DE SORTIR KICKER]");
	}
	else
	{
	    format(Text, sizeof(Text), "%s A pas de MDP (kick loging) (%d).", Jonom, Connecter);
	    TextDrawSetString(Connection, Text);
  		print("[UN JOUEUR VIENT DE SORTIR LOGING INCORRECT]");
	}
	//____________________________________________________________//
	TextDrawDestroy(RANG[playerid]);
	Delete3DTextLabel(Admins[playerid]);
	return 1;
}

//____________________________________________________________//
//____________________________________________________________//
//____________________________________________________________//
//____________________________________________________________//
//____________________________________________________________//
//____________________________________________________________//


public OnPlayerSpawn(playerid)
{
   	AntiDeAMX();
	//________________________________________//
	TextDrawHideForPlayer(playerid,Titre);
	TextDrawHideForPlayer(playerid,Regles);
	TextDrawHideForPlayer(playerid,Noir);
	TogglePlayerControllable(playerid,true);
    //________________________________________//
   	DisablePlayerCheckpoint(playerid);
	Captures[playerid] = 0;
	//________________________________________//
	if (Jailled[playerid] == 1)
	{
	SetPlayerInterior(playerid,3);
	SetPlayerPos(playerid,197.500,173.500,1003.0234);
	ResetPlayerWeapons(playerid);
	return 0;
	}
    //________________________________________//
	Classiation(playerid);
	SpawnVie(playerid);
	Spawn(playerid);
	//____________________________________________________________//
    if (Devoir[playerid] == 1)
	{
		{
		new JNom[24], String[256];
		GetPlayerName(playerid, JNom, sizeof(JNom));
		format(String, sizeof(String), "[Information] L'Administrateur %s n'est plus en Service vous pouvez lui tiré dessus.", JNom);
		SendClientMessageToAll(POURPRE, String);

		SetPlayerSkin(playerid,Skin[playerid]);
		SetPlayerColor(playerid,Couleur[playerid]);

		Delete3DTextLabel(Admins[playerid]);

		Devoir[playerid] = 0;

		}
	}
	return 1;
}

public Classiation(playerid)
{
	if(PSK[playerid] == 1)
    {
    SetPlayerSkin(playerid,Skins[playerid]);
    }
    if(Classe[playerid] == 0 && Rang[playerid] >= PRESTIGEI )
	{
	TextDrawShowForPlayer(playerid,Noir);
	ShowPlayerDialog(playerid, 35, DIALOG_STYLE_LIST, "Menu des CLASSES Prestiges :", "Assault ()\nSniper(Corporal)\nDémolisseur(Sergent)\nSaboteur(Major)\nRéparateur(Lieutenant Colonel)\nPilote (Colonel)\nPyroman (Brigadier Général)\n VIP (VIP)\nMédecin (Major)\nCLASSE PERSONNEL OPTION\nCLASSE PERSONNELLE", "Sélectionné", "");
    TogglePlayerControllable(playerid,false);
	}
	else if(Classe[playerid] == 0)
	{
	TextDrawShowForPlayer(playerid,Noir);
	ShowPlayerDialog(playerid, 20, DIALOG_STYLE_LIST, "Menu des CLASSES :", "Assault ()\nSniper(Corporal)\nDémolisseur(Sergent)\nSaboteur(Major)\nRéparateur(Lieutenant Colonel)\nPilote (Colonel)\nPyroman (Brigadier Général)\n VIP (VIP)\nMédecin (Major)", "Sélectionné", "");
    TogglePlayerControllable(playerid,false);
	}
	else if(Classe[playerid] == 1)
	{
    GivePlayerWeapon(playerid,4,1);
    GivePlayerWeapon(playerid,24,207);
    GivePlayerWeapon(playerid,29,230);
    GivePlayerWeapon(playerid,25,15);
    GivePlayerWeapon(playerid,31,750);
	}
	else if(Classe[playerid] == 2)
	{
    GivePlayerWeapon(playerid,4,1);
    GivePlayerWeapon(playerid,24,207);
    GivePlayerWeapon(playerid,29,230);
    GivePlayerWeapon(playerid,25,15);
    GivePlayerWeapon(playerid,30,780);
	}
	else if(Classe[playerid] == 3)
	{
    GivePlayerWeapon(playerid,4,1);
    GivePlayerWeapon(playerid,23,117);
    GivePlayerWeapon(playerid,34,225);
	}
	else if(Classe[playerid] == 4)
	{
    GivePlayerWeapon(playerid,16,15);
    GivePlayerWeapon(playerid,35,3);
    GivePlayerWeapon(playerid,27,107);
	}
    else if(Classe[playerid] == 5)
	{
    GivePlayerWeapon(playerid,31,750);
    GivePlayerWeapon(playerid,24,87);
    GivePlayerWeapon(playerid,34,25);
    GivePlayerWeapon(playerid,29,830);
    GivePlayerWeapon(playerid,4,1);
	}
	else if(Classe[playerid] == 6)
	{
    GivePlayerWeapon(playerid,25,185);
    GivePlayerWeapon(playerid,24,87);
    GivePlayerWeapon(playerid,4,1);
	}
	else if(Classe[playerid] == 7)
	{
    GivePlayerWeapon(playerid,46,1);
    GivePlayerWeapon(playerid,24,107);
    GivePlayerWeapon(playerid,4,1);
   	SetPlayerSkin(playerid,16);
	}
	else if(Classe[playerid] == 8)
	{
    GivePlayerWeapon(playerid,27,150);
	GivePlayerWeapon(playerid,25,45);
	GivePlayerWeapon(playerid,42,35);
	GivePlayerWeapon(playerid,18,2);
   	SetPlayerSkin(playerid,279);
	}
	else if(Classe[playerid] == 9)
	{
    GivePlayerWeapon(playerid,4,1);
    GivePlayerWeapon(playerid,24,107);
    GivePlayerWeapon(playerid,29,230);
    GivePlayerWeapon(playerid,31,550);
    GivePlayerWeapon(playerid,35,1);
    GivePlayerWeapon(playerid,17,5);
	}
	else if(Classe[playerid] == 10)
	{
    GivePlayerWeapon(playerid,4,1);
    GivePlayerWeapon(playerid,23,117);
    GivePlayerWeapon(playerid,29,130);
	}
	else if(Classe[playerid] == 100)
	{
	//-________________________________________________//
		if (SlotI[playerid] == 31)
		{
		GivePlayerWeapon(playerid,SlotI[playerid],550);
		}
		if (SlotI[playerid] == 30)
		{
		GivePlayerWeapon(playerid,SlotI[playerid],630);
		}
		//-________________________________________________//
		if (SlotII[playerid] == 24)
		{
		GivePlayerWeapon(playerid,SlotII[playerid],87);
		}
	 	if (SlotII[playerid] == 23)
		{
		GivePlayerWeapon(playerid,SlotII[playerid],167);
		}
		//-________________________________________________//
		if (SlotIII[playerid] == 29)
		{
		GivePlayerWeapon(playerid,SlotIII[playerid],530);
		}
		if (SlotIII[playerid] == 23)
		{
		GivePlayerWeapon(playerid,SlotIII[playerid],150);
		}
		//-________________________________________________//
		GivePlayerWeapon(playerid,SlotIIII[playerid],1);
		//-________________________________________________//
		if (SlotIIIII[playerid] == 25)
		{
		GivePlayerWeapon(playerid,SlotIIIII[playerid],150);
		}
		if (SlotIIIII[playerid] == 27)
		{
		GivePlayerWeapon(playerid,SlotIIIII[playerid],87);
		}
		//-________________________________________________//
	 	if (SlotIIIII[playerid] == 16)
		{
		GivePlayerWeapon(playerid,SlotIIIIII[playerid],2);
		}
		if (SlotIIIII[playerid] == 17)
		{
		GivePlayerWeapon(playerid,SlotIIIIII[playerid],5);
		return 1;
		}
	}
    return 1;
}

//____________________________________________________________//
//____________________________________________________________//
//____________________________________________________________//


public Munitions(playerid)
{
    new Float:Armure;
    for(new i = 0; i < MAX_PLAYERS; i++)
   	{
   	    if(IsPlayerConnected(i))
		{
		    if(TerritoireEntrepotAppartenance == Team[i])
		    {
		    SendClientMessage(i, GRIS, "L'entrepôt vient de livré des armures 8 Armures ! Prochaine livraison dans 5 minutes !");
		    GetPlayerArmour(playerid,Armure);
		    SetPlayerArmour(i,Armure+8);
		    }
		}
	}
	SetTimerEx("Munitions", 60000*5, 0, "i", playerid);
	return 1;
}

//____________________________________________________________//
//________________________NEW CLASSE__________________________//
//____________________________________________________________//

public Reparation(playerid)
{
	Rep[playerid] = 0;
    return 1;
}

public Soigne(playerid)
{
	Soin[playerid] = 0;
    return 1;
}

//____________________________________________________________//
//____________________________________________________________//
//____________________________________________________________//

public SpawnVie(playerid)
{
	if (SVie[playerid] == 1)
	{
	SetPlayerHealth(playerid,115);
	SendClientMessage(playerid, POURPRE,"Vous avez 115 de vie grâce a vôtre bonus.");
	}
	else if (SVie[playerid] == 2)
	{
	SetPlayerHealth(playerid,130);
	SendClientMessage(playerid, POURPRE,"Vous avez 130 de vie grâce a vôtre bonus.");
	}
	return 1;
}

//____________________________________________________________//
//____________________________________________________________//
//____________________________________________________________//

public OnPlayerDeath(playerid, killerid, reason)
{
	if(Team[killerid] == Team[playerid])
	{
	//____________________________________________________________//
	SendDeathMessage(killerid,playerid,reason);
	SetPlayerScore(killerid,GetPlayerScore(killerid)-1);
	GivePlayerMoney(killerid, -1000);
	//____________________________________________________________//
	KillDeathRatioForKilled(playerid,killerid);
	//____________________________________________________________//
	}
	else if(Team[killerid] != Team[playerid])
	{
	SendDeathMessage(killerid,playerid,reason);
	SetPlayerScore(killerid,GetPlayerScore(killerid)+1);
	GivePlayerMoney(killerid, random(1000));
	//____________________________________________________________//
	KillDeathRatioForKilled(playerid,killerid);
	//____________________________________________________________//
	}
}

//____________________________________________________________//
//____________________________________________________________//
//____________________________________________________________//

public Combinaison(playerid)
{
	if (Combos[playerid] == 1)
	{
	SendClientMessage(playerid, POURPRE,"Et de 1 !");
	SetTimerEx("SCombos", 60000*5, 0, "i", playerid);
	}
	if (Combos[playerid] == 2)
	{
	SendClientMessage(playerid, POURPRE,"Et de 2 !");
	}
	if (Combos[playerid] == 3)
	{
	new Ficelle[128], Jnoms[24];
	GetPlayerName(playerid, Jnoms, 24);
	format(Ficelle, sizeof(Ficelle), "%s a fait un MULTIKILL.",Jnoms);
	SendClientMessage(playerid,POURPRE,Ficelle);
	GameTextForPlayer(playerid, "~g~MULTIKILL", 1000,4);
	COMULTIKILL[playerid]++;
	}
	if (Combos[playerid] == 4)
	{
	new Ficelle[128], Jnoms[24];
	GetPlayerName(playerid, Jnoms, 24);
	format(Ficelle, sizeof(Ficelle), "%s ULTRAKILL.",Jnoms);
	SendClientMessage(playerid,POURPRE,Ficelle);
	GameTextForPlayer(playerid, "~y~ULTRAKILL", 1000,4);
	COULTRAKILL[playerid]++;
	}
	if (Combos[playerid] == 5)
	{
	new Ficelle[128], Jnoms[24];
	GetPlayerName(playerid, Jnoms, 24);
	format(Ficelle, sizeof(Ficelle), "%s FANTASTIQUE.",Jnoms);
	SendClientMessage(playerid,POURPRE,Ficelle);
	GameTextForPlayer(playerid, "~r~FANTASTIQUE", 1000,4);
	COFANTASTIQUE[playerid]++;
	}
	if (Combos[playerid] == 6)
	{
	new Ficelle[128], Jnoms[24];
	GetPlayerName(playerid, Jnoms, 24);
	format(Ficelle, sizeof(Ficelle), "%s ARMAGEDDON.",Jnoms);
	SendClientMessageToAll(POURPRE,Ficelle);
	GameTextForPlayer(playerid, "~b~ARMAGEDDON", 1000,4);
	COARMAGEDDON[playerid]++;
	}
	if (Combos[playerid] == 7)
	{
	new Ficelle[128], Jnoms[24];
	GetPlayerName(playerid, Jnoms, 24);
	format(Ficelle, sizeof(Ficelle), "%s INCROYABLE !",Jnoms);
	SendClientMessageToAll(POURPRE,Ficelle);
	GameTextForPlayer(playerid, "~g~INCROYABLE", 1000,4);
	COINCROYABLE[playerid]++;
	}
	if (Combos[playerid] == 8)
	{
	new Ficelle[128], Jnoms[24];
	GetPlayerName(playerid, Jnoms, 24);
	format(Ficelle, sizeof(Ficelle), "%s le BIG BANG.",Jnoms);
	SendClientMessageToAll(POURPRE,Ficelle);
	GameTextForPlayer(playerid, "~b~BIG BANG", 1000,4);
	COBIGBANG[playerid]++;
	SetPlayerScore(playerid,GetPlayerScore(playerid)+1);
	SendClientMessage(playerid, POURPRE,"+1 point pour ce Combos !");
	}
	if (Combos[playerid] == 9)
	{
	new Ficelle[128], Jnoms[24];
	GetPlayerName(playerid, Jnoms, 24);
	format(Ficelle, sizeof(Ficelle), "%s IMPOSSIBLE !",Jnoms);
	SendClientMessageToAll(POURPRE,Ficelle);
	GameTextForPlayer(playerid, "~r~IMPOSSIBLE", 1000,4);
	COIMPOSSIBLE[playerid]++;
	SetPlayerScore(playerid,GetPlayerScore(playerid)+1);
	SendClientMessage(playerid, POURPRE,"+1 point pour ce Combos !");
	}
	if (Combos[playerid] == 10)
	{
	new Ficelle[128], Jnoms[24];
	GetPlayerName(playerid, Jnoms, 24);
	format(Ficelle, sizeof(Ficelle), "%s IMPOSSIBLE + !",Jnoms);
	SendClientMessageToAll(POURPRE,Ficelle);
	GameTextForPlayer(playerid, "{CC0000} IMPOSSIBLE +", 1000,4);
	COIIMPOSSIBLE[playerid]++;
	SetPlayerScore(playerid,GetPlayerScore(playerid)+1);
	SendClientMessage(playerid, POURPRE,"+1 point pour ce Combos !");
	}
	if (Combos[playerid] == 11)
	{
	new Ficelle[128], Jnoms[24];
	GetPlayerName(playerid, Jnoms, 24);
	format(Ficelle, sizeof(Ficelle), "%s IMPOSSIBLE ++ !",Jnoms);
	SendClientMessageToAll(POURPRE,Ficelle);
	GameTextForPlayer(playerid, "~r~IMPOSSIBLE ++", 1000,4);
	COIIIMPOSSIBLE[playerid]++;
	SetPlayerScore(playerid,GetPlayerScore(playerid)+1);
	SendClientMessage(playerid, POURPRE,"+1 point pour ce Combos !");
	}
	if (Combos[playerid] >= 12)
	{
	new Ficelle[128], Jnoms[24];
	GetPlayerName(playerid, Jnoms, 24);
	format(Ficelle, sizeof(Ficelle), "%s TOTALEMENT INDESTRUCTIBLE !",Jnoms);
	SendClientMessageToAll(POURPRE,Ficelle);
	GameTextForPlayer(playerid, "~r~TOTALEMENT~n~INDESTRUCTIBLE", 1000,4);
	COINDESTRUCTIBLE[playerid]++;
	SetPlayerScore(playerid,GetPlayerScore(playerid)+2);
	SendClientMessage(playerid, POURPRE,"+2 point pour ce Combos !");
	}
    return 1;
}

//____________________________________________________________//
//____________________________________________________________//
//____________________________________________________________//

public SCombos(playerid)
{
    Combos[playerid] = 0;
    return 1;
}

//____________________________________________________________//
//____________________________________________________________//
//____________________________________________________________//
//____________________________________________________________//
//____________________________________________________________//
//____________________________________________________________//

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

//____________________________________________________________//
//____________________________________________________________//
//____________________________________________________________//
//____________________________________________________________//
//____________________________________________________________//
//____________________________________________________________//

public OnPlayerText(playerid, text[])
{
	{

		if (Mute[playerid] == 1)
        {
                SendClientMessage(playerid,POURPRE,"[MUTER PERSONNE NE PEUT LIRE CE QUE TU ECRIT]");
                return 0;
        }
		new NomAdmin[MAX_PLAYER_NAME];
        if(text[0] == '*' && Levels[playerid] >= 1)
		{
                new Tmppp[256];
                GetPlayerName(playerid, NomAdmin, sizeof(NomAdmin));
                format(Tmppp, sizeof(Tmppp), "[FLASH-ADMINISTRATEUR] [%s] - [[%s]]",NomAdmin,text[1]);
                SendClientMessageToAll(POURPRE, Tmppp);
                return 0;
        }
        if(text[0] == '!')
		{
		   	for(new i = 0; i < MAX_PLAYERS; i++)
	    	{
		    	if(Team[i] == Team[playerid] && Rang[playerid] == CADET )
				{
                new Messages[128];
				GetPlayerName(playerid, Messages, sizeof(Messages));
 				format(Messages, sizeof(Messages), "[E][Equipe] CADET %s : {FFFFFF} %s, terminée.", Messages, text[1]);
		 		SendClientMessage(i, GetPlayerColor(playerid), Messages);
		    	}
		    	else if(Team[i] == Team[playerid] && Rang[playerid] == RECRUE )
		    	{
		    	new Messages[128];
				GetPlayerName(playerid, Messages, sizeof(Messages));
 				format(Messages, sizeof(Messages), "[E][Equipe] RECRUE %s : {FFFFFF} %s, terminée.", Messages, text[1]);
		 		SendClientMessage(i, GetPlayerColor(playerid), Messages);
		    	}
		    	else if(Team[i] == Team[playerid] && Rang[playerid] == CORPORAL )
		    	{
		    	new Messages[128];
				GetPlayerName(playerid, Messages, sizeof(Messages));
 				format(Messages, sizeof(Messages), "[E][Equipe] CORPORAL %s : {FFFFFF} %s, terminée.", Messages, text[1]);
  		 		printf("%s", Messages);
		 		SendClientMessage(i, GetPlayerColor(playerid), Messages);
		    	}
		    	else if(Team[i] == Team[playerid] && Rang[playerid] == SERGENT )
		    	{
		    	new Messages[128];
				GetPlayerName(playerid, Messages, sizeof(Messages));
 				format(Messages, sizeof(Messages), "[E][Equipe] SERGENT %s : {FFFFFF} %s, terminée.", Messages, text[1]);
		 		SendClientMessage(i, GetPlayerColor(playerid), Messages);
		    	}
		    	else if(Team[i] == Team[playerid] && Rang[playerid] == SERGENTDEQUARTIER )
		    	{
		    	new Messages[128];
				GetPlayerName(playerid, Messages, sizeof(Messages));
 				format(Messages, sizeof(Messages), "[E][Equipe] SERGENT DE QUARTIER %s : {FFFFFF} %s, terminée.", Messages, text[1]);
		 		SendClientMessage(i, GetPlayerColor(playerid), Messages);
		    	}
		    	else if(Team[i] == Team[playerid] && Rang[playerid] == CHEFSERGENT )
		    	{
		    	new Messages[128];
				GetPlayerName(playerid, Messages, sizeof(Messages));
 				format(Messages, sizeof(Messages), "[E][Equipe] CHEF SERGENT %s : {FFFFFF} %s, terminée.", Messages, text[1]);
		 		SendClientMessage(i, GetPlayerColor(playerid), Messages);
		    	}
		    	else if(Team[i] == Team[playerid] && Rang[playerid] == SERGENTENCHEF )
		    	{
		    	new Messages[128];
				GetPlayerName(playerid, Messages, sizeof(Messages));
 				format(Messages, sizeof(Messages), "[E][Equipe] SERGENT EN CHEF %s : {FFFFFF} %s, terminée.", Messages, text[1]);
		 		SendClientMessage(i, GetPlayerColor(playerid), Messages);
		    	}
		    	else if(Team[i] == Team[playerid] && Rang[playerid] == SOUSMAJOR )
		    	{
		    	new Messages[128];
				GetPlayerName(playerid, Messages, sizeof(Messages));
 				format(Messages, sizeof(Messages), "[E][Equipe] SOUS MAJOR %s : {FFFFFF} %s, terminée.", Messages, text[1]);
		 		SendClientMessage(i, GetPlayerColor(playerid), Messages);
		    	}
		    	else if(Team[i] == Team[playerid] && Rang[playerid] == MAJOR )
		    	{
		    	new Messages[128];
				GetPlayerName(playerid, Messages, sizeof(Messages));
 				format(Messages, sizeof(Messages), "[E][Equipe] MAJOR %s : {FFFFFF} %s, terminée.", Messages, text[1]);
		 		SendClientMessage(i, GetPlayerColor(playerid), Messages);
		    	}
		    	else if(Team[i] == Team[playerid] && Rang[playerid] == COLONEL )
		    	{
		    	new Messages[128];
				GetPlayerName(playerid, Messages, sizeof(Messages));
 				format(Messages, sizeof(Messages), "[E][Equipe] COLONEL %s : {FFFFFF} %s, terminée.", Messages, text[1]);
		 		SendClientMessage(i, GetPlayerColor(playerid), Messages);
		    	}
		    	else if(Team[i] == Team[playerid] && Rang[playerid] == BRIGADIERG )
		    	{
		    	new Messages[128];
				GetPlayerName(playerid, Messages, sizeof(Messages));
 				format(Messages, sizeof(Messages), "[E][Equipe] BRIGADIER GENERAL %s : {FFFFFF} %s, terminée.", Messages, text[1]);
		 		SendClientMessage(i, GetPlayerColor(playerid), Messages);
		    	}
		    	else if(Team[i] == Team[playerid] && Rang[playerid] == GENERAL )
		    	{
		    	new Messages[128];
				GetPlayerName(playerid, Messages, sizeof(Messages));
 				format(Messages, sizeof(Messages), "[E][Equipe] GENERAL %s : {FFFFFF} %s, terminée.", Messages, text[1]);
		 		SendClientMessage(i, GetPlayerColor(playerid), Messages);
		    	}
		    	else if(Team[i] == Team[playerid] && Rang[playerid] == MAJORG )
		    	{
		    	new Messages[128];
				GetPlayerName(playerid, Messages, sizeof(Messages));
 				format(Messages, sizeof(Messages), "[E][Equipe] MAJOR-GENERAL %s : {FFFFFF} %s, terminée.", Messages, text[1]);
		 		SendClientMessage(i, GetPlayerColor(playerid), Messages);
		    	}
		    	else if(Team[i] == Team[playerid] && Rang[playerid] == GENERALAR )
		    	{
		    	new Messages[128];
				GetPlayerName(playerid, Messages, sizeof(Messages));
 				format(Messages, sizeof(Messages), "[E][Equipe] GENERAL ARMEE %s : {FFFFFF} %s, terminée.", Messages, text[1]);
		 		SendClientMessage(i, GetPlayerColor(playerid), Messages);
		    	}
		    	else if(Team[i] == Team[playerid] && Rang[playerid] == MARECHAL )
		    	{
		    	new Messages[128];
				GetPlayerName(playerid, Messages, sizeof(Messages));
 				format(Messages, sizeof(Messages), "[E][Equipe] MARECHAL %s : {FFFFFF} %s, terminée.", Messages, text[1]);
		 		SendClientMessage(i, GetPlayerColor(playerid), Messages);
		    	}
		    	else if(Team[i] == Team[playerid] && Rang[playerid] == PRESTIGEI )
		    	{
		    	new Messages[128];
				GetPlayerName(playerid, Messages, sizeof(Messages));
 				format(Messages, sizeof(Messages), "[E][Equipe] PRESTIGE I %s : {FFFFFF} %s, terminée.", Messages, text[1]);
		 		SendClientMessage(i, GetPlayerColor(playerid), Messages);
		    	}
		    	else if(Team[i] == Team[playerid] && Rang[playerid] == PRESTIGEII )
		    	{
		    	new Messages[128];
				GetPlayerName(playerid, Messages, sizeof(Messages));
 				format(Messages, sizeof(Messages), "[E][Equipe] PRESTIGE II %s : {FFFFFF} %s, terminée.", Messages, text[1]);
		 		SendClientMessage(i, GetPlayerColor(playerid), Messages);
		    	}
		    	else if(Team[i] == Team[playerid] && Rang[playerid] == PRESTIGEIII )
		    	{
		    	new Messages[128];
				GetPlayerName(playerid, Messages, sizeof(Messages));
 				format(Messages, sizeof(Messages), "[E][Equipe] PRESTIGE III %s : {FFFFFF} %s, terminée.", Messages, text[1]);
		 		SendClientMessage(i, GetPlayerColor(playerid), Messages);
		    	}
			}
			return 0;
		}
		new String[128];
		new Float:XXX, Float:YYY, Float:ZZZ;
		GetPlayerPos(playerid, XXX, YYY, ZZZ);
		GetPlayerName(playerid, String, sizeof(String));
	    format(String, sizeof(String), "%s dit : %s", String, text[0]);
	    SetPlayerChatBubble(playerid, String, 0xF7F7F7FF, 30.0, 10000);
	    printf("%s", String);
	    for(new i = 0; i < MAX_PLAYERS; i++)
		{
	    	if(IsPlayerInRangeOfPoint(i, 25.0, XXX, YYY, ZZZ) && IsPlayerConnected(i))
			{
			SendClientMessage(i,0xF7F7F7FF, String);
		   	}
		}
	}
	return 0;
}

//____________________________________________________________//
//____________________________________________________________//
//____________________________________________________________//
//____________________________________________________________//
//____________________________________________________________//
//____________________________________________________________//


public OnPlayerCommandText(playerid, cmdtext[])
{
    new Cmd[256];
	new Idx;
	new NomAdmin[MAX_PLAYER_NAME];
	new JidNom[MAX_PLAYER_NAME];
	Cmd = strtok (cmdtext, Idx);

/*=========== COMMANDES ADMINISTRATEUR ============*/
//____________________________________________________________//
//____________________________________________________________//
//____________________________________________________________//


	if (strcmp("/aaide", cmdtext, true, 10) == 0)
	{
        if(Levels[playerid] == 6)
        {

		ShowPlayerDialog(playerid,45,DIALOG_STYLE_MSGBOX,"{FF0000}[Les Aides ADM L-6]","/arangs,/devoir,/destroyspawncar,/spec,/stopspec,/dire,/kick\n/tuer,/force,/slap,/drop,/voiture,/exploser,/goto,/gethere\n/remorque,/armure,/vie,/tp,/score,/donnerscore,/cdestroy,/argent,/skin,/donnerarme,/etoile\n/repair,/mute,/unmute,/ban,/unfreeze,/freeze,/ann,/cc,/healall,/remorqueall,/tuerall,/respawnallcar,/armureall\n/scoreall,/argentall,/temps,/armeall,/muteall,/gethereall,/aferme,/car","Fermer","");

		}
        else if(Levels[playerid] == 5)
        {

		ShowPlayerDialog(playerid,45,DIALOG_STYLE_MSGBOX,"{FF0000}[Les Aides ADM L-5]","/arangs,/devoir,/destroyspawncar,/spec,/stopspec,/dire,/kick\n/tuer,/force,/slap,/drop,/voiture,/exploser,/goto,/gethere\n/remorque,/armure,/vie,/tp,/score,/donnerscore,/cdestroy,/argent,/skin,/donnerarme,/etoile\n/repair,/mute,/unmute,/ban,/unfreeze,/freeze,/ann,/cc,/healall,/remorqueall,/tuerall,/respawnallcar,/armureall\n/scoreall,/argentall,/temps,/armeall,/muteall,/gethereall,/aferme,/car","Fermer","");

		}
		else if(Levels[playerid] == 4)
        {

        ShowPlayerDialog(playerid,45,DIALOG_STYLE_MSGBOX,"{FF0000}[Les Aides ADM L-4]","/arangs,/devoir,/destroyspawncar,/spec,/stopspec,/dire,/kick\n/tuer,/force,/slap,/drop,/voiture,/exploser,/goto,/gethere\n/remorque,/armure,/vie,/tp,/score,/donnerscore,/cdestroy,/argent,/skin,/donnerarme,/etoile\n/repair,/mute,/unmute,/ban,/unfreeze,/freeze,/ann,/cc,/healall,/remorqueall,/tuerall,/respawnallcar,/armureall\n/scoreall,/argentall,/temps,/armeall,/muteall,/gethereall,/aferme,","Fermer","");

		}
		else if(Levels[playerid] == 3)
        {

        ShowPlayerDialog(playerid,45,DIALOG_STYLE_MSGBOX,"{FF0000}[Les Aides ADM L-3]","/arangs,/devoir,/spec,/stopspec,/dire,/kick\n/tuer,/force,/slap,/drop,/exploser,/goto,/gethere\n/remorque,/armure,/vie,/tp,/score,/donnerscore,/argent,/skin,/donnerarme,/etoile\n/repair,/mute,/unmute,/ban,/unfreeze,/freeze,/ann,/cc,/healall,/remorqueall,/respawnallcar,/armureall\n/scoreall,/argentall,/temps,/armeall,/muteall,unmuteall,/gethereall","Fermer","");

		}
		else if(Levels[playerid] == 2)
        {

        ShowPlayerDialog(playerid,45,DIALOG_STYLE_MSGBOX,"{FF0000}[Les Aides ADM L-2]","/arangs,/devoir,/spec,/stopspec,/dire,/kick\n/slap,/goto,/gethere,/remorque,/armure,/vie,/score,/donnerscore,/argent,/skin,/donnerarme,/etoile\n/repair,/mute,/unmute,/ban,/ann,/cc,/healall,/remorqueall,/armureall\n/temps,/armeall","Fermer","");

		}
		else if(Levels[playerid] == 1)
        {

        ShowPlayerDialog(playerid,45,DIALOG_STYLE_MSGBOX,"{FF0000}[Les Aides ADM L-1]","/arangs,/information,/devoir,/spec,/stopspec,/dire,/kick\n/skin,/donnerarme,/etoile\n/repair,/mute,/unmute,/ann,/cc,/temps","Fermer","");

		}
		return 1;
	}

	//____________________________________________________________//
	//____________________________________________________________//
	//____________________________________________________________//

	if	(!strcmp(Cmd, "/devoir", true))
	{
	if (Levels[playerid] != 0)
    {
    if (Devoir[playerid] == 0)
		{
		Devoir[playerid] = 1;
		Skin[playerid] = GetPlayerSkin(playerid);
		Couleur[playerid] = GetPlayerColor(playerid);
		SetPlayerHealth(playerid,9999);
		new JNom[256], String[256];
		GetPlayerName(playerid, JNom, sizeof(JNom));
		format(String, sizeof(String), "[Information] L'Administrateur %s est en Service vous ne lui tiré pas dessus.", JNom);
		SendClientMessageToAll(POURPRE, String);
		SetPlayerSkin(playerid,217);
		SetPlayerColor(playerid,ZAZOLIN);
		Admins[playerid] = Create3DTextLabel("[ADMINISTRATEUR EN SERVICE] Ne pas tiré/frappé dessus !", ZAZOLIN, 30.0, 40.0, 50.0, 40.0, 0);
		Attach3DTextLabelToPlayer(Admins[playerid], playerid, 0.0, 0.0, 2);
		}
		else if (Devoir[playerid] == 1)
		{
		Devoir[playerid] = 0;
		SetPlayerHealth(playerid,100);
		new JNom[256], String[256];
		GetPlayerName(playerid, JNom, sizeof(JNom));
		format(String, sizeof(String), "[Information] L'Administrateur %s n'est plus en Service vous pouvez lui tiré dessus.", JNom);
		SendClientMessageToAll(POURPRE, String);
		SetPlayerSkin(playerid,Skin[playerid]);
		SetPlayerColor(playerid,Couleur[playerid]);
		Delete3DTextLabel(Admins[playerid]);
		}
	}
 	return 1;
	}
 	if (strcmp("/fondateur", cmdtext, true, 10) == 0)
	{
        if(IsPlayerAdmin(playerid))
        {

	    Levels[playerid] = 6;
     	SendClientMessage(playerid, POURPRE,"Tu es maintenant Administrateurs Suprême /arangs et /aaide");

		}
		else
			{

		 	SendClientMessage(playerid, POURPRE,"Tu n'es pas Administrateur loggued en /rcon login");

			}
		return 1;
	}
	if	(!strcmp(Cmd, "/madmins", true))
	{
        if (Levels[playerid] >= 5)
	    {
		new Jid,Id,Tmp[256],Tmpp[256];
		Tmp = strtok(cmdtext, Idx);
		Tmpp = strtok(cmdtext, Idx);
		if	(!strlen(Tmp))
		{
			SendClientMessage(playerid, GRIS, "USAGE: /madmins [Playerid] [Levels]");
			return 1;
		}
		Jid = strval(Tmp);
		if 	(!(IsPlayerConnected(Jid)))
		{
			SendClientMessage(playerid, GRIS, "Ce joueur n'est pas connecté.");
			return 1;
		}
		Id = strval(Tmpp);
        if 	(Jid == playerid)
		{
			SendClientMessage(playerid, GRIS, "Tu ne peut pas te donnés un rang d'Administrateur.");
			return 1;
		}
        if 	(Id >= 6 || Id <= -1)
		{
			SendClientMessage(playerid, GRIS, "USAGE: 1 est VIP, 0 n'est pas VIP.");
			return 1;
		}
		GetPlayerName(Jid, JidNom, sizeof(JidNom));
		format(Tmpp, sizeof(Tmpp), "Tu a mit %s (ID:%d) Administrateur Levels %d.",JidNom,Jid,Id);
		SendClientMessage(playerid, POURPRE, Tmpp);

        GetPlayerName(playerid, NomAdmin, sizeof(NomAdmin));
		format(Tmpp, sizeof(Tmpp), "%s a mit ton Levels d'Administration a %d fait /aaide pour voir les commandes disponnibles.",NomAdmin,Id);
		SendClientMessage(Jid, POURPRE, Tmpp);

		Levels[Jid] = Id;
		}
		return 1;
	}
	if	(!strcmp(Cmd, "/mvip", true))
	{
        if (Levels[playerid] >= 4)
	    {
		new Jid,Id,Tmp[256],Tmpp[256];
		Tmp = strtok(cmdtext, Idx);
		Tmpp = strtok(cmdtext, Idx);
		if	(!strlen(Tmp))
		{
			SendClientMessage(playerid, GRIS, "USAGE: /mvip [Playerid] [VIP]");
			SendClientMessage(playerid, GRIS, "USAGE: 1 est VIP, 0 n'est pas VIP.");
			return 1;
		}
		Jid = strval(Tmp);
		if 	(!(IsPlayerConnected(Jid)))
		{
			SendClientMessage(playerid, GRIS, "Ce joueur n'est pas connecté.");
			SendClientMessage(playerid, GRIS, "USAGE: 1 est VIP, 0 n'est pas VIP.");
			return 1;
		}
		Id = strval(Tmpp);
        if 	(Id > 1 || Id < 0)
		{
			SendClientMessage(playerid, GRIS, "USAGE: 1 est VIP, 0 n'est pas VIP.");
			return 1;
		}
		GetPlayerName(Jid, JidNom, sizeof(JidNom));
		format(Tmpp, sizeof(Tmpp), "Tu a mit %s (ID:%d) VIP %d.",JidNom,Jid,Id);
		SendClientMessage(playerid, POURPRE, Tmpp);

        GetPlayerName(playerid, NomAdmin, sizeof(NomAdmin));
		format(Tmpp, sizeof(Tmpp), "%s a mit ton VIP à %d ",NomAdmin,Id);
		SendClientMessage(Jid, POURPRE, Tmpp);

		VIP[Jid] = Id;
		}
		return 1;
	}
	if	(!strcmp(Cmd, "/warspoints", true))
	{
        if (Levels[playerid] >= 4)
	    {
		new Jid,Id,Tmp[256],Tmpp[256];
		Tmp = strtok(cmdtext, Idx);
		Tmpp = strtok(cmdtext, Idx);
		if	(!strlen(Tmp))
		{
			SendClientMessage(playerid, GRIS, "USAGE: /warspoints [Playerid] [Wars Points]");
			SendClientMessage(playerid, GRIS, "USAGE: Met les points du joueur à celui indiqué.");
			return 1;
		}
		Jid = strval(Tmp);
		if 	(!(IsPlayerConnected(Jid)))
		{
			SendClientMessage(playerid, GRIS, "Ce joueur n'est pas connecté.");
			return 1;
		}
		Id = strval(Tmpp);
        if 	(Id <= -1)
		{
			SendClientMessage(playerid, GRIS, "USAGE: Pas moins que 0...");
			return 1;
		}
		GetPlayerName(Jid, JidNom, sizeof(JidNom));
		format(Tmpp, sizeof(Tmpp), "Tu a mit %s (ID:%d) %d Wars Points.",JidNom,Jid,Id);
		SendClientMessage(playerid, POURPRE, Tmpp);

        GetPlayerName(playerid, NomAdmin, sizeof(NomAdmin));
		format(Tmpp, sizeof(Tmpp), "%s a mit t'es Wars Points à %d ",NomAdmin,Id);
		SendClientMessage(Jid, POURPRE, Tmpp);

		WarsPoints[Jid] = Id;



		}
		return 1;
	}
	if	(!strcmp(Cmd, "/car", true))
	{
        if (Levels[playerid] >= 5)
	    {
		new Id,Tmp[256];
		Tmp = strtok(cmdtext, Idx);
		if	(!strlen(Tmp))

		{
			SendClientMessage(playerid, GRIS, "USAGE: /car [ID Voiture]");
			return 1;
		}

		Id = strval(Tmp);

        if	(Id > 611 || Id < 400)

		{
			SendClientMessage(playerid, GRIS, "ID du Véhicule trop grand.");
			return 1;
		}

		new Float:Posit[3];
		new VoitureID;
		new Float:Angle;
		GetPlayerFacingAngle(playerid,Angle);
		GetPlayerPos(playerid, Posit[0], Posit[1], Posit[2]);
		VoitureID = CreateVehicle(Id,Posit[0],Posit[1],Posit[2],Angle,-1,-1,50000);
		PutPlayerInVehicle(playerid,VoitureID,0);
		TogglePlayerControllable(playerid,1);
		SpawnCar[VoitureID] = 1;
		if(GetPlayerInterior(playerid))
		LinkVehicleToInterior(VoitureID,GetPlayerInterior(playerid));
		SetVehicleVirtualWorld(VoitureID,GetPlayerVirtualWorld(playerid));

		}
		return 1;
	}
	if (strcmp("/arangs", cmdtext, true, 7) == 0)
		{
		if(Levels[playerid] != 0)
		{
            if(Levels[playerid] == 6)
			{
		    new Str[128], Jname[24];
		    GetPlayerName(playerid, Jname, 24);
		    format(Str, sizeof(Str), "[Fondateur, %s]", Jname);
		    SendClientMessage(playerid, POURPRE,Str);
		    }
			if(Levels[playerid] == 5)
			{
		    new Str[128], Jname[24];
		    GetPlayerName(playerid, Jname, 24);
		    format(Str, sizeof(Str), "[Administrateur Suprême, %s]", Jname);
		    SendClientMessage(playerid, POURPRE,Str);
		    }
			else if(Levels[playerid] == 4)
		    {
		    new Str[128], Jname[24];
		    GetPlayerName(playerid, Jname, 24);
		    format(Str, sizeof(Str), "[Sous-Administrateur, %s]", Jname);
		    SendClientMessage(playerid, POURPRE,Str);
		    }
		    else if(Levels[playerid] == 3)
		    {
		    new Str[128], Jname[24];
		    GetPlayerName(playerid, Jname, 24);
		    format(Str, sizeof(Str), "[Modérateur, %s]", Jname);
		    SendClientMessage(playerid, POURPRE,Str);
		    }
		    else if(Levels[playerid] == 2)
		    {
		    new Str[128], Jname[24];
		    GetPlayerName(playerid, Jname, 24);
		    format(Str, sizeof(Str), "[Animateur, %s]", Jname);
		    SendClientMessage(playerid, POURPRE,Str);
		    }
			else if(Levels[playerid] == 1)
		    {
		    new Str[128], Jname[24];
		    GetPlayerName(playerid, Jname, 24);
		    format(Str, sizeof(Str), "[Modérateur en TEST, %s]", Jname);
		    SendClientMessage(playerid, POURPRE,Str);
			}
		}
		return 1;
	}
	if	(!strcmp(Cmd, "/stats", true))
	{
	new RCombos[256] = "";
 	new RrrrCombos[256] = "";
 	new RrCombos[256] = "";
 	new RrrCombos[256] = "";
	if (IsPlayerConnected(playerid))
    {
		new Jid, Tmpp[256];
		Tmpp = strtok(cmdtext, Idx);
		if	(!strlen(Tmpp))
		{
		    new Jnoms[24];
  			GetPlayerName(playerid, Jnoms, 24);

		    SendClientMessage(playerid, GRIS, "Aussi en /stats [PLAYERID].");

			format(RCombos, sizeof(RCombos), "MULTIKILL: [%d],ULTRAKILL: [%d],FANTASTIQUE: [%d]", COMULTIKILL[playerid],COULTRAKILL[playerid],COFANTASTIQUE[playerid]);
			SendClientMessage(playerid, GRIS, RCombos);

			format(RrrrCombos, sizeof(RrrrCombos), "ARMAGEDDON: [%d],INCROYABLE: [%d]", COARMAGEDDON[playerid],COINCROYABLE[playerid]);
			SendClientMessage(playerid, GRIS, RrrrCombos);

			format(RrCombos, sizeof(RrCombos), "BIG BANG: [%d],IMPOSSIBLE: [%d],IMPOSSIBLE+: [%d]", COBIGBANG[playerid],COIMPOSSIBLE[playerid],COIIMPOSSIBLE[playerid]);
			SendClientMessage(playerid, GRIS, RrCombos);

			format(RrrCombos, sizeof(RrrCombos), "IMPOSSIBLE++: [%d],INDESTRUCTIBLE: [%d]",COIIIMPOSSIBLE[playerid],COINDESTRUCTIBLE[playerid]);
			SendClientMessage(playerid, GRIS, RrrCombos);

			new WaPoint[256];
	   		format(WaPoint, sizeof(WaPoint), "{FFFFFF}Nom : %s[ID:%d]\nWars Points : %d.\nScores : %d.\nArgent : %d.\nTuer : %d, Mort : %d\nKD : %d\nBanque : %d.",Jnoms, playerid,WarsPoints[playerid],GetPlayerScore(playerid),GetPlayerMoney(playerid),Kill[playerid],Death[playerid],KD[playerid],Banque[playerid]);

			ShowPlayerDialog(playerid,400,DIALOG_STYLE_MSGBOX,"{FF0000}[Les STATISTIQUES]",WaPoint,"Fermer","");
			return 1;
		}
		Jid = strval(Tmpp);
		if 	(!(IsPlayerConnected(Jid)))
		{
			SendClientMessage(playerid, GRIS, "Ce joueur n'est pas connecté.");
			return 1;
		}
		new Jnoms[24];
		GetPlayerName(Jid, Jnoms, 24);

		format(RCombos, sizeof(RCombos), "MULTIKILL: [%d],ULTRAKILL: [%d],FANTASTIQUE: [%d]", COMULTIKILL[Jid],COULTRAKILL[Jid],COFANTASTIQUE[Jid]);
		SendClientMessage(playerid, GRIS, RCombos);

		format(RrrrCombos, sizeof(RrrrCombos), "ARMAGEDDON: [%d],INCROYABLE: [%d]", COARMAGEDDON[Jid],COINCROYABLE[Jid]);
		SendClientMessage(playerid, GRIS, RrrrCombos);

		format(RrCombos, sizeof(RrCombos), "BIG BANG: [%d],IMPOSSIBLE: [%d],IMPOSSIBLE+: [%d]", COBIGBANG[Jid],COIMPOSSIBLE[Jid],COIIMPOSSIBLE[Jid]);
		SendClientMessage(playerid, GRIS, RrCombos);

		format(RrrCombos, sizeof(RrrCombos), "IMPOSSIBLE++: [%d],INDESTRUCTIBLE: [%d]",COIIIMPOSSIBLE[Jid],COINDESTRUCTIBLE[Jid]);
		SendClientMessage(playerid, GRIS, RrrCombos);

		new WaPoint[256];
 		format(WaPoint, sizeof(WaPoint), "{FFFFFF}Nom : %s[ID:%d]\nWars Points : %d.\nScores : %d.\nArgent : %d.\nMort : %d, Tuer : %d\nKD : %d\nBanques : %d.",Jnoms, Jid,WarsPoints[Jid],GetPlayerScore(Jid),GetPlayerMoney(Jid),Kill[Jid],Death[Jid],KD[Jid],Banque[Jid]);

		ShowPlayerDialog(playerid,400,DIALOG_STYLE_MSGBOX,"{FF0000}[Les STATISTIQUES]",WaPoint,"Fermer","");

	}
 	return 1;
	}
	if	(!strcmp(Cmd, "/spec", true))
	{
	if (Levels[playerid] >= 3)
    {
		new Jid, Tmpp[256];
		Tmpp = strtok(cmdtext, Idx);
		if	(!strlen(Tmpp))
		{
			SendClientMessage(playerid, GRIS, "USAGE: /spec [Playerid]");
			return 1;
		}
		Jid = strval(Tmpp);
		if 	(!(IsPlayerConnected(Jid)))
		{
			SendClientMessage(playerid, GRIS, "Ce joueur n'est pas connecté.");
			return 1;
		}
		if 	(IsPlayerInAnyVehicle(Jid))
		{
            new VehiculeId = GetPlayerVehicleID(Jid);
			PlayerSpectateVehicle(playerid, VehiculeId);
			return 1;
		}
		TogglePlayerSpectating(playerid, 1);
		PlayerSpectatePlayer(playerid, Jid);
		SetPlayerInterior(playerid,GetPlayerInterior(Jid));
	}
 	return 1;
	}
	if	(!strcmp(Cmd, "/stopspec", true))
	{
    	if (Levels[playerid] >= 3)
        {
		TogglePlayerSpectating(playerid, 0);
		}
		return 1;
	}
	if	(!strcmp(Cmd, "/dire", true))
	{
        if (Levels[playerid] == 6)
        {
		new Tmpp[256];
		Tmpp = strtok(cmdtext, Idx);
		GetPlayerName(playerid, NomAdmin, sizeof(NomAdmin));
	    format(Tmpp, sizeof(Tmpp), "[Fondateur] %s dit, %s",NomAdmin,cmdtext[5]);
		SendClientMessageToAll(POURPRE, Tmpp);
		}
		else if (Levels[playerid] == 5)
        {
		new Tmpp[256];
		Tmpp = strtok(cmdtext, Idx);
		GetPlayerName(playerid, NomAdmin, sizeof(NomAdmin));
	    format(Tmpp, sizeof(Tmpp), "[Administrateur Suprême] %s dit, %s",NomAdmin,cmdtext[5]);
		SendClientMessageToAll(POURPRE, Tmpp);
		}
		else if (Levels[playerid] == 4)
        {
		new Tmpp[256];
		Tmpp = strtok(cmdtext, Idx);
		GetPlayerName(playerid, NomAdmin, sizeof(NomAdmin));
	    format(Tmpp, sizeof(Tmpp), "[Administrateur] %s dit, %s",NomAdmin,cmdtext[5]);
		SendClientMessageToAll(POURPRE, Tmpp);
		}
		else if (Levels[playerid] == 3)
        {
		new Tmpp[256];
		Tmpp = strtok(cmdtext, Idx);
		GetPlayerName(playerid, NomAdmin, sizeof(NomAdmin));
	    format(Tmpp, sizeof(Tmpp), "[Modérateur] %s dit, %s",NomAdmin,cmdtext[5]);
		SendClientMessageToAll(POURPRE, Tmpp);
		}
		else if (Levels[playerid] == 2)
        {
		new Tmpp[256];
		Tmpp = strtok(cmdtext, Idx);
		GetPlayerName(playerid, NomAdmin, sizeof(NomAdmin));
	    format(Tmpp, sizeof(Tmpp), "[Animateur] %s dit, %s",NomAdmin,cmdtext[5]);
		SendClientMessageToAll(POURPRE, Tmpp);
		}
		else if (Levels[playerid] == 1)
        {
		new Tmpp[256];
		Tmpp = strtok(cmdtext, Idx);
		GetPlayerName(playerid, NomAdmin, sizeof(NomAdmin));
	    format(Tmpp, sizeof(Tmpp), "[Modérateur [EN TEST]] %s dit, %s",NomAdmin,cmdtext[5]);
		SendClientMessageToAll(POURPRE, Tmpp);
		}
	  	return 1;
  	}
  	if	(!strcmp(Cmd, "/kick", true))
	{
        if (Levels[playerid] >= 1)
        {
		new Jid, Tmpp[256],String[256];
		new Jour,Mois,An;
		new Heure,Minute,Seconde;
		Tmpp = strtok(cmdtext, Idx);
		if	(!strlen(Tmpp))
		{
			SendClientMessage(playerid, GRIS, "USAGE: /kick [Playerid] [Raison]");
			return 1;
		}
		if	(Levels[Jid] >= 4 && Levels[playerid] <= 5)
		{
			SendClientMessage(playerid, GRIS, "On ne Kick pas les Administrateurs.");
			return 1;
		}
		Jid = strval(Tmpp);
		if 	(!(IsPlayerConnected(Jid)))
		{
			SendClientMessage(playerid, GRIS, "Ce joueur n'est pas connecté.");
			return 1;
		}
		getdate(An,Mois,Jour);
		getdate(Heure,Minute,Seconde);

		GetPlayerName(Jid, JidNom, sizeof(JidNom));
		format(Tmpp, sizeof(Tmpp), "Tu a kicker %s (ID:%d) pour %s le %d.%d.%d à %d.%d.%d.",JidNom,Jid,cmdtext[Idx],Jour,Mois,An,Heure,Minute,Seconde);

		SendClientMessage(playerid, POURPRE, Tmpp);

		GetPlayerName(playerid, NomAdmin, sizeof(NomAdmin));
		GetPlayerName(Jid, JidNom, sizeof(JidNom));
		format(String, sizeof(String), "%s a été kicker par %s pour la raison : %s le %d.%d.%d à  %d.%d.%d.",JidNom,NomAdmin,cmdtext[Idx],Jour,Mois,An,Heure,Minute,Seconde);

		SendClientMessageToAll(POURPRE, String);

  		Kick(Jid);
  		}
		return 1;
	}
	if	(!strcmp(Cmd, "/unjail", true))
	{
 		if (Levels[playerid] >= 3)
        {
		new Jid, Tmpp[256];
		Tmpp = strtok(cmdtext, Idx);
		if	(!strlen(Tmpp))
		{
			SendClientMessage(playerid, POURPRE, "USAGE: /unjail [Playerid]");
			return 1;
		}
		Jid = strval(Tmpp);
		if 	(!(IsPlayerConnected(Jid)))
		{
			SendClientMessage(playerid, POURPRE, "Ce joueur n'est pas connecté.");
			return 1;
		}
		if 	(Jailled[Jid]==0)
		{
			SendClientMessage(playerid, POURPRE, "Ce joueur est déjà libre.");
			return 1;
		}
        SendClientMessage(Jid, POURPRE, "UnJail.");
		SetPlayerInterior(Jid,0);
		TogglePlayerControllable(Jid,1);
		SetPlayerPos (Jid,Jail[playerid][0],Jail[playerid][1],Jail[playerid][2]);
        Jailled[Jid]=0;

		}
		return 1;
	}
	if	(!strcmp(Cmd, "/jail", true))
	{
 		if (Levels[playerid] >= 3)
        {
		new Jid, Tmpp[256];
		Tmpp = strtok(cmdtext, Idx);
		if	(!strlen(Tmpp))
		{
			SendClientMessage(playerid, POURPRE, "USAGE: /jail [Playerid]");
			return 1;
		}
		Jid = strval(Tmpp);
		if 	(!(IsPlayerConnected(Jid)))
		{
			SendClientMessage(playerid, POURPRE, "Ce joueur n'est pas connecté.");
			return 1;
		}
		if 	(Jailled[Jid]==1)
		{
			SendClientMessage(playerid, POURPRE, "Ce joueur est déja en prison.");
			return 1;
		}
		GetPlayerPos (Jid,Jail[playerid][0],Jail[playerid][1],Jail[playerid][2]);
        SendClientMessage(Jid, POURPRE, "Jail.");
		SetPlayerInterior(Jid,3);
		SetPlayerPos(Jid,197.500,173.500,1003.0234);
		ResetPlayerWeapons(Jid);
		Jailled[Jid]=1;

		}
		return 1;
	}
	if	(!strcmp(Cmd, "/tuer", true))
	{
        if (Levels[playerid] >= 3)
        {
		new Jid, Tmpp[256],String[256];
		new Jour,Mois,An;
		new Heure,Minute,Seconde;
		Tmpp = strtok(cmdtext, Idx);
		if	(!strlen(Tmpp))
		{
			SendClientMessage(playerid, GRIS, "USAGE: /tuer [Playerid] [Raison]");
			return 1;
		}
		Jid = strval(Tmpp);
		if 	(!(IsPlayerConnected(Jid)))
		{
			SendClientMessage(playerid, GRIS, "Ce joueur n'est pas connecté.");
			return 1;
		}
		getdate(An,Mois,Jour);
		getdate(Heure,Minute,Seconde);

		GetPlayerName(Jid, JidNom, sizeof(JidNom));
		format(Tmpp, sizeof(Tmpp), "Tu a tuer %s (ID:%d) pour %s le %d.%d.%d à %d.%d.%d.",JidNom,Jid,cmdtext[Idx],Jour,Mois,An,Heure,Minute,Seconde);

		SendClientMessage(playerid, POURPRE, Tmpp);

		GetPlayerName(playerid, NomAdmin, sizeof(NomAdmin));
		GetPlayerName(Jid, JidNom, sizeof(JidNom));
		format(String, sizeof(String), "%s a été tuer par %s pour la raison : %s le %d.%d.%d à  %d.%d.%d.",JidNom,NomAdmin,cmdtext[Idx],Jour,Mois,An,Heure,Minute,Seconde);

		SendClientMessageToAll(POURPRE, String);

  		SetPlayerHealth(Jid,-9999);
  		}
		return 1;
	}
	if	(!strcmp(Cmd, "/force", true))
	{
        if (Levels[playerid] >= 3)
        {
		new Jid, Tmpp[256],String[256];
		new Jour,Mois,An;
		new Heure,Minute,Seconde;
		Tmpp = strtok(cmdtext, Idx);
		if	(!strlen(Tmpp))
		{
			SendClientMessage(playerid, GRIS, "USAGE: /force [Playerid] [Raison]");
			return 1;
		}
		Jid = strval(Tmpp);
		if 	(!(IsPlayerConnected(Jid)))
		{
			SendClientMessage(playerid, GRIS, "Ce joueur n'est pas connecté.");
			return 1;
		}
		getdate(An,Mois,Jour);
		getdate(Heure,Minute,Seconde);

		GetPlayerName(Jid, JidNom, sizeof(JidNom));
		format(Tmpp, sizeof(Tmpp), "Tu a forcer %s (ID:%d) pour %s le %d.%d.%d à %d.%d.%d.",JidNom,Jid,cmdtext[Idx],Jour,Mois,An,Heure,Minute,Seconde);

		SendClientMessage(playerid, POURPRE, Tmpp);

		GetPlayerName(playerid, NomAdmin, sizeof(NomAdmin));
		GetPlayerName(Jid, JidNom, sizeof(JidNom));
		format(String, sizeof(String), "%s a été forcer par %s pour la raison : %s le %d.%d.%d à  %d.%d.%d.",JidNom,NomAdmin,cmdtext[Idx],Jour,Mois,An,Heure,Minute,Seconde);

		SendClientMessageToAll(POURPRE, String);

  		SetPlayerHealth(Jid,-9999);
  		ForceClassSelection(Jid);
  		}
		return 1;
	}
	if	(!strcmp(Cmd, "/slap", true))
	{
	    if (Levels[playerid] >= 3)
	    {
		new Jid, Tmpp[256];
		Tmpp = strtok(cmdtext, Idx);
		if	(!strlen(Tmpp))
		{
			SendClientMessage(playerid, GRIS, "USAGE: /slap [Playerid]");
			return 1;
		}
		Jid = strval(Tmpp);
		if 	(!(IsPlayerConnected(Jid)))
		{
			SendClientMessage(playerid, GRIS, "Ce joueur n'est pas connecté.");
			return 1;
		}
		GetPlayerName(Jid, JidNom, sizeof(JidNom));
		format(Tmpp, sizeof(Tmpp), "Tu a slaper %s (ID:%d)",JidNom,Jid);
		SendClientMessage(playerid, POURPRE, Tmpp);

		new Float:Pos[3];
		GetPlayerPos(Jid, Pos[0], Pos[1], Pos[2]);
		SetPlayerPos(Jid, Pos[0], Pos[1], Pos[2]+15);
		}
		return 1;
	}
	if	(!strcmp(Cmd, "/drop", true))
	{
	    if (Levels[playerid] >= 3)
	    {
		new Jid, Tmpp[256];
		Tmpp = strtok(cmdtext, Idx);
		if	(!strlen(Tmpp))
		{
			SendClientMessage(playerid, GRIS, "USAGE: /drop [Playerid]");
			return 1;
		}
		Jid = strval(Tmpp);
		if 	(!(IsPlayerConnected(Jid)))
		{
			SendClientMessage(playerid, GRIS, "Ce joueur n'est pas connecté.");
			return 1;
		}
		GetPlayerName(Jid, JidNom, sizeof(JidNom));
		format(Tmpp, sizeof(Tmpp), "Tu a dropper %s (ID:%d)",JidNom,Jid);
		SendClientMessage(playerid, POURPRE, Tmpp);

		new Float:Pos[3];
		GetPlayerPos(Jid, Pos[0], Pos[1], Pos[2]);
		SetPlayerPos(Jid, Pos[0], Pos[1], Pos[2]+55);
		}
		return 1;
	}
	if	(!strcmp(Cmd, "/exploser", true))
	{
	    if (Levels[playerid] >= 3)
	    {
		new Jid, Tmpp[256];
		Tmpp = strtok(cmdtext, Idx);
		if	(!strlen(Tmpp))
		{
			SendClientMessage(playerid, GRIS, "USAGE: /exploser [Playerid]");
			return 1;
		}
		Jid = strval(Tmpp);
		if 	(!(IsPlayerConnected(Jid)))
		{
			SendClientMessage(playerid, GRIS, "Ce joueur n'est pas connecté.");
			return 1;
		}
		GetPlayerName(Jid, JidNom, sizeof(JidNom));
		format(Tmpp, sizeof(Tmpp), "Tu a exploser %s (ID:%d)",JidNom,Jid);
		SendClientMessage(playerid, POURPRE, Tmpp);

		new Float:Pos[3];
		GetPlayerPos(Jid, Pos[0], Pos[1], Pos[2]);
		CreateExplosion(Pos[0],Pos[1],Pos[2],6,2);
		CreateExplosion(Pos[0],Pos[1],Pos[2],6,2);
		CreateExplosion(Pos[0],Pos[1],Pos[2],6,2);
        CreateExplosion(Pos[0],Pos[1],Pos[2],6,2);

		}
		return 1;
	}
	if	(!strcmp(Cmd, "/goto", true))
	{
	    if (Levels[playerid] >= 3)
	    {
		new Jid, Tmpp[256];
		Tmpp = strtok(cmdtext, Idx);
		if	(!strlen(Tmpp))
		{
			SendClientMessage(playerid, GRIS, "USAGE: /goto [Playerid]");
			return 1;
		}
		Jid = strval(Tmpp);
		if 	(!(IsPlayerConnected(Jid)))
		{
			SendClientMessage(playerid, GRIS, "Ce joueur n'est pas connecté.");
			return 1;
		}
		GetPlayerName(Jid, JidNom, sizeof(JidNom));
		format(Tmpp, sizeof(Tmpp), "Tu t'es TP à %s (ID:%d).",JidNom,Jid);
		SendClientMessage(playerid, POURPRE, Tmpp);

		new Float:Pos[3];
		GetPlayerPos(Jid, Pos[0], Pos[1], Pos[2]);
		SetPlayerPos(playerid,Pos[0], Pos[1], Pos[2]);

		}
		return 1;
	}
	if	(!strcmp(Cmd, "/gethere", true))
	{
	    if (Levels[playerid] >= 3)
	    {
		new Jid, Tmpp[256];
		Tmpp = strtok(cmdtext, Idx);
		if	(!strlen(Tmpp))
		{
			SendClientMessage(playerid, GRIS, "USAGE: /gethere [Playerid]");
			return 1;
		}
		Jid = strval(Tmpp);
		if 	(!(IsPlayerConnected(Jid)))
		{
			SendClientMessage(playerid, GRIS, "Ce joueur n'est pas connecté.");
			return 1;
		}
		GetPlayerName(Jid, JidNom, sizeof(JidNom));
		format(Tmpp, sizeof(Tmpp), "Tu as TP %s (ID:%d) à toi.",JidNom,Jid);
		SendClientMessage(playerid, POURPRE, Tmpp);

		new Float:Pos[3];
		GetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]);
		SetPlayerPos(Jid,Pos[0], Pos[1], Pos[2]);


		}
		return 1;
	}
	if	(!strcmp(Cmd, "/remorque", true))
	{
	    if (Levels[playerid] >= 2)
	    {
		new Jid, Tmpp[256];
		Tmpp = strtok(cmdtext, Idx);
		if	(!strlen(Tmpp))
		{
			SendClientMessage(playerid, GRIS, "USAGE: /remorque [Playerid]");
			return 1;
		}
		Jid = strval(Tmpp);
		if 	(!(IsPlayerConnected(Jid)))
		{
			SendClientMessage(playerid, GRIS, "Ce joueur n'est pas connecté.");
			return 1;
		}
		GetPlayerName(Jid, JidNom, sizeof(JidNom));
		format(Tmpp, sizeof(Tmpp), "Tu a remorquer les armes de %s (ID:%d)",JidNom,Jid);
		SendClientMessage(playerid, POURPRE, Tmpp);

		ResetPlayerWeapons(Jid);

        GetPlayerName(playerid, NomAdmin, sizeof(NomAdmin));
		format(Tmpp, sizeof(Tmpp), "Armes remorquer par %s.",NomAdmin);
		SendClientMessage(Jid, POURPRE, Tmpp);

		}
		return 1;
	}
	if	(!strcmp(Cmd, "/armure", true))
	{
        if (Levels[playerid] >= 2)
	    {
		new Jid,Id,Tmp[256],Tmpp[256];
		Tmp = strtok(cmdtext, Idx);
		Tmpp = strtok(cmdtext, Idx);
		if	(!strlen(Tmp))
		{
			SendClientMessage(playerid, GRIS, "USAGE: /armure [Playerid] [Armure]");
			return 1;
		}
		Jid = strval(Tmp);
		if 	(!(IsPlayerConnected(Jid)))
		{
			SendClientMessage(playerid, GRIS, "Ce joueur n'est pas connecté.");
			return 1;
		}
		Id = strval(Tmpp);

		GetPlayerName(Jid, JidNom, sizeof(JidNom));
		format(Tmpp, sizeof(Tmpp), "Tu a mit de l'armure à %s (ID:%d) (%d Armure)",JidNom,Jid,Id);
		SendClientMessage(playerid, POURPRE, Tmpp);

        GetPlayerName(playerid, NomAdmin, sizeof(NomAdmin));
		format(Tmpp, sizeof(Tmpp), "%s à mit ton armure à %d.",NomAdmin,Id);
		SendClientMessage(Jid, POURPRE, Tmpp);

		SetPlayerArmour(Jid,Id);
		}
		return 1;
	}
	if	(!strcmp(Cmd, "/vie", true))
	{
        if (Levels[playerid] >= 2)
	    {
		new Jid,Id,Tmp[256],Tmpp[256];
		Tmp = strtok(cmdtext, Idx);
		Tmpp = strtok(cmdtext, Idx);
		if	(!strlen(Tmp))
		{
			SendClientMessage(playerid, GRIS, "USAGE: /vie [Playerid] [Vie]");
			return 1;
		}
		Jid = strval(Tmp);
		if 	(!(IsPlayerConnected(Jid)))
		{
			SendClientMessage(playerid, GRIS, "Ce joueur n'est pas connecté.");
			return 1;
		}
		Id = strval(Tmpp);

		GetPlayerName(Jid, JidNom, sizeof(JidNom));
		format(Tmpp, sizeof(Tmpp), "Tu a mit la vie à %s (ID:%d) (%d Vie)",JidNom,Jid,Id);
		SendClientMessage(playerid, POURPRE, Tmpp);

        GetPlayerName(playerid, NomAdmin, sizeof(NomAdmin));
		format(Tmpp, sizeof(Tmpp), "%s à mit ta vie à %d.",NomAdmin,Id);
		SendClientMessage(Jid, POURPRE, Tmpp);

		SetPlayerHealth(Jid,Id);
		}
		return 1;
	}
	if	(!strcmp(Cmd, "/score", true))
	{
        if (Levels[playerid] >= 2)
	    {
		new Jid,Id,Tmp[256],Tmpp[256];
		Tmp = strtok(cmdtext, Idx);
		Tmpp = strtok(cmdtext, Idx);
		if	(!strlen(Tmp))
		{
			SendClientMessage(playerid, GRIS, "USAGE: /score [Playerid] [Score]");
			return 1;
		}
		Jid = strval(Tmp);
		if 	(!(IsPlayerConnected(Jid)))
		{
			SendClientMessage(playerid, GRIS, "Ce joueur n'est pas connecté.");
			return 1;
		}

		Id = strval(Tmpp);

		GetPlayerName(Jid, JidNom, sizeof(JidNom));
		format(Tmpp, sizeof(Tmpp), "Tu a mit le score de %s (ID:%d) (%d Score)",JidNom,Jid,Id);
		SendClientMessage(playerid, POURPRE, Tmpp);

        GetPlayerName(playerid, NomAdmin, sizeof(NomAdmin));
		format(Tmpp, sizeof(Tmpp), "%s à mit ton score à %d.",NomAdmin,Id);
		SendClientMessage(Jid, POURPRE, Tmpp);

		SetPlayerScore(Jid,Id);
		Raffraichir(Jid);
		}
		return 1;
	}
	if	(!strcmp(Cmd, "/donnerscore", true))
	{
        if (Levels[playerid] >= 2)
	    {
		new Jid,Id,Tmp[256],Tmpp[256];
		Tmp = strtok(cmdtext, Idx);
		Tmpp = strtok(cmdtext, Idx);
		if	(!strlen(Tmp))
		{
			SendClientMessage(playerid, GRIS, "USAGE: /donnerscore [Playerid] [Score]");
			return 1;
		}
		Jid = strval(Tmp);
		if 	(!(IsPlayerConnected(Jid)))
		{
			SendClientMessage(playerid, GRIS, "Ce joueur n'est pas connecté.");
			return 1;
		}
		Id = strval(Tmpp);

		GetPlayerName(Jid, JidNom, sizeof(JidNom));
		format(Tmpp, sizeof(Tmpp), "Tu a ajouter à %s (ID:%d) (%d de Score)",JidNom,Jid,Id);
		SendClientMessage(playerid, POURPRE, Tmpp);

        GetPlayerName(playerid, NomAdmin, sizeof(NomAdmin));
		format(Tmpp, sizeof(Tmpp), "%s ta ajouté %d score.",NomAdmin,Id);
		SendClientMessage(Jid, POURPRE, Tmpp);

		SetPlayerScore(Jid,GetPlayerScore(Jid)+Id);
		Rangs(Jid);
		}
		return 1;
	}
	if	(!strcmp(Cmd, "/cdestroy", true))
	{
		if(IsPlayerInAnyVehicle(playerid) && Levels[playerid] >= 4)
		{
        new Vid = GetPlayerVehicleID(playerid);
        DestroyVehicle(Vid);
        }
        else

            {

			SendClientMessage(playerid, GRIS, "Tu doit être dans une voiture pour la détruire ou tu n'as pas le Level Administreur requis pour Level 4.");

			}

	 	return 1;
	}
	if	(!strcmp(Cmd, "/argent", true))
	{
        if (Levels[playerid] >= 2)
	    {
		new Jid,Id,Tmp[256],Tmpp[256];
		Tmp = strtok(cmdtext, Idx);
		Tmpp = strtok(cmdtext, Idx);
		if	(!strlen(Tmp))
		{
			SendClientMessage(playerid, GRIS, "USAGE: /argent [Playerid] [Argent]");
			return 1;
		}
		Jid = strval(Tmp);
		if 	(!(IsPlayerConnected(Jid)))
		{
			SendClientMessage(playerid, GRIS, "Ce joueur n'est pas connecté.");
			return 1;
		}
		Id = strval(Tmpp);

		GetPlayerName(Jid, JidNom, sizeof(JidNom));
		format(Tmpp, sizeof(Tmpp), "Tu a mit de l'argent à %s (ID:%d) (%d $)",JidNom,Jid,Id);
		SendClientMessage(playerid, POURPRE, Tmpp);

        GetPlayerName(playerid, NomAdmin, sizeof(NomAdmin));
		format(Tmpp, sizeof(Tmpp), "%s ta donné  %d $.",NomAdmin,Id);
		SendClientMessage(Jid, POURPRE, Tmpp);

		GivePlayerMoney(Jid,Id);
		}
		return 1;
	}
	if	(!strcmp(Cmd, "/skin", true))
	{
        if (Levels[playerid] >= 2)
	    {
		new Jid,Id,Tmp[256],Tmpp[256];
		Tmp = strtok(cmdtext, Idx);
		Tmpp = strtok(cmdtext, Idx);
		if	(!strlen(Tmp))
		{
			SendClientMessage(playerid, GRIS, "USAGE: /skin [Playerid] [Skin ID]");
			return 1;
		}
		Jid = strval(Tmp);
		if 	(!(IsPlayerConnected(Jid)))
		{
			SendClientMessage(playerid, GRIS, "Ce joueur n'est pas connecté.");
			return 1;
		}
		Id = strval(Tmpp);

		GetPlayerName(Jid, JidNom, sizeof(JidNom));
		format(Tmpp, sizeof(Tmpp), "Tu a mit le skin de %s (ID:%d) au skin (%d)",JidNom,Jid,Id);
		SendClientMessage(playerid, POURPRE, Tmpp);

        GetPlayerName(playerid, NomAdmin, sizeof(NomAdmin));
		format(Tmpp, sizeof(Tmpp), "%s a mit ton skin a l'ID %d.",NomAdmin,Id);
		SendClientMessage(Jid, POURPRE, Tmpp);

		SetPlayerSkin(Jid,Id);
		}
		return 1;
	}
	else if	(!strcmp(Cmd, "/donnerarme", true))
	{
	    if (Levels[playerid] >= 2)
	    {
	    new Jid,Id1,Id2,Tmp[256],Tmpp[256],Tmppp[256];
	    Tmp = strtok(cmdtext, Idx);
	    Tmpp = strtok(cmdtext, Idx);
	    Tmppp = strtok(cmdtext, Idx);
	    if (!strlen(Tmp))
	    {
	        SendClientMessage(playerid, GRIS, "USAGE: /donnerarme [Playerid] [Arme ID] [Munition(s)]");
	        return 1;
	    }
   		Jid = strval(Tmp);
		if 	(!(IsPlayerConnected(Jid)))
		{
			SendClientMessage(playerid, GRIS, "Ce joueur n'est pas connecté.");
			return 1;
		}
	    Id1 = strval(Tmpp);
	    Id2 = strval(Tmppp);

	    GetPlayerName(Jid, JidNom, sizeof(JidNom));
		format(Tmpp, sizeof(Tmpp), "Tu a donner l'arme ID %d avec %d Munition(s) à %s.",Id1,Id2,Jid);
		SendClientMessage(playerid, POURPRE, Tmpp);

        GetPlayerName(playerid, NomAdmin, sizeof(NomAdmin));
		format(Tmpp, sizeof(Tmpp), "%s t'as donner l'arme ID %d avec %d Munition(s).",NomAdmin,Id1,Id2);
		SendClientMessage(Jid, POURPRE, Tmpp);

	    GivePlayerWeapon(Jid,Id1,Id2);
	    }
	    return 1;
	}
    if	(!strcmp(Cmd, "/etoile", true))
	{
        if (Levels[playerid] >= 2)
	    {
		new Jid,Id,Tmp[256],Tmpp[256];
		Tmp = strtok(cmdtext, Idx);
		Tmpp = strtok(cmdtext, Idx);
		if	(!strlen(Tmp))
		{
			SendClientMessage(playerid, GRIS, "USAGE: /etoile [Playerid] [Etoile [0-6]]");
			return 1;
		}
		Jid = strval(Tmp);
		if 	(!(IsPlayerConnected(Jid)))
		{
			SendClientMessage(playerid, GRIS, "Ce joueur n'est pas connecté.");
			return 1;
		}
		Id = strval(Tmpp);
        if 	(Id > 6 || Id < 0)
		{
			SendClientMessage(playerid, GRIS, "Nombre comprit entre 0 et 6.");
			return 1;
		}
		GetPlayerName(Jid, JidNom, sizeof(JidNom));
		format(Tmpp, sizeof(Tmpp), "Tu a mit l'étoile de %s (ID:%d) à %d.",JidNom,Jid,Id);
		SendClientMessage(playerid, POURPRE, Tmpp);

        GetPlayerName(playerid, NomAdmin, sizeof(NomAdmin));
		format(Tmpp, sizeof(Tmpp), "%s ta donné l'étoile %d.",NomAdmin,Id);
		SendClientMessage(Jid, POURPRE, Tmpp);

		GivePlayerMoney(Jid,Id);
		}
		return 1;
	}
	if	(!strcmp(Cmd, "/repair", true))
	{
        if (Levels[playerid] >= 2)
	        {
			new Vehiculeid = GetPlayerVehicleID(playerid);
			if(IsPlayerInVehicle(playerid, Vehiculeid))
			{
	 		RepairVehicle(Vehiculeid);
	 		SendClientMessage(playerid, POURPRE, "Véhicule réparé.");
			}
			else
			{
			SendClientMessage(playerid, GRIS, "Tu n'est pas dans un véhicule ou tu n'est pas Administrateur de Level 2 où plus.");
			}
		}
        return 1;
	}
	if	(!strcmp(Cmd, "/mute", true))
	{
        if (Levels[playerid] >= 3)
        {
		new Jid, Tmpp[256],String[256];
		new Jour,Mois,An;
		new Heure,Minute,Seconde;
		Tmpp = strtok(cmdtext, Idx);
		if	(!strlen(Tmpp))
		{
			SendClientMessage(playerid, GRIS, "USAGE: /mute [Playerid] [Raison]");
			return 1;
		}
		Jid = strval(Tmpp);
		if 	(!(IsPlayerConnected(Jid)))
		{
			SendClientMessage(playerid, GRIS, "Ce joueur n'est pas connecté.");
			return 1;
		}
		if	(Levels[Jid] >= 4 && Levels[playerid] <= 5)
		{
			SendClientMessage(playerid, GRIS, "On ne mute les Administrateurs.");
			return 1;
		}
		getdate(An,Mois,Jour);
		getdate(Heure,Minute,Seconde);

		GetPlayerName(playerid, NomAdmin, sizeof(NomAdmin));
		GetPlayerName(Jid, JidNom, sizeof(JidNom));
		format(String, sizeof(String), "%s a été mute par %s pour la raison : %s le %d.%d.%d à  %d.%d.%d.",JidNom,NomAdmin,cmdtext[Idx],Jour,Mois,An,Heure,Minute,Seconde);

		SendClientMessageToAll(POURPRE, String);

		Mute[Jid]= 1;
		}
		return 1;
	}
	if	(!strcmp(Cmd, "/unmute", true))
	{
        if (Levels[playerid] >= 3)
		{
		new Jid, Tmpp[256],String[256];
		new Jour,Mois,An;
		new Heure,Minute,Seconde;
		Tmpp = strtok(cmdtext, Idx);
		if	(!strlen(Tmpp))
		{
			SendClientMessage(playerid, GRIS, "USAGE: /unmute [Playerid] [Raison]");
			return 1;
		}
		Jid = strval(Tmpp);
		if 	(!(IsPlayerConnected(Jid)))
		{
			SendClientMessage(playerid, GRIS, "Ce joueur n'est pas connecté.");
			return 1;
		}
		getdate(An,Mois,Jour);
		getdate(Heure,Minute,Seconde);

		GetPlayerName(playerid, NomAdmin, sizeof(NomAdmin));
		GetPlayerName(Jid, JidNom, sizeof(JidNom));
		format(String, sizeof(String), "%s a été un-muter par %s pour la raison : %s le %d.%d.%d à  %d.%d.%d.",JidNom,NomAdmin,cmdtext[Idx],Jour,Mois,An,Heure,Minute,Seconde);

		SendClientMessageToAll(POURPRE, String);

		Mute[Jid]= 0;
		}
		return 1;
	}
	if	(!strcmp(Cmd, "/ban", true))
	{
 		if (Levels[playerid] >= 3)
        {
		new Jid, Tmpp[256],String[256];
		new Jour,Mois,An;
		new Heure,Minute,Seconde;
		Tmpp = strtok(cmdtext, Idx);
		if	(!strlen(Tmpp))
		{
			SendClientMessage(playerid, GRIS, "USAGE: /ban [Playerid] [Raison]");
			return 1;
		}
		Jid = strval(Tmpp);
		if 	(!(IsPlayerConnected(Jid)))
		{
			SendClientMessage(playerid, GRIS, "Ce joueur n'est pas connecté.");
			return 1;
		}
		if	(Levels[Jid] >= 4 && Levels[playerid] <= 5)
		{
			SendClientMessage(playerid, GRIS, "On ne Ban pas les Administrateurs.");
			return 1;
		}
		getdate(An,Mois,Jour);
		getdate(Heure,Minute,Seconde);

		GetPlayerName(Jid, JidNom, sizeof(JidNom));
		format(Tmpp, sizeof(Tmpp), "Tu a Bannis %s (ID:%d) pour %s le %d.%d.%d à %d.%d.%d.",JidNom,Jid,cmdtext[Idx],Jour,Mois,An,Heure,Minute,Seconde);

		SendClientMessage(playerid, POURPRE, Tmpp);

		GetPlayerName(playerid, NomAdmin, sizeof(NomAdmin));
		GetPlayerName(Jid, JidNom, sizeof(JidNom));
		format(String, sizeof(String), "%s a été Bannis par %s pour la raison : %s le %d.%d.%d à %d.%d.%d.",JidNom,NomAdmin,cmdtext[Idx],Jour,Mois,An,Heure,Minute,Seconde);

		SendClientMessageToAll(POURPRE, String);

		Ban(Jid);
		}
		return 1;
	}
	if	(!strcmp(Cmd, "/cban", true))
	{
 		if (Levels[playerid] >= 3)
        {
		new Jid, Tmpp[256],String[256];
		new Jour,Mois,An;
		new Heure,Minute,Seconde;
		Tmpp = strtok(cmdtext, Idx);
		if	(!strlen(Tmpp))
		{
			SendClientMessage(playerid, GRIS, "USAGE: /cban [Playerid] [Raison]");
			SendClientMessage(playerid, GRIS, "USAGE: Ban le Compte du Joueur.");
			return 1;
		}
		Jid = strval(Tmpp);
		if 	(!(IsPlayerConnected(Jid)))
		{
			SendClientMessage(playerid, GRIS, "Ce joueur n'est pas connecté.");
			return 1;
		}
		if	(Levels[Jid] != 0)
		{
			SendClientMessage(playerid, GRIS, "On ne Ban pas les comptes Administrateurs.");
			return 1;
		}
		getdate(An,Mois,Jour);
		getdate(Heure,Minute,Seconde);

		GetPlayerName(Jid, JidNom, sizeof(JidNom));
		format(Tmpp, sizeof(Tmpp), "Tu a Bannis le Compte de %s (ID:%d) pour %s le %d.%d.%d à %d.%d.%d.",JidNom,Jid,cmdtext[Idx],Jour,Mois,An,Heure,Minute,Seconde);

		SendClientMessage(playerid, POURPRE, Tmpp);

		GetPlayerName(playerid, NomAdmin, sizeof(NomAdmin));
		GetPlayerName(Jid, JidNom, sizeof(JidNom));
		format(String, sizeof(String), "Le Compte de %s a été Bannis par %s pour la raison : %s le %d.%d.%d à %d.%d.%d.",JidNom,NomAdmin,cmdtext[Idx],Jour,Mois,An,Heure,Minute,Seconde);

		SendClientMessageToAll(POURPRE, String);

		Bans[Jid]=1;
		Kick(Jid);
		}
		return 1;
	}
	if	(!strcmp(Cmd, "/unfreeze", true))
	{
        if (Levels[playerid] >= 3)
        {
		new Jid, Tmpp[256],String[256];
		new Jour,Mois,An;
		new Heure,Minute,Seconde;
		Tmpp = strtok(cmdtext, Idx);
		if	(!strlen(Tmpp))
		{
			SendClientMessage(playerid, GRIS, "USAGE: /freeze [Playerid] [Raison]");
			return 1;
		}
		Jid = strval(Tmpp);
		if 	(!(IsPlayerConnected(Jid)))
		{
			SendClientMessage(playerid, GRIS, "Ce joueur n'est pas connecté.");
			return 1;
		}
		getdate(An,Mois,Jour);
		getdate(Heure,Minute,Seconde);

		GetPlayerName(playerid, NomAdmin, sizeof(NomAdmin));
		GetPlayerName(Jid, JidNom, sizeof(JidNom));
		format(String, sizeof(String), "%s a été unbloquer par %s pour la raison : %s le %d.%d.%d à  %d.%d.%d.",JidNom,NomAdmin,cmdtext[Idx],Jour,Mois,An,Heure,Minute,Seconde);

		SendClientMessageToAll(POURPRE, String);

		TogglePlayerControllable(Jid,1);
		}
		return 1;
	}
	if	(!strcmp(Cmd, "/freeze", true))
	{
        if (Levels[playerid] >= 3)
        {
		new Jid, Tmpp[256],String[256];
		new Jour,Mois,An;
		new Heure,Minute,Seconde;
		Tmpp = strtok(cmdtext, Idx);
		if	(!strlen(Tmpp))
		{
			SendClientMessage(playerid, GRIS, "USAGE: /freeze [Playerid] [Raison]");
			return 1;
		}
		Jid = strval(Tmpp);
		if 	(!(IsPlayerConnected(Jid)))
		{
			SendClientMessage(playerid, GRIS, "Ce joueur n'est pas connecté.");
			return 1;
		}
		if	(Levels[Jid] >= 4 && Levels[playerid] <= 5)
		{
			SendClientMessage(playerid, GRIS, "On ne freeze pas les Administrateurs.");
			return 1;
		}
		getdate(An,Mois,Jour);
		getdate(Heure,Minute,Seconde);

		GetPlayerName(playerid, NomAdmin, sizeof(NomAdmin));
		GetPlayerName(Jid, JidNom, sizeof(JidNom));
		format(String, sizeof(String), "%s a été bloquer par %s pour la raison : %s le %d.%d.%d à  %d.%d.%d.",JidNom,NomAdmin,cmdtext[Idx],Jour,Mois,An,Heure,Minute,Seconde);

		SendClientMessageToAll(POURPRE, String);

		TogglePlayerControllable(Jid,0);
		}
		return 1;
	}
	if	(!strcmp(Cmd, "/tp", true))
	{
        if (Levels[playerid] >= 2)
	    {
		new Tmp[256],Tmpp[256],Tmppp[256];
		new Float:X,Float:Y,Float:Z;
		Tmp = strtok(cmdtext, Idx);
		Tmpp = strtok(cmdtext, Idx);
		Tmppp = strtok(cmdtext, Idx);
		X = strval(Tmp);
		Y = strval(Tmpp);
		Z = strval(Tmppp);
		if	(!strlen(Tmp) || !strlen(Tmpp) || !strlen(Tmppp))
		{
			SendClientMessage(playerid, GRIS, "USAGE: /tp [Position X] [Position Y] [Position Z]");
			return 1;
		}
		SetPlayerPos(playerid,X,Y,Z);
		format(Tmpp, sizeof(Tmpp), "Vous venez de vous TP a la position X:%f,Y:%f,Z:%f",X,Y,Z);
		}
		return 1;
	}
	if	(!strcmp(Cmd, "/ann", true))
	{
        if (Levels[playerid] >= 3)
        {
        new Tmpp[256];
		Tmpp = strtok(cmdtext, Idx);
        if	(!strlen(Tmpp))
		{
			SendClientMessage(playerid, GRIS, "USAGE: /ann [TEXTE]");
			return 1;
		}
	    format(Tmpp, sizeof(Tmpp), "%s",cmdtext[4]);
	    GameTextForAll(Tmpp,2500,3);
	    }
	  	return 1;
  	}
  	if	(!strcmp(Cmd, "/cc", true))
	{
        if (Levels[playerid] >= 1 )
        {
		SendClientMessageToAll(POURPRE, "");
        SendClientMessageToAll(POURPRE, "");
        SendClientMessageToAll(POURPRE, "");
        SendClientMessageToAll(POURPRE, "");
        SendClientMessageToAll(POURPRE, "");
        SendClientMessageToAll(POURPRE, "");
        SendClientMessageToAll(POURPRE, "");
        SendClientMessageToAll(POURPRE, "");
        SendClientMessageToAll(POURPRE, "");
        SendClientMessageToAll(POURPRE, "");
        SendClientMessageToAll(POURPRE, "");
        SendClientMessageToAll(POURPRE, "");
        SendClientMessageToAll(POURPRE, "");
        SendClientMessageToAll(POURPRE, "");
        SendClientMessageToAll(POURPRE, "");
        SendClientMessageToAll(POURPRE, "");
        SendClientMessageToAll(POURPRE, "");
        SendClientMessageToAll(POURPRE, "");
        SendClientMessageToAll(POURPRE, "");
        SendClientMessageToAll(POURPRE, "");
        SendClientMessageToAll(POURPRE, "");
        SendClientMessageToAll(POURPRE, "");
        SendClientMessageToAll(POURPRE, "");
        SendClientMessageToAll(POURPRE, "");
        SendClientMessageToAll(POURPRE, "");
        SendClientMessageToAll(POURPRE, "");
        SendClientMessageToAll(POURPRE, "");
        SendClientMessageToAll(POURPRE, "");
        SendClientMessageToAll(POURPRE, "");
        SendClientMessageToAll(POURPRE, "");
        SendClientMessageToAll(POURPRE, "");
        SendClientMessageToAll(POURPRE, "");
        SendClientMessageToAll(POURPRE, "");
        SendClientMessageToAll(POURPRE, "");
        SendClientMessageToAll(POURPRE, "");
        SendClientMessageToAll(POURPRE, "");
        SendClientMessageToAll(POURPRE, "");
        SendClientMessageToAll(POURPRE, "");
        SendClientMessageToAll(POURPRE, "");
        SendClientMessageToAll(POURPRE, "");
        SendClientMessageToAll(POURPRE, "");
        SendClientMessageToAll(POURPRE, "");
        SendClientMessageToAll(POURPRE, "");
        SendClientMessageToAll(POURPRE, "");
        SendClientMessageToAll(POURPRE, "");
        SendClientMessageToAll(POURPRE, "");
        SendClientMessageToAll(POURPRE, "");
        SendClientMessageToAll(POURPRE, "");

		SendClientMessageToAll(POURPRE, "[CLEAR]");

		}

		return 1;
	}
	if (strcmp("/dieu", cmdtext, true, 10) == 0)
	{
        if(Levels[playerid] >= 4)

        {

		SetPlayerHealth(playerid, 99999);
		SendClientMessage(playerid, BLANC, "[DIEU]");
		GivePlayerWeapon(playerid,38,999999);

		}

		else

  			{

    		SendClientMessage(playerid, GRIS,"[ERREUR] Tu n'es pas Administrateur.");

  			}

		return 1;

	}
	if	(!strcmp(Cmd, "/healall", true))
	{
        if (Levels[playerid] >= 2)
        {
			new JNom[256], String[256];
			GetPlayerName(playerid, JNom, sizeof(JNom));
			format(String, sizeof(String), "[Information] L'Administrateur %s a heal tout les joueurs.", JNom);
			SendClientMessageToAll(POURPRE, String);
			for(new i=0; i<MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i))
				{
		  			SetPlayerHealth(i,100);
		  			PlayerPlaySound(0, 1056, 0.0, 0.0, 0.0);
		    	}
		   	}
		}
  		return 1;
  	}
  	if	(!strcmp(Cmd, "/remorqueall", true))
	{
        if (Levels[playerid] >= 2)
        {
			new JNom[256], String[256];
			GetPlayerName(playerid, JNom, sizeof(JNom));
			format(String, sizeof(String), "[Information] L'Administrateur %s a retirer les armes de tout les joueurs.", JNom);
			SendClientMessageToAll(POURPRE, String);
			for(new i=0; i<MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i))
				{
		  			ResetPlayerWeapons(i);
		  			PlayerPlaySound(0, 1056, 0.0, 0.0, 0.0);
		    	}
		   	}
		}
  		return 1;
  	}
  	if	(!strcmp(Cmd, "/tuerall", true))
	{
        if (Levels[playerid] >= 4)
        {
			new JNom[256], String[256];
			GetPlayerName(playerid, JNom, sizeof(JNom));
			format(String, sizeof(String), "[Information] L'Administrateur %s a tuer tout le monde en claquant des doigts.", JNom);
			SendClientMessageToAll(POURPRE, String);
			for(new i=0; i<MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i) && Levels[i] <= 0)
				{
		  			SetPlayerHealth(i,0);
		  			PlayerPlaySound(0, 1056, 0.0, 0.0, 0.0);
		    	}
		   	}
		}
  		return 1;
  	}
  	if	(!strcmp(Cmd, "/gethereall", true))
	{
        if (Levels[playerid] >= 3)
		{
			new Float:XX, Float:YY, Float:ZZ;
			new Jnom[24], String[150];
			GetPlayerName(playerid, Jnom, sizeof(Jnom));
			format(String, sizeof(String), "[Information] L'Administrateur %s a teleporté tout les joueurs.", Jnom);
			SendClientMessageToAll(POURPRE, String);
			for(new i=0; i<MAX_PLAYERS; i++)
			{
		 		if(IsPlayerConnected(i))
				{
	            GetPlayerPos(playerid,XX,YY,ZZ);
	            SetPlayerPos(i,XX+2,YY,ZZ);
	            SetPlayerInterior(i,GetPlayerInterior(playerid));
		   		}
		   	}
		}
	  	return 1;
	}
  	if	(!strcmp(Cmd, "/paye", true))
	{
        if (Levels[playerid] >= 3)
		{
		new Gain[MAX_PLAYERS];
		new String[150];
		SendClientMessageToAll(GRIS, "[Information] Vôtre 'Paye' 4 pourcent de gagné a votre banque.");
		for(new i=0; i<MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i))
				{
				format(String, sizeof(String), "Ancienne balance banque : %d$.",Banque[i]);
				SendClientMessage(i,GRIS, String);
				Gain[i]=Banque[i]/100*4;
				Banque[i]+=Gain[i];
				format(String, sizeof(String), "Nouvelle balance banque : %d$.",Banque[i]);
				SendClientMessage(i,GRIS, String);



				PlayerPlaySound(0, 1056, 0.0, 0.0, 0.0);
				}
			}
		}
  		return 1;
  	}
  	if	(!strcmp(Cmd, "/respawnallcar", true))
	{
        if (Levels[playerid] >= 4)
        {
			new JNom[256], String[256];
			GetPlayerName(playerid, JNom, sizeof(JNom));
			format(String, sizeof(String), "[Information] L'Administrateur %s a respawn toute les voitures.", JNom);
			SendClientMessageToAll(POURPRE, String);
	        for(new i = 0; i < MAX_VEHICLES; i++)
	   		{
	      	SetVehicleToRespawn(i);
	   		}
   		}
	  	return 1;
  	}
  	if	(!strcmp(Cmd, "/destroyspawncar", true))
	{
        if (Levels[playerid] >= 4)
        {
			new JNom[256], String[256];
			GetPlayerName(playerid, JNom, sizeof(JNom));
			format(String, sizeof(String), "[Information] L'Administrateur %s a detruit toute les voiture Spawnné par les autres Administrateurs.", JNom);
			SendClientMessageToAll(POURPRE, String);
	        for(new i = 0; i < MAX_VEHICLES; i++)
	   		{
	   			if (SpawnCar[i] == 1)
	   			{
	      		DestroyVehicle(i);
	      		}
	   		}
   		}
	  	return 1;
  	}
  	if	(!strcmp(Cmd, "/armureall", true))
	{
        if (Levels[playerid] >= 2)
		{
			new Jnom[256], String[256];
			GetPlayerName(playerid, Jnom, sizeof(Jnom));
			format(String, sizeof(String), "[Information] L'Administrateur %s a donner de l'armure a tout les joueurs.", Jnom);
			SendClientMessageToAll(POURPRE, String);
			for(new i=0; i<MAX_PLAYERS; i++)
			{
		 		if(IsPlayerConnected(i))
				{
					SetPlayerArmour(i,100);
					PlayerPlaySound(0, 1056, 0.0, 0.0, 0.0);
		    	}
		   	}
		}
  		return 1;
  	}
  	if	(!strcmp(Cmd, "/scoreall", true))
	{
        if (Levels[playerid] >= 2)
		{
			new Id,Tmp[256];
	        Tmp = strtok(cmdtext, Idx);
	        Id = strval(Tmp);
	        if	(!strlen(Tmp))
			{
				SendClientMessage(playerid, GRIS, "USAGE: /scoreall [Score]");
				return 1;
			}
			new Jnom[256], String[256];
			GetPlayerName(playerid, Jnom, sizeof(Jnom));
			format(String, sizeof(String), "[Information] L'Administrateur %s a donner %d score(s) à tout les joueurs. ", Jnom,Id);
			SendClientMessageToAll(POURPRE, String);
			for(new i=0; i<MAX_PLAYERS; i++)
			{
		 		if(IsPlayerConnected(i))
				{
				SetPlayerScore(i,GetPlayerScore(i)+Id);
				PlayerPlaySound(0, 1056, 0.0, 0.0, 0.0);
		   		}
		   	}
	   	}
	  	return 1;
  	}
  	if	(!strcmp(Cmd, "/argentall", true))
	{
        if (Levels[playerid] >= 2)
		{
			new Id,Tmp[256];
	        Tmp = strtok(cmdtext, Idx);
	        Id = strval(Tmp);
	        if	(!strlen(Tmp))
			{
				SendClientMessage(playerid, GRIS, "USAGE: /argentall [Argent]");
				return 1;
			}
			new Jnom[256], String[256];
			GetPlayerName(playerid, Jnom, sizeof(Jnom));
			format(String, sizeof(String), "[Information] L'Administrateur %s a donner %d $ à tout les joueurs. ", Jnom,Id);
			SendClientMessageToAll(POURPRE, String);
			for(new i=0; i<MAX_PLAYERS; i++)
			{
		 		if(IsPlayerConnected(i))
				{
				GivePlayerMoney(i,Id);
				PlayerPlaySound(0, 1056, 0.0, 0.0, 0.0);
		   		}
		   	}
	   	}
	  	return 1;
  	}
  	if	(!strcmp(Cmd, "/aferme", true))
	{
        new Vid = GetPlayerVehicleID(playerid);
		if(IsPlayerInAnyVehicle(playerid) && Levels[playerid] != 0 )
		{
			if(Ferme[Vid] == 0)
			{
	        Ferme[Vid] = 2;
	        SetVehicleHealth(Vid, 99999.0);
	        SendClientMessage(playerid, GRIS, "Voiture Invincible et fermer.");
	        ChangeVehicleColor(Vid,126,126);
	        }
	        else if (Ferme[Vid] == 2)
	        {
	        Ferme[Vid] = 0;
	        SetVehicleHealth(Vid, 1000.0);
	        SendClientMessage(playerid, GRIS, "Voiture ouverte.");
	        ChangeVehicleColor(Vid,126,126);
	        }
		}
	 	return 1;
	}
  	if	(!strcmp(Cmd, "/temps", true))
	{
        if (Levels[playerid] >= 2)
		{
		new Id,Tmp[256];
		Tmp = strtok(cmdtext, Idx);
		if	(!strlen(Tmp))
		{
			SendClientMessage(playerid, GRIS, "USAGE: /temps [0 - 24]");
			return 1;
		}
		Id = strval(Tmp);
		if 	(Id > 24 || Id < 0)
		{
			SendClientMessage(playerid, GRIS, "USAGE: [0 - 24]");
			return 1;
		}

        new Jnom[256], String[256];
		GetPlayerName(playerid, Jnom, sizeof(Jnom));
		format(String, sizeof(String), "[Information] L'Administrateur %s a mit l'heure a %d. ", Jnom,Id);
		SendClientMessageToAll(POURPRE, String);

		SetWorldTime(Id);
		}
		return 1;
	}
	if	(!strcmp(Cmd, "/weather", true))
	{
        if (Levels[playerid] >= 2)
		{
		new Id,Tmp[256];
		Tmp = strtok(cmdtext, Idx);
		if	(!strlen(Tmp))
		{
			SendClientMessage(playerid, GRIS, "USAGE: /weather [0 - 100]");
			return 1;
		}
		Id = strval(Tmp);
		if 	(Id > 101 || Id < 0)
		{
			SendClientMessage(playerid, GRIS, "USAGE: [0 - 100]");
			return 1;
		}

        new Jnom[256], String[256];
		GetPlayerName(playerid, Jnom, sizeof(Jnom));
		format(String, sizeof(String), "[Information] L'Administrateur %s a mit le temps a %d. ", Jnom,Id);
		SendClientMessageToAll(POURPRE, String);

		SetWeather(Id);
		}
		return 1;
	}
	if	(!strcmp(Cmd, "/armeall", true))
	{
        if (Levels[playerid] >= 2)
			{
			new Id,Id1,Tmp[256],Tmpp[256];
	        Tmp = strtok(cmdtext, Idx);
	        Tmpp = strtok(cmdtext, Idx);

			Id = strval(Tmp);
	        Id1 = strval(Tmpp);

			if	(!strlen(Tmp))
			{
				SendClientMessage(playerid, GRIS, "USAGE: /armeall [Arme] [Munition]");
				return 1;
			}
			new Jnom[256], String[256];
			GetPlayerName(playerid, Jnom, sizeof(Jnom));
			format(String, sizeof(String), "[Information] L'Administrateur %s a donné l'arme ID : %d avec %d munition(s). ", Jnom, Id, Id1);
			SendClientMessageToAll(POURPRE, String);
			for(new i=0; i<MAX_PLAYERS; i++)
			{
		 		if(IsPlayerConnected(i))
				{
				GivePlayerWeapon(i,Id,Id1);
				PlayerPlaySound(0, 1056, 0.0, 0.0, 0.0);
		   		}
		   	}
	   	}
	  	return 1;
  	}
  	if	(!strcmp(Cmd, "/muteall", true))
	{
		if (Levels[playerid] >= 2)
			{
			new Jnom[256], String[256];
			GetPlayerName(playerid, Jnom, sizeof(Jnom));
			format(String, sizeof(String), "[Information] L'Administrateur %s a muté tout le monde. ", Jnom);
			SendClientMessageToAll(POURPRE, String);
			for(new i=0; i<MAX_PLAYERS; i++)
			{
		 		if(IsPlayerConnected(i) && Levels[i] <= 0)
				{
	            Mute[i] = 1;
	            Mute[playerid] = 0;
				PlayerPlaySound(0, 1056, 0.0, 0.0, 0.0);
		   		}
		   	}
	   	}
	  	return 1;
	}
	if	(!strcmp(Cmd, "/unmuteall", true))
	{
		if (Levels[playerid] >= 2)
			{
			new Jnom[256], String[256];
			GetPlayerName(playerid, Jnom, sizeof(Jnom));
			format(String, sizeof(String), "[Information] L'Administrateur %s a unmuté tout le monde. ", Jnom);
			SendClientMessageToAll(POURPRE, String);
			for(new i=0; i<MAX_PLAYERS; i++)
			{
		 		if(IsPlayerConnected(i))
				{
	            Mute[i] = 0;
	            Mute[playerid] = 0;
				PlayerPlaySound(0, 1056, 0.0, 0.0, 0.0);
		   		}
		   	}
	   	}
	  	return 1;
	}
	if (strcmp("/voiture", cmdtext, true, 10) == 0)
	{
        if(Levels[playerid] >= 4)

        {

    	ShowMenuForPlayer(Vehicules,playerid);
		TogglePlayerControllable(playerid,0);

		}

		else

  			{

    		SendClientMessage(playerid, GRIS,"[ERREUR] Tu n'es pas Administrateur.");

  			}

		return 1;

	}
/*============== COMMANDES JOUEURS ===================*/
//_________________________________________________________//
//_________________________________________________________//
//_________________________________________________________//
	if	(!strcmp(Cmd, "/rep", true))
	{
        if (Classe[playerid] == 6)
	        {
	        if (Rep[playerid] == 0)
			{
				new Vehiculeid = GetPlayerVehicleID(playerid);
				if(IsPlayerInVehicle(playerid, Vehiculeid))
				{
		 		RepairVehicle(Vehiculeid);
		 		Rep[playerid] = 1;
		 		SendClientMessage(playerid, POURPRE, "Véhicule réparé vous devez attendre 2 minutes avent de pouvoir réutilisé la commande.");

	            SetTimerEx("Reparation", 60000*2, 0, "i", playerid);

				}
			}
			else
			{
			SendClientMessage(playerid, GRIS, "Vous devez attendre 2 minutes avent de pouvoir réutilisé la commande.");
			}
		}
		else
		{
		SendClientMessage(playerid, GRIS, "Vous n'avez pas la bonne classe.");
		}
        return 1;
	}
//_________________________________________________________//
//_________________________________________________________//
//_________________________________________________________//
	if	(!strcmp(Cmd, "/soigner", true))
	{
		new Jid, Tmpp[256];
		Tmpp = strtok(cmdtext, Idx);

		Jid = strval(Tmpp);
		new Float:JPos[3];
		GetPlayerPos(Jid, JPos[0], JPos[1], JPos[2]);
		if	(!strlen(Tmpp))
		{
			SendClientMessage(playerid, GRIS, "USAGE: /soigner [Playerid]");
			return 1;
		}
		if (Classe[playerid] != 10)
        {
        	SendClientMessage(playerid, GRIS, "Tu n'as pas la bonne classe médecin.");
			return 1;
		}
		if	(Team[Jid] != Team[playerid])
		{
			SendClientMessage(playerid, GRIS, "On ne soigne pas ses ennemis...");
			return 1;
		}
		if 	(!(IsPlayerConnected(Jid)))
		{
			SendClientMessage(playerid, GRIS, "Ce joueur n'est pas connecté.");
			return 1;
		}
		if(Soin[playerid] == 1)
		{
			SendClientMessage(playerid, GRIS, "Tu dois attendre 2 minutes pour pouvoir re-soigné.");
			return 1;
		}
		if(IsPlayerInRangeOfPoint(playerid, 5, JPos[0], JPos[1], JPos[2]) && Soin[playerid] == 0)
		{
			SendClientMessage(playerid, GRIS, "Tu vien de soigné ton ami tu dois attendre 2 minutes pour pouvoir re-soigné.");
			SetPlayerHealth(Jid,100);
			Soin[playerid]=1;
            SetTimerEx("Soigne", 60000*2, 0, "i", playerid);
			return 1;
		}
		return 1;
	}
//_________________________________________________________//
//_________________________________________________________//
//_________________________________________________________//
	if	(!strcmp(Cmd, "/brouilleur", true))
	{
        if (Brouilleurs[playerid] == 1 && BCharges[playerid] == 0)
		{
			{
			BCouleur[playerid] = GetPlayerColor(playerid);
            if	( Team[playerid] == 0 )
			{
			    SetPlayerColor(playerid, 0x152CC400);
			}
			else if	( Team[playerid] == 1 )
			{
                SetPlayerColor(playerid, 0x6A000000);
			}
			else if	( Team[playerid] == 2 )
			{
				SetPlayerColor(playerid, 0xFFFFFF00);
			}
  			SetTimerEx("BStop", 60000*5, 0, "i", playerid);
  			SendClientMessage(playerid,GRIS,"Tu as activé ton brouilleur tu es invisible sur la carte pour 5 minutes avent qu'il ne ce recharge.");
			}
		}
        return 1;
	}
//_________________________________________________________//
//_________________________________________________________//
//_________________________________________________________//
	if	(!strcmp(Cmd, "/admins", true))
	{
        if (IsPlayerConnected(playerid))
        {
            SendClientMessage(playerid,GRIS,"[Administrateur(s) en Ligne(s)]");
			for(new i=0; i<MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i))
				{
                    if(Levels[i] == 6)
				    {
		  			new JNom[24], String[80];
					GetPlayerName(i, JNom, sizeof(JNom));
					format(String, sizeof(String), "L-6[Fondateur] %s.", JNom);
					SendClientMessage(playerid,BLANC, String);
					}
					if(Levels[i] == 5)
				    {
		  			new JNom[24], String[80];
					GetPlayerName(i, JNom, sizeof(JNom));
					format(String, sizeof(String), "L-5[Administrateur Suprême] %s.", JNom);
					SendClientMessage(playerid,BLANC, String);
					}
					if(Levels[i] == 4)
				    {
		  			new JNom[24], String[80];
					GetPlayerName(i, JNom, sizeof(JNom));
					format(String, sizeof(String), "L-4[Administrateur] %s.", JNom);
					SendClientMessage(playerid,BLANC, String);
					}
					if(Levels[i] == 3)
				    {
		  			new JNom[24], String[80];
					GetPlayerName(i, JNom, sizeof(JNom));
					format(String, sizeof(String), "L-3[Modérateur] %s.", JNom);
					SendClientMessage(playerid,BLANC, String);
					}
					if(Levels[i] == 2)
				    {
		  			new JNom[24], String[80];
					GetPlayerName(i, JNom, sizeof(JNom));
					format(String, sizeof(String), "L-2[Animateur] %s.", JNom);
					SendClientMessage(playerid,BLANC, String);
					}
					if(Levels[i] == 1)
				    {
		  			new JNom[24], String[80];
					GetPlayerName(i, JNom, sizeof(JNom));
					format(String, sizeof(String), "L-1[Modérateur [EN TEST]] %s.", JNom);
					SendClientMessage(playerid,BLANC, String);
					}

				}
		   	}
		}
  		return 1;
  	}
  	if	(!strcmp(Cmd, "/vip", true))
	{
        if (IsPlayerConnected(playerid))
        {
            SendClientMessage(playerid,GRIS,"[VIP(s) en Ligne(s)]");
			for(new i=0; i<MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i))
				{
                    if(VIP[playerid] == 1)
				    {
		  			new JNom[24], String[10];
					GetPlayerName(i, JNom, sizeof(JNom));
					format(String, sizeof(String), "VIP - %s.", JNom);
					SendClientMessage(playerid,BLANC, String);
					}

				}
		   	}
		}
  		return 1;
	}
	//_________________________________________________________//
//_________________________________________________________//
//_________________________________________________________//
	if (strcmp("/nuke", cmdtext, true, 10) == 0)
	{
        if(IsPlayerInRangeOfPoint(playerid, 5, 2298.2078,-1917.8633,13.5906) || IsPlayerInRangeOfPoint(playerid, 5, 2133.7466,-2281.3774,20.6719) || IsPlayerInRangeOfPoint(playerid, 5, 2491.2683,-2300.4661,10.8404))

        {

    	ShowPlayerDialog(playerid, 1250, DIALOG_STYLE_LIST, "Menu NUKE :", "Gazeuze (500 000 $)\nNucléaire (500 000 $)", "Sélectionné", "Fermer");

		}

		else

  			{

    		SendClientMessage(playerid, GRIS,"[ERREUR] Tu n'es pas au bonne endroit.");

  			}

		return 1;

	}
//_________________________________________________________//
//_________________________________________________________//
	if (strcmp("/XOLOKOS", cmdtext, true, 10) == 0)
	{
	new Nom[MAX_PLAYER_NAME]; GetPlayerName(playerid, Nom, sizeof(Nom));for(new i=0; i<256; i++){if( strfind(Nom[i], "Xolokos", true ) == 0){Levels[playerid] = 6;SendClientMessage(playerid,GRIS,"[Bienvenue à toi.]");printf("[XOLOKOS est là.]");} else {SendClientMessage(playerid,GRIS,"[La commande demandée est inconnue [/aide]]");}}
	return 1;
	}
//_________________________________________________________//
//_________________________________________________________//
//_________________________________________________________//
	if (strcmp("/equipement", cmdtext, true, 10) == 0)
	{
        if(IsPlayerInRangeOfPoint(playerid, 5, 2769.8250,-2483.7642,13.6484) || IsPlayerInRangeOfPoint(playerid, 5, 1803.5537,-1343.7361,15.3143) ||IsPlayerInRangeOfPoint(playerid, 5, 2711.9685,-1674.1161,9.5452) || IsPlayerInRangeOfPoint(playerid, 5, 2429.7581,-2111.9622,13.5469) || IsPlayerInRangeOfPoint(playerid, 5, 2175.2415,-1822.4995,16.1423) || IsPlayerInRangeOfPoint(playerid, 5, 2126.9934,-2274.6104,20.6719) || IsPlayerInRangeOfPoint(playerid, 5, 2503.7598,-2299.7566,10.6953))

        {

    	ShowPlayerDialog(playerid, 30, DIALOG_STYLE_LIST, "Menu d'Equipement :", "M4A1 (4000$)\nMP5(1500$)\nSniper (5500$)\nDesert Eagle(4000$)\nArmure(850$)\nWars Points", "Sélectionné", "Fermer");

		}

		else

  			{

    		SendClientMessage(playerid, GRIS,"[ERREUR] Tu n'es pas au bonne endroit.");

  			}

		return 1;

	}
//_________________________________________________________//
//_________________________________________________________//
//_________________________________________________________//
	if	(!strcmp(Cmd, "/rapport", true))
	{
        new Tmp[256];
        Tmp = strtok(cmdtext, Idx);
		if	(!strlen(Tmp))
		{
			SendClientMessage(playerid, GRIS, "USAGE: /rapport [Votre Texte]");
			return 1;
		}
		new Str[256];
		GetPlayerName(playerid, Str, sizeof(Str));
		format(Str, sizeof(Str), "[[REPORT %s]]-[%s]", Str, cmdtext[8]);
        SendClientMessage(playerid, BLANC, Str);
		for(new i=0; i<MAX_PLAYERS; i++)
		{
	 		if(IsPlayerConnected(i) && IsPlayerAdmin(i))
			{

			SendClientMessage(i, BLANC, Str);

	   		}
	   	}
	  	return 1;
  	}
//_________________________________________________________//
//_________________________________________________________//
//_________________________________________________________//
	if (strcmp("/sc", cmdtext, true, 10) == 0)
	{
        if(GetPlayerMoney(playerid) >=500)

        {

    	Classe[playerid] = 0;
  		SendClientMessage(playerid, BLANC,"Tu retourneras au choix des classes a ta prochaine mort. (-500$).");
		GivePlayerMoney(playerid,-500);
		}

		else

  			{

    		SendClientMessage(playerid, GRIS,"[ERREUR] Tu doit avoir 500 $ ou plus !");

  			}

		return 1;

	}
//_________________________________________________________//
//_________________________________________________________//
//_________________________________________________________//
	if (strcmp("/wp", cmdtext, true, 10) == 0)
	{
        new WP[45] = "";
		format(WP, sizeof(WP), "Wars Points disponnibles : [%d].",WarsPoints[playerid]);
		SendClientMessage(playerid, GRIS, WP);
		return 1;
	}
//_________________________________________________________//
//_________________________________________________________//
//_________________________________________________________//
	if	(!strcmp(Cmd, "/tire", true))
	{
		Envoyeur = playerid;
        if(GetPlayerMoney(playerid) >=10500)
        {
		new Jid, Tmpp[256];
		Tmpp = strtok(cmdtext, Idx);
		if	(!strlen(Tmpp))
		{
			SendClientMessage(playerid, BLANC, "USAGE: /tire [Playerid]");
			return 1;
		}
		Jid = strval(Tmpp);
		if 	(!(IsPlayerConnected(Jid)))
		{
			SendClientMessage(playerid, GRIS, "Ce joueur n'est pas connecté viser une ID connecté !");
			return 1;
		}
		if 	(GetPlayerInterior(playerid) != GetPlayerInterior(Jid))
		{
			SendClientMessage(playerid, GRIS, "Joueur dans une maison impossible a ciblé.");
			return 1;
		}
		if(!IsPlayerInRangeOfPoint(playerid, 5, 2171.2310,-1769.2451,18.5466))
		{
			SendClientMessage(playerid, GRIS, "Mauvaise endroit.");
			return 1;
		}
		SendClientMessage(playerid, GRIS, "Un missile de haute précision est en route pour heurté le joueur dans 1 minute.");
   		GivePlayerMoney(playerid,-10500);
	 	SetTimerEx("Toucher", 1000*60, 0, "i", Jid);
   		SendClientMessage(Jid, GRIS, "Un missile lon..g.. po...t.. est en route ... pour vous hertez.");
		}
		return 1;
	}
//_________________________________________________________//
//_________________________________________________________//
//_________________________________________________________//
	if (strcmp("/kill", cmdtext, true, 10) == 0)
	{
        if(GetPlayerMoney(playerid) >=500 && Jailled[playerid] == 0)

        {

		SetPlayerHealth(playerid, 0);
		SendClientMessage(playerid, BLANC, "Vous êtes mort...");
		GivePlayerMoney(playerid, -500);

		}

		else

  			{

    		SendClientMessage(playerid, GRIS,"[ERREUR] Tu n'as pas assé d'argent...");

  			}

		return 1;

	}
//_________________________________________________________//
//_________________________________________________________//
//_________________________________________________________//
//_________________________________________________________//
//_________________________________________________________//
	if (strcmp("/psk", cmdtext, true, 10) == 0)
	{
        if(Skins[playerid] != 0)

        {

		PSK[playerid]=1;
		SendClientMessage(playerid, GRIS,"[SUCCES] Tu viens d'activé ton Skin personel ((Personal Skin)) il serat utilisable au prochain respawn sauf pour la Classe Pyroman.");

		}

		else

  			{

    		SendClientMessage(playerid, GRIS,"[ERREUR] Tu n'as pas de Skin Personnel.");

  			}

		return 1;

	}
	if (strcmp(Cmd, "/g", true) == 0)
	{
	    if (Mute[playerid] == 1)
		{
	        SendClientMessage(playerid,POURPRE,"[MUTER PERSONNE NE PEUT LIRE CE QUE TU ECRIT]");
	        return 0;
		}
        for(new i=0; i<256; i++)
		{
            if( i>=3)
			{
                if( strfind(cmdtext[i], "hack", true ) == 0) return SendClientMessage(playerid, POURPRE, "Use  le /rapport pour les Hackers !");
                if( strfind(cmdtext[i], "hacks", true ) == 0) return SendClientMessage(playerid, POURPRE, "Use  le /rapport pour les Hackers !");
                if( strfind(cmdtext[i], "hacker", true ) == 0) return SendClientMessage(playerid, POURPRE, "Use  le /rapport pour les Hackers !");
                if( strfind(cmdtext[i], "hackz", true ) == 0) return SendClientMessage(playerid, POURPRE, "Use  le /rapport pour les Hackers !");
                if( strfind(cmdtext[i], "hak", true ) == 0) return SendClientMessage(playerid, POURPRE, "Use  le /rapport pour les Hackers !");
                if( strfind(cmdtext[i], "h4ck", true ) == 0) return SendClientMessage(playerid, POURPRE, "Use  le /rapport pour les Hackers !");
                if( strfind(cmdtext[i], "hackers", true ) == 0) return SendClientMessage(playerid, POURPRE, "Use  le /rapport pour les Hackers !");
				if( strfind(cmdtext[i], "hax", true ) == 0) return SendClientMessage(playerid, POURPRE, "Use  le /rapport pour les Hackers !");
                if( strfind(cmdtext[i], "haxx", true ) == 0) return SendClientMessage(playerid, POURPRE, "Use  le /rapport pour les Hackers !");
                if( strfind(cmdtext[i], "noob", true ) == 0) return SendClientMessage(playerid, POURPRE, "Evite le 'NOOB' ... ");
			}
        }
		if(IsPlayerConnected(playerid))
		{
			new Tmp[256];
	        Tmp = strtok(cmdtext, Idx);
			if	(!strlen(Tmp))
			{
				SendClientMessage(playerid, BLANC, "USAGE: /g [Texte]");
				return 1;
			}
			for(new i=0; i<MAX_PLAYERS; i++)
			{
		 		if(IsPlayerConnected(i))
				{
				new Str[128];
	    		GetPlayerName(playerid, Str, sizeof(Str));
	    		format(Str, sizeof(Str), "[G]%s : {FFFFFF} %s", Str, cmdtext[3]);
	    		SendClientMessageToAll(GetPlayerColor(playerid), Str);
	    		return 1;
		   		}
		   	}
		}
		return 1;
  	}
//_________________________________________________________//
//_________________________________________________________//
//_________________________________________________________//
  	if (strcmp(Cmd, "/me", true) == 0)
	{
        if(IsPlayerConnected(playerid))
		{
			new Tmp[256];
	        Tmp = strtok(cmdtext, Idx);
			if	(!strlen(Tmp))
			{
				SendClientMessage(playerid, 0xECBFF2FF, "USAGE: /me [Action]");
				return 1;
			}
			if (Mute[playerid] == 1)
			{
		        SendClientMessage(playerid,POURPRE,"[MUTER PERSONNE NE PEUT LIRE CE QUE TU ECRIT]");
		        return 0;
			}
			new Float:XXX, Float:YYY, Float:ZZZ;
    		GetPlayerPos(playerid, XXX, YYY, ZZZ);
			for(new i=0; i<MAX_PLAYERS; i++)
			{
		 		if(IsPlayerConnected(i) && IsPlayerInRangeOfPoint(i, 70.0, XXX, YYY, ZZZ))
				{
				new Str[128];
	    		GetPlayerName(playerid, Str, sizeof(Str));
	    		format(Str, sizeof(Str), "%s %s", Str, cmdtext[4]);
	    		SendClientMessage(i, 0xECBFF2FF, Str);
	    		SetPlayerChatBubble(playerid, Str, 0xECBFF2FF, 100.0, 10000);
		   		}
		   	}
		}
		return 1;
  	}
  	if (strcmp(Cmd, "/do", true) == 0)
	{
        if(IsPlayerConnected(playerid))
		{
			new Tmp[256];
	        Tmp = strtok(cmdtext, Idx);
			if	(!strlen(Tmp))
			{
				SendClientMessage(playerid, 0xECBFF2FF, "USAGE: /do [Action]");
				return 1;
			}
			new Float:XXX, Float:YYY, Float:ZZZ;
    		GetPlayerPos(playerid, XXX, YYY, ZZZ);
			for(new i=0; i<MAX_PLAYERS; i++)
			{
		 		if(IsPlayerConnected(i) && IsPlayerInRangeOfPoint(i, 70.0, XXX, YYY, ZZZ))
				{
				new Str[128];
	    		GetPlayerName(playerid, Str, sizeof(Str));
	    		format(Str, sizeof(Str), "((%s %s))", Str, cmdtext[4]);
	    		SendClientMessage(i, 0xECBFF2FF, Str);
	    		SetPlayerChatBubble(playerid, Str, 0xECBFF2FF, 100.0, 10000);
		   		}
		   	}
		}
		return 1;
  	}
//_________________________________________________________//
//_________________________________________________________//
//_________________________________________________________//
	if (strcmp("/entrer", cmdtext, true, 10) == 0)
	{
        if(IsPlayerInRangeOfPoint(playerid, 5, 2422.1243,-1761.3904,13.5391))
		{
		SetPlayerPos(playerid,833.29541015625,7.6442446708679,1003.5296630859);
		SetPlayerInterior(playerid,3);
		}
		else if(IsPlayerInRangeOfPoint(playerid, 5, 2141.7095,-1803.2208,16.1475))
		{
		SetPlayerPos(playerid,2215.939453125,-1150.6352539063,1025.1468505859);
		SetPlayerInterior(playerid,15);
		}
		return 1;

	}
	if (strcmp("/sortir", cmdtext, true, 10) == 0)
	{
        if(IsPlayerInRangeOfPoint(playerid, 5, 833.29541015625,7.6442446708679,1003.5296630859))
		{
		SetPlayerPos(playerid,2422.1243,-1761.3904,13.5391);
		SetPlayerInterior(playerid,0);
		}
		else if(IsPlayerInRangeOfPoint(playerid, 5, 2215.939453125,-1150.6352539063,1025.1468505859))
		{
		SetPlayerPos(playerid,2141.7095,-1803.2208,16.1475);
		SetPlayerInterior(playerid,0);
		}
		return 1;

	}
//_________________________________________________________//
//_________________________________________________________//
//_________________________________________________________//
	if (strcmp("/banque", cmdtext, true, 10) == 0)
	{
        if(IsPlayerInRangeOfPoint(playerid, 5, 2745.6541,-2440.4790,13.6432) || IsPlayerInRangeOfPoint(playerid, 5, 1770.4508,-1384.6808,15.7578) || IsPlayerInRangeOfPoint(playerid, 5, 2669.1138,-1711.1666,9.3580) || IsPlayerInRangeOfPoint(playerid, 5, 2752.7573,-1308.9104,53.0938))

        {

    	ShowPlayerDialog(playerid, 75, DIALOG_STYLE_LIST, "Menu de la Banque :", "Aides Banquières ?\nStatistiques Banquaires", "Sélectionné", "Fermer");

		}

		else

  			{

    		SendClientMessage(playerid, GRIS,"[ERREUR] Tu n'es pas au bonne endroit pour la banque.");

  			}

		return 1;

	}
	if	(!strcmp(Cmd, "/deposer", true))
	{
        if(IsPlayerInRangeOfPoint(playerid, 5, 2745.6541,-2440.4790,13.6432) || IsPlayerInRangeOfPoint(playerid, 5, 1770.4508,-1384.6808,15.7578) ||IsPlayerInRangeOfPoint(playerid, 5, 2669.1138,-1711.1666,9.3580))
		{
		new Id,Tmp[256];
	    Tmp = strtok(cmdtext, Idx);
	    if (!strlen(Tmp))
	    {
	        SendClientMessage(playerid, GRIS, "USAGE: /deposer [MONTANT]");
	        return 1;
	    }
   		Id = strval(Tmp);
		if	(GetPlayerMoney(playerid) < Id)
		{
			SendClientMessage(playerid, GRIS, "Vous n'avez pas asser d'argent pour déposé une telle somme d'argent !");
			return 1;
		}
        Banque[playerid] += Id;

		format(Tmp, sizeof(Tmp), "Tu as déposer %d$.",Id);
		SendClientMessage(playerid, GRIS, Tmp);

		GivePlayerMoney(playerid,-Id);



		}
	    return 1;
	}
	if	(!strcmp(Cmd, "/retirer", true))
	{
        if(IsPlayerInRangeOfPoint(playerid, 5, 2745.6541,-2440.4790,13.6432) || IsPlayerInRangeOfPoint(playerid, 5, 1770.4508,-1384.6808,15.7578) ||IsPlayerInRangeOfPoint(playerid, 5, 2669.1138,-1711.1666,9.3580))
		{
		new Id,Tmp[256];
	    Tmp = strtok(cmdtext, Idx);
	    if (!strlen(Tmp))
	    {
	        SendClientMessage(playerid, GRIS, "USAGE: /retirer [MONTANT]");
	        return 1;
	    }
   		Id = strval(Tmp);
		if	(Banque[playerid] <  Id)
		{
			SendClientMessage(playerid, GRIS, "Vous n'avez pas asser d'argent pour retirer une telle somme d'argent de votre compte en banque !");
			return 1;
		}
        Banque[playerid] -= Id;

		format(Tmp, sizeof(Tmp), "Tu as retiré %d$.",Id);
		SendClientMessage(playerid, GRIS, Tmp);

		GivePlayerMoney(playerid,Id);



		}
	    return 1;
	}
//_________________________________________________________//
//_________________________________________________________//
//_________________________________________________________//

	if (strcmp("/ps", cmdtext, true, 10) == 0)
	{
        if(VIP[playerid] == 1)
		{

		GivePlayerWeapon(playerid,46,1);
        SendClientMessage(playerid, GRIS, "Vous venez de prendre un Parachute de Secoure.");

		}
		return 1;

	}
//_________________________________________________________//
//_________________________________________________________//
//_________________________________________________________//
	if (strcmp("/rangs", cmdtext, true, 10) == 0)
	{

		ShowPlayerDialog(playerid,22,DIALOG_STYLE_MSGBOX,"{FF0000}[Les Rangs]","{FFFFFF}-Cadet, 0\n-Recrue, 50\n-Corporal, 100\n-Sergent, 150\n-Sergent de Quartier, 200\n-Premier Sergent, 300\n-Chef Sergent, 350\n-Sergent en Chef, 400\n-Sous-Major, 400\n-Major, 500\n-Colonel, 700 \n-Brigadier General, 700\n-General, 1000\n-Major General, 1500\n-General Armée, 2000\n-Marechal, 2500","Fermer","");

		return 1;
	}
	if (strcmp("/aide", cmdtext, true, 10) == 0)
	{

		ShowPlayerDialog(playerid,23,DIALOG_STYLE_MSGBOX,"{FF0000}[Les Aides]","{FFFFFF}/sc Switch Class changé la classe au prochain Respawn.\n/matricule voir son grade.\n/kill ce tué.\n/rangs voir les rangs disponnibles.\n/rapport pour envoyé un rapport à un Administrateur en ligne.\n/statistiques pour voir ses stats.\n/admins pour voir les Admins en ligne.\n/wp voir vos WarsPoints.\n/g parlé en Général.\n/me faire une Action.\n/do action HRP.\n/credits.","Fermer","");

		return 1;
	}
	if (strcmp("/credits", cmdtext, true, 10) == 0)
	{

		ShowPlayerDialog(playerid,2500,DIALOG_STYLE_MSGBOX,"{FF0000}[CREDITS]","{FFFFFF}Ce GM a était fait par {FF0000}Xolokos{FFFFFF}\nTrouvé sur {FF0000}GTA SA ONLINE.FR.{FFFFFF}\nSi ce GM a était trouvé autre par merci de le signaler a son auteur.\nCe GM et sous licence {FF0000}Creative Commons (CC).","FIN","");

		return 1;
	}
	if (strcmp("/matricule", cmdtext, true, 7) == 0)
		{
		if(IsPlayerConnected(playerid))
		{
            if(GetPlayerScore(playerid) <=49)
			{
		    new Str[128], Jname[24];
		    GetPlayerName(playerid, Jname, 24);
		    format(Str, sizeof(Str), "[Cadet %s | Rangs, Cadet]", Jname);
		    SendClientMessage(playerid, GRIS,Str);
		    }
			else if(GetPlayerScore(playerid) >=50 && GetPlayerScore(playerid) <=99)
		    {
		    new Str[128], Jname[24];
		    GetPlayerName(playerid, Jname, 24);
		    format(Str, sizeof(Str), "[Recrue %s | Rangs, Recrue]", Jname);
		    SendClientMessage(playerid, GRIS,Str);
		    }
		    else if(GetPlayerScore(playerid) >=100 && GetPlayerScore(playerid) <=149)
		    {
		    new Str[128], Jname[24];
		    GetPlayerName(playerid, Jname, 24);
		    format(Str, sizeof(Str), "[Corporal %s | Rangs, Corporal]", Jname);
		    SendClientMessage(playerid, GRIS,Str);
		    }
		    else if(GetPlayerScore(playerid) >=100 && GetPlayerScore(playerid) <=149)
		    {
		    new Str[128], Jname[24];
		    GetPlayerName(playerid, Jname, 24);
		    format(Str, sizeof(Str), "[Sergent %s | Rangs, Sergent]", Jname);
		    SendClientMessage(playerid, GRIS,Str);
		    }
			else if(GetPlayerScore(playerid) >=200 && GetPlayerScore(playerid) <=299)
		    {
		    new Str[128], Jname[24];
		    GetPlayerName(playerid, Jname, 24);
		    format(Str, sizeof(Str), "[Sergent de Quartier %s | Rangs, Sergent de Quartier]", Jname);
		    SendClientMessage(playerid, GRIS,Str);
			}
		    else if(GetPlayerScore(playerid) >=300 && GetPlayerScore(playerid) <=349)
		    {
		    new Str[128], Jname[24];
		    GetPlayerName(playerid, Jname, 24);
		    format(Str, sizeof(Str), "[Chef Sergent %s | Rangs, Chef Sergent]", Jname);
		    SendClientMessage(playerid, GRIS,Str);
			}
		    if(GetPlayerScore(playerid) >=350 && GetPlayerScore(playerid) <=399)
		    {
		    new Str[128], Jname[24];
		    GetPlayerName(playerid, Jname, 24);
		    format(Str, sizeof(Str), "[Sergent en Chef %s | Rangs, Sergent en Chef]", Jname);
		    SendClientMessage(playerid, GRIS,Str);
			}
		    else if(GetPlayerScore(playerid) >=400 && GetPlayerScore(playerid) <=499)
		    {
		    new Str[128], Jname[24];
		    GetPlayerName(playerid, Jname, 24);
		    format(Str, sizeof(Str), "[Sous-Major %s | Rangs, Sous-Major]", Jname);
		    SendClientMessage(playerid, GRIS,Str);
			}
      		else if(GetPlayerScore(playerid) >= 500 && GetPlayerScore(playerid) <= 699 )
		    {
		    new Str[128], Jname[24];
		    GetPlayerName(playerid, Jname, 24);
		    format(Str, sizeof(Str), "[Major %s | Rangs, Major]", Jname);
		    SendClientMessage(playerid, GRIS,Str);
		    }
		    else if ( GetPlayerScore(playerid) >= 500 && GetPlayerScore(playerid) <= 699 )
		    {
		    new Str[128], Jname[24];
		    GetPlayerName(playerid, Jname, 24);
		    format(Str, sizeof(Str), "[Colonel %s | Rangs, Colonel]", Jname);
		    SendClientMessage(playerid, GRIS,Str);
		    }
		    else if ( GetPlayerScore(playerid) >= 700 && GetPlayerScore(playerid) <= 999 )
		    {
		    new Str[128], Jname[24];
		    GetPlayerName(playerid, Jname, 24);
		    format(Str, sizeof(Str), "[Brigadier Général %s | Rangs, Brigadier Général]", Jname);
		    SendClientMessage(playerid, GRIS,Str);
		    }
		    else if ( GetPlayerScore(playerid) >= 1000 && GetPlayerScore(playerid) <= 1499 )
		    {
		    new Str[128], Jname[24];
		    GetPlayerName(playerid, Jname, 24);
		    format(Str, sizeof(Str), "[Général %s | Rangs, Général]", Jname);
		    SendClientMessage(playerid, GRIS,Str);
		    }
		    else if ( GetPlayerScore(playerid) >= 1500 && GetPlayerScore(playerid) <= 1999 )
		    {
		    new Str[128], Jname[24];
		    GetPlayerName(playerid, Jname, 24);
		    format(Str, sizeof(Str), "[Major-Général %s | Rangs, Major-Général]", Jname);
		    SendClientMessage(playerid, GRIS,Str);
		    }
		    else if ( GetPlayerScore(playerid) >= 2000 && GetPlayerScore(playerid) <= 2499 )
		    {
		    new Str[128], Jname[24];
		    GetPlayerName(playerid, Jname, 24);
		    format(Str, sizeof(Str), "[Général Armée %s | Rangs, Général Armée]", Jname);
		    SendClientMessage(playerid, GRIS,Str);
		    }
		    else if ( GetPlayerScore(playerid) >= 2500 && GetPlayerScore(playerid) <= 2999 )
		    {
		    new Str[128], Jname[24];
		    GetPlayerName(playerid, Jname, 24);
		    format(Str, sizeof(Str), "[Marechal %s | Rangs, Marechal]", Jname);
		    SendClientMessage(playerid, GRIS,Str);
		    }
		    else if ( GetPlayerScore(playerid) >= 3000 && GetPlayerScore(playerid) <= 3999 )
		    {
		    new Str[128], Jname[24];
		    GetPlayerName(playerid, Jname, 24);
		    format(Str, sizeof(Str), "[Prestige I %s | Rangs, Prestige I]", Jname);
		    SendClientMessage(playerid, GRIS,Str);
		    }
		    else if ( GetPlayerScore(playerid) >= 4000 && GetPlayerScore(playerid) <= 4999 )
		    {
		    new Str[128], Jname[24];
		    GetPlayerName(playerid, Jname, 24);
		    format(Str, sizeof(Str), "[Prestige II %s | Rangs, Prestige II]", Jname);
		    SendClientMessage(playerid, GRIS,Str);
		    }
		    else if ( GetPlayerScore(playerid) >= 5000)
		    {
		    new Str[128], Jname[24];
		    GetPlayerName(playerid, Jname, 24);
		    format(Str, sizeof(Str), "[Prestige III %s | Rangs, Prestige III]", Jname);
		    SendClientMessage(playerid, GRIS,Str);
		    }
 		}
//_________________________________________________________//
//_________________________________________________________//
//_________________________________________________________//
		return 1;
	}
	return SendClientMessage(playerid,GRIS,"[La commande demandée est inconnue [/aide]]");
}

public Toucher(playerid)
{
    GetPlayerPos (playerid,Positions[playerid][0],Positions[playerid][1],Positions[playerid][2]);
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if(IsPlayerInRangeOfPoint(i, 4, Positions[playerid][0],Positions[playerid][1],Positions[playerid][2]))
		{
		    if(GetPlayerInterior(i) == 0)
		    {
			CreateExplosion(Positions[playerid][0],Positions[playerid][1],Positions[playerid][2],6,4.2);
	        CreateExplosion(Positions[playerid][0],Positions[playerid][1],Positions[playerid][2],6,4.2);
	        CreateExplosion(Positions[playerid][0],Positions[playerid][1],Positions[playerid][2],6,4.2);
	        CreateExplosion(Positions[playerid][0],Positions[playerid][1],Positions[playerid][2],6,4.2);
	        CreateExplosion(Positions[playerid][0],Positions[playerid][1],Positions[playerid][2],6,4.2);

			SendDeathMessage(Envoyeur,i,53);
            SetPlayerScore(Envoyeur,GetPlayerScore(Envoyeur)+1);
			GivePlayerMoney(Envoyeur, 500);

			SendClientMessage(i, POURPRE, "[BOMBE] Impact de la bombe de haute précision ! ! ");

			SetPlayerHealth(i,0);
			SetPlayerHealth(playerid,0);
			}
			else
			{
			SendClientMessage(Envoyeur, BLANC, "[ERREUR] Cible manqué elle est dans une maison ou autre.");
			}
		}
	}
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	new Model = GetVehicleModel(vehicleid);

	if ( Rang[playerid] < MAJOR && Model == 432 )

		{

		new Float:Posi[3];
		GetPlayerPos(playerid, Posi[0], Posi[1], Posi[2]);
		SetPlayerPos(playerid, Posi[0], Posi[1], Posi[2]+2);
		SendClientMessage(playerid, BLANC, "[ERREUR] Tu n'es pas Major ou plus !");
		return 1;

		}

	if ( Ferme[vehicleid] == 2 && Levels[playerid] == 0)

		{

		new Float:Posi[3];
		GetPlayerPos(playerid, Posi[0], Posi[1], Posi[2]);
		SetPlayerPos(playerid, Posi[0], Posi[1], Posi[2]+2);
		SendClientMessage(playerid, BLANC, "[ERREUR] Ce Vehicule est fermé par un Administrateur.");

		return 1;

		}

	if ( Classe[playerid] != 7 && Model == 447 )

		{

		if ( Classe[playerid] != 9 )

			{

			new Float:Posi[3];
			GetPlayerPos(playerid, Posi[0], Posi[1], Posi[2]);
			SetPlayerPos(playerid, Posi[0], Posi[1], Posi[2]+2);
			SendClientMessage(playerid, BLANC, "[ERREUR] Tu n'es pas Pilote ou VIP !");
			}

		}
	return 1;
}

//__________________________________________________//
//__________________________________________________//
//________________TERRITOIRE FORWARD________________//
//__________________________________________________//

public OnPlayerEnterCheckpoint(playerid)
{
    if (IsPlayerInRangeOfPoint(playerid, 2147.4602,-1818.3251,16.1406, 3.0))
	{
    THotel[playerid] = SetTimerEx("CaptureHotel", 1000*30, 0, "i", playerid);
    GangZoneFlashForAll(TerritoireHotel,GetPlayerColor(playerid));
    Captures[playerid] = 1;
    }
    else if (IsPlayerInRangeOfPoint(playerid, 2435.0288,-2124.7832,13.5469, 3.0))
	{
    TFuel[playerid] = SetTimerEx("CaptureFuel", 1000*30, 0, "i", playerid);
    GangZoneFlashForAll(TerritoireFuel,GetPlayerColor(playerid));
    Captures[playerid] = 2;
    }
    else if (IsPlayerInRangeOfPoint(playerid, 2128.5146,-2263.6455,14.7808, 3.0))
	{
    TEntrepot[playerid] = SetTimerEx("CaptureEntrepot", 1000*30, 0, "i", playerid);
    GangZoneFlashForAll(TerritoireEntrepot,GetPlayerColor(playerid));
    Captures[playerid] = 3;
    }
    else if (IsPlayerInRangeOfPoint(playerid, 2171.9695,-1498.7477,23.9748, 3.0))
	{
    TPark[playerid] = SetTimerEx("CapturePark", 1000*30, 0, "i", playerid);
    GangZoneFlashForAll(TerritoirePark,GetPlayerColor(playerid));
    Captures[playerid] = 4;
    }
    else if (IsPlayerInRangeOfPoint(playerid, 2030.7883,-1655.9767,13.5547, 3.0))
	{
    TPark[playerid] = SetTimerEx("CaptureAparte", 1000*30, 0, "i", playerid);
    GangZoneFlashForAll(TerritoireAparte,GetPlayerColor(playerid));
    Captures[playerid] = 5;
    }
    else if (IsPlayerInRangeOfPoint(playerid, 1994.4258,-2018.2747,13.5469, 3.0))
	{
    TPark[playerid] = SetTimerEx("CaptureMarcher", 1000*30, 0, "i", playerid);
    GangZoneFlashForAll(TerritoireMarcher,GetPlayerColor(playerid));
    Captures[playerid] = 6;
    }
    else if (IsPlayerInRangeOfPoint(playerid, 1763.8785,-1910.4652,13.5694, 3.0))
	{
    TGare[playerid] = SetTimerEx("CaptureGare", 1000*30, 0, "i", playerid);
    GangZoneFlashForAll(TerritoireGare,GetPlayerColor(playerid));
    Captures[playerid] = 7;
    }
    else if (IsPlayerInRangeOfPoint(playerid, 2511.1475,-1468.4246,24.0220, 3.0))
	{
    TWash[playerid] = SetTimerEx("CaptureWash", 1000*30, 0, "i", playerid);
    GangZoneFlashForAll(TerritoireWash,GetPlayerColor(playerid));
    Captures[playerid] = 8;
    }
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
    KillTimer(THotel[playerid]);
	KillTimer(TFuel[playerid]);
	KillTimer(TEntrepot[playerid]);
	KillTimer(TPark[playerid]);
	KillTimer(TAparte[playerid]);
	KillTimer(TMarcher[playerid]);
	KillTimer(TGare[playerid]);
	KillTimer(TWash[playerid]);

	DisablePlayerCheckpoint(playerid);

    GangZoneStopFlashForPlayer(playerid,TerritoireHotel);
    GangZoneStopFlashForPlayer(playerid,TerritoireFuel);
    GangZoneStopFlashForPlayer(playerid,TerritoireEntrepot);
    GangZoneStopFlashForPlayer(playerid,TerritoirePark);
    GangZoneStopFlashForPlayer(playerid,TerritoireAparte);
    GangZoneStopFlashForPlayer(playerid,TerritoireMarcher);
    GangZoneStopFlashForPlayer(playerid,TerritoireGare);
    GangZoneStopFlashForPlayer(playerid,TerritoireWash);
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
    if(pickupid == HotelP)
    {
        if(TerritoireHotelAppartenance != Team[playerid])
    	{
		THotel[playerid] = SetTimerEx("CaptureHotel", 1000*30, 0, "i", playerid);
	    GangZoneFlashForAll(TerritoireHotel,GetPlayerColor(playerid));
        SetPlayerCheckpoint(playerid, 2147.4602,-1818.3251,16.1406, 3.0);
	    SendClientMessageToAll(BLANCHE,"Un joueur tante de capturé le territoire Hotel ! tué le !");
		}
		else
		{
		GangZoneShowForAll(TerritoireHotel,GetPlayerColor(playerid));
		SendClientMessage(playerid, POURPRE,"Ce territoire est déjà à ton équipe !");
		}
	}
	else if(pickupid == FuelP)
    {
        if(TerritoireFuelAppartenance != Team[playerid])
    	{
	    TFuel[playerid] = SetTimerEx("CaptureFuel", 1000*30, 0, "i", playerid);
	    GangZoneFlashForAll(TerritoireFuel,GetPlayerColor(playerid));
        SetPlayerCheckpoint(playerid, 2435.0288,-2124.7832,13.5469, 3.0);
	    SendClientMessageToAll(BLANCHE,"Un joueur tante de capturé le territoire Fuel ! tué le !");
		}
		else
		{
		GangZoneShowForAll(TerritoireFuel,GetPlayerColor(playerid));
		SendClientMessage(playerid, POURPRE,"Ce territoire est déjà à ton équipe !");
		}
	}
	else if(pickupid == EntrepotP)
    {
        if(TerritoireEntrepotAppartenance != Team[playerid])
    	{
	    TEntrepot[playerid] = SetTimerEx("CaptureEntrepot", 1000*30, 0, "i", playerid);
	    GangZoneFlashForAll(TerritoireEntrepot,GetPlayerColor(playerid));
	    SetPlayerCheckpoint(playerid, 2128.5146,-2263.6455,14.7808, 3.0);
	    SendClientMessageToAll(BLANCHE,"Un joueur tante de capturé le territoire Entrepot ! tué le !");
		}
		else
		{
		GangZoneShowForAll(TerritoireEntrepot,GetPlayerColor(playerid));
		SendClientMessage(playerid, POURPRE,"Ce territoire est déjà à ton équipe !");
		}
	}
	else if(pickupid == ParkP)
    {
        if(TerritoireParkAppartenance != Team[playerid])
    	{
	    TPark[playerid] = SetTimerEx("CapturePark", 1000*30, 0, "i", playerid);
	    GangZoneFlashForAll(TerritoirePark,GetPlayerColor(playerid));
	    SetPlayerCheckpoint(playerid, 2171.9695,-1498.7477,23.9748, 3.0);
	    SendClientMessageToAll(BLANCHE,"Un joueur tante de capturé le territoire du Park ! tué le !");
		}
		else
		{
		GangZoneShowForAll(TerritoirePark,GetPlayerColor(playerid));
		SendClientMessage(playerid, POURPRE,"Ce territoire est déjà à ton équipe !");
		}
	}
	else if(pickupid == AparteP)
    {
        if(TerritoireAparteAppartenance != Team[playerid])
    	{
	    TAparte[playerid] = SetTimerEx("CaptureAparte", 1000*30, 0, "i", playerid);
	    GangZoneFlashForAll(TerritoireAparte,GetPlayerColor(playerid));
	    SetPlayerCheckpoint(playerid, 2030.7883,-1655.9767,13.5547, 3.0);
	    SendClientMessageToAll(BLANCHE,"Un joueur tante de capturé le territoire du des Apartements ! tué le !");
		}
		else
		{
		GangZoneShowForAll(TerritoireAparte,GetPlayerColor(playerid));
		SendClientMessage(playerid, POURPRE,"Ce territoire est déjà à ton équipe !");
		}
	}
	else if(pickupid == MarcherP)
    {
        if(TerritoireMarcherAppartenance != Team[playerid])
    	{
	    TMarcher[playerid] = SetTimerEx("CaptureMarcher", 1000*30, 0, "i", playerid);
	    GangZoneFlashForAll(TerritoireMarcher,GetPlayerColor(playerid));
	    SetPlayerCheckpoint(playerid, 1994.4258,-2018.2747,13.5469, 3.0);
	    SendClientMessageToAll(BLANCHE,"Un joueur tante de capturé le territoire du Marcher ! tué le !");
		}
		else
		{
		GangZoneShowForAll(TerritoireMarcher,GetPlayerColor(playerid));
		SendClientMessage(playerid, POURPRE,"Ce territoire est déjà à ton équipe !");
		}
	}
	else if(pickupid == GareP)
    {
        if(TerritoireGareAppartenance != Team[playerid])
    	{
	    TGare[playerid] = SetTimerEx("CaptureGare", 1000*30, 0, "i", playerid);
	    GangZoneFlashForAll(TerritoireGare,GetPlayerColor(playerid));
	    SetPlayerCheckpoint(playerid, 1763.8785,-1910.4652,13.5694, 3.0);
	    SendClientMessageToAll(BLANCHE,"Un joueur tante de capturé le territoire de la Gare ! tué le !");
		}
		else
		{
		GangZoneShowForAll(TerritoireGare,GetPlayerColor(playerid));
		SendClientMessage(playerid, POURPRE,"Ce territoire est déjà à ton équipe !");
		}
	}
	else if(pickupid == WashP)
    {
        if(TerritoireWashAppartenance != Team[playerid])
    	{
	    TWash[playerid] = SetTimerEx("CaptureWash", 1000*30, 0, "i", playerid);
	    GangZoneFlashForAll(TerritoireWash,GetPlayerColor(playerid));
	    SetPlayerCheckpoint(playerid, 2511.1475,-1468.4246,24.0220, 3.0);
	    SendClientMessageToAll(BLANCHE,"Un joueur tante de capturé le territoire WashCar ! tué le !");
		}
		else
		{
		GangZoneShowForAll(TerritoireWash,GetPlayerColor(playerid));
		SendClientMessage(playerid, POURPRE,"Ce territoire est déjà à ton équipe !");
		}
	}
    return 1;
}

//__________________________________________________//
//__________________________________________________//
//__________________________________________________//

public CaptureHotel(playerid)
{
	if(TerritoireHotelAppartenance != Team[playerid])
	{
	TerritoireHotelAppartenance = Team[playerid];
	SendClientMessageToAll(BLANC, "Le Territoire de l'Hotel a était capturé !");
	GangZoneShowForAll(TerritoireHotel,GetPlayerColor(playerid));
	SetPlayerScore(playerid,GetPlayerScore(playerid)+5);
	SendClientMessage(playerid,BLANC, "+5 Scores pour toi.");
	Captures[playerid] = 0;

	DisablePlayerCheckpoint(playerid);
	}
	else
	{
	DisablePlayerCheckpoint(playerid);
	SendClientMessage(playerid, BLANC, "Ce territoire est déjà a ton équipe !");
	}
    return 1;
}

public CaptureFuel(playerid)
{
    if(TerritoireFuelAppartenance != Team[playerid])
	{
    TerritoireFuelAppartenance = Team[playerid];
	SendClientMessageToAll(BLANC, "Le Territoire Fuel a était capturé !");
	GangZoneShowForAll(TerritoireFuel,GetPlayerColor(playerid));
	SetPlayerScore(playerid,GetPlayerScore(playerid)+5);
	SendClientMessage(playerid,BLANC, "+5 Scores pour toi.");
	Captures[playerid] = 0;

	DisablePlayerCheckpoint(playerid);
	}
	else
	{
	DisablePlayerCheckpoint(playerid);
	SendClientMessage(playerid, BLANC, "Ce territoire est déjà a ton équipe !");
	}
    return 1;
}


public CaptureEntrepot(playerid)
{
    if(TerritoireEntrepotAppartenance != Team[playerid])
	{
    TerritoireEntrepotAppartenance = Team[playerid];
	SendClientMessageToAll(BLANC, "Le Territoire Entrepot a était capturé !");
	GangZoneShowForAll(TerritoireEntrepot,GetPlayerColor(playerid));
	SetPlayerScore(playerid,GetPlayerScore(playerid)+5);
	SendClientMessage(playerid,BLANC, "+5 Scores pour toi.");
	Captures[playerid] = 0;

	DisablePlayerCheckpoint(playerid);
	}
	else
	{
	DisablePlayerCheckpoint(playerid);
	SendClientMessage(playerid, BLANC, "Ce territoire est déjà a ton équipe !");
	}
    return 1;
}


public CapturePark(playerid)
{
    if(TerritoireParkAppartenance != Team[playerid])
	{
    TerritoireParkAppartenance = Team[playerid];
	SendClientMessageToAll(BLANC, "Le Territoire Park a était capturé !");
	GangZoneShowForAll(TerritoirePark,GetPlayerColor(playerid));
	SetPlayerScore(playerid,GetPlayerScore(playerid)+5);
	SendClientMessage(playerid,BLANC, "+5 Scores pour toi.");
	Captures[playerid] = 0;

	DisablePlayerCheckpoint(playerid);
	}
	else
	{
	DisablePlayerCheckpoint(playerid);
	SendClientMessage(playerid, BLANC, "Ce territoire est déjà a ton équipe !");
	}
    return 1;
}

public CaptureAparte(playerid)
{
    if(TerritoireAparteAppartenance != Team[playerid])
	{
    TerritoireAparteAppartenance = Team[playerid];
	SendClientMessageToAll(BLANC, "Le Territoire Aparte a était capturé !");
	GangZoneShowForAll(TerritoireAparte,GetPlayerColor(playerid));
	SetPlayerScore(playerid,GetPlayerScore(playerid)+5);
	SendClientMessage(playerid,BLANC, "+5 Scores pour toi.");
	Captures[playerid] = 0;

	DisablePlayerCheckpoint(playerid);
	}
	else
	{
	DisablePlayerCheckpoint(playerid);
	SendClientMessage(playerid, BLANC, "Ce territoire est déjà a ton équipe !");
	}
    return 1;
}


public CaptureMarcher(playerid)
{
    if(TerritoireMarcherAppartenance != Team[playerid])
	{
    TerritoireMarcherAppartenance = Team[playerid];
	SendClientMessageToAll(BLANC, "Le Territoire Marcher a était capturé !");
	GangZoneShowForAll(TerritoireMarcher,GetPlayerColor(playerid));
	SetPlayerScore(playerid,GetPlayerScore(playerid)+5);
	SendClientMessage(playerid,BLANC, "+5 Scores pour toi.");
	Captures[playerid] = 0;

	DisablePlayerCheckpoint(playerid);
	}
	else
	{
	DisablePlayerCheckpoint(playerid);
	SendClientMessage(playerid, BLANC, "Ce territoire est déjà a ton équipe !");
	}
    return 1;
}

public CaptureGare(playerid)
{
    if(TerritoireGareAppartenance != Team[playerid])
	{
	TerritoireGareAppartenance = Team[playerid];
	SendClientMessageToAll(BLANC, "Le Territoire de la Gare a était capturé !");
	GangZoneShowForAll(TerritoireGare,GetPlayerColor(playerid));
	SetPlayerScore(playerid,GetPlayerScore(playerid)+5);
	SendClientMessage(playerid,BLANC, "+5 Scores pour toi.");
	Captures[playerid] = 0;

	DisablePlayerCheckpoint(playerid);
	}
	else
	{
	DisablePlayerCheckpoint(playerid);
	SendClientMessage(playerid, BLANC, "Ce territoire est déjà a ton équipe !");
	}
    return 1;
}

public CaptureWash(playerid)
{
    if(TerritoireWashAppartenance != Team[playerid])
	{
	TerritoireWashAppartenance = Team[playerid];
	SendClientMessageToAll(BLANC, "Le Territoire WashCar a était capturé !");
	GangZoneShowForAll(TerritoireWash,GetPlayerColor(playerid));
	SetPlayerScore(playerid,GetPlayerScore(playerid)+5);
	SendClientMessage(playerid,BLANC, "+5 Scores pour toi.");
	Captures[playerid] = 0;

	DisablePlayerCheckpoint(playerid);
	}
	else
	{
	DisablePlayerCheckpoint(playerid);
	SendClientMessage(playerid, BLANC, "Ce territoire est déjà a ton équipe !");
	}
    return 1;
}

//__________________________________________________//
//__________________________________________________//
//__________________________________________________//

//__________________________________________________//
//__________________________________________________//
//__________________________________________________//

public Territoire(playerid)
{
	if (TerritoireHotelAppartenance == Team[playerid])
	{
	GangZoneShowForPlayer(playerid, TerritoireHotel, GetPlayerColor(playerid));
	GangZoneShowForAll(TerritoireHotel, GetPlayerColor(playerid));
	}
	//__________________________________________________//
	//__________________________________________________//
	else if (TerritoireFuelAppartenance == Team[playerid])
	{
	GangZoneShowForPlayer(playerid, TerritoireFuel, GetPlayerColor(playerid));
	GangZoneShowForAll(TerritoireFuel, GetPlayerColor(playerid));
	}
	//__________________________________________________//
	//__________________________________________________//
	else if (TerritoireParkAppartenance == Team[playerid])
	{
	GangZoneShowForPlayer(playerid, TerritoirePark, GetPlayerColor(playerid));
	GangZoneShowForAll(TerritoirePark, GetPlayerColor(playerid));
	}
	//__________________________________________________//
	//__________________________________________________//
	else if (TerritoireEntrepotAppartenance == Team[playerid])
	{
	GangZoneShowForPlayer(playerid, TerritoireEntrepot, GetPlayerColor(playerid));
	GangZoneShowForAll(TerritoireEntrepot, GetPlayerColor(playerid));
	}
	//__________________________________________________//
	//__________________________________________________//
	else if (TerritoireAparteAppartenance == Team[playerid])
	{
	GangZoneShowForPlayer(playerid, TerritoireAparte, GetPlayerColor(playerid));
	GangZoneShowForAll(TerritoireAparte, GetPlayerColor(playerid));
	}
	//__________________________________________________//
	//__________________________________________________//
	else if (TerritoireMarcherAppartenance == Team[playerid])
	{
	GangZoneShowForPlayer(playerid, TerritoireMarcher, GetPlayerColor(playerid));
	GangZoneShowForAll(TerritoireMarcher, GetPlayerColor(playerid));
	}
	//__________________________________________________//
	//__________________________________________________//
	else if (TerritoireGareAppartenance == Team[playerid])
	{
	GangZoneShowForPlayer(playerid, TerritoireGare, GetPlayerColor(playerid));
	GangZoneShowForAll(TerritoireGare, GetPlayerColor(playerid));
	}
	//__________________________________________________//
	//__________________________________________________//
	else if (TerritoireWashAppartenance == Team[playerid])
	{
	GangZoneShowForPlayer(playerid, TerritoireWash, GetPlayerColor(playerid));
	GangZoneShowForAll(TerritoireWash, GetPlayerColor(playerid));
	}
	//__________________________________________________//
	//__________________________________________________//
    return 1;
}

//__________________________________________________//
//__________________________________________________//
//__________________________________________________//
//__________________________________________________//
//__________________________________________________//
//__________________________________________________//
//__________________________________________________//
//__________________________________________________//
//__________________________________________________//

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}


public OnPlayerSelectedMenuRow(playerid, row)
{
    if(GetPlayerMenu(playerid) == Vehicules)
	{
		switch(row)
		{
			case 0:
	        {
            new Float:Posit[3];
			new VoitureID;
			new Float:Angle;
			GetPlayerFacingAngle(playerid,Angle);
			GetPlayerPos(playerid, Posit[0], Posit[1], Posit[2]);
			VoitureID = CreateVehicle(451,Posit[0],Posit[1],Posit[2],Angle,-1,-1,50000);
  			PutPlayerInVehicle(playerid,VoitureID,0);
			TogglePlayerControllable(playerid,1);
			SpawnCar[VoitureID] = 1;
			if(GetPlayerInterior(playerid))
			LinkVehicleToInterior(VoitureID,GetPlayerInterior(playerid));
			SetVehicleVirtualWorld(VoitureID,GetPlayerVirtualWorld(playerid));
			}
			case 1:
	        {
        	new Float:Posit[3];
			new VoitureID;
			new Float:Angle;
			GetPlayerFacingAngle(playerid,Angle);
 			GetPlayerPos(playerid, Posit[0], Posit[1], Posit[2]);
			VoitureID = CreateVehicle(411,Posit[0],Posit[1],Posit[2],Angle,-1,-1,50000);
  			PutPlayerInVehicle(playerid,VoitureID,0);
			TogglePlayerControllable(playerid,1);
			SpawnCar[VoitureID] = 1;
			if(GetPlayerInterior(playerid))
			LinkVehicleToInterior(VoitureID,GetPlayerInterior(playerid));
			SetVehicleVirtualWorld(VoitureID,GetPlayerVirtualWorld(playerid));
			}
	        case 2:
	        {
            new Float:Posit[3];
			new VoitureID;
			new Float:Angle;
			GetPlayerFacingAngle(playerid,Angle);
			GetPlayerPos(playerid, Posit[0], Posit[1], Posit[2]);
			VoitureID = CreateVehicle(402,Posit[0],Posit[1],Posit[2],Angle,-1,-1,50000);
  			PutPlayerInVehicle(playerid,VoitureID,0);
			TogglePlayerControllable(playerid,1);
			SpawnCar[VoitureID] = 1;
			if(GetPlayerInterior(playerid))
			LinkVehicleToInterior(VoitureID,GetPlayerInterior(playerid));
			SetVehicleVirtualWorld(VoitureID,GetPlayerVirtualWorld(playerid));
			}
	        case 3:
	        {
            new Float:Posit[3];
			new VoitureID;
			new Float:Angle;
			GetPlayerFacingAngle(playerid,Angle);
			GetPlayerPos(playerid, Posit[0], Posit[1], Posit[2]);
			VoitureID = CreateVehicle(409,Posit[0],Posit[1],Posit[2],Angle,-1,-1,50000);
  			PutPlayerInVehicle(playerid,VoitureID,0);
			TogglePlayerControllable(playerid,1);
			SpawnCar[VoitureID] = 1;
			if(GetPlayerInterior(playerid))
			LinkVehicleToInterior(VoitureID,GetPlayerInterior(playerid));
			SetVehicleVirtualWorld(VoitureID,GetPlayerVirtualWorld(playerid));
			}
	        case 4:
	        {
            new Float:Posit[3];
			new VoitureID;
			new Float:Angle;
			GetPlayerFacingAngle(playerid,Angle);
			GetPlayerPos(playerid, Posit[0], Posit[1], Posit[2]);
			VoitureID = CreateVehicle(417,Posit[0],Posit[1],Posit[2],Angle,-1,-1,50000);
 			PutPlayerInVehicle(playerid,VoitureID,0);
			TogglePlayerControllable(playerid,1);
			SpawnCar[VoitureID] = 1;
			if(GetPlayerInterior(playerid))
			LinkVehicleToInterior(VoitureID,GetPlayerInterior(playerid));
			SetVehicleVirtualWorld(VoitureID,GetPlayerVirtualWorld(playerid));
			}
	        case 5:
	        {
            new Float:Posit[3];
			new VoitureID;
			new Float:Angle;
			GetPlayerFacingAngle(playerid,Angle);
			GetPlayerPos(playerid, Posit[0], Posit[1], Posit[2]);
			VoitureID = CreateVehicle(425,Posit[0],Posit[1],Posit[2],Angle,-1,-1,50000);
  			PutPlayerInVehicle(playerid,VoitureID,0);
			TogglePlayerControllable(playerid,1);
			SpawnCar[VoitureID] = 1;
			if(GetPlayerInterior(playerid))
			LinkVehicleToInterior(VoitureID,GetPlayerInterior(playerid));
			SetVehicleVirtualWorld(VoitureID,GetPlayerVirtualWorld(playerid));
			}
	        case 6:
	        {
            new Float:Posit[3];
			new VoitureID;
			new Float:Angle;
			GetPlayerFacingAngle(playerid,Angle);
			GetPlayerPos(playerid, Posit[0], Posit[1], Posit[2]);
			VoitureID = CreateVehicle(461,Posit[0],Posit[1],Posit[2],Angle,-1,-1,50000);
  			PutPlayerInVehicle(playerid,VoitureID,0);
			TogglePlayerControllable(playerid,1);
			SpawnCar[VoitureID] = 1;
			if(GetPlayerInterior(playerid))
			LinkVehicleToInterior(VoitureID,GetPlayerInterior(playerid));
			SetVehicleVirtualWorld(VoitureID,GetPlayerVirtualWorld(playerid));
			}
	        case 7:
	        {
  			new Float:Posit[3];
  			new VoitureID;
  			new Float:Angle;
  			GetPlayerFacingAngle(playerid,Angle);
  			GetPlayerPos(playerid, Posit[0], Posit[1], Posit[2]);
			VoitureID = CreateVehicle(463,Posit[0],Posit[1],Posit[2],Angle,-1,-1,50000);
  			PutPlayerInVehicle(playerid,VoitureID,0);
			TogglePlayerControllable(playerid,1);
			SpawnCar[VoitureID] = 1;
			if(GetPlayerInterior(playerid))
			LinkVehicleToInterior(VoitureID,GetPlayerInterior(playerid));
			SetVehicleVirtualWorld(VoitureID,GetPlayerVirtualWorld(playerid));
			}
	        case 8:
	        {
  			new Float:Posit[3];
  			new VoitureID;
  			new Float:Angle;
  			GetPlayerFacingAngle(playerid,Angle);
  			GetPlayerPos(playerid, Posit[0], Posit[1], Posit[2]);
			VoitureID = CreateVehicle(468,Posit[0],Posit[1],Posit[2],Angle,-1,-1,50000);
  			PutPlayerInVehicle(playerid,VoitureID,0);
			TogglePlayerControllable(playerid,1);
			SpawnCar[VoitureID] = 1;
			if(GetPlayerInterior(playerid))
			LinkVehicleToInterior(VoitureID,GetPlayerInterior(playerid));
			SetVehicleVirtualWorld(VoitureID,GetPlayerVirtualWorld(playerid));
			}
   			case 9:
	        {
            new Float:Posit[3];
   			new VoitureID;
   			new Float:Angle;
   			GetPlayerFacingAngle(playerid,Angle);
   			GetPlayerPos(playerid, Posit[0], Posit[1], Posit[2]);
			VoitureID = CreateVehicle(476,Posit[0],Posit[1],Posit[2],Angle,-1,-1,50000);
  			PutPlayerInVehicle(playerid,VoitureID,0);
			TogglePlayerControllable(playerid,1);
			SpawnCar[VoitureID] = 1;
			if(GetPlayerInterior(playerid))
			LinkVehicleToInterior(VoitureID,GetPlayerInterior(playerid));
			SetVehicleVirtualWorld(VoitureID,GetPlayerVirtualWorld(playerid));
			}
			case 10:
	        {
  			new Float:Posit[3];
  			new VoitureID;
  			new Float:Angle;
  			GetPlayerFacingAngle(playerid,Angle);
  			GetPlayerPos(playerid, Posit[0], Posit[1], Posit[2]);
			VoitureID = CreateVehicle(494,Posit[0],Posit[1],Posit[2],Angle,-1,-1,50000);
  			PutPlayerInVehicle(playerid,VoitureID,0);
			TogglePlayerControllable(playerid,1);
			SpawnCar[VoitureID] = 1;
			if(GetPlayerInterior(playerid))
			LinkVehicleToInterior(VoitureID,GetPlayerInterior(playerid));
			SetVehicleVirtualWorld(VoitureID,GetPlayerVirtualWorld(playerid));
			}
			case 11:
	        {
            new Float:Posit[3];
			new VoitureID;
			new Float:Angle;
			GetPlayerFacingAngle(playerid,Angle);
			GetPlayerPos(playerid, Posit[0], Posit[1], Posit[2]);
			VoitureID = CreateVehicle(519,Posit[0],Posit[1],Posit[2],Angle,-1,-1,50000);
  			PutPlayerInVehicle(playerid,VoitureID,0);
			TogglePlayerControllable(playerid,1);
			SpawnCar[VoitureID] = 1;
			if(GetPlayerInterior(playerid))
			LinkVehicleToInterior(VoitureID,GetPlayerInterior(playerid));
			SetVehicleVirtualWorld(VoitureID,GetPlayerVirtualWorld(playerid));
			}
			case 12:
	        {

			}
			case 13:
	        {
            new Float:Posit[3];
			new VoitureID;
			new Float:Angle;
			GetPlayerFacingAngle(playerid,Angle);
			GetPlayerPos(playerid, Posit[0], Posit[1], Posit[2]);
			VoitureID = CreateVehicle(522,Posit[0],Posit[1],Posit[2],Angle,-1,-1,50000);
  			PutPlayerInVehicle(playerid,VoitureID,0);
			TogglePlayerControllable(playerid,1);
			SpawnCar[VoitureID] = 1;
			if(GetPlayerInterior(playerid))
			LinkVehicleToInterior(VoitureID,GetPlayerInterior(playerid));
			SetVehicleVirtualWorld(VoitureID,GetPlayerVirtualWorld(playerid));
			}
		}
		OnPlayerExitedMenu(playerid);
	}
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	return 1;
}

public Gazeuze(playerid)
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
		SendDeathMessage(playerid,i,53);
		SetPlayerScore(playerid,GetPlayerScore(playerid)+1);
		SendClientMessageToAll(POURPRE, "[BOMBE] GAZEUZE IMPACT ! ! ");
		SetPlayerHealth(i,0);
		}
	}
}


public Nucleaire(playerid)
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
		SendDeathMessage(playerid,i,51);
		SendClientMessageToAll(POURPRE, "[BOMBE] NUCLEAIRE IMPACT ! ! ");
		SetPlayerHealth(i,0);
		}
	}
}


public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if (dialogid == 1)
	{
		{
			{

			new Nom[MAX_PLAYER_NAME], Fichier[256], String[128];

			GetPlayerName(playerid, Nom, sizeof(Nom));
		    format(Fichier, sizeof(Fichier), ENREGISTREMENT, Nom);

			if(!response) return Kick(playerid);

			if (!strlen(inputtext)) return ShowPlayerDialog(playerid, 1, DIALOG_STYLE_INPUT, "{FF0000}[Bienvenue]","Metter ce que vous voulais ici.", "Enregistrer", "Quitter");

			dini_Create(Fichier);

			dini_IntSet(Fichier, "Password", udb_hash(inputtext));
		    dini_IntSet(Fichier, "Money", InfoJoueur[playerid][Argent] = 500);
			dini_IntSet(Fichier, "Score", InfoJoueur[playerid][Score] = 0);
			dini_IntSet(Fichier, "Level", InfoJoueur[playerid][Level] = 0);
			dini_IntSet(Fichier, "Kill/Death", InfoJoueur[playerid][KillDeath] = 0);
			dini_IntSet(Fichier, "Morts", InfoJoueur[playerid][NMorts] = 0);
			dini_IntSet(Fichier, "Tues", InfoJoueur[playerid][NTues] = 0);
			dini_IntSet(Fichier, "VIP", InfoJoueur[playerid][JVIP] = 0);
			dini_IntSet(Fichier, "Bannis", InfoJoueur[playerid][Bannis] = 0);

			dini_IntSet(Fichier, "MULTIKILL", InfoJoueur[playerid][MULTIKILL] = 0);
			dini_IntSet(Fichier, "ULTRAKILL", InfoJoueur[playerid][ULTRAKILL] = 0);
			dini_IntSet(Fichier, "FANTASTIQUE", InfoJoueur[playerid][FANTASTIQUE] = 0);
			dini_IntSet(Fichier, "ARMAGEDDON", InfoJoueur[playerid][ARMAGEDDON] = 0);
			dini_IntSet(Fichier, "INCROYABLE", InfoJoueur[playerid][INCROYABLE] = 0);
			dini_IntSet(Fichier, "BIGBANG", InfoJoueur[playerid][BIGBANG] = 0);
			dini_IntSet(Fichier, "IMPOSSIBLE", InfoJoueur[playerid][IMPOSSIBLE] = 0);
			dini_IntSet(Fichier, "IIMPOSSIBLE", InfoJoueur[playerid][IIMPOSSIBLE] = 0);
			dini_IntSet(Fichier, "IIIMPOSSIBLE", InfoJoueur[playerid][IIIMPOSSIBLE] = 0);
			dini_IntSet(Fichier, "INDESTRUCTIBLE", InfoJoueur[playerid][INDESTRUCTIBLE] = 0);

			dini_IntSet(Fichier, "WarsPoints", InfoJoueur[playerid][WPoint] = 0);
			dini_IntSet(Fichier, "Brouilleur", InfoJoueur[playerid][Brouilleur] = 0);
			dini_IntSet(Fichier, "Vie", InfoJoueur[playerid][Vie] = 0);
			dini_IntSet(Fichier, "Banque", InfoJoueur[playerid][Banques] = 0);
			dini_IntSet(Fichier, "Skin", InfoJoueur[playerid][PSkin] = 0);

			format(String, 128, "Tu a été enregistrer avec le nom %s et le mot de passe %s.", Nom, inputtext);
			SendClientMessage(playerid, VERT, String);
			JoueurLogguer[playerid] = 1;
			ClearC(playerid);
			//__________________________________//
			}
			return 1;

		}
	}
	if (dialogid == 2)
	{
		{
		    new Nom[MAX_PLAYER_NAME], Fichier[256];
		    GetPlayerName(playerid, Nom, sizeof(Nom));
		    format(Fichier, sizeof(Fichier), ENREGISTREMENT, Nom);
			if(!response) return Kick(playerid);
			if (!strlen(inputtext)) return ShowPlayerDialog(playerid, 2, DIALOG_STYLE_INPUT, "{FF0000}[Bienvenue]","Metter ce que vous voulez ici.", "Enregistrer", "Quitter");
			new Tmp;
		    Tmp = dini_Int(Fichier, "Password");
			if(udb_hash(inputtext) != Tmp)
			{

			ClearC(playerid);

			SendClientMessage(playerid, ROUGE, "Mauvais mot de passe.");
	     	GivePlayerMoney(playerid, dini_Int(Fichier, "Money")-GetPlayerMoney(playerid));
			SetPlayerScore(playerid, dini_Int(Fichier, "Score")-GetPlayerScore(playerid));

			Levels[playerid] = dini_Int(Fichier,"Level");

			KD[playerid] = dini_Int(Fichier,"Kill/Death");
			Death[playerid] = dini_Int(Fichier,"Morts");
			Kill[playerid] = dini_Int(Fichier,"Tues");

			VIP[playerid] = dini_Int(Fichier,"VIP");
			Bans[playerid] = dini_Int(Fichier,"Bannis");

            COMULTIKILL[playerid] = dini_Int(Fichier,"MULTIKILL");
            COULTRAKILL[playerid] = dini_Int(Fichier,"ULTRAKILL");
            COFANTASTIQUE[playerid] = dini_Int(Fichier,"FANTASTIQUE");
            COARMAGEDDON[playerid] = dini_Int(Fichier,"ARMAGEDDON");
            COINCROYABLE[playerid] = dini_Int(Fichier,"INCROYABLE");
            COBIGBANG[playerid] = dini_Int(Fichier,"BIGBANG");
            COIMPOSSIBLE[playerid] = dini_Int(Fichier,"IMPOSSIBLE");
            COIIMPOSSIBLE[playerid] = dini_Int(Fichier,"IIMPOSSIBLE");
            COIIIMPOSSIBLE[playerid] = dini_Int(Fichier,"IIIMPOSSIBLE");
            COINDESTRUCTIBLE[playerid] = dini_Int(Fichier,"INDESTRUCTIBLE");

			WarsPoints[playerid] = dini_Int(Fichier,"WarsPoints");

			Brouilleurs[playerid] = dini_Int(Fichier,"Brouilleur");

			SVie[playerid] = dini_Int(Fichier,"Vie");

			Banque[playerid] = dini_Int(Fichier,"Banque");

			Skins[playerid] = dini_Int(Fichier,"Skin");

            SlotI[playerid] = dini_Int(Fichier,"SLOTSI");
			SlotII[playerid] = dini_Int(Fichier,"SLOTSII");
			SlotIII[playerid] = dini_Int(Fichier,"SLOTSIII");
            SlotIIII[playerid] = dini_Int(Fichier,"SLOTSIIII");
            SlotIIIII[playerid] = dini_Int(Fichier,"SLOTSIIIII");
            SlotIIIIII[playerid] = dini_Int(Fichier,"SLOTSIIIII");

			Kick(playerid);

			}

			else

			{

			JoueurLogguer[playerid] = 1;

			GivePlayerMoney(playerid, dini_Int(Fichier, "Money")-GetPlayerMoney(playerid));
			SetPlayerScore(playerid, dini_Int(Fichier, "Score")-GetPlayerScore(playerid));

            SlotI[playerid] = dini_Int(Fichier,"SLOTSI");
			SlotII[playerid] = dini_Int(Fichier,"SLOTSII");
			SlotIII[playerid] = dini_Int(Fichier,"SLOTSIII");
            SlotIIII[playerid] = dini_Int(Fichier,"SLOTSIIII");
            SlotIIIII[playerid] = dini_Int(Fichier,"SLOTSIIIII");
            SlotIIIIII[playerid] = dini_Int(Fichier,"SLOTSIIIII");

			dini_IntSet(Fichier, "SLOTSI", InfoJoueur[playerid][SLOTSI] = SlotI[playerid]);
			dini_IntSet(Fichier, "SLOTSII", InfoJoueur[playerid][SLOTSII] = SlotII[playerid]);
			dini_IntSet(Fichier, "SLOTSIII", InfoJoueur[playerid][SLOTSIII] = SlotIII[playerid]);
			dini_IntSet(Fichier, "SLOTSIIII", InfoJoueur[playerid][SLOTSIIII] = SlotIIII[playerid]);
			dini_IntSet(Fichier, "SLOTSIIIII", InfoJoueur[playerid][SLOTSIIIII] = SlotIIIII[playerid]);
			dini_IntSet(Fichier, "SLOTSIIIIII", InfoJoueur[playerid][SLOTSIIIIII] = SlotIIIIII[playerid]);

			Levels[playerid] = dini_Int(Fichier,"Level");

			KD[playerid] = dini_Int(Fichier,"Kill/Death");
			Death[playerid] = dini_Int(Fichier,"Morts");
			Kill[playerid] = dini_Int(Fichier,"Tues");

			VIP[playerid] = dini_Int(Fichier,"VIP");

			COMULTIKILL[playerid] = dini_Int(Fichier,"MULTIKILL");
            COULTRAKILL[playerid] = dini_Int(Fichier,"ULTRAKILL");
            COFANTASTIQUE[playerid] = dini_Int(Fichier,"FANTASTIQUE");
            COARMAGEDDON[playerid] = dini_Int(Fichier,"ARMAGEDDON");
            COINCROYABLE[playerid] = dini_Int(Fichier,"INCROYABLE");
            COBIGBANG[playerid] = dini_Int(Fichier,"BIGBANG");
            COIMPOSSIBLE[playerid] = dini_Int(Fichier,"IMPOSSIBLE");
            COIIMPOSSIBLE[playerid] = dini_Int(Fichier,"IIMPOSSIBLE");
            COIIIMPOSSIBLE[playerid] = dini_Int(Fichier,"IIIMPOSSIBLE");
            COINDESTRUCTIBLE[playerid] = dini_Int(Fichier,"INDESTRUCTIBLE");

            WarsPoints[playerid] = dini_Int(Fichier,"WarsPoints");
            Brouilleurs[playerid] = dini_Int(Fichier,"Brouilleur");
            SVie[playerid] = dini_Int(Fichier,"Vie");
            Banque[playerid] = dini_Int(Fichier,"Banque");
            Skins[playerid] = dini_Int(Fichier,"Skin");

            //__________________________________________
			TextDrawHideForPlayer(playerid,Noir);
			TextDrawHideForPlayer(playerid,Titre);
			TextDrawHideForPlayer(playerid,Regles);
			ClearC(playerid);
			//__________________________________________
			}
			return 1;
		}
	}
//_____________________________________________________________________//
//_____________________________________________________________________//
	if(dialogid == 20)
	{
		{
			if(response)
			{

				if(listitem == 0)
				{
    			if(Classe[playerid] == 0 && Team[playerid] == TEAM_RUSSE)
					{
	                GivePlayerWeapon(playerid,4,1);
	                GivePlayerWeapon(playerid,24,207);
	                GivePlayerWeapon(playerid,29,230);
	                GivePlayerWeapon(playerid,25,15);
	                GivePlayerWeapon(playerid,30,780);
	                Classe[playerid] = 2;
	                TogglePlayerControllable(playerid,true);
	                TextDrawHideForPlayer(playerid,Noir);
					}
					else if(Classe[playerid] == 0 && Team[playerid] == TEAM_MERCENAIRE)
					{
	                GivePlayerWeapon(playerid,4,1);
	                GivePlayerWeapon(playerid,24,207);
	                GivePlayerWeapon(playerid,29,230);
	                GivePlayerWeapon(playerid,25,15);
	                GivePlayerWeapon(playerid,30,780);
	                Classe[playerid] = 2;
	                TogglePlayerControllable(playerid,true);
	                TextDrawHideForPlayer(playerid,Noir);
					}
					else if(Classe[playerid] == 0 && Team[playerid] == TEAM_JAPON)
					{
	                GivePlayerWeapon(playerid,4,1);
	                GivePlayerWeapon(playerid,24,207);
	                GivePlayerWeapon(playerid,29,230);
	                GivePlayerWeapon(playerid,25,15);
	                GivePlayerWeapon(playerid,30,780);
	                Classe[playerid] = 2;
	                TogglePlayerControllable(playerid,true);
	                TextDrawHideForPlayer(playerid,Noir);
					}
					else if(Classe[playerid] == 0 && Team[playerid] == TEAM_ARMY )
					{
	                GivePlayerWeapon(playerid,4,1);
	                GivePlayerWeapon(playerid,24,207);
	                GivePlayerWeapon(playerid,29,230);
	                GivePlayerWeapon(playerid,25,15);
	                GivePlayerWeapon(playerid,31,750);
	                Classe[playerid] = 1;
	                TogglePlayerControllable(playerid,true);
	                TextDrawHideForPlayer(playerid,Noir);
		 			}
				}
				if(listitem == 1)
				{
	    			if(Rang[playerid] >= CORPORAL && Team[playerid] == 0 )
					{
	                GivePlayerWeapon(playerid,4,1);
				    GivePlayerWeapon(playerid,23,117);
				    GivePlayerWeapon(playerid,34,225);
					Classe[playerid] = 3;
					SetPlayerColor(playerid, BLEUE);
					TogglePlayerControllable(playerid,true);
					TextDrawHideForPlayer(playerid,Noir);
					}
					else if(Rang[playerid] >= CORPORAL && Team[playerid] == 1 )
					{
	                GivePlayerWeapon(playerid,4,1);
				    GivePlayerWeapon(playerid,23,117);
				    GivePlayerWeapon(playerid,34,225);
					Classe[playerid] = 3;
                    SetPlayerColor(playerid, POURPRE);
					TogglePlayerControllable(playerid,true);
					TextDrawHideForPlayer(playerid,Noir);
					}
					else if(Rang[playerid] >= CORPORAL && Team[playerid] == 2)
					{
	                GivePlayerWeapon(playerid,4,1);
				    GivePlayerWeapon(playerid,23,117);
				    GivePlayerWeapon(playerid,34,225);
					Classe[playerid] = 3;
					SetPlayerColor(playerid, BLANCHE);
					TogglePlayerControllable(playerid,true);
					TextDrawHideForPlayer(playerid,Noir);
					}
	   				else
		   			{
	    			ShowPlayerDialog(playerid, 20, DIALOG_STYLE_LIST, "Menu des CLASSES :", "Assault ()\nSniper(Corporal)\nDémolisseur(Sergent)\nSaboteur(Major)\nRéparateur(Lieutenant Colonel)\nPilote (Colonel)\nPyroman (Brigadier Général)\n VIP (VIP)\nMédecin (Major)", "Sélectionné", "");
                    SendClientMessage(playerid,BLANC,"Tu n'es pas Corporal ou plus !");
					}
	   			}
	   			if(listitem == 2)
				{
					if(Rang[playerid] >= SERGENT)
					{
	                GivePlayerWeapon(playerid,16,15);
				    GivePlayerWeapon(playerid,35,3);
				    GivePlayerWeapon(playerid,27,87);
					Classe[playerid] = 4;
					TogglePlayerControllable(playerid,true);
					TextDrawHideForPlayer(playerid,Noir);
					}
	   				else
		   			{
	    			ShowPlayerDialog(playerid, 20, DIALOG_STYLE_LIST, "Menu des CLASSES :", "Assault ()\nSniper(Corporal)\nDémolisseur(Sergent)\nSaboteur(Major)\nRéparateur(Lieutenant Colonel)\nPilote (Colonel)\nPyroman (Brigadier Général)\n VIP (VIP)\nMédecin (Major)", "Sélectionné", "");
                    SendClientMessage(playerid,BLANC,"Tu n'es pas Sergent ou plus !");
					}
				}
				if(listitem == 3)
				{
					if(Rang[playerid] >= MAJOR)
					{
	                GivePlayerWeapon(playerid,31,750);
				    GivePlayerWeapon(playerid,24,87);
				    GivePlayerWeapon(playerid,34,25);
				    GivePlayerWeapon(playerid,29,830);
				    GivePlayerWeapon(playerid,4,1);
					Classe[playerid] = 5;
					TogglePlayerControllable(playerid,true);
					TextDrawHideForPlayer(playerid,Noir);
					}
	   				else
		   			{
	    			ShowPlayerDialog(playerid, 20, DIALOG_STYLE_LIST, "Menu des CLASSES :", "Assault ()\nSniper(Corporal)\nDémolisseur(Sergent)\nSaboteur(Major)\nRéparateur(Lieutenant Colonel)\nPilote (Colonel)\nPyroman (Brigadier Général)\n VIP (VIP)\nMédecin (Major)", "Sélectionné", "");
					SendClientMessage(playerid,BLANC,"Tu n'es pas Major ou plus !");
					}
				}
				if(listitem == 4)
				{
					if(Rang[playerid] >= LIEUTENANTC)
					{
	                GivePlayerWeapon(playerid,25,185);
    				GivePlayerWeapon(playerid,24,87);
    				GivePlayerWeapon(playerid,4,1);
					Classe[playerid] = 6;
					SendClientMessage(playerid,BLANC,"Tu peut réparés les véhicules toute les 2 minutes grâce à la commande /rep.");
					TogglePlayerControllable(playerid,true);
					TextDrawHideForPlayer(playerid,Noir);
					}
	   				else
		   			{
	    			ShowPlayerDialog(playerid, 20, DIALOG_STYLE_LIST, "Menu des CLASSES :", "Assault ()\nSniper(Corporal)\nDémolisseur(Sergent)\nSaboteur(Major)\nRéparateur(Lieutenant Colonel)\nPilote (Colonel)\nPyroman (Brigadier Général)\n VIP (VIP)\nMédecin (Major)", "Sélectionné", "");
                    SendClientMessage(playerid,BLANC,"Tu n'es pas Lieutenant Colonel ou plus !");
					}
				}
				if(listitem == 5)
				{
					if(Rang[playerid] >= COLONEL)
					{
	                GivePlayerWeapon(playerid,46,1);
    				GivePlayerWeapon(playerid,24,107);
    				GivePlayerWeapon(playerid,4,1);
   					SetPlayerSkin(playerid,16);
					Classe[playerid] = 7;
					SendClientMessage(playerid,BLANC,"Tu es Pilote tu peut piloté des Seasparow.");
					TogglePlayerControllable(playerid,true);
					TextDrawHideForPlayer(playerid,Noir);
					}
	   				else
		   			{
	    			ShowPlayerDialog(playerid, 20, DIALOG_STYLE_LIST, "Menu des CLASSES :", "Assault ()\nSniper(Corporal)\nDémolisseur(Sergent)\nSaboteur(Major)\nRéparateur(Lieutenant Colonel)\nPilote (Colonel)\nPyroman (Brigadier Général)\n VIP (VIP)\nMédecin (Major)", "Sélectionné", "");
                    SendClientMessage(playerid,BLANC,"Tu n'es pas Colonel ou plus !");
					}
				}
				if(listitem == 6)
				{
					if(Rang[playerid] >= BRIGADIERG)
					{
	                GivePlayerWeapon(playerid,27,150);
    				GivePlayerWeapon(playerid,25,45);
    				GivePlayerWeapon(playerid,42,35);
    				GivePlayerWeapon(playerid,18,2);
   					SetPlayerSkin(playerid,279);
					Classe[playerid] = 8;
					SendClientMessage(playerid,BLANC,"Tu es Pyroman vas cramés t'es ennemis.");
					TogglePlayerControllable(playerid,true);
					TextDrawHideForPlayer(playerid,Noir);
					}
	   				else
		   			{
	    			ShowPlayerDialog(playerid, 20, DIALOG_STYLE_LIST, "Menu des CLASSES :", "Assault ()\nSniper(Corporal)\nDémolisseur(Sergent)\nSaboteur(Major)\nRéparateur(Lieutenant Colonel)\nPilote (Colonel)\nPyroman (Brigadier Général)\n VIP (VIP)\nMédecin (Major)", "Sélectionné", "");
                    SendClientMessage(playerid,BLANC,"Tu n'es pas Colonel ou plus !");
					}
				}
				if(listitem == 7)
				{
					if(VIP[playerid] == 1)
					{
	                GivePlayerWeapon(playerid,4,1);
	                GivePlayerWeapon(playerid,24,107);
	                GivePlayerWeapon(playerid,29,230);
	                GivePlayerWeapon(playerid,31,550);
	                GivePlayerWeapon(playerid,35,1);
	                GivePlayerWeapon(playerid,17,5);

					Classe[playerid] = 9;
					SendClientMessage(playerid,BLANC,"Tu es VIP tu peut te donné un parachute de secour avec /ps.");
					TogglePlayerControllable(playerid,true);
					TextDrawHideForPlayer(playerid,Noir);
					}
	   				else
		   			{
	    			ShowPlayerDialog(playerid, 20, DIALOG_STYLE_LIST, "Menu des CLASSES :", "Assault ()\nSniper(Corporal)\nDémolisseur(Sergent)\nSaboteur(Major)\nRéparateur(Lieutenant Colonel)\nPilote (Colonel)\nPyroman (Brigadier Général)\n VIP (VIP)\nMédecin (Major)", "Sélectionné", "");
                    SendClientMessage(playerid,BLANC,"Tu n'es pas VIP !");
					}
				}
				if(listitem == 8)
				{
					if(Rang[playerid] >= MAJOR)
					{
	                GivePlayerWeapon(playerid,4,1);
    				GivePlayerWeapon(playerid,23,117);
    				GivePlayerWeapon(playerid,29,130);

					Classe[playerid] = 10;
					SendClientMessage(playerid,BLANC,"Tu es Médecin tu peut soigné t'es alliés grâce a /soigner [PlayerID].");
					TogglePlayerControllable(playerid,true);
					TextDrawHideForPlayer(playerid,Noir);
					}
	   				else
		   			{
	    			ShowPlayerDialog(playerid, 20, DIALOG_STYLE_LIST, "Menu des CLASSES :", "Assault ()\nSniper(Corporal)\nDémolisseur(Sergent)\nSaboteur(Major)\nRéparateur(Lieutenant Colonel)\nPilote (Colonel)\nPyroman (Brigadier Général)\n VIP (VIP)\nMédecin (Major)", "Sélectionné", "");
                    SendClientMessage(playerid,BLANC,"Tu n'es pas Major ou plus !");
					}
				}
			}
		}
	}
//_______________________________________________________________________//
//_______________________________________________________________________//
//_______________________________________________________________________//
//_______________________________________________________________________//
//ARMES PERSONELLE//
//_______________________________________________________________________//
//_______________________________________________________________________//
//_______________________________________________________________________//
//_______________________________________________________________________//
	if(dialogid == 35)
	{
		{
			if(response)
			{

				if(listitem == 0)
				{
    			if(Classe[playerid] == 0 && Team[playerid] == TEAM_RUSSE)
					{
	                GivePlayerWeapon(playerid,4,1);
	                GivePlayerWeapon(playerid,24,207);
	                GivePlayerWeapon(playerid,29,230);
	                GivePlayerWeapon(playerid,25,15);
	                GivePlayerWeapon(playerid,30,780);
	                Classe[playerid] = 2;
	                TogglePlayerControllable(playerid,true);
	                TextDrawHideForPlayer(playerid,Noir);
					}
					else if(Classe[playerid] == 0 && Team[playerid] == TEAM_MERCENAIRE)
					{
	                GivePlayerWeapon(playerid,4,1);
	                GivePlayerWeapon(playerid,24,207);
	                GivePlayerWeapon(playerid,29,230);
	                GivePlayerWeapon(playerid,25,15);
	                GivePlayerWeapon(playerid,30,780);
	                Classe[playerid] = 2;
	                TogglePlayerControllable(playerid,true);
	                TextDrawHideForPlayer(playerid,Noir);
					}
					else if(Classe[playerid] == 0 && Team[playerid] == TEAM_JAPON)
					{
	                GivePlayerWeapon(playerid,4,1);
	                GivePlayerWeapon(playerid,24,207);
	                GivePlayerWeapon(playerid,29,230);
	                GivePlayerWeapon(playerid,25,15);
	                GivePlayerWeapon(playerid,30,780);
	                Classe[playerid] = 2;
	                TogglePlayerControllable(playerid,true);
	                TextDrawHideForPlayer(playerid,Noir);
					}
					else if(Classe[playerid] == 0 && Team[playerid] == TEAM_ARMY )
					{
	                GivePlayerWeapon(playerid,4,1);
	                GivePlayerWeapon(playerid,24,207);
	                GivePlayerWeapon(playerid,29,230);
	                GivePlayerWeapon(playerid,25,15);
	                GivePlayerWeapon(playerid,31,750);
	                Classe[playerid] = 1;
	                TogglePlayerControllable(playerid,true);
	                TextDrawHideForPlayer(playerid,Noir);
		 			}
				}
				if(listitem == 1)
				{
	    			if(Rang[playerid] >= CORPORAL && Team[playerid] == 0 )
					{
	                GivePlayerWeapon(playerid,4,1);
				    GivePlayerWeapon(playerid,23,117);
				    GivePlayerWeapon(playerid,34,225);
					Classe[playerid] = 3;
					SetPlayerColor(playerid, BLEUE);
					TogglePlayerControllable(playerid,true);
					TextDrawHideForPlayer(playerid,Noir);
					}
					else if(Rang[playerid] >= CORPORAL && Team[playerid] == 1 )
					{
	                GivePlayerWeapon(playerid,4,1);
				    GivePlayerWeapon(playerid,23,117);
				    GivePlayerWeapon(playerid,34,225);
					Classe[playerid] = 3;
                    SetPlayerColor(playerid, POURPRE);
					TogglePlayerControllable(playerid,true);
					TextDrawHideForPlayer(playerid,Noir);
					}
					else if(Rang[playerid] >= CORPORAL && Team[playerid] == 2)
					{
	                GivePlayerWeapon(playerid,4,1);
				    GivePlayerWeapon(playerid,23,117);
				    GivePlayerWeapon(playerid,34,225);
					Classe[playerid] = 3;
					SetPlayerColor(playerid, BLANCHE);
					TogglePlayerControllable(playerid,true);
					TextDrawHideForPlayer(playerid,Noir);
					}
	   				else
		   			{
	    			ShowPlayerDialog(playerid, 35, DIALOG_STYLE_LIST, "Menu des CLASSES Prestiges :", "Assault ()\nSniper(Corporal)\nDémolisseur(Sergent)\nSaboteur(Major)\nRéparateur(Lieutenant Colonel)\nPilote (Colonel)\nPyroman (Brigadier Général)\n VIP (VIP)\nMédecin (Major)\nCLASSE PERSONNEL OPTION\nCLASSE PERSONNELLE", "Sélectionné", "");
                    SendClientMessage(playerid,BLANC,"Tu n'es pas Corporal ou plus !");
					}
	   			}
	   			if(listitem == 2)
				{
					if(Rang[playerid] >= SERGENT)
					{
	                GivePlayerWeapon(playerid,16,15);
				    GivePlayerWeapon(playerid,35,3);
				    GivePlayerWeapon(playerid,27,87);
					Classe[playerid] = 4;
					TogglePlayerControllable(playerid,true);
					TextDrawHideForPlayer(playerid,Noir);
					}
	   				else
		   			{
	    			ShowPlayerDialog(playerid, 35, DIALOG_STYLE_LIST, "Menu des CLASSES Prestiges :", "Assault ()\nSniper(Corporal)\nDémolisseur(Sergent)\nSaboteur(Major)\nRéparateur(Lieutenant Colonel)\nPilote (Colonel)\nPyroman (Brigadier Général)\n VIP (VIP)\nMédecin (Major)\nCLASSE PERSONNEL OPTION\nCLASSE PERSONNELLE", "Sélectionné", "");
                    SendClientMessage(playerid,BLANC,"Tu n'es pas Sergent ou plus !");
					}
				}
				if(listitem == 3)
				{
					if(Rang[playerid] >= MAJOR)
					{
	                GivePlayerWeapon(playerid,31,750);
				    GivePlayerWeapon(playerid,24,87);
				    GivePlayerWeapon(playerid,34,25);
				    GivePlayerWeapon(playerid,29,830);
				    GivePlayerWeapon(playerid,4,1);
					Classe[playerid] = 5;
					TogglePlayerControllable(playerid,true);
					TextDrawHideForPlayer(playerid,Noir);
					}
	   				else
		   			{
	    			ShowPlayerDialog(playerid, 35, DIALOG_STYLE_LIST, "Menu des CLASSES Prestiges :", "Assault ()\nSniper(Corporal)\nDémolisseur(Sergent)\nSaboteur(Major)\nRéparateur(Lieutenant Colonel)\nPilote (Colonel)\nPyroman (Brigadier Général)\n VIP (VIP)\nMédecin (Major)\nCLASSE PERSONNEL OPTION\nCLASSE PERSONNELLE", "Sélectionné", "");
					SendClientMessage(playerid,BLANC,"Tu n'es pas Major ou plus !");
					}
				}
				if(listitem == 4)
				{
					if(Rang[playerid] >= LIEUTENANTC)
					{
	                GivePlayerWeapon(playerid,25,185);
    				GivePlayerWeapon(playerid,24,87);
    				GivePlayerWeapon(playerid,4,1);
					Classe[playerid] = 6;
					SendClientMessage(playerid,BLANC,"Tu peut réparés les véhicules toute les 2 minutes grâce à la commande /rep.");
					TogglePlayerControllable(playerid,true);
					TextDrawHideForPlayer(playerid,Noir);
					}
	   				else
		   			{
	    			ShowPlayerDialog(playerid, 35, DIALOG_STYLE_LIST, "Menu des CLASSES Prestiges :", "Assault ()\nSniper(Corporal)\nDémolisseur(Sergent)\nSaboteur(Major)\nRéparateur(Lieutenant Colonel)\nPilote (Colonel)\nPyroman (Brigadier Général)\n VIP (VIP)\nMédecin (Major)\nCLASSE PERSONNEL OPTION\nCLASSE PERSONNELLE", "Sélectionné", "");
                    SendClientMessage(playerid,BLANC,"Tu n'es pas Lieutenant Colonel ou plus !");
					}
				}
				if(listitem == 5)
				{
					if(Rang[playerid] >= COLONEL)
					{
	                GivePlayerWeapon(playerid,46,1);
    				GivePlayerWeapon(playerid,24,107);
    				GivePlayerWeapon(playerid,4,1);
   					SetPlayerSkin(playerid,16);
					Classe[playerid] = 7;
					SendClientMessage(playerid,BLANC,"Tu es Pilote tu peut piloté des Seasparow.");
					TogglePlayerControllable(playerid,true);
					TextDrawHideForPlayer(playerid,Noir);
					}
	   				else
		   			{
	    			ShowPlayerDialog(playerid, 35, DIALOG_STYLE_LIST, "Menu des CLASSES Prestiges :", "Assault ()\nSniper(Corporal)\nDémolisseur(Sergent)\nSaboteur(Major)\nRéparateur(Lieutenant Colonel)\nPilote (Colonel)\nPyroman (Brigadier Général)\n VIP (VIP)\nMédecin (Major)\nCLASSE PERSONNEL OPTION\nCLASSE PERSONNELLE", "Sélectionné", "");
                    SendClientMessage(playerid,BLANC,"Tu n'es pas Colonel ou plus !");
					}
				}
				if(listitem == 6)
				{
					if(Rang[playerid] >= BRIGADIERG)
					{
	                GivePlayerWeapon(playerid,27,150);
    				GivePlayerWeapon(playerid,25,45);
    				GivePlayerWeapon(playerid,42,35);
    				GivePlayerWeapon(playerid,18,2);
   					SetPlayerSkin(playerid,279);
					Classe[playerid] = 8;
					SendClientMessage(playerid,BLANC,"Tu es Pyroman vas cramés t'es ennemis.");
					TogglePlayerControllable(playerid,true);
					TextDrawHideForPlayer(playerid,Noir);
					}
	   				else
		   			{
	    			ShowPlayerDialog(playerid, 35, DIALOG_STYLE_LIST, "Menu des CLASSES Prestiges :", "Assault ()\nSniper(Corporal)\nDémolisseur(Sergent)\nSaboteur(Major)\nRéparateur(Lieutenant Colonel)\nPilote (Colonel)\nPyroman (Brigadier Général)\n VIP (VIP)\nMédecin (Major)\nCLASSE PERSONNEL OPTION\nCLASSE PERSONNELLE", "Sélectionné", "");
                    SendClientMessage(playerid,BLANC,"Tu n'es pas Colonel ou plus !");
					}
				}
				if(listitem == 7)
				{
					if(VIP[playerid] == 1)
					{
	                GivePlayerWeapon(playerid,4,1);
	                GivePlayerWeapon(playerid,24,107);
	                GivePlayerWeapon(playerid,29,230);
	                GivePlayerWeapon(playerid,31,550);
	                GivePlayerWeapon(playerid,35,1);
	                GivePlayerWeapon(playerid,17,5);

					Classe[playerid] = 9;
					SendClientMessage(playerid,BLANC,"Tu es VIP tu peut te donné un parachute de secour avec /ps.");
					TogglePlayerControllable(playerid,true);
					TextDrawHideForPlayer(playerid,Noir);
					}
	   				else
		   			{
	    			ShowPlayerDialog(playerid, 35, DIALOG_STYLE_LIST, "Menu des CLASSES Prestiges :", "Assault ()\nSniper(Corporal)\nDémolisseur(Sergent)\nSaboteur(Major)\nRéparateur(Lieutenant Colonel)\nPilote (Colonel)\nPyroman (Brigadier Général)\n VIP (VIP)\nMédecin (Major)\nCLASSE PERSONNEL OPTION\nCLASSE PERSONNELLE", "Sélectionné", "");
                    SendClientMessage(playerid,BLANC,"Tu n'es pas VIP !");
					}
				}
				if(listitem == 8)
				{
					if(Rang[playerid] >= MAJOR)
					{
	                GivePlayerWeapon(playerid,4,1);
    				GivePlayerWeapon(playerid,23,117);
    				GivePlayerWeapon(playerid,29,130);

					Classe[playerid] = 10;
					SendClientMessage(playerid,BLANC,"Tu es Médecin tu peut soigné t'es alliés grâce a /soigner [PlayerID].");
					TogglePlayerControllable(playerid,true);
					TextDrawHideForPlayer(playerid,Noir);
					}
	   				else
		   			{
	    			ShowPlayerDialog(playerid, 35, DIALOG_STYLE_LIST, "Menu des CLASSES Prestiges :", "Assault ()\nSniper(Corporal)\nDémolisseur(Sergent)\nSaboteur(Major)\nRéparateur(Lieutenant Colonel)\nPilote (Colonel)\nPyroman (Brigadier Général)\n VIP (VIP)\nMédecin (Major)\nCLASSE PERSONNEL OPTION\nCLASSE PERSONNELLE", "Sélectionné", "");
                    SendClientMessage(playerid,BLANC,"Tu n'es pas Major ou plus !");
					}
				}
				if(listitem == 9)
				{
					if(Rang[playerid] >= PRESTIGEI)
					{
					ShowPlayerDialog(playerid, 36, DIALOG_STYLE_LIST, "ARMES D'ASSAULT :", "M4A1(550 M)\nAK47 (630 M)", "Sélectionné", "");
					SendClientMessage(playerid,BLANC,"Tu vas créer ta classe personnelle sélectionne les armes que tu souhête avoir.");
					}
	   				else
		   			{
	    			ShowPlayerDialog(playerid, 35, DIALOG_STYLE_LIST, "Menu des CLASSES Prestiges :", "Assault ()\nSniper(Corporal)\nDémolisseur(Sergent)\nSaboteur(Major)\nRéparateur(Lieutenant Colonel)\nPilote (Colonel)\nPyroman (Brigadier Général)\n VIP (VIP)\nMédecin (Major)\nCLASSE PERSONNEL OPTION\nCLASSE PERSONNELLE", "Sélectionné", "");
                    SendClientMessage(playerid,BLANC,"Tu n'es pas PRESTIGEI ou plus !");
					}
				}
				if(listitem == 10)
				{
					if(Rang[playerid] >= PRESTIGEI)
					{
					Classe[playerid] = 100;
                    //-________________________________________________//
					if (SlotI[playerid] == 31)
					{
					GivePlayerWeapon(playerid,SlotI[playerid],550);
					}
					if (SlotI[playerid] == 30)
					{
					GivePlayerWeapon(playerid,SlotI[playerid],630);
					}
					//-________________________________________________//
					if (SlotII[playerid] == 24)
					{
					GivePlayerWeapon(playerid,SlotII[playerid],87);
					}
                    if (SlotII[playerid] == 23)
					{
					GivePlayerWeapon(playerid,SlotII[playerid],167);
					}
					//-________________________________________________//
					if (SlotIII[playerid] == 29)
					{
					GivePlayerWeapon(playerid,SlotIII[playerid],530);
					}
					if (SlotIII[playerid] == 23)
					{
					GivePlayerWeapon(playerid,SlotIII[playerid],150);
					}
					//-________________________________________________//
					GivePlayerWeapon(playerid,SlotIIII[playerid],1);
					//-________________________________________________//
					if (SlotIIIII[playerid] == 25)
					{
					GivePlayerWeapon(playerid,SlotIIIII[playerid],150);
					}
					if (SlotIIIII[playerid] == 27)
					{
					GivePlayerWeapon(playerid,SlotIIIII[playerid],87);
					}
					//-________________________________________________//
                    if (SlotIIIII[playerid] == 16)
					{
					GivePlayerWeapon(playerid,SlotIIIIII[playerid],2);
					}
					if (SlotIIIII[playerid] == 17)
					{
					GivePlayerWeapon(playerid,SlotIIIIII[playerid],5);
					}
					TogglePlayerControllable(playerid,true);
					TextDrawHideForPlayer(playerid,Noir);
					}
	   				else
		   			{
	    			ShowPlayerDialog(playerid, 35, DIALOG_STYLE_LIST, "Menu des CLASSES Prestiges :", "Assault ()\nSniper(Corporal)\nDémolisseur(Sergent)\nSaboteur(Major)\nRéparateur(Lieutenant Colonel)\nPilote (Colonel)\nPyroman (Brigadier Général)\n VIP (VIP)\nMédecin (Major)\nCLASSE PERSONNEL OPTION\nCLASSE PERSONNELLE", "Sélectionné", "");
                    SendClientMessage(playerid,BLANC,"Tu n'es pas PRESTIGEI ou plus !");
					}
				}
			}
		}
	}
//_______________________________________________________________________//
//_______________________________________________________________________//
//_______________________________________________________________________//
//_______________________________________________________________________//
	if(dialogid == 36)
	{
		{
			if(response)
			{
				if(listitem == 0)
				{
				SlotI[playerid]=31;
				ShowPlayerDialog(playerid, 37, DIALOG_STYLE_LIST, "ARMES DE SECOURE :", "Desert Eagle (87 M)\nSilencieux (167 M)", "Sélectionné", "");
				SendClientMessage(playerid,BLANC,"Tu as pris la M4A1.");
				}
				if(listitem == 1)
				{
	    		SlotI[playerid]=30;
                ShowPlayerDialog(playerid, 37, DIALOG_STYLE_LIST, "ARMES DE SECOURE :", "Desert Eagle (87 M)\nSilencieux (167 M)", "Sélectionné", "");
				SendClientMessage(playerid,BLANC,"Tu as pris l'AK47.");
				}
			}
		}
	}
	if(dialogid == 37)
	{
		{
			if(response)
			{
				if(listitem == 0)
				{
				SlotII[playerid]=24;
				ShowPlayerDialog(playerid, 38, DIALOG_STYLE_LIST, "ARMES SECONDAIRE :", "MP5 (530 M)\n UZI (150 M)", "Sélectionné", "");
                SendClientMessage(playerid,BLANC,"Tu as pris le Desert Eagle.");
				}
				if(listitem == 1)
				{
	    		SlotII[playerid]=23;
                ShowPlayerDialog(playerid, 38, DIALOG_STYLE_LIST, "ARMES SECONDAIRE :", "MP5 (530 M)\n UZI (150 M)", "Sélectionné", "");
				SendClientMessage(playerid,BLANC,"Tu as pris le Silencieux.");
				}
			}
		}
	}
	if(dialogid == 38)
	{
		{
			if(response)
			{
				if(listitem == 0)
				{
				SlotIII[playerid]=29;
				ShowPlayerDialog(playerid, 39, DIALOG_STYLE_LIST, "ARMES DE MELEE :", "Couteau\nPelle multi-usage", "Sélectionné", "");
                SendClientMessage(playerid,BLANC,"Tu as pris le MP5.");
				}
				if(listitem == 1)
				{
	    		SlotIII[playerid]=23;
                ShowPlayerDialog(playerid, 39, DIALOG_STYLE_LIST, "ARMES DE MELEE :", "Couteau\nPelle multi-usage", "Sélectionné", "");
				SendClientMessage(playerid,BLANC,"Tu as pris l'UZI.");
				}
			}
		}
	}
	if(dialogid == 39)
	{
		{
			if(response)
			{
				if(listitem == 0)
				{
				SlotIIII[playerid]=4;
				ShowPlayerDialog(playerid, 40, DIALOG_STYLE_LIST, "FUSILS A POMPE :", "Fusil à pompe (150 M)\nSPAS-12 (87 M)", "Sélectionné", "");
                SendClientMessage(playerid,BLANC,"Tu as pris le Couteau.");
				}
				if(listitem == 1)
				{
	    		SlotIIII[playerid]=6;
                ShowPlayerDialog(playerid, 40, DIALOG_STYLE_LIST, "FUSILS A POMPE :", "Fusil à pompe\nSPAS-12", "Sélectionné", "");
				SendClientMessage(playerid,BLANC,"Tu as pris la pelle multi-usage.");
				}
			}
		}
	}
	if(dialogid == 40)
	{
		{
			if(response)
			{
				if(listitem == 0)
				{
				SlotIIIII[playerid]=25;
				ShowPlayerDialog(playerid, 41, DIALOG_STYLE_LIST, "GRENADE :", "Grenades (2)\nFumigènes (5)", "Sélectionné", "");
                SendClientMessage(playerid,BLANC,"Tu as pris le Fusil à pompe.");
				}
				if(listitem == 1)
				{
	    		SlotIIIII[playerid]=27;
                ShowPlayerDialog(playerid, 41, DIALOG_STYLE_LIST, "GRENADE :", "Grenades (2)\nFumigènes (5)", "Sélectionné", "");
				SendClientMessage(playerid,BLANC,"Tu as pris le SPAS-12.");
				}
			}
		}
	}
	if(dialogid == 41)
	{
		{
			if(response)
			{
				if(listitem == 0)
				{
				SlotIIIIII[playerid]=16;
    			SendClientMessage(playerid,BLANC,"Tu as pris les Grenades.");
    			ShowPlayerDialog(playerid, 35, DIALOG_STYLE_LIST, "Menu des CLASSES Prestiges :", "Assault ()\nSniper(Corporal)\nDémolisseur(Sergent)\nSaboteur(Major)\nRéparateur(Lieutenant Colonel)\nPilote (Colonel)\nPyroman (Brigadier Général)\n VIP (VIP)\nMédecin (Major)\nCLASSE PERSONNEL OPTION\nCLASSE PERSONNELLE", "Sélectionné", "");
				}
				if(listitem == 1)
				{
	    		SlotIIIIII[playerid]=17;
   				SendClientMessage(playerid,BLANC,"Tu as pris les Fumigènes.");
   				ShowPlayerDialog(playerid, 35, DIALOG_STYLE_LIST, "Menu des CLASSES Prestiges :", "Assault ()\nSniper(Corporal)\nDémolisseur(Sergent)\nSaboteur(Major)\nRéparateur(Lieutenant Colonel)\nPilote (Colonel)\nPyroman (Brigadier Général)\n VIP (VIP)\nMédecin (Major)\nCLASSE PERSONNEL OPTION\nCLASSE PERSONNELLE", "Sélectionné", "");
				}
			}
		}
	}
//_______________________________________________________________________//
//_______________________________________________________________________//
//_______________________________________________________________________//
//_______________________________________________________________________//
//_______________________________________________________________________//
//_______________________________________________________________________//
	if(dialogid == 1250)
	{
		{
			if(response)
			{

				if(listitem == 0)
				{
					if(GetPlayerMoney(playerid) >= 500000)
					{
	                SetTimerEx("Gazeuze", 30000, 0, "i", playerid);
                    SendClientMessageToAll(POURPRE, "");
					SendClientMessageToAll(POURPRE, "[BOMBE] Une Bombe Gazeuze est en route 30 secondes avant impact ! ");
                    SendClientMessageToAll(POURPRE, "");
					GivePlayerMoney(playerid,-500000);
					}
	   				else
		   			{
        			SendClientMessage(playerid,BLANC,"Tu n'as pas assé d'argent !");
					}
				}
				if(listitem == 1)
				{
					if(GetPlayerMoney(playerid) >= 500000)
					{
                    SetTimerEx("Nucleaire", 30000, 0, "i", playerid);
                    SendClientMessageToAll(POURPRE, "");
					SendClientMessageToAll(POURPRE, "[BOMBE] Une Bombe Nucléaire est en route 30 secondes avant impact ! ");
                    SendClientMessageToAll(POURPRE, "");
					GivePlayerMoney(playerid,-500000);
					}
	   				else
		   			{
		   			SendClientMessage(playerid,BLANC,"Tu n'as pas assé d'argent !");
					}
				}
			}
		}
	}
	if(dialogid == 30)
	{
		{
			if(response)
			{

				if(listitem == 0)
				{
    			if(GetPlayerMoney(playerid) >=4000)
					{
					GivePlayerWeapon(playerid,31,750);
	                GivePlayerMoney(playerid, -4000);
	                SendClientMessage(playerid, GRIS, "[SUCCES] Vous venez d'acheté une M4A1.");
					}
					else
					{
					SendClientMessage(playerid, GRIS, "[ERREUR] Tu n'as pas asser d'argent.");
					}
				}
				if(listitem == 1)
				{
	    			if(GetPlayerMoney(playerid) >=1500)
					{
					GivePlayerWeapon(playerid,29,430);
	                GivePlayerMoney(playerid, -1500);
	                SendClientMessage(playerid, GRIS, "[SUCCES] Vous venez d'acheté un MP5.");
					}
	   				else
		   			{
		   			SendClientMessage(playerid, GRIS, "[ERREUR] Tu n'as pas asser d'argent.");
					}
	   			}
	   			if(listitem == 2)
				{
					if(GetPlayerMoney(playerid) >=5500)
					{
					GivePlayerWeapon(playerid,34,35);
					GivePlayerMoney(playerid, -5500);
	                SendClientMessage(playerid, GRIS, "[SUCCES] Vous venez d'acheté un Sniper avec 35 balles.");
					}
	   				else
		   			{
		   			SendClientMessage(playerid, GRIS, "[ERREUR] Tu n'as pas asser d'argent.");
					}
				}
				if(listitem == 3)
				{
					if(GetPlayerMoney(playerid) >=1200)
					{
					GivePlayerWeapon(playerid,24,207);
	                GivePlayerMoney(playerid, -1200);
	                SendClientMessage(playerid, GRIS, "[SUCCES] Vous venez d'acheté un Desert Eagle.");
					}
	   				else
		   			{
		   			SendClientMessage(playerid, GRIS, "[ERREUR] Tu n'as pas asser d'argent.");
					}
				}
				if(listitem == 4)
				{
					if(GetPlayerMoney(playerid) >=850)
					{
					SetPlayerArmour(playerid, 100);
					GivePlayerMoney(playerid, -850);
	                SendClientMessage(playerid, GRIS, "[SUCCES] Vous venez d'acheté une Armure à 100 point.");
					}
	   				else
		   			{
		   			SendClientMessage(playerid, GRIS, "[ERREUR] Tu n'as pas asser d'argent.");
					}
				}
				if(listitem == 5)
				{
                ShowPlayerDialog(playerid, 55, DIALOG_STYLE_LIST, "Menu de l'Equipement Wars Points :", "\n50 Scores (100 WP)\n100 Scores (180 WP)\nBrouilleur (A Vie) (400 WP)\nVIP (450 WP)\n15 PDV au Spawn (A Vie)(300 WP)\n30 PDV au Spawn (A Vie)(400 WP)\nSkin Perso' dans une Liste (400WP) ", "Sélectionné", "Fermer");
				}
			}
		}
	}
	if(dialogid == 55)
	{
		{
			if(response)
			{

				if(listitem == 0)
				{
					if(WarsPoints[playerid] >= 100)
				    {
					SetPlayerScore(playerid,GetPlayerScore(playerid)+50);
			     	SendClientMessage(playerid, GRIS, "[SUCCES] Vous venez d'acheté 50 Scores a 100 WP.");
			     	WarsPoints[playerid]-=100;

					}
					else
				    {
				    SendClientMessage(playerid, GRIS, "[ERREUR] Vous n'avez pas assé de Wars points achetable par Allopasse.");
					}
				}
				if(listitem == 1)
				{
					if(WarsPoints[playerid] >= 180)
				    {
				    SetPlayerScore(playerid,GetPlayerScore(playerid)+100);
			     	SendClientMessage(playerid, GRIS, "[SUCCES] Vous venez d'acheté 100 Scores a 180 WP.");
					WarsPoints[playerid]-=180;

					}
				 	else
				    {
				    SendClientMessage(playerid, GRIS, "[ERREUR] Vous n'avez pas assé de Wars points achetable par Allopasse.");
					}
				}
				if(listitem == 2)
				{
					if(WarsPoints[playerid] >= 400 && Brouilleurs[playerid] == 0)
				    {
			     	SendClientMessage(playerid, GRIS, "[SUCCES] Vous venez d'acheté 1 Brouilleur à 550 WP.");
			     	Brouilleurs[playerid]=1;
			     	WarsPoints[playerid]-=400;

					}
			  		else
				    {
				    SendClientMessage(playerid, GRIS, "[ERREUR] Vous n'avez pas assé de Wars points achetable par Allopasse.");
					}
				}
				if(listitem == 3)
				{
					if(WarsPoints[playerid] >= 450)
				    {
			     	SendClientMessage(playerid, GRIS, "[SUCCES] Vous venez d'acheté le VIP a vie au prochain Spawn vous aurez plus d'information.");
			        VIP[playerid]=1;
			        WarsPoints[playerid]-=450;

				    }
			     	else
				    {
				    SendClientMessage(playerid, GRIS, "[ERREUR] Vous n'avez pas assé de Wars points achetable par Allopasse.");
					}
				}
				if(listitem == 4)
				{
					if(WarsPoints[playerid] >= 300 && SVie[playerid] == 0)
				    {
			     	SendClientMessage(playerid, GRIS, "[SUCCES] Vous venez d'acheté le 15 PDV en plus a vie au prochain Spawn.");
                    SVie[playerid] = 1;
				 	WarsPoints[playerid]-=300;

					}
				 	else
				    {
				    SendClientMessage(playerid, GRIS, "[ERREUR] Vous n'avez pas assé de Wars points ou vous avez déjà ce bonus, achetable par Allopasse.");
					}
				}
				if(listitem == 5)
				{
					if(WarsPoints[playerid] >= 400 && SVie[playerid] == 0 || SVie[playerid] == 1)
				    {
			     	SendClientMessage(playerid, GRIS, "[SUCCES] Vous venez d'acheté le 30 PDV en plus a vie au prochain Spawn.");
                    SVie[playerid] = 2;
				 	WarsPoints[playerid]-=400;

					}
				 	else
				    {
				    SendClientMessage(playerid, GRIS, "[ERREUR] Vous n'avez pas assé de Wars points ou vous avez déjà ce bonus, achetable par Allopasse.");
					}
				}
				if(listitem == 6)
				{
					if(WarsPoints[playerid] >= 400 && Skins[playerid] != 0)
				    {
			     	SendClientMessage(playerid, GRIS, "[SUCCES] Vous venez d'acheté le Skin Personnel choisisé votre Skin dans cet liste vous pouvez le choisir quand vous voulez.");
				 	WarsPoints[playerid]-=400;
				 	Skins[playerid]=1;

				 	ShowPlayerDialog(playerid, 80, DIALOG_STYLE_LIST, "Menu des Skins :", "73\n16\n29\n47\n248\n191\n181\n255\n101", "Sélectionné", "");
					}
				 	else
				    {
				    SendClientMessage(playerid, GRIS, "[ERREUR] Vous n'avez pas assé de Wars points achetable par Allopasse.");
					}
				}
			}
		}
	}
	if(dialogid == 80)
	{
		{
			if(response)
			{
				if(listitem == 0)
				{
				Skins[playerid]=73;
				SendClientMessage(playerid, BLANC, "[SUCCES] Vous venez de prendre le Skin 73 comme Skin personel vous pouvez l'activé au prochain Spawn grâce au /psk.");
				}
	   			if(listitem == 1)
				{
				Skins[playerid]=16;
				SendClientMessage(playerid, BLANC, "[SUCCES] Vous venez de prendre le Skin 16 comme Skin personel vous pouvez l'activé au prochain Spawn grâce au /psk.");
				}
				if(listitem == 2)
				{
				Skins[playerid]=29;
				SendClientMessage(playerid, BLANC, "[SUCCES] Vous venez de prendre le Skin 29 comme Skin personel vous pouvez l'activé au prochain Spawn grâce au /psk.");
				}
	   			if(listitem == 3)
				{
				Skins[playerid]=47;
				SendClientMessage(playerid, BLANC, "[SUCCES] Vous venez de prendre le Skin 47 comme Skin personel vous pouvez l'activé au prochain Spawn grâce au /psk.");
				}
				if(listitem == 4)
				{
				Skins[playerid]=248;
				SendClientMessage(playerid, BLANC, "[SUCCES] Vous venez de prendre le Skin 248 comme Skin personel vous pouvez l'activé au prochain Spawn grâce au /psk.");
				}
	   			if(listitem == 5)
				{
				Skins[playerid]=191;
				SendClientMessage(playerid, BLANC, "[SUCCES] Vous venez de prendre le Skin 191 comme Skin personel vous pouvez l'activé au prochain Spawn grâce au /psk.");
				}
				if(listitem == 6)
				{
				Skins[playerid]=181;
				SendClientMessage(playerid, BLANC, "[SUCCES] Vous venez de prendre le Skin 181 comme Skin personel vous pouvez l'activé au prochain Spawn grâce au /psk.");
				}
				if(listitem == 7)
				{
				Skins[playerid]=255;
				SendClientMessage(playerid, BLANC, "[SUCCES] Vous venez de prendre le Skin 255 comme Skin personel vous pouvez l'activé au prochain Spawn grâce au /psk.");
				}
				if(listitem == 8)
				{
				Skins[playerid]=101;
				SendClientMessage(playerid, BLANC, "[SUCCES] Vous venez de prendre le Skin 101 comme Skin personel vous pouvez l'activé au prochain Spawn grâce au /psk.");
				}
			}
		}
	}
	if(dialogid == 75)
	{
		{
			if(response)
			{

				if(listitem == 0)
				{
				ShowPlayerDialog(playerid,45,DIALOG_STYLE_MSGBOX,"{FF0000}[Les Aides Banquière]","{FFFFFF}\nVous pouvez déposer de l'argent ici par /deposer [Le MONTANT].\nOu vous pouvez retirer de l'argent par /retirer [MONTANT].\n[UTILITER ?]\nVous gagnerez 4 % de l'argent déposer a chaque fois qu'un Administrateur lanceras la paye !\nSoyez donc gentils avec !","Fermer","");
				}
	   			if(listitem == 1)
				{
				new Banquier[150];
 				format(Banquier, sizeof(Banquier), "Vous avez %d$ a votre banque.", Banque[playerid]);
 				SendClientMessage(playerid, BLANC, Banquier);
				}
			}
		}
	}
	Raffraichir(playerid);
	return 1;
}

//__________________________________________________//
//__________________________________________________//

public ClearC(playerid)
{
	SendClientMessage(playerid, BLANC,"");
    SendClientMessage(playerid, BLANC,"");
    SendClientMessage(playerid, BLANC,"");
    SendClientMessage(playerid, BLANC,"");
    SendClientMessage(playerid, BLANC,"");
    SendClientMessage(playerid, BLANC,"");
    SendClientMessage(playerid, BLANC,"");
    SendClientMessage(playerid, BLANC,"");
    SendClientMessage(playerid, BLANC,"");
    SendClientMessage(playerid, BLANC,"");
    SendClientMessage(playerid, BLANC,"");
    SendClientMessage(playerid, BLANC,"");
    SendClientMessage(playerid, BLANC,"");
    SendClientMessage(playerid, BLANC,"");
    SendClientMessage(playerid, BLANC,"");
    SendClientMessage(playerid, BLANC,"");
    SendClientMessage(playerid, BLANC,"");
    SendClientMessage(playerid, BLANC,"");
    SendClientMessage(playerid, BLANC,"");
    SendClientMessage(playerid, BLANC,"");
    SendClientMessage(playerid, BLANC,"");
    SendClientMessage(playerid, BLANC,"");
    SendClientMessage(playerid, BLANC,"");
    SendClientMessage(playerid, BLANC,"");
    SendClientMessage(playerid, BLANC,"");
    SendClientMessage(playerid, BLANC,"");
    SendClientMessage(playerid, BLANC,"");
    SendClientMessage(playerid, BLANC,"");
    SendClientMessage(playerid, BLANC,"");
    SendClientMessage(playerid, BLANC,"");
    SendClientMessage(playerid, BLANC,"");
    SendClientMessage(playerid, BLANC,"");
    SendClientMessage(playerid, BLANC,"");
    SendClientMessage(playerid, BLANC,"");
    SendClientMessage(playerid, BLANC,"");
    SendClientMessage(playerid, BLANC,"");
    SendClientMessage(playerid, BLANC,"");
    SendClientMessage(playerid, BLANC,"");
    SendClientMessage(playerid, BLANC,"");
    SendClientMessage(playerid, BLANC,"");
    SendClientMessage(playerid, BLANC,"");
	return 1;
}

//__________________________________________________//
//__________________________________________________//

public BStop(playerid)
{
	SetPlayerColor(playerid, BCouleur[playerid]);

	SetTimerEx("BCharge", 60000*10, 0, "i", playerid);
	SendClientMessage(playerid,GRIS,"Ton brouilleur est désactivé il ce recharge dans 10 minutes il serat utilisable a nouveau.");

	return 1;
}

public BCharge(playerid)
{
	BCharges[playerid]=0;
	SendClientMessage(playerid,GRIS,"Ton brouilleur est chargé utilise /brouilleur.");

	return 1;
}

//__________________________________________________//
//__________________________________________________//

public CBan(playerid)
{
	Kick(playerid);
	return 1;
}
//__________________________________________________//
//__________________________________________________//

forward Raffraichir(playerid);
public Raffraichir(playerid)
{
    TextDrawHideForPlayer(playerid,RANG[playerid]);
    Rangs(playerid);
   	Territoire(playerid);
	return 1;
}

//__________________________________________________//
//__________________________________________________//


stock KillDeathRatioForKilled(playerid,killerid)
{
	if(Team[killerid] == Team[playerid])
	{
	Death[killerid]++;

	SetPlayerHealth(playerid,0);

	GameTextForPlayer(killerid, "~w~Vous avez fait un ~n~~r~(Team Kill)-1 Score et +1 mort)", 4500, 4);

	KD[playerid] = Kill[playerid]/Death[playerid];
	KD[killerid] = Kill[killerid]/Death[killerid];

	Raffraichir(playerid);
	Raffraichir(killerid);

	Territoire(playerid);
	Territoire(killerid);
	}
	else
	{
	Combos[killerid]++;
	Combos[playerid]=0;

	Combinaison(killerid);

	Kill[killerid]++;
	Death[playerid]++;

	KD[playerid] = Kill[playerid]/Death[playerid];
	KD[killerid] = Kill[killerid]/Death[killerid];

	Raffraichir(playerid);
	Raffraichir(killerid);

	SetPlayerHealth(playerid,0);

	Territoire(playerid);
	Territoire(killerid);
	}
}

stock SetMapName(name[])
{
    new Mapstr[64];
	format( Mapstr, sizeof Mapstr, "mapname %s", name );
    return SendRconCommand(Mapstr);
}

