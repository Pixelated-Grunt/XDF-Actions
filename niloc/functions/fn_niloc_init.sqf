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
 * [] call XDF_fnc_niloc_init
 *
 * Public: No
**/


if (isServer) then {
    [
        { [] call FUNCMAIN(dbInit) },
        {
            INFO("==================== NiLOC Initialisation Starts ====================");

            // Keep this EH before database initiation
            addMissionEventHandler [
                "PlayerConnected", {
                    params ["", "_uid", "_name", "_jip", "", "_idstr"];

                    if (_name isNotEqualTo "__SERVER__") then {
                        private _sectionHash = ["session"] call FUNCMAIN(getSectionAsHashmap);

                        _sectionHash set ["session.player." + _uid, [_name, diag_tickTime, _jip, _idstr]];
                        ["session", [_sectionHash]] call FUNCMAIN(putSection)
                    }
                }
            ];

            INFO("---------- Setting Up Database ----------");
            private _sessionHash = ["session", ["session.number"]] call FUNCMAIN(getSectionAsHashmap);
            private _sessionNo = _sessionHash get "session.number";
            private _vicCount = 0;

            INFO_1("Database loaded, current game session is (%1).", _sessionNo);

            INFO("---------- Tagging Vehicles ----------");
            {
                if (IS_VEHICLE(_x)) then {
                    _vicCount = _vicCount + 1;
                    _x setVariable [QGVAR(tag), "vic_" + str _vicCount];
                    INFO_2("Vechile (%1) is tagged as (vic_%2).", (str _x), (str _vicCount));
                };
            } forEach ALL_VEHICLES;
            INFO_1("%1 vehicles had been tagged.", _vicCount);

            if (_sessionNo > 1) then {
                private _result = 0;

                if (missionNamespace getVariable [QGVAR(preloadMarkers), true]) then {
                    INFO("---------- Loading User Map Markers ----------");
                    _result = [] call FUNCMAIN(restoreUserMarkers);

                    INFO_1("%1 user markers loaded.", _result);
                    ["session", ["session.loaded.markers", _result]] call FUNCMAIN(putSection);
                    missionNamespace setVariable [QGVAR(loadedMarkersCompleted), true, true]
                }
            };

            addMissionEventHandler [
                "EntityKilled", {
                    params ["_unit", "", "", ""];

                    [_unit] call FUNCMAIN(handleDeadEntity);
                }
            ];

            // This EH only available in dev branch 2.18
            //addMissionEventHandler [
            //    "EntityDeleted", {
            //        params ["_entity"];
            //
            //        [_entity] call FUNCMAIN(handleDeadEntity);
            //    }
            //];

            addMissionEventHandler [
                "HandleDisconnect", {
                    params ["_unit", "", "_uid", "_name"];

                    private _sessionHash = (["session"] call FUNCMAIN(getSectionAsHashmap));

                    if (_sessionHash get "session.last.save" == 0) then {
                        if (_sessionHash get "session.last.load" > 0) then {
                            [_unit, _uid, _name] call FUNCMAIN(savePlayersStates);
                        } else { INFO_1("Skip saving player (%1) since mission was not loaded.", _name); }
                    } else { INFO_1("Current session had been saved ... skip saving player (%1).", _name); }
                }
            ];

            addMissionEventHandler [
                "MPEnded", {
                    private _lastSave = (["session", ["session.last.save"]] call FUNCMAIN(getSectionAsHashmap)) get "session.last.save";

                    if (_lastSave > 0) then {
                        [] call FUNCMAIN(backupDatabase);
                    } else { INFO("There was no saves in this session ... skipping backup.") }
                }
            ];

            [QGVAR(requestPlayersInfo), FUNCMAIN(sendPlayersInfo)] call CBA_fnc_addEventHandler;
            [QGVAR(requestSessioInfo), FUNCMAIN(sendSessionInfo)] call CBA_fnc_addEventHandler;

            missionNamespace setVariable [QGVAR(enable), true, true];
            INFO("==================== NiLOC Initialisation Finished ====================");

            if (hasInterface) then {
                [
                    { missionNamespace getVariable [QGVAR(loadedMarkersCompleted), false] },
                    {
                        addMissionEventHandler [
                            "MarkerCreated", {
                                params ["_marker"];

                                ["create", _marker] call FUNCMAIN(handleUserMarker)
                            }
                        ];

                        addMissionEventHandler [
                            "MarkerDeleted", {
                                params ["_marker"];

                                ["delete", _marker] call FUNCMAIN(handleUserMarker)
                            }
                        ];

                        addMissionEventHandler [
                            "MarkerUpdated", {
                                params ["_marker"];

                                ["update", _marker] call FUNCMAIN(handleUserMarker)
                            }
                        ]
                    },
                    "",
                    20,
                    { WARNING("Timeout while waiting for saved markers to be loaded ... all marker EHs disabled.") }
                ] call CBA_fnc_waitUntilAndExecute
            }
        },
        [],
        20,
        {
            ERROR("NiLOC database failed to initialise ... disable the system.");
            missionNamespace setVariable [QGVAR(enable), false, true]
        }
    ] call CBA_fnc_waitUntilAndExecute
}
