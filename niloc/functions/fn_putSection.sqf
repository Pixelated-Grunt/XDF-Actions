#include "script_macros.hpp"
/*
 * Author: Pixelated_Grunt
 * Internal function that provides an interface to put data to the database
 *
 * Arguments:
 * 0: The name of the section to write to <STRING>
 * 1: An array or array of arrays of keys and values to be written <ARRAY|HASHMAP>
 *
 * Return Value:
 * Number of records written <NUMBER>
 *
 * Example:
 * _count = ["section", [["key", "value"], ["key2", "value2"]]] call XDF_fnc_putSession
 *
 * Public: No
 */


params [
    ["_section", "", [""]],
    ["_data", [], [[], createHashMap]]
];
private ["_iniDBi", "_recordsPut"];

// If this check is done after getting the db global variable, error was thrown wtf?
if (isNil {missionNamespace getVariable QUOTE(GVAR(DB))}) exitWith {ERROR("Database instance doesn't exist.")};
_iniDBi = missionNamespace getVariable QUOTE(GVAR(DB));

_recordsPut = 0;

if ((typeName _data) isEqualTo "HASHMAP") then {
    {
        ["write", [_section, _x, _y]] call _iniDBi;
        _recordsPut = _recordsPut + 1;
    } forEach _data;
} else {
    if ((typeName (_data select 0)) isEqualTo "STRING") then {
        ["write", [_section, _data select 0, _data select 1]] call _iniDBi;
        _recordsPut = _recordsPut + 1;
    } else {
        // Array of arrays
        {
            ["write", [_section, _x select 0, _x select 1]] call _iniDBi;
            _recordsPut = _recordsPut + 1;
        } forEach _data;
    };
};

_recordsPut
