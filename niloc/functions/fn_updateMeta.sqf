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

private ["_updateOk", "_iniDBi", "_value", "_metaValue"];

_updateOk = false;
_iniDBi = [] call FUNCMAIN(getDbInstance);
_value = ["read", ["meta", _targetSection, []]] call _iniDBi;

if (_action == "add") then {
    _value pushBackUnique _targetKey;
    _updateOk = ["write", ["meta", _targetSection, _value]] call _iniDBi;
} else {
    if ((_action == "delete") && (count _value > 0)) then {
        _updateOk = ["write", ["meta", _targetSection, (_value - [_targetKey])]] call _iniDBi;
    } else { WARNING_2("Key (%1) doesn't exist in meta or it's a wrong type for the value (%2) to be deleted.", _targetSection, _targetKey) };
};

// Update itself
_metaValue = ["read", ["meta", "meta", []]] call _iniDBi;

// Create meta section meta key the 1st time
if (count _metaValue == 0) then { _metaValue pushBackUnique "meta" };

_metaValue pushBackUnique _targetSection;
_updateOK = ["write", ["meta", "meta", _metaValue]] call _iniDBi;

_updateOk
