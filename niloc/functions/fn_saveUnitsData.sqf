#include "script_macros.hpp"
/*
 * Author: Pixelated_Grunt
 * Save data of all units excluding playable
 *
 * Arguments:
 * Nil
 *
 * Return Valuej:
 * Return number of units saved <NUMBER>
 *
 * Example:
 * [] call XDF_fnc_saveUnitsData
 *
 * Public: Yes
**/


// All units except players
private _units = ALIVEAIS;
private _count = 0;

{
    private ["_section", "_unitArray", "_res", "_key"];

    _section = "units." + str side _x;
    _unitArray = toArray ([_x] call FUNCMAIN(prepUnitData));

    _res = 0;
    _key = str _x;
    _res = [_section, [_key, _unitArray]] call FUNCMAIN(putSection);

    if (_res != 0) then {
        _count = _count + 1;
    } else { ERROR_3("Failed to write key (%1) value (%2) to section (%3).", _x, _unitArray, _section) };
} forEach _units;

_count
