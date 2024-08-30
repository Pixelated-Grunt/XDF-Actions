#include "script_macros.hpp"
/*
 * Author: Pixelated_Grunt
 * Return what stats to process for the given object type e.g. unit, vehicle
 *
 * Arguments:
 * 0: Type of stats to return <STRING>
 *
 * Return Value:
 * Stats for the particular type <ARRAY>
 *
 * Example:
 * _stats = ["unit"] call niloc_fnc_returnStats
 *
 * Public: No
**/


params [["_type", "", [""]]];

private ["_stats", "_extraStats"];

_extraStats = [];
switch (_type) do {
    case "unit": { _stats = UNIT_STATS; _extraStats = UNIT_STATS_EXTRA };
    case "player": { _stats = PLAYER_STATS };
    case "vehicle": { _stats = VEHICLE_STATS };
    default {ERROR_1("Stats type (%1) is incorrect.", _type)};
};

if (missionNamespace getVariable [QGVARMAIN(enableCreate), true]) then { _stats = _stats + _extraStats };
_stats
