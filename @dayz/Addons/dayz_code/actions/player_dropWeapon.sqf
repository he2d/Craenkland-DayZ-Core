private ["_item","_config","_onLadder","_consume","_bag","_UpdateBack","_droppedtype"];

_item = _this;
_config = configFile >> "CfgWeapons" >> _item;
_droppedtype = (gettext (_config >> "droppeditem"));

_onLadder = (getNumber (configFile >> "CfgMovesMaleSdr" >> "States" >> (animationState player) >> "onLadder")) == 1;
if (_onLadder) exitWith {cutText [(localize "str_player_21") , "PLAIN DOWN"]; r_action_count = 0;};
if (r_action_count != 1) exitWith { cutText [localize "str_player_actionslimit", "PLAIN DOWN"]; };

call gear_ui_init;

_consume = ([] + getArray (_config >> "magazines")) select 0;

if ((dayz_onBack != "") && (dayz_onBack in MeleeWeapons)) then {
	switch DayZ_onBack do {
		case "MeleeHatchet": {_item = "ItemHatchet";};
		case "MeleeCrowbar": {_item = "ItemCrowbar";};
		case "MeleeMachete": {_item = "ItemMachete";};
	};
	dayz_onBack = "";
	disableSerialization;
	_UpdateBack = ((findDisplay 106) displayCtrl 1209) ctrlSetText "";
} else {
	player removeMagazines _consume;
	player removeWeapon _item;
	if (_droppedtype == "") then { _item = _this; } else { _item = _droppedtype; };
};
/*
if (_item == "MeleeHatchet") then {_item = "ItemHatchet";};
if (_item == "MeleeCrowbar") then {_item = "ItemCrowbar";};
if (_item == "MeleeMachete") then {_item = "ItemMachete";};
*/

_bag = createVehicle [format["WeaponHolder_%1",_item],getPosATL player,[], 1, "CAN_COLLIDE"];
_bag modelToWorld getPosATL player;
_bag setdir (getDir player);
player reveal _bag;
r_action_count = 0;