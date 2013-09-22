private ["_timer","_position","_radius","_timer1","_day"];
_timer = diag_tickTime;
_timer1 = diag_tickTime;
_spawnCheck = diag_tickTime;

_NewDay  = diag_tickTime;

while {true} do {
	if ((diag_tickTime - _timer) > 300) then {
	//Other Counters
		dayz_currentGlobalAnimals = count entities "CAAnimalBase";
		dayz_currentGlobalZombies = count entities "zZombie_Base";
		
	//Animals
		[] spawn player_animalCheck;
		
		_timer = diag_tickTime;
	};
	
	if ((diag_tickTime - _timer1) > 60) then {
		_position = getPosATL player;
		_radius = 200;
		//Current amounts
		dayz_spawnZombies = {alive _x AND local _x} count (_position nearEntities ["zZombie_Base",_radius]);
		dayz_CurrentNearByZombies = {alive _x} count (_position nearEntities ["zZombie_Base",_radius]);
		dayz_currentWeaponHolders = count (_position nearObjects ["ReammoBox",(_radius - 100)]);
		
		_timer1 = diag_tickTime;
	};
	
	//spawning system
	if ((diag_tickTime - _spawnCheck) > 14) then {
		["both"] spawn player_spawnCheck;

		_spawnCheck  = diag_tickTime;
	};
	
	//Check if new day
	if ((diag_tickTime - _NewDay) > 5) then {
	
		_day = round(360 * (dateToNumber date));
		if(dayz_currentDay != _day) then {
			dayz_sunRise = call world_sunRise;
			dayz_currentDay = _day;
		};
		
		_NewDay  = diag_tickTime;
	};
		
	//wait
	//sleep 5;
};