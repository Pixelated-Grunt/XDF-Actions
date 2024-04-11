#include "script_macros.hpp"
/*
 * Author: Pixelated_Grunt
 * Restore data for all alive units from the database
 *
 * Arguments:
 * Nil
 *
 * Return Value:
 * Total number of units restored <NUMBER>
 *
 * Example:
 * [] call XDF_fnc_restoreUnitsData
 *
 * Public: Yes
**/


params [["_unit", "", [""]]];

private ["_unitStats"];

_unitStats = FUNCMAIN(getUnitData);
