/*
        Created exclusively for ArmA2:OA - DayZMod.
        Please request permission to use/alter/distribute from project leader (R4Z0R49) AND the author (facoptere@gmail.com)
*/
private ["_rnd","_move","_hpList","_hp","_wound","_cnt","_index","_damage","_woundDamage","_total","_doRE","_deg","_lastTackle","_cantSee","_unit","_type","_vehicle","_speed","_distance","_isVehicle","_dist","_tPos","_zPos","_inAngle","_pos","_movePlayer","_knockdown","_dir"];
//_start = diag_tickTime;

_unit = _this select 0;
_type = _this select 1;

_vehicle = (vehicle player);
_speed = speed player;
//_nextPlayerPos = player call dayz_futurePos;
_distance = [_unit, player] call BIS_fnc_distance2D;
//_viralZeds = typeOf _unit in DayZ_ViralZeds;
_isVehicle = (_vehicle != player);
//_agentPos = getPosATL _unit;

if (_type != "zombie") exitWith { diag_log ("not a zombie"); }; // we deal only with zombies in this function
if (_unit distance player > dayz_areaAffect) exitWith { diag_log ("too far:"); }; // distance too far according to any logic dealt here //+str(_unit distance _nextPlayerPos)+"/"+str(_areaAffect)

// check Z stance. Stand up Z if it prones/kneels.
if (unitPos _unit != "UP") then {
	_unit setUnitPos "UP";
};

// make sure zed is facing player
_dir = [_unit,player] call BIS_Fnc_dirTo;
_unit setDir _dir;

// compute the animation move
_rnd = 0;
_dist = round(_distance*10);
switch true do {
	case (((toArray(animationState player) select 5) == 112) && (_distance < 2.2)) : {
			_rnd = ceil(random 4); //9
			_move = "ZombieFeed" + str(_rnd);
	};
	case (r_player_unconscious && ((random 3) < 1)) : {
			_rnd = ceil(random 4); //9
			_move = "ZombieFeed" + str(_rnd);
	};
	case ((_isVehicle) AND (_distance < 3.6)) : { // enable attack if Z is between 2.2 and 3.5. Other cases are handled in "default"
		_rnd = 8;
		_move = "ZombieStandingAttack" + str(_rnd);
	};
	case (((_speed >= 5) or (_speed <= -5)) and (_distance < 2.3)) : {
		_rnd = 8;
		_move = "ZombieStandingAttack" + str(_rnd);
	};
	default {
		// attack moves depends on the distance between player and Z
		// we compute the distance in 10cm slots.
		switch _dist do {
			case 0 : {_rnd = [ 1, 4, 9, 3, 6 ];};
			case 10 : {_rnd = [ 1, 4, 9, 3, 6 ];};
			case 11 : {_rnd = [ 1, 4, 9, 3, 6 ];};
			case 12 : {_rnd = [ 1, 9, 3, 6 ];};
			case 13 : {_rnd = [ 3, 6 ];};
			case 14 : {_rnd = [ 3, 6, 7 ];};
			case 15 : {_rnd = [ 7, 5, 10 ];};
			case 16 : {_rnd = [ 7, 5, 10 ];};
			case 17 : {_rnd = [ 7, 5, 10 ];};
			case 18 : {_rnd = [ 8, 10 ];};
			case 19 : {_rnd = [ 8, 10 ];};
			case 20 : {_rnd = [ 8 ];}; 
			case 21 : {_rnd = [ 8 ];};
			case 22 : {_rnd = [ 8 ];};
			default { 
				if (_dist < 10) then {_rnd = [ 1, 2, 4, 9 ];} else {
				if (_dist > 22) then {_rnd = [ 8 ];} else { _rnd = ceil(random 4);};
				};
			};
		};
		_rnd = _rnd call BIS_fnc_selectRandom;
		_move = "ZombieStandingAttack" + str(_rnd);
		//diag_log format ["Distance: %3/%1, Animation: %2", _distance, _rnd, _dist];
	};
};

// make sure zed is still facing player
_dir = [_unit,player] call BIS_Fnc_dirTo;
_unit setDir _dir;

// let's animate the Z
if (local _unit) then {
	_unit switchMove _move;
} else {
	[objNull,  _unit,  rSwitchMove,  _move] call RE;
};

sleep 0.03;

