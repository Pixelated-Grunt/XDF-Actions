#include "script_macros.hpp"
/*
 * Author: Pixelated_Grunt
 * Get keys from database section and their values as hashmaps and return them in an array
 * Expect the values from database in format of "[["key1", "key2"], [["value", "other value"], ["value", "other value"]]]"
 *
 * Arguments:
 * 0: Name of the section <STRING>
 * 1: Optional array contains a list of keys to retrieve <ARRAY>
 *
 * Return Value:
 * Array of hashmaps for all keys and their values <ARRAY>
 *
 * Example:
 * _sectionArray = ["units.EAST"] call XDF_fnc_getSectionAsArrayOfHashmaps
 *
 * Public: No
 */


params [
    ["_section", "", [""]],
    ["_includes", [], [[]]]
];
private ["_keys", "_iniDBi", "_results"];

_iniDBi = [] call FUNCMAIN(getDbIntance);
_keys = ["getKeys", _section] call _iniDBi;
_results = [];

if (count _keys > 0) then {
    if (count _includes > 0) then { _keys = _includes };

    {
        private _value = ["read", [_section, _x]] call _iniDBi;
        LOG_3("Value (%1) from section (%2) with key (%3)", _value, _section, _x);

        _value call {
            if (params [["_valuesArray", [], [[]], 2]]) then {
                private _arrayOfKeys = _valuesArray select 0 select 0;
                private _arrayOfValues = _valuesArray select 0 select 1;
                private _recordHash = _arrayOfKeys createHashMapFromArray _arrayOfValues;

                if (count _recordHash > 0) then {
                    _results pushBack _recordHash;
                } else {
                    ERROR_2("Array of keys (%1) and array of values (%2) created an empty hashmap.", _arrayOfKeys, _arrayOfValues);
                };
            };
        };
    } forEach _keys;
} else {
    WARNING_1("Section %1 from the NiLoc database does not have any data.");
};
