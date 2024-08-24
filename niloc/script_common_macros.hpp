// All players
#define ALL_PLAYERS playableUnits select {isPlayer _x}

// Sections to be preserved during purge before save
#define SECTIONS_NO_PURGE ["session", "meta", "players", "dead.units"]

// Check if object is a unit
#define IS_UNIT(OBJ) if (OBJ isKindOf "Man") then [{true}, {false}]

// Check if object is an actual vehicle including static weapons
#define IS_VEHICLE(OBJ) if ((OBJ isKindOf "LandVehicle") || (OBJ isKindOf "Ship") || (OBJ isKindOf "Plane") || (OBJ isKindOf "Helicopter")) then [{true}, {false}]

// All actual vehicles including static weapons
#define ALL_VEHICLES vehicles select { if (IS_VEHICLE(_x)) then [{true}, {false}] }

// Alive players
#define ALIVE_PLAYERS (playableUnits select {isPlayer _x}) select {alive _x}

// All AIs without players
#define ALIVE_AIS allUnits select { !(_x in (call BIS_fnc_listPlayers)) } select { alive _x }

// Base unit stats
#define BASE_STATS ["location", "loadout", "damage", "captive", "vehicle"]

// Player stats
#define PLAYER_STATS BASE_STATS + ["playerName", "playerUid", "rations"]

// Unit stats
#define UNIT_STATS BASE_STATS + ["objStr", "formation", "behaviour"]
#define UNIT_STATS_EXTRA ["type", "face"]

// Vehicle stats
#define VEHICLE_STATS ["objStr", "type", "side", "location", "damage", "weaponCargo", "itemCargo", "magazineCargo", "backpackCargo", "crew"]
