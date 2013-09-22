class ItemTent : CA_Magazine {
	scope = public;
	count = 1;
	type = (256 * 3);
	displayName = $STR_EQUIP_NAME_20;
	model = "\dayz_equip\models\tentbag_gear.p3d";
	picture = "\dayz_equip\textures\equip_tentbag_ca.paa";
	descriptionShort = $STR_EQUIP_DESC_20;

	class ItemActions {
		delete Pitch;
		class Build {
			text = $STR_PITCH_TENT;
			script = "spawn player_build; r_action_count = r_action_count + 1;";
			require = "";
			create = "TentStorage";
		};
	};
};

class ItemDomeTent : CA_Magazine {
	scope = public;
	count = 1;
	type = (256 * 3);
	displayName = $STR_EQUIP_NAME_20;
	model = "\dayz_equip\models\tentbag_gear.p3d";
	picture = "\dayz_equip\textures\equip_tentbag_ca.paa";
	descriptionShort = $STR_EQUIP_DESC_20;

	class ItemActions {
		class Build {
			text = $STR_PITCH_DOME_TENT;
			script = "spawn player_build; r_action_count = r_action_count + 1;";
			require = "";
			create = "DomeTentStorage";
		};
	};
};

class ItemSandbag : CA_Magazine {
	scope = public;
	count = 1;
	type = 256;
	displayName = $STR_EQUIP_NAME_21;
	model = "\dayz_equip\models\sandbags.p3d";
	picture = "\dayz_equip\textures\equip_sandbag_ca.paa";
	descriptionShort = $STR_EQUIP_DESC_21;

	class ItemActions {
		class Build {
			text = $STR_ACTION_BUILD;
			script = "spawn player_build; r_action_count = r_action_count + 1;";
			require = "ItemEtool";
			create = "Sandbag1_DZ";
		};
	};
};

class ItemTankTrap : CA_Magazine {
	scope = public;
	count = 1;
	type = 256;
	displayName = $STR_EQUIP_NAME_22;
	model = "\dayz_equip\models\tank_trap_kit.p3d";
	picture = "\dayz_equip\textures\equip_tanktrap_kit_CA.paa";
	descriptionShort = $STR_EQUIP_DESC_22;

	class ItemActions {
		class Build {
			text = $STR_ACTION_BUILD;
			script = "spawn player_build; r_action_count = r_action_count + 1;";
			require = "ItemToolbox";
			create = "Hedgehog_DZ";
		};
	};
};

class ItemWire : CA_Magazine {
	scope = public;
	count = 1;
	type = 256;
	displayName = $STR_EQUIP_NAME_23;
	model = "\dayz_equip\models\Fence_wire_kit.p3d";
	picture = "\dayz_equip\textures\equip_fencewire_kit_CA.paa";
	descriptionShort = $STR_EQUIP_DESC_23;

	class ItemActions {
		class Build {
			text = $STR_ACTION_BUILD;
			script = "spawn player_build; r_action_count = r_action_count + 1;";
			require = "ItemToolbox";
			create = "Wire_cat1";
		};
	};
};
//Land_CamoNet_EAST
class ItemCamoNet : CA_Magazine {
	scope = public;
	count = 1;
	type = (256 * 3);
	displayName = $STR_ITEM_NAME_CAMONET;
	model = "\dayz_equip\models\tentbag_gear.p3d";
	picture = "\dayz_equip\textures\equip_tentbag_ca.paa";
	descriptionShort = $STR_ITEM_DESC_CAMONET;
	tentmodel = CamoNet_DZ;

	class ItemActions {
		class Build {
			text = $STR_BUILD_CAMONET;
			script = "spawn player_build; r_action_count = r_action_count + 1;";
			require = "ItemToolbox";
			create = "CamoNet_DZ";
		};
	};
};

// traps
class TrapBear : CA_Magazine {
	scope = public;
	count = 1;
	type = 256;
	displayName = $STR_EQUIP_NAME_BEARTRAP;
	model = "\dayz_equip\models\bear_trap_gear.p3d";
	picture = "\dayz_equip\textures\equip_bear_trap_ca.paa";
	descriptionShort = $STR_EQUIP_DESC_BEARTRAP;

	class ItemActions {
		class Build {
			text = $STR_ACTION_BUILD;
			//script = "spawn player_setTrap; r_action_count = r_action_count + 1;";
			script = "spawn player_build; r_action_count = r_action_count + 1;";
			require = "ItemToolbox";
			create = "BearTrap_DZ";
		};
	};
};

