class Citizen;
class Citizen1: Citizen {
	class SpeechVariants {
		class Default {
			speechplural[] = {""};
			speechsingular[] = {""};
		};
		class EN: Default {
			speechplural[] = {""};
			speechsingular[] = {""};
		};
		class CZ {
			speechplural[] = {""};
			speechsingular[] = {""};
		};
		class CZ_Akuzativ {
			speechplural[] = {""};
			speechsingular[] = {""};
		};
		class RU {
			speechplural[] = {""};
			speechsingular[] = {""};
		};
	};
};	
class Zed_Base : Citizen1 {
	scope = public;
	class HitDamage {};
};
class zZombie_Base : Zed_Base {
	scope = public;
	glassesEnabled = 0;
	vehicleClass = "Zombie";
	displayName = $STR_ZNAME_INFECTED;
	fsmDanger = "";
	fsmFormation = "";
	zombieLoot = "civilian";
	moves = "CfgMovesZombie";
	isMan = false;
	weapons[] = {};
	magazines[] = {};
	sensitivity = 2;	// sensor sensitivity
	sensitivityEar = 4;
	identityTypes[] = {"zombie1", "zombie2"};
	class TalkTopics {};
	languages[] = {};
	
	class Eventhandlers {
		init = "_this call zombie_initialize;";
		local = "if(_this select 1) then {[(position (_this select 0)),(_this select 0),true] execFSM '\z\AddOns\dayz_code\system\zombie_agent.fsm'};";
	};
	
	class HitPoints {
		class HitHead {
			armor = 0.3;
			material = -1;
			name = "head_hit";
			passThrough = true;
			memoryPoint = "pilot";
		};
		
		class HitBody : HitHead {
			armor = 2;
			name = "body";
			memoryPoint = "aimPoint";
		};
		
		class HitSpine : HitHead {
			armor = 2;
			name = "Spine2";
			memoryPoint = "aimPoint";
		};
		
		class HitHands : HitHead {
			armor = 0.5;
			material = -1;
			name = "hands";
			passThrough = true;
		};
		
		class HitLArm : HitHands {
			name = "LeftArm";
			memoryPoint = "lelbow";
		};
		
		class HitRArm : HitHands {
			name = "RightArm";
			memoryPoint = "relbow";
		};
		
		class HitLForeArm : HitHands {
			name = "LeftForeArm";
			memoryPoint = "lwrist";
		};
		
		class HitRForeArm : HitHands {
			name = "RightForeArm";
			memoryPoint = "rwrist";
		};
		
		class HitLHand : HitHands {
			name = "LeftHand";
			memoryPoint = "LeftHandMiddle1";
		};
		
		class HitRHand : HitHands {
			name = "RightHand";
			memoryPoint = "RightHandMiddle1";
		};
		
		class HitLegs : HitHands {
			name = "legs";
			memoryPoint = "pelvis";
		};
		
		class HitLLeg : HitHands {
			name = "LeftLeg";
			memoryPoint = "lknee";
		};
		
		class HitLLegUp : HitHands {
			name = "LeftUpLeg";
			memoryPoint = "lfemur";
		};
		
		class HitRLeg : HitHands {
			name = "RightLeg";
			memoryPoint = "rknee";
		};
		
		class HitRLegUp : HitHands {
			name = "RightUpLeg";
			memoryPoint = "rfemur";
		};
	};
};
class z_policeman : zZombie_Base {
	displayName = $STR_ZNAME_POLICEMAN;
	zombieLoot = "policeman";
};
class z_soldier : zZombie_Base {
	displayName = $STR_ZNAME_SOLDIER;
	zombieLoot = "military";
}; 
class z_soldier_heavy : z_soldier {
	displayName = $STR_ZNAME_SOLDIERHEAVY;
	zombieLoot = "military";
};
class z_soldier_pilot: z_soldier {
	displayName = $STR_ZNAME_PILOT;
	zombieLoot = "military";
};
class z_suit1 : zZombie_Base {
	displayName = $STR_ZNAME_SUIT;
	zombieLoot = "civilian";
}; 
class z_worker1 : zZombie_Base { 
	displayName = $STR_ZNAME_WORKER;
	zombieLoot = "Industrial";
}; 
class z_doctor : zZombie_Base { 
	displayName = $STR_ZNAME_DOCTOR;
	zombieLoot = "medical";
}; 
class z_teacher : z_doctor { 
	displayName = $STR_ZNAME_TEACHER;
	zombieLoot = "civilian";
}; 
class z_hunter : zZombie_Base { 
	displayName = $STR_ZNAME_HUNTER;
	zombieLoot = "hunter";
}; 
class z_priest : zZombie_Base { 
	displayName = $STR_ZNAME_PRIEST;
	zombieLoot = "Church";
}; 

