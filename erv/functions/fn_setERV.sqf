#include "script_macros.hpp"
/*
 * Author: Pixelated_Grunt
 * Initialise the ERV action
 *
 * Arguments:
 * Nil
 *
 * Return Value:
 * Nil
 *
 * Example:
 * [] call XDF_fnc_setERV
 *
 * Public: No
**/


params ["_player"];

private _group = groupId group _player;
private _markerName = format["respawn_west_%1", _group];
private _markerText = format["%1 ERV", _group];

openMap true;
[_markerName, _markerText] onMapSingleClick {
    params ["_marker", "_markerText", "_pos"];

    if !(_marker in allMapMarkers) then {
        createMarkerLocal [_marker, [0,0,0]];
    };
    _marker setMarkerColorLocal 'ColorBlue';
    _marker setMarkerTypeLocal 'mil_end';
    _marker setMarkerText _markerText;
    _marker setMarkerPos _pos;
    true;
};

addMissionEventHandler ["Map", {
    params ["_mapIsOpened"];

    if !_mapIsOpened then {
        onMapSingleClick "";
        removeMissionEventHandler ["Map", _thisEventHandler];
    };
}];
