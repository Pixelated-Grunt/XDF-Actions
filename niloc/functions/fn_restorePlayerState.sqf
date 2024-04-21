#include "script_macros.hpp"
/*
 * Author: Pixelated_Grunt
 * Restore data for a given player
 *
 * Arguments:
 * 0: Player to be restored <OBJECT>
 *
 * Return Value:
 * Successful restored player state <BOOL>
 *
 * Example:
 * [] call XDF_fnc_restorePlayerState
 *
 * Public: No
**/


params [["_playerObj", objNull, [objNull]]];

private ["_sectionHash", "_playerHash", "_playerUID"];

_playerUID = (getUserInfo (getPlayerID _playerObj)) select 2;
_sectionHash = ["players", [_playerUID]] call FUNCMAIN(getSectionAsHashmap);

if (count _sectionHash == 0) exitWith { false };
_playerHash = ((_sectionHash get _playerUID) select 0) createHashMapFromArray ((_sectionHash get _playerUID) select 1);

{
    private _stat = _x;
    private _value = _y;

    switch (_stat) do {
        case "playerName": {};
        case "playerUID": {};
        case "location": {};
        case "loadout": { _playerObj setUnitLoadout _value };
        case "damage": {
            if HASACE3 then {
                [_playerObj, _value] call ace_medical_fnc_deserializeState;
            } else { _playerObj setDamage _value }
        };
        case "vehicle": {};
        default {};
    }
} forEach keys _playerHash;

true
