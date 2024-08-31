#include "..\script_component.hpp"
/*
 * Author: Pixelated_Grunt
 * Return object from matching string for AIs and Vehicles only.
 *
 * Arguments:
 * 0: String of the object to match <STRING>
 * 1: Array of objects <ARRAY>
 *
 * Return Value:
 * Object if found <OBJECT> (default: objNull)
 *
 * Example:
 * _unit = ["B Alpha 1-1:1", allUnits] call niloc_fnc_getObjFromStr
 *
 * Public: No
**/


params [
    ["_objStr", "", [""]],
    ["_objects", [], [[]]]
];

private _object = objNull;

// Tagged vehicle
if ("vic_" in _objStr) then {
    {
        private _vicVar = _x getVariable [QGVAR(tag), nil];

        if (_vicVar isEqualTo _objStr) exitWith { _object = _x };
    } forEach _objects;
} else {    // AI
    {
        if (str _x isEqualTo _objStr) exitWith { _object = _x };
    } forEach _objects;
};

_object
