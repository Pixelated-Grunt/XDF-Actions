#include "script_macros.hpp"
/*
 * Author: Pixelated_Grunt
 * Save data of all players
 *
 * Arguments:
 * 0: Save all or a single player record <OBJECT> {default: objNull}
 *
 * Return Valuej:
 * Return number of player record saved <NUMBER>
 *
 * Example:
 * [] call XDF_fnc_savePlayersStates
 *
 * Public: Yes
**/


params [["_playerObj", objNull, [objNull]]];

private ["_allPlayers", "_count"];

_count = 0;
_allPlayers = ALLPLAYERS;

if (!isNull _playerObj) then {
    _allPlayers = [_playerObj];
};

{
    private _playerHash = ["player", _x] call FUNCMAIN(prepUnitData);
    private _putOk = 0;

    _putOk = ["players", [str _x, toArray(_playerHash)]] call FUNCMAIN(putSection);
    if (_putOk > 0) then {
        _count = _count + 1;
    } else { ERROR_1("Failed to write states for player (%1).", str _x) }
} forEach _allPlayers;

_count
