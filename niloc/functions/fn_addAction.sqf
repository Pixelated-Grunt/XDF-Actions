#include "script_macros.hpp"
/*
 * Author: Pixelated_Grunt
 * Manages whether to show action for player with access item in inventory.
 *
 * Arguments:
 * 0: Player to add action to <OBJECT>
 * 1: Player can access the actions <BOOL> {default: false}
 *
 * Return Value:
 * Nil
 *
 * Example:
 * [] call XDF_fnc_addAction
 *
 * Public: No
**/


params [
    ["_unit", objNull, [objNull]],
    ["_canAccess", false, [false]]
];

private ["_statement", "_action"];

// XDF parent menu
[(typeOf _unit), 1, ["ACE_SelfActions"], [
    "XDF",
    "D F",
    "a3\ui_f\data\igui\cfg\simpletasks\letters\x_ca.paa",
    {},
    { _canAccess }
] call ace_interact_menu_fnc_createAction] call ace_interact_menu_fnc_addActionToClass;

// NiLoc menu
_action = [
    "NiLOC",
    "NiLOC",
    "a3\ui_f_oldman\data\igui\cfg\holdactions\holdaction_sleep2_ca.paa",
    {},
    { _canAccess }
] call ace_interact_menu_fnc_createAction;
[(typeOf _unit), 1, ["ACE_SelfActions", "XDF"], _action] call ace_interact_menu_fnc_addActionToClass;

// Save action
_statement = { [] call FUNCMAIN(saveWorld); LOG_1("_this inside _statement: (%1).", _this) };
_action = [
    "Save",
    "Save Mission",
    "a3\ui_f\data\igui\cfg\simpletasks\types\download_ca.paa",
    _statement,
    { _canAccess }
] call ace_interact_menu_fnc_createAction;
[(typeOf _unit), 1, ["ACE_SelfActions", "XDF", "NiLOC"], _action] call ace_interact_menu_fnc_addActionToClass;

// Load action
_statement = { [] call FUNCMAIN(loadWorld) };
_action = [
    "Load",
    "Load Mission",
    "a3\ui_f\data\igui\cfg\simpletasks\types\upload_ca.paa",
    _statement,
    { _canAccess }
] call ace_interact_menu_fnc_createAction;
[(typeOf _unit), 1, ["ACE_SelfActions", "XDF", "NiLOC"], _action] call ace_interact_menu_fnc_addActionToClass;
