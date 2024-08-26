#include "script_macros.hpp"
/*
 * Author: Pixelated_Grunt
 * Add child actions to ace menu
 *
 * Arguments:
 * Nil
 *
 * Return Value:
 * List of ace menu actions <ARRAY>
 *
 * Example:
 * _actions = [] call XDF_fnc_nilocChildActions
 *
 * Public: No
**/


private ["_action", "_actions", "_loadIcon", "_saveIcon", "_saveCount"];

_saveCount = missionNamespace getVariable [QGVARMAIN(saveCount), 0];
_loadIcon = "a3\ui_f\data\igui\cfg\simpletasks\types\upload_ca.paa";
_saveIcon = "a3\ui_f\data\igui\cfg\simpletasks\types\download_ca.paa";
_actions = [];

// Load action
_action = [
    "Load",
    "Load Mission",
    _loadIcon,
    { [] call EFUNC(MAIN,clientLoadMission); },
    { _this # 2 # 1 > 0 },
    {},
    [_loadIcon, _saveCount],
    nil,
    nil,
    nil,
    {
        params ["", "_player", "_params", "_actionData"];

        _actionData set [2, [_params # 0, _player getVariable [QGVAR(loadStatusColour), HEX_WHITE]]];
    }
] call ace_interact_menu_fnc_createAction;
_actions pushBack [_action, [], SHORT_PREFIX];

// Save action
_action = [
    "Save",
    "Save Mission",
    _saveIcon,
    { [] call EFUNC(MAIN,clientSaveMission); },
    { true },
    {},
    _saveIcon,
    nil,
    nil,
    nil,
    {
        params ["", "_player", "_icon", "_actionData"];

        _actionData set [2, [_icon, _player getVariable [QGVAR(saveStatusColour), HEX_WHITE]]];
    }
] call ace_interact_menu_fnc_createAction;
_actions pushBack [_action, [], SHORT_PREFIX];

_actions
