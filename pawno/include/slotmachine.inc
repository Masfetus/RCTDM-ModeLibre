#include <a_samp>

#define G_STATE_NOT_GAMBLING    0
#define G_STATE_READY           1
#define G_STATE_GAMBLING        2
#define G_STATE_DISPLAY         3

#define DISPLAY_TIME 750
#define GAMBLE_TIMER 100

new PlayerText:BetText[MAX_PLAYERS];
new Text:Box;
new Text:Digit1[6];
new Text:Digit2[6];
new Text:Digit3[6];

new Slots[MAX_PLAYERS][3];
new SlotCounter[MAX_PLAYERS];
new Gambling[MAX_PLAYERS];
new SlotTimer[MAX_PLAYERS];
new Bet[MAX_PLAYERS];

forward PlayAgainTimer(playerid);
forward Gambler(playerid);

Text:CreateSprite(Float:sX,Float:sY,Name[],Float:Width,Float:Height)
	{
        new Text:RetSprite;
        RetSprite = TextDrawCreate(sX, sY, Name);
        TextDrawFont(RetSprite, 4);
        TextDrawColor(RetSprite,0xFFFFFFFF);
        TextDrawTextSize(RetSprite,Width,Height);
        return RetSprite;
	}

Text:CreateBox(Float:bX,Float:bY,Float:Width,Float:Height,color)
	{
        new Text[500];
        for(new i=floatround(bY); i < floatround(bY+Height);i++)
        	{
                strcat(Text,"~n~_");
        	}
    	new Text:RetSprite;
        RetSprite = TextDrawCreate(bX, bY, Text);
        TextDrawFont(RetSprite, 0);
        TextDrawColor(RetSprite,0xFFFFFFFF);
        TextDrawTextSize(RetSprite,Width+bX,Height+bY);
        TextDrawUseBox(RetSprite,1);
        TextDrawBoxColor(RetSprite,color);
        TextDrawLetterSize(RetSprite,0.0001,0.1158);
        return RetSprite;
	}

public OnFilterScriptInit()
	{
        Box = CreateBox(194.0,330.0, 3*64.0 + 3*20, 84, 0x00000077);
        // Cherries (x25)
        Digit1[0] = CreateSprite(214.0,350.0,"LD_SLOT:cherry",64,64);
        Digit2[0] = CreateSprite(288.0,350.0,"LD_SLOT:cherry",64,64);
        Digit3[0] = CreateSprite(362.0,350.0,"LD_SLOT:cherry",64,64);
        // grapes (x100)
        Digit1[1] = CreateSprite(214.0,350.0,"LD_SLOT:grapes",64,64);
        Digit2[1] = CreateSprite(288.0,350.0,"LD_SLOT:grapes",64,64);
        Digit3[1] = CreateSprite(362.0,350.0,"LD_SLOT:grapes",64,64);
        // 69's (x250)
        Digit1[2] = CreateSprite(214.0,350.0,"LD_SLOT:r_69",64,64);
        Digit2[2] = CreateSprite(288.0,350.0,"LD_SLOT:r_69",64,64);
        Digit3[2] = CreateSprite(362.0,350.0,"LD_SLOT:r_69",64,64);
        // bells (x500)
        Digit1[3] = CreateSprite(214.0,350.0,"LD_SLOT:bell",64,64);
        Digit2[3] = CreateSprite(288.0,350.0,"LD_SLOT:bell",64,64);
        Digit3[3] = CreateSprite(362.0,350.0,"LD_SLOT:bell",64,64);
        // Bars [1 bar] (x1000)
        Digit1[4] = CreateSprite(214.0,350.0,"LD_SLOT:bar1_o",64,64);
        Digit2[4] = CreateSprite(288.0,350.0,"LD_SLOT:bar1_o",64,64);
        Digit3[4] = CreateSprite(362.0,350.0,"LD_SLOT:bar1_o",64,64);
        // Bars [2 bar] (x2000)
        Digit1[5] = CreateSprite(214.0,350.0,"LD_SLOT:bar2_o",64,64);
        Digit2[5] = CreateSprite(288.0,350.0,"LD_SLOT:bar2_o",64,64);
        Digit3[5] = CreateSprite(362.0,350.0,"LD_SLOT:bar2_o",64,64);
        return 1;
	}

