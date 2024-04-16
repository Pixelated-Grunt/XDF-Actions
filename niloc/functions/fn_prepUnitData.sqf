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
private ["_statsToSave", "_unitHash"];

_statsToSave = ["unit"] call FUNCMAIN(returnStats);
_unitHash = createHashMap;

{
    private _stat = _x;

    switch (_stat) do {
        // Assuming all units are not in water i.e. ATL
        case "objStr": { _unitHash set [_stat, str _unit]};
        case "location": { _unitHash set [_stat, (getPosATL _unit)] };
        case "loadout": { _unitHash set [_stat, (getUnitLoadout _unit)] };
        case "formation": { _unitHash set [_stat, (formation _unit)] };
        case "behaviour": { _unitHash set [_stat, (behaviour _unit)] };
        case "damage": {
            if HASACE3 then {
                _unitHash set [_stat, [_unit] call ace_medical_fnc_serializeState];
            } else {
                _unitHash set [_stat, damage _unit];
            };
        };
        case "vehicle": {
            private _vehicle = objectParent _unit;

            if (!isNull _vehicle) then {
                _unitHash set [_stat, [str _vehicle, getPosATL _vehicle]];
            };
        };
        case "type": { _unitHash set [_stat, (typeOf _unit)] };
        case "face": { _unitHash set [_stat, (face _unit)] };
        default { ERROR_2("No key (%1) defined for unit (%2).", _stat, _unit) };
    };
} forEach _statsToSave;

_unitHash
