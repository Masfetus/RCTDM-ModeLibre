
#include <a_samp>

// PARAMETRE
 
//#define USE_MYSQL // Decomenter pour utiliser mysql
#define USE_MENU // Decomenter pour utiliser la gestion par menu
//#define USE_CALLCAR //Decomenter pour avoir la posibiliter d'appeler un de nos vehicule
//#define FILTERSCRIPT //Decomenter pour utiliser le script comme un FilterScripts


#define MAX_PLAYER_VEHICLES 2  //Nombre de vehicules par joueur
#define PRIX_ESSENCE 		5  //Prix du litre d'essence
#define SECONDE_LITRE       60  //Nombre de seconde pour retirer 1 litre d'essence au vehicule
#define RESPAWN_DELAY       -1 // Temps de respawn en seconde (-1 = Pas de respawn)
#define TIMESAVE       1800000 // Temps en MS du timer de sauvegarde des vehicule (1800000 = Sauvegarde toute les 30 minutes)


// PARAMETRE MYSQL
#if defined USE_MYSQL
	#include <a_sampmysql>
	#define MYSQL_HOST 			"box2.hosting-facile.com"
	#define MYSQL_USER 			"Matthias" // nom d'utilisateur MySQL
	#define MYSQL_PASS 			"afanu0882la"// Mot de passe MySQL
	#define MYSQL_DB_SERVEUR 	"Site" //Nom de la base de donnee
	#define MYSQL_TB_VEH        "vehicule" // Nom de la table des vehicule
#else
	#define VEH_FILENAME        "vehinfo.cfg"
#endif

// PARAMETRE FILTERSCRIPTS
#if defined FILTERSCRIPT
	#define Script_OnGameModeInit OnFilterScriptInit
	#define Script_OnGameModeExit OnFilterScriptExit
	#define Script_OnPlayerPickUpPickup OnPlayerPickUpPickup
	#define Script_OnPlayerConnect OnPlayerConnect
	#define Script_OnPlayerDisconnect OnPlayerDisconnect
	#define Script_OnVehicleDeath OnVehicleDeath
	#define Script_OnPlayerCommandText OnPlayerCommandText
	#define Script_OnPlayerExitVehicle OnPlayerExitVehicle
	#define Script_OnPlayerKeyStateChange OnPlayerKeyStateChange
	#define Script_OnPlayerStateChange OnPlayerStateChange
	#define Script_OnPlayerText OnPlayerText
	#define Script_OnPlayerSelectedMenuRow OnPlayerSelectedMenuRow
	#define Script_OnPlayerExitedMenu OnPlayerExitedMenu
	#define Script_OnVehicleMod OnVehicleMod
	#define Script_OnVehiclePaintjob OnVehiclePaintJob
	#define Script_OnVehicleRespray OnVehicleRespray
#endif

#define COL_WHITE  	    	0xFFFFFFFF
#define COL_LIGHTRED    	0xFF2F35FF
#define COL_GREEN 	 	    0x429D3DFF
#define COL_YELLOW      	0xF2FB25FF
#define COL_RED            	0xBD0000FF
#define COLOR_RED           0xBD0000FF
#define COLOR_PURPLE        0xC2A2DAAA
#define ORANGE              0xF97804FF
#define INVALID_VEH_ID      0
#define Veh                 "savedpositions.txt"

forward Script_OnGameModeInit();
forward Script_OnGameModeExit();
forward Script_OnPlayerPickUpPickup(playerid, pickupid);
forward Script_OnPlayerConnect(playerid);
forward Script_OnPlayerDisconnect(playerid);
forward Script_OnVehicleDeath(vehicleid);
forward Script_OnPlayerCommandText(playerid,cmdtext[]);
forward Script_OnPlayerExitVehicle(playerid);
forward Script_OnPlayerKeyStateChange(playerid, newkeys);
forward Script_OnPlayerStateChange(playerid, newstate);
forward Script_OnPlayerText(playerid, text[]);
forward Script_OnPlayerSelectedMenuRow(playerid, row);
forward Script_OnPlayerExitedMenu(playerid);
forward Script_OnVehicleMod(playerid, vehicleid, componentid);
forward Script_OnVehiclePaintjob(playerid, vehicleid, paintjobid);
forward Script_OnVehicleRespray(playerid, vehicleid, color1, color2);
forward SauvegardeVeh();
forward Remplisage(playerid);
forward Vitesse();
forward DestroyVeh(vehicleid);
forward RestartVeh(vehicleid);
forward CallCar(playerid,vehicleid);
forward CreateVeh(vehicleid,Float:x,Float:y,Float:z,Float:a);
forward Demmarage(playerid);
forward IsAnRadar(playerid);
forward EsUnAvion(carid);
new NbVeh = 1;
new Flashing[MAX_PLAYER_NAME];
static Field[32][64];
static TimerSave;
static TimerVitesse;
static Text:BarreVieVeh[12];

// Position de pompe a essence
static Float:Pompe[21][3] = {
{2109.2126,917.5845,10.8203},
{2640.1831,1103.9224,10.8203},
{611.8934,1694.7921,6.7193},
{-1327.5398,2682.9771,49.7896},
{-2413.7427,975.9317,45.0031},
{-1672.3597,414.2950,6.8866},
{-2244.1365,-2560.6294,31.6276},
{-1603.0166,-2709.3589,48.2419},
{1939.3275,-1767.6813,13.2787},
{-94.7651,-1174.8079,1.9979},
{1381.6699,462.6467,19.8540},
{657.8167,-559.6507,16.0630},
{-1478.2916,1862.8318,32.3617},
{2147.3054,2744.9377,10.5263},
{2204.9602,2480.3494,10.5278},
{1590.9493,2202.2637,10.5247},
{1561.5695,1448.6895,10.3636},
{366.4071,2535.3784,16.8363},
{1969.3317,-2303.8423,13.2547},
{1587.3940,-2182.4717,13.5547},
{-2028.1575,156.7560,28.8359}
};

static PickupPompe[sizeof(Pompe)];
new Float:Radars[1][3] = {
    {-2004.5272,145.4511,27.5391}
};
enum VehInfo
{
	VehID,
	Model,
	Float:XSpawn,
	Float:YSpawn,
	Float:ZSpawn,
	Float:ASpawn,
	Couleur1,
	Couleur2,
	Prix,
	Status,
	Alarme,
	Tuning1,
	Tuning2,
	Tuning3,
	Tuning4,
	Tuning5,
	Tuning6,
	Tuning7,
	Tuning8,
	Tuning9,
	Tuning10,
	Tuning11,
	Tuning12,
	Tuning13,
	Tuning14,
	Tuning15,
	Tuning16,
	Tuning17,
	Peinture,
	MaxEssence,
	Proprio[MAX_PLAYER_NAME],
	Nom[64],
	Essence,
	Moteur,
}
new VehiculeInfo[MAX_VEHICLES][VehInfo];

static EssenceCount[MAX_VEHICLES];

new VehicleName[212][64] = {
   "Landstalker","Bravura","Buffalo","Linerunner","Pereniel","Sentinel","Dumper","Firetruck","Trashmaster","Stretch","Manana",
   "Infernus","Voodoo","Pony","Mule","Cheetah","Ambulance","Leviathan","Moonbeam","Esperanto","Taxi","Washington","Bobcat",
   "Mr Whoopee","BF Injection","Hunter","Premier","Enforcer","Securicar","Banshee","Predator","Bus","Rhino","Barracks","Hotknife",
   "Trailer","Previon","Coach","Cabbie","Stallion","Rumpo","RC Bandit","Romero","Packer","Monster Truck","Admiral","Squalo",
   "Seasparrow","Pizzaboy","Tram","Trailer","Turismo","Speeder","Reefer","Tropic","Flatbed","Yankee","Caddy","Solair","Berkley's RC Van",
   "Skimmer","PCJ-600","Faggio","Freeway","RC Baron","RC Raider","Glendale","Oceanic","Sanchez","Sparrow","Patriot","Quad","Coastguard",
   "Dinghy","Hermes","Sabre","Rustler","ZR-350","Walton","Regina","Comet","BMX","Burrito","Camper","Marquis","Baggage","Dozer","Maverick",
   "News Chopper","Rancher","FBI Rancher","Virgo","Greenwood","Jetmax","Hotring","Sandking","Blista Compact","Police Maverick","Boxville",
   "Benson","Mesa","RC Goblin","Hotring Racer","Hotring Racer","Bloodring Banger","Rancher","Super GT","Elegant","Journey","Bike","Mountain Bike",
   "Beagle","Cropdust","Stunt","Tanker","RoadTrain","Nebula","Majestic","Buccaneer","Shamal","Hydra","FCR-900","NRG-500","HPV1000",
   "Cement Truck","Tow Truck","Fortune","Cadrona","FBI Truck","Willard","Forklift","Tractor","Combine","Feltzer","Remington","Slamvan","Blade",
   "Freight","Streak","Vortex","Vincent","Bullet","Clover","Sadler","Firetruck","Hustler","Intruder","Primo","Cargobob","Tampa","Sunrise",
   "Merit","Utility","Nevada","Yosemite","Windsor","Monster Truck","Monster Truck","Uranus","Jester","Sultan","Stratum","Elegy","Raindance",
   "RC Tiger","Flash","Tahoma","Savanna","Bandito","Freight","Trailer","Kart","Mower","Duneride","Sweeper","Broadway","Tornado","AT-400",
   "DFT-30","Huntley","Stafford","BF-400","Newsvan","Tug","Trailer","Emperor","Wayfarer","Euros","Hotdog","Club","Trailer","Trailer","Andromada",
   "Dodo","RC Cam","Launch","Police Car (LSPD)","Voiture de Police","Police Car (LVPD)","Police Ranger","Picador","S.W.A.T. Van","Alpha",
   "Phoenix","Glendale","Sadler","Luggage Trailer","Luggage Trailer","Stair Trailer","Boxville","Farm Plow","Utility Trailer"
};

new spoiler[20][0] = {
	{1000},{1001},{1002},{1003},{1014},{1015},{1016},{1023},{1058},{1060},
	{1049},{1050},{1138},{1139},{1146},{1147},{1158},{1162},{1163},{1164}
};

new nitro[3][0] = {
    {1008},{1009},{1010}
};

new fbumper[23][0] = {
    {1117},{1152},{1153},{1155},{1157},{1160},{1165},{1167},{1169},{1170},
    {1171},{1172},{1173},{1174},{1175},{1179},{1181},{1182},{1185},{1188},
    {1189},{1192},{1193}
};

new rbumper[22][0] = {
    {1140},{1141},{1148},{1149},{1150},{1151},{1154},{1156},{1159},{1161},
    {1166},{1168},{1176},{1177},{1178},{1180},{1183},{1184},{1186},{1187},
    {1190},{1191}
};

new exhaust[28][0] = {
    {1018},{1019},{1020},{1021},{1022},{1028},{1029},{1037},{1043},{1044},
    {1045},{1046},{1059},{1064},{1065},{1066},{1089},{1092},{1104},{1105},
	{1113},{1114},{1126},{1127},{1129},{1132},{1135},{1136}
};

new bventr[2][0] = {
    {1042},{1044}
};

new bventl[2][0] = {
    {1043},{1045}
};

new bscoop[4][0] = {
	{1004},{1005},{1011},{1012}
};

new rscoop[13][0] = {
    {1006},{1032},{1033},{1035},{1038},{1053},{1054},{1055},{1061},{1067},
    {1068},{1088},{1091}
};

new lskirt[21][0] = {
    {1007},{1026},{1031},{1036},{1039},{1042},{1047},{1048},{1056},{1057},
    {1069},{1070},{1090},{1093},{1106},{1108},{1118},{1119},{1133},{1122},
	{1134}
};

new rskirt[21][0] = {
    {1017},{1027},{1030},{1040},{1041},{1051},{1052},{1062},{1063},{1071},
    {1072},{1094},{1095},{1099},{1101},{1102},{1107},{1120},{1121},{1124},
    {1137}
};

new hydraulics[1][0] = {
    {1087}
};

new base[1][0] = {
    {1086}
};

new rbbars[2][0] = {
    {1109},{1110}
};

new fbbars[2][0] = {
	{1115},{1116}
};

new wheels[17][0] = {
    {1025},{1073},{1074},{1075},{1076},{1077},{1078},{1079},{1080},{1081},
    {1082},{1083},{1084},{1085},{1096},{1097},{1098}
};

new lights[2][0] = {
	{1013},{1024}
};

#if defined USE_MENU
	static Menu:MenuJoueur;
	static Menu:MenuAdmin;
	static DefinirPrix[MAX_PLAYERS];
	static DefinirEssence[MAX_PLAYERS];
#endif

static PompeEssence[MAX_PLAYERS];
static TimerEssence[MAX_PLAYERS];
static TableauActive[MAX_PLAYERS];
static EnPanne[MAX_PLAYERS];
static Float:PlayerPos[MAX_PLAYERS][3];
static EchangeVeh[MAX_PLAYERS][3];

#if defined USE_CALLCAR
	static MyVehicleID[MAX_PLAYERS][MAX_PLAYER_VEHICLES];
#endif

