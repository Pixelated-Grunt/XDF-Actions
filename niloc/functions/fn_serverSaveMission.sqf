#include "script_macros.hpp"
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
 * [player] call XDF_fnc_serverSaveMission
 *
 * Public: Yes
**/


if !(isServer) exitWith { ERROR("NiLOC system only works in MP games."); false };
params [["_client", objNull, [objNull]]];

_client setVariable [QGVAR(saveMissionOk), nil];
private ["_lastSave", "_saveCount", "_minsFromLastSave", "_count"];

_count = 0;
_lastSave = (["session", ["session.last.save"]] call FUNCMAIN(getSectionAsHashmap)) get "session.last.save";
_saveCount = (["session", ["session.save.count"]] call FUNCMAIN(getSectionAsHashmap)) get "session.save.count";
_minsFromLastSave = diag_tickTime - _lastSave;

if ((missionNamespace getVariable [QGVAR(saveOnce), false]) && (_lastSave > 0)) exitWith {
    INFO("Save once per game session setting is on ... not saving.");
    _client setVariable [QGVAR(saveStatusColour), HEX_RED];
    _client setVariable [QGVAR(saveMissionOk), false]
};

if ((missionNamespace getVariable [QGVAR(timeBetweenSaves), 60]) > _minsFromLastSave) exitWith {
    INFO("Too short between save ... not saving.");
    _client setVariable [QGVAR(saveStatusColour), HEX_AMBER];
    _client setVariable [QGVAR(saveMissionOk), false]
};

INFO("==================== Save Mission Starts ====================");

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
_client setVariable [QGVAR(saveStatusColour), HEX_GREEN];
INFO("==================== Save Mission Finished ===================");

_client setVariable [QGVAR(saveMissionOk), true]
