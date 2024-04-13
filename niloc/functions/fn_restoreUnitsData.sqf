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


private ["_unitSections", "_aliveAIs", "_count"];

_unitSections = ["units."] call FUNCMAIN(getSectionNames);
if (count _unitSections == 0) exitWith {WARNING("Unit sections are empty.")};

_aliveAIs = ALIVEAIS;
_count = 0;

{
    private ["_unitsHash"];

    _unitsHash = [_x] call FUNCMAIN(getSectionAsHashmap);

    {
        private ["_idx", "_unitStr", "_unitObj"];
        _unitStr = _x;
        _idx = _aliveAIs findIf { str _x isEqualTo _unitStr };

        if (_idx > -1) then {
            private _unitStats = _unitHash get _unitStr;

            _unitObj = _aliveAIs select _idx;
            {

            } forEach _unitStats;

            _count = _count + 1;
        } else {
            WARNING_1("Couldn't find unit (%1) to restore.", _unitStr);
        };
    } forEach _unitHash;
} forEach _unitSections;

_count
