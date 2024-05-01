#include "script_macros.hpp"
/*
 * Author: Pixelated_Grunt
 * Handles list box item selection
 *
 * Arguments:
 * Nil
 *
 * Return Value:
 * Nil
 *
 * Example:
 * [] spawn XDF_fnc_guiLeftListBoxSelect
 *
 * Public: No
**/


if !(hasInterface) exitWith {};
private ["_id", "_lbData", "_textBox", "_steamIdPrefix", "_separator"];

disableSerialization;
_id = lbCurSel IDC_NILOCGUI_LISTBOX;
_lbData = lbData [IDC_NILOCGUI_LISTBOX, _id];
_textBox = (findDisplay IDD_NILOCGUI_RSCNILOCDIALOG) displayCtrl IDC_NILOCGUI_INFOBOX;
_steamIdPrefix = "7656119";
_separator = parseText "--------------------------------------------------------------";

LOG_2("_lbData is (%1) type is (%2).", _lbData, typeName _lbData);
// Database button pressed
if (_lbData isEqualTo "session") then {
    private _sessionHash = [_lbData] call FUNCMAIN(getSectionAsHashmap);

    {
        private ["_key", "_value"];

        _key = if (_steamIdPrefix in _x) then [{"session.player"}, {_x}];
        _value = _y;
        _textBox ctrlSetStructuredText parseText format [
            "<t align='left'>%1:</t> <t align='right'>%2</t></br></br>
            <t align='left'>%3</t></br>", _key, _value, _separator
        ];
    } forEach _sessionHash;
} else {
    // Saved players button pressed
    if (_steamIdPrefix in _lbData) then {
        private _sessionHash = ["players", [_lbData]] call FUNCMAIN(getSectionAsHashmap);
        private _playerName = (_sessionHash get _lbData) select 1 select 2;

        _textBox ctrlSetStructuredText parseText format [
            "<t align='left'>Press SELECT to select this profile:</t>
            <t align='left'>%2</t>
            <t align='left'>%1</t>", _playerName, _separator
        ];
    } else {    // Online players button pressed
        private _playerName = (getUserInfo _lbData) select 4;

        _textBox ctrlSetStructuredText parseText format [
            "<t align='left'>Press SELECT to select this player:</t> <t align='right'>%1</t>
            <t align='left'>%2</t></br>", _playerName, _separator
        ];
    };
}
