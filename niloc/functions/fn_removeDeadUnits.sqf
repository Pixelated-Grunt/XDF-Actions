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
 * [] call XDF_fnc_removeDeadUnits
 *
 * Public: No
**/


params[["_action", "kill", [""]]];

private _unitsHash = ["units.DEAD"] call FUNCMAIN(getSectionAsHashmap);
private _count = 0;

if (count _unitsHash > 0) then {
    private _deadUnits = keys _unitsHash;

    {
        private _aliveUnits = ALIVE_AIS;
        private _deadUnit = [_x, _aliveUnits] call FUNCMAIN(getObjFromStr);

        // NOTE: Better way to check maybe is to use the type from units.DEAD
        // Not AI
        if (isNull _deadUnit) then {
            // Try vehicle
            _deadUnit = [_x, vehicles] call FUNCMAIN(getObjFromStr);

            if (!isNull _deadUnit) then {
                if (_action == "delete") then { deleteVehicle _deadUnit } else { _deadUnit setDamage 1 };
                _count = _count + 1;
            };
        };
    } forEach _deadUnits;   // Array of object strings not objects
};

_count
