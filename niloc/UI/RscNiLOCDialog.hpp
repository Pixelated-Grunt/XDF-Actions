#include "gui_macros.hpp"

class RscNiLOCDialog {
    idd = 1800;
    movingEnable = false;

    controls[] = {
        MainFrame,
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
        idc = IDC_NILOCGUI_MAINFRAME;
        x = 5 * GUI_GRID_W + GUI_GRID_X;
        y = 2.5 * GUI_GRID_H + GUI_GRID_Y;
        w = 29 * GUI_GRID_W;
        h = 20.5 * GUI_GRID_H;
    };

    class LeftListBox: RscListbox {
        idc = IDC_NILOCGUI_LISTBOX;
        x = 5.5 * GUI_GRID_W + GUI_GRID_X;
        y = 5 * GUI_GRID_H + GUI_GRID_Y;
        w = 13 * GUI_GRID_W;
        h = 15.5 * GUI_GRID_H;
    };

    class RightInfoBox: RscStructuredText {
        idc = IDC_NILOCGUI_INFOBOX;
        x = 19 * GUI_GRID_W + GUI_GRID_X;
        y = 7 * GUI_GRID_H + GUI_GRID_Y;
        w = 14.5 * GUI_GRID_W;
        h = 13.5 * GUI_GRID_H;
    };

    class TitleBar: RscText {
        idc = IDC_NILOCGUI_TITLEBAR;
        x = 5.5 * GUI_GRID_W + GUI_GRID_X;
        y = 3 * GUI_GRID_H + GUI_GRID_Y;
        w = 28 * GUI_GRID_W;
        h = 1.5 * GUI_GRID_H;
    };

    class SavePlayersButton: RscButton {
        idc = IDC_NILOCGUI_SPLAYERSBUTTON;
        text = "S.PLAYERS"; //--- ToDo: Localize;
        x = 19 * GUI_GRID_W + GUI_GRID_X;
        y = 5 * GUI_GRID_H + GUI_GRID_Y;
        w = 4.5 * GUI_GRID_W;
        h = 1.5 * GUI_GRID_H;
    };

    class OnlinePlayersButton: RscButton {
        idc = IDC_NILOCGUI_OPLAYERSBUTTON;
        text = "O.PLAYERS"; //--- ToDo: Localize;
        x = 24 * GUI_GRID_W + GUI_GRID_X;
        y = 5 * GUI_GRID_H + GUI_GRID_Y;
        w = 4.5 * GUI_GRID_W;
        h = 1.5 * GUI_GRID_H;
    };

    class SaveInfoButton: RscButton {
        idc = IDC_NILOCGUI_SAVEINFOBUTTON;
        text = "SAVE INFO"; //--- ToDo: Localize;
        x = 29 * GUI_GRID_W + GUI_GRID_X;
        y = 5 * GUI_GRID_H + GUI_GRID_Y;
        w = 4.5 * GUI_GRID_W;
        h = 1.5 * GUI_GRID_H;
    };

    class SelectButton: RscButton {
        idc = IDC_NILOCGUI_SELECTBUTTON;
        text = "SELECT"; //--- ToDo: Localize;
        x = 5.5 * GUI_GRID_W + GUI_GRID_X;
        y = 21 * GUI_GRID_H + GUI_GRID_Y;
        w = 4 * GUI_GRID_W;
        h = 1.5 * GUI_GRID_H;
    };

    class ClearButton: RscButton {
        idc = IDC_NILOCGUI_CLEARBUTTON;
        text = "CLEAR"; //--- ToDo: Localize;
        x = 10 * GUI_GRID_W + GUI_GRID_X;
        y = 21 * GUI_GRID_H + GUI_GRID_Y;
        w = 4 * GUI_GRID_W;
        h = 1.5 * GUI_GRID_H;
    };

    class ConfirmButton: RscButton {
        idc = IDC_NILOCGUI_CONFIRMBUTTON;
        text = "CONFIRM"; //--- ToDo: Localize;
        x = 14.5 * GUI_GRID_W + GUI_GRID_X;
        y = 21 * GUI_GRID_H + GUI_GRID_Y;
        w = 4 * GUI_GRID_W;
        h = 1.5 * GUI_GRID_H;
    };

    class CloseButton: RscButton {
        idc = IDC_NILOCGUI_CLOSEBUTTON;
        text = "CLOSE"; //--- ToDo: Localize;
        x = 29 * GUI_GRID_W + GUI_GRID_X;
        y = 21 * GUI_GRID_H + GUI_GRID_Y;
        w = 4.5 * GUI_GRID_W;
        h = 1.5 * GUI_GRID_H;
    };
}
