#define VSoft				0
#define VArmor				1
#define VAir				2
#define private				0
#define protected			1
#define public				2
#define ReadAndWrite		0
#define ReadAndCreate		1
#define ReadOnly			2
#define ReadOnlyVerified	3
#define EAST 				0 // (Russian)

class CfgPatches {
	class dayz_code {
		units[] = {};
		weapons[] = {};
		requiredVersion = 0.1;
		requiredAddons[] = {"dayz_equip","dayz_weapons","CAMisc3","CABuildingParts","CABuildingParts_Signs","CAStructuresHouse","CAStructuresLand_Ind_Stack_Big","CAStructures_Misc_Powerlines","CAStructures","CABuildings","CABuildings2","Ind_MalyKomin","CAStructures_A_CraneCon","CAStructures_Mil","CAStructures_Nav","CAStructures_Rail","A_Crane_02","A_TVTower","CAStructures_Railway","CAStructuresHouse_HouseBT"};
	};
};

class CfgMods {
	class DayZ {
		dir = "DayZ";
		name = "DayZ";
		picture = "z\addons\dayz_code\gui\mod.paa";
		hidePicture = 0;
		hideName = 0;
		action = "http://www.dayzmod.com";
		version = "1.8";
		hiveVersion = 0.96;
		requiredAddons[] = {"Chernarus"};
	};
};

class CfgAddons {
	access = 1;
	class PreloadBanks {};
	class PreloadAddons	{
		class dayz {
			list[] = {"dayz_code","dayz","dayz_equip","dayz_communityassets","dayz_weapons","dayz_sfx","ST_bunnyhop","st_collision","st_evasive"};
		};
	};
};

#include "Configs\basicDefines.hpp"

#include "Configs\rscTitles.hpp"
#include "Configs\CfgWorlds.hpp"
#include "Configs\CfgMoves.hpp"
#include "Configs\CfgVehicles.hpp"
#include "Configs\CfgWeapons.hpp"
#include "Configs\CfgCrafting\CfgCrafting.hpp"
#include "Configs\CfgMagazines.hpp"
#include "Configs\CfgLoot\CfgBuildingLoot.hpp"
#include "Configs\CfgMarkers.hpp"
#include "Configs\CfgAmmo.hpp"
#include "Configs\CfgObjectCompositions.hpp"
#include "Configs\CfgTownGenerator\CfgTownGeneratorChernarus.hpp"
#include "Configs\CfgFaces.hpp"
#include "Configs\CfgGlasses.hpp"
#include "Configs\CfgArma.hpp"
