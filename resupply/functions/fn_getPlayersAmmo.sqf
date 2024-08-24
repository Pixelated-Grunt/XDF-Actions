#include "script_macros.hpp"
/*
 * Author: Pixelated_Grunt
 * Get a list of ammo of all players
 *
 * Arguments:
 * Nil
 *
 * Return Value:
 * List of players ammo; throwables and explosives <HASHMAP>
 *
 * Example:
 * [] call XDF_fnc_getPlayersAmmo
 *
 * Public: No
**/


private ["_playersAmmo", "_magazines", "_throwables", "_explosives", "_fnc_isExplosive"];

_fnc_isExplosive = {
    params ["_item"];

    private "_isExplosive";

    _isExplosive = count ("
        _item in getArray (_x >> 'magazines')
    " configClasses (configFile >> "CfgWeapons" >> "Put")) > 0;

    _isExplosive
};

_playersAmmo = createHashMap;
_magazines = [];

{
    private _helperArray = [];

    _helperArray = magazines _x;
    _helperArray pushBackUnique currentMagazine _x;
    _magazines insert [-1, _helperArray, true]
} forEach ALL_PLAYERS;

_throwables = _magazines select { _x call BIS_fnc_isThrowable };
_magazines = _magazines - _throwables;
_explosives = _magazines select { _x call _fnc_isExplosive };
_magazines = _magazines - _explosives;

_playersAmmo set ["magazines", _magazines];
_playersAmmo set ["throwables", _throwables];
_playersAmmo set ["explosives", _explosives];

{
    {
        private _helperArray = [];

    } forEach _y;
} forEach _playersAmmo;

_playersAmmo
