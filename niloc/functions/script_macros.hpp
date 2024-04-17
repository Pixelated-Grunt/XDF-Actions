#include "..\..\script_common_macros.hpp"

#define COMPONENT NiLoc
#define DEBUG_MODE_FULL 1

#include "\x\cba\addons\main\script_macros_mission.hpp"

// Alive players
#define ALLPLAYERS call BIS_fnc_listPlayers select { alive _x }

// All AIs without players
#define ALIVEAIS allUnits select {!(_x in (call BIS_fnc_listPlayers))} select { alive _x }
#define DEADAIS allUnits select {!(_x in (call BIS_fnc_listPlayers))} select { !alive _x }

// Base unit stats
#define BASESTATS ["location", "loadout", "damage", "vehicle"]

// Player stats
#define PLAYERSTATS BASESTATS + ["playerName", "playerUID"]

// Unit stats
#define UNITSTATS BASESTATS + ["objStr", "formation", "behaviour"]
#define UNITSTATSEXTRA ["type", "face"]
