#include "script_macros.hpp"
/*
 * Author: Pixelated_Grunt
 * Restore user placed markers on map found in database
 *
 * Arguments:
 * Nil
 *
 * Return Value:
 * Total number of markers restored <NUMBER>
 *
 * Example:
 * [] call niloc_fnc_restoreUserMarkers
 *
 * Public: No
**/


private ["_resHash", "_count"];

_resHash = ["markers"] call FUNCMAIN(getSectionAsHashmap);
_count = 0;

if ((count _resHash) == 0) exitWith { 0 };

{
    if (_y != "") then {
        [_y] call FUNCMAIN(stringToMarker);
        INC(_count)
    } else {
        WARNING_1("The (%1) marker string is empty.", _x);
    };
} forEach _resHash;

_count
