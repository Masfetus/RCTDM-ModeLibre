// SFTDM2 Traduit par Metrakit de l'équipe :
// www.Gta-Mp.fr www.Gta-Host.fr
// Gta-Host.fr : Votre hébergeur sa-mp profesionnel !
//Credits goes to:
//Cam some of the classes are his
//CodeMaster added the selection screen sounds and the kool Team chat
//Nitroglycerine for tree id :P
//DM Messages by yellowblood
//Necrioss for the wicked car/stats save system and the login/enregistrer system and settings file
//[CBK]$$$PiMp Made this
//===============================Include Files==================================
#include <a_samp>
#include <dini>
#include <dudb>
#include <time>
#include <file>
#include <dutils>
#include <float>
//===============================Class Defines==================================
#define TEAM_WORKER 0
#define TEAM_PIMP 1
#define TEAM_GOLFER 2
#define TEAM_TRIAD 3
#define TEAM_ARMY 4
#define TEAM_VALET 5
#define TEAM_MEDIC 6
#define TEAM_FBI 7
#define TEAM_CHICKEN 8
#define TEAM_RICH 9
#define TEAM_PILOT 10
#define TEAM_DANANG 11
//========================0.2 Forward Declarations==============================
//forward PlayerName(playerid);

forward changecolor1();
forward changecolor2();

forward Gangs();
forward Keys();
forward Float:GetOptimumRampDistance(playerid);
forward Float:GetXYInFrontOfPlayer(playerid, &Float:x, &Float:y, Float:distance);
forward AddStaticVehicle2(modelid, Float:spawn_x, Float:spawn_y, Float:spawn_z, Float:z_angle, color1, color2);
forward keys2();
forward IsPlayerNameOnline(compname[]);
forward profitup();
forward SetupPlayerForClassSelection(playerid);
forward SetCheckpoint(playerid, i);
forward PlaySoundForPlayer(playerid, soundid);
forward weapreturn(playerid);
forward dteamchatcmd(playerid,params[]);
forward checkpointUpdate();
forward getCheckpointType(playerID);
forward isPlayerInArea(playerID, Float:data[4]);
forward ctimer();
forward resetcount();
forward announcer();
forward scoreupdate();
forward eject();
forward CheckSpeedo(playerid);
forward SystemMsg(playerid,msg[]);
forward resetcar();
forward PhoneCut();
forward Settings();
forward SaveData();
forward SoundForAll(sound);
forward resetmessage();
forward newracestart();
forward kartraceann();
forward kartraceready();
forward startkart();
forward vehiclecheck();
forward raceend();
forward racercheck();
forward hoverraceann();
forward hoverraceready();
forward starthover();
forward quadraceann();
forward quadraceready();
forward startquad();
forward GameModeExitFunc();
forward GetPlayers();
forward SetPlayerRandomSpawn(playerid);
forward SetupPlayerForClassSelection(playerid);
//==============================Settings Files==================================
#define FILE_SETTINGS "settings.ini"
//=============================Max Points/Gangs=================================
#pragma dynamic 40000
#define CallCost 1
#define MAX_CARS 251
#define MAX_POINTS 63
#define BIZ_AMOUNT 60
#define MAX_SCORE 99 //max score for when the round's over
//===============================Checkpoint defines===================================
#define CP_BANK 		20
#define CP_BANK_2 		21
#define CP_BANK_3 		22
#define BIZ1 			23
#define BIZ2			24
#define BIZ3    25
#define BIZ4    26
#define BIZ5    27
#define BIZ6    28
#define BIZ7    29
#define BIZ8    30
#define BIZ9    31
#define BIZ10   32
#define BIZ11   33
#define BIZ12   34
#define BIZ13   35
#define BIZ14   36
#define BIZ15   37
#define BIZ16   38
#define BIZ17   39
#define BIZ18   40
#define BIZ19   41
#define BIZ20   42
#define BIZ21   43
#define BIZ22   44
#define BIZ23   45
#define BIZ24   46
#define BIZ25   47
#define BIZ26   48
#define BIZ27   49
#define BIZ28   50
#define BIZ29   51
#define BIZ30   52
#define BIZ31   53
#define BIZ32   54
#define BIZ33   55
#define BIZ34   56
#define BIZ35   57
#define BIZ36   58
#define BIZ37   59
#define BIZ38   60
#define BIZ39   61
#define BIZ40   62
#define BIZ41   63
#define BIZ42   64
#define BIZ43   65
#define BIZ44   66
#define BIZ45   67
#define BIZ46   68
#define BIZ47   69
#define BIZ48   70
#define BIZ49   71
#define BIZ50   72
#define BIZ51   73
#define BIZ52   74
#define BIZ53   75
#define BIZ54   76
#define BIZ55   77
#define BIZ56   78
#define BIZ57   79
#define BIZ58   80
#define BIZ59   81
#define BIZ60   82
//================================Vehicle Defines===============================
new VehicleName[212][0] = {
   "Landstalker",
   "Bravura",
   "Buffalo",
   "Linerunner",
   "Pereniel",
   "Sentinel",
   "Dumper",
   "Firetruck",
   "Trashmaster",
   "Stretch",
   "Manana",
   "Infernus",
   "Voodoo",
   "Pony",
   "Mule",
   "Cheetah",
   "Ambulance",
   "Leviathan",
   "Moonbeam",
   "Esperanto",
   "Taxi",
   "Washington",
   "Bobcat",
   "Mr Whoopee",
   "BF Injection",
   "Hunter",
   "Premier",
   "Enforcer",
   "Securicar",
   "Banshee",
   "Predator",
   "Bus",
   "Rhino",
   "Barracks",
   "Hotknife",
   "Trailer", //artict1
   "Previon",
   "Coach",
   "Cabbie",
   "Stallion",
   "Rumpo",
   "RC Bandit",
   "Romero",
   "Packer",
   "Monster Truck",
   "Admiral",
   "Squalo",
   "Seasparrow",
   "Pizzaboy",
   "Tram",
   "Trailer", //artict2
   "Turismo",
   "Speeder",
   "Reefer",
   "Tropic",
   "Flatbed",
   "Yankee",
   "Caddy",
   "Solair",
   "Berkley's RC Van",
   "Skimmer",
   "PCJ-600",
   "Faggio",
   "Freeway",
   "RC Baron",
   "RC Raider",
   "Glendale",
   "Oceanic",
   "Sanchez",
   "Sparrow",
   "Patriot",
   "Quad",
   "Coastguard",
   "Dinghy",
   "Hermes",
   "Sabre",
   "Rustler",
   "ZR-350",
   "Walton",
   "Regina",
   "Comet",
   "BMX",
   "Burrito",
   "Camper",
   "Marquis",
   "Baggage",
   "Dozer",
   "Maverick",
   "News Chopper",
   "Rancher",
   "FBI Rancher",
   "Virgo",
   "Greenwood",
   "Jetmax",
   "Hotring",
   "Sandking",
   "Blista Compact",
   "Police Maverick",
   "Boxville",
   "Benson",
   "Mesa",
   "RC Goblin",
   "Hotring Racer", //hotrina
   "Hotring Racer", //hotrinb
   "Bloodring Banger",
   "Rancher",
   "Super GT",
   "Elegant",
   "Journey",
   "Bike",
   "Mountain Bike",
   "Beagle",
   "Cropdust",
   "Stunt",
   "Tanker", //petro
   "RoadTrain",
   "Nebula",
   "Majestic",
   "Buccaneer",
   "Shamal",
   "Hydra",
   "FCR-900",
   "NRG-500",
   "HPV1000",
   "Cement Truck",
   "Tow Truck",
   "Fortune",
   "Cadrona",
   "FBI Truck",
   "Willard",
   "Forklift",
   "Tractor",
   "Combine",
   "Feltzer",
   "Remington",
   "Slamvan",
   "Blade",
   "Freight",
   "Streak",
   "Vortex",
   "Vincent",
   "Bullet",
   "Clover",
   "Sadler",
   "Firetruck", //firela
   "Hustler",
   "Intruder",
   "Primo",
   "Cargobob",
   "Tampa",
   "Sunrise",
   "Merit",
   "Utility",
   "Nevada",
   "Yosemite",
   "Windsor",
   "Monster Truck", //monstera
   "Monster Truck", //monsterb
   "Uranus",
   "Jester",
   "Sultan",
   "Stratum",
   "Elegy",
   "Raindance",
   "RC Tiger",
   "Flash",
   "Tahoma",
   "Savanna",
   "Bandito",
   "Freight", //freiflat
   "Trailer", //streakc
   "Kart",
   "Mower",
   "Duneride",
   "Sweeper",
   "Broadway",
   "Tornado",
   "AT-400",
   "DFT-30",
   "Huntley",
   "Stafford",
   "BF-400",
   "Newsvan",
   "Tug",
   "Trailer", //petrotr
   "Emperor",
   "Wayfarer",
   "Euros",
   "Hotdog",
   "Club",
   "Trailer", //freibox
   "Trailer", //artict3
   "Andromada",
   "Dodo",
   "RC Cam",
   "Launch",
   "Police Car (LSPD)",
   "Police Car (SFPD)",
   "Police Car (LVPD)",
   "Police Ranger",
   "Picador",
   "S.W.A.T. Van",
   "Alpha",
   "Phoenix",
   "Glendale",
   "Sadler",
   "Luggage Trailer", //bagboxa
   "Luggage Trailer", //bagboxb
   "Stair Trailer", //tugstair
   "Boxville",
   "Farm Plow", //farmtr1
   "Utility Trailer" //utiltr1
};

new	heavycar[24][0] = {
	{406},
	{444},
	{556},
	{557},
	{573},
	{601},
	{407},
	{427},
	{433},
	{434},
	{499},
	{498},
	{482},
	{431},
	{524},
	{578},
	{455},
	{403},
	{414},
	{443},
	{515},
	{428},
	{408},
	{456}
};
new	boat[11][0] = {
	{472},
	{473},
	{493},
	{595},
	{484},
	{430},
	{453},
	{452},
	{446},
	{454},
	{539}
};
new	mbike[11][0] = {
	{581},
	{521},
	{462},
	{463},
	{468},
	{471},
	{586},
	{522},
	{523},
	{461},
	{448}
};
new	pbike[3][0] = {
	{481},
	{509},
	{510}
};
new	splane[6][0] = {
	{593},
	{512},
	{513},
	{460},
	{464},
	{465}
};
new	mplane[2][0] = {
	{519},
	{511}
};
new	lplane[2][0] = {
	{553},
	{592}
};
new milair[4][0] = {
	{520},
	{476},
	{447},
	{425}
};
new sheli[4][0] = {
	{487},
	{488},
	{469},
	{497}
};
new lheli[3][0] = {
	{417},
	{548},
	{563}
};
//===========================Character Selection Music==========================
#define SOUND_MUSIC1							1062
#define SOUND_MUSIC2							1068
#define SOUND_MUSIC3							1076
#define SOUND_OFF                    			1184
//=================================Team Colors==================================
#define COLOR_GREEN 0x33AA33AA //SFgrove color
#define COLOR_RED 0xAA3333AA //pimp color
#define COLOR_PINK 0xFF66FFAA //triad color
#define COLOR_BLUE 0x0000BBAA //mechanic color
#define COLOR_LIGHTBLUE 0x33CCFFAA //pilot color
#define COLOR_ORANGE 0xFF9900AA //Swat color
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_PURPLE 0x330066AA
#define COLOR_GREY 0xCCCCCAA
#define COLOR_SKIN 0xFFCC99AA
#define COLOR_DARKGREY 0x333333AA
#define COLOR_DARKRED 0x990000AA
#define RED 0xFF0000AA
#define COLOR_INDIGO 0x4B00B0AA
#define COLOR_BRIGHTRED 0xDC143CAA
#define COLOR_AQUA 0x7CFC00AA
#define COLOR_SYSTEM 0xEFEFF7AA
//===============================Modified DCMD==================================
#define cmd(%1) if((strcmp(cmdtext,%1,true,strlen(%1))==0)&&(((cmdtext[strlen(%1)]==0)&&(d%1(playerid,"")))||((cmdtext[strlen(%1)]==32)&&(d%1(playerid,cmdtext[strlen(%1)+1]))))) return 1
//================================Admin Stuff===================================
enum pInfo
{
    pAdmin,
    pJailedby,
}
//==================================Defines=====================================
new teamchatcmd[]  = "/t";
new gVehicleClass[MAX_VEHICLES];
new gVC;

new playercount[MAX_PLAYERS];
new biznote[MAX_PLAYERS];
new carnote[MAX_PLAYERS];
new Calling[MAX_PLAYERS];
new Answered[MAX_PLAYERS];
new Callerid[MAX_PLAYERS];
new allowprofit[MAX_PLAYERS];
new profit[MAX_PLAYERS];
new totalprofit[MAX_PLAYERS];
new bizid[MAX_PLAYERS];
new cttmp[256];
new tmpname[256];
new ownername[256];
new propmess[256];
new propcost[MAX_PLAYERS];
new propowned[MAX_PLAYERS];
new buyable[MAX_PLAYERS];
new playernameh[MAX_PLAYER_NAME];
new playerbiz[MAX_PLAYERS];
new Count[MAX_PLAYERS];
new cseconds,cstring[40];
new PlayerInfo[MAX_PLAYERS][pInfo];
new moneyed[MAX_PLAYERS];
new ignition[MAX_PLAYERS];
new secure[MAX_PLAYERS];
new admined[MAX_PLAYERS];
new bought[MAX_PLAYERS];
new carowned[MAX_PLAYERS];
new currentvehicle[MAX_PLAYERS];
new carcost[256];
new server[256];
new passenger[MAX_PLAYERS];
new cartemp[MAX_PLAYERS];
new gTeam[MAX_PLAYERS];
new Spawned[MAX_PLAYERS];
new tmpcar[MAX_PLAYERS];
new welcome[MAX_PLAYERS];
new frozen[MAX_PLAYERS];
new speedo[MAX_PLAYERS];
new messaged[MAX_PLAYERS];
new used[MAX_PLAYERS];
new CashScoreOld;
new tmpcar2[MAX_PLAYERS];
new aMessage[MAX_PLAYERS];
new setd[MAX_PLAYERS];
new propactive[MAX_PLAYERS];
new amount[MAX_PLAYERS];
new biznum[MAX_PLAYERS];
new telemoney[MAX_PLAYERS];
new carbuyable[MAX_PLAYERS];
new bizbuyable[MAX_PLAYERS];
new tempid[MAX_PLAYERS];
new carname[256];
new lockmess[256];
new securemess[256];
new carmess[256];
new password[256];
new oldvehcount;

new Float:g, Float:h, Float:l;
new Float:t, Float:u, Float:o;
//================================Checkpoints===================================
new Float:checkCoords[MAX_POINTS][4] = {
{-36.5483,-57.9948, -17.2655,-49.2967},     	//BANK
{-37.2183,-91.8006, -14.1099,-74.6845},      	//BANK_2
{-34.6621,-31.4095, -2.6782,-25.6232},     		//BANK_3
{2059.7805,1020.1033,2289.0493,1193.4093},
{2055.5642,1533.3348,2200.9768,1753.8568},
{2114.8748,1775.9012,2277.7209,1891.3472},
{2146.1289,1893.4567,2342.6091,1950.9486},
{2137.8066,2038.1023,2223.3726,2143.6411},
{2225.2517,2088.4695,2359.3306,2143.9646},
{1842.4160,1264.5808,2059.4907,1454.3223},
{1968.2183,929.2423,2054.0447,1096.8796},
{2056.7427,1444.7155,2190.7131,1537.8398},
{2537.2771,2232.3604,2664.7832,2461.8420},
{2027.6141,2288.6062,2177.2280,2443.9287},
{2322.5151,1603.0068,2550.0662,1714.9113},
{1976.6951,1846.7843,2138.2932,2028.0287},
{2517.0713,2125.2759,2540.1426,2140.9841},
{2517.1316,2279.6184,2540.0034,2314.0369},
{2309.3223,2231.9849,2239.1592,2263.0171},
{2307.8157,2404.8630,2365.8564,2427.3931},
{2113.8269,1420.0763,2169.8450,1448.3851},
{2133.8765,1424.9305,2158.0867,1449.6304},
{2081.6860,2033.0593,2136.8855,2121.2231},
{2405.2615,2044.4905,2429.2261,2070.7527},
{2512.7620,2292.9004,2538.0837,2316.1021},
{2405.6833,2001.2031,2427.2678,2024.1396},
{2210.8799,1418.5393,2221.6172,1434.6121}, //num24
{1004.0436,1378.4221,1238.1447,1789.2527},
{1303.5311,2043.1515,1575.4657,2310.8394},
{1982.6249,1481.2999,2055.5203,1587.4567},
{2138.1567,908.3344,2207.1643,980.6557},
{2518.3003,2046.3043,2621.8103,2114.5112},
{2501.6440,1985.4578,2550.4285,2055.2839},
{2484.2690,2229.0103,2534.2617,2246.9116},
{2166.9695,1354.7913,2251.1807,1443.4131},
{1921.2307,2014.2312,1995.0787,2118.3655},
{2076.9065,2203.9939,2086.9548,2222.7378},
{2516.0190,2140.3875,2549.2168,2156.4136},
{2579.2708,1827.0596,2638.5925,1869.3435},
{2102.8501,2225.0020,2128.5029,2233.7532},
{2341.3113,2023.0891,2418.6460,2059.8914},
{2601.2441,1656.5068,2637.8970,1678.0903},
{2336.8066,2054.1135,2403.8230,2083.4001},
{2421.8442,1971.7770,2507.7588,2059.8337},
{1101.3241,2043.9854,1189.1630,2148.9053},
{2427.3594,2044.5748,2449.6052,2070.0330},
{2467.3035,2037.6560,2527.0105,2068.9089},
{2347.1316,2086.8259,2436.4583,2143.5769},
{2102.3923,2232.8354,2132.9700,2279.6086},
{2086.9155,2206.2480,2095.4680,2223.6389},
{2404.2832,1967.7424,2439.7622,2000.2843},
{2172.5940,1458.2136,2201.1655,1537.2443},
{2094.0740,2204.3918,2104.2151,2223.1936},
{2206.0823,1947.1849,2137.1362,2023.3031},
{2449.7007,2043.6879,2469.7415,2074.7456},
{2503.3691,1940.5511,2610.8059,2002.4291},
{2514.7412,2153.7595,2546.4314,2176.9170},
{2515.2012,2324.6948,2542.5288,2350.3384},
{2089.9951,2107.3723,2129.4351,2138.4326},
{2035.4915,2104.2634,2089.2329,2126.5642},
{2337.3936,1961.5359,2392.2026,2023.3726},
{2197.4590,1418.8319,2212.3408,1436.3138},
{2219.5940,1416.0967,2250.4465,1436.7446}
};

new Float:checkpoints[MAX_POINTS][4] = {
{-22.2549,-55.6575,1003.5469,2.5},
{-23.0664,-90.0882,1003.5469,2.5},
{-33.9593,-29.0792,1003.5573,2.5},
{2181.2170,1117.3793,12.2120,2.5},
{2185.4421,1691.4431,10.6553,2.5},
{2219.9041,1839.5925,10.3847,2.5},
{2162.7468,1903.8865,10.3884,2.5},
{2167.2166,2117.6150,10.3809,2.5},
{2317.3208,2117.7710,10.3882,2.5},
{1934.8152,1344.3130,9.5411,2.5},
{2028.6173,997.6895,10.3901,2.5},
{2139.1824,1483.6544,10.3850,2.5},
{2634.2117,2342.9260,10.2322,2.5},
{2127.1482,2374.2432,10.3928,2.5},
{2433.9910,1694.5219,10.3891,2.5},
{2027.4666,1919.8239,11.8970,2.5},
{2535.0242,2137.1760,10.3844,2.5},
{2533.9272,2290.7966,10.3965,2.5},
{2292.8953,2250.4241,10.3915,2.5},
{2327.7629,2418.4009,10.3137,2.5},
{2125.8101,1439.5314,10.3825,2.5},
{2144.4243,1438.7078,10.3857,2.5},
{2088.1013,2080.2449,10.5105,2.5},
{2413.2683,2063.5012,10.3790,2.5},
{2516.7546,2302.4880,10.3827,2.5},
{2412.0635,2016.4637,10.3789,2.5},
{2215.1062,1431.6699,10.6265,2.5},
{1098.4010,1611.0776,12.1107,2.5},
{1479.4565,2252.0762,10.5973,2.5},
{2004.3060,1544.7435,13.1615,2.5},
{2155.3611,937.0895,10.3759,2.5},
{2536.4421,2078.7681,10.3914,2.5},
{2518.4578,2033.5502,10.6029,2.5},
{2500.1050,2240.7932,10.3955,2.5},
{2200.1270,1388.8220,10.3802,2.5},
{1945.0096,2069.8103,10.3847,2.5},
{2081.3513,2221.6086,10.3705,2.5},
{2537.7957,2151.2844,10.3940,2.5},
{2634.9871,1845.2051,10.5572,2.5},
{2107.3560,2229.2830,10.7454,2.5},
{2395.3364,2044.5300,10.3796,2.5},
{2635.2498,1673.8412,10.5941,2.5},
{2364.5168,2076.1494,10.3798,2.5},
{2464.9089,2034.4392,10.5851,2.5},
{1162.8470,2070.3850,10.3921,2.5},
{2436.7664,2061.3137,10.3951,2.5},
{2490.2861,2062.2139,10.3753,2.5},
{2366.6399,2123.9949,10.4007,2.5},
{2106.3506,2250.8586,10.5889,2.5},
{2090.6064,2220.4714,10.3877,2.5},
{2411.2610,1992.9418,10.3783,2.5},
{2195.4019,1469.8882,10.3641,2.5},
{2095.6563,2221.7317,10.3953,2.5},
{2192.3142,1986.8772,11.6534,2.5},
{2456.7498,2060.2307,10.3932,2.5},
{2542.1289,1969.6676,10.3852,2.5},
{2536.7393,2162.0422,10.3918,2.5},
{2519.7532,2335.0073,10.3927,2.5},
{2099.8533,2120.0144,10.3961,2.5},
{2070.7163,2120.6021,10.3895,2.5},
{2366.6096,1981.6423,10.3858,2.5},
{2206.2791,1431.5449,10.6267,2.5},
{2228.6863,1431.7811,10.6125,2.5}
};
//=================================Save Player Pos==============================
enum SavePlayerPosEnum
{
    Float:LastX,
    Float:LastY,
    Float:LastZ
}
new SavePlayerPos[MAX_PLAYERS][SavePlayerPosEnum];
//=================================Checkpoint Type==============================
new checkpointType[MAX_POINTS] = {
	CP_BANK,
	CP_BANK_2,
	CP_BANK_3,
	BIZ1,
	BIZ2,
	BIZ3,
	BIZ4,
	BIZ5,
	BIZ6,
	BIZ7,
	BIZ8,
	BIZ9,
	BIZ10,
	BIZ11,
	BIZ12,
	BIZ13,
	BIZ14,
	BIZ15,
	BIZ16,
	BIZ17,
	BIZ18,
	BIZ19,
	BIZ20,
	BIZ21,
	BIZ22,
	BIZ23,
	BIZ24,
	BIZ25,
	BIZ26,
	BIZ27,
	BIZ28,
	BIZ29,
	BIZ30,
	BIZ31,
	BIZ32,
	BIZ33,
	BIZ34,
	BIZ35,
	BIZ36,
	BIZ37,
	BIZ38,
	BIZ39,
	BIZ40,
	BIZ41,
	BIZ42,
	BIZ43,
	BIZ44,
	BIZ45,
	BIZ46,
	BIZ47,
	BIZ48,
	BIZ49,
	BIZ50,
	BIZ51,
	BIZ52,
    BIZ53,
    BIZ54,
    BIZ55,
    BIZ56,
    BIZ57,
    BIZ58,
    BIZ59,
    BIZ60,
};
//================================More Defines==================================
new Float:ta, Float:tb, Float:tc;
new logged[MAX_PLAYERS];
new bank[999];
new PlayerInterior[MAX_PLAYERS];
new carused[MAX_PLAYERS];
new playerCheckpoint[MAX_PLAYERS];
new reset[MAX_PLAYERS];
new ejected[MAX_PLAYERS];
//================================Global Defines================================
new Float:Pos[MAX_PLAYERS][4];
//new tk[MAX_PLAYERS];
//================================Main Info=====================================
				main()
				{
				print(" ");
				print("\n--------------------------------------");
				print(" SFTDM Reloaded 2.0 FINAL By [CBK]$$$PiMp!!!");
				print("--------------------------------------\n");}
//=================================Telephone====================================
public PhoneCut()
{
	for (new i = 0; i < MAX_PLAYERS; i++)
	{
		if (IsPlayerConnected(i))
		{
			if (Calling[i] > -1 && Answered[i] == 1 && Callerid[i] == 1)
			{
				if (GetPlayerMoney(i) >= CallCost)
				{
					GivePlayerMoney(i, -CallCost);
				}
				if (GetPlayerMoney(i) < CallCost)
				{
					SendClientMessage(i, COLOR_BRIGHTRED, "COUPER: Vous n'avez pas assez d'argent pour continuer cet appel!");
					SendClientMessage(Calling[i], COLOR_BRIGHTRED, "COUPER: Votre téléphone a été coupé pour manque de degré de solvabilité");
					Calling[Calling[i]] = -1;
					Answered[Calling[i]] = 0;
					Calling[i] = -1;
					Answered[i] = 0;
					Callerid[i] = 0;
				}
			}
		}
	}
	return 1;
}

