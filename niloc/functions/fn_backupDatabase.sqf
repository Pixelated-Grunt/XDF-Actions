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


private ["_inidbiOld", "_inidbiNew", "_oldDbName", "_newDbName", "_sections"];

_inidbiOld = [] call FUNCMAIN(getDbInstance);
_oldDbName = "getDbName" call _inidbiOld;
_newDbName = format [
    "%1_%2",
    _oldDbName,
    ["read", ["session", "session.number"]] call _inidbiOld
];
_inidbiNew = ["new", _newDbName] call OO_inidbi;
_sections = [] call FUNCMAIN(getSectionNames);
LOG_1("_sections: (%1).", _sections);

if (IS_CODE(_inidbiNew)) then {
    INFO("==================== Starting Database Backup ====================");
    {
        private _sectionHash = [_x] call FUNCMAIN(getSectionAsHashmap);

        INFO_1("-= %1 =-", _x);
        [_x, [_sectionHash], _inidbiNew, false] call FUNCMAIN(putSection);
    } forEach _sections;

    if (count (["", _inidbiNew] call FUNCMAIN(getSectionNames)) == count _sections) then {
        INFO("Database backup successfully.");
    } else {
        ERROR("Database backup section count failed.")
    };
    INFO("==================== Database Backup Finished ====================");
} else { ERROR("Failed to create new database instance ... no backup.") }
