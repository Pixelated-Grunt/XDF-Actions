#include "script_macros.hpp"
/*
 * Author: Pixelated_Grunt
 * Backup exiting database before game shutdown
 *
 * Arguments:
 * Nil
 *
 * Return Value:
 * Nil
 *
 * Example:
 * [] call XDF_fnc_backupDatabase
 *
 * Public: No
**/


private ["_iniDBiOld", "_iniDBiNew", "_oldDbName", "_newDbName", "_sections"];

_iniDBiOld = [] call FUNCMAIN(getDbInstance);
_oldDbName = "getDbName" call _iniDBiOld;
_newDbName = _oldDbName + "." + ["read", ["session", "session.number"]] call _iniDBiOld;
_iniDBiNew = ["new", _newDbName] call OO_iniDBi;
_sections = [] call FUNCMAIN(getSectionNames);

if (IS_OBJECT(_iniDBiNew)) then {
    {
        private _sectionHash = [_x] call FUNCMAIN(getSectionAsHashmap);

        [_x, [_sectionHash], _newDbName, false] call FUNCMAIN(putSection);
    } forEach _sections;

    if (count [_iniDBiNew] call FUNCMAIN(getSectionNames) == count _sections) then {
        INFO("Database backup successfully.");
    } else {
        ERROR("Database backup section count failed.")
    };
} else { ERROR("Failed to create new database instance ... no backup.") }