//Medical Event Handlers
"PVDZ_drg_RaLW"   		addPublicVariableEventHandler {[_this select 1] execVM "\z\addons\dayz_code\medical\publicEH\load_wounded.sqf"};
"PVDZ_drg_RLact"		addPublicVariableEventHandler {[_this select 1] execVM "\z\addons\dayz_code\medical\load\load_wounded.sqf"};
//"norrnRDead"   		addPublicVariableEventHandler {[_this select 1] execVM "\z\addons\dayz_code\medical\publicEH\deadState.sqf"};
"PVDZ_hlt_Bleed"			addPublicVariableEventHandler {_id = (_this select 1) spawn fnc_usec_damageBleed};
//"usecInject"		addPublicVariableEventHandler {(_this select 1) call player_medInject};
//"dayzHit" 			addPublicVariableEventHandler {(_this select 1) call fnc_usec_damageHandler};
"PVCDZ_veh_SH" 		addPublicVariableEventHandler {(_this select 1) call fnc_veh_handleDam}; // set damage to vehicle part
"PVDZ_veh_SF"		addPublicVariableEventHandler {(_this select 1) call fnc_veh_handleRepair}; // repair a part from a vehicle
"PVCDZ_obj_HideBody"		addPublicVariableEventHandler {hideBody (_this select 1)};
"PVCDZ_obj_GutBody"		addPublicVariableEventHandler {(_this select 1) spawn local_gutObject};
//Moved from isserver
"PVCDZ_veh_SetFuel"		addPublicVariableEventHandler {(_this select 1) spawn local_setFuel};
//"dayzDelLocal"		addPublicVariableEventHandler {(_this select 1) call object_delLocal};
//"dayzVehicleInit"	addPublicVariableEventHandler {(_this select 1) call fnc_vehicleEventHandler};
//"dayz_serverObjectMonitor"		addPublicVariableEventHandler {dayz_serverObjectMonitor = dayz_safety};
"dayzInfectedCamps"		addPublicVariableEventHandler {(_this select 1) spawn infectedcamps};

	"PVDZ_Server_changeOwner" addPublicVariableEventHandler {
		//["agent","reciever"]
		//diag_log ("Starting Ownership system");
		
		_agent = ((_this select 1) select 0);
		_reciever = ((_this select 1) select 1);
				
		//Get owners
		_ownerID = owner _agent;
		_newownerID = 1; //1 = server

		//Get new owner
		if (typeName _reciever == "OBJECT") then {
			_newownerID = owner _reciever;
		};
				
		//Log owners
		//diag_log format ["Agent: %1, Player: %2",_agent,_reciever];
		//diag_log format ["Original Owner: %1, New Owner: %2",_ownerID,_newownerID];
		
		//Save original owner
		if (isnil ("Owner")) then {
			_agent setVariable ["Owner",_ownerID];
		};
		
		_agent setOwner _newownerID;
		diag_log ("TRANSFER OWNERSHIP: " + (typeOf _agent) + " OF _unit: " + str(_agent) + " TO _client: " + str(_reciever) );
	};
	
		
	"PVDZ_Server_Simulation" addPublicVariableEventHandler {
		_agent = ((_this select 1) select 0);
		_control = ((_this select 1) select 1);
		
		_agent enableSimulation _control;
	};

//Both

