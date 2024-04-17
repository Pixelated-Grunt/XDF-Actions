#include "script_macros.hpp"
/*
 * Author: Pixelated_Grunt
 * Restore data for all units from the database
 *
 * Arguments:
 * Nil
 *
 * Return Value:
 * Total number of units restored <NUMBER>
 *
 * Example:
 * [] call XDF_fnc_restoreUnitsStates
 *
 * Public: Yes
**/


private ["_sections", "_aliveAIs", "_count"];

_sections = ["units."] call FUNCMAIN(getSectionNames);
if (count _sections == 0) exitWith {WARNING("Unit sections are empty.")};

_aliveAIs = ALIVEAIS;
_count = 0;

{   // sections loop
    private _units = [_x] call FUNCMAIN(getSectionAsHashmap);

    if (_x isEqualTo "units.DEAD") then {
        private _deadUnits = _units get "units";

        {
            private _unitObj = [_x, _aliveAIs] call FUNCMAIN(getObjFromStr);

            if (!isNull _unitObj) then {
                _unitObj setDamage 1;
            } else { ERROR_1("Unit (%1) not found, nothing to kill or remove.", _x) }
        } forEach _deadUnits;
    } else {    // alive units
        {   // units loop
            private _unitHash = (_y select 0) createHashMapFromArray (_y select 1);
            private _unitObj = [_x, _aliveAIs] call FUNCMAIN(getObjFromStr);

            if (isNull _unitObj) exitWith { ERROR_1("No object find for unit (%1).", _unitHash get "objStr") };

            {   // unitHash loop
                private _key = _x;
                private _value = _y;

                switch (_key) do {
                    case "objStr": {};
                    case "location": {
                        // If unit is inside a vehicle leave it to the vehicle case
                        if (isNull objectParent _unitObj) then {
                            if ((getPosATL _unitObj) isNotEqualTo _value) then {
                                _unitObj setPosATL _value;
                            } else { LOG_2("Position (%1) of unit (%2) has not changed, not moving.", _value, str _unitObj) };
                        } else { LOG_1("Unit (%1) is inside a vehicle not moving.", str _unitObj) };
                    };
                    case "loadout": { _unitObj setUnitLoadout _value };
                    case "formation": { _unitObj setFormation _value };
                    case "behaviour": { _unitObj setCombatBehaviour _value };
                    case "damage": {
                        if HASACE3 then {
                            [_unitObj, _value] call ace_medical_fnc_deserializeState;
                        } else { _unitObj setDamage _value };
                    };
                    case "vehicle": {
                        private _vehObj = objNull;

                        _vehObj = [_value select 0, vehicles] call FUNCMAIN(getObjFromStr);
                        if (!isNull _vehObj) then {
                            private _oldPos = _value select 1;

                            if ((getPosATL _vehObj) isNotEqualTo _oldPos) then {
                                _vehObj setPosATL _oldPos;
                            } else { LOG_2("Position (%1) of vehicle (%2) has not changed, not moving.", _value select 0, str _vehObj) };
                        } else { WARNING_1("Vehicle object (%1) does not exist.", str _unitObj) };
                    };
                    case "type": {};
                    case "face": {};
                    default { ERROR_2("No key (%1) defined for unit (%2) to restore.", _key, str _unitObj) };
                };
            } forEach _unitHash;
        } forEach _units;
    };  // else
} forEach _sections;

_count
