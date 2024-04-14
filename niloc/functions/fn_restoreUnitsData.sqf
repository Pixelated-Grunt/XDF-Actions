#include "script_macros.hpp"
/*
 * Author: Pixelated_Grunt
 * Restore data for all alive units from the database
 *
 * Arguments:
 * Nil
 *
 * Return Value:
 * Total number of units restored <NUMBER>
 *
 * Example:
 * [] call XDF_fnc_restoreUnitsData
 *
 * Public: Yes
**/


private ["_sections", "_aliveAIs", "_count"];

_sections = ["units."] call FUNCMAIN(getSectionNames);
if (count _sections == 0) exitWith {WARNING("Unit sections are empty.")};

_aliveAIs = ALIVEAIS;
_count = 0;

{
    private _units = [_x] call FUNCMAIN(getSectionAsArrayOfHashmaps);
    {
        private _unitHash = _x;
        {
            private _key = _x;
            private _value = _y;
            private _unitObj = objNull;

            switch (_key) do {
                case "objStr": {
                    _unitObj = [_value, _aliveAIs] call FUNCMAIN(getObjFromStr);

                    if (isNull _unitObj) exitWith { ERROR_1("No object find for unit (%1).", _key) };
                };
                case "location": { _unitObj setPosATL _value };
                case "loadout": { _unitObj setUnitLoadout _value };
                case "damage": {
                    if HASACE3 then {
                        [_unitObj, _value] call ace_medical_fnc_deserializeState;
                    } else {
                        _unitObj setDamage _value;
                    };
                };
                case "vehicle": {
                    private _vehObj = objNull;

                    _vehObj = [_value select 0, vehicles] call FUNCMAIN(getObjFromStr);
                    if (!isNull _vehObj) then {
                        _vehObj setPosATL _value select 1;
                    };
                };
                case "type": {};
                case "face": {};
                default { ERROR_2("No key (%1) defined for unit (%2) to restore.", _key, _unitHash get "objStr") };
            };
        } forEach _unitHash;
    } forEach _units;
} forEach _sections;

_count
