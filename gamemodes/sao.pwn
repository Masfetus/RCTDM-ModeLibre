//----------------------------------------------------------
//
//  SAN ANDREAS ONLINE BY ADRIENSPY & [EXO]JHONNY
//
//----------------------------------------------------------

//INCLUDES
#include <a_samp>
#include <Gamemode\fixes>
#include <Download/mapandreas>
#include <a_players>
#include <a_angles>
#include <Gamemode/gl_common>
#include <Download\YSI\y_ini>
#include <Download\streamer>
#include <Download/actors>
#include <Download/FCNPC>
#include <Download\YSI\y_commands>
#include <Download/sscanf2>

#define GMV "0.92"

#define PATH "/Users/%s.ini"
#define HPATH "/Serveur/Maisons/%d.ini"
#define CPATH "/Serveur/Commerces/%d.ini"
#define SPATH "/Serveur/servinfos.ini"
#define BPATH "/Serveur/Propriétés/%d.ini"
#define PathSanctions "/Serveur/sanctions.txt"
#define RACEPATH "/Races/%d.ini"
#define MAXCONTACT 20
#define MAX_COMMERCES 15
#define MAXRESTOS 12
#define MAX_AMMU 7
#define MAX_BAR 2
#define MAX_HOUSES 48
#define MAX_BIZ 30
#define NBATM 3
#define TOTAL_AMMU 13
#define AMMUWEAP 296.5000000,-37.2000000,1001.5999800,0.0000000,0.0000000,360.0000000
#define CABINES 8
#define MAXLEVEL 6
#define XMAX 300.04
#define XMIN 285.42
#define YMAX -5.5
#define YMIN -18.19
#define TOTAL_VEHICLES 76
#define TOTAL_ITEMS         289
#define SELECTION_ITEMS 	21
#define ITEMS_PER_LINE  	7
#define HEADER_TEXT "Magasin de Skins (200$/skin)"
#define NEXT_TEXT   "Suiv."
#define PREV_TEXT   "Prec."
#define DIALOG_BASE_X   	75.0
#define DIALOG_BASE_Y   	130.0
#define DIALOG_WIDTH    	550.0
#define DIALOG_HEIGHT   	180.0
#define SPRITE_DIM_X    	60.0
#define SPRITE_DIM_Y    	70.0
#define STAR_KILLPLAYER 1
#define STAR_KILLACTOR 1
#define STAR_ROBHOUSE 1
#define STAR_ROBCOMMERCE 2
#define STAR_ROBBANK 3
#define STAR_KILLCOP 4
#define STAR_KILLALLCOPS 5
#define AMMU_STAND 286.27,-30.66,1001.51
#define STAD_ENTER -2110.80,-444.51,38.73
#define INT 15
#define STAD_EXIT -1398.103515,937.631164,1036.479125
#define COM_POSENTER -1605.04,711.23,13.86
#define COM_POSEXIT 246.38,108.41,1003.21
#define COM_DUTY 246.43,121.87,1003.22
#define ALCITY -1422.5546,-288.4269,14.1484
#define POSMISSION1 -1982.54,132.25,27.68
#define POSDOHERTY -2027.56,-41.61,38.80
#define POSMISSION2 -2224.5,330,35
#define POSINTERIOR -2168, 642, 1057
#define POSCAISSES -1706.17,24.81,3
#define POSMISSION3 -2218.5,329,35
#define ENTREPOT   -2163,-227,36
#define POSMISSION8 404.0, 2537.8, 16.5
#define PURSUIT -2446,-84,34.22
#define MAX_SKYDIVE 2
#define PICKCENTER 19197
#define BANKENTER -2454.49,503.70,30.07
#define BANKEXIT 1667.21,-994.24,683.69
#define BANKINFO 1667.53,-974.17,683.68
#define HOTELENTER -2163.0,129.5, 35.0
#define HOTELEXIT 2214.91,-1150.54,1025.79
#define VENDING_MACHINE_RANGE		2.0
#define ADMIN_SPEC_TYPE_NONE 0
#define ADMIN_SPEC_TYPE_PLAYER 1
#define ADMIN_SPEC_TYPE_VEHICLE 2
#define TAXE 0.06
#define SpeedCheck(%0,%1,%2,%3,%4) floatround(floatsqroot(%4?(%0*%0+%1*%1+%2*%2):(%0*%0+%1*%1)) *%3*1.6)
#define DIALOG_REGISTER 1
#define DIALOG_LOGIN 2
#define DIALOG_SUCCESS_1 3
#define DIALOG_SUCCESS_2 4
#define DLG_WHITE "{FFFFFF}"
#define DLG_RED "{F81414}"
#define DLG_GREEN "{00FF22}"
#define DLG_LIGHTBLUE "{00CED1}"
#define DLG_BLUE "{0080C0}"
#define MSG_YELLOW 1
#define MSG_BLUE 2
#define MSG_RED 3
#define GREY 0xAFAFAFAA
#define RED 0xAA3333AA
#define YELLOW 0xFFFF00AA
#define PINK 0xFF66FFAA
#define BLUE 0x0080C0FF
#define WHITE 0xFFFFFFAA
#define LIGHTBLUE 0x33CCFFAA
#define DARKRED 0x660000AA
#define ORANGE 0xFF9900AA
#define BRIGHTRED 0xFF0000AA
#define INDIGO 0x4B00B0AA
#define VIOLET 0x9955DEEE
#define LIGHTRED 0xFF99AADD
#define SEAGREEN 0x00EEADDF
#define GRAYWHITE 0xEEEEFFC4
#define LIGHTNEUTRALBLUE 0xabcdef66
#define GREENISHGOLD 0xCCFFDD56
#define LIGHTBLUEGREEN 0x0FFDD349
#define NEUTRALBLUE 0xABCDEF01
#define LIGHTCYAN 0xAAFFCC33
#define LEMON 0xDDDD2357
#define MEDIUMBLUE 0x63AFF00A
#define NEUTRAL 0xABCDEF97
#define BLACK 0x00000000
#define NEUTRALGREEN 0x81CFAB00
#define GREEN 0x33AA33AA
#define DARKGREEN 0x12900BBF
#define LIGHTGREEN 0x24FF0AB9
#define DARKBLUE 0x300FFAAB
#define BLUEGREEN 0x46BBAA00
#define PINK 0xFF66FFAA
#define DARKRED 0x660000AA
#define ORANGE 0xFF9900AA
#define PURPLE 0x800080AA
#define RED1 0xFF0000AA
#define BROWN 0x993300AA
#define CYAN 0x99FFFFAA
#define TAN 0xFFFFCCAA
#define PINK 0xFF66FFAA
#define KHAKI 0x999900AA
#define LIME 0x99FF00AA
#define SYSTEM 0xEFEFF7AA
#define GRAD1 0xB4B5B7FF
#define GRAD2 0xBFC0C2FF
#define GRAD4 0xD8D8D8FF
#define GRAD6 0xF0F0F0FF
#define GRAD2 0xBFC0C2FF
#define GRAD3 0xCBCCCEFF
#define GRAD5 0xE3E3E3FF
#define GRAD1 0xB4B5B7FF
#define MAX_RESTOS 3
#define BURGER 0
#define PIZZA 1
#define CLUCKIN 2
#define MAX_SLOTS 8

main()
{
	print("--------------------------------\n");
	print("San Andreas Online "GMV"\n");
	print("by adrienspy & [Exo]Jhonny\n");
	print("--------------------------------\n");
}

enum pInfo
{
    pPass,
    pCash,
	pNum,
	pContacts,
	bool:pTuto,
	pMaison,
	pBanque,
	bool:pCarte,
	pSkin,
	p9mm,
	pS9mm,
	pEagle,
	pShotgun,
	pSawnoff,
	pCShotgun,
	pUzi,
	pMp5,
	pAk47,
	pM4,
	pTec9,
	pRifle,
	pSniper,
	pLoyer,
	pLevel,
	bool:pBan,
	pBiz,
	pEtoiles
}
enum hInfo
{
	Float:X1,
	Float:Y1,
	Float:Z1,
	Float:eX,
	Float:eY,
	Float:eZ,
	Float:cX,
	Float:cY,
	Float:cZ,
	Type,
	Interior,
	Prix,
	Lock
}
enum bInfo
{
	Float:X,
	Float:Y,
	Float:Z,
	Caisse,
	CaisseMax,
	Prix,
	Revenus,
	Proprio[MAX_PLAYER_NAME],
	Type
}
enum rInfo
{
	Float:X1,
	Float:Y1,
	Float:Z1,
	Float:eX,
	Float:eY,
	Float:eZ,
	Type,
	Interieur
}
enum vInfo
{
	Model,
	Float:X,
	Float:Y,
	Float:Z,
	Float:A,
	Color1,
	Color2,
	PaintJob
}
enum nInfo
{
	Skin,
	Interior,
	VirtualWorld,
	Weap,
	bool:Invulnerable,
	FollowID,
	FocusID,
	Float:AimDist,
	Float:Accuracy,
	Float:Health,
	NpcID
}
enum wInfo
{
	Model,
	Ammo,
	Light
}
enum RaceInfo
{
	Float:Ang,
	RaceName[256],
	Model,
	CPMax
};

stock const Float:VENDING_MACHINES[][3] = {
	{-14.70, 1175.36, 18.95}, 		{201.02, -107.62, 0.90},
	{662.43, -552.16, 15.71}, 		{-76.03, 1227.99, 19.13},
	{1154.73, -1460.89, 15.16}, 	{1277.84, 372.52, 18.95},
	{1398.84, 2222.61, 10.42}, 		{1520.15, 1055.27, 10.00},
	{1634.11, -2237.53, 12.89}, 	{1659.46, 1722.86, 10.22},
	{1729.79, -1943.05, 12.95}, 	{1789.21, -1369.27, 15.16},
	{1928.73, -1772.45, 12.95}, 	{2060.12, -1897.64, 12.93},
	{2085.77, 2071.36, 10.45}, 		{2139.52, -1161.48, 23.36},
	{2153.23, -1016.15, 62.23}, 	{2271.73, -76.46, 25.96},
	{2319.99, 2532.85, 10.22}, 		{2325.98, -1645.13, 14.21},
	{2352.18, -1357.16, 23.77}, 	{2480.86, -1959.27, 12.96},
	{2503.14, 1243.70, 10.22}, 		{-253.74, 2597.95, 62.24},
	{-253.74, 2599.76, 62.24}, 		{2647.70, 1129.66, 10.22},
	{2845.73, 1295.05, 10.79}, 		{-862.83, 1536.61, 21.98},
	{-1350.12, 492.29, 10.59}, 		{-1350.12, 493.86, 10.59},
	{-1455.12, 2591.66, 55.23}, 	{-1980.79, 142.66, 27.07},
	{-2005.65, -490.05, 34.73}, 	{-2011.14, -398.34, 34.73},
	{-2034.46, -490.05, 34.73}, 	{-2039.85, -398.34, 34.73},
	{-2063.27, -490.05, 34.73}, 	{-2068.56, -398.34, 34.73},
	{-2092.09, -490.05, 34.73}, 	{-2097.27, -398.34, 34.73},
	{-2118.62, -422.41, 34.73}, 	{-2118.97, -423.65, 34.73},
	{-2229.19, 286.41, 34.70}, 		{-2420.18, 985.95, 44.30},
	{-2420.22, 984.58, 44.30}, 		{2155.84, 1607.88, 1000.06},
	{2155.91, 1606.77, 1000.05}, 	{2202.45, 1617.01, 1000.06},
	{2209.24, 1621.21, 1000.06}, 	{2209.91, 1607.20, 1000.05},
	{2222.20, 1606.77, 1000.05}, 	{2222.37, 1602.64, 1000.06},
	{2225.20, -1153.42, 1025.91}, 	{-15.10, -140.23, 1003.63},
	{-16.12, -91.64, 1003.63}, 		{-16.53, -140.30, 1003.63},
	{-17.55, -91.71, 1003.63}, 		{-19.04, -57.84, 1003.63},
	{-32.45, -186.70, 1003.63},		{-33.88, -186.77, 1003.63},
	{330.68, 178.50, 1020.07}, 		{331.92, 178.50, 1020.07},
	{-35.73, -140.23, 1003.63}, 	{350.91, 206.09, 1008.48},
	{-36.15, -57.88, 1003.63}, 		{361.56, 158.62, 1008.48},
	{371.59, 178.45, 1020.07}, 		{373.83, -178.14, 1000.73},
	{374.89, 188.98, 1008.48}, 		{379.04, -178.88, 1000.73},
	{495.97, -24.32, 1000.73}, 		{500.56, -1.37, 1000.73},
	{501.83, -1.43, 1000.73}, 		{2576.70, -1284.43, 1061.09}
};

new Float:PosCabine[CABINES][3] = {
{289.18,-25.13,1001.51},
{290.82,-25.13,1001.51},
{292.16,-25.13,1001.51},
{293.64,-25.13,1001.51},
{295.24,-25.13,1001.51},
{296.82,-25.13,1001.51},
{298.15,-25.13,1001.51},
{299.74,-25.13,1001.51}
};
new Float:PosPickup[MAX_SLOTS][3] = {
{1661.9182,-975.3804,701.0894},
{923.0,-1064.0,24.0},
{1779.0, -1940.0, 13.0},
{-1666.66, 435.93, 7.0},
{-2242.0, 128.7, 35.0},
{1300.0,-800.0,84.0},
{388.0, -1826.0,-14.7},
{-874.5, 557.0, 1341.0}
};
new Float:PosBar[MAX_BAR][3] = {
	{-2551.0,194.0,6.0},
	{-2214.0,721.0,49.5}
};
new Float:PosAtm[NBATM][6] = {
{ -1980.77222, 144.34845, 26.68100,0.0,0.0,-90.0},
{-1911.19299, 823.39557, 34.16320,0.0,0.0,90.0},
{-1806.08618, 950.69489, 23.85220,0.0,0.0,90.0}
};
new Float:PosRestos[MAXRESTOS][3] = {
{-1805.7,943.2,24.8},
{-1719.1,1359.4,8.6},
{-2356.0,1009.0,49.0},
{-1913.3,826.2,36.9},
{-2335.6,-165.6,39.5},
{-2671.6,257.4,4.6},
{-1816.2,620.8,37.5},
{2330.2,75.2,31.0},
{203.2,-200.4,6.5},
{-2154.0,-2461.2,30.8},
{172.73,1176.76,13.7},
{-1216.0,1831.4,45.3}
};
new Float:PosAmmu[MAX_AMMU][3] = {
{-2626.6,209.4,4.9},
{-2092.7,-2463.8,30.6},
{779.7,1874.3,4.9},
{240.0,-178.2,2.0},
{-315.67,829.87,13.43},
{-1509.4,2611.8,58.5},
{2332.9,63.6,31.0}
};
new Float:CpBraq[MAX_RESTOS][3] = {
{372.56,-65.66,1001.51},
{379.45,-119.59,1001.49},
{372.11,-6.65,1001.85}
};
new Float:SkyDiveCP[MAX_SKYDIVE][3] = {
{-2084.95,220.36,41.17},
{-1336.3632,494.0419,49.3231}
};
new Float:SkyDiveAir[MAX_SKYDIVE][3] = {
{-2070.0,355.0,175.0},
{-1791.1991,567.9830,332.8019}
};
new Float:SkyDiveSol[MAX_SKYDIVE][3] = {
{-2055.0, 355.0,35.0},
{-1810.3242,576.3303,35.1668}
};
new Float:PlayerVehHP[MAX_PLAYERS];
new Float:Angle;
new Float:PosRace[800][3];
new ModelPickup[MAX_SLOTS] = {
	1210,
	19344,
	19344,
	19344,
	19344,
	19344,
	19344,
	19344,
};
new gItemList[TOTAL_ITEMS] = {
1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,
50,51,52,53,54,55,56,57,58,59,60,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,
97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,
132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,
167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,
202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,
237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,268,269,270,271,
272,273,275,276,277,278,279,287,289,290,291,292,293,294,295,296,297,298,299,303,304,305
};
new RandomPed[128] = {
7,9,10,12,13,14,15,17,18,19,20,21,22,23,24,25,29,30,36,37,38,39,40,41,43,44,45,46,47,48,51,52,53,54,55,56,57,58,59,60,66,67,69,72,73,76,78,79,
88,89,90,91,92,93,94,95,96,97,98,99,100,134,135,136,137,138,139,140,141,142,143,147,147,150,154,169,170,179,180,181,182,183,184,185,186,187,188,
210,212,213,215,216,218,219,220,221,222,223,224,225,226,227,28,229,230,231,232,233,234,235,235,239,234,241,242,247,248,250,251,254,258,259,261,
262,263,303,304,305
};
new RandomCPed[26] = {
26,31,32,33,34,35,128,129,130,131,133,151,157,158,159,160,161,162,196,197,198,199,200,201,202,206
};
new RandomWorker[10] = {
8,11,16,27,50,153,171,172,189,260
};
new RandomGang[17] = {
49,121,122,123, //DA NANG BOYS
111,112,113,124,126,127,272, //MAFIA
117,118,120, //TRIADS
173,175,175 //SAN FIERRO RIFA
};
new ItemVeh[TOTAL_VEHICLES] = {
600,554,422,489,579,533,587,602,412,517,474,419,491,475,436,527,526,410,401,496,558,576,549,542,439,518,575,
535,534,536,567,565,589,404,479,458,561,418,482,466,585,516,551,445,426,507,566,492,467,405,547,546,540,529,550,
421,580,555,477,559,562,480,429,560,603,541,415,451,411,581,461,521,522,468,463,471
};

new ItemVPrice[TOTAL_VEHICLES] = {
20000,25000,22500,30000,35000,27500,27500,25000,25000,25000,20000,25000,20000,32500,22500,25000,22500,22500,22500,27500,30000,27500,12500,
10000,20000,22500,22500,27500,27500,30000,25000,50000,25000,17500,27500,20000,20000,20000,20000,22500,20000,22500,32500,40000,37500,37500,40000,
40000,30000,37500,27500,27500,22500,25000,35000,27500,22500,50000,90000,110000,115000,150000,165000,175000,175000,180000,185000,200000,
250000,20000,40000,60000,75000,40000,35000,45000
};
new VehicleNames[][] =
{
    "Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel", "Dumper", "Firetruck",
	"Trashmaster", "Stretch", "Manana", "Infernus", "Voodoo", "Pony", "Mule", "Cheetah",
    "Ambulance", "Leviathan", "Moonbeam", "Esperanto", "Taxi", "Washington", "Bobcat", "Mr Whoopee",
    "BF Injection", "Hunter", "Premier", "Enforcer", "Securicar", "Banshee", "Predator", "Bus",
    "Rhino", "Barracks", "Hotknife", "Article Trailer", "Previon", "Coach", "Cabbie", "Stallion",
    "Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral", "Squallo", "Seasparrow",
    "Pizzaboy", "Tram", "Article Trailer 2", "Turismo", "Speeder", "Reefer", "Tropic", "Flatbed",
    "Yankee", "Caddy", "Solair", "Berkley's RC Van", "Skimmer", "PCJ-600", "Faggio", "Freeway",
    "RC Baron", "RC Raider", "Glendale", "Oceanic", "Sanchez", "Sparrow", "Patriot", "Quad",
    "Coastguard", "Dinghy", "Hermes", "Sabre", "Rustler", "ZR-350", "Walton", "Regina",
    "Comet", "BMX", "Burrito", "Camper", "Marquis", "Baggage", "Dozer", "Maverick",
    "SAN News Maverick", "Rancher", "FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring Racer", "Sandking",
    "Blista Compact", "Police Maverick", "Boxville", "Banson", "Mesa", "RC Goblin", "Hotring Racer", "Hotring Racer",
    "Bloodring Banger", "Rancher", "Super GT", "Elegant", "Journey", "Bike", "Mountain-Bike", "Beagle",
    "Cropduster", "Stuntplane", "Tanker", "Roadtrain", "Nebula", "Majestic", "Buccaneer", "Shamal",
    "Hydra", "FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Towtruck", "Fortune", "Cadrona",
    "FBI Truck", "Willard", "Forklift", "Tractor", "Combine Harvester", "Feltzer", "Remington", "Slamvan",
    "Blade", "Freight (Train)", "Brownstreak (Train)", "Vortex", "Vincent", "Bullet", "Clover", "Sadler",
    "Firetruck LA", "Hustler", "Intruder", "Primo", "Cargobob", "Tampa", "Sunrise", "Merit",
    "Utility Van", "Nevada", "Yosemite", "Windsor", "Monster A", "Monster B", "Uranus", "Jester",
    "Sultan", "Stratum", "Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma", "Savanna",
    "Bandito", "Freight Flat Trailer", "Brownstreak Trailer", "Kart", "Mower", "Dune", "Sweeper", "Broadway",
    "Tornado", "AT400", "DFT-30", "Huntley", "Stafford", "BF-400", "Newsvan", "Tug",
    "Petrol Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club", "Freight Box Trailer", "Article Trailer 3",
    "Andromada", "Dodo", "RC Cam", "Launch", "Police Cruiser (LSPD)", "Police Cruiser (SFPD)", "Police Cruiser (LVPD)", "Police Ranger",
    "Picador", "S.W.A.T", "Alpha", "Phoenix", "Glendale Shit", "Sadler Shit", "Baggage Trailer A", "Baggage Trailer B",
    "Tug Stairs Trailer", "Boxville", "Farm Trailer", "Utility Trailer"
};
new ItemAmmu[TOTAL_AMMU] =
{
346,347,348,349,350,351,352,353,355,356,372,357,358
};
new ItemWeapon[TOTAL_AMMU] =
{
22,23,24,25,26,27,28,29,30,31,32,33,34
};
new ItemPrice[TOTAL_AMMU] =
{
200,300,500,400,750,1000,400,450,600,700,375,700,1000
};
new bool:skydiving[MAX_PLAYERS] = false;
new bool:gps[MAX_PLAYERS];
new bool:sdrive[MAX_PLAYERS];
new bool:CabineOccuped[CABINES];
new bool:AlreadyDone[MAX_PLAYERS][50];
new bool:PressN[MAX_PLAYERS];
new bool:InAmmu[MAX_PLAYERS];
new bool:ClubTBoGT[MAX_PLAYERS];
new bool:vcmds[MAX_PLAYERS];
new bool: magicgun[MAX_PLAYERS];
new bool:vPosseded[MAX_VEHICLES];
new bool:CDFRace;
new bool:BuildingRace[MAX_PLAYERS];
new bool:RaceLoaded;
new bool:concessbusy;
new bool:PickupTaken[MAX_PLAYERS][MAX_SLOTS];
new bool:muted[MAX_PLAYERS];
new bool:nextrob[MAX_PLAYERS] = true;
new bool:jailed[MAX_PLAYERS];
new bool:isgarageopen = false;
new bool:InRace[MAX_PLAYERS];
new bool: MenuREditor[MAX_PLAYERS];
new bool:MenuNPC[MAX_PLAYERS];
new bool:respawnhospital[MAX_PLAYERS];
new bool:Phone[MAX_PLAYERS]=false;
new bool:robbing[MAX_PLAYERS];
new bool:IsRaceLoaded;
new bool:jbraquage[MAX_PLAYERS];
new bool:braquage;
new bool:IsLogged[MAX_PLAYERS];
new bool:havebox[MAX_PLAYERS];
new Text:VehicleName[MAX_PLAYERS], Text:VehicleSpeed[MAX_PLAYERS], Text:Title, Text:Underline, Text:KMH;
new PlayerText:TD_Fade[MAX_PLAYERS][2];
new PlayerText: TD_Dialog[MAX_PLAYERS];
new PlayerText:TD_Obj[MAX_PLAYERS];
new PlayerText:TD_Phone[MAX_PLAYERS][13];
new PlayerText:TD_Appel[MAX_PLAYERS][5];
new PlayerText:TD_Comm[MAX_PLAYERS][2];
new PlayerText:gCurrentPageTextDrawId[MAX_PLAYERS];
new PlayerText:gHeaderTextDrawId[MAX_PLAYERS];
new PlayerText:gBackgroundTextDrawId[MAX_PLAYERS];
new PlayerText:gNextButtonTextDrawId[MAX_PLAYERS];
new PlayerText:gPrevButtonTextDrawId[MAX_PLAYERS];
new PlayerText:gSelectionItems[MAX_PLAYERS][SELECTION_ITEMS];
new PlayerText:TDMsg_Sub[MAX_PLAYERS][3];
new PlayerText:TDMenu_NPC[MAX_PLAYERS][13];
new PlayerText:TDRace_Editor[MAX_PLAYERS][9];
new WeaponObject[MAX_OBJECTS][wInfo];
new NPCInfo[MAX_PLAYERS][nInfo];
new VehicleInfo[MAX_PLAYERS][vInfo];
new PlayerInfo[MAX_PLAYERS][pInfo];
new HouseInfo[MAX_HOUSES][hInfo];
new BizInfo[MAX_BIZ][bInfo];
new CommerceInfo[MAX_COMMERCES][rInfo];
new timercd;
new timedown;
new treboot;
new trob[MAX_PLAYERS];
new tbraquage;
new htimer[MAX_PLAYERS];
new subtimer[MAX_PLAYERS][3];
new mutetimer[MAX_PLAYERS];
new jailtimer[MAX_PLAYERS];
new timerob[MAX_PLAYERS] = -1;
new robhtimer[MAX_PLAYERS];
new ctimer[MAX_PLAYERS];
new ftimer[MAX_PLAYERS];
new timedialog[MAX_PLAYERS];
new counter = 0;
new countdia[MAX_PLAYERS];
new hour, minute;
new cabine[MAX_PLAYERS];
new ammulvl[MAX_PLAYERS];
new atarget[MAX_PLAYERS];
new oldint[MAX_PLAYERS];
new bproprio[MAX_BIZ][MAX_PLAYER_NAME]; // BIZ OWNER
new proprio[MAX_HOUSES][MAX_PLAYER_NAME];
new DRVGarage;
new STREAMER_TAG_OBJECT maskplayer[7];
new housefocus[MAX_PLAYERS]; // ID OF HOUSE FOCUSED
new PickupMoney[MAX_PICKUPS];
new pickup[MAX_PLAYERS][MAX_SLOTS];
new BizPickup[MAX_BIZ];
new housepickup[MAX_HOUSES][2];
new commpickup[MAX_COMMERCES][2];
new motelpickup[2];
new bankpickup[3];
new weappickup[2];
new VehicleTuning[MAX_PLAYERS][14];
new cvehicle[MAX_PLAYERS];
new jvehicle[MAX_PLAYERS];
new vhealth[MAX_VEHICLES];
new aveh[MAX_PLAYERS] = -1;
new NameRace[256];
new CpRace;
new typecar;
new Edit[MAX_PLAYERS];
new racetotal;
new racepos;
new RacePlayer[MAX_PLAYERS][RaceInfo];
new cpplayer[MAX_PLAYERS];
new racebuilding[MAX_PLAYERS];
new NumCPBuilding[MAX_PLAYERS];
new Races;
new NameContact[MAX_PLAYERS][MAXCONTACT][MAX_PLAYER_NAME];
new NumContact[MAX_PLAYERS][MAXCONTACT];
new namesave[MAX_PLAYERS][MAX_PLAYER_NAME];
new cname[MAX_PLAYERS][MAX_PLAYER_NAME];
new InCall[MAX_PLAYERS];
new IsDead[MAX_PLAYERS];
new Talking[MAX_PLAYERS];
new TalkingID[MAX_PLAYERS];
new IsCalling[MAX_PLAYERS];
new EndTimer[MAX_PLAYERS];
new SmsId[MAX_PLAYERS];
new selectid[MAX_PLAYERS];
new LastIp[MAX_PLAYERS][32];
new gSpectateID[MAX_PLAYERS];
new gSpectateType[MAX_PLAYERS];
new aclickedid[MAX_PLAYERS];
new sanctiontype[MAX_PLAYERS];
new stepchangepassword[MAX_PLAYERS];
new deftype[MAX_PLAYERS];
new achat[MAX_PLAYERS];
new SelectItem[MAX_PLAYERS] = 0;
new page[MAX_PLAYERS];
new gTotalItems = TOTAL_ITEMS;
new gSelectionItemsTag[MAX_PLAYERS][SELECTION_ITEMS];
new gItemAt[MAX_PLAYERS];
new ArmeSelect[MAX_PLAYERS];
new request[MAX_PLAYERS];
new npcname[MAX_PLAYERS][MAX_PLAYER_NAME];
new braqueur[2]; // ROBBER'S ID
new role[MAX_PLAYERS]; // IF THE PLAYER IS TARGETTING THE ACTOR OR ROBBING THE MONEY IN SAFEROOM
new MoneyBanque; // MONEY AMOUNT BANK'S
new MoneyResto[MAX_RESTOS]; // AMOUNT RESTAURANT
new cprob[MAX_PLAYERS]; // ID CHECKPOINT PLAYER
new cbraquage[MAX_PLAYERS] = -1; // TYPE OF ROBBERY
new actlib[MAX_ACTORS][32];
new actname[MAX_ACTORS][32];
new bactor; // BANK ACTOR
new ServActor;
new resetactoranim[MAX_ACTORS];
new coveractor[MAX_ACTORS];
new actortest[MAX_PLAYERS]; // ACTER TEST OF PLAYER
new vcop;
new mission[MAX_PLAYERS];
new vmission[MAX_PLAYERS];
new vennemy[MAX_PLAYERS];
new cobject[MAX_PLAYERS];
new caisses[MAX_PLAYERS];
new mafkilled[MAX_PLAYERS]; // NUMBER OF MAFIAS KILLED
new FL[MAX_PLAYERS];
new MC[MAX_PLAYERS];
new AM[MAX_PLAYERS];
new VH[MAX_PLAYERS];
new maf[MAX_PLAYERS][6];
new bcop[MAX_PLAYERS][4];
new AME[MAX_PLAYERS];
new AMG[MAX_PLAYERS];
new RE[MAX_PLAYERS][4];
new PE[MAX_PLAYERS];
new PG[MAX_PLAYERS];
new MatthewHR_Dialogs[][] = {
{"(Numérotation...)"},
{"Matthew: Euh, yo, c'est pour quoi ?"},
{"Moi: Ça te dirait d'aller faire un tour ?"},
{"Matthew: Oh nan pas maintenant, j'dormais là, rappelle plus tard."},
{"Moi: Ça marche, une autre fois alors."}
//6
};
new MatthewH1_Dialogs[][] = {
{"(Numérotation...)"},
{"Matthew: Hey ! C'est pour sortir ?"},
{"Moi: Non, pour t'acheter des tomates."},
{"Matthew: Super drôle, allez passe me chercher, même endroit que d'habitude !"},
{"Moi: J'arrive."}
//6
};
new MatthewH1_Dialogs2[][] = {
{"Matthew: Salut ! Trimballe nous où tu veux !"},
{"Moi: C'est parti !"}
//3
};
new MatthewH1_Dialogs3[][] = {
{"Matthew: Wouh ! Yeah. Reviens dès qu'tu peux mon pote !"},
{"Moi: Héhé, j'y penserai."}
//3
};
new Mission1_Dialogs[][] = {
{"Matthew: Putain c'est toi ? Mais c'est génial ! Depuis quand t'es arrivé ? ~n~Ça fait un bail ! Enfin laisse, c'est cool de te voir ici."},
{"Matthew: J'suis un peu dans la merde en c'moment tu vois, ~n~j'dois de l'argent par-ci par-là, mais c'est d'la bricole."},
{"Matthew: J'aimerais juste que tu bosses pour un d'ces gars-là,~n~ Ça règlera mon problème et ça t'occupera, tu pourrais même te faire des amis !"},
{"Matthew: Y s'appelle Fabrizio Luccetti, il est jamais bien loin de King's,~n~repasse me voir quand tu lui auras parlé ! Ah, et merci hein !"},
{"Moi: J'adore quand on me laisse le temps d'en placer une... J'irais l'voir... Salut."}
//6
};
new Mission2_Dialogs[][] = {
{"Fabrizio: À qui ai-je l'honneur ?"},
{"Moi: Je suis un ami de Matthew, il vous doit du fric."},
{"Fabrizio: Exact et alors quoi, tu viens payer?"},
{"Moi: En quelque sorte."},
{"Fabrizio: Bon eh ben vas-y, donne !"},
{"Moi: Non, j'ai des bras, des jambes et un cerveau, c'est plus utile."},
{"Fabrizio: Ah, tu viens donner de ta personne, je vois. Très bien, tu vas te charger d'un truc pour moi."},
{"Fabrizio: Tu vas commencer par aller chercher une \"cargaison spéciale\" sur les docks,~n~ y'a un camion qui t'attends dehors."},
{"Fabrizio: J'te laisse faire c'que t'as à faire."}
//10
};
new Mission3_Dialogs[][] = {
{"Fabrizio: Aaaah, mais qui vois-je ? C'est mon \"Monsieur Muscles\" !"},
{"Fabrizio: Mais en Amérique, t'auras besoin d'un flingue, prends ça."},
{"Moi: J'ai fait l'boulot, vous attendez quoi ensuite ?"},
{"Fabrizio: T'as rien fait jusqu'ici. Ton pote, c'est un gros client, il m'en doit un bon paquet.~n~T'en as pas fini avec moi."},
{"Moi: Peu importe, accélérez vieux croûton, plus vite ce sera fait, plus vite vous disparaîtrez."},
{"Fabrizio: Hé, du calme jeune idiot, tu lui dois l'respect au vieux. ~n~Cette fois, tu va aller chercher d'la marchandise à moi à l'entrepôt."},
{"Fabrizio: Il est à Doherty, j'ai des amis qui sont là-bas, t'auras qu'à leur dire que tu viens de la part de M. Luccetti."}
//6
};
new Mission4_Dialogs[][] = {
{"Moi: Bordel, vous êtes qui vous encore ?"},
{"Alexeï: Je suis Alexeï Mandrovski, on va dire que j'étais un partenaire de Fabrizio."},
{"Moi: Et lui, il est où ?"},
{"Alexeï: Disons qu'on a arrêté de faire des affaires et que j'ai dû le rayer de mes listes. Il y a une certaine hierarchie aux pays du rêve tu vois."},
{"Moi: Donc ?"},
{"Alexeï: Et donc j'ai pris sa place ! Et tu m'intéresses, paraît que t'as fait un gros raffut à l'entrepôt de Doherty.~n~J'ai besoin de gros bras."},
{"Moi: J'suis pas là pour vos tueries et vos deals, j'suis juste venu rembourser la dette d'un ami."},
{"Alexeï: Justement, tu seras payé à un bon prix mais ce sera à ma manière. ~n~Tiens, voilà déjà l'argent pour t'être occupé des abrutis d'service."},
{"Alexeï: Repasse me voir plus tard, j'ai de quoi vous donner une vie meilleure à toi et ton ami."},
{"Moi: Parce que vous le connaissez ?"},
{"Alexeï: Ne me prends pas pour un ignorant, tu serais surpris."},
{"Moi: Si vous le dites..."}
//13
};
new Mission5_Dialogs[][] = {
{"Matthew: Alors, ça y est, t'as fini son boulot ? Tu t'es fait des potes ? C'était pas trop chiant ? Et.."},
{"Moi: FERME-LA ! Il m'a tendu un piège, j'ai de la chance d'avoir survécu ! De toute façon, il est mort aussi."},
{"Matthew: Hein ? Pourquoi ?"},
{"Moi: Je sais pas, il a dû comprendre que j'avais pas peur de lui... Et y'a un autre mec qui a pris sa place et qui m'a donné ça."},
{"Moi: Il dit qu'il en aura plus, règles tes dettes et arrêtes tes conneries,~n~j'ai pas que ça à faire de risquer ma vie pour les criminels du coin."},
{"Matthew: Merci d'aider... Désolé pour tout hein je savais pas..."},
{"Moi: T'as encore besoin de beaucoup ?"},
{"Matthew: Bah si tu reviens avec la même chose la prochaine fois ce sera bon je pense."},
{"Moi: Quoi qu'il en soit, dépense rien pour le moment, je reviendrais dès que je peux. À plus tard."}
//10
};
new Mission6_Dialogs[][] = {
{"(Sonnerie de téléphone)"},
{"Alexeï: Eh gamin, j'ai un boulot pour toi et ça urge."},
{"Moi: Mais comment vous avez eu mon numéro ?"},
{"Alexeï: POSE PAS DE QUESTIONS STUPIDES ET ÉCOUTE-MOI !"},
{"Alexeï: Un d'mes gars va passer te chercher en vitesse, on cherche un enfoiré des triades qui nous emmerde."},
{"Alexeï: Butes-le avant qu'il aille à sa planque, sinon, ils seront trop nombreux."}
//7
};
new Mission7_Dialogs[][] = {
{"Alexeï: Voilà mon tueur au sang froid !"},
{"Moi: J'appartiens à personne."},
{"Alexeï: Travailler pour quelqu'un aux États-Unis, c'est appartenir à un patron. Et jusqu'ici, tu bosses pour moi."},
{"Moi: Écoutez, j'suis arrivé dans cette ville pour rejoindre un ami à moi, pas pour travailler pour des \"patrons\"."},
{"Moi: Trouvez un autre pigeon, moi je gagnes ma vie et j'essayes de faire ça honnêtement, avec des gens comme vous, c'est pas gagné."},
{"Alexeï: Tu bosses pour l'argent comme tout le monde dans ce pays, moi je suis venu pour en profiter mais ça fait des ennemis."},
{"Alexeï: C'est pour ça que je payes les gens pour faire le sale boulot."},
{"Moi: Alors allez vous faire foutre, j'en ai rien à cirer de votre argent et de vos ennemis."},
{"Alexeï: Alors dis adieu à Matthew."}
//10
};
new Mission7_Dialogs2[][] = {
{"Moi: MATTHEW, MONTE SANS POSER DE QUESTIONS !"},
{"Matthew: J'arrive !"}
//3
};
new Mission7_Dialogs3[][] = {
{"Matthew: WOW ! Enfin ! C'était qui les gars qui se sont tirés quand t'es arrivé ?"},
{"Moi: C'était des russes, j'ai dit au mec plein de thunes de l'autre fois que je bossais plus pour lui."},
{"Matthew: Naaaaaan meeeerde ! Faut jamais contrarier ces mecs-là ! Après ils nous traquent jusqu'à la mort !"},
{"Moi: Tu parles, ils ont abandonné parce que j'ai été plus rapide qu'eux, ils nous traquent vachement."},
{"Matthew: Et qu'est-ce qui va se passer maintenant ? J'vais rester là ?"},
{"Moi: Derrière, c'est abandonné, tu restes planqué ici pour le moment, c'est plus sûr."},
{"Matthew: Et toi tu vas me laisser là dedans tout seul sans bouffe ni rien ?"},
{"Moi: Mais non, je reviendrai vite et puis fouille un peu, il doit bien rester quelque chose."},
{"Matthew: Mais si tu retournes en ville, tu vas te faire massacrer, reste donc avec moi !"},
{"Moi: Et puis quoi, j'attends la mort ? De toute manière, ils me tueront pas, ils te veulent toi pour m'atteindre."},
{"Matthew: Super rassurant à savoir ! Te fais pas suivre encore une fois si tu reviens me voir !"},
{"Moi: T'inquiète pas, j'y veillerai... Prends soin de toi, je reviens bientôt."}
//13
};
new Mission8_Dialogs[][] = {
{"Matthew: Putain tu t'es fait attendre ! Mais qu'est-ce que tu foutais ?!"},
{"Moi: Ça me regarde. Et donc, t'es mort ?"},
{"Matthew: D'inquiétude ouais !"},
{"Moi: Quoi, tu tiens tant que ça à moi ? T'as pourtant pas arrangé ma situation..."},
{"Matthew: À toi ? mais est-ce que t'es au courant que moi j'suis enfermé ici toute la journée à regarder le cadran faire des tours ?"},
{"Moi: PUTAIN MAIS J'Y CROIS PAS ! J'ai sauvé ta misérable vie et toi tu t'inquiète parce que t'es entre 4 murs ?"},
{"Moi: Estime-toi déjà heureux de pas être entre 4 planches de sapin abruti !"},
{"Matthew: Tout allait très bien avant que tu laisses tomber le russe !"},
{"Moi: Ouaaaais vachement bien ! Je tuais des gens et j'allais chercher des bricoles et même pas pour vivre, pour SURVIVRE !"},
{"Moi: Et payer TES DETTES espèce d'ingrat ! Si j'te laisse ici, tu tiendras pas une semaine entière !"},
{"Matthew: On parie ? Y'a des caisses de bouffe pas loin !"},
{"Vieil homme: Mes provisions ?"},
{"Moi: Qu'est-ce que ?"},
{"Vieil homme: Qu'est-ce que quoi ? C'est moi qui devrait poser les questions, vous faites quoi chez moi ?"},
{"Matthew: Bah rien de spécial, moi je m'ennuie et lui il vient le constater."},
{"Moi: Ta gueule espèce d'égocentrique, si on est sur une propriété privée, on reste pas."},
{"Vieil homme: Je ne qualifierais pas ça de propriété privée... Mais on va pas dire que c'est abandonné non plus... C'est chez moi voilà tout."},
{"Moi: Et donc ?"},
{"Vieil homme: Et donc vous pouvez habiter ici, prendre les provisions, utiliser la télé et tout ce que vous voulez mais il faudra payer."},
{"Moi: Payer ? Cet espèce de mendiant endetté a plus rien à vous filer. Et moi non plus d'ailleurs."},
{"Vieil homme: Je n'vous parle pas d'argent, je vous parles de services !"},
{"Moi: Comme ?"},
{"Vieil homme: Comme par exemple aller chercher ma voiture !"},
{"Moi: Et elle est où, elle ressemble à quoi ?"},
{"Vieil homme: C'est comme une petite camionette avec une caisse à l'arrière, elle est dans la zone 51..."},
{"Moi: Et c'est quoi ça, la zone 51 ?"},
{"Matthew: Tu connais pas la zone 51 ? C'est un endroit plein d'militaires planqués et de trucs secrets que l'état manigance !"},
{"Moi: Mais qu'est-ce que votre voiture fout là-bas ?"},
{"Vieil homme: Bah j'suis curieux comme tout le monde ! Mais l'armée était pas très joyeuse de me voir... Ils ont manqué de me tuer, alors j'ai fui."},
{"Moi: Ouais bon, j'ai survécu à des trucs plutôt oufs depuis que j'suis arrivé dans l'coin, ça devrait pas me poser de problème... J'y vais."}
//31
};
new Mission9_Dialogs[][] = {
{"Moi: Matthew, avant que tu te plaignes ou que tu dises quoi que ce soit, j'aimerais que tu m'écoutes..."},
{"Matthew: Quoi ?"},
{"Moi: J'voudrais faire le point un p'tit peu avec tout ce qui se passe... T'expliquer mon comportement et pourquoi j'ai réagi comme ça l'autre fois."},
{"Matthew: Tu veux dire m'insulter et m'engueuler pour rien ?"},
{"Moi: Recommence pas tu veux, laisse moi parler ! J'suis arrivé dans un pays qui ne reflète pas du tout mon idéal de vie,"},
{"Moi: Un pays soit disant de rêve alors qu'il y a longtemps que tout ça est terminé et que les plus riches profitent des autres qui font le boulot."},
{"Moi: J'ai travaillé pour des gens mauvais assoiffés d'argent, rancuniers et sans pitié pour une seule et unique raison Matthew et c'est toi."},
{"Moi: Tout ce que j'ai fait, je l'ai fait parce que je suis ton ami et parce que je voulais pas rester seul à Chestfield."},
{"Moi: D'ailleurs, tu as trahi des générations de ta famille en venant ici."},
{"Matthew: Je m'en fiche, c'est pas parce que je porte le nom de famille d'un endroit paumé que j'dois y rester toute ma vie."},
{"Moi: Mais regarde où ça t'a mené ! Tu vis à crédit auprès des truands et actuellement, des gens veulent te faire la peau !"},
{"Matthew: Et c'est de ma faute peut-être ?"},
{"Moi: Parfaitement, la seule raison pour laquelle t'étais encore en vie, c'est parce qu'ils avaient pitié de toi et qu'ils attendaient ton argent !"},
{"Moi: Je t'ai arrangé ta situation en réalité, tu vis gratuitement chez un vieil homme très hospitalier et j'viens régulièrement te voir."},
{"Matthew: Tu veux rire ? J'ai l'impression de vivre dans une maison de retraite !"},
{"Matthew: Excuse-moi mais écouter les anecdotes du vieux et lui torcher l'cul, c'est pas un rêve..."},
{"Moi: Au moins, t'es en bonne santé et j'ai pas à m'occuper de toi, ça m'a aidé à prendre du recul."},
{"Matthew: Dis-le si j'suis un fardeau, si j't'ai engueulé pour ton retard c'est parce que t'es la seule chose que j'ai dans ce pays en réalité..."},
{"Moi: J'suis content que tu le reconnaisses enfin ! Faut qu'on arrête de s'faire la gueule constamment, j'suis venu ici pour toi."},
{"Matthew: On devrait aller boire un coup ! Mais pas en ville, ça serait risqué."},
{"Moi: Bah on va faire un tour et suivre les routes, on trouvera bien un p'tit bar sympa dans l'coin !"},
{"Matthew: Ça marche, on y va !"}
//23
};
new Mission9_Dialogs2[][] = {
{"Matthew: C'était cool ! On devrait faire ça plus souvent !"},
{"Moi: J't'achèterais un téléphone un d'ces jours et on pourra s'appeler régulièrement."},
{"Matthew: Super sympa, merci mec, j'apprécie c'que tu fais pour moi !"},
{"Moi: C'est un peu mon rôle en quelque sorte, on va s'en sortir t'en fais pas. J'repasserais t'voir bientôt, salut !"}
//5
};
new Mission10_Dialogs[][] = {
{"Matthew: Heeey ! Qu'est-ce tu fais là ?"},
{"Moi: J't'apporte ton nouveau téléphone banane !"},
{"Matthew: Comment t'as trouvé l'argent pour m'acheter un téléphone ?"},
{"Moi: J't'ai pas tout donné de l'argent du russe, je savais que t'en ferais pas bon usage alors j'ai mis de côté."},
{"Matthew: J'sais pas trop comment l'prendre mais j'vais quand même te remercier... On va pouvoir sortir souvent alors ?"},
{"Moi: J't'appellerais quand j'serais libre et que j'aurais pas la tête pleine de tourments, t'en fais pas."}
//7
};
new Mission10_Dialogs2[][] = {
{"Alexeï: Coucou"},
{"Moi: Putain, j'avais oublié qu'vous aviez mon numéro."},
{"Alexeï: Et si ça m'chante, j'peux même savoir où tu es."},
{"Moi: Pourquoi vous m'avez pas encore buté, vous attendez quoi de moi ?"},
{"Alexeï: Les gars comme toi, ça court pas les rues, ils tiennent pas longtemps dans une fusillade d'habitude. C'est pour ça que j'te veux."},
{"Moi: J'vous ai dit que j'bosserais plus pour vous."},
{"Alexeï: J't'ai foutu un bon coup de flippe avec Matthew hein ? T'y as vraiment cru ?"},
{"Moi: Dites-moi pourquoi vous faites ça."},
{"Alexeï: Si je touches pas la corde sensible, tu feras jamais rien pour moi ! Reviens me voir, sinon, ton pote va vraiment y passer cette fois."}
//10
};

Sanction(adminid,playerid,reason[])
{
	new string[256],sanction[32],aname[MAX_PLAYER_NAME],pname[MAX_PLAYER_NAME];
	aname = GetName(adminid);
	pname = GetName(playerid);
	switch(sanctiontype[adminid])
	{
	    case 1 :
	    {
			if(muted[playerid] == true) return SubMessage(adminid,MSG_RED,"Ce joueur est déjà mute !",5);
	        sanction = "mute";
	        muted[playerid] = true;
	        mutetimer[playerid] = SetTimerEx("MuteTimer",300000,false,"i",playerid);
            printf("[ADMIN] %s a mute %s | Raison : %s",GetName(adminid),GetName(playerid),reason);
		}
		case 3 :
		{
		    sanction = "kick";
	        format(string,sizeof(string),"[ADMIN] {ffffff}%s {0080C0}a kick {ffffff}%s {0080C0}pour {ffffff}%s",GetName(adminid),GetName(playerid),reason);
	        SendClientMessageToAll(BLUE,string);
		    SendClientMessage(playerid,BLUE,"[ADMIN] Vous avez été kick !");
		    printf("[ADMIN] %s a kick %s | Raison : %s",GetName(adminid),GetName(playerid),reason);
		    new year,month,day;
		    getdate(year,month,day);
		    new hours,minutes,second;
		    gettime(hours,minutes,second);
		    new aip[16],pip[16];
		    GetPlayerIp(playerid,pip,sizeof(pip));
		    GetPlayerIp(adminid,aip,sizeof(aip));
		    format(string,sizeof(string),"[%02d/%02d/%02d - %02d:%02d:%02d] Admin %s (%s) a %s %s (%s) | Raison : %s\r\n",day,month,year,hours,minutes,second,aname,aip,sanction,pname,pip,reason);
		    WriteSanctionFile(string);
		    Kick(playerid);
		    return 1;
		}
		case 4 :
		{
		    sanction = "banni";
 	        format(string,sizeof(string),"[ADMIN] {ffffff}%s {0080C0}a banni {ffffff}%s {0080C0}pour {ffffff}%s",GetName(adminid),GetName(playerid),reason);
	        SendClientMessageToAll(BLUE,string);
	        SendClientMessage(playerid,BLUE,"[ADMIN] Vous avez été banni du serveur !");
	        SendClientMessage(playerid,YELLOW,"Vous pouvez poster une {ff0000}demande débanissement {ffff00}via notre forum : {ff0000}http://sanandreasonline.forumactif.com/");
	        PlayerInfo[playerid][pBan] = true;
        	new INI:UserFile = INI_Open(UserPath(playerid));
		    INI_SetTag(UserFile,"data");
			INI_WriteBool(UserFile,"Ban", PlayerInfo[playerid][pBan]);
		    INI_Close(UserFile);
		    printf("[ADMIN] %s a banni %s | Raison : %s",GetName(adminid),GetName(playerid),reason);
		    new year,month,day;
		    getdate(year,month,day);
		    new hours,minutes,second;
		    gettime(hours,minutes,second);
		    new aip[16],pip[16];
		    GetPlayerIp(playerid,pip,sizeof(pip));
		    GetPlayerIp(adminid,aip,sizeof(aip));
		    format(string,sizeof(string),"[%02d/%02d/%02d - %02d:%02d:%02d] Admin %s (%s) a %s %s (%s) | Raison : %s\r\n",day,month,year,hours,minutes,second,aname,aip,sanction,pname,pip,reason);
		    WriteSanctionFile(string);
		    BanEx(playerid,reason);
		    return 1;

		}
		case 5 :
		{
		    sanction = "fucked up";
			GivePlayerSkin(playerid,252);
			GiveMoney(playerid,-10000);
			new Float:x,Float:y,Float:z;
			GetPlayerPos(playerid,x,y,z);
			SetPlayerPos(playerid,x,y,z + 15.0);
			CreateExplosion(x,y,z + 15.0,0,10.0);
		}
		case 6:
		{
		    sanction = "slap";
			new Float:x,Float:y,Float:z;
			GetPlayerPos(playerid,x,y,z);
			SetPlayerPos(playerid,x,y,z + 15.0);
		}
		case 7:
		{
			sanction = "explosé";
			new Float:x,Float:y,Float:z;
			GetPlayerPos(playerid,x,y,z);
			CreateExplosion(x,y,z,0,10.0);
		}
		case 8:
		{
			if(jailed[playerid] == true) return SubMessage(adminid,MSG_RED,"Ce joueur est déjà jail !",5);
		    sanction = "jail";
			new value = random(2);
			new Float:x;
			value ++;
			if(value == 1) x = 219.5876;
			else x = 215.5112;
			jailed[playerid] = true;
			SetPlayerPosEx(playerid,x,110.2150,999.0156,10,0);
			format(string,sizeof(string),"[ADMIN] Vous avez été placé dans la cellule {ffffff}%d",value);
			SendClientMessage(playerid,BLUE,string);
			jailtimer[playerid] = SetTimerEx("JailTimer",300000,false,"i",playerid);

		}
		// case 9 : Unjail
	}
	format(string,sizeof(string),"[ADMIN] {ffffff}%s {0080C0}a %s {ffffff}%s {0080C0}| Raison : {ffffff}%s",GetName(adminid),sanction,GetName(playerid),reason);
	SendClientMessageToAll(BLUE,string);
    printf("[ADMIN] %s a %s %s | Raison : %s",aname,sanction,pname,reason);
    new year,month,day;
    getdate(year,month,day);
    new hours,minutes,second;
    gettime(hours,minutes,second);
    new aip[16],pip[16];
    GetPlayerIp(playerid,pip,sizeof(pip));
    GetPlayerIp(adminid,aip,sizeof(aip));
    format(string,sizeof(string),"[%02d/%02d/%02d - %02d:%02d:%02d] Admin %s (%s) a %s %s (%s) | Raison : %s\r\n",day,month,year,hours,minutes,second,aname,aip,sanction,pname,pip,reason);
    WriteSanctionFile(string);
    return 1;
}

TimeWeap(weaponid)
{
	new value;
	switch(weaponid)
	{
		case 22,27: value = 55;
		case 23: value = 65;
		case 24: value = 128;
		case 25,33,34: value = 189;
		case 26: value = 26;
		case 28 .. 32: value = 22;
		case 38: value = 4;
	}
	return value;
}

Float:floatrand(Float:min, Float:max)
{
	new imin = floatround(min);
	return floatdiv(float(random((floatround(max)-imin)*100)+(imin*100)),100.0);
}

CreateTarget(playerid, level)
{
	new Float:x,Float:y,Float:oldx,Float:oldy;
    x = floatrand(XMIN,XMAX);
    y = floatrand(YMIN,YMAX);
	oldx = floatrand(XMIN,XMAX);
 	oldy = floatrand(YMIN,YMAX);
 	GivePlayerWeapon(playerid,24,1);
 	atarget[playerid] = CreatePlayerObject(playerid,3024,x,y,1003.0,0.0,0.0,0.0);
 	SetPlayerDrunkLevel(playerid,0);
	switch(level)
	{
	    case 2:
	    {
			MovePlayerObject(playerid,atarget[playerid],oldx,oldy,1003.0,2.5,0.0,0.0,0.0);
		}
		case 3:
		{
			MovePlayerObject(playerid,atarget[playerid],oldx,oldy,1003.0,5.0,0.0,0.0,0.0);
		}
		case 4:
		{
			MovePlayerObject(playerid,atarget[playerid],oldx,oldy,1003.0,5.0,0.0,0.0,0.0);
			SetPlayerDrunkLevel(playerid,5000);
		}
		case 5:
		{
            MovePlayerObject(playerid,atarget[playerid],oldx,oldy,1003.0,7.5,0.0,0.0,0.0);
		}
		case 6:
		{
		    MovePlayerObject(playerid,atarget[playerid],oldx,oldy,1003.0,7.5,0.0,0.0,0.0);
		    SetPlayerDrunkLevel(playerid,25000);
		}
	}
}

GivePlayerWeaponsSaved(playerid)
{
	ResetPlayerWeapons(playerid);
	if(PlayerInfo[playerid][p9mm] != 0) GivePlayerWeapon(playerid,22,PlayerInfo[playerid][p9mm]);
	if(PlayerInfo[playerid][pS9mm] != 0) GivePlayerWeapon(playerid,23,PlayerInfo[playerid][pS9mm]);
 	if(PlayerInfo[playerid][pEagle] != 0) GivePlayerWeapon(playerid,24,PlayerInfo[playerid][pEagle]);
 	if(PlayerInfo[playerid][pShotgun] != 0) GivePlayerWeapon(playerid,25,PlayerInfo[playerid][pShotgun]);
    if(PlayerInfo[playerid][pSawnoff] != 0) GivePlayerWeapon(playerid,26,PlayerInfo[playerid][pSawnoff]);
    if(PlayerInfo[playerid][pCShotgun] != 0) GivePlayerWeapon(playerid,27,PlayerInfo[playerid][pCShotgun]);
    if(PlayerInfo[playerid][pUzi] != 0) GivePlayerWeapon(playerid,28,PlayerInfo[playerid][pUzi]);
    if(PlayerInfo[playerid][pMp5] != 0) GivePlayerWeapon(playerid,29,PlayerInfo[playerid][pMp5]);
    if(PlayerInfo[playerid][pAk47] != 0) GivePlayerWeapon(playerid,30,PlayerInfo[playerid][pAk47]);
    if(PlayerInfo[playerid][pM4] != 0) GivePlayerWeapon(playerid,31,PlayerInfo[playerid][pM4]);
    if(PlayerInfo[playerid][pTec9] != 0) GivePlayerWeapon(playerid,32,PlayerInfo[playerid][pTec9]);
    if(PlayerInfo[playerid][pRifle] != 0) GivePlayerWeapon(playerid,33,PlayerInfo[playerid][pRifle]);
    if(PlayerInfo[playerid][pSniper] != 0) GivePlayerWeapon(playerid,34,PlayerInfo[playerid][pSniper]);
	return 1;
}

SetCountDown(time,bool:race)
{
	KillTimer(timercd);
	timedown = time;
	CDFRace = race;
	timercd = SetTimer("CountDown",1000,true);
}

IsAllCabineOccuped()
{
	new value = -1;
	for(new i; i < CABINES ; i++)
	{
	    if(CabineOccuped[i] == false)
	    {
	        value = i;
	        break;
		}
	}
	return value;
}
stock GetClosestDynamicObject(playerid)
{
	new Float:px,Float:py,Float:pz,
	Float:ox,Float:oy,Float:oz,Float:dist,Float:result = 12345;
	GetPlayerPos(playerid,px,py,pz);
	for(new o; o < CountDynamicObjects(); o++)
	{
		GetDynamicObjectPos(o,ox,oy,oz);
		dist = floatsqroot(floatpower(floatabs(floatsub(px,ox)),2)+floatpower(floatabs(floatsub(py,oy)),2)+floatpower(floatabs(floatsub(pz,oz)),2));
		if(dist < result)
		{
		    result = dist;
		    return o;
		}
	}
	return true;
}
GivePlayerWantedLevel(playerid, amount)
{
	if(PlayerInfo[playerid][pEtoiles] >= amount) return 1;

	new value,string[256];
	switch(amount)
	{
	    case 1 : value = 100;
	    case 2 : value = 300;
	    case 3 : value = 500;
	    case 4 : value = 750;
	    case 5 : value = 1000;
	    case 6 : value = 2000;
	}
	format(string,sizeof(string),"Tu as ~w~%d ~y~étoile(s) ! Tu gagnes ~w~$%d ~y~!",amount,value);
	SubMessage(playerid,MSG_YELLOW, string, 10);
	GiveMoney(playerid,value);
	PlayerInfo[playerid][pEtoiles] = amount;
	if(PlayerInfo[playerid][pEtoiles] > 6) PlayerInfo[playerid][pEtoiles] = 6;
	new INI:File = INI_Open(UserPath(playerid));
	INI_SetTag(File,"data");
	INI_WriteInt(File,"Etoiles",PlayerInfo[playerid][pEtoiles]);
	INI_Close(File);
	SetPlayerWantedLevel(playerid,PlayerInfo[playerid][pEtoiles]);
	return 1;
}

CreateNPCMenu(playerid)
{
    TDMenu_NPC[playerid][0] = CreatePlayerTextDraw(playerid, 141.478775, 50.583362, "box");
	PlayerTextDrawLetterSize(playerid, TDMenu_NPC[playerid][0], 0.000000, 38.204971);
	PlayerTextDrawTextSize(playerid, TDMenu_NPC[playerid][0], 502.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, TDMenu_NPC[playerid][0], 1);
	PlayerTextDrawColor(playerid, TDMenu_NPC[playerid][0], -1);
	PlayerTextDrawUseBox(playerid, TDMenu_NPC[playerid][0], 1);
	PlayerTextDrawBoxColor(playerid, TDMenu_NPC[playerid][0], 150);
	PlayerTextDrawSetShadow(playerid, TDMenu_NPC[playerid][0], 1);
	PlayerTextDrawSetOutline(playerid, TDMenu_NPC[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, TDMenu_NPC[playerid][0], 255);
	PlayerTextDrawFont(playerid, TDMenu_NPC[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, TDMenu_NPC[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, TDMenu_NPC[playerid][0], 1);

	TDMenu_NPC[playerid][1] = CreatePlayerTextDraw(playerid, 145.226959, 52.916648, "Menu_npc");
	PlayerTextDrawLetterSize(playerid, TDMenu_NPC[playerid][1], 0.391097, 1.699166);
	PlayerTextDrawAlignment(playerid, TDMenu_NPC[playerid][1], 1);
	PlayerTextDrawColor(playerid, TDMenu_NPC[playerid][1], 402653183);
	PlayerTextDrawSetShadow(playerid, TDMenu_NPC[playerid][1], 4);
	PlayerTextDrawSetOutline(playerid, TDMenu_NPC[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, TDMenu_NPC[playerid][1], 255);
	PlayerTextDrawFont(playerid, TDMenu_NPC[playerid][1], 2);
	PlayerTextDrawSetProportional(playerid, TDMenu_NPC[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, TDMenu_NPC[playerid][1], 4);

	TDMenu_NPC[playerid][2] = CreatePlayerTextDraw(playerid, 195.827331, 90.249946, "Nom npc");
	PlayerTextDrawLetterSize(playerid, TDMenu_NPC[playerid][2], 0.327847, 1.366666);
	PlayerTextDrawTextSize(playerid, TDMenu_NPC[playerid][2], 0.000000, 88.000000);
	PlayerTextDrawAlignment(playerid, TDMenu_NPC[playerid][2], 2);
	PlayerTextDrawColor(playerid, TDMenu_NPC[playerid][2], -1);
	PlayerTextDrawUseBox(playerid, TDMenu_NPC[playerid][2], 1);
	PlayerTextDrawBoxColor(playerid, TDMenu_NPC[playerid][2], 255);
	PlayerTextDrawSetShadow(playerid, TDMenu_NPC[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, TDMenu_NPC[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, TDMenu_NPC[playerid][2], 255);
	PlayerTextDrawFont(playerid, TDMenu_NPC[playerid][2], 2);
	PlayerTextDrawSetProportional(playerid, TDMenu_NPC[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, TDMenu_NPC[playerid][2], 0);
	PlayerTextDrawSetSelectable(playerid, TDMenu_NPC[playerid][2], false);

	TDMenu_NPC[playerid][3] = CreatePlayerTextDraw(playerid, 152.554931, 118.833297, "");
	PlayerTextDrawLetterSize(playerid, TDMenu_NPC[playerid][3], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TDMenu_NPC[playerid][3], 90.000000, 90.000000);
	PlayerTextDrawAlignment(playerid, TDMenu_NPC[playerid][3], 1);
	PlayerTextDrawColor(playerid, TDMenu_NPC[playerid][3], -1);
	PlayerTextDrawSetShadow(playerid, TDMenu_NPC[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, TDMenu_NPC[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, TDMenu_NPC[playerid][3], 255);
	PlayerTextDrawFont(playerid, TDMenu_NPC[playerid][3], 5);
	PlayerTextDrawSetProportional(playerid, TDMenu_NPC[playerid][3], 0);
	PlayerTextDrawSetShadow(playerid, TDMenu_NPC[playerid][3], 0);
	PlayerTextDrawSetSelectable(playerid, TDMenu_NPC[playerid][3], true);
	PlayerTextDrawSetPreviewModel(playerid, TDMenu_NPC[playerid][3], 0);
	PlayerTextDrawSetPreviewRot(playerid, TDMenu_NPC[playerid][3], 0.000000, 0.000000, 0.000000, 1.000000);

    new string[16];
    string = "Intérieur";
    ConvertEncoding(string);
	TDMenu_NPC[playerid][4] = CreatePlayerTextDraw(playerid, 207.071838, 231.999938,string);
	PlayerTextDrawLetterSize(playerid, TDMenu_NPC[playerid][4], 0.327847, 1.366666);
	PlayerTextDrawTextSize(playerid, TDMenu_NPC[playerid][4], 15.000000, 88.000000);
	PlayerTextDrawAlignment(playerid, TDMenu_NPC[playerid][4], 2);
	PlayerTextDrawColor(playerid, TDMenu_NPC[playerid][4], -1);
	PlayerTextDrawUseBox(playerid, TDMenu_NPC[playerid][4], 1);
	PlayerTextDrawBoxColor(playerid, TDMenu_NPC[playerid][4], 255);
	PlayerTextDrawSetShadow(playerid, TDMenu_NPC[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, TDMenu_NPC[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, TDMenu_NPC[playerid][4], 255);
	PlayerTextDrawFont(playerid, TDMenu_NPC[playerid][4], 2);
	PlayerTextDrawSetProportional(playerid, TDMenu_NPC[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid, TDMenu_NPC[playerid][4], 0);
	PlayerTextDrawSetSelectable(playerid, TDMenu_NPC[playerid][4], true);

	TDMenu_NPC[playerid][5] = CreatePlayerTextDraw(playerid, 216.442260, 265.379486, "Virtual World : 0");
	PlayerTextDrawLetterSize(playerid, TDMenu_NPC[playerid][5], 0.327847, 1.366666);
	PlayerTextDrawTextSize(playerid, TDMenu_NPC[playerid][5], 15.000000, 137.000000);
	PlayerTextDrawAlignment(playerid, TDMenu_NPC[playerid][5], 2);
	PlayerTextDrawColor(playerid, TDMenu_NPC[playerid][5], -1);
	PlayerTextDrawUseBox(playerid, TDMenu_NPC[playerid][5], 1);
	PlayerTextDrawBoxColor(playerid, TDMenu_NPC[playerid][5], 255);
	PlayerTextDrawSetShadow(playerid, TDMenu_NPC[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, TDMenu_NPC[playerid][5], 0);
	PlayerTextDrawBackgroundColor(playerid, TDMenu_NPC[playerid][5], 255);
	PlayerTextDrawFont(playerid, TDMenu_NPC[playerid][5], 2);
	PlayerTextDrawSetProportional(playerid, TDMenu_NPC[playerid][5], 1);
	PlayerTextDrawSetShadow(playerid, TDMenu_NPC[playerid][5], 0);
	PlayerTextDrawSetSelectable(playerid, TDMenu_NPC[playerid][5], true);

	TDMenu_NPC[playerid][6] = CreatePlayerTextDraw(playerid, 176.449508, 287.416534, "");
	PlayerTextDrawLetterSize(playerid, TDMenu_NPC[playerid][6], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TDMenu_NPC[playerid][6], 90.000000, 90.000000);
	PlayerTextDrawAlignment(playerid, TDMenu_NPC[playerid][6], 1);
	PlayerTextDrawColor(playerid, TDMenu_NPC[playerid][6], -1);
	PlayerTextDrawSetShadow(playerid, TDMenu_NPC[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, TDMenu_NPC[playerid][6], 0);
	PlayerTextDrawBackgroundColor(playerid, TDMenu_NPC[playerid][6], 255);
	PlayerTextDrawFont(playerid, TDMenu_NPC[playerid][6], 5);
	PlayerTextDrawSetProportional(playerid, TDMenu_NPC[playerid][6], 0);
	PlayerTextDrawSetShadow(playerid, TDMenu_NPC[playerid][6], 0);
	PlayerTextDrawSetSelectable(playerid, TDMenu_NPC[playerid][6], true);
	PlayerTextDrawSetPreviewModel(playerid, TDMenu_NPC[playerid][6], 335);
	PlayerTextDrawSetPreviewRot(playerid, TDMenu_NPC[playerid][6], 0.000000, 0.000000, 0.000000, 1.000000);

	string = "Vulnérable";
	ConvertEncoding(string);
	TDMenu_NPC[playerid][7] = CreatePlayerTextDraw(playerid, 413.221343, 92.129470,string);
	PlayerTextDrawLetterSize(playerid, TDMenu_NPC[playerid][7], 0.327847, 1.366666);
	PlayerTextDrawTextSize(playerid, TDMenu_NPC[playerid][7], 15.000000, 137.000000);
	PlayerTextDrawAlignment(playerid, TDMenu_NPC[playerid][7], 2);
	PlayerTextDrawColor(playerid, TDMenu_NPC[playerid][7], 8388863);
	PlayerTextDrawUseBox(playerid, TDMenu_NPC[playerid][7], 1);
	PlayerTextDrawBoxColor(playerid, TDMenu_NPC[playerid][7], 255);
	PlayerTextDrawSetShadow(playerid, TDMenu_NPC[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, TDMenu_NPC[playerid][7], 0);
	PlayerTextDrawBackgroundColor(playerid, TDMenu_NPC[playerid][7], 255);
	PlayerTextDrawFont(playerid, TDMenu_NPC[playerid][7], 2);
	PlayerTextDrawSetProportional(playerid, TDMenu_NPC[playerid][7], 1);
	PlayerTextDrawSetShadow(playerid, TDMenu_NPC[playerid][7], 0);
	PlayerTextDrawSetSelectable(playerid, TDMenu_NPC[playerid][7], true);

	TDMenu_NPC[playerid][8] = CreatePlayerTextDraw(playerid, 411.815795, 135.296112, "Suivre...");
	PlayerTextDrawLetterSize(playerid, TDMenu_NPC[playerid][8], 0.327847, 1.366666);
	PlayerTextDrawTextSize(playerid, TDMenu_NPC[playerid][8], 15.000000, 137.000000);
	PlayerTextDrawAlignment(playerid, TDMenu_NPC[playerid][8], 2);
	PlayerTextDrawColor(playerid, TDMenu_NPC[playerid][8], 8388863);
	PlayerTextDrawUseBox(playerid, TDMenu_NPC[playerid][8], 1);
	PlayerTextDrawBoxColor(playerid, TDMenu_NPC[playerid][8], 255);
	PlayerTextDrawSetShadow(playerid, TDMenu_NPC[playerid][8], 0);
	PlayerTextDrawSetOutline(playerid, TDMenu_NPC[playerid][8], 0);
	PlayerTextDrawBackgroundColor(playerid, TDMenu_NPC[playerid][8], 255);
	PlayerTextDrawFont(playerid, TDMenu_NPC[playerid][8], 2);
	PlayerTextDrawSetProportional(playerid, TDMenu_NPC[playerid][8], 1);
	PlayerTextDrawSetShadow(playerid, TDMenu_NPC[playerid][8], 0);
	PlayerTextDrawSetSelectable(playerid, TDMenu_NPC[playerid][8], true);

	TDMenu_NPC[playerid][9] = CreatePlayerTextDraw(playerid, 411.815795, 177.296081, "Viser...");
	PlayerTextDrawLetterSize(playerid, TDMenu_NPC[playerid][9], 0.327847, 1.366666);
	PlayerTextDrawTextSize(playerid, TDMenu_NPC[playerid][9], 15.000000, 137.000000);
	PlayerTextDrawAlignment(playerid, TDMenu_NPC[playerid][9], 2);
	PlayerTextDrawColor(playerid, TDMenu_NPC[playerid][9], 8388863);
	PlayerTextDrawUseBox(playerid, TDMenu_NPC[playerid][9], 1);
	PlayerTextDrawBoxColor(playerid, TDMenu_NPC[playerid][9], 255);
	PlayerTextDrawSetShadow(playerid, TDMenu_NPC[playerid][9], 0);
	PlayerTextDrawSetOutline(playerid, TDMenu_NPC[playerid][9], 0);
	PlayerTextDrawBackgroundColor(playerid, TDMenu_NPC[playerid][9], 255);
	PlayerTextDrawFont(playerid, TDMenu_NPC[playerid][9], 2);
	PlayerTextDrawSetProportional(playerid, TDMenu_NPC[playerid][9], 1);
	PlayerTextDrawSetShadow(playerid, TDMenu_NPC[playerid][9], 0);
	PlayerTextDrawSetSelectable(playerid, TDMenu_NPC[playerid][9], true);

	TDMenu_NPC[playerid][10] = CreatePlayerTextDraw(playerid, 416.032440, 278.083312, "Distance pour viser : 10.0m");
	PlayerTextDrawLetterSize(playerid, TDMenu_NPC[playerid][10], 0.327847, 1.366666);
	PlayerTextDrawTextSize(playerid, TDMenu_NPC[playerid][10], 15.000000, 159.000000);
	PlayerTextDrawAlignment(playerid, TDMenu_NPC[playerid][10], 2);
	PlayerTextDrawColor(playerid, TDMenu_NPC[playerid][10], -1);
	PlayerTextDrawUseBox(playerid, TDMenu_NPC[playerid][10], 1);
	PlayerTextDrawBoxColor(playerid, TDMenu_NPC[playerid][10], 255);
	PlayerTextDrawSetShadow(playerid, TDMenu_NPC[playerid][10], 0);
	PlayerTextDrawSetOutline(playerid, TDMenu_NPC[playerid][10], 0);
	PlayerTextDrawBackgroundColor(playerid, TDMenu_NPC[playerid][10], 255);
	PlayerTextDrawFont(playerid, TDMenu_NPC[playerid][10], 2);
	PlayerTextDrawSetProportional(playerid, TDMenu_NPC[playerid][10], 1);
	PlayerTextDrawSetShadow(playerid, TDMenu_NPC[playerid][10], 0);
	PlayerTextDrawSetSelectable(playerid, TDMenu_NPC[playerid][10], true);

	TDMenu_NPC[playerid][11] = CreatePlayerTextDraw(playerid, 416.032440, 337.583221, "Precision : 1.0");
	PlayerTextDrawLetterSize(playerid, TDMenu_NPC[playerid][11], 0.327847, 1.366666);
	PlayerTextDrawTextSize(playerid, TDMenu_NPC[playerid][11], 15.000000, 159.000000);
	PlayerTextDrawAlignment(playerid, TDMenu_NPC[playerid][11], 2);
	PlayerTextDrawColor(playerid, TDMenu_NPC[playerid][11], -1);
	PlayerTextDrawUseBox(playerid, TDMenu_NPC[playerid][11], 1);
	PlayerTextDrawBoxColor(playerid, TDMenu_NPC[playerid][11], 255);
	PlayerTextDrawSetShadow(playerid, TDMenu_NPC[playerid][11], 0);
	PlayerTextDrawSetOutline(playerid, TDMenu_NPC[playerid][11], 0);
	PlayerTextDrawBackgroundColor(playerid, TDMenu_NPC[playerid][11], 255);
	PlayerTextDrawFont(playerid, TDMenu_NPC[playerid][11], 2);
	PlayerTextDrawSetProportional(playerid, TDMenu_NPC[playerid][11], 1);
	PlayerTextDrawSetShadow(playerid, TDMenu_NPC[playerid][11], 0);
	PlayerTextDrawSetSelectable(playerid, TDMenu_NPC[playerid][11], true);

	TDMenu_NPC[playerid][12] = CreatePlayerTextDraw(playerid, 415.095367, 233.166488, "Vie_:_100.0");
	PlayerTextDrawLetterSize(playerid, TDMenu_NPC[playerid][12], 0.327847, 1.366666);
	PlayerTextDrawTextSize(playerid, TDMenu_NPC[playerid][12], 15.000000, 159.000000);
	PlayerTextDrawAlignment(playerid, TDMenu_NPC[playerid][12], 2);
	PlayerTextDrawColor(playerid, TDMenu_NPC[playerid][12], -1);
	PlayerTextDrawUseBox(playerid, TDMenu_NPC[playerid][12], 1);
	PlayerTextDrawBoxColor(playerid, TDMenu_NPC[playerid][12], 255);
	PlayerTextDrawSetShadow(playerid, TDMenu_NPC[playerid][12], 0);
	PlayerTextDrawSetOutline(playerid, TDMenu_NPC[playerid][12], 0);
	PlayerTextDrawBackgroundColor(playerid, TDMenu_NPC[playerid][12], 255);
	PlayerTextDrawFont(playerid, TDMenu_NPC[playerid][12], 2);
	PlayerTextDrawSetProportional(playerid, TDMenu_NPC[playerid][12], 1);
	PlayerTextDrawSetShadow(playerid, TDMenu_NPC[playerid][12], 0);
	PlayerTextDrawSetSelectable(playerid, TDMenu_NPC[playerid][12], true);
}

ShowNPCMenu(playerid)
{
	PlayerTextDrawSetString(playerid,TDMenu_NPC[playerid][2],npcname[playerid]);
    MenuNPC[playerid] = true;
    for(new i; i < 13;i++) PlayerTextDrawShow(playerid,TDMenu_NPC[playerid][i]);
}

HideNPCMenu(playerid)
{
	MenuNPC[playerid] = false;
	for(new i ; i < 13 ; i++) PlayerTextDrawHide(playerid,TDMenu_NPC[playerid][i]);
}

CreateSubMessages(playerid)
{
    TDMsg_Sub[playerid][0] = CreatePlayerTextDraw(playerid, 322.311676, 354.214935, "");
	PlayerTextDrawLetterSize(playerid, TDMsg_Sub[playerid][0], 0.440292, 1.664166);
	PlayerTextDrawAlignment(playerid, TDMsg_Sub[playerid][0], 2);
	PlayerTextDrawColor(playerid, TDMsg_Sub[playerid][0], HexToInt("E2C063FF"));
	PlayerTextDrawSetShadow(playerid, TDMsg_Sub[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, TDMsg_Sub[playerid][0], 1);
	PlayerTextDrawBackgroundColor(playerid, TDMsg_Sub[playerid][0], 255);
	PlayerTextDrawFont(playerid, TDMsg_Sub[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, TDMsg_Sub[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, TDMsg_Sub[playerid][0], 0);

	TDMsg_Sub[playerid][1] = CreatePlayerTextDraw(playerid, 322.311676, 384.616790, "");
	PlayerTextDrawLetterSize(playerid, TDMsg_Sub[playerid][1], 0.440292, 1.664166);
	PlayerTextDrawAlignment(playerid, TDMsg_Sub[playerid][1], 2);
	PlayerTextDrawColor(playerid, TDMsg_Sub[playerid][1], HexToInt("323C7FFF"));
	PlayerTextDrawSetShadow(playerid, TDMsg_Sub[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, TDMsg_Sub[playerid][1], 1);
	PlayerTextDrawBackgroundColor(playerid, TDMsg_Sub[playerid][1], 255);
	PlayerTextDrawFont(playerid, TDMsg_Sub[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, TDMsg_Sub[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, TDMsg_Sub[playerid][1], 0);

	TDMsg_Sub[playerid][2] = CreatePlayerTextDraw(playerid, 322.311676, 415.618682, "");
	PlayerTextDrawLetterSize(playerid, TDMsg_Sub[playerid][2], 0.440292, 1.664166);
	PlayerTextDrawAlignment(playerid, TDMsg_Sub[playerid][2], 2);
	PlayerTextDrawColor(playerid, TDMsg_Sub[playerid][2], HexToInt("B4191DFF"));
	PlayerTextDrawSetShadow(playerid, TDMsg_Sub[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, TDMsg_Sub[playerid][2], 1);
	PlayerTextDrawBackgroundColor(playerid, TDMsg_Sub[playerid][2], 255);
	PlayerTextDrawFont(playerid, TDMsg_Sub[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, TDMsg_Sub[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, TDMsg_Sub[playerid][2], 0);
}

SetWantedLevel(playerid, value)
{
	PlayerInfo[playerid][pEtoiles] = value;
	new INI:File = INI_Open(UserPath(playerid));
	INI_SetTag(File,"data");
	INI_WriteInt(File,"Etoiles",PlayerInfo[playerid][pEtoiles]);
	INI_Close(File);
	SetPlayerWantedLevel(playerid,PlayerInfo[playerid][pEtoiles]);
}

EndRace(playerid)
{
	InRace[playerid] = false;
	DestroyVehicle(vmission[playerid]);
	TogglePlayerControllable(playerid,true);
	SetPlayerVirtualWorld(playerid,0);
	SpawnPlayer(playerid);
	cpplayer[playerid] = 0;
	if(IsRaceLoaded == true) LessPlayerInRace(playerid);
	DisablePlayerRaceCheckpoint(playerid);
}

CreateTDRaceEditor(playerid)
{
	TDRace_Editor[playerid][0] = CreatePlayerTextDraw(playerid, 123.600006, 95.173355, "box");
	PlayerTextDrawLetterSize(playerid, TDRace_Editor[playerid][0], 0.002399, 30.542940);
	PlayerTextDrawTextSize(playerid, TDRace_Editor[playerid][0], 507.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, TDRace_Editor[playerid][0], 1);
	PlayerTextDrawColor(playerid, TDRace_Editor[playerid][0], -1);
	PlayerTextDrawUseBox(playerid, TDRace_Editor[playerid][0], 1);
	PlayerTextDrawBoxColor(playerid, TDRace_Editor[playerid][0], 125);
	PlayerTextDrawSetShadow(playerid, TDRace_Editor[playerid][0], -82);
	PlayerTextDrawSetOutline(playerid, TDRace_Editor[playerid][0], -2);
	PlayerTextDrawBackgroundColor(playerid, TDRace_Editor[playerid][0], 255);
	PlayerTextDrawFont(playerid, TDRace_Editor[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, TDRace_Editor[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, TDRace_Editor[playerid][0], -82);

	TDRace_Editor[playerid][1] = CreatePlayerTextDraw(playerid, 218.000015, 90.693321, "Editeur_de_course");
	PlayerTextDrawLetterSize(playerid, TDRace_Editor[playerid][1], 0.674399, 2.331732);
	PlayerTextDrawAlignment(playerid, TDRace_Editor[playerid][1], 1);
	PlayerTextDrawColor(playerid, TDRace_Editor[playerid][1], -1);
	PlayerTextDrawSetShadow(playerid, TDRace_Editor[playerid][1], 2);
	PlayerTextDrawSetOutline(playerid, TDRace_Editor[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, TDRace_Editor[playerid][1], 255);
	PlayerTextDrawFont(playerid, TDRace_Editor[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, TDRace_Editor[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, TDRace_Editor[playerid][1], 2);

	TDRace_Editor[playerid][2] = CreatePlayerTextDraw(playerid, 310.000152, 131.013336, "");
	PlayerTextDrawLetterSize(playerid, TDRace_Editor[playerid][2], 0.400000, 1.600000);
	PlayerTextDrawTextSize(playerid, TDRace_Editor[playerid][2], 25.0, 320.000000);
	PlayerTextDrawAlignment(playerid, TDRace_Editor[playerid][2], 2);
	PlayerTextDrawColor(playerid, TDRace_Editor[playerid][2], 8388863);
	PlayerTextDrawUseBox(playerid, TDRace_Editor[playerid][2], 1);
	PlayerTextDrawBoxColor(playerid, TDRace_Editor[playerid][2], 150);
	PlayerTextDrawSetShadow(playerid, TDRace_Editor[playerid][2], 2);
	PlayerTextDrawSetOutline(playerid, TDRace_Editor[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, TDRace_Editor[playerid][2], 255);
	PlayerTextDrawFont(playerid, TDRace_Editor[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, TDRace_Editor[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, TDRace_Editor[playerid][2], true);

	TDRace_Editor[playerid][3] = CreatePlayerTextDraw(playerid, 147.399978, 187.853317, "");
	PlayerTextDrawLetterSize(playerid, TDRace_Editor[playerid][3], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TDRace_Editor[playerid][3], 73.000000, 69.000000);
	PlayerTextDrawAlignment(playerid, TDRace_Editor[playerid][3], 1);
	PlayerTextDrawColor(playerid, TDRace_Editor[playerid][3], -1);
	PlayerTextDrawSetShadow(playerid, TDRace_Editor[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, TDRace_Editor[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, TDRace_Editor[playerid][3], 150);
	PlayerTextDrawFont(playerid, TDRace_Editor[playerid][3], 5);
	PlayerTextDrawSetProportional(playerid, TDRace_Editor[playerid][3], 0);
	PlayerTextDrawSetSelectable(playerid, TDRace_Editor[playerid][3], true);
	PlayerTextDrawSetPreviewModel(playerid, TDRace_Editor[playerid][3], 0);
	PlayerTextDrawSetPreviewRot(playerid, TDRace_Editor[playerid][3], 0.000000, -30.000000, 45.000000, 1.000000);

	TDRace_Editor[playerid][4] = CreatePlayerTextDraw(playerid, 186.800018, 257.946655, "Infernus");
	PlayerTextDrawLetterSize(playerid, TDRace_Editor[playerid][4], 0.347198, 1.420799);
	PlayerTextDrawAlignment(playerid, TDRace_Editor[playerid][4], 2);
	PlayerTextDrawColor(playerid, TDRace_Editor[playerid][4], -1);
	PlayerTextDrawSetShadow(playerid, TDRace_Editor[playerid][4], 2);
	PlayerTextDrawSetOutline(playerid, TDRace_Editor[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, TDRace_Editor[playerid][4], 255);
	PlayerTextDrawFont(playerid, TDRace_Editor[playerid][4], 1);
	PlayerTextDrawSetProportional(playerid, TDRace_Editor[playerid][4], 1);

	TDRace_Editor[playerid][5] = CreatePlayerTextDraw(playerid, 290.000000, 190.000000, "Nombre_de_checkpoints_:_36");
	PlayerTextDrawLetterSize(playerid, TDRace_Editor[playerid][5], 0.317598, 1.331199);
	PlayerTextDrawTextSize(playerid, TDRace_Editor[playerid][5], 443.610595, 25.0);
	PlayerTextDrawAlignment(playerid, TDRace_Editor[playerid][5], 1);
	PlayerTextDrawColor(playerid, TDRace_Editor[playerid][5], -1);
	PlayerTextDrawUseBox(playerid, TDRace_Editor[playerid][5], 1);
	PlayerTextDrawBoxColor(playerid, TDRace_Editor[playerid][5], 150);
	PlayerTextDrawSetSelectable(playerid, TDRace_Editor[playerid][5], true);
	PlayerTextDrawSetShadow(playerid, TDRace_Editor[playerid][5], 1);
	PlayerTextDrawSetOutline(playerid, TDRace_Editor[playerid][5], 1);
	PlayerTextDrawBackgroundColor(playerid, TDRace_Editor[playerid][5], 255);
	PlayerTextDrawFont(playerid, TDRace_Editor[playerid][5], 1);
	PlayerTextDrawSetProportional(playerid, TDRace_Editor[playerid][5], 1);


	TDRace_Editor[playerid][6] = CreatePlayerTextDraw(playerid, 291.600036, 220.613433, "Angle_de_depart_:_90");
	PlayerTextDrawLetterSize(playerid, TDRace_Editor[playerid][6], 0.317598, 1.331199);
	PlayerTextDrawTextSize(playerid, TDRace_Editor[playerid][6], 411.000000, 25.0);
	PlayerTextDrawAlignment(playerid, TDRace_Editor[playerid][6], 1);
	PlayerTextDrawColor(playerid, TDRace_Editor[playerid][6], -1);
	PlayerTextDrawUseBox(playerid, TDRace_Editor[playerid][6], 1);
	PlayerTextDrawBoxColor(playerid, TDRace_Editor[playerid][6], 150);
	PlayerTextDrawSetShadow(playerid, TDRace_Editor[playerid][6], -3);
	PlayerTextDrawSetOutline(playerid, TDRace_Editor[playerid][6], 1);
	PlayerTextDrawBackgroundColor(playerid, TDRace_Editor[playerid][6], 255);
	PlayerTextDrawFont(playerid, TDRace_Editor[playerid][6], 1);
	PlayerTextDrawSetProportional(playerid, TDRace_Editor[playerid][6], 1);
	PlayerTextDrawSetSelectable(playerid, TDRace_Editor[playerid][6], true);

	TDRace_Editor[playerid][7] = CreatePlayerTextDraw(playerid, 429.799987, 54.946647, "");
	PlayerTextDrawLetterSize(playerid, TDRace_Editor[playerid][7], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TDRace_Editor[playerid][7], 90.000000, 90.000000);
	PlayerTextDrawAlignment(playerid, TDRace_Editor[playerid][7], 1);
	PlayerTextDrawColor(playerid, TDRace_Editor[playerid][7], -1);
	PlayerTextDrawSetShadow(playerid, TDRace_Editor[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, TDRace_Editor[playerid][7], 0);
	PlayerTextDrawBackgroundColor(playerid, TDRace_Editor[playerid][7], 0);
	PlayerTextDrawFont(playerid, TDRace_Editor[playerid][7], 5);
	PlayerTextDrawSetProportional(playerid, TDRace_Editor[playerid][7], 0);
	PlayerTextDrawSetPreviewModel(playerid, TDRace_Editor[playerid][7], 19307);
	PlayerTextDrawSetPreviewRot(playerid, TDRace_Editor[playerid][7], 0.000000, 0.000000, 0.000000, 1.000000);

	TDRace_Editor[playerid][8] = CreatePlayerTextDraw(playerid, 312.400024, 341.573150, "Quitter");
	PlayerTextDrawLetterSize(playerid, TDRace_Editor[playerid][8], 0.400000, 1.600000);
	PlayerTextDrawTextSize(playerid, TDRace_Editor[playerid][8], 25.0, 220.000000);
	PlayerTextDrawAlignment(playerid, TDRace_Editor[playerid][8], 2);
	PlayerTextDrawColor(playerid, TDRace_Editor[playerid][8], -1);
	PlayerTextDrawUseBox(playerid, TDRace_Editor[playerid][8], 1);
	PlayerTextDrawBoxColor(playerid, TDRace_Editor[playerid][8], 150);
	PlayerTextDrawSetShadow(playerid, TDRace_Editor[playerid][8], 0);
	PlayerTextDrawSetOutline(playerid, TDRace_Editor[playerid][8], 0);
	PlayerTextDrawBackgroundColor(playerid, TDRace_Editor[playerid][8], 255);
	PlayerTextDrawFont(playerid, TDRace_Editor[playerid][8], 2);
	PlayerTextDrawSetProportional(playerid, TDRace_Editor[playerid][8], 1);
	PlayerTextDrawSetSelectable(playerid, TDRace_Editor[playerid][8], true);
}

ShowTDRaceEditor(playerid)
{
	ConvertEncoding(RacePlayer[playerid][RaceName]);
	PlayerTextDrawSetString(playerid,TDRace_Editor[playerid][2],RacePlayer[playerid][RaceName]);
	PlayerTextDrawSetPreviewModel(playerid,TDRace_Editor[playerid][3],RacePlayer[playerid][Model]);
	new string[256];
	format(string,sizeof(string),"Nombre de checkpoints : %d",RacePlayer[playerid][CPMax]);
	PlayerTextDrawSetString(playerid,TDRace_Editor[playerid][5],string);
	format(string,sizeof(string),"Angle de départ : %.2f°",RacePlayer[playerid][Ang]);
	ConvertEncoding(string);
	PlayerTextDrawSetString(playerid,TDRace_Editor[playerid][6],string);
	if(RacePlayer[playerid][Model] < 400) string = "À pied";
	else format(string,sizeof(string),"%s",VehicleNames[RacePlayer[playerid][Model] - 400]);
	ConvertEncoding(string);
	PlayerTextDrawSetString(playerid,TDRace_Editor[playerid][4],string);
	for(new i; i < 9 ; i++) PlayerTextDrawShow(playerid,TDRace_Editor[playerid][i]);
	SelectTextDraw(playerid,RED);
	MenuREditor[playerid] = true;
}

HideTDRaceEditor(playerid)
{
	SendClientMessage(playerid,BLUE,"[ADMIN] Vous pouvez réafficher ce menu en faisant /rmenu !");
	for(new i; i < 9 ; i++) PlayerTextDrawHide(playerid,TDRace_Editor[playerid][i]);
	CancelSelectTextDraw(playerid);
	MenuREditor[playerid] = false;
}

SubMessage(playerid,part,text[],time)
{
	if(part <= 0) return printf("[Error] Invalid Part = %d : \"%s\" Time: %d",part,text,time);
	new index = part - 1;
	KillTimer(subtimer[playerid][index]);
	ConvertEncoding(text);
	PlayerTextDrawSetString(playerid,TDMsg_Sub[playerid][index],text);
	UpdateTXD(playerid,TDMsg_Sub[playerid][index]);
	subtimer[playerid][index] = SetTimerEx("SubTimer",time * 1000,false,"ii",playerid,index);
	return 1;
}

randomEx(min, max)
{
    new rand = random(max-min)+min;
    return rand;
}

IsAdmin(playerid)
{
	if(strfind("[Exo]Jhonny",GetName(playerid),true)==0 || strfind("adrienspy",GetName(playerid),true)==0 || strfind("valen6306",GetName(playerid),true)==0)
	{
	    return 1;
 	}
 	else
 	{
		return 0;
	}
}

NotRankedEnough(playerid)
{
	return SendClientMessage(playerid,RED,"Tu dois être administrateur pour faire cette commande !");
}

ConvertEncoding(string[])
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

HexToInt(string[])
{
    if(!string[0]) return 0;
    new cur = 1, res = 0;
    for(new i = strlen(string); i > 0; i--)
    {
        res += cur * (string[i - 1] - ((string[i - 1] < 58) ? (48) : (55)));
        cur = cur * 16;
    }
    return res;
}

udb_hash(buf[]) {
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

UserPath(playerid)
{
    new string[128],playername[MAX_PLAYER_NAME];
    GetPlayerName(playerid,playername,sizeof(playername));
	format(string,sizeof(string),PATH,playername);
    return string;
}

HousePath(houseid)
{
    new string[128];
    format(string,sizeof(string),HPATH,houseid);
	return string;
}

IsPlayerFree(playerid)
{
	if(mission[playerid] != 0 || SelectItem[playerid] != 0 || robbing[playerid] == true || jbraquage[playerid] == true || skydiving[playerid] == true || InRace[playerid] == true || jailed[playerid] == true
	|| InAmmu[playerid] == true) return false;
	else return true;
}

CommercePath(restoid)
{
    new string[128];
    format(string,sizeof(string),CPATH,restoid);
	return string;
}

BizPath(bizid)
{
    new string[128];
    format(string,sizeof(string),BPATH,bizid);
	return string;
}

LockHouse(playerid,houseid)
{
	HouseInfo[houseid][Lock] = 1;
	SubMessage(playerid,MSG_RED,"Porte verrouillée !", 3);
	PlayerPlaySound(playerid,24600,0,0,0);
	SaveHouse(houseid);
}

HourUpdate()
{
	for(new i; i < MAX_PLAYERS; i++)
	{
		if(PlayerInfo[i][pEtoiles] == 1)
		{
		    SubMessage(i,MSG_YELLOW,"Tu n'es plus recherché !",5);
		}
		PlayerInfo[i][pEtoiles] --;
		if(PlayerInfo[i][pEtoiles] < 0) PlayerInfo[i][pEtoiles] = 0;
		SetWantedLevel(i,PlayerInfo[i][pEtoiles]);
	}

	for(new i; i < MAX_BIZ; i++)
	{
	    if(BizInfo[i][Type] == 2)
	    {
			BizInfo[i][Caisse] += BizInfo[i][Revenus];
			if(BizInfo[i][Caisse] > BizInfo[i][CaisseMax]) BizInfo[i][Caisse] = BizInfo[i][CaisseMax];
		}
	}

	gettime(hour, minute);
   	SetWorldTime(hour);

	new x=0;
	while(x!=MAX_PLAYERS) {
	    if(IsPlayerConnected(x) && GetPlayerState(x) != PLAYER_STATE_NONE) {
	        SetPlayerTime(x,hour,minute);
 		}
		x++;
	}
	
	new next_weather_prob = random(3);
	if(next_weather_prob == 0) 		SetWeather(0);
	else if(next_weather_prob == 1) SetWeather(8);
	else							SetWeather(9);
}

PlayAudioStream(playerid,url[])
{
	StopAudioStreamForPlayer(playerid);
	PlayAudioStreamForPlayer(playerid, url);
}

GameTextForPlayerEx(playerid,text[],time,font)
{
	ConvertEncoding(text);
	GameTextForPlayer(playerid,text,time,font);
	return 1;
}

GameTextForAllEx(text[],time,font)
{
	ConvertEncoding(text);
	GameTextForAll(text,time,font);
	return 1;
}

DisablePlayerCheckpointEx(playerid)
{
	DisablePlayerCheckpoint(playerid);
	SetMarkerMission(playerid);
}

ShowMenuAdmin(playerid)
{
	new string[256];
	format(string,sizeof(string),"Sanctionner %s",GetName(aclickedid[playerid]));
	ShowPlayerDialog(playerid,34,DIALOG_STYLE_LIST,string,"\t\tMute\n\t\tUnmute\n\t\tKick\n\t\tBan\n\t\tFuckup\n\t\tSlap\n\t\tExploser\n\t\tJail\n\t\tUnjail","Choisir","Quitter");
	return 1;
}

ApplyActorAnimationEx(actorid,lib[32],name[32],Float:Delta,loop,lockx,locky,freeze,time)
{
	actlib[actorid] = lib;
	actname[actorid] = name;
	ApplyActorAnimation(actorid,actlib[actorid],actname[actorid],Delta,loop,lockx,locky,freeze,time);
}

CreateNPC(name[], skin, Float:x, Float:y, Float:z, Float:angle, virtualworld, weapon, ammo)
{
	new npcid = FCNPC_Create(name);
	FCNPC_Spawn(npcid,skin,x,y,z);
	FCNPC_SetAngle(npcid, angle);
	FCNPC_SetVirtualWorld(npcid, virtualworld);
	FCNPC_SetWeapon(npcid, weapon);
	FCNPC_SetAmmo(npcid, ammo);
	return npcid;
}

DestroyNPC(npcid)
{
	if(FCNPC_IsValid(npcid)) FCNPC_Destroy(npcid);
}

UnlockHouse(playerid,houseid)
{
	HouseInfo[houseid][Lock] = 0;
	SubMessage(playerid,MSG_BLUE,"Porte déverrouillée !", 3);
	PlayerPlaySound(playerid,24600,0,0,0);
	SaveHouse(houseid);
}

SpawnPlayerEx(playerid)
{
    TogglePlayerSpectating(playerid,false);
	new Float:x,Float:y,Float:z,Float:a;
	if(PlayerInfo[playerid][pMaison]!=-1)
	{
	    x = HouseInfo[PlayerInfo[playerid][pMaison]][X1];
	    y = HouseInfo[PlayerInfo[playerid][pMaison]][Y1];
	    z = HouseInfo[PlayerInfo[playerid][pMaison]][Z1];
	    a = 90.0;
	}
	else
	{
	    x = -2163.0;
		y = 129.5;
		z = 35.0;
		a = 263.3229;
	}
	SetSpawnInfo(playerid,0,PlayerInfo[playerid][pSkin],x,y,z,a,0,0,0,0,0,0);
	SavePlayerWeapons(playerid);
	TogglePlayerControllable(playerid,true);
	SpawnPlayer(playerid);
	return 1;
}

SetPlayerPosEx(playerid,Float:x,Float:y,Float:z,Int,vw)
{
	if(mission[playerid] == 0) LoadChargement(playerid);
	SetPlayerPos(playerid,x,y,z);
	SetPlayerInterior(playerid,Int);
	SetPlayerVirtualWorld(playerid,vw);
}

LoadChargement(playerid)
{
		TogglePlayerControllable(playerid,false);
  		GameTextForPlayerEx(playerid,"~g~CHARGEMENT...",1500,6);
		SetTimerEx("EndChargement",1500,false,"i",playerid);
}

SetPlayerMoney(playerid,ammount)
{
     PlayerInfo[playerid][pCash] = 0;
     GiveMoney(playerid,ammount);
     return 1;
}

GivePlayerBanque(playerid,amount)
{
	if(PlayerInfo[playerid][pBanque] + amount < 0)
	{
		PlayerInfo[playerid][pBanque] = 0;
	}
	else
	{
		PlayerInfo[playerid][pBanque] += amount;
	}
	new INI:File = INI_Open(UserPath(playerid));
	INI_SetTag(File,"data");
	INI_WriteInt(File,"Banque",PlayerInfo[playerid][pBanque]);
	INI_Close(File);
}

GiveMoney(playerid,amount)
{
    printf("[Money] %s a reçu $%d",GetName(playerid),amount);
	PlayerInfo[playerid][pCash]+=amount;
	ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid,PlayerInfo[playerid][pCash]);
 	new INI:UserFile = INI_Open(UserPath(playerid));
    INI_SetTag(UserFile,"data");
	INI_WriteInt(UserFile,"Cash", PlayerInfo[playerid][pCash]);
    INI_Close(UserFile);
}

GiveMoneyBanque(amount)
{
	if(MoneyBanque + amount < 0)
	{
		MoneyBanque = 0;
	}
	else
	{
		MoneyBanque += amount;
	}
	new INI:File = INI_Open(SPATH);
	INI_SetTag(File,"data");
	INI_WriteInt(File,"Argent",MoneyBanque);
	INI_Close(File);
}
GetModelWeapon(weaponid)
{
	new value;
	switch(weaponid)
	{
	    case 1 : value = 331;
	    case 2 .. 8 : value = weaponid + 331;
	    case 9 : value = 341;
	    case 10 .. 15 : value = weaponid + 311;
	    case 16 .. 18 : value = weaponid + 326;
	    case 22 .. 29 : value = weaponid + 324;
	    case 30,31 : value = weaponid + 325;
	    case 32 : value = 372;
	    case 33 .. 45 : value = weaponid + 324;
	    case 46 : value = 371;
	    default : value = 0;
	}
	return value;
}
GiveMoneyResto(amount,type)
{
	new INI:File = INI_Open(SPATH);
	INI_SetTag(File,"data");
	switch(type)
	{
	    case BURGER :
	    {
			if(MoneyResto[BURGER] + amount < 0)
			{
				MoneyResto[BURGER] = 0;
			}
			else
			{
			    MoneyResto[BURGER] += amount;
			}
   	 		INI_WriteInt(File,"Burger",MoneyResto[BURGER]);
		}
  		case PIZZA :
	    {
			if(MoneyResto[PIZZA] + amount < 0)
			{
				MoneyResto[PIZZA] = 0;
			}
			else
			{
			    MoneyResto[PIZZA] += amount;
			}
   	 		INI_WriteInt(File,"Pizza",MoneyResto[PIZZA]);
		}
  		case CLUCKIN :
	    {
			if(MoneyResto[CLUCKIN] + amount < 0)
			{
				MoneyResto[CLUCKIN] = 0;
			}
			else
			{
			    MoneyResto[CLUCKIN] += amount;
			}
   	 		INI_WriteInt(File,"Cluckin",MoneyResto[CLUCKIN]);
		}
	}
	INI_Close(File);
}

ResetData(playerid)
{
    PlayerInfo[playerid][pPass] = 0;
    PlayerInfo[playerid][pCash] = 0;
	PlayerInfo[playerid][pNum] = 0;
	PlayerInfo[playerid][pContacts] = 0;
	PlayerInfo[playerid][pTuto] = false;
	PlayerInfo[playerid][pMaison] = -1;
	PlayerInfo[playerid][pBanque] = 0;
	PlayerInfo[playerid][pCarte] = false;
	PlayerInfo[playerid][pSkin] = 101;
	PlayerInfo[playerid][pLoyer] = 0;
	PlayerInfo[playerid][pLevel] = 0;
	PlayerInfo[playerid][pBan] = false;
	PlayerInfo[playerid][pBiz] = -1;
	PlayerInfo[playerid][p9mm] = 0;
	PlayerInfo[playerid][pS9mm] = 0;
	PlayerInfo[playerid][pEagle] = 0;
	PlayerInfo[playerid][pUzi] = 0;
	PlayerInfo[playerid][pTec9] = 0;
	PlayerInfo[playerid][pRifle] = 0;
	PlayerInfo[playerid][pShotgun] = 0;
	PlayerInfo[playerid][pSawnoff] = 0;
	PlayerInfo[playerid][pCShotgun] = 0;
	PlayerInfo[playerid][pMp5] = 0;
	PlayerInfo[playerid][pM4] = 0;
	PlayerInfo[playerid][pAk47] = 0;
	VehicleInfo[playerid][Model] = 0;
	NPCInfo[playerid][FollowID] = -1;
	NPCInfo[playerid][FocusID] = -1;
	for(new i; i< MAX_SLOTS;i++) PickupTaken[playerid][i] = false;
}

CreateMoneyPickup(Float:x,Float:y,Float:z,amount,vw,interior)
{
	new pcash;
	pcash = CreateDynamicPickup(1212,2,x+2,y+2,z,vw,interior,-1,-1);
	PickupMoney[pcash] = amount;
}

GivePlayerSkin(playerid,skin)
{
	PlayerInfo[playerid][pSkin] = skin;
	SetPlayerSkin(playerid,skin);
	new INI:File = INI_Open(UserPath(playerid));
	INI_SetTag(File,"data");
	INI_WriteInt(File,"Skin",PlayerInfo[playerid][pSkin]);
	INI_Close(File);
}

IsPosRace(playerid)
{
	for(new i=1; i < 800; i ++)
	{
	    if(IsPlayerInRangeOfPoint(playerid,5.0,PosRace[i][0],PosRace[i][1],PosRace[i][2])) return true;
	}
	return false;
}

IsValidSkin( skinid )
{
	if( skinid == 74 || skinid > 311 || skinid < 0 )
	    return 0;

	return 1;
}

GetName(playerid)
{
	new Name[MAX_PLAYER_NAME];
	GetPlayerName(playerid,Name,sizeof(Name));
	return Name;
}

GetPlayerID(playername[])
{
	for(new i = 0; i <= MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			new playername2[MAX_PLAYER_NAME];
			GetPlayerName(i, playername2, sizeof(playername2));
			if(strcmp(playername2, playername, true, strlen(playername)) == 0) return i;
		}
	}
	return INVALID_PLAYER_ID;
}

GetVehicleName(modelid)
{
	new String[32];
	format(String,sizeof(String),"%s",VehicleNames[modelid - 400]);
	return String;
}

GetVehicleModelByName(name[])
{
	new model = 0;
	for(new i; i < 212; i++)
	{
	    if(strfind(VehicleNames[i],name,true) != -1)
	    {
	        model = i + 400;
	        break;
		}
	}
	return model;
}

// GET DISTANCE BETWEEN TWO POINTS
Float: GetAxeDistance(Float: f1, Float: f2)
{
	return floatabs( floatsub(f1,f2) );
}

Float:GetDistance( Float:x1, Float:y1, Float:z1, Float:x2, Float:y2, Float:z2 )
{
	new Float:distance = floatsqroot( floatpower( (x1 - x2),2) + floatpower( (y1 - y2), 2) + floatpower( (z1 - z2), 2) );
	return distance;
}

/*
Float:CalculDistanceBetweenCP()
{
	new Float:distance;
	for(new i=1; i < CpRace ; i++)
	{
		distance += GetDistance(PosRace[i][0],PosRace[i][1],PosRace[i][2],PosRace[i + 1][0],PosRace[i + 1][1],PosRace[i + 1][2]);
	}
	return distance;
}
*/

GetPlayerSpeed(playerid, get3d)
{
	new Float:x, Float:y, Float:z;
	if(IsPlayerInAnyVehicle(playerid))
	    GetVehicleVelocity(GetPlayerVehicleID(playerid), x, y, z);
	else
	    GetPlayerVelocity(playerid, x, y, z);

	return SpeedCheck(x, y, z, 100.0, get3d);
}

IsPlayerAtVendingMachine(playerid) {
	for (new i = 0; i != sizeof(VENDING_MACHINES); ++i) {
		if (IsPlayerInRangeOfPoint(playerid, VENDING_MACHINE_RANGE, VENDING_MACHINES[i][0], VENDING_MACHINES[i][1], VENDING_MACHINES[i][2])) {
			return true;
		}
	}
	return false;
}

GetClosestResto(playerid)
{
	new Float:distance = 9999,Float:temp,Float:x,Float:y,Float:z,current = -1;

	for(new i = 0;i<MAXRESTOS;i++)
	{
		x = PosRestos[i][0];
		y = PosRestos[i][1];
		z = PosRestos[i][2];
		temp = GetPlayerDistanceFromPoint(playerid,x,y,z);
		if(temp < distance)
		{
				distance = temp;
				current = i;
		}
	}
	return current;
}

GetClosestAtm(playerid)
{
	new Float:distance = 9999,Float:temp,Float:x,Float:y,Float:z,current = -1;

	for(new i = 0;i<NBATM;i++)
	{
		x = PosAtm[i][0];
		y = PosAtm[i][1];
		z = PosAtm[i][2];
		temp = GetPlayerDistanceFromPoint(playerid,x,y,z);
		if(temp < distance)
		{
				distance = temp;
				current = i;
		}
	}
	return current;
}

GetClosestAmmu(playerid)
{
	new Float:distance = 9999,Float:temp,Float:x,Float:y,Float:z,current = -1;
	for(new i = 0;i<MAX_AMMU;i++)
	{
		x = PosAmmu[i][0];
		y = PosAmmu[i][1];
		z = PosAmmu[i][2];
		temp = GetPlayerDistanceFromPoint(playerid,x,y,z);
		if(temp < distance)
		{
				distance = temp;
				current = i;
		}
	}
	return current;
}

GetClosestBar(playerid)
{
	new Float:distance = 9999,Float:temp,Float:x,Float:y,Float:z,current = -1;
	for(new i = 0;i<MAX_BAR;i++)
	{
		x = PosBar[i][0];
		y = PosBar[i][1];
		z = PosBar[i][2];
		temp = GetPlayerDistanceFromPoint(playerid,x,y,z);
		if(temp < distance)
		{
				distance = temp;
				current = i;
		}
	}
	return current;
}

IsValidAmmuWeapon(playerid)
{
	for(new i;i<TOTAL_AMMU;i++)
	{
		if(GetPlayerWeapon(playerid) == ItemWeapon[i])
		{
		    return 1;
		}
  	}
  	return 0;
}

IsPlayerInCommerceBraq(playerid)
{
	for(new i; i < MAX_RESTOS ; i++)
	{
		if(IsPlayerInRangeOfPoint(playerid,2.0,CpBraq[i][0],CpBraq[i][1],CpBraq[i][2])) return true;
	}
	return false;
}

StartBraquage(playerid,type)
{
	SubMessage(playerid,MSG_BLUE,"Le braquage du commerce a commencé !", 5);
	SubMessage(playerid,MSG_YELLOW,"Reste pendant 10 secondes dans le checkpoint afin de dévaliser le commerce !", 10);
	SetPlayerCheckpoint(playerid,CpBraq[type][0],CpBraq[type][1],CpBraq[type][2],2.0);
	cbraquage[playerid] = type;
}

EndBraquage()
{
	braquage = false;
	ClearActorAnimations(bactor);
	for(new i;i<2;i++)
	{
		jbraquage[braqueur[i]] = false;
		role[braqueur[i]] = false;
		DisablePlayerCheckpointEx(braqueur[i]);
		RemovePlayerAttachedObject(braqueur[i],9);
	}
	KillTimer(tbraquage);
}

EndCommBraquage(playerid)
{
	DisablePlayerCheckpointEx(playerid);
	cprob[playerid] = -1;
	cbraquage[playerid] = -1;
}

SendAdminMessage(color,text[])
{
	for(new i;i<MAX_PLAYERS;i++) if(IsPlayerConnected(i) && IsAdmin(i))
	{
		SendClientMessage(i,color,text);
	}
	return 1;
}

SetDialogMessage(playerid,txt[])
{
	ConvertEncoding(txt);
	PlayerTextDrawSetString(playerid,TD_Dialog[playerid],txt);
	UpdateTXD(playerid,TD_Dialog[playerid]);
}

SetMissionObj(playerid,txt[])
{
	ConvertEncoding(txt);
	PlayerTextDrawSetString(playerid,TD_Obj[playerid],txt);
	UpdateTXD(playerid,TD_Obj[playerid]);
}

StartMission(playerid, missionid)
{
	RemovePlayerMapIcon(playerid,52);
	if(missionid < 300) SetPlayerVirtualWorld(playerid, playerid+1);
	mission[playerid] = missionid;
	SetPlayerSkin(playerid, 101);
	switch(missionid)
	{
	    case 1 :
		{
		    MTD(playerid,"Un vieil ami...",1,true);
		    vmission[playerid] = CreateVehicle(475,-1995.7245,134.1081,27.4311,177.9305,36,36,-1,0);
   			SetVehicleParamsEx(vmission[playerid], 1, 0, 0, 0, 0, 0, 1);
		    SetVehicleVirtualWorld(vmission[playerid],GetPlayerVirtualWorld(playerid));
		}
		case 2 :
		{
			MTD(playerid,"Les docks",2,true);
  	 		SetPlayerCameraPos(playerid, -2163.0874, 642.1738, 1058.9799);
			SetPlayerCameraLookAt(playerid, -2163.9917, 642.6017, 1058.6449);
			new string[MAX_PLAYER_NAME];
			format(string, sizeof(string), "FL_%d", GetPlayerVirtualWorld(playerid));
			FL[playerid] = CreateNPC(string, 68,-2165.85, 644.13, 1057.59, 126.57,GetPlayerVirtualWorld(playerid),0,0);
		}
		case 3 :
		{
			MTD(playerid,"Pas de pot à l'entrepôt",3,true);
  	 		SetPlayerCameraPos(playerid, -2163.0874, 642.1738, 1058.9799);
			SetPlayerCameraLookAt(playerid, -2163.9917, 642.6017, 1058.6449);
			new string[MAX_PLAYER_NAME];
			format(string, sizeof(string), "FL_%d", GetPlayerVirtualWorld(playerid));
			FL[playerid] = CreateNPC(string, 68,-2165.85, 644.13, 1057.59, 126.57,GetPlayerVirtualWorld(playerid),0,0);
		}
		case 4 :
		{
			MTD(playerid,"Nouveau boss pour une nouvelle vie",4,true);
  	 		SetPlayerCameraPos(playerid, -2163.0874, 642.1738, 1058.9799);
			SetPlayerCameraLookAt(playerid, -2163.9917, 642.6017, 1058.6449);
			new string[MAX_PLAYER_NAME];
			format(string, sizeof(string), "AM_%d", GetPlayerVirtualWorld(playerid));
			AM[playerid] = CreateNPC(string,113,-2165.85, 644.13, 1057.59, 126.57,GetPlayerVirtualWorld(playerid),0,0);
		}
		case 5 :
		{
			MTD(playerid,"Fini les conneries",5,true);
 			SetPlayerCameraPos(playerid, -2023.3724, -51.4528, 43.0261);
			SetPlayerCameraLookAt(playerid, -2023.8196, -50.5540, 42.6012);
			new string[MAX_PLAYER_NAME];
			format(string, sizeof(string), "MC_%d", GetPlayerVirtualWorld(playerid));
			MC[playerid] = CreateNPC(string,119, -2027.75, -40.9, 38.8,184.0, GetPlayerVirtualWorld(playerid),0,0);
		}
		case 6 :
		{
			if(PlayerInfo[playerid][pNum]==0)
			{
				mission[playerid] = 0;
				SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
				TogglePlayerControllable(playerid,true);
 				GameTextForPlayerEx(playerid, "~r~Il te faut un numéro !", 6000, 0);
 				SetPlayerPos(playerid,-2235.40,329.61,35.3);
 				SetMarkerMission(playerid);
 				SetPlayerVirtualWorld(playerid,0);
 				return 1;
			}
			else
			{
				MTD(playerid,"Une affaire de familles",6,true);
			}
		}
		case 7 :
		{
			MTD(playerid,"Pays d'opportunités",7,true);
   			SetPlayerPosEx(playerid,POSINTERIOR,1,GetPlayerVirtualWorld(playerid));
  	 		SetPlayerCameraPos(playerid, -2163.0874, 642.1738, 1058.9799);
			SetPlayerCameraLookAt(playerid, -2163.9917, 642.6017, 1058.6449);
			new string[MAX_PLAYER_NAME];
			format(string, sizeof(string), "AM_%d", GetPlayerVirtualWorld(playerid));
			AM[playerid] = CreateNPC(string,113,-2165.85, 644.13, 1057.59, 126.57,GetPlayerVirtualWorld(playerid),0,0);
		}
		case 8 :
		{
			MTD(playerid,"Stranger Things",8,true);
			SetPlayerCameraPos(playerid, 404.6475, 2531.2395, 20.1033);
			SetPlayerCameraLookAt(playerid, 404.4013, 2532.2126, 19.7784);
			SetPlayerPosEx(playerid, 402.4,2538.0,16.5,0,playerid+1);
			SetPlayerFacingAngle(playerid, 60.0);
			new string[MAX_PLAYER_NAME];
			format(string, sizeof(string), "MC_%d", GetPlayerVirtualWorld(playerid));
			MC[playerid] = CreateNPC(string,119, 400.3, 2539.25, 16.5,240.0, GetPlayerVirtualWorld(playerid),0,0);
		}
		case 9 :
		{
			MTD(playerid,"L'amitié c'est magique",9,true);
			SetPlayerCameraPos(playerid, 404.6475, 2531.2395, 20.1033);
			SetPlayerCameraLookAt(playerid, 404.4013, 2532.2126, 19.7784);
			SetPlayerPosEx(playerid, 402.4,2538.0,16.5,0,playerid+1);
			SetPlayerFacingAngle(playerid, 60.0);
			new string[MAX_PLAYER_NAME];
			format(string, sizeof(string), "MC_%d", GetPlayerVirtualWorld(playerid));
			MC[playerid] = CreateNPC(string,119, 400.3, 2539.25, 16.5,240.0, GetPlayerVirtualWorld(playerid),0,0);
		}
		case 10 :
		{
			MTD(playerid,"Pineapple, leave your pen !",10,true);
			SetPlayerPosEx(playerid, 402.4,2538.0,16.5,0,playerid+1);
   			vmission[playerid] = CreateVehicle(475,400.0,2535.0,16.0,140.0,36,36,-1,0);
			SetVehicleParamsEx(vmission[playerid], 1, 0, 0, 0, 0, 0, 1);
   			SetVehicleVirtualWorld(vmission[playerid],GetPlayerVirtualWorld(playerid));
		}


		case 101 :
		{
			new string[MAX_PLAYER_NAME];
			format(string, sizeof(string), "PE_%d", GetPlayerVirtualWorld(playerid));
			ConnectNPC(string, "PE");
			format(string, sizeof(string), "PG_%d", GetPlayerVirtualWorld(playerid));
			ConnectNPC(string, "PG");
			MTD(playerid,"Mini-Jeu:~n~Poursuite",101,true);

	    	vennemy[playerid] = CreateVehicle(415,-2457.7,-118.5,26.0,-90.0,-1,-1,-1,0);
	    	vhealth[vennemy[playerid]] = 1000;
		    SetVehicleVirtualWorld(vennemy[playerid],GetPlayerVirtualWorld(playerid));
	    	vmission[playerid] = CreateVehicle(597,-2457.7,-118.5,26.0,-90.0,-1,-1,-1,0);
	    	vhealth[vmission[playerid]] = 1000;
		    SetVehicleVirtualWorld(vmission[playerid],GetPlayerVirtualWorld(playerid));
		}
		case 300:
		{
			gettime(hour, minute);
			if(hour >= 23 || hour <= 8)
			{
				StartDialog(playerid, 300);
			}
			else
			{
				StartDialog(playerid, 301);
				MTD(playerid, "Sortie avec Matthew", 301, true);
			    new Float:x, Float:y, Float:z, Float:a;
			    GetPlayerPos(playerid, x,y,z);
			    GetPlayerFacingAngle(playerid, a);
				SetPlayerVirtualWorld(playerid, playerid+1);
				if(!IsPlayerInAnyVehicle(playerid))
			    {
					vmission[playerid] = CreateVehicle(475,x,y,z,a,36,36,-1,0);
				   	SetVehicleParamsEx(vmission[playerid], 1, 0, 0, 0, 0, 0, 0);
				    SetVehicleVirtualWorld(vmission[playerid],GetPlayerVirtualWorld(playerid));
		 			PutPlayerInVehicle(playerid, vmission[playerid], 0);
				}
				else
				{
			    	SetVehicleVirtualWorld(GetPlayerVehicleID(playerid),playerid+1);
		 			PutPlayerInVehicle(playerid, GetPlayerVehicleID(playerid), 0);
				}
			}
		}
	}
	printf("[Mission] %s débute la mission %d",GetName(playerid),missionid);
	return 1;
}

FailMission(playerid)
{
 	GameTextForPlayerEx(playerid, "~r~Échec de la mission !", 5000, 0);
	PlayAudioStream(playerid, "http://xdev-team.tk/creations/sao/Audio/Wasted.mp3");
	TogglePlayerControllable(playerid,true);
	if(mission[playerid] > 0 && mission[playerid] < 50) AlreadyDone[playerid][mission[playerid]] = true;
	PressN[playerid] = false;
	if(mission[playerid] == 3)
	{
		for(new i = 0;i<6;i++) DestroyNPC(maf[playerid][i]);
		mafkilled[playerid] = 0;
	}

	if(mission[playerid] == 6)
	{

		if(IsPlayerNPC(AME[playerid])) Kick(AME[playerid]);
		if(IsPlayerNPC(AMG[playerid])) Kick(AMG[playerid]);
		SetPlayerAmmo(playerid, 30, 0);
	}

	if(mission[playerid] == 7)
	{
		Kick(RE[playerid][0]);
		for(new i = 1; i < 4 ; i++)	DestroyNPC(RE[playerid][i]);
	}

	if(mission[playerid] == 101)
	{
		if(IsPlayerNPC(PG[playerid])) Kick(PG[playerid]);
		if(IsPlayerNPC(PE[playerid])) Kick(PE[playerid]);
		SetPlayerAmmo(playerid, 30, 0);
	}
	DestroyNPC(FL[playerid]);
	DestroyNPC(AM[playerid]);
	DestroyNPC(MC[playerid]);
	DestroyNPC(VH[playerid]);

	havebox[playerid] = false;
	countdia[playerid] = 0;
	mission[playerid] = 0;
	KillTimer(timedialog[playerid]);
	PlayerTextDrawHide(playerid,TD_Obj[playerid]);
	PlayerTextDrawHide(playerid,TD_Dialog[playerid]);
	if(IsValidVehicle(vmission[playerid])) DestroyVehicle(vmission[playerid]);
	if(IsValidVehicle(vennemy[playerid])) DestroyVehicle(vennemy[playerid]);
	if(IsValidVehicle(jvehicle[playerid]))
	{
		SetVehicleToRespawn(jvehicle[playerid]);
		SetVehicleVirtualWorld(jvehicle[playerid], 0);
	}
	SetPlayerVirtualWorld(playerid,0);
	SetCameraBehindPlayer(playerid);
	DisablePlayerCheckpointEx(playerid);
}

IsPosRobHouse(playerid)
{
	new Float:x,Float:y,Float:z;
	GetPlayerPos(playerid,x,y,z);
	for(new i; i < MAX_HOUSES; i++)
	{
	    if(HouseInfo[i][Type] == 2 && i != PlayerInfo[playerid][pMaison])
	    {
	        if(IsPlayerInRangeOfPoint(playerid,2.0,HouseInfo[i][cX],HouseInfo[i][cY],HouseInfo[i][cZ]))
	        {
	            return true;
			}
		}
	}
	return false;
}

EndAmmu(playerid)
{
	new string[256],amount;
	switch(ammulvl[playerid] - 1)
	{
		case 4: amount = 500;
		case 5: amount = 1000;
		case 6: amount = 1500;
	}
 	if((ammulvl[playerid] - 1) >=4)
	{
	 	format(string,sizeof(string),"Tu as atteint le niveau ~w~%d ~b~! Tu remportes ~w~$%d ~b~!",ammulvl[playerid] - 1,amount);
		SubMessage(playerid,MSG_BLUE,string, 5);
	}
    SetPlayerPosEx(playerid,AMMU_STAND,1,5);
    InAmmu[playerid] = false;
	CabineOccuped[cabine[playerid]] = false;
	ResetPlayerWeapons(playerid);
	GivePlayerMoney(playerid, amount);
	DestroyPlayerObject(playerid,atarget[playerid]);
	SetPlayerDrunkLevel(playerid,0);
}

EndMission(playerid,missionid)
{
	switch(missionid)
	{
 		case 1:
	    {
			SubMessage(playerid,MSG_BLUE,"Mission n°1 réussie ! 'Un vieil ami'", 5);
			GameTextForPlayerEx(playerid,"~y~Mission réussie~n~~w~LEVEL: +",5000,0);
			PlayerTextDrawHide(playerid,TD_Dialog[playerid]);
			new dlgstring[512];
		    strcat(dlgstring,"Les levels te permettront de débloquer des aptitudes spéciales comme d'apparaître avec un gilet pare-balles\n");
		    strcat(dlgstring,"ou d'avoir un véhicule plus résistant mais aussi débloquer des mini-jeux après certaines missions (Par exemple, débloquer le\n");
		    strcat(dlgstring,"mini-jeu \"Fusillade\" après une mission qui en contient une). Plus tu avances dans l'histoire, plus tu débloques de fonctionnalités.\n");
			ShowPlayerDialog(playerid,30000,DIALOG_STYLE_MSGBOX,"Les niveaux",dlgstring,"OK","");
		}
		case 2:
		{
			SubMessage(playerid,MSG_BLUE,"Mission n°2 réussie ! 'Les docks'", 5);
			GameTextForPlayerEx(playerid,"~y~Mission réussie~n~~w~LEVEL: +",5000,0);
		    DestroyDynamicObject(cobject[playerid]);
		    caisses[playerid] = 0;
		}
		case 3:
		{
			SubMessage(playerid,MSG_BLUE,"Mission n°3 réussie ! 'Pas de pot à l'entrepôt'", 5);
            GameTextForPlayerEx(playerid,"~y~Mission réussie~n~~w~LEVEL: +~n~$3000",5000,0);
			GiveMoney(playerid, 3000);
			mafkilled[playerid] = 0;
		}
		case 4:
		{
			SubMessage(playerid,MSG_BLUE,"Mission n°4 réussie ! 'Nouveau boss pour une nouvelle vie'", 5);
			GameTextForPlayerEx(playerid,"~y~Mission réussie~n~~w~LEVEL: +~n~$1000",5000,0);
			GiveMoney(playerid, 1000);
			PlayerTextDrawHide(playerid,TD_Dialog[playerid]);
			SetPlayerPosEx(playerid,POSMISSION2,0,0);
		}
		case 5:
		{
			SubMessage(playerid,MSG_BLUE,"Mission n°5 réussie ! 'Fini les conneries'", 5);
			PlayerTextDrawHide(playerid,TD_Dialog[playerid]);
			SetPlayerPosEx(playerid,POSMISSION1,0,0);
			GameTextForPlayerEx(playerid,"~y~Mission réussie~n~~w~LEVEL: +",5000,0);
		}
		case 6:
		{
			SubMessage(playerid,MSG_BLUE,"Mission n°6 réussie ! 'Une affaire de familles'", 5);
			GameTextForPlayerEx(playerid,"~y~Mission réussie~n~~w~LEVEL: +~n~$1000",5000,0);
			GiveMoney(playerid, 1000);

			new dlgstring[512];
		    strcat(dlgstring,"Félicitations ! Tu as débloqué le mini-jeu \"Poursuite\" ! Regardes ta map pour le trouver !\n");
			ShowPlayerDialog(playerid,30000,DIALOG_STYLE_MSGBOX,"Mini-Jeu débloqué",dlgstring,"OK","");

			Kick(AME[playerid]);
			Kick(AMG[playerid]);
		}
		case 7:
		{
			SubMessage(playerid,MSG_BLUE,"Mission n°7 réussie ! 'Pays d'opportunités'", 5);
			GameTextForPlayerEx(playerid,"~y~Mission réussie~n~~w~LEVEL: +~n~$500",5000,0);
			GiveMoney(playerid, 500);
		}
		case 8:
		{
			SubMessage(playerid,MSG_BLUE,"Mission n°8 réussie ! 'Stranger Things'", 5);
			GameTextForPlayerEx(playerid,"~y~Mission réussie~n~~w~LEVEL: +~n~$500",5000,0);
			GiveMoney(playerid, 500);
		}
		case 9:
		{
			SubMessage(playerid,MSG_BLUE,"Mission n°9 réussie ! 'L'amitié c'est magique'", 5);
			GameTextForPlayerEx(playerid,"~y~Mission réussie~n~~w~LEVEL: +~n~$500",5000,0);
			GiveMoney(playerid, 500);
   			SetPlayerDrunkLevel (playerid, 0);
		}
		case 10:
		{
			SubMessage(playerid,MSG_BLUE,"Mission n°10 réussie ! 'Pineapple, connect yourself'", 5);
			GameTextForPlayerEx(playerid,"~y~Mission réussie~n~~w~LEVEL: +~n~$500",5000,0);
			GiveMoney(playerid, 500);
		    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
		    RemovePlayerAttachedObject(playerid, 4);
		}

		case 101:
		{
			SubMessage(playerid,MSG_BLUE,"Mini-Jeu terminé ! 'Poursuite'", 5);
			GameTextForPlayerEx(playerid,"~y~Mission réussie~n~~w~$300",5000,0);
			GiveMoney(playerid, 300);
			DestroyNPC(PG[playerid]);
			DestroyNPC(PE[playerid]);
		}
		case 300:
		{
			SubMessage(playerid,MSG_RED,"Matthew dort encore ! Rappelle-le plus tard !", 5);
	 		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
			RemovePlayerAttachedObject(playerid, 4);
		}
		case 301:
		{
			SubMessage(playerid,MSG_BLUE,"Matthew s'est bien amusé ! Pense à l'appeler régulièrement pour recommencer !", 5);
		}
	}

	if(mission[playerid] < 300)
	{
		PlayAudioStream(playerid, "http://xdev-team.tk/creations/sao/Audio/VC-Miscom.mp3");
	}
	if(mission[playerid] <= 100)
	{
		new string[256];
		GivePlayerLevel(playerid,1);
		format(string,sizeof(string),"Tu es maintenant niveau %d !",PlayerInfo[playerid][pLevel]);
		SubMessage(playerid,MSG_YELLOW,string, 5);
	}
	PressN[playerid] = false;
	havebox[playerid] = false;
	countdia[playerid] = 0;
	mission[playerid] = 0;
	DestroyNPC(MC[playerid]);
	DestroyNPC(AM[playerid]);
	DestroyNPC(FL[playerid]);
	DestroyNPC(VH[playerid]);
	KillTimer(timedialog[playerid]);
	PlayerTextDrawHide(playerid,TD_Obj[playerid]);
	PlayerTextDrawHide(playerid,TD_Dialog[playerid]);
	if(IsValidVehicle(vmission[playerid])) DestroyVehicle(vmission[playerid]);
	if(IsValidVehicle(vennemy[playerid])) DestroyVehicle(vennemy[playerid]);
	if(IsValidVehicle(jvehicle[playerid]))
	{
		SetVehicleToRespawn(jvehicle[playerid]);
		SetVehicleVirtualWorld(jvehicle[playerid], 0);
	}
	SetPlayerVirtualWorld(playerid,0);
	SetCameraBehindPlayer(playerid);
	TogglePlayerControllable(playerid, true);
	ClearAnimations(playerid);
	DisablePlayerCheckpointEx(playerid);
	SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
}

SetMarkerMission(playerid)
{
	RemovePlayerMapIcon(playerid,51);
	if(PlayerInfo[playerid][pLevel] >= 6) SetPlayerMapIcon(playerid,52,PURSUIT,55,0xFFFFFF00,MAPICON_LOCAL_CHECKPOINT); // MJ PURSUIT
	switch(PlayerInfo[playerid][pLevel])
	{
	    case 0: MCP(playerid,POSMISSION1,1);
	    case 1: MCP(playerid,POSMISSION2,2);
	    case 2: MCP(playerid,POSMISSION3,3);
	    case 3: MCP(playerid,POSMISSION2,4);
	    case 4: MCP(playerid,POSDOHERTY,5);
	    case 5: MCP(playerid,POSMISSION2,6);
	    case 6: MCP(playerid,POSMISSION2,7);
	    case 7: MCP(playerid,POSMISSION8,8);
	    case 8: MCP(playerid,POSMISSION8,9);
	    case 9: MCP(playerid,POSMISSION8,10);
	}
}

MCP(playerid, Float:x, Float:y, Float:z, missionid)
{
	new marker[MAX_PLAYER_NAME];
	switch(missionid)
	{
	    case 1: marker[playerid] = 37; //?
	    case 2,3: marker[playerid] = 58; //BLUE GUY
	    case 4: marker[playerid] = 59; //VIOLET GUY
	    case 5: marker[playerid] = 26; //MC
	    case 6:
		{
			marker[playerid] = 59; //VIOLET GUY
		}
		case 7: marker[playerid] = 59; //VIOLET GUY
		case 8: marker[playerid] = 26; //MC
		case 9: marker[playerid] = 26; //MC
		case 10: marker[playerid] = 26; //MC
	}
	SetPlayerMapIcon(playerid,51,x,y,z,marker[playerid],GREEN,MAPICON_GLOBAL_CHECKPOINT);
}

MTD(playerid, text[],missionid,bool:fadeout)
{
	ConvertEncoding(text);
	PlayerTextDrawSetString(playerid,TD_Fade[playerid][1],text);
	TogglePlayerControllable(playerid, false);
	if(fadeout == true)
	{
		ftimer[playerid] = SetTimerEx("FadeOut", 200, true, "id", playerid,missionid);
	}
	else
	{
	    ftimer[playerid] = SetTimerEx("Fade",200,true,"id",playerid,missionid);
	}
}

UpdateTXD(playerid, PlayerText:txd)
{
	PlayerTextDrawHide(playerid,txd);
	PlayerTextDrawShow(playerid,txd);
}

StartDialog(playerid,missionid)
{
	if(missionid < 300)
	{
		TogglePlayerControllable(playerid,false);
		ClearAnimations(playerid);
	}
	if(missionid > 0 && missionid < 50)
	{
		if(AlreadyDone[playerid][missionid] == true)
		{
		    SetMissionObj(playerid,"Appuie sur N pour passer la cinématique");
		}
	}
	switch(missionid)
	{
 		case 1 :
 		{
 			SetPlayerCameraPos(playerid, -2023.3724, -51.4528, 43.0261);
			SetPlayerCameraLookAt(playerid, -2023.8196, -50.5540, 42.6012);
		}
 		case 6 :
	 	{
		 	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
		 	SetPlayerAttachedObject(playerid, 0, 18872, 6, 0.1, 0.0, 0.0, 90.0, 180.0, 0.0, 1, 1, 1);
			PlayerPlaySound(playerid,23000,0.0,0.0,0.0);
		}
		case 10 :
		{
			SetPlayerCameraPos(playerid, 404.6475, 2531.2395, 20.1033);
			SetPlayerCameraLookAt(playerid, 404.4013, 2532.2126, 19.7784);
			SetPlayerPosEx(playerid, 402.4,2538.0,16.5,0,playerid+1);
			SetPlayerFacingAngle(playerid, 60.0);
			new string[MAX_PLAYER_NAME];
			format(string, sizeof(string), "MC_%d", GetPlayerVirtualWorld(playerid));
			MC[playerid] = CreateNPC(string,119, 400.3, 2539.25, 16.5,240.0, GetPlayerVirtualWorld(playerid),0,0);
		}

 		case 205 :
	 	{
		 	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
		 	SetPlayerAttachedObject(playerid, 0, 18872, 6, 0.1, 0.0, 0.0, 90.0, 180.0, 0.0, 1, 1, 1);
			PlayerPlaySound(playerid,23000,0.0,0.0,0.0);
		}
		case 300:
		{
		 	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
		 	SetPlayerAttachedObject(playerid, 0, 18872, 6, 0.1, 0.0, 0.0, 90.0, 180.0, 0.0, 1, 1, 1);
		}
	}
	TimeDialogMission(playerid,missionid);
}

StartSkydive(playerid,id)
{
	SetPlayerPosEx(playerid,SkyDiveAir[id][0],SkyDiveAir[id][1],SkyDiveAir[id][2],0,0);
	SetPlayerCheckpoint(playerid,SkyDiveCP[id][0],SkyDiveCP[id][1],SkyDiveCP[id][2],2.0);
	GivePlayerWeapon(playerid,46,1);
	SetTimerEx("TimeSkydive",10000,false,"i",playerid);
	SubMessage(playerid,MSG_YELLOW,"Sautez et atterrissez sur le ~w~checkpoint ~y~indiqué sur votre mini-map.", 5);
}

IsPosSkydive(playerid)
{
	new value = -1;
	for(new i;i<MAX_SKYDIVE;i++)
	{
	    if(IsPlayerInRangeOfPoint(playerid,4.0,SkyDiveSol[i][0],SkyDiveSol[i][1],SkyDiveSol[i][2]))
	    {
			value = i;
			break;
		}
	}
	return value;
}

IsPosSkydiveCP(playerid)
{
	new value = -1;
	for(new i;i<MAX_SKYDIVE;i++)
	{
		 if(IsPlayerInRangeOfPoint(playerid,2.0,SkyDiveCP[i][0],SkyDiveCP[i][1],SkyDiveCP[i][2]))
		{
		value = i;
		break;
		}
	}
	return value;
}

GetXYBehindVehicle(vehicleid, &Float:q, &Float:w, Float:distance)
{
	new Float:a;
	GetVehiclePos(vehicleid, q, w, a);
	GetVehicleZAngle(vehicleid, a);
	q += (distance * -floatsin(-a, degrees));
	w += (distance * -floatcos(-a, degrees));
}

GetPosBehindVehicle(vehicleid, &Float:x, &Float:y, &Float:z, Float:offset=0.5)
{
	new Float:vehicleSize[3], Float:vehiclePos[3];
	GetVehiclePos(vehicleid, vehiclePos[0], vehiclePos[1], vehiclePos[2]);
	GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_SIZE, vehicleSize[0], vehicleSize[1], vehicleSize[2]);
	GetXYBehindVehicle(vehicleid, vehiclePos[0], vehiclePos[1], (vehicleSize[1]/2)+offset);
	x = vehiclePos[0];
	y = vehiclePos[1];
	z = vehiclePos[2];
	return 1;
}

HandlePlayerItemSelection(playerid, selecteditem)
{
	new string[256];

	if(gSelectionItemsTag[playerid][selecteditem] >= 0 && gSelectionItemsTag[playerid][selecteditem] < 319)
 	{
 	    if(PlayerInfo[playerid][pCash]<200)
		{
		    if(PlayerInfo[playerid][pBanque] < 200)
			{
				SubMessage(playerid,MSG_RED,"T'as pas assez d'argent pour t'acheter ça !", 5);
                PlayerPlaySound(playerid,1055,0,0,0);
			}
			else
			{
	  			GivePlayerBanque(playerid,-200);
				format(string,sizeof(string),"T'as acheté le skin %d pour $200 avec ton compte bancaire.",gSelectionItemsTag[playerid][selecteditem]);
				SubMessage(playerid,MSG_BLUE,string, 5);
				GivePlayerSkin(playerid,gSelectionItemsTag[playerid][selecteditem]);
	      		PlayerPlaySound(playerid,1054,0,0,0);
			}
		}
		else
		{
			format(string,sizeof(string),"T'as acheté le skin %d pour $200 en liquide.",gSelectionItemsTag[playerid][selecteditem]);
			SubMessage(playerid,MSG_BLUE,string, 5);
		    GiveMoney(playerid,-200);
      		GivePlayerSkin(playerid, gSelectionItemsTag[playerid][selecteditem]);
      		PlayerPlaySound(playerid,1054,0,0,0);
		}
	}
	return 1;
}

CreateTDMissions(playerid)
{
    TD_Fade[playerid][0] = CreatePlayerTextDraw(playerid, -1.999990, -1.644441, "box");
	PlayerTextDrawLetterSize(playerid, TD_Fade[playerid][0], 0.000000, 50.711652);
	PlayerTextDrawTextSize(playerid, TD_Fade[playerid][0], 639.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, TD_Fade[playerid][0], 1);
	PlayerTextDrawColor(playerid, TD_Fade[playerid][0], -1);
	PlayerTextDrawUseBox(playerid, TD_Fade[playerid][0], 1);
	PlayerTextDrawBoxColor(playerid, TD_Fade[playerid][0], 255);
	PlayerTextDrawSetShadow(playerid, TD_Fade[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, TD_Fade[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_Fade[playerid][0], 255);
	PlayerTextDrawFont(playerid, TD_Fade[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, TD_Fade[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, TD_Fade[playerid][0], 0);

	TD_Fade[playerid][1] = CreatePlayerTextDraw(playerid, 321.101898, 76.297012, "TDEditor");
	PlayerTextDrawLetterSize(playerid, TD_Fade[playerid][1], 0.620666, 2.031407);
	PlayerTextDrawAlignment(playerid, TD_Fade[playerid][1], 2);
	PlayerTextDrawColor(playerid, TD_Fade[playerid][1], -65281);
	PlayerTextDrawSetShadow(playerid, TD_Fade[playerid][1], -73);
	PlayerTextDrawSetOutline(playerid, TD_Fade[playerid][1], 1);
	PlayerTextDrawBackgroundColor(playerid, TD_Fade[playerid][1], 255);
	PlayerTextDrawFont(playerid, TD_Fade[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, TD_Fade[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, TD_Fade[playerid][1], -73);
}

CreateTDObj(playerid)
{
	TD_Obj[playerid] = CreatePlayerTextDraw(playerid, 6.000000, 200.000000, "Objectif");
	PlayerTextDrawLetterSize(playerid, TD_Obj[playerid], 0.400000, 1.600000);
	PlayerTextDrawTextSize(playerid, TD_Obj[playerid], 170.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, TD_Obj[playerid], 1);
	PlayerTextDrawColor(playerid, TD_Obj[playerid], -1);
	PlayerTextDrawUseBox(playerid, TD_Obj[playerid], 1);
	PlayerTextDrawBoxColor(playerid, TD_Obj[playerid], 100);
	PlayerTextDrawSetShadow(playerid, TD_Obj[playerid], 0);
	PlayerTextDrawSetOutline(playerid, TD_Obj[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, TD_Obj[playerid], 255);
	PlayerTextDrawFont(playerid, TD_Obj[playerid], 1);
	PlayerTextDrawSetProportional(playerid, TD_Obj[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TD_Obj[playerid], 0);
}

CreateTDAmmu(playerid)
{
	TD_Comm[playerid][0] = CreatePlayerTextDraw(playerid, 282.666839, 94.177742, "AK_47");
	PlayerTextDrawLetterSize(playerid, TD_Comm[playerid][0], 0.677666, 2.093629);
	PlayerTextDrawAlignment(playerid, TD_Comm[playerid][0], 1);
	PlayerTextDrawColor(playerid, TD_Comm[playerid][0], -1);
	PlayerTextDrawSetShadow(playerid, TD_Comm[playerid][0], 1);
	PlayerTextDrawSetOutline(playerid, TD_Comm[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_Comm[playerid][0], 255);
	PlayerTextDrawFont(playerid, TD_Comm[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, TD_Comm[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, TD_Comm[playerid][0], 1);

	TD_Comm[playerid][1] = CreatePlayerTextDraw(playerid, 292.666748, 351.777893, "$500");
	PlayerTextDrawLetterSize(playerid, TD_Comm[playerid][1], 0.677666, 2.093629);
	PlayerTextDrawAlignment(playerid, TD_Comm[playerid][1], 1);
	PlayerTextDrawColor(playerid, TD_Comm[playerid][1], 8388863);
	PlayerTextDrawSetShadow(playerid, TD_Comm[playerid][1], 1);
	PlayerTextDrawSetOutline(playerid, TD_Comm[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_Comm[playerid][1], 255);
	PlayerTextDrawFont(playerid, TD_Comm[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, TD_Comm[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, TD_Comm[playerid][1], 1);
}

ShowTDComm(playerid,type)
{
	TogglePlayerControllable(playerid,false);
	page[playerid] = -1;

	switch(type)
	{
	    case 1:  // AMMUNATION
	    {
	        achat[playerid] = 1;
			SetPlayerCameraPos(playerid,296.06, -38.03, 1001.51);
			SetPlayerCameraLookAt(playerid,296.5000000,-39.2000000,1001.5999800);
			NextPage(playerid,1);
		}
		case 2: // CONCESS
		{
		    achat[playerid] = 2;
			concessbusy = true;
			SetPlayerCameraPos(playerid,-1950.06,264.03, 35.51);
			SetPlayerCameraLookAt(playerid,-1958.9713,258.9484,35.1035);
			NextPage(playerid,2);
		}
	}
}

NextPage(playerid,type)
{
	new gunname[32];
	page[playerid] ++;
	switch(type)
	{
		case 1: // GUN SHOP PAGES
		{
			if(page[playerid]==TOTAL_AMMU)
			{
			    page[playerid] = 0;
			}
			DestroyPlayerObject(playerid,ArmeSelect[playerid]);
			ArmeSelect[playerid] = CreatePlayerObject(playerid,ItemAmmu[page[playerid]],296.5,-39.2 ,1001.59998,0,0,358);
			SelectItem[playerid] = ItemAmmu[page[playerid]];
			GetWeaponName(ItemWeapon[page[playerid]],gunname,sizeof(gunname));
			for(new i;i<2;i++)
			{
			    PlayerTextDrawHide(playerid,TD_Comm[playerid][i]);
			}
			PlayerTextDrawSetString(playerid,TD_Comm[playerid][0],gunname);
			format(gunname,sizeof(gunname),"$%d",ItemPrice[page[playerid]]);
			PlayerTextDrawSetString(playerid,TD_Comm[playerid][1],gunname);
			for(new i;i<2;i++)
			{
			    PlayerTextDrawShow(playerid,TD_Comm[playerid][i]);
			}
		}
		case 2: //VEHICLES SHOP PAGES
		{
			if(page[playerid]==TOTAL_VEHICLES)
			{
			    page[playerid] = 0;
			}
			DestroyVehicle(cvehicle[playerid]);
			cvehicle[playerid] = CreateVehicle(ItemVeh[page[playerid]],-1958.9713,258.9484,35.1035,318.8788,-1,-1,-1);
			vPosseded[cvehicle[playerid]] = true;
			SelectItem[playerid] = ItemVeh[page[playerid]];
			for(new i;i<2;i++)
			{
			    PlayerTextDrawHide(playerid,TD_Comm[playerid][i]);
			}
			PlayerTextDrawSetString(playerid,TD_Comm[playerid][0],GetVehicleName(ItemVeh[page[playerid]]));
			format(gunname,sizeof(gunname),"$%d",ItemVPrice[page[playerid]]);
			PlayerTextDrawSetString(playerid,TD_Comm[playerid][1],gunname);
			for(new i;i<2;i++)
			{
			    PlayerTextDrawShow(playerid,TD_Comm[playerid][i]);
			}
		}
	}
}

PreviousPage(playerid,type)
{
	new gunname[32];
	page[playerid] --;
	switch(type)
	{
	    case 1:
		{
			if(page[playerid]==-1)
			{
			    page[playerid] = TOTAL_AMMU-1;
			}
			DestroyPlayerObject(playerid,ArmeSelect[playerid]);
			ArmeSelect[playerid] = CreatePlayerObject(playerid,ItemAmmu[page[playerid]],296.5,-39.2 ,1001.59998,0,0,358);
			SelectItem[playerid] = ItemAmmu[page[playerid]];
			GetWeaponName(ItemWeapon[page[playerid]],gunname,sizeof(gunname));
			for(new i;i<2;i++)
			{
			    PlayerTextDrawHide(playerid,TD_Comm[playerid][i]);
			}
			PlayerTextDrawSetString(playerid,TD_Comm[playerid][0],gunname);
			format(gunname,sizeof(gunname),"$%d",ItemPrice[page[playerid]]);
			PlayerTextDrawSetString(playerid,TD_Comm[playerid][1],gunname);
			for(new i;i<2;i++)
			{
			    PlayerTextDrawShow(playerid,TD_Comm[playerid][i]);
			}
		}
		case 2:
		{
			if(page[playerid]==-1)
			{
			    page[playerid] = TOTAL_VEHICLES-1;
			}
			DestroyVehicle(cvehicle[playerid]);
			cvehicle[playerid] = CreateVehicle(ItemVeh[page[playerid]],-1958.9713,258.9484,35.1035,318.8788,-1,-1,-1);
			vPosseded[cvehicle[playerid]] = true;
			SelectItem[playerid] = ItemVeh[page[playerid]];
			for(new i;i<2;i++)
			{
			    PlayerTextDrawHide(playerid,TD_Comm[playerid][i]);
			}
			PlayerTextDrawSetString(playerid,TD_Comm[playerid][0],GetVehicleName(ItemVeh[page[playerid]]));
			format(gunname,sizeof(gunname),"$%d",ItemVPrice[page[playerid]]);
			PlayerTextDrawSetString(playerid,TD_Comm[playerid][1],gunname);
			for(new i;i<2;i++)
			{
			    PlayerTextDrawShow(playerid,TD_Comm[playerid][i]);
			}
		}
	}
}

HideTDComm(playerid,type)
{
	SetCameraBehindPlayer(playerid);
	TogglePlayerControllable(playerid,true);
	SelectItem[playerid] = 0;
	page[playerid] = 0;
	if(type == 1) DestroyPlayerObject(playerid,ArmeSelect[playerid]);
	if(type == 2) concessbusy = false;
	for(new i;i<2;i++)
	{
	    PlayerTextDrawHide(playerid,TD_Comm[playerid][i]);
	}
}

GetNumberOfPages()
{
	if((gTotalItems >= SELECTION_ITEMS) && (gTotalItems % SELECTION_ITEMS) == 0)
	{
		return (gTotalItems / SELECTION_ITEMS);
	}
	else return (gTotalItems / SELECTION_ITEMS) + 1;
}

PlayerText:CreateCurrentPageTextDraw(playerid, Float:Xpos, Float:Ypos)
{
	new PlayerText:txtInit;
   	txtInit = CreatePlayerTextDraw(playerid, Xpos, Ypos, "0/0");
   	PlayerTextDrawUseBox(playerid, txtInit, 0);
	PlayerTextDrawLetterSize(playerid, txtInit, 0.4, 1.1);
	PlayerTextDrawFont(playerid, txtInit, 1);
	PlayerTextDrawSetShadow(playerid, txtInit, 0);
    PlayerTextDrawSetOutline(playerid, txtInit, 1);
    PlayerTextDrawColor(playerid, txtInit, 0xACCBF1FF);
    PlayerTextDrawShow(playerid, txtInit);
    return txtInit;
}

PlayerText:CreatePlayerDialogButton(playerid, Float:Xpos, Float:Ypos, Float:Width, Float:Height, button_text[])
{
 	new PlayerText:txtInit;
   	txtInit = CreatePlayerTextDraw(playerid, Xpos, Ypos, button_text);
   	PlayerTextDrawUseBox(playerid, txtInit, 1);
   	PlayerTextDrawBoxColor(playerid, txtInit, 0x000000FF);
   	PlayerTextDrawBackgroundColor(playerid, txtInit, 0x000000FF);
	PlayerTextDrawLetterSize(playerid, txtInit, 0.4, 1.1);
	PlayerTextDrawFont(playerid, txtInit, 1);
	PlayerTextDrawSetShadow(playerid, txtInit, 0);
    PlayerTextDrawSetOutline(playerid, txtInit, 0);
    PlayerTextDrawColor(playerid, txtInit, 0x4A5A6BFF);
    PlayerTextDrawSetSelectable(playerid, txtInit, 1);
    PlayerTextDrawAlignment(playerid, txtInit, 2);
    PlayerTextDrawTextSize(playerid, txtInit, Height, Width);
    PlayerTextDrawShow(playerid, txtInit);
    return txtInit;
}

PlayerText:CreatePlayerHeaderTextDraw(playerid, Float:Xpos, Float:Ypos, header_text[])
{
	new PlayerText:txtInit;
   	txtInit = CreatePlayerTextDraw(playerid, Xpos, Ypos, header_text);
   	PlayerTextDrawUseBox(playerid, txtInit, 0);
	PlayerTextDrawLetterSize(playerid, txtInit, 0.5, 2.5);
	PlayerTextDrawFont(playerid, txtInit, 3);
	PlayerTextDrawSetShadow(playerid, txtInit, 0);
    PlayerTextDrawSetOutline(playerid, txtInit, 1);
    PlayerTextDrawColor(playerid, txtInit, 0xACCBF1FF);
    PlayerTextDrawShow(playerid, txtInit);
    return txtInit;
}

PlayerText:CreatePlayerBackgroundTextDraw(playerid, Float:Xpos, Float:Ypos, Float:Width, Float:Height)
{
	new PlayerText:txtBackground = CreatePlayerTextDraw(playerid, Xpos, Ypos,
	"                                            ~n~");
    PlayerTextDrawUseBox(playerid, txtBackground, 1);
    PlayerTextDrawBoxColor(playerid, txtBackground, 0x4A5A6BBB);
	PlayerTextDrawLetterSize(playerid, txtBackground, 5.0, 5.0);
	PlayerTextDrawFont(playerid, txtBackground, 0);
	PlayerTextDrawSetShadow(playerid, txtBackground, 0);
    PlayerTextDrawSetOutline(playerid, txtBackground, 0);
    PlayerTextDrawColor(playerid, txtBackground,0x000000FF);
    PlayerTextDrawTextSize(playerid, txtBackground, Width, Height);
   	PlayerTextDrawBackgroundColor(playerid, txtBackground, 0x4A5A6BBB);
    PlayerTextDrawShow(playerid, txtBackground);
    return txtBackground;
}

PlayerText:CreateModelPreviewTextDraw(playerid, modelindex, Float:Xpos, Float:Ypos, Float:width, Float:height)
{
    new PlayerText:txtPlayerSprite = CreatePlayerTextDraw(playerid, Xpos, Ypos, ""); // it has to be set with SetText later
    PlayerTextDrawFont(playerid, txtPlayerSprite, TEXT_DRAW_FONT_MODEL_PREVIEW);
    PlayerTextDrawColor(playerid, txtPlayerSprite, 0xFFFFFFFF);
    PlayerTextDrawBackgroundColor(playerid, txtPlayerSprite, 0x88888899);
    PlayerTextDrawTextSize(playerid, txtPlayerSprite, width, height); // Text size is the Width:Height
    PlayerTextDrawSetPreviewModel(playerid, txtPlayerSprite, modelindex);
    PlayerTextDrawSetSelectable(playerid, txtPlayerSprite, 1);
    PlayerTextDrawShow(playerid,txtPlayerSprite);
    return txtPlayerSprite;
}

DestroyPlayerModelPreviews(playerid)
{
	new x=0;
	while(x != SELECTION_ITEMS) {
	    if(gSelectionItems[playerid][x] != PlayerText:INVALID_TEXT_DRAW) {
			PlayerTextDrawDestroy(playerid, gSelectionItems[playerid][x]);
			gSelectionItems[playerid][x] = PlayerText:INVALID_TEXT_DRAW;
		}
		x++;
	}
}

ShowPlayerModelPreviews(playerid)
{
    new x=0;
	new Float:BaseX = DIALOG_BASE_X;
	new Float:BaseY = DIALOG_BASE_Y - (SPRITE_DIM_Y * 0.33);
	new linetracker = 0;

	new itemat = GetPVarInt(playerid, "skinc_page") * SELECTION_ITEMS;

	DestroyPlayerModelPreviews(playerid);

	while(x != SELECTION_ITEMS && itemat < gTotalItems) {
	    if(linetracker == 0) {
	        BaseX = DIALOG_BASE_X + 25.0;
	        BaseY += SPRITE_DIM_Y + 1.0;
		}
  		gSelectionItems[playerid][x] = CreateModelPreviewTextDraw(playerid, gItemList[itemat], BaseX, BaseY, SPRITE_DIM_X, SPRITE_DIM_Y);
  		gSelectionItemsTag[playerid][x] = gItemList[itemat];
		BaseX += SPRITE_DIM_X + 1.0;
		linetracker++;
		if(linetracker == ITEMS_PER_LINE) linetracker = 0;
		itemat++;
		x++;
	}
}

UpdatePageTextDraw(playerid)
{
	new PageText[64+1];
	format(PageText, 64, "%d/%d", GetPVarInt(playerid,"skinc_page") + 1, GetNumberOfPages());
	PlayerTextDrawSetString(playerid, gCurrentPageTextDrawId[playerid], PageText);
}

CreateSelectionMenu(playerid)
{
    gBackgroundTextDrawId[playerid] = CreatePlayerBackgroundTextDraw(playerid, DIALOG_BASE_X, DIALOG_BASE_Y + 20.0, DIALOG_WIDTH, DIALOG_HEIGHT);
    gHeaderTextDrawId[playerid] = CreatePlayerHeaderTextDraw(playerid, DIALOG_BASE_X, DIALOG_BASE_Y, HEADER_TEXT);
    gCurrentPageTextDrawId[playerid] = CreateCurrentPageTextDraw(playerid, DIALOG_WIDTH - 30.0, DIALOG_BASE_Y + 15.0);
    gNextButtonTextDrawId[playerid] = CreatePlayerDialogButton(playerid, DIALOG_WIDTH - 30.0, DIALOG_BASE_Y+DIALOG_HEIGHT+100.0, 50.0, 16.0, NEXT_TEXT);
    gPrevButtonTextDrawId[playerid] = CreatePlayerDialogButton(playerid, DIALOG_WIDTH - 90.0, DIALOG_BASE_Y+DIALOG_HEIGHT+100.0, 50.0, 16.0, PREV_TEXT);

    ShowPlayerModelPreviews(playerid);
    UpdatePageTextDraw(playerid);
}

DestroySelectionMenu(playerid)
{
	DestroyPlayerModelPreviews(playerid);

	PlayerTextDrawDestroy(playerid, gHeaderTextDrawId[playerid]);
	PlayerTextDrawDestroy(playerid, gBackgroundTextDrawId[playerid]);
	PlayerTextDrawDestroy(playerid, gCurrentPageTextDrawId[playerid]);
	PlayerTextDrawDestroy(playerid, gNextButtonTextDrawId[playerid]);
	PlayerTextDrawDestroy(playerid, gPrevButtonTextDrawId[playerid]);

	gHeaderTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gBackgroundTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gCurrentPageTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gNextButtonTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gPrevButtonTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
}

SavePlayerWeapons(playerid)
{
	new weapons[7][2];
	new INI:File = INI_Open(UserPath(playerid));
	INI_SetTag(File,"Weap");
	for(new i;i<7;i++)
	{
	    GetPlayerWeaponData(playerid,i,weapons[i][0],weapons[i][1]);
	}
	switch(weapons[2][0])
	{
	    case 22:
		{
		    PlayerInfo[playerid][p9mm] = weapons[2][1];
			INI_WriteInt(File,"9mm",weapons[2][1]);
			INI_WriteInt(File,"Silencieux",0);
			INI_WriteInt(File,"Eagle",0);
		}
	    case 23:
		{
		    PlayerInfo[playerid][pS9mm] = weapons[2][1];
			INI_WriteInt(File,"9mm",0);
			INI_WriteInt(File,"Silencieux",weapons[2][1]);
			INI_WriteInt(File,"Eagle",0);
		}
	    case 24:
		{
		    PlayerInfo[playerid][pEagle] = weapons[2][1];
			INI_WriteInt(File,"9mm",0);
			INI_WriteInt(File,"Silencieux",0);
			INI_WriteInt(File,"Eagle",weapons[2][1]);
		}
	}
	switch(weapons[3][0])
	{
	    case 25:
		{
		    PlayerInfo[playerid][pShotgun] = weapons[3][1];
			INI_WriteInt(File,"Shotgun",weapons[3][1]);
			INI_WriteInt(File,"Sawnoff",0);
			INI_WriteInt(File,"CombatShotgun",0);
		}
	    case 26:
		{
		    PlayerInfo[playerid][pSawnoff] = weapons[3][1];
			INI_WriteInt(File,"Shotgun",0);
			INI_WriteInt(File,"Sawnoff",weapons[3][1]);
			INI_WriteInt(File,"CombatShotgun",0);
		}
	    case 27:
		{
		    PlayerInfo[playerid][pCShotgun] = weapons[3][1];
			INI_WriteInt(File,"Shotgun",0);
			INI_WriteInt(File,"Shotgun",0);
			INI_WriteInt(File,"CombatShotgun",weapons[3][1]);
		}
	}
	switch(weapons[4][0])
	{
	    case 28:
		{
		    PlayerInfo[playerid][pUzi] = weapons[4][1];
			INI_WriteInt(File,"UZI",weapons[4][1]);
			INI_WriteInt(File,"MP5",0);
			INI_WriteInt(File,"TEC9",0);
		}
	    case 29:
		{
		    PlayerInfo[playerid][pMp5] = weapons[4][1];
			INI_WriteInt(File,"UZI",0);
			INI_WriteInt(File,"MP5",weapons[4][1]);
			INI_WriteInt(File,"TEC9",0);
		}
	    case 32:
		{
		    PlayerInfo[playerid][pTec9] = weapons[4][1];
			INI_WriteInt(File,"UZI",0);
			INI_WriteInt(File,"MP5",0);
			INI_WriteInt(File,"TEC9",weapons[4][1]);
		}
	}
	switch(weapons[5][0])
	{
	    case 30:
		{
		    PlayerInfo[playerid][pAk47] = weapons[5][1];
			INI_WriteInt(File,"AK47",weapons[5][1]);
			INI_WriteInt(File,"M4",0);
			INI_WriteInt(File,"Sniper",0);
		}
	    case 31:
		{
		    PlayerInfo[playerid][pM4] = weapons[5][1];
			INI_WriteInt(File,"AK47",0);
			INI_WriteInt(File,"M4",weapons[5][1]);
			INI_WriteInt(File,"Sniper",0);
		}
	}
	switch(weapons[6][0])
	{
	    case 33:
		{
		    PlayerInfo[playerid][pRifle] = weapons[6][1];
			INI_WriteInt(File,"Rifle",weapons[6][1]);
			INI_WriteInt(File,"Sniper",0);
		}
	    case 34:
		{
		    PlayerInfo[playerid][pSniper] = weapons[6][1];
			INI_WriteInt(File,"Rifle",0);
			INI_WriteInt(File,"Sniper",weapons[6][1]);
		}
	}
    INI_Close(File);
}

SaveHouse(houseid)
{
	new INI:File = INI_Open(HousePath(houseid));
	INI_SetTag(File,"data");
	INI_WriteFloat(File,"X1",HouseInfo[houseid][X1]);
	INI_WriteFloat(File,"Y1",HouseInfo[houseid][Y1]);
	INI_WriteFloat(File,"Z1",HouseInfo[houseid][Z1]);
	INI_WriteFloat(File,"eX",HouseInfo[houseid][eX]);
	INI_WriteFloat(File,"eY",HouseInfo[houseid][eY]);
	INI_WriteFloat(File,"eZ",HouseInfo[houseid][eZ]);
	INI_WriteFloat(File,"cX",HouseInfo[houseid][cX]);
	INI_WriteFloat(File,"cY",HouseInfo[houseid][cY]);
	INI_WriteFloat(File,"cZ",HouseInfo[houseid][cZ]);
	INI_WriteString(File,"Proprio",proprio[houseid]);
	INI_WriteInt(File,"Type",HouseInfo[houseid][Type]);
	INI_WriteInt(File,"Interior",HouseInfo[houseid][Interior]);
	INI_WriteInt(File,"Prix",HouseInfo[houseid][Prix]);
	INI_WriteInt(File,"Lock",HouseInfo[houseid][Lock]);
	INI_Close(File);
}

SaveCommerce(restoid)
{
	new INI:File = INI_Open(CommercePath(restoid));
	INI_SetTag(File,"data");
	INI_WriteFloat(File,"X1",CommerceInfo[restoid][X1]);
	INI_WriteFloat(File,"Y1",CommerceInfo[restoid][Y1]);
	INI_WriteFloat(File,"Z1",CommerceInfo[restoid][Z1]);
	INI_WriteFloat(File,"eX",CommerceInfo[restoid][eX]);
	INI_WriteFloat(File,"eY",CommerceInfo[restoid][eY]);
	INI_WriteFloat(File,"eZ",CommerceInfo[restoid][eZ]);
	INI_WriteInt(File,"Type",CommerceInfo[restoid][Type]);
	INI_WriteInt(File,"Interior",CommerceInfo[restoid][Interieur]);
	INI_Close(File);
}

SaveBiz(bizid)
{
	new INI:File = INI_Open(BizPath(bizid));
	INI_SetTag(File,"data");
	INI_WriteFloat(File,"X1",BizInfo[bizid][X]);
	INI_WriteFloat(File,"Y1",BizInfo[bizid][Y]);
	INI_WriteFloat(File,"Z1",BizInfo[bizid][Z]);
	INI_WriteString(File,"Proprio",bproprio[bizid]);
	INI_WriteInt(File,"Type",BizInfo[bizid][Type]);
	INI_WriteInt(File,"Caisse",BizInfo[bizid][Caisse]);
	INI_WriteInt(File,"CaisseMax",BizInfo[bizid][CaisseMax]);
	INI_WriteInt(File,"Prix",BizInfo[bizid][Prix]);
	INI_WriteInt(File,"Revenus",BizInfo[bizid][Revenus]);
	INI_Close(File);
}

FindPlayerByNum(num)
{
	new id,result;
	for(new i;i<MAX_PLAYERS;i++)
	{
	    if(IsPlayerConnected(i))
	    {
		    if(PlayerInfo[i][pNum] == num)
		    {
		        id = i;
		        result++;
		    	break;
			}
		}
	}
	if(result == 0)
	{
		return -1;
 	}
 	else
 	{
		return id;
	}
}

StartAppel(id1)
{
	new str[128];
	new playerid = id1;
	KillTimer(EndTimer[playerid]);
	KillTimer(EndTimer[TalkingID[playerid]]);
	PlayerTextDrawHide(playerid,TD_Appel[playerid][3]);
	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_USECELLPHONE);
	SetPlayerAttachedObject(playerid, 0, 18872, 6, 0.1, 0.0, 0.0, 90.0, 180.0, 0.0, 1, 1, 1);
	SubMessage(playerid,MSG_BLUE,"T'as répondu à l'appel, tu peux maintenant parler.", 5);
	format(str,sizeof(str),"\"%s\" a répondu à ton appel, tu peux maintenant parler.",GetName(id1));
	SubMessage(TalkingID[playerid],MSG_BLUE,str, 5);
	Talking[TalkingID[playerid]] = 1;
	Talking[playerid] = 1;
	InCall[playerid] = 1;
}

CallPlayer(playerid,num)
{
	new id = FindPlayerByNum(num);
	new str[256];
	if(PlayerInfo[playerid][pNum]==0) return SubMessage(playerid,MSG_RED,"T'as pas de numéro ! Tapes /createnum pour en créer un !",5);
	{
		if(id == -1) return SubMessage(playerid,MSG_RED,"Ce numéro est invalide ou le joueur n'est pas connecté !",5);
		{
		    if(id == playerid) return SubMessage(playerid,MSG_RED,"Tu ne peux pas t'appeler toi-même !",5);
		    {
		        if(Talking[playerid] == 1) return SubMessage(playerid,MSG_RED,"T'as déjà un appel en cours !",5);
		        {
		   			if(InCall[id] == 1 || mission[id] != 0)
					{
					 	SubMessage(playerid,MSG_RED,"Ce correspondant était occupé, un message lui a été envoyé le notifiant de ton appel.",5);
						format(str,sizeof(str),"Le joueur \"%s\" (%d) a essayé de te joindre alors que tu es occupé.",playerid,GetName(playerid));
						SubMessage(id,MSG_BLUE,str, 5);
						return 1;
					}
					format(str,sizeof(str),"Appel de \"%s (%d)\"...",GetName(id),PlayerInfo[id][pNum]);
					SetPlayerSpecialAction(playerid,SPECIAL_ACTION_USECELLPHONE);
					SetPlayerAttachedObject(playerid, 0, 18872, 6, 0.1, 0.0, 0.0, 90.0, 180.0, 0.0, 1, 1, 1);
					SubMessage(playerid,MSG_BLUE,str,30);
					format(str,sizeof(str),"Appel entrant de \"%s\"...",GetName(playerid),PlayerInfo[playerid][pNum]);
					SubMessage(id,MSG_BLUE,str,30);
					EndTimer[id] = SetTimerEx("EndCall",30000,0,"iii",playerid,id,1);
					PlayerPlaySound(id,23000,0.0,0.0,0.0);
					TalkingID[playerid] = id;
					TalkingID[id] = playerid;
				    IsCalling[id] = 1;
					InCall[playerid] = 1;
					InCall[id] = 1;
					HidePhoneTD(id);
					HidePhoneTD(playerid);
					ShowAppelTD(id);
					ShowAppelTD(playerid);
					PlayerTextDrawHide(playerid,TD_Appel[playerid][3]);
				}
			}
		}
	}
	return 1;
}

GetXYFront(&Float:x, &Float:y, Float:a, Float:distance)
{
	x += (distance * floatsin(-a, degrees));
	y += (distance * floatcos(-a, degrees));
}

CreatePhoneTD(playerid)
{
	TD_Phone[playerid][0] = CreatePlayerTextDraw(playerid, 442.666625, 229.407470, "box");
	PlayerTextDrawLetterSize(playerid, TD_Phone[playerid][0], 0.000000, 23.500001);
	PlayerTextDrawTextSize(playerid, TD_Phone[playerid][0], 538.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, TD_Phone[playerid][0], 1);
	PlayerTextDrawColor(playerid, TD_Phone[playerid][0], -1);
	PlayerTextDrawUseBox(playerid, TD_Phone[playerid][0], 1);
	PlayerTextDrawBoxColor(playerid, TD_Phone[playerid][0], 255);
	PlayerTextDrawSetShadow(playerid, TD_Phone[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, TD_Phone[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_Phone[playerid][0], 255);
	PlayerTextDrawFont(playerid, TD_Phone[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, TD_Phone[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, TD_Phone[playerid][0], 0);

	TD_Phone[playerid][1] = CreatePlayerTextDraw(playerid, 446.000030, 253.340637, "box");
	PlayerTextDrawLetterSize(playerid, TD_Phone[playerid][1], 0.000000, 18.600000);
	PlayerTextDrawTextSize(playerid, TD_Phone[playerid][1], 535.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, TD_Phone[playerid][1], 1);
	PlayerTextDrawColor(playerid, TD_Phone[playerid][1], -1);
	PlayerTextDrawUseBox(playerid, TD_Phone[playerid][1], 1);
	PlayerTextDrawBoxColor(playerid, TD_Phone[playerid][1], -2139062017);
	PlayerTextDrawSetShadow(playerid, TD_Phone[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, TD_Phone[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_Phone[playerid][1], 255);
	PlayerTextDrawFont(playerid, TD_Phone[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, TD_Phone[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, TD_Phone[playerid][1], 0);

	TD_Phone[playerid][2] = CreatePlayerTextDraw(playerid, 460.966674, 233.140792, "PineApple");
	PlayerTextDrawLetterSize(playerid, TD_Phone[playerid][2], 0.292000, 1.301333);
	PlayerTextDrawAlignment(playerid, TD_Phone[playerid][2], 1);
	PlayerTextDrawColor(playerid, TD_Phone[playerid][2], -1);
	PlayerTextDrawSetShadow(playerid, TD_Phone[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, TD_Phone[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_Phone[playerid][2], 255);
	PlayerTextDrawFont(playerid, TD_Phone[playerid][2], 2);
	PlayerTextDrawSetProportional(playerid, TD_Phone[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, TD_Phone[playerid][2], 0);

	TD_Phone[playerid][3] = CreatePlayerTextDraw(playerid, 481.666961, 427.255950, "box");
	PlayerTextDrawLetterSize(playerid, TD_Phone[playerid][3], 0.000000, 0.766665);
	PlayerTextDrawTextSize(playerid, TD_Phone[playerid][3], 499.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, TD_Phone[playerid][3], 1);
	PlayerTextDrawColor(playerid, TD_Phone[playerid][3], -1);
	PlayerTextDrawUseBox(playerid, TD_Phone[playerid][3], 1);
	PlayerTextDrawBoxColor(playerid, TD_Phone[playerid][3], 1347440895);
	PlayerTextDrawSetShadow(playerid, TD_Phone[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, TD_Phone[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_Phone[playerid][3], 255);
	PlayerTextDrawFont(playerid, TD_Phone[playerid][3], 1);
	PlayerTextDrawSetProportional(playerid, TD_Phone[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, TD_Phone[playerid][3], 0);

	TD_Phone[playerid][4] = CreatePlayerTextDraw(playerid, 469.000061, 253.881439, "12:00");
	PlayerTextDrawLetterSize(playerid, TD_Phone[playerid][4], 0.493999, 2.155852);
	PlayerTextDrawAlignment(playerid, TD_Phone[playerid][4], 1);
	PlayerTextDrawColor(playerid, TD_Phone[playerid][4], -1);
	PlayerTextDrawSetShadow(playerid, TD_Phone[playerid][4], 1);
	PlayerTextDrawSetOutline(playerid, TD_Phone[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_Phone[playerid][4], 255);
	PlayerTextDrawFont(playerid, TD_Phone[playerid][4], 3);
	PlayerTextDrawSetProportional(playerid, TD_Phone[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid, TD_Phone[playerid][4], 1);

	TD_Phone[playerid][5] = CreatePlayerTextDraw(playerid, 469.866485, 276.281555, "jeudi_13_novembre");
	PlayerTextDrawLetterSize(playerid, TD_Phone[playerid][5], 0.232000, 1.060740);
	PlayerTextDrawAlignment(playerid, TD_Phone[playerid][5], 1);
	PlayerTextDrawColor(playerid, TD_Phone[playerid][5], -1);
	PlayerTextDrawSetShadow(playerid, TD_Phone[playerid][5], 1);
	PlayerTextDrawSetOutline(playerid, TD_Phone[playerid][5], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_Phone[playerid][5], 255);
	PlayerTextDrawFont(playerid, TD_Phone[playerid][5], 1);
	PlayerTextDrawSetProportional(playerid, TD_Phone[playerid][5], 1);
	PlayerTextDrawSetShadow(playerid, TD_Phone[playerid][5], 1);

	TD_Phone[playerid][6] = CreatePlayerTextDraw(playerid, 453.733581, 318.177856, "box");
	PlayerTextDrawLetterSize(playerid, TD_Phone[playerid][6], 0.000000, 3.566667);
	PlayerTextDrawTextSize(playerid, TD_Phone[playerid][6], 484.400207, 0.000000);
	PlayerTextDrawAlignment(playerid, TD_Phone[playerid][6], 1);
	PlayerTextDrawColor(playerid, TD_Phone[playerid][6], -1);
	PlayerTextDrawUseBox(playerid, TD_Phone[playerid][6], 1);
	PlayerTextDrawBoxColor(playerid, TD_Phone[playerid][6], -5963521);
	PlayerTextDrawSetShadow(playerid, TD_Phone[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, TD_Phone[playerid][6], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_Phone[playerid][6], 255);
	PlayerTextDrawFont(playerid, TD_Phone[playerid][6], 1);
	PlayerTextDrawSetProportional(playerid, TD_Phone[playerid][6], 1);
	PlayerTextDrawSetShadow(playerid, TD_Phone[playerid][6], 0);

	TD_Phone[playerid][7] = CreatePlayerTextDraw(playerid, 496.366699, 318.822235, "box");
	PlayerTextDrawLetterSize(playerid, TD_Phone[playerid][7], 0.000000, 3.566667);
	PlayerTextDrawTextSize(playerid, TD_Phone[playerid][7], 526.600585, 0.000000);
	PlayerTextDrawAlignment(playerid, TD_Phone[playerid][7], 1);
	PlayerTextDrawColor(playerid, TD_Phone[playerid][7], -1);
	PlayerTextDrawUseBox(playerid, TD_Phone[playerid][7], 1);
	PlayerTextDrawBoxColor(playerid, TD_Phone[playerid][7], 1815478527);
	PlayerTextDrawSetShadow(playerid, TD_Phone[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, TD_Phone[playerid][7], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_Phone[playerid][7], -1523963137);
	PlayerTextDrawFont(playerid, TD_Phone[playerid][7], 1);
	PlayerTextDrawSetProportional(playerid, TD_Phone[playerid][7], 1);
	PlayerTextDrawSetShadow(playerid, TD_Phone[playerid][7], 0);

	TD_Phone[playerid][8] = CreatePlayerTextDraw(playerid, 494.333251, 303.503662, "");
	PlayerTextDrawLetterSize(playerid, TD_Phone[playerid][8], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TD_Phone[playerid][8], 36.000000, 59.000000);
	PlayerTextDrawAlignment(playerid, TD_Phone[playerid][8], 1);
	PlayerTextDrawColor(playerid, TD_Phone[playerid][8], -1);
	PlayerTextDrawSetShadow(playerid, TD_Phone[playerid][8], 0);
	PlayerTextDrawSetOutline(playerid, TD_Phone[playerid][8], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_Phone[playerid][8], 0);
	PlayerTextDrawFont(playerid, TD_Phone[playerid][8], 5);
	PlayerTextDrawSetProportional(playerid, TD_Phone[playerid][8], 0);
	PlayerTextDrawSetShadow(playerid, TD_Phone[playerid][8], 0);
	PlayerTextDrawSetSelectable(playerid, TD_Phone[playerid][8], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_Phone[playerid][8], 2894);
	PlayerTextDrawSetPreviewRot(playerid, TD_Phone[playerid][8], 90.000000, 10.000000, 0.000000, 1.000000);

	TD_Phone[playerid][9] = CreatePlayerTextDraw(playerid, 468.666717, 323.570220, "SMS");
	PlayerTextDrawLetterSize(playerid, TD_Phone[playerid][9], 0.412000, 2.189037);
	PlayerTextDrawTextSize(playerid,TD_Phone[playerid][9],32.3,46.8);
	PlayerTextDrawAlignment(playerid, TD_Phone[playerid][9], 2);
	PlayerTextDrawColor(playerid, TD_Phone[playerid][9], -1);
	PlayerTextDrawSetShadow(playerid, TD_Phone[playerid][9], 1);
	PlayerTextDrawSetOutline(playerid, TD_Phone[playerid][9], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_Phone[playerid][9], 255);
	PlayerTextDrawFont(playerid, TD_Phone[playerid][9], 1);
	PlayerTextDrawSetProportional(playerid, TD_Phone[playerid][9], 1);
	PlayerTextDrawSetShadow(playerid, TD_Phone[playerid][9], 1);
	PlayerTextDrawSetSelectable(playerid, TD_Phone[playerid][9], true);

	TD_Phone[playerid][10] = CreatePlayerTextDraw(playerid, 454.666717, 369.844451, "box");
	PlayerTextDrawLetterSize(playerid, TD_Phone[playerid][10], 0.000000, 3.566667);
	PlayerTextDrawTextSize(playerid, TD_Phone[playerid][10], 484.300018, 0.000000);
	PlayerTextDrawAlignment(playerid, TD_Phone[playerid][10], 1);
	PlayerTextDrawColor(playerid, TD_Phone[playerid][10], -1);
	PlayerTextDrawUseBox(playerid, TD_Phone[playerid][10], 1);
	PlayerTextDrawBoxColor(playerid, TD_Phone[playerid][10], -1);
	PlayerTextDrawSetShadow(playerid, TD_Phone[playerid][10], 0);
	PlayerTextDrawSetOutline(playerid, TD_Phone[playerid][10], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_Phone[playerid][10], -1523963137);
	PlayerTextDrawFont(playerid, TD_Phone[playerid][10], 1);
	PlayerTextDrawSetProportional(playerid, TD_Phone[playerid][10], 1);
	PlayerTextDrawSetShadow(playerid, TD_Phone[playerid][10], 0);

	TD_Phone[playerid][11] = CreatePlayerTextDraw(playerid, 468.833801, 364.022216, "$");
	PlayerTextDrawTextSize(playerid,TD_Phone[playerid][11],36.4 ,36.4);
	PlayerTextDrawLetterSize(playerid, TD_Phone[playerid][11], 0.614666, 4.097185);
	PlayerTextDrawAlignment(playerid, TD_Phone[playerid][11], 2);
	PlayerTextDrawColor(playerid, TD_Phone[playerid][11], 8388863);
	PlayerTextDrawSetShadow(playerid, TD_Phone[playerid][11], 1);
	PlayerTextDrawSetOutline(playerid, TD_Phone[playerid][11], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_Phone[playerid][11], 255);
	PlayerTextDrawFont(playerid, TD_Phone[playerid][11], 1);
	PlayerTextDrawSetProportional(playerid, TD_Phone[playerid][11], 1);
	PlayerTextDrawSetShadow(playerid, TD_Phone[playerid][11], 1);
	PlayerTextDrawSetSelectable(playerid, TD_Phone[playerid][11], true);

	TD_Phone[playerid][12] = CreatePlayerTextDraw(playerid, 483.033386, 354.840881, "");
	PlayerTextDrawLetterSize(playerid, TD_Phone[playerid][12], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TD_Phone[playerid][12], 55.000000, 60.000000);
	PlayerTextDrawAlignment(playerid, TD_Phone[playerid][12], 1);
	PlayerTextDrawColor(playerid, TD_Phone[playerid][12], -1);
	PlayerTextDrawSetShadow(playerid, TD_Phone[playerid][12], 0);
	PlayerTextDrawSetOutline(playerid, TD_Phone[playerid][12], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_Phone[playerid][12], 0);
	PlayerTextDrawFont(playerid, TD_Phone[playerid][12], 5);
	PlayerTextDrawSetProportional(playerid, TD_Phone[playerid][12], 0);
	PlayerTextDrawSetShadow(playerid, TD_Phone[playerid][12], 0);
	PlayerTextDrawSetSelectable(playerid, TD_Phone[playerid][12], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_Phone[playerid][12], 19168);
	PlayerTextDrawSetPreviewRot(playerid, TD_Phone[playerid][12], 90.000000, 180.000000, 0.000000, 1.000000);


	TD_Appel[playerid][0] = CreatePlayerTextDraw(playerid, 472.666656, 256.629638, "");
	PlayerTextDrawLetterSize(playerid, TD_Appel[playerid][0], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TD_Appel[playerid][0], 39.000000, 46.000000);
	PlayerTextDrawAlignment(playerid, TD_Appel[playerid][0], 1);
	PlayerTextDrawColor(playerid, TD_Appel[playerid][0], -1);
	PlayerTextDrawSetShadow(playerid, TD_Appel[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, TD_Appel[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_Appel[playerid][0], -1);
	PlayerTextDrawFont(playerid, TD_Appel[playerid][0], 5);
	PlayerTextDrawSetProportional(playerid, TD_Appel[playerid][0], 0);
	PlayerTextDrawSetShadow(playerid, TD_Appel[playerid][0], 0);
	PlayerTextDrawSetPreviewModel(playerid, TD_Appel[playerid][0], 0);

	TD_Appel[playerid][1] = CreatePlayerTextDraw(playerid, 459.000030, 310.296325, "Appel_de_...");
	PlayerTextDrawLetterSize(playerid, TD_Appel[playerid][1], 0.296666, 1.293037);
	PlayerTextDrawAlignment(playerid, TD_Appel[playerid][1], 1);
	PlayerTextDrawColor(playerid, TD_Appel[playerid][1], -1);
	PlayerTextDrawSetShadow(playerid, TD_Appel[playerid][1], 1);
	PlayerTextDrawSetOutline(playerid, TD_Appel[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_Appel[playerid][1], 255);
	PlayerTextDrawFont(playerid, TD_Appel[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, TD_Appel[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, TD_Appel[playerid][1], 1);

	TD_Appel[playerid][2] = CreatePlayerTextDraw(playerid, 476.333343, 326.474090, "pseudo");
	PlayerTextDrawLetterSize(playerid, TD_Appel[playerid][2], 0.304333, 1.355259);
	PlayerTextDrawAlignment(playerid, TD_Appel[playerid][2], 1);
	PlayerTextDrawColor(playerid, TD_Appel[playerid][2], -1);
	PlayerTextDrawSetShadow(playerid, TD_Appel[playerid][2], 1);
	PlayerTextDrawSetOutline(playerid, TD_Appel[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_Appel[playerid][2], 255);
	PlayerTextDrawFont(playerid, TD_Appel[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, TD_Appel[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, TD_Appel[playerid][2], 1);


	TD_Appel[playerid][3] = CreatePlayerTextDraw(playerid, 452.733184, 406.518432, "Y");
	PlayerTextDrawLetterSize(playerid, TD_Appel[playerid][3], 0.400000, 1.600000);
	PlayerTextDrawTextSize(playerid, TD_Appel[playerid][3], 0.000000, 14.000000);
	PlayerTextDrawAlignment(playerid, TD_Appel[playerid][3], 2);
	PlayerTextDrawColor(playerid, TD_Appel[playerid][3], -1);
	PlayerTextDrawUseBox(playerid, TD_Appel[playerid][3], 1);
	PlayerTextDrawBoxColor(playerid, TD_Appel[playerid][3], 8388863);
	PlayerTextDrawSetShadow(playerid, TD_Appel[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, TD_Appel[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_Appel[playerid][3], 255);
	PlayerTextDrawFont(playerid, TD_Appel[playerid][3], 1);
	PlayerTextDrawSetProportional(playerid, TD_Appel[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, TD_Appel[playerid][3], 0);

	TD_Appel[playerid][4] = CreatePlayerTextDraw(playerid, 527.766357, 406.233215, "N");
	PlayerTextDrawLetterSize(playerid, TD_Appel[playerid][4], 0.400000, 1.600000);
	PlayerTextDrawTextSize(playerid, TD_Appel[playerid][4], 0.000000, 14.000000);
	PlayerTextDrawAlignment(playerid, TD_Appel[playerid][4], 2);
	PlayerTextDrawColor(playerid, TD_Appel[playerid][4], -1);
	PlayerTextDrawUseBox(playerid, TD_Appel[playerid][4], 1);
	PlayerTextDrawBoxColor(playerid, TD_Appel[playerid][4], -16776961);
	PlayerTextDrawSetShadow(playerid, TD_Appel[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, TD_Appel[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_Appel[playerid][4], 255);
	PlayerTextDrawFont(playerid, TD_Appel[playerid][4], 1);
	PlayerTextDrawSetProportional(playerid, TD_Appel[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid, TD_Appel[playerid][4], 0);
}

ShowAppelTD(playerid)
{
	Phone[playerid] = false;
	new pname[MAX_PLAYER_NAME];
	GetPlayerName(TalkingID[playerid],pname,sizeof(pname));
	PlayerTextDrawSetString(playerid,TD_Appel[playerid][2],pname);
	PlayerTextDrawSetPreviewModel(playerid,TD_Appel[playerid][0],GetPlayerSkin(TalkingID[playerid]));
	for(new i;i<5;i++)
	{
	    PlayerTextDrawShow(playerid,TD_Appel[playerid][i]);

	}
	for(new i;i<4;i++)
	{
	    PlayerTextDrawShow(playerid,TD_Phone[playerid][i]);
	}
}

LessPlayerInRace(playerid)
{
	racetotal --;
	if(racetotal == 0)
	{
		RaceLoaded = false;
		IsRaceLoaded = false;
		SubMessage(playerid,MSG_BLUE,"La course est terminée !",5);
		racepos = 0;
	}
}

HideAppelTD(playerid)
{
	CancelSelectTextDraw(playerid);
	for(new i;i<5;i++)
	{
	    PlayerTextDrawHide(playerid,TD_Appel[playerid][i]);
	}
	for(new i;i<4;i++)
	{
	    PlayerTextDrawHide(playerid,TD_Phone[playerid][i]);
	}
}

ShowPhoneTD(playerid)
{
	Phone[playerid] = true;
	new string[256],day,month,hours,minutes,year,seconds;
	getdate(year,month,day);
	gettime(hours,minutes,seconds);
	format(string,sizeof(string),"%02d/%02d/%d",day,month,year);
	PlayerTextDrawSetString(playerid,TD_Phone[playerid][5],string);
	format(string,sizeof(string),"%02d:%02d",hours,minutes);
	PlayerTextDrawSetString(playerid,TD_Phone[playerid][4],string);
	SelectTextDraw(playerid,0x373737FF);
	for(new i;i<13;i++)
	{
		PlayerTextDrawShow(playerid,TD_Phone[playerid][i]);
	}
}

WriteSanctionFile(msg[])
{
	new File: fsanction = fopen(PathSanctions,io_append);
	fwrite(fsanction, msg);
	fclose(fsanction);
}

HidePhoneTD(playerid)
{
	Phone[playerid] = false;
	CancelSelectTextDraw(playerid);
	for(new i;i<13;i++)
	{
	    PlayerTextDrawHide(playerid,TD_Phone[playerid][i]);
	}

}

FailRobHouse(playerid)
{
	robbing[playerid] = false;
	gps[playerid] = false;
	DestroyVehicle(vmission[playerid]);
 	GameTextForPlayerEx(playerid, "~r~Échec de la mission !", 5000, 0);
	PlayAudioStream(playerid, "http://xdev-team.tk/creations/sao/Audio/Wasted.mp3");
	KillTimer(robhtimer[playerid]);
	DisablePlayerCheckpointEx(playerid);
	RemovePlayerAttachedObject(playerid,9);
	ClearAnimations(playerid);
	havebox[playerid] = false;
}

ShowDialogContacts(playerid)
{
	new string[256],msg[256];
	strcat(msg,"... Ajouter un nouveau contact\n");
	if(PlayerInfo[playerid][pContacts]>0)
	{
 		for(new i;i<PlayerInfo[playerid][pContacts];i++)
   		{
     		format(string,sizeof(string),"%s - %d\n",NameContact[playerid][i],NumContact[playerid][i]);
       		strcat(msg,string);
		}
	}

	return ShowPlayerDialog(playerid,6,DIALOG_STYLE_LIST,"Mes contacts",msg,"Aller","Quitter");
}

GivePlayerLevel(playerid,value)
{
	new INI:File = INI_Open(UserPath(playerid));
	PlayerInfo[playerid][pLevel] += value;
	INI_SetTag(File,"data");
	INI_WriteInt(File,"Level",PlayerInfo[playerid][pLevel]);
	INI_Close(File);
	SetPlayerScore(playerid,PlayerInfo[playerid][pLevel]);
	SetMarkerMission(playerid);
}

SetPlayerLevel(playerid,value)
{
	new INI:File = INI_Open(UserPath(playerid));
	PlayerInfo[playerid][pLevel] = value;
	INI_SetTag(File,"data");
	INI_WriteInt(File,"Level",PlayerInfo[playerid][pLevel]);
	INI_Close(File);
	SetPlayerScore(playerid,PlayerInfo[playerid][pLevel]);
	SetMarkerMission(playerid);
}

forward getINIString(filename[], section[], item[], result[]);
forward fcreate(filename[]);
forward LoadServ_data(name[],value[]);
forward LoadHouse_data(houseid,name[],value[]);
forward LoadCommerce_data(restoid,name[],value[]);
forward LoadPlayerRaces_data(playerid,name[],value[]);
forward LoadRaces_data(name[],value[]);
forward LoadVehicle_Veh(playerid,name[],value[]);
forward LoadUser_data(playerid,name[],value[]);
forward LoadBiz_data(bizid,name[],value[]);
forward LoadContacts_Contacts(playerid,name[],value[]);
forward LoadWeapons_Weap(playerid,name[],value[]);
forward LoadPickups_Pickups(playerid,name[],value[]);
forward EndCall(id1,id2,reason);
forward TimerBiz();
forward CountDown();
forward Speedometer(playerid);
forward Reboot();
forward MuteTimer(playerid);
forward JailTimer(playerid);
forward LoyerTime(playerid);
forward AnimPorter(playerid);
forward EndChargement(playerid);
forward RobHouseTimer(playerid);
forward RobTimer(playerid);
forward TimeSkydive(playerid);
forward BraquageCommerce(playerid);
forward BraquageTimer();
forward FadeOut(playerid,missionid);
forward Fade(playerid,missionid);
forward TimeDialogMission(playerid,missionid);
forward RemoveHandObject(playerid);
forward ResetActorAnim(actorid);
forward CoverActor(actorid);
forward SubTimer(playerid,index);

public SubTimer(playerid,index)
{
    PlayerTextDrawHide(playerid,TDMsg_Sub[playerid][index]);
	return 1;
}

public RemoveHandObject(playerid) RemovePlayerAttachedObject(playerid,4);
public ResetActorAnim(actorid)
{
	if(!IsActorDead(actorid))
	{
		ClearActorAnimations(actorid);
		ApplyActorAnimationEx(actorid,actlib[actorid],actname[actorid],4.0,1,1,1,1,0);
	}
}
public CoverActor(actorid) if(!IsActorDead(actorid)) ApplyActorAnimation(actorid, "PED", "cower",4.0,1,0,0,1,0);

public RobTimer(playerid)
{
	new INI:File = INI_Open(UserPath(playerid));
	timerob[playerid] ++;
	if(timerob[playerid] == 10)
	{
	    timerob[playerid] = -1;
		KillTimer(trob[playerid]);
		nextrob[playerid] = true;
	}
	INI_SetTag(File,"data");
	INI_WriteInt(File,"TimeRobHouse",timerob[playerid]);
	INI_Close(File);
}
public CountDown()
{
	new ColorRandom[] = {
	'b','h','g','p','r','y','w'};
	new CharRandom = ColorRandom[random(7)];
	new string[256];
	format(string,sizeof(string),"~%c~%d",CharRandom,timedown);
	GameTextForAll(string,1000,6);

	if(timedown ==0)
	{
	    if(racetotal == 0)
	    {
            IsRaceLoaded = false;
		    RaceLoaded = false;
			for(new i; i < MAX_PLAYERS ; i++)
			{
			    if(IsPlayerConnected(i) && InRace[i] == true)
			    {
			        EndRace(i);
				}
			}
			KillTimer(timercd);
			SendClientMessageToAll(RED,"La course a été annulée faute de participants !");
			return 1;
		}
	    GameTextForAll("~g~GO !",1000,6);
		if(CDFRace == true)
		{
			for(new i; i < MAX_PLAYERS; i++)
			{
			    if(IsPlayerConnected(i) && InRace[i] == true)
			    {
					TogglePlayerControllable(i,true);
	 				SetPlayerRaceCheckpoint(i,0,PosRace[1][0],PosRace[1][1],PosRace[1][2],PosRace[2][0],PosRace[2][1],PosRace[2][2],5.0);

				}
			}
			IsRaceLoaded = true;
		}
	    KillTimer(timercd);
	}
	timedown --;
	return 1;
}
public RobHouseTimer(playerid)
{
	ClearAnimations(playerid);
	SetPlayerAttachedObject( playerid, 9, 3799, 1, 0.04, 0.420760, 0.00000, 0.000000, 92.0, 0.000000,0.125,0.125, 0.125 );
 	SetTimerEx("AnimPorter",500,false,"i",playerid);
 	havebox[playerid] = true;
 	SubMessage(playerid,MSG_YELLOW,"Parfait ! Retournez vite à votre véhicule et prenez la fuite !",5);
 	DisablePlayerCheckpointEx(playerid);
 	SetPlayerCheckpoint(playerid,-1977.2008,1227.3647,31.6484,4.0);
}
public MuteTimer(playerid)
{
	SendClientMessage(playerid,BLUE,"[ADMIN] Vous avez été unmute, vous pouvez reparler !");
	muted[playerid] = false;
	return 1;
}
public JailTimer(playerid)
{
	SendClientMessage(playerid,BLUE,"[ADMIN] Vous avez été libéré !");
	jailed[playerid] = false;
	SpawnPlayerEx(playerid);
	return 1;
}
public AnimPorter(playerid)
{
	havebox[playerid] = true;
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
	return 1;
}
public Fade(playerid,missionid)
{
	counter++;
	PlayerTextDrawShow(playerid,TD_Fade[playerid][0]);
	if(counter==1)
	{
		PlayerTextDrawBoxColor(playerid,TD_Fade[playerid][0],0x00000000);
		PlayerTextDrawShow(playerid,TD_Fade[playerid][1]);

	}
	if(counter==11)
	{
		PlayerTextDrawBoxColor(playerid,TD_Fade[playerid][0],0x00000011);
		PlayerTextDrawHide(playerid,TD_Fade[playerid][1]);
	}
	if(counter==12) PlayerTextDrawBoxColor(playerid,TD_Fade[playerid][0],0x00000022);
	if(counter==13) PlayerTextDrawBoxColor(playerid,TD_Fade[playerid][0],0x00000033);
	if(counter==14) PlayerTextDrawBoxColor(playerid,TD_Fade[playerid][0],0x00000044);
	if(counter==15) PlayerTextDrawBoxColor(playerid,TD_Fade[playerid][0],0x00000055);
	if(counter==16) PlayerTextDrawBoxColor(playerid,TD_Fade[playerid][0],0x00000066);
	if(counter==17) PlayerTextDrawBoxColor(playerid,TD_Fade[playerid][0],0x00000077);
	if(counter==18) PlayerTextDrawBoxColor(playerid,TD_Fade[playerid][0],0x00000088);
	if(counter==19) PlayerTextDrawBoxColor(playerid,TD_Fade[playerid][0],0x00000099);
	if(counter==20) PlayerTextDrawBoxColor(playerid,TD_Fade[playerid][0],0x000000AA);
	if(counter==21) PlayerTextDrawBoxColor(playerid,TD_Fade[playerid][0],0x000000BB);
	if(counter==22) PlayerTextDrawBoxColor(playerid,TD_Fade[playerid][0],0x000000CC);
	if(counter==23) PlayerTextDrawBoxColor(playerid,TD_Fade[playerid][0],0x000000DD);
	if(counter==24) PlayerTextDrawBoxColor(playerid,TD_Fade[playerid][0],0x000000EE);
	UpdateTXD(playerid,TD_Fade[playerid][0]);
	if(counter==25)
	{
	    TogglePlayerControllable(playerid,true);
		KillTimer(ftimer[playerid]);
		counter = 0;
		switch(missionid)
		{
			case 201:
			{
				MTD(playerid,"",201,true);
				new string[MAX_PLAYER_NAME];
				format(string, sizeof(string), "MC_%d", GetPlayerVirtualWorld(playerid));
				MC[playerid] = CreateNPC(string,119, -2027.75, -40.9, 38.8,184.0, GetPlayerVirtualWorld(playerid),0,0);
			}
			case 204: MTD(playerid,"Au bar...",204,true);
			case 205:
			{
				SetPlayerCameraPos(playerid, 397.2,2530.3, 15.8648);
				SetPlayerCameraLookAt(playerid, 402.4, 2538.0, 16.5);
				SetPlayerFacingAngle(playerid, 145.75);
				MTD(playerid, "",205, true);
				TogglePlayerControllable(playerid, true);
				ApplyAnimation(playerid, "PED", "WALK_gang2", 4.0, 1, 1, 1, 0, 0, 1);
			}
			case 302: MTD(playerid,"Au bar...",302,true);
		}
	}

	return 1;
}
public FadeOut(playerid,missionid)
{
	counter++;
	PlayerTextDrawShow(playerid,TD_Fade[playerid][0]);
	if(counter==1)
	{
		PlayerTextDrawShow(playerid,TD_Fade[playerid][1]);
		PlayerTextDrawBoxColor(playerid,TD_Fade[playerid][0],0x000000FF);
		if(mission[playerid] == -1) SetPlayerPosEx(playerid, -789.0,501.0,1381.6, 0, 0);
	}
	if(counter==11)
	{
		PlayerTextDrawBoxColor(playerid,TD_Fade[playerid][0],0x000000DD);
		PlayerTextDrawHide(playerid,TD_Fade[playerid][1]);

		new string[MAX_PLAYER_NAME];
		format(string, sizeof(string), "PE_%d", GetPlayerVirtualWorld(playerid));
		PE[playerid] = GetPlayerID(string);
		SetPlayerSkin(PE[playerid], 47);
		SetPlayerVirtualWorld(PE[playerid], GetPlayerVirtualWorld(playerid));
		PutPlayerInVehicle(PE[playerid],vennemy[playerid], 0);
		SetPlayerCheckpoint(PE[playerid],-2059.1,-736.5,31.9,20.0);
	}
	if(counter==12) PlayerTextDrawBoxColor(playerid,TD_Fade[playerid][0],0x000000CC);
	if(counter==13) PlayerTextDrawBoxColor(playerid,TD_Fade[playerid][0],0x000000BB);
	if(counter==14) PlayerTextDrawBoxColor(playerid,TD_Fade[playerid][0],0x000000AA);
	if(counter==15) PlayerTextDrawBoxColor(playerid,TD_Fade[playerid][0],0x00000099);
	if(counter==16) PlayerTextDrawBoxColor(playerid,TD_Fade[playerid][0],0x00000088);
	if(counter==17) PlayerTextDrawBoxColor(playerid,TD_Fade[playerid][0],0x00000077);
	if(counter==18) PlayerTextDrawBoxColor(playerid,TD_Fade[playerid][0],0x00000066);
	if(counter==19) PlayerTextDrawBoxColor(playerid,TD_Fade[playerid][0],0x00000055);
	if(counter==20) PlayerTextDrawBoxColor(playerid,TD_Fade[playerid][0],0x00000044);
	if(counter==21) PlayerTextDrawBoxColor(playerid,TD_Fade[playerid][0],0x00000033);
	if(counter==22) PlayerTextDrawBoxColor(playerid,TD_Fade[playerid][0],0x00000022);
	if(counter==23) PlayerTextDrawBoxColor(playerid,TD_Fade[playerid][0],0x00000011);
	if(counter==24) PlayerTextDrawBoxColor(playerid,TD_Fade[playerid][0],0x00000000);
	UpdateTXD(playerid,TD_Fade[playerid][0]);
	if(counter==25)
	{
 		TogglePlayerControllable(playerid,true);
		KillTimer(ftimer[playerid]);
		PlayerTextDrawHide(playerid,TD_Fade[playerid][0]);
		counter = 0;
		switch(missionid)
		{
		    case -1:
		    {
		        SetPlayerPosEx(playerid,-753.5265,500.1738,1371.9109,1,0);
		        SetPlayerFacingAngle(playerid,237.0);
				GameTextForPlayer(playerid,"~w~Liberty City",2000,1);
			}
			case 201: StartDialog(playerid,1);
			case 1:
			{
				SetMissionObj(playerid, "Va voir matthew");
				PlayAudioStream(playerid,"http://xdev-team.tk/creations/sao/Audio/Drv14.mp3");
			}
			case 2: StartDialog(playerid,2);
			case 3: StartDialog(playerid,3);
			case 4: StartDialog(playerid,4);
			case 5: StartDialog(playerid,5);
			case 6: StartDialog(playerid,6);
			case 7: StartDialog(playerid,7);
			case 8: StartDialog(playerid,8);
			case 9: StartDialog(playerid,9);
			case 204:
			{
				SetPlayerCheckpoint(playerid, POSMISSION8, 5.0);
				SetMissionObj(playerid, "Retour aux bercailles ! Ramène Matthew");
		        SetPlayerDrunkLevel (playerid, 30000);
			}
			case 205: StartDialog(playerid,205);
			case 10:
			{
			    SetPlayerCheckpoint(playerid, -182.0,1163.0,20.0, 5.0);
			    SetMissionObj(playerid, "Va acheter un téléphone pour Matthew !");
			}
			case 101:
			{
				TogglePlayerControllable(playerid, true);
				PlayAudioStream(playerid, "http://xdev-team.tk/creations/sao/Audio/Drv13.mp3");

				new string[MAX_PLAYER_NAME];
				format(string, sizeof(string), "PG_%d", GetPlayerVirtualWorld(playerid));
				PG[playerid] = GetPlayerID(string);
				SetPlayerSkin(PG[playerid], 281);
				SetPlayerVirtualWorld(PG[playerid], GetPlayerVirtualWorld(playerid));
				PutPlayerInVehicle(PG[playerid],vmission[playerid], 0);

				PutPlayerInVehicle(playerid,vmission[playerid], 1);
				GivePlayerWeapon(playerid, 30, 200);
				SetMissionObj(playerid, "Tue l'ennemi ! (Appuies sur H)");
			}
			case 302:
			{
				SetPlayerCheckpoint(playerid, POSMISSION8, 5.0);
				SetMissionObj(playerid, "Ramène Matthew !");
		        SetPlayerDrunkLevel (playerid, 5000);
		        mission[playerid] = 301;
			}
		}
	}

	return 1;
}

public Reboot()
{
	GameTextForAllEx("~b~REDÉMARRAGE...", 10000, 3);
	SendClientMessageToAll(BLUE,"Le serveur redémarre ...");
	SendRconCommand("gmx");
	return 1;
}

public BraquageTimer()
{
	for(new i;i<2;i++)
	{
		SubMessage(braqueur[i],MSG_YELLOW,"T'as réussi ton braquage ! Tirez-vous avec l'argent !",5);
		role[braqueur[i]] = 3;
		SetPlayerCheckpoint(braqueur[i],-1945.0, 1000.0, 35.0, 4.00);
		SetPlayerAttachedObject(braqueur[i], 9, 1550, 1, 0.1, -0.3, 0, 0, 40, 0, 1, 1, 1);
	}
	KillTimer(tbraquage);
}

public LoyerTime(playerid)
{
	if(PlayerInfo[playerid][pMaison] != -1)
	{
		PlayerInfo[playerid][pLoyer] = 0;
		KillTimer(htimer[playerid]);
	}
	else
	{
		PlayerInfo[playerid][pLoyer]++;
		if(PlayerInfo[playerid][pLoyer] == 60)
		{
			PlayerInfo[playerid][pLoyer] = 0;
			SubMessage(playerid,MSG_BLUE,"Un loyer de $300 a été prélevé sur ton compte bancaire (Sauf si tu n'as pas d'argent).",5);

			if(PlayerInfo[playerid][pBanque] > 0) GivePlayerBanque(playerid,-300);
			else
			GiveMoneyBanque(300*2);
		}
	}
	new INI:File1 = INI_Open(UserPath(playerid));
	INI_SetTag(File1,"data");
	INI_WriteInt(File1,"Loyer",PlayerInfo[playerid][pLoyer]);
	INI_Close(File1);
	return 1;
}

public EndChargement(playerid)
{
	TogglePlayerControllable(playerid,true);
}

public fcreate(filename[])
{
    if (fexist(filename)){return false;}
    new File:fhandle = fopen(filename,io_append);
    fclose(fhandle);
    return true;
}

public getINIString( filename[], section[], item[], result[] ) {
  new File:inifile;
  new line[512];
  new sectionstr[64], itemstr[64];
  new sectionfound = 0;

  inifile = fopen( filename, io_read );
  if( !inifile ) {
    printf( "FATAL: Couldn't open \"%s\"!", filename );
    return 0;
  }

  format( sectionstr, 64, "[%s]", section );
  format( itemstr, 64, "%s=", item );

  while( fread( inifile, line )) {
    line[strlen( line )-2] = 0;

    if( line[0] == 0 ) {
      continue;
    }

    if( !sectionfound ) {
      if( !strcmp( line, sectionstr, true, strlen( sectionstr ))) {
        sectionfound = 1;
      }
    }
    else {
      if( line[0] == '[' ) {
        return 0;
       }

      if( !strcmp( line, itemstr, true, strlen( itemstr ))) {
        format( result, sizeof( line ), "%s", line[strlen( itemstr )] );
        return 1;
      }
    }
  }

  fclose( inifile );
  return 0;
}

public LoadServ_data(name[],value[])
{
	INI_Int("Argent",MoneyBanque);
	INI_Int("Burger",MoneyResto[BURGER]);
	INI_Int("Pizza",MoneyResto[PIZZA]);
	INI_Int("Cluckin",MoneyResto[CLUCKIN]);
	INI_Int("ServActor",ServActor);
	INI_Int("Races",Races);
	return 1;
}

public LoadPickups_Pickups(playerid,name[],value[])
{
	new string[256];
	for(new i; i < MAX_SLOTS ; i++)
	{
	    format(string,sizeof(string),"Slot_%d",i);
	    INI_Bool(string,PickupTaken[playerid][i]);
	}
	return 1;
}

public LoadPlayerRaces_data(playerid,name[],value[])
{
	INI_Int("Model",RacePlayer[playerid][Model]);
	INI_String("Name",RacePlayer[playerid][RaceName],256);
	INI_Int("CP",RacePlayer[playerid][CPMax]);
	INI_Float("Angle",RacePlayer[playerid][Ang]);
	return 1;
}

public LoadRaces_data(name[],value[])
{
	new string[256];
	INI_Int("Model",typecar);
	INI_String("Name",NameRace,256);
	INI_Int("CP",CpRace);
	INI_Float("Angle",Angle);
	for(new i=1; i < CpRace + 1; i++)
	{
	    format(string,sizeof(string),"CPX_%d",i);
	    INI_Float(string,PosRace[i][0]);
		format(string,sizeof(string),"CPY_%d",i);
		INI_Float(string,PosRace[i][1]);
		format(string,sizeof(string),"CPZ_%d",i);
		INI_Float(string,PosRace[i][2]);
	}
	return 1;
}

public LoadHouse_data(houseid,name[],value[])
{
	INI_Float("X1",HouseInfo[houseid][X1]);
	INI_Float("Y1",HouseInfo[houseid][Y1]);
	INI_Float("Z1",HouseInfo[houseid][Z1]);
	INI_Float("eX",HouseInfo[houseid][eX]);
	INI_Float("eY",HouseInfo[houseid][eY]);
	INI_Float("eZ",HouseInfo[houseid][eZ]);
	INI_Float("cX",HouseInfo[houseid][cX]);
	INI_Float("cY",HouseInfo[houseid][cY]);
	INI_Float("cZ",HouseInfo[houseid][cZ]);
	INI_String("Proprio",proprio[houseid],MAX_PLAYER_NAME);
	INI_Int("Type",HouseInfo[houseid][Type]);
	INI_Int("Interior",HouseInfo[houseid][Interior]);
	INI_Int("Prix",HouseInfo[houseid][Prix]);
	INI_Int("Lock",HouseInfo[houseid][Lock]);
	return 1;
}

public LoadCommerce_data(restoid,name[],value[])
{
	INI_Float("X1",CommerceInfo[restoid][X1]);
	INI_Float("Y1",CommerceInfo[restoid][Y1]);
	INI_Float("Z1",CommerceInfo[restoid][Z1]);
	INI_Float("eX",CommerceInfo[restoid][eX]);
	INI_Float("eY",CommerceInfo[restoid][eY]);
	INI_Float("eZ",CommerceInfo[restoid][eZ]);
	INI_Int("Type",CommerceInfo[restoid][Type]);
	INI_Int("Interior",CommerceInfo[restoid][Interieur]);
	return 1;
}

public LoadBiz_data(bizid,name[],value[])
{
	INI_Float("X1",BizInfo[bizid][X]);
	INI_Float("Y1",BizInfo[bizid][Y]);
	INI_Float("Z1",BizInfo[bizid][Z]);
	INI_String("Proprio",bproprio[bizid],MAX_PLAYER_NAME);
	INI_Int("Type",BizInfo[bizid][Type]);
	INI_Int("Caisse",BizInfo[bizid][Caisse]);
	INI_Int("CaisseMax",BizInfo[bizid][CaisseMax]);
	INI_Int("Prix",BizInfo[bizid][Prix]);
	INI_Int("Revenus",BizInfo[bizid][Revenus]);
	return 1;
}

public LoadWeapons_Weap(playerid,name[],value[])
{
	INI_Int("9mm",PlayerInfo[playerid][p9mm]);
	INI_Int("Silencieux",PlayerInfo[playerid][pS9mm]);
	INI_Int("Eagle",PlayerInfo[playerid][pEagle]);
	INI_Int("Shotgun",PlayerInfo[playerid][pShotgun]);
	INI_Int("Sawnoff",PlayerInfo[playerid][pSawnoff]);
	INI_Int("CombatShotgun",PlayerInfo[playerid][pCShotgun]);
	INI_Int("UZI",PlayerInfo[playerid][pUzi]);
	INI_Int("MP5",PlayerInfo[playerid][pMp5]);
	INI_Int("AK47",PlayerInfo[playerid][pAk47]);
	INI_Int("M4",PlayerInfo[playerid][pM4]);
	INI_Int("TEC9",PlayerInfo[playerid][pTec9]);
    INI_Int("Rifle",PlayerInfo[playerid][pRifle]);
    INI_Int("Sniper",PlayerInfo[playerid][pSniper]);
    return 1;
}

public TimeSkydive(playerid)
{
	skydiving[playerid] = true;
}

public TimeDialogMission(playerid,missionid)
{

	countdia[playerid] ++;
	if(PressN[playerid] == true)
	{
		switch(missionid)
		{
		    case 1 : countdia[playerid] = 6;
		    case 2,5 : countdia[playerid] = 10;
		    case 3 : countdia[playerid] = 8;
		    case 4 : countdia[playerid] = 13;
		    case 6 : countdia[playerid] = 5;
		    case 7 : countdia[playerid] = 9;
		    case 10 : countdia[playerid] = 7;
		    case 8 : countdia[playerid] = 31;
		    case 9 : countdia[playerid] = 23;
		}
		PressN[playerid] = false;
	}
	if(missionid == 1 && countdia[playerid] == 1) ApplyAnimation(MC[playerid], "RIOT", "RIOT_CHANT", 4.0, 1, 1, 1, 1, 0, 1);
	if(missionid == 1 && countdia[playerid] == 2) ApplyAnimation(MC[playerid], "PED", "factalk", 4.0, 0, 1, 1, 1, 0, 1);
	if(missionid == 1 && countdia[playerid] == 3) ApplyAnimation(MC[playerid], "GANGS", "prtial_gngtlkG", 4.0, 0, 1, 1, 1, 0, 1);
	if(missionid == 1 && countdia[playerid] == 4) ApplyAnimation(MC[playerid], "GANGS", "prtial_gngtlkB", 4.0, 0, 1, 1, 1, 0, 1);
	if(missionid == 1 && countdia[playerid] == 5) ApplyAnimation(playerid, "GANGS", "Invite_Yes", 4.0, 0, 1, 1, 1, 0, 1);
	if(missionid == 1 && countdia[playerid] == 6)
	{
	    ClearAnimations(playerid);
		EndMission(playerid,1);
	}

	if(missionid == 2 && countdia[playerid] == 1) ApplyAnimation(FL[playerid], "COP_AMBIENT", "Coplook_loop", 4.0, 1, 1, 1, 0, 1);
	if(missionid == 2 && countdia[playerid] == 2) ApplyAnimation(playerid, "RIOT", "RIOT_challenge", 4.0, 0, 1, 1, 1, 0, 1);
	if(missionid == 2 && countdia[playerid] == 3) ApplyAnimation(FL[playerid], "PED", "endchat01", 4.0, 0, 1, 1, 1, 0, 1);
	if(missionid == 2 && countdia[playerid] == 4) ApplyAnimation(playerid, "PED", "factalk", 4.0, 0, 1, 1, 1, 0, 1);
	if(missionid == 2 && countdia[playerid] == 5) ApplyAnimation(FL[playerid], "GANGS", "DEALER_DEAL", 4.0, 0, 1, 1, 1, 0, 1);
	if(missionid == 2 && countdia[playerid] == 6) ApplyAnimation(playerid, "PED", "XPRESSscratch", 4.0, 0, 1, 1, 1, 0, 1);
	if(missionid == 2 && countdia[playerid] == 7)
	{
	    ClearAnimations(playerid);
		ApplyAnimation(FL[playerid], "GANGS", "prtial_gngtlkD", 4.0, 0, 1, 1, 0, 1);
	}
	if(missionid == 2 && countdia[playerid] == 8) ApplyAnimation(FL[playerid], "PED", "gang_gunstand", 4.0, 0, 1, 1, 1, 0, 1);
	if(missionid == 2 && countdia[playerid] == 9) ApplyAnimation(FL[playerid], "GANGS", "prtial_gngtlkA", 4.0, 0, 1, 1, 1, 0, 1);
	if(missionid == 2 && countdia[playerid] == 10)
	{
	    SetPlayerPos(playerid,POSMISSION2);
	    SetPlayerInterior(playerid,0);
	    TogglePlayerControllable(playerid, true);
	    ClearAnimations(playerid);
	    SetMissionObj(playerid, "Monte dans le boxville");
	    vmission[playerid] = CreateVehicle(498,-2217.01,314.95,35.33,-90.0,-1,-1,-1,0);
		SetVehicleParamsEx(vmission[playerid], 1, 0, 0, 0, 0, 0, 1);
	    SetVehicleVirtualWorld(vmission[playerid],GetPlayerVirtualWorld(playerid));
	    PlayerTextDrawHide(playerid,TD_Dialog[playerid]);
	    SetCameraBehindPlayer(playerid);
		PlayAudioStream(playerid, "http://xdev-team.tk/creations/sao/Audio/D3R-Rftps1.mp3");
		DestroyNPC(FL[playerid]);
		countdia[playerid] = 0;
		KillTimer(timedialog[playerid]);
	}

	if(missionid == 3 && countdia[playerid] == 1) ApplyAnimation(FL[playerid], "ON_LOOKERS", "Pointup_loop", 4.0, 0, 1, 1, 1, 0, 1);
	if(missionid == 3 && countdia[playerid] == 2) ClearAnimations(FL[playerid]);
	if(missionid == 3 && countdia[playerid] == 3)
	{
		ApplyAnimation(FL[playerid], "GRENADE", "WEAPON_throwu", 4.0, 0, 1, 1, 1, 0, 1);
		ApplyAnimation(playerid, "POLICE", "CopTraf_Away", 4.0, 0, 1, 1, 1, 0, 1);
		GivePlayerWeapon(playerid,22,100);
	}
	if(missionid == 3 && countdia[playerid] == 4) ApplyAnimation(FL[playerid], "PED", "Invite_No", 4.0, 0, 1, 1, 1, 0, 1);
	if(missionid == 3 && countdia[playerid] == 5) ApplyAnimation(playerid, "GANGS", "hndshkba", 4.0, 0, 1, 1, 1, 0, 1);
	if(missionid == 3 && countdia[playerid] == 6) ApplyAnimation(FL[playerid], "GANGS", "prtial_gngtlkH", 4.0, 1, 1, 1, 1, 0, 1);
	if(missionid == 3 && countdia[playerid] == 8)
	{
	    SetPlayerPos(playerid,POSMISSION2);
	    SetPlayerInterior(playerid,0);
	    TogglePlayerControllable(playerid, true);
	    ClearAnimations(playerid);
	    SetMissionObj(playerid, "Monte dans la voiture");
		PlayAudioStream(playerid, "http://xdev-team.tk/creations/sao/Audio/D3R-MD.mp3");
	    vmission[playerid] = CreateVehicle(475,-2217.01,314.95,35.33,-90.0,36,36,-1,0);
		SetVehicleParamsEx(vmission[playerid], 1, 0, 0, 0, 0, 0, 1);
	    SetVehicleVirtualWorld(vmission[playerid],GetPlayerVirtualWorld(playerid));
	    PlayerTextDrawHide(playerid,TD_Dialog[playerid]);
	    SetCameraBehindPlayer(playerid);
		SetPlayerCheckpoint(playerid,ENTREPOT,1.0);
		DestroyNPC(FL[playerid]);
		ResetPlayerWeapons(playerid);
		GivePlayerWeapon(playerid,22,100);
		countdia[playerid] = 0;
		KillTimer(timedialog[playerid]);
	}

	if(missionid == 4 && countdia[playerid] == 1) ApplyAnimation(playerid, "PED", "fucku", 4.0, 0, 1, 1, 1, 0, 1);
	if(missionid == 4 && countdia[playerid] == 2) ApplyAnimation(AM[playerid], "GANGS", "Invite_Yes", 4.0, 0, 1, 1, 1, 0, 1);
	if(missionid == 4 && countdia[playerid] == 3) ApplyAnimation(playerid, "PED", "XPRESSscratch", 4.0, 0, 1, 1, 1, 0, 1);
	if(missionid == 4 && countdia[playerid] == 4)
	{
	    ClearAnimations(playerid);
		ApplyAnimation(AM[playerid], "GANGS", "prtial_gngtlkC", 4.0, 0, 1, 1, 0, 1);
	}
	if(missionid == 4 && countdia[playerid] == 5) ApplyAnimation(playerid, "PED", "factalk", 4.0, 0, 1, 1, 1, 0, 1);
	if(missionid == 4 && countdia[playerid] == 6) ApplyAnimation(AM[playerid], "GANGS", "leanIN", 4.0, 0, 1, 1, 1, 0, 1);
	if(missionid == 4 && countdia[playerid] == 7) ApplyAnimation(playerid, "GANGS", "Invite_No", 4.0, 0, 1, 1, 1, 0, 1);
	if(missionid == 4 && countdia[playerid] == 8) ApplyAnimation(AM[playerid],"PED","ATM",4.1,0,1,1,1,1,1);
	if(missionid == 4 && countdia[playerid] == 9) ApplyAnimation(AM[playerid],"GANGS","Invite_Yes",4.1,0,1,1,1,1,1);
	if(missionid == 4 && countdia[playerid] == 10) ApplyAnimation(playerid,"PED","factalk",4.1,0,1,1,1,1,1);
	if(missionid == 4 && countdia[playerid] == 11) ApplyAnimation(AM[playerid], "COP_AMBIENT", "Coplook_loop", 4.0, 1, 1, 1, 0, 1);
	if(missionid == 4 && countdia[playerid] == 12) ApplyAnimation(playerid,"PED","factalk",4.1,0,1,1,1,1,1);
	if(missionid == 4 && countdia[playerid] == 13) EndMission(playerid,4);

	if(missionid == 5 && countdia[playerid] == 1) ApplyAnimation(MC[playerid], "GANGS", "hndshkba", 4.0, 0, 1, 1, 1, 0, 1);
	if(missionid == 5 && countdia[playerid] == 2) ApplyAnimation(playerid, "RIOT", "RIOT_shout", 4.0, 0, 1, 1, 1, 0, 1);
	if(missionid == 5 && countdia[playerid] == 3) ApplyAnimation(MC[playerid], "PED", "factalk", 4.0, 0, 1, 1, 1, 0, 1);
	if(missionid == 5 && countdia[playerid] == 4) ApplyAnimation(playerid, "GANGS", "prtial_gngtlkC", 4.0, 0, 1, 1, 1, 0, 1);
	if(missionid == 5 && countdia[playerid] == 5) ApplyAnimation(playerid, "GANGS", "Invite_YES", 4.0, 0, 1, 1, 1, 0, 1);
	if(missionid == 5 && countdia[playerid] == 6) ApplyAnimation(MC[playerid], "RIOT", "RIOT_challenge", 4.0, 0, 1, 1, 1, 0, 1);
	if(missionid == 5 && countdia[playerid] == 7) ApplyAnimation(playerid, "PED", "factalk", 4.0, 0, 1, 1, 0, 1);
	if(missionid == 5 && countdia[playerid] == 8) ApplyAnimation(MC[playerid], "GANGS", "prtial_gngtlkA", 4.0, 0, 1, 1, 0, 1);
	if(missionid == 5 && countdia[playerid] == 9) ApplyAnimation(playerid, "GANGS", "prtial_hndshk_01", 4.0, 0, 1, 1, 1, 0, 1);
	if(missionid == 5 && countdia[playerid] == 10) EndMission(playerid,5);

	if(missionid == 6 && countdia[playerid] == 5)
	{
		vennemy[playerid] = CreateVehicle(405,-2239.8,369.0,35.0,270.0,24,24,-1,0);
		SetVehicleParamsEx(vennemy[playerid], 1, 0, 0, 0, 0, 0, 1);
 		vhealth[vennemy[playerid]] = 1000;
		SetVehicleVirtualWorld(vennemy[playerid],GetPlayerVirtualWorld(playerid));
		vmission[playerid] = CreateVehicle(560,-2239.8,369.0,35.0,0,0,-1,0);
 		vhealth[vmission[playerid]] = 1000;
 		SetVehicleParamsEx(vmission[playerid], 1, 0, 0, 0, 0, 0, 1);
		SetVehicleVirtualWorld(vmission[playerid],GetPlayerVirtualWorld(playerid));

		new string[MAX_PLAYER_NAME];
		format(string, sizeof(string), "AMG_%d", GetPlayerVirtualWorld(playerid));
		ConnectNPC(string, "AMG");
		format(string, sizeof(string), "AME_%d", GetPlayerVirtualWorld(playerid));
		ConnectNPC(string, "AME");
	}
	if(missionid == 6 && countdia[playerid] == 6)
	{
		new string[MAX_PLAYER_NAME];

		format(string, sizeof(string), "AMG_%d", GetPlayerVirtualWorld(playerid));
		AMG[playerid] = GetPlayerID(string);
		SetPlayerSkin(AMG[playerid], 112);
		SetPlayerVirtualWorld(AMG[playerid], GetPlayerVirtualWorld(playerid));
		PutPlayerInVehicle(AMG[playerid], vmission[playerid], 0);

		format(string, sizeof(string), "AME_%d", GetPlayerVirtualWorld(playerid));
		AME[playerid] = GetPlayerID(string);
		SetPlayerSkin(AME[playerid], 120);
		SetPlayerCheckpoint(AME[playerid],-2457.068359,2297.263183,4.618873,30.0);
		SetPlayerVirtualWorld(AME[playerid], GetPlayerVirtualWorld(playerid));
		PutPlayerInVehicle(AME[playerid], vennemy[playerid], 0);
	}
    if(missionid == 6 && countdia[playerid] == 7)
    {
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
		RemovePlayerAttachedObject(playerid, 4);
		PlayerTextDrawHide(playerid,TD_Dialog[playerid]);
		TogglePlayerControllable(playerid, true);
		PlayAudioStream(playerid, "http://xdev-team.tk/creations/sao/Audio/Drv11.mp3");
		PutPlayerInVehicle(playerid,vmission[playerid], 1);
		SetVehicleParamsEx(vmission[playerid], 1, 0, 0, 0, 0, 0, 0);
		GivePlayerWeapon(playerid, 30, 200);
		SetMissionObj(playerid, "Tue l'ennemi ! (Appuies sur H)");
		countdia[playerid] = 0;
		KillTimer(timedialog[playerid]);
	}
	if(missionid == 7 && countdia[playerid] == 1) ApplyAnimation(AM[playerid],"COP_AMBIENT","Coplook_loop",4.0,1,0,0,0,0, 1);
	if(missionid == 7 && countdia[playerid] == 2) ApplyAnimation(playerid, "COP_AMBIENT", "Coplook_loop", 4.0, 0, 1, 1, 0, 1);
	if(missionid == 7 && countdia[playerid] == 3) ApplyAnimation(AM[playerid], "GANGS", "Invite_Yes", 4.0, 0, 1, 1, 0, 1);
	if(missionid == 7 && countdia[playerid] == 4) ApplyAnimation(playerid, "GANGS", "Invite_No", 4.0, 0, 1, 1, 1, -1);
	if(missionid == 7 && countdia[playerid] == 5) ApplyAnimation(playerid, "COP_AMBIENT", "Coplook_loop", 4.0, 0, 1, 1, 0, 1);
	if(missionid == 7 && countdia[playerid] == 6) ApplyAnimation(AM[playerid], "GANGS", "prtial_gngtlkH", 4.0, 0, 1, 1, 0, 1);
	if(missionid == 7 && countdia[playerid] == 7) ApplyAnimation(AM[playerid], "GANGS", "prtial_gngtlkH", 4.0, 0, 1, 1, 0, 1);
	if(missionid == 7 && countdia[playerid] == 8) ApplyAnimation(playerid, "RIOT", "RIOT_FUKU", 4.0, 0, 1, 1, 0, 1);
	if(missionid == 7 && countdia[playerid] == 9)
	{
		ApplyAnimation(AM[playerid], "ON_LOOKERS", "Pointup_loop", 4.0, 0, 1, 1, 0, 1);

		new string[MAX_PLAYER_NAME];
		format(string, sizeof(string), "RE0_%d", GetPlayerVirtualWorld(playerid));
		ConnectNPC(string, "RE");
		vennemy[playerid] = CreateVehicle(560,-2253.804931,346.750396,32.938728,270.0,0,0,-1,0);
		SetVehicleParamsEx(vennemy[playerid], 1, 0, 0, 0, 0, 0, 1);
	    SetVehicleVirtualWorld(vennemy[playerid],GetPlayerVirtualWorld(playerid));
	    vmission[playerid] = CreateVehicle(475,-2217.01,314.95,35.33,-90.0,36,36,-1,0);
		SetVehicleParamsEx(vmission[playerid], 1, 0, 0, 0, 0, 0, 1);
	    SetVehicleVirtualWorld(vmission[playerid],GetPlayerVirtualWorld(playerid));
	}
	if(missionid == 7 && countdia[playerid] == 10)
	{
		PlayerTextDrawHide(playerid,TD_Dialog[playerid]);
		SetPlayerPos(playerid,POSMISSION2);
	    SetPlayerInterior(playerid,0);
	    SetCameraBehindPlayer(playerid);
		TogglePlayerControllable(playerid, true);
	    ClearAnimations(playerid);
	    DestroyNPC(AM[playerid]);
		PlayAudioStream(playerid, "http://xdev-team.tk/creations/sao/Audio/Drv5.mp3");
	    SetMissionObj(playerid, "Monte dans la voiture et fonce chez Matthew avant les russes !");
		SetPlayerCheckpoint(playerid,-2033.0,-62.22,35.3,5.0);

		new string[MAX_PLAYER_NAME];
		format(string, sizeof(string), "RE0_%d", GetPlayerVirtualWorld(playerid));
		RE[playerid][0] = GetPlayerID(string);
		SetPlayerSkin(RE[playerid][0], 111);
		SetPlayerVirtualWorld(RE[playerid][0], GetPlayerVirtualWorld(playerid));
		PutPlayerInVehicle(RE[playerid][0], vennemy[playerid], 0);
		SetPlayerCheckpoint(RE[playerid][0],-2033.0,-62.22,35.3,10.0);

		for(new i = 1;i<4;i++)
		{
			format(string, sizeof(string), "RE%d_%d",i,GetPlayerVirtualWorld(playerid));
			RE[playerid][i] = CreateNPC(string,randomEx(111,113),-2253.804931,346.750396,32.938728,0.0, GetPlayerVirtualWorld(playerid),0,0);
			FCNPC_PutInVehicle(RE[playerid][i], vennemy[playerid], i);
		}
        KillTimer(timedialog[playerid]);
		countdia[playerid] = 0;
	}
	if(missionid == 8 && countdia[playerid] == 1) ApplyAnimation(MC[playerid], "RIOT", "RIOT_CHANT", 4.0, 0, 1, 1, 1, 0, 1);
	if(missionid == 8 && countdia[playerid] == 2) ApplyAnimation(playerid, "PED", "fucku", 4.0, 0, 1, 1, 1, 0, 1);
	if(missionid == 8 && countdia[playerid] == 3) ApplyAnimation(MC[playerid], "PED", "factalk", 4.0, 0, 1, 1, 1, 0, 1);
	if(missionid == 8 && countdia[playerid] == 4) ApplyAnimation(playerid, "RIOT", "RIOT_challenge", 4.0, 0, 1, 1, 1, 0, 1);
	if(missionid == 8 && countdia[playerid] == 5) ApplyAnimation(MC[playerid], "PED", "fucku", 4.0, 0, 1, 1, 1, 0, 1);
	if(missionid == 8 && countdia[playerid] == 6) ApplyAnimation(playerid, "GANGS", "Invite_No", 4.0, 0, 1, 1, 1, 0, 1);
	if(missionid == 8 && countdia[playerid] == 7) ApplyAnimation(playerid, "RIOT", "RIOT_challenge", 4.0, 0, 1, 1, 1, 0, 1);
	if(missionid == 8 && countdia[playerid] == 8) ApplyAnimation(MC[playerid], "GANGS", "prtial_gngtlkD", 4.0, 0, 1, 1, 1, 0, 1);
	if(missionid == 8 && countdia[playerid] == 9) ApplyAnimation(playerid, "GANGS", "prtial_gngtlkB", 4.0, 0, 1, 1, 1, 0, 1);
	if(missionid == 8 && countdia[playerid] == 10) ApplyAnimation(playerid, "PED", "fucku", 4.0, 0, 1, 1, 1, 0, 1);
	if(missionid == 8 && countdia[playerid] == 11)
	{
		ApplyAnimation(MC[playerid], "GANGS", "Invite_Yes", 4.0, 0, 1, 1, 1, 0, 1);
	    new string[MAX_PLAYER_NAME];
		format(string, sizeof(string), "VH_%d", GetPlayerVirtualWorld(playerid));
		VH[playerid] = CreateNPC(string,160,396.0,2530.0,16.5,0.0, GetPlayerVirtualWorld(playerid),0,0);
	}
	if(mission[playerid] != 0 && PlayerInfo[pInfo][pLevel] == 7 && countdia[playerid] == 12)
	{
		FCNPC_GoTo(VH[playerid], 400.4, 2536.2, 16.5, MOVE_TYPE_WALK, MOVE_SPEED_WALK,true);
	}
	if(missionid == 8 && countdia[playerid] == 13) ApplyAnimation(playerid, "PED", "factalk", 4.0, 0, 1, 1, 1, 0, 1);
	if(missionid == 8 && countdia[playerid] == 14) ApplyAnimation(VH[playerid], "GANGS", "prtial_gngtlkD", 4.0, 0, 1, 1, 1, 0, 1);
	if(missionid == 8 && countdia[playerid] == 15) ApplyAnimation(MC[playerid], "GANGS", "prtial_gngtlkC", 4.0, 0, 1, 1, 1, 0, 1);
	if(missionid == 8 && countdia[playerid] == 16) ApplyAnimation(playerid, "PED", "fucku", 4.0, 0, 1, 1, 1, 0, 1);
	if(missionid == 8 && countdia[playerid] == 17) ApplyAnimation(VH[playerid], "GANGS", "Invite_Yes", 4.0, 0, 1, 1, 1, 0, 1);
	if(missionid == 8 && countdia[playerid] == 18) ApplyAnimation(playerid, "PED", "factalk", 4.0, 0, 1, 1, 1, 0, 1);
	if(missionid == 8 && countdia[playerid] == 19) ApplyAnimation(VH[playerid], "GANGS", "prtial_gngtlkF", 4.0, 0, 1, 1, 1, 0, 1);
	if(missionid == 8 && countdia[playerid] == 20) ApplyAnimation(playerid, "GANGS", "prtial_gngtlkD", 4.0, 0, 1, 1, 1, 0, 1);
	if(missionid == 8 && countdia[playerid] == 21) ApplyAnimation(VH[playerid], "PED", "fucku", 4.0, 0, 1, 1, 1, 0, 1);
	if(missionid == 8 && countdia[playerid] == 22) ApplyAnimation(playerid, "PED", "factalk", 4.0, 0, 1, 1, 1, 0, 1);
	if(missionid == 8 && countdia[playerid] == 23) ApplyAnimation(VH[playerid], "GANGS", "prtial_gngtlkE", 4.0, 0, 1, 1, 1, 0, 1);
	if(missionid == 8 && countdia[playerid] == 24) ApplyAnimation(playerid, "GANGS", "prtial_gngtlkB", 4.0, 0, 1, 1, 1, 0, 1);
	if(missionid == 8 && countdia[playerid] == 25) ApplyAnimation(VH[playerid], "GANGS", "prtial_gngtlkC", 4.0, 0, 1, 1, 1, 0, 1);
	if(missionid == 8 && countdia[playerid] == 26) ApplyAnimation(playerid, "PED", "factalk", 4.0, 0, 1, 1, 1, 0, 1);
	if(missionid == 8 && countdia[playerid] == 27) ApplyAnimation(MC[playerid], "PED", "fucku", 4.0, 0, 1, 1, 1, 0, 1);
	if(missionid == 8 && countdia[playerid] == 28) ApplyAnimation(playerid, "GANGS", "prtial_gngtlkD", 4.0, 0, 1, 1, 1, 0, 1);
	if(missionid == 8 && countdia[playerid] == 29) ApplyAnimation(VH[playerid], "GANGS", "prtial_gngtlkH", 4.0, 0, 1, 1, 1, 0, 1);
	if(missionid == 8 && countdia[playerid] == 30) ApplyAnimation(playerid, "GANGS", "prtial_gngtlkH", 4.0, 0, 1, 1, 1, 0, 1);
    if(missionid == 8 && countdia[playerid] == 31)
    {
		PlayerTextDrawHide(playerid,TD_Dialog[playerid]);
		TogglePlayerControllable(playerid, true);
		PlayAudioStream(playerid, "http://xdev-team.tk/creations/sao/Audio/D3R-Rftps1.mp3");
		SetMissionObj(playerid, "Va chercher la voiture !");
		SetCameraBehindPlayer(playerid);
	    vmission[playerid] = CreateVehicle(510,400.0,2535.0,16.0,140.0,-1,-1,-1,0);
		SetVehicleParamsEx(vmission[playerid], 1, 0, 0, 0, 0, 0, 1);
	    vennemy[playerid] = CreateVehicle(478,221.0,1857.0,13.0,0.0,3,0,-1,0);
	    SetPlayerCheckpoint(playerid,221.0,1857.0,13.0,5.0);
		SetVehicleParamsEx(vennemy[playerid], 1, 0, 0, 0, 0, 0, 1);
	    SetVehicleVirtualWorld(vmission[playerid],GetPlayerVirtualWorld(playerid));
		SetVehicleVirtualWorld(vennemy[playerid],GetPlayerVirtualWorld(playerid));
	    DestroyNPC(MC[playerid]);
	    DestroyNPC(VH[playerid]);
	    countdia[playerid] = 0;
	    KillTimer(timedialog[playerid]);
	}


	if(missionid == 202 && countdia[playerid] == 2)
	{
		new string[MAX_PLAYER_NAME];
		format(string, sizeof(string), "MC_%d", GetPlayerVirtualWorld(playerid));
		MC[playerid] = CreateNPC(string,119, -2027.75, -40.9, 38.8,184.0, GetPlayerVirtualWorld(playerid),0,0);
	    FCNPC_EnterVehicle(MC[playerid], vmission[playerid], 1, MOVE_TYPE_SPRINT);
	}
	if(missionid == 202 && countdia[playerid] == 3)
	{
		countdia[playerid] = 0;
		PlayerTextDrawHide(playerid,TD_Dialog[playerid]);
		TogglePlayerControllable(playerid, true);
		SetPlayerCheckpoint(playerid,405,2450,16, 5.0);
		SetMissionObj(playerid, "Emmène Matthew dans un endroit sûr");
	}
	if(missionid == 203 && countdia[playerid] == 13)
	{
		PlayerTextDrawHide(playerid,TD_Dialog[playerid]);
		TogglePlayerControllable(playerid, true);
		EndMission(playerid,7);
	}

    if(missionid == 9 && countdia[playerid] == 23)
    {
		countdia[playerid] = 0;
		PlayerTextDrawHide(playerid,TD_Dialog[playerid]);
		TogglePlayerControllable(playerid, true);
		PlayAudioStream(playerid,"http://xdev-team.tk/creations/sao/Audio/Drv14.mp3");
		SetMissionObj(playerid, "Va au bar le plus proche !");
		SetCameraBehindPlayer(playerid);
	    vmission[playerid] = CreateVehicle(475,400.0,2535.0,16.0,140.0,36,36,-1,0);
		SetVehicleParamsEx(vmission[playerid], 1, 0, 0, 0, 0, 0, 1);
	    SetVehicleVirtualWorld(vmission[playerid],GetPlayerVirtualWorld(playerid));
		SetPlayerCheckpoint(playerid,-79.0,1340.0,11.0,5.0);
	    FCNPC_EnterVehicle(MC[playerid], vmission[playerid], 1);
	    KillTimer(timedialog[playerid]);
	}
	if(missionid == 204 && countdia[playerid] == 5)
	{
		EndMission(playerid,9);
	}
	if(missionid == 10 && countdia[playerid] == 7)
	{
		KillTimer(timedialog[playerid]);
		countdia[playerid] = 0;
		PlayerTextDrawHide(playerid,TD_Dialog[playerid]);
		PlayerTextDrawHide(playerid,TD_Obj[playerid]);
	    DestroyNPC(MC[playerid]);
     	SetCameraBehindPlayer(playerid);
		TogglePlayerControllable(playerid, true);
		MTD(playerid, "",205, false);
	}
	if(missionid == 205 && countdia[playerid] == 10) EndMission(playerid,10);

	if(missionid == 300 && countdia[playerid] == 6) EndMission(playerid, 300);

	if(missionid == 301 && countdia[playerid] == 6)
	{
 		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
		RemovePlayerAttachedObject(playerid, 4);
		PlayerTextDrawHide(playerid,TD_Dialog[playerid]);
	    SetPlayerCheckpoint(playerid,POSMISSION8, 5.0);
		SetMissionObj(playerid, "Va chercher Matthew !");
		countdia[playerid] = 0;
	}
	if(missionid == 302 && countdia[playerid] == 3)
	{
		PlayerTextDrawHide(playerid,TD_Dialog[playerid]);
		SetPlayerCheckpoint(playerid,-79.0,1340.0,11.0,5.0);
		countdia[playerid] = 0;
  		TogglePlayerControllable(playerid, true);
	}

	if(missionid == 303 && countdia[playerid] == 3) EndMission(playerid, 301);
	else
	{
		switch(missionid)
		{
		    case 1: SetDialogMessage(playerid, Mission1_Dialogs[countdia[playerid]-1]);
		    case 2: SetDialogMessage(playerid, Mission2_Dialogs[countdia[playerid]-1]);
		    case 3: SetDialogMessage(playerid, Mission3_Dialogs[countdia[playerid]-1]);
		    case 4: SetDialogMessage(playerid, Mission4_Dialogs[countdia[playerid]-1]);
		    case 5: SetDialogMessage(playerid, Mission5_Dialogs[countdia[playerid]-1]);
		    case 6: SetDialogMessage(playerid, Mission6_Dialogs[countdia[playerid]-1]);
		    case 7: SetDialogMessage(playerid, Mission7_Dialogs[countdia[playerid]-1]);
		    case 202: SetDialogMessage(playerid, Mission7_Dialogs2[countdia[playerid]-1]);
		    case 203: SetDialogMessage(playerid, Mission7_Dialogs3[countdia[playerid]-1]);
		    case 8: SetDialogMessage(playerid, Mission8_Dialogs[countdia[playerid]-1]);
		    case 9: SetDialogMessage(playerid, Mission9_Dialogs[countdia[playerid]-1]);
		    case 204: SetDialogMessage(playerid, Mission9_Dialogs2[countdia[playerid]-1]);
		    case 10: SetDialogMessage(playerid, Mission10_Dialogs[countdia[playerid]-1]);
		    case 205: SetDialogMessage(playerid, Mission10_Dialogs2[countdia[playerid]-1]);
		    case 300: SetDialogMessage(playerid, MatthewHR_Dialogs[countdia[playerid]-1]);
		    case 301: SetDialogMessage(playerid, MatthewH1_Dialogs[countdia[playerid]-1]);
		    case 302: SetDialogMessage(playerid, MatthewH1_Dialogs2[countdia[playerid]-1]);
		    case 303: SetDialogMessage(playerid, MatthewH1_Dialogs3[countdia[playerid]-1]);
		}
		timedialog[playerid] = SetTimerEx("TimeDialogMission",7000,false,"idd",playerid,missionid);
	}
}

public LoadVehicle_Veh(playerid,name[],value[])
{
	INI_Int("Model",VehicleInfo[playerid][Model]);
	INI_Float("X1",VehicleInfo[playerid][X]);
	INI_Float("Y1",VehicleInfo[playerid][Y]);
	INI_Float("Z1",VehicleInfo[playerid][Z]);
	INI_Float("A1",VehicleInfo[playerid][A]);
	INI_Int("Color1",VehicleInfo[playerid][Color1]);
	INI_Int("Color2",VehicleInfo[playerid][Color2]);
	INI_Int("PaintJob",VehicleInfo[playerid][PaintJob]);
	for(new i;i< 14 ;i++)
	{
		new string[7];
		format(string,sizeof(string),"Slot_%d",i);
		INI_Int(string,VehicleTuning[playerid][i]);
	}
	return 1;
}

public LoadUser_data(playerid,name[],value[])
{
    INI_Int("Password",PlayerInfo[playerid][pPass]);
    INI_Int("Cash",PlayerInfo[playerid][pCash]);
    INI_Int("Num",PlayerInfo[playerid][pNum]);
    INI_Bool("Tuto",PlayerInfo[playerid][pTuto]);
    INI_Int("Maison",PlayerInfo[playerid][pMaison]);
    INI_Int("Banque",PlayerInfo[playerid][pBanque]);
    INI_Bool("CarteBancaire",PlayerInfo[playerid][pCarte]);
    INI_Int("Skin",PlayerInfo[playerid][pSkin]);
	INI_Int("Loyer",PlayerInfo[playerid][pLoyer]);
	INI_Int("Level",PlayerInfo[playerid][pLevel]);
	INI_String("LastIp",LastIp[playerid],32);
	INI_Bool("Ban",PlayerInfo[playerid][pBan]);
	INI_Int("TimeRobHouse",timerob[playerid]);
	INI_Int("Biz",PlayerInfo[playerid][pBiz]);
	INI_Int("Etoiles",PlayerInfo[playerid][pEtoiles]);
    return 1;
}

public LoadContacts_Contacts(playerid,name[],value[])
{
	INI_Int("Contacts",PlayerInfo[playerid][pContacts]);
	new string[256];
	for(new i=0;i<PlayerInfo[playerid][pContacts];i++)
	{
	    format(string,sizeof(string),"Contact%d",i+1);
	    INI_String(string,NameContact[playerid][i],30);
		format(string,sizeof(string),"Num%d",i+1);
	    INI_Int(string,NumContact[playerid][i]);
	}
    return 1;
}

public BraquageCommerce(playerid)
{
	new string[256];
 	format(string,sizeof(string),"~y~Mission réussie ! ~n~~w~$%d",MoneyResto[cbraquage[playerid]]);
 	PlayAudioStream(playerid, "http://xdev-team.tk/creations/sao/Audio/VC-Miscom.mp3");
 	GameTextForPlayerEx(playerid, string, 5000, 0);
	GiveMoney(playerid,MoneyResto[cbraquage[playerid]]);
	MoneyResto[cbraquage[playerid]] = 0;
	GivePlayerWantedLevel(playerid,STAR_ROBCOMMERCE);
	EndCommBraquage(playerid);
	return 1;
}

public EndCall(id1,id2,reason)
{
	KillTimer(EndTimer[id1]);
	KillTimer(EndTimer[id2]);
	HideAppelTD(id1);
	HideAppelTD(id2);
	InCall[id1] = 0;
 	InCall[id2] = 0;
	InCall[id1] = 0;
	InCall[id2] = 0;
	Talking[id1] = 0;
	Talking[id2] = 0;
	TalkingID[id1] = -1;
	TalkingID[id2] = -1;
	IsCalling[id1] = 0;
 	SetPlayerSpecialAction(id1,SPECIAL_ACTION_STOPUSECELLPHONE);
	RemovePlayerAttachedObject(id1, 4);
	SetPlayerSpecialAction(id2,SPECIAL_ACTION_STOPUSECELLPHONE);
	RemovePlayerAttachedObject(id2, 4);
	if(reason == 1) // NO ANSWER
	{
    	new str[128];
		if(InCall[id1] == 1)
		{
			InCall[id1] = 0;
			SetPlayerSpecialAction(id1,SPECIAL_ACTION_STOPUSECELLPHONE);
			RemovePlayerAttachedObject(id1, 4);
			format(str,sizeof(str),"~r~\"%s\" n'a pas répondu à ton appel.",GetName(id2));
			SubMessage(id1,MSG_BLUE,str,5);
		}
		format(str,sizeof(str),"Tu n'as pas répondu à l'appel de \"%s (%d)\".",GetName(id1),PlayerInfo[id1][pNum]);
		SubMessage(id2,MSG_BLUE,str,5);
	}
	else if(reason == 2) // DISCONNECTED
	{
	    if(!IsPlayerConnected(id1))
	    {
	        SubMessage(id2,MSG_BLUE,"~r~L'appelant s'est déconnecté.",5);
		}
		else if(!IsPlayerConnected(id2))
		{
		    SubMessage(id1,MSG_BLUE,"~r~Le destinataire s'est déconnecté.",5);
		}
	}
	else if(reason == 3) // HANG UP
	{
	    SubMessage(id1,MSG_BLUE,"Appel terminé !",5);
	    SubMessage(id2,MSG_BLUE,"Appel terminé !",5);
	}
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER)
	{
		PlayAudioStreamForPlayer(playerid, "http://xdev-team.tk/creations/sao/Audio/radio.pls");
		
	    TextDrawShowForPlayer(playerid, Underline);
		TextDrawShowForPlayer(playerid, Title);
		TextDrawShowForPlayer(playerid, KMH);

	    for(new i = 0; i < GetMaxPlayers(); i++)
	    {
	        TextDrawShowForPlayer(playerid, VehicleName[playerid]);
	        TextDrawShowForPlayer(playerid, VehicleSpeed[playerid]);
	    }
	}
	else if(oldstate == PLAYER_STATE_DRIVER || oldstate == PLAYER_STATE_PASSENGER)
	{
	    TextDrawHideForPlayer(playerid, Underline);
		TextDrawHideForPlayer(playerid, Title);
		TextDrawHideForPlayer(playerid, KMH);

	    for(new i = 0; i < GetMaxPlayers(); i++)
	    {
	        TextDrawHideForPlayer(playerid, VehicleName[i]);
	        TextDrawHideForPlayer(playerid, VehicleSpeed[i]);
	    }
	    if(IsPlayerFree(playerid)) StopAudioStreamForPlayer(playerid);
	}
	if(newstate == PLAYER_STATE_DRIVER)
	{
		new vid = GetPlayerVehicleID(playerid);
		if(vPosseded[vid] == false && vid != vmission[playerid] && GetVehicleModel(vid) != 504)
		{
			new engine,
			lights,
			alarm,
			doors,
			bonnet,
			boot,
			objective;
			GetVehicleParamsEx(vid, engine, lights, alarm,	 doors, bonnet,boot,objective);
			SetVehicleParamsEx(vid, engine, lights, random(2), doors, bonnet, boot, objective);
		}
	}
	return 1;
}

public Speedometer(playerid)
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i) && IsPlayerInAnyVehicle(i))
	    {
			new string[32], string2[32];
			format(string, sizeof(string), "~g~%s", VehicleNames[GetVehicleModel(GetPlayerVehicleID(i))-400]);
			TextDrawSetString(VehicleName[i], string);

			format(string2, sizeof(string2), "%d", GetPlayerSpeed(i, 0));
			TextDrawSetString(VehicleSpeed[i], string2);
	    }
	}
	return 1;
}

public OnVehicleSpawn(vehicleid)
{

	for(new i;i<MAX_PLAYERS;i++)
	{
	    if(vmission[i] == vehicleid)
	    {
			vPosseded[vmission[i]] = true;
		}
	}

	if(vPosseded[vehicleid] == false && GetVehicleModel(vehicleid) != 504)
	{
		new engine = random(2),
		lights = 0,
		alarm,
		doors = random(2),
		bonnet = random(2),
		boot = 0,
		objective = 0;
		if(bonnet == 1)
		{
			SetVehicleHealth(vehicleid, randomEx(251, 400));
			engine = 0;
		}
		SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	}
	else
	{
		for(new i;i<MAX_PLAYERS;i++)
		{
		    if(jvehicle[i] == vehicleid)
		    {
   				ChangeVehicleColor(vehicleid,VehicleInfo[i][Color1],VehicleInfo[i][Color2]);
                SetVehiclePos(vehicleid,VehicleInfo[i][X],VehicleInfo[i][Y],VehicleInfo[i][Z]);
                SetVehicleZAngle(vehicleid,VehicleInfo[i][A]);
                if(VehicleInfo[i][PaintJob] != -1) ChangeVehiclePaintjob(vehicleid,VehicleInfo[i][PaintJob]);
		        for(new i2;i2<14;i2++)
				{
		            if(VehicleTuning[i][i2] != 0)
		            {
		                AddVehicleComponent(vehicleid,VehicleTuning[i][i2]);
					}
				}
			}
		}
	}
    return 1;
}

public OnVehicleDeath(vehicleid)
{
	if(vehicleid == vcop) DestroyVehicle(vehicleid);

	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	if(vehicleid == vmission[playerid] && mission[playerid] != 0)
	{
	    if(PlayerInfo[playerid][pLevel] == 0 || PlayerInfo[playerid][pLevel] == 1 || PlayerInfo[playerid][pLevel] == 3 || PlayerInfo[playerid][pLevel] == 5 || PlayerInfo[playerid][pLevel] == 6)
	    {
			new engine,
			lights,
			alarm,
			doors,
			bonnet,
			boot,
			objective;
			GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet,boot,objective);
			SetVehicleParamsEx(vehicleid, engine, lights, 0, 0, 0, 0, 1);
		}
	}
	else StopAudioStreamForPlayer(playerid);
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	SubMessage(playerid,MSG_BLUE,"~n~Faites ~w~/stopradio ~b~à tout moment pour enlever la musique",5);
	
	if(vehicleid == jvehicle[playerid] && VehicleInfo[playerid][Model] !=0)
    {
  		SubMessage(playerid,MSG_BLUE,".:: Bienvenue dans votre véhicule ::. ~n~Faites ~w~/stopradio ~b~à tout moment pour enlever la musique",5);
	}
	
	if(robbing[playerid] == true && vehicleid == vmission[playerid] && havebox[playerid] == true)
	{
		RemovePlayerAttachedObject(playerid,9);
		ClearAnimations(playerid);
		havebox[playerid] = false;
	}
	if(mission[playerid] != 0)
	{
		if(vehicleid == vmission[playerid] || vehicleid == vmission[GetPlayerVirtualWorld(playerid-1)])
		{
			new engine,
			lights,
			alarm,
			doors,
			bonnet,
			boot,
			objective;
			GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet,boot,objective);
			SetVehicleParamsEx(vehicleid, engine, lights, 0, 0, 0, 0, 0);
			if(mission[playerid] == 2)
			{
			    if(!IsValidDynamicObject(cobject[playerid]))
			    {
					SetMissionObj(playerid, "Va aux docks remplir le boxville");
					cobject[playerid] = CreateDynamicObject(3799, -1708.67578, 27.00929, 2.54452,   0.00000, 0.00000, 0.00000,GetPlayerVirtualWorld(playerid),0,playerid);
					SetPlayerCheckpoint(playerid,POSCAISSES,1.0);
				}
			}
			if(mission[playerid] == 3)
			{
				SetMissionObj(playerid, "Va à l'entrepôt");
				cobject[playerid] = CreateDynamicObject(3799, -1708.67578, 27.00929, 2.54452,   0.00000, 0.00000, 0.00000,GetPlayerVirtualWorld(playerid),0,playerid);
				SetPlayerCheckpoint(playerid,ENTREPOT,1.0);
			}
		}
		if(vehicleid == vennemy[playerid] && mission[playerid] == 8)
		{
			SetMissionObj(playerid, "Va rejoindre les autres");
			SetPlayerCheckpoint(playerid,POSMISSION8,3.0);
			SetVehicleParamsEx(vehicleid, 1, 0, 0, 0, 0, 0, 0);
		}
	}
    return 1;
}
public OnUnoccupiedVehicleUpdate(vehicleid, playerid, passenger_seat, Float:new_x, Float:new_y, Float:new_z, Float:vel_x, Float:vel_y, Float:vel_z)
{
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		static Float:hp, Float:hpa;
		GetVehicleHealth(GetPlayerVehicleID(playerid), hp);
		if(hp < PlayerVehHP[playerid])
		{
		    if(GetVehicleDistanceFromPoint(vehicleid, new_x, new_y, new_z) < 15.0)
		    {
				GetVehicleHealth(vehicleid, hpa);
				SetVehicleHealth(vehicleid, hpa - (PlayerVehHP[playerid] - hp));
		    }
		}
		PlayerVehHP[playerid] = hp;
	    return 1;
	}
    return 1;
}
public OnPlayerShootDynamicObject(playerid, weaponid, STREAMER_TAG_OBJECT objectid, Float:x, Float:y, Float:z)
{
	if(objectid == maskplayer[3])
	{
	    SubMessage(playerid,MSG_BLUE,"Vous enfilez le ~w~masque du diable",5);
	    SetPlayerAttachedObject(playerid, 0, 11704, 2, 0.0519, 0.1149, 0.0019, 170.1001, 96.0000, 13.4000, 0.3690, 0.4039, 0.4850, 0xFFFFFFFF, 0xFFFFFFFF);
	}
	else if(objectid == maskplayer[6])
	{
	    SubMessage(playerid,MSG_BLUE,"Vous enfilez la ~w~tête de motard",5);
	    SetPlayerAttachedObject(playerid, 0, 3012, 2, -0.3989, 0.4959, -0.4269, -0.8999, 59.0999, 1.9000, 1.2520, 1.1219, 1.0120, 0xFFFFFFFF, 0xFFFFFFFF);
	}
	return 1;
}

public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{

	for(new i; i < MAX_ACTORS; i++) if(IsValidActor(i) && !IsActorDead(i)) if(IsPlayerInRangeOfActor(playerid, i, 40.0))
	{
			ApplyActorAnimation(i, "PED", "cower",4.0,1,0,0,1,0);
			KillTimer(resetactoranim[i]);
			resetactoranim[i] = SetTimerEx("ResetActorAnim",20*1000,false,"i",i);
	}
	
	if(hittype == BULLET_HIT_TYPE_VEHICLE)
	{
		for(new i;i<MAX_PLAYERS;i++)
		{
			if(IsPlayerNPC(i) && GetPlayerVehicleID(i) == hitid)
			{
		 		vhealth[hitid] -= 30;
			 	if(hitid == vennemy[playerid])
				{
				    if(vhealth[hitid] < 250)
				    {
						if(mission[playerid] == 6) EndMission(playerid, 6);
						if(mission[playerid] == 101) EndMission(playerid, 101);
					}
				}
			}
		}
	    static Float:x, Float:y, Float:z;
	    /* Show in the petrol tank - It also works when the player is inside. */
		GetVehicleModelInfo(GetVehicleModel(hitid), VEHICLE_MODEL_INFO_PETROLCAP, x, y, z);

		if(VectorSize(fX-x, fY-y, fZ-z) < 0.15)
		{
		    SetVehicleHealth(hitid, -1000.0);
		    GetVehiclePos(hitid, x,y,z);
			CreateExplosion(x,y,z,0,10.0);
		    return 1;
		}

		/* Shot in empty vehicle */
		for(new i = GetPlayerPoolSize(); i > -1; i--)
		{
			if(GetPlayerVehicleID(i) == hitid && GetPlayerVehicleSeat(i) == 0)
			return 1;
		}

		GetVehicleHealth(hitid, x);
		if(x > 0)
		{
			switch(weaponid)
			{
				case 0 .. 15: SetVehicleHealth(hitid, x - 10);
				case 22 .. 23: SetVehicleHealth(hitid, x - 15);
                case 24: SetVehicleHealth(hitid, x - 50);
				case 25 .. 27: SetVehicleHealth(hitid, x - 30);
				case 28, 29, 32: SetVehicleHealth(hitid, x - 5);
				case 30, 31: SetVehicleHealth(hitid, x - 10);
				case 33, 34: SetVehicleHealth(hitid, x - 40);
				case 35 .. 38: SetVehicleHealth(hitid, x - 80);
				default: return 1;
			}
		}
	}
	if(magicgun[playerid] == true)
	{
	    new type[32],string[256],wpname[64];
		GetWeaponName(weaponid,wpname,sizeof(wpname));
	    if(GetPlayerTargetActor(playerid) == INVALID_ACTOR_ID)
	    {
		    switch(hittype)
		    {
		        case 0 : type = "de l'air";
		        case 1 : type = "un joueur";
		        case 2 : type = "un véhicule";
		        case 3 : type = "un objet";
		        case 4 : type = "un player objet";
			}
			format(string,sizeof(string),"[ADMIN] Vous avez touché {ffffff}%s {0080C0}d'ID {ffffff}%d{0080C0} avec un {ffffff}%s{0080C0}.",type,hitid,wpname);
			SendClientMessage(playerid,BLUE,string);
		}
		else
		{
			format(string,sizeof(string),"[ADMIN] Vous avez touché {ffffff}un acteur {0080C0}d'ID {ffffff}%d{0080C0} avec un {ffffff}%s{0080C0}.",GetPlayerTargetActor(playerid),wpname);
			SendClientMessage(playerid,BLUE,string);
		}
		format(string,sizeof(string),"[ADMIN] Les coordonnées de l'impact : X : {ffffff}%.2f {0080C0} | Y : {ffffff}%.2f {0080C0} | Z : {ffffff}%.2f",fX,fY,fZ);
		SendClientMessage(playerid,BLUE,string);
	}
	if(InAmmu[playerid] == true)
	{
	    if(hittype == BULLET_HIT_TYPE_PLAYER_OBJECT && hitid == atarget[playerid])
	    {
	        DestroyPlayerObject(playerid,atarget[playerid]);
			ammulvl[playerid] ++;
			SubMessage(playerid,MSG_BLUE,"Tu passes au niveau supérieur",5);
			CreateTarget(playerid,ammulvl[playerid]);
			if(ammulvl[playerid] == MAXLEVEL)
			{
			    EndAmmu(playerid);
				return 1;
			}
		}
		else
		{
		    SubMessage(playerid,MSG_RED,"Tu as raté le niveau !",5);
		    EndAmmu(playerid);
		}

	}
	if(hittype == 0)
	{
	    if(GetAxeDistance(fX,228.65) < 0.1 && GetAxeDistance(fY,1079.25) < 0.05 && GetAxeDistance(fZ,1085.75) < 0.1) // maskplayer HOCKET WHITE
	    {
	        SubMessage(playerid,MSG_BLUE,"Vous enfilez un ~w~masque de hockey blanc",5);
			SetPlayerAttachedObject(playerid, 0, 19036, 2, 0.0960, 0.0419, -0.0109, 93.7999, 92.0000, 3.9999, 1.0710, 1.1349, 1.0720, 0xFFFFFFFF, 0xFFFFFFFF);
		}
		else if(GetAxeDistance(fX,228.65) < 0.1 && GetAxeDistance(fY,1079.25) < 0.05 && GetAxeDistance(fZ,1085.22) < 0.1) // maskplayer HOCKET RED
		{
		    SubMessage(playerid,MSG_BLUE,"Vous enfilez un ~w~masque de hockey rouge",5);
		    SetPlayerAttachedObject(playerid, 0, 19037, 2, 0.0960, 0.0419, -0.0109, 93.7999, 92.0000, 3.9999, 1.0710, 1.1349, 1.0720, 0xFFFFFFFF, 0xFFFFFFFF);
		}
		else if(GetAxeDistance(fX,228.65) < 0.1 && GetAxeDistance(fY,1079.25) < 0.05 && GetAxeDistance(fZ,1084.67) < 0.1) // maskplayer HOCKET GREEN
		{
		    SubMessage(playerid,MSG_BLUE,"Vous enfilez un ~w~masque de hockey vert",5);
		    SetPlayerAttachedObject(playerid, 0, 19038, 2, 0.0960, 0.0419, -0.0109, 93.7999, 92.0000, 3.9999, 1.0710, 1.1349, 1.0720, 0xFFFFFFFF, 0xFFFFFFFF);
		}
		else if(GetAxeDistance(fX,225.80) < 0.1 && GetAxeDistance(fY,1079.25) < 0.05 && GetAxeDistance(fZ,1085.68) < 0.15) // CJ HEAD
		{
		    SubMessage(playerid,MSG_BLUE,"Vous enfilez la ~w~tête de CJ",5);
		    SetPlayerAttachedObject(playerid, 0, 18963, 2, 0.0859, 0.0380, 0.0000, 94.8999, 90.3999, -1.8999, 1.1609, 1.2129, 1.0799, 0xFFFFFFFF, 0xFFFFFFFF);
		}
		else if(GetAxeDistance(fX,225.81) < 0.25 && GetAxeDistance(fY,1079.25) < 0.05 && GetAxeDistance(fZ,1085.15) < 0.45) // CERF HEAD
		{
		    SubMessage(playerid,MSG_BLUE,"Vous enfilez une ~w~tête de cerf",5);
		    SetPlayerAttachedObject(playerid, 0, 1736, 2, 0.1209, 0.2479, -0.0489, 168.3001, 95.7999, 1.1999, 0.4379, 0.5270, 0.4239, 0xFFFFFFFF, 0xFFFFFFFF);
		}
	}
    return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	if(jvehicle[playerid] == vehicleid)
	{
		VehicleInfo[playerid][Color1] = color1;
		VehicleInfo[playerid][Color2] = color2;
		new INI:File = INI_Open(UserPath(playerid));
		INI_SetTag(File,"Veh");
		INI_WriteInt(File,"Color1",VehicleInfo[playerid][Color1]);
		INI_WriteInt(File,"Color2",VehicleInfo[playerid][Color2]);
		INI_Close(File);
	}
    return 1;
}

public OnVehicleMod(playerid,vehicleid,componentid)
{
	new IdSlot = GetVehicleComponentType(componentid), string[32],INI:File = INI_Open(UserPath(playerid));
	VehicleTuning[playerid][IdSlot] = componentid;
	format(string,sizeof(string),"Slot_%d",IdSlot);
	INI_SetTag(File,"Veh");
	INI_WriteInt(File,string,VehicleTuning[playerid][IdSlot]);
	INI_Close(File);

	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	new INI:File = INI_Open(UserPath(playerid));
    VehicleInfo[playerid][PaintJob] = paintjobid;
   	INI_SetTag(File,"Veh");
	INI_WriteInt(File,"PaintJob",VehicleInfo[playerid][PaintJob]);
	INI_Close(File);
    return 1;
}

public OnPlayerConnect(playerid)
{

	ResetData(playerid);

	SetPlayerSkillLevel(playerid,WEAPONSKILL_PISTOL,900);
	SetPlayerSkillLevel(playerid,WEAPONSKILL_MICRO_UZI,900);

	if(IsPlayerNPC(playerid) || FCNPC_IsValid(playerid)) return 1;

	#include <Mapping/newsfremove>
	#include <Mapping/DRV3remove>
	#include <Mapping/newlcremove>

	//REMOVE TOWER CRANES
	RemoveBuildingForPlayer(playerid, 1403, 0.0, 0.0, 0.0, 100000.0);
	RemoveBuildingForPlayer(playerid, 1404, 0.0, 0.0, 0.0, 100000.0);
	RemoveBuildingForPlayer(playerid, 1385, 0.0, 0.0, 0.0, 100000.0);
	RemoveBuildingForPlayer(playerid, 1684, 0.0, 0.0, 0.0, 100000.0);

	// HOUSE ID 1 (BUG UNDERMAP)
	RemoveBuildingForPlayer(playerid, 14480, 456.1719, 514.1250, 1001.0078, 0.25);

	//HOUSE BAYSIDE
	RemoveBuildingForPlayer(playerid, 9389, -2437.5938, 2360.3984, 6.8359, 0.25);
	RemoveBuildingForPlayer(playerid, 1408, -2436.7656, 2344.5469, 4.5313, 0.25);
	RemoveBuildingForPlayer(playerid, 715, -2416.2500, 2351.5000, 11.6406, 0.25);
	RemoveBuildingForPlayer(playerid, 9341, -2437.5938, 2360.3984, 6.8359, 0.25);
	RemoveBuildingForPlayer(playerid, 715, -2450.1250, 2367.9141, 11.7500, 0.25);
	RemoveBuildingForPlayer(playerid, 767, -2434.8672, 2384.6719, 8.0938, 0.25);

 	SetPlayerMapIcon(playerid,83,STAD_ENTER,33,0,MAPICON_LOCAL); // STADIUM
	SetPlayerMapIcon(playerid,84,COM_POSENTER,30,0,MAPICON_LOCAL); // COMMI
	SetPlayerMapIcon(playerid,85,ALCITY,5,0,MAPICON_LOCAL); // Depart Liberty City
	SetPlayerMapIcon(playerid,86,-1883.0,866.0,35.0,45,0,MAPICON_LOCAL); // CLOTHES SHOP
	SetPlayerMapIcon(playerid,87,HOTELENTER,35,0,MAPICON_LOCAL); // MOTEL
	SetPlayerMapIcon(playerid,88,-2551.0,194.0,6.0,48,0,MAPICON_LOCAL); //SF MALIBU CLUB
	SetPlayerMapIcon(playerid,89,-2625.0,1412.0,7.0,49,0,MAPICON_LOCAL); //SF JIZZY'S NIGHTCLUB BAR
	SetPlayerMapIcon(playerid,90,-2214.0,721.0,49.5,49,0,MAPICON_LOCAL); //SF CHINATOWN BAR
	SetPlayerMapIcon(playerid,91,-1805.7,943.2,24.8,29,0,MAPICON_LOCAL); //SF WELL STACKED PIZZA CO
	SetPlayerMapIcon(playerid,92,-1719.1,1359.4,8.6,29,0,MAPICON_LOCAL); //SF WELL STACKED PIZZA CO
	SetPlayerMapIcon(playerid,93,-2356.0,1009.0,49.0,10,0,MAPICON_LOCAL); //SF BURGER SHOT
	SetPlayerMapIcon(playerid,94,-1913.3,826.2,36.9,10,0,MAPICON_LOCAL); //SF BURGER SHOT
	SetPlayerMapIcon(playerid,95,-2335.6,-165.6,39.5,10,0,MAPICON_LOCAL); //SF BURGER SHOT
	SetPlayerMapIcon(playerid,96,-2671.6,257.4,4.6,14,0,MAPICON_LOCAL); //SF CLUCKIN' BELL
	SetPlayerMapIcon(playerid,97,-1816.2,620.8,37.5,14,0,MAPICON_LOCAL); //SF CLUCKIN' BELL
	SetPlayerMapIcon(playerid,98,-2626.6,209.4,4.9,6,0,MAPICON_LOCAL); //SF AMMU-NATION
	SetPlayerMapIcon(playerid,99,BANKENTER,52,0,MAPICON_LOCAL); //SF BANK

	CreateTDAmmu(playerid);
	CreateTDMissions(playerid);
	CreateTDObj(playerid);
	CreateSubMessages(playerid);
	CreateNPCMenu(playerid);

	gHeaderTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
	gBackgroundTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
	gCurrentPageTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
	gNextButtonTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
	gPrevButtonTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;

	for(new x=0; x < SELECTION_ITEMS; x++) {
		gSelectionItems[playerid][x] = PlayerText:INVALID_TEXT_DRAW;
	}

	VehicleInfo[playerid][PaintJob] = -1;
	gItemAt[playerid] = 0;

	CreatePhoneTD(playerid);

	ShowPlayerMarkers(PLAYER_MARKERS_MODE_GLOBAL);

	new playrname[MAX_PLAYER_NAME];
	new string[128];
	GetPlayerName(playerid, playrname, sizeof(playrname));
	for(new i=0;i<MAX_PLAYERS;i++)
	{
	    if(!IsPlayerNPC(playerid))
	    {
		format(string, sizeof(string), "[+] %s", playrname);
		SendClientMessage(i, GREEN, string);
		}
	}

	mission[playerid] = 0;
	cbraquage[playerid] = -1;
	vcmds[playerid] = false;

	GameTextForPlayerEx(playerid," ",1,0);
	GameTextForPlayerEx(playerid,"~w~Bienvenue sur~n~~r~San ~r~Andreas ~r~Online",3000,6);

	new ClientVersion[32];
	GetPlayerVersion(playerid, ClientVersion, 32);
	printf("Le joueur %d utilise la version: %s", playerid, ClientVersion);

	timerob[playerid] = -1;

	if(fexist(UserPath(playerid)))
	{
		INI_ParseFile(UserPath(playerid), "LoadUser_%s", false, true, playerid, false);
		INI_ParseFile(UserPath(playerid), "LoadContacts_%s", false,true, playerid, false);
		INI_ParseFile(UserPath(playerid), "LoadVehicle_%s",false,true, playerid, false);
		INI_ParseFile(UserPath(playerid), "LoadWeapons_%s",false,true,playerid,false);
		INI_ParseFile(UserPath(playerid),"LoadPickups_%s",false,true,playerid,false);
		ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_INPUT,""DLG_WHITE"Login",""DLG_WHITE"Tapes ton mot de passe pour te connecter.","Connexion","Quitter");
		if(timerob[playerid] != -1)
		{
		    trob[playerid] = SetTimerEx("RobTimer",60000,true,"i",playerid);
		    nextrob[playerid] = false;
		}
	}
	else
	{
		ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_INPUT,""DLG_WHITE"Enregistrement...",""DLG_WHITE"Tapes ton mot de passe ci-dessous pour t'enregistrer.","Enregistrer","Quitter");
	}
	for(new i; i < MAX_SLOTS ; i++)
	{
	    if(PickupTaken[playerid][i] == false)
	    {
	        pickup[playerid][i] = CreateDynamicPickup(ModelPickup[i],1,PosPickup[i][0],PosPickup[i][1],PosPickup[i][2],-1,-1,playerid);
		}
	}

	if(VehicleInfo[playerid][Model] != 0)
	{
		jvehicle[playerid] = CreateVehicle(VehicleInfo[playerid][Model],VehicleInfo[playerid][X],VehicleInfo[playerid][Y],VehicleInfo[playerid][Z],VehicleInfo[playerid][A],VehicleInfo[playerid][Color1],VehicleInfo[playerid][Color2],-1);
		SetVehicleNumberPlate(jvehicle[playerid],GetName(playerid));
		vPosseded[jvehicle[playerid]] = true;
		for(new i;i<14;i++)
		{
			if(VehicleTuning[playerid][i] != 0)
			{
			    AddVehicleComponent(jvehicle[playerid],VehicleTuning[playerid][i]);
			    if(VehicleInfo[playerid][PaintJob] != -1) ChangeVehiclePaintjob(jvehicle[playerid],VehicleInfo[playerid][PaintJob]);
			}
		}
	}

	SetPlayerColor(playerid,BLUE);

	gettime(hour, minute);
	SetPlayerTime(playerid,hour,minute);

	InCall[playerid] = 0;
	IsDead[playerid] = 0;
	IsCalling[playerid] = 0;
	TalkingID[playerid] = -1;

	SetMarkerMission(playerid);

	if(PlayerInfo[playerid][pMaison] == -1)
	{
		htimer[playerid] = SetTimerEx("LoyerTime",60000,true,"i",playerid);
	}

	for(new i;i<MAX_HOUSES;i++)
	{
		if(HouseInfo[i][Type] == 1)
		{
			SetPlayerMapIcon(playerid,i,HouseInfo[i][X1],HouseInfo[i][Y1],HouseInfo[i][Z1],31,0,MAPICON_LOCAL);
		}
		if(HouseInfo[i][Type] == 2)
		{
			if(i == PlayerInfo[playerid][pMaison])
			{
				SetPlayerMapIcon(playerid,i,HouseInfo[i][X1],HouseInfo[i][Y1],HouseInfo[i][Z1],32,0,MAPICON_GLOBAL);
			}
			else
			{
				SetPlayerMapIcon(playerid,i,HouseInfo[i][X1],HouseInfo[i][Y1],HouseInfo[i][Z1],32,0,MAPICON_LOCAL);
			}
		}
	}
	TD_Dialog[playerid] = CreatePlayerTextDraw(playerid, 319.666595, 380.814819," ");
	PlayerTextDrawLetterSize(playerid, TD_Dialog[playerid], 0.340333, 1.554371);
	PlayerTextDrawTextSize(playerid, TD_Dialog[playerid], 0.549999, 637.472412);
	PlayerTextDrawAlignment(playerid, TD_Dialog[playerid], 2);
	PlayerTextDrawColor(playerid, TD_Dialog[playerid], -1);
	PlayerTextDrawUseBox(playerid, TD_Dialog[playerid], 1);
	PlayerTextDrawBoxColor(playerid, TD_Dialog[playerid], HexToInt("00000088"));
	PlayerTextDrawSetShadow(playerid, TD_Dialog[playerid], 0);
	PlayerTextDrawSetOutline(playerid, TD_Dialog[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, TD_Dialog[playerid], 255);
	PlayerTextDrawFont(playerid, TD_Dialog[playerid], 1);
	PlayerTextDrawSetProportional(playerid, TD_Dialog[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TD_Dialog[playerid], 3);

	GetPlayerIp(playerid,LastIp[playerid],32);

	if(IsAdmin(playerid))
	{
		vcmds[playerid] = true;
		CreateTDRaceEditor(playerid);
	}
 	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	DestroyNPC(NPCInfo[playerid][NpcID]);
	
	for(new i=0;i<MAX_PLAYERS;i++)
	{
	if(IsPlayerNPC(playerid) || FCNPC_IsValid(playerid)) return 1;

    new pName[MAX_PLAYER_NAME];
	GetPlayerName(playerid, pName, sizeof(pName));
    new string[56];
	switch(reason)
    {
  		case 0: format(string, sizeof(string), "[-] %s (Crash)", pName);
    	case 1: format(string, sizeof(string), "[-] %s (Quitté)", pName);
    	case 2: format(string, sizeof(string), "[-] %s (Kick/Ban)", pName);
    }
    SendClientMessage(i,RED, string);
	}
	if(mission[playerid] != 0) FailMission(playerid);
	if(InRace[playerid] == true)
	{
		EndRace(playerid);
	}
	DestroyVehicle(jvehicle[playerid]);
	GameTextForPlayerEx(playerid, "~b~Redémarrage...", 5000, 0);
	if(robbing[playerid] == true) FailRobHouse(playerid);

	if(InCall[playerid] && !Talking[playerid] && IsCalling[playerid]) KillTimer(EndTimer[TalkingID[playerid]]);
	if(InCall[playerid] && !Talking[playerid] && !IsCalling[playerid]) KillTimer(EndTimer[playerid]);
	if(Talking[playerid] == 1 && TalkingID[playerid] > -1 && IsPlayerConnected(TalkingID[playerid]) && Talking[TalkingID[playerid]] == 1) EndCall(TalkingID[playerid],playerid,2);

	KillTimer(htimer[playerid]);

	if(jbraquage[playerid] == true)
	{
	    for(new i;i<2;i++)
	    {
	        SubMessage(braqueur[i],MSG_BLUE,"~r~Ton coéquipier s'est déconnecté, le braquage est donc annulé !",5);
		}
		EndBraquage();
	}
	if(cbraquage[playerid] != -1)
	{
	    EndCommBraquage(playerid);
 		SendClientMessage(playerid,BLUE,"Le braquage en cours n'a pas été sauvegardé.");
	}
	if(mission[playerid] != 0)
	{
 		SendClientMessage(playerid,BLUE,"La mission en cours n'a pas été sauvegardée.");
	}
	if(InAmmu[playerid] == true) EndAmmu(playerid);

	SavePlayerWeapons(playerid);

	new INI:UserFile = INI_Open(UserPath(playerid));
    INI_SetTag(UserFile,"data");
    INI_WriteBool(UserFile,"Ban",PlayerInfo[playerid][pBan]);
	INI_WriteString(UserFile,"LastIp", LastIp[playerid]);
    INI_Close(UserFile);

	sdrive[playerid] = false;
	DestroyVehicle(aveh[playerid]);

    SelectItem[playerid] = 0;
	return 1;
}
public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	if(newinteriorid == 1 && mission[playerid] == 0)
	{
		new vw = GetPlayerVirtualWorld(playerid);
		if(vw == 10)	PlayAudioStreamForPlayer(playerid, "http://xdev-team.tk/creations/sao/Audio/VC.mp3");
		if(vw == 11)	PlayAudioStreamForPlayer(playerid, "http://xdev-team.tk/creations/sao/Audio/VC.mp3");
		if(vw == 12)	PlayAudioStreamForPlayer(playerid, "http://xdev-team.tk/creations/sao/Audio/VC.mp3");
		if(vw == 13)
		{
			PlayAudioStreamForPlayer(playerid, "http://xdev-team.tk/creations/sao/Audio/TBoGT.mp3");
			ClubTBoGT[playerid] = true;
		}
	}
	if(newinteriorid == 0 && mission[playerid] == 0)
	{
		StopAudioStreamForPlayer(playerid);
		SetPlayerVirtualWorld(playerid, 0);
		ClubTBoGT[playerid] = false;
	}

	new x = 0;
	while(x!=MAX_PLAYERS) {
	    if( IsPlayerConnected(x) &&	GetPlayerState(x) == PLAYER_STATE_SPECTATING &&
			gSpectateID[x] == playerid && gSpectateType[x] == ADMIN_SPEC_TYPE_PLAYER )
   		{
   		    SetPlayerInterior(x,newinteriorid);
		}
		x++;
	}
	return 1;
}
public OnPlayerText(playerid, text[])
{
	if(IsLogged[playerid] == false)
	{
		SendClientMessage(playerid,RED,"Tu dois être connecté pour parler !");
		return 0;
	}

	if(IsAdmin(playerid))
	{
		if(text[0] == ',')
		{
  			new string[256];
			strdel(text,0,1);
            format(string,sizeof(string),"[AdminChat] %s :{8080FF} %s",GetName(playerid),text);
		    SendAdminMessage(BLUE,string);
			printf("[AdminChat] %s : %s",GetName(playerid),text);
			return 0;
		}
	}

	if(InCall[playerid] == 1)
	{
		if(IsPlayerConnected(TalkingID[playerid]) && Talking[playerid] == 1 && TalkingID[playerid] > -1 && Talking[TalkingID[playerid]] == 1)
		{
			new str[128];
			format(str,sizeof(str),"[Phone] - De %s (id: %d): %s",GetName(playerid),playerid,text);
			SendClientMessage(TalkingID[playerid],YELLOW,str);
			format(str,sizeof(str),"[Phone] - De %s (id: %d): %s",GetName(playerid),playerid,text);
			SendClientMessage(playerid,BLUE,str);
			return 0;
	 	}
 	}

	if(Edit[playerid]==3)
	{
	    new prix = strval(text),string[256];
		if(prix<0)
		{
			SubMessage(playerid,MSG_RED,"Prix invalide !",5);
			Edit[playerid]=0;
			return 0;
		}
		switch(deftype[playerid])
		{
		    case 1 :
		    {
	 			format(string,sizeof(string),"[ADMIN] Le prix de la maison '%d' est de maintenant $%d",selectid[playerid],prix);
		    	SendClientMessage(playerid,BLUE,string);
		    	HouseInfo[selectid[playerid]][Prix] = prix;
		    	SaveHouse(selectid[playerid]);
		    	Edit[playerid]=0;
				return 0;
			}
			case 3 :
			{
				format(string,sizeof(string),"[ADMIN] Le prix de la propriété '%d' est de maintenant $%d",selectid[playerid],prix);
		    	SendClientMessage(playerid,BLUE,string);
		    	BizInfo[selectid[playerid]][Prix] = prix;
		    	SaveBiz(selectid[playerid]);
		    	Edit[playerid]=0;
		    	return 0;
			}
		}
	}

	if(Edit[playerid]==-1)
	{
		new montant = strval(text);
	    new value = 0;
	    if(PlayerInfo[playerid][pMaison] <1)
	    {
	    	value = floatround(floatmul(floatstr(text),TAXE),floatround_round);
		}
	    if(montant<10)
		{
			Edit[playerid]=0;
	 		SubMessage(playerid,MSG_RED,"Tu ne peux pas déposer une somme inférieure ou égale à $10 !",10);
	 		return 0;
		}
	    if(value>PlayerInfo[playerid][pCash])
		{
			Edit[playerid]=0;
	 		SubMessage(playerid,MSG_RED,"T'as pas assez d'argent !",5);
	 		return 0;
		}
		else
		{
			new string[256];
		    GiveMoney(playerid,-montant);
		    GivePlayerBanque(playerid,montant-value);
			format(string,sizeof(string),"Taxe de la banque: ~w~$%d",value);
			SubMessage(playerid,MSG_BLUE,string,5);
			SubMessage(playerid,MSG_BLUE,"Transfert effectué !",5);
			Edit[playerid]=0;
			GiveMoneyBanque(value*2);
			return 0;
		}

	}
	if(Edit[playerid]==-2)
	{
	    new value = strval(text);
	    if(value>PlayerInfo[playerid][pBanque] || value == 0)
		{
			Edit[playerid]=0;
	 		SubMessage(playerid,MSG_RED,"Montant invalide !",5);
	 		return 0;
		}
		else
		{
		    GiveMoney(playerid,value);
		    GivePlayerBanque(playerid,-value);
			SubMessage(playerid,MSG_BLUE,"Transfert effectué !",5);
			Edit[playerid]=0;
			return 0;
		}

	}
	if(Edit[playerid]==-3)
	{
		new value = strval(text),string[256],msg[256];
		if(value>PlayerInfo[playerid][pBanque] || value==0)
		{
		    SubMessage(playerid,MSG_RED,"Montant invalide !",5);
		    Edit[playerid]=0;
		    return 0;
		}
		else
		{
		    new id = 999,bool:found = false;
			for(new i;i<MAX_PLAYERS;i++)
			{
			    if(IsPlayerConnected(i))
			    {
			        if(!strcmp(GetName(i),namesave[playerid]))
			        {
			            if(PlayerInfo[i][pCarte] == false)
			            {
				            format(msg,sizeof(msg),"~w~%s ~b~a tenté de de faire un virement mais tu n'as pas de compte bancaire !",GetName(playerid));
				            SubMessage(i,MSG_BLUE,msg,5);
				            SubMessage(playerid,MSG_RED,"Ce joueur n'a pas de compte bancaire !",5);
						}
			            else
			            {
				            format(msg,sizeof(msg),"Tu as reçu un virement de ~w~$%d ~b~de la part de ~w~%s",value,GetName(playerid));
				            SubMessage(i,MSG_BLUE,msg,5);
				            GivePlayerBanque(i,value);
							GivePlayerBanque(playerid,-value);
							SubMessage(playerid,MSG_BLUE,"Virement effectué !",5);
			            }
			            found = true;
					}
				}
			}
			if(found == false)
			{

				format(string,sizeof(string),PATH,namesave[playerid]);
				INI_ParseFile(string, "LoadUser_%s",false, true, id, false);
				PlayerInfo[id][pBanque]+=value;
				new INI:File = INI_Open(string);
				INI_WriteInt(File,"Banque",PlayerInfo[id][pBanque]);
				INI_Close(File);
				SubMessage(playerid,MSG_BLUE,"Virement effectué vers ce compte.",5);
			}
			Edit[playerid]=0;
			return 0;
		}
	}
	if(Edit[playerid] == 5)
	{
		new prix = strval(text), string[256];
		if(prix < 0)
		{
		    SubMessage(playerid,MSG_RED,"Prix invalide !",5);
		    Edit[playerid] = 0;
		    return 0;
		}
		else
		{
			format(string,sizeof(string),"[ADMIN] La caisse maximale de la propriété '%d' est de maintenant $%d",selectid[playerid],prix);
		    SendClientMessage(playerid,BLUE,string);
		    BizInfo[selectid[playerid]][CaisseMax] = prix;
		    SaveBiz(selectid[playerid]);
		    Edit[playerid] = 0;
		    return 0;
		}
	}
	if(Edit[playerid] == 6)
	{
		new prix = strval(text), string[256];
		if(prix < 0)
		{
      		SubMessage(playerid,MSG_RED,"Prix invalide !",5);
		    Edit[playerid] = 0;
		    return 0;
		}
		else
		{
			format(string,sizeof(string),"[ADMIN] Les revenus de la propriété '%d' sont de maintenant $%d par heure",selectid[playerid],prix);
		    SendClientMessage(playerid,BLUE,string);
		    BizInfo[selectid[playerid]][Revenus] = prix;
		    SaveBiz(selectid[playerid]);
		    Edit[playerid] = 0;
		    return 0;
		}
	}
	if(muted[playerid] == true)
	{
	    SubMessage(playerid,MSG_RED,"Vous êtes mute ! Vous ne pouvez pas parler pour le moment !",5);
	    return 0;
	}

	new string[128];
	new name[MAX_PLAYER_NAME+1];
	GetPlayerName(playerid, name, sizeof(name));
	format(string, sizeof(string), "%s[%i]: %s",name,playerid,text);
	printf(string);

	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
    if(InRace[playerid] == true && IsPosRace(playerid) && IsRaceLoaded == true)
    {
		cpplayer[playerid] ++;
		new index = cpplayer[playerid],string[256];
		SetPlayerRaceCheckpoint(playerid,0,PosRace[index][0],PosRace[index][1],PosRace[index][2],PosRace[index + 1][0],PosRace[index + 1][1],PosRace[index + 1][2],5.0);
		if(cpplayer[playerid] != 1)
		{
			format(string,sizeof(string)," ~b~CP ~w~%d~b~/~w~%d",index-2,CpRace-1);
			GameTextForPlayer(playerid,string,3000,1);
			if(cpplayer[playerid] == CpRace + 1)
			{
			    racepos++;
			    DisablePlayerCheckpointEx(playerid);
			    new msg[256],value = 0;
			    switch(racepos)
			    {
			        case 1:
			        {
						msg = "Tu as fini 1er de la course !";
						value = 1000;
					}
					case 2:
					{
					    value = 750;
					}
					case 3:
					{
					    value = 500;
					}
				}
				if(racepos != 1) format(msg,sizeof(msg),"Tu as fini %dème de la course ! Tu gagnes $1000 !",racepos);
				format(string, sizeof(string), "%s "DLG_BLUE" a fini "DLG_WHITE"%dème "DLG_WHITE"de la course !", playerid, racepos);
				SendClientMessageToAll(BLUE,string);
				SubMessage(playerid,MSG_BLUE,msg,5);
				format(msg,sizeof(msg),"Tu gagnes un bonus de ~w~$%d en plus des $100",value);
				SubMessage(playerid,MSG_YELLOW,msg,5);
			    GiveMoney(playerid,1000+value);
				EndRace(playerid);
			}
		}
	}
    return 1;
}
public OnPlayerSpawn(playerid)
{
	if(IsPlayerNPC(playerid) || FCNPC_IsValid(playerid)) return 1;

   	gettime(hour, minute);
	SetPlayerTime(playerid,hour,minute);

    SetPlayerMoney(playerid, PlayerInfo[playerid][pCash]);
	SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
	
	SetPlayerInterior(playerid,0);
	StopAudioStreamForPlayer(playerid);

	INI_ParseFile(UserPath(playerid), "LoadWeapons_%s",false,true,playerid,false);
	GivePlayerWeaponsSaved(playerid);
	
	if(respawnhospital[playerid] == true)
	{
	    SetPlayerPos(playerid,-2663.31,633.26,14.45);
	    SetPlayerFacingAngle(playerid,183.69);
		respawnhospital[playerid] = false;
	}
	TogglePlayerControllable(playerid, true);
	return 1;
}

public OnPlayerObjectMoved(playerid,objectid)
{
    if(objectid == atarget[playerid] && InAmmu[playerid])
    {
        new Float:speed;
        switch(ammulvl[playerid])
        {
            case 2 : speed = 2.5;
            case 3: speed = 5.0;
            case 4: speed = 5.0;
            case 5: speed = 7.5;
			case 6: speed = 7.5;
		}
        new Float:oldx,Float:oldy;
   		oldx = floatrand(XMIN,XMAX);
		oldy = floatrand(YMIN,YMAX);
		MovePlayerObject(playerid,atarget[playerid],oldx,oldy,1003.0,speed,0.0,0.0,0.0);
	}
    return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	respawnhospital[playerid] = true;
	if(robbing[playerid] == true)
	{
		nextrob[playerid] = false;
		timerob[playerid] ++;
		trob[playerid] = SetTimerEx("RobTimer",60000,true,"i",playerid);
		FailRobHouse(playerid);
	}
	if(InAmmu[playerid] == true)
	{
	    EndAmmu(playerid);
	}
	if(killerid != INVALID_PLAYER_ID && !IsPlayerNPC(playerid))
	{
	    new weapons[13][2],Float:x,Float:y,Float:z;
		for (new i = 0; i <= 12; i++)
		{
  			GetPlayerWeaponData(playerid, i, weapons[i][0], weapons[i][1]);
  			if(weapons[i][0] != 0)
  			{
	  			new object,weapname[32];
	  			GetPlayerPos(playerid,x,y,z);
	  			x += floatrand(-2.0,2.0);
	  			y += floatrand(-2.0,2.0);
				new Float:vz1,Float:vz;
				GetPlayerVelocity(playerid,x,y,vz1);
			    GetPlayerPos(playerid,x,y,vz);
				MapAndreas_FindZ_For2DCoord(x,y,z);
				if(vz < z && vz1 == 0.0) z = vz -1.0;
			  	object = CreateObject(GetModelWeapon(weapons[i][0]),x, y,z,90.0,0.0,0.0);
			  	WeaponObject[object][Light] = CreateDynamicObject(19290,x,y,z,0.0,0.0,0.0);
				WeaponObject[object][Model] = weapons[i][0];
				WeaponObject[object][Ammo] = weapons[i][1];
				GetWeaponName(WeaponObject[object][Model],weapname,sizeof(weapname));
				printf("[Weapon] %s est mort et jette un %s de %d munitions",GetName(playerid),weapname,WeaponObject[object][Ammo]);
			}
		}
		GivePlayerWantedLevel(killerid,STAR_KILLPLAYER);
	}
	if(mission[playerid] != 0)
	{
	    FailMission(playerid);
	}
	else
	{
		if(mission[playerid] == 0)
		{
	 		GameTextForPlayerEx(playerid, "~r~Wasted", 5000, 0);
	 	}
		SavePlayerWeapons(playerid);
	 	PlayAudioStream(playerid, "http://xdev-team.tk/creations/sao/Audio/Wasted.mp3");

		if(IsPlayerNPC(killerid) || FCNPC_IsValid(killerid) || IsPlayerNPC(playerid) || FCNPC_IsValid(playerid))
		{
		}
		else
		{
			SendDeathMessage(killerid, playerid, reason);
		}

		if(IsDead[playerid] == 1 && InCall[playerid] == 1 && Talking[playerid] == 1) IsDead[playerid] = 0;

		DisablePlayerCheckpointEx(playerid);

		if(killerid == INVALID_PLAYER_ID || IsPlayerNPC(killerid)) {
			GiveMoney(playerid, -100);
		}
		else
		{
			if(PlayerInfo[playerid][pCash] > 0)
			{
				new Float:x,Float:y,Float:z,wname[64];
				GetWeaponName(reason,wname,sizeof(wname));
				GetPlayerPos(playerid,x,y,z);
				CreateMoneyPickup(x,y,z,PlayerInfo[playerid][pCash],GetPlayerVirtualWorld(playerid),GetPlayerInterior(playerid));
				GiveMoney(playerid,-PlayerInfo[playerid][pCash]);
				printf("%s a été tué par %s (%s)",GetName(playerid),GetName(killerid),wname);
			}
		}
		if(playerid == braqueur[0])
		{
		    DestroyNPC(bcop[braqueur[0]][0]);
		    DestroyNPC(bcop[braqueur[0]][1]);
		}
		if(playerid == braqueur[1])
		{
		    DestroyNPC(bcop[braqueur[1]][2]);
		    DestroyNPC(bcop[braqueur[1]][3]);
		}
		if(jbraquage[playerid] == true)
		{
			for(new i;i<2;i++)
			{
				if(braqueur[i] != playerid)
				{
				    SubMessage(i,MSG_BLUE,"~r~Ton coéquipier est mort, le braquage est donc annulé !",5);
					PlayAudioStream(i, "http://xdev-team.tk/creations/sao/Audio/Wasted.mp3");
				}
			}
	 		EndBraquage();
	 		SubMessage(playerid,MSG_RED,"Tu es mort et tu as fait rater le braquage !",5);
			PlayAudioStream(playerid, "http://xdev-team.tk/creations/sao/Audio/Wasted.mp3");
		}
		if(cbraquage[playerid] != -1)
		{
			PlayAudioStream(playerid, "http://xdev-team.tk/creations/sao/Audio/Wasted.mp3");
		    SubMessage(playerid,MSG_RED,"T'es mort ! Ton braquage a donc échoué !",5);
		    EndCommBraquage(playerid);
		}
	}
   	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	TogglePlayerSpectating(playerid,true);
	InterpolateCameraPos(playerid,-2405.0044,1349.5211,110.6622,-1339.7137,498.7899,110.5223,60000);
	InterpolateCameraLookAt(playerid,-2662.3396,1436.3416,53.8972,-1517.6713,674.2904,103.5589,60000);
	return 1;
}

public OnPlayerPickUpDynamicPickup(playerid, pickupid)
{
	for(new i;i<MAX_HOUSES;i++)
	{
	    if(pickupid == housepickup[i][0])
	    {
			new string[256];
	        if(HouseInfo[i][Type]==2)
	        {
		        format(string,sizeof(string),"~b~Maison de ~w~%s",proprio[i]);

			}
			else if(HouseInfo[i][Type]==1)
			{
			    format(string,sizeof(string),"~g~Maison en vente pour ~w~$%d",HouseInfo[i][Prix]);
			}
			GameTextForPlayerEx(playerid,string,1000,1);
		}
	}
	for(new i; i< MAX_BIZ;i++)
	{
	    if(pickupid == BizPickup[i])
	    {
	        new msg[256];
			if(BizInfo[i][Type] == 2) format(msg,sizeof(msg),"~r~Propriété de ~w~%s~n~~b~Caisse : ~w~$%d/$%d ~n~ ~b~Revenus : ~w~$%d/heure",bproprio[i],BizInfo[i][Caisse],BizInfo[i][CaisseMax],BizInfo[i][Revenus]);
			else format(msg,sizeof(msg), "~g~Propriété en vente pour ~w~$%d ~n~ ~b~Caisse : ~w~$%d/$%d ~n~ ~b~Revenus : ~w~$%d/heure",BizInfo[i][Prix],BizInfo[i][Caisse],BizInfo[i][CaisseMax],BizInfo[i][Revenus]);
			ConvertEncoding(msg);
	        GameTextForPlayer(playerid,msg,3500,4);
	        break;
	    }
	}
	for(new i; i < MAX_SLOTS; i++)
	{

		if(pickupid == pickup[playerid][i] && PickupTaken[playerid][i] == false)
		{
			PickupTaken[playerid][i] = true;
			new INI:File = INI_Open(UserPath(playerid));
			INI_SetTag(File,"Pickups");
		    new string[256];
		    format(string,sizeof(string),"Slot_%d",i);
			INI_WriteBool(File,string,PickupTaken[playerid][i]);
			INI_Close(File);
		 	DestroyDynamicPickup(pickup[playerid][i]);
		 	switch(i)
		 	{
		 	    case 0:
		 	    {
		 	        SubMessage(playerid,MSG_YELLOW,"Tu as trouvé la valise oubliée du banquier !",5);
				 	GameTextForPlayerEx(playerid, "~y~Secret trouvé ! ~n~~w~$10000", 5000, 0);
				 	GiveMoney(playerid,10000);
				}
				case 1:
				{
				    SubMessage(playerid,MSG_YELLOW,"Tu as trouvé la référence à la première mission de San Andreas !",5);
				 	GameTextForPlayerEx(playerid, "~y~Secret trouvé ! ~n~~w~$5000", 5000, 0);
				 	GiveMoney(playerid,5000);
				}
				case 2:
				{
				    SubMessage(playerid,MSG_YELLOW,"Follow the damn train CJ !",5);
				 	GameTextForPlayerEx(playerid, "~y~Secret trouvé ! ~n~~w~$5000", 5000, 0);
				 	GiveMoney(playerid,5000);
				}
				case 3:
				{
    				SubMessage(playerid,MSG_YELLOW,"Tu as trouvé Jethro & Dwayne !",5);
				 	GameTextForPlayerEx(playerid, "~y~Secret trouvé ! ~n~~w~$5000", 5000, 0);
				 	GiveMoney(playerid,5000);
				}
				case 4:
				{
    				SubMessage(playerid,MSG_YELLOW,"Tu as trouvé Zero et son magasin !",5);
				 	GameTextForPlayerEx(playerid, "~y~Secret trouvé ! ~n~~w~$5000", 5000, 0);
				 	GiveMoney(playerid,5000);
				}
				case 5:
				{
					SubMessage(playerid,MSG_YELLOW,"Tu as trouvé les rappeurs Madd Dogg et OG Loc !",5);
				 	GameTextForPlayerEx(playerid, "~y~Secret trouvé ! ~n~~w~$5000", 5000, 0);
				 	GiveMoney(playerid,5000);
				}
				case 6:
				{
					SubMessage(playerid,MSG_YELLOW,"Tu as trouvé le Malibu Club de Vice City, les Village People et Kent Paul !",5);
				 	GameTextForPlayerEx(playerid, "~y~Secret trouvé ! ~n~~w~$5000", 5000, 0);
				 	GiveMoney(playerid,5000);
				}
				case 7:
				{
					SubMessage(playerid,MSG_YELLOW,"Tu as trouvé le club Maisonette 9 de GTA IV: The Ballad Of Gay Tony !",5);
				 	GameTextForPlayerEx(playerid, "~y~Secret trouvé ! ~n~~w~$5000", 5000, 0);
				 	GiveMoney(playerid,5000);
				}
			}
		 	break;
		}
	}
	if(pickupid == bankpickup[0])
	{
	    GameTextForPlayerEx(playerid,"~b~Banque",2000,1);
	}
	if(pickupid == bankpickup[2])
	{
	    GameTextForPlayerEx(playerid,"~w~/banque",2000,1);
	}
	if(pickupid == motelpickup[0])
	{
		GameTextForPlayerEx(playerid,"~b~Motel",2000,1);
	}
	if(PickupMoney[pickupid] > 0)
	{
		new string[256],cash = PickupMoney[pickupid];
		format(string,sizeof(string),"Tu ramasses ~w~$%d ~b~!",cash);
		SubMessage(playerid,MSG_BLUE,string,5);
		GiveMoney(playerid,cash);
		DestroyDynamicPickup(pickupid);
		PickupMoney[pickupid] = 0;
	}
	if(pickupid == weappickup[0]) GivePlayerWeapon(playerid,35,4);
	if(pickupid == weappickup[1]) GivePlayerWeapon(playerid,38,200);

	return 1;
}
public OnGameModeInit()
{
   #define MAPANDREAS_ADRESS MAP_ANDREAS_MODE_FULL
   	#if MAPANDREAS_ADRESS != MAP_ANDREAS_MODE_NONE
    MapAndreas_Init(MAPANDREAS_ADRESS);
	printf(" MapAndreas Address : %d",MAPANDREAS_ADRESS);
	FCNPC_InitMapAndreas(MapAndreas_GetAddress());
	#endif

	SetTimer("TimerBiz",60*60*1000,true);

	new string[64];
	format(string,sizeof(string),RACEPATH,1);
	INI_ParseFile(string, "LoadRaces_%s");

#include <Mapping/newsf>
#include <Mapping/baysidehouse>
#include <Mapping/house1>
#include <Mapping/smallap>
#include <Mapping/littleappart>
#include <Mapping/modernap>
#include <Mapping/modernap2>
#include <Mapping/richmodernap>
#include <Mapping/malibu>
#include <Mapping/nightbar>
#include <Mapping/bar>
#include <Mapping/bank>
#include <Mapping/myhouse>
#include <Mapping/myhouseinterior>
#include <Mapping/port>
#include <Mapping/DRV3>
#include <Mapping/newlc>
#include <Mapping/jhonnyhouseint>

	// HOUSE ID 1 (BUG UNDERMAP)
	CreateDynamicObject(2528, 454.58099, 515.70001, 1000.45001,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2522, 457.29999, 514.15002, 1000.40002,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19791, 458.04999, 506.54001, 994.53711,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1505, 442.49588, 508.53015, 1000.41388,   0.00000, 0.00000, 90.00000);

	DRVGarage = CreateObject(19862, -2873.3010, 426.5359, 5.7400,   0.00000, 0.00000, 0.00000);

	Create3DTextLabel("{ff0000}Cellule des criminels n°1\n{0080C0}Ici reposent tous les hors-la-loi de la ville.",0,227.4509,113.1797,999.0156,5.0,0);
	Create3DTextLabel("{ff0000}Cellule des criminels n°2\n{0080C0}Ici reposent tous les hors-la-loi de la ville.",0,223.4723,113.1785,999.0156,5.0,0);
	Create3DTextLabel("{ff0000}Cellule des vilains n°1\n{0080C0}Ici reposent tous les vilains enfreignant les règles",0,219.5408,113.1858,999.0156,5.0,0);
	Create3DTextLabel("{ff0000}Cellule des vilains n°2\n{0080C0}Ici reposent tous les vilains enfreignant les règles",0,215.5123,113.1912,999.0156,5.0,0);

	if(fexist(SPATH))
	{
		INI_ParseFile(SPATH,"LoadServ_%s");
	}
	else
	{
		new INI:File = INI_Open(SPATH);
		INI_SetTag(File,"data");
		INI_WriteInt(File,"Argent",0);
		INI_Close(File);
	}
	printf("-------- Balances du serveur ---------\nBanque : $%d\nBurger : $%d\nPizza : $%d\nCluckin'Bell: $%d",MoneyBanque,MoneyResto[BURGER],MoneyResto[PIZZA],MoneyResto[CLUCKIN]);
	printf("-------- Infos du serveur -----------\nCompteur acteur : %d\nNombre de courses : %d",ServActor,Races);

	new compteur;
	for(new i;i<MAX_HOUSES;i++)
 	{
		if(fexist(HousePath(i)))
  		{
 			INI_ParseFile(HousePath(i),"LoadHouse_%s",.bExtra=true,.extra=i);

		}
		else
		{
			HouseInfo[i][Type]=0;
   			SaveHouse(i);

		}
		if(HouseInfo[i][Type]!=0)
		{
			compteur ++;
		    if(HouseInfo[i][Type]==2)
		    {
				housepickup[i][0] = CreateDynamicPickup(19522,1,HouseInfo[i][X1],HouseInfo[i][Y1],HouseInfo[i][Z1]);
			}
			else
			{
			    housepickup[i][0] = CreateDynamicPickup(1273,1,HouseInfo[i][X1],HouseInfo[i][Y1],HouseInfo[i][Z1]);
			}
			if(HouseInfo[i][Interior] != 0)
			{
            	housepickup[i][1] = CreateDynamicPickup(1318,1,HouseInfo[i][eX],HouseInfo[i][eY],HouseInfo[i][eZ],i,HouseInfo[i][Interior]);
			}
			else
			{
				housepickup[i][1] = CreateDynamicPickup(1318,1,HouseInfo[i][eX],HouseInfo[i][eY],HouseInfo[i][eZ],0,0);
			}
		}
		if(HouseInfo[i][Type]==0)
		{
			housepickup[i][0] = CreateDynamicPickup(0,0,HouseInfo[i][X1],HouseInfo[i][Y1],HouseInfo[i][Z1]);
			housepickup[i][1] = CreateDynamicPickup(0,0,HouseInfo[i][X1],HouseInfo[i][Y1],HouseInfo[i][Z1],i,HouseInfo[i][Interior]);
		}
	}
	printf(".:::: %d maisons chargées ::::.",compteur);
	compteur = 0;

	for(new i;i<MAX_COMMERCES;i++)
 	{
		if(fexist(CommercePath(i)))
  		{
 			INI_ParseFile(CommercePath(i),"LoadCommerce_%s",.bExtra=true,.extra=i);
		}
		else
		{
			CommerceInfo[i][Type]=0;
   			SaveCommerce(i);

		}
		if(CommerceInfo[i][Type]!= 0)
		{
		    compteur ++;
			commpickup[i][0] = CreateDynamicPickup(PICKCENTER,1,CommerceInfo[i][X1],CommerceInfo[i][Y1],CommerceInfo[i][Z1]);
			if(CommerceInfo[i][Interieur] !=0)
			{
  				commpickup[i][1] = CreateDynamicPickup(1318,1,CommerceInfo[i][eX],CommerceInfo[i][eY],CommerceInfo[i][eZ],i,CommerceInfo[i][Interieur]);
			}
			else
			{
				commpickup[i][1] = CreateDynamicPickup(1318,1,CommerceInfo[i][eX],CommerceInfo[i][eY],CommerceInfo[i][eZ],0,0);
			}
		}
		if(CommerceInfo[i][Type]== 0)
		{
			commpickup[i][0] = CreateDynamicPickup(0,0,CommerceInfo[i][X1],CommerceInfo[i][Y1],CommerceInfo[i][Z1]);
			commpickup[i][1] = CreateDynamicPickup(0,0,CommerceInfo[i][X1],CommerceInfo[i][Y1],CommerceInfo[i][Z1],i,CommerceInfo[i][Interieur]);
		}
	}
	printf(".:::: %d commerces chargés ::::.",compteur);
	compteur = 0;
	for(new i;i < MAX_BIZ ; i++)
	{
	    if(fexist(BizPath(i)))
	    {
	        INI_ParseFile(BizPath(i),"LoadBiz_%s",.bExtra = true,.extra = i);
		}
		else
		{
			BizInfo[i][Type] = 0;
			SaveBiz(i);
		}
		if(BizInfo[i][Type] != 0)
		{
		    compteur ++;
			BizPickup[i] = CreateDynamicPickup(1274,1,BizInfo[i][X],BizInfo[i][Y],BizInfo[i][Z]);
		}
	}
	printf(".:::: %d propriétés chargées ::::.",compteur);
	compteur = 0;

	bankpickup[0] = CreateDynamicPickup(1274,1,BANKENTER,0,0);
	bankpickup[1] = CreateDynamicPickup(1318,1,BANKEXIT,0,1);
	bankpickup[2] = CreateDynamicPickup(1239,1,BANKINFO,0,1);

	motelpickup[0] = CreateDynamicPickup(1277,1,HOTELENTER,0,0);
	motelpickup[1] = CreateDynamicPickup(1318,1,HOTELEXIT,0,15);

	weappickup[0] = CreateDynamicPickup(359,3,-1291.6017,490.5652,11.1953,0);
	weappickup[1] = CreateDynamicPickup(362,3,-2641.3499,1416.8595,23.8926,0);

	for(new i;i < MAX_SKYDIVE;i++) CreateDynamicPickup(371,1,SkyDiveSol[i][0],SkyDiveSol[i][1],SkyDiveSol[i][2]);

	for(new i;i<NBATM;i++)	CreateDynamicObject(19526,PosAtm[i][0],PosAtm[i][1],PosAtm[i][2],PosAtm[i][3],PosAtm[i][4],PosAtm[i][5]);

	//GENERALPICKUPS
	AddStaticPickup(2880,1,375.65, -67.50, 1001.50, -1); // BURGER PICKUP
	AddStaticPickup(2768,1,369.52, -6.20, 1001.85, -1); // CLUCKIN BELL PICKUP
	AddStaticPickup(2814,1,373.88, -119.35, 1001.49, -1); // PIZZA PICKUP
	AddStaticPickup(346,1,296.06, -38.03, 1001.51, -1); // AMMU PICKUP
	AddStaticPickup(1275,1,161.33, -83.85, 1001.80, -1); // CLOTHES SHOP PICKUP
	AddStaticPickup(1098,1,-1952.00, 270.00, 35.00,-1); // CARS SHOP PICKUP
	AddStaticPickup(1668,1,-978.5,3792.0,14.0,-1); // JIZZY'S NIGHTCLUB PICKUP
	AddStaticPickup(1544,1,395.0,-1824.0,-15.0,-1); // MALIBU CLUB PICKUP
	AddStaticPickup(1544,1,2582.0,-1650.0,1358.0,-1); // CHINATOWN BAR PICKUP
	AddStaticPickup(19130,1,ALCITY,-1); // PICKUP TO LIBERTY CITY
	AddStaticPickup(PICKCENTER,1,COM_POSENTER,-1); // ENTER COMMI
	AddStaticPickup(1318,1,COM_POSEXIT,-1); // EXIT COMMI
	AddStaticPickup(1247,1,COM_DUTY,-1); // DUTY COMMI
	AddStaticPickup(1318,1,STAD_ENTER,-1); // STADIUM ENTER
	AddStaticPickup(1318,1,STAD_EXIT,-1); // STADIUM EXIT
	AddStaticPickup(1318,1,AMMU_STAND,-1); // AMMUNATION STAND

	//FREE VEHICLES IN CITY
	AddStaticVehicle(421,-2023.8849,337.6310,34.7769,46.0847,0,0); //
	AddStaticVehicle(562,-1951.1639,262.8304,40.7241,48.3976,35,1); //
	AddStaticVehicle(482,-1979.0510,434.9017,26.1855,2.1133,48,48); //
	AddStaticVehicle(585,-1941.2390,585.6181,34.7053,0.0695,42,42); //
	AddStaticVehicle(605,-1929.3820,586.1232,34.9552,358.5550,32,8); //
	AddStaticVehicle(597,-1610.7156,651.6248,6.9747,359.2508,0,1); //
	AddStaticVehicle(599,-1582.3413,673.1873,7.3639,179.4917,0,1); //
	AddStaticVehicle(523,-1594.4854,675.5894,6.7770,182.3937,0,0); //
	AddStaticVehicle(427,-1573.8545,738.8243,-5.0886,88.4815,0,1); //
	AddStaticVehicle(427,-1604.3560,692.2973,-5.0886,181.0423,0,1); //
	AddStaticVehicle(601,-1622.9883,653.6837,-5.4512,90.5011,1,1); //
	AddStaticVehicle(528,-1588.3424,750.2039,-5.1740,182.3650,0,0); //
	AddStaticVehicle(490,-1616.6438,733.8552,-5.9942,357.0867,0,0); //
	AddStaticVehicle(420,-1986.9199,171.4375,27.4645,359.0637,6,1); //
	AddStaticVehicle(437,-1968.0809,90.9575,27.7713,41.6983,79,7); //
	AddStaticVehicle(407,-2057.5420,93.4520,28.6517,86.2985,3,1); //
	AddStaticVehicle(544,-2055.1626,83.5533,28.6539,90.3170,3,1); //
	AddStaticVehicle(429,-2072.7471,-108.6315,34.9949,268.3970,3,0); //
	AddStaticVehicle(577,-1622.0441,-129.3876,14.0899,314.8485,8,10); //
	AddStaticVehicle(497,-1682.7087,708.2231,30.7949,41.7129,0,1); //
	AddStaticVehicle(525,-1634.6011,651.2846,7.0909,359.2697,17,20); //
	AddStaticVehicle(425,278.2516,1987.9772,18.2321,269.1167,43,0); //
	AddStaticVehicle(432,281.3027,1956.0103,17.6650,269.4207,43,0); //
	AddStaticVehicle(432,280.1748,2023.1365,17.6651,265.5844,43,0); //
	AddStaticVehicle(492,2509.5120,-1671.9537,13.2059,347.3994,94,47); //
	AddStaticVehicle(466,2063.7307,-1694.5443,13.3221,270.4035,94,47); //
	AddStaticVehicle(442,956.7966,-1113.7478,23.5685,0.4948,0,0); //
	AddStaticVehicle(571,1305.4230,-796.8719,83.4333,181.5802,36,2); //
	AddStaticVehicle(468,1783.8149,-1932.8715,13.0708,177.4940,46,46); //
	AddStaticVehicle(567,1793.4982,-2130.9214,13.4418,0.3301,3,3); //
	AddStaticVehicle(400,-1891.3163,878.7496,35.1902,359.5934,113,1); // Landstalker
	AddStaticVehicle(401,-1930.4883,833.1628,38.0160,271.3062,47,47); // Bravura
	AddStaticVehicle(405,-1809.1664,613.5859,34.9877,90.9673,36,1); // sentinel
	AddStaticVehicle(410,-1841.3923,613.4404,34.7560,92.8062,9,1); // manana
	AddStaticVehicle(409,-1745.9237,956.3348,24.6353,89.4561,1,1); // stretch
	AddStaticVehicle(405,-1761.9463,956.5258,24.7069,89.8637,40,1); // sentinel
	AddStaticVehicle(418,-1719.4520,1003.7800,17.6959,90.1631,117,227); // moonbean
	AddStaticVehicle(421,-1736.6189,1028.4525,17.4905,270.1995,13,1); // washington
	AddStaticVehicle(422,-1702.7421,1012.0754,17.5885,270.9171,97,25); // bobcat
	AddStaticVehicle(426,-1687.6827,999.6859,17.3436,89.5848,42,42); // premier
	AddStaticVehicle(436,-2607.5256,214.3731,5.9844,279.7526,87,1); // previon
	AddStaticVehicle(439,-2636.6069,212.8010,4.1886,272.0203,8,17); // stallion
	AddStaticVehicle(458,-2688.1499,268.6347,4.2316,359.9718,101,1); // solair
	AddStaticVehicle(467,-2661.5796,267.8036,4.1112,0.5732,58,8); // oceanic
	AddStaticVehicle(479,-2348.5017,-124.1512,35.1297,180.7544,59,36); // regina
	AddStaticVehicle(491,-2318.8174,-125.2937,35.0957,180.1984,71,72); // virgo
	AddStaticVehicle(492,-1720.7925,1344.2117,6.9195,43.9134,77,26); // greenwood
	AddStaticVehicle(500,-1720.2738,1366.3772,7.3078,134.5021,40,84); // mesa
	AddStaticVehicle(500,-2568.7471,214.6987,8.5832,26.7429,40,110); // mesa
	AddStaticVehicle(533,-2556.3953,176.4830,4.6375,359.8880,74,1); // feltzer
	AddStaticVehicle(507,-2221.6550,725.7867,49.1848,269.7400,42,42); // elegant
	AddStaticVehicle(439,-2619.0574,1378.0879,7.0555,0.0040,43,21); // stallion
	AddStaticVehicle(536,-2639.3948,1377.5001,6.9037,179.6569,12,1); // blade
	AddStaticVehicle(555,-2623.5476,1334.4779,6.8968,132.8372,58,1); // windsor
	AddStaticVehicle(567,-2645.7202,1348.8563,7.0608,270.4432,88,64); // savanna
	AddStaticVehicle(561,-2839.9211,918.1295,43.8885,273.6757,8,17); // stratum
	AddStaticVehicle(562,-2872.5046,768.5338,32.6293,174.2740,35,1); // elegy
	AddStaticVehicle(416,-2644.6995,631.2380,14.6304,89.7613,1,3); // ambulance
	AddStaticVehicle(416,-2676.1987,631.0990,14.6299,90.6646,1,3); // ambulance
	AddStaticVehicle(416,-2572.7480,660.9737,14.6309,91.2074,1,3); // ambulance
	AddStaticVehicle(405,-2571.7524,632.8818,14.3575,90.7433,75,1); // sentinel
	AddStaticVehicle(445,-2589.5505,621.9856,14.3557,89.1073,35,35); // admiral
	AddStaticVehicle(416,-2573.5115,626.3317,27.9830,179.8820,1,3); // ambulance
	AddStaticVehicle(458,-2544.9766,638.4733,27.7080,270.0870,113,1); // solair
	AddStaticVehicle(527,-2592.2014,660.8000,27.5406,86.9379,53,1); // cadrona
	AddStaticVehicle(409,-2658.0334,376.7588,4.0550,358.7641,1,1); // stretch
	AddStaticVehicle(409,-2754.9392,375.8286,4.0562,180.8166,1,1); // stretch
	AddStaticVehicle(545,-2682.9575,-21.8133,4.1731,179.8855,47,1); // hustler
	AddStaticVehicle(550,-2680.0308,-55.1360,4.1735,0.3464,42,42); // sunrise
	AddStaticVehicle(579,-2627.4619,-34.5574,4.3018,179.5269,42,42); // huntley
	AddStaticVehicle(566,-2626.8508,-55.1009,4.1385,0.5633,30,8); // tahoma
	AddStaticVehicle(551,-2640.0332,-55.1483,4.1513,0.1438,72,1); // merit
	AddStaticVehicle(445,-2776.4673,-281.3869,6.9375,179.6328,37,37); // admiral
	AddStaticVehicle(526,-2741.8342,-281.0621,6.8213,179.3165,9,39); // fortune
	AddStaticVehicle(516,-2760.5996,-312.0970,6.8852,3.7481,119,1); // nebula
	AddStaticVehicle(400,-2397.6335,-591.8925,132.7490,126.7012,101,1); // landstalker
	AddStaticVehicle(579,-2399.7363,-613.0505,132.6091,34.8097,53,53); // huntley
	AddStaticVehicle(582,-2498.2412,-602.2610,132.6339,180.3378,41,20); // newsvan
	AddStaticVehicle(582,-2516.8743,-602.1055,132.6378,180.3694,49,11); // newsvan
	AddStaticVehicle(457,-2375.6770,-214.7089,42.3606,112.9797,2,1); // caddy
	AddStaticVehicle(457,-2508.9243,-254.0076,38.3782,236.4911,63,1); // caddy
	AddStaticVehicle(458,-2076.9346,-83.9503,35.0599,0.4557,4,1); // solair
	AddStaticVehicle(405,-2064.2334,-84.2409,35.0625,180.7567,91,1); // sentinel
	AddStaticVehicle(426,-2221.5732,573.8536,34.8478,89.5162,53,53); // premier
	AddStaticVehicle(480,-2189.9182,645.1689,49.2245,91.0605,12,12); // comet
	AddStaticVehicle(468,-2212.3809,636.9928,49.1310,322.8875,46,46); // sanchez
	AddStaticVehicle(404,-2266.4763,136.8047,34.9240,269.9253,119,50); // perrenial
	AddStaticVehicle(400,-2265.5767,144.9516,35.2612,91.4436,4,1); // landstalker
	AddStaticVehicle(423,-2512.6152,771.9629,35.2173,268.9654,1,56); // mr whoopee
	AddStaticVehicle(413,-2491.2207,741.4029,35.1137,180.4925,88,1); // pony
	AddStaticVehicle(424,-2451.4731,741.3017,34.8121,179.4907,2,2); // bf injection
	AddStaticVehicle(408,-2473.2112,775.5399,35.7552,270.2573,26,26); // trashmaster
	AddStaticVehicle(421,-2504.0022,741.0894,34.9268,179.0762,75,1); // washington
	AddStaticVehicle(401,-2411.9275,741.3586,34.8116,179.5389,87,87); // Bravura
	AddStaticVehicle(512,-1398.3502,-224.7388,14.4481,335.1982,15,123); // cropduster
	AddStaticVehicle(512,-1351.5717,-281.7506,14.4447,313.1136,61,96); // cropduster
	AddStaticVehicle(459,-1897.3453,-846.7831,32.0993,90.4346,28,28); // berkley's van
	AddStaticVehicle(461,-1896.9559,-843.0089,31.6278,76.1634,3,2); // pcj
	AddStaticVehicle(461,-1895.9564,-850.3106,31.6169,114.1319,43,1); // pcj
	AddStaticVehicle(478,-2266.0344,192.5950,35.1745,88.4537,66,1); // walton
	AddStaticVehicle(500,-2265.1746,121.3230,35.2965,89.4938,28,119); // mesa
	AddStaticVehicle(602,-2267.1902,89.3121,34.9957,267.8623,69,1); // alpha
	AddStaticVehicle(587,-2270.2966,61.8582,34.9042,89.1748,40,1); // euros
	AddStaticVehicle(588,-2281.5806,139.5606,35.1902,176.6732,1,1); // hotdog
	AddStaticVehicle(504,-1284.5809,1022.9224,1037.5333,105.8612,-1,-1); // vderby
	AddStaticVehicle(504,-1277.0148,1006.1588,1037.2379,95.0502,-1,-1); // vderby
	AddStaticVehicle(504,-1276.1179,994.6937,1036.9998,90.8183,-1,-1); // vderby
	AddStaticVehicle(504,-1279.5881,981.6170,1036.8326,82.5904,-1,-1); // vderby
	AddStaticVehicle(504,-1283.8853,970.2625,1036.6532,75.4928,-1,-1); // vderby
	AddStaticVehicle(504,-1292.6711,959.9589,1036.4899,69.9258,-1,-1); // vderby
	AddStaticVehicle(504,-1512.2087,969.4289,1037.0444,283.4230,-1,-1); // vderby
	AddStaticVehicle(504,-1518.9764,979.9171,1037.1821,286.4578,-1,-1); // vderby
	AddStaticVehicle(504,-1520.0887,993.1644,1037.4524,271.2275,-1,-1); // vderby
	AddStaticVehicle(504,-1519.3999,1008.8347,1037.7006,262.7385,-1,-1); // vderby
	AddStaticVehicle(504,-1512.3094,1022.7266,1037.9211,255.1836,-1,-1); // vderby
	AddStaticVehicle(504,-1443.9871,1059.9962,1038.4242,276.4322,-1,-1); // vderby
	AddStaticVehicle(504,-1415.8496,1062.1569,1038.4021,270.0847,-1,-1); // vderby

	for(new i;i<MAX_VEHICLES;i++)
	{
	    if(GetVehicleModel(i) != 0 && GetVehicleModel(i) != 504)
	    {
  			new engine = random(2),
			lights = 0,
			alarm,
			doors = 0,
			bonnet,
			boot = 0,
			objective = 0;
			vPosseded[i] = false;
			if(engine == 0)
			{
				bonnet = 1;
				SetVehicleHealth(i, randomEx(251, 400));
			}
			SetVehicleParamsEx(i, engine, lights, alarm, doors, bonnet, boot, objective);
		}
		if(GetVehicleModel(i) == 504) LinkVehicleToInterior(i,INT);
	}

	SetTimer("Speedometer", 300, true);

	Underline = TextDrawCreate(607.571594, 397.446624, "-");
	TextDrawLetterSize(Underline, 0.000000, -0.212750);
	TextDrawTextSize(Underline, 537.428588, 0.000000);
	TextDrawAlignment(Underline, 1);
	TextDrawColor(Underline, 0);
	TextDrawUseBox(Underline, true);
	TextDrawBoxColor(Underline, 255);
	TextDrawSetShadow(Underline, 0);
	TextDrawSetOutline(Underline, 0);
	TextDrawFont(Underline, 0);

	Title = TextDrawCreate(539.428588, 383.573211, "Vitesse / Etat");
	TextDrawLetterSize(Title, 0.217999, 1.288532);
	TextDrawAlignment(Title, 1);
	TextDrawColor(Title, -1);
	TextDrawSetShadow(Title, 0);
	TextDrawSetOutline(Title, 1);
	TextDrawBackgroundColor(Title, 51);
	TextDrawFont(Title, 2);
	TextDrawSetProportional(Title, 1);

	KMH = TextDrawCreate(571.428955, 416.426666, "KM/H");
	TextDrawLetterSize(KMH, 0.318951, 1.070932);
	TextDrawAlignment(KMH, 1);
	TextDrawColor(KMH, -1);
	TextDrawSetShadow(KMH, 0);
	TextDrawSetOutline(KMH, 1);
	TextDrawBackgroundColor(KMH, 51);
	TextDrawFont(KMH, 2);
	TextDrawSetProportional(KMH, 1);

	for(new i = 0; i < GetMaxPlayers(); i++)
	{
	    VehicleName[i] = TextDrawCreate(538.285278, 396.800018, " ");
		TextDrawLetterSize(VehicleName[i], 0.206952, 1.130664);
		TextDrawAlignment(VehicleName[i], 1);
		TextDrawColor(VehicleName[i], -1);
		TextDrawSetShadow(VehicleName[i], 0);
		TextDrawSetOutline(VehicleName[i], 1);
		TextDrawBackgroundColor(VehicleName[i], 51);
		TextDrawFont(VehicleName[i], 2);
		TextDrawSetProportional(VehicleName[i], 1);

		VehicleSpeed[i] = TextDrawCreate(537.903259, 402.346588, " ");
		TextDrawLetterSize(VehicleSpeed[i], 0.435141, 2.909866);
		TextDrawAlignment(VehicleSpeed[i], 1);
		TextDrawColor(VehicleSpeed[i], -1);
		TextDrawSetShadow(VehicleSpeed[i], 0);
		TextDrawSetOutline(VehicleSpeed[i], 1);
		TextDrawBackgroundColor(VehicleSpeed[i], 51);
		TextDrawFont(VehicleSpeed[i], 2);
		TextDrawSetProportional(VehicleSpeed[i], 1);
	}

	SetTimer("HourUpdate",1000*60*60,true);
	SetGravity(0.0065);
    UsePlayerPedAnims();
    EnableStuntBonusForAll(false);
   	DisableInteriorEnterExits();
	SetGameModeText("San Andreas Online");
	ShowNameTags(true);
	SetNameTagDrawDistance(40.0);
	SetObjectsDefaultCameraCol(true);

	bactor = CreateActor(295,1667.3759,-970.8100,683.6854,185.2696);
	SetActorInvulnerable(bactor,true);

	new aammu;
	aammu = CreateActor(179,296.40,-40.20,1001.5,354.30);
	SetActorVirtualWorld(aammu,5);
	new abar;
	abar = CreateActor(179,2584.9, -1651.9, 1359.0, 357.9);
	SetActorVirtualWorld(abar,11);

	#include <Gamemode/actors>
	for(new i;i<MAX_ACTORS;i++)
	{
	    if(IsValidActor(i))
	    {
			SetActorHealth(actor[i],100.0);
			SetActorInvulnerable(actor[i],false);
		}
	}
	for(new i; i < MAX_ACTORS ; i++) if(IsValidActor(i) && !IsActorInvulnerable(i)) compteur ++;
	printf(".:::: %d acteurs chargés ::::.",compteur);
	compteur = 0;
	for(new i; i < MAX_VEHICLES ; i++) if(GetVehicleModel(i) >= 400) compteur ++;
	printf(".:::: %d véhicules chargés ::::.",compteur);
	compteur = 0;
	for(new i; i < MAX_OBJECTS ; i++) if(IsValidObject(i)) compteur ++;
	printf(".:::: %d objets chargés ::::.",compteur + CountDynamicObjects());
	compteur = 0;
	for(new i;i<MAX_ACTORS;i++)
	{
		for(new i2;i2<MAX_COMMERCES;i2++)
		{
		    if(CommerceInfo[i2][Type] != 0)
		    {
				if(GetDistance(CommerceInfo[i2][eX],CommerceInfo[i2][eY],CommerceInfo[i2][eZ],363.27,-74.60,1001.50)<= 10.0)
				{
					i = CreateActor(205,376.47,-65.25,1001.50,182.97); // BURGER ACTOR
					SetActorVirtualWorld(i,i2);
				}
				else if(GetDistance(CommerceInfo[i2][eX],CommerceInfo[i2][eY],CommerceInfo[i2][eZ],365.29,-10.81,1001.85)<= 10.0)
				{
					i = CreateActor(167,368.18,-4.21,1001.85,177.14); // CLUCKIN BELL ACTOR
					SetActorVirtualWorld(i,i2);
				}
				else if(GetDistance(CommerceInfo[i2][eX],CommerceInfo[i2][eY],CommerceInfo[i2][eZ],372.06,-131.60,1001.49)<= 10.0)
				{
					i = CreateActor(155,374.89,-116.65,1001.49,181.28); // PIZZA ACTOR
					SetActorVirtualWorld(i,i2);
				}
		    }
		}
	}
	return 1;
}

public OnGameModeExit()
{
	for(new i;i<MAX_HOUSES;i++)
	{
	    SaveHouse(i);
	}
	for(new i;i<MAX_COMMERCES;i++)
	{
	    SaveCommerce(i);
	}
	for(new i; i<MAX_BIZ;i++)
	{
	    SaveBiz(i);
	}
	for(new i;i<MAX_PLAYERS;i++)
	{
	    if(IsPlayerNPC(i))
	    {
			Kick(i);
		}
		if(FCNPC_IsValid(i))
		{
		    DestroyNPC(i);
		}
	}
	
 	MapAndreas_Unload();
 	
	//SPEEDOMETER SETTINGS
	TextDrawHideForAll(Underline);
	TextDrawDestroy(Underline);
	TextDrawHideForAll(Title);
	TextDrawDestroy(Title);
	TextDrawHideForAll(KMH);
	TextDrawDestroy(KMH);

	for(new i = 0; i < GetMaxPlayers(); i++)
	{
		TextDrawDestroy(VehicleName[i]);
		TextDrawDestroy(VehicleSpeed[i]);
	}

	printf("Le serveur redémarre... Les commerces, maisons et données des joueurs ont étés sauvegardés !");
	return 1;
}

public OnActorDeath(actorid, killerid, reason)
{
	SetActorRespawnTime(actorid, 60000);
    new Float:x,Float:y,Float:z;
    GetActorPos(actorid,x,y,z);
	new value = random(100);
    while(value == 0) value = random(100);
    CreateMoneyPickup(x-2,y-2,z,value,GetActorVirtualWorld(actorid),-1);
	GivePlayerWantedLevel(killerid,STAR_KILLACTOR);
    ApplyActorAnimation(actorid,"PED","KO_SHOT_FACE",4.0, 0, 1, 1, 1, -1);
    KillTimer(resetactoranim[actorid]);
    
	return 1;
}
public OnActorSpawn(actorid)
{
	ResetActorAnim(actorid);
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys & KEY_JUMP && !(oldkeys & KEY_JUMP) && GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_CUFFED){
	ApplyAnimation(playerid, "GYMNASIUM", "gym_jog_falloff",4.1,0,1,1,0,0);
	}
	if(newkeys & KEY_SUBMISSION)
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		if(IsPlayerInAnyVehicle(playerid) && sdrive[playerid] == true)
		{
		    SetVehicleVelocity(vehicleid,0.0,0.0,0.0);
		}
	}
	if(newkeys & KEY_ACTION)
	{
	    new vehicleid = GetPlayerVehicleID(playerid);
	    if(IsPlayerInAnyVehicle(playerid) && sdrive[playerid] == true)
	    {
			new Float:x,Float:y,Float:z;
			GetVehicleVelocity(vehicleid,x,y,z);
			SetVehicleVelocity(vehicleid,x,y,z + 0.35);
		}
	}
	if(newkeys & KEY_FIRE)
	{
	    new vehicleid = GetPlayerVehicleID(playerid);
	    if(IsPlayerInAnyVehicle(playerid) && sdrive[playerid] == true)
	    {
			new Float:x,Float:y,Float:z;
			GetVehicleVelocity(vehicleid,x,y,z);
			SetVehicleVelocity(vehicleid,x * 1.35,y * 1.35,z*1.35);
		}
		if(GetVehicleModel(vehicleid) == 504 && GetPlayerInterior(playerid) == 15)
		{
		    if(GetPlayerSpeed(playerid, 0) < 175)
		    {
   				new Float:x,Float:y,Float:z;
				GetVehicleVelocity(vehicleid,x,y,z);
				SetVehicleVelocity(vehicleid,x * 1.2,y * 1.2,z*1.2);
			}
		}
	}
	if(newkeys & KEY_YES)
	{
	    if(IsPlayerInRangeOfPoint(playerid,1.0,POSCAISSES))
	    {
	        if(mission[playerid] == 2)
	        {
  				SetMissionObj(playerid, "Déposes la caisse dans le coffre du Boxville");
   				ApplyAnimation(playerid,"MISC","pickup_box",6.0,0,1,1,1,1,1);
				SetPlayerAttachedObject( playerid, 9, 3799, 1, 0.04, 0.420760, 0.00000, 0.000000, 92.0, 0.000000,0.125,0.125, 0.125 );
	         	SetTimerEx("AnimPorter",500,false,"i",playerid);
	        }
		}
	    if(IsCalling[playerid]==1)
	    {
	        StartAppel(playerid);
		}
		if(SelectItem[playerid] != 0)
		{
		    NextPage(playerid,achat[playerid]);
		}
		for(new i;i<MAX_HOUSES;i++)
		{
		    if(HouseInfo[i][Type]>0)
		    {
		        if(IsPlayerInRangeOfPoint(playerid,1.0,HouseInfo[i][X1],HouseInfo[i][Y1],HouseInfo[i][Z1]) || IsPlayerInRangeOfPoint(playerid,1.0,HouseInfo[i][eX],HouseInfo[i][eY],HouseInfo[i][eZ]))
		        {
					if(HouseInfo[i][Lock]==1)
					{
					    if(!strcmp(GetName(playerid),proprio[i]))
					    {
					        UnlockHouse(playerid,i);
						}
					}
				}
			}
		}
	}
	if(newkeys & KEY_NO)
	{
		if(IsCalling[playerid]== 1 || InCall[playerid]==1)
		{
		    EndCall(playerid,TalkingID[playerid],3);
		}
		else
		{
		    if(mission[playerid] != 0 && countdia[playerid] != 0 && AlreadyDone[playerid][mission[playerid]] == true && PressN[playerid] == false)
		    {
		        SubMessage(playerid,MSG_BLUE,"Veuillez patienter...",5);
				PressN[playerid] = true;
			}
		    if(mission[playerid] == 2)
		    {
			    new Float:x,Float:y,Float:z;
			    GetPosBehindVehicle(vmission[playerid],x,y,z);
			    if(IsPlayerInRangeOfPoint(playerid,2.0,x,y,z))
			    {
					new string[256];
					if(havebox[playerid] == true)
					{
						if(caisses[playerid] > 1)
						{
				    		SetMissionObj(playerid, "Retournes voir Fabrizio");
							DisablePlayerCheckpoint(playerid);
							SetPlayerCheckpoint(playerid,POSMISSION2,1.0);
							RemovePlayerAttachedObject(playerid,9);
							ClearAnimations(playerid);
							havebox[playerid] = false;
						}
						else
						{
						RemovePlayerAttachedObject(playerid,9);
						caisses[playerid] ++;
						format(string,sizeof(string),"Tu as chargé une caisse, il en reste encore %d",3-caisses[playerid]);
			 			SetMissionObj(playerid, string);
						ClearAnimations(playerid);
						havebox[playerid] = false;
						}
	     			}
					else
					{
		 				SetMissionObj(playerid, "Tu ne portes pas de caisse !");
					}
				}
			}
	  		if(SelectItem[playerid] != 0)
		    {
		        PreviousPage(playerid,achat[playerid]);
			}
	  		new currentweap = GetPlayerWeapon(playerid);
		    if(currentweap > 0 && !IsPlayerInAnyVehicle(playerid))
		    {
		    	new weapons[13][2],weapslot,weapname[32];
				for (new i = 0; i <= 12; i++)
				{
				    GetPlayerWeaponData(playerid, i, weapons[i][0], weapons[i][1]);
				    if(weapons[i][0] == currentweap)
				    {
						weapslot = i;
						break;
					}
				}
				new object,Float:x,Float:y,Float:z;
				new Float:vz1,Float:vz;
				GetPlayerVelocity(playerid,x,y,vz1);
			    GetPlayerPos(playerid,x,y,vz);
				MapAndreas_FindZ_For2DCoord(x,y,z);
				if(vz < z && vz1 == 0.0) z = vz -1.0;
				object = CreateObject(GetModelWeapon(currentweap),x,y,z,90.0,0.0,0.0,0);
				WeaponObject[object][Model] = currentweap;
				WeaponObject[object][Ammo] = weapons[weapslot][1];
				WeaponObject[object][Light] = CreateDynamicObject(19290,x,y,z,0.0,0.0,0.0);
				GetWeaponName(currentweap,weapname,sizeof(weapname));
				printf("[Weapon] %s a posé un(e) %s de %d munitions.",GetName(playerid),weapname,WeaponObject[object][Ammo]);
				new string[256];
				format(string,sizeof(string),"~w~%s ~b~de ~w~%d ~b~munitions posé !",weapname,WeaponObject[object][Ammo]);
				SubMessage(playerid,MSG_BLUE,string,3);
				GivePlayerWeapon(playerid,currentweap,-WeaponObject[object][Ammo]);
				ApplyAnimation(playerid, "GRENADE", "WEAPON_throwu", 4.0, 0, 1, 1,0, 0, 1);
			}
			for(new i;i<MAX_HOUSES;i++)
			{
			    if(HouseInfo[i][Type]>0)
			    {
			        if(IsPlayerInRangeOfPoint(playerid,1.0,HouseInfo[i][X1],HouseInfo[i][Y1],HouseInfo[i][Z1]) || IsPlayerInRangeOfPoint(playerid,1.0,HouseInfo[i][eX],HouseInfo[i][eY],HouseInfo[i][eZ]))
			        {
						if(HouseInfo[i][Lock]==0)
						{
						    if(!strcmp(GetName(playerid),proprio[i]))
						    {
						        LockHouse(playerid,i);
							}
						}
					}
				}
			}
		}
	}
	if(newkeys & KEY_SECONDARY_ATTACK)
	{
		if(IsPlayerAtVendingMachine(playerid) && GetPlayerMoney(playerid) >= 1) GiveMoney(playerid, -10);
 		if(robbing[playerid] == true && havebox[playerid] == true)
		{
			new Float:vx,Float:vy,Float:vz;
			GetVehiclePos(vmission[playerid],vx,vy,vz);
			if(IsPlayerInRangeOfPoint(playerid,5.0,vx,vy,vz))
			{
				RemovePlayerAttachedObject(playerid,9);
				ClearAnimations(playerid);
				havebox[playerid] = false;
    			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
			}
		}
		for(new i;i<MAX_HOUSES;i++)
		{
		    if(HouseInfo[i][Type]>0)
		    {
		        if(IsPlayerInRangeOfPoint(playerid,1.0,HouseInfo[i][X1],HouseInfo[i][Y1],HouseInfo[i][Z1]))
		        {
		            if(HouseInfo[i][Lock]==1)
	 				{
	 					GameTextForPlayerEx(playerid,"~r~VERROUILLÉ",2000,5);
	 					if(robbing[playerid] == true)
	 					{
	 					    SubMessage(playerid,MSG_RED,"Cette porte est verrouillée !",5);
	 					    FailRobHouse(playerid);
						}
						return 1;
					}
	                oldint[playerid] = GetPlayerInterior(playerid);
	                if(HouseInfo[i][Interior] !=0)
	                {
						SetPlayerPosEx(playerid,HouseInfo[i][eX],HouseInfo[i][eY],HouseInfo[i][eZ],HouseInfo[i][Interior],i);
					}
					else
					{
		            	SetPlayerPosEx(playerid,HouseInfo[i][eX],HouseInfo[i][eY],HouseInfo[i][eZ],HouseInfo[i][Interior],0);
					}
					if(robbing[playerid] == true)
					{
					    new proprioid = GetPlayerID(proprio[housefocus[playerid]]);
					    if(IsPlayerConnected(proprioid))
					    {
							new string[256];
							format(string,sizeof(string),"~r~Votre maison se fait cambrioler par ~w~%s !",GetName(playerid));
							SubMessage(proprioid,MSG_BLUE,string,5);
						}
					    SubMessage(playerid,MSG_YELLOW,"Rejoignez le checkpoint, il peut y avoir choses intéressantes là-bas.",5);
						SetPlayerCheckpoint(playerid,HouseInfo[housefocus[playerid]][cX],HouseInfo[housefocus[playerid]][cY],HouseInfo[housefocus[playerid]][cZ],2.0);
					}
				}
				else if(IsPlayerInRangeOfPoint(playerid,1.0,HouseInfo[i][eX],HouseInfo[i][eY],HouseInfo[i][eZ]))
				{
				    if(HouseInfo[i][Lock]==1) return GameTextForPlayerEx(playerid,"~r~VERROUILLÉ",2000,5);
				    {
					    if(HouseInfo[i][Interior] == 0)
					    {
					    	SetPlayerPosEx(playerid,HouseInfo[i][X1],HouseInfo[i][Y1],HouseInfo[i][Z1],oldint[playerid],0);
						}
						else
						{
							SetPlayerPosEx(playerid,HouseInfo[GetPlayerVirtualWorld(playerid)][X1],HouseInfo[GetPlayerVirtualWorld(playerid)][Y1],HouseInfo[GetPlayerVirtualWorld(playerid)][Z1],oldint[playerid],0);
						}
					}
				}
			}
		}
		for(new i;i<MAX_COMMERCES;i++)
		{
		    if(CommerceInfo[i][Type]>0)
		    {
		        if(IsPlayerInRangeOfPoint(playerid,1.0,CommerceInfo[i][X1],CommerceInfo[i][Y1],CommerceInfo[i][Z1]))
		        {
		            oldint[playerid] = GetPlayerInterior(playerid);
		            if(CommerceInfo[i][Interieur] !=0)
		            {
	          			SetPlayerPosEx(playerid,CommerceInfo[i][eX],CommerceInfo[i][eY],CommerceInfo[i][eZ],CommerceInfo[i][Interieur],i);
					}
					else
					{
        				SetPlayerPosEx(playerid,CommerceInfo[i][eX],CommerceInfo[i][eY],CommerceInfo[i][eZ],0,0);
					}
				}
				else if(IsPlayerInRangeOfPoint(playerid,1.0,CommerceInfo[i][eX],CommerceInfo[i][eY],CommerceInfo[i][eZ]))
				{
				    if(CommerceInfo[i][Interieur] !=0)
				    {
						if(GetPlayerVirtualWorld(playerid) == i)
						{
							SetPlayerPosEx(playerid,CommerceInfo[i][X1],CommerceInfo[i][Y1],CommerceInfo[i][Z1],oldint[playerid],0);
						}
					}
					else
					{
					    SetPlayerPosEx(playerid,CommerceInfo[i][X1],CommerceInfo[i][Y1],CommerceInfo[i][Z1],oldint[playerid],0);
					}
				}
			}
		}
		new biz;
		if(PlayerInfo[playerid][pBiz] > 0) biz = PlayerInfo[playerid][pBiz];
		if(IsPlayerInRangeOfPoint(playerid,1.0,BizInfo[biz][X],BizInfo[biz][Y],BizInfo[biz][Z]) && biz > 0 && BizInfo[biz][Caisse] != 0) // DROP CASH BIZ
		{
		    new string[256];
			format(string,sizeof(string),"Ta propriété t'as rapporté ~w~$%d",BizInfo[biz][Caisse]);
			SubMessage(playerid,MSG_BLUE,string,5);
			GiveMoney(playerid,BizInfo[biz][Caisse]);
			BizInfo[biz][Caisse] = 0;
		}
		if(IsPlayerInRangeOfPoint(playerid,1.0,AMMU_STAND))
		{
		    if(IsPlayerFree(playerid))
		    {
		        new msg[512];
				msg = "Derrière cette porte se trouve le stand de tir\n\n";
				strcat(msg,"Tu devras tirer sur la cible avec une seule munition, si tu la manque, tu perds !\n");
				strcat(msg,"La difficulté augmentera au fur et à mesure des niveaux.\n");
				strcat(msg,"Tu n'aura de récompense qu'à partir du niveau 4 !.\n");
				ShowPlayerDialog(playerid,47,DIALOG_STYLE_MSGBOX,"Stand de Tir",msg,"Ok","Quitter");
			}
		}

		if(IsPlayerInRangeOfPoint(playerid,1.0,COM_POSENTER))
		{
		    SubMessage(playerid,MSG_YELLOW,"Info : Faites entrée sur le pickup pour devenir policier !",5);
		    SetPlayerPosEx(playerid,COM_POSEXIT,10,0);
		}
		if(IsPlayerInRangeOfPoint(playerid,1.0,STAD_ENTER))
		{
		    SubMessage(playerid,MSG_BLUE,"Des voitures sont à votre disposition !",5);
		    SetPlayerPosEx(playerid,STAD_EXIT,INT,0);
		}
		if(IsPlayerInRangeOfPoint(playerid,1.0,STAD_EXIT))
		{
			SetPlayerPosEx(playerid,STAD_ENTER,0,0);
		}
		if(IsPlayerInRangeOfPoint(playerid,1.0,COM_POSEXIT))
		{
		    SetPlayerPosEx(playerid,COM_POSENTER,0,0);
		}
		if(IsPlayerInRangeOfPoint(playerid,1.0,COM_DUTY))
		{
		    SubMessage(playerid,MSG_BLUE,"Tu deviens policier !",5);
		}
		if(IsPlayerInRangeOfPoint(playerid,1.0,BANKENTER))
		{
		    SetPlayerPosEx(playerid,BANKEXIT,1,0);
		}
		if(IsPlayerInRangeOfPoint(playerid,1.0,BANKEXIT))
		{
		    SetPlayerPosEx(playerid,BANKENTER,0,0);
			PlayerPlaySound(playerid,0,0,0,0);
		}
		if(IsPlayerInRangeOfPoint(playerid,2.0,ALCITY))
		{
	        MTD(playerid,"Départ pour Liberty City...",-1,true);
		}
		if(IsPlayerInRangeOfPoint(playerid,2.0,HOTELENTER))
		{
			SetPlayerPosEx(playerid,HOTELEXIT,15,0);
		}
		if(IsPlayerInRangeOfPoint(playerid,2.0,HOTELEXIT))
		{
			SetPlayerPosEx(playerid,HOTELENTER,0,0);
		}
		if(IsPlayerInRangeOfPoint(playerid,2.0,375.65, -67.50, 1001.50))
		{
		    if(PlayerInfo[playerid][pCash] <20)
		    {
		        if(PlayerInfo[playerid][pBanque] < 20) return SubMessage(playerid,MSG_RED,"T'as pas assez d'argent pour te payer un hamburger !",5);
				PlayerInfo[playerid][pBanque] -= 20;
			}
			else GiveMoney(playerid,-20);

			SetPlayerHealth(playerid,100);
	        GiveMoneyResto(20,BURGER);
	        SubMessage(playerid,MSG_BLUE,"Tu as mangé un hamburger pour ~w~$20 ~b~, ta vie a été restaurée !",5);
	        SetPlayerAttachedObject(playerid,4,19094,6,0.057999,0.082999,0.034000,0.000000,0.000000,0.000000,0.457000,0.251001,0.271001);
	        ApplyAnimation(playerid, "FOOD", "EAT_Burger", 3.0, 0, 0, 0, 0, 0);
			SetTimerEx("RemoveHandObject",4000,false,"i",playerid);
		}
		if(IsPlayerInRangeOfPoint(playerid,2.0,369.52 ,-6.20, 1001.85))
		{
		    if(PlayerInfo[playerid][pCash] <20)
		    {
		        if(PlayerInfo[playerid][pBanque] < 20) return SubMessage(playerid,MSG_RED,"T'as pas assez d'argent pour te payer un burger au poulet !",5);
				PlayerInfo[playerid][pBanque] -= 20;
			}
			else GiveMoney(playerid,-20);

			SetPlayerHealth(playerid,100);
	        GiveMoneyResto(20,CLUCKIN);
	        SubMessage(playerid,MSG_BLUE,"Tu as mangé un burger au poulet pour ~w~$20 ~b~, ta vie a été restaurée !",5);
	        SetPlayerAttachedObject(playerid,4,19094,6,0.057999,0.082999,0.034000,0.000000,0.000000,0.000000,0.457000,0.251001,0.271001);
	        ApplyAnimation(playerid, "FOOD", "EAT_Burger", 3.0, 0, 0, 0, 0, 0);
			SetTimerEx("RemoveHandObject",4000,false,"i",playerid);
		}
		if(IsPlayerInRangeOfPoint(playerid,2.0,-978.5,3792.0,14.0)) // JIZZY'S NIGHTCLUB PICKUP
		{
		    if(PlayerInfo[playerid][pCash] <30) return SubMessage(playerid,MSG_RED,"T'as pas assez d'argent pour te payer une vodka !",5);
		    {
		        SetPlayerHealth(playerid,100);
		        GiveMoney(playerid,-30);
		        SubMessage(playerid,MSG_BLUE,"Tu as bu une vodka pour ~w~$30 ~b~, tu es dans un état déplorable !",5);
	        	SetPlayerAttachedObject(playerid,4,1668,6,0.057999,0.082999,0.034000,0.000000,0.000000,0.000000,0.457000,0.251001,0.271001);
		        ApplyAnimation(playerid, "VENDING", "VEND_Drink_P", 3.0, 0, 0, 0, 0, 0);
		        SetPlayerDrunkLevel (playerid, 30000);
				SetTimerEx("RemoveHandObject",4000,false,"i",playerid);
			}
		}
		if(IsPlayerInRangeOfPoint(playerid,2.0,2582.0,-1650.0,1358.0)) // CHINATOWN BAR PICKUP
		{
		    if(PlayerInfo[playerid][pCash] <20) return SubMessage(playerid,MSG_RED,"T'as pas assez d'argent pour te payer une bière !",5);
		    {
		        GiveMoney(playerid,-20);
		        SubMessage(playerid,MSG_BLUE,"Tu as acheté une bière pour ~w~$20 ~b~!~n~Appuies sur ~w~~k~~VEHICLE_ENTER_EXIT~ ~b~pour la jeter",5);
    			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_BEER);
			}
		}
		if(IsPlayerInRangeOfPoint(playerid,2.0,395.0,-1824.0,-15.0)) // MALIBU CLUB PICKUP
		{
		    if(PlayerInfo[playerid][pCash] <20) return SubMessage(playerid,MSG_RED,"Tu n'as pas assez d'argent pour te payer une bière !",5);
		    {
		        GiveMoney(playerid,-20);
		        SubMessage(playerid,MSG_BLUE,"Tu as acheté une bière pour ~w~$20 ~b~!~n~Appuies sur ~w~~k~~VEHICLE_ENTER_EXIT~ ~b~pour la jeter",5);
    			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_BEER);
			}
		}
		if(IsPlayerInRangeOfPoint(playerid,2.0,373.88, -119.35, 1001.49))
		{
		    if(PlayerInfo[playerid][pCash] <20)
		    {
		        if(PlayerInfo[playerid][pBanque] < 20) return SubMessage(playerid,MSG_BLUE,"T'as pas assez d'argent pour te payer une pizza !",5);
				PlayerInfo[playerid][pBanque] -= 20;
			}
			else GiveMoney(playerid,-20);

			SetPlayerHealth(playerid,100);
	        GiveMoneyResto(20,PIZZA);
	        SubMessage(playerid,MSG_BLUE,"Tu as mangé une pizza pour ~w~$20 ~b~, ta vie a été restaurée !",5);
	        SetPlayerAttachedObject(playerid,4,19094,6,0.057999,0.082999,0.034000,0.000000,0.000000,0.000000,0.457000,0.251001,0.271001);
	        ApplyAnimation(playerid, "FOOD", "EAT_Burger", 3.0, 0, 0, 0, 0, 0);
			SetTimerEx("RemoveHandObject",4000,false,"i",playerid);
		}
		if(IsPlayerInRangeOfPoint(playerid,1.0,296.06, -38.03, 1001.51))
		{
		    if(SelectItem[playerid] == 0)
		    {
			    ShowTDComm(playerid,1);
			    SubMessage(playerid,MSG_YELLOW,"Utilise ~w~~k~~CONVERSATION_YES~ ~y~et ~w~~k~~CONVERSATION_NO~ ~y~pour changer d'article,~n~ ~w~~k~~PED_SPRINT~ ~y~pour acheter et ~w~~k~~VEHICLE_ENTER_EXIT~ ~y~pour quitter.",5);
			}
			else
			{
			    HideTDComm(playerid,1);
			}
		}
		if(IsPlayerInRangeOfPoint(playerid,2.0,161.33, -83.85, 1001.80))
		{
		    DestroySelectionMenu(playerid);
		    SetPVarInt(playerid, "skinc_active", 1);
		    CreateSelectionMenu(playerid);
		    SelectTextDraw(playerid, 0xACCBF1FF);
		}
		if(IsPlayerInRangeOfPoint(playerid,2.0,-1952.00, 270.00, 35.00))
		{
			if(VehicleInfo[playerid][Model] != 0) return SubMessage(playerid,MSG_RED,"Tu as déjà une voiture ! fais /sellveh pour la vendre !",5);
			{
				if(SelectItem[playerid] == 0)
			    {
			    	if(concessbusy == true) return SubMessage(playerid,MSG_RED,"Le vendeur est occupé, il s'occupera de toi dans quelques instants !",5);
	    			{
			    		SubMessage(playerid,MSG_YELLOW,"Utilise ~w~~k~~CONVERSATION_YES~ ~y~et ~w~~k~~CONVERSATION_NO~ ~y~pour faire défiler les véhicules,~n~ ~w~~k~~PED_SPRINT~ ~y~pour acheter et ~w~~k~~VEHICLE_ENTER_EXIT~ ~y~pour quitter.",5);
						ShowTDComm(playerid,2);
					}
				}
				else
				{
				    HideTDComm(playerid,2);
				    DestroyVehicle(cvehicle[playerid]);
				}
			}
		}
		for(new i;i<NBATM;i++)
		{
			if(IsPlayerInRangeOfPoint(playerid,1.5,PosAtm[i][0],PosAtm[i][1],PosAtm[i][2]))
			{
				if(PlayerInfo[playerid][pCarte] == false) return SubMessage(playerid,MSG_RED,"Tu n'as pas de compte bancaire !",5);
				{
				    ApplyAnimation(playerid,"PED","ATM",4.1,0,1,1,1,1,1);
					ShowPlayerDialog(playerid,24,DIALOG_STYLE_LIST,"ATM","\t\tDéposer de l'argent\n\t\tRetirer de l'argent","Choisir","Quitter");
				}
			}
		}
		if(IsPosSkydive(playerid) != -1)
		{
		    if(IsPlayerFree(playerid))
			{
			    StartSkydive(playerid,IsPosSkydive(playerid));
			}
			else SubMessage(playerid,MSG_BLUE, "Tu es occupé !",5);
		}
		if(!IsPlayerInAnyVehicle(playerid))
		{
			new Float:x,Float:y,Float:z,object,Float:health;
			GetPlayerHealth(playerid,health);
			for(new i; i < MAX_OBJECTS ; i++)
			{
			    GetObjectPos(i,x,y,z);
			    if(IsPlayerInRangeOfPoint(playerid,2.0,x,y,z) && WeaponObject[i][Model] != 0)
			    {
			        if(health <= 0.0) return SubMessage(playerid,MSG_RED,"Vous êtes mort !",3);
			        object = i;
		        	new string[256],weapname[32];
					GetWeaponName(WeaponObject[object][Model],weapname,sizeof(weapname));
					format(string,sizeof(string),"~w~%s ~b~de ~w~%d ~b~munitions ramassé !",weapname,WeaponObject[object][Ammo]);
					SubMessage(playerid,MSG_BLUE,string,3);
					printf("[Weapon] %s ramasse un %s de %d munitions",GetName(playerid),weapname,WeaponObject[object][Ammo]);
					DestroyObject(object);
					DestroyDynamicObject(WeaponObject[object][Light]);
					GivePlayerWeapon(playerid,WeaponObject[object][Model],WeaponObject[object][Ammo]);
					WeaponObject[object][Model] = 0;
					WeaponObject[object][Ammo] = 0;
					WeaponObject[object][Light] = -1;
					ApplyAnimation(playerid,"BOMBER","BOM_Plant",4.0,0,1,1,0,0,1);
					break;
				}
			}
		}
	}
	if(newkeys == KEY_SPRINT)
	{
	    if(SelectItem[playerid] != 0)
		{
		    if(achat[playerid] == 1)
		    {
				new weaponid = ItemWeapon[page[playerid]];
				new gunname[32];
				new string[256];
				GetWeaponName(weaponid,gunname,sizeof(gunname));
			    if(PlayerInfo[playerid][pCash]<ItemPrice[page[playerid]])
			    {
			        if(PlayerInfo[playerid][pBanque]<ItemPrice[page[playerid]])
			        {
			            SubMessage(playerid,MSG_BLUE,"T'as pas assez d'argent sur ton compte pour acheter cette arme !",5);
					}
					else
					{
					    GivePlayerWeapon(playerid,weaponid,50);
					    GivePlayerBanque(playerid,-ItemPrice[page[playerid]]);
						format(string,sizeof(string),"Tu as acheté un(e) ~w~%s ~b~de 50 munitions pour ~w~$%d ~b~sur ton compte bancaire.",gunname,ItemPrice[page[playerid]]);
						SubMessage(playerid,MSG_BLUE,string,5);
						HideTDComm(playerid,1);
					}
				}
				else
				{
    				GivePlayerWeapon(playerid,weaponid,50);
				    GiveMoney(playerid,-ItemPrice[page[playerid]]);
					format(string,sizeof(string),"Tu as acheté un(e) ~w~%s de 50 munitions pour ~w~$%d ~b~en liquide.",gunname,ItemPrice[page[playerid]]);
					SubMessage(playerid,MSG_BLUE,string,5);
					HideTDComm(playerid,1);
				}
				SavePlayerWeapons(playerid);
			}
			else if(achat[playerid] == 2)
			{
				if(PlayerInfo[playerid][pCash] < ItemVPrice[page[playerid]])
				{
					if(PlayerInfo[playerid][pBanque] < ItemVPrice[page[playerid]])
					{
						SubMessage(playerid,MSG_RED,"T'as pas assez d'argent sur ton compte bancaire pour te payer ce véhicule !",5);
					}
					else
					{

						GivePlayerBanque(playerid,-ItemVPrice[page[playerid]]);

						VehicleInfo[playerid][Model] = SelectItem[playerid];
						VehicleInfo[playerid][X] = -1986.0460;
						VehicleInfo[playerid][Y] = 304.4619;
						VehicleInfo[playerid][Z] = 34.916;
						VehicleInfo[playerid][A] = 270;
						DestroyVehicle(cvehicle[playerid]);
						new INI:File = INI_Open(UserPath(playerid)), string[7];
						INI_SetTag(File,"Veh");
						INI_WriteInt(File,"PaintJob",0);
						for(new i;i< 14 ;i++)
						{
							format(string,sizeof(string),"Slot_%d",i);
							INI_WriteInt(File,string,0);
						}
						INI_WriteInt(File,"Model",VehicleInfo[playerid][Model]);
						INI_WriteFloat(File,"X1",VehicleInfo[playerid][X]);
						INI_WriteFloat(File,"Y1",VehicleInfo[playerid][Y]);
						INI_WriteFloat(File,"Z1",VehicleInfo[playerid][Z]);
						INI_WriteFloat(File,"A1",VehicleInfo[playerid][A]);
						INI_Close(File);
						INI_ParseFile(UserPath(playerid), "LoadVehicle_%s",false,true, playerid, false);
						jvehicle[playerid] = CreateVehicle(VehicleInfo[playerid][Model],VehicleInfo[playerid][X],VehicleInfo[playerid][Y],VehicleInfo[playerid][Z],VehicleInfo[playerid][A],-1,-1,-1);
						PutPlayerInVehicle(playerid,jvehicle[playerid],0);
						SetVehicleNumberPlate(jvehicle[playerid],GetName(playerid));
						SubMessage(playerid,MSG_BLUE,"Véhicule acheté avec succès avec ta carte bancaire.",5);
						SubMessage(playerid,MSG_YELLOW,"Va garer ton véhicule en dehors du parking avec /park",5);
						HideTDComm(playerid,2);
					}
				}
				else
				{
					GiveMoney(playerid,-ItemVPrice[page[playerid]]);
					VehicleInfo[playerid][Model] = SelectItem[playerid];
					VehicleInfo[playerid][X] = -1986.0460;
					VehicleInfo[playerid][Y] = 304.4619;
					VehicleInfo[playerid][Z] = 34.916;
					VehicleInfo[playerid][A] = 270;
					DestroyVehicle(cvehicle[playerid]);
					jvehicle[playerid] = CreateVehicle(VehicleInfo[playerid][Model],VehicleInfo[playerid][X],VehicleInfo[playerid][Y],VehicleInfo[playerid][Z],VehicleInfo[playerid][A],-1,-1,-1);
					PutPlayerInVehicle(playerid,jvehicle[playerid],0);
					SetVehicleNumberPlate(jvehicle[playerid],GetName(playerid));
					new INI:File = INI_Open(UserPath(playerid));
					INI_SetTag(File,"Veh");
					INI_WriteInt(File,"Model",VehicleInfo[playerid][Model]);
					INI_WriteFloat(File,"X1",VehicleInfo[playerid][X]);
					INI_WriteFloat(File,"Y1",VehicleInfo[playerid][Y]);
					INI_WriteFloat(File,"Z1",VehicleInfo[playerid][Z]);
					INI_WriteFloat(File,"A1",VehicleInfo[playerid][A]);
					INI_Close(File);
					SubMessage(playerid,MSG_BLUE,"Véhicule acheté avec succès en liquide.",5);
					SubMessage(playerid,MSG_YELLOW,"Va garer ton véhicule en dehors du parking avec /park",5);
					HideTDComm(playerid,2);
				}
			}
		}
	}
	return 1;
}

public FCNPC_OnUpdate(npcid)
{
	if(FCNPC_IsValid(bcop[braqueur[0]][0]) && GetPlayerInterior(braqueur[0]) == 0)
	{
		new Float:x, Float:y, Float:z;
		GetPlayerPos(braqueur[0], x,y,z);
		if(!IsPlayerInRangeOfPoint(bcop[braqueur[0]][0], 10.0, x,y,z))
		{
			FCNPC_GoToPlayer(bcop[braqueur[0]][0], braqueur[0], MOVE_TYPE_AUTO, MOVE_SPEED_AUTO, true, 2.0, true, 0.0, 1.5, -1);
		}
		else
		{
			FCNPC_Stop(bcop[braqueur[0]][0]);
		}
	}
	if(FCNPC_IsValid(bcop[braqueur[0]][1]) && GetPlayerInterior(braqueur[0]) == 0)
	{
		new Float:x, Float:y, Float:z;
		GetPlayerPos(braqueur[0], x,y,z);
		if(!IsPlayerInRangeOfPoint(bcop[braqueur[0]][1], 10.0, x,y,z))
		{
			FCNPC_GoToPlayer(bcop[braqueur[0]][1], braqueur[0], MOVE_TYPE_AUTO, MOVE_SPEED_AUTO, true, 10.0, true, 10.0, 10.0, -1);
		}
		else
		{
			FCNPC_Stop(bcop[braqueur[0]][1]);
		}
	}
	if(FCNPC_IsValid(bcop[braqueur[1]][2]) && GetPlayerInterior(braqueur[1]) == 0)
	{
		new Float:x, Float:y, Float:z;
		GetPlayerPos(braqueur[1], x,y,z);
		if(!IsPlayerInRangeOfPoint(bcop[braqueur[1]][2], 10.0, x,y,z))
		{
			FCNPC_GoToPlayer(bcop[braqueur[1]][2], braqueur[1], MOVE_TYPE_AUTO, MOVE_SPEED_AUTO, true, 10.0, true, 10.0, 10.0, -1);
		}
		else
		{
			FCNPC_Stop(bcop[braqueur[1]][2]);
		}
	}
	if(FCNPC_IsValid(bcop[braqueur[1]][3]) && GetPlayerInterior(braqueur[0]) == 0)
	{
		new Float:x, Float:y, Float:z;
		GetPlayerPos(braqueur[1], x,y,z);
		if(!IsPlayerInRangeOfPoint(bcop[braqueur[1]][3], 10.0, x,y,z))
		{
			FCNPC_GoToPlayer(bcop[braqueur[1]][3], braqueur[1], MOVE_TYPE_AUTO, MOVE_SPEED_AUTO, true, 10.0, true, 10.0, 10.0, -1);
		}
		else
		{
			FCNPC_Stop(bcop[braqueur[1]][3]);
		}
	}

	return 1;
}

public OnPlayerUpdate(playerid)
{
	
	if(FCNPC_IsValid(NPCInfo[playerid][NpcID]) && IsAdmin(playerid))
	{
		new npcid = NPCInfo[playerid][NpcID];
		if(FCNPC_IsAiming(npcid))
		{
			new aim = FCNPC_GetAimingPlayer(npcid);
			new Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2;
			GetPlayerPos(aim,x1,y1,z1);
			FCNPC_GetPosition(npcid,x2,y2,z2);
			new Float:dist = GetDistance(x1,y1,z1,x2,y2,z2);
			if(dist <= 10.0)
			{
				FCNPC_Stop(npcid);
				return 1;
			}
		}
		if(!IsPlayerConnected(NPCInfo[playerid][FollowID])) // THE CLOSEST PLAYER
		{
		    new Float:olddist = 9999.9,Float:newdist,focus;
		    new Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2;
			FCNPC_GetPosition(npcid,x1,y1,z1);
			for(new i; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i) && GetPlayerInterior(i) == FCNPC_GetInterior(npcid) && !IsPlayerNPC(i))
				{
				    GetPlayerPos(i,x2,y2,z2);
					newdist = GetDistance(x1,y1,z1,x2,y2,z2);
					if(newdist < olddist) focus = i;
				}
			}
			FCNPC_GoToPlayer(npcid,focus,MOVE_TYPE_AUTO,MOVE_SPEED_AUTO,true);
		}
		else FCNPC_GoToPlayer(npcid,NPCInfo[playerid][FollowID],MOVE_TYPE_AUTO,MOVE_SPEED_AUTO,true);
		
		if(!IsPlayerConnected(NPCInfo[playerid][FocusID]))
		{
  			new Float:olddist = 9999.9,Float:newdist,focus;
		    new Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2;
			FCNPC_GetPosition(npcid,x1,y1,z1);
			for(new i; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i) && GetPlayerInterior(i) == FCNPC_GetInterior(npcid) && !IsPlayerNPC(i))
				{
				    GetPlayerPos(i,x2,y2,z2);
					newdist = GetDistance(x1,y1,z1,x2,y2,z2);
					if(newdist < olddist) focus = i;
				}
			}
			FCNPC_AimAtPlayer(npcid,focus,true,TimeWeap(NPCInfo[playerid][Weap])*10);
		}
		else FCNPC_AimAtPlayer(npcid,NPCInfo[playerid][FocusID],true,TimeWeap(NPCInfo[playerid][Weap])*10);

	}
	if(skydiving[playerid] == true && GetPlayerWeapon(playerid) != 46)
	{
	    SubMessage(playerid,MSG_BLUE,"Tu as échoué ta mission skydive !",5);
	    GameTextForPlayerEx(playerid, "~r~Échec de la mission !", 5000, 0);
	    DisablePlayerCheckpointEx(playerid);
		skydiving[playerid] = false;
	}
	if(ClubTBoGT[playerid] == true)
	{
		new key,u_d,l_r;
		GetPlayerKeys(playerid,key,u_d,l_r);
		if((u_d == KEY_UP || u_d == KEY_DOWN || l_r == KEY_RIGHT || l_r == KEY_LEFT) && key == KEY_WALK)
		{
		    ApplyAnimation(playerid,"PED","WALK_gang1",4.1, 0, 1, 1, 0, 0, 1);
		}
	}
	if(GetPlayerDrunkLevel(playerid) != 0)
	{
		new key,u_d,l_r;
		GetPlayerKeys(playerid,key,u_d,l_r);
		if((u_d == KEY_UP || u_d == KEY_DOWN || l_r == KEY_RIGHT || l_r == KEY_LEFT) && key == KEY_WALK)
		{
			ApplyAnimation(playerid, "PED", "WALK_DRUNK", 4.0, 0, 1, 1, 0, 0, 1);
		}
	}

	if(IsPlayerFree(playerid))
	{
		if(IsPlayerInRangeOfPoint(playerid,4.0,PURSUIT))
		{
		    if(PlayerInfo[playerid][pLevel] >= 6)
		    {
				StartMission(playerid,101);
			}
		}

		if(IsPlayerInRangeOfPoint(playerid,2.0,POSMISSION1))
		{
		    if(mission[playerid] == 0 && PlayerInfo[playerid][pLevel] == 0)
		    {
		        RemovePlayerMapIcon(playerid,51);
				StartMission(playerid,1);
				SetPlayerCheckpoint(playerid,POSDOHERTY,1.0);
			}
		}
		if(IsPlayerInRangeOfPoint(playerid,2.0,POSDOHERTY))
		{
			if(mission[playerid] == 0 && PlayerInfo[playerid][pLevel] == 4)
		    {
		        RemovePlayerMapIcon(playerid,51);
				StartMission(playerid,5);
			}
		}
		if(IsPlayerInRangeOfPoint(playerid,2.0,POSMISSION2))
		{
		    if(mission[playerid] == 0 && PlayerInfo[playerid][pLevel] == 1)
		    {
		        RemovePlayerMapIcon(playerid,51);
				StartMission(playerid,2);
		        SetPlayerPosEx(playerid,POSINTERIOR,1,GetPlayerVirtualWorld(playerid));
				SetPlayerFacingAngle(playerid,312);
			}
		    if(mission[playerid] == 0 && PlayerInfo[playerid][pLevel] == 3)
		    {
		        RemovePlayerMapIcon(playerid,51);
				StartMission(playerid,4);
		        SetPlayerPosEx(playerid,POSINTERIOR,1,GetPlayerVirtualWorld(playerid));
				SetPlayerFacingAngle(playerid,312);
			}
		    if(mission[playerid] == 0 && PlayerInfo[playerid][pLevel] == 5)
		    {
		        RemovePlayerMapIcon(playerid,51);
				StartMission(playerid,6);
			}
		    if(mission[playerid] == 0 && PlayerInfo[playerid][pLevel] == 6)
		    {
	         	RemovePlayerMapIcon(playerid,51);
				StartMission(playerid,7);
				SetPlayerFacingAngle(playerid,312);
			}
		}
		if(IsPlayerInRangeOfPoint(playerid,2.0,POSMISSION3))
		{
		    if(mission[playerid] == 0 && PlayerInfo[playerid][pLevel] == 2)
		    {
		        RemovePlayerMapIcon(playerid,51);
				StartMission(playerid,3);
		        SetPlayerPosEx(playerid,POSINTERIOR,1,GetPlayerVirtualWorld(playerid));
				SetPlayerFacingAngle(playerid,312.0);
			}
		}
		if(IsPlayerInRangeOfPoint(playerid,3.0,POSMISSION8))
		{
		    if(mission[playerid] == 0 && PlayerInfo[playerid][pLevel] == 7)
		    {
		        RemovePlayerMapIcon(playerid,51);
				StartMission(playerid,8);
			}
		    if(mission[playerid] == 0 && PlayerInfo[playerid][pLevel] == 8)
		    {
		        RemovePlayerMapIcon(playerid,51);
				StartMission(playerid,9);
			}
		    if(mission[playerid] == 0 && PlayerInfo[playerid][pLevel] == 9)
		    {
		        RemovePlayerMapIcon(playerid,51);
				StartMission(playerid,10);
			}
		}
	}
	if(braquage == true)
	{
		if(GetPlayerTargetActor(playerid) == bactor && jbraquage[playerid] == true && role[playerid] == 0)
		{
		    if(IsValidAmmuWeapon(playerid))
		    {
				SubMessage(playerid,MSG_YELLOW,"Vous commencez à braquer la banque ! Reste comme ceci, l'arme pointée sur le banquier.",5);
				ApplyActorAnimation(bactor, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
				role[playerid] = 1;
				for(new i;i<2;i++)
				{
					if(braqueur[i] != playerid)
					{
						role[braqueur[i]] = 2;
						SubMessage(braqueur[i],MSG_YELLOW,"Ton coéquipier surveille l'entrée ! Tu dois aller dans la chambre forte pour ramasser l'argent !",5);
						SetPlayerCheckpoint(braqueur[i],1677.85,-1002.87,671.00,4.0);
					}
				}
			}
		}
		if(GetPlayerTargetActor(playerid) != bactor && role[playerid] == 1)
		{

			SubMessage(playerid,MSG_RED,"T'as pas surveillé le banquier il a appuyé sur le bouton d'alarme ! Fuyez avant que les flics n'arrivent !",5);
			for(new i;i<2;i++)
			{
				PlayAudioStream(braqueur[i], "http://xdev-team.tk/creations/sao/Audio/Drv11.mp3");
				if(braqueur[i] != playerid)
				{
					SubMessage(braqueur[i],MSG_BLUE,"~r~Ton coéquipier a tout fait foirer ! Fuyez avant que les flics n'arrivent !",5);
				}
			}
			vcop = CreateVehicle(427,-2434.5508,494.3013,30.1526,292.6494,0,1,120); //ENFORCER

			new string[MAX_PLAYER_NAME];
			format(string,sizeof(string),"BCop1_%d", braqueur[0]);
			bcop[braqueur[0]][0] = CreateNPC(string,281,-2430.0,493.0,30.0,0.0,0,WEAPON_COLT45,9999);
			FCNPC_AimAtPlayer(bcop[braqueur[0]][0], braqueur[0],true);
			FCNPC_SetWeaponInfo(bcop[braqueur[0]][0], WEAPON_COLT45, 2000, 250, 17, 0.2);

			format(string,sizeof(string),"BCop2_%d", braqueur[0]);
			bcop[braqueur[0]][1] = CreateNPC(string,281,-2431.0,492.0,30.0,0.0,0,WEAPON_COLT45,9999);
			FCNPC_AimAtPlayer(bcop[braqueur[0]][1], braqueur[0],true);
			FCNPC_SetWeaponInfo(bcop[braqueur[0]][1], WEAPON_COLT45, 2000, 250, 17, 0.2);

			format(string,sizeof(string),"BCop3_%d", braqueur[1]);
			bcop[braqueur[1]][2] = CreateNPC(string,281,-2432.0,492.0,30.0,0.0,0,WEAPON_COLT45,9999);
			FCNPC_AimAtPlayer(bcop[braqueur[1]][2], braqueur[0],true);
			FCNPC_SetWeaponInfo(bcop[braqueur[1]][2], WEAPON_COLT45, 2000, 250, 17, 0.2);

			format(string,sizeof(string),"BCop4_%d", braqueur[1]);
			bcop[braqueur[1]][3] = CreateNPC(string,281,-2433.0,492.0,30.0,0.0,0,WEAPON_COLT45,9999);
			FCNPC_AimAtPlayer(bcop[braqueur[1]][3], braqueur[0],true);
			FCNPC_SetWeaponInfo(bcop[braqueur[1]][3], WEAPON_COLT45, 2000, 250, 17, 0.2);

			for(new i;i<MAX_PLAYERS;i++)
			{
				if(IsPlayerConnected(i))
				{
					if(IsPlayerInRangeOfPoint(i,100.0,BANKINFO))
					{
						PlayerPlaySound(i,6001,BANKINFO);
					}
				}
			}
			EndBraquage();
		}
	}
	if(cbraquage[playerid] == -1)
	{
	    for(new i;i<MAX_ACTORS;i++)
	    {
		    if(IsValidActor(i))
		    {
		        if(GetPlayerTargetActor(playerid) == i)
		        {
					for(new i2;i2<TOTAL_AMMU;i2++)
					{
				        if(GetPlayerWeapon(playerid) == ItemWeapon[i2])
				        {
							new Float:x,Float:y,Float:z;
							GetActorPos(i,x,y,z);
							if(GetDistance(x,y,z,376.47,-65.25,1001.50)<10)
							{
							    if(mission[playerid] == 0)
							    {
								    if(MoneyResto[BURGER] >= 300)
								    {
										StartBraquage(playerid,BURGER);
									}
									else
									{
										GameTextForPlayerEx(playerid,"~r~Il n'y a pas assez ~n~d'argent pour pouvoir ~n~braquer ce commerce !",1500,6);
									}
								}
								else
								{
									GameTextForPlayerEx(playerid,"~r~Tu es en mission !",1500,6);
								}
							}
							else if(GetDistance(x,y,z,368.18,-4.21,1001.85)<10)
							{
							    if(mission[playerid] == 0)
							    {
								    if(MoneyResto[CLUCKIN] >= 300)
								    {
								    	StartBraquage(playerid,CLUCKIN);
									}
									else
									{
										GameTextForPlayerEx(playerid,"~r~Il n'y a pas assez ~n~d'argent pour pouvoir ~n~braquer ce commerce !",500,6);
									}
								}
								else
								{
									GameTextForPlayerEx(playerid,"~r~Tu es en mission !",1500,6);
								}
							}
							else if(GetDistance(x,y,z,374.89,-116.65,1001.49)<10)
							{
							    if(mission[playerid] == 0)
							    {
								    if(MoneyResto[PIZZA] >= 300)
								    {
								    	StartBraquage(playerid,PIZZA);
									}
									else
									{
										GameTextForPlayerEx(playerid,"~r~Il n'y a pas assez ~n~d'argent pour pouvoir ~n~braquer ce commerce !",500,6);
									}
								}
								else
								{
									GameTextForPlayerEx(playerid,"~r~Tu es en mission !",1500,6);
								}
							}
						}
					}
				}
			}
		}
	}
	return 1;
}

public OnPlayerTargetActor(playerid, newtarget, oldtarget)
{
	if(IsValidActor(newtarget) && !IsActorDead(newtarget))
	{
		ApplyActorAnimation(newtarget, "SHOP", "SHP_HandsUp_Scr",4.1,0,0,0,1,0);
		KillTimer(resetactoranim[newtarget]);
		resetactoranim[newtarget] = SetTimerEx("ResetActorAnim",5*1000,false,"i",newtarget);
	}
}

public OnPlayerGiveDamageActor(playerid, damaged_actorid, Float:amount, weaponid, bodypart)
{
	for(new i; i < MAX_ACTORS; i++) if(IsValidActor(i) && i != damaged_actorid && !IsActorDead(i)) if(IsPlayerInRangeOfActor(playerid, i, 40.0))
	{
		ApplyActorAnimation(i, "PED", "cower",4.1,0,0,0,1,0);
		KillTimer(resetactoranim[i]);
		resetactoranim[i] = SetTimerEx("ResetActorAnim",20*1000,false,"i",i);
	}
  	
    if(!IsActorDead(damaged_actorid))
    {
		if(bodypart == 3)
	    {
	        ApplyActorAnimation(damaged_actorid, "PED", "DAM_stomach_frmFT",4.1,0,0,0,0,0);
	    }
	    if(bodypart == 4)
	    {
	        ApplyActorAnimation(damaged_actorid, "PED", "DAM_stomach_frmBK",4.1,0,0,0,0,0);
	    }
	    if(bodypart == 5)
	    {
	        ApplyActorAnimation(damaged_actorid, "PED", "DAM_armL_frmFT",4.1,0,0,0,0,0);
	    }
	    if(bodypart == 6)
	    {
	        ApplyActorAnimation(damaged_actorid, "PED", "DAM_armR_frmFT",4.1,0,0,0,0,0);
	    }
	    if(bodypart == 7)
	    {
	        ApplyActorAnimation(damaged_actorid, "PED", "DAM_LegL_frmFT",4.1,0,0,0,0,0);
	    }
	    if(bodypart == 8)
	    {
	        ApplyActorAnimation(damaged_actorid, "PED", "DAM_LegR_frmFT",4.1,0,0,0,0,0);
	    }
	    if(bodypart == 9)
	    {
	        SetActorHealth(damaged_actorid, 0.0);
		    OnActorDeath(damaged_actorid,playerid,weaponid);
	    }
	    
		KillTimer(coveractor[damaged_actorid]);
		coveractor[damaged_actorid] = SetTimerEx("CoverActor",1000,false,"i",damaged_actorid);
	}
    return 1;
}

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{

	if(_:clickedid == 65535)
	{
	    if(Phone[playerid]==true) HidePhoneTD(playerid);
        if(MenuREditor[playerid] == true) HideTDRaceEditor(playerid);
        if(MenuNPC[playerid] == true) HideNPCMenu(playerid);

	}

	if(GetPVarInt(playerid, "skinc_active") == 0) return 0;

	if(clickedid == Text:INVALID_TEXT_DRAW) {
        DestroySelectionMenu(playerid);
        SetPVarInt(playerid, "skinc_active", 0);
        PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
        return 1;
	}
	return 0;
}

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
	if(playertextid == TDRace_Editor[playerid][2]) ShowPlayerDialog(playerid,41,DIALOG_STYLE_INPUT,"Nom de la course","Entrez le nouveau nom de la course :","Choisir","Quitter");
	if(playertextid == TDRace_Editor[playerid][3]) ShowPlayerDialog(playerid,42,DIALOG_STYLE_INPUT,"Véhicule pour la course","Entrez ci-dessous le nom ou id du modèle de véhicule pour la course.\nNote: Laisser vide pour faire une course à pied.","Entrer","Quitter");
	if(playertextid == TDRace_Editor[playerid][5]) ShowPlayerDialog(playerid,43,DIALOG_STYLE_INPUT,"Modifier le nombre de checkpoints","Entrez ci-dessous la valeur du nombre de CP\n{ff0000}À utiliser qu'en cas de suppression d'un checkpoint précédent !","Entrer","Quitter");
	if(playertextid == TDRace_Editor[playerid][6]) SendClientMessage(playerid,BLUE,"[ADMIN] Orientez bien votre personnage (ou véhicule) et tapez {ffffff}/angle");
	if(playertextid == TDRace_Editor[playerid][8]) HideTDRaceEditor(playerid);

	if(playertextid == TDMenu_NPC[playerid][3])
	{
		request[playerid] = 1;
		ShowPlayerDialog(playerid,48,DIALOG_STYLE_INPUT,"Skin","Entrez ci-dessous l'ID du skin à donner au NPC :","Entrer","Quitter");
	}
	if(playertextid == TDMenu_NPC[playerid][4])
	{
		new string[256],interior = GetPlayerInterior(playerid);
		format(string,sizeof(string),"[ADMIN] le npc est dans l'intérieur {ffffff}%d",interior);
		SendClientMessage(playerid,BLUE,string);
		NPCInfo[playerid][Interior] = interior;
		FCNPC_SetInterior(NPCInfo[playerid][NpcID],NPCInfo[playerid][Interior]);
		format(string,sizeof(string),"Intérieur : %d",NPCInfo[playerid][Interior]);
		ConvertEncoding(string);
		PlayerTextDrawSetString(playerid,TDMenu_NPC[playerid][4],string);
		UpdateTXD(playerid, TDMenu_NPC[playerid][4]);
	}
	if(playertextid == TDMenu_NPC[playerid][5])
	{
		new string[256],vw = GetPlayerVirtualWorld(playerid);
		format(string,sizeof(string),"[ADMIN] le NPC est dans le virtual world {ffffff}%d",vw);
		SendClientMessage(playerid,BLUE,string);
		NPCInfo[playerid][VirtualWorld] = vw;
		FCNPC_SetVirtualWorld(NPCInfo[playerid][NpcID],NPCInfo[playerid][VirtualWorld]);
		format(string,sizeof(string),"Virtual World : %d",NPCInfo[playerid][VirtualWorld]);
		ConvertEncoding(string);
		PlayerTextDrawSetString(playerid,TDMenu_NPC[playerid][5],string);
		UpdateTXD(playerid, TDMenu_NPC[playerid][5]);
	}
	if(playertextid == TDMenu_NPC[playerid][6])
	{
	    request[playerid] = 2;
	    ShowPlayerDialog(playerid,48,DIALOG_STYLE_INPUT,"Armes","Entrez ci-dessous l'ID ou le nom de l'arme à donner au NPC :","Entrer","Quitter");
 	}
 	if(playertextid == TDMenu_NPC[playerid][7])
 	{
	 	new string[16];
 	    if(NPCInfo[playerid][Invulnerable] == false)
 	    {
 	        NPCInfo[playerid][Invulnerable] = true;
			SendClientMessage(playerid,BLUE,"[ADMIN] Le NPC est maintenant {ffffff}invulnérable");
			PlayerTextDrawColor(playerid,TDMenu_NPC[playerid][7],HexToInt("FF0000FF"));
			string = "Invulnérable";
		}
		else
		{
		    NPCInfo[playerid][Invulnerable] = false;
		    SendClientMessage(playerid,BLUE,"[ADMIN] Le NPC est maintenant {ffffff}vulnérable");
		    PlayerTextDrawColor(playerid,TDMenu_NPC[playerid][7],HexToInt("008000FF"));
		    string = "Vulnérable";
		}
		ConvertEncoding(string);
		PlayerTextDrawSetString(playerid,TDMenu_NPC[playerid][7],string);
		UpdateTXD(playerid,TDMenu_NPC[playerid][7]);
		FCNPC_SetInvulnerable(NPCInfo[playerid][NpcID],NPCInfo[playerid][Invulnerable]);
	}
	if(playertextid == TDMenu_NPC[playerid][8])
	{
		request[playerid] = 3;
		ShowPlayerDialog(playerid,48,DIALOG_STYLE_LIST,"Suivre...","\t\tLe joueur le plus proche\n\t\tUn joueur en particulier","Choisir","Quitter");
	}
	if(playertextid == TDMenu_NPC[playerid][9])
	{
	    request[playerid] = 4;
	    ShowPlayerDialog(playerid,48,DIALOG_STYLE_LIST,"Viser...","\t\tLe joueur le plus proche\n\t\tUn joueur en particulier","Choisir","Quitter");
	}
	if(playertextid == TDMenu_NPC[playerid][10])
	{
	    request[playerid] = 5;
	    ShowPlayerDialog(playerid,48,DIALOG_STYLE_INPUT,"Distance de visée","Entrer ci-dessous la distance à laquelle le NPC commence à viser et tirer :","Entrer","Quitter");
	}
	if(playertextid == TDMenu_NPC[playerid][11])
	{
	    request[playerid] = 6;
	    ShowPlayerDialog(playerid,48,DIALOG_STYLE_INPUT,"Précision","Entrer ci-dessous la précision du NPC :","Entrer","Quitter");
	}
	if(playertextid == TDMenu_NPC[playerid][12])
	{
	    request[playerid] = 7;
	    ShowPlayerDialog(playerid,48,DIALOG_STYLE_INPUT,"Vie","Entrer ci-dessous la vie du NPC :","Entrer","Quitter");
	}
	if(playertextid == TD_Phone[playerid][8])
	{
		ShowDialogContacts(playerid);
	}
	if(playertextid == TD_Phone[playerid][9])
	{
		new string[256],msg[256];
		for(new i;i<MAX_PLAYERS;i++)
		{
		    if(IsPlayerConnected(i) && !IsPlayerNPC(i) && !FCNPC_IsValid(i))
		    {
		        if(i != playerid)
		        {
					format(string,sizeof(string),"\t\t[%i] %s\n",i,GetName(i));
					strcat(msg,string);
				}
			}
		}
		if(!strlen(msg)) return SubMessage(playerid,MSG_RED,"Aucun joueur n'est connecté !",5);
		{
			ShowPlayerDialog(playerid,14,DIALOG_STYLE_LIST,"Joueurs",msg,"Choisir","Quitter");
		}
	}
	if(playertextid == TD_Phone[playerid][11])
	{
	    if(PlayerInfo[playerid][pCarte]==false) return SubMessage(playerid,MSG_RED,"Tu n'as aucun compte bancaire de créé. Va à la banque pour en créer un !",5);
	    {
	        ShowPlayerDialog(playerid,19,DIALOG_STYLE_LIST,"{008000}Banque","\t\tConsulter mon compte bancaire\n\t\tEffectuer un virement\n","Ok","Quitter");
		}
	}
	if(playertextid == TD_Phone[playerid][12])
	{
	    if(gps[playerid]==true && !robbing[playerid])
    	{
			DisablePlayerCheckpointEx(playerid);
			gps[playerid]=false;
			SubMessage(playerid,MSG_BLUE,"GPS désactivé !",3);
			return 1;
		}
	    ShowPlayerDialog(playerid,23,DIALOG_STYLE_LIST,"GPS","\t\tMaison\n\t\tRestaurant le plus proche\n\t\tAmmunation le plus proche\n\t\tBar le plus proche\n\t\tATM le plus proche\n\t\tBanque\n\t\tMotel\n\t\tConcessionnaire\n\t\tMagasin de vêtements\n\t\tDépart pour Liberty-City","Aller","Quitter");
	}

	if(GetPVarInt(playerid, "skinc_active") == 0) return 0;

	new curpage = GetPVarInt(playerid, "skinc_page");

	if(playertextid == gNextButtonTextDrawId[playerid]) {
	    if(curpage < (GetNumberOfPages() - 1)) {
	        SetPVarInt(playerid, "skinc_page", curpage + 1);
	        ShowPlayerModelPreviews(playerid);
         	UpdatePageTextDraw(playerid);
         	PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
		} else {
		    PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
		}
		return 1;
	}

	if(playertextid == gPrevButtonTextDrawId[playerid]) {
	    if(curpage > 0) {
	    	SetPVarInt(playerid, "skinc_page", curpage - 1);
	    	ShowPlayerModelPreviews(playerid);
	    	UpdatePageTextDraw(playerid);
	    	PlayerPlaySound(playerid, 1084, 0.0, 0.0, 0.0);
		} else {
		    PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
		}
		return 1;
	}

	new x=0;
	while(x != SELECTION_ITEMS) {
	    if(playertextid == gSelectionItems[playerid][x]) {
	        HandlePlayerItemSelection(playerid, x);
	        PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
	        DestroySelectionMenu(playerid);
	        CancelSelectTextDraw(playerid);
        	SetPVarInt(playerid, "skinc_active", 0);
        	return 1;
		}
		x++;
	}
	return 0;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch( dialogid )
    {

        case DIALOG_REGISTER:
        {
            if (!response) return Kick(playerid);
            if(response)
            {
                if(!strlen(inputtext)) return ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_INPUT, ""DLG_WHITE"Enregistrment...",""DLG_RED"Ce mot de passe est incorrect.\n"DLG_WHITE"Entre ton mot de passe ci-dessous pour t'enregistrer.","Enregistrer","Quitter");
                new INI:File = INI_Open(UserPath(playerid));
                INI_SetTag(File,"data");
                INI_WriteInt(File,"Password",udb_hash(inputtext));
                INI_WriteInt(File,"Cash",0);
			    INI_WriteInt(File,"Num",0);
			    INI_WriteBool(File,"Tuto",false);
			    INI_WriteInt(File,"Maison",-1);
			    INI_WriteInt(File,"Banque",0);
			    INI_WriteInt(File,"CarteBancaire",0);
			    INI_WriteInt(File,"Level",0);
			    INI_WriteInt(File,"Skin",101);
				INI_WriteInt(File,"Loyer",0);
				INI_WriteInt(File,"TimeRobHouse",-1);
			    INI_SetTag(File,"Contacts");
			    INI_WriteInt(File,"Contacts",0);
			    INI_SetTag(File,"Veh");
		    	INI_WriteInt(File,"Model",0);
				INI_WriteFloat(File,"X1",0.0);
				INI_WriteFloat(File,"Y1",0.0);
				INI_WriteFloat(File,"Z1",0.0);
				INI_WriteFloat(File,"A1",0.0);
				INI_WriteInt(File,"Color1",0);
				INI_WriteInt(File,"Color2",0);
				INI_SetTag(File,"Weap");
				INI_WriteInt(File,"9mm",0);
				INI_WriteInt(File,"Silencieux",0);
				INI_WriteInt(File,"Eagle",0);
				INI_WriteInt(File,"Shotgun",0);
				INI_WriteInt(File,"Sawnoff",0);
				INI_WriteInt(File,"CombatShotgun",0);
				INI_WriteInt(File,"UZI",0);
				INI_WriteInt(File,"MP5",0);
				INI_WriteInt(File,"TEC9",0);
				INI_WriteInt(File,"AK47",0);
				INI_WriteInt(File,"M4",0);
				INI_WriteInt(File,"Sniper",0);
				INI_WriteInt(File,"Rifle",0);
				INI_SetTag(File,"Pickups");
				new string[256];
				for(new i; i < MAX_SLOTS ; i++)
				{
				    format(string,sizeof(string),"Slot_%d",i);
				    INI_WriteBool(File,string,false);
				}
                INI_Close(File);
				SetPlayerMoney(playerid, 0);
				SetPlayerLevel(playerid, 0);
				SetPlayerMoney(playerid, 0);
                ShowPlayerDialog(playerid, DIALOG_SUCCESS_1, DIALOG_STYLE_MSGBOX,""DLG_WHITE"Succès !",""DLG_GREEN"Le compte a été créé !","Ok","");
				IsLogged[playerid] = true;
			}
        }

        case DIALOG_LOGIN:
        {
            if ( !response ) return Kick ( playerid );
            if( response )
            {
                if(udb_hash(inputtext) == PlayerInfo[playerid][pPass])
                {
					new msg[2048];
					msg = DLG_GREEN"Tu t'es connecté avec succès !\n";
					strcat(msg,"Pour avoir des informations sur le serveur, n'hésitez pas à utiliser {ffffff}/infos"DLG_GREEN" ou {ffffff}contacter un admin.\n");
					strcat(msg,DLG_GREEN"Nous vous prions de ne pas oublier que le serveur est actuellement en "DLG_RED"BETA"DLG_GREEN" et que par conséquent,\n");
					strcat(msg,"la machine hébergeant le serveur peut être "DLG_RED"peu performante"DLG_GREEN", le serveur peut contenir des "DLG_RED"bugs"DLG_GREEN"\n");
					strcat(msg,"et autres que nous vous prions de poster sur le "DLG_RED"forum: sanandreasonline.forumactif.com\n");
					strcat(msg,DLG_GREEN"Si toutefois vous souhaitez changer de mot de passe, il vous suffit d'entrer "DLG_RED"/changepass\n");
					if(IsAdmin(playerid)) strcat(msg,DLG_GREEN"Vous pouvez également consulter vos commandes admins en utilisant {ffffff}/acmds\n\n");
					strcat(msg,DLG_GREEN"\t\tBon jeu !");
					ShowPlayerDialog(playerid, DIALOG_SUCCESS_2, DIALOG_STYLE_MSGBOX,""DLG_WHITE"Succès !",msg,"Ok","");
					IsLogged[playerid] = true;
					SetPlayerSkin(playerid,PlayerInfo[playerid][pSkin]);
					SetPlayerScore(playerid,PlayerInfo[playerid][pLevel]);
					SetPlayerWantedLevel(playerid,PlayerInfo[playerid][pEtoiles]);

    				if(PlayerInfo[playerid][pBan] == true)
					{
				 		new ip[32],string[256];
					    GetPlayerIp(playerid,ip,sizeof(ip));
					    format(string,sizeof(string),"[ADMIN] {ffffff}%s {0080C0}a été banni pour {ffffff}ban evade",GetName(playerid));
					    SendClientMessageToAll(BLUE,string);
						BanEx(playerid,"Ban Evade");
	        			printf("[ADMIN] Serveur a banni %s | Raison : Ban Evade",GetName(playerid));
					    new year,month,day;
					    getdate(year,month,day);
					    new hours,minutes,second;
					    gettime(hours,minutes,second);
					    format(string,sizeof(string),"[%02d/%02d/%02d - %02d:%02d:%02d] %s (%s) a été banni | Raison : Ban Evade\r\n",day,month,year,hours,minutes,second,GetName(playerid),ip);
					    WriteSanctionFile(string);
					}
				}
                else
                {
                    ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_INPUT,""DLG_WHITE"Connexion",""DLG_RED"Ce mot de passe est incorrect.\n"DLG_WHITE"Tapes ton mot de passe ci-dessous pour te connecter.","Connexion","Quitter");
                }
                return 1;
            }
        }
		case DIALOG_SUCCESS_1,DIALOG_SUCCESS_2:
		{
			SpawnPlayerEx(playerid);
			if(PlayerInfo[playerid][pTuto] == false)
			{
			    PlayAudioStream(playerid, "http://xdev-team.tk/creations/sao/Audio/Drv16.mp3");
				ShowPlayerDialog(playerid, 25, DIALOG_STYLE_MSGBOX,""DLG_WHITE"Tutoriel",""DLG_WHITE"Bienvenue sur San Andreas Online ! Ce serveur reprend les idées de base de GTA Online et les a remasterisées et adaptées pour GTA San Andreas !\n Ici, tu peux obtenir un logement, une voiture, un téléphone, un compte bancaire et tout cela\n bien évidemment grâce à l'argent de divers braquages de commerces, de la banque de San Fierro, des missions, des gens dans la rue et diverses activités.","Ok","");
			}
		}

		//CONTACTS SETTINGS
		case 6:
		{
			if(response)
			{
				if(listitem==0)
				{
					ShowPlayerDialog(playerid,7,DIALOG_STYLE_INPUT,"Nom du Contact","Entre ci-dessous le nom que tu veux donner à ton nouveau contact:","Entrer","Quitter");
				}
				else if(listitem>-1)
				{
					new string[256];
					selectid[playerid]=listitem;
					format(string,sizeof(string),"%s - %d",NameContact[playerid][listitem-1],NumContact[playerid][listitem-1]);
					ShowPlayerDialog(playerid,9,DIALOG_STYLE_LIST,string,"{008000}\t\tAppeler\n\t\t{2F2FFF}Modifier le contact","Choisir","Retour");
				}
			}
		}
		case 7:
		{
			if(response)
			{
				new string[100],msg[256],name[MAX_PLAYER_NAME];
				format(name,sizeof(name),"%s",inputtext);
				cname[playerid] = name;
				format(string,sizeof(string),"[Phone] Nom du nouveau contact: %s ",cname[playerid]);
				SendClientMessage(playerid,BLUE,string);
				format(string,sizeof(string),"NUMERO DE %s",cname[playerid]);
				format(msg,sizeof(msg),"Quel est le numéro de %s ?",cname[playerid]);
				ShowPlayerDialog(playerid,8,DIALOG_STYLE_INPUT,string,msg,"Entrer","Quitter");
			}
		}
		//ADD A CONTACT
		case 8:
		{
			if(response)
			{
				new string[256],num,index,INI:File = INI_Open(UserPath(playerid));
				num = strval(inputtext);
				PlayerInfo[playerid][pContacts]++;
				index = PlayerInfo[playerid][pContacts] -1;
				NameContact[playerid][index] = cname[playerid];
				NumContact[playerid][index] = num;
				format(string,sizeof(string),"[Phone] Contact ajouté: %s - %d",NameContact[playerid][index],NumContact[playerid][index]);
				SendClientMessage(playerid,BLUE,string);
				INI_SetTag(File,"Contacts");
				format(string,sizeof(string),"Contact%d",PlayerInfo[playerid][pContacts]);
				INI_WriteString(File,string,NameContact[playerid][index]);
				format(string,sizeof(string),"Num%d",PlayerInfo[playerid][pContacts]);
				INI_WriteInt(File,string,NumContact[playerid][index]);
				INI_WriteInt(File,"Contacts",PlayerInfo[playerid][pContacts]);
				INI_Close(File);
			}
		}
		//SHOW CONTACTS
		case 9:
		{
			if(!response) return ShowDialogContacts(playerid);
			{
				switch(listitem)
				{
					case 0: CallPlayer(playerid,NumContact[playerid][selectid[playerid]-1]);
					case 1:	ShowPlayerDialog(playerid,10,DIALOG_STYLE_LIST,"Modifier...","\t\tNom\n\t\tNuméro","Modifier","Retour");
				}
			}
		}
		//CONTACTS SETTINGS
		case 10:
		{
			new string[128];
			format(string,sizeof(string),"%s - %d",NameContact[playerid][selectid[playerid]],NumContact[playerid][selectid[playerid]]);
			if(!response) return ShowPlayerDialog(playerid,9,DIALOG_STYLE_LIST,string,"{008000}\t\tAppeler\n\t\t{FDFD00}Envoyer un SMS\n\t\t{2F2FFF}Modifier le contact","Choisir","Retour");
			{
				if(listitem==0)
				{
					ShowPlayerDialog(playerid,11,DIALOG_STYLE_INPUT,"Nouveau nom","Entre le nouveau nom de ton contact :","Modifier","Quitter");
				}
				if(listitem==1)
				{
					ShowPlayerDialog(playerid,12,DIALOG_STYLE_INPUT,"Nouveau numéro","Entre le nouveau numéro de ton contact :","Modifier","Quitter");
				}
			}
		}
		//CONTACT LIST
		case 11:
		{
			if(response)
			{
				new string[MAX_PLAYER_NAME],str[128],INI:File = INI_Open(UserPath(playerid));
				format(string,sizeof(string),"%s",inputtext);
				NameContact[playerid][selectid[playerid]-1] = string;
				format(string,sizeof(string),"Contact%d",selectid[playerid]);
				INI_SetTag(File,"Contacts");
				INI_WriteString(File,string,NameContact[playerid][selectid[playerid]-1]);
				INI_Close(File);
				format(str,sizeof(str),"[Phone] Nouveau contact: %s",NameContact[playerid][selectid[playerid]-1]);
				SendClientMessage(playerid,BLUE,str);
			}
		}
		case 12:
		{
			if(response)
			{
				new string[30],str[128],INI:File = INI_Open(UserPath(playerid));
				format(string,sizeof(string),"%s",inputtext);
				NumContact[playerid][selectid[playerid]-1] = strval(inputtext);
				format(string,sizeof(string),"Num%d",selectid[playerid]);
				INI_SetTag(File,"Contacts");
				INI_WriteInt(File,string,NumContact[playerid][selectid[playerid]-1]);
				INI_Close(File);
				format(str,sizeof(str),"[Phone] Nouveau numéro de %s: %d",NameContact[playerid][selectid[playerid]-1],NumContact[playerid][selectid[playerid]-1]);
				SendClientMessage(playerid,BLUE,str);
			}
		}
		case 13:
		{
			if(response)
			{
				if(!IsPlayerConnected(braqueur[0]))
				{
					SubMessage(playerid,MSG_RED,"Ton coéquipier s'est déconnecté !",5);
					braquage = false;
					jbraquage[playerid] = false;
				}
				SubMessage(playerid,MSG_YELLOW,"Tu acceptes le braquage. Va à la banque marquée par un checkpoint sur ta map.",5);
				SubMessage(braqueur[0],MSG_YELLOW,"Le braqueur a accepté. Il t'attendra à la banque marquée par un checkpoint sur ta map.",5);
				PlayAudioStream(playerid, "http://xdev-team.tk/creations/sao/Audio/Drv8.mp3");
				PlayAudioStream(braqueur[0], "http://xdev-team.tk/creations/sao/Audio/Drv8.mp3");
				SetPlayerCheckpoint(playerid,BANKENTER,5.0);
				SetPlayerCheckpoint(braqueur[0],BANKENTER,5.0);
			}
			else
			{
				braquage = false;
				jbraquage[braqueur[0]] = false;
				jbraquage[braqueur[1]] = false;
				SubMessage(playerid,MSG_RED,"Tu as refusé le braquage.",5);
				SubMessage(braqueur[0],MSG_BLUE,"~r~Le joueur a refusé le braquage !",5);
			}
		}
		case 14:
		{
		    if(response)
		    {
				new name[MAX_PLAYER_NAME],string[256];
				if(listitem < playerid)
				{
					SmsId[playerid] = listitem;
				}
				else if(listitem + 1 > playerid)
				{
				    SmsId[playerid] = listitem + 1;
				}
				name = GetName(SmsId[playerid]);
				format(string,sizeof(string),"SMS à %s",name);
				ShowPlayerDialog(playerid,15,DIALOG_STYLE_INPUT,string,"Entre ci-dessous le SMS :","Envoyer","Quitter");
			}
		}
		//WRITE A SMS
		case 15:
		{
			if(response)
			{
				new string[256];
				format(string,sizeof(string),"[SMS] Reçu de %s: %s",GetName(playerid),inputtext);
				SendClientMessage(SmsId[playerid],YELLOW,string);
				format(string,sizeof(string),"[SMS] Envoyé à %s: %s",GetName(SmsId[playerid]),inputtext);
				SendClientMessage(playerid,LIGHTBLUE,string);
				format(string,sizeof(string),"[SMS] PM de {ffffff}%s {0080C0}à {ffffff}%s {0080C0}: {ffffff}%s",GetName(playerid),GetName(SmsId[playerid]),inputtext);
				for(new i; i < MAX_PLAYERS; i++)
				{
				    if(IsPlayerConnected(i) && IsAdmin(i) && vcmds[i] == true) SendClientMessage(i,BLUE,string);
				}
				printf("[SMS] %s à %s : %s",GetName(playerid),GetName(SmsId[playerid]),inputtext);
			}
		}
		//BUILDING CREATING SETTINGS
		case 17:
		{
			if(response)
			{
				new str[64],result;
				selectid[playerid]=strval(inputtext);
				switch(deftype[playerid])
				{
					case 1 :
					{
						if(strlen(inputtext)==0)
						{
							for(new i;i<MAX_HOUSES;i++)
							{
								if(HouseInfo[i][Type]==0)
								{
									if(i!=0)
									{
										result++;
										if(result==1)
										{
											selectid[playerid]=i;
											break;
										}
									}
								}
							}
							format(str,sizeof(str),"Maison '%d'",selectid[playerid]);
							ShowPlayerDialog(playerid,18,DIALOG_STYLE_LIST,str,"\t\tDéfinir emplacement\n\t\tDéfinir intérieur\n\t\tMettre en vente\n\t\tDéfinir Prix\n\t\tVerrouiller/Déverrouiller\n\t\tEmplacement cambriolage","Choisir","Quitter");

						}
						else if(!fexist(HousePath(selectid[playerid])) || selectid[playerid]==0) return SubMessage(playerid,MSG_RED,"L'ID de la maison est invalide !",5);
						{
							format(str,sizeof(str),"Maison '%d'",selectid[playerid]);
							ShowPlayerDialog(playerid,18,DIALOG_STYLE_LIST,str,"\t\tDéfinir emplacement\n\t\tDéfinir intérieur\n\t\tMettre en vente\n\t\tDéfinir Prix\n\t\tVerrouiller/Déverrouiller\n\t\tEmplacement cambriolage\n","Choisir","Quitter");
						}
					}
					case 2 :
					{
						if(strlen(inputtext)==0)
						{
							for(new i;i<MAX_COMMERCES;i++)
							{
								if(CommerceInfo[i][Type]==0)
								{
									if(i!=0)
									{
										result++;
										if(result==1)
										{
											selectid[playerid]=i;
											break;
										}
									}
								}
							}
							format(str,sizeof(str),"Commerce '%d'",selectid[playerid]);
							ShowPlayerDialog(playerid,18,DIALOG_STYLE_LIST,str,"\t\tDéfinir emplacement\n\t\tDéfinir intérieur\n\t\tCréer","Choisir","Quitter");

						}
						else if(!fexist(CommercePath(selectid[playerid])) || selectid[playerid]==0) return SubMessage(playerid,MSG_RED,"L'ID du commerce est invalide !",5);
						{
							format(str,sizeof(str),"Commerce '%d'",selectid[playerid]);
							ShowPlayerDialog(playerid,18,DIALOG_STYLE_LIST,str,"\t\tDéfinir emplacement\n\t\tDéfinir intérieur\n\t\tCréer","Choisir","Quitter");
						}
					}
					case 3:
					{
						if(strlen(inputtext)==0)
						{
							for(new i;i<MAX_BIZ;i++)
							{
								if(BizInfo[i][Type]==0)
								{
									if(i!=0)
									{
										result++;
										if(result==1)
										{
											selectid[playerid]=i;
											break;
										}
									}
								}
							}
							format(str,sizeof(str),"Propriété '%d'",selectid[playerid]);
							ShowPlayerDialog(playerid,18,DIALOG_STYLE_LIST,str,"\t\tDéfinir emplacement\n\t\tDéfinir Caisse Max.\n\t\tDéfinir Revenus\n\t\tDéfinir Prix d'achat\n\t\tMettre en vente","Choisir","Quitter");

						}
						else if(!fexist(CommercePath(selectid[playerid])) || selectid[playerid]==0) return SubMessage(playerid,MSG_RED,"L'ID du commerce est invalide !",5);
						{
							format(str,sizeof(str),"Propriété '%d'",selectid[playerid]);
							ShowPlayerDialog(playerid,18,DIALOG_STYLE_LIST,str,"\t\tDéfinir emplacement\n\t\tDéfinir Caisse Max.\n\t\tDéfinir Revenus\n\t\tDéfinir Prix d'achat\n\t\tMettre en vente","Choisir","Quitter");
						}
					}
				}
			}
		}
		// RESPONSE TO ITEMS HOUSE CREATING SETTINGS
		case 18:
		{
			if(response)
			{
				new string[256];
				if(deftype[playerid]==1)
				{
					switch(listitem)
					{

							case 0:
							{
								SendClientMessage(playerid,BLUE,"[ADMIN] Tu définis l'emplacement de la maison. Va à l'emplacement exact et tapes /emp.");
								Edit[playerid]=1;
							}
							case 1:
							{
								SendClientMessage(playerid,BLUE,"[ADMIN] Tu définis l'intérieur de la maison. Va à l'emplacement exact et tapes /emp.");
								Edit[playerid]=2;
							}
							case 2:
							{
								if(HouseInfo[selectid[playerid]][Type] == 2)
								{
									new id = ReturnUser(proprio[selectid[playerid]]);
									if(IsPlayerConnected(id))
									{
										SendClientMessage(id,BLUE,"[ADMIN] L'Admin a fait vendre ta maison. Tu récupères l'argent.");
										GiveMoney(id,HouseInfo[selectid[playerid]][Prix]);
										PlayerInfo[playerid][pMaison] = -1;
									}
									new INI:File;
									format(string,sizeof(string),PATH,proprio[selectid[playerid]]);
									File = INI_Open(string);
									INI_SetTag(File,"data");
									INI_WriteInt(File,"Maison",-1);
									INI_Close(File);
								}
								HouseInfo[selectid[playerid]][Type]=1;
								DestroyDynamicPickup(housepickup[selectid[playerid]][0]);
								housepickup[selectid[playerid]][0] = CreateDynamicPickup(1273,1,HouseInfo[selectid[playerid]][X1],HouseInfo[selectid[playerid]][Y1],HouseInfo[selectid[playerid]][Z1]);
								RemovePlayerMapIcon(playerid,selectid[playerid]);
								for(new i;i<MAX_PLAYERS;i++)
								{
									if(IsPlayerConnected(i))
									{
										SetPlayerMapIcon(i,selectid[playerid],HouseInfo[selectid[playerid]][X1],HouseInfo[selectid[playerid]][Y1],HouseInfo[selectid[playerid]][Z1],31,0,MAPICON_LOCAL);
									}
								}
								format(string,sizeof(string),"[ADMIN] La maison '%d' a été mise en vente, les joueurs pourront maintenant l'acheter.",selectid[playerid]);
								SendClientMessage(playerid,BLUE,string);
								proprio[selectid[playerid]] = "";
								SaveHouse(selectid[playerid]);
							}
							case 3:
							{
								SendClientMessage(playerid,BLUE,"[ADMIN] Entre dans le chat le prix de la maison.");
								Edit[playerid]=3;
							}
							case 4:
							{
								if(HouseInfo[selectid[playerid]][Lock]==0)
								{
									LockHouse(playerid,selectid[playerid]);
								}
								else
								{
									UnlockHouse(playerid,selectid[playerid]);
								}
								SaveHouse(selectid[playerid]);
							}
							case 5:
							{
							    Edit[playerid] = 4;
							    SendClientMessage(playerid,BLUE,"[ADMIN] Tu définis l'emplacement de cambriolage pour cette maison. Va à l'emplacement et tapes /emp");
							}
						}
					}
				else if(deftype[playerid]==2)
				{
					switch(listitem)
					{
						case 0:
						{
							SendClientMessage(playerid,BLUE,"[ADMIN] Tu définis l'emplacement du commerce . Va à l'emplacement exact et tapes /emp.");
							Edit[playerid]=1;
						}
						case 1:
						{
							SendClientMessage(playerid,BLUE,"[ADMIN] Tu définis l'intérieur du commerce . Va à l'emplacement exact et tapes /emp.");
							Edit[playerid]=2;
						}
						case 2:
						{
							if(CommerceInfo[selectid[playerid]][Type]!=0) return SubMessage(playerid,MSG_RED,"Ce commerce est déjà en service !",5);
							{
								CommerceInfo[selectid[playerid]][Type]=1;
								format(string,sizeof(string),"[ADMIN] Commerce '%d' crée !",selectid[playerid]);
								SendClientMessage(playerid,BLUE,string);
								DestroyDynamicPickup(commpickup[selectid[playerid]][0]);
								commpickup[selectid[playerid]][0] = CreateDynamicPickup(PICKCENTER,1,CommerceInfo[selectid[playerid]][X1],CommerceInfo[selectid[playerid]][Y1],CommerceInfo[selectid[playerid]][Z1]);
								SaveCommerce(selectid[playerid]);
							}
						}
					}
				}
				else if(deftype[playerid]==3)
				{
					switch(listitem)
					{
						case 0:
						{
							SendClientMessage(playerid,BLUE,"[ADMIN] Tu définis l'emplacement de la propriété . Va à l'emplacement exact et tapes /emp.");
							Edit[playerid]=1;
						}
						case 1:
						{
							SendClientMessage(playerid,BLUE,"[ADMIN] Entre dans le chat le montant maximum que peut atteindre la caisse.");
							Edit[playerid] = 5;
						}
						case 2:
						{
	                        SendClientMessage(playerid,BLUE,"[ADMIN] Entre dans le chat le revenu par heure de la propriété.");
	                        Edit[playerid] = 6;
						}
						case 3:
						{
						    SendClientMessage(playerid,BLUE,"[ADMIN] Entre dans le chat le prix d'achat de la propriété.");
						    Edit[playerid] = 3;
						}
						case 4:
						{
							if(BizInfo[selectid[playerid]][Type] == 2)
							{
								new id = ReturnUser(bproprio[selectid[playerid]]);
								if(IsPlayerConnected(id))
								{
									SendClientMessage(id,BLUE,"[ADMIN] L'Admin a fait vendre ta propriété. Tu récupères l'argent.");
									GiveMoney(id,BizInfo[selectid[playerid]][Prix]);
									PlayerInfo[playerid][pBiz] = -1;
								}
								new INI:File;
								format(string,sizeof(string),PATH,bproprio[selectid[playerid]]);
								File = INI_Open(string);
								INI_SetTag(File,"data");
								INI_WriteInt(File,"Biz",-1);
								INI_Close(File);
							}
							DestroyDynamicPickup(BizPickup[selectid[playerid]]);
							BizPickup[selectid[playerid]] = CreateDynamicPickup(1274,1,BizInfo[selectid[playerid]][X],BizInfo[selectid[playerid]][Y],BizInfo[selectid[playerid]][Z]);
							BizInfo[selectid[playerid]][Type]=1;
							format(string,sizeof(string),"[ADMIN] La propriété '%d' a été mise en vente, les joueurs pourront maintenant l'acheter.",selectid[playerid]);
							SendClientMessage(playerid,BLUE,string);
							format(bproprio[selectid[playerid]],MAX_PLAYER_NAME,"");
							SaveBiz(selectid[playerid]);
						}
					}
				}
			}
		}
		// DIALOG PHONE TD BANK
		case 19:
		{
			if(response)
			{
				new string[256];
				if(listitem==0)
				{
					format(string,sizeof(string),"Montant d'argent sur ton compte: {ffffff}$%d",PlayerInfo[playerid][pBanque]);
					ShowPlayerDialog(playerid,21,DIALOG_STYLE_MSGBOX,"{008000}Compte Bancaire",string,"Ok","Quitter");
				}
				if(listitem==1)
				{
					ShowPlayerDialog(playerid,22,DIALOG_STYLE_INPUT,"Virement","Entre le pseudo du titulaire du compte bancaire :","Entrer","Quitter");
				}
			}
		}
		// DIALOG BANK OPERATIONS
		case 20:
		{
			if(response)
			{	new string[256];
				switch(listitem)
				{
					case 0:
					{
						if(PlayerInfo[playerid][pCarte]==false)
						{
							if(PlayerInfo[playerid][pCash]<500) return SubMessage(playerid,MSG_RED,"Tu n'as pas assez d'argent pour acheter une carte bancaire.",5);
							{
								GiveMoney(playerid,-500);
								SubMessage(playerid,MSG_BLUE,"Tu as maintenant une carte bancaire, tu pourra désormais effectuer des opérations à la banque.",5);
								PlayerInfo[playerid][pCarte]=true;
								GiveMoneyBanque(500);
							}
						}
						else
						{
							SubMessage(playerid,MSG_BLUE,"Tu viens de résilier ton contrat avec la banque, tu perds donc ta carte bancaire.",5);
							PlayerInfo[playerid][pCarte]=false;
						}
						new INI:File = INI_Open(UserPath(playerid));
						INI_SetTag(File,"data");
						INI_WriteBool(File,"CarteBancaire",PlayerInfo[playerid][pCarte]);
						INI_Close(File);
					}
					case 1:
					{
						format(string,sizeof(string),"Entre dans le chat le montant d'argent que tu veux déposer sur ton compte. Montant actuel du compte: ~w~$%d",PlayerInfo[playerid][pBanque]);
						SubMessage(playerid,MSG_YELLOW,string, 10);
						Edit[playerid]=-1;
					}
					case 2:
					{
						format(string,sizeof(string),"Entre dans le chat le montant d'argent que tu veux retirer de ton compte. Montant actuel du compte: ~w~$%d",PlayerInfo[playerid][pBanque]);
						SubMessage(playerid,MSG_YELLOW,string, 10);
						Edit[playerid]=-2;
					}
				}
			}
		}
		// AMOUNT OF MONEY TRANSFERT
		case 22:
		{
			if(response)
			{
				new name[MAX_PLAYER_NAME],string[256];
				format(string,sizeof(string),PATH,inputtext);
				if(!fexist(string))
				{
					SubMessage(playerid,MSG_BLUE,"Nom invalide !",5);
					ShowPlayerDialog(playerid,22,DIALOG_STYLE_INPUT,"Virement","Entre le pseudo du titulaire du compte bancaire :","Entrer","Quitter");
					return 1;
    			}
				SubMessage(playerid,MSG_BLUE,"Entre dans le chat le montant de ton virement.",5);
				format(name,sizeof(name),"%s",inputtext);
				namesave[playerid] = name;
				Edit[playerid]=-3;
			}
		}
		// GPS
		case 23:
		{
			if(response)
			{
				switch(listitem)
				{
					case 0:
					{
						if(PlayerInfo[playerid][pMaison]<1) return SubMessage(playerid,MSG_RED,"Tu n'as aucune maison !",5);
						{
							new string[256];
							new id = PlayerInfo[playerid][pMaison];
							format(string,sizeof(string),"Ta maison a été marquée sur ta mini-carte.~n~Distance: %0.2f mètres",GetPlayerDistanceFromPoint(playerid,HouseInfo[id][X1],HouseInfo[id][Y1],HouseInfo[id][Z1]));
							SubMessage(playerid,MSG_BLUE,string,5);
							SetPlayerCheckpoint(playerid,HouseInfo[id][X1],HouseInfo[id][Y1],HouseInfo[id][Z1],5.0);
						}
					}
					case 1:
					{
						new string[256];
						new id = GetClosestResto(playerid);
						format(string,sizeof(string),"Le restaurant le plus proche est marqué sur ta mini-carte.~n~Distance: %0.2f mètres",GetPlayerDistanceFromPoint(playerid,PosRestos[id][0],PosRestos[id][1],PosRestos[id][2]));
						SubMessage(playerid,MSG_BLUE,string,5);
						SetPlayerCheckpoint(playerid,PosRestos[id][0],PosRestos[id][1],PosRestos[id][2],5.0);
					}
					case 2:
					{
						new string[256];
						new id = GetClosestAmmu(playerid);
						format(string,sizeof(string),"L'ammunation le plus proche est marqué sur ta mini-carte.~n~Distance: %0.2f mètres",GetPlayerDistanceFromPoint(playerid,PosAmmu[id][0],PosAmmu[id][1],PosAmmu[id][2]));
						SubMessage(playerid,MSG_BLUE,string,5);
						SetPlayerCheckpoint(playerid,PosAmmu[id][0],PosAmmu[id][1],PosAmmu[id][2],5.0);
					}

					case 3:
					{
						new string[256];
						new id = GetClosestBar(playerid);
						format(string,sizeof(string),"Le bar le plus proche est marqué sur ta mini-carte.~n~Distance: %0.2f mètres",GetPlayerDistanceFromPoint(playerid,PosBar[id][0],PosBar[id][1],PosBar[id][2]));
						SubMessage(playerid,MSG_BLUE,string,5);
						SetPlayerCheckpoint(playerid,PosBar[id][0],PosBar[id][1],PosBar[id][2],5.0);
					}
					case 4:
					{
						new string[256];
						new id = GetClosestAtm(playerid);
						format(string,sizeof(string),"L'ATM le plus proche est marqué sur ta mini-carte.~n~Distance: %0.2f mètres",GetPlayerDistanceFromPoint(playerid,PosAtm[id][0],PosAtm[id][1],PosAtm[id][2]));
						SubMessage(playerid,MSG_BLUE,string,5);
						SetPlayerCheckpoint(playerid,PosAtm[id][0],PosAtm[id][1],PosAtm[id][2],5.0);
					}
					case 5:
					{
						new string[256];
						format(string,sizeof(string),"La banque a été marquée sur ta mini-carte.~n~Distance: %0.2f mètres",GetPlayerDistanceFromPoint(playerid,BANKENTER));
						SubMessage(playerid,MSG_BLUE,string,5);
						SetPlayerCheckpoint(playerid,BANKENTER,5.0);
					}
					case 6:
					{
						new string[256];
						format(string,sizeof(string),"Le Motel a été marqué sur ta mini-carte.~n~Distance: %0.2f mètres",GetPlayerDistanceFromPoint(playerid,HOTELENTER));
						SubMessage(playerid,MSG_BLUE,string,5);
						SetPlayerCheckpoint(playerid,HOTELENTER,5.0);
					}
					case 7:
					{
						new string[256];
						format(string,sizeof(string),"Le Concessionnaire a été marqué sur ta mini-carte.~n~Distance: %0.2f mètres",GetPlayerDistanceFromPoint(playerid,-1952.00, 270.00, 35.00));
						SubMessage(playerid,MSG_BLUE,string,5);
						SetPlayerCheckpoint(playerid,-1952.00, 270.00, 35.00,5.0);
					}
					case 8:
					{
						new string[256];
						format(string,sizeof(string),"Le Magasin de vêtements a été marqué sur ta mini-carte. Distance: %0.2f mètres",GetPlayerDistanceFromPoint(playerid,-1883.0,866.0,35.0));
						SubMessage(playerid,MSG_BLUE,string,5);
						SetPlayerCheckpoint(playerid,-1883.0,866.0,35.0,5.0);
					}
					case 9:
					{
						new string[256];
						format(string,sizeof(string),"Le Départ pour Liberty City a été marqué sur ta mini-carte. Distance: %0.2f mètres",GetPlayerDistanceFromPoint(playerid,ALCITY));
						SubMessage(playerid,MSG_BLUE,string,5);
						SetPlayerCheckpoint(playerid,ALCITY,5.0);
					}
				}
				gps[playerid]=true;
			}
		}
		//DIALOG ATM
		case 24:
		{
			if(response)
			{
				if(listitem==0)
				{
					SubMessage(playerid,MSG_BLUE,"Entre dans le chat le montant d'argent que tu souhaites déposer sur ton compte !",5);
					Edit[playerid] = -1;
				}
				if(listitem == 1)
				{
					SubMessage(playerid,MSG_BLUE,"Entre dans le chat le montant d'argent que tu souhaites retirer de ton compte !",5);
					Edit[playerid]= -2;
				}
			}
		}
		case 25:
		{
			{
				SetPlayerCameraPos(playerid, -2150.0,143.0,38.0);
				SetPlayerCameraLookAt(playerid, HOTELENTER, CAMERA_CUT);
				SetPlayerPos(playerid, -2155.0,145.0,38.0);
				ShowPlayerDialog(playerid, 26, DIALOG_STYLE_MSGBOX,""DLG_WHITE"Tutoriel",""DLG_WHITE"Tu apparais au motel de San Fierro, tu payes donc un loyer de 300$/heure mais tu ne pourras jamais aller en dessous de $0.\n Pour n'importe quel pickup (icône qui tourne), appuies sur F ou Enter pour interagir avec (sauf actions spéciales avec Y et N). (Ici, entrer et sortir du motel)","Ok","");
			}
		}
		case 26:
		{
			{
				SetPlayerCameraPos(playerid, -2007.0,905.0,49.0);
				SetPlayerCameraLookAt(playerid, -2014.0,897.3,45.5, CAMERA_CUT);
				SetPlayerPos(playerid, -2007.0,905.0,45.0);
				ShowPlayerDialog(playerid, 27, DIALOG_STYLE_MSGBOX,""DLG_WHITE"Tutoriel",""DLG_WHITE"Voici un exemple de logement. Son icône sur la map et son pickup seront verts si elle est libre, sinon, ils seront rouges. \nPour acheter une maison, /buyhouse sur le pickup et la vendre (pour le même prix), /sellhouse.\nCela permet de ne pas payer de loyer ou de taxes bancaires.","Ok","");
			}
		}
		case 27:
		{
			{
				SetPlayerCameraPos(playerid, -2641.0,217.0,10.0);
				SetPlayerCameraLookAt(playerid, -2627.0,210.0,5.0, CAMERA_CUT);
				SetPlayerPos(playerid, -2641.0,217.0,5.0);
				ShowPlayerDialog(playerid, 28, DIALOG_STYLE_MSGBOX,""DLG_WHITE"Tutoriel",""DLG_WHITE"Voici un Ammu-Nation, tu peux y acheter des armes à feu basiques, Pistolets, Mitraillette, Fusils d'assauts, Uzi, Tec-9, Fusils, Snipers etc... \nMais pas d'armes lourdes comme les Miniguns, les RPG, Bazookas et autres qui seront probablement donnés lors d'events. Tu peux pas braquer ce commerce car il est trop sécurisé.","Ok","");
			}
		}
		case 28:
		{
			{
				SetPlayerCameraPos(playerid, -2203.0,729.0,52.0);
				SetPlayerCameraLookAt(playerid, -2214.0,721.3,49.5, CAMERA_CUT);
				SetPlayerPos(playerid, -2200.0,735.0,49.5);
				ShowPlayerDialog(playerid, 29, DIALOG_STYLE_MSGBOX,""DLG_WHITE"Tutoriel",""DLG_WHITE"Voici un exemple de bar ou restaurant, il te donne la nausée ou régénère toute ta vie pour 20$.\nTous les restaurants ont les icônes correspondantes à leur type (Poulet, Burger, Pizza) sur la map.\nTu peux les braquer pour obtenir l'argent qu'ils ont engendré en visant le caissier.","Ok","");
			}
		}
		case 29:
		{
			{
				SetPlayerCameraPos(playerid, -2424.0,491.0,35.0);
				SetPlayerCameraLookAt(playerid, BANKENTER, CAMERA_CUT);
				SetPlayerPos(playerid, -2424.0,491.0,30.0);
				ShowPlayerDialog(playerid, 30, DIALOG_STYLE_MSGBOX,""DLG_WHITE"Tutoriel",""DLG_WHITE"Voici la banque de San Fierro. Grâce à elle, tu peux avoir un compte bancaire.\nSi tu as un compte bancaire, tu dois régulièrement déposer ton argent dans les ATM un peu partout \nen ville (boitiers gris et verts) mais avec une taxe de 6 pourcents donnée à la banque si tu n'as pas de maison, ce qui te motivera donc à \"travailler\" et obtenir un maximum d'argent.","Ok","");
			}
		}
		case 30:
		{
			{
				ShowPlayerDialog(playerid, 31, DIALOG_STYLE_MSGBOX,""DLG_WHITE"Tutoriel",""DLG_WHITE"\nEn revanche, la taxe ainsi que la création d'un compte permettent à la banque de gagner de l'argent. Cela augmente donc le montant d'argent à gagner lors d'un braquage.\nSi tu te fais tuer par un autre joueur, tu perdra tout.","Ok","");
			}
		}
		case 31:
		{
			{
				SetPlayerPos(playerid, -2161.0,129.0,35.0);
				SetCameraBehindPlayer(playerid);
				ShowPlayerDialog(playerid, 32, DIALOG_STYLE_MSGBOX,""DLG_WHITE"Tutoriel",""DLG_WHITE"Tu as un téléphone accessible à tout moment avec la commande /tel qui te montre l'heure et la date en France,\nIl te permet de consulter ton solde bancaire, faire des virements à tes amis, envoyer des SMS, appeler et même te repérer avec le GPS !\nLe tutoriel est à présent terminé ! Fais /infos pour obtenir des infos sur le serveur et les commandes !","Ok","");
			}
		}
		case 32:
		{
			SetCameraBehindPlayer(playerid);
			new INI:File = INI_Open(UserPath(playerid));
			INI_SetTag(File,"data");
			INI_WriteBool(File,"Tuto",true);
			INI_Close(File);
			ShowPlayerDialog(playerid, -1, DIALOG_STYLE_MSGBOX,""DLG_WHITE"Tutoriel",""DLG_WHITE"Profites de ton expérience de jeu et pour toute réclamation, va sur le forum ! "DLG_RED"sanandreasonline.forumactif.com","Ok","");
			StopAudioStreamForPlayer(playerid);
		}
		case 33:
		{
		    if(response)
		    {
				new string[2560];
				switch(listitem)
				{
				    case 0:
					{
					    strcat(string,"{ffffff}Tout d'abord si tu es nouveau, nous te souhaitons la bienvenue !\n\n");
					    strcat(string,"Sache que ce serveur est un {ff0000}mode libre{ffffff}. Nous ne t'imposons pas une manière de jouer, {ff0000}les joueurs ne doivent également pas te l'imposer\n\n");
					    strcat(string,"De ce fait, il se peut que tu te fasses {ff0000}tuer par un joueur{ffffff}. Tu perdras alors l'argent que tu possédais ou du moins une liasse sera disponible pour {ff0000}tout le monde{ffffff}\n");
					    strcat(string,"Dépêche-toi donc d'aller récupérer cette liasse avant que d'autres le fassent ! Autrement tu peux toujours déposer ton argent dans un {ff0000}ATM\n en appuyant sur F à côté de ce dernier.{ffffff}\n");
					    strcat(string,"Les ATM sont principalement situés dans le {ff0000}centre de San Fierro{ffffff}, tu peux toujours utiliser ton {ff0000}GPS dans ton téléphone{ffffff} pour trouver l'ATM le plus proche !\n{ffff00}Consulte la rubrique 'À propos de l'argent' dans le {ff0000}/infos{ffff00} pour en savoir plus !\n\n");
					    strcat(string,"{ffffff}Si le skin que tu as ne te plais pas ou plus, tu peux toujours le changer au {ff0000}magasin de skins (GPS toujours dans ton téléphone !) contre 200 malheureux dollars.{ffffff}\n\n");
					    strcat(string,"Peu importe dans quel magasin où tu iras, si tu n'as pas assez d'argent sur toi et que tu as assez en banque ; {ff0000}alors le virement s'effectuera depuis ton compte.{ffffff}\n\n");
					    strcat(string,"Par ailleurs, tu résides sûrement dans l'hôtel. Si tel est le cas, {ff0000}tu vas devoir payer un loyer à chaque heure{ffffff}.\nPour t'acquitter de ce loyer {ff0000}tu dois acheter une maison{ffffff} !\n\n");
					    strcat(string,"{ff0000}Des missions sont également présentes sur le serveur{ffffff}, elles tracent toute une histoire à partir de ton joueur nouveau en Amérique !\n\n{ffff00}");
						strcat(string,"{ffff00}Enfin, il est fort conseillé de consulter la {ff0000}rubrique 'Règles' du /infos {ffff00}pour éviter d'être réprimandé !");
					}
					case 1:
					{
					    strcat(string,"{ffffff}\t\tNouveautés\n\n{ffff00}- Ajout de cambriolages (avec bonus pendant le soir)\n- Ajout de secrets/références partout sur la map\n- Ajout de courses\n- Ajout des propriétés");
					}
					case 2:
					{
					    strcat(string,"{ffffff}Ton portable comporte 4 options au total et est accessible en faisant /tel\n{ffff00}- SMS\n{ffffff}Si tu as un numéro de téléphone (/createnum si non) tu peux envoyer des textos privés à tous les joueurs connectés\n\n{ffff00}");
					    strcat(string,"- Appel / Gestion de contacts\n{ffffff}Tu peux également ajouter des contacts dans ton répertoire et ainsi faciliter tes appels !\nAppeler un contact te permet d'entamer une longue conversation privée avec celui-ci alors n'hésite pas à l'utiliser !\nFaire /numero te permettra de te rappeler de ton numéro de téléphone à communiquer pour les autres !\n");
						strcat(string,"De plus, appuyer sur Y te permettra de répondre à un appel et N de raccrocher à cet appel\n\n{ffff00}");
					    strcat(string,"- Consultation bancaire\n{ffffff}Si tu as un compte bancaire, alors tu pourras utiliser cette option qui te permet de consulter n'importe quand le montant sur ton compte.\nIl te permet également d'effectuer des virements avec des joueurs déconnectés par exemple !\n\n{ffff00}- GPS\n{ffffff}");
						strcat(string,"Au même titre que Google Maps, tu pourras te repérer sur la map à l'aide de cette option.\nElle te permettra de savoir par exemple le restaurant le plus proche qui te permettra de restaurer ta vie\nOu bien si tu es saoul, tu pourras retrouver ta maison sans problème !");
					}
					case 3:
					{
					    strcat(string,"{ffffff}Tu peux acheter différents biens sur le serveur :\n{ffff00}- Maison\n{ffffff}Acheter une maison te permet de t'acquitter du loyer à payer\n");
					    strcat(string,"mais aussi d'avoir un chez-soi auquel on peut spawn ! Il est conseillé de verrouiller ta maison tant que tu n'y es pas afin d'éviter les cambriolages.\nPour ce faire, appuyez sur les touches Y et N pour la dé/verrouiller (en étant à l'entrée ou sortie de votre maison).\n");
					    strcat(string,"Les maisons disponibles sur le serveur sont représentées par une maisonnette verte sur votre mini-map. Rejoins l'endroit et tape /buyhouse pour l'acheter !\n");
					    strcat(string,"Si à contrario tu veux la vendre dans ce cas-là il te suffit de taper /sellhouse, tu seras relogé à l'hôtel.\n");
					    strcat(string,"Les maisonnettes en rouge représentent des maisons occupées par les joueurs.\n\n{ffff00}- Véhicules\n{ffffff}Tu peux également acheter un véhicule que tu peux faire apparaître avec /callcar et garer avec /park\n");
					    strcat(string,"Pour ce faire, rends-toi au concessionnaire (GPS) et appuies sur F ou entrée si le vendeur n'est pas occupé !\n");
					    strcat(string,"Pour changer la couleur de ton véhicule il te suffit d'aller à un garage transfender (ou du même type) qui te permet de choisir la couleur.\nLa couleur sera automatiquement sauvegardée ainsi que le tuning effectué.\n\n{ffff00}- Propriétés\n{ffffff}");
					    strcat(string,"Des propriétés sont sûrement en vente dans tout San Fierro !\nElles ont chacune la particularité de générer un certain montant d'argent qui sera stocké dans votre caisse personnelle.\nCependant, la caisse a ses limites ! Alors dépêchez-vous de récupérer vos profits en faisant F à l'emplacement de votre propriété.\n");
					    strcat(string,"Pour acheter une propriété, il suffit de faire pareil que pour les maisons à savoir /buybiz à l'emplacement de la propriété et si tu souhaites la vendre : /sellbiz.\n\n{ffff00}");
					    strcat(string,"- Armes\n{ffffff}Tu peux enfin, acheter des armes à l'ammunation (GPS) qui seront sauvegardées lors de votre déconnexion.\nAprès ta mort, tu gardes quand même tes armes ! Tu perdras tes armes que quand toutes les munitions seront écoulées !");
					}
					case 4:
					{
					    strcat(string,"{ffffff}Tu dois protéger ton argent avant que quelqu'un d'autre s'en empare.\nLes ATM sont faits pour toi afin que tu déposes ta besogne dedans si tu as un compte bancaire.\n");
					    strcat(string,"Si tel n'est pas le cas, alors tu dois te rendre à la banque (GPS), aller sur le pickup info et faire /banque pour en ouvrir un.\nLes frais de dossier s'élèvent à 500$.\n\n");
					    strcat(string,"Cependant, en déposant dans un ATM tu seras taxé d'un certain pourcentage. Le montant taxé ira droit au coffre de la banque braquable.\n\n");
					    strcat(string,"Les achats que tu pourras faire dans les restaurants ou bars iront pareillement dans le coffre du commerce respectif qui lui aussi sera braquable.\n");
					    strcat(string,"Si tu souhaites consulter le montant des divers coffres il te suffit de taper /balance.\n");
					    strcat(string,"Par ailleurs, si tu souhaites gagner de l'argent il te suffit d'effectuer\n les diverses occupations mises à disposition et consultables dans la rubrique 'Occupations'\n");
					}
					case 5:
					{
					    strcat(string,"{ffffff}Divers moyens sont présents pour gagner de l'argent ou tout simplement pour t'occuper :\n{ffff00}- Braquages\n{ffffff}Tu peux braquer diverses entités et notamment la banque !\nPour ce faire il te suffit d'avoir un compagnon de braquage et de lui proposer un braquage en faisant /braquage\n");
					    strcat(string,"Il suffira ensuite de suivre les instructions.\nCependant prenez garde à ne pas rater le braquage, des policiers vous intercepteront auquel cas.\nTu peux également braquer des commerces comme les restaurants ou encore les bars.\nIl te suffit juste de menacer le caissier ou la caissière en le pointant de ton arme (achetée à l'ammunation).\n");
					    strcat(string,"Reste alors dans le checkpoint qui apparaîtra pendant quelques secondes et tu repartiras avec la caisse !\n\n{ffff00}- Missions\n");
					    strcat(string,"{ffffff}Des missions se créeront au fur et à mesure, elles te permettent de retracer l'histoire de ton personnage\n tout en débloquant des bonus et en gagnant de l'argent !\nElles sont généralement représentées par une lettre ou un symbole différent des autres sur ta mini-map.\n");
					    strcat(string,"N'hésite pas à les faire, tu seras protégé de la potentielle menace des autres joueurs !\n\n{ffff00}- Mini-jeux\n{ffffff}En faisant les missions, tu débloquera des mini-jeux.\nIls retracent plus ou moins ce que tu as fait dans les missions et rapportent de l'argent !");
						strcat(string,"\n\n{ffff00}- Missions Skydive\n{ffffff}Si tu aimes voler dans les airs, alors le skydive est fait pour toi.\n");
					    strcat(string,"Ces missions rapportant de l'argent sont accessibles via les hauts points de San Fierro, à toi de les découvrir et de t'envoler dans le ciel\n américain en appuyant sur F au parachute que tu trouveras!\n\n{ffff00}- Cambriolages\n{ffffff}");
					    strcat(string,"Si tu n'es pas très bon joueur de DM, alors profite en l'absence de monde pour cambrioler les maisons déverrouillées en faisant /robhouse.\nTu gagneras de l'argent et en feras perdre au propriétaire de la maison cambriolée !\nQui plus est, si tu cambrioles entre 19h et 6h tu auras un bonus à la fin de ton cambriolage !\n");
					    strcat(string,"Prends garde cependant aux représailles !");
        				ShowPlayerDialog(playerid,29999,DIALOG_STYLE_MSGBOX,inputtext,string,"Page 2","Quitter");
        				return 1;
					}
					case 6:
					{
						strcat(string,"Règles du Comportement\n{ff0000}- Il est bien évidemment interdit d'insulter violemment quelqu'un ou de tenir des propos discriminatoires portant par exemple sur l'ethnie\n ou les origines de cette personne.\n");
						strcat(string,"{00ff00}- Les insultes moins violentes, pouvant être amicales sont cependant autorisées sous une certaine limite.\n");
						strcat(string,"{ff0000}- Le spam, flood que ce soit par message ou par commande est interdit.\n");
						strcat(string,"- La provocation verbale, intentionnelle, dans un but malveillant n'est pas tolérée.\n");
						strcat(string,"- Toute forme de pub quelle qu'elle soit, visant à attirer du monde est strictement interdite.\n");
						strcat(string,"{00ff00}- Evoquer cependant un serveur est bien évidemment toléré tant que ça ne vise pas à faire venir des joueurs.\n");
						strcat(string,"- Les stéréotypes ou ironies basées dessus sont autorisées tant que ça n'a aucune visée personnelle.\n\n{ffff00}Règles de jeu\n{ff0000}");
						strcat(string,"- Les mods de triche ou mods avantageant beaucoup trop le gameplay sont strictement interdits.\n{00ff00}");
						strcat(string,"- Le Drive-By ainsi que le carkill sont autorisés\n");
						strcat(string,"- Il en va de même pour le Héli-Kill et le Bâti-Kill\n");
						strcat(string,"- Le DM est bien évidemment autorisé\n");
						strcat(string,"{ff0000}- Le C-Bug est cependant interdit\n");
						strcat(string,"{00ff00}- Toutefois le switch et le slide restent tolérés.\n");
						strcat(string,"{ff0000}- Le Chainkill et le spawnkill sont strictement interdits, d'autant plus envers des nouveaux joueurs.\n");
						strcat(string,"\n{ffff00}Règles de Fair-Play\n{00ff00}- Fuire un combat est autorisé {ff0000}tant qu'aucun moyen de téléportation n'est utilisé.");
					}
				}
				ShowPlayerDialog(playerid,30000,DIALOG_STYLE_MSGBOX,inputtext,string,"OK","");
			}
		}
		case 29999:
		{
		    if(response)
		    {
		        new string[1024];
		        string = "{ffff00}- Tuer\n{ffffff}Si au contraire, tu es un fanna du meurtre, tu peux chasser les bots présents dans la ville.\nChacun génère une liasse de billet variant de 1 à 100$ !\nPar ailleurs, tuer les propres joueurs peut être plus rentable car tu gagnera l'argent qu'avait le joueur sur lui !\n\n{ffff00}- Secrets\n{ffffff}";
		    	strcat(string,"Si être hors-la-loi ne te correspond pas, alors pars à la recherche des différents secrets enfouis au sein du serveur.\nIls peuvent parfois rapporter beaucoup d'argent !\n\n{ffff00}- Evénements\n{ffffff}");
			    strcat(string,"Par ailleurs, des événements peuvent être organisés par les admins comme des courses ou d'autres événements libres d'organisation par ces derniers.\nIls peuvent parfois rapporter énormément d'argent alors soyez présents !");
				ShowPlayerDialog(playerid,30001,DIALOG_STYLE_MSGBOX,"Occupations",string,"Page 1","Quitter");
			}
		}
		case 30001:
		{
		    if(response)
		    {
		        OnDialogResponse(playerid, 33, response, 4, "Occupations");
			}
		}
		case 34:
		{
		    if(response)
		    {
		        switch(listitem)
		        {
		            case 1:
		            {
						KillTimer(mutetimer[aclickedid[playerid]]);
						MuteTimer(aclickedid[playerid]);
						printf("[ADMIN] %s a unmute %s",GetName(playerid),GetName(aclickedid[playerid]));
						return 1;
					}
					case 8:
					{
					    KillTimer(jailtimer[aclickedid[playerid]]);
					    JailTimer(aclickedid[playerid]);
					    printf("[ADMIN] %s a unjail %s",GetName(playerid),GetName(aclickedid[playerid]));
					    return 1;
					}
				}
		        new string[256];
		        sanctiontype[playerid] = listitem + 1;
		        format(string,sizeof(string),"Entrez ci-dessous la raison de la sanction pour %s :",GetName(aclickedid[playerid]));
		        ShowPlayerDialog(playerid,35,DIALOG_STYLE_INPUT,inputtext,string,"Sanctionner","Retour");
			}
		}
		case 35:
		{
		    if(!response) return ShowMenuAdmin(playerid);
		    {
				if(!IsPlayerConnected(aclickedid[playerid])) return SubMessage(playerid,MSG_RED,"Le joueur à sanctionner s'est déconnecté !",5);
				Sanction(playerid,aclickedid[playerid],inputtext);
			}
		}
		case 36:
		{
		    if(response)
			{
				new msg[2048],title[256];
			    switch(listitem)
			    {

			        case 0:
					{
						msg = "\t\t{FF8000}Commandes pour les sanctions\n\n{FFFF00}/kill {008040}: Tue un joueur\n{ffff00}/unban {008040}: Débannit un joueur et sa dernière IP utilisée.\n{ffff00}/unfreeze {008040}: Dégèle un joueur\n";
						strcat(msg,"{ffff00}/ban {008040}: Bannit le compte d'un joueur déconnecté\n");
						strcat(msg,"\n\n{FF0000}Les autres sanctions sont disponibles via le menu en faisant TAB et en cliquant sur un joueur.");
			            title = "Sanctions";
					}
			        case 1:
			        {
			            msg = "\t\t{FF8000}Commandes pour la gestion du serveur\n\n{ffff00}/actor {008040}: Crée un acteur dans un fichier .txt\n{ffff00}/resetactors {008040}: Réinitialise tous les acteurs dans ce fichier .txt\n{ffff00}/setcompteur {008040}: Définit le compteur d'acteurs de ce fichier .txt\n";
			            strcat(msg,"{ffff00}/async {008040}: Resynchronise tous les acteurs du serveur\n{ffff00}/emp {008040}: Définit l'emplacement d'une maison\n{ffff00}/agivebanque {008040} : Ajoute de l'argent dans la banque.\n");
			            strcat(msg,"{ffff00}/sethour {008040}: Définit l'heure du serveur\n{ffff00}/setminute {008040}: Définit les minutes du serveur\n{ffff00}/resettime {008040}: Réinitialise l'heure du serveur\n{ffff00}/reload {008040}: Redémarre le serveur\n");
			            strcat(msg,"{ffff00}/asay {008040}: Parle en Admin\n{ffff00}/meteo {008040}: Change la météo du serveur\n{ffff00}/rain {008040}: Il pleut !\n{ffff00}/sun {008040}: Journée ensoleillée !\n{ffff00}/fog {008040}: Il y a du brouillard !\n");
			            strcat(msg,"{ffff00}/defhouse {008040}: Ouvre le panel de gestion de maisons\n{ffff00}/defcomm {008040}: Ouvre le panel de gestion de commerces\n{ffff00}/actinfo {008040}: Donne les informations d'un acteur\n{ffff00}/stoprl {008040}: Interrompt le redémarrage du serveur.\n");
			            strcat(msg,"{ffff00}/servinfos {008040}: Pour connaître toutes les données sur le serveur.\n{ffff00}/magicgun {008040}: Récupère toutes les données de vos tirs\n");
			            title = "Gestion du serveur";
					}
					case 2:
					{
					    msg = "\t\t{FF8000}Commandes pour la gestion d'un joueur\n\n{ffff00}/vcmds {008040}: Voir les commandes des joueurs entrées\n{ffff00}/aint {008040}: Définit l'intérieur d'un joueur\n{ffff00}/avw {008040}: Définit le monde virtuel d'un joueur\n";
					    strcat(msg,"{ffff00}/getvw {008040}: Récupère votre monde virtuel\n{ffff00}/asetlvl {008040}: Définit le niveau d'un joueur\n{ffff00}/spec {008040}: Surveille un joueur\n{ffff00}/specoff {008040}: Arrête de surveiller un joueur\n{ffff00}/skin {008040}: Définit le skin d'un joueur\n");
					    strcat(msg,"{ffff00}/jetpack {008040}: Vous équipe d'un jetpack !\n{ffff00}/agiveweap {008040}: Donne une arme à un joueur\n{ffff00}/setmoney {008040}: Définit l'argent d'un joueur\n{ffff00}/heal {008040}: Soigne un joueur\n{ffff00}/armour {008040}: Donne une armure à un joueur.\n");
					    title = "Gestion d'un joueur";
					}
					case 3:
					{
					    msg = "\t\t{FF8000}Commandes pour les téléportations\n\n{ffff00}/acttp {008040}: Vous téléporte à un acteur\n{ffff00}/setloc {008040}: Vous téléporte à des coordonnées entrées\n{ffff00}/tp {008040}: Vous téléporte à un joueur\n{ffff00}/tphere {008040}: Téléporte un joueur à vous\n";
					    strcat(msg,"{ffff00}/htp {008040}: Vous téléporte à une maison\n{ffff00}/ctp {008040}: Vous téléporte à un commerce\n{ffff00}/respawn {008040}: Téléporte le joueur à son spawn\n{ffff00}/skyfall {008040}: Vous allez dans les airs !!!\n");
					    title = "Téléportations";
					}
					case 4:
					{
					    msg = "\t\t{FF8000}Commandes pour la gestion des véhicules\n\n{ffff00}/specvehicle {008040}: Surveille un véhicule\n{ffff00}/fix {008040}: Répare votre véhicule\n{ffff00}/flip {008040}: Retourne votre véhicule\n{ffff00}/carcolor {008040}: Définit la couleur de votre véhicule\n";
					    strcat(msg,"{ffff00}/nitro {008040}: Place de la nitro dans votre véhicule\n{ffff00}/nonitro {008040}: Enlève la nitro de votre véhicule\n{ffff00}/svehicle {008040}: Définit le spawn d'un véhicule\n");
					    title = "Gestion des véhicules";
					}
				}
				ShowPlayerDialog(playerid,37,DIALOG_STYLE_MSGBOX,title,msg,"Ok","Retour");
			}
		}
		case 37 : if(!response) return ShowPlayerDialog(playerid,36,DIALOG_STYLE_LIST,"Commandes","{0080C0}\t\t{0080C0}Sanctions\n\t\t{0080C0}Gestion du serveur\n\t\t{0080C0}Gestion joueur\n\t\t{0080C0}Téléportations\n\t\t{0080C0}Gestion véhicule\n","Ok","Retour");
		case 38 :
		{
		    if(response)
		    {
		        switch(listitem)
		        {
					case 0 : ShowPlayerDialog(playerid,39,DIALOG_STYLE_INPUT,"Nom de la course","Entrez ci-dessous le nom de la course que vous souhaitez créer :","Entrer","Quitter");
					case 1 :
					{
					    if(Races == 0) return SubMessage(playerid,MSG_RED,"Le serveur n'a encore aucune course !",5);
					    new msg[1024],string[256];
					    for(new i=1; i <= Races ; i++)
						{
  							format(string,sizeof(string),RACEPATH,i);
							INI_ParseFile(string,"LoadPlayerRaces_%s",false, true, playerid, false);
							format(string,sizeof(string),"{ffffff}[{0080C0}%d{ffffff}] - '{008000}%s{ffffff}'\n",i,RacePlayer[playerid][RaceName]);
							strcat(msg,string);
						}
						ShowPlayerDialog(playerid,40,DIALOG_STYLE_LIST,"Liste des courses",msg,"Modifier","Quitter");
					}
				}
			}
		}
		case 39:
		{
		    if(response)
		    {
				BuildingRace[playerid] = true;
				racebuilding[playerid] = Races + 1;
				RacePlayer[playerid][Model] = 0;
				RacePlayer[playerid][Ang] = 0.0;
				RacePlayer[playerid][CPMax] = 0;
				NumCPBuilding[playerid] = 0;
				Races ++;
				new INI:File = INI_Open(SPATH);
				INI_SetTag(File,"data");
				INI_WriteInt(File,"Races",Races);
				INI_Close(File);
				new string[256];
				format(string,sizeof(string),RACEPATH,racebuilding[playerid]);
				File = INI_Open(string);
				INI_SetTag(File,"data");
				INI_WriteString(File,"Name",inputtext);
				INI_Close(File);
				format(string,sizeof(string),"[ADMIN] Vous construisez la course '{ffffff}%s{33AA33}'.",inputtext);
				SendClientMessage(playerid,BLUE,string);
				SendClientMessage(playerid,BLUE,"[ADMIN] Tapez {ffffff}/setcp{0080C0} pour placer chaque checkpoint !");
				format(string,sizeof(string),"%s",inputtext);
				RacePlayer[playerid][RaceName] = string;
				ShowTDRaceEditor(playerid);
			}
		}
		case 40:
		{
		    if(response)
		    {
				new string[256],id = listitem + 1;
				format(string,sizeof(string),RACEPATH,id);
				if(!fexist(string)) return SubMessage(playerid,MSG_RED,"Cette course n'existe pas !",5);

				BuildingRace[playerid] = true;
				format(string,sizeof(string),"[ADMIN] Vous éditez la course {ffffff}%d",id);
				SendClientMessage(playerid,BLUE,string);
				racebuilding[playerid] = id;
				format(string,sizeof(string),RACEPATH,racebuilding[playerid]);
				INI_ParseFile(string,"LoadPlayerRaces_%s",false, true, playerid, false);
				ShowTDRaceEditor(playerid);
			}
		}
		case 41:
		{
		    if(response)
		    {
		        new string[256];
    			format(string,sizeof(string),RACEPATH,racebuilding[playerid]);
				new INI:File = INI_Open(string);
				INI_SetTag(File,"data");
				INI_WriteString(File,"Name",inputtext);
				INI_Close(File);
				format(string,sizeof(string),"[ADMIN] La course se nomme désormais {ffffff}%s",inputtext);
				SendClientMessage(playerid,BLUE,string);
				format(string,sizeof(string),"%s",inputtext);
				RacePlayer[playerid][RaceName] = string;
				ConvertEncoding(inputtext);
				PlayerTextDrawSetString(playerid,TDRace_Editor[playerid][2],inputtext);
			}
		}
		case 42:
		{
		    if(response)
		    {
		        new model,car[256],string[256];
        		format(string,sizeof(string),RACEPATH,racebuilding[playerid]);
				new INI:File = INI_Open(string);
				if(strval(inputtext) != 0)
				{
				    model = strval(inputtext);
      				INI_SetTag(File,"data");
					INI_WriteInt(File,"Model",model);
					INI_Close(File);
					PlayerTextDrawSetPreviewModel(playerid,TDRace_Editor[playerid][3],model);
					PlayerTextDrawSetString(playerid,TDRace_Editor[playerid][4],VehicleNames[model - 400]);
					RacePlayer[playerid][Model] = model;
					format(string,sizeof(string),"[ADMIN] La course se déroulera en {ffffff}%s",VehicleNames[model - 400]);
					ConvertEncoding(VehicleNames[model - 400]);
					SendClientMessage(playerid,BLUE,string);
					return 1;
				}
				else
				{
					if(!strlen(inputtext))
					{
						model = 0;
						string = "[ADMIN] La course se déroulera {ffffff}à pied.";
						car = "À pied";
					}
					else
					{
						model = GetVehicleModelByName(inputtext);
						if(model == 0) return SubMessage(playerid,MSG_RED,"Nom de véhicule invalide !",5);
						format(car,sizeof(car),"%s",VehicleNames[model - 400]);
					}
					if(model != 0) format(string,sizeof(string),"[ADMIN] La course se déroulera en {ffffff}%s",car);
 					INI_SetTag(File,"data");
					INI_WriteInt(File,"Model",model);
					INI_Close(File);
					PlayerTextDrawSetPreviewModel(playerid,TDRace_Editor[playerid][3],model);
					PlayerTextDrawHide(playerid,TDRace_Editor[playerid][3]);
					PlayerTextDrawShow(playerid,TDRace_Editor[playerid][3]);
					ConvertEncoding(car);
					PlayerTextDrawSetString(playerid,TDRace_Editor[playerid][4],car);
					RacePlayer[playerid][Model] = model;
				    SendClientMessage(playerid,BLUE,string);
				}
			}
		}
		case 43:
		{
		    if(response)
		    {
		        new value = strval(inputtext),string[256];
		        if(value < 0) return SubMessage(playerid,MSG_RED,"Il ne peut pas y avoir une valeur négative de checkpoints !",5);

				RacePlayer[playerid][CPMax] = value;
				format(string,sizeof(string),RACEPATH,racebuilding[playerid]);
				new INI:File = INI_Open(string);
				INI_SetTag(File,"data");
				INI_WriteInt(File,"CP",value);
				INI_Close(File);
		        format(string,sizeof(string),"[ADMIN] Il y a maintenant {ffffff}%d {0080C0}checkpoints au total",RacePlayer[playerid][CPMax]);
		        SendClientMessage(playerid,BLUE,string);
			}
		}
		case 44:
		{
		    if(response)
		    {
	    		new string[256],car[256],idrace = listitem + 1;
		    	format(string,sizeof(string),RACEPATH,idrace);
		    	INI_ParseFile(string, "LoadRaces_%s");
				if(typecar - 400 < 0) car = "à pied";
				else format(car,sizeof(car),"%s",VehicleNames[typecar-400]);
				format(string,sizeof(string),"[ADMIN] 'La course {ffffff}%s{33AA33}' ({ffffff}%s{33AA33}) vient d'être lancée !",NameRace,car);
				SendClientMessageToAll(BLUE,string);
				/*
				format(string,sizeof(string),"[ADMIN] CP : {ffffff}%d {33AA33}| Distance : {ffffff}%.2f {33AA33}mètres",CpRace,CalculDistanceBetweenCP());
				SendClientMessageToAll(BLUE,string);
				*/
				SendClientMessageToAll(BLUE,"Pour rejoindre la course, tapez {ffffff}/join");
				RaceLoaded = true;
				SendClientMessage(playerid,BLUE,"{ffff00}[ADMIN] Faites {ffffff}/rstart {ffff00} pour lancer la course !");
				SetCountDown(30,true);
			}
		}
		case 45:
		{
		    if(response)
		    {
				new pass = udb_hash(inputtext);
		        if(stepchangepassword[playerid] == 1)
		        {
		            if(PlayerInfo[playerid][pPass] != pass) return SubMessage(playerid,MSG_RED,"Mot de passe invalide !",5);
		            ShowPlayerDialog(playerid,45,DIALOG_STYLE_INPUT,"Changement de mot de passe","Entrez votre nouveau mot de passe :","Entrer","Quitter");
		            stepchangepassword[playerid] = 2;
				}
				else if(stepchangepassword[playerid] == 2)
				{
				    if(!strlen(inputtext)) return SubMessage(playerid,MSG_RED,"Entrez un mot de passe !",5);
				    new string[256];
				    format(string,sizeof(string),"{ffff00}Nouveau mot de passe : {ffffff}%s",inputtext);
				    stepchangepassword[playerid] = 3;
					ShowPlayerDialog(playerid,45,DIALOG_STYLE_MSGBOX,"Changement de mot de passe",string,"Ok","");
					new INI:File = INI_Open(UserPath(playerid));
					INI_SetTag(File,"data");
					INI_WriteInt(File,"Password",pass);
					INI_Close(File);
					PlayerInfo[playerid][pPass] = pass;
				}
			}
		}
		case 46:
		{
		    if(response)
		    {
				switch(listitem)
				{
				    case 0:
					{
					    StartMission(playerid, 300);
					}
				}
			}
		}
		case 47:
		{
		    if(response)
		    {
				if(IsAllCabineOccuped() == -1) return SubMessage(playerid,MSG_BLUE,"Toutes les cabines sont occupées, veuillez patienter !",5);
				new value = IsAllCabineOccuped();
				SubMessage(playerid,MSG_YELLOW,"Touche la cible en une seule balle par niveau !",5);
				cabine[playerid] = value;
				SavePlayerWeapons(playerid);
				ResetPlayerWeapons(playerid);
				SetPlayerPosEx(playerid,PosCabine[value][0],PosCabine[value][1],PosCabine[value][2],1,5);
				InAmmu[playerid] = true;
				CabineOccuped[value] = true;
				ammulvl[playerid] = 1;
				CreateTarget(playerid,ammulvl[playerid]);
			}
		}
		case 48:
		{
		    if(response)
		    {
		        new string[256];
		        switch(request[playerid])
		        {
		            case 1:
		            {
              			NPCInfo[playerid][Skin] = strval(inputtext);
						format(string,sizeof(string),"[ADMIN] Le NPC a le skin {ffffff}%d",NPCInfo[playerid][Skin]);
						SendClientMessage(playerid,BLUE,string);
						PlayerTextDrawSetPreviewModel(playerid,TDMenu_NPC[playerid][3],NPCInfo[playerid][Skin]);
						UpdateTXD(playerid,TDMenu_NPC[playerid][3]);
						FCNPC_SetSkin(NPCInfo[playerid][NpcID],NPCInfo[playerid][Skin]);
					}
					case 2:
					{
					    if(strval(inputtext) == 0) return SubMessage(playerid,MSG_RED,"ID d'arme invalide !",5);
					    NPCInfo[playerid][Weap] = strval(inputtext);
						new WeaName[32],model;
						switch(NPCInfo[playerid][Weap])
						{
						    case 22..29: model = NPCInfo[playerid][Weap] + 324;
						    case 30: model = 355;
						    case 31: model = 356;
						    case 32: model = 372;
						    case 33: model = 357;
						    case 34: model = 358;
						    case 38: model = 362;
						}
						PlayerTextDrawSetPreviewModel(playerid,TDMenu_NPC[playerid][6],model);
						UpdateTXD(playerid,TDMenu_NPC[playerid][6]);
					    GetWeaponName(NPCInfo[playerid][Weap],WeaName,sizeof(WeaName));
					    format(string,sizeof(string),"[ADMIN] Vous équipez le NPC d'un {ffffff}%s",WeaName);
						SendClientMessage(playerid,BLUE,string);
						FCNPC_SetWeapon(NPCInfo[playerid][NpcID],NPCInfo[playerid][Weap]);
						FCNPC_SetAmmo(NPCInfo[playerid][NpcID],9999);
						FCNPC_SetWeaponInfo(NPCInfo[playerid][NpcID], NPCInfo[playerid][Weap], 1000, 200,-1,0.05);
					}
					case 3:
					{
					    if(listitem == 0)
					    {
					        SendClientMessage(playerid,BLUE,"[ADMIN] Le NPC suivra le joueur le plus proche !");
					        NPCInfo[playerid][FollowID] = -2;
						}
						else
						{
						    new msg[1024];
						    for(new i ; i < MAX_PLAYERS; i++)
						    {
								if(IsPlayerConnected(i) && !IsPlayerNPC(i))
								{
									format(string,sizeof(string),"\t\t%s\n",GetName(i));
									strcat(msg,string);
								}
							}
							request[playerid] = 8;
							ShowPlayerDialog(playerid,48,DIALOG_STYLE_LIST,"Joueurs",msg,"Choisir","Quitter");
						}
					}
					case 4:
					{
						if(listitem == 0)
					    {
					        SendClientMessage(playerid,BLUE,"[ADMIN] Le NPC visera le joueur le plus proche !");
					        NPCInfo[playerid][FocusID] = -2;
						}
						else
						{
						    new msg[1024];
						    for(new i ; i < MAX_PLAYERS; i++)
						    {
								if(IsPlayerConnected(i) && !IsPlayerNPC(i))
								{
									format(string,sizeof(string),"\t\t%s\n",GetName(i));
									strcat(msg,string);
								}
							}
							request[playerid] = 9;
							ShowPlayerDialog(playerid,48,DIALOG_STYLE_LIST,"Joueurs",msg,"Choisir","Quitter");
						}
					}
					case 5:
					{
						new Float:dist = floatstr(inputtext);
						if(dist <= 0.0) return SubMessage(playerid,MSG_RED,"Valeur invalide !",5);
						NPCInfo[playerid][AimDist] = dist;
						format(string,sizeof(string),"[ADMIN] Le NPC visera dans un périmètre de {ffffff}%.2f mètres",NPCInfo[playerid][AimDist]);
						SendClientMessage(playerid,BLUE,string);
						format(string,sizeof(string),"Distance de visée : %.2f mètres",NPCInfo[playerid][AimDist]);
						ConvertEncoding(string);
						PlayerTextDrawSetString(playerid,TDMenu_NPC[playerid][10],string);
						UpdateTXD(playerid,TDMenu_NPC[playerid][10]);
					}
					case 6:
					{
						new Float:preci = floatstr(inputtext);
						if(preci <= 0.0 || preci > 1.0) return SubMessage(playerid,MSG_RED,"Valeur invalide (0.0 - 1.0) !",5);
						NPCInfo[playerid][Accuracy] = preci;
						format(string,sizeof(string),"[ADMIN] Le NPC aura une précision de {ffffff}%.2f pourcents",NPCInfo[playerid][Accuracy] * 100.0);
						SendClientMessage(playerid,BLUE,string);
						FCNPC_SetWeaponInfo(NPCInfo[playerid][NpcID], NPCInfo[playerid][Weap], 1000, TimeWeap(NPCInfo[playerid][Weap]),-1, NPCInfo[playerid][Accuracy]);
						format(string,sizeof(string),"Précision : %.2f%",NPCInfo[playerid][Accuracy] * 100.0);
						ConvertEncoding(string);
						PlayerTextDrawSetString(playerid,TDMenu_NPC[playerid][11],string);
						UpdateTXD(playerid,TDMenu_NPC[playerid][11]);
						FCNPC_SetWeaponInfo(NPCInfo[playerid][NpcID], NPCInfo[playerid][Weap], 1000, 200,-1,NPCInfo[playerid][Accuracy]);
					}
					case 7:
					{
						new Float:health = floatstr(inputtext);
						if(health <= 0.0) return SubMessage(playerid,MSG_RED,"Valeur invalide !",5);
						NPCInfo[playerid][Health] = health;
						format(string,sizeof(string),"[ADMIN] Vous avez mis la vie du NPC à {ffffff}%.2f",NPCInfo[playerid][Health]);
						SendClientMessage(playerid,BLUE,string);
						FCNPC_SetHealth(NPCInfo[playerid][NpcID],NPCInfo[playerid][Health]);
						format(string,sizeof(string),"Vie : %.2f",NPCInfo[playerid][Health]);
						ConvertEncoding(string);
						PlayerTextDrawSetString(playerid,TDMenu_NPC[playerid][12],string);
						UpdateTXD(playerid,TDMenu_NPC[playerid][12]);
					}
					case 8:
					{
						new id = listitem;
						loop_id:
						if(!IsPlayerConnected(id))
						{
						    id ++;
						    goto loop_id;
						}
					    NPCInfo[playerid][FollowID] = id;
					    format(string,sizeof(string),"[ADMIN] Le NPC suivra désormais {ffffff}%s",GetName(NPCInfo[playerid][FollowID]));
					    SendClientMessage(playerid,BLUE,string);
					}
					case 9:
					{
						new id = listitem;
						loop_id:
						if(!IsPlayerConnected(id))
						{
						    id ++;
						    goto loop_id;
						}
	    				NPCInfo[playerid][FocusID] = id;
					    format(string,sizeof(string),"[ADMIN] Le NPC visera désormais {ffffff}%s",GetName(NPCInfo[playerid][FocusID]));
					    SendClientMessage(playerid,BLUE,string);
					}
				}
			}
		}
	}
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
    new value = GetPlayerVirtualWorld(playerid);

	//ROBS
    if(IsPlayerInRangeOfPoint(playerid,5.0,221.0,1857.0,13.0)) DisablePlayerCheckpoint(playerid);
	if(robbing[playerid] == true)
	{
        if(IsPosRobHouse(playerid))
        {
            SubMessage(playerid,MSG_YELLOW,"Restez ici 15 secondes le temps de tout mettre dans le carton !",5);
            robhtimer[playerid] = SetTimerEx("RobHouseTimer",15000,false,"i",playerid);
            ApplyAnimation(playerid,"BOMBER","BOM_Plant",4.0,1,1,1,1,0,1);

		}
	}
	if(IsPlayerInRangeOfPoint(playerid,4.0,-1977.2008,1227.3647,31.6484))
	{
		if(!IsPlayerInVehicle(playerid,vmission[playerid])) return SubMessage(playerid,MSG_RED,"Tu dois être à bord du Boxville !",5);
		{
			new string[256];
		    new proprioid = GetPlayerID(proprio[housefocus[playerid]]);
			new cash = random(10000);
		    if(!IsPlayerConnected(proprioid))
		    {
			    new path[256];
			    format(path,sizeof(path),PATH, proprio[housefocus[playerid]]);
				new victimeid = 999;
				INI_ParseFile(path, "LoadUser_%s", false, true, victimeid, false);
				PlayerInfo[victimeid][pCash] -= cash;
				format(path,sizeof(path),PATH,proprio[housefocus[playerid]]);
				new INI:File =INI_Open(path);
				INI_SetTag(File,"data");
				INI_WriteInt(File,"Cash",PlayerInfo[victimeid][pCash]);
				INI_Close(File);
			}
			else
			{
			    format(string,sizeof(string),"~r~T'as pas réussi à défendre ta maison ! Tu perds ~w~$%d",cash);
			    SubMessage(proprioid,MSG_RED,string,5);
			    GiveMoney(proprioid,-cash);
			}
			format(string,sizeof(string),"Tu as réussi ton cambriolage et remporté ~w~$%d",cash);
			SubMessage(playerid,MSG_BLUE,string,5);
			format(string,sizeof(string),"~y~Mission réussie ! ~n~~w~$%d",cash);
			GameTextForPlayerEx(playerid, string, 5000, 0);
			GiveMoney(playerid,cash);
			PlayAudioStream(playerid, "http://xdev-team.tk/creations/sao/Audio/VC-Miscom.mp3");
			robbing[playerid] = false;
			DisablePlayerCheckpointEx(playerid);
			DestroyVehicle(vmission[playerid]);
			nextrob[playerid] = false;
			timerob[playerid] ++;
			trob[playerid] = SetTimerEx("RobTimer",60000,true,"i",playerid);
			new hours,minutes,second;
			gettime(hours,minutes,second);
			minutes = 0;
			second = 0;
			GivePlayerWantedLevel(playerid, STAR_ROBHOUSE);
			if(hours >= 19 || hours <= 5)
			{
				new bonus = cash/2;
				format(string,sizeof(string),"Tu gagnes ~w~$%d ~y~en plus pour avoir cambriolé de nuit !",bonus);
				SubMessage(playerid,MSG_YELLOW,string,5);
				GiveMoney(playerid, bonus);
			}
		}
	}

	if(IsPlayerInRangeOfPoint(playerid,4.0,	1677.85,-1002.87,671.00))
	{
		SubMessage(playerid,MSG_YELLOW,"Tu commences à ramasser les billets ! Reste sur ta position pendant 30 secondes !",10);
		tbraquage = SetTimer("BraquageTimer",30000,false);
	}
	if(IsPlayerInRangeOfPoint(braqueur[0],4.0,-1945.0,1000.0,35.0) && IsPlayerInRangeOfPoint(braqueur[1],4.0,-1945.0,1000.0,35.0))
	{
		EndBraquage();
		new string[256];
		for(new i;i<2;i++)
		{
			format(string,sizeof(string),"~y~Mission réussie ! ~n~~w~$%d",MoneyBanque/2);
			GameTextForPlayerEx(braqueur[i], string, 5000, 0);
			GivePlayerWantedLevel(braqueur[i],STAR_ROBBANK);
			GiveMoney(braqueur[i],MoneyBanque/2);
			PlayAudioStream(braqueur[i], "http://xdev-team.tk/creations/sao/Audio/VC-Miscom.mp3");
		}
		GiveMoneyBanque(-MoneyBanque);
	}
	if(IsPlayerInCommerceBraq(playerid))
	{
 		SubMessage(playerid,MSG_BLUE,"Le braquage de commerce a commencé ! Reste sur le checkpoint proche de toi pendant 10 secondes",10);
	    ctimer[playerid] = SetTimerEx("BraquageCommerce",10000,false,"i",playerid);
 	}

	//MISSIONS
	if(IsPlayerInRangeOfPoint(playerid,1.0,POSMISSION2))
	{
		EndMission(playerid,2);
	}
	if(IsPlayerInRangeOfPoint(playerid,1.0,ENTREPOT))
	{
		SubMessage(playerid,MSG_YELLOW,"Il semblerait que les \"amis\" de Fabrizio n'apprécient pas ta visite. Finis-les !",10);
		PlayAudioStream(playerid, "http://xdev-team.tk/creations/sao/Audio/D3R-MEsc.mp3");
		SetMissionObj(playerid, "Élimine les mafieux ! (Headshots activés)");
		DisablePlayerCheckpoint(playerid);
		DestroyVehicle(vmission[playerid]);
	 	new string[64];

		format(string,sizeof(string),"Maf1_%d", GetPlayerVirtualWorld(playerid));
		maf[playerid][0] = CreateNPC(string,124,-2170.0,-243.0,40.0,0.0, GetPlayerVirtualWorld(playerid),WEAPON_MP5,9999);

		format(string,sizeof(string),"Maf2_%d", GetPlayerVirtualWorld(playerid));
		maf[playerid][1] = CreateNPC(string,125,-2178.0,-253.0,40.0,0.0, GetPlayerVirtualWorld(playerid),WEAPON_MP5,9999);

		format(string,sizeof(string),"Maf3_%d", GetPlayerVirtualWorld(playerid));
		maf[playerid][2] = CreateNPC(string,126,-2182.0,-248.0,40.0,0.0, GetPlayerVirtualWorld(playerid),WEAPON_MP5,9999);

		format(string,sizeof(string),"Maf4_%d", GetPlayerVirtualWorld(playerid));
		maf[playerid][3] = CreateNPC(string,127,-2172.0,-253.0,37.0,0.0, GetPlayerVirtualWorld(playerid),WEAPON_MP5,9999);

		format(string,sizeof(string),"Maf5_%d", GetPlayerVirtualWorld(playerid));
		maf[playerid][4] = CreateNPC(string,124,-2148.0,-260.0,36.0,0.0, GetPlayerVirtualWorld(playerid),WEAPON_MP5,9999);

		format(string,sizeof(string),"Maf6_%d", GetPlayerVirtualWorld(playerid));
		maf[playerid][5] = CreateNPC(string,125,-2160.0,-268.0,40.0,0.0, GetPlayerVirtualWorld(playerid),WEAPON_MP5,9999);

		for(new i = 0;i<6;i++)
		{
			if(!FCNPC_IsDead(maf[playerid][i]))
			{
				FCNPC_AimAtPlayer(maf[playerid][i],playerid,true,15);
				FCNPC_SetWeaponInfo(maf[playerid][i], WEAPON_MP5, 1000, 200, 17, 0.05);
			}
		}
	}
	if(IsPlayerInRangeOfPoint(playerid,1.0,POSDOHERTY))
	{
	    DisablePlayerCheckpoint(playerid);
		MTD(playerid,"",201,false);
	}
	if(IsPlayerInRangeOfPoint(playerid,1.0,POSCAISSES))
	{
	    SubMessage(playerid,MSG_YELLOW,"Appuies sur ~k~~CONVERSATION_YES~ pour prendre une caisse à ce pickup, puis ~k~~CONVERSATION_NO~ pour la déposer dans le coffre du boxville !",10);
	}
	if(IsPlayerNPC(playerid))
	{
		if(mission[value - 1] != 0)
		{
		 	if(playerid == AME[value-1] && IsPlayerInRangeOfPoint(playerid, 30.0, -2457.068359,2297.263183,4.618873))
			{
				SubMessage(value-1, MSG_BLUE, "~r~T'as pas réussi à tuer l'ennemi à temps !",5);
				FailMission(value-1);
			}
		    if(IsPlayerInRangeOfPoint(playerid, 10.0, -2033.0,-62.22,35.3))
		    {
		        if(IsPlayerNPC(playerid))
				{
					SubMessage(value-1, MSG_BLUE, "~r~T'as été trop lent et Matthew est mort !",5);
					FailMission(value-1);
				}
				else
				{
				    if(IsPlayerInVehicle(playerid,vmission[playerid]))
				    {
						Kick(RE[playerid][0]);
						for(new i = 1; i < 4 ; i++)	DestroyNPC(RE[playerid][i]);
						DestroyVehicle(vennemy[playerid]);
					    DisablePlayerCheckpoint(playerid);
					    StartDialog(playerid,202);
					}
					else
					{
						SetMissionObj(playerid, "Reviens ici avec la voiture !");
					}
				}
		 	}
			if(IsPlayerInRangeOfPoint(playerid, 5.0,405.0,2450.0,16.0))
			{
			    if(GetPlayerVehicleID(playerid) == vmission[playerid])
			    {
				    DisablePlayerCheckpoint(playerid);
				    StartDialog(playerid,203);
				}
				else
				{
					SetMissionObj(playerid, "Reviens ici avec la voiture !");
				}
			}
			if(IsPlayerInRangeOfPoint(playerid,5.0,POSMISSION8))
			{
			    if(mission[playerid] == 8)
			    {
				    if(GetPlayerVehicleID(playerid) == vennemy[playerid])
				    {
					    DisablePlayerCheckpoint(playerid);
					    EndMission(playerid, 8);
					}
					else
					{
						SetMissionObj(playerid, "Reviens ici avec la voiture !");
					}
				}
				if(mission[playerid] == 9)
				{
				    if(GetPlayerVehicleID(playerid) == vmission[playerid])
				    {
					    DisablePlayerCheckpoint(playerid);
						PlayerTextDrawHide(playerid,TD_Obj[playerid]);
		                StartDialog(playerid,204);
					}
					else
					{
						SetMissionObj(playerid, "Reviens ici avec la voiture !");
					}
				}
				if(mission[playerid] == 10)
				{
				    DisablePlayerCheckpoint(playerid);
					StartDialog(playerid, 10);
					DestroyVehicle(vmission[playerid]);
				}
				if(mission[playerid] == 300)
				{
					if(GetPlayerVehicleID(playerid))
				    {
				        TogglePlayerControllable(playerid, false);
						StartDialog(playerid, 302);
					    DisablePlayerCheckpoint(playerid);
						new string[MAX_PLAYER_NAME];
						format(string, sizeof(string), "MC_%d", GetPlayerVirtualWorld(playerid));
						MC[playerid] = CreateNPC(string,119, 400.3, 2539.25, 16.5,240.0, GetPlayerVirtualWorld(playerid),0,0);
						FCNPC_EnterVehicle(MC[playerid], GetPlayerVehicleID(playerid), 1);
						SetPlayerCheckpoint(playerid,-79.0,1340.0,11.0,5.0);
						SetMissionObj(playerid, "Va au bar !");
					}
					else
					{
						SetMissionObj(playerid, "Reviens ici avec la voiture !");
					}
				}
				if(mission[playerid] == 301)
				{
				    DisablePlayerCheckpoint(playerid);
				    StartDialog(playerid, 303);
	       			TogglePlayerControllable(playerid, false);
				}
			}
			if(IsPlayerInRangeOfPoint(playerid, 5.0,-79.0,1340.0,11.0))
			{
			    if(mission[playerid] == 9)
				{
				    if(GetPlayerVehicleID(playerid) == vmission[playerid])
				    {
					    DisablePlayerCheckpoint(playerid);
						PlayerTextDrawHide(playerid,TD_Obj[playerid]);
					    MTD(playerid, "", 204, false);
					}
					else
					{
						SetMissionObj(playerid, "Reviens ici avec la voiture !");
					}
				}
			    if(mission[playerid] == 300)
				{
				    DisablePlayerCheckpoint(playerid);
	   				MTD(playerid, "", 302, false);
				}

			}
			if(IsPlayerInRangeOfPoint(playerid, 5.0,-182.0,1163.0,20.0))
			{
				SetPlayerCheckpoint(playerid, POSMISSION8, 5.0);
				SetMissionObj(playerid, "Donne le téléphone à Matthew !");
			}
			if(playerid == PE[value-1] && IsPlayerInRangeOfPoint(playerid,40.0,-2059.1,-756.5,32.0))
			{
				SubMessage(value-1, MSG_BLUE, "T'as pas réussi à tuer l'ennemi à temps !",5);
				FailMission(value-1);
			}
		}
	}
	if(IsPosSkydiveCP(playerid) != -1)
	{
		GameTextForPlayerEx(playerid, "~y~Mission réussie ! ~n~~w~$300", 5000, 0);
		GiveMoney(playerid, 300);
		DisablePlayerCheckpoint(playerid);
		PlayAudioStream(playerid, "http://xdev-team.tk/creations/sao/Audio/VC-Miscom.mp3");
		skydiving[playerid] = false;
	}

    if(gps[playerid]==true)
    {
		DisablePlayerCheckpointEx(playerid);
		gps[playerid]=false;
		if(robbing[playerid] == true) SubMessage(playerid,MSG_YELLOW,"Entrez dans la maison !",5);
	}

	if(IsPlayerInRangeOfPoint(playerid,5.0,BANKENTER))
	{
		SubMessage(playerid,MSG_YELLOW,"L'un de vous doit menacer le banquier en le pointant de son arme sans s'arrêter et l'autre devra descendre aux coffres pour récupérer l'argent de la banque.",10);
		DisablePlayerCheckpointEx(playerid);
	}
	return 1;
}
public OnPlayerLeaveCheckpoint(playerid)
{
    if(IsPlayerInRangeOfPoint(playerid,8.0,1677.85,-1002.87,671.00) && jbraquage[playerid] == true)
	{
		SubMessage(playerid,MSG_RED,"Tu as quitté le checkpoint et délaissé l'argent, fuyez !",5);
		EndBraquage();
		for(new i;i<2;i++)
		{
		    PlayAudioStream(braqueur[i], "http://xdev-team.tk/creations/sao/Audio/Drv11.mp3");
			if(braqueur[i] != playerid)
			{
				SubMessage(braqueur[i],MSG_BLUE,"~r~Ton coéquipier a décidé de partir sans l'argent ! Fuyez avant que les flics n'arrivent !",5);
			}
		}
		for(new i;i<MAX_PLAYERS;i++)
		{
			if(IsPlayerConnected(i))
			{
				if(IsPlayerInRangeOfPoint(i,100.0,BANKINFO))
				{
					PlayerPlaySound(i,6001,BANKINFO);
				}
			}
		}
	}
	if(cbraquage[playerid] != -1)
	{
		SubMessage(playerid,MSG_RED,"Tu as raté ton braquage !",5);
		EndCommBraquage(playerid);
	}
	if(robbing[playerid] == true && IsPosRobHouse(playerid))
	{
	    SubMessage(playerid,MSG_BLUE,"Tu es parti !",5);
	    FailRobHouse(playerid);
	}
    return 1;
}
public OnPlayerTakeDamage(playerid, issuerid, Float: amount, weaponid, bodypart)
{
	//HEADSHOT !
    if(bodypart == 9)
    {
        SetPlayerHealth(playerid, 0.0);
       	GameTextForPlayerEx(playerid,"~r~HEADSHOT !",3000,4);
       	GameTextForPlayerEx(issuerid,"~r~HEADSHOT !",3000,4);
    }
    return 1;
}
public FCNPC_OnTakeDamage(npcid, damagerid, weaponid, bodypart, Float:health_loss)
{

    new Float:health;
	health = FCNPC_GetHealth(npcid);
    if(bodypart == 9)
    {
		for(new i;i<6;i++)
		{
		    if(npcid == maf[damagerid][i])
		    {
		    	mafkilled[damagerid] ++;
		 	}
		}
        DestroyNPC(npcid);
		GameTextForPlayer(damagerid,"~r~HEADSHOT",3000,4);
	}
	else if(health < 10)
	{
		for(new i;i<6;i++)
		{
		    if(npcid == maf[damagerid][i])
		    {
		    	mafkilled[damagerid] ++;
		 	}
		}
		if(npcid == bcop[damagerid][0] || npcid == bcop[damagerid][1] || npcid == bcop[damagerid][2] || npcid == bcop[damagerid][3])
		{
			new value;
			value = STAR_KILLCOP;
			GivePlayerWantedLevel(damagerid,value);
		    DestroyNPC(npcid);
			if(!FCNPC_IsValid(bcop[damagerid][0]) && !FCNPC_IsValid(bcop[damagerid][1]))
			{
			    GivePlayerWantedLevel(damagerid,STAR_KILLALLCOPS);
				for(new i; i < 2; i++) bcop[damagerid][i] = -1;
			}
			if(!FCNPC_IsValid(bcop[damagerid][2]) && !FCNPC_IsValid(bcop[damagerid][3]))
			{
			    GivePlayerWantedLevel(damagerid,STAR_KILLALLCOPS);
			    for(new i=2;i < 4; i++) bcop[damagerid][i] = -1;
			}
		}
	}

	if(mafkilled[damagerid] == 6 && mission[damagerid] == 3) EndMission(damagerid, 3);
    return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	if(IsLogged[playerid] == false) return 1;
	if(!IsAdmin(playerid)) return NotRankedEnough(playerid);
	else
	{
	    new string[256];
	    aclickedid[playerid] = clickedplayerid;
	    format(string,sizeof(string),"{0080C0}Sanctionner %s",GetName(aclickedid[playerid]));
	    ShowMenuAdmin(playerid);
	}
	return 1;
}

public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
	if(!IsAdmin(playerid)) return 1;
	{
	 	new message[256+1];
	 	#if MAPANDREAS_ADRESS != MAP_ANDREAS_MODE_NONE
 		MapAndreas_FindZ_For2DCoord(fX, fY, fZ);
		#endif
		format(message, 256, "Tu as placé un marqueur en: %f %f %f", fX, fY, fZ+0.5);
		SubMessage(playerid, MSG_BLUE, message,5);
		if(IsPlayerInAnyVehicle(playerid))
  		{
	    	SetVehiclePos(GetPlayerVehicleID(playerid), fX, fY, fZ+0.5);
		}
		else
		{
			SetPlayerPosEx(playerid, fX, fY, fZ+0.5,GetPlayerInterior(playerid),GetPlayerVirtualWorld(playerid));
		}
	}
	return 1;
}

public OnPlayerEditAttachedObject( playerid, response, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ )
{
	SendClientMessage(playerid, WHITE, "Tu as édité l'objet");
	SetPlayerAttachedObject(playerid,index,modelid,boneid,fOffsetX,fOffsetY,fOffsetZ,fRotX,fRotY,fRotZ,fScaleX,fScaleY,fScaleZ);
	return 1;
}

YCMD:vrespawn(playerid,params[],help)
{
	if(!IsAdmin(playerid)) return NotRankedEnough(playerid);

	for(new i; i < MAX_VEHICLES; i++)
	{
	    if(GetVehicleModel(i) != 0) SetVehicleToRespawn(i);
	}
	SendClientMessageToAll(BLUE,"[ADMIN] Les véhicules ont été respawn.");
	printf("[ADMIN] %s a respawn tous les véhicules.",GetName(playerid));
	return 1;
}

YCMD:npccreate(playerid,params[],help)
{
	new string[256],Float:x,Float:y,Float:z,Float:a;
	if(!IsAdmin(playerid)) return NotRankedEnough(playerid);
	if(FCNPC_IsValid(NPCInfo[playerid][NpcID])) return SubMessage(playerid,MSG_RED,"Un NPC existe déjà tapez ~w~/delnpc",3);

	GetPlayerPos(playerid,x,y,z);
	GetPlayerFacingAngle(playerid,a);
	GetXYFront(x,y,a,5.0);

	NPCInfo[playerid][Skin] = GetPlayerSkin(playerid);
	NPCInfo[playerid][Interior] = GetPlayerInterior(playerid);
	NPCInfo[playerid][VirtualWorld] = GetPlayerVirtualWorld(playerid);
	NPCInfo[playerid][Weap] = 0;
	NPCInfo[playerid][Invulnerable] = false;
	NPCInfo[playerid][Weap] = 0;
	NPCInfo[playerid][Accuracy] = 1.0;
	NPCInfo[playerid][FocusID] = -2;
	NPCInfo[playerid][FollowID] = playerid;
	
	NPCInfo[playerid][NpcID] = CreateNPC(npcname[playerid], NPCInfo[playerid][Skin], x, y, z, -a, NPCInfo[playerid][VirtualWorld], NPCInfo[playerid][Weap], 9999);
	FCNPC_SetInterior(NPCInfo[playerid][NpcID],NPCInfo[playerid][Interior]);
	FCNPC_SetInvulnerable(NPCInfo[playerid][NpcID],NPCInfo[playerid][Invulnerable]);
	FCNPC_SetHealth(NPCInfo[playerid][NpcID],100.0);
	FCNPC_SetWeaponInfo(NPCInfo[playerid][NpcID],NPCInfo[playerid][Weap],-1,TimeWeap(NPCInfo[playerid][Weap]),6,NPCInfo[playerid][Accuracy]);
	format(string,sizeof(string),"[ADMIN] Vous avez créé un nouveau npc se nommant {ffffff}%s",params);
	SendClientMessage(playerid,BLUE,string);
	printf("[NPC] %s crée %s",GetName(playerid),params);
	
	return 1;
}

YCMD:delnpc(playerid,params[],help)
{
	if(!IsAdmin(playerid)) return NotRankedEnough(playerid);

	DestroyNPC(NPCInfo[playerid][NpcID]);
	SendClientMessage(playerid,BLUE,"[ADMIN] NPC détruit !");
	NPCInfo[playerid][NpcID] = -1;
	NPCInfo[playerid][FollowID] = -1;
	NPCInfo[playerid][FocusID] = -1;
	return 1;
}

YCMD:npcmenu(playerid,params[],help)
{
	if(!IsAdmin(playerid)) return NotRankedEnough(playerid);
	if(isnull(params)) return SendClientMessage(playerid,RED,"Usage : /npcmenu [Nom du NPC]");
	if(MenuNPC[playerid] == false)
	{
		format(npcname[playerid],MAX_PLAYER_NAME,"%s",params);
		ShowNPCMenu(playerid);
		SelectTextDraw(playerid,RED);
	}
	else HideNPCMenu(playerid);
	return 1;
}

YCMD:submsg(playerid,params[],help)
{
	if(!IsAdmin(playerid)) return NotRankedEnough(playerid);
	new text[128], index;
	if(sscanf(params,"ds[128]",index,text)) return SendClientMessage(playerid,RED,"Usage : /submsg [Index] [Message]");
	SubMessage(playerid,index,text,5);
	return 1;
}

YCMD:sdrive(playerid,params[],help)
{
	if(!IsAdmin(playerid)) return NotRankedEnough(playerid);
	if(isnull(params)) return SendClientMessage(playerid,RED,"Usage : /sdrive [ID / Pseudo]");
	new id = ReturnUser(params);
	if(!IsPlayerConnected(id)) return SubMessage(playerid,MSG_RED,"Ce joueur n'est pas connecté !",5);
	new string[256];
	if(sdrive[id] == false)
	{
		format(string,sizeof(string),"[ADMIN] Vous avez donné la super conduite à {ffffff}%s",GetName(id));
		SendClientMessage(id,BLUE,"[ADMIN] L'Admin t'a donné du boost, des sauts et  des freins utilisables avec Clic, Ctrl et é.");
		SendClientMessage(playerid,BLUE,string);
		sdrive[id] = true;
		format(string,sizeof(string),"[ADMIN] %s a donné la super conduite à %s",GetName(playerid),GetName(id));
	}
	else
	{
		format(string,sizeof(string),"[ADMIN] Vous avez retiré la super conduite à {ffffff}%s",GetName(id));
		SendClientMessage(id,BLUE,"[ADMIN] L'Admin t'a retiré les boosts, les sauts et les freins.");
		SendClientMessage(playerid,BLUE,string);
		sdrive[id] = false;
		format(string,sizeof(string),"[ADMIN] %s a retiré la super conduite de %s",GetName(playerid),GetName(id));
	}
	print(string);
	return 1;
}

YCMD:clearchat(playerid,params[],help)
{
    if(!IsAdmin(playerid)) return NotRankedEnough(playerid);

    for(new i; i < 100; i++) SendClientMessageToAll(0,"");
    SendClientMessageToAll(BLUE,"[ADMIN] Le chat a été nettoyé !");
    return 1;
}
YCMD:setwanted(playerid,params[],help)
{
	new id,tmp[MAX_PLAYER_NAME],value;
	if(!IsAdmin(playerid)) return NotRankedEnough(playerid);
	if(sscanf(params,"s["#MAX_PLAYER_NAME"]d",tmp,value)) return SendClientMessage(playerid,RED,"Usage : /setwanted [ID / Pseudo du joueur] [Etoiles]");
	id = ReturnUser(tmp);
	if(!IsPlayerConnected(id)) return SubMessage(playerid,MSG_RED,"Ce joueur n'est pas connecté !",5);
	if(value < 0 || value > 6) return SubMessage(playerid,MSG_RED,"Valeur invalide !",5);
	new string[256];
	format(string,sizeof(string),"[ADMIN] L'Admin t'a mis {ffffff}%d {0080C0}étoile(s)",value);
	SendClientMessage(id,BLUE,string);
	format(string,sizeof(string),"[ADMIN] Vous avez mis {ffffff}%s {0080C0}à {ffffff}%d {0080C0}étoiles",GetName(id),value);
	SendClientMessage(playerid,BLUE,string);
	SetWantedLevel(id,value);
	return 1;
}
YCMD:reloadrob(playerid,params[],help)
{
	if(!IsAdmin(playerid)) return NotRankedEnough(playerid);
	if(isnull(params)) return SendClientMessage(playerid,RED,"Usage : /reloadrob [ID / Pseudo]");
	new id = ReturnUser(params);
	if(!IsPlayerConnected(id)) return SubMessage(playerid,MSG_RED,"Ce joueur n'est pas connecté !",3);

	new string[256];
 	timerob[id] = -1;
	KillTimer(trob[id]);
	nextrob[id] = true;
	SubMessage(id,MSG_BLUE,"Vous pouvez maintenant cambrioler !",3);
	format(string,sizeof(string),"[ADMIN] {ffffff}%s {0080C0}peut maintenant cambrioler !",GetName(id));
	SendClientMessage(playerid,BLUE,string);
	printf("[ADMIN] %s a donné la possibilité à %s de cambrioler.",GetName(playerid),GetName(id));

	return 1;
}
YCMD:cd(playerid,params[],help)
{
    if(!IsAdmin(playerid)) return NotRankedEnough(playerid);
	new time;
	if(sscanf(params,"d",time)) return SendClientMessage(playerid,RED,"Usage : /cd [Temps en secondes]");
	if(time <= 0) return SubMessage(playerid,MSG_RED,"Temps invalide !",5);

	SetCountDown(time,false);
	printf("[ADMIN] Countdown de %d secondes lancé par %s",time,GetName(playerid));
	SendClientMessage(playerid,BLUE,"[ADMIN] Countdown lancé !");
	return 1;
}

YCMD:infos(playerid,params[],help)
{
    ShowPlayerDialog(playerid,33,DIALOG_STYLE_LIST,"{ffffff}Menu d'Aide","\t\t{00ff00}Infos utiles\n\t\t{008000}Nouveautés\n\t\t{8000FF}Téléphone\n\t\t{0000ff}Biens à acheter\n\t\t{ffff00}À propos de l'argent\n\t\t{FF8000}Occupations\n\t\t{ff0000}Règles","CHOISIR","QUITTER");
	return 1;
}

YCMD:aide(playerid,params[],help)
{
	Command_ReProcess(playerid,"/infos",help);
	return 1;
}

YCMD:appeler(playerid,params[],help)
{
    if(PlayerInfo[playerid][pLevel] < 10) return SubMessage(playerid,MSG_RED,"Tu n'as personne à appeler !",5);
    if(!IsPlayerFree(playerid)) return SubMessage(playerid,MSG_RED,"Tu es occupé !",5);

    ShowPlayerDialog(playerid,46,DIALOG_STYLE_LIST,"Appeler un personnage","Matthew","Appeler","Quitter");
	return 1;
}

YCMD:robhouse(playerid,params[],help)
{
    if(!IsPlayerFree(playerid)) return SubMessage(playerid,MSG_RED,"T'es occupé !",5);
    if(IsPlayerInAnyVehicle(playerid)) return SubMessage(playerid,MSG_RED,"T'es dans un véhicule !",5);
    if(GetPlayerInterior(playerid) != 0) return SubMessage(playerid,MSG_RED,"T'es en intérieur !",5);
    if(timerob[playerid] != -1)
    {
		new msg[256];
		format(msg,sizeof(msg),"~r~Il faut attendre encore %d minutes !",10 - timerob[playerid]);
		SubMessage(playerid,MSG_BLUE,msg,5);
		return 1;
	}
    new housesfree;
    for(new i = 1; i < MAX_HOUSES ; i++)
    {
		if(HouseInfo[i][Type] == 2 && i != PlayerInfo[playerid][pMaison]) housesfree ++;
	}
	if(housesfree == 0) return SubMessage(playerid,MSG_RED,"Aucune maison n'est cambriolable !",5);
	loop_random:
	new value = random(housesfree + 1);
	if(value == 0) goto loop_random;
	new string[256];
	housesfree = 0;
	new houseid;
	for(new i=1; i < MAX_HOUSES ; i++)
	{
	    if(HouseInfo[i][Type] == 2 && i != PlayerInfo[playerid][pMaison])
	    {
			housesfree ++;
			if(housesfree == value)
			{
				houseid = i;
				break;
			}
		}
	}
	new Float:x,Float:y,Float:z,Float:a;
	GetPlayerFacingAngle(playerid,a);
	GetPlayerPos(playerid,x,y,z);
	vmission[playerid] = CreateVehicle(498,x,y,z,a,-1,-1,-1);
	PutPlayerInVehicle(playerid,vmission[playerid],0);
	robbing[playerid] = true;
	gps[playerid] = true;
	housefocus[playerid] = houseid;
	SetPlayerCheckpoint(playerid,HouseInfo[houseid][X1],HouseInfo[houseid][Y1],HouseInfo[houseid][Z1],3.0);
	GivePlayerWeapon(playerid,5,1);
	new hours,time,seconds;
	gettime(hours,time,seconds);
	time = 0;
	seconds = 0;
	format(string,sizeof(string),"Allez cambrioler la maison de ~w~%s ~y~indiquée sur votre radar.",proprio[houseid]);
	if(hour >= 19 || hour <=5) strcat(string,"~n~Si tu réussis ton cambriolage, tu gagnera ~w~50 pourcents ~y~de la somme totale en plus !");
	SubMessage(playerid,MSG_YELLOW,string,10);
	return 1;
}

YCMD:mstop(playerid,params[],help)
{
    if(IsPlayerFree(playerid)) return SubMessage(playerid,MSG_RED,"Tu n'es pas occupé !",5);
    if(mission[playerid] != 0)
	{
		FailMission(playerid);
		SpawnPlayerEx(playerid);
		return 1;
	}
	if(skydiving[playerid] == true)
    {
    	SubMessage(playerid,MSG_RED,"Tu as échoué ta mission skydive !",5);
	    GameTextForPlayerEx(playerid, "~r~Échec de la mission !", 5000, 0);
	    DisablePlayerCheckpointEx(playerid);
		skydiving[playerid] = false;
		return 1;
	}
	if(robbing[playerid] == true)
	{
		trob[playerid] = SetTimerEx("RobTimer",60000,true,"i",playerid);
		timerob[playerid] = 0;
	    nextrob[playerid] = false;
		FailRobHouse(playerid);
		return 1;
	}
	if(InAmmu[playerid] == true)
	{
	    SubMessage(playerid,MSG_BLUE,"Tu quittes le stand de tir !",5);
	    EndAmmu(playerid);
	    return 1;
	}
    return 1;
}

YCMD:lc(playerid,params[],help)
{
    if(!IsAdmin(playerid)) return NotRankedEnough(playerid);

	SetPlayerPosEx(playerid,-753.5265,500.1738,1371.9109,0, GetPlayerVirtualWorld(playerid));
	SetPlayerFacingAngle(playerid,257);
	return 1;
}

YCMD:v(playerid,params[],help)
{
	new model = strval(params);
    if(!IsAdmin(playerid)) return NotRankedEnough(playerid);
    if(isnull(params)) return SendClientMessage(playerid,RED,"Usage : /v [Nom ou Modèle du véhicule]");
    new Float:x,Float:y,Float:z,Float:a,string[256];
    GetPlayerPos(playerid,x,y,z);
	GetPlayerFacingAngle(playerid,a);
    if(strval(params) != 0)
    {
        if(model < 400 || model > 611) return SubMessage(playerid,MSG_RED,"Modèle invalide !",5);

        format(string,sizeof(string),"[ADMIN] Vous avez spawn une {ffffff}%s.",VehicleNames[model - 400]);
	}
	else
	{
	    model =	GetVehicleModelByName(params);
	    format(string,sizeof(string),"[ADMIN] Vous avez spawn une {ffffff}%s.",VehicleNames[model - 400 ]);
	}
	if(model == 0) return SubMessage(playerid,MSG_RED,"Nom invalide",5);
	SendClientMessage(playerid,BLUE,string);
	if(GetVehicleModel(aveh[playerid]) != 0) DestroyVehicle(aveh[playerid]);
	aveh[playerid] = CreateVehicle(model,x,y,z,a,-1,-1,-1);
	SetVehicleVirtualWorld(aveh[playerid],GetPlayerVirtualWorld(playerid));
	LinkVehicleToInterior(aveh[playerid],GetPlayerInterior(playerid));
	PutPlayerInVehicle(playerid,aveh[playerid],0);
	format(string,sizeof(string),"~h~~w~%s~n~~h~~w~ID:~h~~r~%d",VehicleNames[model - 400],model);
	GameTextForPlayer(playerid,string,2500,1);
	return 1;
}

YCMD:acmds(playerid,params[],help)
{
    if(!IsAdmin(playerid)) return NotRankedEnough(playerid);

	ShowPlayerDialog(playerid,36,DIALOG_STYLE_LIST,"Commandes","{0080C0}\t\tSanctions\n\t\t{0080C0}Gestion du serveur\n\t\t{0080C0}Gestion joueur\n\t\t{0080C0}Téléportations\n\t\t{0080C0}Gestion véhicule\n","Ok","Retour");
	return 1;
}

YCMD:invisible(playerid,params[],help)
{
	if(!IsAdmin(playerid)) return NotRankedEnough(playerid);
	if(isnull(params)) return SendClientMessage(playerid,RED,"Usage : /invisible [Nom / ID Joueur]");
	new id;
	id = ReturnUser(params);
	if(!IsPlayerConnected(playerid)) return SubMessage(playerid,MSG_RED,"Ce joueur n'est pas connecté !",5);

	SetPlayerColor(id,0x0080C000);
	SendClientMessage(id,BLUE,"[ADMIN] L'Admin t'a rendu {ffffff}invisible.");
	return 1;
}

YCMD:visible(playerid,params[],help)
{
	if(!IsAdmin(playerid)) return NotRankedEnough(playerid);
	if(isnull(params)) return SendClientMessage(playerid,RED,"Usage : /invisible [Nom / ID Joueur]");
	new id;
	id = ReturnUser(params);
	if(!IsPlayerConnected(playerid)) return SubMessage(playerid,MSG_RED,"Ce joueur n'est pas connecté !",5);

	SetPlayerColor(id,0x0080C0FF);
	SendClientMessage(id,BLUE,"[ADMIN] L'Admin t'a rendu {ffffff}visible.");
	return 1;
}

YCMD:magicgun(playerid,params[],help)
{
	if(!IsAdmin(playerid)) return NotRankedEnough(playerid);

	if(magicgun[playerid] == false)
	{
	    SendClientMessage(playerid,BLUE,"[ADMIN] Vous êtes équipé d'un pistolet magique.");
	    SendClientMessage(playerid,BLUE,"Vous aurez des informations sur tout ce que vous touchez.");
		magicgun[playerid] = true;
	}
	else
	{
	    SendClientMessage(playerid,RED,"Au revoir pistolet magique :(");
		magicgun[playerid] = false;
	}
	return 1;
}

YCMD:tel(playerid,params[],help)
{
    if(Phone[playerid] == false)
    {
		ShowPhoneTD(playerid);
	}
	else
	{
	    HidePhoneTD(playerid);
	}
	return 1;
}

YCMD:park(playerid,params[],help)
{
    if(!IsPlayerInVehicle(playerid,jvehicle[playerid])) return SubMessage(playerid,MSG_RED,"T'es pas dans ton véhicule !",5);
    {
        new INI:File = INI_Open(UserPath(playerid));
		GetVehiclePos(jvehicle[playerid],VehicleInfo[playerid][X],VehicleInfo[playerid][Y],VehicleInfo[playerid][Z]);
        GetVehicleZAngle(jvehicle[playerid],VehicleInfo[playerid][A]);
        INI_SetTag(File,"Veh");
        INI_WriteFloat(File,"X1",VehicleInfo[playerid][X]);
        INI_WriteFloat(File,"Y1",VehicleInfo[playerid][Y]);
        INI_WriteFloat(File,"Z1",VehicleInfo[playerid][Z]);
        INI_WriteFloat(File,"A1",VehicleInfo[playerid][A]);
        INI_Close(File);
        DestroyVehicle(jvehicle[playerid]);
        jvehicle[playerid] = CreateVehicle(VehicleInfo[playerid][Model],VehicleInfo[playerid][X],VehicleInfo[playerid][Y],VehicleInfo[playerid][Z],VehicleInfo[playerid][A],VehicleInfo[playerid][Color1],VehicleInfo[playerid][Color2],-1);
        ChangeVehicleColor(jvehicle[playerid],VehicleInfo[playerid][Color1],VehicleInfo[playerid][Color2]);
        SetVehiclePos(jvehicle[playerid],VehicleInfo[playerid][X],VehicleInfo[playerid][Y],VehicleInfo[playerid][Z]);
        SetVehicleZAngle(jvehicle[playerid],VehicleInfo[playerid][A]);
        if(VehicleInfo[playerid][PaintJob] != -1) ChangeVehiclePaintjob(jvehicle[playerid],VehicleInfo[playerid][PaintJob]);
		for(new i2;i2<14;i2++)
        {
            if(VehicleTuning[playerid][i2] != 0)
            {
                AddVehicleComponent(jvehicle[playerid],VehicleTuning[playerid][i2]);
			}
		}
		SubMessage(playerid,MSG_BLUE,"Ton véhicule sera désormais garé ici !",5);
	}
	return 1;
}

YCMD:acttp(playerid,params[],help)
{
    new string[256],actor;
    if(!IsAdmin(playerid)) return NotRankedEnough(playerid);
	{
	    if(sscanf(params,"d",actor)) return SendClientMessage(playerid,RED,"USAGE: /acttp [ID Acteur]");
	    {
	        if(!IsValidActor(actor)) return SubMessage(playerid,MSG_RED,"Acteur invalide !",5);
			if(IsActorInvulnerable(actor) && IsValidActor(actor)) return SubMessage(playerid,MSG_RED,"Acteur invalide !",5);
			{
				new Float:x,Float:y,Float:z;
				GetActorPos(actor,x,y,z);
				SetPlayerPos(playerid,x+2,y+2,z);
				format(string,sizeof(string),"[ADMIN] Tu as été téléporté à l'acteur %d",actor);
				SendClientMessage(playerid,BLUE,string);
			}
		}
	}
	return 1;
}

YCMD:vcmds(playerid,params[],help)
{
    if(!IsAdmin(playerid)) return NotRankedEnough(playerid);
    new string[256];
	if(vcmds[playerid] == false)
	{
	    string = "[ADMIN] Vous voyez maintenant les commandes !";
		vcmds[playerid] = true;
	}
	else
	{
	    string = "[ADMIN] Vous ne voyez plus les commandes !";
	    vcmds[playerid] = false;
	}
	SendClientMessage(playerid,BLUE,string);
	return 1;
}

YCMD:actor(playerid,params[],help)
{
    if(!IsAdmin(playerid)) return NotRankedEnough(playerid);
    {
		new createactor[128],animation[128],result[256];
		format(result,sizeof(result),"%s",params);
		new sendername[MAX_PLAYER_NAME];
		GetPlayerName(playerid, sendername, sizeof(sendername));
		ServActor++;
		new INI:File = INI_Open(SPATH);
		INI_SetTag(File,"data");
		INI_WriteInt(File,"ServActor",ServActor);
		INI_Close(File);
		new msg[1024];
		new File:file;
		if(ServActor == 1)
		{
		    strins(msg,"\tnew actor[MAX_ACTORS];\n",0);
		}
		new Float:x,Float:y,Float:z,Float:a;
		GetPlayerPos(playerid,x,y,z);
		GetPlayerFacingAngle(playerid,a);
		format(createactor, sizeof(createactor), "\tactor[%d] = CreateActor(%d,%f,%f,%f,%f); // %s\n",ServActor - 1,GetPlayerSkin(playerid),x,y,z,a,result);
		strcat(msg,createactor);
		new bibli[32],anim[32];
		GetAnimationName(GetPlayerAnimationIndex(playerid),bibli,32,anim,32);
		if(GetPlayerAnimationIndex(playerid))
		{
			if(strcmp("IDLE_STANCE",anim))
		    {
			    format(animation,sizeof(animation),"\tApplyActorAnimationEx(actor[%d],\"%s\",\"%s\",4.0,1,1,1,1,0); // %s\n",ServActor - 1,bibli,anim,result);

				strcat(msg,animation);
			}
		}
		if(GetPlayerVirtualWorld(playerid) != 0)
		{
		    new vw[256];
		    format(vw,sizeof(vw),"\tSetActorVirtualWorld(actor[%d],%d);\n\n",ServActor - 1,GetPlayerVirtualWorld(playerid));
		    strcat(msg,vw);
		}
		else
		{
		    strcat(msg,"\n");
		}
		file = fopen("/actors.txt",io_append);
		fwrite(file,msg);
		fclose(file);
		SendClientMessage(playerid,BLUE,"[ADMIN] Acteur enregistré !");
		if(IsValidActor(actortest[playerid])) DestroyActor(actortest[playerid]);
		actortest[playerid] = CreateActor(GetPlayerSkin(playerid),x,y,z,a);
		ApplyActorAnimationEx(actortest[playerid],bibli,anim,4.0,1,1,1,1,0);
	}
	return 1;
}

YCMD:cam(playerid,params[],help)
{
    if(!IsAdmin(playerid)) return NotRankedEnough(playerid);
    {
		SetCameraBehindPlayer(playerid);
	}
	return 1;
}

YCMD:am(playerid,params[],help)
{
    if(!IsAdmin(playerid)) return NotRankedEnough(playerid);
    {
        new string[128];
        format(string, sizeof(string), "ID Mission: %d", mission[playerid]);
		SendClientMessage(playerid, BLUE, string);
	}
	return 1;
}

YCMD:hud(playerid,params[],help)
{
	PlayerTextDrawHide(playerid,TD_Obj[playerid]);
	PlayerTextDrawHide(playerid,TD_Dialog[playerid]);
	for(new i ; i < 3 ; i++) PlayerTextDrawHide(playerid,TDMsg_Sub[playerid][i]);
    TextDrawHideForPlayer(playerid, Underline);
	TextDrawHideForPlayer(playerid, Title);
	TextDrawHideForPlayer(playerid, KMH);
	TextDrawHideForPlayer(playerid, VehicleName[playerid]);
	TextDrawHideForPlayer(playerid, VehicleSpeed[playerid]);
	return 1;
}

YCMD:stopradio(playerid,params[],help)
{
	if(!IsPlayerFree(playerid))
	{
	    SubMessage(playerid, MSG_RED, "Vous ne pouvez pas couper les musiques d'ambiance en mission !",5);
	}
	else
	{
		StopAudioStreamForPlayer(playerid);
	}
	return 1;
}

YCMD:resetactors(playerid,params[],help)
{
	if(!IsAdmin(playerid)) return NotRankedEnough(playerid);
	{
		ServActor = 0;
	    fremove("/actors.txt");
		new INI:File = INI_Open(SPATH);
		INI_SetTag(File,"data");
		INI_WriteInt(File,"ServActor",ServActor);
		INI_Close(File);
		SendClientMessage(playerid,BLUE,"[ADMIN] Acteurs supprimés avec succès !");
	}
	return 1;
}

YCMD:setcompteur(playerid,params[],help)
{
    new string[256],value;
    if(!IsAdmin(playerid)) return NotRankedEnough(playerid);
    {
        if(sscanf(params,"d",value))
        {

			format(string,sizeof(string),"Info: Il y a actuellement %d acteurs dans le fichier.",ServActor-1);
		    SendClientMessage(playerid,RED,"USAGE: /setcompteur [Valeur]");
		    SendClientMessage(playerid,BLUE,string);
		    return 1;
		}
		if(value <= 0) return SubMessage(playerid,MSG_RED,"Valeur incorrecte !",5);
		{
		    ServActor = value;
			new INI:File = INI_Open(SPATH);
			INI_SetTag(File,"data");
			INI_WriteInt(File,"ServActor",ServActor);
			INI_Close(File);
			format(string,sizeof(string),"[ADMIN] Compteur d'acteurs mis à %d",ServActor);
			SendClientMessage(playerid,BLUE,string);
		}
	}
	return 1;
}

YCMD:balance(playerid,params[],help)
{
    new string[256],msg[256];
    string = "\t\tMontant des balances sur le serveur\n\n";
	strcat(string,"{FF8040}Caisse du burger-shot : {ffff00}$%d\n");
	strcat(string,"{FF8040}Caisse du cluckin-bell : {ffff00}$%d\n");
	strcat(string,"{FF8040}Caisse de la pizzéria : {ffff00}$%d\n");
	strcat(string,"{FF8040}Caisse de la banque : {ffff00}$%d\n");
	format(msg,sizeof(msg),string,MoneyResto[BURGER],MoneyResto[CLUCKIN],MoneyResto[PIZZA],MoneyBanque);
	ShowPlayerDialog(playerid,30000,DIALOG_STYLE_MSGBOX,"Balances",msg,"Ok","Quitter");
	return 1;
}

YCMD:aint(playerid,params[],help)
{
    if(!IsAdmin(playerid)) return NotRankedEnough(playerid);
    {
        new interior,id,player[MAX_PLAYER_NAME];
        if(sscanf(params,"sd",player,interior)) return SendClientMessage(playerid,RED,"USAGE: /aint [ID Joueur] [ID Intérieur]");
        {
            id = ReturnUser(player);
            if(!IsPlayerConnected(id)) return SubMessage(playerid,MSG_RED,"Ce joueur n'est pas connecté !",5);

            new vehicleid = GetPlayerVehicleID(id);
            new string[256];
			format(string,sizeof(string),"[ADMIN] L'intérieur de %s est de maintenant %d",GetName(id),interior);
			SendClientMessage(playerid,BLUE,string);
			format(string,sizeof(string),"[ADMIN] Intérieur défini à %d",interior);
			SendClientMessage(id,BLUE,string);
			if(IsPlayerInAnyVehicle(playerid)) LinkVehicleToInterior(vehicleid,interior);
			SetPlayerInterior(id,interior);
			PutPlayerInVehicle(id,vehicleid,0);
		}
    }
    return 1;
}

YCMD:avw(playerid,params[],help)
{
    if(!IsAdmin(playerid)) return NotRankedEnough(playerid);
    {
        new tmp[MAX_PLAYER_NAME],vw,id;
        if(sscanf(params,"s["#MAX_PLAYER_NAME"]d",tmp,vw)) return SendClientMessage(playerid,RED,"USAGE: /avw [ID Joueur] [ID Virtual World]");
        {
            id = ReturnUser(tmp);
            if(!IsPlayerConnected(id)) return SubMessage(playerid,MSG_RED,"Ce joueur n'est pas connecté !",5);

			new vehicleid = GetPlayerVehicleID(id);
            new string[256];
			format(string,sizeof(string),"[ADMIN] Le monde virtuel de %s est de maintenant %d",GetName(id),vw);
			SendClientMessage(playerid,BLUE,string);
			format(string,sizeof(string),"[ADMIN] L'admin a défini ton monde virtuel à %d",vw);
			SendClientMessage(id,BLUE,string);
			if(IsPlayerInAnyVehicle(playerid)) SetVehicleVirtualWorld(vehicleid,vw);
			SetPlayerVirtualWorld(id,vw);
			PutPlayerInVehicle(id,vehicleid,0);
		}
    }
    return 1;
}

YCMD:loadrace(playerid,params[],help)
{
    if(!IsAdmin(playerid)) return NotRankedEnough(playerid);
    if(RaceLoaded == true) return SubMessage(playerid,MSG_RED,"Une course se déroule déjà !",5);
	new msg[1024],string[256];
    for(new i=1; i <= Races ; i++)
	{
		format(string,sizeof(string),RACEPATH,i);
		INI_ParseFile(string,"LoadPlayerRaces_%s",false, true, playerid, false);
		format(string,sizeof(string),"{ffffff}[{0080C0}%d{ffffff}] - '{008000}%s{ffffff}'\n",i,RacePlayer[playerid][RaceName]);
		strcat(msg,string);
	}
	ShowPlayerDialog(playerid,44,DIALOG_STYLE_LIST,"Liste des courses",msg,"Lancer","Quitter");
	return 1;
}

YCMD:join(playerid,params[],help)
{
    if(!IsPlayerFree(playerid)) return SubMessage(playerid,MSG_RED,"T'es occupé !",5);
    if(RaceLoaded == false) return SubMessage(playerid,MSG_RED,"Aucune course n'est lancée !",5);
    if(IsRaceLoaded == true) return SubMessage(playerid,MSG_RED,"La course a déjà commencé !",5);
    if(IsPlayerInAnyVehicle(playerid)) return SubMessage(playerid,MSG_RED,"T'es dans un véhicule !",5);

    racetotal ++;
	SendClientMessage(playerid,BLUE,"[ADMIN] Attendez le départ de la course...");
	new string[256];
	format(string,sizeof(string),"{ffffff}%s {0080C0}a rejoint la course.",GetName(playerid));
	SendClientMessage(playerid,BLUE,string);
	SetPlayerVirtualWorld(playerid,1001);
	SetPlayerInterior(playerid,0);
	cpplayer[playerid] = 0;
	InRace[playerid] = true;
	new index = cpplayer[playerid];
	if(typecar >= 400)
	{
		vmission[playerid] = CreateVehicle(typecar,PosRace[index + 1][0],PosRace[index + 1][1],PosRace[index + 1][2],Angle,-1,-1,0,0);
		SetVehicleVirtualWorld(vmission[playerid],1001);
		PutPlayerInVehicle(playerid,vmission[playerid],0);
		AddVehicleComponent(vmission[playerid], 1010);
	}
	else SetPlayerPos(playerid,PosRace[index + 1][0],PosRace[index + 1][1],PosRace[index + 1][2]);

	SetPlayerRaceCheckpoint(playerid,0,PosRace[index + 1][0],PosRace[index + 1][1],PosRace[index + 1][2],PosRace[index + 2][0],PosRace[index + 2][1],PosRace[index + 2][2],5.0);
	TogglePlayerControllable(playerid,false);
	return 1;
}

YCMD:leave(playerid,params[],help)
{
    if(InRace[playerid] == false) return SubMessage(playerid,MSG_RED,"T'es dans aucune course !",5);

    EndRace(playerid);
    SubMessage(playerid,MSG_RED,"T'as quitté la course !",5);
	return 1;
}


YCMD:setrace(playerid,params[],help)
{
	new value = strval(params);
	if(!IsAdmin(playerid)) return NotRankedEnough(playerid);
	if(isnull(params)) return SendClientMessage(playerid,RED,"Usage : /setrace [Nombre]");
	if(value < 0) return SubMessage(playerid,MSG_RED,"Nombre invalide !",5);

	Races = value;
	printf("[ADMIN] %s a mis le nombre de courses à %d",value);
	SendClientMessage(playerid,BLUE,"[ADMIN] Nombre de courses modifié !");
	return 1;
}

YCMD:rmenu(playerid,params[],help)
{
    if(!IsAdmin(playerid)) return NotRankedEnough(playerid);
	if(BuildingRace[playerid] == false) return SubMessage(playerid,MSG_RED,"Vous ne construisez aucune course !",5);

	if(MenuREditor[playerid] == false) ShowTDRaceEditor(playerid);
	else HideTDRaceEditor(playerid);

	return 1;
}

YCMD:buildrace(playerid,params[],help)
{
    if(!IsAdmin(playerid)) return NotRankedEnough(playerid);

    ShowPlayerDialog(playerid,38,DIALOG_STYLE_LIST,"Panel Course","\t\tConstruire une nouvelle course\n\t\tModifier une course","Choisir","Quitter");
	return 1;
}

YCMD:setcp(playerid,params[],help)
{
    if(!IsAdmin(playerid)) return NotRankedEnough(playerid);
    if(BuildingRace[playerid] == false) return SubMessage(playerid,MSG_RED,"Vous ne construisez aucune course !",5);
    new string[256],Float:x,Float:y,Float:z,Float:a;
    GetPlayerPos(playerid,x,y,z);
    GetPlayerFacingAngle(playerid,a);
    format(string,sizeof(string),RACEPATH,racebuilding[playerid]);
    if(NumCPBuilding[playerid] == RacePlayer[playerid][CPMax]) RacePlayer[playerid][CPMax]++;
	NumCPBuilding[playerid] ++;

	new INI:File = INI_Open(string);
	INI_SetTag(File,"data");
	if(NumCPBuilding[playerid] == 1)
	{
		INI_WriteFloat(File,"Angle",a);
	}
	INI_WriteInt(File,"CP",RacePlayer[playerid][CPMax]);
	format(string,sizeof(string),"CPX_%d",NumCPBuilding[playerid]);
	INI_WriteFloat(File,string,x);
	format(string,sizeof(string),"CPY_%d",NumCPBuilding[playerid]);
	INI_WriteFloat(File,string,y);
	format(string,sizeof(string),"CPZ_%d",NumCPBuilding[playerid]);
	INI_WriteFloat(File,string,z);
	INI_Close(File);
	SendClientMessage(playerid,BLUE,"[ADMIN] Checkpoint enregistré !");
	return 1;
}

YCMD:angle(playerid,params[],help)
{
	if(!IsAdmin(playerid)) return NotRankedEnough(playerid);
	if(BuildingRace[playerid] == false) return SubMessage(playerid,MSG_RED,"Vous ne construisez aucune course !",5);
	new Float:a,string[256];
	if(!IsPlayerInAnyVehicle(playerid)) GetPlayerFacingAngle(playerid,a);
	else GetVehicleZAngle(GetPlayerVehicleID(playerid),a);
	format(string,sizeof(string),RACEPATH,racebuilding[playerid]);
	new INI:File = INI_Open(string);
	INI_SetTag(File,"data");
	INI_WriteFloat(File,"Angle",a);
	INI_Close(File);
	RacePlayer[playerid][Ang] = a;
	SendClientMessage(playerid,BLUE,"[ADMIN] L'angle de départ a été modifié !");
	return 1;
}

YCMD:stopbuild(playerid,params[],help)
{
    if(!IsAdmin(playerid)) return NotRankedEnough(playerid);
    if(BuildingRace[playerid] == false) return SubMessage(playerid,MSG_RED,"Vous ne construisez aucune course !",5);

    NumCPBuilding[playerid] = 0;
    BuildingRace[playerid] = false;
    racebuilding[playerid] = 0;
	SubMessage(playerid,MSG_RED,"Vous arrêtez de construire une course !",5);
	return 1;
}

YCMD:rstart(playerid,params[],help)
{
    if(IsRaceLoaded == true) return SubMessage(playerid,MSG_RED,"La course est déjà lancée !",5);
	if(RaceLoaded == false) return SubMessage(playerid,MSG_RED,"Aucune course n'est en cours !",5);
	if(racetotal != 0)
	{
		SendClientMessageToAll(BLUE,"[ADMIN] La course vient d'être lancée !");
		for(new i; i < MAX_PLAYERS; i++)
		{
		    if(IsPlayerConnected(i) && InRace[i] == true)
		    {
				SendClientMessage(i,BLUE,"[ADMIN] C'est parti !");
				TogglePlayerControllable(i,true);
				SetPlayerRaceCheckpoint(playerid,0,PosRace[1][0],PosRace[1][1],PosRace[1][2],PosRace[2][0],PosRace[2][1],PosRace[2][2],5.0);
			}
		}
		IsRaceLoaded = true;
		KillTimer(timercd);
	}
	return 1;
}

YCMD:rstop(playerid,params[],help)
{
    if(!IsAdmin(playerid)) return NotRankedEnough(playerid);
    if(RaceLoaded == false) return SubMessage(playerid,MSG_RED,"Aucune course n'est lancée !",5);

    IsRaceLoaded = false;
    RaceLoaded = false;
	for(new i; i < MAX_PLAYERS ; i++)
	{
	    if(IsPlayerConnected(i) && InRace[i] == true)
	    {
	        EndRace(i);
		}
	}
	KillTimer(timercd);
    SendClientMessageToAll(BLUE,"[ADMIN] La course a été arrêtée par l'Admin.");
    return 1;
}

YCMD:getvw(playerid,params[],help)
{
    if(!IsAdmin(playerid)) return NotRankedEnough(playerid);
    {
        new string[256];
        format(string,sizeof(string),"[ADMIN] Tu es dans le monde virtuel %d",GetPlayerVirtualWorld(playerid));
        SendClientMessage(playerid,LIGHTBLUE,string);
	}
	return 1;
}

YCMD:async(playerid,params[],help)
{
    if(!IsAdmin(playerid)) return NotRankedEnough(playerid);
    {
		for(new i;i<MAX_ACTORS;i++)
		{
			if(IsValidActor(i))
			{
			    ResyncActor(i);
			}
		}
		SendClientMessage(playerid,BLUE,"[ADMIN] Tous les acteurs ont été resynchronisés !");
	}
	return 1;
}

YCMD:arespawn(playerid,params[],help)
{
    if(!IsAdmin(playerid)) return NotRankedEnough(playerid);
    {
		for(new i;i<MAX_ACTORS;i++)
		{
			if(IsValidActor(i))
			{
			    RespawnActor(i);
			}
		}
		SendClientMessage(playerid,BLUE,"[ADMIN] Tous les acteurs ont été respawn !");
	}
	return 1;
}

YCMD:setdrunklevel(playerid,params[],help)
{
	new value,tmp[MAX_PLAYER_NAME],id;
	if(!IsAdmin(playerid)) return NotRankedEnough(playerid);
	if(sscanf(params,"s["#MAX_PLAYER_NAME"]d",tmp,value)) return SendClientMessage(playerid,RED,"Usage : /setdrunklevel [ID / Pseudo] [Niveau (0-50000)]");
	id = ReturnUser(tmp);
	if(!IsPlayerConnected(id)) return SubMessage(playerid,MSG_RED,"Ce joueur n'est pas connecté !",5);
	if(value < 0 || value > 50000) return SubMessage(playerid,MSG_RED,"Niveau d'alcoolémie invalide !",5);
	SetPlayerDrunkLevel(id,value);
	new string[256];
	format(string,sizeof(string),"[ADMIN] L'Admin t'a mis à un niveau d'alcool de {ffffff}%d",value);
	SendClientMessage(id,BLUE,string);
	format(string,sizeof(string),"[ADMIN] Vous avez mis {ffffff}%s {0080C0}à un niveau d'alcool de {ffffff}%d",GetName(id),value);
	SendClientMessage(playerid,BLUE,string);
	printf("[ADMIN] %s a mis %s à un niveau d'alcool de %d",GetName(playerid),GetName(id),value);
	return 1;
}

YCMD:banque(playerid,params[],help)
{
    if(!IsPlayerInRangeOfPoint(playerid,5.0,BANKINFO)) return SubMessage(playerid,MSG_RED,"Tu n'es pas aux guichets de la banque !",5);
    {
        new string[256];
		if(PlayerInfo[playerid][pCarte]==false)
		{
		    strcat(string,"\t\tCréer une carte bancaire (500$)\n");
		}
		else
		{
		    strcat(string,"\t\tDésactiver ma carte bancaire\n\t\tDépôt d'argent sur mon compte\n\t\tRetrait d'argent de mon compte\n");
		}
        ShowPlayerDialog(playerid,20,DIALOG_STYLE_LIST,"Opérations",string,"Choisir","Quitter");
	}
	return 1;
}

YCMD:emp(playerid,params[],help)
{
    if(Edit[playerid]!=1 && Edit[playerid]!=2 && Edit[playerid] != 4) return SubMessage(playerid,MSG_RED,"Tu ne définis aucun emplacement !",5);
    {
        new Float:x,Float:y,Float:z,interior,string[256];
        GetPlayerPos(playerid,x,y,z);
        interior = GetPlayerInterior(playerid);
        if(deftype[playerid]==1)
        {
	        switch(Edit[playerid])
	        {
	            case 1:
	            {
					format(string,sizeof(string),"[ADMIN] L'emplacement de la maison se situe maintenant aux coordonnées X: %0.2f, Y: %0.2f, Z: %0.2f",x,y,z);
					SendClientMessage(playerid,BLUE,string);
					HouseInfo[selectid[playerid]][X1] = x;
					HouseInfo[selectid[playerid]][Y1] = y;
					HouseInfo[selectid[playerid]][Z1] = z;
					SaveHouse(selectid[playerid]);
				}
	            case 2:
	            {
					format(string,sizeof(string),"[ADMIN] L'intérieur de la maison se situe maintenant à l'intérieur %d et aux coordonnées, X: %0.2f, Y: %0.2f, Z: %0.2f",interior,x,y,z);
					SendClientMessage(playerid,BLUE,string);
					HouseInfo[selectid[playerid]][eX] = x;
					HouseInfo[selectid[playerid]][eY] = y;
					HouseInfo[selectid[playerid]][eZ] = z;
					HouseInfo[selectid[playerid]][Interior] = interior;
					SaveHouse(selectid[playerid]);
				 }
				 case 4:
				 {
				    format(string,sizeof(string),"[ADMIN] L'emplacement du cambriolage se situe aux coordonnées X: %0.2f, Y: %0.2f, Z: %0.2f",x,y,z);
				    SendClientMessage(playerid,BLUE,string);
					HouseInfo[selectid[playerid]][cX] = x;
					HouseInfo[selectid[playerid]][cY] = y;
					HouseInfo[selectid[playerid]][cZ] = z;
					SaveHouse(selectid[playerid]);
					Edit[playerid] = 0;
					return 1;
				}
			}
			RemovePlayerMapIcon(playerid,selectid[playerid]);
			DestroyDynamicPickup(housepickup[selectid[playerid]][0]);
			DestroyDynamicPickup(housepickup[selectid[playerid]][1]);
			if(HouseInfo[selectid[playerid]][Interior]!=0)
			{
				housepickup[selectid[playerid]][1] = CreateDynamicPickup(1318,1,HouseInfo[selectid[playerid]][eX],HouseInfo[selectid[playerid]][eY],HouseInfo[selectid[playerid]][eZ],selectid[playerid],HouseInfo[selectid[playerid]][Interior]);
			}
			else
			{
				housepickup[selectid[playerid]][1] = CreateDynamicPickup(1318,1,HouseInfo[selectid[playerid]][eX],HouseInfo[selectid[playerid]][eY],HouseInfo[selectid[playerid]][eZ],0,0);
			}
			if(HouseInfo[selectid[playerid]][Type] == 1)
			{
			    housepickup[selectid[playerid]][0] = CreateDynamicPickup(1273,1,HouseInfo[selectid[playerid]][X1],HouseInfo[selectid[playerid]][Y1],HouseInfo[selectid[playerid]][Z1]);
				for(new i;i<MAX_PLAYERS;i++)
				{
					if(IsPlayerConnected(i))
					{
			    		SetPlayerMapIcon(i,selectid[playerid],HouseInfo[selectid[playerid]][X1],HouseInfo[selectid[playerid]][Y1],HouseInfo[selectid[playerid]][Z1],31,0,MAPICON_LOCAL);
					}
				}
			}
			else
			{
   				housepickup[selectid[playerid]][0] = CreateDynamicPickup(19522,1,HouseInfo[selectid[playerid]][X1],HouseInfo[selectid[playerid]][Y1],HouseInfo[selectid[playerid]][Z1]);
				for(new i;i<MAX_PLAYERS;i++)
				{
					if(IsPlayerConnected(i))
					{
					    if(selectid[playerid] == PlayerInfo[i][pMaison])
					    {
			    			SetPlayerMapIcon(i,selectid[playerid],HouseInfo[selectid[playerid]][X1],HouseInfo[selectid[playerid]][Y1],HouseInfo[selectid[playerid]][Z1],32,0,MAPICON_GLOBAL);
						}
						else
						{
							SetPlayerMapIcon(i,selectid[playerid],HouseInfo[selectid[playerid]][X1],HouseInfo[selectid[playerid]][Y1],HouseInfo[selectid[playerid]][Z1],32,0,MAPICON_LOCAL);
						}
					}
				}
			}
			Edit[playerid]=0;
		}
		else if(deftype[playerid]==2)
		{
			if(Edit[playerid]==1)
	        {
				format(string,sizeof(string),"[ADMIN] L'emplacement du commerce se situe maintenant aux coordonnées X: %0.2f, Y: %0.2f, Z: %0.2f",x,y,z);
				SendClientMessage(playerid,BLUE,string);
				CommerceInfo[selectid[playerid]][X1] = x;
				CommerceInfo[selectid[playerid]][Y1] = y;
				CommerceInfo[selectid[playerid]][Z1] = z;
				SaveCommerce(selectid[playerid]);
			}
			else
			{
				format(string,sizeof(string),"[ADMIN] L'intérieur du commerce se situe maintenant à l'intérieur %d et aux coordonnées X: %0.2f, Y: %0.2f, Z: %0.2f",interior,x,y,z);
				SendClientMessage(playerid,BLUE,string);
				CommerceInfo[selectid[playerid]][eX] = x;
				CommerceInfo[selectid[playerid]][eY] = y;
				CommerceInfo[selectid[playerid]][eZ] = z;
				CommerceInfo[selectid[playerid]][Interieur] = interior;
				SaveCommerce(selectid[playerid]);
			}
			DestroyDynamicPickup(commpickup[selectid[playerid]][0]);
			DestroyDynamicPickup(commpickup[selectid[playerid]][1]);
			if(CommerceInfo[selectid[playerid]][Interieur]!=0)
			{
				commpickup[selectid[playerid]][1] = CreateDynamicPickup(1318,1,CommerceInfo[selectid[playerid]][eX],CommerceInfo[selectid[playerid]][eY],CommerceInfo[selectid[playerid]][eZ],selectid[playerid],CommerceInfo[selectid[playerid]][Interieur]);
			}
			else
			{
				commpickup[selectid[playerid]][1] = CreateDynamicPickup(1318,1,CommerceInfo[selectid[playerid]][eX],CommerceInfo[selectid[playerid]][eY],CommerceInfo[selectid[playerid]][eZ],0,0);
			}
			commpickup[selectid[playerid]][0] = CreateDynamicPickup(PICKCENTER,1,CommerceInfo[selectid[playerid]][X1],CommerceInfo[selectid[playerid]][Y1],CommerceInfo[selectid[playerid]][Z1]);
			Edit[playerid]=0;
		}
		else if(deftype[playerid] == 3)
		{
		    if(Edit[playerid] == 1)
			{
				format(string,sizeof(string),"[ADMIN] L'emplacement du biz se situe maintenant aux coordonnées X: %0.2f, Y: %0.2f, Z: %0.2f",x,y,z);
				SendClientMessage(playerid,BLUE,string);
				BizInfo[selectid[playerid]][X] = x;
				BizInfo[selectid[playerid]][Y] = y;
				BizInfo[selectid[playerid]][Z] = z;
				SaveBiz(selectid[playerid]);
			}
		}
	}
	return 1;
}

YCMD:asetlvl(playerid,params[],help)
{
    if(!IsAdmin(playerid)) return NotRankedEnough(playerid);
    {
		new tmp[MAX_PLAYER_NAME],id,amount;
        if(sscanf(params,"s["#MAX_PLAYER_NAME"]d",tmp,amount)) return SendClientMessage(playerid,RED,"USAGE: /asetlvl [ID] [Niveau]");
        {
            id = ReturnUser(tmp);
            if(!IsPlayerConnected(id)) return SubMessage(playerid,MSG_RED,"Joueur invalide !",5);
            {
                if(amount < 0) return SubMessage(playerid,MSG_RED,"Niveau invalide !",5);
                {
					new string[256];
					format(string,sizeof(string),"[ADMIN] Tu as mis %s niveau %d",GetName(id),amount);
					SendClientMessage(playerid,BLUE,string);
					format(string,sizeof(string),"[ADMIN] Tu as été mis niveau %d par l'Admin",amount);
					SendClientMessage(id,BLUE,string);
					SetPlayerLevel(id,amount);
				}
			}
		}
	}
	return 1;
}

YCMD:getpos(playerid,params[],help)
{
    new Float:x,Float:y,Float:z,string[256],Float:a;
    GetPlayerPos(playerid,x,y,z);
	GetPlayerFacingAngle(playerid,a);
    format(string,sizeof(string),"Int: %d - X: %0.2f - Y: %0.2f - Z: %0.2f - A: %0.2f",GetPlayerInterior(playerid),x,y,z,a);
    SendClientMessage(playerid,BLUE,string);
    return 1;
}

YCMD:posinfo(playerid,params[],help)
{
    if(!IsAdmin(playerid)) return NotRankedEnough(playerid);
    new string[256] = "{ff0000}Vous n'êtes nul part !";
    for(new i; i < MAX_HOUSES ; i++)
    {
        if(IsPlayerInRangeOfPoint(playerid,5.0,HouseInfo[i][eX],HouseInfo[i][eY],HouseInfo[i][eZ]) || IsPlayerInRangeOfPoint(playerid,5.0,HouseInfo[i][X1],HouseInfo[i][Y1],HouseInfo[i][Z1]))
        {
            format(string,sizeof(string),"[ADMIN] Vous êtes à la maison {ffffff}%d",i);
            break;
		}
		else if(IsPlayerInRangeOfPoint(playerid,5.0,CommerceInfo[i][eX],CommerceInfo[i][eY],CommerceInfo[i][eZ]) || IsPlayerInRangeOfPoint(playerid,5.0,CommerceInfo[i][X1],CommerceInfo[i][Y1],CommerceInfo[i][Z1]))
		{
		    format(string,sizeof(string),"[ADMIN] Vous êtes au commerce {ffffff}%d",i);
		    break;
		}
		else if(IsPlayerInRangeOfPoint(playerid,5.0,BizInfo[i][X],BizInfo[i][Y],BizInfo[i][Z]))
		{
		    format(string,sizeof(string),"[ADMIN] Vous êtes au biz {ffffff}%d",i);
		    break;
		}
	}
	SendClientMessage(playerid,BLUE,string);
	return 1;
}

YCMD:ip(playerid,params[],help)
{
	if(!IsAdmin(playerid)) return NotRankedEnough(playerid);
	new id,ip[32],string[256];
	if(isnull(params)) return SendClientMessage(playerid,RED,"Usage : /ip [Pseudo / ID du joueur]");
	id = ReturnUser(params);
	GetPlayerIp(id,ip,sizeof(ip));
	format(string,sizeof(string),"[ADMIN] L'IP de {ffffff}%s {0080C0}est : {ffffff}%s",GetName(id),ip);
	SendClientMessage(playerid,BLUE,string);
	return 1;
}

YCMD:changepass(playerid,params[],help)
{
	ShowPlayerDialog(playerid,45,DIALOG_STYLE_INPUT,"Changement de mot de passe","Vous allez changer de mot de passe.\nVeuillez d'abord entrer votre mot de passe actuel :","Entrer","Quitter");
	stepchangepassword[playerid] = 1;
	return 1;
}

YCMD:setloc(playerid,params[],help)
{
	if(!IsAdmin(playerid)) return NotRankedEnough(playerid);
    {
        new Float:x,Float:y,Float:z,interior,vw;

		if(sscanf(params,"fffdd",x,y,z,interior,vw)) return SendClientMessage(playerid, RED, "USAGE: /setloc [X] [Y] [Z] [Interior] [VirtualWorld]");
		SetPlayerPosEx(playerid, x, y, z, interior, vw);
		SubMessage(playerid,MSG_BLUE, "Téléportation effectuée !",5);
  	}
	return 1;
}

YCMD:actinfo(playerid,params[],help)
{
    if(!IsAdmin(playerid)) return NotRankedEnough(playerid);
    new actor,Float:health,string[256];
	if(sscanf(params,"d",actor)) return SendClientMessage(playerid,RED,"Usage : /actinfo [ID Acteur]");
	if(!IsValidActor(actor) || IsValidActor(actor) && IsActorInvulnerable(actor)) return SubMessage(playerid,MSG_RED,"Acteur invalide !",5);

	GetActorHealth(actor,health);
	format(string,sizeof(string),"ID %d | Vie: %.2f | Invulnérable: %d",actor,health,IsActorInvulnerable(actor));
	SendClientMessage(playerid,BLUE,string);
	return 1;
}

YCMD:agivebanque(playerid,params[],help)
{
	new value,string[256];
	if(!IsAdmin(playerid)) return NotRankedEnough(playerid);
	{
		if(sscanf(params,"d",value)) return SendClientMessage(playerid,RED,"USAGE: /agivebanque [Montant]");
		{
			format(string,sizeof(string),"[ADMIN] $%d ont été ajoutés au coffre de la banque !",value);
			SendClientMessage(playerid,BLUE,string);
			GiveMoneyBanque(value);
		}
	}
	return 1;
}

YCMD:createnum(playerid,params[],help)
{
    if(PlayerInfo[playerid][pNum] != 0) return SubMessage(playerid,MSG_RED,"Tu as déjà un numéro !",5);
    {
		new randnum[5],string[256], INI:File = INI_Open(UserPath(playerid));
		for(new i;i<5;i++)
		{
		    randnum[i] = random(9);
		}
		format(string,sizeof(string),"%d%d%d%d%d",randnum[0],randnum[1],randnum[2],randnum[3],randnum[4]);
		PlayerInfo[playerid][pNum] = strval(string);
		format(string,sizeof(string),"[Phone] Ton numéro de téléphone est le %d",PlayerInfo[playerid][pNum]);
		SendClientMessage(playerid,BLUE,string);
		INI_SetTag(File,"data");
 		INI_WriteInt(File,"Num", PlayerInfo[playerid][pNum]);
 		INI_Close(File);
	}
	return 1;
}

YCMD:ptime(playerid,params[],help)
{
	if(IsAdmin(playerid))
	{
	    new hours;
   		if(sscanf(params,"d",hours))
 		{
		    gettime(hour,minute);
	     	SetPlayerTime(playerid,hour,minute);
		}
		else SetPlayerTime(playerid,hours,0);
	}
	else
	{
		NotRankedEnough(playerid);
	}
	return 1;
}

YCMD:numero(playerid,params[],help)
{
	if(PlayerInfo[playerid][pNum] == 0) return SubMessage(playerid,MSG_RED,"Tu n'as pas de numéro ! Tapes /createnum pour t'en créer un.",5);
	{
		new string[256];
		format(string,sizeof(string),"[Phone] Ton numéro est le %d",PlayerInfo[playerid][pNum]);
		SendClientMessage(playerid,BLUE,string);
	}
	return 1;
}

YCMD:spec(playerid,params[],help)
{
	new specplayerid;
	if(!IsAdmin(playerid)) return NotRankedEnough(playerid);
	if(isnull(params)) {
		SendClientMessage(playerid, RED, "USAGE: /spec [playerid]");
		return 1;
	}
	specplayerid = ReturnUser(params);
	if(!IsPlayerConnected(specplayerid)) {
	    SubMessage(playerid,MSG_RED, "Ce joueur n'est pas connecté !",5);
		return 1;
	}
	SetPlayerInterior(playerid,GetPlayerInterior(specplayerid));
	SetPlayerVirtualWorld(playerid,GetPlayerVirtualWorld(specplayerid));
	TogglePlayerSpectating(playerid, 1);
	if(!IsPlayerInAnyVehicle(specplayerid)) PlayerSpectatePlayer(playerid, specplayerid);
	else PlayerSpectateVehicle(playerid, GetPlayerVehicleID(specplayerid));
	SetPlayerInterior(playerid,GetPlayerInterior(specplayerid));
	gSpectateID[playerid] = specplayerid;
	gSpectateType[playerid] = ADMIN_SPEC_TYPE_PLAYER;

	return 1;
}

YCMD:specvehicle(playerid,params[],help)
{
	new specvehicleid;
	if(!IsAdmin(playerid)) return NotRankedEnough(playerid);
	if(sscanf(params,"d",specvehicleid)) {
		SendClientMessage(playerid, WHITE, "USAGE: /specvehicle [vehicleid]");
		return 1;
	}

	if(specvehicleid < MAX_VEHICLES) {
		TogglePlayerSpectating(playerid, 1);
		PlayerSpectateVehicle(playerid, specvehicleid);
		gSpectateID[playerid] = specvehicleid;
		gSpectateType[playerid] = ADMIN_SPEC_TYPE_VEHICLE;
	}
	return 1;
}

YCMD:specoff(playerid,params[],help)
{
	if(!IsAdmin(playerid)) return NotRankedEnough(playerid);
    SetPlayerInterior(playerid,0);
    SetPlayerVirtualWorld(playerid,0);
	TogglePlayerSpectating(playerid, 0);
	gSpectateID[playerid] = INVALID_PLAYER_ID;
	gSpectateType[playerid] = ADMIN_SPEC_TYPE_NONE;
	return 1;
}

YCMD:reload(playerid,params[],help)
{
	new value,string[256];
	if(IsAdmin(playerid))
    {
		if(strval(params) == 0) return Reboot();
		{
			sscanf(params,"d",value);
			treboot = SetTimer("Reboot",value*60000,false);
			format(string,sizeof(string),"[ADMIN] Le serveur redémarerra dans %d minute(s).",value);
			SendClientMessageToAll(BLUE,string);
		}
	}
	else
	{
		NotRankedEnough(playerid);
	}
	return 1;
}

YCMD:stoprl(playerid,params[],help)
{
	if(!IsAdmin(playerid)) return NotRankedEnough(playerid);
	{
		KillTimer(treboot);
		SendClientMessageToAll(BLUE,"[ADMIN] Le redémarrage du serveur a été annulé !");
	}
	return 1;
}

YCMD:unfreeze(playerid,params[],help)
{
	new otherid = ReturnUser(params);
	if(!IsAdmin(playerid)) return NotRankedEnough(playerid);
    if(isnull(params)) {
		SendClientMessage(playerid, RED, "USAGE: /unfreeze [ID]");
	}
	else
	{
		if(IsPlayerConnected(otherid))
		{
		    TogglePlayerControllable(otherid,true);
		}
		else SubMessage(playerid,MSG_RED, "Ce joueur n'est pas connecté !",5);
	}
    return 1;
}

YCMD:tp(playerid,params[],help)
{
	new otherid = ReturnUser(params);
	if(!IsAdmin(playerid)) return NotRankedEnough(playerid);
    if(isnull(params)) {
		SendClientMessage(playerid, RED, "USAGE: /tp [ID]");
	}
	else
	{
		if(IsPlayerConnected(otherid))
		{

	    	new Float:x, Float:y, Float:z,Int,vw;

	    	if(GetPlayerVehicleID(playerid))
	    	{
		    	GetPlayerPos( otherid, x, y, z );
		    	SetVehiclePos( GetPlayerVehicleID(playerid), x+0.5, y+0.5, z );
				SubMessage(playerid,MSG_BLUE, "Téléportation effectuée !",5);
  			}
			else
			{
				Int = GetPlayerInterior(otherid);
				vw = GetPlayerVirtualWorld(otherid);
			   	GetPlayerPos( otherid, x, y, z );
			   	SetPlayerPosEx( playerid, x+0.5, y+0.5, z ,Int,vw);
				SubMessage(playerid,MSG_BLUE, "Téléportation effectuée !",5);
	    	}
		}
		else SubMessage(playerid,MSG_RED, "Ce joueur n'est pas connecté !",5);
	}
    return 1;
}

YCMD:tphere(playerid,params[],help)
{
	new otherid = ReturnUser(params);
	if(!IsAdmin(playerid)) return NotRankedEnough(playerid);
    if(isnull(params)) {
		SendClientMessage(playerid, RED, "USAGE: /tphere [ID]");
	}
	else
	{
		if(IsPlayerConnected(otherid))
		{

	    	new Float:x, Float:y, Float:z,Int,vw;
			if(GetPlayerVehicleID(playerid))
	    	{
		    	GetVehiclePos(GetPlayerVehicleID(playerid), x, y, z);
		    	SetPlayerPos(otherid, x+0.5, y+0.5, z+0.5);
				SubMessage(playerid,MSG_BLUE, "Téléportation effectuée !",5);
  			}
	    	if(GetPlayerVehicleID(otherid))
	    	{
		    	GetPlayerPos(playerid, x, y, z );
		    	SetVehiclePos(GetPlayerVehicleID(otherid), x+0.5, y+0.5, z+0.5);
				SubMessage(playerid,MSG_BLUE, "Téléportation effectuée !",5);
  			}
			else
			{
				Int = GetPlayerInterior(playerid);
				vw = GetPlayerVirtualWorld(playerid);
			   	GetPlayerPos(playerid, x, y, z );
			   	SetPlayerPosEx(otherid, x+0.5, y+0.5, z ,Int,vw);
				SubMessage(playerid,MSG_BLUE, "Téléportation effectuée !",5);
	    	}
		}
		else SubMessage(playerid,MSG_RED, "Ce joueur n'est pas connecté !",5);
	}
    return 1;
}

YCMD:servinfos(playerid,params[],help)
{
    if(!IsAdmin(playerid)) return NotRankedEnough(playerid);

    new objects,players,actors,vehicles,npc,houses,commerces,biz;
    for(new i;i<MAX_OBJECTS;i++) if(IsValidObject(i)) objects ++;
	for(new i;i<MAX_PLAYERS;i++) if(IsPlayerConnected(i)) players++;
	for(new i;i<MAX_VEHICLES;i++) if(GetVehicleModel(i) >=400) vehicles++;
	for(new i;i<MAX_ACTORS;i++) if(IsValidActor(i) && !IsActorInvulnerable(i)) actors ++;
	for(new i;i<MAX_PLAYERS;i++) if(IsPlayerNPC(i)) npc ++;
	for(new i;i<MAX_HOUSES;i++) if(HouseInfo[i][Type] != 0) houses ++;
	for(new i;i<MAX_COMMERCES;i++) if(CommerceInfo[i][Type] != 0) commerces ++;
	for(new i;i<MAX_BIZ;i++) if(BizInfo[i][Type] != 0) biz ++;
	new string[1024],msg[1024];
	string = "\t\t{FF8000}Informations du serveur\n\n";
	strcat(string,"\t{ffff00}%d {008040}objets présents\n\t{ffff00}%d{008040} joueurs connectés\n\t{ffff00}%d {008040}véhicules présents\n\t{ffff00}%d {008040}acteurs vivants\n\t{ffff00}%d {008040}NPC connectés\n\t{ffff00}%d {008040}maisons présentes\n\t{ffff00}%d{008040} commerces présents\n\t{ffff00}%d {008040}propriétés présentes");
	format(msg,sizeof(msg),string,objects + CountDynamicObjects(),players,vehicles,actors,npc,houses,commerces,biz);
	ShowPlayerDialog(playerid,38,DIALOG_STYLE_MSGBOX,"Infos du Serveur",msg,"Ok","Quitter");
	return 1;
}

YCMD:braquage(playerid,params[],help)
{
	new id;
	id = ReturnUser(params);
    if(isnull(params)) return SendClientMessage(playerid,RED,"USAGE: /braquage [ID de l'autre braqueur]");
    {
		if(mission[playerid] == 0)
		{
			if(mission[id] == 0)
			{
		        if(!IsPlayerConnected(id) || id == INVALID_PLAYER_ID) return SubMessage(playerid,MSG_RED,"Ce joueur n'est pas connecté !",5);
				{
				    if(id == playerid) return SubMessage(playerid,MSG_RED,"Tu ne peux pas braquer tout seul !",5);
				    {
					    if(jbraquage[playerid] == true) return SubMessage(playerid,MSG_RED,"Tu es déjà en braquage !",5);
					    {
					        if(jbraquage[id] == true) return SubMessage(playerid,MSG_RED,"Ce joueur est déjà en braquage !",5);
					        {
								if(braquage == true) return SubMessage(playerid,MSG_RED,"La banque se fait déjà braquer, allez les tuer !",5);
								{
								    if(MoneyBanque<300) return SubMessage(playerid,MSG_RED,"La banque est à sec !",5);
								    {
									    new string[256];
									    braquage = true;
									    jbraquage[playerid] = true;
									    jbraquage[id] = true;
									    format(string,sizeof(string),"%s souhaite braquer la banque avec toi.\nAcceptes-tu ?",GetName(playerid));
									    ShowPlayerDialog(id,13,DIALOG_STYLE_MSGBOX,"Braquage",string,"Oui","Non");
									    braqueur[0] = playerid;
									    braqueur[1] = id;
									}
								}
							}
						}
					}
				}
			}
			else
			{
				SubMessage(playerid,MSG_RED, "Ce joueur est en mission !",5);
			}
		}
		else
		{
			SubMessage(playerid,MSG_RED, "Tu ne peux pas braquer en cours de mission !",5);
		}
	}
	return 1;
}

YCMD:bstop(playerid,params[],help)
{
    if(jbraquage[playerid] == false) return SubMessage(playerid,MSG_RED,"Tu n'es dans aucun braquage !",5);
	{
		EndBraquage();
		for(new i;i<2;i++)
		{
			if(braqueur[i] != playerid)
			{
			    SubMessage(braqueur[i],MSG_BLUE,"~r~Ton coéquipier a décidé d'abandonner !",5);
			}
		}
		SubMessage(playerid,MSG_RED,"Vous arrêtez le braquage !",5);
	}
	return 1;
}

YCMD:htp(playerid,params[],help)
{
    new maison;
    if(!IsAdmin(playerid)) return NotRankedEnough(playerid);
    {
	    if(sscanf(params,"d",maison))
		{
			SendClientMessage(playerid, RED, "USAGE: /htp [ID Maison]");
			return 1;
		}
		if(HouseInfo[maison][Type]==0) return SubMessage(playerid,MSG_RED,"Cette maison n'existe pas encore !",5);
		{
		    SetPlayerPosEx(playerid,HouseInfo[maison][X1],HouseInfo[maison][Y1],HouseInfo[maison][Z1],0,0);
 		}
	}
    return 1;
}

YCMD:ctp(playerid,params[],help)
{
    new commerce;
    if(!IsAdmin(playerid)) return NotRankedEnough(playerid);
    {
	    if(sscanf(params,"d",commerce))
		{
			SendClientMessage(playerid, RED, "USAGE: /ctp [ID Commerce]");
			return 1;
		}
		if(CommerceInfo[commerce][Type]==0) return SubMessage(playerid,MSG_RED,"Ce commerce n'existe pas encore !",5);
		{
		    SetPlayerPosEx(playerid,CommerceInfo[commerce][X1],CommerceInfo[commerce][Y1],CommerceInfo[commerce][Z1],0,0);
 		}
	}
    return 1;
}

YCMD:btp(playerid,params[],help)
{
    new bizid;
    if(!IsAdmin(playerid)) return NotRankedEnough(playerid);
    {
	    if(sscanf(params,"d",bizid))
		{
			SendClientMessage(playerid, RED, "USAGE: /btp [ID Propriété]");
			return 1;
		}
		if(BizInfo[bizid][Type]==0) return SubMessage(playerid,MSG_RED,"Cette propriété n'existe pas encore !",5);
		{
		    SetPlayerPosEx(playerid,BizInfo[bizid][X],BizInfo[bizid][Y],BizInfo[bizid][Z],0,0);
 		}
	}
    return 1;
}

YCMD:fix(playerid,params[],help)
{
	if(!IsAdmin(playerid)) return NotRankedEnough(playerid);
	if(IsPlayerInAnyVehicle(playerid))
	{
    	new vid = GetPlayerVehicleID(playerid),
		engine,
		lights,
		alarm,
		doors,
		bonnet,
		boot,
		objective;
		GetVehicleParamsEx(vid, engine, lights, alarm, doors, bonnet,boot,objective);
    	SetVehicleParamsEx(vid, 1, 		lights, 0, doors, 0, 0, objective);
	 	RepairVehicle(vid);
		SubMessage(playerid,MSG_BLUE, "Véhicule réparé !",5);
	}
	else
	{
		SubMessage(playerid,MSG_RED, "Tu dois être dans un véhicule pour faire cette commande !",5);
	}
	return 1;
}

YCMD:nitro(playerid,params[],help)
{
    if(!IsAdmin(playerid)) return NotRankedEnough(playerid);
    if(IsPlayerInAnyVehicle(playerid))
    {
    	new vid = GetPlayerVehicleID(playerid);
    	AddVehicleComponent(vid, 1010);
		SubMessage(playerid,MSG_BLUE, "Nitro installée !",5);
	}
	else
	{
		SubMessage(playerid,MSG_RED, "Tu dois être dans un véhicule pour faire cette commande !",5);
	}
    return 1;
}

YCMD:nonitro(playerid,params[],help)
{
    if(!IsAdmin(playerid)) return NotRankedEnough(playerid);
    if(IsPlayerInAnyVehicle(playerid))
    {
    	new vid = GetPlayerVehicleID(playerid);
    	RemoveVehicleComponent(vid, 1010);
		SubMessage(playerid,MSG_BLUE, "Nitro retirée !",5);
	}
	else
	{
		SubMessage(playerid,MSG_RED, "Tu dois être dans un véhicule pour faire cette commande !",5);
	}
    return 1;
}

YCMD:notuning(playerid,params[],help)
{
	if(VehicleInfo[playerid][Model] == 0) return SubMessage(playerid,MSG_RED,"Tu n'as aucun véhicule !",5);
	{
		if(!IsPlayerInVehicle(playerid,jvehicle[playerid])) return SubMessage(playerid,MSG_RED,"Tu dois être dans ton véhicule pour pouvoir le vendre !",5);
		{
			new INI:File = INI_Open(UserPath(playerid)), string[7];
			INI_SetTag(File,"Veh");
			INI_WriteInt(File,"PaintJob",0);
			for(new i;i< 14 ;i++)
			{
				format(string,sizeof(string),"Slot_%d",i);
				INI_WriteInt(File,string,0);
			}
			INI_Close(File);
			SubMessage(playerid,MSG_BLUE,"Le tuning de ton véhicule a été effacé !",5);
			INI_ParseFile(UserPath(playerid), "LoadVehicle_%s",false,true, playerid, false);
			SetVehicleToRespawn(jvehicle[playerid]);
		}
	}
    return 1;
}

YCMD:skin(playerid,params[],help)
{
    new tmp[MAX_PLAYER_NAME],skin,id;
	if(!IsAdmin(playerid)) return NotRankedEnough(playerid);
	if(sscanf(params,"s["#MAX_PLAYER_NAME"]d",tmp,skin)) return SendClientMessage(playerid, RED, "USAGE: /skin [ID Joueur] [ID Skin]");
 	if(!IsValidSkin(skin)) return SubMessage(playerid,MSG_RED,"Skin invalide !",5);
	{
	    id = ReturnUser(tmp);
	    if(!IsPlayerConnected(id)) return SubMessage(playerid,MSG_RED,"Ce joueur n'est pas connecté !",5);

		GivePlayerSkin(id,skin);
		TogglePlayerControllable(id,true);
	}
    return 1;
}

YCMD:ped(playerid,params[],help)
{
	if(!IsAdmin(playerid)) return NotRankedEnough(playerid);
	else
	{
	    new randskin;
		if(isnull(params)) return SendClientMessage(playerid, RED, "USAGE: /ped [Catégorie (Campagne - Ville ( - Réseaux sociaux XPTDRLOLXD) - Travailleur - Gang)]");

		if(!strcmp(params, "Campagne", true))
		{
		    randskin = random(sizeof(RandomCPed));
			GivePlayerSkin(playerid,RandomCPed[randskin]);
		}
		if(!strcmp(params, "Ville", true))
		{
		    randskin = random(sizeof(RandomPed));
			GivePlayerSkin(playerid,RandomPed[randskin]);
		}
		if(!strcmp(params, "Travailleur", true))
		{
		    randskin = random(sizeof(RandomWorker));
			GivePlayerSkin(playerid,RandomWorker[randskin]);
		}
		if(!strcmp(params, "Gang", true))
		{
		    randskin = random(sizeof(RandomGang));
			GivePlayerSkin(playerid,RandomGang[randskin]);
		}
		TogglePlayerControllable(playerid,true);
	}
    return 1;
}

YCMD:suicide(playerid,params[],help)
{
    SetPlayerHealth(playerid,0.0);
    return 1;
}

YCMD:jetpack(playerid,params[],help)
{
	if(!IsAdmin(playerid)) return NotRankedEnough(playerid);
    SetPlayerSpecialAction(playerid,SPECIAL_ACTION_USEJETPACK);
    SubMessage(playerid,MSG_BLUE, "Jetpack équipé !",5);
	return 1;
}

YCMD:kill(playerid,params[],help)
{
    new id;
	id = ReturnUser(params);
	if(!IsAdmin(playerid)) return NotRankedEnough(playerid);
	if(isnull(params)) return SendClientMessage(playerid, RED, "USAGE: /kill [ID]");

	SetPlayerHealth(id, 0.0);

	return 1;
}

YCMD:flip(playerid,params[],help)
{
    if(!IsAdmin(playerid)) return NotRankedEnough(playerid);
    if(IsPlayerInAnyVehicle(playerid))
    {
    	SetVehicleZAngle(GetPlayerVehicleID(playerid), 0);
		SubMessage(playerid,MSG_BLUE, "Ton véhicule a été retourné !",5);
	}
	else
	{
		SubMessage(playerid,MSG_RED, "Tu dois être dans un véhicule pour faire cette commande !",5);
	}
	return 1;
}

YCMD:cp(playerid,params[],help)
{
	new id,string[256];
    if(!IsAdmin(playerid)) return NotRankedEnough(playerid);
    if(BuildingRace[playerid] == false) return SubMessage(playerid,MSG_RED,"Vous ne construisez aucune course !",5);
	if(sscanf(params,"d",id)) return SendClientMessage(playerid,RED,"Usage : /cp [ID CP]");

	if(id <= 0) return SubMessage(playerid,MSG_RED,"ID Invalide !",5);
	NumCPBuilding[playerid] = id - 1;
	format(string,sizeof(string),"[ADMIN] Vous éditez le CP {ffffff}%d.{33AA33}Tapez /setcp pour modifier sa position.",id);
	SendClientMessage(playerid,BLUE,string);
	return 1;
}

YCMD:carcolor(playerid,params[],help)
{
	new color1,color2;
	if(!IsAdmin(playerid)) return NotRankedEnough(playerid);
   	if(IsPlayerInAnyVehicle(playerid))
    {
		if(sscanf(params,"dd",color1,color2)) return SendClientMessage(playerid, RED, "USAGE: /carcolor [C1] [C2 (optionnel)]");
		ChangeVehicleColor(GetPlayerVehicleID(playerid), color1, color2);
		SubMessage(playerid,MSG_BLUE, "Couleur du véhicule changée !",5);
  	}
	else
	{
		SubMessage(playerid,MSG_RED, "Tu dois être dans un véhicule pour utiliser cette commande !",5);
		return 1;
	}
	return 1;
}
YCMD:mask(playerid,params[],help)
{
    if(!IsPlayerAttachedObjectSlotUsed(playerid,0)) return SubMessage(playerid,MSG_RED,"Vous ne portez aucun masque !",5);

    RemovePlayerAttachedObject(playerid,0);

	return 1;
}

YCMD:asay(playerid,params[],help)
{
    if(!IsAdmin(playerid)) return NotRankedEnough(playerid);
    {
		new string[256];
		new sendername[MAX_PLAYER_NAME];
		GetPlayerName(playerid, sendername, sizeof(sendername));

		if(isnull(params)) return SendClientMessage(playerid, RED, "USAGE: /asay [Texte]");
		format(string, sizeof(string), "* Admin: {ffffff}%s",params);
		SendClientMessageToAll(BLUE, string);
	}
	return 1;
}

YCMD:unban(playerid,params[],help)
{
    if(!IsAdmin(playerid)) return NotRankedEnough(playerid);
    {
		new string[256],aip[32];
		GetPlayerIp(playerid,aip,sizeof(aip));
		new sendername[MAX_PLAYER_NAME];
		GetPlayerName(playerid, sendername, sizeof(sendername));

		if(isnull(params)) return SendClientMessage(playerid, RED, "USAGE: /unban [Compte]");
		new victimeid = 999;
		format(string,sizeof(string),PATH,params);
		if(!fexist(string)) return SubMessage(playerid,MSG_RED, "Ce compte n'existe pas !",5);
		INI_ParseFile(string, "LoadUser_%s", false, true, victimeid, false);
		if(PlayerInfo[victimeid][pBan] == false) return SubMessage(playerid,MSG_RED,"Le compte de cette personne n'est pas banni",5);
		format(string,sizeof(string),PATH,params);
		new INI:File = INI_Open(string);
		INI_SetTag(File,"data");
		INI_WriteInt(File,"Ban",false);
		INI_Close(File);
		new ip[32];
		format(ip,sizeof(ip),"unbanip %s",LastIp[victimeid]);
		SendRconCommand(ip);
		new msg[256];
		format(msg,sizeof(msg),"[ADMIN] {ffffff}%s {0080C0}a débanni le compte de {ffffff}%s{0080C0}.",GetName(playerid),params);
		SendClientMessageToAll(BLUE,msg);
		printf("[ADMIN] %s (%s) a unban %s (%s)",GetName(playerid),aip,params,LastIp[victimeid]);
	}
	return 1;
}
YCMD:ban(playerid,params[],help)
{
    if(!IsAdmin(playerid)) return NotRankedEnough(playerid);
    {
		new string[256],aip[32];
		GetPlayerIp(playerid,aip,sizeof(aip));
		new sendername[MAX_PLAYER_NAME];
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if(isnull(params)) return SendClientMessage(playerid, RED, "USAGE: /ban [Compte]");
		new victimeid = 999;
		format(string,sizeof(string),PATH,params);
		if(!fexist(string)) return SubMessage(playerid,MSG_RED, "Ce compte n'existe pas !",5);
		INI_ParseFile(string, "LoadUser_%s", false, true, victimeid, false);
		if(PlayerInfo[victimeid][pBan] == true) return SubMessage(playerid,MSG_RED,"Le compte de cette personne est déjà banni.",5);
		if(GetPlayerID(params) != INVALID_PLAYER_ID) return SubMessage(playerid,MSG_RED,"Le compte de cette personne est connecté !",5);
		format(string,sizeof(string),PATH,params);
		new INI:File = INI_Open(string);
		INI_SetTag(File,"data");
		INI_WriteInt(File,"Ban",true);
		INI_Close(File);
		new ip[32];
		format(ip,sizeof(ip),"banip %s",LastIp[victimeid]);
		SendRconCommand(ip);
		new msg[256];
		format(msg,sizeof(msg),"[ADMIN] {ffffff}%s {0080C0}a banni le compte de {ffffff}%s{0080C0}.",GetName(playerid),params);
		SendClientMessageToAll(BLUE,msg);
		printf("[ADMIN] %s (%s) a banni %s (%s)",GetName(playerid),aip,params,LastIp[victimeid]);
		new day,month,year,hours,minutes,second;
		gettime(hours,minutes,second);
		getdate(year,month,day);
		format(msg,sizeof(msg),"[%02d/%02d/%02d - %02d:%02d:%02d] Admin %s (%s) a banni le compte de %s (%s)\n",day,month,year,hours,minutes,second,GetName(playerid),aip,params,LastIp[victimeid]);
	 	WriteSanctionFile(string);
	}
	return 1;
}

YCMD:respawn(playerid,params[],help)
{
	new otherid = ReturnUser(params);

	new string[256];

	if(IsAdmin(playerid))
    {
    	if(!strlen(params)) return SendClientMessage(playerid, RED, "USAGE: /respawn [ID]");
		if(!IsPlayerConnected(otherid)) return SubMessage(playerid,MSG_RED, "ID Invalide !",5);
		else
		{
		    SavePlayerWeapons(otherid);
			SpawnPlayerEx(otherid);
			SendClientMessage(otherid, BLUE, "[ADMIN] Tu as été respawn par un admin");
			format(string, sizeof(string), "[ADMIN] Tu as respawn le joueur %s !", GetName(otherid));
			SendClientMessage(playerid, BLUE, string);
		}
	}
	else NotRankedEnough(playerid);
	return 1;
}

YCMD:resetnum(playerid,params[],help)
{
	new id,string[256];
	if(!IsAdmin(playerid)) return NotRankedEnough(playerid);
	if(isnull(params)) return SendClientMessage(playerid,RED,"Usage : /resetnum [ID / Pseudo]");
	id = ReturnUser(params);
	if(!IsPlayerConnected(id)) return SubMessage(playerid,MSG_RED,"Ce joueur n'est pas connecté !",5);
	SendClientMessage(id,BLUE,"[ADMIN] L'Admin a supprimé votre numéro !");
	format(string,sizeof(string),"[ADMIN] Numéro de {ffffff}%s {0080C0}supprimé !",GetName(id));
	SendClientMessage(playerid,BLUE,string);
	printf("[ADMIN] %s a supprimé le numéro de %s",GetName(playerid),GetName(id));
	PlayerInfo[id][pNum] = 0;
	new INI:File = INI_Open(UserPath(id));
	INI_SetTag(File,"data");
	INI_WriteInt(File,"Num", PlayerInfo[id][pNum]);
	INI_Close(File);
	return 1;
}

YCMD:skyfall(playerid,params[],help)
{
	if(!IsAdmin(playerid)) return NotRankedEnough(playerid);
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    SetPlayerPosEx(playerid, x, y, z+1000,0,0);
    GivePlayerWeapon(playerid, 46, 1);
	return 1;
}

YCMD:meteo(playerid,params[],help)
{
	if(IsAdmin(playerid))
	{
		SendClientMessageToAll(BLUE, "[ADMIN] La météo a été changée !");
		HourUpdate();
	}
	else
	{
		NotRankedEnough(playerid);
	}
	return 1;
}

YCMD:rain(playerid,params[],help)
{
	if(IsAdmin(playerid))
	{
		SendClientMessageToAll(BLUE, "[ADMIN] Il pleut !");
		SetWeather(8);
	}
	else
	{
		NotRankedEnough(playerid);
	}
	return 1;
}

YCMD:sun(playerid,params[],help)
{
	if(IsAdmin(playerid))
	{
		SendClientMessageToAll(BLUE, "[ADMIN] Il fait beau !");
		SetWeather(0);
	}
	else
	{
		NotRankedEnough(playerid);
	}
	return 1;
}

YCMD:fog(playerid,params[],help)
{
	if(!IsAdmin(playerid)) return NotRankedEnough(playerid);

	SendClientMessageToAll(BLUE, "[ADMIN] Il y a du brouillard !");
	SetWeather(9);
	return 1;
}

YCMD:moon(playerid,params[],help)
{
	if(!IsAdmin(playerid)) return NotRankedEnough(playerid);

	SendClientMessageToAll(BLUE, "[ADMIN] La gravité est lunaire !");
	SetGravity(0.001);
	return 1;
}

YCMD:earth(playerid,params[],help)
{
	if(IsAdmin(playerid))
	{
		SendClientMessageToAll(BLUE, "[ADMIN] La gravité est terrestre !");
		SetGravity(0.008);
	}
	else
	{
		NotRankedEnough(playerid);
	}
	return 1;
}

YCMD:sgravity(playerid,params[],help)
{
	if(IsAdmin(playerid))
	{
		SendClientMessageToAll(BLUE, "[ADMIN] La gravité est adaptée au stunt !");
		SetGravity(0.0065);
	}
	else
	{
		NotRankedEnough(playerid);
	}
	return 1;
}


YCMD:getg(playerid,params[],help)
{
	if(IsAdmin(playerid))
	{
	    new string[512];
	    format(string, sizeof(string), "Gravité actuelle: %f",GetGravity());
	    SendClientMessage(playerid, BLUE, string);
	}
	else
	{
		NotRankedEnough(playerid);
	}
	return 1;
}

YCMD:agiveweap(playerid,params[],help)
{
	if(!IsAdmin(playerid)) return NotRankedEnough(playerid);
	{
		new id,weap,amount,tmp[MAX_PLAYER_NAME],weapname[256];
		if(sscanf(params,"s["#MAX_PLAYER_NAME"]dd",tmp,weap,amount)) return SendClientMessage(playerid,RED,"USAGE: /agiveweap [ID] [ID Arme] [Munitions]");
		{
			id = ReturnUser(tmp);
			if(!IsPlayerConnected(id)) return SubMessage(playerid,MSG_RED,"Ce joueur n'est pas connecté !",5);
			{
				if(GetWeaponName(weap,weapname,sizeof(weapname)) == 0) return SubMessage(playerid,MSG_RED,"ID d'arme invalide !",5);
				{
					new string[256];
					format(string,sizeof(string),"[ADMIN] Tu as reçu un %s de %d munitions par l'Admin.",weapname,amount);
					SendClientMessage(id,BLUE,string);
					SubMessage(playerid,MSG_BLUE,"Arme donnée avec succès !",5);
					GivePlayerWeapon(id,weap,amount);
				}
			}
		}
	}
	return 1;
}

YCMD:setmoney(playerid,params[],help)
{
	if(IsAdmin(playerid))
	{
   		new tmp[MAX_PLAYER_NAME];
   		new otherid,money;
   		if (sscanf(params,"s["#MAX_PLAYER_NAME"]d",tmp,money)) return SendClientMessage(playerid, RED, "USAGE: /setmoney [ID] [Montant]");
   		otherid = ReturnUser(tmp);
		if(!IsPlayerConnected(otherid)) return SubMessage(playerid,MSG_RED,"ID Invalide !",5);
		else
		{
			SetPlayerMoney(otherid, money);
			new string[128],otherplayername[MAX_PLAYER_NAME];
			GetPlayerName(otherid,otherplayername,sizeof(otherplayername));
    		format(string, sizeof(string), "[ADMIN] Tu as défini l'argent de %s à $%d", otherplayername, money);
    		SendClientMessage(playerid, BLUE, string);
    		format(string, sizeof(string), "[ADMIN] L'admin a défini ton argent à $%d", money);
    		SendClientMessage(otherid, BLUE, string);
    	}
	}
	else
	{
		NotRankedEnough(playerid);
	}
	return 1;
}

YCMD:givemoney(playerid,params[],help)
{
	if(IsAdmin(playerid))
	{
    	new tmp[MAX_PLAYER_NAME];
   		new otherid,money;
		if(sscanf(params,"s["#MAX_PLAYER_NAME"]d",tmp,money)) return SendClientMessage(playerid, RED, "USAGE: /givemoney [ID] [Montant]");
		otherid = ReturnUser(tmp);
		if(!IsPlayerConnected(otherid)) return SubMessage(playerid,MSG_RED,"ID Invalide !",5);

    	GiveMoney(otherid, money);
		new string[128],otherplayername[MAX_PLAYER_NAME];
		GetPlayerName(otherid,otherplayername,sizeof(otherplayername));
    	format(string, sizeof(string), "[ADMIN] Tu as donné $%d à %s", money, otherplayername);
    	SendClientMessage(playerid, BLUE, string);
		GetPlayerName(otherid,otherplayername,sizeof(otherplayername));
    	format(string, sizeof(string), "[ADMIN] L'admin t'a donné $%d", money);
		SendClientMessage(otherid,BLUE,string);
    }
	else
	{
		NotRankedEnough(playerid);
	}
	return 1;
}

YCMD:defhouse(playerid,params[],help)
{
	if(!IsAdmin(playerid)) return NotRankedEnough(playerid);
	{
	    selectid[playerid]=-1;
	    deftype[playerid]=1;
		ShowPlayerDialog(playerid,17,DIALOG_STYLE_INPUT,"Maisons","Entre ci-dessous l'ID de la maison que tu souhaites configurer.\nLaisses vide pour créer une nouvelle maison :","Entrer","Quitter");
	}
	return 1;
}

YCMD:defcomm(playerid,params[],help)
{
	if(!IsAdmin(playerid)) return NotRankedEnough(playerid);
	{
	    selectid[playerid]=-1;
	    deftype[playerid]=2;
		ShowPlayerDialog(playerid,17,DIALOG_STYLE_INPUT,"Commerces","Entre ci-dessous l'ID du commerce que tu souhaites configurer.\nLaisses vide pour créer un nouveau commerce :","Entrer","Quitter");
	}
	return 1;
}

YCMD:defbiz(playerid,params[],help)
{
	if(!IsAdmin(playerid)) return NotRankedEnough(playerid);
	{
	    selectid[playerid]=-1;
	    deftype[playerid]=3;
		ShowPlayerDialog(playerid,17,DIALOG_STYLE_INPUT,"Propriété","Entre ci-dessous l'ID de la propriété que tu souhaites configurer.\nLaisses vide pour créer une nouvelle propriété :","Entrer","Quitter");
	}
	return 1;
}

/*YCMD:spawn(playerid,params[],help)
{
	if(!IsPlayerFree(playerid)) return SubMessage(playerid,MSG_RED,"T'es occupé !",5);
	SpawnPlayerEx(playerid);
	return 1;
}*/

YCMD:gar(playerid,params[],help)
{
    if(isgarageopen == true)
    {
		MoveObject(DRVGarage,-2873.3010, 426.5359, 5.7400, 0.3, 0.0);
		SendClientMessage(playerid, BLUE, "Le garage a été fermé !");
		isgarageopen = false;
	}
	else
	{
		MoveObject(DRVGarage,-2873.3010, 426.5359, 5.7400, 0.1, 90.0);
		SendClientMessage(playerid, BLUE, "Le garage a été ouvert !");
		isgarageopen = true;
	}
	return 1;
}

YCMD:spawnveh(playerid,params[],help)
{
    if(VehicleInfo[playerid][Model] == 0) return NotRankedEnough(playerid);
    {
        SetVehicleToRespawn(jvehicle[playerid]);
        SetVehicleVirtualWorld(jvehicle[playerid], 0);
		SubMessage(playerid,MSG_BLUE,"Véhicule respawn avec succès à son emplacement.",5);
	}
	return 1;
}

YCMD:callcar(playerid,params[],help)
{
    if(VehicleInfo[playerid][Model] == 0) return SubMessage(playerid,MSG_RED,"Tu n'as aucun véhicule !",5);
    {
        if(!IsPlayerFree(playerid)) return SubMessage(playerid,MSG_RED,"T'es occupé !",5);
    	new Float:x,Float:y,Float:z,Float:a;
        GetPlayerPos(playerid,x,y,z);
		GetPlayerFacingAngle(playerid,a);
		GetXYFront(x,y,a,5.0);
		SetVehiclePos(jvehicle[playerid],x, y, z+0.5);
		SetVehicleZAngle(jvehicle[playerid],a);
		SubMessage(playerid,MSG_BLUE,"Véhicule téléporté !",5);
	}
	return 1;
}

YCMD:dropcash(playerid,params[],help)
{
    new cash;
    if(sscanf(params,"d",cash)) return SendClientMessage(playerid,RED,"USAGE: /dropcash [Montant]");
    {
		if(cash < 1 || cash > PlayerInfo[playerid][pCash]) return SubMessage(playerid,MSG_RED,"Montant invalide !",5);
		{
			new string[256];
			format(string,sizeof(string),"[ADMIN] Pickup de $%d posé avec succès !",cash);
			GiveMoney(playerid,-cash);
			SendClientMessage(playerid,BLUE,string);
			new Float:x,Float:y,Float:z;
			GetPlayerPos(playerid,x,y,z);
			CreateMoneyPickup(x,y,z,cash,GetPlayerVirtualWorld(playerid),GetPlayerInterior(playerid));
		}
	}
	return 1;
}

YCMD:buyhouse(playerid,params[],help)
{
    if(PlayerInfo[playerid][pMaison] != -1) return SubMessage(playerid,MSG_RED,"T'as déjà une maison !",5);
    {
        new result,maison;
		for(new i;i<MAX_HOUSES;i++)
		{
		    if(IsPlayerInRangeOfPoint(playerid,1.0,HouseInfo[i][X1],HouseInfo[i][Y1],HouseInfo[i][Z1]))
		    {
		        result++;
				maison = i;
			}
		}
		if(result == 0) return SubMessage(playerid,MSG_RED,"Tu n'es à aucune maison !",5);
		{
		    if(HouseInfo[maison][Type]!=1) return SubMessage(playerid,MSG_RED,"Ta maison n'est pas achetable !",5);
		    {
		        if(HouseInfo[maison][Prix]>PlayerInfo[playerid][pCash]) return SubMessage(playerid,MSG_RED,"T'as pas assez d'argent pour acheter cette maison !",5);
		        {
		            new string[256],INI:File = INI_Open(UserPath(playerid));
					proprio[maison] = GetName(playerid);
					HouseInfo[maison][Type]=2;
					format(string,sizeof(string),"Tu as acheté la maison '%d' pour $%d",maison,HouseInfo[maison][Prix]);
					SubMessage(playerid,MSG_BLUE,string,5);
					GiveMoney(playerid,-HouseInfo[maison][Prix]);
					PlayerInfo[playerid][pMaison] = maison;
					INI_SetTag(File,"data");
					INI_WriteInt(File,"Maison",PlayerInfo[playerid][pMaison]);
					INI_Close(File);
					SaveHouse(maison);
					DestroyDynamicPickup(housepickup[maison][0]);
					housepickup[maison][0] = CreateDynamicPickup(19522,1,HouseInfo[maison][X1],HouseInfo[maison][Y1],HouseInfo[maison][Z1]);
					RemovePlayerMapIcon(playerid,maison);
					KillTimer(htimer[playerid]);
					for(new i;i<MAX_PLAYERS;i++)
					{
					    if(IsPlayerConnected(i))
					    {
					        SetPlayerMapIcon(i,maison,HouseInfo[maison][X1],HouseInfo[maison][Y1],HouseInfo[maison][Z1],32,0,MAPICON_LOCAL);
						}
						if(i == PlayerInfo[playerid][pMaison])
						{
							SetPlayerMapIcon(i,maison,HouseInfo[maison][X1],HouseInfo[maison][Y1],HouseInfo[maison][Z1],32,0,MAPICON_GLOBAL);
						}
					}
				}
			}
		}
	}
	return 1;
}

YCMD:buybiz(playerid,params[],help)
{
    if(PlayerInfo[playerid][pBiz] != -1) return SubMessage(playerid,MSG_RED,"T'as déjà une propriété !",5);
    {
        new result,biz;
		for(new i;i<MAX_BIZ;i++)
		{
		    if(IsPlayerInRangeOfPoint(playerid,1.0,BizInfo[i][X],BizInfo[i][Y],BizInfo[i][Z]))
		    {
		        result++;
				biz = i;
			}
		}
		if(result == 0) return SubMessage(playerid,MSG_RED,"Tu n'es à aucune propriété !",5);
		{
		    if(BizInfo[biz][Type]!=1) return SubMessage(playerid,MSG_RED,"Tu ne peux pas acheter cette propriété !",5);
		    {
		        if(BizInfo[biz][Prix]>PlayerInfo[playerid][pCash]) return SubMessage(playerid,MSG_RED,"T'as pas assez d'argent pour acheter cette propriété !",5);
		        {
		            new string[256],INI:File = INI_Open(UserPath(playerid));
					bproprio[biz] = GetName(playerid);
					BizInfo[biz][Type]=2;
					format(string,sizeof(string),"Tu as acheté la propriété ~w~%d ~b~pour ~w~$%d",biz,BizInfo[biz][Prix]);
		    		SubMessage(playerid,MSG_BLUE,string,5);
					GiveMoney(playerid,-BizInfo[biz][Prix]);
					PlayerInfo[playerid][pBiz] = biz;
					INI_SetTag(File,"data");
					INI_WriteInt(File,"Biz",PlayerInfo[playerid][pBiz]);
					INI_Close(File);
					SaveBiz(biz);
				}
			}
		}
	}
	return 1;
}

YCMD:sellbiz(playerid,params[],help)
{
	new maison = PlayerInfo[playerid][pBiz],string[256];
    if(maison == -1) return SubMessage(playerid,MSG_RED,"Tu n'as aucune propriété !",5);
    {
		if(BizInfo[maison][Type]!=2) return SubMessage(playerid,MSG_RED,"Cette propriété n'est pas vendable !",5);
		{
		    new INI:File = INI_Open(UserPath(playerid));
		    GiveMoney(playerid,BizInfo[maison][Prix]);
		    format(string,sizeof(string),"Tu as vendu ta propriété pour ~w~$%d",BizInfo[maison][Prix]);
		    SubMessage(playerid,MSG_BLUE,string,5);
			PlayerInfo[playerid][pBiz] = -1;
			BizInfo[maison][Type]=1;
			BizInfo[maison][Caisse] = 0;
			INI_SetTag(File,"data");
			INI_WriteInt(File,"Biz",PlayerInfo[playerid][pBiz]);
			INI_Close(File);
			bproprio[maison] = "";
			SaveBiz(maison);
		}
	}
	return 1;
}

YCMD:sellhouse(playerid,params[],help)
{
	new maison = PlayerInfo[playerid][pMaison],string[256];
    if(maison == -1) return SubMessage(playerid,MSG_RED,"Tu n'as aucune maison !",5);
    {
		if(HouseInfo[maison][Type]!=2) return SubMessage(playerid,MSG_RED,"Cette maison n'est pas vendable !",5);
		{
		    new INI:File = INI_Open(UserPath(playerid));
		    GiveMoney(playerid,HouseInfo[maison][Prix]);
		    format(string,sizeof(string),"Tu as vendu ta maison pour $%d",HouseInfo[maison][Prix]);
		    SubMessage(playerid,MSG_BLUE,string,5);
			PlayerInfo[playerid][pMaison] = -1;
			HouseInfo[maison][Type]=1;
			INI_SetTag(File,"data");
			INI_WriteInt(File,"Maison",PlayerInfo[playerid][pMaison]);
			INI_Close(File);
			proprio[maison] = "";
			SaveHouse(maison);
			DestroyDynamicPickup(housepickup[maison][0]);
			housepickup[maison][0] = CreateDynamicPickup(1273,1,HouseInfo[maison][X1],HouseInfo[maison][Y1],HouseInfo[maison][Z1]);
			RemovePlayerMapIcon(playerid,maison);
			htimer[playerid] = SetTimerEx("LoyerTime",60000,true,"i",playerid);
			for(new i;i<MAX_PLAYERS;i++)
			{
				if(IsPlayerConnected(i))
			    {
    				SetPlayerMapIcon(i,maison,HouseInfo[maison][X1],HouseInfo[maison][Y1],HouseInfo[maison][Z1],31,0,MAPICON_LOCAL);
				}
			}
		}
	}
	return 1;
}

YCMD:sellveh(playerid,params[],help)
{
	if(VehicleInfo[playerid][Model] == 0) return SubMessage(playerid,MSG_RED,"Tu n'as aucun véhicule !",5);
	{
		if(!IsPlayerInVehicle(playerid,jvehicle[playerid])) return SubMessage(playerid,MSG_RED,"Tu dois être dans ton véhicule pour pouvoir le vendre !",5);
		{
			new string[256];
			for(new i;i<TOTAL_VEHICLES;i++)
			{
				if(ItemVeh[i] == VehicleInfo[playerid][Model])
				{
					format(string,sizeof(string),"La vente de ton véhicule a rapporté $%d",ItemVPrice[i]);
					SubMessage(playerid,MSG_BLUE,string,5);
					GiveMoney(playerid,ItemVPrice[i]);
				}
			}
			VehicleInfo[playerid][Model] = 0;
			new INI:File = INI_Open(UserPath(playerid));
			INI_SetTag(File,"Veh");
			INI_WriteInt(File,"Model",VehicleInfo[playerid][Model]);
			INI_Close(File);
			DestroyVehicle(jvehicle[playerid]);
			jvehicle[playerid] = -1;
		}
	}
	return 1;
}

YCMD:god(playerid,params[],help)
{
	new otherid = ReturnUser(params);
	if(!IsAdmin(playerid)) return NotRankedEnough(playerid);

	if(IsPlayerConnected(otherid))
	{
		if(isnull(params)) return SendClientMessage(playerid, RED, "USAGE: /god [ID]");

		new string[128],otherplayername[MAX_PLAYER_NAME];
		GetPlayerName(otherid,otherplayername,sizeof(otherplayername));
		format(string, sizeof(string), "[ADMIN] Tu as rendu %s invincible", otherplayername);
		SendClientMessage(playerid, BLUE, string);
		SetPlayerHealth(otherid, 9999);
		SendClientMessage(otherid, BLUE, "[ADMIN] Tu es maintenant invincible !");
	}
	else
	{
		SubMessage(playerid,MSG_RED,"ID Invalide !",5);
	}
 	return 1;
}

YCMD:heal(playerid,params[],help)
{
	new otherid = ReturnUser(params);
	if(!IsAdmin(playerid)) return NotRankedEnough(playerid);

	if(IsPlayerConnected(otherid))
	{
		if(isnull(params)) return SendClientMessage(playerid, RED, "USAGE: /heal [ID]");

		new string[128],otherplayername[MAX_PLAYER_NAME];
		GetPlayerName(otherid,otherplayername,sizeof(otherplayername));
		format(string, sizeof(string), "[ADMIN] Tu as régénéré %s", otherplayername);
		SendClientMessage(playerid, BLUE, string);
		SetPlayerHealth(otherid, 100);
		SendClientMessage(otherid, BLUE, "[ADMIN] Ta vie a été régénérée !");
	}
	else
	{
		SubMessage(playerid,MSG_RED,"ID Invalide !",5);
	}
 	return 1;
}

YCMD:armour(playerid,params[],help)
{
	new otherid = ReturnUser(params);
    if(!IsAdmin(playerid)) return NotRankedEnough(playerid);
	if(IsPlayerConnected(otherid))
	{
		if(isnull(params)) return SendClientMessage(playerid, RED, "USAGE: /armour [ID]");

		new string[128],otherplayername[MAX_PLAYER_NAME];
		GetPlayerName(otherid,otherplayername,sizeof(otherplayername));
		format(string, sizeof(string), "[ADMIN] Tu as donné une armure à %s", otherplayername);
		SendClientMessage(playerid, BLUE, string);
		SetPlayerArmour(otherid, 100);
		SendClientMessage(otherid, BLUE, "[ADMIN] Tu as une armure !");
	}
	else
	{
		SubMessage(playerid,MSG_RED,"ID Invalide !",5);
	}
 	return 1;
}

YCMD:svehicle(playerid,params[],help)
{
    if(!IsAdmin(playerid)) return NotRankedEnough(playerid);
    new vid = GetPlayerVehicleID(playerid);
	new Float:px, Float:py, Float:pz;
	GetVehiclePos(vid, px, py, pz);
	new Float:rz;
	GetVehicleZAngle(vid, rz);
	new modelid = GetVehicleModel(vid);
	DestroyVehicle(vid);
	CreateVehicle(modelid, px, py, pz, rz, 0, 0, 15, true);
	PutPlayerInVehicle(playerid, vid, 0);
	return 1;
}

YCMD:anims(playerid,params[],help)
{
	SendClientMessage(playerid,BLUE,"Animations:");
    SendClientMessage(playerid,BLUE,"/handsup /drunk /bomb /arrest /sit /laugh");
    SendClientMessage(playerid,BLUE,"/crossarms /lay /vomit /eat /panic /fuck");
    SendClientMessage(playerid,BLUE,"/kiss /smoke /smoke2 /smoke3 /chat /dance");
    SendClientMessage(playerid,BLUE,"/hey /time /phone /nophone /check /gunstand");
    return 1;
}
YCMD:handsup(playerid,params[],help)
{
	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_HANDSUP);
    return 1;
}
YCMD:phone(playerid,params[],help)
{
    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
 	SetPlayerAttachedObject(playerid, 0, 18872, 6, 0.1, 0.0, 0.0, 90.0, 180.0, 0.0, 1, 1, 1);
	return 1;
}
YCMD:nophone(playerid,params[],help)
{
    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
    RemovePlayerAttachedObject(playerid, 4);
	return 1;
}
/*
YCMD:cuff(playerid,params[],help)
{
	new id = ReturnUser(params);
	if(isnull(params))
	{
		SendClientMessage(playerid,0xFF0000FF,"USAGE: /cuff [ID]");
		return 1;
	}
	else
	{
	    SetPlayerAttachedObject(id, 0, 19418, 6, -0.027999, 0.051999, -0.030000, -18.699926, 0.000000, 104.199928, 1.489999, 3.036000, 1.957999);
		SetPlayerSpecialAction(id,SPECIAL_ACTION_CUFFED);
	}
	return 1;
}
YCMD:uncuff(playerid,params[],help)
{
		new id = ReturnUser(params);
		if(isnull(params))
		{
			SendClientMessage(playerid,0xFF0000FF,"USAGE: /uncuff [ID]");
			return 1;
		}
	    RemovePlayerAttachedObject(id, 0);
		SetPlayerSpecialAction(id,SPECIAL_ACTION_NONE);
  		return 1;
}
*/
YCMD:kiss(playerid,params[],help)
{
	ApplyAnimation(playerid, "KISSING", "Grlfrd_Kiss_02", 4.0, 0, 1, 1, 0, 3, 1);
	return 1;
}
YCMD:bomb(playerid,params[],help)
{
	ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 1, 1, 0, 0, 1);
	return 1;
}
YCMD:arrest(playerid,params[],help)
{
	ApplyAnimation(playerid, "PED", "ARRESTgun", 4.0, 0, 1, 1, 0, 3, 1);
	return 1;
}
YCMD:gunstand(playerid,params[],help)
{
	ApplyAnimation(playerid, "SHOP", "ROB_Loop_Threat", 4.0, 0, 1, 1, 0, 3, 1);
	return 1;
}
YCMD:laugh(playerid,params[],help)
{
	ApplyAnimation(playerid, "RAPPING", "Laugh_01", 4.0, 0, 1, 1, 0, 3, 1);
	return 1;
}
YCMD:smoke(playerid,params[],help)
{
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_SMOKE_CIGGY);
	return 1;
}
YCMD:drunk(playerid,params[],help)
{
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_BEER);
	return 1;
}
YCMD:crossarms(playerid,params[],help)
{
	ApplyAnimation(playerid, "COP_AMBIENT", "Coplook_loop", 4.0, 0, 1, 1, 0, 3, 1);
	return 1;
}
YCMD:lay(playerid,params[],help)
{
	ApplyAnimation(playerid, "BEACH", "bather", 4.0, 0, 1, 1, 0, 3, 1);
	return 1;
}
YCMD:panic(playerid,params[],help)
{
	ApplyAnimation(playerid, "ped", "cower", 4.0, 1, 1, 1, 1, 0, 1);
	return 1;
}
YCMD:vomit(playerid,params[],help)
{
	ApplyAnimation(playerid, "FOOD", "EAT_Vomit_P", 4.0, 0, 1, 1, 0, 0, 1);
	return 1;
}
YCMD:eat(playerid,params[],help)
{
	ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4.0, 0, 1, 1, 0, 0, 1);
	return 1;
}
YCMD:hey(playerid,params[],help)
{
	ApplyAnimation(playerid, "ON_LOOKERS", "wave_loop", 4.0, 1, 1, 1, 1, 3, 1);
	return 1;
}
YCMD:chat(playerid,params[],help)
{
	ApplyAnimation(playerid, "PED", "IDLE_CHAT", 4.0, 0, 1, 1, 0, 3, 1);
 	return 1;
}
YCMD:fuck(playerid,params[],help)
{
	ApplyAnimation(playerid, "PED", "fucku", 4.0, 0, 1, 1, 0, 3, 1);
 	return 1;
}
YCMD:sit(playerid,params[],help)
{
	ApplyAnimation(playerid, "PED", "SEAT_IDLE", 4.0, 1, 1, 1, 0, 0, 1);
    return 1;
}
YCMD:time(playerid,params[],help)
{
	ApplyAnimation(playerid, "COP_AMBIENT", "Coplook_nod", 4.0, 0, 1, 1, 1, 0, 1);
 	return 1;
}
YCMD:check(playerid,params[],help)
{
	ApplyAnimation(playerid, "GANGS", "hndshkba", 4.0, 0, 1, 1, 0, 0, 1);
    return 1;
}
YCMD:stop(playerid,params[],help)
{
    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
    ClearAnimations(playerid);
    return 1;
}
YCMD:dance(playerid,params[],help)
{
    new dancestyle;
	if(sscanf(params,"d",dancestyle))
	{
		SendClientMessage(playerid,0xFF0000FF,"USAGE: /dance [style 1-4]");
		return 1;
	}
	if(dancestyle < 1 || dancestyle > 4)
	{
	    SendClientMessage(playerid,0xFF0000FF,"USAGE: /dance [style 1-4]");
	    return 1;
	}

	if(dancestyle == 1) {
	    SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE1);
	} else if(dancestyle == 2) {
	    SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE2);
	} else if(dancestyle == 3) {
	    SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE3);
	} else if(dancestyle == 4) {
	    SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE4);
	}
	return 1;
}
public OnPlayerCommandReceived(playerid, cmdtext[], success)
{
	new string[256];
	if(IsLogged[playerid] == false) return SubMessage(playerid,MSG_RED,"Vous n'êtes pas connecté !",5);

	format(string,sizeof(string),"[CMD] %s [%i] : %s",GetName(playerid),playerid,cmdtext);
	for(new i; i < MAX_PLAYERS; i++)
	{
	    if(IsAdmin(i) && vcmds[i] == true)
	    {
			SendClientMessage(i,BLUE,string);
		}
	}
	print(string);
	if(success == 2)
	{
	    format(string,sizeof(string),"Commande '{ffffff}%s{AA3333}' inconnue !",cmdtext);
	    SendClientMessage(playerid,RED,string);
	    return 1;
	}
	return 1;
}

