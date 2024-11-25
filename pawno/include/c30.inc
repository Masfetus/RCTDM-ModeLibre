#if defined _c30_included
#endinput
#endif


#define dUserINT(%1).( udb_UserInt(%1,
#define dUserSet(%1).( udb_UserSet(%1,
#define MAX_STRING 255/*
#define MAX_VEHICLES_CAR 97
#define MAX_VEHICLES_MOTO 10
#define MAX_VEHICLES_BATEAUX 11
*/
new Float: X0[MAX_PLAYERS], Float: Y0[MAX_PLAYERS], Float: Z0[MAX_PLAYERS], Float: Angle0[MAX_PLAYERS];
new Float: X1[MAX_PLAYERS], Float: Y1[MAX_PLAYERS], Float: Z1[MAX_PLAYERS], Float: Angle1[MAX_PLAYERS];
new Float: X2[MAX_PLAYERS], Float: Y2[MAX_PLAYERS], Float: Z2[MAX_PLAYERS], Float: Angle2[MAX_PLAYERS];
new Float: X[MAX_PLAYERS], Float: Y[MAX_PLAYERS], Float: Z[MAX_PLAYERS], Float: Angle[MAX_PLAYERS];
/*new voiture[MAX_VEHICLES_CAR] =
{
400,401,402,404,405,410,411,415,418,419,420,421,422,424,426,429,434,436,438,439,
445,451,458,466,467,470,474,475,477,478,479,480,489,490,491,492,494,495,496,500,
502,503,504,505,506,507,516,517,518,525,526,527,528,529,533,534,535,356,540,541,
542,543,545,546,547,549,550,551,552,554,555,558,559,560,561,562,565,566,567,568,
575,576,579,580,585,587,589,596,597,598,599,600,601,602,603,604,605
};
new moto[MAX_VEHICLES_MOTO] =
{
448,461,462,463,468,521,522,523,581,586
};
new bateaux[MAX_VEHICLES_BATEAUX] =
{
430,446,452,453,454,472,473,484,493,539,595
};*/
new NewColor[31] =
{
130, 166, 256, 131, 132, 142, 144, 146, 147, 236, 148, 149, 150, 151, 152, 153, 154, 155,
156, 157, 158, 159, 160, 161, 173, 174, 175, 237, 239, 243, 252
};
new CarName[][] =
{
    "Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel",
	"Dumper", "Firetruck", "Trashmaster", "Stretch", "Manana", "Infernus",
	"Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam",
    "Esperanto", "Taxi", "Washington", "Bobcat", "Whoopee", "BF Injection",
	"Hunter", "Premier", "Enforcer", "Securicar", "Banshee", "Predator", "Bus",
	"Rhino", "Barracks", "Hotknife", "Trailer", "Previon", "Coach", "Cabbie",
	"Stallion", "Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral",
	"Squalo", "Seasparrow", "Pizzaboy", "Tram", "Trailer", "Turismo", "Speeder",
	"Reefer", "Tropic", "Flatbed", "Yankee", "Caddy", "Solair", "Berkley's RC Van",
	"Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron", "RC Raider", "Glendale",
	"Oceanic","Sanchez", "Sparrow", "Patriot", "Quad", "Coastguard", "Dinghy",
	"Hermes", "Sabre", "Rustler", "ZR-350", "Walton", "Regina", "Comet", "BMX",
	"Burrito", "Camper", "Marquis", "Baggage", "Dozer", "Maverick", "News Chopper",
	"Rancher", "FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking",
	"Blista Compact", "Police Maverick", "Boxvillde", "Benson", "Mesa", "RC Goblin",
	"Hotring Racer A", "Hotring Racer B", "Bloodring Banger", "Rancher", "Super GT",
	"Elegant", "Journey", "Bike", "Mountain Bike", "Beagle", "Cropduster", "Stunt",
 	"Tanker", "Roadtrain", "Nebula", "Majestic", "Buccaneer", "Shamal", "Hydra",
 	"FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Tow Truck", "Fortune",
 	"Cadrona", "FBI Truck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer",
 	"Remington", "Slamvan", "Blade", "Freight", "Streak", "Vortex", "Vincent",
    "Bullet", "Clover", "Sadler", "Firetruck", "Hustler", "Intruder", "Primo",
	"Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada", "Yosemite",
	"Windsor", "Monster", "Monster", "Uranus", "Jester", "Sultan", "Stratium",
	"Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma", "Savanna", "Bandito",
    "Freight Flat", "Streak Carriage", "Kart", "Mower", "Dune", "Sweeper",
	"Broadway", "Tornado", "AT-400", "DFT-30", "Huntley", "Stafford", "BF-400",
	"News Van", "Tug", "Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club",
	"Freight Box", "Trailer", "Andromada", "Dodo", "RC Cam", "Launch", "Police Car",
 	"Police Car", "Police Car", "Police Ranger", "Picador", "S.W.A.T", "Alpha",
 	"Phoenix", "Glendale", "Sadler", "Luggage", "Luggage", "Stairs", "Boxville",
 	"Tiller", "Utility Trailer"
};

