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


private ["_dbName", "_iniDBi"];

_dbName = missionName call CBA_fnc_removeWhitespace;
_iniDBi = ["new", _dbName] call OO_iniDBi;

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
    };

    _sessionHash set ["session.start", systemTime];
    _sessionHash set ["session.start.utc", systemTimeUTC];

    ["session", [_sessionHash]] call FUNCMAIN(putSection);

    INFO("Database initialised successfully.");
    true;
} else {
    ERROR("NiLoc database failed to initialised.");
    false;
}
