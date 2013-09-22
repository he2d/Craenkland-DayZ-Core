/*
	DayZ Fishing
	Usage: spawn player_goFishing;
	Made for DayZ Mod please ask permission to use/edit/distrubute email vbawol@veteranbastards.com.
*/
private ["_itemOut","_position","_isOk","_counter","_rnd","_item","_itemtodrop","_vehicle","_inVehicle","_text","_result","_raining","_linecastmax","_linecastmin","_num","_ispond"];

_vehicle = vehicle player;

_clearActions = {
    private ["_vehicle"];
	_vehicle = vehicle player;
    if (s_player_fishing > -1) then {
		player removeAction s_player_fishing;
		s_player_fishing = -1;
	};
	if (s_player_fishing_veh > -1) then {
		_vehicle removeAction s_player_fishing_veh;
		s_player_fishing_veh = -1;
	};
};


if(dayz_fishingInprogress) exitWith { cutText [localize "str_fishing_inprogress", "PLAIN DOWN"]; [] call _clearActions; };
dayz_fishingInprogress = true;
player removeAction s_player_fishing;
_vehicle removeAction s_player_fishing_veh;

//line distance
_linecastmax = 67;
_linecastmin = 37;

_num = (round(random _linecastmax)) max _linecastmin;

call gear_ui_init;

// find position 5m in front of player
_position = player modeltoworld [0,5,0];

_ispond = false;

/*
_objectsPond = 	nearestObjects [_position, [], 25];
{
	_isPondNearBy = ["pond",str(_x),false] call fnc_inString;
	if (_isPondNearBy) then {
		_ispond = true;
	};
	//diag_log (str(_x));
} forEach _objectsPond;
*/

//diag_log (str(_ispond));

if(!(surfaceIsWater _position) and !(_ispond)) exitWith {
	dayz_fishingInprogress = false;
	cutText [localize "str_fishing_watercheck" , "PLAIN DOWN"];
	[] call _clearActions;
};

_isOk = true;
_counter = 0;

// swing fishingpole
player playActionNow "GestureSwing";

// Alert zeds
[player,3,true,(getPosATL player)] call player_alertZombies;

r_interrupt = false;

while {_isOk} do {

	if (r_interrupt) then {
		_isOk = false;
		cutText [localize "str_fishing_canceled", "PLAIN DOWN"];
	} else {
		//make sure the player isnt swimming
		if(dayz_isSwimming) exitWith {dayz_fishingInprogress = false; cutText [localize "str_player_26", "PLAIN DOWN"]; [] call _clearActions; };
		
		//Check if raining.
		_raining = if(rain > 0) then {true} else {false};
		
		// wait for animation
		sleep 2;
			
		_rnd = 100;
		
		// check if player is in boat
		_inVehicle = (_vehicle != player);
		if(_inVehicle) then {
			if(_vehicle isKindOf "Ship") then {
				_rnd = 75;
			};
		};
		//Check for rain fish are more active during the rain.
		if (_raining) then { _rnd = _rnd / 2;};

		// 1% chance to catch anything
		if((random _rnd) <= 1) then {
			// Just the one fish for now
			_itemOut = [];
			_itemOut = switch (true) do {
				case ((_num > 30) and (_num <= 45)) : { ["FishRawTrout","FishRawTrout","FishRawTrout","FishRawTrout","FishRawTrout","FishRawTrout","FishRawTrout"]; };
				case ((_num > 45) and (_num <= 60)) : { ["FishRawTrout","FishRawTrout","FishRawTrout","FishRawTrout","FishRawTrout","FishRawSeaBass","FishRawSeaBass"]; };
				case ((_num > 60)) : { ["FishRawTrout","FishRawTrout","FishRawTrout","FishRawTrout","FishRawSeaBass","FishRawSeaBass","FishRawTuna"]; }; 				
				default { ["FishRawTrout"]; };
			};
			diag_log (str(_itemOut));
			_itemOut = _itemOut call BIS_fnc_selectRandom;
			
			if(_inVehicle) then { 
				_item = _vehicle;
				_itemtodrop = _itemOut;
				_item addMagazineCargoGlobal [_itemtodrop,1];
				//Let the player know what he caught
				_text = getText (configFile >> "CfgMagazines" >> _itemOut >> "displayName");
				cutText [format[localize "str_fishing_success",_text], "PLAIN DOWN"];
			} else {
				_result = [player,_itemOut] call BIS_fnc_invAdd;
				if (_result) then {
					//Let the player know what he caught
					_text = getText (configFile >> "CfgMagazines" >> _itemOut >> "displayName");
					cutText [format[localize "str_fishing_success",_text], "PLAIN DOWN"];
				} else {
					_text = getText (configFile >> "CfgMagazines" >> _itemOut >> "displayName");
					cutText [format[localize "str_fishing_noroom",_text], "PLAIN DOWN"];
				};
			};
			
			//end
			_isOk = false;
		} else {
			
			switch (true) do {
				case (_counter == 0) : { cutText [format[localize "str_fishing_cast",_num], "PLAIN DOWN"]; }; 
				case (_counter == 4) : { cutText [localize "str_fishing_pull", "PLAIN DOWN"]; player playActionNow "GesturePoint"; }; 
				case (_counter == 8) : { cutText [localize "str_fishing_pull", "PLAIN DOWN"]; player playActionNow "GesturePoint"; };
				default { cutText [localize "str_fishing_nibble", "PLAIN DOWN"]; };
			}; 
			_counter = _counter + 1;
				
			if(_counter == 12) then {
				_isOk = false;
				sleep 1;
				cutText [localize "str_fishing_failed", "PLAIN DOWN"];
			};
		};
	};
};
dayz_fishingInprogress = false;
[] call _clearActions;