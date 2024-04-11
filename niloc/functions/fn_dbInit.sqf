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
 */

if (!isServer) exitWith {ERROR("NiLoc only works in multipler mode.")};

private ["_dbName", "_iniDBi", "_fnc_toDB"];

_dbName = missionName call CBA_fnc_removeWhitespace;
_iniDBi = ["new", _dbName] call OO_iniDBi;

_fnc_toDB = {
    params ["_key", "_value"];

    ["write", ["session", _key, _value]] call _iniDBi;
};

if !isNil(QUOTE(_iniDBi)) then {
    private "_sessionHash";

    missionNamespace setVariable [QUOTE(GVAR(DB)), _iniDBi, true];
    _sessionHash = ["session"] call FUNCMAIN(getSection);

    if (count _sessionHash == 0) then {
        // New session.number
        _sessionHash set ["session.number", 1];
    } else {
        // Continue of session.number
        _sessionHash set ["session.number", (_sessionHash get "session.number") + 1];
    };

    _sessionHash set ["session.start", systemTime];
    _sessionHash set ["session.start.utc", systemTimeUTC];

    {
        [_x, _y] call _fnc_toDB;
    } forEach _sessionHash;

    INFO("Database initialised successfully.");
    true;
} else {
    ERROR("NiLoc database failed to initialised.");
    false;
}
