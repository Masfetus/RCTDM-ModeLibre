#include <a_samp>
#include <a_objects>

#if defined _w_Gates_included
	#endinput
#endif
#define _w_Gates_included
#pragma library w_Gates

/*
native AddPDGate();
native OpenPDGate(playerid,Float:Speed, bool: autoclose, time);
native ClosePDGate(playerid,Float:Speed);
native
native AddPD1Gate();
native OpenPD1Gate(playerid,Float:Speed, bool: autoclose, time);
native ClosePD1Gate(playerid,Float:Speed);
native
native AddE1Gate();
native OpenE1Gate(playerid,Float:Speed, bool: autoclose, time);
native CloseE1Gate(playerid,Float:Speed);
native
native AddE2Gate();
native OpenE2Gate(playerid,Float:Speed, bool: autoclose, time);
native CloseE2Gate(playerid,Float:Speed);
native
native AddDOORGate();
native OpenDOORGate(playerid,Float:Speed, bool: autoclose, time);
native CloseDOORGate(playerid,Float:Speed);
native
native AddCOSAGate();
native OpenCOSAGate(playerid,Float:Speed, bool: autoclose, time);
native CloseCOSAGate(playerid,Float:Speed);
native
native AddFOURGate();
native OpenFOURGate(playerid,Float:Speed, bool: autoclose, time);
native CloseFOURGate(playerid,Float:Speed);
native
native AddFOUR2Gate();
native
native AddFBIGate();
native OpenFBIGate(playerid,Float:Speed, bool: autoclose, time);
native CloseFBIGate(playerid,Float:Speed);
*/

new pdgate,pd1gate,e1gate,e2gate,dgate,cgate,fgate,fbigate;
new PD,PD1,E1,E2,DO,CO,FO,FB;
new Float:rxls,Float:ryls,Float:rzls;
new opentimerLS,closetimerLS,TimesLooped;

#define COLOR_RED 0xAA3333AA
#define COLOR_YELLOW 0xFFFF00AA

forward ClosePD(Float:Speed);
forward ClosePD1(Float:Speed);
forward CloseE1(Float:Speed);
forward CloseE2(Float:Speed);
forward CloseDO(Float:Speed);
forward CloseCO(Float:Speed);
forward CloseFO(Float:Speed);
forward PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z);
forward GateOpenLS();
forward GateCloseLS();
forward CloseFB(Float:Speed);


stock AddPDGate()
{
	pdgate = CreateObject(971, 1588.5617, -1638.1036, 12.7200, 0, 0, 0);
}


stock OpenPDGate(playerid,Float:Speed, autoclose, time)
{
	if(PlayerToPoint(25.0,playerid,1586.75, -1638.38, 14.950) == 1)
	{
		KillTimer(PD);
		MoveObject(pdgate,1588.5617, -1638.0871, 5.7200,Float:Speed);
		SendClientMessage(playerid, COLOR_YELLOW,"La grille reste ouverte 5 secondes !");

		if(autoclose == 1)
		{
			PD = SetTimerEx("ClosePD",time,0,"f",Float:Speed);
		}
	}
	else
	{
		SendClientMessage(playerid,COLOR_RED,"Pas à coté Grille Garage LSPD");
	}
}


public ClosePD(Float:Speed)
{
	MoveObject(pdgate,1588.5617, -1638.1036, 12.7200,Float:Speed);
}

stock AddPD1Gate()
{
	pd1gate = CreateObject(968,1544.700317,-1630.735717,13.096980,-1.000000,-91.000000,269.972869);
	CreateObject(997,1544.590576,-1617.848388,12.438137,0.000000,0.000000,271.938476);
	CreateObject(997,1544.710205,-1620.973266,12.416269,0.000000,0.000000,270.590179);
	CreateObject(997,1544.037353,-1632.651123,12.576721,0.000000,0.000000,269.745178);
	CreateObject(997,1544.005737,-1635.747070,12.857315,0.000000,0.000000,270.540161);
}



public GateOpenLS()
{
	TimesLooped ++;
	if(TimesLooped==90)
	{
		KillTimer(opentimerLS);
		TimesLooped=0;
	}
	GetObjectRot(pd1gate,rxls,ryls,rzls);
	SetObjectRot(pd1gate,rxls,ryls+1,rzls);
}

public GateCloseLS()
{
	TimesLooped ++;
	if(TimesLooped==90)
	{
		KillTimer(closetimerLS);
		TimesLooped=0;
	}
	GetObjectRot(pd1gate,rxls,ryls,rzls);
	SetObjectRot(pd1gate,rxls,ryls-1,rzls);
}

stock OpenPD1Gate(playerid,Float:Speed, autoclose, time)
{
	TimesLooped=0;
	if(PlayerToPoint(25.0,playerid,1544.700317,-1630.735717,13.096980) == 1)
	{
		if(TimesLooped == 0)
		{
			KillTimer(PD1);
			SetObjectRot(pd1gate,-1.000000,-91.000000,269.972869);
			opentimerLS=SetTimer("GateOpenLS", 20, 1);
			SendClientMessage(playerid, COLOR_YELLOW,"La grille reste ouverte 5 secondes !");
		}
		if(autoclose == 1)
		{
			PD1 = SetTimerEx("ClosePD1",time,0,"f",Float:Speed);
		}
	}
	else
	{
		SendClientMessage(playerid,COLOR_RED,"Pas à coté Grille Parking LSPD");
	}
}


public ClosePD1(Float:Speed)
{
	TimesLooped=0;
	if(TimesLooped == 0)
	{
		SetObjectRot(pd1gate, -1.000000, -1.00000, 269.972869);
		closetimerLS=SetTimer("GateCloseLS", 20, 1);
	}
		
}


