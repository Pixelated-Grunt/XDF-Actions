#include "script_macros.hpp"
/*
 * Author: Pixelated_Grunt
 * Save all user placed markers on the map
 *
 * Arguments:
 * Nil
 *
 * Return Value:
 * Number of markers saved <NUMBER>
 *
 * Example:
 * [] call XDF_fnc_saveMarkers
 *
 * Public: Yes
**/


private _markerCount = 0;

{
    private ["_res", "_markerStr"];

    if (_x select [0, 15] == "_USER_DEFINED #") then {
        _markerStr = [_x, "~"] call FUNCMAIN(markerToString);
        LOG_1("_markerStr: %1", _markerStr);

        _res = ["markers", [_x, _markerStr]] call FUNCMAIN(putSection);

        if (_res == 0) then {WARNING_1("Couldn't save marker [%1] to database.", _x)};
        _markerCount = _markerCount + _res;
    } else {
        LOG_1("Discarded non user placed marker [%1]", _x);
    };
} forEach allMapMarkers;

_markerCount
