#include "..\script_common.hpp"

#define COMPONENT MAIN
#define DEBUG_MODE_FULL 1
#include "\x\cba\addons\main\script_macros_mission.hpp"

// All players
#define ALL_PLAYERS playableUnits select {isPlayer _x}

// Check if object is a unit
#define IS_UNIT(OBJ) if (OBJ isKindOf "Man") then [{true}, {false}]

// Check if object is an actual vehicle including static weapons
#define IS_VEHICLE(OBJ) if ((OBJ isKindOf "LandVehicle") || (OBJ isKindOf "Ship") || (OBJ isKindOf "Plane") || (OBJ isKindOf "Helicopter")) then [{true}, {false}]

// All actual vehicles including static weapons
#define ALL_VEHICLES vehicles select { if (IS_VEHICLE(_x)) then [{true}, {false}] }

// Alive players
#define ALIVE_PLAYERS (playableUnits select {isPlayer _x}) select {alive _x}

// Base unit stats
#define BASE_STATS ["location", "loadout", "damage", "captive", "vehicle"]

// Player stats
#define PLAYER_STATS BASE_STATS + ["playerName", "playerUid", "rations"]

// Unit stats
#define UNIT_STATS BASE_STATS + ["objStr", "formation", "behaviour"]
#define UNIT_STATS_EXTRA ["type", "face"]

// Vehicle stats
#define VEHICLE_STATS ["objStr", "type", "side", "location", "damage", "weaponCargo", "itemCargo", "magazineCargo", "backpackCargo", "crew"]

#include "..\script_common_macros.hpp"
