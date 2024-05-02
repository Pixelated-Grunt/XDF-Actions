#include "script_macros.hpp"
/*
 * Author: Pixelated_Grunt
 * Call the confirmation dialog to apply saved to select player
 *
 * Arguments:
 * Nil
 *
 * Return Value:
 * Nil
 *
 * Example:
 * [] spawn XDF_fnc_guiApplyBtnClicked
 *
 * Public: No
**/


if !(hasInterface) exitWith {};

private ["_idx", "_playerId", "_savedUid", "_savedName", "_playerName", "_confirmBox"];

// Online player ID
_idx = lbCurSel IDC_NILOCGUI_LBONLINEPLAYERS;
_playerId = lbData [IDC_NILOCGUI_LBONLINEPLAYERS, _idx];
_playerName = getUserInfo _playerId select 4;

// Saved player UID
_idx = lbCurSel IDC_NILOCGUI_LBSAVEDPLAYERS;
_savedUid = lbData [IDC_NILOCGUI_LBSAVEDPLAYERS, _idx];
_savedName = (["players", [_savedUid]] call FUNCMAIN(getSectionAsHashmap)) # 1 # 2;

_confirmBox = (findDisplay IDD_NILOCGUI_RSCNILOCDIALOG) displayCtrl IDC_NILOCGUI_STBCONFIRMATION;
IDC_NILOCGUI_BNAPPLY ctrlEnable false;
IDC_NILOCGUI_BNCLOSE ctrlEnable false;
IDC_NILOCGUI_CTRLGRPCONFIRMATION ctrlShow true;

_confirmBox ctrlSetStructuredText parseText format [
    "<t align='left'>Really apply %1's save to %2?</t>",
    _savedName,
    _playerName
]