public OnPlayerText(playerid, text[])
{
	if (Calling[playerid] > -1 && Answered[playerid] == 1)
	{
    	new string[256];
		new sendername[MAX_PLAYER_NAME];
		GetPlayerName(playerid, sendername, sizeof(sendername));
		format(string, sizeof(string), "%s: %s", sendername, text);
		SendClientMessage(Calling[playerid], COLOR_YELLOW, string);
		format(string, sizeof(string), "%s: %s", sendername, text);
		SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
		format(string, sizeof(string), "%s: %s", sendername, text);
		print(string);
		format(string, sizeof(string), "%s: %s", sendername, text);
		print(string);
		return 0;
	}
	return 1;
}
//================================GameMode Exit=================================
public OnGameModeExit()
{
	dini_IntSet(FILE_SETTINGS,"vehicleresetcount",gVC);
	return 1;
}
//===============================Gamemode Start=================================
public OnGameModeInit()
{
	print("\n \nGameModeInit(SFTDM Reloaded 2.0)");
	SetGameModeText("SFTDM 2.0");
	ShowNameTags(1);
	ShowPlayerMarkers(1);
	SetWorldTime(12);
	SetTimer("changecolor1", 2000, 1);
    SetTimer("changecolor2", 4000, 1);
	SetTimer("CheckSpeedo", 700, 1);
	SetTimer("SaveData",1000,1);
    SetTimer("Settings",1000,1);
    SetTimer("checkpointUpdate",100, 1);
    SetTimer("scoreupdate",1000,1);
    SetTimer("ctimer",1000,1);
    SetTimer("profitup",300000,1);
    SetTimer("PhoneCut",1000,1);
	oldvehcount = dini_Int(FILE_SETTINGS,"vehicleresetcount");
    UsePlayerPedAnims();
//==============================ALL GAME TEAMS==================================
	//Classes Note: Some of the Classes are Cams so give Credit to him too
	AddPlayerClass(260,-2062.5583,237.4662,36.2890,268.8936,23,170,25,60,30,360); //Worker
	AddPlayerClass(296,-2653.6443,1388.2767,8.0739,212.8453,26,100,29,360,15,1); //Pimp
	AddPlayerClass(259,-2642.2583,-274.9985,8.3506,135.0036,25,80,32,300,2,1); //Golfer
	AddPlayerClass(294,-2188.8037,609.8431,36.2624,82.8703,32,300,30,390,4,1); //Triad
	AddPlayerClass(287,-1377.4271,466.0897,8.9393,1.0348,26,80,31,300,23,170); // ARMY
	AddPlayerClass(253,-1754.9976,958.5851,25.8386,163.2550,28,300,24,100,4,1); //Valet
	AddPlayerClass(274,-2665.4282,635.6348,16.0054,179.8403,26,100,23,170,9,1); //Medic
	AddPlayerClass(286,-1635.0077,665.8105,8.4054,264.2244,29,360,27,100,3,1); //FBI
	AddPlayerClass(167,-2681.2529,266.1666,4.3359,2.8437,26,200,29,390,9,1); //Chicken
	AddPlayerClass(295,-2664.8037,938.6110,80.7618,180.7716,27,100,24,100,28,400); //Rich
	AddPlayerClass(61,-1358.6774,-243.8737,15.6769,315.6869,22,170,25,60,14,1); // Pilot
	AddPlayerClass(122,-1430.1825,1492.3381,8.0482,91.3221,24,70,27,77,28,300); //Da Nang
//========================ALL GAME VEHICLES AND PICKUPS=========================
//----------------------------------Vehicles------------------------------------
	AddStaticVehicle2(415,-2252.8276,2285.2219,4.8202,90.7733,14,1);//CHEETAH sv 1
	AddStaticVehicle2(451,-2271.7480,2297.3911,4.8202,270.8565,14,1);//turismo sv 2
	AddStaticVehicle2(562,-2252.5969,2290.9824,4.8202,85.6504,14,1);//ELEGY sv 3
	AddStaticVehicle2(405,-1304.1517,2528.5356 ,87.6315,181.3323,66,66); //hobo
	AddStaticVehicle2(411,-2691.1743,220.3039,4.1797,89.5966,0,10);//infernus trans
	AddStaticVehicle2(415,-1985.6321,258.8751,36.1719,270.8373,0,101);//ferrari at car dealer
//AddStaticVehicle2(419,-1266.4242,2525.7771,89.4997,106.5754,66,66); //hobo
	AddStaticVehicle2(424,-2236.2820,-1724.1927,480.8605,10.4293,2,0);// BFinjection Cill 424--
	AddStaticVehicle2(424,-488.3469,-174.9918,78.2109,175.4913,2,0);// BFinjection FOREST
	AddStaticVehicle2(424,-2653.9656,-2418.3093,2.6874,101.4916,2,0); //BF Injection dunes
	AddStaticVehicle2(424,-2654.8750,-2413.8379,2.6877,101.4914 ,2,0); //BF Injection dunes
//AddStaticVehicle2(439,-1287.0046,2514.1675,86.7848,179.9851,6,6); //stallion
//AddStaticVehicle2(443,-2145.7261,918.4642,79.8516,266.2144,0,101); //CAR CARRIER
	AddStaticVehicle2(444,-2247.1477,-1727.6178,480.2036,38.2774,3,6);//monster Chill 444---
	AddStaticVehicle2(444,-557.6980,-177.3288,78.4063,169.0153,3,6);//monster FOREST
	AddStaticVehicle2(444,-1321.4635,2513.2258,92.5406,180.9954,65,66);//monster hobo
	AddStaticVehicle2(446,-2244.3376,2435.2117,-0.5616,227.1463,14,1);//SPEEDBOAT1 sv 13
	AddStaticVehicle2(446,-2218.8831,2405.2954,-0.5339,45.1995,14,1);//DPEEDBOAT2 sv
	AddStaticVehicle2(451,-2047.5374,901.2433,53.6883,8.7998,2,101);//turismo crooked
	AddStaticVehicle2(451,-1953.6819,259.0149,35.4688,92.4245,106,0); //Turismo
	AddStaticVehicle2(451,-345.9050,1515.0657,75.1318,358.8066,5,101); // drif3 1 turismo
	AddStaticVehicle2(451,-333.4294,1515.0460,75.1313,1.3186,9,101); // drif3 5 turismo
//AddStaticVehicle2(461,-2079.4136,901.8524,64.1328,1.9898,6,101);//pcj600 at crooked str
//AddStaticVehicle2(461,-473.0953,-175.8979,78.2109,180.0741,6,101);//pcj600 FOREST
 	AddStaticVehicle2(468,-2243.3403,-1745.0731,480.1822,11.6067,6,101);//chill sanchez
 	AddStaticVehicle2(468,-2244.4622,-1739.6124,479.7912,11.6067,6,101);//chill sanches
 	AddStaticVehicle2(468,-2654.0969,-2419.7952,2.5891,106.6930,6,101); //Sanchez dunes
	AddStaticVehicle2(468,-2652.5967,-2424.7976,2.5885,106.6923,6,101); //Sanchez dunes
 	AddStaticVehicle2(470,-1857.3772,-1616.0371,21.8090,181.0974,6,101);// patriot rock
    AddStaticVehicle2(470,-2271.9880,2285.2322,4.8202,276.4501,1,1);//HUMMER sv
	AddStaticVehicle2(470, -500.7715,-200.4563,78.4063,18.7517,0,0); //Patriot FOREST
	AddStaticVehicle2(471,-2241.2891,-1738.7552,480.0252,19.2248,102,1);//Quad Chill 471--
	AddStaticVehicle2(471,-564.0124,-198.6842,78.5869,1.2558,102,1);//Quad FOREST
	AddStaticVehicle2(487,-1303.4076,2541.8,93.3047,181.9564,66,117); // hobo MAVERIC
	AddStaticVehicle2(506,-339.8088,1514.8138,75.1312,359.8656,7,101); // drif3 3 supergt
	AddStaticVehicle2(507,-2736.9631,-294.5043,7.0010,229.3018,0,1); //elegant hotel
//AddStaticVehicle2(518,-1308.3707,2542.2786,87.7422,185.9490,20,0); // hobo
	AddStaticVehicle2(520,-2227.4072,2326.7725,7.5469,94.0051,1,1);// HYDRA
	AddStaticVehicle2(521,-1969.1692,304.1157,36.1719,79.3382,79,103);//car dealer bike1
	AddStaticVehicle2(521,-2136.9282,932.2380,79.8516,1.2085,79,103);//lombardi str bike1
	AddStaticVehicle2(521,-2272.1670,2291.3350,4.8202,266.2305,14,1);//900 sv
	AddStaticVehicle2(522,-1702.4731,71.8880,9.5940,315.7556,0,1);// nrg1bowl
	AddStaticVehicle2(522,-1622.2825,-49.7379,3.5638,47.6917,0,1);// nrg2
	AddStaticVehicle2(522,-1533.1570,113.2838,17.3281,130.9336,0,1);// nrg3
	AddStaticVehicle2(522,-1585.6379,144.1861,3.7169,39.9833,0,1);// nrg4
	AddStaticVehicle2(522,-1739.4352,37.0431,7.1512,272.7602,0,1);// nrg5bowl
	AddStaticVehicle2(522,-1986.7144,271.9079,36.1794,268.4854,86,16);//car dealer bike 2  type 30
//AddStaticVehicle2(539,-2237.4849,-1714.5706,480.8717,8.4956,106,101); //hover Chillz1
//AddStaticVehicle2(539,-2236.8608,-1718.7449,480.8733,4.4400,106,101); //hover Chillz2
//AddStaticVehicle2(540,-2750.0332,-296.7870,7.0391,359.7908,0,1); //vincent hotel
	AddStaticVehicle2(541,-1950.8169,271.1274,41.0471,270.7263,106,1);//bullet cardealer2
	AddStaticVehicle2(541,-2105.4585,893.4119,74.7031,358.1261,0,1);//bullet crooked str
//AddStaticVehicle2(555,-2747.0229,-306.4174,7.0391,51.1989,0,1); //Windsor hotel
//AddStaticVehicle2(557,-1821.7633,-1613.2203,23.0156,194.1226,0,1);// monster2 rock
	AddStaticVehicle2(559,-2703.7295,200.9682,4.1797,359.6772,101,6);//car2 trans
	AddStaticVehicle2(559,-1989.1759,243.6824,35.1719,272.5235,106,6);//jester cardealer
	AddStaticVehicle2(559,-2252.7041,2297.0837,4.8125,85.1043,14,1);//JESTER sv
	AddStaticVehicle2(560,-2708.9094,232.6039,4.1797,178.0429,3,6);//car4 trans sultan
	AddStaticVehicle2(560,-336.7014,1515.0159,75.1313,1.2439,8,101); // drif3 4 sultan
	AddStaticVehicle2(562,-2743.9207,-303.1422,7.0174,44.4726,1,0); //elegy hotel
	AddStaticVehicle2(562,-1988.2018,304.3466,36.1794,259.9987,86,16);//car dealer 1
	AddStaticVehicle2(562,-2709.1716,212.8635,4.1797,185.5438,0,79);//car1 trans
	AddStaticVehicle2(562,-342.8802,1515.2021,75.1318,358.7833,6,101); // drif3 2 elegy
//AddStaticVehicle2(565,-2703.7358,234.0788,4.1797,178.7202,2,79);//car3 trans garage IMPALA
	AddStaticVehicle2(567,786.0021,-489.2645,15.2195,356.8713,86,16);//Pimp St car1 garage IMPALA
//AddStaticVehicle2(568,-2235.1560,-1730.3127,480.8531,10.4293,86,121);//bandito Chill Chill 568--
//AddStaticVehicle2(568,-2657.6335,-2400.4102,2.8172,95.5103,86,121); //Bandito dunes
//AddStaticVehicle2(568,-2654.9648,-2415.0906,2.3928,94.0645,102,1); //Bandito dunes
	AddStaticVehicle2(575,-2755.2151,-311.1110,7.0391,9.5682,1,0); //broadway  hotel
//AddStaticVehicle2(587,-2068.8235,964.7271,60.9262,191.7439,86,121);//euros
	AddStaticVehicle2(411,-1954.7201,1338.7400,6.9150,269.8037,1,121); //Infurnus
	AddStaticVehicle2(559,-2272.0962,1355.4470,6.9158,73.5896,86,121); //Jester
	AddStaticVehicle2(451,-2511.3452,1209.7589,37.1508,267.9552,77,121); //Turismo
	AddStaticVehicle2(522,-2791.1389,981.6252,50.0555,27.0045,4,101); //NRG
//AddStaticVehicle2(474,-2662.1809,630.6546,14.2241,267.8837,0,101); //
	AddStaticVehicle2(415,-2433.9585,744.5742,34.7679,79.8409,3,101); //Cheetah
	AddStaticVehicle2(567,-2532.9138,358.5529,19.9271,179.0177,128,101); //Impala
	AddStaticVehicle2(541,-2494.2144,-16.4806,25.5367,182.2214,0,101); //Bullet
	AddStaticVehicle2(451,-2796.0425,-92.2779,6.9580,89.2914,2,101); //Turismo
	AddStaticVehicle2(558,-2244.5911,-98.6327,35.0913,1.1431,0,101); //Uranus
	AddStaticVehicle2(562,-2502.3477,-601.9897,132.3348,178.8116,0,101); //Elegy
	AddStaticVehicle2(559,-2084.1614,61.9760,34.1461,91.3935,6,101); //Jester
	AddStaticVehicle2(411,-1942.0991,487.8265,31.7413,91.9006,0,101); //Infurnus
	AddStaticVehicle2(415,-1885.4987,826.2090,34.9446,320.0322,5,1); //Cheetah
	AddStaticVehicle2(522,-1671.7183,403.9883,6.9516,136.7010,9,1); //NRG
	AddStaticVehicle2(562,-1501.4303,920.4661,6.9595,359.7084,2,1); //Elegy
	AddStaticVehicle2(444,-1786.3508,1204.7767,24.8960,180.6921,3,1); //
	AddStaticVehicle2(470,-2365.2205,1004.9041,50.4741,170.8912,5,1); //Patriot
//AddStaticVehicle2(518,-2249.6162,671.5038,49.0664,1.0118,7,1); // Hobo
	AddStaticVehicle2(521,-2413.1394,330.6846,34.7442,148.4232,9,1); //Bike
	AddStaticVehicle2(470,-1110.9086,-1637.0076,76.3604,268.1148,6,65); //Patriot
//AddStaticVehicle2(432,-1110.3884,-1621.1957,76.3599,268.1147,6,65); //Rhino
	AddStaticVehicle2(415,-1101.1594,-1630.5085,76.3296,90.9229,6,65); //Cheetah
	AddStaticVehicle2(468,-1098.0170,-1663.5310,76.0382,349.3529,6,65); //Sanchez
	AddStaticVehicle2(405,-1085.8618,-1619.6393,76.0357,182.3734,6,65); //Sentinel
	AddStaticVehicle2(411,-1657.6346,1214.0313,7.0241,309.3672,1,55); //Infernus
	AddStaticVehicle2(415,-1666.0741,1221.0962,13.4444,250.4340,3,55); //Cheetah
	AddStaticVehicle2(451,-1661.1064,1210.1271,13.4547,292.6258,5,55); //Turismo
	AddStaticVehicle2(522,-1651.0096,1205.6049,20.9381,253.2666,7,55); //NRG-500
	AddStaticVehicle2(522,-1661.2876,1216.6512,20.9128,334.8425,9,55); //NRG-500
	AddStaticVehicle2(541,-2019.3654,-96.8552,34.7919,0.0014,13,8); // Bullet
//AddStaticVehicle2(503,-2034.5876,-121.7191,35.0830,269.0618,103,101); // car 2
//AddStaticVehicle2(515,-2495.4114,255.6847,36.1914,269.4685,54,77); // car 3
	AddStaticVehicle2(424,-1656.6226,1212.1147,20.9377,294.9032,3,6); // BF Injection
	AddStaticVehicle2(424,-1647.1611,1207.6357,20.9726,249.4393,3,6); // BF Injection
//AddStaticVehicle2(434,-2697.4346,1367.5547,16.9650,180.9779,2,2); // car 6
	AddStaticVehicle2(451,-2646.7986,1354.7396,6.8783,180.9896,16,16); // Turismo
	AddStaticVehicle2(522,-2688.0439,205.9044,3.9158,358.0469,6,25); // NRG-500
//AddStaticVehicle2(556,-2509.8049,1206.3197,37.7969,232.0513,1,1); // Monster! 1
//AddStaticVehicle2(556,-2498.7019,1218.8386,37.8002,320.9645,1,1); // Monster! 2
	AddStaticVehicle2(575,-2619.6208,1376.5171,6.7295,63.4406,25,96); // Broadway
	AddStaticVehicle2(575,-2644.3035,1331.9238,6.9875,45.0654,1,1); // Broadway
	AddStaticVehicle2(411,-2644.5115,1379.5635,6.9651,91.5963,1,1); // Infurnus
	AddStaticVehicle2(409,-2621.3679,1337.4874,6.9951,313.7212,1,1); // Pimp car 4
	AddStaticVehicle2(409,-2598.8127,1354.3470,6.8914,236.0988,1,1); // pimp car 5
	AddStaticVehicle2(507,-2150.3044,658.9729,52.4382,0.1325,7,7); // Elegant
	AddStaticVehicle2(507,-2125.4902,657.3282,52.2070,84.1679,7,7); // Elegant
	AddStaticVehicle2(507,-2126.2554,649.8426,52.1908,84.1687,7,7); // Elegant
	AddStaticVehicle2(507,-2135.8274,633.5853,52.0881,180.0553,7,7); // Elegant
	AddStaticVehicle2(522,-2152.8953,640.5824,51.9376,270.5236,7,79); // NRG-500
	AddStaticVehicle2(522,-2152.9143,642.6978,51.9376,270.5237,7,79); // NRG-500
	AddStaticVehicle2(522,-2152.9333,644.8129,51.9376,270.5237,7,79); // NRG-500
	AddStaticVehicle2(541,-2164.6772,660.1553,60.3202,272.1321,2,1); // Bullet
	AddStaticVehicle2(487,-1217.4595,-15.7898,14.1763,0.0763,3,29); // Maveric
	AddStaticVehicle2(487,-1202.4211,-1.7025,14.3083,0.0763,3,29); // Maveric
	AddStaticVehicle2(487,-1170.3536,34.2232,14.3252,0.0911,3,29); // Maveric
	AddStaticVehicle2(513,-1466.8154,-519.4036,14.7231,235.8817,30,34); // Stuntplane
	AddStaticVehicle2(513,-1429.4215,-504.4780,14.7366,176.0148,55,20); // Stuntplane
	AddStaticVehicle2(560,-1951.9344,301.2165,40.9174,178.3483,13,23); //Sultan
	AddStaticVehicle2(411,-1957.2834,301.9644,40.9152,180.4329,92,93); //Infernus
	AddStaticVehicle2(415,-1945.4662,257.4331,40.9166,359.6798,79,79); //Cheetah
	AddStaticVehicle2(429,-1950.9156,257.7579,40.9170,359.8694,1,2); //Banshee
	AddStaticVehicle2(475,-1955.9065,257.6106,40.9135,1.0206,3,3);  //Sabre
	AddStaticVehicle2(477,-1945.3999,273.2839,35.3427,88.8040,41,9); //Zr350
	AddStaticVehicle2(506,-1945.3353,269.3972,35.3407,90.6095,16,1); //Supergt
	AddStaticVehicle2(535,-1945.6040,265.0452,35.3413,90.3844,6,6); //Slamvan
	AddStaticVehicle2(541,-1945.4299,260.8985,35.3356,89.2809,0,11); //Bullet
	AddStaticVehicle2(559,-1945.8987,255.0587,35.3371,89.3658,87,36);  //Jester
	AddStaticVehicle2(405,-1955.0566,305.0432,35.3371,90.6156,102,106); // Sentinel
	AddStaticVehicle2(411,-1954.1021,299.8945,35.3351,90.2938,32,97); // Infernus
	AddStaticVehicle2(415,-1954.1477,294.9549,35.3353,89.7457,2,0); // Cheetah
	AddStaticVehicle2(429,-1954.0110,290.7222,35.3387,88.9322,3,1); // Banshee
	AddStaticVehicle2(475,-1957.1311,285.7732,35.3396,90.4374,14,3); // Sabre
	AddStaticVehicle2(477,-1955.6929,281.8165,35.3370,89.7357,78,5); // Zr350
	AddStaticVehicle2(506,-1955.8882,277.1920,35.3350,89.9642,112,73); // Supergt
	AddStaticVehicle2(593,-1315.6698,-273.4651,14.6055,3.0874,13,8); // Pilot Dodo plane 1
	AddStaticVehicle2(593,-1334.0336,-277.9224,14.6057,0.3802,68,8); // Dodo plane 2
	AddStaticVehicle2(593,-1353.0640,-269.7730,14.6404,312.9902,51,1); // Dodo plane 3
	AddStaticVehicle2(411,-1388.1222,-245.2673,13.8732,354.8541,112,1); // Infurnus
	AddStaticVehicle2(411,-1379.5950,-248.1002,13.8714,323.6971,80,1); // Infurnus
	AddStaticVehicle2(430,-1476.9966,692.2034,-0.3320,179.4663,46,26); // Police boat 1
	AddStaticVehicle2(490,-1573.8690,706.1183,-5.1148,90.4828,0,0); // FBI Rancher
	AddStaticVehicle2(490,-1573.9437,709.7645,-5.1138,91.0168,0,0); // FBI rancher 2
	AddStaticVehicle2(490,-1573.8345,713.9033,-5.1146,92.0823,0,0); // FBI Rancher 3
	AddStaticVehicle2(490,-1573.9185,718.1544,-5.1135,89.6855,0,0); // FBI Rancher 4
	AddStaticVehicle2(523,-1640.4521,694.4510,-5.6718,222.0250,0,0); // Police Bike
	AddStaticVehicle2(523,-1637.4004,696.3330,-5.5758,222.7802,0,0); // Police bike 1
	AddStaticVehicle2(523,-1642.3473,691.3362,-5.6730,231.3749,0,0); // Police bike 2
	AddStaticVehicle2(542,-1354.8975,456.3702,7.0646,46.1662,22,30); // Mechanic Car 0
//AddStaticVehicle2(433,-1360.6459,455.5932,7.0668,44.9871,44,51); // Mechanic Car 1
//AddStaticVehicle2(530,-1369.2474,452.7523,6.9,273.9458,114,1); // Mechanic car 2
	AddStaticVehicle2(542,-1383.1249,455.2200,6.9309,3.7461,32,92); // Mechanic car 3
	AddStaticVehicle2(542,-1387.7605,455.2076,6.9308,5.4355,113,92); // Mechanic car 4
	AddStaticVehicle2(549,-1393.0094,454.6693,6.8854,2.5754,79,39); // Mechanic car 5
	AddStaticVehicle2(578,-1407.1599,457.7941,7.8070,0.3760,1,1); // Mechanic car 6
	AddStaticVehicle2(592,-1639.4169,-147.6004,15.3440,315.6016,1,1); // Pilot Big ass Plane
	AddStaticVehicle2(469,-1434.7238,-951.1201,201.0333,271.6258,1,3); // Secret Chopter
	AddStaticVehicle2(476,-1352.5894,-471.7502,14.8888,185.2331,77,87); // Pilot Plane
	AddStaticVehicle2(476,-1370.0782,-477.6608,14.8932,200.1253,1,6); // Pilot Plane 2
	AddStaticVehicle2(476,-1390.6306,-485.0246,14.9146,227.2599,6,7); // Pilot plane 1
//AddStaticVehicle2(568,-1852.4655,155.1076,16.3347,172.1547,21,1); // Grove Bandito 1
//AddStaticVehicle2(568,-1855.0499,155.4595,16.3143,172.4940,37,0); // Grove Bandito2
//AddStaticVehicle2(568,-1857.6713,155.9091,16.3127,172.0487,2,39); // Grove Bandito 3
	AddStaticVehicle2(535,-1861.2426,131.7862,14.8880,306.3639,123,1); // Grove Slamvan 2
	AddStaticVehicle2(535,-1861.6567,126.8863,14.8657,309.3829,55,1); // Grove slamvan 1
//AddStaticVehicle2(412,-1851.2207,113.7778,14.9522,1.3342,25,8); // Grove low rider 1
	AddStaticVehicle2(567,-1854.9225,113.5595,14.9940,359.7545,93,64); // Impala
	AddStaticVehicle2(534,-1835.7059,113.2843,14.8431,0.6596,10,10); // Grove Remington 2
	AddStaticVehicle2(534,-1831.7031,113.2726,14.8430,1.1495,62,62); // Grove Remington 1
	AddStaticVehicle2(548,-1838.0574,65.3119,45.8808,184.6405,1,1); // Grove Cargobob
//AddStaticVehicle2(601,-1640.2704,666.1199,-5.4811,91.1522,1,1); // S.W.A.T Car
	AddStaticVehicle2(427,-1616.5471,675.6236,7.3209,2.4888,0,1); // Enforcer 1
	AddStaticVehicle2(427,-1611.4476,675.7996,7.3217,2.6371,0,1); // Enforcer 2
	AddStaticVehicle2(597,-1605.5331,673.7916,6.9588,180.0087,0,1); // Police Car 1
	AddStaticVehicle2(597,-1593.8374,674.0457,6.9589,1.6845,0,1); // Police car 2
	AddStaticVehicle2(597,-1587.3134,651.5364,6.9582,355.2948,0,1); // police car 3
	AddStaticVehicle2(597,-1605.0876,651.8231,6.9571,358.2576,0,1); // police car 4
	AddStaticVehicle2(415,-1628.0483,650.5803,6.9590,0.1257,62,1); // Police car 5
	AddStaticVehicle2(415,-1632.1301,650.8945,6.9607,0.1014,92,1); // Police car 6
	AddStaticVehicle2(563,-1457.6823,507.6632,18.9785,268.7628,1,6); // Chopter
	AddStaticVehicle2(451,-2128.6519,-261.6277,35.0262,359.4464,46,46); // Turismo
	AddStaticVehicle2(451,-2132.4678,-261.5417,35.0280,354.7209,75,75); // Turismo
	AddStaticVehicle2(462,-2134.2356,-249.5907,35.2148,89.9389,1,3); // Drug bike 1
	AddStaticVehicle2(462,-2134.0610,-246.5149,35.1495,85.4465,10,10); // Drug bike 2
	AddStaticVehicle2(463,-2115.6045,-270.6928,34.8605,187.6834,79,79); // drug bike 3
	AddStaticVehicle2(463,-2114.1792,-270.6950,34.8558,195.0268,7,7); // Drug bike 4
	AddStaticVehicle2(468,-2119.7617,-266.4388,34.9895,268.6905,46,46); // Sanches
	AddStaticVehicle2(470,-2100.5608,-250.5921,35.3128,271.4049,43,0); // Patriot
	AddStaticVehicle2(470,-2100.3879,-242.1652,35.3134,265.0983,43,0); // Patriot
	AddStaticVehicle2(541,-2019.3654,-96.8552,34.7919,0.0014,13,8); // Bullet
//AddStaticVehicle2(503,-2034.5876,-121.7191,35.0830,269.0618,103,101); // Car 2
	AddStaticVehicle2(587,-2652.9031,-297.2605,8.0617,315.6009,-1,-1);
//AddStaticVehicle2(491,-2618.9480,1376.7870,7.7322,181.1998,-1,-1);
//AddStaticVehicle2(550,-2645.5964,1376.7522,7.8935,267.8349,-1,-1);
	AddStaticVehicle2(405,-2126.2573,650.7344,53.2421,88.8335,-1,-1);
	AddStaticVehicle2(522,-2223.2629,1083.2794,80.7819,359.6700,-1,-1);// NRG-500
//AddStaticVehicle2(565,-2517.2996,1229.3512,38.7999,209.3221,-1,-1);
	AddStaticVehicle2(534,-1654.1005,1211.9901,14.2380,315.9562,-1,-1);// Remmington
	AddStaticVehicle2(477,-1660.4161,1213.3704,8.0209,295.4768,-1,-1);// ZR-350
	AddStaticVehicle2(558,-1497.4607,845.8477,7.9671,88.5197,-1,-1);// Uranus
//AddStaticVehicle2(602,-1699.4597,1035.9624,46.0932,91.6588,-1,-1);
	AddStaticVehicle2(541,-1786.6871,1206.5266,25.7813,178.8742,-1,-1);
//AddStaticVehicle2(482,-2438.0117,1340.9783,8.7316,86.7979,-1,-1);
	AddStaticVehicle2(507,-2166.5498,1251.0760,28.2782,1.6030,-1,-1);// Elegant
	AddStaticVehicle2(562,-2636.3838,932.3286,72.5378,187.1212,-1,-1);
	AddStaticVehicle2(411,-2464.8860,896.7036,63.6223,0.6326,-1,-1);// Infurnus
//AddStaticVehicle2(400,-2459.9055,786.4501,36.2643,89.8722,-1,-1);
//AddStaticVehicle2(603,-2673.5830,802.1517,51.0693,0.3607,-1,-1);
	AddStaticVehicle2(446,-2970.6746,497.2838,1.3557,4.0073,-1,1);// Elegant
//AddStaticVehicle2(439,-2902.7820,342.5712,6.3723,138.7612,-1,-1);
	AddStaticVehicle2(477,-1382.4279,455.8060,7.1838,359.9849,-1,-1);// ZR-350
	AddStaticVehicle2(549,-1465.0304,455.6730,7.9280,358.9676,-1,-1);
	AddStaticVehicle2(519,-1387.8518,-484.0513,15.6341,247.9289,-1,-1);//shamal plane
	AddStaticVehicle2(519,-1317.8910,-260.4665,16.4827,288.2876,-1,-1);//shamal plane
	AddStaticVehicle2(593,-1362.9397,-183.5522,16.4848,308.6994,-1,-1);//dodo plane
//AddStaticVehicle2(487,-1222.7996,-10.4235,15.1594,45.5780,-1,-1);//maverick chopper
	AddStaticVehicle2(475,-1872.5575,-820.7949,32.8273,90.7921,-1,-1);// Sabre
	AddStaticVehicle2(506,-1898.3019,-915.5814,33.3947,91.2857,-1,-1);// Super GT
	AddStaticVehicle2(451,-2124.4800,-929.0856,32.7397,269.1853,-1,-1);// Turismo
//AddStaticVehicle2(480,-2134.1428,-453.9576,36.1699,95.0875,-1,-1);
//AddStaticVehicle2(533,-2035.6851,170.2529,29.4610,268.9087,-1,-1);
	AddStaticVehicle2(470,-2352.0959,-126.8848,35.9374,179.5324,-1,-1);
//AddStaticVehicle2(404,-2180.1277,41.8536,36.1953,269.9865,-1,-1);
//AddStaticVehicle2(580,-2269.4526,69.5823,35.7279,89.6104,-1,-1);
	AddStaticVehicle2(415,-2129.2864,787.6249,70.3666,87.1679,-1,-1);
	AddStaticVehicle2(542,-2424.9958,740.8871,35.8205,177.6701,-1,-1);
//AddStaticVehicle2(496,-2545.7666,627.5895,15.1684,89.1952,-1,-1);
//AddStaticVehicle2(445,-2498.4822,357.5526,35.7969,58.0823,-1,-1);
//AddStaticVehicle2(555,-2664.9673,268.9968,5.0156,357.6026,-1,-1);
	AddStaticVehicle2(522,-2626.5276,-53.6779,5.1144,357.7703,-1,-1);// NRG-500
	AddStaticVehicle2(559,-2487.5295,-125.3075,26.5715,90.9363,-1,-1);
//AddStaticVehicle2(579,-2486.0298,51.5018,27.7954,177.2178,-1,-1);
//AddStaticVehicle2(587,-2574.9736,146.5981,5.4279,1.8790,-1,-1);
//AddStaticVehicle2(491,-1741.0009,811.0599,25.5879,270.6703,-1,-1);
//AddStaticVehicle2(550,-1920.7559,875.2713,36.1113,270.0973,-1,-1);
//AddStaticVehicle2(420,-2040.4465,1107.7076,54.4032,89.8491,-1,-1);//car taxi
	AddStaticVehicle2(405,-1968.8488,465.6065,36.2766,89.3124,-1,-1);
//AddStaticVehicle2(489,-1825.2035,-0.4858,15.8965,270.0104,-1,-1);
//AddStaticVehicle2(585,-1687.9076,1003.5587,18.2656,91.3972,-1,-1);
	AddStaticVehicle2(534,-2782.3508,442.1533,5.5383,57.1401,-1,-1);// Remmington
	AddStaticVehicle2(567,-2836.3665,865.6495,44.1470,268.7662,-1,-1);
	AddStaticVehicle2(558,-2899.3823,1112.4786,27.3954,268.9744,-1,-1);// Uranus
//AddStaticVehicle2(602,-2618.7363,627.2617,15.6024,179.6464,-1,-1);
	AddStaticVehicle2(541,-2151.4924,428.9210,35.1902,176.6156,-1,-1);// Bullet
//AddStaticVehicle2(482,-2641.7395,1333.0645,6.8700,356.7557,-1,-1);
	AddStaticVehicle2(507,-2129.8242,288.0418,34.9864,269.9582,-1,-1);// Elegant
	AddStaticVehicle2(562,-2664.0950,-259.9579,6.5482,74.4868,-1,-1);
	AddStaticVehicle2(597,-1594.2644,672.5858,6.9564,176.7420,-1,-1);//cop car
	AddStaticVehicle2(597,-1622.6423,651.3411,6.9558,179.1608,-1,-1);//cop car
	AddStaticVehicle2(597,-1584.1769,749.3150,-5.4735,1.1909,-1,-1);//cop car
	AddStaticVehicle2(411,-1231.5951,48.1695,13.7616,229.8069,-1,-1);// Infurnus
//AddStaticVehicle2(420,-1425.8613,-294.0004,13.5707,54.8251,-1,-1);//car taxi
//AddStaticVehicle2(400,-2147.9944,-406.9189,35.0502,43.5458,-1,-1);
	AddStaticVehicle2(415,-2899.2644,1112.4993,26.5128,270.6545,-1,-1);// Cheetah
	AddStaticVehicle2(559,-1852.7903,569.7672,34.9839,223.2814,-1,-1);
//AddStaticVehicle2(493,-1476.2301,691.7451,-0.4462,356.6588,-1,-1);
//AddStaticVehicle2(420,-1393.3545,-336.3529,13.8505,24.0909,-1,-1); // car taxi
//AddStaticVehicle2(602,-2330.9387,558.7618,29.3441,270.7266,-1,-1);
//AddStaticVehicle2(402,-2480.8093,1069.6036,55.6982,180.6722,-1,-1);
	AddStaticVehicle2(411,-1954.0840,262.1563,40.7033,60.7457,-1,-1);// Infurnus
	AddStaticVehicle2(475,-1722.1432,1345.3258,6.9462,45.2691,-1,-1);// Sabre
	AddStaticVehicle2(560,-2796.0449,88.3034,6.8933,91.3375,-1,-1);// Sultan
//AddStaticVehicle2(420,-1384.6299,-375.4851,13.8536,4.7845,-1,-1); //  car taxi
//AddStaticVehicle2(402,-2248.0791,336.6792,34.3907,6.0747,-1,-1);
    AddStaticVehicle2(471,-1849.9697,579.5735,34.6755,191.0737,120,114); // Chicken Quadbike
	AddStaticVehicle2(471,-1847.2742,616.5053,34.6538,99.5473,74,91); // Chicken Quadbike
	AddStaticVehicle2(471,-1886.6931,616.4269,34.6435,106.8854,120,113); // Chicken QuadBike
	AddStaticVehicle2(471,-1725.3540,596.9860,24.3769,351.3364,120,117); // Chicken QuadBike
	AddStaticVehicle2(446,-1469.0970,1468.1393,-0.9598,283.2957,1,44); // Da Nang Boat
	AddStaticVehicle2(446,-1396.2950,1468.5009,-0.3001,249.5674,1,53); // Da Nang Boat
	AddStaticVehicle2(452,-1346.2898,1480.2726,0.0728,323.8238,1,22); // Da Nang Boat
	AddStaticVehicle2(520,-1615.1797,-314.4653,14.8717,43.2734,0,0); // hydra Airport 1
	AddStaticVehicle2(520,-1598.0720,-296.8032,14.8717,42.3004,0,0); // hydra Airport 2
	AddStaticVehicle2(560,-2664.6963,268.4365,4.0437,0.9711,-1,-1); //
	
	AddStaticVehicle2(562,-2558.0569,626.2651,27.4686,1.3911,-1,-1); //
    AddStaticVehicle2(562,-2545.1973,654.4800,27.4713,89.7888,-1,-1); //
    AddStaticVehicle2(483,-2591.9216,645.3833,27.8068,271.0850,-1,-1); //
    AddStaticVehicle2(495,-2583.9741,625.9721,28.1656,2.1764,-1,-1); //
    AddStaticVehicle2(572,-2045.3303,649.0349,48.2441,351.6619,-1,-1); //
    
    //bus et taxi
    AddStaticVehicle2(437,-1989.0459,185.0862,27.1641,1.4267,-1,-1); //
    AddStaticVehicle2(437,-1988.5227,164.0876,27.1643,1.4280,-1,-1); //
    AddStaticVehicle2(437,-1988.5671,123.5921,27.1639,5.8738,-1,-1); //
    AddStaticVehicle2(437,-1989.0206,101.3091,27.1641,358.4635,-1,-1); //
    AddStaticVehicle2(420,-2032.9777,170.1485,28.4610,269.2922,-1,-1); //
    AddStaticVehicle2(420,-2033.5149,178.9579,28.4679,270.3438,-1,-1); //
    AddStaticVehicle2(420,-2025.7020,424.3957,34.7968,270.8936,-1,-1); //
    AddStaticVehicle2(420,-1995.3624,895.0511,45.0703,0.4705,-1,-1); //
    AddStaticVehicle2(420,-2591.5552,666.2154,27.4374,273.5835,-1,-1); //
    AddStaticVehicle2(437,-2744.8291,475.0178,4.8637,89.3246,-1,-1);//
    AddStaticVehicle2(437,-2691.2041,-267.3752,7.1722,133.8710,-1,-1); //

    AddStaticVehicle(525,-2504.1404,740.4272,34.8005,181.3018,-1,-1); //
    AddStaticVehicle(525,-2495.2068,740.5359,34.7954,181.7471,-1,-1);//
    AddStaticVehicle(525,-2486.8882,740.2015,34.7946,181.6177,-1,-1); //


    //-----------------------------------------285/250 CARS ALTOGETHER
    //----------------------218/250 Cars in Use
    //49/50 Car Types in Use

	for(new i=1;i<=gVC;i++)
	{
	    carcost[i] = 50000;
    	for(new s=0; s<24; s++)
		{
     		if(gVehicleClass[i] == heavycar[s][0])
			{
       			carcost[i] = 100000;
   	        }
		}
		for(new a=0; a<11; a++)
		{
     		if(gVehicleClass[i] == boat[a][0])
	 		{
       			carcost[i] = 50000;
   	        }
		}
		for(new b=0; b<11; b++){
     		if(gVehicleClass[i] == mbike[b][0])
			 {
       			carcost[i] = 40000;
   	        }
		}
		for(new d=0; d<3; d++)
		{
     		if(gVehicleClass[i] == pbike[d][0])
			{
       			carcost[i] = 3000;
   	        }
		}
		for(new e=0; e<6; e++)
		{
     		if(gVehicleClass[i] == splane[e][0])
			 {
       			carcost[i] = 500000;
   	        }
		}
		for(new f=0; f<2; f++)
		{
     		if(gVehicleClass[i] == mplane[f][0])
			{
       			carcost[i] = 1500000;
   	        }
		}
		for(new v=0; v<2; v++)
		{
     		if(gVehicleClass[i] == lplane[v][0])
			 {
       			carcost[i] = 2000000;
   	        }
		}
		for(new n=0; n<4; n++)
		{
     		if(gVehicleClass[i] == milair[n][0])
			{
       			carcost[i] = 4000000;
   	        }
		}
		for(new j=0; j<4; j++)
		{
     		if(gVehicleClass[i] == sheli[j][0])
			{
       			carcost[i] = 750000;
   	        }
		}
		for(new k=0; k<3; k++)
		{
     		if(gVehicleClass[i] == lheli[k][0])
			{
       			carcost[i] = 1250000;
   	        }
		}
		format(tmpname,sizeof(tmpname),"%d",i);
		format(carname,sizeof(carname),"%s", VehicleName[gVehicleClass[i]-400][0]);
		if (!dini_Exists(tmpname))
		{
    	    	dini_Create(tmpname);
				dini_Set(tmpname, "owner", "server");
				dini_Set(tmpname, "carname", carname);
				dini_IntSet(tmpname, "carcost", carcost[i]);
				dini_IntSet(tmpname, "carlock", 0);
				dini_IntSet(tmpname, "bought", 0);
				dini_IntSet(tmpname, "secure", 0);
				dini_IntSet(tmpname, "asecure", 0);
				dini_IntSet(tmpname, "used", 0);
				dini_IntSet(tmpname, "buybar", 0);
				GetVehiclePos(i,t,u,o);
        		dini_IntSet(tmpname, "sx", floatround(t));
        		dini_IntSet(tmpname, "sy", floatround(u));
        		dini_IntSet(tmpname, "sz", floatround(o));
    	}
    	if(gVC != oldvehcount)
		{
            format(tmpname,sizeof(tmpname),"%d",i);
			format(carname,sizeof(carname),"%s", VehicleName[gVehicleClass[i]-400][0]);
  			dini_Create(tmpname);
			dini_Set(tmpname, "owner", "server");
			dini_Set(tmpname, "carname", carname);
			dini_IntSet(tmpname, "carcost", carcost[i]);
			dini_IntSet(tmpname, "carlock", 0);
			dini_IntSet(tmpname, "bought", 0);
			dini_IntSet(tmpname, "secure", 0);
			dini_IntSet(tmpname, "asecure", 0);
			dini_IntSet(tmpname, "used", 0);
			dini_IntSet(tmpname, "buybar", 0);
			GetVehiclePos(i,t,u,o);
 			dini_IntSet(tmpname, "sx", floatround(t));
 			dini_IntSet(tmpname, "sy", floatround(u));
 			dini_IntSet(tmpname, "sz", floatround(o));
		}
	}
    for(new p=0; p <= gVC; p++)
	{
        new filename[256];
        format(filename, sizeof(filename), "%d", p);
        if (dini_Exists(filename))
		{
			dini_IntSet(filename, "used", 0);
		}
    }
	for(new tempb=1;tempb<=BIZ_AMOUNT;tempb++)
	{
    	if(tempb >= 1 && tempb <=9)
		{
 			propcost[tempb] = 14000000;
 			profit[tempb] = 7500;
		}
		if(tempb >= 10 && tempb <=13)
		{
 			propcost[tempb] = 11000000;
 			profit[tempb] = 4750;
		}
		if(tempb >= 14 && tempb <=19)
		{
 			propcost[tempb] = 11000;
 			profit[tempb] = 55;
		}
		if(tempb >= 20 && tempb <=24)
		{
 			propcost[tempb] = 1200000;
 			profit[tempb] = 600;
		}
		if(tempb >= 25)
		{
 			propcost[tempb] = 20000000;
 			profit[tempb] = 10000;
		}
		if(tempb >= 26)
		{
 			propcost[tempb] = 18000000;
 			profit[tempb] = 8500;
		}
		if(tempb >= 27)
		{
 			propcost[tempb] = 15000000;
 			profit[tempb] = 8000;
		}
		if(tempb >= 28 && tempb <=29)
		{
 			propcost[tempb] = 2500000;
 			profit[tempb] = 800;
		}
		if(tempb >= 30 && tempb <=31)
		{
 			propcost[tempb] = 850000;
 			profit[tempb] = 290;
		}
		if(tempb >= 32 && tempb <=33)
		{
 			propcost[tempb] = 900000;
 			profit[tempb] = 330;
		}
		if(tempb >= 34 && tempb <=36)
		{
 			propcost[tempb] = 500000;
 			profit[tempb] = 230;
		}
		if(tempb >= 37 && tempb <=39)
		{
 			propcost[tempb] = 600000;
 			profit[tempb] = 250;
		}
		if(tempb >= 40 && tempb <=42)
		{
 			propcost[tempb] = 700000;
 			profit[tempb] = 290;
		}
		if(tempb == 43)
		{
 			propcost[tempb] = 1200000;
 			profit[tempb] = 690;
		}
		if(tempb == 44)
		{
 			propcost[tempb] = 1100000;
 			profit[tempb] = 590;
		}
		if(tempb == 45)
		{
 			propcost[tempb] = 650000;
 			profit[tempb] = 200;
		}
		if(tempb == 46)
		{
 			propcost[tempb] = 800000;
 			profit[tempb] = 225;
		}
		if(tempb == 47)
		{
 			propcost[tempb] = 1000000;
 			profit[tempb] = 490;
		}
		if(tempb >= 48 && tempb <=49)
		{
 			propcost[tempb] = 25000;
 			profit[tempb] = 99;
		}
		if(tempb >= 50 && tempb <=53)
		{
 			propcost[tempb] = 80000;
 			profit[tempb] = 175;
		}
		if(tempb >= 54 && tempb <=60)
		{
 			propcost[tempb] = 50000;
 			profit[tempb] = 99;
		}
		format(tmpname,sizeof(tmpname),"BIZ%d",tempb);
		if (!dini_Exists(tmpname))
		{
    	    	dini_Create(tmpname);
				dini_Set(tmpname, "owner", "server");
				dini_IntSet(tmpname, "propcost", propcost[tempb]);
				dini_IntSet(tmpname, "profit", profit[tempb]);
				dini_IntSet(tmpname, "totalprofit", 0);
				dini_IntSet(tmpname, "bought", 0);
				dini_IntSet(tmpname, "idnumber", tempb);
				dini_IntSet(tmpname, "buybar", 0);

    	}
//-----------------------------------Pickups------------------------------------
		AddStaticPickup(1242, 15, 1198.6222,-2036.7010,69.0078); //Armor WHITE HOSE
		AddStaticPickup(1242, 15, 2037.5424,1955.0793,12.0647); //Armor hotel2
		AddStaticPickup(1242, 15, -1666.2980,1204.7188,7.2546); //Armor car dealer2
		AddStaticPickup(1242, 15, 2216.9341,-1179.4139,25.8906); //Armor motel
		AddStaticPickup(1242, 15, 1582.2346,-2433.3376,13.5547); //Armor airport2
		AddStaticPickup(1242, 15, 915.7377,-1235.0343,17.2109); //Armor MOVIE
		AddStaticPickup(1242, 15, -1111.8021,-1672.5598,76.3672); //Armor HIPPY
		AddStaticPickup(1242, 15, 1296.5054,-786.7410,88.3125); //Armor ADMIN
		AddStaticPickup(1242, 15, -534.7692,-178.1900,78.4047); //armor FOREST
		AddStaticPickup(1242, 15, -2771.5168,-251.6141,7.1875); //armor hotel
		AddStaticPickup(1242, 15, -1321.9531,2504.2705,89.5703); //armor hobo
		AddStaticPickup(1242, 15, -2241.2661,2321.9829,7.5454); //armor secret
		AddStaticPickup(1242, 15, -2720.7385,231.9487,4.3418); //armor at trans
		AddStaticPickup(1242, 15, 2238.8762,2449.3284,11.0372); //armor at security cop
		AddStaticPickup(1242, 15, -1844.8163,-1708.9067,41.1060); //armor at Rock Quarry
		AddStaticPickup(1242, 15, -2230.1113,-1743.3027,480.8695); //armor at chilliad
		AddStaticPickup(1242, 15, 2184.7224,-1203.6058,1049.8330); //armor at lombardi str
		AddStaticPickup(1242, 15, -1954.3491,303.5424,35.4688); //armor at car dealer
		AddStaticPickup(1242, 15, 2537.5513,-1663.5591,15.1492); //armor at grove str back right behind spwn
		AddStaticPickup(1242, 15, 1331.1685,1257.4764,14.2731); //armor at airort
		AddStaticPickup(1242, 15, 2293.2725,1435.4340,38.4735); //armor at driuft
		AddStaticPickup(1242, 15, 2582.8208,-1717.3884,8.0025); //aromr rbed
		AddStaticPickup(1242, 15, 1654.0404,-1658.1034,22.5156); //armor 3towers
		AddStaticPickup(1242, 15, 2332.5977,-1064.6901,1049.0234); //armor pimp
		AddStaticPickup(1242, 15, 688.0721,841.4696,-39.0077); //armor quarry1
		AddStaticPickup(1242, 15, 538.1361,839.2096,-34.6727); //armor quar 2
		AddStaticPickup(1242, 15, 545.5967,919.9224,-34.7484); //armor quar 3
		AddStaticPickup(1242, 15, 623.2344,894.4736,-35.4231); //armor quar 4
		AddStaticPickup(1242, 15, 2746.5503,-2453.7292,13.8623); //Armor military
		AddStaticPickup(370, 15, -2291.5791,2318.0688,15.2117); //SECRET JETPACK
		AddStaticPickup(371, 15, -2240.2351,-1747.3890,480.8622); //chilliad parachute
		AddStaticPickup(657, 2, -2649.4902, 1383.0055, 7.1826); //Kool Spinning tree
	}
	return 1;
}
//============================Is Player Name Online=============================
public IsPlayerNameOnline(compname[])
{
	new playername[MAX_PLAYER_NAME];
    for(new i=0;i<=MAX_PLAYERS;i++)
	{
        if(IsPlayerConnected(i))
		{
            GetPlayerName(i, playername, sizeof(playername));
            if(strcmp(playername,compname,false) == 0)
			{
                return i;
			}
		}
	}
	return 100;
}
//=================================Biz Profit===================================
public profitup()
{
	for(new tempa=1;tempa<=BIZ_AMOUNT;tempa++)
	{
		format(tmpname,sizeof(tmpname),"BIZ%d",tempa);
	 	propowned[tempa] = dini_Int(tmpname, "bought");
		if (propowned[tempa] == 1)
		{
		    new tmp[256];
			totalprofit[tempa] = dini_Int(tmpname, "totalprofit");
			profit[tempa] = dini_Int(tmpname, "profit");
			tmp[tempa] = profit[tempa]+totalprofit[tempa];
			dini_IntSet(tmpname, "totalprofit", tmp[tempa]);
    	}
	}
	for(new i=0;i<=MAX_PLAYERS;i++)
	{
	    if(IsPlayerConnected(i))
		{
	    	new ownera[MAX_PLAYERS],playername[256];
		   	GetPlayerName(i, playername, sizeof(playername));
		    ownera[i] = dini_Int(udb_encode(playername),"bizowned");
	    	if(ownera[i] > 0)
			{
				SendClientMessage(i,COLOR_LIGHTBLUE,"Le bénéfice pour votre propriété a été mis à jour. Revenez à votre propriété.");
    			SendClientMessage(i,COLOR_LIGHTBLUE,"Entré dans le checkpoint et tapez /benefice pour prendre vos recettes du business.");
			}
		}
	}
	return 1;
}
//===========================Define AddStaticVehicle2===========================
public AddStaticVehicle2(modelid, Float:spawn_x, Float:spawn_y, Float:spawn_z, Float:z_angle, color1, color2)
{
	if(gVC<=MAX_CARS)
	{
		gVC++;
		gVehicleClass[gVC] = modelid;
		AddStaticVehicle(modelid, spawn_x, spawn_y, spawn_z, z_angle, color1, color2);
	}
}
//==========================Selection Screen Stuff==============================
public OnPlayerRequestClass(playerid, classid)
//--------------------------Selection Screen Colors-----------------------------
{
	if(classid == 0)
	{
		GameTextForPlayer(playerid, "~r~WORKER", 2000, 5);
		SetPlayerColor(playerid,COLOR_GREEN);
		gTeam[playerid] = TEAM_WORKER;
	}
	else if(classid == 1)
	{
		GameTextForPlayer(playerid, "~r~PIMP", 2000, 5);
		SetPlayerColor(playerid,COLOR_RED);
		gTeam[playerid] = TEAM_PIMP;
	}
	else if(classid == 2)
	{
		GameTextForPlayer(playerid, "~r~GOLFER", 2000, 5);
		SetPlayerColor(playerid,COLOR_YELLOW);
		gTeam[playerid] = TEAM_GOLFER;
	}
	else if(classid == 3)
	{
		GameTextForPlayer(playerid, "~r~TRIAD", 2000, 5);
		SetPlayerColor(playerid,COLOR_PINK);
		gTeam[playerid] = TEAM_TRIAD;
	}
 	else if(classid == 4)
 	{
		GameTextForPlayer(playerid, "~r~ARMY", 2000, 5);
		SetPlayerColor(playerid,COLOR_GREEN);
		gTeam[playerid] = TEAM_ARMY;
	}
	else if(classid == 5)
	{
		GameTextForPlayer(playerid, "~r~VALET", 2000, 5);
		SetPlayerColor(playerid,COLOR_LIGHTBLUE);
		gTeam[playerid] = TEAM_VALET;
	}
 	else if(classid == 6)
	{
		GameTextForPlayer(playerid, "~r~MEDIC", 2000, 5);
		SetPlayerColor(playerid,COLOR_PURPLE);
		gTeam[playerid] = TEAM_MEDIC;
	}
	else if(classid == 7)
	{
		GameTextForPlayer(playerid, "~r~FBI", 2000, 5);
		SetPlayerColor(playerid,COLOR_ORANGE);
		gTeam[playerid] = TEAM_FBI;
	}
	else if(classid == 8)
	{
		GameTextForPlayer(playerid, "~r~CHICKEN", 2000, 5);
		SetPlayerColor(playerid,COLOR_GREY);
		gTeam[playerid] = TEAM_CHICKEN;
	}
	else if(classid == 9)
	{
		GameTextForPlayer(playerid, "~r~RICH", 2000, 5);
	 	SetPlayerColor(playerid,COLOR_SKIN);
	 	gTeam[playerid] = TEAM_RICH;
	}
	else if(classid == 10)
	{
		GameTextForPlayer(playerid, "~r~PILOT", 2000, 5);
		SetPlayerColor(playerid,COLOR_DARKGREY);
		gTeam[playerid] = TEAM_PILOT;
	}
  	else if(classid == 11)
	{
		GameTextForPlayer(playerid, "~r~DA NANG", 2000, 5);
		SetPlayerColor(playerid,COLOR_DARKRED);
		gTeam[playerid] = TEAM_DANANG;
	}
//---------------------Player Selection Screen Locations------------------------
	//-------------------------------Worker
	if(classid == 0)
	{
		SetPlayerInterior(playerid,0);
		SetPlayerPos(playerid, -2109.7576,184.2289,35.1503);
		SetPlayerFacingAngle(playerid,160.3343);
		SetPlayerCameraPos(playerid, -2108.96,175.01,36.31);
		SetPlayerCameraLookAt(playerid, -2109.7576,184.2289,35.1503);
		PlayerPlaySound(playerid,SOUND_MUSIC1,-2109.7576,184.2289,35.1503);
	}
	//-------------------------------Pimp
	else if(classid ==1)
	{
		SetPlayerInterior(playerid,0);
		SetPlayerPos(playerid, -2718.6787,1369.0715,7.1875);
		SetPlayerFacingAngle(playerid,150.9731);
		SetPlayerCameraPos(playerid, -2722.37,1362.35,9.08);
		SetPlayerCameraLookAt(playerid, -2718.6787,1369.0715,7.1875);
		PlayerPlaySound(playerid,SOUND_MUSIC1,-2718.6787,1369.0715,7.1875);
	}
	//-------------------------------Golfer
	else if(classid == 2)
	{
		SetPlayerInterior(playerid,0);
		SetPlayerPos(playerid, -2457.8726,-259.3923,39.6499);
		SetPlayerFacingAngle(playerid,91.5298);
		SetPlayerCameraPos(playerid, -2463.7385,-260.9094,39.5841);
		SetPlayerCameraLookAt(playerid, -2457.8726,-259.3923,39.6499);
		PlayerPlaySound(playerid,SOUND_MUSIC1,-2457.8726,-259.3923,39.6499);
	}
	//-------------------------------Triad
	else if(classid == 3)
	{
		SetPlayerInterior(playerid,0);
		SetPlayerPos(playerid, -2193.5981,641.5383,49.4429);
		SetPlayerFacingAngle(playerid,354.6778);
		SetPlayerCameraPos(playerid, -2194.3101,645.1630,49.4375);
		SetPlayerCameraLookAt(playerid, -2193.5981,641.5383,49.4429);
		PlayerPlaySound(playerid,SOUND_MUSIC1,-2193.5981,641.5383,49.4429);
	}
	//-------------------------------Army
	else if(classid == 4)
	{
		SetPlayerInterior(playerid,0);
		SetPlayerPos(playerid, -1314.7040,445.2622,7.1875);
		SetPlayerFacingAngle(playerid,217.3818);
		SetPlayerCameraPos(playerid, -1314.56,435.76,8.94);
		SetPlayerCameraLookAt(playerid, -1314.7040,445.2622,7.1875);
		PlayerPlaySound(playerid,SOUND_MUSIC1,-1314.7040,445.2622,7.1875);
	}
	//-------------------------------Valet
	else if(classid == 5)
	{
		SetPlayerInterior(playerid,0);
		SetPlayerPos(playerid, -1731.0652,956.3801,24.8828);
		SetPlayerFacingAngle(playerid,358.6085);
		SetPlayerCameraPos(playerid, -1731.92,960.97,26.35);
		SetPlayerCameraLookAt(playerid, -1731.0652,956.3801,24.8828);
		PlayerPlaySound(playerid,SOUND_MUSIC1, -1731.0652,956.3801,24.8828);
	}
	//-------------------------------Medic
	else if(classid == 6)
	{
		SetPlayerInterior(playerid,0);
		SetPlayerPos(playerid, -2593.1321,608.7902,14.4531);
		SetPlayerFacingAngle(playerid,270.5395);
		SetPlayerCameraPos(playerid, -2590.15,608.88,14.89);
		SetPlayerCameraLookAt(playerid, -2593.1321,608.7902,14.4531);
		PlayerPlaySound(playerid,SOUND_MUSIC1, -2593.1321,608.7902,14.4531);
	}
	//-------------------------------FBI
	else if(classid == 7)
	{
		SetPlayerInterior(playerid,0);
		SetPlayerPos(playerid, -1622.7039,673.5800,-4.9063);
		SetPlayerFacingAngle(playerid,150.9650);
		SetPlayerCameraPos(playerid, -1623.80,670.28,-3.78);
		SetPlayerCameraLookAt(playerid, -1622.7039,673.5800,-4.9063);
		PlayerPlaySound(playerid,SOUND_MUSIC1,-1622.7039,673.5800,-4.9063);
	}
	//-----------------------------Chicken
	else if(classid == 8)
	{
		SetPlayerInterior(playerid,0);
		SetPlayerPos(playerid, -2681.2529,266.1666,4.3359);
		SetPlayerFacingAngle(playerid,2.8437);
		SetPlayerCameraPos(playerid, -2681.2529,266.1666,4.3359);
		SetPlayerCameraLookAt(playerid, -2671.7610,276.4885,4.3359);
		PlayerPlaySound(playerid,SOUND_MUSIC1, -2681.2529,266.1666,4.3359);
	}
	//-------------------------------Rich
	else if(classid == 9)
	{
		SetPlayerInterior(playerid,0);
		SetPlayerPos(playerid, -2680.6270,936.2209,79.7031);
		SetPlayerFacingAngle(playerid,2.7078);
		SetPlayerCameraPos(playerid, -2680.65,938.96,80.53);
		SetPlayerCameraLookAt(playerid, -2680.6270,936.2209,79.7031);
		PlayerPlaySound(playerid,SOUND_MUSIC1,-2680.6270,936.2209,79.7031);
	}
	//-------------------------------Pilot
	else if(classid == 10)
	{
		SetPlayerInterior(playerid,0);
		SetPlayerPos(playerid, -1339.0934,-299.9974,14.1484);
		SetPlayerFacingAngle(playerid,173.2872);
		SetPlayerCameraPos(playerid, -1337.09,-306.75,15.64);
		SetPlayerCameraLookAt(playerid, -1339.0934,-299.9974,14.1484);
		PlayerPlaySound(playerid,SOUND_MUSIC1, -1339.0934,-299.9974,14.1484);
	}
	//-------------------------------Da Nang
	else if(classid == 11)
	{
		SetPlayerInterior(playerid,0);
		SetPlayerPos(playerid, -1421.1034,1488.5735,11.8084);
		SetPlayerFacingAngle(playerid,267.8500);
		SetPlayerCameraPos(playerid, -1417.55,1488.98,11.74);
		SetPlayerCameraLookAt(playerid, -1421.1034,1488.5735,11.8084);
		PlayerPlaySound(playerid,SOUND_MUSIC1,-1421.1034,1488.5735,11.8084);
	}
	return 1;
}
//================================Random Functions==============================
public SystemMsg(playerid,msg[])
{
	if ((IsPlayerConnected(playerid))&&(strlen(msg)>0))
	{
		SendClientMessage(playerid,COLOR_SYSTEM,msg);
	}
	return 1;
}