stock AddE1Gate()
{
	e1gate = CreateObject(7657, 2232.647705, -2213.785645, 14.263718, 0.0000, 0.0000, 135.0000);

}

stock OpenE1Gate(playerid,Float:Speed, autoclose, time)
{
	if(PlayerToPoint(25.0,playerid,2232.647705, -2213.785645, 14.263718) == 1)
	{
		KillTimer(E1);
		MoveObject(e1gate,2232.647705, -2213.785645, 9,Float:Speed);
		SendClientMessage(playerid, COLOR_YELLOW,"La grille reste ouverte 5 secondes !");

		if(autoclose == 1)
		{
			E1 = SetTimerEx("CloseE1",time,0,"f",Float:Speed);
		}
	}
	else
	{
		SendClientMessage(playerid,COLOR_RED,"Pas à coté Grille Parking Entrepot !");
	}
}


public CloseE1(Float:Speed)
{
	MoveObject(e1gate,2232.647705, -2213.785645, 14.263718,Float:Speed);
}


stock AddE2Gate()
{
	e2gate = CreateObject(969, 2181.270996, -2252.080078, 13.861120, 0.0000, 0.0000, 225.0000);

}

stock OpenE2Gate(playerid,Float:Speed, autoclose, time)
{
	if(PlayerToPoint(25.0,playerid,2181.270996, -2252.080078, 13.861120) == 1)
	{
		KillTimer(E2);
		MoveObject(e2gate,2181.270996, -2252.080078, 9,Float:Speed);
		SendClientMessage(playerid, COLOR_YELLOW,"La grille reste ouverte 5 secondes !");

		if(autoclose == 1)
		{
			E2 = SetTimerEx("CloseE2",time,0,"f",Float:Speed);
		}
	}
	else
	{
		SendClientMessage(playerid,COLOR_RED,"Pas à coté Grille Entrepot !");
	}
}


public CloseE2(Float:Speed)
{
	MoveObject(e2gate,2181.270996, -2252.080078, 13.861120,Float:Speed);
}

stock AddDOORGate()
{
	dgate = CreateObject(971,249.0,72.8,1003.0,0.000000,0.000000,359.420227);

}

stock OpenDOORGate(playerid,Float:Speed, autoclose, time)
{
	if(PlayerToPoint(25.0,playerid,249.0,72.8,1003.0) == 1)
	{
		KillTimer(DO);
		MoveObject(dgate,252.0,72.8,1003.0,Float:Speed);

		if(autoclose == 1)
		{
			DO = SetTimerEx("CloseDO",time,0,"f",Float:Speed);
		}
	}
	else
	{
		SendClientMessage(playerid,COLOR_RED,"Pas a coté");
	}
}

public CloseDO(Float:Speed)
{
	MoveObject(dgate,249.0,72.8,1003.0,Float:Speed);
}

stock AddCOSAGate()
{
	cgate = CreateObject(971,264.451751,-1333.271240,52.303924,0,0,35);
}

stock OpenCOSAGate(playerid,Float:Speed, autoclose, time)
{
	if(PlayerToPoint(25.0,playerid,264.451751,-1333.271240,52.303924) == 1)
	{
		KillTimer(CO);
		MoveObject(cgate,269.350616,-1330.183837,52.303924,Float:Speed);
		SendClientMessage(playerid, COLOR_YELLOW,"La grille reste ouverte 5 secondes !");

		if(autoclose == 1)
		{
			CO = SetTimerEx("CloseCO",time,0,"f",Float:Speed);
		}
	}
	else
	{
		SendClientMessage(playerid,COLOR_RED,"Pas à coté Portail Cosa Notra");
	}
}


public CloseCO(Float:Speed)
{
	MoveObject(cgate,264.451751,-1333.271240,52.303924,Float:Speed);
}

stock AddFOURGate()
{
	fgate = CreateObject(985, 778, -1385.1, 11.9, 0, 0, 0);
}

stock OpenFOURGate(playerid,Float:Speed, autoclose, time)
{
	if(PlayerToPoint(25.0,playerid,778, -1385.1, 13.5469) == 1)
	{
		KillTimer(FO);
		MoveObject(fgate,770, -1385.1, 11.9,Float:Speed);
		SendClientMessage(playerid, COLOR_YELLOW,"La grille reste ouverte 5 secondes !");

		if(autoclose == 1)
		{
			FO = SetTimerEx("CloseFO",time,0,"f",Float:Speed);
		}
	}
	else
	{
		SendClientMessage(playerid,COLOR_RED,"Pas à coté Grille fourrière");
	}
}


public CloseFO(Float:Speed)
{
	MoveObject(fgate,778, -1385.1, 11.9,Float:Speed);
}

stock AddFOUR2Gate()
{
	CreateObject(985, 777.96, -1330, 11.9, 1.2, 0, 0);
}

stock AddFBIGate()
{
	fbigate = CreateObject(971,1643.06,-1715.08,15.0332,0,0,93);
}


stock OpenFBIGate(playerid,Float:Speed, autoclose, time)
{
	if(PlayerToPoint(25.0,playerid,1643.06,-1715.08,15.0332) == 1)
	{
		KillTimer(FB);
		MoveObject(fbigate,1643.06, -1715.08, 5.3720,Float:Speed);
		SendClientMessage(playerid, COLOR_YELLOW,"La grille reste ouverte 5 secondes !");

		if(autoclose == 1)
		{
			FB = SetTimerEx("CloseFB",time,0,"f",Float:Speed);
		}
	}
	else
	{
		SendClientMessage(playerid,COLOR_RED,"Pas à coté Grille Garage FBI");
	}
}


public CloseFB(Float:Speed)
{
	MoveObject(fbigate,1643.06,-1715.08,15.0332,Float:Speed);
}
