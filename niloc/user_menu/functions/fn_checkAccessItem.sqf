#include "..\script_component.hpp"
/*
 * Author: Pixelated_Grunt
 * Check if player carries certain item
 *
 * Arguments:
 * 0: Unit to check <OBJECT>
 * 1: Optional - Class name of the access item <STRING> (default: "ACE_SpraypaintRed")
 *
 * Return Value:
 * If any access items have been found <BOOL>
 *
 * Example:
 * [player, "ACE_SpraypaintRed"] call niloc_fnc_checkAccessItem
 *
 * Public: No
**/


params ["_unit", "_accessItem"];

private _hasItem = false;
// only check uniform, vest and backpack
private _uniqueItems = uniqueUnitItems [_unit, 0, 2, 2, 2, false];

if !isNil("NILOC_accessItem") then {_accessItem = NILOC_accessItem};
if (keys _uniqueItems findIf {toLower(_accessItem) in toLower(_x)} != -1) then {_hasItem = true};

_hasItem
