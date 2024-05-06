#include "script_macros.hpp"
/*
 * Author: Pixelated_Grunt
 * Update a user marker record when it is created/updated/deleted
 *
 * Arguments:
 * 0: Action to perform <STRING> {default: create}
 * 0: Name of the marker <STRING>
 * 1: Optional channel number <NUMBER> {default: 0}
 *
 * Return Value:
 * Nil
 *
 * Example:
 * [] call XDF_fnc_handleUserMarker
 *
 * Public: No
**/


params [
    ["_action", "create", [""]],
    ["_marker", "", [""]],
    ["_channel", 0, [0]]
];

LOG_2("Name of marker: (%1) channel: (%2).", _marker, _channel);
//private ["_markerStr"];

//{
//    private ["_res", "_markerStr"];
//
//    if (_x select [0, 15] == "_USER_DEFINED #") then {
//        _markerStr = [_x, "~"] call FUNCMAIN(markerToString);
//
//        _res = ["markers", [_x, _markerStr]] call FUNCMAIN(putSection);
//
//        if (_res == 0) then {WARNING_1("Couldn't save marker [%1] to database.", _x)};
//    } else {
//        INFO_1("Discarded non user placed marker [%1]", _x);
//    };
//} forEach allMapMarkers;