public Script_OnGameModeInit()
{
	print("\n");
	#if defined USE_MYSQL

		if(!samp_mysql_connect(MYSQL_HOST,MYSQL_USER,MYSQL_PASS))
		{
			printf("\n ------   ATTENTION: La connection au serveur mysql a echoué! ------   \n");
			return 1;
		}
		if(!samp_mysql_select_db(MYSQL_DB_SERVEUR))
		{
		    printf("\n ------   ATTENTION: La base de donnee '%s' est introuvable ------   \n",MYSQL_DB_SERVEUR);
			return 1;
		}
		if(!samp_mysql_table_exist(MYSQL_TB_VEH))
		{
		    printf("\n ------   ATTENTION: La table '%s' n'existe pas ------   \n",MYSQL_TB_VEH);
		    return 1;
		}
		
		print("\n-------------[CHARGEMENT VEHICULE]-------------\n");
		new query[64];
		new resultline[1024];
		format(query,sizeof(query),"SELECT * FROM %s",MYSQL_TB_VEH);
		samp_mysql_query(query);
		samp_mysql_store_result();
		while(samp_mysql_fetch_row(resultline)==1)
		{
			split2(resultline, Field, '|');
			if(NbVeh >= MAX_VEHICLES) break;
			VehiculeInfo[NbVeh][VehID]		= strval(Field[0]);
			VehiculeInfo[NbVeh][Model]		= strval(Field[1]);
			VehiculeInfo[NbVeh][XSpawn]		= floatstr(Field[2]);
			VehiculeInfo[NbVeh][YSpawn]	 	= floatstr(Field[3]);
			VehiculeInfo[NbVeh][ZSpawn] 	= floatstr(Field[4]);
			VehiculeInfo[NbVeh][ASpawn]	  	= floatstr(Field[5]);
			VehiculeInfo[NbVeh][Couleur1]	= strval(Field[6]);
			VehiculeInfo[NbVeh][Couleur2]	= strval(Field[7]);
			VehiculeInfo[NbVeh][Prix]       = strval(Field[8]);
			VehiculeInfo[NbVeh][Status]     = strval(Field[9]);
			VehiculeInfo[NbVeh][Alarme]	  	= strval(Field[10]);
			VehiculeInfo[NbVeh][Tuning1]	= strval(Field[11]);
			VehiculeInfo[NbVeh][Tuning2]	= strval(Field[12]);
			VehiculeInfo[NbVeh][Tuning3]	= strval(Field[13]);
			VehiculeInfo[NbVeh][Tuning4]	= strval(Field[14]);
			VehiculeInfo[NbVeh][Tuning5]	= strval(Field[15]);
			VehiculeInfo[NbVeh][Tuning6]	= strval(Field[16]);
			VehiculeInfo[NbVeh][Tuning7]	= strval(Field[17]);
			VehiculeInfo[NbVeh][Tuning8]	= strval(Field[18]);
			VehiculeInfo[NbVeh][Tuning9]	= strval(Field[19]);
			VehiculeInfo[NbVeh][Tuning10]	= strval(Field[20]);
			VehiculeInfo[NbVeh][Tuning11]	= strval(Field[21]);
			VehiculeInfo[NbVeh][Tuning12]	= strval(Field[22]);
			VehiculeInfo[NbVeh][Tuning13]	= strval(Field[23]);
			VehiculeInfo[NbVeh][Tuning14]	= strval(Field[24]);
			VehiculeInfo[NbVeh][Tuning15]	= strval(Field[25]);
			VehiculeInfo[NbVeh][Tuning16]	= strval(Field[26]);
			VehiculeInfo[NbVeh][Tuning17]	= strval(Field[27]);
			VehiculeInfo[NbVeh][Peinture]	= strval(Field[28]);
			VehiculeInfo[NbVeh][MaxEssence] = strval(Field[29]);
			strmid(VehiculeInfo[NbVeh][Proprio],     Field[30], 0, strlen(Field[30]),MAX_PLAYER_NAME);
			strmid(VehiculeInfo[NbVeh][Nom],VehicleName[VehiculeInfo[NbVeh][Model]-400],0,strlen(VehicleName[VehiculeInfo[NbVeh][Model]-400]),64);
			VehiculeInfo[NbVeh][Essence] = VehiculeInfo[NbVeh][MaxEssence];
			EssenceCount[NbVeh] = 0;
			VehiculeInfo[NbVeh][Moteur] = 0;

			CreateVehicle(VehiculeInfo[NbVeh][Model],VehiculeInfo[NbVeh][XSpawn],VehiculeInfo[NbVeh][YSpawn],VehiculeInfo[NbVeh][ZSpawn],VehiculeInfo[NbVeh][ASpawn],VehiculeInfo[NbVeh][Couleur1],VehiculeInfo[NbVeh][Couleur2],RESPAWN_DELAY);
			TuningVehicule(NbVeh);
			printf("---- Vehicule %d charger. Proprio: %s , Nom vehicule %s ----",NbVeh,VehiculeInfo[NbVeh][Proprio],VehiculeInfo[NbVeh][Nom]);
			NbVeh++;
		}
		samp_mysql_free_result();

	#else
 		
 		if(fexist(VEH_FILENAME))
 		{
 		    print("\n-------------[CHARGEMENT VEHICULE]-------------\n");
 		    new File:VehFile = fopen(VEH_FILENAME, io_read);
 		    new vehstring[512];
	   		while(fread(VehFile, vehstring, sizeof(vehstring)))
	   		{
	   		    if(split2(vehstring, Field, '|') == 32)
	   		    {
					VehiculeInfo[NbVeh][VehID]		= strval(Field[0]);
					VehiculeInfo[NbVeh][Model]		= strval(Field[1]);
					VehiculeInfo[NbVeh][XSpawn]		= floatstr(Field[2]);
					VehiculeInfo[NbVeh][YSpawn]	 	= floatstr(Field[3]);
					VehiculeInfo[NbVeh][ZSpawn] 	= floatstr(Field[4]);
					VehiculeInfo[NbVeh][ASpawn]	  	= floatstr(Field[5]);
					VehiculeInfo[NbVeh][Couleur1]	= strval(Field[6]);
					VehiculeInfo[NbVeh][Couleur2]	= strval(Field[7]);
					VehiculeInfo[NbVeh][Prix]       = strval(Field[8]);
					VehiculeInfo[NbVeh][Status]     = strval(Field[9]);
					VehiculeInfo[NbVeh][Alarme]	  	= strval(Field[10]);
					VehiculeInfo[NbVeh][Tuning1]	= strval(Field[11]);
					VehiculeInfo[NbVeh][Tuning2]	= strval(Field[12]);
					VehiculeInfo[NbVeh][Tuning3]	= strval(Field[13]);
					VehiculeInfo[NbVeh][Tuning4]	= strval(Field[14]);
					VehiculeInfo[NbVeh][Tuning5]	= strval(Field[15]);
					VehiculeInfo[NbVeh][Tuning6]	= strval(Field[16]);
					VehiculeInfo[NbVeh][Tuning7]	= strval(Field[17]);
					VehiculeInfo[NbVeh][Tuning8]	= strval(Field[18]);
					VehiculeInfo[NbVeh][Tuning9]	= strval(Field[19]);
					VehiculeInfo[NbVeh][Tuning10]	= strval(Field[20]);
					VehiculeInfo[NbVeh][Tuning11]	= strval(Field[21]);
					VehiculeInfo[NbVeh][Tuning12]	= strval(Field[22]);
					VehiculeInfo[NbVeh][Tuning13]	= strval(Field[23]);
					VehiculeInfo[NbVeh][Tuning14]	= strval(Field[24]);
					VehiculeInfo[NbVeh][Tuning15]	= strval(Field[25]);
					VehiculeInfo[NbVeh][Tuning16]	= strval(Field[26]);
					VehiculeInfo[NbVeh][Tuning17]	= strval(Field[27]);
					VehiculeInfo[NbVeh][Peinture]	= strval(Field[28]);
					VehiculeInfo[NbVeh][MaxEssence] = strval(Field[29]);
					strmid(VehiculeInfo[NbVeh][Proprio],     Field[30], 0, strlen(Field[30]),128);
					strmid(VehiculeInfo[NbVeh][Nom],VehicleName[VehiculeInfo[NbVeh][Model]-400],0,strlen(VehicleName[VehiculeInfo[NbVeh][Model]-400]),64);
					VehiculeInfo[NbVeh][Essence] = VehiculeInfo[NbVeh][MaxEssence];
					EssenceCount[NbVeh] = 0;

					CreateVehicle(VehiculeInfo[NbVeh][Model],VehiculeInfo[NbVeh][XSpawn],VehiculeInfo[NbVeh][YSpawn],VehiculeInfo[NbVeh][ZSpawn],VehiculeInfo[NbVeh][ASpawn],VehiculeInfo[NbVeh][Couleur1],VehiculeInfo[NbVeh][Couleur2],RESPAWN_DELAY);
					TuningVehicule(NbVeh);
					printf("---- Vehicule %d charger. Proprio: %s , Nom vehicule %s ----",VehiculeInfo[NbVeh][VehID],VehiculeInfo[NbVeh][Proprio],VehiculeInfo[NbVeh][Nom]);
					NbVeh++;
				}
			}
			fclose(VehFile);
		}
		else
		{
		    printf("Le fichier %s n'existe pas!, Aucun vehicule na pu être cree!",VEH_FILENAME);
		}
	#endif
	print("\n");
	
	#if defined USE_MENU
	
		MenuJoueur = CreateMenu("Menu Joueur",1,440,140,150,40);
		AddMenuItem(MenuJoueur,0,"Acheter");
		AddMenuItem(MenuJoueur,0,"Vendre");
 		AddMenuItem(MenuJoueur,0,"Garer");
		AddMenuItem(MenuJoueur,0,"Alarme");
		AddMenuItem(MenuJoueur,0,"Essence");
		AddMenuItem(MenuJoueur,0,"Tableau de bord");
		#if defined USE_CALLCAR
			AddMenuItem(MenuJoueur,0,"CallCar");
		#endif
		AddMenuItem(MenuJoueur,0,"Exit");

        MenuAdmin = CreateMenu("Menu Admin",1,440,140,150,40);
		AddMenuItem(MenuAdmin,0,"Prix");
		AddMenuItem(MenuAdmin,0,"Alarme Admin");
		AddMenuItem(MenuAdmin,0,"Vendre");
		AddMenuItem(MenuAdmin,0,"Status");
		AddMenuItem(MenuAdmin,0,"Garer");
		AddMenuItem(MenuAdmin,0,"Essence");
		AddMenuItem(MenuAdmin,0,"MaxEssence");
		AddMenuItem(MenuAdmin,0,"Reset Tuning");
		AddMenuItem(MenuAdmin,0,"Exit");
		
	#endif
	
	for(new p=0;p<sizeof(Pompe);p++)
	{
		PickupPompe[p] = CreatePickup(1239,1,Pompe[p][0],Pompe[p][1],Pompe[p][2]);
	}
	
 	BarreVieVeh[0] = TextDrawCreate(549.0, 50.0, "BOUM!");
	TextDrawUseBox(BarreVieVeh[0], 1);
	TextDrawBoxColor(BarreVieVeh[0], COL_RED);
	TextDrawSetShadow(BarreVieVeh[0],0);
	TextDrawTextSize(BarreVieVeh[0], 625, 0);

	BarreVieVeh[1] = TextDrawCreate(551.0, 59.0, " ");
	TextDrawUseBox(BarreVieVeh[1], 1);
	TextDrawBoxColor(BarreVieVeh[1], COL_RED);
	TextDrawSetShadow(BarreVieVeh[1],0);
	TextDrawTextSize(BarreVieVeh[1], 551, 0);

	BarreVieVeh[2] = TextDrawCreate(551.0, 59.0, " ");
	TextDrawUseBox(BarreVieVeh[2], 1);
	TextDrawBoxColor(BarreVieVeh[2], COL_RED);
	TextDrawSetShadow(BarreVieVeh[2],0);
	TextDrawTextSize(BarreVieVeh[2], 556, 0);

	BarreVieVeh[3] = TextDrawCreate(551.0, 59.0, " ");
	TextDrawUseBox(BarreVieVeh[3], 1);
	TextDrawBoxColor(BarreVieVeh[3], COL_RED);
	TextDrawSetShadow(BarreVieVeh[3],0);
	TextDrawTextSize(BarreVieVeh[3], 561, 0);

	BarreVieVeh[4] = TextDrawCreate(551.0, 59.0, " ");
	TextDrawUseBox(BarreVieVeh[4], 1);
	TextDrawBoxColor(BarreVieVeh[4], COL_YELLOW);
	TextDrawSetShadow(BarreVieVeh[4],0);
	TextDrawTextSize(BarreVieVeh[4], 566, 0);

	BarreVieVeh[5] = TextDrawCreate(551.0, 59.0, " ");
	TextDrawUseBox(BarreVieVeh[5], 1);
	TextDrawBoxColor(BarreVieVeh[5], COL_YELLOW);
	TextDrawSetShadow(BarreVieVeh[5],0);
	TextDrawTextSize(BarreVieVeh[5], 571, 0);

	BarreVieVeh[6] = TextDrawCreate(551.0, 59.0, " ");
	TextDrawUseBox(BarreVieVeh[6], 1);
	TextDrawBoxColor(BarreVieVeh[6], COL_YELLOW);
	TextDrawSetShadow(BarreVieVeh[6],0);
	TextDrawTextSize(BarreVieVeh[6], 576, 0);

	BarreVieVeh[7] = TextDrawCreate(551.0, 59.0, " ");
	TextDrawUseBox(BarreVieVeh[7], 1);
	TextDrawBoxColor(BarreVieVeh[7], COL_YELLOW);
	TextDrawSetShadow(BarreVieVeh[7],0);
	TextDrawTextSize(BarreVieVeh[7], 581, 0);

	BarreVieVeh[8] = TextDrawCreate(551.0, 59.0, " ");
	TextDrawUseBox(BarreVieVeh[8], 1);
	TextDrawBoxColor(BarreVieVeh[8], COL_GREEN);
	TextDrawSetShadow(BarreVieVeh[8],0);
	TextDrawTextSize(BarreVieVeh[8], 586, 0);

	BarreVieVeh[9] = TextDrawCreate(551.0, 59.0, " ");
	TextDrawUseBox(BarreVieVeh[9], 1);
	TextDrawBoxColor(BarreVieVeh[9], COL_GREEN);
	TextDrawSetShadow(BarreVieVeh[9],0);
	TextDrawTextSize(BarreVieVeh[9], 591, 0);

	BarreVieVeh[10] = TextDrawCreate(551.0, 59.0, " ");
	TextDrawUseBox(BarreVieVeh[10], 1);
	TextDrawBoxColor(BarreVieVeh[10], COL_GREEN);
	TextDrawSetShadow(BarreVieVeh[10],0);
	TextDrawTextSize(BarreVieVeh[10], 596, 0);

	BarreVieVeh[11] = TextDrawCreate(551.0, 59.0, " ");
	TextDrawUseBox(BarreVieVeh[11], 1);
	TextDrawBoxColor(BarreVieVeh[11], COL_GREEN);
	TextDrawSetShadow(BarreVieVeh[11],0);
	TextDrawTextSize(BarreVieVeh[11], 602, 0);
	
	
	TimerSave = SetTimer("SauvegardeVeh",TIMESAVE,1);
	TimerVitesse = SetTimer("Vitesse", 500, 1);
	#if defined FILTERSCRIPT
		print(" --------------------------------------------");
		print("|   [FS] Gestion Vehicule | By mister-fred   |");
		print(" --------------------------------------------\n");
	#else
		print(" --------------------------------------------");
		print("|   [INC] Gestion Vehicule | By mister-fred   |");
		print(" --------------------------------------------\n");
	#endif
	return 1;
}
public Script_OnGameModeExit()
{
	SauvegardeVeh();

	#if defined USE_MENU
	
	    DestroyMenu(MenuJoueur);
	    DestroyMenu(MenuAdmin);
	    
	#endif
	
	KillTimer(TimerSave);
	KillTimer(TimerVitesse);
	
	for(new i=0;i<MAX_PLAYERS;i++)
	{
		if(IsPlayerConnected(i) && PompeEssence[i] != 255)
		{
		    KillTimer(TimerEssence[i]);
		}
	}
	#if defined USE_MYSQL
		samp_mysql_close();
	#endif
	return 1;
}

public Script_OnPlayerPickUpPickup(playerid, pickupid)
{
	for(new p=0;p<sizeof(Pompe);p++)
	{
	    if(PickupPompe[p] == pickupid)
	    {
			#if defined USE_MENU
			    SendClientMessage(playerid,COL_GREEN,"Bienvenu a la pompe a essence. Pour remplir votre vehicule taper /vmenu et selectioner 'Essence'");
			#else
				SendClientMessage(playerid,COL_GREEN,"Bienvenu a la pompe a essence. Pour remplir votre vehicule taper /vessence");
			#endif
		}
	}
	return 1;
}

public Script_OnPlayerConnect(playerid)
{
	new playername[MAX_PLAYER_NAME],string[128];
	GetPlayerName(playerid,playername,sizeof(playername));
	#if defined FILTERSCRIPT
		format(string,sizeof(string),"Bienvenu %s, Ce serveur utilise [FS] Gestion Vehicule By mister-fred!",playername);
	#else
	    format(string,sizeof(string),"Bienvenu %s, Ce serveur utilise [INC] Gestion Vehicule By mister-fred!",playername);
	#endif
	PlayerPos[playerid][0] = 0; PlayerPos[playerid][1] = 0; PlayerPos[playerid][2] = 0;
	PompeEssence[playerid] = 255;
	TableauActive[playerid] = 1;
	EnPanne[playerid] = 0;
	EchangeVeh[playerid][0] = 255; EchangeVeh[playerid][1] = 0; EchangeVeh[playerid][2] = 0;
	#if defined USE_MENU
		DefinirPrix[playerid] = 0;
		DefinirEssence[playerid] = 0;
	#endif
	#if defined USE_CALLCAR
		for(new c=0;c<MAX_PLAYER_VEHICLES;c++)
		{
		    MyVehicleID[playerid][c] = 0;
		}
	#endif
	for(new m=0;m<sizeof(Pompe);m++)
	{
		SetPlayerMapIcon(playerid,m,Pompe[m][0],Pompe[m][1],Pompe[m][2],51,1);
	}
	for(new b=0;b<sizeof(BarreVieVeh);b++)
	{
		TextDrawHideForPlayer(playerid,BarreVieVeh[b]);
	}
	Flashing[playerid] = 0;
	return 1;
}

public Script_OnPlayerDisconnect(playerid)
{
	if(PompeEssence[playerid] != 255)
	{
	    KillTimer(TimerEssence[playerid]);
	}
	return 1;
}

public Script_OnVehicleDeath(vehicleid)
{
	SetTimerEx("RestartVeh",10000,0,"i",vehicleid);
	return 1;
}

