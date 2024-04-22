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

if (count _sectionHash == 0) exitWith { WARNING_1("Can't find player UID (%1) in the database.", _playerUID); false };
_playerHash = ((_sectionHash get _playerUID) select 0) createHashMapFromArray ((_sectionHash get _playerUID) select 1);

{
    private _stat = _x;
    private _value = _y;

    switch (_stat) do {
        case "playerName": {
            private _sessionHash = ["session", ["session.player.loaded"]] call FUNCMAIN(getSectionAsHashmap);
            private _data = [];

            if (count _sessionHash > 0) then {
                _data = _sessionHash get "session.player.loaded";
            };

            ["session", ["session.player.loaded", _data append _stat]] call FUNCMAIN(putSection);
        };
        case "playerUID": {};
        case "location": {};
        case "loadout": { _playerObj setUnitLoadout _value };
        case "damage": {
            if HASACE3 then {
                [_playerObj, _value] call ace_medical_fnc_deserializeState;
            } else { _playerObj setDamage _value };
        };
        case "captive": { _playerObj setCaptive _playerObj };
        case "rations": {
            _playerObj setVariable ["acex_field_rations_hunger", _value select 0, 100];
            _playerObj setVariable ["acex_field_rations_thirst", _value select 1, 100];
        };
        case "vehicle": {};
        default {};
    }
} forEach keys _playerHash;

true
