#include "script_macros.hpp"
/*
 * Author: Pixelated_Grunt
 * Central function to save the mission
 *
 * Arguments:
 * Nil
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
private ["_lastSave", "_minsFromLastSave", "_count"];

_count = 0;
_lastSave = (["session", ["session.last.save"]] call FUNCMAIN(getSectionAsHashmap)) get "session.last.save";
_minsFromLastSave = serverTime - _lastSave;

if ((missionNamespace getVariable [QGVAR(saveOnce), false]) && (_lastSave > 0)) exitWith {
    INFO("Save once per game session setting is on ... not saving.");
    false
};

if ((missionNamespace getVariable [QGVAR(minsBetweenSaves), 60]) > _minsFromLastSave) exitWith {
    INFO("Too short between save ... not saving.");
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

// Update session
["session", ["session.last.save", serverTime]] call FUNCMAIN(putSection);
INFO("==================== Save Mission Finished ====================");

true
