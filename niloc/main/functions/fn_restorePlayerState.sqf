#include "script_macros.hpp"
/*
 * Author: Pixelated_Grunt
 * Restore data for a given player
 *
 * Arguments:
 * 0: Player object or player ID to be restored <OBJECT|STRING>
 * 1: Saved UID record in database to use <STRING>
 *
 * Return Value:
 * Successful restored player state <BOOL>
 *
 * Example:
 * [] call niloc_fnc_restorePlayerState
 *
 * Public: No
**/


if (!isServer) exitWith {};
params [
    ["_player", objNull, [objNull, ""]],
    ["_uid", "", [""]]
];

private ["_sectionHash", "_playerHash", "_playerId", "_playerUid", "_playerObj"];

if IS_OBJECT(_player) then {
    _playerObj = _player;
    _playerId = getPlayerID _playerObj;
} else {
    _playerId = _player;
    _playerObj = (getUserInfo _playerId) # 10;
};

_playerUid = if (_uid != "") then [{_uid}, {(getUserInfo _playerId) select 2}];
_sectionHash = ["players", [_playerUid]] call FUNCMAIN(getSectionAsHashmap);

if (count _sectionHash == 0) exitWith { WARNING_1("Can't find player UID (%1) in the database.", _playerUid); false };
_playerHash = ((_sectionHash get _playerUid) select 0) createHashMapFromArray ((_sectionHash get _playerUid) select 1);

{
    private _stat = _x;
    private _value = _y;

    switch (_stat) do {
        case "playerName": {
            private _sessionHash = ["session", ["session.loaded.players"]] call FUNCMAIN(getSectionAsHashmap);
            private _data = _sessionHash get "session.loaded.players";

            if (count _sessionHash == 0) then { _data = [] };
            _data pushBackUnique _value;
            ["session", ["session.loaded.players", _data]] call FUNCMAIN(putSection)
        };
        case "playerUid": {};
        case "location": {};
        case "loadout": { _playerObj setUnitLoadout _value };
        case "damage": {
            if HASACE3 then {
                [_playerObj, _value] remoteExec ["ace_medical_fnc_deserializeState", _playerObj]
            } else { _playerObj setDamage _value }
        };
        case "captive": {
            if (_value) then {
                if (HASACE3) then {
                    [_playerObj, _value] remoteExec ["ACE_captives_fnc_setHandcuffed", _playerObj]
                } else {
                    [_playerObj, _value] remoteExec ["setCaptive", _playerObj]
                }
            }
        };
        case "rations": {
            _value params ["_hunger", "_thirst"];

            _playerObj setVariable ["acex_field_rations_hunger", _hunger];
            _playerObj setVariable ["acex_field_rations_thirst", _thirst]
        };
        case "vehicle": {};
        default {}
    }
} forEach _playerHash;

true
