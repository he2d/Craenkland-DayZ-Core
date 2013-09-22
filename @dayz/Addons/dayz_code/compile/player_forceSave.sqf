private["_magazineArray", "_objects"];
_magazineArray = [] call player_countMagazines;

PVDZ_plr_Save = [player,[_magazineArray,dayz_onBack],false];
publicVariableServer "PVDZ_plr_Save";

_objects = nearestObjects [getPosATL player, ["Car", "Helicopter", "Motorcycle", "Ship", "Land_A_tent"], 10];

{
	PVDZ_veh_Save = [_x,"gear"];
	publicVariableServer "PVDZ_veh_Save";

} foreach _objects;
					
dayz_lastSave = diag_tickTime;
