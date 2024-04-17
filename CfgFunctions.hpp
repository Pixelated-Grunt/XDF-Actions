class XDF {
    requiredAddons[] = {"cba_common"};

    class NiLoc {
        file = "xdf\niloc\functions";

        class initialise {
            postInit = 1;
        };
        class dbInit {};
        class deleteSectionKey {};
        class getDbInstance {};
        class getObjFromStr {};
        class getSectionAsHashmap {};
        class handleDeadEntity {};
        class getSectionNames {};
        class markerToString {};
        class prepUnitData {};
        class putSection {};
        class restoreMissionState {};
        class restoreUnitsStates {} ;
        class restoreUserMarkers {};
        class returnStats {};
        class saveMissionState {};
        class savePlayersStates {};
        class saveUnitsStates {};
        class saveUserMarkers {};
        class stringToMarker {};
        class updateMeta {};
    };
};
