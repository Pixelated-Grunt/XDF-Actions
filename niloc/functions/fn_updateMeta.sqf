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
 * ["delete", "key", ["value_1", "value_2"]] call XDF_fnc_updateMeta //replace value to given array
 *
 * Public: No
**/


params [
    ["_action", "add", [""]],
    ["_targetSection", "", [""]],
    ["_targetKey", "", ["", []]]
];

private ["_updateOk", "_inidbi", "_value", "_metaValue"];

_updateOk = false;
_inidbi = [] call FUNCMAIN(getDbInstance);
_value = ["read", ["meta", _targetSection, []]] call _inidbi;

if (_action == "add") then {
    _value pushBackUnique _targetKey;
    _updateOk = ["write", ["meta", _targetSection, _value]] call _inidbi;
} else {
    if ((_action == "delete") && (count _value > 0)) then {
        if (_targetKey isEqualType []) then {
            LOG_1("_targetKey: (%1).", _targetKey);
            ["meta", [_targetSection, _targetKey]] call FUNCMAIN(putSection)
        } else { _updateOk = ["write", ["meta", _targetSection, (_value - [_targetKey])]] call _inidbi }
    } else {
        WARNING_2("Key (%1) doesn't exist in meta or it's a wrong type for the value (%2) to be deleted.", _targetSection, _targetKey)
    };
};

// Update itself
_metaValue = ["read", ["meta", "meta", []]] call _inidbi;

// Create meta section meta key the 1st time
if (count _metaValue == 0) then { _metaValue pushBackUnique "meta" };

_metaValue pushBackUnique _targetSection;
_updateOK = ["write", ["meta", "meta", _metaValue]] call _inidbi;

_updateOk
