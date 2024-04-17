#include "script_macros.hpp"
/*
 * Author: Pixelated_Grunt
 * Restore all mission settings stored previously
 *
 * Arguments:
 * 0: List of keys that do not need to be restored <ARRAY> (default: {[]})
 *
 * Return Value:
 * Number of settings restored <NUMBER>
 *
 * Example:
 * ["dataTime"] call XDF_fnc_restoreMissionState
 *
 * Public: No
**/


params [["_ignoreItems", "", ["", []]]];
private ["_count", "_resHash"];

_count = 0;
_resHash = ["mission"] call FUNCMAIN(getSectionAsHashmap);

if (count _resHash == 0) then {
    INFO("No settings stored in mission section.");
} else {
    {
        if ((_x isEqualTo _ignoreItems) || (_x in _ignoreItems)) then {continue};

        switch (_x) do {
            case "date": {
                [_y, true, true] call BIS_fnc_setDate;
                _count = _count + 1;
            };
            default {};
        };
    } forEach _resHash;
};

_count
