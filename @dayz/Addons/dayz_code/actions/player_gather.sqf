private ["_plant","_type","_itemOut","_amountOut","_alreadyGathering","_dis","_sfx","_r","_l","_i","_result","_string","_text"];

_plant = _this select 3;

_type = typeOf _plant;
_itemOut = getText(configFile >> "CfgVehicles" >> _type >> "output");
_amountOut = getNumber(configFile >> "CfgVehicles" >> _type >> "outamount");

//kneel to gather
player playActionNow "Medic";

//remove action menu
player removeAction s_player_gather;
s_player_gather = -1;

//check if already gathering
_alreadyGathering = _plant getVariable["Gathering",0];
if (_alreadyGathering == 1) exitWith { };

//Set to gather
_plant setVariable["Gathering",1];

//Make some noise
_dis=2;
_sfx = "tentpack";
[player,_sfx,0,false,_dis] call dayz_zombieSpeak;
[player,_dis,true,(getPosATL player)] call player_alertZombies;

sleep 3;

_r = 0;
_l = 0;
_i = 0;

while {_i < _amountOut} do {
	_result = [player,_itemOut] call BIS_fnc_invAdd;
	sleep 0.03;
	if (_result) then {
		//Pickup Counter
		_r = _r + 1;
		
		//Remove only on first successful attempt.
		if (_r == 1) then { 
			//Reset anti dupe var on successful. 
			_plant setVariable["Gathering",nil];
			
			//remove vehicle, Need to ask server to remove.
			PVDZ_objgather_Delete = [_plant,player];
			publicVariableServer "PVDZ_objgather_Delete";
		};
	} else {
		//Lost counter
		_l = _l + 1;
	};
	//Loop Counter
	_i = _i + 1;
};

if (_r > 0) then {
	//Cutext on successful pickup
	_string = format[localize "str_success_gathered",getText(configFile >> "CfgMagazines" >> _itemOut >> "displayName"), _r, _l];
	cutText [_string, "PLAIN DOWN"];
};

if (_r < 1) then {
	//reset anti dupe on failed attempt
	_plant setVariable["Gathering",nil];
	
	//Failed Msg due to invenotry being full.
	_text = getText (configFile >> "CfgMagazines" >> _type >> "displayName");
	cutText [format[localize "str_failed_noroom",_text], "PLAIN DOWN"];
};