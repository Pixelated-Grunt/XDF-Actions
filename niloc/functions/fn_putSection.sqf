#include "script_macros.hpp"
/*
 * Author: Pixelated_Grunt
 * Internal function that provides an interface to write data to the database.
 * It also calls fnc_updateMeta to update the meta section.
 *
 * Arguments:
 * 0: The name of the section to write to <STRING>
 * 1: An array of values to be written <ARRAY>
 *      Array can contain hashmap(s), array(s) or a string
 * 2: Optional db instance <OBJECT>
 * 3: Optional update meta section <BOOL> {default: true}
 *
 * Return Value:
 * Number of records written <NUMBER>
 *
 * Examples:
 * _count = ["section", [_aHashmap]] call XDF_fnc_putSection
 * _count = ["section", [["key", "value"], ["key2", "value2"]]] call XDF_fnc_putSection
 * _count = ["section", [_key, ["value1", "value2"]]] call XDF_fnc_putSection
 * _count = ["section", [_key, "value"]]] call XDF_fnc_putSection
 *
 * Public: No
**/


if (!isServer) exitWith { ERROR("NiLOC only runs on a server.") };
params [
    ["_section", "", [""]],
    ["_data", [], [[]]],
    ["_db", objNull, [objNull]],
    ["_updateMeta", true, [true]]
];
private ["_iniDBi", "_recordsPut", "_writeOk"];

_iniDBi = if (isNull _db) then [{[] call FUNCMAIN(getDbInstance)}, {_db}];
_recordsPut = 0;
_writeOk = false;

switch (typeName (_data select 0)) do {
    case "HASHMAP": {
        {
            {
                _writeOk = ["write", [_section, _x, _y]] call _iniDBi;
                if (_writeOk) then {
                    if (_updateMeta) then { ["add", _section, _x] call FUNCMAIN(updateMeta) };
                    _recordsPut = _recordsPut + 1;
                } else { ERROR_3("Failed to write key (%1) with value (%2) to section (%3)", _x, _y, _section) };
            } forEach _x;   //hashmap
        } forEach _data;    //array
    };
    case "ARRAY": {
        {
            private _key = _x select 0;
            private _value = _x select 1;

            _writeOk = ["write", [_section, _key, _value]] call _iniDBi;
            if (_writeOk) then {
                if (_updateMeta) then { ["add", _section, _key] call FUNCMAIN(updateMeta) };
                _recordsPut = _recordsPut + 1;
            } else { ERROR_3("Failed to write key (%1) with value (%2) to section (%3)", _key, _value, _section) };
        } forEach _data;
    };
    case "STRING": {
        private _key = _data select 0;
        private _value = _data select 1;

        _writeOk = ["write", [_section, _key, _value]] call _iniDBi;
        if (_writeOk) then {
            if (_updateMeta) then { ["add", _section, _key] call FUNCMAIN(updateMeta) };
            _recordsPut = _recordsPut + 1;
        } else { ERROR_3("Failed to write key (%1) with value (%2) to section (%3)", _key, _value, _section) };
    };
    default { ERROR_1("(%1) is not a valid input for this function.", typeName (_data select 0)) };
};

_recordsPut
