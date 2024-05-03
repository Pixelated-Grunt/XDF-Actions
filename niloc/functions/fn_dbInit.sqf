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

_dbName = (missionName regexReplace ["(%20|%2e)/g", "_"]) regexReplace ["_*[vV]_*[0-9]+.*$/g", ""];
_iniDBi = ["new", _dbName] call OO_iniDBi;
_success = false;

if !isNil(QUOTE(_iniDBi)) then {
    private ["_sessionHash", "_sessionNumber", "_saveCount", "_lastSave"];

    _sessionHash = createHashMap;
    _sessionNumber = ["read", ["session", "session.number", 0]] call _iniDBi;
    _saveCount = ["read", ["session", "session.save.count", 0]] call _iniDBi;
    _lastSave = ["read", ["session", "session.last.save", 0]] call _iniDBi;

    missionNamespace setVariable [QGVAR(Db), _iniDBi, true];

    if (_sessionNumber != 0) then {
        // Purge existing section hashmap and db before write
        INFO("Purging previous session section data.");
        if !(["deleteSection", "session"] call _iniDBi) exitWith {
            ERROR("Failed to delete session section from database.");
            false
        };
    };

    if (_lastSave > 0) then { _sessionNumber = _sessionNumber + 1 };
    _sessionHash set ["session.number", _sessionNumber];
    _sessionHash set ["session.save.count", _saveCount];
    _sessionHash set ["session.start", systemTime];
    _sessionHash set ["session.start.utc", systemTimeUTC];
    _sessionHash set ["session.start.game", date];
    _sessionHash set ["session.start.units", count (ALIVE_AIS)];
    _sessionHash set ["session.start.vehicles", count (ALL_VEHICLES)];
    _sessionHash set ["session.last.save", 0];
    _sessionHash set ["session.last.load", 0];
    _sessionHash set ["session.loaded.markers", 0];
    _sessionHash set ["session.loaded.profiles", []];

    if (["session", [_sessionHash]] call FUNCMAIN(putSection) == 0) then {
        ERROR("Failed to write session data into database.");
        _success = false
    } else {
        missionNamespace setVariable [QGVAR(dbName), _dbName, true];
        missionNamespace setVariable [QGVAR(sessionNumber), _sessionNumber, true];
        missionNamespace setVariable [QGVAR(saveCount), _saveCount, true];
        missionNamespace setVariable [QGVAR(sessionStart), _sessionHash get "session.start", true];
        missionNamespace setVariable [QGVAR(sessionStartUtc), _sessionHash get "session.start.utc", true];
        missionNamespace setVariable [QGVAR(lastLoad), 0, true];
        missionNamespace setVariable [QGVAR(loadedMarkers), 0, true];
        missionNamespace setVariable [QGVAR(loadedProfiles), [], true];
        _success = true
    };
} else { ERROR("Failed to create a new IniDBI2 database instance.") };

_success