stock  dini_IntSet(filename[],key[],value) {
   new valuestring[MAX_STRING];
   format(valuestring,sizeof(valuestring),"%d",value);
   return dini_Set(filename,key,valuestring);
}

stock equal(str1[],str2[],bool:ignorecase) {
    if (strlen(str1)!=strlen(str2)) return false;
    if (strcmp(str1,str2,ignorecase)==0) return true;
    return false;
}

stock  dini_Int(filename[],key[]) {
   return strval(dini_Get(filename,key));
}

stock  dini_Exists(filename[]) {
	if (fexist(filename)) return true;
	return false;
}

stock  dini_Create(filename[]) {
	new File:fhnd;
	if (fexist(filename)) return false;
	fhnd=fopen(filename,io_write);
	fclose(fhnd);
	return true;
}


stock  dini_Remove(filename[]) {
	if (!fexist(filename)) return false;
	fremove(filename);
	return true;
}

stock  dini_Set(filename[],key[],value[]) {
	new File:fohnd, File:fwhnd;
	new bool:wasset=false;
	new tmpres[MAX_STRING];
	if (key[0]==0) return false; /* If we have no sign in key, it can't be set*/
	format(tmpres,sizeof(tmpres),"%s.part",filename);
	fohnd=fopen(filename,io_read);
	if (!fohnd) return false;
	fremove(tmpres);
	fwhnd=fopen(tmpres,io_write);
	//  if (!fwhnd) return false;
	while (fread(fohnd,tmpres)) {
		StripNewLine(tmpres);
		if ((!wasset)&&(equal(dini_PRIVATE_ExtractKey(tmpres),key,true))) {
			/* We've got what needs to be replaced! */
			format(tmpres,sizeof(tmpres),"%s=%s",key,value);
			wasset=true;
		}
		fwrite(fwhnd,tmpres);
		fwrite(fwhnd,"\r\n");
	}

	if (!wasset) {
		format(tmpres,sizeof(tmpres),"%s=%s",key,value);
		fwrite(fwhnd,tmpres);
		fwrite(fwhnd,"\r\n");
	}

	fclose(fohnd);
	fclose(fwhnd);

	format(tmpres,sizeof(tmpres),"%s.part",filename);
	if (fcopytextfile(tmpres,filename)) {
		return fremove(tmpres);
	}
	return false;
}

stock  dini_Get(filename[],key[]) {
	new File:fohnd;
	new tmpres[MAX_STRING];
	new tmpres2[MAX_STRING];
	tmpres[0]=0;
	fohnd=fopen(filename,io_read);
	if (!fohnd) return tmpres;
	while (fread(fohnd,tmpres)) {
		StripNewLine(tmpres);
		if (equal(dini_PRIVATE_ExtractKey(tmpres),key,true)) {
			/* We've got what we need */
			tmpres2[0]=0;
			strcat(tmpres2,dini_PRIVATE_ExtractValue(tmpres));
			fclose(fohnd);
			return tmpres2;
		}
	}
	fclose(fohnd);
	return tmpres;
}

stock  dini_FloatSet(filename[],key[],Float:value) {
   new valuestring[MAX_STRING];
   format(valuestring,sizeof(valuestring),"%f",value);
   return dini_Set(filename,key,valuestring);
}

stock udb_encode(nickname[]) {
  new tmp[MAX_STRING];
  set(tmp,nickname);
  tmp=strreplace("_","_00",tmp);
  tmp=strreplace(";","_01",tmp);
  tmp=strreplace("!","_02",tmp);
  tmp=strreplace("/","_0_",tmp);
  tmp=strreplace("\\","_04",tmp);
  tmp=strreplace("[","_05",tmp);
  tmp=strreplace("]","_06",tmp);
  tmp=strreplace("?","_07",tmp);
  tmp=strreplace(".","_08",tmp);
  tmp=strreplace("*","_09",tmp);
  tmp=strreplace("<","_10",tmp);
  tmp=strreplace(">","_11",tmp);
  tmp=strreplace("{","_12",tmp);
  tmp=strreplace("}","_13",tmp);
  tmp=strreplace(" ","_14",tmp);
  tmp=strreplace("\"","_15",tmp);
  tmp=strreplace(":","_16",tmp);
  tmp=strreplace("|","_17",tmp);
  tmp=strreplace("=","_18",tmp);
  return tmp;
}