_tPos = (getPosASL _vehicle);
_zPos = (getPosASL _unit);
_inAngle = [_zPos,(getdir _unit),50,_tPos] call fnc_inAngleSector;
if (_inAngle) then {
	// compute damage for vehicle and/or the player
	if (_isVehicle) then {
		if ((_unit distance player) < 3.6) then {
			// eject the player of the open vehicle. There will be no damage in this case
			if (0 != {_vehicle isKindOf _x} count ["ATV_Base_EP1",  "Motorcycle",  "Bicycle"]) then {
				if (random 3 < 1) then {
					player action ["eject",  _vehicle];
				};
				diag_log(format["%1: Player ejected from %2", __FILE__, _vehicle]);
			} else { 
				// vehicle with a compartment
				_wound = _this select 2; // what is this? wound linked to Z attack?
				if (isNil "_wound") then {
					_hpList = _vehicle call vehicle_getHitpoints;
					_hp = _hpList call BIS_fnc_selectRandom;
					_wound = getText(configFile >> "cfgVehicles" >> (typeOf _vehicle) >> "HitPoints" >> _hp >> "name");
				};
				_woundDamage = _vehicle getVariable ["hit_"+_wound, 0];
				// we limit how vehicle could be damaged by Z. Above 0.8, the vehicle could explode, which is ridiculous.
				_damage =  (if (_woundDamage < 0.8 OR {(!(_wound IN dayZ_explosiveParts))}) then {0.1} else {0.01});
				// Add damage to vehicle. the "sethit" command will be done by the gameengine for which vehicle is local
				diag_log(format["%1: Part ""%2"" damaged from vehicle, damage:+%3", __FILE__, _wound, _damage]);
				_total = [_vehicle,  _wound,  _woundDamage + _damage,  _unit,  "zombie", true] call fnc_veh_handleDam;
				if ((_total >= 1) AND {(_wound IN [ "glass1",  "glass2",  "glass3",  "glass4",  "glass5",  "glass6" ])}) then {
					// glass is broken,  so hurt the player in the vehicle
					if (r_player_blood < (r_player_bloodTotal * 0.8)) then {
						_cnt = count (DAYZ_woundHit select 1);
						_index = floor (random _cnt);
						_index = (DAYZ_woundHit select 1) select _index;
						_wound = (DAYZ_woundHit select 0) select _index;
					} else {
						_cnt = count (DAYZ_woundHit_ok select 1);
						_index = floor (random _cnt);
						_index = (DAYZ_woundHit_ok select 1) select _index;
						_wound = (DAYZ_woundHit_ok select 0) select _index;
					};
					_damage = 0.2 + random (0.512);
					diag_log(format["%1 Player wounded through ""%4"" vehicle window. hit:%2 damage:+%3", __FILE__, _wound, _damage, _vehicle]);
					[player,  _wound,  _damage,  _unit,  "zombie"] call fnc_usec_damageHandler;
					
					// broadcast hit noise
					_pos = getPosATL player;
					if ({isPlayer _x} count (_pos nearEntities ["CAManBase",40]) > 1) then {
						[_unit,"hit",0,false] call dayz_zombieSpeak;
					} else {
						[_unit,"hit",0,true] call dayz_zombieSpeak;
					};
				};
			};	
		};
	} else { 
		// player by foot
		if ((_unit distance player) < 3) then {
			
			//Make sure sure evrything is processed as we attack.
			_damage = 0.1 + random (1.2);
			
			//LOS check
			_cantSee = [_unit,_vehicle] call dayz_losCheck;
			if (!_cantSee) then {
				
				if (r_player_blood < (r_player_bloodTotal * 0.8)) then {
					_cnt = count (DAYZ_woundHit select 1);
					_index = floor (random _cnt);
					_index = (DAYZ_woundHit select 1) select _index;
					_wound = (DAYZ_woundHit select 0) select _index;
				} else {
					_cnt = count (DAYZ_woundHit_ok select 1);
					_index = floor (random _cnt);
					_index = (DAYZ_woundHit_ok select 1) select _index;
					_wound = (DAYZ_woundHit_ok select 0) select _index;
				};
				[player,  _wound,  _damage,  _unit, "zombie"] call fnc_usec_damageHandler;
				
				// broadcast hit noise
				_pos = getPosATL player;
				if ({isPlayer _x} count (_pos nearEntities ["CAManBase",40]) > 1) then {
					[_unit,"hit",0,false] call dayz_zombieSpeak;
				} else {
					[_unit,"hit",0,true] call dayz_zombieSpeak;
				};
			
				// player may fall if hit...
				_deg = [player, _unit] call BIS_fnc_relativeDirTo;
				_lastTackle = player getVariable ["lastTackle", 0];
				_movePlayer = "";
				
				//head hit, Legs, pushed from back
				_knockdown = ["head_hit","legs"];
				//diag_log ("ZombieAttack: "+str(_wound));
				//_isHeadHit = (_wound == "head_hit");
				if (_wound in _knockdown) then {
					if (((diag_tickTime - _lastTackle) > 7) and (_speed >= 5.62)) then {
						switch true do {
						/*
						//Removed for now
							// front
							case (((_deg > 315) and (_deg <= 360)) or ((_deg > 0) and (_deg < 45))) : {
								//player setVelocity [(velocity player select 0) + 5 * sin direction _unit, (velocity player select 1) + 5 * cos direction _unit, (velocity player select 2) + 1];
								// stop player
								_vel = velocity player;
								player setVelocity [-(_vel select 0),  -(_vel select 1),  0];
								disableUserInput true;
								
								[diag_tickTime] call {
									_t = _this select 0;
									while { true } do {
										if (diag_tickTime - _t > 1) exitWith {disableUserInput false;};
									};
								};	
							};
						*/	
							// left
							case (((_deg > 225) and (_deg < 315))) : {

								// rotate player 'smoothly'
								[_deg] spawn {
									private["_step","_i"];
									_step = 90 / 5;
									_i = 0;
									while { _i < 5 } do {
										player setDir ((getDir player) + _step);
										_i = _i + 1;
										sleep 0.01;
									};
								};

								// make player dive
								_movePlayer = switch (toArray(animationState player) select 17) do {
									case 114 : {"ActsPercMrunSlowWrflDf_TumbleOver"}; // rifle
									case 112 : {"AmovPercMsprSlowWpstDf_AmovPpneMstpSrasWpstDnon"}; // pistol
									default {"ActsPercMrunSlowWrflDf_TumbleOver"};
								};
							};
							// right
							case (((_deg > 45) and (_deg < 135))) : {
								[_deg] spawn {
									private["_step","_i"];
									_step = 90 / 5;
									_i = 0;
									while { _i < 5 } do {
										player setDir ((getDir player) - _step);
										_i = _i + 1;
										sleep 0.01;
									};
								};

								// make player dive
								_movePlayer = switch (toArray(animationState player) select 17) do {
									case 114 : {"ActsPercMrunSlowWrflDf_TumbleOver"}; // rifle
									case 112 : {"AmovPercMsprSlowWpstDf_AmovPpneMstpSrasWpstDnon"}; // pistol
									default {"ActsPercMrunSlowWrflDf_TumbleOver"};
								};
							};
							// rear
							case (((_deg > 135) and (_deg < 225))) : {
								_movePlayer = switch (toArray(animationState player) select 17) do {
									case 114 : {"ActsPercMrunSlowWrflDf_TumbleOver"}; // rifle
									case 112 : {"AmovPercMsprSlowWpstDf_AmovPpneMstpSrasWpstDnon"}; // pistol
									default {"ActsPercMrunSlowWrflDf_TumbleOver"};
								};
							};
						};

						// make player dive After making sure the zed can see you.
						if (_movePlayer != "") then {
							player setVariable ["lastTackle", diag_tickTime];
							_doRE = ({isPlayer _x} count (player nearEntities ["AllVehicles",100]) > 1);

							if (_doRE) then {
								[nil, player, rSWITCHMOVE, _movePlayer] call RE;
							} else {
								player switchMove _movePlayer;
							};

							if (_movePlayer == "ActsPercMrunSlowWrflDf_TumbleOver") then {
								[_movePlayer, _doRE] spawn {
									private ["_movePlayer","_doRE"];
									_movePlayer = _this select 0;
									_doRE = _this select 1;

									waitUntil { animationState player == _movePlayer }; // just in case

									while { animationState player == _movePlayer } do {
										if (speed player < 4) exitWith { /* break from loop to fix animation lockup */ };
										sleep 0.1;
									};

									if (_doRE) then {
										[nil, player, rSWITCHMOVE, ""] call RE;
									} else {
										player switchMove "";
									};
								};
							};
							//diag_log(format["%1 player tackled. Weapons: cur:""%2"" anim.state:%6 (%7)--> move: %3. Angle:%4 Delta-time:%5",  __FILE__, currentWeapon player, _move, _deg, time - _lastTackle, animationState player, toArray(animationState player) select 17 ]);
						};
					};
				};
			};
		};
	};
}; // fi player by foot

//_stop = diag_tickTime;
//diag_log format ["%2 Execution Time: %1",_stop - _start, __FILE__];
