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

private _actions = [];
private "_action";

// Load action
_action = [
    "Load",
    "Load Mission",
    "a3\ui_f\data\igui\cfg\simpletasks\types\upload_ca.paa",
    { [] call FUNCMAIN(loadWorld) },
    { true }
] call ace_interact_menu_fnc_createAction;
_actions pushBack [_action, [], _target];

// Save action
_action = [
    "Save",
    "Save Mission",
    "a3\ui_f\data\igui\cfg\simpletasks\types\download_ca.paa",
    { [] call FUNCMAIN(saveWorld) },
    { true }
] call ace_interact_menu_fnc_createAction;
_actions pushBack [_action, [], _target];

_actions
