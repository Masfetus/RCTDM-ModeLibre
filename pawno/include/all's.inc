/*
Include ALL'S By Dim_Jhonny
Merci à leo3412 qui m'a entièrement aidé à développer cette include
*/

#if defined _all's_included
	#endinput
#endif
#define _all's_included
#pragma library all's

// Natives

native GiveAllPlayersWeapons(id arme,munitions);
native GiveAllPlayerMoney(argent);
native FreezeAllPlayersConnect();
native UnfreezeAllPlayersConnect();
native KillAllEx();

stock GiveAllPlayersWeapons(weaponid, ammo) // By leo3412 (Vous pouvez modifier les crédits ;))
{



for(new i = 0; i < MAX_PLAYERS; i++)
    {
        if(IsPlayerConnected(i))
        {
            GivePlayerWeapon(i, weaponid, ammo);





}



}
}

stock GiveAllPlayersMoney(money) // By leo3412 (Vous pouvez modifier les crédits ;))
{



for(new i = 0; i < MAX_PLAYERS; i++)
    {
        if(IsPlayerConnected(i))
        {
            GivePlayerMoney(i, money);





}



}
}
stock FreezeAllPlayersConnect() // By leo3412 (Vous pouvez modifier les crédits ;))
{



for(new i = 0; i < MAX_PLAYERS; i++)
    {
        if(IsPlayerConnected(i))
        {
            TogglePlayerControllable(i, 0);





}



}
}
stock UnFreezeAllPlayersConnect() // By leo3412 (Vous pouvez modifier les crédits ;))
{



for(new i = 0; i < MAX_PLAYERS; i++)
    {
        if(IsPlayerConnected(i))
        {
            TogglePlayerControllable(i, 1);





}



}
}
stock KillAllPlayerEx() // By leo3412 (Vous pouvez modifier les crédits ;))
{
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
        if(IsPlayerConnected(i))
        {
            SetPlayerHealth(i, 0); // On met la vie des joueurs connectés à 0
        }
    }
}


