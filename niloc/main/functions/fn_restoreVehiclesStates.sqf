#include "..\script_component.hpp"
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
 * [] call niloc_fnc_restoreVehiclesStates
 *
 * Public: No
**/


private ["_allVehicles", "_sectionHash", "_count", "_fnc_moveOut"];

_count = 0;
_allVehicles = ALL_VEHICLES;
_sectionHash = ["vehicles"] call FUNCMAIN(getSectionAsHashmap);

if (count _sectionHash == 0) exitWith { _count };

_fnc_moveOut = {
    params ["_unit"];

    if !(isNull objectParent _unit) then {
        [_unit] remoteExec ["moveOut", _unit];
    }
};

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

                    if ( count _savedCrews == 0 ) exitWith { INFO_1("Vehicle (%1) had no crew. Skipping.", _objStr) };
                    _currentCrews sort true;
                    _savedCrews sort true;

                    if (_currentCrews isNotEqualTo _savedCrews) then {
                        {   //forEach _values (crews) loop
                            private _crewObj = [_x select 0, (ALIVE_AIS)] call FUNCMAIN(getObjFromStr);

                            if !(isNull _crewObj) then {
                                switch (_x select 1) do {
                                    case "driver": {
                                        LOG_2("Vehicle (%1) loading driver (%2).", str _objStr, str _crewObj);

                                        [_crewObj] call _fnc_moveOut;
                                        [_crewObj, _vehObj] remoteExec ["moveInDriver", _vehObj];
                                        _crewObj assignAsDriver _vehObj;
                                    };
                                    case "commander": {
                                        LOG_2("Vehicle (%1) loading commander (%2).", str _objStr, str _crewObj);

                                        [_crewObj] call _fnc_moveOut;
                                        [_crewObj, _vehObj] remoteExec ["moveInCommander", _vehObj];
                                        _crewObj assignAsCommander _vehObj;
                                    };
                                    case "gunner": {
                                        LOG_2("Vehicle (%1) loading gunner (%2).", str _objStr, str _crewObj);

                                        [_crewObj] call _fnc_moveOut;
                                        [_crewObj, _vehObj] remoteExec ["moveInGunner", _vehObj];
                                        _crewObj assignAsGunner _vehObj;
                                    };
                                    case "turret": {
                                        private _idx = _x select 3;

                                        LOG_2("Vehicle (%1) loading turret (%2).", str _objStr, str _crewObj);
                                        [_crewObj] call _fnc_moveOut;
                                        [[_crewObj, [_vehObj, _idx]]] remoteExec ["moveInTurret", _vehObj];
                                        _crewObj assignAsTurret [_vehObj, _idx];
                                    };
                                    case "cargo": {
                                        private _idx = _x select 2;

                                        LOG_2("Vehicle (%1) loading cargo (%2).", str _objStr, str _crewObj);
                                        [_crewObj] call _fnc_moveOut;
                                        [[_crewObj, [_vehObj, _idx]]] remoteExec ["moveInCargo", _vehObj];
                                        _crewObj assignAsCargoIndex [_vehObj, _idx];
                                    };
                                    default {};
                                };
                            };
                        } forEach _values;  // crews
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
