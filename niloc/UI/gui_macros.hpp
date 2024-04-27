#define IDC_NILOCGUI_MAINFRAME      1801
#define IDC_NILOCGUI_LISTBOX        1802
#define IDC_NILOCGUI_INFOBOX        1803
#define IDC_NILOCGUI_TITLEBAR       1804
#define IDC_NILOCGUI_SPLAYERSBUTTON 1805
#define IDC_NILOCGUI_OPLAYERSBUTTON 1806
#define IDC_NILOCGUI_SAVEINFOBUTTON 1807
#define IDC_NILOCGUI_SELECTBUTTON   1808
#define IDC_NILOCGUI_CLEARBUTTON    1809
#define IDC_NILOCGUI_CONFIRMBUTTON  1810
#define IDC_NILOCGUI_CLOSEBUTTON    1811

#define GUI_GRID_X      ((safeZoneX + (safeZoneW - ((safeZoneW / safeZoneH) min 1.2)) / 2))
#define GUI_GRID_Y      ((safeZoneY + (safeZoneH - (((safeZoneW / safeZoneH) min 1.2) / 1.2)) / 2))
#define GUI_GRID_W      ((((safeZoneW / safeZoneH) min 1.2) / 40))
#define GUI_GRID_H      (((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25))
#define GUI_GRID_WAbs   (((safeZoneW / safeZoneH) min 1.2))
#define GUI_GRID_HAbs   ((((safeZoneW / safeZoneH) min 1.2) / 1.2))