stock PlayerName(playerid)
{
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, MAX_PLAYER_NAME);
	return name;
}
//==============================On Player Connect===============================
public OnPlayerConnect(playerid)
{
	printf("OnPlayerConnect(%d)", playerid);
	allowprofit[playerid] = 0;
	speedo[playerid] = 1;
    buyable[playerid] = 0;
	bank[playerid]=0;
	Calling[playerid] = -1;
	Answered[playerid] = 0;
	Callerid[playerid] = 0;
 	Spawned[playerid] = 0;
 	welcome[playerid] = 1;
 	moneyed[playerid] = 1;
 	setd[playerid] = 0;
    PlayerInterior[playerid] = GetPlayerInterior(playerid);
    server = dini_Get(FILE_SETTINGS, "servername");
    new string[256];
    new playername[MAX_PLAYER_NAME];
	GetPlayerName(playerid, playername, sizeof(playername));
	format(string, sizeof(string), "Bienvenue %s, sur oOo SFTDM 2.0 oOo !", playername);
	SendClientMessage(playerid, COLOR_ORANGE, string);
	format(string, sizeof(string), "Tape /help pour voir les commandes !");
	SendClientMessage(playerid, COLOR_AQUA, string);
	GameTextForPlayer(playerid, " ~g~ Bienvenue sur mon serveur ~n~~n~~y~~n~~r~~n~Tape /regles ou sinon kick",10000,1);
	return 1;
}
//============================On Player Exit Vehicle============================
public OnPlayerExitVehicle(playerid)
{
    used[playerid] = 0;
	passenger[playerid] = 0;
	return 1;
}
//=============================On Player Spawn==================================
public OnPlayerSpawn(playerid)
{
	if(logged[playerid] == 1)
	{
	    new playername[MAX_PLAYER_NAME];
	    GetPlayerName(playerid, playername, sizeof(playername));
		bank[playerid] = dini_Int(udb_encode(playername), "bank");
		if(bank[playerid] > 20000)
		{
			amount[playerid] = 0;
			SendClientMessage(playerid,COLOR_YELLOW, "Vous avez $20000 ou plus sur votre compte bancaire et vous ne touchez pas les $10000 des allocations .");
		}
		if(bank[playerid] < 20000)
		{
			amount[playerid] = 10000;
			SendClientMessage(playerid,COLOR_YELLOW, "Vous n'avez pas $20000 dans votre compte bancaire et vous recevez les $10000 des allocations.");
		}
		GivePlayerMoney(playerid,amount[playerid]);
	}
	if(welcome[playerid] == 1)
	{
		SendClientMessage(playerid,COLOR_YELLOW, "Vous pouvez vous enregistrer avec votre pseudo sur le serveur: /enregistrer [MotDePasse]'");
		SendClientMessage(playerid,COLOR_YELLOW, "Ou loggez-vous: /ident [MotDePasse]'");
		SendClientMessage(playerid,COLOR_BRIGHTRED, "Vous pourrez seulement récupérer votre argent après vous être loggé!");
		welcome[playerid] = 0;
	}
	GameTextForPlayer(playerid,"~y~TuEz LES TOUS!!!", 3000, 5);
	PlayerPlaySound(playerid,SOUND_OFF,-1421.1034,1488.5735,11.8084);
	Spawned[playerid] = 1;
    return 1;
}
//============================Anti-Team kill Script=============================
public OnPlayerDeath(playerid, killerid, reason)
{
	new name[MAX_PLAYER_NAME];
	new string[256];
	new deathreason[20];
	GameTextForPlayer(playerid,"~r~Tu es mort",10000,2);
	GetPlayerName(playerid, name, sizeof(name));
	GetWeaponName(reason, deathreason, 20);
    new pstring[256]; //player message
	if (killerid == INVALID_PLAYER_ID)
	{
		SendDeathMessage(INVALID_PLAYER_ID,playerid,reason);

		if (reason == WEAPON_DROWN)
		{
			format(string, sizeof(string), "*** %s est descendu comme une brique!", name);
		}
		else {
  			if (strlen(deathreason) > 0)
			  {
				format(string, sizeof(string), "*** %s obtient la mort. (%s)", name, deathreason);
			}
			else {
		 		format(string, sizeof(string), "*** %s est mort.", name);
			}
		}
		//SendClientMessageToAll(COLOR_RED, string);
    }
	else
	{
		new killer[MAX_PLAYER_NAME];
		GetPlayerName(killerid, killer, sizeof(killer));
		if (strlen(deathreason) > 0)
		{
			format(string, sizeof(string), "*** %s a tue %s. (%s)", killer, name, deathreason);
		}
		else {
			format(string, sizeof(string), "*** %s a tue %s.", killer, name);
		}
		if(gTeam[playerid] == gTeam[killerid])
		{
			new warning[256];
			format(warning, sizeof(warning), "Faites attention ! Vous avez tué votre propre équipier!");
			SendClientMessage(killerid, 0xFFFF00AA, warning);
			RemovePlayerFromVehicle(killerid);
			SetPlayerInterior(killerid,6);
			SetPlayerPos(killerid, 265.4426, 79.16441, 1001.039);
			ResetPlayerWeapons(killerid);
			GivePlayerMoney(killerid, -2500);
			SetPlayerScore(killerid, GetPlayerScore(killerid)-1);
		}
		else{
			SetPlayerScore(killerid,GetPlayerScore(killerid)+1);
			GivePlayerMoney(killerid, 5000);
            new kstring[256]; //killer message
			new pname[MAX_PLAYER_NAME];   //player name
			GetPlayerName(playerid, pname, sizeof(pname));
			format(kstring, sizeof(kstring), "~b~Haha Ya 0wned %s",pname);
			GameTextForPlayer(killerid, kstring, 4000, 3);
			new kname[MAX_PLAYER_NAME];   //killername
			GetPlayerName(killerid, kname, sizeof(kname));
			format(pstring, sizeof(pstring), "~r~:( you got 0wned by %s",kname);
			GameTextForPlayer(playerid, pstring, 4000, 3);
		}
		//if(IsPlayerInAnyVehicle(killerid)){
		//new string2[256];
		//format(string2, sizeof(string2), "%s had to use his car to kill so he had his weapons removed!",killer);
		//SendClientMessageToAll(COLOR_RED, string2);
		//ResetPlayerWeapons(killerid);
		SendDeathMessage(killerid,playerid,reason);
		SendClientMessageToAll(COLOR_RED, string);
		Spawned[playerid] = 0;
		moneyed[playerid] = 0;
	}
 	return 1;
}
//===============================Random Functions===============================
public OnVehicleSpawn(vehicleid)
{
	printf("OnVehicleSpawn(%d)", vehicleid);
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
    new filename[256];
	format(filename, sizeof(filename), "%d", vehicleid);
}
//=============================Player save system!==============================
public OnPlayerDisconnect(playerid)
{
    new playername[MAX_PLAYER_NAME];
	new string[256];
	GetPlayerName(playerid, playername, sizeof(playername));

	if (dini_Exists(udb_encode(playername)) && logged[playerid] == 1)
	{
		dini_IntSet(udb_encode(playername), "money", GetPlayerMoney(playerid));
       	dini_IntSet(udb_encode(playername), "bank", bank[playerid]);
       	dini_IntSet(udb_encode(playername), "vehicleresetcount", gVC);
       	PlayerInterior[playerid] = GetPlayerInterior(playerid);
		if(PlayerInterior[playerid] == 0)
		{
			new Float:x, Float:y, Float:z;
      		new Float:a;
			GetPlayerFacingAngle(playerid,a);
			dini_IntSet(udb_encode(playername), "a", floatround(a));
 			GetPlayerPos(playerid,x,y,z);
			dini_IntSet(udb_encode(playername), "x", floatround(x));
			dini_IntSet(udb_encode(playername), "y", floatround(y));
			dini_IntSet(udb_encode(playername), "z", floatround(z));
		}
	}
	format(string, sizeof(string), "--- %s c'est deconnecte.", playername);
	printf(string);
	logged[playerid] = 0;
	return 1;
}
//============================Get Checkpoint Type===============================
public getCheckpointType(playerID)
{
	return checkpointType[playerCheckpoint[playerID]];
}
//====================================Speedo====================================
public CheckSpeedo()
{
	new string[256];
	for(new i=0;i<MAX_PLAYERS;i++)
	{
		if(IsPlayerConnected(i) && IsPlayerInAnyVehicle(i))
		{
			if(speedo[i] == 1 && aMessage[i] == 0 && Count[i] == 0)
			{
		        new Float:x,Float:y,Float:z;
	            new Float:distance,value;
	            new filename[256];
	            format(filename, sizeof(filename), "%d", GetPlayerVehicleID(i));
				carname = dini_Get(filename, "carname");
	            GetPlayerPos(i, x, y, z);
	            distance = floatsqroot(floatpower(floatabs(floatsub(x,SavePlayerPos[i][LastX])),2)+floatpower(floatabs(floatsub(y,SavePlayerPos[i][LastY])),2)+floatpower(floatabs(floatsub(z,SavePlayerPos[i][LastZ])),2));
	            value = floatround(distance * 11000);
	            format(string, sizeof(string), "~n~~n~~n~~n~~n~~n~~n~~n~~n~~r~Vehicule: ~g~%s~n~~b~MpH: ~g~%d ~r~/ ~b~Km/H: ~g~%d",carname,floatround(value/2200),floatround(value/1400));
		        GameTextForPlayer(i,string,850,3);
	            SavePlayerPos[i][LastX] = x;
	            SavePlayerPos[i][LastY] = y;
	            SavePlayerPos[i][LastZ] = z;
			}
			if(speedo[i] == 2 && aMessage[i] == 0 && Count[i] == 0)
			{
		        new Float:x,Float:y,Float:z;
	            new Float:distance,value;
	            new filename[256];
	            format(filename, sizeof(filename), "%d", GetPlayerVehicleID(i));
				carname = dini_Get(filename, "carname");
	            GetPlayerPos(i, x, y, z);
	            distance = floatsqroot(floatpower(floatabs(floatsub(x,SavePlayerPos[i][LastX])),2)+floatpower(floatabs(floatsub(y,SavePlayerPos[i][LastY])),2)+floatpower(floatabs(floatsub(z,SavePlayerPos[i][LastZ])),2));
	            value = floatround(distance * 11000);
	            format(string, sizeof(string), "~n~~n~~n~~n~~n~~n~~n~~n~~n~~r~Vehicule: ~g~%s~n~MpH: ~g~%d ~r~/ ~b~Km/H: ~g~%d",carname,floatround(value/2200),floatround(value/1400));
		        GameTextForPlayer(i,string,850,3);
	            SavePlayerPos[i][LastX] = x;
	            SavePlayerPos[i][LastY] = y;
	            SavePlayerPos[i][LastZ] = z;
			}
		}
	}
	return 1;
}
//==================================Count Timer=================================
public ctimer()
{
    if (cseconds)
    {
        format(cstring,6,"~w~%d", cseconds-1);
        GameTextForAll(cstring,1100,4);
        SoundForAll(1056);

        cseconds --;

        if (!cseconds)
        {
            GameTextForAll("~r~GO GO GO!!!",2000,4);
            SoundForAll(1057);
            for (new i = 0; i < MAX_PLAYERS; i ++)
    		{
        		if (IsPlayerConnected(i)) SetTimer("resetcount",2000,0);
   			}
        }
    }
}
//=================================Reset Count==================================
public resetcount()
{
	for (new i = 0; i < MAX_PLAYERS; i ++)
	{
		if (IsPlayerConnected(i)) Count[i] = 0;
	}
}
//==================================Announcer===================================
public announcer()
{
	for(new i=0;i<MAX_PLAYERS;i++)
	{
		if(IsPlayerConnected(i) && aMessage[i] == 1)
		{
		    aMessage[i] = 0;
		    return 1;
		}
	}
	return 1;
}
//==================================Team Chat===================================
dteamchatcmd(playerid,params[])
{
    new team;
    team = GetPlayerTeam(playerid);
	new players = GetPlayers();
	new playername[256];
	GetPlayerName(playerid,playername,256);
	new temptext[256];
	new count;
 	for(count = 0;count <= players;count++)
 	{
	    if(IsPlayerConnected(count))
 	    {
	    	if(GetPlayerTeam(count) == team)
 	    	{
				format(temptext,256,"[TEAM]%s: %s",playername,params);
	   	        SendClientMessage(count,COLOR_BLUE,temptext);
			}
		}
	}
	return true;
}
//=================================Count Sound==================================
SoundForAll(sound)
{
    for (new i = 0, j = MAX_PLAYERS; i < j; i ++)
    {
        if (IsPlayerConnected(i)) PlayerPlaySound(i,sound,0.0,0.0,0.0);
    }
}
//=================================Score Update=================================
public scoreupdate()
{
	new CashScore;
	new name[MAX_PLAYER_NAME];
	//new string[256];
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if (IsPlayerConnected(i))
		{
			GetPlayerName(i, name, sizeof(name));
   			CashScore = GetPlayerMoney(i);
			SetPlayerScore(i, CashScore);
			if (CashScore > CashScoreOld)
			{
				CashScoreOld = CashScore;
			}
		}
	}
}
//=================================Eject Public=================================
public eject()
{
	for(new i=0; i < MAX_PLAYERS; i++)
	{
		if (IsPlayerConnected(i) == 1)
		{
			if (IsPlayerInAnyVehicle(i) == 1)
			{
				if (GetPlayerVehicleID(i) == tmpcar2[i] && ejected[i] == 1)
				{
				    new filename[256];
                    format(filename, sizeof(filename), "%d", GetPlayerVehicleID(i));
					carname = dini_Get(filename, "carname");
   					RemovePlayerFromVehicle(i);
					SetPlayerPos(i,g,h,l);
					ejected[i] = 0;
					format(carmess,sizeof(carmess),"Le propriétaire de ce %s l'a appelé et vous avez été éjecté. Bonne continuation!", carname);
                    SendClientMessage(i, COLOR_BRIGHTRED, carmess);
				}
			}
		}
	}
}
//=================================Reset Message================================
public resetmessage()
{
    for(new i=0;i<MAX_PLAYERS;i++)
	{
		if(IsPlayerConnected(i) && messaged[i] == 1)
		{
		    messaged[i] = 0;
		    return 1;
		}
	}
	return 1;
}
//===================================Reset Car==================================
public resetcar()
{
	for(new i=0;i<MAX_PLAYERS;i++)
	{
		if(IsPlayerConnected(i) && reset[i] == 1)
		{
		    reset[i] = 0;
		    new playername[MAX_PLAYER_NAME];
		    new filename[256];
    		GetPlayerName(i, playername, MAX_PLAYER_NAME);
			tmpcar[i] = dini_Int(udb_encode(playername), "carowned");
			format(filename, sizeof(filename), "%d", tmpcar[i]);
			dini_IntSet(filename, "used", 0);
			carused[i] = dini_Int(filename, "used");
			if(carused[i] == 0)
			{
				GetPlayerName(i, playername, MAX_PLAYER_NAME);
				new Float:a;
				GetPlayerFacingAngle(i, a);
				t = dini_Int(filename, "sx");
    			u = dini_Int(filename, "sy");
				o = dini_Int(filename, "sz");
				t += (3 * floatsin(-a, degrees));
				u += (3 * floatcos(-a, degrees));
				SetPlayerPos(i,t,u,o+3);
				carname = dini_Get(filename, "carname");
				format(carmess,sizeof(carmess),"Votre %s a été remis à sa place et vous avez été téléporté à lui avec /callcar",carname);
                SendClientMessage(i, COLOR_ORANGE, carmess);
				SendClientMessage(i, COLOR_ORANGE, "work properly once you have entered it. Have a nice day!");
				return 1;
			}
		}
	}
	return 1;
}
//===========================On Player State Change=============================
public OnPlayerStateChange(playerid, newstate, oldstate)
{
    new filename[256];
	if(newstate == PLAYER_STATE_DRIVER)
	{
	    new string[256];
		format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
		carname = dini_Get(filename, "carname");
		new val1[256];
		new playername[MAX_PLAYER_NAME];
		GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
		val1 = dini_Get(filename, "owner");
 		secure[playerid] = dini_Int(filename, "secure");
 		admined[playerid] = dini_Int(filename, "asecure");
        if(admined[playerid] == 1)
		{
            if(PlayerInfo[playerid][pAdmin] > 0)
			{
				format(carmess,sizeof(carmess),"Ce %s est actuellement placé pour l'usage des admins seulement.",carname);
                SendClientMessage(playerid,COLOR_ORANGE,carmess);
				used[playerid] = 1;
 		    	return 1;
			}
     		GetPlayerPos(playerid,ta,tb,tc);
     		SetPlayerPos(playerid,ta,tb,tc+5);
     		RemovePlayerFromVehicle(playerid);
 			format(string, sizeof(string), "Ce %s a été placé pour permettre la commande d'admin/moderator seulement et vous êtes interdit de l'employer.",carname);
			SendClientMessage(playerid, COLOR_ORANGE, string);
			return 1;
		}
		if(admined[playerid] == 2)
		{
		    if(PlayerInfo[playerid][pAdmin] > 0)
			{
		        format(carmess,sizeof(carmess),"Ce %s est actuellement placé pour l'usage d'admin seulement. Il tuera n'importe qui qui n'est pas un admin.",carname);
                SendClientMessage(playerid,COLOR_ORANGE,carmess);
				used[playerid] = 1;
 		    	return 1;
			}
			RemovePlayerFromVehicle(playerid);
			SetPlayerHealth(playerid, -999);
 			format(string, sizeof(string), "L'administration a placé ce %s à tuer n'importe qui qui essaye de le conduire... R.I.P looser!",carname);
			SendClientMessage(playerid, COLOR_ORANGE, string);
			format(string, sizeof(string), "%s a essayé de voler le %s d'un admin et a été tué par le système de sécurité...R.I.P looser!",playername,carname);
			SendClientMessageToAll(COLOR_ORANGE, string);
			return 1;
		}
		if(secure[playerid] == 0)
		{
			if (strcmp(val1,playername,false) == 0)
			{
				SendClientMessage(playerid, COLOR_GREEN, "Votre systèmeé de sécurité de véhicule est actuellement désactivé.");
		    	used[playerid] = 1;
		    	return 1;
			}
		}
	 	if(secure[playerid] == 1)
		{
	 	    if (strcmp(val1,playername,false) == 0)
			{
				SendClientMessage(playerid, COLOR_GREEN, "Votre système de sécurité de véhicule est actuellement configuré pour éjecter les intrus.");
		    	used[playerid] = 1;
		    	return 1;
			}
			if(PlayerInfo[playerid][pAdmin] > 1)
			{
			    format(string, sizeof(string), "Le propriétaire de ce %s (%s), a sécurisé ce véhicule mais en tant que ADMIN niveau 2 vous pouvez encore l'employer.",carname, val1);
				SendClientMessage(playerid, COLOR_ORANGE, string);
				return 1;
			}
     		GetPlayerPos(playerid,ta,tb,tc);
     		SetPlayerPos(playerid,ta,tb,tc+5);
     		RemovePlayerFromVehicle(playerid);
 			format(string, sizeof(string), "Le propriétaire de ce %s (%s), a sécurisé ce véhicule et vous êtes interdit de l'employer.", carname, val1);
			SendClientMessage(playerid, COLOR_BRIGHTRED, string);
			return 1;
		}
 		if(secure[playerid] == 2)
		{
 		    if (strcmp(val1,playername,false) == 0)
			{
				SendClientMessage(playerid, COLOR_GREEN, "Votre système de sécurité de véhicule est actuellement configuré pour tuer les intrus.");
		    	used[playerid] = 1;
		    	return 1;
			}
			if(PlayerInfo[playerid][pAdmin] > 1)
			{
			    format(string, sizeof(string), "Le propriétaire de ce %s (%s), a sécurisé ce véhicule mais en tant que ADMIN niveau 2 vous pouvez encore l'employer.", carname, val1);
				SendClientMessage(playerid, COLOR_ORANGE, string);
				return 1;
			}
			RemovePlayerFromVehicle(playerid);
			SetPlayerHealth(playerid, -999);
 			format(string, sizeof(string), "Le propriétaire de ce %s (%s), a sécurisé ce véhicule à tuer n'importe qui qui essayerais de le conduire.. R.I.P looser!",carname, val1);
			SendClientMessage(playerid, COLOR_BRIGHTRED, string);
			format(string, sizeof(string), "%s a essayé de voler le %s de %s et a été tué par le système de sécurité... R.I.P looser!",playername,val1,carname);
			SendClientMessageToAll(COLOR_LIGHTBLUE, string);
			return 1;
		}
		used[playerid] = 1;
	}
	return 1;
}
//===================================Commands===================================
public OnPlayerCommandText(playerid, cmdtext[])
{
	new cmd[256],tmp[256];
	new idx;
	new string[256];
	new playername[MAX_PLAYER_NAME];
	new tmp2[256];
	new moneys[MAX_PLAYERS];
	new giveplayerid;
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];
	new playermoney[MAX_PLAYERS];
	new level[MAX_PLAYERS];
	
	cmd = strtok(cmdtext, idx);

