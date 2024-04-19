#include "script_macros.hpp"
/*
 * Author: Pixelated_Grunt
 * Save data for all vehicles in game
 *
 * Arguments:
 * Nil
 *
 * Return Valuej:
 * Return number of vehicles saved <NUMBER>
 *
 * Example:
 * [] call XDF_fnc_saveVehiclesStates
 *
 * Public: No
**/


private ["_allVehicles", "_count"];

_allVehicles = ALL_VEHICLES;
_count = 0;

{
    private _vehHash = [_x] call FUNCMAIN(prepVehicleData);
    private _vehName = str _x;
    private _res = 0;

    if (count _vehHash != 0) then {
        _res = ["vehicles", [_vehName, toArray _vehHash]] call FUNCMAIN(putSection);
        if (_res > 0) then { _count = _count + 1 }
    } else { ERROR_1("Failed to get data for vehicle (%1).", _vehName) }
} forEach _allVehicles;

_count
