#include "script_macros.hpp"
/*
 * Author: Pixelated_Grunt
 * Manages whether to show action for player with access item in inventory.
 *
 * Arguments:
 * Nil
 *
 * Return Value:
 * Nil
 *
 * Example:
 * [] call XDF_fnc_addAction
 *
 * Public: No
**/


params [["_unit", objNull, [objNull]]];

private ["_condition", "_statement", "_action"];

// XDF parent menu
[(typeOf _unit), 1, ["ACE_SelfActions"], [
    "XDF",
    "XDF Actions",
    "a3\ui_f\data\igui\cfg\simpletasks\letters\x_ca.paa",
    {},
    { true }
] call ace_interact_menu_fnc_createAction] call ace_interact_menu_fnc_addActionToClass;

// NiLoc menu
_condition = { _unit getVariable [QGVAR(hasAccessItem), false] };
_action = [
    "NiLOC",
    "NiLOC",
    "a3\ui_f_oldman\data\igui\cfg\holdactions\holdaction_sleep2_ca.paa",
    {},
    _condition
] call ace_interact_menu_fnc_createAction;
[(typeOf _unit), 1, ["ACE_SelfActions", "XDF"], _action] call ace_interact_menu_fnc_addActionToClass;

// Save action
_statement = { [] call FUNCMAIN(saveWorld) };
_action = [
    "Save",
    "Save Mission",
    "a3\ui_f\data\igui\cfg\simpletasks\types\download_ca.paa",
    _statement,
    { true }
] call ace_interact_menu_fnc_createAction;
[(typeOf _unit), 1, ["ACE_SelfActions", "XDF", "NiLOC"], _action] call ace_interact_menu_fnc_addActionToClass;

// Load action
_statement = { [] call FUNCMAIN(loadWorld) };
_action = [
    "Load",
    "Load Mission",
    "a3\ui_f\data\igui\cfg\simpletasks\types\upload_ca.paa",
    _statement,
    { true }
] call ace_interact_menu_fnc_createAction;
[(typeOf _unit), 1, ["ACE_SelfActions", "XDF", "NiLOC"], _action] call ace_interact_menu_fnc_addActionToClass;