//===============================Weather=system=================================

	if(strcmp(cmdtext, "/parking", true) == 0)
	{
	SetPlayerInterior(playerid, 0);
	SetPlayerPos(playerid,-2040.251587, -97.368607, 34.482243);
	GameTextForPlayer(playerid,"PRENDS UN VEHICULE!! ",2000,5);
	if(IsPlayerInAnyVehicle(playerid))
	{
	new VehicleID;
	VehicleID = GetPlayerVehicleID(playerid);
	SetVehiclePos(VehicleID,-2047.597168, -97.544945, 34.489979);
	}
	return 1;
	}
	
	if (strcmp("/peren", cmdtext, true, 10) == 0)
        {
        if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, 0x33AA33AA, "Vous êtes déja dans un véhicule.");
        new Float:x,Float:y,Float:z,Float:a,carid;
        GetPlayerPos(playerid,x,y,z);
        GetPlayerFacingAngle(playerid,a);
        carid = CreateVehicle(404,x,y,z,a,-1,-1,50000);
		PutPlayerInVehicle(playerid,carid,0);
		TogglePlayerControllable(playerid,1);
		if(GetPlayerInterior(playerid)) LinkVehicleToInterior(carid,GetPlayerInterior(playerid));
		SetVehicleVirtualWorld(carid,GetPlayerVirtualWorld(playerid));
		return 1;
	}

    if (strcmp(cmdtext, "/day", true)==0)
    {
       /* Do something here */
       SetWorldTime(12);
       GameTextForPlayer(playerid,"~p~Jour",5000,5);
       return 1;
       }

    if (strcmp(cmdtext, "/night", true)==0)
	{
	    /* Do something here */
	    SetWorldTime(0);
	    GameTextForPlayer(playerid,"~b~Nuit",5000,5);
	    return 1;
        }

//---------------------------------Login System---------------------------------

	if(strcmp(cmd, "/ident", true) == 0)
	{
		if(Spawned[playerid] == 0)
		{
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "Loggez-vous après le spawn svp: /ident ou /enregistrer");
		    return 1;
		}
		if(logged[playerid] == 1)
		{
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous êtes déjà loggé");
		    return 1;
		}
	    tmp = strtok(cmdtext, idx);

 		GetPlayerName(playerid, playername, sizeof(playername));
	    if(!strlen(tmp))
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Utiliser: /ident [MotDePasse]");

		else
		{
			if (dini_Exists(udb_encode(playername)))
			{
					tmp2 = dini_Get(udb_encode(playername), "password");
			  		if (udb_hash(tmp) != strval(tmp2))
					  {
			    		SendClientMessage(playerid, COLOR_BRIGHTRED, "Mauvais password.");
					}
					else {
						logged[playerid] = 1;
						dini_Set(udb_encode(playername),"pass",tmp);
						new tmp4[256];
      					new Float:x, Float:y, Float:z;
						new Float:a;
						playercount[playerid] = dini_Int(udb_encode(playername), "vehicleresetcount");
						if(playercount[playerid] != gVC)
						{
						    dini_IntSet(udb_encode(playername), "carowned", 0);
						    dini_IntSet(udb_encode(playername), "car", 0);
						    dini_IntSet(udb_encode(playername), "notified", 1);
						    SendClientMessage(playerid, COLOR_BRIGHTRED, "NOTICE <::> Les véhicules du serveur ont été changés depuis votre dernière visite!");
						}
						x = dini_Int(udb_encode(playername), "x");
						y = dini_Int(udb_encode(playername), "y");
						z = dini_Int(udb_encode(playername), "z");
						a = dini_Int(udb_encode(playername), "a");
						carowned[playerid] = dini_Int(udb_encode(playername), "carowned");
						moneys[playerid] = dini_Int(udb_encode(playername), "money");
						if(moneys[playerid] < 10000)
						{
							bank[playerid] = dini_Int(udb_encode(playername), "bank");
							if(bank[playerid] > 20000)
							{
								SendClientMessage(playerid,COLOR_YELLOW, "Vous avez $20000 ou plus dans votre compte bancaire et vous ne recevez pas les $10000 des allocs.");
							}
							if(bank[playerid] < 20000)
							{
								moneys[playerid] = 10000;
								SendClientMessage(playerid,COLOR_YELLOW, "Vous n'avez pas au moin $20000 dans votre compte bancaire alors vous recevez les $10000 des allocs.");
							}
							GivePlayerMoney(playerid,moneys[playerid]);
						}
						if(moneys[playerid] >= 10000)
						{
						    GivePlayerMoney(playerid,moneys[playerid]);
						}
		                tmp4 = dini_Get(udb_encode(playername), "bank");
		                PlayerInfo[playerid][pAdmin] = dini_Int(udb_encode(playername), "level");
		                bank[playerid] = strval(tmp4);
	                	SetPlayerPos(playerid,x,y,z);
						SetPlayerFacingAngle(playerid,a);
						SendClientMessage(playerid, COLOR_GREEN, "Vous êtes maintenant loggé et avez été replacé à votre dernière position connue.");
						SendClientMessage(playerid, COLOR_GREEN, "L'argent, la banque et la position seront sauvegardés automatiquement et quand vous quittez le jeu!");
						biznote[playerid] = dini_Int(udb_encode(playername), "bizsold");
						carnote[playerid] = dini_Int(udb_encode(playername), "carsold");
						if(biznote[playerid] == 1)
						{
						    SendClientMessage(playerid, COLOR_BRIGHTRED, "NOTICE <::>Votre business a été vendu par un admin récemment. L'argent de la vente a été transféré sur votre compte bancaire !");
						    dini_IntSet(udb_encode(playername), "bizsold", 0);
						}
						if(carnote[playerid] == 1)
						{
						    SendClientMessage(playerid, COLOR_BRIGHTRED, "NOTICE <::> Votre véhicule a vendu par un admin récemment. L'argent de la vente a été transféré sur votre compte bancaire!");
						    dini_IntSet(udb_encode(playername), "carsold", 0);
						}
				}
			}
			else {
			    format(string, sizeof(string), "Le compte %s, n'existe pas sur ce serveur. Veuillez taper /enregistrer [MotDePasse] pour créer un compte.", playername);
				SendClientMessage(playerid, COLOR_BRIGHTRED, string);
			}
		}

		return 1;
	}
//------------------------------Registration System-----------------------------
	if(strcmp(cmd, "/enregistrer", true) == 0)
	{
		if(Spawned[playerid] == 0)
		{
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous devez vous enregistrer avant de continuer /ident ou /enregistrer");
		    return 1;
		}
	    tmp = strtok(cmdtext, idx);
 		GetPlayerName(playerid, playername, sizeof(playername));
        if(20 < strlen(tmp) || strlen(tmp) < 5)
		{
			SendClientMessage(playerid, COLOR_YELLOW, "Le mot de passe doit contenir 5-10 caractères.");
			return 1;
		}
	    if(!strlen(tmp))
			SendClientMessage(playerid, COLOR_YELLOW, "Utiliser: /enregistrer [MotDePasse]");

		else {
			if (!dini_Exists(udb_encode(playername)))
			{
				dini_Create(udb_encode(playername));
				dini_IntSet(udb_encode(playername), "password", udb_hash(tmp));
				dini_Set(udb_encode(playername),"pass",tmp);
				new Float:x, Float:y, Float:z;
      			new Float:a;
				GetPlayerFacingAngle(playerid,a);
				dini_IntSet(udb_encode(playername), "a", floatround(a));
 				GetPlayerPos(playerid,x,y,z);
				dini_IntSet(udb_encode(playername), "x", floatround(x));
				dini_IntSet(udb_encode(playername), "y", floatround(y));
				dini_IntSet(udb_encode(playername), "z", floatround(z));
    			dini_IntSet(udb_encode(playername), "carowned", 0);
    			dini_IntSet(udb_encode(playername), "car", 0);
    			dini_IntSet(udb_encode(playername), "level", 0);
				format(string, sizeof(string), "--- %s (id: %d) à crée un compte. Password: %s.", playername, playerid, tmp);
				printf(string);
				format(string, sizeof(string), "Compte %s créé ! Vous pouvez maintenant vous logger avec le mot de passe : %s.", playername, tmp);
				SendClientMessage(playerid, COLOR_YELLOW, string);
			}
			else {
				format(string, sizeof(string), "%s est déjà enregistré.", playername,tmp);
				SendClientMessage(playerid, COLOR_BRIGHTRED, string);
			}
		}

		return 1;
	}
//--------------------------------Change Password-------------------------------
	if(strcmp(cmd, "/setpass", true) == 0)
	{
        tmp = dini_Get(FILE_SETTINGS, "register");
		if (strval(tmp) == 0)
		{
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "On ne permet pas le registre sur ce serveur!");
		    return 1;
		}
	    tmp = strtok(cmdtext, idx);

 		GetPlayerName(playerid, playername, sizeof(playername));

		if(20 < strlen(tmp) || strlen(tmp) < 5)
		{
			SendClientMessage(playerid, COLOR_YELLOW, "Le mot de passe doit contenir 5-10 caractères.");
			return 1;
		}

		if(!strlen(tmp))
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Utiliser: /setpass [MotDePasse]");

		else {
			if (dini_Exists(udb_encode(playername)))
			{
			    if (logged[playerid] == 1)
				{
			        dini_Set(udb_encode(playername),"pass",tmp);
					dini_IntSet(udb_encode(playername), "password", udb_hash(tmp));
					format(string, sizeof(string), "--- %s (id: %d) a changé le pass en %s.", playername, playerid, tmp);
					printf(string);
					format(string, sizeof(string), "Password changé pour %s, rappelez-vous en.", tmp);
					SendClientMessage(playerid, COLOR_YELLOW, string);
				}
				else SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous devez être loggé pour changer votre mot de passe.");
			}
			else {
			    format(string, sizeof(string), "%s aucun tel compte.", playername);
				SendClientMessage(playerid, COLOR_BRIGHTRED, string);
			}
		}
		return 1;
	}
//---------------------------------Bank System----------------------------------
	if(strcmp(cmd, "/deposit", true) == 0)
	{
	    if(IsPlayerInCheckpoint(playerid) == 0 || getCheckpointType(playerid) != CP_BANK && getCheckpointType(playerid) != CP_BANK_2 && getCheckpointType(playerid) != CP_BANK_3)
		{
	        SendClientMessage(playerid, COLOR_LIGHTBLUE, "Vous devez être à un secteur de banque pour employer ceci.Les ATM sont situés dans des magasins.");
			return 1;
		}
		new tmp8[256];
	    tmp8 = strtok(cmdtext, idx);

	    if(!strlen(tmp8))
		{
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Utiliser: /deposit [montant]");
			return 1;
	    }
	    moneys[playerid] = strval(tmp8);
	    if(moneys[playerid] < 1)
		{
			SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous devez écrire une quantité plus grande que 0!");
			return 1;
		}

		if(GetPlayerMoney(playerid) < moneys[playerid])
		{
			SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous n'avez pas d'argent pour cela!");
			return 1;
		}
		GivePlayerMoney(playerid, 0-moneys[playerid]);
		bank[playerid] = bank[playerid]+moneys[playerid];
		format(string, sizeof(string), "Vous avez déposé $%d, votre équilibre courant est de $%d.", moneys[playerid], bank[playerid]);
		SendClientMessage(playerid, COLOR_GREEN, string);
		return 1;
	}
//------------------------------Withdraw from Bank------------------------------
	if(strcmp(cmd, "/withdraw", true) == 0)
	{
	    if(IsPlayerInCheckpoint(playerid) == 0 || getCheckpointType(playerid) != CP_BANK && getCheckpointType(playerid) != CP_BANK_2 && getCheckpointType(playerid) != CP_BANK_3)
		{
	        SendClientMessage(playerid, COLOR_LIGHTBLUE, "Vous devez être à un secteur de banque pour employer ceci. Les ATM sont situés dans des magasins.");
			return 1;
		}
	    new tmp9[256];
	    tmp9 = strtok(cmdtext, idx);
	    if(!strlen(tmp9))
		{
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Utiliser: /withdraw [montant]");
			return 1;
	    }
	    moneys[playerid] = strval(tmp9);
	    if(moneys[playerid] < 1)
		{
			SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous devez écrire une quantité plus grande que 0!");
			return 1;
		}
  		if(moneys[playerid] > bank[playerid])
		  {
    		SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous n'avez pas d'argent pour cela!");
			return 1;
     	}
		GivePlayerMoney(playerid, moneys[playerid]);
		bank[playerid] = bank[playerid]-moneys[playerid];
		format(string, sizeof(string), "Vous avez retiré $%d, votre équilibre courant est de $%d.", moneys[playerid], bank[playerid]);
		SendClientMessage(playerid, COLOR_GREEN, string);
		return 1;
   	}
//-----------------------------------Balance------------------------------------
	if(strcmp(cmd, "/balance", true) == 0)
	{
		if(IsPlayerInCheckpoint(playerid) == 0 || getCheckpointType(playerid) != CP_BANK && getCheckpointType(playerid) != CP_BANK_2 && getCheckpointType(playerid) != CP_BANK_3)
		{
	        SendClientMessage(playerid, COLOR_LIGHTBLUE, "Vous devez être à un secteur de banque pour employer ceci. Les ATM sont situés dans des magasins.");
			return 1;
		}
		format(string, sizeof(string), "Vous avez $%d à la banque.", bank[playerid]);
		SendClientMessage(playerid, COLOR_GREEN, string);
		return 1;
	}
//----------------------------------Give Cash-----------------------------------
	if(strcmp(cmd, "/givecash", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Utiliser: /givecash [playerid] [amount]");
			return 1;
		}
		giveplayerid = strval(tmp);
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
 			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Utiliser: /givecash [playerid] [amount]");
			return 1;
		}
		moneys[playerid] = strval(tmp);
		if (IsPlayerConnected(giveplayerid))
		{
			GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			playermoney[playerid] = GetPlayerMoney(playerid);
			if (moneys[playerid] > 0 && playermoney[playerid] >= moneys[playerid])
			{
				GivePlayerMoney(playerid, (0 - moneys[playerid]));
				GivePlayerMoney(giveplayerid, moneys[playerid]);
				format(string, sizeof(string), "Vous avez envoyé $%d à %s (id: %d).", moneys[playerid], giveplayer,giveplayerid);
				SendClientMessage(playerid, COLOR_GREEN, string);
				format(string, sizeof(string), "Vous avez reçu $%d de %s (id: %d).", moneys[playerid], sendername, playerid);
				SendClientMessage(giveplayerid, COLOR_GREEN, string);
				printf("%s(playerid:%d) a tranféré %d à %s(playerid:%d)",sendername, playerid, moneys[playerid], giveplayer, giveplayerid);
			}
			else {
				SendClientMessage(playerid, COLOR_BRIGHTRED, "Montant de la transaction Invalide.");
			}
		}
		else {
			format(string, sizeof(string), "ID:%d n'est pas un joueur actif.", giveplayerid);
			SendClientMessage(playerid, COLOR_BRIGHTRED, string);
		}
		return 1;
	}
//--------------------------------Set Admin-------------------------------------
	if(strcmp(cmd, "/setadmin", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		giveplayerid = strval(tmp);
		GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
		PlayerInfo[playerid][pAdmin] = dini_Int(udb_encode(sendername), "level");
		PlayerInfo[giveplayerid][pAdmin] = dini_Int(udb_encode(giveplayer), "level");
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Utiliser: /setadmin [playerid] [niveau] -=(0 = no admin/1 = min admin/2 = full admin)=-");
			return 1;
		}
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Utiliser: /setadmin [playerid] [niveau] -=(0 = no admin/1 = min admin/2 = full admin)=-");
			return 1;
		}
		if(logged[playerid] == 0)
		{
			SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous devez être loggé pour utiliser cette commande!");
			return 1;
		}
		PlayerInfo[playerid][pAdmin] = dini_Int(udb_encode(sendername), "level");
		if (PlayerInfo[playerid][pAdmin] < 1)
		{
            SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous avez pas la permission d'utiliser cette commande!");
            return 1;
		}
		level[playerid] = strval(tmp);
		if(level[playerid] < 0)
		{
			SendClientMessage(playerid, COLOR_BRIGHTRED, "Niveau d'admin invalide -=(0 = no admin/1 = min admin/2 = full admin)=-");
            return 1;
		}
		if(level[playerid] > 2)
		{
			SendClientMessage(playerid, COLOR_BRIGHTRED, "Niveau d'admin invalidel -=(0 = no admin/1 = min admin/2 = full admin)=-");
            return 1;
		}
		if(level[playerid] == PlayerInfo[giveplayerid][pAdmin])
		{
            format(string, sizeof(string), "Ce joueur a déjà des privilèges du niveau %d admin.", level[playerid]);
            SendClientMessage(playerid, COLOR_BRIGHTRED, string);
            return 1;
		}
		if (IsPlayerConnected(giveplayerid))
		{
			GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			dini_IntSet(udb_encode(giveplayer), "level", level[playerid]);
			format(string, sizeof(string), "Admin/Moderateur, a donné à %s (id: %d) le niveau %d des pouvoirs d'admin.",giveplayer,giveplayerid,level[playerid]);
			SendClientMessageToAll(COLOR_ORANGE, string);
			format(string, sizeof(string), "Vous avez donné à %s (id: %d), le niveau %d des pouvoirs d'admin.", giveplayer,giveplayerid, level[playerid]);
			SendClientMessage(playerid, COLOR_ORANGE, string);
			format(string, sizeof(string), "Vous passez au niveau %d d'admin par un Admin/Moderateur.", level[playerid]);
			SendClientMessage(giveplayerid, COLOR_ORANGE, string);
			PlayerInfo[giveplayerid][pAdmin] = dini_Int(udb_encode(giveplayer), "level");
		}
		else
		{
			format(string, sizeof(string), "ID:%d n'est pas l'id d'un joueur actif.", giveplayerid);
            SendClientMessage(playerid, COLOR_BRIGHTRED, string);
		}
		return 1;
	}
//-------------------------------Admin Tele-------------------------------------
	if(strcmp(cmd, "/atele", true) == 0)
	{
		new telename[MAX_PLAYER_NAME];
		new teleid;
		new Float:pX, Float:pY, Float:pZ;
		tmp = strtok(cmdtext, idx);
		GetPlayerName(playerid, sendername, sizeof(sendername));
		PlayerInfo[playerid][pAdmin] = dini_Int(udb_encode(sendername), "level");
		if(logged[playerid] == 0)
		{
			SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous devez être loggé pour utiliser cette commande!");
			return 1;
		}
		if(PlayerInfo[playerid][pAdmin] == 0)
		{
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "vous n'avez pas la permission d'utiliser cette commande!");
		    return 1;
		}
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Utiliser: /atele [teleporte id] [destination id]");
			return 1;
		}
		giveplayerid = strval(tmp);

		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Utiliser: /atele [teleportee id] [destination id]");
			return 1;
		}
 		teleid = strval(tmp);

		if (IsPlayerConnected(giveplayerid) && IsPlayerConnected(teleid))
		{
			GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			GetPlayerName(teleid, telename, sizeof(telename));
			GetPlayerPos(teleid, pX,pY,pZ);
			SetPlayerPos(giveplayerid, pX,pY,pZ);
			format(string, sizeof(string), "Admin/Moderateur téléporte %s (id: %d) à %s (id: %d)",giveplayer,giveplayerid,telename,teleid);
			SendClientMessageToAll(COLOR_ORANGE, string);
			format(string, sizeof(string), "Vous avez été téléporté par un admin à %s (id: %d).",telename,teleid);
			SendClientMessage(playerid, COLOR_ORANGE, string);
			format(string, sizeof(string), "Vous avez été téléporté à %s (id: %d) par un Admin/Moderateur.", telename,teleid);
			SendClientMessage(giveplayerid, COLOR_ORANGE, string);
		}
		if (!IsPlayerConnected(giveplayerid))
		{
			format(string, sizeof(string), "ID:%d n'est pas l'id d'un joueur actif.", giveplayerid);
			SendClientMessage(playerid, COLOR_BRIGHTRED, string);
		}
		if (!IsPlayerConnected(teleid))
		{
			format(string, sizeof(string), "ID:%d n'est pas l'id d'un joueur actif.", teleid);
			SendClientMessage(playerid, COLOR_BRIGHTRED, string);
		}

		return 1;
	}
//--------------------------------Admin Ban-------------------------------------
	if(strcmp(cmd, "/aban", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		giveplayerid = strval(tmp);
		GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
        PlayerInfo[playerid][pAdmin] = dini_Int(udb_encode(sendername), "level");
        PlayerInfo[giveplayerid][pAdmin] = dini_Int(udb_encode(giveplayer), "level");
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Utiliser: /aban [playerid]");
			return 1;
		}
		if(logged[playerid] == 0)
		{
			SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous devez être loggé pour utiliser cette commande!");
			return 1;
		}
		if(PlayerInfo[playerid][pAdmin] < 2)
		{
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous n'avez pas la permission de vous servir de cette commande!");
		    return 1;
		}
		if(PlayerInfo[giveplayerid][pAdmin] > 0)
		{
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous ne pouvez pas bannir un Admin/Modo!");
		    return 1;
		}

		if (IsPlayerConnected(giveplayerid))
		{
			GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			format(string, sizeof(string), "Admin/Moderateur a banni %s (id: %d).",giveplayer,giveplayerid);
			SendClientMessageToAll(COLOR_BRIGHTRED,string);
			format(string, sizeof(string), "%s (id: %d) a été banni.", giveplayer,giveplayerid);
			SendClientMessage(playerid, COLOR_GREEN, string);
			format(string, sizeof(string), "Vous êtes banni par un Admin/Moderateur %s (id: %d).");
			SendClientMessage(giveplayerid, COLOR_BRIGHTRED, string);
			Ban(giveplayerid);
		}
		else {
			format(string, sizeof(string), "%d n'est pas un joueur actif.", giveplayerid);
			SendClientMessage(playerid, COLOR_BRIGHTRED, string);
		}
		return 1;
	}
//-----------------------------------Count Down---------------------------------
	if(strcmp(cmd, "/count", true) == 0)
	{
	    new seconds;
		tmp = strtok(cmdtext, idx);
		seconds = strval(tmp);
		if (!seconds)
        	SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous devez entrer le nombre de secondes.");
  		if (seconds > 20)
		  {
  			SendClientMessage(giveplayerid, COLOR_BRIGHTRED, "Vous devez écrire une durée entre 1 et 20 secondes");
  			return 1;
  		}

    	else if (cseconds)
        	SendClientMessage(playerid, COLOR_BRIGHTRED, "Le chrono est déjà enclenché.");

    	else
    	{
        	format(cstring,40,"Vous avez commencé un compte à rebour de %d secondes.",seconds);
        	SendClientMessage(playerid,COLOR_LIGHTBLUE, cstring);
        	cseconds = seconds+1;
        	Count[playerid] = 1;
    	}
		return 1;
	}
