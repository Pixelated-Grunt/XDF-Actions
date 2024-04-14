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
private _idx = _objects findIf { str _x == _objStr };

if (_idx != -1) then { _object = _objects select _idx };

_object
