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
 * _stats = ["unit"] call XDF_fnc_returnStats
 *
 * Public: No
**/


params [["_type", "", [""]]];

private ["_stats", "_extraStats"];

_extraStats = [];
switch (_type) do {
    case "unit": { _stats = UNITSTATS; _extraStats = UNITSTATSEXTRA };
    case "player": { _stats = PLAYERSTATS };
    case "vehicle": {};
    default {ERROR_1("Stats type (%1) is incorrect.", _type)};
};

//NOTE: Remove me
//if (missionNamespace getVariable [QGVAR(enableCreate), false]) then { _stats = _stats + _extraStats };
_stats = _stats + _extraStats;
_stats
