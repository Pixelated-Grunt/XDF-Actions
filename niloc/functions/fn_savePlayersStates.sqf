#include "script_macros.hpp"
/*
 * Author: Pixelated_Grunt
 * Save data for a single or all players
 *
 * Arguments:
 * 0: Save a single player instead of all <OBJECT> {default: objNull}
 * 1: Player's UID <STRING>
 * 2: Player's name <STRING>
 *
 * Return Valuej:
 * Return number of player record saved <NUMBER>
 *
 * Example:
 * [] call XDF_fnc_savePlayersStates
 *
 * Public: No
**/


if (!isServer) exitWith { ERROR("NiLOC only runs on a server.") };
params [
    ["_playerObj", objNull, [objNull]],
    ["_uid", "", [""]],
    ["_name", "", [""]]
];

private ["_allPlayers", "_count", "_savedPlayers"];

_count = 0;
_allPlayers = ALL_PLAYERS;
_savedPlayers = missionNamespace getVariable [QGVAR(savedPlayers), createHashMap];

if (!isNull _playerObj) then {
    _allPlayers = [_playerObj];
};

{
    private _playerHash = ["player", _x, _uid, _name] call FUNCMAIN(prepUnitData);
    private _putOk = 0;

    // Deals with disconnected players with empty uid and name
    if ((_uid != "") && (_name != "")) then {
        _playerHash set ["playerUID", _uid];
        _playerHash set ["playerName", _name];
    };

    _putOk = ["players", [_playerHash get "playerUID", toArray(_playerHash)]] call FUNCMAIN(putSection);
    if (_putOk > 0) then {
        _count = _count + 1;
    };

    _savedPlayers set [_uid, _name];
} forEach _allPlayers;

missionNamespace setVariable [QGVAR(savedPlayers), _savedPlayers, true];

_count
