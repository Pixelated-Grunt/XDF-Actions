#include "script_macros.hpp"
/*
 * Author: Pixelated_Grunt
 * Get sections from database that match the search string, empty search string returns all.
 *
 * Arguments:
 * 0: The partial name of the sections <STRING>
 *
 * Return Value:
 * A list of matching names of sections <ARRAY> (default: [])
 *
 * Example:
 * _sectionTitles = ["units"] call XDF_fnc_getSectionNames
 *
 * Public: No
**/

params [["_sstring", ["", [""]]]];

private ["_sections", "_results"];

_sections = keys (["meta"] call FUNCMAIN(getSectionAsHashmap));
_results = [];

if ((count _sections > 1) && (_sstring != "")) then {
    _results = _sections select { _sstring in _x };
};

_results
