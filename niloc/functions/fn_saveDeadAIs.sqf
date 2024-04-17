#include "script_macros.hpp"
/*
 * Author: Pixelated_Grunt
 * Save a list of dead AIs
 *
 * Arguments:
 * Nil
 *
 * Return Valuej:
 * Return number of dead units saved <NUMBER>
 *
 * Example:
 * [] call XDF_fnc_saveDeadAIs
 *
 * Public: Yes
**/


private _deadAIs = DEADAIS;
private _count = 0;

if (count _deadAIs == 0) exitWith { INFO("No dead AI units to save."); _count };

_count = ["units.DEAD", ["units", _deadAIs]] call FUNCMAIN(putSection);

_count
