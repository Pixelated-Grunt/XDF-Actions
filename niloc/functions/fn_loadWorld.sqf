#include "script_macros.hpp"
/*
 * Author: Pixelated_Grunt
 * Central function to load previously saved mission data
 *
 * Arguments:
 * Nil
 *
 * Return Valuej:
 * Return true if all items are loaded false if otherwise <BOOL>
 *
 * Example:
 * [] call XDF_fnc_loadWorld
 *
 * Public: Yes
**/


if !(isServer) exitWith { ERROR("NiLoc system only works in MP games."); false };
private _count = 0;

INFO("==================== Mission Loading Starts ====================");

if !(missionNamespace getVariable [QGVAR(preloadMarkers), true]) then {
    INFO("-------------------- Loading User Map Markers --------------------");
    _count = [] call FUNCMAIN(restoreUserMarkers);

    INFO_1("%1 user markers loaded.", _count);
    ["session", ["session.loaded.markers", _count]] call FUNCMAIN(putSection);
};

INFO("---------- Restoring Mission Parameters ----------");
_count = [] call FUNCMAIN(restoreMissionState);

INFO_1("%1 mission parameters had been loaded.", _count);
["session", ["session.loaded.mission.states", _count]] call FUNCMAIN(putSection);

["session", ["session.loaded.units", _count]] call FUNCMAIN(putSection);
INFO("---------- Restoring Units States ----------");
_count = [] call FUNCMAIN(restoreUnitsStates);

INFO_1("%1 units states had been restored.", _count);
["session", ["session.loaded.units", _count]] call FUNCMAIN(putSection);

INFO("---------- Handling Dead Entities ----------");
_count = [] call FUNCMAIN(removeDeadEntities);

INFO_1("%1 dead entities handled.", _count);
["session", ["session.loaded.dead.entities", _count]] call FUNCMAIN(putSection);

INFO("---------- Restoring Vehicles States ----------");
_count = [] call FUNCMAIN(restoreVehiclesStates);

INFO_1("%1 vehicles had been restored.", _count);
["session", ["session.loaded.vehicles", _count]] call FUNCMAIN(putSection);

INFO("---------- Restoring Players States ----------");
_count = [] call FUNCMAIN(restorePlayersStates);

INFO_1("%1 players had been restored.", _count);

// Update session
["session", ["session.last.load", serverTime]] call FUNCMAIN(putSection);
INFO("==================== Load Mission Finished ====================");

true
