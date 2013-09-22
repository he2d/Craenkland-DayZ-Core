class Land_A_tent;
class StashSmall : Land_A_tent {
	armor = 5;
	displayname = $STR_VEH_NAME_STASH;
	icon = "\Ca\misc3\data\Icons\icon_Atent_ca.paa";
	mapsize = 3;
	model = "\z\addons\dayz_communityassets\models\dirt_stash.p3d";
	scope = 2;
	vehicleClass = "Survival";
	transportMaxMagazines = 12;
	transportMaxWeapons = 0;
	transportMaxBackpacks = 0;
};

//class House;
class StashMedium : Land_A_tent {
	armor = 50;
	displayname = $STR_VEH_NAME_STASH_MED;
	icon = "\Ca\misc3\data\Icons\icon_Atent_ca.paa";
	mapsize = 3;
	model = "\z\addons\dayz_communityassets\models\dirt_stash_reinforced.p3d";
	scope = 2;
	vehicleClass = "Survival";
	transportMaxMagazines = 25;
	transportMaxWeapons = 1;
	transportMaxBackpacks = 0;
};

class DomeTentStorage : Land_A_tent {
	displayname = $STR_VEH_NAME_DOME_TENT;
	icon = "\Ca\buildings\Icons\i_Astan_CA.paa";
	mapsize = 3;
	model = "\ca\buildings\Tents\astan";
	armor = 10;
	destrtype = "DestructTent";
	vehicleClass = "Survival";
	transportMaxMagazines = 35;
	transportMaxWeapons = 15;
	transportMaxBackpacks = 0;
};