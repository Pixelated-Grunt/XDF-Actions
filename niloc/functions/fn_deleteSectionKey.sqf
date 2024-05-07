#include "script_macros.hpp"
/*
 * Author: Pixelated_Grunt
 * Internal function to delete a key (a record) from given section.
 * It calls fnc_updateMeta to update the meta section as well.
 *
 * Arguments:
 * 0: The name of the section to delete from <STRING>
 * 1: Key to be deleted from section <STRING>
 * 2: Optional update meta section <BOOL> {default: true}
 *
 * Return Value:
 * Successful delete from value or not <BOOL>
 *
 * Example:
 * _result = ["players", _key] call XDF_fnc_deleteSectionKey
 *
 * Public: No
**/


params [
    ["_section", "", [""]],
    ["_key", "", [""]],
    ["_updateMeta", true, [true]]
];

LOG_1("_section: (%1) _key: (%2).", _section, _key);
private _iniDBi = [] call FUNCMAIN(getDbInstance);
private _value = ["read", [_section, _key]] call _iniDBi;

if (_value isNotEqualTo false) then {
    // Delete from database
    if (["deleteKey", [_section, _key]] call _iniDBi) then {
        // Delete from meta
        if (_updateMeta) then { ["delete", _section, _key] call FUNCMAIN(updateMeta) };
        true    // True as long as key is removed from main section, ignore if meta update failed
    } else { ERROR_2("Key (%1) exist but failed to delete from section (%2).", _key, _section); false };
} else {ERROR_2("Key (%1) does not exist in section (%2) to be deleted.", _key, _section); false }
