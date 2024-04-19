#include "script_macros.hpp"
/*
 * Author: Pixelated_Grunt
 * Internal function to get data from a vehicle
 *
 * Arguments:
 * 0: Vehicle to get data from <OBJECT>
 *
 * Return Value:
 * HashMap that contains vehicle data <HASHMAP>
 *
 * Example:
 * _vehicleHash = [_vehicle] call XDF_fnc_prepVehicleData
 *
 * Public: No
**/


params [["_vehicle", objNull, [objNull]]];

private ["_stats", "_vehHash"];

_stats = ["vehicle"] call FUNCMAIN(returnStats);
_vehHash = createHashMap;

{
    private _statName = _x;

    switch (_statName) do {
        case "objStr": { _vehHash set [_statName, str _vehicle] };
        case "side": { _vehHash set [_statName, str side _vehicle] };
        case "location": { _vehHash set [_statName, getPosASL _vehicle] };
        case "damage": { _vehHash set [_statName, getAllHitPointsDamage _vehicle] };
        case "weaponCargo": { _vehHash set [_statName, getWeaponCargo _vehicle] };
        case "itemCargo": { _vehHash set [_statName, getItemCargo _vehicle] };
        case "magazineCargo": { _vehHash set [_statName, getMagazineCargo _vehicle] };
        case "backpackCargo": {};
        case "crew": { _vehHash set [_statName, fullCrew _vehicle] };
        default {};
    }
} forEach _stats;

_vehHash
