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

{   //_sectionHash loop
    private ["_objStr", "_vehicleHash", "_success", "_vehObj"];

    _objStr = _x;
    _vehObj = [_objStr, _allVehicles] call FUNCMAIN(getObjFromStr);
    _vehicleHash = (_y select 0) createHashMapFromArray (_y select 1);

    {   //_vehicleHash loop
        private ["_stat", "_values"];

        _stat = _x;
        _values = _y;
        _success = false;

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

                    _currentCrews sort true;
                    _savedCrews sort true;

                    if (_currentCrews isNotEqualTo _savedCrews) then {
                        {   //forEach _values (crews) loop
                            private _crewObj = [_x select 0, (ALIVE_AIS)] call FUNCMAIN(getObjFromStr);

                            if !(isNull _crewObj) then {
                                switch (_x select 1) do {
                                    case "driver": {
                                        LOG_2("Vehicle (%1) loading driver (%2).", str _vehObj, str _crewObj);
                                        _crewObj moveInDriver _vehObj;
                                        _crewObj assignAsDriver _vehObj;
                                    };
                                    case "commander": {
                                        LOG_2("Vehicle (%1) loading commander (%2).", str _vehObj, str _crewObj);
                                        _crewObj moveInCommander _vehObj;
                                        _crewObj assignAsCommander _vehObj;
                                    };
                                    case "gunner": {
                                        LOG_2("Vehicle (%1) loading gunner (%2).", str _vehObj, str _crewObj);
                                        _crewObj moveInGunner _vehObj;
                                        _crewObj assignAsGunner _vehObj;
                                    };
                                    case "turret": {
                                        LOG_2("Vehicle (%1) loading turret (%2).", str _vehObj, str _crewObj);
                                        _crewObj moveInTurret [_vehObj, _x select 3];
                                        _crewObj assignAsTurret [_vehObj, _x select 3];
                                    };
                                    case "cargo": {
                                        LOG_2("Vehicle (%1) loading cargo (%2).", str _vehObj, str _crewObj);
                                        _crewObj moveInCargo [_vehObj, _x select 2];
                                        _crewObj assignAsCargoIndex [_vehObj, _x select 2];
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
            _success = true;
        };
    } forEach _vehicleHash;     //each vehicle stats
    if (_success) then {
        _count = _count + 1;
    } else {
        INFO_1("Failed to find vehicle object (%1) among all vehicles.", _objStr);
    };
} forEach _sectionHash;     //each vehicle

_count