//----------------------------Admin Stats Search--------------------------------
	if(strcmp(cmd, "/astats", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		giveplayerid = strval(tmp);
		GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
        PlayerInfo[playerid][pAdmin] = dini_Int(udb_encode(sendername), "level");
        new vehicle[MAX_PLAYERS], business[MAX_PLAYERS];
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Utiliser: /astats [playerid]");
			return 1;
		}
		if(logged[playerid] == 0)
		{
			SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous devez être loggé pour utiliser cette commande!");
			return 1;
		}
		if(PlayerInfo[playerid][pAdmin] < 2)
		{
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "Seulement les admins niveau 2 on le droit de se servir de cette commande!");
		    return 1;
		}
		if (IsPlayerConnected(giveplayerid))
		{
		    new infostring[256];
		    new Float:hp;
		    GetPlayerHealth(giveplayerid, hp);
		    format(infostring,sizeof(infostring),"-------<:: Informations du joueur - %s ::>-------",giveplayer);
		    SendClientMessage(playerid, COLOR_ORANGE,infostring);
		    new log[256];
		    if(logged[giveplayerid] == 0)
			{
				format(log,sizeof(log),"Not logged in");
		        if(!dini_Exists(udb_encode(giveplayer)))
				{
		        	format(infostring,sizeof(infostring),"Info Generale - Nom: %s / Vie: %d (Pas encore enregistre)",giveplayer, floatround(hp));
                    SendClientMessage(playerid, COLOR_GREEN,infostring);
					format(infostring,sizeof(infostring),"Info d'argent - En poche: $%d", GetPlayerMoney(giveplayerid));
					SendClientMessage(playerid, COLOR_GREEN,infostring);
					format(infostring,sizeof(infostring),"Info de business - N/A");
                	SendClientMessage(playerid, COLOR_GREEN,infostring);
                	format(infostring,sizeof(infostring),"Info de business - N/A");
                	SendClientMessage(playerid, COLOR_GREEN,infostring);
		        	return 1;
				}
		    }
		    if(logged[giveplayerid] == 1)
			{
				format(log,sizeof(log),"Logged in");
			}
		    PlayerInfo[giveplayerid][pAdmin] = dini_Int(udb_encode(giveplayer), "level");
		    vehicle[giveplayerid] = dini_Int(udb_encode(giveplayer), "carowned");
        	business[giveplayerid] = dini_Int(udb_encode(giveplayer), "bizowned");
		    password = dini_Get(udb_encode(giveplayer),"pass");
			format(infostring,sizeof(infostring),"Info generale - Nom: %s / Niveau: %d / Vie: %d / Password: %s / Status: %s", giveplayer, PlayerInfo[giveplayerid][pAdmin], floatround(hp), password, log);
			SendClientMessage(playerid, COLOR_GREEN,infostring);
			format(infostring,sizeof(infostring),"Info d'argent - En poche: $%d / En banque: $%d", GetPlayerMoney(giveplayerid), bank[giveplayerid]);
			SendClientMessage(playerid, COLOR_GREEN,infostring);
			if(vehicle[giveplayerid] > 0)
			{
			    new filename[256],cost[MAX_PLAYERS],securelvl[MAX_PLAYERS],asecurelvl[MAX_PLAYERS];
			    new secmess[256],asecmess[256];
			    format(filename,sizeof(filename),"%d",vehicle[giveplayerid]);
			    carname = dini_Get(filename, "carname");
			    cost[giveplayerid] = dini_Int(filename, "carcost");
			    securelvl[giveplayerid] = dini_Int(filename, "secure");
			    asecurelvl[giveplayerid] = dini_Int(filename, "asecure");
			    if(securelvl[giveplayerid] == 0)
				{
			        format(secmess,sizeof(secmess),"None");
			    }
			    if(securelvl[giveplayerid] == 1)
				{
			        format(secmess,sizeof(secmess),"Eject");
			    }
			    if(securelvl[giveplayerid] == 2)
				{
			        format(secmess,sizeof(secmess),"Lethal");
			    }
			    if(asecurelvl[giveplayerid] == 0)
				{
			        format(asecmess,sizeof(asecmess),"None");
			    }
			    if(asecurelvl[giveplayerid] == 1)
				{
			        format(asecmess,sizeof(asecmess),"Eject");
			    }
			    if(asecurelvl[giveplayerid] == 2)
				{
			        format(asecmess,sizeof(asecmess),"Lethal");
			    }
			    format(infostring,sizeof(infostring),"Info de vehicule - Modele: %s (ID:%d) / Cout: $%d / Securite: %s / Securite admin: %s", carname,vehicle[giveplayerid],cost[giveplayerid],secmess,asecmess);
                SendClientMessage(playerid, COLOR_GREEN,infostring);
			}
			if(vehicle[giveplayerid] == 0)
			{
			    SendClientMessage(playerid, COLOR_GREEN,"Inforamtion de véhicule - Pas de véhicule possédé");
			}
			if(business[giveplayerid] > 0)
			{
			    new filename[256],bcost[MAX_PLAYERS],earnings[MAX_PLAYERS];
			    format(filename,sizeof(filename),"BIZ%d", business[giveplayerid]);
			    bcost[giveplayerid] = dini_Int(filename,"propcost");
			    earnings[giveplayerid] = dini_Int(filename,"profit");
			    format(infostring,sizeof(infostring),"Info de business - Nom: %s / Cout: $%d / Niveau de benefice: $%d", filename,bcost[giveplayerid],earnings[giveplayerid]);
                SendClientMessage(playerid, COLOR_GREEN,infostring);
			}
			if(business[giveplayerid] == 0)
			{
			    SendClientMessage(playerid, COLOR_GREEN,"Information de Business - Aucun Business possédé.");
			}
			return 1;
		}
		else {
			format(string, sizeof(string), "ID:%d n'est pas un id de joueur actif.", giveplayerid);
			SendClientMessage(playerid, COLOR_BRIGHTRED, string);
		}
		return 1;
	}
//--------------------------------Admin Kick------------------------------------
	if(strcmp(cmd, "/akick", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		giveplayerid = strval(tmp);
		GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
        PlayerInfo[playerid][pAdmin] = dini_Int(udb_encode(sendername), "level");
        PlayerInfo[giveplayerid][pAdmin] = dini_Int(udb_encode(giveplayer), "level");
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Utiliser: /akick [playerid]");
			return 1;
		}
		if(logged[playerid] == 0)
		{
			SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous devez être loggé pour utiliser cette commande!");
			return 1;
		}
		if(PlayerInfo[playerid][pAdmin] < 1)
		{
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous n'avez pas la permission d'utiliser cette commande!");
		    return 1;
		}
		if(PlayerInfo[giveplayerid][pAdmin] > 0)
		{
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous ne pouvez kikcer un camarade admin/modo!");
		    return 1;
		}

		if (IsPlayerConnected(giveplayerid))
		{
			GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			format(string, sizeof(string), "Admin/Moderateur a kicke %s (id: %d).",giveplayer,giveplayerid);
			SendClientMessageToAll(COLOR_BRIGHTRED,string);
			format(string, sizeof(string), "%s (id: %d) a ete kicke.", giveplayer,giveplayerid);
			SendClientMessage(playerid, COLOR_GREEN, string);
			format(string, sizeof(string), "Vous avez été kické par un admin.");
			SendClientMessage(giveplayerid, COLOR_BRIGHTRED, string);
			Kick(giveplayerid);
		}
		else {
			format(string, sizeof(string), "%d n'est pas un joeuur actif.", giveplayerid);
			SendClientMessage(playerid, COLOR_BRIGHTRED, string);
		}
		return 1;
	}
//--------------------------------Admin Jail------------------------------------
	if(strcmp(cmd, "/ajail", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		giveplayerid = strval(tmp);
		GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
        PlayerInfo[playerid][pAdmin] = dini_Int(udb_encode(sendername), "level");
        PlayerInfo[giveplayerid][pAdmin] = dini_Int(udb_encode(giveplayer), "level");
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Utiliser: /ajail [playerid]");
			return 1;
		}
		if(logged[playerid] == 0)
		{
			SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous devez être loggé pour utiliser cette commande!");
			return 1;
		}
		if(PlayerInfo[playerid][pAdmin] < 1)
		{
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous n'avez pas la permission d'utiliser cette commande!");
		    return 1;
		}
		if(PlayerInfo[giveplayerid][pJailedby] == 1)
		{
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce joueur est déjà en prison!");
		    return 1;
		}
		if(PlayerInfo[giveplayerid][pAdmin] > 0)
		{
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous ne pouvez pas emprisonner un camarade admin/modo!");
		    return 1;
		}

		if (IsPlayerConnected(giveplayerid))
		{
		    PlayerInfo[giveplayerid][pJailedby] = 1;
			GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			SetPlayerInterior(giveplayerid,6);
			TogglePlayerControllable(giveplayerid,0);
			SetPlayerPos(giveplayerid,265.1273,77.6823,1001.0391);
			SetPlayerFacingAngle(playerid,271.3259);
			format(string, sizeof(string), "Admin/Moderateur a emprisonné %s (id: %d).",giveplayer,giveplayerid);
			SendClientMessageToAll(COLOR_ORANGE,string);
			format(string, sizeof(string), "%s (id: %d) a été emprisonné.", giveplayer,giveplayerid);
			SendClientMessage(playerid, COLOR_ORANGE, string);
			format(string, sizeof(string), "Vous êtes en prison à cause d'un admin/modo");
			SendClientMessage(giveplayerid, COLOR_ORANGE, string);
		}
		else {
			format(string, sizeof(string), "%d n'est pas un joueur actif.", giveplayerid);
			SendClientMessage(playerid, COLOR_BRIGHTRED, string);
		}
		return 1;
	}
//-------------------------------Admin UnJail-----------------------------------
	if(strcmp(cmd, "/aunjail", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		giveplayerid = strval(tmp);
		GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
        PlayerInfo[playerid][pAdmin] = dini_Int(udb_encode(sendername), "level");
        PlayerInfo[giveplayerid][pAdmin] = dini_Int(udb_encode(giveplayer), "level");
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Utiliser: /aunjail [playerid]");
			return 1;
		}
		if(PlayerInfo[playerid][pAdmin] < 1)
		{
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous n'avez pas la permission d'utiliser cette commande!");
		    return 1;
		}
		if(PlayerInfo[giveplayerid][pJailedby] == 0)
		{
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce joueur n'est pas en prison!");
		    return 1;
		}
		if (IsPlayerConnected(giveplayerid))
		{
  			if(IsPlayerConnected(giveplayerid))
			  {
  		    	PlayerInfo[giveplayerid][pJailedby] = 0;
  				GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
				GetPlayerName(playerid, sendername, sizeof(sendername));
				SetPlayerInterior(giveplayerid,0);
				TogglePlayerControllable(giveplayerid,1);
				SetPlayerPos(giveplayerid,2283.2024,2424.1245,10.8203);
				format(string, sizeof(string), "Admin/Moderateur a libéré (id: %d) de prison.",giveplayer,giveplayerid);
				SendClientMessageToAll(COLOR_ORANGE, string);
				format(string, sizeof(string), "%s (id: %d) a été libéré de la prison.", giveplayer,giveplayerid);
				SendClientMessage(playerid, COLOR_ORANGE, string);
				format(string, sizeof(string), "Vous avez été relaché de prison par l'admin/Moderateur.");
				SendClientMessage(giveplayerid, COLOR_ORANGE, string);
			}
			else {
				format(string, sizeof(string), "%d n'est pas un joueur actif.", giveplayerid);
				SendClientMessage(playerid, COLOR_BRIGHTRED, string);
			}
	   	}
		return 1;
	}
//-------------------------------Admin Freeze-----------------------------------
	if(strcmp(cmd, "/afreeze", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		giveplayerid = strval(tmp);
		GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
        PlayerInfo[playerid][pAdmin] = dini_Int(udb_encode(sendername), "level");
        PlayerInfo[giveplayerid][pAdmin] = dini_Int(udb_encode(giveplayer), "level");
		if(logged[playerid] == 0)
		{
			SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous devez être loggé pour utiliser cette commande!");
			return 1;
		}
		if(PlayerInfo[playerid][pAdmin] < 1)
		{
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous n'avez pas la permission d'employer cette commande!");
		    return 1;
		}
		if(PlayerInfo[giveplayerid][pAdmin] > 0)
		{
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous ne pouvez pas geler un camarade admin ou le président!");
		    return 1;
		}
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Utiliser: /afreeze [playerid]");
			return 1;
		}

		if (IsPlayerConnected(giveplayerid))
		{
			GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			TogglePlayerControllable(giveplayerid, 0);
			frozen[playerid] = 1;
			format(string, sizeof(string), "Admin/Moderator a paralysé %s (id: %d).",giveplayer,giveplayerid);
			SendClientMessageToAll(COLOR_ORANGE, string);
			format(string, sizeof(string), "%s (id: %d) a été paralysé.", giveplayer,giveplayerid);
			SendClientMessage(playerid, COLOR_ORANGE, string);
			format(string, sizeof(string), "Vous êtes paralysé à cause d'un admin/modo.");
			SendClientMessage(giveplayerid, COLOR_ORANGE, string);
		}
		else {
			format(string, sizeof(string), "%d n'est pas un joueur actif.", giveplayerid);
			SendClientMessage(playerid, COLOR_BRIGHTRED, string);
		}

		return 1;
	}
//------------------------------Admin UnFreeze----------------------------------
	if(strcmp(cmd, "/aunfreeze", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		giveplayerid = strval(tmp);
		GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
        PlayerInfo[playerid][pAdmin] = dini_Int(udb_encode(sendername), "level");
        PlayerInfo[giveplayerid][pAdmin] = dini_Int(udb_encode(giveplayer), "level");
		if(logged[playerid] == 0)
		{
			SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous devez être loggé pour utiliser cette commande!");
			return 1;
		}
		if(PlayerInfo[playerid][pAdmin] < 1) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous n'avez pas la permission d'employer cette commande!");
		    return 1;
		}
		if(PlayerInfo[giveplayerid][pAdmin] > 0) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous ne pouvez pas dégeler un camarade admin ou le président!");
		    return 1;
		}
		if(frozen[playerid] == 0) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce joueur n'a pas été congelé!");
		    return 1;
		}
		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Utilisé: /aunfreeze [playerid]");
			return 1;
		}

		if (IsPlayerConnected(giveplayerid)) {
			GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			TogglePlayerControllable(giveplayerid, 1);
			frozen[playerid] = 0;
			format(string, sizeof(string), "Admin/Moderator a déparalysé %s (id: %d).",giveplayer,giveplayerid);
			SendClientMessageToAll(COLOR_ORANGE, string);
			format(string, sizeof(string), "%s (id: %d) a été déparalysé.", giveplayer,giveplayerid);
			SendClientMessage(playerid, COLOR_ORANGE, string);
			format(string, sizeof(string), "Vous avez été déparalysé par un admin/Moderateur.");
			SendClientMessage(giveplayerid, COLOR_ORANGE, string);
		}
		else {
			format(string, sizeof(string), "%d n'est pas un joueur actif.", giveplayerid);
			SendClientMessage(playerid, COLOR_BRIGHTRED, string);
		}

		return 1;
	}
//----------------------------Admin Give Money----------------------------------
	if(strcmp(cmd, "/agivemoney", true) == 0) {
		tmp = strtok(cmdtext, idx);
		giveplayerid = strval(tmp);
		GetPlayerName(playerid, sendername, sizeof(sendername));
        PlayerInfo[playerid][pAdmin] = dini_Int(udb_encode(sendername), "level");
		if(logged[playerid] == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous devez être loggé pour employer cette commande!");
			return 1;
		}
		if(PlayerInfo[playerid][pAdmin] < 1) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous n'avez pas la permission d'employer cette commande!");
		    return 1;
		}
		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Utiliser: /agivemoney [playerid] [amount]");
			return 1;
		}
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Utiliser: /agivemoney [playerid] [amount]");
			return 1;
		}
 		moneys[playerid] = strval(tmp);
		if (IsPlayerConnected(giveplayerid)) {
			GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			GetPlayerMoney(playerid);
			GivePlayerMoney(giveplayerid, moneys[playerid]);
			format(string, sizeof(string), "Vous avez donné $%d to %s (id: %d).",moneys[playerid],giveplayer,giveplayerid);
			SendClientMessage(playerid, COLOR_ORANGE, string);
			format(string, sizeof(string), "Vous avez reçu $%d par un Admin/Moderateur.", moneys[playerid]);
			SendClientMessage(giveplayerid, COLOR_ORANGE, string);
		}
		else {
			format(string, sizeof(string), "%d n'est pas un joueur actif.", giveplayerid);
			SendClientMessage(playerid, COLOR_BRIGHTRED, string);
		}

		return 1;
	}
//------------------------------Admin Disarm------------------------------------
	if(strcmp(cmd, "/adisarm", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		giveplayerid = strval(tmp);
		GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
        PlayerInfo[playerid][pAdmin] = dini_Int(udb_encode(sendername), "level");
        PlayerInfo[giveplayerid][pAdmin] = dini_Int(udb_encode(giveplayer), "level");
		if(logged[playerid] == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous devez être loggé pour employer cette commande!");
			return 1;
		}
		if(PlayerInfo[playerid][pAdmin] < 1) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous n'avez pas la permission d'employer cette commande!");
		    return 1;
		}
		if(PlayerInfo[giveplayerid][pAdmin] > 0) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous ne pouvez pas désarmer un admin/modo!");
		    return 1;
		}
		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Utiliser: /adisarm [playerid]");
			return 1;
		}

		if (IsPlayerConnected(giveplayerid)) {
			GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			ResetPlayerWeapons(giveplayerid);
			format(string, sizeof(string), "Admin/Moderateur a désarmé %s (id: %d).",giveplayer,giveplayerid);
			SendClientMessageToAll(COLOR_ORANGE, string);
			format(string, sizeof(string), "Vous avez désarmé %s (id: %d).", giveplayer,giveplayerid);
			SendClientMessage(playerid, COLOR_ORANGE, string);
			format(string, sizeof(string), "Admin/Moderateur vous a désarmé.", sendername,playerid);
			SendClientMessage(giveplayerid, COLOR_ORANGE, string);
		}
		else {
			format(string, sizeof(string), "%d n'est pas un joueur actif.", giveplayerid);
			SendClientMessage(playerid, COLOR_BRIGHTRED, string);
		}

		return 1;
	}
//------------------------------Admin Announce----------------------------------
	if(strcmp(cmd, "/aannounce", true) == 0)
        {

        tmp = strtok(cmdtext, idx, strlen(cmdtext));
		GetPlayerName(playerid, sendername, sizeof(sendername));
        PlayerInfo[playerid][pAdmin] = dini_Int(udb_encode(sendername), "level");
        PlayerInfo[giveplayerid][pAdmin] = dini_Int(udb_encode(giveplayer), "level");
		if(logged[playerid] == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous devez être loggé pour utiliser cette comande!");
			return 1;
		}
		PlayerInfo[playerid][pAdmin] = dini_Int(udb_encode(sendername), "level");
		if(PlayerInfo[playerid][pAdmin] == 0) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous n'avez pas la permission d'utiliser cette commande!");
		    return 1;
		}
 		if (!strlen(tmp))
  		{
  			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Utiliser: /aannounce [message]");
    		return 1;
      	}
      	if (2 < strlen(tmp) && strlen(tmp) < 31)
   		{
  			format(string, sizeof(string), "~w~%s", tmp);
			GameTextForAll(string, 5000, 3);
			for(new i=0;i<MAX_PLAYERS;i++) {
				if(IsPlayerConnected(i)) {
		    		aMessage[i] = 1;
		    		SetTimer("announcer",5000,0);
				}
			}
		}
 		else
  		{
			if (strlen(tmp) < 2)
			{
 				format(string, sizeof(string), "- %s - est trop court!", tmp);
   				SendClientMessage(playerid, COLOR_BRIGHTRED, string);
			}
			if (strlen(tmp) == 2)
			{
            	format(string, sizeof(string), "- %s - is too short!", tmp);
           		SendClientMessage(playerid, COLOR_BRIGHTRED, string);
			}
			if (strlen(tmp) > 31)
			{
           		format(string, sizeof(string), "- %s - est trop long!", tmp);
           		SendClientMessage(playerid, COLOR_BRIGHTRED, string);
			}
			if (strlen(tmp) == 31)
			{
				format(string, sizeof(string), "- %s - est trop long!", tmp);
  				SendClientMessage(playerid, COLOR_BRIGHTRED, string);
			}
		}
        return 1;
	}
//------------------------------Admin Murder------------------------------------
	if(strcmp(cmd, "/akill", true) == 0) {
		tmp = strtok(cmdtext, idx);
		giveplayerid = strval(tmp);
		GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
        PlayerInfo[playerid][pAdmin] = dini_Int(udb_encode(sendername), "level");
        PlayerInfo[giveplayerid][pAdmin] = dini_Int(udb_encode(giveplayer), "level");
		if(logged[playerid] == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous devez être loggé pour utiliser cette comande!");
			return 1;
		}
		if(PlayerInfo[playerid][pAdmin] < 1) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous n'avez pas la permission d'utiliser cette commande!");
		    return 1;
		}
		if(PlayerInfo[giveplayerid][pAdmin] > 0) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous ne pouvez pas assassiner un camarade admin/modo!");
		    return 1;
		}
		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Utilisé: /akill [playerid]");
			return 1;
		}

		if (IsPlayerConnected(giveplayerid)) {
			GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			SetPlayerHealth(giveplayerid, -999);
			format(string, sizeof(string), "L'admin/moderateur a assassiné %s (id: %d).", giveplayer,giveplayerid);
			SendClientMessageToAll(COLOR_ORANGE, string);
			format(string, sizeof(string), "Vous avez assassiné %s (id: %d).", giveplayer,giveplayerid);
			SendClientMessage(playerid, COLOR_ORANGE, string);
			format(string, sizeof(string), "L'admin vous a assassiné.");
			SendClientMessage(giveplayerid, COLOR_ORANGE, string);
			return 1;
		}
		else {
			format(string, sizeof(string), "%d n'est pas un joueur actif.", giveplayerid);
			SendClientMessage(playerid, COLOR_BRIGHTRED, string);
			return 1;
		}
	}
//---------------------------------Buy Car--------------------------------------
	if(strcmp(cmd, "/buycar", true) == 0) {
	    new filename[256];
	    GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
    	cartemp[playerid] = dini_Int(udb_encode(playername), "carowned");
    	format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
		tmp = dini_Get(filename, "owner");
		carname = dini_Get(filename, "carname");
		if(logged[playerid] == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous devez être enregistré et loggé pour acheter un véhicule!");
			return 1;
		}
		carbuyable[playerid] = dini_Int(filename, "buybar");
  		if(carbuyable[playerid] == 1) {
    		SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce véhicule a été placé comme non achetable par l'administration!");
      		return 1;
    	}
		if(passenger[playerid] == 1) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous devez être sur le siège avant pour acheter un véhicule!");
			return 1;
		}
		if(IsPlayerInAnyVehicle(playerid) == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous devez conduire un véhicule pour en acheter un!");
			return 1;
		}
		if (strcmp(tmp,playername,false) == 0) {
				format(string, sizeof(string), "Vous possédez déjà ce %s, %s", carname, playername);
				SendClientMessage(playerid, COLOR_BRIGHTRED, string);
				return 1;
			}
		format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
		bought[playerid] = dini_Int(filename, "bought");
		if(cartemp[playerid] == 0 && bought[playerid] == 1) {
			format(string, sizeof(string), "Ce %s est possédé par %s, et n'est pas en vente!", carname, tmp);
			SendClientMessage(playerid, COLOR_BRIGHTRED, string);
			return 1;
		}
		if(cartemp[playerid] > 0) {
  			SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous pouvez seulement posséder UN véhicule à la fois ! Vous devez vendre votre véhicule d'abord!");
     		return 1;
		}
		if(logged[playerid] == 1) {
			new cash[MAX_PLAYERS];
			cash[playerid] = GetPlayerMoney(playerid);
			if(cash[playerid] >= carcost[playerid]) {
			    new stringa[256];
	   	 		format(stringa, sizeof(stringa), "-%d", carcost[playerid]);
				GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
				format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
				dini_Set(filename, "owner", playername);
				dini_Set(udb_encode(playername), "carowned", filename);
				dini_IntSet(filename, "bought", 1);
				dini_Set(udb_encode(playername), "car", "1");
				GivePlayerMoney(playerid, -carcost[playerid]);
				ignition[playerid] = 1;
				new string5[256];
				tmp[playerid] = GetPlayerVehicleID(playerid);
				format(string5, sizeof(string5), "Vous avez acheté ce %s pour $%d.", carname, carcost[playerid],carname,"%");
				SendClientMessage(playerid, COLOR_GREEN, string5);
				return 1;
			}
			if(cash[playerid] < carcost[playerid]) {
			    new string6[256];
				format(string6, sizeof(string6), "Vous n'avez pas $%d et ne pouvez pas vous permettre ce %s!", carcost[playerid], carname);
				SendClientMessage(playerid, COLOR_BRIGHTRED, string6);
				return 1;
			}
		}
		return 1;
	}
//-----------------------------------Sell Car-----------------------------------
	if(strcmp(cmd, "/sellcar", true) == 0) {
		new var1[256];
		new filename[256];
		format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
		GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
   	    var1 = dini_Get(filename, "owner");
   	    carname = dini_Get(filename, "carname");
   	    tmp[playerid] = GetPlayerVehicleID(playerid);
   	    if(logged[playerid] == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous devez être enregistré et loggé pour vendre un véhicule!");
			return 1;
		}
		carbuyable[playerid] = dini_Int(filename, "buybar");
  		if(carbuyable[playerid] == 1) {
    		SendClientMessage(playerid, COLOR_BRIGHTRED, "This vehicle has been set as non-buyable by server administration!");
      		return 1;
    	}
		if(passenger[playerid] == 1) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be in the drivers' seat of your vehicle to sell it!");
			return 1;
		}
		if(IsPlayerInAnyVehicle(playerid) == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be in a vehicle in order to sell it!");
			return 1;
		}
   	    if (strcmp(var1,playername,false) == 0) {
   	        GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
   	    	format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
			dini_Set(filename, "owner", "server");
			dini_IntSet(udb_encode(playername), "carowned", 0);
			dini_IntSet(filename, "bought", 0);
			dini_IntSet(filename, "secure", 0);
			dini_IntSet(udb_encode(playername), "car", 0);
			GivePlayerMoney(playerid, carcost[playerid]);
			RemovePlayerFromVehicle(playerid);
			SetVehicleToRespawn(tmp[playerid]);
			format(string, sizeof(string), "You just sold your %s for $%d, enjoy the walk!!", carname, carcost[playerid]);
			SendClientMessage(playerid, COLOR_BRIGHTRED, string);
			return 1;
  		}
  		else {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "What are you trying to pull here, you don't own the vehicle!!!");
			return 1;
		}
	}
//-------------------------------Admin Sell Car---------------------------------
	if(strcmp(cmd, "/asellcar", true) == 0) {
		new var1[256];
		new filename[256];
		format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
		GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
   	    var1 = dini_Get(filename, "owner");
   	    if(logged[playerid] == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous devez être enregistré et loggé pour employer cette command!");
			return 1;
		}
		if(passenger[playerid] == 1) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be in the drivers seat of this vehicle to use this command!");
			return 1;
		}
		if(IsPlayerInAnyVehicle(playerid) == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be in a vehicle in order to use this command!");
			return 1;
		}
		if (strcmp(var1,server,false) == 0) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "This vehicle has no owner as of yet and cannot be sold!");
			return 1;
		}
   	    if (PlayerInfo[playerid][pAdmin] == 2) {
   	        GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
   	    	format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
			dini_Set(filename, "owner", "server");
			dini_IntSet(filename, "bought", 0);
			dini_IntSet(filename, "secure", 0);
			if(dini_Exists(udb_encode(var1))) {
			    tempid[playerid] = IsPlayerNameOnline(var1);
			    if(tempid[playerid] >= 0 || tempid[playerid] < 100) {
			        bank[tempid[playerid]] = bank[tempid[playerid]]+carcost[playerid];
					dini_IntSet(udb_encode(var1), "car", 0);
					dini_IntSet(udb_encode(var1), "carowned", 0);
					format(string, sizeof(string), "You just sold %s's %s. The sale money ($%d) was sent to %s's online bank account", var1, carname, carcost[playerid], var1);
					SendClientMessage(playerid, COLOR_ORANGE, string);
					format(string, sizeof(string), "Admin (%s) has just sold your %s! The sale money ($%d) was sent to your online bank account!", carname, playername, carcost[playerid]);
                    SendClientMessage(playerid, COLOR_ORANGE, string);
					return 1;
				}
				else {
					bank[tempid[playerid]] = dini_Int(udb_encode(var1), "bank");
				    bank[tempid[playerid]] = bank[tempid[playerid]]+carcost[playerid];
				    dini_IntSet(udb_encode(var1), "car", 0);
					dini_IntSet(udb_encode(var1), "carowned", 0);
					dini_IntSet(udb_encode(var1), "carsold", 1);
					dini_IntSet(udb_encode(var1), "bank", bank[tempid[playerid]]);
					format(string, sizeof(string), "You just sold %s's %s. The sale money ($%d) was sent to %s's online bank account", var1, carname, carcost[playerid], var1);
					SendClientMessage(playerid, COLOR_ORANGE, string);
					return 1;
				}
			}
			if(!dini_Exists(udb_encode(var1))) {
				format(string, sizeof(string), "You just sold %s's %s. The player file was not found and cannot be altered.", var1, carname);
				SendClientMessage(playerid, COLOR_GREEN, string);
				return 1;
			}
		}
		SendClientMessage(playerid, COLOR_BRIGHTRED, "You are not a server administrator and cannot use this command!");
		return 1;

	}
//-----------------------------Admin Make Car Buyable---------------------------
	if(strcmp(cmd, "/cbuy", true) == 0) {
		new var1[256];
		new filename[256];
		format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
		GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
   	    var1 = dini_Get(filename, "owner");
   	    carname = dini_Get(filename, "carname");
   	    tmp[playerid] = GetPlayerVehicleID(playerid);
   	    carbuyable[playerid] = dini_Int(filename, "buybar");
   	    if(logged[playerid] == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous devez être enregistré et loggé pour employer cette command!");
			return 1;
		}
		if(passenger[playerid] == 1) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be in the drivers seat to use this command");
			return 1;
		}
		if(IsPlayerInAnyVehicle(playerid) == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be in a vehicle in order to use this command");
			return 1;
		}
   	    if (PlayerInfo[playerid][pAdmin] == 2) {
   	        if(carbuyable[playerid] == 1) {
   	        	format(string,sizeof(string),"You have set this %s to buyable!", carname);
   	        	SendClientMessage(playerid,COLOR_ORANGE,string);
				dini_IntSet(filename, "buybar", 0);
				return 1;
			}
			SendClientMessage(playerid, COLOR_BRIGHTRED, "This vehicle is already set to buyable!");
			return 1;
		}
		SendClientMessage(playerid, COLOR_BRIGHTRED, "You are not a server administrator and cannot use this command!");
		return 1;
	}
//---------------------------Admin Make Car UnBuyable---------------------------
	if(strcmp(cmd, "/cunbuy", true) == 0) {
		new var1[256];
		new filename[256];
		format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
		GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
   	    var1 = dini_Get(filename, "owner");
   	    carname = dini_Get(filename, "carname");
   	    carbuyable[playerid] = dini_Int(filename, "buybar");
   	    if(logged[playerid] == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous devez être enregistré et loggé pour employer cette command!");
			return 1;
		}
		if(passenger[playerid] == 1) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous devez être dans le siège du conducteur pour employer cette commande");
			return 1;
		}
		if(IsPlayerInAnyVehicle(playerid) == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous devez être dans un véhicule afin d'employer cette commande");
			return 1;
		}
		if(carbuyable[playerid] == 1) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce véhicule est déjà placé comme non achetable!");
			return 1;
		}
   	    if (PlayerInfo[playerid][pAdmin] == 2) {
   	        if (strcmp(server,var1,false) == 0) {
 				format(string,sizeof(string),"Vous avez placé ce %d comme non achetable!",carname);
 				SendClientMessage(playerid,COLOR_ORANGE,string);
   				dini_IntSet(filename, "buybar", 1);
				return 1;
			}
   	        GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
   	    	format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
   	    	var1 = dini_Get(filename, "owner");
			dini_Set(filename, "owner", "server");
			dini_IntSet(filename, "bought", 0);
			dini_IntSet(filename, "secure", 0);
			dini_IntSet(filename, "buybar", 1);
			if(dini_Exists(udb_encode(var1))) {
			    tempid[playerid] = IsPlayerNameOnline(var1);
			    if(tempid[playerid] >= 0 || tempid[playerid] < 100) {
			        bank[tempid[playerid]] = bank[tempid[playerid]]+carcost[playerid];
					dini_IntSet(udb_encode(var1), "car", 0);
					dini_IntSet(udb_encode(var1), "carowned", 0);
					format(string, sizeof(string), "Vous avez vendu ce %s à %s et l'avez placé comme non achetable. L'argent de vente ($%d) a été envoyé au compte bancaire de %s", var1, carname, carcost[playerid], var1);
					SendClientMessage(playerid, COLOR_ORANGE, string);
					format(string, sizeof(string), "L'admin a vendu votre %s et l'a placé comme non achetable ! L'argent de vente ($%d) a été envoyé à votre compte bancaire!", playername, carname, carcost[playerid]);
                    SendClientMessage(tempid[playerid], COLOR_ORANGE, string);
					return 1;
				}
				else {
					bank[tempid[playerid]] = dini_Int(udb_encode(var1), "bank");
				    bank[tempid[playerid]] = bank[tempid[playerid]]+carcost[playerid];
				    dini_IntSet(udb_encode(var1), "car", 0);
					dini_IntSet(udb_encode(var1), "carowned", 0);
					dini_IntSet(udb_encode(var1), "carsold", 1);
					dini_IntSet(udb_encode(var1), "bank", bank[tempid[playerid]]);
					format(string, sizeof(string), "Vous avez vendu ce %s à %s et l'avez placé comme non achetable. L'argent de vente ($%d) a été envoyé au compte bancaire de %s", var1, carname, carcost[playerid], var1);
					SendClientMessage(playerid, COLOR_ORANGE, string);
					return 1;
				}
			}
			if(!dini_Exists(udb_encode(var1))) {
				format(string, sizeof(string), "Vous avez vendu ce %s à %s et l'avez placé comme non achetable. Le dossier de joueur n'a pas été trouvé et ne peut pas être changé.", var1, carname);
				SendClientMessage(playerid, COLOR_GREEN, string);
				return 1;
			}
		}
		SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous n'êtes pas un administrateur et ne pouvez pas employer cette commande!");
		return 1;
	}
