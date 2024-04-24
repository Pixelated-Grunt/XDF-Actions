class XDF {
    requiredAddons[] = { "cba_common" };

    class common {
        file = "xdf\common\functions";

        class common_init {
            postInit = 1;
        };
        class checkAccessItems {};
    };

    class NiLOC {
        file = "xdf\niloc\functions";

        class niloc_init {
            postInit = 1;
        };
        class dbInit {};
        class deleteSectionKey {};
        class getDbInstance {};
        class getObjFromStr {};
        class getSectionAsHashmap {};
        class getSectionNames {};
        class handleDeadEntity {};
        class loadWorld {};
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
        class saveMissionState {};
        class savePlayersStates {};
        class saveUnitsStates {};
        class saveUserMarkers {};
        class saveVehiclesStates {};
        class saveWorld {};
        class stringToMarker {};
        class updateMeta {};
    };

    class ERV {
        file = "xdf\erv\functions";

        class setERV {};
    };
};
