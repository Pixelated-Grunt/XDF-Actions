#include "script_macros.hpp"
/*
 * Author: Pixelated_Grunt
 * Initialises the database based on name of mission
 *
 * Arguments:
 * Nil
 *
 * Return Value:
 * Section data successfully returned <BOOL>
 *
 * Example:
 * [] call XDF_fnc_dbInit
 *
 * Public: No
**/


private ["_dbName", "_iniDBi", "_success"];

_dbName = missionName call CBA_fnc_removeWhitespace;
_iniDBi = ["new", _dbName] call OO_iniDBi;
_success = false;

if !isNil(QUOTE(_iniDBi)) then {
    private "_sessionHash";

    missionNamespace setVariable [QGVAR(Db), _iniDBi, true];
    _sessionHash = ["session"] call FUNCMAIN(getSectionAsHashmap);

    if (count _sessionHash == 0) then {
        // New session.number
        _sessionHash set ["session.number", 1];
    } else {
        // Continue of session.number
        _sessionHash set ["session.number", (_sessionHash get "session.number") + 1];
        // Purge existing section before write
        if !(["deleteSection", "session"] call _iniDBi) exitWith {
            ERROR("Failed to delete session section from database.");
            false
        };
    };

    _sessionHash set ["session.start", systemTime];
    _sessionHash set ["session.start.utc", systemTimeUTC];
    _sessionHash set ["session.start.game", date];
    _sessionHash set ["session.start.units", count (ALIVE_AIS)];
    _sessionHash set ["session.start.vehicles", count (ALL_VEHICLES)];
    _sessionHash set ["session.last.save", 0];
    _sessionHash set ["session.last.load", 0];

    if (["session", [_sessionHash]] call FUNCMAIN(putSection) == 0) then {
        ERROR("Failed to write session data into database.");
        _success = false
    } else { _success = true };
} else { ERROR("Failed to create a new IniDBI2 database instance.") };

_success
