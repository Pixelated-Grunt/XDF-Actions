#define IDD_NILOCGUI_RSCNILOCDIALOG 1800
#define IDC_NILOCGUI_LISTBOX        1801
#define IDC_NILOCGUI_INFOBOX        1802
#define IDC_NILOCGUI_TITLEBAR       1803
//#define IDC_NILOCGUI_SPLAYERSBUTTON 1804
//#define IDC_NILOCGUI_OPLAYERSBUTTON 1805
//#define IDC_NILOCGUI_SAVEINFOBUTTON 1806
//#define IDC_NILOCGUI_SELECTBUTTON   1807
//#define IDC_NILOCGUI_CLEARBUTTON    1808
//#define IDC_NILOCGUI_CONFIRMBUTTON  1809
//#define IDC_NILOCGUI_CLOSEBUTTON    1810

#define GUI_GRID_CENTER_X      ((safeZoneX + (safeZoneW - ((safeZoneW / safeZoneH) min 1.2)) / 2))
#define GUI_GRID_CENTER_Y      ((safeZoneY + (safeZoneH - (((safeZoneW / safeZoneH) min 1.2) / 1.2)) / 2))
#define GUI_GRID_CENTER_W      ((((safeZoneW / safeZoneH) min 1.2) / 40))
#define GUI_GRID_CENTER_H      (((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25))
#define GUI_GRID_CENTER_WAbs   (((safeZoneW / safeZoneH) min 1.2))
#define GUI_GRID_CENTER_HAbs   ((((safeZoneW / safeZoneH) min 1.2) / 1.2))

#define IDC_OK      1 // emulate "OK" button
#define IDC_CANCEL  2 // emulate "Cancel" button
