	    ////-/////-/////-/////-/////-/////-/////-/////-/////-/////-/////-/////-/////-//
	   //							   Anti-Money-Hack								//
	  //								 FoxMoney v2		 					   //
	 //					       COPYRIGHT BY FOXHOUND / PSPGAMER					  //
	////-/////-/////-/////-/////-/////-/////-/////-/////-/////-/////-/////-/////-//

//------< INCLUDEs >------//
	#include <a_samp>
//------------------------//

//----------< OPTIONS >---------//
//	#define I_USE_SETPLMONEY	// UNcomment this, if you have already defined SetPlayerMoney (STANDART: Commented)
	#define SERVER_SIDE_MONEY	// Comment this (//), if you don't want to use the ServerSide-Money Function (NOT RECOMENDED TO COMMENT IT, IT'S USEFUL) (STANDART: Uncommented)
//	#define WRITE_IN_SERVERLOG	// UNcomment this, if you want to log cheaters (it's not really needed) (STANDART: Commented)
	#define MONEYCHECK_TIME 2	// All 5 Seconds, the Money of a Player will be checked (time-in-seconds) (STANDART: 2 Sec)
//------------------------------//

//----------------< DEFINEs >---------------//
	#define FXM_LOG_DIR "FoxMoney_Log.txt"
//------------------------------------------//

//------------------------< FORWARDs >------------------------//
	#if defined I_USE_SETPLMONEY
		forward FXM_SetPlayerMoney(playerid, newmoney);
	#else
		forward SetPlayerMoney(playerid, newmoney);
	#endif
	forward FXM_GivePlayerMoney(playerid, money);
	forward FXM_GetPlayerMoney(playerid);
	forward FXM_ResetPlayerMoney(playerid);
	forward FXM_OnPlayerConnect(playerid);
	forward FXM_OnPlayerDisconnect(playerid,reason);
	forward fxm_player_money_checker(playerid);
//------------------------------------------------------------//

//----------------------< NEW CALLBACK >----------------------//
	forward OnPlayerCheatMoney(playerid,newmoney,oldmoney);
//------------------------------------------------------------//

//--------------< NEWs >--------------//
	new FXM_playerMoney[MAX_PLAYERS];
	new FXM_MoneyCheckTimer[MAX_PLAYERS];
//------------------------------------//

//-------------------------------------------< OnPlayer(Dis)Connect >-------------------------------------------//
public OnPlayerConnect(playerid) {
	FXM_MoneyCheckTimer[playerid] = SetTimerEx("fxm_player_money_checker",MONEYCHECK_TIME*1000,1,"i",playerid);
	return CallLocalFunction("FXM_OnPlayerConnect","i",playerid); }
public OnPlayerDisconnect(playerid,reason) {
	KillTimer(FXM_MoneyCheckTimer[playerid]);
	return CallLocalFunction("FXM_OnPlayerDisconnect","id",playerid,reason); }
//--------------------------------------------------------------------------------------------------------------//

//-------------------< PLAYER MONEY CHECKER >-------------------//
public fxm_player_money_checker(playerid)
{
	new pName[MAX_PLAYER_NAME];
	GetPlayerName(playerid,pName,sizeof(pName));
	if(GetPlayerMoney(playerid) > FXM_playerMoney[playerid])
	{
		#if defined WRITE_IN_SERVERLOG
			printf("[FOXMONEY] MoneyCheat Detected: Player '%s' - Cheated Money: %d$ - OldMoney: %d$ - New Money: %d$\r\n",pName,GetPlayerMoney(playerid)-FXM_playerMoney[playerid],FXM_playerMoney[playerid],GetPlayerMoney(playerid));
            #if defined SERVER_SIDE_MONEY
                ResetPlayerMoney(playerid);GivePlayerMoney(playerid,FXM_playerMoney[playerid]);
				printf("[FOXMONEY] Setting '%s's money to original amount(%d$). Player Current Money: %d$\r\n",pName,FXM_playerMoney[playerid],GetPlayerMoney(playerid));
			#endif
		#endif
		new newmoney[MAX_PLAYERS], oldmoney[MAX_PLAYERS];
		newmoney[playerid] = GetPlayerMoney(playerid);
		oldmoney[playerid] = FXM_playerMoney[playerid];
		CallLocalFunction("OnPlayerCheatMoney","idd",playerid,newmoney[playerid],oldmoney[playerid]);
	}
	else if(GetPlayerMoney(playerid) < FXM_playerMoney[playerid]) { FXM_playerMoney[playerid] = GetPlayerMoney(playerid); }
}
//--------------------------------------------------------------//

//-------------< NEW FUNCTIONS >-------------//
#if defined I_USE_SETPLMONEY
	public FXM_SetPlayerMoney(playerid, newmoney) {
		if(IsPlayerConnected(playerid)) {
			FXM_playerMoney[playerid] = newmoney;
			ResetPlayerMoney(playerid);
			GivePlayerMoney(playerid,newmoney);
			return true; }
		return false; }
#else
	public SetPlayerMoney(playerid, newmoney) {
		if(IsPlayerConnected(playerid)) {
			ResetPlayerMoney(playerid);
			FXM_playerMoney[playerid]=newmoney;
			GivePlayerMoney(playerid,FXM_playerMoney[playerid]);
			return true; }
		return false; }
#endif

public FXM_GivePlayerMoney(playerid, money) {
	if(IsPlayerConnected(playerid)) {
		FXM_playerMoney[playerid]=(FXM_playerMoney[playerid]+money);
		ResetPlayerMoney(playerid);
		GivePlayerMoney(playerid,FXM_playerMoney[playerid]);
		return true; }
	return false; }
public FXM_GetPlayerMoney(playerid) {
	if(IsPlayerConnected(playerid)) {
		return FXM_playerMoney[playerid]; }
	return false; }
public FXM_ResetPlayerMoney(playerid) {
	if(IsPlayerConnected(playerid)) {
		FXM_playerMoney[playerid]=0;
		ResetPlayerMoney(playerid);
		GivePlayerMoney(playerid,FXM_playerMoney[playerid]);
		return true; }
	return false; }
//-------------------------------------------//

#if defined I_USE_SETPLMONEY
	#define SetPlayerMoney FXM_SetPlayerMoney
#endif
#define GivePlayerMoney FXM_GivePlayerMoney
#define GetPlayerMoney FXM_GetPlayerMoney
#define ResetPlayerMoney FXM_ResetPlayerMoney
#define OnPlayerConnect FXM_OnPlayerConnect
#define OnPlayerDisconnect FXM_OnPlayerDisconnect