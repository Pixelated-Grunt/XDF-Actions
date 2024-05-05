#include "script_macros.hpp"
/*
 * Author: Pixelated_Grunt
 * Apply save to player on confirmation button clicked
 *
 * Arguments:
 * Nil
 *
 * Return Value:
 * Nil
 *
 * Example:
 * [] spawn XDF_fnc_guiYesBtnSetProfile
 *
 * Public: No
**/


if !(hasInterface) exitWith {};

private ["_display", "_idx", "_playerUid", "_savedUid", "_playerObj", "_onlinePlayers"];

// Online player
_idx = lbCurSel IDC_NILOCGUI_LBONLINEPLAYERS;
_playerUid = lbData [IDC_NILOCGUI_LBONLINEPLAYERS, _idx];
_onlinePlayers = missionNamespace getVariable [QGVAR(onlinePlayers), createHashMap];

// Saved player
_idx = lbCurSel IDC_NILOCGUI_LBSAVEDPLAYERS;
_savedUid = lbData [IDC_NILOCGUI_LBSAVEDPLAYERS, _idx];

_playerObj = (_onlinePlayers get _playerUid) select 2;
_display = findDisplay IDD_NILOCGUI_RSCNILOCDIALOG;

if (IS_OBJECT(_playerObj)) then {
    [_playerObj, _savedUid] remoteExec [QFUNCMAIN(restorePlayerState), _playerObj];
    (_display displayCtrl IDC_NILOCGUI_CTRLGRPCONFIRMATION) ctrlShow false;
    (_display displayCtrl IDC_NILOCGUI_BNAPPLY) ctrlEnable true;
    [
        FUNCMAIN(guiFillInfoBox),
        [],
        1
    ] call CBA_fnc_waitAndExecute
}
