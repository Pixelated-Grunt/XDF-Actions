#include "..\script_component.hpp"
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
 * [] call niloc_fnc_clientLoadMission
 *
 * Public: Yes
**/


LOG_1("Inside clientLoadMission before hasInterface check.");
if !(hasInterface) exitWith {};

LOG_1("Inside clientLoadMission");
["ServerLoadMission", player] call CBA_fnc_serverEvent