public OnPlayerConnect(playerid)
	{
        Gambling[playerid] = G_STATE_NOT_GAMBLING;
        SlotTimer[playerid] = -1;
        BetText[playerid] = CreatePlayerTextDraw(playerid, 195.0, 408.0,"~y~MISE: ~r~5~g~$");
        PlayerTextDrawFont(playerid, BetText[playerid], 2);
        PlayerTextDrawLetterSize(playerid, BetText[playerid], 0.35, 0.8);
        PlayerTextDrawSetShadow(playerid, BetText[playerid], 0);
        PlayerTextDrawSetOutline(playerid, BetText[playerid], 1);
        return 1;
	}

public OnPlayerDisconnect(playerid, reason)
	{
    	ExitPlayerFromSlotMachine(playerid);
	    for(new i = 0; i < 6; i ++)
	        {
		    	TextDrawHideForPlayer(playerid,Digit1[i]);
		        TextDrawHideForPlayer(playerid,Digit2[i]);
		        TextDrawHideForPlayer(playerid,Digit3[i]);
			}
        TextDrawHideForPlayer(playerid,Box);
        if(SlotTimer[playerid] != -1) KillTimer(SlotTimer[playerid]);
        return 1;
	}

ShowPlayerSlots(playerid,slot1,slot2,slot3)
	{
	    for(new i = 0; i < 6; i ++)
	        {
		    	TextDrawHideForPlayer(playerid,Digit1[i]);
		        TextDrawHideForPlayer(playerid,Digit2[i]);
		        TextDrawHideForPlayer(playerid,Digit3[i]);
			}
        TextDrawShowForPlayer(playerid,Digit1[slot1]);
        TextDrawShowForPlayer(playerid,Digit2[slot2]);
        TextDrawShowForPlayer(playerid,Digit3[slot3]);
        TextDrawShowForPlayer(playerid,Box);
	}

HideSlotsForPlayer(playerid)
	{
	    for(new i = 0; i < 6; i ++)
	        {
		    	TextDrawHideForPlayer(playerid,Digit1[i]);
		        TextDrawHideForPlayer(playerid,Digit2[i]);
		        TextDrawHideForPlayer(playerid,Digit3[i]);
			}
        TextDrawHideForPlayer(playerid,Box);
	}

PutPlayerInSlotMachine(playerid, bet)
	{
		if(langue[playerid] == 0) ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "Machine à sous", "{FFFFFF}Commandes:\n\n{CC0000}Touche de saut: {FFFFFF}Lancer\n{CC0000}Entrée: {FFFFFF}Quitter la machine", "Fermer", "");
		else if(langue[playerid] == 1) ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "Slot machine", "{FFFFFF}Commands:\n\n{CC0000}Jump key: {FFFFFF}Launch\n{CC0000}Enter: {FFFFFF}Leave", "Close", "");
        Gambling[playerid] = G_STATE_READY;
        PlayerTextDrawShow(playerid,BetText[playerid]);
        Slots[playerid][0] = random(5);
        Slots[playerid][1] = random(5);
        Slots[playerid][2] = random(5);
        ShowPlayerSlots(playerid,Slots[playerid][0],Slots[playerid][1],Slots[playerid][2]);
        Bet[playerid] = bet;
        UpdateBetText(playerid);
        TogglePlayerControllable(playerid,0);
        return 1;
	}

