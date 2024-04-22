#include "script_macros.hpp"
/*
 * Author: Pixelated_Grunt
 * Return object from matching string
 *
 * Arguments:
 * 0: String of the object to match <STRING>
 * 1: Array of objects <ARRAY>
 *
 * Return Value:
 * Object if found <OBJECT> (default: objNull)
 *
 * Example:
 * _unit = ["B Alpha 1-1:1", allUnits] call XDF_fnc_getObjFromStr
 *
 * Public: No
**/


params [
    ["_objStr", "", [""]],
    ["_objects", [], [[]]]
];

private _object = objNull;

// Vehicle?
if ("vic_" in _objStr) then {
    {
        if (_x getVariable[QGVAR(tag), nil] isEqualTo _objStr) exitWith { _x };
    } forEach _objects;
} else {
    {
        if ((getUserInfo(getPlayerID _x) select 2) isEqualTo _objStr) exitWith { _x };
    } forEach _objects;
};

_object
