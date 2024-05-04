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


if (!isServer) exitWith {};
[
    { [] call FUNCMAIN(dbInit) },
    {
        INFO("==================== NiLOC Initialisation Starts ====================");

        // Keep this EH before database initiation
        addMissionEventHandler [
            "PlayerConnected", {
                params ["", "_uid", "_name", "_jip", "", "_idstr"];

                if (_name isNotEqualTo "__SERVER__") then {
                    private ["_sectionHash", "_playerObj", "_playerArray", "_playersHash"];

                    _playerObj = (getUserInfo _idstr) select 10;
                    _playerArray = [];
                    _playersHash = missionNamespace getVariable [QGVAR(onlinePlayers), createHashMap];
                    _sectionHash = ["session"] call FUNCMAIN(getSectionAsHashmap);

                    _sectionHash set ["session.player." + _uid, [_name, diag_tickTime, _jip]];
                    ["session", [_sectionHash]] call FUNCMAIN(putSection);

                    _playerArray pushBack _uid;
                    _playerArray pushBack _name;
                    _playerArray pushBack _playerObj;
                    _playersHash set [_uid, _playerArray];
                    missionNamespace setVariable [QGVAR(onlinePlayers), _playersHash, true];
                };
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
                INFO_2("Vechile (%1) is tagged as (%2).", str _x, _x getVariable QGVAR(tag));
            };
        } forEach ALL_VEHICLES;
        INFO_1("%1 vehicles had been tagged.", _vicCount);

        if (_sessionNo > 1) then {
            private _result = 0;
            private _savedPlayers = ["players"] call FUNCMAIN(getSectionAsHashmap);

            if (missionNamespace getVariable [QGVAR(preloadMarkers), true]) then {
                INFO("---------- Loading User Map Markers ----------");
                _result = [] call FUNCMAIN(restoreUserMarkers);

                INFO_1("%1 user markers loaded.", _result);
                ["session", ["session.loaded.markers", _result]] call FUNCMAIN(putSection);
                missionNamespace setVariable [QGVAR(loadedMarkers), _result, true];
            };

            _result = count _savedPlayers;
            if (_result > 0) then {
                private _playersHash = createHashMap;

                INFO("---------- Pushing Saved Players to UI Namespace ----------");
                {
                    // key:uid value:name
                    _playersHash set [_x, _y # 1 # 2];
                } forEach _savedPlayers;

                missionNamespace setVariable [QGVAR(savedPlayers), _playersHash, true];
                INFO_1("%1 saved users pushed to UI Namespace.", _result);
            };
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

                private _lastSave = (["session"] call FUNCMAIN(getSectionAsHashmap)) get "session.last.save";
                private _playersHash = missionNamespace getVariable [QGVAR(onlinePlayers), createHashMap];

                if (count _playersHash > 0) then {
                    _playersHash deleteAt _uid;
                    missionNamespace setVariable [QGVAR(onlinePlayers), _playersHash, true];
                };

                if (_lastSave == 0) then {
                    private _playerStats = (["session"] call FUNCMAIN(getSectionAsHashmap)) get "session.player." + _uid;
                    private _playedTime = diag_tickTime - (_playerStats select 1);

                    if (_playedTime > 300) then {
                        [_unit, _uid, _name] call FUNCMAIN(savePlayersStates);
                    } else { INFO_1("Player (%1) played less than 5 mins ... skipping save.", _name); }
                } else { INFO_1("Current session save record exist ... skipping player (%1) save.", _name); }
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

        missionNamespace setVariable [QGVAR(enable), true, true];
        INFO("==================== NiLOC Initialisation Finished ====================")
    },
    [],
    20,
    {
        ERROR("NiLOC database failed to initialise ... disable the system.");
        missionNamespace setVariable [QGVAR(enable), false, true]
    }
] call CBA_fnc_waitUntilAndExecute