//-----------------------------------Lock Car-----------------------------------
	if (strcmp(cmdtext, "/lock", true)==0)
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
		    new filename[256];
			format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
			carname = dini_Get(filename, "carname");
			new State=GetPlayerState(playerid);
			if(State!=PLAYER_STATE_DRIVER)
			{
				SendClientMessage(playerid,COLOR_YELLOW,"Vous devez être dans le siège du conducteur.");
				return 1;
			}
			new i;
			for(i=0;i<MAX_PLAYERS;i++)
			{
				if(i != playerid)
				{
					SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid),i, 0, 1);
				}
			}
			format(lockmess,sizeof(lockmess),"Votre %s est maintenant fermé.",carname);
			SendClientMessage(playerid,COLOR_GREEN, lockmess);
			new Float:pX, Float:pY, Float:pZ;
			GetPlayerPos(playerid,pX,pY,pZ);
			PlayerPlaySound(playerid,1056,pX,pY,pZ);
		}
		else
		{
			SendClientMessage(playerid, COLOR_YELLOW, "Vous n'êtes pas dans un véhicule.");
		}
		return 1;
	}
//----------------------------------Unlock Car----------------------------------
	if (strcmp(cmdtext, "/unlock", true)==0)
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
		    new filename[256];
			format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
			carname = dini_Get(filename, "carname");
			new State=GetPlayerState(playerid);
			if(State!=PLAYER_STATE_DRIVER)
			{
				SendClientMessage(playerid,COLOR_YELLOW, "Vous devez être dans le siège du conducteur.");
				return 1;
			}
			new i;
			for(i=0;i<MAX_PLAYERS;i++)
			{
				SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid),i, 0, 0);
			}
			format(lockmess,sizeof(lockmess),"Votre %s est maintenant ouvert.",carname);
			SendClientMessage(playerid,COLOR_GREEN, lockmess);
			new Float:pX, Float:pY, Float:pZ;
			GetPlayerPos(playerid,pX,pY,pZ);
			PlayerPlaySound(playerid,1057,pX,pY,pZ);
		}
		else
		{
			SendClientMessage(playerid, COLOR_YELLOW, "Vous n'êtes pas dans un véhicule.");
		}
		return 1;
	}
//---------------------------Secure Car [Non Leathal]---------------------------
	if (strcmp(cmdtext, "/securekick", true)==0) {
		new filename[256];
		format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
		new val1[256];
		GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
		val1 = dini_Get(filename, "owner");
		tmpcar[playerid] = dini_Int(udb_encode(playername), "carowned");
	    if(logged[playerid] == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous devez être enregistré et loggé pour employer cette command!");
			return 1;
		}
  		if(carbuyable[playerid] == 1) {
    		SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce véhicule est non achetable et ces commandes ne fonctionneront pas!");
			return 1;
    	}
		if(tmpcar[playerid] == 0) {
            SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous devez être dans un véhicule pour employer cette commande!");
			return 1;
		}
		if(IsPlayerInAnyVehicle(playerid)) {
            if (strcmp(val1,playername,false) == 0) {
				dini_IntSet(filename, "secure", 1);
				carname = dini_Get(filename, "carname");
				format(securemess,sizeof(securemess),"Vous avez placé votre %s comme bloqué, aucun autre joueur ne pourra l'employer même lorsque vous êtes en HorsLigne.", carname);
				SendClientMessage(playerid, COLOR_GREEN, securemess);
				return 1;
			}
			else {
				SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous ne possédez pas ce véhicule et ne pouvez pas le sécuriser!");
				return 1;
			}
		}
		else {
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Vous devez être dans un véhicule pour employer cette commande!");
			return 1;
		}
	}
//------------------------Admin Secure Car [Non Leathal]------------------------
	if (strcmp(cmdtext, "/asecurekick", true)==0) {
		new filename[256];
		format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
		tmpcar[playerid] = dini_Int(udb_encode(playername), "carowned");
	    if(logged[playerid] == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous devez être enregistré et loggé pour employer cette command!");
			return 1;
		}
		if (PlayerInfo[playerid][pAdmin] > 0) {
			if(IsPlayerInAnyVehicle(playerid)) {
				dini_IntSet(filename, "asecure", 1);
				carname = dini_Get(filename, "carname");
				format(securemess,sizeof(securemess),"Vous avez sécurisé ce %s en tant que admin.", carname);
				SendClientMessage(playerid, COLOR_GREEN, securemess);
				return 1;
			}
			else {
				SendClientMessage(playerid, COLOR_LIGHTBLUE, "Vous devez être dans un véhicule pour employer cette commande!");
				return 1;
			}
		}
		else {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous n'avez pas la permission d'utiliser cette commande!");
			return 1;
		}
	}
//--------------------------Admin Secure car [Leathal]--------------------------
	if (strcmp(cmdtext, "/asecurekill", true)==0) {
		new filename[256];
		format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
		tmpcar[playerid] = dini_Int(udb_encode(playername), "carowned");
	    if(logged[playerid] == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous devez être enregistré et loggé pour employer cette command!");
			return 1;
		}
		if(IsPlayerInAnyVehicle(playerid)) {
            if (PlayerInfo[playerid][pAdmin] > 0) {
				dini_IntSet(filename, "asecure", 2);
				carname = dini_Get(filename, "carname");
				format(securemess,sizeof(securemess),"Vous avez sécurisé ce %s avec la protection mortelle en tant que admin.", carname);
				SendClientMessage(playerid, COLOR_GREEN, securemess);
				return 1;
			}
			else {
				SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous n'avez pas la permission d'utiliser cette commande!");
				return 1;
			}
		}
		else {
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Vous devez être dans un véhicule pour employer cette commande");
			return 1;
		}
	}
//---------------------------------Admin Unsecure-------------------------------
	if (strcmp(cmdtext, "/aunsecure", true)==0) {
		new filename[256];
		format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
		tmpcar[playerid] = dini_Int(udb_encode(playername), "carowned");
	    if(logged[playerid] == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous devez être enregistré et loggé pour employer cette command!");
			return 1;
		}
		if(tmpcar[playerid] == 0) {
            SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous devez d'abord posséder un véhicule avant d'employer cette commande !");
			return 1;
		}
		if(IsPlayerInAnyVehicle(playerid)) {
            if (PlayerInfo[playerid][pAdmin] > 0) {
				dini_IntSet(filename, "asecure", 0);
				carname = dini_Get(filename, "carname");
				format(securemess,sizeof(securemess),"Vous avez enlevé la sécurité de votre %s .", carname);
				SendClientMessage(playerid, COLOR_GREEN, securemess);
				return 1;
			}
			else {
				SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous n'avez pas la permission d'utiliser cette commande!");
				return 1;
			}
		}
		else {
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Vous devez être dans un véhicule pour employer cette commande");
			return 1;
		}
	}
//------------------------------------UnSecure----------------------------------
    if (strcmp(cmdtext, "/unsecure", true)==0) {
        new filename[256];
		format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
		new val1[256];
		GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
		val1 = dini_Get(filename, "owner");
		tmpcar[playerid] = dini_Int(udb_encode(playername), "carowned");
	    if(logged[playerid] == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous devez être enregistré et loggé pour employer cette commande!");
			return 1;
		}
  		if(carbuyable[playerid] == 1) {
    		SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce véhicule est non achetable et ces commandes ne fonctionneront pas!");
			return 1;
    	}
		if(tmpcar[playerid] == 0) {
            SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous devez d'abord posséder un véhicule avant d'employer cette commande!");
			return 1;
		}
		if(IsPlayerInAnyVehicle(playerid)) {
            if (strcmp(val1,playername,false) == 0) {
				dini_IntSet(filename, "secure", 0);
				carname = dini_Get(filename, "carname");
				format(securemess,sizeof(securemess),"Vous avez enlevé la sécurité de votre %s .", carname);
				SendClientMessage(playerid, COLOR_GREEN, securemess);
				return 1;
			}
			else {
			    SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous ne possédez pas ce véhicule et ne pouvez pas le sécuriser!");
				return 1;
			}
		}
		else {
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Vous devez être dans un véhicule pour employer cette commande");
			return 1;
		}
	}
//-----------------------------Secure Car [Leathal]-----------------------------
	if (strcmp(cmdtext, "/securekill", true)==0) {
		new filename[256];
		format(filename, sizeof(filename), "%d", GetPlayerVehicleID(playerid));
		new val1[256];
		GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
		val1 = dini_Get(filename, "owner");
		tmpcar[playerid] = dini_Int(udb_encode(playername), "carowned");
	    if(logged[playerid] == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous devez être enregistré et loggé pour employer cette commande!");
			return 1;
		}
  		if(carbuyable[playerid] == 1) {
    		SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce véhicule est non achetable et ces commandes ne fonctionneront pas!");
			return 1;
    	}
		if(tmpcar[playerid] == 0) {
            SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous devez d'abord posséder un véhicule avant d'employer cette commande!");
			return 1;
		}
		if(IsPlayerInAnyVehicle(playerid)) {
            if (strcmp(val1,playername,false) == 0) {
				dini_IntSet(filename, "secure", 2);
				carname = dini_Get(filename, "carname");
				format(securemess,sizeof(securemess),"Vous avez sécurisé votre %s avec la protection mortelle, aucun autre joueur ne pourra l'employer même lorsque vous êtes HorsLigne.", carname);
				SendClientMessage(playerid, COLOR_GREEN, securemess);
				return 1;
			}
			else {
				SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous ne possédez pas ce véhicule et ne pouvez pas le sécuriser!");
				return 1;
			}
		}
		else {
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Vous devez être dans un véhicule pour employer cette commande");
			return 1;
		}
	}
//------------------------------Teleport to Bank--------------------------------
	if(strcmp(cmdtext, "/telebank", true) == 0)
	{
		{
			SetPlayerInterior(playerid,6);
			{
				SetPlayerPos(playerid,-27.7789,-54.9291,1003.5469);
			}
			GameTextForPlayer(playerid,"La Banque!",2500,3);
		}
		return 1;
	}
//------------------------------Teleport to Pimp--------------------------------
	if(strcmp(cmdtext, "/pimp", true) == 0)
	{
	    if (gTeam[playerid] == TEAM_PIMP)
		{
			SetPlayerInterior(playerid,0);
			{
				SetPlayerPos(playerid,-2653.6443,1388.2767,8.0739);
			}
			GameTextForPlayer(playerid,"Pimp Spawn!",2500,3);
		}
		return 1;
	}
//-----------------------------Teleport to Worker-------------------------------
	if(strcmp(cmdtext, "/worker", true) == 0)
	{
	    if (gTeam[playerid] == TEAM_WORKER)
		{
			SetPlayerInterior(playerid,0);
			{
				SetPlayerPos(playerid,-2062.5583,237.4662,36.2890);
			}
			GameTextForPlayer(playerid,"Worker Spawn!",2500,3);
		}
		return 1;
	}
//----------------------------Teleport to Golfer--------------------------------
	if(strcmp(cmdtext, "/golfer", true) == 0)
	{
	    if (gTeam[playerid] == TEAM_GOLFER)
		{
			SetPlayerInterior(playerid,0);
			{
				SetPlayerPos(playerid,-2642.2583,-274.9985,8.3506);
			}
			GameTextForPlayer(playerid,"Golfer Spawn!",2500,3);
		}
		return 1;
	}
//-----------------------------Teleport to Triad--------------------------------
	if(strcmp(cmdtext, "/triad", true) == 0)
	{
	    if (gTeam[playerid] == TEAM_TRIAD)
		{
			SetPlayerInterior(playerid,0);
			{
				SetPlayerPos(playerid,-2188.8037,609.8431,36.2624);
			}
			GameTextForPlayer(playerid,"Triad Spawn!",2500,3);
		}
		return 1;
	}
//------------------------------Teleport to Army--------------------------------
	if(strcmp(cmdtext, "/army", true) == 0)
	{
	    if (gTeam[playerid] == TEAM_ARMY)
		{
			SetPlayerInterior(playerid,0);
			{
				SetPlayerPos(playerid,-1377.4271,466.0897,8.9393);
			}
			GameTextForPlayer(playerid,"Army Spawn!",2500,3);
		}
		return 1;
	}
//-----------------------------Teleport to Valet--------------------------------
	if(strcmp(cmdtext, "/valet", true) == 0)
	{
	    if (gTeam[playerid] == TEAM_VALET)
		{
			SetPlayerInterior(playerid,0);
			{
				SetPlayerPos(playerid,-1754.9976,958.5851,25.8386);
			}
			GameTextForPlayer(playerid,"Valet Spawn!",2500,3);
		}
		return 1;
	}
//------------------------------Teleport to Medic-------------------------------
	if(strcmp(cmdtext, "/medic", true) == 0)
	{
	    if (gTeam[playerid] == TEAM_MEDIC)
		{
			SetPlayerInterior(playerid,0);
			{
				SetPlayerPos(playerid,-2665.4282,635.6348,16.0054);
			}
			GameTextForPlayer(playerid,"Medic Spawn!",2500,3);
		}
		return 1;
	}
//------------------------------Teleport to FBI---------------------------------
	if(strcmp(cmdtext, "/fbi", true) == 0)
	{
	    if (gTeam[playerid] == TEAM_FBI)
		{
			SetPlayerInterior(playerid,0);
			{
				SetPlayerPos(playerid,-1635.0077,665.8105,8.4054);
			}
			GameTextForPlayer(playerid,"FBI Spawn!",2500,3);
		}
		return 1;
	}
//----------------------------Teleport to Chicken-------------------------------
	if(strcmp(cmdtext, "/chicken", true) == 0)
	{
	    if (gTeam[playerid] == TEAM_CHICKEN)
		{
			SetPlayerInterior(playerid,0);
			{
				SetPlayerPos(playerid,-2681.2529,266.1666,4.3359);
			}
			GameTextForPlayer(playerid,"Chicken Spawn!",2500,3);
		}
		return 1;
	}
//------------------------------Teleport to Rich--------------------------------
	if(strcmp(cmdtext, "/rich", true) == 0)
	{
	    if (gTeam[playerid] == TEAM_RICH)
		{
			SetPlayerInterior(playerid,0);
			{
				SetPlayerPos(playerid,-2664.8037,938.6110,80.7618);
			}
			GameTextForPlayer(playerid,"Rich Spawn!",2500,3);
		}
		return 1;
	}
//------------------------------Teleport to Pilot-------------------------------
	if(strcmp(cmdtext, "/pilot", true) == 0)
	{
	    if (gTeam[playerid] == TEAM_PILOT)
		{
			SetPlayerInterior(playerid,0);
			{
				SetPlayerPos(playerid,-1358.6774,-243.8737,15.6769);
			}
			GameTextForPlayer(playerid,"Pilot Spawn!",2500,3);
		}
		return 1;
	}
//------------------------------Teleport to Da Nang-------------------------------
	if(strcmp(cmdtext, "/danang", true) == 0)
	{
	    if (gTeam[playerid] == TEAM_DANANG)
		{
			SetPlayerInterior(playerid,0);
			{
				SetPlayerPos(playerid,-1430.1825,1492.3381,8.0482);
			}
			GameTextForPlayer(playerid,"Da Nang Spawn!",2500,3);
		}
		return 1;
	}
//------------------------------------Credits-----------------------------------
	if(strcmp(cmd, "/credits", true) == 0) {
		SendClientMessage(playerid, COLOR_LIGHTBLUE, "[CBK]$$$PiMp's SFTDM Reloaded Manuscrit de propriété de manuscrit et de voiture - By -=tAxI=-");
		SendClientMessage(playerid, COLOR_YELLOW, "Conception de base de système de point de contrôle - projet San Andreas - Pixels^");
		SendClientMessage(playerid, COLOR_YELLOW, "Script de système de Téléphone conçu et fait par [eLg]Beckzyboi (www.elg.uk.tt)");
		SendClientMessage(playerid, COLOR_LIGHTBLUE, "Traduit en version Française et amélioré par Metrakit");
		SendClientMessage(playerid, COLOR_LIGHTBLUE, "www.Gta-MP.fr, la référence des serveurs sa-mp.");

		return 1;
	}
//-------------------------------------Help-------------------------------------
	if(strcmp(cmd, "/help", true) == 0)
	{
		SendClientMessage(playerid, COLOR_LIGHTBLUE, "SFTDM reloaded 2.0 traduit et amélioré par Metrakit");
		SendClientMessage(playerid, COLOR_YELLOW, "Aide du Telephone: /telhelp. Aide des Business: /bizhelp.");
		SendClientMessage(playerid, COLOR_YELLOW, "Commandes pour le banque: /bankhelp.");
		SendClientMessage(playerid, COLOR_YELLOW, "Commandes pour les véhicules: /vehiclehelp.");
		SendClientMessage(playerid, COLOR_YELLOW, "Commandes pour l'admin: /adminhelp.");
		SendClientMessage(playerid, COLOR_YELLOW, "Commandes générales: /commands.");
		SendClientMessage(playerid, COLOR_YELLOW, "Commandes pour les téléportations: /telehelp.");
		SendClientMessage(playerid, COLOR_ORANGE, "Tout vos stats sont sauvés de manière permanente, y compris votre propre voiture et business!");
		SendClientMessage(playerid, COLOR_ORANGE, "Tapez /credits pour voir une liste des crédits du serveur.");
		return 1;
	}
//-------------------------------------Help-------------------------------------
	if(strcmp(cmd, "/aide", true) == 0)
	{
		SendClientMessage(playerid, COLOR_LIGHTBLUE, "SFTDM reloaded 2.0 traduit et amélioré par Metrakit");
		SendClientMessage(playerid, COLOR_YELLOW, "Aide du Telephone: /telhelp. Aide des Business: /bizhelp.");
		SendClientMessage(playerid, COLOR_YELLOW, "Commandes pour le banque: /bankhelp.");
		SendClientMessage(playerid, COLOR_YELLOW, "Commandes pour les véhicules: /vehiclehelp.");
		SendClientMessage(playerid, COLOR_YELLOW, "Commandes pour l'admin: /adminhelp.");
		SendClientMessage(playerid, COLOR_YELLOW, "Commandes générales: /commands.");
		SendClientMessage(playerid, COLOR_YELLOW, "Commandes pour les téléportations: /telehelp.");
		SendClientMessage(playerid, COLOR_ORANGE, "Tout vos stats sont sauvés de manière permanente, y compris votre propre voiture et business!");
		SendClientMessage(playerid, COLOR_ORANGE, "Tapez /credits pour voir une liste des crédits du serveur.");
		return 1;
	}
//---------------------------------Property Help--------------------------------
	if(strcmp(cmd, "/bizhelp", true) == 0)
	{
		SendClientMessage(playerid, COLOR_LIGHTBLUE, "---------- Aide du Système des Business ----------");
		SendClientMessage(playerid, COLOR_YELLOW, "Des checkpoints de Business sont situés autour de la totalité de LV (actuellement 60 business en vente avec des bénéfices) !");
    	SendClientMessage(playerid, COLOR_YELLOW, "Acheter un business (vous devez être dans un checkpoint)  - /achatbis");
		SendClientMessage(playerid, COLOR_YELLOW, "Vendre un business (vous devez être dans un checkpoint) - /vendbis");
		SendClientMessage(playerid, COLOR_YELLOW, "Collecter les bénéfices de votre business - /benefice");
		SendClientMessage(playerid, COLOR_YELLOW, "Teleportation à votre business - /gotobiz");
		return 1;
	}
//-----------------------------------Phone Help---------------------------------
	if(strcmp(cmd, "/telhelp", true) == 0) {
		SendClientMessage(playerid, COLOR_LIGHTBLUE, "---------- Aide du telephone ----------");
		SendClientMessage(playerid, COLOR_YELLOW, "Coût d'un appel : $1/seconde.");
		SendClientMessage(playerid, COLOR_YELLOW, "Pour utiliser le telephone - /appel [player id].");
		SendClientMessage(playerid, COLOR_YELLOW, "Pour repondre au telephone - /repondre.");
		SendClientMessage(playerid, COLOR_YELLOW, "Pour raccrocher le telephone - /ignore.");
		return 1;
	}
//-----------------------------------Bank Help----------------------------------
	if(strcmp(cmd, "/bankhelp", true) == 0) {
		SendClientMessage(playerid, COLOR_LIGHTBLUE, "---------- Aide de la Banque ----------");
		SendClientMessage(playerid, COLOR_YELLOW, "Teleport to Bank - /telebank");
		SendClientMessage(playerid, COLOR_YELLOW, "Vous devez être dans une région ATM (située dans les magasins de 24/7):");
		SendClientMessage(playerid, COLOR_YELLOW, "Déposer uen quantité d'argent - /deposit [amount]");
		SendClientMessage(playerid, COLOR_YELLOW, "Retirer une quantité d'argent - /withdraw [montant]");
		SendClientMessage(playerid, COLOR_YELLOW, "Balance - /balance");
		SendClientMessage(playerid, COLOR_YELLOW, "Donner de l'argent - /givecash [recipient id] [montant] - ");
		SendClientMessage(playerid, COLOR_ORANGE, "La banque ne sera pas remise à zéro quand vous mourez ou si vous vous reconnectez.");
		return 1;
	}
//---------------------------------Vehicle Help---------------------------------
    if(strcmp(cmd, "/vehiclehelp", true) == 0) {
		SendClientMessage(playerid, COLOR_LIGHTBLUE, "---------- Aide des véhicules----------");
    	SendClientMessage(playerid, COLOR_YELLOW, "Acheter/vendre un véhicule - /buycar or /sellcar");
		SendClientMessage(playerid, COLOR_YELLOW, "Afficher ou enlever le compteur on/off - /dash");
		SendClientMessage(playerid, COLOR_YELLOW, "Fermer/ouvrir votre Vehicule - /lock ou /unlock ");
		SendClientMessage(playerid, COLOR_YELLOW, "Activé/Désactivé la sécurité du véhicule - /securekick ou /unsecure - éjecte les personnes essayant d'entre dans votre véhicule.");
		SendClientMessage(playerid, COLOR_YELLOW, "Activé/Désactivé la sécurité du véhicule - /securekill ou /unsecure - tue les personnes essayant d'entre dans votre véhicule.");
		SendClientMessage(playerid, COLOR_YELLOW, "Téléporte votre véhicule à vous : /callcar ( éjecte ces occupants ).");
		return 1;
	}
//--------------------------------Commands list---------------------------------
	if (strcmp(cmdtext, "/commands", true)==0)
	{
        SendClientMessage(playerid, COLOR_LIGHTBLUE, "---------- Commandes générales ----------");
		SendClientMessage(playerid, COLOR_RED, "Pour voir les règles du serveur tapez /regles");
		SendClientMessage(playerid, COLOR_RED, "Utiliser /ident pour vous logger, /enregistrer pour vous enregistrer et /setpass pour changer votre mdp.");
        SendClientMessage(playerid, COLOR_YELLOW, "Démarrer le chrono /count [time]");
		SendClientMessage(playerid, COLOR_YELLOW, "Effacer le chat /clear");
		SendClientMessage(playerid, COLOR_YELLOW, "Chat d'équipe - /t [message]");
		SendClientMessage(playerid, COLOR_LIGHTBLUE, "Suite des commandes - /commands2");
		return 1;
	}
//--------------------------------Commands list---------------------------------
	if (strcmp(cmdtext, "/commands2", true)==0)
	{
		SendClientMessage(playerid, COLOR_LIGHTBLUE, "---------- Suite des commandes ----------");
		SendClientMessage(playerid, COLOR_YELLOW, "Pour se suicider - /kill");
		SendClientMessage(playerid, COLOR_YELLOW, "Pour dancer - /dance");
     	SendClientMessage(playerid, COLOR_YELLOW, "Démarrer le chrono /count [time]");
		SendClientMessage(playerid, COLOR_YELLOW, "Effacer le chat /clear");
		SendClientMessage(playerid, COLOR_YELLOW, "Chat d'équipe - /t [message]");
		SendClientMessage(playerid, COLOR_YELLOW, "Pour lever les mains - /handsup");

		return 1;
	}
//---------------------------------Admin Help-----------------------------------
	if(strcmp(cmd, "/adminhelp", true) == 0) {
		SendClientMessage(playerid, COLOR_LIGHTBLUE, "---------- Aide d'admin ----------");
		SendClientMessage(playerid, COLOR_ORANGE, "Pour les admins jusqu'au niveau 2:");
		SendClientMessage(playerid, COLOR_YELLOW, "Aide admin niveau 1 - /ahelp1a");
		SendClientMessage(playerid, COLOR_YELLOW, "Aide admin niveau 1 partie B - /ahelp1b");
		SendClientMessage(playerid, COLOR_YELLOW, "Aide admin niveau 2 - /ahelp2");
		return 1;
	}
//------------------------------Admin lvl 1 Help--------------------------------
	if(strcmp(cmd, "/ahelp1a", true) == 0) {
		SendClientMessage(playerid, COLOR_LIGHTBLUE, "---------- Aide d'admin (level 1 partie A) ----------");
		SendClientMessage(playerid, COLOR_YELLOW, "Utiliser le chat d'admin - /xchat [message]");
		SendClientMessage(playerid, COLOR_YELLOW, "activé/désactivé la sécurité des voitures admin - /asecurekick or /aunsecure - fait sortir les personnes du véhicule.");
		SendClientMessage(playerid, COLOR_YELLOW, "activé/désactivé la sécurité des voitures admin - /asecurekill or /aunsecure - tue els personne du véhicule .");
		SendClientMessage(playerid, COLOR_YELLOW, "Mettre en prison ou sortir un joueur de prison - /ajail [player id] or /aunjail [player id]");
		SendClientMessage(playerid, COLOR_YELLOW, "Se teleporter à un joueur - /atele [teleportee id] [destination id]");
		SendClientMessage(playerid, COLOR_YELLOW, "Effacer le chat pour totu le monde - /clearall");
		return 1;
	}
    if(strcmp(cmd, "/ahelp1b", true) == 0) {
        SendClientMessage(playerid, COLOR_LIGHTBLUE, "---------- Aide d'admin (level 1 partie B) ----------");
		SendClientMessage(playerid, COLOR_YELLOW, "Kick un joueur - /akick [player id]");
		SendClientMessage(playerid, COLOR_YELLOW, "Désarmer - /adisarm [player id]");
		SendClientMessage(playerid, COLOR_YELLOW, "tuer un joueur - /akill [player id]");
		SendClientMessage(playerid, COLOR_YELLOW, "annooncer un message - /aannounce [message]");
		SendClientMessage(playerid, COLOR_YELLOW, "donner de l'argent - /agivemoney [player id] [amount]");
		SendClientMessage(playerid, COLOR_YELLOW, "Freeze ou défreeze un joueur - /afreeze [player id] ou /aunfreeze [player id]");
		return 1;
	}
//-------------------------------Admin lvl 2 Help-------------------------------
	if(strcmp(cmd, "/ahelp2", true) == 0) {
		SendClientMessage(playerid, COLOR_LIGHTBLUE, "---------- Aide d'admin (level 2) ----------");
        SendClientMessage(playerid, COLOR_ORANGE, "Vous pouvez employer toutes les commandes (si vous êtes niveau 2):");
		SendClientMessage(playerid, COLOR_YELLOW, "Bannir un joueur - /aban [player id]");
		SendClientMessage(playerid, COLOR_YELLOW, "Placez des véhicules a vendre ou à ne pas vendre - /cbuy & /cunbuy");
		SendClientMessage(playerid, COLOR_YELLOW, "Placez des affaires à vendre et à ne pas vendre - /bbuy & /bunbuy");
		SendClientMessage(playerid, COLOR_YELLOW, "Remettez à zéro n'importe quel véhicule ou business - /asellcar & /asellbiz");
		SendClientMessage(playerid, COLOR_YELLOW, "Placez le niveau d'admin du joueur - /asetadmin [admin level] :: (0 - no admin <> 1 - moderator <> 2 - full admin)");
        SendClientMessage(playerid, COLOR_YELLOW, "Obtenez l'information détaillée du joueur - /astats [playerid]");
		return 1;
	}
//--------------------------------Teleport Help---------------------------------
	if (strcmp(cmdtext, "/tele", true)==0)
	{
		SendClientMessage(playerid,COLOR_SYSTEM,"oOo SFTDM 2.0 oOo.");
		SendClientMessage(playerid,COLOR_SYSTEM,".:Il y a deux parties pour l'aide des teleportations:.");
		SendClientMessage(playerid,COLOR_SYSTEM,"Tapez /telehelpa pour la première partie des teleportations");
		SendClientMessage(playerid,COLOR_SYSTEM,"Tapez /telehelpb pour la deuxième partie des teleportations");
		return 1;
	}
//--------------------------------Teleport Help A-------------------------------
	if (strcmp(cmdtext, "/telehelpa", true)==0)
	{
		SendClientMessage(playerid,COLOR_SYSTEM,"/sp pour sauver votre position");
		SendClientMessage(playerid,COLOR_SYSTEM,"/lp pour charger votre position");
		SendClientMessage(playerid,COLOR_SYSTEM,"/telebank pour vous teleporter à la banque");
		return 1;
	}
//--------------------------------Teleport Help B-------------------------------
	if (strcmp(cmdtext, "/telehelpb", true)==0)
	{
		SendClientMessage(playerid,COLOR_SYSTEM,"/worker - vous déplacera au spawnpoint de WORKER si votre équipe est WORKER");
		SendClientMessage(playerid,COLOR_SYSTEM,"/pimp - vous déplacera au spawnpoint de PIMP si votre équipe est PIMP");
		SendClientMessage(playerid,COLOR_SYSTEM,"/golfer - vous déplacera au spawnpoint de GOLFER si votre équipe est GOLFER ");
		SendClientMessage(playerid,COLOR_SYSTEM,"/triad - vous déplacera au spawnpoint de TRIAD si votre équipe est TRIAD ");
		SendClientMessage(playerid,COLOR_SYSTEM,"/army - vous déplacera au spawnpoint de ARMY si votre équipe est ARMY ");
		SendClientMessage(playerid,COLOR_SYSTEM,"/valet - vous déplacera au spawnpoint de VALET si votre équipe est VALET ");
		SendClientMessage(playerid,COLOR_SYSTEM,"/medic - vous déplacera au spawnpoint de MEDIC si votre équipe est MEDIC ");
		SendClientMessage(playerid,COLOR_SYSTEM,"/fbi - vous déplacera au spawnpoint de FBI si votre équipe est FBI ");
		SendClientMessage(playerid,COLOR_SYSTEM,"/chicken - vous déplacera au spawnpoint de CHICKEN si votre équipe est CHICKEN ");
		SendClientMessage(playerid,COLOR_SYSTEM,"/rich - vous déplacera au spawnpoint de RICH si votre équipe est RICH ");
		SendClientMessage(playerid,COLOR_SYSTEM,"/pilot - vous déplacera au spawnpoint de PILOT si votre équipe est PILOT ");
		SendClientMessage(playerid,COLOR_SYSTEM,"/danang - vous déplacera au spawnpoint de DANANG si votre équipe est DANANG");
		return 1;
	}
//-----------------------------------Save pos-----------------------------------
	if (strcmp(cmdtext, "/sp", true)==0)
	{
		GetPlayerPos(playerid,Pos[playerid][0],Pos[playerid][1],Pos[playerid][2]); // save x,y and z for this player.
		GetPlayerFacingAngle(playerid,Pos[playerid][3]); // save the facing angle for this player.
		SendClientMessage(playerid,RED,"Position sauvé!"); // send him a red message.
		return 1;
	}
//-----------------------------------Load pos-----------------------------------
	else if (strcmp(cmdtext, "/lp", true)==0)
	{
		SetPlayerPos(playerid,Pos[playerid][0],Pos[playerid][1],Pos[playerid][2]); // set his saved position x,y and z.
		SetPlayerFacingAngle(playerid,Pos[playerid][3]); // set his saved facing angle.
		SetCameraBehindPlayer(playerid); // set the camera..behind the player (looks better).
		SendClientMessage(playerid,RED,"Vous êtes téléporté!"); // send him a red message.
	   	return 1;
	}
//-------------------------------------Rules------------------------------------
	if (strcmp(cmdtext, "/regles", true)== 0)
	{
		SendClientMessage(playerid, 0x33AA33AA, "oOo[SFTDM 2.0]oOo");
		SendClientMessage(playerid, 0x33AA33AA, "CHEAT ET HACK INTERDIT!");
		SendClientMessage(playerid, 0x33AA33AA, "Flood et insultes interdit!");
		SendClientMessage(playerid, 0x33AA33AA, "Spwan kill et Team kill interdit!");
		return 1;
	}
//-------------------------------Admin Clear Chat-------------------------------
	if (strcmp(cmdtext, "/clearall", true)==0) {
		if (PlayerInfo[playerid][pAdmin] > 0)
		{
			SendClientMessageToAll(COLOR_SYSTEM, " ");
			SendClientMessageToAll(COLOR_SYSTEM, " ");
			SendClientMessageToAll(COLOR_SYSTEM, " ");
			SendClientMessageToAll(COLOR_SYSTEM, " ");
			SendClientMessageToAll(COLOR_SYSTEM, " ");
			SendClientMessageToAll(COLOR_SYSTEM, " ");
			SendClientMessageToAll(COLOR_SYSTEM, " ");
			SendClientMessageToAll(COLOR_SYSTEM, " ");
			SendClientMessageToAll(COLOR_SYSTEM, " ");
			SendClientMessageToAll(COLOR_SYSTEM, " ");
			SendClientMessageToAll(COLOR_SYSTEM, " ");
			SendClientMessageToAll(COLOR_SYSTEM, " ");
			SendClientMessageToAll(COLOR_SYSTEM, " ");
			SendClientMessageToAll(COLOR_SYSTEM, " ");
			SendClientMessageToAll(COLOR_SYSTEM, " ");
			SendClientMessageToAll(COLOR_SYSTEM, " ");

			return 1;
		}
	}
