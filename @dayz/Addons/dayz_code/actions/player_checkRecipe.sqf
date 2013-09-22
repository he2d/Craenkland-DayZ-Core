/*
	Created by Alby exclusively for DayZMod.
	Please request permission to use/alter from Alby.
*/

private ["_items","_counts","_config","_isRecipe","_item","_index","_amount","_count","_entry","_input","_array"];
disableSerialization;

_array = _this select 0;
_items = _array select 0;
_counts = _array select 1;
_config = configFile >> "CfgCrafting";
diag_log format["Items: %1    Counts: %2    Config: %3", _items, _counts, _config];
			
for "_i" from 0 to ((count _config) - 1) do{
	_entry = _config select _i;
	_input = getArray (_entry >> "input");
	diag_log format["Recipe: %1    Input: %2", _entry, _input];
	if (count _input > 0) then {
		_isRecipe = true;
		
		{
			_item = _x select 0;
			_index = _items find _item;
			diag_log format["Item: %1    Index: %2", _item, _index];
			
			if (_index <= -1) exitWith { _isRecipe = false; };
			
			_amount = _x select 2;
			_count = _counts select _index;
			diag_log format["Amount: %1    Count: %2", _amount, _count];
			
			if (_count < _amount) exitWith { _isRecipe = false; };
		}forEach _input;
		
		if (_isRecipe) exitWith {
			diag_log format["Items: %1    Recipe: %2", _this, _entry];
			_entry call player_craftItem; 
		};
	};
};

diag_log format["Exited with Items: %1", _array];