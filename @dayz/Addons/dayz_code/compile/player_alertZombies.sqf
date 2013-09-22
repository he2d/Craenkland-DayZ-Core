private ["_unit","_distance","_doRun","_pos","_listTalk","_localtargets","_remotetargets","_zombie"];

_unit = 	_this select 0;
_distance = _this select 1;
_doRun = 	_this select 2;
_pos = 		_this select 3;
_listTalk = _pos nearEntities ["zZombie_Base",_distance];

{
private["_target","_targets"];

	_zombie = _x;
	if (_doRun) then {
		_localtargets = _x getVariable ["localtargets",[]];
		_remotetargets = _x getVariable ["remotetargets",[]];
		_targets = _localtargets + _remotetargets;
		if (!(_unit in _targets)) then {
			switch (local _x) do {
				case false: {
					_remotetargets set [count _remotetargets,_unit];
					_x setVariable ["remotetargets",_remotetargets,true];
				};
				case true: {
					_localtargets set [count _localtargets,_unit];
					_x setVariable ["localtargets",_localtargets,false];
				};
			};
		};
	} else {
		_zombie setVariable ["myDest",_pos,true];
	};
	
} forEach _listTalk;