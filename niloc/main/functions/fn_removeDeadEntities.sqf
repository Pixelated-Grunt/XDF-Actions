#include "script_macros.hpp"
/*
 * Author: Pixelated_Grunt
 * Kill or delete dead or destroyed units
 *
 * Arguments:
 * 0: Action to taken on target units <STRING> {default: "kill"}
 *
 * Return Value:
 * Dead units count (only from database not checking if units are actually killed) <NUMBER>
 *
 * Example:
 * [] call niloc_fnc_removeDeadEntities
 *
 * Public: No
**/


params[["_action", "kill", [""]]];

private ["_count", "_sections"];

_count = 0;
_sections = ["dead."] call FUNCMAIN(getSectionNames);

if (count _sections == 0) exitWith { _count };

{
    private ["_sectionHash", "_aliveEntities"];

    if (_x isEqualTo "dead.units") then {
        _sectionHash = ["dead.units"] call FUNCMAIN(getSectionAsHashmap);
        _aliveEntities = ALIVE_AIS;
    } else {
        _sectionHash = ["dead.vehicles"] call FUNCMAIN(getSectionAsHashmap);
        _aliveEntities = ALL_VEHICLES;
    };

    {
        if ("REMOTE" in _x) then {
            INFO_1("Skip handling Zeus created entity (%1).", _x);
            continue;
        };
        private _obj = [_x, _aliveEntities] call FUNCMAIN(getObjFromStr);

        if !(isNull _obj) then {
            private _pos = _y select 1;

            if (_action isEqualTo "delete") then {
                deleteVehicle _obj;
            } else {
                _obj setPosASL _pos;
                _obj setDamage [1, false];
            };
            _count = _count + 1;
        } else { ERROR_1("Failed to find object (%1) to kill.", _x) }
    } forEach _sectionHash;
} forEach _sections;

_count
