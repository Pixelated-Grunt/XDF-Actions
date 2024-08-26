#include "..\script_component.hpp"
/*
 * Author: Pixelated_Grunt
 * Initiation of user interaction menu
 *
 * Arguments:
 * Nil
 *
 * Return Value:
 * Nil
 *
 * Example:
 * [] call niloc_user_menu_fnc_init
 *
 * Public: No
**/


if !hasInterface exitWith {};

if (!isNil(QGVARMAIN(enable)) && {QGVARMAIN(enabled)}) then {
    private _useMissionFramework = false;
    private _accessItem = RETDEF(NILOC_accessItem, nil);

    // Check if XDF mission framework is enabled
    if !isNil("XDF_MF_accessItems") then {
        if (SHORT_PREFIX in XDF_MF_accessItems) then {
            _accessItem = XDF_MF_accessItems get SHORT_PREFIX;
            _useMissionFramework = true
        }
    };
    missionNamespace setVariable[QGVAR(useMissionFramework), _useMissionFramework];

    if !_useMissionFramework then {
        [player, 1, ["ACE_SelfActions"], [
            ROOT_PREFIX,
            "D F",
            "a3\ui_f\data\igui\cfg\simpletasks\letters\x_ca.paa",
            {},
            { true }
        ] call ace_interact_menu_fnc_createAction] call ace_interact_menu_fnc_addActionToObject
    };

    [player, 1, ["ACE_SelfActions", ROOT_PREFIX], [
        SHORT_PREFIX,
        "NiLOC",
        "a3\ui_f_oldman\data\igui\cfg\holdactions\holdaction_sleep2_ca.paa",
        { call EFUNC(UI,guiOpenGUI); },
        { [_this#0, _this#2] call FUNCMAIN(checkAccessItem) },
        { [] call FUNC(addChildActions) },
        _accessItem
    ] call ace_interact_menu_fnc_createAction] call ace_interact_menu_fnc_addActionToObject
}
