#include "script_macros.hpp"
/*
 * Author: Pixelated_Grunt
 * Initialise the niloc system from cfgfunctions
 *
 * Arguments:
 * Nil
 *
 * Return Value:
 * Nil
 *
 * Example:
 * [] call XDF_fnc_initialise
 *
 * Public: No
**/


if (!isServer) exitWith { ERROR("NiLoc only runs on a server.") };

waitUntil { time > 0 };
addMissionEventHandler [
    "EntityKilled", {
        params ["_unit", "", "", ""];

        [_unit] call FUNCMAIN(handleDeadEntity);
    }
];

addMissionEventHandler [
    "EntityDeleted", {
        params ["_entity"];

        [_entity] call FUNCMAIN(handleDeadEntity);
    }
];

addMissionEventHandler [
    "HandleDisconnect", {
        params ["_unit", "", "", ""];

        private _sectionHash = ["players"] call FUNCMAIN(getSectionAsHashmap);

        // Only save if record doesn't already exist
        if ((count _sectionHash == 0) or !(str _unit in _sectionHash)) then {
            [_unit] call FUNCMAIN(savePlayersStates);
        };
    }
];

INFO("==================== NiLOC Initialisation Starts ====================");
INFO("-------------------- Setting Up Database --------------------");
waitUntil { [] call FUNCMAIN(dbInit) };

private _sessionHash = ["session", ["session.number"]] call FUNCMAIN(getSectionAsHashmap);

if (_sessionHash get "session.number" > 1) then {
    private "_result";

    INFO("-------------------- Loading User Map Markers --------------------");
    _result = [] call FUNCMAIN(restoreUserMarkers);

    if (_result == 0) then {
        INFO("No user markers found in database to restore.")
    } else {
        INFO("%1 user markers loaded.", _result);
        ["session", ["session.loaded.markers", _result]] call FUNCMAIN(putSection);
    };

    INFO("-------------------- Handling Dead Units --------------------");
    _result = [] call FUNCMAIN(removeDeadUnits);

    if (_result == 0) then {
        INFO("No dead units found to be handled.");
    } else {
        INFO("%1 dead units handled.", _result);
        ["session", ["session.loaded.dead.units", _result]] call FUNCMAIN(putSection);
    };

    INFO("-------------------- Restoring Units States --------------------");
    _result = [] call FUNCMAIN(restoreUnitsStates);

    if (_result == 0) then {
        INFO("No unit states found in database to restore.");
    } else {
        INFO("%1 units states had been restored.", _result);
        ["session", ["session.loaded.units", _result]] call FUNCMAIN(putSection);
    };
};

INFO("==================== NiLOC Initialisation Finished ====================");