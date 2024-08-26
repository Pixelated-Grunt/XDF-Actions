class NILOC {
    requiredAddons[] = { "cba_common" };


    class db {
        tag = "NILOC_DB";
        file = "niloc\db\functions";
    };

    class main {
        tag = "NILOC_MAIN"
        file = "niloc\main\functions";

        //class niloc_init {
        //    postInit = 1;
        //};
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

    class ui {
        tag = "NILOC_UI";
        file = "niloc\ui\functions";
    };

    class user_menu {
        tag = "NILOC_USER_MENU";
        file = "niloc\user_menu\functions";

        class init {
            postInit = 1;
        };
        class addChildActions {};
        class checkAccessItems {};
    };
};