//Server only
if (isServer) then {
	"PVDZ_plr_Death"			addPublicVariableEventHandler {_id = (_this select 1) spawn server_playerDied};
	//"PVDZ_plr_Discorem"		addPublicVariableEventHandler {dayz_disco = dayz_disco - [(_this select 1)];};
	"PVDZ_plr_Save"	addPublicVariableEventHandler {_id = (_this select 1) call server_playerSync;};
	"PVDZ_obj_Publish"	addPublicVariableEventHandler {(_this select 1) call server_publishObj};
	"PVDZ_veh_Save" addPublicVariableEventHandler {(_this select 1) call server_updateObject};
	"PVDZ_plr_Login1"			addPublicVariableEventHandler {_id = (_this select 1) call server_playerLogin};
	"PVDZ_plr_Login2"		addPublicVariableEventHandler {(_this select 1) call server_playerSetup};
	//"dayzPlayerMorph"	addPublicVariableEventHandler {(_this select 1) call server_playerMorph};
	//"dayzUpdate"		addPublicVariableEventHandler {_id = (_this select 1) spawn dayz_processUpdate};
	"PVDZ_plr_LoginRecord"	addPublicVariableEventHandler {_id = (_this select 1) spawn dayz_recordLogin};
	//"dayzCharSave"		addPublicVariableEventHandler {_id = (_this select 1) call server_playerSync};
	"PVDZ_obj_Delete"		addPublicVariableEventHandler {(_this select 1) spawn server_deleteObj};

	"PVDZ_send" addPublicVariableEventHandler {(_this select 1) spawn server_sendToClient};
	
	"PVDZ_objgather_Delete" addPublicVariableEventHandler {
		_obj = ((_this select 1) select 0);
		_player = ((_this select 1) select 1);
		_type = typeOf _obj;
		_dis = _player distance _obj;
		
		if (_dis < 3) then {
			if (_type in Dayz_plants) then {
				deleteVehicle _obj;
			};
		};	
	};
	
	"PVDZ_serverStoreVar" addPublicVariableEventHandler {
		_obj = ((_this select 1) select 0);
		_name = ((_this select 1) select 1);
		_value = 0;
		
		switch _name do {
			//[_x,"looted",_dateNow];
			case "looted": {
				_obj = ((_this select 1) select 0);
				_name = "looted";
				_value = (DateToNumber date);
			};
			//[_x,"zombieSpawn",_dateNow]
			case "zombieSpawn": {
				_obj = ((_this select 1) select 0);
				_name = "zombieSpawn";
				_value = (DateToNumber date);
				//diag_log format ["%4 - %1, %2, %3", _obj, _name, _value, "Store zombieSpawn"];
			};
		};

			_obj setVariable [_name, _value];

	};
	
	"PVDZ_receiveVar" addPublicVariableEventHandler {
		_owner = ((_this select 1) select 0);
		_object = ((_this select 1) select 1);
		_name = ((_this select 1) select 2);
		_value = ((_this select 1) select 3);
			
		switch _name do {
			case "looted": {
				//diag_log format ["%4 - %1, %2, %3", _object, _name, _value, "receive looted"]; 
			};
			case "zombieSpawn": {
				//diag_log format ["%4 - %1, %2, %3", _object, _name, _value, "receive zombieSpawn"]; 
			};
		};
		
		_ownerID = owner _owner;
		_return = _object getVariable [_name,_value];
		
		a=0;
		b=5;
		while {a<b} do {a=a+1};
		
		//diag_log format ["%1", _return];	
		
		PVCDZ_SetVar = [_object,_name,_return];
		_ownerID publicVariableClient "PVCDZ_SetVar";
	};
};

//Client only
if (!isDedicated) then {
	"dayzSetDate"		addPublicVariableEventHandler {setDate (_this select 1)};
	"PVDZ_obj_RoadFlare"		addPublicVariableEventHandler {(_this select 1) spawn object_roadFlare};
	"PVDZ_drg_RaDrag"   	addPublicVariableEventHandler {(_this select 1) execVM "\z\addons\dayz_code\medical\publicEH\animDrag.sqf"};
	"PVDZ_obj_Fire"			addPublicVariableEventHandler {nul=(_this select 1) spawn BIS_Effects_Burn};

	"PVCDZ_plr_Humanity"		addPublicVariableEventHandler {(_this select 1) spawn player_humanityChange};
	"PVCDZ_plr_Legs"		addPublicVariableEventHandler {
		_entity = (_this select 1) select 0;
		_entity setHit ["legs", 1];

		if (isPlayer _entity) then {
			_entity setVariable ["hit_legs", 2, true];
		};
	};

	//Medical
	"PVCDZ_hlt_Morphine"		addPublicVariableEventHandler {(_this select 1) call player_medMorphine};
	"PVCDZ_hlt_Bandage"		addPublicVariableEventHandler {(_this select 1) call player_medBandage};
	"PVCDZ_hlt_Epi"			addPublicVariableEventHandler {(_this select 1) call player_medEpi};
	"PVCDZ_hlt_Transfuse"		addPublicVariableEventHandler {(_this select 1) call player_medTransfuse; PVCDZ_hlt_Transfuse = nil};
	"PVCDZ_hlt_PainK"			addPublicVariableEventHandler {(_this select 1) call player_medPainkiller};
	"PVCDZ_hlt_AntiB"			addPublicVariableEventHandler {(_this select 1) call player_medAntiBiotics};
	
	"PVCDZ_SetVar" addPublicVariableEventHandler {
		_object = ((_this select 1) select 0);
		_name = ((_this select 1) select 1);
		_value = ((_this select 1) select 2);
		
		//diag_log format ["%4 - %1, %2, %3", _object, _name, _value, "PVCDZ_SetVar"]; 
		_object setVariable [_name,_value];
	};
};
