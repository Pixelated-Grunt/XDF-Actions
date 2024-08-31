#include "..\script_component.hpp"
/*
 * Author: Pixelated_Grunt
 * Call by client to save the mission
 *
 * Arguments:
 * 0: client who makes the call <OBJECT>
 *
 * Return Value:
 * Nil but set variable on client object of save result <BOOL>
 *
 * Example:
 * [player] call niloc_fnc_serverSaveMission
 *
 * Public: Yes
**/


if !(isServer) exitWith { ERROR("NiLOC system only works in MP games."); false };
params [["_client", objNull, [objNull]]];

_client setVariable [QGVAR(saveMissionOk), nil, true];
private ["_lastSave", "_saveCount", "_secFromLastSave", "_count", "_cachedEntities"];

_count = 0;
_lastSave = (["session", ["session.last.save"]] call FUNCMAIN(getSectionAsHashmap)) get "session.last.save";
_saveCount = (["session", ["session.save.count"]] call FUNCMAIN(getSectionAsHashmap)) get "session.save.count";
_secFromLastSave = diag_tickTime - _lastSave;

if ((missionNamespace getVariable [QGVARMAIN(saveOnce), false]) && (_lastSave > 0)) exitWith {
    INFO("Save once per game session setting is on ... not saving.");
    _client setVariable [QGVAR(saveStatusColour), HEX_RED, true];
    _client setVariable [QGVAR(saveMissionOk), false, true]
};

if ((missionNamespace getVariable [QGVARMAIN(timeBetweenSaves), 60]) > _secFromLastSave) exitWith {
    INFO("Too short between save ... not saving.");
    _client setVariable [QGVAR(saveStatusColour), HEX_AMBER, true];
    _client setVariable [QGVAR(saveMissionOk), false, true]
};

INFO("==================== Save Mission Starts ====================");

INFO("----------------- Saving Cached Entities --------------------");
_cachedEntities = localNamespace getVariable [QGVAR(cachedEntities), createHashMap];

if (count _cachedEntities == 0) then {
    INFO("No cached entity to save.")
} else {
    {
        private _section = _x;
        private _arrayOfEntities = _y;

        {
            if (_section isEqualTo "players") then {
                [_section, [_x get "playerUid", toArray(_x)]] call FUNCMAIN(putSection)
            } else {    // dead units
                [_section, [_x # 0, _x # 1]] call FUNCMAIN(putSection)
            }
        } forEach _arrayOfEntities;
        INFO_2("(%1) cached %2 saved.", count _arrayOfEntities, _section)
    } forEach _cachedEntities
};

INFO("----------------- Saving Mission Parameters -----------------");
_count = [] call FUNCMAIN(saveMissionState);
INFO_1("(%1) mission parameters had been saved.", _count);

INFO("------------------ Saved User Map Markers ------------------");
_count = (count ((["meta", ["markers"]] call FUNCMAIN(getSectionAsHashmap)) get "markers"));
INFO_1("(%1) user markers had been saved.", _count);

INFO("---------------------- Saving AI Units ----------------------");
_count = [] call FUNCMAIN(saveUnitsStates);
INFO_1("(%1) AI units had been saved.", _count);

INFO("---------------------- Saving Vehicles ----------------------");
_count = [] call FUNCMAIN(saveVehiclesStates);
INFO_1("(%1) vehicles had been saved.", _count);

INFO("---------------------- Saving Players ------------------------");
_count = [] call FUNCMAIN(savePlayersStates);
INFO_1("(%1) players had been saved.", _count);

// Update session; global var for ui  & player ace icon colour
["session", ["session.last.save", diag_tickTime]] call FUNCMAIN(putSection);
["session", ["session.save.count", _saveCount + 1]] call FUNCMAIN(putSection);
missionNamespace setVariable [QGVAR(saveCount), _saveCount + 1, true];
_client setVariable [QGVAR(saveStatusColour), HEX_GREEN, true];
INFO("==================== Save Mission Finished ===================");

_client setVariable [QGVAR(saveMissionOk), true, true]
