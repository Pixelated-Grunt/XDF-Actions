#include "script_macros.hpp"
/*
 * Author: Pixelated_Grunt
 * Fill list box data
 *
 * Arguments:
 * 0: Type of data to get <STRING>
 *
 * Return Value:
 * Nil
 *
 * Example:
 * [] call XDF_fnc_guiFillLeftListBox
 *
 * Public: No
**/


if !(hasInterface) exitWith {};
params [["_type", "", [""]]];

private ["_displayCtrl", "_mainDialog"];

_mainDialog = findDisplay IDD_NILOCGUI_RSCNILOCDIALOG;

if (_type isEqualTo "onlinePlayers") then {
    private ["_onlinePlayers", "_playersList"];

    _displayCtrl = _mainDialog displayCtrl IDC_NILOCGUI_LBONLINEPLAYERS;
    lbClear _displayCtrl;
    _onlinePlayers = call BIS_fnc_listPlayers;
    _playersList = _onlinePlayers apply {
        private _playerInfo = [];

        _playerInfo pushBack getPlayerID _x;
        _playerInfo pushBack (getUserInfo (_playerInfo # 0) # 4);
        _playerInfo
    };

    if (count _playersList > 0) then {

        {
            private _idx = _displayCtrl lbAdd (_x select 1);

            _displayCtrl lbSetData [_idx, (_x select 0)];
        } forEach _playersList;

        _displayCtrl lbSetCurSel 0;
    }
} else {
    if (_type isEqualTo "savedPlayers") then {
        private _playersHash = ["players"] call FUNCMAIN(getSectionAsHashmap);

        _displayCtrl = _mainDialog displayCtrl IDC_NILOCGUI_LBSAVEDPLAYERS;
        lbClear _displayCtrl;

        if (count _playersHash > 0) then {

            {
                private ["_uid", "_playerName", "_idx"];

                _uid = _x;
                _playerName = _y select 1 select 2;

                _idx = _displayCtrl lbAdd _playerName;
                _displayCtrl lbSetData [_idx, _uid];
            } forEach _playersHash;

            _displayCtrl lbSetCurSel 0;
        };
    };
}
