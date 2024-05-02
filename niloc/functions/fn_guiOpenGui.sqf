#include "script_macros.hpp"
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
 * [] spawn XDF_fnc_guiOpenGui
 *
 * Public: No
**/


if !(hasInterface) exitWith {};

createDialog "RscNiLOCDialog";
((findDisplay IDD_NILOCGUI_RSCNILOCDIALOG) displayCtrl IDC_NILOCGUI_CTRLGRPCONFIRMATION) ctrlShow false;
["onlinePlayers"] call FUNCMAIN(guiFillListBox);
["savedPlayers"] call FUNCMAIN(guiFillListBox);
[] call FUNCMAIN(guiFillInfoBox)
