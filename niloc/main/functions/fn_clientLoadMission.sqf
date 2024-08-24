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


LOG_1("Inside clientLoadMission before hasInterface check.");
if !(hasInterface) exitWith {};

LOG_1("Inside clientLoadMission");
[QGVAR(loadMissionRequest), player] call CBA_fnc_serverEvent
