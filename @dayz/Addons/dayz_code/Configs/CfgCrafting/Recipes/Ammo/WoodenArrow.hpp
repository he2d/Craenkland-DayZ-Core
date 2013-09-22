class Wooden_Arrow : Recipe {
	displayName = $STR_ITEMWOODENARROW_CODE_NAME;
	input[] = 
	{
		{"PartWoodPile","CfgWeapons",2},
		{"ItemTrashRazor","CfgMagazines",2},
		{"equip_feathers","CfgMagazines",4}
	};
	output[] = 
	{
		{"WoodenArrow","CfgWeapons",4}
	};
	required[] = 
	{
		{"ItemToolbox","CfgWeapons",1}
	};
};