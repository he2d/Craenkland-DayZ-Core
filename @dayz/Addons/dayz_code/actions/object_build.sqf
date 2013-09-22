private ["_array","_object","_item","_classname","_text","_build","_inside","_location","_nearObjects","_dis","_sfx"];
_array = _this select 3;
_object = _array select 0;
_item = _array select 1;
_classname = _array select 2;
_text = _array select 3;
_build = _array select 4;
_dis = _array select 5;
_sfx = _array select 6;

if (isNull _object) exitWith {};

player setVariable ["constructionObject", objNull];

//diag_log("Array: "+str(_array));
//diag_log(format["Array: object: %1 item: %2, classname: %3, text: %4, build: %5, booleans: %6, dis: %7, sfx: %8", _object, _item, _classname, _text, _build, _booleans, _dis,_sfx]);
_createPoints = {
    private ["_unit","_boundingBox","_points"];
    _unit = _this select 0;
	_scale = _this select 1;
	_boundingBox = boundingBox _unit;
	_boundingBox =[[((_boundingBox select 0) select 0) * _scale, ((_boundingBox select 0) select 1) * _scale, (_boundingBox select 0) select 2], [((_boundingBox select 1) select 0) * _scale, ((_boundingBox select 1) select 1) * _scale, (_boundingBox select 1) select 2]];
	
	_points = [getPosATL _unit];
	
	for "_i" from 1 to 0 step -0.5 do {
		for "_j" from 0 to 1 do {
			_points set [count _points, _unit modelToWorld [0, ((_boundingBox select 0) select 1) * _i, 0]];
			_points set [count _points, _unit modelToWorld [0, ((_boundingBox select 1) select 1) * _i, 0]];
			_points set [count _points, _unit modelToWorld [((_boundingBox select 0) select 0) * 0.5, ((_boundingBox select _j) select 1) * _i, 0]];
			_points set [count _points, _unit modelToWorld [((_boundingBox select 1) select 0) * 0.5, ((_boundingBox select _j) select 1) * _i, 0]];
			_points set [count _points, _unit modelToWorld [((_boundingBox select 0) select 0) * 1, ((_boundingBox select _j) select 1) * _i, 0]];
			_points set [count _points, _unit modelToWorld [((_boundingBox select 1) select 0) * 1, ((_boundingBox select _j) select 1) * _i, 0]];
		};
	};
	_points;
};

_insideCheck = {
	private ["_x","_inside","_myX","_myY","_building","_unit","_boundingBox","_points","_min","_max"];
    _building = _this select 0;
	_unit = _this select 1;
	
	_inside = false;
	//Change these to tweak collision detection
	_scale = switch (_this select 2) do {
		case "building": { 0.65 };
		case "tree": { 0.25 };
		case "picea": { 0.0 };
	};
	
	_points = [_unit, _scale] call _createPoints;
	
	_boundingBox = boundingBox _building;
	_min = _building modelToWorld (_boundingBox select 0);
	_max = _building modelToWorld (_boundingBox select 1);
	//diag_log format["boundingBox: %1    min: %2    max: %3", _boundingBox, _min, _max];
	
	{
		_myX = _x select 0;
		_myY = _x select 1;

		if ((_myX > ((_min select 0) min (_max select 0))) and {(_myX < ((_max select 0) max (_min select 0)))}) then {
			if ((_myY > ((_min select 1) min (_max select 1))) and {(_myY < ((_max select 1) max (_min select 1)))}) then {
				_inside = true;
				//diag_log format["result: %1", _inside];
			};
		};
		
		if (_inside) exitWith {};
	} forEach _points;
	
	_inside;
};

if (_build) then {
	_inside = false;
	_nearObjects = nearestObjects [player, [], 15];
	//diag_log format["nearObjects: %1", _nearObjects];
	{
		if ((!isNull _x) and (!(_x == player)) and (!(_x == _object))) then {
			//diag_log format["object: %1    type: %2    string: %3    t_: %4    b_: %5    building: %6    vehicle: %7", _x, typeOf _x, str(_x), [": t_", str(_x)] call fnc_inString, [": b_", str(_x)] call fnc_inString, _x isKindOf "Building", _x isKindOf "AllVehicles"];
			switch true do {
				case ((_x isKindOf "Building") or (_x isKindOf "AllVehicles") or (["rock", str(_x)] call fnc_inString)): { //Building or Vehicle or Rock
					_inside = [_x, _object, "building"] call _insideCheck;
					if (!_inside) then {
						_inside = [_object, _x, "building"] call _insideCheck;
					};
					//diag_log "BUILDING";
				};
				case ([": t_picea", str(_x)] call fnc_inString): {
					_inside = [_object, _x, "picea"] call _insideCheck;
					//diag_log "PICEA";
				};

				case (([": t_", str(_x)] call fnc_inString) or ([": b_", str(_x)] call fnc_inString)): { //Tree or Bush
						_inside = [_object, _x, "tree"] call _insideCheck;
						//diag_log "TREE";
				};
			};
			//diag_log format["result: %1", _inside];
		};
		if (_inside) exitWith {};
	}forEach _nearObjects;
	
	if (!_inside) then {
		[player,_sfx,0,false,_dis] call dayz_zombieSpeak;
		[player,_dis,true,(getPosATL player)] call player_alertZombies;

		player playActionNow "Medic";

		sleep 5;
		
		_location = getPosATL _object;
		_object setPosATL [_location select 0, _location select 1, 0.01];
		_object setDir (getDir _object);

		player reveal _object;

		_object setVariable ["characterID",dayz_characterID,true];

		if (_object isKindOf "TrapItems") then {
			if (getNumber (configFile >> "CfgVehicles" >> typeOf _object >> "initState") > 0) then {
				_object setVariable ["armed", true, true];
			} else {
				_object setVariable ["armed", false, true];
			};
		};

		cutText [format[localize "str_build_01",_text], "PLAIN DOWN"];

		PVDZ_obj_Publish = [dayz_characterID,_object,[getDir _object, getPosATL _object],_classname];
		publicVariableServer "PVDZ_obj_Publish";

		r_action_count = 0;
		cutText [format[localize "str_build_01",_text], "PLAIN DOWN"];
	} else {
		r_action_count = 0;
		deleteVehicle _object;
		player addMagazine _item;
		cutText [format[localize "str_build_failed_01",_text], "PLAIN DOWN"];
	};
} else {
	r_action_count = 0;
	deleteVehicle _object;
	player addMagazine _item;
	cutText [format[localize "str_build_failed_01",_text], "PLAIN DOWN"];
};