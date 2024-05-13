#include "script_macros.hpp"
/*
 * Author: Pixelated_Grunt
 * Cache entity changes in server memory before saving to database
 *
 * Arguments:
 * 0: Type of event handler this call is from <STRING>
 * 1: Parameters usual passed to the event handler <ARRAY>
 *
 * Return Value:
 * Nil
 *
 * Example:
 * ["HandleDisconnect", _params] call XDF_fnc_cacheEntity
 *
 * Public: No
**/


params [
    ["_eventType", "", [""]],
    ["_params", [], [[]]]
];

private _cachedEntities = localNamespace getVariable [QGVAR(cachedEntities), createHashMap];

if (_eventType isEqualTo "HandleDisconnect") then {
    _params params ["_player", "_uid", "_name"];

    private _playerHash = ["player", _player, _uid, _name] call FUNCMAIN(prepUnitData);
    private _playersArray = _cachedEntities getOrDefault ["players", []];

    _cachedEntities set ["players", (_playersArray pushBack _playerHash)]
} else {    // EntityKilled
    private _entity = _params select 0;

    if ((isPlayer _entity) || !((IS_UNIT(_entity)) || (IS_VEHICLE(_entity)))) exitWith {
        INFO_1("Wrong type of entity (%1) to keep ... skipped.", str _entity)
    };

    private ["_side", "_objStr", "_objtype", "_entitiesArray"];

    _side = str side group _entity;
    if (_side isEqualTo "UNKNOWN" && IS_UNIT(_entity)) exitWith {
        INFO_1("Skipped disconnected player (%1) that turned into a dead unit.", _objStr)
    };
    _objStr = str _entity;

    // Write to dead.x section
    if (IS_UNIT(_entity)) then {
        _objType = "units"
    } else {
        _objType = "vehicles";
        _objStr = _entity getVariable [QGVAR(tag), _objStr];
    };
    _entitiesArray = _cachedEntities getOrDefault ["dead." + _objType, []];
    _entitiesArray pushBack [_objStr, [typeOf _entity, getPosASL _entity, _side]];
    _cachedEntities set ["dead." + _objType, _entitiesArray];

    // Remove from alive section
    private _section = (if (_objType == "units") then [{ _objType + "." + _side }, { _objType }]);
    private _sectionHash = [_section] call FUNCMAIN(getSectionAsHashmap);

    if (_objStr in _sectionHash) then {
        if !([_section, _objStr] call FUNCMAIN(deleteSectionKey)) then {
            WARNING_2("Dead entity (%1) recorded successfully but failed to remove from alive section (%2).", _objStr, _section)
        }
    }
};

localNamespace setVariable [QGVAR(cachedEntities), _cachedEntities]
