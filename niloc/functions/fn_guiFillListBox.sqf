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

_mainDialog = uiNamespace getVariable QGVAR(mainDialog);

if (_type isEqualTo "onlinePlayers") then {
    [QGVAR(requestPlayersInfo), ["onlinePlayers", player]] call CBA_fnc_serverEvent;

    [
        { !isNil { player getVariable QGVAR(onlinePlayers) } },
        {
            private _onlinePlayers = player getVariable QGVAR(onlinePlayers);

            _displayCtrl = _mainDialog displayCtrl IDC_NILOCGUI_LBONLINEPLAYERS;
            lbClear _displayCtrl;

            {
                private _idx = _displayCtrl lbAdd _x;

                // _y:id
                _displayCtrl lbSetData [_idx, _y];
            } forEach _onlinePlayers;

            _displayCtrl lbSetCurSel 0
        },
        3
    ] call CBA_fnc_waitUntilAndExecute
} else {
    [QGVAR(requestPlayersInfo), ["savedPlayers", player]] call CBA_fnc_serverEvent;

    [
        { !isNil { player getVariable QGVAR(savedPlayers) } },
        {
            private _playersHash = player getVariable QGVAR(savedPlayers);

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
        3
    ] call CBA_fnc_waitUntilAndExecute;
};

player setVariable [QGVAR(_type), nil]