stock  dini_PRIVATE_ExtractKey(line[]) {
	new tmp[MAX_STRING];
	tmp[0]=0;
	if (strfind(line,"=",true)==-1) return tmp;
	set(tmp,strlower(ret_memcpy(line,0,strfind(line,"=",true))));
	return tmp;
}

stock  dini_PRIVATE_ExtractValue(line[]) {
    new tmp[MAX_STRING];
    tmp[0]=0;
    if (strfind(line,"=",true)==-1) {
        return tmp;
    }
    set(tmp,ret_memcpy(line,strfind(line,"=",true)+1,strlen(line)));
    return tmp;
}

stock udb_UserInt(nickname[],key[]) {
  new fname[MAX_STRING];
  format(fname,sizeof(fname),"%s.ini",udb_encode(nickname));
  return dini_Int(fname,key);
}

stock udb_CheckLogin(nickname[],pwd[]) {
  new fname[MAX_STRING];
  format(fname,sizeof(fname),"%s.tele",udb_encode(nickname));
  if (udb_UserInt(nickname,"password_hash")==udb_hash(pwd)) return true;
  return false;
}

stock strreplace(trg[],newstr[],src[]) {
    new f=0;
    new s1[MAX_STRING];
    new tmp[MAX_STRING];
    format(s1,sizeof(s1),"%s",src);
    f = strfind(s1,trg);
    tmp[0]=0;
    while (f>=0) {
        strcat(tmp,ret_memcpy(s1, 0, f));
        strcat(tmp,newstr);
        format(s1,sizeof(s1),"%s",ret_memcpy(s1, f+strlen(trg), strlen(s1)-f));
        f = strfind(s1,trg);
    }
    strcat(tmp,s1);
    return tmp;
}

stock StripNewLine(string[])
{
	new len = strlen(string);
	if (string[0]==0) return ;
	if ((string[len - 1] == '\n') || (string[len - 1] == '\r')) {
		string[len - 1] = 0;
		if (string[0]==0) return ;
		if ((string[len - 2] == '\n') || (string[len - 2] == '\r')) string[len - 2] = 0;
	}
}

stock fcopytextfile(oldname[],newname[]) {
	new File:ohnd,File:nhnd;
	if (!fexist(oldname)) return false;
	ohnd=fopen(oldname,io_read);
	nhnd=fopen(newname,io_write);
	new tmpres[MAX_STRING];
	while (fread(ohnd,tmpres)) {
		StripNewLine(tmpres);
		format(tmpres,sizeof(tmpres),"%s\r\n",tmpres);
		fwrite(nhnd,tmpres);
	}
	fclose(ohnd);
	fclose(nhnd);
	return true;
}

stock  Float:dini_Float(filename[],key[]) {
   return floatstr(dini_Get(filename,key));
}

stock set(dest[],source[]) {
	new count = strlen(source);
	new i=0;
	for (i=0;i<count;i++) {
		dest[i]=source[i];
	}
	dest[count]=0;
}

stock strlower(text[]) {
	new tmp[MAX_STRING];
	tmp[0]=0;
	if (text[0]==0) return tmp;
	new i=0;
	for (i=0;i<strlen(text);i++) {
		tmp[i]=tolower(text[i]);
	}
	tmp[strlen(text)]=0;
	return tmp;
}

stock SaveSystem(playerid)
{
   if(IsPlayerInAnyVehicle(playerid))
   {
      GetVehicleZAngle(GetVeh(playerid), Angle[playerid]);
      GetVehiclePos(GetVeh(playerid), X[playerid], Y[playerid], Z[playerid]);
      return 1;
   }
   else
   {
      GetPlayerFacingAngle(playerid, Angle[playerid]);
      GetPlayerPos(playerid, X[playerid], Y[playerid], Z[playerid]);
      return 1;
   }
}

stock TlepSystem(playerid)
{
   if(IsPlayerInAnyVehicle(playerid))
   {

      SetVehicleZAngle(GetVeh(playerid), Angle[playerid]);
      SetVehiclePos(GetVeh(playerid), X[playerid], Y[playerid], Z[playerid]);
      return 1;
   }
   else
   {
      SetPlayerFacingAngle(playerid, Angle[playerid]);
      SetPlayerPos(playerid, X[playerid], Y[playerid], Z[playerid]);
      return 1;
   }
}

