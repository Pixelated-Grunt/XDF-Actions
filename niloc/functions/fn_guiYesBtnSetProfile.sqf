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

private ["_idx", "_playerId", "_savedUid", "_playerObj"];

// Online player ID
_idx = lbCurSel IDC_NILOCGUI_LBONLINEPLAYERS;
_playerId = lbData [IDC_NILOCGUI_LBONLINEPLAYERS, _idx];

// Saved player UID
_idx = lbCurSel IDC_NILOCGUI_LBSAVEDPLAYERS;
_savedUid = lbData [IDC_NILOCGUI_LBSAVEDPLAYERS, _idx];

_playerObj = (getUserInfo _playerId) select 10;

if (IS_OBJECT(_playerObj)) then {
    [_playerObj, _savedUid] call FUNCMAIN(restorePlayerState);
    IDC_NILOCGUI_CTRLGRPCONFIRMATION ctrlShow false;
    IDC_NILOCGUI_BNAPPLY ctrlEnable true;
    IDC_NILOCGUI_BNCLOSE ctrlEnable true;
    [] call FUNCMAIN(guiFillInfoBox)
}
