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
params ["_infoBox", "_sessionHash", "_separator", "_iniDBi", "_sessionStart", "_sessionStartUtc", "_fnc_timeToStr"];

_iniDBi = [] call FUNCMAIN(getDbInstance);
_infoBox = (findDisplay IDD_NILOCGUI_RSCNILOCDIALOG) displayCtrl IDC_NILOCGUI_STBINFO;
_sessionHash = ["session"] call FUNCMAIN(getSectionAsHashmap);
_separator = "<br />----------------------------------------<br />";
_sessionStart = _sessionHash get "session.start";
_sessionStartUtc = _sessionHash get "session.start.utc";

_fnc_timeToStr = {
    params [["_timeArray", [], [[]]]];

    private _timeStr = format ["%1/%2/%3 %4:%5:%6",
        _timeArray select 0,
        _timeArray select 1,
        _timeArray select 2,
        _timeArray select 3,
        _timeArray select 4,
        _timeArray select 5,
        _timeArray select 6,
    ];
    _timeStr
};

_infoBox ctrlSetStructuredText parseText format [
    "<t align='left'>NiLOC Session Info:</t>
    <t align='left'>%9</t>
    <t align='left'>Database:</t> <t align='right'>%1</t>
    <t align='left'>No. of Session:</t> <t align='right'>%2</t>
    <t align='left'>Session Start:</t> <t align='right'>%3</t>
    <t align='left'>Session Start (UTC):</t> <t align='right'>%4</t>
    <t align='left'>Session Last Save:</t> <t align='right'>%5</t>
    <t align='left'>Session Last Load:</t> <t align='right'>%6</t>
    <t align='left'>Session Markers Loaded:</t> <t align='right'%7</t>
    <t align='left'>Session Profiles Loaded:</t>
    <t align='left'>%8</t><br />",
    _separator,
    "getDbName" call _iniDBi,
    _sessionHash get "session.number",
    _sessionHash get "session.start" call _fnc_timeToStr,
    _sessionHash get "session.start.utc" call _fnc_timeToStr,
    _sessionHash get "session.last.save",
    _sessionHash get "session.last.load",
    _sessionHash get "session.loaded.markers",
    _sessionHash get "session.loaded.profiles"
]
