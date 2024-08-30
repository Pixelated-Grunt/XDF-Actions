class NILOC {
    requiredAddons[] = { "cba_common" };


    class db {
        file = "niloc\db\functions";

        class dbInit {};
        class backupDatabase {};
        class deleteSection {};
        class deleteSectionKey {};
        class getDbInstance {};
        class getSectionAsHashmap {};
        class getSectionNames {};
        class putSection {};
        class updateMeta {};
    };

    class main {
        file = "niloc\main\functions";

        class main_init {
            postInit = 1;
        };
        class cacheEntity {};
        class clientLoadMission {};
        class clientSaveMission {};
        class getObjFromStr {};
        class markerToString {};
        class prepUnitData {};
        class prepVehicleData {};
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
    };

    class ui {
        file = "niloc\ui\functions";

        class guiApplyBtnClicked {};
        class guiFillInfoBox {};
        class guiFillListBox {};
        class guiOpenGui {};
        class guiYesBtnSetProfile {};
    };

    class user_menu {
        file = "niloc\user_menu\functions";

        class addACEMenu {};
        class addChildActions {};
        class checkAccessItem {};
    };
};
