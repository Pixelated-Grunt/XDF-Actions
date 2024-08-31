#include "..\script_component.hpp"
/*
 * Author: Pixelated_Grunt
 * Add child actions to ace menu
 *
 * Arguments:
 * 0: The ace menu target <OBJECT>
 *
 * Return Value:
 * List of ace menu actions <ARRAY>
 *
 * Example:
 * _actions = [] call niloc_fnc_addChildActions
 *
 * Public: No
**/


params ["_target"];

private ["_action", "_actions", "_loadIcon", "_saveIcon", "_saveCount"];

_saveCount = missionNamespace getVariable [QEGVAR(main,saveCount), 0];
_loadIcon = "a3\ui_f\data\igui\cfg\simpletasks\types\upload_ca.paa";
_saveIcon = "a3\ui_f\data\igui\cfg\simpletasks\types\download_ca.paa";
_actions = [];

// Load action
_action = [
    "Load",
    "Load Mission",
    _loadIcon,
    { [] call FUNCMAIN(clientLoadMission) },
    { _this # 2 # 1 > 0 },
    {},
    [_loadIcon, _saveCount],
    nil,
    nil,
    nil,
    {
        params ["", "_player", "_params", "_actionData"];

        _actionData set [2, [_params # 0, _player getVariable [QEGVAR(main,loadStatusColour), HEX_WHITE]]];
    }
] call ace_interact_menu_fnc_createAction;
_actions pushBack [_action, [], _target];

// Save action
_action = [
    "Save",
    "Save Mission",
    _saveIcon,
    { [] call FUNCMAIN(clientSaveMission) },
    { true },
    {},
    _saveIcon,
    nil,
    nil,
    nil,
    {
        params ["", "_player", "_icon", "_actionData"];

        _actionData set [2, [_icon, _player getVariable [QEGVAR(main,saveStatusColour), HEX_WHITE]]];
    }
] call ace_interact_menu_fnc_createAction;
_actions pushBack [_action, [], _target];

_actions
