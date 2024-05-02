#include "BaseControls.hpp"
#include "gui_macros.hpp"
#include "..\functions\script_macros.hpp"

class RscNiLOCDialog {
    idd = IDD_NILOCGUI_RSCNILOCDIALOG;
    movingEnable = false;
    enableSimulation = 1;

    controls[]=
    {
        lbSavedPlayers,
        lbOnlinePlayers,
        tbSavedPlayers,
        tbOnlinePlayers,
        bnApply,
        bnClose,
        stbInfo,
        ctrlGrpConfirmation
    };

    class lbSavedPlayers: RscListbox
    {
        idc = IDC_NILOCGUI_LBSAVEDPLAYERS;
        x = 4.8 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
        y = 2.4 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
        w = 13 * GUI_GRID_CENTER_W;
        h = 12.5 * GUI_GRID_CENTER_H;
        colorBackground[] = { .1, .1, .1, .7 };
    };
    class lbOnlinePlayers: RscListbox
    {
        idc = IDC_NILOCGUI_LBONLINEPLAYERS;
        x = 17.9 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
        y = 2.4 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
        w = 13 * GUI_GRID_CENTER_W;
        h = 12.5 * GUI_GRID_CENTER_H;
        colorBackground[] = { .1, .1, .1, .7 };
    };
    class tbSavedPlayers: RscText
    {
        idc = IDC_NILOCGUI_TBSAVEDPLAYERS;
        text = "SAVED PLAYERS"; //--- ToDo: Localize;
        x = 4.8 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
        y = 1.2 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
        w = 13 * GUI_GRID_CENTER_W;
        h = 1.1 * GUI_GRID_CENTER_H;
        colorBackground[] = {
            "(profilenamespace getvariable ['GUI_BCG_RGB_R', 0.3843])",
            "(profilenamespace getvariable ['GUI_BCG_RGB_G', 0.7019])",
            "(profilenamespace getvariable ['GUI_BCG_RGB_B', 0.8862])",
            "(profilenamespace getvariable ['GUI_BCG_RGB_A', 0.7])"
        };
    };
    class tbOnlinePlayers: RscText
    {
        idc = IDC_NILOCGUI_LBONLINEPLAYERS;
        text = "ONLINE PLAYERS"; //--- ToDo: Localize;
        x = 17.9 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
        y = 1.2 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
        w = 13 * GUI_GRID_CENTER_W;
        h = 1.1 * GUI_GRID_CENTER_H;
        colorBackground[] = {
            "(profilenamespace getvariable ['GUI_BCG_RGB_R', 0.3843])",
            "(profilenamespace getvariable ['GUI_BCG_RGB_G', 0.7019])",
            "(profilenamespace getvariable ['GUI_BCG_RGB_B', 0.8862])",
            "(profilenamespace getvariable ['GUI_BCG_RGB_A', 0.7])"
        };
    };
    class bnApply: RscButton
    {
        idc = IDC_NILOCGUI_BNAPPLY;
        text = "APPLY"; //--- ToDo: Localize;
        x = 21.8 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
        y = 23.9 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
        w = 4.5 * GUI_GRID_CENTER_W;
        h = 1.1 * GUI_GRID_CENTER_H;
        onButtonClick = QUOTE([] call FUNCMAIN(guiApplyBtnClicked));
    };
    class bnClose: bnApply
    {
        idc = IDC_NILOCGUI_BNCLOSE;
        text = "CLOSE"; //--- ToDo: Localize;
        x = 26.4 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
        y = 23.9 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
        onButtonClick = QUOTE(closeDialog IDC_EXIT_TO_MAIN);
    };
    class stbInfo: RscStructuredText
    {
        idc = IDC_NILOCGUI_STBINFO;
        x = 4.8 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
        y = 15 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
        w = 26.1 * GUI_GRID_CENTER_W;
        h = 8.8 * GUI_GRID_CENTER_H;
        colorBackground[] = { .1, .1, .1, .7 };
    };

    // Control Group
    class ctrlGrpConfirmation: RscControlsGroup {
        idc = IDC_NILOCGUI_CTRLGRPCONFIRMATION;
        x = 5.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
        y = 3 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
        w = 26 * GUI_GRID_CENTER_W;
        h = 17 * GUI_GRID_CENTER_H;

        class Controls {
            class tbConfirmation: RscText
            {
                idc = IDC_NILOCGUI_TBCONFIRMATION;
                text = "CONFIRMATION"; //--- ToDo: Localize;
                x = 11.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
                y = 6 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
                w = 13 * GUI_GRID_CENTER_W;
                h = 1.1 * GUI_GRID_CENTER_H;
                colorBackground[] = {
                    "(profilenamespace getvariable ['GUI_BCG_RGB_R', 0.3843])",
                    "(profilenamespace getvariable ['GUI_BCG_RGB_G', 0.7019])",
                    "(profilenamespace getvariable ['GUI_BCG_RGB_B', 0.8862])",
                    "(profilenamespace getvariable ['GUI_BCG_RGB_A', 0.7])"
                };
            };
            class stbConfirmation: RscStructuredText
            {
                idc = IDC_NILOCGUI_STBCONFIRMATION;
                x = 11.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
                y = 7.2 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
                w = 16 * GUI_GRID_CENTER_W;
                h = 5 * GUI_GRID_CENTER_H;
                colorBackground[] = { .1, .1, .1, .7 };
            };
            class bnNo: RscButton
            {
                idc = IDC_NILOCGUI_BNNO;
                text = "NO"; //--- ToDo: Localize;
                x = 20.7 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
                y = 12.3 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
                w = 3.8 * GUI_GRID_CENTER_W;
                h = 1.1 * GUI_GRID_CENTER_H;
                onButtonClick = QUOTE(IDC_NILOCGUI_CTRLGRPCONFIRMATION ctrlShow false);
            };
            class bnYes: RscButton
            {
                idc = IDC_NILOCGUI_BNYES;
                text = "YES"; //--- ToDo: Localize;
                x = 16.8 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
                y = 12.3 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
                w = 3.8 * GUI_GRID_CENTER_W;
                h = 1.1 * GUI_GRID_CENTER_H;
                onButtonClick = QUOTE([] call FUNCMAIN(guiYesBtnSetProfile));
            };
        };
    };
};