class ItemTrapBearTrapFlare : CA_Magazine {
	scope = public;
	count = 1;
	type = 256;
	displayName = $STR_ITEM_NAME_BEAR_TRAP_FLARE;
	model = "z\addons\dayz_communityassets\models\trap_beartrap_dropped_flare.p3d";
	picture = "\z\addons\dayz_communityassets\pictures\equip_trap_beartrap_dropped_flare.paa";
	descriptionShort = $STR_ITEM_DESC_BEAR_TRAP_FLARE;

	class ItemActions {
		class Build {
			text = $STR_ACTION_BUILD;
			script = "spawn player_build; r_action_count = r_action_count + 1;";
			require = "ItemToolbox";
			create = "TrapBearTrapFlare";
		};
	};
};

class ItemTrapBearTrapSmoke : CA_Magazine {
	scope = public;
	count = 1;
	type = 256;
	displayName = $STR_ITEM_NAME_BEAR_TRAP_SMOKE;
	model = "z\addons\dayz_communityassets\models\trap_beartrap_dropped_smoke.p3d";
	picture = "\z\addons\dayz_communityassets\pictures\equip_trap_beartrap_dropped_smoke.paa";
	descriptionShort = $STR_ITEM_DESC_BEAR_TRAP_SMOKE;

	class ItemActions {
		class Build {
			text = $STR_ACTION_BUILD;
			script = "spawn player_build; r_action_count = r_action_count + 1;";
			require = "ItemToolbox";
			create = "TrapBearTrapSmoke";
		};
	};
};

class ItemTrapTripwireCans : CA_Magazine {
	scope = public;
	count = 1;
	type = 256;
	displayName = $STR_ITEM_NAME_TRIPWIRE_CANS;
	model = "z\addons\dayz_communityassets\models\trap_tripwire_dropped_can.p3d";
	picture = "\z\addons\dayz_communityassets\pictures\equip_trap_tripwire_can.paa";
	descriptionShort = $STR_ITEM_DESC_TRIPWIRE_CANS;

	class ItemActions {
		class Build {
			text = $STR_ACTION_BUILD;
			script = "spawn player_build; r_action_count = r_action_count + 1;";
			require = "ItemToolbox";
			create = "Trap_Cans";
		};
	};
};

class ItemTrapTripwireFlare : CA_Magazine {
	scope = public;
	count = 1;
	type = 256;
	displayName = $STR_ITEM_NAME_TRIPWIRE_FLARE;
	model = "z\addons\dayz_communityassets\models\trap_tripwire_dropped_flare.p3d";
	picture = "\z\addons\dayz_communityassets\pictures\equip_trap_tripwire_flare.paa";
	descriptionShort = $STR_ITEM_DESC_TRIPWIRE_FLARE;

	class ItemActions {
		class Build {
			text = $STR_ACTION_BUILD;
			script = "spawn player_build; r_action_count = r_action_count + 1;";
			require = "ItemToolbox";
			create = "TrapTripwireFlare";
		};
	};
};

class ItemTrapTripwireGrenade : CA_Magazine {
	scope = public;
	count = 1;
	type = 256;
	displayName = $STR_ITEM_NAME_TRIPWIRE_GRENADE;
	model = "z\addons\dayz_communityassets\models\trap_tripwire_dropped_grenade.p3d";
	picture = "\z\addons\dayz_communityassets\pictures\equip_trap_tripwire_grenade.paa";
	descriptionShort = $STR_ITEM_DESC_TRIPWIRE_GRENADE;

	class ItemActions {
		class Build {
			text = $STR_ACTION_BUILD;
			script = "spawn player_build; r_action_count = r_action_count + 1;";
			require = "ItemToolbox";
			create = "TrapTripwireGrenade";
		};
	};
};

class ItemTrapTripwireSmoke : CA_Magazine {
	scope = public;
	count = 1;
	type = 256;
	displayName = $STR_ITEM_NAME_TRIPWIRE_SMOKE;
	model = "z\addons\dayz_communityassets\models\trap_tripwire_dropped_smoke.p3d";
	picture = "\z\addons\dayz_communityassets\pictures\equip_trap_tripwire_smoke.paa";
	descriptionShort = $STR_ITEM_DESC_TRIPWIRE_SMOKE;

	class ItemActions {
		class Build {
			text = $STR_ACTION_BUILD;
			script = "spawn player_build; r_action_count = r_action_count + 1;";
			require = "ItemToolbox";
			create = "TrapTripwireSmoke";
		};
	};
};
