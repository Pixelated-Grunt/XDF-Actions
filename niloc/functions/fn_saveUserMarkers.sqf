#include "script_macros.hpp"
/*
 * Author: Pixelated_Grunt
 * Save updated markers to the database
 *
 * Arguments:
 * Nil
 *
 * Return Valuej:
 * Return number of markers saved <NUMBER>
 *
 * Example:
 * [] call XDF_fnc_saveUserMarkers
 *
 * Public: No
**/


private ["_updatedMarkers", "_count", "_savedMarkersHash"];

_savedMarkersHash = ["markers"] call FUNCMAIN(getSectionAsHashmap);
_updatedMarkers = localNamespace getVariable [QGVAR(updatedMarkers), createHashMap];

// Save all in memory markers
if ((count _updatedMarkers) > 0) then {
    _count = 0;

    {
        if (_x in keys _savedMarkersHash) then {
            private _savedMarker = _savedMarkersHash get _x;
            private _savedMarkerArray = _savedMarker splitString "~";
            private _updatedMarkerArray = (_updatedMarkers get _x) splitString "~";

            _updatedMarkerArray set [8, _savedMarkerArray # 8];
            _updatedMarkerArray set [9, _savedMarkerArray # 9];
            _savedMarkersHash set [_x, "~" + (_updatedMarkerArray joinString "~")];
            INC(_count);
        };
    } forEach keys _updatedMarkers;
    LOG_1("(%1) updated markers saved.", _count)
};

// Read then purge markers section
{
    ["markers", _x] call FUNCMAIN(deleteSectionKey)
} forEach keys _savedMarkersHash;

// Reorder markers before write them back
if (count _savedMarkersHash > 0) then {
    _count = 0;

    {
        private ["_mrkName", "_oldMarkerStr", "_markerStrArray", "_markerStr"];

        _oldMarkerStr = _y;
        _markerStrArray = _oldMarkerStr splitString "~";
        _mrkName = _x regexReplace ["#[0-9]+\/[0-9]+/gi", "#0\/" + str _count];
        _markerStrArray set [0, _mrkName];
        _markerStr = "~" + (_markerStrArray joinString "~");
        LOG_1("New marker string from save world: (%1).", _markerStr);

        ["markers", [_mrkName, _markerStr]] call FUNCMAIN(putSection);
        INC(_count)
    } forEach _savedMarkersHash;
};

_count
