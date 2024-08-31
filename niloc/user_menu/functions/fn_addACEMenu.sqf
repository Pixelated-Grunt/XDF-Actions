#include "..\script_component.hpp"
/*
 * Author: Pixelated_Grunt
 * Initiation of user interaction menu
 *
 * Arguments:
 * 0: Player object to add menu to <OBJECT>
 *
 * Return Value:
 * ACE action array <ARRAY>
 *
 * Example:
 * [] call niloc_fnc_addACEMenu
 *
 * Public: No
**/


if !hasInterface exitWith {};

params ["_unit"];

private _useMissionFramework = false;
private _accessItem = RETDEF(NILOC_accessItem, "ACE_SpraypaintRed");
private _action = [];

// Check if XDF mission framework is enabled
if (XDF_MF_LOADED) then {_useMissionFramework = true};
missionNamespace setVariable[QGVAR(useMissionFramework), _useMissionFramework];

if !_useMissionFramework then {
    [_unit, 1, ["ACE_SelfActions"], [
        QUOTE(ROOT_PREFIX),
        "D F",
        "a3\ui_f\data\igui\cfg\simpletasks\letters\x_ca.paa",
        {},
        { [_this#0, _this#2] call FUNCMAIN(checkAccessItem) },
        {
            params ["_target"];
            private _actions = [];
            private _action = [
                QUOTE(PREFIX),
                "NiLOC",
                "a3\ui_f_oldman\data\igui\cfg\holdactions\holdaction_sleep2_ca.paa",
                { call FUNCMAIN(guiOpenGUI) },
                { true },
                { params ["_target"]; [_target] call FUNCMAIN(addChildActions) }
            ] call ace_interact_menu_fnc_createAction;
            _actions pushBack [_action, [], _target];
            _actions
        },
        _accessItem
    ] call ace_interact_menu_fnc_createAction] call ace_interact_menu_fnc_addActionToObject
} else {
    _action = [
        QUOTE(PREFIX),
        "NiLOC",
        "a3\ui_f_oldman\data\igui\cfg\holdactions\holdaction_sleep2_ca.paa",
        { call FUNCMAIN(guiOpenGUI) },
        { true },
        { params ["_target"]; [_target] call FUNCMAIN(addChildActions) }
    ] call ace_interact_menu_fnc_createAction
};

_action
