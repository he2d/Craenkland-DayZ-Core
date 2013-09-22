private["_object"];
_object = _this select 3;

//_position = [getPosATL _object,0,0,0,0,0,0,getPosATL player] call BIS_fnc_findSafePos;

//Standup
//player playMove "amovpercmstpsraswrfldnon_amovpknlmstpslowwrfldnon";
//sleep 1;
//waitUntil { animationState player != "amovpercmstpsraswrfldnon_amovpknlmstpslowwrfldnon"};

//Kneel Down
player playMove "amovpknlmstpslowwrfldnon_amovpercmstpsraswrfldnon";
waitUntil { animationState player != "amovpknlmstpslowwrfldnon_amovpercmstpsraswrfldnon"};

//_object setpos _position;
_object setvectorup [0,0,1];
[player,"scream",0,true] call dayz_zombieSpeak;
[player,20,true,(getPosATL player)] call player_alertZombies;

//Other possibilities
//[_object,0, 0] call bis_fnc_setpitchbank;
//_object setpos [getpos _object select 0, getpos _object select 1, 0];