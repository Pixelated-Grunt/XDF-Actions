#include "..\..\script_common_macros.hpp"

#define COMPONENT NiLoc
#define DEBUG_MODE_FULL 1

#include "\x\cba\addons\main\script_macros_mission.hpp"

// Sections to be preserved during purge before save
#define SECTIONS_NO_PURGE ["session", "meta", "players", "units.DEAD"]

// Alive players
#define ALL_PLAYERS call BIS_fnc_listPlayers select { alive _x }

// All AIs without players
#define ALIVE_AIS allUnits select {!(_x in (call BIS_fnc_listPlayers))} select { alive _x }

// Base unit stats
#define BASE_STATS ["location", "loadout", "damage", "vehicle"]

// Player stats
#define PLAYER_STATS BASE_STATS + ["playerName", "playerUID"]

// Unit stats
#define UNIT_STATS BASE_STATS + ["objStr", "formation", "behaviour"]
#define UNIT_STATS_EXTRA ["type", "face"]
