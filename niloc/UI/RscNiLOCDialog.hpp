#include "BaseControls.hpp"
#include "gui_macros.hpp"
#include "..\functions\script_macros.hpp"

class RscNiLOCDialog {
    idd = IDD_NILOCGUI_RSCNILOCDIALOG;
    movingEnable = false;
    enableSimulation = 1;

    controls[]=
    {
        BackgroundFrame,
        LeftListBox,
        RightInfoBox,
        TitleTextBox,
        SavedPlayersButton,
        OnlinePlayersButton,
        DatabaseButton,
        SelectButton,
        ClearButton,
        ConfirmButton,
        CloseButton
    };

    class BackgroundFrame: RscFrame
    {
        x = 5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
        y = 2.5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
        w = 29 * GUI_GRID_CENTER_W;
        h = 20.5 * GUI_GRID_CENTER_H;
    };
    class LeftListBox: RscListbox
    {
        idc = IDC_NILOCGUI_LISTBOX;
        x = 5.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
        y = 4.8 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
        w = 13 * GUI_GRID_CENTER_W;
        h = 16.2 * GUI_GRID_CENTER_H;
        colorBackground[] = { .1, .1, .1, .7 };
        onLBSelChanged = QUOTE([] spawn FUNCMAIN(guiLeftListBoxSelect));
    };
    class RightInfoBox: RscStructuredText
    {
        idc = IDC_NILOCGUI_INFOBOX;
        x = 19 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
        y = 6.5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
        w = 14.5 * GUI_GRID_CENTER_W;
        h = 14.5 * GUI_GRID_CENTER_H;
        colorBackground[] = { .1, .1, .1, .7 };
    };
    class TitleTextBox: RscText
    {
        idc = IDC_NILOCGUI_TITLEBAR;
        x = 5.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
        y = 3 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
        w = 28 * GUI_GRID_CENTER_W;
        h = 1.5 * GUI_GRID_CENTER_H;
        colorBackground[] = {
            "(profilenamespace getvariable ['GUI_BCG_RGB_R', 0.3843])",
            "(profilenamespace getvariable ['GUI_BCG_RGB_G', 0.7019])",
            "(profilenamespace getvariable ['GUI_BCG_RGB_B', 0.8862])",
            "(profilenamespace getvariable ['GUI_BCG_RGB_A', 0.7])"
        };
    };
    class CloseButton: RscButton
    {
        text = "CLOSE"; //--- ToDo: Localize;
        x = 29 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
        y = 21.2 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
        w = 4.5 * GUI_GRID_CENTER_W;
        h = 1.5 * GUI_GRID_CENTER_H;
        onButtonClick = QUOTE(closeDialog 2);
    };
    class OnlinePlayersButton: CloseButton
    {
        text = "O.PLAYERS"; //--- ToDo: Localize;
        x = 19 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
        y = 4.8 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
        w = 4.5 * GUI_GRID_CENTER_W;
        onButtonClick = QUOTE(['onlinePlayers'] call FUNCMAIN(guiFillLeftListBox));
    };
    class SavedPlayersButton: CloseButton
    {
        text = "S.PLAYERS"; //--- ToDo: Localize;
        x = 24 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
        y = 4.8 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
        w = 4.5 * GUI_GRID_CENTER_W;
        onButtonClick = QUOTE(['savedPlayers'] call FUNCMAIN(guiFillLeftListBox));
    };
    class DatabaseButton: CloseButton
    {
        text = "DATABASE"; //--- ToDo: Localize;
        x = 29 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
        y = 4.8 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
        w = 4.5 * GUI_GRID_CENTER_W;
        onButtonClick = QUOTE(['database'] call FUNCMAIN(guiFillLeftListBox));
    };
    class SelectButton: CloseButton
    {
        text = "SELECT"; //--- ToDo: Localize;
        x = 5.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
        y = 21.2 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
        w = 4 * GUI_GRID_CENTER_W;
    };
    class ClearButton: CloseButton
    {
        text = "CLEAR SEL."; //--- ToDo: Localize;
        x = 10 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
        y = 21.2 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
        w = 4 * GUI_GRID_CENTER_W;
    };
    class ConfirmButton: CloseButton
    {
        text = "CONFIRM"; //--- ToDo: Localize;
        x = 14.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
        y = 21.2 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
        w = 4 * GUI_GRID_CENTER_W;
    };
};
