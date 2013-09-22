class Blueprint_Trap_Cans : Recipe {
	displayName = $STR_ITEM_NAME_TRIPWIRE_CANS;
	descriptionShort = $STR_ITEM_DESC_TRIPWIRE_CANS;
	input[] = 
	{
		{"equip_string","CfgMagazines",1},
		{"PartWoodPile","CfgMagazines",1},
		{"TrashTinCan","CfgMagazines",1}
	};
	output[] = 
	{
		{"ItemTrapTripwireCans","CfgMagazines",1}
	};
	required[] = 
	{
		{"ItemToolbox","CfgWeapons",1}
	};
};
