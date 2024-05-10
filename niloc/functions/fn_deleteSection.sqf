#include "script_macros.hpp"
/*
 * Author: Pixelated_Grunt
 * Internal function to delete a section from database and update meta
 *
 * Arguments:
 * 0: The name of the section to delete <STRING>
 *
 * Return Value:
 * Successfully delete section from database <BOOL>
 *
 * Example:
 * _result = ["players"] call XDF_fnc_deleteSection
 *
 * Public: No
**/


params ["_section"];

private _inidbi = [] call FUNCMAIN(getDbInstance);
private _res = ["deleteSection", _section] call _inidbi;

if (_res) then {
    ["delete", "meta", _section] call FUNCMAIN(updateMeta)
} else {
    WARNING_1("Failed to remove section (%1) from database.", _section)
};

_res
