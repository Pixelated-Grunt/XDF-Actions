#include "script_macros.hpp"
/*
 * Author: Pixelated_Grunt
 * Fill info box data
 *
 * Arguments:
 * Nil
 *
 * Return Value:
 * Nil
 *
 * Example:
 * [] call XDF_fnc_guiFillInfoBox
 *
 * Public: No
**/


if !(hasInterface) exitWith {};

private ["_separator", "_infoBox"];

disableSerialization;
[QGVAR(requestSessionInfo), [player]] call CBA_fnc_serverEvent;
[
    { (player getVariable [QGVAR(sessionInfo), nil]) isEqualType createHashMap },
    {
        private ["_sessionHash", "_fnc_timeToStr", "_ibPos", "_textH", "_newIbH"];

        _sessionHash = player getVariable QGVAR(sessionInfo);
        _fnc_timeToStr = {
            params [["_timeArray", [], [[]]]];

            private _newArray = _timeArray apply { if (count str _x == 1) then [{"0"+str _x}, {_x}]};
            private _timeStr = format ["%1/%2/%3 %4:%5:%6",
                _newArray select 0,
                _newArray select 1,
                _newArray select 2,
                _newArray select 3,
                _newArray select 4,
                _newArray select 5,
                _newArray select 6
            ];
            _timeStr
        };

        _infoBox = (uiNamespace getVariable QGVAR(mainDialog)) displayCtrl IDC_NILOCGUI_STBINFO;
        _ibPos = ctrlPosition _infoBox;

        _separator = "---------------------------------------------------------------------------------" +
            "----------------------------------------";

        _infoBox ctrlSetStructuredText parseText format [
        "<t size='0.3'>&#160;</t><br/><t align='center' size='0.8' font='LCD14'>-= NiLOC CURRENT SESSION INFO =-</t><br />
        <t align='left' size='0.7'>%10</t><br />
        <t align='left' font='PuristaMedium' size='0.7'>Database:</t> <t align='right' font='PuristaLight' color='#ffff00' size='0.7'>%1</t><br />
        <t align='left' font='PuristaMedium' size='0.7'>Session No. Since Last Save:</t> <t align='right' font='PuristaLight' size='0.7'>%2</t><br />
        <t align='left' font='PuristaMedium' size='0.7'>Session Start:</t> <t align='right' font='PuristaLight' size='0.7'>%3</t><br />
        <t align='left' font='PuristaMedium' size='0.7'>Session Start (UTC):</t> <t align='right' font='PuristaLight' size='0.7'>%4</t><br />
        <t align='left' font='PuristaMedium' size='0.7'>Session Save Count:</t> <t align='right' font='PuristaLight' size='0.7'>%5</t><br />
        <t align='left' font='PuristaMedium' size='0.7'>Session Last Load:</t> <t align='right' font='PuristaLight' size='0.7'>%6</t><br />
        <t align='left' font='PuristaMedium' size='0.7'>Session Markers Loaded:</t> <t align='right' font='PuristaLight' size='0.7'>%7</t><br />
        <t align='left' font='PuristaMedium' size='0.7'>Session Profiles Loaded:</t> <t align='right' font='PuristaLight' size='0.7'>%8</t><br />
        <t align='left' font='PuristaLight' size='0.7'>%9</t><br />",
        _sessionHash get "dbName",
        _sessionHash get "sessionNumber",
        [(_sessionHash get "sessionStart")] call _fnc_timeToStr,
        [(_sessionHash get "sessionStartUtc")] call _fnc_timeToStr,
        _sessionHash get "saveCount",
        _sessionHash get "lastLoad",
        _sessionHash get "loadedMarkers",
        count (_sessionHash get "loadedPlayers"),
        _sessionHash get "loadedPlayers",
        _separator];

        // adjust info box height to cater for different screen resolutions
        _textH = ctrlTextHeight _infoBox;
        _newIbH = _textH - (_ibPos # 3);
        _infoBox ctrlSetPositionH _newIbH;
        _infoBox ctrlCommit 0
    },
    [],
    3,
    { WARNING("UI info box timeout waiting for data.") }
] call CBA_fnc_waitUntilAndExecute
