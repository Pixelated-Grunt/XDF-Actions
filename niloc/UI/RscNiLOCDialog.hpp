#include "gui_macros.hpp"

class RscNiLOCDialog {
    idd = IDD_NILOCGUI_RSCNILOCDIALOG;
    movingEnable = false;
    enableSimulation = 1;

    controls[]=
    {
        MAINFRAME,
        LISTBOX,
        INFOBOX,
        HEADER,
        SPLAYERS,
        OPLAYERS,
        SAVEINO,
        SELECTBUTTON,
        CLEARBUTTON,
        CONFIRMBUTTON,
        CLOSEBUTTON
    };

    class MAINFRAME: RscFrame
    {
        idc = 1800;
        x = 5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
        y = 2.5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
        w = 29 * GUI_GRID_CENTER_W;
        h = 20.5 * GUI_GRID_CENTER_H;
    };
    class LISTBOX: RscListbox
    {
        idc = 1500;
        x = 5.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
        y = 5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
        w = 13 * GUI_GRID_CENTER_W;
        h = 16 * GUI_GRID_CENTER_H;
        colorBackground[] = { .1, .1, .1, .7 };
    };
    class INFOBOX: RscStructuredText
    {
        idc = 1100;
        x = 19 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
        y = 6.5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
        w = 14.5 * GUI_GRID_CENTER_W;
        h = 14.5 * GUI_GRID_CENTER_H;
        colorBackground[] = { .1, .1, .1, .7 };
    };
    class HEADER: RscText
    {
        idc = 1000;
        x = 5.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
        y = 3 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
        w = 28 * GUI_GRID_CENTER_W;
        h = 1.5 * GUI_GRID_CENTER_H;
        colorBackground[] = {
            "(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])",
            "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])",
            "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])",
            "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"
        };
    };
    class SPLAYERS: RscButton
    {
        idc = 1600;
        text = "S.PLAYERS"; //--- ToDo: Localize;
        x = 19 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
        y = 5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
        w = 4.5 * GUI_GRID_CENTER_W;
        h = 1 * GUI_GRID_CENTER_H;
    };
    class OPLAYERS: RscButton
    {
        idc = 1601;
        text = "O.PLAYERS"; //--- ToDo: Localize;
        x = 24 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
        y = 5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
        w = 4.5 * GUI_GRID_CENTER_W;
        h = 1 * GUI_GRID_CENTER_H;
    };
    class SAVEINO: RscButton
    {
        idc = 1602;
        text = "SAVE INFO"; //--- ToDo: Localize;
        x = 29 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
        y = 5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
        w = 4.5 * GUI_GRID_CENTER_W;
        h = 1 * GUI_GRID_CENTER_H;
    };
    class SELECTBUTTON: RscButton
    {
        idc = 1603;
        text = "SELECT"; //--- ToDo: Localize;
        x = 5.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
        y = 21.5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
        w = 4 * GUI_GRID_CENTER_W;
        h = 1 * GUI_GRID_CENTER_H;
    };
    class CLEARBUTTON: RscButton
    {
        idc = 1604;
        text = "CLEAR"; //--- ToDo: Localize;
        x = 10 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
        y = 21.5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
        w = 4 * GUI_GRID_CENTER_W;
        h = 1 * GUI_GRID_CENTER_H;
    };
    class CONFIRMBUTTON: RscButton
    {
        idc = 1605;
        text = "CONFIRM"; //--- ToDo: Localize;
        x = 14.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
        y = 21.5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
        w = 4 * GUI_GRID_CENTER_W;
        h = 1 * GUI_GRID_CENTER_H;
    };
    class CLOSEBUTTON: RscButton
    {
        //idc = 1606;
        idc = -1;
        text = "CLOSE"; //--- ToDo: Localize;
        x = 29 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
        y = 21.5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
        w = 4.5 * GUI_GRID_CENTER_W;
        h = 1 * GUI_GRID_CENTER_H;
        onButtonClick = "closeDialog 2;";
    };
};
