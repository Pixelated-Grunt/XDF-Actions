#include "script_macros.hpp"
/*
 * Author: Pixelated_Grunt
 * Add or delete values in meta section
 *
 * Arguments:
 * 0: Action to perform either add or remove <STRING> {default: add}
 * 1: Key to retrieve record from <STRING>
 * 2: Single value to be added or deleted <STRING>
 *
 * Return Value:
 * The successful of the operation <BOOL>
 *
 * Example:
 * ["delete", "key", "value"] call XDF_fnc_updateMeta
 *
 * Public: No
**/


params [
    ["_action", "add", [""]],
    ["_targetSection", "", [""]],
    ["_targetKey", "", [""]]
];

private ["_updateOk", "_iniDBi", "_value"];

_updateOk = false;
_iniDBi = [] call FUNCMAIN(getDbInstance);
_value = ["read", ["meta", _targetSection]] call _iniDBi;

if (_action == "add") then {
    if (typeName _value isEqualTo "ARRAY") then {
        _value pushBackUnique _targetKey;
        _updateOk = ["write", ["meta", _targetSection, _value]] call _iniDBi;
    } else {
        _updateOk = ["write", ["meta", _targetSection, [_targetKey]]] call _iniDBi;
    };
} else {
    if ((_action == "delete") && (typeName _value isEqualTo "ARRAY")) then {
        _updateOk = ["write", ["meta", _targetSection, (_value - [_targetKey])]] call _iniDBi;
    } else { WARNING_2("Key (%1) doesn't exist in meta or it's a wrong type for the value (%2) to be deleted.", _targetSection, _targetKey) };
};

_updateOk