ExitPlayerFromSlotMachine(playerid)
	{
        if(Gambling[playerid] == G_STATE_NOT_GAMBLING) return 0;
        Gambling[playerid] = G_STATE_NOT_GAMBLING;
        HideSlotsForPlayer(playerid);
        PlayerTextDrawHide(playerid,BetText[playerid]);
        TogglePlayerControllable(playerid,1);
	    return 1;
	}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
	{
        if(newkeys & KEY_SPRINT)
	        {
	            if(Gambling[playerid] == G_STATE_READY)
		            {
		                if(Bet[playerid] > GetPlayerCash(playerid))
			                {
			                    if(langue[playerid] == 0) SendClientMessage(playerid, ROUGE, "Vous n'avez pas assez de fric !");
			                    else if(langue[playerid] == 1) SendClientMessage(playerid, ROUGE, "You don't have enough money!");
			                    return 1;
			                }
		                SlotCounter[playerid] = 30+random(18);
		            	SlotTimer[playerid] = SetTimerEx("Gambler",GAMBLE_TIMER,1,"i",playerid);
		            	Gambling[playerid] = G_STATE_GAMBLING;
		                GivePlayerCash(playerid, -Bet[playerid]);
		                UpdateBetText(playerid);
		            }
	        }
        if(newkeys & KEY_SECONDARY_ATTACK)
	        {
	            if(Gambling[playerid] == G_STATE_READY)
		            {
		                ExitPlayerFromSlotMachine(playerid);
		            }
	        }
        return 1;
	}

public Gambler(playerid)
	{
        if(Gambling[playerid] != G_STATE_GAMBLING)
	        {
	            KillTimer(SlotTimer[playerid]);
	            SlotTimer[playerid] = -1;
	            Gambling[playerid] = G_STATE_NOT_GAMBLING;
	            return 0;
	        }
        SlotCounter[playerid] -= 1;
        new slot = SlotCounter[playerid];
        if(slot < 10)
	        {
	            Slots[playerid][2]+=random(3)+1;
	        }
        else if(slot < 20)
	        {
	            Slots[playerid][1]+=random(3)+1;
	            Slots[playerid][2]+=random(3)+1;
	        }
        else
	        {
	            Slots[playerid][0]+=random(3)+1;
	            Slots[playerid][1]+=random(3)+1;
	            Slots[playerid][2]+=random(3)+1;
	        }
        if(Slots[playerid][0] >= 6) Slots[playerid][0] = 0;
        if(Slots[playerid][1] >= 6) Slots[playerid][1] = 0;
        if(Slots[playerid][2] >= 6) Slots[playerid][2] = 0;
        ShowPlayerSlots(playerid,Slots[playerid][0],Slots[playerid][1],Slots[playerid][2]);
        if(SlotCounter[playerid] == 0)
	        {
	            KillTimer(SlotTimer[playerid]);
	            SlotTimer[playerid] = -1;
	            Gambling[playerid] = G_STATE_DISPLAY;
				new string[128];
	            if(Slots[playerid][0] == Slots[playerid][1] && Slots[playerid][0] == Slots[playerid][2])
		            {
		                new multiplier=1;
		                switch(Slots[playerid][0])
			                {
			                    case 0: multiplier = 25;    // Cherries
			                    case 1: multiplier = 100;   // Grapes
			                    case 2: multiplier = 250;   // 69's
			                    case 3: multiplier = 500;   // Bells
			                    case 4: multiplier = 1000;  // Bar
			                    case 5: multiplier = 2000;  // Double Bars
			                }
		                new money = Bet[playerid]*multiplier;
						if(langue[playerid] == 0) format(string, sizeof(string), "Bravo, tu as gagné $%d.", money);
						else if(langue[playerid] == 1) format(string, sizeof(string), "Well done, you win $%d.", money);
						SendClientMessage(playerid, VERT_CLAIR, string);
						if(money > 1000000)
							{
								if(langue[playerid] == 0) format(string, sizeof(string), "~g~%s a gagné %d $ !", GetName(playerid), money);
								ConvertGameText(string);
								for(new i = 0; i < MAX_PLAYERS; i++) if(langue[i] == 0) GameTextForPlayer(i, string, 5000, 4);
 								if(langue[playerid] == 1) format(string, sizeof(string), "~g~%s won %d $ !", GetName(playerid), money);
								for(new i = 0; i < MAX_PLAYERS; i++) if(langue[i] == 1) GameTextForPlayer(i, string, 5000, 4);
							}
						casino10[playerid] ++;
						if(casino10[playerid] >= 7) GivePlayerExp(playerid, 50);
						if(casino10[playerid] == 10 && inventidobjet[playerid] != 2710)
							{
								if(langue[playerid] == 0)
									{
										SendClientMessage(playerid, VERT_CLAIR, "Tu as gagné un fer à cheval ! Tous tes rêves deviendront réalité !");
						        		GivePlayerInventoryObject(playerid, "Fer a cheval", 954, 0, 0, 0);
									}
								else if(langue[playerid] == 1)
									{
										SendClientMessage(playerid, VERT_CLAIR, "You won a horseshoe ! All your dreams can finally come true !");
						        		GivePlayerInventoryObject(playerid, "Horseshoe", 954, 0, 0, 0);
						        	}
								casino10[playerid] = 0;
							}
		                GivePlayerCash(playerid, money);
		                UpdateBetText(playerid);
		                Slots[playerid][0] = random(5); // Randomize the slots again
		                Slots[playerid][1] = random(5);
		                Slots[playerid][2] = random(5);
		            }
	            else
		            {
						if(langue[playerid] == 0) format(string, sizeof(string), "Tu as perdu $%d !", Bet[playerid]);
						else if(langue[playerid] == 1) format(string, sizeof(string), "You lost $%d !", Bet[playerid]);
						SendClientMessage(playerid, ROUGE, string);
						casino10[playerid] = 0;
		            }
	            SetTimerEx("PlayAgainTimer", DISPLAY_TIME, 0, "i", playerid);
	            return 1;
	        }
        return 0;
	}

