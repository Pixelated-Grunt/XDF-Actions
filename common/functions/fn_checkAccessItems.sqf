#include "script_macros.hpp"
/*
 * Author: Pixelated_Grunt
 * Check if player has certain items to enable Ace menu
 *
 * Arguments:
 * 0: Unit to check <OBJECT>
 * 1: Optional string to specific component <STRING>
 *
 * Return Value:
 * If any access items have been found <BOOL>
 *
 * Example:
 * [player] call XDF_fnc_checkAccessItems
 *
 * Public: No
**/


params [
    ["_unit", objNull, [objNull]],
    ["_component", "all", [""]]
];

private ["_uniqueItems", "_hasItem", "_accessItems"];

_accessItems = [];
_uniqueItems = _unit getVariable [QGVAR(uniqueItems), []];
_hasItem = false;

switch (_component) do {
    case "NiLOC": {
        _accessItems pushBack (missionNamespace getVariable [QGVARMAIN(NiLOC_accessItem), "ACE_SpraypaintRed"]);
        if ((keys _uniqueItems arrayIntersect _accessItems) isNotEqualTo []) then { _hasItem = true };
    };
    case "ERV": { if ([_unit, "ACRE_PRC77"] call acre_api_fnc_hasKindofradio) then { _hasItem = true }};
    default {
        _accessItems pushBack (missionNamespace getVariable [QGVARMAIN(NiLOC_accessItem), "ACE_SpraypaintRed"]);

        if ((keys _uniqueItems arrayIntersect _accessItems) isNotEqualTo [] ||
            [_unit, "ACRE_PRC77"] call acre_api_fnc_hasKindofradio) then { _hasItem = true };
    };
};

_hasItem
