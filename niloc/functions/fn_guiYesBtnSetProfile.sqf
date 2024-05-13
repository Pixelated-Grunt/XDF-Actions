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

private ["_display", "_idx", "_playerId", "_savedUid"];

disableSerialization;
// Online player
_idx = lbCurSel IDC_NILOCGUI_LBONLINEPLAYERS;
_playerId = lbData [IDC_NILOCGUI_LBONLINEPLAYERS, _idx];

// Saved player
_idx = lbCurSel IDC_NILOCGUI_LBSAVEDPLAYERS;
_savedUid = lbData [IDC_NILOCGUI_LBSAVEDPLAYERS, _idx];

[_playerId, _savedUid] remoteExec [QFUNCMAIN(restorePlayerState), 2];
_display = uiNamespace getVariable QGVAR(mainDialog);
(_display displayCtrl IDC_NILOCGUI_CTRLGRPCONFIRMATION) ctrlShow false;
(_display displayCtrl IDC_NILOCGUI_BNAPPLY) ctrlEnable true;
[] call FUNCMAIN(guiFillInfoBox)
