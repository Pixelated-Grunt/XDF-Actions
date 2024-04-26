#include "script_macros.hpp"
/*
 * Author: Pixelated_Grunt
 * Add child actions to ace menu
 *
 * Arguments:
 * Nil
 *
 * Return Value:
 * Nil
 *
 * Example:
 * [] call XDF_fnc_nilocChildActions
 *
 * Public: No
**/


params ["_target"];

private ["_action", "_actions", "_loadIcon", "_saveIcon"];

_loadIcon = "a3\ui_f\data\igui\cfg\simpletasks\types\upload_ca.paa";
_saveIcon = "a3\ui_f\data\igui\cfg\simpletasks\types\download_ca.paa";
_actions = [];

// Load action
_action = [
    "Load",
    "Load Mission",
    _loadIcon,
    { [_this # 1] remoteExec [QFUNCMAIN(loadWorld), 2] },
    { true },
    {},
    nil,
    nil,
    nil,
    nil,
    {
        params ["", "_player", "", "_actionData"];

        _actionData set [2, [_loadIcon], _player getVariable [QGVAR(loadStatusColour), HEX_WHITE]];
    }
] call ace_interact_menu_fnc_createAction;
_actions pushBack [_action, [], _target];

// Save action
_action = [
    "Save",
    "Save Mission",
    _saveIcon,
    { [_this # 1] remoteExec [QFUNCMAIN(saveWorld), 2] },
    { true },
    {},
    nil,
    nil,
    nil,
    nil,
    {
        params ["", "_player", "", "_actionData"];

        _actionData set [2, [_loadIcon], _player getVariable [QGVAR(saveStatusColour), HEX_WHITE]];
    }
] call ace_interact_menu_fnc_createAction;
_actions pushBack [_action, [], _target];

_actions
