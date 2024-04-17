#include "script_macros.hpp"
/*
 * Author: Pixelated_Grunt
 * Internal function that provides an interface to get data from the database
 *
 * Arguments:
 * 0: The name of the section to return <STRING>
 * 1: Optional array of keys that will be returned only <ARRAY>
 *
 * Return Value:
 * A hashmap with all key value pairs from the section <HASHMAP>
 *
 * Example:
 * _resHash = ["mission", ["dateTime"]] call XDF_fnc_getSectionAsHashmap
 *
 * Public: No
 */


params [
    ["_section", "", [""]],
    ["_includes", [], [[]]]
];
private ["_keys", "_resHash", "_iniDBi"];

_iniDBi = [] call FUNCMAIN(getDbInstance);
_resHash = createHashMap;
_keys = ["read", ["meta", _section, []]] call _iniDBi;

if (count _keys > 0) then {
    if (count _includes > 0) then { _keys = _includes };

    {
        private "_value";
        _value = ["read", [_section, _x, nil]] call _iniDBi;
        _resHash set [_x, _value];
    } forEach _keys;
} else {
    WARNING_1("Section %1 from the NiLoc database does not have any data.");
};

_resHash