public Script_OnPlayerCommandText(playerid,cmdtext[])
{
	new cmd[128],string[128],tmp[128];
	new idx;
	cmd = strtok2(cmdtext, idx);
	
	#if defined USE_MENU
		if(strcmp(cmd, "/vmenu", true) == 0)
		{
		    if(IsPlayerConnected(playerid))
		    {
     			ShowMenuForPlayer(MenuJoueur,playerid);
       			TogglePlayerControllable(playerid, 0);
		    }
		    return 1;
		}
   		if(!strcmp(cmdtext, "/carlist", true))
	    {
			new playername[MAX_PLAYER_NAME],string12[128];
			SendClientMessage(playerid,COL_WHITE,"------[LISTE DE VOS VEHICULE]------");
			GetPlayerName(playerid,playername,sizeof(playername));
			new count = 0;
			for(new v=1;v<NbVeh;v++)
			{
			    if(VehiculeInfo[v][VehID] != INVALID_VEH_ID)
				{
					if(strcmp(VehiculeInfo[v][Proprio],playername,true) == 0)
				    {
					    format(string12,sizeof(string12),"%d: %s",count+1,VehiculeInfo[v][Nom]);
						SendClientMessage(playerid,COL_WHITE,string12);
						count++;
					}
				}
			}
			return 1;
		}
   		if(!strcmp(cmdtext, "/moteur", true))
	    {
		    if(IsPlayerInAnyVehicle(playerid))
            {
	    		if(IsPlayerConnected(playerid))
	    		{
		    		new sendername[32];
					new car = GetPlayerVehicleID(playerid);
					if(EsUnAvion(car)){ return 1; }
			  	   	GetPlayerName(playerid, sendername, sizeof(sendername));	
			    	if(VehiculeInfo[car][Moteur] == 1) 
					{ 
                     	if(PlayerInfo[playerid][pMaskuse] == 1)
	                	{
			     	    	ProxDetector(30.0, playerid, "* Etranger tourne la clef et coupe le moteur.", COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	                	}
	                	else
	                    {
			    	    	format(string, sizeof(string), "* %s tourne la clef et coupe le moteur.", sendername);
			     	    	ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			    	    }
				       	VehiculeInfo[car][Moteur] = 0;
       		        	TogglePlayerControllable(playerid, 0);
				    	return 1; 
					}
			    	if(VehiculeInfo[car][Moteur] == 2) { SendClientMessage(playerid,COLOR_RED,"Ce n'es pas vôtre véhicule"); return 1; }
			    	if(VehiculeInfo[car][Moteur] == 3) { SendClientMessage(playerid,COLOR_RED,"Ce vehicule es en panne appelez un mécanicien"); return 1; }
					if(VehiculeInfo[car][Moteur] == 0)
					{
                     	if(PlayerInfo[playerid][pMaskuse] == 1)
	                	{
			     	    	ProxDetector(30.0, playerid, "* Etranger tourne la clef et essaie de démarrer le moteur.", COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	                	}
	                	else
	                    {
			    	    	format(string, sizeof(string), "* %s tourne la clef et essaie de démarrer le moteur.", sendername);
			     	    	ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			    	    }
			    	   	SetTimerEx("Demmarage",3500,0,"i",playerid);
				       	GameTextForPlayer(playerid, "~w~Demarage du Moteur...",3500,3);
				       	VehiculeInfo[car][Moteur] = 1;
				    	return 1;
			    	}
			    }
	    	}
		}
		if(strcmp(cmd, "/avmenu", true) == 0)
		{
		    if(IsPlayerConnected(playerid) && PlayerInfo[playerid][pAdmin] >= 5)
		    {
		        if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		        {
	     			ShowMenuForPlayer(MenuAdmin,playerid);
	       			TogglePlayerControllable(playerid, 0);
				}
				else SendClientMessage(playerid,COL_LIGHTRED,"Vous n'ête pas au volant d'un vehicule!");
		    }
		    else SendClientMessage(playerid,COL_LIGHTRED,"Vous n'ête pas autoriser a utiliser cette commande!");
		    return 1;
		}
		if(strcmp(cmd, "/vlist", true) == 0)
		{
		    if(IsPlayerConnected(playerid))
		    {
				SendClientMessage(playerid,COL_WHITE,"------[LIST DES COMMANDE VEHICULE]------");
				SendClientMessage(playerid,COL_WHITE,"/vmenu, /vechange /acceptveh");
				SendClientMessage(playerid,COL_WHITE,"----------------------------------------");
			}
			return 1;
		}
		if(strcmp(cmd, "/avlist", true) == 0)
		{
		    if(IsPlayerConnected(playerid) && PlayerInfo[playerid][pAdmin] >= 5)
		    {
				SendClientMessage(playerid,COL_WHITE,"------[LIST ADMIN DES COMMANDE VEHICULE]------");
				SendClientMessage(playerid,COL_WHITE," /avmenu , /veh, /vehsave , /vehdestroy , /avcolor");
				SendClientMessage(playerid,COL_WHITE," /allessence , /avsave , /convert , /avgoto , /avmodel");
				SendClientMessage(playerid,COL_WHITE,"----------------------------------------------");
			}
			return 1;
		}
	#else
		if(strcmp(cmd, "/vlist", true) == 0)
		{
		    if(IsPlayerConnected(playerid))
		    {
				SendClientMessage(playerid,COL_WHITE,"------[LIST DES COMMANDE VEHICULE]------");
				SendClientMessage(playerid,COL_WHITE,"/vacheter , /vvendre , /vgarer , /valarme");
				SendClientMessage(playerid,COL_WHITE,"/vessence , /vtableau , /callcar, /vechange");
				SendClientMessage(playerid,COL_WHITE,"/acceptveh");
				SendClientMessage(playerid,COL_WHITE,"----------------------------------------");
			}
			else SendClientMessage(playerid,COL_LIGHTRED,"Vous n'ête pas autoriser a utiliser cette commande!");
			return 1;
		}
		if(strcmp(cmd, "/avlist", true) == 0)
		{
		    if(IsPlayerConnected(playerid) && PlayerInfo[playerid][pAdmin] >= 5)
		    {
				SendClientMessage(playerid,COL_WHITE,"------[LIST ADMIN DES COMMANDE VEHICULE]------");
				SendClientMessage(playerid,COL_WHITE,"/avprix , /avalarme , /avvendre , /avstatus");
				SendClientMessage(playerid,COL_WHITE,"/avgarer , /avessence , /avmaxessence , /avsave ");
				SendClientMessage(playerid,COL_WHITE,"/vehsave , /vehdestroy , /allessence, /avtuning");
				SendClientMessage(playerid,COL_WHITE,"/veh , /convert , /avgoto , /avmodel , /avcolor");
				SendClientMessage(playerid,COL_WHITE,"----------------------------------------------");
			}
			else SendClientMessage(playerid,COL_LIGHTRED,"Vous n'ête pas autoriser a utiliser cette commande!");
			return 1;
		}
		if(strcmp(cmd, "/vacheter", true) == 0)
		{
		    if(IsPlayerConnected(playerid))
		    {
		        if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		        {
		        	AcheterVehicule(playerid);
				}
				else SendClientMessage(playerid,COL_LIGHTRED,"Vous n'ête pas au volant d'un vehicule!");
		    }
		    return 1;
		}
		if(strcmp(cmd, "/vvendre", true) == 0)
		{
		    if(IsPlayerConnected(playerid))
		    {
		        if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		        {
		        	VendreVehicule(playerid, 0);
				}
				else SendClientMessage(playerid,COL_LIGHTRED,"Vous n'ête pas au volant d'un vehicule!");
		    }
		    return 1;
		}
		if(strcmp(cmd, "/vgarer", true) == 0)
		{
		    if(IsPlayerConnected(playerid))
		    {
		        if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		        {
		        	GarerVehicule(playerid, 0);
				}
				else SendClientMessage(playerid,COL_LIGHTRED,"Vous n'ête pas au volant d'un vehicule!");
		    }
		    return 1;
		}
		if(strcmp(cmd, "/valarme", true) == 0)
		{
		    if(IsPlayerConnected(playerid))
		    {
		        if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		        {
		        	AlarmeVehicule(playerid, 0);
				}
				else SendClientMessage(playerid,COL_LIGHTRED,"Vous n'ête pas au volant d'un vehicule!");
		    }
		    return 1;
		}
		if(strcmp(cmd, "/vessence", true) == 0)
		{
		    if(IsPlayerConnected(playerid))
		    {
		        if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		        {
		            EssenceVehicule(playerid, 0);
				}
				else SendClientMessage(playerid,COL_LIGHTRED,"Vous n'ête pas au volant d'un vehicule!");
		    }
		    return 1;
		}
		if(strcmp(cmd, "/vtableau", true) == 0)
		{
		    if(IsPlayerConnected(playerid))
		    {
		        if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		        {
					TableauDeBord(playerid);
				}
				else SendClientMessage(playerid,COL_LIGHTRED,"Vous n'ête pas au volant d'un vehicule!");
		    }
		    return 1;
		}
		if(strcmp(cmd, "/callcar", true) == 0)
		{
		    if(IsPlayerConnected(playerid))
		    {
 				#if defined USE_CALLCAR
					new count = 0;
					new playername[MAX_PLAYER_NAME];
					GetPlayerName(playerid,playername,sizeof(playername));
					for(new v=1;v<NbVeh;v++)
					{
					    if(VehiculeInfo[v][VehID] != INVALID_VEH_ID)
					    {
			 				if(strcmp(VehiculeInfo[v][Proprio],playername,true) == 0)
				    		{
								MyVehicleID[playerid][count] = v;
								count++;
							}
						}
					}
					tmp = strtok2(cmdtext, idx);
					if(!strlen(tmp))
					{
			   			SendClientMessage(playerid,COL_WHITE,"UTILISATION: /callcar [numero]");
			   			count = 0;
						for(new v=1;v<NbVeh;v++)
						{
		    				if(VehiculeInfo[v][VehID] != INVALID_VEH_ID)
						   	{
					 			if(strcmp(VehiculeInfo[v][Proprio],playername,true) == 0)
						   		{
									format(string,sizeof(string),"%d: %s",count+1,VehiculeInfo[v][Nom]);
									SendClientMessage(playerid,COL_WHITE,string);
									count++;
			 					}
							}
						}
			   			return 1;
         			}
					new veh = strval(tmp);
					if(veh < 1 || veh > MAX_PLAYER_VEHICLES)
					{
					    format(string,sizeof(string),"Le numero du vehicule ne peux être inferieur a 1 ou superieur a %d",MAX_PLAYER_VEHICLES);
					    SendClientMessage(playerid,COL_LIGHTRED,string);
					    return 1;
					}
					new vehicleid = MyVehicleID[playerid][veh-1];
					if(vehicleid == 0)
					{
			   			SendClientMessage(playerid,COL_LIGHTRED,"Vous n'avez pas de vehicule a se numéro");
					    return 1;
					}
   					format(string,sizeof(string),"Ce vehicule (%s) a été appeler par sont proprietaire (%s)!",VehiculeInfo[vehicleid][Nom],VehiculeInfo[vehicleid][Proprio]);
					for(new i=0;i<MAX_PLAYERS;i++)
					{
					    if(IsPlayerConnected(i))
					    {
					        if(IsPlayerInAnyVehicle(i) && GetPlayerVehicleID(i) == vehicleid)
					        {
					            SendClientMessage(i,COL_LIGHTRED,string);
					            RemovePlayerFromVehicle(i);
							}
						}
					}
					for(new m=0;m<MAX_PLAYER_VEHICLES;m++)
					{
					    MyVehicleID[playerid][m] = 0;
					}
					SetTimerEx("DestroyVeh",2500,0,"i",vehicleid);
					SetTimerEx("CallCar",3000,0,"ii",playerid,vehicleid);
					format(string,sizeof(string),"Votre vehicule (%s) arrivera dans quelque seconde veuillez patienter!",VehiculeInfo[vehicleid][Nom]);
					SendClientMessage(playerid,COL_LIGHTRED,string);
				#else
					SendClientMessage(playerid,COL_LIGHTRED,"Cette option a été desactiver!");
				#endif
			}
			return 1;
		}
		if(strcmp(cmd, "/avprix", true) == 0)
		{
		    if(IsPlayerConnected(playerid) && PlayerInfo[playerid][pAdmin] >= 5)
		    {
		        if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		        {
					tmp = strtok2(cmdtext, idx);
					if(!strlen(tmp))
					{
		   				SendClientMessage(playerid,COL_WHITE,"UTILISATION: /avprix [prix]");
					    return 1;
		            }
		            new vehicleid = GetPlayerVehicleID(playerid);
		            VehiculeInfo[vehicleid][Prix] = strval(tmp);
	       	    	format(string,sizeof(string),"Vous avez changer le prix de ce vehicule (%s). Nouveau prix: %d$",VehiculeInfo[vehicleid][Nom],VehiculeInfo[vehicleid][Prix]);
		    		SendClientMessage(playerid,COL_GREEN,string);
				}
				else SendClientMessage(playerid,COL_LIGHTRED,"Vous n'ête pas au volant d'un vehicule!");
		    }
		    else SendClientMessage(playerid,COL_LIGHTRED,"Vous n'ête pas autoriser a utiliser cette commande!");
		    return 1;
		}
		if(strcmp(cmd, "/avalarme", true) == 0)
		{
		   	if(IsPlayerConnected(playerid) && PlayerInfo[playerid][pAdmin] >= 5)
		    {
		        if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		        {
					AlarmeVehicule(playerid, 1);
				}
				else SendClientMessage(playerid,COL_LIGHTRED,"Vous n'ête pas au volant d'un vehicule!");
		    }
		    else SendClientMessage(playerid,COL_LIGHTRED,"Vous n'ête pas autoriser a utiliser cette commande!");
		    return 1;
		}
		if(strcmp(cmd, "/avvendre", true) == 0)
		{
		   	if(IsPlayerConnected(playerid) && PlayerInfo[playerid][pAdmin] >= 5)
		    {
		        if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		        {
					VendreVehicule(playerid, 1);
				}
				else SendClientMessage(playerid,COL_LIGHTRED,"Vous n'ête pas au volant d'un vehicule!");
		    }
		    else SendClientMessage(playerid,COL_LIGHTRED,"Vous n'ête pas autoriser a utiliser cette commande!");
		    return 1;
		}
		if(strcmp(cmd, "/avstatus", true) == 0)
		{
		   	if(IsPlayerConnected(playerid) && PlayerInfo[playerid][pAdmin] >= 5)
		    {
		        if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		        {
					StatusVehicule(playerid);
				}
				else SendClientMessage(playerid,COL_LIGHTRED,"Vous n'ête pas au volant d'un vehicule!");
		    }
		    else SendClientMessage(playerid,COL_LIGHTRED,"Vous n'ête pas autoriser a utiliser cette commande!");
		    return 1;
		}
		if(strcmp(cmd, "/avgarer", true) == 0)
		{
		   	if(IsPlayerConnected(playerid) && PlayerInfo[playerid][pAdmin] >= 5)
		    {
		        if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		        {
					GarerVehicule(playerid, 1);
				}
				else SendClientMessage(playerid,COL_LIGHTRED,"Vous n'ête pas au volant d'un vehicule!");
		    }
		    else SendClientMessage(playerid,COL_LIGHTRED,"Vous n'ête pas autoriser a utiliser cette commande!");
		    return 1;
		}
		if(strcmp(cmd, "/avessence", true) == 0)
		{
		   	if(IsPlayerConnected(playerid) && PlayerInfo[playerid][pAdmin] >= 5)
		    {
		        if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		        {
					EssenceVehicule(playerid, 1);
				}
				else SendClientMessage(playerid,COL_LIGHTRED,"Vous n'ête pas au volant d'un vehicule!");
		    }
		    else SendClientMessage(playerid,COL_LIGHTRED,"Vous n'ête pas autoriser a utiliser cette commande!");

		    return 1;
		}
		if(strcmp(cmd, "/avmaxessence", true) == 0)
		{
		    if(IsPlayerConnected(playerid) && PlayerInfo[playerid][pAdmin] >= 5)
		    {
		        if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		        {
					tmp = strtok2(cmdtext, idx);
					if(!strlen(tmp))
					{
		   				SendClientMessage(playerid,COL_WHITE,"UTILISATION: /avmaxessence [litres]");
					    return 1;
		            }
		            new vehicleid = GetPlayerVehicleID(playerid);
		            VehiculeInfo[vehicleid][MaxEssence] = strval(tmp);
				    format(string,sizeof(string),"Vous avez changer le reservoir de ce vehicule (%s). Nouvelle quantiter maxiumum d'essence: %d$",VehiculeInfo[vehicleid][Nom],VehiculeInfo[vehicleid][MaxEssence]);
				    SendClientMessage(playerid,COL_GREEN,string);
				}
				else SendClientMessage(playerid,COL_LIGHTRED,"Vous n'ête pas au volant d'un vehicule!");
		    }
		    else SendClientMessage(playerid,COL_LIGHTRED,"Vous n'ête pas autoriser a utiliser cette commande!");
		    return 1;
		}
		if(strcmp(cmd, "/avtuning", true) == 0)
		{
		   	if(IsPlayerConnected(playerid) && PlayerInfo[playerid][pAdmin] >= 5)
		    {
		        if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		        {
					ResetTuning(playerid);
				}
				else SendClientMessage(playerid,COL_LIGHTRED,"Vous n'ête pas au volant d'un vehicule!");
		    }
		    else SendClientMessage(playerid,COL_LIGHTRED,"Vous n'ête pas autoriser a utiliser cette commande!");
		    return 1;
		}
	#endif
	if(strcmp(cmd, "/vechange", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	        {
				tmp = strtok2(cmdtext, idx);
				if(!strlen(tmp))
				{
		   			SendClientMessage(playerid,COL_WHITE,"UTILISATION: /vechange [id]");
				    return 1;
        		}
				new giveplayerid = strval(tmp);
				if(playerid == giveplayerid)
				{
				    SendClientMessage(playerid,COL_GREEN,"id incorect!");
				    return 1;
				}
				if(IsPlayerConnected(playerid))
				{
				    if(GetPlayerState(giveplayerid) != PLAYER_STATE_DRIVER)
				    {
				        SendClientMessage(playerid,COL_LIGHTRED,"Ce joueur n'est pas dans un vehicule");
				        return 1;
					}
					new playername[MAX_PLAYER_NAME];
					new vehicleid = GetPlayerVehicleID(playerid);
					GetPlayerName(playerid,playername,sizeof(playername));
					if(strcmp(VehiculeInfo[vehicleid][Proprio],playername, true) != 0)
					{
					    SendClientMessage(playerid,COL_LIGHTRED,"Ce vehicule ne vous appartient pas!");
						return 1;
					}
					new giveplayername[MAX_PLAYER_NAME];
					new givevehicleid = GetPlayerVehicleID(giveplayerid);
					GetPlayerName(giveplayerid,giveplayername,sizeof(giveplayername));
					if(strcmp(VehiculeInfo[givevehicleid][Proprio],giveplayername, true) != 0)
					{
					    SendClientMessage(playerid,COL_LIGHTRED,"Le vehicule dans lequel est ce joueur ne lui appartient pas!");
					    return 1;
					}
					format(string,sizeof(string),"Vous proposer a %s d'echanger sont vehicule (%s) contre votre vehicule (%s)",giveplayername,VehiculeInfo[givevehicleid][Nom],VehiculeInfo[vehicleid][Nom]);
					SendClientMessage(playerid,COL_GREEN,string);
					format(string,sizeof(string),"%s vous propose d'echanger sont vehicule (%s) contre votre vehicule (%s). Taper /acceptveh pour accepter l'echange!",playername,VehiculeInfo[vehicleid][Nom],VehiculeInfo[givevehicleid][Nom]);
					SendClientMessage(giveplayerid,COL_GREEN,string);
					EchangeVeh[giveplayerid][0] = playerid;
					EchangeVeh[giveplayerid][1] = vehicleid;
					EchangeVeh[giveplayerid][2] = givevehicleid;
				}
				else SendClientMessage(playerid,COL_LIGHTRED,"Ce joueur n'est pas connecter!");
			}
			else SendClientMessage(playerid,COL_LIGHTRED,"Vous n'ête pas au volant d'un vehicule!");
		}
		return 1;
	}
	if(strcmp(cmd, "/acceptveh", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	        {
				if(EchangeVeh[playerid][0] == 255)
				{
				    SendClientMessage(playerid,COL_LIGHTRED,"Vous n'avez pas de proposition d'echange de vehicule");
				    return 1;
				}
				new giveplayerid = EchangeVeh[playerid][0];
				if(!IsPlayerConnected(giveplayerid))
				{
				    SendClientMessage(playerid,COL_LIGHTRED,"Le joueur qui vous a proposer d'echanger de vehicule c'est deconecter");
				    EchangeVeh[playerid][0] = 255;
				    EchangeVeh[playerid][1] = 0;
				    EchangeVeh[playerid][2] = 0;
				    return 1;
				}
				if(GetPlayerState(giveplayerid) != PLAYER_STATE_DRIVER)
				{
				    SendClientMessage(playerid,COL_LIGHTRED,"Le joueur qui propose l'echange n'est plus dans un vehicule!");
				    EchangeVeh[playerid][0] = 255;
				    EchangeVeh[playerid][1] = 0;
				    EchangeVeh[playerid][2] = 0;
				    return 1;
				}
				new vehicleid = GetPlayerVehicleID(playerid);
				if(vehicleid != EchangeVeh[playerid][2])
				{
				    SendClientMessage(playerid,COL_LIGHTRED,"Vous avez changer de vehicule!");
				    EchangeVeh[playerid][0] = 255;
				    EchangeVeh[playerid][1] = 0;
				    EchangeVeh[playerid][2] = 0;
				    return 1;
				}
				new givevehicleid = GetPlayerVehicleID(giveplayerid);
				if(givevehicleid != EchangeVeh[playerid][1])
				{
				    SendClientMessage(playerid,COL_LIGHTRED,"Le joueur qui vous a proposer l'echange a changer de vehicule!");
				    EchangeVeh[playerid][0] = 255;
				    EchangeVeh[playerid][1] = 0;
				    EchangeVeh[playerid][2] = 0;
				    return 1;
				}
				new playername[MAX_PLAYER_NAME],giveplayername[MAX_PLAYER_NAME];
				GetPlayerName(playerid,playername,sizeof(playername));
				GetPlayerName(giveplayerid,giveplayername,sizeof(giveplayername));
				strmid(VehiculeInfo[vehicleid][Proprio],giveplayername,0,strlen(giveplayername),MAX_PLAYER_NAME);
				strmid(VehiculeInfo[givevehicleid][Proprio],playername,0,strlen(playername),MAX_PLAYER_NAME);
				format(string,sizeof(string),"%s a accepter l'echange de vehicule!",playername);
				SendClientMessage(giveplayerid,COL_GREEN,string);
				format(string,sizeof(string),"Vous avez accepter l'echange de vehicule avec %s",giveplayername);
				SendClientMessage(giveplayerid,COL_GREEN,string);
    			EchangeVeh[playerid][0] = 255;
			    EchangeVeh[playerid][1] = 0;
			    EchangeVeh[playerid][2] = 0;
 			}
			else SendClientMessage(playerid,COL_LIGHTRED,"Vous n'ête pas au volant d'un vehicule!");
		}
		return 1;
	}
	if(strcmp(cmd, "/avsave", true) == 0)
	{
	    if(IsPlayerConnected(playerid) && PlayerInfo[playerid][pAdmin] >= 5)
	    {
	        SauvegardeVeh();
	        SendClientMessage(playerid,COL_GREEN,"Sauvegarde vehicule reussie!");
	    }
	    else SendClientMessage(playerid,COL_LIGHTRED,"Vous n'ête pas autoriser a utiliser cette commande!");
	    return 1;
	}
	if(strcmp(cmd, "/avcolor", true) == 0)
	{
	    if(IsPlayerConnected(playerid) && PlayerInfo[playerid][pAdmin] >= 5)
	    {
	        if(!IsPlayerInAnyVehicle(playerid))
	        {
	            SendClientMessage(playerid,COL_LIGHTRED,"Vous n'ête pas dans un vehicule!");
	            return 1;
	        }
	        tmp = strtok2(cmdtext,idx);
	        if(!strlen(tmp))
	        {
	            SendClientMessage(playerid,COL_WHITE,"UTILISATION: /avcolor [color1] [color2]");
	            return 1;
	        }
	        new col1 = strval(tmp);
	        tmp = strtok2(cmdtext,idx);
	        if(!strlen(tmp))
	        {
	            SendClientMessage(playerid,COL_WHITE,"UTILISATION: /avcolor [color1] [color2]");
	            return 1;
	        }
			new col2 = strval(tmp);
			new vehicleid = GetPlayerVehicleID(playerid);
			ChangeVehicleColor(vehicleid,col1,col2);
			VehiculeInfo[vehicleid][Couleur1] = col1;
			VehiculeInfo[vehicleid][Couleur2] = col2;
			SendClientMessage(playerid,COL_GREEN,"Vehicule repeint!");
		}
	    else SendClientMessage(playerid,COL_LIGHTRED,"Vous n'ête pas autoriser a utiliser cette commande!");
	    return 1;
	}
	if(strcmp(cmd, "/avmodel", true) == 0)
	{
	    if(IsPlayerConnected(playerid) && PlayerInfo[playerid][pAdmin] >= 5)
	    {
	        if(!IsPlayerInAnyVehicle(playerid))
	        {
	            SendClientMessage(playerid,COL_LIGHTRED,"Vous n'ête pas dans un vehicule!");
	            return 1;
	        }
	        tmp = strtok2(cmdtext,idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COL_WHITE, "UTILISATION: /avmodel [nom/moedelid]");
				return 1;
			}
			new modelid = ReturnModelByName(tmp);
			if(modelid == 0)
			{
				SendClientMessage(playerid, COL_WHITE, "Modelid incorect! Assurer vous d'avoir mit un nom de vehicule existant ou d'un modelid corect!");
				return 1;
			}
			new vehicleid = GetPlayerVehicleID(playerid);
			new Float:x,Float:y,Float:z,Float:a;
			GetVehiclePos(vehicleid,x,y,z);
			GetVehicleZAngle(vehicleid,a);
			RemoveAllPlayerFromVehicle(vehicleid);
			VehiculeInfo[vehicleid][Model] = modelid;
			strmid(VehiculeInfo[vehicleid][Nom],VehicleName[VehiculeInfo[vehicleid][Model]-400],0,strlen(VehicleName[VehiculeInfo[vehicleid][Model]-400]),64);
			SetTimerEx("DestroyVeh",1500,0,"i",vehicleid);
			SetTimerEx("CreateVeh",2000,0,"iffff",vehicleid,x,y,z,a);
			SauvegardeVeh();
			SendClientMessage(playerid,COL_GREEN,"Model du vehicule changer!");
		}
	    else SendClientMessage(playerid,COL_LIGHTRED,"Vous n'ête pas autoriser a utiliser cette commande!");
	    return 1;
	}
	if(strcmp(cmd, "/avgoto", true) == 0)
	{
	    if(IsPlayerConnected(playerid) && PlayerInfo[playerid][pAdmin] >= 5)
	    {
	        tmp = strtok2(cmdtext,idx);
	        if(!strlen(tmp))
	        {
	            SendClientMessage(playerid,COL_WHITE,"UTILISATION: /avgoto [VehID]");
	            SendClientMessage(playerid,COL_LIGHTRED,"INFO: Utiliser le VehID pour vous teleporter sur un vehicule!");
				return 1;
			}
			new vehid = strval(tmp);
			new Float:x,Float:y,Float:z;
			for(new v=1;v<NbVeh;v++)
			{
	  			if(VehiculeInfo[v][VehID] != INVALID_VEH_ID && VehiculeInfo[v][VehID] == vehid)
		    	{
		    	    GetVehiclePos(v,x,y,z);
		    	    SetPlayerPos(playerid,x,y,z+1.5);
					return 1;
				}
			}
	        SendClientMessage(playerid,COL_GREEN,"Ce VehID est incorect!");
	    }
	    else SendClientMessage(playerid,COL_LIGHTRED,"Vous n'ête pas autoriser a utiliser cette commande!");
	    return 1;
	}
	if(strcmp(cmd, "/vehsave", true) ==0 )
	{
	    if(IsPlayerConnected(playerid) && PlayerInfo[playerid][pAdmin] >= 5)
	    {
            if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	        {
	            new vehicleid = GetPlayerVehicleID(playerid);
	            if(VehiculeInfo[vehicleid][VehID] != INVALID_VEH_ID)
	            {
	                SendClientMessage(playerid,COL_LIGHTRED,"Ce vehicule est deja sauvegarder!");
	                return 1;
				}
				new Float:x,Float:y,Float:z,Float:a;
				GetVehiclePos(vehicleid,x,y,z);
				GetVehicleZAngle(vehicleid,a);

				VehiculeInfo[vehicleid][VehID]		= vehicleid;
				VehiculeInfo[vehicleid][Model]		= GetVehicleModel(vehicleid);
				VehiculeInfo[vehicleid][XSpawn]		= x;
				VehiculeInfo[vehicleid][YSpawn]	 	= y;
				VehiculeInfo[vehicleid][ZSpawn] 	= z;
				VehiculeInfo[vehicleid][ASpawn]	  	= a;
				VehiculeInfo[vehicleid][Prix]       = 0;
				VehiculeInfo[vehicleid][Status]     = 0;
				VehiculeInfo[vehicleid][Alarme]	  	= 2;
				VehiculeInfo[vehicleid][Tuning1]	= 0;
				VehiculeInfo[vehicleid][Tuning2]	= 0;
				VehiculeInfo[vehicleid][Tuning3]	= 0;
				VehiculeInfo[vehicleid][Tuning4]	= 0;
				VehiculeInfo[vehicleid][Tuning5]	= 0;
				VehiculeInfo[vehicleid][Tuning6]	= 0;
				VehiculeInfo[vehicleid][Tuning7]	= 0;
				VehiculeInfo[vehicleid][Tuning8]	= 0;
				VehiculeInfo[vehicleid][Tuning9]	= 0;
				VehiculeInfo[vehicleid][Tuning10]	= 0;
				VehiculeInfo[vehicleid][Tuning11]	= 0;
				VehiculeInfo[vehicleid][Tuning12]	= 0;
				VehiculeInfo[vehicleid][Tuning13]	= 0;
				VehiculeInfo[vehicleid][Tuning14]	= 0;
				VehiculeInfo[vehicleid][Tuning15]	= 0;
				VehiculeInfo[vehicleid][Tuning16]	= 0;
				VehiculeInfo[vehicleid][Tuning17]	= 0;
				VehiculeInfo[vehicleid][Peinture]	= 0;
				VehiculeInfo[vehicleid][MaxEssence] = 100;
				VehiculeInfo[vehicleid][Essence] 	= 100;
				strmid(VehiculeInfo[vehicleid][Proprio],"Aucun", 0, strlen("Aucun"),MAX_PLAYER_NAME);
				strmid(VehiculeInfo[vehicleid][Nom],VehicleName[VehiculeInfo[vehicleid][Model]-400],0,strlen(VehicleName[VehiculeInfo[vehicleid][Model]-400]),64);
				VehiculeInfo[vehicleid][Essence] = VehiculeInfo[vehicleid][MaxEssence];
				EssenceCount[vehicleid] = 0;
				NbVeh++;

				format(string,sizeof(string),"Ce vehicule (%s) a bien été sauvegarder!",VehiculeInfo[vehicleid][Nom]);
				SendClientMessage(playerid,COL_GREEN,string);
				SauvegardeVeh();
				return 1;
	        }
	    }
	    else SendClientMessage(playerid,COL_LIGHTRED,"Vous n'ête pas autoriser a utiliser cette commande!");
	    return 1;
	}
	if(strcmp(cmd, "/vehdestroy", true) ==0 )
	{
	    if(IsPlayerConnected(playerid) && PlayerInfo[playerid][pAdmin] >= 5)
	    {
			if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
			{
			    new vehicleid = GetPlayerVehicleID(playerid);
				#if defined USE_MYSQL
				    if(VehiculeInfo[vehicleid][VehID] != INVALID_VEH_ID)
				    {
						new query[128];
						format(query,sizeof(query),"DELETE FROM %s WHERE VehID=%d LIMIT 1",MYSQL_TB_VEH,VehiculeInfo[vehicleid][VehID]);
						samp_mysql_query(query);
					}
				#endif
				format(string,sizeof(string),"Ce vehicule (%s) a bien été suprimer!",VehiculeInfo[vehicleid][Nom]);
				SendClientMessage(playerid,COL_GREEN,string);
				VehiculeInfo[vehicleid][VehID] = INVALID_VEH_ID;
				RemoveAllPlayerFromVehicle(vehicleid);
				SetTimerEx("DestroyVeh",5000,0,"i",vehicleid);
				SauvegardeVeh();
			}
			else SendClientMessage(playerid,COL_LIGHTRED,"Vous n'ête pas au volant d'un vehicule!");
	    }
	    else SendClientMessage(playerid,COL_LIGHTRED,"Vous n'ête pas autoriser a utiliser cette commande!");
	    return 1;
	}
	if(strcmp(cmd, "/allessence", true) ==0 )
	{
	    if(IsPlayerConnected(playerid) && PlayerInfo[playerid][pAdmin] >= 5)
	    {
	        for(new v=1;v<NbVeh;v++)
	        {
				VehiculeInfo[v][Essence] = VehiculeInfo[v][MaxEssence];
			}
			SendClientMessage(playerid,COL_GREEN,"Tout les vehicule on été remplis!");
	    }
	    else SendClientMessage(playerid,COL_LIGHTRED,"Vous n'ête pas autoriser a utiliser cette commande!");
	    return 1;
	}
	if(strcmp(cmd, "/maveh", true) ==0 )
	{
	    if(IsPlayerConnected(playerid) && PlayerInfo[playerid][pAdmin] >= 5)
	    {
			tmp = strtok2(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COL_WHITE, "UTILISATION: /veh [nom/moedelid] [color1] [color2]");
				return 1;
			}
			new modelid = ReturnModelByName(tmp);
			if(modelid == 0)
			{
				SendClientMessage(playerid, COL_WHITE, "Modelid incorect! Assurer vous d'avoir mit un nom de vehicule existant ou d'un modelid corect!");
				return 1;
			}
			new color1 = 0;
			tmp = strtok2(cmdtext, idx);
			if(strlen(tmp)) color1 = strval(tmp);
			new color2 = 0;
			tmp = strtok2(cmdtext, idx);
			if(strlen(tmp)) color2 = strval(tmp);
			
			new Float:x,Float:y,Float:z,Float:a;
			GetPlayerPos(playerid,x,y,z);
			GetPlayerFacingAngle(playerid,a);
			GetXYFront(x, y, a, 3.0);
			new Cveh = CreateVehicle(modelid,x,y,z,a,color1,color2,RESPAWN_DELAY);
			
			VehiculeInfo[Cveh][VehID]		= INVALID_VEH_ID;
			VehiculeInfo[Cveh][Model]		= modelid;
			VehiculeInfo[Cveh][XSpawn]		= x;
			VehiculeInfo[Cveh][YSpawn]	 	= y;
			VehiculeInfo[Cveh][ZSpawn] 		= z;
			VehiculeInfo[Cveh][ASpawn]	  	= a;
			VehiculeInfo[Cveh][Couleur1]	= color1;
			VehiculeInfo[Cveh][Couleur2]	= color2;
			VehiculeInfo[Cveh][Prix]       	= 0;
			VehiculeInfo[Cveh][Status]     	= 0;
			VehiculeInfo[Cveh][Alarme]	  	= 2;
			VehiculeInfo[Cveh][Tuning1]		= 0;
			VehiculeInfo[Cveh][Tuning2]		= 0;
			VehiculeInfo[Cveh][Tuning3]		= 0;
			VehiculeInfo[Cveh][Tuning4]		= 0;
			VehiculeInfo[Cveh][Tuning5]		= 0;
			VehiculeInfo[Cveh][Tuning6]		= 0;
			VehiculeInfo[Cveh][Tuning7]		= 0;
			VehiculeInfo[Cveh][Tuning8]		= 0;
			VehiculeInfo[Cveh][Tuning9]		= 0;
			VehiculeInfo[Cveh][Tuning10]	= 0;
			VehiculeInfo[Cveh][Tuning11]	= 0;
			VehiculeInfo[Cveh][Tuning12]	= 0;
			VehiculeInfo[Cveh][Tuning13]	= 0;
			VehiculeInfo[Cveh][Tuning14]	= 0;
			VehiculeInfo[Cveh][Tuning15]	= 0;
			VehiculeInfo[Cveh][Tuning16]	= 0;
			VehiculeInfo[Cveh][Tuning17]	= 0;
			VehiculeInfo[Cveh][Peinture]	= 0;
			VehiculeInfo[Cveh][MaxEssence] 	= 100;
			VehiculeInfo[Cveh][Essence] 	= 100;
			VehiculeInfo[Cveh][Moteur]      = 1;
			strmid(VehiculeInfo[Cveh][Proprio],"Aucun", 0, strlen("Aucun"),128);
			strmid(VehiculeInfo[Cveh][Nom],VehicleName[modelid-400],0,strlen(VehicleName[modelid-400]),128);
			
			format(string,sizeof(string),"Vehicule (%s) cree!",VehiculeInfo[Cveh][Nom]);
			SendClientMessage(playerid,COL_GREEN,string);
			SendClientMessage(playerid,COL_LIGHTRED,"Pour ajouter ce vehicule a la liste des vehicule sauvegarder taper /vehsave ");
		}
	    else SendClientMessage(playerid,COL_WHITE,"Vous n'ête pas autoriser a utiliser cette commande!");
		return 1;
	}
    if(strcmp(cmdtext,"/convert")==0)
	{

			if(!fexist(Veh))
	 		{
	 		    format(string,sizeof(string),"Le fichier %s n'existe pas!",tmp);
	 		    SendClientMessage(playerid,COL_LIGHTRED,string);
	 		    return 1;
	 		}
		    new File:convert = fopen(Veh, io_read);
      		new filestring[256];
	       	new CountConvert = 1;
	        while(fread(convert, filestring))
	        {
         		if(strfind(filestring,"AddStaticVehicle(") != -1 && strfind(filestring,")") != -1)
           		{
	            	new find = strfind(filestring,"(");
		            new find2 = strfind(filestring,")");
		            new info[128];
		            strmid(info,filestring,find+1,find2,128);
		            split(info, Field, ',');
					VehiculeInfo[NbVeh][VehID]		= NbVeh;
					VehiculeInfo[NbVeh][Model]		= strval(Field[0]);
					VehiculeInfo[NbVeh][XSpawn]		= floatstr(Field[1]);
					VehiculeInfo[NbVeh][YSpawn]	 	= floatstr(Field[2]);
					VehiculeInfo[NbVeh][ZSpawn] 	= floatstr(Field[3]);
					VehiculeInfo[NbVeh][ASpawn]	  	= floatstr(Field[4]);
					VehiculeInfo[NbVeh][Couleur1]	= strval(Field[5]);
					VehiculeInfo[NbVeh][Couleur2]	= strval(Field[6]);
					VehiculeInfo[NbVeh][Prix]       = 0;
					VehiculeInfo[NbVeh][Status]     = 0;
					VehiculeInfo[NbVeh][Alarme]	  	= 2;
					VehiculeInfo[NbVeh][Tuning1]	= 0;
					VehiculeInfo[NbVeh][Tuning2]	= 0;
					VehiculeInfo[NbVeh][Tuning3]	= 0;
					VehiculeInfo[NbVeh][Tuning4]	= 0;
					VehiculeInfo[NbVeh][Tuning5]	= 0;
					VehiculeInfo[NbVeh][Tuning6]	= 0;
					VehiculeInfo[NbVeh][Tuning7]	= 0;
					VehiculeInfo[NbVeh][Tuning8]	= 0;
					VehiculeInfo[NbVeh][Tuning9]	= 0;
					VehiculeInfo[NbVeh][Tuning10]	= 0;
					VehiculeInfo[NbVeh][Tuning11]	= 0;
					VehiculeInfo[NbVeh][Tuning12]	= 0;
					VehiculeInfo[NbVeh][Tuning13]	= 0;
					VehiculeInfo[NbVeh][Tuning14]	= 0;
					VehiculeInfo[NbVeh][Tuning15]	= 0;
					VehiculeInfo[NbVeh][Tuning16]	= 0;
					VehiculeInfo[NbVeh][Tuning17]	= 0;
					VehiculeInfo[NbVeh][Peinture]	= 0;
					VehiculeInfo[NbVeh][MaxEssence] = 100;
					VehiculeInfo[NbVeh][Essence] = 100;
					VehiculeInfo[NbVeh][Moteur] = 0;
					strmid(VehiculeInfo[NbVeh][Proprio],"Aucun", 0, strlen("Aucun"),128);
					strmid(VehiculeInfo[NbVeh][Nom],VehicleName[VehiculeInfo[NbVeh][Model]-400],0,strlen(VehicleName[VehiculeInfo[NbVeh][Model]-400]),128);

					CreateVehicle(VehiculeInfo[NbVeh][Model],VehiculeInfo[NbVeh][XSpawn],VehiculeInfo[NbVeh][YSpawn],VehiculeInfo[NbVeh][ZSpawn],VehiculeInfo[NbVeh][ASpawn],VehiculeInfo[NbVeh][Couleur1],VehiculeInfo[NbVeh][Couleur2],-1);

					format(string,sizeof(string),"Vehicule (%s) cree!",VehiculeInfo[NbVeh][Nom]);
					SendClientMessage(playerid,COL_GREEN,string);

					NbVeh++;
					CountConvert++;
				}
    		}
   			if(CountConvert > 1)
   			{
				format(string,sizeof(string),"%d vehicule on été converti et ajouter!",CountConvert);
    			SendClientMessage(playerid,COL_LIGHTRED,string);
       			SauvegardeVeh();
	   		}
			else SendClientMessage(playerid,COL_LIGHTRED,"Il n'ya pas de ligne 'AddStaticVehicle' dans ce fichier!");

			return 1;
	}
    if(strcmp(cmdtext,"/convertvagos")==0)
	{

			if(!fexist(Veh))
	 		{
	 		    format(string,sizeof(string),"Le fichier %s n'existe pas!",tmp);
	 		    SendClientMessage(playerid,COL_LIGHTRED,string);
	 		    return 1;
	 		}
		    new File:convert = fopen(Veh, io_read);
      		new filestring[256];
	       	new CountConvert = 1;
	        while(fread(convert, filestring))
	        {
         		if(strfind(filestring,"AddStaticVehicle(") != -1 && strfind(filestring,")") != -1)
           		{
	            	new find = strfind(filestring,"(");
		            new find2 = strfind(filestring,")");
		            new info[128];
		            strmid(info,filestring,find+1,find2,128);
		            split(info, Field, ',');
					VehiculeInfo[NbVeh][VehID]		= NbVeh;
					VehiculeInfo[NbVeh][Model]		= strval(Field[0]);
					VehiculeInfo[NbVeh][XSpawn]		= floatstr(Field[1]);
					VehiculeInfo[NbVeh][YSpawn]	 	= floatstr(Field[2]);
					VehiculeInfo[NbVeh][ZSpawn] 	= floatstr(Field[3]);
					VehiculeInfo[NbVeh][ASpawn]	  	= floatstr(Field[4]);
					VehiculeInfo[NbVeh][Couleur1]	= strval(Field[5]);
					VehiculeInfo[NbVeh][Couleur2]	= strval(Field[6]);
					VehiculeInfo[NbVeh][Prix]       = 0;
					VehiculeInfo[NbVeh][Status]     = 0;
					VehiculeInfo[NbVeh][Alarme]	  	= 0;
					VehiculeInfo[NbVeh][Tuning1]	= 0;
					VehiculeInfo[NbVeh][Tuning2]	= 0;
					VehiculeInfo[NbVeh][Tuning3]	= 0;
					VehiculeInfo[NbVeh][Tuning4]	= 0;
					VehiculeInfo[NbVeh][Tuning5]	= 0;
					VehiculeInfo[NbVeh][Tuning6]	= 0;
					VehiculeInfo[NbVeh][Tuning7]	= 0;
					VehiculeInfo[NbVeh][Tuning8]	= 0;
					VehiculeInfo[NbVeh][Tuning9]	= 0;
					VehiculeInfo[NbVeh][Tuning10]	= 0;
					VehiculeInfo[NbVeh][Tuning11]	= 0;
					VehiculeInfo[NbVeh][Tuning12]	= 0;
					VehiculeInfo[NbVeh][Tuning13]	= 0;
					VehiculeInfo[NbVeh][Tuning14]	= 0;
					VehiculeInfo[NbVeh][Tuning15]	= 0;
					VehiculeInfo[NbVeh][Tuning16]	= 0;
					VehiculeInfo[NbVeh][Tuning17]	= 0;
					VehiculeInfo[NbVeh][Peinture]	= 0;
					VehiculeInfo[NbVeh][MaxEssence] = 100;
					VehiculeInfo[NbVeh][Essence] = 100;
					VehiculeInfo[NbVeh][Moteur] = 0;
					strmid(VehiculeInfo[NbVeh][Proprio],"Vagos", 0, strlen("Vagos"),128);
					strmid(VehiculeInfo[NbVeh][Nom],VehicleName[VehiculeInfo[NbVeh][Model]-400],0,strlen(VehicleName[VehiculeInfo[NbVeh][Model]-400]),128);

					CreateVehicle(VehiculeInfo[NbVeh][Model],VehiculeInfo[NbVeh][XSpawn],VehiculeInfo[NbVeh][YSpawn],VehiculeInfo[NbVeh][ZSpawn],VehiculeInfo[NbVeh][ASpawn],VehiculeInfo[NbVeh][Couleur1],VehiculeInfo[NbVeh][Couleur2],-1);

					format(string,sizeof(string),"Vehicule (%s) cree!",VehiculeInfo[NbVeh][Nom]);
					SendClientMessage(playerid,COL_GREEN,string);

					NbVeh++;
					CountConvert++;
				}
    		}
   			if(CountConvert > 1)
   			{
				format(string,sizeof(string),"%d vehicule on été converti et ajouter!",CountConvert);
    			SendClientMessage(playerid,COL_LIGHTRED,string);
       			SauvegardeVeh();
	   		}
			else SendClientMessage(playerid,COL_LIGHTRED,"Il n'ya pas de ligne 'AddStaticVehicle' dans ce fichier!");

			return 1;
	}
	return 0;
}

