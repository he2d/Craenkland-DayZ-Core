class ItemHatchet : ItemCore {
		displayName = $STR_EQUIP_NAME_HATCHET;
		descriptionShort = $STR_EQUIP_DESC_HATCHET;
	
		class ItemActions {
			class Toolbelt {
				text = $STR_ACTIONS_RFROMTB;
			};
			class ToBack
			{
				text=$STR_ACTIONS_2BACK;
				script="spawn player_addtoBack;";
				use[]=
				{
					"ItemHatchet"
				};
				output[]=
				{
					"MeleeHatchet"
				};
			};
		};
	};