#include "..\script_component.hpp"
/*
 * Author: Pixelated_Grunt
 * Open NiLOC main UI
 *
 * Arguments:
 * Nil
 *
 * Return Value:
 * Nil
 *
 * Example:
 * [] spawn niloc_fnc_guiOpenGui
 *
 * Public: No
**/


if !(hasInterface) exitWith {};

private "_display";

disableSerialization;
createDialog "RscNiLOCDialog";
_display = findDisplay IDD_NILOCGUI_RSCNILOCDIALOG;
uiNamespace setVariable [QGVAR(mainDialog), _display];
(_display displayCtrl IDC_NILOCGUI_CTRLGRPCONFIRMATION) ctrlShow false;
["onlinePlayers"] call FUNCMAIN(guiFillListBox);
["savedPlayers"] call FUNCMAIN(guiFillListBox);
[] call FUNCMAIN(guiFillInfoBox)
