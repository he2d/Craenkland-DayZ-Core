private ["_started","_finished","_animState","_isMedic","_id","_unit","_item"];
_unit = (_this select 3) select 0;
_item = (_this select 3) select 1;
player removeMagazine _item;

call fnc_usec_medic_removeActions;
r_action = false;

if (vehicle player == player) then {
	//not in a vehicle
	player playActionNow "Medic";
};

r_interrupt = false;
_animState = animationState player;
r_doLoop = true;
_started = false;
_finished = false;
[player,"bandage",0,false] call dayz_zombieSpeak;
while {r_doLoop} do {
	_animState = animationState player;
	_isMedic = ["medic",_animState] call fnc_inString;
	if (_isMedic) then {
		_started = true;
	};
	if (_started and !_isMedic) then {
		r_doLoop = false;
		_finished = true;
	};
	if (r_interrupt) then {
		r_doLoop = false;
	};
	if (vehicle player != player) then {
		sleep 3;
		r_doLoop = false;
		_finished = true;
	};
	sleep 0.1;
};
r_doLoop = false;

if (_finished) then {
	//["PVCDZ_hlt_Bandage",[_unit,player]] call broadcastRpcCallAll;
	//PVCDZ_hlt_Bandage = [_unit,player];
	//publicVariable "PVCDZ_hlt_Bandage";
	PVDZ_send = [_unit,"Bandage",[_unit,player]];
	publicVariableServer "PVDZ_send";
	

	if ((_unit == player) or (vehicle player != player)) then {
		//Self Healing
		_id = [player,player] execVM "\z\addons\dayz_code\medical\publicEH\medBandaged.sqf";
		dayz_sourceBleeding = objNull;
		call fnc_usec_resetWoundPoints;
	} else {
		//PVCDZ_plr_Humanity = [player,20];
		[player,20] call player_humanityChange;
	};
} else {
	r_interrupt = false;
	[objNull, player, rSwitchMove,""] call RE;
	player playActionNow "stop";
	player addMagazine _item;
};