public Script_OnPlayerExitVehicle(playerid)
{
	if(PompeEssence[playerid] != 255)
	{
	    KillTimer(TimerEssence[playerid]);
	    PompeEssence[playerid] = 255;
		SendClientMessage(playerid,COL_GREEN,"Vous ête sortit du vehicule pendant le remplisage du reservoir. Le remplisage c'est arreter!");
	}
	if(TableauActive[playerid] == 1 && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
	    TableauActive[playerid] = 6;
		for(new b=0;b<sizeof(BarreVieVeh);b++)
		{
	       	TextDrawHideForPlayer(playerid,BarreVieVeh[b]);
		}
	}
	return 1;
}
public Script_OnPlayerKeyStateChange(playerid, newkeys)
{
    new car = GetPlayerVehicleID(playerid);
    if(newkeys == KEY_JUMP)
    {
        if(IsPlayerInAnyVehicle(playerid))
        {
			if(IsPlayerConnected(playerid))
			{
				new sendername[32];
				new string[126];
				if(EsUnAvion(car)){ return 1; }
				if(VehiculeInfo[car][Moteur] == 1) { return 1; }
				if(VehiculeInfo[car][Moteur] == 2) { SendClientMessage(playerid,COLOR_RED,"Ce n'es pas vôtre véhicule"); return 1; }
				if(VehiculeInfo[car][Moteur] == 3) { SendClientMessage(playerid,COLOR_RED,"Ce vehicule es en panne appelez un mécanicien"); return 1; }
				GetPlayerName(playerid, sendername, sizeof(sendername));
				if(VehiculeInfo[car][Moteur] == 0)
				{
                 	if(PlayerInfo[playerid][pMaskuse] == 1)
	            	{
			     		ProxDetector(30.0, playerid, "* Etranger tourne la clef et essaie de démarrer le moteur.", COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	            	}
	            	else
	                {
			    		format(string, sizeof(string), "* %s tourne la clef et essaie de démarrer le moteur.", sendername);
			     		ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				    }
					SetTimerEx("Demmarage",3500,0,"i",playerid);
					GameTextForPlayer(playerid, "~w~Demarage du Moteur...",3500,3);
					VehiculeInfo[car][Moteur] = 1;
					return 1;
				}
			}
		}
    }    
	else if(newkeys == KEY_SECONDARY_ATTACK)
    {
        if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
        {
            if(VehiculeInfo[car][Moteur] != 1)
            {
				RemovePlayerFromVehicle(playerid);
				TogglePlayerControllable(playerid, 1);
				return 1;
            }
        }
	}	
	return 1;
}

public Script_OnPlayerStateChange(playerid, newstate)
{
	if(IsPlayerConnected(playerid))
	{
		if(newstate == PLAYER_STATE_DRIVER)
		{

            new vehicleid = GetPlayerVehicleID(playerid);
            new playername[MAX_PLAYER_NAME],string[128];
            new Float:x,Float:y,Float:z;
            GetPlayerName(playerid,playername,sizeof(playername));
            GetPlayerPos(playerid,x,y,z);
			PlayerPos[playerid][0] = x;
   			PlayerPos[playerid][1] = y;
      		PlayerPos[playerid][2] = z;
      		if(VehiculeInfo[vehicleid][VehID] == INVALID_VEH_ID && PlayerInfo[playerid][pAdmin] >= 5)
  		    {
  		        format(string,sizeof(string),"Ce vehicule (%s) n'est pas un vehicule sauvegarder pour le sauvegarder taper /vehsave",VehiculeInfo[vehicleid][Nom]);
	       		SendClientMessage(playerid,COL_LIGHTRED,string);
			}
            if(VehiculeInfo[vehicleid][Alarme] == 2)
            {
                if(PlayerInfo[playerid][pAdmin] <= 0)
                {
					format(string,sizeof(string),"Ce vehicule (%s) est reserver au admin. Vous ne pouvez pas l'utiliser!",VehiculeInfo[vehicleid][Nom]);
					SendClientMessage(playerid,COL_LIGHTRED,string);
					RemovePlayerFromVehicle(playerid);
					return 1;
				}
				else
				{
				    format(string,sizeof(string),"Ce vehicule (%s) est reserver au admin. Vous pouvez l'utiliser!",VehiculeInfo[vehicleid][Nom]);
				    SendClientMessage(playerid,COL_GREEN,string);
				}
			}
            if(strcmp(VehiculeInfo[vehicleid][Proprio],"Aucun",true) == 0)
            {
                if(VehiculeInfo[vehicleid][Status] == 1)
                {
					#if defined USE_MENU
						format(string,sizeof(string),"Ce vehicule (%s) peux être acheter pour %d$! Pour l'acheter taper /vmenu et selectioner 'Acheter'",VehiculeInfo[vehicleid][Nom],VehiculeInfo[vehicleid][Prix]);
					#else
					    format(string,sizeof(string),"Ce vehicule (%s) peux être acheter pour %d$! Pour l'acheter taper /vacheter!",VehiculeInfo[vehicleid][Nom],VehiculeInfo[vehicleid][Prix]);
					#endif
					SendClientMessage(playerid,COL_YELLOW,string);
					VehiculeInfo[vehicleid][Moteur] = 2;
		    		TogglePlayerControllable(playerid, 0);
					
				}
				else
				{
				    format(string,sizeof(string),"Ce vehicule (%s) ne peux pas être acheter!",VehiculeInfo[vehicleid][Nom]);
				    SendClientMessage(playerid,COL_LIGHTRED,string);
				}
            }
            if(strcmp(VehiculeInfo[vehicleid][Proprio],"ACPD",true) == 0)
            {
			    if(PlayerInfo[playerid][pMember] == 1 || PlayerInfo[playerid][pMember] == 2 || PlayerInfo[playerid][pMember] == 3 || PlayerInfo[playerid][pLeader] == 1 || PlayerInfo[playerid][pLeader] == 2 || PlayerInfo[playerid][pLeader] == 3)
				{
				    if(OnDuty[playerid] == 1)
					{
					}
					else
					{
					    SendClientMessage(playerid,COLOR_RED,"Vous devez être en service pour utiliser ce véhicule");
						RemovePlayerFromVehicle(playerid);
				    	return 1;
					}
				}
				else
				{
               	    SendClientMessage(playerid,COL_LIGHTRED,"Ce Véhicule appartient à La Police !");
					RemovePlayerFromVehicle(playerid);
					return 1;
				}
            }
            else if(strcmp(VehiculeInfo[vehicleid][Proprio],"FBI",true) == 0)
            {
			    if(PlayerInfo[playerid][pMember] == 1 || PlayerInfo[playerid][pMember] == 2 || PlayerInfo[playerid][pMember] == 3 || PlayerInfo[playerid][pLeader] == 1 || PlayerInfo[playerid][pLeader] == 2 || PlayerInfo[playerid][pLeader] == 3)
				{
				    if(OnDuty[playerid] == 1)
					{
					}
					else
					{
					    SendClientMessage(playerid,COLOR_RED,"Vous devez être en service pour utiliser ce véhicule");
						RemovePlayerFromVehicle(playerid);
		    			return 1;
					}
				}
				else
				{
               	    SendClientMessage(playerid,COL_LIGHTRED,"Ce Véhicule appartient au FBI !");
					RemovePlayerFromVehicle(playerid);
					return 1;
				}
            }
            else if(strcmp(VehiculeInfo[vehicleid][Proprio],"FAAC",true) == 0)
            {
			    if(PlayerInfo[playerid][pMember] == 1 || PlayerInfo[playerid][pMember] == 2 || PlayerInfo[playerid][pMember] == 3 || PlayerInfo[playerid][pLeader] == 1 || PlayerInfo[playerid][pLeader] == 2 || PlayerInfo[playerid][pLeader] == 3)
				{
				    if(OnDuty[playerid] == 1)
					{
					}
					else
					{
					    SendClientMessage(playerid,COLOR_RED,"Vous devez être en service pour utiliser ce véhicule");
						RemovePlayerFromVehicle(playerid);
	    				return 1;
					}
				}
				else
				{
               	    SendClientMessage(playerid,COL_LIGHTRED,"Ce Véhicule appartient à La FAAC !");
					RemovePlayerFromVehicle(playerid);
					return 1;
				}
            }
            else if(strcmp(VehiculeInfo[vehicleid][Proprio],"Gouvernement",true) == 0)
            {
			    if(PlayerInfo[playerid][pMember] == 1 || PlayerInfo[playerid][pMember] == 2 || PlayerInfo[playerid][pMember] == 3 || PlayerInfo[playerid][pMember] == 7 || PlayerInfo[playerid][pLeader] == 7 || PlayerInfo[playerid][pLeader] == 1 || PlayerInfo[playerid][pLeader] == 2 || PlayerInfo[playerid][pLeader] == 3)
				{
				}
				else
				{
               	    SendClientMessage(playerid,COL_LIGHTRED,"Ce Véhicule appartient au Gouvernement !");
					RemovePlayerFromVehicle(playerid);
					return 1;
				}
            }            
			else if(strcmp(VehiculeInfo[vehicleid][Proprio],"Vagos",true) == 0)
            {
			    if(PlayerInfo[playerid][pLeader] == 5 || PlayerInfo[playerid][pMember] == 5)
				{
				}
				else
				{
               	    SendClientMessage(playerid,COL_LIGHTRED,"Ce Véhicule appartient aux Vagos !");
					RemovePlayerFromVehicle(playerid);
					return 1;
				}
            }			
			else if(strcmp(VehiculeInfo[vehicleid][Proprio],"Russe",true) == 0)
            {
			    if(PlayerInfo[playerid][pLeader] == 9 || PlayerInfo[playerid][pMember] == 9)
				{
				}
				else
				{
               	    SendClientMessage(playerid,COL_LIGHTRED,"Ce Véhicule appartient aux Russes!");
					RemovePlayerFromVehicle(playerid);
					return 1;
				}
            }			
			else if(strcmp(VehiculeInfo[vehicleid][Proprio],"ACMD",true) == 0)
            {
			    if(PlayerInfo[playerid][pJob] == 11)
				{
				}
				else
				{
               	    SendClientMessage(playerid,COL_LIGHTRED,"Ce Véhicule appartient a la ACMD!");
					RemovePlayerFromVehicle(playerid);
					return 1;
				}
            }
            else if(strcmp(VehiculeInfo[vehicleid][Proprio],"Dinozzo",true) == 0)
            {
			    if(PlayerInfo[playerid][pLeader] == 6 || PlayerInfo[playerid][pMember] == 6 )
				{
				}
				else
				{
               	    SendClientMessage(playerid,COL_LIGHTRED,"Ce Véhicule appartient à la Dinozzo Cosia !");
					RemovePlayerFromVehicle(playerid);
					return 1;
				}
            }
            else if(strcmp(VehiculeInfo[vehicleid][Proprio],"Leone",true) == 0)
            {
			    if(PlayerInfo[playerid][pLeader] == 12 || PlayerInfo[playerid][pMember] == 12)
				{
				}
				else
				{
               	    SendClientMessage(playerid,COL_LIGHTRED,"Ce Véhicule appartient à la mafia Leone !");
					RemovePlayerFromVehicle(playerid);
					return 1;
				}
            }
            else if(strcmp(VehiculeInfo[vehicleid][Proprio],"Yakuza",true) == 0)
            {
			    if(PlayerInfo[playerid][pLeader] == 14 || PlayerInfo[playerid][pMember] == 14)
				{
				}
				else
				{
               	    SendClientMessage(playerid,COL_LIGHTRED,"Ce Véhicule appartient à la mafia Yakuza !");
					RemovePlayerFromVehicle(playerid);
					return 1;
				}
            }
			else if(strcmp(VehiculeInfo[vehicleid][Proprio],"Ballas",true) == 0)
            {
			    if(PlayerInfo[playerid][pLeader] == 16 || PlayerInfo[playerid][pMember] == 16)
				{
				}
				else
				{
               	    SendClientMessage(playerid,COL_LIGHTRED,"Ce Véhicule appartient aux Ballas !");
					RemovePlayerFromVehicle(playerid);
					return 1;
				}
            }
            else if(strcmp(VehiculeInfo[vehicleid][Proprio],"CripZ",true) == 0)
            {
			    if(PlayerInfo[playerid][pLeader] == 15 || PlayerInfo[playerid][pMember] == 15)
				{
				}
				else
				{
               	    SendClientMessage(playerid,COL_LIGHTRED,"Ce Véhicule appartient aux Crip'Z !");
					RemovePlayerFromVehicle(playerid);
					return 1;
				}
            }
            else if(strcmp(VehiculeInfo[vehicleid][Proprio],playername,true) == 0)
            {
				format(string,sizeof(string),"Bienvenu dans votre vehicule (%s)",VehiculeInfo[vehicleid][Nom]);
				SendClientMessage(playerid,COL_GREEN,string);
				if(VehiculeInfo[vehicleid][Alarme] == 0)
				{
				    SendClientMessage(playerid,COL_GREEN,"Vôtre véhicule n'es pas verouiller");
				}
				else if(VehiculeInfo[vehicleid][Alarme] == 1)
				{
				    SendClientMessage(playerid,COL_GREEN,"Vôtre véhicule es verouiller");
				}
				else if(VehiculeInfo[vehicleid][Alarme] == 2)
				{
				    SendClientMessage(playerid,COL_GREEN,"Ce vehicule est proteger par l'alarme admin!");
				}
            }
            else
            {
                if(VehiculeInfo[vehicleid][Alarme] == 0)
                {
                	format(string,sizeof(string),"Ce véhicule (%s) es imatriculé à %s",VehiculeInfo[vehicleid][Nom],VehiculeInfo[vehicleid][Proprio]);
                    SendClientMessage(playerid,COL_GREEN,string);
				}
				else if(VehiculeInfo[vehicleid][Alarme] == 1)
				{
				    format(string,sizeof(string),"Ce véhicule (%s) es imatriculé à %s et est vérouillez!",VehiculeInfo[vehicleid][Nom],VehiculeInfo[vehicleid][Proprio]);
                    SendClientMessage(playerid,COL_GREEN,string);
                    RemovePlayerFromVehicle(playerid);
                    return 1;
				}
				else if(VehiculeInfo[vehicleid][Alarme] == 2)
				{
				    format(string,sizeof(string),"Ce vehicule (%s) appartient a %s et est proteger par l'alarme admin!",VehiculeInfo[vehicleid][Nom],VehiculeInfo[vehicleid][Proprio]);
				    SendClientMessage(playerid,COL_GREEN,string);
				}
			}
			if(EsUnAvion(vehicleid)) { TogglePlayerControllable(playerid, 1); return 1; }
            if(VehiculeInfo[vehicleid][Moteur] == 3)
            {
		    	SetVehicleHealth(vehicleid, 500);
				format(string,sizeof(string),"Ce vehicule (%s) es en panne appelez un mécanicien!",VehiculeInfo[vehicleid][Nom]);
				SendClientMessage(playerid,COL_LIGHTRED,string);
				TogglePlayerControllable(playerid, 0);
				VehiculeInfo[vehicleid][Moteur] = 3;
				return 1;
			}
      		if(VehiculeInfo[vehicleid][Moteur] == 0)
  		    {
  		        format(string,sizeof(string),"Le moteur de ce/cette %s es etein appuiez sur SHIFT ou faite /moteur pour le démarer",VehiculeInfo[vehicleid][Nom]);
	       		SendClientMessage(playerid,COL_LIGHTRED,string);
				TogglePlayerControllable(playerid, 0);
			}
		}
	}
	return 1;
}
public Script_OnPlayerText(playerid, text[])
{
	#if defined USE_MENU
	    new tmp[128],string[128],idx;
		if(DefinirPrix[playerid] == 1)
		{
		    tmp = strtok2(text, idx);
		    if(!strlen(tmp))
		    {
		        SendClientMessage(playerid,COL_LIGHTRED,"Veuillez entrer un prix pour ce vehicule!");
		        return 1;
			}
			if(!IsNumeric2(tmp))
			{
			    SendClientMessage(playerid,COL_LIGHTRED,"Veuillez entrer un nombre correct!");
			    return 1;
			}
			new vehicleid = GetPlayerVehicleID(playerid);
		    VehiculeInfo[vehicleid][Prix] = strval(tmp);
		    format(string,sizeof(string),"Vous avez changer le prix de ce vehicule (%s). Nouveau prix: %d$",VehiculeInfo[vehicleid][Nom],VehiculeInfo[vehicleid][Prix]);
		    SendClientMessage(playerid,COL_GREEN,string);
		    TogglePlayerControllable(playerid,1);
		    DefinirPrix[playerid] = 0;
		    return 1;
		}
		if(DefinirEssence[playerid] == 1)
		{
		    tmp = strtok2(text, idx);
		    if(!strlen(tmp))
		    {
		        SendClientMessage(playerid,COL_LIGHTRED,"Veuillez entrer un valeur maxium d'essence pour ce vehicule!");
		        return 1;
			}
			if(!IsNumeric2(tmp))
			{
			    SendClientMessage(playerid,COL_LIGHTRED,"Veuillez entrer un nombre correct!");
			    return 1;
			}
			new vehicleid = GetPlayerVehicleID(playerid);
		    VehiculeInfo[vehicleid][MaxEssence] = strval(tmp);
		    format(string,sizeof(string),"Vous avez changer le reservoir de ce vehicule (%s). Nouvelle quantiter maxiumum d'essence: %d$",VehiculeInfo[vehicleid][Nom],VehiculeInfo[vehicleid][MaxEssence]);
		    SendClientMessage(playerid,COL_GREEN,string);
		    TogglePlayerControllable(playerid,1);
		    DefinirEssence[playerid] = 0;
		    return 1;
		}
		#if defined USE_CALLCAR
			if(MyVehicleID[playerid][0] != 0)
			{
				tmp = strtok2(text, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid,COL_WHITE,"Veuillez entrer un numero de vehicule!");
				    return 1;
	       		}
				new veh = strval(tmp);
				if(veh < 1 || veh > MAX_PLAYER_VEHICLES)
				{
	   				format(string,sizeof(string),"Le numero du vehicule ne peux être inferieur a 1 ou superieur a %d",MAX_PLAYER_VEHICLES);
			    	SendClientMessage(playerid,COL_LIGHTRED,string);
				    return 1;
				}
				new vehicleid = MyVehicleID[playerid][veh-1];
				if(vehicleid == 0)
				{
	   				SendClientMessage(playerid,COL_LIGHTRED,"Vous n'avez pas de vehicule a se numéro");
				    return 1;
				}
			    format(string,sizeof(string),"Ce vehicule (%s) a été appeler par sont proprietaire (%s)!",VehiculeInfo[vehicleid][Nom],VehiculeInfo[vehicleid][Proprio]);
				for(new i=0;i<MAX_PLAYERS;i++)
				{
				    if(IsPlayerConnected(i))
				    {
				        if(IsPlayerInAnyVehicle(i) && GetPlayerVehicleID(i) == vehicleid)
				        {
				            SendClientMessage(i,COL_LIGHTRED,string);
				            RemovePlayerFromVehicle(i);
						}
					}
				}
				for(new m=0;m<MAX_PLAYER_VEHICLES;m++)
				{
				    MyVehicleID[playerid][m] = 0;
				}
				SetTimerEx("DestroyVeh",2500,0,"i",vehicleid);
				SetTimerEx("CallCar",3000,0,"ii",playerid,vehicleid);
				format(string,sizeof(string),"Votre vehicule (%s) arrivera dans quelque seconde veuillez patienter!",VehiculeInfo[vehicleid][Nom]);
				SendClientMessage(playerid,COL_LIGHTRED,string);
			    TogglePlayerControllable(playerid,1);
			    return 1;
			}
		#endif
	#else
		#pragma unused playerid
		#pragma unused text
	#endif
#if defined FILTERSCRIPT
	return 1;
#else
	return 0;
#endif
}
public Script_OnPlayerSelectedMenuRow(playerid, row)
{
    #if defined USE_MENU
	    new Menu:MenuActuel = GetPlayerMenu(playerid);
	    if(MenuActuel == MenuJoueur)
		{
			switch(row)
			{
			    case 0:
				{
					AcheterVehicule(playerid);
				 	HideMenuForPlayer(MenuActuel, playerid);
					TogglePlayerControllable(playerid, 1);
				}
				case 1:
				{
				    VendreVehicule(playerid, 0);
				    HideMenuForPlayer(MenuActuel, playerid);
				    TogglePlayerControllable(playerid, 1);
				}
				case 2:
				{
				    GarerVehicule(playerid, 0);
				    HideMenuForPlayer(MenuActuel, playerid);
				    TogglePlayerControllable(playerid, 1);
				}
				case 3:
				{
				    AlarmeVehicule(playerid, 0);
	 			    HideMenuForPlayer(MenuActuel, playerid);
				    TogglePlayerControllable(playerid, 1);
				}
				case 4:
				{
					EssenceVehicule(playerid, 0);
	 			    HideMenuForPlayer(MenuActuel, playerid);
				    TogglePlayerControllable(playerid, 1);
				}
				case 5:
				{
				    TableauDeBord(playerid);
	 			    HideMenuForPlayer(MenuActuel, playerid);
				    TogglePlayerControllable(playerid, 1);
				}
				#if defined USE_CALLCAR
		 			case 6:
					{
						if(CountPlayerVehicle(playerid) == 0)
						{
						    SendClientMessage(playerid,COL_LIGHTRED,"Vous n'avez pas de vehicules!");
							TogglePlayerControllable(playerid,1);
							return 1;
						}
						new playername[MAX_PLAYER_NAME],string[128];
						SendClientMessage(playerid,COL_WHITE,"------[LISTE DE VOS VEHICULE]------");
						GetPlayerName(playerid,playername,sizeof(playername));
						new count = 0;
						for(new v=1;v<NbVeh;v++)
						{
		    				if(VehiculeInfo[v][VehID] != INVALID_VEH_ID)
					    	{
						 		if(strcmp(VehiculeInfo[v][Proprio],playername,true) == 0)
							    {
									format(string,sizeof(string),"%d: %s",count+1,VehiculeInfo[v][Nom]);
									SendClientMessage(playerid,COL_WHITE,string);
									MyVehicleID[playerid][count] = v;
									count++;
								}
							}
						}
						SendClientMessage(playerid,COL_LIGHTRED,"Pour appeler un vehicule entrer sont numero dans la zone de texte!");
		 			    HideMenuForPlayer(MenuActuel, playerid);
					    TogglePlayerControllable(playerid, 1);
					}
					case 7:
					{
		 			    HideMenuForPlayer(MenuActuel, playerid);
					    TogglePlayerControllable(playerid, 1);
					}
				#else
	 				case 6:
					{
		 			    HideMenuForPlayer(MenuActuel, playerid);
					    TogglePlayerControllable(playerid, 1);
					}
				#endif
			}
		}
		else if(MenuActuel == MenuAdmin)
		{
			switch(row)
			{
			    case 0:
			    {
			        DefinirPrix[playerid] = 1;
			        SendClientMessage(playerid,COL_GREEN,"Taper le prix dans la zone de texte!");
					HideMenuForPlayer(MenuActuel, playerid);
				}
				case 1:
				{
				    AlarmeVehicule(playerid, 1);
				    HideMenuForPlayer(MenuActuel, playerid);
				    TogglePlayerControllable(playerid, 1);
				}
				case 2:
				{
				    VendreVehicule(playerid, 1);
				    HideMenuForPlayer(MenuActuel, playerid);
				    TogglePlayerControllable(playerid, 1);
				}
				case 3:
				{
				    StatusVehicule(playerid);
				    HideMenuForPlayer(MenuActuel, playerid);
				    TogglePlayerControllable(playerid, 1);
				}
				case 4:
				{
				    GarerVehicule(playerid, 1);
				    HideMenuForPlayer(MenuActuel, playerid);
				    TogglePlayerControllable(playerid, 1);
				}
				case 5:
				{
				    EssenceVehicule(playerid, 1);
	 			    HideMenuForPlayer(MenuActuel, playerid);
				    TogglePlayerControllable(playerid, 1);
				}
	 			case 6:
				{
	 			    DefinirEssence[playerid] = 1;
	 			    SendClientMessage(playerid,COL_GREEN,"Taper une valeur dans la zone de texte!");
	 			    HideMenuForPlayer(MenuActuel, playerid);
				}
				case 7:
				{
				    ResetTuning(playerid);
				    HideMenuForPlayer(MenuActuel,playerid);
				    TogglePlayerControllable(playerid, 1);
				}
				case 8:
				{
	 			    HideMenuForPlayer(MenuActuel, playerid);
				    TogglePlayerControllable(playerid, 1);
				}
			}
		}
	#else
		#pragma unused playerid
		#pragma unused row
	#endif
	return 1;
}
public Script_OnPlayerExitedMenu(playerid)
{
	#if defined USE_MENU
		new vehicleid = GetPlayerVehicleID(playerid);
		if(VehiculeInfo[vehicleid][Moteur] != 2)
		{
			new Menu:MenuActuel = GetPlayerMenu(playerid);
			if(MenuActuel == MenuJoueur || MenuActuel == MenuAdmin)
			{
				TogglePlayerControllable(playerid, 1);
			}
		}
	#else
	    #pragma unused playerid
	#endif
	return 1;
}
public Script_OnVehicleMod(playerid, vehicleid, componentid)
{
	new playername[MAX_PLAYER_NAME];
	GetPlayerName(playerid,playername,sizeof(playername));
	if(strcmp(VehiculeInfo[vehicleid][Proprio],playername,true) == 0)
	{
		for(new s=0; s<20; s++)
		{
			if(componentid == spoiler[s][0])
			{
				VehiculeInfo[vehicleid][Tuning1] = componentid;
  			}
		}
		for(new s=0; s<3; s++)
		{
			if(componentid == nitro[s][0])
			{
				VehiculeInfo[vehicleid][Tuning2] = componentid;
  			}
		}
		for(new s=0; s<23; s++)
		{
			if(componentid == fbumper[s][0])
			{
				VehiculeInfo[vehicleid][Tuning3] = componentid;
  			}
		}
		for(new s=0; s<22; s++)
		{
			if(componentid == rbumper[s][0])
			{
       			VehiculeInfo[vehicleid][Tuning4] = componentid;
  			}
		}
		for(new s=0; s<28; s++)
		{
			if(componentid == exhaust[s][0])
			{
				VehiculeInfo[vehicleid][Tuning5] = componentid;
  			}
		}
		for(new s=0; s<2; s++)
		{
			if(componentid == bventr[s][0])
			{
				VehiculeInfo[vehicleid][Tuning6] = componentid;
  			}
		}
		for(new s=0; s<2; s++)
		{
			if(componentid == bventl[s][0])
			{
				VehiculeInfo[vehicleid][Tuning7] = componentid;
  			}
		}
		for(new s=0; s<4; s++)
		{
			if(componentid == bscoop[s][0])
			{
				VehiculeInfo[vehicleid][Tuning8] = componentid;
  			}
		}
		for(new s=0; s<13; s++)
		{
			if(componentid == rscoop[s][0])
		 	{
       			VehiculeInfo[vehicleid][Tuning9] = componentid;
  			}
		}
		for(new s=0; s<21; s++)
		{
			if(componentid == lskirt[s][0])
			{
				VehiculeInfo[vehicleid][Tuning10] = componentid;
 			}
		}
		for(new s=0; s<21; s++)
		{
			if(componentid == rskirt[s][0])
			{
       			VehiculeInfo[vehicleid][Tuning11] = componentid;
 			}
		}
		for(new s=0; s<1; s++)
		{
			if(componentid == hydraulics[s][0])
			{
				VehiculeInfo[vehicleid][Tuning12] = componentid;
 			}
		}
		for(new s=0; s<1; s++)
		{
			if(componentid == base[s][0])
			{
				VehiculeInfo[vehicleid][Tuning13] = componentid;
 			}
		}
		for(new s=0; s<2; s++)
		{
			if(componentid == rbbars[s][0])
			{
       			VehiculeInfo[vehicleid][Tuning14] = componentid;
 			}
		}
		for(new s=0; s<2; s++)
		{
			if(componentid == fbbars[s][0])
			{
				VehiculeInfo[vehicleid][Tuning15] = componentid;
 			}
		}
		for(new s=0; s<17; s++)
		{
			if(componentid == wheels[s][0])
			{
       			VehiculeInfo[vehicleid][Tuning16] = componentid;
   	       	}
		}
		for(new s=0; s<2; s++)
		{
			if(componentid == lights[s][0])
		 	{
				VehiculeInfo[vehicleid][Tuning17] = componentid;
 			}
		}
	}
	SauvegardeVeh();
	return 1;
}
public Script_OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	new playername[MAX_PLAYER_NAME];
	GetPlayerName(playerid,playername,sizeof(playername));
	if(strcmp(VehiculeInfo[vehicleid][Proprio],playername,true) == 0)
	{
		VehiculeInfo[vehicleid][Peinture] = paintjobid;
	}
	SauvegardeVeh();
	return 1;
}
public Script_OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	new playername[MAX_PLAYER_NAME];
	GetPlayerName(playerid,playername,sizeof(playername));
	if(strcmp(VehiculeInfo[vehicleid][Proprio],playername,true) == 0)
	{
	    VehiculeInfo[vehicleid][Couleur1] = color1;
	    VehiculeInfo[vehicleid][Couleur2] = color2;
	}
	SauvegardeVeh();
	return 1;
}