//-------------------------------Player Clear Chat------------------------------
	if (strcmp(cmdtext, "/clear", true)==0)
	{
		SendClientMessage(playerid, COLOR_SYSTEM, " ");
		SendClientMessage(playerid, COLOR_SYSTEM, " ");
		SendClientMessage(playerid, COLOR_SYSTEM, " ");
		SendClientMessage(playerid, COLOR_SYSTEM, " ");
		SendClientMessage(playerid, COLOR_SYSTEM, " ");
		SendClientMessage(playerid, COLOR_SYSTEM, " ");
		SendClientMessage(playerid, COLOR_SYSTEM, " ");
		SendClientMessage(playerid, COLOR_SYSTEM, " ");
		SendClientMessage(playerid, COLOR_SYSTEM, " ");
		SendClientMessage(playerid, COLOR_SYSTEM, " ");
		SendClientMessage(playerid, COLOR_SYSTEM, " ");
		SendClientMessage(playerid, COLOR_SYSTEM, " ");
		SendClientMessage(playerid, COLOR_SYSTEM, " ");
		SendClientMessage(playerid, COLOR_SYSTEM, " ");
		SendClientMessage(playerid, COLOR_SYSTEM, " ");
		SendClientMessage(playerid, COLOR_SYSTEM, " ");
		return 1;
	}
//-----------------------------------Call Car-----------------------------------
	if (strcmp(cmdtext, "/callcar", true)==0)
	{
     	new filename[256];
     	GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
     	tmpcar[playerid] = dini_Int(udb_encode(playername), "carowned");
     	format(filename, sizeof(filename), "%d", tmpcar[playerid]);
     	carname = dini_Get(filename, "carname");
     	carused[playerid] = dini_Int(filename, "used");
	    if(logged[playerid] == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous devez être enregistré et loggé pour appeler un véhicule à vous!");
			return 1;
		}
		carbuyable[playerid] = dini_Int(filename, "buybar");
  		if(carbuyable[playerid] == 1) {
    		SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce véhicule a été placé comme non achetable par l'administration!");
      		return 1;
    	}
		if(PlayerInterior[playerid] > 0) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous devez être dehors pour appeler un véhicule à vous!");
			return 1;
		}
		if(tmpcar[playerid] == 0) {
            SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous devez d'abord posséder un véhicule avant que vous puissiez employer cette commande!");
			return 1;
		}
		for(new i=0; i < MAX_PLAYERS; i++) {
			if (IsPlayerConnected(i) == 1) {
				if (IsPlayerInAnyVehicle(i) == 1) {
					if (GetPlayerVehicleID(i) == tmpcar[playerid]) {
				    	GetPlayerPos(i,g,h,l);
				    	ejected[i] = 1;
				    	tmpcar2[i] = tmpcar[playerid];
					}
				}
			}
		}
		GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
		tmpcar[playerid] = dini_Int(udb_encode(playername), "carowned");
		format(filename, sizeof(filename), "%d", tmpcar[playerid]);
		carused[playerid] = dini_Int(filename, "used");
    	if(carused[playerid] == 1) {
    		new Float:x, Float:y, Float:z, Float:a;
			GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
			GetPlayerPos(playerid,x,y,z);
			GetPlayerFacingAngle(playerid, a);
			x += (3 * floatsin(-a, degrees));
			y += (3 * floatcos(-a, degrees));
			SetVehiclePos(tmpcar[playerid],x,y,z-0.35);
			SetVehicleZAngle(tmpcar[playerid],a+90);
			format(carmess,sizeof(carmess),"Votre %s a été transporté vers vous avec succès!",carname);
			SendClientMessage(playerid, COLOR_GREEN, carmess);
			SendClientMessage(playerid, COLOR_BRIGHTRED, "-=(si votre véhicule n'est pas apparu, tapez /resetcar svp)=-");
		}
		if(carused[playerid] == 0) {
			GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
			new Float:a;
			GetVehiclePos(tmpcar[playerid],t,u,o);
			GetPlayerFacingAngle(playerid, a);
			t = dini_Int(filename, "sx");
    		u = dini_Int(filename, "sy");
			o = dini_Int(filename, "sz");
			t += (3 * floatsin(-a, degrees));
			u += (3 * floatcos(-a, degrees));
			SetPlayerPos(playerid,t,u,o+3);
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Vous avez été déplacé à votre véhicule, ceci s'est produit parce que personne ne l'a employé ");
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "puisque à la dernière initialisation du gamemode il manquait du carburant. /callcar fonctionnera");
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "correctement à moins que le serveur soit remis à zéro!");
		}
		SetTimer("eject", 100, 0);
		return 1;
	}
//---------------------------------Reset Car------------------------------------
	if (strcmp(cmdtext, "/resetcar", true)==0)
	{
		new filename[256];
     	GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
     	tmpcar[playerid] = dini_Int(udb_encode(playername), "carowned");
     	format(filename, sizeof(filename), "%d", tmpcar[playerid]);
     	carused[playerid] = dini_Int(filename, "used");
	    if(logged[playerid] == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous devez être enregistré et loggé pour appeler votre véhicule!");
			return 1;
		}
		carbuyable[playerid] = dini_Int(filename, "buybar");
  		if(carbuyable[playerid] == 1) {
    		SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce véhicule a été placé comme non achetable par l'administration!");
      		return 1;
    	}
		if(tmpcar[playerid] == 0) {
            SendClientMessage(playerid, COLOR_BRIGHTRED, "You must first own a vehicle before you can call it to you!");
			return 1;
		}
		for(new i=0; i < MAX_PLAYERS; i++) {
			if (IsPlayerConnected(i) == 1) {
				if (IsPlayerInAnyVehicle(i) == 1) {
					if (GetPlayerVehicleID(i) == tmpcar[playerid]) {
				    	SendClientMessage(i,COLOR_ORANGE,"This vehicle has been reset by its owner. Enjoy the walk loser!");
					}
				}
			}
		}
		SetVehicleToRespawn(tmpcar[playerid]);
		SetTimer("resetcar",100,0);
		reset[playerid] = 1;
		return 1;
	}

//---------------------------------DashBoard----------------------------------
	if(strcmp(cmd,"/compteur",true)==0)
	{
		if(speedo[playerid] == 1 || speedo[playerid] == 2)
		{
			speedo[playerid] = 0;
			SendClientMessage(playerid,COLOR_BRIGHTRED,"Votre compteur est maintenant désactivé!");
			return 1;
		}
		if(speedo[playerid] == 0) {
			speedo[playerid] = 1;
		    for(new d=0; d<3; d++) {
  				if(gVehicleClass[playerid] == pbike[d][0]) {
 					speedo[playerid] = 2;
       			}
			}
			SendClientMessage(playerid,COLOR_GREEN,"Votre compteur est maintenant activé!");
			return 1;
		}
		return 1;
	}
//----------------------------------Team Chat-----------------------------------
	cmd(teamchatcmd);
//---------------------------------Admin Chat-----------------------------------
	if(strcmp(cmd, "/xchat", true) == 0)
	{
		GetPlayerName(playerid, playername, sizeof(playername));
		PlayerInfo[playerid][pAdmin] = dini_Int(udb_encode(playername), "level");
		if(logged[playerid] == 0)
		{
			SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous devez être loggé pour utiliser cette commande!");
			return 1;
		}
		if(PlayerInfo[playerid][pAdmin] < 1)
		{
			SendClientMessage(playerid, COLOR_BRIGHTRED, "vous n'avez pas la permission d'utiliser cette commande!");
			return 1;
		}
		tmp = strtok(cmdtext, idx, strlen(cmdtext));
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Utilisez: /xchat [message]");
			return 1;
		}
		for (new i = 0; i <MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i))
			{
				GetPlayerName(i, playername, sizeof(playername));
				PlayerInfo[i][pAdmin] = dini_Int(udb_encode(playername), "level");
				if (PlayerInfo[i][pAdmin] > 0)
				{
					GetPlayerName(i, playername, 24);
					format(string, sizeof(string), "Admin Chat (%s): %s", playername, tmp);
					SendClientMessage(i, COLOR_ORANGE, string);
				}
			}
		}
		return 1;
	}

//----------------------------------Give Admin----------------------------------
	if(strcmp(cmd, "/agiveadmin", true) == 0) {
   	    if(logged[playerid] == 0) {
   	        SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be logged in to use this command!");
			return 1;
   	    }
   	    if(IsPlayerAdmin(playerid) == 0) {
   	        SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be logged on to the server RCON to use this command!");
   	        SendClientMessage(playerid, COLOR_BRIGHTRED, "Type /rcon login [rcon password] to login to the server rcon!");
   	        SendClientMessage(playerid, COLOR_BRIGHTRED, "After you have given yourself admin, this will no longer be neccessary.");
  			return 1;
   	    }
   	    if(IsPlayerAdmin(playerid) == 1 && logged[playerid] == 1) {
   	        GetPlayerName(playerid, playername, sizeof(playername));
   	        dini_IntSet(udb_encode(playername),"level", 2);
   	        PlayerInfo[playerid][pAdmin] = dini_Int(udb_encode(playername),"level");
   	        SendClientMessage(playerid,COLOR_ORANGE,"You are now a level 2 administrator (full admin rights) on this server!");
   	        return 1;
   	    }
   	    return 1;
   	}
//-----------------------------------GoTo Biz-----------------------------------
	if(strcmp(cmd, "/gotobiz", true) == 0) {
	    GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
	    biznum[playerid] = dini_Int(udb_encode(playername), "bizowned");
	    format(cttmp,sizeof(cttmp),"BIZ%d",biznum[playerid]);
		if(logged[playerid] == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous devez être enregistré et loggé pour employer la télépathie au checkpoint de business!");
			return 1;
		}
		bizbuyable[playerid] = dini_Int(cttmp,"buybar");
		if(bizbuyable[playerid] == 1) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "Tout les business ont été placé non achetable par l'administration!");
	   		return 1;
		}
		if(biznum[playerid] == 0) {
  			SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous ne possédez pas encore de business, vous devez en acheter un avant de ne plus pouvoir vous déplacer par télèpathie!");
     		return 1;
		}
		if(PlayerInterior[playerid] > 0) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous devez être dehors pour vous déplacer par télépathie à votre business!");
     		return 1;
		}
		if(biznum[playerid] > 0) {
		    new Float:tx,Float:ty,Float:tz;
		    format(string,sizeof(string),"BIZ%d",biznum[playerid]);
		    telemoney[playerid] = dini_Int(string,"profit");
		    if(GetPlayerMoney(playerid) >= telemoney[playerid]) {
		    	biznum[playerid] = dini_Int(udb_encode(playername), "teleid");
		    	tx = checkpoints[biznum[playerid]][0];
		    	ty = checkpoints[biznum[playerid]][1];
		    	tz = checkpoints[biznum[playerid]][2];
		    	SetPlayerPos(playerid,tx,ty,tz);
		    	GivePlayerMoney(playerid,-telemoney[playerid]);
		    	format(string,sizeof(string),"Vous avez été déplacé par télépathie à votre business ! ! Vous avez perdu 5 minutes de bénéfice ($%d), OUCH!",telemoney[playerid]);
				SendClientMessage(playerid, COLOR_GREEN, string);
				return 1;
			}
			else {
			    format(string,sizeof(string),"Vous n'avez pas assez d'argent sur vous pour employez cette commande!!! (prix = $%d)",telemoney[playerid]);
				SendClientMessage(playerid, COLOR_BRIGHTRED, string);
				return 1;
			}
		}

	}
//-----------------------------------Buy Biz------------------------------------
	if(strcmp(cmd, "/achatbis", true) == 0) {
	    GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
	    format(cttmp,sizeof(cttmp),"BIZ%d",biznum[playerid]);
	    ownername = dini_Get(cttmp,"owner");
	    playerbiz[playerid] = dini_Int(udb_encode(playername), "bizowned");
	    bizid[playerid] = dini_Int(cttmp,"idnumber");
		if(logged[playerid] == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous devez être enregistré et loggé pour acheter un business!");
			return 1;
		}
		if(propactive[playerid] == 0) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous devez être dans un checkpoint de propriété afin d'acheter un business!");
			return 1;
		}
		bizbuyable[playerid] = dini_Int(cttmp,"buybar");
		if(bizbuyable[playerid] == 1) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce business a été placé non achetable par l'administration !");
	   		return 1;
		}
		if(IsPlayerInAnyVehicle(playerid) == 1) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous devez être à pied pour acheter un business!");
			return 1;
		}
		if(strcmp(ownername,playername,false) == 0) {
				format(propmess, sizeof(propmess), "Vous possédez déjà cette propriété, %s", playername);
				SendClientMessage(playerid, COLOR_YELLOW, propmess);
				return 1;
			}
		if(playerbiz[playerid] > 0) {
  			SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous pouvez seulement posséder UN business à la fois ! Vous devez vendre votre business d'abord!");
     		return 1;
		}
		if(strcmp(ownername,server,false) == 0) {
			new cash[MAX_PLAYERS];
			cash[playerid] = GetPlayerMoney(playerid);
			if(cash[playerid] >= propcost[playerid]) {
				GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
				dini_IntSet(udb_encode(playername), "teleid", playerCheckpoint[playerid]);
				dini_Set(cttmp,"owner", playername);
				dini_IntSet(udb_encode(playername), "bizowned", bizid[playerid]);
				dini_IntSet(cttmp, "bought", 1);
				GivePlayerMoney(playerid, -propcost[playerid]);
				allowprofit[playerid] = 1;
				profit[playerid] = dini_Int(cttmp,"profit");
				format(propmess, sizeof(propmess), "Vous avez acheté ce business pour $%d. Vous pouvez le vendre en employant /vendbis. Votre business fair $%d toutes les 5 minutes.", propcost[playerid],profit[playerid]);
				SendClientMessage(playerid, COLOR_GREEN, propmess);
				SendClientMessage(playerid, COLOR_LIGHTBLUE, "Vous pouvez retourner au point de contrôle à tout moment pour rassembler vos revenus en tapant /benefice");
				SendClientMessage(playerid, COLOR_LIGHTBLUE, "Votre propriété continuera à faire des bénéfices même lorsque vous êtes HorsLigne!");
				return 1;
			}
			if(cash[playerid] < propcost[playerid]) {
				format(propmess, sizeof(propmess), "Vous n'avez pas $%d et ne pouvez pas vous permettre ce business!", propcost[playerid]);
				SendClientMessage(playerid, COLOR_BRIGHTRED, propmess);
				return 1;
			}
		}
		format(propmess, sizeof(propmess), "Ce business appartient à %s, et ne peut pas être acheté!",ownername);
		SendClientMessage(playerid, COLOR_BRIGHTRED, propmess);
		return 1;
	}
//-------------------------------------Sell Biz---------------------------------
	if(strcmp(cmd, "/vendbis", true) == 0) {
	    GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
	    format(cttmp,sizeof(cttmp),"BIZ%d",biznum[playerid]);
	    playerbiz[playerid] = dini_Int(udb_encode(playername), "bizowned");
		ownername = dini_Get(cttmp,"owner");
		if(logged[playerid] == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be registered and logged in to sell a business!");
			return 1;
		}
		if(propactive[playerid] == 0) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous devez être dans un checkpoint de propriété afin de vendre un business!");
			return 1;
		}
		bizbuyable[playerid] = dini_Int(cttmp,"buybar");
		if(bizbuyable[playerid] == 1) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce business a été placé non achetable par l'administration!");
	   		return 1;
		}
		if(IsPlayerInAnyVehicle(playerid) == 1) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous devez être à pied pour vendre un business!");
			return 1;
		}
		if (strcmp(server,ownername,false) == 0) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "Personne n'a acheté ces affaires pourtant et vous êtes interdit de les vendre!");
			return 1;
		}
		if(playerbiz[playerid] == 0) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous ne possédez encore aucun business!");
		    return 1;
		}
		if (strcmp(playername,ownername,false) == 0) {
			new cash[MAX_PLAYERS];
			cash[playerid] = GetPlayerMoney(playerid);
			GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
			dini_IntSet(udb_encode(playername), "teleid", 0);
			dini_Set(cttmp,"owner", "server");
			dini_IntSet(udb_encode(playername), "bizowned", 0);
			dini_IntSet(cttmp, "bought", 0);
			dini_IntSet(cttmp, "totalprofit", 0);
			GivePlayerMoney(playerid, propcost[playerid]);
			format(propmess, sizeof(propmess), "Vous avez vendu votre business pour $%d.", propcost[playerid]);
			SendClientMessage(playerid, COLOR_GREEN, propmess);
			return 1;
		}
		format(propmess, sizeof(propmess), "Vous ne possédez pas ce business, %s le possède et seulement lui peu le vendre!", ownername);
		SendClientMessage(playerid, COLOR_BRIGHTRED, propmess);
		return 1;
	}
//---------------------------------Admin Sell Biz-------------------------------
	if(strcmp(cmd, "/avendbis", true) == 0)
	{
	    GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
	    format(cttmp,sizeof(cttmp),"BIZ%d",biznum[playerid]);
		ownername = dini_Get(cttmp,"owner");
		if(logged[playerid] == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous devez être enregistré et loggé pour employer cette commande!");
			return 1;
		}
		if(propactive[playerid] == 0) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous devez être dans checkpoint de propriété afin d'employer cette commande!");
			return 1;
		}
		if(IsPlayerInAnyVehicle(playerid) == 1) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous devez être a pied pour utiliser cette commande!");
			return 1;
		}
		if (strcmp(server,ownername,false) == 0) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "Personne n'a encore acheté ce business!");
			return 1;
		}
		if (PlayerInfo[playerid][pAdmin] == 2) {
			dini_Set(cttmp,"owner", "server");
			dini_IntSet(cttmp, "bought", 0);
			dini_IntSet(cttmp, "totalprofit", 0);
			if(dini_Exists(udb_encode(ownername))) {
			    tempid[playerid] = IsPlayerNameOnline(ownername);
			    if(tempid[playerid] >= 0 || tempid[playerid] < 100) {
			        bank[tempid[playerid]] = bank[tempid[playerid]]+propcost[playerid];
					dini_IntSet(udb_encode(ownername), "bizowned", 0);
					dini_IntSet(udb_encode(ownername), "teleid", 0);
					format(propmess, sizeof(propmess), "Vous avez vendu le business de %s. L'argent ($%d) a été envoyé au compte bancaire de %s.", ownername, propcost[playerid], ownername);
					SendClientMessage(playerid, COLOR_ORANGE, propmess);
					format(propmess, sizeof(propmess), "L'admin a vendu votre business ! L'argent de vente ($%d) a été envoyé à votre compte bancaire!", playername, propcost[playerid]);
                    SendClientMessage(tempid[playerid], COLOR_ORANGE, propmess);
					return 1;
				}
				else {
                    bank[tempid[playerid]] = dini_Int(udb_encode(ownername), "bank");
				    bank[tempid[playerid]] = bank[tempid[playerid]]+propcost[playerid];
				    dini_IntSet(udb_encode(ownername), "bizowned", 0);
					dini_IntSet(udb_encode(ownername), "teleid", 0);
					dini_IntSet(udb_encode(ownername), "bank", bank[tempid[playerid]]);
					format(propmess, sizeof(propmess), "Vous avez vendu le business de %s. L'argent ($%d) a été envoyé au compte bancaire de %s.", ownername, propcost[playerid], ownername);
					SendClientMessage(playerid, COLOR_ORANGE, propmess);
					return 1;
				}
			}
			if(!dini_Exists(udb_encode(ownername))) {
				format(propmess, sizeof(propmess), "Vous avez vendu le business de %s. Le dossier de joueur est absent et ne pourrait pas être changé.", ownername);
				SendClientMessage(playerid, COLOR_ORANGE, propmess);
				return 1;
			}
		}
		SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous n'êtes pas un administrateur de se serveur et ne pouvez pas employer cette commande!");
		return 1;
	}
//----------------------------------Biz Buyable---------------------------------
	if(strcmp(cmd, "/bisachat", true) == 0) {
	    GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
	    format(cttmp,sizeof(cttmp),"BIZ%d",biznum[playerid]);
	    bizbuyable[playerid] = dini_Int(cttmp, "buybar");
		if(logged[playerid] == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be registered and logged in to use this command!");
			return 1;
		}
		if(propactive[playerid] == 0) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be in a business checkpoint in order to use this command!");
			return 1;
		}
		if(IsPlayerInAnyVehicle(playerid) == 1) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous devez être à pied pour employer cette commande!");
			return 1;
		}
		if (PlayerInfo[playerid][pAdmin] == 2) {
		    if (bizbuyable[playerid] == 1) {
		    	SendClientMessage(playerid, COLOR_ORANGE, "Vous avez placé ces affaires à vendre!");
		    	dini_IntSet(cttmp, "buybar", 0);
				return 1;
			}
			SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce business est déjà acheté!");
			return 1;
		}
		SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous n'êtes pas un administrateur de se serveur et ne pouvez pas employer cette commande !");
		return 1;
	}
//----------------------------------Biz UnBuyable-------------------------------
	if(strcmp(cmd, "/nonvend", true) == 0) {
	    GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
	    format(cttmp,sizeof(cttmp),"BIZ%d",biznum[playerid]);
		ownername = dini_Get(cttmp,"owner");
		bizbuyable[playerid] = dini_Int(cttmp, "buybar");
		if(logged[playerid] == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous devez être enregistré et loggé pour employer cette commande!");
			return 1;
		}
		if(propactive[playerid] == 0) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous devez être dans un point de contrôle de business afin d'employer cette commande!");
			return 1;
		}
		if(IsPlayerInAnyVehicle(playerid) == 1) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "Vosu devez être à pied pour vous servir de cette commande");
			return 1;
		}
		if(bizbuyable[playerid] == 1) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce business est déjà placé comme non achetable!");
			return 1;
		}
		if (PlayerInfo[playerid][pAdmin] == 2) {
		    if (strcmp(server,ownername,false) == 0) {
		    	SendClientMessage(playerid, COLOR_ORANGE, "Vous avez placé ce business comme non achetable!");
		    	dini_IntSet(cttmp, "buybar", 1);
				return 1;
			}
			dini_Set(cttmp,"owner", "server");
			dini_IntSet(cttmp, "bought", 0);
			dini_IntSet(cttmp, "totalprofit", 0);
			dini_IntSet(cttmp, "buybar", 1);
			if(dini_Exists(udb_encode(ownername))) {
			    tempid[playerid] = IsPlayerNameOnline(ownername);
			    if(tempid[playerid] >= 0 || tempid[playerid] < 100) {
			        bank[tempid[playerid]] = bank[tempid[playerid]]+propcost[playerid];
					dini_IntSet(udb_encode(ownername), "bizowned", 0);
					dini_IntSet(udb_encode(ownername), "teleid", 0);
					format(propmess, sizeof(propmess), "Vous avez un business vendu de %s et le placé comme non achetable. L'argent ($%d) a été envoyé au compte bancaire de %s..", ownername, propcost[playerid], ownername);
					SendClientMessage(playerid, COLOR_ORANGE, propmess);
					format(propmess, sizeof(propmess), "L'admin a juste vendu votre business et l'a placé comme non achetable ! L'argent de vente ($%d) a été envoyé à votre compte bancaire!", playername, propcost[playerid]);
                    SendClientMessage(tempid[playerid], COLOR_ORANGE, propmess);
					return 1;
				}
				else {
                    bank[tempid[playerid]] = dini_Int(udb_encode(ownername), "bank");
				    bank[tempid[playerid]] = bank[tempid[playerid]]+propcost[playerid];
				    dini_IntSet(udb_encode(ownername), "bizowned", 0);
					dini_IntSet(udb_encode(ownername), "teleid", 0);
					dini_IntSet(udb_encode(ownername), "bank", bank[tempid[playerid]]);
					format(propmess, sizeof(propmess), "Vous avez un business vendu de %s et le placé comme non achetable. L'argent ($%d) a été envoyé au compte bancaire de %s..", ownername, propcost[playerid], ownername);
					SendClientMessage(playerid, COLOR_ORANGE, propmess);
					return 1;
				}
			}
			if(!dini_Exists(udb_encode(ownername))) {
				format(propmess, sizeof(propmess), "Vous avez un business vendu de %s et l'avez placé comme non achetable. Le dossier de joueur est absent et ne pourrait pas être changé.", ownername);
				SendClientMessage(playerid, COLOR_ORANGE, propmess);
				return 1;
			}
		}
		SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous n'êtes pas un administrateur de serveur et ne pouvez pas employer cette commande!");
		return 1;
	}
//---------------------------------Get Biz Profit-------------------------------
	if(strcmp(cmd, "/benefice", true) == 0) {
	    GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
	    format(cttmp,sizeof(cttmp),"BIZ%d",biznum[playerid]);
	    ownername = dini_Get(cttmp,"owner");
	    playerbiz[playerid] = dini_Int(udb_encode(playername), "bizowned");
	    bizid[playerid] = dini_Int(cttmp,"idnumber");
		if(logged[playerid] == 0) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous devez être enregistré et loggé pour rassembler vos revenus!");
			return 1;
		}
		if(propactive[playerid] == 0) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous devez être dans un checkpoint de business afin de rassembler vos revenus!");
			return 1;
		}
		bizbuyable[playerid] = dini_Int(cttmp,"buybar");
		if(bizbuyable[playerid] == 1) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce business a été placé non achetable!");
	   		return 1;
		}
		if(IsPlayerInAnyVehicle(playerid) == 1) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous devez rassembler vos revenus à pied!");
			return 1;
		}
		if(strcmp(ownername,server,false) == 0) {
				format(propmess, sizeof(propmess), "Personne n'a encore acheté ces affaires!");
				SendClientMessage(playerid, COLOR_BRIGHTRED, propmess);
				return 1;
		}
		if(playerbiz[playerid] == 0) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous ne possédez encore aucun business!");
		    return 1;
		}
		if(strcmp(ownername,playername,false) == 0) {
			totalprofit[playerid] = dini_Int(cttmp, "totalprofit");
			if(totalprofit[playerid] == 0) {
				SendClientMessage(playerid,COLOR_BRIGHTRED,"Votre business n'a encore fait aucun revenu puisque c'est votre dernière visite. Attendez la mise à jour des revenus svp!");
				return 1;
			}
			GivePlayerMoney(playerid,totalprofit[playerid]);
			dini_IntSet(cttmp, "totalprofit", 0);
			format(propmess, sizeof(propmess), "Vous avez rassemblé $%d des revenus de votre business courant, %s ! Pas mal!", totalprofit[playerid],ownername);
			SendClientMessage(playerid, COLOR_LIGHTBLUE, propmess);
			return 1;
		}
		format(propmess, sizeof(propmess), "Ces affaires appartiennent à %s ! Cessez d'essayer de voler les revenus des autres!",ownername);
		SendClientMessage(playerid, COLOR_BRIGHTRED, propmess);
		return 1;
	}
//---------------------------------Call on Phone--------------------------------
	if(strcmp(cmd, "/appel", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Utilisez: /appel [playerid]");
			return 1;
		}
		giveplayerid = strval(tmp);
		if (logged[playerid] != 1)
		{
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous devez être loggé pour faire un appel téléphonique!");
			return 1;
		}
		if (GetPlayerMoney(playerid) < CallCost)
		{
			SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous n'avez pas assez d'argent pour faire un appel téléphonique!");
			return 1;
		}
		if (giveplayerid == playerid)
		{
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous ne pouvez pas vous appeler!");
		    return 1;
		}
		if (!(IsPlayerConnected(giveplayerid)))
		{
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "Joueur innactif!");
		    return 1;
		}
		if (Calling[playerid] > -1)
		{
			GetPlayerName(Calling[playerid], giveplayer, sizeof(giveplayer));
			format(string, sizeof(string), "Vous êtes déjà au téléphone avec %s!", giveplayer);
			SendClientMessage(playerid, COLOR_BRIGHTRED, string);
			return 1;
		}
		if (Calling[giveplayerid] > -1)
		{
			GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			format(string, sizeof(string), "%s est déjà au téléphone, essayez encore plus tard", giveplayer);
			SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
			return 1;
		}
		else
		GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
		format(string, sizeof(string), "%s vous fait sonner, tapez /repond pour répondre à l'appel ou /ignore pour l'ignorer", sendername);
		SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
		format(string, sizeof(string), "You are ringing %s", giveplayer);
		SendClientMessage(playerid, COLOR_GREEN, string);
   		Calling[playerid] = giveplayerid;
   		Calling[giveplayerid] = playerid;
		Callerid[playerid] = 1;
	    return 1;
	}
//---------------------------------Answer Phone---------------------------------
	if(strcmp(cmd, "/repond", true) == 0)
		{
		if (logged[playerid] != 1)
		{
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous devez être loggé pour répondre à un appel téléphonique!");
			return 1;
		}
		if (Calling[playerid] == -1)
		{
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "Personne ne vous appelle!");
		    return 1;
		}
		if (Answered[playerid] == 1)
		{
		    SendClientMessage(playerid, COLOR_LIGHTBLUE, "Vous êtes déjà au téléphone!");
		    return 1;
		}
		else
		GetPlayerName(Calling[playerid], giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
		format(string, sizeof(string), "%s a répondu à votre appel!", sendername);
		SendClientMessage(Calling[playerid], COLOR_GREEN, string);
		format(string, sizeof(string), "Vous avez répondu à l'appel de %s", giveplayer);
		SendClientMessage(playerid, COLOR_GREEN, string);
		Answered[playerid] = 1;
   		Answered[Calling[playerid]] = 1;
		Callerid[Calling[playerid]] = 1;
	    return 1;
	}
