#include "script_macros.hpp"
/*
 * Author: Pixelated_Grunt
 * Call by client to load saved mission
 *
 * Arguments:
 * Nil
 *
 * Return Value:
 * Nil
 *
 * Example:
 * [] call XDF_fnc_clientLoadMission
 *
 * Public: Yes
**/


if !(hasInterface) exitWith {};

[QGVAR(loadMissionRequest), player] call CBA_fnc_serverEvent
