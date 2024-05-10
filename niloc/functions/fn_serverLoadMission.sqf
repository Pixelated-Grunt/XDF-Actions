#include "script_macros.hpp"
/*
 * Author: Pixelated_Grunt
 * Function to load mission triggered by client via event handler
 *
 * Arguments:
 * 0: player who loads the game <OBJECT>
 *
 * Return Valuej:
 * Return true if all items are loaded false if otherwise <BOOL>
 *
 * Example:
 * _res = [player] call XDF_fnc_serverLoadMission
 *
 * Public: No
**/


if !(isServer) exitWith { ERROR("NiLOC system only works in MP games."); false };
params [["_client", objNull, [objNull]]];

private _count = 0;
private _lastLoad = 0;
private _sessionHash = ["session", ["session.save.count"]] call FUNCMAIN(getSectionAsHashmap);

if (_sessionHash get "session.save.count" == 0) exitWith {
    INFO("There is no save data in the database ... load skipped.");

    _client setVariable [QGVAR(loadStatusColour), HEX_AMBER];
    false
};

INFO("==================== Load Mission Starts ====================");
if !(missionNamespace getVariable [QGVAR(preloadMarkers), true]) then {
    INFO("------------------ Loading User Map Markers ------------------");
    _count = [] call FUNCMAIN(restoreUserMarkers);

    INFO_1("%1 user markers loaded.", _count);
    ["session", ["session.loaded.markers", _count]] call FUNCMAIN(putSection)
};

INFO("---------------- Restoring Mission Parameters ----------------");
_count = [] call FUNCMAIN(restoreMissionState);

INFO_1("%1 mission parameters had been loaded.", _count);
["session", ["session.loaded.mission.states", _count]] call FUNCMAIN(putSection);

["session", ["session.loaded.units", _count]] call FUNCMAIN(putSection);
INFO("------------------- Restoring Units States -------------------");
_count = [] call FUNCMAIN(restoreUnitsStates);

INFO_1("%1 units states had been restored.", _count);
["session", ["session.loaded.units", _count]] call FUNCMAIN(putSection);

INFO("------------------- Handling Dead Entities -------------------");
_count = [] call FUNCMAIN(removeDeadEntities);

INFO_1("%1 dead entities handled.", _count);
["session", ["session.loaded.dead.entities", _count]] call FUNCMAIN(putSection);

INFO("------------------ Restoring Vehicles States -----------------");
_count = [] call FUNCMAIN(restoreVehiclesStates);

INFO_1("%1 vehicles had been restored.", _count);
["session", ["session.loaded.vehicles", _count]] call FUNCMAIN(putSection);

INFO("------------------ Restoring Players States ------------------");
_count = [] call FUNCMAIN(restorePlayersStates);

INFO_1("%1 players had been restored.", _count);

// Update session & player ace menu icon colour
_lastLoad = diag_tickTime;
["session", ["session.last.load", _lastLoad]] call FUNCMAIN(putSection);
_client setVariable [QGVAR(loadStatusColour), HEX_GREEN];
INFO("==================== Load Mission Finished ===================");

true
