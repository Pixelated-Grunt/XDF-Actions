#include "script_macros.hpp"
/*
 * Author: Pixelated_Grunt
 * Restore user placed markers on map found in database
 *
 * Arguments:
 * 0: Restore with Player ID <BOOL> (default: {false})
 *
 * Return Value:
 * Total number of markers restored <NUMBER>
 *
 * Example:
 * [] call XDF_fnc_restoreUserMarkers
 *
 * Public: Yes
**/


params [["_keepPlayerID", false, [false]]];
private ["_resHash", "_count", "_fnc_replacePlayerID"];

_resHash = ["markers"] call FUNCMAIN(getSection);
_count = 0;

// Replace the play id to 0 within the marker meta data, 0 seems to work fine
_fnc_replacePlayerID = {
    params["_str"];
    private ["_pos", "_pos2", "_return", "_len"];

    _pos = _str find "#";
    _pos2 = _str find "/";
    _len = _pos2 - _pos;
    _return = "";

    while {(_pos != -1) && (count _str > 0)} do {
        _return = _return + (_str select [0, _pos]) + "0";

        _str = (_str select [_pos + _len]);
        _pos = _str find "#";
    };
    _return + _str;
};

if ((count _resHash) == 0) exitWith {WARNING("The markers section is empty or doesn't exist."); 0};

{
    // LOG_2("The marker hash return key (%1) with value (%2).", _x, _y);
    if (_y != "") then {

        if (_keepPlayerID) then {
            [_y] call FUNCMAIN(stringToMarker);
        } else {
            _y = _y call _fnc_replacePlayerID;
            [_y] call FUNCMAIN(stringToMarker);
        };

        _count = _count + 1;
    } else {
        WARNING_1("The (%1) marker string is empty.", _x);
        LOG_2("_resHash key (%) value (%2)", _x, _y);
    };
} forEach _resHash;

// NOTE: This counter will show every marker restore including duplicates from db.
// Can do a dupe check, extra code for little gain though. Maybe when this number become useful.
_count
