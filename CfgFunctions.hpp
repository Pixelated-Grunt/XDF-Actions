class XDF {
    requiredAddons[] = {"cba_common"};

    class NiLoc {
        file = "xdf\niloc\functions";

        class dbInit {
            postInit = 1;
        };
        class getDbInstance {};
        class getObjFromStr {};
        class getSectionAsHashmap {};
        class getSectionNames {};
        class markerToString {};
        class prepUnitData {};
        class putSection {};
        class restoreMissionState {};
        class restoreUnitsStates {} ;
        class restoreUserMarkers {};
        class returnStats {};
        class saveDeadAIs {};
        class saveMissionState {};
        class savePlayersStates {};
        class saveUnitsStates {};
        class saveUserMarkers {};
        class stringToMarker {};
        class updateMeta {};
    };
};
