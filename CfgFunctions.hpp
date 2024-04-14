class XDF {
    requiredAddons[] = {"cba_common"};

    class NiLoc {
        file = "xdf\niloc\functions";

        class dbInit {
            postInit = 1;
        };
        class getDbInstance {};
        class getObjFromStr {};
        class getSectionAsArrayOfHashmaps {};
        class getSectionAsHashmap {};
        class getSectionNames {};
        class markerToString {};
        class prepUnitData {};
        class putSection {};
        class restoreMissionData {};
        class restoreUnitData {} ;
        class restoreUnitsData {} ;
        class restoreUserMarkers {};
        class returnStats {};
        class saveMissionData {};
        class saveUnitsData {};
        class saveUserMarkers {};
        class stringToMarker {};
    };
};
