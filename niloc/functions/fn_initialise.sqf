#include "script_macros.hpp"
/*
 * Author: Pixelated_Grunt
 * Initialise the niloc system from cfgfunctions
 *
 * Arguments:
 * Nil
 *
 * Return Value:
 * Nil
 *
 * Example:
 * [] call XDF_fnc_initialise
 *
 * Public: No
**/


if (!isServer) exitWith { ERROR("NiLoc only works in multipler mode.") };

waitUntil { time > 0 };
addMissionEventHandler [
    "EntityKilled", {
        params ["_unit", "", "", ""];

        [_unit] call FUNCMAIN(handleDeadEntity);
    }
];

addMissionEventHandler [
    "EntityDeleted", {
        params ["_entity"];

        [_entity] call FUNCMAIN(handleDeadEntity);
    }
];

[] call FUNCMAIN(dbInit);
