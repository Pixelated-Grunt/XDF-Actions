#include "script_macros.hpp"
/*
 * Author: Pixelated_Grunt
 * Restore data for all players from the database
 *
 * Arguments:
 * Nil
 *
 * Return Value:
 * Total number of players restored <NUMBER>
 *
 * Example:
 * [] call XDF_fnc_restorePlayersStates
 *
 * Public: No
**/


private _allPlayers = ALIVE_PLAYERS;
private _count = 0;

{
    if ([_x] call FUNCMAIN(restorePlayerState)) then {
        _count = _count + 1;
    } else { INFO_1("Player object (%1) has no saved record in the database.", str _x) };
} forEach _allPlayers;

_count