AcheterVehicule(playerid)
{
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
 	{
		new string[128];
		new vehicleid = GetPlayerVehicleID(playerid);
		if(VehiculeInfo[vehicleid][VehID] == INVALID_VEH_ID)
		{
  			SendClientMessage(playerid,COL_LIGHTRED,"Ce vehicule ne peux pas être acheter!");
	    	return 1;
		}
		if(strcmp(VehiculeInfo[vehicleid][Proprio],"Aucun",true) == 0)
		{
			if(VehiculeInfo[vehicleid][Status] == 0) //Si le vehicule ne peux pas être acheter!
			{
			    SendClientMessage(playerid,COL_LIGHTRED,"Ce vehicule ne peux pas être acheter!");
			    return 1;
			}
		    if(GetPlayerMoney(playerid) < VehiculeInfo[vehicleid][Prix])
			{
	  			format(string,sizeof(string),"Vous n'avez pas assez d'argent pour acheter ce vehicule. Il vous faut %d$!",VehiculeInfo[vehicleid][Prix]);
		        SendClientMessage(playerid,COL_LIGHTRED,string);
		        return 1;
			}
			if(CountPlayerVehicle(playerid) == MAX_PLAYER_VEHICLES)
			{
				format(string,sizeof(string),"Vous avez atteint la limite de vehicule possible (%d). Pour acheter ce vehicule vender l'un de vos vehicule!",MAX_PLAYER_VEHICLES);
				SendClientMessage(playerid,COL_LIGHTRED,string);
			}
			new playername[MAX_PLAYER_NAME];
			GetPlayerName(playerid,playername,sizeof(playername));
			GivePlayerMoney(playerid,-VehiculeInfo[vehicleid][Prix]);
			strmid(VehiculeInfo[vehicleid][Proprio],playername,0,strlen(playername),sizeof(playername));
			format(string,sizeof(string),"Vous avez acheter ce vehicule (%s) pour %d$!",VehiculeInfo[vehicleid][Nom],VehiculeInfo[vehicleid][Prix]);
			SendClientMessage(playerid,COL_GREEN,string);
			VehiculeInfo[vehicleid][Moteur] = 1;
			SauvegardeVeh();
		}
		else
		{
		    format(string,sizeof(string),"Ce vehicule appartient a %s. Vous ne pouvez pas l'acheter!",VehiculeInfo[vehicleid][Proprio]);
			SendClientMessage(playerid,COL_LIGHTRED,string);
		}
	}
	else SendClientMessage(playerid,COL_LIGHTRED,"Vous n'ête pas au volant d'un vehicule!");
	return 1;
}
VendreVehicule(playerid, admin)
{
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
 	{
		new string[128];
		new vehicleid = GetPlayerVehicleID(playerid);
		new playername[MAX_PLAYER_NAME];
		if(VehiculeInfo[vehicleid][VehID] == INVALID_VEH_ID)
		{
  			SendClientMessage(playerid,COL_LIGHTRED,"Ce vehicule ne peux pas être vendu!");
	    	return 1;
		}
		if(admin == 0)
		{
			GetPlayerName(playerid,playername,sizeof(playername));
			if(strcmp(VehiculeInfo[vehicleid][Proprio],playername,true) == 0)
			{
			    GivePlayerMoney(playerid,VehiculeInfo[vehicleid][Prix]);
				strmid(VehiculeInfo[vehicleid][Proprio],"Aucun",0,strlen("Aucun"),128);
				if(VehiculeInfo[vehicleid][Alarme]!= 2)
				{
				    VehiculeInfo[vehicleid][Alarme] = 0;
				}
				format(string,sizeof(string),"Vous avez vendu votre vehicule (%s) pour %d$!",VehiculeInfo[vehicleid][Nom],VehiculeInfo[vehicleid][Prix]);
				SendClientMessage(playerid,COL_GREEN,string);
				RemoveAllPlayerFromVehicle(vehicleid);
				SetTimerEx("RestartVeh",2000,0,"i",vehicleid);
				SauvegardeVeh();
			}
			else SendClientMessage(playerid,COL_LIGHTRED,"Ce vehicule ne vous appartient pas!");
		}
		else
		{
			if(strcmp(VehiculeInfo[vehicleid][Proprio],"Aucun",true) == 0)
			{
				if(VehiculeInfo[vehicleid][Alarme]!= 2)
				{
				    VehiculeInfo[vehicleid][Alarme] = 0;
				}
				format(string,sizeof(string),"Vous avez vendu ce vehicule (%s) qui appartenait a %s",VehiculeInfo[vehicleid][Nom],VehiculeInfo[vehicleid][Proprio]);
				SendClientMessage(playerid,COL_GREEN,string);
				for(new i=0;i<MAX_PLAYERS;i++)
				{
				    if(IsPlayerConnected(i))
				    {
						GetPlayerName(i,playername,sizeof(playername));
						if(strcmp(VehiculeInfo[vehicleid][Proprio],playername,true) == 0)
						{
						    format(string,sizeof(string),"Un admin a vendu votre vehicule (%s)",VehiculeInfo[vehicleid][Nom]);
							SendClientMessage(playerid,COL_LIGHTRED,string);
						}
					}
				}
				strmid(VehiculeInfo[vehicleid][Proprio],"Aucun",0,strlen("Aucun"),128);
				RemoveAllPlayerFromVehicle(vehicleid);
				SetTimerEx("RestartVeh",2000,0,"i",vehicleid);
			}
			else SendClientMessage(playerid,COL_LIGHTRED,"Ce vehicule n'a pas de proprietaire!");
		}
	}
	else SendClientMessage(playerid,COL_LIGHTRED,"Vous n'ête pas au volant d'un vehicule!");
	return 1;
}
GarerVehicule(playerid, admin)
{
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
 	{
		new string[128];
		new vehicleid = GetPlayerVehicleID(playerid);
		if(VehiculeInfo[vehicleid][VehID] == INVALID_VEH_ID)
		{
  			SendClientMessage(playerid,COL_LIGHTRED,"Ce vehicule ne peux pas être garer!");
	    	return 1;
		}
		if(admin == 0)
		{
			new playername[MAX_PLAYER_NAME];
			GetPlayerName(playerid,playername,sizeof(playername));
			if(strcmp(VehiculeInfo[vehicleid][Proprio],playername,true) == 0)
			{
				new Float:x,Float:y,Float:z,Float:a;
				GetVehiclePos(vehicleid,x,y,z);
				GetVehicleZAngle(vehicleid,a);
				VehiculeInfo[vehicleid][XSpawn] = x;
				VehiculeInfo[vehicleid][YSpawn] = y;
				VehiculeInfo[vehicleid][ZSpawn] = z;
				VehiculeInfo[vehicleid][ASpawn] = a;
				DestroyVehicle(vehicleid);
                CreateVehicle(VehiculeInfo[vehicleid][Model],VehiculeInfo[vehicleid][XSpawn],VehiculeInfo[vehicleid][YSpawn],VehiculeInfo[vehicleid][ZSpawn],VehiculeInfo[vehicleid][ASpawn],VehiculeInfo[vehicleid][Couleur1],VehiculeInfo[vehicleid][Couleur2],RESPAWN_DELAY);
		    	TuningVehicule(vehicleid);
				format(string,sizeof(string),"Votre vehicule (%s) a bien été garé. Il apparaitra toujours ici!",VehiculeInfo[vehicleid][Nom]);
				SendClientMessage(playerid,COL_GREEN,string);
				SauvegardeVeh();
			}
			else SendClientMessage(playerid,COL_LIGHTRED,"Ce vehicule ne vous appartient pas!");
		}
		else
		{
			new Float:x,Float:y,Float:z,Float:a;
			GetVehiclePos(vehicleid,x,y,z);
			GetVehicleZAngle(vehicleid,a);
			VehiculeInfo[vehicleid][XSpawn] = x;
			VehiculeInfo[vehicleid][YSpawn] = y;
			VehiculeInfo[vehicleid][ZSpawn] = z;
			VehiculeInfo[vehicleid][ASpawn] = a;
			DestroyVehicle(vehicleid);
            CreateVehicle(VehiculeInfo[vehicleid][Model],VehiculeInfo[vehicleid][XSpawn],VehiculeInfo[vehicleid][YSpawn],VehiculeInfo[vehicleid][ZSpawn],VehiculeInfo[vehicleid][ASpawn],VehiculeInfo[vehicleid][Couleur1],VehiculeInfo[vehicleid][Couleur2],RESPAWN_DELAY);
	    	TuningVehicule(vehicleid);
			format(string,sizeof(string),"Ce vehicule (%s) a bien été garé. Il apparaitra toujours ici!",VehiculeInfo[vehicleid][Nom]);
			SendClientMessage(playerid,COL_GREEN,string);
			SauvegardeVeh();
		}
	}
	else SendClientMessage(playerid,COL_LIGHTRED,"Vous n'ête pas au volant d'un vehicule!");
	return 1;
}
AlarmeVehicule(playerid,admin)
{
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
 	{
		new string[128],playername[MAX_PLAYER_NAME];
		new vehicleid = GetPlayerVehicleID(playerid);
		GetPlayerName(playerid,playername,sizeof(playername));
		if(admin == 0)
		{
			if(strcmp(VehiculeInfo[vehicleid][Proprio],playername,true) == 0)
			{
				if(VehiculeInfo[vehicleid][Alarme] == 0)
				{
				    VehiculeInfo[vehicleid][Alarme] = 1;
				    format(string,sizeof(string),"L'alarme de votre vehicule (%s) a été activer!",VehiculeInfo[vehicleid][Nom]);
					SendClientMessage(playerid,COL_GREEN,string);
				}
				else if(VehiculeInfo[vehicleid][Alarme] == 1)
				{
				    VehiculeInfo[vehicleid][Alarme] = 0;
				    format(string,sizeof(string),"L'alarme de votre vehicule (%s) a été desactiver!",VehiculeInfo[vehicleid][Nom]);
				    SendClientMessage(playerid,COL_LIGHTRED,string);
				}
				else if(VehiculeInfo[vehicleid][Alarme] == 2)
				{
				    SendClientMessage(playerid,COL_GREEN,"Ce vehicule est proteger par l'alarme admin!");
				}
			}
			else SendClientMessage(playerid,COL_LIGHTRED,"Ce vehicule ne vous appartient pas!");
		}
		else
		{
			if(VehiculeInfo[vehicleid][Alarme] != 2)
			{
			    VehiculeInfo[vehicleid][Alarme] = 2;
			    format(string,sizeof(string),"Vous avez activer l'alarme admin sur ce vehicule (%s)",VehiculeInfo[vehicleid][Nom]);
			    SendClientMessage(playerid,COL_GREEN,string);
			}
			else
			{
			    VehiculeInfo[vehicleid][Alarme] = 0;
			    format(string,sizeof(string),"Vous avez desactiver l'alarme admin sur ce vehicule (%s)",VehiculeInfo[vehicleid][Nom]);
			    SendClientMessage(playerid,COL_LIGHTRED,string);
			}
		}
	}
	else SendClientMessage(playerid,COL_LIGHTRED,"Vous n'ête pas au volant d'un vehicule!");
	return 1;
}
EssenceVehicule(playerid, admin)
{
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
 	{
		new string[128];
		new vehicleid = GetPlayerVehicleID(playerid);
		if(admin == 0)
		{
			for(new p=0;p<sizeof(Pompe);p++)
			{
			    if(PlayerToPoint2(4.0,playerid,Pompe[p][0],Pompe[p][1],Pompe[p][2]))
			    {
					if(VehiculeInfo[vehicleid][Essence] == VehiculeInfo[vehicleid][MaxEssence])
					{
					    format(string,sizeof(string),"Le reservoir de votre vehicule (%s) est plein!");
					    SendClientMessage(playerid,COL_GREEN,string);
						return 1;
					}
			        format(string,sizeof(string),"Le remplisage de votre vehicule (%s) commence veuillez patienter!",VehiculeInfo[vehicleid][Nom]);
			        SendClientMessage(playerid,COL_GREEN,string);
			        TimerEssence[playerid] = SetTimerEx("Remplisage",1000,1,"i",playerid);
			        PompeEssence[playerid] = p;
			        return 1;
			    }
			}
			return SendClientMessage(playerid,COL_LIGHTRED,"Vous n'ête pas devant une pompe a essence!");
		}
		else
		{
		    VehiculeInfo[vehicleid][Essence] = VehiculeInfo[vehicleid][MaxEssence];
		    format(string,sizeof(string),"Vous avez rempli le reservoir de ce vehicule (%s)",VehiculeInfo[vehicleid][Nom]);
		    SendClientMessage(playerid,COL_GREEN,string);
		}
	}
	else SendClientMessage(playerid,COL_LIGHTRED,"Vous n'ête pas au volant d'un vehicule!");
	return 1;
}
TableauDeBord(playerid)
{
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		if(TableauActive[playerid] == 1)
		{
	 		for(new b=0;b<sizeof(BarreVieVeh);b++)
			{
		       	TextDrawHideForPlayer(playerid,BarreVieVeh[b]);
			}
		    TableauActive[playerid] = 0;
		    SendClientMessage(playerid,COL_GREEN,"Vous avez desactiver le tableau de bord de votre vehicule!");
		}
		else
		{
		    TableauActive[playerid] = 1;
		    SendClientMessage(playerid,COL_GREEN,"Vous avez activer le tableau de bord de votre vehicule!");
		}
	}
	else SendClientMessage(playerid,COL_LIGHTRED,"Vous n'ête pas au volant d'un vehicule!");
	return 1;
}
StatusVehicule(playerid)
{
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		new string[128];
		new vehicleid = GetPlayerVehicleID(playerid);
		if(VehiculeInfo[vehicleid][VehID] == INVALID_VEH_ID)
		{
  			SendClientMessage(playerid,COL_LIGHTRED,"Le status de ce vehicule ne peux pas être changer!");
	    	return 1;
		}
		if(strcmp(VehiculeInfo[vehicleid][Proprio],"Aucun",true) == 0)
		{
			if(VehiculeInfo[vehicleid][Status] == 1)
			{
			    VehiculeInfo[vehicleid][Status] = 0;
			    format(string,sizeof(string),"Ce vehicule (%s) ne pourra plus être achter!",VehiculeInfo[vehicleid][Nom]);
			    SendClientMessage(playerid,COL_GREEN,string);
			}
			else
			{
			    VehiculeInfo[vehicleid][Status] = 1;
			    format(string,sizeof(string),"Ce vehicule (%s) peux maintenant être achter!",VehiculeInfo[vehicleid][Nom]);
			    SendClientMessage(playerid,COL_GREEN,string);
			}
			SauvegardeVeh();
		}
		else
		{
		    format(string,sizeof(string),"Ce vehicule (%s) appartient a %s et sont status ne peux donc pas être changer!",VehiculeInfo[vehicleid][Nom],VehiculeInfo[vehicleid][Proprio]);
			SendClientMessage(playerid,COL_LIGHTRED,string);
		}
	}
	else SendClientMessage(playerid,COL_LIGHTRED,"Vous n'ête pas au volant d'un vehicule!");
	return 1;
}
public EsUnAvion(carid)
{
	new model = GetVehicleModel(carid);
	if( model == 592 || model == 577 || model == 511 || model == 512 || model == 593 || model == 520 || model == 553 || model == 476 || model == 519 || model == 460 || model == 513 || model == 548 || model == 425 || model == 417 || model == 487 || model == 488 || model == 497 || model == 563 || model == 447 || model == 469)
	{
		return 1;
	}
	return 0;
}
ResetTuning(playerid)
{
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		VehiculeInfo[vehicleid][Peinture] = 0;
		VehiculeInfo[vehicleid][Tuning1] = 0;
		VehiculeInfo[vehicleid][Tuning2] = 0;
		VehiculeInfo[vehicleid][Tuning3] = 0;
		VehiculeInfo[vehicleid][Tuning4] = 0;
		VehiculeInfo[vehicleid][Tuning5] = 0;
		VehiculeInfo[vehicleid][Tuning6] = 0;
		VehiculeInfo[vehicleid][Tuning7] = 0;
		VehiculeInfo[vehicleid][Tuning8] = 0;
		VehiculeInfo[vehicleid][Tuning9] = 0;
		VehiculeInfo[vehicleid][Tuning10] = 0;
		VehiculeInfo[vehicleid][Tuning11] = 0;
		VehiculeInfo[vehicleid][Tuning12] = 0;
		VehiculeInfo[vehicleid][Tuning13] = 0;
		VehiculeInfo[vehicleid][Tuning14] = 0;
		VehiculeInfo[vehicleid][Tuning15] = 0;
		VehiculeInfo[vehicleid][Tuning16] = 0;
		VehiculeInfo[vehicleid][Tuning17] = 0;
		RemoveAllPlayerFromVehicle(vehicleid);
		SetTimerEx("RestartVeh",2000,0,"i",vehicleid);
		new string[128];
		format(string,sizeof(string),"Le tuning de ce vehicule (%s) a bien été retirer!",VehiculeInfo[vehicleid][Nom]);
		SendClientMessage(playerid,COL_GREEN,string);
	}
	else SendClientMessage(playerid,COL_LIGHTRED,"Vous n'ête pas au volant d'un vehicule!");
	return 1;
}
public IsAnRadar(playerid)
{
    for(new a = 0; a < sizeof(Radars); a ++)
	{
    	if(PlayerToPoint(20,playerid,Radars[a][0],Radars[a][1],Radars[a][2])){ return 1; }
	}
	return 0;
}

