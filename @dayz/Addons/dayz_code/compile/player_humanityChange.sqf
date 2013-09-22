private ["_object","_change","_humanity","_isFreeTarget","_wait","_endTime","_model","_isBandit","_isHero"];
//Set Variables
_object = _this select 0;
_change = _this select 1;
_wait = if (count _this > 2) then { _this select 2 } else { 0 };

_humanity = 0;

if (_object == player) then {
	_humanity = player getVariable["humanity",0];
	_humanity = _humanity + _change;
	if (_change < 0) then {
		player setVariable["humanity",_humanity,true];
		if ((typeOf player != "Bandit1_DZ") && (typeOf player != "BanditW1_DZ")) then {
			_isFreeTarget = player getVariable ["freeTarget",false];

			if (_wait > 0) then {
				if (!_isFreeTarget) then {
					player setVariable ["freeTarget",true,true];
					_isFreeTarget = true;
				};

				_endTime = diag_tickTime + _wait;
				waitUntil { sleep 1; diag_tickTime > _endTime };
			};

			if (_isFreeTarget) then {
				player setVariable ["freeTarget",false,true];
			};
		};
	} else {
		player setVariable["humanity",_humanity,true];
	};

	_isBandit = typeOf _object == "Bandit1_DZ" || typeOf _object == "BanditW1_DZ";
	_isHero = typeOf _object == "Survivor3_DZ";

	if (_humanity < -2000 and !_isBandit) then {
		_model = typeOf player;
		if (_model == "Survivor2_DZ" || _model == "Survivor3_DZ") then {
			[dayz_playerUID,dayz_characterID,"Bandit1_DZ"] spawn player_humanityMorph;
		};
		if (_model == "SurvivorW2_DZ") then {
			[dayz_playerUID,dayz_characterID,"BanditW1_DZ"] spawn player_humanityMorph;
		};
	};

	if (_humanity > 0 and (_isBandit || ( _humanity < 5000 and _isHero))) then {
		_model = typeOf player;
		if (_model == "Bandit1_DZ" || _model == "Survivor3_DZ") then {
			[dayz_playerUID,dayz_characterID,"Survivor2_DZ"] spawn player_humanityMorph;
		};
		if (_model == "BanditW1_DZ") then {
			[dayz_playerUID,dayz_characterID,"SurvivorW2_DZ"] spawn player_humanityMorph;
		};
	};

	if (_humanity > 5000 and !_isHero) then {
		_model = typeOf player;
		if (_model == "Survivor2_DZ" || _model == "Bandit1_DZ") then {
			[dayz_playerUID,dayz_characterID,"Survivor3_DZ"] spawn player_humanityMorph;
		};
	};
};
