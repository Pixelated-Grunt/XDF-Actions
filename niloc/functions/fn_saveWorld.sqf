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

private ["_lastSave", "_saveCount", "_minsFromLastSave", "_count", "_markersHash", "_updatedMarkers"];

_count = 0;
_lastSave = (["session", ["session.last.save"]] call FUNCMAIN(getSectionAsHashmap)) get "session.last.save";
_saveCount = (["session", ["session.save.count"]] call FUNCMAIN(getSectionAsHashmap)) get "session.save.count";
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
_updatedMarkers = localNamespace getVariable [QGVAR(updatedMarkers), createHashMap];
_count = count _updatedMarkers;
if (_count > 0) then {
    {
        ["markers", [_x, _y]] call FUNCMAIN(putSection);
    } forEach _updatedMarkers;
    INFO_1("(%1) updated markers saved.", _count)
};

_markersHash = ["markers"] call FUNCMAIN(getSectionAsHashmap);
_count = count _markersHash;
if (_count > 0) then {
    _count = 0;

    {
        private _mrkName = _x;
        private _oldMarkerStr = _y;
        private _markerStrArray = splitString [_oldMarkerStr, "~"];

        ["markers", [_mrkName]] call FUNCMAIN(deleteSectionKey);

        _mrkName regexReplace ["#[0-9]+\/[0-9]+/gi", "#0\/" + str _count];
        _markerStrArray set [0, _mrkName];
        LOG_1("New marker string from save world: (%1).", "~" + (_markerStrArray joinString "~"));

        ["markers" [_mrkName, "~" + (_markerStrArray joinString "~")]] call FUNCMAIN(putSection);
        INC(_count);
    } forEach _markersHash;
    INFO_1("(%1) total user markers saved.", _count)
};

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
["session", ["session.save.count", _saveCount + 1]] call FUNCMAIN(putSection);
missionNamespace setVariable [QGVAR(saveCount), _saveCount + 1, true];
[_player, [QGVAR(saveStatusColour), HEX_GREEN]] remoteExec ["setVariable", _player];
INFO("==================== Save Mission Finished ====================");

true
