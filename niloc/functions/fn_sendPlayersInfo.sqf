#include "script_macros.hpp"
/*
 * Author: Pixelated_Grunt
 * Send players info to client from server
 *
 * Arguments:
 * 0: Type of player info to send <STRING>
 * 1: Client who makes the request <OBJECT>
 *
 * Return Value:
 * Nil
 *
 * Example:
 * ["onlinePlayers", player] call XDF_fnc_sendPlayersInfo
 *
 * Public: No
**/


params ["_type", "_client"];

private _playersHash = createHashMap;

if (_type isEqualTo "onlinePlayers") then {
    private _onlinePlayers = ALL_PLAYERS;

    {
        private ["_id", "_name"];

        _id = getPlayerID _client;
        if (_id == "-1") then {
            WARNING_1("Failed to get player id from (%1).", str _x);
            continue
        };

        _name = getUserInfo _id select 3;
        _playersHash set [_name, _id]
    } forEach _onlinePlayers;

    _client setVariable [QGVAR(onlinePlayers), _playersHash, true]
} else {    // saved players
    private _savedPlayers = ["players"] call FUNCMAIN(getSectionAsHashmap);

    {
        private _player = (_y # 0) createHashMapFromArray (_y # 1);

        _playersHash set [_player get "playerName", _player get "playerUid"]
    } forEach _savedPlayers;

    _client setVariable [QGVAR(savedPlayers), _playersHash, true]
}