TuningVehicule(vehicleid)
{
	ChangeVehicleColor(vehicleid,VehiculeInfo[vehicleid][Couleur1],VehiculeInfo[vehicleid][Couleur2]);
	if(VehiculeInfo[vehicleid][Peinture] != 0) ChangeVehiclePaintjob(vehicleid,VehiculeInfo[vehicleid][Peinture]);
	if(VehiculeInfo[vehicleid][Tuning1] != 0) AddVehicleComponent(vehicleid,VehiculeInfo[vehicleid][Tuning1]);
	if(VehiculeInfo[vehicleid][Tuning2] != 0) AddVehicleComponent(vehicleid,VehiculeInfo[vehicleid][Tuning2]);
	if(VehiculeInfo[vehicleid][Tuning3] != 0) AddVehicleComponent(vehicleid,VehiculeInfo[vehicleid][Tuning3]);
	if(VehiculeInfo[vehicleid][Tuning4] != 0) AddVehicleComponent(vehicleid,VehiculeInfo[vehicleid][Tuning4]);
	if(VehiculeInfo[vehicleid][Tuning5] != 0) AddVehicleComponent(vehicleid,VehiculeInfo[vehicleid][Tuning5]);
	if(VehiculeInfo[vehicleid][Tuning6] != 0) AddVehicleComponent(vehicleid,VehiculeInfo[vehicleid][Tuning6]);
	if(VehiculeInfo[vehicleid][Tuning7] != 0) AddVehicleComponent(vehicleid,VehiculeInfo[vehicleid][Tuning7]);
	if(VehiculeInfo[vehicleid][Tuning8] != 0) AddVehicleComponent(vehicleid,VehiculeInfo[vehicleid][Tuning8]);
	if(VehiculeInfo[vehicleid][Tuning9] != 0) AddVehicleComponent(vehicleid,VehiculeInfo[vehicleid][Tuning9]);
	if(VehiculeInfo[vehicleid][Tuning10] != 0) AddVehicleComponent(vehicleid,VehiculeInfo[vehicleid][Tuning10]);
	if(VehiculeInfo[vehicleid][Tuning11] != 0) AddVehicleComponent(vehicleid,VehiculeInfo[vehicleid][Tuning11]);
	if(VehiculeInfo[vehicleid][Tuning12] != 0) AddVehicleComponent(vehicleid,VehiculeInfo[vehicleid][Tuning12]);
	if(VehiculeInfo[vehicleid][Tuning13] != 0) AddVehicleComponent(vehicleid,VehiculeInfo[vehicleid][Tuning13]);
	if(VehiculeInfo[vehicleid][Tuning14] != 0) AddVehicleComponent(vehicleid,VehiculeInfo[vehicleid][Tuning14]);
	if(VehiculeInfo[vehicleid][Tuning15] != 0) AddVehicleComponent(vehicleid,VehiculeInfo[vehicleid][Tuning15]);
	if(VehiculeInfo[vehicleid][Tuning16] != 0) AddVehicleComponent(vehicleid,VehiculeInfo[vehicleid][Tuning16]);
	if(VehiculeInfo[vehicleid][Tuning17] != 0) AddVehicleComponent(vehicleid,VehiculeInfo[vehicleid][Tuning17]);
}
CountPlayerVehicle(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		new playername[MAX_PLAYER_NAME];
		new CountVehP = 0;
		GetPlayerName(playerid,playername,sizeof(playername));
		for(new v=1;v<NbVeh;v++)
		{
			if(VehiculeInfo[v][VehID] != INVALID_VEH_ID)
			{
			    if(strcmp(VehiculeInfo[v][Proprio],playername,true) == 0)
			    {
			        CountVehP++;
			    }
			}
		}
		return CountVehP;
	}
	return 0;
}
RemoveAllPlayerFromVehicle(vehicleid)
{
	for(new i=0;i<MAX_PLAYERS;i++)
	{
	    if(IsPlayerConnected(i))
	    {
	        if(IsPlayerInAnyVehicle(i) && GetPlayerVehicleID(i) == vehicleid)
	        {
	            RemovePlayerFromVehicle(i);
			}
		}
	}
}

