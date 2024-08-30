#include "script_macros.hpp"
/*
 * Author: Pixelated_Grunt
 * Save data sent via event handler, client variable is set with results stored in a hashmap
 *
 * Arguments:
 * 0: Array of arrays of data to be saved <ARRAY>
 * 1: Client who makes the request <OBJECT>
 * 2: Optional whether to purge section before save <BOOL> {default: false}
 *
 * Return Value:
 * Client variable of results <HASHMAP>
 *
 * Examples:
 * [[["section", _dataHashMap]], player] call niloc_fnc_saveIncomingData
 * [[["section", _dataHashMap], ["section2", _dataHashMap2]], player] call niloc_fnc_saveIncomingData
 *
 * Public: No
**/


params [
    ["_data", [], [[]]],
    ["_client", objNull, [objNull]],
    ["_purge", false, [false]]
];

private _responseHash = createHashMap;

{
    private ["_res", "_section"];

    _section = _x select 0;

    if (_purge) then { [_section] call FUNCMAIN(deleteSection) };
    _res = 0;
    _res = [_section, [_x select 1]] call FUNCMAIN(putSection);
    _responseHash set [_section, _res];
} forEach _data;

_client setVariable [QGVAR(responseFromSaveRequest), _responseHash, true]
