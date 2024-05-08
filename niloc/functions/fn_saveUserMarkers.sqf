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


private ["_updatedMarkers", "_count", "_updatedCount", "_savedMarkersHash"];

_updatedMarkers = localNamespace getVariable [QGVAR(updatedMarkers), createHashMap];
_count = count _updatedMarkers;
_updatedCount = 0;

if (_count > 0) then {
    private _markersHash = ["markers"] call FUNCMAIN(getSectionAsHashmap);
    private _markerNames = keys _updatedMarkers;

    {
        if (_x in keys _markersHash) then {
            private _savedMarker = _markersHash get _x;
            private _savedMarkerArray = _savedMarker splitString "~";
            private _updatedMarkerArray = (_updatedMarkers get _x) splitString "~";

            _updatedMarkerArray set [8, _savedMarkerArray # 8];
            _updatedMarkerArray set [9, _savedMarkerArray # 9];

            if (["markers", [_x, "~" + (_updatedMarkerArray joinString "~")]] call FUNCMAIN(putSection) == 1) then {
                INC(_updatedCount)
            } else {
                ERROR_1("Failed to save updated marker (%1) to database.", _x)
            }
        }
    } forEach _markerNames;
    LOG_1("(%1) updated markers saved.", _updatedCount)
};

_savedMarkersHash = ["markers"] call FUNCMAIN(getSectionAsHashmap);
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

        if ((["markers", [_mrkName, _markerStr]] call FUNCMAIN(putSection)) == 1) then {
            INC(_count);
            if (_mrkName != _x) then { ["markers", _x] call FUNCMAIN(deleteSectionKey) }
        } else { ERROR_1("Failed to save marker (%1).", _mrkName) }
    } forEach _savedMarkersHash;
};

_count
