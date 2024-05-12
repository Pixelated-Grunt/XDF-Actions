#include "script_macros.hpp"
/*
 * Author: Pixelated_Grunt
 * Send session info to client from server
 *
 * Arguments:
 * 0: Client who makes the request <OBJECT>
 *
 * Return Value:
 * Nil
 *
 * Example:
 * [player] call XDF_fnc_sendSessionInfo
 *
 * Public: No
**/


params [["_client", objNull, [objNull]]];

//_client setVariable [QGVAR(sessionInfo), nil];
private ["_inidbi", "_dbName", "_dbSession", "_sessionHash"];

_inidbi = [] call FUNCMAIN(getDbInstance);
_dbName = "getDbName" call _inidbi;
_dbSession = ["session"] call FUNCMAIN(getSectionAsHashmap);
_sessionHash = createHashMap;

_sessionHash set ["dbName", _dbName];
_sessionHash set ["sessionNumber", _dbSession get "session.number"];
_sessionHash set ["saveCount", _dbSession get "session.save.count"];
_sessionHash set ["sessionStart", _dbSession get "session.start"];
_sessionHash set ["sessionStartUtc", _dbSession get "session.start.utc"];
_sessionHash set ["lastLoad", _dbSession get "session.last.load"];
_sessionHash set ["loadedMarkers", _dbSession get "session.loaded.markers"];
_sessionHash set ["loadedPlayers", _dbSession get "session.loaded.players"];

_client setVariable [QGVAR(sessionInfo), _sessionHash]
