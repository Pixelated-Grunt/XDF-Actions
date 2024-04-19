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
 * [] call XDF_fnc_removeDeadEntities
 *
 * Public: No
**/


params[["_action", "kill", [""]]];

private ["_unitsDeadHash", "_vehiclesDeadHash", "_deadEntities", "_count", "_entityKeys"];

_unitsDeadHash = ["dead.units"] call FUNCMAIN(getSectionAsHashmap);
_vehiclesDeadHash = ["dead.vehicles"] call FUNCMAIN(getSectionAsHashmap);
_entityKeys = keys _unitsDeadHash + keys _vehiclesDeadHash;
_deadEntities = _entityKeys arrayIntersect _entityKeys;
_count = 0;

if (count _deadEntities > 0) then {

    {
        private _aliveEntities = (ALIVE_AIS) + (ALL_VEHICLES);
        private _deadObj = [_x, _aliveEntities] call FUNCMAIN(getObjFromStr);

        _deadObj = vehicle _deadObj;
        if (!isNull _deadObj) then {
            private "_pos";

            if (_deadObj isKindOf "Man") then {
                _pos = (_unitsDeadHash get _x) select 1;
            } else {
                _pos = (_vehiclesDeadHash get _x) select 1;
            };

            if (_action == "delete") then {
                deleteVehicle _deadObj;
            } else {
                _deadObj setPosASL _pos;
                _deadObj setDamage [1, false];
            };
            _count = _count + 1;
        } else { ERROR_1("Failed to find entity (%1) to kill or delete.", _x) }
    } forEach _deadEntities;   // Array of object strings not objects
};

_count
