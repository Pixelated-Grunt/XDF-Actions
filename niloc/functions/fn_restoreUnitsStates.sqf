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
 * Public: No
**/


private ["_sections", "_aliveAIs", "_count"];

_count = 0;
_sections = ["units."] call FUNCMAIN(getSectionNames);
if (count _sections == 0) exitWith { _count };

_aliveAIs = ALIVE_AIS;

{   // sections loop
    private _units = [_x] call FUNCMAIN(getSectionAsHashmap);

    {   // units loop
        private _unitHash = (_y select 0) createHashMapFromArray (_y select 1);
        private _unitObj = [_x, _aliveAIs] call FUNCMAIN(getObjFromStr);

        if !(isNull _unitObj) then {
            {   // unitHash loop
                private _key = _x;
                private _value = _y;

                switch (_key) do {
                    case "objStr": {};
                    case "location": {
                        // If unit is inside a vehicle leave it to the restore vic function
                        if !("vehicle" in keys _unitHash) then {
                            if ((getPosASL _unitObj) isNotEqualTo _value) then {
                                _unitObj setPosASL _value;
                            } else { LOG_2("Position (%1) of unit (%2) has not changed, not moving.", _value, str _unitObj) };
                        } else { LOG_1("Unit (%1) was inside a vehicle not moving.", str _unitObj) };
                    };
                    case "loadout": { _unitObj setUnitLoadout _value };
                    case "formation": { [_unitObj, _value] remoteExec ["setFormation", _unitObj] };
                    case "behaviour": { [_unitObj, _value] remoteExec ["setCombatBehaviour", _unitObj] };
                    case "damage": {
                        if HASACE3 then {
                            [_unitObj, _value] remoteExec ["ace_medical_fnc_deserializeState", _unitObj];
                        } else { _unitObj setDamage _value };
                    };
                    case "captive": {
                        if (_value) then {
                            if (HASACE3) then {
                                [_unitObj, _value] remoteExec ["ACE_captives_fnc_setHandcuffed", _unitObj];
                            } else {
                                [_unitObj, _value] remoteExec ["setCaptive", _unitObj];
                            };
                        };
                    };
                    case "vehicle": {};
                    case "type": {};
                    case "face": {};
                    default { ERROR_2("No key (%1) defined for unit (%2) to restore.", _key, str _unitObj) };
                };
            } forEach _unitHash;
            _count = _count + 1;
        } else { ERROR_1("No object find for unit (%1).", _unitHash get "objStr") };
    } forEach _units;
} forEach _sections;

_count
