#include "script_macros.hpp"
/*
 * Author: Pixelated_Grunt
 * Save mission settings to database
 *
 * Arguments:
 * Nil
 *
 * Return Value:
 * Return number of records written <NUMBER>
 *
 * Example:
 * [] call XDF_fnc_saveMissionState
 *
 * Public: No
**/


private _count = 0;

// in-game date time
_count = ["mission", ["date", date]] call FUNCMAIN(putSection);
if ( _count > 0) then {
    INFO("Mission settings saved successfully.");
} else {
    ERROR("Failed to write settings to database.");
};

_count
