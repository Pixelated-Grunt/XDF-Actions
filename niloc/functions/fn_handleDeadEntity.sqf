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

if ((isPlayer _object) || !((IS_UNIT(_object)) || (IS_VEHICLE(_object)))) exitWith { LOG("Not recording dead entity."), false };

private ["_count", "_side", "_objStr", "_objtype"];

_side = str side _object;
_objStr = str _object;
_count = 0;

if (IS_UNIT(_object)) then { _objType = "units" } else { _objType = "vehicles" };
_count = ["dead." + _objType, [_objStr, [typeOf _object, getPosASL _object, _side]]] call FUNCMAIN(putSection);

// NOTE: 0 is a valid case, since an entity can be dead before the save happens
if (_count > 0) then {
    private _section = (if (_objType == "units") then [{ _objType + "." + _side }, { _objType }]);
    private _sectionHash = [_section] call FUNCMAIN(getSectionAsHashmap);

    // NOTE: If the unit is inside a vehicle, it will not be found.
    // It is okay since the function that removes destroyed vehicles should handle it.
    if (_objStr in _sectionHash) then {
        if ([_section, _objStr] call FUNCMAIN(deleteSectionKey)) then {
            true
        } else {
            ERROR_2("Dead entity (%1) recorded successfully but failed at removing from alive section (%2).", _objStr, _section)
        };
    };
}
