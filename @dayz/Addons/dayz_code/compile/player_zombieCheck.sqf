private ["_refObj","_listTalk","_attacked","_type","_chance","_last","_targets","_cantSee","_lowBlood","_near","_targeted","_attackCheck","_group","_localtargets","_remotetargets","_radius","_vehicle","_isVehicle"];

_radius = 200;
_vehicle = vehicle player;
_isVehicle = (_vehicle != player);
_refObj = (driver _vehicle);
_listTalk = (getPosATL _refObj) nearEntities ["Zed_Base", _radius];
//_pHeight = (getPosATL _refObj) select 2;
_attacked = false; // at least 1 Z attacked the player
_near = false;
//_multiplier = 1;

{
	_type = "zombie";
	if (alive _x) then {
		private["_dist"];
		_dist = (_x distance _refObj);
		_group = _x;
		_chance = 1; //0 / dayz_monitorPeriod; // Z verbosity
		_targeted = false;
		
		_localtargets = _group getVariable ["localtargets",[]];
		_remotetargets = _group getVariable ["remotetargets",[]];
		_targets = _localtargets + _remotetargets;
		
		if (_x distance player >= dayz_areaAffect) then {
			if (speed _x < 4) then {
				[_x,"idle",(_chance + 4),true] call dayz_zombieSpeak;
			} else {
				[_x,"chase",(_chance + 3),true] call dayz_zombieSpeak;
			};
		};
		
		if (_refObj in _targets) then {
			if (_x distance player < 3.6) then {
				//check for vehicle
				if (_isVehicle) then {
					if (!(animationState _x == "ZombieFeed")) then {
						//perform an attack
						_last = _x getVariable["lastAttack", 0];
						if ((diag_tickTime - _last) > 1) then {
							_attackResult = [_x,  _type] spawn player_zombieAttack;
							_x setVariable["lastAttack", diag_tickTime - random(1)];
							//waitUntil{scriptDone _attackResult};;
						};
						_attacked = true;
					};
			
				} else {
					if (_x distance player < 2.5) then {
						if (!(animationState _x == "ZombieFeed")) then {
							//perform an attack
							_last = _x getVariable["lastAttack", 0];
							if ((diag_tickTime - _last) > 1) then {
								//_LosCheck = [_refObj,_x] call dayz_losCheck_attack;
								//if (_LosCheck) then {
									_attackResult = [_x,  _type] spawn player_zombieAttack;
									_x setVariable["lastAttack", diag_tickTime - random(1)];
									//waitUntil{scriptDone _attackResult};;
								//};
							};
							_attacked = true;
						};
					};	
				};
			};
		};
			
		if (!(_refObj in _targets)) then {	
			//Noise Activation
			if (_dist < DAYZ_disAudial) then {		
				if (DAYZ_disAudial > 80) then {		
					_targeted = true;
				} else {
					_chance = [_group,_dist,DAYZ_disAudial] call dayz_losChance;
					if ((random 1) < _chance) then {	
						_cantSee = [_group,_refObj] call dayz_losCheck;
						if (!_cantSee) then {
							_targeted = true;
						} else {
							if (_dist < (DAYZ_disAudial / 2)) then {
								_targeted = true;
							};
						};
					};
				};
			};
			
			//Sight Activation
			if (_dist < (DAYZ_disVisual/2) ) then {
				_chance = [_group,_dist,DAYZ_disVisual] call dayz_losChance;
				//diag_log ("zombieCheck" +str(_chance/2));
				if ((random 1) < (_chance)) then {
					//_tPos = (getPosASL _refObj);
					//_zPos = (getPosASL _group);
					//_eyeDir = direction _group;
					_attackCheck = [_refObj,_x,45] call dayz_AttackCheck;
					if (_attackCheck) then {
						_targeted = true;
					};
				};
			};
		};
		
		if (_targeted) then {
			switch (local _x) do {
				case false: {
					_remotetargets set [count _remotetargets,_refObj];
					_x setVariable ["remotetargets",_remotetargets,true];
				};
				case true: {
					_localtargets set [count _localtargets,_refObj];
					_x setVariable ["localtargets",_localtargets,false];
				};
			};
		};
	};
} forEach _listTalk;

if (_attacked) then {
	if (r_player_unconscious) then {
		[_refObj, "scream", 6, false] call dayz_zombieSpeak;
	} else {
		_lowBlood = (r_player_blood / r_player_bloodTotal) < 0.5;
		if (_lowBlood) then {
			dayz_panicCooldown = time;
			[_refObj, "panic", 6, false] call dayz_zombieSpeak;
		};
	};
};
	
// return true if attacked or near. if so,  player_monitor will perform its ridiculous 'while true' loop faster.
(_attacked OR _near)
