#include "..\script_component.hpp"
/*
 * Author: Pixelated_Grunt
 * Get sections from database that match the search string, empty search string returns all.
 *
 * Arguments:
 * 0: Optional the partial or full name of the section <STRING>
 * 1: Optional db instance <OBJECT>
 *
 * Return Value:
 * A list of matching names of sections <ARRAY> (default: [])
 *
 * Example:
 * _sectionTitles = ["units"] call niloc_fnc_getSectionNames
 *
 * Public: No
**/

params [
    ["_sstring", "", [""]],
    ["_db", "", ["", {}]]
];

private ["_sections", "_results"];

_results = [];
if (IS_CODE(_db)) then {
    _sections = keys (["meta", [], _db] call FUNCMAIN(getSectionAsHashmap));
} else {
    _sections = keys (["meta"] call FUNCMAIN(getSectionAsHashmap));
};

if ((count _sections > 1) && (_sstring != "")) then {
    _results = _sections select { _sstring in _x };
} else {
    _results = _sections
};

_results
