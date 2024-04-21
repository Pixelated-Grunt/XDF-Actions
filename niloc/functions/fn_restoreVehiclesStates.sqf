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
        private _values = _y;
        private _vehObj = [_objStr, _allVehicles] call FUNCMAIN(getObjFromStr);

        if !(isNull _vehObj) then {
            switch (_stat) do {
                case "objStr": {};
                case "type": {};
                case "side": {};
                case "location": { _vehObj setPosASL _values };
                case "damage": {
                    private _hitPointNames = _values select 0;
                    private _hitPointDamages = _values select 2;

                    {
                        _vehObj setHitPointDamage [_x, _hitPointDamages select (_hitPointNames find _x)];
                    } forEach _hitPointNames;
                };
                case "crew": {
                    private ["_currentCrews", "_savedCrews"];

                    _savedCrews = [];
                    _currentCrews = crew _vehObj apply { str _x };
                    _values apply { _savedCrews pushBack (_x select 0) };

                    if ((_currentCrews sort true) isNotEqualTo (_savedCrews sort true)) then {
                        {
                            private _crewObj = [_x select 0, (ALIVE_AIS)] call FUNCMAIN(getObjFromStr);

                            if !(isNull _crewObj) then {
                                switch (_values select 1) do {
                                    case "driver": {
                                        _crewObj moveInDriver _vehObj;
                                        if ((_values select 5) isNotEqualTo "") then {
                                            _crewObj assignAsDriver _vehObj;
                                        };
                                    };
                                    case "commander": {
                                        _crewObj moveInCommander _vehObj;
                                        if ((_values select 5) isNotEqualTo "") then {
                                            _crewObj assignAsCommander _vehObj;
                                        };
                                    };
                                    case "gunner": {
                                        _crewObj moveInGunner _vehObj;
                                        if ((_values select 5) isNotEqualTo "") then {
                                            _crewObj assignAsGunner _vehObj;
                                        };
                                    };
                                    case "turret": {
                                        _crewObj moveInTurret [_vehObj, _values select 3];
                                        if ((_values select 5) isNotEqualTo "") then {
                                            _crewObj assignAsTurret [_vehObj, _values select 3];
                                        };
                                    };
                                    case "cargo": {
                                        _crewObj moveInCargo [_vehObj, _values select 2];
                                        if ((_values select 5) isNotEqualTo "") then {
                                            _crewObj assignAsCargoIndex [_vehObj, _values select 2];
                                        };
                                    };
                                    default {};
                                };
                            };
                        } forEach _values;
                    } else { INFO_1("Vehicle (%1) has the same crew. Skipping.", _objStr) };
                };
                case "itemCargo": {
                    private ["_items", "_counts"];
                    _items = _values select 0;
                    _counts = _values select 1;

                    clearItemCargoGlobal _vehObj;
                    for "_i" from 0 to ((count _items) -1) do {
                        _vehObj addItemCargoGlobal [_items select _i, _counts select _i];
                    };
                };
                case "magazineCargo": {
                    private ["_items", "_counts"];
                    _items = _values select 0;
                    _counts = _values select 1;

                    clearMagazineCargoGlobal _vehObj;
                    for "_i" from 0 to ((count _items) -1) do {
                        _vehObj addMagazineCargoGlobal [_items select _i, _counts select _i];
                    };
                };
                case "weaponCargo": {
                    private ["_items", "_counts"];
                    _items = _values select 0;
                    _counts = _values select 1;

                    clearWeaponCargoGlobal _vehObj;
                    for "_i" from 0 to ((count _items) -1) do {
                        _vehObj addWeaponCargoGlobal [_items select _i, _counts select _i];
                    };
                };
                case default {};
            };  // switch block
            _count = _count + 1;
        } else { INFO_1("Failed to find vehicle object (%1) among all vehicles.", _objStr) };
    } forEach _vehicleHash;
} forEach _sectionHash;

_count
