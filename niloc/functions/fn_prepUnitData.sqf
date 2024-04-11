#include "script_macros.hpp"
/*
 * Author: Pixelated_Grunt
 * Internal function to get data from a live unit for saving later
 *
 * Arguments:
 * 0: Unit to get data from <OBJECT>
 *
 * Return Value:
 * HashMap that contains unit data <HASHMAP>
 *
 * Example:
 * _unitHash = [player] call XDF_fnc_prepUnitData
 *
 * Public: No
**/


params [["_unit", objNull, [objNull]]];
private ["_statsToSave", "_unitHash", "_extraStats"];

_statsToSave = ["location", "loadout", "damage", "vehicle"];
_extraStats = ["type", "face"];
_unitHash = createHashMap;

//if (missionNamespace getVariable [QGVAR(ENABLE_CREATE), false]) then { _statsToSave = _statsToSave + _extraStats };
_statsToSave = _statsToSave + _extraStats;
{
    private _stat = _x;

    switch (_x) do {
        // Assuming all units are not in water i.e. ATL
        case "location": { _unitHash set [_stat, (getPosATL _unit)] };
        case "loadout": { _unitHash set [_stat, (getUnitLoadout _unit)] };
        case "damage": {
            if HASACE3 then {
                _unitHash set [_stat, [_unit] call ace_medical_fnc_serializeState];
            } else {
                _unitHash set [_stat, damage _unit];
            };
        };
        case "vehicle": {
            private _vehicle = vehicle _unit;

            if (_vehicle != _unit) then {
                _unitHash set [_stat, str _vehicle];
            };
        };
        case "type": { _unitHash set [_stat, (typeOf _unit)] };
        case "face": { _unitHash set [_stat, (face _unit)] };
        default { ERROR_2("No key (%1) defined for unit (%2).", _stat, _unit) };
    };
} forEach _statsToSave;

_unitHash
