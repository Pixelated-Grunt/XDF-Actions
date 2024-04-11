class XDF {
    requiredAddons[] = {"cba_common"};

    class NiLoc {
        file = "xdf\niloc\functions";

        class dbInit {
            postInit = 1;
        };
        class getSection {};
        class markerToString {};
        class prepUnitData {};
        class putSection {};
        class restoreMissionData {};
        class restoreUnitData {} ;
        class restoreUnitsData {} ;
        class restoreUserMarkers {};
        class saveMissionData {};
        class saveUnitsData {};
        class saveUserMarkers {};
        class stringToMarker {};
    };
};