#if defined USE_MYSQL
	CreateMysqlVehicle(vehicleid)
	{
		new query[512];
		format(query,sizeof(query),"INSERT INTO %s (`Model`,`XSpawn`,`YSpawn`,`ZSpawn`,`ASpawn`,`Couleur1`,`Couleur2`,`Nom`) VALUES (%d,'%f','%f','%f','%f',%d,%d,'%s')",
	 	 MYSQL_TB_VEH,VehiculeInfo[vehicleid][Model],VehiculeInfo[vehicleid][XSpawn],VehiculeInfo[vehicleid][YSpawn],
	 	 VehiculeInfo[vehicleid][ZSpawn],VehiculeInfo[vehicleid][ASpawn],VehiculeInfo[vehicleid][Couleur1],
		 VehiculeInfo[vehicleid][Couleur2],VehiculeInfo[vehicleid][Nom]
		);
		samp_mysql_query(query);
		format(query,sizeof(query),"SELECT LAST_INSERT_ID() FROM %s",MYSQL_TB_VEH);
	  	samp_mysql_query(query);
		samp_mysql_store_result();
		new strid[11];
		samp_mysql_fetch_row(strid);
		samp_mysql_free_result();
		VehiculeInfo[vehicleid][VehID] = strval(strid);
	}
