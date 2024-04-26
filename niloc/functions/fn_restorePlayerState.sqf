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

private ["_sectionHash", "_playerHash", "_playerID", "_playerUID"];

_playerID = getPlayerID _playerObj;
_playerUID = (getUserInfo _playerID) select 2;
_sectionHash = ["players", [_playerUID]] call FUNCMAIN(getSectionAsHashmap);

if (count _sectionHash == 0) exitWith { WARNING_1("Can't find player UID (%1) in the database.", _playerUID); false };
_playerHash = ((_sectionHash get _playerUID) select 0) createHashMapFromArray ((_sectionHash get _playerUID) select 1);

{
    private _stat = _x;
    private _value = _y;

    switch (_stat) do {
        case "playerName": {
            private _sessionHash = ["session", ["session.loaded.players"]] call FUNCMAIN(getSectionAsHashmap);
            private _data = _sessionHash get "session.loaded.players";

            if (count _sessionHash == 0) then { _data = [] };
            _data pushBackUnique _value;
            ["session", ["session.loaded.players", _data]] call FUNCMAIN(putSection);
        };
        case "playerUID": {};
        case "location": {};
        case "loadout": { _playerObj setUnitLoadout _value };
        case "damage": {
            if HASACE3 then {
                [_playerObj, _value] remoteExec ["ace_medical_fnc_deserializeState", _playerObj];
            } else { _playerObj setDamage _value };
        };
        case "captive": {
            if (_value) then {
                if (HASACE3) then {
                    [_playerObj, _value] remoteExec ["ACE_captives_fnc_setHandcuffed", _playerObj];
                } else {
                    [_playerObj, _value] remoteExec ["setCaptive", _playerObj];
                };
            };
        };
        case "rations": {
            _value params ["_hunger", "_thirst"];

            [_playerObj, ["acex_field_rations_hunger", _hunger]] remoteExec ["setVariable", _playerObj];
            [_playerObj, ["acex_field_rations_thirst", _thirst]] remoteExec ["setVariable", _playerObj];
        };
        case "vehicle": {};
        default {};
    };

} forEach _playerHash;

true
