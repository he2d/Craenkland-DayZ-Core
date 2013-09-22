class SVD_CAMO_DZ: SVD_CAMO {
	displayName = $STR_EQUIP_NAME_SVD_CAMO;
	descriptionShort = $STR_EQUIP_DESC_SVD_CAMO;
	model = "\ca\weapons\SVD_CAMO";
	dexterity = 1.57;
	picture = "\CA\weapons\data\equip\W_SVD_camo_CA.paa";
	class Single_Sniper: Single {
		displayName = "$STR_DN_MODE_SEMIAUTO";
		dispersion = 0.00045;
		reloadTime = 0.5;
	};
	modes[] = {"Single_Sniper"};
};
