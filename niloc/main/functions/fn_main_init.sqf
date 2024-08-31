#include "..\script_component.hpp"
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
 * [] call niloc_fnc_main_init
 *
 * Public: No
**/


if (isServer) then {
    private "_ehId";
    private _ehHash = createHashMap;

    [
        { [] call FUNCMAIN(dbInit) },
        {
            INFO("==================== NiLOC Initialisation Starts ====================");

            // Keep this EH before database initiation
            _ehId = addMissionEventHandler [
                "PlayerConnected", {
                    params ["", "_uid", "_name", "_jip", "", "_idstr"];

                    if (_name isNotEqualTo "__SERVER__") then {
                        private _sectionHash = ["session"] call FUNCMAIN(getSectionAsHashmap);

                        _sectionHash set ["session.player." + _uid, [_name, diag_tickTime, _jip, _idstr]];
                        ["session", [_sectionHash]] call FUNCMAIN(putSection)
                    }
                }
            ];
            _ehHash set [_ehId, ["PlayerConnected", "bis"]];

            INFO("---------- Setting Up Database ----------");
            private _sessionHash = ["session"] call FUNCMAIN(getSectionAsHashmap);
            private _sessionNo = _sessionHash get "session.number";
            private _vicCount = 0;

            missionNamespace setVariable[QGVAR(saveCount), _sessionHash get "session.save.count", true];
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

                if (missionNamespace getVariable [QGVARMAIN(preloadMarkers), true]) then {
                    INFO("---------- Loading User Map Markers ----------");
                    _result = [] call FUNCMAIN(restoreUserMarkers);

                    INFO_1("%1 user markers loaded.", _result);
                    ["session", ["session.loaded.markers", _result]] call FUNCMAIN(putSection);
                }
            };

            _ehId = addMissionEventHandler [
                "EntityKilled", {
                    params ["_unit", "", "", ""];

                    ["EntityKilled", [_unit]] call FUNCMAIN(cacheEntity);
                }
            ];
            _ehHash set [_ehId, ["EntityKilled", "bis"]];

            // This EH only available in dev branch 2.18
            //addMissionEventHandler [
            //    "EntityDeleted", {
            //        params ["_entity"];
            //
            //        [_entity] call FUNCMAIN(handleDeadEntity);
            //    }
            //];

            _ehId = addMissionEventHandler [
                "HandleDisconnect", {
                    params ["_unit", "", "_uid", "_name"];

                    private _sessionHash = (["session"] call FUNCMAIN(getSectionAsHashmap));

                    if ((_sessionHash get "session.last.load" > 0) || (_sessionHash get "session.number" == 1)) then {
                        ["HandleDisconnect", [_unit, _uid, _name]] call FUNCMAIN(cacheEntity)
                    } else { INFO_1("Skip saving disconnected player (%1) since mission was not loaded.", _name); }
                }
            ];
            _ehHash set [_ehId, ["HandleDisconnect", "bis"]];

            _ehId = addMissionEventHandler [
                "MPEnded", {
                    private _lastSave = (["session", ["session.last.save"]] call FUNCMAIN(getSectionAsHashmap)) get "session.last.save";

                    if (_lastSave > 0) then {
                        [] call FUNCMAIN(backupDatabase);
                    } else { INFO("There was no saves in this session ... skipping backup.") }
                }
            ];
            _ehHash set [_ehId, ["MPEnded", "bis"]];

            _ehId = ["SendPlayersInfo", FUNCMAIN(sendPlayersInfo)] call CBA_fnc_addEventHandler;
            _ehHash set [_ehId, ["SendPlayersInfo", "cba"]];

            _ehId = ["SendSessionInfo", FUNCMAIN(sendSessionInfo)] call CBA_fnc_addEventHandler;
            _ehHash set [_ehId, ["SendSessionInfo", "cba"]];

            _ehId = ["SaveIncomingData", FUNCMAIN(saveIncomingData)] call CBA_fnc_addEventHandler;
            _ehHash set [_ehId, ["SaveIncomingData", "cba"]];

            _ehId = ["ServerSaveMission", FUNCMAIN(serverSaveMission)] call CBA_fnc_addEventHandler;
            _ehHash set [_ehId, ["ServerSaveMission", "cba"]];

            _ehId = ["ServerLoadMission", FUNCMAIN(serverLoadMission)] call CBA_fnc_addEventHandler;
            _ehHash set [_ehId, ["ServerLoadMission", "cba"]];

            missionNamespace setVariable [QGVARMAIN(enable), true, true];

            INFO("==================== NiLOC Initialisation Finished ====================");
        },
        [],
        20,
        {
            {
                if (_y # 1 isEqualTo "bis") then {
                    removeMissionEventHandler [_y # 0, _x]
                } else {
                    [_y # 0, _x] call CBA_fnc_removeEventHandler
                }
            } forEach _ehHash;
            missionNamespace setVariable [QGVARMAIN(enable), false, true];

            ERROR("Timeout waiting for database to initialise ... NiLOC disabled.")
        }
    ] call CBA_fnc_waitUntilAndExecute
};

if hasInterface then {
    [
        {missionNamespace getVariable [QGVARMAIN(enable), false]},
        {[player] call FUNCMAIN(addACEMenu)},
        [],
        20,
        {INFO("NiLOC is not enabled. Disable ACE menu for it.")}
    ] call CBA_fnc_waitUntilAndExecute
}
