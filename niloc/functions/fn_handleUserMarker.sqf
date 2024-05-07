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

if (!(_channel in [0, 1, 2]) or (_marker select [0, 15] isNotEqualTo "_USER_DEFINED #")) exitWith {};

private _markerStr = [_marker, "~"] call FUNCMAIN(markerToString);
private _markerStrArray = _markerStr splitString "~";

if (_action isEqualTo "create") then {
    private _pos = _markerStrArray select 1;
    private "_markerStr";

    // Set marker Z axis to 0
    _pos set [2, 0.0000];
    _markerStrArray set [1, _pos];
    _markerStr = "~" + (_markerStrArray joinString "~");
    LOG_1("New _markerStr from create marker: (%1).", _markerStr);

    ["markers", [_marker, _markerStr]] remoteExec [QFUNCMAIN(putSection), 2];
} else {
    if (_action isEqualTo "update") then {
        // Not a moved marker
        if (inputMouse 0 != 2) exitWith {};

        // Set marker alpha to 1
        _markerStrArray set [8, "1"];
        [[_marker, "~" + (_markerStrArray joinString "~")], {
            params ["_marker", "_markerStr"];
            private ["_updatedMarkers"];

            _updatedMarkers = localNamespace getVariable [QGVAR(updatedMarkers), createHashMap];

            LOG_1("New _markerStr from update marker: (%1).", _markerStr);
            _updatedMarkers set [_marker, _markerStr];
            localNamespace setVariable [QGVAR(updatedMarkers), _updatedMarkers];
        }] remoteExec ["call", 2];
    } else {    //delete
        ["markers", _marker] remoteExec [QFUNCMAIN(deleteSectionKey), 2];
    }
}
