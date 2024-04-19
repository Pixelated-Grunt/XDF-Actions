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
        LOG_1("_deadObj (%1) now is a vehicle", str _deadObj);
        if (!isNull _deadObj) then {
            private "_pos";

            LOG_1("_deadObj (%1) is typeOf (%2).", str _deadObj, typeOf _deadObj);
            if (IS_UNIT(_deadObj)) then {
                _pos = (_unitsDeadHash get _x) select 1;
                LOG_1("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!_pos in units: (%1) from _x (%2).", _pos, _x);
            } else {
                _pos = (_vehiclesDeadHash get _x) select 1;
                LOG_1("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!_pos in vehicles: (%1) from _x (%2).", _pos, _x);
            };

            if (_action == "delete") then {
                deleteVehicle _deadObj;
            } else {
                // FIXME: _pos didn't return in some tests
                LOG_1("=============================_pos in setDamage: (%1) from _x (%2).", _pos, _x);
                //_deadObj setPosASL _pos;
                _deadObj setDamage [1, false];
            };
            _count = _count + 1;
        } else { ERROR_1("Failed to find entity (%1) to kill or delete.", _x) };
    } forEach _deadEntities;   // Array of object strings not objects
};

_count
