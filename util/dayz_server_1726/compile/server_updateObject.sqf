private["_objectID","_object","_updates","_uGear","_key","_result","_position","_speed","_crew","_canDo","_uid","_type","_previous"];
_object = 	_this select 0;
_objectID =	_object getVariable ["ObjectID","0"];
_uid = 		_object call dayz_objectUID;
_type = 	_this select 1;
_speed = speed _object;
_crew = driver _object;
_damage = damage _object;
_canDo = false;
_key = "";
_lastUpdate = _object getVariable ["lastUpdate",time];

diag_log ("HIVE: UPDATING OBJ: "+ str(_this) + " / UID: " + str(_uid));

_object setVariable ["lastUpdate",time];
switch (_type) do {
	case "all": {
		_position = getPosATL _object;
		_worldspace = [
			round(direction _object),
			_position
		];
		_fuel = 0;
		if (_object isKindOf "AllVehicles") then {
			_fuel = fuel _object;
		};
		_key = format["CHILD:305:%1:%2:%3:",_objectID,_worldspace,_fuel];
		diag_log ("HIVE: WRITE: "+ str(_key));
		_key call server_hiveWrite;
		_inventory = [
			getWeaponCargo _object,
			getMagazineCargo _object,
			getBackpackCargo _object
		];
		_previous = str(_object getVariable["lastInventory",[]]);
		if (str(_inventory) != _previous) then {
			_object setVariable["lastInventory",_inventory];
			if (_objectID == "0") then {
				_key = format["CHILD:309:%1:%2:",_uid,_inventory];
			} else {
				_key = format["CHILD:303:%1:%2:",_objectID,_inventory];
			};
			diag_log ("HIVE: WRITE: "+ str(_key));
			_key call server_hiveWrite;
		};
		_hitpoints = _object call vehicle_getHitpoints;
		_array = [];
		_dam = 1;
		{
			_hit = [_object,_x] call object_getHit;
			_selection = getText (configFile >> "CfgVehicles" >> (typeOf _object) >> "HitPoints" >> _x >> "name");
			if (_hit > 0) then {_array set [count _array,[_selection,_hit]]};
		} forEach _hitpoints;
		_key = format["CHILD:306:%1:%2:%3:",_objectID,_array,_damage];
		diag_log ("HIVE: WRITE: "+ str(_key));
		_key call server_hiveWrite;
	};
	case "position": {
		_position = getPosATL _object;
		_worldspace = [
			round(direction _object),
			_position
		];
		_fuel = 0;
		if (_object isKindOf "AllVehicles") then {
			_fuel = fuel _object;
		};
		_key = format["CHILD:305:%1:%2:%3:",_objectID,_worldspace,_fuel];
		diag_log ("HIVE: WRITE: "+ str(_key));
		_key call server_hiveWrite;
	};
	case "gear": {
		_inventory = [
			getWeaponCargo _object,
			getMagazineCargo _object,
			getBackpackCargo _object
		];
		_previous = str(_object getVariable["lastInventory",[]]);
		if (str(_inventory) != _previous) then {
			_object setVariable["lastInventory",_inventory];
			if (_objectID == "0") then {
				_key = format["CHILD:309:%1:%2:",_uid,_inventory];
			} else {
				_key = format["CHILD:303:%1:%2:",_objectID,_inventory];
			};
			diag_log ("HIVE: WRITE: "+ str(_key));
			_key call server_hiveWrite;
		};
	};
	case "damage": {
		_hitpoints = _object call vehicle_getHitpoints;
		_array = [];
		_dam = 1;
		{
			_hit = [_object,_x] call object_getHit;
			_selection = getText (configFile >> "CfgVehicles" >> (typeOf _object) >> "HitPoints" >> _x >> "name");
			if (_hit > 0) then {_array set [count _array,[_selection,_hit]]};
		} forEach _hitpoints;
			
		_key = format["CHILD:306:%1:%2:%3:",_objectID,_array,_damage];
		diag_log ("HIVE: WRITE: "+ str(_key));
		_key call server_hiveWrite;
	};
	case "repair": {
		_hitpoints = _object call vehicle_getHitpoints;
		_array = [];
		_dam = 1;
		{
			_hit = [_object,_x] call object_getHit;
			_selection = getText (configFile >> "CfgVehicles" >> (typeOf _object) >> "HitPoints" >> _x >> "name");
			if (_hit > 0) then {_array set [count _array,[_selection,_hit]]};
		} forEach _hitpoints;
		_key = format["CHILD:306:%1:%2:%3:",_objectID,_array,damage _object];
		diag_log ("HIVE: WRITE: "+ str(_key));
		_key call server_hiveWrite;
	};
};