#include "..\..\script_common_macros.hpp"

#define COMPONENT NiLoc
#define DEBUG_MODE_FULL 1

#include "\x\cba\addons\main\script_macros_mission.hpp"

// All AIs without players
#define ALIVEAIS allUnits select {!(_x in (call BIS_fnc_listPlayers))} select { alive _x }
#define DEADAIS allUnits select {!(_x in (call BIS_fnc_listPlayers))} select { !alive _x }
