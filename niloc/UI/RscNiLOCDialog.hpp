#include "gui_macros.hpp"

class RscNiLOCDialog {
    idd = IDD_NILOCGUI_RSCNILOCDIALOG;
    movingEnable = false;
    enableSimulation = 1;

    controls[] = {
        LeftListBox,
        RightInfoBox,
        TitleBar,
        SavePlayersButton,
        OnlinePlayersButton,
        SaveInfoButton,
        SelectButton,
        ClearButton,
        ConfirmButton,
        CloseButton
    };

    class MainFrame: RscFrame {
        idc = -1;
        x = 5 * GUI_GRID_W + GUI_GRID_X;
        y = 2.5 * GUI_GRID_H + GUI_GRID_Y;
        w = 29 * GUI_GRID_W;
        h = 20.5 * GUI_GRID_H;
        colorBackground[] = { 0, 0, 0, .7 };
    };

    class LeftListBox: RscListbox {
        idc = IDC_NILOCGUI_LISTBOX;
        x = 5.5 * GUI_GRID_W + GUI_GRID_X;
        y = 5 * GUI_GRID_H + GUI_GRID_Y;
        w = 13 * GUI_GRID_W;
        h = 15.5 * GUI_GRID_H;
        colorBackground[] = { .1, .1, .1, .9 };
    };

    class RightInfoBox: RscStructuredText {
        idc = IDC_NILOCGUI_INFOBOX;
        x = 19 * GUI_GRID_W + GUI_GRID_X;
        y = 7 * GUI_GRID_H + GUI_GRID_Y;
        w = 14.5 * GUI_GRID_W;
        h = 13.5 * GUI_GRID_H;
        colorBackground[] = { .1, .1, .1, .9 };
    };

    class TitleBar: RscText {
        idc = IDC_NILOCGUI_TITLEBAR;
        x = 5.5 * GUI_GRID_W + GUI_GRID_X;
        y = 3 * GUI_GRID_H + GUI_GRID_Y;
        w = 28 * GUI_GRID_W;
        h = 1.5 * GUI_GRID_H;
        colorBackground[] = {
            "(profilenamespace getvariable ['GUI_BCG_RGB_R', 0.3843])",
            "(profilenamespace getvariable ['GUI_BCG_RGB_G', 0.7019])",
            "(profilenamespace getvariable ['GUI_BCG_RGB_B', 0.8862])",
            "(profilenamespace getvariable ['GUI_BCG_RGB_A', 0.7])"
        };
    };

    class CloseButton: RscButtonMenu {
        idc = -1
        text = "CLOSE"; //--- ToDo: Localize;
        x = 29 * GUI_GRID_W + GUI_GRID_X;
        y = 21 * GUI_GRID_H + GUI_GRID_Y;
        w = 4.5 * GUI_GRID_W;
        h = 1.5 * GUI_GRID_H;
        onButtonClick = "closeDialog IDC_CANCEL;";
    };

    class SavePlayersButton: CloseButton {
        idc = IDC_NILOCGUI_SPLAYERSBUTTON;
        text = "S.PLAYERS"; //--- ToDo: Localize;
        x = 19 * GUI_GRID_W + GUI_GRID_X;
        y = 5 * GUI_GRID_H + GUI_GRID_Y;
        w = 4.5 * GUI_GRID_W;
        h = 1.5 * GUI_GRID_H;
    };

    class OnlinePlayersButton: CloseButton {
        idc = IDC_NILOCGUI_OPLAYERSBUTTON;
        text = "O.PLAYERS"; //--- ToDo: Localize;
        x = 24 * GUI_GRID_W + GUI_GRID_X;
        y = 5 * GUI_GRID_H + GUI_GRID_Y;
        w = 4.5 * GUI_GRID_W;
        h = 1.5 * GUI_GRID_H;
    };

    class SaveInfoButton: CloseButton {
        idc = IDC_NILOCGUI_SAVEINFOBUTTON;
        text = "SAVE INFO"; //--- ToDo: Localize;
        x = 29 * GUI_GRID_W + GUI_GRID_X;
        y = 5 * GUI_GRID_H + GUI_GRID_Y;
        w = 4.5 * GUI_GRID_W;
        h = 1.5 * GUI_GRID_H;
    };

    class SelectButton: CloseButton {
        idc = IDC_NILOCGUI_SELECTBUTTON;
        text = "SELECT"; //--- ToDo: Localize;
        x = 5.5 * GUI_GRID_W + GUI_GRID_X;
        y = 21 * GUI_GRID_H + GUI_GRID_Y;
        w = 4 * GUI_GRID_W;
        h = 1.5 * GUI_GRID_H;
    };

    class ClearButton: CloseButton {
        idc = IDC_NILOCGUI_CLEARBUTTON;
        text = "CLEAR"; //--- ToDo: Localize;
        x = 10 * GUI_GRID_W + GUI_GRID_X;
        y = 21 * GUI_GRID_H + GUI_GRID_Y;
        w = 4 * GUI_GRID_W;
        h = 1.5 * GUI_GRID_H;
    };

    class ConfirmButton: CloseButton {
        idc = IDC_NILOCGUI_CONFIRMBUTTON;
        text = "CONFIRM"; //--- ToDo: Localize;
        x = 14.5 * GUI_GRID_W + GUI_GRID_X;
        y = 21 * GUI_GRID_H + GUI_GRID_Y;
        w = 4 * GUI_GRID_W;
        h = 1.5 * GUI_GRID_H;
    };
}
