#include "script_macros.hpp"
/*
 * Author: Pixelated_Grunt
 * Restore data for all vehicles from the database
 *
 * Arguments:
 * Nil
 *
 * Return Value:
 * Total number of vehicles restored <NUMBER>
 *
 * Example:
 * [] call XDF_fnc_restoreVehiclesStates
 *
 * Public: No
**/


private ["_allVehicles", "_sectionHash", "_count"];

_count = 0;
_allVehicles = ALL_VEHICLES;
_sectionHash = ["vehicles"] call FUNCMAIN(getSectionAsHashmap);

if (count _sectionHash == 0) exitWith { _count };

{
    private _objStr = _x;
    private _vehicleHash = (_y select 0) createHashMapFromArray (_y select 1);

    {
        private _stat = _x;
        private _value = _y;
        private _vehObj = [_objStr, _allVehicles] call FUNCMAIN(getObjFromStr);

        if !(isNull _vehObj) then {
            switch (_stat) do {
                case "objStr": {};
                case "type": {};
                case "side": {};
                case "location": { _vehObj setPosASL _value };
                case "damage": {
                    private _hitPointNames = _value select 0;
                    private _hitPointDamages = _value select 2;

                    {
                        _vehObj setHitPointDamage [_x, _hitPointDamages select (_hitPointNames find _x)];
                    } forEach _hitPointNames;
                };
                case "crew": {};
                case "itemCargo": {
                    private _itemArray = _value call BIS_fnc_consolidateArray;

                    _vehObj addItemCargoGlobal _itemArray;
                };
                case "magazineCargo": {};
                case "weaponCargo": {};
                case default {};
            };
            _count = _count + 1;
        } else { INFO_1("Failed to find vehicle object (%1) among all vehicles.", _objStr) };
    } forEach _vehicleHash;
} forEach _sectionHash;

_count
