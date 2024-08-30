// All AIs without players
#define ALIVE_AIS allUnits select { !(_x in (call BIS_fnc_listPlayers)) } select { alive _x }
