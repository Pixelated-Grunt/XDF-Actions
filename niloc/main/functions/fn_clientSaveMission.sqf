#include "script_macros.hpp"
/*
 * Author: Pixelated_Grunt
 * Call by client to save the mission
 *
 * Arguments:
 * Nil
 *
 * Return Value:
 * Nil
 *
 * Example:
 * [] call XDF_fnc_clientSaveMission
 *
 * Public: Yes
**/


if !(hasInterface) exitWith {};
private ["_count", "_allUserMarkers", "_markersHash"];

// only for global and side channel user placed markers
_allUserMarkers = allMapMarkers select {
    (_x select [0, 15] isEqualTo "_USER_DEFINED #") and
    { (_x select [(count _x)-1, 1] in "01") }
};

if (count _allUserMarkers > 0) then {
    _markersHash = createHashMap;
    _count = 0;

    {
        private ["_markerStr", "_markerName", "_markerStrArray"];

        INC(_count);
        _markerName = _x regexReplace ["#[0-9]+\/[0-9]+/gi", "#0\/" + str _count];
        _markerStr = [_x, "~"] call FUNCMAIN(markerToString);
        _markerStrArray = _markerStr splitString "~";
        _markerStrArray set [0, _markerName];
        _markerStr = "~" + (_markerStrArray joinString "~");

        _markersHash set [_markerName, _markerStr]
    } forEach _allUserMarkers;
    [QGVAR(saveToSectionRequest), [[["markers", _markersHash]], player, true]] call CBA_fnc_serverEvent;

    [
        { (player getVariable QGVAR(responseFromSaveRequest)) get "markers" > 0 },
        { true },
        [],
        3,
        { WARNING("Timeout waiting for server response for saving map makers.") }
    ] call CBA_fnc_waitUntilAndExecute
};

[QGVAR(saveMissionRequest), player] call CBA_fnc_serverEvent
