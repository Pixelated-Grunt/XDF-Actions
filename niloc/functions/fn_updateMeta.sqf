#include "script_macros.hpp"
/*
 * Author: Pixelated_Grunt
 * Add or delete values in meta section
 *
 * Arguments:
 * 0: Action to perform either add or remove <STRING> {default: add}
 * 1: Key to be added <STRING>
 * 2: Value to be added <STRING>
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

private ["_section", "_updateOk", "_iniDBi", "_recInDb"];

_section = "meta";
_updateOk = false;
_iniDBi = [] call FUNCMAIN(getDbInstance);
_recInDb = ["read", [_section, _targetSection]] call _iniDBi;

if (_action == "add") then {
    if (typeName _recInDb isEqualTo "ARRAY") then {
        _recInDb pushBackUnique _targetKey;
        _updateOk = ["write", [_section, _targetSection, _recInDb]] call _iniDBi;
    } else {
        _updateOk = ["write", [_section, _targetSection, [_targetKey]]] call _iniDBi;
    };
} else {
    if ((_action == "delete") && (typeName _recInDb isEqualTo "ARRAY")) then {
        _updateOk = ["write", [_section, _targetSection, (_recInDb - [_targetKey])]] call _iniDBi;
    } else { WARNING_2("Key (%1) doesn't exist in meta for the value (%2) to be deleted.", _targetSection, _targetKey) };
};

_updateOk
