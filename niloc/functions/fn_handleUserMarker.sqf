#include "script_macros.hpp"
/*
 * Author: Pixelated_Grunt
 * Update a user marker record when it is created/updated/deleted
 *
 * Arguments:
 * 0: Action to perform <STRING> {default: create}
 * 1: Name of the marker <STRING>
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
    ["_marker", "", [""]]
];

if ( !(_marker select [(count _marker)-1, 1] in "012") or
    (_marker select [0, 15] isNotEqualTo "_USER_DEFINED #")
) exitWith {};

private _markerStr = [_marker, "~"] call FUNCMAIN(markerToString);
private _savedMarkerStr = ["markers"] call FUNCMAIN(getSectionAsHashmap) get _marker;

// To avoid multiple client calls on same marker
if (_savedMarkerStr != _markerStr) then {
    if (_action isEqualTo "create") then {
        LOG_1("New _markerStr from create marker: (%1).", _markerStr);
        ["markers", [_marker, _markerStr]] remoteExec [QFUNCMAIN(putSection), 2];
    } else {
        if (_action isEqualTo "update") then {
            // Not a moved marker
            if (inputMouse 0 != 2) exitWith {};

            [[_marker, _markerStr], {
                params ["_marker", "_markerStr"];
                private ["_updatedMarkers"];

                _updatedMarkers = localNamespace getVariable [QGVAR(updatedMarkers), createHashMap];

                LOG_1("New _markerStr from update marker: (%1).", _markerStr);
                _updatedMarkers set [_marker, _markerStr];
                localNamespace setVariable [QGVAR(updatedMarkers), _updatedMarkers];
            }] remoteExec ["call", 2];
        } else {    //delete
            LOG_1("_marker (%1) from handle func before delete func.", _marker);
            ["markers", _marker] remoteExec [QFUNCMAIN(deleteSectionKey), 2];
        }
    }
}
