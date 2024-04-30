#include "..\..\script_common_macros.hpp"

#define COMPONENT NILOC
#define DEBUG_MODE_FULL 1

#include "\x\cba\addons\main\script_macros_mission.hpp"
#include "..\UI\gui_macros.hpp"

// Sections to be preserved during purge before save
#define SECTIONS_NO_PURGE ["session", "meta", "players", "dead.units"]

// Check if object is a unit
#define IS_UNIT(OBJ) if (OBJ isKindOf "Man") then [{true}, {false}]

// Check if object is an actual vehicle including static weapons
#define IS_VEHICLE(OBJ) if ((OBJ isKindOf "LandVehicle") || (OBJ isKindOf "Ship") || (OBJ isKindOf "Plane") || (OBJ isKindOf "Helicopter")) then [{true}, {false}]

// All actual vehicles including static weapons
#define ALL_VEHICLES vehicles select { if (IS_VEHICLE(_x)) then [{true}, {false}] }

// Alive players
#define ALL_PLAYERS call BIS_fnc_listPlayers select { alive _x }

// All AIs without players
#define ALIVE_AIS allUnits select { !(_x in (call BIS_fnc_listPlayers)) } select { alive _x }

// Base unit stats
#define BASE_STATS ["location", "loadout", "damage", "captive", "vehicle"]

// Player stats
#define PLAYER_STATS BASE_STATS + ["playerName", "playerUID", "rations"]

// Unit stats
#define UNIT_STATS BASE_STATS + ["objStr", "formation", "behaviour"]
#define UNIT_STATS_EXTRA ["type", "face"]

// Vehicle stats
#define VEHICLE_STATS ["objStr", "type", "side", "location", "damage", "weaponCargo", "itemCargo", "magazineCargo", "backpackCargo", "crew"]
