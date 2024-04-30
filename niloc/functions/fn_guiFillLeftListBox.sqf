#include "script_macros.hpp"
/*
 * Author: Pixelated_Grunt
 * Fill list box data for GUI
 *
 * Arguments:
 * 0: Type of data to get <STRING>
 *
 * Return Value:
 * Nil
 *
 * Example:
 * [] spawn XDF_fnc_guiFillLeftListBox
 *
 * Public: No
**/


if !(hasInterface) exitWith {};
params [["_type", "", [""]]];

private ["_displayCtrl", "_mainDialog", "_titleBar"];

_mainDialog = findDisplay IDD_NILOCGUI_RSCNILOCDIALOG;
_displayCtrl = (findDisplay IDD_NILOCGUI_RSCNILOCDIALOG) displayCtrl IDC_NILOCGUI_LISTBOX;
_titleBar = _mainDialog displayCtrl IDC_NILOCGUI_TITLEBAR;
lbClear _displayCtrl;

if (_type isEqualTo "onlinePlayers") then {
    private ["_onlinePlayers", "_playersList"];

    _titleBar ctrlSetStructuredText parseText "
        <t align='left'>XDF NiLOC</t>
        <t align='right'>ONLINE PLAYERS LIST</t>";

    _onlinePlayers = ALL_PLAYERS;
    _playersList = _onlinePlayers apply {
        private _playerInfo = [];

        _playerInfo pushBack getPlayerID _x;
        _playerInfo pushBack (getUserInfo (_playerInfo # 0) # 5);
        _playerInfo
    };

    if (count _playersList > 0) then {
        {
            private _idx = _displayCtrl lbAdd (_x select 1);

            _displayCtrl lbSetData [_idx, str (_x select 0)];
        } forEach _playersList;
    };
} else {
    if (_type isEqualTo "savedPlayers") then {
        private _playersHash = ["players"] call FUNCMAIN(getSectionAsHashmap);

        _titleBar ctrlSetStructuredText parseText "
            <t align='left'>XDF NiLOC</t>
            <t align='right'>SAVED PLAYERS LIST</t>";

        {
            private ["_uid", "_playerName", "_idx"];

            _uid = x;
            _playerName = _y select 2;

            _idx = _displayCtrl lbAdd _playerName;
            _displayCtrl lbSetData [_idx, _uid];
        } forEach _playersHash;
    } else {    // Database button
        private _iniDBi = [] call FUNCMAIN(getDbInstance);
        private _dbName = "getDbName" call _iniDBi;
        private _idx = _displayCtrl lbAdd _dbName;

        _titleBar ctrlSetStructuredText parseText "
            <t align='left'>XDF NiLOC</t>
            <t align='right'>SAVED SESSION INFO</t>";

        _displayCtrl lbSetData [_idx, "session"];
    };
}
