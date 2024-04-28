#include "script_macros.hpp"
#include "..\UI\gui_macros.hpp"
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

private ["_displayCtrl"];

_displayCtrl = (findDisplay IDD_NILOCGUI_RSCNILOCDIALOG) displayCtrl IDC_NILOCGUI_LISTBOX;
lbClear _displayCtrl;

switch (_type) do {
    case "onlinePlayers": {
        private ["_onlinePlayers", "_playersList"];

        _onlinePlayers = ALL_PLAYERS;
        _playersList = _onlinePlayers apply {
            private _playerInfo = [];

            _playerInfo pushBack (getUserInfo (getPlayerID _x) select 5);
            _playerInfo pushBack _x;
            _playerInfo
        };

        if (count _playersList > 0) then {
            {
                private _idx = _displayCtrl lbAdd (_x select 0);

                _displayCtrl lbSetData [_idx, _x select 1];
            } forEach _playersList;
        };
    };
    case "savedPlayers": {};
    case "saves": {};
    default {};
}
