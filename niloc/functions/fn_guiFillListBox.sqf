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

disableSerialization;
if (_type isEqualTo "onlinePlayers") then {
    [QGVAR(requestPlayersInfo), ["onlinePlayers", player]] call CBA_fnc_serverEvent;
    [
        { (player getVariable [QGVAR(onlinePlayers), nil]) isEqualType createHashMap },
        {
            private _onlinePlayers = player getVariable QGVAR(onlinePlayers);
            private _mainDialog = uiNamespace getVariable QGVAR(mainDialog);
            private _displayCtrl = _mainDialog displayCtrl IDC_NILOCGUI_LBONLINEPLAYERS;

            lbClear _displayCtrl;

            {
                private _idx = _displayCtrl lbAdd _x;

                // _y:id
                _displayCtrl lbSetData [_idx, _y];
            } forEach _onlinePlayers;

            _displayCtrl lbSetCurSel 0
        },
        [],
        3,
        { WARNING("UI list box timeout waiting for data.") }
    ] call CBA_fnc_waitUntilAndExecute
} else {
    [QGVAR(requestPlayersInfo), ["savedPlayers", player]] call CBA_fnc_serverEvent;
    [
        { (player getVariable [QGVAR(savedPlayers), nil]) isEqualType createHashMap },
        {
            private _playersHash = player getVariable QGVAR(savedPlayers);
            private _mainDialog = uiNamespace getVariable QGVAR(mainDialog);
            private "_displayCtrl";

            if (count _playersHash > 0) then {
                _displayCtrl = _mainDialog displayCtrl IDC_NILOCGUI_LBSAVEDPLAYERS;
                lbClear _displayCtrl;

                {
                   private _idx = _displayCtrl lbAdd _x;
                    // _y:uid
                    _displayCtrl lbSetData [_idx, _y];
                } forEach _playersHash;

                _displayCtrl lbSetCurSel 0
            }
        },
        [],
        3,
        { WARNING("UI list box timeout waiting for data.") }
    ] call CBA_fnc_waitUntilAndExecute
}
