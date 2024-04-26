#include "script_macros.hpp"
/*
 * Author: Pixelated_Grunt
 * Central function to save the mission
 *
 * Arguments:
 * 0: player who saves the game <OBJECT>
 *
 * Return Valuej:
 * Return true if all items are saved false if otherwise <BOOL>
 *
 * Example:
 * [] call XDF_fnc_saveWorld
 *
 * Public: Yes
**/


if !(isServer) exitWith { ERROR("NiLOC system only works in MP games."); false };
params [["_player", objNull, [objNull]]];

private ["_lastSave", "_saveCounts", "_minsFromLastSave", "_count"];

_count = 0;
_lastSave = (["session", ["session.last.save"]] call FUNCMAIN(getSectionAsHashmap)) get "session.last.save";
_saveCounts = (["session", ["session.save.counts"]] call FUNCMAIN(getSectionAsHashmap)) get "session.save.counts";
_minsFromLastSave = diag_tickTime - _lastSave;

if ((missionNamespace getVariable [QGVAR(saveOnce), false]) && (_lastSave > 0)) exitWith {
    INFO("Save once per game session setting is on ... not saving.");
    [_player, [QGVAR(saveStatusColour), HEX_RED]] remoteExec ["setVariable", _player];
    false
};

if ((missionNamespace getVariable [QGVAR(minsBetweenSaves), 60]) > _minsFromLastSave) exitWith {
    INFO("Too short between save ... not saving.");
    [_player, [QGVAR(saveStatusColour), HEX_AMBER]] remoteExec ["setVariable", _player];
    false
};

INFO("==================== Save Mission Starts ====================");

INFO("-------------------- Saving Mission Parameters --------------------");
_count = [] call FUNCMAIN(saveMissionState);
INFO_1("(%1) mission parameters had been saved.", _count);

INFO("-------------------- Saving User Map Markers --------------------");
_count = [] call FUNCMAIN(saveUserMarkers);
INFO_1("(%1) user placed markers had been saved.", _count);

INFO("-------------------- Saving AI Units --------------------");
_count = [] call FUNCMAIN(saveUnitsStates);
INFO_1("(%1) AI units had been saved.", _count);

INFO("-------------------- Saving Vehicles --------------------");
_count = [] call FUNCMAIN(saveVehiclesStates);
INFO_1("(%1) vehicles had been saved.", _count);

INFO("-------------------- Saving Players --------------------");
_count = [] call FUNCMAIN(savePlayersStates);
INFO_1("(%1) players had been saved.", _count);

// Update session & player ace icon colour
["session", ["session.last.save", diag_tickTime]] call FUNCMAIN(putSection);
["session", ["session.save.counts", _saveCounts + 1]] call FUNCMAIN(putSection);
[_player, [QGVAR(saveStatusColour), HEX_GREEN]] remoteExec ["setVariable", _player];
INFO("==================== Save Mission Finished ====================");

true