stock Save0(playerid)
{
   if(IsPlayerInAnyVehicle(playerid))
   {
      GetVehicleZAngle(GetVeh(playerid), Angle0[playerid]);
      GetVehiclePos(GetVeh(playerid), X0[playerid], Y0[playerid], Z0[playerid]);
      return 1;
   }
   else
   {
      GetPlayerFacingAngle(playerid, Angle0[playerid]);
      GetPlayerPos(playerid, X0[playerid], Y0[playerid], Z0[playerid]);
      return 1;
   }
}

stock Telep0(playerid)
{
   if(IsPlayerInAnyVehicle(playerid))
   {
      SetVehicleZAngle(GetVeh(playerid), Angle0[playerid]);
      SetVehiclePos(GetVeh(playerid), X0[playerid], Y0[playerid], Z0[playerid]);
      return 1;
   }
   else
   {
      SetPlayerFacingAngle(playerid, Angle0[playerid]);
      SetPlayerPos(playerid, X0[playerid], Y0[playerid], Z0[playerid]);
	  return 1;
   }
}


stock Save1(playerid)
{
   if(IsPlayerInAnyVehicle(playerid))
   {
      GetVehicleZAngle(GetVeh(playerid), Angle1[playerid]);
      GetVehiclePos(GetVeh(playerid), X1[playerid], Y1[playerid], Z1[playerid]);
      return 1;
   }
   else
   {
      GetPlayerFacingAngle(playerid, Angle1[playerid]);
      GetPlayerPos(playerid, X1[playerid], Y1[playerid], Z1[playerid]);
      return 1;
   }
}

stock Telep1(playerid)
{
   if(IsPlayerInAnyVehicle(playerid))
   {
      SetVehicleZAngle(GetVeh(playerid), Angle1[playerid]);
      SetVehiclePos(GetVeh(playerid), X1[playerid], Y1[playerid], Z1[playerid]);
      return 1;
   }
   else
   {
      SetPlayerFacingAngle(playerid, Angle1[playerid]);
      SetPlayerPos(playerid, X1[playerid], Y1[playerid], Z1[playerid]);
	  return 1;
   }
}

stock Save2(playerid)
{
   if(IsPlayerInAnyVehicle(playerid))
   {
      GetVehicleZAngle(GetVeh(playerid), Angle2[playerid]);
      GetVehiclePos(GetVeh(playerid), X2[playerid], Y2[playerid], Z2[playerid]);
      return 1;
   }
   else
   {
      GetPlayerFacingAngle(playerid, Angle2[playerid]);
      GetPlayerPos(playerid, X2[playerid], Y2[playerid], Z2[playerid]);
      return 1;
   }
}

stock Telep2(playerid)
{
   if(IsPlayerInAnyVehicle(playerid))
   {
      SetVehicleZAngle(GetVeh(playerid), Angle2[playerid]);
      SetVehiclePos(GetVeh(playerid), X2[playerid], Y2[playerid], Z2[playerid]);
      return 1;
   }
   else
   {
      SetPlayerFacingAngle(playerid, Angle2[playerid]);
      SetPlayerPos(playerid, X2[playerid], Y2[playerid], Z2[playerid]);
	  return 1;
   }
}

stock Telep(playerid, Float:Xt, Float:Yt, Float:Zt, Float:Anglet)
{
   if(IsPlayerInAnyVehicle(playerid))
   {
      SetVehicleZAngle(GetVeh(playerid), Anglet);
      SetVehiclePos(GetVeh(playerid), Xt, Yt, Zt);
      return 1;
   }
   else
   {
      SetPlayerFacingAngle(playerid, Anglet);
      SetPlayerPos(playerid, Xt, Yt, Zt);
	  return 1;
   }
}

stock GetVName(playerid)
{
	return CarName[GetVehicleModel(GetVeh(playerid))-400];
}

stock  cc()
{
	new Alea = random (157);
	if (Alea > 126)
	{
		Alea = NewColor[Alea-127];
	}
	return Alea;
}

ret_memcpy(source[],index=0,numbytes) {
	new tmp[MAX_STRING];
	new i=0;
	tmp[0]=0;
	if (index>=strlen(source)) return tmp;
	if (numbytes+index>=strlen(source)) numbytes=strlen(source)-index;
	if (numbytes<=0) return tmp;
	for (i=index;i<numbytes+index;i++) {
		tmp[i-index]=source[i];
		if (source[i]==0) return tmp;
	}
	tmp[numbytes]=0;
	return tmp;
}





/*



new bus[] = "bus";
new band[] = "band";
new quad[] = "quad";
new san[] = "san";
new velo[] = "velo";
new sand[] = "sand";




*/

