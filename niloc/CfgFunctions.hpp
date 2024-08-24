class XDF_NILOC {
    requiredAddons[] = { "cba_common" };

    class actions {
        tag = "XDF_NILOC_ACTIONS";
        file = "niloc\actions\functions";

        class common_init {
            postInit = 1;
        };
        class checkAccessItems {};
    };

    class db {
        tag = "XDF_NILOC_DB";
        file = "niloc\db\functions";
    };

    class gui {
        tag = "XDF_NILOC_UI";
        file = "niloc\ui\functions";
    };

    class main {
        tag = "XDF_NILOC_MAIN"
        file = "niloc\main\functions";

        class niloc_init {
            postInit = 1;
        };
        class backupDatabase {};
        class cacheEntity {};
        class clientLoadMission {};
        class clientSaveMission {};
        class dbInit {};
        class deleteSection {};
        class deleteSectionKey {};
        class getDbInstance {};
        class getObjFromStr {};
        class getSectionAsHashmap {};
        class getSectionNames {};
        class guiApplyBtnClicked {};
        class guiFillInfoBox {};
        class guiFillListBox {};
        class guiOpenGui {};
        class guiYesBtnSetProfile {};
        class markerToString {};
        class nilocChildActions {};
        class prepUnitData {};
        class prepVehicleData {};
        class putSection {};
        class removeDeadEntities {};
        class restoreMissionState {};
        class restorePlayerState {};
        class restorePlayersStates {};
        class restoreUnitsStates {} ;
        class restoreUserMarkers {};
        class restoreVehiclesStates {};
        class returnStats {};
        class saveIncomingData {};
        class saveMissionState {};
        class savePlayersStates {};
        class saveUnitsStates {};
        class saveVehiclesStates {};
        class sendPlayersInfo {};
        class sendSessionInfo {};
        class serverLoadMission {};
        class serverSaveMission {};
        class stringToMarker {};
        class updateMeta {};
    };
};
