/*  ---------------------------------------------------------------------------------| JUST SURVIVE |------------------------------------------------------------------------------------------------
Début : 24/02/2017

*/
#include <a_samp>
#include <YSI\y_ini>
#include <playerprogress>
#include <gl_common>
#include <streamer>
#include <colandreas>

#define CreateObject CreateDynamicObject

#define DateMaj "31/05/2017"

#define rouge 0xFF0000FF
#define jaune 0xFFFF00FF
#define violet 0x400080FF
#define orange 0xFF8000FF
#define bleu 0x0000FFFF
#define newbie 0x00AE00FF
#define ADMIN_COLOR 0x4E8EB9FF
#define rose 0xFF0080FF
#define info 0xFCEBB6FF
#define info2 0x9BD9E6FF
#define info3 0x86B9A8FF
#define vert 0x00FF00FF
#define vert1 0x008000FF
#define blanc 0xFFFFFFFF
#define marron 0x804000FF
#define beige 0xFFB680FF
#define gris 0xBBC1C6FF
#define cyan 0x00FFFFFF

#define PATH "JustSurvive/Comptes/%s.ini"
#define VENTEFILE "JustSurvive/Ventes/%d.ini"

#define MaxLoginTD 11
#define MaxInventoryTD 27

#define MaxPlaces 24

#define MAX_VENTES 1000

#define NUMBPERPAGE 6

// ID OBJETS //
#define MaxObjects 2
#define Rien 0
#define Eau 1

#pragma tabsize 0

new PlayerText:InventObjet[MAX_PLAYERS][3];
new PlayerText:SecInventObjet[MAX_PLAYERS][1][1];
new PlayerText:TD_ObjectReceived[MAX_PLAYERS][5];
new page[MAX_PLAYERS];
new PreviewModels[MaxObjects] = {
-1,
1484
};

enum pInfo
{
	pPass,
	pAdmin,
	Float:pX,
	Float:pY,
	Float:pZ,
	Float:pA,
	pSac
};
enum iType
{
	Item,
	Nombre
};
enum infos
{
	ID,
	Prix,
	Pseudo[MAX_PLAYER_NAME],
	Item,
	Amount
};
#define DIALOG_HDV 25

new request[MAX_PLAYERS];
new bool:OwnVentes[MAX_PLAYERS];
new PlayerText: TD_HDV[MAX_PLAYERS][30];
new VenteInfo[MAX_VENTES][infos];
new PlayerInventory[MAX_PLAYERS][MaxPlaces][iType];
new bool:LoginTDShowed[MAX_PLAYERS];
new bool:InventoryTDShowed[MAX_PLAYERS];
new mdp[MAX_PLAYERS][64];
new PlayerInfo[MAX_PLAYERS][pInfo];
new bool:IsGuest[MAX_PLAYERS];
new bool:IsRegistered[MAX_PLAYERS];
new bool:IsLogged[MAX_PLAYERS];
new bool:IsObjectReceived[MAX_PLAYERS];
new PlayerText: TD_Login[MAX_PLAYERS][MaxLoginTD];
new PlayerText: TD_Inventory[MAX_PLAYERS][MaxInventoryTD];
new treboot;
new PlayerText:TD_Besoins[MAX_PLAYERS][14];
new Bar:Besoins[MAX_PLAYERS][14];
new bool:hdvtd[MAX_PLAYERS];
new Text:txt;
IsNum(textchar)
{
	if(textchar == '0') return 1;
	if(textchar == '1') return 1;
	if(textchar == '2') return 1;
	if(textchar == '3') return 1;
	if(textchar == '4') return 1;
	if(textchar == '5') return 1;
	if(textchar == '6') return 1;
	if(textchar == '7') return 1;
	if(textchar == '8') return 1;
	if(textchar == '9') return 1;
	return 0;
}
FindIP(StrToChk[])
{
	new IpLevel = 0;
	for(new a = 0; a < strlen(StrToChk); a++)
	{

		switch(IpLevel)
		{
			case 0:
			{
	    		if(IsNum(StrToChk[a])) IpLevel++;
			}
			case 1, 2:
			{
                if(IsNum(StrToChk[a])) IpLevel++;
                else if(StrToChk[a] == '.') IpLevel = 4;
                else IpLevel = 0;
			}
			case 3:
			{
			    if(StrToChk[a] == '.') IpLevel++;
			    else IpLevel = 0;
			}
			case 4:
			{
			    if(IsNum(StrToChk[a])) IpLevel++;
			    else IpLevel = 0;
			}
			case 5, 6:
			{
                if(IsNum(StrToChk[a])) IpLevel++;
                else if(StrToChk[a] == '.') IpLevel = 8;
                else IpLevel = 0;
			}
			case 7:
			{
			    if(StrToChk[a] == '.') IpLevel++;
			    else IpLevel = 0;
			}
			case 8:
			{
			    if(IsNum(StrToChk[a])) IpLevel++;
			    else IpLevel = 0;
			}
			case 9, 10:{
                if(IsNum(StrToChk[a])) IpLevel++;
                else if(StrToChk[a] == '.') IpLevel = 12;
                else IpLevel = 0;
			}
			case 11:
			{
			    if(StrToChk[a] == '.') IpLevel++;
			    else IpLevel = 0;
			}
			case 12:
			{
			    if(IsNum(StrToChk[a])) return 1;
                else IpLevel = 0;
			}
  		}
	}
	return 0;
}
CheckContournIp(text[])
{
	
	new start = 0, index, verif, charact[12];
	loop_check:
		index = strfind(text, " .", true, start + 1);
		if(index == -1) return false;
		start = index;
		format(charact,sizeof(charact),"%c",text[start - 1]);
		if(!IsNumeric(charact)) return false;
		for(new i = index; i != 0; i --)
		{
		    if(!IsNumeric(text[i]))
		    {
				if((start - index) > 3) return false;
		        break;
			}
		}
		verif ++;
		if(verif >= 2) return true;
		goto loop_check;
}
main()
{
	print("\n----------------------------------");
	print(" .::::' ------- Survival ------ ':::::.");
	print("----------------------------------\n");
	new ip[128];
	print("///////////////////// Première ////////////////////////");
	ip = "85.74.125.789:7777";
	printf("Première : %d",FindIP(ip));
	print("///////////////////// Deuxième ////////////////////////");
	ip = "jhonny74.125.196.236";
	printf("Deuxième : %d",FindIP(ip));
	print("///////////////////// Troisième ////////////////////////");
	ip = "74 .125 .196.74";
	printf("Troisième : %d",(FindIP(ip) || CheckContournIp(ip)));
	print("///////////////////// Quatrième ////////////////////////");
	ip = "74 .125. salut";
	printf("Quatrième : %d",(FindIP(ip) || CheckContournIp(ip)));
	print("///////////////////// Cinquième ////////////////////////");
	ip = "chouette . ça va .GiveAllPlayersWeapons ?";
	printf("Cinquième : %d",(FindIP(ip) || CheckContournIp(ip)));
}

forward LoadUser_data(playerid,name[],value[]);
forward LoadVentes_data(venteid,name[],value[]);
forward SaveAuto();
forward Reboot();

public SaveAuto()
{
	new string[256];
	string = "~g~Sauvegarde automatique en cours...";
	for(new i;i<MAX_PLAYERS;i++)
	{
	    if(IsGuest[i] == false && IsPlayerConnected(i))
	    {
			GameTextForPlayer(i,string,5000,5);
	        SavePlayer(i);
		}
	}
	SaveAllVentes();
	return 1;
}
public Reboot()
{
	SendClientMessageToAll(ADMIN_COLOR,"[Reboot] Le serveur redémarre, veuillez attendre avant le relancement...");
	SendRconCommand("gmx");
	KillTimer(treboot);
	return 1;
}
public LoadUser_data(playerid,name[],value[])
{
	print("LoadUser_data");
	INI_Int("Password",PlayerInfo[playerid][pPass]);
	INI_Int("Admin",PlayerInfo[playerid][pAdmin]);
	INI_Float("X",PlayerInfo[playerid][pX]);
	INI_Float("Y",PlayerInfo[playerid][pY]);
	INI_Float("Z",PlayerInfo[playerid][pZ]);
	INI_Float("A",PlayerInfo[playerid][pA]);
	INI_Int("Sac",PlayerInfo[playerid][pSac]);
	new tmp[256],tmp1[256],string[256],string2[256],idx;
	for(new i=0;i<MaxPlayerPlaces(playerid);i++)
	{
	    printf("Boucle maxplayerplaces");
		
 		format(string,sizeof(string),"Case_%d",i);
 		INI_String(string,string2,256);
 		printf("String2 : %s",string2);
 		tmp = strtok(string2,idx);
 		printf("tmp = %s",tmp);
 		tmp1 = strtok(string2,idx);
 		printf("tmp1 = %s",tmp1);
 		PlayerInventory[playerid][i][Item] = strval(tmp);
 		PlayerInventory[playerid][i][Nombre] = strval(tmp1);
	}
	return 1;
}
public LoadVentes_data(venteid,name[],value[])
{
	INI_Int("ID",VenteInfo[venteid][ID]);
	INI_Int("Prix",VenteInfo[venteid][Prix]);
	INI_String("Pseudo",VenteInfo[venteid][Pseudo],MAX_PLAYER_NAME);
	INI_Int("Item",VenteInfo[venteid][Item]);
	return 1;
}
stock CreateTDHDV(playerid)
{
	TD_HDV[playerid][0] = CreatePlayerTextDraw(playerid, 118.052688, 52.333339, "box");
	PlayerTextDrawLetterSize(playerid, TD_HDV[playerid][0], 0.000000, 39.201614);
	PlayerTextDrawTextSize(playerid, TD_HDV[playerid][0], 529.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, TD_HDV[playerid][0], 1);
	PlayerTextDrawColor(playerid, TD_HDV[playerid][0], -1);
	PlayerTextDrawUseBox(playerid, TD_HDV[playerid][0], 1);
	PlayerTextDrawBoxColor(playerid, TD_HDV[playerid][0], 125);
	PlayerTextDrawSetShadow(playerid, TD_HDV[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, TD_HDV[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_HDV[playerid][0], 255);
	PlayerTextDrawFont(playerid, TD_HDV[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, TD_HDV[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, TD_HDV[playerid][0], 0);

	TD_HDV[playerid][1] = CreatePlayerTextDraw(playerid, 118.521224, 106.583297, "box");
	PlayerTextDrawLetterSize(playerid, TD_HDV[playerid][1], 0.000000, 0.207908);
	PlayerTextDrawTextSize(playerid, TD_HDV[playerid][1], 529.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, TD_HDV[playerid][1], 1);
	PlayerTextDrawColor(playerid, TD_HDV[playerid][1], -1);
	PlayerTextDrawUseBox(playerid, TD_HDV[playerid][1], 1);
	PlayerTextDrawBoxColor(playerid, TD_HDV[playerid][1], 255);
	PlayerTextDrawSetShadow(playerid, TD_HDV[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, TD_HDV[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_HDV[playerid][1], 255);
	PlayerTextDrawFont(playerid, TD_HDV[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, TD_HDV[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, TD_HDV[playerid][1], 0);

	TD_HDV[playerid][2] = CreatePlayerTextDraw(playerid, 265.637207, 36.000030, "Hotel_des_ventes");
	PlayerTextDrawLetterSize(playerid, TD_HDV[playerid][2], 0.532591, 2.288332);
	PlayerTextDrawAlignment(playerid, TD_HDV[playerid][2], 1);
	PlayerTextDrawColor(playerid, TD_HDV[playerid][2], -1);
	PlayerTextDrawSetShadow(playerid, TD_HDV[playerid][2], -1);
	PlayerTextDrawSetOutline(playerid, TD_HDV[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_HDV[playerid][2], 255);
	PlayerTextDrawFont(playerid, TD_HDV[playerid][2], 0);
	PlayerTextDrawSetProportional(playerid, TD_HDV[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, TD_HDV[playerid][2], -1);

	TD_HDV[playerid][3] = CreatePlayerTextDraw(playerid, 118.521209, 89.083328, "les_ventes");
	PlayerTextDrawLetterSize(playerid, TD_HDV[playerid][3], 0.400000, 1.600000);
	PlayerTextDrawTextSize(playerid, TD_HDV[playerid][3], 221.000000, 10.000000);
	PlayerTextDrawAlignment(playerid, TD_HDV[playerid][3], 1);
	PlayerTextDrawColor(playerid, TD_HDV[playerid][3], -1);
	PlayerTextDrawUseBox(playerid, TD_HDV[playerid][3], 1);
	PlayerTextDrawBoxColor(playerid, TD_HDV[playerid][3], 255);
	PlayerTextDrawSetShadow(playerid, TD_HDV[playerid][3], 2);
	PlayerTextDrawSetOutline(playerid, TD_HDV[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_HDV[playerid][3], 255);
	PlayerTextDrawFont(playerid, TD_HDV[playerid][3], 2);
	PlayerTextDrawSetProportional(playerid, TD_HDV[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, TD_HDV[playerid][3], 2);
	PlayerTextDrawSetSelectable(playerid, TD_HDV[playerid][3], true);

	TD_HDV[playerid][4] = CreatePlayerTextDraw(playerid, 429.150970, 87.916656, "MES_VENTES");
	PlayerTextDrawLetterSize(playerid, TD_HDV[playerid][4], 0.400000, 1.600000);
	PlayerTextDrawTextSize(playerid, TD_HDV[playerid][4], 529.000000, 10.000000);
	PlayerTextDrawAlignment(playerid, TD_HDV[playerid][4], 1);
	PlayerTextDrawColor(playerid, TD_HDV[playerid][4], -1);
	PlayerTextDrawUseBox(playerid, TD_HDV[playerid][4], 0);
	PlayerTextDrawBoxColor(playerid, TD_HDV[playerid][4], 255);
	PlayerTextDrawSetShadow(playerid, TD_HDV[playerid][4], 2);
	PlayerTextDrawSetOutline(playerid, TD_HDV[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_HDV[playerid][4], 255);
	PlayerTextDrawFont(playerid, TD_HDV[playerid][4], 2);
	PlayerTextDrawSetProportional(playerid, TD_HDV[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid, TD_HDV[playerid][4], 2);
	PlayerTextDrawSetSelectable(playerid, TD_HDV[playerid][4], true);

	TD_HDV[playerid][5] = CreatePlayerTextDraw(playerid, 267.042541, 75.083343, "box");
	PlayerTextDrawLetterSize(playerid, TD_HDV[playerid][5], 0.000000, 3.112739);
	PlayerTextDrawTextSize(playerid, TD_HDV[playerid][5], 383.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, TD_HDV[playerid][5], 1);
	PlayerTextDrawColor(playerid, TD_HDV[playerid][5], -1);
	PlayerTextDrawUseBox(playerid, TD_HDV[playerid][5], 1);
	PlayerTextDrawBoxColor(playerid, TD_HDV[playerid][5], 255);
	PlayerTextDrawSetShadow(playerid, TD_HDV[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, TD_HDV[playerid][5], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_HDV[playerid][5], 255);
	PlayerTextDrawFont(playerid, TD_HDV[playerid][5], 1);
	PlayerTextDrawSetProportional(playerid, TD_HDV[playerid][5], 1);
	PlayerTextDrawSetShadow(playerid, TD_HDV[playerid][5], 0);

	TD_HDV[playerid][6] = CreatePlayerTextDraw(playerid, 288.126159, 82.666717, "");
	PlayerTextDrawLetterSize(playerid, TD_HDV[playerid][6], 0.400000, 1.600000);
	PlayerTextDrawTextSize(playerid, TD_HDV[playerid][6], 358.000000, 10.000000);
	PlayerTextDrawAlignment(playerid, TD_HDV[playerid][6], 1);
	PlayerTextDrawColor(playerid, TD_HDV[playerid][6], -1);
	PlayerTextDrawUseBox(playerid, TD_HDV[playerid][6], 1);
	PlayerTextDrawBoxColor(playerid, TD_HDV[playerid][6], 255);
	PlayerTextDrawSetShadow(playerid, TD_HDV[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, TD_HDV[playerid][6], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_HDV[playerid][6], 255);
	PlayerTextDrawFont(playerid, TD_HDV[playerid][6], 2);
	PlayerTextDrawSetProportional(playerid, TD_HDV[playerid][6], 1);
	PlayerTextDrawSetShadow(playerid, TD_HDV[playerid][6], 0);
	PlayerTextDrawSetSelectable(playerid, TD_HDV[playerid][6], true);

	TD_HDV[playerid][7] = CreatePlayerTextDraw(playerid, 118.052642, 111.833320, "box");
	PlayerTextDrawLetterSize(playerid, TD_HDV[playerid][7], 0.000000, 4.846266);
	PlayerTextDrawTextSize(playerid, TD_HDV[playerid][7], 529.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, TD_HDV[playerid][7], 1);
	PlayerTextDrawColor(playerid, TD_HDV[playerid][7], -1);
	PlayerTextDrawUseBox(playerid, TD_HDV[playerid][7], 1);
	PlayerTextDrawBoxColor(playerid, TD_HDV[playerid][7], 175);
	PlayerTextDrawSetShadow(playerid, TD_HDV[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, TD_HDV[playerid][7], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_HDV[playerid][7], 255);
	PlayerTextDrawFont(playerid, TD_HDV[playerid][7], 1);
	PlayerTextDrawSetProportional(playerid, TD_HDV[playerid][7], 1);
	PlayerTextDrawSetShadow(playerid, TD_HDV[playerid][7], 0);

	TD_HDV[playerid][8] = CreatePlayerTextDraw(playerid, 118.052642, 160.716445, "box");
	PlayerTextDrawLetterSize(playerid, TD_HDV[playerid][8], 0.000000, 4.846266);
	PlayerTextDrawTextSize(playerid, TD_HDV[playerid][8], 529.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, TD_HDV[playerid][8], 1);
	PlayerTextDrawColor(playerid, TD_HDV[playerid][8], -1);
	PlayerTextDrawUseBox(playerid, TD_HDV[playerid][8], 1);
	PlayerTextDrawBoxColor(playerid, TD_HDV[playerid][8], 175);
	PlayerTextDrawSetShadow(playerid, TD_HDV[playerid][8], 0);
	PlayerTextDrawSetOutline(playerid, TD_HDV[playerid][8], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_HDV[playerid][8], 255);
	PlayerTextDrawFont(playerid, TD_HDV[playerid][8], 1);
	PlayerTextDrawSetProportional(playerid, TD_HDV[playerid][8], 1);
	PlayerTextDrawSetShadow(playerid, TD_HDV[playerid][8], 0);

	TD_HDV[playerid][9] = CreatePlayerTextDraw(playerid, 118.052642, 210.219467, "box");
	PlayerTextDrawLetterSize(playerid, TD_HDV[playerid][9], 0.000000, 4.846266);
	PlayerTextDrawTextSize(playerid, TD_HDV[playerid][9], 529.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, TD_HDV[playerid][9], 1);
	PlayerTextDrawColor(playerid, TD_HDV[playerid][9], -1);
	PlayerTextDrawUseBox(playerid, TD_HDV[playerid][9], 1);
	PlayerTextDrawBoxColor(playerid, TD_HDV[playerid][9], 175);
	PlayerTextDrawSetShadow(playerid, TD_HDV[playerid][9], 0);
	PlayerTextDrawSetOutline(playerid, TD_HDV[playerid][9], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_HDV[playerid][9], 255);
	PlayerTextDrawFont(playerid, TD_HDV[playerid][9], 1);
	PlayerTextDrawSetProportional(playerid, TD_HDV[playerid][9], 1);
	PlayerTextDrawSetShadow(playerid, TD_HDV[playerid][9], 0);

	TD_HDV[playerid][10] = CreatePlayerTextDraw(playerid, 118.052642, 259.822479, "box");
	PlayerTextDrawLetterSize(playerid, TD_HDV[playerid][10], 0.000000, 4.846266);
	PlayerTextDrawTextSize(playerid, TD_HDV[playerid][10], 529.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, TD_HDV[playerid][10], 1);
	PlayerTextDrawColor(playerid, TD_HDV[playerid][10], -1);
	PlayerTextDrawUseBox(playerid, TD_HDV[playerid][10], 1);
	PlayerTextDrawBoxColor(playerid, TD_HDV[playerid][10], 175);
	PlayerTextDrawSetShadow(playerid, TD_HDV[playerid][10], 0);
	PlayerTextDrawSetOutline(playerid, TD_HDV[playerid][10], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_HDV[playerid][10], 255);
	PlayerTextDrawFont(playerid, TD_HDV[playerid][10], 1);
	PlayerTextDrawSetProportional(playerid, TD_HDV[playerid][10], 1);
	PlayerTextDrawSetShadow(playerid, TD_HDV[playerid][10], 0);

	TD_HDV[playerid][11] = CreatePlayerTextDraw(playerid, 118.052642, 309.825531, "box");
	PlayerTextDrawLetterSize(playerid, TD_HDV[playerid][11], 0.000000, 4.846266);
	PlayerTextDrawTextSize(playerid, TD_HDV[playerid][11], 529.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, TD_HDV[playerid][11], 1);
	PlayerTextDrawColor(playerid, TD_HDV[playerid][11], -1);
	PlayerTextDrawUseBox(playerid, TD_HDV[playerid][11], 1);
	PlayerTextDrawBoxColor(playerid, TD_HDV[playerid][11], 175);
	PlayerTextDrawSetShadow(playerid, TD_HDV[playerid][11], 0);
	PlayerTextDrawSetOutline(playerid, TD_HDV[playerid][11], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_HDV[playerid][11], 255);
	PlayerTextDrawFont(playerid, TD_HDV[playerid][11], 1);
	PlayerTextDrawSetProportional(playerid, TD_HDV[playerid][11], 1);
	PlayerTextDrawSetShadow(playerid, TD_HDV[playerid][11], 0);

	TD_HDV[playerid][12] = CreatePlayerTextDraw(playerid, 118.052642, 359.428558, "box");
	PlayerTextDrawLetterSize(playerid, TD_HDV[playerid][12], 0.000000, 4.846266);
	PlayerTextDrawTextSize(playerid, TD_HDV[playerid][12], 529.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, TD_HDV[playerid][12], 1);
	PlayerTextDrawColor(playerid, TD_HDV[playerid][12], -1);
	PlayerTextDrawUseBox(playerid, TD_HDV[playerid][12], 1);
	PlayerTextDrawBoxColor(playerid, TD_HDV[playerid][12], 175);
	PlayerTextDrawSetShadow(playerid, TD_HDV[playerid][12], 0);
	PlayerTextDrawSetOutline(playerid, TD_HDV[playerid][12], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_HDV[playerid][12], 255);
	PlayerTextDrawFont(playerid, TD_HDV[playerid][12], 1);
	PlayerTextDrawSetProportional(playerid, TD_HDV[playerid][12], 1);
	PlayerTextDrawSetShadow(playerid, TD_HDV[playerid][12], 0);

	TD_HDV[playerid][13] = CreatePlayerTextDraw(playerid, 386.046905, 90.250007, ">");
	PlayerTextDrawLetterSize(playerid, TD_HDV[playerid][13], 0.400000, 1.594166);
	PlayerTextDrawTextSize(playerid, TD_HDV[playerid][13], 395.000000,10.000000);
	PlayerTextDrawAlignment(playerid, TD_HDV[playerid][13], 1);
	PlayerTextDrawColor(playerid, TD_HDV[playerid][13], -1);
	PlayerTextDrawUseBox(playerid, TD_HDV[playerid][13], 1);
	PlayerTextDrawBoxColor(playerid, TD_HDV[playerid][13], 255);
	PlayerTextDrawSetShadow(playerid, TD_HDV[playerid][13], 0);
	PlayerTextDrawSetOutline(playerid, TD_HDV[playerid][13], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_HDV[playerid][13], 255);
	PlayerTextDrawFont(playerid, TD_HDV[playerid][13], 1);
	PlayerTextDrawSetProportional(playerid, TD_HDV[playerid][13], 1);
	PlayerTextDrawSetShadow(playerid, TD_HDV[playerid][13], 0);
	PlayerTextDrawSetSelectable(playerid, TD_HDV[playerid][13], true);

	TD_HDV[playerid][14] = CreatePlayerTextDraw(playerid, 254.738891, 90.250007, "<");
	PlayerTextDrawLetterSize(playerid, TD_HDV[playerid][14], 0.400000, 1.594166);
	PlayerTextDrawTextSize(playerid, TD_HDV[playerid][14], 263.691986, 10.000000);
	PlayerTextDrawAlignment(playerid, TD_HDV[playerid][14], 1);
	PlayerTextDrawColor(playerid, TD_HDV[playerid][14], -1);
	PlayerTextDrawUseBox(playerid, TD_HDV[playerid][14], 1);
	PlayerTextDrawBoxColor(playerid, TD_HDV[playerid][14], 255);
	PlayerTextDrawSetShadow(playerid, TD_HDV[playerid][14], 0);
	PlayerTextDrawSetOutline(playerid, TD_HDV[playerid][14], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_HDV[playerid][14], 255);
	PlayerTextDrawFont(playerid, TD_HDV[playerid][14], 1);
	PlayerTextDrawSetProportional(playerid, TD_HDV[playerid][14], 1);
	PlayerTextDrawSetShadow(playerid, TD_HDV[playerid][14], 0);
	PlayerTextDrawSetSelectable(playerid, TD_HDV[playerid][14], true);

	TD_HDV[playerid][15] = CreatePlayerTextDraw(playerid, 438.343322, 53.300064, "Rechercher");
	PlayerTextDrawLetterSize(playerid, TD_HDV[playerid][15], 0.346120, 1.512499);
	PlayerTextDrawTextSize(playerid, TD_HDV[playerid][15], 528.901489, 10.000000);
	PlayerTextDrawAlignment(playerid, TD_HDV[playerid][15], 1);
	PlayerTextDrawColor(playerid, TD_HDV[playerid][15], -1);
	PlayerTextDrawUseBox(playerid, TD_HDV[playerid][15], 1);
	PlayerTextDrawBoxColor(playerid, TD_HDV[playerid][15], 255);
	PlayerTextDrawSetShadow(playerid, TD_HDV[playerid][15], 2);
	PlayerTextDrawSetOutline(playerid, TD_HDV[playerid][15], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_HDV[playerid][15], 255);
	PlayerTextDrawFont(playerid, TD_HDV[playerid][15], 2);
	PlayerTextDrawSetProportional(playerid, TD_HDV[playerid][15], 1);
	PlayerTextDrawSetShadow(playerid, TD_HDV[playerid][15], 2);
	PlayerTextDrawSetSelectable(playerid, TD_HDV[playerid][15], true);


	TD_HDV[playerid][16] = CreatePlayerTextDraw(playerid, 262.825744, 226.166671, "AUCUNE_VENTE");
	PlayerTextDrawLetterSize(playerid, TD_HDV[playerid][16], 0.400000, 1.600000);
	PlayerTextDrawAlignment(playerid, TD_HDV[playerid][16], 1);
	PlayerTextDrawColor(playerid, TD_HDV[playerid][16], -16776961);
	PlayerTextDrawSetShadow(playerid, TD_HDV[playerid][16], 0);
	PlayerTextDrawSetOutline(playerid, TD_HDV[playerid][16], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_HDV[playerid][16], 255);
	PlayerTextDrawFont(playerid, TD_HDV[playerid][16], 2);
	PlayerTextDrawSetProportional(playerid, TD_HDV[playerid][16], 1);
	PlayerTextDrawSetShadow(playerid, TD_HDV[playerid][16], 0);

	TD_HDV[playerid][17] = CreatePlayerTextDraw(playerid, 116.947219, 110.083305, "");
	PlayerTextDrawLetterSize(playerid, TD_HDV[playerid][17], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TD_HDV[playerid][17], 50.000000, 47.000000);
	PlayerTextDrawAlignment(playerid, TD_HDV[playerid][17], 1);
	PlayerTextDrawColor(playerid, TD_HDV[playerid][17], -1);
	PlayerTextDrawSetShadow(playerid, TD_HDV[playerid][17], 0);
	PlayerTextDrawSetOutline(playerid, TD_HDV[playerid][17], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_HDV[playerid][17], 255);
	PlayerTextDrawFont(playerid, TD_HDV[playerid][17], 5);
	PlayerTextDrawSetProportional(playerid, TD_HDV[playerid][17], 0);
	PlayerTextDrawSetShadow(playerid, TD_HDV[playerid][17], 0);
	PlayerTextDrawSetSelectable(playerid, TD_HDV[playerid][17], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_HDV[playerid][17], 1478);
	PlayerTextDrawSetPreviewRot(playerid, TD_HDV[playerid][17], 0.000000, 0.000000, 0.000000, 1.000000);

	TD_HDV[playerid][18] = CreatePlayerTextDraw(playerid, 116.947219, 158.184875, "");
	PlayerTextDrawLetterSize(playerid, TD_HDV[playerid][18], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TD_HDV[playerid][18], 50.000000, 47.000000);
	PlayerTextDrawAlignment(playerid, TD_HDV[playerid][18], 1);
	PlayerTextDrawColor(playerid, TD_HDV[playerid][18], -1);
	PlayerTextDrawSetShadow(playerid, TD_HDV[playerid][18], 0);
	PlayerTextDrawSetOutline(playerid, TD_HDV[playerid][18], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_HDV[playerid][18], 255);
	PlayerTextDrawFont(playerid, TD_HDV[playerid][18], 5);
	PlayerTextDrawSetProportional(playerid, TD_HDV[playerid][18], 0);
	PlayerTextDrawSetShadow(playerid, TD_HDV[playerid][18], 0);
	PlayerTextDrawSetSelectable(playerid, TD_HDV[playerid][18], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_HDV[playerid][18], 1478);
	PlayerTextDrawSetPreviewRot(playerid, TD_HDV[playerid][18], 0.000000, 0.000000, 0.000000, 1.000000);

	TD_HDV[playerid][19] = CreatePlayerTextDraw(playerid, 116.947219, 209.187988, "");
	PlayerTextDrawLetterSize(playerid, TD_HDV[playerid][19], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TD_HDV[playerid][19], 50.000000, 47.000000);
	PlayerTextDrawAlignment(playerid, TD_HDV[playerid][19], 1);
	PlayerTextDrawColor(playerid, TD_HDV[playerid][19], -1);
	PlayerTextDrawSetShadow(playerid, TD_HDV[playerid][19], 0);
	PlayerTextDrawSetOutline(playerid, TD_HDV[playerid][19], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_HDV[playerid][19], 255);
	PlayerTextDrawFont(playerid, TD_HDV[playerid][19], 5);
	PlayerTextDrawSetProportional(playerid, TD_HDV[playerid][19], 0);
	PlayerTextDrawSetShadow(playerid, TD_HDV[playerid][19], 0);
	PlayerTextDrawSetSelectable(playerid, TD_HDV[playerid][19], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_HDV[playerid][19], 1478);
	PlayerTextDrawSetPreviewRot(playerid, TD_HDV[playerid][19], 0.000000, 0.000000, 0.000000, 1.000000);

	TD_HDV[playerid][20] = CreatePlayerTextDraw(playerid, 116.947219, 257.790954, "");
	PlayerTextDrawLetterSize(playerid, TD_HDV[playerid][20], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TD_HDV[playerid][20], 50.000000, 47.000000);
	PlayerTextDrawAlignment(playerid, TD_HDV[playerid][20], 1);
	PlayerTextDrawColor(playerid, TD_HDV[playerid][20], -1);
	PlayerTextDrawSetShadow(playerid, TD_HDV[playerid][20], 0);
	PlayerTextDrawSetOutline(playerid, TD_HDV[playerid][20], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_HDV[playerid][20], 255);
	PlayerTextDrawFont(playerid, TD_HDV[playerid][20], 5);
	PlayerTextDrawSetProportional(playerid, TD_HDV[playerid][20], 0);
	PlayerTextDrawSetShadow(playerid, TD_HDV[playerid][20], 0);
	PlayerTextDrawSetSelectable(playerid, TD_HDV[playerid][20], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_HDV[playerid][20], 1478);
	PlayerTextDrawSetPreviewRot(playerid, TD_HDV[playerid][20], 0.000000, 0.000000, 0.000000, 1.000000);

	TD_HDV[playerid][21] = CreatePlayerTextDraw(playerid, 116.947219, 308.394042, "");
	PlayerTextDrawLetterSize(playerid, TD_HDV[playerid][21], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TD_HDV[playerid][21], 50.000000, 47.000000);
	PlayerTextDrawAlignment(playerid, TD_HDV[playerid][21], 1);
	PlayerTextDrawColor(playerid, TD_HDV[playerid][21], -1);
	PlayerTextDrawSetShadow(playerid, TD_HDV[playerid][21], 0);
	PlayerTextDrawSetOutline(playerid, TD_HDV[playerid][21], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_HDV[playerid][21], 255);
	PlayerTextDrawFont(playerid, TD_HDV[playerid][21], 5);
	PlayerTextDrawSetProportional(playerid, TD_HDV[playerid][21], 0);
	PlayerTextDrawSetShadow(playerid, TD_HDV[playerid][21], 0);
	PlayerTextDrawSetSelectable(playerid, TD_HDV[playerid][21], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_HDV[playerid][21], 1478);
	PlayerTextDrawSetPreviewRot(playerid, TD_HDV[playerid][21], 0.000000, 0.000000, 0.000000, 1.000000);

	TD_HDV[playerid][22] = CreatePlayerTextDraw(playerid, 116.947219, 357.497039, "");
	PlayerTextDrawLetterSize(playerid, TD_HDV[playerid][22], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TD_HDV[playerid][22], 50.000000, 47.000000);
	PlayerTextDrawAlignment(playerid, TD_HDV[playerid][22], 1);
	PlayerTextDrawColor(playerid, TD_HDV[playerid][22], -1);
	PlayerTextDrawSetShadow(playerid, TD_HDV[playerid][22], 0);
	PlayerTextDrawSetOutline(playerid, TD_HDV[playerid][22], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_HDV[playerid][22], 255);
	PlayerTextDrawFont(playerid, TD_HDV[playerid][22], 5);
	PlayerTextDrawSetProportional(playerid, TD_HDV[playerid][22], 0);
	PlayerTextDrawSetShadow(playerid, TD_HDV[playerid][22], 0);
	PlayerTextDrawSetSelectable(playerid, TD_HDV[playerid][22], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_HDV[playerid][22], 1478);
	PlayerTextDrawSetPreviewRot(playerid, TD_HDV[playerid][22], 0.000000, 0.000000, 0.000000, 1.000000);

	TD_HDV[playerid][23] = CreatePlayerTextDraw(playerid, 172.401199, 112.416633, "Vente nÂ°1 :  Marteau Lourd Ã  500$~n~Prix_:_500_/_unite~n~vendeur_:_Viingo");
	PlayerTextDrawLetterSize(playerid, TD_HDV[playerid][23], 0.337686, 1.454166);
	PlayerTextDrawAlignment(playerid, TD_HDV[playerid][23], 1);
	PlayerTextDrawColor(playerid, TD_HDV[playerid][23], -1);
	PlayerTextDrawSetShadow(playerid, TD_HDV[playerid][23], 5);
	PlayerTextDrawSetOutline(playerid, TD_HDV[playerid][23], 1);
	PlayerTextDrawBackgroundColor(playerid, TD_HDV[playerid][23], 255);
	PlayerTextDrawFont(playerid, TD_HDV[playerid][23], 3);
	PlayerTextDrawSetProportional(playerid, TD_HDV[playerid][23], 1);
	PlayerTextDrawSetShadow(playerid, TD_HDV[playerid][23], 5);

	TD_HDV[playerid][24] = CreatePlayerTextDraw(playerid, 172.401199, 161.718460, "Vente nÂ°1 :  Marteau Lourd Ã  500$~n~Prix_:_500_/_unite~n~vendeur_:_Viingo");
	PlayerTextDrawLetterSize(playerid, TD_HDV[playerid][24], 0.337686, 1.454166);
	PlayerTextDrawAlignment(playerid, TD_HDV[playerid][24], 1);
	PlayerTextDrawColor(playerid, TD_HDV[playerid][24], -1);
	PlayerTextDrawSetShadow(playerid, TD_HDV[playerid][24], 5);
	PlayerTextDrawSetOutline(playerid, TD_HDV[playerid][24], 1);
	PlayerTextDrawBackgroundColor(playerid, TD_HDV[playerid][24], 255);
	PlayerTextDrawFont(playerid, TD_HDV[playerid][24], 3);
	PlayerTextDrawSetProportional(playerid, TD_HDV[playerid][24], 1);
	PlayerTextDrawSetShadow(playerid, TD_HDV[playerid][24], 5);

	TD_HDV[playerid][25] = CreatePlayerTextDraw(playerid, 172.401199, 210.354843, "Vente nÂ°1 :  Marteau Lourd Ã  500$~n~Prix_:_500_/_unite~n~vendeur_:_Viingo");
	PlayerTextDrawLetterSize(playerid, TD_HDV[playerid][25], 0.337686, 1.454166);
	PlayerTextDrawAlignment(playerid, TD_HDV[playerid][25], 1);
	PlayerTextDrawColor(playerid, TD_HDV[playerid][25], -1);
	PlayerTextDrawSetShadow(playerid, TD_HDV[playerid][25], 5);
	PlayerTextDrawSetOutline(playerid, TD_HDV[playerid][25], 1);
	PlayerTextDrawBackgroundColor(playerid, TD_HDV[playerid][25], 255);
	PlayerTextDrawFont(playerid, TD_HDV[playerid][25], 3);
	PlayerTextDrawSetProportional(playerid, TD_HDV[playerid][25], 1);
	PlayerTextDrawSetShadow(playerid, TD_HDV[playerid][25], 5);

	TD_HDV[playerid][26] = CreatePlayerTextDraw(playerid, 172.401199, 260.457885, "Vente nÂ°1 :  Marteau Lourd Ã  500$~n~Prix_:_500_/_unite~n~vendeur_:_Viingo");
	PlayerTextDrawLetterSize(playerid, TD_HDV[playerid][26], 0.337686, 1.454166);
	PlayerTextDrawAlignment(playerid, TD_HDV[playerid][26], 1);
	PlayerTextDrawColor(playerid, TD_HDV[playerid][26], -1);
	PlayerTextDrawSetShadow(playerid, TD_HDV[playerid][26], 5);
	PlayerTextDrawSetOutline(playerid, TD_HDV[playerid][26], 1);
	PlayerTextDrawBackgroundColor(playerid, TD_HDV[playerid][26], 255);
	PlayerTextDrawFont(playerid, TD_HDV[playerid][26], 3);
	PlayerTextDrawSetProportional(playerid, TD_HDV[playerid][26], 1);
	PlayerTextDrawSetShadow(playerid, TD_HDV[playerid][26], 5);

	TD_HDV[playerid][27] = CreatePlayerTextDraw(playerid, 172.401199, 310.960968, "Vente nÂ°1 :  Marteau Lourd Ã  500$~n~Prix_:_500_/_unite~n~vendeur_:_Viingo");
	PlayerTextDrawLetterSize(playerid, TD_HDV[playerid][27], 0.337686, 1.454166);
	PlayerTextDrawAlignment(playerid, TD_HDV[playerid][27], 1);
	PlayerTextDrawColor(playerid, TD_HDV[playerid][27], -1);
	PlayerTextDrawSetShadow(playerid, TD_HDV[playerid][27], 5);
	PlayerTextDrawSetOutline(playerid, TD_HDV[playerid][27], 1);
	PlayerTextDrawBackgroundColor(playerid, TD_HDV[playerid][27], 255);
	PlayerTextDrawFont(playerid, TD_HDV[playerid][27], 3);
	PlayerTextDrawSetProportional(playerid, TD_HDV[playerid][27], 1);
	PlayerTextDrawSetShadow(playerid, TD_HDV[playerid][27], 5);

	TD_HDV[playerid][28] = CreatePlayerTextDraw(playerid, 172.869720, 358.597259, "Vente nÂ°1 :  Marteau Lourd Ã  500$~n~Prix_:_500_/_unite~n~vendeur_:_Viingo");
	PlayerTextDrawLetterSize(playerid, TD_HDV[playerid][28], 0.337686, 1.454166);
	PlayerTextDrawAlignment(playerid, TD_HDV[playerid][28], 1);
	PlayerTextDrawColor(playerid, TD_HDV[playerid][28], -1);
	PlayerTextDrawSetShadow(playerid, TD_HDV[playerid][28], 5);
	PlayerTextDrawSetOutline(playerid, TD_HDV[playerid][28], 1);
	PlayerTextDrawBackgroundColor(playerid, TD_HDV[playerid][28], 255);
	PlayerTextDrawFont(playerid, TD_HDV[playerid][28], 3);
	PlayerTextDrawSetProportional(playerid, TD_HDV[playerid][28], 1);
	PlayerTextDrawSetShadow(playerid, TD_HDV[playerid][28], 5);

	TD_HDV[playerid][29] = CreatePlayerTextDraw(playerid, 118.424530, 52.716732, "AJOUTER_+");
	PlayerTextDrawLetterSize(playerid, TD_HDV[playerid][29], 0.346120, 1.512499);
	PlayerTextDrawTextSize(playerid, TD_HDV[playerid][29], 197.000000, 10.000000);
	PlayerTextDrawAlignment(playerid, TD_HDV[playerid][29], 1);
	PlayerTextDrawColor(playerid, TD_HDV[playerid][29], -1);
	PlayerTextDrawUseBox(playerid, TD_HDV[playerid][29], 1);
	PlayerTextDrawBoxColor(playerid, TD_HDV[playerid][29], 255);
	PlayerTextDrawSetShadow(playerid, TD_HDV[playerid][29], 2);
	PlayerTextDrawSetOutline(playerid, TD_HDV[playerid][29], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_HDV[playerid][29], 255);
	PlayerTextDrawFont(playerid, TD_HDV[playerid][29], 2);
	PlayerTextDrawSetProportional(playerid, TD_HDV[playerid][29], 1);
	PlayerTextDrawSetShadow(playerid, TD_HDV[playerid][29], 2);
	PlayerTextDrawSetSelectable(playerid, TD_HDV[playerid][29], true);
}
CreateTD(playerid)
{
		InventObjet[playerid][0] = CreatePlayerTextDraw(playerid, 530.000000, 211.000000, " ");
		PlayerTextDrawBackgroundColor(playerid, InventObjet[playerid][0], 136);
		PlayerTextDrawFont(playerid, InventObjet[playerid][0], 5);
		PlayerTextDrawLetterSize(playerid, InventObjet[playerid][0], -1.400000, -3.600000);
		PlayerTextDrawColor(playerid, InventObjet[playerid][0], -1);
		PlayerTextDrawSetOutline(playerid, InventObjet[playerid][0], 0);
		PlayerTextDrawSetProportional(playerid, InventObjet[playerid][0], 1);
		PlayerTextDrawSetShadow(playerid, InventObjet[playerid][0], 1);
		PlayerTextDrawUseBox(playerid, InventObjet[playerid][0], 1);
		PlayerTextDrawBoxColor(playerid, InventObjet[playerid][0], 255);
		PlayerTextDrawTextSize(playerid, InventObjet[playerid][0], 90.000000, 100.000000);
		PlayerTextDrawSetPreviewModel(playerid, InventObjet[playerid][0], 18888);
		PlayerTextDrawSetPreviewRot(playerid, InventObjet[playerid][0], 0.000000, 0.000000, 0.000000, 1.000000);
		PlayerTextDrawSetSelectable(playerid, InventObjet[playerid][0], 1);
		//---
		InventObjet[playerid][1] = CreatePlayerTextDraw(playerid, 535.000000, 286.000000, "Rien");
		PlayerTextDrawBackgroundColor(playerid, InventObjet[playerid][1], 255);
		PlayerTextDrawFont(playerid, InventObjet[playerid][1], 2);
		PlayerTextDrawLetterSize(playerid, InventObjet[playerid][1], 0.300000, 1.000000);
		PlayerTextDrawColor(playerid, InventObjet[playerid][1], -1);
		PlayerTextDrawSetOutline(playerid, InventObjet[playerid][1], 0);
		PlayerTextDrawSetProportional(playerid, InventObjet[playerid][1], 1);
		PlayerTextDrawSetShadow(playerid, InventObjet[playerid][1], 1);
		PlayerTextDrawSetSelectable(playerid, InventObjet[playerid][1], 0);
		//---
		InventObjet[playerid][2] = CreatePlayerTextDraw(playerid, 535.000000, 211.000000, "0");
		PlayerTextDrawBackgroundColor(playerid, InventObjet[playerid][2], 255);
		PlayerTextDrawFont(playerid, InventObjet[playerid][2], 2);
		PlayerTextDrawLetterSize(playerid, InventObjet[playerid][2], 0.300000, 1.000000);
		PlayerTextDrawColor(playerid, InventObjet[playerid][2], -1);
		PlayerTextDrawSetOutline(playerid, InventObjet[playerid][2], 0);
		PlayerTextDrawSetProportional(playerid, InventObjet[playerid][2], 1);
		PlayerTextDrawSetShadow(playerid, InventObjet[playerid][2], 1);
		PlayerTextDrawSetSelectable(playerid, InventObjet[playerid][2], 0);
		//---
		SecInventObjet[playerid][0][0] = CreatePlayerTextDraw(playerid, 490.000000, 211.000000, " ");
		PlayerTextDrawBackgroundColor(playerid, SecInventObjet[playerid][0][0], 136);
		PlayerTextDrawFont(playerid, SecInventObjet[playerid][0][0], 5);
		PlayerTextDrawLetterSize(playerid, SecInventObjet[playerid][0][0], -1.399999, -3.599998);
		PlayerTextDrawColor(playerid, SecInventObjet[playerid][0][0], -1);
		PlayerTextDrawSetOutline(playerid, SecInventObjet[playerid][0][0], 0);
		PlayerTextDrawSetProportional(playerid, SecInventObjet[playerid][0][0], 1);
		PlayerTextDrawSetShadow(playerid, SecInventObjet[playerid][0][0], 1);
		PlayerTextDrawUseBox(playerid, SecInventObjet[playerid][0][0], 1);
		PlayerTextDrawBoxColor(playerid, SecInventObjet[playerid][0][0], 255);
		PlayerTextDrawTextSize(playerid, SecInventObjet[playerid][0][0], 30.000000, 30.000000);
		PlayerTextDrawSetPreviewModel(playerid, SecInventObjet[playerid][0][0], 18888);
		PlayerTextDrawSetPreviewRot(playerid, SecInventObjet[playerid][0][0], 0.000000, 0.000000, 0.000000, 1.000000);
		PlayerTextDrawSetSelectable(playerid, SecInventObjet[playerid][0][0], 1);
}
stock NumPlayerVentes(playerid)
{
	new value;
	for(new i; i < MAX_VENTES;i++)
	{
	    if(VenteInfo[i][Item] != 0)
	    {
   	 		if(strcmp(GetName(playerid),VenteInfo[i][Pseudo],true) == 0)
   	 		{
   	 		    value ++;
			}
		}
	}
	return value;
}
stock FirstPlaceVente()
{
	new value = -1;
	for(new i; i < MAX_VENTES; i++)
	{
	    if(VenteInfo[i][Item] == 0)
		{
			value = i;
			break;
		}
	}
	return value;
}
stock ShowNextPage(playerid)
{
	page[playerid] ++;
	new value = page[playerid] * NUMBPERPAGE, string[256];
	for(new i = value - NUMBPERPAGE; i < value; i++)
	{
	    new index1 = (i + 7) - ( (page[playerid] - 1) * NUMBPERPAGE);
	    new index2 = (i + 17) - ( (page[playerid] - 1) * NUMBPERPAGE);
	    new index3 = (i + 23) - ( (page[playerid] - 1) * NUMBPERPAGE);
		if(VenteInfo[i][Item] == 0)
		{
		    for(new i2; i2 < MAX_VENTES; i2++)
		    {
		        if(VenteInfo[i2][Item] != 0)
		        {
			        PlayerTextDrawSetPreviewModel(playerid,TD_HDV[playerid][index2],PreviewModels[VenteInfo[i2][Item]]);
			        format(string,sizeof(string),"Vente n°%d: %d %s~n~Prix : %d$ / unité~n~Vendeur : %s",i2,VenteInfo[i2][Amount],GetNameObject(VenteInfo[i2][Item]),VenteInfo[i2][Prix],VenteInfo[i2][Pseudo]);
					ConvertEncoding(string);
					PlayerTextDrawSetString(playerid,TD_HDV[playerid][index3],string);
					PlayerTextDrawShow(playerid,TD_HDV[playerid][index1]);
					PlayerTextDrawShow(playerid,TD_HDV[playerid][index2]);
			        PlayerTextDrawShow(playerid,TD_HDV[playerid][index3]);
				}
	 		}
		}
	}
	return 1;
}
stock ShowHDV(playerid)
{
	for(new i; i < 7; i++)
	{
		PlayerTextDrawShow(playerid,TD_HDV[playerid][i]);
	}
	for(new i = 13; i < 16; i++)
	{
	    PlayerTextDrawShow(playerid,TD_HDV[playerid][i]);
	}
	if( (OwnVentes[playerid] == false && NumVentes() == 0) || (OwnVentes[playerid] == true && NumPlayerVentes(playerid)) ) PlayerTextDrawShow(playerid,TD_HDV[playerid][16]);
	else
	{
	    new maxpage = (OwnVentes[playerid] == false ? floatround(float(NumVentes() / NUMBPERPAGE),floatround_ceil) : floatround(float(NumPlayerVentes(playerid) / NUMBPERPAGE),floatround_ceil) ),string[256];
	    if(OwnVentes[playerid] == false)
	    {
	    	/*for(new i2; i2 < MAX_VENTES; i2++)
		    {
		        if(VenteInfo[i2][Item] != 0)
		        {
		            new index1 = i2 + 7;
		            new index2 = i2 + 17;
		            new index3 = i2 + 23;
			        PlayerTextDrawSetPreviewModel(playerid,TD_HDV[playerid][index2],PreviewModels[VenteInfo[i2][Item]]);
			        format(string,sizeof(string),"Vente n°%d: %d %s~n~Prix : %d$ / unité~n~Vendeur : %s",i2,VenteInfo[i2][Amount],GetNameObject(VenteInfo[i2][Item]),VenteInfo[i2][Prix],VenteInfo[i2][Pseudo]);
					ConvertEncoding(string);
					PlayerTextDrawSetString(playerid,TD_HDV[playerid][index3],string);
					PlayerTextDrawShow(playerid,TD_HDV[playerid][index1]);
					PlayerTextDrawShow(playerid,TD_HDV[playerid][index2]);
			        PlayerTextDrawShow(playerid,TD_HDV[playerid][index3]);
				}
	 		}*/
	 		ShowNextPage(playerid);
		}
  		if(OwnVentes[playerid] == true)
	    {
		    for(new i; i < MAX_VENTES; i++)
		    {
		        if(strcmp(GetName(playerid),VenteInfo[i][Pseudo],true) == 0)
		        {
		        	PlayerTextDrawSetPreviewModel(playerid,TD_HDV[playerid][i + 17],PreviewModels[VenteInfo[i][Item]]);
			        format(string,sizeof(string),"Vente n°%d: %d %s~n~Prix : %d$ / unité~n~Vendeur : %s",i,VenteInfo[i][Amount],GetNameObject(VenteInfo[i][Item]),VenteInfo[i][Prix],VenteInfo[i][Pseudo]);
					ConvertEncoding(string);
					PlayerTextDrawSetString(playerid,TD_HDV[playerid][i + 23],string);
					PlayerTextDrawShow(playerid,TD_HDV[playerid][i + 7]);
					PlayerTextDrawShow(playerid,TD_HDV[playerid][i + 17]);
			        PlayerTextDrawShow(playerid,TD_HDV[playerid][i + 23]);
				}
			}
		}
		format(string,sizeof(string),"Page %d/%d",page[playerid],maxpage);
		PlayerTextDrawSetString(playerid,TD_HDV[playerid][6],string);
	}
	PlayerTextDrawShow(playerid,TD_HDV[playerid][29]);
	SelectTextDraw(playerid,rouge);
	hdvtd[playerid] = true;
	return 1;
}
stock HideHDV(playerid)
{
	for(new i = 29; i > 7; i--) PlayerTextDrawHide(playerid,TD_HDV[playerid][i]);
	hdvtd[playerid] = false;
	page[playerid] = 0;
	CancelSelectTextDraw(playerid);
}
stock NumVentes()
{
	new value;
	for(new i; i < MAX_VENTES ; i++)
	{
	    if(VenteInfo[i][Item] != 0) value ++;
	}
	return value;
}
stock MaxPlayerPlaces(playerid)
{
	new value;
	switch(PlayerInfo[playerid][pSac])
	{
		case 1: value = 12;
		case 2: value = 18;
		case 3: value = 24;
		default: value = 6;
	}
	return value;
}
IsNumeric(const string[])
{
        for (new i = 0, j = strlen(string); i < j; i++)
        {
                if (string[i] > '9' || string[i] < '0') return 0;
        }
        return 1;
}
stock udb_hash(buf[])
{
	new length=strlen(buf);
	new s1 = 1;
	new s2 = 0;
	new n;
	for (n=0; n<length; n++)
	{
		s1 = (s1 + buf[n]) % 65521;
		s2 = (s2 + s1) % 65521;
	}
	return (s2 << 16) + s1;
}
ReturnUser(text[], playerid = INVALID_PLAYER_ID)
{
        new pos = 0;
        while (text[pos] < 0x21) // Strip out leading spaces
        {
                if (text[pos] == 0) return INVALID_PLAYER_ID; // No passed text
                pos++;
        }
        new userid = INVALID_PLAYER_ID;
        if (IsNumeric(text[pos])) // Check whole passed string
        {
                // If they have a numeric name you have a problem (although names are checked on id failure)
                userid = strval(text[pos]);
                if (userid >=0 && userid < MAX_PLAYERS)
                {
                        if(!IsPlayerConnected(userid))
                        {
                                /*if (playerid != INVALID_PLAYER_ID)
                                {
                                        SendClientMessage(playerid, 0xFF0000AA, "User not connected");
                                }*/
                                userid = INVALID_PLAYER_ID;
                        }
                        else
                        {
                                return userid; // A player was found
                        }
                }
                /*else
                {
                        if (playerid != INVALID_PLAYER_ID)
                        {
                                SendClientMessage(playerid, 0xFF0000AA, "Invalid user ID");
                        }
                        userid = INVALID_PLAYER_ID;
                }
                return userid;*/
                // Removed for fallthrough code
        }
        // They entered [part of] a name or the id search failed (check names just incase)
        new len = strlen(text[pos]);
        new count = 0;
        new name[MAX_PLAYER_NAME];
        for (new i = 0; i < MAX_PLAYERS; i++)
        {
                if (IsPlayerConnected(i))
                {
                        GetPlayerName(i, name, sizeof (name));
                        if (strcmp(name, text[pos], true, len) == 0) // Check segment of name
                        {
                                if (len == strlen(name)) // Exact match
                                {
                                        return i; // Return the exact player on an exact match
                                        // Otherwise if there are two players:
                                        // Me and MeYou any time you entered Me it would find both
                                        // And never be able to return just Me's id
                                }
                                else // Partial match
                                {
                                        count++;
                                        userid = i;
                                }
                        }
                }
        }
        if (count != 1)
        {
                if (playerid != INVALID_PLAYER_ID)
                {
                        if (count)
                        {
                                SendClientMessage(playerid, 0xFF0000AA, "Multiple users found, please narrow earch");
                        }
                        else
                        {
                                SendClientMessage(playerid, 0xFF0000AA, "No matching user found");
                        }
                }
                userid = INVALID_PLAYER_ID;
        }
        return userid; // INVALID_USER_ID for bad return
}
stock UserPath(playerid)
{
	new string[128];
	format(string,sizeof(string),PATH,GetName(playerid));
	print("UserPath");
	return string;
}
stock VentePath(venteid)
{
	new string[128];
	format(string,sizeof(string),VENTEFILE,venteid);
	return string;
}
stock SaveAllVentes()
{
	for(new i; i < MAX_VENTES; i++)
	{
	    if(VenteInfo[i][Item] != 0)
	    {
	        new INI:File = INI_Open(VentePath(i));
			INI_SetTag(File,"data");
			INI_WriteInt(File,"ID",VenteInfo[i][ID]);
			INI_WriteInt(File,"Item",VenteInfo[i][Item]);
			INI_WriteString(File,"Pseudo",VenteInfo[i][Pseudo]);
			INI_WriteInt(File,"Prix",VenteInfo[i][Prix]);
			INI_Close(File);
		}
	}
	return 1;
}
stock ConvertEncoding(string[])
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
		// In packed strings nothing is over 255.
		for (new i = 0, len = strlen(string); i != len; ++i)
		{
			string{i} = scRealChars[string{i}];
		}
	}
	else
	{
		for (new i = 0, len = strlen(string), ch; i != len; ++i)
		{
			// Check if this character is in our reduced range.
			if (0 <= (ch = string[i]) < 256)
			{
				string[i] = scRealChars[ch];
			}
		}
	}
}

stock ShowNews(playerid)
{
	new string[1024];
	strcat(string,"\t\t{33FFFF}Liste de la dernière mise à jour faite le {0000CC}\n\n"DateMaj);
	strcat(string," - Début du serveur");
	ShowPlayerDialog(playerid,2,DIALOG_STYLE_MSGBOX,"{33CC00}Nouveautés",string,"OK","QUITTER");
}
stock IsCaseEmpty(playerid,id)
{
	if(PlayerInventory[playerid][id][Item] != 0 && PlayerInventory[playerid][id][Nombre] != 0)
	{
	    return false;
	}
	else
	{
	    return true;
	}
}
stock IsInventoryFully(playerid)
{
	new total,value;
	for(new i;i<MaxPlayerPlaces(playerid);i++)
	{
		if(IsCaseEmpty(playerid,i))
		{
		    total++;
		}
	}
	if(total == 0) value = -1; // Inventaire Plein retourne -1
	else
	{
	    for(new i;i<MaxPlayerPlaces(playerid);i++)
	    {
	        if(IsCaseEmpty(playerid,i))
	        {
	            value = i; // Inventaire pas plein retourne la première case vide
	            break;
			}
		}
	}
	return value;
}
stock RemoveItem(playerid,item,amount)
{
	new value = -1;
	for(new i;i<MaxPlayerPlaces(playerid);i++)
	{
	    if(PlayerInventory[playerid][i][Item] == item)
	    {
	        PlayerInventory[playerid][i][Nombre] -= amount;
	        if(PlayerInventory[playerid][i][Nombre] < 1)
	        {
	            PlayerInventory[playerid][i][Nombre] = 0;
				PlayerInventory[playerid][i][Item] = 0;
			}
	        value = i;
		}
	}
	return value;
}
stock ShowInventoryTD(playerid)
{
	new value;
	switch(PlayerInfo[playerid][pSac])
	{
	    case 1: value = 14;
	    case 2: value = 20;
		case 3: value = 24;
		default: value = 8;
	}
	for(new i;i<value;i++)
	{
	    PlayerTextDrawSetPreviewModel(playerid,TD_Inventory[playerid][i+2],PreviewModels[PlayerInventory[playerid][i][Item]]);
 		PlayerTextDrawShow(playerid,TD_Inventory[playerid][i]);
	}
	SelectTextDraw(playerid,cyan);
	InventoryTDShowed[playerid] = true;
}
stock CreateObjectReceivedTD(playerid)
{
	TD_ObjectReceived[playerid][0] = CreatePlayerTextDraw(playerid, 209.666671, 136.488845, "box");
	PlayerTextDrawLetterSize(playerid, TD_ObjectReceived[playerid][0], 0.000000, 18.700000);
	PlayerTextDrawTextSize(playerid, TD_ObjectReceived[playerid][0], 422.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, TD_ObjectReceived[playerid][0], 1);
	PlayerTextDrawColor(playerid, TD_ObjectReceived[playerid][0], -1);
	PlayerTextDrawUseBox(playerid, TD_ObjectReceived[playerid][0], 1);
	PlayerTextDrawBoxColor(playerid, TD_ObjectReceived[playerid][0], -1378294017);
	PlayerTextDrawSetShadow(playerid, TD_ObjectReceived[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, TD_ObjectReceived[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_ObjectReceived[playerid][0], 255);
	PlayerTextDrawFont(playerid, TD_ObjectReceived[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, TD_ObjectReceived[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, TD_ObjectReceived[playerid][0], 0);

	TD_ObjectReceived[playerid][1] = CreatePlayerTextDraw(playerid, 255.499908, 136.633270, "Rien");
	PlayerTextDrawLetterSize(playerid, TD_ObjectReceived[playerid][1], 0.303666, 1.367703);
	PlayerTextDrawTextSize(playerid, TD_ObjectReceived[playerid][1], 0.000000, 92.000000);
	PlayerTextDrawAlignment(playerid, TD_ObjectReceived[playerid][1], 2);
	PlayerTextDrawColor(playerid, TD_ObjectReceived[playerid][1], -1);
	PlayerTextDrawUseBox(playerid, TD_ObjectReceived[playerid][1], 1);
	PlayerTextDrawBoxColor(playerid, TD_ObjectReceived[playerid][1], 100);
	PlayerTextDrawSetShadow(playerid, TD_ObjectReceived[playerid][1], 1);
	PlayerTextDrawSetOutline(playerid, TD_ObjectReceived[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_ObjectReceived[playerid][1], 255);
	PlayerTextDrawFont(playerid, TD_ObjectReceived[playerid][1], 2);
	PlayerTextDrawSetProportional(playerid, TD_ObjectReceived[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, TD_ObjectReceived[playerid][1], 1);

	TD_ObjectReceived[playerid][2] = CreatePlayerTextDraw(playerid, 213.333312, 177.685256, "");
	PlayerTextDrawLetterSize(playerid, TD_ObjectReceived[playerid][2], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TD_ObjectReceived[playerid][2], 90.000000, 90.000000);
	PlayerTextDrawAlignment(playerid, TD_ObjectReceived[playerid][2], 1);
	PlayerTextDrawColor(playerid, TD_ObjectReceived[playerid][2], -1);
	PlayerTextDrawSetShadow(playerid, TD_ObjectReceived[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, TD_ObjectReceived[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_ObjectReceived[playerid][2], 200);
	PlayerTextDrawFont(playerid, TD_ObjectReceived[playerid][2], 5);
	PlayerTextDrawSetProportional(playerid, TD_ObjectReceived[playerid][2], 0);
	PlayerTextDrawSetShadow(playerid, TD_ObjectReceived[playerid][2], 0);
	PlayerTextDrawSetPreviewModel(playerid, TD_ObjectReceived[playerid][2], 1484);
	PlayerTextDrawSetPreviewRot(playerid, TD_ObjectReceived[playerid][2], 0.000000, 0.000000, 0.000000, 1.000000);

	TD_ObjectReceived[playerid][3] = CreatePlayerTextDraw(playerid, 365.666809, 196.222183, "Rien");
	PlayerTextDrawLetterSize(playerid, TD_ObjectReceived[playerid][3], 0.427333, 1.599999);
	PlayerTextDrawAlignment(playerid, TD_ObjectReceived[playerid][3], 2);
	PlayerTextDrawColor(playerid, TD_ObjectReceived[playerid][3], 8388863);
	PlayerTextDrawSetShadow(playerid, TD_ObjectReceived[playerid][3], 1);
	PlayerTextDrawSetOutline(playerid, TD_ObjectReceived[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_ObjectReceived[playerid][3], 255);
	PlayerTextDrawFont(playerid, TD_ObjectReceived[playerid][3], 3);
	PlayerTextDrawSetProportional(playerid, TD_ObjectReceived[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, TD_ObjectReceived[playerid][3], 1);

	TD_ObjectReceived[playerid][4] = CreatePlayerTextDraw(playerid, 317.666687, 288.725982, "Fermer");
	PlayerTextDrawLetterSize(playerid, TD_ObjectReceived[playerid][4], 0.400000, 1.600000);
	PlayerTextDrawTextSize(playerid, TD_ObjectReceived[playerid][4], 0.000000, 61.000000);
	PlayerTextDrawAlignment(playerid, TD_ObjectReceived[playerid][4], 2);
	PlayerTextDrawColor(playerid, TD_ObjectReceived[playerid][4], -1);
	PlayerTextDrawUseBox(playerid, TD_ObjectReceived[playerid][4], 1);
	PlayerTextDrawBoxColor(playerid, TD_ObjectReceived[playerid][4], 50);
	PlayerTextDrawSetShadow(playerid, TD_ObjectReceived[playerid][4], 1);
	PlayerTextDrawSetOutline(playerid, TD_ObjectReceived[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_ObjectReceived[playerid][4], 255);
	PlayerTextDrawFont(playerid, TD_ObjectReceived[playerid][4], 1);
	PlayerTextDrawSetProportional(playerid, TD_ObjectReceived[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid, TD_ObjectReceived[playerid][4], 1);
	PlayerTextDrawSetSelectable(playerid, TD_ObjectReceived[playerid][4], true);
}
stock CreateTDBesoins(playerid)
{
	TD_Besoins[playerid][0] = CreatePlayerTextDraw(playerid, 22.235307, 136.333358, "box");
	PlayerTextDrawLetterSize(playerid, TD_Besoins[playerid][0], 0.000000, 20.822488);
	PlayerTextDrawTextSize(playerid, TD_Besoins[playerid][0], 153.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, TD_Besoins[playerid][0], 1);
	PlayerTextDrawColor(playerid, TD_Besoins[playerid][0], -1);
	PlayerTextDrawUseBox(playerid, TD_Besoins[playerid][0], 1);
	PlayerTextDrawBoxColor(playerid, TD_Besoins[playerid][0], 190);
	PlayerTextDrawSetShadow(playerid, TD_Besoins[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, TD_Besoins[playerid][0], 61);
	PlayerTextDrawBackgroundColor(playerid, TD_Besoins[playerid][0], 255);
	PlayerTextDrawFont(playerid, TD_Besoins[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, TD_Besoins[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, TD_Besoins[playerid][0], 0);

	TD_Besoins[playerid][1] = CreatePlayerTextDraw(playerid, 62.235286, 135.750030, "Besoins");
	PlayerTextDrawLetterSize(playerid, TD_Besoins[playerid][1], 0.350117, 1.203333);
	PlayerTextDrawAlignment(playerid, TD_Besoins[playerid][1], 1);
	PlayerTextDrawColor(playerid, TD_Besoins[playerid][1], -1);
	PlayerTextDrawSetShadow(playerid, TD_Besoins[playerid][1], 7);
	PlayerTextDrawSetOutline(playerid, TD_Besoins[playerid][1], 1);
	PlayerTextDrawBackgroundColor(playerid, TD_Besoins[playerid][1], 255);
	PlayerTextDrawFont(playerid, TD_Besoins[playerid][1], 3);
	PlayerTextDrawSetProportional(playerid, TD_Besoins[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, TD_Besoins[playerid][1], 7);

	Besoins[playerid][0] = CreateProgressBar(26.843263, 186.499969,_,_,rouge,100);

	TD_Besoins[playerid][2] = CreatePlayerTextDraw(playerid, 25.529392, 165.500061, "Faim");
	PlayerTextDrawLetterSize(playerid, TD_Besoins[playerid][2], 0.400000, 1.600000);
	PlayerTextDrawAlignment(playerid, TD_Besoins[playerid][2], 1);
	PlayerTextDrawColor(playerid, TD_Besoins[playerid][2], -1);
	PlayerTextDrawSetShadow(playerid, TD_Besoins[playerid][2], 2);
	PlayerTextDrawSetOutline(playerid, TD_Besoins[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_Besoins[playerid][2], 255);
	PlayerTextDrawFont(playerid, TD_Besoins[playerid][2], 0);
	PlayerTextDrawSetProportional(playerid, TD_Besoins[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, TD_Besoins[playerid][2], 2);

	Besoins[playerid][1] = CreateProgressBar(26.843263,  224.416671,_,_,rouge,100);

	TD_Besoins[playerid][5] = CreatePlayerTextDraw(playerid, 24.117624, 202.250045, "Soif");
	PlayerTextDrawLetterSize(playerid, TD_Besoins[playerid][3], 0.400000, 1.600000);
	PlayerTextDrawAlignment(playerid, TD_Besoins[playerid][3], 1);
	PlayerTextDrawColor(playerid, TD_Besoins[playerid][3], -1);
	PlayerTextDrawSetShadow(playerid, TD_Besoins[playerid][3], 2);
	PlayerTextDrawSetOutline(playerid, TD_Besoins[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_Besoins[playerid][3], 255);
	PlayerTextDrawFont(playerid, TD_Besoins[playerid][3], 0);
	PlayerTextDrawSetProportional(playerid, TD_Besoins[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, TD_Besoins[playerid][3], 2);

	Besoins[playerid][1] = CreateProgressBar(26.843263,  261.749908,_,_,rouge,100);

	TD_Besoins[playerid][4] = CreatePlayerTextDraw(playerid, 23.176446, 239.583374, "Fatigue");
	PlayerTextDrawLetterSize(playerid, TD_Besoins[playerid][4], 0.388235, 1.716665);
	PlayerTextDrawAlignment(playerid, TD_Besoins[playerid][4], 1);
	PlayerTextDrawColor(playerid, TD_Besoins[playerid][4], -1);
	PlayerTextDrawSetShadow(playerid, TD_Besoins[playerid][4], 2);
	PlayerTextDrawSetOutline(playerid, TD_Besoins[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_Besoins[playerid][4], 255);
	PlayerTextDrawFont(playerid, TD_Besoins[playerid][4], 0);
	PlayerTextDrawSetProportional(playerid, TD_Besoins[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid, TD_Besoins[playerid][4], 2);

	Besoins[playerid][1] = CreateProgressBar(26.843263, 297.3332821,_,_,rouge,100);

	TD_Besoins[playerid][5] = CreatePlayerTextDraw(playerid, 22.235269, 275.750061, "Humeur");
	PlayerTextDrawLetterSize(playerid, TD_Besoins[playerid][5], 0.388235, 1.716665);
	PlayerTextDrawAlignment(playerid, TD_Besoins[playerid][5], 1);
	PlayerTextDrawColor(playerid, TD_Besoins[playerid][5], -1);
	PlayerTextDrawSetShadow(playerid, TD_Besoins[playerid][5], 2);
	PlayerTextDrawSetOutline(playerid, TD_Besoins[playerid][5], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_Besoins[playerid][5], 255);
	PlayerTextDrawFont(playerid, TD_Besoins[playerid][5], 0);
	PlayerTextDrawSetProportional(playerid, TD_Besoins[playerid][5], 1);
	PlayerTextDrawSetShadow(playerid, TD_Besoins[playerid][5], 2);

	TD_Besoins[playerid][6] = CreatePlayerTextDraw(playerid, 35.823558, 185.333343, "");
	PlayerTextDrawLetterSize(playerid, TD_Besoins[playerid][6], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TD_Besoins[playerid][6], 62.000000, -52.000000);
	PlayerTextDrawAlignment(playerid, TD_Besoins[playerid][6], 1);
	PlayerTextDrawColor(playerid, TD_Besoins[playerid][6], -1);
	PlayerTextDrawSetShadow(playerid, TD_Besoins[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, TD_Besoins[playerid][6], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_Besoins[playerid][6], 0);
	PlayerTextDrawFont(playerid, TD_Besoins[playerid][6], 5);
	PlayerTextDrawSetProportional(playerid, TD_Besoins[playerid][6], 0);
	PlayerTextDrawSetShadow(playerid, TD_Besoins[playerid][6], 0);
	PlayerTextDrawSetPreviewModel(playerid, TD_Besoins[playerid][6], 2880);
	PlayerTextDrawSetPreviewRot(playerid, TD_Besoins[playerid][6], 90.000000, 45.000000, 0.000000, 1.600000);

	TD_Besoins[playerid][7] = CreatePlayerTextDraw(playerid, 39.017662, 234.333297, "");
	PlayerTextDrawLetterSize(playerid, TD_Besoins[playerid][7], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TD_Besoins[playerid][7], 62.000000, -52.000000);
	PlayerTextDrawAlignment(playerid, TD_Besoins[playerid][7], 1);
	PlayerTextDrawColor(playerid, TD_Besoins[playerid][7], -1);
	PlayerTextDrawSetShadow(playerid, TD_Besoins[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, TD_Besoins[playerid][7], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_Besoins[playerid][7], 0);
	PlayerTextDrawFont(playerid, TD_Besoins[playerid][7], 5);
	PlayerTextDrawSetProportional(playerid, TD_Besoins[playerid][7], 0);
	PlayerTextDrawSetShadow(playerid, TD_Besoins[playerid][7], 0);
	PlayerTextDrawSetPreviewModel(playerid, TD_Besoins[playerid][7], 1667);
	PlayerTextDrawSetPreviewRot(playerid, TD_Besoins[playerid][7], 0.000000, 180.000000, 0.000000, 1.600000);

	TD_Besoins[playerid][8] = CreatePlayerTextDraw(playerid, 47.236705, 274.583374, "");
	PlayerTextDrawLetterSize(playerid, TD_Besoins[playerid][8], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TD_Besoins[playerid][8], 62.000000, -52.000000);
	PlayerTextDrawAlignment(playerid, TD_Besoins[playerid][8], 1);
	PlayerTextDrawColor(playerid, TD_Besoins[playerid][8], -1);
	PlayerTextDrawSetShadow(playerid, TD_Besoins[playerid][8], 0);
	PlayerTextDrawSetOutline(playerid, TD_Besoins[playerid][8], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_Besoins[playerid][8], 0);
	PlayerTextDrawFont(playerid, TD_Besoins[playerid][8], 5);
	PlayerTextDrawSetProportional(playerid, TD_Besoins[playerid][8], 0);
	PlayerTextDrawSetShadow(playerid, TD_Besoins[playerid][8], 0);
	PlayerTextDrawSetPreviewModel(playerid, TD_Besoins[playerid][8], 14866);
	PlayerTextDrawSetPreviewRot(playerid, TD_Besoins[playerid][8], 0.000000, 180.000000, 90.000000, 1.600000);

	TD_Besoins[playerid][9] = CreatePlayerTextDraw(playerid, 40.507274, 309.443359, "");
	PlayerTextDrawLetterSize(playerid, TD_Besoins[playerid][9], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TD_Besoins[playerid][9], 62.000000, -52.000000);
	PlayerTextDrawAlignment(playerid, TD_Besoins[playerid][9], 1);
	PlayerTextDrawColor(playerid, TD_Besoins[playerid][9], -1);
	PlayerTextDrawSetShadow(playerid, TD_Besoins[playerid][9], 0);
	PlayerTextDrawSetOutline(playerid, TD_Besoins[playerid][9], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_Besoins[playerid][9], 0);
	PlayerTextDrawFont(playerid, TD_Besoins[playerid][9], 5);
	PlayerTextDrawSetProportional(playerid, TD_Besoins[playerid][9], 0);
	PlayerTextDrawSetShadow(playerid, TD_Besoins[playerid][9], 0);
	PlayerTextDrawSetPreviewModel(playerid, TD_Besoins[playerid][9], 18963);
	PlayerTextDrawSetPreviewRot(playerid, TD_Besoins[playerid][9], 0.000000, 180.000000, 90.000000, 1.600000);
}
stock HideInventoryTD(playerid)
{
	for(new i;i<MaxInventoryTD;i++) PlayerTextDrawHide(playerid,TD_Inventory[playerid][i]);
	CancelSelectTextDraw(playerid);
	InventoryTDShowed[playerid] = false;
}
stock IsAlreadySameItem(playerid,item)
{
	new value;
	for(new i;i<MaxPlayerPlaces(playerid);i++)
	{
	    if(PlayerInventory[playerid][i][Item] == item)
		{
		    value = i;
		    break;
		}
		else value = -1;
	}
	return value;
}
stock GivePlayerObject(playerid,item,amount)
{
	if(IsAlreadySameItem(playerid,item) == -1 && IsInventoryFully(playerid) == -1) return SendClientMessage(playerid,rouge,"Votre inventaire est plein !");
	else
	{
		new value;
		if(IsAlreadySameItem(playerid,item) != -1) value = IsAlreadySameItem(playerid,item);
		if(IsAlreadySameItem(playerid,item) == -1 && IsInventoryFully(playerid) != -1) value = IsInventoryFully(playerid);
		ShowObjectReceivedTD(playerid,item,amount);
		PlayerInventory[playerid][value][Item] = item;
		PlayerInventory[playerid][value][Nombre] += amount;
		if(PlayerInventory[playerid][value][Nombre] == 0)
		{
		    PlayerInventory[playerid][value][Item] = 0;
		    PlayerInventory[playerid][value][Nombre] = 0;
		}
	}
	return 1;
}
stock SavePlayer(playerid)
{
	if(IsGuest[playerid] == false)
	{
		new INI:File = INI_Open(UserPath(playerid)),Float:x,Float:y,Float:z,Float:a;
		GetPlayerPos(playerid,x,y,z);
		GetPlayerFacingAngle(playerid,a);
		INI_SetTag(File,"data");
		INI_WriteInt(File,"Password",udb_hash(mdp[playerid]));
		INI_WriteInt(File,"Admin",PlayerInfo[playerid][pAdmin]);
		INI_WriteFloat(File,"X",x);
		INI_WriteFloat(File,"Y",y);
		INI_WriteFloat(File,"Z",z);
		INI_WriteFloat(File,"A",a);
		INI_WriteInt(File,"Sac",PlayerInfo[playerid][pSac]);
		for(new i;i<MaxPlayerPlaces(playerid);i++)
		{
			new string[256],value[256];
		    format(string,sizeof(string),"Case_%d",i);
			format(value,sizeof(value),"%d %d",PlayerInventory[playerid][i][Item],PlayerInventory[playerid][i][Nombre]);
			INI_WriteString(File,string,value);
		}
		INI_Close(File);
		SendClientMessage(playerid,gris,"[Save] Compte sauvegardé avec succès !");
	}
	else SendClientMessage(playerid,gris,"[Save] Vos données n'ont pas été sauvegardées car vous jouiez en invité !");
}
stock CreateInventoryTD(playerid)
{
	TD_Inventory[playerid][0] = CreatePlayerTextDraw(playerid, 88.000022, 73.437065, "box");
	PlayerTextDrawLetterSize(playerid, TD_Inventory[playerid][0], 0.000000, 37.133331);
	PlayerTextDrawTextSize(playerid, TD_Inventory[playerid][0], 550.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, TD_Inventory[playerid][0], 1);
	PlayerTextDrawColor(playerid, TD_Inventory[playerid][0], -1);
	PlayerTextDrawUseBox(playerid, TD_Inventory[playerid][0], 1);
	PlayerTextDrawBoxColor(playerid, TD_Inventory[playerid][0], 125);
	PlayerTextDrawSetShadow(playerid, TD_Inventory[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, TD_Inventory[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_Inventory[playerid][0], 255);
	PlayerTextDrawFont(playerid, TD_Inventory[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, TD_Inventory[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, TD_Inventory[playerid][0], 0);

	TD_Inventory[playerid][1] = CreatePlayerTextDraw(playerid, 89.666641, 72.192611, "Inventaire");
	PlayerTextDrawLetterSize(playerid, TD_Inventory[playerid][1], 0.460666, 2.039703);
	PlayerTextDrawAlignment(playerid, TD_Inventory[playerid][1], 1);
	PlayerTextDrawColor(playerid, TD_Inventory[playerid][1], -1);
	PlayerTextDrawSetShadow(playerid, TD_Inventory[playerid][1], 2);
	PlayerTextDrawSetOutline(playerid, TD_Inventory[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_Inventory[playerid][1], 255);
	PlayerTextDrawFont(playerid, TD_Inventory[playerid][1], 0);
	PlayerTextDrawSetProportional(playerid, TD_Inventory[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, TD_Inventory[playerid][1], 2);

	TD_Inventory[playerid][2] = CreatePlayerTextDraw(playerid, 105.566696, 111.596206, "");
	PlayerTextDrawLetterSize(playerid, TD_Inventory[playerid][2], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TD_Inventory[playerid][2], 60.000000, 59.000000);
	PlayerTextDrawAlignment(playerid, TD_Inventory[playerid][2], 1);
	PlayerTextDrawColor(playerid, TD_Inventory[playerid][2], -1);
	PlayerTextDrawSetShadow(playerid, TD_Inventory[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, TD_Inventory[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_Inventory[playerid][2], 100);
	PlayerTextDrawFont(playerid, TD_Inventory[playerid][2], 5);
	PlayerTextDrawSetProportional(playerid, TD_Inventory[playerid][2], 0);
	PlayerTextDrawSetShadow(playerid, TD_Inventory[playerid][2], 0);
	PlayerTextDrawSetSelectable(playerid, TD_Inventory[playerid][2], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_Inventory[playerid][2], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_Inventory[playerid][2], 0.000000, 0.000000, 0.000000, 1.000000);

	TD_Inventory[playerid][3] = CreatePlayerTextDraw(playerid, 179.266754, 112.025810, "");
	PlayerTextDrawLetterSize(playerid, TD_Inventory[playerid][3], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TD_Inventory[playerid][3], 60.000000, 59.000000);
	PlayerTextDrawAlignment(playerid, TD_Inventory[playerid][3], 1);
	PlayerTextDrawColor(playerid, TD_Inventory[playerid][3], -1);
	PlayerTextDrawSetShadow(playerid, TD_Inventory[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, TD_Inventory[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_Inventory[playerid][3], 100);
	PlayerTextDrawFont(playerid, TD_Inventory[playerid][3], 5);
	PlayerTextDrawSetProportional(playerid, TD_Inventory[playerid][3], 0);
	PlayerTextDrawSetShadow(playerid, TD_Inventory[playerid][3], 0);
	PlayerTextDrawSetSelectable(playerid, TD_Inventory[playerid][3], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_Inventory[playerid][3], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_Inventory[playerid][3], 0.000000, 0.000000, 0.000000, 1.000000);

	TD_Inventory[playerid][4] = CreatePlayerTextDraw(playerid, 253.933532, 111.396186, "");
	PlayerTextDrawLetterSize(playerid, TD_Inventory[playerid][4], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TD_Inventory[playerid][4], 60.000000, 59.000000);
	PlayerTextDrawAlignment(playerid, TD_Inventory[playerid][4], 1);
	PlayerTextDrawColor(playerid, TD_Inventory[playerid][4], -1);
	PlayerTextDrawSetShadow(playerid, TD_Inventory[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, TD_Inventory[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_Inventory[playerid][4], 100);
	PlayerTextDrawFont(playerid, TD_Inventory[playerid][4], 5);
	PlayerTextDrawSetProportional(playerid, TD_Inventory[playerid][4], 0);
	PlayerTextDrawSetShadow(playerid, TD_Inventory[playerid][4], 0);
	PlayerTextDrawSetSelectable(playerid, TD_Inventory[playerid][4], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_Inventory[playerid][4], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_Inventory[playerid][4], 0.000000, 0.000000, 0.000000, 1.000000);

	TD_Inventory[playerid][5] = CreatePlayerTextDraw(playerid, 328.200195, 112.025810, "");
	PlayerTextDrawLetterSize(playerid, TD_Inventory[playerid][5], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TD_Inventory[playerid][5], 60.000000, 59.000000);
	PlayerTextDrawAlignment(playerid, TD_Inventory[playerid][5], 1);
	PlayerTextDrawColor(playerid, TD_Inventory[playerid][5], -1);
	PlayerTextDrawSetShadow(playerid, TD_Inventory[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, TD_Inventory[playerid][5], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_Inventory[playerid][5], 100);
	PlayerTextDrawFont(playerid, TD_Inventory[playerid][5], 5);
	PlayerTextDrawSetProportional(playerid, TD_Inventory[playerid][5], 0);
	PlayerTextDrawSetShadow(playerid, TD_Inventory[playerid][5], 0);
	PlayerTextDrawSetSelectable(playerid, TD_Inventory[playerid][5], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_Inventory[playerid][5], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_Inventory[playerid][5], 0.000000, 0.000000, 0.000000, 1.000000);

	TD_Inventory[playerid][6] = CreatePlayerTextDraw(playerid, 402.166900, 112.340644, "");
	PlayerTextDrawLetterSize(playerid, TD_Inventory[playerid][6], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TD_Inventory[playerid][6], 60.000000, 59.000000);
	PlayerTextDrawAlignment(playerid, TD_Inventory[playerid][6], 1);
	PlayerTextDrawColor(playerid, TD_Inventory[playerid][6], -1);
	PlayerTextDrawSetShadow(playerid, TD_Inventory[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, TD_Inventory[playerid][6], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_Inventory[playerid][6], 100);
	PlayerTextDrawFont(playerid, TD_Inventory[playerid][6], 5);
	PlayerTextDrawSetProportional(playerid, TD_Inventory[playerid][6], 0);
	PlayerTextDrawSetShadow(playerid, TD_Inventory[playerid][6], 0);
	PlayerTextDrawSetSelectable(playerid, TD_Inventory[playerid][6], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_Inventory[playerid][6], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_Inventory[playerid][6], 0.000000, 0.000000, 0.000000, 1.000000);

	TD_Inventory[playerid][7] = CreatePlayerTextDraw(playerid, 475.200256, 111.611000, "");
	PlayerTextDrawLetterSize(playerid, TD_Inventory[playerid][7], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TD_Inventory[playerid][7], 60.000000, 59.000000);
	PlayerTextDrawAlignment(playerid, TD_Inventory[playerid][7], 1);
	PlayerTextDrawColor(playerid, TD_Inventory[playerid][7], -1);
	PlayerTextDrawSetShadow(playerid, TD_Inventory[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, TD_Inventory[playerid][7], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_Inventory[playerid][7], 100);
	PlayerTextDrawFont(playerid, TD_Inventory[playerid][7], 5);
	PlayerTextDrawSetProportional(playerid, TD_Inventory[playerid][7], 0);
	PlayerTextDrawSetShadow(playerid, TD_Inventory[playerid][7], 0);
	PlayerTextDrawSetSelectable(playerid, TD_Inventory[playerid][7], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_Inventory[playerid][7], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_Inventory[playerid][7], 0.000000, 0.000000, 0.000000, 1.000000);

	TD_Inventory[playerid][8] = CreatePlayerTextDraw(playerid, 106.200233, 187.851699, "");
	PlayerTextDrawLetterSize(playerid, TD_Inventory[playerid][8], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TD_Inventory[playerid][8], 60.000000, 59.000000);
	PlayerTextDrawAlignment(playerid, TD_Inventory[playerid][8], 1);
	PlayerTextDrawColor(playerid, TD_Inventory[playerid][8], -1);
	PlayerTextDrawSetShadow(playerid, TD_Inventory[playerid][8], 0);
	PlayerTextDrawSetOutline(playerid, TD_Inventory[playerid][8], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_Inventory[playerid][8], 100);
	PlayerTextDrawFont(playerid, TD_Inventory[playerid][8], 5);
	PlayerTextDrawSetProportional(playerid, TD_Inventory[playerid][8], 0);
	PlayerTextDrawSetShadow(playerid, TD_Inventory[playerid][8], 0);
	PlayerTextDrawSetSelectable(playerid, TD_Inventory[playerid][8], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_Inventory[playerid][8], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_Inventory[playerid][8], 0.000000, 0.000000, 0.000000, 1.000000);

	TD_Inventory[playerid][9] = CreatePlayerTextDraw(playerid, 178.866882, 187.436904, "");
	PlayerTextDrawLetterSize(playerid, TD_Inventory[playerid][9], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TD_Inventory[playerid][9], 60.000000, 59.000000);
	PlayerTextDrawAlignment(playerid, TD_Inventory[playerid][9], 1);
	PlayerTextDrawColor(playerid, TD_Inventory[playerid][9], -1);
	PlayerTextDrawSetShadow(playerid, TD_Inventory[playerid][9], 0);
	PlayerTextDrawSetOutline(playerid, TD_Inventory[playerid][9], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_Inventory[playerid][9], 100);
	PlayerTextDrawFont(playerid, TD_Inventory[playerid][9], 5);
	PlayerTextDrawSetProportional(playerid, TD_Inventory[playerid][9], 0);
	PlayerTextDrawSetShadow(playerid, TD_Inventory[playerid][9], 0);
	PlayerTextDrawSetSelectable(playerid, TD_Inventory[playerid][9], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_Inventory[playerid][9], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_Inventory[playerid][9], 0.000000, 0.000000, 0.000000, 1.000000);

	TD_Inventory[playerid][10] = CreatePlayerTextDraw(playerid, 253.400238, 187.551712, "");
	PlayerTextDrawLetterSize(playerid, TD_Inventory[playerid][10], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TD_Inventory[playerid][10], 60.000000, 59.000000);
	PlayerTextDrawAlignment(playerid, TD_Inventory[playerid][10], 1);
	PlayerTextDrawColor(playerid, TD_Inventory[playerid][10], -1);
	PlayerTextDrawSetShadow(playerid, TD_Inventory[playerid][10], 0);
	PlayerTextDrawSetOutline(playerid, TD_Inventory[playerid][10], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_Inventory[playerid][10], 100);
	PlayerTextDrawFont(playerid, TD_Inventory[playerid][10], 5);
	PlayerTextDrawSetProportional(playerid, TD_Inventory[playerid][10], 0);
	PlayerTextDrawSetShadow(playerid, TD_Inventory[playerid][10], 0);
	PlayerTextDrawSetSelectable(playerid, TD_Inventory[playerid][10], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_Inventory[playerid][10], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_Inventory[playerid][10], 0.000000, 0.000000, 0.000000, 1.000000);

	TD_Inventory[playerid][11] = CreatePlayerTextDraw(playerid, 328.033538, 188.181335, "");
	PlayerTextDrawLetterSize(playerid, TD_Inventory[playerid][11], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TD_Inventory[playerid][11], 60.000000, 59.000000);
	PlayerTextDrawAlignment(playerid, TD_Inventory[playerid][11], 1);
	PlayerTextDrawColor(playerid, TD_Inventory[playerid][11], -1);
	PlayerTextDrawSetShadow(playerid, TD_Inventory[playerid][11], 0);
	PlayerTextDrawSetOutline(playerid, TD_Inventory[playerid][11], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_Inventory[playerid][11], 100);
	PlayerTextDrawFont(playerid, TD_Inventory[playerid][11], 5);
	PlayerTextDrawSetProportional(playerid, TD_Inventory[playerid][11], 0);
	PlayerTextDrawSetShadow(playerid, TD_Inventory[playerid][11], 0);
	PlayerTextDrawSetSelectable(playerid, TD_Inventory[playerid][11], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_Inventory[playerid][11], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_Inventory[playerid][11], 0.000000, 0.000000, 0.000000, 1.000000);

	TD_Inventory[playerid][12] = CreatePlayerTextDraw(playerid, 402.266906, 188.296127, "");
	PlayerTextDrawLetterSize(playerid, TD_Inventory[playerid][12], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TD_Inventory[playerid][12], 60.000000, 59.000000);
	PlayerTextDrawAlignment(playerid, TD_Inventory[playerid][12], 1);
	PlayerTextDrawColor(playerid, TD_Inventory[playerid][12], -1);
	PlayerTextDrawSetShadow(playerid, TD_Inventory[playerid][12], 0);
	PlayerTextDrawSetOutline(playerid, TD_Inventory[playerid][12], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_Inventory[playerid][12], 100);
	PlayerTextDrawFont(playerid, TD_Inventory[playerid][12], 5);
	PlayerTextDrawSetProportional(playerid, TD_Inventory[playerid][12], 0);
	PlayerTextDrawSetShadow(playerid, TD_Inventory[playerid][12], 0);
	PlayerTextDrawSetSelectable(playerid, TD_Inventory[playerid][12], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_Inventory[playerid][12], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_Inventory[playerid][12], 0.000000, 0.000000, 0.000000, 1.000000);

	TD_Inventory[playerid][13] = CreatePlayerTextDraw(playerid, 474.933532, 189.455383, "");
	PlayerTextDrawLetterSize(playerid, TD_Inventory[playerid][13], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TD_Inventory[playerid][13], 60.000000, 59.000000);
	PlayerTextDrawAlignment(playerid, TD_Inventory[playerid][13], 1);
	PlayerTextDrawColor(playerid, TD_Inventory[playerid][13], -1);
	PlayerTextDrawSetShadow(playerid, TD_Inventory[playerid][13], 0);
	PlayerTextDrawSetOutline(playerid, TD_Inventory[playerid][13], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_Inventory[playerid][13], 100);
	PlayerTextDrawFont(playerid, TD_Inventory[playerid][13], 5);
	PlayerTextDrawSetProportional(playerid, TD_Inventory[playerid][13], 0);
	PlayerTextDrawSetShadow(playerid, TD_Inventory[playerid][13], 0);
	PlayerTextDrawSetSelectable(playerid, TD_Inventory[playerid][13], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_Inventory[playerid][13], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_Inventory[playerid][13], 0.000000, 0.000000, 0.000000, 1.000000);

	TD_Inventory[playerid][14] = CreatePlayerTextDraw(playerid, 106.733558, 263.292388, "");
	PlayerTextDrawLetterSize(playerid, TD_Inventory[playerid][14], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TD_Inventory[playerid][14], 60.000000, 59.000000);
	PlayerTextDrawAlignment(playerid, TD_Inventory[playerid][14], 1);
	PlayerTextDrawColor(playerid, TD_Inventory[playerid][14], -1);
	PlayerTextDrawSetShadow(playerid, TD_Inventory[playerid][14], 0);
	PlayerTextDrawSetOutline(playerid, TD_Inventory[playerid][14], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_Inventory[playerid][14], 100);
	PlayerTextDrawFont(playerid, TD_Inventory[playerid][14], 5);
	PlayerTextDrawSetProportional(playerid, TD_Inventory[playerid][14], 0);
	PlayerTextDrawSetShadow(playerid, TD_Inventory[playerid][14], 0);
	PlayerTextDrawSetSelectable(playerid, TD_Inventory[playerid][14], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_Inventory[playerid][14], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_Inventory[playerid][14], 0.000000, 0.000000, 0.000000, 1.000000);

	TD_Inventory[playerid][15] = CreatePlayerTextDraw(playerid, 178.766876, 263.121917, "");
	PlayerTextDrawLetterSize(playerid, TD_Inventory[playerid][15], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TD_Inventory[playerid][15], 60.000000, 59.000000);
	PlayerTextDrawAlignment(playerid, TD_Inventory[playerid][15], 1);
	PlayerTextDrawColor(playerid, TD_Inventory[playerid][15], -1);
	PlayerTextDrawSetShadow(playerid, TD_Inventory[playerid][15], 0);
	PlayerTextDrawSetOutline(playerid, TD_Inventory[playerid][15], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_Inventory[playerid][15], 100);
	PlayerTextDrawFont(playerid, TD_Inventory[playerid][15], 5);
	PlayerTextDrawSetProportional(playerid, TD_Inventory[playerid][15], 0);
	PlayerTextDrawSetShadow(playerid, TD_Inventory[playerid][15], 0);
	PlayerTextDrawSetSelectable(playerid, TD_Inventory[playerid][15], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_Inventory[playerid][15], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_Inventory[playerid][15], 0.000000, 0.000000, 0.000000, 1.000000);

	TD_Inventory[playerid][16] = CreatePlayerTextDraw(playerid, 253.667160, 263.107116, "");
	PlayerTextDrawLetterSize(playerid, TD_Inventory[playerid][16], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TD_Inventory[playerid][16], 60.000000, 59.000000);
	PlayerTextDrawAlignment(playerid, TD_Inventory[playerid][16], 1);
	PlayerTextDrawColor(playerid, TD_Inventory[playerid][16], -1);
	PlayerTextDrawSetShadow(playerid, TD_Inventory[playerid][16], 0);
	PlayerTextDrawSetOutline(playerid, TD_Inventory[playerid][16], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_Inventory[playerid][16], 100);
	PlayerTextDrawFont(playerid, TD_Inventory[playerid][16], 5);
	PlayerTextDrawSetProportional(playerid, TD_Inventory[playerid][16], 0);
	PlayerTextDrawSetShadow(playerid, TD_Inventory[playerid][16], 0);
	PlayerTextDrawSetSelectable(playerid, TD_Inventory[playerid][16], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_Inventory[playerid][16], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_Inventory[playerid][16], 0.000000, 0.000000, 0.000000, 1.000000);

	TD_Inventory[playerid][17] = CreatePlayerTextDraw(playerid, 328.167236, 262.177520, "");
	PlayerTextDrawLetterSize(playerid, TD_Inventory[playerid][17], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TD_Inventory[playerid][17], 60.000000, 59.000000);
	PlayerTextDrawAlignment(playerid, TD_Inventory[playerid][17], 1);
	PlayerTextDrawColor(playerid, TD_Inventory[playerid][17], -1);
	PlayerTextDrawSetShadow(playerid, TD_Inventory[playerid][17], 0);
	PlayerTextDrawSetOutline(playerid, TD_Inventory[playerid][17], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_Inventory[playerid][17], 100);
	PlayerTextDrawFont(playerid, TD_Inventory[playerid][17], 5);
	PlayerTextDrawSetProportional(playerid, TD_Inventory[playerid][17], 0);
	PlayerTextDrawSetShadow(playerid, TD_Inventory[playerid][17], 0);
	PlayerTextDrawSetSelectable(playerid, TD_Inventory[playerid][17], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_Inventory[playerid][17], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_Inventory[playerid][17], 0.000000, 0.000000, 0.000000, 1.000000);

	TD_Inventory[playerid][18] = CreatePlayerTextDraw(playerid, 402.967315, 261.233123, "");
	PlayerTextDrawLetterSize(playerid, TD_Inventory[playerid][18], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TD_Inventory[playerid][18], 60.000000, 59.000000);
	PlayerTextDrawAlignment(playerid, TD_Inventory[playerid][18], 1);
	PlayerTextDrawColor(playerid, TD_Inventory[playerid][18], -1);
	PlayerTextDrawSetShadow(playerid, TD_Inventory[playerid][18], 0);
	PlayerTextDrawSetOutline(playerid, TD_Inventory[playerid][18], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_Inventory[playerid][18], 100);
	PlayerTextDrawFont(playerid, TD_Inventory[playerid][18], 5);
	PlayerTextDrawSetProportional(playerid, TD_Inventory[playerid][18], 0);
	PlayerTextDrawSetShadow(playerid, TD_Inventory[playerid][18], 0);
	PlayerTextDrawSetSelectable(playerid, TD_Inventory[playerid][18], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_Inventory[playerid][18], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_Inventory[playerid][18], 0.000000, 0.000000, 0.000000, 1.000000);

	TD_Inventory[playerid][19] = CreatePlayerTextDraw(playerid, 475.167297, 261.003540, "");
	PlayerTextDrawLetterSize(playerid, TD_Inventory[playerid][19], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TD_Inventory[playerid][19], 60.000000, 59.000000);
	PlayerTextDrawAlignment(playerid, TD_Inventory[playerid][19], 1);
	PlayerTextDrawColor(playerid, TD_Inventory[playerid][19], -1);
	PlayerTextDrawSetShadow(playerid, TD_Inventory[playerid][19], 0);
	PlayerTextDrawSetOutline(playerid, TD_Inventory[playerid][19], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_Inventory[playerid][19], 100);
	PlayerTextDrawFont(playerid, TD_Inventory[playerid][19], 5);
	PlayerTextDrawSetProportional(playerid, TD_Inventory[playerid][19], 0);
	PlayerTextDrawSetShadow(playerid, TD_Inventory[playerid][19], 0);
	PlayerTextDrawSetSelectable(playerid, TD_Inventory[playerid][19], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_Inventory[playerid][19], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_Inventory[playerid][19], 0.000000, 0.000000, 0.000000, 1.000000);

	TD_Inventory[playerid][20] = CreatePlayerTextDraw(playerid, 106.833938, 334.973602, "");
	PlayerTextDrawLetterSize(playerid, TD_Inventory[playerid][20], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TD_Inventory[playerid][20], 60.000000, 59.000000);
	PlayerTextDrawAlignment(playerid, TD_Inventory[playerid][20], 1);
	PlayerTextDrawColor(playerid, TD_Inventory[playerid][20], -1);
	PlayerTextDrawSetShadow(playerid, TD_Inventory[playerid][20], 0);
	PlayerTextDrawSetOutline(playerid, TD_Inventory[playerid][20], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_Inventory[playerid][20], 100);
	PlayerTextDrawFont(playerid, TD_Inventory[playerid][20], 5);
	PlayerTextDrawSetProportional(playerid, TD_Inventory[playerid][20], 0);
	PlayerTextDrawSetShadow(playerid, TD_Inventory[playerid][20], 0);
	PlayerTextDrawSetSelectable(playerid, TD_Inventory[playerid][20], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_Inventory[playerid][20], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_Inventory[playerid][20], 0.000000, 0.000000, 0.000000, 1.000000);

	TD_Inventory[playerid][21] = CreatePlayerTextDraw(playerid, 178.367309, 334.973571, "");
	PlayerTextDrawLetterSize(playerid, TD_Inventory[playerid][21], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TD_Inventory[playerid][21], 60.000000, 59.000000);
	PlayerTextDrawAlignment(playerid, TD_Inventory[playerid][21], 1);
	PlayerTextDrawColor(playerid, TD_Inventory[playerid][21], -1);
	PlayerTextDrawSetShadow(playerid, TD_Inventory[playerid][21], 0);
	PlayerTextDrawSetOutline(playerid, TD_Inventory[playerid][21], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_Inventory[playerid][21], 100);
	PlayerTextDrawFont(playerid, TD_Inventory[playerid][21], 5);
	PlayerTextDrawSetProportional(playerid, TD_Inventory[playerid][21], 0);
	PlayerTextDrawSetShadow(playerid, TD_Inventory[playerid][21], 0);
	PlayerTextDrawSetSelectable(playerid, TD_Inventory[playerid][21], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_Inventory[playerid][21], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_Inventory[playerid][21], 0.000000, 0.000000, 0.000000, 1.000000);

	TD_Inventory[playerid][22] = CreatePlayerTextDraw(playerid, 253.034011, 334.473541, "");
	PlayerTextDrawLetterSize(playerid, TD_Inventory[playerid][22], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TD_Inventory[playerid][22], 60.000000, 59.000000);
	PlayerTextDrawAlignment(playerid, TD_Inventory[playerid][22], 1);
	PlayerTextDrawColor(playerid, TD_Inventory[playerid][22], -1);
	PlayerTextDrawSetShadow(playerid, TD_Inventory[playerid][22], 0);
	PlayerTextDrawSetOutline(playerid, TD_Inventory[playerid][22], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_Inventory[playerid][22], 100);
	PlayerTextDrawFont(playerid, TD_Inventory[playerid][22], 5);
	PlayerTextDrawSetProportional(playerid, TD_Inventory[playerid][22], 0);
	PlayerTextDrawSetShadow(playerid, TD_Inventory[playerid][22], 0);
	PlayerTextDrawSetSelectable(playerid, TD_Inventory[playerid][22], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_Inventory[playerid][22], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_Inventory[playerid][22], 0.000000, 0.000000, 0.000000, 1.000000);

	TD_Inventory[playerid][23] = CreatePlayerTextDraw(playerid, 328.700683, 333.643920, "");
	PlayerTextDrawLetterSize(playerid, TD_Inventory[playerid][23], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TD_Inventory[playerid][23], 60.000000, 59.000000);
	PlayerTextDrawAlignment(playerid, TD_Inventory[playerid][23], 1);
	PlayerTextDrawColor(playerid, TD_Inventory[playerid][23], -1);
	PlayerTextDrawSetShadow(playerid, TD_Inventory[playerid][23], 0);
	PlayerTextDrawSetOutline(playerid, TD_Inventory[playerid][23], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_Inventory[playerid][23], 100);
	PlayerTextDrawFont(playerid, TD_Inventory[playerid][23], 5);
	PlayerTextDrawSetProportional(playerid, TD_Inventory[playerid][23], 0);
	PlayerTextDrawSetShadow(playerid, TD_Inventory[playerid][23], 0);
	PlayerTextDrawSetSelectable(playerid, TD_Inventory[playerid][23], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_Inventory[playerid][23], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_Inventory[playerid][23], 0.000000, 0.000000, 0.000000, 1.000000);

	TD_Inventory[playerid][24] = CreatePlayerTextDraw(playerid, 403.034027, 332.399414, "");
	PlayerTextDrawLetterSize(playerid, TD_Inventory[playerid][24], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TD_Inventory[playerid][24], 60.000000, 59.000000);
	PlayerTextDrawAlignment(playerid, TD_Inventory[playerid][24], 1);
	PlayerTextDrawColor(playerid, TD_Inventory[playerid][24], -1);
	PlayerTextDrawSetShadow(playerid, TD_Inventory[playerid][24], 0);
	PlayerTextDrawSetOutline(playerid, TD_Inventory[playerid][24], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_Inventory[playerid][24], 100);
	PlayerTextDrawFont(playerid, TD_Inventory[playerid][24], 5);
	PlayerTextDrawSetProportional(playerid, TD_Inventory[playerid][24], 0);
	PlayerTextDrawSetShadow(playerid, TD_Inventory[playerid][24], 0);
	PlayerTextDrawSetSelectable(playerid, TD_Inventory[playerid][24], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_Inventory[playerid][24], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_Inventory[playerid][24], 0.000000, 0.000000, 0.000000, 1.000000);

	TD_Inventory[playerid][25] = CreatePlayerTextDraw(playerid, 475.034057, 332.399353, "");
	PlayerTextDrawLetterSize(playerid, TD_Inventory[playerid][25], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TD_Inventory[playerid][25], 60.000000, 59.000000);
	PlayerTextDrawAlignment(playerid, TD_Inventory[playerid][25], 1);
	PlayerTextDrawColor(playerid, TD_Inventory[playerid][25], -1);
	PlayerTextDrawSetShadow(playerid, TD_Inventory[playerid][25], 0);
	PlayerTextDrawSetOutline(playerid, TD_Inventory[playerid][25], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_Inventory[playerid][25], 100);
	PlayerTextDrawFont(playerid, TD_Inventory[playerid][25], 5);
	PlayerTextDrawSetProportional(playerid, TD_Inventory[playerid][25], 0);
	PlayerTextDrawSetShadow(playerid, TD_Inventory[playerid][25], 0);
	PlayerTextDrawSetSelectable(playerid, TD_Inventory[playerid][25], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_Inventory[playerid][25], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_Inventory[playerid][25], 0.000000, 0.000000, 0.000000, 1.000000);

	TD_Inventory[playerid][26] = CreatePlayerTextDraw(playerid, 488.000030, 36.362949, "");
	PlayerTextDrawLetterSize(playerid, TD_Inventory[playerid][26], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TD_Inventory[playerid][26], 90.000000, 90.000000);
	PlayerTextDrawAlignment(playerid, TD_Inventory[playerid][26], 1);
	PlayerTextDrawColor(playerid, TD_Inventory[playerid][26], -1);
	PlayerTextDrawSetShadow(playerid, TD_Inventory[playerid][26], 0);
	PlayerTextDrawSetOutline(playerid, TD_Inventory[playerid][26], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_Inventory[playerid][26], 0);
	PlayerTextDrawFont(playerid, TD_Inventory[playerid][26], 5);
	PlayerTextDrawSetProportional(playerid, TD_Inventory[playerid][26], 0);
	PlayerTextDrawSetShadow(playerid, TD_Inventory[playerid][26], 0);
	PlayerTextDrawSetPreviewModel(playerid, TD_Inventory[playerid][26], 11745);
	PlayerTextDrawSetPreviewRot(playerid, TD_Inventory[playerid][26], -45.000000, 45.000000, 90.000000, 1.500000);
}
stock CreateLoginTD(playerid)
{
	new string[32];
	TD_Login[playerid][0] = CreatePlayerTextDraw(playerid, 1.300027, 1.433264, "box");
	PlayerTextDrawLetterSize(playerid, TD_Login[playerid][0], 0.000000, 49.481338);
	PlayerTextDrawTextSize(playerid, TD_Login[playerid][0], 693.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, TD_Login[playerid][0], 1);
	PlayerTextDrawColor(playerid, TD_Login[playerid][0], 255);
	PlayerTextDrawUseBox(playerid, TD_Login[playerid][0], 1);
	PlayerTextDrawBoxColor(playerid, TD_Login[playerid][0], 255);
	PlayerTextDrawSetShadow(playerid, TD_Login[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, TD_Login[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_Login[playerid][0], 255);
	PlayerTextDrawFont(playerid, TD_Login[playerid][0], 0);
	PlayerTextDrawSetProportional(playerid, TD_Login[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, TD_Login[playerid][0], 0);

	TD_Login[playerid][1] = CreatePlayerTextDraw(playerid, 511.535827, 302.752075, "Quitter");
	PlayerTextDrawLetterSize(playerid, TD_Login[playerid][1], 0.400000, 1.600000);
	PlayerTextDrawAlignment(playerid, TD_Login[playerid][1], 2);
	PlayerTextDrawColor(playerid, TD_Login[playerid][1], -1);
	PlayerTextDrawSetShadow(playerid, TD_Login[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, TD_Login[playerid][1], 5);
	PlayerTextDrawBackgroundColor(playerid, TD_Login[playerid][1], 255);
	PlayerTextDrawFont(playerid, TD_Login[playerid][1], 0);
	PlayerTextDrawSetProportional(playerid, TD_Login[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, TD_Login[playerid][1], 0);

	TD_Login[playerid][2] = CreatePlayerTextDraw(playerid, 321.333435, 7.481489, "Just_Survive");
	PlayerTextDrawLetterSize(playerid, TD_Login[playerid][2], 0.797667, 2.715850);
	PlayerTextDrawAlignment(playerid, TD_Login[playerid][2], 2);
	PlayerTextDrawColor(playerid, TD_Login[playerid][2], -1378294017);
	PlayerTextDrawSetShadow(playerid, TD_Login[playerid][2], 1);
	PlayerTextDrawSetOutline(playerid, TD_Login[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_Login[playerid][2], 255);
	PlayerTextDrawFont(playerid, TD_Login[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, TD_Login[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, TD_Login[playerid][2], 1);

	TD_Login[playerid][3] = CreatePlayerTextDraw(playerid, 320.566711, 63.007423, "Bienvenue sur le serveur survival de Jhonny.~n~Cliquez sur une des options ci-dessous pour continuer.");
	PlayerTextDrawLetterSize(playerid, TD_Login[playerid][3], 0.345333, 1.649777);
	PlayerTextDrawAlignment(playerid, TD_Login[playerid][3], 2);
	PlayerTextDrawColor(playerid, TD_Login[playerid][3], -1);
	PlayerTextDrawSetShadow(playerid, TD_Login[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, TD_Login[playerid][3], 2);
	PlayerTextDrawBackgroundColor(playerid, TD_Login[playerid][3], 255);
	PlayerTextDrawFont(playerid, TD_Login[playerid][3], 3);
	PlayerTextDrawSetProportional(playerid, TD_Login[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, TD_Login[playerid][3], 0);

	TD_Login[playerid][4] = CreatePlayerTextDraw(playerid, 69.333312, 184.111022, "");
	PlayerTextDrawLetterSize(playerid, TD_Login[playerid][4], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TD_Login[playerid][4], 103.000000, 112.000000);
	PlayerTextDrawAlignment(playerid, TD_Login[playerid][4], 1);
	PlayerTextDrawColor(playerid, TD_Login[playerid][4], -1);
	PlayerTextDrawSetShadow(playerid, TD_Login[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, TD_Login[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_Login[playerid][4], -1061109505);
	PlayerTextDrawFont(playerid, TD_Login[playerid][4], 5);
	PlayerTextDrawSetProportional(playerid, TD_Login[playerid][4], 0);
	PlayerTextDrawSetShadow(playerid, TD_Login[playerid][4], 0);
	PlayerTextDrawSetSelectable(playerid, TD_Login[playerid][4], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_Login[playerid][4], 11746);
	PlayerTextDrawSetPreviewRot(playerid, TD_Login[playerid][4], 0.000000, 90.000000, 0.000000, 0.500000);

	TD_Login[playerid][5] = CreatePlayerTextDraw(playerid, 121.034835, 302.670471, "Se_Connecter");
	PlayerTextDrawLetterSize(playerid, TD_Login[playerid][5], 0.400000, 1.600000);
	PlayerTextDrawAlignment(playerid, TD_Login[playerid][5], 2);
	PlayerTextDrawColor(playerid, TD_Login[playerid][5], -1);
	PlayerTextDrawSetShadow(playerid, TD_Login[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, TD_Login[playerid][5], 5);
	PlayerTextDrawBackgroundColor(playerid, TD_Login[playerid][5], 255);
	PlayerTextDrawFont(playerid, TD_Login[playerid][5], 0);
	PlayerTextDrawSetProportional(playerid, TD_Login[playerid][5], 1);
	PlayerTextDrawSetShadow(playerid, TD_Login[playerid][5], 0);

	TD_Login[playerid][6] = CreatePlayerTextDraw(playerid, 200.933319, 184.037246, "");
	PlayerTextDrawLetterSize(playerid, TD_Login[playerid][6], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TD_Login[playerid][6], 104.000000, 111.000000);
	PlayerTextDrawAlignment(playerid, TD_Login[playerid][6], 1);
	PlayerTextDrawColor(playerid, TD_Login[playerid][6], -1);
	PlayerTextDrawSetShadow(playerid, TD_Login[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, TD_Login[playerid][6], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_Login[playerid][6], -1061109505);
	PlayerTextDrawFont(playerid, TD_Login[playerid][6], 5);
	PlayerTextDrawSetProportional(playerid, TD_Login[playerid][6], 0);
	PlayerTextDrawSetShadow(playerid, TD_Login[playerid][6], 0);
	PlayerTextDrawSetSelectable(playerid, TD_Login[playerid][6], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_Login[playerid][6], 19555);
	PlayerTextDrawSetPreviewRot(playerid, TD_Login[playerid][6], 0.000000, 0.000000, 120.000000, 0.800000);

	string = "Jouer en invité";
	ConvertEncoding(string);
	TD_Login[playerid][7] = CreatePlayerTextDraw(playerid, 256.868377, 302.011169, string);
	PlayerTextDrawLetterSize(playerid, TD_Login[playerid][7], 0.400000, 1.600000);
	PlayerTextDrawAlignment(playerid, TD_Login[playerid][7], 2);
	PlayerTextDrawColor(playerid, TD_Login[playerid][7], -1);
	PlayerTextDrawSetShadow(playerid, TD_Login[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, TD_Login[playerid][7], 5);
	PlayerTextDrawBackgroundColor(playerid, TD_Login[playerid][7], 255);
	PlayerTextDrawFont(playerid, TD_Login[playerid][7], 0);
	PlayerTextDrawSetProportional(playerid, TD_Login[playerid][7], 1);
	PlayerTextDrawSetShadow(playerid, TD_Login[playerid][7], 0);

	TD_Login[playerid][8] = CreatePlayerTextDraw(playerid, 455.200653, 184.614578, "");
	PlayerTextDrawLetterSize(playerid, TD_Login[playerid][8], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TD_Login[playerid][8], 104.000000, 112.000000);
	PlayerTextDrawAlignment(playerid, TD_Login[playerid][8], 1);
	PlayerTextDrawColor(playerid, TD_Login[playerid][8], -1);
	PlayerTextDrawSetShadow(playerid, TD_Login[playerid][8], 0);
	PlayerTextDrawSetOutline(playerid, TD_Login[playerid][8], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_Login[playerid][8], -1061109505);
	PlayerTextDrawFont(playerid, TD_Login[playerid][8], 5);
	PlayerTextDrawSetProportional(playerid, TD_Login[playerid][8], 0);
	PlayerTextDrawSetShadow(playerid, TD_Login[playerid][8], 0);
	PlayerTextDrawSetSelectable(playerid, TD_Login[playerid][8], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_Login[playerid][8], 2050);
	PlayerTextDrawSetPreviewRot(playerid, TD_Login[playerid][8], 0.000000, 0.000000, 0.000000, 0.800000);

	TD_Login[playerid][9] = CreatePlayerTextDraw(playerid, 329.867309, 184.673767, "");
	PlayerTextDrawLetterSize(playerid, TD_Login[playerid][9], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TD_Login[playerid][9], 104.000000, 112.000000);
	PlayerTextDrawAlignment(playerid, TD_Login[playerid][9], 1);
	PlayerTextDrawColor(playerid, TD_Login[playerid][9], -1);
	PlayerTextDrawSetShadow(playerid, TD_Login[playerid][9], 0);
	PlayerTextDrawSetOutline(playerid, TD_Login[playerid][9], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_Login[playerid][9], -1061109505);
	PlayerTextDrawFont(playerid, TD_Login[playerid][9], 5);
	PlayerTextDrawSetProportional(playerid, TD_Login[playerid][9], 0);
	PlayerTextDrawSetShadow(playerid, TD_Login[playerid][9], 0);
	PlayerTextDrawSetSelectable(playerid, TD_Login[playerid][9], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_Login[playerid][9], 19606);
	PlayerTextDrawSetPreviewRot(playerid, TD_Login[playerid][9], 0.000000, 0.000000, 0.000000, 0.800000);

	string = "Nouveautés";
	ConvertEncoding(string);
	TD_Login[playerid][10] = CreatePlayerTextDraw(playerid, 384.535125, 302.255706, string);
	PlayerTextDrawLetterSize(playerid, TD_Login[playerid][10], 0.400000, 1.600000);
	PlayerTextDrawAlignment(playerid, TD_Login[playerid][10], 2);
	PlayerTextDrawColor(playerid, TD_Login[playerid][10], -1);
	PlayerTextDrawSetShadow(playerid, TD_Login[playerid][10], 0);
	PlayerTextDrawSetOutline(playerid, TD_Login[playerid][10], 5);
	PlayerTextDrawBackgroundColor(playerid, TD_Login[playerid][10], 255);
	PlayerTextDrawFont(playerid, TD_Login[playerid][10], 0);
	PlayerTextDrawSetProportional(playerid, TD_Login[playerid][10], 1);
	PlayerTextDrawSetShadow(playerid, TD_Login[playerid][10], 0);
}
stock ShowLoginTD(playerid)
{
	LoginTDShowed[playerid] = true;
	SelectTextDraw(playerid,rouge);
	for(new i;i<MaxLoginTD;i++) PlayerTextDrawShow(playerid,TD_Login[playerid][i]);
}
stock HideLoginTD(playerid)
{
	LoginTDShowed[playerid] = false;
	CancelSelectTextDraw(playerid);
	for(new i;i<MaxLoginTD;i++) PlayerTextDrawHide(playerid,TD_Login[playerid][i]);
}
stock IsValidItem(item)
{
	new name[256];
	name = GetNameObject(item);
	if(!strlen(name)) return 0;
	else return 1;
}
stock GetName(playerid)
{
	new pname[MAX_PLAYER_NAME];
	GetPlayerName(playerid,pname,sizeof(pname));
	return pname;
}
stock ShowObjectReceivedTD(playerid,id,amount)
{
	new string[256];
	string = "Objet reçu";
	ConvertEncoding(string);
	PlayerTextDrawSetString(playerid,TD_ObjectReceived[playerid][1],string);
	format(string,sizeof(string),"Vous avez reçu~n~%d~n~%s",amount,GetNameObject(id));
	ConvertEncoding(string);
	PlayerTextDrawSetString(playerid,TD_ObjectReceived[playerid][3],string);
	PlayerTextDrawSetPreviewModel(playerid,TD_ObjectReceived[playerid][2],PreviewModels[id]);
	for(new i=0;i<5;i++) PlayerTextDrawShow(playerid,TD_ObjectReceived[playerid][i]);
	SelectTextDraw(playerid,rouge);
	IsObjectReceived[playerid] = true;
}
stock HideObjectReceivedTD(playerid)
{
	for(new i=0;i<5;i++) PlayerTextDrawHide(playerid,TD_ObjectReceived[playerid][i]);
	CancelSelectTextDraw(playerid);
	IsObjectReceived[playerid] = false;
}
stock NotRankedEnough(playerid) return SendClientMessage(playerid,rouge,"Vous n'êtes pas assez haut gradé !");
stock NotConnected(playerid) return SendClientMessage(playerid,rouge,"Ce joueur n'est pas connecté !");

stock GetNameObject(item)
{
	new string[256];
	switch(item)
	{
	    case 1: string = "Eau";
	}
	return string;
}
forward UpdateResponse(playerid, response_code, data[]);
public UpdateResponse(playerid, response_code, data[])
{
		printf("response_code : %d",response_code);
	    printf("data :");
	    print(data);
}

public OnGameModeInit()
{
	printf("-6781984945 : %d  | 0xFFF7898F : %d",IsNumeric("-6781984945"), 0xFFF7898F);
	printf("%d",udb_hash("mdpchange"));
	new valuestart = 'a';
	new valueend = 'z';
	printf("Valuestart : %c : %d",valuestart,valuestart);
	printf("Valueend : %c : %d",valueend, valueend);
	for(new i = valuestart; i < valueend; i++) printf("%c : %d",i,i);
	SetGameModeText("Survival v0.1");
	new string[256];
	string = "85 699";
	new tmp[256],tmp1[256],idx;
	tmp = strtok(string,idx);
	tmp1 = strtok(string,idx);
	txt = TextDrawCreate(510.0, 335.0,"~r~/regles~n~  ~g~/help~n~    ~p~/aide");
	TextDrawUseBox(txt,0);
	TextDrawFont(txt, 2);
	for(new i; i < MAX_VENTES; i++)
	{
	    if(fexist(VentePath(i))) INI_ParseFile(VentePath(i), "LoadVentes_%s", .bExtra = true, .extra = i);
	}
	
 // --------------------  [ISLAND IN THE SUN  - PIX ] ---------------------------------- //
CreateDynamicObject(18751,-3790.5498047,-3160.5039062,1.6690000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18751,-3787.9489746,-3103.9079590,0.0440000,0.0000000,0.0000000,9.9975586); //
		CreateDynamicObject(18751,-3793.6960449,-3056.2871094,0.1690000,1.7468262,0.0000000,0.0000000); //
		CreateObject(18752,-3909.0625000,-3099.7128906,0.0000000,0.0000000,0.0000000,90.0000000); //
		CreateDynamicObject(1610,-3759.5668945,-3143.4431152,4.4720001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18751,-3786.7617188,-2998.9960938,-0.0810000,0.0000000,0.0000000,357.9895020); //
		CreateDynamicObject(18751,-3785.1523438,-2944.5351562,-0.1060000,0.9997559,0.0000000,357.9895020); //
		CreateDynamicObject(18751,-3783.7729492,-2889.2338867,-0.1060000,0.9997559,0.0000000,357.9895020); //
		CreateDynamicObject(18751,-3792.0478516,-2850.9287109,-0.1060000,0.9887695,0.0000000,37.9797363); //
		CreateDynamicObject(18751,-3784.7229004,-2525.2290039,-4.7100000,0.9942627,0.0000000,39.9847412); //
		CreateDynamicObject(18751,-3907.9589844,-2755.7170410,0.6690000,2.4942627,0.0000000,69.9847412); //
		CreateDynamicObject(18751,-3956.9863281,-2736.4726562,1.4190000,1.2414551,0.2471924,69.9719238); //
		CreateDynamicObject(18751,-3800.1708984,-3202.0966797,2.8440001,0.0000000,0.0000000,329.9963379); //
		CreateDynamicObject(18751,-3829.1210938,-3241.1389160,2.8440001,0.0000000,0.0000000,319.9963379); //
		CreateDynamicObject(18751,-3866.7187500,-3242.8349609,3.5940001,0.0000000,0.0000000,279.9920654); //
		CreateDynamicObject(18751,-3920.4970703,-3245.8740234,4.0440001,1.2469482,0.0000000,269.9890137); //
		CreateDynamicObject(18751,-3975.6826172,-3246.5312500,4.0440001,1.2414551,0.0000000,269.9890137); //
		CreateDynamicObject(18751,-4009.9589844,-3233.7822266,4.0440001,1.2414551,0.0000000,229.9822998); //
		CreateDynamicObject(18751,-4025.0576172,-3199.8193359,4.0440001,1.2414551,0.0000000,189.9865723); //
		CreateDynamicObject(18751,-4034.7216797,-3144.0468750,4.0440001,1.2414551,0.0000000,189.9865723); //
		CreateDynamicObject(18751,-4046.7470703,-3090.2207031,4.0440001,1.2414551,0.0000000,189.9865723); //
		CreateDynamicObject(18751,-4058.2988281,-3036.1289062,4.0440001,1.2414551,0.0000000,189.9810791); //
		CreateDynamicObject(18751,-4069.1230469,-2988.5048828,4.0440001,1.2414551,0.0000000,189.9865723); //
		CreateDynamicObject(18751,-4079.7749023,-2931.9379883,4.0440001,1.2414551,0.0000000,189.9865723); //
		CreateDynamicObject(18751,-4089.8857422,-2876.1308594,4.0440001,1.2414551,0.0000000,189.9865723); //
		CreateDynamicObject(18751,-4258.2675781,-2899.2695312,0.8250000,1.2414551,0.0000000,159.9774170); //
		CreateDynamicObject(18751,-4064.7734375,-2809.7060547,4.0440001,1.2414551,0.0000000,129.9792480); //
		CreateDynamicObject(18751,-4029.5129395,-2849.0429688,4.0440001,1.2414551,0.0000000,129.9792480); //
		CreateDynamicObject(18751,-4047.4519043,-2881.9160156,4.0440001,1.2414551,0.0000000,129.9792480); //
		CreateDynamicObject(18751,-4004.6005859,-2882.1835938,4.0440001,1.2414551,0.0000000,129.9737549); //
		CreateDynamicObject(18751,-3926.7871094,-2764.1601562,-0.4060000,3.2409668,0.2471924,149.9633789); //
		CreateDynamicObject(18751,-4032.8339844,-2924.6123047,2.9940000,1.2414551,0.0000000,189.9865723); //
		CreateDynamicObject(18751,-4020.7216797,-2957.8964844,2.9940000,1.2414551,0.0000000,189.9865723); //
		CreateDynamicObject(18751,-3990.9599609,-2930.4042969,2.9940000,1.2414551,0.0000000,189.9865723); //
		CreateDynamicObject(18751,-3961.3857422,-2960.0322266,2.9940000,1.2414551,0.0000000,189.9865723); //
		CreateDynamicObject(18751,-3974.4250488,-2899.5310059,3.4440000,0.9914551,0.0000000,189.9865570); //
		CreateDynamicObject(11556,-3930.2729492,-2902.0581055,-5.0760002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(16110,-3905.2351074,-2878.2690430,0.5300000,5.3434143,311.7214966,45.9624634); //
		CreateDynamicObject(16110,-3909.9499512,-2862.5800781,0.5300000,5.3393555,311.7205811,235.9613037); //
		CreateDynamicObject(16112,-3886.5136719,-2849.6171875,-3.2500000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(16113,-3907.6250000,-2853.6088867,-2.5780001,0.0000000,0.0000000,50.0000000); //
		CreateDynamicObject(16113,-3887.3437500,-2871.7216797,-3.5780001,0.0000000,0.0000000,269.9945068); //
		CreateDynamicObject(16114,-3906.4658203,-2861.9970703,0.5500000,0.0000000,0.0000000,309.9957275); //
		CreateDynamicObject(16116,-3917.9404297,-2853.6181641,3.2079999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(16117,-3900.7160645,-2826.5979004,-1.1080000,0.0000000,0.0000000,40.0000000); //
		CreateDynamicObject(16117,-3912.7519531,-2839.1250000,-2.0330000,0.0000000,0.0000000,49.9932861); //
		CreateDynamicObject(16118,-4100.1289062,-2245.1799316,-0.7500000,0.0000000,0.0000000,319.9932861); //
		CreateDynamicObject(16112,-3888.0649414,-2839.3359375,1.7500000,358.1206665,20.0112305,16.6842957); //
		CreateDynamicObject(16120,-3911.5244141,-2835.0585938,-1.3660001,0.0000000,0.0000000,69.9938965); //
		CreateDynamicObject(16120,-3903.7709961,-2834.7250977,-1.3660001,0.0000000,0.0000000,69.9993896); //
		CreateDynamicObject(16127,-3928.8439941,-2822.8869629,-3.3889999,0.0000000,0.0000000,50.0000000); //
		CreateDynamicObject(16139,-3909.9414062,-2817.7021484,-9.0209999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18751,-3985.9150391,-3190.1889648,4.0440001,1.2414551,0.0000000,219.9865723); //
		CreateDynamicObject(18751,-3948.9707031,-3204.9609375,4.0440001,1.2414551,0.0000000,249.9829102); //
		CreateDynamicObject(18751,-3898.1435547,-3199.5634766,4.0440001,1.2414551,0.0000000,259.9804688); //
		CreateDynamicObject(18751,-3926.3798828,-3178.4140625,4.0440001,1.2414551,0.0000000,259.9804688); //
		CreateDynamicObject(18751,-3955.1960449,-3155.9650879,4.0440001,1.2414551,0.0000000,249.9804688); //
		CreateDynamicObject(18751,-3989.6110840,-3139.0109863,4.0440001,1.2414551,0.0000000,219.9774170); //
		CreateDynamicObject(18751,-4005.8232422,-3104.5468750,4.0440001,1.2414551,0.0000000,159.9719238); //
		CreateDynamicObject(18751,-4018.9609375,-3008.7780762,4.0440001,1.2414551,0.0000000,159.9719238); //
		CreateDynamicObject(18751,-4017.6894531,-3065.0439453,4.0440001,1.2414551,0.0000000,159.9664307); //
		CreateDynamicObject(18751,-3984.3469238,-3059.3840332,4.0440001,1.2414551,0.0000000,159.9719238); //
		CreateDynamicObject(18751,-3976.1298828,-2999.5480957,2.9940000,1.2414551,0.0000000,159.9719238); //
		CreateDynamicObject(18751,-3980.9550781,-3025.0830078,2.9940000,1.2414551,0.0000000,159.9719238); //
		CreateDynamicObject(18751,-3949.5629883,-3024.4509277,2.9940000,1.2414551,0.0000000,159.9719238); //
		CreateDynamicObject(18751,-3926.3339844,-2999.7714844,2.9940000,1.2414551,0.0000000,159.9664307); //
		CreateDynamicObject(18751,-3891.7500000,-3034.1220703,2.9940000,1.2414551,0.0000000,159.9719238); //
		CreateDynamicObject(18751,-3884.7480469,-3014.7419434,2.9940000,1.2414551,0.0000000,181.9719238); //
		CreateDynamicObject(18751,-3856.7802734,-3005.6562500,2.9940000,1.2414551,0.0000000,181.9610596); //
		CreateDynamicObject(18751,-3815.5048828,-3040.9824219,1.3940001,1.2414551,0.0000000,185.9655762); //
		CreateDynamicObject(18751,-3815.1542969,-3081.0292969,1.1440001,1.2414551,0.0000000,185.9655762); //
		CreateDynamicObject(18751,-3824.1816406,-3126.0664062,1.1440001,1.2414551,0.0000000,185.9655762); //
		CreateDynamicObject(18751,-3837.9677734,-3165.4345703,1.1440001,1.2414551,0.0000000,185.9655762); //
		CreateDynamicObject(18751,-3851.8339844,-3195.6337891,1.1440001,1.2414551,0.0000000,185.9655762); //
		CreateDynamicObject(18751,-3859.8769531,-3173.4750977,1.1440001,1.2414551,0.0000000,185.9655762); //
		CreateDynamicObject(18751,-3820.0419922,-3015.2609863,-0.0060000,1.2414551,0.0000000,181.9665527); //
		CreateDynamicObject(18751,-3821.1499023,-2996.4519043,-0.0060000,1.2414551,0.0000000,181.9665527); //
		CreateDynamicObject(18751,-3828.0820312,-2975.7338867,0.8190000,1.2414551,0.0000000,211.9665527); //
		CreateDynamicObject(18751,-3880.6445312,-2921.4082031,-8.4309998,1.2414551,0.0000000,211.9647217); //
		CreateDynamicObject(18751,-3840.9970703,-2875.4509277,-8.4309998,1.2414551,0.0000000,211.9647217); //
		CreateDynamicObject(18751,-3823.2460938,-2863.9670410,-8.4309998,1.2414551,0.0000000,211.9647217); //
		CreateDynamicObject(18751,-3871.3139648,-2877.8759766,-8.4309998,1.2414551,0.0000000,211.9647217); //
		CreateDynamicObject(18751,-3931.2609863,-2841.5161133,-8.4309998,1.2414551,0.0000000,211.9647217); //
		CreateDynamicObject(18751,-3964.1960449,-2823.2109375,-8.4309998,1.2414551,0.0000000,211.9647217); //
		CreateDynamicObject(18751,-3998.5529785,-2797.6030273,-8.4309998,1.2414551,0.0000000,211.9647217); //
		CreateDynamicObject(622,-3828.9909668,-3134.2958984,6.6090002,0.0000000,0.0000000,229.9932861); //
		CreateDynamicObject(624,-3822.2548828,-3127.1508789,6.3080001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(624,-3825.2890625,-3119.5959473,5.9650002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(624,-3816.7509766,-3121.3149414,4.6399999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(629,-3820.9970703,-3119.0830078,7.2839999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(634,-3820.4990234,-3117.9121094,7.0349998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(641,-3821.8740234,-3116.1289062,4.8290000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(649,-3820.7800293,-3119.1149902,7.2440000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(655,-3891.4208984,-3023.4670410,9.0690002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(655,-3895.3979492,-3016.1298828,8.5690002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(655,-3886.1389160,-3018.2729492,8.7939997,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(655,-3890.3486328,-3013.5351562,9.0690002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(655,-3901.5229492,-3016.3400879,7.5689998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(655,-3896.8139648,-3011.5258789,7.5689998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(669,-3892.2810059,-3019.3588867,8.8690004,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(624,-3831.7871094,-3128.2729492,5.9650002,0.0000000,0.0000000,100.0000000); //
		CreateDynamicObject(624,-3828.9750977,-3123.0329590,5.2150002,0.0000000,0.0000000,83.9975586); //
		CreateDynamicObject(624,-3820.2170410,-3132.5061035,3.4649999,0.0000000,0.0000000,83.9959717); //
		CreateDynamicObject(622,-3838.3027344,-3160.7197266,7.3309999,0.0000000,0.0000000,289.9896240); //
		CreateDynamicObject(12991,-3626.3520508,-2584.4589844,33.7659988,359.9945068,359.9945068,181.3256836); //
		CreateDynamicObject(12991,2161.6328125,-102.4765625,1.7500000,0.0000000,0.0000000,31.3330078); //
		CreateDynamicObject(18751,-3989.7978516,-2709.0888672,1.4190000,1.2414551,0.2471924,39.9737549); //
		CreateDynamicObject(672,-3815.2646484,-3127.0273438,7.6680002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(688,-3819.9755859,-3110.9736328,6.4910002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(698,-3900.9350586,-3022.3798828,8.3710003,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(710,-3813.2089844,-3119.4970703,21.0170002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(710,-3827.9560547,-3143.1079102,19.4969997,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(710,-3837.3500977,-3136.2089844,21.9899998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(710,-3833.3906250,-3158.1835938,21.8500004,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(712,-3832.0439453,-3150.1979980,15.7040005,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(712,-3832.2719727,-3142.6970215,13.7040005,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(622,-3822.6367188,-3144.7832031,2.7839999,0.0000000,0.0000000,289.9896240); //
		CreateDynamicObject(726,-3831.4218750,-3114.0156250,6.6710000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(858,-3819.1760254,-3120.3930664,6.9130001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(3505,-3827.1479492,-3113.3898926,6.6999998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(3512,-3809.5107422,-3121.2294922,5.0609999,0.0000000,0.0000000,270.0000000); //
		CreateDynamicObject(759,-3819.4270020,-3124.6899414,7.0710001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18751,-4033.0029297,-2740.6318359,-8.4309998,1.2414551,0.0000000,211.9647217); //
		CreateDynamicObject(902,-3749.4709473,-2945.5119629,1.6680000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2406,-3782.7060547,-3166.8652344,8.6829996,0.0000000,0.0000000,59.9963379); //
		CreateDynamicObject(1609,-3802.0720215,-3143.6459961,5.0000000,0.0000000,0.0000000,269.9993896); //
		CreateDynamicObject(16502,-3942.7229004,-2861.1479492,4.0469999,358.1729736,335.9870605,19.1862488); //
		CreateDynamicObject(710,-3838.1169434,-3125.8439941,20.7779999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(710,-3841.6740723,-3113.7338867,19.7530003,0.0000000,0.0000000,290.0000000); //
		CreateDynamicObject(710,-3837.3000488,-3115.5800781,19.7530003,0.0000000,0.0000000,259.9951172); //
		CreateDynamicObject(710,-3840.8259277,-3100.8010254,18.8780003,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3831.8369141,-3106.4929199,18.8279991,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3824.1630859,-3105.6630859,18.8029995,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3832.4003906,-3092.9638672,19.0030003,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3835.7629395,-3084.2219238,19.0030003,0.0000000,0.0000000,259.9914551); //
		CreateDynamicObject(710,-3825.6569824,-3087.4550781,19.2530003,0.0000000,0.0000000,259.9914551); //
		CreateDynamicObject(710,-3832.4580078,-3073.2170410,20.2530003,0.0000000,0.0000000,259.9914551); //
		CreateDynamicObject(710,-3820.9709473,-3074.8210449,20.2530003,0.0000000,0.0000000,259.9914551); //
		CreateDynamicObject(710,-3834.1730957,-3065.0139160,19.7530003,0.0000000,0.0000000,259.9914551); //
		CreateDynamicObject(710,-3823.7570801,-3065.2119141,19.7530003,0.0000000,0.0000000,259.9914551); //
		CreateDynamicObject(710,-3814.0410156,-3079.5410156,19.7530003,0.0000000,0.0000000,259.9914551); //
		CreateDynamicObject(710,-3829.6367188,-3055.7021484,19.7530003,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3822.5039062,-3058.7680664,19.2530003,0.0000000,0.0000000,259.9914551); //
		CreateDynamicObject(710,-3812.7829590,-3067.8500977,20.0030003,0.0000000,0.0000000,259.9914551); //
		CreateDynamicObject(710,-3822.5490723,-3047.7949219,20.0030003,0.0000000,0.0000000,259.9914551); //
		CreateDynamicObject(710,-3814.8417969,-3054.6035156,20.0030003,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3812.4440918,-3061.8291016,20.5030003,0.0000000,0.0000000,259.9914551); //
		CreateDynamicObject(710,-3813.8479004,-3044.4240723,20.5030003,0.0000000,0.0000000,259.9914551); //
		CreateDynamicObject(710,-3829.0559082,-3041.2070312,20.5030003,0.0000000,0.0000000,259.9914551); //
		CreateDynamicObject(710,-3819.8579102,-3038.3969727,20.5030003,0.0000000,0.0000000,259.9914551); //
		CreateDynamicObject(710,-3822.9384766,-3030.7753906,20.5030003,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3814.2285156,-3036.0800781,20.5030003,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3822.8898926,-3097.7661133,20.1529999,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3813.7958984,-3098.9409180,18.8530006,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3847.2639160,-3164.7919922,20.0030003,0.0000000,0.0000000,259.9914551); //
		CreateDynamicObject(710,-3837.5100098,-3168.1120605,20.0030003,0.0000000,0.0000000,259.9914551); //
		CreateDynamicObject(710,-3839.6379395,-3058.7971191,19.2530003,0.0000000,0.0000000,259.9914551); //
		CreateDynamicObject(12990,-3746.0722656,-3168.7177734,2.3130000,5.9985352,0.0000000,95.9985352); //
		CreateDynamicObject(18632,-3783.4570312,-3168.2880859,8.7650003,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(672,-3819.3291016,-3086.6530762,7.0879998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(688,-3823.9326172,-3049.9541016,5.3699999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(7916,-3936.0136719,-2816.3652344,0.7440000,0.0000000,0.0000000,235.9973145); //
		CreateDynamicObject(3414,-3809.0468750,-3177.2099609,7.9239998,2.2394714,2.2517090,79.9034119); //
		CreateDynamicObject(3415,-4026.5920410,-2894.8359375,10.2200003,0.0000000,0.0000000,35.9954834); //
		CreateDynamicObject(16405,-3792.6330566,-3176.8039551,8.3800001,14.0000000,0.0000000,356.0000000); //
		CreateDynamicObject(1462,-3786.4843750,-3170.8349609,7.8850002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1463,-3809.1015625,-3151.0791016,5.5000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(841,-3817.8349609,-3160.9279785,4.5689998,0.0000000,11.0000000,0.0000000); //
		CreateDynamicObject(838,-3826.4580078,-3101.2285156,7.0619998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(838,-3815.6540527,-3072.9589844,9.8120003,0.0000000,0.0000000,312.0000000); //
		CreateDynamicObject(837,-3826.4719238,-3078.3439941,6.7210002,0.4954224,352.2496948,0.0674133); //
		CreateDynamicObject(835,-3845.8940430,-3108.5668945,7.1900001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(833,-3821.1918945,-3067.3210449,7.4120002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(830,-3838.9709473,-3093.3439941,5.2659998,0.0000000,344.2500000,0.0000000); //
		CreateDynamicObject(616,-3820.9287109,-3035.4296875,7.2270002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(648,-3812.3789062,-3086.1289062,5.7370000,0.0000000,0.0000000,91.9940186); //
		CreateDynamicObject(654,-3827.3420410,-3093.8310547,6.3049998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(658,-3837.9689941,-3073.5480957,4.9600000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(669,-3826.9462891,-3034.4238281,6.7900000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(671,-3817.1865234,-3069.8681641,7.0830002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(673,-3821.5585938,-3062.6152344,6.0380001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(16502,-3634.5751953,-2702.7099609,38.8849983,350.9527588,334.3963623,155.6872559); //
		CreateDynamicObject(16502,-3910.5258789,-2853.9641113,25.4820004,356.1864929,342.2033691,356.7724304); //
		CreateDynamicObject(703,-3878.1943359,-3014.9355469,8.6059999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(767,-3827.5673828,-3067.5878906,6.4759998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(767,-3829.0322266,-3089.0742188,6.5260000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(647,-3834.6450195,-3078.6179199,5.9460001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(677,-3781.8278809,-3165.5100098,7.2649999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(679,-3781.8630371,-3165.4909668,7.2670002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(728,-3819.8669434,-3129.8769531,6.9720001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(753,-3791.7609863,-3169.8889160,8.0340004,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(759,-3834.1269531,-3154.5029297,7.0440001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(647,-3832.0107422,-3086.1142578,6.6459999,0.0000000,0.0000000,79.9969482); //
		CreateDynamicObject(647,-3832.3769531,-3087.7509766,6.6459999,0.0000000,0.0000000,79.9969482); //
		CreateDynamicObject(647,-3832.5849609,-3089.1940918,6.6459999,0.0000000,0.0000000,39.9969482); //
		CreateDynamicObject(647,-3834.5302734,-3100.4228516,6.6459999,0.0000000,0.0000000,39.9957275); //
		CreateDynamicObject(762,-3822.8037109,-3043.6210938,10.8640003,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(800,-3808.2661133,-3079.8510742,7.3080001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(803,-3838.0161133,-3054.1779785,5.6859999,0.9945068,353.9990845,3.3545227); //
		CreateDynamicObject(817,-3829.2646484,-3126.8222656,7.6599998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18751,-4049.0510254,-2727.3959961,-8.4309998,1.2414551,0.0000000,211.9647217); //
		CreateDynamicObject(18751,-4066.7170410,-2743.9960938,-8.4309998,1.2414551,0.0000000,211.9647217); //
		CreateDynamicObject(18751,-3908.4870605,-2899.9399414,-7.9310002,1.2414551,0.0000000,211.9647217); //
		CreateDynamicObject(18688,-3817.9560547,-3160.9250488,2.8529999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1452,-3786.4479980,-3160.4580078,8.8529997,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(3403,-3788.6608887,-3186.9460449,8.2670002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(3419,-3782.0449219,-3138.0449219,3.6650000,351.2553711,357.9764709,359.6922302); //
		CreateDynamicObject(13206,-3789.4350586,-3153.4240723,6.5939999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18259,-3996.1396484,-3027.9023438,8.7019997,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(710,-3805.6608887,-3063.0009766,20.1779995,0.0000000,0.0000000,259.9914551); //
		CreateDynamicObject(710,-3807.9270020,-3054.1049805,20.1779995,0.0000000,0.0000000,259.9914551); //
		CreateDynamicObject(710,-3799.2380371,-3060.6750488,19.6529999,0.0000000,0.0000000,259.9914551); //
		CreateDynamicObject(895,-3815.4260254,-3049.9528809,6.6589999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(892,-3808.4853516,-3060.4677734,4.7789998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(889,-3812.1083984,-3049.3720703,6.3790002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(881,-3816.4370117,-3057.6621094,4.2979999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(882,-3817.5170898,-3065.1450195,6.6160002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(789,-3979.7314453,-3050.5937500,23.5839996,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(778,-3886.6430664,-3010.7890625,9.1689997,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(778,-3838.9770508,-3049.6230469,4.8600001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(770,-3908.2690430,-3021.7919922,6.6939998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(770,-3982.5849609,-3032.5146484,7.0689998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(766,-3958.0429688,-3043.7409668,6.5929999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(763,-3959.3149414,-3038.7219238,5.9239998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(736,-3965.1250000,-3041.6650391,18.0020008,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(726,-3945.8027344,-3033.7656250,8.0900002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(718,-3914.3190918,-3018.1831055,5.7880001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(712,-3915.0080566,-3021.0629883,15.7259998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(712,-3922.6640625,-3019.5263672,15.5509996,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(712,-3868.7792969,-3013.7783203,17.9659996,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(714,-3943.0830078,-3017.8505859,6.8620000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(710,-3857.5009766,-3168.0710449,22.4629993,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(708,-3925.8515625,-3013.7324219,6.5400000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(704,-3933.2998047,-3025.9628906,6.5650001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(698,-3858.6816406,-3012.6826172,14.1540003,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(623,-3658.1000977,-3323.4020996,14.3660002,0.0000000,0.0000000,89.9908447); //
		CreateDynamicObject(623,-3858.9809570,-3015.3630371,6.5450001,0.0000000,0.0000000,189.9963379); //
		CreateDynamicObject(648,-3802.9960938,-3078.5458984,5.7370000,0.0000000,0.0000000,121.9940186); //
		CreateDynamicObject(648,-3803.9912109,-3048.7607422,5.4870000,0.0000000,0.0000000,121.9866943); //
		CreateDynamicObject(19448,-3824.7758789,-3168.7241211,5.4949999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(19448,-3826.5339355,-3168.7590332,5.4949999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(19448,-3825.6499023,-3168.7390137,7.1700001,0.0000000,90.5000610,0.0000000); //
		CreateDynamicObject(19346,-3824.3701172,-3173.1359863,7.2870002,0.0000000,0.0000000,290.0000000); //
		CreateDynamicObject(19346,-3824.3730469,-3172.8120117,7.2870002,0.0000000,0.0000000,289.9951172); //
		CreateDynamicObject(19346,-3824.3759766,-3172.4860840,7.2870002,0.0000000,0.0000000,289.9951172); //
		CreateDynamicObject(19346,-3824.3789062,-3172.1870117,7.2870002,0.0000000,0.0000000,289.9951172); //
		CreateDynamicObject(19346,-3824.3779297,-3172.3359375,7.2870002,0.0000000,0.0000000,289.9951172); //
		CreateDynamicObject(19346,-3824.3750000,-3172.6599121,7.2870002,0.0000000,0.0000000,289.9951172); //
		CreateDynamicObject(19346,-3824.3720703,-3172.9829102,7.2870002,0.0000000,0.0000000,289.9951172); //
		CreateDynamicObject(19346,-3824.3820801,-3172.0109863,7.2870002,0.0000000,0.0000000,289.9951172); //
		CreateDynamicObject(19346,-3824.3840332,-3171.8120117,7.2870002,0.0000000,0.0000000,289.9951172); //
		CreateDynamicObject(19346,-3824.8320312,-3171.8159180,7.2870002,0.0000000,0.0000000,289.9951172); //
		CreateDynamicObject(19346,-3824.8300781,-3172.0400391,7.2870002,0.0000000,0.0000000,289.9951172); //
		CreateDynamicObject(19346,-3824.8278809,-3172.2639160,7.2870002,0.0000000,0.0000000,289.9951172); //
		CreateDynamicObject(19346,-3824.8249512,-3172.4628906,7.2870002,0.0000000,0.0000000,289.9951172); //
		CreateDynamicObject(19346,-3824.8220215,-3172.6870117,7.2870002,0.0000000,0.0000000,289.9951172); //
		CreateDynamicObject(19346,-3824.8190918,-3172.8859863,7.2870002,0.0000000,0.0000000,289.9951172); //
		CreateDynamicObject(19346,-3824.8168945,-3173.0849609,7.2870002,0.0000000,0.0000000,289.9951172); //
		CreateDynamicObject(19346,-3824.8149414,-3173.2590332,7.2870002,0.0000000,0.0000000,289.9951172); //
		CreateDynamicObject(2222,-3824.4909668,-3171.1870117,7.2890000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2342,-3825.0139160,-3171.2229004,7.3590002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1666,-3824.7810059,-3170.5590820,7.3290000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1666,-3824.4460449,-3170.2189941,7.3260002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1666,-3825.0480957,-3170.7299805,7.3290000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1666,-3824.6660156,-3170.7370605,7.3290000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1666,-3824.8720703,-3170.7419434,7.3290000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1666,-3825.0349121,-3170.5520020,7.3290000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1666,-3824.9150391,-3170.4760742,7.3290000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1666,-3824.5869141,-3170.2180176,7.3290000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1666,-3824.4919434,-3170.7480469,7.3290000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1666,-3824.7609863,-3170.2080078,7.3290000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1666,-3825.0349121,-3170.1918945,7.3290000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1666,-3825.0200195,-3169.9431152,7.3290000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1666,-3824.8640137,-3169.8520508,7.3290000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1666,-3824.7329102,-3169.7590332,7.3290000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1666,-3824.5769043,-3169.6679688,7.3290000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1666,-3824.3959961,-3169.5791016,7.3290000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1666,-3824.4189453,-3169.9780273,7.3290000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1666,-3824.5380859,-3169.8710938,7.3290000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1666,-3824.6350098,-3169.8159180,7.3290000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1666,-3824.8278809,-3169.7041016,7.3290000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1666,-3824.9470215,-3169.6220703,7.3290000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1666,-3825.0419922,-3169.5419922,7.3290000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1666,-3824.3640137,-3170.7561035,7.3290000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1667,-3824.4221191,-3169.2128906,7.3340001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1667,-3824.5500488,-3169.2229004,7.3350000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1667,-3824.6708984,-3169.2241211,7.3340001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1667,-3824.8200684,-3169.2241211,7.3340001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1667,-3824.9689941,-3169.2241211,7.3340001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1667,-3825.0681152,-3169.2241211,7.3340001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1667,-3825.0681152,-3169.0991211,7.3340001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1667,-3825.0681152,-3168.9489746,7.3340001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1667,-3825.0681152,-3168.8491211,7.3340001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1667,-3824.8181152,-3169.0979004,7.3340001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1667,-3824.8181152,-3168.9980469,7.3340001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1667,-3824.4440918,-3169.0729980,7.3340001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1667,-3824.4431152,-3168.9479980,7.3340001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1667,-3824.4431152,-3168.8229980,7.3340001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1667,-3825.0649414,-3168.3491211,7.3340001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1667,-3825.0649414,-3168.4479980,7.3340001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1667,-3825.0148926,-3168.5471191,7.3340001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1667,-3824.9150391,-3168.6469727,7.3340001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1667,-3824.7910156,-3168.5720215,7.3340001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1667,-3824.6918945,-3168.4470215,7.3340001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1667,-3824.6420898,-3168.3469238,7.3340001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1667,-3824.5170898,-3168.3220215,7.3340001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1667,-3824.4418945,-3168.4460449,7.3340001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1667,-3824.4418945,-3168.5700684,7.3340001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1667,-3824.6159668,-3167.9970703,7.3340001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1667,-3824.3920898,-3167.9719238,7.3340001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1667,-3824.5148926,-3167.9970703,7.3340001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1667,-3824.7399902,-3167.9970703,7.3340001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1667,-3824.8889160,-3167.9970703,7.3340001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1667,-3825.0129395,-3167.9970703,7.3340001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1667,-3825.0380859,-3168.0969238,7.3340001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1667,-3825.0380859,-3168.1721191,7.3340001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1667,-3825.0380859,-3167.9230957,7.3340001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1667,-3825.0380859,-3167.7980957,7.3340001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1667,-3825.0380859,-3167.7978516,7.3340001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1455,-3825.0590820,-3167.2700195,7.3220000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1455,-3825.0300293,-3167.4450684,7.3220000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1455,-3825.0559082,-3167.1201172,7.3220000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1455,-3824.8898926,-3167.5720215,7.3220000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1455,-3824.7160645,-3167.6000977,7.3220000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1455,-3824.5410156,-3167.5529785,7.3220000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1455,-3824.4150391,-3167.4560547,7.3220000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1455,-3824.3630371,-3167.3320312,7.3220000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1455,-3824.5329590,-3167.1540527,7.3220000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1455,-3824.6569824,-3167.1508789,7.3220000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1455,-3824.7089844,-3167.2990723,7.3220000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1455,-3824.7041016,-3167.0249023,7.3220000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1455,-3824.3830566,-3167.1799316,7.3220000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1455,-3824.3510742,-3166.7338867,7.3220000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1455,-3824.5000000,-3166.7309570,7.3220000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1455,-3824.6499023,-3166.7280273,7.3220000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1455,-3824.8239746,-3166.7241211,7.3220000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1455,-3825.0229492,-3166.7199707,7.3220000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1455,-3825.0200195,-3166.5700684,7.3220000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1455,-3825.0170898,-3166.4199219,7.3220000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1455,-3824.6721191,-3166.6259766,7.3220000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1455,-3824.3479004,-3166.6320801,7.3220000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1455,-3824.3449707,-3166.4829102,7.3220000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1455,-3825.2709961,-3166.6889648,7.3220000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1455,-3825.3920898,-3166.5119629,7.3220000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1455,-3824.3640137,-3166.2080078,7.3220000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1455,-3824.5380859,-3166.2050781,7.3220000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1455,-3824.7128906,-3166.2019043,7.3220000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1455,-3824.9121094,-3166.1970215,7.3220000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1455,-3824.9350586,-3166.0710449,7.3220000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1455,-3824.7829590,-3165.9489746,7.3220000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1455,-3824.6069336,-3165.8769531,7.3220000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1455,-3824.3798828,-3165.7819824,7.3220000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1455,-3824.6289062,-3165.7753906,7.3220000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1455,-3824.8530273,-3165.7709961,7.3220000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1455,-3825.0520020,-3165.7670898,7.3220000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1455,-3825.1350098,-3166.1889648,7.3220000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1455,-3824.3959961,-3165.3559570,7.3220000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1455,-3824.5700684,-3165.3769531,7.3220000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1455,-3824.8181152,-3165.3720703,7.3220000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1455,-3825.0419922,-3165.3679199,7.3220000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1455,-3825.3659668,-3165.3859863,7.3220000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1455,-3824.4379883,-3165.1049805,7.3220000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1455,-3824.6110840,-3165.0510254,7.3220000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1455,-3824.8339844,-3164.9970703,7.3220000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1455,-3825.0820312,-3164.9179688,7.3220000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1455,-3825.0791016,-3164.7438965,7.3220000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1455,-3824.8039551,-3164.6989746,7.3220000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1455,-3824.6040039,-3164.6770020,7.3220000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1455,-3824.4279785,-3164.6298828,7.3220000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1455,-3824.6569824,-3164.8750000,7.3220000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1455,-3825.0449219,-3164.3439941,7.3220000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1455,-3824.8710938,-3164.3469238,7.3220000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1455,-3824.7219238,-3164.3500977,7.3220000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1455,-3824.5229492,-3164.3540039,7.3220000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1455,-3824.3979492,-3164.3559570,7.3220000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1455,-3824.3950195,-3164.2060547,7.3220000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1455,-3824.3911133,-3164.0319824,7.3220000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1455,-3824.3906250,-3164.0312500,7.3220000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(3931,-3770.2910156,-3131.3879395,2.6650000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(3931,-3813.2419434,-3169.9050293,5.2600002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2096,-3786.2661133,-3188.2070312,5.2930002,0.0000000,0.0000000,80.0000000); //
		CreateDynamicObject(2096,-3804.4521484,-3173.6503906,5.6360002,0.0000000,0.0000000,79.9914551); //
		CreateDynamicObject(2636,-3786.2109375,-3187.3310547,5.9109998,0.0000000,0.0000000,158.0000000); //
		CreateDynamicObject(2096,-3785.8249512,-3186.4450684,5.2700000,0.0000000,0.0000000,49.9969482); //
		CreateDynamicObject(951,-3734.3000488,-3168.2958984,2.0850000,0.0000000,0.0000000,120.0000000); //
		CreateDynamicObject(8483,-3950.4370117,-3195.4208984,22.6429996,0.0000000,340.0000000,30.0000000); //
		CreateDynamicObject(6865,-4001.7910156,-3078.8037109,6.4210000,336.3519287,37.0458984,16.8420410); //
		CreateDynamicObject(1644,-3792.3920898,-3161.0969238,7.8880000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2045,-3783.8459473,-3167.2849121,7.6149998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2228,-3793.4760742,-3167.8979492,8.5799999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(19315,-3825.5749512,-3077.2980957,7.0100002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(19315,-3824.6311035,-3077.1589355,7.0850000,0.0000000,0.0000000,260.0000000); //
		CreateDynamicObject(19320,-3826.2829590,-3172.1169434,7.5599999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(19320,-3825.4418945,-3172.1240234,7.5599999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(19320,-3826.8579102,-3171.6159668,7.5599999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(19320,-3826.4951172,-3172.8940430,7.5599999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(19320,-3825.6879883,-3172.8439941,7.5599999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(19320,-3827.0209961,-3172.4060059,7.5599999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18890,-3793.8840332,-3167.8701172,8.9289999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(339,-3794.1479492,-3167.8510742,8.2720003,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(3031,-3778.1850586,-3140.3391113,6.1719999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2769,-3824.7351074,-3171.4260254,7.2670002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2768,-3825.6079102,-3171.4479980,7.2979999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2769,-3825.6340332,-3170.5219727,7.2670002,0.0000000,0.0000000,310.0000000); //
		CreateDynamicObject(2769,-3825.3989258,-3170.4240723,7.2670002,0.0000000,0.0000000,349.9957275); //
		CreateDynamicObject(2769,-3825.3479004,-3170.7609863,7.2670002,0.0000000,0.0000000,349.9914551); //
		CreateDynamicObject(2769,-3825.3210449,-3170.1398926,7.2670002,0.0000000,0.0000000,349.9914551); //
		CreateDynamicObject(2769,-3825.6579590,-3170.2609863,7.2670002,0.0000000,0.0000000,285.9914551); //
		CreateDynamicObject(2768,-3825.6699219,-3170.9279785,7.2979999,0.0000000,0.0000000,70.0000000); //
		CreateDynamicObject(2768,-3825.9929199,-3171.3149414,7.2979999,0.0000000,0.0000000,69.9993896); //
		CreateDynamicObject(2768,-3825.8110352,-3171.7351074,7.2979999,0.0000000,0.0000000,29.9993896); //
		CreateDynamicObject(2768,-3826.2739258,-3171.3679199,7.2979999,0.0000000,0.0000000,29.9981689); //
		CreateDynamicObject(2768,-3826.5720215,-3171.0329590,7.2979999,0.0000000,0.0000000,9.9981689); //
		CreateDynamicObject(2768,-3826.1120605,-3170.9069824,7.2979999,0.0000000,0.0000000,9.9975586); //
		CreateDynamicObject(2768,-3825.2570801,-3171.6599121,7.2979999,0.0000000,0.0000000,9.9975586); //
		CreateDynamicObject(2768,-3826.9199219,-3171.0769043,7.2979999,0.0000000,0.0000000,9.9975586); //
		CreateDynamicObject(2838,-3826.2929688,-3170.1770020,7.2620001,0.5000000,0.0000000,0.0000000); //
		CreateDynamicObject(2839,-3825.9199219,-3169.5449219,7.2579999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2860,-3825.8129883,-3168.9960938,7.2570000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2803,-3826.0859375,-3167.7770996,7.6910000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2806,-3826.2871094,-3166.5969238,7.4809999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1520,-3826.7199707,-3165.8520508,7.2649999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1520,-3825.6259766,-3166.9309082,7.2560000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1665,-3826.3889160,-3165.6679688,7.3230000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1804,-3793.6110840,-3160.8229980,7.8160000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2146,-3781.5729980,-3138.7070312,4.3270001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2146,-3783.3479004,-3138.7419434,4.3270001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2146,-3781.4951172,-3135.0358887,3.7520001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2146,-3783.0390625,-3135.0200195,3.7520001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2713,-3793.6979980,-3167.3850098,8.1639996,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2827,-3780.6201172,-3138.5629883,4.5019999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2869,-3780.7890625,-3131.2409668,3.1640000,0.0000000,0.0000000,322.0000000); //
		CreateDynamicObject(2869,-3783.3779297,-3131.3540039,3.2760000,0.0000000,0.0000000,323.7500000); //
		CreateDynamicObject(1368,-3786.0729980,-3184.2648926,6.1760001,359.7527466,351.4999084,69.9630432); //
		CreateDynamicObject(3276,-3776.1599121,-3194.7590332,7.0650001,0.0000000,5.2500000,0.0000000); //
		CreateDynamicObject(3276,-3787.7661133,-3194.8239746,8.0400000,359.7518311,7.0000000,0.7804565); //
		CreateDynamicObject(3276,-3799.1960449,-3194.9179688,9.1650000,356.0064697,4.2585754,0.0461426); //
		CreateDynamicObject(3276,-3810.6479492,-3194.8830566,8.6650000,356.0671692,348.7199402,358.9627991); //
		CreateDynamicObject(3276,-3822.0249023,-3194.8479004,6.5400000,356.0723877,348.2171631,358.9233398); //
		CreateDynamicObject(3276,-3831.0930176,-3190.3059082,5.4150000,355.9967041,3.7544250,308.0043945); //
		CreateDynamicObject(3276,-3833.3430176,-3180.1340332,6.2150002,355.9954834,3.7518311,258.0017090); //
		CreateDynamicObject(3276,-3831.0959473,-3169.4169922,7.1650000,355.9852295,2.4932861,257.9097900); //
		CreateDynamicObject(3276,-3828.7138672,-3158.2412109,6.8899999,356.2426758,355.2209473,257.1679688); //
		CreateDynamicObject(3276,-3822.6860352,-3150.4819336,5.1900001,356.2388916,355.9725647,209.2173004); //
		CreateDynamicObject(3276,-3807.0048828,-3142.8515625,5.6399999,356.2261963,358.7200928,215.3924561); //
		CreateDynamicObject(3276,-3797.8808594,-3136.3486328,5.1900001,356.2316895,356.2097168,221.2207031); //
		CreateDynamicObject(3276,-3788.7729492,-3130.0000000,4.0149999,354.7253418,358.4614258,207.3341675); //
		CreateDynamicObject(3276,-3777.9431152,-3127.8369141,4.3649998,354.7210693,358.4564209,177.3339844); //
		CreateDynamicObject(3276,-3769.6289062,-3132.8400879,4.2649999,354.7208862,1.4692078,119.6075134); //
		CreateDynamicObject(3276,-3765.9528809,-3143.4499512,5.6650000,354.7281494,4.2283630,99.8567505); //
		CreateDynamicObject(3276,-3767.1489258,-3192.0820312,6.0149999,359.7500000,359.7459717,39.9989014); //
		CreateDynamicObject(3276,-3762.3400879,-3183.2949219,6.3150001,359.7473755,358.7418213,81.9913330); //
		CreateDynamicObject(3276,-3764.1040039,-3154.0019531,5.4650002,354.7468262,353.4286194,98.8615112); //
		CreateDynamicObject(3014,-3807.1140137,-3146.8330078,5.0640001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(3082,-3794.4609375,-3167.8291016,8.2469997,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(744,-4048.5283203,-3119.8964844,5.9679999,0.0000000,15.9906006,0.0000000); //
		CreateDynamicObject(828,-3996.5600586,-3094.9099121,10.0299997,359.2608337,9.7508240,0.1270142); //
		CreateDynamicObject(896,-3965.5449219,-3236.8779297,11.1759996,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(896,-3975.5234375,-3238.4970703,11.1759996,0.0000000,0.0000000,49.9987793); //
		CreateDynamicObject(896,-3985.9880371,-3237.2270508,10.6759996,68.0000000,0.0000000,33.9987793); //
		CreateDynamicObject(896,-3997.7849121,-3233.6210938,10.6759996,40.0964050,289.8878174,94.6757812); //
		CreateDynamicObject(896,-4005.6669922,-3227.2548828,9.6260004,1.8519592,270.7485352,101.9825439); //
		CreateDynamicObject(896,-3960.4528809,-3180.8049316,11.5080004,1.8511963,270.7470703,61.9805908); //
		CreateDynamicObject(897,-3949.4179688,-3223.5148926,11.3319998,50.2502136,180.0000000,180.0000000); //
		CreateDynamicObject(898,-3945.1621094,-3215.7919922,12.3230000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(899,-3940.2412109,-3203.7197266,10.8230000,0.0000000,0.0000000,59.9963379); //
		CreateDynamicObject(899,-3943.0029297,-3193.1210938,9.2729998,90.0000000,180.0000000,289.9982910); //
		CreateDynamicObject(905,-3924.8574219,-3172.5107422,9.8420000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(897,-3950.6210938,-3181.8081055,10.3920002,21.2248230,28.0557251,33.0695801); //
		CreateDynamicObject(896,-3957.3652344,-3232.0751953,9.6260004,1.8511963,270.7470703,61.9793701); //
		CreateDynamicObject(896,-4001.6669922,-3217.6899414,5.8759999,313.0720825,244.3581238,40.7094116); //
		CreateDynamicObject(896,-3999.2858887,-3208.5859375,5.7010002,43.6951904,275.7890625,221.6649170); //
		CreateDynamicObject(896,-4005.1679688,-3196.8701172,5.7010002,43.9536743,272.1920776,86.8460693); //
		CreateDynamicObject(896,-4010.4829102,-3189.9230957,5.7010002,22.0439453,171.3705444,283.2576904); //
		CreateDynamicObject(896,-3995.5048828,-3179.4418945,5.7010002,22.0385742,171.3702393,273.2550049); //
		CreateDynamicObject(896,-4016.0280762,-3186.5729980,7.6009998,348.3769531,171.8310547,308.3347168); //
		CreateDynamicObject(896,-4000.6210938,-3172.7380371,7.6009998,352.8048096,127.4088440,300.6883240); //
		CreateDynamicObject(896,-4007.8632812,-3166.4375000,7.6009998,348.3709717,171.8206787,278.3276367); //
		CreateDynamicObject(896,-4024.0078125,-3179.1435547,7.6009998,326.6235352,170.3924561,276.6632080); //
		CreateDynamicObject(896,-3963.0949707,-3233.7919922,19.0459995,7.0016174,234.6007690,164.2283936); //
		CreateDynamicObject(896,-3975.9960938,-3237.0480957,19.0459995,6.9982910,234.5965576,324.2236328); //
		CreateDynamicObject(896,-3988.5690918,-3232.7299805,19.0459995,6.9982910,234.5965576,84.2230225); //
		CreateDynamicObject(896,-3995.8271484,-3227.2451172,19.0459995,6.9982910,234.5965576,174.2211914); //
		CreateDynamicObject(896,-3997.5869141,-3219.5947266,15.5710001,6.1138916,127.5732422,157.8295898); //
		CreateDynamicObject(896,-3955.4479980,-3227.3210449,19.0459995,350.9979248,40.6022339,219.7672729); //
		CreateDynamicObject(17026,-3974.9980469,-3183.4462891,7.5920000,0.0000000,0.0000000,51.9818115); //
		CreateDynamicObject(896,-3944.9375000,-3216.1738281,19.0459995,350.9967041,40.5999756,277.7618408); //
		CreateDynamicObject(896,-3946.3203125,-3207.6269531,19.0459995,350.9967041,40.5999756,137.7575684); //
		CreateDynamicObject(896,-3948.8430176,-3194.7119141,23.8589993,48.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(896,-3952.4375000,-3204.3671875,27.7959995,350.9967041,40.5999756,137.7520752); //
		CreateDynamicObject(896,-3953.8920898,-3219.0810547,27.7959995,350.9967041,40.5999756,207.7575684); //
		CreateDynamicObject(896,-3951.6689453,-3214.4921875,27.7959995,350.9967041,40.5999756,267.7532959); //
		CreateDynamicObject(896,-3960.4440918,-3224.5139160,27.7959995,33.3192749,236.2367859,340.7082214); //
		CreateDynamicObject(896,-3969.2451172,-3230.9238281,25.0459995,33.3160400,236.2335205,0.7031250); //
		CreateDynamicObject(896,-3979.4860840,-3230.1579590,25.0459995,33.3160400,236.2335205,290.7031250); //
		CreateDynamicObject(896,-4000.9648438,-3210.3544922,12.5710001,296.2792969,98.0584717,154.9237061); //
		CreateDynamicObject(896,-4005.3059082,-3204.6269531,12.5710001,296.2792969,98.0584717,114.9139404); //
		CreateDynamicObject(896,-3960.3029785,-3188.1909180,24.3209991,296.2792969,98.0584717,164.9194336); //
		CreateDynamicObject(896,-3983.8330078,-3186.2451172,24.3209991,326.2884521,116.6967773,268.1268311); //
		CreateDynamicObject(896,-3962.2399902,-3190.0830078,30.5709991,341.3428955,53.9528809,343.7840576); //
		CreateDynamicObject(896,-3957.6972656,-3201.2246094,32.8209991,341.3342285,53.9373779,343.7731934); //
		CreateDynamicObject(896,-3974.1650391,-3188.3100586,28.4610004,340.4266357,127.9317017,292.6876221); //
		CreateDynamicObject(896,-4018.1608887,-3186.2871094,12.5710001,296.2792969,98.0584717,164.9194336); //
		CreateDynamicObject(896,-3962.4150391,-3195.4970703,4.9660001,333.1274414,41.2152100,109.5392151); //
		CreateDynamicObject(896,-3955.6601562,-3216.0205078,32.8209991,341.3342285,53.9318848,293.7634277); //
		CreateDynamicObject(896,-3962.3049316,-3226.3549805,30.0709991,356.0195312,83.0354919,265.6512451); //
		CreateDynamicObject(896,-3972.9470215,-3229.9509277,30.0709991,302.1654053,70.0126648,100.7721863); //
		CreateDynamicObject(896,-3989.9030762,-3228.9619141,23.0709991,302.1624756,70.0103760,200.7720947); //
		CreateDynamicObject(899,-3979.3183594,-3220.0371094,34.1689987,17.9956055,0.0000000,339.9884033); //
		CreateDynamicObject(744,-3955.9775391,-3201.1074219,38.3279991,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(896,-4000.1660156,-3175.6608887,16.1009998,348.3709717,171.8206787,238.3276367); //
		CreateDynamicObject(896,-4008.2080078,-3182.8100586,21.8509998,294.2840576,81.6452637,320.8341064); //
		CreateDynamicObject(896,-4012.6389160,-3191.2290039,20.8509998,297.6994934,118.9299316,1.9609680); //
		CreateDynamicObject(896,-3991.9880371,-3181.1379395,20.3509998,294.2797852,81.6448975,350.8337402); //
		CreateDynamicObject(880,-4017.9370117,-3159.8579102,16.3169994,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(896,-4000.9650879,-3210.3549805,20.0709991,296.2792969,98.0584717,154.9237061); //
		CreateDynamicObject(896,-3999.7290039,-3192.2390137,20.0709991,296.2792969,98.0584717,154.9237061); //
		CreateDynamicObject(896,-3993.2829590,-3220.7309570,25.5709991,296.2792969,98.0584717,184.9237061); //
		CreateDynamicObject(896,-3996.1269531,-3203.2871094,25.5709991,329.8627014,30.4572144,102.3975525); //
		CreateDynamicObject(896,-3970.9765625,-3197.7871094,36.7260017,329.8590088,30.4486084,140.3887939); //
		CreateDynamicObject(899,-4028.0644531,-3158.2519531,18.6389999,354.0179443,184.0209961,110.4125977); //
		CreateDynamicObject(896,-3994.1562500,-3192.0683594,30.0709991,329.8590088,30.4486084,142.3883057); //
		CreateDynamicObject(896,-3981.9431152,-3191.2229004,31.7259998,60.7332764,330.3218994,172.3775024); //
		CreateDynamicObject(896,-3985.4912109,-3202.5097656,35.7260017,60.7324219,330.3149414,172.3699951); //
		CreateDynamicObject(899,-3981.5791016,-3231.4902344,28.7369995,63.9953613,0.0000000,339.9884033); //
		CreateDynamicObject(896,-3980.8779297,-3219.3798828,35.1619987,348.5412598,34.7662354,243.8800049); //
		CreateDynamicObject(898,-3977.6738281,-3197.7744141,38.5940018,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(896,-4019.2009277,-3156.4240723,7.6009998,326.6235352,170.3924561,276.6632080); //
		CreateDynamicObject(896,-4034.7290039,-3171.3110352,7.6009998,289.8767090,155.8001709,219.0725098); //
		CreateDynamicObject(896,-4043.8400879,-3158.4240723,7.6009998,8.0928040,247.3292236,111.3584595); //
		CreateDynamicObject(896,-4026.6621094,-3146.7280273,7.6009998,348.0357361,237.9304657,282.2823792); //
		CreateDynamicObject(896,-4012.1130371,-3175.7819824,14.1009998,289.8767090,155.8001709,219.0725098); //
		CreateDynamicObject(896,-4014.2219238,-3166.8039551,17.6009998,354.6081238,87.3904419,148.1066895); //
		CreateDynamicObject(896,-4022.4150391,-3173.5439453,17.6009998,354.6057129,87.3852539,248.1011963); //
		CreateDynamicObject(899,-3992.6054688,-3217.2539062,28.7369995,63.9953613,0.0000000,289.9896240); //
		CreateDynamicObject(880,-3944.9335938,-3141.1826172,18.2579994,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14608,-3966.2338867,-3228.8479004,9.1000004,0.0000000,4.2500000,332.0000000); //
		CreateDynamicObject(14608,-3954.5839844,-3205.5771484,11.6009998,0.0000000,0.0000000,59.9963379); //
		CreateDynamicObject(2404,-3783.0644531,-3167.7333984,8.7370005,0.0000000,0.0000000,69.9993896); //
		CreateDynamicObject(880,-3964.8828125,-3231.8056641,11.7500000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(880,-3967.9479980,-3217.7729492,7.8460002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(880,-3952.2290039,-3202.5319824,10.6859999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1550,-3976.1870117,-3217.9150391,8.7139997,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1550,-3978.1860352,-3218.3879395,8.3680000,0.0000000,0.0000000,300.0000000); //
		CreateDynamicObject(1550,-3977.5778809,-3219.5290527,8.3000002,0.0000000,0.0000000,80.0000000); //
		CreateDynamicObject(1550,-3976.8920898,-3219.7160645,8.2270002,0.0000000,0.0000000,300.0000000); //
		CreateDynamicObject(1550,-3976.5791016,-3218.4838867,8.7170000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1550,-3976.8999023,-3220.9499512,8.2360001,0.0000000,28.0000000,170.0000000); //
		CreateDynamicObject(1550,-3976.5061035,-3219.4699707,8.1809998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1550,-3962.7438965,-3216.5439453,9.0699997,0.0000000,0.0000000,70.0000000); //
		CreateDynamicObject(1550,-3968.7028809,-3228.9990234,8.1910000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1550,-3959.5930176,-3214.3701172,9.3039999,84.0000000,180.0000000,260.0000000); //
		CreateDynamicObject(1550,-3960.0910645,-3214.3439941,9.5909996,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1550,-3959.0139160,-3214.0869141,9.6300001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1550,-3963.1818848,-3216.9938965,8.9700003,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1550,-3963.2548828,-3208.1540527,10.8190002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1550,-3961.2028809,-3207.0039062,10.2410002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2332,-3952.2119141,-3209.4489746,10.4110003,0.0000000,0.0000000,300.0000000); //
		CreateDynamicObject(1550,-3978.8840332,-3219.7141113,8.3959999,0.0000000,0.0000000,290.0000000); //
		CreateDynamicObject(2332,-3954.1079102,-3201.5939941,10.6969995,0.0000000,0.0000000,240.0000000); //
		CreateDynamicObject(1829,-3963.1311035,-3217.7209473,8.9940004,0.0000000,349.5000000,82.0000000); //
		CreateDynamicObject(1550,-3977.9199219,-3219.0258789,8.3360004,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1550,-3976.7709961,-3217.8110352,8.7139997,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1550,-3965.9960938,-3209.7199707,9.8820000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1550,-3977.1079102,-3220.1499023,8.2349997,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1550,-3977.2990723,-3216.9470215,8.2709999,34.5000000,0.0000000,290.0000000); //
		CreateDynamicObject(1550,-3977.3200684,-3220.9929199,8.2309999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1550,-3978.5620117,-3220.1330566,8.1350002,328.2126465,266.1085205,122.8915405); //
		CreateDynamicObject(1550,-3976.8200684,-3219.2180176,8.1829996,0.0000000,14.0000000,60.0000000); //
		CreateDynamicObject(1550,-3978.0471191,-3221.5791016,8.2530003,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2311,-3976.7609863,-3217.7370605,7.8150001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2311,-3976.7500000,-3218.5590820,7.8179998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1550,-3977.6738281,-3217.1777344,8.3170004,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1550,-3976.5478516,-3220.2226562,8.1770000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2833,-3977.2480469,-3216.3486328,7.9610000,0.0000000,0.0000000,31.9976807); //
		CreateDynamicObject(14705,-3976.8830566,-3218.7919922,8.5719995,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14705,-3975.5129395,-3217.9870605,8.5690002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1725,-3975.1069336,-3194.8430176,8.6850004,0.0000000,0.0000000,350.0000000); //
		CreateDynamicObject(2803,-3956.9719238,-3201.0878906,10.6639996,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2805,-3956.8820801,-3201.6909180,10.7049999,305.9967041,0.0000000,0.0000000); //
		CreateDynamicObject(2805,-3957.5759277,-3200.7260742,10.8000002,11.9970703,0.0000000,27.9986572); //
		CreateDynamicObject(9833,-3981.8095703,-3210.4277344,6.9800000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14402,-3938.1269531,-3204.4221191,16.4459991,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14402,-3944.2280273,-3186.7041016,21.7800007,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(9153,-3872.1840820,-3186.3168945,7.2420001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(9153,-3964.5520020,-3036.6130371,11.2200003,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(9152,-3838.4318848,-3163.3549805,7.6020002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(3520,-3946.1450195,-3196.0610352,29.1130009,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(3472,-3973.6044922,-3210.5244141,35.8059998,1.9995117,179.9945068,179.9945068); //
		CreateDynamicObject(710,-3810.5458984,-3108.9179688,18.6760006,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3806.0659180,-3119.3911133,17.9260006,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3801.0190430,-3112.1279297,17.9260006,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3798.3349609,-3122.3530273,18.9260006,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3801.2260742,-3099.4780273,18.9260006,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3791.3269043,-3104.1730957,18.9260006,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3788.9399414,-3113.1970215,18.9260006,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3778.4799805,-3114.2749023,18.9260006,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3783.3278809,-3105.5439453,18.9260006,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3804.8400879,-3090.9230957,18.9260006,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3795.0400391,-3094.9809570,18.9260006,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3774.8500977,-3105.8278809,18.9260006,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3780.1818848,-3098.8359375,18.9260006,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3786.5568848,-3093.9008789,18.9260006,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3799.1220703,-3087.7409668,18.9260006,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3769.2949219,-3113.7570801,18.9260006,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3762.7382812,-3114.5576172,18.9260006,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3766.6059570,-3105.8769531,18.9260006,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3772.1689453,-3098.9819336,18.9260006,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3767.2900391,-3091.8181152,18.9260006,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3776.1330566,-3090.0690918,18.9260006,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3784.3159180,-3085.3410645,18.9260006,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3793.3339844,-3081.8950195,18.9260006,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3793.0800781,-3071.3830566,18.9260006,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3766.5339355,-2631.1621094,27.4839993,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3789.8549805,-3064.4770508,18.9260006,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(672,-3794.5170898,-3108.6750488,5.6960001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(838,-3805.7558594,-3106.5761719,6.4229999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(892,-3773.1411133,-3113.6621094,5.3769999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(892,-3785.1738281,-3111.3789062,6.3540001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(892,-3792.5080566,-3088.5290527,5.1399999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(892,-3787.9450684,-3079.5229492,3.5550001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(892,-3793.0310059,-3118.2790527,5.6100001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(892,-3817.2539062,-3101.1989746,3.9820001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(622,-3776.9902344,-3118.4062500,5.8850002,0.0000000,0.0000000,169.9859619); //
		CreateDynamicObject(622,-3753.9160156,-3126.3789062,2.0599999,0.0000000,0.0000000,129.9847412); //
		CreateDynamicObject(710,-3764.7460938,-3124.4890137,19.1879997,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(673,-3795.7099609,-3064.8320312,6.2750001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(673,-3797.2128906,-3078.3535156,4.9050002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(673,-3779.7749023,-3094.7209473,5.3759999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14469,-3765.7219238,-3119.5090332,4.5549998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14469,-3940.0600586,-3217.3400879,25.6000004,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(762,-3866.9729004,-3214.3789062,6.2389998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(767,-3765.2880859,-3110.8037109,4.2410002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(767,-3776.5009766,-3111.2419434,5.7690001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(767,-3767.9833984,-3085.5000000,4.1669998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(760,-3809.3391113,-3082.5239258,6.9800000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(760,-3771.8911133,-3087.5371094,4.6430001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(760,-3771.8500977,-3087.5500488,4.6469998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(760,-3777.3430176,-3094.9279785,5.4549999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(760,-3779.2019043,-3106.0659180,5.6770000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(760,-3811.9230957,-3075.9069824,7.3230000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(770,-3764.5332031,-3099.9277344,2.9640000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(770,-3781.9431152,-3069.4790039,4.8930001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(732,-3794.6230469,-3059.3847656,6.3439999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(726,-3811.9658203,-3137.4189453,5.1209998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(3017,-3975.7819824,-3218.7590332,8.3450003,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2894,-3975.2370605,-3218.2939453,8.3230000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2287,-3951.6779785,-3209.1079102,12.1330004,333.7500000,0.0000000,307.0000000); //
		CreateDynamicObject(2176,-3958.9082031,-3209.6533203,12.0839996,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2906,-3976.6918945,-3205.8378906,6.9020000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2906,-3975.9008789,-3217.2561035,7.9619999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2683,-3826.5878906,-3164.9931641,7.3899999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(905,-3957.0400391,-3210.2260742,29.0960007,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(905,-3957.8049316,-3210.3620605,28.0020008,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(905,-3957.2822266,-3210.3359375,28.7800007,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(905,-3957.4719238,-3210.0410156,28.3740005,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(905,-3957.1640625,-3204.0729980,27.0960007,0.0000000,0.0000000,34.0000000); //
		CreateDynamicObject(905,-3957.8789062,-3210.0390625,27.6009998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(905,-3958.2700195,-3209.9489746,26.9629993,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(896,-3953.8588867,-3203.8869629,32.5709991,347.8241577,28.4434814,126.6302490); //
		CreateDynamicObject(880,-3941.5358887,-3203.6040039,18.7910004,0.0000000,0.0000000,40.0000000); //
		CreateDynamicObject(744,-3949.5019531,-3199.9809570,32.5639992,0.0000000,0.0000000,50.0000000); //
		CreateDynamicObject(744,-3965.4370117,-3203.7390137,35.2270012,74.0000000,0.0000000,90.0000000); //
		CreateDynamicObject(3269,-4031.7480469,-2961.2758789,6.9180002,3.4738770,352.9869995,0.4270325); //
		CreateDynamicObject(3528,-3962.5991211,-3220.9069824,16.6739998,0.0000000,0.0000000,143.9935303); //
		CreateDynamicObject(18309,-2426.9375000,-1530.4531250,440.9687500,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2404,-3996.3249512,-3021.1230469,10.0380001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2405,-3997.1899414,-3021.2009277,10.0380001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2410,-4256.4741211,-2902.7900391,21.5380001,359.8605042,86.0024414,331.9951172); //
		CreateDynamicObject(1641,-3996.7338867,-3022.4560547,8.7880001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(19319,-3991.5910645,-3027.7399902,9.4630003,348.0000000,0.0000000,270.0000000); //
		CreateDynamicObject(19169,-3991.5200195,-3026.1020508,10.5319996,88.7499084,0.0000000,272.2500000); //
		CreateDynamicObject(2636,-3997.6120605,-3025.6540527,9.4239998,0.0000000,0.0000000,89.9981689); //
		CreateDynamicObject(2096,-4004.0681152,-3022.6530762,8.7880001,0.0000000,0.0000000,290.0000000); //
		CreateDynamicObject(2096,-4004.1721191,-3023.5620117,8.7880001,0.0000000,0.0000000,255.9951172); //
		CreateDynamicObject(2268,-3995.6760254,-3036.4570312,10.2130003,0.0000000,0.0000000,182.5000000); //
		CreateDynamicObject(1433,-4002.7351074,-3023.5539551,8.9680004,0.0000000,0.0000000,29.9981689); //
		CreateDynamicObject(1668,-4002.7590332,-3023.5290527,9.6429996,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(653,-3884.4829102,-2812.0229492,1.6100000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(653,-3928.5175781,-2903.3593750,3.9960001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(653,-3934.7578125,-2900.2187500,4.2160001,0.0000000,0.0000000,209.9981689); //
		CreateDynamicObject(896,-3963.1435547,-3210.1425781,32.8209991,341.3342285,53.9263916,13.7603760); //
		CreateDynamicObject(896,-3983.2438965,-3202.1679688,35.7260017,60.7324219,330.3149414,202.3699951); //
		CreateDynamicObject(3260,-3973.0009766,-3207.8740234,35.4760017,270.4943848,179.9945068,245.9893799); //
		CreateDynamicObject(3260,-3973.8420410,-3206.4008789,35.4760017,270.4998779,179.9945068,105.9948730); //
		CreateDynamicObject(3260,-3971.6220703,-3206.6560059,35.4760017,270.4998779,179.9945068,155.9948730); //
		CreateDynamicObject(3260,-3974.4020996,-3204.7429199,35.4760017,270.4943848,179.9945068,55.9906006); //
		CreateDynamicObject(899,-3994.8359375,-3161.9409180,6.3460002,354.0179443,184.0209961,110.4125977); //
		CreateDynamicObject(899,-4011.6149902,-3160.3850098,4.0960002,354.0179443,184.0209961,180.4125977); //
		CreateDynamicObject(653,-4020.9499512,-2707.9389648,5.4229999,0.0000000,0.0000000,90.0000000); //
		CreateDynamicObject(653,-4011.0048828,-2705.2500000,4.6320000,0.0000000,0.0000000,320.0000000); //
		CreateDynamicObject(653,-4006.7419434,-2696.8940430,4.5830002,0.0000000,0.0000000,50.0000000); //
		CreateDynamicObject(653,-4017.0070801,-2690.4790039,3.3080001,0.0000000,0.0000000,300.0000000); //
		CreateDynamicObject(653,-4004.7470703,-2687.2009277,3.9250000,0.0000000,0.0000000,346.0000000); //
		CreateDynamicObject(653,-3990.8134766,-2676.2568359,3.7230000,0.0000000,0.0000000,299.9981689); //
		CreateDynamicObject(653,-3984.0380859,-2665.9221191,3.9110000,0.0000000,0.0000000,290.0000000); //
		CreateDynamicObject(653,-3969.3642578,-2688.2353516,3.3659999,0.0000000,0.0000000,309.9957275); //
		CreateDynamicObject(653,-3977.0029297,-2675.7250977,4.4310002,0.0000000,0.0000000,40.0000000); //
		CreateDynamicObject(653,-3981.7990723,-2694.7028809,6.7890000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(653,-3973.9079590,-2699.4169922,5.5079999,0.0000000,0.0000000,40.0000000); //
		CreateDynamicObject(651,-3993.0891113,-2690.6818848,5.1799998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(651,-3986.3720703,-2692.5930176,6.6900001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(651,-3983.7919922,-2673.0720215,4.3220000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(651,-3994.3979492,-2681.2900391,4.2680001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(651,-3976.7280273,-2686.1599121,5.0200000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(651,-3985.7409668,-2708.4909668,7.5580001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(682,-3978.7028809,-2690.3278809,5.8629999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(682,-3983.0449219,-2688.1469727,6.4640002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(682,-3993.0891113,-2686.4938965,4.7600002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(682,-4000.8769531,-2699.6049805,4.8769999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(682,-4008.6699219,-2667.9399414,0.8610000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(682,-3998.7028809,-2695.0681152,4.2820001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(682,-3990.8601074,-2706.2690430,7.5479999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(682,-4018.0529785,-2697.6669922,3.9840000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(682,-4016.3701172,-2704.8850098,4.6970000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(692,-4014.4289551,-2696.2990723,3.8780000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(692,-4011.3840332,-2695.9619141,4.2839999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(692,-3996.2409668,-2689.4221191,4.5720000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(692,-3991.8159180,-2682.6540527,4.6129999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(692,-3977.1188965,-2677.4199219,4.6220002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(692,-4000.9130859,-2698.4099121,4.6199999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(692,-3999.4838867,-2698.7260742,4.9219999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(692,-3976.9899902,-2700.0849609,6.2300000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(692,-4019.1220703,-2708.1909180,5.1929998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(728,-4004.5791016,-2702.5458984,5.1240001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(728,-4003.5610352,-2703.0659180,5.4060001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(728,-4543.0849609,-3209.9499512,13.8009996,8.2492981,359.2421875,0.1087341); //
		CreateDynamicObject(754,-3984.9570312,-2677.8149414,4.8030000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(754,-3990.4741211,-2691.0729980,5.7820001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(754,-3981.9729004,-2696.2819824,6.8610001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(754,-4004.9030762,-2688.8010254,4.1849999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(754,-4014.9560547,-2706.1269531,4.6680002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(757,-4008.0520020,-2698.3149414,4.6589999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(757,-4020.0000000,-2706.9040527,5.2259998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(757,-3989.0710449,-2702.4309082,7.3940001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(757,-3997.9890137,-2704.9060059,6.3649998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(757,-3993.8000488,-2709.0161133,7.4710002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(757,-3973.5429688,-2679.8181152,4.0640001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(801,-3987.1508789,-2695.1289062,6.7890000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(12857,-3723.2236328,-2974.8046875,-1.9180000,0.0000000,0.0000000,257.9919434); //
		CreateDynamicObject(18751,-3954.2509766,-2744.7648926,1.4190000,1.2414551,0.2471924,65.9719238); //
		CreateDynamicObject(18228,-3942.8896484,-2772.2460938,0.6370000,0.0000000,0.0000000,311.9952393); //
		CreateDynamicObject(16112,-4061.8466797,-2839.0888672,6.2220001,0.0000000,0.0000000,1.9995117); //
		CreateDynamicObject(16120,-4028.6660156,-3200.0849609,7.6700001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(16122,-4057.1171875,-2901.8857422,4.7240000,0.0000000,0.0000000,17.9956055); //
		CreateDynamicObject(960,-3993.9489746,-3034.7680664,9.1700001,0.0000000,0.0000000,335.0000000); //
		CreateDynamicObject(960,-3618.3750000,-2336.5390625,2.2820001,0.0000000,0.0000000,24.9938965); //
		CreateDynamicObject(933,-3998.3193359,-3032.5468750,8.7880001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2908,-3993.8669434,-3034.7729492,8.9480000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1777,-4042.6298828,-2715.7360840,0.4200000,297.5672607,339.1062317,281.3041992); //
		CreateDynamicObject(1369,-4023.4541016,-2964.0219727,9.4879999,359.5029602,353.7497559,129.9455872); //
		CreateDynamicObject(11496,-3887.8857422,-3058.5478516,40.1419983,0.0000000,0.0000000,45.9997559); //
		CreateDynamicObject(19433,-3883.9221191,-3062.3469238,42.0919991,0.0000000,0.0000000,316.0000000); //
		CreateDynamicObject(19360,-3882.8911133,-3059.1540527,42.0919991,0.0000000,0.0000000,45.9997559); //
		CreateDynamicObject(19406,-3885.1550293,-3056.9350586,42.0919991,0.0000000,0.0000000,45.9997559); //
		CreateDynamicObject(19433,-3893.1330566,-3053.7900391,42.0919991,0.0000000,0.0000000,315.9997559); //
		CreateDynamicObject(19433,-3884.7199707,-3063.1730957,42.0919991,0.0000000,0.0000000,315.9997559); //
		CreateDynamicObject(19433,-3893.5270996,-3054.2019043,42.0919991,0.0000000,0.0000000,315.9997559); //
		CreateDynamicObject(19433,-3885.7041016,-3064.1730957,42.0919991,0.0000000,0.0000000,315.9997559); //
		CreateDynamicObject(19433,-3894.6369629,-3055.3168945,42.0919991,0.0000000,0.0000000,315.9997559); //
		CreateDynamicObject(19360,-3883.0090332,-3059.1560059,43.7669983,0.0000000,90.0000000,45.9998474); //
		CreateDynamicObject(19360,-3885.4431152,-3061.6750488,43.7669983,0.0000000,90.0000000,45.9997559); //
		CreateDynamicObject(19360,-3885.2990723,-3056.9208984,43.7919998,0.0000000,90.0000000,45.9997559); //
		CreateDynamicObject(19360,-3887.7319336,-3059.4299316,43.7919998,0.0000000,90.0000000,45.9997559); //
		CreateDynamicObject(19360,-3887.6320801,-3054.7309570,43.7669983,0.0000000,90.0000000,45.9997559); //
		CreateDynamicObject(19360,-3889.8950195,-3052.5419922,43.7669983,0.0000000,90.0000000,45.9997559); //
		CreateDynamicObject(19360,-3890.0410156,-3057.2363281,43.7669983,0.0000000,90.0000000,45.9997559); //
		CreateDynamicObject(19360,-3891.2646484,-3053.9472656,43.7669983,0.0000000,90.0000000,45.9997559); //
		CreateDynamicObject(19360,-3892.4541016,-3059.7351074,43.7669983,0.0000000,90.0000000,45.9997559); //
		CreateDynamicObject(19360,-3890.1240234,-3061.9060059,43.7919998,0.0000000,90.0000000,45.9997559); //
		CreateDynamicObject(19360,-3887.8759766,-3064.1870117,43.7669983,0.0000000,90.0000000,45.9997559); //
		CreateDynamicObject(19433,-3883.4340820,-3061.8469238,42.0919991,0.0000000,0.0000000,315.9997559); //
		CreateDynamicObject(19433,-3882.9980469,-3061.3662109,43.7669983,90.0000000,180.4010010,135.5932617); //
		CreateDynamicObject(19433,-3885.4208984,-3063.8649902,43.7669983,90.0000000,180.4010010,135.5932617); //
		CreateDynamicObject(19406,-3893.5537109,-3056.3261719,43.7669983,0.0000000,89.4946289,45.9942627); //
		CreateDynamicObject(19433,-3892.0229492,-3052.6569824,43.7669983,90.0000000,180.4010010,135.5932617); //
		CreateDynamicObject(19433,-3891.4130859,-3052.0009766,42.0919991,0.0000000,0.0000000,315.9997559); //
		CreateDynamicObject(19433,-3892.1979980,-3052.8339844,42.0919991,0.0000000,0.0000000,315.9997559); //
		CreateDynamicObject(19433,-3894.4121094,-3055.1340332,43.7669983,90.0000000,180.4010010,135.5932617); //
		CreateDynamicObject(19433,-3889.6889648,-3052.6311035,43.7669983,90.0000000,180.4010010,45.5932617); //
		CreateDynamicObject(19433,-3887.2089844,-3055.0249023,43.7669983,90.0000000,180.3955078,45.5877686); //
		CreateDynamicObject(19433,-3884.6931152,-3057.4580078,43.7669983,90.0000000,180.3955078,45.5877686); //
		CreateDynamicObject(19433,-3883.0500488,-3059.0490723,43.7669983,90.0000000,180.3955078,45.5877686); //
		CreateDynamicObject(19360,-3889.6840820,-3052.5939941,42.0919991,0.0000000,0.0000000,45.9997559); //
		CreateDynamicObject(896,-3970.8417969,-3216.1230469,39.1049995,348.5357666,34.7607422,243.8800049); //
		CreateDynamicObject(2636,-3885.2790527,-3057.8549805,40.9780006,0.0000000,0.0000000,316.0000000); //
		CreateDynamicObject(2636,-3886.1660156,-3056.8830566,40.9780006,0.0000000,0.0000000,135.9997559); //
		CreateDynamicObject(1433,-3885.7270508,-3057.3349609,40.5219994,0.0000000,0.0000000,316.0000000); //
		CreateDynamicObject(2090,-3889.3916016,-3055.0263672,40.3419991,0.0000000,0.0000000,45.9997559); //
		CreateDynamicObject(2835,-3883.2309570,-3061.0161133,40.3419991,0.0000000,0.0000000,48.0000000); //
		CreateDynamicObject(6964,-4050.5742188,-3060.1210938,7.2560000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(3930,-4042.9008789,-3064.2719727,7.8660002,0.0000000,0.0000000,291.9981689); //
		CreateDynamicObject(3930,-4043.1770020,-3064.6279297,7.8660002,0.0000000,0.0000000,291.9946289); //
		CreateDynamicObject(3930,-4043.4541016,-3064.9838867,7.8660002,0.0000000,0.0000000,291.9946289); //
		CreateDynamicObject(3930,-4043.7509766,-3065.3239746,7.8660002,0.0000000,0.0000000,291.9946289); //
		CreateDynamicObject(3930,-4044.0129395,-3065.6599121,7.8660002,0.0000000,0.0000000,291.9946289); //
		CreateDynamicObject(3930,-4044.2739258,-3065.9951172,7.8660002,0.0000000,0.0000000,291.9946289); //
		CreateDynamicObject(3930,-4044.5349121,-3066.3310547,7.8660002,0.0000000,0.0000000,291.9946289); //
		CreateDynamicObject(3930,-4044.7958984,-3066.6669922,7.8660002,0.0000000,0.0000000,291.9946289); //
		CreateDynamicObject(3930,-4045.5280762,-3067.2070312,7.8660002,0.0000000,0.0000000,265.9946289); //
		CreateDynamicObject(3930,-4045.9050293,-3067.4020996,7.8660002,0.0000000,0.0000000,265.9899902); //
		CreateDynamicObject(3930,-4046.3039551,-3067.6079102,7.8660002,0.0000000,0.0000000,265.9899902); //
		CreateDynamicObject(3930,-4046.7041016,-3067.8139648,7.8660002,0.0000000,0.0000000,265.9899902); //
		CreateDynamicObject(3930,-4047.1040039,-3068.0200195,7.8660002,0.0000000,0.0000000,265.9899902); //
		CreateDynamicObject(3930,-4047.5039062,-3068.2260742,7.8660002,0.0000000,0.0000000,265.9899902); //
		CreateDynamicObject(3930,-4047.9040527,-3068.4318848,7.8660002,0.0000000,0.0000000,265.9899902); //
		CreateDynamicObject(3930,-4048.3029785,-3068.6379395,7.8660002,0.0000000,0.0000000,265.9899902); //
		CreateDynamicObject(3930,-4049.1049805,-3068.7009277,7.8660002,0.0000000,0.0000000,239.9899902); //
		CreateDynamicObject(3930,-4049.5349121,-3068.7089844,7.8660002,0.0000000,0.0000000,239.9853516); //
		CreateDynamicObject(3930,-4049.9890137,-3068.7209473,7.8660002,0.0000000,0.0000000,239.9853516); //
		CreateDynamicObject(3930,-4050.4370117,-3068.7119141,7.8660002,0.0000000,0.0000000,239.9853516); //
		CreateDynamicObject(3930,-4050.8850098,-3068.7028809,7.8660002,0.0000000,0.0000000,239.9853516); //
		CreateDynamicObject(3930,-4051.3330078,-3068.6931152,7.8660002,0.0000000,0.0000000,239.9853516); //
		CreateDynamicObject(3930,-4051.7810059,-3068.6840820,7.8660002,0.0000000,0.0000000,239.9853516); //
		CreateDynamicObject(3930,-4052.2041016,-3068.6750488,7.8660002,0.0000000,0.0000000,239.9853516); //
		CreateDynamicObject(3930,-4052.9599609,-3068.5109863,7.8660002,0.0000000,0.0000000,213.9853516); //
		CreateDynamicObject(3930,-4053.3659668,-3068.3159180,7.8660002,0.0000000,0.0000000,213.9807129); //
		CreateDynamicObject(3930,-4053.7700195,-3068.1220703,7.8660002,0.0000000,0.0000000,213.9807129); //
		CreateDynamicObject(3930,-4054.1621094,-3067.9619141,7.8660002,0.0000000,0.0000000,213.9807129); //
		CreateDynamicObject(3930,-4054.5439453,-3067.7790527,7.8660002,0.0000000,0.0000000,213.9807129); //
		CreateDynamicObject(3930,-4054.9479980,-3067.5849609,7.8660002,0.0000000,0.0000000,213.9807129); //
		CreateDynamicObject(3930,-4055.3520508,-3067.3920898,7.8660002,0.0000000,0.0000000,213.9807129); //
		CreateDynamicObject(3930,-4055.7338867,-3067.2089844,7.8660002,0.0000000,0.0000000,213.9807129); //
		CreateDynamicObject(3930,-4056.3540039,-3066.6799316,7.8660002,0.0000000,0.0000000,187.9807129); //
		CreateDynamicObject(3930,-4056.6169434,-3066.3420410,7.8660002,0.0000000,0.0000000,187.9807129); //
		CreateDynamicObject(3930,-4056.8969727,-3066.0209961,7.8660002,0.0000000,0.0000000,187.9760742); //
		CreateDynamicObject(3930,-4057.1950684,-3065.6818848,7.8660002,0.0000000,0.0000000,187.9760742); //
		CreateDynamicObject(3930,-4057.4340820,-3065.3330078,7.8660002,0.0000000,0.0000000,187.9760742); //
		CreateDynamicObject(3930,-4057.6909180,-3064.9970703,7.8660002,0.0000000,0.0000000,187.9760742); //
		CreateDynamicObject(3930,-4057.9680176,-3064.6760254,7.8660002,0.0000000,0.0000000,187.9760742); //
		CreateDynamicObject(3930,-4058.2250977,-3064.3400879,7.8660002,0.0000000,0.0000000,187.9760742); //
		CreateDynamicObject(3930,-4058.6721191,-3063.4709473,7.8660002,0.0000000,0.0000000,161.9760742); //
		CreateDynamicObject(3930,-4058.7729492,-3063.0839844,7.8660002,0.0000000,0.0000000,161.9714355); //
		CreateDynamicObject(3930,-4058.8701172,-3062.6960449,7.8660002,0.0000000,0.0000000,161.9714355); //
		CreateDynamicObject(3930,-4058.9489746,-3062.2519531,7.8660002,0.0000000,0.0000000,161.9714355); //
		CreateDynamicObject(3930,-4059.0520020,-3061.8129883,7.8660002,0.0000000,0.0000000,161.9714355); //
		CreateDynamicObject(3930,-4059.1560059,-3061.3730469,7.8660002,0.0000000,0.0000000,161.9714355); //
		CreateDynamicObject(3930,-4059.2590332,-3060.9340820,7.8660002,0.0000000,0.0000000,161.9714355); //
		CreateDynamicObject(3930,-4059.2971191,-3059.6101074,7.8660002,0.0000000,0.0000000,137.9714355); //
		CreateDynamicObject(3930,-4059.3339844,-3060.5148926,6.8160000,0.0000000,0.0000000,161.9714355); //
		CreateDynamicObject(3930,-4059.3339844,-3060.5148926,7.3410001,0.0000000,0.0000000,161.9714355); //
		CreateDynamicObject(3930,-4059.2590332,-3060.9340820,7.3909998,0.0000000,0.0000000,161.9714355); //
		CreateDynamicObject(3930,-4059.2590332,-3060.9340820,6.7659998,0.0000000,0.0000000,161.9714355); //
		CreateDynamicObject(3930,-4059.1550293,-3061.3730469,7.3909998,0.0000000,0.0000000,161.9714355); //
		CreateDynamicObject(3930,-4059.1540527,-3061.3730469,6.7160001,0.0000000,0.0000000,161.9714355); //
		CreateDynamicObject(3930,-4059.0520020,-3061.8129883,7.3660002,0.0000000,0.0000000,161.9714355); //
		CreateDynamicObject(3930,-4059.0520020,-3061.8129883,6.6910000,0.0000000,0.0000000,161.9714355); //
		CreateDynamicObject(3930,-4058.9479980,-3062.2519531,7.3160000,0.0000000,0.0000000,161.9714355); //
		CreateDynamicObject(3930,-4058.9470215,-3062.2519531,6.6659999,0.0000000,0.0000000,161.9714355); //
		CreateDynamicObject(3930,-4058.8701172,-3062.6950684,7.3160000,0.0000000,0.0000000,161.9714355); //
		CreateDynamicObject(3930,-4058.8701172,-3062.6940918,6.6659999,0.0000000,0.0000000,161.9714355); //
		CreateDynamicObject(3930,-4058.7729492,-3063.0839844,7.2909999,0.0000000,0.0000000,161.9714355); //
		CreateDynamicObject(3930,-4058.7729492,-3063.0839844,6.6160002,0.0000000,0.0000000,161.9714355); //
		CreateDynamicObject(3930,-4058.6721191,-3063.4709473,7.2410002,0.0000000,0.0000000,161.9714355); //
		CreateDynamicObject(3930,-4058.6721191,-3063.4709473,6.5910001,0.0000000,0.0000000,161.9714355); //
		CreateDynamicObject(3930,-4058.2250977,-3064.3400879,7.2410002,0.0000000,0.0000000,187.9760742); //
		CreateDynamicObject(3930,-4058.2250977,-3064.3400879,6.5910001,0.0000000,0.0000000,187.9760742); //
		CreateDynamicObject(3930,-4057.9680176,-3064.6760254,7.2410002,0.0000000,0.0000000,187.9760742); //
		CreateDynamicObject(3930,-4057.9680176,-3064.6760254,6.6160002,0.0000000,0.0000000,187.9760742); //
		CreateDynamicObject(3930,-4057.6909180,-3064.9970703,7.2160001,0.0000000,0.0000000,187.9760742); //
		CreateDynamicObject(3930,-4057.6909180,-3064.9970703,6.5910001,0.0000000,0.0000000,187.9760742); //
		CreateDynamicObject(3930,-4057.4340820,-3065.3330078,7.2160001,0.0000000,0.0000000,187.9760742); //
		CreateDynamicObject(3930,-4057.4340820,-3065.3330078,6.5910001,0.0000000,0.0000000,187.9760742); //
		CreateDynamicObject(3930,-4057.1940918,-3065.6818848,7.2410002,0.0000000,0.0000000,187.9760742); //
		CreateDynamicObject(3930,-4056.8969727,-3066.0209961,7.2160001,0.0000000,0.0000000,187.9760742); //
		CreateDynamicObject(3930,-4056.6159668,-3066.3420410,7.2160001,0.0000000,0.0000000,187.9760742); //
		CreateDynamicObject(3930,-4056.3540039,-3066.6799316,7.2160001,0.0000000,0.0000000,187.9760742); //
		CreateDynamicObject(3930,-4055.7338867,-3067.2089844,7.2160001,0.0000000,0.0000000,213.9807129); //
		CreateDynamicObject(3930,-4055.3520508,-3067.3920898,7.2160001,0.0000000,0.0000000,213.9807129); //
		CreateDynamicObject(3930,-4059.2241211,-3059.1640625,7.8660002,0.0000000,0.0000000,137.9663086); //
		CreateDynamicObject(3930,-4059.1450195,-3058.7199707,7.8660002,0.0000000,0.0000000,137.9663086); //
		CreateDynamicObject(3930,-4059.0659180,-3058.2758789,7.8660002,0.0000000,0.0000000,137.9663086); //
		CreateDynamicObject(3930,-4058.9860840,-3057.8320312,7.8660002,0.0000000,0.0000000,134.7163086); //
		CreateDynamicObject(3930,-4058.8820801,-3057.3930664,7.8660002,0.0000000,0.0000000,134.7163391); //
		CreateDynamicObject(3930,-4058.7780762,-3056.9528809,7.8660002,0.0000000,0.0000000,134.7143555); //
		CreateDynamicObject(3930,-4058.6740723,-3056.5129395,7.8660002,0.0000000,0.0000000,134.7143555); //
		CreateDynamicObject(3930,-4058.2500000,-3055.9541016,7.8660002,0.0000000,0.0000000,110.7143250); //
		CreateDynamicObject(3930,-4058.0048828,-3055.6059570,7.8660002,0.0000000,0.0000000,110.7092590); //
		CreateDynamicObject(3930,-4057.7399902,-3055.2709961,7.8660002,0.0000000,0.0000000,110.7092590); //
		CreateDynamicObject(3930,-4057.4541016,-3054.9189453,7.8660002,0.0000000,0.0000000,110.7092590); //
		CreateDynamicObject(3930,-4057.1689453,-3054.5668945,7.8660002,0.0000000,0.0000000,110.7092590); //
		CreateDynamicObject(3930,-4056.9008789,-3054.2319336,7.8660002,0.0000000,0.0000000,110.7092590); //
		CreateDynamicObject(3930,-4056.6320801,-3053.8620605,7.8660002,0.0000000,0.0000000,110.7092590); //
		CreateDynamicObject(3930,-4056.3820801,-3053.5090332,7.8660002,0.0000000,0.0000000,110.7092590); //
		CreateDynamicObject(3930,-4059.3339844,-3060.5148926,7.8660002,0.0000000,0.0000000,161.9714355); //
		CreateDynamicObject(3930,-4059.2971191,-3059.6088867,7.3660002,0.0000000,0.0000000,137.9663086); //
		CreateDynamicObject(3930,-4059.2971191,-3059.6088867,6.8160000,0.0000000,0.0000000,137.9663086); //
		CreateDynamicObject(3930,-4059.2241211,-3059.1640625,7.3909998,0.0000000,0.0000000,137.9663086); //
		CreateDynamicObject(3930,-4059.1450195,-3058.7199707,7.3660002,0.0000000,0.0000000,137.9714355); //
		CreateDynamicObject(3930,-4059.0659180,-3058.2758789,7.3410001,0.0000000,0.0000000,137.9663086); //
		CreateDynamicObject(3930,-4058.9851074,-3057.8320312,7.3410001,0.0000000,0.0000000,134.7143555); //
		CreateDynamicObject(3930,-4058.8820801,-3057.3930664,7.3160000,0.0000000,0.0000000,134.7143555); //
		CreateDynamicObject(3930,-4058.7770996,-3056.9519043,7.3160000,0.0000000,0.0000000,134.7163391); //
		CreateDynamicObject(3930,-4058.6740723,-3056.5129395,7.3410001,0.0000000,0.0000000,134.7143555); //
		CreateDynamicObject(3930,-4058.6740723,-3056.5129395,6.8160000,0.0000000,0.0000000,134.7143555); //
		CreateDynamicObject(3930,-4058.7758789,-3056.9509277,6.7909999,0.0000000,0.0000000,134.7143555); //
		CreateDynamicObject(3930,-4058.8820801,-3057.3930664,6.7659998,0.0000000,0.0000000,134.7143555); //
		CreateDynamicObject(3930,-4059.0659180,-3058.2758789,6.7659998,0.0000000,0.0000000,137.9663086); //
		CreateDynamicObject(3930,-4058.9838867,-3057.8320312,6.7909999,0.0000000,0.0000000,134.7143555); //
		CreateDynamicObject(3930,-4059.1450195,-3058.7199707,6.7659998,0.0000000,0.0000000,137.9663086); //
		CreateDynamicObject(3930,-4059.2241211,-3059.1640625,6.7659998,0.0000000,0.0000000,137.9663086); //
		CreateDynamicObject(3930,-4055.6269531,-3052.9919434,7.8660002,0.0000000,0.0000000,85.7092285); //
		CreateDynamicObject(3930,-4055.2229004,-3052.7939453,7.8660002,0.0000000,0.0000000,85.7043457); //
		CreateDynamicObject(3930,-4054.8410645,-3052.6069336,7.8660002,0.0000000,0.0000000,85.7043457); //
		CreateDynamicObject(3930,-4054.4370117,-3052.4089355,7.8660002,0.0000000,0.0000000,85.7043457); //
		CreateDynamicObject(3930,-4054.0319824,-3052.2109375,7.8660002,0.0000000,0.0000000,85.7043457); //
		CreateDynamicObject(3930,-4053.6269531,-3052.0129395,7.8660002,0.0000000,0.0000000,85.7043457); //
		CreateDynamicObject(3930,-4053.2229004,-3051.8149414,7.8660002,0.0000000,0.0000000,85.7043457); //
		CreateDynamicObject(3930,-4052.8410645,-3051.6279297,7.8660002,0.0000000,0.0000000,85.7043457); //
		CreateDynamicObject(3930,-4052.0739746,-3051.4938965,7.8660002,0.0000000,0.0000000,59.9543457); //
		CreateDynamicObject(3930,-4051.6230469,-3051.4829102,7.8660002,0.0000000,0.0000000,59.9523926); //
		CreateDynamicObject(3930,-4051.1740723,-3051.4899902,7.8660002,0.0000000,0.0000000,59.9523926); //
		CreateDynamicObject(3930,-4050.7509766,-3051.4980469,7.8660002,0.0000000,0.0000000,59.9523926); //
		CreateDynamicObject(3930,-4050.3020020,-3051.4819336,7.8660002,0.0000000,0.0000000,59.9523926); //
		CreateDynamicObject(3930,-4049.8530273,-3051.4650879,7.8660002,0.0000000,0.0000000,59.9523926); //
		CreateDynamicObject(3930,-4049.4030762,-3051.4680176,7.8660002,0.0000000,0.0000000,59.9523926); //
		CreateDynamicObject(3930,-4048.9528809,-3051.4709473,7.8660002,0.0000000,0.0000000,59.9523926); //
		CreateDynamicObject(3930,-4048.1689453,-3051.7409668,7.8660002,0.0000000,0.0000000,35.9523926); //
		CreateDynamicObject(3930,-4047.7561035,-3051.9250488,7.8660002,0.0000000,0.0000000,35.9472656); //
		CreateDynamicObject(3930,-4047.3640137,-3052.0969238,7.8660002,0.0000000,0.0000000,33.9472656); //
		CreateDynamicObject(3930,-4046.9729004,-3052.2629395,7.8660002,0.0000000,0.0000000,33.9422607); //
		CreateDynamicObject(3930,-4046.5920410,-3052.4519043,7.8660002,0.0000000,0.0000000,33.9422607); //
		CreateDynamicObject(3930,-4046.1789551,-3052.6269531,7.8660002,0.0000000,0.0000000,33.9422607); //
		CreateDynamicObject(3930,-4045.8081055,-3052.8391113,7.8660002,0.0000000,0.0000000,33.9422607); //
		CreateDynamicObject(3930,-4045.4499512,-3053.0180664,7.8660002,0.0000000,0.0000000,33.9422607); //
		CreateDynamicObject(3930,-4044.7819824,-3053.5869141,7.8660002,0.0000000,0.0000000,9.9422607); //
		CreateDynamicObject(3930,-4044.4909668,-3053.9299316,7.8660002,0.0000000,0.0000000,9.9371338); //
		CreateDynamicObject(3930,-4044.1999512,-3054.2729492,7.8660002,0.0000000,0.0000000,9.9371338); //
		CreateDynamicObject(3930,-4043.9230957,-3054.5969238,7.8660002,0.0000000,0.0000000,9.9371338); //
		CreateDynamicObject(3930,-4043.6459961,-3054.9479980,7.8660002,0.0000000,0.0000000,9.9371338); //
		CreateDynamicObject(3930,-4043.3688965,-3055.2990723,7.8660002,0.0000000,0.0000000,7.9371338); //
		CreateDynamicObject(3930,-4043.0778809,-3055.6420898,7.8660002,0.0000000,0.0000000,7.9321289); //
		CreateDynamicObject(3930,-4042.7871094,-3055.9838867,7.8660002,0.0000000,0.0000000,7.9321289); //
		CreateDynamicObject(3930,-4042.5280762,-3056.7661133,7.8660002,0.0000000,0.0000000,343.9321289); //
		CreateDynamicObject(3930,-4042.4399414,-3057.2050781,7.8660002,0.0000000,0.0000000,343.9270020); //
		CreateDynamicObject(3930,-4042.3569336,-3057.6201172,7.8660002,0.0000000,0.0000000,343.9270020); //
		CreateDynamicObject(3930,-4042.2800293,-3058.0371094,7.8660002,0.0000000,0.0000000,343.9270020); //
		CreateDynamicObject(3930,-4042.1621094,-3058.4479980,7.8660002,0.0000000,0.0000000,343.9270020); //
		CreateDynamicObject(3930,-4042.0449219,-3058.8579102,7.8660002,0.0000000,0.0000000,343.9270020); //
		CreateDynamicObject(3930,-4041.9440918,-3059.2971191,7.8660002,0.0000000,0.0000000,343.9270020); //
		CreateDynamicObject(3930,-4041.8420410,-3059.7360840,7.8660002,0.0000000,0.0000000,343.9270020); //
		CreateDynamicObject(3930,-4041.8659668,-3060.5620117,7.8660002,0.0000000,0.0000000,315.9270020); //
		CreateDynamicObject(3930,-4041.9519043,-3061.0129395,7.8660002,0.0000000,0.0000000,315.9228516); //
		CreateDynamicObject(3930,-4042.0629883,-3061.4650879,7.8660002,0.0000000,0.0000000,315.9228516); //
		CreateDynamicObject(3930,-4042.1489258,-3061.9160156,7.8660002,0.0000000,0.0000000,315.9228516); //
		CreateDynamicObject(3930,-4042.2609863,-3062.3430176,7.8660002,0.0000000,0.0000000,315.9228516); //
		CreateDynamicObject(3930,-4042.3479004,-3062.7690430,7.8660002,0.0000000,0.0000000,315.9228516); //
		CreateDynamicObject(3930,-4042.4309082,-3063.1950684,7.8660002,0.0000000,0.0000000,315.9228516); //
		CreateDynamicObject(3930,-4042.5180664,-3063.6101074,7.8660002,0.0000000,0.0000000,315.9228516); //
		CreateDynamicObject(3930,-4058.2500000,-3055.9541016,7.3160000,0.0000000,0.0000000,110.7092285); //
		CreateDynamicObject(3930,-4058.2500000,-3055.9541016,6.7909999,0.0000000,0.0000000,110.7092285); //
		CreateDynamicObject(3930,-4058.0048828,-3055.6059570,7.3410001,0.0000000,0.0000000,110.7092285); //
		CreateDynamicObject(3930,-4058.0048828,-3055.6059570,6.8160000,0.0000000,0.0000000,110.7092285); //
		CreateDynamicObject(3930,-4057.7390137,-3055.2709961,7.3410001,0.0000000,0.0000000,110.7092285); //
		CreateDynamicObject(3930,-4057.7380371,-3055.2709961,6.8160000,0.0000000,0.0000000,110.7092285); //
		CreateDynamicObject(3930,-4057.4541016,-3054.9189453,7.3410001,0.0000000,0.0000000,110.7092285); //
		CreateDynamicObject(3930,-4057.4541016,-3054.9189453,6.8160000,0.0000000,0.0000000,110.7092285); //
		CreateDynamicObject(3930,-4057.1689453,-3054.5668945,7.3410001,0.0000000,0.0000000,110.7092285); //
		CreateDynamicObject(3930,-4057.1689453,-3054.5668945,6.8160000,0.0000000,0.0000000,110.7092285); //
		CreateDynamicObject(3930,-4056.9008789,-3054.2319336,7.3160000,0.0000000,0.0000000,110.7092285); //
		CreateDynamicObject(3930,-4056.9008789,-3054.2319336,6.7909999,0.0000000,0.0000000,110.7092285); //
		CreateDynamicObject(3930,-4056.6320801,-3053.8610840,7.3410001,0.0000000,0.0000000,110.7092285); //
		CreateDynamicObject(3930,-4056.6320801,-3053.8601074,6.8160000,0.0000000,0.0000000,110.7092285); //
		CreateDynamicObject(3930,-4056.3820801,-3053.5090332,7.3410001,0.0000000,0.0000000,110.7092285); //
		CreateDynamicObject(3930,-4056.3820801,-3053.5090332,6.8160000,0.0000000,0.0000000,110.7092285); //
		CreateDynamicObject(3930,-4055.6269531,-3052.9909668,7.3410001,0.0000000,0.0000000,85.7043457); //
		CreateDynamicObject(3930,-4055.6269531,-3052.9899902,6.8160000,0.0000000,0.0000000,85.7043457); //
		CreateDynamicObject(3930,-4055.2229004,-3052.7939453,7.3410001,0.0000000,0.0000000,85.7043457); //
		CreateDynamicObject(3930,-4055.2229004,-3052.7939453,6.8160000,0.0000000,0.0000000,85.7043457); //
		CreateDynamicObject(3930,-4054.8410645,-3052.6069336,7.3410001,0.0000000,0.0000000,85.7043457); //
		CreateDynamicObject(3930,-4054.8410645,-3052.6069336,6.8160000,0.0000000,0.0000000,85.7043457); //
		CreateDynamicObject(3930,-4054.4370117,-3052.4079590,7.3410001,0.0000000,0.0000000,85.7043457); //
		CreateDynamicObject(3930,-4054.4370117,-3052.4069824,6.8160000,0.0000000,0.0000000,85.7043457); //
		CreateDynamicObject(3930,-4054.0310059,-3052.2109375,7.3410001,0.0000000,0.0000000,85.7043457); //
		CreateDynamicObject(3930,-4054.0300293,-3052.2109375,6.8160000,0.0000000,0.0000000,85.7043457); //
		CreateDynamicObject(3930,-4053.6269531,-3052.0129395,7.3410001,0.0000000,0.0000000,85.7043457); //
		CreateDynamicObject(3930,-4053.6269531,-3052.0129395,6.8160000,0.0000000,0.0000000,85.7043457); //
		CreateDynamicObject(3930,-4053.2229004,-3051.8149414,7.3410001,0.0000000,0.0000000,85.7043457); //
		CreateDynamicObject(3930,-4053.2229004,-3051.8149414,6.8160000,0.0000000,0.0000000,85.7043457); //
		CreateDynamicObject(3930,-4052.8410645,-3051.6279297,7.3410001,0.0000000,0.0000000,85.7043457); //
		CreateDynamicObject(3930,-4052.8410645,-3051.6279297,6.8160000,0.0000000,0.0000000,85.7043457); //
		CreateDynamicObject(3930,-4052.0729980,-3051.4929199,7.3410001,0.0000000,0.0000000,59.9523926); //
		CreateDynamicObject(3930,-4052.0720215,-3051.4919434,6.8160000,0.0000000,0.0000000,59.9523926); //
		CreateDynamicObject(3930,-4051.6230469,-3051.4829102,7.3410001,0.0000000,0.0000000,59.9523926); //
		CreateDynamicObject(3930,-4051.6230469,-3051.4829102,6.8160000,0.0000000,0.0000000,59.9523926); //
		CreateDynamicObject(3930,-4051.1740723,-3051.4890137,7.3410001,0.0000000,0.0000000,59.9523926); //
		CreateDynamicObject(3930,-4051.1740723,-3051.4880371,6.8160000,0.0000000,0.0000000,59.9523926); //
		CreateDynamicObject(3930,-4050.7509766,-3051.4980469,7.3410001,0.0000000,0.0000000,59.9523926); //
		CreateDynamicObject(3930,-4050.7509766,-3051.4980469,6.8160000,0.0000000,0.0000000,59.9523926); //
		CreateDynamicObject(3930,-4050.3020020,-3051.4819336,7.3410001,0.0000000,0.0000000,59.9523926); //
		CreateDynamicObject(3930,-4050.3020020,-3051.4819336,6.8160000,0.0000000,0.0000000,59.9523926); //
		CreateDynamicObject(3930,-4049.8530273,-3051.4650879,7.3410001,0.0000000,0.0000000,59.9523926); //
		CreateDynamicObject(3930,-4049.8530273,-3051.4650879,6.8160000,0.0000000,0.0000000,59.9523926); //
		CreateDynamicObject(3930,-4049.4020996,-3051.4680176,7.3410001,0.0000000,0.0000000,59.9523926); //
		CreateDynamicObject(3930,-4049.4008789,-3051.4680176,6.8160000,0.0000000,0.0000000,59.9523926); //
		CreateDynamicObject(3930,-4048.9519043,-3051.4709473,7.3410001,0.0000000,0.0000000,59.9523926); //
		CreateDynamicObject(3930,-4048.9509277,-3051.4709473,6.8160000,0.0000000,0.0000000,59.9523926); //
		CreateDynamicObject(3930,-4048.1689453,-3051.7399902,7.3410001,0.0000000,0.0000000,35.9472656); //
		CreateDynamicObject(3930,-4048.1689453,-3051.7390137,6.8160000,0.0000000,0.0000000,35.9472656); //
		CreateDynamicObject(3930,-4047.7561035,-3051.9250488,7.3410001,0.0000000,0.0000000,35.9472656); //
		CreateDynamicObject(3930,-4047.7561035,-3051.9250488,6.8160000,0.0000000,0.0000000,35.9472656); //
		CreateDynamicObject(3930,-4047.3630371,-3052.0969238,7.3410001,0.0000000,0.0000000,33.9422607); //
		CreateDynamicObject(3930,-4047.3620605,-3052.0969238,6.8160000,0.0000000,0.0000000,33.9422607); //
		CreateDynamicObject(3930,-4046.9729004,-3052.2629395,7.3410001,0.0000000,0.0000000,33.9422607); //
		CreateDynamicObject(3930,-4046.9729004,-3052.2629395,6.8160000,0.0000000,0.0000000,33.9422607); //
		CreateDynamicObject(3930,-4046.5920410,-3052.4509277,7.3410001,0.0000000,0.0000000,33.9422607); //
		CreateDynamicObject(3930,-4046.1789551,-3052.6269531,7.3410001,0.0000000,0.0000000,33.9422607); //
		CreateDynamicObject(3930,-4045.8081055,-3052.8391113,7.3410001,0.0000000,0.0000000,33.9422607); //
		CreateDynamicObject(3930,-4045.4489746,-3053.0180664,7.3410001,0.0000000,0.0000000,33.9422607); //
		CreateDynamicObject(3930,-4044.7810059,-3053.5869141,7.3410001,0.0000000,0.0000000,9.9371338); //
		CreateDynamicObject(3930,-4044.7800293,-3053.5869141,6.8160000,0.0000000,0.0000000,9.9371338); //
		CreateDynamicObject(3930,-4044.4899902,-3053.9299316,7.3410001,0.0000000,0.0000000,9.9371338); //
		CreateDynamicObject(3930,-4044.4890137,-3053.9299316,6.8160000,0.0000000,0.0000000,9.9371338); //
		CreateDynamicObject(3930,-4044.1989746,-3054.2729492,7.3410001,0.0000000,0.0000000,9.9371338); //
		CreateDynamicObject(3930,-4044.1979980,-3054.2729492,6.8160000,0.0000000,0.0000000,9.9371338); //
		CreateDynamicObject(3930,-4043.9230957,-3054.5969238,7.3410001,0.0000000,0.0000000,9.9371338); //
		CreateDynamicObject(3930,-4043.9230957,-3054.5969238,6.8160000,0.0000000,0.0000000,9.9371338); //
		CreateDynamicObject(3930,-4043.6459961,-3054.9470215,7.3410001,0.0000000,0.0000000,9.9371338); //
		CreateDynamicObject(3930,-4043.6459961,-3054.9460449,6.8160000,0.0000000,0.0000000,9.9371338); //
		CreateDynamicObject(3930,-4043.3679199,-3055.2990723,7.3410001,0.0000000,0.0000000,7.9321289); //
		CreateDynamicObject(3930,-4043.3669434,-3055.2990723,6.8160000,0.0000000,0.0000000,7.9321289); //
		CreateDynamicObject(3930,-4043.0769043,-3055.6420898,7.3410001,0.0000000,0.0000000,7.9321289); //
		CreateDynamicObject(3930,-4043.0759277,-3055.6420898,6.8160000,0.0000000,0.0000000,7.9321289); //
		CreateDynamicObject(3930,-4042.7871094,-3055.9838867,7.3410001,0.0000000,0.0000000,7.9321289); //
		CreateDynamicObject(3930,-4042.7871094,-3055.9838867,6.8160000,0.0000000,0.0000000,7.9321289); //
		CreateDynamicObject(3930,-4042.5270996,-3056.7661133,7.3410001,0.0000000,0.0000000,343.9270020); //
		CreateDynamicObject(3930,-4042.5258789,-3056.7661133,6.8160000,0.0000000,0.0000000,343.9270020); //
		CreateDynamicObject(3930,-4042.4399414,-3057.2050781,7.3410001,0.0000000,0.0000000,343.9270020); //
		CreateDynamicObject(3930,-4042.4399414,-3057.2050781,6.8160000,0.0000000,0.0000000,343.9270020); //
		CreateDynamicObject(3930,-4042.3569336,-3057.6201172,7.3410001,0.0000000,0.0000000,343.9270020); //
		CreateDynamicObject(3930,-4042.3569336,-3057.6201172,6.8160000,0.0000000,0.0000000,343.9270020); //
		CreateDynamicObject(3930,-4042.2790527,-3058.0371094,7.3660002,0.0000000,0.0000000,343.9270020); //
		CreateDynamicObject(3930,-4042.1621094,-3058.4470215,7.3410001,0.0000000,0.0000000,343.9270020); //
		CreateDynamicObject(3930,-4042.1621094,-3058.4460449,6.7909999,0.0000000,0.0000000,343.9270020); //
		CreateDynamicObject(3930,-4042.2780762,-3058.0371094,6.8160000,0.0000000,0.0000000,343.9270020); //
		CreateDynamicObject(3930,-4042.0449219,-3058.8579102,7.3410001,0.0000000,0.0000000,343.9270020); //
		CreateDynamicObject(3930,-4041.9431152,-3059.2971191,7.3410001,0.0000000,0.0000000,343.9270020); //
		CreateDynamicObject(3930,-4042.0449219,-3058.8579102,6.8160000,0.0000000,0.0000000,343.9270020); //
		CreateDynamicObject(3930,-4041.8420410,-3059.7351074,7.3410001,0.0000000,0.0000000,343.9270020); //
		CreateDynamicObject(3930,-4041.8649902,-3060.5620117,7.3160000,0.0000000,0.0000000,315.9228516); //
		CreateDynamicObject(3930,-4041.9509277,-3061.0129395,7.3410001,0.0000000,0.0000000,315.9228516); //
		CreateDynamicObject(3930,-4042.0629883,-3061.4650879,7.3410001,0.0000000,0.0000000,315.9228516); //
		CreateDynamicObject(3930,-4042.1489258,-3061.9160156,7.3410001,0.0000000,0.0000000,315.9228516); //
		CreateDynamicObject(3930,-4042.2609863,-3062.3430176,7.3410001,0.0000000,0.0000000,315.9228516); //
		CreateDynamicObject(3930,-4042.3479004,-3062.7690430,7.3410001,0.0000000,0.0000000,315.9228516); //
		CreateDynamicObject(3930,-4042.4309082,-3063.1940918,7.3410001,0.0000000,0.0000000,315.9228516); //
		CreateDynamicObject(3930,-4041.9431152,-3059.2971191,6.8160000,0.0000000,0.0000000,343.9270020); //
		CreateDynamicObject(749,-4004.8249512,-2980.7600098,5.5660000,7.9925537,1.2524414,316.8184814); //
		CreateDynamicObject(749,-4055.8889160,-3067.0419922,2.2449999,0.0000000,0.0000000,340.5000000); //
		CreateDynamicObject(749,-4058.5891113,-3064.1259766,2.2449999,0.0000000,0.0000000,310.4992676); //
		CreateDynamicObject(749,-4059.4169922,-3060.2399902,2.2449999,0.0000000,0.0000000,260.4956055); //
		CreateDynamicObject(749,-4058.4829102,-3056.3740234,2.2449999,0.0000000,0.0000000,228.4913330); //
		CreateDynamicObject(749,-4056.1311035,-3053.3210449,2.2449999,0.0000000,0.0000000,204.4881592); //
		CreateDynamicObject(749,-4052.7089844,-3051.4360352,2.2449999,0.0000000,0.0000000,194.4830322); //
		CreateDynamicObject(749,-4048.7958984,-3051.9089355,2.2449999,0.0000000,0.0000000,144.4799805); //
		CreateDynamicObject(749,-4045.3520508,-3053.5249023,2.2449999,0.0000000,0.0000000,104.4757080); //
		CreateDynamicObject(749,-4043.1049805,-3056.3159180,2.2449999,0.0000000,0.0000000,86.4744873); //
		CreateDynamicObject(749,-4042.2680664,-3060.0749512,2.2449999,0.0000000,0.0000000,76.4733887); //
		CreateDynamicObject(749,-4043.0690918,-3063.7980957,2.2449999,0.0000000,0.0000000,52.4703369); //
		CreateDynamicObject(749,-4045.1110840,-3066.7709961,2.2449999,0.0000000,0.0000000,42.2152100); //
		CreateDynamicObject(749,-4048.3420410,-3068.6320801,2.2449999,0.0000000,0.0000000,28.2149658); //
		CreateDynamicObject(749,-4052.5419922,-3068.4641113,2.2449999,0.0000000,0.0000000,348.2128906); //
		CreateDynamicObject(18751,-3961.7880859,-2942.8964844,2.9940000,1.2414551,0.0000000,189.9865723); //
		CreateDynamicObject(933,-3888.0119629,-3055.8278809,40.3419991,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1750,-3887.9780273,-3056.1569824,41.3059998,0.0000000,0.0000000,320.0000000); //
		CreateDynamicObject(1712,-3890.0700684,-3059.0849609,40.3419991,0.0000000,0.0000000,136.0000000); //
		CreateDynamicObject(2028,-3887.5920410,-3056.2019043,41.4029999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1777,-3884.0939941,-3058.6760254,41.1310005,0.0000000,0.0000000,317.0000000); //
		CreateDynamicObject(18751,-3791.7250977,-2970.5400391,-0.3560000,0.2497559,0.0000000,261.9895020); //
		CreateDynamicObject(744,-3990.9589844,-3101.5068359,8.1920004,0.0000000,15.9906006,0.0000000); //
		CreateDynamicObject(698,-3854.1030273,-2990.7028809,11.1680002,0.0000000,0.0000000,70.0000000); //
		CreateDynamicObject(669,-3854.5471191,-2996.2990723,9.1750002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(704,-3852.0771484,-2998.9287109,8.6359997,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(684,-3861.1440430,-3003.5310059,9.3509998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(844,-3824.2700195,-2986.7890625,7.0530000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(839,-3830.0910645,-2988.1679688,7.1479998,0.0000000,0.0000000,288.0000000); //
		CreateDynamicObject(836,-3833.9699707,-2993.1699219,6.2119999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(836,-3843.8688965,-2991.2819824,7.8080001,21.4031372,349.2507935,135.9630737); //
		CreateDynamicObject(616,-3844.0048828,-3000.0900879,7.1830001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(616,-3877.9345703,-2995.8271484,7.0660000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(641,-3807.6799316,-2981.9079590,2.4020000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(657,-3837.3491211,-2998.5529785,6.1129999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(657,-3836.4770508,-2996.5910645,5.7760000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(657,-3851.6479492,-3006.9899902,8.8090000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(669,-3839.4707031,-3002.4775391,6.6059999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(671,-3841.0683594,-2997.0976562,6.2340002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(672,-3847.3959961,-2995.1818848,7.9920001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(683,-3763.5341797,-2999.1699219,2.8620000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(683,-3840.8271484,-2986.2333984,5.8420000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(688,-3762.9240723,-3003.2329102,2.6229999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(703,-3955.8059082,-3013.2648926,8.1929998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(710,-3762.3068848,-3006.4709473,18.4179993,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(710,-3762.1337891,-3014.7519531,17.7210007,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(710,-3770.8183594,-2998.7978516,17.7210007,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(16675,-3490.7390137,-3580.4750977,-4.8899999,0.0000000,0.0000000,169.9969482); //
		CreateDynamicObject(16112,-3643.1816406,-2953.6464844,-3.2839999,13.9965820,0.0000000,169.9914551); //
		CreateDynamicObject(19458,-3999.0078125,-2978.1650391,7.2839999,0.0000000,90.0000000,2.7500000); //
		CreateDynamicObject(19458,-3999.4687500,-2968.5605469,7.2839999,0.0000000,90.0000000,2.7465820); //
		CreateDynamicObject(19458,-3995.9970703,-2968.4179688,10.7840004,0.0000000,90.0000000,2.7465820); //
		CreateDynamicObject(19458,-3995.5341797,-2978.0097656,7.2839999,0.0000000,90.0000000,2.7465820); //
		CreateDynamicObject(19458,-4002.5048828,-2978.3310547,7.2839999,0.0000000,90.0000000,2.7465820); //
		CreateDynamicObject(19458,-4002.9589844,-2968.7265625,7.2839999,0.0000000,90.0000000,2.7465820); //
		CreateDynamicObject(19448,-4004.1650391,-2978.4199219,9.1199999,0.0000000,0.0000000,2.7465820); //
		CreateDynamicObject(19448,-3999.2148438,-2982.9306641,9.1199999,0.0000000,0.0000000,92.7465820); //
		CreateDynamicObject(19448,-4000.1328125,-2963.8583984,9.1199999,0.0000000,0.0000000,92.7465820); //
		CreateDynamicObject(19402,-3992.5878906,-2963.4931641,9.1199999,0.0000000,0.0000000,92.7465820); //
		CreateDynamicObject(19402,-4004.7646484,-2965.7617188,9.1199999,0.0000000,0.0000000,2.7465820); //
		CreateDynamicObject(19448,-4004.1650391,-2978.4199219,5.6199999,0.0000000,0.0000000,2.7465820); //
		CreateDynamicObject(19448,-3999.2150879,-2982.9309082,5.6199999,0.0000000,0.0000000,92.7465820); //
		CreateDynamicObject(19448,-4004.6269531,-2968.8291016,5.6199999,0.0000000,0.0000000,2.7465820); //
		CreateDynamicObject(19448,-4000.1359863,-2963.8339844,5.6199999,0.0000000,0.0000000,92.7465820); //
		CreateDynamicObject(19448,-3995.7749023,-2963.6340332,5.6199999,0.0000000,0.0000000,92.7465820); //
		CreateDynamicObject(19448,-3990.3579102,-2977.7539062,5.6199999,0.0000000,0.0000000,2.7465820); //
		CreateDynamicObject(19448,-3994.8688965,-2982.7360840,5.6199999,0.0000000,0.0000000,92.7465820); //
		CreateDynamicObject(19448,-3990.8310547,-2968.1552734,5.6199999,0.0000000,0.0000000,2.7465820); //
		CreateDynamicObject(19429,-3994.5400391,-2963.5947266,9.1199999,0.0000000,0.0000000,92.7465820); //
		CreateDynamicObject(19429,-4004.6875000,-2967.5703125,9.1199999,0.0000000,0.0000000,2.7465820); //
		CreateDynamicObject(19448,-3994.8671875,-2982.7343750,9.1199999,0.0000000,0.0000000,92.7465820); //
		CreateDynamicObject(19448,-3990.8310547,-2968.1542969,9.1199999,0.0000000,0.0000000,2.7465820); //
		CreateDynamicObject(19386,-3998.1059570,-2968.4909668,12.6199999,0.0000000,0.0000000,92.7465820); //
		CreateDynamicObject(19448,-3990.4775391,-2974.8974609,9.1199999,0.0000000,0.0000000,2.7465820); //
		CreateDynamicObject(19458,-3999.0078125,-2978.1650391,10.7840004,0.0000000,90.0000000,2.7465820); //
		CreateDynamicObject(19448,-3995.5339355,-2978.0100098,14.3090000,0.0000000,90.0000000,2.7465820); //
		CreateDynamicObject(19458,-3992.0527344,-2977.8417969,10.7840004,0.0000000,90.0000000,2.7465820); //
		CreateDynamicObject(19458,-4001.0458984,-2968.6721191,10.7840004,0.0000000,90.0000000,2.7465820); //
		CreateDynamicObject(19458,-3999.4667969,-2968.5859375,10.7840004,0.0000000,90.0000000,2.7465820); //
		CreateDynamicObject(19458,-3992.5148926,-2968.2480469,10.7840004,0.0000000,90.0000000,2.7465820); //
		CreateDynamicObject(1502,-3990.1420898,-2981.5810547,7.3439999,0.0000000,0.0000000,92.7465820); //
		CreateDynamicObject(19448,-3990.8310547,-2968.1542969,12.5950003,0.0000000,0.0000000,2.7465820); //
		CreateDynamicObject(19402,-3995.6816406,-2963.6650391,12.5950003,0.0000000,0.0000000,92.7465820); //
		CreateDynamicObject(19458,-3992.5156250,-2968.2226562,7.2839999,0.0000000,90.0000000,2.7465820); //
		CreateDynamicObject(19458,-3992.0527344,-2977.8417969,7.2839999,0.0000000,90.0000000,2.7465820); //
		CreateDynamicObject(19458,-3995.9990234,-2968.3925781,7.2839999,0.0000000,90.0000000,2.7465820); //
		CreateDynamicObject(19429,-3994.0087891,-2982.6835938,12.5950003,0.0000000,0.0000000,92.7465820); //
		CreateDynamicObject(19429,-3993.3242188,-2963.5429688,12.5950003,0.0000000,0.0000000,92.7465820); //
		CreateDynamicObject(19402,-4003.3410645,-2964.0280762,12.5950003,0.0000000,0.0000000,92.7465820); //
		CreateDynamicObject(19429,-3998.0471191,-2963.7700195,12.5950003,0.0000000,0.0000000,92.7465820); //
		CreateDynamicObject(19429,-4001.2294922,-2963.9316406,12.5950003,0.0000000,0.0000000,92.7465820); //
		CreateDynamicObject(19448,-4004.1650391,-2978.4199219,12.5950003,0.0000000,0.0000000,2.7465820); //
		CreateDynamicObject(19429,-4004.8129883,-2964.9589844,12.5950003,0.0000000,0.0000000,2.7465820); //
		CreateDynamicObject(19429,-4004.7319336,-2966.5629883,12.5950003,0.0000000,0.0000000,2.7465820); //
		CreateDynamicObject(19429,-4004.6909180,-2967.5649414,12.5950003,0.0000000,0.0000000,2.7465820); //
		CreateDynamicObject(19448,-3999.2150879,-2982.9309082,12.5950003,0.0000000,0.0000000,92.7465820); //
		CreateDynamicObject(19402,-3991.6699219,-2982.6000977,12.5950003,0.0000000,0.0000000,92.7465820); //
		CreateDynamicObject(19429,-3991.7753906,-2963.4667969,12.5950003,0.0000000,0.0000000,92.7465820); //
		CreateDynamicObject(19402,-3990.5185547,-2974.5468750,12.5950003,0.0000000,0.0000000,2.7465820); //
		CreateDynamicObject(19429,-3990.4091797,-2976.8642578,12.5950003,0.0000000,0.0000000,2.7465820); //
		CreateDynamicObject(19429,-3990.3320312,-2978.3889160,12.5950003,0.0000000,0.0000000,2.7465820); //
		CreateDynamicObject(19429,-3990.2773438,-2979.9101562,12.5950003,0.0000000,0.0000000,2.7465820); //
		CreateDynamicObject(19429,-3990.1979980,-2981.4309082,12.5950003,0.0000000,0.0000000,2.7465820); //
		CreateDynamicObject(19429,-3990.1970215,-2981.8059082,12.5950003,0.0000000,0.0000000,2.7465820); //
		CreateDynamicObject(714,-3948.9804688,-3000.9648438,6.2690001,0.0000000,0.0000000,69.9993896); //
		CreateDynamicObject(789,-3963.3574219,-3012.3125000,20.2290001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14874,-4003.7629395,-2967.9409180,9.1110001,0.0000000,0.0000000,92.7465820); //
		CreateDynamicObject(19448,-4004.4770508,-2972.4299316,9.1199999,0.0000000,0.0000000,2.7465820); //
		CreateDynamicObject(19448,-4004.4980469,-2972.1059570,12.5950003,0.0000000,0.0000000,2.7465820); //
		CreateDynamicObject(686,-4005.7770996,-2963.4340820,7.1440001,0.0000000,0.0000000,342.5000000); //
		CreateDynamicObject(19458,-3991.2570801,-2977.8081055,10.7840004,0.0000000,90.0000000,2.7465820); //
		CreateDynamicObject(19458,-3991.7280273,-2968.2380371,10.7840004,0.0000000,90.0000000,2.7465820); //
		CreateDynamicObject(19458,-3990.2570801,-2977.7719727,14.2840004,0.0000000,90.0000000,2.7465820); //
		CreateDynamicObject(19458,-3990.7028809,-2968.1889648,14.2840004,0.0000000,90.0000000,2.7465820); //
		CreateDynamicObject(19448,-3992.0529785,-2977.8420410,14.3090000,0.0000000,90.0000000,2.7465820); //
		CreateDynamicObject(19448,-3992.0527344,-2977.8417969,14.2589998,0.0000000,90.0000000,2.7465820); //
		CreateDynamicObject(19448,-3992.5161133,-2968.2548828,14.2589998,0.0000000,90.0000000,2.7465820); //
		CreateDynamicObject(19448,-3992.5156250,-2968.2548828,14.3090000,0.0000000,90.0000000,2.7465820); //
		CreateDynamicObject(19458,-3995.5341797,-2978.0097656,10.7840004,0.0000000,90.0000000,2.7465820); //
		CreateDynamicObject(19448,-3995.5329590,-2978.0100098,14.2589998,0.0000000,90.0000000,2.7465820); //
		CreateDynamicObject(19448,-3995.9970703,-2968.4179688,14.3090000,0.0000000,90.0000000,2.7465820); //
		CreateDynamicObject(19448,-3999.0080566,-2978.1650391,14.3090000,0.0000000,90.0000000,2.7465820); //
		CreateDynamicObject(19448,-3999.4670410,-2968.5859375,14.3090000,0.0000000,90.0000000,2.7465820); //
		CreateDynamicObject(19448,-4002.5048828,-2978.3310547,14.2589998,0.0000000,90.0000000,2.7465820); //
		CreateDynamicObject(19448,-4002.9589844,-2968.7265625,14.3090000,0.0000000,90.0000000,2.7465820); //
		CreateDynamicObject(19448,-3999.0078125,-2978.1650391,14.2589998,0.0000000,90.0000000,2.7465820); //
		CreateDynamicObject(19448,-4002.5048828,-2978.3310547,14.3090000,0.0000000,90.0000000,2.7465820); //
		CreateDynamicObject(19448,-4002.9589844,-2968.7270508,14.2589998,0.0000000,90.0000000,2.7465820); //
		CreateDynamicObject(19448,-3999.4670410,-2968.5859375,14.2589998,0.0000000,90.0000000,2.7465820); //
		CreateDynamicObject(19314,-3990.1110840,-2980.8269043,10.0290003,89.0000000,180.0000000,182.0000000); //
		CreateDynamicObject(16281,-3994.1909180,-2963.5419922,13.6180000,0.0000000,0.0000000,182.7500000); //
		CreateDynamicObject(16281,-3990.5439453,-2973.1079102,13.6180000,0.0000000,0.0000000,92.7465820); //
		CreateDynamicObject(16281,-3990.8486328,-2966.7929688,13.6180000,0.0000000,0.0000000,92.7465820); //
		CreateDynamicObject(16281,-3997.5239258,-2963.7050781,13.6180000,0.0000000,0.0000000,182.7465820); //
		CreateDynamicObject(16281,-4001.6699219,-2963.9040527,13.6180000,0.0000000,0.0000000,182.7465820); //
		CreateDynamicObject(16281,-4004.4650879,-2973.6240234,13.6180000,0.0000000,0.0000000,272.7438965); //
		CreateDynamicObject(16281,-4004.1350098,-2979.9208984,13.6180000,0.0000000,0.0000000,272.7410889); //
		CreateDynamicObject(16281,-4004.7763672,-2967.2324219,13.6180000,0.0000000,0.0000000,272.7410889); //
		CreateDynamicObject(16281,-3990.2929688,-2979.4741211,13.6180000,0.0000000,0.0000000,91.7465820); //
		CreateDynamicObject(16281,-3993.3688965,-2982.6960449,13.6180000,0.0000000,0.0000000,2.7465820); //
		CreateDynamicObject(16281,-3999.8059082,-2983.0019531,13.6180000,0.0000000,0.0000000,2.7465820); //
		CreateDynamicObject(16281,-4000.7470703,-2983.0549316,13.6180000,0.0000000,0.0000000,2.7465820); //
		CreateDynamicObject(14399,-4001.0249023,-2981.1188965,7.1199999,0.0000000,0.0000000,272.7465820); //
		CreateDynamicObject(19458,-4002.5891113,-2975.1320801,10.7840004,0.0000000,90.0000000,2.7465820); //
		CreateDynamicObject(19439,-4003.7529297,-2969.6799316,8.2950001,0.0000000,0.0000000,92.7465820); //
		CreateDynamicObject(19439,-4001.9838867,-2969.5681152,9.1199999,0.0000000,0.0000000,92.7465820); //
		CreateDynamicObject(19439,-4000.5991211,-2969.5009766,9.0450001,0.0000000,0.0000000,92.7465820); //
		CreateDynamicObject(19439,-4000.0009766,-2969.4680176,9.0450001,0.0000000,0.0000000,92.7465820); //
		CreateDynamicObject(19429,-4003.9670410,-2981.5749512,6.8449998,0.0000000,0.0000000,2.7465820); //
		CreateDynamicObject(19429,-4003.9289551,-2982.3320312,6.8449998,0.0000000,0.0000000,2.7465820); //
		CreateDynamicObject(1491,-4002.8400879,-2981.1608887,5.6950002,0.0000000,0.0000000,2.7465820); //
		CreateDynamicObject(19439,-4003.6230469,-2981.1770020,6.4450002,0.0000000,0.0000000,92.7465820); //
		CreateDynamicObject(1950,-4004.2229004,-2972.6479492,9.2180004,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1950,-4004.3830566,-2970.3068848,9.7930002,0.0000000,0.0000000,333.2500000); //
		CreateDynamicObject(1951,-4004.1950684,-2972.3889160,9.2320004,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(16152,-3996.9099121,-2964.7438965,7.3699999,0.0000000,0.0000000,272.7465820); //
		CreateDynamicObject(1778,-4004.6809082,-2968.1979980,7.3699999,0.0000000,0.0000000,90.0000000); //
		CreateDynamicObject(2812,-3996.8959961,-2964.8200684,8.2959995,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2683,-4004.2141113,-2971.9519043,9.1459999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2822,-3999.2871094,-2980.7590332,8.4949999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2830,-3994.6059570,-2964.7060547,8.2950001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2830,-3996.9780273,-2964.1850586,8.2959995,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(749,-3999.7451172,-3065.8828125,9.1929998,7.9925537,1.2524414,0.8184814); //
		CreateDynamicObject(1543,-3999.3999023,-2976.0209961,8.4949999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1543,-4004.2270508,-2972.4318848,8.4440002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1544,-4004.3220215,-2969.9279785,8.4239998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1545,-4001.2028809,-2969.6879883,9.0699997,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1664,-3999.2890625,-2980.1369629,8.6619997,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1664,-4003.4379883,-2969.9709473,8.5930004,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(19448,-3995.1992188,-2976.8271484,12.5950003,0.0000000,0.0000000,92.7465820); //
		CreateDynamicObject(19448,-4002.6923828,-2968.7763672,12.5950003,0.0000000,0.0000000,2.7465820); //
		CreateDynamicObject(19429,-4002.1450195,-2963.9560547,12.5950003,0.0000000,0.0000000,92.7465820); //
		CreateDynamicObject(19386,-3999.8701172,-2978.6025391,12.6199999,0.0000000,0.0000000,2.7465820); //
		CreateDynamicObject(19429,-4001.8688965,-2968.6699219,12.5950003,0.0000000,0.0000000,92.7465820); //
		CreateDynamicObject(19429,-4000.4709473,-2968.6149902,12.5950003,0.0000000,0.0000000,92.7465820); //
		CreateDynamicObject(19458,-4002.4890137,-2978.3349609,10.7840004,0.0000000,90.0000000,2.7465820); //
		CreateDynamicObject(19439,-4003.2080078,-2969.6479492,8.2950001,0.0000000,0.0000000,92.7465820); //
		CreateDynamicObject(19386,-3990.2197266,-2980.8183594,9.1199999,0.0000000,0.0000000,2.7465820); //
		CreateDynamicObject(19402,-3999.6550293,-2963.8540039,12.5950003,0.0000000,0.0000000,92.7465820); //
		CreateDynamicObject(19429,-3996.6389160,-2967.5969238,12.5950003,0.0000000,0.0000000,2.7465820); //
		CreateDynamicObject(19429,-3996.7041016,-2966.0209961,12.5950003,0.0000000,0.0000000,2.7465820); //
		CreateDynamicObject(19429,-3996.7758789,-2964.4450684,12.5950003,0.0000000,0.0000000,2.7465820); //
		CreateDynamicObject(19386,-3995.0058594,-2968.3515625,12.6199999,0.0000000,0.0000000,92.7465820); //
		CreateDynamicObject(19429,-3992.6230469,-2968.2419434,12.5950003,0.0000000,0.0000000,92.7465820); //
		CreateDynamicObject(19429,-3991.6760254,-2968.2199707,12.5950003,0.0000000,0.0000000,92.7465820); //
		CreateDynamicObject(2299,-3994.6169434,-2964.1149902,10.8699999,0.0000000,0.0000000,272.7465820); //
		CreateDynamicObject(2299,-4002.2338867,-2967.6000977,10.8699999,0.0000000,0.0000000,2.7465820); //
		CreateDynamicObject(19429,-3999.7600098,-2981.0129395,12.5950003,0.0000000,0.0000000,2.7465820); //
		CreateDynamicObject(19429,-3999.7141113,-2982.1708984,12.5950003,0.0000000,0.0000000,2.7465820); //
		CreateDynamicObject(2517,-4000.3029785,-2981.4108887,10.8699999,0.0000000,0.0000000,182.7465820); //
		CreateDynamicObject(2526,-4003.4670410,-2981.3579102,10.8699999,0.0000000,0.0000000,272.7465820); //
		CreateDynamicObject(19386,-4001.3798828,-2979.4990234,12.6199999,0.0000000,0.0000000,92.7465820); //
		CreateDynamicObject(19429,-4003.2839355,-2979.5930176,12.5950003,0.0000000,0.0000000,92.7465820); //
		CreateDynamicObject(2738,-4001.7629395,-2968.1369629,11.4729996,0.0000000,0.0000000,182.7465820); //
		CreateDynamicObject(2738,-3991.3896484,-2967.2949219,11.4729996,0.0000000,0.0000000,270.0000000); //
		CreateDynamicObject(2518,-4000.2561035,-2968.0161133,10.8699999,0.0000000,0.0000000,182.7465820); //
		CreateDynamicObject(2518,-3990.9250488,-2979.2739258,10.8699999,0.0000000,0.0000000,272.7465820); //
		CreateDynamicObject(2518,-4001.4099121,-2982.4431152,10.8699999,0.0000000,0.0000000,182.7465820); //
		CreateDynamicObject(2738,-4000.2670898,-2980.7971191,11.4729996,0.0000000,0.0000000,270.0000000); //
		CreateDynamicObject(2964,-3994.5720215,-2972.2509766,7.3699999,0.0000000,0.0000000,320.0000000); //
		CreateDynamicObject(3004,-4004.1999512,-2974.4650879,8.8950005,281.6461182,59.3401489,290.8148193); //
		CreateDynamicObject(3004,-4004.2099609,-2974.2839355,8.8950005,281.6455078,59.3371582,290.8135986); //
		CreateDynamicObject(3003,-4004.2009277,-2972.7299805,8.4829998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(3002,-3994.3369141,-2972.4528809,8.3000002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2996,-3994.3149414,-2972.5249023,8.3000002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2965,-3994.2480469,-2972.5300293,8.2869997,0.0000000,0.0000000,320.0000000); //
		CreateDynamicObject(2997,-3994.2600098,-2972.4680176,8.3000002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2998,-3994.2839355,-2972.5959473,8.3000002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2999,-3994.1889648,-2972.4829102,8.3000002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(3000,-3994.1201172,-2972.4970703,8.3000002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(3001,-3994.1730957,-2972.5581055,8.3000002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(3106,-3994.2419434,-2972.5358887,8.3000002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(3100,-3994.2199707,-2972.6179199,8.3000002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(3101,-3994.2619629,-2972.6779785,8.3000002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(3102,-3994.2290039,-2972.7470703,8.3000002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(3103,-3994.1799316,-2972.6860352,8.3000002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(3104,-3994.1311035,-2972.6269531,8.3000002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(3105,-3994.0869141,-2972.5681152,8.3000002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(3101,-3994.0419922,-2972.5119629,8.3000002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2941,-4000.6069336,-2981.0620117,8.8420000,0.0000000,0.0000000,32.0000000); //
		CreateDynamicObject(1494,-4002.1508789,-2979.5649414,10.8699999,0.0000000,0.0000000,2.7465820); //
		CreateDynamicObject(1491,-3995.7900391,-2968.3859863,10.8699999,0.0000000,0.0000000,2.7465820); //
		CreateDynamicObject(1491,-3999.8632812,-2979.3408203,10.8699999,0.0000000,0.0000000,92.7465820); //
		CreateDynamicObject(1491,-3997.3630371,-2968.4221191,10.8699999,0.0000000,0.0000000,182.7465820); //
		CreateDynamicObject(1799,-3996.7548828,-2979.2280273,10.8699999,0.0000000,0.0000000,182.7465820); //
		CreateDynamicObject(1799,-3994.0190430,-2979.1220703,10.8699999,0.0000000,0.0000000,182.7410889); //
		CreateDynamicObject(2131,-3999.1259766,-2982.3479004,10.8699999,0.0000000,0.0000000,92.7465820); //
		CreateDynamicObject(2132,-3996.5349121,-2977.4719238,10.8699999,0.0000000,0.0000000,2.7465820); //
		CreateDynamicObject(2180,-3992.1818848,-2982.0310059,10.8699999,0.0000000,0.0000000,2.7465820); //
		CreateDynamicObject(2079,-3995.4882812,-2964.6367188,11.5059996,0.0000000,0.0000000,270.0000000); //
		CreateDynamicObject(2096,-4002.6469727,-2977.0549316,7.3699999,0.0000000,0.0000000,60.0000000); //
		CreateDynamicObject(2517,-3991.0500488,-2978.1870117,10.8699999,0.0000000,0.0000000,2.7465820); //
		CreateDynamicObject(2738,-3990.8491211,-2978.5710449,11.4729996,0.0000000,0.0000000,270.0000000); //
		CreateDynamicObject(2518,-3991.5263672,-2965.9648438,10.8699999,0.0000000,0.0000000,272.7410889); //
		CreateDynamicObject(16112,-3902.5566406,-2836.8027344,8.0780001,13.9965820,0.0000000,207.9931641); //
		CreateDynamicObject(2180,-3995.1831055,-2964.1809082,10.8699999,0.0000000,0.0000000,182.7465820); //
		CreateDynamicObject(2180,-3999.1015625,-2964.3544922,10.8699999,0.0000000,0.0000000,182.7465820); //
		CreateDynamicObject(2079,-3991.5244141,-2981.2548828,11.5059996,0.0000000,0.0000000,49.9987793); //
		CreateDynamicObject(2079,-3999.4560547,-2965.1540527,11.5059996,0.0000000,0.0000000,240.0000000); //
		CreateDynamicObject(1803,-3993.2309570,-3024.5129395,8.7880001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1768,-3992.7500000,-2974.8134766,7.3699999,0.0000000,0.0000000,209.9981689); //
		CreateDynamicObject(3534,-3999.4221191,-2966.2519531,14.1210003,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(3534,-3993.6721191,-2966.3190918,14.1210003,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1753,-3991.2529297,-2970.7360840,10.8699999,0.0000000,0.0000000,272.7465820); //
		CreateDynamicObject(1742,-3991.8769531,-2968.1950684,10.8610001,0.0000000,0.0000000,2.7465820); //
		CreateDynamicObject(1896,-3994.1499023,-2975.1679688,11.8520002,0.0000000,0.0000000,182.7465820); //
		CreateDynamicObject(1895,-3993.9870605,-2976.5930176,12.8199997,0.0000000,0.0000000,182.7500000); //
		CreateDynamicObject(2188,-4001.6809082,-2970.8369141,11.8549995,0.0000000,0.0000000,92.7465820); //
		CreateDynamicObject(19474,-3996.0549316,-2972.5878906,11.4289999,0.0000000,0.0000000,320.0000000); //
		CreateDynamicObject(3534,-3995.5559082,-2981.2661133,14.1669998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(3472,-3996.0681152,-2974.6640625,-4.0330000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2115,-3998.5070801,-3025.9150391,8.7880001,0.0000000,0.0000000,330.0000000); //
		CreateDynamicObject(1786,-3995.9819336,-3032.0659180,8.7880001,0.0000000,0.0000000,170.0000000); //
		CreateDynamicObject(1719,-3996.5170898,-3031.2709961,8.8420000,0.0000000,0.0000000,160.0000000); //
		CreateDynamicObject(1706,-3996.2299805,-3029.1660156,8.7880001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1362,-3994.4929199,-3031.9641113,9.3859997,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(935,-3998.4350586,-3035.5161133,9.3509998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(905,-3918.9040527,-2825.4140625,10.2749996,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(905,-3919.1499023,-2826.1298828,10.2749996,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(905,-3919.2729492,-2826.1079102,10.5000000,0.0000000,0.0000000,110.0000000); //
		CreateDynamicObject(905,-3919.5891113,-2826.7380371,10.5000000,0.0000000,0.0000000,109.9951172); //
		CreateDynamicObject(905,-3919.9069824,-2827.5200195,10.5000000,0.0000000,0.0000000,79.9951172); //
		CreateDynamicObject(905,-3920.2990723,-2828.0090332,10.5000000,0.0000000,0.0000000,29.9914551); //
		CreateDynamicObject(901,-3917.1533203,-2825.7353516,7.7579999,0.0000000,0.0000000,29.9871826); //
		CreateDynamicObject(18751,-3637.6816406,-2970.8857422,1.1690000,0.0000000,0.0000000,17.9901123); //
		CreateDynamicObject(18751,-3713.0214844,-2951.8212891,-8.8360004,0.0000000,0.0000000,17.9901123); //
		CreateDynamicObject(18751,-3724.5610352,-2978.1721191,-8.8360004,0.0000000,0.0000000,17.9901123); //
		CreateDynamicObject(18751,-3751.2370605,-3014.9199219,-8.8360004,0.0000000,0.0000000,17.9901123); //
		CreateDynamicObject(18751,-3702.2910156,-3003.7590332,-8.8360004,0.0000000,0.0000000,17.9901123); //
		CreateDynamicObject(622,-3722.4599609,-2778.2783203,26.7119999,333.9953613,0.0000000,99.9810791); //
		CreateDynamicObject(12991,-3636.5849609,-2975.9050293,7.4549999,358.9999695,0.2500610,0.0043030); //
		CreateDynamicObject(2096,-3639.8359375,-2979.0791016,7.3299999,0.0000000,0.0000000,289.9896240); //
		CreateDynamicObject(2109,-3636.4060059,-2975.6550293,7.8540001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1720,-3636.3898926,-2976.1730957,7.4650002,0.0000000,0.0000000,180.0000000); //
		CreateDynamicObject(16112,-3752.8994141,-2859.4326172,-2.5790000,13.9965820,0.0000000,169.9914551); //
		CreateDynamicObject(710,-3627.4179688,-2989.0849609,13.6940002,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3638.0500488,-2987.7871094,13.6940002,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3640.0620117,-2994.0329590,19.6940002,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(833,-3895.2753906,-3237.4931641,7.4549999,0.0000000,0.0000000,317.9992676); //
		CreateDynamicObject(831,-3896.7050781,-3235.9460449,7.9640002,0.0000000,0.0000000,10.0000000); //
		CreateDynamicObject(831,-3897.5590820,-3234.9379883,7.9140000,0.0000000,0.0000000,9.9975586); //
		CreateDynamicObject(791,-3892.9414062,-3233.8095703,1.7250000,0.0000000,0.0000000,328.1231689); //
		CreateDynamicObject(840,-3895.8530273,-3232.8940430,9.7980003,353.9948730,0.0000000,127.9992676); //
		CreateDynamicObject(840,-3892.4050293,-3233.0759277,12.2729998,353.9904785,0.0000000,47.9962158); //
		CreateDynamicObject(840,-3892.1960449,-3236.4519043,14.5229998,353.9849854,0.0000000,317.9937744); //
		CreateDynamicObject(840,-3894.7729492,-3236.4069824,16.7730007,353.9849854,0.0000000,207.9937744); //
		CreateDynamicObject(840,-3893.8046875,-3232.8955078,19.1480007,353.9849854,0.0000000,117.9931641); //
		CreateDynamicObject(840,-3891.5419922,-3233.8491211,21.3980007,353.9849854,0.0000000,357.9931641); //
		CreateDynamicObject(840,-3893.8469238,-3235.9409180,23.7229996,353.9849854,0.0000000,257.9895020); //
		CreateDynamicObject(19378,-3883.4309082,-3223.8491211,28.5860004,0.0000000,90.0000000,0.0000000); //
		CreateDynamicObject(19378,-3892.8059082,-3235.0039062,38.3359985,0.0000000,90.0000000,0.0000000); //
		CreateDynamicObject(704,-3887.0312500,-3208.3134766,7.8200002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(19378,-3886.5139160,-3207.9829102,40.2109985,0.0000000,90.0000000,0.0000000); //
		CreateDynamicObject(704,-3867.0400391,-3255.0510254,7.7449999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(19378,-3870.0161133,-3252.6750488,40.3260002,0.0000000,90.0000000,0.0000000); //
		CreateDynamicObject(19378,-3909.1699219,-3233.5119629,39.4360008,0.0000000,90.0000000,0.0000000); //
		CreateDynamicObject(840,-3894.8830566,-3233.7519531,25.8980007,353.9849854,0.0000000,137.9864502); //
		CreateDynamicObject(835,-3892.1059570,-3232.3330078,27.6520004,358.3420410,34.0161743,241.1186523); //
		CreateDynamicObject(14872,-3881.6130371,-3225.8559570,29.1229992,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(19378,-3871.1640625,-3238.0175781,30.5109997,0.0000000,90.0000000,0.0000000); //
		CreateDynamicObject(5153,-3873.3820801,-3244.6879883,31.3449993,0.0000000,0.0000000,270.0000000); //
		CreateDynamicObject(5153,-3873.1201172,-3227.3430176,30.2700005,0.0000000,25.0000000,270.0000000); //
		CreateDynamicObject(5153,-3873.1210938,-3230.9519043,30.3449993,0.0000000,20.0000000,270.0000000); //
		CreateDynamicObject(19386,-3872.9990234,-3233.2980957,32.3470001,0.0000000,0.0000000,90.0000000); //
		CreateDynamicObject(19375,-3871.1640625,-3238.0180664,34.0359993,0.0000000,90.0000000,0.0000000); //
		CreateDynamicObject(19356,-3869.7858887,-3233.2980957,32.3470001,0.0000000,0.0000000,90.0000000); //
		CreateDynamicObject(19429,-3875.3898926,-3233.2980957,32.3470001,0.0000000,0.0000000,90.0000000); //
		CreateDynamicObject(19429,-3867.3740234,-3233.2980957,32.3470001,0.0000000,0.0000000,90.0000000); //
		CreateDynamicObject(19429,-3866.7180176,-3233.2980957,32.3470001,0.0000000,0.0000000,90.0000000); //
		CreateDynamicObject(19448,-3866.0080566,-3238.0009766,32.3470001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(19402,-3867.5810547,-3242.7170410,32.3470001,0.0000000,0.0000000,90.0000000); //
		CreateDynamicObject(19356,-3873.6430664,-3257.4008789,42.1619987,0.0000000,0.0000000,90.0000000); //
		CreateDynamicObject(19386,-3871.3459473,-3257.4008789,42.1619987,0.0000000,0.0000000,90.0000000); //
		CreateDynamicObject(19429,-3875.4750977,-3242.7099609,32.3470001,0.0000000,0.0000000,90.0000000); //
		CreateDynamicObject(5153,-3876.2275391,-3226.2685547,29.4200001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(5153,-3880.6740723,-3261.9909668,39.2070007,0.0000000,24.9993896,180.0000000); //
		CreateDynamicObject(5153,-3878.7290039,-3247.7590332,32.9910011,0.0000000,0.0000000,179.9945068); //
		CreateDynamicObject(5153,-3881.8310547,-3246.6918945,33.8409996,0.0000000,24.9993896,89.9945068); //
		CreateDynamicObject(5153,-3881.8410645,-3238.4169922,36.4010010,0.0000000,0.0000000,89.9945068); //
		CreateDynamicObject(5153,-3899.9370117,-3234.8579102,38.6199989,0.0000000,13.2493896,180.0000000); //
		CreateDynamicObject(5153,-3881.8491211,-3250.8010254,34.7410011,0.0000000,0.0000000,269.9945068); //
		CreateDynamicObject(5153,-3881.8540039,-3254.8439941,36.5110016,0.0000000,0.0000000,269.9890137); //
		CreateDynamicObject(5153,-3881.8540039,-3258.8830566,38.2610016,0.0000000,0.0000000,269.9890137); //
		CreateDynamicObject(5153,-3874.4511719,-3247.7695312,32.1910019,0.0000000,24.9993896,179.9945068); //
		CreateDynamicObject(5153,-3876.4260254,-3261.9970703,39.3069992,0.0000000,24.9993896,179.9945068); //
		CreateDynamicObject(5153,-3872.3798828,-3262.0009766,39.4070015,0.0000000,24.9993896,179.9945068); //
		CreateDynamicObject(5153,-3871.3110352,-3259.4431152,39.8569984,0.0000000,34.9993896,269.9945068); //
		CreateDynamicObject(5153,-3901.7329102,-3234.8579102,38.9449997,0.0000000,13.2440186,179.9945068); //
		CreateDynamicObject(5153,-3885.4838867,-3235.3310547,37.7659988,0.0000000,9.2492676,179.9945068); //
		CreateDynamicObject(5153,-3878.4799805,-3235.3491211,37.2910004,0.0000000,23.4942627,179.9945068); //
		CreateDynamicObject(16114,-4024.3652344,-2878.8378906,1.9250000,0.0000000,0.0000000,309.9957275); //
		CreateDynamicObject(16114,-4035.8505859,-2930.0244141,2.8000000,0.0000000,0.0000000,99.9920654); //
		CreateDynamicObject(16139,-4014.0029297,-2918.9990234,-4.2709999,0.0000000,0.0000000,220.0000000); //
		CreateDynamicObject(18751,-4023.4316406,-2915.9042969,2.9940000,1.2414551,0.0000000,189.9865723); //
		CreateDynamicObject(18751,-4006.4509277,-2908.3110352,2.9940000,1.2414551,0.0000000,189.9865723); //
		CreateDynamicObject(16112,-4395.6069336,-3166.9008789,-5.2500000,0.0000000,0.0000000,31.9970703); //
		CreateDynamicObject(16139,-4013.4221191,-2927.4829102,-4.2709999,0.0000000,0.0000000,229.9957275); //
		CreateDynamicObject(16667,-4004.9746094,-2909.7802734,15.9779997,0.0000000,0.0000000,279.9975586); //
		CreateDynamicObject(16112,-4003.1750488,-2903.5791016,0.2220000,0.0000000,0.0000000,11.9970703); //
		CreateDynamicObject(16112,-4004.3259277,-2921.2971191,0.8470000,0.0000000,0.0000000,11.9970703); //
		CreateDynamicObject(7916,-4412.9824219,-3189.6992188,3.8750000,0.0000000,0.0000000,219.9902344); //
		CreateDynamicObject(16667,-4042.3898926,-2923.3449707,19.7129993,44.0000000,0.0000000,179.9975586); //
		CreateDynamicObject(16122,-4051.4257812,-2881.4335938,4.7240000,0.0000000,0.0000000,17.9956055); //
		CreateDynamicObject(899,-4044.3417969,-2905.8134766,25.9330006,344.2510986,190.3930664,162.8338623); //
		CreateDynamicObject(899,-4040.0498047,-2891.9169922,23.5330009,5.9930420,177.9840088,190.1898193); //
		CreateDynamicObject(899,-4019.9770508,-2916.8950195,25.9330006,344.2510986,190.3930664,242.8338623); //
		CreateDynamicObject(899,-4015.5559082,-2911.0148926,23.2579994,332.0153809,177.7294312,268.9134521); //
		CreateDynamicObject(899,-3865.8249512,-2754.5820312,3.1400001,3.9825439,177.9840088,10.1184082); //
		CreateDynamicObject(16667,-4036.2314453,-2926.6630859,12.4530001,0.0000000,0.0000000,169.9914551); //
		CreateDynamicObject(899,-4031.5310059,-2912.5520020,27.7579994,324.0106201,177.5141602,128.5169983); //
		CreateDynamicObject(11496,-4434.1328125,-3150.9160156,0.0000000,0.0000000,0.0000000,304.4805908); //
		CreateDynamicObject(899,-4048.5810547,-2911.8950195,24.6830006,344.2510986,190.3930664,212.8338623); //
		CreateDynamicObject(16151,-4435.2851562,-3151.4404297,0.5750000,0.0000000,0.0000000,119.9926758); //
		CreateDynamicObject(5153,-3877.4050293,-3232.0048828,37.2910004,0.0000000,23.4942627,269.9945068); //
		CreateDynamicObject(5153,-3877.3798828,-3227.6059570,37.2910004,0.0000000,23.4942627,269.9890137); //
		CreateDynamicObject(5153,-3877.3859863,-3223.2060547,37.2910004,0.0000000,23.4942627,269.9890137); //
		CreateDynamicObject(5153,-3877.3779297,-3218.8129883,37.2910004,0.0000000,23.4942627,269.9890137); //
		CreateDynamicObject(5153,-3881.8349609,-3242.4277344,34.6409988,0.0000000,0.0000000,89.9945068); //
		CreateDynamicObject(5153,-3882.8818359,-3235.3339844,37.2910004,0.0000000,23.4942627,179.9945068); //
		CreateDynamicObject(5153,-3877.3869629,-3210.0139160,37.2910004,0.0000000,23.4942627,269.9890137); //
		CreateDynamicObject(5153,-3879.6809082,-3208.9331055,38.6619987,0.0000000,341.7500000,180.0000000); //
		CreateDynamicObject(19386,-3873.3271484,-3242.7167969,32.3470001,0.0000000,0.0000000,90.0000000); //
		CreateDynamicObject(19356,-3870.7812500,-3242.7167969,32.3470001,0.0000000,0.0000000,90.0000000); //
		CreateDynamicObject(19356,-3868.1569824,-3257.4008789,42.1619987,0.0000000,0.0000000,90.0000000); //
		CreateDynamicObject(19356,-3866.3850098,-3257.4008789,42.1619987,0.0000000,0.0000000,90.0000000); //
		CreateDynamicObject(19448,-3864.8520508,-3252.6770020,42.1619987,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(19402,-3866.5009766,-3247.9360352,42.1619987,0.0000000,0.0000000,90.0000000); //
		CreateDynamicObject(19356,-3869.6540527,-3247.9360352,42.1619987,0.0000000,0.0000000,90.0000000); //
		CreateDynamicObject(19356,-3872.8549805,-3247.9360352,42.1619987,0.0000000,0.0000000,90.0000000); //
		CreateDynamicObject(19429,-3874.4040527,-3247.9360352,42.1619987,0.0000000,0.0000000,90.0000000); //
		CreateDynamicObject(19375,-3870.0161133,-3252.6750488,43.8759995,0.0000000,90.0000000,0.0000000); //
		CreateDynamicObject(19356,-3875.1579590,-3255.8569336,42.1619987,0.0000000,0.0000000,180.0000000); //
		CreateDynamicObject(19356,-3875.1579590,-3252.6708984,42.1619987,0.0000000,0.0000000,179.9945068); //
		CreateDynamicObject(19402,-3875.1579590,-3249.4860840,42.1619987,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(19448,-3914.3190918,-3233.5109863,41.2719994,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(19375,-3909.1699219,-3233.5119629,42.9860001,0.0000000,90.0000000,0.0000000); //
		CreateDynamicObject(19448,-3876.2587891,-3238.0283203,32.3470001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(19448,-3886.8549805,-3212.6979980,42.0470009,0.0000000,0.0000000,90.0000000); //
		CreateDynamicObject(19429,-3888.3999023,-3239.6479492,40.1720009,0.0000000,0.0000000,90.0000000); //
		CreateDynamicObject(19386,-3904.0258789,-3234.9641113,41.2719994,0.0000000,0.0000000,180.0000000); //
		CreateDynamicObject(19429,-3904.0229492,-3237.3610840,41.2719994,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(19356,-3904.0258789,-3231.8039551,41.2719994,0.0000000,0.0000000,180.0000000); //
		CreateDynamicObject(19429,-3904.0258789,-3229.4589844,41.2719994,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(19402,-3905.6608887,-3228.7380371,41.2719994,0.0000000,0.0000000,90.0000000); //
		CreateDynamicObject(19356,-3908.8559570,-3228.7380371,41.2719994,0.0000000,0.0000000,89.9945068); //
		CreateDynamicObject(19402,-3896.4399414,-3230.2770996,40.1720009,0.0000000,0.0000000,90.0000000); //
		CreateDynamicObject(19356,-3910.2561035,-3228.7380371,41.2719994,0.0000000,0.0000000,89.9945068); //
		CreateDynamicObject(19386,-3897.9550781,-3234.8168945,40.1720009,0.0000000,0.0000000,179.9945068); //
		CreateDynamicObject(19356,-3897.9550781,-3237.9780273,40.1720009,0.0000000,0.0000000,179.9945068); //
		CreateDynamicObject(19448,-3909.4716797,-3238.2392578,41.2719994,0.0000000,0.0000000,90.0000000); //
		CreateDynamicObject(19429,-3904.7421875,-3238.2392578,41.2719994,0.0000000,0.0000000,90.0000000); //
		CreateDynamicObject(19356,-3897.9550781,-3231.8068848,40.1720009,0.0000000,0.0000000,179.9945068); //
		CreateDynamicObject(19375,-3892.8059082,-3235.0039062,41.8610001,0.0000000,90.0000000,0.0000000); //
		CreateDynamicObject(19402,-3912.7392578,-3228.7373047,41.2719994,0.0000000,0.0000000,90.0000000); //
		CreateDynamicObject(19402,-3893.3400879,-3230.2770996,40.1720009,0.0000000,0.0000000,90.0000000); //
		CreateDynamicObject(19356,-3890.1359863,-3230.2770996,40.1720009,0.0000000,0.0000000,269.9945068); //
		CreateDynamicObject(19386,-3887.6950684,-3235.0891113,40.1720009,0.0000000,0.0000000,179.9945068); //
		CreateDynamicObject(19429,-3888.3859863,-3230.2770996,40.1720009,0.0000000,0.0000000,90.0000000); //
		CreateDynamicObject(19402,-3887.6950684,-3231.8889160,40.1720009,0.0000000,0.0000000,180.0000000); //
		CreateDynamicObject(19356,-3887.6950684,-3238.0439453,40.1720009,0.0000000,0.0000000,179.9945068); //
		CreateDynamicObject(19448,-3891.6721191,-3207.9790039,42.0470009,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(19375,-3886.5139160,-3207.9829102,43.7109985,0.0000000,90.0000000,0.0000000); //
		CreateDynamicObject(19402,-3890.0439453,-3203.2609863,42.0470009,0.0000000,0.0000000,90.0000000); //
		CreateDynamicObject(19356,-3886.8911133,-3203.2609863,42.0470009,0.0000000,0.0000000,89.9945068); //
		CreateDynamicObject(19356,-3883.6909180,-3203.2609863,42.0470009,0.0000000,0.0000000,89.9945068); //
		CreateDynamicObject(19429,-3882.0549316,-3212.6979980,42.0470009,0.0000000,0.0000000,90.0000000); //
		CreateDynamicObject(19448,-3893.2119141,-3239.6474609,40.1720009,0.0000000,0.0000000,90.0000000); //
		CreateDynamicObject(19429,-3882.0546875,-3203.2607422,42.0470009,0.0000000,0.0000000,90.0000000); //
		CreateDynamicObject(19402,-3881.3620605,-3204.9331055,42.0470009,0.0000000,0.0000000,180.0000000); //
		CreateDynamicObject(19386,-3881.3620605,-3208.9770508,42.0470009,0.0000000,0.0000000,179.9945068); //
		CreateDynamicObject(19429,-3881.3620605,-3206.8940430,42.0470009,0.0000000,0.0000000,180.0000000); //
		CreateDynamicObject(19429,-3881.3620605,-3211.1970215,42.0470009,0.0000000,0.0000000,179.9945068); //
		CreateDynamicObject(19429,-3881.3620605,-3211.9130859,42.0470009,0.0000000,0.0000000,179.9945068); //
		CreateDynamicObject(833,-3889.5009766,-3228.0244141,28.3040009,14.8370361,157.1978760,324.1735840); //
		CreateDynamicObject(2117,-3884.6899414,-3205.6179199,40.1720009,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1802,-3866.2971191,-3251.4660645,40.4119987,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2136,-3871.3100586,-3248.5410156,40.4119987,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2135,-3872.2770996,-3248.5400391,40.4119987,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2231,-3867.6459961,-3253.0249023,40.5379982,0.0000000,0.0000000,170.0000000); //
		CreateDynamicObject(2231,-3865.6840820,-3252.7648926,40.4119987,0.0000000,0.0000000,230.0000000); //
		CreateDynamicObject(2104,-3866.4780273,-3253.1918945,40.4119987,0.0000000,0.0000000,208.0000000); //
		CreateDynamicObject(2119,-3870.2141113,-3252.8000488,40.4119987,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2111,-3880.5710449,-3222.5810547,29.0620003,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2110,-3912.4570312,-3234.3110352,39.5219994,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1720,-3911.9089355,-3234.8200684,39.5219994,0.0000000,0.0000000,180.0000000); //
		CreateDynamicObject(1720,-3911.9379883,-3233.6640625,39.5219994,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1797,-3890.4729004,-3207.6459961,40.2970009,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(19474,-3873.3940430,-3237.8530273,31.1560001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(19175,-3890.1699219,-3230.3620605,39.9420013,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(3503,-3884.1179199,-3205.5681152,42.3120003,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2290,-3892.0458984,-3231.2529297,38.4220009,0.0000000,0.0000000,330.0000000); //
		CreateDynamicObject(1747,-3893.0749512,-3234.1340332,39.8769989,0.0000000,0.0000000,160.0000000); //
		CreateDynamicObject(1795,-3894.3999023,-3239.0849609,38.4220009,0.0000000,0.0000000,90.0000000); //
		CreateDynamicObject(1828,-3871.6909180,-3240.2790527,30.5970001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1829,-3875.3530273,-3234.1389160,31.0610008,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2147,-3875.7739258,-3237.9079590,30.5970001,0.0000000,0.0000000,90.0000000); //
		CreateDynamicObject(2170,-3875.7363281,-3239.5244141,30.5970001,0.0000000,0.0000000,90.0000000); //
		CreateDynamicObject(2845,-3870.0920410,-3235.6608887,30.5970001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14666,-3881.4470215,-3207.0659180,41.3689995,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2590,-3873.3059082,-3237.9169922,33.9869995,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1701,-3867.4589844,-3236.8679199,30.5970001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1798,-3891.2580566,-3238.0390625,38.4220009,0.0000000,0.0000000,270.0000000); //
		CreateDynamicObject(2146,-3890.0559082,-3210.4570312,40.7820015,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2300,-3882.8200684,-3208.1699219,40.2970009,0.0000000,0.0000000,180.0000000); //
		CreateDynamicObject(744,-4046.5791016,-3116.9599609,5.9679999,0.0000000,15.9906006,300.0000000); //
		CreateDynamicObject(833,-3888.3769531,-3224.4770508,28.8789997,0.0306091,159.9986572,356.0402527); //
		CreateDynamicObject(833,-3888.1240234,-3221.0358887,28.8789997,356.9737549,159.9647827,354.9265137); //
		CreateDynamicObject(833,-3886.2839355,-3219.0458984,28.8789997,356.9732666,159.9609375,274.9243164); //
		CreateDynamicObject(833,-3882.7829590,-3218.8710938,28.8789997,356.9677734,159.9554443,274.9218750); //
		CreateDynamicObject(833,-3880.2548828,-3218.8720703,28.8789997,356.9677734,159.9554443,264.9218750); //
		CreateDynamicObject(833,-3878.5710449,-3220.8349609,28.8789997,356.9677734,159.9554443,174.9188232); //
		CreateDynamicObject(833,-3878.5019531,-3223.1730957,28.8789997,356.9677734,159.9554443,174.9133301); //
		CreateDynamicObject(833,-3879.9770508,-3228.4189453,28.8789997,356.9677734,159.9554443,94.9133301); //
		CreateDynamicObject(833,-3882.6650391,-3228.4309082,28.8789997,356.9677734,159.9554443,84.9108887); //
		CreateDynamicObject(833,-3886.3720703,-3228.2319336,28.8040009,356.9677734,159.9554443,84.9078369); //
		CreateDynamicObject(904,-3912.5029297,-3236.6010742,39.5219994,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(904,-3912.9108887,-3231.0681152,39.5219994,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2780,-3908.6799316,-3233.2490234,39.6290016,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(16192,-4132.7626953,-3181.9404297,-37.4500008,0.0000000,0.0000000,309.9957275); //
		CreateDynamicObject(3406,-4057.7839355,-3212.2670898,3.6680000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(3406,-4066.5419922,-3212.2629395,3.6680000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(3406,-4075.3479004,-3212.2770996,3.6680000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(3406,-4084.1464844,-3212.2744141,3.6680000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(3406,-4092.9318848,-3212.2758789,3.6680000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(11490,-4166.7919922,-3212.0258789,5.2069998,0.0000000,0.0000000,270.0000000); //
		CreateDynamicObject(11491,-4177.8339844,-3212.0471191,6.7069998,0.0000000,0.0000000,270.0000000); //
		CreateDynamicObject(16120,-4208.6518555,-3264.2770996,0.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(3406,-4101.7070312,-3212.2648926,3.6680000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(712,-4165.1948242,-3235.6960449,14.8260002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(712,-4164.7519531,-3191.6159668,14.8260002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(869,-4159.7470703,-3217.1569824,6.0990000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(869,-4159.8251953,-3220.2609863,6.3109999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(869,-4160.8588867,-3224.2370605,6.5130000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(869,-4160.7949219,-3227.9479980,6.8000002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(869,-4160.7587891,-3231.3601074,7.0850000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(869,-4160.2729492,-3206.9121094,5.9559999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(869,-4160.3637695,-3203.6579590,6.0819998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(869,-4161.0581055,-3199.8410645,6.2389998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(869,-4161.4238281,-3196.4318848,6.4200001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(871,-4160.0800781,-3216.9250488,5.8920002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(871,-4159.7680664,-3219.4750977,6.0929999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(871,-4160.2221680,-3222.3378906,6.2600002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(871,-4160.8901367,-3226.3588867,6.4959998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(871,-4160.8041992,-3229.9289551,6.7969999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(871,-4160.2001953,-3205.5869141,5.8390002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(871,-4160.6362305,-3201.8969727,5.9870000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(871,-4161.4589844,-3198.3000488,6.1380000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(872,-4164.7050781,-3235.6359863,6.8369999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(872,-4163.8911133,-3191.3310547,6.6620002,0.0000000,0.0000000,310.0000000); //
		CreateDynamicObject(726,-4177.2519531,-3196.5566406,6.7080002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(726,-4177.8779297,-3225.1398926,6.0830002,0.0000000,0.0000000,189.9975586); //
		CreateDynamicObject(710,-4157.3168945,-3227.5048828,21.4890003,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(710,-4157.1298828,-3199.3620605,21.3640003,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(16120,-4210.9057617,-3216.6918945,0.0000000,0.0000000,0.0000000,320.0000000); //
		CreateDynamicObject(16120,-4197.2412109,-3176.2880859,0.0000000,0.0000000,0.0000000,269.9890137); //
		CreateDynamicObject(16120,-4173.3481445,-3157.6169434,-0.4500000,0.0000000,0.0000000,269.9945068); //
		CreateDynamicObject(712,-4156.1181641,-3205.9089355,14.7489996,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(712,-4155.3139648,-3218.9680176,14.7489996,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(712,-4146.8129883,-3219.0200195,14.7489996,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(712,-4146.9667969,-3206.0109863,14.7489996,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(712,-4137.1708984,-3205.9189453,14.7489996,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(712,-4136.9609375,-3218.8149414,14.7489996,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(712,-4125.6572266,-3218.6049805,14.7489996,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(712,-4125.8559570,-3205.9069824,14.7489996,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(712,-4114.2265625,-3205.8750000,14.7489996,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(712,-4113.6318359,-3218.1030273,14.7489996,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(803,-4123.1669922,-3205.8291016,6.9029999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(803,-4119.4912109,-3206.4040527,7.1789999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(803,-4116.5039062,-3206.3391113,7.5560002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(803,-4116.4780273,-3218.6489258,8.0559998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(803,-4120.1127930,-3218.4619141,7.6560001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(803,-4123.7597656,-3218.4089355,7.6560001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(3525,-4161.9960938,-3209.6669922,8.4259996,0.0000000,0.0000000,90.0000000); //
		CreateDynamicObject(3525,-4161.9980469,-3214.2229004,8.4259996,0.0000000,0.0000000,90.0000000); //
		CreateDynamicObject(708,-4173.5698242,-3183.8569336,7.6690001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(708,-4175.8173828,-3240.9638672,7.6690001,0.0000000,0.0000000,179.9945068); //
		CreateDynamicObject(803,-4128.3828125,-3218.5510254,6.7810001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(803,-4132.0341797,-3218.5629883,6.7810001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(803,-4135.6098633,-3218.3989258,6.7810001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(803,-4134.6850586,-3205.9880371,6.7810001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(803,-4131.4082031,-3206.0869141,6.7810001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(803,-4128.1079102,-3206.1870117,6.7810001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(803,-4140.0820312,-3218.8850098,6.7810001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(803,-4142.0122070,-3218.7451172,6.7810001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(803,-4143.9121094,-3218.9150391,6.7810001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(803,-4139.8378906,-3205.9870605,7.1310000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(803,-4142.2387695,-3206.6809082,7.1310000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(803,-4144.8901367,-3206.7451172,7.1310000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(803,-4149.9838867,-3206.9699707,6.5310001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(803,-4154.1879883,-3207.0930176,6.4559999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(803,-4149.6000977,-3218.8120117,6.7810001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(803,-4153.0961914,-3219.0080566,6.7810001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2180,-4169.9482422,-3212.5949707,6.7150002,0.0000000,0.0000000,90.0000000); //
		CreateDynamicObject(18692,-4174.2250977,-3212.3439941,4.2649999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2894,-4169.9130859,-3212.6809082,7.5170002,0.0000000,0.0000000,90.0000000); //
		CreateDynamicObject(1811,-4170.2329102,-3212.5939941,7.3410001,0.0000000,0.0000000,160.0000000); //
		CreateDynamicObject(2330,-4164.2797852,-3208.9560547,6.7150002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2708,-4169.9941406,-3207.6779785,6.7150002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18368,-2236.4609375,-1730.9296875,475.4296875,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18368,-4196.0673828,-3263.8789062,5.5599999,0.0000000,0.0000000,39.9957275); //
		CreateDynamicObject(16111,-4194.3203125,-3270.6240234,1.0740000,0.0000000,0.0000000,249.9938965); //
		CreateDynamicObject(16112,-4210.2421875,-3268.9790039,1.3310000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(16120,-4222.0610352,-3254.9189453,-3.7500000,0.0000000,0.0000000,319.9987793); //
		CreateDynamicObject(16120,-4214.5551758,-3280.9250488,-3.7500000,0.0000000,0.0000000,359.9987793); //
		CreateDynamicObject(12857,-4000.1796875,-2785.7724609,-0.3400000,0.0000000,0.0000000,319.9822998); //
		CreateDynamicObject(12857,-3683.3974609,-2982.9921875,-1.9180000,0.0000000,0.0000000,257.9919434); //
		CreateDynamicObject(2743,-4170.0249023,-3214.7119141,8.0640001,0.0000000,0.0000000,180.0000000); //
		CreateDynamicObject(2809,-4170.0341797,-3214.7009277,8.0400000,0.0000000,0.0000000,180.0000000); //
		CreateDynamicObject(19352,-4169.9321289,-3214.7570801,9.3459997,0.0000000,0.0000000,90.0000000); //
		CreateDynamicObject(19348,-4169.9667969,-3214.9741211,8.5500002,2.0000000,180.0000000,180.0000000); //
		CreateDynamicObject(19349,-4169.8959961,-3214.6330566,9.2650003,88.0000000,180.0000000,358.0000000); //
		CreateDynamicObject(18747,-4050.9160156,-3055.9960938,6.8759999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18747,-4049.7480469,-3058.2060547,6.8759999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18747,-4048.9121094,-3060.5358887,6.8759999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18747,-4049.3010254,-3063.1159668,6.8759999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18747,-4050.1721191,-3066.3349609,6.8759999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18747,-4057.4008789,-3060.7670898,6.8759999,0.0000000,0.0000000,270.0000000); //
		CreateDynamicObject(16112,-4058.6845703,-2819.8535156,6.2220001,0.0000000,0.0000000,1.9995117); //
		CreateDynamicObject(789,-4127.6328125,-3175.4509277,18.2530003,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(789,-4130.1899414,-3241.6298828,18.2530003,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18751,-4085.4228516,-2839.9863281,4.0440001,1.2414551,0.0000000,159.9774170); //
		CreateDynamicObject(18751,-4243.2368164,-2847.3369141,0.4000000,1.2414551,0.0000000,179.9774170); //
		CreateDynamicObject(18751,-4240.1791992,-2790.7929688,0.4000000,1.2414551,0.0000000,179.9725342); //
		CreateDynamicObject(18751,-4296.9169922,-2885.1779785,0.8000000,1.2414551,0.0000000,179.9725342); //
		CreateDynamicObject(18751,-4289.7690430,-2841.6398926,0.8000000,1.2414551,0.0000000,179.9725342); //
		CreateDynamicObject(18751,-4293.8549805,-2799.5480957,0.8000000,1.2414551,0.0000000,179.9725342); //
		CreateDynamicObject(18751,-4310.3691406,-2739.8359375,0.8000000,1.2414551,0.0000000,179.9725342); //
		CreateDynamicObject(18751,-4264.7861328,-2764.5061035,0.8000000,1.2414551,0.0000000,179.9725342); //
		CreateDynamicObject(18751,-4236.2880859,-2727.1289062,0.8000000,1.2414551,0.0000000,149.9688721); //
		CreateDynamicObject(18751,-4222.5000000,-2721.7207031,0.8000000,1.2414551,0.0000000,139.9658203); //
		CreateDynamicObject(18751,-4252.0810547,-2696.5520020,0.8000000,1.2414551,0.0000000,139.9658203); //
		CreateDynamicObject(18751,-4287.2724609,-2684.2324219,0.8000000,1.2414551,0.0000000,179.9615479); //
		CreateDynamicObject(18751,-4324.4208984,-2701.0170898,0.8000000,1.2414551,0.0000000,179.9615479); //
		CreateDynamicObject(18751,-4327.0253906,-2683.9443359,0.8000000,1.2414551,0.0000000,179.9615479); //
		CreateDynamicObject(18751,-4326.1650391,-2753.8898926,0.8000000,1.2414551,0.0000000,179.9615479); //
		CreateDynamicObject(18751,-4325.5307617,-2807.3820801,1.5250000,1.2414551,0.0000000,179.9615479); //
		CreateDynamicObject(18751,-4326.3417969,-2864.7080078,1.5250000,1.2414551,0.0000000,179.9615479); //
		CreateDynamicObject(18751,-4316.8300781,-2908.3469238,1.5250000,1.2414551,0.0000000,209.9615479); //
		CreateDynamicObject(18751,-4280.8310547,-2899.2480469,1.5250000,0.4888916,0.0000000,173.4521484); //
		CreateDynamicObject(18751,-4247.0942383,-2860.5539551,-0.5500000,1.2414551,0.0000000,169.9774170); //
		CreateDynamicObject(18751,-4438.4150391,-3193.1308594,-8.9899998,1.2414551,0.0000000,149.9633789); //
		CreateDynamicObject(18751,-4242.9238281,-2888.3330078,0.3250000,1.2414551,0.0000000,149.9774170); //
		CreateDynamicObject(18751,-4115.0468750,-2788.0590820,-8.4250002,1.2414551,0.0000000,179.9743652); //
		CreateDynamicObject(18751,-4168.1870117,-2764.2219238,-9.6750002,1.2414551,0.0000000,179.9725342); //
		CreateDynamicObject(18751,-4130.3720703,-2805.4370117,-8.4250002,1.2414551,0.0000000,179.9725342); //
		CreateDynamicObject(18751,-4172.7441406,-2831.5529785,-10.1650000,1.2414551,0.0000000,179.9725342); //
		CreateDynamicObject(18751,-4168.0791016,-2793.5480957,-10.1650000,1.2414551,0.0000000,179.9725342); //
		CreateDynamicObject(18751,-4155.9428711,-2804.6579590,-10.1650000,1.2414551,0.0000000,179.9725342); //
		CreateDynamicObject(18751,-4136.9228516,-2829.1389160,-10.1650000,1.2414551,0.0000000,179.9725342); //
		CreateDynamicObject(18751,-4150.5991211,-2854.3620605,-10.1650000,1.2414551,0.0000000,179.9725342); //
		CreateDynamicObject(18751,-4149.7070312,-2865.5605469,-8.9150000,1.2414551,0.0000000,179.9725342); //
		CreateDynamicObject(18751,-4175.3818359,-2873.8115234,-9.6650000,1.2414551,0.0000000,179.9725342); //
		CreateDynamicObject(16120,-4321.4057617,-2707.8229980,6.0019999,0.0000000,0.0000000,129.9945374); //
		CreateDynamicObject(16120,-4312.3046875,-2692.1943359,6.0019999,0.0000000,0.0000000,69.9829102); //
		CreateDynamicObject(16139,-4284.7158203,-2712.3491211,14.3970003,0.0000000,0.0000000,270.0000000); //
		CreateDynamicObject(16667,-4306.4370117,-2694.8081055,27.3619995,0.0000000,0.0000000,30.0000000); //
		CreateDynamicObject(16667,-4313.9589844,-2697.1562500,27.3869991,0.0000000,0.0000000,39.9957275); //
		CreateDynamicObject(16112,-4316.0146484,-2707.7060547,27.3139992,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(16667,-4303.4819336,-2696.3769531,22.6369991,0.0000000,0.0000000,329.9957275); //
		CreateDynamicObject(16667,-4313.8100586,-2702.3129883,22.1369991,0.0000000,0.0000000,319.9908447); //
		CreateDynamicObject(16667,-4316.7841797,-2705.7260742,22.1369991,0.0000000,0.0000000,319.9877930); //
		CreateDynamicObject(16667,-4321.1088867,-2709.9709473,21.3869991,0.0000000,0.0000000,129.9877930); //
		CreateDynamicObject(16112,-4323.5039062,-2704.9433594,19.5639992,5.5975342,62.5177002,163.3666992); //
		CreateDynamicObject(16112,-4320.4238281,-2715.1989746,19.5639992,5.5975342,62.5177002,221.3666992); //
		CreateDynamicObject(16112,-4335.0219727,-2715.9980469,0.8740000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(710,-4228.0507812,-2884.3110352,17.9239998,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-4236.8662109,-2882.1040039,17.9239998,0.0000000,0.0000000,269.9859619); //
		CreateDynamicObject(710,-4238.3979492,-2891.0520020,17.9239998,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-4233.7548828,-2890.8659668,17.9239998,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-4227.8808594,-2890.3469238,17.9239998,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-4236.3452148,-2899.2260742,17.9239998,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-4232.7900391,-2896.2929688,17.9239998,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-4236.5400391,-2903.2539062,17.9239998,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-4230.6850586,-2900.2150879,17.9239998,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-4226.6259766,-2895.8469238,17.9239998,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-4225.0361328,-2902.7236328,17.9239998,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-4220.7939453,-2895.8491211,17.9239998,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-4222.7158203,-2889.4208984,17.9239998,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-4231.9340820,-2879.8959961,17.9239998,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-4242.4960938,-2883.8969727,17.9239998,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-4247.4648438,-2882.1789551,17.9239998,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-4241.6611328,-2879.4650879,17.9239998,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-4236.4057617,-2875.1650391,17.9239998,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-4245.4140625,-2875.7890625,17.9239998,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-4241.9179688,-2872.2150879,17.9239998,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-4230.9008789,-2877.4079590,17.9239998,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-4225.0541992,-2878.5849609,17.9239998,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-4249.9467773,-2867.9479980,17.9239998,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-4245.3471680,-2868.2539062,17.9239998,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-4250.4121094,-2873.7900391,17.9239998,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-4251.2441406,-2862.4770508,17.9239998,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-4246.3032227,-2861.7180176,17.9239998,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-4255.8710938,-2859.6940918,17.9239998,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-4247.9580078,-2855.8969727,8.4239998,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-4242.4531250,-2858.1386719,8.4239998,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-4252.5878906,-2854.5100098,17.8439999,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-4246.0332031,-2851.3181152,17.8439999,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(12991,-3786.4970703,-3167.5908203,7.7140002,355.9954834,357.4841309,251.1529541); //
		CreateDynamicObject(2406,-4257.7421875,-2724.7290039,38.0050011,270.0000000,270.0000000,59.9908447); //
		CreateDynamicObject(12857,-4144.2177734,-2822.6953125,-0.3900000,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(12857,-4184.3720703,-2815.8955078,-0.3900000,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(16502,-3932.5439453,-2852.8984375,11.5970001,3.1750488,327.9364014,65.9838867); //
		CreateDynamicObject(1639,-4306.1630859,-2902.8010254,7.0120001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1639,-4312.2656250,-2902.7900391,7.0120001,0.0000000,0.0000000,179.9945068); //
		CreateDynamicObject(18751,-4204.8129883,-2734.4340820,0.3000000,1.2414551,0.0000000,139.9658203); //
		CreateDynamicObject(18751,-4150.8901367,-2690.9838867,0.3000000,1.2414551,0.0000000,119.9657898); //
		CreateDynamicObject(18751,-4079.0549316,-2672.4189453,0.3000000,1.2414551,0.0000000,89.9652100); //
		CreateDynamicObject(18751,-4049.1599121,-2675.5339355,0.4000000,0.9906921,2.2503357,179.9226685); //
		CreateDynamicObject(18751,-4038.5690918,-2659.4221191,0.4000000,0.9887695,2.2467041,179.9176025); //
		CreateDynamicObject(18751,-3948.1250000,-2701.0239258,1.0500000,0.9887695,2.2467041,109.9176025); //
		CreateDynamicObject(18751,-3976.0900879,-2676.6230469,1.0500000,0.9832764,2.2412109,149.9127197); //
		CreateDynamicObject(18751,-3993.4687500,-2665.7744141,1.0500000,0.9722900,2.2302246,149.9084473); //
		CreateDynamicObject(18751,-4188.8613281,-2712.7021484,-0.0500000,1.2414551,0.0000000,139.9658508); //
		CreateDynamicObject(18751,-4149.4960938,-2755.4140625,-10.4309998,1.2414551,0.0000000,211.9647217); //
		CreateDynamicObject(18751,-4119.7470703,-2747.8068848,-10.4309998,1.2414551,0.0000000,211.9647217); //
		CreateDynamicObject(18751,-4130.1250000,-2679.4409180,0.3000000,1.2414551,0.0000000,109.9652100); //
		CreateDynamicObject(18751,-4206.1708984,-2687.8840332,0.3000000,1.2414551,0.0000000,99.9621582); //
		CreateDynamicObject(18751,-4160.3032227,-2678.9099121,0.3000000,1.2414551,0.0000000,99.9591064); //
		CreateDynamicObject(16112,-4316.0146484,-2707.7060547,27.3139992,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(710,-3857.2060547,-3249.7431641,23.7999992,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3862.2729492,-3241.4340820,23.7999992,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3855.1831055,-3232.0878906,21.0499992,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3861.0649414,-3224.0129395,21.5499992,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3858.2829590,-3221.0419922,20.7999992,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3853.2170410,-3215.1389160,21.0499992,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3839.6220703,-3175.0300293,18.7999992,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3846.9770508,-3185.4509277,19.2999992,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3852.4409180,-3174.0959473,19.2999992,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3856.4460449,-3183.1469727,19.2999992,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3851.4270020,-3190.5859375,19.2999992,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3851.7019043,-3198.1950684,19.2999992,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3851.1440430,-3208.8110352,18.5499992,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3850.9809570,-3223.5690918,18.5499992,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3846.5209961,-3201.3129883,18.5499992,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3844.5600586,-3216.2119141,18.5499992,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3856.4409180,-3240.6210938,21.5499992,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3860.6789551,-3200.9528809,20.5499992,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3858.7790527,-3207.1550293,20.5499992,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3858.7539062,-3194.6970215,19.5499992,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3866.8989258,-3201.5769043,19.5499992,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3844.4709473,-3235.2780762,19.5499992,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3850.5681152,-3243.8220215,19.5499992,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3845.1320801,-3253.9851074,19.5499992,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3834.2839355,-3244.7590332,21.2999992,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3834.7619629,-3229.5449219,23.7999992,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(892,-3840.3688965,-3241.6101074,8.1619997,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(841,-4242.4160156,-2913.3181152,4.4600000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18688,-4242.3662109,-2913.3979492,3.0190001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1800,-4258.8862305,-2903.1479492,20.1000004,0.0000000,0.0000000,60.0000000); //
		CreateDynamicObject(2079,-4258.1171875,-2901.2670898,20.9109993,0.0000000,0.0000000,200.0000000); //
		CreateDynamicObject(2111,-4257.2949219,-2901.0739746,20.6399994,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2079,-4257.8051758,-2900.4660645,20.9109993,0.0000000,0.0000000,139.9951172); //
		CreateDynamicObject(3931,-3814.5000000,-3175.9589844,5.7350001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14872,-4261.9838867,-2903.0759277,20.7269993,0.0000000,0.0000000,216.0000000); //
		CreateDynamicObject(14872,-4260.2690430,-2904.0590820,20.7269993,0.0000000,0.0000000,215.9967041); //
		CreateDynamicObject(758,-4283.7158203,-2926.0703125,3.5079999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(901,-4315.8007812,-2955.1279297,4.4400001,0.0000000,0.0000000,320.0000000); //
		CreateDynamicObject(901,-4274.4130859,-2930.8569336,4.4260001,0.0000000,0.0000000,60.0000000); //
		CreateDynamicObject(897,-4282.7724609,-2918.6757812,3.8810000,11.4312744,78.7335205,315.1263428); //
		CreateDynamicObject(801,-4437.8491211,-3181.5690918,-3.0810001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(801,-4283.6010742,-2929.9990234,3.3520000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(805,-4323.4731445,-2957.9890137,4.7270002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(805,-4287.3520508,-2914.1721191,5.5469999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(805,-4285.5117188,-2913.0927734,6.4470000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(805,-4293.6650391,-2913.2910156,6.3220000,9.9975586,0.0000000,0.0000000); //
		CreateDynamicObject(14400,-4308.7890625,-2929.9589844,5.0320001,0.0000000,0.0000000,40.0000000); //
		CreateDynamicObject(14400,-4288.3959961,-2911.2670898,6.7859998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14400,-4288.1279297,-2915.8095703,5.9439998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(623,-4306.7348633,-2904.3320312,-0.6190000,0.0000000,0.0000000,209.9963379); //
		CreateDynamicObject(703,-4292.2939453,-2909.5478516,6.0330000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(703,-4323.7070312,-2947.2849121,-4.4670000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(710,-4301.0258789,-2903.5229492,19.4990005,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-4294.3681641,-2903.5471191,18.4990005,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-4288.8339844,-2900.1369629,18.4990005,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-4296.1171875,-2897.7949219,19.4990005,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-4284.4179688,-2893.2619629,19.4990005,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-4290.5141602,-2894.0380859,19.4990005,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-4280.0649414,-2888.5371094,19.4990005,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-4287.2031250,-2888.2060547,19.4990005,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-4294.3349609,-2890.5800781,19.4990005,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-4277.5161133,-2882.9150391,19.4990005,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-4281.8129883,-2882.7858887,19.4990005,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-4281.8125000,-2882.7851562,19.4990005,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-4288.0131836,-2884.0590820,19.4990005,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-4292.6391602,-2883.1340332,19.4990005,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-4279.0791016,-2875.8720703,19.4990005,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-4286.7719727,-2877.4431152,19.4990005,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-4282.5219727,-2871.5720215,18.4990005,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-4287.1030273,-2870.7380371,18.4990005,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-4291.7778320,-2868.8049316,17.7490005,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-4283.6728516,-2867.3059082,18.2490005,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-4278.2509766,-2865.0319824,18.2490005,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-4301.4887695,-2895.9919434,18.2490005,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-4300.3232422,-2891.5910645,17.7490005,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-4306.1000977,-2894.5681152,17.7490005,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-4311.8540039,-2893.8449707,17.7490005,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(16502,-4263.7329102,-2886.4260254,22.1149998,3.9880066,46.1356201,269.8580322); //
		CreateDynamicObject(3361,-4245.7421875,-2890.1550293,16.5149994,0.0000000,0.0000000,30.0000000); //
		CreateDynamicObject(3361,-4271.8828125,-2692.7250977,30.9619999,0.0000000,0.0000000,65.9926758); //
		CreateDynamicObject(3361,-4233.0732422,-2887.2858887,8.3900003,0.0000000,0.0000000,299.9981689); //
		CreateDynamicObject(3361,-4229.9628906,-2892.6770020,4.2649999,0.0000000,0.0000000,299.9926758); //
		CreateDynamicObject(836,-4296.7939453,-2916.1130371,6.0390000,354.8556824,11.5471497,251.0495148); //
		CreateDynamicObject(836,-4295.9531250,-2912.8750000,6.2240000,0.0000000,0.0000000,60.0000000); //
		CreateDynamicObject(623,-4283.7695312,-2912.0058594,3.8069999,0.0000000,0.0000000,209.9871826); //
		CreateDynamicObject(17026,-3954.6152344,-2654.3583984,1.3850000,0.0000000,0.0000000,211.9921875); //
		CreateDynamicObject(789,-4291.0927734,-2859.2939453,15.6529999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(814,-4305.7719727,-2928.2680664,6.4330001,0.0000000,0.0000000,80.0000000); //
		CreateDynamicObject(814,-4296.4692383,-2889.2241211,8.7620001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(814,-4283.2597656,-2891.8369141,9.5530005,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(817,-4313.8041992,-2933.2080078,5.1279998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(817,-4313.5791016,-2932.7880859,5.5009999,0.0000000,0.0000000,280.0000000); //
		CreateDynamicObject(819,-4308.7890625,-2926.0759277,5.2470002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(712,-4312.3232422,-2928.5559082,10.6040001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(821,-4311.5219727,-2927.2810059,6.4410000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(821,-4236.7290039,-2898.8039551,6.7410002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(823,-4225.3623047,-2877.3300781,5.3779998,359.2474365,357.9949951,359.9670410); //
		CreateDynamicObject(855,-4282.4692383,-2932.5170898,3.2750001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(855,-4300.9130859,-2956.7060547,2.2600000,0.0000000,0.0000000,2.0000000); //
		CreateDynamicObject(872,-4316.8095703,-2933.8789062,5.4650002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(759,-4316.3168945,-2931.6469727,5.5300002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(759,-4323.5371094,-2941.3701172,5.8509998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(759,-4296.5351562,-2912.4370117,5.9020000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(800,-4319.8398438,-2935.8039551,5.7110000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(800,-4329.1132812,-2940.8476562,7.2199998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(16201,-4279.4873047,-2824.9150391,-21.7169991,0.0000000,0.0000000,309.9957275); //
		CreateDynamicObject(703,-4321.1728516,-2929.8613281,6.0359998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(754,-4308.5942383,-2923.1140137,4.6360002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(754,-4307.7587891,-2923.6350098,4.5060000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(754,-4308.6782227,-2921.6188965,4.8550000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(754,-4307.8271484,-2922.0610352,4.7500000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(806,-4306.0190430,-2924.1960449,7.7839999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(806,-4299.0761719,-2918.9709473,8.3439999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(806,-4305.7612305,-2924.8269043,8.1759996,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(806,-4305.4467773,-2926.0939941,8.2639999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(758,-4297.8417969,-2915.0900879,3.1830001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(703,-4323.8071289,-2920.0029297,7.2859998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(16112,-4116.8911133,-2704.2971191,-4.4949999,0.0000000,0.0000000,139.9969482); //
		CreateDynamicObject(616,-4305.0458984,-2885.1940918,6.4559999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(889,-4243.6918945,-2876.9130859,6.0209999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(897,-4239.3559570,-2864.8391113,5.4650002,11.4312744,78.7335205,315.1263428); //
		CreateDynamicObject(11496,-4169.8930664,-2755.2199707,0.5480000,0.0000000,0.0000000,315.9997559); //
		CreateDynamicObject(710,-4165.4702148,-2743.6840820,8.4239998,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(623,-4187.1547852,-2755.1818848,-3.9419999,0.0000000,0.0000000,249.9871826); //
		CreateDynamicObject(838,-3852.0009766,-3235.6069336,8.5270004,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(767,-3846.7749023,-3228.3269043,5.2350001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(892,-3857.5390625,-3193.2661133,6.9619999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(894,-3845.7170410,-3209.5849609,4.6890001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(894,-4224.9902344,-2892.8300781,3.8690000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(782,-3845.8679199,-3211.5471191,4.9520001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(782,-4255.9741211,-2883.2019043,6.4140000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(3425,-4195.8920898,-2756.6779785,14.4949999,0.0000000,0.0000000,51.1535645); //
		CreateDynamicObject(17049,-4175.7587891,-2736.0258789,1.2660000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(789,-4198.2670898,-2769.5048828,14.1289997,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(17298,-4202.2041016,-2729.8496094,11.4560003,0.0000000,0.0000000,129.9957275); //
		CreateDynamicObject(12857,-4285.9721680,-2741.5859375,34.0019989,358.7500000,0.0000000,309.9859314); //
		CreateDynamicObject(16502,-4305.5639648,-2760.2041016,32.7540016,1.6401062,339.9855347,218.5926514); //
		CreateDynamicObject(1362,-4201.5688477,-2729.4870605,7.0510001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18688,-4201.6499023,-2729.5239258,6.1840000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(791,-4258.7841797,-2772.1660156,3.9340000,0.0000000,0.0000000,328.1231689); //
		CreateDynamicObject(791,-4255.5351562,-2792.4780273,3.9340000,0.0000000,0.0000000,328.1231689); //
		CreateDynamicObject(791,-4250.3486328,-2813.7636719,2.9840000,0.0000000,0.0000000,298.1195068); //
		CreateDynamicObject(791,-4306.5927734,-2815.2670898,3.9340000,0.0000000,0.0000000,298.1195068); //
		CreateDynamicObject(791,-4287.9531250,-2779.0490723,3.9340000,0.0000000,0.0000000,298.1195068); //
		CreateDynamicObject(791,-4336.1420898,-2802.8439941,3.9340000,0.0000000,0.0000000,298.1195068); //
		CreateDynamicObject(791,-4331.0639648,-2840.6708984,3.9340000,0.0000000,0.0000000,298.1195068); //
		CreateDynamicObject(791,-4336.8818359,-2875.8200684,1.4340000,0.0000000,0.0000000,8.1195068); //
		CreateDynamicObject(791,-4234.8979492,-2833.6918945,1.4340000,0.0000000,0.0000000,298.1195068); //
		CreateDynamicObject(789,-4219.9160156,-2784.6933594,16.4029999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(791,-4234.9379883,-2744.8310547,1.9340000,0.0000000,0.0000000,328.1231689); //
		CreateDynamicObject(791,-4228.3730469,-2704.8447266,1.9340000,0.0000000,0.0000000,328.1231689); //
		CreateDynamicObject(791,-4214.0605469,-2684.1142578,1.9340000,0.0000000,0.0000000,328.1231689); //
		CreateDynamicObject(791,-4179.2329102,-2703.1679688,0.4340000,0.0000000,0.0000000,328.1231689); //
		CreateDynamicObject(791,-4165.8857422,-2666.4990234,-1.8160000,0.0000000,0.0000000,328.1231689); //
		CreateDynamicObject(18228,-3925.7910156,-2698.9902344,-1.3630000,0.0000000,0.0000000,261.9909668); //
		CreateDynamicObject(18228,-3893.8601074,-2735.7929688,-1.3630000,0.0000000,0.0000000,301.9909668); //
		CreateDynamicObject(899,-4026.6943359,-2902.9160156,30.5079994,3.9825439,177.9840088,10.1184082); //
		CreateDynamicObject(825,-4234.1982422,-2870.1770020,4.7280002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(825,-4088.8491211,-2529.0339355,0.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(791,-4269.4091797,-2835.6630859,-33.2260017,0.0000000,0.0000000,298.1195068); //
		CreateDynamicObject(791,-4283.3652344,-2810.5380859,3.9340000,0.0000000,0.0000000,258.1182861); //
		CreateDynamicObject(3361,-4238.6923828,-2886.1630859,12.5150003,0.0000000,0.0000000,29.9926758); //
		CreateDynamicObject(16112,-4321.5288086,-2682.2309570,1.1090000,0.0000000,0.0000000,349.9969482); //
		CreateDynamicObject(3361,-4269.3369141,-2687.0219727,26.8120003,0.0000000,0.0000000,65.9893799); //
		CreateDynamicObject(3361,-4266.8139648,-2681.3220215,22.6620007,0.0000000,0.0000000,65.9893799); //
		CreateDynamicObject(3361,-4261.4721680,-2678.9770508,18.6870003,0.0000000,0.0000000,335.9893799); //
		CreateDynamicObject(3361,-4255.7622070,-2681.5300293,14.5120001,0.0000000,0.0000000,335.9838867); //
		CreateDynamicObject(3361,-4250.1308594,-2684.0629883,10.3620005,0.0000000,0.0000000,335.9838867); //
		CreateDynamicObject(3361,-4247.8427734,-2685.0749512,8.7119999,0.0000000,0.0000000,335.9838867); //
		CreateDynamicObject(16120,-4289.7631836,-2697.9980469,6.0019999,0.0000000,0.0000000,69.9884033); //
		CreateDynamicObject(16112,-4263.9501953,-2681.2670898,1.1090000,0.0000000,0.0000000,209.9969482); //
		CreateDynamicObject(16112,-4269.5639648,-2686.7189941,5.9840002,0.0000000,0.0000000,209.9926758); //
		CreateDynamicObject(18259,-4261.5170898,-2722.5700684,36.7690010,0.0000000,0.0000000,330.0000000); //
		CreateDynamicObject(1799,-4260.2568359,-2719.4799805,36.9049988,0.0000000,0.0000000,332.0000000); //
		CreateDynamicObject(2115,-4264.5732422,-2727.1789551,36.8300018,0.0000000,0.0000000,332.0000000); //
		CreateDynamicObject(1810,-4263.9218750,-2726.9150391,36.7799988,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1810,-4264.3159180,-2727.5859375,36.7799988,0.0000000,0.0000000,150.0000000); //
		CreateDynamicObject(19360,-3887.4746094,-3054.7207031,42.0919991,0.0000000,0.0000000,45.9997559); //
		CreateDynamicObject(1225,-4264.6420898,-2719.7270508,37.2610016,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1225,-4263.7260742,-2718.9628906,37.2610016,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1225,-4263.4291992,-2720.3210449,37.2610016,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1225,-4262.5219727,-2719.5568848,37.2610016,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1225,-4262.5278320,-2720.7609863,37.2610016,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1225,-4261.6279297,-2720.0148926,37.2610016,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1347,-4257.3750000,-2724.0510254,37.4210014,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1347,-4258.1337891,-2725.5100098,37.4210014,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2406,-4255.9951172,-2901.5595703,21.4270000,0.0000000,0.0000000,59.9908447); //
		CreateDynamicObject(2595,-4257.6420898,-2724.7819824,38.3230019,0.0000000,0.0000000,180.0000000); //
		CreateDynamicObject(1712,-4260.8569336,-2724.1059570,36.8549995,0.0000000,0.0000000,66.0000000); //
		CreateDynamicObject(759,-4323.4580078,-2938.9528809,5.8080001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(759,-4321.2788086,-2938.3859863,5.6220002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(759,-4323.3032227,-2936.1398926,6.1310000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(759,-4324.0937500,-2939.6503906,5.8179998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(16195,-3670.2763672,-2571.8798828,6.3649998,0.0000000,0.0000000,209.9981689); //
		CreateDynamicObject(16196,-3863.6132812,-2682.9062500,-9.7550001,0.0000000,0.0000000,209.9981689); //
		CreateDynamicObject(16192,-3919.7749023,-3521.5710449,-37.8499985,358.0000000,0.0000000,339.9884033); //
		CreateDynamicObject(16192,-3594.6083984,-2583.0957031,-10.1850004,0.0000000,0.0000000,269.9890137); //
		CreateDynamicObject(16120,-3715.1201172,-2581.0673828,-1.3660001,0.0000000,0.0000000,69.9884033); //
		CreateDynamicObject(16207,-3579.3588867,-2634.7041016,-3.2479999,0.0000000,0.0000000,210.0000000); //
		CreateDynamicObject(16693,-3539.9335938,-2420.3125000,-15.1029997,0.0000000,0.0000000,279.9865723); //
		CreateDynamicObject(16192,-3631.7812500,-2652.8710938,-16.6849995,359.7473145,356.9952393,359.9780273); //
		CreateDynamicObject(16120,-3664.9069824,-2638.3588867,9.9740000,0.0000000,0.0000000,329.9993896); //
		CreateDynamicObject(16120,-3652.1311035,-2657.4089355,6.2240000,0.0000000,0.0000000,229.9963379); //
		CreateDynamicObject(16192,-3694.0891113,-2651.1550293,-35.3050003,0.0000000,0.0000000,39.9945068); //
		CreateDynamicObject(16163,-3650.1879883,-2624.7858887,-4.8800001,0.0000000,0.0000000,356.0000000); //
		CreateDynamicObject(3361,-3628.1579590,-2723.8840332,27.6229992,0.0000000,0.0000000,59.9908447); //
		CreateDynamicObject(7916,-3661.9108887,-2663.1340332,28.4659996,0.0000000,0.0000000,260.0000000); //
		CreateDynamicObject(16120,-3659.9929199,-2702.4599609,8.7240000,0.0000000,0.0000000,229.9932861); //
		CreateDynamicObject(16116,-3659.2500000,-2697.7390137,7.1939998,0.0000000,0.0000000,290.0000000); //
		CreateDynamicObject(16116,-3540.1240234,-2692.2500000,-12.3660002,0.0000000,0.0000000,289.9951172); //
		CreateDynamicObject(16116,-3557.4389648,-2711.3291016,-2.5160000,0.0000000,0.0000000,139.9914551); //
		CreateDynamicObject(16120,-3646.4431152,-2647.4370117,12.2240000,0.0000000,0.0000000,229.9932861); //
		CreateDynamicObject(16120,-3621.7490234,-2665.3271484,17.7240009,0.0000000,0.0000000,229.9932861); //
		CreateDynamicObject(16120,-3647.5800781,-2670.5820312,18.0240002,0.0000000,0.0000000,119.9932861); //
		CreateDynamicObject(6964,-3661.6818848,-2666.4951172,27.6660004,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(16207,-3670.1999512,-2638.7680664,-53.5929985,358.0594482,345.9917603,209.5141602); //
		CreateDynamicObject(16207,-3684.2690430,-2606.3798828,-45.0429993,352.1223145,349.9036865,208.6001587); //
		CreateDynamicObject(16120,-3778.9277344,-2664.2880859,-7.0560002,0.0000000,0.0000000,359.9890137); //
		CreateDynamicObject(16207,-3659.1621094,-2661.3659668,-56.2929993,358.0834961,342.9853516,209.4080811); //
		CreateDynamicObject(6964,-3661.5566406,-2683.7480469,27.6660004,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(6964,-3651.1660156,-2674.4453125,27.6660004,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(6964,-3672.4199219,-2674.9460449,27.6660004,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(6964,-3669.7626953,-2698.6464844,27.6660004,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(6964,-3658.2939453,-2699.1809082,27.6660004,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(6964,-3672.1789551,-2687.6899414,27.6660004,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(6964,-3673.4938965,-2698.9299316,27.6660004,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(6964,-3669.7419434,-2667.7160645,27.6660004,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(16120,-3678.6340332,-2639.9279785,9.7240000,0.0000000,0.0000000,349.9932861); //
		CreateDynamicObject(16120,-3681.0629883,-2675.1201172,7.6739998,0.0000000,0.0000000,319.9914551); //
		CreateDynamicObject(16113,-3672.3159180,-2642.6369629,11.4589996,0.0000000,0.0000000,299.9945068); //
		CreateDynamicObject(16113,-3677.7351074,-2667.1560059,11.4589996,0.0000000,0.0000000,299.9926758); //
		CreateDynamicObject(16116,-3659.7529297,-2705.5520020,7.1939998,0.0000000,0.0000000,289.9951172); //
		CreateDynamicObject(16116,-3663.3010254,-2699.7199707,7.1939998,0.0000000,0.0000000,289.9951172); //
		CreateDynamicObject(16116,-3649.9880371,-2698.7370605,4.1939998,0.0000000,0.0000000,289.9951172); //
		CreateDynamicObject(7916,-3691.1201172,-2670.8066406,12.7159996,0.0000000,0.0000000,259.9969482); //
		CreateDynamicObject(648,-3670.3049316,-2696.4838867,17.3279991,0.0000000,0.0000000,291.9866943); //
		CreateDynamicObject(6964,-3693.8430176,-2696.7280273,11.6680002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(6964,-3686.8105469,-2681.1318359,11.6680002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(6964,-3698.6279297,-2683.4230957,11.6680002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(6964,-3693.4780273,-2713.9790039,11.6680002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(6964,-3693.6679688,-2669.6000977,11.6680002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(6964,-3708.9169922,-2672.7199707,11.6680002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(6964,-3708.5439453,-2695.1960449,11.6680002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(6964,-3707.5229492,-2685.2451172,11.6680002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(6964,-3701.0224609,-2704.0761719,11.6680002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(6964,-3704.0339355,-2658.8649902,11.6680002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(6964,-3690.0712891,-2654.0957031,11.6680002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(16113,-3714.7219238,-2700.1040039,-4.3109999,0.0000000,0.0000000,349.9926758); //
		CreateDynamicObject(16113,-3718.9550781,-2670.5800781,-3.7110000,0.0000000,0.0000000,309.9914551); //
		CreateDynamicObject(16113,-3714.8730469,-2661.9709473,0.1890000,0.0000000,0.0000000,129.9902344); //
		CreateDynamicObject(16113,-3690.8898926,-2629.5090332,0.1890000,0.0000000,0.0000000,269.9847412); //
		CreateDynamicObject(9831,-3751.9379883,-2697.8249512,3.3099999,3.5000000,0.0000000,120.0000000); //
		CreateDynamicObject(9831,-3750.5480957,-2700.3229980,3.3099999,3.4991455,0.0000000,119.9981689); //
		CreateDynamicObject(9831,-3749.4108887,-2703.1188965,3.3099999,3.4991455,0.0000000,119.9981689); //
		CreateDynamicObject(9831,-3747.9760742,-2705.8898926,3.3099999,3.4991455,0.0000000,119.9981689); //
		CreateDynamicObject(9831,-3753.5209961,-2695.3730469,3.5100000,3.4991455,0.0000000,119.9981689); //
		CreateDynamicObject(16120,-3752.9873047,-2683.8710938,-7.0560002,0.0000000,0.0000000,69.9884033); //
		CreateDynamicObject(16120,-3708.2980957,-2713.1210938,-7.0560002,0.0000000,0.0000000,199.9884033); //
		CreateDynamicObject(16120,-3714.2150879,-2717.1779785,-7.0560002,0.0000000,0.0000000,199.9841309); //
		CreateDynamicObject(16112,-3731.5490723,-2701.6640625,-6.3790002,13.9965820,0.0000000,89.9914551); //
		CreateDynamicObject(16112,-3737.9250488,-2691.5371094,-6.8039999,13.9965820,0.0000000,89.9890137); //
		CreateDynamicObject(7916,-3756.8906250,-2689.7246094,1.8060000,0.0000000,0.0000000,299.9926758); //
		CreateDynamicObject(7916,-3756.8349609,-2694.9799805,0.8060000,0.0000000,0.0000000,299.9926758); //
		CreateDynamicObject(16120,-3712.7241211,-2724.8190918,-12.9460001,0.0000000,0.0000000,199.9841309); //
		CreateDynamicObject(623,-3703.8039551,-2705.1000977,11.0200005,0.0000000,0.0000000,51.9787598); //
		CreateDynamicObject(648,-3707.1550293,-2666.9079590,-2.9020000,0.0000000,0.0000000,11.9787598); //
		CreateDynamicObject(629,-3707.7392578,-2710.3300781,14.5389996,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(621,-3707.9318848,-2680.1230469,-3.2820001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(621,-3706.3889160,-2697.5649414,-3.2820001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(621,-3716.0639648,-2705.4770508,4.7179999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(16207,-3679.1953125,-2691.3398438,-56.2929993,358.0828857,342.9766846,209.4049072); //
		CreateDynamicObject(16120,-3747.2399902,-2495.7749023,-1.3660001,0.0000000,0.0000000,209.9993896); //
		CreateDynamicObject(16120,-3714.6416016,-2451.7607422,-1.3660001,0.0000000,0.0000000,255.9979248); //
		CreateDynamicObject(16694,-3635.2548828,-2472.2177734,-5.7500000,0.0000000,0.0000000,279.9865723); //
		CreateDynamicObject(16120,-3726.3134766,-2458.9248047,-1.3660001,0.0000000,0.0000000,75.9979248); //
		CreateDynamicObject(16120,-3704.3339844,-2481.8720703,-30.1630001,0.0000000,0.0000000,95.9930420); //
		CreateDynamicObject(16120,-3773.9462891,-2517.6582031,-1.3660001,0.0000000,0.0000000,135.9887695); //
		CreateDynamicObject(671,-3757.2578125,-2621.9716797,13.5229998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(710,-3785.2841797,-3074.7597656,18.9260006,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3758.6767578,-2625.9042969,26.2339993,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3756.3391113,-2617.4550781,26.2339993,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3765.2949219,-2621.2829590,26.2339993,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3759.7060547,-2611.0310059,25.4839993,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3751.8869629,-2612.8898926,25.4839993,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3762.1030273,-2615.7619629,25.4839993,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3768.5891113,-2616.2019043,25.4839993,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3769.6621094,-2624.8149414,25.4839993,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3752.6269531,-2627.9729004,25.4839993,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3774.0908203,-2620.5761719,25.4839993,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3777.4790039,-2623.1730957,25.4839993,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3773.7939453,-2627.5229492,25.4839993,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3779.1560059,-2627.2661133,25.4839993,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3778.9440918,-2631.8569336,25.4839993,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3827.1630859,-2594.9699707,12.3140001,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(16197,-3843.9238281,-2667.4775391,-50.2220001,0.0000000,0.0000000,349.9914551); //
		CreateDynamicObject(648,-3879.7729492,-2548.8688965,-10.8500004,0.0000000,0.0000000,141.9732666); //
		CreateDynamicObject(710,-3781.9638672,-2631.8867188,25.4839993,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3716.8911133,-2600.9331055,55.1339989,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3719.9240723,-2625.0600586,54.1339989,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3730.7019043,-2603.9309082,54.1339989,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3727.0510254,-2595.5900879,54.1339989,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3733.5581055,-2597.4150391,54.1339989,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3736.4960938,-2607.6430664,53.1339989,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3728.9929199,-2609.9509277,53.1339989,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3724.4370117,-2602.1630859,53.1339989,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3736.5009766,-2601.2109375,52.6339989,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3731.0749512,-2619.0200195,52.6339989,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3737.1740723,-2613.1000977,52.1339989,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3738.8359375,-2621.8168945,51.3839989,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3733.1210938,-2625.1320801,53.3839989,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3611.4729004,-2754.5180664,53.8499985,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3730.9340820,-2631.7980957,52.1339989,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3725.7839355,-2627.6721191,52.1339989,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3732.0810547,-2637.4970703,52.8839989,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(19511,-3717.1479492,-2615.2939453,43.1059990,0.0000000,0.0000000,110.0000000); //
		CreateDynamicObject(19512,-3717.1479492,-2615.2939453,43.1059990,0.0000000,0.0000000,110.0000000); //
		CreateDynamicObject(1502,-3711.7529297,-2614.4660645,41.0530014,0.0000000,0.0000000,200.0000000); //
		CreateDynamicObject(2302,-3719.6188965,-2614.4899902,41.1529999,0.0000000,0.0000000,20.0000000); //
		CreateDynamicObject(2029,-3719.0869141,-2616.4179688,41.1599998,0.0000000,0.0000000,20.0000000); //
		CreateDynamicObject(1720,-3718.8220215,-2615.7639160,41.1599998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1720,-3718.3168945,-2616.5681152,41.1529999,0.0000000,0.0000000,200.0000000); //
		CreateDynamicObject(3361,-3750.3681641,-2593.1474609,5.6450000,0.0000000,0.0000000,95.9875488); //
		CreateDynamicObject(3361,-3754.5341797,-2589.3085938,1.4950000,0.0000000,0.0000000,185.9930420); //
		CreateDynamicObject(16405,-3716.8530273,-2604.8559570,42.5880013,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(933,-3719.7871094,-2620.0380859,41.1529999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(933,-3717.8139648,-2619.6679688,41.1529999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(933,-3717.8139648,-2619.6679688,42.1030006,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2147,-3716.0419922,-2610.0170898,41.1529999,0.0000000,0.0000000,290.0000000); //
		CreateDynamicObject(2144,-3715.5161133,-2610.8740234,41.1529999,0.0000000,0.0000000,290.0000000); //
		CreateDynamicObject(16116,-3554.7739258,-2704.3229980,0.0590000,0.0000000,0.0000000,139.9877930); //
		CreateDynamicObject(16116,-3558.1999512,-2708.6259766,1.9840000,0.0000000,0.0000000,139.9877930); //
		CreateDynamicObject(16116,-3548.8278809,-2731.9829102,-15.2559996,0.0000000,0.0000000,139.9877930); //
		CreateDynamicObject(16116,-3557.7980957,-2715.3610840,-0.3910000,0.0000000,0.0000000,159.9877930); //
		CreateDynamicObject(710,-3716.4030762,-2468.1149902,28.0699997,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3725.0690918,-2468.5490723,27.0699997,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3723.9030762,-2475.1030273,27.0699997,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3732.2119141,-2475.1879883,27.0699997,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3731.5681152,-2480.8520508,26.0699997,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3735.8139648,-2481.1579590,25.3199997,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3736.2680664,-2486.0991211,24.3199997,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3733.8259277,-2486.5000000,24.3199997,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(11428,-3621.5273438,-2760.0908203,43.4090004,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(11441,-3640.1455078,-2768.6582031,36.9220009,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(11442,-3625.7158203,-2786.5996094,37.3160019,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(11443,-3644.5109863,-2784.0710449,36.6640015,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(11458,-3642.9863281,-2759.9521484,37.3009987,0.0000000,0.0000000,270.0000000); //
		CreateDynamicObject(710,-3737.9667969,-2630.4697266,52.1339989,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3634.8837891,-2746.0029297,53.8499985,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3644.2910156,-2746.2250977,52.5999985,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3648.5568848,-2738.2810059,52.5999985,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3653.8720703,-2733.1572266,52.5999985,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3657.3620605,-2530.9750977,67.5459976,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3715.5107422,-2730.2539062,23.4939995,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3723.7177734,-2721.8964844,21.5370007,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3655.2109375,-2533.6450195,75.7460022,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(18368,-3686.9550781,-2671.1000977,20.2350006,0.0000000,0.0000000,169.9957275); //
		CreateDynamicObject(653,-3718.5429688,-2732.5161133,8.9740000,0.0000000,0.0000000,309.9957275); //
		CreateDynamicObject(653,-3716.8110352,-2726.6660156,7.6680002,0.0000000,0.0000000,309.9957275); //
		CreateDynamicObject(653,-3646.7971191,-2766.6311035,36.8800011,0.0000000,0.0000000,309.9957275); //
		CreateDynamicObject(3524,-3654.1169434,-2794.7229004,35.2060013,0.0000000,0.0000000,180.0000000); //
		CreateDynamicObject(3524,-3654.2280273,-2800.1721191,35.2309990,0.0000000,0.0000000,359.9945068); //
		CreateDynamicObject(3524,-3651.2919922,-2797.4650879,35.3810005,0.0000000,0.0000000,89.9890137); //
		CreateDynamicObject(3524,-3656.9528809,-2797.3579102,35.2809982,0.0000000,0.0000000,269.9890137); //
		CreateDynamicObject(18691,-3653.5349121,-2797.3220215,35.9169998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(16502,-3924.4443359,-2848.5800781,18.5319996,356.0119629,353.9739990,319.5758057); //
		CreateDynamicObject(16120,-3563.3720703,-2527.0520020,1.3430001,0.0000000,0.0000000,229.9871826); //
		CreateDynamicObject(16599,-3657.4760742,-2760.2680664,42.0589981,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(841,-3654.0720215,-2797.2429199,37.2130013,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(841,-3654.0339355,-2796.8200684,37.1730003,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(841,-3653.7438965,-2797.5080566,37.2439995,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(841,-3654.3969727,-2797.7409668,37.2540016,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(710,-3664.1340332,-2588.3459473,49.1529999,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3662.2749023,-2592.7229004,49.2130013,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3672.1520996,-2582.4519043,49.8279991,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3673.1110840,-2574.5258789,49.1380005,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3668.8889160,-2578.5759277,49.5730019,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3679.2871094,-2595.9709473,49.4840012,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3673.8640137,-2592.2780762,49.4840012,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3667.2500000,-2596.2539062,49.6839981,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3667.7910156,-2606.0000000,49.9840012,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3673.0820312,-2601.4121094,49.9840012,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3658.7290039,-2601.1889648,49.1590004,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3656.6159668,-2590.8569336,48.6090012,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3653.3410645,-2595.4809570,48.5340004,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3660.7351074,-2582.3710938,49.1090012,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3680.5629883,-2583.4060059,49.9840012,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3687.7580566,-2585.5371094,48.7340012,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3685.0939941,-2578.9020996,48.7340012,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3679.4580078,-2603.5270996,48.7340012,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3685.7390137,-2606.1950684,48.2340012,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3675.6530762,-2608.2189941,49.4840012,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3681.0703125,-2612.2128906,47.4840012,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(629,-3759.0549316,-2500.9919434,7.2249999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(629,-3754.8369141,-2502.9099121,6.9250002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(3406,-3759.1835938,-2586.0546875,-2.0750000,0.0000000,0.0000000,95.9875488); //
		CreateDynamicObject(3406,-3753.1386719,-2587.0957031,-2.0750000,0.0000000,0.0000000,5.9875488); //
		CreateDynamicObject(3406,-3754.6562500,-2591.5019531,-2.0750000,0.0000000,0.0000000,5.9875488); //
		CreateDynamicObject(3361,-3738.7128906,-2642.2167969,12.7320004,0.0000000,0.0000000,325.9918213); //
		CreateDynamicObject(3361,-3743.2739258,-2636.7670898,16.7819996,0.0000000,0.0000000,285.9918213); //
		CreateDynamicObject(3361,-3744.9641113,-2630.8811035,20.8570004,0.0000000,0.0000000,285.9906006); //
		CreateDynamicObject(3361,-3746.0659180,-2623.1389160,24.9069996,0.0000000,0.0000000,265.9906006); //
		CreateDynamicObject(3361,-3745.6330566,-2617.0791016,28.9570007,0.0000000,0.0000000,265.9899902); //
		CreateDynamicObject(3361,-3744.4379883,-2611.1760254,32.9570007,0.0000000,0.0000000,251.9899902); //
		CreateDynamicObject(3361,-3743.6889648,-2608.8969727,34.5820007,0.0000000,0.0000000,251.9879150); //
		CreateDynamicObject(9361,-3555.7968750,-2445.2490234,27.4680004,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1453,-4203.6440430,-2725.7810059,6.6810002,346.5000000,0.0000000,0.0000000); //
		CreateDynamicObject(1454,-4204.4389648,-2727.0590820,7.1190000,348.0000000,0.0000000,40.0000000); //
		CreateDynamicObject(2090,-3557.2749023,-2442.8830566,25.0930004,0.0000000,0.0000000,314.0000000); //
		CreateDynamicObject(3276,-3661.3789062,-2709.0300293,43.6279984,356.3739319,16.2513428,242.5263367); //
		CreateDynamicObject(3276,-3666.4379883,-2717.9990234,40.6279984,356.3690186,16.2487793,240.5231934); //
		CreateDynamicObject(3276,-3669.4460449,-2722.9870605,38.9780006,356.3635254,16.2432861,240.5181885); //
		CreateDynamicObject(3276,-3667.3688965,-2723.8549805,38.9780006,356.3559570,344.1768799,60.4275513); //
		CreateDynamicObject(3276,-3659.7343750,-2710.3027344,43.5779991,356.3470459,344.1687012,60.4193115); //
		CreateDynamicObject(3276,-3664.6369629,-2719.3491211,40.7029991,356.3525391,344.1741943,60.4248047); //
		CreateDynamicObject(18752,-3616.5681152,-2585.6269531,-24.3600006,0.0000000,0.0000000,260.0000000); //
		CreateDynamicObject(12857,-3755.3427734,-2765.4765625,0.0000000,0.0000000,0.0000000,307.9907227); //
		CreateDynamicObject(12857,-3787.2753906,-2790.7744141,0.0000000,0.0000000,0.0000000,307.9907227); //
		CreateDynamicObject(3361,-3746.0920410,-2757.9909668,5.9800000,0.0000000,0.0000000,215.9918213); //
		CreateDynamicObject(3361,-3748.0400391,-2759.4169922,4.3550000,0.0000000,0.0000000,215.9912109); //
		CreateDynamicObject(9833,-3606.9521484,-2585.0419922,33.5460014,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14608,-3606.4099121,-2590.5070801,35.4729996,0.0000000,0.0000000,50.0000000); //
		CreateDynamicObject(9833,-3605.7629395,-2595.2949219,33.0709991,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1655,-3751.3359375,-2792.8261719,0.7500000,0.0000000,0.0000000,39.9957275); //
		CreateDynamicObject(1655,-3777.8239746,-2756.9230957,0.6500000,0.0000000,0.0000000,219.9902344); //
		CreateDynamicObject(714,-3545.3220215,-2442.4670410,23.1079998,0.0000000,0.0000000,69.9993896); //
		CreateDynamicObject(16207,-4313.7539062,-2572.5234375,-21.6599998,352.1118164,349.8980713,98.5858154); //
		CreateDynamicObject(10166,-3985.0957031,-2593.3759766,9.3249998,0.0000000,0.0000000,199.9951172); //
		CreateDynamicObject(18228,-3935.8964844,-2576.5458984,-4.5000000,0.0000000,0.0000000,101.9860840); //
		CreateDynamicObject(18228,-3939.2939453,-2576.3964844,-2.5000000,0.0000000,0.0000000,41.9842529); //
		CreateDynamicObject(18228,-4000.8671875,-2570.3007812,-4.6999998,0.0000000,0.0000000,171.9744873); //
		CreateDynamicObject(18228,-3990.2509766,-2570.5400391,-4.6999998,0.0000000,0.0000000,171.9799805); //
		CreateDynamicObject(18228,-4030.5800781,-2577.8720703,-4.6999998,0.0000000,0.0000000,171.9744873); //
		CreateDynamicObject(18228,-4049.6347656,-2603.9384766,-4.6999998,0.0000000,0.0000000,241.9793701); //
		CreateDynamicObject(16195,-4007.5058594,-2533.4208984,-24.0249996,0.0000000,0.0000000,339.9884033); //
		CreateDynamicObject(896,-3961.5161133,-2563.2380371,9.8380003,41.2209778,81.1135864,283.3476868); //
		CreateDynamicObject(896,-3962.9221191,-2564.8190918,13.7629995,41.2207031,81.1120605,333.3428955); //
		CreateDynamicObject(896,-3943.1489258,-2571.5229492,13.7629995,41.2207031,81.1120605,63.3416748); //
		CreateDynamicObject(896,-3951.5175781,-2566.5136719,6.7630000,345.8990479,33.1182861,164.3225098); //
		CreateDynamicObject(16192,-3621.1689453,-2814.0117188,-6.3350000,0.0000000,0.0000000,209.9981689); //
		CreateDynamicObject(16196,-3798.1809082,-2610.1459961,-40.1559982,0.0000000,0.0000000,339.9981689); //
		CreateDynamicObject(16120,-3720.6889648,-2555.3229980,-38.4760017,0.0000000,0.0000000,129.9938965); //
		CreateDynamicObject(16120,-3715.9499512,-2543.6918945,-38.4760017,0.0000000,0.0000000,129.9902344); //
		CreateDynamicObject(16120,-3709.8420410,-2549.8820801,-38.4760017,0.0000000,0.0000000,129.9902344); //
		CreateDynamicObject(16120,-3703.8400879,-2559.4528809,-38.4760017,0.0000000,0.0000000,129.9902344); //
		CreateDynamicObject(16120,-3699.9829102,-2565.1931152,-38.4760017,0.0000000,0.0000000,129.9902344); //
		CreateDynamicObject(18367,-3557.1699219,-2481.2099609,25.1639996,23.7469482,0.0000000,167.9963379); //
		CreateDynamicObject(18367,-3735.1818848,-2675.4208984,13.6750002,8.0000000,0.0000000,16.0000000); //
		CreateDynamicObject(18367,-3722.6831055,-2727.9899902,7.8000002,27.5362549,348.7066650,297.7707520); //
		CreateDynamicObject(869,-3622.0129395,-2826.0529785,37.3769989,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(869,-3624.1789551,-2820.4370117,38.1749992,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(869,-3623.3579102,-2817.6669922,38.2490005,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(869,-3626.9440918,-2816.3269043,38.2809982,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(869,-3619.8540039,-2814.6840820,38.2470016,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(869,-3624.2470703,-2812.8840332,38.3310013,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(869,-3628.2719727,-2819.1379395,38.0699997,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(869,-3627.4951172,-2823.4541016,37.9980011,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(869,-3623.5529785,-2825.0490723,37.8919983,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(869,-3631.3759766,-2816.9121094,37.9620018,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(869,-3617.3669434,-2809.9589844,38.2840004,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(869,-3621.0979004,-2809.3159180,38.3419991,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(869,-3616.5969238,-2817.0029297,38.1720009,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(869,-3619.4340820,-2819.8989258,38.0960007,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(869,-3615.3720703,-2821.0769043,37.9099998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(869,-3619.7739258,-2826.2180176,37.7639999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(869,-3616.6140137,-2824.4829102,37.6769981,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(869,-3613.4709473,-2826.9780273,37.4410019,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(869,-3616.9990234,-2829.1760254,37.5279999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(869,-3622.1140137,-2829.2089844,37.6339989,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(871,-3621.1069336,-2821.0729980,37.5789986,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(871,-3616.9050293,-2819.6030273,37.6199989,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(871,-3617.8630371,-2820.9970703,37.8019981,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(871,-3616.9360352,-2822.9108887,37.6160011,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(871,-3618.3520508,-2822.9770508,37.6459999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(871,-3620.8181152,-2824.9089355,37.6930008,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(871,-3619.5109863,-2823.8479004,37.6689987,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(871,-3624.2980957,-2825.0639648,37.7260017,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(871,-3626.1298828,-2823.8491211,37.8040009,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(871,-3628.9809570,-2818.0949707,37.8790016,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(871,-3629.1320801,-2820.1740723,37.8839989,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(871,-3627.5029297,-2823.1940918,37.8470001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(871,-3625.6359863,-2820.5129395,38.0070000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(871,-3625.1269531,-2817.4309082,38.1080017,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(871,-3620.4240723,-2813.9279785,38.0989990,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(871,-3619.6049805,-2809.7509766,38.1500015,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(871,-3624.5710449,-2812.7780762,38.1699982,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(871,-3622.3950195,-2811.4160156,38.1619987,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(871,-3617.0681152,-2817.2490234,38.0070000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(871,-3615.9250488,-2819.0629883,37.9290009,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(871,-3618.6250000,-2818.8610840,38.0040016,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(871,-3613.7141113,-2824.9829102,37.3699989,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(871,-3615.4670410,-2826.9479980,37.3689995,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(871,-3614.8869629,-2821.7438965,37.6749992,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(873,-3624.1069336,-2814.8730469,37.8499985,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(873,-3636.9340820,-2823.3449707,39.1129990,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(3532,-3623.9890137,-2822.1909180,37.6180000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(3532,-3622.2810059,-2822.0300293,37.5810013,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(3532,-3624.4221191,-2822.5778809,38.2770004,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(3532,-3627.3798828,-2820.9489746,38.3730011,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(3532,-3625.6359863,-2818.7519531,38.4529991,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(3532,-3624.3559570,-2815.4709473,38.5260010,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(3532,-3622.3630371,-2814.3278809,38.5169983,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(3532,-3629.5690918,-2821.0280762,38.2799988,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(3532,-3627.7189941,-2813.8520508,38.5940018,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(3532,-3631.4230957,-2815.1350098,38.2970009,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(3532,-3625.6860352,-2810.8789062,38.6110001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(3532,-3619.8999023,-2812.5891113,38.5110016,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(3532,-3616.3491211,-2808.4509277,38.5190010,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(3532,-3619.8830566,-2807.2060547,38.5830002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(3532,-3618.3679199,-2812.6721191,38.4900017,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(3532,-3621.1579590,-2816.5490723,38.4690018,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(3532,-3617.2180176,-2824.0520020,37.9529991,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(3532,-3614.1059570,-2823.2648926,37.9259987,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(3532,-3621.6760254,-2827.3469238,37.9790001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(875,-3618.0869141,-2824.3789062,39.0940018,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(875,-3625.1860352,-2813.5759277,39.6769981,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(875,-3636.4470215,-2823.5148926,39.1370010,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(875,-3637.1369629,-2819.1120605,39.0289993,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(875,-3615.1979980,-2814.4069824,39.5349998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(691,-3626.1484375,-2827.3437500,36.6609993,0.0000000,0.0000000,49.9987793); //
		CreateDynamicObject(843,-3630.7329102,-2811.4409180,38.6059990,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(839,-3613.2460938,-2807.4699707,39.2080002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(871,-3637.7119141,-2820.3291016,37.9449997,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(869,-3634.2080078,-2825.0778809,37.8170013,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(869,-3635.2729492,-2821.6340332,37.6669998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(869,-3638.7729492,-2821.5310059,37.6669998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(869,-3637.6918945,-2818.8100586,37.6669998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(869,-3635.3979492,-2817.3759766,37.6669998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(869,-3631.2500000,-2821.0009766,38.0169983,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(869,-3613.7939453,-2814.4580078,38.1669998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(791,-3625.2832031,-2817.0498047,35.5769997,0.0000000,0.0000000,328.1231689); //
		CreateDynamicObject(8623,-3634.4008789,-2824.1779785,37.4440002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(8623,-3636.4309082,-2825.7099609,37.3839989,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(8623,-3636.7519531,-2822.9020996,38.0810013,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(8623,-3626.7080078,-2829.8139648,37.9129982,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(8623,-3624.7189941,-2807.1010742,38.7270012,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(647,-3634.0070801,-2815.6259766,39.2519989,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(647,-3623.7490234,-2816.2399902,39.6570015,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(726,-3619.9240723,-2803.9619141,37.8709984,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(726,-3642.8349609,-2809.8193359,36.8709984,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(616,-3703.2119141,-2790.2241211,29.8419991,0.0000000,0.0000000,300.0000000); //
		CreateDynamicObject(616,-3648.4899902,-2825.4179688,36.5919991,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(622,-3626.9726562,-2969.5283203,2.1510000,17.9956055,0.0000000,129.9847412); //
		CreateDynamicObject(622,-3660.4853516,-2695.7949219,45.4620018,357.9949951,0.0000000,139.9768066); //
		CreateDynamicObject(3406,-3633.8349609,-2590.0891113,31.7199993,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(3406,-3625.0791016,-2590.0949707,31.7199993,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(3406,-3622.2099609,-2584.1879883,31.7199993,0.0000000,0.0000000,90.0000000); //
		CreateDynamicObject(3406,-3630.1931152,-2584.2280273,31.7199993,0.0000000,0.0000000,90.0000000); //
		CreateDynamicObject(3406,-3624.1931152,-2585.2419434,31.7199993,0.0000000,0.0000000,270.0000000); //
		CreateDynamicObject(3406,-3626.1960449,-2585.2419434,31.7199993,0.0000000,0.0000000,270.0000000); //
		CreateDynamicObject(3406,-3628.1940918,-2585.2790527,31.7199993,0.0000000,0.0000000,270.0000000); //
		CreateDynamicObject(12991,-3617.2338867,-2335.8688965,1.4380000,3.4835205,359.9835205,251.3156738); //
		CreateDynamicObject(17063,-3553.3789062,-2427.5200195,24.5489998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2030,-3626.3320312,-2584.6708984,34.1980019,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1720,-3626.2390137,-2583.9660645,33.7980003,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1720,-3626.2119141,-2585.2338867,33.7980003,0.0000000,0.0000000,180.0000000); //
		CreateDynamicObject(2801,-3626.3720703,-2584.6889648,34.2500000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(3406,-3616.2880859,-2590.0878906,32.1450005,0.0000000,354.7500000,0.0000000); //
		CreateDynamicObject(3406,-3611.8010254,-2590.0581055,32.5449982,0.0000000,354.7485352,0.0000000); //
		CreateDynamicObject(1299,-4201.9091797,-2726.3269043,6.8740001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1655,-3878.7329102,-2496.8000488,0.1000000,0.0000000,0.0000000,49.9877930); //
		CreateDynamicObject(1655,-3916.7265625,-2469.4707031,0.5250000,0.0000000,0.0000000,239.9798584); //
		CreateDynamicObject(901,-3447.3168945,-2737.9331055,0.2290000,0.0000000,0.0000000,349.9926758); //
		CreateDynamicObject(901,-3463.1660156,-2754.1689453,0.2290000,0.0000000,0.0000000,49.9926758); //
		CreateDynamicObject(901,-3458.2451172,-2776.1970215,-0.5210000,8.7398987,173.9291992,156.1252441); //
		CreateDynamicObject(901,-3435.7438965,-2784.2141113,-0.2210000,8.7396240,173.9245605,216.1212158); //
		CreateDynamicObject(901,-3419.0449219,-2768.8081055,0.2290000,0.0000000,0.0000000,249.9877930); //
		CreateDynamicObject(901,-3425.6430664,-2745.6779785,0.2290000,0.0000000,0.0000000,289.9829102); //
		CreateDynamicObject(16197,-3468.7490234,-3193.8710938,-32.9269981,0.0000000,0.0000000,349.9914551); //
		CreateDynamicObject(16693,-3429.4350586,-2734.3559570,-40.7229996,0.0000000,0.0000000,280.0000000); //
		CreateDynamicObject(622,-3439.6152344,-2763.4423828,0.9280000,13.9910889,0.0000000,139.9768066); //
		CreateDynamicObject(622,-3439.6030273,-2762.6789551,0.9280000,13.9910889,0.0000000,179.9768066); //
		CreateDynamicObject(869,-3441.3911133,-2761.9870605,3.8499999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(869,-3439.7160645,-2762.3049316,4.2870002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(869,-3440.7070312,-2765.0490723,4.1999998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(869,-3442.1230469,-2764.0190430,3.7869999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(872,-3440.6708984,-2759.4599609,3.4380000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14468,-3441.8400879,-2764.3911133,3.4289999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14468,-3441.0900879,-2765.3630371,4.4780002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(810,-3441.9799805,-2763.4169922,3.3369999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(810,-3444.3479004,-2762.3330078,2.8750000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(810,-3440.0639648,-2758.6311035,3.5790000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(818,-3443.8229980,-2760.7590332,5.8429999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(818,-3440.7380371,-2765.4770508,5.8429999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(823,-3438.2661133,-2761.8410645,4.0419998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(823,-3437.5270996,-2763.2119141,4.7150002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(826,-3444.6669922,-2764.0249023,3.9540000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(872,-3438.0681152,-2758.8120117,4.0440001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(16116,-3586.5190430,-2642.2099609,-33.4510002,0.0000000,0.0000000,139.9877930); //
		CreateDynamicObject(16116,-3574.9150391,-2624.2299805,-33.4510002,0.0000000,0.0000000,109.9877930); //
		CreateDynamicObject(16116,-3548.4760742,-2640.8120117,-33.4510002,0.0000000,0.0000000,109.9841309); //
		CreateDynamicObject(16116,-3545.2409668,-2634.1740723,-35.4510002,0.0000000,0.0000000,109.9841309); //
		CreateDynamicObject(16116,-3555.6818848,-2612.4409180,-35.4510002,0.0000000,0.0000000,109.9841309); //
		CreateDynamicObject(16116,-3554.5019531,-2600.2290039,-35.4510002,0.0000000,0.0000000,109.9841309); //
		CreateDynamicObject(16116,-3555.7189941,-2592.1840820,-35.4510002,0.0000000,0.0000000,109.9841309); //
		CreateDynamicObject(16116,-3569.0329590,-2593.1809082,-30.2010002,0.0000000,0.0000000,89.9841309); //
		CreateDynamicObject(16116,-3570.3669434,-2615.6931152,-30.9510002,0.0000000,0.0000000,89.9835205); //
		CreateDynamicObject(16116,-3562.1040039,-2615.8540039,-33.9510002,0.0000000,0.0000000,89.9835205); //
		CreateDynamicObject(16116,-3561.5329590,-2629.7490234,-35.2010002,0.0000000,0.0000000,89.9835205); //
		CreateDynamicObject(16116,-3499.3400879,-2509.4670410,-31.3789997,0.0000000,0.0000000,289.9896240); //
		CreateDynamicObject(16116,-3532.8249512,-2697.3039551,-33.7760010,0.0000000,0.0000000,289.9896240); //
		CreateDynamicObject(16116,-3530.2380371,-2688.3940430,-33.7760010,0.0000000,0.0000000,289.9896240); //
		CreateDynamicObject(16116,-3528.7648926,-2676.1950684,-33.7760010,0.0000000,0.0000000,289.9896240); //
		CreateDynamicObject(8493,-3897.1950684,-2416.1940918,22.7950001,18.0000000,0.0000000,260.0000000); //
		CreateDynamicObject(16120,-3900.1816406,-2433.0947266,-16.1159992,0.0000000,0.0000000,155.9838867); //
		CreateDynamicObject(2097,-3558.3769531,-2446.6054688,25.3929996,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(710,-3565.7360840,-2434.5371094,38.5970001,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3572.3867188,-2435.4921875,37.8470001,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3571.3300781,-2444.0949707,37.8470001,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3579.1950684,-2429.1450195,37.6969986,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3588.9970703,-2430.5529785,36.7470016,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3598.4929199,-2429.6120605,35.0470009,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3608.0048828,-2429.8830566,34.1720009,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3577.3007812,-2442.5830078,36.6720009,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3574.7949219,-2450.1411133,35.6720009,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3577.1259766,-2422.1169434,36.6739998,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3567.0258789,-2456.9550781,34.6720009,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3567.0253906,-2456.9550781,34.6720009,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(622,-3661.3544922,-2528.5654297,57.0320015,13.9910889,0.0000000,29.9761963); //
		CreateDynamicObject(1562,-4021.4780273,-2969.4699707,8.3660002,16.2500610,0.0000000,0.0000000); //
		CreateDynamicObject(1562,-4024.7451172,-2968.0830078,8.8660002,4.2487793,0.0000000,270.0000000); //
		CreateDynamicObject(710,-3671.0300293,-2673.4990234,38.7340012,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(1710,-3888.8159180,-2405.9450684,7.1799998,0.0000000,0.0000000,250.0000000); //
		CreateDynamicObject(1752,-3892.5742188,-2406.3925781,7.3811641,0.0000000,0.0000000,69.9993896); //
		CreateDynamicObject(2314,-3892.5800781,-2407.3210449,7.0229998,0.0000000,0.0000000,70.0000000); //
		CreateDynamicObject(2346,-3891.1979980,-2409.2209473,7.1209998,359.5015564,4.5001831,150.0392456); //
		CreateDynamicObject(1711,-3891.5769043,-2410.3068848,7.0660000,0.0000000,4.5000000,170.0000000); //
		CreateDynamicObject(2837,-3892.0161133,-2408.7280273,7.5440001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2838,-3891.3500977,-2409.0520020,7.6020002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(647,-3894.9650879,-2408.2490234,8.1009998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(647,-3886.8769531,-2408.8068848,8.0010004,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(647,-3885.4729004,-2405.9951172,8.2510004,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(647,-3893.5668945,-2404.1850586,8.1510000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(691,-3894.3847656,-2406.2880859,3.1029999,0.0000000,0.0000000,49.9987793); //
		CreateDynamicObject(653,-3701.1369629,-2785.6560059,32.5589981,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(653,-3658.0800781,-2694.7207031,46.7519989,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(653,-3657.5878906,-2702.8391113,45.4560013,0.0000000,0.0000000,270.0000000); //
		CreateDynamicObject(710,-3648.7409668,-2583.6311035,47.3139992,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3632.9938965,-2586.8129883,47.1510010,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3654.8200684,-2583.6169434,47.3139992,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3651.2290039,-2576.1889648,46.5639992,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3643.3750000,-2573.1250000,46.5639992,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3730.6789551,-2754.1088867,20.7539997,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3642.9394531,-2580.3974609,46.5639992,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(707,-3882.6914062,-2431.6337891,5.3449998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1631,-3916.1389160,-2434.7758789,0.4390000,0.0000000,0.0000000,349.9969482); //
		CreateDynamicObject(1742,-3558.2971191,-2443.2229004,25.0930004,0.0000000,0.0000000,46.0000000); //
		CreateDynamicObject(1742,-3559.2749023,-2444.2319336,25.0930004,0.0000000,0.0000000,45.9997559); //
		CreateDynamicObject(3525,-3606.7241211,-2588.3579102,34.9690018,0.0000000,0.0000000,270.0000000); //
		CreateDynamicObject(3525,-3606.3820801,-2592.3530273,34.9690018,0.0000000,0.0000000,270.0000000); //
		CreateDynamicObject(16502,-3656.1079102,-2657.2939453,31.9130001,350.9527588,334.3963623,235.6872559); //
		CreateDynamicObject(9833,-3667.5146484,-2678.1806641,24.1599998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2901,-4199.7578125,-2733.2329102,6.8080001,0.0000000,0.0000000,40.0000000); //
		CreateDynamicObject(2901,-4199.8818359,-2732.8330078,7.0330000,0.0000000,54.0000000,129.9957275); //
		CreateDynamicObject(2901,-4200.3120117,-2733.2150879,7.0330000,3.0430298,44.3266907,154.2770996); //
		CreateDynamicObject(2901,-4201.0888672,-2734.2839355,6.8080001,0.0000000,0.0000000,39.9957275); //
		CreateDynamicObject(2901,-4201.3056641,-2733.8935547,6.8080001,0.0000000,0.0000000,39.9957275); //
		CreateDynamicObject(2901,-4201.2167969,-2734.1079102,7.1079998,0.0000000,0.0000000,39.9957275); //
		CreateDynamicObject(1766,-4205.9291992,-2734.5959473,6.4809999,0.0000000,0.0000000,130.0000000); //
		CreateDynamicObject(15037,-4204.0322266,-2732.1376953,6.7690001,0.0000000,0.0000000,199.9951172); //
		CreateDynamicObject(1255,-3651.8269043,-2693.2019043,48.5629997,359.2568665,352.2493286,359.8988647); //
		CreateDynamicObject(1255,-3651.6721191,-2691.6989746,48.5130005,359.2529297,352.2491455,339.8956299); //
		CreateDynamicObject(1255,-3649.8068848,-2694.7150879,48.8629990,359.2611694,348.4988098,79.8463745); //
		CreateDynamicObject(2914,-3657.6879883,-2760.3291016,47.5139999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(710,-3729.4189453,-2653.6777344,22.7089996,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3726.6340332,-2748.0070801,19.5039997,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3733.3549805,-2761.9780273,21.7539997,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3735.6760254,-2756.4208984,21.0039997,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3734.4780273,-2768.9289551,21.5039997,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3738.3769531,-2762.6130371,21.5039997,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(726,-3707.9431152,-2776.9279785,31.7000008,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(654,-3697.5219727,-2791.7990723,32.3400002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(654,-3650.6450195,-2815.9130859,36.8440018,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(683,-3698.9650879,-2801.6459961,28.7490005,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(16120,-3616.3076172,-2957.1923828,-1.7750000,0.0000000,0.0000000,349.9914551); //
		CreateDynamicObject(2725,-3556.5600586,-2445.3310547,25.3260002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(691,-3878.4570312,-2413.6499023,7.7030001,0.0000000,0.0000000,49.9987793); //
		CreateDynamicObject(789,-3886.7207031,-2397.9277344,20.1149998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2361,-3887.6079102,-2403.1508789,7.4020000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2361,-3890.3620605,-2410.6179199,7.0770001,0.0000000,0.0000000,340.0000000); //
		CreateDynamicObject(647,-3885.5849609,-2412.1520996,8.8129997,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(647,-3884.1770020,-2413.6760254,8.8129997,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(647,-3882.2580566,-2412.6918945,8.8129997,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(647,-3884.7971191,-2410.0778809,8.8129997,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(647,-3880.8081055,-2411.7160645,8.8129997,0.0000000,0.0000000,320.0000000); //
		CreateDynamicObject(647,-3882.0920410,-2410.4541016,8.8129997,0.0000000,0.0000000,319.9987793); //
		CreateDynamicObject(647,-3884.2370605,-2407.8549805,8.8129997,0.0000000,0.0000000,319.9987793); //
		CreateDynamicObject(789,-3851.0712891,-2358.4345703,20.7830009,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(11413,-3856.0966797,-2361.2138672,8.4759998,0.9997559,0.9997559,359.9780273); //
		CreateDynamicObject(16120,-3747.2490234,-2478.0732422,-1.3660001,0.0000000,0.0000000,95.9930420); //
		CreateDynamicObject(16120,-3706.1330566,-2513.9350586,-30.1630001,0.0000000,0.0000000,95.9930420); //
		CreateDynamicObject(16120,-3666.0410156,-2468.3500977,-30.1630001,0.0000000,0.0000000,95.9930420); //
		CreateDynamicObject(710,-3565.8200684,-2420.7680664,38.5970001,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3571.3859863,-2426.7041016,37.8470001,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3564.5458984,-2427.5820312,37.8470001,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3575.4699707,-2425.3588867,37.3470001,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3580.8459473,-2449.7460938,38.0970001,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3601.8491211,-2432.0739746,34.8969994,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3596.7299805,-2434.8310547,35.3720016,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3588.8449707,-2440.5200195,34.8470001,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(727,-3571.0270996,-2460.5878906,24.4810009,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(727,-3572.5761719,-2441.0205078,23.6310005,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(726,-3585.3210449,-2430.0019531,21.6030006,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(729,-3575.2661133,-2453.3039551,24.2169991,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(729,-3564.8544922,-2464.4951172,24.7590008,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(726,-3570.7219238,-2450.3369141,24.6280003,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(726,-3569.5332031,-2419.1259766,22.7129993,0.0000000,0.0000000,299.9981689); //
		CreateDynamicObject(707,-3557.0739746,-2457.4819336,24.5890007,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(16197,-4271.6445312,-3079.3027344,-52.1150017,0.0000000,0.0000000,349.9914551); //
		CreateDynamicObject(19339,-3556.8830566,-2447.5190430,25.4470005,0.0000000,0.0000000,44.0000000); //
		CreateDynamicObject(18858,-3848.2199707,-2659.7509766,9.1250000,0.0000000,0.0000000,210.0000000); //
		CreateDynamicObject(18751,-3829.3378906,-2813.4472656,0.1940000,2.7410889,0.4998779,57.9473877); //
		CreateDynamicObject(1655,-3854.3999023,-2648.7189941,0.8000000,0.0000000,0.0000000,209.9902344); //
		CreateDynamicObject(703,-4254.8896484,-3007.4072266,0.4550000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(653,-3994.6059570,-2659.9970703,7.2230000,0.0000000,0.0000000,299.9981689); //
		CreateDynamicObject(653,-3996.7128906,-2666.7929688,7.5229998,0.0000000,0.0000000,219.9957275); //
		CreateDynamicObject(18259,-3972.1748047,-3397.1806641,0.9500000,0.0000000,0.0000000,90.0000000); //
		CreateDynamicObject(16120,-3978.7783203,-3380.9218750,-2.2500000,0.0000000,0.0000000,69.9829102); //
		CreateDynamicObject(727,-3578.9130859,-2437.5019531,22.5060005,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(16207,-3824.7548828,-2498.0690918,-81.7979965,352.1118164,349.8980713,208.5919189); //
		CreateDynamicObject(16207,-3858.9489746,-2531.0070801,-81.7979965,352.1118164,349.8980713,208.5919189); //
		CreateDynamicObject(16207,-3938.2290039,-2568.8220215,-81.7979965,352.1118164,349.8980713,208.5919189); //
		CreateDynamicObject(16195,-3681.5820312,-3312.5949707,-50.3030014,0.0000000,0.0000000,349.9804688); //
		CreateDynamicObject(16120,-3999.0244141,-3408.8056641,-2.2500000,0.0000000,0.0000000,129.9847412); //
		CreateDynamicObject(648,-4041.2851562,-2543.8115234,29.4589996,0.0000000,0.0000000,81.9689941); //
		CreateDynamicObject(11489,-3533.9641113,-3855.1149902,7.5760002,0.0000000,0.0000000,139.4919434); //
		CreateDynamicObject(11420,-4054.1560059,-3363.9108887,9.7570000,0.2499084,1.5000000,359.9934692); //
		CreateDynamicObject(16694,-3889.8588867,-3380.6831055,-34.7599983,0.0000000,6.0000000,189.9920654); //
		CreateDynamicObject(2359,-3974.4960938,-3393.1721191,1.2460001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2358,-3975.3300781,-3393.2329102,1.3960000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2358,-3975.3378906,-3393.2399902,1.1520000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2358,-3975.7919922,-3393.6530762,1.1520000,0.0000000,0.0000000,320.0000000); //
		CreateDynamicObject(16120,-3990.4890137,-3436.9270020,-2.2500000,0.0000000,0.0000000,179.9847412); //
		CreateDynamicObject(16120,-3964.6494141,-3441.0888672,-2.2500000,0.0000000,0.0000000,249.9829102); //
		CreateDynamicObject(16120,-3949.1718750,-3389.5751953,-2.2500000,0.0000000,0.0000000,359.9780273); //
		CreateDynamicObject(3406,-3974.3420410,-3407.3500977,-1.8250000,0.0000000,0.0000000,2.0000000); //
		CreateDynamicObject(3406,-3983.1088867,-3407.6508789,-1.8250000,0.0000000,0.0000000,1.9995117); //
		CreateDynamicObject(3406,-3986.8959961,-3412.6130371,-1.8250000,0.0000000,0.0000000,91.9995117); //
		CreateDynamicObject(3406,-3986.5920410,-3421.3491211,-1.8250000,0.0000000,0.0000000,91.9940186); //
		CreateDynamicObject(3406,-3981.8906250,-3417.1826172,-1.8250000,0.0000000,0.0000000,181.9885254); //
		CreateDynamicObject(3406,-3981.6120605,-3425.1389160,-1.8250000,0.0000000,0.0000000,181.9885254); //
		CreateDynamicObject(2096,-3963.4829102,-3404.0029297,1.0360000,0.0000000,0.0000000,310.0000000); //
		CreateDynamicObject(2096,-3964.6721191,-3403.7480469,1.0360000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14831,-3965.1760254,-3406.9250488,2.5390000,0.0000000,0.0000000,182.0000000); //
		CreateDynamicObject(2802,-3977.3259277,-3399.5439453,1.3660001,0.0000000,0.0000000,280.0000000); //
		CreateDynamicObject(2802,-3965.8759766,-3399.8000488,1.3660001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2802,-3975.3120117,-3400.2561035,1.3660001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2802,-3976.6330566,-3396.0529785,1.3660001,0.0000000,0.0000000,329.9975586); //
		CreateDynamicObject(2802,-3974.4240723,-3397.5581055,1.3660001,0.0000000,0.0000000,269.9963379); //
		CreateDynamicObject(2802,-3968.1831055,-3397.6860352,1.3660001,0.0000000,0.0000000,269.9945068); //
		CreateDynamicObject(2802,-3965.1359863,-3396.2919922,1.3660001,0.0000000,0.0000000,219.9945068); //
		CreateDynamicObject(2802,-3970.6440430,-3398.7060547,1.3660001,0.0000000,0.0000000,179.9902344); //
		CreateDynamicObject(16207,-3715.5185547,-2578.9580078,-36.0180016,352.1118164,349.8980713,208.5919189); //
		CreateDynamicObject(16207,-4352.8950195,-2618.6298828,-48.5299988,358.0198059,349.9886169,99.6424866); //
		CreateDynamicObject(16207,-4339.3349609,-2576.3310547,-59.6500015,352.1118164,349.8980713,98.5912781); //
		CreateDynamicObject(18751,-4356.2441406,-2641.7141113,-6.9499998,1.2414551,0.0000000,199.9615479); //
		CreateDynamicObject(18751,-4379.5400391,-2608.1918945,-7.1999998,1.2414551,0.0000000,199.9511719); //
		CreateDynamicObject(18751,-4309.5917969,-2633.9650879,-6.9499998,1.2414551,0.0000000,199.9566650); //
		CreateDynamicObject(18751,-4343.7221680,-2610.6508789,-6.9499998,1.2414551,0.0000000,199.9566650); //
		CreateDynamicObject(18751,-4329.1782227,-2604.7639160,-6.9499998,1.2414551,0.0000000,199.9566650); //
		CreateDynamicObject(18751,-4328.3759766,-2635.5090332,-6.9499998,1.2414551,0.0000000,199.9566650); //
		CreateDynamicObject(18751,-4365.6767578,-2622.1879883,-6.9499998,1.2414551,0.0000000,199.9566650); //
		CreateDynamicObject(18751,-4368.8388672,-2597.0559082,-6.9499998,1.2414551,0.0000000,199.9566650); //
		CreateDynamicObject(18751,-4344.1020508,-2640.4980469,-6.9499998,1.2414551,0.0000000,199.9566650); //
		CreateDynamicObject(18751,-4362.6552734,-2606.6474609,-6.9499998,1.2414551,0.0000000,199.9511719); //
		CreateDynamicObject(791,-4233.9082031,-2664.1088867,-2.9289999,0.0000000,0.0000000,328.1231689); //
		CreateDynamicObject(791,-4347.3125000,-2666.5947266,-8.9289999,0.0000000,0.0000000,28.1195068); //
		CreateDynamicObject(791,-4333.7421875,-2641.5869141,-12.1789999,0.0000000,0.0000000,28.1195068); //
		CreateDynamicObject(791,-4325.9848633,-2620.5061035,-12.1789999,0.0000000,0.0000000,28.1195068); //
		CreateDynamicObject(791,-4339.1079102,-2606.6621094,-12.1789999,0.0000000,0.0000000,28.1195068); //
		CreateDynamicObject(791,-4345.3168945,-2585.7160645,-12.1789999,0.0000000,0.0000000,28.1195068); //
		CreateDynamicObject(791,-4352.9619141,-2548.9099121,-0.4390000,0.0000000,0.0000000,28.1195068); //
		CreateDynamicObject(791,-4350.7763672,-2515.8056641,8.8109999,0.0000000,0.0000000,28.1140137); //
		CreateDynamicObject(791,-4345.3110352,-2523.1621094,5.5609999,0.0000000,0.0000000,28.1195068); //
		CreateDynamicObject(791,-4375.0380859,-2512.3840332,5.5609999,0.0000000,0.0000000,48.1195068); //
		CreateDynamicObject(791,-4351.9287109,-2612.3173828,-12.1789999,0.0000000,0.0000000,28.1140137); //
		CreateDynamicObject(791,-4303.5527344,-2613.2333984,-12.1789999,0.0000000,0.0000000,28.1140137); //
		CreateDynamicObject(791,-4273.1777344,-2651.3994141,-13.9289999,0.0000000,0.0000000,28.1140137); //
		CreateDynamicObject(791,-4296.9819336,-2643.6840820,-15.9289999,0.0000000,0.0000000,28.1195068); //
		CreateDynamicObject(683,-4385.5507812,-2526.1250000,21.3810005,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(683,-4379.8862305,-2531.6240234,21.3810005,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(683,-4367.9389648,-2529.0830078,21.3810005,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(669,-4386.2358398,-2534.0109863,21.5060005,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18751,-4306.7158203,-2605.3251953,-5.4800000,1.2414551,0.0000000,179.9615479); //
		CreateDynamicObject(18751,-4329.1079102,-2610.0859375,-5.4800000,1.2414551,0.0000000,109.9615479); //
		CreateDynamicObject(16195,-4426.3559570,-2590.3190918,-36.6020012,0.0000000,0.0000000,209.9859619); //
		CreateDynamicObject(16195,-4454.0161133,-2596.1499023,-36.6020012,0.0000000,0.0000000,169.9816895); //
		CreateDynamicObject(16195,-4441.1669922,-2570.2561035,-36.6020012,0.0000000,0.0000000,139.9804688); //
		CreateDynamicObject(5153,-3877.3798828,-3214.4130859,37.2910004,0.0000000,23.4942627,269.9890137); //
		CreateDynamicObject(18751,-4380.8178711,-2627.8679199,-7.1999998,1.2414551,0.0000000,199.9511719); //
		CreateDynamicObject(18751,-4384.6201172,-2643.9819336,-7.1999998,1.2414551,0.0000000,199.9511719); //
		CreateDynamicObject(18751,-4392.1250000,-2606.8549805,-7.1999998,1.2414551,0.0000000,199.9511719); //
		CreateDynamicObject(18751,-4405.6728516,-2610.0300293,-7.1999998,1.2414551,0.0000000,199.9511719); //
		CreateDynamicObject(18751,-4401.8339844,-2629.6730957,-7.1999998,1.2414551,0.0000000,199.9511719); //
		CreateDynamicObject(18751,-4412.6538086,-2649.3159180,-7.1999998,1.2414551,0.0000000,199.9511719); //
		CreateDynamicObject(18751,-4376.0039062,-2672.6330566,-7.1999998,1.2414551,0.0000000,199.9511719); //
		CreateDynamicObject(18751,-4386.1201172,-2657.3149414,-7.1999998,1.2414551,0.0000000,199.9511719); //
		CreateDynamicObject(18751,-4408.8281250,-2698.1889648,-7.1999998,1.2414551,0.0000000,199.9511719); //
		CreateDynamicObject(18751,-4446.6528320,-2658.9509277,-6.3000002,1.2414551,0.0000000,199.9511719); //
		CreateDynamicObject(18751,-4428.2304688,-2658.6630859,-6.3000002,1.2414551,0.0000000,199.9511719); //
		CreateDynamicObject(18751,-4412.7299805,-2666.6770020,-6.3000002,1.2414551,0.0000000,199.9511719); //
		CreateDynamicObject(18751,-4393.4824219,-2686.3417969,-7.1999998,1.2414551,0.0000000,199.9511719); //
		CreateDynamicObject(18751,-4409.5678711,-2686.7690430,-7.1999998,1.2414551,0.0000000,199.9511719); //
		CreateDynamicObject(18751,-4394.2480469,-2661.0559082,-6.8499999,1.2414551,0.0000000,199.9511719); //
		CreateDynamicObject(18751,-4376.4580078,-2651.7770996,-6.8499999,1.2414551,0.0000000,199.9511719); //
		CreateDynamicObject(791,-4368.5898438,-2634.2839355,-12.5790005,0.0000000,0.0000000,28.1140137); //
		CreateDynamicObject(791,-4386.9799805,-2604.9270020,-12.5790005,0.0000000,0.0000000,28.1140137); //
		CreateDynamicObject(791,-4401.1611328,-2650.7780762,-12.5790005,0.0000000,0.0000000,28.1140137); //
		CreateDynamicObject(791,-4427.8349609,-2625.2822266,-12.5790005,0.0000000,0.0000000,28.1140137); //
		CreateDynamicObject(18751,-4439.5761719,-2614.5869141,-7.1999998,1.2414551,0.0000000,199.9511719); //
		CreateDynamicObject(791,-4427.5952148,-2608.8620605,-12.5790005,0.0000000,0.0000000,28.1140137); //
		CreateDynamicObject(791,-4420.0917969,-2655.8491211,-12.5790005,0.0000000,0.0000000,28.1140137); //
		CreateDynamicObject(791,-4429.2929688,-2662.8652344,-12.5790005,0.0000000,0.0000000,338.1097412); //
		CreateDynamicObject(18751,-4432.9038086,-2583.0539551,-7.1999998,1.2414551,0.0000000,199.9511719); //
		CreateDynamicObject(18751,-4466.1679688,-2594.8020020,-7.1999998,1.2414551,0.0000000,199.9511719); //
		CreateDynamicObject(18751,-4460.5551758,-2572.1220703,-7.1999998,1.2414551,0.0000000,199.9511719); //
		CreateDynamicObject(18751,-4429.8989258,-2562.1579590,-7.1999998,1.2414551,0.0000000,199.9511719); //
		CreateDynamicObject(18751,-4443.3862305,-2571.3911133,-7.1999998,1.2414551,0.0000000,199.9511719); //
		CreateDynamicObject(18751,-4458.0908203,-2557.8139648,-7.1999998,1.2414551,0.0000000,199.9511719); //
		CreateDynamicObject(18751,-4443.5048828,-2548.2680664,-7.1999998,1.2414551,0.0000000,199.9511719); //
		CreateDynamicObject(18751,-4419.5952148,-2550.2990723,-7.1999998,1.2414551,0.0000000,199.9511719); //
		CreateDynamicObject(18751,-4403.5751953,-2524.6970215,-6.5500002,1.2414551,0.0000000,199.9511719); //
		CreateDynamicObject(18751,-4433.6538086,-2538.6970215,-7.1999998,1.2414551,0.0000000,199.9511719); //
		CreateDynamicObject(18751,-4444.5971680,-2523.6650391,-7.1999998,1.2414551,0.0000000,199.9511719); //
		CreateDynamicObject(18751,-4407.8408203,-2504.8850098,-7.1999998,1.2414551,0.0000000,199.9511719); //
		CreateDynamicObject(18751,-4414.5541992,-2504.1311035,-5.1999998,1.2414551,0.0000000,199.9511719); //
		CreateDynamicObject(18751,-4445.5551758,-2525.2990723,-6.1999998,1.2414551,0.0000000,199.9511719); //
		CreateDynamicObject(18751,-4444.8349609,-2557.4770508,-4.9499998,1.2414551,0.0000000,159.9511719); //
		CreateDynamicObject(18751,-4461.5112305,-2576.1818848,-4.9499998,1.2414551,0.0000000,119.9499512); //
		CreateDynamicObject(18751,-4447.3051758,-2507.9609375,-6.9499998,1.2414551,0.0000000,199.9511719); //
		CreateDynamicObject(18751,-4401.8339844,-2629.6730957,-5.6999998,1.2414551,0.0000000,199.9511719); //
		CreateDynamicObject(18751,-4384.6962891,-2637.0517578,-5.5500002,1.2414551,0.0000000,109.9456787); //
		CreateDynamicObject(18751,-4362.6557617,-2606.6479492,-5.4499998,1.2414551,0.0000000,199.9511719); //
		CreateDynamicObject(791,-4446.3730469,-2590.6931152,-12.5790005,0.0000000,0.0000000,28.1140137); //
		CreateDynamicObject(791,-4454.0629883,-2582.8798828,-12.5790005,0.0000000,0.0000000,328.1140137); //
		CreateDynamicObject(791,-4450.0878906,-2557.8469238,-12.5790005,0.0000000,0.0000000,28.1140137); //
		CreateDynamicObject(791,-4442.9409180,-2529.8730469,-12.5790005,0.0000000,0.0000000,118.1140137); //
		CreateDynamicObject(791,-4423.9140625,-2509.3300781,-13.3290005,0.0000000,0.0000000,118.1085205); //
		CreateDynamicObject(791,-4415.9941406,-2493.6669922,-13.3290005,0.0000000,0.0000000,118.1085205); //
		CreateDynamicObject(791,-4463.9599609,-2508.6818848,-13.3290005,0.0000000,0.0000000,118.1085205); //
		CreateDynamicObject(791,-4391.7900391,-2499.9843750,-13.3290005,0.0000000,0.0000000,118.1085205); //
		CreateDynamicObject(758,-4406.8388672,-2556.9541016,3.0999999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(880,-4406.6049805,-2560.9299316,4.0019999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(906,-4407.7060547,-2558.1311035,7.0879998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(906,-4404.0859375,-2561.2060547,8.8380003,66.8033447,299.7363892,118.1402283); //
		CreateDynamicObject(906,-4406.1372070,-2558.9050293,10.0380001,59.9395752,225.0180511,199.1000519); //
		CreateDynamicObject(897,-4411.6279297,-2572.1450195,2.8280001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(905,-4403.3603516,-2560.3388672,6.4310002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(905,-4403.0268555,-2561.3149414,6.7620001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(905,-4403.3837891,-2559.8181152,6.9559999,314.2501831,180.0000000,180.0000000); //
		CreateDynamicObject(897,-4409.5097656,-2570.2028809,11.9280005,0.0000000,0.0000000,280.0000000); //
		CreateDynamicObject(3798,-4221.7221680,-3225.3300781,10.7659998,0.0000000,0.0000000,339.9993896); //
		CreateDynamicObject(960,-3995.5468750,-3034.8515625,9.1700001,0.0000000,0.0000000,24.9938965); //
		CreateDynamicObject(897,-4419.0371094,-2560.2009277,2.8280001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(897,-4422.6791992,-2571.9819336,2.8280001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(900,-4410.5532227,-2568.5729980,20.5520000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(897,-4417.6127930,-2564.5620117,12.5780001,21.9732361,306.7401428,32.6227112); //
		CreateDynamicObject(622,-3767.1669922,-3100.7250977,0.5590000,76.0000000,180.0000000,279.9768066); //
		CreateDynamicObject(16195,-3518.3920898,-2282.8979492,-11.0050001,2.2500000,0.0000000,209.9981689); //
		CreateDynamicObject(16192,-3853.5595703,-2340.1367188,-36.7410011,0.0000000,0.0000000,339.9884033); //
		CreateDynamicObject(16120,-4433.6269531,-3244.3200684,-2.2500000,0.0000000,0.0000000,319.9792480); //
		CreateDynamicObject(16120,-3951.9331055,-3600.8750000,2.7800000,0.0000000,0.0000000,349.9816895); //
		CreateDynamicObject(16120,-3941.3359375,-3564.9370117,2.2800000,0.0000000,0.0000000,289.9804688); //
		CreateDynamicObject(16120,-3910.4851074,-3562.5739746,2.2800000,0.0000000,0.0000000,179.9786377); //
		CreateDynamicObject(16120,-3941.4040527,-3605.0019531,2.7800000,0.0000000,0.0000000,39.9804688); //
		CreateDynamicObject(16120,-3914.5429688,-3600.3210449,2.7800000,0.0000000,0.0000000,99.9792480); //
		CreateDynamicObject(7916,-3708.4479980,-3303.4990234,3.9250000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(7916,-3732.8391113,-3327.3420410,3.9250000,0.0000000,0.0000000,40.0000000); //
		CreateDynamicObject(7916,-3721.6169434,-3315.7939453,3.9250000,0.0000000,0.0000000,19.9957275); //
		CreateDynamicObject(7916,-3713.5310059,-3309.7839355,3.9250000,0.0000000,0.0000000,9.9951172); //
		CreateDynamicObject(7916,-3734.0629883,-3335.0419922,3.9250000,0.0000000,0.0000000,59.9920654); //
		CreateDynamicObject(7916,-3714.7351074,-3358.9670410,3.9250000,0.0000000,0.0000000,129.9908447); //
		CreateDynamicObject(7916,-3718.5510254,-3355.6379395,3.9250000,0.0000000,0.0000000,129.9902344); //
		CreateDynamicObject(7916,-3684.5568848,-3357.7509766,3.9250000,0.0000000,0.0000000,189.9902344); //
		CreateDynamicObject(7916,-3678.4150391,-3352.9309082,3.9250000,0.0000000,0.0000000,189.9865723); //
		CreateDynamicObject(7916,-3664.2780762,-3335.4130859,3.9250000,0.0000000,0.0000000,229.9865723); //
		CreateDynamicObject(7916,-3670.4431152,-3313.6589355,3.9250000,0.0000000,0.0000000,269.9822998); //
		CreateDynamicObject(7916,-3666.5148926,-3318.8220215,3.9250000,0.0000000,0.0000000,269.9780273); //
		CreateDynamicObject(7916,-3690.8925781,-3302.6552734,3.9250000,0.0000000,0.0000000,329.9743652); //
		CreateDynamicObject(16120,-3696.3469238,-3292.4509277,-1.9500000,0.0000000,0.0000000,49.9755859); //
		CreateDynamicObject(16120,-3727.5681152,-3309.6059570,-1.0750000,0.0000000,0.0000000,99.9713135); //
		CreateDynamicObject(16120,-4044.0109863,-2916.5100098,-10.6840000,0.0000000,0.0000000,169.9688721); //
		CreateDynamicObject(16120,-3720.3984375,-3365.9013672,-0.9000000,0.0000000,0.0000000,199.9676514); //
		CreateDynamicObject(16120,-3657.4980469,-3333.5061035,-1.0250000,0.0000000,0.0000000,309.9676514); //
		CreateDynamicObject(16120,-3696.1083984,-3369.3837891,-0.7750000,0.0000000,0.0000000,249.9609375); //
		CreateDynamicObject(18751,-3696.0729980,-3328.3210449,-6.6059999,0.0000000,0.0000000,329.9963379); //
		CreateDynamicObject(18751,-3729.5839844,-3326.4919434,-6.4060001,0.0000000,0.0000000,329.9963379); //
		CreateDynamicObject(18751,-3714.5969238,-3327.3120117,-6.5809999,0.0000000,0.0000000,329.9963379); //
		CreateDynamicObject(18751,-3706.6069336,-3302.8378906,-6.4060001,0.0000000,0.0000000,329.9963379); //
		CreateDynamicObject(18751,-3695.0759277,-3317.2561035,-6.4060001,0.0000000,0.0000000,329.9963379); //
		CreateDynamicObject(18751,-3681.9499512,-3341.0759277,-6.4060001,0.0000000,0.0000000,329.9963379); //
		CreateDynamicObject(18751,-3700.0878906,-3335.1101074,-6.4060001,0.0000000,0.0000000,329.9963379); //
		CreateDynamicObject(18751,-3691.0769043,-3324.3049316,-6.4060001,0.0000000,0.0000000,329.9963379); //
		CreateDynamicObject(896,-3669.8569336,-3361.2399902,13.1379995,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(16120,-3660.7919922,-3345.9350586,-12.3050003,0.0000000,0.0000000,309.9627686); //
		CreateDynamicObject(18751,-3679.8210449,-3355.1369629,-5.8559999,0.0000000,0.0000000,329.9963379); //
		CreateDynamicObject(18751,-3671.3120117,-3317.0869141,-6.7810001,0.0000000,0.0000000,329.9963379); //
		CreateDynamicObject(18751,-3664.0620117,-3306.2170410,-6.7810001,0.0000000,0.0000000,329.9963379); //
		CreateDynamicObject(18751,-3677.6835938,-3300.5244141,-6.7810001,0.0000000,0.0000000,329.9963379); //
		CreateDynamicObject(18751,-3706.1508789,-3344.7749023,-6.5060000,0.0000000,0.0000000,329.9963379); //
		CreateDynamicObject(18751,-3718.3391113,-3344.5510254,-6.4060001,0.0000000,0.0000000,329.9963379); //
		CreateDynamicObject(16112,-3644.4619141,-3325.2509766,-6.0000000,3.2465820,0.0000000,169.9914551); //
		CreateDynamicObject(16112,-3654.2241211,-3298.4499512,-6.0000000,3.2464600,0.0000000,169.9914551); //
		CreateDynamicObject(16112,-3671.9370117,-3283.8549805,-6.0000000,3.2464600,0.0000000,169.9914551); //
		CreateDynamicObject(16112,-3702.9741211,-3281.1311035,-7.9499998,3.2464600,0.0000000,359.9914551); //
		CreateDynamicObject(16112,-3723.0490723,-3291.9799805,-7.9499998,3.2464600,0.0000000,359.9890137); //
		CreateDynamicObject(16112,-3740.4860840,-3306.8811035,-7.9499998,3.2464600,0.0000000,359.9890137); //
		CreateDynamicObject(16112,-4226.4877930,-3223.5520020,0.0000000,3.2464600,0.0000000,359.9890137); //
		CreateDynamicObject(16112,-3643.7119141,-3354.7187500,-6.0000000,3.2464600,0.0000000,169.9914551); //
		CreateDynamicObject(16112,-3716.0449219,-3380.2509766,-6.1250000,3.2464600,0.0000000,19.9841309); //
		CreateDynamicObject(16112,-3749.9108887,-3352.7089844,-6.1250000,3.2464600,0.0000000,19.9896240); //
		CreateDynamicObject(710,-3715.2351074,-3334.7810059,18.7369995,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3710.6330566,-3332.0129395,17.7369995,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3702.6870117,-3329.5180664,12.9870005,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3701.6499023,-3337.4570312,5.4870000,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3702.0649414,-3343.9318848,12.9870005,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3701.7290039,-3321.9719238,12.9870005,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3696.6479492,-3327.0991211,12.9870005,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3695.3911133,-3333.7099609,12.9870005,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3697.2639160,-3340.1779785,12.9870005,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3496.3859863,-3861.5649414,21.7409992,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3697.8269043,-3348.4050293,12.4619999,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3689.1298828,-3347.5429688,12.4619999,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3689.8759766,-3341.5690918,12.4619999,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3688.6240234,-3335.5129395,12.4619999,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3689.8688965,-3329.5600586,12.4619999,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3693.6420898,-3322.9599609,12.4619999,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3698.1440430,-3316.8911133,12.4619999,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3692.0019531,-3314.1369629,12.4619999,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3689.5180664,-3319.7890625,12.4619999,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3685.7338867,-3326.6389160,12.4619999,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3684.8950195,-3316.5969238,12.4619999,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3682.3601074,-3323.4980469,12.4619999,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3683.2700195,-3331.7910156,12.4619999,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3683.7419434,-3338.5649414,12.4619999,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3684.4938965,-3344.6000977,12.4619999,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3678.3720703,-3341.3459473,12.4619999,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3678.5769043,-3336.3510742,12.4619999,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3678.1855469,-3327.5771484,12.4619999,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(767,-3699.9306641,-3333.8662109,-0.4250000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(770,-3693.7141113,-3318.7028809,-0.3000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(623,-3826.5898438,-3032.1679688,6.5450001,0.0000000,0.0000000,59.9908447); //
		CreateDynamicObject(712,-3718.6770020,-3331.4829102,13.7779999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(16112,-3755.4775391,-3328.7265625,-7.9499998,3.2464600,0.0000000,359.9890137); //
		CreateDynamicObject(16120,-4231.7299805,-3200.1311035,0.0000000,0.0000000,0.0000000,269.9890137); //
		CreateDynamicObject(16120,-4243.9189453,-3226.1789551,0.0000000,0.0000000,0.0000000,359.9890137); //
		CreateDynamicObject(19342,-4221.7050781,-3225.3400879,14.0640001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(3798,-4410.0429688,-2564.1630859,0.9450000,0.0000000,0.0000000,339.9993896); //
		CreateDynamicObject(960,-4221.7509766,-3225.3530273,13.1510000,0.0000000,0.0000000,24.9938965); //
		CreateDynamicObject(704,-4317.5039062,-2906.4221191,6.4730000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(16120,-3633.9309082,-2403.0620117,-1.3660001,0.0000000,0.0000000,95.9979248); //
		CreateDynamicObject(16112,-3614.1093750,-2373.0371094,-1.1000000,0.0000000,0.0000000,251.9879150); //
		CreateDynamicObject(16112,-3639.1572266,-2401.5195312,0.1500000,0.0000000,0.0000000,51.9927979); //
		CreateDynamicObject(16120,-3648.0681152,-2401.2800293,-2.2160001,0.0000000,0.0000000,95.9930420); //
		CreateDynamicObject(16120,-3631.9990234,-2374.9189453,-2.2160001,0.0000000,0.0000000,45.9887695); //
		CreateDynamicObject(18751,-4110.7451172,-2665.8828125,0.8000000,1.2414551,0.0000000,105.9576416); //
		CreateDynamicObject(622,-3645.0539551,-2374.4069824,13.8310003,357.9953613,0.0000000,27.9810791); //
		CreateDynamicObject(622,-3645.0537109,-2374.4062500,13.8310003,357.9949951,0.0000000,47.9766846); //
		CreateDynamicObject(16410,-4067.4580078,-3376.2260742,10.1269999,0.0000000,0.0000000,60.0000000); //
		CreateDynamicObject(16410,-4067.3278809,-3378.9450684,11.5019999,6.0000000,0.0000000,355.9963379); //
		CreateDynamicObject(3414,-3952.5380859,-2547.6005859,12.3190002,0.0000000,0.0000000,219.9957275); //
		CreateDynamicObject(16120,-4182.4819336,-3289.1608887,-7.8499999,0.0000000,0.0000000,280.0000000); //
		CreateDynamicObject(746,-4066.7390137,-3375.7470703,9.9410000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(616,-4251.7851562,-3005.2978516,1.4790000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18632,-3952.8249512,-2544.8710938,10.5509996,356.0000000,180.0000000,180.0000000); //
		CreateDynamicObject(14402,-3705.9689941,-3334.4409180,-0.4640000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14402,-3706.3029785,-3331.0209961,-0.0070000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14402,-3705.7749023,-3332.4780273,0.1090000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14402,-3705.6679688,-3334.7800293,0.4170000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14402,-3702.7299805,-3331.6989746,0.4410000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14402,-3698.9140625,-3328.0080566,0.5750000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14402,-3694.9030762,-3345.9790039,0.0170000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14402,-3695.3710938,-3348.9628906,-0.0060000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14402,-3695.4760742,-3351.6188965,-0.1770000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14402,-3693.5019531,-3348.9370117,-0.2290000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14402,-3694.0690918,-3350.9951172,-0.3480000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14402,-3697.1799316,-3346.4099121,0.2250000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(767,-3695.9389648,-3346.9570312,-0.9000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(726,-3846.1899414,-3224.4951172,5.8280001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(653,-3970.4677734,-2658.6367188,10.2030001,0.0000000,0.0000000,219.9902344); //
		CreateDynamicObject(653,-3966.7858887,-2660.5590820,9.4589996,0.0000000,0.0000000,129.9957275); //
		CreateDynamicObject(18751,-3871.9462891,-2778.8808594,0.7940000,0.9942627,0.0000000,39.9847412); //
		CreateDynamicObject(18751,-3766.0009766,-2508.8750000,-4.7100000,0.9942627,0.0000000,39.9847412); //
		CreateDynamicObject(18751,-3802.3066406,-2518.7167969,-4.7100000,0.9887695,0.0000000,39.9847412); //
		CreateDynamicObject(18751,-3780.2490234,-2496.1000977,-4.7100000,0.9942627,0.0000000,39.9847412); //
		CreateDynamicObject(18751,-3758.3630371,-2473.1469727,-4.7100000,0.9942627,0.0000000,39.9847412); //
		CreateDynamicObject(18751,-3738.7189941,-2451.5061035,-4.7100000,0.9942627,0.0000000,39.9847412); //
		CreateDynamicObject(18751,-3735.6950684,-2439.2561035,-4.7100000,0.9942627,0.0000000,339.9847412); //
		CreateDynamicObject(18751,-3636.3457031,-2406.3125000,-4.4299998,0.9832764,0.0000000,319.9822998); //
		CreateDynamicObject(18751,-3622.5371094,-2386.9541016,-4.4299998,0.9832764,0.0000000,349.9822998); //
		CreateDynamicObject(18751,-3619.2719727,-2390.0129395,-4.4299998,0.9777832,0.0000000,59.9804688); //
		CreateDynamicObject(16120,-3637.3955078,-2336.4101562,-2.2160001,0.0000000,0.0000000,335.9838867); //
		CreateDynamicObject(16120,-3591.9719238,-2324.6560059,-2.2160001,0.0000000,0.0000000,295.9838867); //
		CreateDynamicObject(18751,-3605.5710449,-2369.1379395,-4.4299998,0.9722900,0.0000000,59.9798584); //
		CreateDynamicObject(18751,-3584.7399902,-2352.9279785,-4.4299998,0.9722900,0.0000000,29.9798584); //
		CreateDynamicObject(18751,-3606.6171875,-2335.4042969,-4.4299998,0.9722900,0.0000000,269.9725342); //
		CreateDynamicObject(18751,-3631.5209961,-2354.4750977,-3.1550000,0.9722900,0.0000000,339.9725342); //
		CreateDynamicObject(18751,-3594.5800781,-2408.3410645,-7.6300001,0.9777832,0.0000000,349.9804688); //
		CreateDynamicObject(12991,-4259.2080078,-2900.9384766,20.0779991,359.9780273,359.9780273,241.3146973); //
		CreateDynamicObject(3798,-3618.3359375,-2336.4970703,-0.1030000,0.0000000,0.0000000,339.9993896); //
		CreateDynamicObject(960,-4410.1513672,-2564.1855469,3.3299999,0.0000000,0.0000000,24.9938965); //
		CreateDynamicObject(19343,-3618.1411133,-2336.5949707,3.0720000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(855,-3561.5097656,-2320.0791016,23.8859997,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(855,-3562.2570801,-2316.6550293,23.8349991,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(855,-3615.1269531,-2325.1818848,0.5730000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(855,-3600.7150879,-2321.0490723,0.0090000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(856,-3605.6569824,-2324.4289551,1.1780000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(615,-3563.7019043,-2318.3479004,23.7749996,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-3457.8203125,-2147.3544922,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-3657.3979492,-2147.3549805,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-3856.9880371,-2147.3549805,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-4056.5537109,-2147.3544922,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-4256.1220703,-213338.0937500,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-4455.7402344,-2147.3544922,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-3457.8203125,-2345.8535156,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-3457.8203125,-2544.3066406,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-3457.8203125,-2742.7480469,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-3457.8210449,-2941.2309570,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-3457.8210449,-3139.6708984,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-3457.8203125,-3338.0927734,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-3457.8203125,-3536.5820312,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-3457.8203125,-3735.0576172,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-3657.3974609,-2345.8540039,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-3856.9873047,-2345.8540039,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-4056.5537109,-2345.8535156,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-4256.1220703,-2345.8535156,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-4455.7402344,-2345.8535156,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-4455.7402344,-2544.3066406,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-4256.1220703,-2544.3066406,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-4056.5537109,-2544.3066406,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-3856.9873047,-2544.3066406,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-3657.3974609,-2544.3068848,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-3657.3974609,-2742.7480469,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-4056.5537109,-2742.7480469,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-4256.1220703,-2742.7480469,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-4455.7402344,-2742.7480469,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(7916,-3759.1650391,-2682.0119629,-0.1440000,0.0000000,0.0000000,289.9926758); //
		CreateDynamicObject(4241,-3457.8203125,-2941.2304688,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-3657.3974609,-2941.2304688,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-3856.9873047,-2941.2304688,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-4056.5537109,-2941.2304688,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-4256.1220703,-2941.2304688,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-4455.7402344,-2941.2304688,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-3457.8203125,-3139.6708984,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-3657.3974609,-3139.6708984,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-3856.9873047,-3139.6708984,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-4056.5537109,-3139.6708984,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-4256.1220703,-3139.6708984,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-4455.7402344,-3139.6708984,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-3657.3974609,-3338.0927734,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-3856.9873047,-3338.0927734,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-4056.5537109,-3338.0927734,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-4256.1220703,-2147.3544922,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-4455.7402344,-3338.0927734,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-4256.1220703,-3338.0930176,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-3657.3974609,-3536.5820312,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-3856.9873047,-3536.5820312,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-4056.5537109,-3536.5820312,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-4256.1220703,-3536.5820312,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-4455.7402344,-3536.5820312,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-3657.3974609,-3735.0576172,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-3856.9873047,-3735.0576172,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-4056.5537109,-3735.0576172,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-4256.1220703,-3735.0576172,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-4455.7402344,-3735.0576172,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1655,-3718.2309570,-2991.6708984,0.9000000,0.0000000,0.0000000,349.9914551); //
		CreateDynamicObject(1655,-3711.5117188,-2961.1699219,0.9000000,0.0000000,0.0000000,169.9914551); //
		CreateDynamicObject(18752,-3524.2089844,-3105.4306641,-24.5459995,0.0000000,0.0000000,90.0000000); //
		CreateDynamicObject(18751,-3461.9638672,-3076.6582031,1.1690000,0.0000000,0.0000000,17.9901123); //
		CreateDynamicObject(18751,-3480.1552734,-3152.2539062,1.1690000,0.0000000,0.0000000,57.9858398); //
		CreateDynamicObject(18751,-3454.7570801,-3112.2470703,1.1690000,0.0000000,0.0000000,57.9858398); //
		CreateDynamicObject(16197,-3456.9472656,-2835.3437500,-50.1959991,0.0000000,0.0000000,349.9914551); //
		CreateDynamicObject(16120,-3521.6179199,-3052.2871094,-4.7100000,0.0000000,0.0000000,49.9914551); //
		CreateDynamicObject(16120,-3501.7219238,-3036.5048828,-20.1200008,0.0000000,0.0000000,49.9877930); //
		CreateDynamicObject(16120,-3544.6918945,-3045.0581055,-20.1200008,0.0000000,0.0000000,79.9877930); //
		CreateDynamicObject(18229,-3478.5527344,-3121.6728516,8.8640003,0.0000000,0.0000000,349.9969482); //
		CreateDynamicObject(710,-3489.1508789,-3148.8291016,20.2150002,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3491.1708984,-3153.8020020,20.2150002,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3494.7729492,-3156.5109863,20.2150002,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3500.6799316,-3159.2009277,19.4400005,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3507.6140137,-3161.4479980,20.2150002,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3503.5249023,-3165.5219727,20.2150002,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3496.5009766,-3162.2170410,20.0149994,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3486.9890137,-3163.0280762,19.9150009,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3492.1499023,-3167.3779297,20.2150002,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3519.4890137,-3164.8049316,16.3150005,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3514.3400879,-3165.0349121,17.0650005,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3507.6889648,-3169.6840820,17.0650005,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3501.9379883,-3170.6569824,16.0650005,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3498.0500488,-3167.5520020,18.4899998,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3497.8701172,-3174.1940918,18.4899998,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(770,-3456.4880371,-3116.4079590,20.6709995,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(770,-3515.2480469,-3856.4709473,5.0910001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(671,-3481.7958984,-3150.8410645,7.2020001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(624,-3484.0070801,-3165.2360840,3.7850001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(624,-3482.7629395,-3162.1079102,4.4670000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(624,-3486.3378906,-3173.1259766,3.5100000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(624,-3490.3559570,-3177.6000977,0.7850000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(715,-3475.4199219,-3147.6679688,14.6049995,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(730,-3468.1367188,-3152.3369141,6.7170000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(730,-3468.0729980,-3141.2880859,4.9670000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(733,-3486.6132812,-3175.3046875,2.5620000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(733,-3476.6779785,-3157.7370605,6.2449999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(763,-3468.0139160,-3161.6430664,6.9210000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(763,-3473.2280273,-3156.0510254,7.1700001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(767,-3491.1000977,-3056.7329102,2.7230000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(767,-3484.7739258,-3168.7929688,4.3820000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(767,-3475.5559082,-3133.4890137,5.3820000,0.0000000,0.0000000,50.0000000); //
		CreateDynamicObject(771,-3456.5119629,-3129.1950684,4.3030000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(771,-3469.5930176,-3147.6979980,6.5530000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(771,-3486.5048828,-3158.7390137,6.6529999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(755,-3477.8330078,-3157.5520020,7.7490001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(755,-3477.4199219,-3156.1298828,7.4670000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(755,-3476.1330566,-3153.8759766,7.4439998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(755,-3474.3291016,-3146.6740723,6.8979998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(755,-3489.5310059,-3157.3500977,6.8239999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(755,-3495.1579590,-3164.2509766,4.7570000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(755,-3501.0280762,-3163.1411133,4.7340002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(755,-3488.1640625,-3166.9970703,5.1910000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(755,-3475.6479492,-3175.5810547,3.9059999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(755,-3479.3999023,-3160.4580078,6.9530001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(755,-3483.5878906,-3157.4509277,6.8439999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(760,-3476.3039551,-3165.1530762,6.5450001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(760,-3476.4589844,-3165.2150879,6.5209999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(759,-3497.4130859,-3171.8181152,3.6180000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(759,-3490.2929688,-3171.5778809,4.4590001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(759,-3481.0449219,-3153.6340332,7.3330002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(759,-3473.3811035,-3145.5109863,6.7040000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(759,-3481.9829102,-3143.4890137,6.8360000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(759,-3491.7290039,-3147.8449707,4.9730000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(759,-3485.7319336,-3149.6320801,6.7519999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(759,-3467.2849121,-3133.5969238,4.4450002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(759,-3478.7800293,-3131.6679688,6.0730000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(759,-3522.5991211,-3162.0029297,2.1849999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(759,-3479.7141113,-3131.4008789,6.1450000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(759,-3457.3989258,-3135.9379883,4.7480001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(759,-3463.4431152,-3151.9460449,6.9899998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(800,-3480.7309570,-3174.8588867,5.1350002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(800,-3501.9020996,-3138.6359863,13.9169998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(800,-3492.8229980,-3171.5319824,5.1350002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(800,-3450.8750000,-3122.0371094,22.2700005,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(802,-3448.4599609,-3120.8989258,20.6679993,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(802,-3448.0949707,-3117.1569824,21.2500000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(802,-3493.3378906,-3117.3300781,22.9410000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(802,-3518.2590332,-3167.3410645,2.5400000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(802,-3500.3349609,-3176.1030273,2.5620000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(802,-3545.4440918,-3122.6831055,25.6250000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(819,-3477.0849609,-3178.7980957,3.6040001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(819,-3494.9169922,-3165.1818848,5.4310002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(819,-3503.8779297,-3178.9060059,2.5309999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(819,-3508.1530762,-3179.7949219,1.2810000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(819,-3479.1140137,-3165.6469727,4.7110000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(819,-3481.6630859,-3177.3669434,3.0860000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(819,-3467.6669922,-3130.5559082,5.0860000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(823,-3477.2958984,-3150.1760254,9.1339998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(823,-3508.5778809,-3177.4990234,3.8840001,0.0000000,0.0000000,310.0000000); //
		CreateDynamicObject(823,-3519.1740723,-3161.2790527,3.1340001,0.0000000,0.0000000,309.9957275); //
		CreateDynamicObject(823,-3462.1979980,-3128.3850098,6.7090001,0.0000000,0.0000000,309.9957275); //
		CreateDynamicObject(823,-3455.3579102,-3129.2719727,6.7090001,0.0000000,0.0000000,309.9957275); //
		CreateDynamicObject(823,-3450.5048828,-3129.1330566,6.7090001,0.0000000,0.0000000,359.9957275); //
		CreateDynamicObject(823,-3449.4770508,-3126.6320801,6.7090001,0.0000000,0.0000000,359.9945068); //
		CreateDynamicObject(823,-3446.5549316,-3124.4030762,6.7090001,0.0000000,0.0000000,29.9945068); //
		CreateDynamicObject(823,-3444.7770996,-3121.3879395,8.2089996,0.0000000,0.0000000,69.9926758); //
		CreateDynamicObject(823,-3445.6201172,-3116.7119141,8.2089996,0.0000000,0.0000000,89.9884033); //
		CreateDynamicObject(823,-3448.9489746,-3113.5959473,8.2089996,0.0000000,0.0000000,119.9835205); //
		CreateDynamicObject(823,-3446.9360352,-3116.4350586,8.9589996,0.0000000,0.0000000,119.9816895); //
		CreateDynamicObject(823,-3452.7600098,-3112.5590820,8.9589996,0.0000000,0.0000000,169.9816895); //
		CreateDynamicObject(823,-3456.7229004,-3114.2971191,8.2840004,0.0000000,0.0000000,199.9804688); //
		CreateDynamicObject(823,-3454.1369629,-3113.9389648,8.9589996,0.0000000,0.0000000,199.9786377); //
		CreateDynamicObject(823,-3460.4860840,-3118.0380859,8.9589996,0.0000000,0.0000000,219.9786377); //
		CreateDynamicObject(823,-3461.6149902,-3122.2170410,8.4340000,0.0000000,0.0000000,249.9737549); //
		CreateDynamicObject(823,-3459.2500000,-3125.2949219,7.5440001,0.0000000,0.0000000,289.9719238); //
		CreateDynamicObject(823,-3464.8149414,-3117.6569824,7.5440001,0.0000000,0.0000000,289.9676514); //
		CreateDynamicObject(823,-3467.2360840,-3141.9221191,7.0689998,0.0000000,0.0000000,289.9676514); //
		CreateDynamicObject(823,-3466.1159668,-3147.2958984,7.0689998,0.0000000,0.0000000,289.9676514); //
		CreateDynamicObject(823,-3466.3349609,-3150.9160156,7.0689998,0.0000000,0.0000000,289.9676514); //
		CreateDynamicObject(825,-3453.2080078,-3127.9160156,5.8400002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(825,-3452.1350098,-3128.7780762,7.5809999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(825,-3462.7800293,-3154.3911133,9.0579996,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(825,-3462.7460938,-3143.9189453,7.3850002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(825,-3461.2150879,-3147.4069824,7.3850002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(825,-3462.6879883,-3140.1669922,6.6599998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(825,-3470.6630859,-3133.3859863,6.5349998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(825,-3457.8559570,-3132.0148926,6.5349998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(827,-3446.3830566,-3124.0891113,6.9780002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(827,-3473.9250488,-3157.9030762,11.3170004,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(827,-3485.4479980,-3177.4741211,7.2779999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(827,-3489.3291016,-3172.0878906,8.2700005,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(856,-3448.0139160,-3125.7619629,6.6929998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(856,-3439.6569824,-3096.4980469,4.8360000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(856,-3451.8979492,-3125.4179688,21.2779999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(856,-3481.5649414,-3179.9460449,3.8010001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(856,-3481.6770020,-3139.1110840,6.4629998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(856,-3480.5920410,-3134.9140625,6.4219999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(856,-3514.8620605,-3161.8410645,3.5230000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(856,-3525.2780762,-3161.9851074,1.8700000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(856,-3450.6088867,-3113.9851074,8.2969999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(856,-3447.7089844,-3118.3081055,7.6370001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(856,-3490.2041016,-3057.2370605,3.4820001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(856,-3499.5729980,-3138.2390137,13.0749998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(856,-3501.7519531,-3162.5668945,4.6220002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(872,-3462.1088867,-3118.6459961,7.0860000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(872,-3462.1079102,-3118.6459961,7.0860000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(872,-3513.5390625,-3177.2800293,2.1810000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(872,-3449.4819336,-3118.3249512,21.2709999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(872,-3450.1489258,-3115.8100586,21.1539993,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(872,-3543.2709961,-3122.9318848,25.8990002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(872,-3510.2409668,-3160.5991211,4.6030002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(872,-3496.5839844,-3150.6340332,4.4710002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18782,-3532.4780273,-3196.1799316,0.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18782,-3534.1799316,-3198.9680176,0.0000000,0.0000000,0.0000000,32.0000000); //
		CreateDynamicObject(18782,-3533.7309570,-3201.2338867,0.0000000,0.0000000,0.0000000,71.9976807); //
		CreateDynamicObject(18782,-3531.4499512,-3202.8110352,0.0000000,0.0000000,0.0000000,111.9934082); //
		CreateDynamicObject(18782,-3531.8029785,-3201.1459961,0.2250000,0.0000000,0.0000000,171.9891357); //
		CreateDynamicObject(18782,-3529.4819336,-3202.0839844,0.2250000,0.0000000,0.0000000,181.9854736); //
		CreateDynamicObject(18782,-3531.4440918,-3196.7290039,0.2250000,0.0000000,0.0000000,201.9830322); //
		CreateDynamicObject(18782,-3528.4519043,-3200.6789551,0.2250000,0.0000000,0.0000000,201.9781494); //
		CreateDynamicObject(18782,-3528.3430176,-3198.5710449,0.2250000,0.0000000,0.0000000,261.9781494); //
		CreateDynamicObject(825,-3609.3200684,-2335.7480469,3.1670001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(825,-3604.9938965,-2331.0668945,3.1880000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(825,-3618.2409668,-2343.5891113,2.9370000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(825,-3618.2700195,-2329.3200684,2.8060000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(827,-3612.9340820,-2339.1989746,5.4470000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(827,-3616.4980469,-2326.1779785,4.5110002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(827,-3614.5778809,-2340.3920898,5.2880001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(629,-3603.8420410,-2329.2270508,1.0850000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(629,-3616.3610840,-2325.7629395,0.3100000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(629,-3619.8181152,-2336.5859375,1.0599999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(619,-3608.1494141,-2332.4189453,1.1950001,0.0000000,0.0000000,299.9981689); //
		CreateDynamicObject(619,-3618.4628906,-2341.1730957,1.1950001,0.0000000,0.0000000,229.9981689); //
		CreateDynamicObject(16112,-3605.0258789,-2359.1699219,-2.0999999,0.0000000,0.0000000,351.9879150); //
		CreateDynamicObject(3798,-3454.6721191,-3120.8149414,19.5510006,0.0000000,0.0000000,339.9993896); //
		CreateDynamicObject(960,-3454.7880859,-3120.8491211,21.8610001,0.0000000,0.0000000,30.0000000); //
		CreateDynamicObject(19343,-3454.7270508,-3120.8920898,22.7740002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(671,-3453.2080078,-3115.1079102,20.8449993,0.0000000,0.0000000,30.0000000); //
		CreateDynamicObject(770,-3512.5253906,-3168.7011719,2.5950000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(767,-3479.7011719,-3167.5527344,5.3820000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(791,-4362.3032227,-2699.2170410,-11.6789999,0.0000000,0.0000000,28.1195068); //
		CreateDynamicObject(791,-4333.8847656,-2754.8020020,-11.8789997,0.0000000,0.0000000,28.1195068); //
		CreateDynamicObject(791,-4354.1918945,-2751.7160645,-11.8789997,0.0000000,0.0000000,298.1195068); //
		CreateDynamicObject(791,-4365.4370117,-2718.8510742,-11.8789997,0.0000000,0.0000000,298.1195068); //
		CreateDynamicObject(791,-3475.4838867,-3161.3569336,3.0730000,0.0000000,0.0000000,328.1231689); //
		CreateDynamicObject(744,-3468.2500000,-3076.8359375,6.6589999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(744,-3451.5681152,-3082.0649414,6.2839999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(744,-3456.1572266,-3064.5371094,5.5339999,0.0000000,0.0000000,90.0000000); //
		CreateDynamicObject(671,-3456.1469727,-3123.8710938,20.0450001,0.0000000,0.0000000,69.9981689); //
		CreateDynamicObject(3798,-3971.2858887,-3389.5900879,-0.7500000,0.0000000,0.0000000,359.9993896); //
		CreateDynamicObject(960,-3971.2800293,-3389.5810547,1.6350000,0.0000000,0.0000000,320.0000000); //
		CreateDynamicObject(19342,-3971.2280273,-3389.5939941,2.5480001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(3798,-3584.6340332,-2638.7661133,14.6280003,0.0000000,0.0000000,339.9945068); //
		CreateDynamicObject(960,-3584.6130371,-2638.8378906,17.0130005,0.0000000,0.0000000,40.0000000); //
		CreateDynamicObject(19341,-3584.5878906,-2638.7919922,18.1280003,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(16197,-3837.8000488,-2606.3330078,-50.2220001,0.0000000,0.0000000,39.9914551); //
		CreateDynamicObject(710,-3717.2666016,-2474.0156250,28.0699997,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(653,-3440.6369629,-2755.9641113,3.9210000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(653,-3549.4680176,-2446.7580566,25.1380005,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(653,-3651.3969727,-2414.1499023,19.5909996,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(653,-3877.7070312,-2383.9638672,6.4060001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(653,-3858.7580566,-2386.2990723,6.4670000,0.0000000,0.0000000,190.0000000); //
		CreateDynamicObject(3531,-3625.6579590,-2601.9299316,34.2480011,0.0000000,0.0000000,280.0000000); //
		CreateDynamicObject(707,-3860.8610840,-2378.7280273,4.5390000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(789,-3612.9230957,-2774.8649902,51.8040009,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(658,-3555.2849121,-2416.3669434,21.7660007,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(658,-3545.9541016,-2426.9890137,21.7660007,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(658,-3537.4108887,-2455.3620605,19.7660007,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(658,-3966.3291016,-2549.3500977,4.0749998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(658,-3956.9221191,-2541.0681152,4.0749998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(658,-3966.4790039,-2542.4350586,3.8250000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(12957,-3963.6970215,-2549.8120117,10.7469997,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1799,-3953.5778809,-2551.1250000,10.3420000,0.0000000,0.0000000,130.0000000); //
		CreateDynamicObject(2332,-3954.8759766,-2547.6870117,10.9860001,0.0000000,0.0000000,40.0000000); //
		CreateDynamicObject(2827,-3955.9589844,-2550.7338867,10.5959997,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1281,-3951.5539551,-2539.9221191,11.2539997,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1281,-3968.7219238,-2551.1989746,10.8310003,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1281,-3950.2539062,-2535.1450195,11.2130003,0.0000000,0.0000000,40.0000000); //
		CreateDynamicObject(653,-3947.0290527,-2683.5190430,5.0650001,0.0000000,0.0000000,219.9902344); //
		CreateDynamicObject(653,-3964.1640625,-2676.0310059,6.5029998,0.0000000,0.0000000,219.9902344); //
		CreateDynamicObject(653,-3998.4870605,-2728.3559570,4.3309999,0.0000000,0.0000000,219.9902344); //
		CreateDynamicObject(653,-4000.1770020,-2714.1359863,7.2630000,0.0000000,0.0000000,219.9902344); //
		CreateDynamicObject(653,-4017.2160645,-2721.3500977,3.6710000,0.0000000,0.0000000,219.9902344); //
		CreateDynamicObject(653,-3979.5959473,-2721.1879883,6.8769999,0.0000000,0.0000000,251.9902344); //
		CreateDynamicObject(19341,-4410.1860352,-2564.1779785,4.4450002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(19341,-3962.6669922,-2639.3649902,4.7500000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(3798,-3962.7480469,-2639.4335938,1.2500000,0.0000000,0.0000000,339.9993896); //
		CreateDynamicObject(960,-3962.6430664,-2639.4670410,3.6350000,0.0000000,0.0000000,30.0000000); //
		CreateDynamicObject(17026,-3958.5590820,-2646.0810547,-14.6750002,0.0000000,0.0000000,121.9921875); //
		CreateDynamicObject(658,-4257.8520508,-2737.0009766,29.2940006,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(16195,-4120.5029297,-3367.3603516,-24.6149998,0.0000000,0.0000000,349.9804688); //
		CreateDynamicObject(18751,-3587.7041016,-2747.7158203,-2.5810001,0.0000000,0.0000000,337.9888916); //
		CreateDynamicObject(18751,-3584.1730957,-2773.1770020,-2.5810001,0.0000000,0.0000000,307.9888916); //
		CreateDynamicObject(18751,-3554.2370605,-3066.4460449,-4.3309999,0.0000000,0.0000000,17.9901123); //
		CreateDynamicObject(18751,-3542.7749023,-3134.6420898,-4.3309999,0.0000000,0.0000000,57.9901123); //
		CreateDynamicObject(18751,-3555.1950684,-3090.8779297,-3.6760001,0.0000000,0.0000000,87.9858398); //
		CreateDynamicObject(18751,-3549.8940430,-3114.3549805,-4.4260001,0.0000000,0.0000000,57.9858398); //
		CreateDynamicObject(18751,-3490.6779785,-3174.6049805,-5.8309999,0.0000000,0.0000000,57.9858398); //
		CreateDynamicObject(18751,-3463.5300293,-3180.6049805,-5.8309999,0.0000000,0.0000000,57.9858398); //
		CreateDynamicObject(18751,-3459.0830078,-3159.3640137,-8.8310003,0.0000000,0.0000000,57.9858398); //
		CreateDynamicObject(18751,-3433.6440430,-3122.2900391,-8.5559998,0.0000000,0.0000000,57.9858398); //
		CreateDynamicObject(18751,-3436.1159668,-3103.3798828,-8.5559998,0.0000000,0.0000000,57.9858398); //
		CreateDynamicObject(18751,-3452.4489746,-3062.4550781,-8.5559998,0.0000000,0.0000000,27.9858398); //
		CreateDynamicObject(18751,-3433.9230957,-3057.0959473,-8.5559998,0.0000000,0.0000000,27.9821777); //
		CreateDynamicObject(18751,-3456.0700684,-3051.1508789,-8.5559998,0.0000000,0.0000000,27.9821777); //
		CreateDynamicObject(18751,-3478.1779785,-3052.6750488,-8.5559998,0.0000000,0.0000000,27.9821777); //
		CreateDynamicObject(18751,-3518.5510254,-3051.3330078,-8.5559998,0.0000000,0.0000000,27.9821777); //
		CreateDynamicObject(3462,-3627.8850098,-2787.3200684,38.8310013,0.0000000,0.0000000,269.9945068); //
		CreateDynamicObject(16118,-3559.0681152,-3436.4240723,-5.7500000,0.0000000,0.0000000,319.9987793); //
		CreateDynamicObject(16118,-3532.3459473,-3408.4541016,-7.6250000,0.0000000,0.0000000,299.9932861); //
		CreateDynamicObject(16118,-3498.5710449,-3418.7490234,-7.6250000,0.0000000,0.0000000,19.9926758); //
		CreateDynamicObject(16118,-3525.2351074,-3430.9699707,-8.8750000,0.0000000,0.0000000,249.9896240); //
		CreateDynamicObject(16118,-3510.7451172,-3471.2929688,-8.8750000,0.0000000,0.0000000,129.9884033); //
		CreateDynamicObject(16118,-3484.3662109,-3451.7275391,-8.8750000,0.0000000,0.0000000,129.9847412); //
		CreateDynamicObject(16118,-3483.1931152,-3507.3999023,-8.8750000,0.0000000,0.0000000,99.9847412); //
		CreateDynamicObject(16118,-3441.4267578,-3495.8935547,-8.8750000,0.0000000,0.0000000,99.9810791); //
		CreateDynamicObject(16118,-3464.8889160,-3483.7019043,-8.8750000,0.0000000,0.0000000,329.9810791); //
		CreateDynamicObject(16118,-3449.0791016,-3718.2998047,-2.4000001,0.0000000,0.0000000,131.9787598); //
		CreateDynamicObject(16112,-3682.9736328,-3383.7041016,-6.1250000,3.2464600,0.0000000,19.9896240); //
		CreateDynamicObject(16195,-3564.2548828,-3619.8220215,-14.8739996,0.0000000,0.0000000,269.9884033); //
		CreateDynamicObject(16118,-3605.3056641,-3593.8085938,4.5229998,0.0000000,0.0000000,159.9774170); //
		CreateDynamicObject(16120,-3672.8408203,-3294.2275391,-1.0250000,0.0000000,0.0000000,9.9700928); //
		CreateDynamicObject(16112,-3737.6152344,-3374.3857422,-6.1250000,3.2464600,0.0000000,19.9841309); //
		CreateDynamicObject(16118,-3432.5620117,-3690.3479004,-15.6499996,0.0000000,0.0000000,131.9787598); //
		CreateDynamicObject(16118,-3437.4599609,-3711.3181152,-13.1499996,0.0000000,0.0000000,161.9787598); //
		CreateDynamicObject(16112,-3452.1069336,-3722.8740234,-7.0000000,3.2464600,0.0000000,169.9914551); //
		CreateDynamicObject(16112,-3450.5119629,-3709.4919434,-14.2399998,3.2464600,0.0000000,169.9914551); //
		CreateDynamicObject(16112,-3463.9499512,-3712.2739258,-14.2399998,3.2464600,0.0000000,169.9914551); //
		CreateDynamicObject(16112,-3471.5668945,-3717.6250000,-14.2399998,3.2464600,0.0000000,169.9914551); //
		CreateDynamicObject(16112,-3468.2749023,-3724.5109863,-14.2399998,3.2464600,0.0000000,169.9914551); //
		CreateDynamicObject(16112,-3451.1020508,-3734.2490234,-14.2399998,3.2464600,0.0000000,169.9914551); //
		CreateDynamicObject(16118,-3435.9479980,-3710.9440918,1.1000000,0.0000000,0.0000000,131.9787903); //
		CreateDynamicObject(16118,-3402.3046875,-3705.0927734,-5.6500001,0.0000000,0.0000000,61.9738770); //
		CreateDynamicObject(16118,-3466.6650391,-3762.2089844,-7.1500001,0.0000000,0.0000000,341.9714355); //
		CreateDynamicObject(16112,-3453.6179199,-3741.9980469,-7.0000000,3.2464600,0.0000000,169.9914551); //
		CreateDynamicObject(16112,-3434.9008789,-3724.4729004,-7.0000000,3.2464600,0.0000000,169.9914551); //
		CreateDynamicObject(16112,-3412.6159668,-3719.1789551,-7.0000000,3.2464600,0.0000000,169.9914551); //
		CreateDynamicObject(16112,-3387.7451172,-3767.0610352,-10.2500000,3.2464600,0.0000000,169.9914551); //
		CreateDynamicObject(16112,-3384.0039062,-3812.9851074,-10.2500000,3.2464600,0.0000000,99.9914551); //
		CreateDynamicObject(16112,-3408.9863281,-3832.0283203,-10.2500000,3.2464600,0.0000000,99.9810791); //
		CreateDynamicObject(16112,-3395.6621094,-3767.9960938,-10.2500000,3.2464600,0.0000000,39.9847412); //
		CreateDynamicObject(16197,-3580.6589355,-2590.2380371,-18.8080006,0.0000000,0.0000000,349.9914551); //
		CreateDynamicObject(18229,-3574.0249023,-2541.3330078,24.5489998,0.0000000,0.0000000,59.9969482); //
		CreateDynamicObject(18751,-3587.3410645,-2531.4489746,-4.4299998,0.9832764,0.0000000,309.9822998); //
		CreateDynamicObject(18751,-3570.8720703,-2545.3439941,-4.4299998,0.9777832,0.0000000,259.9792480); //
		CreateDynamicObject(653,-3569.9331055,-2322.2470703,23.5000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(653,-3554.7690430,-2566.3740234,1.2470000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(653,-3559.4680176,-2561.1020508,0.7900000,0.0000000,0.0000000,70.0000000); //
		CreateDynamicObject(16120,-3586.9980469,-2540.4318848,3.6340001,0.0000000,0.0000000,105.9960938); //
		CreateDynamicObject(16112,-3576.2370605,-2518.7629395,-5.2249999,0.0000000,0.0000000,171.9927979); //
		CreateDynamicObject(16112,-3589.6210938,-2518.8569336,-5.5999999,0.0000000,0.0000000,251.9909668); //
		CreateDynamicObject(16114,-3575.4240723,-2552.8559570,0.0000000,0.0000000,0.0000000,170.0000000); //
		CreateDynamicObject(18751,-3560.5068359,-2569.5146484,-4.4299998,0.9722900,0.0000000,199.9731445); //
		CreateDynamicObject(16112,-3566.5700684,-2543.9670410,-3.0250001,0.0000000,0.0000000,91.9909668); //
		CreateDynamicObject(791,-3652.5180664,-2805.9890137,34.6389999,0.0000000,0.0000000,328.1231689); //
		CreateDynamicObject(16120,-3638.7324219,-2698.9765625,19.1240005,0.0000000,0.0000000,29.9871826); //
		CreateDynamicObject(18751,-3554.8720703,-2545.1789551,-3.4800000,0.9722900,0.0000000,69.9731445); //
		CreateDynamicObject(899,-3558.0991211,-2522.6259766,0.8290000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(899,-3542.3212891,-2527.8515625,-1.1710000,73.9984131,0.0000000,99.9975586); //
		CreateDynamicObject(899,-3657.5720215,-3023.9670410,0.0330000,73.9984131,0.0000000,149.9975586); //
		CreateDynamicObject(899,-3663.7351074,-3009.8510742,-6.4670000,73.9874268,0.0000000,69.9938965); //
		CreateDynamicObject(899,-3654.8610840,-3013.0959473,0.0330000,14.0000000,180.0000000,219.9938965); //
		CreateDynamicObject(16112,-3845.0830078,-3642.0410156,-15.7600002,3.2464600,0.0000000,339.9841309); //
		CreateDynamicObject(16112,-3711.0458984,-3381.8603516,-4.6250000,3.2464600,0.0000000,339.9829102); //
		CreateDynamicObject(16112,-3609.8630371,-3621.4089355,-3.0000000,3.2464600,0.0000000,69.9774170); //
		CreateDynamicObject(16120,-3926.0517578,-3638.2421875,-3.5000000,0.0000000,0.0000000,209.9816895); //
		CreateDynamicObject(16112,-3810.2819824,-3654.7089844,-15.7600002,3.2464600,0.0000000,159.9829102); //
		CreateDynamicObject(16118,-3473.1962891,-3516.0849609,-8.8750000,0.0000000,0.0000000,159.9774170); //
		CreateDynamicObject(16118,-3594.0471191,-3599.6088867,-8.3970003,0.0000000,0.0000000,159.9774170); //
		CreateDynamicObject(16118,-3607.9399414,-3570.3200684,-2.1170001,0.0000000,0.0000000,259.9774170); //
		CreateDynamicObject(16120,-3652.6469727,-3433.4409180,-1.9000000,0.0000000,0.0000000,249.9676514); //
		CreateDynamicObject(16112,-3662.6621094,-3432.4289551,-1.8290000,3.2464600,0.0000000,339.9829102); //
		CreateDynamicObject(16112,-3641.1188965,-3425.4951172,-1.8290000,3.2464600,0.0000000,239.9829102); //
		CreateDynamicObject(16118,-3612.3898926,-3592.0991211,-4.7270002,0.0000000,0.0000000,159.9774170); //
		CreateDynamicObject(16112,-3662.6621094,-3432.4287109,-1.8290000,3.2464600,0.0000000,339.9829102); //
		CreateDynamicObject(18751,-4374.9360352,-2736.7180176,-3.2000000,1.2414551,0.0000000,199.9511719); //
		CreateDynamicObject(18751,-4424.9970703,-2688.2119141,-5.6999998,1.2414551,0.0000000,139.9511719); //
		CreateDynamicObject(18751,-4438.3730469,-2721.0419922,-5.3000002,1.2414551,0.0000000,89.9493408); //
		CreateDynamicObject(791,-4430.2231445,-2702.2790527,-14.5790005,0.0000000,0.0000000,338.1097412); //
		CreateDynamicObject(791,-4404.1621094,-2725.1159668,-14.5790005,0.0000000,0.0000000,338.1097412); //
		CreateDynamicObject(18751,-4380.3847656,-2701.3588867,-7.1999998,1.2414551,0.0000000,199.9511719); //
		CreateDynamicObject(18751,-4388.6250000,-2680.8249512,-7.1999998,1.2414551,0.0000000,199.9511719); //
		CreateDynamicObject(16207,-3544.3911133,-3623.0869141,-42.4440002,352.1118164,349.8980713,98.5858154); //
		CreateDynamicObject(16112,-3681.3183594,-3440.0693359,-1.8290000,3.2464600,0.0000000,339.9774170); //
		CreateDynamicObject(16112,-3593.5791016,-3593.4318848,-3.0000000,3.2464600,0.0000000,139.9719238); //
		CreateDynamicObject(622,-3596.7639160,-3576.4470215,16.8750000,0.0000000,0.0000000,320.0000000); //
		CreateDynamicObject(622,-3549.0219727,-3848.5720215,2.4000001,27.9985352,0.0000000,239.9975433); //
		CreateDynamicObject(815,-3587.2690430,-3579.7919922,5.2810001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(815,-3581.9479980,-3583.1298828,5.3639998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(815,-3699.8759766,-3330.7480469,0.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(815,-3690.3491211,-3345.8630371,0.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(815,-3692.8010254,-3343.4150391,0.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(815,-4040.9750977,-3107.6110840,6.8490000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(815,-4008.2690430,-3038.4550781,7.5180001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(815,-4152.6040039,-3215.9350586,5.9039998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(815,-4178.1259766,-3195.2399902,6.9200001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(815,-4182.7060547,-3230.7548828,6.7340002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(3361,-3694.5253906,-2598.7646484,36.6980019,0.0000000,0.0000000,15.9960938); //
		CreateDynamicObject(18367,-3474.6379395,-3806.8969727,11.1780005,24.7469482,0.0000000,139.9963379); //
		CreateDynamicObject(18367,-3557.1669922,-2481.1450195,25.1389999,347.7469482,0.0000000,347.9919434); //
		CreateDynamicObject(3276,-3563.2270508,-2503.7871094,34.0060005,356.4062195,341.1632690,254.2293396); //
		CreateDynamicObject(3276,-3560.6799316,-2493.2729492,30.2810001,356.4019775,341.1584473,256.2291260); //
		CreateDynamicObject(3276,-3558.3229980,-2482.5969238,26.5809994,356.3964844,341.1584473,256.4786377); //
		CreateDynamicObject(3276,-3556.5400391,-2482.6520996,26.4559994,356.3964844,161.1584473,256.9758301); //
		CreateDynamicObject(3276,-3558.7719727,-2493.3659668,30.2810001,356.3964844,161.1529541,256.9757080); //
		CreateDynamicObject(3276,-3560.8601074,-2504.1000977,34.0060005,356.3964844,161.1529541,258.4757080); //
		CreateDynamicObject(899,-3549.4670410,-2570.3620605,-5.4460001,0.0000000,180.0000000,179.9975586); //
		CreateDynamicObject(16197,-3469.6660156,-3496.5249023,-21.4829998,0.0000000,0.0000000,349.9914551); //
		CreateDynamicObject(819,-3537.8181152,-3411.5329590,7.3620000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(819,-3568.2500000,-3438.4880371,3.9860001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(822,-3565.9479980,-3439.2570801,1.5930001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(822,-3467.7619629,-3500.1250000,8.5900002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(822,-3498.1379395,-3436.9628906,2.7390001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(16207,-3385.5927734,-3820.8759766,-42.4440002,352.1118164,349.8980713,98.5858154); //
		CreateDynamicObject(16207,-3352.5751953,-3700.3730469,-38.9939995,356.7888184,349.9787598,179.4193726); //
		CreateDynamicObject(4241,-3258.2470703,-3735.0625000,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-3258.2470703,-3536.5820312,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-3258.2470703,-3338.0927734,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-3258.2470703,-3139.6708984,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-3258.2470703,-2742.7480469,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-3258.2470703,-2941.2304688,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-3457.8203125,-2544.3066406,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-3258.2470703,-2544.3066406,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-3457.8203125,-2345.8535156,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-3258.2470703,-2345.8535156,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-3258.2470703,-2147.3544922,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(791,-4270.6328125,-2697.8010254,1.9340000,0.0000000,0.0000000,278.1231689); //
		CreateDynamicObject(18259,-3419.9443359,-3717.1425781,14.4980001,7.9925537,0.0000000,79.9914551); //
		CreateDynamicObject(16118,-3365.5319824,-3742.3789062,-5.6500001,0.0000000,0.0000000,1.9738770); //
		CreateDynamicObject(655,-3420.4335938,-3753.6308594,10.6510000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(655,-3400.0270996,-3740.7009277,10.6510000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(655,-3434.3642578,-3738.1445312,13.6759996,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(655,-3394.7070312,-3762.5339355,9.9010000,24.0000000,0.0000000,90.0000000); //
		CreateDynamicObject(655,-3446.8669434,-3780.5329590,2.9890001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(11495,-3440.0029297,-3809.7480469,0.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(750,-3406.9501953,-3754.9208984,9.9709997,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(867,-3426.9470215,-3740.9589844,13.6110001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(867,-3443.8640137,-3740.5930176,14.3310003,344.0000000,0.0000000,70.0000000); //
		CreateDynamicObject(880,-3448.6816406,-3766.1962891,3.7060001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(880,-3384.0080566,-3756.0009766,8.0990000,0.0000000,0.0000000,60.0000000); //
		CreateDynamicObject(880,-3402.3420410,-3781.0119629,4.0310001,0.0000000,0.0000000,200.0000000); //
		CreateDynamicObject(880,-3404.4541016,-3783.6760254,2.8310001,316.0000000,0.0000000,289.9950562); //
		CreateDynamicObject(897,-3425.0009766,-3743.6159668,9.4080000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(900,-3470.4838867,-3805.5559082,-1.5250000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(906,-3410.7370605,-3720.8999023,11.3360004,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(16112,-3381.0214844,-3766.9619141,-1.9000000,0.0000000,0.0000000,199.9951172); //
		CreateDynamicObject(841,-3417.5439453,-3735.2670898,12.3360004,1.9805298,8.0048218,359.7215271); //
		CreateDynamicObject(836,-3410.9299316,-3742.3159180,11.9180002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(654,-3424.5419922,-3784.2839355,4.6129999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(654,-3452.8583984,-3744.0175781,6.0879998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18688,-3417.3349609,-3735.1840820,10.9670000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18688,-3417.7900391,-3735.3278809,10.9670000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18688,-3417.5090332,-3735.6330566,10.9670000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18751,-3519.7021484,-3874.6445312,0.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18751,-3549.4140625,-3874.5634766,0.6730000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18751,-3519.2851562,-3842.5888672,0.6730000,7.9925537,0.0000000,0.0000000); //
		CreateDynamicObject(11556,-3539.4130859,-3779.8269043,0.5800000,0.0000000,0.0000000,190.0000000); //
		CreateDynamicObject(11556,-3485.9609375,-3804.8574219,7.7049999,329.9963379,0.0000000,259.9969482); //
		CreateDynamicObject(16113,-3579.0205078,-3912.8437500,-3.1830001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(16113,-3498.5410156,-3909.3320312,-2.3829999,13.9965820,0.0000000,69.9993896); //
		CreateDynamicObject(16113,-3524.1425781,-3931.3085938,-5.9330001,0.0000000,0.0000000,109.9951172); //
		CreateDynamicObject(16113,-3492.6359863,-3918.3200684,-5.9330001,0.0000000,0.0000000,249.9950867); //
		CreateDynamicObject(805,-3576.6940918,-3898.0830078,4.0170002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(16112,-3465.3559570,-3794.8439941,-7.4000001,0.0000000,0.0000000,199.9951172); //
		CreateDynamicObject(16112,-3556.0649414,-3822.2719727,-5.6300001,0.0000000,0.0000000,159.9951172); //
		CreateDynamicObject(805,-3451.7290039,-3739.4079590,8.1379995,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18751,-3537.3000488,-3200.1311035,-6.4410000,0.0000000,0.0000000,57.9858398); //
		CreateDynamicObject(622,-3572.5600586,-2552.5991211,19.7099991,29.9910889,0.0000000,89.9761963); //
		CreateDynamicObject(622,-3581.1730957,-2459.4628906,9.8330002,359.9816895,0.0000000,149.9707031); //
		CreateDynamicObject(710,-3588.1398926,-2537.2128906,37.1609993,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(726,-3716.3830566,-2792.5209961,-1.3160000,0.0000000,0.0000000,299.9981689); //
		CreateDynamicObject(726,-3712.8630371,-2800.4560547,-1.3160000,0.0000000,0.0000000,239.9981689); //
		CreateDynamicObject(726,-3865.1455078,-2833.1523438,2.3199999,0.0000000,0.0000000,239.9908447); //
		CreateDynamicObject(726,-3705.3879395,-3315.5339355,-0.6750000,0.0000000,0.0000000,239.9963379); //
		CreateDynamicObject(726,-3869.2421875,-2847.6816406,4.0879998,0.0000000,0.0000000,239.9908447); //
		CreateDynamicObject(726,-3639.0634766,-2969.1220703,7.0679998,0.0000000,0.0000000,239.9963379); //
		CreateDynamicObject(726,-3488.1840820,-3860.3620605,-10.1910000,0.0000000,0.0000000,349.9963379); //
		CreateDynamicObject(10023,-3521.8369141,-3841.9755859,8.0609999,0.0000000,0.0000000,319.9987793); //
		CreateDynamicObject(4241,-3258.2429199,-3933.5659180,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-3457.8203125,-3933.5659180,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-3657.3974609,-3933.5659180,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-3856.9873047,-3933.5659180,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-4056.5537109,-3933.5659180,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-4256.1220703,-3933.5659180,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-4455.7402344,-3933.5654297,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18751,-3501.7810059,-3862.5720215,0.4750000,0.0000000,0.0000000,20.0000000); //
		CreateDynamicObject(16112,-3480.7209473,-3830.7839355,-5.9000001,0.0000000,0.0000000,199.9951172); //
		CreateDynamicObject(750,-3513.4824219,-3836.7490234,6.6370001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(750,-3527.4008789,-3826.2119141,4.4889998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(809,-3506.0869141,-3835.3510742,7.1180000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(810,-3519.3950195,-3828.4750977,5.7449999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(810,-3506.6809082,-3834.6831055,7.1320000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(810,-3517.6708984,-3832.3491211,6.7410002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(812,-3509.4741211,-3836.1960449,9.1929998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(812,-3507.6350098,-3838.1850586,9.1440001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(812,-3525.6210938,-3827.2529297,8.2130003,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(814,-3526.9838867,-3823.5690918,8.3160000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(814,-3507.8679199,-3834.2910156,9.2910004,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(814,-3506.1918945,-3839.9060059,8.7489996,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(814,-3519.2099609,-3829.0119629,19.6520004,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(814,-3519.0991211,-3831.2319336,17.2339993,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(814,-3489.7900391,-3862.2890625,7.9159999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(817,-3507.2028809,-3838.6950684,7.3010001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(817,-3501.5139160,-3848.7399902,5.1370001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(821,-3494.3630371,-3854.2451172,7.4340000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(744,-3542.6599121,-3841.5390625,3.7300000,0.0000000,355.9906006,0.0000000); //
		CreateDynamicObject(905,-3501.6630859,-3848.7250977,5.1370001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(905,-3493.6608887,-3853.4729004,6.5139999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(3920,-3903.1999512,-2419.2871094,7.3039999,7.5025940,20.4326172,169.2120361); //
		CreateDynamicObject(3920,-3498.3530273,-3848.4379883,12.2799997,0.0000000,0.0000000,319.9987793); //
		CreateDynamicObject(806,-3518.2150879,-3831.2700195,10.2229996,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(806,-3502.4741211,-3847.7438965,8.3719997,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(826,-3490.2170410,-3864.0380859,7.9889998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(826,-3492.2370605,-3856.8359375,8.1110001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(726,-3526.5439453,-3871.7260742,4.9910002,0.0000000,0.0000000,239.9963379); //
		CreateDynamicObject(726,-3534.9628906,-3820.2680664,-10.1910000,0.0000000,0.0000000,349.9914551); //
		CreateDynamicObject(8623,-3524.0139160,-3827.7600098,5.9010000,0.0000000,0.0000000,330.0000000); //
		CreateDynamicObject(3920,-3490.5429688,-3854.0820312,16.4860001,0.0000000,0.0000000,320.0000000); //
		CreateDynamicObject(3920,-3495.6040039,-3850.7380371,14.4860001,0.0000000,0.0000000,319.9987793); //
		CreateDynamicObject(3920,-3526.7519531,-3823.6279297,16.5610008,0.0000000,0.0000000,319.9987793); //
		CreateDynamicObject(3920,-3527.1909180,-3824.2019043,13.5609999,0.0000000,0.0000000,319.9987793); //
		CreateDynamicObject(3920,-3528.3210449,-3823.3349609,14.8859997,0.0000000,0.0000000,319.9987793); //
		CreateDynamicObject(639,-3496.9287109,-3848.4316406,15.3850002,0.0000000,0.0000000,229.9987793); //
		CreateDynamicObject(639,-3488.2800293,-3856.5080566,13.0100002,0.0000000,0.0000000,229.9987793); //
		CreateDynamicObject(639,-3506.6608887,-3841.1149902,11.1599998,0.0000000,0.0000000,229.9987793); //
		CreateDynamicObject(639,-3534.0610352,-3818.0849609,12.6599998,0.0000000,0.0000000,229.9987793); //
		CreateDynamicObject(639,-3525.6789551,-3824.8168945,13.9099998,0.0000000,0.0000000,229.9987793); //
		CreateDynamicObject(819,-3521.7099609,-3829.8049316,18.0170002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(819,-3534.7800293,-3816.8999023,15.3170004,359.1318359,277.9531250,213.8103485); //
		CreateDynamicObject(819,-3541.1870117,-3810.7438965,15.3170004,359.1265869,277.9486084,233.8049316); //
		CreateDynamicObject(819,-3494.0349121,-3852.6389160,6.8169999,359.1265869,277.9486084,233.8000488); //
		CreateDynamicObject(18751,-3542.8669434,-3846.7858887,-0.3270000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(750,-3533.1079102,-3862.6599121,5.1589999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(749,-3504.0449219,-3846.7648926,2.7570000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(758,-3505.3979492,-3845.2680664,4.9860001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(905,-3502.4279785,-3848.8410645,4.9770002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(905,-3491.4709473,-3857.4409180,6.4660001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(905,-3491.1420898,-3856.9169922,7.0640001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(905,-3491.7590332,-3856.6030273,6.5120001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(905,-3491.5649414,-3865.2429199,6.6170001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(751,-3548.1818848,-3814.1469727,3.2639999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(801,-3542.6020508,-3815.1530762,6.6110001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(801,-3502.1289062,-3848.3469238,5.1980000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(801,-3506.0200195,-3845.5649414,7.4400001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(823,-3520.6840820,-3830.3269043,5.4749999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(823,-3520.6840820,-3830.3259277,9.9750004,26.0000000,0.0000000,100.0000000); //
		CreateDynamicObject(823,-3510.6159668,-3839.9230957,9.9750004,9.9745789,355.9385071,156.7021484); //
		CreateDynamicObject(823,-3505.3869629,-3846.1721191,5.7249999,9.9700928,355.9350586,156.6979980); //
		CreateDynamicObject(823,-3531.1950684,-3824.0300293,5.7249999,9.9700928,355.9350586,156.6979980); //
		CreateDynamicObject(823,-3539.4860840,-3815.9960938,7.7249999,9.9700928,355.9350586,156.6979980); //
		CreateDynamicObject(827,-3531.3679199,-3821.3688965,9.7620001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(827,-3497.5239258,-3848.8798828,9.0279999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(827,-3509.8320312,-3839.0520020,15.8979998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(827,-3524.0080566,-3828.4040527,7.6479998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(16118,-3562.5939941,-3847.5939941,-2.4000001,0.0000000,0.0000000,341.9787598); //
		CreateDynamicObject(16118,-3513.5019531,-3885.9360352,-1.1500000,0.0000000,0.0000000,291.9769287); //
		CreateDynamicObject(16113,-3550.0349121,-3878.5590820,-3.1830001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(16113,-3553.4589844,-3907.2141113,-3.1830001,0.0000000,0.0000000,100.0000000); //
		CreateDynamicObject(3798,-3524.0239258,-3902.7009277,4.0300002,0.0000000,0.0000000,339.9993896); //
		CreateDynamicObject(960,-3524.1279297,-3902.7199707,6.4150000,0.0000000,0.0000000,30.0000000); //
		CreateDynamicObject(19343,-3524.1320801,-3902.7429199,7.3280001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(16112,-3499.9140625,-3894.9470215,-0.5750000,0.0000000,0.0000000,199.9951172); //
		CreateDynamicObject(751,-3549.8029785,-3815.5170898,3.8889999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(622,-3581.6855469,-3581.2089844,4.4520001,5.9985352,0.0000000,279.9975586); //
		CreateDynamicObject(654,-3531.6469727,-3702.5390625,18.0249996,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(744,-3519.3076172,-3833.6074219,5.3119998,0.0000000,355.9844971,0.0000000); //
		CreateDynamicObject(16118,-3501.0690918,-3853.4489746,-12.3750000,0.0000000,0.0000000,123.9726562); //
		CreateDynamicObject(3462,-3531.3540039,-3844.3129883,6.9380002,0.0000000,0.0000000,229.9945068); //
		CreateDynamicObject(14416,-3536.5629883,-3847.7189941,5.0689998,0.0000000,0.0000000,230.0000000); //
		CreateDynamicObject(14416,-3526.4040527,-3856.0859375,5.0689998,0.0000000,0.0000000,49.9987793); //
		CreateDynamicObject(19366,-3528.8740234,-3853.7460938,8.1899996,0.0000000,90.0000000,230.0000000); //
		CreateDynamicObject(19366,-3531.3159180,-3851.7028809,8.1899996,0.0000000,90.0000000,229.9987793); //
		CreateDynamicObject(19366,-3533.7529297,-3849.6621094,8.1899996,0.0000000,90.0000000,229.9987793); //
		CreateDynamicObject(19366,-3536.0070801,-3852.3378906,8.1899996,0.0000000,90.0000000,229.9987793); //
		CreateDynamicObject(19366,-3533.5659180,-3854.3679199,8.1899996,0.0000000,90.0000000,229.9987793); //
		CreateDynamicObject(19366,-3531.1049805,-3856.4189453,8.1899996,0.0000000,90.0000000,229.9987793); //
		CreateDynamicObject(14416,-3528.2900391,-3858.3930664,5.0689998,0.0000000,0.0000000,49.9987793); //
		CreateDynamicObject(14416,-3531.1621094,-3847.1730957,5.0689998,0.0000000,0.0000000,140.0000000); //
		CreateDynamicObject(14416,-3528.1579590,-3849.6831055,5.0689998,0.0000000,0.0000000,139.9987793); //
		CreateDynamicObject(14416,-3526.8828125,-3850.7490234,5.0689998,0.0000000,0.0000000,139.9987793); //
		CreateDynamicObject(14416,-3538.4599609,-3849.9770508,5.0689998,0.0000000,0.0000000,229.9987793); //
		CreateDynamicObject(19458,-3527.2871094,-3854.5048828,6.3090000,0.0000000,0.0000000,320.0000000); //
		CreateDynamicObject(19458,-3534.4890137,-3847.9990234,6.3340001,0.0000000,0.0000000,319.9987793); //
		CreateDynamicObject(19458,-3537.2949219,-3853.4389648,6.3590002,0.0000000,0.0000000,229.9987793); //
		CreateDynamicObject(19458,-3532.8789062,-3848.2290039,6.3340001,0.0000000,0.0000000,229.9932861); //
		CreateDynamicObject(19458,-3525.7990723,-3853.9680176,6.3090000,0.0000000,0.0000000,229.9932861); //
		CreateDynamicObject(19458,-3530.2250977,-3859.3911133,6.3090000,0.0000000,0.0000000,229.9932861); //
		CreateDynamicObject(3462,-3524.0039062,-3850.6142578,6.9380002,0.0000000,0.0000000,229.9932861); //
		CreateDynamicObject(11489,-4061.1025391,-3373.1582031,9.5410004,0.0000000,0.0000000,145.4919434); //
		CreateDynamicObject(744,-3530.7587891,-3824.9746094,2.8369999,0.0000000,355.9899902,0.0000000); //
		CreateDynamicObject(16118,-3546.5139160,-3857.2351074,-12.3750000,0.0000000,0.0000000,3.9697266); //
		CreateDynamicObject(750,-3491.2802734,-3863.4912109,5.7010002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18688,-3524.0280762,-3850.6669922,7.1890001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18688,-3531.4069824,-3844.4030762,7.0560002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(726,-3428.7587891,-3732.1748047,13.9309998,0.0000000,0.0000000,239.9963379); //
		CreateDynamicObject(726,-3542.1030273,-3832.4509277,5.6409998,0.0000000,0.0000000,239.9963379); //
		CreateDynamicObject(622,-3515.7470703,-3704.3066406,5.8249998,341.9934082,0.0000000,239.9963379); //
		CreateDynamicObject(710,-3708.2812500,-3348.7060547,12.9870005,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3480.1740723,-3851.7739258,18.3750000,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(733,-3569.7500000,-3894.8449707,3.4389999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(733,-3505.9160156,-3862.5991211,5.8880000,0.0000000,0.0000000,340.0000000); //
		CreateDynamicObject(733,-3475.4399414,-3865.0100098,3.8629999,0.0000000,0.0000000,339.9993896); //
		CreateDynamicObject(732,-3532.1289062,-3871.4641113,5.5510001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(732,-3596.6130371,-3561.3999023,5.4270000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(732,-3548.5332031,-3866.4814453,4.5260000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(770,-3499.7900391,-3180.3173828,1.7950000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(770,-3542.8349609,-3867.8989258,6.0869999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(824,-3513.6818848,-3854.3320312,6.7280002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(827,-3517.2910156,-3852.2333984,9.4849997,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(872,-3541.3869629,-3836.8400879,4.7490001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(872,-3530.1140137,-3853.0200195,3.6760001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(813,-3535.3068848,-3840.8869629,7.4860001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(813,-3517.6850586,-3832.6398926,12.6960001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(813,-3522.5910645,-3870.3999023,7.9949999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(819,-3496.5742188,-3842.3212891,5.1939998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(822,-3538.4240723,-3837.6699219,6.0630002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(822,-3511.9660645,-3847.6469727,7.0879998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(823,-3527.4794922,-3828.7431641,8.9600000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(826,-3522.6142578,-3854.2041016,6.3039999,21.9946289,0.0000000,0.0000000); //
		CreateDynamicObject(726,-3529.0249023,-3865.6699219,4.7410002,0.0000000,0.0000000,229.9963379); //
		CreateDynamicObject(770,-3552.3239746,-3858.4060059,4.8620000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(733,-3537.7060547,-3825.6520996,4.2379999,0.0000000,0.0000000,339.9993896); //
		CreateDynamicObject(767,-3528.9699707,-3835.5380859,6.6520000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(767,-3512.6579590,-3849.9418945,6.6520000,0.0000000,0.0000000,140.0000000); //
		CreateDynamicObject(669,-3544.7880859,-3812.0410156,11.1070004,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(710,-3535.5712891,-3876.3037109,20.9909992,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3526.2910156,-3899.9755859,19.7450008,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3482.9951172,-3844.1708984,18.3750000,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(710,-3523.4519043,-3815.1110840,21.1250000,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(865,-3535.3999023,-3851.4809570,8.3909998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(872,-3533.6589355,-3835.7470703,5.9080000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(872,-3523.8879395,-3833.2028809,6.5019999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18367,-3657.2363281,-2703.9472656,44.7659988,23.7469482,0.0000000,329.9963379); //
		CreateDynamicObject(18367,-3474.2351074,-3806.4790039,11.0030003,21.2161560,356.7816467,291.4090271); //
		CreateDynamicObject(880,-3555.8989258,-3822.4660645,7.0520000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(880,-3543.1579590,-3829.0900879,5.8020000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18751,-3518.7421875,-3834.3369141,-2.8269999,7.9925537,0.0000000,0.0000000); //
		CreateDynamicObject(18751,-3543.1899414,-3832.6259766,-2.8269999,7.9980469,0.0000000,340.0000000); //
		CreateDynamicObject(16195,-4337.1372070,-2335.5939941,1.9060000,0.2497559,2.5000305,209.9872437); //
		CreateDynamicObject(791,-4392.8549805,-2466.2958984,-13.3290005,0.0000000,0.0000000,118.1085205); //
		CreateDynamicObject(791,-4341.1259766,-2458.3408203,-13.3290005,0.0000000,0.0000000,118.1085205); //
		CreateDynamicObject(791,-4349.0742188,-2413.6999512,-13.3290005,0.0000000,0.0000000,118.1085205); //
		CreateDynamicObject(791,-4406.3940430,-2438.5800781,-13.3290005,0.0000000,0.0000000,118.1085205); //
		CreateDynamicObject(791,-4430.4399414,-2398.8200684,-13.3290005,0.0000000,0.0000000,118.1085205); //
		CreateDynamicObject(791,-4433.1967773,-2358.0590820,-13.3290005,0.0000000,0.0000000,118.1085205); //
		CreateDynamicObject(18228,-4427.6484375,-2249.7041016,-1.7500000,0.0000000,0.0000000,191.9915771); //
		CreateDynamicObject(18228,-4372.6240234,-2215.4431152,-1.7500000,0.0000000,0.0000000,191.9915771); //
		CreateDynamicObject(18228,-4395.0971680,-2227.8420410,-1.7500000,0.0000000,0.0000000,171.9915771); //
		CreateDynamicObject(18267,-4379.5703125,-2365.2226562,34.8019981,0.0000000,0.0000000,229.9987793); //
		CreateDynamicObject(3077,-4381.9101562,-2360.5019531,34.8800011,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(16112,-4073.2421875,-2626.1914062,-3.7449999,0.0000000,0.0000000,349.9914551); //
		CreateDynamicObject(710,-3848.0629883,-2949.6240234,16.3880005,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(710,-3852.6188965,-2957.2839355,16.3880005,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(710,-3844.7041016,-2955.3769531,16.3880005,0.0000000,0.0000000,320.0000000); //
		CreateDynamicObject(710,-3857.4240723,-2984.8039551,15.6379995,0.0000000,0.0000000,319.9987793); //
		CreateDynamicObject(710,-3846.9060059,-2982.0568848,15.6379995,0.0000000,0.0000000,319.9987793); //
		CreateDynamicObject(710,-3861.5878906,-2983.9108887,15.6379995,0.0000000,0.0000000,319.9987793); //
		CreateDynamicObject(710,-3864.3840332,-2980.6970215,15.6379995,0.0000000,0.0000000,319.9987793); //
		CreateDynamicObject(710,-3863.9499512,-2975.9379883,14.8879995,0.0000000,0.0000000,319.9987793); //
		CreateDynamicObject(710,-3840.5239258,-2976.8139648,14.8879995,0.0000000,0.0000000,319.9987793); //
		CreateDynamicObject(710,-3845.3000488,-2975.1289062,13.6379995,0.0000000,0.0000000,319.9987793); //
		CreateDynamicObject(710,-3853.4179688,-2981.3950195,13.6379995,0.0000000,0.0000000,319.9987793); //
		CreateDynamicObject(710,-3858.5620117,-2978.4140625,13.6379995,0.0000000,0.0000000,319.9987793); //
		CreateDynamicObject(710,-3852.8200684,-2973.9819336,13.6379995,0.0000000,0.0000000,319.9987793); //
		CreateDynamicObject(710,-3860.2390137,-2969.2819824,13.6379995,0.0000000,0.0000000,319.9987793); //
		CreateDynamicObject(710,-3848.9108887,-2967.1730957,13.6379995,0.0000000,0.0000000,319.9987793); //
		CreateDynamicObject(710,-3857.5180664,-2963.3898926,13.6379995,0.0000000,0.0000000,319.9987793); //
		CreateDynamicObject(710,-3867.9729004,-2967.0371094,13.6379995,0.0000000,0.0000000,319.9987793); //
		CreateDynamicObject(710,-3857.6889648,-2967.6440430,19.1189995,0.0000000,0.0000000,319.9987793); //
		CreateDynamicObject(710,-3840.0939941,-2969.0200195,13.6379995,0.0000000,0.0000000,319.9987793); //
		CreateDynamicObject(710,-3835.9770508,-2959.2070312,13.6379995,0.0000000,0.0000000,320.0000000); //
		CreateDynamicObject(710,-3842.2841797,-2962.4960938,13.6379995,0.0000000,0.0000000,319.9932861); //
		CreateDynamicObject(710,-3875.4899902,-2985.2849121,17.3880005,0.0000000,0.0000000,319.9987793); //
		CreateDynamicObject(710,-3871.2910156,-2975.6398926,18.1380005,0.0000000,0.0000000,319.9987793); //
		CreateDynamicObject(710,-3881.1101074,-3001.4179688,19.3880005,0.0000000,0.0000000,319.9987793); //
		CreateDynamicObject(710,-3889.4589844,-3005.4570312,19.3880005,0.0000000,0.0000000,319.9987793); //
		CreateDynamicObject(710,-3883.8649902,-2996.5559082,18.6380005,0.0000000,0.0000000,319.9987793); //
		CreateDynamicObject(648,-3856.7197266,-2843.6923828,-1.8190000,0.0000000,0.0000000,51.9818115); //
		CreateDynamicObject(648,-4012.5280762,-2975.4680176,3.7340000,0.0000000,0.0000000,131.9842529); //
		CreateDynamicObject(710,-3835.9765625,-2959.2070312,13.6379995,0.0000000,0.0000000,319.9987793); //
		CreateDynamicObject(648,-3867.1904297,-2961.7617188,-2.9080000,0.0000000,0.0000000,221.9842529); //
		CreateDynamicObject(9831,-3702.5920410,-2819.8510742,-4.0250001,284.8017578,4.8984375,128.2366943); //
		CreateDynamicObject(2759,-3889.1689453,-2406.1740723,8.9080000,315.7500000,0.0000000,80.0000000); //
		CreateDynamicObject(19085,-3891.9489746,-2405.6950684,7.6520000,2.2414246,5.0038452,341.0537720); //
		CreateDynamicObject(18727,-3904.3750000,-3094.3220215,24.3820000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18727,-3904.9660645,-3099.6669922,24.5370007,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18727,-3906.2390137,-3102.8010254,24.0039997,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18727,-3910.2270508,-3096.8068848,24.0620003,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18727,-3902.8669434,-3094.1340332,25.2310009,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18727,-3905.0300293,-3092.1870117,25.0179996,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18727,-3904.0039062,-3098.1789551,24.7649994,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18727,-3902.6689453,-3096.4780273,24.5450001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18727,-3906.2629395,-3090.4970703,24.1669998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18727,-3909.1149902,-3090.1188965,24.6000004,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18727,-3907.1499023,-3090.0529785,24.0370007,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18727,-3910.4150391,-3091.7260742,25.8689995,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18727,-3909.4599609,-3091.2749023,23.7259998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18727,-3910.8479004,-3093.8049316,24.2180004,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18727,-3911.1931152,-3095.4589844,24.2630005,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18727,-3907.7370605,-3103.4069824,24.7280006,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18727,-3907.4870605,-3102.6469727,23.9200001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18727,-3908.7009277,-3101.8420410,23.8640003,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18727,-3909.4389648,-3099.6918945,23.8299999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18727,-3909.7519531,-3097.8100586,24.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18727,-3904.4130859,-3097.8291016,24.6259995,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18727,-3907.2680664,-3101.6831055,23.1970005,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18727,-3909.2971191,-3098.8820801,22.9340000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18727,-3906.1721191,-3096.0690918,22.7199993,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18727,-3909.6508789,-3085.1650391,41.7719994,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18727,-3907.1398926,-3084.8190918,40.9749985,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18727,-3911.6250000,-3087.0529785,42.8889999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18727,-3907.9641113,-3085.1818848,39.1310005,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18727,-3902.6230469,-3103.4689941,30.4029999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18727,-3900.1721191,-3099.0439453,29.1060009,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18727,-3913.6359863,-3105.3688965,43.2179985,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18727,-3900.9450684,-3105.9919434,43.9589996,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18727,-3896.0090332,-3098.1960449,44.3549995,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18727,-3895.7080078,-3090.5700684,44.3989983,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18727,-3901.2199707,-3084.8630371,44.7430000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18727,-3902.7800293,-3084.1311035,45.4010010,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18727,-3904.8579102,-3099.5029297,24.6119995,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18727,-3903.6069336,-3100.2990723,25.7089996,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18727,-3901.9560547,-3098.2670898,26.0259991,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18727,-3906.1789551,-3095.7280273,22.6359997,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(16120,-3615.6818848,-2923.3239746,-4.1250000,0.0000000,0.0000000,19.9914551); //
		CreateDynamicObject(16112,-3605.9780273,-2933.0209961,-5.0339999,13.9965820,0.0000000,169.9914551); //
		CreateDynamicObject(648,-3846.2370605,-2829.5590820,-14.8940001,0.0000000,0.0000000,71.9818115); //
		CreateDynamicObject(710,-3856.3820801,-2833.4829102,15.4820004,0.0000000,0.0000000,319.9932861); //
		CreateDynamicObject(710,-3848.5590820,-2838.1340332,15.4820004,0.0000000,0.0000000,319.9932861); //
		CreateDynamicObject(710,-3853.7519531,-2829.9880371,15.4820004,0.0000000,0.0000000,319.9932861); //
		CreateDynamicObject(710,-3839.7170410,-2832.6579590,15.4820004,0.0000000,0.0000000,319.9932861); //
		CreateDynamicObject(710,-3836.3898926,-2838.8630371,14.4820004,0.0000000,0.0000000,319.9932861); //
		CreateDynamicObject(825,-3842.9130859,-2835.2299805,1.0060000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(825,-3846.0849609,-2836.7949219,1.0060000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(825,-3846.8588867,-2833.6279297,1.3310000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(825,-3843.2219238,-2833.8049316,1.8060000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(825,-3845.0959473,-2831.3391113,1.9310000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(825,-3849.3879395,-2832.6411133,1.9310000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(825,-3850.9980469,-2835.0859375,1.0810000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(825,-3853.6650391,-2833.1831055,1.0810000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(825,-3851.9370117,-2831.7250977,1.6560000,0.0000000,0.0000000,40.0000000); //
		CreateDynamicObject(825,-3851.9365234,-2831.7246094,1.6560000,0.0000000,0.0000000,39.9957275); //
		CreateDynamicObject(825,-3844.8359375,-2842.8000488,1.3810000,0.0000000,0.0000000,39.9957275); //
		CreateDynamicObject(825,-3842.3701172,-2838.1931152,0.9560000,0.0000000,0.0000000,39.9957275); //
		CreateDynamicObject(825,-3841.5319824,-2835.5419922,1.4310000,0.0000000,0.0000000,39.9957275); //
		CreateDynamicObject(825,-3838.8349609,-2838.4140625,1.4310000,0.0000000,0.0000000,39.9957275); //
		CreateDynamicObject(825,-3835.9221191,-2840.5449219,1.4310000,0.0000000,0.0000000,39.9957275); //
		CreateDynamicObject(825,-3834.7990723,-2845.4851074,1.4310000,0.0000000,0.0000000,39.9957275); //
		CreateDynamicObject(825,-3839.0229492,-2843.1450195,0.6810000,0.0000000,0.0000000,39.9957275); //
		CreateDynamicObject(825,-4259.9018555,-2817.7290039,3.9449999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(825,-4267.1782227,-2817.2500000,3.9449999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(825,-4266.1152344,-2822.8010254,3.9449999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(825,-4263.7368164,-2813.0878906,3.9449999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(825,-4269.8759766,-2811.0659180,3.9449999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(825,-4272.8540039,-2811.0891113,3.9449999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(825,-4276.2988281,-2810.4870605,4.4699998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(825,-4272.1240234,-2806.9008789,4.8200002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(825,-4269.7670898,-2801.6369629,3.8699999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(825,-4266.0830078,-2807.2700195,3.8699999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(825,-4259.9311523,-2804.2919922,5.3200002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(825,-4263.4057617,-2799.8500977,4.3699999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(825,-4269.2539062,-2796.6379395,4.0200000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(825,-4264.9780273,-2791.6250000,3.6450000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(825,-4260.6279297,-2793.7849121,4.1450000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(825,-4259.3618164,-2788.9208984,4.1450000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(825,-4266.8017578,-2786.9929199,3.6199999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(825,-4257.6020508,-2795.4450684,5.4699998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(825,-4260.2612305,-2798.4230957,5.4699998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(824,-4254.6738281,-2796.8339844,6.0419998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(824,-4257.3969727,-2800.4279785,6.2110000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(824,-4252.7900391,-2789.9609375,7.7199998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(824,-4266.1748047,-2802.2229004,5.5359998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(824,-4273.8232422,-2801.2060547,5.5359998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(889,-4270.1992188,-2791.0119629,3.3000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(889,-4269.8740234,-2787.1508789,3.6500001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(688,-4320.1879883,-2893.1579590,5.1729999,0.0000000,0.0000000,2.0000000); //
		CreateDynamicObject(791,-4309.0961914,-2839.1931152,-33.2260017,0.0000000,0.0000000,298.1195068); //
		CreateDynamicObject(809,-4276.9560547,-2808.3210449,4.6430001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(809,-4276.0019531,-2804.2170410,4.6090002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(809,-4271.1782227,-2787.2290039,3.8020000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(809,-4262.7797852,-2786.2109375,3.8829999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18694,-3516.8220215,-3825.9479980,9.0469999,88.7500916,180.0000000,180.0000000); //
		CreateDynamicObject(750,-3507.7670898,-3835.3798828,5.7119999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(750,-3516.5620117,-3827.7690430,5.3119998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18694,-3507.6621094,-3833.6159668,9.0469999,88.7475586,179.9945068,179.9945068); //
		CreateDynamicObject(812,-3516.7412109,-3829.5556641,8.3290005,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(812,-3518.7749023,-3827.1879883,7.7270002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(812,-3515.2705078,-3826.4716797,7.7529998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(744,-3516.7290039,-3828.0830078,2.0120001,0.0000000,355.9844971,0.0000000); //
		CreateDynamicObject(18751,-3538.1101074,-3199.5190430,-6.1059999,0.0000000,0.0000000,57.9858398); //
		CreateDynamicObject(18751,-3528.3540039,-3194.7939453,-6.1059999,0.0000000,0.0000000,247.9858398); //
		CreateDynamicObject(18751,-3526.9250488,-3205.2900391,-6.1059999,0.0000000,0.0000000,167.9833984); //
		CreateDynamicObject(18751,-3519.6818848,-3193.9140625,-6.1059999,0.0000000,0.0000000,167.9809570); //
		CreateDynamicObject(18751,-3522.8789062,-3194.0620117,-6.1059999,0.0000000,0.0000000,167.9809570); //
		CreateDynamicObject(18751,-3525.0800781,-3190.3300781,-6.1059999,0.0000000,0.0000000,147.9809570); //
		CreateDynamicObject(18751,-3528.8469238,-3189.1359863,-6.1059999,0.0000000,0.0000000,127.9803467); //
		CreateDynamicObject(18751,-3528.8469238,-3189.1359863,-5.9809999,0.0000000,0.0000000,127.9797363); //
		CreateDynamicObject(18751,-3520.4528809,-3185.9370117,-5.5060000,356.0000000,0.0000000,137.9797363); //
		CreateDynamicObject(730,-3671.9279785,-2801.2319336,37.1430016,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(3052,-4377.5029297,-2361.3911133,35.0060005,0.0000000,0.0000000,170.0000000); //
		CreateDynamicObject(3052,-4376.7988281,-2361.8920898,35.0060005,0.0000000,0.0000000,139.9969482); //
		CreateDynamicObject(3052,-4376.1079102,-2362.3491211,35.0060005,0.0000000,0.0000000,139.9932861); //
		CreateDynamicObject(3052,-4376.5361328,-2362.6899414,35.0060005,0.0000000,0.0000000,129.9932861); //
		CreateDynamicObject(3052,-4376.5659180,-2362.2780762,35.2560005,0.0000000,0.0000000,139.9932861); //
		CreateDynamicObject(2912,-4375.6391602,-2363.4279785,34.8800011,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2029,-4378.3911133,-2365.7060547,34.8800011,0.0000000,0.0000000,320.0000000); //
		CreateDynamicObject(3017,-4378.2900391,-2366.0830078,35.7029991,0.0000000,0.0000000,320.0000000); //
		CreateDynamicObject(2894,-4378.2778320,-2365.6669922,35.6809998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1255,-4365.1489258,-2376.4299316,34.4399986,0.0000000,0.0000000,320.0000000); //
		CreateDynamicObject(1255,-4366.2402344,-2378.1369629,34.4399986,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(17030,-4331.7568359,-2774.5219727,-10.0139999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18267,-4154.3876953,-2403.4882812,6.5019999,0.0000000,0.0000000,90.0000000); //
		CreateDynamicObject(18228,-4167.5278320,-2420.1298828,-4.0000000,0.0000000,0.0000000,151.9915771); //
		CreateDynamicObject(18228,-4145.9091797,-2411.7773438,-13.7500000,0.0000000,0.0000000,211.9866943); //
		CreateDynamicObject(18228,-4160.9731445,-2403.4528809,-16.2500000,0.0000000,0.0000000,31.9866943); //
		CreateDynamicObject(18228,-4144.4282227,-2407.1369629,-14.4499998,0.0000000,0.0000000,251.9866943); //
		CreateDynamicObject(18228,-4144.8930664,-2399.2810059,-13.3249998,0.0000000,0.0000000,191.9824219); //
		CreateDynamicObject(18228,-4171.4858398,-2404.1730957,-4.0000000,0.0000000,0.0000000,251.9903564); //
		CreateDynamicObject(18228,-4164.5219727,-2402.2438965,-15.7500000,0.0000000,0.0000000,241.9879150); //
		CreateDynamicObject(18228,-4166.3452148,-2393.4890137,-15.7500000,0.0000000,0.0000000,161.9848633); //
		CreateDynamicObject(18228,-4162.7568359,-2393.4650879,-15.5000000,0.0000000,0.0000000,161.9824219); //
		CreateDynamicObject(18228,-4156.7231445,-2392.8300781,-16.5750008,0.0000000,0.0000000,161.9824219); //
		CreateDynamicObject(18228,-4153.3769531,-2399.3339844,-16.5750008,0.0000000,0.0000000,161.9824219); //
		CreateDynamicObject(18228,-4158.4418945,-2400.7329102,-16.5750008,0.0000000,0.0000000,161.9824219); //
		CreateDynamicObject(18228,-4157.6547852,-2410.5690918,-13.6590004,0.0000000,0.0000000,8.0000000); //
		CreateDynamicObject(18228,-4152.7050781,-2396.7770996,-16.2840004,0.0000000,0.0000000,237.9980469); //
		CreateDynamicObject(905,-4151.2641602,-2408.8249512,4.9190001,343.6428223,262.3823547,62.9035339); //
		CreateDynamicObject(905,-4150.4667969,-2408.7419434,4.9190001,343.6413574,262.3809814,82.9022217); //
		CreateDynamicObject(671,-3849.0400391,-2978.8229980,5.0139999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(703,-4274.4458008,-2795.9799805,4.5289998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(896,-4010.6015625,-3197.5322266,12.5710001,333.1274414,41.2152100,109.5391846); //
		CreateDynamicObject(896,-3982.0581055,-3191.8400879,5.2410002,333.1274414,41.2152100,109.5392151); //
		CreateDynamicObject(896,-3992.8820801,-3221.7370605,5.2410002,342.9954224,72.8014221,131.3149109); //
		CreateDynamicObject(896,-3989.9499512,-3210.6770020,5.2410002,0.8119812,91.8277893,111.8916016); //
		CreateDynamicObject(2357,-3962.8999023,-3206.2839355,10.0150003,0.0000000,0.0000000,270.0000000); //
		CreateDynamicObject(2636,-3961.9230957,-3205.0148926,10.3000002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2636,-3961.8898926,-3206.1799316,10.3000002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2636,-3962.0419922,-3207.2309570,10.3000002,0.0000000,0.0000000,320.0000000); //
		CreateDynamicObject(1739,-3962.8769531,-3203.6940918,10.6090002,0.0000000,0.0000000,90.0000000); //
		CreateDynamicObject(2636,-3963.6940918,-3204.8920898,10.2939997,0.0000000,0.0000000,180.0000000); //
		CreateDynamicObject(2636,-3963.7490234,-3206.0991211,10.2939997,0.0000000,0.0000000,179.9945068); //
		CreateDynamicObject(2636,-3963.9409180,-3207.1240234,9.8690004,85.7500610,0.0000000,218.9945984); //
		CreateDynamicObject(2850,-3962.9938965,-3206.5791016,10.4250002,0.0000000,0.0000000,310.0000000); //
		CreateDynamicObject(2851,-3963.0139160,-3204.8410645,10.4250002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2869,-3959.6298828,-3209.7280273,10.7189999,0.0000000,0.0000000,53.7500000); //
		CreateDynamicObject(18693,-3959.6799316,-3210.0820312,10.3330002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18693,-3959.6899414,-3209.3588867,10.3330002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(759,-4024.9399414,-3160.3029785,7.0330000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(759,-4025.6159668,-3159.7749023,6.9480000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(759,-4024.8120117,-3161.9990234,7.1799998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(759,-4018.7780762,-3164.4069824,9.1800003,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(759,-4020.1699219,-3164.5300293,8.6090002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(759,-4019.0991211,-3159.2519531,14.1379995,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(759,-4020.3720703,-3159.7409668,13.2360001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(759,-4019.2241211,-3160.2519531,13.0850000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(761,-4036.0300293,-3160.7500000,7.2570000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(761,-4030.5629883,-3165.3530273,7.0070000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(761,-4030.4221191,-3166.6079102,7.1160002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(761,-4029.3010254,-3165.6770020,6.5409999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(761,-4029.4838867,-3164.0339355,6.5409999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(761,-4029.3068848,-3167.5920410,6.5409999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(761,-4024.0559082,-3163.4150391,6.9410000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(761,-4028.4450684,-3168.8168945,6.9410000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(761,-4028.6740723,-3167.3759766,6.9410000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(761,-4032.3449707,-3164.4880371,6.9410000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(761,-4030.8349609,-3164.0358887,6.9410000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(761,-4032.6740723,-3163.2199707,6.9410000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(761,-4032.6738281,-3163.2197266,6.9410000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(761,-4034.2548828,-3162.5590820,6.9410000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(761,-4035.0490723,-3161.0090332,6.6160002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(761,-4033.7370605,-3161.7561035,6.0910001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(761,-4032.2971191,-3162.7199707,6.0910001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(761,-4030.6770020,-3162.9970703,6.0910001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(761,-4027.4641113,-3169.5610352,6.4660001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(761,-4026.6188965,-3171.1918945,6.7160001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(761,-4023.4990234,-3171.8100586,6.5660000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(801,-4016.8979492,-3165.7670898,9.0330000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(801,-4018.2819824,-3174.2939453,6.4590001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(801,-4033.6989746,-3160.3720703,6.9740000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(804,-4020.6130371,-3165.1279297,8.0920000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(804,-4021.3449707,-3164.8549805,9.1750002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(821,-4024.9379883,-3171.6120605,6.6459999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(825,-4020.2780762,-3160.2500000,12.7500000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(820,-3525.3439941,-3853.7858887,5.0720000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(818,-4009.1931152,-3174.1030273,7.0279999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(821,-4012.8449707,-3167.4990234,9.2709999,2.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(821,-4016.7280273,-3174.2758789,10.7959995,1.9995117,0.0000000,0.0000000); //
		CreateDynamicObject(821,-4025.4799805,-3174.2661133,8.6709995,1.9995117,0.0000000,0.0000000); //
		CreateDynamicObject(821,-4026.9289551,-3174.5920410,10.3459997,1.9995117,0.0000000,0.0000000); //
		CreateDynamicObject(821,-4030.2119141,-3171.6850586,10.3459997,1.9995117,0.0000000,0.0000000); //
		CreateDynamicObject(821,-4026.4870605,-3170.1298828,13.3210001,1.9995117,0.0000000,0.0000000); //
		CreateDynamicObject(821,-4032.2438965,-3168.7150879,13.3210001,1.9995117,0.0000000,0.0000000); //
		CreateDynamicObject(821,-4031.9929199,-3167.7009277,9.6459999,1.9995117,0.0000000,0.0000000); //
		CreateDynamicObject(821,-4028.0869141,-3161.8420410,5.6710000,1.9995117,0.0000000,0.0000000); //
		CreateDynamicObject(821,-4026.5419922,-3163.2370605,5.6710000,1.9995117,0.0000000,0.0000000); //
		CreateDynamicObject(821,-4028.0739746,-3166.1579590,5.8460002,1.9995117,0.0000000,0.0000000); //
		CreateDynamicObject(821,-4023.0449219,-3164.8540039,6.0209999,1.9995117,0.0000000,0.0000000); //
		CreateDynamicObject(821,-4020.6240234,-3163.5668945,6.7459998,1.9995117,0.0000000,0.0000000); //
		CreateDynamicObject(821,-4013.1230469,-3170.8798828,10.6709995,2.0000000,180.0000000,180.0000000); //
		CreateDynamicObject(3512,-3958.1999512,-3216.4970703,8.6029997,0.0000000,0.0000000,270.0000000); //
		CreateDynamicObject(3512,-3971.9750977,-3198.6879883,7.4320002,0.0000000,0.0000000,270.0000000); //
		CreateDynamicObject(3512,-3962.5939941,-3202.0270996,9.6140003,0.0000000,0.0000000,270.0000000); //
		CreateDynamicObject(19439,-3974.4040527,-3203.3588867,34.0359993,0.0000000,90.0000000,0.0000000); //
		CreateDynamicObject(19439,-3974.0280762,-3204.9609375,34.0359993,0.0000000,90.0000000,0.0000000); //
		CreateDynamicObject(19439,-3970.6010742,-3204.9809570,34.0359993,0.0000000,90.0000000,0.0000000); //
		CreateDynamicObject(19439,-3970.5380859,-3206.5458984,34.0359993,0.0000000,90.0000000,0.0000000); //
		CreateDynamicObject(19439,-3974.0371094,-3206.5510254,34.0359993,0.0000000,90.0000000,0.0000000); //
		CreateDynamicObject(19439,-3977.7128906,-3207.7810059,31.3360004,0.0000000,90.0000000,0.0000000); //
		CreateDynamicObject(19439,-3974.2197266,-3207.7705078,31.3360004,0.0000000,90.0000000,0.0000000); //
		CreateDynamicObject(19439,-3971.0458984,-3207.7451172,32.0110016,0.0000000,66.0000000,0.0000000); //
		CreateDynamicObject(19439,-3970.4340820,-3209.8049316,28.8859997,0.0000000,90.0000000,0.0000000); //
		CreateDynamicObject(19439,-3973.9277344,-3209.8095703,28.8859997,0.0000000,90.0000000,0.0000000); //
		CreateDynamicObject(19439,-3977.3950195,-3209.8029785,28.8859997,0.0000000,90.0000000,0.0000000); //
		CreateDynamicObject(19439,-3980.8510742,-3209.8068848,28.8859997,0.0000000,90.0000000,0.0000000); //
		CreateDynamicObject(19439,-3984.3249512,-3209.8000488,28.8859997,0.0000000,90.0000000,0.0000000); //
		CreateDynamicObject(19439,-3987.8000488,-3209.7949219,28.8859997,0.0000000,90.0000000,0.0000000); //
		CreateDynamicObject(19439,-3986.5568848,-3191.0649414,12.8710003,0.0000000,90.0000000,90.0000000); //
		CreateDynamicObject(19439,-3989.7971191,-3191.0480957,13.6709995,90.0000000,0.0000000,180.0000000); //
		CreateDynamicObject(19439,-3991.3229980,-3190.3640137,16.2259998,0.0000000,90.0000000,50.0000000); //
		CreateDynamicObject(19439,-3989.0742188,-3191.0615234,14.4209995,0.0000000,90.0000000,90.0000000); //
		CreateDynamicObject(19439,-3989.7971191,-3191.0480957,12.0959997,90.0000000,0.0000000,179.9945068); //
		CreateDynamicObject(19439,-3989.7971191,-3191.0480957,10.4960003,90.0000000,0.0000000,179.9945068); //
		CreateDynamicObject(19439,-3989.0219727,-3192.7719727,12.6960001,0.0000000,0.0000000,89.9945068); //
		CreateDynamicObject(19439,-3989.0219727,-3192.7719727,9.2209997,0.0000000,0.0000000,89.9945068); //
		CreateDynamicObject(19439,-3987.4499512,-3192.7749023,9.2209997,0.0000000,0.0000000,89.9945068); //
		CreateDynamicObject(19439,-3988.1459961,-3192.7680664,12.7209997,0.0000000,0.0000000,89.9945068); //
		CreateDynamicObject(19439,-3986.5258789,-3192.7639160,11.0459995,0.0000000,0.0000000,89.9945068); //
		CreateDynamicObject(19439,-3985.8081055,-3192.0539551,11.0459995,0.0000000,0.0000000,179.9945068); //
		CreateDynamicObject(19439,-3987.4130859,-3192.0568848,12.7209997,0.0000000,0.0000000,179.9945068); //
		CreateDynamicObject(19439,-3987.4130859,-3190.4750977,12.7209997,0.0000000,0.0000000,179.9945068); //
		CreateDynamicObject(19439,-3988.1992188,-3191.0966797,14.4209995,0.0000000,90.0000000,90.0000000); //
		CreateDynamicObject(19439,-3985.8081055,-3190.4790039,11.0459995,0.0000000,0.0000000,179.9945068); //
		CreateDynamicObject(19439,-3993.5109863,-3192.9790039,16.2259998,0.0000000,90.0000000,49.9987793); //
		CreateDynamicObject(19439,-3993.3430176,-3194.1220703,16.2259998,0.0000000,90.0000000,319.9987793); //
		CreateDynamicObject(19439,-3994.3579102,-3195.3181152,16.2259998,0.0000000,90.0000000,319.9932861); //
		CreateDynamicObject(19439,-3995.3579102,-3196.5100098,16.2259998,0.0000000,90.0000000,319.9932861); //
		CreateDynamicObject(19439,-3994.6379395,-3199.1320801,16.2259998,0.0000000,90.0000000,89.9932861); //
		CreateDynamicObject(19439,-3994.6311035,-3202.5600586,16.2259998,0.0000000,90.0000000,89.9890137); //
		CreateDynamicObject(19439,-3994.6359863,-3206.0300293,16.2259998,0.0000000,90.0000000,89.9890137); //
		CreateDynamicObject(19439,-3994.6459961,-3209.4699707,16.2259998,0.0000000,90.0000000,89.9890137); //
		CreateDynamicObject(19439,-3996.1860352,-3198.1311035,16.2259998,0.0000000,90.0000000,89.9890137); //
		CreateDynamicObject(19439,-3997.7338867,-3198.0891113,16.2259998,0.0000000,90.0000000,89.9890137); //
		CreateDynamicObject(19439,-3999.2739258,-3198.3479004,16.2259998,0.0000000,90.0000000,89.9890137); //
		CreateDynamicObject(19439,-3996.1909180,-3201.5258789,16.2259998,0.0000000,90.0000000,89.9890137); //
		CreateDynamicObject(19439,-3997.7490234,-3201.5139160,16.2259998,0.0000000,90.0000000,89.9890137); //
		CreateDynamicObject(19439,-3996.1721191,-3204.9790039,16.2259998,0.0000000,90.0000000,89.9890137); //
		CreateDynamicObject(19439,-3997.8059082,-3205.0229492,16.2259998,0.0000000,90.0000000,89.9890137); //
		CreateDynamicObject(19439,-3992.0778809,-3204.7500000,18.8010006,0.0000000,90.0000000,89.9890137); //
		CreateDynamicObject(19439,-3992.0769043,-3201.3249512,18.8010006,0.0000000,90.0000000,89.9890137); //
		CreateDynamicObject(19439,-3992.0590820,-3198.1130371,18.8010006,0.0000000,90.0000000,89.9890137); //
		CreateDynamicObject(19439,-3992.0690918,-3194.6970215,18.8010006,0.0000000,90.0000000,89.9890137); //
		CreateDynamicObject(19439,-3992.0791016,-3191.2561035,18.8010006,0.0000000,90.0000000,89.9890137); //
		CreateDynamicObject(19439,-3992.0749512,-3187.8879395,18.8010006,0.0000000,90.0000000,89.9890137); //
		CreateDynamicObject(896,-4003.8239746,-3198.9829102,18.5709991,296.2792969,98.0584717,114.9114990); //
		CreateDynamicObject(19439,-3993.6220703,-3188.2661133,18.8010006,0.0000000,90.0000000,89.9890137); //
		CreateDynamicObject(19439,-3995.1469727,-3187.4130859,18.8010006,0.0000000,90.0000000,89.9890137); //
		CreateDynamicObject(19439,-3995.9790039,-3185.3369141,18.8010006,0.0000000,90.0000000,89.9890137); //
		CreateDynamicObject(19439,-3993.6010742,-3191.7360840,18.8010006,0.0000000,90.0000000,89.9890137); //
		CreateDynamicObject(19439,-3993.5720215,-3194.4279785,18.8010006,0.0000000,90.0000000,89.9890137); //
		CreateDynamicObject(19439,-3992.3310547,-3192.8969727,16.2259998,0.0000000,90.0000000,319.9932861); //
		CreateDynamicObject(19439,-3991.0170898,-3193.2380371,20.3010006,0.0000000,90.0000000,189.9890137); //
		CreateDynamicObject(19439,-3987.6010742,-3192.6359863,20.3010006,0.0000000,90.0000000,189.9865723); //
		CreateDynamicObject(19439,-3984.2858887,-3192.0529785,20.3010006,0.0000000,90.0000000,189.9865723); //
		CreateDynamicObject(19439,-3983.0319824,-3194.2561035,20.3010006,0.0000000,90.0000000,279.9865723); //
		CreateDynamicObject(19439,-3981.4770508,-3193.9809570,20.3010006,0.0000000,90.0000000,279.9865723); //
		CreateDynamicObject(19439,-3979.9550781,-3193.7019043,20.3010006,0.0000000,90.0000000,279.9865723); //
		CreateDynamicObject(19439,-3968.4804688,-3223.0068359,22.9249992,0.0000000,90.0000000,29.9816895); //
		CreateDynamicObject(19439,-3978.9970703,-3190.0480957,20.3010006,0.0000000,90.0000000,279.9865723); //
		CreateDynamicObject(19439,-3984.8081055,-3193.0700684,20.3010006,0.0000000,90.0000000,279.9865723); //
		CreateDynamicObject(19439,-3986.3669434,-3193.3229980,20.3010006,0.0000000,90.0000000,279.9865723); //
		CreateDynamicObject(19439,-3978.4013672,-3193.4511719,20.3010006,0.0000000,90.0000000,279.9865723); //
		CreateDynamicObject(19439,-3965.5078125,-3221.9218750,22.9249992,0.0000000,90.0000000,9.9865723); //
		CreateDynamicObject(19439,-3965.1831055,-3223.3789062,22.9249992,0.0000000,90.0000000,9.9865723); //
		CreateDynamicObject(19439,-3965.2324219,-3219.4130859,25.1749992,0.0000000,90.0000000,9.9865723); //
		CreateDynamicObject(19439,-3968.6787109,-3220.0117188,25.1749992,0.0000000,90.0000000,9.9865723); //
		CreateDynamicObject(16120,-4002.8540039,-3263.8679199,-13.3009996,0.0000000,0.0000000,289.9829102); //
		CreateDynamicObject(16195,-4002.8349609,-2356.7661133,-1.4140000,0.0000000,0.0000000,80.0000000); //
		CreateDynamicObject(16118,-3907.2041016,-2856.0732422,10.1020002,0.0000000,0.0000000,319.9877930); //
		CreateDynamicObject(16118,-4104.1137695,-2244.3710938,13.4499998,0.0000000,0.0000000,349.9877930); //
		CreateDynamicObject(16118,-4097.0131836,-2230.0539551,-3.1800001,0.0000000,0.0000000,329.9859619); //
		CreateDynamicObject(16118,-4105.6010742,-2229.6069336,-3.1800001,0.0000000,0.0000000,329.9853516); //
		CreateDynamicObject(16118,-4113.2158203,-2228.0839844,-3.1800001,0.0000000,0.0000000,329.9853516); //
		CreateDynamicObject(16118,-4119.3759766,-2236.1699219,-3.1800001,0.0000000,0.0000000,319.9853516); //
		CreateDynamicObject(16118,-4133.7939453,-2253.7167969,-2.7300000,0.0000000,0.0000000,319.9822998); //
		CreateDynamicObject(16118,-4110.4501953,-2265.4404297,-2.7300000,0.0000000,0.0000000,179.9780273); //
		CreateDynamicObject(900,-4116.7646484,-2257.8789062,12.0760002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(900,-4115.1738281,-2251.2451172,-2.1240001,350.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(900,-4106.9750977,-2259.9650879,-2.1240001,349.9969482,0.0000000,0.0000000); //
		CreateDynamicObject(900,-4125.2998047,-2262.4409180,-2.1489999,349.9969482,0.0000000,190.0000000); //
		CreateDynamicObject(900,-4116.5878906,-2267.5390625,-2.1489999,349.9914551,0.0000000,189.9975586); //
		CreateDynamicObject(758,-4109.7299805,-2238.1369629,14.3020000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(758,-4111.1162109,-2240.2700195,14.3020000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(758,-4111.7949219,-2237.0959473,14.3020000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(758,-4113.0200195,-2239.0490723,14.1770000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(900,-4117.2011719,-2254.0449219,12.0760002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(9831,-4092.6950684,-2252.0949707,-4.9749999,279.5000610,0.0000000,159.9951172); //
		CreateDynamicObject(9831,-4089.3278809,-2253.4189453,-4.9749999,279.4976807,0.0000000,159.9938965); //
		CreateDynamicObject(9831,-4086.0300293,-2254.6210938,-4.9749999,279.4976807,0.0000000,159.9938965); //
		CreateDynamicObject(9831,-4083.0139160,-2255.8898926,-4.9749999,279.4976807,0.0000000,159.9938965); //
		CreateDynamicObject(9831,-4080.3120117,-2257.0200195,-4.9749999,279.4976807,0.0000000,159.9938965); //
		CreateDynamicObject(9831,-4077.3920898,-2258.2661133,-4.9749999,279.4976807,0.0000000,159.9938965); //
		CreateDynamicObject(9831,-4074.3879395,-2259.3620605,-4.9749999,279.4976807,0.0000000,159.9938965); //
		CreateDynamicObject(9831,-4071.2089844,-2260.6650391,-4.9749999,279.4976807,0.0000000,159.9938965); //
		CreateDynamicObject(9831,-4068.1989746,-2261.8859863,-4.9749999,279.4976807,0.0000000,159.9938965); //
		CreateDynamicObject(9831,-4064.9360352,-2263.2509766,-4.9749999,279.4976807,0.0000000,159.9938965); //
		CreateDynamicObject(9831,-4061.9741211,-2264.4370117,-4.9749999,279.4976807,0.0000000,159.9938965); //
		CreateDynamicObject(9831,-4059.3569336,-2265.4719238,-4.9749999,279.4976807,0.0000000,159.9938965); //
		CreateDynamicObject(9831,-4056.5290527,-2266.6440430,-4.9749999,279.4976807,0.0000000,159.9938965); //
		CreateDynamicObject(9831,-4054.0329590,-2267.5339355,-4.9749999,279.4976807,0.0000000,159.9938965); //
		CreateDynamicObject(9831,-4051.0729980,-2268.8291016,-4.9749999,279.4976807,0.0000000,159.9938965); //
		CreateDynamicObject(9831,-4045.5039062,-2271.1479492,-4.9749999,279.4976807,0.0000000,159.9938965); //
		CreateDynamicObject(9831,-4042.9899902,-2272.0859375,-4.9749999,279.4976807,0.0000000,159.9938965); //
		CreateDynamicObject(9831,-4039.7429199,-2273.5659180,-4.9749999,279.4976807,0.0000000,159.9938965); //
		CreateDynamicObject(9831,-4037.2810059,-2274.2890625,-4.9749999,279.4976807,0.0000000,159.9938965); //
		CreateDynamicObject(9831,-4034.2780762,-2275.5800781,-4.9749999,279.4976807,0.0000000,159.9938965); //
		CreateDynamicObject(9831,-4048.5681152,-2269.9741211,-4.9749999,279.4976807,0.0000000,159.9938965); //
		CreateDynamicObject(9831,-4094.9331055,-2253.7290039,-4.9749999,279.4976807,0.0000000,339.9938965); //
		CreateDynamicObject(9831,-4090.3330078,-2255.4628906,-4.9749999,279.4976807,0.0000000,339.9884033); //
		CreateDynamicObject(9831,-4088.3320312,-2256.2580566,-4.9749999,279.4976807,0.0000000,339.9884033); //
		CreateDynamicObject(9831,-4085.7390137,-2257.4560547,-4.9749999,279.4976807,0.0000000,339.9884033); //
		CreateDynamicObject(9831,-4083.2490234,-2258.6809082,-4.9749999,279.4976807,0.0000000,340.2384033); //
		CreateDynamicObject(9831,-4079.7080078,-2260.0891113,-4.9749999,279.4976807,0.0000000,340.2355957); //
		CreateDynamicObject(9831,-4077.7060547,-2261.2280273,-4.9749999,279.4976807,0.0000000,340.2355957); //
		CreateDynamicObject(9831,-4074.7849121,-2262.4470215,-4.9749999,279.4976807,0.0000000,340.2355957); //
		CreateDynamicObject(9831,-4072.6689453,-2263.6459961,-4.9749999,279.4976807,0.0000000,340.2355957); //
		CreateDynamicObject(9831,-4069.7070312,-2264.9799805,-4.9749999,279.4976807,0.0000000,340.2355957); //
		CreateDynamicObject(9831,-4066.8229980,-2266.0258789,-4.9749999,279.4976807,0.0000000,340.2355957); //
		CreateDynamicObject(9831,-4064.7119141,-2266.9208984,-4.9749999,279.4976807,0.0000000,340.2355957); //
		CreateDynamicObject(9831,-4061.8320312,-2268.1608887,-4.9749999,279.4976807,0.0000000,340.2355957); //
		CreateDynamicObject(9831,-4058.7500000,-2269.2939453,-4.9749999,279.4976807,0.0000000,340.2355957); //
		CreateDynamicObject(9831,-4056.4870605,-2270.1730957,-4.9749999,279.4976807,0.0000000,340.2355957); //
		CreateDynamicObject(9831,-4053.6110840,-2271.4409180,-4.9749999,279.4976807,0.0000000,340.2355957); //
		CreateDynamicObject(9831,-4050.8950195,-2272.6289062,-4.9749999,279.4976807,0.0000000,340.2355957); //
		CreateDynamicObject(9831,-4047.7919922,-2273.7661133,-4.9749999,279.4976807,0.0000000,340.2355957); //
		CreateDynamicObject(9831,-4045.5480957,-2274.9399414,-4.9749999,279.4976807,0.0000000,340.2355957); //
		CreateDynamicObject(9831,-4042.4008789,-2276.0161133,-4.9749999,279.4976807,0.0000000,340.2355957); //
		CreateDynamicObject(9831,-4039.4570312,-2277.3139648,-4.9749999,279.4976807,0.0000000,340.2355957); //
		CreateDynamicObject(9831,-4036.7028809,-2278.7810059,-4.9749999,279.4976807,0.0000000,340.2355957); //
		CreateDynamicObject(9831,-4034.3239746,-2279.8168945,-4.9749999,279.4976807,0.0000000,340.2355957); //
		CreateDynamicObject(9831,-4031.3020020,-2281.4489746,-4.9749999,279.4976807,0.0000000,340.2355957); //
		CreateDynamicObject(1742,-4372.8159180,-2371.5520020,34.8129997,0.0000000,0.0000000,230.0000000); //
		CreateDynamicObject(1744,-4378.0019531,-2360.2199707,36.2799988,0.0000000,0.0000000,320.0000000); //
		CreateDynamicObject(1669,-4378.5219727,-2360.2351074,36.7869987,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1664,-4378.4448242,-2360.2680664,36.7869987,0.0000000,0.0000000,300.0000000); //
		CreateDynamicObject(1543,-4378.3388672,-2360.4108887,36.6209984,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1512,-4378.2060547,-2360.5039062,36.8180008,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2868,-4375.5991211,-2363.4279785,35.5929985,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18693,-4375.5981445,-2363.4150391,34.5009995,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2870,-4377.8359375,-2360.6689453,36.6209984,0.0000000,0.0000000,300.0000000); //
		CreateDynamicObject(2908,-4377.5732422,-2360.9951172,36.7480011,271.9999390,180.0000000,230.0000000); //
		CreateDynamicObject(2350,-4377.4340820,-2365.3439941,35.2519989,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(19439,-3972.1110840,-3220.6201172,25.1749992,0.0000000,90.0000000,9.9865723); //
		CreateDynamicObject(880,-3975.0329590,-3221.3300781,25.7500000,47.6525879,276.6218262,81.0732422); //
		CreateDynamicObject(19439,-3964.0549316,-3217.9689941,25.1749992,0.0000000,90.0000000,49.9865723); //
		CreateDynamicObject(19439,-3961.8220215,-3215.3049316,25.1749992,0.0000000,90.0000000,49.9822998); //
		CreateDynamicObject(19439,-3959.9541016,-3213.0849609,25.1749992,0.0000000,90.0000000,49.9822998); //
		CreateDynamicObject(19439,-3964.8911133,-3215.1931152,25.1749992,0.0000000,90.0000000,139.9822998); //
		CreateDynamicObject(19439,-3967.5239258,-3213.0039062,25.1749992,0.0000000,90.0000000,139.9768066); //
		CreateDynamicObject(19439,-3969.8911133,-3214.3029785,25.1749992,0.0000000,90.0000000,229.9768066); //
		CreateDynamicObject(19439,-3972.0839844,-3216.9099121,25.1749992,0.0000000,90.0000000,229.9713135); //
		CreateDynamicObject(19439,-3974.3330078,-3219.5910645,25.1749992,0.0000000,90.0000000,229.9713135); //
		CreateDynamicObject(19439,-3968.0500488,-3208.4960938,29.8360004,0.0000000,90.0000000,0.0000000); //
		CreateDynamicObject(19439,-3971.5471191,-3208.4750977,29.8360004,0.0000000,90.0000000,0.0000000); //
		CreateDynamicObject(19439,-3975.0119629,-3208.4689941,29.8360004,0.0000000,90.0000000,0.0000000); //
		CreateDynamicObject(19439,-3978.4980469,-3208.4670410,29.8360004,0.0000000,90.0000000,0.0000000); //
		CreateDynamicObject(19439,-3981.9790039,-3208.4689941,29.8360004,0.0000000,90.0000000,0.0000000); //
		CreateDynamicObject(19439,-3975.8601074,-3207.7949219,32.9109993,0.0000000,90.0000000,0.0000000); //
		CreateDynamicObject(880,-3976.7971191,-3217.7438965,25.7500000,47.6477051,276.6192627,81.0681152); //
		CreateDynamicObject(900,-3980.2255859,-2588.1816406,20.2479992,0.0000000,0.0000000,29.9926758); //
		CreateDynamicObject(19366,-3973.4423828,-3210.8583984,26.5760002,0.0000000,90.0000000,0.0000000); //
		CreateDynamicObject(18228,-4242.3520508,-2563.2629395,-2.2500000,0.0000000,0.0000000,101.9744873); //
		CreateDynamicObject(18228,-4210.5488281,-2576.0930176,-2.2500000,0.0000000,0.0000000,141.9696045); //
		CreateDynamicObject(18228,-4169.3720703,-2576.7319336,-2.2500000,0.0000000,0.0000000,341.9653320); //
		CreateDynamicObject(18228,-4259.3652344,-2544.6132812,-2.2500000,0.0000000,0.0000000,241.9683838); //
		CreateDynamicObject(791,-4259.9560547,-2543.9479980,-13.9289999,0.0000000,0.0000000,28.1140137); //
		CreateDynamicObject(18228,-4243.6347656,-2537.9814453,-2.2500000,0.0000000,0.0000000,211.9647217); //
		CreateDynamicObject(18228,-4219.6372070,-2511.4169922,-2.2500000,0.0000000,0.0000000,141.9647217); //
		CreateDynamicObject(18228,-4189.4902344,-2498.0605469,-2.2500000,0.0000000,0.0000000,201.9561768); //
		CreateDynamicObject(18228,-4196.7680664,-2417.0749512,-2.2500000,0.0000000,0.0000000,301.9561768); //
		CreateDynamicObject(18228,-4139.6757812,-2567.3125000,-2.2500000,0.0000000,0.0000000,341.9549561); //
		CreateDynamicObject(18228,-4233.6811523,-2540.9899902,-2.2500000,0.0000000,0.0000000,61.9598389); //
		CreateDynamicObject(18228,-4211.6782227,-2523.1818848,-2.2500000,0.0000000,0.0000000,31.9573975); //
		CreateDynamicObject(791,-4230.7060547,-2532.2109375,-13.9289999,0.0000000,0.0000000,28.1140137); //
		CreateDynamicObject(791,-4221.7031250,-2556.4870605,-13.9289999,0.0000000,0.0000000,28.1140137); //
		CreateDynamicObject(18228,-4055.6379395,-2562.5200195,-2.2500000,0.0000000,0.0000000,251.9604492); //
		CreateDynamicObject(18228,-4040.1201172,-2554.7810059,-2.2500000,0.0000000,0.0000000,251.9604492); //
		CreateDynamicObject(18228,-4029.7829590,-2542.8601074,-2.2500000,0.0000000,0.0000000,111.9604492); //
		CreateDynamicObject(18228,-4078.1210938,-2518.4824219,-2.2500000,0.0000000,0.0000000,71.9549561); //
		CreateDynamicObject(18228,-4047.2619629,-2533.4331055,-2.2500000,0.0000000,0.0000000,291.9549561); //
		CreateDynamicObject(18228,-4065.5869141,-2609.1831055,-2.2500000,0.0000000,0.0000000,211.9506836); //
		CreateDynamicObject(18228,-4090.6320801,-2617.8540039,-2.2500000,0.0000000,0.0000000,181.9482422); //
		CreateDynamicObject(18228,-4120.9038086,-2625.1950684,-2.2500000,0.0000000,0.0000000,161.9445801); //
		CreateDynamicObject(18228,-4154.8017578,-2637.8359375,-2.2500000,0.0000000,0.0000000,161.9439697); //
		CreateDynamicObject(791,-4197.7329102,-2494.7119141,-13.9289999,0.0000000,0.0000000,28.1140137); //
		CreateDynamicObject(18228,-4318.3168945,-2534.3999023,-2.2500000,0.0000000,0.0000000,51.9696045); //
		CreateDynamicObject(18228,-4156.3242188,-2478.8569336,-2.2500000,0.0000000,0.0000000,151.9561768); //
		CreateDynamicObject(18228,-4227.3999023,-2410.7241211,-2.2500000,0.0000000,0.0000000,1.9537354); //
		CreateDynamicObject(791,-4317.9458008,-2531.2858887,-16.4389992,0.0000000,0.0000000,28.1140137); //
		CreateDynamicObject(18228,-4113.8110352,-2466.6989746,-2.2500000,0.0000000,0.0000000,171.9519043); //
		CreateDynamicObject(18228,-4082.1240234,-2446.0722656,-2.2500000,0.0000000,0.0000000,201.9451904); //
		CreateDynamicObject(18228,-4095.2319336,-2516.2028809,-18.3099995,0.0000000,0.0000000,151.9464111); //
		CreateDynamicObject(814,-4192.5400391,-2523.8649902,4.9180002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(814,-4141.1127930,-2518.4650879,3.4059999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(814,-4112.6879883,-2525.7910156,4.0209999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(814,-4091.1799316,-2550.0859375,0.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(814,-4092.5270996,-2550.4890137,0.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(814,-4091.4299316,-2551.5690918,0.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(814,-4091.3808594,-2553.4248047,0.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(846,-4185.1250000,-2547.7170410,0.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(846,-4173.1381836,-2550.5358887,0.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(846,-4175.7109375,-2551.8398438,0.0000000,0.0000000,0.0000000,29.9981689); //
		CreateDynamicObject(846,-4175.1430664,-2551.4628906,0.0000000,0.0000000,0.0000000,119.9981689); //
		CreateDynamicObject(846,-4169.3671875,-2549.1589355,0.0000000,0.0000000,0.0000000,209.9926758); //
		CreateDynamicObject(846,-4170.1958008,-2556.6750488,0.0000000,0.0000000,0.0000000,139.9871826); //
		CreateDynamicObject(846,-4177.2460938,-2557.2141113,0.0000000,0.0000000,0.0000000,49.9822998); //
		CreateDynamicObject(846,-4180.5571289,-2549.9829102,0.0000000,0.0000000,0.0000000,359.9822998); //
		CreateDynamicObject(846,-4176.4511719,-2545.2629395,0.0000000,0.0000000,0.0000000,275.9774170); //
		CreateDynamicObject(846,-4186.2368164,-2552.6149902,0.0000000,0.0000000,0.0000000,255.9765625); //
		CreateDynamicObject(846,-4188.5439453,-2549.4060059,0.0000000,0.0000000,0.0000000,245.9759521); //
		CreateDynamicObject(846,-4192.8593750,-2545.7333984,0.0000000,0.0000000,0.0000000,285.9686279); //
		CreateDynamicObject(846,-4195.5258789,-2550.5349121,0.0000000,0.0000000,0.0000000,285.9686279); //
		CreateDynamicObject(846,-4195.4692383,-2553.7839355,0.0000000,0.0000000,0.0000000,275.9686279); //
		CreateDynamicObject(846,-4189.4208984,-2556.4221191,0.0000000,0.0000000,0.0000000,305.9655762); //
		CreateDynamicObject(846,-4201.0439453,-2549.6350098,0.0000000,0.0000000,0.0000000,305.9637451); //
		CreateDynamicObject(846,-4198.4038086,-2557.5891113,0.0000000,0.0000000,0.0000000,305.9637451); //
		CreateDynamicObject(846,-4184.1450195,-2557.8249512,0.0000000,0.0000000,0.0000000,305.9637451); //
		CreateDynamicObject(846,-4182.1137695,-2559.5371094,0.0000000,0.0000000,0.0000000,325.9637451); //
		CreateDynamicObject(846,-4180.5468750,-2563.2590332,0.0000000,0.0000000,0.0000000,345.9588623); //
		CreateDynamicObject(14400,-4194.4101562,-2552.4318848,0.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14400,-4192.0478516,-2555.2351074,0.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14400,-4193.9667969,-2548.0090332,0.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14400,-4186.9189453,-2551.0019531,0.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14400,-4182.8701172,-2551.5690918,0.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14400,-4177.7480469,-2554.3940430,0.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14400,-4178.1152344,-2551.5749512,0.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14400,-4179.6699219,-2549.0439453,0.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14400,-4178.0742188,-2546.7070312,0.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14400,-4175.1538086,-2549.9570312,0.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14400,-4174.3178711,-2546.6879883,0.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14400,-4171.8618164,-2546.6540527,0.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14400,-4170.0468750,-2550.3640137,0.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14400,-4169.9179688,-2552.4660645,0.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14400,-4171.2797852,-2555.3789062,0.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14400,-4174.1499023,-2557.5209961,0.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14400,-4174.2958984,-2552.8068848,0.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14400,-4175.1020508,-2555.1679688,0.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14400,-4182.9941406,-2554.7028809,0.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14400,-4181.7641602,-2556.3869629,1.3250000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14400,-4180.5498047,-2557.5458984,1.3250000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14400,-4184.6372070,-2559.7800293,0.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14400,-4181.2578125,-2561.5258789,0.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14400,-4188.7519531,-2558.8090820,0.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14400,-4196.0009766,-2557.0878906,0.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14400,-4185.2841797,-2560.9479980,0.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14400,-4186.2871094,-2563.4919434,0.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14400,-4182.9819336,-2564.6708984,0.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14400,-3892.9499512,-2417.3588867,11.7690001,0.0000000,340.0000000,0.0000000); //
		CreateDynamicObject(14400,-4177.2622070,-2570.2150879,0.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14400,-4201.7299805,-2557.9890137,0.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14400,-4206.1489258,-2550.0258789,0.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14400,-4208.4238281,-2550.3110352,0.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14400,-4210.4838867,-2552.7460938,0.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14400,-4219.7871094,-2565.3291016,6.2630000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14400,-4216.2231445,-2562.0009766,4.7900000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14400,-4208.2280273,-2532.1450195,8.4639997,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14400,-4105.7348633,-2524.6970215,0.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14400,-4105.7011719,-2523.0358887,0.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14400,-4137.8720703,-2489.1840820,0.1710000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14400,-4262.5258789,-2797.9040527,5.2040000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14400,-4258.2778320,-2795.7309570,6.1900001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14400,-4255.5898438,-2799.5668945,6.7230000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14400,-4261.0229492,-2817.7490234,3.6680000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14400,-4264.0258789,-2813.6799316,4.3950000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14400,-4258.8969727,-2810.7758789,4.8480000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14400,-4261.6269531,-2811.8359375,4.5840001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14400,-4255.0898438,-2803.5000000,6.1849999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14400,-4250.2290039,-2844.2670898,6.9180002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14400,-4252.8950195,-2844.1589355,6.5790000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14400,-4252.0122070,-2843.0410156,6.6659999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14400,-4258.8452148,-2750.9250488,6.9080000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14400,-4263.7612305,-2751.2590332,9.4610004,64.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14400,-4263.0478516,-2751.1210938,10.0340004,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14400,-4262.4829102,-2751.2128906,8.5030003,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14400,-4263.7612305,-2751.2590332,11.9610004,63.9953613,0.0000000,0.0000000); //
		CreateDynamicObject(14400,-4261.4741211,-2751.5390625,6.4610000,63.9953613,0.0000000,0.0000000); //
		CreateDynamicObject(14400,-4266.9379883,-2751.1169434,6.4610000,63.9953613,0.0000000,0.0000000); //
		CreateDynamicObject(14400,-4265.1728516,-2751.1960449,7.9610000,63.9953613,0.0000000,0.0000000); //
		CreateDynamicObject(14400,-4265.1728516,-2751.1950684,13.4610004,63.9953613,0.0000000,0.0000000); //
		CreateDynamicObject(14400,-4270.9902344,-2750.7561035,7.7110000,63.9953613,0.0000000,0.0000000); //
		CreateDynamicObject(14400,-4268.6879883,-2750.6818848,9.7110004,63.9953613,0.0000000,0.0000000); //
		CreateDynamicObject(14400,-4265.5429688,-2751.5310059,10.7110004,63.9953613,0.0000000,0.0000000); //
		CreateDynamicObject(855,-3837.4819336,-2363.8979492,6.2960000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(855,-3897.1130371,-2409.7141113,6.8649998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(855,-3928.3999023,-2410.8139648,3.2430000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(855,-4188.0981445,-2547.8740234,0.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(855,-4171.6230469,-2547.2629395,0.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(855,-4110.0112305,-2526.0749512,1.9880000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(855,-4071.6311035,-2550.7609863,6.6059999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(855,-4057.0749512,-2581.0480957,3.4200001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(855,-4068.1010742,-2582.9619141,0.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(855,-4070.6960449,-2583.3310547,0.5290000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(855,-4304.6191406,-2800.4069824,6.3670001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(855,-4295.0429688,-2823.1569824,5.8290000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(855,-4267.6479492,-2809.7309570,4.1269999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(855,-4275.9160156,-2812.0668945,4.4140000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(825,-4276.8837891,-2815.6962891,6.0640001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(825,-4182.5048828,-2547.0610352,0.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(825,-4188.8217773,-2553.6940918,0.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(825,-4177.5249023,-2571.7250977,2.1880000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(825,-4061.4318848,-2550.6708984,9.5939999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(825,-4056.4519043,-2570.4460449,7.2950001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(825,-4108.5659180,-2618.5759277,9.5150003,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(825,-4137.4931641,-2624.4628906,6.2030001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(825,-4156.6518555,-2580.6630859,7.4730000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(703,-4128.2402344,-2570.3391113,5.0780001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(703,-4196.9462891,-2571.0312500,6.4029999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(703,-4138.8242188,-2554.8000488,0.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(823,-4139.8969727,-2416.5090332,4.3779998,359.2474365,357.9949951,359.9670410); //
		CreateDynamicObject(823,-4177.1230469,-2562.3579102,0.0000000,359.2474365,357.9949951,359.9670410); //
		CreateDynamicObject(823,-4167.6049805,-2567.8349609,0.0000000,359.2474365,357.9949951,359.9670410); //
		CreateDynamicObject(823,-4191.8759766,-2551.3869629,0.0000000,359.2474365,357.9949951,359.9670410); //
		CreateDynamicObject(823,-4210.7167969,-2558.0258789,0.0000000,359.2474365,357.9949951,359.9670410); //
		CreateDynamicObject(823,-4210.0458984,-2538.4499512,10.6029997,359.2474365,357.9949951,359.9670410); //
		CreateDynamicObject(823,-4210.7978516,-2534.1130371,10.9519997,359.2474365,357.9949951,359.9670410); //
		CreateDynamicObject(823,-4216.6840820,-2533.7639160,9.9499998,359.2474365,357.9949951,359.9670410); //
		CreateDynamicObject(823,-4211.1958008,-2538.1721191,10.5209999,359.2474365,357.9949951,359.9670410); //
		CreateDynamicObject(823,-4141.6308594,-2558.2280273,0.0000000,359.2474365,357.9949951,359.9670410); //
		CreateDynamicObject(823,-4145.8427734,-2560.9069824,0.0000000,359.2474365,357.9949951,359.9670410); //
		CreateDynamicObject(823,-4150.3330078,-2562.3220215,0.0000000,359.2474365,357.9949951,359.9670410); //
		CreateDynamicObject(823,-4056.8339844,-2580.6889648,6.5110002,359.2474365,357.9949951,359.9670410); //
		CreateDynamicObject(839,-4198.5820312,-2542.7360840,0.0270000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(839,-4194.5009766,-2531.8649902,0.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(839,-4187.1938477,-2530.8100586,0.0000000,0.0000000,0.0000000,310.0000000); //
		CreateDynamicObject(900,-4107.4814453,-2258.3886719,12.0760002,0.0000000,0.0000000,29.9981689); //
		CreateDynamicObject(900,-3963.1718750,-2607.2021484,20.2479992,0.0000000,0.0000000,249.9938965); //
		CreateDynamicObject(900,-3976.5878906,-2608.8730469,20.2479992,0.0000000,0.0000000,289.9938965); //
		CreateDynamicObject(18751,-4306.9057617,-2559.2639160,-5.4800000,1.2414551,0.0000000,179.9615479); //
		CreateDynamicObject(18751,-4289.7690430,-2580.1789551,-7.4800000,1.2414551,0.0000000,179.9615479); //
		CreateDynamicObject(18751,-4279.2631836,-2602.3369141,-7.4800000,1.2414551,0.0000000,179.9615479); //
		CreateDynamicObject(18751,-4273.6748047,-2629.1699219,-7.4800000,1.2414551,0.0000000,179.9615479); //
		CreateDynamicObject(18751,-4250.6557617,-2572.3110352,-7.4800000,1.2414551,0.0000000,179.9615479); //
		CreateDynamicObject(18751,-4270.0419922,-2563.5969238,-7.4800000,1.2414551,0.0000000,179.9615479); //
		CreateDynamicObject(18751,-4265.4467773,-2589.8999023,-7.4800000,1.2414551,0.0000000,179.9615479); //
		CreateDynamicObject(18751,-4244.9448242,-2606.8879395,-7.4800000,1.2414551,0.0000000,179.9615479); //
		CreateDynamicObject(18751,-4196.9418945,-2622.6831055,-9.9799995,1.2414551,0.0000000,179.9615479); //
		CreateDynamicObject(18751,-4200.2319336,-2578.9929199,-7.4800000,1.2414551,0.0000000,179.9615479); //
		CreateDynamicObject(18751,-4218.2749023,-2581.0419922,-7.4800000,1.2414551,0.0000000,179.9615479); //
		CreateDynamicObject(18751,-4147.2729492,-2598.0310059,-9.2799997,1.2414551,0.0000000,179.9615479); //
		CreateDynamicObject(18751,-4108.8041992,-2599.1669922,-10.0299997,1.2414551,0.0000000,179.9615479); //
		CreateDynamicObject(18751,-4098.8608398,-2566.5568848,-10.0299997,1.2414551,0.0000000,179.9615479); //
		CreateDynamicObject(18751,-4078.3239746,-2541.7790527,-10.0299997,1.2414551,0.0000000,179.9615479); //
		CreateDynamicObject(18751,-4138.8320312,-2541.2099609,-10.0299997,1.2414551,0.0000000,179.9615479); //
		CreateDynamicObject(18751,-4115.0581055,-2533.9260254,-13.2799997,1.2414551,0.0000000,179.9615479); //
		CreateDynamicObject(18751,-4171.7490234,-2580.4208984,-7.9850001,1.2414551,0.0000000,179.9615479); //
		CreateDynamicObject(18751,-4187.1508789,-2557.5258789,-8.5100002,1.2414551,0.0000000,179.9615479); //
		CreateDynamicObject(18751,-4182.1220703,-2525.7919922,-11.2600002,1.2414551,0.0000000,179.9615479); //
		CreateDynamicObject(18751,-4174.4809570,-2510.5349121,-10.5100002,1.2414551,0.0000000,179.9615479); //
		CreateDynamicObject(18751,-4170.0878906,-2484.6389160,-10.5100002,1.2414551,0.0000000,179.9615479); //
		CreateDynamicObject(18751,-4148.5649414,-2478.3139648,-10.5100002,1.2414551,0.0000000,179.9615479); //
		CreateDynamicObject(18228,-4140.2631836,-2562.5419922,-12.6000004,0.0000000,0.0000000,341.9549561); //
		CreateDynamicObject(18228,-4119.7529297,-2559.3400879,-21.6000004,0.0000000,0.0000000,341.9549561); //
		CreateDynamicObject(18228,-4189.2709961,-2501.8710938,-17.8799992,0.0000000,0.0000000,201.9561768); //
		CreateDynamicObject(18228,-4186.3041992,-2496.3659668,-20.6299992,0.0000000,0.0000000,201.9561768); //
		CreateDynamicObject(18228,-4168.1318359,-2488.6989746,-20.6299992,0.0000000,0.0000000,191.9561768); //
		CreateDynamicObject(18228,-4160.1499023,-2483.9770508,-20.6299992,0.0000000,0.0000000,171.9531250); //
		CreateDynamicObject(18228,-4152.2021484,-2482.6101074,-20.6299992,0.0000000,0.0000000,171.9525146); //
		CreateDynamicObject(18228,-4145.2807617,-2484.6650391,-21.1800003,0.0000000,0.0000000,171.9525146); //
		CreateDynamicObject(18228,-4139.1938477,-2484.6831055,-21.1800003,0.0000000,0.0000000,171.9525146); //
		CreateDynamicObject(18228,-4130.6850586,-2479.3010254,-21.1800003,0.0000000,0.0000000,171.9525146); //
		CreateDynamicObject(18228,-4124.7202148,-2479.8610840,-22.4300003,0.0000000,0.0000000,171.9525146); //
		CreateDynamicObject(18228,-4120.6201172,-2477.2871094,-22.4300003,0.0000000,0.0000000,171.9525146); //
		CreateDynamicObject(18228,-4115.3837891,-2472.2619629,-22.4300003,0.0000000,0.0000000,171.9525146); //
		CreateDynamicObject(18228,-4108.0219727,-2470.0830078,-22.4300003,0.0000000,0.0000000,171.9525146); //
		CreateDynamicObject(18228,-4098.6591797,-2467.9919434,-22.9300003,0.0000000,0.0000000,171.9525146); //
		CreateDynamicObject(18228,-4094.5930176,-2466.6689453,-22.9300003,0.0000000,0.0000000,171.9525146); //
		CreateDynamicObject(18228,-4090.2958984,-2463.3750000,-22.9300003,0.0000000,0.0000000,171.9525146); //
		CreateDynamicObject(18228,-4080.4399414,-2459.3400879,-22.9300003,0.0000000,0.0000000,11.9525146); //
		CreateDynamicObject(18228,-4074.6860352,-2454.1850586,-22.9300003,0.0000000,0.0000000,11.9476318); //
		CreateDynamicObject(18228,-4070.9050293,-2450.5039062,-22.9300003,0.0000000,0.0000000,11.9476318); //
		CreateDynamicObject(18228,-4071.1699219,-2445.6630859,-22.9300003,0.0000000,0.0000000,11.9476318); //
		CreateDynamicObject(18228,-4069.8339844,-2441.8879395,-22.9300003,0.0000000,0.0000000,11.9476318); //
		CreateDynamicObject(18228,-4074.9750977,-2450.6269531,-22.9300003,0.0000000,0.0000000,11.9476318); //
		CreateDynamicObject(18228,-4156.0429688,-2414.6750488,-21.5750008,0.0000000,0.0000000,161.9824219); //
		CreateDynamicObject(18228,-4156.0541992,-2407.7109375,-21.5750008,0.0000000,0.0000000,161.9824219); //
		CreateDynamicObject(18228,-4177.7060547,-2381.6030273,-21.5750008,0.0000000,0.0000000,161.9824219); //
		CreateDynamicObject(18228,-4187.5605469,-2376.8642578,-24.0750008,0.0000000,0.0000000,161.9824219); //
		CreateDynamicObject(18228,-4197.2329102,-2382.1840820,-26.0750008,0.0000000,0.0000000,161.9824219); //
		CreateDynamicObject(814,-4118.6191406,-2563.4370117,0.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(814,-4120.9799805,-2563.5568848,2.3050001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(814,-4117.4741211,-2562.0778809,0.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(814,-4120.7158203,-2563.4169922,1.6510000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(814,-4162.7851562,-2489.6359863,1.8210000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(814,-4193.5888672,-2528.4750977,0.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(814,-4197.4970703,-2549.4289551,0.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(814,-4197.7119141,-2552.4270020,0.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(814,-3920.1740723,-2411.4270020,4.5860000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(814,-4199.5732422,-2556.4599609,0.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(814,-4201.8198242,-2556.4360352,0.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(814,-4206.2729492,-2560.3789062,1.1550000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(814,-4205.3999023,-2558.9499512,0.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(16122,-4279.7421875,-3258.8850098,-7.0000000,0.0000000,0.0000000,337.9956055); //
		CreateDynamicObject(16122,-3370.9089355,-3628.7390137,-5.5000000,0.0000000,0.0000000,57.9956055); //
		CreateDynamicObject(3920,-3503.9062500,-3842.8857422,16.6049995,0.0000000,0.0000000,319.9987793); //
		CreateDynamicObject(3920,-4146.2597656,-2817.5991211,1.0510000,0.0000000,0.0000000,349.9969482); //
		CreateDynamicObject(3920,-4446.1831055,-3164.4289551,-0.7750000,0.0000000,0.0000000,213.9914551); //
		CreateDynamicObject(789,-4156.2822266,-2569.7871094,27.5200005,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18228,-4130.3798828,-2522.0559082,-6.7500000,0.0000000,0.0000000,161.9549561); //
		CreateDynamicObject(1631,-4096.7519531,-2509.6979980,0.6250000,0.0000000,0.0000000,190.0000000); //
		CreateDynamicObject(18228,-4103.0888672,-2516.8999023,-18.3099995,0.0000000,0.0000000,151.9464111); //
		CreateDynamicObject(1631,-4095.1430664,-2525.9689941,0.6250000,0.0000000,0.0000000,9.9975586); //
		CreateDynamicObject(1655,-3882.3400879,-2494.9179688,0.1000000,0.0000000,0.0000000,49.9877930); //
		CreateDynamicObject(1655,-3882.7626953,-2493.4755859,2.7000000,8.9978027,0.0000000,49.9877930); //
		CreateDynamicObject(1655,-3881.5710449,-2495.0991211,0.7750000,1.4978027,0.0000000,49.9877930); //
		CreateDynamicObject(1655,-4143.9658203,-2300.0568848,3.0000000,9.2449951,0.0000000,239.9798584); //
		CreateDynamicObject(1655,-3914.6240234,-2470.4370117,0.7500000,9.2449951,0.0000000,239.9798584); //
		CreateDynamicObject(1655,-3911.8969727,-2471.1120605,0.9500000,9.2449951,0.0000000,239.9798584); //
		CreateDynamicObject(707,-4217.3769531,-2433.6923828,0.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(707,-4176.8071289,-2473.1520996,3.9770000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(707,-4195.3940430,-2535.6479492,-2.2750001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18228,-4253.6894531,-2404.0439453,-2.2500000,0.0000000,0.0000000,241.9628906); //
		CreateDynamicObject(18228,-4245.5839844,-2414.8029785,-19.5200005,0.0000000,0.0000000,241.9683838); //
		CreateDynamicObject(18228,-4245.7099609,-2407.5920410,-19.5200005,0.0000000,0.0000000,241.9683838); //
		CreateDynamicObject(18228,-4249.1269531,-2385.5673828,-24.2700005,0.0000000,0.0000000,241.9628906); //
		CreateDynamicObject(18228,-4277.4711914,-2401.4199219,-24.2700005,0.0000000,0.0000000,241.9683838); //
		CreateDynamicObject(18228,-4264.6982422,-2423.4780273,-24.2700005,0.0000000,0.0000000,281.9683838); //
		CreateDynamicObject(18228,-4249.5190430,-2428.6269531,-23.0200005,0.0000000,0.0000000,281.9641113); //
		CreateDynamicObject(18228,-4246.8032227,-2434.1831055,-23.0200005,0.0000000,0.0000000,311.9641113); //
		CreateDynamicObject(18228,-4239.4838867,-2439.8999023,-23.0200005,0.0000000,0.0000000,301.9622803); //
		CreateDynamicObject(18228,-4212.0761719,-2434.0329590,-23.0200005,0.0000000,0.0000000,351.9592285); //
		CreateDynamicObject(18228,-4198.2797852,-2434.7829590,-23.0200005,0.0000000,0.0000000,351.9580078); //
		CreateDynamicObject(18751,-4169.2470703,-2450.2070312,-11.7600002,1.2414551,0.0000000,179.9615479); //
		CreateDynamicObject(18228,-4250.7568359,-2382.0991211,-24.2700005,0.0000000,0.0000000,291.9683838); //
		CreateDynamicObject(18228,-4254.2148438,-2373.2399902,-24.2700005,0.0000000,0.0000000,351.9671631); //
		CreateDynamicObject(18228,-4275.8828125,-2375.4951172,-24.2700005,0.0000000,0.0000000,171.9635010); //
		CreateDynamicObject(18228,-4262.4887695,-2372.2919922,-24.2700005,0.0000000,0.0000000,171.9580078); //
		CreateDynamicObject(758,-3894.0700684,-3056.5449219,39.3250008,0.0000000,0.0000000,249.9993896); //
		CreateDynamicObject(2512,-4157.5761719,-2405.2209473,9.4130001,0.0000000,0.0000000,100.0000000); //
		CreateDynamicObject(3395,-4153.2519531,-2407.5839844,6.5799999,0.0000000,0.0000000,270.0000000); //
		CreateDynamicObject(2725,-4150.7309570,-2403.1179199,7.0130000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1486,-4150.7587891,-2402.8579102,7.5939999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1486,-4150.6088867,-2403.1721191,7.5939999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1512,-4150.6611328,-2403.0061035,7.6459999,0.0000000,0.0000000,320.0000000); //
		CreateDynamicObject(1520,-4150.7031250,-2403.3129883,7.4489999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2120,-4150.6708984,-2402.7810059,6.8680000,90.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2302,-4160.0688477,-2404.0739746,6.5799999,0.0000000,0.0000000,90.0000000); //
		CreateDynamicObject(639,-4125.5849609,-2268.1445312,11.5839996,0.0000000,0.0000000,73.9984131); //
		CreateDynamicObject(639,-4125.7089844,-2268.0100098,12.4090004,0.0000000,0.0000000,67.9984131); //
		CreateDynamicObject(639,-4129.6850586,-2266.1059570,12.4090004,0.0000000,0.0000000,63.4943848); //
		CreateDynamicObject(639,-4130.0551758,-2266.3750000,11.8090000,0.0000000,0.0000000,63.4899902); //
		CreateDynamicObject(639,-4129.8530273,-2266.7790527,11.1090002,0.0000000,0.0000000,71.4899902); //
		CreateDynamicObject(639,-4129.7402344,-2266.8349609,9.9589996,0.0000000,0.0000000,71.4880371); //
		CreateDynamicObject(639,-4074.2290039,-2262.0820312,20.1560001,0.0000000,0.0000000,63.4880371); //
		CreateDynamicObject(639,-4076.4560547,-2261.5139160,20.1560001,0.0000000,0.0000000,63.4844971); //
		CreateDynamicObject(639,-4079.9980469,-2258.8540039,18.9060001,0.0000000,0.0000000,63.4844971); //
		CreateDynamicObject(639,-4082.6540527,-2257.5449219,17.6560001,0.0000000,0.0000000,63.4844971); //
		CreateDynamicObject(639,-4084.7639160,-2256.7490234,16.6560001,0.0000000,0.0000000,63.4844971); //
		CreateDynamicObject(639,-4087.2009277,-2255.9809570,15.2559996,0.0000000,0.0000000,63.4844971); //
		CreateDynamicObject(639,-4089.8930664,-2254.7919922,13.6309996,0.0000000,0.0000000,63.4844971); //
		CreateDynamicObject(639,-4091.0839844,-2254.4189453,13.7559996,0.0000000,0.0000000,63.4844971); //
		CreateDynamicObject(639,-4092.4479980,-2253.9880371,14.1560001,0.0000000,0.0000000,63.4844971); //
		CreateDynamicObject(639,-4081.7680664,-2258.4670410,19.4060001,0.0000000,0.0000000,63.4844971); //
		CreateDynamicObject(3920,-4078.6640625,-2258.4389648,28.2549992,19.9664612,3.4580994,156.8148193); //
		CreateDynamicObject(639,-4133.1108398,-2265.8510742,11.1090002,0.0000000,0.0000000,71.4880371); //
		CreateDynamicObject(639,-4133.1958008,-2265.4208984,13.0590000,359.3230591,25.5019226,71.8109436); //
		CreateDynamicObject(639,-4133.5351562,-2265.1799316,13.0590000,359.3188477,25.4992676,71.8066406); //
		CreateDynamicObject(900,-4115.3300781,-2257.1250000,-4.3990002,5.9670105,90.6294556,233.9647217); //
		CreateDynamicObject(1506,-4120.6557617,-2257.8789062,1.9730000,0.0000000,0.0000000,312.0000000); //
		CreateDynamicObject(12990,-3656.1589355,-2845.9431152,36.0800018,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2511,-4159.4541016,-2402.4689941,9.4379997,0.0000000,0.0000000,39.9957275); //
		CreateDynamicObject(758,-4155.6582031,-2397.8916016,8.1499996,85.9954834,179.9945068,249.9938965); //
		CreateDynamicObject(758,-3894.9970703,-3057.1311035,40.0499992,0.0000000,0.0000000,249.9938965); //
		CreateDynamicObject(16120,-4097.3481445,-2268.8159180,-19.5200005,0.0000000,0.0000000,300.0000000); //
		CreateDynamicObject(16120,-4096.3798828,-2278.6120605,-19.5200005,0.0000000,0.0000000,299.9981689); //
		CreateDynamicObject(16120,-4107.3583984,-2293.0859375,-16.1949997,0.0000000,0.0000000,269.9945068); //
		CreateDynamicObject(18228,-4219.5639648,-2504.2729492,-10.0000000,0.0000000,0.0000000,151.9647217); //
		CreateDynamicObject(18228,-4246.7358398,-2518.8569336,-10.0000000,0.0000000,0.0000000,181.9628906); //
		CreateDynamicObject(18228,-4269.7167969,-2516.0109863,-23.2500000,0.0000000,0.0000000,191.9610596); //
		CreateDynamicObject(18228,-4241.8085938,-2410.2880859,-19.7700005,0.0000000,0.0000000,141.9598389); //
		CreateDynamicObject(18228,-4233.2998047,-2408.2070312,-19.7700005,0.0000000,0.0000000,141.9598389); //
		CreateDynamicObject(18228,-4228.0620117,-2404.0148926,-19.7700005,0.0000000,0.0000000,141.9598389); //
		CreateDynamicObject(18228,-4220.5600586,-2401.4260254,-14.8100004,0.0000000,0.0000000,141.9628906); //
		CreateDynamicObject(18228,-4212.8608398,-2399.4350586,-14.8100004,0.0000000,0.0000000,141.9598389); //
		CreateDynamicObject(16118,-4136.1938477,-2255.6931152,-12.1499996,0.0000000,0.0000000,319.9822998); //
		CreateDynamicObject(16118,-4138.8637695,-2252.7839355,-12.1499996,0.0000000,0.0000000,319.9822998); //
		CreateDynamicObject(16118,-4153.0468750,-2262.7070312,-20.8999996,0.0000000,0.0000000,319.9822998); //
		CreateDynamicObject(16118,-4156.0297852,-2256.6530762,-20.8999996,0.0000000,0.0000000,319.9822998); //
		CreateDynamicObject(16118,-4157.4951172,-2249.0969238,-20.8999996,0.0000000,0.0000000,319.9822998); //
		CreateDynamicObject(16118,-4141.4619141,-2244.9780273,-16.5699997,0.0000000,0.0000000,319.9822998); //
		CreateDynamicObject(16118,-4143.0971680,-2230.3620605,-24.3199997,0.0000000,0.0000000,319.9822998); //
		CreateDynamicObject(16118,-4133.1840820,-2225.5620117,-22.8199997,0.0000000,0.0000000,339.9822998); //
		CreateDynamicObject(16118,-4128.2670898,-2220.7170410,-22.8199997,0.0000000,0.0000000,269.9774170); //
		CreateDynamicObject(16118,-4123.0732422,-2219.6010742,-22.0949993,0.0000000,0.0000000,269.9725342); //
		CreateDynamicObject(16118,-4120.7211914,-2215.9440918,-20.3449993,0.0000000,0.0000000,269.9725342); //
		CreateDynamicObject(16118,-4118.9379883,-2211.6560059,-20.3449993,0.0000000,0.0000000,199.9725342); //
		CreateDynamicObject(16118,-4114.2841797,-2206.2958984,-20.3449993,0.0000000,0.0000000,199.9676514); //
		CreateDynamicObject(16118,-4107.0507812,-2203.3701172,-21.4950008,0.0000000,0.0000000,109.9676514); //
		CreateDynamicObject(16118,-4102.7329102,-2199.6230469,-21.4950008,0.0000000,0.0000000,109.9676514); //
		CreateDynamicObject(16118,-4098.1381836,-2196.8139648,-21.4950008,0.0000000,0.0000000,109.9676514); //
		CreateDynamicObject(16118,-4075.4409180,-2198.2580566,-21.4950008,0.0000000,0.0000000,79.9676514); //
		CreateDynamicObject(16118,-4071.5129395,-2210.9121094,-21.4950008,0.0000000,0.0000000,39.9639893); //
		CreateDynamicObject(16118,-4088.6708984,-2224.2880859,-21.4950008,0.0000000,0.0000000,319.9627686); //
		CreateDynamicObject(16118,-4094.2810059,-2231.7150879,-21.4950008,0.0000000,0.0000000,319.9603271); //
		CreateDynamicObject(16118,-4096.9667969,-2264.2810059,-21.4950008,0.0000000,0.0000000,319.9603271); //
		CreateDynamicObject(16118,-4094.2329102,-2259.7709961,-21.4950008,0.0000000,0.0000000,339.9603271); //
		CreateDynamicObject(16118,-4092.7241211,-2244.2800293,-21.4950008,0.0000000,0.0000000,309.9554443); //
		CreateDynamicObject(16118,-4090.5581055,-2242.0080566,-21.4950008,0.0000000,0.0000000,309.9517822); //
		CreateDynamicObject(16118,-4086.6970215,-2238.5729980,-20.4449997,0.0000000,0.0000000,339.9517822); //
		CreateDynamicObject(16118,-4080.9331055,-2225.6489258,-20.4449997,0.0000000,0.0000000,335.9499512); //
		CreateDynamicObject(16118,-4081.0229492,-2221.8850098,-20.4449997,0.0000000,0.0000000,335.9454346); //
		CreateDynamicObject(16118,-4081.6979980,-2219.1931152,-20.4449997,0.0000000,0.0000000,5.9454346); //
		CreateDynamicObject(16120,-4112.4238281,-2300.0371094,-16.1949997,0.0000000,0.0000000,269.9945068); //
		CreateDynamicObject(16120,-4099.7099609,-2276.0568848,-23.4449997,0.0000000,0.0000000,269.9945068); //
		CreateDynamicObject(16120,-4102.2050781,-2266.3469238,-23.4449997,0.0000000,0.0000000,269.9945068); //
		CreateDynamicObject(16120,-4101.0458984,-2270.9528809,-23.4449997,0.0000000,0.0000000,269.9945068); //
		CreateDynamicObject(16120,-4120.3271484,-2282.3500977,-23.4449997,0.0000000,0.0000000,189.9945068); //
		CreateDynamicObject(16120,-4130.3959961,-2276.2670898,-24.6700001,0.0000000,0.0000000,189.9920654); //
		CreateDynamicObject(16120,-4125.6601562,-2277.6579590,-24.6700001,0.0000000,0.0000000,189.9920654); //
		CreateDynamicObject(703,-4186.7280273,-2556.6188965,-1.0250000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(703,-4327.5297852,-2954.9809570,4.3810000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(703,-4120.3378906,-3221.0209961,6.6609998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(703,-4118.3251953,-3200.6289062,6.6609998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18751,-4017.7810059,-3256.2570801,-7.4460001,1.2414551,0.0000000,219.9822998); //
		CreateDynamicObject(18751,-4025.8278809,-3252.0148926,-7.4460001,1.2414551,0.0000000,219.9792480); //
		CreateDynamicObject(18751,-4024.3269043,-3240.1350098,-5.5960002,1.2414551,0.0000000,249.9792480); //
		CreateDynamicObject(18751,-4020.3210449,-3238.6799316,-4.1459999,1.2414551,0.0000000,249.9774170); //
		CreateDynamicObject(18751,-4020.3300781,-3239.5349121,-4.1459999,1.2414551,0.0000000,249.9774170); //
		CreateDynamicObject(18751,-4015.2590332,-3247.8950195,-4.1459999,1.2414551,0.0000000,209.9774170); //
		CreateDynamicObject(18751,-4036.5429688,-3243.9729004,-7.4460001,1.2414551,0.0000000,219.9792480); //
		CreateDynamicObject(18751,-4032.3110352,-3248.4250488,-6.7459998,1.2414551,0.0000000,219.9792480); //
		CreateDynamicObject(19439,-3969.6130371,-3193.4270020,24.2010002,0.0000000,90.0000000,279.9975586); //
		CreateDynamicObject(19439,-3971.1679688,-3193.6818848,24.2010002,0.0000000,90.0000000,279.9975586); //
		CreateDynamicObject(19439,-3973.1899414,-3195.0009766,23.2509995,0.0000000,56.0000000,9.9975586); //
		CreateDynamicObject(19439,-3973.4580078,-3193.4929199,23.2509995,0.0000000,55.9973145,9.9975586); //
		CreateDynamicObject(19439,-3973.7209473,-3192.0371094,23.2509995,0.0000000,55.9973145,9.9975586); //
		CreateDynamicObject(19439,-3976.1159668,-3193.9670410,21.4260006,0.0000000,55.9973145,9.9975586); //
		CreateDynamicObject(19439,-3976.3779297,-3192.4660645,21.4260006,0.0000000,55.9973145,9.9975586); //
		CreateDynamicObject(19439,-3976.6250000,-3190.9299316,21.4260006,0.0000000,55.9973145,9.9975586); //
		CreateDynamicObject(19439,-3975.8659668,-3195.4460449,21.4260006,0.0000000,55.9973145,9.9975586); //
		CreateDynamicObject(17864,-4027.0537109,-2907.5185547,10.3369999,0.0000000,0.0000000,299.9981689); //
		CreateDynamicObject(726,-3942.6159668,-3010.4528809,8.2419996,0.0000000,0.0000000,239.9908447); //
		CreateDynamicObject(16675,-3801.0615234,-2875.1337891,4.9439998,0.0000000,0.0000000,169.9914551); //
		CreateDynamicObject(16120,-3738.4042969,-3340.9609375,-0.8500000,0.0000000,0.0000000,149.9688721); //
		CreateDynamicObject(16120,-4046.8769531,-2913.7028809,-10.6840000,0.0000000,0.0000000,149.9639893); //
		CreateDynamicObject(16120,-4039.1621094,-2928.3610840,-9.5590000,0.0000000,0.0000000,159.9633789); //
		CreateDynamicObject(16120,-4037.7829590,-2921.9340820,-9.5590000,0.0000000,0.0000000,219.9609375); //
		CreateDynamicObject(770,-4056.0258789,-2936.4108887,3.0130000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(903,-3943.3110352,-3379.5500488,0.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(903,-4271.1279297,-3102.7770996,3.8750000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(903,-4282.5097656,-3108.5349121,3.8750000,0.0000000,0.0000000,60.0000000); //
		CreateDynamicObject(903,-4286.9028320,-3113.6298828,3.8750000,0.0000000,0.0000000,119.9926758); //
		CreateDynamicObject(800,-4327.1738281,-2938.2160645,7.2199998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(800,-4321.9218750,-2934.2219238,7.2199998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(800,-4328.9238281,-2949.4641113,7.2199998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(800,-4317.0058594,-2955.8320312,9.2200003,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1609,-3799.5739746,-3141.4741211,5.3220000,0.0000000,0.0000000,220.0000000); //
		CreateDynamicObject(920,-3793.2141113,-3166.4418945,8.3079996,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(653,-3921.3369141,-2872.0759277,21.6480007,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(653,-3927.1640625,-2882.1201172,2.7830000,0.0000000,0.0000000,100.0000000); //
		CreateDynamicObject(653,-3899.0478516,-2888.5048828,18.6809998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(653,-3945.5820312,-2683.1918945,11.4720001,0.0000000,0.0000000,99.9975586); //
		CreateDynamicObject(653,-3906.1132812,-2857.0107422,30.6140003,0.0000000,0.0000000,99.9975586); //
		CreateDynamicObject(653,-3897.5595703,-2838.3144531,32.1020012,0.0000000,0.0000000,99.9975586); //
		CreateDynamicObject(653,-3907.6875000,-2844.9716797,19.4810009,0.0000000,0.0000000,99.9975586); //
		CreateDynamicObject(18228,-3991.1550293,-2647.5380859,-3.5630000,0.0000000,0.0000000,311.9952393); //
		CreateDynamicObject(900,-3999.1159668,-2635.9379883,9.6260004,0.0000000,0.0000000,129.9938965); //
		CreateDynamicObject(900,-4033.0219727,-2552.1560059,-6.0749998,0.0000000,0.0000000,119.9926758); //
		CreateDynamicObject(900,-4035.7910156,-2543.8920898,-5.2750001,0.0000000,0.0000000,119.9926758); //
		CreateDynamicObject(648,-3983.9890137,-2594.4780273,23.3589993,0.0000000,0.0000000,81.9689941); //
		CreateDynamicObject(648,-4012.9570312,-2557.2260742,14.2740002,0.0000000,0.0000000,181.9635010); //
		CreateDynamicObject(18751,-3674.7490234,-2513.4431152,-11.7969999,0.0000000,0.0000000,357.9895020); //
		CreateDynamicObject(18751,-3676.2548828,-2492.8840332,-11.7969999,0.0000000,0.0000000,357.9895020); //
		CreateDynamicObject(18751,-3682.3730469,-2474.5039062,-11.7969999,0.0000000,0.0000000,357.9895020); //
		CreateDynamicObject(18751,-3752.1000977,-2586.6860352,-12.5719995,0.0000000,0.0000000,357.9895020); //
		CreateDynamicObject(18751,-3761.8889160,-2583.8999023,-12.5719995,0.0000000,0.0000000,357.9895020); //
		CreateDynamicObject(18751,-3756.8920898,-2610.8239746,-8.6969995,0.0000000,0.0000000,357.9895020); //
		CreateDynamicObject(4241,-3856.9873047,-2742.7480469,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(16112,-3465.8049316,-3809.9489746,-14.0000000,3.2464600,0.0000000,99.9810791); //
		CreateDynamicObject(16112,-3464.1088867,-3824.2170410,-17.7500000,3.2464600,0.0000000,359.9810791); //
		CreateDynamicObject(16112,-3464.1179199,-3830.9318848,-17.2500000,3.2464600,0.0000000,299.9780273); //
		CreateDynamicObject(16112,-3459.4169922,-3847.3798828,-17.2500000,3.2464600,0.0000000,289.9761963); //
		CreateDynamicObject(16112,-3455.1508789,-3860.8510742,-17.2500000,3.2464600,0.0000000,289.9731445); //
		CreateDynamicObject(19473,-3584.0490723,-3580.4199219,5.5799999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(19473,-3584.4880371,-3579.8369141,5.5760002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(19473,-3584.0568848,-3579.7141113,5.6290002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(19473,-3584.1760254,-3581.0371094,5.6729999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(19473,-3583.3269043,-3580.7399902,5.6729999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(19473,-3583.7770996,-3580.3701172,6.4229999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(19473,-3583.8798828,-3579.9519043,6.4229999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(19473,-3584.2119141,-3580.2241211,6.4229999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(16112,-4009.6601562,-2887.4775391,0.2220000,0.0000000,0.0000000,11.9915771); //
		CreateDynamicObject(16122,-4430.9218750,-3212.3955078,-6.2500000,0.0000000,0.0000000,337.9943848); //
		CreateDynamicObject(16112,-4441.8496094,-3214.7685547,-5.2500000,0.0000000,0.0000000,1.9830322); //
		CreateDynamicObject(16112,-4397.5869141,-3147.0190430,-8.7500000,0.0000000,0.0000000,201.9873047); //
		CreateDynamicObject(16112,-4421.6381836,-3132.6040039,-5.2500000,0.0000000,0.0000000,31.9921875); //
		CreateDynamicObject(16122,-4442.2724609,-3145.5351562,-6.2500000,0.0000000,0.0000000,167.9919434); //
		CreateDynamicObject(899,-4431.2373047,-3145.3818359,16.0400009,324.0142822,177.5115967,18.5119629); //
		CreateDynamicObject(899,-4028.6728516,-2891.6835938,23.2579994,324.0142822,177.5115967,348.5137939); //
		CreateDynamicObject(899,-4444.3652344,-3154.4628906,16.2900009,316.0217285,177.1984863,58.0297852); //
		CreateDynamicObject(899,-4452.1523438,-3164.6767578,15.8649998,316.0162354,177.1929932,58.0242920); //
		CreateDynamicObject(899,-4459.4277344,-3177.8212891,15.8649998,316.0162354,177.1929932,98.0255127); //
		CreateDynamicObject(899,-4404.1870117,-3172.0048828,15.8649998,316.0162354,177.1929932,278.0255127); //
		CreateDynamicObject(899,-4410.6757812,-3185.9589844,15.8649998,316.0162354,177.1929932,238.0242920); //
		CreateDynamicObject(899,-4428.0942383,-3201.3940430,15.8649998,316.0162354,177.1929932,218.0242920); //
		CreateDynamicObject(899,-4414.4111328,-3203.4780273,5.1149998,294.0733337,113.2002563,155.1208496); //
		CreateDynamicObject(16120,-4437.4384766,-3142.5009766,-4.0000000,0.0000000,0.0000000,89.9780273); //
		CreateDynamicObject(11496,-4447.2949219,-3159.9619141,0.0000000,0.0000000,0.0000000,304.4805908); //
		CreateDynamicObject(16120,-4445.4301758,-3146.0070801,-13.0000000,0.0000000,0.0000000,89.9780273); //
		CreateDynamicObject(18751,-4334.3134766,-2923.3671875,2.0000000,1.2414551,0.0000000,149.9743652); //
		CreateDynamicObject(18751,-4431.2460938,-3160.9951172,-8.9899998,1.2414551,0.0000000,149.9743652); //
		CreateDynamicObject(18751,-4409.4169922,-3173.8896484,-9.4150000,1.2414551,0.0000000,149.9688721); //
		CreateDynamicObject(18751,-4412.8710938,-3203.9099121,-10.8900003,1.2414551,0.0000000,149.9743652); //
		CreateDynamicObject(899,-4436.1777344,-3190.8798828,18.0149994,346.0528564,186.1523438,221.4569092); //
		CreateDynamicObject(899,-4425.9560547,-3181.0200195,18.0149994,346.0583496,186.1578369,221.4624023); //
		CreateDynamicObject(899,-4435.4750977,-3167.3000488,20.5900002,6.0044861,4.0464478,99.5493774); //
		CreateDynamicObject(899,-4420.6181641,-3164.8979492,19.5900002,6.0040283,4.0429688,99.5471191); //
		CreateDynamicObject(899,-4444.4941406,-3203.0769043,8.7399998,329.5390625,225.5421143,223.2934570); //
		CreateDynamicObject(6965,-4431.6098633,-3172.1740723,-1.7330000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(16112,-4365.7060547,-3161.8505859,-8.3249998,0.0000000,0.0000000,201.9781494); //
		CreateDynamicObject(2404,-4260.6474609,-2903.4404297,21.3750000,270.0000000,90.0000000,149.9963379); //
		CreateDynamicObject(12857,-3484.3840332,-2766.9089355,-3.8150001,0.0000000,0.0000000,267.9919434); //
		CreateDynamicObject(12857,-3525.0939941,-2765.7299805,-3.8150001,0.0000000,0.0000000,267.9895020); //
		CreateDynamicObject(12857,-3565.7829590,-2764.5769043,-3.8150001,0.0000000,0.0000000,267.9895020); //
		CreateDynamicObject(18751,-3556.4560547,-2589.6201172,-11.7799997,0.9722900,0.0000000,199.9731445); //
		CreateDynamicObject(18751,-3541.0830078,-2576.9060059,-11.0299997,0.9722900,0.0000000,199.9731445); //
		CreateDynamicObject(18751,-3537.7858887,-2488.1779785,-11.0299997,0.9722900,0.0000000,199.9731445); //
		CreateDynamicObject(18751,-3534.4528809,-2506.6069336,-9.2299995,0.9722900,0.0000000,199.9731445); //
		CreateDynamicObject(18751,-3566.6818848,-2502.1899414,-9.2299995,0.9722900,0.0000000,199.9731445); //
		CreateDynamicObject(18751,-3597.3869629,-2463.6269531,-15.4799995,0.9722900,0.0000000,199.9731445); //
		CreateDynamicObject(18751,-3500.8259277,-2501.0710449,-11.4799995,0.9722900,0.0000000,199.9731445); //
		CreateDynamicObject(18751,-3488.1931152,-2490.6979980,-11.4799995,0.9722900,0.0000000,199.9731445); //
		CreateDynamicObject(18751,-3479.8310547,-2478.9499512,-11.4799995,0.9722900,0.0000000,199.9731445); //
		CreateDynamicObject(18751,-3497.9331055,-2449.4689941,-11.4799995,0.9722900,0.0000000,249.9731445); //
		CreateDynamicObject(18751,-3550.7219238,-2424.8400879,-11.4799995,0.9722900,0.0000000,249.9719238); //
		CreateDynamicObject(18751,-3576.2871094,-2314.4299316,-13.1000004,0.9722900,0.0000000,269.9725342); //
		CreateDynamicObject(18751,-3641.5449219,-2331.3430176,-10.6000004,0.9722900,0.0000000,339.9725342); //
		CreateDynamicObject(18751,-3655.5810547,-2383.0949707,-10.6000004,0.9722900,0.0000000,339.9719238); //
		CreateDynamicObject(18751,-3703.1970215,-2432.2250977,-10.6000004,0.9722900,0.0000000,249.9719238); //
		CreateDynamicObject(18751,-3743.9160156,-2419.1220703,-10.6000004,0.9722900,0.0000000,249.9719238); //
		CreateDynamicObject(18751,-3767.7570801,-2459.0129395,-10.6000004,0.9722900,0.0000000,239.9719238); //
		CreateDynamicObject(18751,-3821.5539551,-2502.1818848,-10.6000004,0.9722900,0.0000000,229.9688721); //
		CreateDynamicObject(18751,-3708.8378906,-2531.4279785,-11.1000004,0.9722900,0.0000000,229.9658203); //
		CreateDynamicObject(18751,-3694.5710449,-2572.4169922,-9.8999996,0.9722900,0.0000000,159.9658203); //
		CreateDynamicObject(18751,-3768.4951172,-2735.2661133,-15.8459997,2.7410889,0.4998779,57.9528809); //
		CreateDynamicObject(16120,-3735.9660645,-2601.6010742,-20.3099995,0.0000000,0.0000000,129.9914551); //
		CreateDynamicObject(16120,-3735.7099609,-2594.2548828,-20.3099995,0.0000000,0.0000000,129.9902344); //
		CreateDynamicObject(16120,-3735.9440918,-2586.5729980,-20.3099995,0.0000000,0.0000000,129.9902344); //
		CreateDynamicObject(16120,-3728.2709961,-2562.0668945,-20.3099995,0.0000000,0.0000000,49.9902344); //
		CreateDynamicObject(16120,-3718.7041016,-2562.4050293,-20.3099995,0.0000000,0.0000000,59.9877930); //
		CreateDynamicObject(16120,-3714.6130371,-2567.2780762,-20.3099995,0.0000000,0.0000000,59.9853516); //
		CreateDynamicObject(18751,-3946.3769531,-2582.9399414,-8.7100000,0.9887695,0.0000000,29.9847412); //
		CreateDynamicObject(18228,-4076.8649902,-2407.6389160,-3.0000000,0.0000000,0.0000000,241.9451904); //
		CreateDynamicObject(18228,-4088.5039062,-2366.3520508,-3.0000000,0.0000000,0.0000000,281.9409180); //
		CreateDynamicObject(18228,-4114.2822266,-2339.1560059,-3.0000000,0.0000000,0.0000000,281.9366455); //
		CreateDynamicObject(18228,-4112.2690430,-2308.3630371,-3.0000000,0.0000000,0.0000000,11.9366455); //
		CreateDynamicObject(18228,-4152.6191406,-2333.7080078,-3.0000000,0.0000000,0.0000000,141.9366455); //
		CreateDynamicObject(18228,-4197.2319336,-2323.4970703,-3.0000000,0.0000000,0.0000000,131.9323730); //
		CreateDynamicObject(18228,-4217.0400391,-2298.7490234,-3.0000000,0.0000000,0.0000000,81.9293213); //
		CreateDynamicObject(18228,-4263.5449219,-2357.4660645,-3.0000000,0.0000000,0.0000000,261.9250488); //
		CreateDynamicObject(707,-4202.7148438,-2307.8979492,6.7440000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18228,-4210.0151367,-2404.9409180,-14.6099997,0.0000000,0.0000000,141.9323730); //
		CreateDynamicObject(653,-3929.1499023,-2827.5778809,10.2639999,0.0000000,0.0000000,209.9981689); //
		CreateDynamicObject(653,-3929.9880371,-2830.2619629,8.9910002,0.0000000,0.0000000,119.9981689); //
		CreateDynamicObject(16693,-3510.8000488,-2425.6059570,-27.6930008,0.0000000,0.0000000,279.9865723); //
		CreateDynamicObject(16693,-3477.0891113,-2435.0419922,-33.4430008,0.0000000,0.0000000,279.9865723); //
		CreateDynamicObject(16693,-3499.5576172,-2416.9257812,-33.4430008,0.0000000,0.0000000,339.9829102); //
		CreateDynamicObject(622,-3569.4775391,-2546.1933594,21.2099991,29.9816895,0.0000000,29.9707031); //
		CreateDynamicObject(648,-3983.9882812,-2594.4775391,23.3589993,0.0000000,0.0000000,81.9635010); //
		CreateDynamicObject(622,-4243.1831055,-2405.1340332,-2.0000000,13.9910889,0.0000000,309.9761963); //
		CreateDynamicObject(622,-3724.5517578,-2718.0732422,5.3790002,13.9910889,0.0000000,79.9749756); //
		CreateDynamicObject(726,-3888.2680664,-2544.4860840,2.0220001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(707,-3770.7810059,-2637.8750000,14.9230003,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(710,-3831.1386719,-2595.6357422,18.8139992,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(648,-3831.0546875,-2592.8681641,1.0980000,0.0000000,0.0000000,311.9732666); //
		CreateDynamicObject(671,-3766.5800781,-2635.6330566,15.0930004,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(671,-3778.6721191,-2639.4069824,14.5089998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(671,-3778.0859375,-2619.8388672,16.7889996,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(707,-3578.3588867,-2309.2958984,21.7269993,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(9831,-4459.3940430,-3176.0769043,-14.4750004,282.0000000,0.0000000,252.5000000); //
		CreateDynamicObject(899,-4449.6347656,-3180.8525391,18.0149994,346.0528564,186.1523438,151.4520264); //
		CreateDynamicObject(9831,-4454.9199219,-3173.7802734,-14.4750004,272.2467041,0.0000000,74.4982910); //
		CreateDynamicObject(18747,-4460.7778320,-3175.8811035,-2.0250001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18747,-4458.6870117,-3174.4179688,-2.0250001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18747,-4460.9370117,-3174.4309082,-2.0250001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18747,-4461.4028320,-3180.1840820,-2.0250001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18747,-4464.4028320,-3180.2009277,-2.0250001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18747,-4463.6630859,-3178.4460449,-2.0250001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18747,-4458.4130859,-3178.4150391,-2.0250001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18747,-4458.4130859,-3178.4150391,-2.0250001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18747,-4457.7343750,-3175.2392578,-2.0250001,0.0000000,0.0000000,0.2500000); //
		CreateDynamicObject(18747,-4457.8710938,-3170.9409180,-2.0250001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18747,-4455.9760742,-3176.2609863,-2.0250001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18747,-4455.9755859,-3176.2607422,-2.0250001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18747,-4457.5551758,-3172.2739258,-2.0250001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18751,-4457.6865234,-3195.4521484,-10.2399998,1.2414551,0.0000000,149.9633789); //
		CreateDynamicObject(9831,-4458.9726562,-3174.7958984,-14.4750004,281.9915771,0.0000000,252.4932861); //
		CreateDynamicObject(899,-4468.6152344,-3167.2939453,7.9400001,19.4018555,84.9682617,264.8144531); //
		CreateDynamicObject(899,-4468.6474609,-3167.4404297,2.0150001,19.4018555,84.9627686,264.8089600); //
		CreateDynamicObject(899,-4469.4951172,-3172.7360840,-6.2350001,19.4018555,84.9682617,264.8144531); //
		CreateDynamicObject(899,-4469.7148438,-3177.7019043,5.6650000,19.4018555,84.9682617,74.8144531); //
		CreateDynamicObject(19298,-4458.1791992,-3174.2390137,0.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(9833,-4432.0341797,-3172.2351074,4.5749998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(903,-4291.0830078,-3092.3320312,3.8750000,0.0000000,0.0000000,119.9926758); //
		CreateDynamicObject(7916,-4406.6289062,-3183.5769043,3.8750000,0.0000000,0.0000000,219.9902344); //
		CreateDynamicObject(7916,-4417.6660156,-3194.8530273,3.8750000,0.0000000,0.0000000,219.9902344); //
		CreateDynamicObject(726,-3875.9050293,-3121.9230957,45.1100006,0.0000000,0.0000000,239.9908447); //
		CreateDynamicObject(726,-3846.9790039,-2962.3859863,4.6220002,0.0000000,0.0000000,239.9908447); //
		CreateDynamicObject(726,-3725.0620117,-2479.5949707,11.6800003,0.0000000,0.0000000,239.9908447); //
		CreateDynamicObject(726,-3758.5400391,-2499.9072266,6.9670000,0.0000000,0.0000000,239.9908447); //
		CreateDynamicObject(726,-3614.0419922,-2583.3601074,33.5839996,0.0000000,0.0000000,89.9908447); //
		CreateDynamicObject(726,-3661.9345703,-2367.6123047,-0.0190000,0.0000000,0.0000000,239.9853516); //
		CreateDynamicObject(862,-4014.5759277,-2906.9108887,10.5349998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(862,-4016.9770508,-2908.1430664,10.5070000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(862,-4019.2460938,-2909.3020020,10.4449997,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(862,-4021.4289551,-2910.5270996,10.4680004,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(862,-4023.3889160,-2911.5690918,10.3970003,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(862,-4025.3020020,-2912.5539551,10.3050003,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(862,-4027.0859375,-2913.5639648,10.1969995,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(862,-4029.1608887,-2914.6750488,10.1000004,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(862,-4031.2451172,-2915.8420410,10.1099997,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(862,-4033.2890625,-2916.9489746,10.1180000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(16112,-4014.4609375,-2890.8149414,-1.3530000,0.0000000,0.0000000,11.9915771); //
		CreateDynamicObject(16112,-4016.2209473,-2888.1979980,-1.3530000,0.0000000,0.0000000,11.9915771); //
		CreateDynamicObject(862,-4015.5310059,-2905.0490723,10.5349998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(862,-4017.9689941,-2906.3620605,10.5349998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(862,-4020.2570801,-2907.5429688,10.4849997,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(862,-4022.4560547,-2908.6789551,10.4350004,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(862,-4024.5000000,-2909.7338867,10.3350000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(862,-4026.3701172,-2910.6909180,10.2100000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(862,-4028.3210449,-2911.7070312,10.1099997,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(862,-4030.3190918,-2912.8530273,10.0850000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(862,-4032.3830566,-2914.0358887,10.1599998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(862,-4034.4689941,-2915.2309570,10.1099997,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(3409,-4031.8239746,-2908.5029297,10.1090002,0.0000000,0.0000000,29.9981689); //
		CreateDynamicObject(3409,-4028.0700684,-2906.4350586,10.1090002,0.0000000,0.0000000,29.9981689); //
		CreateDynamicObject(3409,-4024.2229004,-2904.2690430,10.1090002,0.0000000,0.0000000,29.9981689); //
		CreateDynamicObject(3409,-4020.5930176,-2902.2309570,10.1090002,0.0000000,0.0000000,29.9981689); //
		CreateDynamicObject(3286,-4034.9379883,-2900.9829102,14.0970001,0.0000000,0.0000000,20.0000000); //
		CreateDynamicObject(9833,-4050.6369629,-3060.5520020,6.0879998,0.0000000,0.0000000,70.0000000); //
		CreateDynamicObject(18751,-4048.7351074,-3199.2600098,-5.9559999,1.2414551,0.0000000,189.9865723); //
		CreateDynamicObject(18751,-4058.5681152,-3155.1789551,-5.9559999,1.2414551,0.0000000,189.9865723); //
		CreateDynamicObject(762,-3775.1787109,-3077.0468750,8.5690002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(683,-3834.1350098,-3247.5090332,7.9000001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(683,-3831.9560547,-3238.1789551,7.9000001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(683,-3854.0429688,-3250.2773438,7.9000001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(683,-3825.0161133,-3252.8059082,6.9000001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(710,-3841.5500488,-3193.0439453,8.7449999,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(648,-3843.3740234,-3203.7351074,1.9780000,0.0000000,0.0000000,151.9866943); //
		CreateDynamicObject(767,-3828.3278809,-3232.3750000,7.5500002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(840,-3825.4389648,-3242.7399902,10.3990002,359.9849854,0.0000000,117.9931641); //
		CreateDynamicObject(704,-3837.0729980,-3222.2700195,4.8200002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(791,-3829.5590820,-3254.2949219,-0.7750000,0.0000000,0.0000000,328.1231689); //
		CreateDynamicObject(16118,-4025.9089355,-2308.4870605,-2.7300000,0.0000000,0.0000000,179.9780273); //
		CreateDynamicObject(16118,-4017.1799316,-2346.1350098,-2.7300000,0.0000000,0.0000000,209.9780273); //
		CreateDynamicObject(16118,-3990.1630859,-2380.9628906,-2.7300000,0.0000000,0.0000000,29.9761963); //
		CreateDynamicObject(16118,-4002.6860352,-2335.7890625,-2.7300000,0.0000000,0.0000000,19.9761963); //
		CreateDynamicObject(16118,-3989.4050293,-2329.8879395,-2.7300000,0.0000000,0.0000000,319.9731445); //
		CreateDynamicObject(1655,-3912.6962891,-2471.8652344,2.9250000,9.2449951,0.0000000,239.9798584); //
		CreateDynamicObject(1655,-4148.0898438,-2297.6899414,0.5000000,0.0000000,0.0000000,239.9798584); //
		CreateDynamicObject(3415,-3793.7910156,-3163.0634766,7.3319998,0.0000000,0.0000000,85.9954834); //
		CreateDynamicObject(2901,-4028.5810547,-2897.7299805,10.8739996,0.0000000,0.0000000,39.9957275); //
		CreateDynamicObject(2901,-4028.9179688,-2897.2849121,10.8599997,0.0000000,0.0000000,39.9957275); //
		CreateDynamicObject(2901,-4029.2089844,-2896.9230957,10.8479996,0.0000000,0.0000000,39.9957275); //
		CreateDynamicObject(2901,-4028.9570312,-2896.9909668,11.2480001,0.0000000,0.0000000,39.9957275); //
		CreateDynamicObject(2901,-4028.6430664,-2897.4799805,11.2480001,0.0000000,0.0000000,39.9957275); //
		CreateDynamicObject(2901,-4028.4780273,-2897.6411133,11.6230001,0.0000000,0.0000000,39.9957275); //
		CreateDynamicObject(2901,-4028.8181152,-2897.1940918,11.6230001,0.0000000,0.0000000,39.9957275); //
		CreateDynamicObject(2090,-4026.4189453,-2892.9309082,10.5089998,0.0000000,0.0000000,306.0000000); //
		CreateDynamicObject(2147,-4028.2729492,-2894.3129883,10.4460001,0.0000000,0.0000000,34.0000000); //
		CreateDynamicObject(2080,-4026.3300781,-2895.2351074,10.4740000,0.0000000,0.0000000,40.0000000); //
		CreateDynamicObject(2120,-4026.2648926,-2894.6350098,11.0559998,0.0000000,0.0000000,140.0000000); //
		CreateDynamicObject(758,-4428.6938477,-3162.9641113,-2.8000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(744,-4427.4550781,-3179.0625000,-4.3160000,0.0000000,0.0000000,90.0000000); //
		CreateDynamicObject(16118,-3398.4040527,-3566.4919434,-8.8750000,0.0000000,0.0000000,129.9847412); //
		CreateDynamicObject(16118,-3406.8759766,-3595.6269531,-8.8750000,0.0000000,0.0000000,229.9847412); //
		CreateDynamicObject(16118,-3371.3039551,-3636.1599121,-8.8750000,0.0000000,0.0000000,209.9822998); //
		CreateDynamicObject(18751,-3519.5681152,-3817.1159668,-7.8769999,7.9925537,0.0000000,0.0000000); //
		CreateDynamicObject(18751,-3548.9089355,-3820.1230469,-7.8769999,7.9925537,0.0000000,70.0000000); //
		CreateDynamicObject(18751,-3561.0471191,-3874.8610840,-7.8769999,7.9870605,0.0000000,89.9993896); //
		CreateDynamicObject(18751,-3504.2128906,-3800.0959473,-12.8769999,7.9925537,0.0000000,0.0000000); //
		CreateDynamicObject(18751,-3454.7529297,-3766.7810059,-10.4270000,7.9925537,0.0000000,0.0000000); //
		CreateDynamicObject(18751,-3372.8820801,-3697.1860352,-10.1020002,7.9925537,0.0000000,0.0000000); //
		CreateDynamicObject(18751,-3385.6020508,-3645.7648926,-10.1020002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18751,-3381.9560547,-3576.4951172,-10.1020002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18751,-3402.6779785,-3570.8239746,-10.1020002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18751,-3359.9699707,-3606.1411133,-10.1020002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18751,-3344.0668945,-3628.4409180,-7.7270002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18751,-3372.2810059,-3685.7661133,-7.7270002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18751,-3377.2590332,-3729.1508789,-7.7270002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18751,-3392.8020020,-3761.2338867,-7.7270002,0.0000000,0.0000000,300.0000000); //
		CreateDynamicObject(18751,-3481.5471191,-3878.6889648,-7.7270002,0.0000000,0.0000000,299.9981689); //
		CreateDynamicObject(18751,-3523.7639160,-3918.8479004,-6.4770002,0.0000000,0.0000000,299.9981689); //
		CreateDynamicObject(18751,-3560.2260742,-3922.6440430,-7.5019999,0.0000000,0.0000000,299.9981689); //
		CreateDynamicObject(18751,-3580.8779297,-3870.9409180,-7.5019999,0.0000000,0.0000000,279.9981689); //
		CreateDynamicObject(18751,-3570.1350098,-3825.5161133,-7.5019999,0.0000000,0.0000000,229.9975586); //
		CreateDynamicObject(18751,-3562.5529785,-3795.4489746,-7.5019999,0.0000000,0.0000000,169.9932861); //
		CreateDynamicObject(812,-3504.5930176,-3841.5249023,14.5530005,0.0000000,0.0000000,60.0000000); //
		CreateDynamicObject(819,-3511.0549316,-3838.9550781,12.4440002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(819,-3517.5419922,-3833.3049316,5.3690000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(819,-3511.6950684,-3836.9660645,5.3690000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(827,-3517.2910156,-3852.2333984,9.4849997,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18751,-3494.0969238,-2746.9418945,-11.5810003,0.0000000,0.0000000,337.9888916); //
		CreateDynamicObject(710,-3879.4289551,-2550.4589844,11.0349998,0.0000000,0.0000000,259.9859619); //
		CreateDynamicObject(683,-3907.2299805,-3244.4270020,7.4600000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(16112,-4476.7128906,-3193.5937500,-5.2500000,0.0000000,0.0000000,91.9775391); //
		CreateDynamicObject(9831,-4454.1372070,-3193.8269043,-14.4750004,272.2467041,0.0000000,324.4982910); //
		CreateDynamicObject(899,-4442.6220703,-3203.4150391,7.9650002,0.5194397,89.9859924,41.4501343); //
		CreateDynamicObject(9831,-4451.7192383,-3191.4790039,-14.4750004,283.2465210,0.0000000,142.7476807); //
		CreateDynamicObject(899,-4466.8071289,-3187.6289062,6.8400002,0.5163574,89.9835205,271.4459229); //
		CreateDynamicObject(18747,-4449.7900391,-3193.4619141,-2.0250001,0.0000000,0.0000000,0.2471924); //
		CreateDynamicObject(18747,-4451.5839844,-3192.2338867,-2.0250001,0.0000000,0.0000000,0.2471924); //
		CreateDynamicObject(18747,-4452.9838867,-3191.0939941,-2.0250001,0.0000000,0.0000000,0.2471924); //
		CreateDynamicObject(18747,-4455.5810547,-3189.4689941,-2.0250001,0.0000000,0.0000000,0.2471924); //
		CreateDynamicObject(18747,-4454.0410156,-3188.7451172,-2.0250001,0.0000000,0.0000000,0.2471924); //
		CreateDynamicObject(18747,-4449.7509766,-3190.6589355,-2.0250001,0.0000000,0.0000000,0.2471924); //
		CreateDynamicObject(18747,-4452.5307617,-3198.1530762,-2.0250001,0.0000000,0.0000000,0.2471924); //
		CreateDynamicObject(18747,-4455.0688477,-3196.7500000,-2.0250001,0.0000000,0.0000000,0.2471924); //
		CreateDynamicObject(18747,-4454.1928711,-3186.8701172,-2.0250001,0.0000000,0.0000000,0.2471924); //
		CreateDynamicObject(18747,-4453.9501953,-3193.0180664,-2.0250001,0.0000000,0.0000000,0.2471924); //
		CreateDynamicObject(18747,-4454.4218750,-3193.7839355,-2.0250001,0.0000000,0.0000000,0.2471924); //
		CreateDynamicObject(744,-4435.4599609,-3176.0029297,-8.1160002,0.0000000,0.0000000,90.0000000); //
		CreateDynamicObject(18751,-4198.5488281,-2895.6889648,-9.6650000,1.2414551,0.0000000,159.9725342); //
		CreateDynamicObject(18751,-4231.8730469,-2940.2619629,-9.6650000,1.2414551,0.0000000,149.9719238); //
		CreateDynamicObject(18751,-4250.6967773,-2953.2299805,-9.6650000,1.2414551,0.0000000,169.9688721); //
		CreateDynamicObject(18751,-4294.9589844,-2961.0910645,-9.6650000,1.2414551,0.0000000,169.9639893); //
		CreateDynamicObject(18751,-4317.9248047,-2984.7141113,-8.1650000,1.2414551,0.0000000,169.9639893); //
		CreateDynamicObject(18751,-4366.8608398,-2960.2480469,-8.1650000,1.2414551,0.0000000,169.9639893); //
		CreateDynamicObject(18751,-4386.4072266,-2935.6950684,-8.1650000,1.2414551,0.0000000,169.9639893); //
		CreateDynamicObject(18751,-4382.4912109,-2881.7309570,-8.1650000,1.2414551,0.0000000,169.9639893); //
		CreateDynamicObject(18751,-4380.3862305,-2821.5979004,-8.1650000,1.2414551,0.0000000,179.9639893); //
		CreateDynamicObject(4241,-4655.3671875,-2147.3544922,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-4655.3671875,-2345.8535156,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-4655.3671875,-2544.3066406,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-4655.3671875,-2742.7480469,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-4655.3671875,-2941.2304688,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-4655.3671875,-3139.6708984,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-4655.3671875,-3338.0927734,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-4655.3671875,-3536.5820312,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-4655.3671875,-3735.0576172,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(4241,-4655.3671875,-3933.5654297,-13.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1725,-3412.3759766,-3716.9431152,13.4420004,0.0000000,8.5000000,350.0000000); //
		CreateDynamicObject(2370,-3411.5371094,-3718.3359375,13.2209997,358.5155334,351.7472839,175.7847290); //
		CreateDynamicObject(2724,-3411.5778809,-3720.1450195,13.6610003,0.0000000,98.0000000,260.0000000); //
		CreateDynamicObject(2346,-3411.8601074,-3722.0170898,14.5389996,359.1871033,113.9869385,352.1726685); //
		CreateDynamicObject(2764,-3411.4240723,-3717.2299805,13.8420000,0.0000000,8.0000000,0.0000000); //
		CreateDynamicObject(1764,-3410.9169922,-3718.7370605,13.9840002,0.0000000,278.2500000,0.0000000); //
		CreateDynamicObject(1737,-3411.1840820,-3715.4570312,15.6940002,359.2397766,115.7395325,358.4237061); //
		CreateDynamicObject(18888,-4311.5600586,-2902.8120117,8.0279999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18888,-4310.0410156,-2902.8120117,8.0279999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18888,-4308.5717773,-2902.8120117,8.0279999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(18888,-4306.7290039,-2902.8120117,8.0279999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(2096,-3412.0568848,-3720.7949219,13.4049997,0.0000000,0.0000000,289.9896240); //
		CreateDynamicObject(655,-3876.4760742,-3251.9318848,9.5080004,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(655,-4300.9228516,-2882.3039551,6.7259998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(759,-4312.2260742,-2924.2949219,4.6430001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(3920,-4157.1962891,-2815.7802734,1.0510000,0.0000000,0.0000000,349.9969482); //
		CreateDynamicObject(639,-3917.1311035,-2417.3469238,12.5570002,358.2501526,0.7503357,350.0213013); //
		CreateDynamicObject(639,-3903.2939453,-2409.7648926,18.9570007,0.0000000,0.0000000,349.9969482); //
		CreateDynamicObject(639,-3902.8139648,-2407.3139648,18.9570007,0.0000000,0.0000000,349.9969482); //
		CreateDynamicObject(814,-4201.6279297,-2551.9169922,0.0000000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(814,-3917.8889160,-2417.8911133,4.4359999,61.5000000,0.0000000,10.0000000); //
		CreateDynamicObject(14400,-4179.0800781,-2566.8525391,0.2360000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(14400,-3892.2250977,-2421.0969238,11.3190002,62.4249268,298.5174255,58.4924927); //
		CreateDynamicObject(726,-3804.5800781,-2507.2670898,0.1910000,0.0000000,0.0000000,239.9853516); //
		CreateDynamicObject(726,-3816.6240234,-2519.7041016,-15.9440002,0.0000000,0.0000000,239.9853516); //
		CreateDynamicObject(619,-3574.1608887,-2368.8869629,-0.8300000,0.0000000,0.0000000,79.9981689); //
		CreateDynamicObject(619,-3559.6540527,-2412.9619141,6.1700001,310.0416260,87.6183472,116.8873291); //
		CreateDynamicObject(671,-3595.3640137,-2382.6721191,0.6390000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(729,-3755.2661133,-2462.6159668,0.6320000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(729,-3754.1210938,-2475.5778809,11.2840004,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(729,-3544.6320801,-2313.6000977,-1.0800000,0.0000000,0.0000000,70.0000000); //
		CreateDynamicObject(729,-3543.4902344,-2318.2001953,22.8519993,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(1642,-3775.5139160,-3149.1508789,6.6659999,349.2525940,358.7276917,359.7626953); //
		CreateDynamicObject(2032,-3810.3159180,-3176.2390137,6.0450001,0.2492371,4.5000305,349.9803772); //
		CreateDynamicObject(2636,-3809.8249512,-3175.8920898,6.6199999,0.0000000,0.0000000,90.0000000); //
		CreateDynamicObject(2636,-3810.7800293,-3176.1040039,6.6199999,0.0000000,0.0000000,160.0000000); //
		CreateDynamicObject(2636,-3810.1650391,-3176.9760742,6.5450001,0.0000000,0.0000000,269.9993896); //
		CreateDynamicObject(2849,-3809.5339355,-3176.3779297,6.8039999,359.7524414,8.0000000,0.0347900); //
		CreateDynamicObject(789,-3868.5891113,-3193.8110352,19.5289993,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(843,-3816.4040527,-3166.2890625,4.4889998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(844,-3812.7639160,-3155.4240723,5.5190001,353.0016785,1.2593689,90.1535034); //
		CreateDynamicObject(758,-4390.4018555,-3178.3259277,3.2449999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(899,-4452.6518555,-3240.3989258,0.7400000,13.6691895,353.0170288,357.6282959); //
		CreateDynamicObject(16120,-3842.3037109,-3611.4121094,-12.8100004,0.0000000,0.0000000,129.9792480); //
		CreateDynamicObject(899,-4450.2587891,-3253.7189941,0.4900000,12.9935608,356.6249695,356.7279053); //
		CreateDynamicObject(16120,-4450.9150391,-3273.3378906,-2.2500000,0.0000000,0.0000000,259.9768066); //
		CreateDynamicObject(16120,-4480.9667969,-3279.1999512,-2.2500000,0.0000000,0.0000000,229.9749756); //
		CreateDynamicObject(16120,-4519.6230469,-3274.8720703,-2.2500000,0.0000000,0.0000000,249.9713135); //
		CreateDynamicObject(16120,-4519.6230469,-3274.8720703,-2.2500000,0.0000000,0.0000000,249.9664307); //
		CreateDynamicObject(16120,-4547.8471680,-3266.5869141,-2.2500000,0.0000000,0.0000000,179.9664307); //
		CreateDynamicObject(16120,-4560.3217773,-3232.8110352,-2.2500000,0.0000000,0.0000000,149.9615173); //
		CreateDynamicObject(16120,-4547.5019531,-3195.4970703,-2.2500000,0.0000000,0.0000000,109.9578857); //
		CreateDynamicObject(16120,-4497.9418945,-3168.9670410,-2.2500000,0.0000000,0.0000000,39.9566650); //
		CreateDynamicObject(16120,-4523.4331055,-3167.1330566,-2.2500000,0.0000000,0.0000000,69.9517822); //
		CreateDynamicObject(11442,-4450.5947266,-3236.2119141,6.4299998,0.0000000,0.0000000,270.0000000); //
		CreateDynamicObject(899,-4453.3217773,-3243.9360352,0.7150000,13.6669922,353.0126953,317.6269531); //
		CreateDynamicObject(899,-4439.2368164,-3238.4089355,0.6150000,13.6614990,353.0126953,31.6257324); //
		CreateDynamicObject(11428,-4493.1357422,-3274.2460938,10.7279997,0.0000000,0.0000000,285.9960938); //
		CreateDynamicObject(899,-4540.0996094,-3273.2216797,18.2250004,13.6614990,353.0126953,17.6220703); //
		CreateDynamicObject(899,-4474.1118164,-3273.7119141,-3.1600001,16.6389160,352.9132080,18.0028076); //
		CreateDynamicObject(899,-4473.1079102,-3275.7209473,-3.0350001,14.4058228,352.9850769,17.7143860); //
		CreateDynamicObject(18751,-4440.7290039,-3226.9489746,-8.9899998,1.2414551,0.0000000,149.9633789); //
		CreateDynamicObject(18751,-4445.0908203,-3232.2607422,-8.9899998,1.2414551,0.0000000,149.9633789); //
		CreateDynamicObject(18751,-4446.4321289,-3255.5849609,-8.9899998,1.2414551,0.0000000,149.9633789); //
		CreateDynamicObject(18751,-4467.1821289,-3270.3679199,-8.9899998,1.2414551,0.0000000,149.9633789); //
		CreateDynamicObject(18751,-4480.1503906,-3216.5371094,-9.4650002,1.2414551,0.0000000,149.9633789); //
		CreateDynamicObject(18751,-4498.2338867,-3244.8349609,-9.4650002,1.2414551,0.0000000,149.9633789); //
		CreateDynamicObject(18751,-4499.0488281,-3181.3510742,-9.4650002,1.2414551,0.0000000,149.9633789); //
		CreateDynamicObject(18751,-4532.0371094,-3219.0681152,-9.4650002,1.2414551,0.0000000,149.9633789); //
		CreateDynamicObject(18751,-4545.2797852,-3262.2519531,-9.4650002,1.2414551,0.0000000,149.9633789); //
		CreateDynamicObject(18751,-4494.8017578,-3284.1088867,-9.9650002,1.2414551,0.0000000,149.9633789); //
		CreateDynamicObject(18751,-4578.5351562,-3244.1201172,-10.9650002,1.2414551,0.0000000,149.9633789); //
		CreateDynamicObject(18751,-4551.5927734,-3215.8500977,-9.2399998,1.2414551,0.0000000,119.9633789); //
		CreateDynamicObject(899,-4460.5732422,-3269.0390625,-3.6350000,19.6105957,352.7819824,18.3911133); //
		CreateDynamicObject(899,-4470.0532227,-3263.7609863,-5.3099999,19.6105957,352.7819824,18.3911133); //
		CreateDynamicObject(899,-4437.2270508,-3225.1899414,8.7399998,329.5349121,225.5383301,283.2916260); //
		CreateDynamicObject(899,-4436.2167969,-3234.5039062,18.2649994,320.6964111,166.9702148,247.6318359); //
		CreateDynamicObject(758,-4398.2910156,-3159.3640137,4.7579999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(758,-4416.0332031,-3136.5690918,5.5850000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(744,-4392.0615234,-3157.5410156,3.3310001,0.0000000,0.0000000,90.0000000); //
		CreateDynamicObject(3920,-4168.6689453,-2813.8115234,1.0510000,0.0000000,0.0000000,349.9914551); //
		CreateDynamicObject(3920,-4435.9208984,-3157.3391113,-0.7750000,0.0000000,0.0000000,213.9862061); //
		CreateDynamicObject(3920,-4430.3872070,-3153.4550781,-0.7750000,0.0000000,0.0000000,213.9862061); //
		CreateDynamicObject(899,-4490.5917969,-3271.6660156,0.7400000,13.6614990,353.0126953,17.6220703); //
		CreateDynamicObject(899,-4521.4482422,-3263.6718750,-2.8850000,13.6560059,353.0126953,17.6220703); //
		CreateDynamicObject(899,-4541.3613281,-3253.9072266,1.1650000,83.2049561,272.0159912,93.9331055); //
		CreateDynamicObject(899,-4548.2001953,-3258.5500488,13.1650000,43.8500366,189.4371338,179.3947754); //
		CreateDynamicObject(899,-4536.0273438,-3266.9228516,-2.5850000,13.6560059,353.0126953,17.6220703); //
		CreateDynamicObject(899,-4525.0761719,-3249.4409180,-2.0599999,13.6614990,353.0126953,17.6220703); //
		CreateDynamicObject(899,-4544.2998047,-3242.1899414,-2.0599999,13.6614990,353.0126953,287.6220703); //
		CreateDynamicObject(899,-4554.0976562,-3239.7480469,-2.9349999,19.6051025,352.7874756,288.3856201); //
		CreateDynamicObject(899,-4556.8701172,-3222.5634766,-2.9349999,19.5996094,352.7874756,288.3856201); //
		CreateDynamicObject(899,-4514.2348633,-3259.1550293,-2.7100000,19.6051025,352.7874756,288.3856201); //
		CreateDynamicObject(899,-4502.8632812,-3262.3935547,-1.3850000,19.5996094,352.7874756,328.3813477); //
		CreateDynamicObject(899,-4499.1982422,-3192.8420410,3.3650000,296.5656738,344.6647339,172.1693115); //
		CreateDynamicObject(899,-4494.3115234,-3182.3662109,-2.9349999,19.5996094,352.7874756,288.3856201); //
		CreateDynamicObject(899,-4504.1640625,-3182.2739258,9.1650000,25.5552368,324.2695312,299.1947021); //
		CreateDynamicObject(9831,-4502.5952148,-3201.9089355,-14.1250000,293.4964294,0.0000000,178.2482910); //
		CreateDynamicObject(9831,-4503.4121094,-3206.0920410,-14.1250000,282.5059204,180.0000000,178.2476807); //
		CreateDynamicObject(18747,-4503.2822266,-3199.9641113,-0.9500000,0.0000000,0.0000000,0.2471924); //
		CreateDynamicObject(18747,-4499.9628906,-3200.9829102,-0.9500000,0.0000000,0.0000000,0.2471924); //
		CreateDynamicObject(18747,-4505.5971680,-3201.0070801,-0.9500000,0.0000000,0.0000000,0.2471924); //
		CreateDynamicObject(18747,-4501.8891602,-3202.2729492,-0.9500000,0.0000000,0.0000000,0.2471924); //
		CreateDynamicObject(18747,-4497.8388672,-3201.5070801,-0.9500000,0.0000000,0.0000000,0.2471924); //
		CreateDynamicObject(18747,-4506.8168945,-3200.9140625,-0.9500000,0.0000000,0.0000000,0.2471924); //
		CreateDynamicObject(899,-4517.2119141,-3180.4809570,-2.9349999,19.6051025,352.7874756,288.3856201); //
		CreateDynamicObject(899,-4512.5429688,-3179.4829102,3.0650001,19.6051025,352.7874756,288.3856201); //
		CreateDynamicObject(899,-4523.3701172,-3184.0449219,-0.4350000,19.6051025,352.7874756,288.3856201); //
		CreateDynamicObject(899,-4505.8901367,-3178.2419434,7.0650001,19.6051025,352.7874756,288.3856201); //
		CreateDynamicObject(899,-4493.8378906,-3180.6188965,2.7400000,19.5996094,352.7874756,288.3856201); //
		CreateDynamicObject(899,-4480.2631836,-3178.8549805,4.4150000,19.5996094,352.7874756,288.3856201); //
		CreateDynamicObject(899,-4490.0571289,-3180.9870605,3.1150000,19.5996094,352.7874756,288.3856201); //
		CreateDynamicObject(899,-4491.6220703,-3182.4221191,3.6650000,13.1492615,353.0236206,197.5493164); //
		CreateDynamicObject(899,-4483.5839844,-3180.3410645,3.7149999,13.1451416,353.0181885,197.5451660); //
		CreateDynamicObject(899,-4483.9409180,-3174.7680664,4.2649999,10.1671448,353.0930176,197.1749115); //
		CreateDynamicObject(6964,-4488.6079102,-3181.9318848,9.3230000,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(899,-4480.7929688,-3180.3129883,3.1150000,53.1990356,348.6125488,275.1160889); //
		CreateDynamicObject(899,-4485.0888672,-3187.6860352,-1.6350000,82.3711853,332.2296448,233.5097656); //
		CreateDynamicObject(899,-4521.6347656,-3197.4062500,-2.5100000,14.0460205,9.7503662,299.5587158); //
		CreateDynamicObject(899,-4530.3837891,-3190.9619141,-1.5350000,14.0515137,9.7503662,299.5642090); //
		CreateDynamicObject(744,-4535.4692383,-3189.0649414,15.8369999,65.3045044,76.7876587,324.4881287); //
		CreateDynamicObject(744,-4524.0546875,-3196.0722656,2.0680001,0.0000000,0.0000000,90.0000000); //
		CreateDynamicObject(11458,-4475.0849609,-3238.9489746,-5.5790000,0.0000000,0.0000000,270.0000000); //
		CreateDynamicObject(899,-4490.7597656,-3232.0500488,-12.1599998,18.8170166,341.6973877,332.0402527); //
		CreateDynamicObject(11441,-4515.3710938,-3230.9060059,-6.0990000,0.0000000,0.0000000,280.0000000); //
		CreateDynamicObject(11441,-4543.8569336,-3242.3120117,3.4150000,0.0000000,0.0000000,20.0000000); //
		CreateDynamicObject(11442,-4506.3740234,-3266.0595703,2.8369999,0.0000000,0.0000000,86.4953613); //
		CreateDynamicObject(11442,-4515.6850586,-3265.6010742,2.3030000,0.0000000,0.0000000,265.7493896); //
		CreateDynamicObject(899,-4521.4692383,-3276.4650879,-3.1600001,13.6560059,353.0126953,17.6220703); //
		CreateDynamicObject(744,-4416.2299805,-3159.1398926,22.4570007,0.0000000,0.0000000,90.0000000); //
		CreateDynamicObject(899,-4534.7197266,-3262.6816406,18.2900009,11.2225342,342.4383545,211.4813232); //
		CreateDynamicObject(899,-4525.2275391,-3273.5605469,9.5400000,78.1237793,215.0848389,51.4544678); //
		CreateDynamicObject(899,-4541.3618164,-3272.2399902,13.8999996,82.8529358,288.1776123,197.6535034); //
		CreateDynamicObject(899,-4546.5869141,-3266.0869141,-6.5400000,17.1923523,314.6686401,320.6047363); //
		CreateDynamicObject(899,-4549.9687500,-3259.0634766,-6.4899998,17.1881104,314.6649170,320.6030273); //
		CreateDynamicObject(744,-4505.2348633,-3191.2561035,13.8160000,358.2500610,359.4997559,151.9847412); //
		CreateDynamicObject(744,-4504.4941406,-3189.9919434,13.7159996,358.2476807,359.4946289,221.9793701); //
		CreateDynamicObject(2345,-4497.0439453,-3194.8449707,17.4249992,0.0000000,0.0000000,358.7500000); //
		CreateDynamicObject(899,-4552.9877930,-3209.3989258,-6.2600002,10.1083984,9.6063843,300.2517700); //
		CreateDynamicObject(899,-4546.4321289,-3204.2490234,-6.5100002,14.6734009,5.8945618,320.4533081); //
		CreateDynamicObject(899,-4557.3828125,-3228.1181641,-2.6099999,18.9239502,354.9298096,287.6000977); //
		CreateDynamicObject(899,-4540.0390625,-3227.6970215,-2.5350001,348.5337830,355.1065979,314.9768677); //
		CreateDynamicObject(899,-4483.1660156,-3169.4160156,19.3899994,315.8875732,220.8034668,72.9774780); //
		CreateDynamicObject(899,-4497.2539062,-3168.3659668,19.3899994,315.8843994,220.8032227,42.9766846); //
		CreateDynamicObject(899,-4490.8452148,-3178.4079590,32.2400017,338.4846191,192.8872070,86.7714233); //
		CreateDynamicObject(899,-4498.3808594,-3172.7270508,8.4899998,298.1424561,127.3498230,38.8495789); //
		CreateDynamicObject(899,-4469.2290039,-3176.0668945,23.4899998,357.0123901,222.0452423,60.6644592); //
		CreateDynamicObject(899,-4456.6840820,-3183.7539062,23.4899998,357.0117188,222.0446777,68.6610107); //
		CreateDynamicObject(899,-4447.8691406,-3193.2561035,23.4899998,357.0062256,222.0391846,48.6590576); //
		CreateDynamicObject(899,-4442.1372070,-3207.1818848,22.5149994,357.2015076,226.0395050,26.8606567); //
		CreateDynamicObject(899,-4438.2177734,-3217.3085938,19.3400002,24.0985107,242.3638916,27.9931641); //
		CreateDynamicObject(899,-4472.3530273,-3181.7871094,33.7400017,3.8855286,191.9965820,93.1380310); //
		CreateDynamicObject(899,-4462.3720703,-3196.0349121,33.7400017,3.8836670,191.9915771,63.1365967); //
		CreateDynamicObject(899,-4451.7089844,-3208.0771484,32.2400017,354.3420410,192.0135498,35.1562500); //
		CreateDynamicObject(9831,-4502.0019531,-3194.1398926,0.8780000,282.0000000,0.0000000,178.0000000); //
		CreateDynamicObject(9831,-4502.0058594,-3198.0170898,0.8780000,271.8171387,344.0256348,342.0281982); //
		CreateDynamicObject(899,-4497.6411133,-3183.8769531,36.2400017,349.9862061,177.9436646,111.6156311); //
		CreateDynamicObject(899,-4484.4379883,-3186.6970215,37.0900002,352.1029663,169.8743286,110.5683899); //
		CreateDynamicObject(899,-4474.7490234,-3183.3278809,35.4650002,358.0083313,169.9616089,111.6204224); //
		CreateDynamicObject(899,-4501.8442383,-3177.8159180,30.2399998,8.4537354,212.3651123,106.6510315); //
		CreateDynamicObject(899,-4508.9531250,-3170.9130859,22.9899998,19.1715698,196.9320679,126.2592468); //
		CreateDynamicObject(899,-4492.3989258,-3166.1508789,10.1049995,36.9472656,141.2236328,205.7374725); //
		CreateDynamicObject(899,-4437.9619141,-3247.9960938,18.2399998,305.0121460,162.3040161,250.3214722); //
		CreateDynamicObject(899,-4442.8188477,-3263.2460938,16.5400009,305.0079346,162.3010254,220.3179932); //
		CreateDynamicObject(899,-4451.3427734,-3271.4208984,15.7900000,307.7246704,149.5831299,184.0597534); //
		CreateDynamicObject(899,-4459.9711914,-3275.6420898,15.5150003,314.6975098,141.3692017,149.3728638); //
		CreateDynamicObject(899,-4472.6020508,-3279.7338867,14.4899998,314.6923828,141.3665771,149.3701172); //
		CreateDynamicObject(899,-4481.4179688,-3279.2170410,14.4899998,298.3839111,112.5303650,114.2191162); //
		CreateDynamicObject(899,-4502.5898438,-3278.3491211,14.4899998,298.3831787,112.5274658,104.2138672); //
		CreateDynamicObject(899,-4515.1450195,-3274.4670410,12.2399998,305.2467041,84.2357178,79.9300842); //
		CreateDynamicObject(899,-4517.8969727,-3273.4370117,12.2399998,305.2441406,84.2321777,77.9255371); //
		CreateDynamicObject(899,-4518.0058594,-3170.7080078,20.2399998,40.0140991,201.0468140,168.0663452); //
		CreateDynamicObject(899,-4530.4560547,-3179.7370605,20.2399998,40.0122070,201.0443115,188.0633545); //
		CreateDynamicObject(899,-4536.6098633,-3184.0620117,4.9400001,63.0256042,217.3178253,187.7572937); //
		CreateDynamicObject(899,-4538.7802734,-3189.2050781,16.6149998,61.4080811,215.0683594,188.2891846); //
		CreateDynamicObject(899,-4547.0649414,-3199.4499512,16.6149998,61.4080811,215.0683594,194.2891846); //
		CreateDynamicObject(899,-4554.5532227,-3212.0510254,16.7399998,303.4321289,47.4850159,272.2430725); //
		CreateDynamicObject(899,-4548.7490234,-3203.9521484,3.0899999,296.6638184,258.0084229,186.5643311); //
		CreateDynamicObject(899,-4559.9150391,-3222.0849609,19.9650002,290.5059814,209.8388672,128.1994629); //
		CreateDynamicObject(899,-4559.5839844,-3232.1289062,14.9650002,290.5059814,209.8388672,128.1994629); //
		CreateDynamicObject(899,-4558.8520508,-3245.2280273,14.7900000,281.6917419,300.6706238,251.1523590); //
		CreateDynamicObject(899,-4530.2260742,-3174.5371094,17.2700005,300.2795410,276.9205322,333.9503174); //
		CreateDynamicObject(9831,-4505.7221680,-3200.1330566,-14.9219999,290.2209473,56.4965820,152.2974854); //
		CreateDynamicObject(9831,-4500.7412109,-3199.5490723,-14.4720001,286.4157715,293.6755676,202.5599365); //
		CreateDynamicObject(11428,-4497.6220703,-3236.0920410,-0.7040000,0.0000000,0.0000000,285.9960938); //
		CreateDynamicObject(11428,-4495.1000977,-3231.5329590,-5.4540000,0.0000000,0.0000000,105.9906006); //
		CreateDynamicObject(899,-4535.2270508,-3269.5449219,-2.4600000,12.1670837,353.0544128,17.4354248); //
		CreateDynamicObject(744,-4491.8750000,-3200.5595703,-7.3829999,0.0000000,0.0000000,69.9993896); //
		CreateDynamicObject(805,-4290.2617188,-2913.3046875,6.0720000,9.9975586,0.0000000,0.0000000); //
		CreateDynamicObject(801,-4311.3847656,-2932.1201172,4.7480001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(801,-4455.8759766,-3238.6960449,6.1910000,0.0000000,0.0000000,290.0000000); //
		CreateDynamicObject(801,-4491.3178711,-3190.1889648,10.4250002,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(814,-4312.2695312,-2932.1250000,7.0799999,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(823,-4315.2578125,-2930.5166016,7.1529999,359.2639160,11.9970703,0.1538086); //
		CreateDynamicObject(801,-4530.7041016,-3187.2470703,15.2329998,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(728,-3984.2304688,-2680.3945312,5.3610001,0.0000000,0.0000000,0.0000000); //
		CreateDynamicObject(728,-4544.5620117,-3211.3359375,12.6929998,8.2452393,359.2419434,20.1043701); //
		CreateDynamicObject(728,-4497.2841797,-3237.0878906,-3.3380001,8.2452393,359.2419434,20.0994873); //
		CreateDynamicObject(728,-4497.1220703,-3194.7399902,10.1800003,1.7876282,37.2709656,258.6308594); //
		CreateDynamicObject(728,-4496.2329102,-3193.8190918,15.6549997,1.7852783,37.2656250,298.6291504); //
		CreateDynamicObject(899,-4444.8129883,-3228.2548828,30.5900002,16.8321228,213.5839996,19.0574036); //
		CreateDynamicObject(899,-4448.0830078,-3246.5830078,30.5900002,330.0540161,217.6597290,321.0062866); //
		CreateDynamicObject(899,-4458.0708008,-3263.6030273,28.0900002,330.0512695,217.6556396,281.0040283); //
		CreateDynamicObject(899,-4475.4350586,-3269.0939941,28.0900002,330.0457764,217.6501465,251.0028076); //
		CreateDynamicObject(899,-4491.9648438,-3272.8669434,28.0900002,330.0457764,217.6501465,254.9991455); //
		CreateDynamicObject(899,-4503.1372070,-3270.8491211,28.0900002,330.0457764,217.6501465,244.9981689); //
		CreateDynamicObject(899,-4520.4282227,-3266.1621094,28.0900002,330.0457764,217.6501465,224.9951172); //
		CreateDynamicObject(899,-4536.9560547,-3257.5959473,28.0900002,330.0457764,217.6501465,194.9945068); //
		CreateDynamicObject(899,-4550.6572266,-3244.3269043,28.0900002,330.0457764,217.6501465,194.9908447); //
		CreateDynamicObject(899,-4501.6362305,-3277.6520996,24.5200005,50.4011841,296.4632568,71.0947876); //
		CreateDynamicObject(16112,-4444.8188477,-3263.0400391,20.3299999,56.0000000,0.0000000,51.9775391); //
		CreateDynamicObject(899,-4435.7631836,-3239.2790527,24.2649994,303.4157104,18.4688416,251.5486603); //
		CreateDynamicObject(899,-4425.7011719,-3234.5129395,15.2650003,303.4149170,18.4680176,281.5484619); //
		CreateDynamicObject(899,-4420.2597656,-3239.7089844,6.7649999,303.4149170,18.4625244,281.5466309); //
		CreateDynamicObject(899,-4410.6230469,-3238.9289551,-9.0349998,303.4149170,18.4625244,281.5466309); //
		CreateDynamicObject(899,-4423.3750000,-3222.4641113,5.4850001,303.4149170,18.4625244,331.5466309); //
		CreateDynamicObject(18751,-4370.7578125,-3168.4560547,-9.7399998,1.2414551,0.0000000,149.9688721); //
		CreateDynamicObject(18751,-4397.6821289,-3130.6210938,-9.7399998,1.2414551,0.0000000,119.9688721); //
		CreateDynamicObject(18751,-4437.8540039,-3120.2880859,-9.7399998,1.2414551,0.0000000,79.9652100); //
		CreateDynamicObject(899,-4456.7729492,-3131.0180664,-9.4359999,338.0018005,177.8260498,119.1613159); //
		CreateDynamicObject(18751,-4458.1689453,-3158.7919922,-9.7399998,1.2414551,0.0000000,79.9639893); //
		CreateDynamicObject(18751,-4500.3828125,-3163.3940430,-6.9899998,1.2414551,0.0000000,359.9639893); //
		CreateDynamicObject(18751,-4530.4912109,-3189.7128906,-6.9899998,1.2414551,0.0000000,309.9615479); //
		CreateDynamicObject(16122,-3366.1552734,-3691.6777344,-5.5000000,0.0000000,0.0000000,17.9956055); //
		CreateDynamicObject(18751,-4258.2558594,-3233.9279785,-4.7100000,1.2414551,0.0000000,129.9633789); //
		CreateDynamicObject(899,-4555.3701172,-3231.3640137,27.9650002,290.5059814,209.8388672,128.1994629); //
		CreateDynamicObject(899,-4551.9409180,-3212.9089355,28.7150002,309.0840759,196.0492096,92.5397339); //
		CreateDynamicObject(899,-4540.5771484,-3200.5949707,28.7150002,309.0838623,196.0455322,82.5378418); //
		CreateDynamicObject(899,-4531.8559570,-3187.5310059,28.7150002,320.3923950,229.7737427,126.9591980); //
		CreateDynamicObject(899,-4517.5380859,-3182.4489746,32.2150002,327.2145996,224.3980713,87.8845215); //
		CreateDynamicObject(899,-4474.7797852,-3204.1459961,37.2400017,352.2584534,186.0091248,34.7667236); //
		CreateDynamicObject(899,-4492.3378906,-3199.2019043,38.4900017,352.2546387,186.0040283,34.7662354); //
		CreateDynamicObject(899,-4508.9047852,-3187.8840332,38.4900017,352.2546387,186.0040283,104.7662354); //
		CreateDynamicObject(899,-4523.9609375,-3190.9040527,38.7400017,352.2491455,186.0040283,124.7656250); //
		CreateDynamicObject(899,-4532.3061523,-3209.7548828,38.7400017,352.2491455,186.0040283,154.7607422); //
		CreateDynamicObject(899,-4543.0678711,-3217.9838867,36.9900017,352.2491455,186.0040283,154.7589111); //
		CreateDynamicObject(899,-4551.7138672,-3231.1840820,35.1899986,332.3694458,186.7180939,157.0731201); //
		CreateDynamicObject(899,-4541.0551758,-3240.2438965,38.1899986,346.2855835,173.7657471,152.4636230); //
		CreateDynamicObject(899,-4530.6210938,-3250.1240234,38.6899986,351.4519653,166.2884521,151.8697510); //
		CreateDynamicObject(899,-4514.3530273,-3248.1420898,38.6899986,341.7428589,165.7053223,149.3845215); //
		CreateDynamicObject(899,-4528.1337891,-3234.0720215,42.6899986,357.2756958,166.4196777,153.2890015); //
		CreateDynamicObject(899,-4532.1030273,-3227.8039551,42.7150002,17.0055542,188.8195343,151.3466797); //
		CreateDynamicObject(899,-4518.7910156,-3211.6530762,41.3400002,354.9571228,175.6615601,153.5566406); //
		CreateDynamicObject(899,-4518.9658203,-3229.6640625,41.2150002,355.1952515,182.4332275,284.1412354); //
		CreateDynamicObject(899,-4502.2329102,-3205.5568848,42.0900002,354.9517822,175.6604004,193.5559082); //
		CreateDynamicObject(899,-4504.0610352,-3221.7280273,43.5900002,354.9462891,175.6604004,193.5516357); //
		CreateDynamicObject(899,-4485.9580078,-3218.3959961,42.0900002,355.0307312,168.6339722,192.9370575); //
		CreateDynamicObject(899,-4463.8618164,-3223.4899902,39.0900002,355.0286865,168.6291504,172.9364014); //
		CreateDynamicObject(899,-4461.4589844,-3240.1049805,39.0900002,357.2291260,168.6536255,153.3800049); //
		CreateDynamicObject(899,-4473.7578125,-3235.3979492,41.0900002,357.2259521,168.6511230,153.3746338); //
		CreateDynamicObject(899,-4470.9189453,-3251.0371094,39.8400002,349.2182007,174.5684204,152.9121094); //
		CreateDynamicObject(899,-4493.2177734,-3255.8469238,39.0900002,349.2169189,174.5672607,172.9077148); //
		CreateDynamicObject(899,-4495.5791016,-3237.1550293,42.5900002,349.2169189,174.5617676,172.9028320); //
		CreateDynamicObject(11458,-4448.9501953,-3251.2380371,5.8520002,0.0000000,0.0000000,260.0000000); //
		CreateDynamicObject(11446,-4542.5981445,-3235.9230957,3.5680001,0.0000000,0.0000000,110.0000000); //
		CreateDynamicObject(899,-4558.6118164,-3223.2050781,-1.6100000,18.9783630,2.3312988,285.1933594); //
		CreateDynamicObject(11442,-4550.4838867,-3219.6760254,4.2810001,0.0000000,0.0000000,20.0000000); //

	/*
	Objects converted: 1967
	Vehicles converted: 0
	Vehicle models found: 0
	----------------------
	In the time this conversion took to finish the US national debt has risen by about $11,646.51!
	*/

	return 1;
}

public OnGameModeExit()
{
	SaveAllVentes();
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	return 0;
}

public OnPlayerConnect(playerid)
{
	new string[256];
	if(fexist(UserPath(playerid))) INI_ParseFile(UserPath(playerid), "LoadUser_%s", .bExtra = true, .extra = playerid);
	LoginTDShowed[playerid] = false;
	InventoryTDShowed[playerid] = false;
	IsGuest[playerid] = false;
	IsRegistered[playerid] = false;
	IsLogged[playerid] = false;
	IsObjectReceived[playerid] = false;
	PlayerPlaySound(playerid,1068,0,0,0);
	CreateObjectReceivedTD(playerid);
	CreateLoginTD(playerid);
	ShowLoginTD(playerid);
	CreateInventoryTD(playerid);
	CreateTDBesoins(playerid);
	format(string,sizeof(string),"{0000ff}[New] {ffffff}%s{0000ff} a rejoint le monde des vivants !",GetName(playerid));
	SendClientMessage(playerid,bleu,string);
	CreateTDHDV(playerid);
	CreateTD(playerid);
	new ip[64];
	GetPlayerIp(playerid, ip,sizeof(ip));
	format(string,sizeof(string),"check.getipintel.net/check.php?ip=%s&contact=dimjhonny@gmail.com",ip);
	HTTP(playerid, HTTP_GET,string,"","UpdateResponse");
	for(new i; i < 3; i++)
	{
		PlayerTextDrawShow(playerid,InventObjet[playerid][i]);
		if(i == 0) PlayerTextDrawShow(playerid,SecInventObjet[playerid][i][i]);
	}
	TextDrawShowForPlayer(playerid,txt);
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	new string[256];
	SavePlayer(playerid);
	if(reason != 2)
	{
	    format(string,sizeof(string),"{ff0000}[Quit] {ffffff}%s {ff0000}n'est plus de ce monde , adieu !",GetName(playerid));
	    SendClientMessageToAll(0,string);
	}
	return 1;
}

public OnPlayerSpawn(playerid)
{
	PlayerPlaySound(playerid,1069,0,0,0);
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
	if(IsLogged[playerid] == false)
	{
		SendClientMessage(playerid,rouge,"Vous devez vous connecter / enregistrer avant de pouvoir parler !");
		return 0;
	}
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	new cmd[256+1];
	new idx;
	cmd = strtok(cmdtext, idx);
	if(IsLogged[playerid] == false) return SendClientMessage(playerid,rouge,"Vous devez être connecté ou enregistré pour utiliser des commandes !");
	printf("[CMD] %s : %s",GetName(playerid),cmdtext);
	if(strcmp(cmd,"/reboot",true)==0)
	{
	    if(PlayerInfo[playerid][pAdmin] < 4) return NotRankedEnough(playerid);
	    new tmp[256],string[256],value;
	    tmp = strtok(cmdtext,idx);
	    if(!strlen(tmp))
	    {
			Reboot();
			return 1;
		}
		value = strval(tmp);
		format(string,sizeof(string),"[Reboot] Le serveur redémarrera dans {ffffff}%d {4E8EB9}minute(s).",value);
		SendClientMessageToAll(ADMIN_COLOR,string);
		treboot = SetTimer("Reboot",value * 60000,false);
		return 1;
	}
	if(strcmp(cmdtext,"/hdv",true)==0)
	{
	    ShowHDV(playerid);
	    return 1;
	}
	if(!strcmp("/network",cmdtext,true))
	{
	    new str[400+1];
	    GetPlayerNetworkStats(playerid,str,sizeof(str));
	    ShowPlayerDialog(playerid, 400, DIALOG_STYLE_MSGBOX,"Network stats",str,"Ok","");
	    return 1;
	}
	if (!strcmp("/for", cmdtext, true)) // Ici on peut raccourcir la vérification de l'égalité : strcmp("clear",cmdtext,true) == 0 par !strcmp("clear",cmdtext,true)
	{
	    new count = GetTickCount();
		if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, 0, "{ff0000}Tu n'es pas admin !"); // Si le joueur n'est pas admin alors ça lui retourne ce message
		for(new i; i < 3000; i++) SendClientMessageToAll(0, " ");
		SendClientMessageToAll(0, "{00FF00}Le chat a été nettoyé !");
		printf("Boucle for : %d ms",GetTickCount() - count);
		return 1;
	}
	if (!strcmp("/dowhile", cmdtext, true)) // Ici on peut raccourcir la vérification de l'égalité : strcmp("clear",cmdtext,true) == 0 par !strcmp("clear",cmdtext,true)
	{
	    new count = GetTickCount();
		if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, 0, "{ff0000}Tu n'es pas admin !"); // Si le joueur n'est pas admin alors ça lui retourne ce message
		new i = 0;
		do
		{
			i++;
			SendClientMessageToAll(0, " ");
		}
		while(i < 3000);
		SendClientMessageToAll(0, "{00FF00}Le chat a été nettoyé !");
		printf("Boucle do..while : %d ms",GetTickCount() - count);
		return 1;
	}
	if (!strcmp("/while", cmdtext, true)) // Ici on peut raccourcir la vérification de l'égalité : strcmp("clear",cmdtext,true) == 0 par !strcmp("clear",cmdtext,true)
	{
	    new count = GetTickCount();
		if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, 0, "{ff0000}Tu n'es pas admin !"); // Si le joueur n'est pas admin alors ça lui retourne ce message
		new i = 0;
		while(i < 3000)
		{
			i++;
			SendClientMessageToAll(0, " ");
		}
		SendClientMessageToAll(0, "{00FF00}Le chat a été nettoyé !");
		printf("While :  %d ms",GetTickCount() - count);
		return 1;
	}
	if (!strcmp("/goto", cmdtext, true)) // Ici on peut raccourcir la vérification de l'égalité : strcmp("clear",cmdtext,true) == 0 par !strcmp("clear",cmdtext,true)
	{
	    
	    new count = GetTickCount();
		if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, 0, "{ff0000}Tu n'es pas admin !"); // Si le joueur n'est pas admin alors ça lui retourne ce message
		new i = 0;
		loop_begin:
			i++;
			SendClientMessageToAll(0, " ");
			if(i < 3000) goto loop_begin;
		SendClientMessageToAll(0, "{00FF00}Le chat a été nettoyé !");
		printf("While :  %d ms",GetTickCount() - count);
		return 1;
	}
	if(strcmp(cmdtext,"/pmenu",true)==0)
	{
		SendClientMessage(playerid,gris,"[Menu] Menu d'accueil affiché !");
		SendClientMessage(playerid,jaune,"Vous pouvez faire échap pour quitter ce menu, s'il ne vous intéresse pas !");
		ShowLoginTD(playerid);
		return 1;
	}
	if(strcmp(cmdtext,"/csave",true)==0)
	{
	    if(IsGuest[playerid] == true) return SendClientMessage(playerid,rouge,"Vous ne pouvez pas sauvegarder votre compte, vous êtes invité !");
		SavePlayer(playerid);
		return 1;
	}
	if(strcmp(cmdtext,"/saveauto",true)==0)
	{
	    if(PlayerInfo[playerid][pAdmin] < 4) return NotRankedEnough(playerid);
	    SaveAuto();
	    return 1;
	 }
	if(strcmp(cmd,"/asetadmin",true)==0)
	{
		if(PlayerInfo[playerid][pAdmin] < 4) return NotRankedEnough(playerid);
		new tmp[256],tmp2[256],id,rank;
		tmp = strtok(cmdtext,idx);
		id = ReturnUser(tmp);
		tmp2 = strtok(cmdtext,idx);
		rank = strval(tmp2);
		if(!strlen(tmp) || !strlen(tmp2))
		{
			SendClientMessage(playerid,orange,"USAGE : /asetadmin [ID Joueur] [Rang]");
			SendClientMessage(playerid,gris,"Joueur - 1 | Membre confiance - 2 | Modo - 3 | Admin - 4");
			return 1;
		}
		new rankname[32];
		if(!IsPlayerConnected(id)) return NotConnected(playerid);
		if(rank < 1 || rank > 4) return SendClientMessage(playerid,rouge,"Rang invalide !");
		switch(rank)
		{
		    case 1 : rankname = "Joueur";
		    case 2 : rankname = "Membre de confiance";
		    case 3 : rankname = "Modérateur";
		    case 4 : rankname = "Administrateur";
		}
		new string[256];
		format(string,sizeof(string),"[Admin] Vous avez mis %s %s .",GetName(id),rankname);
		SendClientMessage(playerid,ADMIN_COLOR,string);
		format(string,sizeof(string),"[Admin] L'Admin vous a mis %s .",rankname);
		SendClientMessage(id,ADMIN_COLOR,string);
		PlayerInfo[id][pAdmin] = rank;
		return 1;
	}
	if(strcmp(cmd,"/agiveobj",true)==0)
	{
	    if(PlayerInfo[playerid][pAdmin] < 4) return NotRankedEnough(playerid);
	    new tmp[256],tmp1[256],tmp2[256],tmp3[256],id,item,amount;
		tmp = strtok(cmdtext,idx);
		tmp1 = strtok(cmdtext,idx);
		tmp2 = strtok(cmdtext,idx);
		tmp3 = strtok(cmdtext,idx);
		if(!strlen(tmp) || !strlen(tmp1) || !strlen(tmp2)) return SendClientMessage(playerid,rouge,"USAGE : /agiveobj [ID] [Item] [Montant]");
		id = ReturnUser(tmp);
		item = strval(tmp1);
		amount = strval(tmp2);
		if(!IsPlayerConnected(id)) return NotConnected(playerid);
		if(!IsValidItem(item)) return SendClientMessage(playerid,rouge,"ID Objet invalide !");
		if(amount < 1) return SendClientMessage(playerid,rouge,"Montant invalide !");
		GivePlayerObject(id,item,amount);
		new string[256];
		format(string,sizeof(string),"[Admin] Vous avez reçu %d %s de l'Admin.",amount,GetNameObject(item));
		SendClientMessage(id,ADMIN_COLOR,string);
		format(string,sizeof(string),"[Admin] Vous donnez %d %s à %s.",amount,GetNameObject(item),GetName(id));
		SendClientMessage(playerid,ADMIN_COLOR,string);
		return 1;
	}
	if(strcmp(cmd,"/removeobj",true)==0)
	{
	    if(PlayerInfo[playerid][pAdmin] < 4) return NotRankedEnough(playerid);
	    new tmp[256],tmp2[256],tmp3[256],amount,id,item;
		tmp = strtok(cmdtext,idx);
		tmp2 = strtok(cmdtext,idx);
		tmp3 = strtok(cmdtext,idx);
		if(!strlen(tmp) || !strlen(tmp2) || !strlen(tmp3)) return SendClientMessage(playerid,rouge,"USAGE : /removeobj [ID] [Item] [Nombre]");
		amount = strval(tmp3);
		id = ReturnUser(tmp);
		item = strval(tmp2);
		if(!IsValidItem(item)) return SendClientMessage(playerid,rouge,"ID Objet invalide !");
		if(amount < 1) return SendClientMessage(playerid,rouge,"Nombre invalide !");
		if(!IsPlayerConnected(id)) return NotConnected(playerid);
		RemoveItem(id,item,amount);
		new string[256];
		format(string,sizeof(string),"[Admin] L'Admin vous a retiré \"%s\"",GetNameObject(item));
		SendClientMessage(id,ADMIN_COLOR,string);
		format(string,sizeof(string),"[Admin] Vous avez retiré à %s \"%s\"",GetName(id),GetNameObject(item));
		SendClientMessage(playerid,ADMIN_COLOR,string);
		return 1;
	}
	if(strcmp(cmdtext,"/inv",true)==0)
	{
		new msg[1024];
		for(new i;i<MaxPlayerPlaces(playerid);i++)
		{
		    new string[256];
			format(string,sizeof(string),"{ff0000}%d {ffffff}%s\n",PlayerInventory[playerid][i][Nombre],GetNameObject(PlayerInventory[playerid][i][Item]));
			strcat(msg,string);
		}
		ShowPlayerDialog(playerid,2,DIALOG_STYLE_MSGBOX,"Inventaire",msg,"Ok","");
		return 1;
	}
	if(strcmp(cmdtext,"/inventaire",true)==0)
	{
	    ShowInventoryTD(playerid);
	    return 1;
	}
	new msg[256];
	format(msg,sizeof(msg),"{ff0000}La commande {ffffff}%s {ff0000}est inconnue !",cmd);
	return SendClientMessage(playerid,rouge,msg);
}
public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	if(_:clickedid == 65535)
	{
	    if(LoginTDShowed[playerid] == true && IsLogged[playerid] == true)
	    {
	        HideLoginTD(playerid);
		}
		if(InventoryTDShowed[playerid] == true)
		{
		    HideInventoryTD(playerid);
		}
		if(IsObjectReceived[playerid] == true)
		{
		    HideObjectReceivedTD(playerid);
		}
		if(hdvtd[playerid] == true) HideHDV(playerid);
	}
	return 0;
}
public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
	if(playertextid == TD_Login[playerid][4])
	{
	    if(IsLogged[playerid] == true && IsGuest[playerid] == false) return SendClientMessage(playerid,rouge,"Vous êtes déjà connecté !");
	    new string[256],title[16];
		if(fexist(UserPath(playerid)))
		{
			format(title,sizeof(title),"{00ff00}Connexion");
			format(string,sizeof(string),"\t\t{ffffff}Bienvenue {ff0000}%s {ffffff}sur le serveur.\n\nVeuillez entrer ci-dessous {ff0000}le mot de passe {ffffff}pour vous connecter :",GetName(playerid));
			IsRegistered[playerid] = true;
		}
		else
		{
		    format(title,sizeof(title),"{00ff00}Enregistrement");
		    format(string,sizeof(string),"\t\t{ffffff}Bienvenue sur le serveur {ff0000}%s {ffffff}!\n\nN'ayant pas de compte , vous devez vous en créer en définissant ci-dessous le mot de passe :",GetName(playerid));
			IsRegistered[playerid] = false;
		}
		ShowPlayerDialog(playerid,1,DIALOG_STYLE_PASSWORD,title,string,"Continuer","Annuler");
	}
	else if(playertextid == TD_Login[playerid][6])
	{
	    if(IsLogged[playerid] == true)
		{
			SendClientMessage(playerid,rouge,"Vous êtes déjà connecté !");
			SendClientMessage(playerid,vert,"Si vous souhaitez jouer en tant qu'invité , déconnectez-vous et reconnectez-vous et choisissez 'Jouer en tant qu'invité'");
			return 1;
		}
	    IsGuest[playerid] = true;
	    IsLogged[playerid] = true;
	    SendClientMessage(playerid,jaune,"Vous jouez en tant qu'invité , cependant vos données ne seront {ff0000}pas sauvegardées !");
	    SendClientMessage(playerid,vert,"{00ff00}Si jamais vous voulez vous créer un compte , tapez {ff0000}/pmenu {00ff00}afin de réaccéder au menu d'accueil.");
	    SetSpawnInfo(playerid,0,0,-3734.7263, -3167.3877, 2.3410,0.0,0,0,0,0,0,0);
	    SpawnPlayer(playerid);
 		SetPlayerPos(playerid,-3734.7263, -3167.3877, 2.3410);
   		HideLoginTD(playerid);
   		PlayerPlaySound(playerid,1069,0,0,0);
	}
	else if(playertextid == TD_Login[playerid][8])
	{
	    if(IsLogged[playerid] == false)
	    {
			new string[256];
			format(string,sizeof(string),"[Quit] {ffffff}%s {ff0000}n'a pas eu le courage d'affronter la survie !",GetName(playerid));
			SendClientMessageToAll(rouge,string);
			HideLoginTD(playerid);
			Kick(playerid);
		}
		else HideLoginTD(playerid);
	}
	else if(playertextid == TD_ObjectReceived[playerid][4])
	{
		HideObjectReceivedTD(playerid);
	}
	else if(playertextid == TD_Login[playerid][9])
	{
	    ShowNews(playerid);
	}
	else if(playertextid == TD_HDV[playerid][3])
	{
		OwnVentes[playerid] = false;
		PlayerTextDrawUseBox(playerid,TD_HDV[playerid][3],true);
		PlayerTextDrawUseBox(playerid,TD_HDV[playerid][4],false);
		HideHDV(playerid);
		ShowHDV(playerid);
	}
	else if(playertextid == TD_HDV[playerid][4])
	{
		OwnVentes[playerid] = true;
		PlayerTextDrawUseBox(playerid,TD_HDV[playerid][4],true);
		PlayerTextDrawUseBox(playerid,TD_HDV[playerid][3],false);
		HideHDV(playerid);
		ShowHDV(playerid);
	}
	else if(playertextid == TD_HDV[playerid][15])
	{
	    request[playerid] = 1;
	    ShowPlayerDialog(playerid,DIALOG_HDV,DIALOG_STYLE_INPUT,"Rechercher...","Entrez ci-dessous le nom ou une partie du nom d'objet à rechercher :","Rechercher","Quitter");
	}
	else if(playertextid == TD_HDV[playerid][29])
	{
	    request[playerid] = 2;
	    ShowPlayerDialog(playerid,DIALOG_HDV,DIALOG_STYLE_INPUT,"Ajouter...","Entrez ci-dessous le prix à l'unité de l'objet à vendre {ff0000}dans la grande case :","Ajouter","Quitter");
	}
    return 1;
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

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
	    case 1:
	    {
	        if(response)
	        {
		        if(IsRegistered[playerid] == true)
		        {
	            	if(udb_hash(inputtext) != PlayerInfo[playerid][pPass]) return SendClientMessage(playerid,rouge,"Accès refusé !");
	            	{
	            	    IsLogged[playerid] = true;
	            	    IsGuest[playerid] = false;
	            	    SetSpawnInfo(playerid,0,0,-3734.7263, -3167.3877, 2.3410,0.0,0,0,0,0,0,0);
	            	    SpawnPlayer(playerid);
	            	    SendClientMessage(playerid,vert,"Vous vous êtes connecté avec succès !");
	            	    SendClientMessage(playerid,gris,"Vous avez été téléporté là où vous étiez lors de votre dernière déconnexion !");
	            	    SetPlayerPos(playerid,PlayerInfo[playerid][pX],PlayerInfo[playerid][pY],PlayerInfo[playerid][pZ]);
	            	    SetPlayerFacingAngle(playerid,PlayerInfo[playerid][pA]);
						HideLoginTD(playerid);
						PlayerPlaySound(playerid,1069,0,0,0);
					}
				}
				else
				{
					if(!strlen(inputtext)) return SendClientMessage(playerid,rouge,"Mot de passe invalide !");
					{
					    IsLogged[playerid] = true;
					    IsGuest[playerid] = false;
					    SetSpawnInfo(playerid,0,0,-3734.7263, -3167.3877, 2.3410,0.0,0,0,0,0,0,0);
					    SpawnPlayer(playerid);
						new string[256];
						format(string,sizeof(string),"{FF8000}[New] {ff0000}%s {FF8000}vient de rejoindre le monde apocalyptique , souhaitez lui bonne merde !",GetName(playerid));
						SendClientMessageToAll(0,string);
						SendClientMessage(playerid,gris,"Bienvenue dans le {ff0000}monde apocalyptique.");
						SendClientMessage(playerid,gris,"Vous devrez combattre {ff0000}les zombies, {ff0000}les joueurs assoifés de sang, ainsi que vos besoins naturels !");
						SendClientMessage(playerid,gris,"Force et courage ! En vous souhaitant bon jeu !");
					    SetPlayerPos(playerid,-3734.7263, -3167.3877, 2.3410);
					    HideLoginTD(playerid);
					    PlayerPlaySound(playerid,1069,0,0,0);
						SavePlayer(playerid);
					}
				}
				new string[64];
				format(string,sizeof(string),"%s",inputtext);
				mdp[playerid] = string;
			}
		}
		case DIALOG_HDV:
		{
			new value = strval(inputtext), string[256];
		    switch(request[playerid])
		    {
		        case 2:
		        {
		            if(value <= 0) return SendClientMessage(playerid,rouge,"Prix invalide !");
		            
					new index = FirstPlaceVente();
					format(string,sizeof(string),"[Item] Vente n°%d Vous ajoutez 1 %s à l'hôtel des ventes pour $%d / unité",index,GetNameObject(1),value);
					SendClientMessage(playerid,vert,string);
					VenteInfo[index][Item] = 1;
					format(VenteInfo[index][Pseudo],MAX_PLAYER_NAME,"%s",GetName(playerid));
					VenteInfo[index][ID] = index;
					VenteInfo[index][Prix] = value;
					VenteInfo[index][Amount] = 5;
				}
			}
		}
	}
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}
