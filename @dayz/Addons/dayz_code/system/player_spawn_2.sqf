private ["_refObj","_size","_vel","_speed","_hunger","_thirst","_timeOut","_result","_wpnType","_isOK","_randomSpot","_distance","_mylastPos","_humanity","_lastTemp","_rnd","_listTalk","_messTimer","_display","_control","_PlayerNearby","_ZedsNearby","_ismelee","_saveTime","_tempPos","_lastUpdate","_foodVal","_thirstVal","_lowBlood","_startcombattimer","_myPos","_debug"];
disableSerialization;
_timeOut = 0;
_messTimer = 0;
_lastTemp = dayz_temperatur;
_debug = getMarkerpos "respawn_west";

player setVariable ["temperature",dayz_temperatur,true];

dayz_myLoad = (((count dayz_myBackpackMags) * 0.2) + (count dayz_myBackpackWpns)) + (((count dayz_myMagazines) * 0.1) + (count dayz_myWeapons * 0.5));

[player,0] call player_humanityChange;

//player addMagazine "Hatchet_swing";
//player addWeapon "MeleeHatchet";

while {true} do {
	//Initialize
	_refObj = vehicle player;
	_size = (sizeOf typeOf _refObj) * 0.6;
	_vel = velocity player;
	_speed = round((_vel distance [0,0,0]) * 3.5);
	_saveTime = (playersNumber west * 2) + 10;

	//reset position
	_randomSpot = true;
	_tempPos = getPosATL player;
	_distance = _debug distance _tempPos;
	if (_distance < 2000) then {
		_randomSpot = false;
	};
	_distance = [0,0,0] distance _tempPos;
	if (_distance < 500) then {
		_randomSpot = false;
	};
	if (!isNil "_mylastPos") then {
		_distance = _mylastPos distance _tempPos;
		if (_distance > 400) then {
			_randomSpot = false;
		};
	};
	if (_randomSpot) then {
		_mylastPos = _tempPos;
	};

	if (!isNil "_mylastPos") then {
		dayz_mylastPos = _mylastPos;
	};
	dayz_areaAffect = _size;

	if (_speed > 0.1) then {
		_timeOut = _timeOut + 1;
	};

	if (_timeOut > 150) then {
		_humanity = player getVariable ["humanity",0];
		if (_humanity < 1) then {
			[player, round(_timeOut / 10)] call player_humanityChange;
		};
		_timeOut = 0;
	};

/*
	//Has infection?
	if (r_player_infected) then {
		[player,"cough",4,false] call dayz_zombieSpeak;
	};
*/
	//Record Check
	_lastUpdate = time - dayZ_lastPlayerUpdate;
	if (_lastUpdate > 8) then {
		//POSITION?
		_distance = dayz_myPosition distance player;
		if (_distance > 10) then {
			//Player has moved
			dayz_myPosition = getPosATL player;
			player setVariable["posForceUpdate",true,true];
			dayz_unsaved = true;
			dayZ_lastPlayerUpdate = time;
		};
	};

	//Hunger
	_hunger = +((((r_player_bloodTotal - r_player_blood) / r_player_bloodTotal) * 5) + _speed + dayz_myLoad) * 3;
	if (time - dayz_panicCooldown < 120) then {
		_hunger = _hunger * 2;
	};
	dayz_hunger = dayz_hunger + (_hunger / 60);

	//Thirst
	_thirst = 2;
	if (_refObj == player) then {
		_thirst = (_speed + 4) * 3;
	};
	dayz_thirst = dayz_thirst + (_thirst / 60) * (dayz_temperatur / dayz_temperaturnormal);	//TeeChange Temperatur effects added Max Effects: -25% and + 16.6% waterloss

	//Temperatur
	2 call player_temp_calculation; //2 = sleep time of this loop //TeeChange
	if ((_lastTemp - dayz_temperatur) > 0.75 or (_lastTemp - dayz_temperatur) < -0.75 ) then {
		player setVariable ["temperature",dayz_temperatur,true];
		_lastTemp = dayz_temperatur;
	};

	//can get nearby infection
	if (!r_player_infected) then {
		//	Infectionriskstart
		if (dayz_temperatur < ((80 / 100) * (dayz_temperaturnormal - dayz_temperaturmin) + dayz_temperaturmin)) then { //TeeChange
			_listTalk = _mylastPos nearEntities ["CAManBase",8];
			{
				if (_x getVariable["USEC_infected",false]) then {
					_rnd = (random 1) * (((dayz_temperaturnormal - dayz_temperatur) * (100 /(dayz_temperaturnormal - dayz_temperaturmin)))/ 50);	//TeeChange
					if (_rnd < 0.1) then {
						_rnd = random 1;
						if (_rnd > 0.7) then {
							r_player_infected = true;
							//player setVariable["USEC_infected",true];
						};
					};
				};
			} forEach _listTalk;
			if (dayz_temperatur < ((50 / 100) * (dayz_temperaturnormal - dayz_temperaturmin) + dayz_temperaturmin)) then { //TeeChange
				_rnd = (random 1) * (((dayz_temperaturnormal - dayz_temperatur) * (100 /(dayz_temperaturnormal - dayz_temperaturmin)))/ 25);	//TeeChange
				if (_rnd < 0.05) then {
					_rnd = random 1;
					if (_rnd > 0.95) then {
						r_player_infected = true;
						//player setVariable["USEC_infected",true];
					};
				};
			};
		};
	};	

	//If has infection reduce blood cough and add shake
	if (r_player_infected) then {
		if !(player getVariable["USEC_infected",false]) then {
			player setVariable["USEC_infected",true,true];
		};

		if (!r_player_unconscious) then {
			_rnd = 10; //_rnd = ceil (random 8);
			[player,"cough",_rnd,false] call dayz_zombieSpeak;

			if (_rnd < 3) then {
				addCamShake [2, 1, 25];
			};
		};
		
		_result = r_player_blood - 3;
		if (_result < 0) then {
			_id = [player,"sick"] spawn player_death;
		};
	};

	//Pain Shake Effects
	if (r_player_inpain and !r_player_unconscious) then {
		playSound "breath_1";
		addCamShake [2, 1, 25];
	};

	//Hunger Effect
	_foodVal = dayz_statusArray select 0;
	_thirstVal = dayz_statusArray select 1;
	if (_thirstVal <= 0) then {
		_result = r_player_blood - 10;
		if (_result < 0) then {
			_id = [player,"dehyd"] spawn player_death;
		} else {
			r_player_blood = _result;
		};
	};
	if (_foodVal <= 0) then {
		_result = r_player_blood - 10;
		if (_result < 0) then {
			_id = [player,"starve"] spawn player_death;
		} else {
			r_player_blood = _result;
		};
	};

	//Record low bloow
	_lowBlood = player getVariable ["USEC_lowBlood", false];
	if ((r_player_blood < r_player_bloodTotal) and !_lowBlood) then {
		player setVariable["USEC_lowBlood",true,true];
	};

	//Broadcast Hunger/Thirst
	_messTimer = _messTimer + 1;
	if (_messTimer > 15) then {
		_messTimer = 0;
		player setVariable ["messing",[dayz_hunger,dayz_thirst],true];
	};

	//check if can disconnect
	if (!dayz_canDisconnect) then {
		if ((time - dayz_damageCounter) > 180) then {
			if (!r_player_unconscious) then {
				dayz_canDisconnect = true;
				//["PVDZ_plr_Discorem",getPlayerUID player] call callRpcProcedure;
				PVDZ_plr_Discorem = getPlayerUID player;
				publicVariableServer "PVDZ_plr_Discorem";

				//Ensure Control is hidden
				_display = uiNamespace getVariable 'DAYZ_GUI_display';
				_control = _display displayCtrl 1204;
				_control ctrlShow false;
			};
		};
	};

	//Save Checker
	if (dayz_unsaved or ((time - dayz_lastSave) > 300)) then {
		if ((time - dayz_lastSave) > _saveTime) then {
			PVDZ_plr_Save = [player,nil,false];
			publicVariableServer "PVDZ_plr_Save";

			if (isServer) then {
				PVDZ_plr_Save call server_playerSync;
			};

			dayz_unsaved = false;
			dayz_lastSave = time;
		};
	};

	// sort out pickup actions
	_isOK = (pickupInit and !canPickup) or (!pickupInit and canPickup);

	if (_isOK) then {
		if (pickupInit and !canPickup) then {
			canPickup = true;
			pickupInit = false;
		};
	} else {
		// reset
		canPickup = false;
		pickupInit = true;
	};

	_PlayerNearby = false;
	_ZedsNearby = false;
	if ({isPlayer _x} count (player nearEntities ["AllVehicles", 5]) > 1) then {
		_PlayerNearby = true;
	};
	if (count (player nearEntities ["zZombie_Base", 10]) > 0) then {
		_ZedsNearby = true;
	};

	_startcombattimer = player getVariable["startcombattimer", 0];
	if (_startcombattimer == 1 || _PlayerNearby) then {
		player setVariable["combattimeout", diag_tickTime + 30, false];
		player setVariable["startcombattimer", 0, false];
	} else {
		if (_ZedsNearby) then {
			player setVariable["combattimeout", diag_tickTime + 10, false];
			player setVariable["startcombattimer", 0, false];
		};
	};
	//setGroupIconsVisible [false,false];
	//clearGroupIcons group player;

	"colorCorrections" ppEffectAdjust [1, 1, 0, [1, 1, 1, 0.0], [1, 1, 1, 1 min (4*r_player_blood/3/r_player_bloodTotal)],  [1, 1, 1, 0.0]];
	"colorCorrections" ppEffectCommit 0;
	sleep 2;

	_myPos = player getVariable["lastPos",[]];
	if (count _myPos > 0) then {
		player setVariable["lastPos",_mylastPos, true];
		player setVariable["lastPos",[]];
	};

	//Melee Weapons ammo fix
	if(isNil {login_ammochecked}) then {
		login_ammochecked = true;
		 _wpnType = primaryWeapon player;
		_ismelee = (gettext (configFile >> "CfgWeapons" >> _wpnType >> "melee"));
		if (_ismelee == "true") then {
			call dayz_meleeMagazineCheck;
		};
	};

	//Crowbar ammo fix
	//"MeleeCrowbar" call dayz_meleeMagazineCheck;

};