#endif

public Vitesse()
{
    new string[128];
	for(new i=0;i<MAX_PLAYERS;i++)
	{
	 	if(IsPlayerConnected(i))
		{
		    if(GetPlayerState(i) == PLAYER_STATE_DRIVER)
		    {
		        new vehicleid = GetPlayerVehicleID(i);
		        if(TableauActive[i] == 1)
		        {
					for(new b=0;b<sizeof(BarreVieVeh);b++)
					{
			        	TextDrawHideForPlayer(i,BarreVieVeh[b]);
					}
	    			new Float:vieveh;
					GetVehicleHealth(vehicleid,vieveh);
					if(vieveh >= 0 && vieveh <= 249) TextDrawShowForPlayer(i,BarreVieVeh[0]);
					else if(vieveh >= 250 && vieveh <= 317) TextDrawShowForPlayer(i,BarreVieVeh[1]);
					else if(vieveh >= 318 && vieveh <= 385) TextDrawShowForPlayer(i,BarreVieVeh[2]);
					else if(vieveh >= 386 && vieveh <= 453) TextDrawShowForPlayer(i,BarreVieVeh[3]);
					else if(vieveh >= 454 && vieveh <= 521) TextDrawShowForPlayer(i,BarreVieVeh[4]);
					else if(vieveh >= 522 && vieveh <= 589) TextDrawShowForPlayer(i,BarreVieVeh[5]);
					else if(vieveh >= 590 && vieveh <= 657) TextDrawShowForPlayer(i,BarreVieVeh[6]);
					else if(vieveh >= 658 && vieveh <= 725) TextDrawShowForPlayer(i,BarreVieVeh[7]);
					else if(vieveh >= 726 && vieveh <= 793) TextDrawShowForPlayer(i,BarreVieVeh[8]);
					else if(vieveh >= 794 && vieveh <= 861) TextDrawShowForPlayer(i,BarreVieVeh[9]);
					else if(vieveh >= 862 && vieveh <= 929) TextDrawShowForPlayer(i,BarreVieVeh[10]);
					else if(vieveh >= 930 && vieveh <= 1000) TextDrawShowForPlayer(i,BarreVieVeh[11]);
				}
		        
 	        	new model = GetVehicleModel(vehicleid);
				new Float:value,Float:distance,Float:x,Float:y,Float:z;
	   			GetPlayerPos(i, x, y, z);
	            distance = floatsqroot(floatpower(floatabs(floatsub(x,PlayerPos[i][0])),2)+floatpower(floatabs(floatsub(y,PlayerPos[i][1])),2)+floatpower(floatabs(floatsub(z,PlayerPos[i][2])),2));
	            value = floatround(distance * 11000);
	            new vitesse = 0+floatround(value/1450);
			   	if(vitesse < 75 &&  Flashing[i] == 1)
				{
				    Flashing[i] = 0;
				}
				if(IsAnRadar(i) && Flashing[i] == 0)
				{
			    	if(vitesse > 75)
					{
			    	    Flashing[i] = 1;
				    	if(PlayerInfo[i][pMember] == 1 || PlayerInfo[i][pMember] == 2 || PlayerInfo[i][pMember] == 3 || PlayerInfo[i][pLeader] == 1 || PlayerInfo[i][pLeader] == 2 || PlayerInfo[i][pLeader] == 3)
						{
				    		SendClientMessage(i,ORANGE,"[Radar Fixe]Vous n'avez pas été flasher car vous êtes un membre des forces de l'ordre.");
						}
						else
						{
			    			new ammande = vitesse*3;
			    			format(string, sizeof(string), "[Radar Fixe] Vous avez été flasher a %dKm/H et vous avez une ammande de %d$",vitesse,ammande);
				    		SendClientMessage(i,ORANGE,string);
							new nom[32];
			      	        GetPlayerName(i, nom, sizeof(nom));
			    			format(string, sizeof(string), "[Radar Fixe] %s c'est fait flasher",nom);
							ProxDetector(30.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
							GivePlayerMoney(i,-ammande);
						}
					}
				}
	        	if(model ==	481 || model == 509 || model == 510 || EsUnAvion(vehicleid))//Si c'est un velo on afiche pas l'essence
	        	{
				    if(TableauActive[i] == 1)
				    {
		        		format(string, sizeof(string), "~n~~n~~n~~n~~n~~n~~n~~n~~n~~g~Vehicule: ~w~%s ~n~~b~KM/H: ~w~%d~n~",VehiculeInfo[vehicleid][Nom],vitesse);
                        GameTextForPlayer(i,string,600,3);
					}
				}
				else
				{
				    if(TableauActive[i] == 1)
				    {
   						format(string, sizeof(string), "~n~~n~~n~~n~~n~~n~~n~~n~~g~Vehicule: ~w~%s ~n~~b~KM/H: ~w~%d~n~~r~Essence: ~w~%d/%d~n~",VehiculeInfo[vehicleid][Nom],vitesse,VehiculeInfo[vehicleid][Essence],VehiculeInfo[vehicleid][MaxEssence]);
                        GameTextForPlayer(i,string,600,3);
					}
					if(VehiculeInfo[vehicleid][Essence] > 0 )
					{
					    EssenceCount[vehicleid]++;
						if(EssenceCount[vehicleid] >= SECONDE_LITRE*2)
						{
							VehiculeInfo[vehicleid][Essence]--;
							EssenceCount[vehicleid] = 0;
						}
					}
				}
				if(VehiculeInfo[vehicleid][Essence] <= 0 && VehiculeInfo[vehicleid][Moteur] != 3 && !EsUnAvion(vehicleid))
				{
					format(string,sizeof(string),"Le reservoir de ce vehicule (%s) est vide!",VehiculeInfo[vehicleid][Nom]);
					SendClientMessage(i,COL_LIGHTRED,string);
					TogglePlayerControllable(i, 0);
					VehiculeInfo[vehicleid][Moteur] = 3;
				}
		    	new Float:vie;
                GetVehicleHealth(vehicleid, vie);
                if(vie <= 300 && VehiculeInfo[vehicleid][Moteur] != 3 && !EsUnAvion(vehicleid))
                {
		         	SetVehicleHealth(vehicleid, 500);
		     		format(string,sizeof(string),"Ce vehicule (%s) es en panne appelez un mécanicien!",VehiculeInfo[vehicleid][Nom]);
		     		SendClientMessage(i,COL_LIGHTRED,string);
		     		TogglePlayerControllable(i, 0);
	     			VehiculeInfo[vehicleid][Moteur] = 3;
	     		}
				PlayerPos[i][0] = x;
	            PlayerPos[i][1] = y;
	            PlayerPos[i][2] = z;
			}
			if(TableauActive[i] > 1)
			{
			    TableauActive[i]--;
			}
		}
	}
}
public Remplisage(playerid)
{
	new pompe = PompeEssence[playerid];
	if(PlayerToPoint2(4.0,playerid,Pompe[pompe][0],Pompe[pompe][1],Pompe[pompe][2]))
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		new string[128];
		VehiculeInfo[vehicleid][Essence]++;
		GivePlayerMoney(playerid, - PRIX_ESSENCE);
		if(VehiculeInfo[vehicleid][Essence] == VehiculeInfo[vehicleid][MaxEssence])
		{
		    PompeEssence[playerid] = 255;
		    KillTimer(TimerEssence[playerid]);
			format(string,sizeof(string),"Le reservoir de votre vehicule (%s) est plein. Passer une bonne journnée",VehiculeInfo[vehicleid][Nom]);
			SendClientMessage(playerid,COL_GREEN,string);
		}
	}
	else
	{
 		PompeEssence[playerid] = 255;
   		KillTimer(TimerEssence[playerid]);
		SendClientMessage(playerid,COL_LIGHTRED,"Vous avez quitter la pompe a essence durant le remplisage de votre vehicule!");
	}
}


public SauvegardeVeh()
{
	#if defined USE_MYSQL

	    new query[512];
		for(new v=1;v<NbVeh;v++)
		{
	        if(VehiculeInfo[v][VehID] != INVALID_VEH_ID)
	        {
		 		format(query, sizeof(query), "UPDATE %s SET Model=%d, XSpawn='%f', YSpawn='%f', ZSpawn='%f', ASpawn='%f', Couleur1=%d, Couleur2=%d, Prix=%d, Status=%d, Alarme=%d, Tuning1=%d, Tuning2=%d, Tuning3=%d, Tuning4=%d, Tuning5=%d, Tuning6=%d, Tuning7=%d, Tuning8=%d, Tuning9=%d, Tuning10=%d, Tuning11=%d, Tuning12=%d, Tuning13=%d, Tuning14=%d, Tuning15=%d, Tuning16=%d, Tuning17=%d, Peinture=%d, MaxEssence=%d, Proprio='%s', Nom='%s' WHERE VehID=%d LIMIT 1",
			 	 MYSQL_TB_VEH,VehiculeInfo[v][Model],VehiculeInfo[v][XSpawn],VehiculeInfo[v][YSpawn],VehiculeInfo[v][ZSpawn],
				 VehiculeInfo[v][ASpawn],VehiculeInfo[v][Couleur1],VehiculeInfo[v][Couleur2],VehiculeInfo[v][Prix],
				 VehiculeInfo[v][Status],VehiculeInfo[v][Alarme],VehiculeInfo[v][Tuning1],VehiculeInfo[v][Tuning2],
				 VehiculeInfo[v][Tuning3],VehiculeInfo[v][Tuning4],VehiculeInfo[v][Tuning5],VehiculeInfo[v][Tuning6],
				 VehiculeInfo[v][Tuning7],VehiculeInfo[v][Tuning8],VehiculeInfo[v][Tuning9],VehiculeInfo[v][Tuning10],
				 VehiculeInfo[v][Tuning11],VehiculeInfo[v][Tuning12],VehiculeInfo[v][Tuning13],VehiculeInfo[v][Tuning14],
				 VehiculeInfo[v][Tuning15],VehiculeInfo[v][Tuning16],VehiculeInfo[v][Tuning17],VehiculeInfo[v][Peinture],
				 VehiculeInfo[v][MaxEssence],VehiculeInfo[v][Proprio],VehiculeInfo[v][Nom],VehiculeInfo[v][VehID]
	 			);
				samp_mysql_query(query);
				printf("---- Vehicule %d sauvegarder! ----",v);
			}
		}

	#else

 		new File:VehFile = fopen(VEH_FILENAME, io_write);
		new vehstring[256];
		for(new v=1;v<NbVeh;v++)
		{
		    if(VehiculeInfo[v][VehID] != INVALID_VEH_ID)
		    {
				format(vehstring, sizeof(vehstring), "%d|%d|%f|%f|%f|%f|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%s|%s\r\n",
				 VehiculeInfo[v][VehID],VehiculeInfo[v][Model],VehiculeInfo[v][XSpawn],VehiculeInfo[v][YSpawn],VehiculeInfo[v][ZSpawn],
				 VehiculeInfo[v][ASpawn],VehiculeInfo[v][Couleur1],VehiculeInfo[v][Couleur2],VehiculeInfo[v][Prix],
				 VehiculeInfo[v][Status],VehiculeInfo[v][Alarme],VehiculeInfo[v][Tuning1],VehiculeInfo[v][Tuning2],
				 VehiculeInfo[v][Tuning3],VehiculeInfo[v][Tuning4],VehiculeInfo[v][Tuning5],VehiculeInfo[v][Tuning6],
				 VehiculeInfo[v][Tuning7],VehiculeInfo[v][Tuning8],VehiculeInfo[v][Tuning9],VehiculeInfo[v][Tuning10],
				 VehiculeInfo[v][Tuning11],VehiculeInfo[v][Tuning12],VehiculeInfo[v][Tuning13],VehiculeInfo[v][Tuning14],
				 VehiculeInfo[v][Tuning15],VehiculeInfo[v][Tuning16],VehiculeInfo[v][Tuning17],VehiculeInfo[v][Peinture],
				 VehiculeInfo[v][MaxEssence],VehiculeInfo[v][Proprio],VehiculeInfo[v][Nom]
				);
				fwrite(VehFile, vehstring);
				  
				printf("---- Vehicule %d sauvegarder! ----",v);
			}
		}
		fclose(VehFile);

	#endif
}
public DestroyVeh(vehicleid)
{
	return DestroyVehicle(vehicleid);
}
public CreateVeh(vehicleid,Float:x,Float:y,Float:z,Float:a)
{
	vehicleid = CreateVehicle(VehiculeInfo[vehicleid][Model],x,y,z,a,VehiculeInfo[vehicleid][Couleur1],VehiculeInfo[vehicleid][Couleur2],RESPAWN_DELAY);
}
public RestartVeh(vehicleid)
{
	DestroyVehicle(vehicleid);
	CreateVehicle(VehiculeInfo[vehicleid][Model],VehiculeInfo[vehicleid][XSpawn],VehiculeInfo[vehicleid][YSpawn],VehiculeInfo[vehicleid][ZSpawn],VehiculeInfo[vehicleid][ASpawn],VehiculeInfo[vehicleid][Couleur1],VehiculeInfo[vehicleid][Couleur2],RESPAWN_DELAY);
	VehiculeInfo[vehicleid][Essence] = VehiculeInfo[vehicleid][MaxEssence];
	TuningVehicule(vehicleid);
}
#if defined USE_CALLCAR
public CallCar(playerid,vehicleid)
{
	if(IsPlayerConnected(playerid))
	{
		new Float:x,Float:y,Float:z,Float:a,string[128];
	    GetPlayerPos(playerid, x,y,z);
	    GetPlayerFacingAngle(playerid,a);
     	GetXYFront(x,y,a, 4.0);
		CreateVehicle(VehiculeInfo[vehicleid][Model],x,y,z,a-90,VehiculeInfo[vehicleid][Couleur1],VehiculeInfo[vehicleid][Couleur2],RESPAWN_DELAY);
		TuningVehicule(vehicleid);
		format(string,sizeof(string),"Votre vehicule (%s) a bien été teleporter jusqua vous!",VehiculeInfo[vehicleid][Nom]);
		SendClientMessage(playerid,COL_GREEN,string);
	}
}
#endif

// autre fonction
static split2(const strsrc[], strdest[][], delimiter)
{
	new i, li,aNum,len;
	while(i <= strlen(strsrc))
	{
	    if(strsrc[i]==delimiter || i==strlen(strsrc))
		{
	        len = strmid(strdest[aNum], strsrc, li, i, 128);
	        strdest[aNum][len] = 0;
	        li = i+1;
	        aNum++;
		}
		i++;
	}
	return aNum;
}

static strtok2(const string[], &index,seperator=' ')
{
	new length = strlen(string);
	new offset = index;
	new result[128];
	while ((index < length) && (string[index] != seperator) && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}

	result[index - offset] = EOS;
	if ((index < length) && (string[index] == seperator))
	{
		index++;
	}
	return result;
}
static PlayerToPoint2(Float:radi, playerid, Float:x, Float:y, Float:z)
{
    if(IsPlayerConnected(playerid))
	{
	    new Float:pos[3];
	    new Float:tmppos[3];
		GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
		tmppos[0] = (pos[0] - x);
		tmppos[1] = (pos[1] - y);
		tmppos[2] = (pos[2] - z);
		if (((tmppos[0] < radi) && (tmppos[0] > -radi)) && ((tmppos[1] < radi) && (tmppos[1] > -radi)) && ((tmppos[2] < radi) && (tmppos[2] > -radi)))
		{
			return 1;
		}
	}
	return 0;
}
static IsNumeric2(const string[])
{
	for (new i = 0, j = strlen(string); i < j; i++)
	{
		if (string[i] > '9' || string[i] < '0') return 0;
	}
	return 1;
}
public Demmarage(playerid)
{
    if(IsPlayerConnected(playerid))
    {
        if(IsPlayerInAnyVehicle(playerid))
        {
            new RandomStart;
    		new string[256];
    		new sendername[MAX_PLAYER_NAME];
            RandomStart = random(4);
			new car = GetPlayerVehicleID(playerid);
            switch(RandomStart)
            {
                case 0,1,2:
                {
                    VehiculeInfo[car][Moteur] = 1;
                    TogglePlayerControllable(playerid, true);
                    GetPlayerName(playerid, sendername, sizeof(sendername));
                 	if(PlayerInfo[playerid][pMaskuse] == 1)
	            	{
    					ProxDetector(30.0, playerid,  "* Le véhicule démarre(( Etranger ))", COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	            	}
	            	else
	            	{
                        format(string, sizeof(string), "* Le véhicule démarre (( %s )).", sendername);
                        ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
       	        		TogglePlayerControllable(playerid, 1);
			        }
					
                }
                case 3:
                {
                    GetPlayerName(playerid, sendername, sizeof(sendername));
					VehiculeInfo[car][Moteur] = 0;
                 	if(PlayerInfo[playerid][pMaskuse] == 1)
	            	{
    					ProxDetector(30.0, playerid,  "* Le véhicule cale (( Etranger ))", COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	            	}
	            	else
	            	{
                        format(string, sizeof(string), "* Le véhicule cale (( %s )).", sendername);
			    		ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			        }
       		    	TogglePlayerControllable(playerid, 0);
                }
            }
        }
    }
    return 1;
}
ReturnModelByName(const text[])
{
	if (IsNumeric2(text))
	{
		if (strval(text) >= 400 && strval(text) <= 611)
		{
			return strval(text);
		}
		return 0;
	}
	new len = strlen(text);
	for (new m=0;m<sizeof(VehicleName);m++)
	{
		if (strcmp(VehicleName[m], text, true, len) == 0)
		{
			return m+400;
		}
	}
	return 0;
}
GetXYFront(&Float:x, &Float:y, Float:a, Float:distance)
{
	x += (distance * floatsin(-a, degrees));
	y += (distance * floatcos(-a, degrees));
}
#if defined USE_MYSQL
samp_mysql_table_exist(const table[])
{
	new query[64];
	format(query,sizeof(query),"SHOW TABLES FROM %s LIKE '%s'",MYSQL_DB_SERVEUR,table);
	samp_mysql_query(query);
	samp_mysql_store_result();
	if (samp_mysql_num_rows()==0)
	{
	    samp_mysql_free_result();
		return 0;
	}
	samp_mysql_free_result();
	return 1;
}
#endif