//---------------------------------HangUp Phone---------------------------------
	if(strcmp(cmd, "/ignore", true) == 0)
		{
		if (logged[playerid] != 1)
		{
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous devez être loggé pour utiliser le telephone!");
			return 1;
		}
		if (Calling[playerid] == -1)
		{
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "Vous n'êtes pas au téléphone!");
		    return 1;
		}
		else
		{
			GetPlayerName(Calling[playerid], giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			format(string, sizeof(string), "%s vous appelle", sendername);
			SendClientMessage(Calling[playerid], COLOR_LIGHTBLUE, string);
			format(string, sizeof(string), "Vous avez raccroché à %s", giveplayer);
			SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
			new bCalling = Calling[playerid];
   			Calling[playerid] = -1;
   			Answered[playerid] = 0;
			Callerid[playerid] = 0;
   			Calling[bCalling] = -1;
   			Answered[bCalling] = 0;
			Callerid[bCalling] = 0;
		}
		return 1;
	}
	return 0;
}
//=========================On Player Leave Checkpoint=============================
public OnPlayerLeaveCheckpoint(playerid)
{
	propactive[playerid] = 0;
	allowprofit[playerid] = 0;
	switch(getCheckpointType(playerid))
	{
	}
}
//==================================Settings====================================
public Settings()
{
	if (!dini_Exists(FILE_SETTINGS)) {
		dini_Create(FILE_SETTINGS);
		dini_Set(FILE_SETTINGS, "servername", "server");
		dini_IntSet(FILE_SETTINGS, "moneyscan", 1);
		dini_IntSet(FILE_SETTINGS, "maxmoney", 9000000);
		dini_IntSet(FILE_SETTINGS, "register", 1);
		dini_IntSet(FILE_SETTINGS, "maxusers", 2000);
		dini_IntSet(FILE_SETTINGS, "bank", 1);
		dini_IntSet(FILE_SETTINGS, "manualsaving", 1);
	}
}
//================================Save System===================================
public SaveData()
{
    new playername[MAX_PLAYER_NAME];

    for (new i=0;i<MAX_PLAYERS;i++) {
	    GetPlayerName(i, playername, MAX_PLAYER_NAME);
	    if (dini_Exists(udb_encode(playername)) && logged[i] == 1) {
			dini_IntSet(udb_encode(playername), "money", GetPlayerMoney(i));
       		dini_IntSet(udb_encode(playername), "bank", bank[i]);
       		PlayerInterior[i] = GetPlayerInterior(i);
       		if(PlayerInterior[i] == 0) {
				new Float:x, Float:y, Float:z;
				GetPlayerPos(i,x,y,z);
      			new Float:a;
 				GetPlayerFacingAngle(i,a);
 				dini_IntSet(udb_encode(playername), "a", floatround(a));
				dini_IntSet(udb_encode(playername), "x", floatround(x));
				dini_IntSet(udb_encode(playername), "y", floatround(y));
				dini_IntSet(udb_encode(playername), "z", floatround(z));
			}
		}
	}

    return 1;
}
//=============================On Enter Checkpoint==============================
public OnPlayerEnterCheckpoint(playerid)
{   
    switch(getCheckpointType(playerid))
	{
		case CP_BANK: {
			SendClientMessage(playerid, COLOR_GREEN, "Bienvenue au système de tAxI. Service bancaire ATM");
			SendClientMessage(playerid, COLOR_GREEN, "Tapez /bankhelp pour voir comment commander votre compte bancaire personnel!");
		}
		case CP_BANK_2: {
			SendClientMessage(playerid, COLOR_GREEN, "Bienvenue au système de tAxI. Service bancaire ATM");
			SendClientMessage(playerid, COLOR_GREEN, "Tapez /bankhelp pour voir comment commander votre compte bancaire personnel!");
		}
		case CP_BANK_3: {
			SendClientMessage(playerid, COLOR_GREEN, "Bienvenue au système de tAxI. Service bancaire ATM");
			SendClientMessage(playerid, COLOR_GREEN, "Tapez /bankhelp pour voir comment commander votre compte bancaire personnel!");
		}
		case BIZ1: {
			if(propactive[playerid] == 0) {
				biznum[playerid] = 1;
				format(cttmp, sizeof(cttmp), "%s","BIZ1");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce business est non achetable!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"Ce business est actuellement vide et peut être acheté pour $%d par /buybiz. Ce business gagnent $%d toutes les 5 minutes.", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Bienvenue dans votre business, %s. Tapez /getprofit pour rassembler les revenus que votre business a fait depuis vos dernières collectes.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"Ce business appartient à %s, et n'est pas en vente !", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
  		case BIZ2: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 2;
				format(cttmp, sizeof(cttmp), "%s","BIZ2");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce business est non achetable!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"Ce business est actuellement vide et peut être acheté pour $%d par /buybiz. Ce business gagnent $%d toutes les 5 minutes.", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Bienvenue dans votre business, %s. Tapez /getprofit pour rassembler les revenus que votre business a fait depuis vos dernières collectes.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"Ce business appartient à %s, et n'est pas en vente !", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ3: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 3;
				format(cttmp, sizeof(cttmp), "%s","BIZ3");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce business est non achetable!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"Ce business est actuellement vide et peut être acheté pour $%d par /buybiz. Ce business gagnent $%d toutes les 5 minutes.", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Bienvenue dans votre business, %s. Tapez /getprofit pour rassembler les revenus que votre business a fait depuis vos dernières collectes.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"Ce business appartient à %s, et n'est pas en vente !", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ4: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 4;
				format(cttmp, sizeof(cttmp), "%s","BIZ4");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce business est non achetable!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"Ce business est actuellement vide et peut être acheté pour $%d par /buybiz. Ce business gagnent $%d toutes les 5 minutes.", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Bienvenue dans votre business, %s. Tapez /getprofit pour rassembler les revenus que votre business a fait depuis vos dernières collectes.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"Ce business appartient à %s, et n'est pas en vente !", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ5: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 5;
				format(cttmp, sizeof(cttmp), "%s","BIZ5");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce business est non achetable!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"Ce business est actuellement vide et peut être acheté pour $%d par /buybiz. Ce business gagnent $%d toutes les 5 minutes.", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Bienvenue dans votre business, %s. Tapez /getprofit pour rassembler les revenus que votre business a fait depuis vos dernières collectes.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"Ce business appartient à %s, et n'est pas en vente !", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ6: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 6;
				format(cttmp, sizeof(cttmp), "%s","BIZ6");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce business est non achetable!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"Ce business est actuellement vide et peut être acheté pour $%d par /buybiz. Ce business gagnent $%d toutes les 5 minutes.", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Bienvenue dans votre business, %s. Tapez /getprofit pour rassembler les revenus que votre business a fait depuis vos dernières collectes.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"Ce business appartient à %s, et n'est pas en vente !", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ7: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 7;
				format(cttmp, sizeof(cttmp), "%s","BIZ7");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce business est non achetable!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"Ce business est actuellement vide et peut être acheté pour $%d par /buybiz. Ce business gagnent $%d toutes les 5 minutes.", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Bienvenue dans votre business, %s. Tapez /getprofit pour rassembler les revenus que votre business a fait depuis vos dernières collectes.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"Ce business appartient à %s, et n'est pas en vente !", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ8: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 8;
				format(cttmp, sizeof(cttmp), "%s","BIZ8");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce business est non achetable!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"Ce business est actuellement vide et peut être acheté pour $%d par /buybiz. Ce business gagnent $%d toutes les 5 minutes.", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Bienvenue dans votre business, %s. Tapez /getprofit pour rassembler les revenus que votre business a fait depuis vos dernières collectes.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"Ce business appartient à %s, et n'est pas en vente !", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ9: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 9;
				format(cttmp, sizeof(cttmp), "%s","BIZ9");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce business est non achetable!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"Ce business est actuellement vide et peut être acheté pour $%d par /buybiz. Ce business gagnent $%d toutes les 5 minutes.", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Bienvenue dans votre business, %s. Tapez /getprofit pour rassembler les revenus que votre business a fait depuis vos dernières collectes.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"Ce business appartient à %s, et n'est pas en vente !", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ10: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 10;
				format(cttmp, sizeof(cttmp), "%s","BIZ10");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce business est non achetable!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"Ce business est actuellement vide et peut être acheté pour $%d par /buybiz. Ce business gagnent $%d toutes les 5 minutes.", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Bienvenue dans votre business, %s. Tapez /getprofit pour rassembler les revenus que votre business a fait depuis vos dernières collectes.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"Ce business appartient à %s, et n'est pas en vente !", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ11: {
			if(propactive[playerid] == 0) {
				biznum[playerid] = 11;
				format(cttmp, sizeof(cttmp), "%s","BIZ11");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce business est non achetable!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"Ce business est actuellement vide et peut être acheté pour $%d par /buybiz. Ce business gagnent $%d toutes les 5 minutes.", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Bienvenue dans votre business, %s. Tapez /getprofit pour rassembler les revenus que votre business a fait depuis vos dernières collectes.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"Ce business appartient à %s, et n'est pas en vente !", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
  		case BIZ12: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 12;
				format(cttmp, sizeof(cttmp), "%s","BIZ12");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce business est non achetable!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"Ce business est actuellement vide et peut être acheté pour $%d par /buybiz. Ce business gagnent $%d toutes les 5 minutes.", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Bienvenue dans votre business, %s. Tapez /getprofit pour rassembler les revenus que votre business a fait depuis vos dernières collectes.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"Ce business appartient à %s, et n'est pas en vente !", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ13: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 13;
				format(cttmp, sizeof(cttmp), "%s","BIZ13");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce business est non achetable!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"Ce business est actuellement vide et peut être acheté pour $%d par /buybiz. Ce business gagnent $%d toutes les 5 minutes.", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Bienvenue dans votre business, %s. Tapez /getprofit pour rassembler les revenus que votre business a fait depuis vos dernières collectes.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"Ce business appartient à %s, et n'est pas en vente !", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ14: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 14;
				format(cttmp, sizeof(cttmp), "%s","BIZ14");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce business est non achetable!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"Ce business est actuellement vide et peut être acheté pour $%d par /buybiz. Ce business gagnent $%d toutes les 5 minutes.", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Bienvenue dans votre business, %s. Tapez /getprofit pour rassembler les revenus que votre business a fait depuis vos dernières collectes.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"Ce business appartient à %s, et n'est pas en vente !", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ15: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 15;
				format(cttmp, sizeof(cttmp), "%s","BIZ15");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce business est non achetable!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"Ce business est actuellement vide et peut être acheté pour $%d par /buybiz. Ce business gagnent $%d toutes les 5 minutes.", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Bienvenue dans votre business, %s. Tapez /getprofit pour rassembler les revenus que votre business a fait depuis vos dernières collectes.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"Ce business appartient à %s, et n'est pas en vente !", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ16: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 16;
				format(cttmp, sizeof(cttmp), "%s","BIZ16");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce business est non achetable!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"Ce business est actuellement vide et peut être acheté pour $%d par /buybiz. Ce business gagnent $%d toutes les 5 minutes.", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Bienvenue dans votre business, %s. Tapez /getprofit pour rassembler les revenus que votre business a fait depuis vos dernières collectes.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"Ce business appartient à %s, et n'est pas en vente !", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ17: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 17;
				format(cttmp, sizeof(cttmp), "%s","BIZ17");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce business est non achetable!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"Ce business est actuellement vide et peut être acheté pour $%d par /buybiz. Ce business gagnent $%d toutes les 5 minutes.", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Bienvenue dans votre business, %s. Tapez /getprofit pour rassembler les revenus que votre business a fait depuis vos dernières collectes.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"Ce business appartient à %s, et n'est pas en vente !", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ18: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 18;
				format(cttmp, sizeof(cttmp), "%s","BIZ18");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce business est non achetable!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"Ce business est actuellement vide et peut être acheté pour $%d par /buybiz. Ce business gagnent $%d toutes les 5 minutes.", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Bienvenue dans votre business, %s. Tapez /getprofit pour rassembler les revenus que votre business a fait depuis vos dernières collectes.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"Ce business appartient à %s, et n'est pas en vente !", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ19: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 19;
				format(cttmp, sizeof(cttmp), "%s","BIZ19");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce business est non achetable!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"Ce business est actuellement vide et peut être acheté pour $%d par /buybiz. Ce business gagnent $%d toutes les 5 minutes.", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Bienvenue dans votre business, %s. Tapez /getprofit pour rassembler les revenus que votre business a fait depuis vos dernières collectes.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"Ce business appartient à %s, et n'est pas en vente !", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ20: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 20;
				format(cttmp, sizeof(cttmp), "%s","BIZ20");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce business est non achetable!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"Ce business est actuellement vide et peut être acheté pour $%d par /buybiz. Ce business gagnent $%d toutes les 5 minutes.", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Bienvenue dans votre business, %s. Tapez /getprofit pour rassembler les revenus que votre business a fait depuis vos dernières collectes.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"Ce business appartient à %s, et n'est pas en vente !", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}case BIZ21: {
			if(propactive[playerid] == 0) {
				biznum[playerid] = 21;
				format(cttmp, sizeof(cttmp), "%s","BIZ21");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce business est non achetable!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"Ce business est actuellement vide et peut être acheté pour $%d par /buybiz. Ce business gagnent $%d toutes les 5 minutes.", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Bienvenue dans votre business, %s. Tapez /getprofit pour rassembler les revenus que votre business a fait depuis vos dernières collectes.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"Ce business appartient à %s, et n'est pas en vente !", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
  		case BIZ22: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 22;
				format(cttmp, sizeof(cttmp), "%s","BIZ22");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce business est non achetable!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"Ce business est actuellement vide et peut être acheté pour $%d par /buybiz. Ce business gagnent $%d toutes les 5 minutes.", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Bienvenue dans votre business, %s. Tapez /getprofit pour rassembler les revenus que votre business a fait depuis vos dernières collectes.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"Ce business appartient à %s, et n'est pas en vente !", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ23: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 23;
				format(cttmp, sizeof(cttmp), "%s","BIZ23");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce business est non achetable!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"Ce business est actuellement vide et peut être acheté pour $%d par /buybiz. Ce business gagnent $%d toutes les 5 minutes.", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Bienvenue dans votre business, %s. Tapez /getprofit pour rassembler les revenus que votre business a fait depuis vos dernières collectes.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"Ce business appartient à %s, et n'est pas en vente !", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ24: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 24;
				format(cttmp, sizeof(cttmp), "%s","BIZ24");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce business est non achetable!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"Ce business est actuellement vide et peut être acheté pour $%d par /buybiz. Ce business gagnent $%d toutes les 5 minutes.", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Bienvenue dans votre business, %s. Tapez /getprofit pour rassembler les revenus que votre business a fait depuis vos dernières collectes.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"Ce business appartient à %s, et n'est pas en vente !", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ25: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 25;
				format(cttmp, sizeof(cttmp), "%s","BIZ25");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce business est non achetable!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"Ce business est actuellement vide et peut être acheté pour $%d par /buybiz. Ce business gagnent $%d toutes les 5 minutes.", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Bienvenue dans votre business, %s. Tapez /getprofit pour rassembler les revenus que votre business a fait depuis vos dernières collectes.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"Ce business appartient à %s, et n'est pas en vente !", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ26: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 26;
				format(cttmp, sizeof(cttmp), "%s","BIZ26");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce business est non achetable!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"Ce business est actuellement vide et peut être acheté pour $%d par /buybiz. Ce business gagnent $%d toutes les 5 minutes.", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Bienvenue dans votre business, %s. Tapez /getprofit pour rassembler les revenus que votre business a fait depuis vos dernières collectes.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"Ce business appartient à %s, et n'est pas en vente !", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ27: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 27;
				format(cttmp, sizeof(cttmp), "%s","BIZ27");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce business est non achetable!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"Ce business est actuellement vide et peut être acheté pour $%d par /buybiz. Ce business gagnent $%d toutes les 5 minutes.", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Bienvenue dans votre business, %s. Tapez /getprofit pour rassembler les revenus que votre business a fait depuis vos dernières collectes.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"Ce business appartient à %s, et n'est pas en vente !", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ28: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 28;
				format(cttmp, sizeof(cttmp), "%s","BIZ28");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce business est non achetable!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"Ce business est actuellement vide et peut être acheté pour $%d par /buybiz. Ce business gagnent $%d toutes les 5 minutes.", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Bienvenue dans votre business, %s. Tapez /getprofit pour rassembler les revenus que votre business a fait depuis vos dernières collectes.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"Ce business appartient à %s, et n'est pas en vente !", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ29: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 29;
				format(cttmp, sizeof(cttmp), "%s","BIZ29");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce business est non achetable!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"Ce business est actuellement vide et peut être acheté pour $%d par /buybiz. Ce business gagnent $%d toutes les 5 minutes.", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Bienvenue dans votre business, %s. Tapez /getprofit pour rassembler les revenus que votre business a fait depuis vos dernières collectes.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"Ce business appartient à %s, et n'est pas en vente !", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ30: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 30;
				format(cttmp, sizeof(cttmp), "%s","BIZ30");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce business est non achetable!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"Ce business est actuellement vide et peut être acheté pour $%d par /buybiz. Ce business gagnent $%d toutes les 5 minutes.", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Bienvenue dans votre business, %s. Tapez /getprofit pour rassembler les revenus que votre business a fait depuis vos dernières collectes.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"Ce business appartient à %s, et n'est pas en vente !", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}case BIZ31: {
			if(propactive[playerid] == 0) {
				biznum[playerid] = 31;
				format(cttmp, sizeof(cttmp), "%s","BIZ31");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce business est non achetable!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"Ce business est actuellement vide et peut être acheté pour $%d par /buybiz. Ce business gagnent $%d toutes les 5 minutes.", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Bienvenue dans votre business, %s. Tapez /getprofit pour rassembler les revenus que votre business a fait depuis vos dernières collectes.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"Ce business appartient à %s, et n'est pas en vente !", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
  		case BIZ32: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 32;
				format(cttmp, sizeof(cttmp), "%s","BIZ32");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce business est non achetable!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"Ce business est actuellement vide et peut être acheté pour $%d par /buybiz. Ce business gagnent $%d toutes les 5 minutes.", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Bienvenue dans votre business, %s. Tapez /getprofit pour rassembler les revenus que votre business a fait depuis vos dernières collectes.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"Ce business appartient à %s, et n'est pas en vente !", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ33: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 33;
				format(cttmp, sizeof(cttmp), "%s","BIZ33");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce business est non achetable!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"Ce business est actuellement vide et peut être acheté pour $%d par /buybiz. Ce business gagnent $%d toutes les 5 minutes.", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Bienvenue dans votre business, %s. Tapez /getprofit pour rassembler les revenus que votre business a fait depuis vos dernières collectes.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"Ce business appartient à %s, et n'est pas en vente !", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ34: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 34;
				format(cttmp, sizeof(cttmp), "%s","BIZ34");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce business est non achetable!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"Ce business est actuellement vide et peut être acheté pour $%d par /buybiz. Ce business gagnent $%d toutes les 5 minutes.", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Bienvenue dans votre business, %s. Tapez /getprofit pour rassembler les revenus que votre business a fait depuis vos dernières collectes.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"Ce business appartient à %s, et n'est pas en vente !", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ35: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 35;
				format(cttmp, sizeof(cttmp), "%s","BIZ35");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce business est non achetable!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"Ce business est actuellement vide et peut être acheté pour $%d par /buybiz. Ce business gagnent $%d toutes les 5 minutes.", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Bienvenue dans votre business, %s. Tapez /getprofit pour rassembler les revenus que votre business a fait depuis vos dernières collectes.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"Ce business appartient à %s, et n'est pas en vente !", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ36: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 36;
				format(cttmp, sizeof(cttmp), "%s","BIZ36");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce business est non achetable!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"Ce business est actuellement vide et peut être acheté pour $%d par /buybiz. Ce business gagnent $%d toutes les 5 minutes.", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Bienvenue dans votre business, %s. Tapez /getprofit pour rassembler les revenus que votre business a fait depuis vos dernières collectes.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"Ce business appartient à %s, et n'est pas en vente !", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ37: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 37;
				format(cttmp, sizeof(cttmp), "%s","BIZ37");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce business est non achetable!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"Ce business est actuellement vide et peut être acheté pour $%d par /buybiz. Ce business gagnent $%d toutes les 5 minutes.", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Bienvenue dans votre business, %s. Tapez /getprofit pour rassembler les revenus que votre business a fait depuis vos dernières collectes.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"Ce business appartient à %s, et n'est pas en vente !", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ38: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 38;
				format(cttmp, sizeof(cttmp), "%s","BIZ38");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce business est non achetable!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"Ce business est actuellement vide et peut être acheté pour $%d par /buybiz. Ce business gagnent $%d toutes les 5 minutes.", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Bienvenue dans votre business, %s. Tapez /getprofit pour rassembler les revenus que votre business a fait depuis vos dernières collectes.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"Ce business appartient à %s, et n'est pas en vente !", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ39: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 39;
				format(cttmp, sizeof(cttmp), "%s","BIZ39");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce business est non achetable!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"Ce business est actuellement vide et peut être acheté pour $%d par /buybiz. Ce business gagnent $%d toutes les 5 minutes.", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Bienvenue dans votre business, %s. Tapez /getprofit pour rassembler les revenus que votre business a fait depuis vos dernières collectes.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"Ce business appartient à %s, et n'est pas en vente !", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ40: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 40;
				format(cttmp, sizeof(cttmp), "%s","BIZ40");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce business est non achetable!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"Ce business est actuellement vide et peut être acheté pour $%d par /buybiz. Ce business gagnent $%d toutes les 5 minutes.", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Bienvenue dans votre business, %s. Tapez /getprofit pour rassembler les revenus que votre business a fait depuis vos dernières collectes.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"Ce business appartient à %s, et n'est pas en vente !", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}case BIZ41: {
			if(propactive[playerid] == 0) {
				biznum[playerid] = 41;
				format(cttmp, sizeof(cttmp), "%s","BIZ41");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce business est non achetable!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"Ce business est actuellement vide et peut être acheté pour $%d par /buybiz. Ce business gagnent $%d toutes les 5 minutes.", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Bienvenue dans votre business, %s. Tapez /getprofit pour rassembler les revenus que votre business a fait depuis vos dernières collectes.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"Ce business appartient à %s, et n'est pas en vente !", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
  		case BIZ42: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 42;
				format(cttmp, sizeof(cttmp), "%s","BIZ42");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce business est non achetable!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"Ce business est actuellement vide et peut être acheté pour $%d par /buybiz. Ce business gagnent $%d toutes les 5 minutes.", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Bienvenue dans votre business, %s. Tapez /getprofit pour rassembler les revenus que votre business a fait depuis vos dernières collectes.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"Ce business appartient à %s, et n'est pas en vente !", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ43: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 43;
				format(cttmp, sizeof(cttmp), "%s","BIZ43");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce business est non achetable!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"Ce business est actuellement vide et peut être acheté pour $%d par /buybiz. Ce business gagnent $%d toutes les 5 minutes.", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Bienvenue dans votre business, %s. Tapez /getprofit pour rassembler les revenus que votre business a fait depuis vos dernières collectes.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"Ce business appartient à %s, et n'est pas en vente !", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ44: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 44;
				format(cttmp, sizeof(cttmp), "%s","BIZ44");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce business est non achetable!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"Ce business est actuellement vide et peut être acheté pour $%d par /buybiz. Ce business gagnent $%d toutes les 5 minutes.", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Bienvenue dans votre business, %s. Tapez /getprofit pour rassembler les revenus que votre business a fait depuis vos dernières collectes.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"Ce business appartient à %s, et n'est pas en vente !", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ45: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 45;
				format(cttmp, sizeof(cttmp), "%s","BIZ45");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce business est non achetable!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"Ce business est actuellement vide et peut être acheté pour $%d par /buybiz. Ce business gagnent $%d toutes les 5 minutes.", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Bienvenue dans votre business, %s. Tapez /getprofit pour rassembler les revenus que votre business a fait depuis vos dernières collectes.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"Ce business appartient à %s, et n'est pas en vente !", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ46: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 46;
				format(cttmp, sizeof(cttmp), "%s","BIZ46");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce business est non achetable!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"Ce business est actuellement vide et peut être acheté pour $%d par /buybiz. Ce business gagnent $%d toutes les 5 minutes.", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Bienvenue dans votre business, %s. Tapez /getprofit pour rassembler les revenus que votre business a fait depuis vos dernières collectes.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"Ce business appartient à %s, et n'est pas en vente !", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ47: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 47;
				format(cttmp, sizeof(cttmp), "%s","BIZ47");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce business est non achetable!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"Ce business est actuellement vide et peut être acheté pour $%d par /buybiz. Ce business gagnent $%d toutes les 5 minutes.", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Bienvenue dans votre business, %s. Tapez /getprofit pour rassembler les revenus que votre business a fait depuis vos dernières collectes.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"Ce business appartient à %s, et n'est pas en vente !", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ48: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 48;
				format(cttmp, sizeof(cttmp), "%s","BIZ48");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce business est non achetable!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"Ce business est actuellement vide et peut être acheté pour $%d par /buybiz. Ce business gagnent $%d toutes les 5 minutes.", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Bienvenue dans votre business, %s. Tapez /getprofit pour rassembler les revenus que votre business a fait depuis vos dernières collectes.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"Ce business appartient à %s, et n'est pas en vente !", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ49: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 49;
				format(cttmp, sizeof(cttmp), "%s","BIZ49");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce business est non achetable!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"Ce business est actuellement vide et peut être acheté pour $%d par /buybiz. Ce business gagnent $%d toutes les 5 minutes.", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Bienvenue dans votre business, %s. Tapez /getprofit pour rassembler les revenus que votre business a fait depuis vos dernières collectes.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"Ce business appartient à %s, et n'est pas en vente !", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ50: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 50;
				format(cttmp, sizeof(cttmp), "%s","BIZ50");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce business est non achetable!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"Ce business est actuellement vide et peut être acheté pour $%d par /buybiz. Ce business gagnent $%d toutes les 5 minutes.", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Bienvenue dans votre business, %s. Tapez /getprofit pour rassembler les revenus que votre business a fait depuis vos dernières collectes.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"Ce business appartient à %s, et n'est pas en vente !", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}case BIZ51: {
			if(propactive[playerid] == 0) {
				biznum[playerid] = 51;
				format(cttmp, sizeof(cttmp), "%s","BIZ51");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce business est non achetable!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"Ce business est actuellement vide et peut être acheté pour $%d par /buybiz. Ce business gagnent $%d toutes les 5 minutes.", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Bienvenue dans votre business, %s. Tapez /getprofit pour rassembler les revenus que votre business a fait depuis vos dernières collectes.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"Ce business appartient à %s, et n'est pas en vente !", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
  		case BIZ52: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 52;
				format(cttmp, sizeof(cttmp), "%s","BIZ52");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce business est non achetable!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"Ce business est actuellement vide et peut être acheté pour $%d par /buybiz. Ce business gagnent $%d toutes les 5 minutes.", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Bienvenue dans votre business, %s. Tapez /getprofit pour rassembler les revenus que votre business a fait depuis vos dernières collectes.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"Ce business appartient à %s, et n'est pas en vente !", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ53: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 53;
				format(cttmp, sizeof(cttmp), "%s","BIZ53");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce business est non achetable!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"Ce business est actuellement vide et peut être acheté pour $%d par /buybiz. Ce business gagnent $%d toutes les 5 minutes.", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Bienvenue dans votre business, %s. Tapez /getprofit pour rassembler les revenus que votre business a fait depuis vos dernières collectes.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"Ce business appartient à %s, et n'est pas en vente !", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ54: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 54;
				format(cttmp, sizeof(cttmp), "%s","BIZ54");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce business est non achetable!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"Ce business est actuellement vide et peut être acheté pour $%d par /buybiz. Ce business gagnent $%d toutes les 5 minutes.", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Bienvenue dans votre business, %s. Tapez /getprofit pour rassembler les revenus que votre business a fait depuis vos dernières collectes.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"Ce business appartient à %s, et n'est pas en vente !", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ55: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 55;
				format(cttmp, sizeof(cttmp), "%s","BIZ55");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce business est non achetable!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"Ce business est actuellement vide et peut être acheté pour $%d par /buybiz. Ce business gagnent $%d toutes les 5 minutes.", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Bienvenue dans votre business, %s. Tapez /getprofit pour rassembler les revenus que votre business a fait depuis vos dernières collectes.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"Ce business appartient à %s, et n'est pas en vente !", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ56: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 56;
				format(cttmp, sizeof(cttmp), "%s","BIZ56");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce business est non achetable!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"Ce business est actuellement vide et peut être acheté pour $%d par /buybiz. Ce business gagnent $%d toutes les 5 minutes.", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Bienvenue dans votre business, %s. Tapez /getprofit pour rassembler les revenus que votre business a fait depuis vos dernières collectes.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"Ce business appartient à %s, et n'est pas en vente !", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ57: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 57;
				format(cttmp, sizeof(cttmp), "%s","BIZ57");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce business est non achetable!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"Ce business est actuellement vide et peut être acheté pour $%d par /buybiz. Ce business gagnent $%d toutes les 5 minutes.", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Bienvenue dans votre business, %s. Tapez /getprofit pour rassembler les revenus que votre business a fait depuis vos dernières collectes.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"Ce business appartient à %s, et n'est pas en vente !", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ58:
		{
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 58;
				format(cttmp, sizeof(cttmp), "%s","BIZ58");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce business est non achetable!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"Ce business est actuellement vide et peut être acheté pour $%d par /buybiz. Ce business gagnent $%d toutes les 5 minutes.", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Bienvenue dans votre business, %s. Tapez /getprofit pour rassembler les revenus que votre business a fait depuis vos dernières collectes.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"Ce business appartient à %s, et n'est pas en vente !", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ59: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 59;
				format(cttmp, sizeof(cttmp), "%s","BIZ59");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce business est non achetable!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"Ce business est actuellement vide et peut être acheté pour $%d par /buybiz. Ce business gagnent $%d toutes les 5 minutes.", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Bienvenue dans votre business, %s. Tapez /getprofit pour rassembler les revenus que votre business a fait depuis vos dernières collectes.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"Ce business appartient à %s, et n'est pas en vente !", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
		case BIZ60: {
		    if(propactive[playerid] == 0) {
				biznum[playerid] = 60;
				format(cttmp, sizeof(cttmp), "%s","BIZ60");
				ownername = dini_Get(cttmp,"owner");
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME);
				propcost[playerid] = dini_Int(cttmp,"propcost");
        		propowned[playerid] = dini_Int(cttmp,"bought");
        		profit[playerid] = dini_Int(cttmp,"profit");
        		propactive[playerid] = 1;
	  			if(strcmp(ownername,server,false) == 0)
	   			{
	   			    bizbuyable[playerid] = dini_Int(cttmp,"buybar");
	   			    if(bizbuyable[playerid] == 1) {
	   			    	SendClientMessage(playerid, COLOR_BRIGHTRED, "Ce business est non achetable!");
	   			    	return 1;
	   			    }
	   	    		format(propmess,sizeof(propmess),"Ce business est actuellement vide et peut être acheté pour $%d par /buybiz. Ce business gagnent $%d toutes les 5 minutes", propcost[playerid],profit[playerid]);
		 			buyable[playerid] = 1;
		 			allowprofit[playerid] = 0;
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) {
	   				format(propmess,sizeof(propmess),"Bienvenue dans votre business, %s. Tapez /getprofit pour rassembler les revenus que votre business a fait depuis vos dernières collectes.", ownername);
   		       		buyable[playerid] = 0;
   		       		allowprofit[playerid] = 1;
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else {
 					format(propmess,sizeof(propmess),"Ce business appartient à %s, et n'est pas en vente !", ownername);
               		buyable[playerid] = 0;
               		allowprofit[playerid] = 0;
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}
			}
		}
 }
	return 0;
}
//===============================On Enter Vehicle===============================
public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	speedo[playerid] = 1;
    for(new d=0; d<3; d++) {
		if(gVehicleClass[playerid] == pbike[d][0]) {
			speedo[playerid] = 2;
		}
	}
	new filename[256];
	format(filename, sizeof(filename), "%d", vehicleid);
	carname = dini_Get(filename, "carname");
	new val1[256];
	new playername[MAX_PLAYER_NAME];
	dini_IntSet(filename, "used", 1);
	GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
	val1 = dini_Get(filename, "owner");
 	secure[playerid] = dini_Int(filename, "secure");
	new tmp[256];
	tmp[playerid] = ispassenger;
	passenger[playerid] = ispassenger;
	currentvehicle[playerid] = GetPlayerVehicleID(playerid);
	if(tmp[playerid] == 0)
	{
		format(filename, sizeof(filename), "%d", vehicleid);
		GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
		new tmp1[256];
		tmp1 = dini_Get(filename, "owner");
        carbuyable[playerid] = dini_Int(filename, "buybar");
   	    if (strcmp(tmp1,playername,false) == 0)
		{
			new string[256];
			carcost[playerid] = dini_Int(filename, "carcost");
			format(string, sizeof(string), "Bienvenue dans votre %s %s, conduisez soigneusement svp!", carname, tmp1);
			SendClientMessage(playerid, COLOR_GREEN, string);
			ignition[playerid] = 1;
			return 1;
		}
		if (strcmp(tmp1,server,false) == 0 && logged[playerid] == 1) {
			if(carbuyable[playerid] == 1)
			{
               	new string[256];
				format(string,sizeof(string),"Ce %s est non achetable!",carname);
				SendClientMessage(playerid, COLOR_BRIGHTRED, string);
				return 1;
			}
			new string[256];
			carcost[playerid] = dini_Int(filename, "carcost");
			format(string, sizeof(string), "Ce %s est en vente et coûte $%d, tapez /buycar pour acheter ce véhicule.",carname, carcost[playerid]);
 			SendClientMessage(playerid, COLOR_YELLOW, string);
			return 1;
		}
		if (strcmp(tmp1,server,false) == 0 && logged[playerid] == 0)
		{
		    if(carbuyable[playerid] == 1)
			{
				new string[256];
				format(string,sizeof(string),"Ce %s est non achetable!",carname);
				SendClientMessage(playerid, COLOR_BRIGHTRED, string);
				return 1;
			}
			new string[256];
			carcost[playerid] = dini_Int(filename, "carcost");
			format(string, sizeof(string), "Ce %s est en vente et coûte $%d, mais vous ne pouvez pas l'acheter, loggez-vous : /ident.", carname, carcost[playerid]);
			SendClientMessage(playerid, COLOR_BRIGHTRED, string);
			return 1;
		}
		else
		{
			new string[256];
			carcost[playerid] = dini_Int(filename, "carcost");
			format(string, sizeof(string), "Ce %s appartient à %s, et ne peut pas être acheté.", carname, tmp1);
			SendClientMessage(playerid, COLOR_BRIGHTRED, string);
			return 1;
		}
    }
	return 1;
}
//==============================Checkpoint Update===============================
public checkpointUpdate()
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i)) {
	        for(new j=0; j < MAX_POINTS; j++) {
	            if(isPlayerInArea(i, checkCoords[j])) {
						if(playerCheckpoint[i]!= j) {
	                    DisablePlayerCheckpoint(i);
						SetPlayerCheckpoint(i, checkpoints[j][0],checkpoints[j][1],checkpoints[j][2],checkpoints[j][3]);
						playerCheckpoint[i] = j;
					}
	            } else {
	            	if(playerCheckpoint[i]==j) {
	            	    DisablePlayerCheckpoint(i);
	            	    playerCheckpoint[i] = 999;
         	    	}
	            }
	        }
		}
	}
}
//==============================Is Player in Area===============================
public isPlayerInArea(playerID, Float:data[4])
{
	new Float:X, Float:Y, Float:Z;

	GetPlayerPos(playerID, X, Y, Z);
	if(X >= data[0] && X <= data[2] && Y >= data[1] && Y <= data[3]) {
		return 1;
	}
	return 0;
}
//=============================Gamemode Exit Stuff==============================
public GameModeExitFunc()
{
	GameModeExit();
	return 1;
}
//=================================Team Chat====================================
public GetPlayers() //By rapidZ
{
	new i;
	new player;
	player = 0;
	for (i=0;i<MAX_PLAYERS;i++)
	{
		if(IsPlayerConnected(i))
		{
			player++;
		}
	}
	return player;
}

