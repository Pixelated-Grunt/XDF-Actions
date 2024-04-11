#include "script_macros.hpp"
/*
 * Author: Pixelated_Grunt
 * Restore data for a single unit
 *
 * Arguments:
 * 0: The unit to be restored <STRING>
 *
 * Return Value:
 * Total number of records restored <NUMBER>
 *
 * Example:
 * [] call XDF_fnc_restoreUnitData
 *
 * Public: Yes
**/


params [["_unit", "", [""]]];

private ["_unitStats"];

_unitStats = FUNCMAIN(getUnitData);
