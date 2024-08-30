#include "..\script_component.hpp"
/*
 * Author: Pixelated_Grunt
 * Fill list box data
 *
 * Arguments:
 * 0: Type of data to fill <STRING>
 *
 * Return Value:
 * Nil
 *
 * Example:
 * [] call niloc_fnc_guiFillListBox
 *
 * Public: No
**/


if !(hasInterface) exitWith {};
params [["_type", "", [""]]];

disableSerialization;
//NOTE: if set onlinePlayers to nil, the wait result will timeout
//player setVariable [QEGVAR(main,onlinePlayers), nil];
//player setVariable [QEGVAR(main,savedPlayers), nil];

if (_type isEqualTo "onlinePlayers") then {
    ["SendPlayersInfo", ["onlinePlayers", player]] call CBA_fnc_serverEvent;
    [
        { (player getVariable [QEGVAR(main,onlinePlayers), nil]) isEqualType createHashMap },
        {
            private _onlinePlayers = player getVariable QEGVAR(main,onlinePlayers);
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
        { WARNING("UI online players list box timeout waiting for data.") }
    ] call CBA_fnc_waitUntilAndExecute
} else {
    ["SendPlayersInfo", ["savedPlayers", player]] call CBA_fnc_serverEvent;
    [
        { (player getVariable [QEGVAR(main,savedPlayers), nil]) isEqualType createHashMap },
        {
            private _playersHash = player getVariable QEGVAR(main,savedPlayers);
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
        { WARNING("UI saved players list box timeout waiting for data.") }
    ] call CBA_fnc_waitUntilAndExecute
}
