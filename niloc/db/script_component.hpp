#include "..\script_common.hpp"

#define COMPONENT DB
#define DEBUG_MODE_FULL 1

#include "\x\cba\addons\main\script_macros_mission.hpp"

// Sections to be preserved during purge before save
#define SECTIONS_NO_PURGE ["session", "meta", "players", "dead.units"]

#include "..\script_common_macros.hpp"
