class XDF {
    requiredAddons[] = {"cba_common"};

    class NiLoc {
        file = "xdf\niloc\functions";

        class initialise {
            postInit = 1;
        };
        class addAction {};
        class dbInit {};
        class deleteSectionKey {};
        class getDbInstance {};
        class getObjFromStr {};
        class getSectionAsHashmap {};
        class getSectionNames {};
        class handleDeadEntity {};
        class loadWorld {};
        class markerToString {};
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
        class saveMissionState {};
        class savePlayersStates {};
        class saveUnitsStates {};
        class saveUserMarkers {};
        class saveVehiclesStates {};
        class saveWorld {};
        class stringToMarker {};
        class updateMeta {};
    };
};
