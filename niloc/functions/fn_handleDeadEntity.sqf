#include "script_macros.hpp"
/*
 * Author: Pixelated_Grunt
 * Function called by EH to record a dead or destroyed entity
 *
 * Arguments:
 * 0: object to record <OBJECT>
 *
 * Return Value:
 * Whether the operation is successful <BOOL>
 *
 * Example:
 * [_unit] call XDF_fnc_handleDeadEntity
 *
 * Public: No
**/


params [["_object", objNull, [objNull]]];

private ["_count", "_objHash", "_side", "_objStr"];

_count = 0;
if (isPlayer _object) exitWith { false };

_objHash = createHashMap;
_side = str side _object;
_objStr = str _object;

_objHash set ["side", _side];
_objHash set ["type", typeOf _object];

_count = ["units.DEAD", [_objStr, toArray _objHash]] call FUNCMAIN(putSection);

if (_count > 0) then {
    private _section = "units." + _side;
    private _sectionHash = [_section] call FUNCMAIN(getSectionAsHashmap);

    // NOTE: If entity is a vehicle that an AI is in, it will not be removed.
    // It is okay since the function that removes destroyed vehicles should handle it.
    if (_objStr in _sectionHash) then {
        if ([_section, _objStr] call FUNCMAIN(deleteSectionKey)) then {
            true
        } else {
            ERROR_2("Dead entity (%1) recorded successfully but failed at removing from alive section (%2).", _objStr, _section)
        };
    };
} else { false };
