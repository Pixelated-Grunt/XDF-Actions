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
disableSerialization;

_mainDialog = findDisplay IDD_NILOCGUI_RSCNILOCDIALOG;

if (_type isEqualTo "onlinePlayers") then {
    private _onlinePlayers = missionNamespace getVariable [QGVAR(onlinePlayers), createHashMap];

    if (count _onlinePlayers > 0) then {
        _displayCtrl = _mainDialog displayCtrl IDC_NILOCGUI_LBONLINEPLAYERS;
        lbClear _displayCtrl;

        {
            private _idx = _displayCtrl lbAdd (_y select 1);

            // _x:uid
            _displayCtrl lbSetData [_idx, _x];
        } forEach _onlinePlayers;

        _displayCtrl lbSetCurSel 0;
    }
} else {
    private _playersHash = missionNamespace getVariable [QGVAR(savedPlayers), createHashMap];

    if (count _playersHash > 0) then {
        _displayCtrl = _mainDialog displayCtrl IDC_NILOCGUI_LBSAVEDPLAYERS;
        lbClear _displayCtrl;

        {
            private ["_uid", "_playerName", "_idx"];

            _uid = _x;
            _playerName = _y;

            _idx = _displayCtrl lbAdd _playerName;
            _displayCtrl lbSetData [_idx, _uid];
        } forEach _playersHash;

        _displayCtrl lbSetCurSel 0;
    };
}
