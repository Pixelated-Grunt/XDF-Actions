/*
    Authors: 
        Killzone_Kid (original, BIS_fnc_markerToString)
        Kaleb (added marker polyline support)

    Description:
        Serializes marker to string for storage (supports polylines).

    Parameter(s):
        0: STRING - existing marker name
        1: STRING (Optional) - a single data delimiter character. Default "|"

    Returns:
        STRING - serialized marker to be used with GLMRK_fnc_stringToMarker or GLMRK_fnc_stringToMarkerLocal 
        or 
        "" on error

    Example:
        ["marker_0"] call GLMRK_fnc_markerToString;
        ["marker_1", ":"] call GLMRK_fnc_markerToString;
*/

params [["_markerName", "", [""]], ["_delimiter", "|", [""]]];

private _markerShape = markerShape _markerName;
private _markerType = [configName (configFile >> "CfgMarkers" >> markerType _markerName), ""] select ((markerType _markerName) == "");

if ( (_markerShape != "POLYLINE") && (_markerType isEqualTo "") ) exitWith { [["Invalid marker type for `%1`", "Marker `%1` does not exist"] select (allMapMarkers findIf { _x == _markerName } < 0), _markerName] call BIS_fnc_error; "" };

toFixed 4;
private _markerPosition = str markerPos [_markerName, true];
private _markerPolyline = str markerPolyline _markerName;
toFixed -1; 

[
    "",
    _markerName,
    _markerPosition,
    ["polyline", _markerType] select (_markerShape != "POLYLINE"), 
    _markerShape, 
    _markerPolyline,
    markerSize _markerName, 
    markerDir _markerName,
    markerBrush _markerName, 
    markerColor _markerName, 
    markerAlpha _markerName, 
    markerText _markerName
]
joinString _delimiter
