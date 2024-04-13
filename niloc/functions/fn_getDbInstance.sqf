#include "script_macros.hpp"
/*
 * Author: Pixelated_Grunt
 * Check and return the database instance
 *
 * Arguments:
 * Nil
 *
 * Return Value:
 * Database instance <OBJECT>
 *
 * Example:
 * _iniDBi = [] call XDF_fnc_getDbInstance
 *
 * Public: No
 */


// If this check is done after getting the db global variable, error was thrown wtf?
if (isNil { missionNamespace getVariable QGVAR(Db) }) exitWith { ERROR("Database instance does not exist."); objNull };
private _iniDBi = missionNamespace getVariable QGVAR(Db);

_iniDbi