public PlayAgainTimer(playerid)
	{
        Gambling[playerid] = G_STATE_READY;
        // Remove the following 3 lines to disable the ability to hold down SPRINT
        new keys,lr,ud;
        GetPlayerKeys(playerid,keys,ud,lr);
        if(keys & KEY_SPRINT) OnPlayerKeyStateChange(playerid,KEY_SPRINT,0);
	}

UpdateBetText(playerid)
	{
	    new str[128];
	    if(langue[playerid] == 0) format(str,sizeof(str),"~y~Mise: ~r~%d~g~$",Bet[playerid]);
	    else if(langue[playerid] == 1) format(str,sizeof(str),"~y~Bet: ~r~%d~g~$",Bet[playerid]);
	    PlayerTextDrawSetString(playerid, BetText[playerid], str);
	}

public OnPlayerCommandText(playerid, cmdtext[])
	{
        new cmd[128],idx;
        cmd = strtok(cmdtext,idx);
        if (strcmp(cmd, "/gamble", true) == 0)
	        {
	            cmd = strtok(cmdtext,idx);
	            if(!strlen(cmd))
					{
						if(langue[playerid] == 0) SendClientMessage(playerid, ROUGE, "USAGE: /bandit [SOMME]");
						else if(langue[playerid] == 1) SendClientMessage(playerid, ROUGE, "USAGE: /bandit [AMOUNT]");
						return 1;
					}
	            new money = strval(cmd);
	            if(money < 5000)
					{
						if(langue[playerid] == 0) SendClientMessage(playerid, ROUGE, "Mise minimum: 5000 $ !");
						else if(langue[playerid] == 1) SendClientMessage(playerid, ROUGE, "Minimum bet: 5000 $!");
						return 1;
					}
	            if(money > GetPlayerCash(playerid))
					{
						if(langue[playerid] == 0) SendClientMessage(playerid, ROUGE, "Vous n'avez pas assez d'argent !");
						else if(langue[playerid] == 1) SendClientMessage(playerid, ROUGE, "You have not got enough paper!");
						return 1;
					}
	            if(money > 1000000)
					{
						if(langue[playerid] == 0) SendClientMessage(playerid, ROUGE, "Mise maximum: 1.000.000 $ !");
						else if(langue[playerid] == 1) SendClientMessage(playerid, ROUGE, "Maximum bet: 1.000.000 $!");
						return 1;
					}
				if(Gambling[playerid] != G_STATE_NOT_GAMBLING)
					{
						if(langue[playerid] == 0) SendClientMessage(playerid, ROUGE, "Vous jouez déjà !");
						else if(langue[playerid] == 1) SendClientMessage(playerid, ROUGE, "Already gambling!");
						return 1;
					}
				PutPlayerInSlotMachine(playerid, money);
	            return 1;
	        }
        return 0;
	}
