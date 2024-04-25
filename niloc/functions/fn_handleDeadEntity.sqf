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


if (!isServer) exitWith { ERROR("NiLOC only runs on a server.") };
params [["_object", objNull, [objNull]]];

if ((isPlayer _object) || !((IS_UNIT(_object)) || (IS_VEHICLE(_object)))) exitWith {
    LOG_1("Skip recording dead entity for (%1).", str _object);
    false
};

private ["_count", "_side", "_objStr", "_objtype"];

_side = str side group _object;
_objStr = str _object;
_count = 0;

// Write to dead.x section
if (IS_UNIT(_object)) then {
    _objType = "units"
} else {
    _objType = "vehicles";
    _objStr = _object getVariable [QGVAR(tag), _objStr];
};
_count = ["dead." + _objType, [_objStr, [typeOf _object, getPosASL _object, _side]]] call FUNCMAIN(putSection);

// Remove from alive section
if (_count > 0) then {
    private _section = (if (_objType == "units") then [{ _objType + "." + _side }, { _objType }]);
    private _sectionHash = [_section] call FUNCMAIN(getSectionAsHashmap);

    if (_objStr in _sectionHash) then {
        if ([_section, _objStr] call FUNCMAIN(deleteSectionKey)) then {
            true
        } else {
            ERROR_2("Dead entity (%1) recorded successfully but failed at removing from alive section (%2).", _objStr, _section)
        };
    };
}
