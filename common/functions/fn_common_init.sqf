#include "script_macros.hpp"
/*
 * Author: Pixelated_Grunt
 * Common setup for all XDF tools
 *
 * Arguments:
 * Nil
 *
 * Return Value:
 * Nil
 *
 * Example:
 * [] call XDF_fnc_common_init
 *
 * Public: No
**/


if (hasInterface) then {
    uiNamespace setVariable [QGVAR(mainDialog), findDisplay IDD_NILOCGUI_RSCNILOCDIALOG];

    // CBA EH for inventory changes
    ["loadout", {
        params ["_unit"];

        _unit setVariable [QGVAR(uniqueItems), uniqueUnitItems _unit];
    }, true] call CBA_fnc_addPlayerEventHandler;

    // If access items are detected create ACE menu root entry
    ["CaManBase", 1, ["ACE_SelfActions"], [
        "XDF",
        "D F",
        "a3\ui_f\data\igui\cfg\simpletasks\letters\x_ca.paa",
        {},
        { [_this # 1] call FUNCMAIN(checkAccessItems) }
    ] call ace_interact_menu_fnc_createAction, true] call ace_interact_menu_fnc_addActionToClass;

    // NiLOC submenu
    ["CaManBase", 1, ["ACE_SelfActions", "XDF"], [
        "NiLOC",
        "NiLOC",
        "a3\ui_f_oldman\data\igui\cfg\holdactions\holdaction_sleep2_ca.paa",
        { [] call FUNCMAIN(guiOpenGui) },
        { [_this # 1, _this # 2] call FUNCMAIN(checkAccessItems) && missionNamespace getVariable [QEGVAR(niloc,enable), false] },
        { _this call FUNCMAIN(nilocChildActions) },
        "NiLOC"
    ] call ace_interact_menu_fnc_createAction, true] call ace_interact_menu_fnc_addActionToClass;

    // ERV action
    ["CaManBase", 1, ["ACE_SelfActions", "XDF"], [
        "ERV",
        "Set Emergency RV",
        "a3\ui_f\data\map\markers\military\end_CA.paa",
        { [_this # 1] call FUNCMAIN(setERV) },
        { [_this # 1, _this # 2] call FUNCMAIN(checkAccessItems) },
        {},
        "ERV"
    ] call ace_interact_menu_fnc_createAction, true] call ace_interact_menu_fnc_addActionToClass;
};
