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
 * Public: Yes
**/

params [["_sstring", ["", [""]]]];

private ["_iniDBi", "_sections", "_results"];

_iniDBi = [] call FUNCMAIN(getDbIntance);
_sections = "getSections" call _iniDBi;
_results = [];

if ((count _sections > 1) && (_sstring != "")) then {
    _results = _sections select { _sstring in _x };
};

_results
