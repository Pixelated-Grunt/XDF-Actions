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
 * _inidbi = [] call niloc_fnc_getDbInstance
 *
 * Public: No
 */


private _inidbi = localNamespace getVariable [QGVAR(instance), ""];

if IS_CODE(_inidbi) then {
    _inidbi
} else {
    ERROR("Database instance does not exist.");
    objNull
}