class Swarm_Base : Zed_Base {
	scope = public;
	glassesEnabled = 0;
	vehicleClass = "Zombie";
	displayName = $STR_ZNAME_INFECTED;
	fsmDanger = "";
	fsmFormation = "";
	zombieLoot = "civilian";
	moves = "CfgMovesZombie";
	isMan = false;
	weapons[] = {};
	magazines[] = {};
	sensitivity = 1;	// sensor sensitivity
	sensitivityEar = 1;
	identityTypes[] = {"zombie1", "zombie2"};
	class TalkTopics {};
	languages[] = {};
	armor = 10;

	class Eventhandlers {
		init = "_this call zombie_initialize;";
		local = "if(_this select 1) then {[(position (_this select 0)),(_this select 0),true] execFSM '\z\AddOns\dayz_code\system\zombie_combatagent.fsm'};";
	};
	
	class HitPoints {
		class HitHead {
			armor = 0.3;
			material = -1;
			name = "head_hit";
			passThrough = true;
			memoryPoint = "pilot";
		};
		
		class HitBody : HitHead {
			armor = 2;
			name = "body";
			memoryPoint = "aimPoint";
		};
		
		class HitSpine : HitHead {
			armor = 2;
			name = "Spine2";
			memoryPoint = "aimPoint";
		};
		
		class HitHands : HitHead {
			armor = 0.5;
			material = -1;
			name = "hands";
			passThrough = true;
		};
		
		class HitLArm : HitHands {
			name = "LeftArm";
			memoryPoint = "lelbow";
		};
		
		class HitRArm : HitHands {
			name = "RightArm";
			memoryPoint = "relbow";
		};
		
		class HitLForeArm : HitHands {
			name = "LeftForeArm";
			memoryPoint = "lwrist";
		};
		
		class HitRForeArm : HitHands {
			name = "RightForeArm";
			memoryPoint = "rwrist";
		};
		
		class HitLHand : HitHands {
			name = "LeftHand";
			memoryPoint = "LeftHandMiddle1";
		};
		
		class HitRHand : HitHands {
			name = "RightHand";
			memoryPoint = "RightHandMiddle1";
		};
		
		class HitLegs : HitHands {
			name = "legs";
			memoryPoint = "pelvis";
		};
		
		class HitLLeg : HitHands {
			name = "LeftLeg";
			memoryPoint = "lknee";
		};
		
		class HitLLegUp : HitHands {
			name = "LeftUpLeg";
			memoryPoint = "lfemur";
		};
		
		class HitRLeg : HitHands {
			name = "RightLeg";
			memoryPoint = "rknee";
		};
		
		class HitRLegUp : HitHands {
			name = "RightUpLeg";
			memoryPoint = "rfemur";
		};
	};
};

class swarm_newBase : Swarm_Base {
	zombieLoot = "civilian";
	model = "\Ca\characters_E\Overall\Overall";
	hiddenSelections[] = {"Camo"};
	hiddenSelectionsTextures[] = {"\Ca\characters_E\Overall\Data\Overall_4_co.paa"};
		
	class Wounds {
		tex[] = {};
		mat[] = {"Ca\characters_E\Overall\Data\Overall.rvmat", "Ca\characters_E\Overall\Data\W1_Overall.rvmat", "Ca\characters_E\Overall\Data\W2_Overall.rvmat"};
	};
};